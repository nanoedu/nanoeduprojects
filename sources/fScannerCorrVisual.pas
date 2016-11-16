unit fScannerCorrVisual;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TScannerCorrVisual = class(TForm)
    Chart1: TChart;
    Chart2: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
     procedure WMMove(var Mes:TWMMove); message WM_Move;
  public
    { Public declarations }
  end;

var
  ScannerCorrVisual: TScannerCorrVisual;

implementation

uses uScannerCorrect,CSPMVar{SystemConfig}, mMain;
{$R *.DFM}
procedure TScannerCorrVisual.WMMOve(var Mes:TWMMove);
begin
    if Mes.YPos<Main.ToolBar1.Height+5 then Top:=Main.ToolBar1.Height+5;
end;

procedure TScannerCorrVisual.FormShow(Sender: TObject);
var i:integer;
 SplineVal,xcount,Dist:single;
begin
  for i:=1 to NXSplines do
   begin
    Series1.AddXY(XXSp[i],YXSp[i]);
   end;
  for i:=1 to NYSplines do
   begin
     Series2.AddXY(XYSp[i],YYSp[i]);
   end;
  for i:=1 to  NXSplines*10 do
   begin
     xcount:=0.1*ScannerCorrect.GridCellSize*(i-1);
     SplineVal:=SEVAL(NXSplines,Xcount,XXsp,YXsp,BX,CX,DX);
     Series5.AddXY(xcount,Splineval);
   end;
   for i:=1 to  NYSplines*10 do
    begin
     xcount:=0.1*ScannerCorrect.GridCellSize*(i-1);
     SplineVal:=SEVAL(NYSplines,Xcount,XYsp,YYsp,BY,CY,DY);
     Series6.AddXY(xcount,Splineval);
    end;
 for i:=1 to NXSplines-1 do
 begin
  Dist:=YXSp[i+1]-YxSp[i];
  Series3.AddXY(XXSp[i],Dist);
 end;
 for i:=1 to NYSplines-1 do
  begin
    Dist:=YYSp[i+1]-YYSp[i];
    Series4.AddXY(XYSp[i],Dist);
  end;
end;

procedure TScannerCorrVisual.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TScannerCorrVisual.FormCreate(Sender: TObject);
begin
    Chart1.Width:=clientwidth div 2;
    chart2.width:=Chart1.width;
    chart1.height:=clientheight;
    chart2.height:=chart1.height;
    chart1.top:=0;
    chart1.left:=0;
    chart2.top:=chart1.top;
    chart2.left:=chart1.left+chart1.width;
end;

end.
