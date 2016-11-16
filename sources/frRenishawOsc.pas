unit frRenishawOsc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Series, TeEngine, TeeProcs, Chart, ExtCtrls, StdCtrls, Buttons, GlobalType,
  RenishawVars, siComp, siLngLnk, ComCtrls, ToolWin;

const ReniShawDrawing = 1;
const ReniShawscanning = 2;
const CurrentSignalWindow_discr = 1500;
  type
  TFormRenishawOsc = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ChartSens: TChart;
    Chartnmv: TChart;
    ChartCurrentSignal: TChart;
    SerCurrentRSSignal: TLineSeries;
    SerPulsesIntervalsnm: TLineSeries;
    SerRSSignalHist: TLineSeries;
    SercurrentRSPulses: TBarSeries;
    SerRSPulsesHist: TBarSeries;
    SerScannerMoving: TLineSeries;
    siLangLinked1: TsiLangLinked;
    sbHistory: TScrollBar;
    ControlPanel: TPanel;
    RadioGroupAxis: TRadioGroup;
    RadioGroupDir: TRadioGroup;
    Label1: TLabel;
    LabelOldSens: TLabel;
    LabelNewsens: TLabel;
    EdScanRate: TEdit;
    Labeldist: TLabel;
    UpDown: TUpDown;
    Panel5: TPanel;
    ToolBarScanWnd: TToolBar;
    StartBtn: TToolButton;
    StopBtn: TToolButton;
    procedure StopBtnClick(Sender: TObject);
    procedure EdScanRateChange(Sender: TObject);
    procedure EdScanRateKeyPress(Sender: TObject; var Key: Char);
    procedure UpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure sbHistoryScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StartBtnClick(Sender: TObject);
  private
    InitSensX, RealSensX:single;
    InitSensY, RealSensY:single;
    InitSensZ, RealSensZ:single;
    LinearArray: array of Apitype;
    LinearArrayDiff: array of Apitype;
    LinearArraynm:array of single;
    HistArray: array of double;
    TrainFastLinesBuf,
    LengthFastBuf: integer;
    NLinearArraynmPoints:integer;
    LinearArraySmooth: arraySpline;
    LinearArrayDiffSmooth: arraySpline;
    histArrayInd:integer;
    flgScanning, flgDrawing: Boolean;
    flgHistogram:boolean;
    HistArrayRes:integer;
    PulsesScr_Nmb:integer;
    FinishedAxisCnt:integer;
    Koefnm_d, Koefnm_volt, Koefdiscr_Volt:single;
    PointsArraynm:ArrayInt;
    TimeProgressVal_s:integer;
    TrainElementsCnt: integer;
    XBeginnmDir, YBeginnmDir:single;

    procedure RestoreStart();
    function  CountNewSens(InitialSens:single; var NewSens:single):integer;
    procedure ThreadDone(var AMessage: TMessage); message WM_ReniShawThreadDoneMsg;
    procedure BuildLinearArray(n_Points:integer);
    procedure BuildLinArraynm(TransformKoefnm_d:single);
    procedure DrawRSLinnm(SeriesLinDiffSave:TLineSeries);

  public
    { Public declarations }
  end;

var
  FormRenishawOsc: TFormRenishawOsc;
  flgStopPressed:Boolean;
  
implementation

{$R *.dfm}
uses RenishawOscThread,  UNanoEduInterface, uNanoEduScanClasses, SystemConfig, UNanoEduBaseClasses,
    SioCSPM, UScannerCorrect,GlobalVar, GlobalFunction,
    frExperimParams, frTools, frScannerCorrVisual, Math,
     CSPMVar,mMain, ScanWorkThread;

procedure TFormRenishawOsc.StartBtnClick(Sender: TObject);
   var i:integer;
   DelayBuf ,DelayBWBuf:integer;
   ScanRateBuf:single;
   Koefnm_d:single;
begin
if FlgStopReniShawOsc then
begin
 StartBtn.Enabled:=False;
 StopBtn.enabled:=false;
if not FlgStopScan then
begin
    siLangLinked1.MessageDLG(siLangLinked1.GetTextOrDefault('IDS_20' (* 'Stop scanning!' *) ) , mtwarning,[mbOK],0);
    StartBtn.Enabled:=true;   StopBtn.enabled:=true;
    exit
end;
       //Start  Scannning
with ReniShawOscParams do
 begin
    TransformkoefZ:=CSPMSignals[7].MaxDiscr/(HardWareOpt.UFBMaxOut*HardWareOpt.AMPGainZ);
    TransformkoefY:=(CSPMSignals[9].MaxDiscr-CSPMSignals[9].MinDiscr)/((CSPMSignals[9].MaxV-CSPMSignals[9].MinV)*HardWareOpt.AMPGainY);    // nm-> discr
    TransformkoefX:=(CSPMSignals[8].MaxDiscr-CSPMSignals[8].MinDiscr)/((CSPMSignals[8].MaxV-CSPMSignals[8].MinV)*HardWareOpt.AMPGainX);    // nm-> discr
  end;
 ControlPanel.Enabled:=false;
 FlgStopReniShawOsc:=false;
 histArrayInd:=0;
 sbHistory.Position:=0;
 sbHistory.Enabled:=False;
 LastDrawnPoint:=0;
 FinishedAxisCnt:=0;
 SerCurrentRSPulses.SeriesColor:=clGreen;
 TrainElementsCnt:=1;
 SerCurrentRSPulses.Clear;
 SerCurrentRSSignal.Clear;
 SerRSSignalHist.Clear;
 SerRSPulsesHist.Clear;
 SerScannerMoving.Clear;
 SerPulsesIntervalsnm.Clear;
 SerCurrentRSSignal.Active:=True;
 SerRSSignalHist.Active:=False;
 SerRSPulsesHist.Active:=False;
 SerCurrentRSPulses.Active:=True;
// LabelNewsens.Caption:=' ';
 ReniShawOscParams.RateFastAxis:=StrToInt(edScanRate.Text);
 if HardWareOpt.XYTune='Fine' then
    begin
      ReniShawOscParams.XBeginnm:=10;//XBeginnmDir:=10;
      ReniShawOscParams.YBeginnm:=10;//YBeginnmDir:=10;
    end;
 XBeginnmDir:=ReniShawOscParams.XBeginnm;
 YBeginnmDir:=ReniShawOscParams.YBeginnm;

    case RadiogroupDir.ItemIndex of
        0: ReniShawOscParams.MovingDirection:=0;  // forward
        1: ReniShawOscParams.MovingDirection:=1;  // back
    end;

 case RadiogroupAxis.ItemIndex of
    0: begin
           ReniShawOscParams.AxisName:=XFast;
           LabelOldsens.Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Old Sens X = ' *) )+ FloatToStrF(InitSensX, fffixed,5,2)+ siLangLinked1.GetTextOrDefault('IDS_1' (* ' nm/v' *) );
       end;
    1:  begin
          ReniShawOscParams.AxisName:=YFast;
          LabelOldsens.Caption:=siLangLinked1.GetTextOrDefault('IDS_2' (* 'Old Sens Y = ' *) )+ FloatToStrF(InitSensY, fffixed,5,2)+ siLangLinked1.GetTextOrDefault('IDS_1' (* ' nm/v' *) );
        end;
    2:  begin
          ReniShawOscParams.AxisName:=Z;
          LabelOldsens.Caption:=siLangLinked1.GetTextOrDefault('IDS_4' (* 'Old Sens Z = ' *) )+ FloatToStrF(InitSensZ, fffixed,5,2)+ siLangLinked1.GetTextOrDefault('IDS_1' (* ' nm/v' *) );
        end;
                 end;
 if ReniShawOscParams.MovingDirection =1 then
   begin
     if ReniShawOscParams.AxisName=xFast then
        begin
           with HardWareOpt do  Koefnm_d:=(CSPMSignals[8].MaxDiscr-CSPMSignals[8].MinDiscr)/((CSPMSignals[8].MaxV-CSPMSignals[8].MinV)*ScannerOptModX.SensitivX*AMPGainX);
           XBeginnmDir:=(CSPMSignals[8].MaxDiscr-500)/Koefnm_d-ReniShawOscParams.XBeginnm - Scanparams.xshift; // !!!!! XMax is not Determined!
        end
     else if ReniShawOscParams.AxisName=YFast then
         begin
           with HardWareOpt do  Koefnm_d:=(CSPMSignals[9].MaxDiscr-CSPMSignals[9].MinDiscr)/((CSPMSignals[9].MaxV-CSPMSignals[9].MinV)*ScannerOptModY.SensitivY*AMPGainY);
           YBeginnmDir:=(CSPMSignals[9].MaxDiscr-500)/Koefnm_d-ReniShawOscParams.YBeginnm - Scanparams.yshift;
         end;
   end;

      if (RenishawOscParams.AxisName = XFast)  then
        begin
                 ReniShawOscParams.NX:= (ReniShawOscParams.LengthFast_discr )div ReniShawOscParams.delt_discr;
                 ReniShawOscParams.NY:= 0;
                 ReniShawOscParams.microstep_Delay:=round(1000*1000*ScannerOptModX.SensitivX*ReniShawOscParams.delt_discr/
                                                        (ReniShawOscParams.RateFastAxis* ReniShawOscParams.TransformkoefX));
        end
        else if (RenishawOscParams.AxisName = YFast)  then
              begin
                 ReniShawOscParams.NX:= 0;
                 ReniShawOscParams.NY:= (ReniShawOscParams.LengthFast_discr) div ReniShawOscParams.delt_discr;
                 ReniShawOscParams.microstep_Delay:=round(1000*1000*ScannerOptModY.SensitivY*ReniShawOscParams.delt_discr/
                                                        (ReniShawOscParams.RateFastAxis* ReniShawOscParams.TransformkoefY));
              end

        else //  ONLY FOR ADC-TEST
              begin
                 ReniShawOscParams.NX:= 0;
                 ReniShawOscParams.NY:= (ReniShawOscParams.LengthZ_discr) div ReniShawOscParams.delt_discr;
                 ReniShawOscParams.microstep_Delay:=round(1000*1000*ScannerOptModX.SensitivZ*ReniShawOscParams.delt_discr/
                                                        (ReniShawOscParams.RateFastAxis* ReniShawOscParams.TransformkoefZ));
              end;
     NanoEdu.Method:=TScanMoveToX0Y0.Create(XBeginnmDir,YBeginnmDir);
     DelayBuf :=ScanParams.MicrostepDelay;
     DelayBWBuf :=ScanParams.MicrostepDelayBW;
     ScanRateBuf:=ScanParams.ScanRate;
     ScanParams.MicrostepDelay:=ReniShawOscParams.microstep_Delay;
     ScanParams.MicrostepDelayBW:=ReniShawOscParams.microstep_Delay;
     ScanParams.ScanRate:=ReniShawOscParams.RateFastAxis;
     NanoEdu.Method.Launch;
     FreeAndNil(NanoEdu.Method);
     ScanParams.MicrostepDelay:=DelayBuf;
     ScanParams.MicrostepDelayBW:=DelayBWBuf;
     ScanParams.ScanRate:= ScanRateBuf;
     NanoEdu.Method:=TRenishawOsc.Create; // Y or Z/// FOR TEST
     NanoEdu.Method.Launch;
     Application.ProcessMessages;
 //    StartBtn.Enabled:=true;
     StopBtn.enabled:=true;
end;
 //    StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_18' (* 'S&top' *) );
  //   StartBtn.Font.Color:=clRed;
 //  StartBtn.Glyph.Assign(BitMapStop);
end;
procedure TFormRenishawOsc.StopBtnClick(Sender: TObject);
begin
if  not FlgStopReniShawOsc then
begin
       Stopbtn.Enabled:=false;
       StartBtn.Enabled:=false;
       NanoEdu.Method.StopWork;
       NanoEdu.Method.WaitStopWork;
end
end;

procedure TFormRenishawOsc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action:=caFree;
   SetLength(LinearArray,0);
   SetLength(LinearArrayDiff,0);
   SetLength(LinearArraynm,0);
   Main.ToolButtonRStest.visible:=true;
end;

procedure TFormRenishawOsc.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
  var DelayBuf, DelayBWBuf:integer ;
      ScanRateBuf: single;
begin
if  not FlgStopReniShawOsc then
 canclose:=false
else
begin
if not assigned(NanoEdu.Method) then
 begin
     NanoEdu.Method:=TScanMoveToX0Y0.Create(ScanParams.XBegin,ScanParams.YBegin);
     DelayBuf :=ScanParams.MicrostepDelay;
     DelayBWBuf :=ScanParams.MicrostepDelayBW;
     ScanRateBuf:=ScanParams.ScanRate;
     ScanParams.MicrostepDelay:=ReniShawOscParams.microstep_Delay;
     ScanParams.MicrostepDelayBW:=ReniShawOscParams.microstep_Delay;
     ScanParams.ScanRate:=ReniShawOscParams.RateFastAxis;
     NanoEdu.Method.Launch;
     FreeAndNil(NanoEdu.Method);
 end;
     ScanParams.MicrostepDelay:=DelayBuf;
     ScanParams.MicrostepDelayBW:=DelayBWBuf;
     ScanParams.ScanRate:= ScanRateBuf;
     canclose:=true;
 end;
end;

procedure TFormRenishawOsc.FormCreate(Sender: TObject);
begin
   FlgStopReniShawOsc:=true;
   siLangLinked1.ActiveLanguage:=Lang;
   ChartCurrentSignal.title.Text[0]:=siLangLinked1.GetTextOrDefault('IDS_3' (* 'Original Renishaw signal and detected fronts' *) );
   ChartCurrentSignal.BottomAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_5' (* 'discrete' *) );
   ChartCurrentSignal.LeftAxis.Title.Caption:='';
   ChartSens.BottomAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_17' (* 'wwwV' *) );
   ChartSens.title.text[0]:=siLangLinked1.GetTextOrDefault('IDS_12' (* 'Scanner Sensitivity as a function of Voltage' *) );
   ChartSens.LeftAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_13' (* 'Sensitivity, nm/v' *) );
   Chartnmv.title.text[0]:=siLangLinked1.GetTextOrDefault('IDS_14' (* 'Scanner moving' *) );
   Chartnmv.BottomAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_15' (* 'Scanner Voltage, V' *) );
   Chartnmv.LeftAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_16' (* 'Scanner Moving, nm' *) );
   ChartCurrentSignal.LeftAxis.SetMinMax(-0.5,1.5);
   ChartCurrentSignal.BottomAxis.SetMinMax(0,CurrentSignalWindow_discr);
   InitSensX:=ScannerOptModX.SensitivX;
   InitSensY:=ScannerOptModX.SensitivY;
   InitSensZ:=ScannerOptModX.SensitivZ;
   RealSensx:=InitSensX;
   RealSensY:=InitSensY;
   RealSensZ:=InitSensZ;
   LabelOldSens.Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Old Sens X = ' *) )+ FloatToStrF(InitSensX, fffixed,5,2)+ siLangLinked1.GetTextOrDefault('IDS_1' (* ' nm/v' *) );
   edScanRate.Text:=IntToStr(ReniShawOscParams.RateFastAxis);
   NanoEdu.FineXY:=(HardWareOpt.XYTune='Fine');
   //  Api.XYTune:=byte(HardWareOpt.XYTune='Fine');
   //   StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_19' (* '&Start' *) );
 //  StartBtn.Font.Color:=clBlack;
//   StartBtn.Glyph.Assign(BitMapStart);
end;

procedure TFormRenishawOsc.RestoreStart();
begin
 ControlPanel.Enabled:=true;
 StartBtn.Enabled:=True;
 StopBtn.Enabled:=false;
end;

procedure TFormRenishawOsc.sbHistoryScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
var pmin,pmax:single;
begin
  case ScrollCode of
 scLineUp,
 scLineDown,
 scEndScroll:
 begin
   pmax:=ScrollPos/10;
   pmin:=pmax-CurrentSignalWindow_discr;
   ChartCurrentSignal.BottomAxis.SetMinMax(pmin,pmax);
 end;
    end;
end;

procedure TFormReniShawOsc.ThreadDone(var AMessage: TMessage); // keep track of when and which thread is done executing
var error:integer;
    i:integer;
    ss, Fn:string;
    dir:string;
    LeftAxisMin,LeftAxisMax:single;
    TableRowNmb:integer;
    LinearArrayRes:integer;
    flgFinish:integer;
    NewSens:single;
    DelayBuf, DelayBWBuf:integer;
    ScanRateBuf:single;
    res:integer;
begin
  flgFinish:=0;
 if  (AMessage.WParam=ReniShawDrawing)  then
  begin
    if assigned(ReniShawThr) then
     begin
      ReniShawThreadActive:= false;
      ReniShawThr:=nil;
     end;
        StopBtn.enabled:=false;
      while assigned(nanoedu.method) do application.ProcessMessages;  { TODO : 051207 }    //wait for  end scanning
        Startbtn.enabled:=false;
        application.processmessages;
        NanoEdu.Method:=TScanMoveToX0Y0.Create(XBeginnmDir,YBeginnmDir);
        DelayBuf :=ScanParams.MicrostepDelay;
        DelayBWBuf :=ScanParams.MicrostepDelayBW;
        ScanRateBuf:=Scanparams.ScanRate;
        Scanparams.ScanRate:=ReniShawOscParams.RateFastAxis;
        ScanParams.MicrostepDelay:=ReniShawOscParams.microstep_Delay; // !!!!!!
        ScanParams.MicrostepDelayBW:=ReniShawOscParams.microstep_Delay;
        NanoEdu.Method.Launch;
        FreeAndNil(NanoEdu.Method);
        ScanParams.MicrostepDelay:=DelayBuf;
        ScanParams.MicrostepDelayBW:=DelayBWBuf;
        Scanparams.ScanRate:= ScanRateBuf;
        sbHistory.Enabled:=True;
//        PulsesScr_Nmb:=GetCommonUserVar(ch_PULSES_CNT); //aPULSES_CNT=$94;
        flgFinish:= GetCommonUserVar(ch_flgFinish);     //a=$88;
      if  flgFinish>1 then    MessageDlg(siLangLinked1.GetTextOrDefault('IDS_25' (* 'DAC achieved Limit' *) ),mtWarning ,[mbYes],0);
      if PulsesScr_Nmb<>0 then
      begin
          if res=2 then MessageDlg(siLangLinked1.GetTextOrDefault('IDS_11' (* 'Zero Linear array!' *) ),mtWarning,[mbOk],0);
      end
      else
      begin
         MessageDlg(siLangLinked1.GetTextOrDefault('IDS_7' (* 'No RS Pulses!' *) ),mtWarning ,[mbYes],0);
      end;
        FlgStopReniShawOsc:=true;
        RestoreStart();
        application.processmessages;
  end;
   if (AMessage.WParam = ReniShawScanning) then
    begin
       ChartCurrentSignal.BottomAxis.Automatic:=False;
       SerCurrentRSSignal.Active:=False;
       SerRSSignalHist.Active:=True;
       SerRSPulsesHist.Active:=True;
       SerCurrentRSPulses.Active:=False;
       ChartCurrentSignal.BottomAxis.SetMinMax(LastDrawnPoint-1500, LastDrawnPoint);
   //    PulsesScr_Nmb:=GetCommonUserVar(ch_PULSES_CNT);   // a=$94;
       BuildLinearArray(ReniShawOscParams.LengthFast_discr div ReniShawOscParams.delt_discr);
       if PulsesScr_Nmb<>0 then
          begin
          if  ReniShawOscParams.AxisName=XFast then
          begin
                 with HardWareOpt do
                        Koefnm_d:=(CSPMSignals[8].MaxDiscr-CSPMSignals[8].MinDiscr)/((CSPMSignals[8].MaxV-CSPMSignals[8].MinV)*ScannerOptModX.SensitivX*AMPGainX);
                        Koefnm_Volt:=1/ScannerOptModX.SensitivX;
                        Koefdiscr_Volt:=1/RenishawOscParams.TransformkoefX;
                        BuildLinArraynm(Koefnm_d);
                        DrawRSLinnm(SerPulsesIntervalsnm);
                        res:=CountNewSens( InitSensX, RealSensX);
                        LabelNewsens.Caption:=siLangLinked1.GetTextOrDefault('IDS_8' (* 'New Sens X = ' *) )+ FloattostrF(RealSensX, fffixed,5,3)+ siLangLinked1.GetTextOrDefault('IDS_1' (* ' nm/v' *) );
          end
          else if   ReniShawOscParams.AxisName=YFast then
                begin
                   with HardWareOpt do
                       Koefnm_d:=(CSPMSignals[9].MaxDiscr-CSPMSignals[9].MinDiscr)/((CSPMSignals[9].MaxV-CSPMSignals[9].MinV)*ScannerOptModY.SensitivY*AMPGainY);
                       Koefnm_Volt:=1/ScannerOptModX.SensitivY;
                       Koefdiscr_Volt:=1/RenishawOscParams.TransformkoefY;
                       BuildLinArraynm(Koefnm_d);
                       DrawRSLinnm(SerPulsesIntervalsnm);
                       res:=CountNewSens( InitSensY, RealSensY);
                       LabelNewsens.Caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'New Sens Y = ' *) )+ FloattostrF(RealSensY, fffixed,5,3)+ siLangLinked1.GetTextOrDefault('IDS_1' (* ' nm/v' *) );
                 end
                else
                 begin
                  with HardWareOpt do
                       Koefnm_d:=CSPMSignals[7].MaxDiscr/(ScannerCorrect.SensitivZ*UFBMaxOut*AMPGainZ);
                       Koefnm_Volt:=1/ScannerOptModX.SensitivZ;
                       Koefdiscr_Volt:=1/RenishawOscParams.TransformkoefZ;
                       BuildLinArraynm(Koefnm_d);
                       DrawRSLinnm(SerPulsesIntervalsnm);
                       res:=CountNewSens( InitSensZ, RealSensZ);
                       LabelNewsens.Caption:=siLangLinked1.GetTextOrDefault('IDS_10' (* 'New Sens Z = ' *) )+ FloattostrF(RealSensZ, fffixed,5,3)+ siLangLinked1.GetTextOrDefault('IDS_1' (* ' nm/v' *) );
                 end;
         end;
       if  SerRSSignalHist.MaxXValue>CurrentSignalWindow_discr then
               begin
                sbHistory.Enabled:=True;
                sbHistory.Max:=round(10*(SerRSSignalHist.MaxXValue+0.5));
                sbHistory.Min:=10*round(CurrentSignalWindow_discr);
                sbHistory.Position:=sbHistory.Max;
                ChartCurrentSignal.BottomAxis.Automatic:=False;
               end;
       labeldist.caption:=siLangLinked1.GetTextOrDefault('IDS_23' (* 'distance= ' *) )+inttostr(round(PulsesScr_Nmb*ReniShawParams.Period_nm))+siLangLinked1.GetTextOrDefault('IDS_24' (* ' nm' *) );
       NanoEdu.Method.ScanWorkDone;
       NanoEdu.Method.FreeBuffers;
      if Assigned(scWorkThread) then FreeAndNil(scWorkThread);
      FreeAndNiL(NanoEdu.Method);
   end;//reniscanning
end;


procedure TFormRenishawOsc.UpDownClick(Sender: TObject; Button: TUDBtnType);
begin
   if (Button = btNext) then
    begin
     edScanRate.Text:=floattostrf(2*strtoint(edScanRate.Text),fffixed,10,0);
    end
   else
    begin
      edScanRate.Text:=floattostrf(round(0.5*strtoint(edScanRate.Text)),fffixed,10,0);
      if  strtoint(edScanRate.Text)=0 then  edScanRate.Text:='1';
    end;
end;

procedure TFormReniShawOsc.BuildLinearArray(n_Points:integer);
var k,i:integer;
    Buf:TMas2;
    Buf1:array of apitype;
begin
   if  PulsesScr_Nmb<=0 then  exit;

   SetLength(LinearArray,PulsesScr_Nmb);
   SetLength(LinearArrayDiff,(PulsesScr_Nmb-1));

 (*// Finalize(Buf1);
 SetLength(Buf1,0);
  SetLength(Buf1,n_Points);
   for i:=0 to n_Points -1 do
    begin
      Buf1[i]:=(NanoEdu.Method as TReniShawStend).signal_scrdetected[i];
    end;
   //finalize(Buf1);
   SetLength(Buf1,0);
   *)
   k:=0;
   for i:=0 to n_Points-1 do
      begin
         if  (Nanoedu.Method as TREniShawOsc).signal_scrdetected[i]>0 then
           begin
              LinearArray[k]:=i*ReniShawOscParams.delt_discr;

             inc(k);
           end;
      end;
    PulsesScr_Nmb:=k;
     if  PulsesScr_Nmb<=0 then  exit;


   //SMOOTHING
  (*     SetLength(Buf1,0);
        SetLength(Buf1,PulsesScr_Nmb-1);

           Median3_1D(LinearArray,PulsesScr_Nmb-1);

           SetLength(Buf1,0);
         Smooth1(LinearArray,PulsesScr_Nmb-1,30);
    *)

end;


procedure TFormReniShawOsc.DrawRSLinnm(SeriesLinDiffSave:TLineSeries);
var i,i1, k, L:integer;
Absciss, Ordinat:single;

begin

      for i:=0 to NLinearArraynmPoints -2 do
        begin
          Absciss:= LinearArraynm[i]*Koefnm_Volt;
         // Ordinat:= (LinearArraynm[i+1]- LinearArraynm[i]); // nm
          Ordinat:= ReniShawParams.Period_nm*ReniShawOscParams.CurveScale/
                        ((LinearArraynm[i+1]- LinearArraynm[i])*Koefnm_Volt);   // Sensitivity (nm/v )
          SerPulsesIntervalsnm.AddXY(Absciss,Ordinat);              { Absciss in Volt }
        end;

       //for i:=0 to PulsesScr_Nmb-1 do
      // SerScannerMoving.AddXY(LinearArray[i]*Koefdiscr_Volt, i*ReniShawOscParams.Period_nm);

      for i:=0 to NLinearArraynmPoints -1 do
        begin
          SerScannerMoving.AddXY(LinearArraynm[i]*Koefnm_Volt,
                                                  i*ReniShawParams.Period_nm*ReniShawOscParams.CurveScale);
        end;
  end;


procedure TFormRenishawOsc.EdScanRateChange(Sender: TObject);
var v:single;
begin
 try
  v:=strtofloat(edScanRate.text);
  if V>100000 then  edScanRate.text:='100000';
 (* ReniShawOscParams.RateFastAxis:=StrToInt(edScanRate.Text);
      if (RenishawOscParams.AxisName = XFast)  then
        begin
                 ReniShawOscParams.microstep_Delay:=round(1000*1000*ScannerOptModX.SensitivX*ReniShawOscParams.delt_discr/
                                                        (ReniShawOscParams.RateFastAxis* ReniShawOscParams.TransformkoefX));
        end
        else if (RenishawOscParams.AxisName = YFast)  then
              begin
                 ReniShawOscParams.microstep_Delay:=round(1000*1000*ScannerOptModY.SensitivY*ReniShawOscParams.delt_discr/
                                                        (ReniShawOscParams.RateFastAxis* ReniShawOscParams.TransformkoefY));
              end
        else //  ONLY FOR ADC-TEST
              begin
                 ReniShawOscParams.microstep_Delay:=round(1000*1000*ScannerOptModX.SensitivZ*ReniShawOscParams.delt_discr/
                                                        (ReniShawOscParams.RateFastAxis* ReniShawOscParams.TransformkoefZ));
              end;
   API.PATHSPD:= ReniShawOscParams.microstep_Delay;
   SetCommonVar(aPATH_SPD_BW, word(ReniShawOscParams.microstep_Delay div 2));
   *)
 except
    on EConvertError do
    begin MessageDlg( siLangLinked1.GetTextOrDefault('IDS_21' (* 'error input' *) ) ,mtWarning,[mbOk],0); edScanRate.text:='1000'; v:=1000;end;
 end;
end;

procedure TFormRenishawOsc.EdScanRateKeyPress(Sender: TObject; var Key: Char);
begin
   if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TFormReniShawOsc.BuildLinArraynm(TransformKoefnm_d:single);
var i,i1, k:integer;
    Buf:single;
begin
//Finalize(LinearArraynm);
SetLength(LinearArraynm,0);
SetLength(LinearArraynm, PulsesScr_Nmb div ReniShawOscParams.curveScale+1 );
i1:=ReniShawOscParams.curveScale-1;
k:=0;
 for i:=0 to PulsesScr_Nmb-1 do
    begin
    inc(i1);
    if (i1=ReniShawOscParams.curveScale ) then
      begin
        LinearArraynm[k]:=LinearArray[i]/TransformKoefnm_d;
        i1:=0;
        inc(k);
       end;
    end;
    NLinearArraynmPoints:=k;
    buf:= LinearArraynm[0];
    for i:=0 to NLinearArraynmPoints-1 do
       LinearArraynm[i]:=LinearArraynm[i]-Buf;
end;

function TFormReniShawOsc.CountNewSens( InitialSens:single; var NewSens:single):integer;
var
   i:integer;
   SensKoef,RealSens:single;
   MaxLinearArraynm:single;
begin
  result:=0;

 for i:=0 to NLinearArraynmPoints-1 do
   begin
      MaxLinearArraynm:=LinearArraynm[NLinearArraynmPoints-1-i];
      if MaxLinearArraynm>0 then break;
   end;
   if MaxLinearArraynm=0 then
       begin
         Result:=2;
        // MessageDlg(siLangLinked1.GetTextOrDefault('IDS_11' (* 'Zero Linear array!' *) ),mtWarning,[mbOk],0);
         exit;
       end;

  with ReniShawParams do   SensKoef:=PulsesScr_Nmb*Period_nm/MaxLinearArraynm;

  // SensKoef:=(NLinearArraynmPoints-1-i)*curveScale*Period_nm/MaxLinearArraynm;

   RealSens:=InitialSens*SensKoef;
    NewSens:=RealSens;

end;

end.
