package mlab;

public class SetRate
{
       public static int[] SetRate( int DELAY, int DELAYBW, int DiscrNumInMicroStep)   // st1 = +-1
	{
	  int[] res;
          res = new int[2];
          int LV;
          int LVBw;
          int LSnom;
  	  if (DELAY > DELAYBW)
           {
                 LSnom =((DiscrNumInMicroStep<<1) /DELAY)<<14;  //DiscrNumInMicroStep уже сдвинут на 16 при чтении
                 LV=  DiscrNumInMicroStep;//1<<16;                
                 LVBw=LV*DELAY/DELAYBW;
                 LV=-LV;
                 Simple.bramWrite( Simple.bramID("m_ustep"), LSnom );
           }
         else
           {
                LSnom =((DiscrNumInMicroStep<<1) /DELAYBW)<<14;  //DiscrNumInMicroStep уже сдвинут на 16 при чтении
                LVBw= DiscrNumInMicroStep;// 1<<16;
                LV=LVBw*DELAYBW/DELAY;
                LV=-LV;                
                Simple.bramWrite( Simple.bramID("m_ustep"), LSnom );
            }
           res[0]=LV;
           res[1]=LVBw;	 
           return(res);
	}
}
