unit frDockWorkViewWnd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tabs, DockTabSet, ExtCtrls;

type
  TDockWorkView = class(TForm)
    Panel1: TPanel;
    DockTabSet1: TDockTabSet;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DockWorkView: TDockWorkView;

implementation

{$R *.dfm}
uses mMain,frSPM_Browser,globalvar;
procedure TDockWorkView.FormCreate(Sender: TObject);
begin
      WorkView:=TfrSPMView.Create(self,Workdirectory,{WorkView,}0);
      WorkView.Caption:='Pабочий Директорий';//    Work Directory';
      WorkView.ManualDock( Panel1);
      WorkView.DragKind:=dkDock;
      WorkView.DragMode:=dmAutomatic;

end;

end.
