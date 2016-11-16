package mlab; //220113

public class movetonew
{
//	static int X_POINTS = 50;
//	static int Y_POINTS = 50;
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
	static  int USTEP_DLY= 400;

	static final int M_BASE_K = 5;

	static final int M_USTEP = 21;
        static  int M_DACX;
        static  int M_DACY;


	static final int PORT_COS_X = ( 3 );
	static final int PORT_COS_Y = ( 4 );
	static final int PORT_COS_Z = ( 5 );

	static final int PORT_X = ( 0 );
	static final int PORT_Y = ( 1 );
	static final int PORT_Z = ( 2 );

	static final int PORT_H = ( 2 );


        // chanels ID

	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;

        public static final int done=60;

        public static final int stop=100;

	public static final int MakeSTOP =1;

      	public static final int move =200;

	public static void main(String[] arg)
	{
		int[] arr;
		int i;
		int src_i;
		int dst_i;
		int[] datain;
		int handle;
		int point;
		int d_step;
		int d_step_N;
		int x_cos;
		int y_cos;
		int lines;
		int scanIndx;
		int x_dir;
		int dacX;
		int dacY;
		int dacZ;
		int uVector;
                int wr,rd;
                int[] res;
		int  ScanPath;
		int  SZ;
		int  ScanMethod;
		int  MicrostepDelay =100;
		int  MicrostepDelayBW;
		int  DiscrNumInMicroStep;
		int  XMicrostepNmb;
		int  YMicrostepNmb;
                int Timewait;
		int  X_begin =100;
		int  Y_begin =100;
                   //new
              	Dxchg dxchg;

                M_DACX   = Simple.bramID("dxchg_X");
                M_DACY   = Simple.bramID("dxchg_Y");

       		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1

  		int[] buf_stop;
		buf_stop = new int[1];
		buf_stop[0] =0;
		wr = stream_ch_stop.Write(buf_stop, 1, 1000);
		stream_ch_stop.Invalidate();

		int[] buf_drawdone;
		buf_drawdone = new int[1];
		buf_drawdone[0] =move;
	      	wr=0;
		for (;  wr == 0; )
		{
	          wr = stream_ch_drawdone.Write(buf_drawdone, 1, 300);
		}
//                	wr = stream_ch_drawdone.Write(buf_drawdone, 1, 1000);
             	stream_ch_drawdone.Invalidate();


		datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

		X_begin         =    datain[i0];
        	Y_begin         =    datain[i0+1];
		MicrostepDelay  =    datain[i0+2];
                DiscrNumInMicroStep= datain[i0+3]<<16;   //210113  add
                Timewait           = datain[i0+4];

             if (MicrostepDelay!=0) { 	USTEP_DLY =  MicrostepDelay;}         //210113
             else
             { USTEP_DLY=1;};

         //       if (X_begin==0) {X_begin=1;}
         //       if (Y_begin==0) {Y_begin=1;}

                X_begin = X_begin * DAC_STEP;
                Y_begin = Y_begin * DAC_STEP;
               	dacX =Simple.bramRead(M_DACX) ;
                dacX=dacX>>16;
                dacX=dacX<<16;
           	dacY =Simple.bramRead(M_DACY) ;
                dacY=dacY>>16;
                dacY=dacY<<16;
        	dacZ =0;
              	Simple.DumpInt(0xCCCCCCCC);
                Simple.DumpInt(MicrostepDelay);
                Simple.DumpInt(X_begin);
                Simple.DumpInt(dacX);
                Simple.DumpInt(Y_begin);
                Simple.DumpInt(dacY);
                Simple.DumpInt(DiscrNumInMicroStep);
            //      int dx,dy;
            //    dx=Simple.abs(dacX-X_begin);
            //    dy=Simple.abs(dacY-Y_begin);
            //    int d=dx+dy;
            //  Timewait=(dx/DiscrNumInMicroStep+dy/DiscrNumInMicroStep) * USTEP_DLY;

 		uVector = (2 * DiscrNumInMicroStep / USTEP_DLY);

            //  Simple.DumpInt(d);
            //    Simple.DumpInt(uVector);
            //    Simple.DumpInt(Timewait);
            //    Simple.DumpInt(0xCCCCCCCC);

              	Simple.bramWrite( M_USTEP, uVector );

               if ((dacX!=X_begin)|(dacY!=Y_begin))
               {
                     	dxchg = new Dxchg();
                 	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               -1,-1,-1}
                                          );
         	        dacX =  X_begin;
                      	dxchg.Goto( dacX,dacY,0);
                     	dacY =  Y_begin;
                        dxchg.Goto(dacX,dacY,0);
	     	// run
             	dxchg.ExecuteScan();
                dxchg.WaitScanComplete(Timewait+10000);
	        res = dxchg.GetResults();
              }

              // 	Simple.DumpInt(0xAAAAAAAA);
              //  Simple.DumpInt(done);
               // Simple.DumpInt(0xAAAAAAAA);
       		buf_drawdone[0]=done;

		wr=0;
		for (;  wr == 0; )
		{
	          wr = stream_ch_drawdone.Write(buf_drawdone, 1, 300);
		}
                stream_ch_drawdone.Invalidate();

		Simple.Sleep(1000);
              //	Simple.DumpInt(0xBBBBBBBB);
              //  Simple.DumpInt(done);
              //  Simple.DumpInt(0xBBBBBBBB);
     		rd=0;
		int ccnt = 0;
                for(;(buf_stop[0]!=stop) ;)
                {
                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);
                  ccnt+=1;
                }
       		stream_ch_drawdone.Close();
		stream_ch_stop.Close();

	}

}

















