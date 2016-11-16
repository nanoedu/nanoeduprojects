package mlab;      //211112

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


	static final int PORT_COS_X = ( Port.OUT | 3 );
	static final int PORT_COS_Y = ( Port.OUT | 4 );
	static final int PORT_COS_Z = ( Port.OUT | 5 );

	static final int PORT_X = ( Port.OUT | 0 );
	static final int PORT_Y = ( Port.OUT | 1 );
	static final int PORT_Z = ( Port.OUT | 2 );

	static final int PORT_uVector = ( Port.OUT | 6 );


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
//       M_USTEP=Simple.bramID("m_ustep");
       M_DACX   = Simple.bramID("dxchg_X");
       M_DACY   = Simple.bramID("dxchg_Y");


		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                 // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                 // 1
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,3,2*ZPoints,JVIO.FIFO,2*ZPoints, 1);   // 2 //(UAM,Z)

                flg=false; //flg limit achived

              	int ampl;
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

          	dacX =Simple.bramRead(M_DACX) ;
             	dacY =Simple.bramRead(M_DACY) ;
        	dacZ =0;
               	dacZ0=dacZ;
    	i=0;
        int k;
        k=0;
        off=0;

//start

    Simple.fcupBypass(0,true); //turn off   FB     false???

     Simple.Sleep(100);
     		span_x_y_z = new Span[] { new Span(2), new Span(1) };

		span_h     = new Span[] { new Span(2), new Span(1), new Span(100) };

     	port = new Port[] { new Port(PORT_COS_X,   span_x_y_z),
		                    new Port(PORT_COS_Y,   span_x_y_z),
				    new Port(PORT_COS_Z,   span_x_y_z),
		                    new Port(PORT_X,       span_x_y_z),
		                    new Port(PORT_Y,       span_x_y_z),
				    new Port(PORT_Z,       span_x_y_z)
                                  };

 //move to start point

   scene = new Scene( port );

   for(handle=0;handle==0;)
   {
	handle = scene.createScene( scene.getTemplate(), 1);
	if ( 0 == handle ) scene.releaseScene(0);
    }

        dacZ=dacZ0-ZStart;        //+_????
    	scene.setScanPorts( handle, new int[] {
                                               PORT_X,PORT_COS_X,
		                               PORT_Y,PORT_COS_Y,
		                               PORT_Z,PORT_COS_Z
                                              }
                                              );

    scene.addPoint( handle, dacX, dacY, dacZ );//1

    scene.run( handle );

    scene.wait( handle, -1 );

    scene.releaseScene( handle );


  for(i=0; i<ZPoints; i++)
  {
    scene = new Scene( port );
    for(handle=0;handle==0;)
    {
	handle = scene.createScene( scene.getTemplate(), 1);
	if ( 0 == handle ) scene.releaseScene(0);
    }

    scene.setScanPorts( handle, new int[] {PORT_X,PORT_COS_X,
                                           PORT_Y,PORT_COS_Y,
	                                   PORT_Z,PORT_COS_Z});

    scene.addPoint( handle, dacX, dacY, dacZ );//1

    scene.run( handle );

    scene.wait( handle, -1 );
    if (flgSTM==1) {  ampl=Simple.bramRead(M_I);} //  STM
    else           {  ampl=Simple.bramRead(M_A);}  //  SFM


    dataout[k]=ampl;

    dataout[k+1]=-(dacZ-dacZ0);

    dataout[k+2]=1;
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
    scene.releaseScene( handle );
  }
     dacZ=dacZ+ZStep;
     ZPoints= k / 3;

  for(i=ZPoints; i>=1; i--)
  {
    scene = new Scene( port );
    for(handle=0;handle==0;)
    {
	handle = scene.createScene( scene.getTemplate(), 1);
	if ( 0 == handle ) scene.releaseScene(0);
    }
    scene.setScanPorts( handle, new int[] {PORT_X,PORT_COS_X,
                                           PORT_Y,PORT_COS_Y,
	                                   PORT_Z,PORT_COS_Z});

    scene.addPoint( handle, dacX, dacY, dacZ );//1

    scene.run( handle );

    scene.wait( handle, -1 );

    if (flgSTM==1) {  ampl=Simple.bramRead(M_I);} //  STM
    else           {  ampl=Simple.bramRead(M_A);}  //  SFM

    dataout[k]=ampl;

    dataout[k+1]=-(dacZ-dacZ0);

    dataout[k+2]=-1;

    dacZ=dacZ+ZStep;

    wr=0;
    wr= stream_ch_data_out.WriteEx(dataout, off,1, 1000);
    off+=wr;
    k+=3;
    stream_ch_data_out.Invalidate();
    scene.releaseScene( handle );

   }

 //move to start point

   scene = new Scene( port );
   for(handle=0;handle==0;)
   {
	handle = scene.createScene( scene.getTemplate(), 1);
	if ( 0 == handle ) scene.releaseScene(0);
    }

    dacZ=dacZ0;

    scene.setScanPorts( handle, new int[] {PORT_X,PORT_COS_X,
		                               PORT_Y,PORT_COS_Y,
		                               PORT_Z,PORT_COS_Z});

    scene.addPoint( handle, dacX, dacY, dacZ );//1

    scene.run( handle );

    scene.wait( handle, -1 );

    scene.releaseScene( handle );

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
	}

}

















