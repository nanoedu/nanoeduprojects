//not changed from 161115
unit frPositionXYZ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, ToolWin, siComp,globaltype,cspmvar,siLngLnk,
  RuleMod4, Buttons;

type
  TScannerPositionXYZ = class(TForm)
    Panel1: TPanel;
    PanelPM: TPanel;
    siLangLinked1: TsiLangLinked;
    Panel4: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    LabelTime: TLabel;
    LabelTimeval: TLabel;
    LabelPMpauseval: TLabel;
    LabelPause: TLabel;
    ScrollBarPMPause: TScrollBar;
    ScrollBarPMTime: TScrollBar;
    PanelFastStep: TPanel;
    Label1: TLabel;
    LblNstepsval: TLabel;
    ScrollBarNmbFastStp: TScrollBar;
    Panel5: TPanel;
    PanelX: TPanel;
    Label3: TLabel;
    LblStepsXVal: TLabel;
    PanelY: TPanel;
    Label4: TLabel;
    LblStepsYval: TLabel;
    PanelZ: TPanel;
    Label6: TLabel;
    LblStepsZval: TLabel;
    Panel2: TPanel;
    PanelHelpHotkeys: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    ToolBarControlX: TToolBar;
    StartBtnXM: TToolButton;
    StartBtnXFastM: TToolButton;
    ToolButton9: TToolButton;
    StopBtnX: TToolButton;
    ToolButton11: TToolButton;
    StartBtnXFastP: TToolButton;
    StartBtnXP: TToolButton;
    RadioGroupDir: TRadioGroup;
    HiddenEdit: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    ImageX: TImage;
    Image1: TImage;
    Panel9: TPanel;
    StaticText1: TStaticText;
    Image2: TImage;
    Image4: TImage;
    Image3: TImage;
    Image5: TImage;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Panel6: TPanel;
    LabelZ: TLabel;
    ZIndicatorScan: TRuleMod4;
    Label13: TLabel;
    LabelZV: TLabel;
    Timer: TTimer;
    BitBtnMovetoZero: TBitBtn;
    BitBtnMovetoStart: TBitBtn;
    PanelZCaption: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure RadioGroupDirClick(Sender: TObject);
    procedure ScrollBarPMPauseChange(Sender: TObject);
    procedure ScrollBarNmbFastStpScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StopBtnXClick(Sender: TObject);
    procedure StartBtnXMClick(Sender: TObject);
    procedure ScrollBarPMPauseScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ScrollBarPMTimeScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HiddenEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HiddenEditKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnMovetoStartPosClick(Sender: TObject);
    procedure TimerUp(Sender: TObject);
    procedure BitBtnMovetoStartClick(Sender: TObject);
  private
    { Private declarations }
//  flgDrag:boolean;
    flgCanClose:boolean;
    sgn:integer;
    flgArrowdown:boolean;
    ActiveTag:integer;
    flgTimerActive, flgStopTimer:boolean;
    stepsclr:Tcolor;
    procedure MyFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMLMouseDown(var Msg : TWMMouse); message WM_LBUTTONDOWN;
    function  StopMoving:boolean;
    procedure ZIndicatorDraw(Z:apitype);

   //  procedure drawsamplepos(x,y:integer; cl:Tcolor);
  public
    { Public declarations }
     ScannerMoveXYZActive:boolean;
     StopAllow:boolean;
     flgCancel:Boolean;
     FlgStepResult:apitype;
//    FlgMoveXYZResult:apitype;
  procedure  ThreadDone(var AMessage : TMessage); message WM_ThreadDoneMsg;
end;

var
  ScannerPositionXYZ: TScannerPositionXYZ;

implementation

{$R *.dfm}

uses globalvar,UNanoEduBaseClasses,ScannermoveXYZDrawThread,mmain;
 const
	strmxslw: string = ''; (*    -X  S&low  *)
	strmyslw: string = ''; (*    -Y  S&low  *)
	strmzslw: string = ''; (*    -Z  S&low  *)
	strpxslw: string = ''; (*    +X  Sl&ow  *)
	strpyslw: string = ''; (*    +Y  Sl&ow  *)
	strpzslw: string = ''; (*    +Z  Sl&ow  *)
	strmxfast: string = ''; (*    -X  &Fast  *)
	strmyfast: string = ''; (*    -Y  &Fast  *)
	strmzfast: string = ''; (*    -Z  &Fast  *)
	strpxfast: string = ''; (*    +X  F&ast  *)
	strpyfast: string = ''; (*    +Y  F&ast  *)
	strpzfast: string = ''; (*    +Z  F&ast  *)
	strrise: string = ''; (* rise *) // TSI: Localized (Don't modify!)
	strappr: string = ''; (* approach *) // TSI: Localized (Don't modify!)

function  TScannerPositionXYZ.StopMoving:boolean;
begin
result:=true;
 if not  FlgStopScannerMoveXYZ  then
  begin
   ToolBarControlX.enabled:=false;
   Application.ProcessMessages;
   if assigned(Nanoedu.Method) then
   begin
    flgStopJava:=true;
    if not Nanoedu.Method.StopWork then
     begin
      result:=false;
      FreeAndNil(NanoEdu.Method);
      ToolBarControlX.enabled:=true;
      Application.ProcessMessages;
     end;
   end;
  end;
end;
procedure  TScannerPositionXYZ.ThreadDone(var AMessage : TMessage);
begin
 if  (mDrawing=AMessage.WParam)then
  begin
    if assigned(ScannerMoveXYZThread) then
     begin
        ScannerMoveXYZThread:=nil;
        ScannerMoveXYZThreadActive := false;
     end;
    StartBtnXP.Down:=false;
    StartBtnXM.Down:=false;
    StartBtnXFastM.Down:=false;
    StartBtnXFastP.Down:=false;
    ScannerMoveXYZActive:=false;
//  FlgStopScannerMoveXYZ:=false; //can press stop btn
    ToolBarControlX.Enabled:=true;
    flgCanClose:=true;
    StopBtnX.Down:=true;
//     add 080216
    flgStopTimer:=false;
    Timer.Enabled:=true;
//
    Application.ProcessMessages;
 end;//drawthread
  if mScanning=AMessage.WParam then
    begin
      NanoEdu.Method.FreeBuffers;
      FreeAndNil(NanoEdu.Method);
    end;
 end;



procedure TScannerPositionXYZ.UpdateStrings;
begin
  strappr := siLangLinked1.GetTextOrDefault('strstrappr' (* 'approach' *) );
  strrise := siLangLinked1.GetTextOrDefault('strstrrise' (* 'rise' *) );
  strpzfast := siLangLinked1.GetTextOrDefault('strstrpzfast');
  strpyfast := siLangLinked1.GetTextOrDefault('strstrpyfast');
  strpxfast := siLangLinked1.GetTextOrDefault('strstrpxfast');
  strmzfast := siLangLinked1.GetTextOrDefault('strstrmzfast');
  strmyfast := siLangLinked1.GetTextOrDefault('strstrmyfast');
  strmxfast := siLangLinked1.GetTextOrDefault('strstrmxfast');
  strpzslw := siLangLinked1.GetTextOrDefault('strstrpzslw');
  strpyslw := siLangLinked1.GetTextOrDefault('strstrpyslw');
  strpxslw := siLangLinked1.GetTextOrDefault('strstrpxslw');
  strmzslw := siLangLinked1.GetTextOrDefault('strstrmzslw');
  strmyslw := siLangLinked1.GetTextOrDefault('strstrmyslw');
  strmxslw := siLangLinked1.GetTextOrDefault('strstrmxslw');
  strappr := siLangLinked1.GetTextOrDefault('strstrappr');
  strrise := siLangLinked1.GetTextOrDefault('strstrrise');
end;

//
(*procedure TScannerPositionXY.drawsamplepos(x,y:integer; cl:Tcolor);
begin
  ImageScanFull.Canvas.Brush.Color:=cl;
  ImageScanFull.Canvas.pen.Color:=cl;
 // if (X+30)>ImageScanFull.width then
  ImageScanFull.Canvas.MoveTo(x,y);
  ImageScanFull.Canvas.FillRect(Rect(x,y,x+r,y+r));
 // ImageScanFull.Canvas.Ellipse(x,y,x+r,y+r);
 // ImageScanFull.Canvas.FloodFill(x+5,y+5,cl,fsSurface);
end;
*)
procedure TScannerPositionXYZ.BitBtnMovetoStartClick(Sender: TObject);
begin
//  move to zero position 10000;
 
end;

procedure TScannerPositionXYZ.BtnMovetoStartPosClick(Sender: TObject);
begin
//
// rise to zero point
end;

procedure TScannerPositionXYZ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
(* if assigned(Nanoedu.ScannerMoveXYZ.Motor)
     then Nanoedu.ScannerMoveXYZ.Motor.TurnOff;
  FreeAndNil(Nanoedu.ScannerMoveXYZ);
  ScannerPositionXYZ:=nil;
  *)
  ScannerPositionXYZ:=nil;
  Action:=CaFree;
end;
 procedure TScannerPositionXYZ.TimerUp(Sender: TObject);
var z:integer;
begin
 Timer.Enabled:=false;
 flgTimerActive:=True;
// if Timer.Enabled then    { TODO : 271007 }
//  begin
    Application.ProcessMessages;
      z:=NanoEdu.ZValue;
      ZIndicatorDraw(z);
//  end;
   flgTimerActive:=false;
  if not flgStopTimer then Timer.Enabled:=true;  { TODO : 271007 }
end;
procedure TScannerPositionXYZ.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    CanClose := False;   flgStopTimer:=true;
   if not FlgStopScannerMoveXYZ then
    begin
      MessageDlgCtr(  'Stop move before exit!!!'  , mtInformation,[mbOk],0);
    end
    else
    if  not flgCanClose   then
     begin      //moving thread
     end
     else
     begin
      if not  FlgTimerActive then
       begin if assigned(Timer) then
         begin
          Timer.Enabled:=false;
          FreeAndNil(Timer);
         end;
         CanClose := True;
       end
       else
       begin
        flgStopTimer:=true;
        while  FlgTimerActive do
        begin
          sleep(100);
          application.processmessages;
        end;
        CanClose := True;
       end
     end;
end;
 procedure TScannerPositionXYZ.ZIndicatorDraw(Z:apitype);
var i:integer;
begin
  if assigned(ScannerPositionXYZ) then
  begin
 //    ZIndicatorScan.Value:=round((MinAPITYPE+1)*(Z-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));
    ZIndicatorScan.Value:=round((MaxAPITYPE)*(1-(Z-MinAPITYPE)/(MaxAPITYPE-MinAPITYPE))); // Нормировка изменена 30/07/2013
// ZIndicatorScan.Value:=Z;
//  ZIndicatorVal:=round((MinAPITYPE+1)*(TempAquiData[i]-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));


     LabelZV.Font.color:=clGreen;
     ZIndicatorScan.IndicColor:=clGreen;
     LabelZV.Caption:=FloattoStrF(ZIndicatorScan.Value/Maxapitype,fffixed,3,2);
   if  (ZIndicatorScan.Value < 3200) then
    begin
        ZIndicatorScan.IndicColor:=clRed;
        LabelZV.Font.color:=clRed;
        i:=0;
    end
    else
     begin
     if  (ZIndicatorScan.Value >29000) then
      begin
          ZIndicatorScan.IndicColor:=clNavy;
          LabelZV.Font.color:=clNavy ;
       //   Beep;
      end
    end;
    ZindicatorScan.RePaint;
  end;
end;

procedure TScannerPositionXYZ.FormCreate(Sender: TObject);
begin
  UpdateStrings;
    HiddenEdit.Height:=0;
    HiddenEdit.width:=0;
    flgArrowdown:=false;
    stepsclr:=clBlack;
    siLangLinked1.ActiveLanguage:=Lang;
    ScannerMoveXYZActive:=false;
    FlgStopScannerMoveXYZ:=true;
    FlgCanClose:=true;
    ScannerMoveXYZParams.TypeMover:=2;
    sgn:=1;
    RadioGroupDir.ItemIndex:=0;
    lblStepsXval.Caption:=inttostr( ScannerMoveXYZParams.StepsCountX);
    lblStepsYVal.Caption:=inttostr( ScannerMoveXYZParams.StepsCountY);
    lblStepsZVal.Caption:=inttostr( ScannerMoveXYZParams.StepsCountZ);
    PanelFastStep.Visible:=true;
    PanelPM.Visible:=true;
  // Indicator
     ZIndicatorScan.Maximum:=MaxApiType;
     ZIndicatorScan.HighLimit:=round(ApproachParams.ZGateMax*MaxApiType);
     ZIndicatorScan.LowLimit:=round(ApproachParams.ZGateMin*MaxApiType);
     ZIndicatorScan.IndicColor:=clNavy;
     FlgTimerActive:=false;
     flgStopTimer:=false;
     Timer.Enabled:=true;
     Timer.Interval:=200;
  // ZIndicatorScan.Hint:=siLangLinked1.GetTextOrDefault('IDS_43' (* 'the Indicator Z' *) )
  // StopBtnX.Enabled:=false;
 end;
procedure TScannerPositionXYZ.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
(*  Application.ProcessMessages;
  flgArrowdown:=false;
  StopBtnXClick(Sender);
  StopBtnX.down:=true;
  *)
end;

procedure TScannerPositionXYZ.FormResize(Sender: TObject);
begin
//
end;

procedure TScannerPositionXYZ.FormShow(Sender: TObject);
begin
  width:=width+1;
//    RadioGroupDir.ItemIndex:=0;
      case RadioGroupDir.ItemIndex of
0: begin
    ScannerMoveXYZParams.TypeMover:=2;
    StartBtnXM.Caption:=strmxslw;  StartBtnXFastM.Caption:=strmxfast;
    StartBtnXP.Caption:=strpxslw;  StartBtnXFastP.Caption:=strpxfast;
    panelx.font.color:=clRed;
    panely.font.color:=stepsclr;
    panelz.font.color:=stepsclr;
    StartBtnXM.ImageIndex:=17;
    StartBtnXFastM.ImageIndex:=20;
    StartBtnXP.ImageIndex:=8;
    StartBtnXFastP.ImageIndex:=19;
   end;
1: begin
    ScannerMoveXYZParams.TypeMover:=3;
    StartBtnXM.Caption:=strmyslw;  StartBtnxFastM.Caption:=strmyfast;
    StartBtnXP.Caption:=strpyslw;  StartBtnxFastP.Caption:=strpyfast;
    panelx.font.color:=clRed;
    panely.font.color:=stepsclr;
    panelz.font.color:=stepsclr;
    StartBtnXM.ImageIndex:=17;
    StartBtnXFastM.ImageIndex:=20;
    StartBtnXP.ImageIndex:=8;
    StartBtnXFastP.ImageIndex:=19;
   end;
2: begin  //z
    ScannerMoveXYZParams.TypeMover:=4;
    sgn:=1;//-1;
    StartBtnXM.Caption:=strmzslw;  StartBtnXFastM.Caption:=strmzfast;
    StartBtnXP.Caption:=strpzslw;  StartBtnXFastP.Caption:=strpzfast;
    panelx.font.color:=clRed;
    panely.font.color:=stepsclr;
    panelz.font.color:=stepsclr;
    StartBtnXM.ImageIndex:=11;
    StartBtnXFastM.ImageIndex:=15;
    StartBtnXP.ImageIndex:=13;
    StartBtnXFastP.ImageIndex:=16;
   end;
     end;
    Invalidate;
    ScrollBarPMTime.Position:=ScannermoveXYZParams.PMActiveTime;
    LabelTimeVal.Caption:=inttostr(ScrollBarPMTime.Position);
    ScrollBarPMPause.Position:=ScrollBarPMPause.Max-ScannermoveXYZParams.PMPAUSE;
    LabelPMPauseVal.Caption:=inttostr(ScrollBarPMPause.Position);
    ScannerMoveXYZParams.Speed:=(ScannerMoveXYZParams.PMActiveTime shl 4) +(ScannerMoveXYZParams.PMPause);
    ScannerMoveXYZParams.StepsNumbFast:=10;
    lblNstepsval.caption:=inttostr(ScannerMoveXYZParams.StepsNumbFast);
    ScrollBarNmbFastStp.position:=ScannerMoveXYZParams.StepsNumbFast;
//    StopBtnX.Enabled:=false;

 HiddenEdit.SetFocus;
end;

procedure TScannerPositionXYZ.HiddenEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 MyFormKeyDown(Sender, Key,Shift);
end;
 procedure TScannerPositionXYZ.WMLMouseDown(var Msg: TWMMouse);
begin
  HiddenEdit.SetFocus;
  Msg.Result := ERROR_SUCCESS;
end;
procedure TScannerPositionXYZ.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  Msg.Result := DLGC_WANTARROWS;
end;
procedure TScannerPositionXYZ.HiddenEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  lToEnd : Boolean;
begin
// while not ScannerPositionXYZ.StopBtnX.Enabled do Application.ProcessMessages;
// while not ScannerMoveXYZThreadActive do sleep(50);
  flgStopJava:=true;
  flgArrowdown:=false;
//  StopMoving;
//    StopBtnXClick(Sender);
  StopBtnX.down:=true;
 (*  lToEnd := False;
  if ssShift in Shift then
    lToEnd := True;

  case Key of
    VK_UP     : if lToEnd then YPositiveMove else YPositiveStep ;
    VK_DOWN   : if lToEnd then YNegativeMove else YNegativeStep ;
    VK_LEFT   : if lToEnd then XNegativeMove else XNegativeStep ;
    VK_RIGHT  : if lToEnd then XPositiveMove else XPositiveStep ;
    VK_RETURN : MoveStop;
    VK_ESCAPE : MoveStop;
  end;
  *)
end;
procedure TScannerPositionXYZ.MyFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  var
     flgFast:Boolean;
     val,ltag:integer;
     scriptname:string;
     sgnchange:integer;
begin
flgfast:=false;
if ssShift in Shift then flgFast:=true;
if  (Key in [vk_left,vk_right,vk_up,vk_down,vK_end]) then
begin
if not  flgArrowdown and ToolBarControlX.Enabled {and not flgStopJava} then
begin
flgArrowdown:=true;
  case key of
vk_left,
vk_right:
 begin //x
   if  RadioGroupDir.ItemIndex<>2 then    //NOT Z
   begin
    RadioGroupDir.ItemIndex:=0 ;
    RadioGroupDirClick(Sender);
    case key of
 vk_Left: if flgFast then StartBtnXFastM.down:=true else StartBtnXFastM.down:=false;
vk_right: if flgFast then StartBtnXFastP.down:=true else StartBtnXFastP.down:=false;
    end;
    Application.processmessages;
   end;
  end;
vk_up,
vk_down:
begin //y
 if  RadioGroupDir.ItemIndex<>2 then      //NOT Z
   begin
    RadioGroupDir.ItemIndex:=1 ;
    RadioGroupDirClick(Sender);
        case key of
vk_down: if flgFast then StartBtnXFastM.down:=true else StartBtnXFastM.down:=false;
vk_up  : if flgFast then StartBtnXFastP.down:=true else StartBtnXFastP.down:=false;
    end;
    Application.processmessages;
   end;
end;

vK_end: begin
         StopBtnXClick(Sender);
         StopBtnX.down:=true;
         exit;
       end;
     end;


         case key of
vk_left:begin                //-x
            case flgFast of
  true:  begin
           StartBtnXMClick(StartBtnXFastM);
           StartBtnXFastM.down:=true;
         end;
  false: begin
           StartBtnXMClick(StartBtnXM);
           StartBtnXM.down:=true;
         end;
              end;
        end;
vk_right:begin
            case flgFast of
  true:    begin
            StartBtnXMClick(StartBtnXFastP);
            StartBtnXFastP.down:=true;
           end;
  false:   begin
            StartBtnXMClick(StartBtnXP);
            StartBtnXP.down:=true;
           end;
                end;
         end;
vk_up:begin   //y+
                    case flgFast of
  true:    begin
            StartBtnXMClick(StartBtnXFastP);
            StartBtnXFastP.down:=true;
           end;
  false:   begin
            StartBtnXMClick(StartBtnXP);
            StartBtnXP.down:=true;
           end;
              end;
      end;
vk_down:begin     //Y-
           case flgFast of
  true:    begin
            StartBtnXMClick(StartBtnXFastM);
            StartBtnXFastM.down:=true;
           end;
  false:   begin
            StartBtnXMClick(StartBtnXM);
            StartBtnXM.down:=true;
           end;
               end;
       end;
            end;  //case
    Application.processmessages;
end
else inherited KeyDown(key,shift)//not Z
end;
 // ActiveTag:=TControl(Sender).tag;
end;
//
procedure TScannerPositionXYZ.RadioGroupDirClick(Sender: TObject);
var sgnchange:integer;
begin
      sgnchange:=1;
     case RadioGroupDir.ItemIndex of
0: begin        //x
    sgn:=1;
    if ScannerMoveXYZParams.TypeMover=4 then sgnchange:=-1;
    ScannerMoveXYZParams.TypeMover:=2;
    StartBtnXM.Caption:=strmxslw;  StartBtnXFastM.Caption:=strmxfast;
    StartBtnXP.Caption:=strpxslw;  StartBtnXFastP.Caption:=strpxfast;
    panelx.font.color:=clRed;
    panely.font.color:=stepsclr;
    panelz.font.color:=stepsclr;
    StartBtnXM.ImageIndex:=17;
    StartBtnXFastM.ImageIndex:=20;
    StartBtnXP.ImageIndex:=8;
    StartBtnXFastP.ImageIndex:=19;
    PanelZCaption.visible:=false;
   end;
1: begin       //y
    sgn:=1;
    if ScannerMoveXYZParams.TypeMover=4 then sgnchange:=-1;
    ScannerMoveXYZParams.TypeMover:=3;
    StartBtnXM.Caption:=strmyslw;  StartBtnxFastM.Caption:=strmyfast;
    StartBtnXP.Caption:=strpyslw;  StartBtnxFastP.Caption:=strpyfast;
    panely.font.color:=clRed;
    panelx.font.color:=stepsclr;
    panelz.font.color:=stepsclr;
    StartBtnXM.ImageIndex:=17;
    StartBtnXFastM.ImageIndex:=20;
    StartBtnXP.ImageIndex:=8;
    StartBtnXFastP.ImageIndex:=19;
    PanelZCaption.visible:=false;
   end;
2: begin        //z
    sgn:=1;//-1;
    if ScannerMoveXYZParams.TypeMover<>4 then sgnchange:=-1;
    ScannerMoveXYZParams.TypeMover:=4;
    StartBtnXM.Caption:=strmzslw;  StartBtnXFastM.Caption:=strmzfast;
    StartBtnXP.Caption:=strpzslw;  StartBtnXFastP.Caption:=strpzfast;
    panelz.font.color:=clRed;
    panely.font.color:=stepsclr;
    panelx.font.color:=stepsclr;
    StartBtnXM.ImageIndex:=11;
    StartBtnXFastM.ImageIndex:=15;
    StartBtnXP.ImageIndex:=13;
    StartBtnXFastP.ImageIndex:=16;
    PanelZCaption.visible:=true;
//   StartBtnXFastP.caption:=strrise;
//    StartBtnXFastM.caption:=strappr;
   end;
     end;
     if ScannerMoveXYZActive then
     begin
        ScannerMoveXYZParams.StepsNumb:=sgnchange*ScannerMoveXYZParams.StepsNumb;
       if assigned (Nanoedu.Method) then   Nanoedu.Method.SetUsersParams;
 (*     if assigned(Nanoedu.ScannerMoveXYZ)
       then
       begin
        ScannerMoveXYZParams.StepsNumb:=sgnchange*ScannerMoveXYZParams.StepsNumb;
        Nanoedu.ScannerMoveXYZ.NSteps:=ScannerMoveXYZParams.StepsNumb;
       end;
       if assigned(Nanoedu.ScannerMoveXYZ.Motor) then
       begin
         Nanoedu.ScannerMoveXYZ.Motor.TurnOff;
         Nanoedu.ScannerMoveXYZ.Motor.TurnOn;
       end;
       *)
     end;
  HiddenEdit.SetFocus;
end;

(*
procedure TScannerPositionXY.ImageScanFullMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if (ImageScanFull.Canvas.Pixels[x,y]=clStart) or
 (ImageScanFull.Canvas.Pixels[x,y]=clAim) then flgDrag:=true;
end;

procedure TScannerPositionXY.ImageScanFullMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 if flgDrag then
 begin
   ScrollBarX.Position:=x;
   ScrollBarY.Position:=Y;
 end;
end;

procedure TScannerPositionXY.ImageScanFullMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 flgDrag:=false;
end;



procedure TScannerPositionXY.ScrollBarXChange(Sender: TObject);
begin
 drawsamplepos(xa,ya,clClear);
 xa:=ScrollBarX.Position;
 LabelaX.Caption:=inttostr(xa);
 drawsamplepos(x0,y0,ClStart);
 drawsamplepos(xa,ya,ClAim);
end;

procedure TScannerPositionXY.ScrollBarXScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
 drawsamplepos(xa,ya,clClear);
 xa:=ScrollPos;
 LabelaX.Caption:=inttostr(xa);
 drawsamplepos(x0,y0,ClStart);
 drawsamplepos(xa,ya,ClAim);
end;

procedure TScannerPositionXY.ScrollBarYChange(Sender: TObject);
begin
 drawsamplepos(xa,ya,clClear);
 ya:=ScrollBary.Position;
 Labelay.Caption:=inttostr(ya);
 drawsamplepos(x0,y0,ClStart);
 drawsamplepos(xa,ya,ClAim);
end;

procedure TScannerPositionXY.ScrollBarYScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  drawsamplepos(xa,ya,clClear);
  LabelaY.Caption:=inttostr(ya);
  Ya:=Scrollpos;
  drawsamplepos(x0,y0,clStart);
  drawsamplepos(xa,ya,ClAim);
end;
*)
 procedure TScannerPositionXYZ.ScrollBarNmbFastStpScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var sgnfst:integer;
begin
   lblnstepsval.Caption:=inttostr(ScrollPos);
   sgnfst:=1;
//   if (ScannerMoveXYZParams.StepsNumbFast<0) and (sgn<0) then sgnfst:=-1;
   ScannerMoveXYZParams.StepsNumbFast:=ScrollPos;
if ScannerMoveXYZParams.StepsNumb<0 then  sgnfst:=-1;
  if  ScannerMoveXYZActive    then
  begin
   ScannerMoveXYZParams.StepsNumb:=sgnfst*ScannerMoveXYZParams.StepsNumbFast;
   if assigned (Nanoedu.Method) then   Nanoedu.Method.SetUsersParams;
  end;
   HiddenEdit.SetFocus;
end;

procedure TScannerPositionXYZ.ScrollBarPMPauseChange(Sender: TObject);
begin
    ScannerMoveXYZParams.PMPause:=ScrollBarPMPause.position;
    LabelPMPauseVal.Caption:=inttostr(ScrollBarPMPause.position);
    ScannerMoveXYZParams.Speed:=(ScannerMoveXYZParams.PMActiveTime shl 4) +(ScannerMoveXYZParams.PMPause);
  if assigned (Nanoedu.Method) then   Nanoedu.Method.SetUsersParams;
   HiddenEdit.SetFocus;
end;

procedure TScannerPositionXYZ.ScrollBarPMPauseScroll(Sender: TObject;  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
    ScannerMoveXYZParams.PMPause:=ScrollBarPMPause.Max-ScrollPos;
    ScannerMoveXYZParams.Speed:=(ScannerMoveXYZParams.PMActiveTime shl 4) +(ScannerMoveXYZParams.PMPause);
    LabelPMPauseVal.Caption:=inttostr(scrollpos);
   if assigned (Nanoedu.Method) then   Nanoedu.Method.SetUsersParams;
    HiddenEdit.SetFocus;
end;

procedure TScannerPositionXYZ.ScrollBarPMTimeScroll(Sender: TObject;  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
    ScannerMoveXYZParams.PMActiveTime:=ScrollPos;
    ScannerMoveXYZParams.Speed:=(ScannerMoveXYZParams.PMActiveTime shl 4) +(ScannerMoveXYZParams.PMPause);
    LabelTimeVal.Caption:=inttostr(scrollpos);
  if assigned (Nanoedu.Method) then   Nanoedu.Method.SetUsersParams;
   HiddenEdit.SetFocus;
end;



procedure TScannerPositionXYZ.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TScannerPositionXYZ.StartBtnXMClick(Sender: TObject);
var
     val,ltag:integer;
     ScriptName:string;
begin
if not ScannerMoveXYZActive then     //not active approach process
begin
 FlgStopJava:=False;
 ScannerMoveXYZActive:=true;
// ToolBarControlX.Enabled:=false;
 Application.ProcessMessages;
 ScriptName:=ScannerMoveXYZScrpt;
 ltag:=TControl(Sender).tag;
      case  ltag of
1:begin                //X-
   ScannerMoveXYZParams.StepsNumb:=-sgn;
   PanelFastStep.Visible:=true;
  end;
2:begin  //x-
    ScannerMoveXYZParams.StepsNumb:=-sgn*ScannerMoveXYZParams.StepsNumbFast;
    PanelFastStep.Visible:=true;
  end;
3:begin
   ScannerMoveXYZParams.StepsNumb:=sgn;
   PanelFastStep.Visible:=true;
  end;
4:begin
   ScannerMoveXYZParams.StepsNumb:=sgn*ScannerMoveXYZParams.StepsNumbFast;
   PanelFastStep.Visible:=true;
  end;
            end;  //case
 if  FlgStopScannerMoveXYZ then
  begin
    FlgStopScannerMoveXYZ:=False;
    FlgCanClose:=false;
    Application.processmessages;
    NanoEdu.ScannerMoveXYZMethod;
    if NanoEdu.Method.Launch<>0 then
     begin
      FreeAndNil(NanoEdu.Method);
     end;
  end;  //
 end
 else  //active moving
 begin //active  process
  ltag:=TControl(Sender).tag;
      case ltag of
  1:begin                //-x
      ScannerMoveXYZParams.StepsNumb:=-sgn;
      PanelFastStep.Visible:=true;//false;
    end;
  2:begin    //x- fast
      ScannerMoveXYZParams.StepsNumb:=-sgn*ScannerMoveXYZParams.StepsNumbFast;
      PanelFastStep.Visible:=true;
    end;
  3:begin   //x+
      ScannerMoveXYZParams.StepsNumb:=sgn;
      PanelFastStep.Visible:=true;//false;
      end;
  4:begin     //x+fast
      ScannerMoveXYZParams.StepsNumb:=sgn*ScannerMoveXYZParams.StepsNumbFast;
      PanelFastStep.Visible:=true;
    end;
            end;  //case
  if assigned (Nanoedu.Method) then   Nanoedu.Method.SetUsersParams;
    Application.processmessages;
 end;
  ActiveTag:=TControl(Sender).tag;
   HiddenEdit.SetFocus;
end;

procedure TScannerPositionXYZ.StopBtnXClick(Sender: TObject);
begin
  flgStopJava:=true;
  ActiveTag:=TControl(Sender).tag;
  HiddenEdit.SetFocus;
end;
end.


