package mlab;   //291112  //ok 1 page read

public class readfrommlpc
{
        // chanels ID
	public static final int CH_STOP        = 0;
        public static final int CH_DRAWDONE    = 1;
        public static final int CH_DATA_OUT    = 2;
        public static final int CH_PARAMS      = 3;

        public static final int pagesize   = 64;

        public static final int done=60;

        public static final int stop=100;
        public static final int mask=0x00000001;

	public static void main(String[] arg)
	{
                int wr =0;
 		int rd =0;
 		int off =0;
                int[] datain;

                int[] block_64 = new int[64];
                int[] dataread;
                int pages,pagenmb;
                int fpages,fpagenmb;
		int dataread_len;
		int i;
		int j;
                int res;

                datain=Simple.xchgGet("algoritmparams.bin");
                int i0 = 4;
                pages =   datain[i0];

                fpages=pages;
                fpagenmb=0;
                for (i=0;i<16; i++)
                {
                  res=fpages&mask;
                  if (res==1) {fpagenmb++;};
                 fpages=fpages>>1;
                }

                Simple.DumpInt(0xAAAAAAAA);
                Simple.DumpInt(fpagenmb);

                dataread_len =  fpagenmb*pagesize;
                dataread = new int [dataread_len];

       		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
                JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,pagesize,fpagenmb,JVIO.FIFO,1, 0);  // 2

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
                int k;
                int error;
                k=0;
               for( i=0; i<16  ; i++)
               {   res=( pages&mask);
                   if (res==1)
                   {
                    wr=0;
                    buf_drawdone[0] =0;
                    for(; wr!=1 ;)
                    {
                  	wr = stream_ch_drawdone.Write(buf_drawdone, 1, 1000);
                     }
                      stream_ch_drawdone.Invalidate();
                       Simple.DumpInt(0xAAAAAAAA);
                      Simple.DumpInt(k);
                      error=SetupDiag.ReadBlock(k,block_64);
                      Simple.DumpInt(0xAAAAAAAA);
                      Simple.DumpInt(error);
                      for(i=0;i<10; i++)
                        Simple.DumpInt(block_64[i]);
                      wr = 0;
                     for (;  wr != 1; )
		     {
			wr += stream_ch_data_out.WriteEx(block_64, wr, 1-wr, 1000);
		     }
                        stream_ch_data_out.Invalidate();
                    }
                    pages=pages>>1;
                    k=k+1;
                    rd=0;
                    for(;(buf_drawdone[0]!=done) ;)
                    {
                     rd = stream_ch_drawdone.Read(buf_drawdone, 1,10000,false);
                    }
              }

                 Simple.DumpInt(0xBBBBBBBB);
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

















