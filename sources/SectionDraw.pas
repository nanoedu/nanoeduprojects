//280802
unit SectionDraw;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, Menus, StdCtrls,
  SpmChart,OpenGL;
 
type
  TSection = class(TForm)
    MainMenu1: TMainMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  //  PtSect: TPtSect ;
    ChartPanel: TChartGraphica;
  end;
 type
    TPtSect=^SectGL;
     SectGL=record
        Sect:TSection;
        GLList:GLUint; //
        end;
var PtSect: TPtSect ;

implementation

{$R *.DFM}
uses OpenGlDraw;


procedure TSection.FormClose(Sender: TObject; var Action: TCloseAction);
var i,Count:integer;
    FrmS:TSection;
begin
      Count:=ArFrmSect.Count;
 for i:=(Count-1) downto 0 do
  begin
   PtSect:=ArFrmSect.Items[i];
   FrmS:=TSection(PtSect.Sect);
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



procedure TSection.FormCreate(Sender: TObject);
begin
  width:=700;
  height:=550;
  ChartPanel:= TChartGraphica.Create(TComponent(Self));
  ChartPanel.Parent:= Self;
  ChartPanel.Align:= alClient;
  MainMenu1.Items.Add(ChartPanel.EditChartMenu);
   PtSect.Sect:=self;
  Self.OldCreateOrder:= True;
end;

procedure TSection.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ChartPanel.Action(Round(Key));
end;

end.
