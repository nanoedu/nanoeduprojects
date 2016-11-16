package mlab;     //26.10.12

public class ScanTest
{
	static int X_POINTS = 50;
	static int Y_POINTS = 50;
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
	static  int USTEP_DLY= 400;
        static  int  Phase=3;
        static  int  UAM =4;   //Force Image SFM
        static  int  I=7;      //Current STM
        static  final int SEM=3;  // SEM unit
/*
	static final int M_BASE_K = 5;

	static final int M_USTEP = 21;
*/

	static  int M_BASE_K;// = 5;
	static  int M_USTEP;// = 21;

	static final int PORT_COS_X = ( Port.OUT | 3 );
	static final int PORT_COS_Y = ( Port.OUT | 4 );
	static final int PORT_COS_Z = ( Port.OUT | 5 );

	static final int PORT_X = ( Port.OUT | 0 );
	static final int PORT_Y = ( Port.OUT | 1 );
	static final int PORT_Z = ( Port.OUT | 2 );

	static final int PORT_uVector = ( Port.OUT | 6 );

	static final int PORT_H  =  ( Port.IN | 2 );
        static final int PORT_PH =  ( Port.IN | 0 );
        static final int PORT_ERR = ( Port.IN | 1 );

        // chanels ID
	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;
	public static final int CH_DATA_OUT    = 2;
        public static final int CH_PARAMS      = 3;

        public static final int done=60;

        public static final int stop=100;

	public static final int MakeSTOP =1;

	public static void main(String[] arg)
	{
		int[] arr;
              	int[] arradd;
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
		int  MicrostepDelay;
		int  MicrostepDelayBW;
		int  DiscrNumInMicroStep;
		int  XMicrostepNmb;
		int  YMicrostepNmb;
                int  fastlinescount;
                int  slowlinescount;

       M_BASE_K =Simple.bramID("m_BaseK");;
       M_USTEP = Simple.bramID("m_ustep");;

		datain=Simple.xchgGet("algoritmparams.bin");
                int i0=4;
		X_POINTS        =    datain[i0];
		Y_POINTS        =    datain[i0+1];
		ScanPath        =    datain[i0+2];
		SZ              =    datain[i0+3];
		ScanMethod      =    datain[i0+4];
		MicrostepDelay  =    datain[i0+5];
		MicrostepDelayBW=    datain[i0+5];
		DiscrNumInMicroStep= datain[i0+6]; //<<
		XMicrostepNmb   =    -datain[i0+7]; //<< **
		YMicrostepNmb   =    -datain[i0+8]; //<< **
        //      	flgUnit         =    datain[10];
                  int  flgUNit;
                  int  MaxX=0x7fffffff;
                  int  MinX=0x80000000;
                  int  MaxY=0x7fffffff;
                  int  MinY=0x80000000;
           /*     if flgUNit=SEM
                {
                   MaxX=0x40000000;
                   MaxY=0x40000000;
                }
           */
                int fastlines=X_POINTS;
                int slowlines=Y_POINTS;
                if (ScanPath==1)
                {
                 fastlines=Y_POINTS;
                 slowlines=X_POINTS;
                }

		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,SZ,X_POINTS*Y_POINTS,JVIO.FIFO,fastlines, 0);  // 2
        //      JVIO stream_ch_params    = new JVIO(CH_PARAMS,  1, 1,JVIO.BUF,  1, 0);                        // 3

       		int[] dataout;
	   	dataout=new int[SZ*X_POINTS*Y_POINTS];

		int[] buf_stop;
		buf_stop = new int[1];
		buf_stop[0] =0;
		wr = stream_ch_stop.Write(buf_stop, 1, 1000);
		stream_ch_stop.Invalidate();

		int[] buf_drawdone;
		buf_drawdone = new int[1];
		buf_drawdone[0] =0;
		wr = stream_ch_drawdone.Write(buf_drawdone, 1, 1000);

		d_step_N = XMicrostepNmb;     // Кол-во микрошагов от точки к точке.
		USTEP_DLY =  MicrostepDelay;
		d_step = d_step_N * DAC_STEP; // Приращение ЦАП на шаге от точки к точке.

		span_x_y_z = new Span[] { new Span(2), new Span(1) };
		span_h     = new Span[] { new Span(2), new Span(1), new Span(400) };

		port = new Port[] { new Port(PORT_COS_X,   span_x_y_z),
		                    new Port(PORT_COS_Y,   span_x_y_z),
		                    new Port(PORT_X,       span_x_y_z),
		                    new Port(PORT_Y,       span_x_y_z),
		                    new Port(PORT_H,       span_h),
                                    new Port(PORT_PH,      span_h),
                                    new Port(PORT_ERR,     span_h)};

		scene = new Scene( port );
		for(handle=0;handle==0;)
		{
			handle = scene.createScene( scene.getTemplate(), fastlines+2 );
			if ( 0 == handle ) scene.releaseScene(0);
		}

		dacX = 0xFFFF0000 & scene.getPort( PORT_X );
		dacY = 0xFFFF0000 & scene.getPort( PORT_Y );
		dacZ = 0xFFFF0000 & scene.getPort( PORT_Z );

Simple.DumpInt( dacX );
Simple.DumpInt( dacY );
Simple.DumpInt( dacZ );

      //		uVector = (2 * 0x00010000 / USTEP_DLY);

     //		Simple.bramWrite( M_USTEP, uVector );

                     slowlinescount=0;
		// Цикл сканирования по строкам.
		for(lines=slowlines; lines>0; --lines)
		{
		    fastlinescount=0;
                  //  	Simple.bramWrite( M_USTEP, uVector );
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

			for(point=0; point<fastlines; point++)
			{
				scene.addPoint( handle, dacX, dacY, 0 );
			      if (  ScanPath == 0)                    // X Mode
				           {if (dacX>(MinX-d_step))
                                             {dacX += d_step;fastlinescount+=1;}
                                           }
              				 else
                                           {if (dacY>(MinY-d_step))
                                           {dacY += d_step;fastlinescount+=1;}
                                           }  // Y Mode
			}
                        if (  ScanPath == 0)
			             {dacX -= fastlinescount*d_step;}
			 else        {dacY -= fastlinescount*d_step;}

                        scene.addPoint( handle, dacX, dacY, 0 );
			if ( lines > 1 ) {
                              if (  ScanPath == 0)
                                   {if (dacY>(MinY-d_step)){dacY += d_step;slowlinescount+=1;}}
                              else {if (dacX>(MinX-d_step)){dacX += d_step;slowlinescount+=1;}}
                                         }

			else    {
                                 if (  ScanPath == 0)  dacY -= (slowlinescount-1)*d_step;         // Go to Start Point
				                  else dacX -= (slowlinescount-1)*d_step;
			        }

			scene.addPoint( handle, dacX, dacY, 0 );

			// run
        		scene.run( handle );
			scene.wait( handle, -1 );

			arr    = scene.get( handle, PORT_H );

                        arradd = scene.get( handle, PORT_ERR );

                        if (ScanMethod == Phase)                       { arradd = scene.get( handle, PORT_PH ); }
                        if ((ScanMethod == I) | (ScanMethod == UAM))   { arradd = scene.get( handle, PORT_ERR );}

			// Оставляем в массиве только нужные данные.
			src_i = 2;
			dst_i = 0;
			for(i=0; i<fastlines; i++)
			{
			    dataout[dst_i]   = arr[src_i];
                            if (SZ==2)  { dataout[dst_i+1] =arradd[src_i];}
			    if (SZ==1)	{dst_i += 1;}
                            else        {dst_i += 2;}
				src_i += 3;
			}


			wr=0;  rd=0;
			int s = fastlines;
// Simple.DumpInt(s);
			for (;  wr != s; )
			{

// Simple.DumpInt(wr);
// Simple.DumpInt(rd);
				wr += stream_ch_data_out.WriteEx(dataout, wr, s-wr, 1000);
			}

// Simple.DumpInt(wr);
			stream_ch_data_out.Invalidate();
		}//y

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
		int ccnt = 0;
              //  for(;(buf_stop[0]!=stop) & (ccnt < 50) ;)
                  for(;(buf_stop[0]!=stop) ;)


                {
Simple.DumpInt(rd);
                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);
                  ccnt+=1;
                }
Simple.DumpInt(1);

	//	stream_ch_params.Close();
		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();
	}

}

















