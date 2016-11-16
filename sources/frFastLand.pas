//250204
unit frFastLand;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, siComp, siLngLnk;

type
  TFastLand = class(TForm)
    Panel1: TPanel;
    StartBtn: TBitBtn;
    BitBtnHelp: TBitBtn;
    Label1: TLabel;
    RadioGFastApproach: TRadioGroup;
    TimerWakeUp: TTimer;
    Labelsteps: TLabel;
    StopBtn: TBitBtn;
    PanelPM: TPanel;
    ScrollBarPause: TScrollBar;
    Label2: TLabel;
    LabelPause: TLabel;
    Label3: TLabel;
    siLangLinked1: TsiLangLinked;
    BitBtnSlow: TBitBtn;
    ScrollBarPulse: TScrollBar;
    LabelAcTime: TLabel;
    LabelPulse: TLabel;
    CheckBoxcamera: TCheckBox;
    procedure CheckBoxcameraClick(Sender: TObject);
    procedure BitBtnSlowClick(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure BitBtnExitClick(Sender: TObject);
    procedure RadioGFastApproachClick(Sender: TObject);
    procedure TimerWakeUpTimer(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure ScrollBarPauseScroll(Sender: TObject;  ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ScrollBarPulseScroll(Sender: TObject;  ScrollCode: TScrollCode; var ScrollPos: Integer);
  private
   flgStopStart:boolean;
   FlgTimerActive:Boolean;
   flgRunSlow:boolean;
   StepCount:integer;
   FlgStatusStep:integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FastLand: TFastLand;

implementation

{$R *.dfm}
uses  CSPMVar,Globalvar,GlobalFunction,nanoeduhelp,UNanoEduBaseClasses,
      mMain,  frExperimParams,Video, SystemConfig, FrInform;
const
	strf1: string = ''; (* Fast landing done. Make landing *)
	strf2: string = ''; (* Error!! *)
	strf3: string = ''; (* Tip too close to a sample! *)
	strf4: string = ''; (* Verify landing option or physical unit state. *)
	strf5: string = ''; (* Do you want to rise the probe in a save place? *)
	strf6: string = ''; (* Stop Landing before exit!!! *)

procedure TFastLand.FormCreate(Sender: TObject);
begin
  UpdateStrings;
  flgStopStart:=true;
  siLangLinked1.ActiveLanguage:=Lang;
  FlgTimerActive:=false;
  flgRunSlow:=false;
if Startbtn.Visible then  BitBtnSlow.Visible:=true;
  CheckBoxcamera.Checked:=ApproachParams.flgAutorunCamera;
  Top:=100;;
  LabelSteps.Caption:='0';
//  width:= 170;//210;
//  height:=400;
  StepCount:=0;
  Left:=Main.Width-width-30;
  StartBtn.Glyph.Assign(BitMapStart);
  StartBtn.left:=StartBtn.parent.width div 2-(StartBtn.width div 2);
  StopBtn.left:=StartBtn.left;
  BitBtnSlow.left:=  BitBtnSlow.parent.width div 2-(BitBtnSlow.width div 2);
  StopBtn.Glyph.Assign(BitMapStop);
  RadioGFastApproach.left:=RadioGFastApproach.parent.width div 2-(RadioGFastApproach.width div 2);
  label1.left:=label1.parent.width div 2-(label1.width div 2);
  BitBtnHelp.left:=BitBtnHelp.parent.width div 2-(BitBtnHelp.width div 2);
  labelsteps.left:=labelsteps.parent.width div 2-(labelsteps.width div 2);
//  Instruments.PanelSTMSFM.enabled:=false;
  NanoEdu.ApproachRegime;
  if (RadioGFastApproach.ItemIndex=1) then        //   Rising
  begin
    NanoEdu.ScannerApproach.Nsteps:=ApproachParams.ZUpStepsNumb;
  end
 else
  begin                                          //   Landing
    NanoEdu.ScannerApproach.Nsteps:=-ApproachParams.ZUpStepsNumb;
  end;
  NanoEdu.ScannerApproach.TurnOn;

  case  FlgUnit of
baby:
   begin
    PanelPM.Visible:=true;
    ScrollbarPulse.Position:= ApproachParams.PMActiveTime;
    ScrollBarPause.Position:= ApproachParams.PMPAUSE;
    LabelPAUSE.Caption:=inttostr(ApproachParams.PMPAUSE);
    LabelPULSE.Caption:=inttostr(ApproachParams.PMActiveTime);
   end;
grand:begin
       PanelPM.Visible:=true;
       ScrollbarPulse.Position:= ApproachParams.PMActiveTime;
       ScrollBarPause.Position:= ApproachParams.PMPAUSE;
       LabelPAUSE.Caption:=inttostr(ApproachParams.PMPAUSE);
       LabelPULSE.Caption:=inttostr(ApproachParams.PMActiveTime);
      end;
              end;
   TimerWakeUp.Interval:=1000;
if ApproachParams.flgControlTopPosition then
 begin
  TimerWakeUp.Enabled:=true;
 end;
  Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Fast Landing' *) );
end;

procedure TFastLand.StartBtnClick(Sender: TObject);
var        val,n:integer;
    StatusLoad:Dword;
             P:PChar;
begin
  TimerWakeUp.Enabled:=false;//TimerWakeUp.Interval:=0;
//  ApproachParams.flgOneStep:=false;
 flgStopStart:=false;
  StartBtn.visible:=false;
  BitBtnSlow.Visible:=false;
  flgtooClose:=false;
  Application.ProcessMessages;
if (RadioGFastApproach.ItemIndex=1) then        //   Rising
 begin
  ApproachParams.ZStepsNumb:=ApproachParams.ZUpStepsNumb;//ZFastStepsNumb;//
  SetDemoParamsDef;
 end
 else
 begin                //Landing
   ApproachParams.ZStepsNumb:=-ApproachParams.ZFastStepsNumb;
 end;
                  //steps
    FlgStopApproach:=False;  // flgTooClose:=false;
    FlgApproachOK:=False;
//    TimerWakeUp.Enabled:=false;//TimerWakeUp.Interval:=0;
   if assigned(ApproachOpt) then
    begin
     ApproachOpt.ScanCorSheet.enabled:=false;
     ApproachOpt.HardWareSheet.enabled:=false;
     ApproachOpt.OKBtn.enabled:=false;
     ApproachOpt.DefaultBtn.enabled:=false;
    end;
     RadioGFastApproach.Enabled:=false;
   if  NanoEdu.ScannerApproach.InitSteps(ApproachNScrpt)>0 then  //error
    begin
      RadioGFastApproach.Enabled:=true;
      if assigned(ApproachOpt) then
        begin
          ApproachOpt.ScanCorSheet.enabled:=true;
          ApproachOpt.HardWareSheet.enabled:=true;
          ApproachOpt.OKBtn.enabled:=true;
          ApproachOpt.DefaultBtn.enabled:=true;
        end;
        FlgStopApproach:=True;
 if   ApproachParams.flgControlTopPosition then TimerWakeUp.Enabled:=true;//false;TimerWakeUp.Interval:=200;
        StartBtn.visible:=true;
        BitBtnSlow.Visible:=true;
        StopBtn.visible:=false;
        flgStopStart:=true;
        exit;
    end;
     StopBtn.visible:=true;
   repeat     // make steps
      begin      { TODO : 170107 }
      //     NanoEdu.ScannerApproach.StepsCount:=-StepCount;
           FlgStatusStep:=NanoEdu.ScannerApproach.Step;
           Application.ProcessMessages;
     case FlgStatusStep of
       3: begin           //ok
             beep;
//             StepCount:=StepCount+ ApproachParams.ZStepsNumb;
//             labelSteps.Caption:=Format('%d',[-StepCount]);
             beep;
             TimerWakeUp.Enabled:=false;
             MessageDlgCtr(strf1{ 'Fast landing done. Make landing' }, mtInformation,[mbOk],0);
             FlgStopApproach:=True;
             FlgApproachOK:=True;
          end;
       2: begin                //too close
              beep;
              flgTooClose:=true;
            if  MessageDlgCtr(strf2{'Error!!'}+#13+strf3{'Tip too close to a sample!'}+#13+strf4{'Verify landing option or physical unit state.'}+#13+strf5{'Do you want to rise the probe in a save place?'},mtWarning ,[mbYes,mbNo,mbHelp],IDH_error_landing_option)=mrYes then
             begin
               Application.ProcessMessages;
               NanoEdu.ScannerApproach.RisingToStartPoint(20);
               StepCount:=StepCount+20;
             end;
              Application.ProcessMessages;
              flgTooClose:=false;
              FlgStopApproach:=True;
          end;                      //too close
       4: begin    //out boundary
            FlgStopApproach:=True;
            StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_6' (* '&RUN' *) ) ;
            StartBtn.Glyph.Assign(BitMapStart);
            StartBtn.Font.Color:=clBlack;
            Beep;
          end;
                    end;                //case

          StepCount:=StepCount+ApproachParams.ZStepsNumb;
          labelSteps.Caption:=Format('%d',[-StepCount]);
    end;
        until FlgStopApproach;
    BitBtnSlow.Visible:=true;
    StopBtn.visible:=false;
    RadioGFastApproach.Enabled:=true;
    StartBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_8' (* 'Start Fast Landing' *) ) ;
    StartBtn.visible:=true;
    StartBtn.Enabled:=True;
    flgStopStart:=true;
    if FlgApproachOK  then  Close
                      else
                      if ApproachParams.flgControlTopPosition then TimerWakeUp.enabled:=true;
end;
//
(*procedure TFastLand.StartBtnClick(Sender: TObject);
var        val,n:integer;
    StatusLoad:Dword;
             P:PChar;
begin
if  not StartBtn.enabled then exit;
  StartBtn.enabled:=false;
if (RadioGFastApproach.ItemIndex=1) then        //   Rising
 begin
  ApproachParams.ZStepsNumb:=ApproachParams.ZUpStepsNumb;//ZFastStepsNumb;//
  SetDemoParamsDef;
 end
 else
 begin                //Landing
   ApproachParams.ZStepsNumb:=-ApproachParams.ZFastStepsNumb;
 end;
 if not FlgStopApproach then
  begin
   Nanoedu.ScannerApproach.StopSteps;

   StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_6' {* '&RUN'} ) ;
   StartBtn.Glyph.Assign(BitMapStart);
   RadioGFastApproach.Enabled:=true;
   StartBtn.Font.Color:=clBlack;
  if assigned(ApproachOpt) then
    begin
     ApproachOpt.ScanCorSheet.enabled:=true;
     ApproachOpt.HardWareSheet.enabled:=true;
     ApproachOpt.OKBtn.enabled:=true;
     ApproachOpt.DefaultBtn.enabled:=true;
    end;
    FlgStopApproach:=True;
  end
 else
  begin                     //steps
    FlgStopApproach:=False;
   { TODO : 120206 }
    FlgApproachOK:=False;
    TimerWakeUp.Enabled:=false;//TimerWakeUp.Interval:=0;
   if assigned(ApproachOpt) then
    begin
     ApproachOpt.ScanCorSheet.enabled:=false;
     ApproachOpt.HardWareSheet.enabled:=false;
     ApproachOpt.OKBtn.enabled:=false;
     ApproachOpt.DefaultBtn.enabled:=false;
    end;
     StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_10' { '&STOP' } ) ;
     StartBtn.Glyph.Assign(BitMapStop);
     StartBtn.Font.Color:=clRed;
     RadioGFastApproach.Enabled:=false;
   if  NanoEdu.ScannerApproach.InitSteps>0 then  //error
    begin
      StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_6' { '&RUN' } ) ;
      StartBtn.Glyph.Assign(BitMapStart);
      StartBtn.Font.Color:=clBlack;
      RadioGFastApproach.Enabled:=true;
      if assigned(ApproachOpt) then
        begin
          ApproachOpt.ScanCorSheet.enabled:=true;
          ApproachOpt.HardWareSheet.enabled:=true;
          ApproachOpt.OKBtn.enabled:=true;
          ApproachOpt.DefaultBtn.enabled:=true;
        end;
        FlgStopApproach:=True;
        StartBtn.enabled:=true;
        TimerWakeUp.Enabled:=true;//false;TimerWakeUp.Interval:=200;
        exit;
    end;
   repeat     // make steps
      begin
           NanoEdu.ScannerApproach.StepsCount:=-StepCount;
           FlgStatusStep:=NanoEdu.ScannerApproach.Step;
      //      startbtn.enabled:=true;
           Application.ProcessMessages;
     case FlgStatusStep of
       3: begin           //ok
             beep;
             StepCount:=StepCount+ ApproachParams.ZStepsNumb;
             labelSteps.Caption:=Format('%d',[-StepCount]);
             beep;
             MessageDlgCtr('Fast landing done. Make landing', mtInformation,[mbOk],0);
             FlgStopApproach:=True;
             FlgApproachOK:=True;
          end;
       2: begin                //too close
            beep;
            StepCount:=StepCount+ ApproachParams.ZStepsNumb;
            labelSteps.Caption:=Format('%d',[-StepCount]);
            MessageDlgCtr('Error!! Tip too close to a sample.'+#13+'Make rising or test parameters.',mtWarning ,[mbOK,mbHelp],IDH_error_landing_option);
            FlgStopApproach:=True;
          end;                      //too close
       4: begin    //out boundary
            FlgStopApproach:=True;
            StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_6' { '&RUN' } ) ;
            StartBtn.Glyph.Assign(BitMapStart);
            StartBtn.Font.Color:=clBlack;
            Beep;
            MessageDlgCtr('Attention!!!The step motor has achieved top position!'+#13+'Turn screw counter-clockwise by hand!!', mtInformation,[mbOk],IDH_Probe_is_too_High);
          end;
                    end;                //case
          startbtn.enabled:=true;
          StepCount:=StepCount+ApproachParams.ZStepsNumb;
          labelSteps.Caption:=Format('%d',[-StepCount]);
    end;
        until FlgStopApproach;
    StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_6' {* '&RUN' } );
    StartBtn.enabled:=true;
    StartBtn.Font.Color:=clBlack;
    StartBtn.Glyph.Assign(BitMapStart);
    RadioGFastApproach.Enabled:=true;
    StartBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_8' {* 'Start Fast Landing' }) ) ;
    StartBtn.Enabled:=True;
    TimerWakeUp.enabled:=true;
    if FlgApproachOK then begin Close;{Instruments.PreScanBtnClick(Sender); } End;
    //TimerWakeUp.Interval:=200;
 end;
// {$ENDIF}
end;
 *)
procedure TFastLand.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var h:HWNd;
begin
CanClose := False;
   if not FlgStopApproach   then
    begin
       ShowMessage(strf6{'Stop Landing before exit!!!'})
    end
   else
   if not flgStopStart then  CanClose := False
    else
    begin
     //  while FlgTimerActive do Application.ProcessMessages;
      if not FlgTimerActive  then
      begin
         if assigned(TimerWakeUp) then
         begin
          TimerWakeUp.Enabled:=false;
          FreeAndNil(TimerWakeUp);
         end;
      if   flgVideoOscConflict then
      begin
       h:=findwindow(nil,Pchar((strm41){msvideo'}));
       if  h<>0  then   StopVideo;
      end;
      Application.processmessages;
      CanClose := True;
   end;
  end;
end;

procedure TFastLand.FormClose(Sender: TObject; var Action: TCloseAction);
var h:HWNd;
begin
    Main.ComboBoxSFMSTM.enabled:=(not (FlgApproachOK  and STMflg)) and (not (FlgtooClose  and STMflg));
    if not  Main.ComboBoxSFMSTM.enabled  then
    begin
      Main.ComboBoxSFMSTM.Hint:=siLangLinked1.GetTextOrDefault('IDS_24' (* 'Panel is not enabled.The tip is too close a sample.' *) )+#13+siLangLinked1.GetTextOrDefault('IDS_25' (* 'It is recommended to make rising' *) );
    end
    else
    begin
           case STMflg of
     false:Main.ComboBoxSFMSTM.Hint:=siLangLinked1.GetTextOrDefault('IDS_26' (* 'Scanning Force Microscope' *) );
      true:Main.ComboBoxSFMSTM.Hint:=siLangLinked1.GetTextOrDefault('IDS_27' (* 'Scanning Tunneling Microscope' *) ) ;
       end;
    end;
    Main.Landing.Visible:=true;
    Main.Training.visible:=(not FlgApproachOK) and (not flgtooClose);
    if not STMFlg then
    begin
     Main.Resonance.Visible:=(not FlgApproachOK)and (not flgtooClose);
    end;
    if  FlgApproachOK or flgtooClose
                      then Main.ResonanceBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_28' (* 'Button is not enabled.The tip is too close a sample.' *) )+#13+siLangLinked1.GetTextOrDefault('IDS_25' (* 'It is recommended to make rising' *) )
                      else Main.ResonanceBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_30' (* 'Resonance frequence Measuring  and Setting' *) );
    FreeAndNil(NanoEdu.ScannerApproach);
  Action:=caFree;
  FastLand:=nil;
 if FlgRunSlow or FlgApproachOK then Main.LandingSlowExecute(Sender);
end;

procedure TFastLand.BitBtnHelpClick(Sender: TObject);
begin
    Application.HelpContext(IDH_Probe_Position{IDH_Fast_landing});//(18);
end;

procedure TFastLand.BitBtnSlowClick(Sender: TObject);
begin
  flgRunSlow:=true;
  Close;
end;

procedure TFastLand.CheckBoxcameraClick(Sender: TObject);
begin
    ApproachParams.flgAutorunCamera:=CheckBoxCamera.checked;
end;

procedure TFastLand.BitBtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFastLand.RadioGFastApproachClick(Sender: TObject);
begin
       case RadioGFastApproach.itemindex of
  0: begin Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Fast Landing' *) );RadioGFastApproach.font.color:=clblack; LabelSteps.Font.color:=clRed end;
  1: begin Caption:=siLangLinked1.GetTextOrDefault('IDS_33' (* 'Fast Rising' *) ); RadioGFastApproach.font.color:=clred;   LabelSteps.Font.color:=clRed end;
         end;
end;

procedure TFastLand.TimerWakeUpTimer(Sender: TObject);
begin
   TimerWakeUp.enabled:=false;
   FlgTimerActive:=true;
  if  Approachparams.flgControlTopPosition then
     if Nanoedu.UpperLimitOut then
      begin
         Beep;
       Inform:=TInform.Create(self);
       Inform.Caption:=siLangLinked1.GetTextOrDefault('IDS_34' (* 'Warning!' *) );
       Inform.Labelinf.Color:=clSilver;
       Inform.Labelinf.Font.Color:=clBlack;
       Inform.Labelinf.Caption:=siLangLinked1.GetTextOrDefault('IDS_35' (* 'The step motor has achieved top position!' *) )+#13+siLangLinked1.GetTextOrDefault('IDS_19' (* 'Turn screw counter-clockwise by hand!!' *) );
       Inform.Show;
       Application.ProcessMessages;
       sleep(1300);   { TODO : //170308 }
       Inform.close;
     end;
   FlgTimerActive:=false;
   TimerWakeUp.enabled:=true;
end;

procedure TFastLand.UpdateStrings;
begin
  strf6 := siLangLinked1.GetTextOrDefault('strstrf6');
  strf5 := siLangLinked1.GetTextOrDefault('strstrf5');
  strf4 := siLangLinked1.GetTextOrDefault('strstrf4');
  strf3 := siLangLinked1.GetTextOrDefault('strstrf3');
  strf2 := siLangLinked1.GetTextOrDefault('strstrf2');
  strf1 := siLangLinked1.GetTextOrDefault('strstrf1');
end;

procedure TFastLand.StopBtnClick(Sender: TObject);
begin
  StopBtn.visible:=false;
   Application.ProcessMessages;
  if not FlgStopApproach then
  begin
   Nanoedu.ScannerApproach.StopSteps;
   StartBtn.Visible:=true;
   RadioGFastApproach.Enabled:=true;
  if assigned(ApproachOpt) then
    begin
     ApproachOpt.ScanCorSheet.enabled:=true;
     ApproachOpt.HardWareSheet.enabled:=true;
     ApproachOpt.OKBtn.enabled:=true;
     ApproachOpt.DefaultBtn.enabled:=true;
    end;
    FlgStopApproach:=True;
  end ;
   BitBtnSlow.Visible:=true;
   Application.ProcessMessages;
end;

procedure TFastLand.ScrollBarPauseScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   LabelPAUSE.Caption:=inttostr(ScrollPos);
   ApproachParams.PMPAUSE:=ScrollPos;
  if assigned(NanoEdu.ScannerApproach) then   NanoEdu.ScannerApproach.MOTOR.Pause:=ApproachParams.PMPAUSE;
end;

procedure TFastLand.ScrollBarPulseScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
      ApproachParams.PMActiveTime:=ScrollPos;
      LabelPULSE.Caption:=inttostr(ScrollPos);
    if assigned(NanoEdu.ScannerApproach) then   NanoEdu.ScannerApproach.Motor.SPEED:=ApproachParams.PMActiveTime;
end;

procedure TFastLand.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

end.

