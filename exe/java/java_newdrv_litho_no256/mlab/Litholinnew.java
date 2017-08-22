package mlab;// 17.06.26 edited

//16/11/17 new scheme
//error testing right java exit 16/11/15
//litholin new 12/05/16
// move to zero point 16.05.16
//correction backward direction 
public class Litholinnew
{
   	static int X_POINTS;// = 50;
   	static int Y_POINTS;// = 50;
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
	static  int USTEP_DLY= 400;
       	static  int USTEP_DLYBW=800;
        static int  pause=50;;
       	static  int ZUSTEP_DLY= 1;

	static  int M_BASE_K;// = 5;
        static  int M_USTEP;// = 21;
      	static  int M_ZUSTEP;
        static  int M_DACX;
        static  int M_DACY;
        static  int M_DACZ;

	static final int PORT_DIR_X = ( 3 );
	static final int PORT_DIR_Y = ( 4 );
	static final int PORT_DIR_Z = ( 5 );

	static final int PORT_X = ( 0 );
	static final int PORT_Y = ( 1 );
	static final int PORT_Z = ( 2 );

	static final int PORT_H = ( 2 );      //Z

	static final int PORT_CNTR = ( 5 );    //   timer

//	static final int PORT_uVector = ( Port.OUT | 6 );

//     	static final int PORT_ZuVector = ( Port.OUT | 6 );


        // chanels ID
	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;
	public static final int CH_DATA_OUT    = 2;
        public static final int CH_PARAMS      = 3;
	public static final int CH_LINEARSTEPS_IN     = 4;
	public static final int CH_DATA_IN     = 5;
	

        public static final int done=60;

        public static final int stop=100;

	public static final int MakeSTOP =1;

	public static void main(String[] arg)
	{
	    //	int[] arr;
		int i;
                int err;
                int timewait;
                int timewait_bw;
		int src_i;
		int dst_i;
                int s;
		int[] datain;
                int[] maskin;
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
              	int[] res;
		int[] dataout;
                int[] JMPX;
		int[] JMPY;
		int[] LINSTEPS;
		int  JMPX_SUM = 0;
                int  JMPY_SUM = 0;
                int V,Vbw,Snom;
                err=1;
                timewait=20000;
                timewait_bw=-1;

            //    Stopwatch timer;
            //    timer = new Stopwatch();
                M_BASE_K = Simple.bramID("m_BaseK");
                M_USTEP  = Simple.bramID("m_ustep");
                M_ZUSTEP = Simple.bramID("m_Z_ustep");
                M_DACX   = Simple.bramID("dxchg_X");
                M_DACY   = Simple.bramID("dxchg_Y");
                M_DACZ   = Simple.bramID("dxchg_Z");

		datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

		X_POINTS        =    datain[i0];
		Y_POINTS        =    datain[i0+1];
		ScanPath        =    datain[i0+2];
		SZ              =    datain[i0+3];
		ScanMethod      =    datain[i0+4];
		MicrostepDelay  =    datain[i0+5];
		MicrostepDelayBW=    datain[i0+6];
		DiscrNumInMicroStep= datain[i0+7]<< 16;
		XMicrostepNmb   =    -datain[i0+8]; //<<
		YMicrostepNmb   =    -datain[i0+9]; //<<
                Amplifier       =    datain[i0+10]; //<<
                dt              =    datain[i0+11]; //<<
//add 11/11/2016
//                twait           =    datain[i0+12];

              	//maskin=Simple.xchgGet("lithomask.bin"); //массив одномерный- правильно заполнить в дельфи

		maskin  = new int[X_POINTS * Y_POINTS+1];
		LINSTEPS= new int[X_POINTS + Y_POINTS+1];

                int fastlines=X_POINTS;
                int slowlines=Y_POINTS;
                if (ScanPath==1)
                {
                 fastlines=Y_POINTS;
                 slowlines=X_POINTS;
                }

		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,1,2*(X_POINTS*Y_POINTS),JVIO.FIFO,fastlines, 0);  // 2

                JVIO stream_ch_params    = new JVIO(CH_PARAMS, 4, 1,JVIO.BUF,  1, 0);                        // 3

		JVIO stream_ch_linearsteps_in   = new JVIO(CH_LINEARSTEPS_IN ,X_POINTS+Y_POINTS+1, 1,JVIO.FIFO, 1, 0);   //4
		JVIO stream_ch_data_in   = new JVIO(CH_DATA_IN ,X_POINTS*Y_POINTS+1, 1,JVIO.FIFO, 1, 0);   //5

		dataout = new int[(fastlines+1)];

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
                buf_params[2]=datain[i0+10];   //<<   ???    // amplifier
                buf_params[3]=datain[i0+11];                 // dt
                 wr=0;
//read parameters
                for (;  wr == 0; )
		{
                 wr = stream_ch_params.Write(buf_params, 1, 1000);
		}
		 rd=0;
                 for(;(rd!=1) ;)
                   {
                     rd = stream_ch_linearsteps_in.Read(LINSTEPS, 1,-1,false);
                   }

		 rd=0;
//read litho matrix
                 for(;(rd!=1) ;)
                   {
                     rd = stream_ch_data_in.Read(maskin, 1,-1,false);
                   }
//
		JMPX = new int[X_POINTS];
                JMPY = new int[Y_POINTS];

                for (i=0; i<X_POINTS; i++) { JMPX[i] = - LINSTEPS[i] *  DAC_STEP;
                                            JMPX_SUM = JMPX_SUM + JMPX[i];
                                          }
                for (i=0; i<Y_POINTS; i++) { JMPY[i] = - LINSTEPS[i+X_POINTS] * DAC_STEP;
                                            JMPY_SUM = JMPY_SUM + JMPY[i];
                                          }

	       //  d_step_N =  XMicrostepNmb;     // Кол-во микрошагов от точки к точке.

		USTEP_DLY =  MicrostepDelay;

		d_step = XMicrostepNmb * DAC_STEP; // Приращение ЦАП на шаге от точки к точке.


                ZUSTEP_DLY = 5;


            //   	ZuVector = (2 * 0x01000000 / ZUSTEP_DLY);         //jump 100     ??????

              	ZuVector = ((1<<17)/ ZUSTEP_DLY)<<14;

                int Vz=(1<<24);

               	Simple.bramWrite( M_ZUSTEP, ZuVector );        //z speed  moving


        //     Цикл сканирования по строкам.


                      	dacX =Simple.bramRead(M_DACX) ;
	             	dacY =Simple.bramRead(M_DACY) ;
	         	dacZ =0;

                  USTEP_DLY = buf_params[0];

                USTEP_DLYBW = buf_params[1];

                 Snom =((1<<17) /USTEP_DLY)<<14;
                 V=  1<<16;
                 V=-V;
                 Vbw=-V*USTEP_DLY/USTEP_DLYBW;
                 Simple.bramWrite( Simple.bramID("m_ustep"), Snom );


                     // set  speed z??????????????


//////////////////////////////////////////////////////////////////////////
        	int[] path_in;
                int[] path_in2;
 	        int[] data_out;
 		int[] code;
                int[] code2 ;
               	code2 = new int[23];
                code  = new int[34];
//----- Заголовок -- "2D point" --------------------
		code[0]  = Dxchg2.CODE_SIGNATURE;
		code[1]  = 0x00030002; //точка входа  3   глубина =2
		code[2]  = code.length;
// repeat

                code[3]= 0x80000000 + (5<<16)  +fastlines;      //forward
           //-------------------end----
                code[4]= 0x80000000 + (3<<16)  +0;

// Вектор перемещения и позиция точки
                code[5]  = 0x00000000 + (22<<16) + (0<<0);
		code[6]  = 0x20000000;
		// Контроль перемещения
                code[7]  = 0x00000000;
		code[8]  = 0x10000008;    //?????
                // Считывание после паузы
                code[9]  = 0x00000000 + (0<<16) + (27<<0);
                code[10] = 0x40000000 + pause - 1;
// перемещения по z dz
                code[11]  = 0x00000000 + (29<<16) + (0<<0);
		code[12]  = 0x20000000;
		// Контроль перемещения
                code[13]  = 0x00000000;
		code[14]  = 0x10000008;
 // пауза после перемещения по z  береться из dataout

                code[15]  = 0x00008000 + (32<<16) + (0<<0);  //pause from dataout
		code[16]  = 0x00000000;

// перемещения по z -dz
                code[17]  = 0x00000000 + (29<<16) + (0<<0);
		code[18]  = 0x20000000;
		// Контроль перемещения
                code[19]  = 0x00000000;
		code[20]  = 0x10000008;
// Возврат
                code[21] = 0x80000000 + (5<<16) + 0;

//----- Список портов перемещения в точку ---------
		code[22] = 4;
		code[23] = Dxchg2.PORT_DIRY;
		code[24] = Dxchg2.PORT_DIRX;
		code[25] = Dxchg2.PORT_Y;
		code[26] = Dxchg2.PORT_X;

//----- Список портов получения результатов ------------------
		code[27] = 1;
           	code[28] = Dxchg2.PORT_H;
//

//----- Список портов перемещения в точку z  dz-------
		code[29] = 2;
		code[30] = Dxchg2.PORT_DIRZ;
		code[31] = Dxchg2.PORT_Z;
// список портов ожидание воздействия

		code[32] = 1;
		code[33] = -1;


//  code backward
//

//----- Заголовок -- "2D point" --------------------
		code2[0]  = Dxchg2.CODE_SIGNATURE;
		code2[1]  = 0x00030002; //точка входа  3   глубина =2
		code2[2]  = code2.length;
// repeat
                code2[3]  = 0x80000000 + (9<<16) +fastlines;

//перемещения в точку next line
                code2[4]  = 0x00000000 + (16<<16) + (0<<0);
		code2[5]  = 0x20000000;
		// Контроль перемещения
                code2[6]  = 0x00000000;
		code2[7]  = 0x10000008;
// Возврат
                code2[8]  = 0x80000000 + (3<<16) +0;
// конец


//----- Код ---движения по Быстрой оси------------------------------------
                // Вектор перемещения и позиция точки
                code2[9]   = 0x00000000 + (16<<16) + (0<<0);
		code2[10]  = 0x20000000;
		// Контроль перемещения
                code2[11]  = 0x00000000;
		code2[12]  = 0x10000008;
	 	// Считывание после паузы
                code2[13]  = 0x00000000 + (0<<16) + (21<<0);
                code2[14]  = 0x40000000 + pause - 1;
// Возврат
                code2[15]  = 0x80000000 + (9<<16) + 0;
//-------------------движения по медленной оси----------------------

//----- Список портов перемещения в точку ---------
		code2[16] = 4;
		code2[17] = Dxchg2.PORT_DIRY;
		code2[18] = Dxchg2.PORT_DIRX;
		code2[19] = Dxchg2.PORT_Y;
		code2[20] = Dxchg2.PORT_X;
//----- Список портов получения результатов ------------------
		code2[21] = 1;
           	code2[22] = Dxchg2.PORT_H;

                
            int   slowlinescount=0;
            int   fastlinescount=0;
            path_in  =new int[9*(fastlines)];
            path_in2 =new int[4*(fastlines+1)];
            data_out =new int[fastlines];


            i=0;
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
                           Amplifier    = buf_params[2];
                           dt           = buf_params[3];
                           USTEP_DLY    = buf_params[0];
                           USTEP_DLYBW = buf_params[1];

                  Snom =((1<<17) /USTEP_DLY)<<14;
                  V=1<<16;
                  V=-V;
                  Vbw=-V*USTEP_DLY/USTEP_DLYBW;
                  Simple.bramWrite( Simple.bramID("m_ustep"), Snom );
                   i=0;
                    for(point=0; point<fastlines; point++)  //forward
		     {
                         if (Amplifier > 0) dacZ =maskin[( slowlines- lines)*fastlines+point]*Amplifier;
                         else               dacZ =-maskin[( slowlines- lines)*fastlines+point]/Amplifier;

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

                               path_in[i++]=-Vz;
                               path_in[i++]=-dacZ;

                              if  (dacZ!=0)
                              {
                               path_in[i++]=dt;
                              }
                              else
                              {
                               path_in[i++]=0;
                              }
                               path_in[i++]=Vz;
                               path_in[i++]=0;
               		}
                  }
                        Dxchg2.ExecuteScan( path_in, data_out, code,   1);

                    	wr=0;  rd=0;
			s = fastlines;
			for (;  wr != s; )
			{
			   wr += stream_ch_data_out.WriteEx(data_out, wr, s-wr, 1000);
			}
                      	stream_ch_data_out.Invalidate();


    //backward          Ok
                 i=0;
 	       	for(point=0; point<fastlines; point++)
			{
                           if (  ScanPath == 0)    // X Mode; X - fast
		              {
                                 dacX -= JMPX[fastlines-1-point];;
                                 fastlinescount+=1;
                                 path_in2[i++]=0;
                                 path_in2[i++]=Vbw;
                              }
              		      else    // Y Mode;   Y -fast
                              {
                                   dacY -= JMPY[fastlines-1-point];
                                   fastlinescount+=1;
                                   path_in2[i++]=Vbw;
                                   path_in2[i++]=0;
                               }
                               path_in2[i++]=dacY;
                               path_in2[i++]=dacX;
        		}
                     if ( lines > 1 )
                                  {
                                    if (  ScanPath == 0)
                                    {
                                        dacY += JMPY[slowlines-lines];
                                        slowlinescount+=1;
                                        path_in2[i++]=V;
                                        path_in2[i++]=0;
                                     }
                                     else
                                     {
                                        dacX += JMPX[slowlines-lines];
                                        slowlinescount+=1;
                                        path_in2[i++]=0;
                                        path_in2[i++]=V;
                                     }
                                  }
			     else {                                   // Go to Start Point по  оси slowlines
                                   if (  ScanPath == 0)
                                   {
                                       dacY -= (JMPY_SUM- JMPY[slowlines-1]);
                                       path_in2[i++]=Vbw;
                                       path_in2[i++]=0;
                                   }
                                    else
                                    {
                                     dacX -= (JMPX_SUM- JMPX[slowlines-1]);
                                     path_in2[i++]=0;
                                     path_in2[i++]=Vbw;
                                    }
			          }
                               path_in2[i++]=dacY;
                               path_in2[i++]=dacX;
                               
                              Dxchg2.ExecuteScan( path_in2, data_out, code2,   1);
   	          	wr=0;  rd=0;
			 s = fastlines;
			for (;  wr != s; )
			{
				wr += stream_ch_data_out.WriteEx(data_out, wr, s-wr, 1000);
			}

			stream_ch_data_out.Invalidate();
     	}//y                                 next lines

		buf_drawdone[0]=done;

//               	ZuVector = ((1<<17)/ ZUSTEP_DLY)<<14;


//               	Simple.bramWrite( M_ZUSTEP, ZuVector );        //z speed  moving

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
		stream_ch_data_in.Close();
		stream_ch_linearsteps_in.Close();
	}
}

















