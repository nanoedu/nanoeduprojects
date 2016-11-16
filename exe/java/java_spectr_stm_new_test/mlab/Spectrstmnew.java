package mlab;      //231215

public class Spectrstmnew
{
	static final int DAC_STEP =1<<16; // 65536*1;
        static final int start_step=100;
        public static  int M_I;
        public static  int M_U;
      	public static  int M_SELOPORA;
        static  int M_DACX;
        static  int M_DACY;

      	static final int PORT_COS_X = ( 3 );
	static final int PORT_COS_Y = ( 4 );
	static final int PORT_COS_Z = ( 5 );


	static final int PORT_X = ( 0 );
	static final int PORT_Y = ( 1 );
	static final int PORT_Z = ( 2 );

	static final int PORT_I = ( 4 ); //??
       	static final int PORT_U = ( 6 );



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
	        boolean flg;
              	int dacX;
		int dacY;
		int dacZ;
                int  off;
		int  handle;
		int  point;
	        int  ubackup;
                int ucurrent;
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
               //new
              	Dxchg dxchg;
                
		datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

		UPoints         =   datain[i0];
                UCurves         =   datain[i0+1];
		UStart		=   datain[i0+2];    //integer  shl
		UStep		=   datain[i0+3];    //step shl
      		dt              =   datain[i0+4];
                flgSTM          =   datain[i0+5];

              M_DACX     = Simple.bramID("dxchg_X");
              M_DACY     = Simple.bramID("dxchg_Y");
              M_I        = Simple.bramID("m_ADC_I");
              M_U        = Simple.bramID("m_DAC_I");
              M_SELOPORA = Simple.bramID("m_sel_Uopora");


		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                 // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                 // 1
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,2,UPoints*UCurves,JVIO.FIFO,UPoints, 1);   //

		int[] dataout;
	     	dataout=new int[2*UPoints];
             // 	dataout=new int[2*UPoints];
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
    ubackup=Simple.bramRead(M_U);

    Simple.fcupBypass(0,true); //turn off   FB     false???

    Simple.Sleep(1000);

    // init dxchg
      dxchg = new Dxchg();
      dxchg.SetScanPorts( new int[] {-1,-1, -1,
                                     -1,-1, -1,
                                     -1,-1, -1} );
                        dxchg.SetO(PORT_U, ubackup);
                        dxchg.Wait(50);
               		dxchg.ExecuteScan();
         		dxchg.WaitScanComplete(-1);


  //
      Simple.bramWrite( M_SELOPORA, 0X80000000);     //use dchange for U
      Simple.Sleep(1000);

 // move to start point

      dacX =Simple.bramRead(M_DACX) ;
      dacY =Simple.bramRead(M_DACY) ;
      dacZ =0;
      int step;
      int kk;
      int dlt;
      dacU=ubackup;
      step=-start_step*DAC_STEP;
/*      dlt=(ubackup-UStart)>>16;
      if (dlt<0)
      {
        step=start_step*DAC_STEP;
	dlt=-dlt;
      }
       dxchg = new Dxchg();
       dxchg.SetScanPorts( new int[] {-1,-1, -1,
                                     -1,-1, -1,
                                     -1,-1, -1} );
        int nstep;
        nstep=dlt / start_step;
        int rest ;
        rest=dlt%start_step;
      for (kk=0; kk<nstep; kk++)
      {

          dxchg.SetO(PORT_U,dacU);
          dxchg.Wait(300);
          dacU+=step;
      }
          dxchg.SetO(PORT_U,dacU);
          dxchg.Wait(300);
          dacU+=rest;
      dxchg.ExecuteScan();
      dxchg.WaitScanComplete(-1);
  */
     int nstep;
     int rest;
 for (j=0; j<UCurves; j++)
 {
     step=-start_step*DAC_STEP;
      dlt=(dacU-UStart)>>16;
      if (dlt<0)
      {
        step=start_step*DAC_STEP;
	dlt=-dlt;
      }
       dxchg = new Dxchg();
       dxchg.SetScanPorts( new int[] {-1,-1, -1,
                                     -1,-1, -1,
                                     -1,-1, -1} );
        nstep=dlt / start_step;
        rest=dlt%start_step;
      for (kk=0; kk<nstep; kk++)
      {
          dxchg.SetO(PORT_U,dacU);
          dxchg.Wait(300);
          dacU+=step;
      }
          dacU+=rest;
          dxchg.SetO(PORT_U,dacU);
          dxchg.Wait(300);
         dxchg.ExecuteScan();
         dxchg.WaitScanComplete(-1);
         dxchg = new Dxchg();
         dxchg.SetScanPorts( new int[] {-1,-1, -1,
                                     -1,-1, -1,
                                     -1,-1, -1} );

  for(i=0; i<UPoints; i++)
  {
                               dxchg.SetO(PORT_U,dacU);
                               dxchg.Wait(dt);
                               dxchg.GetI(PORT_I);
                               dacU+=UStep;
  }


                      	// run
        		dxchg.ExecuteScan();
         		dxchg.WaitScanComplete(-1);
	        	arr = dxchg.GetResults();

    	//Read data Оставляем в массиве только нужные данные.

			dst_i = 0;
                        k=0;  ///
			for(i=0; i<UPoints; i++)
			{
			        dataout[k]=UStart+i*UStep;
                                dataout[k+1]=arr[dst_i];
                              	dst_i += 1;
                                k+=2;
			}

                          off=0;//UPoints;
                          rd=0;  wr=0;
    			 s =UPoints;// UPoints;

			for (;  wr != s; )
			{
		        	wr += stream_ch_data_out.WriteEx(dataout, off, s-wr, 1000);
                        }

                        stream_ch_data_out.Invalidate();

 //move to start point
  }// j Curves
     dacU-=UStep;
     step=-start_step*DAC_STEP;
     dlt=(dacU-ubackup)>>16;
     if (dlt<0)
     {
        step=start_step*DAC_STEP;
	dlt=-dlt;
     }
      dxchg = new Dxchg();
      dxchg.SetScanPorts( new int[] {-1,-1,-1,
                                     -1,-1,-1,
                                     -1,-1, -1}
                         );
  rest=dlt%start_step ;
  nstep=dlt/start_step;
 for (kk=0; kk<nstep; kk++)
 {
  dxchg.SetO(PORT_U,dacU);
  dxchg.Wait(300);
  dacU+=step;
 }
     dacU+=rest;
     dxchg.SetO(PORT_U,dacU);
     dxchg.Wait(300);
     dxchg.ExecuteScan();
     dxchg.WaitScanComplete(-1);

      Simple.Sleep(1000);

      Simple.bramWrite( M_SELOPORA, 0X00000000); //use bram for U

   //      Simple.bramWrite(M_U,ubackup);

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

















