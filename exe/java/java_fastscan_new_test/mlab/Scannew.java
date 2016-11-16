package mlab;  // fastscan
// 18/10/16 changed buffer
               // 22/03/13  // additional element in buffer (  <> mod 512)

public class Scannew
{
	static int X_POINTS = 50;
	static int Y_POINTS = 50;
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
	static  int USTEP_DLY= 400;
       	static  int USTEP_DLYBW=800;
    //methods
        static  int  OneLine=11;
        static  int  Phase=3;
        static  int  UAM =4;   //Force Image SFM
        static  int  I=7;      //Current STM
        static  int  FastScan=8;
        static  int  FastScanPhase=10;
    //
        static  final int SEM=3;  // SEM unit
	static  int M_BASE_K;// = 5;
	static  int M_USTEP;// = 21;
        static  int M_DACX;
        static  int M_DACY;
	static final int PORT_COS_X = ( 3 );
	static final int PORT_COS_Y = ( 4 );
	static final int PORT_COS_Z = ( 5 );
    //in
	static final int PORT_X = ( 0 );
	static final int PORT_Y = ( 1 );
	static final int PORT_Z = ( 2 );

    //out
	static final int PORT_H   = ( 2 );      //Z
        static final int PORT_PH  = ( 0 );
        static final int PORT_ERR = ( 1 );
        static final int PORT_I   = ( 4 );
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
               	int uVectorBW;
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
               //new
              	Dxchg dxchg;

                M_BASE_K =Simple.bramID("m_BaseK");;
                M_USTEP = Simple.bramID("m_ustep");;
                M_DACX   = Simple.bramID("dxchg_X");
                M_DACY   = Simple.bramID("dxchg_Y");

	//	datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

		X_POINTS        =   100; // datain[i0];
		Y_POINTS        =   100; // datain[i0+1];
		ScanPath        =   0;//  datain[i0+2];
		SZ              =   1;//  1; //datain[i0+3];
		ScanMethod      =   8;//  datain[i0+4];
		MicrostepDelay  =   5;//5;//  datain[i0+5];
		MicrostepDelayBW=   5;//5;//  datain[i0+6];
		DiscrNumInMicroStep= 1<<16;//  datain[i0+7] << 16;
		XMicrostepNmb   =  -16;//  -datain[i0+8]; //<< **
		YMicrostepNmb   =  -1;//  -datain[i0+9]; //<< **


                int  flgUNit;
                int  MaxX=0x7fffffff;
                int  MinX=0x80000000;
                int  MaxY=0x7fffffff;
                int  MinY=0x80000000;
                int fastlines=X_POINTS;
                int slowlines=Y_POINTS;
                if (ScanPath==1)
                {
                 fastlines=Y_POINTS;
                 slowlines=X_POINTS;
                }


		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
             // +1 - лишняя точка, чтобы исключить передачу данных длиной,
             //  кратной 512 байт
               JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,SZ,fastlines*slowlines+ 1,JVIO.FIFO,fastlines*slowlines+ 1, 0); // 2
               JVIO stream_ch_params    = new JVIO(CH_PARAMS,  2, 1,JVIO.BUF,  1, 0);                        // 3

       		int[] dataout;

		dataout=new int[fastlines*slowlines+1];

	

	        d_step_N = XMicrostepNmb;     // Кол-во микрошагов от точки к точке.
 		d_step = d_step_N * DAC_STEP; // Приращение ЦАП на шаге от точки к точке.

	       	dacX =Simple.bramRead(M_DACX) ;
             	dacY =Simple.bramRead(M_DACY) ;
        	dacZ =0;


                USTEP_DLY = MicrostepDelay;

                USTEP_DLYBW =MicrostepDelayBW;

      		uVector =   (2 * DiscrNumInMicroStep / USTEP_DLY);
                if (uVector==0) uVector=1;

                uVectorBW = (2 * DiscrNumInMicroStep / USTEP_DLYBW);
                if (uVectorBW==0) uVectorBW=1;

     		Simple.bramWrite( M_USTEP, uVector );

      		// Цикл сканирования по строкам.
               	rd=0;      	dst_i = 0;
                  slowlinescount=0;

		for(lines=slowlines; lines>0; --lines)
		{ 
                    
                         fastlinescount=0;
                       //   read buffers params

                  uVector = (2 * DiscrNumInMicroStep / USTEP_DLY);
                  uVectorBW = (2 * DiscrNumInMicroStep / USTEP_DLYBW);
                       	dxchg = new Dxchg();
                     	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               -1,-1, -1} );

			for(point=0; point<fastlines; point++)
			{
		          dxchg.Goto( dacX,dacY,0);
                      	  dxchg.Wait( 100 );
                          if (ScanMethod == FastScan) { dxchg.GetI( PORT_I);}
                          else
                          {
                           dxchg.GetI( PORT_PH);
                          }
  			      if (  ScanPath == 0)                    // X Mode
				           {if (dacX>(MinX-d_step))
                                             {dacX += d_step;fastlinescount+=1;}
                                           }
              				 else
                                           {if (dacY>(MinY-d_step))
                                             {dacY += d_step;fastlinescount+=1;}
                                           }  // Y Mode
			}
               	// run   foreward line

                       	Simple.bramWrite( M_USTEP, uVector );
        		dxchg.ExecuteScan();
         		dxchg.WaitScanComplete(-1);
	        	arr = dxchg.GetResults();
                      	src_i = 0;

                       	// Оставляем в массиве только нужные данные.
			for(i=0; i<fastlines; i++)
			{
			    dataout[dst_i]   = arr[src_i];
			    dst_i += 1;
                            src_i += 1;
			}

                // run    backward                
                  	dxchg = new Dxchg();
                     	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
         		                               PORT_Y,PORT_COS_Y, dacY,
                	                               -1,-1, -1} );


                        if (  ScanPath == 0)
			             {dacX -= fastlinescount*d_step;}
			 else        {dacY -= fastlinescount*d_step;}

                        dxchg.Goto( dacX,dacY,0);
                        if ( lines > 1 )
                                  {
                                   if (  ScanPath == 0)
                                       {if (dacY>(MinY-d_step)){dacY += d_step;slowlinescount+=1;}
                                  }
                                     else {if (dacX>(MinX-d_step)){dacX += d_step;slowlinescount+=1;}}
                                  }
			     else {
                                   if (  ScanPath == 0)  dacY -= (slowlinescount-1)*d_step;         // Go to Start Point
				                    else dacX -= (slowlinescount-1)*d_step;
			          }
			 dxchg.Goto( dacX,dacY,0);

		// run    backward

                       	Simple.bramWrite( M_USTEP, uVectorBW );
                      	dxchg.ExecuteScan();
         		dxchg.WaitScanComplete(-1);

		}//y
                	wr=0;  rd=0;

			int s = slowlines*fastlines +1;  // +1 чтобы размер данных был <> mod 512
			for (;  wr != s; )
			{
                          wr += stream_ch_data_out.WriteEx(dataout, wr, s-wr, 1000);
			}
			stream_ch_data_out.Invalidate();
// окончание работы

                stream_ch_params.Close();
		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();
   }
	
}

















