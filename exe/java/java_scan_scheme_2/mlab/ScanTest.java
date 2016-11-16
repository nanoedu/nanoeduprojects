package mlab;    //110511   scheme 2

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

	static final int PORT_X = ( Port.OUT | 0 );
	static final int PORT_Y = ( Port.OUT | 1 );
	static final int PORT_H = ( Port.IN | 0 );
	static final int PORT_PID = ( Port.IN | 1 );
// chanels ID
	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;
	public static final int CH_DATA_OUT    = 2;
        public static final int CH_PARAMS      = 3;

        public static final int done=60;

        public static final int stop=100;

	public static final int MakeSTOP =1;

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

		span = new Span[] { new Span(400) };
		port = new Port[] { new Port(PORT_X, span),
		                    new Port(PORT_Y, span) };

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


  for (i=0;i<10; i++)  { Simple.DumpInt(datain[i]);}

     Simple.Sleep(10000);



    JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
    JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
    JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,1,X_POINTS*Y_POINTS,JVIO.FIFO, 1, 0);                  // 2
    JVIO stream_ch_params    = new JVIO(CH_PARAMS,  1, 1,JVIO.BUF,  7, 0);                        // 3


                int[] buf_stop;
                buf_stop = new int[1];
                buf_stop[0] =0;
                wr = stream_ch_stop.Write(buf_stop, 1, 1000);

                int[] buf_DRAWDONE;
		buf_DRAWDONE=new int[1];

                int[] buf_PARAMS;

		buf_PARAMS=new int[1];

                buf_PARAMS[0]=MicrostepDelay;
                   wr=0;
                for (;  wr == 0; )
		{
                 wr = stream_ch_params.Write(buf_PARAMS, 1, 1000);
                }
                DAC_STEP=DiscrNumInMicroStep;


		scan = new int[X_POINTS*Y_POINTS];
		//pidStatus = new int[3+X_POINTS*Y_POINTS];

		d_step   = DAC_STEP;          // Приращение ЦАП на микрошаге.
		d_step_N =50;// XMicrostepNmb;     // Кол-во микрошагов от точки к точке.


///!!!!!!!!
			 span_x_y = new Span[] { new Span(400),
 		                                 new Span(100, d_step_N) };
                         span_h = new Span[]   { new Span(400) };

         		 port = new Port[] { new Port(PORT_X, span_x_y),
		                             new Port(PORT_Y, span_x_y),
		                             new Port(PORT_H, span_h)
                                          /*,new Port(PORT_PID, span_h)*/ };

         		 scene = new Scene( port );

        		 for(handle=0;handle==0;)
	        	  {
			    handle = scene.createScene( scene.getTemplate(), X_POINTS );
			    if ( 0 == handle ) scene.releaseScene(0);
		           }
////
		Simple.bramWrite( M_BASE_K, 0x73333332 );

		dacX = 0;
		dacY = 0;

		x_dir = 1; // Прямой ход.

		// Цикл сканирования по строкам.
		for(lines=Y_POINTS,scanIndx=0; lines > 0 ;)
		{

		     rd = stream_ch_stop.Read(buf_stop, 1,200,false);

			if (buf_stop[0] == MakeSTOP)
                                {
                                  break;
                                 }
                 	rd=0;
		   for (;  rd == 0; )
                   {
     		     rd = stream_ch_params.Read(buf_PARAMS, 1,300,true);
                   }

                       MicrostepDelay   = buf_PARAMS[0];

			y_d_step = 0;
			if ( x_dir > 0 )
			{
				x_d_step = d_step;
			}
			else
			{
				x_d_step = -d_step;
			}


			for(point=0; point < X_POINTS ; point++)
			{
                        	Simple.DumpInt( point );
			    scene.startLoad( handle, PORT_X, point );
			    scene.load( handle, dacX );
        		    scene.load( handle, dacX+x_d_step, x_d_step, d_step_N );

		            dacX += (x_d_step * d_step_N);

				// На обратном пути при последнем перемещении по X делаем шаг и по Y
			    if ( x_dir < 0 && point == (X_POINTS-1) ) y_d_step = d_step;

                            scene.startLoad( handle, PORT_Y, point );
			    scene.load( handle, dacY );
			    scene.load( handle, dacY+y_d_step, y_d_step, d_step_N );

			    dacY += (y_d_step * d_step_N);

			}
			scene.run( handle );
			scene.wait( handle, -1 );

			if ( x_dir > 0 )
			{
				// При завершении прямого перемещения считываем результаты.
				arr = scene.get( handle, PORT_H );

				//for(i=0;i<arr.length;i++) arr[i] = arr[i] >> 16;
                              	wr=0;  rd=0;
                                int s=arr.length;
			   for (;  wr != s; )
			    {
                            	Simple.DumpInt(wr); Simple.DumpInt(rd);
				rd = stream_ch_data_out.Write(arr,s-wr,1000);
                                wr=wr+rd;
                             }
				stream_ch_data_out.Invalidate();

				System.arraycopy( arr, 0, scan, scanIndx, X_POINTS );

				//arr = scene.get( handle, PORT_PID );
				//System.arraycopy( arr, 0, pidStatus, scanIndx, X_POINTS );

				scanIndx += X_POINTS;
			}
			else
			{
				// Перешли к следующей строке.
				lines -= 1;
				Simple.DumpInt( lines );
			}

			x_dir = -x_dir;

			scene.releaseScene(handle);


			if ( 0xABBA1234 == Simple.bramRead(M_PROGRESS) ) break;
		}

	//	scene.releaseScene( handle );

		Simple.xchgCreate( "topo.dat", scan );
	//	Simple.DumpInt( scene.getPort( PORT_X ) );
	//	Simple.DumpInt( scene.getPort( PORT_Y ) );

		moveScanner(0, 0);

                buf_stop[0]=done;
                wr=0;
                 for (;  wr == 0; )
		 {
                  wr = stream_ch_stop.Write(buf_stop, 1, 300);
	         }
		wr=0;
                for(i=0;buf_stop[0]!=stop ;i++)
   	      {
                 wr = stream_ch_drawdone.Read(buf_stop, 1,10000,false);
              }
                       stream_ch_params.Close();
                       stream_ch_drawdone.Close();
                       stream_ch_data_out.Close();
                       stream_ch_stop.Close();
                    Simple.Sleep(1000);

	///	Simple.DumpInt( scene.getPort( PORT_X ) );
	//	Simple.DumpInt( scene.getPort( PORT_Y ) );
	}

}


