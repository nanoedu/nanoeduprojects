package mlab; //161211

public class test_TI
{
 public static final int M_DFI_PIN = 7;
 public static final int M_A = 3;
 public static final int M_A_rez = 4;
 public static final int M_BASE_K= 5;
 public static final int M_PID_ON = 10;
 public static final int M_smZ_ctrl=13;
 public static final int M_smZ_status=14;
 public static final int M_PID_out=20;


 public static final int done=60;

 public static final int stop=100;

// chanels ID
	public static final int CH_STOP        = 0;
	public static final int CH_DRAWDONE    = 1;
	public static final int CH_DATA_OUT    = 2;

   	static final int PORT_H = ( Port.IN | 2 );


public static void main(String[] arg)
{
    int rd,wr,count;
    int adcZ;
    int INTDELAY,SCANNERDECAY;
    int i;
    Port[] port;
    Span[] span_h;
    Scene scene;
    int handle;
  //  int point;
    JVIO stream_ch_stop      = new JVIO(CH_STOP      ,1, 1,JVIO.BUF,  1, 0); 			// 0
    JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE  ,1, 1,JVIO.BUF,  1, 0);                    // 1
    JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT  ,1, 1,JVIO.BUF,  1, 0);                    // 2
                       //1


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

              	int[] buf_dataout;
		buf_dataout = new int[1];
// main

        	span_h = new Span[] { new Span(2), new Span(1) };

		port = new Port[] { new Port(PORT_H,span_h)};

		scene = new Scene( port );

		for(handle=0;handle==0;)
		{
			handle = scene.createScene( scene.getTemplate(), 2 );
			if ( 0 == handle ) scene.releaseScene(0);
		}

    		       Simple.bramWrite(M_PID_ON,0);      // pull back;

		       Simple.Sleep(500);      //wait

                       Simple.bramWrite(M_PID_ON,0x80000000); // pull ahead tip
                       int tick;
                       Simple.timerSet(3000);
                       for (; (Simple.timerCheck()==false);)
                       {
                         adcZ = 0xFFFF0000 & scene.getPort( PORT_H );
                         tick=Simple.timerGetTimeout();
                           Simple.DumpInt(tick);
                         if (adcZ== 0x80000000)
                         {
                               Simple.DumpInt(10);
                          	buf_dataout[0]=tick;
                 		wr=0;
		              for (;  wr == 0; )
                		{
		                 wr = stream_ch_data_out.Write(buf_dataout, 1, 300);

                     		}
                            stream_ch_data_out.Invalidate();
                            break;
                         }
                         Simple.Sleep(50);
                       }
//

       		buf_drawdone[0]=done;

		Simple.DumpInt(done);

		wr=0;
		for (;  wr == 0; )
		{
			wr = stream_ch_drawdone.Write(buf_drawdone, 1, 300);
		}
                stream_ch_drawdone.Invalidate();

//		Simple.Sleep(1000);
     		rd=0;
		int ccnt = 0;
              //  for(;(buf_stop[0]!=stop) & (ccnt < 50) ;)

                for(;(buf_stop[0]!=stop) ;)
                {
//                  Simple.DumpInt(rd);
                  rd = stream_ch_stop.Read(buf_stop, 1,1000,false);
                  ccnt+=1;
                }
       		stream_ch_drawdone.Close();
		stream_ch_data_out.Close();
		stream_ch_stop.Close();


}   //main
    //
} //class test_TI


