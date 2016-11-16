//140802
unit SpectrGraphica;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls,Chart,Series,GlobalDCL;

type
  TfrSpectrGraph = class(TForm)
    PageControl: TPageControl;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
   NPage,NGraphP,Npoints:word; { Private declarations }
  public
   FileName:string; { Public declarations }
   ArTabSheet:array of TTabSheet;
   ArChart:array of TChart;
   ArSeries:array of  TLineSeries;
  // ArSeriesIn:array of TLineSeries;
   ZStep:smallint;
   ZStart:smallint;
   FlgSPReadBlock:Integer;
   TopoSPM: TExperiment;
  procedure DrawSpectr;
  end;


implementation

{$R *.DFM}

procedure TfrSpectrGraph.FormCreate(Sender: TObject);
var
    I:integer;
begin
  TopoSPM:=TExperiment.Create;
 //FileName:=ImFileName;
  TopoSPM.ImfileName:=FileNameIN;
  FlgSPReadBlock:=FlgReadBlock;
  TopoSPM.ReadSurface(FlgSpReadBlock);
  NPage:=TopoSPM.MainRcd.NyPoint;
  NGraphP:=2;
  ZStep:=10;
  ZStart:=0;
  NPoints:=TopoSPM.MainRcd.NxSpec DIV 4;
  SetLength(ArTabSheet,NPage);
  SetLength(ArChart,NPage);
  SetLength(ArSeries,NPage);
 // SetLength(ArSeriesIn,NPage);
  for i:=0 to (NPage-1) do
   begin
      ArTabSheet[i]:=TTabSheet.Create(PageControl);
      ArTabSheet[i].PageControl:=PageControl;
      ArTabSheet[i].TabVisible:=True;
      ArTabSheet[i].Caption:='Point= '+IntToStr(i+1);
      ArChart[i]:=TChart.Create(ArTabSheet[i]);
      ArChart[i].Parent:=ArTabSheet[i];
      ArChart[i].View3d:=False;
      ArChart[i].Align:=alClient;
   //   ArSeriesIn[i]:=TLineSeries.Create(ArChart[i]);
    //  ArSeriesIn[i].ParentChart:=ArChart[i];
  //    ArChart[i].OnMouseDown:=ChartResMouseDown;
      ArChart[i].Legend.Visible:=False;
      ArSeries[i]:=TLineSeries.Create(ArChart[i]);
      ArSeries[i].ParentChart:=ArChart[i];
     with ArChart[i].Title.Text do
        begin
	 Clear;
         Add('Spectroscopy Curve');
        end;
    end;
    DrawSpectr;
end;
procedure  TfrSpectrGraph.DrawSpectr;
var i,j,m,k:integer;
 begin
  for i:=0 to NPage-1 do
   for j:=0 to (NgraphP-1) do
     begin
       case j of
    0: begin
        m:=0;
      for k:=0 to (NPoints-1) do
       begin
        { TODO : Znmconv }
            ArSeries[i].AddXY(round({ZnmConv*}TopoSPM.AquiSpectr.Data[i,m+1]),
                  TopoSPM.AquiSpectr.Data[i,m],'',clBlue);
                m:=m+2;

       end;
        Application.ProcessMessages;
      end;
   1: begin
             m:=2*NPoints;
      for k:=NPoints to (2*NPoints-1) do
       begin
             ArSeries[i].AddXY(round({ZnmConv*}TopoSPM.AquiSpectr.Data[i,m+1]),
              TopoSPM.AquiSpectr.Data[i,m],'',clRed);
              m:=m+2;

        end;
           Application.ProcessMessages;
      end;
    end; //case
  end;
end;

procedure TfrSpectrGraph.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     Action:=caFree;
end;

end.
