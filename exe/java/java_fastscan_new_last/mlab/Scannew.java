package mlab;  // fastscan
//15/12/16  change scan algorithm
//err
//16/11/28 waitfor error 
//19/10/16 changed buffer
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
                int err;
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
                int  stepdelay;
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
                stepdelay=100;
		datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

		X_POINTS        =     datain[i0];
		Y_POINTS        =     datain[i0+1];
		ScanPath        =     datain[i0+2];
		SZ              =     1; //datain[i0+3];
		ScanMethod      =     datain[i0+4];
		MicrostepDelay  =     datain[i0+5];
		MicrostepDelayBW=     datain[i0+6];
		DiscrNumInMicroStep=  datain[i0+7] << 16;
		XMicrostepNmb   =    -datain[i0+8]; //<< **
		YMicrostepNmb   =    -datain[i0+9]; //<< **
               // stepdelay       =     datain[i0+11]; //add 05.12.16

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
             // +1 - лишн€€ точка, чтобы исключить передачу данных длиной,
             //  кратной 512 байт
               JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,SZ,fastlines*slowlines+ 1,JVIO.FIFO,fastlines*slowlines+ 1, 0); // 2
               JVIO stream_ch_params    = new JVIO(CH_PARAMS,  2, 1,JVIO.BUF,  1, 0);                        // 3

       		int[] dataout;

		dataout=new int[fastlines*slowlines+1];

		int[] buf_stop;
		buf_stop = new int[1];
		buf_stop[0] =0;
		wr = stream_ch_stop.Write(buf_stop, 1, 1000);
		stream_ch_stop.Invalidate();

		int[] buf_drawdone;
		buf_drawdone = new int[1];
		buf_drawdone[0] =0;
		wr = stream_ch_drawdone.Write(buf_drawdone, 1, 1000);
	        d_step_N = XMicrostepNmb;     //  ол-во микрошагов от точки к точке.
 		d_step = d_step_N * DAC_STEP; // ѕриращение ÷јѕ на шаге от точки к точке.

	       	dacX =Simple.bramRead(M_DACX) ;
             	dacY =Simple.bramRead(M_DACY) ;
        	dacZ =0;


                USTEP_DLY = MicrostepDelay;//buf_params[0];

                USTEP_DLYBW = MicrostepDelayBW;//buf_params[1];

      		uVector =   (2 * DiscrNumInMicroStep / USTEP_DLY);
               // if (uVector==0) uVector=1;

                uVectorBW = (2 * DiscrNumInMicroStep / USTEP_DLYBW);
              //  if (uVectorBW==0) uVectorBW=1;

     		Simple.bramWrite( M_USTEP, uVector );

//                Simple.fcupBypass(0,true); //turn off   FB     false???

                  err=1;
  boolean  oneframe=false;
   for (;;)
   {
                        if (err!=1)
                         {
                          if (!oneframe) break;
                         }
	// ÷икл сканировани€ по строкам.
        //     stop 
        	        rd=0;
			for (;  rd == 0; )
			{
			 rd=stream_ch_stop.Read(buf_stop, 1,300,true);
			}

			if (buf_stop[0] == MakeSTOP)
			{
			if (!oneframe) break;
			}
                  slowlinescount=0;
              	  dxchg = new Dxchg();
                  dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               -1,-1, -1} );

		for(lines=slowlines; lines>0; --lines)
		{
                        fastlinescount=0;
			for(point=0; point<fastlines; point++)
			{
		          dxchg.Goto( dacX,dacY,0);
                      	  dxchg.Wait( stepdelay); //100 microsec
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
                      //run backward

                        if (  ScanPath == 0)  {dacX -= fastlinescount*d_step;}
			 else                 {dacY -= fastlinescount*d_step;}

                        dxchg.Goto( dacX,dacY,0);
                        if ( lines > 1 )
                          {
                           if (  ScanPath == 0)
                           {
                            if (dacY>(MinY-d_step)){dacY += d_step;slowlinescount+=1;}
                           }
                           else
                           {
                            if (dacX>(MinX-d_step)){dacX += d_step;slowlinescount+=1;}
                           }
                          }
			  else
                          {
                            if (  ScanPath == 0)  dacY -= (slowlinescount)*d_step;         // Go to Start Point
			                     else dacX -= (slowlinescount)*d_step;
			  }
			 dxchg.Goto( dacX,dacY,0);
	}//y
		// run    scan
                       	Simple.bramWrite( M_USTEP, uVectorBW );
                      	dxchg.ExecuteScan();
         		err=dxchg.WaitScanComplete(20000);
	        	arr = dxchg.GetResults();
                      	src_i = 0;
                   	dst_i = 0;
		
              	// ќставл€ем в массиве только нужные данные.
	       for(int j=0; j<slowlines;j++)	
               	for(i=0; i<fastlines; i++)
			{
			       if (err==1)	dataout[dst_i] = arr[src_i];
                               else             dataout[dst_i] = 9999<<16;
			    dst_i += 1;
                            src_i += 1;
			}
               //send data
                    	wr=0;  rd=0;
			int s = slowlines*fastlines +1;  // +1 чтобы размер данных был <> mod 512
			for (;  wr != s; )
			{
                          wr += stream_ch_data_out.WriteEx(dataout, wr, s-wr, 1000);
			}
			stream_ch_data_out.Invalidate();
                        if (!oneframe)  { if (err!=1) break;       }
			else break;				
} //next frame
                if (err!=1)
                {
                 // «аписываем 0 в выходные порты COS дл€ остановки
		 // возможного перемещени€ по X,Y,Z (см.топологию).
                 dxchg = new Dxchg();
	       	 dxchg.SetO(PORT_COS_X, 0);
		 dxchg.SetO(PORT_COS_Y, 0);
	   	 dxchg.SetO(PORT_COS_Z, 0);
		 dxchg.ExecuteScan();
		 dxchg.WaitScanComplete(500);

		// ѕосле того, как сканирование остановлено (dxchg.ena==1)
		// можно считывать текущее состо€ние координат.
	       	 dacX = Simple.bramRead(M_DACX) ;
             	 dacY = Simple.bramRead(M_DACY) ;
                 dxchg = new Dxchg();
                 dxchg.SetO(PORT_X, dacX);
		 dxchg.SetO(PORT_Y, dacY);

         	 dxchg.ExecuteScan();
		 dxchg.WaitScanComplete(500);
                }
  // окончание работы

		buf_drawdone[0]=done;

  //              Simple.fcupBypass(0,false); //turn on  FB

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
                stream_ch_params.Close();
		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();
	}
}

















