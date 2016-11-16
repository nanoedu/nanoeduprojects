//040305
unit uNanoeduUnit;

interface
uses    Windows,Classes,SysUtils,Dialogs,CSPMVar,GlobalVar,SioCSPM,globalDCl,CSPMHelp ;
type

TNanoedu = class(TObject)
private
 public
 constructor Create(var AOwner: TComponent);
 destructor Destroy();
  procedure TurnOn;
  procedure TurnOff;
  procedure SFMTurnOn;
  procedure STMTurnOn;
  procedure TurnOnSynchro;
  function  GetMaxUAM:smallint;
  procedure SetVT_Sign(val:integer);
  procedure SetGain_AM(val:word);
  procedure SetGain_FM(val:word);
  procedure SetFreq_sel(fq:integer);
  procedure SetDAC_VT(val:word);
  procedure SetDAC_REF(val:word);
  procedure SetSD_GENF_R(val:word);
  procedure SetSD_GENF_F(val:word);
  procedure SetSD_GEN_M(val:word);
  procedure SetFeedBack(val:word);
  function  Median3 (a1,a2,a3:smallint):smallint;
  procedure NormalizeUAM;
  procedure StartRising;

end;

TNanoEduResonance= class(TObject)
private
    imax:word;
    function  Q:integer;
    function  SetQRes:single;
public
   T,Fine,Rough:word;
   UMax:smallint;
   dx:integer;
   U:array of smallint ;
   constructor Create(var AOwner: TComponent);
   destructor Destroy();
   function   GetAmplitudes(RangeRF:Word):integer;
   property   QRes :single  read SetQRes;
end;

TNanoEduApproach= class(TNanoEdu)
private
     procedure StopMover;
public
   NSteps:smallint;
   Z:smallint;
   UAM:smallint;
   IT: smallint;
   constructor Create(var AOwner: TComponent);
   destructor Destroy();
   procedure FastAppoachTurnOn;
   procedure FastAppoachTurnOff;
   procedure SFMApproachTurnOn;
   procedure STMApproachTurnOn;
   procedure StopSteps;
   function  InitFastSteps:byte;
   function  InitSteps:byte;
   function  Step:byte;
   procedure SetSetPointSFM;
end;

Type
 TNanoEduScan= class(TObject)
private
public
   ScanData:TExperiment;
   Z:smallint;
   UAM:smallint;
   IT: smallint;
   constructor Create(var AOwner: TComponent);
   destructor Destroy();
end;

var NanoeduUnit:TNanoedu;
    NanoEduApproach: TNanoEduApproach;
    NanoEduResonance:TNanoEduResonance ;

implementation
constructor TNanoEduScan.Create(var AOwner: TComponent);
begin
   inherited Create;
end;

destructor TNanoEduScan.Destroy();
begin
 inherited Destroy;

end;
//TAproach
constructor TNanoEduApproach.Create(var AOwner: TComponent);
begin
   inherited Create(AOwner);
end;

destructor TNanoEduApproach.Destroy();
begin
 inherited Destroy;
 NanoEduApproach:=nil;
end;

procedure TNanoEduApproach.FasTAppoachTurnOn;
var val:word;
begin
 SetCommonVar(CT2,ApproachParams.IntegratorDelay);
 SetCommonVar(SD_ZERO,0);     //turn off step motor
end;
procedure TNanoEduApproach.FasTAppoachTurnOff;
var val:word;
begin
  StopMover;
end;

procedure TNanoEduApproach.StopMover;
begin
   setCommonVar(ITR_RES,0);     //ahead 0
   SetCommonVar(SD_ZERO,0);     //turn off step motor
end ;

procedure TNanoEduApproach.StopSteps;
var val:word;
begin
   SetCommonVar(StatusApproach,word(Stop));
   repeat
     val:=GetCommonVar(StatusApproach)
   until (val=EndScript);
   StopMover;
end;

function TNanoEduApproach.InitSteps:byte;
var    ZMaxContr,ZMinContr:SmallInt;
begin
    result:=0;
    SetCommonVar(SD_ZERO,1);     //turn on step motor
    if LoadScript(ApproachNScrpt)<>0 then
    begin
       StopMover;
      result:=1;
      exit;
    end;
      SetCommonVar(SMZ_SPEED,1);
      ZMaxContr:=round(ApproachParams.ZGateMax*MaXSmallINT);
      setCommonVar(CZMax,ZMaxContr);
      ZMinContr:=round(ApproachParams.ZGateMin*MaxSmallINT);
      setCommonVar(CZMin,ZMinContr);
             case STMFlg of
     False: begin
              setCommonVar(CLevel,smallint(round(UAMMax*ApproachParams.LevelUAM)));
            end;
      TRUE: begin
              setCommonVar(CLevel,smallint(round(ApproachParams.LevelIT*TransformUnit.nA_d)));
            end;
               end; //case
      setCommonVar(CNStep_Z,word(nsteps));
      setCommonVar(CT1,ApproachParams.ScannerDecay);
      setCommonVar(CT2,ApproachParams.IntegratorDelay);
end;

function TNanoEduApproach.InitFastSteps:byte;
var    ZMaxContr,ZMinContr:SmallInt;
begin
    result:=0;
    SetCommonVar(SD_ZERO,1);     //turn on step motor
    if LoadScript(ApproachNScrpt)<>0 then
    begin
      SetCommonVar(SD_ZERO,0);    //turn off step motor
      result:=1;
      exit;
    end;
      SetCommonVar(SMZ_SPEED,1);
      setCommonVar(CNStep_Z,word(nsteps));
      setCommonVar(CT1,ApproachParams.ScannerDecay);
      setCommonVar(CT2,ApproachParams.IntegratorDelay);
end;

function TNanoEduApproach.Step:byte;
var FlgStatusStep:byte;
begin
         result:=0;
         FlgStatusStep:=0;
         SetCommonVar(StatusStep,FlgStatusStep);
         SetCommonVar(StatusApproach,word(Start));
       repeat                     //waiting for the end one step
         begin
          FlgStatusStep:=getCommonVar(StatusStep);
         end;
        until (FlgStatusStep<>0);

             case FlgStatusStep of
      3: begin           //ok
          SetCommonVar(SD_ZERO,0);     //turn off step motor
         end;
      2: begin                //too close
           StopMover;
          end;                      //too close
      4: begin    //out boundary
            setCommonVar(SMZ_STEP,word(0));
            StopMover;
          end;
                     end;                //case
          Z:=abs(smallint(getCommonVar(CZ)));
                  case STMFlg of
     False: begin
              UAM:=Smallint(GetCommonVar(ADC_UAM));//_OUT));
              if (UAM>UAMMax ) then UAM:=UAMMax;
            end;
      TRUE: begin
              IT:=smallint(GetCommonVar(ADC_IT));
            end;
                end;
        result:=FlgStatusStep;
end;
procedure TNanoEduApproach.SetSetPointSFM;
begin
   if not STMFlg then
   begin
     ApproachParams.SetPoint:=0.9;
     SetDAC_REF(word(round(UAMMax*ApproachParams.SetPoint)));
   end;
end;

// TResonance
  constructor TNanoeduResonance.Create(var AOwner: TComponent);
begin
  inherited Create;
   Rough:=0;
   Fine:=1;
   iMax:=0;
   T:=1;
   dx:=256;                      // Number of Frequency points
   SetLength(U,dx);
end;

destructor TNanoeduResonance.Destroy();
begin
 Finalize(U);
 inherited Destroy;
 NanoEduResonance:=nil;
end;

function TNanoeduResonance.SetQRes:single;
begin
 result:=(1+5.45*0.001*(iMax-$80))*1000/(5.45*Q);
end;

function TNanoeduResonance.Q:integer;
var
 i:integer;
 i1,i2:smallint;
 UM, UMin:smallInt;
begin
 UMin:=0;
 UM:=(UMax-UMin) div 2;
 i2:=iMax;
 i1:=iMax;
for i:=imax downto 0 do
  if U[i]< UM+UMin then
    begin
     i1:=i;
     break ;
  end;
for i:=imax to Dx-1 do
  if U[i]< UM+UMin then
    begin
     i2:=i;
     break ;
  end;
  Result:=1;
  if (i2-i1)<>0 then  Result:=(i2-i1);
end;


function  TNanoeduResonance.GetAmplitudes(RangeRF:Word):integer;
var
   P:Pchar;
   StatusLoad:DWord;
   szdata:integer;
   i,k,iend:word;
   Uc:smallint;
   a1,a2,a3:smallint;
begin
     SetCommonVar(SD_GENF_F,$80);
     SetCommonVar(TDelayR,T);
     SetCommonVar(FlgFine,RangeRF); // 0=Rough , 1=Fine;
     Result:=0;
  if LoadScript(ResonanceNScrpt)<>0 then begin Result:=1; exit; end;
   try
        szData:=dx*sizeof(word)*3;
        GetMem(data_out,szData);
        GetMem(data_path,2*sizeof(word));
      	PWordArray(data_path)[0]:= word($4000 or 1) ;
        PWordArray(data_path)[1]:= word(0);
        if BufRegister<>0 then
                begin
                  ShowMessage('Unable to register buffers! Reload Controller.');
                  raise EDivByZero.Create('');
                  exit;
                end;
 	ScanStart;
 	f.Pin:= @i;
	f.in_count:= 1;
	f.Ppath:= data_path;
	f.path_count:= 2;
	f.Pout:=data_out;
	f.out_count:= dx*3;
  if ScanInit(@f)<>0 then
                begin
                   ShowMessage('Error in ScanInit()');
                   raise EDivByZero.Create('');
                end;
  if ScanWork()<>0 then MessageBox(0,'Error during ScanWork() execution','Error',MB_OK);
        ScanDone;
        BufDeregister;
        GetCurProc(P_READY);
        Uc:=0;
        i:=0;
        k:=0;
        iend:=dx*3;
 while (i<iend)
 do
   begin
     a1:=smallint(PWordArray(Data_out)[i]);
     a2:=smallint(PWordArray(Data_out)[i+1]);
     a3:=smallint(PWordArray(Data_out)[i+2]);
     U[k]:=NanoEduUnit.median3(a1,a2,a3);
     inc(k);
     i:=i+3;
   end;
          Umax:=-32768;
         for i:=0 to (Dx-1)
          do
           begin
            if U[i]>Umax then
             begin
              Umax:=U[i];   iMax:=i;
             end;
           end;
        case  RangeRF of
   1: begin      //Fine
         ApproachParams.ResFreqF:=iMax;
         SetCommonVar(SD_GENF_F,ApproachParams.ResFreqF);
        end;
   0: begin   //Rough
          ApproachParams.ResFreqR:=iMax;
          SetCommonVar(SD_GENF_R,ApproachParams.ResFreqR);
      end;
             end
  finally

     f.Pin:=nil;

     f.Pout:=nil;
     f.PPath:=nil;
     FreeMem(data_out);
     FreeMem(data_path);
  end;

end;

//TNanoEDu
constructor TNanoedu.Create(var AOwner: TComponent);
begin
  inherited Create;
end;

destructor TNanoedu.Destroy();
begin

   inherited Destroy;
end;

function TNanoedu.median3 (a1,a2,a3:smallint):smallint;
var Uc:smallint;
begin
     UC:=a1;
     if Uc>a2 then begin a1:=a2; a2:=Uc; Uc:=a2; end  else Uc:=a2;
     if Uc>a3 then begin a2:=a3; a3:=Uc; Uc:=a1; end;
     if Uc>a2 then begin a1:=a2; a2:=Uc;         end;
     Result:=a2;
end;
procedure TNanoedu.TurnOn;
var  CZTune:word;
begin
       SFMTurnOn;
       SetCommonVar(DAC_X,0);
       SetCommonVar(DAC_Y,0);
       SetCommonVar(DAC_Z,0);
       SetCommonVar(DAC_UPD,2);
end;

procedure TNanoedu.TurnOff;
begin

end;


procedure TNanoedu.StartRising;
var     val:word;
 FlgStatusStep:byte;
begin
 val:=GetCommonVar(CMP_VAL);
 if val>=2  then
   begin
     SetCommonVar(SD_ZERO,1);     //turn on step motor
     FlgStopApproach:=False;
     if LoadScript(ApproachNScrpt)<>0 then
       begin
         FlgStopApproach:=true;
         SetCommonVar(SD_ZERO,0);     //turn off step motor
         exit;
       end;
        sleep(500);
        SetCommonVar(SMZ_SPEED,1);
        setCommonVar(CNStep_Z,word(300));
        setCommonVar(CT1,ApproachParams.ScannerDecay);
        setCommonVar(CT2,ApproachParams.IntegratorDelay);
        FlgStatusStep:=0;
        SetCommonVar(StatusStep,FlgStatusStep);
        SetCommonVar(StatusApproach,word(Start));
       repeat                     //waiting for the end one step
         begin
          FlgStatusStep:=getCommonVar(StatusStep);
         end;
       until (FlgStatusStep<>0);
         FlgStopApproach:=True;
         if FlgStatusStep=4 then  //out boundary
           begin
              setCommonVar(SMZ_STEP,word(0));
              SetCommonVar(SD_ZERO,0);
              Beep;
              MessageDlg('Attention!!! Step motor upper limit! Turn screw counter-clockwise by hand!!', mtInformation,[mbOk,mbHelp],IDH_Probe_is_too_High);
           end;
            SetCommonVar(StatusApproach,word(Stop));
          repeat
            val:=GetCommonVar(StatusApproach) ;
          until (val=EndScript);
        SetCommonVar(SD_ZERO,0);     //turn off step motor
     end
   else
      MessageDlg('Attention!!! Step motor upper limit! Turn screw counter-clockwise by hand!!', mtInformation,[mbOk,mbHelp],IDH_Probe_is_too_High);
end;

procedure   TNanoedu.SetGain_FM(val:word);
begin
  setCommonVar(SD_GEN_M,val);
end;

procedure   TNanoedu.SetGain_AM(val:word);
begin
  SetCommonVar(SD_GAIN_AM,val);
end;
procedure  TNanoedu.SetVT_Sign(val:integer);
begin
  SetCommonVar(VT_SIGN,val);
end;

procedure TNanoedu.SetDAC_REF(val:word);
begin
   SetCommonVar(DAC_REF,val);
   SetCommonVar(DAC_UPD,2);
end;

procedure TNanoedu.SetDAC_VT(val:word);
begin
   SetCommonVar(DAC_VT,val);
   SetCommonVar(DAC_UPD,1);
end;

procedure TNanoedu.SetFreq_sel(fq:integer);
begin
 with ApproachParams do
  begin
             case     fq of
   100: begin    SetCommonVar(Freq_Sel,0); end;
   50:  begin    SetCommonVar(Freq_Sel,1); end;
   10:  begin    SetCommonVar(Freq_Sel,2); end;
   2:   begin    SetCommonVar(Freq_Sel,3); end;
              end;
        F0:=fq;
  end;
end;
procedure TNanoedu.SetSD_GENF_R(val:word);
begin
   SetCommonVar(ITR_RES,1);
end;

procedure TNanoedu.SetSD_GENF_F(val:word);
begin
  SetCommonVar(ITR_RES,1);
end;

procedure TNanoedu.SetSD_GEN_M(val:word);
begin
  SetCommonVar(SD_GAIN_FM,(255-val));
end;

procedure TNanoedu.SetFeedBack(val:word);
begin
   SetCommonVar(ITR_RES,1);
   SetCommonVar(ITR_SEL,val);
   SetCommonVar(ITR_RES,0);
end;

procedure TNanoedu.SFMTurnOn;
var   CZTune:word;
begin
      SetCommonVar(MODE,0);       //  SFM_Mode;
      SetCommonVar(VT_SIGN,0);    //  bias voltage inversion
      SetCommonVar(SD_ENA,1);     //  turn off synchrodetector
      SetCommonVar(CMP_ENA,0);    //  turn off comparator
      SetCommonVar(FB_ENA,0);
      SetCommonVar(ITR_SEL,1);    //  tau integrator
      SetCommonVar(SD_ZERO,0);    //  turn off step motor
      SetCommonVar(FB_SEL,ApproachParams.FreqBandR); //choose  FB gain  x10
      CZTune:=0;
   if HardWareOpt.ZTune='Fine' then CZTune:=1; //Fine
      SetCommonVar(Z_TUNE,CZTune);
      SetCommonVar(ADC_MCH_ENA,32);
      UAMMax:=GetMaxUAM;
end;

procedure TNanoedu.STMTurnOn;
var CZTune:word;
begin
        SetCommonVar(MODE,1);      //   STM_Mode;
        SetCommonVar(SD_ENA,1);    //   turn off synchrodetector
        SetCommonVar(CMP_ENA,0);   //   turn off comparator
        SetCommonVar(CHMOD_SEL,1); //   turn on modulation chanel
        SetCommonVar(FB_ENA,0);
        SetCommonVar(ITR_SEL,1);      // tau integrator
        SetSD_GEN_M(0);
   //     SetCommonVar(SD_GAIN_FM,255);   //SD_GEN_M
        SetGAIN_AM(0);
   //     SetCommonVar(SD_GAIN_AM,0);
        SetCommonVar(SD_ZERO,0);      //turn off step motor
        SetCommonVar(FB_SEL,ApproachParams.FreqBandR);       //choose  FB gain  x10
        CZTune:=0;                                 // Rough
        if HardWareOpt.ZTune='Fine' then CZTune:=1; // Fine
        SetCommonVar(Z_TUNE,CZTune);
end;

procedure TNanoEduApproach.SFMApproachTurnOn;
var  valDiscr:smallint;
begin
//     UAMMax:=NanoeduUnit.GetMaxUAM;
       SetCommonVar(ADC_MCH_ENA,32);
       ApproachParams.SetPoint:=0.7;
       SetDAC_REF(word(round(UAMMax*ApproachParams.SetPoint)));
       StopMover;
       ApproachParams.FreqBandF:=3;
       NanoeduUnit.SetFeedBack( ApproachParams.FreqBandF);
end;

procedure TNanoEduApproach.STMApproachTurnOn;
var ITMax,valDiscr:smallint;
begin
       SetCommonVar(ADC_MCH_ENA,8);    //IT
       valDiscr:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
       if  valDiscr<0 then SetVT_Sign(1)// SetCommonVar(VT_SIGN,1)
                      else SetVT_Sign(0);// SetCommonVar(VT_SIGN,0);

       SetDAC_VT(valDiscr);
//       ApproachParams.SetPoint:=0.7;
       ITMax:=round(ApproachParams.SetPoint*TransformUnit.nA_d); //Average amplitude ;110102
       valDiscr:=-ITMax ;
       SetDac_REF(word(-ITMax));
       StopMover;
       ApproachParams.FreqBandF:=3;
       NanoeduUnit.SetFeedBack(ApproachParams.FreqBandF);
end;

procedure TNanoedu.TurnOnSynchro;
var  val:word;
begin
 SetCommonVar(SD_ENA,0);         // True;  Turn on Synchrodetector
 SetCommonVar(ADC_MCH_ENA,32);   // UAM
 SetCommonVar(Freq_Sel,2);       // F0=10;
 SetSD_GENF_R(ApproachParams.ResFreqR);
 SetSD_GENF_F(ApproachParams.ResFreqF);
 val:=5;
 SetCommonVar(CHMOD_SEL,val);    // Modulation Channel=PzD;
 SetCommonVar(SD_ZERO,0);             //   Turn off step motor
 SetSD_GEN_M(ApproachParams.Amp_M);
 SetGain_AM(ApproachParams.Gain_AM);
end;

function TNanoedu.GetMaxUAM:smallint;
var a1,a2,a3:smallint;
begin
  a1:=abs(smallint(GetCommonVar(ADC_UAM)));
  a2:=abs(smallint(GetCommonVar(ADC_UAM)));
  a3:=abs(smallint(GetCommonVar(ADC_UAM)));
  Result:=median3(a1,a2,a3);
end;

procedure TNanoedu.NormalizeUAM;
var valDiscr:word;
begin
    case STMFlg of
False:begin
        UAMMax:=GetMaxUAM;
        valDiscr:= round(UAMMax*ApproachParams.SetPoint);
       end;
TRUE: begin
      end;
        end;  //case
      SetDAC_REF(word(valDiscr));
end;

end.
