package mlab;

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
    public static  int param3; // Level_UAM
    public static  int param4; // NStep_Z
    public static  int param5; // T1 ceramic delay
    public static  int param6; // T2 integrator delay
    public static  int param7; // Z
    public static  int param8; // VERT
    public static  int flgonestep;   //not used
    public static  int flgTopPos;   //control top position flag
    public static  int flgendscript; //1 endscript; 2 - not ;

    public static final int endscript=1;
    public static final int steps=2;
    public static final int waitsteps=3;
    public static final int stop=4;
    public static final int ok=5;
    public static final int touch=6;

// chanels ID
	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;
	public static final int CH_RES_OUT     = 2;
	public static final int CH_NSTEPS      = 3;
        public static final int CH_SET_POINT   = 4;
        public static final int CH_GATE_Z_MAX  = 5;
        public static final int CH_GATE_Z_MIN  = 6;
        public static final int CH_SIGNAL_LEVEL= 7;
        public static final int CH_INTDELAY    = 8;
        public static final int CH_SCANNERDECAY= 9;

	public static final int  MakeSTOP =   1;
    

public static void main()
{ 
    int TIMER,s,T1,T2,count,dlt,NCurPos;
    int SMZ_STEP,SIGNAL,LEVEL_SGL,Z;
    int [] debugZ, debugSteps, debugStatus;
    int cntZ, cntSteps;
      
       int[] datain; 
       
        datain=Simple.xchgGet("algoritmparams.bin");

        SET_POINT   = datain[0]; //<<
        GATE_Z_MAX  = datain[1]; //<<
        GATE_Z_MIN  = datain[2]; //<< 
        SIGNAL_LEVEL= datain[3]; //<< 
	NSTEPS      = datain[4]; //<<
        INTDELAY    = datain[5];
        SCANNERDECAY= datain[6];    


    JVIO stream_stop =     new JVIO(CH_STOP, 1, 1,JVIO.BUF, 1, 0);                       // 0
    JVIO stream_drawdone = new JVIO(DRAWDONE, 1, 1,JVIO.BUF, 1, 0);                      // 1 
    JVIO stream_res_out =  new JVIO(RES_OUT, 2, FREQ_STEPS,JVIO.FIFO, FREQ_STEPS-25, 25);// 2
    JVIO stream_CH_PARAMS = new JVIO(CH_PARAMS, 1, 1,JVIO.BUF, 1, 0);
/*
    JVIO stream_CH_SET_POINT = new JVIO(CH_SET_POINT, 1, 1,JVIO.BUF, 1, 0);              // 3 add on PC
    JVIO stream_CH_GATE_Z_MAX = new JVIO(CH_GATE_Z_MIN, 1, 1,JVIO.BUF, 1, 0);            // 4 add on PC
    JVIO stream_CH_GATE_Z_MIN = new JVIO(CH_INTDELAY, 1, 1,JVIO.BUF, 1, 0);              // 5 add on PC
    JVIO stream_CH_SIGNAL_LEVEL  = new JVIO(CH_SIGNAL_LAVEL, 1, 1,JVIO.BUF, 1, 0);       // 6 add on PC
    JVIO stream_CH_NSTEPS = new JVIO(CH_NSTEPS, 1, 1,JVIO.BUF, 1, 0);                    // 7 add on PC
    JVIO stream_CH_INTDELAY  = new JVIO(DRAWDONE, 1, 1,JVIO.BUF, 1, 0);                  // 8 add on PC
    JVIO stream_CH_SCANNERDECAY  = new JVIO(CH_SCANNERDECAY, 1, 1,JVIO.BUF, 1, 0);       // 9 add on PC
*/

 
                int[] buf_STOP;
                buf_STOP = new int[1];
                buf_STOP[0] =0;
                wr = stream_stop.Write(buf_STOP, 1, 1000);
                int[] buf_DRAWDONE;
		buf_DRAWDONE=new int[1];
                buf_DRAWDONE[0]=0;
                wr = stream_drawdone.Write(buf_DRAWDONE, 1, 1000);
                int[] buf_NSTEPS;
		buf_NSTEPS=new int[1];
                buf_NSTEPS[0]=0;
    
    //        all var  in array

                for i=0;i<;i++;

               wr = stream_CH_NSTEPS.Write(buf_NSTEPS, 1, 1000);
                int[] buf_SET_POINT;
		buf_SET_POINT=new int[1];
                buf_SET_POINT[0]=0;
                wr = stream_CH_SET_POINT.Write(buf_SET_POINT, 1, 1000);
	        int[] buf_GATE_Z_MAX;
		buf_GATE_Z_MAX=new int[1];
                buf_GATE_Z_MAX[0]=0;
                wr = stream_CH_GATE_Z_MAX.Write(buf_GATE_Z_MAX, 1, 1000);
                int[] buf_GATE_Z_MIN;
		buf_GATE_Z_MIN=new int[1];
                buf_GATE_Z_MIN[0]=0;
                wr = stream_CH_GATE_Z_MIN.Write(buf_GATE_Z_MIN, 1, 1000);          
                int[] buf_INTDELAY;
		buf_INTDELAY=new int[1];
                buf_INTDELAY[0]=0;
                wr = stream_CH_INTDELAY.Write(buf_INTDELAY, 1, 1000);
                int[] buf_SCANNERDECAY;
		buf_SCANNERDECAY=new int[1];
                buf_SCANNERDECAY[0]=0;
                wr = stream_CH_SCANNERDECAY.Write(buf_SCANNERDECAY, 1, 1000);


	 param0=0;  //0
         flgendscript=2;//active
         status=steps;
	 param3=(Simple.bramRead(M_A_rez)>>4)*12;
         LEVEL_SGL=param3;
//       param1=1717986918;//(int)(0x80000000*0.8);
//	 param2=644245094;//(int)(0x80000000*0.3);
         param5=10;
	 param6=100;
         NCurPos=Simple.bramRead(M_smZ_status);
         param4=65536*3;  //3<<16  //step
         T2=param6;
         T1=param5;
         Simple.bramWrite(M_BASE_K, BASE_K);
         cntZ = 0;
         cntSteps = 0;
         debugStatus = new int[50];
// while ( true ) if (buf_STOP[0] == MakeSTOP)
// {         if (status==stop){status=endscript; flgendscript=1; break;}    //exit init; 100
                       //approch
                 debugStatus[7] = 0x1;
               while ( 1==1 )
             	 {
                        Simple.bramWrite(M_PID_ON,0x80000000); // pull ahead tip
                        Simple.Sleep(INTDELAY); // T2 ms
                        param0=0;
                 	Z=(int)Simple.bramRead(M_PID_out);
                        param7=Z;
                        dlt=param4;
                        debugStatus[0] = status;
                        debugStatus[1] = ZNoInteraction_0_3;
                        debugStatus[2] = Z;
                        debugStatus[3] = ZTooClose0_3;
                  ///   SIGNAL=(int)Simple.bramRead(M_A);//ADC_UAM;

                        if (dlt>0){if (Z > 0) {
                                               if (Z >= ZTooClose0_3)
			                       {
                                                param0=2; status=touch;  flgendscript=1;
                                                break;
                                               }
			                      }
	         }  ///?????? what is this
                       // Too Close  stop script        //        NStep_Z=1
                    if (dlt > 0)
                      {
			   count=0;

                             ////  debugStatus[5] = SIGNAL;
                               // if (SIGNAL <= LEVEL_SGL)
                                 {
                                   if (Z >= 0) { count = count+1;status=ok;}
                                   else if (Z >= ZNoInteraction_0_3)    {count=count+1; status=15;}  //O'K
                                   else {status = 10;}
                                  };

                            if (count > 0)
                             {
			      param0=3;  flgendscript=1;   //O'K   stop script
			      break;
                             }
         		    
                       }     //dlt, param4>0

	                Simple.bramWrite(M_PID_ON,0); // pull back;
	                 
                        Simple.Sleep(300);      // T1 ms
                        cntSteps = cntSteps+1;
                        SMZ_STEP=param4+NCurPos;
                        Simple.bramWrite(M_smZ_ctrl,SMZ_STEP);
                        while(Simple.bramRead(M_smZ_status)== SMZ_STEP);
                        Simple.Sleep(300);
                     
                         NCurPos = SMZ_STEP;//Simple.bramRead(M_smZ_status);
                    }  //steps
       debugStatus[0] = status;
       Simple.xchgCreate("status.dat",debugStatus);
       Simple.Sleep(500);
   		     			     
   //  Simple.xchgCreate("steps.dat", debugSteps);
   //  Simple.xchgCreate("Z.dat", debugZ); 
   //   Simple.Sleep(500);
  
// flgendscript=1;
}   //main
    //       
} //class approach   


