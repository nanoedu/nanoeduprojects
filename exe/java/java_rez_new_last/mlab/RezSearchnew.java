//090916
// output full buffer
package mlab;

public class RezSearchnew
{
public static int M_DFI_PIN;
public static int M_A;
public static int M_A_REZ;
public static int M_PID_ON;
public static int M_F_K;  //modulation amplitude 0.015;

public static  int FREQ_START ;// = (int)((6000L << 32) / 1000000);
public static  int DELTA_FREQ ;//= (int)(( 10L  << 32) / 1000000);
public static  int FREQ_STEPS;// = 40;
public static  int   delay;

// chanels ID
public static final int CH_STOP     =0;
public static final int CH_DRAWDONE =1;
public static final int CH_RES_OUT  =2;
public static final int CH_DELAY_IN =3;
public static final int MakeSTOP =1;
public static final int stop =100;

   public static void main(String[] arg)
   {
       int[] datain;
       M_DFI_PIN=Simple.bramID("m_dfi_pin");
       M_A=Simple.bramID("m_A");
       M_A_REZ=Simple.bramID("m_A_rez");
       M_PID_ON=Simple.bramID("m_pid_On");
       M_F_K=Simple.bramID("m_F_k");
        datain=Simple.xchgGet("algoritmparams.bin");
        int i0=4;
        FREQ_START=datain[i0];
        DELTA_FREQ=datain[i0+1];
        FREQ_STEPS=datain[i0+2];
        delay     =datain[i0+3];

     JVIO stream_stop =     new JVIO(CH_STOP,     1, 1,JVIO.BUF, 1, 0);
     JVIO stream_drawdone = new JVIO(CH_DRAWDONE, 1, 1,JVIO.BUF, 1, 0);    //add on PC
     JVIO stream_res_out =  new JVIO(CH_RES_OUT,  2, FREQ_STEPS,JVIO.FIFO, FREQ_STEPS, 0);
     JVIO stream_delay =    new JVIO(CH_DELAY_IN, 1, 1,JVIO.BUF, 1, 0);
 	        int wr;
 		int rd =1;
 		int off =0;
                int[] buf_STOP;
                buf_STOP = new int[1];
                buf_STOP[0] =0;
                wr = stream_stop.Write(buf_STOP, 1, 1000);
                int[] buf_DRAWDONE;
		buf_DRAWDONE=new int[1];
                buf_DRAWDONE[0]=0;
		int rez_A;
		int rez_Freq;
		int[] arrA;
		int[] buf_delay;
                buf_delay = new int[1];
                buf_delay[0] = delay;
                wr = stream_delay.Write(buf_delay, 1, 1000);
		int k ;
		k =0;

		rez_A = 0;
		rez_Freq = 0;

        	Simple.bramWrite(M_PID_ON, 0);  //retract
               	int freq;
                freq = FREQ_START;
                Simple.bramWrite(M_DFI_PIN, freq);
               	Simple.Sleep(100);

		arrA = new int[2*FREQ_STEPS];
		for(int i=0; i<FREQ_STEPS; i++)
		{
	        
	        	int i_tmp;
                        rd = stream_stop.Read(buf_STOP, 1,100,false);
                        if (buf_STOP[0] == MakeSTOP)
                                {
                                  break;
                                 }
			freq = FREQ_START+i*DELTA_FREQ;
			Simple.bramWrite(M_DFI_PIN, freq);

			Simple.Sleep(delay);

			i_tmp = Simple.bramRead(M_A);
                        arrA[k] =freq;
			arrA[k+1] =  i_tmp;
                        k += 2;
			if ( i_tmp > rez_A )
			{
				rez_A = i_tmp;
				rez_Freq = freq;
			}
	        	rd = stream_delay.Read(buf_delay, 1, 100,false);////????/
                        delay = buf_delay[0];
		}
              	 wr=0;
	      	 int s = FREQ_STEPS;
	      	 for (;  wr != s; )
	      	 {
                          wr += stream_res_out.WriteEx(arrA, off, s-off, 1000);
	      	 }
                stream_res_out.Invalidate();

		Simple.bramWrite(M_PID_ON, 0x80000000);// protract
       		Simple.bramWrite(M_DFI_PIN, rez_Freq);
       		Simple.bramWrite(M_A_REZ,   rez_A);

   //      wait for PC answer

                buf_STOP[0]=2;
		wr=0;
                for(int i=0;buf_STOP[0]!=stop ;i++)
   	      {
                wr = stream_stop.Read(buf_STOP, 1,1000,false);
              }

               stream_delay.Close();
               stream_res_out.Close();
               stream_stop.Close();
  	       stream_drawdone.Close();

       //        Simple.Sleep(1000);

	//	Simple.xchgCreate("rezA256.dat", arrA);

	}
}
