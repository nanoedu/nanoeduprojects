package mlab; // 161026 correction add z to channel out
//261012     ok

public class mover
{
 public static  int M_smZ_ctrl;
 public static  int M_smZ_status;
 public static  int M_smX_ctrl;
 public static  int M_smX_status;
 public static  int M_smY_ctrl;
 public static  int M_smY_status;
 public static  int M_sm_speed;
 public static  int M_BASE_K;
 public static  int M_PID_ON;
 public static  int M_PID_out;
 public static  int M_I_BASE;         //?????
 public static  int M_I;
    public static final int steps=50;
    public static final int done=60;
    public static final int waitsteps=40;//0
    public static final int none=30;     //0
    public static final int stop=100;

    public static final int MakeSTOP =   1;
    public static final int stopdone =   5;


    public static final int  MinStepsVal=0xFFFFFFFF;
    public static final int  MaxStepsVal=0x7FFFFFFF;

// chanels ID
	public static final int CH_STOP        = 0;
        public static final int CH_STEPS       = 1;
      	public static final int CH_DATA_OUT    = 2;
        public static final int CH_PARAMS      = 3;




public static void main(String[] arg)
{
    int rd,wr,count,CurPosMotor,CurPosMotorX,CurPosMotorY,CurPosMotorZ,STMFLG;
    int Z,SM_STEP,Speed,SET_POINT;
    int NSTEPS,flgMotor;
    int i;
    boolean flgsetzero;
    boolean flgstep;
  //  changed 26.04.16
     int maskMotorOn =  0x00008000;          // or   - установка бита
     int maskMotorOff = 0xFFFF7FFF;         // and   - сброс бита

  //  int maskMotorOn =  0x00008000;          // or   - установка бита
   // int maskMotorOff = 0xFFFF7FFF;         // and   - сброс бита
//    public static final int  MaxStepsVal=0x7FFFFFFF;
    int maskTopLimit = 0x02000000;         // and   - проверка равенства 0 бита крайнего верхнего положения
					   // при достижении крайнего верхнего положения 6-ой бит слева в ячейке DIN
                                           // становится =0 (0xFDF00000)
					   // 7-й  контакт  разъема J11, DIO 6  - цифровая земля
					   // 15-й контакт - сигнал концевика

	int temp;
	temp = 0;

       M_smZ_status=Simple.bramID("m_smZ_status");
       M_smZ_ctrl=Simple.bramID("m_smZ_ctrl");
       M_smX_status=Simple.bramID("m_smX_status");
       M_smX_ctrl=Simple.bramID("m_smX_ctrl");
       M_smY_status=Simple.bramID("m_smY_status");
       M_smY_ctrl=Simple.bramID("m_smY_ctrl");
       M_sm_speed=Simple.bramID("speed");
       M_PID_ON=Simple.bramID("m_pid_On");
       M_BASE_K=Simple.bramID("m_BaseK");
       M_I_BASE=Simple.bramID("m_I_BASE");
       M_I=Simple.bramID("m_ADC_I");
       M_PID_out=Simple.bramID("m_pid_out");


    JVIO stream_ch_stop      = new JVIO(CH_STOP      ,1, 1,JVIO.BUF,  1, 0);   //0
    JVIO stream_ch_steps     = new JVIO(CH_STEPS     ,1, 1,JVIO.BUF,  1, 0);   // 4
    JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT  ,2, 1,JVIO.BUF,  1, 0);   // nstep,  z
    JVIO stream_ch_params    = new JVIO(CH_PARAMS    ,3, 1,JVIO.BUF,  1, 0);   //020212                 // 3

        int[] datain;

        datain=Simple.xchgGet("algoritmparams.bin");


        int i0=4;
  	NSTEPS   = datain[i0];     //<<
        flgMotor = datain[i0+1];
        Speed    = datain[i0+2];
        SET_POINT= datain[i0+3];
        STMFLG   = datain[i0+4];
                int[] buf_step;
                buf_step = new int[1];
                buf_step[0] =waitsteps;
                wr = stream_ch_steps.Write(buf_step, 1, 1000);

                int[] buf_params;
                int[] buf_status;
            //  	buf_status=new int[1];
            	buf_status=new int[2];
              	buf_status[0]=none;
                Z=(int)Simple.bramRead(M_PID_out);
                 buf_status[1]=Z;
      		buf_params=new int[3];
                for(i=0; i<3; i++) buf_params[i]=datain[i+i0];
                 wr=0;
                for (;  wr == 0; )
		{
                 wr = stream_ch_params.Write(buf_params, 1, 1000);
		}
          if (STMFLG==1) {   Simple.bramWrite(M_I_BASE, SET_POINT);}  //  STM
          else           {   Simple.bramWrite(M_BASE_K, SET_POINT);}  //  SFM

          CurPosMotorZ=Simple.bramRead(M_smZ_status);
          CurPosMotorX=Simple.bramRead(M_smX_status);
          CurPosMotorY=Simple.bramRead(M_smY_status);
          CurPosMotor=CurPosMotorX;

          switch (flgMotor)
{
 case 2:
           CurPosMotor=CurPosMotorX;
           break;
 case 3:
           CurPosMotor=CurPosMotorY;
           break;
 case 4:
           CurPosMotor=CurPosMotorZ;
           break;
}
                Simple.bramWrite(M_sm_speed,Speed);
                int[] buf_stop;
                buf_stop = new int[1];
                buf_stop[0] =waitsteps;

///  main cycle

  for (; buf_stop[0] != MakeSTOP;)
 {
                   Simple.Sleep(200);
                   rd=stream_ch_stop.Read(buf_stop, 1,300,true);
                   if (buf_stop[0] == MakeSTOP)
                            {
				buf_step[0]=done;
                                break;
                            }

                   //   read buffers params
			rd=0;
		    for (;  rd == 0; )
			{
			 rd = stream_ch_params.Read(buf_params, 1,200,true);
			}
                     NSTEPS      = buf_params[0]; //<<
                     flgMotor    = buf_params[1];
                     Speed       = buf_params[2];
     	          //	 Simple.bramWrite(M_PID_ON,0);      // pull back;
 			 Simple.Sleep(200);
/*

                         switch (flgMotor)
{
 case 2:
           CurPosMotorX=Simple.bramRead(M_smX_status);
           CurPosMotor=CurPosMotorX;
           break;
 case 3:
           CurPosMotorY=Simple.bramRead(M_smY_status);
           CurPosMotor=CurPosMotorY;
           break;
 case 4:
           CurPosMotorZ=Simple.bramRead(M_smZ_status);
           CurPosMotor=CurPosMotorZ;
           break;
}
                  flgsetzero=false;
                  Simple.bramWrite(M_sm_speed,Speed);
                  CurPosMotor = CurPosMotor & maskMotorOff;          // Сброс бита включения мотора  (бит номер 15)
                  if (NSTEPS>0)
                         {if  ((CurPosMotor+NSTEPS) >= (MaxStepsVal-NSTEPS))
                          {
                            flgsetzero=true;
                           }
                         }
                  if (NSTEPS<0)
                         {if  ((CurPosMotor+NSTEPS) <= (MinStepsVal-NSTEPS))
                          {
                           flgsetzero=true;
                          }
                         }
*/
                    flgsetzero=true;
//Simple.Sleep(200);
 if (flgsetzero==true)
 {

                                    switch (flgMotor)
                           {
 case 2:
//Simple.DumpInt( 0xA5A50000 );
//Simple.DumpInt( 0& maskMotorOff );
//                         Simple.Sleep(20);
                           Simple.bramWrite(M_smX_ctrl,0& maskMotorOff);      // обнуление счетчика шагов
                           CurPosMotorX=0;
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smX_status)== 0){wr=1;}}
//temp = Simple.bramRead(M_smX_status);
                           break;
 case 3:
            //             Simple.Sleep(20);
                           Simple.bramWrite(M_smY_ctrl,0& maskMotorOff);      // обнуление счетчика шагов
                           CurPosMotorY=0;
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smY_status)== 0){wr=1;}}
                           break;
 case 4:
        //                 Simple.Sleep(20);
                           Simple.bramWrite(M_smZ_ctrl,0& maskMotorOff);      // обнуление счетчика шагов
                           CurPosMotorZ=0;
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smZ_status)== 0){wr=1;}}
                           break;
                          }   //case
}  //setzero
         //Simple.Sleep(20) ;
       switch (flgMotor)
 {
 case 2:  //x
                         SM_STEP=NSTEPS+CurPosMotorX;
   	        	 SM_STEP  = SM_STEP |  maskMotorOn;                     // включение мотора
//Simple.DumpInt( 0xA5A5000A );
//Simple.DumpInt( SM_STEP );
//                       Simple.Sleep(20);

                         Simple.bramWrite(M_smX_ctrl,SM_STEP);
//Simple.DumpInt( temp );
			  wr=0;
			 for (;  wr == 0; )
			 {if (Simple.bramRead(M_smX_status)== SM_STEP){wr=1;}}
//Simple.DumpInt( Simple.bramRead(M_smX_status) );
                         CurPosMotorX = SM_STEP;
                         CurPosMotor=CurPosMotorX ;
                         break;
 case 3:  //y
                         SM_STEP=NSTEPS+CurPosMotorY;
  	        	 SM_STEP  = SM_STEP |  maskMotorOn;                     // включение мотора
//                           Simple.Sleep(20);
                         Simple.bramWrite(M_smY_ctrl,SM_STEP);
			  wr=0;
			 for (;  wr == 0; )
			 {if (Simple.bramRead(M_smY_status)== SM_STEP){wr=1;}}
                         CurPosMotorY = SM_STEP;
			 CurPosMotor=CurPosMotorY ;
                         break;
 case 4:   //z
                        SM_STEP=NSTEPS+CurPosMotorZ;
	        	SM_STEP  = SM_STEP |  maskMotorOn;                     // включение мотора
//                           Simple.Sleep(20);
                        Simple.bramWrite(M_smZ_ctrl,SM_STEP);
			 wr=0;
			 for (;  wr == 0; )
			  {if (Simple.bramRead(M_smZ_status)== SM_STEP){wr=1;}}
                         CurPosMotorZ = SM_STEP;
			 CurPosMotor=CurPosMotorZ ;
                         break;
        }  //case
                          buf_status[0]=NSTEPS>>16;//(CurPosMotor>>16);
                           Z=(int)Simple.bramRead(M_PID_out);
                          buf_status[1]=Z;
                          wr=0;
            		   for (;  wr == 0; )
	    		    {
                              wr = stream_ch_data_out.Write(buf_status,1,1000);
	     	            }
	   		 stream_ch_data_out.Invalidate();
                    //    if (STMFLG==1) {   Simple.bramWrite(M_PID_ON,0x40000000);} // pull ahead tip STM
                    //    else           {   Simple.bramWrite(M_PID_ON,0x80000000);} // pull ahead tip SFM

                         Simple.Sleep(200);      //add 220316


}// not stop
    //   Stop JAVA
                  CurPosMotor = CurPosMotor & maskMotorOff;          //add 04/05/16

             switch (flgMotor)
                           {
 case 2:
                     //      Simple.bramWrite(M_smX_ctrl,CurPosMotor);          // Отключение мотора
                           Simple.bramWrite(M_smX_ctrl,0& maskMotorOff);      // обнуление счетчика шагов
                           CurPosMotorX=0;
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smX_status)== 0){wr=1;}}
                           break;
 case 3:
                       //    Simple.bramWrite(M_smY_ctrl,CurPosMotor);          // Отключение мотора
                           Simple.bramWrite(M_smY_ctrl,0& maskMotorOff);                    // обнуление счетчика шагов
                           CurPosMotorY=0;
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smY_status)== 0){wr=1;}}
                           break;
 case 4:
                     //      Simple.bramWrite(M_smZ_ctrl,CurPosMotor);          // Отключение мотора
                           Simple.bramWrite(M_smZ_ctrl,0& maskMotorOff);      // обнуление счетчика шагов
                           CurPosMotorZ=0;
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smZ_status)== 0){wr=1;}}
                           break;
                          }   //case                         	wr=0;

                       	buf_step[0]=done;
                          wr=0;
  	  		   for (;  wr == 0; )
  	  		    {
                           wr = stream_ch_steps.Write(buf_step,1,1000);
  	 	            }
                       stream_ch_steps.Invalidate();

                     	Simple.Sleep(1000);

   		rd=0;
                for( i=0;buf_stop[0]!=stop;i++)
       	        {
       	    	   rd = stream_ch_stop.Read(buf_stop, 1,10000,false);
       	    	}
                	Simple.Sleep(100);
                       stream_ch_params.Close();
                       stream_ch_stop.Close();
                       stream_ch_data_out.Close();
                       stream_ch_steps.Close();

}   //main

} //class mover


