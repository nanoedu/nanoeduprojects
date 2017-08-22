package mlab;
//17/06/19    waitfor error    repeat  error  scan
public class  scanlinnew
{
        public static final int pause = 50;
        static int X_POINTS = 50;
	static int Y_POINTS = 50;
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
	static  int USTEP_DLY= 400;
       	static  int USTEP_DLYBW=800;
    //methods
        static  int  Topography=0;
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

/*       public static int[] SetRate( int DELAY, int DELAYBW, int DiscrNumInMicroStep)   // st1 = +-1
	{
	  int[] res;
          res = new int[2];
          int LV;
          int LVBw;
          int LSnom;
  	  if (DELAY > DELAYBW)
           {
                 LSnom =((DiscrNumInMicroStep<<1) /DELAY)<<14;  //DiscrNumInMicroStep уже сдвинут на 16 при чтении
                 LV=  DiscrNumInMicroStep;//1<<16;                
                 LVBw=LV*DELAY/DELAYBW;
                 LV=-LV;
                 Simple.bramWrite( Simple.bramID("m_ustep"), LSnom );
           }
         else
           {
                LSnom =((DiscrNumInMicroStep<<1) /DELAYBW)<<14;  //DiscrNumInMicroStep уже сдвинут на 16 при чтении
                LVBw= DiscrNumInMicroStep;// 1<<16;
                LV=LVBw*DELAYBW/DELAY;
                LV=-LV;                
                Simple.bramWrite( Simple.bramID("m_ustep"), LSnom );
            }
           res[0]=LV;
           res[1]=LVBw;	 
           return(res);
	}	
*/	
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
         // +1 - лишняя точка, чтобы исключить передачу данных длиной,
        //  кратной 512 байт  
		JVIO stream_ch_data_out    = new JVIO(CH_DATA_OUT,SZ,X_POINTS*Y_POINTS+slowlines+SZ,JVIO.FIFO,fastlines, 0); // fastlines+1->fastlines  2
               // JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,SZ,(fastlines+1)*10,JVIO.FIFO,fastlines+1, 0); // 2
		JVIO stream_ch_params      = new JVIO(CH_PARAMS,  2, 1,JVIO.BUF,  1, 0);                        // 3
		JVIO stream_ch_linearsteps_in   = new JVIO(CH_LINEARSTEPS_IN ,X_POINTS+Y_POINTS+1, 1,JVIO.FIFO, 1, 0);   //4

       		int[] dataout;
	   	//dataout=new int[SZ*X_POINTS*Y_POINTS+slowlines];
	    //	dataout=new int[SZ*(fastlines+1)];
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

	        d_step_N = XMicrostepNmb;     // Кол-во микрошагов от точки к точке.
 		d_step = d_step_N * DAC_STEP; // Приращение ЦАП на шаге от точки к точке.

	       	dacX =Simple.bramRead(M_DACX) ;
             	dacY =Simple.bramRead(M_DACY) ;
        	dacZ =0;


                USTEP_DLY = buf_params[0];

                USTEP_DLYBW = buf_params[1];
/*
                 int Snom =((1<<17) /USTEP_DLY)<<14;
                 int V=  1<<16;
                 V=-V;
                 int Vbw=-V*USTEP_DLY/USTEP_DLYBW;
                 Simple.bramWrite( Simple.bramID("m_ustep"), Snom );
*/
              int[] resV;
              resV = new int[2];
              resV = SetRate.SetRate( USTEP_DLY,USTEP_DLYBW, DiscrNumInMicroStep) ; 
              int V=    resV[0];
              int Vbw = resV[1];

//////////////////////////////////////////////////////////////////////////
        	int[] path_in;
                int[] path_in2;
 	        int[] data_out;
		int[] data_out2;
 		int[] code;
                int[] code2d ;
               int codesz;
             	code2d = new int[22];

                code = new int[21];
 if (SZ==1)
 {
//----- Заголовок -- "2D point" --------------------
		code[0]  = Dxchg2.CODE_SIGNATURE;
		code[1]  = 0x00030002; //точка входа  3   глубина =2
		code[2]  = code.length;
// repeat
                code[3]= 0x80000000 + (7<<16) +fastlines;
// Считывание после паузы
                code[4] = 0x00000000 + (0<<16) + (19<<0);
                code[5] = 0x40000000 + pause - 1;

                code[6]= 0x80000000 + (3<<16) +0;
// конец


//----- Код ---движения по медленной оси------------------------------------
                // Вектор перемещения и позиция точки
                code[7]  = 0x00000000 + (14<<16) + (0<<0);
		code[8]  = 0x20000000;
		// Контроль перемещения
                code[9]  = 0x00000000;
		code[10]  = 0x10000008;
	 	// Считывание после паузы
                code[11] = 0x00000000 + (0<<16) + (19<<0);
                code[12] = 0x40000000 + pause - 1;
// Возврат
                code[13] = 0x80000000 + (7<<16) + 0;
//-------------------движения по медленной оси----------------------

//----- Список портов перемещения в точку ---------
		code[14] = 4;
		code[15] = Dxchg2.PORT_DIRY;
		code[16] = Dxchg2.PORT_DIRX;
		code[17] = Dxchg2.PORT_Y;
		code[18] = Dxchg2.PORT_X;
//----- Список портов получения результатов ------------------
		code[19] = 1;
           	code[20] = PORT_H;
//
}
else
{
 //----- Заголовок -- "2D point" --------------------
		code2d[0]  = Dxchg2.CODE_SIGNATURE;
		code2d[1]  = 0x00030002; //точка входа  3   глубина =2
		code2d[2]  = code2d.length;
// repeat

                code2d[3]= 0x80000000 + (7<<16) +fastlines;

         	// Считывание после паузы
                code2d[4] = 0x00000000 + (0<<16) + (19<<0);
                code2d[5] = 0x40000000 + pause - 1;
// Возврат
                code2d[6]= 0x80000000 + (3<<16) +0;
// конец


//----- Код ---движения по медленной оси------------------------------------
                // Вектор перемещения и позиция точки
                code2d[7]  = 0x00000000 + (14<<16) + (0<<0);
		code2d[8]  = 0x20000000;
		// Контроль перемещения
                code2d[9]  = 0x00000000;
		code2d[10]  = 0x10000008;
	 	// Считывание после паузы
                code2d[11] = 0x00000000 + (0<<16) + (19<<0);
                code2d[12] = 0x40000000 + pause - 1;
// Возврат
                code2d[13] = 0x80000000 + (7<<16) + 0;
//-------------------движения по медленной оси----------------------

//----- Список портов перемещения в точку ---------
		code2d[14] = 4;
		code2d[15] = Dxchg2.PORT_DIRY;
		code2d[16] = Dxchg2.PORT_DIRX;
		code2d[17] = Dxchg2.PORT_Y;
		code2d[18] = Dxchg2.PORT_X;
//----- Список портов получения результатов ------------------
		code2d[19] = 2;
           	code2d[20] = PORT_H;
                if (ScanMethod == Phase)  { code2d[21]= PORT_PH;}
                if (ScanMethod == I)      { code2d[21]= PORT_I;}
                if (ScanMethod == UAM)    { code2d[21]= PORT_ERR;}
}

 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                int[]  codebw = new int[23];

 /*               codebw[0]  = Dxchg2.CODE_SIGNATURE;             
                codebw[1]  = 0x00030002; //точка входа  3   глубина =2
		codebw[2]  = codebw.length;
// repeat
                codebw[3]= 0x80000000 + (4<<16) +1;

// перемещения в точку  x=0   fastline
                codebw[4]  = 0x00000000 + (16<<16) + (0<<0);
		codebw[5]  = 0x20000000;
// Контроль перемещения
                codebw[6]  = 0x00000000;
		codebw[7]  = 0x10000008;
//перемещения в точку  x=0 ;y=0
                codebw[8]  = 0x00000000 + (16<<16) + (0<<0);
		codebw[9]  = 0x20000000;
// Контроль перемещения
                codebw[10]  = 0x00000000;
		codebw[11]  = 0x10000008;
// Считывание после паузы
                codebw[12] = 0x00000000 + (0<<16) + (21<<0);
                codebw[13] = 0x40000000 + pause - 1;
// Возврат
                codebw[14]= 0x80000000 + (4<<16) +0;

// Возврат
                codebw[15]= 0x80000000 + (3<<16) +0;

//----- Список портов перемещения в точку ---------
		codebw[16] = 4;
		codebw[17] = Dxchg2.PORT_DIRY;
		codebw[18] = Dxchg2.PORT_DIRX;
		codebw[19] = Dxchg2.PORT_Y;
		codebw[20] = Dxchg2.PORT_X;
//----- Список портов получения результатов ------------------
		codebw[21] = 1;
           	codebw[22] = PORT_H;
*/ 
       
                codebw[0]  = Dxchg2.CODE_SIGNATURE;             
                codebw[1]  = 0x00030001; //точка входа  3   глубина =2
		codebw[2]  = codebw.length;
// repeat

// перемещения в точку  x=0   fastline
                codebw[3]  = 0x00000000 + (14<<16) + (0<<0);
		codebw[4]  = 0x20000000;
// Контроль перемещения
                codebw[5]  = 0x00000000;
		codebw[6]  = 0x10000008;
//перемещения в точку  x=0 ;y=0
                codebw[7]  = 0x00000000 + (14<<16) + (0<<0);
		codebw[8]  = 0x20000000;
// Контроль перемещения
                codebw[9]  = 0x00000000;
		codebw[10]  = 0x10000008;
// Считывание после паузы
                codebw[11] = 0x00000000 + (0<<16) + (19<<0);
                codebw[12] = 0x40000000 + pause - 1;
// Возврат
                codebw[13]= 0x80000000 + (3<<16) +0;

//----- Список портов перемещения в точку ---------
		codebw[14] = 4;
		codebw[15] = Dxchg2.PORT_DIRY;
		codebw[16] = Dxchg2.PORT_DIRX;
		codebw[17] = Dxchg2.PORT_Y;
		codebw[18] = Dxchg2.PORT_X;
//----- Список портов получения результатов ------------------
		codebw[19] = 1;
           	codebw[20] = PORT_H;

// конец

///
        path_in =new int[4*(fastlines)];
        data_out =new int[SZ*(fastlines+1)];

        int[]	path_inbw =new int[4*2];
        int[]  data_outbw =new int[SZ];

       // сканируем  только   один кадр

                slowlinescount=0;
        	fastlinescount=0;
//main cycle
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

                   resV = SetRate.SetRate( USTEP_DLY, USTEP_DLYBW, DiscrNumInMicroStep) ; 
                   V=    resV[0];
                   Vbw = resV[1];

                	rd=0;
			for (;  rd == 0; )
			{
				rd=stream_ch_stop.Read(buf_stop, 1,300,true);
			}

			if (buf_stop[0] == MakeSTOP)
			{
				break;
			}
                i=0;
 		for(point=0; point<fastlines; point++)
		{
		          if (  ScanPath == 0)    // X Mode; X - fast
		              {
                                 dacX +=JMPX[point];
                                 fastlinescount+=1;
                                 path_in[i++]=0;
                                 path_in[i++]=V;
                              }
              		      else    // Y Mode;   Y -fast
                              {
                                   dacY += JMPY[point];
                                   fastlinescount+=1;
                                   path_in[i++]=V;
                                   path_in[i++]=0;
                               }
                               path_in[i++]=dacY;
                               path_in[i++]=dacX;
        	}


//backward
			i=0;
                   if (  ScanPath == 0)
			             {
                                      dacX -= JMPX_SUM;
                                      path_inbw[i++]=0;
                                      path_inbw[i++]=Vbw;
                                     }
			 else        {
                                       dacY -= JMPY_SUM;
                                       path_inbw[i++]=Vbw;
                                       path_inbw[i++]=0;
                                      }

                               path_inbw[i++]=dacY;
                               path_inbw[i++]=dacX;
                        if ( lines > 1 )
                                  {
                                    if (  ScanPath == 0)
                                    {
                                        if  (ScanMethod != OneLine)
                                        {  dacY += JMPY[Y_POINTS-lines];}
                                        path_inbw[i++]=V;
                                        path_inbw[i++]=0;
                                     }
                                     else
                                     {
                                       if  (ScanMethod != OneLine)
                                        { dacX += JMPX[X_POINTS-lines];}
                                        path_inbw[i++]=0;
                                        path_inbw[i++]=V;
                                     }
                                  }
			     else {                                   // Go to Start Point по  оси slowlines
                                   if (  ScanPath == 0)
                                   {
                                       if  (ScanMethod != OneLine)
                                       {dacY -= (JMPY_SUM- JMPY[slowlines-1]);}
                                       path_inbw[i++]=Vbw;
                                       path_inbw[i++]=0;
                                   }
                                    else
                                    {
                                        if  (ScanMethod != OneLine)
                                        { dacX -= (JMPX_SUM- JMPX[slowlines-1]); }
                                     path_inbw[i++]=0;
                                     path_inbw[i++]=Vbw;
                                    }
			          }
                               path_inbw[i++]=dacY;
                               path_inbw[i++]=dacX;


	 	 if (SZ==1)    Dxchg2.ExecuteScan( path_in, data_out, code,   1);
                   else        Dxchg2.ExecuteScan( path_in, data_out, code2d, 1);

                       	wr=0;
   	//Simple.xchgCreate( "data", data_out );
	 		int s = fastlines+1;  // +1 чтобы размер данных был <> mod 512
			for (;  wr != s; )
			{
                          wr += stream_ch_data_out.WriteEx(data_out, wr, s-wr, 1000);
			}
			stream_ch_data_out.Invalidate();
                        
//backward
		//	Simple.Sleep(50);

                   Dxchg2.ExecuteScan( path_inbw, data_outbw, codebw, 1);


               }//lines

        	buf_drawdone[0]=done;

	//	Simple.DumpInt(done);

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

















