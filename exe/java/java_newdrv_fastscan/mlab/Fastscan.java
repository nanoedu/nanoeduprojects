//16/06/17
package mlab;

public class Fastscan
{

public static final int pause = 50; // ����� � ����� mks
public static final int steps =64; // ����� ����������� ����� ������� mks
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
/*
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
*/
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
             // +1 - ������ �����, ����� ��������� �������� ������ ������,
             //  ������� 512 ����
               JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,SZ,(fastlines)*slowlines,JVIO.FIFO,fastlines*slowlines, 0); // 2
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

	        d_step_N = XMicrostepNmb;     // ���-�� ���������� �� ����� � �����.
 		d_step = d_step_N * DAC_STEP; // ���������� ��� �� ���� �� ����� � �����.

	       	dacX =Simple.bramRead(M_DACX) ;
             	dacY =Simple.bramRead(M_DACY) ;
        	dacZ =0;



                USTEP_DLY = MicrostepDelay;//buf_params[0];

                USTEP_DLYBW = MicrostepDelayBW;//buf_params[1];

  /*   		uVector =   (2 * DiscrNumInMicroStep / USTEP_DLY);

                uVectorBW = (2 * DiscrNumInMicroStep / USTEP_DLYBW);

     	        Simple.bramWrite( M_USTEP, uVector );

*/              

//              Simple.fcupBypass(0,true); //turn off   FB     false???


///***********************************************************************
         	//int Snom = 0x028F5C29; // 1.0/50 - ������ ������� ����� 50
		//int Vtrvl_nom = 0x19000000; // Snom*Vtrvl = Grid, �� 1 ���
		// V = Vtrvl_nom / 32;
               //  int Snom =((1<<17) /USTEP_DLY)<<14;
               //  V=  1<<16;
              //   Vbw= V;
                 int Snom =((DiscrNumInMicroStep <<1) /USTEP_DLY)<<14;
                 V=DiscrNumInMicroStep ;
                 Vbw= (V*USTEP_DLY)/USTEP_DLYBW; // �������� V ��������������� ��������, � �� ��������
                   V=-V;                 
               
     		Simple.bramWrite( Simple.bramID("m_ustep"), Snom );
               

//////////////////////////////////////////////////////////////////////////
        	int[] path_in;
 	        int[] data_out;
 		int[] code;

		code = new int[27];

//----- ��������� -- "2D point" --------------------
		code[0]  = Dxchg2.CODE_SIGNATURE;
		code[1]  = 0x00030002; //����� �����  3   ������� =2
		code[2]  = code.length;
// repeat

                code[3]= 0x80000000 + (13<<16) +fastlines;

// ����������� � �����  x=0   fastline
                code[4]  = 0x00000000 + (20<<16) + (0<<0);
		code[5]  = 0x20000000;
		// �������� �����������
                code[6]  = 0x00000000;
		code[7]  = 0x10000008;
 //����������� � �����  x=0 ;y=0
                code[8]  = 0x00000000 + (20<<16) + (0<<0);
		code[9]  = 0x20000000;
		// �������� �����������
                code[10]  = 0x00000000;
		code[11]  = 0x10000008;
// �������
                code[12]= 0x80000000 + (3<<16) +0;
// �����


//----- ��� ---�������� �� ��������� ���------------------------------------
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
//-------------------�������� �� ��������� ���----------------------

//----- ������ ������ ����������� � ����� ---------
		code[20] = 4;
		code[21] = Dxchg2.PORT_DIRY;
		code[22] = Dxchg2.PORT_DIRX;
		code[23] = Dxchg2.PORT_Y;
		code[24] = Dxchg2.PORT_X;
//----- ������ ������ ��������� ����������� ------------------
		code[25] = 1;
               if (ScanMethod == FastScan) {code[26]= Dxchg2.PORT_I;}
                          else
                          {
                           code[26]= Dxchg2.PORT_PH;
                          }
//////////////////////////////////////////////////////////////////////

         path_in=new int[4*(fastlines+2)*slowlines];
         data_out=new int[fastlines*slowlines];

       // ���������  ������   ���� ����
                 i=0;
                slowlinescount=0;
        	fastlinescount=0;
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

      // 	Simple.xchgCreate( "data", path_in );
 	Dxchg2.ExecuteScan( path_in, data_out, code, slowlines);


          //send scan data
			int s = slowlines*fastlines;// +1;  // +1 ����� ������ ������ ��� <> mod 512
	              	wr=0;
 	        	for (;  wr != s; )
			{
                          wr += stream_ch_data_out.WriteEx(data_out, wr, s-wr, 1000);
			}
			stream_ch_data_out.Invalidate();


           // ��������� ������

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

















