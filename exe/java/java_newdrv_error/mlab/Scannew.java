package mlab;    // 19.06.17
                 // oneline+; discrtinmicrostep
                 //  need test additional element in buffer (  <> mod 512)

public class Scannew
{
 public static final int pause = 50; // пауза в точке mks
 public static final int steps = 64; // время перемещения между точками mks
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


       M_BASE_K =Simple.bramID("m_BaseK");;
       M_USTEP = Simple.bramID("m_ustep");;
       M_DACX   = Simple.bramID("dxchg_X");
       M_DACY   = Simple.bramID("dxchg_Y");

//		datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

		X_POINTS        =  82;//   datain[i0];
		Y_POINTS        =  82;//   datain[i0+1];
		ScanPath        =  0; //  datain[i0+2];
		SZ              =  1;//   datain[i0+3];
		ScanMethod      =  0;//   datain[i0+4];
		MicrostepDelay  = 460;//   datain[i0+5];
		MicrostepDelayBW=  230;//   datain[i0+6];
		DiscrNumInMicroStep=1<<16;//  datain[i0+7] << 16;
		XMicrostepNmb   =-30;//    -datain[i0+8]; //<< **
		YMicrostepNmb   =-30;//    -datain[i0+9]; //<< **

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

//for (i=0;i<10; i++)  { Simple.DumpInt(datain[i]);}

		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
             // +1 - лишняя точка, чтобы исключить передачу данных длиной,
             //  кратной 512 байт
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,SZ,X_POINTS*Y_POINTS/*+ slowlines+SZ*/,JVIO.FIFO,fastlines, 0); // 2
		JVIO stream_ch_params    = new JVIO(CH_PARAMS,  2, 1,JVIO.BUF,  1, 0);                        // 3

       //		int[] dataout;
	   	//dataout=new int[SZ*X_POINTS*Y_POINTS];
	 //	dataout=new int[SZ*(fastlines +1)];

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
                buf_params[0]=460;//datain[i0+5]  ;    // speed foreward
                buf_params[1]=230;//datain[i0+6];      // speed backward

                 wr=0;
                for (;  wr == 0; )
		{
                 wr = stream_ch_params.Write(buf_params, 1, 1000);
		}


	        d_step_N = XMicrostepNmb;     // Кол-во микрошагов от точки к точке.
 		d_step = d_step_N * DAC_STEP; // Приращение ЦАП на шаге от точки к точке.

	       	dacX =Simple.bramRead(M_DACX) ;
             	dacY =Simple.bramRead(M_DACY) ;
        	dacZ =0;


                USTEP_DLY = buf_params[0];

                USTEP_DLYBW = buf_params[1];

                slowlinescount=0;
            //
            ///***********************************************************************
           /*	int Snom = 0x028F5C29; // 1.0/50 - просто выбрано число 50
		int Vtrvl_nom = 0x19000000; // Snom*Vtrvl = Grid, за 1 шаг
	        int V = Vtrvl_nom / 320;
                int Vbw=-10*V;
     		Simple.bramWrite( Simple.bramID("m_ustep"), Snom );
                int Grid = 0x00800000;
            */

                 int Snom =((1<<17) /USTEP_DLY)<<14;
                 int V=  1<<16;
                 V=-V;
                 int Vbw=-V*USTEP_DLY/USTEP_DLYBW;
                 Simple.bramWrite( Simple.bramID("m_ustep"), Snom );


//////////////////////////////////////////////////////////////////////////
        	int[] path_in;
 	        int[] data_out;
 		int[] code;
                int[] code2d ;
               int codesz;
               	code2d = new int[28];
                code = new int[27];
 if (SZ==1)
 {
//----- Заголовок -- "2D point" --------------------
		code[0]  = Dxchg2.CODE_SIGNATURE;
		code[1]  = 0x00030002; //точка входа  3   глубина =2
		code[2]  = code.length;
// repeat

                code[3]= 0x80000000 + (13<<16) +fastlines;

// перемещения в точку  x=0   fastline
                code[4]  = 0x00000000 + (20<<16) + (0<<0);
		code[5]  = 0x20000000;
		// Контроль перемещения
                code[6]  = 0x00000000;
		code[7]  = 0x10000008;
 //перемещения в точку  x=0 ;y=0
                code[8]  = 0x00000000 + (20<<16) + (0<<0);
		code[9]  = 0x20000000;
		// Контроль перемещения
                code[10]  = 0x00000000;
		code[11]  = 0x10000008;
// Возврат
                code[12]= 0x80000000 + (3<<16) +0;
// конец


//----- Код ---движения по медленной оси------------------------------------
                // Вектор перемещения и позиция точки
                code[13]  = 0x00000000 + (20<<16) + (0<<0);
		code[14]  = 0x20000000;
		// Контроль перемещения
                code[15]  = 0x00000000;
		code[16]  = 0x10000008;
	 	// Считывание после паузы
                code[17] = 0x00000000 + (0<<16) + (25<<0);
                code[18] = 0x40000000 + pause - 1;
// Возврат
                code[19] = 0x80000000 + (13<<16) + 0;
//-------------------движения по медленной оси----------------------

//----- Список портов перемещения в точку ---------
		code[20] = 4;
		code[21] = Dxchg2.PORT_DIRY;
		code[22] = Dxchg2.PORT_DIRX;
		code[23] = Dxchg2.PORT_Y;
		code[24] = Dxchg2.PORT_X;
//----- Список портов получения результатов ------------------
		code[25] = 1;
           	code[26] = PORT_H;
//
}
else
{
 //----- Заголовок -- "2D point" --------------------
		code2d[0]  = Dxchg2.CODE_SIGNATURE;
		code2d[1]  = 0x00030002; //точка входа  3   глубина =2
		code2d[2]  = code2d.length;
// repeat

                code2d[3]= 0x80000000 + (13<<16) +fastlines;

// перемещения в точку  x=0   fastline
                code2d[4]  = 0x00000000 + (20<<16) + (0<<0);
		code2d[5]  = 0x20000000;
		// Контроль перемещения
                code2d[6]  = 0x00000000;
		code2d[7]  = 0x10000008;
 //перемещения в точку  x=0 ;y=0
                code2d[8]  = 0x00000000 + (20<<16) + (0<<0);
		code2d[9]  = 0x20000000;
		// Контроль перемещения
                code2d[10]  = 0x00000000;
		code2d[11]  = 0x10000008;
// Возврат
                code2d[12]= 0x80000000 + (3<<16) +0;
// конец


//----- Код ---движения по медленной оси------------------------------------
                // Вектор перемещения и позиция точки
                code2d[13]  = 0x00000000 + (20<<16) + (0<<0);
		code2d[14]  = 0x20000000;
		// Контроль перемещения
                code2d[15]  = 0x00000000;
		code2d[16]  = 0x10000008;
	 	// Считывание после паузы
                code2d[17] = 0x00000000 + (0<<16) + (25<<0);
                code2d[18] = 0x40000000 + pause - 1;
// Возврат
                code2d[19] = 0x80000000 + (13<<16) + 0;
//-------------------движения по медленной оси----------------------

//----- Список портов перемещения в точку ---------
		code2d[20] = 4;
		code2d[21] = Dxchg2.PORT_DIRY;
		code2d[22] = Dxchg2.PORT_DIRX;
		code2d[23] = Dxchg2.PORT_Y;
		code2d[24] = Dxchg2.PORT_X;
//----- Список портов получения результатов ------------------
		code2d[25] = 2;
           	code2d[26] = PORT_H;
                if (ScanMethod == Topography) { code2d[27]= 5;}
                if (ScanMethod == Phase)  { code2d[27]= PORT_PH;}
                if (ScanMethod == I)      { code2d[27]= PORT_I;}
                if (ScanMethod == UAM)    { code2d[27]= PORT_ERR;}
}

 //////////////////////////////////////////////////////////////////////

         path_in =new int[4*(fastlines+2)];
        data_out =new int[SZ*fastlines];

       // сканируем  только   один кадр

                slowlinescount=0;
        	fastlinescount=0;
//main cycle
 	    for(lines=slowlines; lines>0; --lines)
	       {
                       	fastlinescount=0;
                       //   read buffers params

                        Snom =((1<<17) /USTEP_DLY)<<14;

                        Vbw=-V*USTEP_DLY/USTEP_DLYBW;

               Simple.bramWrite( Simple.bramID("m_ustep"), Snom );

                i=0;
 		for(point=0; point<fastlines; point++)
			{
		          if (  ScanPath == 0)    // X Mode; X - fast
		              {
                                 dacX += d_step;
                                 fastlinescount+=1;
                                 path_in[i++]=0;
                                 path_in[i++]=V;
                              }
              		      else    // Y Mode;   Y -fast
                              {
                                   dacY += d_step;
                                   fastlinescount+=1;
                                   path_in[i++]=V;
                                   path_in[i++]=0;
                               }
                               path_in[i++]=dacY;
                               path_in[i++]=dacX;
        		}

                //backward
                        if (  ScanPath == 0)
			             {
                                      dacX -= fastlinescount*d_step;
                                      path_in[i++]=0;
                                      path_in[i++]=Vbw;
                                     }
			 else        {
                                       dacY -= fastlinescount*d_step;
                                       path_in[i++]=Vbw;
                                       path_in[i++]=0;
                                      }

                               path_in[i++]=dacY;
                               path_in[i++]=dacX;
                        if ( lines > 1 )
                                  {
                                    if (  ScanPath == 0)
                                    {
                                        if  (ScanMethod != OneLine)
                                        {  dacY += d_step;}
                                        slowlinescount+=1;
                                        path_in[i++]=V;
                                        path_in[i++]=0;
                                     }
                                     else
                                     {
                                       if  (ScanMethod != OneLine)
                                        { dacX += d_step;}
                                        slowlinescount+=1;
                                        path_in[i++]=0;
                                        path_in[i++]=V;
                                     }
                                  }
			     else {                                   // Go to Start Point по  оси slowlines
                                   if (  ScanPath == 0)
                                   {
                                       if  (ScanMethod != OneLine)
                                       {dacY -= (slowlinescount)*d_step;}
                                       path_in[i++]=Vbw;
                                       path_in[i++]=0;
                                   }
                                    else
                                    {
                                        if  (ScanMethod != OneLine)
                                        { dacX -= (slowlinescount)*d_step; }
                                     path_in[i++]=0;
                                     path_in[i++]=Vbw;
                                    }
			          }
                               path_in[i++]=dacY;
                               path_in[i++]=dacX;

                   if (SZ==1)    Dxchg2.ExecuteScan( path_in, data_out, code,   1);
                   else          Dxchg2.ExecuteScan( path_in, data_out, code2d, 1);

                	wr=0;

			int s = fastlines;  // +1 чтобы размер данных был <> mod 512
			for (;  wr != s; )
			{
                          wr += stream_ch_data_out.WriteEx(data_out, wr, s-wr, 1000);
			}
			stream_ch_data_out.Invalidate();


               }//lines


		buf_drawdone[0]=done;

                stream_ch_params.Close();
		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();
	}

}

















