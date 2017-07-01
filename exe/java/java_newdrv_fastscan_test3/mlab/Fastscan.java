package mlab;
//13/06/17
public class Fastscan
{

public static final int pause = 50; // ����� � ����� mks
public static final int steps = 32; // ����� ����������� ����� ������� mks
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
        	int Snom = 0x028F5C29; // 1.0/50 - ������ ������� ����� 50
		int Vtrvl_nom = 0x19000000; // Snom*Vtrvl = Grid, �� 1 ���
		 V = Vtrvl_nom / 32;
                Vbw=-10*V;
     		Simple.bramWrite( Simple.bramID("m_ustep"), Snom );
                int Grid = 0x00800000;

        	int[] path_in;
 	        int[] data_out;
 		int[] code;


                int fastlines=X_POINTS;
                int slowlines=Y_POINTS;
                if (ScanPath==1)
                {
                 fastlines=Y_POINTS;
                 slowlines=X_POINTS;
                }
		 
		code = new int[27];

//----- ��������� -- "2D point" --------------------
		code[0]  = Dxchg2.CODE_SIGNATURE;
		code[1]  = 0x00030002; //����� �����  ???   ������� =2
		code[2]  = code.length;
// repeat

                code[3]= 0x80000000 + (13<<16) +fastlines; 

        // ������ ����������� � �����  0   fastline
                code[4]  = 0x00000000 + (20<<16) + (0<<0);
		code[5]  = 0x20000000;
		// �������� �����������
                code[6]  = 0x00000000;
		code[7]  = 0x10000008;
 // ������ ����������� � ������� ����� slowline+1
                code[8]  = 0x00000000 + (20<<16) + (0<<0);
		code[9]  = 0x20000000;
		// �������� �����������
                code[10]  = 0x00000000;
		code[11]  = 0x10000008;
// ������� 
                code[12]= 0x80000000 + (3<<16) +0; 



//----- ��� ----------------------------------------
                // ������ ����������� � ������� �����
                code[13]  = 0x00000000 + (20<<16) + (0<<0);
		code[14]  = 0x20000000;
		// �������� �����������
                code[15]  = 0x00000000;
		code[16]  = 0x10000008;
	 	// ���������� ����� �����
                code[17] = 0x00000000 + (0<<16) + (25<<0);
                code[18] = 0x40000000 + pause - 1;
// ������� 

                code[19] = 0x80000000 + (13<<16) + 0; 

 
//----- ������ ������ ����������� � ����� ---------
		code[20] = 4;
		code[21] = Dxchg2.OUTP_DIRY;
		code[22] = Dxchg2.OUTP_DIRX;
		code[23] = Dxchg2.OUTP_Y;
		code[24] = Dxchg2.OUTP_X;
//----- ������ ������ ��������� ����������� ------------------
		code[25] = 1;
               if (ScanMethod == FastScan) {code[26]= PORT_I;}
                          else
                          {
                           code[26]= PORT_PH;
                          }

   



 ///
         path_in=new int[4*(fastlines+2)*slowlines];
         data_out=new int[fastlines*slowlines];

       // ���������  ������   ���� ����
                 i=0;
                slowlinescount=0;
        	fastlinescount=0;
             //   d_step=Grid;
            //    dacX=0;
            //    dacY=0;
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
			     else {                                   // Go to Start Point ��  ��� slowlines
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

       	Simple.xchgCreate( "data", path_in );
 	Dxchg2.ExecuteScan( path_in, data_out, code, slowlines);



  
	}
}

















