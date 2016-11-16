//280802
unit DrawGraphics;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, Menus, StdCtrls,
  SpmChart,OpenGL;

type
  Tgraphica = class(TForm)
    MainMenu1: TMainMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    ChartPanel: TChartGraphica;
  end;
 type
    TPtSect=^SectGL;
     SectGL=record
        Sect:TGraphica;
        GLList:GLUint; //
        end;
 var PtSect: TPtSect ;

implementation

{$R *.DFM}
uses OpenGlDraw;


procedure Tgraphica.FormClose(Sender: TObject; var Action: TCloseAction);
var i,Count:integer;
    FrmS:TGraphica;
begin
      Count:=ArFrmSect.Count;
 for i:=(Count-1) downto 0 do
  begin
   PtSect:=ArFrmSect.Items[i];
   FrmS:=PtSect.Sect;
    if FrmS.Caption=self.Caption then
     begin
      glDeleteLists(PtSect^.GLList,1);
      ArFrmSect.Delete(i);
//      dispose(PtSect);
     end;
   end;
  ChartPanel.Destroy;
  Action:=caFree;
end;



procedure Tgraphica.FormCreate(Sender: TObject);
begin
  width:=700;
  height:=550;
  ChartPanel:= TChartGraphica.Create(TComponent(Self));
  ChartPanel.Parent:= Self;
  ChartPanel.Align:= alClient;
  MainMenu1.Items.Add(ChartPanel.EditChartMenu);
  Self.OldCreateOrder:= True;
end;

procedure Tgraphica.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ChartPanel.Action(Round(Key));
end;

end.
