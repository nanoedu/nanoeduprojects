package mlab; //19/06/17

public class movetonew
{
	static final int DAC_STEP = 65536*1;
        static final int pause =50;
	static final int VAL_0_5  = 0x40000000;
	static  int USTEP_DLY= 400;
       // static  unint pow_2_31 = 131072;//0x80000000;

	static final int M_BASE_K = 5;

	static final int M_USTEP = 21;
        static  int M_DACX;
        static  int M_DACY;


        // chanels ID

	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;

        public static final int done=60;

        public static final int stop=100;

	public static final int MakeSTOP =1;

      	public static final int move =200;
       
         static final int PORT_H   = ( 2 );

	public static void main(String[] arg)
	{
		int i;
		int[] datain;
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
                int[] res;
		int  ScanPath;
		int  SZ;
		int  ScanMethod;
		int  MicrostepDelay =100;
		int  MicrostepDelayBW;
		int  DiscrNumInMicroStep;
		int  XMicrostepNmb;
		int  YMicrostepNmb;
                int Timewait;
		int  X_begin =100;
		int  Y_begin =100;
    
                M_DACX   = Simple.bramID("dxchg_X");
                M_DACY   = Simple.bramID("dxchg_Y");

       		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1

  		int[] buf_stop;
		buf_stop = new int[1];
		buf_stop[0] =0;
		wr = stream_ch_stop.Write(buf_stop, 1, 1000);
		stream_ch_stop.Invalidate();

		int[] buf_drawdone;
		buf_drawdone = new int[1];
		buf_drawdone[0] =move;
	      	wr=0;
		for (;  wr == 0; )
		{
	          wr = stream_ch_drawdone.Write(buf_drawdone, 1, 300);
		}
            	stream_ch_drawdone.Invalidate();


		datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

		X_begin         =    datain[i0];
        	Y_begin         =    datain[i0+1];
		MicrostepDelay  =    datain[i0+2];
                DiscrNumInMicroStep= datain[i0+3]<<16;   //210113  add
                Timewait           = datain[i0+4];

             if (MicrostepDelay!=0) { 	USTEP_DLY =  MicrostepDelay;}         //210113
             else             { USTEP_DLY=1;};

                X_begin = X_begin * DAC_STEP;
                Y_begin = Y_begin * DAC_STEP;
               	dacX =Simple.bramRead(M_DACX) ;
           	dacY =Simple.bramRead(M_DACY) ;

        	dacZ =0;

                  int Snom =((1<<17) /USTEP_DLY)<<14;
                  int V=  1<<16;

               Simple.bramWrite( Simple.bramID("m_ustep"), Snom );
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
//GET
                code[7] = 0x00000000 + (0<<16) + (15<<0);
                code[8] = 0x40000000 + pause - 1;
// Возврат
   
		// Возврат
                code[9] = 0x80000000 + (3<<16) + 0;
   //----- Список портов перемещения в точку ---------
		code[10] = 4;
		code[11]  = Dxchg2.OUTP_DIRY;
		code[12] = Dxchg2.OUTP_DIRX;
		code[13] = Dxchg2.OUTP_Y;
		code[14] = Dxchg2.OUTP_X;
// GET
		code[15] = 1;
		code[16]  = PORT_H ;


                int[] path_in;
                path_in = new int[8];
                i=0;
                path_in[i++]= 0;
                path_in[i++]= X_begin < dacX ? -V : V;
                path_in[i++]= dacY;
                path_in[i++]= X_begin;
                path_in[i++]= Y_begin < dacY ? -V : V;
                path_in[i++]= 0;
                path_in[i++]= Y_begin;
                path_in[i++]= X_begin;


                int[] data_out;
                data_out = new int[2];

                Dxchg2.ExecuteScan( path_in, data_out, code, 2 );


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
       		stream_ch_drawdone.Close();
		stream_ch_stop.Close();
 
	}

}

















