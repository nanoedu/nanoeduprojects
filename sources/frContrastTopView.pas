unit frContrastTopView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, siComp, siLngLnk;

type
  TfrContrast = class(TForm)
    PanelContrust: TPanel;
    BitBtnReSet: TBitBtn;
    Panel6: TPanel;
    ImageGrad: TImage;
    Label5: TLabel;
    ZTrackBarLeft: TTrackBar;
    ZTrackBarRight: TTrackBar;
    Label1: TLabel;
    siLangLinked1: TsiLangLinked;
    procedure BitBtnReSetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZTrackBarRightChange(Sender: TObject);
    procedure ZTrackBarLeftChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GradientRect (FromRGB, ToRGB: TColor;Canvas:tcanvas;ZTop,ZBottom:integer);

  public
    { Public declarations }
  end;

var
  frContrast: TfrContrast;
   TopViewFromRGB, TopViewToRGB: TColor;

implementation

   uses globaltype,globalvar,ScanDrawThread,mMain;

{$R *.dfm}
procedure TfrContrast.GradientRect (FromRGB, ToRGB: TColor;Canvas:tcanvas;ZTop,ZBottom:integer);
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
  RGBFrom[0] := GetRValue (ColorToRGB ( FromRGB));
  RGBFrom[1] := GetGValue (ColorToRGB ( FromRGB));
  RGBFrom[2] := GetBValue (ColorToRGB ( FromRGB));
  { calculate difference of from and to RGB values}
  RGBDiff[0] := GetRValue (ColorToRGB ( ToRGB)) - RGBFrom[0];
  RGBDiff[1] := GetGValue (ColorToRGB ( ToRGB)) - RGBFrom[1];
  RGBDiff[2] := GetBValue (ColorToRGB ( ToRGB)) - RGBFrom[2];

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
     end;                           { TODO : 201108 }
       R:=round(255*RDistr[MaxVal-1]);
       G:=round(255*GDistr[Maxval-1]);
       B:=round(255*BDistr[MaxVal-1]);
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
procedure TfrContrast.ZTrackBarLeftChange(Sender: TObject);
var h:single;
begin
  if  ZTrackBarLeft.position > ZTrackBarRight.position then  ZTrackBarLeft.position:=ZTrackBarRight.position;
   ZW:=((255-ZTrackBarLeft.position)/255);
   GradientRect( TopViewFromRGB, TopViewToRGB,ImageGrad.Canvas,ZTrackBarLeft.position,ZTrackBarRight.position);
   with ImageGrad.Canvas do
   begin
     h:=(ClipRect.Bottom-ClipRect.top)/255;
     moveto(ClipRect.left,ClipRect.top+round(h*ZTrackBarLeft.position));
     lineto(ClipRect.Right,ClipRect.top+round(h*ZTrackBarLeft.position));
     moveto(ClipRect.left,ClipRect.top+round(h*ZTrackBarRight.position));
     lineto(ClipRect.Right,ClipRect.top+round(h*ZTrackBarRight.position))
   end;
end;

procedure TfrContrast.ZTrackBarRightChange(Sender: TObject);
var h:single;
begin
  if  ZTrackBarRight.position < ZTrackBarLeft.position then  ZTrackBarRight.position:=ZTrackBarLeft.position;
    ZB:=((255-ZTrackBarRight.position)/255);
    GradientRect( TopViewFromRGB, TopViewToRGB,ImageGrad.Canvas,ZTrackBarLeft.position,ZTrackBarRight.position);
  with ImageGrad.Canvas do
   begin
     h:=(ClipRect.Bottom-ClipRect.top)/255;
     moveto(ClipRect.left,ClipRect.top+round(h*ZTrackBarLeft.position));
     lineto(ClipRect.Right,ClipRect.top+round(h*ZTrackBarLeft.position));
     moveto(ClipRect.left,ClipRect.top+round(h*ZTrackBarRight.position));
     lineto(ClipRect.Right,ClipRect.top+round(h*ZTrackBarRight.position))
   end;
end;

procedure TfrContrast.BitBtnReSetClick(Sender: TObject);
begin
 ZTrackBarRight.position:=255;
 ZTrackBarLeft.position:=0;
 ZB:=(255-ZTrackBarRight.position)/255;
 ZW:=(255-ZTrackBarLeft.position)/255;
end;

procedure TfrContrast.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
   frContrast:=nil;
end;

procedure TfrContrast.FormCreate(Sender: TObject);
begin
if  FlgStopScan  then
 begin
 ZW:=1;
 ZB:=0;
end;
              siLanglinked1.ActiveLanguage:=Lang;
             ZTrackBarLeft.position:=255-round(ZTrackBarLeft.Max*ZW);
             ZTrackBarRight.position:=255-round(ZTrackBarRight.Max*ZB);
   GradientRect( TopViewFromRGB, TopViewToRGB,ImageGrad.Canvas,ZTrackBarLeft.position,ZTrackBarRight.position);
end;

end.
