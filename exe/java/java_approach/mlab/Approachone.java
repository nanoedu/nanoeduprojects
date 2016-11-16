package mlab; //121211

public class ApproachOne
{
 public static final int M_DFI_PIN = 7;
 public static final int M_A = 3;
 public static final int M_A_rez = 4;
 public static final int M_BASE_K= 5;
 public static final int M_PID_ON = 10;
 public static final int M_smZ_ctrl=13;
 public static final int M_smZ_status=14;
 public static final int M_PID_out=20;



    public static final int steps=50;
    public static final int done=60;
    public static final int waitsteps=40;//0
    public static final int none=30;     //0
    public static final int stop=100;

    public static final int ok=          3;
    public static final int touch=       2; 
    public static final int outlimit=    4;
    public static final int MakeSTOP =   1;
    public static final int stopdone =   5;

// chanels ID
	public static final int CH_STOP        = 0;
//	public static final int CH_DRAWDONE    = 1;
	public static final int CH_DATA_OUT    = 2;
        public static final int CH_PARAMS      = 3;
        public static final int CH_STEPS       = 1;

	
    

public static void main()
{ 
    int rd,wr,count,CurPosStepMotor;
    int SMZ_STEP,SIGNAL,LEVEL_SGL,Z;
    int [] debugZ, debugSteps, debugStatus;
    int SET_POINT,GATE_Z_MAX,GATE_Z_MIN,SIGNAL_LEVEL,NSTEPS;      
    int INTDELAY,SCANNERDECAY,FLGONESTEP;  
    int process;
    int i;

    JVIO stream_ch_stop      = new JVIO(CH_STOP      ,1, 1,JVIO.BUF,  1, 0); 			// 0
    JVIO stream_ch_steps     = new JVIO(CH_STEPS     ,1, 1,JVIO.BUF,  1, 0);                    // 4
 // JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE  ,1, 1,JVIO.BUF,  1, 0);                    // 1
    JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT  ,3, 1,JVIO.BUF,  1, 0);                    // 2
    JVIO stream_ch_params    = new JVIO(CH_PARAMS    ,7, 1,JVIO.BUF,  1, 0);                    // 3
                       //1                  		          
  
        int[] datain;

        datain=Simple.xchgGet("algoritmparams.bin");

        SET_POINT   = datain[0]; //<<
        GATE_Z_MAX  = datain[1]; //<<
        GATE_Z_MIN  = datain[2]; //<<
        SIGNAL_LEVEL= datain[3]; //<<
	NSTEPS      = datain[4]; //<<
        INTDELAY    = datain[5];
        SCANNERDECAY= datain[6];

  //    FLGONESTEP  = datain[7];

                int[] buf_step;
                buf_step = new int[1];
                buf_step[0] =waitsteps;
                wr = stream_ch_steps.Write(buf_step, 1, 1000);
             
                int[] buf_DRAWDONE;
         	buf_DRAWDONE=new int[1];

                int[] buf_params;
		buf_params=new int[7];
                for(i=0; i<7; i++) buf_params[i]=datain[i];             
                 wr=0;
                for (;  wr == 0; )
		{
                 wr = stream_ch_params.Write(buf_params, 1, 1000);
		}
                int[] buf_status;
		buf_status= new int[3];
		buf_status[0]=none;
	        buf_status[1]=(int)Simple.bramRead(M_PID_out);
                buf_status[2]=(int)Simple.bramRead(M_A);      //ADC_UAM;



	  Simple.bramWrite(M_BASE_K, SET_POINT); 

          CurPosStepMotor=Simple.bramRead(M_smZ_status);

        	Z=0;
	    SIGNAL=0;

                int[] buf_stop;
                buf_stop = new int[1];
                buf_stop[0] =waitsteps;
                     wr=0;
                for (;  wr == 0; )
		{
                  wr = stream_ch_stop.Write(buf_stop, 1, 1000); 	
	        }
 Simple.DumpInt(0);
                
///  main cycle
	
                for (; buf_stop[0] != MakeSTOP;)
             	 {
                     //    rd=0;
                     //   for (;  rd == 0; )
     		    //      {
 Simple.DumpInt(1);
                            rd=stream_ch_stop.Read(buf_stop, 1,300,true); 
	             //     }
 
		 
                        if (buf_stop[0] == MakeSTOP)
                            { 
                                  // Simple.bramWrite(M_PID_ON,0x80000000); // pull ahead tip
                                  // Simple.Sleep(INTDELAY);  

				buf_status[0]=stopdone;

				buf_step[0]=done;
 Simple.DumpInt(5);

                                break;
                            }

                           rd=0;
                     //   for (;  rd == 0; )
     		          {
 Simple.DumpInt(2);
				  rd = stream_ch_steps.Read(buf_step, 1, 1000,true);
			  }
			             


/*
 Simple.DumpInt(1);
 Simple.DumpInt(buf_STEP[0]);
 Simple.DumpInt(steps);
*/

		  if ( buf_step[0]==steps)
                  {
                   //   read buffers params
			rd=0;
		   for (;  rd == 0; )
			{
			 rd = stream_ch_params.Read(buf_params, 1,200,true);
 Simple.DumpInt(3);
			}
                  
             
                     SET_POINT   = buf_params[0]; //<<
                     GATE_Z_MAX  = buf_params[1]; //<<
                     GATE_Z_MIN  = buf_params[2]; //<<
                     SIGNAL_LEVEL= buf_params[3]; //<<
                     NSTEPS      = buf_params[4]; //<<
                     INTDELAY    = buf_params[5];
                     SCANNERDECAY= buf_params[6];

                     Simple.bramWrite(M_BASE_K, SET_POINT); 


for (i=0;i<7;i++)
{ Simple.DumpInt(buf_params[i]);} 

                         Simple.bramWrite(M_PID_ON,0x80000000); // pull ahead tip
                        
			  Simple.Sleep(INTDELAY);                //  ms
      

                      if (NSTEPS>=0)
	   		 {
                      
                 	  Z=(int)Simple.bramRead(M_PID_out);

                          SIGNAL=(int)Simple.bramRead(M_A);      //ADC_UAM;

			  if (Z >= GATE_Z_MIN)
			    {
                              buf_step[0]=done;

                              buf_status[0]=touch;
                              buf_status[1]=Z;
                              buf_status[2]=SIGNAL;
				wr=0;
			   for (;  wr == 0; )
			    {
                              wr = stream_ch_data_out.Write(buf_status,1,1000);	
		            }	     
    			      stream_ch_data_out.Invalidate();
		             //too close!
                              break;
                       	    }

                        //  if (SIGNAL <=SIGNAL_LEVEL)
                           {
			      if (Z>=GATE_Z_MAX)
			       { count=0;
				 for(i=0; i<20; i++)
				 {
				   Z=(int)Simple.bramRead(M_PID_out);
				   if (Z>=GATE_Z_MAX) {  count = count+1;}
				   Simple.Sleep(100);
                                  };
                                if (count > 10)
                                {
			         buf_step[0]=done;

				 buf_status[0]=ok;
				 buf_status[1]=Z;
                                 buf_status[2]=SIGNAL;
                                	wr=0;
			         for (;  wr == 0; )
			         {
                                   wr = stream_ch_data_out.Write(buf_status,1,1000);	
		                  }	
				 stream_ch_data_out.Invalidate();
                                //O'K   stop script
			         break;
                                }//ok
			       }//z>
         		   }
                        }     //NSTEPS>0
                       if (NSTEPS<0)
                        { // test  top over limit
                       	  Z=(int)Simple.bramRead(M_PID_out);

                          SIGNAL=(int)Simple.bramRead(M_A); //ADC_UAM;

		        }
      			 Simple.bramWrite(M_PID_ON,0);      // pull back;

 			 Simple.Sleep(SCANNERDECAY);

                         SMZ_STEP=NSTEPS+CurPosStepMotor;

                         Simple.bramWrite(M_smZ_ctrl,SMZ_STEP);

			  wr=0;

			 for (;  wr == 0; )
			 {if (Simple.bramRead(M_smZ_status)== SMZ_STEP){wr=1;}}
                         
                         CurPosStepMotor = SMZ_STEP;

			 buf_status[0]=none;
			 buf_status[1]=Z;
                         buf_status[2]=SIGNAL;
				
			 buf_step[0]=done;

                       		wr=0;
			   for (;  wr == 0; )
			    {
                              wr = stream_ch_data_out.Write(buf_status,1,1000);	
		            }
                          stream_ch_data_out.Invalidate();	
//  Simple.DumpInt(wr);
				wr=0;
			    for (;  wr == 0; )
			    {
                              wr = stream_ch_steps.Write(buf_step,1,1000);	
		            }
			  stream_ch_steps.Invalidate();
			
                        
//  Simple.DumpInt(wr);
			
			 

                    }  // if steps

                   if ( buf_status[0]!=none)  break;  //stop 

                  }// not stop

                         	wr=0;
			   for (;  wr == 0; )
			    {
                              wr = stream_ch_data_out.Write(buf_status,1,1000);	
		            }
                        
			 stream_ch_data_out.Invalidate();	

                         Simple.bramWrite(M_PID_ON,0x80000000); // pull ahead tip
                        
		         Simple.Sleep(INTDELAY);                //  ms
                 
 Simple.DumpInt(4);


				wr=0;
			   for (;  wr == 0; )
			    {
                              wr = stream_ch_steps.Write(buf_step,1,1000);	
		            }	
     
                         buf_stop[0]=0;
		rd=0; 
                for( i=0;buf_stop[0]!=stop;i++) 
   	        { 
             //    rd = stream_ch_drawdone.Read(buf_DRAWDONE, 1,10000,false);   
		   rd = stream_ch_stop.Read(buf_stop, 1,10000,false);    
		}
//   Simple.DumpInt(6);            
               
//  Simple.Sleep(1000); //need to disconnect channels on PC   2000


                       stream_ch_params.Close();
               //      stream_ch_drawdone.Close();
                       stream_ch_data_out.Close();          
                       stream_ch_stop.Close();
                       stream_ch_steps.Close();
// Simple.DumpInt(10);
// Simple.Sleep(500);    //1000

  
}   //main
    //       
} //class approach   


