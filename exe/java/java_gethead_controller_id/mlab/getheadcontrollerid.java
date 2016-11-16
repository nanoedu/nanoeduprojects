package mlab; //29.08.13

public class getheadcontrollerid
{
	static int b2(int i1,int i2,int i3,int i4)
	{
		return (i4<<24)|(i3<<16)|(i2<<8)|(i1);
	}
        static int b2i(int i1,int i2,int i3,int i4)
	{
		return (i1<<24)|(i2<<16)|(i3<<8)|(i4);
	}
	static int d2a(int dec)
	{
		dec = dec & 0xF;
		return dec>9 ? 'A'-10+dec : '0'+dec;
	}
	static int barr2i(byte arr[], int off)
	{
	int ret;
		ret  =  arr[off++] << 24;
		ret |=  arr[off++] << 16;
		ret |=  arr[off++] << 8;
		ret |=  arr[off++];
		return ret;
	}
	static int int2i(int r[], int p, int val )
	{
		return p;
	}
  // chanels ID
	public static final int CH_STOP        = 0;
        public static final int CH_DRAWDONE    = 1;
        public static final int CH_DATA_OUT    = 2;

        public static final int pagesize_int   = 64;

        public static final int done=60;

        public static final int stop=100;

	public static void main(String[] args)
	{
	int i;
	int p;
	int[] r;
        int wr =0;
        int rd =1;
	int off =0;
        int[] data;
         
//         	data = new int[2];

                data = new int[34];
                JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);
                JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                        // 1
                JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,34, 1,JVIO.BUF,  1, 0);  // 2


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
               
                byte[] at24buf = new byte[128];

		if ( 0 != SetupDiag.m_EERead( 0, at24buf ) )
			throw new Error();

		r = new int[at24buf.length/4];
		for(p=0,i=0; i<r.length; i++) 
		//	data[i+2] = b2i(at24buf[p++],at24buf[p++],at24buf[p++],at24buf[p++]);
                         
                        data[i+2] = b2(at24buf[p++],at24buf[p++],at24buf[p++],at24buf[p++]);
	
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