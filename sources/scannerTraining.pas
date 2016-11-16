unit ScannerTraining;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,GlobalType,GlobalVar, ComCtrls, CSPMVar,CSPMHelp;
 const   TrainDrawing=1;
 const   TrainScanning=2;

 const   TimMicroStep=1;        // mks, Time of one microstep;
 const   TimMeasurePoint=1.5;    //mks, time of measure in the point
 const   Fast=0;
 const   Slow =2;
 const   Middle=1;

type
  TFormScannerTraining = class(TForm)
    Panel1: TPanel;
    StartBtn: TBitBtn;
    TimerUpT: TTimer;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    ApplyBitBtn: TBitBtn;
    lbltime: TEdit;
    EdCycleNmb: TEdit;
    CbTrainingRate: TComboBox;
    EdScanRate: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    LabelT: TLabel;
    Panel3: TPanel;
    ProgressBar: TProgressBar;
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

//        DAC_Z0,DAC_Zx,DAC_ZEnd:apitype;
        TrainingRate: single;         //nm/s
        TrainingTime:single;
        ScanRatebackUp:single;
        ScanDiscrNumb: integer;
        flgBlickApply:Boolean;
        ScanRateLimit:single;
        XMax:single;              //nm
        cl:longword;
        rateKoef:integer;
  //       MicrostepsNmb:integer;
 //        MicrostepDelay:apitype;     //mks
        LineTime:single;           //seconds
        CycleTime:single;          //seconds
        FlagRateChoise:integer;
//     function  StartScanWork(ScanScrpt:string; InBufferLen,OutBufferLen:integer):byte;
//     procedure TrainingPath(N:integer);
//     procedure ScanMoveToX0Y0(X0,Y0:apitype);
 //    procedure FreeWork;
     procedure ThreadDone(var AMessage : TMessage); message WM_ThreadTrainDoneMsg;
     procedure SetTrainingRate(FlagRate:integer);
     procedure RestoreStart;
  public
    { Public declarations }
  //  CycleCount:word;
  end;

var
  FormScannerTraining: TFormScannerTraining;
     FlgStopScan:boolean;
implementation

{$R *.dfm}
uses   ScanWorkThread,TrainDrawThread,SioCSPM,SystemConfig, mScanRate,frProgress,
       UNanoeduInterface,UNanoEduClasses, UNanoEduScanClasses,frInstruments;

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
     NanoEdu.Method:=TScanMoveToX0Y0.Create(0,0);
     error:=NanoEdu.Method.Launch;
     FreeAndNil(NanoEdu.Method);
     StartBtn.Enabled := True;
     StartBtn.Caption:='&RUN';
     StartBtn.Glyph.Assign(BitMapStart);
     StartBtn.Font.Color:=clBlack;
  end;
   if TrainScanning=AMessage.WParam then
    begin
      NanoEdu.Method.ScanWorkDone;
      NanoEdu.Method.FreeBuffer;
      FreeAndNiL(NanoEdu.Method);
    end;
    ApplyBitBtn.Enabled:=True;
    cbTrainingRate.Enabled:=true;
    ApplyBitBtn.Font.color:=clBlack;
    flgBlickApply:=False;
end;
(*

procedure TFormScannerTraining.FreeWork;
begin
 f.Pin:=nil;
 f.POut:=nil;
 f.PPath:=nil;
 FreeMem(Data_out);
 FreeMem(Data_path);
 FreeMem(Data_in);
end;

function TFormScannerTraining.StartScanWork(ScanScrpt:string; InBufferLen,OutBufferLen:integer):byte;
var
   P:PChar;
   StatusLoad:DWord;
begin
  result:=0;
  if BufRegister<>0 then
                begin
                        ShowMessage('Unable to register buffers!Reload Controller.');
                        raise EDivByZero.Create('');
                        result:=2;
                        exit
                end;
  if LoadScript(ScanScrpt)<>0 then begin result:=1; exit;end;
	ScanStart;
	f.Pin:= data_in;
	f.in_count:= InBufferLen;
	f.Ppath:= data_path;
 	f.Pout:=data_out;
	f.out_count:= OutBufferLen;
      if ScanInit(@f)<>0 then
                begin
                 ShowMessage('Error in ScanInit()');
                 raise EDivByZero.Create('');
                 result:=3;
                 exit;
                end;
  ScWorkThread := TScanWorkThread.Create;
end;
*)
procedure TFormScannerTraining.StartBtnClick(Sender: TObject);
var Max_Count,Pt,error:integer;
begin
  if FlgBlickApply then
       begin
           MessageDLG('You have changed Parameters. Press Apply button, before start Trainning', mtwarning,[mbOK],0);
           exit
       end;
  if FlgStopScan=False then //Stop    Scanning
   begin
       FlgStopScan:=true;
        NanoEdu.Method.StopWork;
        NanoEdu.Method.WaitStopWork;
        StartBtn.Enabled:=False;
        ApplyBitBtn.Enabled:=True;
   end
   else       //Start  Scannning
   begin
     FlgStopScan:=False;
     ProgressBar.Position:=0;
     ApplyBitBtn.Enabled:=False;
     StartBtn.Font.Color:=clRed;
     StartBtn.Caption:='&STOP';
     StartBtn.Enabled:=False;
     StartBtn.Glyph.Assign(BitMapStop);
     cbTrainingRate.Enabled:=false;
 //    SetCommonVar(MIN_IN,0);
 //    SetCommonVar(STATUS,0);
 //    API.PMSPEED:=0;// SetCommonVar(PM_SPEED,0);

     NanoEdu.Method:=TScanMoveToX0Y0.Create(0,0);
     error:=NanoEdu.Method.Launch;
     FreeAndNil(NanoEdu.Method);
     if error<>0 then begin   RestoreStart; exit end;

 //    ScanMoveToX0Y0(0,0);

 //  SetCommonVar(MIN_IN,0);
 //  SetCommonVar(STATUS,0);
 // API.PMSPEED:=0;// SetCommonVar(PM_SPEED,0);
 //  SetCommonVar(PRIM_STEP_X,word(ScanParams.DiscrNumInMicroStep));
 //  SetCommonVar(PRIM_STEP_Y,word(ScanParams.DiscrNumInMicroStep));
   // MicrostepDelay:=5;  //!!!!!!!!!!!!!!!!!!SET FIXED
 // Api.PATHSPD:=ScanParams.MicrostepDelay;// SetCommonVar(PATH_SPD,word(ScanParams.MicrostepDelay));    // Delay between microsteps;
 //  SetCommonVar(JUMP,1);                           //  Microstep Size

     StartBtn.Enabled:=False;
     StartBtn.Font.Color:=clRed;
     StartBtn.Caption:='&STOP';
     StartBtn.Glyph.Assign(BitMapStop);
     NanoEdu.Method:=TScannerTrainnig.Create;
  if NanoEdu.Method.Launch<>0 then
   begin FreeAndNil(NanoEdu.Method); RestoreStart; exit end;
     StartBtn.Enabled := True;
  end;
end;
procedure TFormScannerTraining.RestoreStart;
begin
     StartBtn.Enabled := True;
     StartBtn.Caption:='&RUN';
     StartBtn.Font.Color:=clBlack;
     StartBtn.Glyph.Assign(BitMapStart);
     ApplyBitBtn.Enabled:=True;
     cbTrainingRate.Enabled:=true;
     ApplyBitBtn.Font.color:=clBlack;
     flgBlickApply:=False;
     FlgStopScan:=true;
end;

(*
procedure  TFormScannerTraining.ScanMoveToX0Y0(X0,y0:apitype);    //nm
var XEnd,YEnd:integer;
    i:dword;
  //  ProgressCal: TProgress ;
 begin
 DAC_ZEnd:=apitype(GetCommonVar(DAC_Z));
 XEnd:=abs(apitype(GetCommonVar(DAC_X)));   //discrets;
 YEnd:=abs(apitype(GetCommonVar(DAC_Y)));

   SetCommonVar(PRIM_STEP_X,word(1));
   SetCommonVar(PRIM_STEP_Y,word(1));
   SetCommonVar(JUMP,1);
     try
        GetMem(data_out,2);
        GetMem(data_path,4*2);
        GetMem(data_in,2);
        f.path_count:= 4;
	PWordArray(data_path)[0]:= word($4000 or 0);
	PWordArray(data_path)[1]:= word(X0-XEnd);
	PWordArray(data_path)[2]:= word($C000 or 0);
	PWordArray(data_path)[3]:= word(Y0-YEnd);
             if   StartScanWork(TrainScrpt,1,1)<>0 then exit;

           (*     ProgressCal:=TProgress.Create(self);
                ProgressCal.Show;
                ProgressCal.caption:='Wait for moving to the start point';
                ProgressCal.ProgressBar.Max:=abs(x0-XEnd)+abs(y0-yend);
             if ProgressCal.ProgressBar.Max=0 then ProgressCal.ProgressBar.Max:=1;
                ProgressCal.ProgressBar.Min:=0;
                ProgressCal.ProgressBar.Position:=0;
       while (ProgressCal.ProgressBar.Position<ProgressCal.ProgressBar.Max) do
        begin
             Application.ProcessMessages;
             XEnd:=abs(apitype(GetCommonVar(DAC_X)));
             YEnd:=abs(apitype(GetCommonVar(DAC_Y)));
             ProgressCal.ProgressBar.Position :=ProgressCal.ProgressBar.Max-abs(x0-XEnd)-abs(y0-yend); ;
           end;
             *)
(*        TrainWorkThread.WaitFor;
        TrainWorkThread.Destroy;
        TrainWorkThread := nil;
         if ScanDone<>0 then                                     {Завершение сканирования}
                begin
                        ShowMessage('Error in ScanDone()');
                        raise EDivByZero.Create('');
                end;
        BufDeRegister;
   finally
//     ProgressCal.Free;
     FreeWork;
   end;
end;
*)
(*
procedure  TFormScannerTraining.TrainingPath(N:integer);
var i:integer;
begin
   GetMem(data_in,1*sizeof(word));
   GetMem(data_out,N*sizeof(word));
   GetMem(data_path,N*8*sizeof(word));
   f.path_count:=8*N;
   i:=0;
while i<N*8 do
 begin
	PWordArray(data_path)[i+0]:= word($4000 or 0);
	PWordArray(data_path)[i+1]:= word(ScanParams.XMicrostepNmb);
	PWordArray(data_path)[i+2]:= word($4000 or 0);
	PWordArray(data_path)[i+3]:= word(-ScanParams.XMicrostepNmb);
  PWordArray(data_path)[i+4]:= word($C000 or 0);
	PWordArray(data_path)[i+5]:= word(ScanParams.XMicrostepNmb);
	PWordArray(data_path)[i+6]:= word($C000 or 1);
	PWordArray(data_path)[i+7]:= word(-ScanParams.XMicrostepNmb);
  i:=i+8;
 end;
end;
*)
procedure TFormScannerTraining.FormCreate(Sender: TObject);
begin
 FlagRateChoise:=Middle;
 ScanRatebackUp:=ScanParams.ScanRate;
 cbTrainingRate.ItemIndex:=FlagRateChoise;
 StartBtn.Glyph.Assign(BitMapStart);
 height:=500;
 width:=400;
 constraints.MaxHeight:=400;
 constraints.MaxWidth:=400;
 constraints.MinHeight:=400;
 constraints.MinWidth:=400;
 XMax:= Maxapitype/TransformUnit.Xnm_d;
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
  ProgressBar.Max:=ScanParams.CycleCount;
 if TrainingRate>ScanRateLimit then TrainingRate:=ScanRateLimit;
 if ScanParams.MicrostepDelay=0 then ScanParams.MicrostepDelay:=1;
 TrainingTime:=StrToFloat(lblTime.text);
 ScanParams.CycleCount:=round(60*1000000*TrainingTime/CycleTime);
 EdCycleNmb.Text:=IntToStr(ScanParams.CycleCount);
 ProgressBar.Max:=ScanParams.CycleCount;
// edScanRate.Font.Color:=clBlack;
 edCycleNmb.Font.Color:=clBlack;
 lblTime.Font.Color:=clBlack;
 ApplyBitBtn.Font.Color:=clBlack;
 lbltime.Font.Color:=clBlack;
 ScanParams.DiscrNumInMicroStep:=RateKoef;
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
  with Instruments do
  begin
    ToolBtnTest.Enabled:=True;
    AdjustBtn.Enabled:=true;
  end;
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

procedure TFormScannerTraining.EdCycleNmbChange(Sender: TObject);
begin
  edCycleNmb.Font.Color:=clRed;
 // ApplyBitBtn.Font.Color:=clRed;
 // flgBlickApply:=True;
end;

procedure TFormScannerTraining.EdCycleNmbKeyPress(Sender: TObject;  var Key: Char);
begin
     if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;


procedure TFormScannerTraining.lbltimeKeyPress(Sender: TObject;  var Key: Char);
begin
     if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TFormScannerTraining.lbltimeChange(Sender: TObject);
begin
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
end;

procedure  TFormScannerTraining.SetTrainingRate(FlagRate:integer);
var TrainingRateOut:integer;
begin
 case  FlagRate   of
  Fast:
    begin
       rateKoef:=3;
       ScanParams.MicrostepDelay:=5;//round(1000000*(LineTime-StepsTime)/MicrostepsNmb) ;//mcs
    end;
  Middle:
    begin
      rateKoef:=1;
       ScanParams.MicrostepDelay:=2;
    end;
  Slow:
    begin
       rateKoef:=1;
       ScanParams.MicrostepDelay:=6;
    end;
   end;
 ScanParams.XMicrostepNmb:=MaxApiType div RateKoef;
 ScanRateLimit:=900000; //nm/sec
 TrainingRate:=300000;   //nm/s
 LineTime:=ScanParams.XMicrostepNmb*(ScanParams.MicrostepDelay+TimMicroStep); //mks
 CycleTime:=4*LineTime+TimMeasurePoint*ScanParams.XMicrostepNmb;
 TrainingRate:= 1000000*XMax/LineTime;
 TrainingRateOut:=round(0.001*TrainingRate)*1000;
 //edScanRate.Text:=FloatToStrF(TrainingRate,ffFixed,7,0);
 edScanRate.Text:=IntToStr(TrainingRateOut);//,ffFixed,7);
 ScanParams.CycleCount:=round(60*1000000*TrainingTime/CycleTime);
 EdCycleNmb.Text:=IntToStr(ScanParams.CycleCount);
 ProgressBar.Max:=ScanParams.CycleCount;
end;

procedure TFormScannerTraining.FormCloseQuery(Sender: TObject;   var CanClose: Boolean);
begin
  CanClose:=true;
  if not FlgStopScan then
  begin
    MessageDlg('Stop testing!',mtWarning,[mbOk],0);
    CanClose:=false;
  end;
end;

end.
