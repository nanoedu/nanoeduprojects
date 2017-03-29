//110407

unit frapproachnew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, Math, Buttons, frSignalsMod, MPlayer,
  CspmVar,GlobalType, RuleMod4, siComp, siLngLnk, ComCtrls, ToolWin, ActnList,
     {$IFDEF DEBUG}
           SioCSPM,frDebug,
       {$ENDIF}
  ImgList;
  type
  TApproach = class(TForm)
    TimerUp: TTimer;
    PanelPM: TPanel;
    LblPMtime: TLabel;
    LabelTimeval: TLabel;
    ScrollBarPMTime: TScrollBar;
    LabelPMPause: TLabel;
    LabelPauseval: TLabel;
    ScrollBarPMPause: TScrollBar;
    siLangLinked1: TsiLangLinked;
    PanelMain: TPanel;
    SignalsMode: TSignalsMod;
    BitBtnStepTest: TBitBtn;
    Panel5: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    LabelCur: TLabel;
    LabelZV: TLabel;
    Label7: TLabel;
    LabeLZMax: TLabel;
    LabelSignalMax: TLabel;
    LabelZ: TLabel;
    ZIndicator: TRuleMod4;
    SignalIndicator: TRuleMod4;
    PanelCounter: TPanel;
    Label6: TLabel;
    edstepscounter: TLabel;
    NormBitBtn: TBitBtn;
    SpeedButton6: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton7: TSpeedButton;
    exitBtn: TBitBtn;
    CheckBoxCamera: TCheckBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
//    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    ToolBarControl: TToolBar;
    Startbtndown: TToolButton;
    StartBtnFastDown: TToolButton;
    StartBtnOneStepdown: TToolButton;
    ToolButton1: TToolButton;
    StopBtn: TToolButton;
    ToolButton3: TToolButton;
    StartOneBtnUp: TToolButton;
    StartBtnFastUp: TToolButton;
    StartBtnUp: TToolButton;
    Panel10: TPanel;
    PanelLanding: TPanel;
    Panel12: TPanel;
    PanelRising: TPanel;
    ToolBarOpt: TToolBar;
    Optionsbtn: TToolButton;
    ToolBarOk: TToolBar;
    BitBtnOk: TToolButton;
    BitBtnHelp: TToolButton;
    BitBtnLog: TBitBtn;
    PanelTimeControl: TPanel;
    ScrollBarTimeControl: TScrollBar;
    Label4: TLabel;
    LblTimeControl: TLabel;
    LblMs: TLabel;
    procedure FormShow(Sender: TObject);
    procedure CheckBoxCameraClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StartBtnDownClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure TimerWakeUp(Sender: TObject);
    procedure OptionsBtnClick(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure NormBitBtnClick(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure RadioApproachEnter(Sender: TObject);
    procedure RadioApproachClick(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
   // procedure BitBtnLogClick(Sender: TObject);
    procedure BitBtnStepTestClick(Sender: TObject);
    procedure SignalsModeButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure StartBtnOneStepdownClick(Sender: TObject);
    procedure ScrollBarPMTimeScroll(Sender: TObject; ScrollCode: TScrollCode;     var ScrollPos: Integer);
    procedure ScrollBarPMPauseScroll(Sender: TObject;ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure BitBtnLogClick(Sender: TObject);
    procedure SignalsModebtnSetPointClick(Sender: TObject);
    procedure SignalsModeButton2Click(Sender: TObject);
    procedure ScrollBarTimeControlScroll(Sender: TObject; ScrollCode: TScrollCode;  var ScrollPos: Integer);
    procedure SignalsModeBtnBiasVClick(Sender: TObject);
    procedure UpdateStrings;
  private
     { Private declarations }
     ApproachActive:boolean;
     ApproachOneActive:boolean;
  //   flgOneStepActive:boolean;
     flgApproachOK_justAchieved:boolean;  // 14/03/13 ola- для того, чтобы отличить
                                         // ложный захват от выхода из ворот
     flgCanClose:boolean;
     flgTimerActive:Boolean;
     ActiveTag:integer;
     ZMaxContr,ZMinContr:apitype;
     AddCaption:string;
     MainCaption:string;
     FormVar: ^TApproach;
    procedure  OneStep(n:apitype);
    procedure  TestContact;
    procedure  NormalizeUAM;
    procedure  WMMOve(var Mes:TWMMove); message WM_Move;
    procedure  WMNCLButton(var Message: TMessage); message WM_NCLButtonDown;
    function   AverageSignalIndicator:apitype;
    procedure  SetZLevelsValue(Sender: TObject);
    procedure  SetUAMLevelsValue(Sender: TObject);
    procedure  SetITLevelsValue(Sender: TObject);
    procedure  SetITSetPointValue(Sender: TObject);
    procedure  SetUAMSetPointValue(Sender: TObject);
    procedure  TestZGate(stepDir:integer);   // +1 rising, -1 landing
    function   CheckResonance:boolean;
  // function  ExecAndWait(const FileName, Params: ShortString; const WinState: Word): boolean;
  protected
    procedure CreateParams(var Params:TCreateParams); override;
  public
    { Public declarations }
     StopAllow:boolean;
     flgCancel:Boolean;
     FlgStepResult:apitype;
     ZMaxAbility:word; {discrets}
     StepsCount:integer; //absolute number
     StartStepsCount:integer;   //number of steps when start click
     procedure  ThreadDone(var AMessage : TMessage); message WM_ThreadDoneMsg;
     procedure  ZIndicatorDraw(Z:apitype);
     procedure  SignalDraw(SignalValue:apitype);
//  constructor Create(AOwner: TComponent; var AFormVar: TApproach);
//  destructor  Destroy; override;
 end;

var
  Approach: TApproach;
const
	strv: string = ''; (* Voltage Bias=0. Set Voltage *) // TSI: Localized (Don't modify!)


implementation

uses frExperimParams,mMain,GlobalVar,GlobalFunction,ScanWorkThread,
     fShockwave,UNanoEduBaseClasses, UNanoEduClasses, UNanoeduInterface,
     nanoeduhelp,frSpectroscopy,frStepTest,ApproachThreadDrawNew,uNanoEduScanClasses,
     SystemConfig, FrInform,frSetInteraction,frViewLogFile, frReport;

     {$R *.DFM}

var  UAM:apitype;
     IT:apitype;
     ITMAX:apitype;
     cl:longword;

procedure TApproach.ThreadDone(var AMessage: TMessage); // keep track of when and which thread is done executing
var
 val,i:integer;
     z:apitype;
     hr:Hresult;
     lFlgStatusStep:apitype;
  begin
 if  (mDrawing=AMessage.WParam)then
  begin
    if assigned(ApproachThread) then
     begin
        ApproachThread:=nil;
        ApproachThreadActive := false;
          case FlgStepResult of
      3: begin           //ok
            beep;
            BitBtnOK.Visible:=True;
            z:=NanoEdu.ZValue;
            ZIndicatorDraw(z);
          //  SignalsMode.FrequencyTrack.Enabled:=True;
            SignalsMode.sbTi.Enabled:=True;
            SignalIndicator.Value:=abs(NanoEdu.SignalValue);
               { TODO : 050406 }
            case STMFlg of
       TRUE: begin
              LabelCur.Caption:=FloatToStrF({2*}ITCor*SignalIndicator.Value/TransformUnit.nA_d,ffFixed ,8,3)
            end;
     False: begin
              LabelCur.Caption:=FloatToStrF(SignalIndicator.Value/ApproachParams.UAMMax,ffFixed ,8,2)
            end;
                    end; //case
             for i:=0  to 5 do beep;
               MessageDlgCtr( siLangLinked1.GetTextOrDefault('IDS_2' (* 'Landing done' *) ) , mtInformation,[mbOk],0);
               FlgApproachOK:=True;
               flgApproachOK_justAchieved:=true;
               Main.ComboBoxSFMSTM.Enabled:= not (FlgApproachOK and STMflg);
                 {$IFNDEF FULL}
                   BitBtnStepTest.Enabled:=FlgApproachOK;
                 {$ENDIF}
               Main.Scanning.Visible:=true;
            end;
      2: begin                //too close
            beep;
            flgTooClose:=true;
            Z:=NanoEdu.ZValue;
            ZIndicatorDraw(z);
            // SignalsMode.FrequencyTrack.Enabled:=True;
            SignalsMode.sbTi.Enabled:=True;
            SignalIndicator.Value:=abs(NanoEdu.SignalValue);
             case STMFlg of
      TRUE: begin
             LabelCur.Caption:=FloatToStrF({2*}ITCor*SignalIndicator.Value/TransformUnit.nA_d,ffFixed ,8,3)
            end;
     False: begin
             LabelCur.Caption:=FloatToStrF(SignalIndicator.Value/ApproachParams.UAMMax,ffFixed ,8,2)
            end;
                      end; //case
             if  MessageDlgCtr( siLangLinked1.GetTextOrDefault('IDS_3' (* 'Error!!' *) ) +#13+siLangLinked1.GetTextOrDefault('IDS_4' (* 'Tip too close to a sample!' *) )+#13+ siLangLinked1.GetTextOrDefault('IDS_5' (* 'Verify landing option or physical unit state.' *) )+#13+siLangLinked1.GetTextOrDefault('IDS_6' (* 'Do you want to rise the probe in a save place?' *) ) ,mtWarning ,[mbYes,mbNo,mbHelp],IDH_error_landing_option)=mrYes then
             begin
               StartBtnDown.Down:=false;
               StartBtnFastDown.Down:=false;
               Application.ProcessMessages;
               StartBtnFastUp.Down:=true;
               ApproachActive :=true;
           //    NanoEdu.RisingToStartPoint(20);
           //edited 14/03/17
               if (flgUnit=ProBeam) then lFlgStatusStep:=NanoEdu.RisingToStartPoint(30) else
                if (flgUnit=MicProbe) then lFlgStatusStep:=NanoEdu.RisingToStartPoint(30)       // need to known!!!!!!!!!!!!!!
                                      else lFlgStatusStep:=NanoEdu.RisingToStartPoint(30);   //changed 220316
               Sleep(1000);
               StartBtnFastUp.Down:=false;
               StepsCount:=StepsCount+30;
             end;

              Application.ProcessMessages;
              flgTooClose:=false;
              Main.ComboBoxSFMSTM.Enabled:=false;
          end;                      //too close
       4: begin    //out boundary
           // SignalsMode.FrequencyTrack.Enabled:=True;
            SignalsMode.sbTi.Enabled:=True;
            NormBitBtn.Enabled:=True;
            Beep;
            MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_69' (* 'Attention!!!' *) )+#13+
                          siLangLinked1.GetTextOrDefault('IDS_29' (* 'The step motor has achieved top position!' *) )+#13+
                          siLangLinked1.GetTextOrDefault('IDS_30' (* 'Turn screw counter-clockwise by hand!!' *) ), mtInformation,[mbOk],IDH_Probe_is_too_High);
           end;
                     end;                //case

  //      if NanoEdu.ScannerApproach.flgMadeStep then StepsCount:=StepsCount+ApproachParams.ZStepsNumb;
          edStepsCounter.Caption:=Format( '%d' ,[-StepsCount]);
          Z:=NanoEdu.ZValue;
          ZIndicatorDraw(Z);
          SignalIndicator.Value:=abs(NanoEdu.SignalValue);
          SignalIndicator.Repaint;
                 case STMFlg of
     False: begin
              LabelCur.Caption:=FloatToStrF(SignalIndicator.Value/ApproachParams.UAMMax,ffFixed ,8,2)
            end;
      TRUE: begin
              LabelCur.Caption:=FloatToStrF({2*}ITCor*SignalIndicator.Value/TransformUnit.nA_d,ffFixed ,8,3)
            end;
               end; //case
        end;

    flgStopJava:=false;

    WaitforJavaNotActive;

    if assigned(ApproachOpt) then
    begin
     ApproachOpt.ScanCorSheet.enabled:=true;
     ApproachOpt.HardWareSheet.enabled:=true;
    end;
    StartStepsCount:=StepsCount;
    Main.ComboBoxSFMSTM.Enabled:=not (FlgApproachOK and STMflg);
    SignalsMode.sbTi.Enabled:=True;
    NormBitBtn.Enabled:=True;
    PanelLanding.Font.Color:=clBlack;
    PanelRising.Font.Color:=clBlack;
    flgStopTimer:=false;
    TimerUp.enabled:=true;
    NormBitBtn.Enabled:=True;
    StartBtnDown.Down:=false;
    StartBtnUp.Down:=false;
    StartBtnFastDown.Down:=false;
    StartBtnFastUp.Down:=false;
    ActiveTag:=7; //stop
    ApproachActive:=false;
    ToolBarControl.Enabled:=true;
    flgCanClose:=true;
    StopBtn.Down:=true;
   end;//drawthread
    if mScanning=AMessage.WParam then
    begin
     if  flgControlerTurnON   then
      begin
        NanoEdu.Method.ScanWorkDone;
        NanoEdu.Method.FreeBuffers;
        FreeAndNil(NanoEdu.Method);
      end;
    end;
end;

 //
 procedure TApproach.ZIndicatorDraw(Z:apitype);
begin
 if Assigned(ZIndicator) then
   begin
      // ZIndicator.Value:=round((MinAPITYPE+1)*(Z-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));
      ZIndicator.Value:=round((MaxAPITYPE)*(1-(Z-MinAPITYPE)/(MaxAPITYPE-MinAPITYPE))); // Нормировка изменена 30/07/2013
  // Z изменяется от -32768 до 32767 ???
       LabelZV.Font.color:=clGreen;
       ZIndicator.IndicColor:=clGreen;
    if  (ZIndicator.Value < ZIndicator.LowLimit) then
     begin
        ZIndicator.IndicColor:=clRed;
        LabelZV.Font.color:=clRed;
      //  Beep;
     end
     else
     if  (ZIndicator.Value >ZIndicator.HighLimit) then
      begin
          ZIndicator.IndicColor:=clNavy;
          LabelZV.Font.color:=clNavy ;
      end ;
      LabelZV.Caption:=FloattoStrF(ZIndicator.Value/Maxapitype,fffixed,3,2);
      Zindicator.RePaint;
      Application.processmessages;
  end;
end;
procedure  TApproach.SignalDraw(SignalValue:apitype);
begin
     if Assigned(SignalIndicator) then
         begin
                       case STMFlg of                 //151210
      TRUE: begin
             SignalIndicator.Value:=abs(SignalValue*ITCor);//070212
             if Assigned(Approach) then
               LabelCur.Caption:=FloatToStrF(ITCor*SignalValue/TransformUnit.nA_d,ffFixed ,8,3)
              end;
      False: begin
              SignalIndicator.Value:=SignalValue  ;
              if Assigned(Approach) then
                LabelCur.Caption:=FloatToStrF(SignalValue/ApproachParams.UAMMax,ffFixed ,8,2)
             end;
               end; //case
           SignalIndicator.Repaint;
         end;
end;
procedure TApproach.SetZLevelsValue;
begin
 ApproachParams.ZGateMax:=Zindicator.HighLimit/ZMaxAbility;
 ApproachParams.ZGateMin:=Zindicator.LowLimit/ZMaxAbility;
 if assigned(ApproachOpt)    then ApproachOpt.ApproachSheetInit;
 if Assigned(Nanoedu.Method) then Nanoedu.Method.SetUsersParams;
(* begin
//  Nanoedu.ScannerApproach.Zmax:=round(ApproachParams.ZGateMax*MaXapitype);
//  Nanoedu.ScannerApproach.ZMin:=round(ApproachParams.ZGateMin*Maxapitype);
 end;
 *)
end;

procedure TApproach.SetITLevelsValue;
begin
  ApproachParams.LevelIT:=SignalIndicator.HighLimit/TransformUnit.nA_d;    //101210
  if assigned(ApproachOpt)    then  ApproachOpt.ApproachSheetInit;
  if assigned(Nanoedu.Method) then  Nanoedu.Method.SetUsersParams;
end;

procedure TApproach.SetITSetPointValue;
begin
   ApproachParams.LandingSetPoint:=SignalIndicator.LowLimit/TransformUnit.nA_d;  //101210
   ApproachParams.SetPoint:=ApproachParams.LandingSetPoint;
   Approach.SignalsMode.btnSetPoint.Caption:=FloattoStrF(ApproachParams.LandingSetPoint*ITCor,fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_0' (* ' nA' *) );//101210
      if assigned(ApproachOpt) then  ApproachOpt.ApproachSheetInit;
   if Assigned(Nanoedu.Method) then  NanoEdu.Method.SetUsersParams
   else Nanoedu.SetPoint:=ApiType(round(ApproachParams.SetPoint*TransformUnit.nA_d));
end;

procedure  TApproach.TestZGate(stepDir:integer);   // +1 rising, -1 landing;
var i:integer;
begin
  if assigned( ZIndicator) then
     with ZIndicator do
     begin
      if (value>HighLimit) and FlgApproachOK then
         begin
           if stepDir =-1 then   // landing
                 MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_31' (* 'Error!!!' *) )
                 +#13+ siLangLinked1.GetTextOrDefault('IDS_32' (* 'False Occurence of Landing done message. Read FAQ' *) ), mtInformation,[mbOk,mbHelp],IDH_FAQR_Approach)
              else   // rizing
             MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_69' (* 'Attention!' *) ) + #13+ siLangLinked1.GetTextOrDefault('IDS_52' (* 'You leave work zone!' *) ), mtInformation,[mbOk,mbHelp],IDH_FAQR_Approach);
             flgApproachOK:=false;
             BitBtnOK.Visible:=false;
             exit;
         end;
      if (value<LowLimit) then
         begin
          if stepDir = -1 then
              MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_31' (* 'Error!!!' *) ) +#13+ siLangLinked1.GetTextOrDefault('IDS_4' (* 'Too close' *) ), mtInformation,[mbOk,mbHelp],IDH_FAQR_Approach);
             flgApproachOK:=false;
             BitBtnOK.Visible:=false;
         end;
      if (value>=LowLimit)  and   (value<=HighLimit) then
         begin
          beep;
            BitBtnOK.Visible:=True;
             for i:=0  to 5 do beep;
             if not FlgApproachOK then MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_2' { 'Landing done' }), mtInformation,[mbOk],0);
               FlgApproachOK:=True;
               Main.ComboBoxSFMSTM.Enabled:= not (FlgApproachOK and STMflg);
               {$IFNDEF FULL}
                 BitBtnStepTest.Enabled:=FlgApproachOK;
               {$ENDIF}
               Main.Scanning.Visible:=true;
          end;
     end;
end;

procedure TApproach.SetUAMSetPointValue;
begin
  ApproachParams.LandingSetPoint:=SignalIndicator.LowLimit/ApproachParams.UAMMax;
  Approach.SignalsMode.LbSuppress.Caption:=FloattoStrF((1-ApproachParams.LandingSetPoint),fffixed,4,2);
  Approach.SignalsMode.LbSuppressI.Caption:=FloattoStrF((1-ApproachParams.LandingSetPoint),fffixed,4,2);
 if assigned(ApproachOpt)    then ApproachOpt.ApproachSheetInit;
 if Assigned(Nanoedu.Method) then  NanoEdu.Method.SetUsersParams
                             else  Nanoedu.SetPoint:=ApproachParams.LandingSetPoint;
end;

procedure TApproach.SetUAMLevelsValue;
begin
  ApproachParams.LevelUAM:=SignalIndicator.HighLimit/ApproachParams.UAMMax;
  if assigned(ApproachOpt)    then ApproachOpt.ApproachSheetInit;
  if Assigned(Nanoedu.Method) then Nanoedu.Method.SetUsersParams;
//   Nanoedu.ScannerApproach.SetLevel;
end;

procedure TApproach.CheckBoxCameraClick(Sender: TObject);
begin
   ApproachParams.flgAutorunCamera:=CheckBoxCamera.Checked;
end;

procedure TApproach.CreateParams(var Params:TCreateParams);
begin
inherited CreateParams(Params);
//  Params.Style:=Params.Style xor WS_SizeBOX {xor WS_MaximizeBox};
end;

procedure TApproach.WMMOve(var Mes:TWMMove);
begin
// if Mes.YPos<(Main.ToolBarMain.Height div 2) then Top:=5;//Main.ToolBarMain.Height+5;
end;
procedure TApproach.WMNCLButton(var Message: TMessage);
 begin
       case Message.wParam of
HTCAPTION:
          begin
           if AltDown  then        // copy to clipboard    for report
             if  assigned(ReportForm) then
             begin
               Panelmain.BeginDrag(False);
               Main.CopyToClipBoardExecute(self);
               ReportForm.CaptureSourceImage(Panelmain);
             end;
           end;
      end;
      inherited;
 end;


procedure TApproach.StartBtnDownClick(Sender: TObject);
var
     val,i,ltag:integer;
     z:apitype;
     scriptname:string;
begin
ltag:=TControl(Sender).tag;
if ((ltag = 1 ) or (ltag = 2 )) and (not CheckResonance) then exit;
if STMFlg then
 if (ApproachParams.BiasV=0) then
    begin
      siLangLinked1.MessageDLG(strv , mtwarning,[mbOK],0);
      exit;
    end;
FlgStopJava:=false;

if not ApproachOneActive then
if not ApproachActive then     //not active approach process
begin
 ApproachActive :=true;
 ToolBarControl.Enabled:=false;
 Application.ProcessMessages;
 flgApproachOk:=False;
 flgTooClose:=false;
 ScriptName:=ApproachNScrpt;

      case  ltag of
1:begin                //Landing
   ApproachParams.ZStepsNumb:=1;//-1;
   AddCaption:=siLangLinked1.GetTextOrDefault('IDS_8' (* ', Landing' *) );
   panelLanding.Font.Color:=clRed;
   panelRising.Font.Color:=clBlack;
//   panelfaststep.Visible:=false;
  end;
2:begin
   panelLanding.Font.Color:=clRed;    panelRising.Font.Color:=clBlack;
   ApproachParams.ZStepsNumb:={-}ApproachParams.ZFastStepsNumb;
   AddCaption:=siLangLinked1.GetTextOrDefault('IDS_8' (* ', Landing' *) );
  // if flgUnit=sem then panelfaststep.Visible:=true;
  end;
//rising
4:begin
    ApproachParams.ZStepsNumb:=-1;
    NormBitBtn.Enabled:=True;
    BitBtnOK.Visible:=false;
    panelRising.Font.Color:=clRed;
    panelLanding.Font.Color:=clBlack;
    FlgApproachOK:=False;         //Rising
    {$IFNDEF FULL}
          BitBtnStepTest.Enabled:=FlgApproachOK;
    {$ENDIF}
   // panelfaststep.Visible:=false;
 //   SetDemoParamsDef;
    AddCaption:=siLangLinked1.GetTextOrDefault('IDS_35' (* ', rising' *) );
  end;
5:begin
   panelRising.Font.Color:=clRed;   panelLanding.Font.Color:=clBlack;
   ApproachParams.ZStepsNumb:=-ApproachParams.ZUpStepsNumb;
   NormBitBtn.Enabled:=True;
   BitBtnOK.Visible:=false;
   FlgApproachOK:=False;         //Rising
  //  if flgUnit=sem then panelfaststep.Visible:=true;
               {$IFNDEF FULL}
                   BitBtnStepTest.Enabled:=FlgApproachOK;
               {$ENDIF}
 //  SetDemoParamsDef;
   AddCaption:=siLangLinked1.GetTextOrDefault('IDS_35' (* ', rising' *) );
  end;
            end;  //case
  Caption:=MainCaption+AddCaption;
 if  FlgStopApproach then
  begin
    FlgStopApproach:=False;
    FlgApproachOK:=False;
 //  while   flgTimerActive do  Application.processmessages;
    flgStopTimer:=true;
    TimerUp.Enabled:=false;
   if assigned(ApproachOpt) then
    begin
     ApproachOpt.ScanCorSheet.enabled:=false;
     ApproachOpt.HardWareSheet.enabled:=false;
    end;
    Main.ComboBoxSFMSTM.Enabled:=false;
    BitBtnOK.Visible:=False;
   // SignalsMode.FrequencyTrack.Enabled:=true;//False;
   SignalsMode.sbTi.Enabled:=True;
    NormBitBtn.Enabled:=False;
    FlgCanClose:=false;
    Application.processmessages;
    NanoEdu.ApproachMethod;
    if NanoEdu.Method.Launch<>0 then
     begin
      FreeAndNil(NanoEdu.Method);
       if assigned(ApproachOpt) then
        begin
          ApproachOpt.ScanCorSheet.enabled:=true;
          ApproachOpt.HardWareSheet.enabled:=true;
        end;

      NormBitBtn.Enabled:=True;
      FlgStopApproach:=True;
      ApproachParams.flgOneStep:=false;
      StopBtn.Down:=true;
      TToolButton(Sender).down:=false;
      ApproachActive:=false;
      flgCanClose:=true;
      ToolBarControl.Enabled:=true;
      exit;
    end;
  end
  else
  begin     //stop false;
   ApproachActive :=true;
   ToolBarControl.Enabled:=false;
  end
 end
 else
 begin //active aproach process
  ltag:=TControl(Sender).tag;
      case ltag of
  1:begin                //Landing
     ApproachParams.ZStepsNumb:=1;
     panelLanding.Font.Color:=clRed;    panelRising.Font.Color:=clBlack;
     AddCaption:=siLangLinked1.GetTextOrDefault('IDS_8' (* ', landing' *) );
    //  panelfaststep.Visible:=false;
    end;
  2:begin
     panelLanding.Font.Color:=clRed;    panelRising.Font.Color:=clBlack;
     ApproachParams.ZStepsNumb:=ApproachParams.ZFastStepsNumb;
     AddCaption:=siLangLinked1.GetTextOrDefault('IDS_8' (* ', landing' *) );
     //if flgUnit=sem then panelfaststep.Visible:=true;
    end;
//rising
  4:begin
     ApproachParams.ZStepsNumb:=-1;
     panelLanding.Font.Color:=clBlack;    panelRising.Font.Color:=clred;
     BitBtnOK.Visible:=false;
    //  panelfaststep.Visible:=false;
     FlgApproachOK:=False;         //Rising
               {$IFNDEF FULL}
                   BitBtnStepTest.Enabled:=FlgApproachOK;
               {$ENDIF}
     AddCaption:=siLangLinked1.GetTextOrDefault('IDS_35' (* ', rising' *) );
    end;
 5:begin
    ApproachParams.ZStepsNumb:=-ApproachParams.ZUpStepsNumb;
    panelLanding.Font.Color:=clBlack;    panelRising.Font.Color:=clred;
    BitBtnOK.Visible:=false;
   // if flgUnit=sem then panelfaststep.Visible:=true;
    FlgApproachOK:=False;         //Rising
               {$IFNDEF FULL}
                   BitBtnStepTest.Enabled:=FlgApproachOK;
               {$ENDIF}
    AddCaption:=siLangLinked1.GetTextOrDefault('IDS_35' (* ', rising' *) );
   end;
            end;  //case
    Caption:=MainCaption+AddCaption;
//    Nanoedu.ScannerApproach.NSteps:=ApproachParams.ZStepsNumb;
  if assigned (Nanoedu.Method) then   Nanoedu.Method.SetUsersParams;
    Application.processmessages;
 end;       //ApproachActive
 ActiveTag:=TControl(Sender).tag;
end;

procedure TApproach.FormClose(Sender: TObject; var Action: TCloseAction);
var newItem:TMenuItem;
begin
  ApprOnProgr:=False;
  if assigned(SetInteraction) then  SetInteraction.close;
  Main.ComboBoxSFMSTM.Enabled:=(not (FlgApproachOK  and STMflg)) and (not (FlgtooClose  and STMflg));
  if not  Main.ComboBoxSFMSTM.Enabled
    then
    begin
      Main.ComboBoxSFMSTM.Hint:= siLangLinked1.GetTextOrDefault('IDS_19' (* 'Panel is not enabled.The tip is too close a sample.' *) )+#13+siLangLinked1.GetTextOrDefault('IDS_20' (* 'It is recommended to make rising' *) );
    end
    else
    begin
      Main.ComboBoxSFMSTM.Hint:= '';
     case STMflg of
     false:Main.ComboBoxSFMSTM.Hint:=siLangLinked1.GetTextOrDefault('IDS_18' (* 'Scanning Force Microscope' *) );
     true: Main.ComboBoxSFMSTM.Hint:=siLangLinked1.GetTextOrDefault('IDS_15' (* 'Scanning Tunneling Microscope' *) ) ;
       end;
    end;
  Main.Scanning.Visible:=True;
//if FlgUnit<>ProBeam then     //comment 16/11/24
  Main.Training.Visible:=(not FlgApproachOK) and (not FlgTooClose);//not FlgApproachOK;//false;
if  not STMflg then
 begin
  Main.Resonance.visible:=(not FlgApproachOK) and (not FlgTooClose);
 end;
  Main.Landing.Visible:=True;
  Main.ScanBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_23' (* 'Scanning Sample Surface' *) );
  Main.ToolBtnLanding.Hint:=siLangLinked1.GetTextOrDefault('IDS_24' (* 'Landing' *) );
  Main.Camera.enabled:=True;
  Main.Camera.visible:=True;
  if FlgApproachOK  or flgtooClose then
  begin
   Main.ResonanceBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_25' (* 'Button is not enabled.The tip is too close a sample.' *) )+#13+siLangLinked1.GetTextOrDefault('IDS_20' (* 'It is recommended to make rising' *) )
  end
  else
  begin
    Main.ResonanceBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_27' (* 'Resonance frequence Measuring  and Setting' *) )
  end;
//  FreeAndNil(NanoEdu.ScannerApproach);
  Action := caFree;
  Approach:=nil;         { TODO : 190506 }
  if flgApproachOK and not flgCancel then Main.ScanningExecute(Sender);
end;

function TApproach.AverageSignalIndicator:apitype;
var i,Imax:integer;
    s:single;
  ITC:single;
begin
Imax:=30;
s:=0;
for i:=1 to IMax do
 begin
  ITC:=API.IT/IMax;//(GetCommonVar(ADC_IT));
  s:=s+ITC;
 end;
 Result:=apitype(round(s));
end;

procedure TApproach.TimerWakeUp(Sender: TObject);
var
 Z,SignalValue:apitype;
begin
  TimerUp.Enabled:=false;
//     ToolBarControl.enabled:=true;
     flgTimerActive:=True;
     Z:= NanoEdu.ZValue;
     if assigned(NanoEdu)        then  SignalValue:=NanoEdu.SignalValue;
     if assigned(ZIndicator )    then  ZIndicatorDraw(Z);
     if  not (CurrentUserLevel='Demo')then if ApproachParams.flgControlTopPosition and Nanoedu.UpperLimitOut then
      begin
       Beep;
       Inform:=TInform.Create(self);
       Inform.Caption:=siLangLinked1.GetTextOrDefault('IDS_28' { 'Warning!' } );
       Inform.Labelinf.Color:=clSilver;
       Inform.Labelinf.Font.Color:=clBlack;
       Inform.Labelinf.Caption:=siLangLinked1.GetTextOrDefault('IDS_29' { 'The step motor has achieved top position!' } )+#13+siLangLinked1.GetTextOrDefault('IDS_30' { 'Turn screw counter-clockwise by hand!!' } );
       Inform.Show;
       Application.ProcessMessages;
       sleep(1300);   { TODO : //170308 }
       Inform.close;
       sleep(1300);
      end;
 if assigned(SignalIndicator )  then   SignalDraw(SignalValue);
 if flgApproachOK then
  begin
   if assigned( ZIndicator) then
     with ZIndicator do
      if (value>HighLimit) then
          begin
          if flgApproachOK_justAchieved then
             MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_31' (* 'Error!!!' *) ) +#13+ siLangLinked1.GetTextOrDefault('IDS_32' (* 'False Occurence of Landing done message. Read FAQ' *) ), mtInformation,[mbOk,mbHelp],IDH_FAQR_Approach)
             else
             MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_69' (* 'Attention!' *) ) + #13+ siLangLinked1.GetTextOrDefault('IDS_52' (* 'You leave work zone!' *) ), mtInformation,[mbOk,mbHelp],IDH_FAQR_Approach);
             flgApproachOK:=false;
             BitBtnOK.Visible:=false;
             Main.Landing.Visible:=false;
          end
          else
         if (value<LowLimit) then
          begin
             MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_31' (* 'Error!!!' *) ) +#13+ siLangLinked1.GetTextOrDefault('IDS_4' (* 'Too close' *) ), mtInformation,[mbOk,mbHelp],IDH_FAQR_Approach);
             flgApproachOK:=false;
             BitBtnOK.Visible:=false;
             Main.Landing.Visible:=false;
          end;
  end;
  flgTimerActive:=False;
  flgApproachOK_justAchieved:=False;
//  TimerUp.Enabled:=true;
 if not flgStopTimer then
   if (Approach.WindowState=wsMinimized) then TimerUp.Enabled:=false else TimerUp.Enabled:=true;
end;


procedure TApproach.UpdateStrings;
begin
  strv := siLangLinked1.GetTextOrDefault('strstrv' (* 'Voltage Bias=0. Set Voltage' *) );

end;

procedure TApproach.OptionsBtnClick(Sender: TObject);
begin
if not assigned(ApproachOpt) then
begin
 ApproachOpt:=TApproachOpt.Create(Application,ApproachOpt);
 with ApproachOpt do
  begin
    ScanOptSheet.TabVisible:=False;
    ApprOptSheet.TabVisible:=True;
  end;
 end
 else  ApproachOpt.SetFocus;
end;

procedure TApproach.NormalizeUAM;
begin
    (Nanoedu as TSFMNanoEdu).NormalizeUAM;
    case STMFlg of
False:begin
       with SignalIndicator do
        begin
          Maximum:=ApproachParams.UAMMax;
          Value:=Maximum;
          HighLimit:=round(ApproachParams.LevelUAM*ApproachParams.UAMMax);
          LowLimit:= HighLimit;
        end;
      end;
TRUE: begin
      end;
        end;  //case
    flgBlickNorm:=False;
    Sleep(200);
end;

procedure TApproach.ExitBtnClick(Sender: TObject);
begin
ExitBtn.enabled:=false;
if  flgCanClose then
begin
 if not FlgTimerActive then
 begin
  TimerUp.Enabled:=false;
  FreeAndNil(TimerUp);
  flgCancel:=true;
  Close;
 end;
end
else ExitBtn.enabled:=true;
end;

procedure TApproach.NormBitBtnClick(Sender: TObject);
begin
 NormalizeUAM;
 NormBitBtn.Font.Color:=clBlack;
 flgMakeNormalize:=false;
 NormBitBTn.visible:=false;
end;

procedure TApproach.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    flgStopTimer:=true;
    CanClose := False;
   if not FlgStopApproach then
    begin
      MessageDlgCtr( siLangLinked1.GetTextOrDefault('IDS_33' (* 'Stop approach before exit!!!' *) ) , mtInformation,[mbOk],0);
    end
    else
    if assigned(SpectrWnd) then
     begin
      MessageDlgCtr( siLangLinked1.GetTextOrDefault('IDS_13' (* 'Close Spectroscopy window!!' *) ) , mtInformation,[mbOk],0);
    end
    else
    if   flgCanClose   then
     begin
       if not FlgTimerActive then
       begin
        if assigned(TimerUp) then
         begin
          TimerUp.Enabled:=false;
          sleep(500);
         end;
        CanClose := True;
       end
     (*  else
       begin
        flgStopTimer:=true;
        while  FlgTimerActive do
        begin
          sleep(100);
          application.processmessages;
        end;
        CanClose := True;
       end;
       *)
    end;
end;

procedure TApproach.BitBtnHelpClick(Sender: TObject);
begin
 (*  case RadioApproach.itemindex of
   0: begin if STMflg then HlpContext:=IDH_Landing_STM else HlpContext:=IDH_Landing_SFM{20} end;
   1: begin if STMflg then HlpContext:=IDH_Rising_STM  else HlpContext:=IDH_Rising{22}      end;
     end;
   *)
    begin if STMflg then HlpContext:=IDH_Landing_STM else HlpContext:=IDH_Landing_SFM{20} end;

   Application.HelpContext(HlpContext);
end;

procedure TApproach.BitBtnLogClick(Sender: TObject);
begin
{$IFDEF DEBUG}
//          EnumChannels;
{$ENDIF}
// ViewLogFile:=TViewLogFile.Create(Application,FlgStepResult);
end;

procedure TApproach.RadioApproachEnter(Sender: TObject);
begin
(*   case RadioApproach.itemindex of
   0: begin AddCaption:=siLangLinked1.GetTextOrDefault('IDS_8' {* ', Landing' *} ); RadioApproach.font.color:=clblack; edStepsCounter.Font.color:=clRed end;
   1: begin AddCaption:=siLangLinked1.GetTextOrDefault('IDS_35' {* ', Rising' *} );  RadioApproach.font.color:=clred;   edStepsCounter.Font.color:=clRed end;
     end;
  *)
  Caption:=MainCaption+AddCaption;
end;

procedure TApproach.RadioApproachClick(Sender: TObject);
begin
   edStepsCounter.Font.color:=clRed ;
 (*    case RadioApproach.itemindex of
    0: begin
           AddCaption:=siLangLinked1.GetTextOrDefault('IDS_8' {* ', Landing' *} );
           RadioApproach.font.color:=clblack;
           labelOneStep.Font.color:=clBlack;
       end;
    1: begin
          AddCaption:=siLangLinked1.GetTextOrDefault('IDS_35' {* ', Rising' *} );
          RadioApproach.font.color:=clred;
          labelOneStep.Font.color:=clRed;
       end;
                  end;

*)     Caption:=MainCaption+AddCaption;
     Application.ProcessMessages;
end;

procedure TApproach.BitBtnOKClick(Sender: TObject);
begin
 flgStopTimer:=true;
 if not FlgTimerActive then
  begin
   if assigned( TimerUp) then
    begin
     TimerUp.Enabled:=false;
     FreeAndNil(TimerUp);
    end;
(*   if not STMFlg then
   begin
     NanoEdu.ScannerApproach.SetScanSetPoint;
   end;
  *)
   flgCancel:=false;
   Close;
  end;
end;

(*procedure TApproach.BitBtnLogClick(Sender: TObject);
begin
  if  FileExists(ExeFilePath+'Animation\landing.swf') then
  begin
    ShockWave:=TShockWave.create(Sender,ExeFilePath+'Animation\landing.swf');
    ShockWave.Show;
    ShockWave.Caption:=siLangLinked1.GetTextOrDefault('IDS_40' { ' Landing' } );
    ShockWave.ShockwaveFlash.play;
 end;
end;
*)

procedure TApproach.BitBtnStepTestClick(Sender: TObject);
begin
 if not flgStopApproach then  begin  MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_41' (* 'Stop Landing!' *) ),mtwarning,[mbYes],0); exit end;
 {$IFNDEF FULL}
 if flgApproachOK then
 {$ENDIF}
 begin
  if flgCurrentUserLevel=Demo then
          begin
           MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_42' (* 'no Demo Data!!!' *) ), mtInformation,[mbOk],0);
           exit;
          end;
  TimerUp.Enabled:=false;
  BitBtnStepTest.Enabled:=false;
  StepsTest:= TStepsTest.Create(self);
  StepsTest.ShowModal;
  StepsTest:=nil;
  BitBtnStepTest.Enabled:=true;
  TimerUp.Enabled:=true;
 end
 {$IFNDEF FULL}
   else MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_43' (* 'No Interaction!' *) ),mtwarning,[mbYes],0);
 {$ENDIF}
end;

procedure TApproach.SignalsModeBtnBiasVClick(Sender: TObject);
begin
  SignalsMode.btnBiasVClick(Sender);

end;

procedure TApproach.SignalsModebtnSetPointClick(Sender: TObject);
begin
  SignalsMode.btnSetPointClick(Sender);
end;

procedure TApproach.SignalsModeButton1Click(Sender: TObject);
begin
  TimerBackUpState:=TimerUp.Enabled;
  flgStopTimer:=true;
  TimerUp.Enabled:=false;
  SignalsMode.BtnSetInterClick(Sender);
end;

procedure TApproach.SignalsModeButton2Click(Sender: TObject);
begin
  TimerBackUpState:=TimerUp.Enabled;
  flgStopTimer:=true;
  TimerUp.Enabled:=false;
  SignalsMode.BtnSetInterClick(Sender);
end;

procedure TApproach.siLangLinked1ChangeLanguage(Sender: TObject);
begin
 Application.ProcessMessages;
  UpdateStrings;
end;

procedure TApproach.FormCreate(Sender: TObject);
var tmpval:integer;
  NewItem:TMenuItem;
begin
  UpdateStrings;
//  FormVar := @AFormVar;
//  inherited Create(AOwner);
    Top:=TopStart;
    left:=(main.Clientwidth-Clientwidth) div 2;
    main.ComboBoxSFMSTM.Enabled:=false;
    Application.ProcessMessages;
    CheckBoxCamera.Checked:=ApproachParams.flgAutorunCamera;
    flgApproachOK_justAchieved:=false;
    flgTimerActive:=False;
    ApproachOneActive:=false;
    ApproachActive:=false; // true =start process
    ApproachOneActive:=false;
    FlgCancel:=true;  // false appproach ok - start scan
    flgCanClose:=true;
    siLangLinked1.ActiveLanguage:=Lang;
    signalsmode.siLangLinkedf1.ActiveLanguage:=lang;
    Addcaption:='';
    StepsCount:=0;
    StartStepsCount:=0;
    cl:=$000000FF;
    FlgStopApproach:=True; //do not move
    ActiveTag:=7;
    ApproachParams.FreqBandF:=3;
   // Signalsmode.FrequencyTrack.Position:=0;///!!!!OLa- PIDParams.Ti;// ApproachParams.FreqBandF;
    BitBtnLog.Visible:=false;
    PidParams.Ti:=PidParams.TiApproach;
    // FINE PID CONTROL
     SignalsMode.SpeedBtnFineTi.down:=false;
                   case  flgUnit of
ProBeam:begin
           SignalsMode.sbTi.max:=10000;     // 160317
        end;
              end;
    with PidParams do
    begin
      // rough
      SignalsMode.sbTi.Position:=round(PidParams.Ti);// round(SignalsMode.sbTi.Max*(abs(PidParams.Ti))/PidParams.TiAbsMax);
      NanoEdu.SetPIDParameters;
   (*   InitPIDFine(abs(Ti), TiAbsMax, pidTiL1, pidTiL2);
      with SignalsMode do
           sbTi.Position:= round(sbTi.Max*(abs(Ti)-pidTiL1)/(pidTiL2-pidTiL1));    *)
    end;
 {$IFDEF FULL}
     BitBtnStepTest.Visible:=false;
     BitBtnLog.Visible:=FALSE ;
 {$ENDIF}
    ScanOnProgr:=False;
    Main.ScanBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'Make Landing before Scanning a Sample Surface' *) );
    if  FlgApproachOK then
                         begin
                           NormBitBtn.Font.Color:=clBlack;
                           NormBitBtn.Enabled:=False;
                           end
                         else
                         begin
                           flgBlickNorm:=flgMakeNormalize;//NormBitBtn.Font.Color:=clRed;
                         end;
    ApprOnProgr:=True;
    edStepsCounter.Caption:='0';
    ZMaxAbility:=MaxApitype;  //nanoeduII   2

 //   NanoEdu.ApproachRegime;
//    NanoEdu.ScannerApproach.TurnOn;
    ZIndicator.Maximum:=ZMaxAbility;
    Zindicator.Hint:=siLangLinked1.GetTextOrDefault('IDS_51' (* 'the Indicator Z' *) );
    ZIndicator.HighLimit:=round(ApproachParams.ZGateMax*ZMaxAbility);
    ZIndicator.LowLimit:=round(ApproachParams.ZGateMin*ZMaxAbility);
    ZIndicator.OnSetLevelsValue:=SetZLevelsValue;
             case STMFlg of
  TRUE:  begin                //STM
            Label1.Visible:=True;
            Label2.Caption:=siLangLinked1.GetTextOrDefault('IDS_11' (* '  Tunneling' *) );
            label7.Caption:=siLangLinked1.GetTextOrDefault('IDS_12' (* 'Current' *) );
            LabelSignalMax.caption:='';
            LabelCur.Visible:=True;
            SignalsMode.tbSTM.TabVisible:=True;
            SignalsMode.tbSFM.TabVisible:=False;
            SignalsMode.tbSFMCUR.TabVisible:=False;
            SignalsMode.LabelFB.Caption:=FloatToStrf(PIDParams.Ti, fffixed,5,2);
    //        SignalsMode.btnSetPoint.Caption:=
  //                    FloatToStrF(ApproachParams.LandingSetPoint*ITCor,fffixed,5,2)+siLangLinked1.GetTextOrDefault('IDS_0' (* ' nA' *) );//101210
            SignalsMode.btnBiasV.Caption:=
                      FloatToStrF(ApproachParams.BiasV,fffixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_14' (* ' V' *) );
            NormBitBTn.Visible:=False;
            MainCaption:=siLangLinked1.GetTextOrDefault('IDS_15' (* 'Scanning Tunneling Microscope' *) );
            ITMax:=round(ApproachParams.LandingSetPoint*TransformUnit.nA_d); //101210
          with SignalIndicator do
           begin
       (*     if flgUnit<>pipette then
            begin
             tmpval:=round(ITMax*ApproachParams.ScaleMaxIT{/ITCor});
            if tmpval<=MaxApitype then Maximum:=round(ITMax*ApproachParams.ScaleMaxIT)//101210
                                  else
                                  begin Maximum:=MaxApitype{*ITCor}; ApproachParams.ScaleMaxIT:=1;  end;
             Value:=abs(ITMax);        //151210
            end
            else   *)
             OnSetLevelsValue:=SetITLevelsValue;
             OnSetPointValue:=SetITSetPointValue;
             SFM:=not STMflg;
             Maximum:=round(MaxAPiType*ApproachParams.MaxITindicator/100{*ITCor});//101210
             Value:=abs(ITMax*ITCor);
             Hint:=siLangLinked1.GetTextOrDefault('IDS_57' (* 'The indicator of a current' *) )+#13+
             siLangLinked1.GetTextOrDefault('IDS_58' (* 'Red line - the Setpoint' *) )+#13+
             siLangLinked1.GetTextOrDefault('IDS_59' (* 'Green Line- a level of the beginning of the control(IT Level)' *) );
             HighLimit:=round(abs(ApproachParams.LevelIT*TransformUnit.nA_d{*ITCor}));
           //  LowLimit:=round(ApproachParams.SetPoint*TransformUnit.nA_d{*ITCor});  //101210
             LowLimit:=round(ApproachParams.LandingSetPoint*TransformUnit.nA_d{*ITCor});   //edited 030616
            end;
           SignalsMode.btnSetPoint.Caption:=
           FloatToStrF(ApproachParams.LandingSetPoint*ITCor,fffixed,5,2)+siLangLinked1.GetTextOrDefault('IDS_0' (* ' nA' *) );//101210
 //
         end;
  False: begin           //SFM
              Label1.Visible:=False;
              Label2.Caption:=siLangLinked1.GetTextOrDefault('IDS_16' (* 'Probe Oscillation  ' *) );
              label7.Caption:=siLangLinked1.GetTextOrDefault('IDS_17' (* ' Amplitude' *) );
              LabelSignalMax.caption:='1';
              LabelCur.Visible:=true;//False;
              SignalsMode.tbSTM.TabVisible:=False;
              SignalsMode.tbSFM.TabVisible:=True;
              SignalsMode.tbSFMCUR.TabVisible:=False;
              SignalsMode.LabelFB.Caption:=FloatToStrf(PIDParams.Ti, fffixed,5,2);
              {$IFDEF FULL}
                  if flgUnit=Pipette  then
                  begin
                    SignalsMode.tbSTM.TabVisible:=False;
                    SignalsMode.tbSFM.TabVisible:=False;
                    SignalsMode.tbSFMCUR.TabVisible:=True;
                  end;
              {$ENDIF}
              SignalsMode.lbSuppress.Caption:=FloatToStrF((1-ApproachParams.LandingSetPoint),fffixed,4,2);
              SignalsMode.lbSuppressI.Caption:=FloatToStrF((1-ApproachParams.LandingSetPoint),fffixed,4,2);
               with SignalIndicator do
               begin
                  Maximum:=ApproachParams.UAMMax;
                  Value:=Maximum;
                  Hint:=siLangLinked1.GetTextOrDefault('IDS_62' (* 'the indicator of a Probe Oscillation Amplitude.' *) )+#13+
                  siLangLinked1.GetTextOrDefault('IDS_63' (* 'Red line - SetPoint;' *) )+#13+
                  siLangLinked1.GetTextOrDefault('IDS_64' (* 'Green line- a level of the beginning of the control(Probe Oscillation Level' *) );
                  HighLimit:=round(ApproachParams.LevelUAM*ApproachParams.UAMMax);
                  OnSetLevelsValue:=SetUAMLevelsValue;
                  OnSetPointValue:=SetUAMSetPointValue;
                  SFM:=not STMflg;
                  LowLimit:=round(ApproachParams.LandingSetPoint*ApproachParams.UAMMax);
               end;
              MainCaption:=siLangLinked1.GetTextOrDefault('IDS_65' (* 'Scanning Force Microscope; ' *) );
         end;
              end; //case;
              //nanoeduII
       case STMflg of
false:  NanoEdu.SetPoint:=ApproachParams.LandingSetPoint;
// true:  NanoEdu.SetPoint:=ApiType(round(ApproachParams.SetPoint*TransformUnit.nA_d));
true:  NanoEdu.SetPoint:=ApiType(round(ApproachParams.LandingSetPoint*TransformUnit.nA_d));
      end;

       ScrollBarTimeControl.Position:=ApproachParams.IntegratorDelay;
       lblTimeControl.Caption:=inttostr(ApproachParams.IntegratorDelay);
       ApproachParams.ZMax:=(CSPMSignals[7].MaxDiscr-CSPMSignals[7].MinDiscr)/TransformUnit.Znm_d;      //edited  03/06/16
       LabelZMax.caption:='1 ('+FloattoStrF((round(ApproachParams.ZMax/100)/10),ffFixed,4,1)+' '+mcrn+')';
       Caption:=MainCaption+AddCaption;
       Main.Landing.Visible:=False;
       Main.Resonance.visible:=False;
       NewItem := TMenuItem.Create(Self);
       NewItem.Caption :='-';
       Main.mWindows.Add(NewItem);
       NewItem := TMenuItem.Create(Self);
       NewItem.Caption := self.Caption;
       Main.mWindows.Add(NewItem);
       NewItem.OnClick:=Main.ActivateMenuItem;
       BitBtnOk.Visible:=FlgApproachOK;
       Main.Scanning.Visible:=FlgApproachOK;
            {$IFNDEF FULL}
                   BitBtnStepTest.Enabled:=FlgApproachOK;
           {$ENDIF}

    {$IFDEF DEBUG}
//          EnumChannels;
    {$ENDIF}
       flgStopTimer:=false;
       flgTimerActive:=false;
       TimerUp.enabled:=true;
       TimerUp.Interval:=300;//1000; //300
 
       case  flgUnit of
 baby,
 ProBeam,
 MicProbe: begin
       PanelPM.Visible:=true;
       ScrollBarPMTime.Position:=ApproachParams.PMActiveTime;
       LabelTimeVal.Caption:=inttostr(ScrollBarPMTime.Position);
       ScrollBarPMPause.Position:=ScrollBarPMPause.Max-ApproachParams.PMPause;
       ApproachParams.Speed:=(ApproachParams.PMActiveTime shl 4) +(ApproachParams.PMPause);
       LabelPauseVal.Caption:=inttostr(ScrollBarPMPause.Position);
       CheckBoxCamera.Enabled:=false;
       CheckBoxCamera.checked:=false;
       ApproachParams.flgAutorunCamera:=false;
      end;
grand:begin
       PanelPM.Visible:=false;
       ScrollBarPMTime.Position:=ApproachParams.PMActiveTime;
       LabelTimeval.Caption:=inttostr(ScrollBarPMTime.Position);
       ScrollBarPMPause.Position:=ApproachParams.PMPause;
       LabelPauseval.Caption:=inttostr(ScrollBarPMPause.Position);
     end;
Pipette:
        begin
         PanelPM.Visible:=false;
        end;
Nano:   begin
         PanelPM.Visible:=false;
        end;
Terra:  begin
           PanelPM.Visible:=true;
           ScrollBarPMTime.Position:=ApproachParams.PMActiveTime;
           LabelTimeVal.Caption:=inttostr(ScrollBarPMTime.Position);
           ScrollBarPMPause.Position:=ApproachParams.PMPause;
           ApproachParams.Speed:=(ApproachParams.PMActiveTime shl 4) +(ApproachParams.PMPause);
           LabelPauseVal.Caption:=inttostr(ScrollBarPMPause.Position);
        end;
                 end; //case
end;

procedure TApproach.StopBtnClick(Sender: TObject);
begin
  Caption:=MainCaption;
 if not ApproachOneActive  then
  if not FlgStopApproach then
  begin
   ToolBarControl.enabled:=false;
   Application.ProcessMessages;
//  if assigned(Nanoedu.Method) then
//   begin
    flgStopJava:=true;
//    Nanoedu.Method.StopWork
//   end;
  // ToolBarControl.enabled:=true;
  end;
  ActiveTag:=TControl(Sender).tag;
end;

procedure TApproach.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
    if (ssCtrl in Shift) then
     if (Key=ord('V')) then
      begin
          BitBtnStepTest.Visible:= not BitBtnStepTest.Visible;
      end;
end;

procedure TApproach.FormResize(Sender: TObject);
begin
//     ToolBarControl.ButtonWidth:=ToolBarControl.ClientWidth div 7;

end;

procedure TApproach.FormShow(Sender: TObject);
begin
//do not delete is correct gluck for english languige
   width:=width+1;
end;

procedure TApproach.StartBtnOneStepDownClick(Sender: TObject);
var ltag:word;
begin
 ltag:=TControl(Sender).tag;
if (ltag = 3) and  (not CheckResonance) then exit;

TControl(sender).Enabled:=false;
// ToolBarControl.enabled:=false;     //161211
 Application.processmessages;
 if ApproachActive then
 begin
    MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_41' (* 'Stop Landing!!' *) ),mtWarning ,[mbOK],0);
  //  ToolBarControl.enabled:=true;   //161211
    TControl(sender).Enabled:=true;
    TToolButton(sender).down:=false;
    case ActiveTag of
1:   StartBTndown.Down:=true;
2:   StartBTnFastdown.Down:=true;
4:   StartBTnUp.Down:=true;
5:   StartBTnFastUp.Down:=true;
    end;
//    ToolBarControl.enabled:=true;
    Application.processmessages;
    exit;
 end;
// ExitBtn.enabled:=false;
 FlgCanClose:=false;
 ApproachActive:=false;
 ApproachOneActive:=true;
 ApproachParams.flgOneStep:=true;
// Application.ProcessMessages;
// SetDemoParamsDef;

      case  ltag of
6:begin
     //Rising
     OneStep(1);
  end;
3:begin

     OneStep(-1);
  end;
     end;
 AddCaption:='';
 Caption:=MainCaption+AddCaption;
 ApproachParams.flgOneStep:=false;
 TToolButton(sender).down:=false;
 StopBtn.Down:=true;
 FlgCanClose:=true;
 ApproachOneActive:=false;
// ToolBarControl.enabled:=true;     //161211
 TControl(sender).Enabled:=true;
 Application.ProcessMessages;
end;

procedure  TApproach.TestContact;
begin



end;
procedure TApproach.OneStep(n:apitype);
var
     val,i:integer;
     z:apitype;
      z1demo:integer;
begin
 flgTooClose:=false;
//  ApproachParams.ZStepsNumb:=n;
 if (FlgCurrentUserLevel = Demo) and flgapproachOK {and (flgApproach <>}  then
 begin
 if n<0 then      // 1Step landing
    begin
      z1demo:= DemoParams.Z +1500;         // DemoParams.Z < 0
      if z1demo < MinApitype then   z1demo:= MinApitype;
      DemoParams.Z:=z1demo;
    end
    else
    begin
      z1demo:= DemoParams.Z -1500;         // DemoParams.Z < 0
      if z1demo < MinApitype then   z1demo:= MinApitype;
      DemoParams.Z:=z1demo;
    end  ;
    inc(ApproachParams.ZStepsDone, n);
    inc(Approach.StepsCount,n);
 end;

 if  FlgStopApproach then
  begin
    FlgStopApproach:=False;
    TimerUp.Enabled:=false;
   if assigned(ApproachOpt) then
    begin
     ApproachOpt.ScanCorSheet.enabled:=false;
     ApproachOpt.HardWareSheet.enabled:=false;
    end;
    Main.ComboBoxSFMSTM.Enabled:=false;
    BitBtnOK.Visible:=False;
//    SignalsMode.FrequencyTrack.Enabled:=False;

    NanoEdu.RisingToStartPoint(n);

  //  Sleep(ApproachParams.IntegratorDelay);

//     TimerUp.Enabled:=true;
//     PostMessage(Handle,wm_ThreadDoneMsg,mScanning,0);

     Application.ProcessMessages;
     
     TestZGate(n);
     StepsCount:=StepsCount+n;
     edStepsCounter.Caption:=Format('%d',[-StepsCount]);
   if assigned(ApproachOpt) then
    begin
     ApproachOpt.ScanCorSheet.enabled:=true;
     ApproachOpt.HardWareSheet.enabled:=true;
    end;
    StartStepsCount:=StepsCount;
   Main.ComboBoxSFMSTM.Enabled:=not (FlgApproachOK and STMflg);
//   SignalsMode.FrequencyTrack.Enabled:=True;
   NormBitBtn.Enabled:=True;
   FlgStopApproach:=True;
   TimerUp.enabled:=true;
  end;
 end;


procedure TApproach.ScrollBarPMTimeScroll(Sender: TObject;  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
    ApproachParams.PMActiveTime:=ScrollPos;
    LabelTimeval.Caption:=inttostr(scrollpos);
    ApproachParams.Speed:=(ApproachParams.PMActiveTime shl 4) +(ApproachParams.PMPause);
   if assigned (Nanoedu.Method) then   Nanoedu.Method.SetUsersParams;
end;

procedure TApproach.ScrollBarTimeControlScroll(Sender: TObject; ScrollCode: TScrollCode;  var ScrollPos: Integer);
begin
case ScrollCode of
  scEndScroll: begin
                 ApproachParams.IntegratorDelay:=ScrollPos;
                 lblTimeControl.Caption:=inttostr(ApproachParams.IntegratorDelay);
                 if Assigned(Nanoedu.Method) and (Nanoedu.Method is TApproachSFM) then Nanoedu.Method.SetUsersParams;
               end;
         end; 
end;

procedure TApproach.ScrollBarPMPauseScroll(Sender: TObject;  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
    ApproachParams.PMPause:=ScrollBarPMPause.Max-ScrollPos;
    LabelPauseval.Caption:=inttostr(scrollpos);
    ApproachParams.Speed:=(ApproachParams.PMActiveTime shl 4) +(ApproachParams.PMPause);
   if assigned (Nanoedu.Method) then   Nanoedu.Method.SetUsersParams;
end;

function TApproach.CheckResonance:boolean;
begin
Result:=True;
if STMFlg then  exit;
if not FlgResonance then
       begin
          MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_66' (* 'Make Resonance before Landing!' *) ),mtWarning ,[mbOK],0);
          Result:=false;
       end;
end;
end.

