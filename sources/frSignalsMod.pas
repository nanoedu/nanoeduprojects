unit frSignalsMod;
//220503
interface

uses 
  Windows, Messages, SysUtils,math, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons,siComp, siLngLnk,mMain, frdebug, Menus,
  ImgList;

type
  TSignalsMod = class(TFrame)
    Panel3: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    PageControl1: TPageControl;
    tbSFM: TTabSheet;
    Panel1: TPanel;
    PanelGain: TPanel;
    tbSTM: TTabSheet;
    Panel4: TPanel;
    PanelBias: TPanel;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    GainFMBtn: TButton;
    btnSetPoint: TButton;
    Label4: TLabel;
    tbSFMCUR: TTabSheet;
    Panel6: TPanel;
    Panel7: TPanel;
    Button2: TButton;
    Label7: TLabel;
    BtnBiasSFM: TBitBtn;
    BtnBiasV: TBitBtn;
    LbSuppress: TLabel;
    siLangLinkedf1: TsiLangLinked;
    LbSuppressI: TLabel;
    sbTi: TScrollBar;
    LabelFB: TLabel;
    PopupMenu1: TPopupMenu;
    Rough1: TMenuItem;
    Fine1: TMenuItem;
    SpeedBtnFineTi: TSpeedButton;
    ImageList1: TImageList;
    procedure BtnSetInterClick(Sender: TObject);
    procedure GainFMBtnClick(Sender: TObject);
 //   procedure FrequencyTrackChange(Sender: TObject);
    procedure btnSetPointClick(Sender: TObject);
    procedure btnBiasVClick(Sender: TObject);
    procedure sbTiScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure Fine1Click(Sender: TObject);
    procedure Rough1Click(Sender: TObject);
    procedure SpeedBtnFineTiClick(Sender: TObject);

  private
    flgPidTiFine:boolean;
         FixTi:single;
    { Private declarations }
  public
    { Public declarations }

    constructor Create(AOwner: TComponent); override;
  end;
 var
    BtnFlg:integer;

implementation

{$R *.DFM}
uses mSetSignal, frSetInteraction,CSPMVar ,GlobalVar, GlobalType,GLOBALFUNCTION,
     frApproachnew,frExperimParams,UNanoEduBaseClasses, MLPCVariablesThread,
     SystemConfig, frScanWnd;

constructor TSignalsMod.Create(AOwner: TComponent);
begin
    inherited;

    flgPidTiFine:=false;
    //LabelFB.Caption:=IntToStr(PIDParams.Ti);
//   if assigned(approach) then
    LabelFB.Caption:=FloatToStrf(PIDParams.Ti, fffixed,5,2);
    //   if assigned(ScanWnd)  then LabelFB.Caption:=FloatToStrf(PIDParams.TiScan, fffixed,5,2);
    //LabelFB.caption:='0';
    PageControl1.TabHeight:=1;
   // FrequencyTrack.Min:=0;
   // FrequencyTrack.Max:=40;
   // FrequencyTrack.Position:= -round(PIDParams.Ti);
    GainFMbtn.Caption:=FloattoStrF(ApproachParams.Gain_FM,fffixed,5,2);
    btnBiasSFM.Caption:=FloattoStrF(ApproachParams.BiasV,fffixed,8,3)+' V';
    btnBiasV.Caption:=FloattoStrF(ApproachParams.BiasV,fffixed,8,3)+' V';
    case STMflg of
 true: begin
       if ApproachParams.BiasV<0 then  btnBiasV.Font.Color:=clBlue
                                 else  btnBiasV.Font.Color:=clRed ;
        sbTi.Max:=200;
        sbTi.Min:=0;
       end;
 false:begin
         if ApproachParams.BiasV<0 then  btnBiasSFM.Font.Color:=clBlue
                                   else  btnBiasSFM.Font.Color:=clRed ;
         sbTi.Max:=200;
         sbTi.Min:=0;     //-1000
        end;
                  end;

    btnSetPoint.Caption:=FloattoStrF(ApproachParams.SetPoint,fffixed,5,2)+' nA';
//  lbSuppress.Caption:=FloatToStrF((1-ApproachParams.SetPoint),fffixed,4,2);
end;

procedure TSignalsMod.Fine1Click(Sender: TObject);
begin
     flgPidTiFine:=True; //fine
     InitPIDFine(abs(PidParams.Ti), PidParams.TiAbsMax, PidParams.pidTiL1,PidParams.pidTiL2);
     sbTi.Position:= round(sbTi.Max*(abs(PidParams.Ti)-PidParams.pidTiL1)/(PidParams.pidTiL2-PidParams.pidTiL1));
end;

procedure TSignalsMod.BtnSetInterClick(Sender: TObject);
begin
 SetInteraction:=TSetInteraction.Create(Application);
// SetInteraction.Show;//Modal;
end;

procedure TSignalsMod.GainFMBtnClick(Sender: TObject);
begin
 BtnFlg:=0;
 SetSignal:=TSetSignal.Create(self);
 SetSignal.ShowModal;
end;

procedure TSignalsMod.Rough1Click(Sender: TObject);
begin
 flgPidTiFine:=false;// rough
 sbTi.Position:= round(sbTi.Max*(abs(PidParams.Ti))/PidParams.TiAbsMax) ;
end;

procedure TSignalsMod.sbTiScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
var res:boolean;
 //   sgn:integer;
begin
(*    if STMFLG then   sgn:=-1//signf(ApproachParams.BiasV)//-1
              else   sgn:=1;
*)
      res:=false;
                case ScrollCode of
 scPosition,
 scTrack,
 scLineUp,
 scLineDown:
     begin
       if flgPidTiFine then//fine
        with  PidParams do
        begin
        if assigned(Approach) then
         begin
          TiApproach:=floor(FixTi)+ sbTi.Position/(sbTi.Max-sbTi.Min);
          Ti:=TiApproach;
         end
         else
         begin
          TiScan:=floor(FixTi)+ sbTi.Position/(sbTi.Max-sbTi.Min);
          Ti:=TiScan;
         end;
          LabelFB.Caption:=FloattoStrF(PidParams.Ti, fffixed,5,2);
        end
      else
        begin    // rough
        if assigned(Approach) then
        begin
          PidParams.TiApproach:= sbTi.Position;
          PidParams.Ti:=PidParams.TiApproach;
        end
        else
        begin
           PidParams.TiScan:= sbTi.Position;
           PidParams.Ti:=PidParams.TiScan;
        end;
          LabelFB.Caption:=FloattoStrF(PidParams.Ti, fffixed,5,2);     //0
        end;
     end;
 scEndScroll:
     begin
      if flgPidTiFine then//fine
        with  PidParams do
        begin
        if assigned(Approach) then
         begin
          TiApproach:=floor(FixTi)+ sbTi.Position/(sbTi.Max-sbTi.Min);
          Ti:=TiApproach;
         end
         else
         begin
          TiScan:=floor(FixTi)+ sbTi.Position/(sbTi.Max-sbTi.Min);
          Ti:=TiScan;
         end;
          LabelFB.Caption:=FloattoStrF(PidParams.Ti, fffixed,5,2);
        end
      else
      begin    // rough
        if assigned(Approach) then
        begin
          PidParams.TiApproach:= sbTi.Position;
          PidParams.Ti:=PidParams.TiApproach;
        end
        else
        begin
           PidParams.TiScan:= sbTi.Position;
           PidParams.Ti:=PidParams.TiScan;
        end;
          LabelFB.Caption:=FloattoStrF(PidParams.Ti, fffixed,5,2);       //0
      end;
             while  not res do
              begin
               res:= NanoEdu.SetPIDParameters;
               {$IFDEF DEBUG}
               if not res then Formlog.memolog.Lines.add('Set PID ERROR');
              {$ENDIF}
               end;
     end;
                end; //case
end;

procedure TSignalsMod.SpeedBtnFineTiClick(Sender: TObject);
var minsb,maxsb:integer;
begin
flgPidTiFine:=SpeedBtnFineTi.down;
  if flgPidTiFine then
          begin         //fine
           FixTi:=PIDParams.Ti;
          end
          else
          begin
           sbTi.position:=round(PIDParams.Ti);
          end;
end;

(*procedure TSignalsMod.FrequencyTrackChange(Sender: TObject);
var val:PIDType;
begin
   PIDParams.Ti:=-FrequencyTrack.Position;
   val:=FrequencyTrack.Position;
   LabelFB.Caption:=floatToStrf(PIDParams.Ti, fffixed,5,2);
   if Assigned(ApproachOpt) then
     ApproachOpt.ApproachOptGrid.Cells[1,10]:=Format('%d',[Approachparams.FreqBandF]);
   Nanoedu.FeedBackBand:=val;
end;
  *)
procedure TSignalsMod.btnSetPointClick(Sender: TObject);
begin
  BtnFlg:=1;
  siLangLinkedf1.ActiveLanguage:=lang;
  SetSignal:=TSetSignal.Create(self);
  SetSignal.ShowModal;
  if ApprOnProgr then
   with Approach.SignalIndicator do
            begin
     (*         if flgUnit<>pipette then
               begin
               if round(abs(ApproachParams.LandingSetPoint*TransformUnit.nA_d*ApproachParams.ScaleMaxIT))>MaxApitype
                     then ApproachParams.ScaleMaxIT:=1;
                Maximum:=round(abs(ApproachParams.LandingSetPoint*TransformUnit.nA_d*ApproachParams.ScaleMaxIT){/ITCor})//101210
               end
               else *)
               begin
                if round(abs(ApproachParams.LandingSetPoint*TransformUnit.nA_d))>Maximum then
                 silangLinkedf1.MessageDlg(siLangLinkedf1.GetTextOrDefault('IDS_3' {* 'Increase Maximum value of the I indicator!' *} ) ,mtWarning ,[mbOK],0)
               end;
          //    Value:=round((ApproachParams.SetPoint)*TransformUnit.nA_d);
              HighLimit:=round((ApproachParams.LevelIT)*TransformUnit.nA_d);
              LowLimit:= round((ApproachParams.SetPoint)*TransformUnit.nA_d);
             end;
end;

procedure TSignalsMod.btnBiasVClick(Sender: TObject);
begin
  BtnFlg:=2;
  SetSignal:=TSetSignal.Create(self);
  SetSignal.ShowModal;
end;
end.
