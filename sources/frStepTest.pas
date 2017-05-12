unit frStepTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Series, TeEngine, TeeProcs, Chart, ComCtrls, StdCtrls, Buttons,
  frParInput, ExtCtrls,CSPMVar, globaltype, math, siComp, siLngLnk;
const  StepTestDrawing=2;
       StepTesting=1;
type
  TStepsTest = class(TForm)
    PanelUp: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PanelLeft: TPanel;
    FrActiveTime: TFrameParInput;
    FrSteps: TFrameParInput;
    FrZmin: TFrameParInput;
    FrZmax: TFrameParInput;
    FrCycles: TFrameParInput;
    StartBitBtn: TBitBtn;
    PanelBottom: TPanel;
    BitBtnApply: TBitBtn;
    Panel4: TPanel;
    PageControl: TPageControl;
    TabSheetZ_N: TTabSheet;
    ChartZ_N: TChart;
    SeriesZ_N: TLineSeries;
    TabSheetHL: TTabSheet;
    ChartHist: TChart;
    SeriesH: TAreaSeries;
    SeriesH1: TLineSeries;
    TabSheetHB: TTabSheet;
    ChartHB: TChart;
    SeriesHB: TAreaSeries;
    SeriesHB1: TLineSeries;
    BitBtnHelp: TBitBtn;
    siLangLinked1: TsiLangLinked;
    FrDelay: TFrameParInput;
    procedure FrDelayEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrDelayEditFrmChange(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure StartBitBtnClick(Sender: TObject);
    procedure FrZmaxEditFrmChange(Sender: TObject);
    procedure FrZminEditFrmChange(Sender: TObject);
    procedure FrStepsEditFrmChange(Sender: TObject);
    procedure FrActiveTimeEditFrmChange(Sender: TObject);
    procedure FrCyclesEditFrmChange(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FrActiveTimeEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrZmaxEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrZminEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrStepsEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrCyclesEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrStepsBitBtnFrmClick(Sender: TObject);
    procedure FrZmaxBitBtnFrmClick(Sender: TObject);
    procedure FrCyclesBitBtnFrmClick(Sender: TObject);
    procedure InitChartZ_N();
  private
    { Private declarations }
    FlgStopTest:boolean;
    ApproachParamsSave:RApproachParams;
    procedure RestoreStart;
    function  Histogram(const Vals:array of double; NAreas:integer;MinVal:single; HistStep:single):TMas1;
    procedure ThreadDone(var AMessage : TMessage); message WM_StepTestThreadDoneMsg;     // Message to be sent back from thread when its done
  public
    { Public declarations }
    dn:integer;   //interval step number
    maxz,minz:double;
  end;

var
  StepsTest: TStepsTest;

implementation

{$R *.dfm}
uses globalvar,UNanoEduBaseClasses,uNanoEduScanClasses,ScanWorkThread,TestStepDrawThread,mMain;
const
	strchrt1: string = ''; (* Steps Histogram Landing *)
	strchrt2: string = ''; (* Steps Histogram Rising *)
	strchrt3: string = ''; (* Z(N) ---  Blue - Rising;  Red- Landing *)


procedure TStepsTest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    ApproachParams:=ApproachParamsSave;
(*    NanoEdu.ScannerApproach.IntegratorDelay:=ApproachParams.IntegratorDelay;
    NanoEdu.ScannerApproach.ZMax:=(round(ApproachParams.ZGateMax*Maxapitype));
    NanoEdu.ScannerApproach.ZMin:=(round(ApproachParams.ZGateMin*Maxapitype));
*)
    action:=caFree;
   // StepsTest:=nil;
end;

procedure TStepsTest.FormCreate(Sender: TObject);
begin
  flgStopJava:=false;
  siLangLinked1.ActiveLanguage:=Lang;
  UpdateStrings;
  ChartZ_N.Title.Text[0]:=strchrt3;
  ChartHist.Title.Text[0]:=strchrt1;
  ChartHB.Title.Text[0]:=strchrt2;
  frZMax.siLangLinked1.ActiveLanguage:=lang;
  frZMin.siLangLinked1.ActiveLanguage:=lang;
  frSteps.siLangLinked1.ActiveLanguage:=lang;
  frCycles.siLangLinked1.ActiveLanguage:=lang;
  frActiveTime.siLangLinked1.ActiveLanguage:=lang;
  frDelay.siLangLinked1.ActiveLanguage:=lang;
  flgStopTest:=true;
  PanelUp.Height:=470;
  PanelLeft.Top:=0;
  PanelLeft.Height:=PanelUp.ClientHeight;
  PanelLeft.Width:=230;
  StepTestDrawThreadActive:=false;
  PageControl.Top:=0;
  PageControl.Left:=PanelLeft.Left+PanelLeft.width+5;
  PageControl.Width:=PanelUp.ClientWidth-panelleft.width-10;
  PageControl.Height:=PanelLeft.Height;
  PageControl.ActivePage:=TabSheetZ_N;
  SeriesHB1.Active:=false;
  SeriesH1.Active:=false;
   ApproachParamsSave:= ApproachParams;
   ApproachParams.IntegratorDelay:=2000;

   with FrZmax  do
   begin
    ScrollBarFrm.Max:=100;
    ScrollBarFrm.Min:=0;
    ScrollBarFrm.Position:=round(ApproachParams.ZGateMax*ScrollBarFrm.Max);
    EditFrm.Text:=intToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:='%';
   end;
  with FrZmin   do
   begin
    ScrollBarFrm.Max:=100;
    ScrollBarFrm.Min:=0;
    ScrollBarFrm.Position:=round(ApproachParams.ZGateMin*ScrollBarFrm.Max);
    EditFrm.Text:=intToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:='%';
   end;
  with FrSteps do
   begin
    ScrollBarFrm.Max:=10;
    ScrollBarFrm.Min:=1;
    ScrollBarFrm.Position:=1;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:='';
   end;
   with FrActiveTime do
   begin
    ScrollBarFrm.Max:=1000;
    ScrollBarFrm.Min:=0;
    ScrollBarFrm.Position:=ApproachParams.PMActiveTime;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:='';
   end;
     with FrDelay do
   begin
    ScrollBarFrm.Max:=4000;
    ScrollBarFrm.Min:=0;
    ScrollBarFrm.Position:=ApproachParams.IntegratorDelay;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:='';
   end;
 if  ApproachParams.TypeMover=0 then FrActiveTime.Visible:=false  //sm
                                else FrActiveTime.Visible:=true;  //pm
  with FrCycles do
   begin
    ScrollBarFrm.Max:=200;
    ScrollBarFrm.Min:=1;
    ScrollBarFrm.Position:=10;//ApproachParams.NCycles;   //10
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:='';
   end;
   StartBitBtn.Font.Color:=clBlack;
   InitChartZ_N();
 //  NanoEdu.ScannerApproach.IntegratorDelay:=ApproachParams.IntegratorDelay;// SetCommonVar(CT2,IntegratorDelay);
end;

procedure TStepsTest.StartBitBtnClick(Sender: TObject);

begin
 if  not FlgStopTest then //Stop   TEST
   begin

       flgStopJava:=true;
       StartBitBtn.Font.Color:=clBlack;
       StartBitBtn.Enabled:=false;
   //    NanoEdu.Method.StopWork;
   //    NanoEdu.Method.WaitStopWork;
   end
   else       //Start  Test
   begin
     FlgStopTest:=False;
     StartBitBtn.Enabled:=false;
     StartBitBtn.Font.Color:=clRed;
     StartBitBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* '&STOP' *) );
     TabSheetHl.enabled:=false;
     TabSheetHB.enabled:=false;
     InitChartZ_N();

     PageControl.ActivePage:=TabSheetZ_N;
 //    NanoEdu.ScannerApproach.InitTestStep;
     NanoEdu.Method:=TStepTest.Create;
     if NanoEdu.Method.Launch<>0 then begin FreeAndNil(NanoEdu.Method); ReStoreStart; exit; end;
     StartBitBtn.Enabled:=true;
   end;
end;

procedure TStepsTest.RestoreStart;
begin
         FlgStopTest:=true;
       StartBitBtn.Font.Color:=clBlack;
       StartBitBtn.Enabled:=false;

end;

procedure TStepsTest.siLangLinked1ChangeLanguage(Sender: TObject);
begin

  UpdateStrings;
end;

procedure TStepsTest.ThreadDone(var AMessage: TMessage);
var  Sender:TObject;
     StepZ:single;
     lMaxVal, MinVal:single;
     L,i:integer;
     H:TMas1;
     d,HistMin,HistMax:single;
     NAreas:integer;
     HistStep,Current:single;
     dev,aver:extended;
     YVals:array of double;
  label 100,200;
begin
 if  (StepTestDrawing=AMessage.WParam) then
  begin
    if assigned(StepTestDrawThread)  then
     begin
      StepTestDrawThreadActive := false;
      StepTestDrawThread:=nil;
     for i:=0 to SeriesZ_N.Count-2 do
     begin   d:=SeriesZ_N.YValues[i+1]-SeriesZ_N.YValues[i];
      if SeriesZ_N.ValueColor[i+1]=clBlue then  SeriesHB1.AddY(d)   //rising
                                          else  SeriesH1.AddY(-d);  //landing
     end;
     //landing
      if SeriesH1.count<=2 then goto 100;
      SetLength(YVals,SeriesH1.Count-1);
      for i:=0 to SeriesH1.Count-2 do  YVals[i]:=SeriesH1.YValues[i];

      MinVal:=minValue(YVals);
      lMaxVal:=maxValue(YVals);
      NAreas:=1+round(sqrt(SeriesH1.Count));
      if NAreas<=6 then NAreas:=6;
      HistStep:=(lmaxval-minval+1)/NAreas;
      H:=Histogram(YVals, NAreas, MinVal, HistStep);
      StepZ:=1;
      L:=Length(H);
      HistMin:=H[0];
     for i:=0 to L-1 do  if H[i]<HistMin then HistMin:=H[i];
      HistMax:=H[0];
     for i:=0 to L-1 do  if H[i]>HistMax then HistMax:=H[i];
     with ChartHist.BottomAxis do
     begin
       Automatic:=False;
       SetMinMax(StepZ*minval,StepZ*(lmaxval+HistStep));
     end;
    SeriesH.Stairs:=True;
    SeriesH.Clear;
    Current:=StepZ*minval;
    for i:=0 to NAreas do
    begin
     if i<> Nareas then SeriesH.AddXY(Current,H[i]/(SeriesH1.Count-1))
                   else SeriesH.AddXY(Current,0);
     Current:=Current+StepZ*HistStep;
    end;
     MeanAndStdDev(YVals,aver,dev);
     ChartHist.Title.Text.clear;
     ChartHist.Title.Text.Add(siLangLinked1.GetTextOrDefault('IDS_1' (* '   mean= ' *) )+floattostrf(aver, Fffixed,4,1)+
                                     siLangLinked1.GetTextOrDefault('IDS_2' (* '   Std Dev= ' *) ) +floattostrf(dev, Fffixed,4,1));
      YVals:=nil;
      //rising
100: if  SeriesHB1.Count<=2 then goto 200;
      SetLength(YVals,SeriesHB1.Count-1);
      for i:=0 to SeriesHB1.Count-2 do  YVals[i]:=SeriesHB1.YValues[i];

      MinVal:=minValue(YVals);
      lMaxVal:=maxValue(YVals);
      NAreas:=1+round(sqrt(SeriesHB1.Count));
      if NAreas<=6 then NAreas:=6;
      HistStep:=(lmaxval-minval+1)/NAreas;
      H:=Histogram(YVals, NAreas, MinVal, HistStep);
      StepZ:=1;
      L:=Length(H);
      HistMin:=H[0];
     for i:=0 to L do  if H[i]<HistMin then HistMin:=H[i];
      HistMax:=H[0];
     for i:=0 to L do  if H[i]>HistMax then HistMax:=H[i];
     with ChartHB.BottomAxis do
     begin
       Automatic:=False;
       SetMinMax(StepZ*minval,StepZ*(lmaxval+HistStep));
     end;
    SeriesHB.Stairs:=True;
    SeriesHB.Clear;
    Current:=StepZ*minval;
    for i:=0 to NAreas do
    begin
     if i<> Nareas then SeriesHB.AddXY(Current,H[i]/(SeriesHB1.Count-1))
                   else SeriesHB.AddXY(Current,0);
     Current:=Current+StepZ*HistStep;
    end;
     MeanAndStdDev(YVals,aver,dev);
     ChartHB.Title.Text.clear;
     ChartHB.Title.Text.Add(siLangLinked1.GetTextOrDefault('IDS_1' (* '   mean= ' *) )+floattostrf(aver, Fffixed,4,1)+
                           siLangLinked1.GetTextOrDefault('IDS_2' (* '   Std Dev= ' *) ) +floattostrf(dev, Fffixed,4,1));
      YVals:=nil;

200:  FlgStopTest:=true;
      TabSheetHl.enabled:=true;
      TabSheetHB.enabled:=true;
      StartBitBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_5' (* '&RUN' *) );
      StartBitBtn.Font.Color:=clBlack;
      StartBitBtn.Enabled:=True;
     end;
  end; //draw
 if StepTesting=AMessage.WParam  then
    begin

      NanoEdu.Method.FreeBuffers;
    //   if Assigned(StepTestDrawThread) then FreeAndNil(StepTestDrawThread);
      FreeAndNiL(NanoEdu.Method);

    end;                                                          
end;

function  TStepsTest.Histogram(const Vals:array of double; NAreas:integer;MinVal:single; HistStep:single):TMas1;
var
 i:integer;
 a: integer;
 Histogr: TMas1;
 len: integer; // Histogram Length;
begin
 len:=NAreas;
 if len<0 then  exit;
 SetLength(Histogr,len+1);
 for i:=0 to length(Vals)-1 do
    begin
     a:=round((Vals[i]-MinVal)/HistStep-0.5);
     Histogr[a]:=Histogr[a]+1;
    end;
  Histogram:=Histogr;
  Histogr:=nil;
end;

procedure TStepsTest.FrZmaxBitBtnFrmClick(Sender: TObject);
begin
  FrZmax.BitBtnFrmClick(Sender);

end;

procedure TStepsTest.FrZmaxEditFrmChange(Sender: TObject);
var Val:integer;
begin
  FrZmax.EditFrmChange(Sender);
try
 if (FrZmax.editFrm.text='')  then
  begin  { TODO : 101005 }
  exit;
  end;
  val:=StrToInt(FrZmax.EditFrm.Text);
    if val<FrZmax.ScrollBarFrm.Min then
    begin
     val:=FrZMax.ScrollBarFrm.Min;
     FrZmax.EditFrm.Text:=inttostr(val);
    end;
    if val>FrZMax.ScrollBarFrm.Max then
    begin
     val:=FrZmax.ScrollBarFrm.Max;
     FrZMax.EditFrm.Text:=inttostr(val);
    end;
 Approachparams.ZGateMax:=StrToFloat(FrZMax.EditFrm.Text)/100;
  except
    on EConvertError do
     begin
       FrZmax.editFrm.text:='70';
     end;
 end;
end;

procedure TStepsTest.FrZminEditFrmChange(Sender: TObject);
var val:integer;
begin
  FrZmin.EditFrmChange(Sender);
   try
    if (FrZmin.editFrm.text='')  then
  begin  { TODO : 101005 }
  exit;
  end;  val:=StrToInt(FrZmin.EditFrm.Text);
    if val<FrZmin.ScrollBarFrm.Min then
    begin
     val:=FrZMin.ScrollBarFrm.Min;
     FrZmin.EditFrm.Text:=inttostr(val);
    end;
    if val>FrZMin.ScrollBarFrm.Max then
    begin
     val:=FrZmin.ScrollBarFrm.Max;
     FrZMin.EditFrm.Text:=inttostr(val);
    end;
  except
    on EConvertError do
     begin
      FrZmin.editFrm.text:='30';
    end;
 end;
  Approachparams.ZGateMin:=StrToFloat(FrZMin.EditFrm.Text)/100;
end;

procedure TStepsTest.FrStepsBitBtnFrmClick(Sender: TObject);
begin
  FrSteps.BitBtnFrmClick(Sender);

end;

procedure TStepsTest.FrStepsEditFrmChange(Sender: TObject);
var val:integer;begin
  FrSteps.EditFrmChange(Sender);
   try
     if (FrSteps.editFrm.text='')  then  exit;
    val:=StrToInt(FrSteps.EditFrm.Text);
    if val<FrSteps.ScrollBarFrm.Min then
    begin
     val:=FrSteps.ScrollBarFrm.Min;
     FrSteps.EditFrm.Text:=inttostr(val);
    end;
    if val>FrSteps.ScrollBarFrm.Max then
    begin
     val:=FrSteps.ScrollBarFrm.Max;
     FrSteps.EditFrm.Text:=inttostr(val);
    end;
  except
    on EConvertError do
     begin
      FrSteps.editFrm.text:='1';
    end;
 end;
  Approachparams.ZStepsNumb:=-StrToInt(FrSteps.EditFrm.Text);
end;

procedure TStepsTest.FrActiveTimeEditFrmChange(Sender: TObject);
var val:integer;begin
   FrActiveTime.EditFrmChange(Sender);
   try
    if (FrActiveTime.editFrm.text='')  then
  begin  { TODO : 101005 }
  exit;
  end;   val:=StrToInt(FrActiveTime.EditFrm.Text);
    if val<FrActiveTime.ScrollBarFrm.Min then
    begin
     val:=FrActiveTime.ScrollBarFrm.Min;
     FrActiveTime.EditFrm.Text:=inttostr(val);
    end;
    if val>FrActiveTime.ScrollBarFrm.Max then
    begin
     val:=FrActiveTime.ScrollBarFrm.Max;
     FrActiveTime.EditFrm.Text:=inttostr(val);
    end;
  except
    on EConvertError do
     begin
      FrActiveTime.editFrm.text:='1';
     end;
  end;
  Approachparams.PMActiveTime:=StrToInt(FrActiveTime.EditFrm.Text);
//if assigned(Nanoedu.ScannerApproach) then  Nanoedu.ScannerApproach.Motor.Speed:=ApproachParams.PMActiveTime ;
end;

procedure TStepsTest.FrCyclesBitBtnFrmClick(Sender: TObject);
begin
  FrCycles.BitBtnFrmClick(Sender);

end;

procedure TStepsTest.FrCyclesEditFrmChange(Sender: TObject);
 var val:integer;
begin
 FrCycles.EditFrmChange(Sender);
try
   if (FrCycles.editFrm.text='')  then
  begin  { TODO : 101005 }
  exit;
  end; val:=StrToInt(FrCycles.EditFrm.Text);
   if val<FrCycles.ScrollBarFrm.Min then
    begin
     val:=FrCycles.ScrollBarFrm.Min;
     FrCycles.EditFrm.Text:=inttostr(val);
    end;
    if val>FrCycles.ScrollBarFrm.Max then
    begin
     val:=FrCycles.ScrollBarFrm.Max;
     FrCycles.EditFrm.Text:=inttostr(val);
    end;
  except
    on EConvertError do
     begin
      FrCycles.editFrm.text:='10';
    end;
 end;
  Approachparams.NCycles:=StrToInt(FrCycles.EditFrm.Text);
end;

procedure TStepsTest.BitBtn3Click(Sender: TObject);
begin
 close;
end;

procedure TStepsTest.FormCloseQuery(Sender: TObject;   var CanClose: Boolean);
begin
   if not flgStopTest then
   begin
      MessageDlg(siLangLinked1.GetTextOrDefault('IDS_9' (* 'Stop Test before exit!!!' *) ), mtInformation,[mbOk],0);
      CanClose := False;
    end
     else  CanClose := True;
end;

procedure TStepsTest.FrActiveTimeEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  FrActiveTime.EditFrmKeyPress(Sender, Key);
  if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TStepsTest.FrZmaxEditFrmKeyPress(Sender: TObject; var Key: Char);
begin
  FrZmax.EditFrmKeyPress(Sender, Key);
   if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TStepsTest.FrZminEditFrmKeyPress(Sender: TObject; var Key: Char);
begin
  FrZmin.EditFrmKeyPress(Sender, Key);
  if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TStepsTest.FrStepsEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  FrSteps.EditFrmKeyPress(Sender, Key);
  if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TStepsTest.FrCyclesEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  FrCycles.EditFrmKeyPress(Sender, Key);
 if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TStepsTest.FrDelayEditFrmChange(Sender: TObject);
var val:integer;
begin
   FrDelay.EditFrmChange(Sender);
   try
    if (FrDelay.editFrm.text='')  then
  begin  { TODO : 101005 }
  exit;
  end;   val:=StrToInt(FrDelay.EditFrm.Text);
    if val<FrDelay.ScrollBarFrm.Min then
    begin
     val:=FrDelay.ScrollBarFrm.Min;
     FRDelay.EditFrm.Text:=inttostr(val);
    end;
    if val>FrDelay.ScrollBarFrm.Max then
    begin
     val:=FrDelay.ScrollBarFrm.Max;
     FrDelay.EditFrm.Text:=inttostr(val);
    end;
  except
    on EConvertError do
     begin
      FrDelay.editFrm.text:='1';
     end;
  end;
  Approachparams.IntegratorDelay:=StrToInt(FrDelay.EditFrm.Text);
 // if assigned(NanoEdu.ScannerApproach)then NanoEdu.ScannerApproach.IntegratorDelay:=Approachparams.IntegratorDelay;
end;

procedure TStepsTest.FrDelayEditFrmKeyPress(Sender: TObject; var Key: Char);
begin
   FrActiveTime.EditFrmKeyPress(Sender, Key);
  if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TStepsTest.UpdateStrings;
begin
  strchrt3 := siLangLinked1.GetTextOrDefault('strstrchrt3');
  strchrt2 := siLangLinked1.GetTextOrDefault('strstrchrt2');
  strchrt1 := siLangLinked1.GetTextOrDefault('strstrchrt1');
end;

procedure TStepsTest.InitChartZ_N();
var GateMax,GateMin:double;
begin
  SeriesZ_N.Clear;
     SeriesH.Clear;
     SeriesHB.Clear;
     SeriesH1.Clear;
     SeriesHB1.Clear;
     dn:=50;
     gateMax:=(ApproachParams.ZGateMax)+0.15;
     gateMin:=(ApproachParams.ZGateMin)-0.15;
     if GateMax>1 then GateMax:=1;
     if GateMin<0 then GateMin:=0;
     maxZ:=GateMax*(MaxApitype- MinApitype)/TransformUnit.Znm_d;    // nm
     minZ:=GateMin*(MaxApitype- MinApitype)/TransformUnit.Znm_d;    // nm     ; MaxZ > MinZ; MinZ, MaxZ >0
     ChartZ_N.LeftAxis.Automatic:=false;
     ChartZ_N.BottomAxis.Automatic:=false;
    // ChartZ_N.LeftAxis.SetMinMax(minZ,maxZ);
     ChartZ_N.LeftAxis.SetMinMax(minZ,maxZ);
     ChartZ_N.BottomAxis.SetMinMax(0,dn);
end;

end.

