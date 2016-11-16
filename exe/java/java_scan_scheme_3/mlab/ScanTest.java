//020611
package mlab;       //original modefied  200511

public class ScanTest
{
	static int X_POINTS = 50;
	static int Y_POINTS = 50;
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
	static  int USTEP_DLY= 400;

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

        public static final int done=60;

        public static final int stop=100;

	public static final int MakeSTOP =1;

	public static void main()
	{
		int[] arr;
		int i;
		int[] datain;
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
		int x_d_step;
		int y_d_step;
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

        int fastlines=X_POINTS;
        int slowlines=Y_POINTS;
                if (ScanPath==1)
                {
                 fastlines=Y_POINTS;
                 slowlines=X_POINTS;
                }
  for (i=0;i<10; i++)  { Simple.DumpInt(datain[i]);}

    JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
    JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
    JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,1,SZ*X_POINTS*Y_POINTS,JVIO.FIFO,SZ*fastlines, 0);  // 2
    JVIO stream_ch_params    = new JVIO(CH_PARAMS,  1, 1,JVIO.BUF,  1, 0);                        // 3


                int[] buf_stop;
                buf_stop = new int[1];
                buf_stop[0] =0;
                wr = stream_ch_stop.Write(buf_stop, 1, 1000);
                stream_ch_stop.Invalidate();

                int[] buf_drawdone;
                buf_drawdone = new int[1];
                buf_drawdone[0] =0;
                wr = stream_ch_drawdone.Write(buf_drawdone, 1, 1000);

          	scan = new int[fastlines*slowlines];

	//	d_step_N = 50;                // Кол-во микрошагов от точки к точке.
	        d_step_N = XMicrostepNmb;
                USTEP_DLY =  MicrostepDelay;
		d_step = d_step_N * DAC_STEP; // Приращение ЦАП на шаге от точки к точке.

		span_x_y_z = new Span[] { new Span(1) };
		span_uVect = new Span[] { new Span(1) };
		span_h     = new Span[] { new Span(100+d_step_N*USTEP_DLY) };

		port = new Port[] { new Port(PORT_COS_X,   span_x_y_z),
		                    new Port(PORT_COS_Y,   span_x_y_z),
		                    new Port(PORT_X,       span_x_y_z),
		                    new Port(PORT_Y,       span_x_y_z),
		                    new Port(PORT_uVector, span_uVect),
		                    new Port(PORT_H,       span_h) };

		scene = new Scene( port );
		for(handle=0;handle==0;)
		{
			handle = scene.createScene( scene.getTemplate(), X_POINTS+2 );
			if ( 0 == handle ) scene.releaseScene(0);
		}

/*		scan[0] = X_POINTS;
		scan[1] = Y_POINTS;
		scan[2] = d_step_N;
*/

//		Simple.bramWrite( M_BASE_K, 0x73333332 );

		dacX = 0xFFFF0000 & scene.getPort( PORT_X );
		dacY = 0xFFFF0000 & scene.getPort( PORT_Y );
		dacZ = 0xFFFF0000 & scene.getPort( PORT_Z );

Simple.DumpInt( dacX );
Simple.DumpInt( dacY );
Simple.DumpInt( dacZ );


		uVector = (2 * 0x00010000 / (USTEP_DLY));

		// Цикл сканирования по строкам.



		for(lines=slowlines,scanIndx=0; lines > 0 ;)
		{
			x_d_step = d_step;
			x_cos = VAL_0_5;
			y_cos = 0;
	               rd=0;
                        for (;  rd == 0; )
			         {
                                  rd=stream_ch_stop.Read(buf_stop, 1,300,true);
		                 }


                        if (buf_stop[0] == MakeSTOP)
                          {

                             break;
                          }


			scene.setScanPorts( handle, new int[] {PORT_X,PORT_COS_X,
		                                               PORT_Y,PORT_COS_Y,
		                                               0,0} );

			for(point=0; point < (fastlines+2) ; point++)
			{
				/*
				    0..(X_POINTS-1) - движение по оси X,
				    (X_POINTS)      - шаг по оси Y,
				    (X_POINTS+1)    - возврат в начальное положение по X.
				*/
				if ( point == (fastlines-1) )
				{
					//x_d_step = -d_step * (X_POINTS-1);
					x_d_step = 0;
				}
				if ( point == (fastlines) )
				{
					//x_d_step = 0;
					x_d_step = -d_step * (fastlines-1);
					if ( lines > 1 )
						dacY += d_step;
					//else
					//	dacY -= d_step*(slowlines-1);
				}
				if ( point == (fastlines+1) )
				{
					x_d_step = 0;
					if ( lines <= 1 )
						dacY -= d_step*(slowlines-1);
				}

				scene.addPoint( handle, dacX, dacY, 0 );

//Simple.DumpInt( dacX ); Simple.DumpInt( dacY );

				dacX += x_d_step;

				//-uVector-
				scene.startLoad( handle, PORT_uVector, point );
			        scene.load( handle, uVector );
			}

			scene.run( handle );
			scene.wait( handle, -1 );

			// При завершении сканирования линии считываем результаты.
			arr = scene.get( handle, PORT_H );

                          	wr=0;  rd=0;
                                int s=arr.length-2;
 Simple.DumpInt(s);
			   for (;  wr != s; )
			    {

 Simple.DumpInt(wr);
 Simple.DumpInt(rd);
				rd = stream_ch_data_out.Write(arr,s-wr,1000);
                                wr=wr+rd;
                             }

 Simple.DumpInt(wr);
                        stream_ch_data_out.Invalidate();
			System.arraycopy( arr, 0, scan, scanIndx,fastlines );
                        scanIndx += fastlines;

			// Перешли к следующей строке.
			lines -= 1;
	//		Simple.DumpInt( lines );
    		        Simple.Sleep( d_step_N * USTEP_DLY * fastlines / 1000 );
        //                Simple.Sleep( 2*d_step_N * USTEP_DLY * fastlines / 1000 );

		}//y

		scene.releaseScene( handle );

		//Simple.xchgCreate( "topo.dat", scan );

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
//                    Simple.Sleep(1000);

	}

}

















