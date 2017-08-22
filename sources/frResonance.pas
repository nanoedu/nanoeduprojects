// 21022017
unit frResonance;

interface

uses
  Windows,Messages, Menus, StdCtrls, ExtCtrls, Buttons, Controls, Classes,
  SysUtils, Graphics,  Forms, Dialogs,ShellApi,
  Series,TeeProcs, Chart, ComCtrls,SpmChart, Math,QuickRpt, QRCtrls,
  ClipBrd, AppEvnts, siComp, siLngLnk, ImgList, ToolWin,
  {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
   Globaltype,CSPMVar;

type
  TAutoResonance = class(TForm)
    Panel1: TPanel;
    Regime: TRadioGroup;
    PanelMain: TPanel;
    MainMenu: TMainMenu;
    Edit: TMenuItem;
    CopytoClipboard: TMenuItem;
    CopytoFile: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    Panel4: TPanel;
    PanelGr: TPanel;
    PanelBottom: TPanel;
    Panel2: TPanel;
    PanelManual: TPanel;
    Panel3: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    AMLabel: TLabel;
    AMGainLabel: TLabel;
    sbAmpMod: TScrollBar;
    rgManual: TRadioGroup;
    Panel6: TPanel;
    Bevel3: TBevel;
    Label4: TLabel;
    ComboBoxFQ_SEl: TComboBox;
    siLangLinked1: TsiLangLinked;
    Label3: TLabel;
    PanelT: TPanel;
    Bevel5: TBevel;
    Label5: TLabel;
    ScrollBarT: TScrollBar;
    LabelT: TLabel;
    ToolBarOpt: TToolBar;
    BitBtnOk: TToolButton;
    Optionsbtn: TToolButton;
    ToolButton1: TToolButton;
    BitBtnprint: TToolButton;
    ToolButton3: TToolButton;
    ImageListdis: TImageList;
    CopySaveDialog: TSaveDialog;
    Panelstart: TPanel;
    ToolBarControl: TToolBar;
    StartBtn: TToolButton;
    PanelVpipette: TPanel;
    PanelV: TPanel;
    LabelV: TLabel;
    ScrollBarV: TScrollBar;
    ToolButton2: TToolButton;
    PanelCustom: TPanel;
    Bevel1: TBevel;
    ScrollBarFrom: TScrollBar;
    ScrollBarTo: TScrollBar;
    Label2: TLabel;
    Label6: TLabel;
    LblFromVal: TLabel;
    LblToval: TLabel;
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OptionsbtnClick(Sender: TObject);
    procedure ScrollBarTChange(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure sbAmpModChange(Sender: TObject);
//    procedure sbAMGainChange(Sender: TObject);
    procedure RegimeClick(Sender: TObject);
    procedure OKBitBtnClick(Sender: TObject);
    procedure rgManualClick(Sender: TObject);
    procedure ComboBoxFQ_SELClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnTutorClick(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure CopytoFileClick(Sender: TObject);
    procedure CopytoClipboardClick(Sender: TObject);
    procedure PanelManualMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ApplicationEventsMessage(var Msg: tagMSG;   var Handled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;   Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ScrollBarVScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ToolButton2Click(Sender: TObject);
    procedure sbAmpModScroll(Sender: TObject; ScrollCode: TScrollCode;var ScrollPos: Integer);
    procedure ScrollBarTScroll(Sender: TObject; ScrollCode: TScrollCode;var ScrollPos: Integer);
    procedure BitBtn1Click(Sender: TObject);
    procedure ScrollBarFromScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ScrollBarToScroll(Sender: TObject; ScrollCode: TScrollCode;  var ScrollPos: Integer);
    procedure ScrollBarToChange(Sender: TObject);
    procedure ScrollBarFromChange(Sender: TObject);
  private
    { Private declarations }
     flgResonanceActive:boolean;
     flgCanClose:boolean;
     flgMadeFine:boolean;
     flgMadeRough:boolean;
     DBegin, AutomatFlag:Boolean;
     T:word;
     fAmplMax:double;
     BottAxMin,BottAxMax:single;
     QuickRep: TQuickRep;
     QRLabel:TQRLabel;
     DetailBand: TQRBand;
     QRImageTop: TQRImage;
     Q,frq:double;
     procedure OnListUpdate(Sender: TObject);
     procedure OnChannelUpdate(Sender: TObject);
     procedure GetData;
     procedure RoughRegime;
     procedure FineRegime;
//   procedure FineRegimeDraw;
     procedure SetPriborParameters(Sender: TObject);
     procedure RestoreStart;
     procedure WMMove(var Mes:TWMMove); message WM_Move;
     procedure WMNCLButton(var Message: TMessage); message WM_NCLButtonDown;
     function  CreateQuickReportComponent:boolean;
     procedure GetResonanceFreq(var Frq:double;var Q:double);
     function  GetQ(iMax:integer):double;
     procedure EnableControls();
     procedure DisableControls();
 protected
     procedure CreateParams(var Params:TCreateParams); override;
public
    { Public declarations }
    flgCancel:boolean;
    flgRegime:integer;  //rough=0 fine=1;
    flgMode:integer;   //auto=1 -manual=0;
    ChartPanel: TChartResonance;
    ResonanceCurve: TLineSingle;
    ResonanceFreqVals: TLineSingle;
    procedure NormalizeUAM;
    procedure SaveAmplitudesAsASCII(Const FileName:string);
    procedure ThreadDone(var AMessage : TMessage); message WM_ThreadDoneMsg;
//    procedure UserMessage (var Msg: TMessage); message WM_UserResWndUpdated;
    procedure ResonanceParamUpdate;
end;

var
 AutoResonance: TAutoResonance;

implementation

uses GlobalVar,NL3LFBLib_TLB,MLPC_APILib_TLB,SioCSPM,nanoeduhelp,SystemConfig,mMain,fShockwave,UNanoEduBaseClasses,
     UNanoEduInterface,UNanoEduClasses,GlobalDcl,GlobalFunction,ResDrawThread, frReport, FrInform;

{$R *.DFM}
const

	strr0: string = ''; (* Printer is not connected.   *)
	strr1: string = ''; (* Max amplitude>1,4. Decrease probe voltage modulation and repeat. *) // TSI: Localized (Don't modify!)

procedure TAutoResonance.ResonanceParamUpdate;
var val:word;
begin
   with   ResonanceParams do
        begin
            case Sensor.kind of
probe:begin
         FreqStartRough:=FreqStartProbeRough;//8000;
         FreqEndRough:=FreqEndProbeRough; // 10000;
         ApproachParams.Amp_M:=ApproachParams.AmpProbe_M ;
         ComboBoxFQ_SEL.ItemIndex:=0;
      end;
cantilever:
       begin
         FreqStartRough:=FreqStartCantRough;//8000;
         FreqEndRough:=FreqEndCantRough; // 10000;
         ApproachParams.Amp_M:=ApproachParams.AmpCant_M;
         ComboBoxFQ_SEL.ItemIndex:=1;
         PanelCustom.visible:=true;
       end;
        end;
         FreqStart:=FreqStartRough;  //Hrz
         FreqEnd:=FreqEndRough;
        end;
  LblFromVal.caption:=inttostr(ResonanceParams.FreqStart div 1000);
  LblToVal.Caption:=inttostr(ResonanceParams.FreqEnd div 1000);
  ScrollBarFrom.Position:= ResonanceParams.FreqStart div 1000;
  ScrollBarTo.Position:= ResonanceParams.FreqEnd div 1000;
  val:= ApproachParams.Amp_M;
 if val>0 then AMLabel.Caption:=FloattoStrF(val{/1000}{/255},ffFixed,5,0)+siLangLinked1.GetTextOrDefault('IDS_16' { ' mV' } )
          else AMLabel.Caption:=siLangLinked1.GetTextOrDefault('IDS_17' { '1 mV' } ); ;
     BottAxMin:=ResonanceParams.FreqStart;
     BottAxMax:=ResonanceParams.FreqEnd;
 with ChartPanel.Chart.BottomAxis do
     begin
      Automatic:=False;
      SetMinMax(BottAxMin,BottAxMax);
     end;
end;
function TAutoResonance.GetQ(iMax:integer):double;     //Check !!!!!
var
 i:integer;
 i1,i2:integer;
 frq,UM,{fAmplMax,}fAmplMin:double;
begin
if ChartPanel.Series1.XValues.Count>0 then
begin
 fAmplMin:=0;
 fAmplMax:=ResonanceCurve[Imax];
 UM:=(fAmplMax-fAmplMin)/2;
 i2:=iMax;
 i1:=iMax;
 i:=imax;
repeat
  if ChartPanel.Series1.YValues.Value[i]< (UM+fAmplMin) then
    begin
     i1:=i;
     break ;
   end;
   dec(i);
until i=0;
  i:=imax;
repeat
  if ChartPanel.Series1.YValues.Value[i]< (UM+fAmplMin) then
    begin
      i2:=i;
      break ;
     end;
     inc(i);
until i=ChartPanel.Series1.XValues.Count-1;
  Result:=1;
  if (i2-i1)<>0 then  Result:=(i2-i1)*(ChartPanel.Series1.XValues[1]-ChartPanel.Series1.XValues[0]);
end;
end;

procedure  TAutoResonance.GetResonanceFreq(var Frq:double;var Q:double);
var i,IMax:integer;
    fAmplMax:double;
    NPoints:integer;
  begin
      fAmplMax:=MinDATATYPE;
      i:=0;
      if (AutoResonance.flgMode=Manual) or
           ((AutoResonance.flgMode=Auto) and (AutoResonance.flgRegime=Rough)) then
           begin
            if ChartPanel.Series1.XValues.Count>0 then
             repeat
               begin
                if ChartPanel.Series1.YValues.Value[i] >fAmplMax then
                   begin
                       fAmplMax:=ChartPanel.Series1.YValues.Value[i];
                       frq:=ChartPanel.Series1.XValues.Value[i];
                       Imax:=i;
                  end;
                 inc(i);
              end;
              until i>(ChartPanel.Series1.XValues.Count-1);

             Q:=frq/GetQ(IMax);
           end
           else
           begin
             NPoints:= length(ResonanceCurve);
             if NPoints > 0 then
             repeat
               begin
                if ResonanceCurve[i] >fAmplMax then
                   begin
                     fAmplMax:=ResonanceCurve[i];
                     frq:=ResonanceFreqVals[i];
                     Imax:=i;
                   end;
                   inc(i);
               end;
            until i>(NPoints-1);     // edited 170227
           end;


end;




procedure TAutoResonance.OnChannelUpdate(Sender: TObject);
var nout:Integer;
begin
(*  PCChanelInBufRead:= arPCChannel[0] as  IMLPCChannelRead;
 if assigned(PCChanelInBufRead) then
 begin
   PCChanelInBufRead.get_Count(nout);
   if(nout=2*ResonanceParams.NPoints) then ; //read data in
 end;
 *)
end;

 procedure TAutoResonance.CreateParams(var Params:TCreateParams);
begin
inherited CreateParams(Params);
 Params.Style:=Params.Style xor WS_SizeBOX;// xor WS_MaximizeBox;
end;

procedure TAutoResonance.SaveAmplitudesAsASCII(const FileName:string);
var Fl:TextFile;
    s:STRING;
    i,j:integer;
    Year, Month, Day, Hour, Minut, Sec, MSec: Word;
    Present: TDateTime;
    presentdate:string;
begin
if flgMadeRough or flgMadeFine then
begin
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minut, Sec, MSec);
  presentdate:=intTostr(day)+'.'+inttostr(month)+'.'+inttostr(year);
 try
    AssignFile(Fl, FileName);
    ReWrite(Fl);
    S:='File Format = ASCII';
    Writeln(Fl, S);
    S:=IdentifDemo;
    Writeln(Fl, S);
    S:='File: '+FileName;
    Writeln(Fl, S);
    Writeln(Fl, 'NX = ',ResonanceParams.Npoints);
    Writeln(Fl, Format('Scale X = %5.2f',[1.0]));
    Writeln(Fl, Format('Scale Data = %8.5f',[ResonanceParams.AmplStep]));
    Writeln(Fl, 'Bias X = 0,0');
    Writeln(Fl, 'Bias Data = ',0);
    Writeln(Fl, 'Unit X = ', 'Hz');
    Writeln(Fl, 'Unit Data = ','V');
    Writeln(Fl,  'Start of Data : ');

    for i:=0 to ResonanceParams.Npoints-1 do
        begin
         Write(Fl,Format('%8.2f',[ChartPanel.Series1.XValues[i]]),';',Format('%8.5f',[ChartPanel.Series1.YValues[i]]),';');
        end;
  finally
    CloseFile(Fl);
  end;
end;
end;
procedure TAutoResonance.ThreadDone(var AMessage: TMessage); // keep track of when and which thread is done executing
var
 val,i,im:integer;
     z:apitype;
     hr:Hresult;
 begin
 if  (mDrawing=AMessage.WParam)then
  begin
    if assigned(ResThread) then
     begin
        ResThread:=nil;
        ResThreadActive := false;
     end;
  case Regime.Itemindex of
Auto:begin   //auto
       //set resonance
  //    if flgRegime=Rough then //290216
       begin
        GetResonanceFreq(frq,Q);
        ResonanceParams.ResFreq:=round(frq);
        flgMadeRough:=true;
      end;
       ChartPanel.SetFindLine_pos(ResonanceParams.ResFreq);
      ChartPanel.Chart.Title.Text.Clear;
      ChartPanel.Chart.Title.Text.Add(siLangLinked1.GetTextOrDefault('IDS_24' { 'Probe Oscillation Amplitude' }) );
      ChartPanel.QLabel.caption:='; Q= '+FloatToStrF(Q,ffFixed,6,1);
      if flgMadeFine then
      begin
         ChartPanel.IsAutoDetection:=False;
         RestoreStart;
      end;
      Application.ProcessMessages;
      if not flgMadeFine then
      begin
        FlgStopResonance:=False;
        FineRegime;
        while assigned(nanoedu.method) do application.ProcessMessages;
        NanoEdu.ResonanceMethod;
        Application.ProcessMessages;
        FlgStopResonance:=False;
        if NanoEdu.Method.Launch<>0 then
        begin FreeAndNil(NanoEdu.Method); RestoreStart; exit end;
        if flgRegime=Fine  then    flgMadeFine:=true;
      end
      else //set res freq in java ;
       end ;
Manual:begin  //manual
        if flgRegime=Rough then    flgMadeRough:=true;
        if flgRegime=Fine  then    flgMadeFine:=true;
        GetResonanceFreq(frq,Q);
        ResonanceParams.ResFreq:=round(frq);
        ChartPanel.SetFindLine_pos(Resonanceparams.ResFreq);
        ChartPanel.Chart.Title.Text.Clear;
        ChartPanel.Chart.Title.Text.Add(siLangLinked1.GetTextOrDefault('IDS_24' { 'Probe Oscillation Amplitude' }) );
        ChartPanel.QLabel.caption:='; Q= '+FloatToStrF(Q,ffFixed,6,1);
        RestoreStart;
        Application.ProcessMessages;
      end;
         end;
    if (fAmplMax>1.4) then  silanglinked1.MessageDlg(strr1{'Max amplitude>1,4. Decrease probe voltage modulation and repeat.'},mtwarning,[mbYes],0);
    
   end;//drawthread
 if mScanning=AMessage.WParam then
    begin
     if  flgControlerTurnON   then
      begin
        NanoEdu.Method.FreeBuffers;
        FreeAndNil(NanoEdu.Method);
      end;
      //if Regime.Itemindex = Auto then       //changed 010316
     //         RestoreStart;
    end;
end;


procedure TAutoResonance.ToolButton2Click(Sender: TObject);
begin
if  flgResonanceActive then
   if assigned(Nanoedu.Method) then
   begin
    flgStopJava:=true;
    Nanoedu.Method.StopWork
   end;
end;

procedure TAutoResonance.WMMOve(var Mes:TWMMove);
begin
    if Mes.YPos<(Main.ToolBarMain.Height div 2) then Top:=5;//Main.ToolBarMain.Height+1;
end;

procedure TAutoResonance.WMNCLButton(var Message: TMessage);
 begin
      case Message.wParam of
HTCAPTION:
          begin
           if AltDown  then        // copy to clipboard    for report
             if  assigned(ReportForm) then
             begin
               PanelGr.BeginDrag(False);
               Main.CopyToClipBoardExecute(self);
               ReportForm.CaptureSourceImage(PanelGr);
             end;
           end;
      end;
      inherited;
      //
 end;



function TAutoResonance.CreateQuickReportComponent:boolean;
begin
   result:=true;
  if not Assigned(QuickRep) then
  begin
    result:=true;
    try
     QuickRep:=TQuickRep.Create(self);
    except
     begin
      silanglinked1.MessageDlg(strr0{ 'Printer is not connected.  '},mtwarning,[mbYes],0);
      result:=false;
      exit;
     end;
    end
  end
  else
  begin
    freeandnil(QRImageTop);
    freeAndNil(QRLabel);
    freeAndNil(DetailBand);
    FreeandNil(QuickRep);
    try
     QuickRep:=TQuickRep.Create(self);
    except
     begin
      silanglinked1.MessageDlg(strr0{ 'Printer is not connected.  '},mtwarning,[mbYes],0);
      result:=false;
      exit;
     end;
    end
  end;
    QuickRep.Parent:=self;
    QuickRep.visible:=false;
    DetailBand:=TQRBand.Create(QuickRep);;
    DetailBand.parent:=QuickRep;
    QRLabel:=TQRLabel.Create(DetailBand);
    QRLabel.parent:=DetailBand;
    QRImageTop:=TQRImage.Create(DetailBand);;
    QRImageTop.parent:=DetailBand;
    Application.Processmessages;
end;

procedure TAutoResonance.ScrollBarFromChange(Sender: TObject);
begin
(*      lblFromVal.Caption:=inttostr(ScrollBarFrom.Position);
                  with   ResonanceParams do
                 begin
                     FreqStartRough:=ScrollBarFrom.Position*1000;
                     FreqStart:=FreqStartRough;
                     StepRough:=round((FreqEnd-FreqStart)/(Npoints-1));
                     Step:=StepRough;
                     BottAxMin:=round(FreqStart);
                     BottAxMax:=round(FreqEnd);
                     with ChartPanel.Chart.BottomAxis do
                     begin
                       Automatic:=False;
                       SetMinMax(BottAxMin,BottAxMax);
                     end;
                  end
                  *)
      
end;

procedure TAutoResonance.ScrollBarFromScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
case ScrollCode of
  scTrack,
 scLineUp,
 scLineDown:;
 scEndScroll: begin
 //               if ScrollPos<ScrollBarTo.Position then
                begin
                 lblFromVal.Caption:=inttostr(ScrollPos);
                  with   ResonanceParams do
                 begin
                     FreqStartRough:=ScrollPos*1000;
                     if (FreqStartRough>FreqEnd) then
                    begin
                      ScrollPos:=FreqEnd div 1000;
                      lblFromVal.Caption:=inttostr(ScrollPos);
                      exit;
                     end;
                     FreqStart:=FreqStartRough;
                     StepRough:=round((FreqEnd-FreqStart)/(Npoints-1));
                     Step:=StepRough;
                     BottAxMin:=round(FreqStart);
                     BottAxMax:=round(FreqEnd);
                     with ChartPanel.Chart.BottomAxis do
                     begin
                       Automatic:=False;
                       SetMinMax(BottAxMin,BottAxMax);
                     end;
                      case Sensor.kind of
                  probe:begin
                         FreqStartProbeRough:=FreqStartRough;//8000;
                         FreqEndProbeRough:=FreqEndRough; // 10000;
                        end;
            cantilever:begin
                         FreqStartCantRough:=FreqStartRough;//8000;
                         FreqEndCantRough:=FreqEndRough; // 10000;
                       end;
                             end;//case
                  end
                 end
             end;
   end;
end;

procedure TAutoResonance.ScrollBarTChange(Sender: TObject);
begin
(*
   ResonanceParams.Delay:=ScrollBarT.Position;
  LabelT.Caption:=inttostr(ResonanceParams.Delay);
  SetCommonUserVar(ch_Res_Delay,ResonanceParams.Delay);
*)
end;

procedure TAutoResonance.ScrollBarToChange(Sender: TObject);
begin
(*              lblToVal.Caption:=inttostr(ScrollBarTo.Position);
                 with ResonanceParams   do
                 begin
                  FreqEndRough:=ScrollBarTo.Position*1000;
                  FreqEnd:=FreqEndRough;
                  StepRough:=round((FreqEnd-FreqStart)/(Npoints-1));
                  Step:=StepRough;
                  BottAxMin:=round(FreqStart);
                  BottAxMax:=round(FreqEnd);
                     with ChartPanel.Chart.BottomAxis do
                     begin
                       Automatic:=False;
                       SetMinMax(BottAxMin,BottAxMax);
                    end;
                 end
  *)
end;

procedure TAutoResonance.ScrollBarToScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
case ScrollCode of
   scTrack,
 scLineUp,
 scLineDown:;
 scEndScroll:begin
              // if ScrollPos>ScrollBarFrom.Position then
                begin
                   lblToVal.Caption:=inttostr(ScrollPos);
                 with ResonanceParams   do
                 begin
                  FreqEndRough:=ScrollPos*1000;
                    if (FreqEndRough<FreqStart) then
                    begin
                      ScrollPos:=FreqStart div 1000;
                      lblToVal.Caption:=inttostr(ScrollPos);
                      exit;
                     end;
                  FreqEnd:=FreqEndRough;
                  StepRough:=round((FreqEnd-FreqStart)/(Npoints-1));
                  Step:=StepRough;
                  BottAxMin:=round(FreqStart);
                  BottAxMax:=round(FreqEnd);
                     with ChartPanel.Chart.BottomAxis do
                     begin
                       Automatic:=False;
                       SetMinMax(BottAxMin,BottAxMax);
                    end;
                 end
                end
               (*& else
                begin
                 ScrollBarTo.Position:=ScrollBarFrom.Position+1;
                 Application.ProcessMessages;
                end;  *)
               end;
                                  end;
end;

procedure TAutoResonance.ScrollBarTScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   case ScrollCode of
scEndScroll:begin
             ResonanceParams.Delay:=ScrollBarT.Position;
             LabelT.Caption:=inttostr(ResonanceParams.Delay);
             if assigned(NanoEdu.Method) then  NanoEdu.Method.SetUsersParams;
        //   SetCommonUserVar(ch_UserParams,ResonanceParams.Delay);
            end;
                end;
end;

procedure TAutoResonance.ScrollBarVScroll(Sender: TObject;  ScrollCode: TScrollCode; var ScrollPos: Integer);
var val:word;
     v:single;
begin


       case ScrollCode of
(* scTrack,
 scLineUp,
 scLineDown:
            begin      // Vt
                V:=ScrollPos/TransformUnit.BiasV_d;
               if ScrollPos<0 then   LabelV.Font.Color:=clBlue
                              else   LabelV.Font.Color:=clRed ;
                 LabelV.caption:=FloattoStrF(V,fffixed,8,3)+ ' V' ;
                 ApproachParams.BiasV:=ScrollPos/TransformUnit.BiasV_d;
                 if (not assigned(Nanoedu.Method)) and (NanoEdu.BramUflg=0)then  NanoEdu.Bias:=apiType(ScrollPOS)
                                                 else
                                                 begin
                                                   if  NanoEdu.BramUflg=0 then NanoEdu.Bias:=apiType(ScrollPOS)
                                                                          else  Nanoedu.Method.SetUsersParams;
                                                 end;

             end;
             *)
 scEndScroll:
             begin
               V:=ScrollPos/TransformUnit.BiasV_d;
               if ScrollPos<0 then   LabelV.Font.Color:=clBlue
                              else   LabelV.Font.Color:=clRed ;

               LabelV.caption:=FloattoStrF(V,fffixed,8,3)+ ' V' ;
               ApproachParams.BiasV:=ScrollPos/TransformUnit.BiasV_d;
               if (not assigned(Nanoedu.Method)) and (NanoEdu.BramUflg=0)then  NanoEdu.Bias:=apiType(ScrollPOS)
                                                 else
                                                 begin
                                                   if  NanoEdu.BramUflg=0 then NanoEdu.Bias:=apiType(ScrollPOS)
                                                                          else Nanoedu.Method.SetUsersParams;
                                                 end;
                end;
                     end;
 end;

procedure TAutoResonance.SetPriborParameters(Sender: TObject);
var Pos:single;
    val:longword;
begin
      Pos:= ChartPanel.FindLine_pos;
      val:=round(Pos);
      Api.Frequency:=val;
      ResonanceParams.ResFreq:=round(Pos); //Hrz
(*      case rgManual.ItemIndex of
 Rough: begin         //rough
    {  ApproachParams.ResFreqR:=round((ChartPanel.FindLine_pos/ApproachParams.F0-1)/(5.4*0.001))+$80;
      if ApproachParams.ResFreqR<0 then ApproachParams.ResFreqR:=0;
       API.SDGenf_R:=ApproachParams.ResFreqR;  }
     //  (NanoEdu as TSFMNanoEdu).ScannerResonance.FreqVal:=(Pos);
        Api.Frequency:=Pos;
      end;
 Fine: begin
    {  ApproachParams.ResFreqF:=$80+round((ChartPanel.FindLine_pos/ApproachParams.F0-1-5.4*0.001*(ApproachParams.ResFreqR-$80))/(5.4*0.0001));
      API.SDGenf_F:=ApproachParams.ResFreqF;
     }
    //   (NanoEdu as TSFMNanoEdu).ScannerResonance.FreqValFine:=(Pos);
    end;
        end;
*)
end;
procedure TAutoResonance.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TAutoResonance.RestoreStart;
begin
   FlgStopResonance:=True;
   flgStopJava:=false;
 //  StartBtn.enabled:=True;
   BitBtnOK.enabled:=True;
 //  Main.Landing.Visible:=true;    // 160114
   BitBtnOK.visible:=True;
   flgResonanceActive:=false;
   StartBtn.down:=False;
   EnableControls();
//   BitBtnCancel.enabled:=True;
//   Application.ProcessMessages;
end;
procedure TAutoResonance.BitBtnHelpClick(Sender: TObject);
begin
   HlpContext:=IDH_Resonance;
   Application.HelpContext(HlpContext);
end;
procedure TAutoResonance.ComboBoxFQ_SELClick(Sender: TObject);
var  fq:integer;
begin
//  fq:= StrToInt(ComboBoxFQ_SEL.TEXT );
 // (NanoEdu as TSFMNanoEdu).ScannerResonance.SDFreq:=fq;
  rgManual.ItemIndex:=0;//rough;
 PanelCustom.Visible:=ComboBoxFQ_SEL.Itemindex=1;
 with     ResonanceParams    do
 begin
  case ComboBoxFQ_SEL.ItemIndex of
 0: begin
     rgManual.ItemIndex:=0;
     PanelCustom.Visible:=false;
     ResonanceParamsDef;
     FreqStartRough:=FreqStartProbeRough;
     FreqStart:=FreqStartRough;
     FreqEndRough:=FreqEndProbeRough;
     FreqEnd:=FreqEndRough;
     StepRough:=round((FreqEnd-FreqStart)/(Npoints-1));
     Step:=StepRough;
    end;
 1: begin
     rgManual.ItemIndex:=0;
     PanelCustom.Visible:=true;
                 case Sensor.kind of
probe:begin
         FreqStartRough:=FreqStartProbeRough;//8000;
         FreqEndRough:=FreqEndProbeRough; // 10000;
      end;
cantilever:
       begin
         FreqStartRough:=FreqStartCantRough;//8000;
         FreqEndRough:=FreqEndCantRough; // 10000;
       end;
        end;
     LblFromVal.Caption:=inttostr(FreqStartRough div 1000);
     LblToVal.caption:=inttostr(FreqEndRough div 1000);
     FreqStart:=FreqStartRough;
     FreqEnd:=FreqEndRough;
     StepRough:=round((FreqEnd-FreqStart)/(Npoints-1));
     Step:=StepRough;
    end;
             end;
                 BottAxMin:=round(FreqStart);
                 BottAxMax:=round(FreqEnd);
                     with ChartPanel.Chart.BottomAxis do
                     begin
                       Automatic:=False;
                       SetMinMax(BottAxMin,BottAxMax);
                     end;
 end;
end;

procedure TAutoResonance.FormCreate(Sender: TObject);
var    val:word;
    lkoef:single;
   NewItem:TMenuItem;
   hr:Hresult;
begin
 if FlgTrans then
  begin
   Rgn:= CreateRectRgn(0,0,Width,Height);
   CombineRgn(FullRgn, FullRgn, Rgn, rgn_or);
   SetWindowRgn(Handle, FullRgn, True);
  end;

  Main.ComboBoxSFMSTM.Enabled:=false;
  flgResonanceActive:=false;
  FlgStopResonance:=True;
  flgStopJava:=false;
  flgCancel:=true;
  siLangLinked1.ActiveLanguage:=Lang;
  UpdateStrings;
  Application.ProcessMessages;
  Top:=TopStart;
  left:=(main.Clientwidth-Clientwidth) div 2;

  BitBtnOK.enabled:=false;
  BitBtnOK.visible:=false;


  Height:=520;//520;
  if (flgUnit=Nano) or (flgUnit=NanoTutor) or (flgUnit=Pipette) then  Height:=580;
  Width:=800;
  ChartPanel:= TChartResonance.Create(TComponent(Self));
  ChartPanel.OnSetPriborParameters:= SetPriborParameters;
  ChartPanel.Align:=alClient;
  ChartPanel.Parent:=PanelGr;
  ChartPanel.Color:= $00DCDDDB;//clGray;
  ChartPanel.AxisXLabel.Caption:= siLangLinked1.GetTextOrDefault('IDS_15' (* 'kHz' *) );
  ChartPanel.AxisYLabel.Caption:= siLangLinked1.GetTextOrDefault('IDS_22' (* 'V' *) );
  ChartPanel.PanelResult.Visible:=False;
// ***
      with   ResonanceParams do
        begin
            case Sensor.kind of
probe:begin
         FreqStartRough:=FreqStartProbeRough;//8000;
         FreqEndRough:=FreqEndProbeRough; // 10000;
         ComboBoxFQ_SEL.ItemIndex:=0;
      end;
cantilever:
       begin
         FreqStartRough:=FreqStartCantRough;//8000;
         FreqEndRough:=FreqEndCantRough; // 10000;
         ComboBoxFQ_SEL.ItemIndex:=1;
         PanelCustom.visible:=true;
       end;
               end;
         FreqStart:=FreqStartRough;  //Hrz
         FreqEnd:=FreqEndRough;
        end;
 // if   ComboBoxFQ_SEL.Items.count=1 then
   // begin
     // ComboBoxFQ_SEL.Items.Add('Custom');
//      ComboBoxFQ_SEL.Items.Add('28');
//      ComboBoxFQ_SEL.Items.Add('29');//50 Hrz in old electronic
//      ComboBoxFQ_SEL.Items.Add('30');
//      ComboBoxFQ_SEL.Items.Add('31');
//    end;
//  {$ENDIF}
    
    flgMadeFine:=false;
    flgMadeRough:=false;
    flgMode:=Auto; //Manual;//
    flgRegime:=Rough;
   Regime.ItemIndex:=flgMode;
   rgManual.ItemIndex:=flgRegime;
     case Regime.ItemIndex of
1:begin //manual
    case  rgManual.ItemIndex  of
   Rough:  RoughRegime;
    Fine:  FineRegime;
       end;
    PanelManual.visible:=True;
    rgmanual.enabled:=true;
    ChartPanel.IsAutoDetection:=False;
    sbAmpMod.Enabled:=true;
//    sbAmGain.Enabled:=true;
    ComboBoxFQ_SEl.Enabled:=true;
  end;
0:begin    //auto
     RoughRegime;
     PanelManual.visible:=false;
     rgmanual.enabled:=false;
     sbAmpMod.Enabled:=false;
 //    sbAmGain.Enabled:=false;
     ChartPanel.IsAutoDetection:=True;
     ComboBoxFQ_SEl.Enabled:=false;
  end;
     end;
  Main.Landing.Visible:=False;
  Main.Scanning.Visible:=False;
  Main.Training.Visible:=False;
  MainMenu.Items.Add(ChartPanel.EditChartMenu);


   PanelCustom.Visible:=false;
   (*
   case  flgUnit   of
   ProBeam,
   micProbe:
    begin
     PanelCustom.visible:=true;
     ComboBoxFQ_SEL.ItemIndex:=1;
    end;
          end;
     *)

 (*   if (Sensor.kind=Sensor.kind) then
    begin
     //  flgMode:=Manual;//
    //   flgRegime:=Rough;
       PanelCustom.visible:=true;
       ComboBoxFQ_SEL.ItemIndex:=1;
    end;
   *)

  LblFromVal.caption:=inttostr(ResonanceParams.FreqStart div 1000);
  LblToVal.Caption:=inttostr(ResonanceParams.FreqEnd div 1000);
  ScrollBarFrom.Position:= ResonanceParams.FreqStart div 1000;
  ScrollBarTo.Position:= ResonanceParams.FreqEnd div 1000;
//  ChartPanel.IsAutoDetection:=True;    //81211
  DBegin:=False;
 case Sensor.kind of
probe:begin
         ApproachParams.Amp_M:=ApproachParams.AmpProbe_M
      end;
cantilever:
       begin
         ApproachParams.Amp_M:=ApproachParams.AmpCant_M
       end;
        end;

 val:= ApproachParams.Amp_M;
 if val>0 then AMLabel.Caption:=FloattoStrF(val{/1000}{/255},ffFixed,5,0)+siLangLinked1.GetTextOrDefault('IDS_16' (* ' mV' *) )
          else AMLabel.Caption:=siLangLinked1.GetTextOrDefault('IDS_17' (* '1 mV' *) ); ;
 with sbAMPMod do
  begin
   Min:=1;
   Max:=ApproachParams.MaxAmp_M;//($FF-1);     1000*val/255
   Position:=val;
  end;
  NanoEdu.SD_GAM:=round(ApproachParams.Amp_M*2.5/1000*TransformUnit.BiasV_d);

with ScrollBarT do
  begin
   Min:=1;
   Max:=1000;
   Position:=Resonanceparams.Delay;
  end;
  PanelV.Visible:=false;
  if (flgUnit=Pipette) or (flgUnit=nanoTutor) or (flgUnit=Nano) then
  begin
   panelVPipette.visible:=true;
   PanelV.Visible:=true;
   with ScrollBarV do
   begin
      min:=-32768;
      max:=32767;
      Position:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
      LargeChange:=10;
      Smallchange:=1;
      if Position<0 then   LabelV.Font.Color:=clBlue
                    else   LabelV.Font.Color:=clRed ;
      LabelV.Caption:=FloattoStrF(ApproachParams.BiasV,fffixed,8,3)+ ' V';
   end;
  end;
     LabelT.Caption:=inttostr(Resonanceparams.Delay);
     BottAxMin:=ResonanceParams.FreqStart;
     BottAxMax:=ResonanceParams.FreqEnd;
 with ChartPanel.Chart.BottomAxis do
     begin
      Automatic:=False;
      SetMinMax(BottAxMin,BottAxMax);
     end;
 with ChartPanel.Chart.LeftAxis do
     begin
      Automatic:=false;//False;
      SetMinMax(0,2.5);
     end;
if (FlgCurrentUserLevel=Demo) then
 begin
   ComboBoxFQ_SEl.enabled:=false;
 end;

       NewItem := TMenuItem.Create(Self);
       NewItem.Caption :='-';
       Main.mWindows.Add(NewItem);
       NewItem := TMenuItem.Create(Self);
       NewItem.Caption := self.Caption;
       NewItem.OnClick:=Main.ActivateMenuItem;
       Main.mWindows.Add(NewItem);
end;

procedure TAutoResonance.FormDeactivate(Sender: TObject);
begin
// Main.ActionExport.enabled:=false;
// Main.ActionSaveAs.enabled:=false;
end;

procedure TAutoResonance.StartBtnClick(Sender: TObject);
begin
DisableControls();
Finalize(ResonanceCurve);
SetLength(ResonanceCurve,ResonanceParams.Npoints);
Finalize(ResonanceFreqVals);
SetLength(ResonanceFreqVals,ResonanceParams.Npoints);
if not flgResonanceActive then
begin
  flgResonanceActive:=true;
  BitBtnOK.enabled:=False;
  BitBtnOK.visible:=false;
  Application.ProcessMessages;
  FlgStopResonance:=False;
  FlgMakeNormalize:=True;
  flgMadeFine :=false;
  ChartPanel.Series1.Clear;   //clear chart
  case Regime.Itemindex of
0:begin   //auto
   RoughRegime;
  // if flgMadeRough then FineRegime;
  end ;
1:begin  //manual
     case rgManual.ItemIndex of
     0: RoughRegime;     //rough
     1:begin //fine
         if flgMadeRough then FineRegime
         else
         begin
          Inform:=TInform.Create(Application);
          Inform.labelinf.caption:=siLangLinked1.GetTextOrDefault('IDS_23' { 'Please ,first  make rough!!' } );
          Inform.Show;
          application.processmessages;
          sleep(1500);
          Inform.close;
         // EnableControls();  // Заменено на RestoreStart, т.к. если Fine вызывался
         // без Rough, то не сбрасывался флаг flgResonanceActive, и программа зависала
         RestoreStart;
          exit;
         end;
      end;
           end;
  end;
     end;
    NanoEdu.ResonanceMethod;
    if NanoEdu.Method.Launch<>0 then
     begin FreeAndNil(NanoEdu.Method); RestoreStart; exit end;
end;
end;

procedure TAutoResonance.UpdateStrings;
begin
  strr1 := siLangLinked1.GetTextOrDefault('strstrr1' (* 'Max amplitude>1,4. Decrease probe voltage modulation and repeat.' *) );
  strr0 := siLangLinked1.GetTextOrDefault('strstrr0');
end;

procedure TAutoResonance.NormalizeUAM;
begin
    (Nanoedu as TSFMNanoEdu).NormalizeUAM;
    FlgMakeNormalize:=false;
    flgBlickNorm:=false;
    Sleep(200);
end;


procedure TAutoResonance.OnListUpdate(Sender: TObject);
//create PC<->java channels
var IU:IUNknown;
    IEU:IEnumUnknown;
    IU2: IUNknown;
    PCChannel:IMLPCChannel;
    PCChannelRead:IMLPCChannelRead;
    ncount:LongWord;
    i,res,n:integer;
    ID:Integer;
begin
(*  PCChannelManagerT.EnumChannels(IU);
  IEU:=IU as  IEnumUnknown;
  IEU.RemoteNext(ResonanceParams.nchannel,IU2,ncount);
  if ncount=ResonanceParams.nchannel then
  begin
   setlength(arPCChannel,ResonanceParams.nchannel);
   IEU.ReSet;
   i:=0;
  repeat
  begin
   IEU.RemoteNext(1,IU2,ncount);
   arPCChannel[i]:=IU2 as IMLPCChannel;       //???       create only in channel
   inc(i);
  end
  until i<=ResonanceParams.nchannel;
//   PCChannelEvents:=IEU as _IMLPCChannelEvents;
//   PCChannelEvents.OnUpdate:=OnChannelUpdate; //    ???? event function
   setlength(arPCChannelRead,1);
   arPCChannelRead[0]:= arPCChannel[0] as IMLPCChannelRead;
  end
  else
  begin
   //release? \
   IU2._Release;
   IU._Release;
  end;
  *)
end;
procedure  TAutoResonance.GetData;
begin



end;


procedure TAutoResonance.RoughRegime;
var i:integer;
    iFreq:single;
    QRes:single;
begin
 flgMadeRough:=FALSE;
 flgRegime:=Rough;
 ChartPanel.Chart.LeftAxis.Automatic:=true;
 ChartPanel.Series1.Clear;
 with ResonanceParams do
 begin
  FreqStart:=FreqStartRough;
  FreqEnd:=FreqEndRough;
  Step:=round((FreqEnd-FreqStart)/(Npoints-1));//ResonanceParams.StepRough;
  BottAxMin:=round(FreqStart);
  BottAxMax:=round(FreqEnd);
 end;
  with ChartPanel.Chart.BottomAxis do
    begin
      Automatic:=False;
      SetMinMax(BottAxMin,BottAxMax);
    end;
    flgMadeFine:=false;
end;

procedure TAutoResonance.sbAmpModChange(Sender: TObject);
//var val:word;
begin
(* val:=sbAmpMod.Position ;
 if val>0 then AMLabel.Caption:=FloattoStrF(1000*val/255,ffFixed,5,0)+siLangLinked1.GetTextOrDefault('IDS_16' { ' mV' }) )
          else AMLabel.Caption:=siLangLinked1.GetTextOrDefault('IDS_17' { '1 mV' } );
 ApproachParams.Amp_M:=val;
(NanoEdu as TSFMNanoEdu).ModAmplitud:=ApproachParams.Amp_M;
*)
end;

procedure TAutoResonance.sbAmpModScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var val:word;
begin
   case  ScrollCode of
  scEndScroll: begin
                val:=sbAmpMod.Position ;
                if val>0 then AMLabel.Caption:=FloattoStrF(val{/1000}{*val/255},ffFixed,5,0)+siLangLinked1.GetTextOrDefault('IDS_16' (* ' mV' *) )
                         else AMLabel.Caption:=siLangLinked1.GetTextOrDefault('IDS_17' (* '1 mV' *) );

             with   ResonanceParams do
        begin
            case Sensor.kind of
probe:begin
           ApproachParams.AmpProbe_M :=val;
        end;
cantilever:
       begin
           ApproachParams.AmpCant_M :=val;
       end;
                  end;
        end;
             ApproachParams.Amp_M:=val;           //mV
      //          NanoEdu.SD_GAM:=round(ApproachParams.Amp_M/1000*TransformUnit.BiasV_d);//*32;   //????  250112
                  case flgUnit of
            Nano:  NanoEdu.SD_GAM:=round(ApproachParams.Amp_M*2.5/1000*TransformUnit.BiasV_d);      
            Probeam,
            MicProbe,
            terra,
            Pipette:  NanoEdu.SD_GAM:=round(ApproachParams.Amp_M*2.5/1000*TransformUnit.BiasV_d);
                  end;
              end;
                   end;
end;

(*rocedure TAutoResonance.sbAMGainChange(Sender: TObject);
var val:word;
begin
  val:=sbAMGain.Position;
  if val/($FF-val)<1 then AMGainLabel.Caption:=FloatToStrF(val/($FF-val),ffFixed,5,1)
                     else AMGainLabel.Caption:=FloatToStrF(val/($FF-val),ffFixed,5,0);
 ApproachParams.Gain_AM:=val;
(NanoEdu as TSFMNanoEdu).Gain_AM:=ApproachParams.Gain_AM;
// API.SDGain_AM:=ApproachParams.Gain_AM;
end;
*)
procedure TAutoResonance.RegimeClick(Sender: TObject);
begin
 case Regime.ItemIndex of
1:begin    //manual
    PanelManual.visible:=True;
    ChartPanel.IsAutoDetection:=False;
    sbAmpMod.Enabled:=true;
 //   sbAmGain.Enabled:=true;
    rgmanual.enabled:=true;
    ComboBoxFQ_SEl.Enabled:=true;
   if (FlgCurrentUserLevel=Demo) then
   begin
     ComboBoxFQ_SEl.enabled:=false;
   end;
    case ComboBoxFQ_SEL.ItemIndex of
 0: begin
     PanelCustom.Visible:=false;
    end;
 1: begin
     PanelCustom.Visible:=true;
    end;
       end;
    flgMode:=Manual;
  //  PanelMain.Height:=Panel1.Height+20+PanelManual.Height;
  end;
0:begin    //auto
    PanelManual.visible:=false;
    sbAmpMod.Enabled:=false;
    rgmanual.enabled:=false;
//    sbAmGain.Enabled:=false;
    ChartPanel.IsAutoDetection:=True;
    ComboBoxFQ_SEl.Enabled:=false;
    flgMode:=Auto;
 //   PanelMain.Height:=Panel1.Height+20;
  end;
     end;//    Range:=0;
end;

procedure TAutoResonance.OKBitBtnClick(Sender: TObject);
begin
  FlgStopResonance:=false;
  BitBtnOK.enabled:=false;
 with ApproachParams do
  begin
    Amp_M:=sbAmpMod.Position;
//    Gain_AM:=sbAMGain.Position;
  end;
 if not flgMadeRough  then
  begin
   Inform:=TInform.Create(Application);
   Inform.labelinf.caption:=siLangLinked1.GetTextOrDefault('IDS_23' (* 'Please ,first  make rough!!' *) );
   Inform.Show;
   application.processmessages;
   sleep(1000);
   Inform.close;
   exit;
  end;
(* if not flgMadeFine   then
  begin
   Inform:=TInform.Create(Application);
   Inform.labelinf.caption:=siLangLinked1.GetTextOrDefault('IDS_29' { 'Please, wait while the fine regime is making!!' } );
   Inform.Show;
   application.processmessages;
   FineRegime;
   Inform.close;
  end;
*)
  FlgResonance:=True;
  NormalizeUAM;
  Main.LandingFast.Visible:=true;
  Main.Resonance.Enabled:=True;
  Main.Resonance.visible:=True;
  Main.LandingFast.Visible:=true;
  Main.Landing.Enabled:=True;
  Main.Landing.visible:=True;
  Main.Resonance.visible:=True;
//if FlgUnit<>SEM then
  Main.Training.visible:=True;
  Main.ToolBtnLanding.Hint:=siLangLinked1.GetTextOrDefault('IDS_30' (* 'Landing' *) );
  Main.ScanBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_31' (* 'Landing before Scanning' *) );
  Application.processmessages;
  FlgStopResonance:=true;
  flgCancel:=false;
  Close;
end;

procedure TAutoResonance.OptionsbtnClick(Sender: TObject);
begin
  Main.ShowOptionsExecute(Sender);
end;

procedure TAutoResonance.rgManualClick(Sender: TObject);
begin
 //  Range:=rgManual.ItemIndex;
       case rgManual.ItemIndex of
   Rough:    RoughRegime;
    Fine:    FineRegime;
       end;
end;

(*procedure TAutoResonance.FineRegimeDraw;
var i:integer;
    iFreq:single;
    QRes:single;
begin
 ChartPanel.Chart.LeftAxis.Automatic:=True;
 BottAxMin:=ApproachParams.F0*(1+ResonanceParams.koef{5.45}*0.001*(ApproachParams.ResFreqR{FreqR}-$80)+ResonanceParams.koef{5.45}*0.0001*(-$80));
 BottAxMax:=ApproachParams.F0*(1+ResonanceParams.koef{5.45}*0.001*(ApproachParams.ResFreqR{FreqR}-$80)+ResonanceParams.koef{5.45}*0.0001*($FF-$80));
 ChartPanel.Chart.BottomAxis.Increment:=((BottAxMax-BottAxMin)/(NanoEdu as TSFMNanoEdu).ScannerResonance.Dx);
 ChartPanel.Series1.Clear;
   with ChartPanel.Chart.BottomAxis do
     begin
      Automatic:=False;
      SetMinMax(BottAxMin,BottAxMax);
     end;
  ChartPanel.Series1.Clear;
 if  (NanoEdu as TSFMNanoEdu).ScannerResonance.GetAmplitudes(Fine)>0 then exit;
 for i:=0 to ((NanoEdu as TSFMNanoEdu).ScannerResonance.Dx-1) do
            begin

              iFreq:=ApproachParams.F0*(1+ResonanceParams.koef{5.45}*0.001*(ApproachParams.ResFreqR{FreqR}-$80)+ResonanceParams.koef*0.0001*(i-$80));

              ChartPanel.Series1.AddXY(iFreQ,(NanoEdu as TSFMNanoEdu).ScannerResonance.U[i]/TransformUnit.Uv_d16,'',clRed);

            end;
     ChartPanel.SetFindLine_pos(ApproachParams.F0*(1+ResonanceParams.koef{5.45}*0.001*(ApproachParams.ResFreqR-$80)+ResonanceParams.koef{5.45}*0.0001*(ApproachParams.ResFreqF-$80)));
  flgMadeFine:=true;
  { TODO : 141005 }
//     ChartPanel.Chart.Title.Text.Clear;
//     ChartPanel.Chart.Title.Text.Add('');
//     ChartPanel.Chart.Title.Text.Add('Q= '+FloatToStrF((NanoEdu as TSFMNanoEdu).ScannerResonance.QRes,ffFixed,6,1));
end;
*)
procedure TAutoResonance.FineRegime;
begin
 flgMadeFine:=true;
 flgRegime:=Fine;
 ResonanceParams.FreqStartFine:=ResonanceParams.ResFreq-ResonanceParams.DeltaFine;
 ResonanceParams.FreqEndFine:=ResonanceParams.ResFreq+ResonanceParams.DeltaFine;
 ResonanceParams.FreqStart:=ResonanceParams.FreqStartFine;
 ResonanceParams.FreqEnd:=ResonanceParams.FreqEndFine;
 ResonanceParams.Step:=round((ResonanceParams.FreqEnd-ResonanceParams.FreqStart)/(ResonanceParams.Npoints-1));
 BottAxMin:=ResonanceParams.FreqStart;
 BottAxMax:=ResonanceParams.FreqEnd;
// if AutoResonance.flgMode=Manual then      //290216
  begin
     ChartPanel.Series1.Clear;
    with ChartPanel.Chart.BottomAxis do
    begin
      Automatic:=False;
      SetMinMax(BottAxMin,BottAxMax);
    end;
  end;
end;

procedure TAutoResonance.FormActivate(Sender: TObject);
begin
// Main.ActionExport.enabled:=flgMadeRough or flgMadeFine;
// Main.ActionSaveAs.enabled:=flgMadeRough or flgMadeFine;
end;

procedure TAutoResonance.FormClose(Sender: TObject;var Action: TCloseAction);
begin
//  Main.ActionExport.enabled:=false;
//  Main.ActionSaveAs.enabled:=false;
  Finalize(ResonanceCurve);
  Finalize(ResonanceFreqVals);

  Main.Resonance.Visible:=true;
  Main.ToolBtnLanding.Hint:=siLangLinked1.GetTextOrDefault('IDS_30' (* 'Landing' *) );
  Main.ScanBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_31' (* 'Landing before Scanning' *) );
   with ResonanceParams do
   begin
 case  flgUnit of
probeam,
micprobe:begin
         FreqStart:=FreqStartRough;
         FreqEnd:=FreqEndRough;
        end;
nano,
nanotutor,
pipette,
terra:begin
           FreqStartRough:=FreqStartProbeRough;
           FreqStart:=FreqStartRough;
           FreqEndRough:=FreqEndProbeRough;
           FreqEnd:=FreqEndRough;
          end;
         end;
     StepRough:=round((FreqEnd-FreqStart)/(Npoints-1));
     Step:=StepRough;
   end;
 if assigned(ScanData)   then FreeAndNil(ScanData);
 if assigned(QRLabel)    then FreeAndNil(QRLabel);
 if assigned(QRImageTop) then FreeAndNil(QRImageTop);
 if assigned(DetailBand) then FreeAndNil(DetailBand);
 if assigned(QuickRep)   then FreeAndNil(QuickRep);
  ChartPanel.Destroy;
  Action:=caFree;
  AutoResonance:=nil;
  if not flgCancel then Main.LandingExecute(Sender)
                   else
                   begin
                    Main.Training.Visible:=true;
                    Main.Landing.Visible:=false;
                    Main.ComboBoxSFMSTM.Enabled:=true;
                   end;
end;

procedure TAutoResonance.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not FlgStopResonance then
    begin
      siLangLinked1.ShowMessage(siLangLinked1.GetTextOrDefault('IDS_32' (* 'Wait to finish before exit!!!' *) ));
      CanClose := False;
    end
    else  CanClose := True;
end;

procedure TAutoResonance.BitBtn1Click(Sender: TObject);
begin
 Javacontrol.IsRunning(flgJavaRunning);
 showmessage(booltostr(flgJavaRunning));
end;

procedure TAutoResonance.BitBtnCancelClick(Sender: TObject);
begin
  Main.Resonance.Visible:=true;
  Main.ToolBtnLanding.Hint:=siLangLinked1.GetTextOrDefault('IDS_30' (* 'Landing' *) );
  Main.ScanBtn.Hint:=siLangLinked1.GetTextOrDefault('IDS_31' (* 'Landing before Scanning' *) );
  Close;
end;

procedure TAutoResonance.BitBtnTutorClick(Sender: TObject);
  var res:Thandle;
  filename:string;
 begin
 filename:=CommonNanoeduDocumentsPath+'Animation\resonance.swf';
 if  FileExists(filename) then
  begin
(*   res:= ShellExecute(handle,nil,Pchar(filename),nil,nil,SW_SHOWNORMAL or SW_RESTORE{ or SW_MAXIMIZE}	);
 if  Res<32 then
 begin
     case res of
SE_ERR_NOASSOC:begin
                 if silanglinked1.MessageDlg('There is no application associated with the given file name extension.Install flash player?',mtwarning,[mbYes,mbNo],0)=mrYes then
                 begin
                 if FileExists(InstallFlashplayerpath) then
                   ShellExecute(handle,nil,Pchar(InstallFlashplayerpath),nil,nil,SW_RESTORE or SW_MAXIMIZE	);
                 end;
               end;
                end; //case
 end;
 *)
  begin
    ShockWave:=TShockWave.create(Sender,Pchar(filename));
    ShockWave.Show;
    ShockWave.ShockwaveFlash.play;
  end;
(*
    ShockWave:=TShockWave.create(Sender,CommonNanoeduDocumentsPath{ExeFilePath}+'Animation\resonance.swf');
    ShockWave.Show;
    ShockWave.Caption:=siLangLinked1.GetTextOrDefault('IDS_37'Х 'Frequency Scanning. Adjust  Resonance' Ъ );
    ShockWave.ShockwaveFlash.play;
*)
  end;
end;


procedure TAutoResonance.BitBtnPrintClick(Sender: TObject);
var Bitmap_Pic:TBitmap;
    Rect,Rectd:TRect;
begin
  BitBtnPrint.enabled:=false;
  if not  CreateQuickReportComponent then  exit;
    Toolbaropt.visible:=false;
    Bitmap_Pic := TBitmap.Create;
 try
      Bitmap_pic.Width :=ClientWidth;
      Bitmap_pic.Height :=ClientHeight;
      Main.CopyToClipBoardExecute(self);
      Bitmap_pic.LoadFromClipBoardFormat(cf_BitMap,ClipBoard.GetAsHandle(cf_Bitmap),0);
      QuickRep.Visible:=false;
      QRLabel.Height:=20;
      QRLabel.top:=0;
      QRLabel.Left:= 0;
      QRLabel.Width:= QRLabel.Parent.Width;
      QRLabel.Alignment:= taCenter;
      QRLabel.Font.Size:= 16;
      QRLabel.Caption:= self.Caption;
      QRImageTop.AutoSize:= false;
      QRImageTop.Stretch:= true;
      QRImageTop.Top:= QRLabel.height;
      QRImageTop.Width:= (QRImageTop.Parent.ClientWidth div 4)*3;//  Bitmap_pic.Width
      QRImageTop.Height:=round(QRImageTop.Width*Bitmap_pic.Height/Bitmap_pic.Width);
      QRImageTop.Left:=(QRImageTop.Parent.Width - QRImageTop.Width) div 2;
      QRImageTop.Picture.Assign(BitMap_pic);
      QuickRep.PreviewModal;
      QuickRep.Visible:=false;
      BitBtnPrint.Enabled:=true;
      Toolbaropt.visible:=true;
 finally
      FreeAndNil(Bitmap_Pic);
 end;
end;

procedure TAutoResonance.CopytoFileClick(Sender: TObject);
var
  Bitmap: TBitmap;
begin
  CopySaveDialog.FilterIndex:=1;
  CopySaveDialog.Filter:='image  files *.bmp|*.bmp';
 if CopySaveDialog.execute then
  begin
    Main.CopytoClipBoardExecute(self);
    Bitmap := TBitMap.create;
    try
     Bitmap.LoadFromClipBoardFormat(cf_BitMap,ClipBoard.GetAsHandle(cf_Bitmap),0);
     Bitmap.SaveToFile(CopySaveDialog.FileName);
    finally
      FreeAndNil(Bitmap);
    end;
   end;
end;

procedure TAutoResonance.CopytoClipboardClick(Sender: TObject);
begin
    Main.CopytoClipBoardExecute(self);
end;

procedure TAutoResonance.PanelManualMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
(*   if (Button=mbLeft) and (ssAlt in Shift) then
       begin
             PostMessage(self.handle,WM_CopyClipboardMsg,0,0);
             PanelManual.BeginDrag(False);
       end;
*)       
end;
procedure TAutoResonance.ApplicationEventsMessage(var Msg: tagMSG;  var Handled: Boolean);
begin
 if flgDragForm then
  if Msg.message=WM_LButtonDown then
   begin
   if  getkeystate(VK_Menu)<0 then
    begin
       Panel1.BeginDrag(true);
       Main.CopytoClipboardExecute(self);
       handled:=true;
    end;
   end;
     flgDragForm:=false;
end;

procedure TAutoResonance.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
    if (ssAlt in Shift) then
    begin
      flgDragForm:=true;
    end;
    if (ssCtrl in Shift) then
     if (Key=ord('V')) then
      begin
          PanelV.Visible:= not PanelV.Visible;
          panelVPipette.visible:=not panelVPipette.visible;
      end;
end;

procedure TAutoResonance.FormKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if (ssAlt in Shift) then
    begin
      flgDragForm:=false;
    end
end;

procedure TAutoResonance.EnableControls();
begin
   StartBtn.Enabled:=True;
   Regime.Enabled:=True;
   Panel3.Enabled:=True;
   Panel6.Enabled:=True;
end;
procedure TAutoResonance.DisableControls();
begin
   StartBtn.Enabled:=false;
   Regime.Enabled:=False;
   Panel3.Enabled:=False;
   Panel6.Enabled:=False;
end;

end.


