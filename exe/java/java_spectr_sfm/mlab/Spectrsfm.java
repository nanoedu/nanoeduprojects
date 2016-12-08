package mlab;
    //08/12/16 fix bugs IZ
    //28/08/13 // По одному дискрету, c функциией и задержкой
public class Spectrsfm
{
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
	static  int USTEP_DLY= 400;
        public static  int M_A ;
        public static  int M_I;
        public static  int M_USTEP;
        static  int M_DACX;
        static  int M_DACY;
	public static  int M_DACZ;

  	static final int PORT_COS_X   = ( Port.OUT | 3 );
	static final int PORT_COS_Y   = ( Port.OUT | 4 );
	static final int PORT_COS_Z   = ( Port.OUT | 5 );
  	static final int PORT_X       = ( Port.OUT | 0 );
	static final int PORT_Y       = ( Port.OUT | 1 );
	static final int PORT_Z       = ( Port.OUT | 2 );
  	static final int PORT_uVector = ( Port.OUT | 6 );

        // chanels ID
	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;
	public static final int CH_DATA_OUT    = 2;
        public static final int CH_PARAMS      = 3;

        public static final int done=60;
        public static final int stop=100;
 	public static final int MakeSTOP =1;

public static int Zmove( int Z, int ndiscr, int st1, int delay )   // st1 = +-1
	{
	  int j,k;
  	  int cZ;	
	  cZ = Z;
	  for (j=0; j< ndiscr; j++)
	  {
	    cZ=cZ+(st1 << 16 );
            for(k=0; k < delay; k++) { }// задержка в каждом дискрете
            Simple.bramWrite(M_DACZ, cZ);
	  }
	  return(cZ);
	}		

	public static void main(String[] arg)
	{
 		int i,j;
		int[] datain;
		Port[] port;
		Span[] span_x_y_z;
		Span[] span_h;
		Span[] span_uVect;
		Scene scene;
                boolean flg;
                int off;
		int handle;
		int point;
		int d_step;
		int d_step_N;
		int x_cos;
		int y_cos;
		int z_cos;
		int dacZ;
              	int dacX;
		int dacY;
                int dacZ0;
		int uVector;
                int s,wr,rd;
                int  Z;
		int  MicrostepDelay;
                int  VertMin;
                int  ZPoints;
                int  ZStep;
                int  ZStart;
                int  flgSTM;
		int dlt;
 		datain=Simple.xchgGet("algoritmparams.bin");
        	int i0=4;

		ZPoints        =    datain[i0];
		ZStart		=   datain[i0+1];    //integer
		ZStep		=   datain[i0+2];    //discrets word
                VertMin         =   datain[i0+3];
		MicrostepDelay  =   datain[i0+4];
                flgSTM          =   datain[i0+5];

                M_A=Simple.bramID("m_A");
                M_I=Simple.bramID("m_ADC_I");
                M_DACZ 	= Simple.bramID("m_dacZ");

		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                 // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                 // 1
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,3,2*ZPoints,JVIO.FIFO,2*ZPoints, 1);   // 2 //(UAM,Z)

                flg=false; //flg limit achived

              	int ampl;
		int[] dataout;
		dataout=new int[6*ZPoints];
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
		dacZ = 0;
               	dacZ0=dacZ;
           	i=0;
                int k;
                k=0;
                off=0;
 //start
                int  st = 1 << 16;
                Simple.fcupBypass(0,true); //turn off   FB
                int workTim = Simple.GetSystemTicks();
 //move to start point
                dacZ = Zmove( dacZ, (-(ZStart >> 16)), 1, MicrostepDelay );
        	Simple.Sleep(100);	//

  for(i=0; i<ZPoints; i++)
  {
    if (flgSTM==1) {  ampl=Simple.bramRead(M_I);}  //  STM
    else           {  ampl=Simple.bramRead(M_A);}  //  SFM

    dataout[k]=ampl;
    dataout[k+1]=-(dacZ-dacZ0);
    dataout[k+2]=1;

   if (flgSTM==1)
   {
    if (ampl<0) ampl=-ampl;
    int imax=VertMin;
    if (imax<0) imax=-imax;
    if (ampl<imax)
     {
         dacZ = Zmove( dacZ, (ZStep >> 16), -1, MicrostepDelay );
         k+=3;
     }
   }
   else
   {
    if (ampl>VertMin)
    {
     dacZ = Zmove( dacZ, (ZStep >> 16), -1, MicrostepDelay );
      k+=3;
    };
   }
 }  // for    i

  //   dacZ=dacZ+ZStep;
    ZPoints= k / 3;
    Simple.Sleep(300);
     k=k+3;
  off = ZPoints;
  for(i=ZPoints; i>=1; i--)
  {
    if (flgSTM==1) {  ampl=Simple.bramRead(M_I);} //  STM
    else           {  ampl=Simple.bramRead(M_A);}  //  SFM

    dataout[k]=ampl;

    dataout[k+1]=-(dacZ-dacZ0);

    dataout[k+2]=-1;

  //  dacZ=dacZ+ZStep;

   dacZ = Zmove( dacZ, (ZStep >> 16), +1, MicrostepDelay );

   k+=3;
  }

 //move to start point

if (dacZ > 0) {dlt = dacZ;}
  else {dlt = -dacZ;}

 dacZ = Zmove( dacZ, (dlt >> 16), -1, MicrostepDelay );

    	//dacZ=dacZ0;

	//Simple.bramWrite(M_DACZ, dacZ);

   workTim = Simple.GetSystemTicks() - workTim;  // Время выполнения алгоритма

   off = 0;
   wr=0;
   s = 2*ZPoints;
   for (;  wr != s; )
   {
     wr += stream_ch_data_out.WriteEx(dataout, off, s-wr, 1000);
     off += wr;
   }
	 stream_ch_data_out.Invalidate();

    Simple.fcupBypass(0,false); //turn on  FB


		buf_drawdone[0]=done;

		wr=0;
		for (;  wr == 0; )
		{
	          wr = stream_ch_drawdone.Write(buf_drawdone, 1, 300);
		}
                stream_ch_drawdone.Invalidate();

		Simple.Sleep(1000);

		rd=0;
               for(;(buf_stop[0]!=stop) ;)
                {
                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);
                }
		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();
//Simple.DumpInt(0xDDDDDDDD);
	}

}

















