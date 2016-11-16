unit frImageAnalysis;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, TeeProcs, Chart, ExtCtrls,
  GlobalDcl, GlobalVar,ComCtrls, StdCtrls, FourierProc, Buttons, math;
  

type
  TImgAnalysWnd = class(TForm)
    PanelRight: TPanel;
    PageControlResults: TPageControl;
    TabSheetRoughness: TTabSheet;
    Panel4: TPanel;
    HistChart: TChart;
    Series2: TBarSeries;
    Panel5: TPanel;
    RichEdit1: TRichEdit;
    Panel6: TPanel;
    SpectrumChart: TChart;
    tabSheetSpectr: TTabSheet;
    Series3: TLineSeries;
    PanelSpecTools: TPanel;
    ClearBitBtn: TBitBtn;
    SpeedBtnFreq: TSpeedButton;
    SpeedBtnAngle: TSpeedButton;
    PanelindFrq: TPanel;
    IndicateLabel: TLabel;
    PanelLeft: TPanel;
    PanelImgTools: TPanel;
    PanelLeftChart: TPanel;
    ImgChart: TChart;
    Series1: TLineSeries;
    PanelZ: TPanel;
    ImageZGrad: TImage;
    Label1: TLabel;
    Label2: TLabel;
    PanelIndPeriod: TPanel;
    Label3: TLabel;
    SpeedBtnDist: TSpeedButton;
    SpeedBtnAngleImg: TSpeedButton;
    ClearImgSpeedBtn: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControlResultsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImgChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure SpectrumChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ClearBitBtnClick(Sender: TObject);
    procedure SpectrumChartMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure SpectrumChartMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure ImgChartAfterDraw(Sender: TObject);
    procedure SpectrumChartAfterDraw(Sender: TObject);
    procedure SpeedBtnFreqClick(Sender: TObject);
    procedure SpeedBtnAngleClick(Sender: TObject);
    procedure ImgChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImgChartMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ClearImgSpeedBtnClick(Sender: TObject);
   // procedure FormCreate(Sender: TObject);
  private
  BitMap:TBitMap;
  hpal:HPALETTE;
  RfAver,RfSq:single;
  Dmin, Dmax:real;
  Step:single;
  DataFloatMas:TDataFloatCount;
  FlgFourierCounted:Boolean;
  FlgSpecChrtFirstDraw, FlgImgChrtFirstDraw:Boolean;
  LX,LY:integer;
  Measure1:string;
  X0,Y0,X1,Y1:integer;
  AngleBegin, FreqBegin:Boolean;
  AngleImgBegin,DistBegin:Boolean;
  SecondClick:boolean;
  XFreq,Yfreq:single;
  Angle0,Angle1,Angle:single;
  ChartFieldY,ChartFieldX:integer; //Estimate of axes fields
   ChX0,ChY0:single;
   FlgCreate:boolean;
    { Private declarations }
   procedure WMMOve(var Mes:TWMMove); message WM_Move;
   procedure FloatMasInit(Dat:TData);
   procedure SpectrSheetInit(Dat:TData);

  public
  constructor Create(Sender: TObject; Dat:TData; ImgTitle:string);
 // destructor Destroy;
  procedure MakePalette(BitMap: TBitMap);
  procedure DrawData( BitMap: TBitMap; Dat:TData); //overload;
  procedure DrawDataFloat( BitMap: TBitMap; Dat:TDataFloatCount); //overload;

    { Public declarations }
  end;
 function Hist(Dat:TData;var MinVal:integer):TMas1;
 procedure RoughnessParam(Dat:tdata; var Ra,Rq:single);
var
  ImgAnalysWnd: TImgAnalysWnd;

implementation
uses fTools, mMain;//, mMain;
{$R *.dfm}
function sign(x:single):single;
begin
 sign:=1;
 if x<0 then sign:=-1;
end;
 procedure TImgAnalysWnd.WMMOve(var Mes:TWMMove);
begin
    if Mes.YPos<Main.ToolBar1.Height+3 then Top:=Main.ToolBar1.Height+3;
end;
constructor TImgAnalysWnd.Create(Sender: TObject; Dat:TData;ImgTitle:string);
var i{,X,Y}:integer;
 XL,Yl,XR,yR:integer;
 R:TRect;
 H:TMas1;
 L,StartInd:integer;
 ss:string;
 HeightChartNew,WidthChartNew:integer;
 H0,W0,CH,CW:integer;
 MinVal,HistMin,HistMax:integer;
begin
FlgCreate:=True;
FlgSpecChrtFirstDraw:=True;
FlgImgChrtFirstDraw:=True;
inherited Create(application);
ChartFieldY:=40;
ChartFieldX:= 40;
 if   flgViewTools then frTools.Hide;
 FlgFourierCounted:=False; // It becomes True if Fourier spectrum is counted;
 AngleBegin:=False;
 AngleImgBegin:=False;
 FreqBegin:=False;
 DistBegin:=False;
 SecondClick:=False;
 measure1:='nm';//dat.caption;
// width:=main.ClientWidth-140;
// height:=Main.ClientHeight-140;
 with PageControlResults do
 begin
   Align:=alClient;
   ActivePageIndex:=0;
 end;
width:=main.ClientWidth*3 div 4;
height:=main.ClientHeight*3 div 4;
panelLeft.top:=0;
panelLeft.left:=0;
panelRight.top:=0;
panelLeft.Height:=clientheight;
panelLeft.width:=(clientwidth div 2) -2;
panelRight.Height:=clientheight;
panelRight.width:=clientwidth div 2;
panelRight.left:=panelLeft.width+2;
panelLeftChart.top:=panelLeft.top+PanelImgTools.Height;
panelLeftChart.left:=0;
panelLeftChart.Height:=panelLeft.ClientHeight-PanelIndPeriod.Height-PanelImgTools.Height;
panelLeftChart.width:=panelLeft.clientwidth;
PanelIndPeriod.top:=panelLeftChart.Height+panelLeftChart.top;
PanelIndPeriod.left:=0;
PanelIndPeriod.Width:=panelLeft.ClientWidth;
PanelZ.top:=2;
PanelZ.Left:=Panelleftchart.Width-Panelz.Width;
PanelZ.Height:=Panelleftchart.height-4;
imageZgrad.left:=0;
PanelImgTools.width:=panelLeft.clientwidth;
Panel4.Height:=TabSheetRoughness.Height*2 div 3;
Panel4.Width:=TabSheetRoughness.Width;
Panel4.Top:=0;
Panel4.Left:=0;
Panel5.Top:=Panel4.Height;
Panel5.Left:=0;
Panel5.Height:=TabSheetRoughness.Height-Panel4.Height;
Panel5.Width:=TabSheetRoughness.Width;
PanelIndFrq.width:=TabSheetSpectr.Clientwidth;
PanelIndFrq.left:=0;
with panel6 do
begin
//width:=TabSheetSpectr.Width;
width:=TabSheetSpectr.clientWidth;
height:=TabSheetSpectr.clientHeight-PanelSpecTools.Height-PanelindFrq.Height;
Left:=0;
Top:=PanelSpecTools.Height+1;
end;

PanelindFrq.Top:=Panel6.Top+Panel6.Height+1;

LX:=Dat.Nx;
LY:=Dat.Ny;
 Dmin:=Dat.datamin;
  Dmax:=Dat.datamax;
Step:=Dat.XStep;
Series1.Clear;


with  SpectrumChart.Title.Text do
begin
Clear;
Add(Imgtitle+' Fourier Spectrum');
end;


with ImgChart do
begin
LeftAxis.SetMinMax( 0, LY*Step );
LeftAxis.Title.Angle:=90;
LeftAxis.Title.Caption:=Measure1;//(dat.Caption);
BottomAxis.SetMinMax( 0, LX*Step );
BottomAxis.Title.Caption:=Measure1;//Dat.Caption;

end;
with  ImgChart.Title.Text do
begin
Clear;
Add(Imgtitle);
end;
with  HistChart.Title.Text do
begin
Clear;
Add('Image Histogram');
end;
HistChart.BottomAxis.Title.Caption:=dat.caption;

BitMap:=TBitMap.Create;
DrawData(BitMap,Dat);
with ImgChart do
begin
  if LX>=LY then
   begin
    Width:=Panelleftchart.Width-20-PanelZ.Width;
    Height:=round((Width-ChartFieldX)*LY/LX)+ChartFieldY;
    Left:=0;
    Top:=Panelleftchart.Height div 2-Height div 2;
   end
   else
   begin
     Height:=Panelleftchart.Height-20;
     Width:= round((Height-ChartFieldY)*LX/LY)+ChartFieldX;
     Top:=0;
     left:=(Panelleftchart.Width -PanelZ.Width) div 2-Width div 2;
   end;
  BackImage.Assign(BitMap);
  BackImageInside:=True;
end;
 

R:=ImgChart.ChartBounds;
XL:=ImgChart.ChartBounds.Left;

frTools.GradientRect(FromRGB,ToRGB,ImageZGrad.Canvas,0,255);
Label1.Caption:=FloatToStrF(Dmax,fffixed,5,0)+' '+dat.caption;
Label2.Caption:=FloatToStrF(Dmin,fffixed,5,0)+' '+dat.caption;

H:=Hist(Dat,MinVal);
L:=Length(H);
HistMin:=H[0];
for i:=0 to L do
 begin
   if H[i]<HistMin then HistMin:=H[i];
 end;
 HistMax:=H[0];
for i:=0 to L do
 begin
   if H[i]>HistMax then HistMax:=H[i];
 end;


(*for i:=0 to L-1 do
   if H[i]>0 then
    begin
     StartInd:=i+MinVal;
     break;
    end;
  *)
with HistChart.BottomAxis do
begin
 Automatic:=False;
 SetMinMax( MinVal, MinVal+L );
// Minimum:=StartInd;
// Maximum:=L;
end;
for i:=0 to L-1 do
Series2.AddXY(i+MinVal,H[i]);

RoughnessParam(Dat,RfAver,RfSq);


RichEdit1.Lines.Add('Roughness Average   '+ FloatToStrF(RfAver,fffixed,5,2)+
                                          ' '+dat.caption);
RichEdit1.Lines.Add('Root Mean Square    '+ FloatToStrF(RfSq,fffixed,5,2)+
                                          ' '+dat.caption);

SpectrSheetInit(Dat);
FloatMasInit(Dat);
PageControlResults.ActivePage.HighLighted:=True;
end; {Create}

procedure TImgAnalysWnd.FloatMasInit(Dat:TData);
var i,j:integer;
begin
 DataFloatMas:=TDataFloatCount.Create;
with DataFloatMas do
begin
  NX:=Dat.Nx;
  Ny:=Dat.Ny;
  SetLength(data,Nx,Ny);
  for i:=0 to Ny-1 do
  for j:=0 to Nx-1 do
    data[j,i]:=Dat.data[j,i];
end;
end;

procedure TImgAnalysWnd.SpectrSheetInit(Dat:TData);
var
//freqStepX,freqStepY:single;
freqMax:single;
begin
//freqStepX:=1/Dat.Nx/Step;
freqMax:=1/Step/2;

with SpectrumChart do
begin
//Width:=ImgChart.Width;
//Height:=ImgChart.Height;
  if LX>=LY then
   begin
    Width:=Panel6.Width-20-PanelZ.Width;
    //Height:=round(Width*LY/LX);
    Height:=round((Width-ChartFieldX)*LY/LX)+ChartFieldY;
    Left:=0;
    Top:=Panel6.Height div 2-Height div 2;
   end
   else
   begin
     Height:=Panel6.Height-20;
    // Width:= round(Height*LX/LY);
    Width:= round((Height-ChartFieldY)*LX/LY)+ChartFieldX;
     Top:=0;
     left:=(Panel6.Width ) div 2-Width div 2;
   end;
end;
with SpectrumChart do
begin
//width:=ImgChart.Width;
//height:=ImgChart.Height;
//Left:=ImgChart.Left;
//Top:=ImgChart.Top;
LeftAxis.SetMinMax( -freqMax, freqMax );
LeftAxis.Title.Angle:=90;
LeftAxis.Title.Caption:=('1/'+Measure1);
BottomAxis.SetMinMax( -freqMax, freqMax );
BottomAxis.Title.Caption:='1/'+Measure1;
end;
(*with  SpectrumChart.Title.Text do
begin
Clear;
Add(Imgtitle+'  Fourier Spectrum');
end;
*)
end;



procedure TImgAnalysWnd.MakePalette(BitMap: TBitMap);
var i : Integer;
    pal : PLogPalette;
   // hpal : HPALETTE;
begin
  pal := nil;
  GetMem(pal, sizeof(TLogPalette) + sizeof(TPaletteEntry) * 255);
  try
  begin
    pal.palVersion := $300;
    pal.palNumEntries := 256;
    for i := 0 to 255 do
    begin
      pal.palPalEntry[i].peRed := i;
      pal.palPalEntry[i].peGreen := i;
      pal.palPalEntry[i].peBlue := i;
      pal^.palPalEntry[i].peFlags := pc_nocollapse;
    end;
    if hPal<>0 then
    DeleteObject(hPal);
    hpal := CreatePalette(pal^);
  //  HandleNeeded;
  //  hpal := CreateHalftonePalette(Handle);
    if hpal <> 0 then
       BitMap.Palette := hpal; // Это место где созданная палитра присваиваеться Bitmap.
                             // Если писать без классов то надо писать так Bitmap.Palette:=hpal
  end
  finally
    FreeMem(pal);
  end;
end; {MakePalette}

procedure TImgAnalysWnd.DrawData( BitMap: TBitMap; Dat:TData);
var //BitMap: TBitMap;
    GreyEntr: integer;

    zscale: real;
    x,y: Integer;
    P:PByteArray;
    Height,Width: Integer;
    PointColor:integer;
begin
       BitMap.PixelFormat:=pf8bit ;
       BitMap.Height:=Dat.NY;
       BitMap.Width:=Dat.NX;
       Height:=Dat.NY;
       Width:=Dat.NX;
       GreyEntr:=255;

       if (Dmax-Dmin)<>0 then
       zscale:= GreyEntr/(Dmax-Dmin)
       else
       zscale:=1;
       MakePalette(BitMap);
       for y:=0 to Height-1 do
       begin
            P:=BitMap.ScanLine[y];
            for x:=0 to Width-1 do
            begin
                 PointColor:=round(zscale*(Dat.Data[x,height-y-1]-Dmin));
                 if (PointColor >255) then PointColor:=255 ;
                 if (PointColor <0)   then   PointColor:=0 ;
                 P[x]:=PointColor;
            end;
       end;

end; {DrawData}

procedure TImgAnalysWnd.DrawDataFloat( BitMap: TBitMap; Dat:TDataFloatCount);
var //BitMap: TBitMap;
    GreyEntr: integer;

    zscale: real;
    x,y: Integer;
    P:PByteArray;
    Height,Width: Integer;
    PointColor:integer;
begin
       BitMap.PixelFormat:=pf8bit ;
       BitMap.Height:=Dat.NY;
       BitMap.Width:=Dat.NX;
       Height:=Dat.NY;
       Width:=Dat.NX;
       GreyEntr:=255;

       if (Dmax-Dmin)<>0 then
       zscale:= GreyEntr/(Dmax-Dmin)
       else
       zscale:=1;

       MakePalette(BitMap);
       for y:=0 to Height-1 do
       begin
            P:=BitMap.ScanLine[y];
            for x:=0 to Width-1 do
            begin
                 PointColor:=round(zscale*(Dat.Data[x,height-y-1]-Dmin));
                 if (PointColor >255) then PointColor:=255 ;
                 if (PointColor <0)   then   PointColor:=0 ;
                 P[x]:=PointColor;
            end;
       end;

end; {DrawData}

procedure TImgAnalysWnd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
DeleteObject(hpal);
 if   flgViewTools then frTools.Show;
BitMap:=nil;
DataFloatMas.Free;
end;

function Hist(Dat:TData; var MinVal:integer):TMas1;
 var
 i,j:integer;
 a: integer;
 Histogr: TMas1;
 len: integer; // Histogram Length;
 begin
 MinVal:=(round(Dat.datamin));
 len:=(round(Dat.datamax)-MinVal)+1;
 if len<0 then
 begin
   ShowMessage('Image contains negative values');
   exit;
 end;
 SetLength(Histogr,len+1);
// SetLength(Hist,len);
  for i:=0 to Dat.NY-1 do
  for j:=0 to Dat.NX-1 do
    begin
    a:=(round(Dat.data[j,i]));
    Histogr[a-MinVal]:=Histogr[a-MinVal]+1;
    end;
  Hist:=Histogr;
  Histogr:=nil;
 end;

procedure RoughnessParam(Dat:tdata; var Ra,Rq:single);
var X,Y:integer;
i,j:integer;
Sum:double;
Aver:single;
begin
X:= Dat.Nx;
Y:=Dat.Ny;
Sum:=0;
Aver:=Dat.DataMean;
for i:=0 to Y-1 do
for j:=0 to X-1 do
Sum:=Sum+abs(Dat.Data[j,i]-Aver);

Ra:=Sum/X/Y;
Sum:=0;
for i:=0 to Y-1 do
for j:=0 to X-1 do
Sum:=Sum+(Dat.Data[j,i]-Aver)*(Dat.Data[j,i]-Aver);

Rq:=sqrt(Sum/X/Y);

end;

procedure TImgAnalysWnd.PageControlResultsChange(Sender: TObject);
var BitMapSpectr:TBitMap;
    I:integer;
begin
 with PageControlResults do
  begin
   for i:=0 to PageCount-1 do {PageControl.}Pages[i].HighLighted:=False;
   {PageControl.}ActivePage.HighLighted:=True;
  end;

if PageControlResults.activePage.name='tabSheetSpectr' then
begin
if not FlgFourierCounted then
  begin
    FourierSp(DataFloatMas);
    FlgFourierCounted:=True;
    BitMapSpectr:=TBitMap.Create;
    Dmin:=DataFloatMas.min;
    Dmax:=DataFloatMas.max;
    DrawdataFloat(BitMapSpectr,DataFloatMas);
    with SpectrumChart do
      begin
       // Width:=Panel6.Width;
       // Height:=round(Width*DataFloatMas.NY/DataFloatMas.NX);
        BackImage.Assign(BitMapSpectr);
        BackImageInside:=True;
end;
  end;
end
else
if BitMapSpectr<>nil
then BitMapSpectr:=nil;
 IndicateLabel.Caption:=' ';
 Label3.Caption:=' ';
end;

procedure TImgAnalysWnd.FormShow(Sender: TObject);
begin
end; {FormShow}



procedure TImgAnalysWnd.SpectrumChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var Freq, Period:single;

  begin
  FlgCreate:=False;
  SpectrumChart.Invalidate;//Repaint;
  With SpectrumChart do
    if SpeedBtnFreq.Down then
	  begin
     // Canvas.Pen.Mode:=pmCopy;
     //	Canvas.Pen.Color:=clYellow;
     FreqBegin:=True;

	  end
    else if SpeedBtnAngle.Down then
    begin
     Label3.Caption:=' ';
     with Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clblack;
        Width:=1;
        Mode:=pmnotXOR;
       end;

    //	Canvas.MoveTo( X,Y );
	 //  Canvas.LineTo( ChartXCenter, ChartYCenter );
      
      X0:=ChartXCenter;//X;
      X1:=X;
      Y0:= ChartYCenter;//Y;
      Y1:=Y;
      XFreq:={BottomAxis.CalcPosPoint}(X)-X0;
      YFreq:={LeftAxis.CalcPosPoint}(Y)-Y0;
      if Xfreq<>0 then
      Angle0:=arctan2(YFreq,Xfreq)
      else Angle0:=sign(Yfreq)*pi/2;
      AngleBegin:=True;
    end;
end;

procedure TImgAnalysWnd.SpectrumChartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 if ( AngleBegin) then
  begin
 with SpectrumChart.Canvas do begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     MoveTo(X0,Y0);
     LineTo(X,Y);
     X1:=X;
     Y1:=Y;

      XFreq:={SpectrumChart.BottomAxis.CalcPosPoint}(X)-X0;
      YFreq:={SpectrumChart.LeftAxis.CalcPosPoint}(Y)-Y0;
      if XFreq<>0 then
      Angle1:=arctan2(YFreq,Xfreq)
      else Angle1:=sign(YFreq)*pi/2;
      Angle:=Angle0-Angle1;
      Angle:=abs(Angle*180/pi);
      if Angle>180 then
      Angle:=360-Angle;
      IndicateLabel.Caption:='Angle= '+  FloatToStrF(Angle,fffixed,5,2)+' Degrees';

  end ;
end;
end;

procedure TImgAnalysWnd.SpectrumChartMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Freq, Period:single;
begin
if FreqBegin then
begin
with spectrumChart do
begin
 with Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clYellow;//clblack;
        Width:=1;
        Mode:=pmcopy;// pmnotXOR;
       end;
      Canvas.MoveTo( X0,Y0 );
	    Canvas.LineTo( ChartXCenter, ChartYCenter );
    	Canvas.MoveTo( X,Y );
	    Canvas.LineTo( ChartXCenter, ChartYCenter );
      XFreq:=BottomAxis.CalcPosPoint(X);
      YFreq:=LeftAxis.CalcPosPoint(Y);
      Freq:=sqrt(XFreq*XFreq+YFreq*YFreq);
      Period:=1/Freq;
      IndicateLabel.Caption:='Frequency= '+FloatToStrF(Freq,fffixed,8,5)+' 1/'+Measure1;
      Label3.Caption:='Period= '+  FloatToStrF(Period,fffixed,8,4)+' '+Measure1;
     X0:=X;
     y0:=Y;
     end;
end;

if (AngleBegin) then
with SpectrumChart.Canvas do begin
    MoveTo(X0,Y0);
    LineTo(X1,Y1);
   //  Pen.Mode:=pmCopy;
    MoveTo(X0,Y0);
    LineTo(X,Y);
    X1:=X; Y1:=Y;
end;
  AngleBegin:=False;
  FreqBegin:=False;
end;

procedure TImgAnalysWnd.ClearBitBtnClick(Sender: TObject);
begin
 SpectrumChart.Repaint;
 Label3.Caption:=' ';
 IndicateLabel.Caption:=' ';
end;


procedure TImgAnalysWnd.FormResize(Sender: TObject);
begin
 PanelLeft.top:=0;
 panelLeft.left:=0;
 panelRight.top:=0;
 panelLeft.Height:=clientheight;
 panelLeft.width:=(clientwidth div 2) -2;
 panelRight.Height:=clientheight;
 panelRight.width:=clientwidth div 2;
 panelRight.left:=panelLeft.width+2;
 panelLeftChart.top:=panelLeft.top+PanelImgTools.Height;
 panelLeftChart.left:=0;
 panelLeftChart.Height:=panelLeft.ClientHeight-PanelIndPeriod.Height-PanelImgTools.Height;
 panelLeftChart.width:=panelLeft.clientwidth;
 PanelIndPeriod.top:=panelLeftChart.Height+panelLeftChart.top;
 PanelIndPeriod.left:=0;
 PanelIndPeriod.Width:=panelLeft.ClientWidth;
 PanelZ.top:=2;
 PanelZ.Left:=Panelleftchart.Width-Panelz.Width;
 PanelZ.Height:=Panelleftchart.height-4;
 imageZgrad.left:=0;
 PanelImgTools.width:=panelLeft.clientwidth;
 Panel4.Height:=TabSheetRoughness.Height*2 div 3;
 Panel4.Width:=TabSheetRoughness.Width;
 Panel4.Top:=0;
 Panel4.Left:=0;
 Panel5.Top:=Panel4.Height;
 Panel5.Left:=0;
 Panel5.Height:=TabSheetRoughness.Height-Panel4.Height;
 Panel5.Width:=TabSheetRoughness.Width;
 PanelIndFrq.width:=TabSheetSpectr.Clientwidth;
 PanelIndFrq.left:=0;
with panel6 do
begin
//width:=TabSheetSpectr.Width;
width:=TabSheetSpectr.clientWidth;
height:=TabSheetSpectr.clientHeight-PanelSpecTools.Height-PanelindFrq.Height;
Left:=0;
Top:=PanelSpecTools.Height+1;
end;

PanelindFrq.Top:=Panel6.Top+Panel6.Height+1;
end;

procedure TImgAnalysWnd.ImgChartAfterDraw(Sender: TObject);
var H0,W0,CH,CW,HeightChartNew,WidthChartNew:integer;

begin
if FlgCreate then
 with ImgChart do
  begin
  H0:=Height;
  W0:=Width;
  CH:=ChartHeight;
  CW:=ChartWidth;
  if LX>=LY then
   begin
     HeightChartNew:=round(CW*LY/LX)+H0-CH;
     Height:= HeightChartNew;
   end
   else
   begin
     WidthChartNew:=round(CH*LX/LY)+W0-CW;
     Width:= WidthChartNew;
   end;
if  FlgImgChrtFirstDraw then  Repaint;
    FlgImgChrtFirstDraw:=false;
  end;

end;

procedure TImgAnalysWnd.SpectrumChartAfterDraw(Sender: TObject);
var H0,W0,CH,CW,HeightChartNew,WidthChartNew:integer;

begin
if FlgCreate then
 with SpectrumChart do
  begin
  H0:=Height;
  W0:=Width;
  CH:=ChartHeight;
  CW:=ChartWidth;
  if LX>=LY then
   begin
     HeightChartNew:=round(CW*LY/LX)+H0-CH;
     Height:= HeightChartNew;
   end
   else
   begin
     WidthChartNew:=round(CH*LX/LY)+W0-CW;
     Width:= WidthChartNew;
   end;
 if  FlgSpecChrtFirstDraw then  repaint;
     FlgSpecChrtFirstDraw:=false;  
  end;
 X0:=SpectrumChart.ChartXCenter;
 Y0:=SpectrumChart.ChartYCenter;
end;

procedure TImgAnalysWnd.SpeedBtnFreqClick(Sender: TObject);
begin
SpectrumChart.Repaint;
end;

procedure TImgAnalysWnd.SpeedBtnAngleClick(Sender: TObject);
begin
SpectrumChart.Repaint;
end;

procedure TImgAnalysWnd.ImgChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

begin
FlgCreate:=False;
if  SpeedBtnDist.Down or SpeedBtnAngleImg.Down then
  if not SecondClick then
  begin
  ImgChart.Repaint;
  X0:=X; X1:=X;
  y0:=Y; Y1:=Y;
  chX0:=ImgChart.BottomAxis.CalcPosPoint(X0);
  chY0:=  ImgChart.LeftAxis.CalcPosPoint(Y0);
  end
  else {SecondClick}
  begin
  X0:=X1;
  Y0:=Y1;
  chX0:=ImgChart.BottomAxis.CalcPosPoint(X0);
  chY0:=  ImgChart.LeftAxis.CalcPosPoint(Y0);
  With ImgChart do
  begin
   with Canvas.Pen do
       begin
       Style:=psSolid;
        Color:=clBlue;//brush.color;
        Width:=1;
        Mode:=pmnotXOR;
       end;
  Canvas.MoveTo(X0,Y0);
  Canvas.LineTo(X,Y);
  end;
  end;
  X1:=X;
  y1:=Y;
With ImgChart do
    if SpeedBtnDist.Down then
	  begin
           with Canvas.Pen do
       begin
       Style:=psSolid;
        Color:=clBlue;//brush.color;
        Width:=1;
        Mode:=pmnotXOR;
       end;
   //  Canvas.MoveTo(X0,Y0);
    // Canvas.LineTo(X1,Y1);

     DistBegin:=True;
	  end
    else if SpeedBtnAngleImg.Down then
    begin
     Label3.Caption:=' ';
     with Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clblue;//clblack;
        Width:=1;
        Mode:=pmnotXOR;
       end;
     AngleImgBegin:=True;
   end;
  end;



procedure TImgAnalysWnd.ImgChartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  var dist,dx,dy:single;

  begin
if DistBegin   then
begin
   with ImgChart.Canvas do
    begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     MoveTo(X0,Y0);
     LineTo(X,Y);
     end;
     X1:=X;
     Y1:=Y;

     dx:=ImgChart.BottomAxis.CalcPosPoint(X)-chX0;
     dy:=ImgChart.LeftAxis.CalcPosPoint(Y)- chY0;

     dist:=sqrt(dx*dx+dy*dy);
     label3.Caption:='Distance= '+FloatToStrF(Dist,fffixed,6,2)+
                                  ' '+Measure1;
     end
 else if ( AngleImgBegin) then
  begin
 with ImgChart.Canvas do
  begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     MoveTo(X0,Y0);
     LineTo(X,Y);
     X1:=X;
     Y1:=Y;
   end;
    if SecondClick then
    begin
      dX:=ImgChart.BottomAxis.CalcPosPoint(X)-chX0;
      dY:=ImgChart.LeftAxis.CalcPosPoint(Y)-chY0;
      if dx<>0 then
      Angle1:=arctan2(dY,dX)
      else Angle1:=sign(dy)*pi/2;

      if Angle1<0 then Angle1:=2*pi-abs(Angle1);
      Angle:=Angle0-Angle1;

      Angle:=abs(Angle*180/pi);
      if Angle>180 then
      Angle:=360-Angle;
    //  Angle0:=Angle0*180/pi;
      Label3.Caption:='Angle= '+  FloatToStrF(Angle,fffixed,5,2)+' Degrees';

  end ;
end;

end;

procedure TImgAnalysWnd.ImgChartMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var dx,dy:single;
begin
if (DistBegin) or AngleImgBegin then

with ImgChart.Canvas do begin

    MoveTo(X0,Y0);
     LineTo(X1,Y1);
     Pen.Mode:=pmCopy;
     Pen.Color:=TColor($0200FF00);
     MoveTo(X0,Y0);
     LineTo(X,Y);
     X1:=X; Y1:=Y;
end;

 if AngleImgBegin and SpeedBtnAngleImg.Down then
  begin

  if  not SecondClick then
    begin
      dX:=chX0-ImgChart.BottomAxis.CalcPosPoint(X);
      dY:=chY0-ImgChart.LeftAxis.CalcPosPoint(Y);
      if dx<>0 then
      Angle0:=arctan2(dy,dx)
      else Angle0:=sign(dy)*pi/2;

      if Angle0 <0 then Angle0:=2*pi-abs(Angle0);
    end ;{not SecondClick}

     if (abs(X-X0)>5) or (abs(Y-Y0)>5) then
     SecondClick:=not SecondClick;
  end;
  DistBegin:=False;
  //if SecondClick then
  AngleImgBegin:=False;
  end;

procedure TImgAnalysWnd.ClearImgSpeedBtnClick(Sender: TObject);
begin
ImgChart.Repaint;
end;

end.
