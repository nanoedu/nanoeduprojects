package mlab;    //changed  070416

public class Testsm
{
   public static  int M_DFI_PIN;
   public static  int M_A ;
   public static  int M_A_rez;
   public static  int M_BASE_K;
   public static  int M_PID_ON;
   public static  int M_smZ_ctrl;
   public static  int M_smZ_status;
   public static  int M_PID_out;
   public static  int M_I_BASE;         //?????
   public static  int M_I;
   public static  int M_sm_speed;
   public static  int M_Arez;

   public static final int steps=50;
   public static final int done=60;
   public static final int waitsteps=40;//0
   public static final int none=30;     //0
   public static final int stop=100;

   public static final int ok=          3;
   public static final int touch=       2;
   public static final int outlimit=    4;
   public static final int MakeSTOP =   1;
   public static final int stopdone =   5;

// chanels ID
   public static final int CH_STOP        = 0;
   public static final int CH_DATA_OUT    = 2;
   public static final int CH_PARAMS      = 3;
   public static final int CH_STEPS       = 1;




public static void main(String[] arg)
{
    int rd,wr,count,CurPosStepMotor;
    int SMZ_STEP,SIGNAL,LEVEL_SGL,Z;
    int [] debugZ, debugSteps, debugStatus;
    int RESAmpl,SET_POINT,ZMax,ZMin,NSTEPS, SPEED;
    int INTDELAY,SCANNERDECAY,NCYCLES;
    int STMFLG;
    int step;
    int process;
    int i;
    int CurPosMotorZ;
    int Z0;
    boolean Control;
    int maskMotorOn  = 0x00008000;       // or   - установка бита
    int maskMotorOff = 0xFFFF7FFF;           // and   - сброс бита
    int motorON = 1;

       M_A=Simple.bramID("m_A");
       M_PID_ON=Simple.bramID("m_pid_On");
       M_BASE_K=Simple.bramID("m_BaseK");
       M_I_BASE=Simple.bramID("m_I_BASE");
       M_I=Simple.bramID("m_ADC_I");
       M_PID_out=Simple.bramID("m_pid_out");
       M_smZ_status=Simple.bramID("m_smZ_status");
       M_smZ_ctrl=Simple.bramID("m_smZ_ctrl");
       M_sm_speed=Simple.bramID("speed");

    JVIO stream_ch_stop      = new JVIO(CH_STOP      ,1, 1,JVIO.BUF,  1, 0); 			// 0
    JVIO stream_ch_steps     = new JVIO(CH_STEPS     ,1, 1,JVIO.BUF,  1, 0);                    // 4
    JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT  ,2, 1,JVIO.BUF,  1, 0);                    // 2
    JVIO stream_ch_params    = new JVIO(CH_PARAMS    ,7, 1,JVIO.BUF,  1, 0);   //020212                 // 3
                       //1

        int[] datain;

        datain=Simple.xchgGet("algoritmparams.bin");

        int i0=4;


        ZMax  =       datain[i0+0]; //<<
        ZMin  =       datain[i0+1]; //<<
 	NSTEPS      = -datain[i0+2]; //<<
        INTDELAY    = datain[i0+3];
        SCANNERDECAY= datain[i0+4];
        SPEED       = datain[i0+5];
        NCYCLES     = datain[i0+6];
        STMFLG      = datain[i0+7];
               Simple.bramWrite(M_sm_speed,SPEED);
               int[] buf_params;
	       buf_params=new int[8];
               for(i=0; i<8; i++) buf_params[i]=datain[i+i0];
                wr=0;
                for (;  wr == 0; )
		{
                 wr = stream_ch_params.Write(buf_params, 1, 1000);
		}

                int[] buf_status;
		buf_status= new int[2];
	        buf_status[0]=(int)Simple.bramRead(M_PID_out);
                buf_status[1]=NSTEPS;//Simple.bramRead(M_smZ_status)>>16;

              CurPosStepMotor=Simple.bramRead(M_smZ_status);
              CurPosStepMotor = CurPosStepMotor |  maskMotorOn;         //turn on motor
              Simple.bramWrite(M_smZ_ctrl,CurPosStepMotor);
        	Z=0;
                int[] buf_stop;
                buf_stop = new int[1];
                buf_stop[0] =waitsteps;
                wr=0;
                for (;  wr == 0; )
		{
                  wr = stream_ch_stop.Write(buf_stop, 1, 1000);
	        }
               Simple.Sleep(200);
              //   while (count<3)
               Z0=(int)Simple.bramRead(M_PID_out);  // определить начальное положение Z
               Z=Z0;
             // проверить, в воротах ли Z

               step = NSTEPS;          // NSTEPS > 0 - сближение
                //  landing  goto min
                // Идти вниз до мин. точки
               while ( Z < ZMin )          // ZMax < Z < ZMin означает, что Z  в воротах
               	{
                         if (buf_stop[0] == MakeSTOP) break;                 // если "стоп" был прочитан ранее
                         rd=stream_ch_stop.Read(buf_stop, 1,300,true);
                         if (buf_stop[0] == MakeSTOP)
                            {
                               buf_status[0]=Z;
                               buf_status[1]=Simple.bramRead(M_smZ_status)>>16;
                               break;
                            }
                        Simple.bramWrite(M_PID_ON,0);      // втянуть;
                        Simple.Sleep(SCANNERDECAY);

                         SMZ_STEP=step+CurPosStepMotor;           // Шаги
                         Simple.bramWrite(M_smZ_ctrl,SMZ_STEP);
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smZ_status)== SMZ_STEP){wr=1;}}
                         CurPosStepMotor = SMZ_STEP;

                    if (STMFLG==1) {   Simple.bramWrite(M_PID_ON,0x40000000);} // pull ahead tip STM
                    else           {   Simple.bramWrite(M_PID_ON,0x80000000);} // pull ahead tip SFM
              //         Simple.bramWrite(M_PID_ON,0x80000000); // вытянуть острие
                         Simple.Sleep(INTDELAY);                //  ms
                         Z=(int)Simple.bramRead(M_PID_out);  // измерить положение Z
                                 buf_status[0]=Z;
                                 buf_status[1]=step >> 16;//Simple.bramRead(M_smZ_status)>>16;
                                  wr=0;
			         for (;  wr == 0; )
			         {
                                   wr = stream_ch_data_out.Write(buf_status,1,1000);
		                 }
				 stream_ch_data_out.Invalidate();
              };

              // циклическое хождение между воротами
              i=0;
            while(NCYCLES>i)
            {
                 if (buf_stop[0] == MakeSTOP) break;                 // если "стоп" был прочитан ранее
                 step=-NSTEPS;
                 while (Z > ZMax)                                    // идти вверх до верхних ворот
    		{
                         if (buf_stop[0] == MakeSTOP) break;                 // если "стоп" был прочитан ранее
                         rd=stream_ch_stop.Read(buf_stop, 1,300,true);
                         if (buf_stop[0] == MakeSTOP)
                            {
                               buf_status[0]=Z;
                               buf_status[1]= step >> 16;//Simple.bramRead(M_smZ_status)>>16;
                               break;
                            }
                   Simple.bramWrite(M_PID_ON,0);      // втянуть;
                   Simple.Sleep(SCANNERDECAY);

                        SMZ_STEP=step+CurPosStepMotor;           // Шаги
                         Simple.bramWrite(M_smZ_ctrl,SMZ_STEP);
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smZ_status)== SMZ_STEP){wr=1;}}
                           CurPosStepMotor = SMZ_STEP;
                    if (STMFLG==1) {   Simple.bramWrite(M_PID_ON,0x40000000);} // pull ahead tip STM
                    else           {   Simple.bramWrite(M_PID_ON,0x80000000);} // pull ahead tip SFM

                  //       Simple.bramWrite(M_PID_ON,0x80000000); // вытянуть острие
                         Simple.Sleep(INTDELAY);                //  ms


         	      //	  count=0;
                      //while (count<3)
                      Z=(int)Simple.bramRead(M_PID_out);  // измерить положение Z

                                 buf_status[0]=Z;
                                 buf_status[1]=step >> 16;//Simple.bramRead(M_smZ_status)>>16;
                                  wr=0;
			         for (;  wr == 0; )
			         {
                                   wr = stream_ch_data_out.Write(buf_status,1,1000);
		                 }
				 stream_ch_data_out.Invalidate();
              };

                step = NSTEPS;
                 while (Z  < ZMin)          // идти до нижних ворот
   		{
                    if (buf_stop[0] == MakeSTOP) break;                 // если "стоп" был прочитан ранее
                         rd=stream_ch_stop.Read(buf_stop, 1,300,true);
                         if (buf_stop[0] == MakeSTOP)
                            {
                               buf_status[0]=Z;
                               buf_status[1]= step >> 16;  //Simple.bramRead(M_smZ_status)>>16;
                               break;
                            }

                   Simple.bramWrite(M_PID_ON,0);      // втянуть;
                   Simple.Sleep(SCANNERDECAY);

                        SMZ_STEP=step+CurPosStepMotor;           // Шаги
                         Simple.bramWrite(M_smZ_ctrl,SMZ_STEP);
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smZ_status)== SMZ_STEP){wr=1;}}
                         CurPosStepMotor = SMZ_STEP;

                    if (STMFLG==1) {   Simple.bramWrite(M_PID_ON,0x40000000);} // pull ahead tip STM
                    else           {   Simple.bramWrite(M_PID_ON,0x80000000);} // pull ahead tip SFM
    //                 Simple.bramWrite(M_PID_ON,0x80000000); // вытянуть острие
                         Simple.Sleep(INTDELAY);                //  ms


         	      //	  count=0;
                      //while (count<3)
                      Z=(int)Simple.bramRead(M_PID_out);  // измерить положение Z

                                 buf_status[0]=Z;
                                 buf_status[1]=step >> 16;//Simple.bramRead(M_smZ_status)>>16;
                                  wr=0;
			         for (;  wr == 0; )
			         {
                                   wr = stream_ch_data_out.Write(buf_status,1,1000);
		                 }
				 stream_ch_data_out.Invalidate();
              };
             i=i+1;
          } //while cyclecount
                 step = - NSTEPS;
                  while (Z > Z0)                                    // идти вверх до Z0 (начальной позиции)
    		{
                         if (buf_stop[0] == MakeSTOP) break;                 // если "стоп" был прочитан ранее
                         rd=stream_ch_stop.Read(buf_stop, 1,300,true);
                         if (buf_stop[0] == MakeSTOP)
                            {
                               buf_status[0]=Z;
                               buf_status[1]= step >> 16; //Simple.bramRead(M_smZ_status)>>16;
                               break;
                            }

                   Simple.bramWrite(M_PID_ON,0);      // втянуть;
                   Simple.Sleep(SCANNERDECAY);

                        SMZ_STEP=step+CurPosStepMotor;           // Шаги
                         Simple.bramWrite(M_smZ_ctrl,SMZ_STEP);
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smZ_status)== SMZ_STEP){wr=1;}}
                         CurPosStepMotor = SMZ_STEP;

                  if (STMFLG==1) {   Simple.bramWrite(M_PID_ON,0x40000000);} // pull ahead tip STM
                    else           {   Simple.bramWrite(M_PID_ON,0x80000000);} // pull ahead tip SFM
//                   Simple.bramWrite(M_PID_ON,0x80000000); // вытянуть острие
                         Simple.Sleep(INTDELAY);                //  ms


         	      //	  count=0;
                      //while (count<3)
                      Z=(int)Simple.bramRead(M_PID_out);  // измерить положение Z

                                 buf_status[0]=Z;
                                 buf_status[1]=step >> 16;//Simple.bramRead(M_smZ_status)>>16;
                                  wr=0;
			         for (;  wr == 0; )
			         {
                                   wr = stream_ch_data_out.Write(buf_status,1,1000);
		                 }
				 stream_ch_data_out.Invalidate();
              };

              //**********
                     CurPosStepMotor = CurPosStepMotor & maskMotorOff;          // Сброс бита включения мотора  (бит номер 15)
                     Simple.bramWrite(M_smZ_ctrl,CurPosStepMotor);
                        buf_stop[0]=0;
         		rd=0;
                        for( i=0;buf_stop[0]!=stop;i++)
         	        {
         		   rd = stream_ch_stop.Read(buf_stop, 1,10000,false);
	         	}

                       stream_ch_params.Close();
                       stream_ch_data_out.Close();
                       stream_ch_stop.Close();
                       stream_ch_steps.Close();
 }   //main
} //class Testsm


