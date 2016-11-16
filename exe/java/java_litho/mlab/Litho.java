package mlab;  //litho 26.10.12

public class Litho
{
   	static int X_POINTS;// = 50;
   	static int Y_POINTS;// = 50;
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
	static  int USTEP_DLY= 400;
       	static  int ZUSTEP_DLY= 1;

	static  int M_BASE_K;// = 5;
        static  int M_USTEP;// = 21;
      	static  int M_ZUSTEP;


	static final int PORT_COS_X = ( Port.OUT | 3 );
	static final int PORT_COS_Y = ( Port.OUT | 4 );
	static final int PORT_COS_Z = ( Port.OUT | 5 );

	static final int PORT_X = ( Port.OUT | 0 );
	static final int PORT_Y = ( Port.OUT | 1 );
	static final int PORT_Z = ( Port.OUT | 2 );

	static final int PORT_uVector = ( Port.OUT | 6 );

//     	static final int PORT_ZuVector = ( Port.OUT | 6 );

	static final int PORT_H = ( Port.IN | 2 );

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
		int i;
		int src_i;
		int dst_i;
                int s;
		int[] datain;
                int[] maskin;
		Port[] portsfw; //forward  scene
              	Port[] portsbw;  //backward   scene
		Span[] span_x_y_z;
		Span[] span_h;
             	Span[] span_z;      //dt after action
		Span[] span_uVect;
                Span[] span_ZuVect;
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
                int ZuVector;
                int wr,rd;
                int dt;   //time action
                int Amplifier;  //action Z
		int ScanPath;
		int SZ;
		int ScanMethod;
		int MicrostepDelay;
		int MicrostepDelayBW;
		int DiscrNumInMicroStep;
		int XMicrostepNmb;
		int YMicrostepNmb;

                M_BASE_K = Simple.bramID("m_BaseK");
                M_USTEP  = Simple.bramID("m_ustep");
                M_ZUSTEP = Simple.bramID("m_Z_ustep");


		datain=Simple.xchgGet("algoritmparams.bin");
                int i0=4;
		X_POINTS        =    datain[i0];
		Y_POINTS        =    datain[i0+1];
		ScanPath        =    datain[i0+2];
		SZ              =    datain[i0+3];
		ScanMethod      =    datain[i0+4];
		MicrostepDelay  =    datain[i0+5];
		MicrostepDelayBW=    datain[i0+6];
		DiscrNumInMicroStep= datain[i0+7]; //<<
		XMicrostepNmb   =   -datain[i0+8]; //<<
		YMicrostepNmb   =   -datain[i0+9]; //<<
                Amplifier       =    datain[i0+10]; //<<
                dt              =    datain[i0+11]; //<<


              	maskin=Simple.xchgGet("lithomask.bin"); //массив одномерный- правильно заполнить в дельфи



                int fastlines=X_POINTS;
                int slowlines=Y_POINTS;
                if (ScanPath==1)
                {
                 fastlines=Y_POINTS;
                 slowlines=X_POINTS;
                }



for (i=4;i<16; i++)  { Simple.DumpInt(datain[i]);}

		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,1,2*SZ*X_POINTS*Y_POINTS,JVIO.FIFO,SZ*fastlines, 0);  // 2
                JVIO stream_ch_params    = new JVIO(CH_PARAMS,  2, 1,JVIO.BUF,  1, 0);                        // 3

                  dt        =5;
                  Amplifier =1;
		int[] buf_stop;
		buf_stop = new int[1];
		buf_stop[0] =0;
		wr = stream_ch_stop.Write(buf_stop, 1, 1000);
		stream_ch_stop.Invalidate();

		int[] buf_drawdone;
		buf_drawdone = new int[1];
		buf_drawdone[0] =0;
		wr = stream_ch_drawdone.Write(buf_drawdone, 1, 1000);

                 int[] buf_params;
		buf_params=new int[2];
                buf_params[0]=datain[i0+10]  ; //<<   ???    // amplifier
                buf_params[1]=datain[i0+11];                  // dt
                 wr=0;
                for (;  wr == 0; )
		{
                 wr = stream_ch_params.Write(buf_params, 1, 1000);
		}


	       //  d_step_N =  XMicrostepNmb;     // Кол-во микрошагов от точки к точке.
		USTEP_DLY =  MicrostepDelay;
		d_step = XMicrostepNmb * DAC_STEP; // Приращение ЦАП на шаге от точки к точке.
                ZUSTEP_DLY = 5;
               	span_z     = new Span[] { new Span(2), new Span(1) ,new Span(400+dt)}; //240512
		span_x_y_z = new Span[] { new Span(2), new Span(1) };
		span_h     = new Span[] { new Span(2), new Span(1), new Span(400) };

                 Simple.DumpInt(0xAAAAAAAA);

                 Simple.DumpInt(XMicrostepNmb);

              Simple.DumpInt(USTEP_DLY);
 	 //	uVector  = (2 * 0x00010000 / USTEP_DLY);
              Simple.DumpInt(ZUSTEP_DLY);
               	ZuVector = (2 * 0x01000000 / ZUSTEP_DLY);         //jump 100

	 //	Simple.bramWrite( M_USTEP, uVector );          //     20.0212
                Simple.DumpInt(0xAAAA0001);
               	Simple.bramWrite( M_ZUSTEP, ZuVector );

                Simple.DumpInt(0xAAAA0002);

		// Цикл сканирования по строкам.

		for(lines=slowlines; lines>0; --lines)
		{
             Simple.DumpInt(lines);
			rd=0;
			for (;  rd == 0; )
			{
				rd=stream_ch_stop.Read(buf_stop, 1,300,true);
			}

			if (buf_stop[0] == MakeSTOP)
			{
				break;
			}
                   //   read buffers params
			rd=0;
		       for (;  rd == 0; )
			{
			 rd = stream_ch_params.Read(buf_params, 1,200,true);
			}
                         Amplifier   = buf_params[0];
                         dt          = buf_params[1];
   //                      dt        =5;
   //                      Amplifier =1;
                   //
             //       Simple.DumpInt(0xAAAA0003);
                       	span_z = new Span[] { new Span(2), new Span(1) ,new Span(dt)};
                        portsfw = new Port[]
                                   {
                                    new Port(PORT_COS_X,   span_x_y_z),
		                    new Port(PORT_COS_Y,   span_x_y_z),
                                    new Port(PORT_COS_Z,   span_z),
		                    new Port(PORT_X,       span_x_y_z),
		                    new Port(PORT_Y,       span_x_y_z),
		                    new Port(PORT_H,       span_h),
                                    new Port(PORT_Z,       span_z)
                                   };
                       	scene = new Scene( portsfw );
         		for(handle=0;handle==0;)
	        	{
		        	handle = scene.createScene( scene.getTemplate(), 3*(fastlines) ); //+1
			        if ( 0 == handle ) scene.releaseScene(0);
        		}
			scene.setScanPorts( handle, new int[] {PORT_X,PORT_COS_X,
		                                               PORT_Y,PORT_COS_Y,
		                                               PORT_Z,PORT_COS_Z}
                                          );

                   	dacX = 0xFFFF0000 & scene.getPort( PORT_X );
	             	dacY = 0xFFFF0000 & scene.getPort( PORT_Y );
	    //     	dacZ = 0xFFFF0000 & scene.getPort( PORT_Z );
           //        Simple.DumpInt(0xAAAA0004);

			for(point=0; point<fastlines; point++)  //forward
			{
              //    Simple.DumpInt((slowlines-lines)*fastlines+point);
                               if (Amplifier > 0)
                                dacZ = maskin[( slowlines- lines)*fastlines+point]*Amplifier;
                               else
                                 dacZ = -maskin[( slowlines- lines)*fastlines+point]/Amplifier;
	 //      	    Simple.DumpInt(dacZ);

                    Simple.DumpInt(0xAAAAAAA0);
                     Simple.DumpInt(Amplifier);
                       Simple.DumpInt(dt);
                          	scene.addPoint( handle, dacX, dacY, 0 );
                              	scene.addPoint( handle, dacX, dacY, -dacZ ); //action and wait dt time  sign ???
                               	scene.addPoint( handle, dacX, dacY, 0 );
			      if (  ScanPath == 0)                    // X Mode
				           { dacX += d_step;}
				 else      { dacY += d_step;}        // Y Mode
			}

                      	// run

        		scene.run( handle );

			scene.wait( handle, -1 );

                 //   Simple.DumpInt(0xAAAA0008);

                   	arr = scene.get( handle, PORT_H );
                                	//Read data Оставляем в массиве только нужные данные.
			src_i = 2;
			dst_i = 0;
			for(i=0; i<fastlines; i++)
			{
				arr[dst_i] = arr[src_i];
				dst_i += 1;
				src_i += 9;
			}


			wr=0;  rd=0;
			 s = fastlines;
			for (;  wr != s; )
			{
				wr += stream_ch_data_out.WriteEx(arr, wr, s-wr, 1000);
			}

                        scene.releaseScene( handle );

                        //write data  1 */

            	   /*  	arr = new int[fastlines];
			for(i=0; i<fastlines; i++)
			{
				arr[i] = 1;
			}

			wr=0;  rd=0;
			 s = fastlines;
			for (;  wr != s; )
			{
				wr += stream_ch_data_out.WriteEx(arr, wr, s-wr, 1000);
			}
                    */
	         	stream_ch_data_out.Invalidate();

                        //backward

                        	rd=0;
			for (;  rd == 0; )
			{
				rd=stream_ch_stop.Read(buf_stop, 1,300,true);
			}

			if (buf_stop[0] == MakeSTOP)
			{
				break;
			}
                   //   read buffers params
			rd=0;
		       for (;  rd == 0; )
			{
			 rd = stream_ch_params.Read(buf_params, 1,200,true);
			}
                         Amplifier   = buf_params[0];
                         dt          = buf_params[1];


                        portsbw = new Port[]
                                   {
                                    new Port(PORT_COS_X,   span_x_y_z),
		                    new Port(PORT_COS_Y,   span_x_y_z),
		                    new Port(PORT_X,       span_x_y_z),
		                    new Port(PORT_Y,       span_x_y_z),
		                    new Port(PORT_H,       span_h)
                                   };
                       	scene = new Scene( portsbw );
         		for(handle=0;handle==0;)
	        	{
		        	handle = scene.createScene( scene.getTemplate(), fastlines+1 );
			        if ( 0 == handle ) scene.releaseScene(0);
        		}
			scene.setScanPorts( handle, new int[] {PORT_X,PORT_COS_X,
		                                               PORT_Y,PORT_COS_Y,
		                                               0,0}
                                                              );

                        /////////
                       for(point=0; point<fastlines; point++)
			{
			    	scene.addPoint( handle, dacX, dacY, 0 );
			      if (  ScanPath == 0)                    // X Mode
				           { dacX -= d_step;}
				 else      { dacY -= d_step;}        // Y Mode
			}

                                if (  ScanPath == 0)
                                   {dacY += d_step;}
                              else {dacX += d_step;}
                          scene.addPoint( handle, dacX, dacY, 0 );

			// run
               //     Simple.DumpInt(0xAAAA0006);
        		scene.run( handle );
			scene.wait( handle, -1 );
                    Simple.DumpInt(0xAAAA0007);
			arr = scene.get( handle, PORT_H );

                      	scene.releaseScene( handle );

			//Read data Оставляем в массиве только нужные данные.
			src_i = 2;
			dst_i = 0;
			for(i=0; i<fastlines; i++)
			{
				arr[dst_i] = arr[src_i];
				dst_i += 1;
				src_i += 3;
			}


			wr=0;  rd=0;
			 s = fastlines;
			for (;  wr != s; )
			{
				wr += stream_ch_data_out.WriteEx(arr, wr, s-wr, 1000);
			}

			stream_ch_data_out.Invalidate();
		}//y                                 next lines




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
                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);
                  ccnt+=1;
                }
           	stream_ch_params.Close();
		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();
	}
}

















