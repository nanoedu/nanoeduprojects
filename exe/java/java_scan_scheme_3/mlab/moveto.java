package mlab; //280411

public class ScanTest
{
	static  int X_POINTS;// = 50;
	static  int Y_POINTS;// = 50;
	static  int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
	static final int USTEP_DLY= 400;

	static final int M_BASE_K = 5;

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
	public static final int CH_DATA_OUT    = 2;
        public static final int CH_PARAMS      = 3;

	public static final int MakeSTOP =1;
        public static final int stop=100;
        public static final int done=60;

	public static void main()
	{
                int[] datain;
		int[] arr;
		int i;

		Port[] port;
		Span[] span_x_y_z;
		Span[] span_h;
		Span[] span_uVect;
		Scene scene;
		int[] scan;
		int handle;
		int point;
		int d_step;
		int d_step_N;
		int d_step_X;
		int d_step_Y;
		int x_cos;
		int y_cos;
		int lines;
		int scanIndx;
		int x_dir;
		int dacX;
		int dacY;
		int dacZ;
		int uVector;
	        int rd,wr;

                int  ScanPath;
                int  SZ;
	        int  ScanMethod;
                int  MicrostepDelay;
                int  MicrostepDelayBW;
                int  DiscrNumInMicroStep;
                int  X0;
                int  Y0;

                datain=Simple.xchgGet("algoritmparams.bin");

        X_POINTS        =   1;//datain[0];
        Y_POINTS        =   1;// datain[1];
        ScanPath        =   0;// datain[2];
        SZ              =   1;// datain[3];
	ScanMethod      =   0;// datain[4];
        MicrostepDelay  =    datain[5];
        MicrostepDelayBW=    datain[6];
        DiscrNumInMicroStep=1;// datain[7]; //<<
        X0   =    datain[8]; //<<
        Y0   =    datain[9]; //<<

    JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                      // 0
    JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                      // 1
    JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,1,X_POINTS*Y_POINTS,JVIO.BUF,  X_POINTS*Y_POINTS, 0);        // 2
    JVIO stream_ch_params    = new JVIO(CH_PARAMS,  1, 1,JVIO.BUF,  7, 0);                      // 3


                int[] buf_stop;
                buf_stop = new int[1];
                buf_stop[0] =0;
                wr = stream_ch_stop.Write(buf_stop, 1, 1000);

                int[] buf_drawdone;
		buf_drawdone=new int[1];

                int[] buf_params;

		buf_params=new int[1];

                buf_params[0]=MicrostepDelay;

                wr = stream_ch_params.Write(buf_params, 1, 1000);

                DAC_STEP=DiscrNumInMicroStep;

           	dacX = 0xFFFF0000 & scene.getPort( PORT_X );
		dacY = 0xFFFF0000 & scene.getPort( PORT_Y );
		dacZ = 0xFFFF0000 & scene.getPort( PORT_Z );

		d_step   = DAC_STEP;          // Приращение ЦАП на микрошаге.
	      int	d_step_N_X =dacX- X0;     // Кол-во микрошагов от точки к точке
	      int	d_step_N_Y =dacY- Y0;

//		d_step_N = 50;                // Кол-во микрошагов от точки к точке.

	    d_step_X = d_step_N_X * DAC_STEP; // Приращение ЦАП на шаге от точки к точке.
            d_step_Y = d_step_N_Y * DAC_STEP;

         	span_x_y_z = new Span[] { new Span(1) };
		span_uVect = new Span[] { new Span(1) };

		port = new Port[] { new Port(PORT_COS_X,   span_x_y_z),
		                    new Port(PORT_COS_Y,   span_x_y_z),
		                    new Port(PORT_X,       span_x_y_z),
		                    new Port(PORT_Y,       span_x_y_z),
		                    new Port(PORT_uVector, span_uVect),
		                   };

		scene = new Scene( port );
		for(handle=0;handle==0;)
		{
			handle = scene.createScene( scene.getTemplate(), 2 );
			if ( 0 == handle ) scene.releaseScene(0);
		}



		Simple.bramWrite( M_BASE_K, 0x73333332 );





Simple.DumpInt( dacX );
Simple.DumpInt( dacY );
Simple.DumpInt( dacZ );


		uVector = (2 * 0x00010000 / (MicrostepDelay/2));



	       //		x_d_step = d_step;
			x_cos = VAL_0_5;
			y_cos = 0;


                      uVector = (2 * 0x00010000 / (MicrostepDelay/2));
//move x
                                dacX-=d_step_X ;

				scene.addPoint( handle, dacX, dacY, 0 );

                              	scene.startLoad( handle, PORT_uVector, 0 );
			        scene.load( handle, uVector );

//move y

				dacY -=d_step_Y;

				scene.addPoint( handle, dacX, dacY, 0 );


				//-uVector-
				scene.startLoad( handle, PORT_uVector, 1 );
				scene.load( handle, uVector );



			scene.run( handle );
			scene.wait( handle, -1 );

		scene.releaseScene( handle );

                buf_drawdone[0]=done;

  Simple.DumpInt(done);

                wr=0;
                 for (;  wr == 0; )
		 {
                  wr = stream_ch_drawdone.Write(buf_drawdone, 1, 300);

	         }
                stream_ch_drawdone.Invalidate();

  Simple.Sleep(1000);

		rd=0;

                for(;buf_stop[0]!=stop ;)
   	        {
Simple.DumpInt(rd);
                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);
                }
  Simple.DumpInt(1);
                       stream_ch_params.Close();
                       stream_ch_drawdone.Close();
                       stream_ch_data_out.Close();
                       stream_ch_stop.Close();
                    Simple.Sleep(1000);

	}

}

















