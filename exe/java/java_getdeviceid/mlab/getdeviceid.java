package mlab;//060213  new ver

public class getdeviceid
{
        // chanels ID
	public static final int CH_STOP        = 0;
        public static final int CH_DRAWDONE    = 1;
        public static final int CH_DATA_OUT    = 2;

        public static final int pagesize_int   = 64;

        public static final int done=60;

        public static final int stop=100;

	public static void main(String[] arg)
	{
                int wr =0;
 		int rd =1;
 		int off =0;
                int[] data;
                int i;
         	data = new int[2];

                JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);
                JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
                JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,2, 1,JVIO.BUF,  1, 0);  // 2


   		      int[] buf_stop;
		      buf_stop = new int[1];
		      buf_stop[0] =0;
		      wr = stream_ch_stop.Write(buf_stop, 1, 1000);
		      stream_ch_stop.Invalidate();


                       Simple.DumpInt(0xAAAAAAAA);
                       
                      i = Simple.checkLinkAdj( 10000 ); // bit[0]  =1 0k; bit[32]=1 = busy


                       data[0] =  SetupDiag.getAdaptorVerId();  //SetupDiag.GetAdaptorType();
                                  // чтение VerId введено 30.01.13
	               data[1] =i;

                       Simple.DumpInt(data[0]);
                       Simple.DumpInt(i);          
                       Simple.DumpInt(0xBBBBBBBB);
                       wr=0; /////!!!!!
                        for (;  wr ==0; )
			{
				wr = stream_ch_data_out.Write(data,1, 1000);
			}

                      stream_ch_data_out.Invalidate();

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

















