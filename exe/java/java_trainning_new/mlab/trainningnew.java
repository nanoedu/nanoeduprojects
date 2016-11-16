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

       public static int Zmove( int Z, int ndiscr, int st1, int delay )   // st1 = +-1
	{
	  int j,k;
  	  int cZ;
		cZ = Z;
		for (j=0; j< ndiscr; j++)
		{
		cZ=cZ+(st1 << 16 );

		for(k=0; k < delay; k++)
                {}  // задержка в каждом дискрете
             //       Simple.bramRead(M_USTEP);

		Simple.bramWrite(M_DACZ, cZ);

		}
	  return(cZ);
	}
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
           	datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

              	NCycle             =  datain[i0];
                INTDELAY           =  datain[i0+1];
                SCANNERDECAY       =  datain[i0+2];
                STMFLG             =  datain[i0+3];
                MicrostepDelay     =  datain[i0+4];
                DiscrNumInMicroStep=  datain[i0+5];

           for (i=0;i<9; i++)  { Simple.DumpInt(datain[i]); }

       		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
       		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,1,NCycle,JVIO.BUF,1, 0); // 2

  		int[] buf_stop;
		buf_stop = new int[1];
		buf_stop[0] =0;
		wr = stream_ch_stop.Write(buf_stop, 1, 1000);
		stream_ch_stop.Invalidate();

		int[] buf_drawdone;
		buf_drawdone = new int[1];
		buf_drawdone[0] =0;
	      	wr=0;
		for (;  wr == 0; )
		{
	          wr = stream_ch_drawdone.Write(buf_drawdone, 1, 300);
		}
             	stream_ch_drawdone.Invalidate();

                      	dacX0 =Simple.bramRead(M_DACX) ;
	             	dacY0 =Simple.bramRead(M_DACY) ;
	         	dacZ0 =0;

                        dacX=dacX0;
                        dacY=dacY0;
                        dacZ=dacZ0;
                        Simple.bramWrite( M_DACZ,0);

   //                   Simple.DumpInt(dacZ);
   //                   Simple.DumpInt(dacX);
   //                   Simple.DumpInt(dacY);

                uV0=Simple.bramRead( M_USTEP);

                ZuV0=Simple.bramRead( M_ZUSTEP);

                uVector = (2 * DiscrNumInMicroStep/MicrostepDelay);

              	Simple.bramWrite( M_USTEP, uVector );

               	ZuVector = (2 * DiscrNumInMicroStep/MicrostepDelay);         // jump 100

             	Simple.bramWrite( M_ZUSTEP, ZuVector );

                 Simple.fcupBypass(0,true);                //turn off

    //             Simple.bramWrite(M_PID_ON,00000000);           // pull back;

	        Simple.Sleep(SCANNERDECAY);

//  Simple.DumpInt(0xAAAAAAAA);
//  Simple.DumpInt(NCycle);
//  Simple.DumpInt(DiscrNumInMicroStep);
//  Simple.DumpInt(MicrostepDelay);
//  Simple.DumpInt(0xAAAAAAAA);
                                            int j,k;
  	  int cZ;

               for (i=0 ;  i<NCycle ; i++)
               {
  //                      Simple.DumpInt(0xBBBBBBBB);
  //                      Simple.DumpInt(i);
                     	rd=0;
			for (;  rd == 0; )
			{
				rd=stream_ch_stop.Read(buf_stop, 1,300,true);
			}

			if (buf_stop[0] == MakeSTOP)
			{
			   	break;
			}

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
                
                        dacX =DAC_MIN; dacY=DAC_MIN; //dacz
                      	dxchg.Goto( dacX,dacY,dacZ);
                     	dacX =DAC_MAX;  dacY=DAC_MAX;    //dacz
                        dxchg.Goto(dacX,dacY,dacZ);
                        dacX =DAC_MIN  ;  dacY=DAC_MIN;
                     	dxchg.Goto( dacX,dacY,dacZ);
                     	dacX =DAC_MAX;    dacY=DAC_MAX;
                        dxchg.Goto(dacX,dacY,dacZ);
                       	dacX =DAC_MIN;   dacY=DAC_MIN;
                        dxchg.Goto(dacX,dacY,dacZ);
          
                        dxchg.GetI( PORT_H   );
                        dxchg.ExecuteScan();
                        dxchg.WaitScanComplete( -1 );
             //           Simple.DumpInt(0xBBBBBBBB);
	                arr = dxchg.GetResults();

                      	wr=0;
			for (;  wr == 0; )
			{
                          wr= stream_ch_data_out.Write(arr,1, 1000);
			}
                      	stream_ch_data_out.Invalidate();

              }
	     	// n
//                        Simple.DumpInt(0xCCCCCCCC);
                     	dxchg = new Dxchg();
                	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               PORT_Z,PORT_COS_Z, dacZ} );
                          //goto start position

                        dxchg.Goto(dacX0,dacY0,dacZ0);
                        dxchg.ExecuteScan();
                        dxchg.WaitScanComplete( -1 );

            //    	Simple.Sleep(1000);

                       	Simple.bramWrite( M_USTEP, uV0 );
                       	Simple.bramWrite( M_ZUSTEP, ZuV0);
           //             Simple.DumpInt(0xAAAAAAAA);

                        Simple.fcupBypass(0,false);

                 if (STMFLG==1) {   Simple.bramWrite(M_PID_ON,0x40000000);} // pull ahead tip STM
                  else          {   Simple.bramWrite(M_PID_ON,0x80000000);} // pull ahead tip SFM

                Simple.Sleep(INTDELAY);

                Simple.Sleep(1000);

            	buf_drawdone[0]=done;
		wr=0;
		for (;  wr == 0; )
		{
	          wr = stream_ch_drawdone.Write(buf_drawdone, 1, 300);
		}
                stream_ch_drawdone.Invalidate();
                  Simple.DumpInt(0xCCCCCCCC);
		rd=0;
		int ccnt = 0;
                for(;(buf_stop[0]!=stop) ;)
                {
                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);
                  ccnt+=1;
                }

       		stream_ch_drawdone.Close();
		stream_ch_stop.Close();
                stream_ch_data_out.Close();
	}
}

















