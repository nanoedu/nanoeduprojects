package mlab; //06.09.13     write user number of the  controller to the EEPROM

public class setcontrollerid
{
  	public static final int CH_STOP        = 0;
        public static final int CH_DRAWDONE    = 1;
        public static final int CH_DATA_OUT    = 2;
        public static final int CH_DATA_IN     = 3;

        public static final int numbersize   = 4;

        public static final int done=60;

        public static final int stop=100;

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

	public static void main(String[] args)
	{
	int i,j,s;
	int p;
	int[] r;
        int wr =0;
        int rd =1;
	int off =0;


            	JVIO stream_ch_stop      = new JVIO(CH_STOP,     1, 1,JVIO.BUF,  1, 0);                        // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE, 1, 1,JVIO.BUF,  1, 0);                        // 1
                JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT, 1, 1,JVIO.FIFO, 1, 0);                        // 2
                JVIO stream_ch_data_in   = new JVIO(CH_DATA_IN , numbersize, 1,JVIO.FIFO, 1, 0);

              	int[] buf_stop;
		buf_stop = new int[1];
		buf_stop[0] =0;
		wr = stream_ch_stop.Write(buf_stop, 1, 1000);
		stream_ch_stop.Invalidate();


   		int[] dataout;
	   	dataout=new int[1];

                int[] datain;
		datain = new int[numbersize];


		int[] buf_drawdone;
		buf_drawdone = new int[1];
		buf_drawdone[0] =0;
		wr = stream_ch_drawdone.Write(buf_drawdone, 1, 1000);


                byte[] at24buf = new byte[16];

                    rd=0;
                   for(;(rd!=1) ;)
                   {

                    rd = stream_ch_data_in.Read(datain, 1,-1,false);

                    }
/*               Simple.DumpInt(0xAAAAAAAA);
               Simple.DumpInt(0xBBBBBBBB);
               Simple.DumpInt(0xCCCCCCCC);
               Simple.Sleep(1000);
                      for (j=0; j<numbersize;j++)
                      {
                       Simple.DumpInt(datain[j]);

                      }
*/
                      int k=0;
              for( i=0; i<4 ; i++)
              { at24buf[k+0]=(byte)(datain[i]&0x000000FF);
                at24buf[k+1]=(byte)((datain[i]&0x0000FF00)>>8);
                at24buf[k+2]=(byte)((datain[i]&0x00FF0000)>>16);
                at24buf[k+3]=(byte)((datain[i]&0xFF000000)>>24);
                k=k+4;
              }
  /*              Simple.DumpInt(0xCCCCCCCC);
                   for (j=0; j<16;j++)
                      {
                       Simple.DumpInt(at24buf[j]);

                      }
*/
              if ( 0 != SetupDiag.m_EEWrite( 16, at24buf ) )
			throw new Error();


                  	wr=0;  s=1;
			for (;  wr != s; )
			{
                          wr += stream_ch_data_out.WriteEx(dataout, wr, s-wr, 1000);
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
              	stream_ch_data_in.Close();
            }
}