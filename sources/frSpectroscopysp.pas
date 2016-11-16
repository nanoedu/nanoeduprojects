unit frSpectroscopysp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frParInput, ComCtrls, ToolWin, Buttons, ExtCtrls;

type
  TSpectroscopysp = class(TForm)
    StatusBar1: TStatusBar;
    Panel: TPanel;
    Panel6: TPanel;
    PageControl: TPageControl;
    Panel7: TPanel;
    BitBtnApply: TBitBtn;
    BitBtnSave: TBitBtn;
    BitBtnExit: TBitBtn;
    ToolBar2: TToolBar;
    PrintBtn: TToolButton;
    ToolButton1: TToolButton;
    PanelEditBtns: TPanel;
    PanelLabels: TPanel;
    PanelCurves: TPanel;
    Lblwarning: TStatusBar;
    ControlPanel: TPanel;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    StartBtn: TToolButton;
    Panel3: TPanel;
    Panel4: TPanel;
    FrT: TFrameParInput;
    FrNPoints: TFrameParInput;
    FrEndPoint: TFrameParInput;
    FrStartP: TFrameParInput;
    Panel5: TPanel;
    LabelStep: TLabel;
    LabelStepMin: TLabel;
    procedure StartBtnClick(Sender: TObject);
    procedure FrNPointsEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrTEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrTEditFrmChange(Sender: TObject);
    procedure FrNPointsEditFrmExit(Sender: TObject);
    procedure FrNPointsEditFrmChange(Sender: TObject);
    procedure FrStartPEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrEndPointEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrEndPointEditFrmChange(Sender: TObject);
    procedure FrStartPEditFrmExit(Sender: TObject);
    procedure FrStartPEditFrmChange(Sender: TObject);
  private
    { Private declarations }
       procedure TestStepSize;
  public
    { Public declarations }
  end;

var
  Spectroscopysp: TSpectroscopysp;

implementation

{$R *.dfm}

procedure TSpectroScopysp.TestStepSize;
begin
    LabelStep.Font.Color:=clBlack;
   if ZStep<ZStepMin then
     begin
      MessageDlg(strs2{'The step too small!'}+#13+strs3{'Change parameters to increase the step.'},mtWarning,[mbOk],0);
      LabelStep.Font.Color:=clRed;
     end;
end;
procedure TSpectroscopysp.FrEndPointEditFrmChange(Sender: TObject);
begin
   FrEndPoint.EditFrmChange(Sender);
try
 if  (FrEndPoint.EditFrm.Text='')  or (FrEndPoint.EditFrm.Text='-') then exit;
  EndPointZ:=StrToInt(FrEndPoint.EditFrm.Text);
   ZStep:=(EndPointZ-StartPointZ)/(NumbP-1);
   LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+ siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
   LabelStep.Font.Color:=clBlack;
  if ZStep<ZStepMin then
     begin
      LabelStep.Font.Color:=clRed;
     end;
    FrEndPoint.ScrollBarFrm.position:=EndPointZ;
except
    on EConvertError do
     begin MessageDlg(strs6{'error input'},mtWarning,[mbOk],0);FrEndPoint.editFrm.text:=siLangLinked.GetTextOrDefault('IDS_57' (* '100' *) );end;
 end;

end;


procedure TSpectroscopysp.FrEndPointEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
 FrEndPoint.EditFrmKeyPress(Sender, Key);
  if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TSpectroscopysp.FrNPointsEditFrmChange(Sender: TObject);
var val:integer;
begin
 try
  if (FrNpoints.editFrm.text='')  then   exit;
   val:=StrToInt(FrNpoints.EditFrm.Text);
    if val<FrNpoints.ScrollBarFrm.Min then
    begin
     val:=FrNpoints.ScrollBarFrm.Min;
     FrNpoints.EditFrm.Text:=inttostr(val);
    end;
    if val>FrNpoints.ScrollBarFrm.Max then
    begin
     val:=FrNpoints.ScrollBarFrm.Max;
     FrNpoints.EditFrm.Text:=inttostr(val);
    end;
    NumbP:=StrToInt(FrNPoints.EditFrm.Text);
    ZStep:=(EndPointZ-StartPointZ)/(NumbP-1);
    LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+ siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
    LabelStep.Font.Color:=clBlack;
    { TODO : 250607 }
    FrNpoints.ScrollBarFrm.position:=NumbP;
    if ZStep<ZStepMin then
     begin
      LabelStep.Font.Color:=clRed;
     end;
  except
    on EConvertError do
     begin MessageDlg(strs6{'error input'},mtWarning,[mbOk],0);FrNpoints.editFrm.text:=siLangLinked.GetTextOrDefault('IDS_57' (* '100' *) );end;
  end;

end;

procedure TSpectroscopysp.FrNPointsEditFrmExit(Sender: TObject);
begin
   TestStepSize
end;

procedure TSpectroscopysp.FrNPointsEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  FrNPoints.EditFrmKeyPress(Sender, Key);
   if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TSpectroscopysp.FrStartPEditFrmChange(Sender: TObject);
var Val:integer;
begin
  if (FrStartP.editFrm.text='') or (FrStartP.editFrm.text='-') then   exit;
  try
      val:=StrToInt(FrStartP.EditFrm.Text);
    if val<FrStartP.ScrollBarFrm.Min then
    begin
     val:=FrStartP.ScrollBarFrm.Min;
     FrStartP.EditFrm.Text:=inttostr(val);
    end;
    if val>FrStartP.ScrollBarFrm.Max then
    begin
     val:=FrStartP.ScrollBarFrm.Max;
     FrStartP.EditFrm.Text:=inttostr(val);
    end;
   StartPointZ:=StrToInt(FrStartP.EditFrm.Text);
    ZStep:=(EndPointZ-StartPointZ)/(NumbP-1);
    FrStartP.ScrollBarFrm.Position:=StartPointZ;
    LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+ siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
    LabelStep.Font.Color:=clBlack;
  if ZStep<ZStepMin then
     begin
      LabelStep.Font.Color:=clRed;
     end;
except
    on EConvertError do
     begin
      MessageDlg(strs5{'Error input. Start point must be <=0!'},mtWarning,[mbOk],0);
      FrStartP.editFrm.text:=siLangLinked.GetTextOrDefault('IDS_53' (* '-200' *) );
    end;
 end;
end;

procedure TSpectroscopysp.FrStartPEditFrmExit(Sender: TObject);
begin
   TestStepSize;
end;

procedure TSpectroscopysp.FrStartPEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
   FrStartP.EditFrmKeyPress(Sender, Key);
    if not(Key in ['-','0'..'9',#8]) then Key :=#0 ;
end;

procedure TSpectroscopysp.FrTEditFrmChange(Sender: TObject);
begin
  FrT.EditFrmChange(Sender);

end;

procedure TSpectroscopysp.FrTEditFrmKeyPress(Sender: TObject; var Key: Char);
begin
  FrT.EditFrmKeyPress(Sender, Key);

end;

procedure TSpectroscopysp.StartBtnClick(Sender: TObject);
var i,j,index:integer;
    x0nm,y0nm:double;
    nCor,NumbPupdate:apitype;
    ZStepD:word;//discr
begin
 if LabelStep.Font.Color=clRed then
 begin
  MessageDlg(strs2{'Step too small!'}+#13+strs3{'Change Parameters.'},mtError,[mbOk],0);
  exit;
 end;
 if Error=0 then
 begin
 try
    flgProcess:=true;
    Caption:=BaseCaption;
    StartBtn.Enabled:=False;
    BitBtnSave.Enabled:=false;
    BitBtnExit.Enabled:=false;
    inc(countStart);
    WorkNameFile:=workdirectory+'\'+WorkNameFileMaskCur+ScandataWorkFileNameEm(CountStart)+WorkExtFile;
    T:=StrToInt(FrT.EditFrm.Text);
    StartPointZ:=StrToInt(FrStartP.EditFrm.Text);        //nm
    EndPointZ:=StrToInt(FrEndPoint.EditFrm.Text);       //nm
    NumbP:=StrToInt(FrNPoints.EditFrm.Text);
    if  lflgIZ then VertMin:=round(StrtoInt(FrSupLevel.EditFrm.Text)*0.01*MaxApiType)
               else VertMin:=round((100-StrtoInt(FrSupLevel.EditFrm.Text))*0.01*ApproachParams.UAMMax);   //discr

//    StartBtn.Font.Color:=clRed;
    ZStep:=(abs(StartPointZ)+EndPointZ)/(NumbP-1);
    ZStepD:=round(ZStep*TransformUnit.Znm_d); //discrete
    nCor:=(round((EndPointZ-StartPointZ)*TransformUnit.Znm_d)-ZStepD*(NumbP-1)) div ZStepD;
    NumbPUpdate:=NumbP+nCor;
    lblWarning.Visible:=false;
   if ZStepD<1 then  begin  MessageDlg(strs4{siLangLinked1.GetTextOrDefault('IDS_46' (* 'Step too small!Change Parameters.' *) )},mtWarning,[mbOk],0); exit; end;
    LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+ siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
    SpectrParams.StartP:=StartPointZ;    //nm
    SpectrParams.EndP:=EndPointZ;       //nm
    SpectrParams.NPoints:=NumbPUpdate;
    SpectrParams.NSpectrPoints:=ArPntSpector.Count;  //number point when spectroscopy are  made
    SpectrParams.T:=T ;
    SpectrParams.TC:=ApproachParams.ScannerDecay;
    SpectrParams.LevelSFM:=StrtoInt(FrSupLevel.EditFrm.Text);
    SpectrParams.Step:=ZStep;  { TODO : 220506 }
     j:=0;

    ScanData.AquiSpectr.Data:=nil;   // 2*(UAM,Z)*Npoints
    ScanData.AquiSpectrPoint:=nil;

    SetLength(ScanData.AquiSpectr.Data,SpectrParams.NSpectrPoints,2*2*SpectrParams.NPoints);   // 2*(UAM,Z)*Npoints
    SetLength(ScanData.AquiSpectrPoint,3*SpectrParams.NSpectrPoints);
   { TODO : 290507 }
    ScanData.HeaderPrepare;

   for i:=0 to (NPage-1) do ArChart[i].ClearAllSeries;

   j:=0;
   for i:=0 to NPage-1 do
    begin
      PntSpector:=ArPntSpector.items[i];
      x0nm:=PntSpector^.point.x;
      y0nm:=PntSpector^.point.y;
      ScanData.AquiSpectrPoint[j]:=round(x0nm*TransformUnit.XPnm_d);    //discrets
      ScanData.AquiSpectrPoint[j+1]:=round(y0nm*TransformUnit.YPnm_d);
      ScanData.AquiSpectrPoint[j+2]:=1;
      inc(j,3);
       NanoEdu.ScanMoveToX0Y0Method(X0nm,y0nm);
       error:=NanoEdu.Method.Launch;
       FreeAndNil(NanoEdu.Method);
    if error<>0 then
    begin
     RestoreStart;
     exit
    end;
      Application.ProcessMessages;
      SpectrParams.CurrentLine:=i;
      DemoSpectrCnt:=i;
      NanoEdu.SpectroscopyMethod;
     if NanoEdu.Method.Launch<>0 then begin FreeAndNil(NanoEdu.Method); ReStoreStart; exit; end;
      DrawGraphics(i, (Nanoedu.Method as TSpectroscopySFM).U, ZStepMin, StepValueMin);
      if ArChart[i].flgFilter then
      begin
        ArChart[i].FiltrAverage;
        ArChart[i].SetFindLine_pos(0);
      end;
      FreeAndNil(NanoEdu.Method);
      Application.ProcessMessages;
   end;    //i    { TODO : 071007 }     //move to the x0,y0
    while assigned(nanoedu.method) do Application.ProcessMessages;   //wait for  end scanning
       NanoEdu.ScanMoveToX0Y0Method(ScanParams.Xbegin,ScanParams.Ybegin);
       NanoEdu.Method.Launch;
       FreeAndNil(NanoEdu.Method);
   with PageControl do
  begin
    for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
   Activepage:= ArTabSheet[0];
   ActivePage.HighLighted:=True;
  end;
  ReStoreStart;
  BitBtnSaveClick(Sender);
  Main.ToolBtnExp.visible:=true;
 if assigned(Scanwnd) then
 begin
  Scanwnd.SaveExpBtn.Enabled:=True;
  Scanwnd.flgBlickSave:=true;
 end;
 except
   on EConvertError do
    begin end;
  end;
 end{Error=0}
 else
    MessageDlgCtr(strs1{'no Demo Data!!!'}, mtInformation,[mbOk],0);

end;

end.
