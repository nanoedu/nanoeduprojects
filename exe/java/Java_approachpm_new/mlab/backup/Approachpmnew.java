package mlab;        //changed z indication 070416
 //13.11.14  overflow
// 26/04/2013 введена проверка на достижение верхнего крайнего положения
// 17/06/13  теперь проверка на достижение верхнего крайнего положения делается по
// флагу, переданному с ПК


public class Approachpmnew
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
public static  int DIN;

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
//	public static final int CH_DRAWDONE    = 1;
	public static final int CH_DATA_OUT    = 2;
        public static final int CH_PARAMS      = 3;
        public static final int CH_STEPS       = 1;

    public static final int  MaxStepsVal=0x7FFFFFFF;

    public static final int  MinStepsVal=0xFFFFFFFF;




public static void main(String[] arg)
{
    int rd,wr,count,CurPosStepMotor;
    int SMZ_STEP,SIGNAL,SIGNALM,LEVEL_SGL,Z;
    int [] debugZ, debugSteps, debugStatus;
    int RESAmpl,SET_POINT,GATE_Z_MAX,GATE_Z_MIN,SIGNAL_LEVEL,NSTEPS,STMFLG,SPEED, FLG_CHECKTOP;
    int INTDELAY,SCANNERDECAY,FLGONESTEP;
    int process;
    int i;
    int CurPosMotorZ;
    boolean Control;
    int lstatus, idin;

    int maskMotorOn  = 0x00008000;          // or   - установка бита
    int maskMotorOff = 0xFFFF7FFF;         // and   - сброс бита
    int maskTopLimit = 0x02000000;         // and   - проверка равенства 0 бита крайнего верхнего положения
					   // при достижении крайнего верхнего положения 6-ой бит слева в ячейке DIN
                                           // становится =0 (0xFDF00000)
					   // 7-й  контакт  разъема J11, DIO 6  - цифровая земля
					   // 15-й контакт - сигнал концевика


       M_A=Simple.bramID("m_A");
       M_PID_ON=Simple.bramID("m_pid_On");
       M_BASE_K=Simple.bramID("m_BaseK");
       M_I_BASE=Simple.bramID("m_I_BASE");
       M_I=Simple.bramID("m_ADC_I");
       M_PID_out=Simple.bramID("m_pid_out");
       M_smZ_status=Simple.bramID("m_smZ_status");
       M_smZ_ctrl=Simple.bramID("m_smZ_ctrl");
       M_sm_speed=Simple.bramID("speed");
   //  M_Arez=Simple.bramID("m_A_rez");
	DIN = Simple.bramID("din");

    JVIO stream_ch_stop      = new JVIO(CH_STOP      ,1, 1,JVIO.BUF,  1, 0); 			// 0
    JVIO stream_ch_steps     = new JVIO(CH_STEPS     ,1, 1,JVIO.BUF,  1, 0);                    // 4
    JVIO stream_ch_data_out  = new JVIO(CH_DATA_OUT  ,4, 1,JVIO.BUF,  1, 0);                    // 2
    JVIO stream_ch_params    = new JVIO(CH_PARAMS    ,10,1,JVIO.BUF,  1, 0);   //020212                 // 3
                       //1

        int[] datain;

        datain=Simple.xchgGet("algoritmparams.bin");

        int i0=4;

        SET_POINT   = datain[i0]; //<<
        GATE_Z_MAX  = datain[i0+1]; //<<
        GATE_Z_MIN  = datain[i0+2]; //<<
        SIGNAL_LEVEL= datain[i0+3]; //<<
	NSTEPS      = datain[i0+4]; //<<
        INTDELAY    = datain[i0+5];
        SCANNERDECAY= datain[i0+6];
        STMFLG      = datain[i0+7];
        SPEED       = datain[i0+8];
	FLG_CHECKTOP = datain[i0+9];

     //      RESAmpl=Simple.Read(M_A_res);

//             for(i=0; i<10; i++) Simple.DumpInt(datain[i+i0]);


                int[] buf_step;
                buf_step = new int[1];
                buf_step[0] =waitsteps;
                wr = stream_ch_steps.Write(buf_step, 1, 1000);

                int[] buf_DRAWDONE;
         	buf_DRAWDONE=new int[1];

                int[] buf_params;
		buf_params=new int[10];
                for(i=0; i<10; i++) buf_params[i]=datain[i+i0];
                 wr=0;
                for (;  wr == 0; )
		{
                 wr = stream_ch_params.Write(buf_params, 1, 1000);
		}

                CurPosMotorZ=Simple.bramRead(M_smZ_status);
                int[] buf_status;
		buf_status= new int[4];
		buf_status[0]=none;
	        buf_status[1]=(int)Simple.bramRead(M_PID_out);
                buf_status[2]=(int)Simple.bramRead(M_A);      //ADC_UAM;
                buf_status[3]=0;//Simple.bramRead(M_smZ_status)>>16;

  //            Simple.DumpInt(0xBBBBBBBB);

          if (STMFLG==1) {   Simple.bramWrite(M_I_BASE, SET_POINT);} //  STM
          else           {   Simple.bramWrite(M_BASE_K, SET_POINT);}  //  SFM

               CurPosStepMotor =Simple.bramRead(M_smZ_status);
               CurPosStepMotor = CurPosStepMotor |  maskMotorOn;
               Simple.bramWrite(M_smZ_ctrl, CurPosStepMotor);
        	Z=0;
                SIGNAL=0;
                if (STMFLG==1){   SIGNAL=Simple.bramRead(M_I);
                                //  if (SIGNAL<0) {SIGNAL=-SIGNAL;};
                              } //  STM
                else          {   SIGNAL=Simple.bramRead(M_A);};  //  SFM

                int[] buf_stop;
                buf_stop = new int[1];
                buf_stop[0] =waitsteps;
                wr=0;

                for (;  wr == 0; )
		{
                  wr = stream_ch_stop.Write(buf_stop, 1, 1000);
	        }
                 stream_ch_stop.Invalidate();

//  main cycle
   		lstatus = none;

                for (; buf_stop[0] != MakeSTOP;)
             	 {
                   Simple.Sleep(400);
                     rd=stream_ch_stop.Read(buf_stop, 1,300,true);

                        if (buf_stop[0] == MakeSTOP)
                            {
				buf_status[0]=stopdone;
                                buf_status[1]=Z;
                                buf_status[2]=SIGNAL;
                                buf_status[3]=0;//Simple.bramRead(M_smZ_status)>>16;
                         	buf_step[0]=done;
                                break;
                            }

                     //   read buffers params
			rd=0;
                      for (;  rd == 0; )
		      {
			 rd = stream_ch_params.Read(buf_params, 1,200,true);
		      }
                     SET_POINT    = buf_params[0]; //<<     used setuserparams
                     GATE_Z_MAX   = buf_params[1]; //<<
                     GATE_Z_MIN   = buf_params[2]; //<<
                     SIGNAL_LEVEL = buf_params[3]; //<<
                     NSTEPS       = buf_params[4]; //<<
                     INTDELAY     = buf_params[5];
                     SCANNERDECAY = buf_params[6];
                     STMFLG       = buf_params[7];
                     SPEED        = buf_params[8];
	             FLG_CHECKTOP = buf_params[9];

                    Simple.bramWrite(M_sm_speed,SPEED);


                    if (STMFLG==1) {   Simple.bramWrite(M_I_BASE, SET_POINT);} //  STM
                    else           {   Simple.bramWrite(M_BASE_K, SET_POINT);}  //  SFM


                    if (STMFLG==1) {   Simple.bramWrite(M_PID_ON,0x40000000);} // pull ahead tip STM
                    else           {   Simple.bramWrite(M_PID_ON,0x80000000);} // pull ahead tip SFM

	       	   Simple.Sleep(INTDELAY);                //  ms

                   //
                      if (NSTEPS>=0)
	   		{
                   	  Z=(int)Simple.bramRead(M_PID_out);

                           if (STMFLG==1) {   SIGNAL=Simple.bramRead(M_I);
                                            SIGNALM= SIGNAL;
                                            if (SIGNAL<0) {SIGNALM=-SIGNAL;};
                                          } //  STM
                            else          {   SIGNAL=Simple.bramRead(M_A);
                                             SIGNALM= SIGNAL;
                                          };  //  SFM


			  if (Z >= GATE_Z_MIN)
			    {
                              buf_step[0]=done;
                             //too close!
                              buf_status[0]=touch;
                              buf_status[1]=Z;
                              buf_status[2]=SIGNAL;
                              buf_status[3]=0;//Simple.bramRead(M_smZ_status)>>16;
				wr=0;
			     for (;  wr == 0; )
			      {
                               wr = stream_ch_data_out.Write(buf_status,1,1000);
		              }
    			      stream_ch_data_out.Invalidate();
                              break;
                       	    }    //z>=
                             Control=false;

                             if (STMFLG==1) {  for(i=0; i<80; i++)
          			        	{
                                                  SIGNAL=Simple.bramRead(M_I);
                                                  SIGNALM= SIGNAL;
                                                  if (SIGNAL<0) {SIGNALM=-SIGNAL;};
                             		          Simple.Sleep(5);
                                                  if (SIGNALM >=SIGNAL_LEVEL) {Control=true; break; };
						}
					    }

                             else           { for(i=0; i<10; i++)
          			        	{
                                                  SIGNAL=Simple.bramRead(M_A);
                              		          Simple.Sleep(10);
						 if (SIGNAL <=SIGNAL_LEVEL) {Control=true; break;};
                                                }
                                             }
                          if (Control) //(SIGNAL <=SIGNAL_LEVEL)
                           {
			      if (Z>=GATE_Z_MAX)
			       { count=0;
				 for(i=0; i<10; i++)
				 {
				   Z=(int)Simple.bramRead(M_PID_out);
				   if (Z>=GATE_Z_MAX) {  count = count+1;}
				   Simple.Sleep(10);
                                  };
                                if (count >=3)
                                {
			         //O'K   stop script
                                 buf_step[0]=done;
				 buf_status[0]=ok;
				 buf_status[1]=Z;
                                 buf_status[2]=SIGNAL;
                                 buf_status[3]=0;//Simple.bramRead(M_smZ_status)>>16;
                                  wr=0;
			         for (;  wr == 0; )
			         {
                                   wr = stream_ch_data_out.Write(buf_status,1,1000);
		                 }
				 stream_ch_data_out.Invalidate();
                                 break;
                                }//ok
			       }//z>
         		   }
                        }     //NSTEPS>0
                       if (NSTEPS<0)          //remove     check the top position
                        { // test  top over limit
			  lstatus = none;
			    if (FLG_CHECKTOP == 1)
			      {
                        	// test  top over limit
                          	idin = Simple.bramRead(DIN);
			  	if ((idin & maskTopLimit) == 0) { lstatus = outlimit;} // Проверка достижения крайнего верхнего положения
       		  	      }
                          Z=(int)Simple.bramRead(M_PID_out);
                          if (STMFLG==1) {   SIGNAL=Simple.bramRead(M_I);
                                           //  if (SIGNAL<0) {SIGNAL=-SIGNAL;};
                                         } //  STM
                            else         {   SIGNAL=Simple.bramRead(M_A);}; //  SFM

		        }
      			 Simple.bramWrite(M_PID_ON,0);      // pull back;
 			 Simple.Sleep(SCANNERDECAY);
                      if (NSTEPS>0)          //approach
                      {
                       if  ((CurPosStepMotor+NSTEPS) >= (MaxStepsVal-NSTEPS))
                         {
                           CurPosStepMotor = CurPosStepMotor & maskMotorOff;          // Сброс бита включения мотора  (бит номер 15)
                           Simple.bramWrite(M_smZ_ctrl,CurPosStepMotor);              // Отключение мотора
                           Simple.bramWrite(M_smZ_ctrl,0& maskMotorOff);              // Обнуление счетчика шагов
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smZ_status)== 0){wr=1;}}
                           CurPosStepMotor=0;
                           CurPosStepMotor = CurPosStepMotor |  maskMotorOn;          // включение мотора
                          }
                      }
                      if (NSTEPS<0)        //remove
                      {
                      if  ((CurPosStepMotor+NSTEPS) <= (MinStepsVal-NSTEPS))
                         {
                           CurPosStepMotor = CurPosStepMotor & maskMotorOff;          // Сброс бита включения мотора  (бит номер 15)
                           Simple.bramWrite(M_smZ_ctrl,CurPosStepMotor);              // Отключение мотора
                           Simple.bramWrite(M_smZ_ctrl,0& maskMotorOff);              // Обнуление счетчика шагов
                           wr=0;
                           for (;  wr == 0; )
			   {if (Simple.bramRead(M_smZ_status)== 0){wr=1;}}
                           CurPosStepMotor=0;
                           CurPosStepMotor = CurPosStepMotor |  maskMotorOn;          // включение мотора
                         }
                      }
       //make steps
                         CurPosStepMotor = CurPosStepMotor |  maskMotorOn;          // включение мотора
                         SMZ_STEP=NSTEPS+CurPosStepMotor;
                         Simple.bramWrite(M_smZ_ctrl,SMZ_STEP);
			 wr=0;
			 for (;  wr == 0; )
			 {if (Simple.bramRead(M_smZ_status)== SMZ_STEP){wr=1;}}

                         CurPosStepMotor = SMZ_STEP& maskMotorOff; //changed 040516
      /*   changed 070416
			 buf_status[0]=lstatus;//none;
			 buf_status[1]=Z;
                         buf_status[2]=SIGNAL;
                         buf_status[3]=NSTEPS>>16;//Simple.bramRead(M_smZ_status)>>16;

                       	  wr=0;
			   for (;  wr == 0; )
			    {
                              wr = stream_ch_data_out.Write(buf_status,1,1000);
		            }
                          stream_ch_data_out.Invalidate();
     */
                       if ( buf_status[0]!=none)
                       {
                         break;  //stop
                       }

                  }// not stop

                        CurPosStepMotor = CurPosStepMotor & maskMotorOff;          // Сброс бита включения мотора  (бит номер 15)
                        Simple.bramWrite(M_smZ_ctrl,CurPosStepMotor);              // Отключение мотора
                        Simple.bramWrite(M_smZ_ctrl,0& maskMotorOff);              // обнуление счетчика шагов
                      	wr=0;
			   for (;  wr == 0; )
			    {
                              wr = stream_ch_data_out.Write(buf_status,1,1000);
		            }

			 stream_ch_data_out.Invalidate();
                         if (STMFLG==1) {   Simple.bramWrite(M_PID_ON,0x40000000);} // pull ahead tip    STM
                         else           {   Simple.bramWrite(M_PID_ON,0x80000000);}; // pull ahead tip   SFM

		  //       Simple.Sleep(INTDELAY);                //  ms
		         buf_step[0]=done;
                         wr=0;
			    for (;  wr == 0; )
			    {
                              wr = stream_ch_steps.Write(buf_step,1,1000);
		            }
                        stream_ch_steps.Invalidate();
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
} //class approach


