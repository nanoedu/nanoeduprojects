//170107
unit UNanoEduBaseClasses;

interface
uses  classes, windows,sysutils,Dialogs,
//ntspb
 GlobalType,CSPMVar,
      uNanoEduBaseMethodClass,UDeviceEvents,
        {$IFDEF DEBUG}
              frDebug,
       {$ENDIF}
     PortableDeviceApiLib_TLB, MLPC_API2Lib_TLB,NL3LFBLib_TLB, NL3LFBLib_TLBDemo;
type

TMotor=class(TObject)
private
  procedure SetMotorSPEED(val:apitype); virtual; abstract;
  procedure SetMotorPause(val:apitype); virtual; abstract;
public
 constructor create;
 procedure TurnOn;             virtual;
 procedure TurnOff;            virtual; abstract;
 property  Speed:apitype       write SetMotorSpeed;
 property  Pause:apitype       write SetMotorPause;    //PM motor
end;

TStepMotor=class(TMotor)
private
 procedure SetMotorSPEED(val:apitype); override;
 procedure SetMotorPause(val:apitype); override;
public
 procedure TurnOn;             override;
 procedure TurnOff;            override;  //turn off step motor
end;

TPiezoMotor=class(TMotor)
private
 procedure SetMotorSPEED(val:apitype);override;
 procedure SetMotorPause(val:apitype);override;
public
 procedure TurnOn;            override;
 procedure TurnOff;           override;  //turn off step motor
end;

TStepMotorX=class(TStepMotor)
private
 procedure SetMotorSPEED(val:apitype); override;
public
 procedure TurnOn;             override;
 procedure TurnOff;            override;  //turn off step motor
end;

TStepMotorY=class(TStepMotor)
private
 procedure SetMotorSPEED(val:apitype); override;
public
 procedure TurnOn;             override;
 procedure TurnOff;            override;  //turn off step motor
end;

TPiezoMotorXYZ=class(TPiezoMotor)
private
 procedure SetMotorSPEED(val:apitype);override;
 procedure SetMotorPause(val:apitype);override;
public
 constructor Create;
 procedure TurnOn;             override;
 procedure TurnOff;            override;  //turn off step motor
end;

TPiezoMotorZ=class(TPiezoMotorXYZ)
private
 procedure SetMotorPause(val:apitype);override;
public
 procedure TurnOn;             override;
end;
TBaseNanoEdu=class
private
  procedure SetFeedBackRough(val:apitype);    //pro
  procedure SetFineZ(val:boolean);            //pro
  procedure SetFineXY(val:boolean);           //pro
  procedure SetBias(val:apitype);
  function  GetBias:apitype;                  //pro
  procedure SetSD_GAM(val:apitype);         //амплитуда  раскачки
  function  GetSD_GAM:apitype;
  procedure SetSD_GENF(val:apitype);        //Frequency  generator  Rough
  function  GetBramUflg:apitype;
  procedure SetBramUflg(val:apitype);
  function  GetImaxCut:integer;
  procedure SetImaxCut(val:integer);
protected
  procedure SetSetPoint(val:single);       virtual; abstract;  //pro
  function  GetZValue:apitype;             virtual;
  function  GetSignalValue:apitype;        virtual; abstract;
  function  GetControllerNumber:string;    virtual;
  function  GetUpperLimitOut:boolean;      virtual;
  procedure SetFeedBack(val:PIDType);      virtual;
  function  CalcFBKoefDemo:single;
public
// ScannerApproach: TScannerApproach;
// ScannerMoveXYZ:TScannerMoveXYZ;
 Method:TScanMethod;
 ScanMotorX:TStepMotor;
 ScanMotorY:TStepMotorY;
  FBKoefDemo:single;
 function  GetAdapterID:integer;           virtual;
 function  GetControllerParams:PControllerParamsRecord;    virtual;
 function  ControllerConnect:boolean;      virtual;
 function  DisconnectController:boolean;   virtual;
 function  TestAdapterIsNew:boolean;       virtual;
 function  ReadFromDataAdapter(taskdata:integer):boolean;  virtual;
 procedure ScannerRetract;
 procedure ScannerProtract;                virtual;  abstract;
 procedure SetDACZero;
 procedure GetCurrentPosition;             virtual;
 function  RisingToStartPoint(Nstep:smallint):integer; virtual; abstract;
 function  OneStep(Nstep:smallint):integer;
 function  TurnOn:boolean;                 virtual;  abstract;
 function  TurnOff:boolean;                virtual;  abstract;
 function  ScanMotorTurnOn:boolean;        virtual;
 function  ScanMotorTurnOff:boolean;       virtual;
 function  ScanningMethod:boolean;         virtual;  abstract;
 function  ScanMoveToX0Y0Method(X0,Y0:single):boolean; virtual;  abstract ;
 function  ScanCalibrateMethod:boolean;    virtual;  abstract;
 function  ScannerTrainnigMethod:boolean;  virtual;  abstract;
 function  LithoSFMMethod:boolean;         virtual;  abstract;
 function  TurnOnFBMethod:boolean;         virtual;  abstract;
 function  FastTopoMethod:boolean;         virtual;  abstract;
 function  SpectroscopyMethod:boolean;     virtual;  abstract;
 function  StepTestMethod:boolean;         virtual;  abstract;
 function  ResonanceMethod:boolean;        virtual;  abstract;
 function  ApproachMethod:boolean;         virtual;  abstract;
 function  ScannerMoveXYZMethod:boolean;   virtual;
 function  WritetoMLPCMethod:boolean;      virtual;
 function  ReadFromMLPCMethod(RPages:integer):boolean; virtual;
 function  SetSensor(_sensor:RSensor):boolean; virtual; abstract;
 function  WritePagetoMemoryMethod(flgDatatype:integer):boolean;                     virtual;
 function  WritetoMemoryMethod(RecPointersList:TList; startPage:integer):boolean;    virtual;

 function  GetDeviceIdMethod:boolean;      virtual;

 function  TestforAnodeLitho:boolean;
 function  TestForReniShaw:boolean;
 function  SetPIDParameters:boolean;


 Constructor Create;
 Destructor  Destroy;                  override;

 property  ControllerNumber:string     read   GetControllerNumber;
 property  ZValue:apitype              read   GetZValue;
 property  SignalValue:apitype         read   GetSignalValue;
 property  FeedBackRough:apitype       write  SetFeedBackRough;//pro
 property  FineZ:boolean               write  SetFineZ;//pro
 property  FineXY:boolean              write  SetFineXY;//pro
 property  UpperLimitOut:boolean       read   GetUpperLimitOut;
 property  SetPoint:single{apitype}    write  SetSetPoint;
 property  FeedBackBand:PIDtype        write  SetFeedBack;
 property  Bias:apitype                read   GetBias write  SetBias;
 property  SD_GAM:apitype              read   GetSD_GAM write SetSD_GAM;  // усиление амплитуды раскачки
 property  SD_GENF:apitype             write  SetSD_GENF;    //freq
 property  BramUflg:apitype            read   GetBramUflg write  SetBramUflg;  //PID
 property  IMaxCut:integer             read   GetImaxCut  write  SetImaxCut;
end;

var NanoEdu:TBaseNanoEdu;



implementation

 uses    Forms, GlobalVar,MLPC_APILib_TLB, UNanoeduInterface, UAdapterService,
         SIOCSPM,frNoFormUnitLoc,nanoeduhelp, MLPCVariablesThread, uNanoEduScanClasses;

 constructor TBaseNanoEdu.Create;
var CZTune:word;
    IU:IUnknown;
    hr:Hresult;
    vbool:WordBool;
begin
   setlength(arPCChannel,10);
   SetPIDParameters;
   API:=TPMAPI05.Create as IpmAPI05;
   inherited;
end;
 function  TBaseNanoEdu.ScannerMoveXYZMethod:boolean;
begin
 NanoEdu.Method:=TScannerMoveXYZ.Create;
end;
function   TBaseNanoEdu.WritetoMLPCMethod:boolean;
begin
  NanoEdu.Method:=TWriteToAdapter.Create;
end;

function  TBaseNanoEdu.WritePagetoMemoryMethod(flgDatatype:integer):boolean;
begin
(*  case flgDatatype of   // flgDatatype = PageNmb;
  1: NanoEdu.Method:=TWriteMemoryPage.Create(ScannerOptModX,flgDatatype );
  2: NanoEdu.Method:=TWriteMemoryPage.Create(ScannerOptModY, flgDatatype);
  3: NanoEdu.Method:=TWriteMemoryPage.Create(JustLinerizData, flgDatatype);
  4: NanoEdu.Method:=TWriteMemoryPage.Create(JustLinerizData, flgDatatype);
  end;
*)
end;

function  TBaseNanoEdu.WritetoMemoryMethod(RecPointersList:TList; startPage:integer):boolean;
begin
//   NanoEdu.Method:=TWriteMemoryPage.Create(RecPointersList, startPage );
end;


function   TBaseNanoEdu.ReadFromMLPCMethod(RPages:integer):boolean;
begin
  NanoEdu.Method:=TReadFromAdapter.Create(RPages);
end;

function  TBaseNanoEdu.GetDeviceIdMethod:boolean;
begin
  NanoEdu.Method:=TGetDeviceId.Create;
end;

destructor TBaseNanoEdu.Destroy();
var hr:Hresult;
  vbool:WordBool;
begin
    FreeAndNil(Method);
    finalize(arPCChannel);
    inherited ;
end;
function   TBaseNanoEdu.GetAdapterID:integer;
var error:integer;
begin
  NanoEdu.Method:=TGetDeviceId.Create;
  error:=NanoEdu.Method.Launch;
   if error<>0 then
     begin FreeAndNil(NanoEdu.Method); result:=9999; exit  end;
//    Application.ProcessMessages;
//    Events.waitfor(10000);
//    Events.ResetEvent;
end;
function   TBaseNanoEdu.GetControllerParams:PControllerParamsRecord;
var error:integer;
begin
  NanoEdu.Method:=TGetControllerParams.Create;
  error:=NanoEdu.Method.Launch;
   if error<>0 then
     begin FreeAndNil(NanoEdu.Method);  exit  end;
//    Application.ProcessMessages;
//    Events.waitfor(10000);
//    Events.ResetEvent;
end;
function  TBaseNanoEdu.ControllerConnect:boolean;
begin

end;

function  TBaseNanoEdu.DisconnectController:boolean;
begin

end;
function  TBaseNanoEdu.TestAdapterIsNew:boolean;
var  error,PageHeader:integer;
begin
   PageHeader:=1;   //   !!
   Nanoedu.ReadFromMLPCMethod(PageHeader);
   error:=NanoEdu.Method.Launch;
   if error<>0 then
     begin FreeAndNil(NanoEdu.Method); result:=false; exit  end;
end;

function  TBaseNanoEdu.ReadFromDataAdapter(taskdata:integer):boolean;
var  error:integer;
begin
   Nanoedu.ReadFromMLPCMethod(taskdata);
   error:=NanoEdu.Method.Launch;
   if error<>0 then
     begin FreeAndNil(NanoEdu.Method); result:=false; exit  end;
//   WaitforJavaNotActive;
   result:=true;
end;

procedure TBaseNanoEdu.ScannerRetract;
begin
    flgRetract:=true;
    API.ITRRES:=0;
    Sleep(ApproachParams.ScannerDecay);
end;

procedure TBaseNanoEdu.SetDACZero;
begin
 API.DACX:=0;
 API.DACY:=0;
 API.DACZ:=0;
end;


procedure TBaseNanoEdu.GetCurrentPosition;
begin
  ScanParams.XBegin:=(-API.DACX+CSPMSignals[8].MaxDiscr)/TransformUnit.XPnm_d-Scanparams.xshift;
  ScanParams.YBegin:=(-API.DACY+CSPMSignals[9].MaxDiscr)/TransformUnit.YPnm_d-Scanparams.yshift;
end;
procedure TBaseNanoedu.SetFeedBack(val:PidType);
begin
   NanoEdu.SetPIDParameters;
end;

function TBaseNanoEdu.CalcFBKoefDemo:single;
begin
case    ApproachParams.FreqBandF of
  0:   Result:=0;
  1:   Result:= 0.35;
  2:   Result:=  0.6;
  3:   Result:=  0.74;
  4:   Result:=  0.8;
  5:   Result:=  0.87;
  6:   Result := 0.93;
  7:   Result := 1.0;
  end;
end;

procedure TBaseNanoedu.SetFeedBackRough(val:apitype);
begin
// API.FBSEL:=val;//ApproachParams.FreqBandR;
end;
procedure TBaseNanoedu.SetFineZ(val:boolean);
begin
// API.TuneZ:=byte(val);//CZTune;
end;


procedure TBaseNanoedu.SetFineXY(val:boolean);
begin
// API.XYTune:=byte(val);//CZTune;
end;

function TBaseNanoedu.GetUpperLimitOut:boolean;
var Mask:apitype;
begin
  Mask:=$0200;
  result:=(API.CmpValue AND Mask)=0;
end;

function TBaseNanoedu.GetZValue:apitype;
var z:apitype;
begin
 z:=apitype(API.Z);
// if z>0 then z:=0 else   z:=-(z+1);
 result:=z;
end;
procedure TBaseNanoEdu.SetBias(val:apitype);
begin
    API.DACVT:=apitype(val);
end;
function TBaseNanoEdu.GetBias:apitype;
begin
    result:=API.DACVT;
end;
 procedure  TBaseNanoEdu.SetSD_GAM(val:apitype); //Amplitude Modulation
begin
 API.SDGAM:=val;// SetCommonVar(SD_GAIN_AM,val);
end;
function TBaseNanoEdu.GetSD_GAM:apitype; //Amplitude Modulation
begin
 result:=API.SDGAM;// SetCommonVar(SD_GAIN_AM,val);
end;
procedure TBaseNanoEdu.SetSD_GENF(val:apitype);  //Frequency  generator  Rough
begin
 API.Frequency:=val;//  SetCommonVar(SD_GENF_R,val);
end;
function  TBaseNanoEdu.GetBramUflg:apitype;
begin
 result:=Api.ChooseBramU;
end;
procedure TBaseNanoEdu.SetBramUflg(val:apitype);
begin
 Api.ChooseBramU:=val;
end;
function  TBaseNanoEdu.GetImaxCut:integer;
begin
  result:=0;
end;
procedure  TBaseNanoEdu.SetImaxCut(val:integer);
begin
   Api.IMaxCutVal:=val;
end;
function TBaseNanoedu.GetControllerNumber:string;
var sernum:PWideChar;
    len:pDword;
    tst:DWord;
begin
// nanoeduII
result:='Demo';
//
(* GetMem(sernum,Max_path);
 new(len);
 len^:=255;
// {$IFDEF DYNAMIC}
 tst:=GetSerialNumber(sernum,len);
 if tst=0 then begin result:=string(sernum) ; if result=''  then result:='error'; end
          else  Result:='error';
 dispose(len);//:=nil;   { TODO : 250907 }
 FreeMem(sernum);
 *)
end;


function  TBaseNanoedu.OneStep(Nstep:smallint):integer;
 var state:apitype;
begin
 ScannerRetract;  //230112
  state:=Api.SMZSTATUS;
  Api.SMZSTEP:=-NStep;    //?????  -
  ScannerProtract;// 230112
end;
 function TBaseNanoedu.ScanMotorTurnOn:boolean;
begin
   ScanMotorX:=TstepMotorX.Create;
   ScanMotorX.TurnOn;
   ScanMotorY:=TstepMotorY.Create;
   ScanMotorY.TurnOn;
end;
function TBaseNanoedu.ScanMotorTurnOff:boolean;
begin
   ScanMotorX.TurnOff;
   FreeAndNil(ScanMotorX);
   NanoEdu.ScanMotorY.TurnOff;
   FreeAndNil(ScanMotorY);
end;
 function  TBaseNanoedu.TestForAnodeLitho:boolean;
begin
  result:=true;
  case  LoadScript(AnodeLithoTestScrpt) of
1,2: result:=false;
  end;
end;
function   TBaseNanoedu.SetPIDParameters:boolean;
  var hr:HRESULT;
      IU:IUnknown;
begin
 result:=true;
 (*  if not assigned(VarsThread) or (not VarsThreadActive) then // make sure its not already running
                                begin
                                 VarsThread:= TMLPCVariablesThread.Create;
                                 VarsThreadActive := True;
                               end ;  *)

if Assigned(SchematicControl) then
     begin
       SchematicControl.QueryLFB(WideString('pid'),IU);
       if FlgCurrentUserLevel<>Demo then NanoeduPC_PID:= (IU as ILFB_PID)
                                    else NanoeduPC_PID:= (IU as ILFB_PIDDemo) ;
       {$IFDEF DEBUG}
           Formlog.memolog.Lines.add('*********ILFB_PID');
       {$ENDIF};
     try
      with PIDParams do
         NanoeduPC_PID.Write(dT,Te,Td,sgnTI*Ti);
      except
        on Exception do
      begin
       result:=false;
      // showmessage('write PID :block resource');
       exit;
      end;

      end;
       {$IFDEF DEBUG}
               with  PIDParams       do
                   begin
                    Formlog.memolog.Lines.add('Set PID  Ti='+floattoStrF(sgnTi*Ti,fffixed,7,2));
                    Formlog.memolog.Lines.add('Set PID  Te='+floattoStrF(Te,fffixed,7,2));
                    Formlog.memolog.Lines.add('Set PID  Td='+floattoStrF(Td,fffixed,7,2));
                    Formlog.memolog.Lines.add('Set PID  dT='+floattoStrF(dT,fffixed,7,2));
                  end;
          Formlog.memolog.Lines.add('WRITE PID Params OK');
       {$ENDIF};
     end;

 end;



function  TBaseNanoedu.TestForReniShaw:boolean;
begin
(*  result:=true;
  case  LoadScript(RenishawTestScrpt) of
1,2: result:=false;
     end;
*)
end;

// TStepMotor

procedure TMotor.TurnOn;
begin
// API.ITRRES:=1;     // втянуть сканер 061107
end;
constructor TMotor.create;
begin
//
end;

procedure TStepMotor.TurnOn;
begin
 inherited;
// API.SDZero:=1;     // SetCommonVar(SD_ZERO,1);     //turn on step motor
// Speed:=1;
end;

procedure TStepMotor.TurnOff;
begin
(* API.ITRRES:=1;    //втянуть
 sleep(ApproachParams.ScannerDecay);
 API.SDZero:=0;    //turn off step motor
 API.ITRRES:=0;    //вытянуть
 sleep(ApproachParams.IntegratorDelay);
 *)
end;

procedure TStepMotor.SetMotorSPEED(val:apitype);
begin
// API.SMZSPEED:=val;
end;
procedure TStepMotor.SetMotorPause(val:apitype);
begin
end;
procedure TPiezoMotor.TurnOn;
begin
 inherited;
// API.SDZero:=0;
end;

procedure TPiezoMotor.TurnOff;
begin
(* API.ITRRES:=1;    //втянуть
 sleep(ApproachParams.ScannerDecay);
 API.SDZero:=0;   // SetCommonVar(SD_ZERO,0);  //turn off step motor
 API.ITRRES:=0;    //вытянуть
 sleep(ApproachParams.IntegratorDelay);
 *)
end;

procedure TPiezoMotor.SetMotorSPEED(val:apitype);
begin
(* if ApproachParams.ZStepsNumb>0 then if val>30 then val:=30;   ///????
 API.PMSPEED:=val;
 *)
end;
procedure TPiezoMotor.SetMotorPause(val:apitype);
begin
// if ApproachParams.ZStepsNumb>0 then if val>30 then val:=30;  ///?????
// setCommonVar(adr96,unapitype(val));  //PMPAUSE API.PMPAUSE:=val;
end;

constructor TPiezoMotorXYZ.Create;
begin
(* API.CMPENA:=0;
 API.CMPRES:=0;
 API.ENDSCAN:=0;
 *)
end;
procedure TPiezoMotorXYZ.SetMotorSPEED(val:apitype);
begin
(* if val>30 then val:=30;   ///????
 API.PMSPEED:=val;
 *)
end;
procedure TPiezoMotorXYZ.SetMotorPause(val:apitype);
begin
// setCommonVar(adr86,unapitype(val));  //PMPAUSE
end;
procedure TPiezoMotorZ.SetMotorPause(val:apitype);
begin
// setCommonVar(adr96,unapitype(val));  //PMPAUSE
end;

procedure TPiezoMotorZ.TurnOn;
begin
// API.CMPENA:=0;API.CMPRES:=0; API.ENDSCAN:=0;
end;
procedure TPiezoMotorXYZ.TurnOn;
begin
 inherited;
(*case ScannerMoveXYZParams.TypeMover of
2: begin API.CMPENA:=1;API.CMPRES:=0; API.ENDSCAN:=0; end;  //x
3: begin API.CMPENA:=0;API.CMPRES:=1; API.ENDSCAN:=0; end;  //y
4: begin API.CMPENA:=0;API.CMPRES:=0; API.ENDSCAN:=1; end;  //z
    end;
*)
end;
procedure TPiezoMotorXYZ.TurnOff;
begin
// API.ITRRES:=1;    //втянуть
// sleep(ApproachParams.ScannerDecay);
(* API.CMPENA:=0;
 API.CMPRES:=0;
 API.ENDSCAN:=0;
 API.ITRRES:=0;    //вытянуть
 sleep(ApproachParams.IntegratorDelay);
 *)
end;

procedure TStepMotorX.TurnOn;
begin
(* API.SDZero:=1;
 speed:=1;
 *)
end;

procedure TStepMotorX.TurnOff;
begin
 //API.SDZero:=0;   // SetCommonVar(SD_ZERO,0);     //turn off step motor
end;

procedure TStepMotorX.SetMotorSPEED(val:apitype);
begin
 //API.SMZSPEED:=val;//  SetCommonVar(SMZ_SPEED,val);
end;
 procedure TStepMotorY.TurnOn;
begin
(* API.SDZero:=1;
 speed:=1;
 *)
end;

procedure TStepMotorY.TurnOff;
begin
// API.SDZero:=0;   // SetCommonVar(SD_ZERO,0);     //turn off step motor
end;

procedure TStepMotorY.SetMotorSPEED(val:apitype);
begin
// API.SMXSPEED:=val;//  SetCommonVar(SMZ_SPEED,val);
end;
///******
(*
procedure TScannerMoveXYZ.SetNSteps(val:apitype);
  begin
 //   setCommonVar(adr84,unapitype(val));  //CNStep_XY=$84
   end;
function TScannerMoveXYZ.GetNSteps;
   begin
//    result:=GetCommonVar(adr84);  //CNStep_XY=$84
   end;
procedure TScannerMoveXYZ.SetStatus_Move(val:apitype);
   begin
 //   setCommonVar(adr80,unapitype(val)); //StatusMoveXY=$80
   end;
function  TScannerMoveXYZ.GetStatus_Move:apitype;
     begin
  //      Result:=GetCommonVar(adr80);  //StatusMoveXY=$80
      end;
procedure TScannerMoveXYZ.SetStepResult(val:apitype);
    begin
//    setCommonVar(adr82,unapitype(val)); //StatusStep=$82;
    end;

function  TScannerMoveXYZ.GetStepResult:apitype;
     begin
  //      Result:=GetCommonVar(adr82);  //StatusStep=$82;
      end;
function  TScannerMoveXYZ.GetFlgEndScript:boolean;
var flg:apitype;
begin
//  flg:=GetCommonUserVar(ch_Endscript);  //cFlgEndscriptPM=$88
  result:=(flg=1);
end;
 procedure  TScannerMoveXYZ.SetFlgEndScript(val:boolean);
 var flg:apitype;
 begin
   case val of
  true: flg:=1;
 false: flg:=0;
   end;
 // SetCommonUserVar(ch_Endscript,flg)  //  cFlgEndscriptPM=$88
 end;
destructor TScannerMoveXYZ.Destroy();
begin
     FreeAndNil(Motor);
     inherited Destroy;
end;

procedure TScannerMoveXYZ.TurnOn;
begin
   Motor.TurnOff;
end;

procedure TScannerMoveXYZ.TurnOff;
begin
  Motor.TurnOff;
end;

procedure TScannerMoveXYZ.StopSteps;
begin
   if not flgEndScript then
    begin
     Status_Move:=word(Stop);
    while(not FlgEndScript) do Application.ProcessMessages;
    end;
    Motor.TurnOff;
end;

function  TScannerMoveXYZ.InitSteps(const script:string):integer;
begin
    result:=0;
   FlgEndScript:=false;
   case LoadScript(script) of
  1: begin
      NoFormUnitLoc.silang1.MessageDlg(strub4+script,mtError ,[mbOK,mbHelp],IDH_Recording_scripts);
      Motor.TurnOff;
      Result:=1;
      exit;
     end;
  2: begin
       NoFormUnitLoc.silang1.MessageDlg(strub4+script+'!'+#13+strub5,mtError ,[mbOK,mbHelp],IDH_Recording_scripts);
       Motor.TurnOff;
       result:=1;
       exit;
    end;
             end;
      NSteps:=ScannerMoveXYZParams.StepsNumb;
      Motor.Speed:=ScannerMoveXYZParams.PMActiveTime ;
      Motor.PAUSE:=ScannerMoveXYZParams.PMPause;
end;

function  TScannerMoveXYZ.Step:integer;
var lstatus:apitype;
begin
    lStatus:=StepResult;
    if not flgEndScript then
     begin
         Status_Move:=apitype(Start);
       repeat                     //waiting for the end one step
         begin
          sleep(200);
          lstatus:=StepResult;
         end;
        until ((lstatus<>0) or flgEndScript);     //flgStopApproach

             case lstatus of
      1: begin
          iStepsCount:=iStepsCount-ScannerMoveXYZParams.StepsNumb;
         end;
                     end;                //case
     end;
     result:=lStatus;
end;
constructor TScannerMoveXYZ.Create;
begin
  inherited;
  Motor:=TPiezoMotorXYZ.Create;
  iStepsCount:=0;
end;
*)

end.
