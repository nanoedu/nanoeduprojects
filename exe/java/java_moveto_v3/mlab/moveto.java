package mlab; //261012

public class moveto
{
//	static int X_POINTS = 50;
//	static int Y_POINTS = 50;
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
	static  int USTEP_DLY= 400;

	static final int M_BASE_K = 5;

	static final int M_USTEP = 21;

	static final int PORT_COS_X = ( Port.OUT | 3 );
	static final int PORT_COS_Y = ( Port.OUT | 4 );
	static final int PORT_COS_Z = ( Port.OUT | 5 );

	static final int PORT_X = ( Port.OUT | 0 );
	static final int PORT_Y = ( Port.OUT | 1 );
	static final int PORT_Z = ( Port.OUT | 2 );

	static final int PORT_uVector = ( Port.OUT | 6 );

	static final int PORT_H = ( Port.IN | 2 );

        // chanels ID

	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;

        public static final int done=60;

        public static final int stop=100;

	public static final int MakeSTOP =1;

	public static void main(String[] arg)
	{
		int[] arr;
		int i;
		int src_i;
		int dst_i;
		int[] datain;
		Port[] port;
		Span[] span_x_y_z;
		Span[] span_h;
		Span[] span_uVect;
		Scene scene;
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

		int  ScanPath;
		int  SZ;
		int  ScanMethod;
		int  MicrostepDelay =100;
		int  MicrostepDelayBW;
		int  DiscrNumInMicroStep;
		int  XMicrostepNmb;
		int  YMicrostepNmb;
		int  X_begin =100;
		int  Y_begin =100;

       		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1

  		int[] buf_stop;
		buf_stop = new int[1];
		buf_stop[0] =0;
		wr = stream_ch_stop.Write(buf_stop, 1, 1000);
		stream_ch_stop.Invalidate();

		int[] buf_drawdone;
		buf_drawdone = new int[1];
		buf_drawdone[0] =0;
		wr = stream_ch_drawdone.Write(buf_drawdone, 1, 1000);
             	stream_ch_drawdone.Invalidate();


		datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

		X_begin         =    datain[i0];
        	Y_begin         =    datain[i0+1];
		MicrostepDelay  =    datain[i0+2];

              	USTEP_DLY =  MicrostepDelay;

                if (X_begin==0) {X_begin=1;}
                if (Y_begin==0) {Y_begin=1;}
                X_begin = X_begin * DAC_STEP;
                Y_begin = Y_begin * DAC_STEP;
		span_x_y_z = new Span[] { new Span(2), new Span(1) };
		span_h     = new Span[] { new Span(2), new Span(1), new Span(400) };

		port = new Port[] { new Port(PORT_COS_X,   span_x_y_z),
		                    new Port(PORT_COS_Y,   span_x_y_z),
		                    new Port(PORT_X,       span_x_y_z),
		                    new Port(PORT_Y,       span_x_y_z),
		                    new Port(PORT_H,       span_h) };

		scene = new Scene( port );
		for(handle=0;handle==0;)
		{
			handle = scene.createScene( scene.getTemplate(), 2 );
			if ( 0 == handle ) scene.releaseScene(0);
		}

		dacX = 0xFFFF0000 & scene.getPort( PORT_X );
		dacY = 0xFFFF0000 & scene.getPort( PORT_Y );
		dacZ = 0xFFFF0000 & scene.getPort( PORT_Z );

 		uVector = (2 * 0x00010000 / USTEP_DLY);

		Simple.bramWrite( M_USTEP, uVector );

                scene.setScanPorts( handle, new int[] {PORT_X,PORT_COS_X,
		                                       PORT_Y,PORT_COS_Y,
		                                               0,0} );

		        dacX =  X_begin;
			scene.addPoint( handle, dacX, dacY, 0 );
			dacY =  Y_begin;
                        scene.addPoint( handle, dacX, dacY, 0 );

			// run
        		scene.run( handle );
			scene.wait( handle, -1 );



		scene.releaseScene( handle );

       		buf_drawdone[0]=done;

		wr=0;
		for (;  wr == 0; )
		{
			wr = stream_ch_drawdone.Write(buf_drawdone, 1, 300);
		}
                stream_ch_drawdone.Invalidate();

		Simple.Sleep(1000);
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

















