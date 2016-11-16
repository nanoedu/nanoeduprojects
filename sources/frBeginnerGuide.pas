unit frBeginnerGuide;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,CSPMVar, siComp, siLngLnk,
  ToolWin;

type
  TFrBeginner = class(TForm)
    PlUp: TPanel;
    PlBottom: TPanel;
    PanelApproach: TPanel;
    LbSteps: TLabel;
    LabelMain: TLabel;
    RadioGApproach: TRadioGroup;
    Panel2: TPanel;
    ComboBoxSFMSTM: TComboBox;
    PageCtrlGuide: TPageControl;
    TabSheetStart: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    LabelSteps: TLabel;
    siLangLinked1: TsiLangLinked;
    ToolBar: TToolBar;
    StartBtn: TToolButton;
    StopBtn: TToolButton;
    ToolBar2: TToolBar;
    HelpBtn: TToolButton;
    BitBtnNext: TBitBtn;
    BitBtnPrev: TBitBtn;
    procedure StopBtnClick(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBoxSFMSTMSelect(Sender: TObject);
    procedure BitBtnNextClick(Sender: TObject);
    procedure BitBtnPrevClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RadioGApproachClick(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
  private
    { Private declarations }
    StepGuide:integer;
    stepCount,EndStep:Integer;
    procedure InitApproach;
    procedure InitScan;
    procedure InitFast;
    procedure StartFastApproach;
    procedure FindResonance;
    procedure StartApproach;
    procedure StartScan;
    procedure ComponentVisible;
    procedure GradientRect(FromRGB, ToRGB: TColor;Canvas:tcanvas);
  public
    { Public declarations }
    procedure SetMoveAway;
    procedure UserMessage (var Msg: TMessage); message wm_userclosevideo;
end;

var
  FrBeginner: TFrBeginner;

implementation

uses GlobalType,GlobalVar,GlobalFunction,SioCSPM,UNanoEduBaseClasses,uNanoEduBaseMethodClass,UNanoEduClasses,nanoeduhelp,SystemConfig,uScannerCorrect,mMain,frProgress,frChangeDir,
     frScanWnd,Video,UfindProcess, FrInform;
const
	strb9: string = ''; (* error free cspmlib *)
	strb10: string = ''; (* Fast landing done. Make landing  *)
	strb11: string = ''; (* Error!! *)
	strb12: string = ''; (* Tip too close to a sample! *)
	strb13: string = ''; (* Verify landing option or physical unit state. *)
	strb14: string = ''; (* Do you want to rise the probe in a save place? *)
	strb15: string = ''; (* Attention!!! *)
	strb16: string = ''; (* The step motor has achieved top position! *)
	strb17: string = ''; (* Turn screw counter-clockwise by hand!! *)
	strb18: string = ''; (* The Scanner Resonance Frequency is not found. *)
	strb19: string = ''; (* Pass to the level for advanced user(A)!! *)
	strb20: string = ''; (* Make Normalize before Start! *)
	strb21: string = ''; (* Landing done *)
	strb22: string = ''; (* Tip too close to a sample! *)
	strb23: string = ''; (* Verify landing option or physical unit state. *)
	strb24: string = ''; (* Do You want to rise the probe in a save place? *)
	strb25: string = ''; (* Attention!!! *)
	strb26: string = ''; (* The step motor has achieved top position! *)
	strb27: string = ''; (* Turn screw counter-clockwise by hand!! *)
	strb28: string = ''; (* Library MSVideoLib.dll Load Error *)
	strb29: string = ''; (* !; Connect the Camera or Test USB Connection  *)
	strb1: string = ''; (* Attention!!! *)
	strb2: string = ''; (* The step motor has achieved top position! *)
	strb3: string = ''; (* Turn screw counter-clockwise by hand!! *)
	strb4: string = ''; (* Attention! STM is intendend for working with conductive samples, otherwise the probe will be destroyed!! *)
	strb5: string = ''; (* Stop Scanning! *)
	strb6: string = ''; (* Stop approach before exit!!! *)
	strb7: string = ''; (* Stop Scanning before exit!!! *)
	strb8: string = ''; (* Move probe away!! *)

  {$R *.dfm}
procedure TFrBeginner.GradientRect(FromRGB, ToRGB: TColor;Canvas:tcanvas);
var
    RGBFrom : array[0..2] of Byte; { from RGB values }
    RGBDiff : array[0..2] of integer; { difference of from/to RGB values }
     I : Integer; { color band index }
     R : Byte; { a color band's R value }
     G : Byte; { a color band's G value }
     B : Byte; { a color band's B value }
     h,h0:integer;
      ColorBand : TRect;
begin
  { extract from RGB values}
  RGBFrom[0] := GetRValue (ColorToRGB (FromRGB));
  RGBFrom[1] := GetGValue (ColorToRGB (FromRGB));
  RGBFrom[2] := GetBValue (ColorToRGB (FromRGB));
  { calculate difference of from and to RGB values}
  RGBDiff[0] := GetRValue (ColorToRGB (ToRGB)) - RGBFrom[0];
  RGBDiff[1] := GetGValue (ColorToRGB (ToRGB)) - RGBFrom[1];
  RGBDiff[2] := GetBValue (ColorToRGB (ToRGB)) - RGBFrom[2];
    ColorBand.Left := 0;
   ColorBand.Right:=Canvas.ClipRect.Right-Canvas.ClipRect.left;

  { set pen sytle and mode}
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Mode := pmCopy;
  h0:=(canvas.ClipRect.Bottom-Canvas.ClipRect.Top);
  h:=h0;//-round(h0*(Ztop+255-Zbottom)/255);
  { set color band's left and right coordinates}
   for I := 0 to $ff do
     begin
      { calculate color band's top and bottom coordinates}
      { calculate color band color}
      ColorBand.Top :=h-MulDiv (I , h, $100);
      ColorBand.Bottom :=h-MulDiv (I + 1,h, $100);

       R := round(RGBFrom[0] + MulDiv (round(255*RDistr[I+1]), RGBDiff[0], $ff));
       G :=  round(RGBFrom[1] +MulDiv (round(255*GDistr[I+1]), RGBDiff[1], $ff));
       B :=  round(RGBFrom[2] +MulDiv (round(255*BDistr[I+1]), RGBDiff[2], $ff));
         { select brush and paint color band}
       Canvas.Brush.Color := RGB (R, G, B);
       Canvas.FillRect (ColorBand);
     end;
end;

procedure  TFrBeginner.ComponentVisible;
begin
   case StepGuide of
0: begin
    labelMain.Caption:='';
    RadioGApproach.Visible:=false;
    lbSteps.Visible:=false;
    LabelSteps.Visible:=false;
    ToolBar.Visible:=false;
    ComboBoxSFMSTM.Visible:=true;
    BitBtnNext.Enabled:=true;
    BitBtnPrev.Enabled:=false;
    labelMain.Caption:=siLangLinked1.GetTextOrDefault('IDS_7' (* 'Unit' *) );
   end;
1,2:begin
       case RadioGApproach.ItemIndex of
    0: labelMain.Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* '  Landing' *) );
    1: labelMain.Caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* '  Rising' *) );
            end;
    RadioGApproach.Visible:=true;
    lbSteps.Visible:=true;
    LabelSteps.Visible:=true;
    ToolBar.Visible:=true;
    ComboBoxSFMSTM.Visible:=false;
    BitBtnNext.Enabled:=true;
    BitBtnPrev.Enabled:=true;
   end;
3: begin
    labelMain.Caption:=siLangLinked1.GetTextOrDefault('IDS_2' (* ' Scanning' *) );
    RadioGApproach.Visible:=false;
    lbSteps.Visible:=false;
    LabelSteps.Visible:=false;
    ToolBar.Visible:=false;
    ComboBoxSFMSTM.Visible:=false;
    BitBtnNext.Enabled:=false;
    BitBtnPrev.Enabled:=true;
   end;
      end;
end;

procedure TFrBeginner.UpdateStrings;
begin
  strb21 := siLangLinked1.GetTextOrDefault('strstrb21');
  strb8 := siLangLinked1.GetTextOrDefault('strstrb8');
  strb7 := siLangLinked1.GetTextOrDefault('strstrb7');
  strb6 := siLangLinked1.GetTextOrDefault('strstrb6');
  strb5 := siLangLinked1.GetTextOrDefault('strstrb5');
  strb4 := siLangLinked1.GetTextOrDefault('strstrb4');
  strb3 := siLangLinked1.GetTextOrDefault('strstrb3');
  strb2 := siLangLinked1.GetTextOrDefault('strstrb2');
  strb1 := siLangLinked1.GetTextOrDefault('strstrb1');
  strb29 := siLangLinked1.GetTextOrDefault('strstrb29');
  strb28 := siLangLinked1.GetTextOrDefault('strstrb28');
  strb27 := siLangLinked1.GetTextOrDefault('strstrb27');
  strb26 := siLangLinked1.GetTextOrDefault('strstrb26');
  strb25 := siLangLinked1.GetTextOrDefault('strstrb25');
  strb24 := siLangLinked1.GetTextOrDefault('strstrb24');
  strb23 := siLangLinked1.GetTextOrDefault('strstrb23');
  strb22 := siLangLinked1.GetTextOrDefault('strstrb22');
  strb20 := siLangLinked1.GetTextOrDefault('strstrb20');
  strb19 := siLangLinked1.GetTextOrDefault('strstrb19');
  strb18 := siLangLinked1.GetTextOrDefault('strstrb18');
  strb17 := siLangLinked1.GetTextOrDefault('strstrb17');
  strb16 := siLangLinked1.GetTextOrDefault('strstrb16');
  strb15 := siLangLinked1.GetTextOrDefault('strstrb15');
  strb14 := siLangLinked1.GetTextOrDefault('strstrb14');
  strb13 := siLangLinked1.GetTextOrDefault('strstrb13');
  strb12 := siLangLinked1.GetTextOrDefault('strstrb12');
  strb11 := siLangLinked1.GetTextOrDefault('strstrb11');
  strb10 := siLangLinked1.GetTextOrDefault('strstrb10');
  strb9 := siLangLinked1.GetTextOrDefault('strstrb9');

end;

procedure TFrBeginner.UserMessage (var Msg: TMessage);
begin
 Application.ProcessMessages;
 FreeLibrary( LibVideoHandle);
 libVideoHandle:=0;
end;

procedure TFrBeginner.InitScan;
begin
//   NanoEdu.ScannerApproach.SetScanSetPoint;
//   FreeAndNil(NanoEdu.ScannerApproach);
   ScanWND:=TScanWND.Create(Application);
end;

(*procedure TFrBeginner.StartFastApproach;
var  FlgStatusStep:Byte;
begin
 if (RadioGApproach.ItemIndex=1) then        //   Rising
 begin
  ApproachParams.ZStepsNumb:=ApproachParams.ZUpStepsNumb;//ZFastStepsNumb;
 end
 else
 begin                //Landing
   ApproachParams.ZStepsNumb:=-ApproachParams.ZFastStepsNumb;
 end;
if not FlgStopApproach then
  begin
   NanoEdu.ScannerApproach.StopSteps;
   RadioGApproach.Enabled:=true;
   if StepGuide<>3 then BitBtnNext.Enabled:=true;
   if StepGuide<>0 then BitBtnPrev.Enabled:=true;
   StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_3' { '&RUN' } ) ;
   StartBtn.Glyph.Assign(BitMapStart);
   StartBtn.Font.Color:=clBlack;
   StartBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_4' {* 'Run Fast Landing' *} );
   StartBtn.Enabled:=True;
   FlgStopApproach:=True;
  end
 else
  begin
    //steps
    FlgStopApproach:=False;
    RadioGApproach.Enabled:=false;
    FlgApproachOK:=False;
    StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_5' {* '&STOP' *} ) ;
    StartBtn.Glyph.Assign(BitMapStop);
    StartBtn.Font.Color:=clRed;
    StartBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_6' {* 'Stop Fast Landing' *} );
    if StepGuide<>3 then BitBtnNext.Enabled:=false;
    if StepGuide<>0 then BitBtnPrev.Enabled:=false;
   if  NanoEdu.ScannerApproach.InitSteps>0 then  //error
    begin
      StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_3' {* '&RUN' *} ) ;
      StartBtn.Glyph.Assign(BitMapStart);
      StartBtn.Font.Color:=clBlack;
      StartBtn.Enabled:=true;
      FlgStopApproach:=True;
      RadioGApproach.Enabled:=true;
      if StepGuide<>3 then BitBtnNext.Enabled:=true;
      if StepGuide<>0 then BitBtnPrev.Enabled:=true;
      exit;
    end;
  repeat     // make steps
    begin
           FlgStatusStep:=NanoEdu.ScannerApproach.Step;
           StartBtn.Enabled:=true;
           Application.ProcessMessages;
     case FlgStatusStep of
       3: begin           //ok
             beep;
             StepCount:=StepCount+ ApproachParams.ZStepsNumb;
             labelSteps.Caption:=Format('%d',[-StepCount]);
              beep;
              MessageDlgCtr('Fast landing done. Make landing ', mtInformation,[mbOk],0);
              FlgStopApproach:=True;
              FlgApproachOK:=True;
          end;
       2: begin                //too close
            beep;
            StepCount:=StepCount+ ApproachParams.ZStepsNumb;
            labelSteps.Caption:=Format('%d',[-StepCount]);
            MessageDlgCtr('Error!! Tip too close to a sample.'+#13+' Make rising or test parameters',mtWarning ,[mbOK,mbHelp],IDH_error_landing_option);
            FlgStopApproach:=True;
          end;                      //too close
       4: begin    //out boundary
            FlgStopApproach:=True;
            StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_3' {* '&RUN' *} ) ;
            StartBtn.Glyph.Assign(BitMapStart);
            StartBtn.Font.Color:=clBlack;
            Beep;
            MessageDlgCtr('Attention!!!'+#13+'The step motor has achieved top position!'+#13+'Turn screw counter-clockwise by hand!!', mtInformation,[mbOk],IDH_Probe_is_too_High);
          end;
                    end;                //case
          StepCount:=StepCount+ApproachParams.ZStepsNumb;
          labelSteps.Caption:=Format('%d',[-StepCount]);
     end;
  until FlgStopApproach;
    StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_3' {* '&RUN' *} );
    StartBtn.Glyph.Assign(BitMapStart);
    StartBtn.Font.Color:=clBlack;
    StartBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_19' {* 'Start Fast Landing' *} ) ;
      { TODO : 240506 }
    StartBtn.Enabled:=True;
    RadioGApproach.Enabled:=true;
    if StepGuide<>3 then BitBtnNext.Enabled:=true;
    if StepGuide<>0 then BitBtnPrev.Enabled:=true;
 end;
end;
*)
procedure TFrBeginner.StartFastApproach;
var  lFlgStatusStep:apitype;
begin
(* if (RadioGApproach.ItemIndex=1) then        //   Rising
 begin
  ApproachParams.ZStepsNumb:=ApproachParams.ZUpStepsNumb;//ZFastStepsNumb;
 end
 else
 begin                //Landing
   ApproachParams.ZStepsNumb:=-ApproachParams.ZFastStepsNumb;
 end;
if FlgStopApproach then
  begin
    //steps
    FlgStopApproach:=False;
    RadioGApproach.Enabled:=false;
    FlgApproachOK:=False;
    StartBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_6' { 'Stop Fast Landing' } );
    if StepGuide<>3 then BitBtnNext.Enabled:=false;
    if StepGuide<>0 then BitBtnPrev.Enabled:=false;
   if  NanoEdu.ScannerApproach.InitSteps(ApproachNScrpt)>0 then  //error
    begin
      FlgStopApproach:=True;
      RadioGApproach.Enabled:=true;
      StartBtn.down:=false;
      StopBtn.down:=true;
      if StepGuide<>3 then BitBtnNext.Enabled:=true;
      if StepGuide<>0 then BitBtnPrev.Enabled:=true;
      exit;
    end;
  repeat     // make steps
    begin
           lFlgStatusStep:=NanoEdu.ScannerApproach.Step;
           Application.ProcessMessages;
     case lFlgStatusStep of
       3: begin           //ok
             beep;
             StepCount:=StepCount+ ApproachParams.ZStepsNumb;
             labelSteps.Caption:=Format('%d',[-StepCount]);
              beep;
              MessageDlgCtr(strb10{'Fast landing done. Make landing '}, mtInformation,[mbOk],0);
              FlgStopApproach:=True;
              FlgApproachOK:=True;
          end;
       2: begin                //too close
            beep;
             if  MessageDlgCtr(strb11{'Error!!'}+#13+strb12{'Tip too close to a sample!'}+#13+strb13{'Verify landing option or physical unit state.'}+#13+strb14{'Do you want to rise the probe in a save place?'},mtWarning ,[mbYes,mbNo,mbHelp],IDH_error_landing_option)=mrYes then
             begin
               Application.ProcessMessages;
               NanoEdu.ScannerApproach.RisingToStartPoint(20);
               StepCount:=StepCount+ ApproachParams.ZStepsNumb+20;
             end;
             Application.ProcessMessages;
             labelSteps.Caption:=Format('%d',[-StepCount]);
      //      flgTooClose:=false;
             FlgStopApproach:=True;
          end;                      //too close
       4: begin    //out boundary
            FlgStopApproach:=True;
            Beep;
            MessageDlgCtr(strb15{'Attention!!!'}+#13+strb16{'The step motor has achieved top position!'}+#13+strb17{'Turn screw counter-clockwise by hand!!'}, mtInformation,[mbOk],IDH_Probe_is_too_High);
          end;
                    end;                //case
          StepCount:=StepCount+ApproachParams.ZStepsNumb;
          labelSteps.Caption:=Format('%d',[-StepCount]);
     end;
  until FlgStopApproach;
    StartBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_19' { 'Start Fast Landing' } ) ;
      { TODO : 240506 }
    StartBtn.Enabled:=True;
    StartBtn.down:=false;
    StopBtn.down:=true;
    RadioGApproach.Enabled:=true;
    if StepGuide<>3 then BitBtnNext.Enabled:=true;
    if StepGuide<>0 then BitBtnPrev.Enabled:=true;
 end;*)
end;

procedure TFrBeginner.FindResonance;
var ampl:single;
    val:word;
    stepval:apitype;
label 100;
begin
(*   if not STMFlg and not FlgApproachOK then
    Begin
     StartBtn.enabled:=false;
(*    (NanoEdu as TSFMNanoEdu).ResonanceRegime;
    (NanoEdu as TSFMNanoEdu).ScannerResonance.TurnOnSD;
   if (NanoEdu as TSFMNanoEdu).ScannerResonance.GetAmplitudes(Rough)>0 then exit;
     ampl:=(NanoEdu as TSFMNanoEdu).ScannerResonance.UMax/TransformUnit.Uv_d16;
   if (ampl>1.5)and (ampl<8) then goto 100;
     stepval:=20;
     if (ampl>=8) then stepval:=-20;
     val:=ApproachParams.Gain_AM;
    repeat
     begin
      val:=val+stepval;
      if (val >255) or (val<0) then
      begin
        MessageDlgCtr(strb11{'Error!!'}+#13+strb18{'The Scanner Resonance Frequency is not found.'}+#13+strb19{'Pass to the level for advanced user(A)!!'},mtwarning,[mbOk],0);
        StartBtn.enabled:=true;
        exit;
      end;
      ApproachParams.Gain_AM:=val;
      with  (NanoEdu as TSFMNanoEdu).ScannerResonance do
      begin
        Gain_AM:=ApproachParams.Gain_AM;
        if GetAmplitudes(Rough)>0 then exit;
        ampl:=(NanoEdu as TSFMNanoEdu).ScannerResonance.UMax/TransformUnit.Uv_d16;
      end;
     end;
    until (ampl>1.5) and (ampl<8) ;

100: if (NanoEdu as TSFMNanoEdu).ScannerResonance.GetAmplitudes(Fine)>0  then exit;
        (NanoEdu as TSFMNanoEdu).ScannerResonance.Qres;
    (NanoEdu as TSFMNanoEdu).NormalizeUAM;
     FreeAndNil((NanoEdu as TSFMNanoEdu).ScannerResonance);

     NanoEdu.ResonanceMethod;
    if NanoEdu.Method.Launch<>0 then     StartBtn.enabled:=true;
    end;
    *)
end;

(*procedure TFrBeginner.StartApproach;
 var
    FlgStatusStep:byte;
    i,n:integer;
    z:Integer;
    dx:WORD;
begin
 dx:=1;
 flgApproachOk:=False;
 if (RadioGApproach.ItemIndex=1) then        //   Rising
 begin
  ApproachParams.ZStepsNumb:=ApproachParams.ZUpStepsNumb;
  FlgApproachOK:=False;         //Rising
 end
 else
 begin                //Landing
    ApproachParams.ZStepsNumb:=-1;
  if not STMflg then
   if FlgMakeNormalize  then
    begin
     MessageDlgCtr('Make Normalize before Start!',mtWarning ,[mbOK,mbHelp],IDH_Landing); exit
    end;
 end;
 if not FlgStopApproach then    //stop
  begin
   Nanoedu.ScannerApproach.StopSteps;
   RadioGApproach.Enabled:=true;
   if StepGuide<>3 then BitBtnNext.Enabled:=true;
   if StepGuide<>0 then BitBtnPrev.Enabled:=true;
   StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_3' {* '&RUN' *} ) ;
   StartBtn.Glyph.Assign(BitMapStart);
   StartBtn.Font.Color:=clBlack;
   FlgStopApproach:=True;
  end
 else
  begin                     //steps
    FlgStopApproach:=False;
    FlgApproachOK:=False;
    n:= NanoEdu.ScannerApproach.Nsteps;
    StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_5' {* '&STOP' *} ) ;
    StartBtn.Glyph.Assign(BitMapStop);
    StartBtn.Font.Color:=clRed;
    RadioGApproach.Enabled:=false;
    if StepGuide<>3 then BitBtnNext.Enabled:=false;
    if StepGuide<>0 then BitBtnPrev.Enabled:=false;
    if  NanoEdu.ScannerApproach.InitSteps>0 then  //error
    begin
      StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_3' {* '&RUN' * ) ;
      StartBtn.Glyph.Assign(BitMapStart);
      StartBtn.Enabled:=true;
      StartBtn.Font.Color:=clBlack;
      FlgStopApproach:=True;
      RadioGApproach.Enabled:=true;
      if StepGuide<>3 then BitBtnNext.Enabled:=true;
      if StepGuide<>0 then BitBtnPrev.Enabled:=true;
      exit;
    end;
    FlgApproachOK:=false;
    repeat     // make steps
      begin
         FlgStatusStep:=NanoEdu.ScannerApproach.Step;
         Application.ProcessMessages;
         StartBtn.Enabled:=true;
          case FlgStatusStep of
      3: begin           //ok
            beep;
            StepCount:=StepCount+ApproachParams.ZStepsNumb;
            LabelSteps.Caption:=Format('%d',[-StepCount]);
            case STMFlg of
     False: begin
            end;
      TRUE: begin
            end;
               end; //case
             for i:=0  to 5 do beep;
               MessageDlgCtr('Landing done', mtInformation,[mbOk],0);
               FlgStopApproach:=True;
               FlgApproachOK:=True;
            end;
      2: begin                //too close
            beep;
            StepCount:=StepCount+ApproachParams.ZStepsNumb;
            LabelSteps.Caption:=Format('%d',[-StepCount]);
              case STMFlg of
     False: begin
            end;
      TRUE: begin
            end;
               end; //case
               MessageDlgCtr('Error!! Tip too close to a sample.'+#13+'Verify landing option or physical unit state ',mtWarning ,[mbOK,mbHelp],IDH_error_landing_option);
               FlgStopApproach:=True;
          end;                      //too close
       4: begin    //out boundary
            FlgStopApproach:=True;
            StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_3' {* '&RUN' *} ) ;
            StartBtn.Glyph.Assign(BitMapStart);
            StartBtn.Font.Color:=clBlack;
            Beep;
            MessageDlgCtr('Attention!!!The step motor has achieved top position!'+#13+'Turn screw counter-clockwise by hand!!', mtInformation,[mbOk],IDH_Probe_is_too_High);
          end;
                     end;                //case
          StepCount:=StepCount+ApproachParams.ZStepsNumb;
          LabelSteps.Caption:=Format('%d',[-StepCount]);
                case STMFlg of
     False: begin
            end;
      TRUE: begin
            end;
               end; //case
        end;
    until FlgStopApproach;

    StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_3' {* '&RUN' *} );
    StartBtn.Glyph.Assign(BitMapStart);
    RadioGApproach.Enabled:=true;
    StartBtn.Enabled:=true;
    if StepGuide<>3 then BitBtnNext.Enabled:=true;
    if StepGuide<>0 then BitBtnPrev.Enabled:=true;
    StartBtn.Font.Color:=clBlack;
   end; 
end;
*)
procedure TFrBeginner.StartApproach;
 var
    lFlgStatusStep:apitype;
    i,n:integer;
    z:Integer;
    dx:WORD;
begin
(* dx:=1;
 flgApproachOk:=False;
 if (RadioGApproach.ItemIndex=1) then        //   Rising
 begin
  ApproachParams.ZStepsNumb:=ApproachParams.ZUpStepsNumb;
  FlgApproachOK:=False;         //Rising
 end
 else
 begin                //Landing
    ApproachParams.ZStepsNumb:=-1;
  if not STMflg then
   if FlgMakeNormalize  then
    begin
     MessageDlgCtr(strb20{'Make Normalize before Start!'},mtWarning ,[mbOK,mbHelp],IDH_Landing); exit
    end;
 end;
if  FlgStopApproach then
  begin                     //steps
    FlgStopApproach:=False;
    FlgApproachOK:=False;
    n:= NanoEdu.ScannerApproach.Nsteps;
    RadioGApproach.Enabled:=false;
    if StepGuide<>3 then BitBtnNext.Enabled:=false;
    if StepGuide<>0 then BitBtnPrev.Enabled:=false;
    if  NanoEdu.ScannerApproach.InitSteps(ApproachNScrpt)>0 then  //error
    begin
      FlgStopApproach:=True;
      RadioGApproach.Enabled:=true;
      StartBtn.down:=false;
      StopBtn.down:=true;
      if StepGuide<>3 then BitBtnNext.Enabled:=true;
      if StepGuide<>0 then BitBtnPrev.Enabled:=true;
      exit;
    end;
    FlgApproachOK:=false;
    repeat     // make steps
      begin
         lFlgStatusStep:=NanoEdu.ScannerApproach.Step;
         Application.ProcessMessages;
          case lFlgStatusStep of
      3: begin           //ok
            beep;
            StepCount:=StepCount+ApproachParams.ZStepsNumb;
            LabelSteps.Caption:=Format('%d',[-StepCount]);
            case STMFlg of
     False: begin
            end;
      TRUE: begin
            end;
               end; //case
             for i:=0  to 5 do beep;
               MessageDlgCtr(strb21{'Landing done'}, mtInformation,[mbOk],0);
               FlgStopApproach:=True;
               FlgApproachOK:=True;
            end;
      2: begin                //too close
            beep;
            StepCount:=StepCount+ApproachParams.ZStepsNumb;
            LabelSteps.Caption:=Format('%d',[-StepCount]);
              case STMFlg of
     False: begin
            end;
      TRUE: begin
            end;
               end; //case
            if  MessageDlgCtr(strb11{'Error!!'}+#13+strb22{'Tip too close to a sample!'}+#13+strb23{'Verify landing option or physical unit state.'}+#13+STRB24{'Do You want to rise the probe in a save place?'},mtWarning ,[mbYes,mbNo,mbHelp],IDH_error_landing_option)=mrYes then
             begin
               Application.ProcessMessages;
               NanoEdu.ScannerApproach.RisingToStartPoint(20);
               StepCount:=StepCount+20;
             end;
              Application.ProcessMessages;
              FlgStopApproach:=True;
          end;                      //too close
       4: begin    //out boundary
            FlgStopApproach:=True;
            Beep;
            MessageDlgCtr(strb25{'Attention!!!'}+#13+strb26{'The step motor has achieved top position!'}+#13+strb27{'Turn screw counter-clockwise by hand!!'}, mtInformation,[mbOk],IDH_Probe_is_too_High);
          end;
                     end;                //case
          StepCount:=StepCount+ApproachParams.ZStepsNumb;
          LabelSteps.Caption:=Format('%d',[-StepCount]);
                case STMFlg of
     False: begin
            end;
      TRUE: begin
            end;
               end; //case
        end;
    until FlgStopApproach;
    StartBtn.down:=false;
    StopBtn.down:=true;
    RadioGApproach.Enabled:=true;
    if StepGuide<>3 then BitBtnNext.Enabled:=true;
    if StepGuide<>0 then BitBtnPrev.Enabled:=true;
   end;
   *)
end;


procedure TFrBeginner.StartScan;
begin

end;

procedure TFrBeginner.StopBtnClick(Sender: TObject);
begin
   Nanoedu.Method.StopWork ;
   RadioGApproach.Enabled:=true;
   if StepGuide<>3 then BitBtnNext.Enabled:=true;
   if StepGuide<>0 then BitBtnPrev.Enabled:=true;
   FlgStopApproach:=True;
end;

procedure TFrBeginner.InitFast;
var H:hwnd;
    R:TRect;
    ProgressCal:TProgress;
begin
(*    h:=findwindow(nil,Pchar(strm41{'MSVideo'}));
   if h=0  then
    begin
     if GetModuleHandle('MSVideoLib.dll')=0 then
     begin
      @StartVideo:=nil;
      LibVideoHandle:=0;
      LibVideoHandle:=LoadLibrary(PChar(ExeFilePath+'MSVideoLib.dll'));
       if  LibVideoHandle<=32 then begin
                                   MessageDlgCtr(strb28{'Library MSVideoLib.dll Load Error'}+ IntToStr(GetLastError)+strb29{'!; Connect the Camera or Test USB Connection '},mtWarning,[mbOk],0);
                                   exit;
                                  end
                             else
                                  begin
                                    StartVideo:=GetProcAddress(LibVideoHandle,'StartVideo');
                                    StopVideo:=GetProcAddress(LibVideoHandle,'StopVideo');
                                  end;
     end;
      if StartVideo(Application.Handle,self.Handle,WM_UserCloseVideo,Lang) then
      begin
       h:=findwindow(nil,Pchar(strm41{'MSVideo'}));
       if h<>0  then
       begin
        GetWindowRect(h,R);
        SetWindowPos(h,HWND_TOPMost,Main.Left+5,Main.Top+Main.ClientHeight-(R.Bottom-R.Top),50,50,SWP_NOSIZE or SWP_SHOWWINDOW);
       end;
      end;
     end;
     if assigned(NanoEdu.ScannerApproach)then FreeAndNil(NanoEdu.ScannerApproach);
       NanoEdu.ApproachRegime;
       NanoEdu.ScannerApproach.TurnOn;

       if (RadioGApproach.ItemIndex=1) then        //   Rising
        begin
           NanoEdu.ScannerApproach.Nsteps:=ApproachParams.ZUpStepsNumb;
        end
        else
        begin                                            //Landing
           NanoEdu.ScannerApproach.Nsteps:=-ApproachParams.ZFastStepsNumb;
        end;

   LabelMain.Caption:=siLangLinked1.GetTextOrDefault('IDS_81' { 'Fast Landing' } );
   BitBtnNext.Enabled:=false;
   BitBtnPrev.Enabled:=false;
   Application.ProcessMessages;
   if not STMFlg and not FlgApproachOK then
   begin
              ProgressCal:=TProgress.Create(self);
           try
              ProgressCal.Show;
              ProgressCal.Caption:=siLangLinked1.GetTextOrDefault('IDS_82' { 'Search the Scanner Resonance Frequency' } );
              ProgressCal.ProgressBar.Position := ProgressCal.ProgressBar.Max div 2;
              FindResonance;
              ProgressCal.ProgressBar.Position := ProgressCal.ProgressBar.Max ;
          finally
              FreeAndNil(ProgressCal);
          end;
   end;
   BitBtnPrev.Enabled:=true;
   BitBtnNext.Enabled:=true;
   *)
end;

procedure TFrBeginner.InitApproach;
var val:word;
   stepval:apitype;
   Ampl:single;
begin
   LabelMain.Caption:=siLangLinked1.GetTextOrDefault('IDS_83' (* '   Landing' *) );
 (*   if assigned(NanoEdu.ScannerApproach) then FreeAndNil(NanoEdu.ScannerApproach);
    NanoEdu.ApproachRegime;
    NanoEdu.ScannerApproach.TurnOn;
 if (RadioGApproach.ItemIndex=1) then        //   Rising
    begin
       NanoEdu.ScannerApproach.Nsteps:=ApproachParams.ZUpStepsNumb;
    end
    else
    begin                        //Landing
       NanoEdu.ScannerApproach.Nsteps:=-ApproachParams.ZStepsNumb;//-1
    end;
            case STMFlg of
  TRUE:  begin                //STM
         end;
  False: begin
          ApproachParams.UAMMAX:=(NanoEdu as TSFMNanoEdu).MaxUAM;
         end;
              end; //case;
              *)
end;

procedure TFrBeginner.StartBtnClick(Sender: TObject);
var H:HWND;
begin
       case  StepGuide  of
 1:begin //fast Landing
     StartFastApproach;
   end;
 2:begin  //Approach
     StartApproach;
   end;
     end;
end;


procedure TFrBeginner.FormCreate(Sender: TObject);
var
     val:word;
   i,LinError:integer;
  ProcessHandle : THandle;
  ProcessID: Integer;
   TheWindow : HWND;
 ProcInfo: TProcessInformation;
 res:integer;
 olddir:string;
begin
 siLangLinked1.ActiveLanguage:=Lang;
 UpdateStrings;
 if   EXE_Running('Oscilloscope.exe', false) then
 begin
  TheWindow:=FindWindow(nil,'Oscilloscope');
  if  TheWindow<>0 then
  begin
   GetWindowThreadProcessID(TheWindow, @ProcessID);
   ProcessHandle := OpenProcess(PROCESS_TERMINATE, FALSE, ProcessId);
   if not (ProcessHandle=0) then
   begin
    TerminateProcess(ProcessHandle,0{4});
    CloseHandle(ProcessHandle);
   end;
  end;
 end;
  Top:=Screen.WorkareaHeight-height-20;
  Left:=Screen.WorkareaWidth-width-20;
  StepGuide:=0;
  EndStep:=4;
  if StepGuide=0 then BitBtnPrev.enabled:=false;
    PagectrlGuide.ActivePage:=TabsheetStart;
    PanelApproach.Visible:=true;
    PanelApproach.align:=alClient;
    RadioGApproach.font.color:=clred;
    LabelSteps.Font.color:=clRed;
    Caption:=siLangLinked1.GetTextOrDefault('IDS_91' { 'Guide SFM' } );
    ComboBoxSFMSTM.hint:=siLangLinked1.GetTextOrDefault('IDS_92' { 'Scanning Force Microscope' } );
    ComponentVisible;
    StepCount:=0;
  with PageCtrlGuide do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
end;

procedure TFrBeginner.ComboBoxSFMSTMSelect(Sender: TObject);
begin
     case ComboBoxSFMSTM.ItemIndex   of
  0:begin
      STMflg:=false;
      ComboBoxSFMSTM.hint:=siLangLinked1.GetTextOrDefault('IDS_92' (* 'Scanning Force Microscope' *) );
      FreeAndNil(NanoEdu);
      NanoEdu:=TSFMNanoEdu.Create;
      NanoEdu.TurnOn;
      Caption:=siLangLinked1.GetTextOrDefault('IDS_91' (* 'Guide SFM' *) );
     end;   //SFM
  1:begin
      STMflg:=true;
      ComboBoxSFMSTM.hint:=siLangLinked1.GetTextOrDefault('IDS_95' (* 'Scanning Tunneling Microscope' *) );
      MessageDlgCtr(strb4{'Attention! STM is intendend for working with conductive samples, otherwise the probe will be destroyed!!'},mtWarning ,[mbOK],0);
      FreeAndNil(NanoEdu);
      NanoEdu:=TSTMNanoEdu.Create;
      NanoEdu.TurnOn;
      Caption:=siLangLinked1.GetTextOrDefault('IDS_97' (* 'Guide STM' *) );
     end;   //STM
            end;
end;

procedure TFrBeginner.BitBtnNextClick(Sender: TObject);
var
   i:integer;
   val:word;
begin
 inc(StepGuide);
 ComponentVisible;
 PageCtrlGuide.ActivePageIndex:=StepGuide;
  case StepGuide of
1:begin //fast
   InitFast;
  end;
2:begin //approach
   InitApproach;
  end;
3:begin //scan
   InitScan;
  end;
    end;
      with PageCtrlGuide do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
end;

procedure TFrBeginner.BitBtnPrevClick(Sender: TObject);
var
   i:integer;
   val:word;
begin
 if not FlgStopScan then
  begin
   MessageDlgCtr(strb5{'Stop Scanning!'},mtWarning ,[mbOK],0);
   exit;
  end;
 if StepGuide=3 then   //scan
 begin
  if assigned(ScanWnd) then
    begin
      ScanWnd.Close;
    end;
 end;
  Dec(StepGuide);
  ComponentVisible;
  case StepGuide of
0: begin
    PageCtrlGuide.ActivePageIndex:=0;
    end;
1,2:begin  //approch + fast
     PageCtrlGuide.ActivePageIndex:=StepGuide;
    end;
3:  PageCtrlGuide.ActivePageIndex:=3; //scan
       end;
  case StepGuide of
1:begin //fast
   InitFast;
  end;
2:begin //approach
   InitApproach;
  end;
3:begin //scan
   InitScan;
  end;
    end;
          with PageCtrlGuide do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
end;

procedure TFrBeginner.SetMoveAway;
begin
          StepGuide:=2;
          PageCtrlGuide.ActivePageIndex:=StepGuide;
          ComponentVisible;
          RadioGApproach.ItemIndex:=1;
          InitApproach;
end;

procedure TFrBeginner.siLangLinked1ChangeLanguage(Sender: TObject);
begin

  UpdateStrings;
end;

procedure TFrBeginner.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
var h:HWND;
begin
   if not FlgStopApproach then
    begin
      MessageDlgCtr(strb6{'Stop approach before exit!!!'}, mtInformation,[mbOk],0);
      CanClose := False;
    end
    else
    begin
     if assigned(ScanWnd)  then
      if  FlgStopScan then ScanWnd.Close
                      else begin MessageDlgCtr(strb7{'Stop Scanning before exit!!!'}, mtInformation,[mbOk],0); CanClose := False; exit; end;
       if  flgApproachOK then
       begin
        MessageDlgCtr(strb8{'Move probe away!!'}, mtInformation,[mbOk], 0);
        SetMoveAway;
        CanClose := False;
       end
       else CanClose := True;
       h:=FindWindow(nil,Pchar(strm41{'MSVideo'}));
       if h<>0 then  StopVideo;
   end;
end;

procedure TFrBeginner.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
 if assigned(WorkView) then
  begin
   Main.width:= Main.width+ WorkView.width;
   Main.Left:=Screen.WorkAreaLeft;
   WorkView.close;
  end;
 Main.ActionNew.Enabled:=true;
 Main.ActionNew.Visible:=true;
 Main.ComboBoxLevel.Enabled:=true;
// Main.btnViewWork.Visible:=false;
// main.ToolBtnDir.Visible:=false;
 FreeAndNil(NanoEdu);
 frBeginner:=nil;
// if  libHandle>0 then
//   if  not FreeCSPMLib(libHandle) then siLangLinked1.ShowMessage(strb9{'error free cspmlib'})
//                                  else
//                                   libHandle:=0;
 end;

procedure TFrBeginner.RadioGApproachClick(Sender: TObject);
begin
       case RadioGApproach.itemindex of
    0: begin
           case  StepGuide of
         1:  LabelMain.Caption:=siLangLinked1.GetTextOrDefault('IDS_81' (* 'Fast Landing' *) );
         2:  LabelMain.Caption:=siLangLinked1.GetTextOrDefault('IDS_83' (* '   Landing' *) );
                  end;
        RadioGApproach.font.color:=clred;
        LabelSteps.Font.color:=clRed
       end;
    1: begin
          case  StepGuide of
         1:  LabelMain.Caption:=siLangLinked1.GetTextOrDefault('IDS_106' (* 'Fast Rising' *) );
         2:  LabelMain.Caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* '  Rising' *) );
                  end;
           RadioGApproach.font.color:=clblack;
           LabelSteps.Font.color:=clBlack
       end;
     end;
end;

procedure TFrBeginner.BitBtnHelpClick(Sender: TObject);
begin
 case StepGuide  of
0,                     
1,2:begin
        HlpContext:=IDH_Control_Panel_Beginner;
    end;
 3: begin
    if STMFlg then
     begin
       HlpContext:=IDH_Scanning_STM;
     end
     else
     begin
       HlpContext:=IDH_Scanning_SFM;
     end;
    end;
        end; //case
   Application.HelpContext(HlpContext);
end;
end.


