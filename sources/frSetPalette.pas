//22.06.05  corrected
unit frSetPalette;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,  StdCtrls, Buttons,GlobalType,mMain, siComp, siLngLnk;

const ColorsNumber=256;
const BrightnessNumber=256;

type PColorLabels=^ColorLabels;
     ColorLabels=record
      X:single;      // Color Intencity normalized (0...1)
      Y:single;      // Brightness, normalized (0...1)
     end;
type
  TPaletteForm = class(TForm)
    Panel1: TPanel;
    PaletteFieldImg: TImage;
    PanelImg: TPanel;
    PaletteScaleImg: TImage;
    PanelB: TPanel;
    Label1: TLabel;
    ComboBoxPal: TComboBox;
    LblMax: TLabel;
    BitBtnDef: TBitBtn;
    BitBtnSave: TBitBtn;
    BitBtnHelp: TBitBtn;
    siLangLinked1: TsiLangLinked;
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaletteFieldImgMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PaletteFieldImgMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure PaletteFieldImgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBoxPalSelect(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure BitBtnDefClick(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
  private
    LFromRGB,LToRGB:TColor;
    BR,CR,DR,BG,CG,DG,{BB,}CB{,DB}:ArraySpline;
    FieldW,fieldH:integer;
    RBegin,GBegin,BBegin:Boolean;
    CurrentPointInd:integer;
    MovedPointInd:integer;
    RColorLabels,GColorLabels,BColorLabels:PColorLabels;
    YPlus, YMinus:single;
    NearPoint:Boolean;
    RedScale,BlueScale,GreenScale:TList; // these lists must be in OpenGLDraw (Public)
    procedure FreeList;
    procedure InitArrays(var Ar1,Ar2:arraySpline);
    procedure MouseDownProcess(X,Y:integer; ScaleList:TList; ColorLabels:PColorLabels;
                                       var NNodes:integer; var XNodes,YNodes:ArraySpline);
    procedure ColorGradientRect (FromRGB, ToRGB: TColor;Canvas:tcanvas);
    Procedure MovePoint(X,Y:integer; ScaleList:TList; ColorLabels:PColorLabels; col:TColor; var XNodes,YNodes:ArraySpline);
    procedure ListToArray(ScaleList:TList;var XNodes,YNodes:ArraySpline);
    procedure ArrayToList(ScaleList:TList; ColorLabels:PColorLabels;  N:integer;const XNodes,YNodes:ArraySpline);
    procedure PaletLineDraw(N:integer;const XNodes,YNodes:ArraySpline; col:TColor; Canvas:Tcanvas);
    procedure ReDrawPalette(Canvas:TCanvas);
    procedure NearPointColor(var X,Y:integer; var NearPoint:Boolean);
     { Private declarations }
 public
  procedure SetCurrentPalette();
  procedure InitPalette();
  procedure ReDraw;
     { Public declarations }
end;

var
  PaletteForm: TPaletteForm;

implementation
 uses  inifiles,GlobalVar,GlobalFunction,frSPM_Browser,frSPM_BrowserFull,frOpenGlDraw, frTools,frNamePal,nanoeduhelp;

 {$R *.dfm}
const
	strp1: string = ''; (* Rename and save new Palette *)

procedure TPaletteForm.InitArrays(var Ar1,Ar2:ArraySpline);
var i:integer;
begin
for i:=1 to MaxVal do
begin
 Ar1[i]:=0;
 Ar2[i]:=0;
end;
end;

procedure TPaletteForm.SetCurrentPalette();
var i:integer;
    LabelXi,LabelYi:single;
begin
 with PaletteFieldImg.Canvas do
    begin
     Brush.Color:=clWhite;
     Fillrect(Rect(0,0,FieldW,FieldH));
    end;
 PaletLineDraw(NRed, XR,YR, clRed, PaletteFieldImg.Canvas );
 PaletLineDraw(NGreen, XG,YG, clgreen, PaletteFieldImg.Canvas );
 PaletLineDraw(NBlue, XB,YB, clBlue, PaletteFieldImg.Canvas );
end;


procedure TPaletteForm.siLangLinked1ChangeLanguage(Sender: TObject);
begin

  UpdateStrings;
end;

procedure TPaletteForm.UpdateStrings;
begin
  strp1 := siLangLinked1.GetTextOrDefault('strstrp1');

end;

procedure TPaletteForm.InitPalette();
begin
 ArrayToList(RedScale,RColorLabels,NRed,XR,YR);
 ArrayToList(GreenScale,GColorLabels,NGreen,XG,YG);
 ArrayToList(BlueScale,BColorLabels,NBlue,XB,YB);
end;

procedure TPaletteForm.FormCreate(Sender: TObject);
var
  SFile:string;
  PalIni:TiniFile;
begin
  UpdateStrings;
siLangLinked1.ActiveLanguage:=Lang;
 Height:=550;
 WIDTH:= 200;
 top:=Main.clientHeight-self.Height-15;
 left:=Main.ClientWidth-self.width-5;
 RBegin:=False;
 GBegin:=False;
 BBegin:=False;
 Panel1.Width:=ClientWidth;
 Panel1.Height:=ClientHeight;
 PaletteFieldImg.Width:=160;
 PaletteFieldImg.height:=280;
 PaletteFieldImg.Top:=0;
 PaletteFieldImg.Left:=0;
 PanelB.Top:=PaletteFieldImg.height;
 PanelB.Left:=0;
 PanelB.Height:=Panel1.Height-PaletteFieldImg.height;
 PanelB.Width:=ClientWidth;
 PanelImg.Height:=PaletteFieldImg.Height;
 PanelImg.width:=172;
 PanelImg.top:=0;
 constraints.MaxWidth:=200;
 constraints.MinWidth:=200;
 PanelImg.left:=PaletteFieldImg.Width+1;
 PaletteScaleImg.width:=PanelImg.ClientWidth;
 PaletteScaleImg.Top:=0;
 PaletteScaleImg.Left:=0;
 PaletteScaleImg.height:=PanelImg.Clientheight;
 fieldW:=PaletteFieldImg.Width-2;
 fieldH:=PaletteFieldImg.Height-2;
 RedScale:=TList.Create;
 BlueScale:=TList.Create;
 GreenScale:=TList.Create;
 sFile:=PaletteIniFilePath + PaletteIniFile;
 PalIni:=TIniFile.Create(sFile);
try
 PalIni.ReadSections(ComboBoxPal.Items);
 ComboBoxPal.Text:=PaletteName;//DefPaletName;
 InitPalette;
 ReDrawPalette(PaletteFieldImg.Canvas);
 LFromRGB:=$00000000;
 LToRGB:=$00FFFFFF;
 ColorGradientRect (LFromRGB, LToRGB, PaletteScaleImg.Canvas);
 if ComboBoxpal.Text='Custom' then  BitBtnSave.Enabled:=true
                              else  BitBtnSave.Enabled:=false;

 lblMax.Left:=palettefieldImg.width-5;
 finally
    PalIni.Free;
 end;
end;

procedure TPaletteForm.FreeList;
   var i:integer;
   count:integer;
begin
   Count:=RedScale.Count;
 for i:=(Count-1) downto 0 do
   begin
     RColorLabels := RedScale.Items[i];
     Dispose(RColorLabels);
   end;
    Count:=GreenScale.Count;
 for i:=(Count-1) downto 0 do
   begin
     GColorLabels := GreenScale.Items[i];
     Dispose(GColorLabels);
   end;
     Count:=BlueScale.Count;
 for i:=(Count-1) downto 0 do
   begin
     BColorLabels := BlueScale.Items[i];
     Dispose(BColorLabels);
   end;
   BlueScale.Clear;     GreenScale.clear;    RedScale.Clear;
  FreeAndNil(RedScale);
  FreeAndNil(GreenScale);
  FreeAndNil(BlueScale);
end;

procedure TPaletteForm.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
 FreeList;
 action:=caFree;
 PaletteForm:=nil;
end;


procedure TPaletteForm.ColorGradientRect (FromRGB, ToRGB: TColor;Canvas:tcanvas);
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
   with    PaletteScaleImg do
 begin
  { set pen sytle and mode}
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Mode := pmCopy;
  h:=(canvas.ClipRect.Bottom-Canvas.ClipRect.Top);

  { set color band's left and right coordinates}

   ColorBand.Left := 0;
   ColorBand.Right:=Canvas.ClipRect.Right-Canvas.ClipRect.left;
  //*********************?????????????????????????
   for I := 0 to $ff do
     begin
      { calculate color band's top and bottom coordinates}
      ColorBand.Top :=h -MulDiv (I , h, $100);
      ColorBand.Bottom :=h -MulDiv (I+ 1,h, $100);
      { calculate color band color}
       R :=  (RGBFrom[0] + MulDiv (round(255*RDistr[I+1]), RGBDiff[0], $ff));
       G :=  (RGBFrom[1] + MulDiv (round(255*GDistr[I+1]), RGBDiff[1], $ff));
       B :=  (RGBFrom[2] + MulDiv (round(255*BDistr[I+1]), RGBDiff[2], $ff));

       { select brush and paint color band}
       Canvas.Brush.Color := RGB (R, G, B);
       Canvas.FillRect (ColorBand);
     end;
  end;
end;


procedure TPaletteForm.PaletteFieldImgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  PointColor:TColor;
  ColorValX,ColorValY:single;
  LabelXi, LabelYi:single;
begin
 NearPoint:=False;
 NearPointColor(X,Y,NearPoint);
 if NearPoint then
 begin
  if ComboBoxPal.Text<>'Custom'then
   begin
    ComboBoxPal.Text:='Custom';
    ComboBoxPal.items.add('Custom');
    BitBtnSave.Enabled:=true;
//  InitPalIndex:=ComboBoxPal.items.count-1;
    PaletteName:=ComboBoxPal.Text;
  end;
 if RBegin  then  MouseDownProcess(X,Y,  RedScale, RColorLabels, NRed, XR,YR)
            else if  GBegin then  MouseDownProcess(X,Y,  GreenScale, GColorLabels, NGreen, XG,YG)
            else if  BBegin then  MouseDownProcess(X,Y,  BlueScale, BColorLabels, NBlue, XB,YB);
 end;
end;

procedure TPaletteForm.PaletteFieldImgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
if RBegin then
begin
 MovePoint(X,Y, RedScale, RColorLabels, clRed, XR,YR);
 NRed:= RedScale.Count;
 ReDrawPalette(PaletteFieldImg.Canvas);
end
else
if GBegin then
begin
 MovePoint(X,Y, GreenScale, gColorLabels,clGreen, XG,YG);
 NGreen:= GreenScale.Count;
 ReDrawPalette(PaletteFieldImg.Canvas);
end
else
if BBegin then
begin
 MovePoint(X,Y, BlueScale, BColorLabels,clBlue, XB,YB);
 NBlue:= BlueScale.Count;
 ReDrawPalette(PaletteFieldImg.Canvas);
end;
  EvalPaletteLines();
  ColorGradientRect (LFromRGB, LToRGB, PaletteScaleImg.Canvas);
  InvalidateRect(Handle, nil, False);
(* if Assigned(ActiveGLW) then
 begin
  ActiveGLW.PalletteGeo(sender);
 end;
 *)
 if Assigned(ImageTools) then
 begin
  if flgContrastZ then ImageTools.ReDrawGR;
 end;
end;

procedure TPaletteForm.PaletteFieldImgMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if Assigned(ActiveGLW) then   ActiveGLW.PalletteGeo(sender);
 if RBegin then  RBegin:=False
          else
          if BBegin then  BBegin:=False
                   else
                   if GBegin then  GBegin:=False;
end;

procedure TPaletteForm.MouseDownProcess(X,Y:integer; ScaleList:TList; ColorLabels:PColorLabels;
                                       var NNodes:integer; var  XNodes,YNodes:ArraySpline);
var
 ColorValX,ColorValY:single;
  i:integer;
  LabelXi, LabelYi:single;
  tColorLabels:PColorLabels;
begin
  NNodes:=ScaleList.Count;
  ColorValY:=(fieldH-Y)/fieldH;  // ColorValY=(0..1)
  for i:=0 to NNodes-1 do
  begin
   LabelYi:=PColorLabels(ScaleList.items[i])^.Y;
   if LabelYi> ColorValY then
   begin
    new(ColorLabels);
    ColorLabels^.X:=X/fieldW;
    ColorLabels^.Y:=ColorValY;
    if ((LabelYi- ColorValY) <0.06)and (i<(NNodes-1)) then
    begin     { TODO : 271007 }
     tColorLabels:= ScaleList.Items[i];
     Dispose(tColorLabels);
     ScaleList.Delete(i);
    end;
    ScaleList.Insert(i,ColorLabels);
    NNodes:=ScaleList.Count;
    CurrentPointInd:=i;
    break;
   end;
  end;
  if (CurrentPointInd+1)<NNodes then  YPlus:= PColorLabels(ScaleList.items[CurrentPointInd+1])^.Y
                                else  YPlus:= PColorLabels(ScaleList.items[CurrentPointInd])^.Y;
   YMinus:= PColorLabels(ScaleList.items[CurrentPointInd-1])^.Y;
   ListToArray(ScaleList,XNodes,YNodes);
   ReDrawPalette(PaletteFieldImg.Canvas);
   MovedPointInd:=CurrentPointInd;
end;

Procedure TPaletteForm.MovePoint(X,Y:integer; ScaleList:TList; ColorLabels:PColorLabels; col:TColor; var XNodes,YNodes:ArraySpline);
var NNodes:integer;
  LabelXi, LabelYi:single;
   tColorLabels:PColorLabels;
begin
 if X<0       then X:=0;
 if X>=fieldW then X:=fieldW-1;
 if Y<0       then Y:=0;
 if Y>=fieldH then Y:=fieldH-1;
// MovedPointInd:=CurrentPointInd;

 NNodes:=ScaleList.Count;
 if (Y<fieldH*(1-YPlus)) and (YPlus<1)  then
  begin
   if (CurrentPointInd+1)<NNodes-1 then
   begin  { TODO : 271007 }
     tColorLabels:= ScaleList.Items[CurrentPointInd+1];
     Dispose(tColorLabels);
    ScaleList.Delete(CurrentPointInd+1);
   end;
   NNodes:=ScaleList.Count;
   YPlus:=PColorLabels(Scalelist.items[CurrentPointInd+1])^.Y;
   ListToArray(ScaleList,XNodes,YNodes);
  end
  else
   if (Y>fieldH*(1-YMinus)) and (YMinus>0) {and Flg1} then
     begin
     // Flg1:=False;
      if (CurrentPointInd-1)>0 then
       begin         { TODO : 271007 }
         tColorLabels:= ScaleList.Items[CurrentPointInd-1];
         Dispose(tColorLabels);
         ScaleList.Delete(CurrentPointInd-1);
         YMinus:=PColorLabels(Scalelist.items[CurrentPointInd-2])^.Y;
         MovedPointInd:=CurrentPointInd-1;
         CurrentPointInd:=CurrentPointInd-1;
         NNodes:=ScaleList.Count;
         ListToArray(ScaleList,XNodes,YNodes);
       end;
     end;
    XNodes[CurrentPointInd+1]:=X/FieldW;
    YNodes[CurrentPointInd+1]:=1-Y/FieldH;
    ArrayToList(ScaleList,ColorLabels,NNodes,XNodes,YNodes);
end;

procedure TPaletteForm.ComboBoxPalSelect(Sender: TObject);
var i:integer;
cnt:integer;
begin
 with ComboBoxpal do
 begin
 if ComboBoxpal.Text='Custom' then
 begin
   BitBtnSave.Enabled:=true;
 end
 else
 begin
  BitBtnSave.Enabled:=false;
   cnt:= ComboBoxpal.Items.Count;
   for i:=cnt-1 downto 0 do
    if  ComboBoxpal.Items[i]='Custom' then
         begin
          ComboBoxpal.Items.delete(i);
          break;
         end;

  LoadPalette( ComboBoxpal.Text);        // Reads PaletteIni File;
  PaletteName:=ComboBoxPal.Text;
 end;
end;

 InitPalette();         // Fill Palette Lists  by XRGB, YRGB
 EvalPaletteLines();
// FixedPalette();        // Normalize RGBDistr (0..1) in  values (0..255)
 //SetCurrentPalette;     // Draw Nodes in the image
 ReDrawPalette(PaletteFieldImg.Canvas);
 ColorGradientRect(LFromRGB, LToRGB, PaletteScaleImg.Canvas);
 InvalidateRect(Handle, nil, False);
 if Assigned(ActiveGLW) then
 begin
  ActiveGLW.PalletteGeo(sender);
 end;
 if Assigned(ImageTools) then
 begin
  if flgContrastZ then ImageTools.ReDrawGR;
 end;
end;

procedure TPaletteForm.ReDraw;
begin
 PaletteName:=ActiveGLW.PaletteNameGLW;
 ComboBoxPal.Text:=PaletteName;
 InitPalette();    // Fill Palette Lists  by XRGB, YRGB
 EvalPaletteLines();
// SetCurrentPalette;      // Draw Nodes in the image
 ReDrawPalette(PaletteFieldImg.Canvas);
 ColorGradientRect(LFromRGB, LToRGB, PaletteScaleImg.Canvas);
end;

procedure TPaletteForm.ListToArray(ScaleList:TList; var XNodes,YNodes:ArraySpline);
var NNodes,i:integer;
    LabelXi,LabelYi:single;
begin
   NNodes:=ScaleList.Count;
   InitArrays(XNodes,YNodes);
  for i:=0 to NNodes-1 do
  begin
   LabelXi:= PColorLabels(ScaleList.items[i])^.X;  //   (0..1)
   LabelYi:= PColorLabels(ScaleList.items[i])^.Y;
   XNodes[i+1]:=LabelXi;
   YNodes[i+1]:=LabelYi;
  end;
end;

procedure TPaletteForm.ArrayToList(ScaleList:TList; ColorLabels:PColorLabels; N:integer;const XNodes,YNodes:ArraySpline);
var i:integer;
 tColorLabels:PColorLabels;
begin
  for i:=( ScaleList.count-1) downto 0 do
   begin
     tColorLabels := ScaleList.Items[i];
     Dispose(tColorLabels);
   end;
 ScaleList.Clear;
 ScaleList.Capacity:=20;
for i:=0 to N-1 do
 begin
  new(ColorLabels);
  ColorLabels^.X:=XNodes[i+1];      // .Х -значение по оси Y, расположенной гориз.
  ColorLabels^.Y:=YNodes[i+1];       // .Y - значение по Оси Х, располож вертикально
  ScaleList.Add(ColorLabels);
 end;
end;

procedure TPaletteForm.PaletLineDraw(N:integer;const XNodes,YNodes:ArraySpline; col:TColor; Canvas:Tcanvas);
var i:integer;
   PX,PY:integer;
begin
with Canvas do
 begin
  pen.Color:=col;
  brush.color:=col;
  MoveTo(round(FieldW*XNodes[1]),round(FieldH*(1-YNodes[1])));
  for i:=2 to N do
    begin
     PX:=round(FieldW*XNodes[i]);
     PY:=round(FieldH*(1-YNodes[i]));
     LineTo(PX,PY);
     FillRect(Rect(PX-2,PY-2,PX+2,PY+2));
    end;
 end;
end;
procedure  TPaletteForm.ReDrawPalette(Canvas:TCanvas);
begin
 with Canvas do
    begin
     Brush.Color:=clWhite;
     Fillrect(Rect(0,0,PaletteFieldImg.Width,PaletteFieldImg.Height));
    end;
 PaletLineDraw(NRed,XR,YR,clRed,PaletteFieldImg.Canvas);
 PaletLineDraw(NGreen,XG,YG,clGreen,PaletteFieldImg.Canvas);
 PaletLineDraw(NBlue,XB,YB,clBlue,PaletteFieldImg.Canvas);
end;

procedure TPaletteForm.NearPointColor(var X,Y:integer; var NearPoint:Boolean);
var i,j:integer;
begin
if PaletteFieldImg.Canvas.pixels[X,Y]=clRed then
begin
  NearPoint:=true;
  RBegin:=True;
  exit;
end;

if PaletteFieldImg.Canvas.pixels[X,Y]=clGreen then
begin
  NearPoint:=true;
  GBegin:=true;
  exit;
end;

if PaletteFieldImg.Canvas.pixels[X,Y]=clBlue then
begin
  NearPoint:=true;
  BBegin:=True;
  exit;
end;

for i:=-3 to 3 do
for j:=-3 to 3 do
begin
 if ((X+j)>=0) and ((X+j)<=FieldW) and ((Y+i)>=0) and ((Y+j)<=FieldH) then
 begin
  if PaletteFieldImg.Canvas.pixels[X+j,Y+j]=clRed then
  begin
   NearPoint:=true;
   RBegin:=True;
   X:=X+j; Y:=Y+i;
   exit;
  end;

if PaletteFieldImg.Canvas.pixels[X+j,Y+i]=clGreen then
begin
  NearPoint:=true;
  GBegin:=True;
  X:=X+j; Y:=Y+i;
  exit;
end;

if PaletteFieldImg.Canvas.pixels[X+j,Y+i]=clBlue then
begin
  NearPoint:=true;
  BBegin:=True;
  X:=X+j; Y:=Y+i;
  exit;
end;
end;
end;   {for -1..1}

for i:=-6 to 6 do
for j:=-6 to 6 do
begin
  if ((X+j)>=0) and ((X+j)<=FieldW) and ((Y+i)>=0) and ((Y+i)<=FieldH) then
   begin
    if PaletteFieldImg.Canvas.pixels[X+j,Y+i]=clRed then
    begin
     NearPoint:=true;
     RBegin:=True;
     X:=X+j; Y:=Y+i;
     exit;
   end;

if PaletteFieldImg.Canvas.pixels[X+j,Y+i]=clGreen then
begin
  NearPoint:=true;
  GBegin:=True;
  X:=X+j; Y:=Y+i;
  exit;
end;

if PaletteFieldImg.Canvas.pixels[X+j,Y+i]=clBlue then
  begin
    NearPoint:=true;
    BBegin:=true;
    X:=X+j; Y:=Y+i;
    exit;
  end;
 end;
end;   {for -2..2}
end;

procedure TPaletteForm.BitBtnSaveClick(Sender: TObject);
begin
   NamePal:=TNamePal.Create(self);
   NamePal.top:=self.Top+self.height div 2;
   NamePal.left:=self.Left-NamePal.width+20;
 if  Namepal.ShowModal=mrOk then
 begin
  SavePalette(ComboBoxPal.Text);
  ComboBoxPal.Items.add(ComboBoxPal.Text);
 end;
end;

procedure TPaletteForm.BitBtnDefClick(Sender: TObject);
begin
  if  ComboBoxPal.Text='Custom' then
  begin
   silanglinked1.MessageDlg(strp1{'Rename and save new Palette'},mtWarning,[mbOk],0);
   exit;
  end;
    SaveDefPaletName(ComboBoxPal.Text);
    LoadPalette(ComboBoxPal.Text);
    EvalPaletteLines();
    FixedPalette();
  if assigned(DirView) then   DirView.ReDraw;
end;

procedure TPaletteForm.BitBtnHelpClick(Sender: TObject);
begin
  HlpContext:=IDH_Images;
  Application.HelpContext(HlpContext)
end;

end.

