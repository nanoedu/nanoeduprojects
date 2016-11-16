package mlab; //290813

public class trainningnew
{
//	static int X_POINTS = 50;
//	static int Y_POINTS = 50;
	static final int DAC_MAX = 0x7FFFFFFF;
	static final int DAC_MIN = 0x80000000;
       	static final int DACZ_MAX = 0x7FFFFFFF;   //28.08.13 !!!!!
	static final int DACZ_MIN = 0x80000000;

        static  int M_DACX;
        static  int M_DACY;
       	static  int M_DACZ;
        static  int M_PID_ON;
        static  int M_USTEP;
      	static  int M_ZUSTEP;

	static final int PORT_COS_X = ( Port.OUT | 3 );
	static final int PORT_COS_Y = ( Port.OUT | 4 );
	static final int PORT_COS_Z = ( Port.OUT | 5 );

	static final int PORT_X = ( Port.OUT | 0 );
	static final int PORT_Y = ( Port.OUT | 1 );
	static final int PORT_Z = ( Port.OUT | 2 );

	static final int PORT_uVector = ( Port.OUT | 6 );

	static final int PORT_H = (Port.IN | 2 );


        // chanels ID

	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;
    	public static final int CH_DATA_OUT    = 2;

        public static final int done=60;

        public static final int stop=100;

       	public static final int MakeSTOP =1;

  	public static void main(String[] arg)
	{
		int[] arr;
		int i;
		int[] datain;
		int  dacX,dacX0;
		int  dacY,dacY0;
		int  dacZ,dacZ0;
		int  uVector,ZuVector;
                int  uV0,ZuV0;
                int  s,wr,rd;
                int  NCycle;
		int  MicrostepDelay =100;
		int  DiscrNumInMicroStep;
          	int  INTDELAY;
                int  SCANNERDECAY;
                int  STMFLG;
                int  ZStep;
                       //new
              	Dxchg dxchg;

                M_USTEP  = Simple.bramID("m_ustep");
                M_ZUSTEP = Simple.bramID("m_Z_ustep");
                M_PID_ON=Simple.bramID("m_pid_On");
                M_DACX   = Simple.bramID("dxchg_X");
                M_DACY   = Simple.bramID("dxchg_Y");
                //
                M_DACZ   = Simple.bramID("m_dacZ");

                      	dacX0 =Simple.bramRead(M_DACX) ;
	             	dacY0 =Simple.bramRead(M_DACY) ;
	         	dacZ0 =0;

                        dacX=dacX0;
                        dacY=dacY0;
                        dacZ=dacZ0;
                        Simple.bramWrite( M_DACZ,0);

                 uV0=Simple.bramRead( M_USTEP);

                ZuV0=Simple.bramRead( M_ZUSTEP);

                uVector =0x00008000;

              	Simple.bramWrite( M_USTEP, uVector );

               	ZuVector =0x00008000;         // jump 100

             	Simple.bramWrite( M_ZUSTEP, ZuVector );

                 Simple.fcupBypass(0,true);                //turn off

    //             Simple.bramWrite(M_PID_ON,00000000);           // pull back;

               for (i=0 ;  i<10 ; i++)
               {
                       	dxchg = new Dxchg();
                	dxchg.SetScanPorts( new int[]
                                               {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               PORT_Z,PORT_COS_Z, dacZ} );


                       	dxchg.Goto( dacX,dacY,0);
                         dacZ=DACZ_MIN;
                      	dxchg.Goto( dacX,dacY,dacZ);
                     	  dacZ=DACZ_MAX;
                        dxchg.Goto(dacX,dacY,dacZ);
                          dacZ=DACZ_MIN;
                     	dxchg.Goto( dacX,dacY,dacZ);
                     	   dacZ=DACZ_MAX;
                        dxchg.Goto(dacX,dacY,dacZ);
                       	   dacZ=DACZ_MIN;
                        dxchg.Goto(dacX,dacY,dacZ);
                        dxchg.Goto( dacX,dacY,0);
                        dxchg.ExecuteScan();
                        dxchg.WaitScanComplete( -1 );

              }
	}
}

















