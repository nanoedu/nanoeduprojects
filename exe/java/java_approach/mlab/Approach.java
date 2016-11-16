package mlab; //261012

public class Approach
{
 public static  int M_DFI_PIN;
 public static  int M_A ;
 public static  int M_A_rez;
 public static  int M_BASE_K;
 public static  int M_PID_ON;
 public static  int M_smZ_ctrl;
 public static  int M_smZ_status;
 public static  int M_PID_out;
 public static  int M_I_BASE;         //?????
 public static  int M_I;
 public static  int M_sm_speed;

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
	public static final int CH_DATA_OUT    = 2;
        public static final int CH_PARAMS      = 3;
        public static final int CH_STEPS       = 1;




public static void main(String[] arg)
{
    int rd,wr,count,CurPosStepMotor;
    int SMZ_STEP,SIGNAL,LEVEL_SGL,Z;
    int [] debugZ, debugSteps, debugStatus;
    int SET_POINT,GATE_Z_MAX,GATE_Z_MIN,SIGNAL_LEVEL,NSTEPS,STMFLG,SPEED;
    int INTDELAY,SCANNERDECAY,FLGONESTEP;
    int process;
    int i;

       M_A=Simple.bramID("m_A");
       M_PID_ON=Simple.bramID("m_pid_On");
       M_BASE_K=Simple.bramID("m_BaseK");
       M_I_BASE=Simple.bramID("m_I_BASE");
       M_I=Simple.bramID("m_ADC_I");
       M_PID_out=Simple.bramID("m_pid_out");
       M_smZ_status=Simple.bramID("m_smZ_status");
       M_smZ_ctrl=Simple.bramID("m_smZ_ctrl");
       M_sm_speed=Simple.bramID("speed");

    JVIO stream_ch_stop      = new JVIO(CH_STOP      ,1, 1,JVIO.BUF,  1, 0); 			// 0
    JVIO stream_ch_steps     = new JVIO(CH_STEPS     ,1, 1,JVIO.BUF,  1, 0);                    // 4
    JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT  ,3, 1,JVIO.BUF,  1, 0);                    // 2
    JVIO stream_ch_params    = new JVIO(CH_PARAMS    ,9, 1,JVIO.BUF,  1, 0);   //020212                 // 3

        int[] datain;

        datain=Simple.xchgGet("algoritmparams.bin");

        int i0=4;

        SET_POINT   = datain[i0]; //<<
        GATE_Z_MAX  = datain[i0+1]; //<<
        GATE_Z_MIN  = datain[i0+2]; //<<
        SIGNAL_LEVEL= datain[i0+3]; //<<
	NSTEPS      = datain[i0+4]; //<<
        INTDELAY    = datain[i0+5];
        SCANNERDECAY= datain[i0+6];
        STMFLG      = datain[i0+7];
        SPEED       = datain[i0+8];

                int[] buf_step;
                buf_step = new int[1];
                buf_step[0] =waitsteps;
                wr = stream_ch_steps.Write(buf_step, 1, 1000);

                int[] buf_DRAWDONE;
         	buf_DRAWDONE=new int[1];

                int[] buf_params;
		buf_params=new int[9];
                for(i=0; i<9; i++) buf_params[i]=datain[i+i0];
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



  //	  Simple.bramWrite(M_BASE_K, SET_POINT);

          if (STMFLG==1) {   Simple.bramWrite(M_I_BASE, SET_POINT);} //  STM
          else           {   Simple.bramWrite(M_BASE_K, SET_POINT);}  //  SFM

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

// Simple.DumpInt(0);
//  main cycle

                for (; buf_stop[0] != MakeSTOP;)
             	 {
                     rd=stream_ch_stop.Read(buf_stop, 1,300,true);
2
                        if (buf_stop[0] == MakeSTOP)
                            {
				buf_status[0]=stopdone;
				buf_step[0]=done;
                                break;
                            }

                     rd=0;
                     rd = stream_ch_steps.Read(buf_step, 1, 1000,true);

		  if ( buf_step[0]==steps)
                  {
                   //   read buffers params
			rd=0;
                     for (;  rd == 0; )
			{
			 rd = stream_ch_params.Read(buf_params, 1,200,true);
			}
                     SET_POINT   = buf_params[0]; //<<     used setuserparams
                     GATE_Z_MAX  = buf_params[1]; //<<
                     GATE_Z_MIN  = buf_params[2]; //<<
                     SIGNAL_LEVEL= buf_params[3]; //<<
                     NSTEPS      = buf_params[4]; //<<
                     INTDELAY    = buf_params[5];
                     SCANNERDECAY= buf_params[6];
                     STMFLG      = buf_params[7];
                     SPEED       = buf_params[8];

                     Simple.bramWrite(M_sm_speed,SPEED);

    //                 Simple.bramWrite(M_BASE_K, SET_POINT);

                  if (STMFLG==1) {   Simple.bramWrite(M_I_BASE, SET_POINT);} //  STM       ????????
                  else           {   Simple.bramWrite(M_BASE_K, SET_POINT);}  //  SFM      ????????


                  if (STMFLG==1) {   Simple.bramWrite(M_PID_ON,0x40000000);} // pull ahead tip    STM
                  else           {   Simple.bramWrite(M_PID_ON,0x80000000);} // pull ahead tip   SFM

		   Simple.Sleep(INTDELAY);                //  ms


                      if (NSTEPS>=0)
	   		 {

                 	  Z=(int)Simple.bramRead(M_PID_out);

                           if (STMFLG==1) {   SIGNAL=Simple.bramRead(M_I);} //  STM
                            else          {   SIGNAL=Simple.bramRead(M_A);};  //  SFM

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

                      //    SIGNAL=(int)Simple.bramRead(M_A); //ADC_UAM;

                           if (STMFLG==1) {   SIGNAL=Simple.bramRead(M_I);} //  STM
                            else          {   SIGNAL=Simple.bramRead(M_A);};  //  SFM


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
        			wr=0;
			    for (;  wr == 0; )
			    {
                              wr = stream_ch_steps.Write(buf_step,1,1000);
		            }
			  stream_ch_steps.Invalidate();

                    }  // if steps

                   if ( buf_status[0]!=none)  break;  //stop

                  }// not stop

                         	wr=0;
			   for (;  wr == 0; )
			    {
                              wr = stream_ch_data_out.Write(buf_status,1,1000);
		            }

			 stream_ch_data_out.Invalidate();

                //       Simple.bramWrite(M_PID_ON,0x80000000); // pull ahead tip
                         if (STMFLG==1) {   Simple.bramWrite(M_PID_ON,0x40000000);} // pull ahead tip    STM
                         else           {   Simple.bramWrite(M_PID_ON,0x80000000);}; // pull ahead tip   SFM

		         Simple.Sleep(INTDELAY);                //  ms

// Simple.DumpInt(4);


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

                       stream_ch_params.Close();
               //      stream_ch_drawdone.Close();
                       stream_ch_data_out.Close();
                       stream_ch_stop.Close();
                       stream_ch_steps.Close();


}   //main
    //
} //class approach   


