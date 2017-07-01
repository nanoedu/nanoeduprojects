//260707
unit frScannerTraining;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, CSPMVar, siComp, siLngLnk,
  ToolWin;

 const   TrainDrawing=1;
 const   TrainScanning=2;

type
  TFormScannerTraining = class(TForm)
    Panel1: TPanel;
    TimerUpT: TTimer;
    Label3: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    ProgressBar: TProgressBar;
    GroupBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    LabelT: TLabel;
    lbltime: TEdit;
    ApplyBitBtn: TBitBtn;
    CbTrainingRate: TComboBox;
    EdCycleNmb: TLabel;
    EdScanRate: TLabel;
    siLangLinked1: TsiLangLinked;
    ToolBar: TToolBar;
    StartBtn: TToolButton;
    HelpBtn: TToolButton;
    StopBtn: TToolButton;
    procedure StopBtnClick(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplyBitBtnClick(Sender: TObject);
    procedure EdScanRateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdScanRateKeyPress(Sender: TObject; var Key: Char);
    procedure TimerUpTTimer(Sender: TObject);
    procedure EdCycleNmbChange(Sender: TObject);
    procedure EdCycleNmbKeyPress(Sender: TObject; var Key: Char);
    procedure lbltimeKeyPress(Sender: TObject; var Key: Char);
    procedure lbltimeChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CbTrainingRateSelect(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
        FlgStopScan:boolean;
        flgBlickApply:Boolean;
        FlagRateChoise:integer;
        ScanDiscrNumb:integer;
        rateKoef:integer;
        TrainingRate: single;         //nm/s
        TrainingTime:single;
        ScanRatebackUp:single;
        ScanRateLimit:single;
        XMax:single;              //nm
        cl:longword;
        LineTime:single;           //seconds
        CycleTime:single;          //seconds
     procedure ThreadDone(var AMessage : TMessage); message WM_ThreadTrainDoneMsg;
     procedure SetTrainingRate(FlagRate:integer);
     procedure RestoreStart;
  public
    { Public declarations }
  end;

var
  FormScannerTraining: TFormScannerTraining;

implementation

{$R *.dfm}

uses  GlobalVar,globalfunction,nanoeduhelp,TrainDrawThread,ScanWorkThread,     { TODO : 250907 }
      UNanoEduBaseClasses, UNanoEduScanClasses,mMain;//,frInstruments;

// const   TimMicroStep=5;        // mks, Time of one microstep;
// const   TimMeasurePoint=1.5;    //mks, time of measure in the point
 const   Fast=0;
 const   Middle=1;
 const   Slow =2;
	strt0: string = ''; (* You have changed Parameters. Press Apply button, before start Trainning *)
	strt1: string = ''; (* Stop training! *)

 procedure TFormScannerTraining.ThreadDone(var AMessage: TMessage); // keep track of when and which thread is done executing
var error:integer;
begin
 if  (TrainDrawing=AMessage.WParam)  then
  begin
    if assigned(DrawTrainThread) then
     begin
      TrainDrawThreadActive:= false;
      DrawTrainThread:=nil;
    end;
(*  while assigned(nanoedu.method) do application.ProcessMessages;
     NanoEdu.Method:=TScanMoveToX0Y0.Create(0,0);
     error:=NanoEdu.Method.Launch;
     FreeAndNil(NanoEdu.Method);
     NanoEdu.SetDACZero;
 *)
     FlgStopScan:=True;
     StartBtn.Enabled := True;
     RestoreStart;
  end;
   if TrainScanning=AMessage.WParam then
    begin
      NanoEdu.Method.FreeBuffers;
      FreeAndNiL(NanoEdu.Method);
     if Assigned(scWorkThread) then FreeAndNil(scWorkThread); 
    end;
end;

procedure TFormScannerTraining.StartBtnClick(Sender: TObject);
var Max_Count,Pt,error:integer;
begin
     StartBtn.Enabled:=False;
  if FlgBlickApply then
       begin
        siLangLinked1.MessageDLG(strt0{'You have changed Parameters. Press Apply button, before start Trainning'}, mtwarning,[mbOK],0);
        StartBtn.Enabled:=true;
        exit;
       end;
 (* if not FlgStopScan then //Stop    Scanning
   begin
        NanoEdu.Method.StopWork;
        NanoEdu.Method.WaitStopWork;
        StartBtn.Enabled:=False;
        ApplyBitBtn.Enabled:=True;
   end *)
 if  FlgStopScan then
   begin
  //   StartBtn.Enabled:=False;
     FlgStopJava:=False;
     FlgStopScan:=False;
     ProgressBar.Position:=0;
     ApplyBitBtn.Enabled:=False;
     StartBtn.Down:=true;   StopBtn.Down:=false;
     cbTrainingRate.Enabled:=false;
     lblTime.enabled:=false;
 //    NanoEdu.Method:=TScanMoveToX0Y0.Create(-Scanparams.xshift,-Scanparams.yshift);
//     error:=NanoEdu.Method.Launch;
//     FreeAndNil(NanoEdu.Method);
//     if error<>0 then begin   RestoreStart; exit end;

    // NanoEdu.Method:=TScannerTrainnig.Create;
    NanoEdu.ScannerTrainnigMethod;
  if NanoEdu.Method.Launch<>0 then
   begin FreeAndNil(NanoEdu.Method); RestoreStart; exit end;
    StopBtn.enabled:=true;
//     StartBtn.Enabled := True;
  end;
end;
procedure TFormScannerTraining.RestoreStart;
begin
     StartBtn.Enabled := True;
     StartBtn.Down:=false;   StopBtn.Down:=true;
     StopBtn.Enabled := false;
     ApplyBitBtn.Enabled:=True;
     cbTrainingRate.Enabled:=true;
     lblTime.enabled:=true;
     ApplyBitBtn.Font.color:=clBlack;
     flgBlickApply:=False;
     FlgStopScan:=true;
end;
procedure TFormScannerTraining.FormCreate(Sender: TObject);
begin
 main.ComboBoxSFMSTM.Enabled:=false;
 siLangLinked1.ActiveLanguage:=Lang;
 UpdateStrings;
 FlagRateChoise:=Middle;
 ScanRateBackUp:=ScanParams.ScanRate;
 cbTrainingRate.ItemIndex:=FlagRateChoise;
//StartBtn.Glyph.Assign(BitMapStart);
(* constraints.MaxHeight:=300;
 constraints.MaxWidth:=320;
 constraints.MinHeight:=250;
 constraints.MinWidth:=320; *)
 SetXYMax;
 XMax:=ScanParams.Xmax; //   nm
 TimerUpT.Interval:=200;
 cl:=$000000FF;
 TrainingTime:=10; //min
 lblTime.text:=inttostr(round(TrainingTime));
 SetTrainingRate(FlagRateChoise);
 FlgStopScan:=True;
 ApplyBitBtnClick(Self);
end;

procedure TFormScannerTraining.ApplyBitBtnClick(Sender: TObject);
var
   StepsTime:single;
begin
 TimerUpT.Interval:=0;
 if TrainingRate>ScanRateLimit  then TrainingRate:=ScanRateLimit;
 if ScanParams.MicrostepDelay=0 then ScanParams.MicrostepDelay:=1;
 TrainingTime:=StrToFloat(lblTime.text);
 ScanParams.CycleCount:=round(60*1000000*TrainingTime/CycleTime/2);
 ProgressBar.Max:=ScanParams.CycleCount;
 EdCycleNmb.Caption:=IntToStr(ScanParams.CycleCount);
// edScanRate.Font.Color:=clBlack;
 edCycleNmb.Font.Color:=clBlack;
 lblTime.Font.Color:=clBlack;
 ApplyBitBtn.Font.Color:=clBlack;
 lbltime.Font.Color:=clBlack;
// ScanParams.DiscrNumInMicroStep:=RateKoef;
 Scanparams.ScanRate:=TrainingRate;
 flgBlickApply:=false;
end;

procedure TFormScannerTraining.EdScanRateChange(Sender: TObject);
begin
  edScanRate.Font.Color:=clRed;
  ApplyBitBtn.Font.Color:=clRed;
  flgBlickApply:=True;
end;

procedure TFormScannerTraining.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=cafree;
  ScanParams.ScanRate:=ScanRatebackUp;
  FormScannerTraining:=nil;
  with Main do
  begin
    Training.visible:=True;
   if  not STMflg then Resonance.visible:=true;
  end;
  main.ComboBoxSFMSTM.Enabled:=true;
end;

procedure TFormScannerTraining.EdScanRateKeyPress(Sender: TObject;  var Key: Char);
begin
    if not(Key in ['0'..'9',DecimalSeparator,#8]) then Key :=#0 ;
end;

procedure TFormScannerTraining.TimerUpTTimer(Sender: TObject);
begin
 if ((TimerUpT.Interval<>0)) then
  begin
    Application.ProcessMessages;
       if flgBlickApply then
           begin
            if cl=$000000FF then cl:=$0000000 else cl:=$000000FF;
             if assigned( FormScannerTraining) then ApplyBitBtn.Font.Color:=TColor(cl);//clRed;
           end;
  end;
end;

procedure TFormScannerTraining.StopBtnClick(Sender: TObject);
begin
 if not FlgStopScan then //Stop    Scanning
   begin
     StopBtn.enabled:=false;
     FlgStopJava:=true;
     StartBtn.Enabled:=False;
  //   ApplyBitBtn.Enabled:=True;
   end
end;

procedure TFormScannerTraining.UpdateStrings;
begin
  strt1 := siLangLinked1.GetTextOrDefault('strstrt1');
  strt0 := siLangLinked1.GetTextOrDefault('strstrt0');
end;

procedure TFormScannerTraining.EdCycleNmbChange(Sender: TObject);
begin
  edCycleNmb.Font.Color:=clRed;
end;

procedure TFormScannerTraining.EdCycleNmbKeyPress(Sender: TObject;  var Key: Char);
begin
     if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;


procedure TFormScannerTraining.lbltimeKeyPress(Sender: TObject;  var Key: Char);
begin
     if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TFormScannerTraining.lblTimeChange(Sender: TObject);
begin
  Progressbar.Position:=0;
  edCycleNmb.Font.Color:=clRed;
  ApplyBitBtn.Font.Color:=clRed;
  lbltime.Font.Color:=clRed;
  flgBlickApply:=True;
end;

procedure TFormScannerTraining.BitBtn1Click(Sender: TObject);
begin
    Application.Helpcontext(IDH_training_scanner);
end;

procedure TFormScannerTraining.CbTrainingRateSelect(Sender: TObject);
begin
  FlagRateChoise:=CbTrainingRate.ItemIndex;
  SetTrainingRate(FlagRateChoise);
  ApplyBitBtn.Font.Color:=clRed;
  ProgressBar.position:=0;
  ApplyBitBtnClick(Sender);
end;

procedure  TFormScannerTraining.SetTrainingRate(FlagRate:integer);
var TrainingRateOut:integer;
begin
 case  FlagRate   of
  Fast:
    begin
       rateKoef:=3;
       CycleTime:=300000;// mks        oscilloscope time
       ScanParams.MicrostepDelay:=2;//round(1000000*(LineTime-StepsTime)/MicrostepsNmb) ;//mcs
       ScanParams.DiscrNumInMicroStep:=1;
    end;
  Middle:
    begin
      rateKoef:=1;
      CycleTime:=750000;// mks          oscilloscope time
      ScanParams.MicrostepDelay:=4;
      ScanParams.DiscrNumInMicroStep:=1;
    end;
  Slow:
    begin
       rateKoef:=1;
       CycleTime:=1040000;// mks       oscilloscope time
       ScanParams.MicrostepDelay:=6;
       ScanParams.DiscrNumInMicroStep:=1;
    end;
   end;
 ScanParams.XMicrostepNmb:=MaxApiType div RateKoef;

(* ScanRateLimit:=900000; //nm/sec
 TrainingRate:=300000;   //nm/s
// LineTime:=ScanParams.XMicrostepNmb*(ScanParams.MicrostepDelay+TimMicroStep); //mks
LineTime:=ScanParams.DiscrNumInMicroStep*(ScanParams.MicrostepDelay+TimMicroStep)*(;
// CycleTime:=4*LineTime+TimMeasurePoint*ScanParams.XMicrostepNmb;  260707
 TrainingRate:= 1000000*XMax/LineTime;
 TrainingRateOut:=round(0.001*TrainingRate)*1000;
 edScanRate.Caption:=IntToStr(TrainingRateOut);//,ffFixed,7);
 ScanParams.CycleCount:=round(60*1000000*TrainingTime/CycleTime);
 *)
  ScanRateLimit:=900000; //nm/sec
  TrainingRate:=300000;   //nm/s
  LineTime:=0.000001*(MaxApiType-MinApiType)/ScanParams.DiscrNumInMicroStep*(ScanParams.TimMicroStep+ScanParams.MicrostepDelay);             //s
// CycleTime:=4*LineTime+TimMeasurePoint*ScanParams.XMicrostepNmb;  260707
  TrainingRate:= XMax/LineTime;               // nm/s
  TrainingRateOut:=round(0.001*TrainingRate)*1000;
  edScanRate.Caption:=IntToStr(TrainingRateOut);//,ffFixed,7);
  ScanParams.CycleCount:=round(60*1000000*TrainingTime/CycleTime);

  EdCycleNmb.Caption:=IntToStr(ScanParams.CycleCount);
  ProgressBar.Max:=ScanParams.CycleCount;
end;

procedure TFormScannerTraining.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TFormScannerTraining.FormCloseQuery(Sender: TObject;   var CanClose: Boolean);
begin
  CanClose:=true;
  if not FlgStopScan then
  begin
    siLangLinked1.MessageDlg(strt1{'Stop training!'},mtWarning,[mbOk],0);
    CanClose:=false;
  end;
end;

end.

