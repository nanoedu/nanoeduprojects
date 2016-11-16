unit frCurrentLine;

interface

uses
  Windows,   Classes,  Forms,
   TeEngine, Series,  TeeProcs, Chart, Controls, ExtCtrls, siComp, siLngLnk,
  StdCtrls, Buttons;

type
  TCurrentLineWnd = class(TForm)
    siLangLinked1: TsiLangLinked;
    Panel1: TPanel;
    PanelBottom: TPanel;
    ChartCurrentLine: TChart;
    SeriesLine: TFastLineSeries;
    SeriesAddLine: TFastLineSeries;
    BitBtnHideH: TBitBtn;
    BitBtnHideAdd: TBitBtn;
    BitBtnShowH: TBitBtn;
    BitBtnShowAdd: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnHideAddClick(Sender: TObject);
    procedure BitBtnShowAddClick(Sender: TObject);
    procedure BitBtnHideHClick(Sender: TObject);
    procedure BitBtnShowHClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReDraw;
  end;

var
  CurrentLineWnd: TCurrentLineWnd;

implementation

uses globalvar,CSPMVar,mMain,frScanWnd;

{$R *.dfm}

procedure TCurrentLineWnd.ReDraw;
begin
     SeriesLine.Clear;
     SeriesAddLine.Clear;
         case ScanParams.ScanPath of
 Multi,OneX:
        begin
          ChartCurrentLine.BottomAxis.SetMinMax(0,ScanParams.X);
        end;
MultiY,OneY:
        begin
          ChartCurrentLine.BottomAxis.SetMinMax(0,ScanParams.Y);
        end;
                end;
       ChartCurrentLine.Update;

end;

procedure TCurrentLineWnd.BitBtnHideAddClick(Sender: TObject);
begin
   ChartCurrentLine.RightAxis.Visible:=false;
   SeriesAddLine.visible:=false;
   if ChartCurrentLine.LeftAxis.Visible then
    Caption:=siLangLinked1.GetTextOrDefault('IDS_0' { 'Current Line ' } )+ScanWnd.TabSheetCurScan.Caption;
end;

procedure TCurrentLineWnd.BitBtnHideHClick(Sender: TObject);
begin
   ChartCurrentLine.LeftAxis.Visible:=false;
   SeriesLine.visible:=false;
   ChartCurrentLine.RightAxis.Grid.Visible:=ChartCurrentLine.RightAxis.Visible;
  if ChartCurrentLine.RightAxis.Visible then
   Caption:=siLangLinked1.GetTextOrDefault('IDS_0' { 'Current Line ' } )+ScanWnd.TabSheetCurLineAdd.Caption;
end;

procedure TCurrentLineWnd.BitBtnShowAddClick(Sender: TObject);
begin
   ChartCurrentLine.RightAxis.Visible:=true;
   SeriesAddLine.visible:=true;
   ChartCurrentLine.RightAxis.Grid.Visible:=not ChartCurrentLine.LeftAxis.Visible ;
   Caption:=siLangLinked1.GetTextOrDefault('IDS_0' { 'Current Line ' } )+ScanWnd.TabSheetCurLineAdd.Caption;
   if ChartCurrentLine.LeftAxis.Visible then caption:=caption+';'+ScanWnd.TabSheetCurScan.Caption;
end;

procedure TCurrentLineWnd.BitBtnShowHClick(Sender: TObject);
begin
   ChartCurrentLine.LeftAxis.Visible:=true;
   SeriesLine.visible:=true;
    if  ChartCurrentLine.RightAxis.Grid.Visible then
    begin
      ChartCurrentLine.LeftAxis.Grid.Visible:=true;
      ChartCurrentLine.RightAxis.Grid.Visible:=false;
    end;
    Caption:=siLangLinked1.GetTextOrDefault('IDS_0' { 'Current Line ' } )+ScanWnd.TabSheetCurScan.Caption;
   if ChartCurrentLine.LeftAxis.Visible then caption:=caption+';'+ScanWnd.TabSheetCurLineAdd.Caption;
end;

procedure TCurrentLineWnd.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
     ScanWnd.SeriesLine.Clear;
     ScanWnd.SeriesAddLine.Clear;
     Action:=caFree;
     CurrentLineWnd:=nil;
end;

procedure TCurrentLineWnd.FormCreate(Sender: TObject);
begin
     siLangLinked1.ActiveLanguage:=Lang;
     top:=ScanWnd.ClientToScreen(Point(0,0)).y+60;
     left:=ScanWnd.ClientToScreen(Point(0,0)).x+240;
     width:=700;
     ChartCurrentLine.RightAxis.Visible:=false;
     ChartCurrentLine.RightAxis.Title.Caption:=ScanWnd.TabSheetCurLineAdd.Caption;
     Caption:=siLangLinked1.GetTextOrDefault('IDS_0' { 'Current Line ' } )+ScanWnd.TabSheetCurScan.Caption;
(*
     SeriesLine.Active:=(ScanWnd.PageCtrlAdd.ActivePage=ScanWnd.TabSheetCurScan);
  if  SeriesLine.Active then Caption:=siLangLinked1.GetTextOrDefault('IDS_0' { 'Current Line ' } )+ScanWnd.TabSheetCurScan.Caption
                        else Caption:=siLangLinked1.GetTextOrDefault('IDS_0' { 'Current Line ' } )+ScanWnd.TabSheetCurLineAdd.Caption ;
     SeriesAddLine.Active:=not  (ScanWnd. PageCtrlAdd.ActivePage=ScanWnd. TabSheetCurScan);
  *)
   PanelBottom.visible:=false;
   ChartCurrentLine.LeftAxis.SetMinMax(0,1);
   if  ScanWnd.TabSheetCurLineAdd.TabVisible then
   begin
    PanelBottom.visible:=true;
    Caption:=Caption+' ; '+ScanWnd.TabSheetCurLineAdd.Caption;
    ChartCurrentLine.RightAxis.SetMinMax(0,1);
    SeriesAddLine.visible:=true;
    ChartCurrentLine.RightAxis.Visible:=true;
   end;

         case ScanParams.ScanPath of
 Multi,OneX:
        begin
          ChartCurrentLine.BottomAxis.SetMinMax(0,ScanParams.X);
        end;
MultiY,OneY:
        begin
          ChartCurrentLine.BottomAxis.SetMinMax(0,ScanParams.Y);
        end;
                end;
     ChartCurrentLine.BottomAxis.Automatic:=false;
     ChartCurrentLine.LeftAxis.Automatic:=false;
     ChartCurrentLine.RightAxis.Automatic:=false;
end;

end.
