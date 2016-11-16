//270402
unit frSetInteraction;

interface

uses
  Windows, SysUtils, Classes,Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Buttons,Messages, siComp, siLngLnk;
type
(*  TMyTrackBar=class(TTrackBar)
  protected
   procedure SuppressChange(Sender: TObject);
  public
   procedure TrackMousedown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
   constructor  Create(var AOwner: TComponent);
  end;
 *)
  TSetInteraction = class(TForm)
    Panel2: TPanel;
    tbSuppress: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    OKBitBtn: TBitBtn;
    BtnSpectr: TButton;
    lblSuppress: TLabel;
    AMLabel: TLabel;
    BitBtnCancel: TBitBtn;
    BitBtnHelp: TBitBtn;
    siLangLinked1: TsiLangLinked;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ProgressBar: TProgressBar;
    procedure OKBitBtnClick(Sender: TObject);
    procedure tbSuppressChange(Sender: TObject);
    procedure tbAmplitudChange(Sender: TObject);
    procedure ButtonSpectrClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure UpdateStrings;

  private
    { Private declarations }
    procedure WMMove(var Mes:TWMMove); message WM_Move;
  public
    { Public declarations }
  end;

var
  SetInteraction: TSetInteraction;

implementation

{$R *.DFM}
uses  GlobalType,GlobalDCl,FrSpectroscopy,FrSpectroscopyTerra,CSPMVar,GlobalVar,
     UNanoEduBaseClasses,UNanoEduClasses,UNanoEduInterface,nanoeduhelp, frScanWnd, 
     frApproachnew,mMain, MLPCVariablesThread;

var Count:integer;
const
	str1: string = ''; (*  mV *)
(*
procedure  TMYTrackBar.TrackMousedown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 inherited;
 Count:=0;
end;

constructor  TMYTrackBar.Create(var AOwner: TComponent);
begin
  inherited Create(AOwner);
   ONMouseDown:=TrackMousedown;
   ONchange:= SuppressChange;
end;

procedure  TMYTrackBar.SuppressChange(Sender: TObject);
var
t,V1,V2:double;
begin
 t:= Max*(1-(1-ApproachParams.LevelUAM)/ApproachParams.MaxSuppress);
if  (Position >t) and (not Assigned(ScanWnd)) then
 begin
 // flgError:=true;
  if count=0 then
  begin
    MessageDlg(siLangLinked1.GetTextOrDefault('IDS_0' { 'Error!!' } )+#13+{siLangLinked1.GetTextOrDefault('IDS_1' { 'Suppresion=' } )+FloattoStrF(1-Position/Max,fffixed,5,2)+siLangLinked1.GetTextOrDefault('IDS_2' { ' is too small.' } )+#13+siLangLinked1.GetTextOrDefault('IDS_3' { ' Open the Options Window and increase Probe Amplitude Level.'  ),mtWarning ,[mbOK],0);
    inc(count);
  end;
  Position:=round(t{tbSuppress.Max)-12;
  exit;
 end;
 V1:=(TSetInteraction(parent.parent).tbAmplitud.Max-TSetInteraction(parent.parent).tbAmplitud.Position)/TSetInteraction(parent.parent).tbAmplitud.Max;
 V2:=(Max-Position)/TSetInteraction(parent.parent).tbSuppress.Max;
 TSetInteraction(parent.parent).tbInteract.SelEnd:=round(TSetInteraction(parent.parent).tbInteract.Max*V1*V2);
 TSetInteraction(parent.parent).lblSuppress.Caption:=FloatToStrF(ApproachParams.MaxSuppress*V2,fffixed,4,2);
end;                              }
*)
procedure TSetInteraction.WMMOve(var Mes:TWMMove);
begin
    if Mes.YPos<(Main.ToolBarMain.Height div 2) then Top:=5;//Main.ToolBarMain.Height+1;
end;

procedure TSetInteraction.OKBitBtnClick(Sender: TObject);
var
valDiscr:apitype;
 val:word;
begin
with ApproachParams do
begin
// Amp_M:=tbAmplitud.Max-tbAmplitud.Position;
if assigned(Approach) then
 begin
  LandingSetPoint:=1-MaxSuppress*(tbSuppress.Max-tbSuppress.Position)/tbSuppress.Max;
//  LandingSetPoint:=1-0.01*round(100*MaxSuppress*(tbSuppress.Max-tbSuppress.Position)/tbSuppress.Max+0.5);
  NanoEdu.SetPoint:=LandingSetPoint;
  Approach.SignalsMode.LbSuppress.Caption:=FloatToStrF((1-LandingSetPoint),fffixed,4,2);
  Approach.SignalsMode.LbSuppressI.Caption:=FloatToStrF((1-LandingSetPoint),fffixed,4,2);
  Approach.SignalIndicator.LowLimit:=round(ApproachParams.LandingSetPoint*ApproachParams.UAMMax);
 end;
if assigned(ScanWnd)  then
 begin
  //ApproachParams.SetPoint:=1-round(MaxSuppress*(tbSuppress.Max-tbSuppress.Position)/tbSuppress.Max+0.5);
  ApproachParams.SetPoint:=1-MaxSuppress*(tbSuppress.Max-tbSuppress.Position)/tbSuppress.Max;

  if not assigned(VarsThread) or (not VarsThreadActive) then // make sure its not already running
                                begin
                                 VarsThread:= TMLPCVariablesThread.Create;
                                 VarsThreadActive := True;
                               end ;
 // NanoEdu.SetPoint:=ApproachParams.SetPoint;
  ScanWnd.SignalsMode.LbSuppress.Caption:=FloatToStrF((1-SetPoint),fffixed,4,2);
  ScanWnd.SignalsMode.LbSuppressI.Caption:=FloatToStrF((1-SetPoint),fffixed,4,2);
end;
end;
//  val:=tbAmplitud.Max-tbAmplitud.Position;
// (NanoEdu as TSFMNanoEdu).ModAmplitud:=val;
 Close;
end;

procedure TSetInteraction.siLangLinked1ChangeLanguage(Sender: TObject);
begin

  UpdateStrings;
end;

procedure TSetInteraction.tbSuppressChange(Sender: TObject);
var
t,V1,V2:double;
begin
 t:= tbSuppress.Max*(1-(1-ApproachParams.LevelUAM)/ApproachParams.MaxSuppress);
if  (tbSuppress.Position >t) and (not Assigned(ScanWnd)) then
 begin
  tbSuppress.Position:=round(t)-1;
 end;
 V1:=(ApproachParams.Amp_M)/ApproachParams.MaxAmp_M;//(tbAmplitud.Max-tbAmplitud.Position)/tbAmplitud.Max;
 V2:=(tbSuppress.Max-tbSuppress.Position)/tbSuppress.Max;
 Progressbar.position:=2*round(Progressbar.Max*V1*V2);
// lblSuppress.Caption:=FloatToStrF(0.01*round(100*ApproachParams.MaxSuppress*V2+0.5),fffixed,4,2);
 lblSuppress.Caption:=FloatToStrF(ApproachParams.MaxSuppress*V2,fffixed,4,2);
end;

procedure TSetInteraction.UpdateStrings;
begin
  str1 := siLangLinked1.GetTextOrDefault('strstr1');
end;

procedure TSetInteraction.tbAmplitudChange(Sender: TObject);
var
V1,V2,val:single;
begin
 V1:=(ApproachParams.Amp_M)/ApproachParams.MaxAmp_M;//(tbAmplitud.Max-tbAmplitud.Position)/tbAmplitud.Max;
 V2:=(tbSuppress.Max-tbSuppress.Position)/tbSuppress.Max;
  Progressbar.position:=2*round(Progressbar.Max*V1*V2);
 val:=ApproachParams.Amp_M;
    if val>0 then AMLabel.Caption:=FloattoStrF(val,ffFixed,5,0)+str1 (* ' mV' *)
             else AMLabel.Caption:=str1 (* '1 mV' *) ;
 flgBlickNorm:=true;
end;

procedure TSetInteraction.ButtonSpectrClick(Sender: TObject);
   var x0,y0:apitype;
begin
    SetIntActOnProgr:=True;
    if not assigned(ScanWnd) then   { TODO : 021007 }
    begin
     if not assigned(ArPntSpector) then  ArPntSpector:=TList.Create;    ////
      ArPntSpector.Clear;
      ArPntSpector.Capacity:=1;
    end  { TODO : 071007 }
    else ScanWnd.BitBtnPointClearClick(Sender);    { TODO : 021007 }
      Application.processmessages;
      new(PntSpector);
      X0:=abs(API.DACX);
      Y0:=abs(API.DACY);
      PntSpector^.Point.x:=round(x0);  //convert disc to nm
      PntSpector^.Point.y:=round(y0);
      ArPntSpector.Add(PntSpector);
      SpectrParams.NCurves:=2;           //  ??????
      SpectrParams.NSpectrPoints:=ArPntSpector.Count;
        { TODO : 160606 }
      if not assigned(ScanWnd) then ScanData:=TExperiment.Create;

               case  flgUnit of
         Terra:  SpectrWndTerra:=TSpectroscopyTerra.Create(Application);
           else  SpectrWnd:=TSpectroscopy.Create(Application);
                              end;

     // SpectrWnd.Show;//Modal;
       { TODO : 220607 }
    if assigned(ScanWnd)        then  ScanWnd.WindowState:=wsMinimized;
    if Assigned(Approach)       then  Approach.WindowState:=wsMinimized;
    if Assigned(SetInteraction) then  SetInteraction.WindowState:=wsMinimized;
end;

procedure TSetInteraction.FormClose(Sender: TObject; var Action: TCloseAction);
var i:Integer;
begin
  if Assigned(Approach) then
  begin
   Approach.TimerUp.Enabled:=TimerBackUpState;
   flgStopTimer:=false;
  end;
    SetIntActOnProgr:=False;  { TODO : 160606 }
  if (not assigned(ScanWnd)) and assigned(ScanData) then FreeAndNil(ScanData);
  { TODO : 250907 }
  if  assigned(ArPntSpector) then
    begin
    for i := 0 to (ArPntSpector.Count - 1) do
     begin
      PntSpector := ArPntSpector.Items[i];
      Dispose(PntSpector);
     end;
      ArPntSpector.Clear;   { TODO : 021007 }
      if not assigned(ScanWnd) then  FreeAndNil(ArPntSpector); { TODO : 021007 }
    end;
     { TODO : 250907 }
    Action:=caFree;
    SetInteraction:=NIL;
end;

procedure TSetInteraction.FormCreate(Sender: TObject);
 var V1,V2,val:single;
begin
 siLangLinked1.ActiveLanguage:=Lang;
 UpdateStrings;

 if (not flgStopScan) or (not FlgStopApproach) then BtnSpectr.Enabled:=False
                                               else BtnSpectr.Enabled:=True ;
(* if assigned(ScanWnd) then tbAmplitud.Enabled:=False
                      else tbAmplitud.Enabled:=True;
 if flgApproachOK     then tbAmplitud.Enabled:=False
                      else tbAmplitud.Enabled:=True;
 { TODO : 140306 }
  tbAmplitud.Enabled:=False;
(*
 with tbAmplitud do
  begin
   Min:=0;
   Max:=ApproachParams.MaxAmp_M;
   Frequency:=1;
   Position:=Max-ApproachParams.Amp_M;
   Brush.Color:=clSilver;
  end;
  *)
   flgBlickNorm:=false;
 with tbSuppress do
  begin
   Min:=0;
   Max:=100;
   Frequency:=2;
   if assigned(Approach) then Position:=Max-round((1-ApproachParams.LandingSetPoint)*Max/ApproachParams.MaxSuppress);
   if assigned(ScanWnd)  then Position:=Max-round((1-ApproachParams.SetPoint)*Max/ApproachParams.MaxSuppress);
   Brush.Color:=clSilver;
  end;


 V1:=(ApproachParams.Amp_M)/ApproachParams.MaxAmp_M;
 V2:=(tbSuppress.Max-tbSuppress.Position)/tbSuppress.Max;
  Progressbar.position:=2*round(Progressbar.Max*V1*V2);
 lblSuppress.Caption:=FloatToStrF(ApproachParams.MaxSuppress*V2,fffixed,4,2);
 val:=ApproachParams.Amp_M;
    if val>0 then AMLabel.Caption:=FloattoStrF(val,ffFixed,5,0)+str1(* ' mV' *)
             else AMLabel.Caption:=str1 (* '1 mV' *) end;

procedure TSetInteraction.BitBtnCancelClick(Sender: TObject);
begin
   close;
end;

procedure TSetInteraction.BitBtnHelpClick(Sender: TObject);
begin
    if not STMFlg then  HlpContext:=IDH_Set_Interaction{21};
    Application.HelpContext(HlpContext);
end;
end.


