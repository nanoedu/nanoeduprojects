package mlab;
  //300617

public class Spectrstmnew
{
	static final int DAC_STEP =1<<16; // 65536*1;
        static final int start_step=100;
        static final int pause =50;
        public static  int M_I;
        public static  int M_U;
      	public static  int M_SELOPORA;


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

		datain=Simple.xchgGet("algoritmparams.bin");

                int i0=4;

		UPoints         =   datain[i0];
                UCurves         =   datain[i0+1];
		UStart		=   datain[i0+2];    //integer  shl
		UStep		=   datain[i0+3];    //step shl
      		dt              =   datain[i0+4];
                flgSTM          =   datain[i0+5];

              M_I        = Simple.bramID("m_ADC_I");
              M_U        = Simple.bramID("m_DAC_I");
              M_SELOPORA = Simple.bramID("m_sel_Uopora");


		JVIO stream_ch_stop      = new JVIO(CH_STOP,    1, 1,JVIO.BUF,  1, 0);                 // 0
		JVIO stream_ch_drawdone  = new JVIO(CH_DRAWDONE,1, 1,JVIO.BUF,  1, 0);                 // 1
		JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT,2,UPoints*UCurves,JVIO.FIFO,UPoints, 1);   //

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

     int[] code;
     int[] data_out;
     int[] path_in;
//////////////////////////////////////////////////////////////////
		code = new int[18];
//----- Заголовок -- "2D point" --------------------
		code[0]  = Dxchg2.CODE_SIGNATURE;
		code[1]  = 0x00030002;
		code[2]  = code.length;
//------------------ Код ----------------------------------------
// Вектор перемещения и позиция точки
                code[3]  = 0x00000000 + (12<<16) + (0<<0);
		code[4]  = 0x20000000;
// Контроль перемещения
                code[5]  = 0x00000000;
		code[6]  = 0x10000008;
// пауза после перемещения по z  береться из dataout
                code[7]  = 0x00008000 + (16<<16) + (0<<0);  //pause from dataout
		code[8]  = 0x00000000;
//GET  I
                code[9]  = 0x00000000 + (0<<16) + (14<<0);
                code[10] = 0x40000000 + pause - 1;
// Возврат
                code[11] = 0x80000000 + (3<<16) + 0;
//----- Список портов перемещения в точку ---------
		code[12] = 1;
		code[13] =PORT_U;
// Список портов измерения тока
		code[14] = 1;
		code[15] =PORT_I ;
// список портов ожидание воздействия
		code[16] =  1;
		code[17] = -1;
// Возврат
////////////////////////////////////////////////////////////////////

      Simple.bramWrite( M_SELOPORA, 0X80000000);     //use dchange for U
      Simple.Sleep(1000);

 // move to start point

      int step;
      int kk;
      int dlt;
      dacU=ubackup;
      step=-start_step*DAC_STEP;

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
        nstep=dlt / start_step;
        rest=dlt%start_step;

       data_out = new int[nstep+1];
       path_in = new int[2*(nstep+1)];
      i=0;
      for (kk=0; kk<nstep; kk++)
      {
                path_in[i++]=dacU;
                path_in[i++]=300;
                dacU+=step;
         }
         dacU+=rest;
         path_in[i++]=dacU;
         path_in[i++]=300;

         Dxchg2.ExecuteScan( path_in, data_out, code, 1 );

       data_out = new int[UPoints];
       path_in = new int[2*(UPoints)];
       i=0;
       for(i=0; i<UPoints; i++)
       {
                path_in[i++]=dacU;
                path_in[i++]=dt;
                dacU+=UStep;
       }

         Dxchg2.ExecuteScan( path_in, data_out, code, 1 );
         off=0;//UPoints;
         rd=0;  wr=0;
	 s =UPoints;// UPoints;

	for (;  wr != s; )
	{
        	wr += stream_ch_data_out.WriteEx(data_out, off, s-wr, 1000);
       }
       stream_ch_data_out.Invalidate();
      //move to start point
  }// j Curves

  //move to
     dacU-=UStep;
     step=-start_step*DAC_STEP;
     dlt=(dacU-ubackup)>>16;
     if (dlt<0)
     {
        step=start_step*DAC_STEP;
	dlt=-dlt;
     }
     rest=dlt%start_step ;
     nstep=dlt/start_step;

       data_out = new int[nstep+1];
       path_in = new int[2*(nstep+1)];
      i=0;
      for (kk=0; kk<nstep; kk++)
      {
                path_in[i++]=dacU;
                path_in[i++]=300;
                dacU+=step;
         }
         dacU+=rest;
         path_in[i++]=dacU;
         path_in[i++]=300;

      Dxchg2.ExecuteScan( path_in, data_out, code, 1 );

      Simple.Sleep(1000);

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

















