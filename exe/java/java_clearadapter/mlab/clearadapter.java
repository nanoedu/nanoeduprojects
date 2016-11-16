package mlab; // 20 12 12

public class clearadapter
{
  // chanels ID
	public static final int CH_STOP        = 0;
        public static final int CH_DRAWDONE    = 1;
        public static final int CH_DATA_OUT    = 2;
        public static final int CH_DATA_IN     = 3;

        public static final int pagesize   = 64;

        public static final int done=60;

        public static final int stop=100;

	public static void main(String[] arg)
	{
                int wr,s =0;
 		int rd =1;
 		int off =0;
                int[] datain;

                int[] block_64 = new int[64];
      		int adpage,pagesnmb;
		int i;
		int j;
                int nw;

       		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
                JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,1,7,JVIO.FIFO,1, 0);  // 2
                JVIO stream_ch_data_in   = new JVIO(CH_DATA_IN ,64, 1,JVIO.FIFO, 1, 0);

           	int[] dataout;

	   	dataout=new int[16];

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



                 for (i=0; i < 16; i++)
                      {
                          adpage=i;
                          for   (j=0; j<pagesize; j++)
                          {
                           block_64[j] = 0xFFFFFFFF;
                          }
                          nw=SetupDiag.WriteBlock(adpage, block_64);
                          dataout[0]=adpage;
                      	wr=0;  s=1;
			for (;  wr != s; )
			{
                          wr += stream_ch_data_out.WriteEx(dataout, wr, s-wr, 1000);
			}
			stream_ch_data_out.Invalidate();
                      }

                Simple.DumpInt( 0xAAAAAAAA );

              	buf_drawdone[0]=done;

		wr=0;
		for (;  wr == 0; )
		{
                  wr = stream_ch_drawdone.Write(buf_drawdone, 1, 300);
		}
                stream_ch_drawdone.Invalidate();

		Simple.Sleep(1000);


               for(;(buf_stop[0]!=stop) ;)
                {

                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);

                }

       		stream_ch_drawdone.Close();
                stream_ch_data_out.Close(); 
		stream_ch_stop.Close();

	}

  

}

















