//100406v4
unit uNanoEduDemoClasses;     //11/12/12

interface

uses windows,forms,dialogs, SysUtils,
//ntspb
     GlobalType,GlobalScanDataType,CSPMVar, GlobalDcl,
     uNanoEduBaseClasses,uNanoEduClasses,
     uNanoEduScanClasses;
type
TSFMNanoEduDemo=class(TSFMNanoEdu)
private
protected
  function  GetMaxUAM:apitype;            override;
  function  GetSignalValue:apitype;       override;
  function  GetZValue:apitype;            override;
  procedure SetFeedBack(val:PIDType);     override;
public
 procedure  GetCurrentPosition;             override;
 function   GetAdapterID:integer;           override;
 function   GetControllerParams:PControllerParamsRecord;    override;
 function   TestAdapterIsNew:boolean;       override;
 procedure  ScannerProtract;
 function   RisingToStartPoint(Nstep:smallint):integer; override;
 procedure  NormalizeUAM;                 override;
 function   TurnOn:boolean;           override;
 function   LithoSFMMethod:boolean;   override;
 function   ScanningMethod:boolean;   override;
 function   ScanMoveToX0Y0Method(X0,Y0:single):boolean;   override;
 function   ScanCalibrateMethod:boolean;    override;
 function   ScannerTrainnigMethod:boolean;    override;
 function   SpectroscopyMethod:boolean;     override;
 function   ResonanceMethod:boolean;        override;
 function   ApproachMethod:boolean;         override;
end;

TSTMNanoEduDemo=class(TSTMNanoEdu)
protected
 procedure    SetFeedBack(val:PIDtype);    override;
private
 function     GetZValue:apitype;           override;
 function  GetSignalValue:apitype;  override;
public
 procedure GetCurrentPosition;             override;
 function  GetAdapterID:integer;           override;
 function  GetControllerParams:PControllerParamsRecord;    override;
 function  TestAdapterIsNew:boolean;       override;
 function  RisingToStartPoint(Nstep:smallint):integer; override;
 function  TurnOn:boolean;                 override;
 function  GetUpperLimitOut:boolean;       override;
 function  ApproachMethod:boolean;         override;
 function  ScanningMethod:boolean;         override;
 function   SpectroscopyMethod:boolean;     override;
 function  ScanMoveToX0Y0Method(X0,Y0:single):boolean;   override;
 function  ScanCalibrateMethod:boolean;    override;
 function   ScannerTrainnigMethod:boolean;    override;
 Constructor Create;
 Destructor  Destroy; override;
end;

//Methods

TScanMoveToX0Y0Demo=class(TScanMoveToX0Y0)
protected
   procedure SetPathSpeed;             override;
   function  InitBuffers:integer;      override;
   function  FreeBuffers:integer;      override;
   function  InitRegimeVars:integer;   override;
public
 Constructor Create(X0nm,y0nm:single);
end;

TScanCalibrateDemo=class(TScanCalibrate)
private
 function  LoadDemoData(FileName:string):integer;
 procedure CutDemoLine(X0,Y0,Len:single; ExpData:TData; var LenN:integer; var ExpLine:ArraySpline);
 procedure SplnInterp1D(ExpLine:ArraySpline; LenN:integer; Step:single; var DemoLine:TLine);
 procedure StartDraw;      override;
protected
 procedure SetPathSpeed;   override;
public

end;

TResonanceDemo=class(TResonance)
private
   AmplitudKoef:single;
   AMGainDemo:single;
   OscAmpDemo:single;
   SDFreqDemo:integer;
   UR:ArrayInt ;
   UF:ArrayInt ;
    dx:apitype;
   UMax:apitype;
function   ReadResonanceCurveFile(FileName:String):integer;
procedure  SetSD_GEN_M(val:word);
procedure  FindMaxU;
function   Sign(val:single):apitype;
procedure  SetFreq_Sel(fq:apitype);
procedure  ModifyData(RangeRF:apitype);
protected
 function    InitAlgorithmParamsFile:integer; override;
 function    InitRegimeVars:integer;           override;
 function    InitBuffers:integer;                override;
 function    FreeBuffers:integer;     override;
 procedure   StartDraw;               override;
public
 Constructor Create;
 destructor  Destroy;
// function    Launch:integer;            override;
end;

TApproachSFMDemo=class(TApproachSFM)
private
  flgMadeStepDemo:boolean;
  ZDemo:integer;
  TunnelCurrentDemo:apitype;
  CurrentNoise:apitype;
  OscAmplitudDemo:Apitype;
  ITIndicatorMaximum, ITMaxDemo:apitype;
  function  ReadDemoData( FileName:String;const DataId:string; var DataArray:TLine):integer;
  function  GetflgEndScript:boolean;
  procedure SetFlgEndScript(val:boolean);
  function  GetFlgMadeStep:boolean;
  procedure SetflgMadeStep(val:boolean);
  function  InitBuffers:integer;                override;
  function  FreeBuffers:integer;                 override;
protected
 procedure   StartDraw;            override;
public
 Constructor Create;
 destructor  Destroy;
end;

TApproachSTMDemo=class(TApproachSTM)
private
  flgMadeStepDemo:boolean;
  ZDemo:integer;
  TunnelCurrentDemo:apitype;
  CurrentNoise:apitype;
  OscAmplitudDemo:Apitype;
   ITIndicatorMaximum, ITMaxDemo:apitype;
  function  InitBuffers:integer;                override;
  function  FreeBuffers:integer;                override;
protected
 procedure StartDraw;            override;
public
  Constructor Create;
end;

TScannerTrainnigDemo=class(TScannerTrainnig)
private
 function  LoadDemoData:integer;
 procedure StartDraw;           override;
protected
  function  InitRegimeVars:integer;  override;
  procedure SetPathSpeed;        override;
  function  InitBuffers:integer; override;
  function  FreeBuffers:integer;                 override;

public
end;

TTopographyDemo=class(TTopography)
private
 function  LoadDemoData(FileName:string):integer;
 procedure CutDemoArea(X0,Y0,LenX,LenY:single; ExpData:TData; var Area:TData);
 procedure SplnInterp2D(Area:TData; var DemoArea:TData);
protected
 function  InitRegimeVars:integer;  override;
 procedure SetPathSpeed;        override;
 procedure StartDraw;           override;
 function  InitBuffers:integer; override;
 function  FreeBuffers:integer; override;
public
end;

TLithoSFMDemo=class(TLithoSFM)
private
 function   LoadDemoData(FileName:string):integer;
 procedure  CutDemoArea(X0,Y0,LenX,LenY:single; ExpData:TData; var Area:TData);
 procedure  SplnInterp2D(Area:TData; var DemoArea:TData);
protected
  function  InitRegimeVars:integer;  override;
  procedure SetPathSpeed;        override;
  procedure StartDraw;           override;
  function  InitBuffers:integer; override;
  function  FreeBuffers:integer; override;
public
end;

TFastTopoDemo=class(TFastTopo)
private
 function  LoadDemoData(const FileName:string):integer;
 procedure CutDemoArea(X0,Y0,LenX,LenY:single; ExpData:TData; var Area:TData);
 procedure SplnInterp2D(Area:TData; var DemoArea:TData);
protected
  procedure SetPathSpeed;        override;
  procedure StartDraw;           override;
end;

TSpectroscopySFMDemo=class(TSpectroscopySFM)
private
  NPointsInSource:integer;
  Curve1,Curve2, XPoints1, XPoints2:ArraySpline;
  StartIndInSource:integer;
  function  LoadDemoCurves(const FileName:string;  var Curves:TMas2):integer;
  procedure SplnInterp1D(XPoints,ExpLine:ArraySpline; LenN:integer;  var DemoLine:TLine);
protected
  function  InitRegimeVars:integer;  override;
  function  LoadDemoData(FileName:string):integer;
  function  InitBuffers:integer; override;
  function  FreeBuffers:integer; override;
public
  function    Launch:integer;       override;
  constructor Create;
end;

TSpectroscopySTMDemo=class(TSpectroscopySTM)
private
  NPointsInSource:integer;
  Curve1,Curve2, XPoints1, XPoints2:ArraySpline;
  StartIndInSource:integer;
  function  LoadDemoCurves(const FileName:string;  var Curves:TMas2):integer;
 // procedure SplnInterp1D(XPoints,ExpLine:ArraySpline; LenN:integer;  var DemoLine:TLine);
protected
  function  InitRegimeVars:integer;  override;
  function  LoadDemoData(FileName:string):integer;
  function  InitBuffers:integer; override;
  function  FreeBuffers:integer; override;
public
  function    Launch:integer;       override;
  constructor Create;
end;


TStepTestDemo=class(TStepTest)
private
(*  function  InitBuffers:integer; override;
  procedure LinearPath;          override;
  procedure SetDataIn;           override;
  procedure SetPath;             override;
  procedure InitRegimeVars;      override;
  procedure StartDraw;           override;
public
 constructor Create;             overload;
 function  Launch:integer;       override;     *)
end;

implementation

uses
  classes, GlobalVar,GlobalFunction, UNanoEduInterface,
  frProgress, UScannerCorrect,frNoFormUnitLoc;

function  TResonanceDemo.ReadResonanceCurveFile(FileName:String):integer;
var Fl:TextFile;
    s,sres:STRING;
    i,k:integer;
    sz:integer;
    ffrqf,famplf,famplstep,ffrqstep:single;
    ffrq,fampl:integer;
    ffrq64:Int64;
    maxfampl:integer;
function StrGetNextValue(Delimeter: Char; var Str: String): string;
var
  SInd: Integer;
begin
  SInd := Pos(Delimeter, Str);
  if SInd > 0 then
  begin
    result := Copy(Str, 1, SInd-1);
    Delete(Str, 1, SInd);
  end
  else
  begin
    SInd := Pos(#13, Str);
    if SInd > 0 then
      result := Copy(Str, 1, SInd-1)
    else
      result := Str;
    Str := '';
  end;
  result := Trim(result);
end;
begin
 FileName:=DemoDataDirectory+DemoSample+'\'+FileName;
 randomize;
   if not FileExists(FileName) then
        begin
           NoFormUnitLoc.silang1.MessageDlg(strud1{'no Demo Data!!!'}, mtInformation,[mbOk],0);
           result:=1;
           exit;
        end;
   result:=0;
  try
    AssignFile(Fl, FileName);
  except
      on IO: EInOutError do
            begin
              NoFormUnitLoc.siLang1.messageDlg(FileName+strud2{' Open ERROR!'},mtwarning,[mbOk],0);
              result:=1;
              exit;
            end;
    end;
   try
    Reset(Fl);
    Readln(Fl, S);
    Readln(Fl, S);
    i:=0;
    if  (S=IdentifDemo) then
     begin
      Readln(fl,S);
      Readln(fl,S);  //nx=256
      StrGetNextValue('=', S);
      sz:=strtoint(S);
      ResonanceParams.NPoints:=sz;
      GetMem(DataBufIN,2*sz*sizeof(data_out_type));
      Readln(fl,S);
      StrGetNextValue('=', S);
      ffrqstep:=ConvertStringtoFloat(S);;
      Readln(fl,S);
      StrGetNextValue('=', S);
      famplStep:=ConvertStringtoFloat(S);
      famplStep:=famplStep/(0.9*ApproachParams.Amp_M/8) ;  // Подобран коэфф.
                       // для имитации изменения напряжения раскачки зонда
      maxfampl:=0;//$FFFFFFFF;     230114
     repeat
      Readln(Fl, S);
     until (S='Start of Data : ');
       Read(Fl,S);
       k:=0;
      for i:=0 to sz-1 do
        begin
         Sres:=StrGetNextValue(';', S);
         ffrqf:=ConvertStringtoFloat(sres);
         ffrq:=round(ffrqf);
         ffrq64:=round((int64(ffrq) shl 32)/million);
         PIntegerArray(DataBufIn)[k]:=integer(ffrq64);
          Sres:=StrGetNextValue(';', S);
         famplf:=ConvertStringtoFloat(sres);;
         fampl:=round((famplf+(0.0025- 0.005*0.01*random(100)))/famplstep) ;
         if maxFampl<fampl then maxfampl:=fampl;
         PIntegerArray(DataBufIn)[k+1]:=fampl shl 16;
         inc(k,2);
         end;
      end
      else
      begin
        NoFormUnitLoc.siLang1.ShowMessage(FileName+strud3{'File is not Demo!'});
        result:=MaxApiTYpe;
        exit;
      end;; {if S=IdentifDemo}
    finally
     CloseFile(Fl);
    end;
    result:=MaxfAmpl;
end; {ReadResonanceCurveFile}

procedure  TResonanceDemo.SetSD_GEN_M(val:word);
begin
   AMGainDemo:=val;
end;

procedure TResonanceDemo.findMaxU;
var i:integer;
begin
(*  Umax:=-32768;
         for i:=0 to (Dx-1)
          do
           begin
            if U[i]>Umax then
             begin
              Umax:=U[i];   iMax:=i;
             end;
           end;
           *)
end;

function   TResonanceDemo.Sign(val:single):apitype;
begin
  Result:=0;
  if val>0 then Result:=1
  else if val<0 then Result:=-1;
end;

procedure  TResonanceDemo.SetFreq_Sel(fq:apitype);
begin
   SDFreqDemo:=fq;
   ApproachParams.F0:=fq;
end;

procedure TResonanceDemo.ModifyData(RangeRF:apitype);
var i,r:integer;
    delt:integer;
    A0:single;
    A,C:single;
    pointKoef:single;
    UM:ArrayInt ;
begin
(*     case RangeRF of
     0:  delt:=30; //Fine
     1:  delt:=iMax;
        end;
    //  K:=(1-AmplitudKoef)/delt;
    //  A0:=AmplitudKoef;
      A:=(1-AmplitudKoef)/delt/delt;
      C:=AmplitudKoef;
      SetLength(UM,dx);
      for i:=-delt to  delt do
       begin
        r:=i+iMax;
       if (r>=0) and (r<dx) then
        begin
     //    pointKoef:=sign(i)*K*i+A0;
         pointKoef:=A*i*i+C;
         UM[r]:=round(U[r]*pointKoef/2);
         UM[r]:=UM[r]-random(round(0.05*UM[r]));
         if UM[r]>=MaxApiType-1 then U[r]:=MaxApiType-1
          else
          if UM[r]<0 then U[r]:=0
                     else U[r]:=UM[r];
        end;
       end;
      Finalize(UM);
      *)
end;
constructor TResonanceDemo.Create;
begin
  inherited Create;
  DemoParams.OscAmplRes:=ReadResonanceCurveFile('NEResRNew.txt');
//  AMGainDemo:=ApproachParams.Gain_AM/255;
  OscAmpDemo:=ApproachParams.Amp_M/ApproachParams.MaxAmp_M;
  SDFreqDemo:=10;
 // AmplitudKoef:=AMGainDemo+10*OscAmpDemo;
  Randomize;
end;


destructor TResonanceDemo.Destroy;
begin
 Finalize(UF);
 Finalize(UR);
end;

(*
function TSFMApproachDemo.ReadDemoData( FileName:String;const DataId:string; var DataArray:TLine):integer;
var Fl:TextFile;
    s:STRING;
    i,k,buf:integer;
begin
 FileName:=DemoDataDirectory+DemoSample+'\'+FileName;
   if not FileExists(FileName) then
        begin
            NoFormUnitLoc.siLang1.ShowMessage(FileName+strud1{ File not exist'});
           result:=1;
           exit;
        end;
   result:=0;
  try
    AssignFile(Fl, FileName);
  except
      on IO: EInOutError do
            begin
               NoFormUnitLoc.siLang1.messageDlg(FileName+strud2{' Open ERROR!'},mtwarning,[mbOk],0);
              result:=1;
              exit;
            end;
    end;
   try
    Reset(Fl);
    Readln(Fl, S);
    Readln(Fl, S);
    i:=0;
    if  (S=IdentifDemo) then
    begin
     Readln(Fl, S);
     if (S=DataId) then
     begin
     repeat
      Readln(Fl, S);
     until (S='Start of Data : ');
     while not Eof(Fl) do
        begin
         Read(Fl,Buf);
         inc(i);
        end;
     try
      SetLength(DataArray,i);
      for k:=0 to i-1 do
       Read(Fl,DataArray[k]);
     except
      DataArray:=nil;
     end;
     end;
    end
     else Result:=-1;
     finally
      CloseFile(Fl);
     end;
end;
*)



function  TSFMNanoEduDemo.GetZValue:apitype;
var rval:integer;
begin
 rVal:=DemoParams.Z+random(500)-250;
 if rval >= Maxapitype-1 then rval:= Maxapitype-1;
 if rval <= MinApitype then  rval:=  MinApitype ;
 result:=rval;
end;

function  TSFMNanoEduDemo.GetSignalValue:apitype;
var rval:integer;
begin
  rVal:=DemoParams.OscAmp+random(800)-400;
  if rval >= Maxapitype-1 then rval:= Maxapitype-1;
//  if rval <= MinApitype then  rval:=  MinApitype ;
    if rval <= 0 then  begin
                       rval:=  0 ;
                       end;
   result:=rval;
end;

function   TSFMNanoEduDemo.GetMaxUAM:apitype;
begin
  result :=ApproachParams.UAMMax;
end;

procedure TSFMNanoEduDemo.SetFeedBack(val:PIDtype);
begin
 DemoParams.FBKoef:=CalcFBKoefDemo;
end;

procedure TSFMNanoEduDemo.ScannerProtract;
begin
//    API.ITRRES:=16384;//$4000;
//    sleep(ApproachParams.ScannerDecay);
end;
function   TSFMNanoEduDemo.RisingToStartPoint(Nstep:smallint):integer;
begin
  sleep(1500);
end;
procedure TSFMNanoEduDEmo.NormalizeUAM;
var valDiscr:apitype;
begin
 if flgApproachOK then    ApproachParams.UAMMAX:=DemoParams.OscAmplRes
                  else    ApproachParams.UAMMAX:=MaxApiType;
      valDiscr:=ApproachParams.UAMMax;
     DemoParams.OscAmp:=ApproachParams.UAMMax;
 end;
function TSFMNanoEduDemo.GetAdapterID:integer;
begin
   flgAdapterLink:=true;
   AdapterID:=adDemoId;
   FlgDataScannerHaveRead:=false; //170113   true
   result:=adDemoId;
end;
function TSFMNanoEduDemo.GetControllerParams:PControllerParamsRecord;
begin
 with  PControllerParams^ do
 begin
        SN_LMT:='1111-1111';
        SN_NTSPB:='2222_2222';
        CFG_Size:=80;
        id:=1;
        XVStart:=0;
        XMOde:=1;
        X_Max:=250;
        X_Min:=0;
        X_Name:='DAC_X';
        YVStart:=0;
        YMOde:=1;
        Y_Max:=250;
        Y_Min:=0;
        Y_Name:='DAC_Y';
        ZVStart:=0;
        ZMOde:=1;
        Z_Max:=150;
        Z_Min:=0;
        Z_Name:='DAC_Z';
 end;
end;
function TSTMNanoEduDemo.GetControllerParams:PControllerParamsRecord;
var i:integer;
begin
 with  PControllerParams^ do
 begin
        SN_LMT:='1111-1111';
        SN_NTSPB:='2222_2222';
        CFG_Size:=80;
        id:=1;
        XVStart:=0;
        XMOde:=1;
        X_Max:=250;
        X_Min:=0;
        X_Name:='DAC_X';
        YVStart:=0;
        YMOde:=1;
        Y_Max:=250;
        Y_Min:=0;
        Y_Name:='DAC_Y';
        ZVStart:=0;
        ZMOde:=1;
        Z_Max:=150;
        Z_Min:=0;
        Z_Name:='DAC_Z';
 end;
end;
procedure TSFMNanoEduDemo.GetCurrentPosition;
begin
  ScanParams.XBegin:=(-MaxApiType+CSPMSignals[8].MaxDiscr)/TransformUnit.XPnm_d-Scanparams.xshift;
  ScanParams.YBegin:=(-MaxApiType+CSPMSignals[9].MaxDiscr)/TransformUnit.YPnm_d-Scanparams.yshift;
end;
function   TSFMNanoEduDemo.TestAdapterIsNew:boolean;
begin
   result:=true;
   FlgDataScannerHaveRead:=false;   //170113 true
end;
function TSFMNanoEduDemo.TurnOn:boolean;
begin
inherited  TurnOn;
 DemoParams.FBKoef:=CalcFBKoefDemo;
end;
(*
function TSFMNanoEduDemo.GetControllerNumber:string;
begin
 result:='Demo';
end;

function  TSFMNanoEduDemo.GetUpperLimitOut:boolean;
begin
  Result:=False;
end;

function TSFMNanoEduDemo.ResonanceRegime: boolean;
begin
 ScannerResonance:=TScannerResonanceDemo.Create;
end;
 *)
 (*
procedure TSFMNanoEduDemo.ApproachRegime;
begin
 ScannerApproach:=TSFMApproachDemo.Create;
end;
 *)
function  TSFMNanoEduDemo.ScanningMethod:boolean;
begin
  NanoEDu.Method:=TTopographyDemo.Create;
end;

function  TSFMNanoEduDemo.ScanMoveToX0Y0Method(X0,Y0:single):boolean;
begin
 NanoEdu.Method:=TScanMoveToX0Y0Demo.Create(X0,Y0);
end;


function  TSFMNanoEduDemo.ScanCalibrateMethod:boolean;
begin
 NanoEdu.Method:=TScanCalibrateDemo.Create;
end;
function  TSFMNanoEduDemo.ScannerTrainnigMethod:boolean;
begin
 NanoEdu.Method:=TScannerTrainnigDemo.Create;
end;

function  TSFMNanoEduDemo.LithoSFMMethod:boolean;
begin
  NanoEdu.Method:=TLithoSFMDemo.Create;
end;
(*
function  TSFMNanoEduDemo.FastTopoMethod:boolean;
begin
  NanoEdu.Method:=TFastTopoDemo.Create;
end;
*)
function  TSFMNanoEduDemo.SpectroscopyMethod:boolean;
begin
  NanoEdu.Method:=TSpectroscopySFMDemo.Create;
end;
(*
function  TSFMNanoEduDemo.StepTestMethod:boolean;
begin
  NanoEdu.Method:=TStepTestDemo.Create;
  result:=true;
end;
function  TSFMNanoEduDemo.AdjustPhaseMethod:boolean;
begin
  NanoEdu.Method:=TScannerPhaseAdjustDemo.Create;
  result:=true;
end;
 *)

(*
Constructor TSFMNanoEduDemo.Create;
begin
 inherited Create;

 //CalcInitZVal;
end;

destructor TSFMNanoEduDemo.Destroy();
begin
  inherited ;
end;

function TSTMNanoEduDemo.GetControllerNumber:string;
begin
 result:='Demo';
end;
*)
function   TSTMNanoEduDemo.GetAdapterID:integer;
begin
   flgAdapterLink:=true;
   AdapterID:=adDemoId;
   result:=adDemoId;
end;
procedure TSTMNanoEduDemo.GetCurrentPosition;
begin
  ScanParams.XBegin:=(-MaxApiType+CSPMSignals[8].MaxDiscr)/TransformUnit.XPnm_d-Scanparams.xshift;
  ScanParams.YBegin:=(-MaxApiType+CSPMSignals[9].MaxDiscr)/TransformUnit.YPnm_d-Scanparams.yshift;
end;

function   TSTMNanoEduDemo.TestAdapterIsNew:boolean;
begin
   result:=true;
end;
function   TSTMNanoEduDemo.RisingToStartPoint(Nstep:smallint):integer; 
begin
  sleep(1500);
end;

procedure TSTMNanoEduDemo.SetFeedBack(val:PIDtype);
begin
 DemoParams.FBKoef:=CalcFBKoefDemo;
end;


function  TSTMNanoEduDemo.GetZValue:apitype;
var rval:integer;
begin
 rVal:=DemoParams.Z+random(500)-250;
 if rval >= Maxapitype-1 then rval:= Maxapitype-1;
 if rval <= MinApitype then  rval:=  MinApitype ;
 result:=rval;
end;

function  TSTMNanoEduDemo.GetSignalValue:apitype;
var rval:integer;
begin
  rVal:=DemoParams.TunnelCurrent+random(180)-90;
  if rval >= Maxapitype-1 then rval:= Maxapitype-1;
//  if rval <= MinApitype then  rval:=  MinApitype ;
    if rval <= 0 then  begin
                       rval:=  0 ;
                       end;
   result:=rval;
end;

function TSTMNanoEduDemo.TurnOn:boolean;
begin
inherited  TurnOn;
 DemoParams.FBKoef:=CalcFBKoefDemo;
end;

function  TSTMNanoEduDemo.GetUpperLimitOut:boolean;
begin
  Result:=False;
end;

function TSFMNanoEduDemo.ApproachMethod:boolean;
begin
 NanoEdu.Method:=TApproachSFMDemo.Create;
end;


function TApproachSFMDemo.ReadDemoData( FileName:String;const DataId:string; var DataArray:TLine):integer;
var Fl:TextFile;
    s:STRING;
    i,k,buf:integer;
begin
 FileName:=DemoDataDirectory+DemoSample+'\'+FileName;
   if not FileExists(FileName) then
        begin
            NoFormUnitLoc.siLang1.ShowMessage(FileName+strud1{ File not exist'});
           result:=1;
           exit;
        end;
   result:=0;
  try
    AssignFile(Fl, FileName);
  except
      on IO: EInOutError do
            begin
               NoFormUnitLoc.siLang1.messageDlg(FileName+strud2{' Open ERROR!'},mtwarning,[mbOk],0);
              result:=1;
              exit;
            end;
    end;
   try
    Reset(Fl);
    Readln(Fl, S);
    Readln(Fl, S);
    i:=0;
    if  (S=IdentifDemo) then
    begin
     Readln(Fl, S);
     if (S=DataId) then
     begin
     repeat
      Readln(Fl, S);
     until (S='Start of Data : ');
     while not Eof(Fl) do
        begin
         Read(Fl,Buf);
         inc(i);
        end;
     try
      SetLength(DataArray,i);
      for k:=0 to i-1 do
       Read(Fl,DataArray[k]);
     except
      DataArray:=nil;
     end;
     end;
    end
     else Result:=-1;
     finally
      CloseFile(Fl);
     end;
end;

(*
function  TApproachSFMDemo.GetSignalValue:apitype;
begin
 Result:=DemoParams.OscAmp- random(200);
end;


function  TApproachSFMDemo.GetZValue:apitype;
begin
Result:=ZDemo;
//Result:=DemoParams.Z;
end;
*)
function   TApproachSFMDemo.GetflgEndScript:boolean;
begin
//  result:=FflgEndscript;
end;
 procedure   TApproachSFMDemo.SetFlgEndScript(val:boolean);
 begin
 //  FFlgEndScript:=val;
 end;
function  TApproachSFMDemo.GetFlgMadeStep:boolean;
begin
      Result:=FlgMadeStepDemo;
end;
procedure TApproachSFMDemo.SetflgMadeStep(val:boolean);
begin
 //  flgMadeStep:=val;
end;
constructor TApproachSFMDemo.Create;
begin
    inherited Create;
    ZDemo:=DemoParams.Z;
    PATH_SPDDemo:=500;
    OscAmplitudDemo:=DemoParams.OscAmp;
end;

destructor TApproachSFMDemo.Destroy;
begin
 // DemoParams.Z:=ZDemo;
//  DemoParams.OscAmp:=OscAmplitudDemo;
  inherited Destroy;
end;
function TApproachSFMDemo.InitBuffers:integer;
var i,k:integer;
    valZ_discr, valAmpl_discr:integer;
    dZ_Discr, dAmpl_discr:integer;
    Z_OK:integer;
    ZSteps_NewVal:integer;
    Appres:integer;
    stnmb:integer;
    ZGatediscr_min, ZGateDiscr_max:integer;
begin
  inherited InitBuffers;
  FreeMem(DoneBuf);
  FreeMem(DataBuf);
  ApproachParams.DataBufLength:=AlgParams.SizeElements*AlgParams.NElements  ;//30;//*2;   //status ; z ; signal
  GetMem(DoneBuf,(AlgParams.NElements+1)*sizeof(Integer));
  GetMem(DataBuf,ApproachParams.DataBufLength*sizeof(data_out_type));
  GetMem(DataBufIn,ApproachParams.DataBufLength*sizeof(data_out_type));
  k:=0;
  ZSteps_NewVal:=  ApproachParams.ZStepsDone;
  Appres:=0;
  stnmb:=ApproachParams.ZStepsNumb;
//if ApproachParams.ZStepsNumb>0 then      // landing
//begin

 ZGatediscr_min:= round(-65536*ApproachParams.ZGateMin + MaxApitype);   // нижняя риска - положит. значения
 ZGatediscr_max:= round(-65536*ApproachParams.ZGateMax + MaxApitype);    // верхняя риска - отрицат. значения
 Z_OK:=round(ZGatediscr_max +0.5*(ZGatediscr_min-ZGatediscr_max));  // discr


 (*if (abs(DemoParams.Z) < abs(ZGatediscr_min)) and (abs(DemoParams.Z) < abs(ZGatediscr_max))  then
   begin
     Appres:=3;        // OK
     stnmb:=0;         // идти не надо
   end;


if flgapproachOK then
     begin
         for I := 0 to (ApproachParams.DataBufLength div AlgParams.SizeElements -1) do
            begin
              PIntegerArray(DataBufIn)[k]:=3;
              PIntegerArray(DataBufIn)[k+1]:=Z_OK shl 16;             // Z  в положени захвата
              PIntegerArray(DataBufIn)[k+2]:=round(maxApitype*ApproachParams.LandingSetPoint) shl 16 ;
              PIntegerArray(DataBufIn)[k+3]:= 0;//round(Approach.StepsCount);
              inc(k,AlgParams.SizeElements);
            end;
     end
     else  *)
     begin

       valZ_discr:=MinApitype; //DemoParams.Z;// 
       valAmpl_discr:= maxApitype;//DemoParams.OscAmp;//   maxApitype;

       dZ_Discr:=300;
       dAmpl_discr:=100;

       k:=0;      // Теперь анализ текущего состояния выполняется в процедуре
                  // TMLPCChannelReadDemo.Read
       for I := 0 to (ApproachParams.DataBufLength div AlgParams.SizeElements -3) do
          begin
            PIntegerArray(DataBufIn)[k]:=Appres;
            valZ_discr:= valZ_discr + dZ_Discr;       //valZ_discr < 0
          (*  if  abs(valZ_discr) > abs(Z_OK) then
                inc(dZ_Discr,200)
                else dZ_Discr:=0; *)
            valZ_discr:=valZ_discr + 200+random(400);
            valAmpl_discr:= valAmpl_discr - dAmpl_Discr;       //valAmpl_discr > 0
            inc(dAmpl_Discr,100);
            valAmpl_discr:=valAmpl_discr - 200+random(600);
            if valAmpl_discr > Maxapitype-1 then valAmpl_discr:= Maxapitype-1;
            if valAmpl_discr < 0 then valAmpl_discr:= 0;
            PIntegerArray(DataBufIn)[k+1]:=valZ_discr shl 16;
            PIntegerArray(DataBufIn)[k+2]:=valAmpl_Discr shl 16;
           // ApproachParams.ZStepsDone:=ApproachParams.ZStepsDone+ApproachParams.ZStepsNumb;
            ZSteps_NewVal:= ZSteps_NewVal+  stnmb;
            PIntegerArray(DataBufIn)[k+3]:=ZSteps_NewVal;
            inc(k,AlgParams.SizeElements);
          end;
       valAmpl_discr:= valAmpl_discr - dAmpl_Discr;       //valAmpl_discr > 0
       valAmpl_discr:=valAmpl_discr - 200+random(400);
       if valAmpl_discr > Maxapitype-1 then valAmpl_discr:= Maxapitype-1;
       if valAmpl_discr < 0 then valAmpl_discr:= 0;
       PIntegerArray(DataBufIn)[k]:=Appres;
       PIntegerArray(DataBufIn)[k+1]:=Z_OK shl 16;
       PIntegerArray(DataBufIn)[k+2]:=valAmpl_Discr shl 16;
      // ApproachParams.ZStepsDone:=ApproachParams.ZStepsDone+ApproachParams.ZStepsNumb;
      // PIntegerArray(DataBufIn)[k+3]:=ApproachParams.ZStepsDone;
       ZSteps_NewVal:= ZSteps_NewVal+  stnmb;
       PIntegerArray(DataBufIn)[k+3]:=ZSteps_NewVal;
       inc(k,AlgParams.SizeElements);
       PIntegerArray(DataBufIn)[k]:=3;
       PIntegerArray(DataBufIn)[k+1]:= Z_OK shl 16;             // Z  в положени захвата
       // PIntegerArray(DataBufIn)[k+2]:=32767 shl 16;
       PIntegerArray(DataBufIn)[k+2]:= round(maxApitype*ApproachParams.LandingSetPoint) shl 16 ;
      // ApproachParams.ZStepsDone:=ApproachParams.ZStepsDone+ApproachParams.ZStepsNumb;
      //PIntegerArray(DataBufIn)[k+3]:=ApproachParams.ZStepsDone;
      ZSteps_NewVal:= ZSteps_NewVal+  stnmb;
       PIntegerArray(DataBufIn)[k+3]:=ZSteps_NewVal;
        inc(k,AlgParams.SizeElements);
   end ;

 for i:=0 to  AlgParams.NElements do PIntegerArray(DoneBuf)[i]:=done;
  setLength(ArDemoChannelParams,AlgParams.NChannels);
  ArDemoChannelParams[0].PBuffer:=StopBuf;
  ArDemoChannelParams[1].PBuffer:=DoneBuf;
  ArDemoChannelParams[2].PBuffer:=DataBufIn;
  ArDemoChannelParams[0].SizeElement:=1;
  ArDemoChannelParams[1].SizeElement:=1;
  ArDemoChannelParams[2].SizeElement:=AlgParams.SizeElements;
  ArDemoChannelParams[0].NElements:=1;
  ArDemoChannelParams[1].NElements:=1;
  ArDemoChannelParams[2].NElements:=AlgParams.NElements;
end;

function TApproachSFMDemo.FreeBuffers:integer;
begin
 inherited FreeBuffers;
 FreeMem(DataBufIn);
 Finalize(ArDemoChannelParams);
end;

procedure TApproachSFMDemo.StartDraw;
begin
 inherited StartDraw;
end;

function TSTMNanoEduDemo.ApproachMethod:boolean;
begin
 NanoEdu.Method:=TApproachSTMDemo.Create;
end;
function TApproachSTMDemo.InitBuffers:integer;
var i,k:integer;
    valZ_discr, valCurrent_discr:integer;
    dZ_Discr, dCurrent_discr:integer;
    Z_OK:integer;
    ZSteps_NewVal:integer;
    Appres:integer;
    stnmb, N:integer;
    ZGatediscr_min, ZGateDiscr_max:integer;
     ITStepDemo:integer;
begin
  inherited InitBuffers;
  FreeMem(DoneBuf);
  FreeMem(DataBuf);
  ApproachParams.DataBufLength:=AlgParams.SizeElements*AlgParams.NElements  ;//30;//*2;   //status ; z ; signal
  GetMem(DoneBuf,(AlgParams.NElements+1)*sizeof(Integer));
  GetMem(DataBuf,ApproachParams.DataBufLength*sizeof(data_out_type));
  GetMem(DataBufIn,ApproachParams.DataBufLength*sizeof(data_out_type));
  k:=0;
  ZSteps_NewVal:=  ApproachParams.ZStepsDone;
  Appres:=0;
  stnmb:=ApproachParams.ZStepsNumb;
//if ApproachParams.ZStepsNumb>0 then      // landing

 N:= ApproachParams.DataBufLength div AlgParams.SizeElements;

 ZGatediscr_min:= round(-65536*ApproachParams.ZGateMin + MaxApitype);   // нижняя риска - положит. значения
 ZGatediscr_max:= round(-65536*ApproachParams.ZGateMax + MaxApitype);    // верхняя риска - отрицат. значения
 Z_OK:=round(ZGatediscr_max +0.5*(ZGatediscr_min-ZGatediscr_max));  // discr

 ITMaxDemo:=round(ApproachParams.SetPoint*TransformUnit.nA_d);    // discr
 ITIndicatorMaximum:=round(ITMaxDemo*ApproachParams.ScaleMaxIT/ITCor);
  //  ITStepDemo:=round(0.07* ITMaxDemo*ApproachParams.LevelIT );
 ITStepDemo:= ITMaxDemo div (N +2);  // N+2 - чтобы не доходил до черты, пока не последний элемент буфера

 (*if (abs(DemoParams.Z) < abs(ZGatediscr_min)) and (abs(DemoParams.Z) < abs(ZGatediscr_max))  then
   begin
     Appres:=3;        // OK
     stnmb:=0;         // идти не надо
   end;
   *)
       valZ_discr:= minApitype;//  DemoParams.Z; //
       valCurrent_discr:=maxApitype;//DemoParams.TunnelCurrent;
       dZ_Discr:=300;
       k:=0;
       for I := 0 to (N -3) do
          begin
            PIntegerArray(DataBufIn)[k]:=Appres;
            valZ_discr:= valZ_discr + dZ_Discr;       //valZ_discr < 0
            if  (valZ_discr) < (Z_OK) then
                inc(dZ_Discr,200)
                else dZ_Discr:=0;
            valZ_discr:=valZ_discr + 200+random(400);
            valCurrent_discr:= valCurrent_discr - ITStepDemo;       //valCurrent_discr < 0
          //  inc(dCurrent_Discr,100);
            valCurrent_discr:=valCurrent_discr - 30+random(60);
         //   if valCurrent_discr > Maxapitype-1 then valCurrent_discr:= Maxapitype-1;
            if valCurrent_discr > 0 then valCurrent_discr:= 0;
            PIntegerArray(DataBufIn)[k+1]:=valZ_discr shl 16;
            PIntegerArray(DataBufIn)[k+2]:=valCurrent_Discr shl 16;
           // ApproachParams.ZStepsDone:=ApproachParams.ZStepsDone+ApproachParams.ZStepsNumb;
            ZSteps_NewVal:= ZSteps_NewVal+  stnmb;
            PIntegerArray(DataBufIn)[k+3]:=ZSteps_NewVal;
            inc(k,AlgParams.SizeElements);
          end;
       valCurrent_discr:= valCurrent_discr - ITStepDemo;
       valCurrent_discr:=valCurrent_discr - 30+random(60);
      // if valCurrent_discr > Maxapitype-1 then valCurrent_discr:= Maxapitype-1;
       if valCurrent_discr > 0 then valCurrent_discr:= 0;
       PIntegerArray(DataBufIn)[k]:=Appres;
       PIntegerArray(DataBufIn)[k+1]:=Z_OK shl 16;
       PIntegerArray(DataBufIn)[k+2]:=valCurrent_Discr shl 16;
      // ApproachParams.ZStepsDone:=ApproachParams.ZStepsDone+ApproachParams.ZStepsNumb;
      // PIntegerArray(DataBufIn)[k+3]:=ApproachParams.ZStepsDone;
       ZSteps_NewVal:= ZSteps_NewVal+  stnmb;
       PIntegerArray(DataBufIn)[k+3]:=ZSteps_NewVal;
       inc(k,AlgParams.SizeElements);
       PIntegerArray(DataBufIn)[k]:=3;
       PIntegerArray(DataBufIn)[k+1]:= Z_OK shl 16;             // Z  в положени захвата
       // PIntegerArray(DataBufIn)[k+2]:=32767 shl 16;
       PIntegerArray(DataBufIn)[k+2]:= round(-ITMaxDemo) shl 16 ;
       
      // ApproachParams.ZStepsDone:=ApproachParams.ZStepsDone+ApproachParams.ZStepsNumb;
      //PIntegerArray(DataBufIn)[k+3]:=ApproachParams.ZStepsDone;
       ZSteps_NewVal:= ZSteps_NewVal+  stnmb;
       PIntegerArray(DataBufIn)[k+3]:=ZSteps_NewVal;
       inc(k,AlgParams.SizeElements);


 for i:=0 to  AlgParams.NElements do PIntegerArray(DoneBuf)[i]:=done;
  setLength(ArDemoChannelParams,AlgParams.NChannels);
  ArDemoChannelParams[0].PBuffer:=StopBuf;
  ArDemoChannelParams[1].PBuffer:=DoneBuf;
  ArDemoChannelParams[2].PBuffer:=DataBufIn;
  ArDemoChannelParams[0].SizeElement:=1;
  ArDemoChannelParams[1].SizeElement:=1;
  ArDemoChannelParams[2].SizeElement:=AlgParams.SizeElements;
  ArDemoChannelParams[0].NElements:=1;
  ArDemoChannelParams[1].NElements:=1;
  ArDemoChannelParams[2].NElements:=AlgParams.NElements;
end;

function  TApproachSTMDemo.FreeBuffers:integer;
begin
 inherited FreeBuffers;
 FreeMem(DataBufIn);
 Finalize(ArDemoChannelParams)
end;
procedure TApproachSTMDemo.StartDraw;
begin
 inherited StartDraw;
end;
constructor TApproachSTMDemo.Create;
begin
    inherited Create;
    ZDemo:=DemoParams.Z;
    TunnelCurrentDemo:= DemoParams.TunnelCurrent;
    PATH_SPDDemo:=500;
    OscAmplitudDemo:=DemoParams.OscAmp;
end;
function TSFMNanoEduDemo.ResonanceMethod:boolean;
begin
 NanoEdu.Method:=TResonanceDemo.Create;
end;
procedure TResonanceDemo.StartDraw;
begin
 inherited StartDraw;
 end;
function  TResonanceDemo.InitAlgorithmParamsFile:integer;
var val:int64;
    v:integer;
begin
 with  AlgParams do
 begin
   NChannels:=ResonanceParams.NChannels;
   NElements:=ResonanceParams.NPoints;  //dataout    channel
   SizeElements:=2;  //dataout channel
   NGetCountEvent:=30;
   val:=round((int64(ResonanceParams.FreqStart) shl 32)/million);
   v:=integer(val);
   params[0]:=ByteInversion(v);
   val:=round((int64(ResonanceParams.Step) shl 32)/million);
   v:=integer(val);
   params[1]:=ByteInversion(v);
   params[2]:=ByteInversion(ResonanceParams.NPoints);
   params[3]:=ByteInversion(ResonanceParams.Delay);
 end;
end;
function  TResonanceDemo.InitRegimeVars:integer;
var i,j:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(ResonanceNScrpt); //wide

  InitBuffers;
  PATH_SPDDemo:=1;
  if assigned(ScanData) then FreeandNil(ScanData);
  ScanData:=TExperiment.Create;
  ScanData.AquiTopo.Nx:=2*ResonanceParams.Npoints;   //{frq,Ampl}
  ScanData.AquiTopo.Ny:=1;
     try
       SetLength(ScanData.AquiTopo.Data,ScanData.AquiTopo.Nx,ScanData.AquiTopo.Ny);   //23.11.01   x->y
      for i:=0 to ScanData.AquiTopo.Nx-1 do ScanData.AquiTopo.Data[i,0]:=0;
           except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
           end;
 GETCOUNT_DELAY:=40;
 SetSpeed;
end;
function TResonanceDemo.FreeBuffers:integer;
begin
 inherited FreeBuffers;
 FreeMem(DataBufIn);
 Finalize(ArDemoChannelParams);
end;
function TResonanceDemo.InitBuffers:integer;
var i,k:integer;
begin
  inherited InitBuffers;
//  GetMem(DataBufIn,ResonanceParams.NPoints*2*sizeof(data_out_type));
  setLength(ArDemoChannelParams,AlgParams.NChannels);
  ArDemoChannelParams[0].PBuffer:=StopBuf;
  ArDemoChannelParams[0].SizeElement:=1;
  ArDemoChannelParams[0].NElements:=1;
  ArDemoChannelParams[1].PBuffer:=DoneBuf;
  ArDemoChannelParams[1].SizeElement:=1;
  ArDemoChannelParams[1].NElements:=1;
  ArDemoChannelParams[2].SizeElement:=AlgParams.SizeElements;
  ArDemoChannelParams[2].NElements:=AlgParams.NElements;
  ArDemoChannelParams[2].PBuffer:=DataBufIn;
end;
function  TSTMNanoEduDemo.ScanningMethod:boolean;
begin
NanoEDu.Method:=TTopographyDemo.Create;
end;
function  TSTMNanoEduDemo.ScanMoveToX0Y0Method(X0,Y0:single):boolean;
begin
 NanoEdu.Method:=TScanMoveToX0Y0Demo.Create(X0,Y0);
end;
function  TSTMNanoEduDemo.ScanCalibrateMethod:boolean;
begin
 NanoEdu.Method:=TScanCalibrateDemo.Create;
end;

function  TSTMNanoEduDemo.ScannerTrainnigMethod:boolean;
begin
 NanoEdu.Method:=TScannerTrainnigDemo.Create;
end;

function   TSTMNanoEduDemo.SpectroscopyMethod:boolean;
begin
  NanoEdu.Method:=TSpectroscopySTMDemo.Create;
end;

Constructor TSTMNanoEduDemo.Create;
begin
 inherited Create;
end;

destructor TSTMNanoEduDemo.Destroy();
begin
  inherited ;
end;

procedure TScanMoveToX0Y0Demo.SetPathSpeed;
var
DemoPointDelay:integer;
begin
  with ScanParams do
 if (ScanPath=OneX ) or (ScanPath=Multi) then
      DemoPointDelay:=round(1000*ScanParams.X/(ScanParams.ScanRate*ScanParams.Nx))  // mc
    else     DemoPointDelay:=round(1000*ScanParams.Y/(ScanParams.ScanRate*ScanParams.NY));  // mc
 API.PATHSPD:=2*DemoPointDelay;  // "2*" is for Back path
end;
function TScanMoveToX0Y0Demo.InitBuffers:integer;
var i:integer;
begin
  inherited InitBuffers;
  FreeMem(DoneBuf);
  GetMem(DoneBuf,6*sizeof(Integer));
  setLength(ArDemoChannelParams,AlgParams.NChannels);   //????? 12.08.13
  ArDemoChannelParams[0].PBuffer:=StopBuf;
  ArDemoChannelParams[0].SizeElement:=1;
  ArDemoChannelParams[0].NElements:=1;
  ArDemoChannelParams[1].PBuffer:=DoneBuf;
  ArDemoChannelParams[1].SizeElement:=1;
  ArDemoChannelParams[1].NElements:=6;

  for I :=0 to 4 do   PIntegerArray(DoneBuf)[i]:=0;
  PIntegerArray(DoneBuf)[5]:=done;
end;
 function  TScanMoveToX0Y0Demo.FreeBuffers:integer;
 begin
   inherited FreeBuffers;
   Finalize(ArDemoChannelParams);
 end;
function TScanMoveToX0Y0Demo.InitRegimeVars:integer;
begin
 InitAlgorithmParamsFile;
 CreateAlgorithmParamsFile;
 AlgorithmJava:=WideString(MovetoScrpt);
 InitBuffers;
 SetSpeed;
end;
constructor TScanMoveToX0Y0Demo.Create(X0nm,y0nm:single);
begin
// inherited Create;
 X0:=-round((X0nm+Scanparams.xshift)*TransformUnit.XPnm_d)+CSPMSignals[8].MaxDiscr;       //discrets   add P
 y0:=-round((y0nm+Scanparams.yshift)*TransformUnit.yPnm_d)+CSPMSignals[9].MaxDiscr;       //discrets   add P
 MoveToMicrostepDelay:=ScanParams.MicrostepDelay;
// InitRegimeVars;
end;
(*
function  TScanCalibrateDemo.InitBuffers:integer;
begin
           ScanParams.sz:=1;
      case  ScanParams.ScanMethod of
 Phase,UAM,CurrentSTM,
 FastScan,
 FastScanPhase:
           begin
             ScanParams.sz:=2;
           end;
             end;
  PathLength:=(2*ScanParams.ScanPoints-1)*2;

  //number of points for DemoVersion
    Data_in_BufferLength:=2*ScanParams.ScanPoints*ScanParams.sz;

  Data_out_BufferLength:=(2*ScanParams.Scanpoints-1)*ScanParams.sz;
  GetMem(data_path,PathLength{4}*sizeof(word));
  GetMem(data_out,Data_out_BufferLength{((2*ScanParams.ScanPoints-1)*ScanParams.sz)}*sizeof(data_out_type));
  GetMem(data_in,Data_in_BufferLength{(2*ScanParams.ScanPoints+2)}*sizeof(word));
end;
*)
procedure  TScanCalibrateDemo.SetPathSpeed;
var
DemoPointDelay:integer;
begin
(*  with ScanParams do
 if (ScanPath=OneX)  or (ScanPath=Multi) then  DemoPointDelay:=round(1000*ScanParams.X/(ScanParams.ScanRate*ScanParams.Nx))  // mc
                                        else     DemoPointDelay:=round(1000*ScanParams.Y/(ScanParams.ScanRate*ScanParams.NY));  // mc
   case ScanParams.ScanMethod of
   TopoGraphy,
   OneLineScan,
   Litho,LithoCurrent:
        API.PATHSPD:=2*DemoPointDelay;  // for Back path
  BackPass,Phase,
  WorkF,
  UAM,Current,
  FastScan,
  FastScanPhase:
        API.PATHSPD:=DemoPointDelay;  // Two pictures are mixed
  end;
  *)
end;

procedure TScanCalibrateDemo.CutDemoLine(X0,Y0,Len:single; ExpData:TData; var LenN:integer; var ExpLine:ArraySpline);
var i:integer;
    StartPointX,StartPointY:integer;
begin
 StartPointX:=round(X0/ExpData.XStep);
 StartPointY:=round(Y0/ExpData.YStep);
 if ScanParams.ScanMethod in ScanmethodSetLitho{=litho} then
  begin
    StartPointX:=0;
    StartPointY:=0;
  end;
   case ScanParams.ScanPath of
      OneX:
          begin
          if  ScanParams.ScanMethod in ScanmethodSetLitho {=Litho} then  LenN:= ExpData.Nx
          else
             begin
             LenN:= round(ScanParams.X/ExpData.XStep+0.5);
             if LenN*ExpData.XStep>ScanParams.XMax then dec(LenN);
             end ;
           for i:=0 to LenN-1 do
          ExpLine[i+1]:=ExpData.Data[i+StartPointX, StartPointY];
          end;
      OneY:
          begin
          if  ScanParams.ScanMethod in ScanmethodSetLitho{=Litho} then  LenN:= ExpData.Ny
          else
          begin
           LenN:= round(ScanParams.Y/ExpData.YStep+0.5);
           if LenN*ExpData.YStep>ScanParams.YMax then dec(LenN);
          end;
          for i:=0 to LenN-1 do
          ExpLine[i+1]:=ExpData.Data[StartPointX, i+StartPointY];
          end;
   end;
end;

procedure TScanCalibrateDemo.SplnInterp1D(ExpLine:ArraySpline; LenN:integer; Step:single; var DemoLine:TLine);
var i:integer;
    XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef:ArraySpline;
begin
//DemoLine:=nil;
SetLength(DemoLine,ScanParams.ScanPoints);
for i:=0 to LenN-1 do
      XPoints[i+1]:=i*Step;

SPLINE(LenN, XPoints,ExpLine, BSplnKoef,CSplnKoef,DSplnKoef);
for i:=0 to ScanParams.ScanPoints-1 do
  DemoLine[i]:=round(SEVAL(LenN, i*ScanParams.StepXY, XPoints,ExpLine, BSplnKoef,CSplnKoef,DSplnKoef));
end;

function  TScanCalibrateDemo.LoadDemoData(FileName:string):integer;
var DemoExperiment:TExperiment;
i,j,c1,c2, cnt:integer;
NPoints:integer;
TopVal, BottVal, CurrentVal:datatype;
TopoNormKoef:single;
z0:apitype;
TmpMaxPoints:integer;
SourceLine:ArraySpline;
LineLength:single;
 DemoLine,  DemoLineAdd:TLine;
begin
 Result:=0;
// FileName:=DemoDataDirectory+DemoSample+FileName;
   if not FileExists(FileName) then
       begin
            NoFormUnitLoc.siLang1.ShowMessage(FileName+strud1{' File not exist'});
           result:=1;
           exit;
        end;
 DemoExperiment:=TExperiment.Create;
try
 DemoExperiment.imFileName:=FileName;
 TmpMaxPoints:=LinePointsMax;
 LinePointsMax:=ScanSizeMax;
 DemoExperiment.ReadSurface(TopoGraphy);
 TopVal:=DemoExperiment.AquiTopo.DataMax;
 BottVal:=DemoExperiment.AquiTopo.DataMin;
 TopoNormKoef:=ApproachParams.ZGateMax*MaxApiTYpe ;
 LineLength:=ScanParams.ScanPoints*ScanParams.StepXY;
 CutDemoLine(ScanParams.XBegin,ScanParams.YBegin,LineLength, DemoExperiment.AquiTopo, NPoints, SourceLine);
 SplnInterp1D(SourceLine, NPoints, DemoExperiment.AquiTopo.XStep,  DemoLine);
 cnt:=0;
 z0:= NanoEdu.ZValue;
 case ScanParams.ScanMethod of
   TopoGraphy,
   OneLineScan,
   Litho,LithoCurrent :
   begin
      for j:=0 to ScanParams.ScanPoints-1 do
         begin
             if FlgApproachOK then  PWordArray(DataBuf)[cnt]:=-TopVal+DemoLine[j]-z0
                              else  PWordArray(DataBuf)[cnt]:=-z0;
           inc(cnt);
         end;
         for j:=ScanParams.ScanPoints-1 downto 0 do
         begin
            if FlgApproachOK then  PWordArray(DataBuf)[cnt]:=-TopVal+DemoLine[j]-z0
                             else  PWordArray(DataBuf)[cnt]:=-z0;
           inc(cnt);
         end;
   end;
  BackPass,Phase,
  WorkF,
  UAM,Current,
  FastScan,
  FastScanPhase:
    begin
     DemoExperiment.ReadSurface(ScanParams.ScanMethod);
     CutDemoLine(ScanParams.XBegin,ScanParams.YBegin,LineLength, DemoExperiment.AquiAdd, NPoints, SourceLine);
     SplnInterp1D(SourceLine, NPoints, DemoExperiment.AquiTopo.XStep,  DemoLineAdd);
      cnt:=0;
        for j:=0 to ScanParams.ScanPoints-1 do
         begin
          if FlgApproachOK then  PWordArray(DataBuf)[cnt]:=-TopVal+DemoLine[j]-z0//PWordArray(DataBuf)[cnt]:=-TopVal+DemoExperiment.AquiTopo.Data[c1,c2]-z0
                           else  PWordArray(DataBuf)[cnt]:=-z0;
          inc(cnt);
          if FlgApproachOK then  PWordArray(DataBuf)[cnt]:=-TopVal+DemoLineAdd[j]//PWordArray(DataBuf)[cnt]:=DemoExperiment.AquiAdd.Data[c1,c2]
                           else  PWordArray(DataBuf)[cnt]:=random(200);
         inc(cnt);
         end;
        for j:= ScanParams.ScanPoints-1 downto 0 do
         begin
          if FlgApproachOK then  PWordArray(DataBuf)[cnt]:=-TopVal+DemoLine[j]-z0//PWordArray(DataBuf)[cnt]:=-TopVal+DemoExperiment.AquiTopo.Data[c1,c2]-z0
                           else  PWordArray(DataBuf)[cnt]:=-z0;
          inc(cnt);
          if FlgApproachOK then  PWordArray(DataBuf)[cnt]:=-TopVal+DemoLineAdd[j]//PWordArray(DataBuf)[cnt]:=DemoExperiment.AquiAdd.Data[c1,c2]
                           else  PWordArray(DataBuf)[cnt]:=random(200);
         inc(cnt);
         end;
    end;
  end;
  LinePointsMax:= TmpMaxPoints;
  Finalize(DemoLine);
  Finalize(DemoLineAdd);
finally
  FreeAndNil(DemoExperiment);
end;
end;
procedure TScanCalibrateDemo.StartDraw;
var FileName:string;
begin
 FileName:=DemoDataDirectory+DemoSample+'\'+FileName;
 case ScanParams.ScanMethod of
   TopoGraphy:
     if STMFlg then  FileName:=DemoDataDirectory+DemoSample+'\'+DemoTopoSTMFile
               else  FileName:=DemoDataDirectory+DemoSample+'\'+DemoTopoSFMFile;
   Phase:
                     FileName:=DemoDataDirectory+DemoSample+'\'+DemoPhaseFile;
   Litho,
   Lithocurrent:     FileName:=DemoDataDirectory+DemoSampleLitho+'\'+DemoLithoSFMFile;
               end;
   LoadDemoData(FileName);
  inherited StartDraw;
end;

procedure TScannerTrainnigDemo.StartDraw;
begin
  LoadDemoData;
  inherited StartDraw;
end;

procedure TScannerTrainnigDemo.SetPathSpeed;
var
DemoPointDelay:integer;

begin
 DemoPointDelay:=round(1000*ScanParams.X/(ScanParams.ScanRate*ScanParams.Nx));  // mc
 API.PATHSPD:=2*DemoPointDelay;

end;
function TScannerTrainnigDemo.InitRegimeVars:integer;
begin
 Inherited  InitRegimeVars;
  LoadDemoData;
end;
function  TScannerTrainnigDemo.LoadDemoData:integer;
var j:integer;
begin
    (*   for j:=0 to ScanParams.CycleCount-1 do
         begin
           //   PWordArray(DataBuf)[j]:=1;
           PIntegerArray(DataBufIn)[j]:=1;
         end;    *)
end;
function   TScannerTrainnigDemo.InitBuffers:integer;
 var j:integer;
 begin
  inherited InitBuffers;
  FreeMem(StopBuf);
  FreeMem(DoneBuf);
  GetMem(StopBuf,3*sizeof(Integer));
  GetMem(DoneBuf,3*sizeof(Integer));
  GetMem(DataBufIn,ScanParams.CycleCount*sizeof(data_out_type));
  setLength(ArDemoChannelParams,AlgParams.NChannels);
  ArDemoChannelParams[0].PBuffer:=StopBuf;
  ArDemoChannelParams[0].SizeElement:=1;
  ArDemoChannelParams[0].NElements:=1;
  ArDemoChannelParams[1].SizeElement:=1;
  ArDemoChannelParams[1].PBuffer:=DoneBuf;
  ArDemoChannelParams[1].NElements:=1;
  ArDemoChannelParams[2].NElements:=ScanParams.CycleCount;
  ArDemoChannelParams[2].PBuffer:=DataBufIn;
  ArDemoChannelParams[2].SizeElement:=1;
  PIntegerArray(DoneBuf)[0]:=done;
  PIntegerArray(DoneBuf)[1]:=done;
  PIntegerArray(DoneBuf)[2]:=done;

  for j:=0 to ScanParams.CycleCount-1 do
         begin
           PIntegerArray(DataBufIn)[j]:=1;
         end;
 end;

function  TScannerTrainnigDemo.FreeBuffers:integer;
 begin
    inherited FreeBuffers;
    Finalize(ArDemoChannelParams) ;
    FreeMem(DataBufIn);
 
 end;

function  TTopographyDemo.InitRegimeVars:integer;
 var I,J:INTEGER;
  FileName:string;
begin
 Inherited  InitRegimeVars;
  (*
  if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit)
     then  AlgorithmJava:=WideString(LinearScrpt)
     else
    *)
  FileName:=DemoDataDirectory+DemoSample+'\'+FileName;
 case ScanParams.ScanMethod of
   TopoGraphy:
     if STMFlg then  FileName:=DemoDataDirectory+DemoSample+'\'+DemoTopoSTMFile
               else  FileName:=DemoDataDirectory+DemoSample+'\'+DemoTopoSFMFile;
   Phase:
                     FileName:=DemoDataDirectory+DemoSample+'\'+DemoPhaseFile;
   UAM:              FileName:=DemoDataDirectory+DemoSample+'\'+DemoForceFile;
               end;
  LoadDemoData(FileName);
  if ScanParams.flgFastSimulator then GETCOUNT_DELAY:=10;
end;
procedure  TTopographyDemo.SetPathSpeed;
var
 DemoPointDelay:integer;
begin
  with ScanParams do
 if (ScanPath=OneX)  or (ScanPath=Multi) then
    //  DemoPointDelay:=round(1000*ScanParams.X/(ScanParams.ScanRate*ScanParams.Nx))  // mc
   // else     DemoPointDelay:=round(1000*ScanParams.Y/(ScanParams.ScanRate*ScanParams.NY));  // mc
  begin
   if ScanParams.flgFastSimulator then DemoPointDelay:=round(100*ScanParams.X/ScanParams.ScanRate)
     else DemoPointDelay:=round(1000*ScanParams.X/ScanParams.ScanRate)
  end
  else
  begin
   if ScanParams.flgFastSimulator then  DemoPointDelay:=round(100*ScanParams.Y/ScanParams.ScanRate)
     else DemoPointDelay:=round(1000*ScanParams.Y/ScanParams.ScanRate)
  end;
  case ScanParams.ScanMethod of
   TopoGraphy,
   OneLineScan,
   Litho,LithoCurrent :
        API.PATHSPD:=round(1.5*DemoPointDelay);  // for direct and Back path
  BackPass,Phase,
  WorkF,
  UAM,Current,
  FastScan,
  FastScanPhase:
        API.PATHSPD:=DemoPointDelay;  // Two pictures are mixed
  end;
//  if DemoPointDelay=1 then AlgParams.NGetCountEvent:=2*AlgParams.NGetCountEvent;
end;

 function    TTopographyDemo.InitBuffers:integer;
 begin
  inherited InitBuffers;
  FreeMem(StopBuf);
  FreeMem(DoneBuf);
  GetMem(StopBuf,3*sizeof(Integer));
  GetMem(DoneBuf,3*sizeof(Integer));
  GetMem(DataBufIn,2*ScanParams.ScanPoints*ScanParams.ScanLines*ScanParams.sz*sizeof(data_out_type));
  setLength(ArDemoChannelParams,AlgParams.NChannels);
  ArDemoChannelParams[0].PBuffer:=StopBuf;
  ArDemoChannelParams[0].SizeElement:=1;
  ArDemoChannelParams[0].NElements:=3;
  ArDemoChannelParams[1].SizeElement:=1;
  ArDemoChannelParams[1].PBuffer:=DoneBuf;
  ArDemoChannelParams[1].NElements:=3;
  ArDemoChannelParams[2].NElements:=AlgParams.NElements;
  ArDemoChannelParams[2].PBuffer:=DataBufIn;
  ArDemoChannelParams[2].SizeElement:=AlgParams.SizeElements;
  PIntegerArray(DoneBuf)[0]:=done;
  PIntegerArray(DoneBuf)[1]:=done;
  PIntegerArray(DoneBuf)[2]:=done;
 end;

 function   TTopographyDemo.FreeBuffers:integer;
 begin
   inherited FreeBuffers;
   FreeMem(DataBufIn);
   Finalize(ArDemoChannelParams);
 end;

procedure TTopographyDemo.StartDraw;
begin
 inherited StartDraw;
end;
(*
procedure TTopographyDemo.PhaseZeroAdjust;
begin
     ProgressCal:=TProgress.Create(Application);
     ProgressCal.Show;
     ProgressCal.Caption:='Adjust Phase  Zero Point';
     ProgressCal.ProgressBar.Position := ProgressCal.ProgressBar.Max div 2;
     sleep(1000);
     FreeAndNil(ProgressCal);
end;
*)

procedure TTopographyDemo.CutDemoArea(X0,Y0,LenX,LenY:single; ExpData:TData; var Area:TData);
var i,j:integer;
    AreaNx,AreaNy:integer;
    StartPointX,StartPointY:integer;
begin
AreaNx:=round(LenX/ExpData.XStep+0.5);
AreaNy:=round(LenY/ExpData.YStep+0.5);
if AreaNx*ExpData.XStep>ScanParams.XMax then dec(AreaNx);
if AreaNy*ExpData.YStep>ScanParams.YMax then dec(AreaNy);

StartPointX:=round(X0/ExpData.XStep);
StartPointY:=round(Y0/ExpData.YStep);
 if ScanParams.ScanMethod in ScanmethodSetLitho{ Litho} then
  begin
    StartPointX:=0;
    StartPointY:=0;
  end;

//Area:=TData.Create;

SetLength(Area.Data,AreaNx,AreaNy);
//Area.Nx:=
with Area do
 begin
   Nx:=AreaNx;
   Ny:=AreaNy;
   XStep:=ExpData.XStep;
   YStep:=ExpData.YStep;
   ZStep:=ExpData.ZStep;
 end;
for i:=0 to AreaNx-1 do
  for j:=0 to AreaNy-1 do
      Area.Data[i,j]:=ExpData.Data[StartPointX+i,StartPointY+j];
end;

procedure TTopographyDemo.SplnInterp2D(Area:TData; var DemoArea:TData);
var XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef:ArraySpline;
    TmpData:Tdata;
    i,j:integer;
begin
TmpData:=TData.Create;
try
 SetLength(TmpData.Data, ScanParams.NX,Area.Ny);
 TmpData.Nx:=ScanParams.NX;
 TmpData.Ny:=Area.Ny;
for i:=0 to Area.Ny-1 do
  begin
   for j:=0 to Area.Nx-1 do
     begin
       XPoints[j+1]:=j*Area.XStep;
       YPoints[j+1]:=Area.Data[j,i];
     end;
   Spline(Area.Nx,XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef);   // (NXSplines,ScannerCorrect.NonLinFieldX,XXsp,YXsp,Bx,CX,DX)
   for j:=0 to TmpData.Nx-1 do
    TmpData.Data[j,i]:=round(SEVAL(Area.Nx, j*ScanParams.StepXY, XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef));
  end;

(*DemoArea:=TData.Create;
SetLength(DemoArea.Data, ScanParams.NX,ScanParams.Ny);  *)
DemoArea.Nx:=ScanParams.NX;
DemoArea.Ny:=ScanParams.Ny;
for i:=0  to TmpData.Nx-1 do
  begin
     for j:=0 to TmpData.Ny-1 do
     begin
       XPoints[j+1]:=j*Area.YStep;
       YPoints[j+1]:=TmpData.Data[i,j];
     end;
     Spline(Area.Ny,XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef);
      for j:=0 to DemoArea.Ny-1 do
       DemoArea.Data[i,j]:=round(SEVAL(Area.Ny, j*ScanParams.StepXY, XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef));
  end;
finally
 FreeAndNil(TmpData);   { TODO : 250907 }
end;
end;

function  TTopographyDemo.LoadDemoData(FileName:string):integer;
var DemoExperiment:TExperiment;
i,j, cnt, c1, c2:integer;
NX,NY:integer;
TopVal, BottVal, CurrentVal:datatype;
TopoNormKoef:single;
z0:apitype;
TmpMaxPoints:integer;
Area, DemoArea, DemoAreaAdd,DemoReniS:TData;
begin
 Result:=0;
   if not FileExists(FileName) then
       begin
            NoFormUnitLoc.siLang1.ShowMessage(FileName+strud1{ File not exist'});
           result:=1;
           exit;
        end;
 DemoExperiment:=TExperiment.Create;
try
 DemoExperiment.imFileName:=FileName;
 TmpMaxPoints:=LinePointsMax;
 LinePointsMax:=ScanSizeMax;
 DemoExperiment.ReadSurface(TopoGraphy);
 fSourceScanRate:=DemoExperiment.FileHeadRcd.HScanRate;
 fSourceFBGain:=abs(DemoExperiment.FileHeadRcd.HFBGain);
 TopVal:=DemoExperiment.AquiTopo.DataMax;
 BottVal:=DemoExperiment.AquiTopo.DataMin;
 TopoNormKoef:=ApproachParams.ZGateMax*MaxApiTYpe ;
 Area:=TData.Create;
try
 CutDemoArea(ScanParams.XBegin,ScanParams.YBegin,ScanParams.X,ScanParams.Y, DemoExperiment.AquiTopo, Area);
 DemoArea:=TData.Create;
try
 SetLength(DemoArea.Data, ScanParams.NX,ScanParams.Ny);
 DemoArea.Nx:=ScanParams.NX;
 DemoArea.Ny:=ScanParams.Ny;
 SplnInterp2D(Area, DemoArea);
 NX:=ScanParams.NX;
 NY:=ScanParams.NY;
 cnt:=0;
 z0:= NanoEdu.ZValue;
 case ScanParams.ScanMethod of
   TopoGraphy,
   OneLineScan,
   Litho,LithoCurrent:
   begin
     for i:=0 to ScanParams.ScanLines-1 do
       for j:=0 to ScanParams.ScanPoints-1 do
         begin
         case ScanParams.ScanPath of
          OneX:
           begin
             c1:=j;
             c2:=i;
           end;
          OneY:
            begin
             c1:=i;
             c2:=j;
            end;
            end; {case}
            if FlgApproachOK then // PIntegerArray(DataBufIn)[cnt]:=(-TopVal+DemoArea.Data[c1,c2]-z0) shl 16
                                  PIntegerArray(DataBufIn)[cnt]:=(-BottVal+DemoArea.Data[c1,c2]+z0) shl 16
                             else // PIntegerArray(DataBufIn)[cnt]:=-z0 shl 16;
                                   PIntegerArray(DataBufIn)[cnt]:=z0 shl 16;
           inc(cnt);
         end;
  end;
  BackPass,Phase,
  WorkF,
  UAM,Current,
  FastScan,
  FastScanPhase:
   begin
     DemoExperiment.ReadSurface(ScanParams.ScanMethod);
     CutDemoArea(ScanParams.XBegin,ScanParams.YBegin,ScanParams.X,ScanParams.Y, DemoExperiment.AquiAdd, Area);
     DemoAreaAdd:=TData.Create;
    try
      SetLength(DemoAreaAdd.Data, ScanParams.NX,ScanParams.Ny);
      DemoAreaAdd.Nx:=ScanParams.NX;
      DemoAreaAdd.Ny:=ScanParams.Ny;
      SplnInterp2D(Area, DemoAreaAdd);
      cnt:=0;
     for i:=0 to ScanParams.ScanLines-1 do
       for j:=0 to ScanParams.ScanPoints-1 do
         begin
          case ScanParams.ScanPath of
          OneX:
           begin
             c1:=j;
             c2:=i;
           end;
          OneY:
            begin
             c1:=i;
             c2:=j;
            end;
            end; {case}
          if FlgApproachOK then  PIntegerArray(DataBufIn)[cnt]:=(-TopVal+DemoArea.Data[c1,c2]-z0) shl 16//PWordArray(DataBuf)[cnt]:=-TopVal+DemoExperiment.AquiTopo.Data[c1,c2]-z0
                           else  PIntegerArray(DataBufIn)[cnt]:=-z0 shl 16;
         inc(cnt);
          if FlgApproachOK then  PIntegerArray(DataBufIn)[cnt]:=DemoAreaAdd.Data[c1,c2] shl 16//PWordArray(DataBuf)[cnt]:=DemoExperiment.AquiAdd.Data[c1,c2]
                           else  PIntegerArray(DataBufIn)[cnt]:=random(200) shl 16;
         inc(cnt);
         end;
   //      FreeAndNil(Area);
     finally
         FreeAndNil(DemoAreaAdd);
     end;
   end;
  end;
  LinePointsMax:= TmpMaxPoints;
  finally
   FreeAndNil(DemoArea);
   end;
 finally
  FreeAndNil(Area);
  end;
finally
   FreeAndNil(DemoExperiment);//.Destroy;
 end;
end;

function  TLithoSFMDemo.LoadDemoData(FileName:string):integer;
var DemoExperiment:TExperiment;
i,j, cnt, c1, c2:integer;
NX,NY:integer;
TopVal, BottVal, CurrentVal:datatype;
TopoNormKoef:single;
z0:apitype;
TmpMaxPoints:integer;
begin
//TopoGraphy
 Result:=0;
   if not FileExists(FileName) then
       begin
            NoFormUnitLoc.siLang1.ShowMessage(FileName+strud1{' File not exist'});
           result:=1;
           exit;
        end;
 DemoExperiment:=TExperiment.Create;
try
 DemoExperiment.imFileName:=  FileName;
 TmpMaxPoints:=LinePointsMax;
 LinePointsMax:=ScanSizeMax;
 DemoExperiment.ReadSurface(TopoGraphy);
 fSourceScanRate:=DemoExperiment.FileHeadRcd.HScanRate;
 fSourceFBGain:=abs(DemoExperiment.FileHeadRcd.HFBGain);
 fSourceLithoAction:=DemoExperiment.FileHeadRcd.HLithoAction ;
 TopVal:=DemoExperiment.AquiTopo.DataMax;
 BottVal:=DemoExperiment.AquiTopo.DataMin;
 TopoNormKoef:=ApproachParams.ZGateMax*MaxApiTYpe ;
 cnt:=0;
 z0:= NanoEdu.ZValue;
   for i:=0 to ScanParams.ScanLines-1 do
      begin
       for j:=0 to ScanParams.ScanPoints-1 do
         begin
         case ScanParams.ScanPath of
          OneX:
           begin
             c1:=j;
             c2:=i;
           end;
          OneY:
            begin
             c1:=i;
             c2:=j;
            end;
            end; {case}
            if FlgApproachOK then
                   PIntegerArray(DataBufIn)[cnt]:=(-TopVal+DemoExperiment.AquiTopo.Data[c1,c2]-z0) shl 16
              else PIntegerArray(DataBufIn)[cnt]:=-z0 shl 16;
           inc(cnt);
         end;
        for j:=ScanParams.ScanPoints-1 downto 0 do
         begin
         case ScanParams.ScanPath of
          OneX:
           begin
             c1:=j;
             c2:=i;
           end;
          OneY:
            begin
             c1:=i;
             c2:=j;
            end;
               end; {case}
            if FlgApproachOK then  PIntegerArray(DataBufIn)[cnt]:=(-TopVal+DemoExperiment.AquiTopo.Data[c1,c2]-z0) shl 16
                             else  PIntegerArray(DataBufIn)[cnt]:=(-z0) shl 16;
           inc(cnt);
         end;
    end;
  LinePointsMax:= TmpMaxPoints;
finally
  FreeAndNil(DemoExperiment)
end;
end;
procedure TLithoSFMDemo.CutDemoArea(X0,Y0,LenX,LenY:single; ExpData:TData; var Area:TData);
var i,j:integer;
    AreaNx,AreaNy:integer;
    StartPointX,StartPointY:integer;
begin
AreaNx:=round(LenX/ExpData.XStep+0.5);
AreaNy:=round(LenY/ExpData.YStep+0.5);
if AreaNx*ExpData.XStep>ScanParams.XMax then dec(AreaNx);
if AreaNy*ExpData.YStep>ScanParams.YMax then dec(AreaNy);

StartPointX:=round(X0/ExpData.XStep);
StartPointY:=round(Y0/ExpData.YStep);
 if ScanParams.ScanMethod in ScanmethodSetLitho{ Litho} then
  begin
    StartPointX:=0;
    StartPointY:=0;
  end;

//Area:=TData.Create;

SetLength(Area.Data,AreaNx,AreaNy);
//Area.Nx:=
with Area do
 begin
   Nx:=AreaNx;
   Ny:=AreaNy;
   XStep:=ExpData.XStep;
   YStep:=ExpData.YStep;
   ZStep:=ExpData.ZStep;
 end;
for i:=0 to AreaNx-1 do
  for j:=0 to AreaNy-1 do
      Area.Data[i,j]:=ExpData.Data[StartPointX+i,StartPointY+j];
end;

procedure TLithoSFMDemo.SplnInterp2D(Area:TData; var DemoArea:TData);
var XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef:ArraySpline;
    TmpData:Tdata;
    i,j:integer;
begin
TmpData:=TData.Create;
try
 SetLength(TmpData.Data, ScanParams.NX,Area.Ny);
 TmpData.Nx:=ScanParams.NX;
 TmpData.Ny:=Area.Ny;
for i:=0 to Area.Ny-1 do
  begin
   for j:=0 to Area.Nx-1 do
     begin
       XPoints[j+1]:=j*Area.XStep;
       YPoints[j+1]:=Area.Data[j,i];
     end;
   Spline(Area.Nx,XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef);   // (NXSplines,ScannerCorrect.NonLinFieldX,XXsp,YXsp,Bx,CX,DX)
   for j:=0 to TmpData.Nx-1 do
    TmpData.Data[j,i]:=round(SEVAL(Area.Nx, j*ScanParams.StepXY, XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef));
  end;

(*DemoArea:=TData.Create;
SetLength(DemoArea.Data, ScanParams.NX,ScanParams.Ny);  *)
DemoArea.Nx:=ScanParams.NX;
DemoArea.Ny:=ScanParams.Ny;
for i:=0  to TmpData.Nx-1 do
  begin
     for j:=0 to TmpData.Ny-1 do
     begin
       XPoints[j+1]:=j*Area.YStep;
       YPoints[j+1]:=TmpData.Data[i,j];
     end;
     Spline(Area.Ny,XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef);
      for j:=0 to DemoArea.Ny-1 do
       DemoArea.Data[i,j]:=round(SEVAL(Area.Ny, j*ScanParams.StepXY, XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef));
  end;
finally
 FreeAndNil(TmpData);   { TODO : 250907 }
end;
end;

procedure  TLithoSFMDemo.SetPathSpeed;
var
DemoPointDelay:integer;
begin
  DemoPointDelay:=round(1000*ScanParams.X/(ScanParams.ScanRate));  // mc
  PATH_SPDDemo:=round(1.5*DemoPointDelay);
 end;
function  TLithoSFMDemo.InitRegimeVars:integer;
 var I,J:INTEGER;
  FileName:string;
begin
 Inherited  InitRegimeVars;
 filename:=DemoDataDirectory+ DemoSampleLitho+'\'+DemoLithoSFMFile;
 LoadDemoData(filename);
end;

procedure TLithoSFMDemo.StartDraw;
var filename:string;
begin
//if  Scanparams.ScanMethod=Litho        then filename:=DemoDataDirectory+ DemoSampleLitho+DemoLithoSFMFile;;
//if  Scanparams.ScanMethod=LithoCurrent then filename:=;

inherited StartDraw;
end;

 function   TLithoSFMDemo.InitBuffers:integer;
 begin
  inherited InitBuffers;
  FreeMem(DoneBuf);
  GetMem(DoneBuf,3*Sizeof(integer));
  GetMem(DataBufIn,2*ScanParams.ScanPoints*ScanParams.ScanLines*sizeof(data_out_type));
  setLength(ArDemoChannelParams,AlgParams.NChannels);
  ArDemoChannelParams[0].PBuffer:=StopBuf;
  ArDemoChannelParams[0].SizeElement:=1;
  ArDemoChannelParams[0].NElements:=3;
  ArDemoChannelParams[1].PBuffer:=DoneBuf;
  ArDemoChannelParams[1].SizeElement:=1;
  ArDemoChannelParams[1].NElements:=3;
  ArDemoChannelParams[2].NElements:=AlgParams.NElements;
  ArDemoChannelParams[2].PBuffer:=DataBufIn;
  ArDemoChannelParams[2].SizeElement:=AlgParams.SizeElements;

  PIntegerArray(DoneBuf)[0]:=done;
  PIntegerArray(DoneBuf)[1]:=done;
  PIntegerArray(DoneBuf)[2]:=done;
 end;
 function   TLithoSFMDemo.FreeBuffers:integer;
 begin
   inherited FreeBuffers;
   FreeMem(DataBufIn);
   Finalize(ArDemoChannelParams);
 end;

procedure TSpectroscopySFMDemo.SplnInterp1D(XPoints,ExpLine:ArraySpline; LenN:integer;  var DemoLine:TLine);
var i:integer;
    newStep:single;
    YPoints,BSplnKoef,CSplnKoef,DSplnKoef:ArraySpline;
    TMP:TLine;
begin
 DemoLine:=nil;
 TMP:=nil;
 SetLength(DemoLine,SpectrParams.NPoints);
 SetLength(TMP,SpectrParams.NPoints);
 SPLINE(LenN, XPoints,ExpLine, BSplnKoef,CSplnKoef,DSplnKoef);
 newStep:=((SPectrParams.EndP-SPectrParams.StartP)/DemoSpectrStep/SPectrParams.NPoints);  //discr
for i:=0 to SpectrParams.NPoints-1 do
  DemoLine[i]{TMP[i]}:=round(SEVAL(LenN, XPoints[1]+i*newStep, XPoints,ExpLine, BSplnKoef,CSplnKoef,DSplnKoef));
// DemoLine:=TMP;
 Finalize(Tmp);   //240113
end;
function  TSpectroscopySFMDemo.LoadDemoCurves(const FileName:string;  var Curves:TMas2):integer;
var
   Nx:integer;
  DemoExperimentCurve:TExperiment;
begin
   result:=0;
   if not FileExists(FileName) then
       begin
           ShowMessage(FileName+' File not exist');
           result:=1;
           exit;
        end;
 DemoExperimentCurve:=TExperiment.Create;
try
 DemoExperimentCurve.imFileName:=FileName;
 DemoExperimentCurve.Readsurface(spectr);
 Nx:=(DemoExperimentCurve.MainRcd.NxSpec );
 SetLength(Curves,DemoExperimentCurve.MainRcd.NyPoint,Nx);
 Curves:=DemoExperimentCurve.AquiSpectr.Data;
 DemoSpectrNCurves:=DemoExperimentCurve.MainRcd.NyPoint;
 DemoSpectrNPoints:=Nx;
 DemoSpectrStep:=0.001*DemoExperimentCurve.FileHeadRcd.HSensZ*DemoExperimentCurve.FileHeadRcd.HAMP_GainZ*
         DemoExperimentCurve.FileHeadRcd.HDiscrZmvolt; //mvo
 if not flgApproachOK then DemoSpectrNorm:=100
                      else DemoSpectrNorm:=DemoExperimentCurve.FileHeadRcd.HUAMMax;//}HStepXY;
 with SpectrParams do
  begin
   StartPointLimit:=round(Curves[0,1]*DemoSpectrStep);
   FinalPointLimit:=round(Curves[0,(DemoSpectrNPoints div 2)+1] *DemoSpectrStep);
  // SpectrParams.NPoints:=DemoSpectrNPoints div 4;
 //  SpectrParams.NCurves:=DemoSpectrNCurves;
  end;
 finally
  FreeAndNil(DemoExperimentCurve);
 end;
end;
 function  TSpectroscopySFMDemo.LoadDemoData(FileName:string):integer;
var
  i,k,s:integer;
  L:integer;
  Curve1Interp,Curve2Interp, UInterp1, UInterp2:TLine;
  demoCurveStep:single;
  demoCurveStepnm:single;
  UPoints:ArraySpline;
  newStep:single;
  newStepnm:single;
  TurnPoint:integer;
  BSplnKoef,CSplnKoef,DSplnKoef:ArraySpline;
  StartIndinSource, StoppedInd:integer;
  demoCurve:TLine;
  error:integer;
begin
 Randomize;
 FileName:=DemoDataDirectory+DemoSample+'\'+DemoSpectrSFMFile;
 Error:=LoadDemoCurves(FileName,DemoSpectrCurves);
 SetLength(demoCurve, DemoSpectrNPoints);

 if DemoSpectrCnt>DemoSpectrNCurves-1 then DemoSpectrCnt:=DemoSpectrNCurves-1;
 for i:=0 to DemoSpectrNPoints-1 do  demoCurve[i]:=DemoSpectrCurves[DemoSpectrCnt,i];
  if not FlgApproachOK then
   for i:=0 to (DemoSpectrNPoints div 2)-1 do   demoCurve[2*i]:=round(100*(1+0.2*(0.5-random)));
 L:=Length(demoCurve) div 4;
 demoCurveStepnm:=(SpectrParams.FinalPointLimit-SpectrParams.StartPointLimit)/L;
 SetLength(Curve1Interp,SpectrParams.NPoints);
 SetLength(Curve2Interp,SpectrParams.NPoints);
 demoCurveStep:=demoCurve[3]-demoCurve[1]; //discr
 for i:=1 to L do
 begin
  Xpoints1[i]:=SpectrParams.StartPointLimit+(i-1)*demoCurveStepnm;
  Curve1[i]:=demoCurve[2*(i-1)];
 end;
// SplnInterp1D(Xpoints1,Curve1, L,  Curve1Interp);
 SPLINE(L, XPoints1,Curve1, BSplnKoef,CSplnKoef,DSplnKoef);
 newStepnm:=((SPectrParams.EndP-SPectrParams.StartP)/SPectrParams.NPoints);  //nm
 for i:=0 to SpectrParams.NPoints-1 do
  Curve1Interp[i]:=round(SEVAL(L, SpectrParams.StartP+i*newStepnm, XPoints1,Curve1, BSplnKoef,CSplnKoef,DSplnKoef));
 for i:=1 to L do
 begin
   Xpoints1[i]:=SpectrParams.FinalPointLimit+(i-1)*demoCurveStepnm;    // ??????? -
   Curve1[i]:=demoCurve[2*(i-1+L)];
 end;
// SplnInterp1D(Xpoints1,Curve1, L,  Curve2Interp);
 SPLINE(L, XPoints1,Curve1, BSplnKoef,CSplnKoef,DSplnKoef);
 newStepnm:=((SPectrParams.EndP-SPectrParams.StartP)/SPectrParams.NPoints);  //nm
 for i:=0 to SpectrParams.NPoints-1 do
  Curve2Interp[i]:=round(SEVAL(L, SpectrParams.FinalPointLimit+(SpectrParams.FinalPointLimit-SpectrParams.EndP)+i*newStepnm, XPoints1,Curve1, BSplnKoef,CSplnKoef,DSplnKoef));
 newStep:=(SPectrParams.EndP-SPectrParams.StartP)/DemoSpectrStep/SPectrParams.NPoints;
 k:=0;

   for i:=0 to SpectrParams.NPoints-1 do
   begin
     PIntegerArray(DataBufIn)[k]  :=Curve1Interp[i] shl 16;
     PIntegerArray(DataBufIn)[k+1]:=round((SPectrParams.StartP+i*newStepnm)/DemoSpectrStep) shl 16;
     PIntegerArray(DataBufIn)[k+2]:=1;
     inc(k,3);
   end;
   s:=i;
   TurnPoint:=PIntegerArray(DataBufIn)[k-5] shr 16 ;//U[k-3];

 //  Data_out_BufferLength:=SpectrParams.NPoints*2*3;
   for i:=0 to SpectrParams.NPoints-1 do
   begin
     PIntegerArray(DataBufIn)[k]  := Curve2Interp[i] shl 16;
     PIntegerArray(DataBufIn)[k+1]:=round(TurnPoint-i*newStep) shl 16;
     PIntegerArray(DataBufIn)[k+2]:=-1;
     inc(k,3);
   end;
 Finalize(Curve1Interp);
 Finalize(Curve2Interp);
 Finalize(demoCurve);
end;
 function  TSpectroscopySFMDemo.InitBuffers:integer;
var i:Integer;
    ndone:integer;
 begin
   inherited InitBuffers;
   FreeMem(StopBuf);
   FreeMem(DoneBuf);
   FreeMem(DataBuf);
   Data_in_BufferLength:=(DemoSpectrNpoints div 4)*DemoSpectrNCurves*2+AlgParams.NGetCountEvent;//1;
//   Data_out_BufferLength:=(DemoSpectrNpoints div 4)*DemoSpectrNCurves*3*2;//*4; // (UAM,Z,dir ) ??????

   Data_out_BufferLength:=SpectrParams.NCurves*SpectrParams.NPoints*2*3;
   GetMem(StopBuf,3*sizeof(Integer)); //3 need for demo
   GetMem(DoneBuf,Data_in_BufferLength*sizeof(integer));     //need for demo
   GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
   GetMem(DataBufIn,Data_out_BufferLength*sizeof(data_out_type));
    for i:=0 to Data_in_BufferLength-1{2} do   PIntegerArray(DoneBuf)[i]:=0;
//   PIntegerArray(DoneBuf)[Data_in_BufferLength-1]:=done;
// for i:=Data_in_BufferLength-AlgParams.NGetCountEvent to
ndone:=(Data_in_BufferLength div AlgParams.NGetCountEvent) * AlgParams.NGetCountEvent;//-1;
//PIntegerArray(DoneBuf)[ndone]:=done;
  setLength(ArDemoChannelParams,AlgParams.NChannels);
  ArDemoChannelParams[0].PBuffer:=StopBuf;
  ArDemoChannelParams[0].SizeElement:=1;
  ArDemoChannelParams[0].NElements:=1;
  ArDemoChannelParams[1].PBuffer:=DoneBuf;
  ArDemoChannelParams[1].SizeElement:=1;
  ArDemoChannelParams[1].NElements:=SpectrParams.NCurves*SpectrParams.Npoints*2;
  ArDemoChannelParams[2].PBuffer:=DataBufIn;
  ArDemoChannelParams[2].SizeElement:=AlgParams.SizeElements;
  ArDemoChannelParams[2].NElements:=AlgParams.NElements;
 end;
function  TSpectroscopySFMDemo.InitRegimeVars:integer;
begin
 Inherited  InitRegimeVars;
  LoadDemoData(DemoDataDirectory+DemoSample+'\'+DemoSpectrSFMFile);
end;

 function   TSpectroscopySFMDemo.FreeBuffers:integer;
 begin
   inherited FreeBuffers;
   FreeMem(DataBufIn);
   Finalize(ArDemoChannelParams);
 end;

constructor TSpectroscopySFMDemo.Create;
begin
 inherited Create;
 PATH_SPDDemo:=0;
end;

function TSpectroscopySFMDemo.Launch:integer;
begin
 result:=0;
 InitRegimeVars;
if StartWork(SpectrNScrpt)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
 StartDraw;
end;


function  TSpectroscopySTMDemo.LoadDemoCurves(const FileName:string;  var Curves:TMas2):integer;
var
  Nx, NCurves:integer;
  DemoExperimentCurve:TExperiment;
  lIStepMin, lUStepMin:single;
begin
   result:=0;
   if not FileExists(FileName) then
       begin
           ShowMessage(FileName+' File not exist');
           result:=1;
           exit;
        end;
 DemoExperimentCurve:=TExperiment.Create;
try
 DemoExperimentCurve.imFileName:=FileName;
 DemoExperimentCurve.Readsurface(spectr);
 Nx:=(DemoExperimentCurve.MainRcd.NxSpec );
 NCurves:= DemoExperimentCurve.AquiSpectrPoint[2];
 SetLength(Curves,NCurves,Nx);
 Curves:=DemoExperimentCurve.AquiSpectr.Data;
 DemoSpectrNCurves:=NCurves;  // Количество кривых в одной точке, имеющееся в файле демо-данных
 //DemoExperimentCurve.MainRcd.NyPoint;  //
 DemoSpectrNPoints:=Nx ;  // длина массива с одной кривой (ток + напряжение)
 lIStepMin:=1/DemoExperimentCurve.FileHeadRcd.HnA_d;
 lUStepMin:=1/DemoExperimentCurve.FileHeadRcd.HBiasV_d*1000;

 with SpectrParams do
  begin
   StartPointLimit:=round(Curves[0,0]*lUStepMin);
   FinalPointLimit:=round(Curves[0,Nx-2] *lUStepMin);

  end;
//   SpectrParams.NPoints:=Nx div 2;//DemoSpectrNPoints ;//  ?? div 4;
 //  SpectrParams.NCurves:=NCurves;
 //  SpectrParams.NSpectrPoints:=DemoSpectrNCurves;     //number of points for spectr measurement
 finally
  FreeAndNil(DemoExperimentCurve);
 end;

  end;
//procedure TSpectroscopySTMDemo.SplnInterp1D(XPoints,ExpLine:ArraySpline; LenN:integer;  var DemoLine:TLine);

function  TSpectroscopySTMDemo.InitRegimeVars:integer;
begin
  Inherited  InitRegimeVars;
  LoadDemoData(DemoDataDirectory+DemoSample+'\'+DemoSpectrSTMIVFile);
end;

function  TSpectroscopySTMDemo.LoadDemoData(FileName:string):integer;
var error,i,j:integer;
    lcurves:TMas2;
begin
  Error:=LoadDemoCurves(FileName,DemoSpectrCurves);
 SpectrParams.NPoints:=DemoSpectrNPoints div 2;//DemoSpectrNPoints ;
  // SpectrParams.NCurves:=из интерфейса
  // SpectrParams.NSpectrPoints;  из интерфейса
  setLength(lcurves, SpectrParams.NCurves, DemoSpectrNPoints);
  try
  for I := 0 to SpectrParams.NCurves - 1 do
  for j := 0 to DemoSpectrNPoints - 1 do
         lcurves[i,j]:=  DemoSpectrCurves[i,j];

  if not FlgApproachOK then
   begin
   for I := 0 to SpectrParams.NCurves - 1 do
   for j := 0 to DemoSpectrnPoints - 1 do
      if odd(j) then
             lcurves[i,j]:=  0+round(5*random);
   end;

  for i:=0 to SpectrParams.NCurves-1 do
  for j := 0 to DemoSpectrNPoints - 1 do
   begin
   if odd(j) then   PIntegerArray(DataBufIn)[i*DemoSpectrnPoints+j]  :=(-lcurves[i,j]+400-random(800)) shl 16 // valI
   else  PIntegerArray(DataBufIn)[i*DemoSpectrnPoints+j]  :=lcurves[i,j] shl 16;   // valU

   end;
  finally
    Finalize(lcurves);
  end;

end;
function  TSpectroscopySTMDemo.InitBuffers:integer;
var i:Integer;
    ndone:integer;
 begin
   inherited InitBuffers;
   FreeMem(StopBuf);
   FreeMem(DoneBuf);
   FreeMem(DataBuf);
   Data_in_BufferLength:=(DemoSpectrNpoints div 4)*DemoSpectrNCurves*2+AlgParams.NGetCountEvent;//1;
  // Data_out_BufferLength:=(DemoSpectrNpoints div 4)*DemoSpectrNCurves*3*2;//*4; // (UAM,Z,dir ) ??????
 //  Data_out_BufferLength:=(DemoSpectrNpoints)*DemoSpectrNCurves;
   Data_out_BufferLength:=SpectrParams.NPoints*2*SpectrParams.NCurves;
   GetMem(StopBuf,3*sizeof(Integer)); //3 need for demo
   GetMem(DoneBuf,Data_in_BufferLength*sizeof(integer));     //need for demo
   GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
   GetMem(DataBufIn,Data_out_BufferLength*sizeof(data_out_type));
    for i:=0 to Data_in_BufferLength-1{2} do   PIntegerArray(DoneBuf)[i]:=0;
//   PIntegerArray(DoneBuf)[Data_in_BufferLength-1]:=done;
// for i:=Data_in_BufferLength-AlgParams.NGetCountEvent to
//ndone:=(Data_in_BufferLength div AlgParams.NGetCountEvent) * AlgParams.NGetCountEvent;//-1;
//PIntegerArray(DoneBuf)[ndone]:=done;
  setLength(ArDemoChannelParams,AlgParams.NChannels);
  ArDemoChannelParams[0].PBuffer:=StopBuf;
  ArDemoChannelParams[0].SizeElement:=1;
  ArDemoChannelParams[0].NElements:=1;
  ArDemoChannelParams[1].PBuffer:=DoneBuf;
  ArDemoChannelParams[1].SizeElement:=1;
  ArDemoChannelParams[1].NElements:=SpectrParams.NCurves*SpectrParams.Npoints*2;
  ArDemoChannelParams[2].PBuffer:=DataBufIn;
  ArDemoChannelParams[2].SizeElement:=AlgParams.SizeElements;
  ArDemoChannelParams[2].NElements:=AlgParams.NElements

end;
function  TSpectroscopySTMDemo.FreeBuffers:integer;
begin
     inherited FreeBuffers;
   FreeMem(DataBufIn);
   Finalize(ArDemoChannelParams)
end;
function    TSpectroscopySTMDemo.Launch:integer;
begin
    result:=0;
 InitRegimeVars;
if StartWork(SpectrScrptSTM)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
 StartDraw;
end;
constructor TSpectroscopySTMDemo.Create;
begin
   inherited Create;
 PATH_SPDDemo:=0;
end;

function  TFastTopoDemo.LoadDemoData(const FileName:string):integer;
var
 k,i,j, cnt, c1, c2:integer;
 NX,NY:integer;
 TopVal, BottVal, CurrentVal:datatype;
 TopoNormKoef:single;
 z0:apitype;
 TmpMaxPoints:integer;
 DemoExperiment:TExperiment;
 Area, DemoArea, DemoAreaAdd:TData;
 FileNameFull:string;
begin
//TopoGraphy
 Result:=0;
// FileNameFull:=DemoDataDirectory+DemoSample+'\'+FileName;
   if not FileExists(FileNameFull) then
       begin
            NoFormUnitLoc.siLang1.ShowMessage(FileName+strud1{' File not exist'});
           result:=1;
           exit;
        end;
 DemoExperiment:=TExperiment.Create;
try
 DemoExperiment.imFileName:=FileName;//Full;
 TmpMaxPoints:=LinePointsMax;
 LinePointsMax:=ScanSizeMax;
 DemoExperiment.ReadSurface(TopoGraphy);
 TopVal:=DemoExperiment.AquiTopo.DataMax;
 BottVal:=DemoExperiment.AquiTopo.DataMin;
 TopoNormKoef:=ApproachParams.ZGateMax*MaxApiTYpe ;
 //NX:=DemoExperiment.AquiTopo.Nx;
// NY:=DemoExperiment.AquiTopo.NY;
  Area:=TData.Create;
 CutDemoArea(ScanParams.XBegin,ScanParams.YBegin,ScanParams.X,ScanParams.Y, DemoExperiment.AquiTopo, Area);
 DemoArea:=TData.Create;
try
 SetLength(DemoArea.Data, ScanParams.NX,ScanParams.Ny);
 DemoArea.Nx:=ScanParams.NX;
 DemoArea.Ny:=ScanParams.Ny;
 SplnInterp2D(Area, DemoArea);
 NX:=ScanParams.NX;
 NY:=ScanParams.NY;
 cnt:=0;
     z0:= NanoEdu.ZValue;
     DemoExperiment.ReadSurface(ScanParams.ScanMethod);
 //   Area:=TData.Create;         { TODO : 250907 }
   try
     CutDemoArea(ScanParams.XBegin,ScanParams.YBegin,ScanParams.X,ScanParams.Y, DemoExperiment.AquiAdd, Area);
     DemoAreaAdd:=TData.Create;
   try
      SetLength(DemoAreaAdd.Data, ScanParams.NX,ScanParams.Ny);
      DemoAreaAdd.Nx:=ScanParams.NX;
      DemoAreaAdd.Ny:=ScanParams.Ny;
      SplnInterp2D(Area, DemoAreaAdd);
      cnt:=0;
    for k:=0 to ScanParams.NFrames-1 do
     for i:=0 to ScanParams.ScanLines-1 do
       for j:=0 to ScanParams.ScanPoints-1 do
         begin
          case ScanParams.ScanPath of
          OneX:
           begin
             c1:=j;
             c2:=i;
           end;
          OneY:
            begin
             c1:=i;
             c2:=j;
            end;
            end; {case}
         if FlgApproachOK  then  PWordArray(DataBuf)[cnt]:=DemoAreaAdd.Data[c1,c2]+random(1200)
                           else  PWordArray(DataBuf)[cnt]:=random(200);
         inc(cnt);
         end;
       
  LinePointsMax:= TmpMaxPoints;
   finally
    FreeAndNil(DemoAreaAdd);
   end;
  finally
   FreeAndNil(Area);
  end;
  finally
   FreeAndNil(DemoArea);
  end;
 finally
  FreeAndNil(DemoExperiment);
 end;
end;
procedure TFastTopoDemo.CutDemoArea(X0,Y0,LenX,LenY:single; ExpData:TData; var Area:TData);
var i,j:integer;
    AreaNx,AreaNy:integer;
    StartPointX,StartPointY:integer;
begin
AreaNx:=round(LenX/ExpData.XStep+0.5);
AreaNy:=round(LenY/ExpData.YStep+0.5);
if AreaNx*ExpData.XStep>ScanParams.XMax then dec(AreaNx);
if AreaNy*ExpData.YStep>ScanParams.YMax then dec(AreaNy);

StartPointX:=round(X0/ExpData.XStep);
StartPointY:=round(Y0/ExpData.YStep);
 if ScanParams.ScanMethod in ScanmethodSetLitho then
  begin
    StartPointX:=0;
    StartPointY:=0;
  end;
SetLength(Area.Data,AreaNx,AreaNy);
//Area.Nx:=
with Area do
 begin
   Nx:=AreaNx;
   Ny:=AreaNy;
   XStep:=ExpData.XStep;
   YStep:=ExpData.YStep;
   ZStep:=ExpData.ZStep;
 end;
for i:=0 to AreaNx-1 do
  for j:=0 to AreaNy-1 do
      Area.Data[i,j]:=ExpData.Data[StartPointX+i,StartPointY+j];
end;

procedure TFastTopoDemo.SplnInterp2D(Area:TData; var DemoArea:TData);
var XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef:ArraySpline;
  TmpData:Tdata;
  i,j:integer;
begin
TmpData:=Tdata.Create;
SetLength(TmpData.Data, ScanParams.NX,Area.Ny);
TmpData.Nx:=ScanParams.NX;
TmpData.Ny:=Area.Ny;
for i:=0 to Area.Ny-1 do
  begin
   for j:=0 to Area.Nx-1 do
     begin
       XPoints[j+1]:=j*Area.XStep;
       YPoints[j+1]:=Area.Data[j,i];
     end;
   Spline(Area.Nx,XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef);   // (NXSplines,ScannerCorrect.NonLinFieldX,XXsp,YXsp,Bx,CX,DX)
  for j:=0 to TmpData.Nx-1 do
   TmpData.Data[j,i]:=round(SEVAL(Area.Nx, j*ScanParams.StepXY, XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef));
end;
(*
DemoArea:=TData.Create;
SetLength(DemoArea.Data, ScanParams.NX,ScanParams.Ny);
DemoArea.Nx:=ScanParams.NX;
DemoArea.Ny:=ScanParams.Ny;
*)
for i:=0  to TmpData.Nx-1 do
begin
   for j:=0 to TmpData.Ny-1 do
     begin
       XPoints[j+1]:=j*Area.YStep;
       YPoints[j+1]:=TmpData.Data[i,j];
     end;
  Spline(Area.Ny,XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef);
  for j:=0 to DemoArea.Ny-1 do
   DemoArea.Data[i,j]:=round(SEVAL(Area.Ny, j*ScanParams.StepXY, XPoints,YPoints,BSplnKoef,CSplnKoef,DSplnKoef));
end;
 finalize(TmpData);
 end;

procedure TFastTopoDemo.StartDraw;
var fileName:string;
begin
  FileName:=DemoDataDirectory+DemoSample+'\'+DemoPhaseFile;
  LoadDemoData(FileName);
 inherited StartDraw;
end;
procedure  TFastTopoDemo.SetPathSpeed;
var
DemoPointDelay:integer;
begin
(*
    DemoPointDelay:=round(1000*ScanParams.Y/(ScanParams.ScanRate*ScanParams.NY));  // mc
     API.PATHSPD:=DemoPointDelay;  // Two pictures are mixed
  *)   
end;

end.
