//250307
unit frTools;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Menus,Cspmvar, ImgList, ToolWin,
  siComp, siLngLnk;
type
  TImagetools = class(TForm)
    PopupMenuZoom: TPopupMenu;
    N50: TMenuItem;
    N130: TMenuItem;
    N150: TMenuItem;
    N200: TMenuItem;
    PopupMenuRubber: TPopupMenu;
    AreaRubber: TMenuItem;
    LineRubber: TMenuItem;
    PanelMain: TPanel;
    PanelTools: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedBtnData: TSpeedButton;
    Label2: TLabel;
    SpeedButton8: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButtonStepX: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedBtnRubber: TSpeedButton;
    Panel3: TPanel;
    Label6: TLabel;
    BitBtnScreenplay: TBitBtn;
    BitBtnRunScript: TBitBtn;
    Panel4: TPanel;
    SpeedBtnFrag: TSpeedButton;
    SpeedBtnSect: TSpeedButton;
    BitBtnContr: TSpeedButton;
    SpdBtnZoom: TSpeedButton;
    SpeedBtnRule: TSpeedButton;
    SpeedBtnAngle: TSpeedButton;
    SpeedBtnSc: TSpeedButton;
    Panel5: TPanel;
    SpeedBtn3D: TSpeedButton;
    SpeedBtn2D: TSpeedButton;
    SpeedBtn2DG: TSpeedButton;
    SpeedBtn3DG: TSpeedButton;
    SpeedBtnL: TSpeedButton;
    SpeedBtnM: TSpeedButton;
    SpeedBtnPal: TSpeedButton;
    Label1: TLabel;
    bitbtninvert: TSpeedButton;
    BitBtnHelp: TBitBtn;
    PanelContrust: TPanel;
    BitBtnReSet: TBitBtn;
    Panel6: TPanel;
    ImageGrad: TImage;
    Label5: TLabel;
    ZTrackBarLeft: TTrackBar;
    ZTrackBarRight: TTrackBar;
    ImageList1: TImageList;
    siLangLinked1: TsiLangLinked;
    RenishawDiagnBtn: TSpeedButton;
    Panel7: TPanel;
    PanelBottom: TPanel;
    ToolBar1: TToolBar;
    ToolBtnCloseall: TToolButton;
    ToolBtnCloseAct: TToolButton;
    ToolBtnNext: TToolButton;
    ToolBtnHor: TToolButton;
    ToolBtnC: TToolButton;
    ToolBtnV: TToolButton;
    Panel9: TPanel;
    ImageList2: TImageList;
    ImageList3: TImageList;
    SpeedButtonStepY: TSpeedButton;
    Panel8: TPanel;
    SpdBtnMir: TSpeedButton;
    PopupMenuMirror: TPopupMenu;
    MirrorX: TMenuItem;
    MirrorY: TMenuItem;
    Fullscreen1: TMenuItem;
    procedure SpdBtnMirClick(Sender: TObject);
    procedure MirrorYClick(Sender: TObject);
    procedure MirrorXClick(Sender: TObject);
    procedure SpeedButtonStepYClick(Sender: TObject);
    procedure RenishawDiagnBtnClick(Sender: TObject);
    procedure ToolBtnVClick(Sender: TObject);
    procedure ToolBtnHorClick(Sender: TObject);
    procedure ToolBtnCClick(Sender: TObject);
    procedure ToolBtnNextClick(Sender: TObject);
    procedure ToolBtnCloseActClick(Sender: TObject);
    procedure ToolBtnCloseallClick(Sender: TObject);
    procedure SpeedBtn3DClick(Sender: TObject);
    procedure SpeedBtn2DClick(Sender: TObject);
    procedure SpeedBtn3DGClick(Sender: TObject);
    procedure SpeedBtn2DGClick(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButtonStepXClick(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedBtnFragClick(Sender: TObject);
    procedure SpeedBtnSectClick(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnContrClick(Sender: TObject);
    procedure ZTrackBarLeftChange(Sender: TObject);
    procedure ZTrackBarRightChange(Sender: TObject);
    procedure BitBtnReSetClick(Sender: TObject);
    procedure N50Click(Sender: TObject);
    procedure SpdBtnZoomClick(Sender: TObject);
    procedure N130Click(Sender: TObject);
    procedure N150Click(Sender: TObject);
    procedure N200Click(Sender: TObject);
    procedure SpeedBtnOptClick(Sender: TObject);
    procedure SpeedBtnRuleClick(Sender: TObject);
    procedure SpeedBtnAngleClick(Sender: TObject);
    procedure SpeedBtnDataClick(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure SpeedBtnMClick(Sender: TObject);
    procedure SpeedBtnScClick(Sender: TObject);
    procedure SpeedBtnPalClick(Sender: TObject);
    procedure BitBtnScreenplayClick(Sender: TObject);
    procedure BitBtnRunScriptClick(Sender: TObject);
    procedure AreaRubberClick(Sender:Tobject);
    procedure LineRubberClick(Sender:Tobject);
    procedure SpeedBtnRubberMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SpeedBtnRubberClick(Sender: TObject);
    procedure BitBtnInvertClick(Sender: TObject);
    procedure Fullscreen1Click(Sender: TObject);
  private
     border:integer;
     width0:integer;
     panelcontrustwidth:integer;
  procedure GradientRect (FromRGB, ToRGB: TColor;Canvas:tcanvas;Ztop,Zbottom:integer);
  procedure prilip(var msg: TPrilipalkaMSG);message CM_PrilipalkaMove;
 protected
     procedure CreateParams(var Params:TCreateParams); override;
 public
     procedure ReDRawGr;
 end;

var
  Imagetools: TImagetools;
  FromRGB, ToRGB: TColor;

implementation

{$R *.DFM}
uses   GlobalType,GlobalScanDataType,GlobalVar,GlobalDcl,NanoEduHelp,mMain,frOpenGlDraw, frLightOption,frSetMaterialOpt, frScale,
       frSetPalette,frScriptPlay, frRenishowDiagn,frRenishawSlowFronts,frRenishawNomogram;

procedure TImagetools.GradientRect (FromRGB, ToRGB: TColor;Canvas:tcanvas;ZTop,ZBottom:integer);
var
    RGBFrom : array[0..2] of Byte; { from RGB values }
    RGBDiff : array[0..2] of integer; { difference of from/to RGB values }
    ColorBand : TRect; { color band rectangular coordinates }
    WhiteBand:TRect;
    BlackBand:TRect;
     I : Integer; { color band index }
     R : Byte; { a color band's R value }
     G : Byte; { a color band's G value }
     B : Byte; { a color band's B value }
     h,h0,iL,iR:integer;
begin
  { extract from RGB values}
  RGBFrom[0] := GetRValue (ColorToRGB (FromRGB));
  RGBFrom[1] := GetGValue (ColorToRGB (FromRGB));
  RGBFrom[2] := GetBValue (ColorToRGB (FromRGB));
  { calculate difference of from and to RGB values}
  RGBDiff[0] := GetRValue (ColorToRGB (ToRGB)) - RGBFrom[0];
  RGBDiff[1] := GetGValue (ColorToRGB (ToRGB)) - RGBFrom[1];
  RGBDiff[2] := GetBValue (ColorToRGB (ToRGB)) - RGBFrom[2];

  { set pen sytle and mode}
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Mode := pmCopy;
  h0:=(canvas.ClipRect.Bottom-Canvas.ClipRect.Top);
  h:=h0-round(h0*(Ztop+255-Zbottom)/255);
  { set color band's left and right coordinates}
   iL:=round(h0*Ztop/255);
   ColorBand.Left := 0;
   ColorBand.Right:=Canvas.ClipRect.Right-Canvas.ClipRect.left;
   WhiteBand.Left := 0;
   WhiteBand.Right:=Canvas.ClipRect.Right-Canvas.ClipRect.left;
   WhiteBand.Top:=0;
   WhiteBand.Bottom:=iL;
   iR:=round(h0*ZBottom/255);
   BlackBand.Top:=iR;
   BlackBand.Bottom:=Canvas.ClipRect.Bottom;
   BlackBand.Left := 0;
   BlackBand.Right:=Canvas.ClipRect.Right-Canvas.ClipRect.left;
   for I := 0 to $ff do
     begin
      { calculate color band's top and bottom coordinates}
      ColorBand.Top :=h-MulDiv (I , h, $100)+iL;
      ColorBand.Bottom :=h-MulDiv (I + 1,h, $100)+iL;
      { calculate color band color}
       R := round(RGBFrom[0] + MulDiv (round(255*RDistr[I+1]), RGBDiff[0], $ff));
       G :=  round(RGBFrom[1] +MulDiv (round(255*GDistr[I+1]), RGBDiff[1], $ff));
       B :=  round(RGBFrom[2] +MulDiv (round(255*BDistr[I+1]), RGBDiff[2], $ff));
         { select brush and paint color band}
       Canvas.Brush.Color := RGB (R, G, B);
       Canvas.FillRect (ColorBand);
     end;
       R:=round(255*RDistr[MaxVal]);
       G:=round(255*GDistr[Maxval]);
       B:=round(255*BDistr[MaxVal]);
       Canvas.Brush.Color := RGB (R, G, B);
//       Canvas.Brush.Color :=$00FFFFFF;
       Canvas.FillRect (WhiteBand);
       R:=round(255*RDistr[1]);
       G:=round(255*GDistr[1]);
       B:=round(255*BDistr[1]);
       Canvas.Brush.Color := RGB (R, G, B);
//       Canvas.Brush.Color :=$00000000;
       Canvas.FillRect (BlackBand);
end;
procedure TImagetools.prilip(var msg: TPrilipalkaMSG);
begin
// if (left<=(screen.WorkAreaWidth-width) )      then  left:=msg.mfRight;
// if (msg.mfRight<=screen.WorkAreaWidth-width) then  left:=msg.mfRight;//screen.WorkAreaWidth-width;
  left:=msg.mfRight;
   top:=msg.mfTop;
  Application.ProcessMessages;
end;
procedure TImagetools.ReDRawGr;
begin
 GradientRect(FromRGB,ToRGB,ImageGrad.Canvas,ZTrackBarLeft.position,ZTrackBarRight.position);
end;

procedure TImagetools.RenishawDiagnBtnClick(Sender: TObject);
var i,j:integer;
    Buf:tData;
    SlowAxisData:TLine; // array of apitype;
    mode:integer;
    ss:string;
begin
 //Buf.data:=nil;
 //SlowAxisData:=nil;
 if assigned(ActiveGLW) then
//  if ActiveGLW.flgRenishawCorrected then
  begin
   Main.CreateMDIChild(Sender,ActiveGLW.FileNameGL,ActiveGLW.FlgView,false,false);
   ActiveGLW.TopoSPM.ReadRenishawData ;
   Buf:=TData.Create;
   mode:= ActiveGLW.TopoSPM.FileHeadRcd.HPathMode;
   if mode=0 then ss:=' X '
             else ss:=' Y ';
   try
   if mode =0 then
     begin
       Buf.Nx:=ActiveGLW.TopoSPM.AquiRenishaw.Nx-1;
       Buf.Ny:=ActiveGLW.TopoSPM.AquiRenishaw.Ny;
       SetLength(SlowAxisData,Buf.Ny);
        for i := 0 to Buf.Ny - 1 do
           SlowAxisData[i]:= ActiveGLW.TopoSPM.AquiRenishaw.data[Buf.Nx,i];
     end
     else
     begin
       Buf.Nx:=ActiveGLW.TopoSPM.AquiRenishaw.Nx;
       Buf.Ny:=ActiveGLW.TopoSPM.AquiRenishaw.Ny-1;
       SetLength(SlowAxisData,Buf.Nx);
        for i := 0 to Buf.Nx - 1 do
           SlowAxisData[i]:= ActiveGLW.TopoSPM.AquiRenishaw.data[i,Buf.Ny];
     end;
   try SetLength(Buf.data,Buf.Nx,Buf.Ny);
    for i := 0 to Buf.Nx - 1 do
     for j := 0 to Buf.Ny - 1 do
         Buf.data[i,j]:=ActiveGLW.TopoSPM.AquiRenishaw.data[i,j];
     (* if ActiveGLW.FlgOneLineScan then
             begin
               FormReniShDiagn:=TFormReniShDiagn.Create(Application,Buf,mode);
             //  FormReniShDiagn.Caption:='Renishaw nomogramma, One Line Scanning; '+ ActiveGLW.TopoSPM.ImFileName+' '+siLangLinked1.GetTextOrDefault('IDS_0' (* '  No Correction, ' *)
             // )+ ss+siLangLinked1.GetTextOrDefault('IDS_1' (* ' Fast ' *) );
      //       end
     //   else  *)
        begin
              FormRenishNomogram:= TFormRenishNomogram.Create(Application,Buf,SlowAxisData,mode, ActiveGLW.FlgOneLineScan);
              FormRenishNomogram.Caption:='Renishaw nomogramma; '+ ActiveGLW.TopoSPM.ImFileName+' '+siLangLinked1.GetTextOrDefault('IDS_0' (* '  No Correction, ' *) )+ ss+siLangLinked1.GetTextOrDefault('IDS_1' (* ' Fast ' *) );
        end;
   if not ActiveGLW.FlgOneLineScan then
     FormSlowFronts:= TFormSlowFronts.Create(Application);
    finally
     FreeAndNil(Buf);
    end;
   finally
     finalize(SlowAxisData);
   end;
    end
 //   else ShowMessage(siLangLinked1.GetTextOrDefault('IDS_2' (* 'No Renishaw Data in  ' *) )+ ActiveGLW.FileNameGL);
end;

procedure  TImagetools.CreateParams(var Params:TCreateParams);
begin
inherited CreateParams(Params);
 Params.Style:=Params.Style xor WS_SizeBOX ;
end;
procedure TImagetools.SpeedBtn3DClick(Sender: TObject);
begin
  if  assigned(ActiveGLW) then ActiveGLW.View3DClick(Sender);
end;

procedure TImagetools.SpeedBtn2DClick(Sender: TObject);
begin
  if  assigned(ActiveGLW) then ActiveGLW.View3DTopClick(Sender);
end;

procedure TImagetools.SpeedBtn3DGClick(Sender: TObject);
begin
  if  assigned(ActiveGLW) then ActiveGLW.View3DGeoClick(Sender);
end;

procedure TImagetools.SpeedBtn2DGClick(Sender: TObject);
begin
  if  assigned(ActiveGLW) then ActiveGLW.View2DGeoClick(Sender);
end;

procedure TImagetools.SpeedButton5Click(Sender: TObject);
begin
  if  assigned(ActiveGLW) then ActiveGLW.MedianClick(Sender);
end;

procedure TImagetools.SpeedButton6Click(Sender: TObject);
begin
  if  assigned(ActiveGLW) then ActiveGLW.Average3x3Click(Sender);
end;

procedure TImagetools.SpeedButton9Click(Sender: TObject);
begin
  if  assigned(ActiveGLW) then  ActiveGLW.LevelDeleteClick(Sender);
end;

procedure TImagetools.ToolBtnCloseallClick(Sender: TObject);
begin
  Main.ActionCloseAllExecute(Sender);
end;

procedure TImagetools.ToolBtnCloseActClick(Sender: TObject);
begin
  Main.ActionLeaveActiveExecute(Sender);
end;

procedure TImagetools.ToolBtnNextClick(Sender: TObject);
begin
 Main.ActionNextImageExecute(Sender);
end;

procedure TImagetools.ToolBtnHorClick(Sender: TObject);
begin
   Main.ActionHorizontalExecute(Sender);
end;

procedure TImagetools.ToolBtnVClick(Sender: TObject);
begin
   Main.ActionVerticalExecute(Sender);
end;

procedure TImagetools.ToolBtnCClick(Sender: TObject);
begin
  Main.ActionCascadeExecute(Sender)
end;

procedure TImagetools.SpeedButton8Click(Sender: TObject);
begin
  if  assigned(ActiveGLW)  then   ActiveGLW.SurfaceDeleteClick(Sender);
end;

procedure TImagetools.SpeedButtonStepXClick(Sender: TObject);
begin
  if assigned(ActiveGLW) then  ActiveGLW.StepsYDeleteClick(Sender);
end;

procedure TImagetools.SpeedButton7Click(Sender: TObject);
begin
  if assigned(ActiveGLW) then  ActiveGLW.PlaneDeleteClick(Sender);
end;

procedure TImagetools.FormClose(Sender: TObject; var Action: TCloseAction);
var i,count:integer;
    PlayAction:pScriptAction;
begin
  if assigned(ActiveGLW)   then
    begin
   //  ActiveGLW.ToolsPanel.checked:=false;
     ActiveGLW.ContrastMenu.checked:=false;
     ActiveGLW.ContrastPopUp.checked:=false;
//     flgContrastZ:=false;
     Main.ActionImageTools.visible:=true;
    end;
  flgContrastZ:=false;
  flgViewTools:=false;
//  Main.ActionImageTools.visible:=true;
  if assigned(ScaleGL)         then ScaleGL.close;
  if assigned(PaletteForm)     then PaletteForm.Close;
  if assigned(vSetMaterialOpt) then vSetMaterialOpt.Close;   // 080410
  if assigned(LightOption)     then LightOption.Close;      //  080410
  if assigned(filterlist)  then
  begin
   count:=filterlist.Count;
    for i:=count-1 downto 0 do
    begin
     playaction:= filterlist[i];
     playaction.filter:=nil;
     playaction^.name:='';
     filterlist.delete(i);
     dispose(playaction);
    end;
   filterlist.Clear;
   FreeAndNil(filterlist);
  end;
   Main.width:= Main.width+ width0;
   Main.PanelMonitor.Width:=Main.widthmonitor;
  // Action:=caFree;      080410
   ImageTools:=nil;
end;

procedure TImagetools.SpeedBtnFragClick(Sender: TObject);
begin
  if assigned(ActiveGLW) then
  begin
   ActiveGLW.CutFragmentClick(Sender);
   SpeedBtnFrag.Down:=not SpeedBtnFrag.Down;
   SpeedBtnRubber.Down:=False;
  end;
end;

procedure TImagetools.SpeedBtnSectClick(Sender: TObject);
begin
 if assigned(ActiveGLW) then
 begin
  ActiveGLW.CutSectionClick(Sender);
  SpeedBtnSect.Down:=not SpeedBtnSect.Down;
  SpeedBtnRubber.Down:=False;
 end;
end;

procedure TImagetools.SpeedButton13Click(Sender: TObject);
begin
 if assigned(ActiveGLW) then ActiveGLW.UnDoClick(Sender);
end;

procedure TImagetools.SpeedButtonStepYClick(Sender: TObject);
begin
   if assigned(ActiveGLW) then  ActiveGLW.StepsXDeleteClick(Sender);
end;

procedure TImagetools.FormCreate(Sender: TObject);
begin
   siLangLinked1.ActiveLanguage:=Lang;
    panelcontrustwidth:=130;
   Main.ActionImageTools.visible:=false;
     formstyle:=fsStayOnTop;
     flgfrTools:=true;
     width:=164;       //146
     width0:=width;
   //  height:=590;
     height:=Screen.WorkAreaHeight;
     self.top:=0;
     border:=(width-clientwidth) div 2;
  begin
     BitBtnContr.down:=false;
     if assigned(ActiveGLW) then ActiveGLW.ContrastMenu.checked:=false;
     PanelContrust.visible:=false;
     self.width:=width0;
  end;
 //self.left:=Screen.WorkAreaWidth-self.width;//-5;//  self.left:=Main.ClientWidth-self.width-5;
  self.left:=Main.left+Main.width-width;//Screen.WorkAreaWidth-self.width;//-5;//  self.left:=Main.ClientWidth-self.width-5;
  Main.width:=Main.width-width;
 Main.PanelMonitor.Width:=0;
 Application.ProcessMessages;
end;

procedure TImagetools.Fullscreen1Click(Sender: TObject);
begin
   if  assigned(ActiveGLW) then
    begin
        ActiveGLW.Height:=round(Screen.Height);
        ActiveGLW.Width:=round(Screen.Height);
        InvalidateRect(ActiveGLW.Handle, nil, False);
    end;
end;

procedure TImagetools.BitBtnContrClick(Sender: TObject);
begin
 if  PanelContrust.visible   then begin  width:=width-panelcontrust.width+2*border; left:=main.left+Main.width;end
                             else begin  width:=width+panelcontrustwidth; left:=left-panelcontrustwidth end;
PanelContrust.visible:=not  PanelContrust.visible ;
flgContrastZ:=PanelContrust.visible;
if assigned(ActiveGLW) then
begin
 ActiveGLW.ContrastMenu.checked:=flgContrastZ;
 ActiveGLW.ContrastPopUp.checked:=flgContrastZ;
end;
if PanelContrust.visible then
 begin
  GradientRect(FromRGB,ToRGB,ImageGrad.Canvas,ZTrackBarLeft.position,ZTrackBarRight.position);
 end;
end;

procedure TImagetools.ZTrackBarLeftChange(Sender: TObject);
var h:single;
begin
  if  ZTrackBarLeft.position > ZTrackBarRight.position then  ZTrackBarLeft.position:=ZTrackBarRight.position;
   ZContrMax:=(255-ZTrackBarLeft.position)/255;
   GradientRect(FromRGB,ToRGB,ImageGrad.Canvas,ZTrackBarLeft.position,ZTrackBarRight.position);
   with ImageGrad.Canvas do
   begin
     h:=(ClipRect.Bottom-ClipRect.top)/255;
     moveto(ClipRect.left,ClipRect.top+round(h*ZTrackBarLeft.position));
     lineto(ClipRect.Right,ClipRect.top+round(h*ZTrackBarLeft.position));
     moveto(ClipRect.left,ClipRect.top+round(h*ZTrackBarRight.position));
     lineto(ClipRect.Right,ClipRect.top+round(h*ZTrackBarRight.position))
   end;
   if  assigned(ActiveGLW) then
    begin
      FlgcontrastZ:=True;
      ActiveGLW.TrackBarL:=ZTrackBarLeft.position;
      ActiveGLW.Contrast(Sender);
    end;
end;
Procedure TImagetools.ZTrackBarRightChange(Sender: TObject);
var h:single;
begin
  if  ZTrackBarRight.position < ZTrackBarLeft.position then  ZTrackBarRight.position:=ZTrackBarLeft.position;
    ZContrMin:=(255-ZTrackBarRight.position)/255;
    GradientRect(FromRGB,ToRGB,ImageGrad.Canvas,ZTrackBarLeft.position,ZTrackBarRight.position);
  with ImageGrad.Canvas do
   begin
     h:=(ClipRect.Bottom-ClipRect.top)/255;
     moveto(ClipRect.left,ClipRect.top+round(h*ZTrackBarLeft.position));
     lineto(ClipRect.Right,ClipRect.top+round(h*ZTrackBarLeft.position));
     moveto(ClipRect.left,ClipRect.top+round(h*ZTrackBarRight.position));
     lineto(ClipRect.Right,ClipRect.top+round(h*ZTrackBarRight.position))
   end;
   if  assigned(ActiveGLW) then
     begin
      FlgcontrastZ:=True;
      ActiveGLW.TrackBarR:=ZTrackBarRight.position;
      ActiveGLW.Contrast(Sender);
   end;
end;

procedure TImagetools.BitBtnReSetClick(Sender: TObject);
begin
 ZTrackBarRight.position:=255;
 ZTrackBarLeft.position:=0;
 ZContrMin:=(255-ZTrackBarRight.position)/255;
 ZContrMax:=(255-ZTrackBarLeft.position)/255;
  if  assigned(ActiveGLW) then
   begin
    FlgcontrastZ:=True;
    ActiveGLW.TrackBarR:=ZTrackBarRight.position;
    ActiveGLW.TrackBarL:=ZTrackBarLeft.position;
    ActiveGLW.contrast(Sender);
   end;
end;

procedure TImagetools.N50Click(Sender: TObject);
begin
 if  assigned(ActiveGLW) then
   begin
       ActiveGLW.Height:=round( ActiveGLW.Height*0.5);
       ActiveGLW.Width:=round( ActiveGLW.Width*0.5);
       InvalidateRect(ActiveGLW.Handle, nil, False);
  end;
end;

procedure TImagetools.SpdBtnMirClick(Sender: TObject);
var point,pointa:Tpoint;
begin
       point.x:=SpdBtnMir.width div 3;
       point.y:=SpdBtnMir.height-10;
       pointa:=SpdBtnMir.ClientToScreen(point);
       PopUpMenuMirror.Popup(pointa.X,pointa.y);

end;

procedure TImagetools.SpdBtnZoomClick(Sender: TObject);
begin
   with SpdBtnZoom  do
   PopupMenuZoom.Popup(ClientOrigin.x+(width div 2),ClientOrigin.y+(height div 2));
end;

procedure TImagetools.N130Click(Sender: TObject);
begin
    if  assigned(ActiveGLW) then
    begin
       ActiveGLW.Height:=round( ActiveGLW.Height*1.3);
       ActiveGLW.Width:=round( ActiveGLW.Width*1.3);
       InvalidateRect(ActiveGLW.Handle, nil, False);
    end;
end;

procedure TImagetools.N150Click(Sender: TObject);
begin
     if  assigned(ActiveGLW) then
    begin
       ActiveGLW.Height:=round( ActiveGLW.Height*1.5);
       ActiveGLW.Width:=round( ActiveGLW.Width*1.5);
       InvalidateRect(ActiveGLW.Handle, nil, False);
    end;
end;

procedure TImagetools.N200Click(Sender: TObject);
begin
  if  assigned(ActiveGLW) then
    begin
       ActiveGLW.Height:=round( ActiveGLW.Height*2.0);
       ActiveGLW.Width:=round( ActiveGLW.Width*2.0);
       InvalidateRect(ActiveGLW.Handle, nil, False);
    end;
end;

procedure TImagetools.SpeedBtnOptClick(Sender: TObject);
begin
  if assigned(ActiveGLW) then
    begin
      if not assigned(LightOption) then LightOption:= TLightOption.Create(Self)
                                   else LightOption.SetFocus;;
    end
end;

procedure TImagetools.SpeedBtnRuleClick(Sender: TObject);
begin
  if  assigned(ActiveGLW) then
   begin
    ActiveGLW.RuleClick(sender);
    SpeedBtnRule.Down:=not SpeedBtnRule.Down;
    if SpeedBtnRubber.Down then SpeedBtnRubber.Down:=not  SpeedBtnRubber.Down;
   end;
end;

procedure TImagetools.SpeedBtnAngleClick(Sender: TObject);
begin
  if  assigned(ActiveGLW) then
   begin
    ActiveGLW.AngleClick(sender);
    SpeedBtnAngle.Down:=not SpeedBtnAngle.Down;
     if  SpeedBtnRubber.Down then
    SpeedBtnRubber.Down:=not  SpeedBtnRubber.Down;
   end;
end;

procedure TImagetools.SpeedBtnDataClick(Sender: TObject);
begin
  if  assigned(ActiveGLW) then
   begin
    SpeedBtnData.enabled:=false;
    ActiveGLW.ImageAnalysis1.enabled:=false;
    ActiveGLW.ImageAnalysis2.enabled:=false;
    ActiveGLW.ImageAnalysis1Click(Sender);
   end;
end;

procedure TImagetools.BitBtnHelpClick(Sender: TObject);
begin
   HlpContext:=IDH_Instr_Panel;
   Application.HelpContext(HlpContext);
end;

procedure TImagetools.SpeedBtnMClick(Sender: TObject);
begin
if not assigned(vSetMaterialOpt) then  vSetMaterialOpt:=TSetMaterialOption.Create(Self)
                                 else  vSetMaterialOpt.SetFocus;
end;

procedure TImagetools.SpeedBtnScClick(Sender: TObject);
begin
    if not  assigned(ScaleGL) then
     begin
      ScaleGL:=TScaleGL.Create(self);
     end
    else
    begin
      ScaleGL.SetFocus;
      if assigned(ActiveGLW) then ScaleGL.TrackBarSc.Position:=ActiveGLW.ZScaleP;
    end;
end;


procedure TImagetools.SpeedBtnPalClick(Sender: TObject);
begin
 if not assigned(PaletteForm) then
  begin
    PaletteForm:=TPaletteForm.Create(Self);
  end
  else PaletteForm.SetFocus;
end;

procedure TImagetools.BitBtnScreenplayClick(Sender: TObject);
begin
  ScriptPlay:=TScriptPlay.Create(Application,ActiveGLW.DataDraw.Nx,ActiveGLW.DataDraw.Ny,ActiveGLW.datadraw.data);
  ScriptPlay.ShowModal;
 end;

procedure TImagetools.BitBtnRunScriptClick(Sender: TObject);
begin
 if assigned(filterlist) then
 begin
     BitBtnRunScript.Enabled:=false;
     Application.ProcessMessages;
     ScriptPlay:=TScriptPlay.Create(Application,ActiveGLW.DataDraw.Nx,ActiveGLW.DataDraw.Ny,ActiveGLW.datadraw.data);
     ScriptPlay.RunScript;
     ScriptPlay.Close;
     BitBtnRunScript.Enabled:=true;
     Application.ProcessMessages;
 end;

end;

procedure TImagetools.AreaRubberClick(Sender: TObject);
begin
if assigned(ActiveGLW) then
  begin
   ActiveGLW.miAreaRubberClick(Sender);
   SpeedBtnRubber.Down:=True;//not SpeedBtnRubber.Down;
  end;
end;

procedure TImagetools.LineRubberClick(Sender: TObject);
begin
 if assigned(ActiveGLW) then
  begin
   ActiveGLW.miLineRubberClick(Sender);
   SpeedBtnRubber.Down:=True;//not SpeedBtnRubber.Down;
  end;
end;

procedure TImagetools.MirrorXClick(Sender: TObject);
begin
if  assigned(ActiveGLW) then  ActiveGLW.MirrorXClick(Sender);
end;

procedure TImagetools.MirrorYClick(Sender: TObject);
begin
if  assigned(ActiveGLW) then  ActiveGLW.MirrorYClick(Sender);
end;

procedure TImagetools.SpeedBtnRubberMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var point,pointa:Tpoint;
begin
  if Button=mbLeft then
   if not SpeedBtnRubber.Down then
   begin
      point.x:=x;
      point.y:=y;
      pointa:=SpeedBtnRubber.ClientToScreen(point);
      PopupMenuRubber.Popup(pointa.X,pointa.y);
   end;
    SpeedBtnRubber.Down:=False;
end;

procedure TImagetools.SpeedBtnRubberClick(Sender: TObject);
begin
  SpeedBtnRubber.Down:=False;
end;

procedure TImagetools.BitBtnInvertClick(Sender: TObject);
begin
 if  assigned(ActiveGLW) then  ActiveGLW.InvertClick(Sender);
 BitBtnInvert.Down:=not BitBtnInvert.Down;
end;

end.
