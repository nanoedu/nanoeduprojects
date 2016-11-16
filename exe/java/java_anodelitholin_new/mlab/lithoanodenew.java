package mlab;  //anodelitho 171112  //discrtinmicrostep

public class lithoanodenew
{
   	static int X_POINTS;// = 50;
   	static int Y_POINTS;// = 50;
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
       	static  int ZUSTEP_DLY= 1;
 	static  int USTEP_DLY= 400;
       	static  int USTEP_DLYBW=800;

	static  int M_BASE_K;// = 5;
        static  int M_USTEP;// = 21;
      	static  int M_ZUSTEP;
      	static  int M_SELOPORA;
        static  int M_DACX;
        static  int M_DACY;

	static final int PORT_COS_X = ( 3 );
	static final int PORT_COS_Y = ( 4 );
	static final int PORT_COS_Z = ( 5 );

	static final int PORT_X = ( 0 );
	static final int PORT_Y = ( 1 );
	static final int PORT_Z = ( 2 );

	static final int PORT_H = ( 2 );
       	static final int PORT_U = ( 6 );

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
		int dacU;
		int uVector;
                int uVectorBW;
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
                  //new
              	Dxchg dxchg;

                M_DACX   = Simple.bramID("dxchg_X");
                M_DACY   = Simple.bramID("dxchg_Y");
                M_BASE_K = Simple.bramID("m_BaseK");
                M_USTEP  = Simple.bramID("m_ustep");
                M_ZUSTEP = Simple.bramID("m_Z_ustep");
                M_SELOPORA = Simple.bramID("m_sel_Uopora");

                Simple.bramWrite( M_SELOPORA, 0X80000000);     //use dchange for U

		datain=Simple.xchgGet("algoritmparams.bin");
                int i0=4;
		X_POINTS        =    datain[i0];
		Y_POINTS        =    datain[i0+1];
		ScanPath        =    datain[i0+2];
		SZ              =    datain[i0+3];
		ScanMethod      =    datain[i0+4];
		MicrostepDelay  =    datain[i0+5];
		MicrostepDelayBW=    datain[i0+6];
		DiscrNumInMicroStep= datain[i0+7]<<16;  //<<
		XMicrostepNmb   =    -datain[i0+8]; //<<
		YMicrostepNmb   =    -datain[i0+9]; //<<
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



for (i=0;i<12; i++)  { Simple.DumpInt(datain[i]);}

		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,1,2*SZ*X_POINTS*Y_POINTS,JVIO.FIFO,SZ*X_POINTS, 0);  // 2
                JVIO stream_ch_params    = new JVIO(CH_PARAMS,  4, 1,JVIO.BUF,  1, 0);                        // 3

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
		buf_params=new int[4];
                buf_params[0]=datain[i0+5];    //<<   ???    // speed
                buf_params[1]=datain[i0+6];                  // speed Bw
                buf_params[2]=datain[i0+10]  ; //<<   ???    // amplifier
                buf_params[3]=datain[i0+11];                  // dt
                 wr=0;
                for (;  wr == 0; )
		{
                 wr = stream_ch_params.Write(buf_params, 1, 1000);
		}


	       //  d_step_N =  XMicrostepNmb;     // Кол-во микрошагов от точки к точке.
		USTEP_DLY =  MicrostepDelay;
		d_step = XMicrostepNmb * DAC_STEP; // Приращение ЦАП на шаге от точки к точке.
                ZUSTEP_DLY = 5;

		// Цикл сканирования по строкам.

		for(lines=slowlines; lines>0; --lines)
		{
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
                       MicrostepDelay   = buf_params[0];
                       MicrostepDelayBW = buf_params[1];
                           Amplifier    = buf_params[2];
                           dt           = buf_params[3];

                          USTEP_DLY = buf_params[0];

                       USTEP_DLYBW = buf_params[1];

         		uVector = (2 * DiscrNumInMicroStep / USTEP_DLY);
                        uVectorBW = (2 *DiscrNumInMicroStep / USTEP_DLYBW);

               	 	dacX =Simple.bramRead(M_DACX) ;
	             	dacY =Simple.bramRead(M_DACY) ;
	         	dacZ =0;

                             	dxchg = new Dxchg();
                     	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               -1,-1, -1} );

             //           i=0;
			for(point=0; point<fastlines; point++)  //forward
			{
                               dacU =maskin[( slowlines- lines)*fastlines+point]*Amplifier;
                               dxchg.Goto( dacX,dacY,0);
                               dxchg.Wait(100);
                               dxchg.GetI(PORT_H);
                               dxchg.SetO(PORT_U,dacU);
                              if (dacU!=0) { dxchg.Wait(dt);};
                	      if (  ScanPath == 0)                    // X Mode
				           { dacX += d_step;}
				 else      { dacY += d_step;}        // Y Mode
			}

                      	// run

                       	Simple.bramWrite( M_USTEP, uVector );
        		dxchg.ExecuteScan();
         		dxchg.WaitScanComplete(-1);
	        	arr = dxchg.GetResults();

			wr=0;  rd=0;
			 s = fastlines;
			for (;  wr != s; )
			{
				wr += stream_ch_data_out.WriteEx(arr, wr, s-wr, 1000);
			}

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
                         MicrostepDelay = buf_params[0];
                       MicrostepDelayBW = buf_params[1];
                           Amplifier    = buf_params[2];
                           dt           = buf_params[3];

                         USTEP_DLY = buf_params[0];

                       USTEP_DLYBW = buf_params[1];

         		uVector = (2 * DiscrNumInMicroStep / USTEP_DLY);

                        uVectorBW = (2 * DiscrNumInMicroStep/ USTEP_DLYBW);

                         	dxchg = new Dxchg();
                     	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               -1,-1, -1} );

                         dxchg.SetO(PORT_U,0);  //set U zero  !!! 12/11/12

                         for(point=0; point<fastlines; point++)
                    {
                       	dxchg.Goto( dacX,dacY,0);
                        dxchg.Wait( 100 );
	        	dxchg.GetI( PORT_H );
              	      if (  ScanPath == 0)                    // X Mode
				           { dacX -= d_step;}
				 else      { dacY -= d_step;}        // Y Mode
		    }
                      if (  ScanPath == 0) {dacY += d_step;}    //next fast line
                                      else {dacX += d_step;}
//                      	dxchg.Goto( dacX,dacY,0);
//                        dxchg.Wait( 100 );

			// run

                	Simple.bramWrite( M_USTEP, uVectorBW );
               		dxchg.ExecuteScan();
         		dxchg.WaitScanComplete(-1);        //-1 infinite
	         	arr = dxchg.GetResults();

			//Read data Оставляем в массиве только нужные данные.
			src_i = 0;
			dst_i = 0;
			for(i=0; i<fastlines; i++)
			{
				arr[dst_i] = arr[src_i];
				dst_i += 1;
				src_i += 1;     //3
			}


			wr=0;  rd=0;
			 s = fastlines;
			for (;  wr != s; )
			{
				wr += stream_ch_data_out.WriteEx(arr, wr, s-wr, 1000);
			}

			stream_ch_data_out.Invalidate();		}//y                                 next lines


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

                Simple.bramWrite( M_SELOPORA, 0X00000000); //use bram for U
           	stream_ch_params.Close();
		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();
	}
}

















