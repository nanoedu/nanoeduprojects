package mlab;

public class Fastscan
{

public static final int pause = 50; // пауза в точке mks
public static final int steps =64; // время перемещения между точками mks
///*************

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
	static final int PORT_DIR_X = ( 3 );
	static final int PORT_DIR_Y = ( 4 );
	static final int PORT_DIR_Z = ( 5 );
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
  		int i;
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
                int  Vbw;
                int  V;
                M_BASE_K =Simple.bramID("m_BaseK");;
                M_USTEP = Simple.bramID("m_ustep");;
                M_DACX   = Simple.bramID("dxchg_X");
                M_DACY   = Simple.bramID("dxchg_Y");
                //read parameters
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
 		d_step = d_step_N * DAC_STEP; // Приращение ЦАП на шаге от точки к точке.

	       	dacX =Simple.bramRead(M_DACX) ;
             	dacY =Simple.bramRead(M_DACY) ;
        	dacZ =0;
 /*

                USTEP_DLY = MicrostepDelay;//buf_params[0];

                USTEP_DLYBW = MicrostepDelayBW;//buf_params[1];

      		uVector =   (2 * DiscrNumInMicroStep / USTEP_DLY);

                uVectorBW = (2 * DiscrNumInMicroStep / USTEP_DLYBW);

     	        Simple.bramWrite( M_USTEP, uVector );
                */

//              Simple.fcupBypass(0,true); //turn off   FB     false???

  	int[] data_out;
		int[] data_in;
		int[] code;

		code = new int[17];
//----- Заголовок -- "2D point" --------------------
		code[0]  = Dxchg2.CODE_SIGNATURE;
		code[1]  = 0x00030001;
		code[2]  = code.length;
//----- Код ----------------------------------------
                // Вектор перемещения и позиция точки
                code[3]  = 0x00000000 + (10<<16) + (0<<0);
		code[4]  = 0x20000000;
		// Контроль перемещения
                code[5]  = 0x00000000;
		code[6]  = 0x10000008;
	 	// Считывание после паузы
                code[7] = 0x00000000 + (0<<16) + (15<<0);
                code[8] = 0x40000000 + pause - 1;
		// Возврат 
                code[9] = 0x80000000 + (3<<16) + 0;   
//----- Список портов перемещения в точку ---------
		code[10] = 4;
		code[11] = Dxchg2.OUTP_DIRY;
		code[12] = Dxchg2.OUTP_DIRX;
		code[13] = Dxchg2.OUTP_Y;
		code[14] = Dxchg2.OUTP_X;
//----- Список портов результатов ------------------
		code[15] = 1;
		code[16] = 5;
//--------------------------------------------------

		int Grid = 0x00800000; // шаг сетки
		int Snom = 0x028F5C29; // 1.0/50 - просто выбрано число 50
		int Vtrvl_nom = 0x19000000; // Snom*Vtrvl = Grid, за 1 шаг
		int Vtrvl = Vtrvl_nom / steps;

     		Simple.bramWrite( Simple.bramID("m_ustep"), Snom );
     		int N=100;
int P=100;
		data_in = new int[N*P*1]; // список #15 в каждой точке

		data_out = new int[N*P*4]; // список #10 в каждой точке

		 i = 0;
		for ( int y = 0; y < N; ++y ) // по Y
		{
			for ( int x = 0; x < P; ++x ) // по X
			{
				if ( x == 0 )
				{
					if ( y == 0 )
						data_out[i++] = -Vtrvl * 10;
					else
						data_out[i++] = Vtrvl;
					data_out[i++] = -Vtrvl * 10;
				}
				else
				{
					data_out[i++] = 0;
					data_out[i++] = Vtrvl;
				}
				data_out[i++] = Grid*y;
				data_out[i++] = Grid*x;
			}
		}

		Dxchg2.ExecuteScan( data_out, data_in, code, N*P );
	


          //send scan data
			int s = slowlines*fastlines +1;  // +1 чтобы размер данных был <> mod 512
	              	wr=0;
 	        	for (;  wr != s; )
			{
                          wr += stream_ch_data_out.WriteEx(data_out, wr, s-wr, 1000);
			}
			stream_ch_data_out.Invalidate();


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

















