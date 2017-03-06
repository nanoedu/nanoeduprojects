unit uNanoEduClasses;

interface

uses    classes,Forms,sysutils,globaltype,UNanoEduBaseClasses;
type

TSTMNanoEdu=class(TBaseNanoEdu )
private
  procedure SetSetPoint(val:single); override;
  function  GetSignalValue:apitype;  override;
public
  function TurnOn:boolean;                  override;
  function TurnOff:boolean;                 override;
  procedure ScannerProtract;                override;
  function  RisingToStartPoint(Nstep:smallint):integer; override;
// procedure ApproachRegime;            override;
  function  TurnOnFBMethod:boolean;         override;
  function  ScanningMethod:boolean;         override;
  function  ScanMoveToX0Y0Method(X0,Y0:single):boolean;   override;
  function  ScanCalibrateMethod:boolean;    override;
  function  ScannerTrainnigMethod:boolean;  override;
  function  FastTopoMethod:boolean;         override;
  function  SpectroscopyMethod:boolean;     override;
  function  StepTestMethod:boolean;         override;
  function  ApproachMethod:boolean;         override;
end;

TSFMNanoEdu=class(TBaseNanoEdu )
private
 function   median3 (a1,a2,a3:apitype):apitype;
// procedure  SetSD_GEN_M(val:apitype);        //pro
 procedure  SetGain_FM(val:apitype);        //pro
 // procedure SetFreq_Sel(fq:integer);
// procedure  SetSD_GENF(val:apitype);   //pro   250112
// procedure  SetSD_GENF_F(val:unapitype);   //pro
// procedure  SetModAmplitud(val:apitype);  //pro
protected
  function  GetMaxUAM:apitype;   virtual;
  function  GetSignalValue:apitype;   override;

public
//ScannerResonance: tScannerResonance;
 procedure  ScannerProtract;
 function   RisingToStartPoint(Nstep:smallint):integer; override;
 procedure  NormalizeUAM;             virtual;
 procedure  SetSetPoint(val:single);  override;
 function   TurnOn:boolean;           override;
 function   TurnOff:boolean;          override;
// function  ResonanceRegime: boolean; override;
 function   AdjustPhaseMethod:boolean;virtual;
// procedure  ApproachRegime;         override;
 function   LithoSFMMethod:boolean;   override;
 function   ScanningMethod:boolean;   override;
 function   TurnOnFBMethod:boolean;   override;
 function   ScanMoveToX0Y0Method(X0,Y0:single):boolean;   override;
 function   ScanCalibrateMethod:boolean;    override;
 function   ScannerTrainnigMethod:boolean;  override;
 function   FastTopoMethod:boolean;         override;
 function   SpectroscopyMethod:boolean;     override;
 function   StepTestMethod:boolean;         override;
 function   ResonanceMethod:boolean;        override;
 function   ApproachMethod:boolean;         override;
 property   MaxUAM:apitype      read  GetMaxUAM ;
// property ModAmplitud:apitype write SetModAmplitud;
// property SD_GENF_F:unapitype   write SetSD_GENF_F;
// property  SD_GENF:apitype    write SetSD_GENF;
 property   Gain_FM:apitype    write SetGain_FM;
// property  SD_GEN_M:apitype   write SetSD_GEN_M;
 Destructor Destroy;       override;
end;

implementation

uses  globalvar,globalfunction,CSPMVar,uNanoEduScanClasses,UNanoeduInterface, renishawvars;

destructor TSFMNanoEdu.Destroy();
begin
//  FreeAndNil(ScannerResonance);
  inherited ;
end;
 

function TSFMNanoEdu.TurnOn:boolean;
var CZTune:word;
begin
// 050213
(*    SetPIDParameters;
//    setlength(arPCChannel,10);
    API:=TPMAPI05.Create as IpmAPI05;
 *)   
//050213
     BramUflg:=0;       //use Bram U
     Bias:=0;       //081107
     Api.UserErr:=-1;
     SetPoint:=ApproachParams.LandingSetPoint;
     ScannerProtract;
  //   SD_GAM:= round(ApproachParams.Amp_M/1000*TransformUnit.BiasV_d);      06/03/17
          case flgUnit of
     Nano:  NanoEdu.SD_GAM:=round(ApproachParams.Amp_M/1000*TransformUnit.BiasV_d);
    Probeam,
    MicProbe,
      terra,
    Pipette:  NanoEdu.SD_GAM:=round(ApproachParams.Amp_M*10/1000*TransformUnit.BiasV_d);
                  end;
     if flgUnit=pipette then  Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
end;

function TSFMNanoEdu.TurnOff:boolean;
begin
 Api.SMZSTEP:=0;
// Finalize(arPCChannel);
end;
(*
function TSFMNanoEdu.ResonanceRegime: boolean;
begin
 ScannerResonance:=TScannerResonance.Create;
end;
*)

function  TSFMNanoEdu.AdjustPhaseMethod:boolean;
begin
 // NanoEdu.Method:= TScannerPhaseAdjust.Create;
end;

function  TSFMNanoEdu.LithoSFMMethod:boolean;
begin
 NanoEdu.Method:=TLithoSFM.Create;
end;

function TSFMNanoEdu.GetMaxUAM:apitype;
var a1,a2,a3:apitype;
begin
  a1:=(apitype(API.UAM));// GetCommonVar(ADC_UAM)));
  a2:=(apitype(API.UAM));//GetCommonVar(ADC_UAM)));
  a3:=(apitype(API.UAM));//GetCommonVar(ADC_UAM)));
  Result:=median3(a1,a2,a3);
end;

function  TSFMNanoEdu.GetSignalValue:apitype;
begin
 result:=apitype(API.UAM);
end;

 function TSFMNanoEdu.median3 (a1,a2,a3:apitype):apitype;
var Uc:apitype;
begin
     UC:=a1;
     if Uc>a2 then begin a1:=a2; a2:=Uc; Uc:=a2; end  else Uc:=a2;
     if Uc>a3 then begin a2:=a3; a3:=Uc; Uc:=a1; end;
     if Uc>a2 then begin a1:=a2; a2:=Uc;         end;
     Result:=a2;
end;


procedure TSFMNanoEdu.ScannerProtract;
begin
    flgRetract:=false;
    API.ITRRES:=MinDATATYPE; //see siocspm
    sleep(ApproachParams.IntegratorDelay);
end;

function  TSFMNanoEdu.RisingToStartPoint(Nstep:smallint):integer;
var state:apitype;
begin
if not flgNanoeduUnitCreate then  ScannerRetract;               //230112    change 010913
  state:=Api.SMZSTATUS;
  Api.SMZSTEP:=state-NStep;    //?????  -
  MotorCurrentStatus:=Api.SMZSTATUS;
  while MotorCurrentStatus <>(state-NStep) do
   begin
    Application.Processmessages;
    MotorCurrentStatus:=Api.SMZSTATUS;
   end;
   // sleep(1000);
  Api.SMZSTEP:=0;   // turn off motor  and set  SMZSTATUS=current//  see setcommonvar
 if not flgNanoeduUnitCreate then  ScannerProtract;      // 230112   change 010913
end;

procedure TSFMNanoEdu.NormalizeUAM;
var valDiscr:apitype;
begin
   //  MaxUAM:=API.ADC_UAM;
   ApproachParams.UAMMAX:=MaxUAM;
   valDiscr:=ApproachParams.UAMMax;
   API.DACIref:=(valDiscr);
   API.DACIref_AM:=round(ApproachParams.LandingSetPoint*100)//*dbltoint) ;//ApproachParams.LandingSetPoint;
end;

procedure   TSFMNanoEdu.SetGain_FM(val:apitype);  // Freq Modulation Channel
begin
// API.SDGain_FM:=val;// API.SDGen_M:=val;// setCommonVar(SD_GEN_M,val);
end;

procedure  TSFMNanoEdu.SetSetPoint(val:single);
begin
   Api.DACIRef:=apitype(ApproachParams.UAMMAX);
   API.DACIRef_AM:=round(val*100);
end;
(*
procedure  TSFMNanoEdu.SetSD_GEN_M(val:apitype); //Amplitude Modulation
begin
 API.SDGEN_M:=val;// SetCommonVar(SD_GAIN_AM,val);
end;
 *)

(*procedure TSFMNanoEdu.SetSD_GENF(val:apitype);  //Frequency  generator  Rough
begin
 API.Frequency:=val;//  SetCommonVar(SD_GENF_R,val);
end;
*)
(*
procedure TSFMNanoEdu.SetSD_GENF_F(val:unapitype); // Frequency generator Fine
begin
 API.SDGenf_F:=val;// SetCommonVar(SD_GENF_F,val);
end;
*)
(*procedure TSFMNanoEdu.SetModAmplitud(val:apitype);  // Amplitude Bias Generator
begin
 // SetCommonVar(SD_GAIN_FM,(255-val));
  API.SDGAM:=val;
end;
 *)
function TSTMNanoEdu.TurnOn:boolean;
var CZTune:apitype;
begin
(*
    SetPIDParameters;
//    setlength(arPCChannel,10);
    API:=TPMAPI05.Create as IpmAPI05;
*)
// SetDACZero; //280113
 BramUflg:=0;        // use BRam U
 Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
//use Bram U
 SD_GAM:=0;
 API.UserErr:=1;
 SD_GENF:=0;
// SetPoint:=ApiType(round(ApproachParams.SetPoint*TransformUnit.nA_d));
 SetPoint:=ApiType(round(ApproachParams.LandingSetPoint*TransformUnit.nA_d));  //16/12/14
 IMaxCut:=round(ApproachParams.ImaxCut*dbltoint);
 ScannerProtract;
end;

procedure  TSTMNanoEdu.SetSetPoint(val:single);
begin
  API.DACREFSTM:=round(val);
end;
function  TSTMNanoEdu.GetSignalValue:apitype;
begin
 result:=-apitype(API.IT); //160113
end;

function TSTMNanoEdu.TurnOff:boolean;
begin
// Finalize(arPCChannel);
end;

procedure TSTMNanoEdu.ScannerProtract;
begin
    flgRetract:=false;
    API.ITRRES:=16384;//$4000;     //see siocspm
    sleep(ApproachParams.IntegratorDelay);
end;

function  TSTMNanoEdu.RisingToStartPoint(Nstep:smallint):integer;
var state:apitype;
begin
if not flgNanoeduUnitCreate then  ScannerRetract;               //230112
  state:=Api.SMZSTATUS;
  Api.SMZSTEP:=state-NStep;    //?????  -
  while Api.SMZSTATUS<>(state-NStep) do application.processmessages;
    Api.SMZSTEP:=0;  // turn of motor    see setcommonvar
if not flgNanoeduUnitCreate then    ScannerProtract;      // 230112
end;
function  TSFMNanoEdu.ApproachMethod:boolean;
begin
 NanoEdu.Method:=TApproachSFM.Create;
end;



function  TSTMNanoEdu.ScanningMethod:boolean;
begin
 NanoEdu.Method:=TTopography.Create;
end;

function  TSTMNanoEdu.ScanMoveToX0Y0Method(X0,Y0:single):boolean;
begin
   if (flgRenishawUnit and  flgMoveToBeginbyRS)
                      then NanoEdu.Method:=TRenishawMoveToX0Y0.Create(X0,Y0)
                      else NanoEdu.Method:=TScanMoveToX0Y0.Create(X0,Y0);
end;
function  TSTMNanoEdu.TurnOnFBMethod:boolean;
begin
 NanoEdu.Method:=TMultiTurnONFB.Create;
end;
function  TSTMNanoEdu.ScanCalibrateMethod:boolean;
begin
 NanoEdu.Method:=TScanCalibrate.Create;
end;
function  TSTMNanoEdu.ScannerTrainnigMethod:boolean;
begin
 NanoEdu.Method:=TScannerTrainnig.Create;
end;
function  TSTMNanoEdu.FastTopoMethod:boolean;
begin
 NanoEdu.Method:=TFastTopo.Create;
end;
function  TSTMNanoEdu.SpectroscopyMethod:boolean;
begin
         case STMflg of
  true: begin
          if SpectrParams.flgIZ then NanoEdu.Method:=TSpectroscopySFM.Create
                                else NanoEdu.Method:=TSpectroscopySTM.Create;
        end;
 false: begin
           NanoEdu.Method:=TSpectroscopySFM.Create
(*         if flgUnit<>pipette then
            begin  NanoEdu.Method:=TSpectroscopySFM.Create end
            else
            begin
             if SpectrParams.flgIZ then NanoEdu.Method:=TSpectroscopySFM.Create     //101210
                                   else NanoEdu.Method:=TSpectroscopySTM.Create;    //101210
            end;
            *)
        end;
                 end;
end;
function  TSTMNanoEdu.StepTestMethod:boolean;
begin
 NanoEdu.Method:=TStepTest.Create;
end;
function  TSFMNanoEdu.ScanningMethod:boolean;
begin
 NanoEdu.Method:=TTopography.Create;
end;

function  TSFMNanoEdu.ScanMoveToX0Y0Method(X0,Y0:single):boolean;
begin
   if(flgRenishawUnit and  flgMoveToBeginbyRS)
   then   NanoEdu.Method:=TRenishawMoveToX0Y0.Create(X0,Y0)
   else   NanoEdu.Method:=TScanMoveToX0Y0.Create(X0,Y0);
end;
function  TSFMNanoEdu.TurnOnFBMethod:boolean;
begin
  NanoEdu.Method:=TMultiTurnONFB.Create;
end;
function  TSFMNanoEdu.ScanCalibrateMethod:boolean;
begin
 NanoEdu.Method:=TScanCalibrate.Create;
end;
function  TSFMNanoEdu.ScannerTrainnigMethod:boolean;
begin
 NanoEdu.Method:=TScannerTrainnig.Create;
end;
function  TSFMNanoEdu.FastTopoMethod:boolean;
begin
 NanoEdu.Method:=TFastTopo.Create;
end;
function  TSFMNanoEdu.SpectroscopyMethod:boolean;
begin
         case STMflg of
 true: begin
        if SpectrParams.flgIZ then NanoEdu.Method:=TSpectroscopySFM.Create
                              else NanoEdu.Method:=TSpectroscopySTM.Create;
       end;
false: begin
                case flgUnit of
         terra:   NanoEdu.Method:=TSpectroscopySFMTerra.Create;
             else NanoEdu.Method:=TSpectroscopySFM.Create;
           end;
       end;
(*
        case flgTerra of
       false: begin
               if flgUnit<>pipette then         //101210
               begin NanoEdu.Method:=TSpectroscopySFM.Create end
               else
               begin
            //   if SpectrParams.flgIZ then NanoEdu.Method:=TSpectroscopySFM.Create     //101210
            //                         else NanoEdu.Method:=TSpectroscopySTM.Create;    //101210
                NanoEdu.Method:=TSpectroscopySFM.Create;
               end;
              end;
       true:   NanoEdu.Method:=TSpectroscopySFMTerra.Create;
        end;
          end;
          *)
       end;  //case
end;
function  TSFMNanoEdu.StepTestMethod:boolean;
begin
 NanoEdu.Method:=TStepTest.Create;
end;
function  TSFMNanoEdu.ResonanceMethod:boolean;
begin
 NanoEdu.Method:=TResonance.Create;
end;
function  TSTMNanoEdu.ApproachMethod:boolean;
begin
 NanoEdu.Method:=TApproachSTM.Create;
end;
end.
