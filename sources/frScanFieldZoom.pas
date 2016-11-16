//171005
unit frScanFieldZoom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, siComp, siLngLnk;

{type TScanningField=class(TChart)
private

public
constructor Create(var AOwner: TComponent);
end;    }
const mrOnlyMove=20;
type
  TFieldZoom = class(TForm)
    ChartFieldZoom: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    siLangLinked1: TsiLangLinked;
   // procedure FormCreate(Sender: TObject);
    procedure ChartFieldZoomMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ChartFieldZoomMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ChartFieldZoomMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure ChartFieldZoomAfterDraw(Sender: TObject);

  private
    XBeginZoom,YBeginZoom,XEndZoom,YEndZoom:single; //nm
    ChRect:TRect;
    ChScaleX,ChScaleY:single;
    mX0,mY0:integer;
    FlgFirstDraw:boolean;
    FlgFinishDrawChart:boolean;
    HToWRatio:single;
    flgDrawField:boolean;
    flgLeftBtn:boolean;
    flagMoveArea:boolean;
    xm,ym:integer;
    flgLeftBtnPressed:boolean;
    OldBkMode:integer;
    BaseCaption:string;
    FieldSizeStr:string;
    BufBitMap,InterpBitMap:TBitMap;
    procedure  FieldMouseDown( Button:TMouseButton; X,Y:integer);
    procedure  FieldMouseMove(X,Y:integer);
    function   PointInside(CurrPoint:Tpoint ; ChRect:TRect):boolean;
    procedure  SQChartRect;
    procedure  DrawFieldnm( X0,Y0,XLength,YLength:single);
    procedure  StretchBitMap(DestBitMap, SourcebitMap:TBitMap);
  public
    FlgMouseDown :boolean;
    R:TRect;
    R_S:TRect;
    constructor Create(AOwner:TComponent; BitMap:TbitMap);
  end;

var
  FieldZoom: TFieldZoom;


implementation
uses     GlobalVar, CSPMVar, frScanWnd,mMain;
{$R *.dfm}

//procedure TFieldZoom.FormCreate(Sender: TObject);
constructor TFieldZoom.Create(AOwner:TComponent; BitMap:TbitMap);
begin
Inherited Create(AOwner);
siLanglinked1.ActiveLanguage:=Lang;
basecaption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Zoom Scan Area. Scan Area=' *) ) ;
FlgFinishDrawChart:=False;
flgDrawField:=False;
flgLeftBtnPressed:=False;
FieldSizeStr:='['+FloatToStrF(0,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_1' (* ' x ' *) )+ FloatToStrF(0,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_2' (* ' (nm)' *) )+']' ;
with ChartFieldZoom do
begin
  LeftAxis.SetMinMax(0,ScanParams.YMax);
  BottomAxis.SetMinMax(0,ScanParams.XMax);
  BackImageInside:=True;
  BackImageMode:=pbmStretch;
  AllowZoom:=False;
  AllowPanning:=pmNone;
end;
Width:=Height;
with ChartFieldZoom.BackImage.Bitmap do
 begin
  Width:=100;
  Height:=Width;
  Canvas.CopyMode:=cmWhiteness;     {Очистка картины}
  Canvas.CopyRect(Rect(0,0,Width,Height),Canvas,Rect(0,0,Width,Height));
 end;
 DrawFieldnm( ScanParams.XBegin, ScanParams.YBegin, ScanParams.X, ScanParams.Y);
 FlgFirstDraw:=True;
with R_S do
 begin
  Left:=0;
  Right:=0;
  Top:=0;
  Bottom:=0;
 end;
 BufBitMap:=TBitMap.Create;
 BufBitMap.Assign(BitMap);
  InterpBitMap:=TBitMap.Create;
  InterpBitMap.Width:=ChartFieldZoom.ChartWidth;
  InterpBitMap.Height:=ChartFieldZoom.ChartHeight;
 ChartFieldZoom.BackImage.Bitmap.Assign(BufBitMap);
end;

procedure TFieldZoom.ChartFieldZoomMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var    pr: PRect;
begin
  r.topleft:=ChartFieldZoom.ClienttoScreen(ChartFieldZoom.ChartRect.topleft);
  r.bottomright:=ChartFieldZoom.ClienttoScreen(ChartFieldZoom.ChartRect.bottomright);
  pr := @r;
  ClipCursor(pr);
    with ChartFieldZoom.BackImage.Bitmap do
       begin
         Width:=ChartFieldZoom.ChartWidth;
         Height:=Width;//ChartFieldZoom.ChartHeight;
       end;
//  DataToBitMapInterpolation2D(ChartFieldZoom.ChartWidth, ChartFieldZoom.ChartWidth, InterpBitMap);

  StretchBitMap(ChartFieldZoom.BackImage.Bitmap{InterpBitMap}, BufBitMap);
//  ChartFieldZoom.BackImage.Bitmap.Assign(InterpBitMap);
  FieldMouseDown(Button,  X,Y);
end;


procedure TFieldZoom.ChartFieldZoomMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
 FieldMouseMove( X,Y);
end;


procedure  TFieldZoom.FieldMouseDown( Button:TMouseButton; X,Y:integer);
var CurrPoint:TPoint;
    w:integer;
begin
 flgDrawField:=False;
 ChScaleX:= ChartFieldZoom.ChartWidth/ChartFieldZoom.BackImage.Bitmap.Width;
 ChScaleY:= ChartFieldZoom.ChartHeight/ChartFieldZoom.BackImage.Bitmap.Height;
 ChRect:=ChartFieldZoom.ChartRect;
 CurrPoint:=point(X,Y);
if FlgStopScan then
 if PointInside(CurrPoint,ChRect) then
   begin
      flgMouseDown:=True;
      X:=round((X-ChRect.Left)/ChScaleX);//round(X*DelImg2);
      Y:=round((Y-Chrect.Top)/ChscaleY);
      mX0:=X;
      mY0:=Y;

   if (Button=mbLeft) and (ScanParams.ScanMethod<>Litho)  and (ScanParams.ScanMethod<>lithoCurrent) then
   begin
      flgLeftBtn:=True;
      flgLeftBtnPressed:=True;
       with R_S do
        begin
          Left:=x;
          Right:=x;
          Top:=y;
          Bottom:=y;
        end;
       FieldSizeStr:='['+FloatToStrF(0,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_1' (* ' x ' *) )+ FloatToStrF(0,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_2' (* ' (nm)' *) )+']';

       with ChartFieldZoom.BackImage.BitMap.Canvas do
        begin
         Pen.Style:= psSolid;
         Brush.Style:= bsSolid;
         Pen.Width:=2;
         Pen.Mode:=pmNOTXOR;
         Pen.Color:=clBlack;
         Polyline([Point(mx0,my0),Point(mx0,my0)]);
         Polyline([Point(R_S.Left,R_S.Bottom),Point(R_S.Left,R_S.Top),
         Point(R_S.Right,R_S.Top),Point(R_S.Right,R_S.Bottom),Point(R_S.Left,R_S.Bottom)]);
       end;
       caption:=baseCaption+FieldSizeStr;
      R_S.TopLeft:=Point(X,Y);
      R_S.BottomRight:=Point(X,Y);
   end
   else // Button<> mbLeft
   begin
     if (R_S.Left=0) and (R_S.Top=0) and (R_S.Right=0) and (R_S.Bottom=0) then
       with ScanParams do
             begin
               R_S.Left:=round((ChartFieldZoom.BottomAxis.CalcPosValue(XBegin)-ChRect.Left)/ChScaleX);
               R_S.Right:=round((ChartFieldZoom.BottomAxis.CalcPosValue(XBegin+X)-ChRect.Left)/ChScaleX);
               R_S.Top:=round((ChartFieldZoom.LeftAxis.CalcPosValue(YBegin+Y)-ChRect.Top)/ChScaleY);
               R_S.Bottom:=round((ChartFieldZoom.LeftAxis.CalcPosValue(YBegin)-ChRect.Top)/ChScaleY);
            end;
      if ((X>R_S.Left) and (X<R_S.Right) and (Y>R_S.Top) and (Y<R_S.Bottom))
        then
          flagMoveArea:=true;   flgLeftBtn:=False;
          with  ChartFieldZoom.BackImage.BitMap.Canvas do
               begin
                  Pen.Color:=clBlack;
                  Pen.Mode:=pmNOTXOR;
                  Polyline([Point(R_S.Left,R_S.Bottom),Point(R_S.Left,R_S.Top),
                  Point(R_S.Right,R_S.Top),Point(R_S.Right,R_S.Bottom),Point(R_S.Left,R_S.Bottom)]);
                  Caption:=BaseCaption+ FieldSizeStr;
               end;
    end;
end;
end;  {FieldMouseDown}



procedure   TFieldZoom.FieldMouseMove( X,Y:integer);
var XSizenm,YSizenm:single;
begin
 if flgMouseDown then
  if FlgStopScan then
    begin
      X:=round((X-ChRect.Left)/ChScaleX);//round(X*DelImg2);
      Y:=round((Y-Chrect.Top)/ChscaleY);
      with ChartFieldZoom.BackImage.Bitmap do
       begin
        if (X>Width)  then X:= Width;
        if (Y>Height) then Y:= Height;
        if (X<0) then X:=0;
        if (Y<0) then Y:=0;
       end;
     if ((abs(x-mx0)>5) or (abs(y-my0)>5)) then
      begin
      flgDrawField:=true;
       with ChartFieldZoom.BackImage.Bitmap.Canvas do
        begin
          Pen.Color:=clBlack;
          Polyline([Point(R_S.Left,R_S.Bottom),Point(R_S.Left,R_S.Top),
          Point(R_S.Right,R_S.Top),Point(R_S.Right,R_S.Bottom),Point(R_S.Left,R_S.Bottom)]);
          Caption:=BaseCaption+ FieldSizeStr; Font.Color:=clGreen;
        end;
    if flgLeftBtn then
      begin
       if (MX0<X)  then begin R_S.Left:=MX0; R_S.Right:=X;   end
                   else begin R_S.Left:=X;   R_S.Right:=MX0; end;
       if (MY0<Y)
         then
          begin
            R_S.Top:=MY0;
            if ScanParams.FlgSQ then
             begin
              if (MX0>X) then
               begin
                R_S.Bottom:=MY0-(X-MX0);
              if R_S.Bottom>ChartFieldZoom.BackImage.Bitmap.Height{scanparams.ny} then
                 begin
                   R_S.Bottom:=ChartFieldZoom.BackImage.Bitmap.Height{scanparams.ny};
                   R_S.Left:=R_S.Right-(R_S.Bottom-R_S.top)
                  end
               end
              else
               begin
                R_S.Bottom:=MY0+(X-MX0);
                if R_S.Bottom>ChartFieldZoom.BackImage.Bitmap.Height{scanparams.ny} then
                  begin
                    R_S.Bottom:=ChartFieldZoom.BackImage.Bitmap.Height;
                    R_S.Right:=R_S.left+(R_S.Bottom-R_S.top)
                  end
               end
              end
              else R_S.Bottom:=Y; //FlgSQ=false
          end
         else       //Y0>y
          begin
             R_S.Bottom:=MY0;
             if ScanParams.FlgSQ then
               begin
                if (MX0<X) then
                      begin
                        R_S.Top:=MY0-(X-MX0); if R_S.Top<0 then begin R_S.Top:=0; R_S.Right:=R_S.left+(R_S.Bottom-R_S.Top);end
                      end
                     else
                      begin
                        R_S.Top:=MY0+(X-MX0); if R_S.Top<0 then begin R_S.Top:=0; R_S.Left:=R_S.Right-(R_S.Bottom-R_S.Top);end
                      end
                end
                     else R_S.Top:=Y;   //flgSq:=False
          end;
       with ChartFieldZoom.BackImage.Bitmap do
        begin
          if R_S.left<0 then  R_S.left:=0;
          if R_S.Right>width then  R_S.Right:=width;
          if R_S.Top<0 then R.Top:=0;
          if R_S.Bottom>height then R_S.Bottom:=height;
        end;
           XEndZoom:=ChartFieldZoom.BottomAxis.CalcPosPoint(round(R_S.Right*ChscaleX+CHRect.Left));
           XBeginZoom:=ChartFieldZoom.BottomAxis.CalcPosPoint(round(R_S.Left*ChscaleX+CHRect.Left));
           YBeginZoom:=ChartFieldZoom.LeftAxis.CalcPosPoint(round(R_S.Bottom*ChscaleY+CHRect.Top));
           YEndZoom:=ChartFieldZoom.LeftAxis.CalcPosPoint(round(R_S.Top*ChscaleY+CHRect.Top));
           XSizenm:=XEndZoom-XBeginZoom;
           YSizenm:=YEndZoom-YBeginZoom;
           if ScanParams.FlgSQ then
            FieldSizeStr:='['+FloatToStrF(XSizenm,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_1' (* ' x ' *) )+ FloatToStrF(XSizenm,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_2' (* ' (nm)' *) )+']'
           else
            FieldSizeStr:='['+FloatToStrF(XSizenm,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_1' (* ' x ' *) )+ FloatToStrF(YSizenm,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_2' (* ' (nm)' *) )+']';
          end // LeftBtn
     else  // right btn
     begin
       if flagMoveArea then
        begin
         if ((R_S.Right+(X-mX0+1)<=ChartFieldZoom.BackImage.Bitmap.Width) and ((R_S.Left+(X-mX0)-1)>=0)
           and ((R_S.Bottom+(Y-mY0)-1)<=ChartFieldZoom.BackImage.Bitmap.Height)
             and ((R_S.Top+(Y-mY0)+1)>=0)) then
          begin
           R_S.Left:=R_S.Left+(X-mX0);
           R_S.Right:=R_S.Right+(X-mX0);
           R_S.Bottom:=R_S.Bottom+(Y-mY0);
           R_S.Top:=R_S.Top+(Y-mY0);
           mX0:=X;
           my0:=Y;
          end;
       end;
      if flgLeftBtnPressed then
       begin
           XEndZoom:=ChartFieldZoom.BottomAxis.CalcPosPoint(round(R_S.Right*ChscaleX+CHRect.Left));
           XBeginZoom:=ChartFieldZoom.BottomAxis.CalcPosPoint(round(R_S.Left*ChscaleX+CHRect.Left));
           YBeginZoom:=ChartFieldZoom.LeftAxis.CalcPosPoint(round(R_S.Bottom*ChscaleY+CHRect.Top));
           YEndZoom:=ChartFieldZoom.LeftAxis.CalcPosPoint(round(R_S.Top*ChscaleY+CHRect.Top));
           XSizenm:=XEndZoom-XBeginZoom;
           YSizenm:=YEndZoom-YBeginZoom;
           if ScanParams.FlgSQ then
            FieldSizeStr:='['+FloatToStrF(XSizenm,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_1' (* ' x ' *) )+ FloatToStrF(XSizenm,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_2' (* ' (nm)' *) )+']'
           else
            FieldSizeStr:='['+FloatToStrF(XSizenm,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_1' (* ' x ' *) )+ FloatToStrF(YSizenm,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_2' (* ' (nm)' *) )+']'
       end
      else
      FieldSizeStr:='['+FloatToStrF(ScanParams.X,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_1' (* ' x ' *) )+ FloatToStrF(ScanParams.Y,fffixed,6,0)+siLangLinked1.GetTextOrDefault('IDS_2' (* ' (nm)' *) )+']'
     end;  //right

     with  ChartFieldZoom.BackImage.Bitmap.Canvas do
     begin
          Pen.Color:=clBlack;
          Polyline([Point(R_S.Left,R_S.Bottom),Point(R_S.Left,R_S.Top),
          Point(R_S.Right,R_S.Top),Point(R_S.Right,R_S.Bottom),Point(R_S.Left,R_S.Bottom)]);
        Caption:=BaseCaption+ FieldSizeStr;
    //       Font.Color:=clGreen;
   //         OldBkMode := SetBkMode(Handle, TRANSPARENT);
   //       TextOut(R_S.Left,R_S.Top-Font.Size-10,FieldSizeStr);
   //       SetBkMode(Handle, OldBkMode);
     end;
  end;
 end;
end;{FieldMouseMove}

procedure TFieldZoom.ChartFieldZoomMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ClipCursor(nil);  flgMouseDown:=false;
if  ScanParams.ScanMethod<>Spectr then
if FlgStopScan  then
 begin
  flagMoveArea:=False;
     if  not FlgLeftBtn then
      begin
        mx0:=0;
        mY0:=0;
      end;

   if FlgDrawField then
     begin
      ScanWnd.FlgChange:=True;
      XBeginZoom:=ChartFieldZoom.BottomAxis.CalcPosPoint(round(R_S.Left*ChscaleX+CHRect.Left));
      YBeginZoom:=ChartFieldZoom.LeftAxis.CalcPosPoint(round(R_S.Bottom*ChscaleY+CHRect.Top));
       if flgLeftBtnPressed then
         begin
           XEndZoom:=ChartFieldZoom.BottomAxis.CalcPosPoint(round(R_S.Right*ChscaleX+CHRect.Left));
           YEndZoom:=ChartFieldZoom.LeftAxis.CalcPosPoint(round(R_S.Top*ChscaleY+CHRect.Top));
         end
       else
         begin
           XEndZoom:=XBeginZoom+scanParams.X;
           YEndZoom:=YBeginZoom+scanParams.Y;
         end;
    end;
  FlgLeftBtn:=False;
  flgMouseDown:=False;
 end;
end;

function TFieldZoom.PointInside(CurrPoint:Tpoint ; ChRect:TRect):boolean;
begin
Result:=False;
if  (CurrPoint.X >=ChRect.Left)   and (CurrPoint.X<=ChRect.Right)
    and (CurrPoint.Y>=ChRect.Top) and (CurrPoint.Y<=ChRect.Bottom)
    then Result:=True;
end;


procedure TFieldZoom.FormClose(Sender: TObject; var Action: TCloseAction);
var XSizenm,YSizenm:single;
n:integer;
begin
if flgDrawField then
begin
  XSizenm:=abs(XBeginZoom-XEndZoom);
  if ScanParams.FlgSQ then  YSizenm:=XSizenm
                      else  YSizenm:=abs(YBeginZoom-YEndZoom);
  if XSizenm=0 then XSizenm:=1;
  if YSizenm=0 then YSizenm:=1;
  ScanParams.XBegin:=XBeginZoom;
  ScanParams.YBegin:=YBeginZoom;
  with ScanWnd do
  begin
     EdX.Text:=FloatToStrF(round(XSizenm),fffixed,8,0);
     EdY.Text:=FloatToStrF(round(YSizenm),fffixed,8,0);
  end;
  if ScanParams.FlgStepXY then
  begin
     N:=round(XSizenm/ScanParams.StepXY-0.5);
     ScanWnd.edNX.text:=intToStr(N);
     N:=round(YSizenm/ScanParams.StepXY-0.5);
     ScanWnd.edNY.text:=intToStr(N);
  end;
  if  not flgLeftBtnPressed then ModalResult:=mrOnlyMove
  else  ModalResult:=mrOK;
end
else ModalResult:=mrCancel;
 FreeandNil(BufBitMap);
 FreeandNil(InterpBitMap);
end;


procedure TFieldZoom.FormResize(Sender: TObject);
var
FSize:integer;
Left,Right,Top,Bottom:single;
begin
if FlgFinishDrawChart then
begin
 ClientHeight:=round(HToWRatio*ClientWidth);
end;
end;

procedure  TFieldZoom.SQChartRect;
var R:single;
begin
if ChartFieldZoom.ChartWidth<>ChartFieldZoom.ChartHeight then
begin
 R:=ChartFieldZoom.ChartWidth/ChartFieldZoom.ChartHeight;
 ChartFieldZoom.Height:=round(R*ChartFieldZoom.Height);
end;
end;


procedure   TFieldZoom.DrawFieldnm( X0,Y0,XLength,YLength:single);
var Left, Right, Top, Bottom:integer;
begin
with Series1 do
  begin
     AddXY(X0,Y0);
     AddXY(X0,Y0+YLength);
     AddXY(X0+XLength, Y0+YLength);
  end;
with Series2 do
  begin
     AddXY(X0,Y0);
     AddXY(X0+XLength, Y0);
     AddXY(X0+XLength, Y0+YLength);
  end;

end;


procedure TFieldZoom.ChartFieldZoomAfterDraw(Sender: TObject);
begin
if FlgFirstDraw then
begin
 FlgFirstDraw:=False;
 SqChartRect;
 HtoWRatio:=ChartFieldZoom.Height/ChartFieldZoom.Width;
 FlgFinishDrawChart:=True;
end;
end;

procedure TFieldZoom.StretchBitMap(DestBitMap, SourcebitMap:TBitMap);
begin
   SetStretchBltMode(DestBitMap.Canvas.Handle, COLORONCOLOR);
   StretchBlt(DestBitMap.Canvas.Handle,
       0, 0,
       DestBitMap.Width, DestBitMap.Height,
       SourcebitMap.Canvas.Handle,
       0, 0,
       SourcebitMap.Width,
       SourcebitMap.Height,
       SRCCOPY);

end;
end.
