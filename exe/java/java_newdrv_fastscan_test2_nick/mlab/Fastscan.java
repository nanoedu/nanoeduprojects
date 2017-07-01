package mlab;

public class Fastscan
{

public static final int pause = 50; // пауза в точке mks
public static final int steps = 32; // время перемещения между точками mks
///*************

	static int X_POINTS = 100;
	static int Y_POINTS = 100;
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
    //methods
        static  int  FastScan=8;
        static  int  FastScanPhase=10;
    //
	static  int M_USTEP;// = 21;
        static  int M_DACX;
        static  int M_DACY;
   	static final int PORT_H   = ( 2 );      //Z
        static final int PORT_PH  = ( 0 );
        static final int PORT_ERR = ( 1 );
        static final int PORT_I   = ( 4 );

	public static void main(String[] arg)
	{
  		int i;

		int d_step;
		int d_step_N;
		int lines;
		int dacX;
		int dacY;
		int dacZ;
		int  ScanPath;
		int  ScanMethod;
                int  fastlinescount;
                int  slowlinescount;
		int  point;
                int  Vbw;
                int  V;
                M_USTEP = Simple.bramID("m_ustep");;
                M_DACX   = Simple.bramID("dxchg_X");
                M_DACY   = Simple.bramID("dxchg_Y");
                //read parameters

                ScanPath=0;
		ScanMethod=FastScanPhase;
   

	       	dacX =Simple.bramRead(M_DACX) ;
             	dacY =Simple.bramRead(M_DACY) ;
        	dacZ =0;
        	int Snom = 0x028F5C29; // 1.0/50 - просто выбрано число 50
		int Vtrvl_nom = 0x19000000; // Snom*Vtrvl = Grid, за 1 шаг
		 V = Vtrvl_nom / 32;
                Vbw=-V;
     		Simple.bramWrite( Simple.bramID("m_ustep"), Snom );
                int Grid = 0x00800000;

        	int[] path_in;
 	        int[] data_out;
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
//----- Список портов получения результатов ------------------
		code[15] = 1;
               if (ScanMethod == FastScan) {code[16]= PORT_I;}
                          else
                          {
                           code[16]= PORT_PH;
                          }

                int fastlines=X_POINTS;
                int slowlines=Y_POINTS;
                if (ScanPath==1)
                {
                 fastlines=Y_POINTS;
                 slowlines=X_POINTS;
                }


 ///
         path_in=new int[4*(fastlines+2)*slowlines];
         data_out=new int[(fastlines+2)*slowlines];

       // сканируем  только   один кадр
                 i=0;
                slowlinescount=0;
        	fastlinescount=0;
                d_step=Grid;
                dacX=0;
                dacY=0;
		for(lines=slowlines; lines>0; --lines)
		{
                       	fastlinescount=0;
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
                                        dacY += d_step;
                                        slowlinescount+=1;
                                        path_in[i++]=V;
                                        path_in[i++]=0;
                                     }
                                     else
                                     {
                                        dacX += d_step;
                                        slowlinescount+=1;
                                        path_in[i++]=0;
                                        path_in[i++]=V;
                                     }
                                  }
			     else {                                   // Go to Start Point по  оси slowlines
                                   if (  ScanPath == 0)
                                   {  dacY -= (slowlinescount)*d_step;
                                       path_in[i++]=Vbw;
                                       path_in[i++]=0;
                                   }
                                    else
                                    {
                                     dacX -= (slowlinescount)*d_step;
                                     path_in[i++]=0;
                                     path_in[i++]=Vbw;
                                    }
			          }
                               path_in[i++]=dacY;
                               path_in[i++]=dacX;

        	}//lines


        // get data
//         	Simple.xchgCreate( "data", path_in );
 	Dxchg2.ExecuteScan( path_in, data_out, code, (fastlines+2)*slowlines);



  
	}
}

















