//16/11/17
unit CSPMVar;
//
interface
uses  messages,classes,GlobalType,GlobalVar,SyncObjs, mtplib_tlb,PortableDeviceApiLib_TLB,
      NL3LFBLib_TLB,MLPC_APILib_TLB,MLPC_APILib_Demo,MLPC_API2Lib_TLB,MLPC_API2DEMOLIB,UDeviceEvents;

const DAC12DiscrToVolt=$3FF8/5;
const MaxAPITYPE = 32767;
const MinAPITYPE = -32768;
const MaxDATATYPE = 32767;
const MinDATATYPE = -32768;
Const APITypeRange= MaxAPITYPE-MinAPITYPE;   //$7fff    { TODO : 041012 }
Const ScannerXYBiasZero=$4000;
const INFINITE_TIME=-1;
const VLimitSTM=7;  //STM Cutter V 
//digital controller   ID    need to change

const  EDU_HARDWARE_ID :string= 'USB\VID_0438&PID_0FDF&REV_0100&MI_00';
const  EDU_INSTANCE_ID_PREF:string ='USB#VID_0438&PID_0FDF';//&MI_00';  //   '\'
const  EDU_NAME_PREFFIX: string     = '\\?\USB#VID_0438&PID_0FDF&MI_00#';   //digital
//const  DigNanoeduDevName='NanoTutor';//'NanoeducatorLE';//'Scanning Probe Microscope Controller';
const  DigNanoeduDevOldName='NanoeducatorLE';//'Scanning Probe Microscope Controller';
const  DigNanoeduDevBaseName='MLPC';
//
//USB\VID_0438&PID_0FDB&REV_0100&MI_00
//USB\VID_0438&PID_0FDB&MI_00                 MLPC

const  USER_err:widestring   = 'm_user_err';
const  DAC_Z:widestring      = 'm_Z';
const  DAC_X:widestring      = 'dxchg_X';// 'm_X';
const  DAC_Y:widestring      = 'dxchg_Y';//'m_Y';
const  DAC_IREF:widestring   = 'm_A_rez';  // Resonance Amplitude
const  DAC_IREF_AM:widestring= 'm_BaseK';  // Setpoint    Resonance Amplitude*m_BaseK
const  ADC_Z:widestring      = 'm_pid_out';   //ADC_Z
const  ADC_UFM:widestring	   = 'm_P';        //Phase
const  ADC_UAM:widestring    = 'm_A';        //Amplitude
const  SD_GENF:widestring    = 'm_dfi_pin';   // resonance frequency
const  SMZ_STEP:widestring   = 'm_smZ_ctrl';        //Step
const  SMZ_STATUS:widestring = 'm_smZ_status';      // current coordinate stepmotor
const  SD_GAM:widestring     = 'm_F_k';      // probe modulation amplitude
const  ITR_RES:widestring	   = 'm_pid_ON';   // 0 retract;  protract scanner: stm=0x400000000 ;  sfm=0x80000000
const  ADC_IT:widestring     = 'm_ADC_I' ;     //Current
const  DAC_VT:widestring     = 'm_DAC_I' ;     //U
const  U_VECTOR:widestring   = 'm_ustep';    // scanning rate
const  U_VECTOR_BW:widestring= 'm_ustep_rw';    // scanning rate BW
const  DAC_REFSTM:widestring = 'm_I_BASE';    //set point STM
const  DAC_REFSFM:widestring = 'm_A_rez';
const  SelBRamU:widestring   = 'm_sel_Uopora';    // $00000000  bram ; $80000000  dchange block
const  IMaxCut:widestring    = 'm_I_max';
const  CMP_VAL:widestring     = 'din' ; 
                         		// Выход END_SCAN
 const FIFO_IN      = $66;		// Данные входного потока сканирования
 const FIFO_PATH    = $68;		// Данные пути сканирования
 const FIFO_OUT     = $6A;		// Данные выходного потока сканирования
 const IR_IN        = $6C;
 const IR_OUT       = $6E;


 const
 pgXmodeParams = 1;               // Ola Memory pages consts
 pgXmodeXAxis =  2;
 pgXModeYAxis =  3;
 pgYmodeParams = 4;
 pgYmodeXAxis =  5;
 pgYmodeYAxis =  6;

 const
   AdaptPgType_empty =0;
   AdaptPgType_header =1;
   AdaptPgType_params =2;
   AdaptPgType_curve =3;
 const   //adapter id
//  AdNanoId=1;
  AdNanoId=2;
  AdReniId=4;//?????? 25/01/17
  AdPMId=3;
//  AdTerraId=4;
  AdNotConnectedId=15;  //byte -1
  AdDemoId=999;
(* static final int ADPT_NE2     = 1;
	static final int ADPT_NEA_REN = 2;
	static final int ADPT_NEA_HVC = 3;
*)
Const
  StopJava:integer=1;       // stop java algorithm and wiat stop java bin
 //Common user var
  ch_Stop     :integer=0;     // value 1  Stop ; 0 = java running
  ch_Draw_done:integer=1;    //  value 1  drawdone ; 0 not done; time to close channel on java machine
  ch_Data_OUT :integer=2;    //data channel
 //Resonance
 //Approach
  ch_UserParams:integer=3;
  ch_Steps_done:integer=1;
// MoverXYZ
  ch_MoverXYZUserParams:integer=3;
//
  ch_Data_IN:integer=3;    //write to adapter
// Litho
  ch_Data_MATRIX:integer=5;    //
  ch_LINEAR_STEPS:integer=4;    //

 (*
  ch_Appr_ZMin:integer=2;
  ch_Appr_ZMax:integer=3;
  ch_Appr_SetLevel:integer=4;
  ch_Appr_IntegratorDelay:integer=5;
  ch_Appr_ScannerDecay:integer=6;
  ch_Appr_NStep_Z:byte=1;
  ch_Appr_Delay:byte=1;
  ch_Appr_LevelUAM:integer=1;
  ch_Appr_ControlTopPos:integer=1;
  ch_StatusApproach:integer=1;
  ch_flgOneStep:integer=1;
  ch_StatusStep:integer=1;
  ch_MadeStep:integer=1;
  ch_Endscript:integer=1;
  ch_ZValue:integer=1;
  ch_FlgEndscript:integer=1;
  *)
// Litho
  ch_Action:integer=1;
  ch_TimeAction:integer=1;
  ch_Amplifier:integer=1;

// spectr terra
  ch_TerraDelay:integer=3;
//
  ch_FlgFinish:integer=1;
  ch_Spectr_T:integer=1;
  ch_Npoints_Terra:integer=1;
  ch_TimeAct_Litho:integer=1;
  ch_Amplifier_Litho:integer=1;
  ch_TerraTDelay:integer=1;


       //etching   step motor
  const  aNStepE=$84;
  const  aMDelayE=$86;


  const None=0;
  const Steps=50;   //start approach
  const Done=60;
  const Stop=100;   // stop javabin
  const StopDone=5;// stop approach done
  const Start=50;   //start approach
  const WaitSteps=0;
  const EndScript=1;
  const Fine=1;
  const Rough=0;
   //resonance
  const Auto=0;
  const Manual=1;
 //  User Level

  const Beginner=2;//0
  const Advanced=0;//1;
  const Demo=1;//2;

  const   mScanning=1;
  const   mDrawing=2;
  const   mReadingMLPC = 5;
  const   mGetDeviceId = 6;
  const   mMemWriteDone = 7;
  const   mMemReadDone = 8;
  const   mEEPromWriteDone = 9;
  const   mFastDrawing=3;
  const   mApproaching=4;
  const   mGetControllerParams=10;
  const   lError=1;
  const   lOK=0;
//RENIShow error
 const XRightOver=2;
 const XLeftOver=3;
 const YTOPOver=4;
 const YBOTTOMOver=5;
const      //  device
  Nano=1;
  ProBeam=2;
  Terra=3;
  MicProbe=4;
  Baby=5;
  Grand=6;
  Pipette=7;
  NanoTutor=8;
  Unknown=12;// unknown=nano;
const //motor
 stepm=1;
 piezom=2;

 //View Type
 type
  RBufParams=record
    PBuffer:PInteger;
    SizeElement:Integer;
    NElements:Integer;
  end;

  Type Memorypagetype=(empty,header,params,curve);

  const NTSPBIdentif = 'nt-spb nanoeduLE 100';

 type
  TScanmethod = 0..20;
  TScanmethodSet=set of TScanmethod;

  Const  ScanSizeMax:integer=1024;    //Max point number in Scan Line
  Const  LinePointsMax:integer=1024; //Current Max point number in Scan Line
  Const  Topography=0;
  Const  WorkF=1;
  Const  BackPass=2;
  Const  Phase=3;
  Const  UAM=4;   //Force Image
  Const  Spectr=5;
  Const  Litho=6;
  Const  Current=7;
  Const  FastScan=8;  //current
  Const  TopoError=9;
  Const  FastScanPhase=10;
  Const  OneLineScan=11;
  Const  SensivityCorrection=12;
  Const  LithoCurrent=13;
  Const  Profile=14;

//  Type pagetype=(empty,header,params,curve);

var
  DigNanoeduDevName:string='NanoTutor';
  ScanmethodSetTopo:TScanmethodSet;
  ScanmethodSetOneL:TScanmethodSet;
  ScanmethodSetLitho:TScanmethodSet;
  ScanmethodSetZnm:TScanmethodSet;
  ScanmethodSetZAm:TScanmethodSet;
  ScanmethodSetZph:TScanmethodSet;
  ScanmethodSetAdd:TScanmethodSet;
  ScanmethodSetNoAdd:TScanmethodSet;
  ScanmethodSetZUAM:TScanmethodSet;
  ScanmethodSetSpectr:TScanmethodSet;
  ScanmethodSetTopoErr:TScanmethodSet;
  ScanmethodSetZWrk:TScanmethodSet;
  ScanmethodSetNeedV:TScanmethodSet;
  ScanmethodSetFast:TScanmethodSet;
//  pathmode =ScanPath

  Const  MultiY=3; //y++
  Const  Multi=2;  //x++
  Const  OneY=1;   //Y+
  Const  OneX=0;   //X+
//user messages

  const   WM_UserCloseVideo       = WM_User + 30;
  const   WM_ThreadDoneMsg        = WM_User + 8;
  const   WM_ScanParamsUpdate     = WM_User + 9;
  const   WM_ThreadTrainDoneMsg   = WM_User + 10;
  const   WM_StepTestThreadDoneMsg= WM_User + 11;
  const   WM_ThreadStepsDoneMsg   = WM_User + 12;
  const   WM_CopyClipboardMsg     = WM_User + 13;
  const   WM_MultiThreadDoneMsg   = WM_User + 14;
  const   WM_UserChangePreview    = WM_User + 15;
  const   WM_UserLBViewFocus      = WM_User + 16;
  const   CM_PrilipalkaMove       = WM_USER + 17;
  const   WM_UserFreeLib          = WM_User + 20;
  const   WM_UserApproachOptUpdated = WM_User + 21;
  const   WM_UserScanWndUpdated   = WM_User + 22;
  const   WM_UserMsgScanError     = WM_User + 23;
  const   WM_UserUpdateWorkView   = WM_User + 24;  
type
  TPrilipalkaMSG = packed record
    Msg: Cardinal;
    {main form position}
    mfLeft: integer;
    mfTop: integer;
    mfRight: integer;
    mfBottom: integer;
  end;

//type viewtype=(Topography,WorkF,BackPass,Phase,UAM,Spectr,Litho,CurrentSTM,FastScan,TopoError,
//               FastScanPhase,OneLineScan,SensivityCorrection);
type RChannels=record
 Main: IMLPCChannel;
 ChannelRead: IMLPCChannelRead;
 ChannelRead2:IMLPCChannelRead2;
 ChannelWrite:IMLPCChannelWrite;
 ID:Integer;
end;

type ClChannel = class
  Main : IMLPCChannel;
  function Read(Data: PInteger; var pCount: Integer): HResult;
end;

type ROSCParams=packed record
 NChannels:integer;
 NameChannel1:string;
 NameChannel2:string;
end;

type TOSCParamVal= array of integer;

type TOSCParamName= array of widestring;

(* type RPIDParams=packed record
 dT:integer;
 Te:integer;
 Td:integer;
 Ti:integer;
end; *)

type RPIDParams=packed record
 dT:Integer;
 Te:PIDType;
 Td:PIDType;
 Ti:PIDType;
 sgnTI:PIDType;
 TiApproach:PIDType;
 TiScan:PIDType;
 dTAbsMax:integer;
 TeAbsMax:PIDType;
 TdAbsMax:PIDType;
 TiAbsMax:PIDType;
 FineScale:PIDType;      // zoom koef for fine Scale
 pidTeL1,pidTeL2,
 pidTdL1,pidTdL2,
 pidTiL1,pidTiL2:PIDType;    // Bounds  for fine PID control
end;

TYPE RHardwareOpt=PACKED record
//Physical Unit Options:
  //      flgFlash:Boolean;
  //      flgAutoScanner:byte;
        ScannerNumb:string;
        ElectronicNumb:string;
        XYTune:string;
// Analog HardWare Options:
 //       ZTune:string;//integer;
        //integer;
        AMPGainZ,
        AMPGainX,
        AMPGainY,
        AMPGainRZ,
        AMPGainRX,
        AMPGainRY,
        AMPGainFZ,
        AMPGainFX,
        AMPGainFY: single;
        UFBMaxOUT:double;
//        TappingKoef:double; //nm/volt;
//        FlgNewElectronic:boolean;
end;

TYPE RSignalCharacter=packed record
    Name:string;
    MinV,
    MaxV:single;  //single !!!
    DeviceClass:word;
    MinDiscr,
    ZeroVal,
    MaxDiscr:smallint; //word;     { TODO : 041012 }
end;

Type RTransformUnit=packed record
     Znm_d:single;       //transfer nm->discret
     Ynm_d:single;
     Xnm_d:single;
     YPnm_d:single; //  use sensivity for position x   movetoxoyo
     XPnm_d:single; // use sensivity for position y
     Uv_d:single;        //UAM volt dis
     nA_d:single;        // Tunnel Current dis
     A_d_SetPoint:single;// Set point Current coeff
     AmplV_d:single;      //V-discr
     BiasV_d:single;
     mA_dE:single;        //Etching
 end;
TYPE CSPMSignalsArr=array [1..13] of RSignalCharacter;

Type RResonanceParams=packed record
     nchannel:LongWord;
     FreqStart:longword;        //word->longword 150217
     FreqEnd:longword;
     FreqStartRough:longword;
     FreqStartFine:longword;
     FreqEndRough:longword;
     FreqEndFine:longword;
     FreqStartRoughDef:longword;
     FreqEndRoughDef:longword;
     NPoints:word;
     Step:word;
     StepRough:word;
     StepFine:word;
     AmplStep:single;
     DeltaFine:word; //  1/2 fine windows size
     Delay:word;
     ResFreq:longword;
     Q:single;
     NChannels:integer;
     Gain_AM:word;  //250112
(*     F0:word;         //generator base frequency
     Amp_M:word;
     Gain_FM:word;
//   Gain_AM:word;       //arb unit
     FreqBandF:word;
     FreqBandR:word;
*)
end;
///
 Type  RAlgParams=record
//  NEED FOR DEMO VER
  NChannels:data_dig;
  NElements:data_dig;  //dataout    channel
  SizeElements:data_dig;  //dataout channel
  NGetCountEvent:data_dig;   //add demo get count event!!!!!!!!!!!1
//
 // params:array[0..11] of data_dig;
 params:array[0..12] of data_dig;
 end;
////
 Type RAlgResonanceParams=record     //java algorithm parametrs
 //type???
     FreqStart:data_dig;
     Step:data_dig;
     NPoints:data_dig;
     Delay:data_dig;
end;
TYPE RApproachParams=packed record
       NChannels:integer;
       flgOneStep:boolean;
       flgAutorunCamera:boolean;
       flgControlTopPosition:boolean;
       flgControlTopPositionDemo:boolean;
       TypeMover:byte; //0 step; 1 piezo mover Z ;2 piezo mover X; 3 piezo mover-y ; piezo mover Z SEM
       F0:word;         //generator base frequency
       Amp_M:word;
       Gain_FM:word;
       FreqBandF:word;
       FreqBandR:word;
       PMActiveTime:word;     //time piezo motor work in the cycle
       PMPause:word;
       ScannerDecay:word;     //mmsec
       IntegratorDelay:word;
       IntegratorDelayFB:array[0..10] of word; //
       UAMMax:apitype;
       ZUpStepsNumb:integer;         //>0    for fast rising
       ZFastStepsNumb:integer;       //    for fast  landing
       ZUnCntlStepsNumb:Integer;    //uncontrol landing steps
       ZStepsNumb:Integer;           //current steps
       ZStepsDone:integer;
       NCycles:integer;              //nmb cycles of pm testing
       MaxAmp_M:integer;
       ExtremAmplitude:single;
       IMaxCut:single;
       LevelIT:single;               //nA
       Zmax:single;         //zmax scanner
       ZGateMax:single;     // protract   =0
       ZGateZero:apitype;
       ZGateMin:single;     //retract   max
       LevelUAM:single;
       SetPoint:single;             //suppression
       LandingSetpoint:single;
       BiasV:single;
       MaxSuppress:single;
       ScaleMaxIT:single;
       MaxITIndicator:Integer;
       CurVideoProgram:string;
       OrVideoProgram:string;
       OrVideoCaption:string;
       Speed:integer;
       DataBufLength:integer;
      end;

TYPE RAlgApproachParams= record
       LandingSetpoint:data_dig;  // 0  ?   <<
       ZGateMax:data_dig;         // 1 absolute  (-1,1)
       ZGateMin:data_dig;         // 2 absolute  (-1,1)
       LevelUAM:data_dig;         // 3 absolute
       ZStepsNumb:data_dig;       // 4
       IntegratorDelay:data_dig;  // 5 mmsec
       ScannerDecay:data_dig;     // 6 mmsec
       flgSTM:data_dig;           // STM flg =1 true;
       Speed:data_dig;
 //    BiasV:single;
 end;

TYPE RSTMApproachParams=packed record
       ZStepsNumb:integer;
       FreqBandF:word;
       FreqBandR:word;
       ScannerDecay:integer;
       IntegratorDelay:integer;
       ZGateMax:single;
       ZGateMin:single;
       LevelI:single;
       ExtremI:single;
       SetPoint:single;
       BiasV:single;
       Speed:integer;
     end;

TYPE RScannerMoveXYZParams=packed record
       TypeMover:apitype; //0 step; 1 piezo mover Z ;2 piezo mover X; 3 piezo mover-y; 4- piezo mover Z SEM
       PMActiveTime:apitype;     //time piezo motor work in the cycle
       PMPause:apitype;
       Speed:integer;
       StepsNumbSlow:apitype;      //number step in one step
       StepsNumbFast:apitype;    //number step in one step   fast
       StepsNumb:apitype;   //number step in one step
       StepsCountY:integer;
       StepsCountX:integer;
       StepsCountZ:integer;
       Z:apitype;
       XMax:single;
       YMax:single;
       nchannels:integer;
      end;

 TYPE RAlgScannerMoveXYZParams=packed record
       StepsNumb:data_dig;
       TypeMover:data_dig; //0 step; 1 piezo mover Z ;2 piezo mover X; 3 piezo mover-y; 4- piezo mover Z ProBeam  ,MicProbe
       Speed:data_dig;
      end;

TYPE RScanParams=packed record
      flgSetScanArea:boolean; // set  def or not scanarea when change sfm->stm  device
      flgStepXY:Boolean;      //flg fix step
      flgSQ:boolean;         //flg Square Area  draw
      flgTopoLevelDel:boolean;     //delete base - min value
      flgTopoCurLinePlDel:boolean;
      flgTopoTopViewPlDel:boolean;
      flgTopoTopViewSDel:boolean;
      flgAquiAdd:boolean;
      flgSpectr:boolean;
      flgProfile:boolean;
      flgOneFrame:boolean;
      flgFastSimulator:boolean;
      flgMovetoZero:boolean;
      nchannels,
      NX,
      NY,
      CurrentScanCount,
      NFrames:integer;//FastTopo
      CycleCount:integer;
      ScanPoints:integer;
      ScanLines:integer;
      ScanRate:single;
      ScanRateLimParameter:single; // 20/12/2016 this parameter is max valid ratio: NPoints/lineTime_c
      ScanRateBW:single;
      ScanPath:integer; {X+:0,Y+:1,multi:2}
      sz:integer;   //=1 ; +add data =2
      ScanMethod:integer; //method
      PassIIDz:apitype;
      dataInPrev:ApiType;// zero  dataIn  Multi pass
      dataInNext:ApiType;
      dataInCur:ApiType;
      DACZTimeDelay:word; //II pass
      IntegrDecay:word;//II Pass
      MicrostepDelay:integer;
      MicrostepDelayBW:integer;
      DiscrNumInMicroStep:word;  //170505
      Microstep:integer;
      XMicrostepNmb:integer;
      YMicrostepNmb:integer;
      ScanShift:integer;
      flgFilter:integer; //multi pass filter
      StepXY:single;
      X,Y,
      XBegin,    //relative coordinate
      YBegin,    //relative coordinate
      xshift,    // shift zero coordinate scan area
      yshift,    // shift zero coordinate scan area
      XPrevious, YPrevious:single;   //relative {abs} coordinate
      XMax:single;
      YMax:single;
      XBias0,
      YBias0,
      XDigCor,   // Correction Voltage X  -50V +150V
      YDigCor:single;   // Correction Voltage Y  -50V +150V
      ScanLineTime:integer;      // time waitfor fast scanning execute
      //profile
     //  SpeedXY :integer;
       Speed  :integer;
       PiezoMoverNStepsXY:integer;
       PiezoMoverSzStepsXY:single; //size of the step piezomover with fix speed
       PiezoMoverStepsZUp:integer;      //size step up discret
       PiezoMoverStepsZDown:integer;   //size step down discret
       IntegratorDelay:integer;
       ScannerDecay:integer ;
       ScanDrawDelay:integer;        //ms
       LithoDrawDelay:integer;        //ms
       TerraTDelay:integer;  //miliseconds
       FastDrawDelay:integer; //miliseconds
       WaitForPrepareFastPath:integer;//msec
       TimMeasurePoint:single; // ms - time need for waiting after moving scanner before get signals data
       TimMicroStep:single;   // milisec, minimum  Time of one microstep;
      //
     end;
  TYPE RMoveToScanParams=record
      nchannels:Integer;
  end;

 TYPE RAlgScanParams=record
      NX,
      NY,
      ScanPath:integer; {X+:0,Y+:1,multi -2}
      sz:integer;   //=1 ; +add data =2
      ScanMethod:integer; //method
      MicrostepDelay:integer;
      MicrostepDelayBW:integer;
      DiscrNumInMicroStep:integer;  //170505
      XMicrostepNmb:integer;
      YMicrostepNmb:integer;
     end;


 Type RLithoParams=packed record
      TimeAct:integer;
      ScaleAct:single;
      Amplifier:integer;
      Vmin:integer;   //discret
      Vmax:integer;   //discret
         V:integer;    //discret
     nchannels:integer;
    end;

 TYPE RAlgLithoParams=record
      NX,
      NY,
      ScanPath:data_dig; {X+:0,Y+:1,multi -2}
      sz:data_dig;   //=1 ; +add data =2
      ScanMethod:data_dig; //method
      MicrostepDelay:data_dig;
      MicrostepDelayBW:data_dig;
      DiscrNumInMicroStep:data_dig;  //170505
      XMicrostepNmb:data_dig;
      YMicrostepNmb:data_dig;
      Amplifier:data_dig;
      TimeAct:data_dig;
 //     Vmin:data_dig;   //discret
 //     Vmax:data_dig;   //discret
//         V:data_dig;   //discret
     end;
 TYPE RAlgLitho_ingParams=record
      MicrostepDelay:data_dig;
      MicrostepDelayBW:data_dig;
      Amplifier:data_dig;
      TimeAct:data_dig;
 //     Vmin:data_dig;   //discret
 //     Vmax:data_dig;   //discret
 //        V:data_dig;   //discret
     end;

 Type RSpectrParams=packed record
       NSpectrPoints:integer;     //number of points for spectr measurement
       CurrentLine:integer;
       NPoints:integer;   //number of points  in one line
       NewPoints:integer;    // need for sfm when  archived limit
       StartP:apitype;   //SFM
       Step:single;
       LevelIZ:apitype; 
       LevelSFM:apitype;
      //stop approach SFM
       LevelI_Pipe:apitype;    //stop approach I Pipettte
       LevelUAM_SFM:apitype; //stop approach SFM
       EndP:apitype;        //SFM
       T:word;              //delay between measure
       TC:word;             //Scanner Delay
       StopV:apitype;       //STM
       StartV:apitype;      //STM
       NCurves:apitype;    //number of  graphics in the one points of spectr measurement
       NAv:integer;      //number of points for average in the point of spectr measurement
       flgIZ:boolean;  //spectr I-Z =true; I-V  =false for STm
       StartPointLimit,
       FinalPointLimit:integer;
       StartSPT:apitype;
       EndSPT:apitype;
       nchannels:integer;

      end;
  Type RProfileParams=packed record
     //approaching
       PMActiveTimeZ:word;     //time piezo motor work in the cycle
       PMPauseZ:word;
       ScannerDecay:word;     //mmsec
       IntegratorDelay:word;
       szStepUP:single;          // size rising step piezo
       szStepDown:single;      //   size approaching step piezo
       nzstepsUp:integer;      //// number of step to rise before move along axis x/y
//scanning
       X,    //length of the line кратно шагу пьезо moover X
       ScanRate:single;
       ScanRateBW:single;
       ScanPath:integer;    //X,Y
       ScanPoints:integer;        //n point  in the scan xy<<7 mcm
       ScanLines:integer;        // n lines =7 mcm
       stepXY:single;     //size step scanning X/Y
       ProfileLength:single; //length of the profile
//moving X,Y

       PMActiveTimeXY:word;     //time piezo motor work in the cycle
       PMPauseXY:word;
       npiezosteps:integer;  //numbers of the steps for piezo to move to the next scan line
//common
       nchannels:integer;
      end;

 type RAlgSpectrSFMParams =record
      NPoints:data_dig;   //number of points  in one line
      StartP:data_dig;   //SFM
      Step:data_dig;
      LevelSFM:data_dig;  //stop approach SFM
      T:data_dig;          //delay between measure
      flgSTM:data_dig;
 end;

 type RAlgSpectrSTMParams =record
      NPoints:data_dig;   //number of points  at one line
      NCurves:data_dig;   //number curves at point
      StartV:data_dig;   //
      Step:data_dig;
      T:data_dig;          //delay between measure
      flgSTM:data_dig;
 end;

 Type RAlgMoveToParams= record
    Xbegin_d, YBegin_d:integer;
    MicrostepDelay:integer;
 end;

 type RAlgWriteToMemParams = record

 end;

 type RAlgSpectrSFMTerraParams=record

 end;

 type RAlgStepTestParams=record

 end;

 type RAlgPhaseADParams=record

 end;

 type RAlgTrainParams=record

 end;


 Type RScannerCorrect=packed record
       flgPlnDelHW:boolean;
       flgPlnDel:boolean;
       FlgXYLinear:Boolean;
       FlgZLinear:boolean;
       FlgZLinAbs:boolean;
       FlgZSurfCorr:Boolean;
       flgHideLine:Boolean;
       NonLinFieldX,
       NonLinFieldY:integer;     //nm
       GridCellSize:integer; //nm
       YBiasTan:single;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:single;
       SensitivX:single;
       SensitivY:single;
       I_VTransfKoef:single;
      end;

 type  RAdapterOptFloatRecord=packed record                // Ola
       PageNmb:integer;
       PageTypeId: integer;//Memorypagetype;
       DataLengthInt:integer;
       NonLinFieldX,
       NonLinFieldY:integer;     //nm
       GridCellSize:integer; //nm
       YBiasTan:single;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:single;
       SensitivX:single;
       SensitivY:single;
       I_VTransfKoef:single;
     end;
 type PAdapterOptFloatRecord = ^RAdapterOptFloatRecord;
(*
 type  RAdapterOptRecord=packed record                // Ola
       PageNmb:integer;
       PageTypeId: integer;//Memorypagetype;
       DataLengthInt:integer;
       NonLinFieldX,
       NonLinFieldY:integer;     //nm
       GridCellSize:integer; //nm
       intYBiasTan:integer;//single;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       intSensitivZ:integer;//single;
       intSensitivX:integer;//single;
       intSensitivY:integer;//single;
       intI_VTransfKoef:integer;//single;

     end;
 type PAdapterOptRecord = ^RAdapterOptRecord;

  *)
 type RAdapterLinPointsRecord64 = record
       pageNmb:integer;
       PageTypeId: integer; //Memorypagetype;
       DataLengthInt:integer;
       LinearizationDate:string[12];
       NPoints:integer;
       Points:array[1..50] of integer;     // array[1..64] of integer;
     end;
 type PAdapterLinPointsRecord = ^RAdapterLinPointsRecord64;
(*
 type RScannerOptRecord64 = record
         PageNmb:integer;
     //  DataLength:integer;
       PageTypeId:integer;
       NonLinFieldX,
       NonLinFieldY:integer;
       GridCellSize:integer; //nm
       intYBiasTan:integer;  // tang of angle between OY and Y-Section (22.01.03, Olya)
       intSensitivZ:integer;
       intSensitivX:integer;
       intSensitivY:integer;
       intI_VTransfKoef:integer;
       NoInf:array[1..52] of integer;
      end;
  type  PScannerOptRecord64 = ^RScannerOptRecord64;
  *)
  type RAdapterHeadRecord = record
       PageNmb:integer;
       PageTypeId: integer;
       aflgUnit:integer;
       NTSPBId:string[20];
       ProtocolVers:integer;
       ScannerNumber:string[8];
       pagewritten:array[1..6] of integer;
  end;

 type PAdapterHeadRecord = ^RAdapterHeadRecord;

 type  RControllerParamsRecord=record
(*CFG_SIZE[2],CFG_ID[4],
X/Y/Z: {STARTUP[4], MODE[4]
       OSC_LO[4], OSC_HI[4], OSC_NAME[8]},
CFG_CHECK[2].
*)      SN_LMT:array[0..15] of AnsiChar;
        SN_NTSPB:array[0..15] of AnsiChar;
        CFG_Size:integer;
        id:integer;
        XVStart,
        XMOde:integer;
        X_Max,
        X_Min:single;
        X_Name:array[0..7] of AnsiChar;
        YVStart,
        YMOde:integer;
        Y_Max,
        Y_Min:single;
        Y_Name:array[0..7] of AnsiChar;
        ZVStart,
        ZMOde:integer;
        Z_Max,
        Z_Min:single;
        Z_Name:array[0..7] of AnsiChar;
    end;
 type PControllerParamsRecord = ^RControllerParamsRecord;

 (*
 type RScannerHeadRecord64 = record
       PageNmb:integer;
     //  DataLength:integer;
       PageTypeId: integer;//Memorypagetype;
       NTSPBId:string[20];
       ProtocolVers:integer;
       ScannerNumber:integer;
       NoInf:array[1..58] of integer;
  end;

 type PScannerHeadRecord64 = ^RScannerHeadRecord64;
*)
 Type RScannerMaxAreaDef=packed record
        YBiasTan:single;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivX:single;
       SensitivY:single;
      end;

 Type RScannerOptMod=packed record
       PathMode:integer;
       LinearizationDate:string;
       NonLinFieldX,
       NonLinFieldY:integer;     //nm
       GridCellSize:integer; //nm
       YBiasTan:single;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:single;
       SensitivX:single;
       SensitivY:single;
       I_VTransfKoef:single;
       ApprLineX0, ApprLineXKoef:single;   //    { TODO : 170608  To correct Max Field by linear curves }
       ApprLineY0, ApprLineYKoef:single;
     end;

 Type RDemoParams=packed record
      Z:integer;
      OscAmp,OscAmplRes, TunnelCurrent:integer;
      NZStepsApproach, NZStepsFastApproach :integer;
      FBKoef:single;
 end;

 type RAlgReadfromMLPCParams = record
      StartPage,
      PagesNmb:integer;
 end;
 type  RDatawriteList =record
      pnt:PInteger;
      size:integer;
      end;
 type  PRDatawriteList=^RDatawriteList;

 var
    NanoeduDevice:IMLabDevice;
    SchematicControl:ISchematicControl;
//    SchematicControlDemo:ISchematicControlDemo;
    JavaControl:IJavaControl;
    NanoeduPC_Cell:ILFB;
    NanoeduPC_Cell_CELL:ILFB_CELL;
    NanoeduPC_PID:ILFB_PID;
    NanoeduPC_VScope:ILFB;
    NanoeduCellPropertyPage:IUnknown;
    NanoeduPIDPropertyPage:IUnknown;
    NanoeduVScopePropertyPage:IUnknown;
    PCChannelManager:IMLPCChannelManager;
    PCChannelManager2:IMLPCChannelManager2;
//  PCChannelManagerEvents:_IMLPCChannelManagerEvents;
    PCChannel:IMLPCChannel;
//  PCChannelEvents:_IMLPCChannelEvents;
    PCChannelRead:IMLPCChannelRead;
    PCChannelWrite:IMLPCChannelWrite;
    PCChanelInBufRead:IMLPCChannelRead;
    arPCChannel: array of  RChannels;   // channel [0]  in
//    pIMtpEventCallback: IMtpEventCallback;
    DeviceEventsCallback:CPortableDeviceEventsCallback;
    NanoeduPortDev: IPortableDevice;
    spClientInfo:IPortableDeviceValues;
//
var
  STMFlg:Boolean;
  flgRunFirmCamera:integer;
  FirmCameraWinName:string;
  FirmCameraSoftPath:string;
  flgRetract:boolean;
  flgNanoeduUnitCreate:boolean;
  FlgAllDataReadFromAdapter:boolean;
  FlgDataScannerHaveRead:boolean;
  flgScannerNotinDBase:boolean;
  flgGetHeader,flgGetScannerOptModeX,flgGetScannerOptModeY:boolean;
  flgGetLinModXAxisX,flgGetLinModXAxisY,flgGetLinModYAxisX,flgGetLinModYAxisY:boolean;
  flgDetectDev:boolean;
  flgControlerTurnON:boolean;
  flgShowSmeshariki:boolean;
  flgShow3DVideo:boolean;
  flgControlerError:boolean;
  flgJavaRunning:WordBool;
  flgSchemeLoaded:WordBool;
  flgStopJava:WordBool;
  flgStopVideoStream:boolean;
  flgfileuploaded:boolean;
  flgfilealguploaded:boolean;
  flgfileparamuploaded:boolean;
  flgfilemaskuploaded:boolean;
  flgfilealgdeleted,flgfileparamdeleted:boolean;
  flgfilemaskdeleted:boolean;
  flgUnit:integer;
  flgMotor:integer;
//  flgTerra:boolean;
  flgSaveProcess:boolean;
  flgVideoOscConflict:boolean;
  flgAnodeLithoEnable:boolean;    // anode lithography controller
  flgRenishawEnable:boolean;      //renishaw controller
  ApprOnProgr,ScanOnProgr:Boolean;
  SetIntActOnProgr:Boolean;    //flg set interaction
  flglimitspectr:boolean;
  ThreadFlg:integer;
  ScanAreaStartXR:integer;
  ScanAreaStartYR:integer;
  ScanAreaStartXF:integer;
  ScanAreaStartYF:integer;
  ScanAreaBeginXR:integer;
  ScanAreaBeginYR:integer;
  ScanAreaBeginXF:integer;
  ScanAreaBeginYF:integer;
  MStepsX,MStepsY:integer;
  PATH_SPDDemo:integer;
  GETCOUNT_DELAY:integer; // 09/09/2013 интервал (мс), через который вызывается
                          //            ф-ция GetCount
  JMPX,JMPY:TMas1;
  XYSp,YYsp,BY,CY,DY,
  XXsp,YXsp,BX,CX,DX :ArraySpline;
//  XmodX,XmodY,YmodX,YmodY :ArraySpline;     //  x  mode y axis
  MatrixLitho:array of array of smallint;
 // MatrixLithoAct:array of array of integer;
  MatrixLithoAct:PInteger;
  LinearStepsAct:PInteger;
  NXSplines,NYSplines:integer;
  YBiasTang:single;
  ZMatr:TMas2;
  LineXkoef,LineYKoef:single;
  OSCParams:ROSCParams;
//  PIDParamsApr:RPIDParams;
  PIDParams:RPIDParams;
  PIDSFMParams:RPIDParams;
  PIDSTMParams:RPIDParams;
  ApproachParams:RApproachParams;
  AlgApproachParams:RAlgApproachParams;
  AlgReadfromMLPCParams:RAlgReadfromMLPCParams;
  ApproachParamsEdited:RApproachParams;
  ScannerMoveXYZParams:RScannerMoveXYZParams;
  AlgScannerMoveXYZParams:RAlgScannerMoveXYZParams;
  ScanParams:RScanParams;
  MoveToScanParams:RMoveToScanParams;
  AlgScanParams:RAlgScanParams;
  AlgLithoParams:RAlgLithoParams;
  AlgMoveToParams:RAlgMoveToParams;
  ResonanceParams:RResonanceParams;
  AlgParams:RAlgParams;
  AlgResParams:RAlgResonanceParams;
  AlgSpectrSTMParams:RAlgSpectrSTMParams;
  AlgSpectrSFMParams:RAlgSpectrSFMParams;
  AlgSpectrSFMTerraParams:RAlgSpectrSFMTerraParams;
  AlgStepTestParams:RAlgStepTestParams;
  AlgTrainParams:RAlgTrainParams;
  AlgPhaseADParams:RAlgPhaseADParams;
  LithoParams:RLithoParams;
  ScanParamsDef:RScanParams;
  SpectrParams:RSpectrParams;
  ScannerCorrect:RScannerCorrect;

  FlgScannerLinDataResident:boolean;
  //scan mode params
  ScannerOptModX, ScannerOptModY:RScannerOptMod;
 //adaper params
  AdapterOptModX, AdapterOptModY:RAdapterOptFloatRecord;//  RScannerOptRecord;//
  pAdapterOptModX, pAdapterOptModY:PAdapterOptFloatRecord;
  //header
  AdapterHead:RAdapterHeadRecord;
  pAdapterHead:PAdapterHeadRecord;
  //linea
  AdapterLinModXAxisX,AdapterLinModXAxisY,
  AdapterLinModYAxisX, AdapterLinModYAxisY : RAdapterLinPointsRecord64;

  pAdapterLinModXAxisX,pAdapterLinModXAxisY,
  pAdapterLinModYAxisX,pADapterLinModYAxisY: PAdapterLinPointsRecord;
//  controller
  PControllerParams:PControllerParamsRecord;
//  PControllerParamsDemo:PControllerParamsRecord;
//
  STMApproachParams:RSTMApproachParams;
  DemoParams:RDemoParams;
  HardwareOpt:RHardwareOpt;
  TransformUnit:RTransformUnit;
  CSPMSignals: CSPMSignalsArr;
//
  DataDemoBuf:PInteger;
  DataBuf:PInteger;
  DoneBuf:PInteger;
  DataBufIn:PInteger;////
  StopBuf:PInteger;
  StepsBuf:PInteger;
  DataInBuf:Pinteger;
//
  ArDemoChannelParams:array of RBufParams;///
  aOSCParamVal:TOSCParamVal;
  aOSCParamName:TOSCParamName;
  AdapterID,AdapterVer_hi, AdapterVer_lo :integer;
  flgAdapterLink:boolean;
  JustLinerizData:ArraySpline; // Ola Массив , в который переписываются данные линеаризации для сохр. их в памяти
  EVents:TEvent;
  DataWriteToAdapterList:TList;
  MotorCurrentStatus:integer;
  
 implementation

function ClChannel.Read(Data: PInteger; var pCount: Integer): HResult;
begin
  result := (Main as IMLPCChannelRead).Read( Data, pCount );
end;

initialization
 flgNanoeduUnitCreate:=true;
 flgAllDataReadFromAdapter:=false;
 flgGetHeader:=false;
 flgGetScannerOptModeX:=false;
 flgGetScannerOptModeY:=false;
 flgGetLinModXAxisX:=false;
 flgGetLinModXAxisY:=false;
 flgGetLinModYAxisX:=false;
 flgGetLinModYAxisY:=false;
 FlgDataScannerHaveRead:=false;
 DataWriteToAdapterList:=TList.Create;
with   ScanparamsDef  do
begin
     X:=ScanAreaStartXR;
     Y:=ScanAreaStartYR;
     XBegin:=10;
     YBegin:=10;
     NX:=100;
     NY:=100;
     ScanRate:= 4000; //double, nm/s;
     ScanPath:=OneX;//integer; {X+:OneX;Y+:OneY,}
     Microstep:=1;//integer;
     MicrostepDelay:=5;//integer;
     XMicrostepNmb:=100;//integer;
     YMicrostepNmb:=100;//integer;
     StepXY:=X/Nx;
     flgStepXY:=false;      //flg fix step
     flgSQ:=true;         //flg Square Area  draw
     flgTopoCurLinePlDel:=true;
     flgTopoTopViewPlDel:=true;
     flgfileuploaded:=false;
     flgfilealguploaded:=false;
     flgfileparamuploaded:=false;
     flgfilemaskuploaded:=false;
     flgfilemaskdeleted:=true;
     flgfilealgdeleted:=true;
     flgfileparamdeleted:=true;
end;


end.
