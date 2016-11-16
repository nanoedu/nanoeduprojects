package mlab;      //261112

public class Spectrstm
{
	static final int DAC_STEP = 65536*1;

        public static  int M_I;
        public static  int M_U;
      	public static  int M_SELOPORA;


	static final int PORT_I = ( Port.IN   | 4 );
      	static final int PORT_U = ( Port.OUT  | 6 );



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

		int i,j;
              	int[] arr;
		int src_i;
		int dst_i;

		int[] datain;
		Port[] port;
		Span[] span_u;
                Span[] span_i;
		Scene scene;
                boolean flg;
                int  off;
		int  handle;
		int  point;
	        int  ubackup;
                int  s,wr,rd;
                int  Z;
		int  dt;
                int  VertMin;
                int  UPoints;
                int  UCurves;
                int  UStep;
                int  UStart;
                int  flgSTM;
                int  dacU;

		datain=Simple.xchgGet("algoritmparams.bin");
                int i0=4;
		UPoints         =   datain[i0];
                UCurves         =   datain[i0+1];
		UStart		=   datain[i0+2];    //integer  shl
		UStep		=   datain[i0+3];    //step shl
      		dt              =   datain[i0+4];
                flgSTM          =   datain[i0+5];

       //         Simple.DumpInt(0xAAAAAAA0);
      //          Simple.DumpInt(UPoints);
      //          Simple.DumpInt(UCurves);
      //          Simple.DumpInt(UStart);
     //           Simple.DumpInt(UStep);

              M_I = Simple.bramID("m_ADC_I");
              M_U = Simple.bramID("m_DAC_I");
       M_SELOPORA = Simple.bramID("m_sel_Uopora");


		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                 // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                 // 1
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,2,UPoints*UCurves,JVIO.FIFO,UPoints, 1);   //

		int[] dataout;
	   	dataout=new int[2*UPoints*UCurves];
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



    	i=0;
        int k;
        k=0;
        off=0;


//start

    Simple.fcupBypass(0,true); //turn off   FB     false???

    Simple.Sleep(100);

    ubackup=Simple.bramRead(M_U);

  //  Simple.DumpInt(0xBBBBBBBB);
  //  Simple.DumpInt(ubackup);


 //move to start point
 /*
     span_u = new Span[] {new Span(dt)};
     span_i = new Span[] {new Span(dt+200)};

     port   = new Port[] {   new Port(PORT_U,       span_u),
                             new Port(PORT_I,       span_i) };
     scene  = new Scene( port );


    for(handle=0;handle==0;)
    {
	handle = scene.createScene( scene.getTemplate(), 1);
	if ( 0 == handle ) scene.releaseScene(0);
    }



      	 scene.startLoad( handle, PORT_U, 0 );
       	 scene.load( handle, ubackup );
//         scene.load( handle, ubackup );
//         scene.load( handle, ubackup );

         scene.run( handle );
         scene.wait( handle, -1 );
         scene.releaseScene( handle );
*/

    Simple.bramWrite( M_SELOPORA, 0X80000000);     //use dchange for U

      dacU=UStart;
      k=0;

 for (j=0; j<UCurves; j++)
 {
      span_u = new Span[] {new Span(dt)};
      span_i = new Span[] {new Span(dt+200)};

     port   = new Port[] {   new Port(PORT_U,       span_u),
                             new Port(PORT_I,       span_i) };
     scene  = new Scene( port );

    for(handle=0;handle==0;)
    {
	handle = scene.createScene( scene.getTemplate(), UPoints);
	if ( 0 == handle ) scene.releaseScene(0);
    }

    dacU=UStart;


  for(i=0; i<UPoints; i++)
  {
       	 scene.startLoad( handle, PORT_U, i );
       	 scene.load( handle, dacU );
  //       scene.load( handle, dacU );
  //       scene.load( handle, dacU );
         dacU+=UStep;
  }


    scene.run( handle );

    scene.wait( handle, -1 );


    arr = scene.get( handle, PORT_I );



    	//Read data Оставляем в массиве только нужные данные.

			src_i = 0;
                 //       k=2*j*UPoints;
			dst_i = 0;
			for(i=0; i<UPoints; i++)
			{
				arr[dst_i] = arr[src_i];
                                dataout[k]=UStart+i*UStep;
                                dataout[k+1]=arr[dst_i];//(i*10+j*100)<<16;//arr[dst_i];
                              	dst_i += 1;
				src_i += 1;
                                k+=2;
			}

                         off=j*UPoints;
                          rd=0;  wr=0;
			 s =UPoints;// UPoints;

			for (;  wr != s; )
			{
				wr += stream_ch_data_out.WriteEx(dataout, off, s-wr, 1000);
                        }

                        stream_ch_data_out.Invalidate();

                        scene.releaseScene( handle );


 //move to start point
  }// j Curves


    //move to start point


     span_u = new Span[] {new Span(dt)};
     span_i = new Span[] {new Span(dt+200)};

     port   = new Port[] {   new Port(PORT_U,       span_u),
                             new Port(PORT_I,       span_i) };
     scene  = new Scene( port );


    for(handle=0;handle==0;)
    {
	handle = scene.createScene( scene.getTemplate(), 1);
	if ( 0 == handle ) scene.releaseScene(0);
    }

      	 scene.startLoad( handle, PORT_U, 0 );
       	 scene.load( handle, ubackup);
   //   	 scene.load( handle, ubackup);
  //     	 scene.load( handle, ubackup);
         scene.run( handle );
         scene.wait( handle, -1 );
         scene.releaseScene( handle );

         Simple.bramWrite(M_U,ubackup);


         Simple.bramWrite( M_SELOPORA, 0X00000000); //use bram for U




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
              //  for(;(buf_stop[0]!=stop) & (ccnt < 50) ;)
                  for(;(buf_stop[0]!=stop) ;)
                {
                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);
                  ccnt+=1;
                }


		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();
	}

}

















