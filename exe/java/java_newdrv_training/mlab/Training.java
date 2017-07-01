package mlab;

public class Training
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
   
       static final int DAC_MAX = 0x7FFFFFFF;
	static final int DAC_MIN = 0x80000000;
       	static final int DACZ_MAX = 0x7FFFFFFF;   //28.08.13 !!!!!
	static final int DACZ_MIN = 0x80000000;

        static  int M_DACX;
        static  int M_DACY;
       	static  int M_DACZ;
        static  int M_PID_ON;
        static  int M_USTEP;
      	static  int M_ZUSTEP;

	static final int PORT_COS_X = ( 3 );
	static final int PORT_COS_Y = ( 4 );
	static final int PORT_COS_Z = ( 5 );
    //in
	static final int PORT_X = ( 0 );
	static final int PORT_Y = ( 1 );
	static final int PORT_Z = ( 2 );

     //out
	static final int PORT_H   = ( 2 );      //Z
  

        // chanels ID
	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;
	public static final int CH_DATA_OUT    = 2;
  
        public static final int done=60;

        public static final int stop=100;

	public static final int MakeSTOP =1;

	public static void main(String[] arg)
	{
	
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
		int  dacX,dacX0;
		int  dacY,dacY0;
		int  dacZ,dacZ0;
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
               int  INTDELAY;
		 int  SCANNERDECAY;
                int  uV0,ZuV0;
              
                int  NCycle;
                int  STMFLG;
                int  ZStep;

      
       M_USTEP = Simple.bramID("m_ustep");;
       M_DACX   = Simple.bramID("dxchg_X");
       M_DACY   = Simple.bramID("dxchg_Y");

		datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

		NCycle             =  datain[i0];
                INTDELAY           =  datain[i0+1];
                SCANNERDECAY       =  datain[i0+2];
                STMFLG             =  datain[i0+3];
                MicrostepDelay     =  datain[i0+4];
                DiscrNumInMicroStep=  datain[i0+5] << 16;
    

                int  MaxX=0x7fffffff;
                int  MinX=0x80000000;
                int  MaxY=0x7fffffff;
                int  MinY=0x80000000;
            
		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
       		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,1,NCycle,JVIO.BUF,1, 0); // 2
                    

		int[] buf_stop;
		buf_stop = new int[1];
		buf_stop[0] =0;
		wr = stream_ch_stop.Write(buf_stop, 1, 1000);
		stream_ch_stop.Invalidate();

		int[] buf_drawdone;
		buf_drawdone = new int[1];
		buf_drawdone[0] =0;
		wr = stream_ch_drawdone.Write(buf_drawdone, 1, 1000);
stream_ch_drawdone.Invalidate();

               dacX0 =Simple.bramRead(M_DACX) ;
	          	dacY0 =Simple.bramRead(M_DACY) ;
	         	dacZ0 =0;

                        dacX=dacX0;
                        dacY=dacY0;
                        dacZ=dacZ0;
                
                 uV0=Simple.bramRead( M_USTEP);

                ZuV0=Simple.bramRead( M_ZUSTEP);


                USTEP_DLY = MicrostepDelay;             
           

                 int Snom =((1<<17) /USTEP_DLY)<<14;
                 int V=  1<<16;               
              
                 Simple.bramWrite( Simple.bramID("m_ustep"), Snom );
                  Simple.bramWrite( Simple.bramID("m_Z_ustep"), Snom);

                 int NMOVS_IN_CYCLE = 12;  // количество перемещений в одном цикле тренировки
//////////////////////////////////////////////////////////////////////////
        	int[] path_in;
 	        int[] data_out;
 		int[] code;
  
                code = new int[29];

//----- Заголовок -- "2D point" --------------------
		code[0]  = Dxchg2.CODE_SIGNATURE;
		code[1]  = 0x00030002; //точка входа  3   глубина =2
		code[2]  = code.length;
// repeat

                code[3]= 0x80000000 + (13<<16) + NMOVS_IN_CYCLE;

               // Считывание после паузы
                code[4] = 0x00000000 + (0<<16) + (27<<0);
                code[5] = 0x40000000 + pause - 1;
// Возврат
                code[6]= 0x80000000 + (3<<16) +0;
// конец


                // Вектор перемещения и позиция точки
                code[13]  = 0x00000000 + (20<<16) + (0<<0);
		code[14]  = 0x20000000;
		// Контроль перемещения
                code[15]  = 0x00000000;
		code[16]  = 0x10000008;

// Возврат
                code[19] = 0x80000000 + (13<<16) + 0;
//-------------------движения по медленной оси----------------------

//----- Список портов перемещения в точку ---------
		code[20] = 6;
		code[21] = Dxchg2.PORT_DIRY;
		code[22] = Dxchg2.PORT_DIRX;
                code[23] = Dxchg2.PORT_DIRZ;
		code[24] = Dxchg2.PORT_Y;
		code[25] = Dxchg2.PORT_X;
code[26] = Dxchg2.PORT_Z;
//----- Список портов получения результатов ------------------
		code[27] = 1;
           	code[28] = PORT_H;

 //////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
//----  Код возврата в исходную точку
               int[] codemovetoP0;
                codemovetoP0 = new int[29];
                int[] pathmovetoP0_in;
                int[] datamovetoP0_out;
//----- Заголовок -- "2D point" --------------------
		codemovetoP0[0]  = Dxchg2.CODE_SIGNATURE;
		codemovetoP0[1]  = 0x00030001; //точка входа  3   глубина =1
		codemovetoP0[2]  = codemovetoP0.length;

//------ Перемещение в исходную точку по X,Y,Z
                codemovetoP0[3]  = 0x00000000 + (20<<16) + (0<<0);
		codemovetoP0[4]  = 0x20000000;
		// Контроль перемещения
                codemovetoP0[5]  = 0x00000000;
		codemovetoP0[6]  = 0x10000008; 

// Считывание после паузы
                codemovetoP0[7] = 0x00000000 + (0<<16) + (27<<0);
                codemovetoP0[8] = 0x40000000 + pause - 1;

                codemovetoP0[9]= 0x80000000 + (3<<16)  +0;                 

 
// конец

//----- Список портов перемещения в точку ---------
		codemovetoP0[20] = 6;
		codemovetoP0[21] = Dxchg2.PORT_DIRY;
		codemovetoP0[22] = Dxchg2.PORT_DIRX;
                codemovetoP0[23] = Dxchg2.PORT_DIRZ;
		codemovetoP0[24] = Dxchg2.PORT_Y;
		codemovetoP0[25] = Dxchg2.PORT_X;
                codemovetoP0[26] = Dxchg2.PORT_Z;

//----- Список портов получения результатов ------------------
		codemovetoP0[27] = 1;
           	codemovetoP0[28] = PORT_H;

         path_in =new int[6*NMOVS_IN_CYCLE];
        data_out =new int[1];

//main cycle
 	      
                 int  movcnt;            
                int ccnt;
		         for (ccnt=0 ;  ccnt<NCycle ; ccnt++)
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
                i=0;
                              path_in[i++]=dacY < dacY0 ? -V : V;    //1    
                              path_in[i++]=dacX < dacX0 ? -V : V;
                              path_in[i++]=0 < dacZ0 ? -V : V;
                              path_in[i++]=dacY;
                              path_in[i++]=dacX;
                              path_in[i++]=0;

                            
                              dacZ=DACZ_MIN;   //2
                              path_in[i++]=0;
                              path_in[i++]=0;
                              path_in[i++]=-V;   // 0 -> DACZ_MIN
                              path_in[i++]=dacY;
                              path_in[i++]=dacX;
                              path_in[i++]=dacZ;

                              dacZ=DACZ_MAX;   //3
                              path_in[i++]=0;
                              path_in[i++]=0;
                              path_in[i++]=V;
                              path_in[i++]=dacY;
                              path_in[i++]=dacX;
                              path_in[i++]=dacZ;

                              dacZ=DACZ_MIN;   //4
                              path_in[i++]=0;
                              path_in[i++]=0;
                              path_in[i++]=-V;
                              path_in[i++]=dacY;
                              path_in[i++]=dacX;
                              path_in[i++]=dacZ;

                              dacZ=DACZ_MAX;   //5
                              path_in[i++]=0;
                              path_in[i++]=0;
                              path_in[i++]=V;
                              path_in[i++]=dacY;
                              path_in[i++]=dacX;
                              path_in[i++]=dacZ;

                              dacZ=DACZ_MIN;   //6
                              path_in[i++]=0;
                              path_in[i++]=0;
                              path_in[i++]=-V;
                              path_in[i++]=dacY;
                              path_in[i++]=dacX;
                              path_in[i++]=dacZ;


                              dacZ =0;         //7
                              path_in[i++]=0;
                              path_in[i++]=0;
                              path_in[i++]=V;
                              path_in[i++]=dacY;
                              path_in[i++]=dacX;
                              path_in[i++]=dacZ;

                              dacX =DAC_MIN; dacY=DAC_MIN;  //8
                              path_in[i++]=-V;
                              path_in[i++]=-V;
                              path_in[i++]=0;
                              path_in[i++]=dacY;
                              path_in[i++]=dacX;
                              path_in[i++]=dacZ;

	                      dacX =DAC_MAX;  dacY=DAC_MAX;  //9
                              path_in[i++]=V;
                              path_in[i++]=V;
                              path_in[i++]=0;
                              path_in[i++]=dacY;
                              path_in[i++]=dacX;
                              path_in[i++]=dacZ;

                              dacX =DAC_MIN  ;  dacY=DAC_MIN;  //10
                              path_in[i++]=-V;
                              path_in[i++]=-V;
                              path_in[i++]=0;
                              path_in[i++]=dacY;
                              path_in[i++]=dacX;
                              path_in[i++]=dacZ;

	                      dacX =DAC_MAX;  dacY=DAC_MAX;  //11
                              path_in[i++]=V;
                              path_in[i++]=V;
                              path_in[i++]=0;
                              path_in[i++]=dacY;
                              path_in[i++]=dacX;
                              path_in[i++]=dacZ;

                              dacX =DAC_MIN;   dacY=DAC_MIN;  //12
                              path_in[i++]=-V;
                              path_in[i++]=-V;
                              path_in[i++]=0;
                              path_in[i++]=dacX;
                              path_in[i++]=dacY;
                              path_in[i++]=dacZ;

 		
                     Dxchg2.ExecuteScan( path_in, data_out, code,   1);
                  

                	wr=0;

			
			for (;  wr == 0; )
			{
                          wr= stream_ch_data_out.Write(data_out,1, 1000);
			}
			stream_ch_data_out.Invalidate();


               }//ccnt
               
                       pathmovetoP0_in = new int[6];
              datamovetoP0_out = new int[1];
              i=0;
              pathmovetoP0_in[i++] =V;
              pathmovetoP0_in[i++] =V;
              pathmovetoP0_in[i++]= dacZ0 < dacZ ? -V : V;
              pathmovetoP0_in[i++]=dacY0;
              pathmovetoP0_in[i++]=dacX0;
              pathmovetoP0_in[i++]=dacZ0;

	     Dxchg2.ExecuteScan( pathmovetoP0_in, datamovetoP0_out, codemovetoP0, 1);             

        
                       	Simple.bramWrite( M_USTEP, uV0 );
                       	Simple.bramWrite( M_ZUSTEP, ZuV0);
                        Simple.fcupBypass(0,false);

                 if (STMFLG==1)    Simple.bramWrite(M_PID_ON,0x40000000); // pull ahead tip STM
                  else             Simple.bramWrite(M_PID_ON,0x80000000); // pull ahead tip SFM

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
		int rcnt = 0;
                for(;(buf_stop[0]!=stop) ;)
                {
                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);
                  rcnt+=1;
                }
         
		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();
	}
}

















