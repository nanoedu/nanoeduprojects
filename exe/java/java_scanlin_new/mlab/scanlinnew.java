package mlab;
//16/11/28   waitfor error    repeat  error  scan
public class  scanlinnew
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
    //
        static  final int SEM=3;  // SEM unit
	static  int M_BASE_K;// = 5;
	static  int M_USTEP;// = 21;
        static  int M_DACX;
        static  int M_DACY;
      //  static  int M_DACZ;
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
	public static final int CH_LINEARSTEPS_IN     = 4;

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
                int dacX0;
		int dacY0;
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
                int  lineshift;

                int[] JMPX;
		int[] JMPY;
		int[] LINSTEPS;
		int  JMPX_SUM = 0;
                int  JMPY_SUM = 0;
               //new
              	Dxchg dxchg;
                err=1;
                M_BASE_K =Simple.bramID("m_BaseK");;
                M_USTEP = Simple.bramID("m_ustep");;
                M_DACX   = Simple.bramID("dxchg_X");
                M_DACY   = Simple.bramID("dxchg_Y");

		datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

		X_POINTS        =     datain[i0];
		Y_POINTS        =     datain[i0+1];
		ScanPath        =     datain[i0+2];
		SZ              =     datain[i0+3];
		ScanMethod      =     datain[i0+4];
		MicrostepDelay  =     datain[i0+5];
		MicrostepDelayBW=     datain[i0+6];
		DiscrNumInMicroStep=  datain[i0+7] << 16;
		XMicrostepNmb   =    -datain[i0+8]; //<< **
		YMicrostepNmb   =    -datain[i0+9]; //<< **
                lineshift       =     datain[i0+10];
                // JMPX
                // JMPY

		LINSTEPS= new int[X_POINTS + Y_POINTS+1];

        //    	flgUnit         =    datain[10];

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
                if  (ScanMethod != OneLine)
                  {
                     JMPX_SUM = JMPX_SUM- lineshift;
                     JMPY_SUM = JMPY_SUM- lineshift;
                  }
		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
         // +1 - лишн€€ точка, чтобы исключить передачу данных длиной,
        //  кратной 512 байт
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,SZ,X_POINTS*Y_POINTS+slowlines+SZ,JVIO.FIFO,fastlines, 0); // fastlines+1->fastlines  2
               // JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,SZ,(fastlines+1)*10,JVIO.FIFO,fastlines+1, 0); // 2
		JVIO stream_ch_params    = new JVIO(CH_PARAMS,  2, 1,JVIO.BUF,  1, 0);                        // 3
		JVIO stream_ch_linearsteps_in   = new JVIO(CH_LINEARSTEPS_IN ,X_POINTS+Y_POINTS+1, 1,JVIO.FIFO, 1, 0);   //4

       		int[] dataout;
	   	//dataout=new int[SZ*X_POINTS*Y_POINTS+slowlines];
		dataout=new int[SZ*(fastlines+1)];
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
                buf_params[0]=datain[i0+5]  ;    // speed foreward
                buf_params[1]=datain[i0+6];      // speed backward

                 wr=0;
                for (;  wr == 0; )
		{
                 wr = stream_ch_params.Write(buf_params, 1, 1000);
		}
		 rd=0;
                 for(;(rd!=1) ;)
                   {
                     rd = stream_ch_linearsteps_in.Read(LINSTEPS, 1,-1,false);
                   }
		JMPX = new int[X_POINTS];
                JMPY = new int[Y_POINTS];

                for (i=0; i<X_POINTS; i++) { JMPX[i] = - LINSTEPS[i] *  DAC_STEP;
                                            JMPX_SUM = JMPX_SUM + JMPX[i];
                                          }
                for (i=0; i<Y_POINTS; i++) { JMPY[i] = - LINSTEPS[i+X_POINTS] * DAC_STEP;
                                            JMPY_SUM = JMPY_SUM + JMPY[i];
                                          }

	        d_step_N = XMicrostepNmb;     //  ол-во микрошагов от точки к точке.
 		d_step = d_step_N * DAC_STEP; // ѕриращение ÷јѕ на шаге от точки к точке.

	       	dacX =Simple.bramRead(M_DACX) ;
             	dacY =Simple.bramRead(M_DACY) ;
        	dacZ =0;


                USTEP_DLY = buf_params[0];

                USTEP_DLYBW = buf_params[1];

      		uVector =   (2 * DiscrNumInMicroStep / USTEP_DLY);

                uVectorBW = (2 * DiscrNumInMicroStep / USTEP_DLYBW);

     		Simple.bramWrite( M_USTEP, uVector );

                slowlinescount=0;
		// ÷икл сканировани€ по строкам.
		for(lines=slowlines; lines>0; --lines)
		{
                        fastlinescount=0;
                       //   read buffers params
			rd=0;
		       for (;  rd == 0; )
			{
			 rd = stream_ch_params.Read(buf_params, 1,200,true);
			}
                         USTEP_DLY = buf_params[0];

                       USTEP_DLYBW = buf_params[1];

                  uVector = (2 * DiscrNumInMicroStep / USTEP_DLY);

                uVectorBW = (2 * DiscrNumInMicroStep / USTEP_DLYBW);


                	rd=0;
			for (;  rd == 0; )
			{
				rd=stream_ch_stop.Read(buf_stop, 1,300,true);
			}

			if (buf_stop[0] == MakeSTOP)
			{
				break;
			}

                       	dxchg = new Dxchg();
                     	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                                       PORT_Y,PORT_COS_Y, dacY,
         	                                      -1,-1, -1} );
                	 dacX0 = Simple.bramRead(M_DACX) ;
             	         dacY0 = Simple.bramRead(M_DACY) ;

			for(point=0; point<fastlines; point++)
			{
		          dxchg.Goto( dacX,dacY,0);
                      	  dxchg.Wait( 100 );
			  dxchg.GetI( PORT_H   );
                          dxchg.GetI( PORT_PH  );
                          if (ScanMethod!=I) { dxchg.GetI( PORT_ERR );}
                                        else { dxchg.GetI( PORT_I );}
  			      if (  ScanPath == 0)                    // X Mode
				           {if (dacX>(MinX-d_step))
                                             {dacX += JMPX[point];fastlinescount+=1;}
                                           }
              				 else
                                           {if (dacY>(MinY-d_step))
                                             {dacY += JMPY[point];fastlinescount+=1;}
                                           }  // Y Mode
			}
                      	// run   foreward line
                       	Simple.bramWrite( M_USTEP, uVector );
        		dxchg.ExecuteScan();
                        err=dxchg.WaitScanComplete(-1);
                        /************************       
                        if(err!=1)
                        {
                  //    REPEAT SCAN
                         dxchg = new Dxchg();
        	       	 dxchg.SetO(PORT_COS_X, 0);
	                 dxchg.SetO(PORT_COS_Y, 0);
        	   	 dxchg.SetO(PORT_COS_Z, -1);
	                 int dacXc=Simple.bramRead(M_DACX) ;
                   	 int dacYc=Simple.bramRead(M_DACY) ;
        		// ѕосле того, как сканирование остановлено (dxchg.ena==1)
	        	// можно считывать текущее состо€ние координат.
	                 dxchg = new Dxchg();
                         dxchg.SetO(PORT_X, dacXc);
	        	 dxchg.SetO(PORT_Y, dacYc);
                         dxchg.SetO(PORT_Z, -1);
                 	 dxchg.ExecuteScan();
	        	 dxchg.WaitScanComplete(500);
                         //move to start x0,y0 point
                          dxchg = new Dxchg();

                          if (  ScanPath == 0)   dacX = dacX0;     // X Mode
               		        	 else    dacY = daxY0;     // Y Mode
                          dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                                         PORT_Y,PORT_COS_Y, dacY,
         	                                        -1,-1, -1} );
                          dxchg.Goto( dacX,dacY,0);
                      	  dxchg.Wait( 100 );
			  dxchg.GetI( PORT_H   );
                          dxchg.GetI( PORT_PH  );
                          if (ScanMethod!=I) { dxchg.GetI( PORT_ERR );}
                                        else { dxchg.GetI( PORT_I );}
                      	// repeat  foreward line
                       	    Simple.bramWrite( M_USTEP, uVector );
        		    dxchg.ExecuteScan();
                            err=dxchg.WaitScanComplete(-1);
                        }
                        *****************************/
	        	arr = dxchg.GetResults();
       			src_i = 0;
			dst_i = 0;
                       	// ќставл€ем в массиве только нужные данные.
			for(i=0; i<fastlines; i++)
			{
			  //  dataout[dst_i]  = arr[src_i];
                            if (err==1)	dataout[dst_i] = arr[src_i];
                               else     dataout[dst_i] = 1<<16;
                            if (SZ==2)
                              {
                                if (ScanMethod == Phase) {dataout[dst_i+1] =arr[src_i+1];}
                                if ((ScanMethod == I) | (ScanMethod == UAM))  {dataout[dst_i+1] =arr[src_i+2];}
                              }
			    if (SZ==1)	{dst_i += 1;}
                            else        {dst_i += 2;}
				src_i += 3;
			}
			dataout[fastlines*SZ] = 0;

                	wr=0;  rd=0;
			int s = fastlines +1;//  +1 - лишн€€ точка, чтобы исключить передачу данных длиной,
                                             //  кратной 512 байт

			for (;  wr != s; )
			{
                          wr += stream_ch_data_out.WriteEx(dataout, wr, s-wr, 1000);
			}
			stream_ch_data_out.Invalidate();
                        if (err!=1) break;
                       	dxchg = new Dxchg();
                     	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               -1,-1, -1} );
                        if (  ScanPath == 0) {dacX -= JMPX_SUM;}
			 else                {dacY -= JMPY_SUM;}

                        dxchg.Goto( dacX,dacY,0);
                        if  (ScanMethod != OneLine)
                        {
		             if ( lines > 1 )   // ѕереход к следующей строке
                                  {
                                   if (  ScanPath == 0)
                                   {if (dacY>(MinY-d_step)){dacY += JMPY[Y_POINTS-lines];slowlinescount+=1;}}
                                    else {if (dacX>(MinX-d_step)){dacX += JMPX[X_POINTS-lines];slowlinescount+=1;}}

                                  }

			     else {
                                   if (  ScanPath == 0)  dacY -= (JMPY_SUM- JMPY[slowlines-1]);         //¬озврат в начальную точку
                		                  else   dacX -= (JMPX_SUM- JMPX[slowlines-1]);
			          }
			 dxchg.Goto( dacX,dacY,0);
                        }
 			// run    backward
                       	Simple.bramWrite( M_USTEP, uVectorBW );
                      	dxchg.ExecuteScan();
         		err=dxchg.WaitScanComplete(-1);
                        if (err!=1)break;
 		}//y
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
		// ѕеремещаем координату Z в нулевое положение.
                }

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
                  for(;(buf_stop[0]!=stop) ;)
                {
                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);
                  ccnt+=1;
                }
                stream_ch_params.Close();
		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();
		stream_ch_linearsteps_in.Close();
	}

}

















