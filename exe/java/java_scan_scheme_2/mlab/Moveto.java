package mlab; //250411

public class ScanTest
{
//	static final int X_POINTS = 100;
//	static final int Y_POINTS = 100;
//	static final int DAC_STEP = 65536*1;

	static  int X_POINTS;
	static  int Y_POINTS;
	static  int DAC_STEP;

	public static final int M_BASE_K = 5;
	public static final int M_PROGRESS = 22;

	static final int N_RPT = 50;

	static final int PORT_X   = ( Port.OUT | 0 );
	static final int PORT_Y   = ( Port.OUT | 1 );
	static final int PORT_H   = ( Port.IN  | 0 );
	static final int PORT_PID = ( Port.IN  | 1 );
// chanels ID
	 static final int CH_STOP        = 0;
	 static final int CH_DRAWDONE    = 1;
	 static final int CH_DATA_OUT    = 2;
         static final int CH_PARAMS      = 3;

	 static final int MakeSTOP =1;

	public static void moveScanner(int x, int y)
	{
		Span[] span;
		Port[] port;
		Scene scene;
		int handle;
		int dacX;
		int dacY;
		int i;
		int move;
		int d_step;
		int d_step_N_Y;
		int d_step_N_Y
                d_step_N_X = XMicrostepNmb; 
                d_step_N_Y = YMicrostepNmb; 

		spanx = new Span[] { new Span(400),
				    new Span(MicrostepDelay*d_step_N_X, d_step_N_X) };
		spany = new Span[] { new Span(400),
				    new Span(MicrostepDelay*d_step_N_Y, d_step_N_Y) };
	
		port = new Port[] { new Port(PORT_X, spanx),
		                    new Port(PORT_Y, spany) };

		scene = new Scene( port );
		for(handle=0;handle==0;)
		{
			handle = scene.createScene( scene.getTemplate(), N_RPT );
			if ( 0 == handle ) scene.releaseScene(0);
		}

		dacX = scene.getPort( PORT_X );	
		dacY = scene.getPort( PORT_Y );

		d_step = DAC_STEP;

		for( ; (x != dacX || y != dacY) ; )
		{
			for(i=0; i<N_RPT; i++)
			{
				move = x - dacX;
				if ( move < 0 )      dacX -= d_step;
				else if ( move > 0 ) dacX += d_step;
				scene.startLoad( handle, PORT_X, i );
					scene.load( handle, dacX );

				move = y - dacY;
				if ( move < 0 )      dacY -= d_step;
				else if ( move > 0 ) dacY += d_step;
				scene.startLoad( handle, PORT_Y, i );
					scene.load( handle, dacY );
			}

			scene.run( handle );
			scene.wait( handle, -1 );
Simple.DumpInt( scene.getPort( PORT_X ) );
Simple.DumpInt( scene.getPort( PORT_Y ) );
		}

		scene.releaseScene( handle );
	}

	public static void main()
	{
		int[] datain;
		int[] arr;
		int i;
		int dacX;
		int dacY;

		Port[] port;
		Span[] span_x_y; 
		Span[] span_h; 
		Scene scene;
		int[] scan;
		int[] pidStatus;
		int handle;
		int point;
		int d_step;
		int d_step_N;
		int x_d_step;
		int y_d_step;
		int lines;
		int scanIndx;
		int x_dir;
		int rd;
		int wr;

                int  ScanPath; 
                int  SZ; 
	        int  ScanMethod; 
                int  MicrostepDelay;
                int  MicrostepDelayBW;
                int  DiscrNumInMicroStep; 
                int  XMicrostepNmb; 
                int  YMicrostepNmb;

                datain=Simple.xchgGet("algoritmparams.bin");

        X_POINTS        =    datain[0];    
        Y_POINTS        =    datain[1]; 
        ScanPath        =    datain[2]; 
        SZ              =    datain[3]; 
	ScanMethod      =    datain[4]; 
        MicrostepDelay  =    datain[5];
        MicrostepDelayBW=    datain[6];
        DiscrNumInMicroStep= datain[7]; //<<
        XMicrostepNmb   =    datain[8]; //<<
        YMicrostepNmb   =    datain[9]; //<<

    JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
    JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
    JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,X_POINTS, 1,JVIO.BUF, 1, 0);                  // 2
    JVIO stream_ch_params    = new JVIO(CH_PARAMS,  1, 1,JVIO.BUF,  1, 0);                        // 3

 
                int[] buf_STOP;
                buf_STOP = new int[1];
                buf_STOP[0] =0;
                wr = stream_ch_stop.Write(buf_STOP, 1, 1000);

                int[] buf_DRAWDONE;
		buf_DRAWDONE=new int[1];

                int[] buf_PARAMS;

		buf_PARAMS=new int[1];

                buf_PARAMS[0]=MicrostepDelay;  
           
                wr = stream_ch_params.Write(buf_PARAMS, 1, 1000);

     		
		Simple.bramWrite( M_BASE_K, 0x73333332 ); /// varible


	        moveScanner(XMicrostepNmb,YMicrostepNmb)

}


