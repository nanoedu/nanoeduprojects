package mlab;      //201112

public class Spectrsfmnew
{
	static final int DAC_STEP = 65536*1;
	static final int VAL_0_5  = 0x40000000;
	static  int USTEP_DLY= 400;
        public static  int M_A ;
        public static  int M_I;
        public static  int M_USTEP;
        static  int M_DACX;
        static  int M_DACY;
        static  int  M_BASE_K;
	static final int PORT_COS_X = (3 );
	static final int PORT_COS_Y = (4 );
	static final int PORT_COS_Z = (5 );

	static final int PORT_X = (0 );
	static final int PORT_Y = (1 );
	static final int PORT_Z = (2 );

        static final int PORT_ERR = ( 1 );     //appl,i

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
  //new
              	Dxchg dxchg;
		int i;
		int[] datain;
                int [] arr;
                boolean flg;
                int off;
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
               	int ampl;
                int setpoint;

		datain=Simple.xchgGet("algoritmparams.bin");

        	int i0=4;

		ZPoints        =    datain[i0];
		ZStart		=   datain[i0+1];    //integer
		ZStep		=   datain[i0+2];    //discrets word
                VertMin         =   datain[i0+3];
		MicrostepDelay  =   datain[i0+4];
                flgSTM          =   datain[i0+5];
 for (i=0;i<6; i++)  { Simple.DumpInt(datain[i+i0]);}

       M_A=Simple.bramID("m_A");
       M_I=Simple.bramID("m_ADC_I");
       M_USTEP=Simple.bramID("m_ustep");
       M_DACX   = Simple.bramID("dxchg_X");
       M_DACY   = Simple.bramID("dxchg_Y");
       M_BASE_K =Simple.bramID("m_BaseK");;

          setpoint=Simple.bramRead(M_BASE_K);

		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                 // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                 // 1
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,3,2*ZPoints,JVIO.FIFO,2*ZPoints, 1);   // 2 //(UAM,Z)

                flg=false; //flg limit achived


		int[] dataout;
		dataout=new int[6*ZPoints];       //?????
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

		d_step_N  =  ZStep;//XMicrostepNmb;     // Кол-во микрошагов от точки к точке.

   //		USTEP_DLY =  MicrostepDelay;

		d_step = d_step_N * DAC_STEP; // Приращение ЦАП на шаге от точки к точке.


	 	dacX =Simple.bramRead(M_DACX) ;
             	dacY =Simple.bramRead(M_DACY) ;
        	dacZ =0;

		dacZ0=dacZ;

// 		uVector = (2 * 0x00010000 / USTEP_DLY);

//		Simple.bramWrite( M_USTEP, uVector );

    	i=0;
        int k;
        k=0;
        off=0;

//start

    Simple.fcupBypass(0,true); //turn off   FB     false???


    Simple.Sleep(100);


 //move to start point


               	dxchg = new Dxchg();
               	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               PORT_Z,PORT_COS_Z, dacZ}
				  );

        dacZ=dacZ0-ZStart;

        dxchg.Goto( dacX,dacY,dacZ);

        dxchg.ExecuteScan();

        dxchg.WaitScanComplete(-1);


  for(i=0; i<ZPoints; i++)
  {
    	dxchg = new Dxchg();
      	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               PORT_Z,PORT_COS_Z, dacZ}
				  );


        dxchg.Goto( dacX,dacY,dacZ);

        dxchg.Wait(MicrostepDelay);

        dxchg.GetI(PORT_ERR);

        dxchg.ExecuteScan();

        dxchg.WaitScanComplete(-1);;
        arr = dxchg.GetResults();

 //         if (flgSTM==1) {  ampl=Simple.bramRead(M_I);} //  STM
 //         else           {  ampl=Simple.bramRead(M_A);}  //  SFM

       ampl=arr[0]+setpoint;
    dataout[k]=ampl;

    dataout[k+1]=-(dacZ-dacZ0);

    dataout[k+2]=1;

     Simple.DumpInt(0xAAAAAAAA);
   Simple.DumpInt(ampl);
     Simple.DumpInt(VertMin);
      Simple.DumpInt(dacZ);
  if (flgSTM==1)
   {
   if (ampl<VertMin)
     { dacZ=dacZ-ZStep;
      wr=0;
      wr= stream_ch_data_out.WriteEx(dataout, off,1, 1000);
      stream_ch_data_out.Invalidate();
      off +=wr;
      k+=3;
     }
   }
   else
    if (ampl>VertMin)
   { dacZ=dacZ-ZStep;
     wr=0;
     wr= stream_ch_data_out.WriteEx(dataout, off,1, 1000);
     stream_ch_data_out.Invalidate();
     off +=wr;
     k+=3;
   };
  } //forward

     dacZ=dacZ+ZStep;
     ZPoints= k / 3;

  for(i=ZPoints; i>=1; i--)
  {
	dxchg = new Dxchg();
      	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               PORT_Z,PORT_COS_Z, dacZ}
				  );

        dxchg.Goto( dacX,dacY,dacZ);

        dxchg.Wait(MicrostepDelay);

        dxchg.GetI(PORT_ERR);

        dxchg.ExecuteScan();

        dxchg.WaitScanComplete(-1);
          arr = dxchg.GetResults();
        ampl=arr[0]+setpoint;
//       if (flgSTM==1) {  ampl=Simple.bramRead(M_I);} //  STM
//       else           {  ampl=Simple.bramRead(M_A);}  //  SFM


    dataout[k]=ampl;

    dataout[k+1]=-(dacZ-dacZ0);

    dataout[k+2]=-1;

    dacZ=dacZ+ZStep;

    wr=0;
    wr= stream_ch_data_out.WriteEx(dataout, off,1, 1000);
    off+=wr;
    k+=3;
    stream_ch_data_out.Invalidate();
   }

 //move to start point


	dxchg = new Dxchg();
      	dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, dacX,
      		                               PORT_Y,PORT_COS_Y, dacY,
         	                               PORT_Z,PORT_COS_Z, dacZ}
			  );

        dacZ=dacZ0;


        dxchg.Goto( dacX,dacY,dacZ);

        dxchg.ExecuteScan();

        dxchg.WaitScanComplete(-1);;


        Simple.fcupBypass(0,false); //turn on  FB


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
		int ccnt = 0;
                  for(;(buf_stop[0]!=stop) ;)
                {
Simple.DumpInt(rd);
                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);
                  ccnt+=1;
                }
Simple.DumpInt(1);

		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();
	}

}

















