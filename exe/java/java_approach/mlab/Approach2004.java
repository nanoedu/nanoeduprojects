package mlab; //200411

public class Approach
{
 public static final int M_DFI_PIN = 7;
 public static final int M_A = 3;
 public static final int M_A_rez = 4;
 public static final int M_BASE_K= 5;
 public static final int M_PID_ON = 10;
 public static final int M_smZ_ctrl=13;
 public static final int M_smZ_status=14;
 public static final int M_PID_out=20;

// public static final  int  ZNoInteraction_0_3 = 0xD97F5980;   //(int)(0x80000000L*(-0.3));
// public static final  int  ZTooClose0_3= 0x2680A680;  //  (int)(0x80000000L*(0.3));
/// public static final int ZNoInteraction_0_3  = (int)((0x80000000L ) * (-0.3));
// public static final  int ZTooClose0_3  = (int)((0x80000000L ) * (0.3));
// public static final  int SET_POINT=(int)((0x80000000L>>2) *3); 

    public static  int status; // control script parameter
    public static  int param0; // FlgStepResult
/*    public static  int param3; // Level_UAM
    public static  int param4; // NStep_Z
    public static  int param5; // T1 ceramic delay
    public static  int param6; // T2 integrator delay
    public static  int param7; // Z
    public static  int param8; // VERT
    public static  int flgonestep;   //not used
    public static  int flgTopPos;   //control top position flag
*/
    public static  int flgendscript; //1 endscript; 2 - not ;

    public static final int endscript=1;
    public static final int steps=50;
    public static final int waitsteps=0;
    public static final int stop=100;
    public static final int none=0;

    public static final int ok=3;
    public static final int touch=2; 
    public static final int outlimit=4;
    public static final int MakeSTOP =   1;

// chanels ID
	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;
	public static final int CH_APR_OUT     = 2;
        public static final int CH_PARAMS      = 3;

/*	public static final int CH_NSTEPS      = 3;
        public static final int CH_SET_POINT   = 4;
        public static final int CH_GATE_Z_MAX  = 5;
        public static final int CH_GATE_Z_MIN  = 6;
        public static final int CH_SIGNAL_LEVEL= 7;
        public static final int CH_INTDELAY    = 8;
        public static final int CH_SCANNERDECAY= 9;
        public static final int CH_ONESTEP    = 10;
*/
	
    

public static void main()
{ 
    int rd,wr,count,CurPosStepMotor;
    int SMZ_STEP,SIGNAL,LEVEL_SGL,Z;
    int [] debugZ, debugSteps, debugStatus;
    int SET_POINT,GATE_Z_MAX,GATE_Z_MIN,SIGNAL_LEVEL,NSTEPS;      
    int INTDELAY,SCANNERDECAY,FLGONESTEP;  
    int process;

    JVIO stream_stop =      new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
    JVIO stream_drawdone =  new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1 
    JVIO stream_apr_out =   new JVIO(CH_APR_OUT, 3, 1,JVIO.FIFO, 3, 0);                        // 2
    JVIO stream_ch_params = new JVIO(CH_PARAMS,  7, 1,JVIO.BUF,  7, 0);                        // 3 

 //   int cntZ, cntSteps;
      
       int[] datain; 
       
        datain=Simple.xchgGet("algoritmparams.bin");

        SET_POINT   = datain[0]; //<<
        GATE_Z_MAX  = datain[1]; //<<
        GATE_Z_MIN  = datain[2]; //<< 
        SIGNAL_LEVEL= datain[3]; //<< 
	NSTEPS      = datain[4]; //<<
        INTDELAY    = datain[5];
        SCANNERDECAY= datain[6];    
  //      FLGONESTEP  = datain[7]; 


   

 /*
    JVIO stream_CH_SET_POINT = new JVIO(CH_SET_POINT, 1, 1,JVIO.BUF, 1, 0);              // 3 add on PC
    JVIO stream_CH_GATE_Z_MAX = new JVIO(CH_GATE_Z_MIN, 1, 1,JVIO.BUF, 1, 0);            // 4 add on PC
    JVIO stream_CH_GATE_Z_MIN = new JVIO(CH_INTDELAY, 1, 1,JVIO.BUF, 1, 0);              // 5 add on PC
    JVIO stream_CH_SIGNAL_LEVEL  = new JVIO(CH_SIGNAL_LAVEL, 1, 1,JVIO.BUF, 1, 0);       // 6 add on PC
    JVIO stream_CH_NSTEPS = new JVIO(CH_NSTEPS, 1, 1,JVIO.BUF, 1, 0);                    // 7 add on PC
    JVIO stream_CH_INTDELAY  = new JVIO(DRAWDONE, 1, 1,JVIO.BUF, 1, 0);                  // 8 add on PC
    JVIO stream_CH_SCANNERDECAY  = new JVIO(CH_SCANNERDECAY, 1, 1,JVIO.BUF, 1, 0);       // 9 add on PC
*/

/*
     Simple.DumpInt(SET_POINT);
     Simple.DumpInt(GATE_Z_MAX);
     Simple.DumpInt(GATE_Z_MIN); 
     Simple.DumpInt(SIGNAL_LEVEL); 
     Simple.DumpInt(NSTEPS);
     Simple.DumpInt(INTDELAY); 
     Simple.DumpInt(SCANNERDECAY);

     Simple.Sleep(10000);
*/
                int[] buf_STOP;
                buf_STOP = new int[1];
                buf_STOP[0] =0;
                wr = stream_stop.Write(buf_STOP, 1, 1000);
                int[] buf_DRAWDONE;
		buf_DRAWDONE=new int[1];
//              buf_DRAWDONE[0]=0;
//              wr = stream_drawdone.Write(buf_DRAWDONE, 1, 1000);
                int[] buf_PARAMS;
		buf_PARAMS=new int[7];
                for(int i=0; i<7; i++) buf_PARAMS[i]=datain[i];
              
                wr = stream_ch_params.Write(buf_PARAMS, 1, 1000);
                int[] buf_status;
		buf_status= new int[3];
		buf_status[0]=none;

    //        all var  in array

   //           for(int i=0; i<FREQ_STEPS; i++)



	  Simple.bramWrite(M_BASE_K, SET_POINT); 

          CurPosStepMotor=Simple.bramRead(M_smZ_status);        

	Z=0;
	SIGNAL=0;

	 process=none;  // stop
         status=none;

// while ( true ) if (buf_STOP[0] == MakeSTOP)
// {         if (status==stop){status=endscript; flgendscript=1; break;}    //exit init; 100
// approch



               while (buf_STOP[0] != MakeSTOP )
             	 {
                       stream_stop.Read(buf_STOP, 1,500,true);
                        if (buf_STOP[0] == MakeSTOP)
                                {  
                                   break;
                                }
		
                    
               //   read buffers params  
         
                   rd = stream_ch_params.Read(buf_PARAMS, 1,1000,true);
                   
             
                  SET_POINT   = buf_PARAMS[0]; //<<
                  GATE_Z_MAX  = buf_PARAMS[1]; //<<
                  GATE_Z_MIN  = buf_PARAMS[2]; //<< 
                  SIGNAL_LEVEL= buf_PARAMS[3]; //<< 
                  NSTEPS      = buf_PARAMS[4]; 
                  INTDELAY    = buf_PARAMS[5];
                  SCANNERDECAY= buf_PARAMS[6]; 

                     if (NSTEPS>=0)
	   		 {             
                          Simple.bramWrite(M_PID_ON,0x80000000); // pull ahead tip
                          Simple.Sleep(INTDELAY); // T2 ms
                          param0=steps;		
                 	  Z=(int)Simple.bramRead(M_PID_out);

                          SIGNAL=(int)Simple.bramRead(M_A);//ADC_UAM;
                 
			  if (Z >= GATE_Z_MIN)
			    {
                              param0=stop;
                              buf_status[0]=touch; 
                              buf_status[1]=Z;
                              buf_status[2]=SIGNAL;
                              break;
                       	    }
		     		
                        //  if (SIGNAL <=SIGNAL_LEVEL)
                           {  
			      if (Z>=GATE_Z_MAX)
			       { count=0;
				 for(int i=0; i<20; i++) 
				 {
				   Z=(int)Simple.bramRead(M_PID_out);
				  if (Z>=GATE_Z_MAX) {  count = count+1;}
				   Simple.Sleep(100);
                                  };
                                if (count > 10)
                                {
			         param0=stop; 
				 buf_status[0]=ok; 
				 buf_status[1]=Z;
                                 buf_status[2]=SIGNAL;
                                // flgendscript=1;//O'K   stop script
			         break;
                                }
			       }//z>	                     
         		   } 
                        }     //NSTEPS>0
                       if (NSTEPS<0)
                        { // test  top over limit 
                       	  Z=(int)Simple.bramRead(M_PID_out);

                          SIGNAL=(int)Simple.bramRead(M_A);//ADC_UAM;
    
		        }	                        
      			 Simple.bramWrite(M_PID_ON,0); // pull back;
			
 			 Simple.Sleep(SCANNERDECAY); 
            
                         SMZ_STEP=NSTEPS+CurPosStepMotor;
 
                         Simple.bramWrite(M_smZ_ctrl,SMZ_STEP);

                         while(Simple.bramRead(M_smZ_status)== SMZ_STEP);

                         Simple.Sleep(SCANNERDECAY);		
                     
                         CurPosStepMotor = SMZ_STEP;

			 buf_status[0]=steps;
			 buf_status[1]=Z;
                         buf_status[2]=SIGNAL;
                        
 
                         wr = stream_apr_out.Write(buf_status,1,1000);



                    }  // while steps

	               
                    
                       wr = stream_apr_out.Write(buf_status,1,1000);

                       wr = stream_drawdone.Read(buf_DRAWDONE, 1,10000,false);

            
                       stream_ch_params.Close();
                       stream_apr_out.Close();          
                       stream_stop.Close();
  	               stream_drawdone.Close();

                       Simple.xchgCreate("status.dat",buf_status);

 /*      debugStatus[0] = status;
       Simple.xchgCreate("status.dat",debugStatus);
       Simple.Sleep(500);
*/
        		     			     
   //  Simple.xchgCreate("steps.dat", debugSteps);
   //  Simple.xchgCreate("Z.dat", debugZ); 
   //   Simple.Sleep(500);
  
}   //main
    //       
} //class approach   


