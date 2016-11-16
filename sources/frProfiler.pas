unit frProfiler;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frParInput, ComCtrls, ToolWin, Buttons, ExtCtrls, Chart,SpmChart, siComp, siLngLnk,GlobalType, GlobalDCl,
  TeEngine,TeeProcs, Series, CSPMVar;

type
  TProfiler = class(TForm)
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
    Panel5: TPanel;
    LabelStep: TLabel;
    LabelStepMin: TLabel;
    StatusBar1: TStatusBar;
    ComboBoxPath: TComboBox;
    Label1: TLabel;
    TabSheetProfile: TTabSheet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    
  public
    { Public declarations }
      ArChart:TChartSpectrographiZ;
  end;

var
  ProfilerWND: TProfiler;

implementation

uses frScanWnd;
{$R *.dfm}

procedure TProfiler.FormClose(Sender: TObject; var Action: TCloseAction);
begin

    ArChart.Destroy;
    ArChart:=nil;
    if assigned(ScanWnd) then
   begin
    Scanwnd.RestoreStartSFM;     { TODO : 160906 }
   end;
   if assigned(ScanWnd)        then  ScanWnd.WindowState:=wsNormal;
    Action:=caFree;
  if (self=ProfilerWND) then  ProfilerWND:=nil;
end;

procedure TProfiler.FormCreate(Sender: TObject);
begin
   ArChart:=TChartSpectrographiZ.Create(TComponent(TabSheetProfile));
      ArChart.Align:=alClient;
      ArChart.AllowEditChartMenu.Checked:=false;
      InvalidateRect( ArChart.Handle, nil, False);
      ArChart.Chart.Legend.Visible:=True;
      ArChart.Chart.Legend.LegendStyle:=lsAuto;
      ArChart.Chart.Legend.ResizeChart:=true;
     // ArChart[i].Chart.LeftAxis.Automatic:=True;
      ArChart.Chart.LeftAxis.Automatic:=True;
      ArChart.Chart.LeftAxis.Title.Angle:=90;
      ArChart.Chart.LeftAxis.LabelsSize:=30;
      ArChart.Chart.ShowHint:=true;
      ArChart.Chart.hint:= 'Click Left Button to set label; Click Right Button to show popup menu' ;
      ArChart.Chart.LeftAxis.Title.Caption:='mcm';
      ArChart.Chart.BottomAxis.Title.Angle:=0;
      ArChart.Chart.BottomAxis.Title.Caption:='x  mcm';
    if not  ArChart.AllowEditChartMenu.Checked then ArChart.AllowEditClick(self);
        ArChart.EditFindLineChartPopUpMenu.Visible:=false;
        ArChart.EditFindLineChartMenu.Visible:=false;
        ArChart.AddSeries(clBlue);
        ArChart.HeadSeriesList.Series.title:=''; //rising   red;
        ArChart.HeadSeriesList.Series.SeriesColor:=clRed;
        ArChart.HeadSeriesList.Series.Pointer.Style:=psCircle;
        ArChart.HeadSeriesList.Series.Pointer.VertSize:=2;
        ArChart.HeadSeriesList.Series.Pointer.HorizSize:=2;
   end;

end.
