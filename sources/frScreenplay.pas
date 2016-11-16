//190307
unit frScreenplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Menus, GlobalType,GlobalDcl;

type ff=procedure(Nx, Ny : integer;var p:Tmas2);  stdcall ;
     pff=^ff;
type
  TScriptplay = class(TForm)
    PanelTop: TPanel;
    PanelBottom: TPanel;
    BitBtnLoad: TBitBtn;
    BitBtnSaveTmpl: TBitBtn;
    PanelUp: TPanel;
    GroupBox1: TGroupBox;
    BitBtnOpenDoc: TBitBtn;
    BitBtnH: TBitBtn;
    GroupBoxAct: TGroupBox;
    BitBtnDelAct: TBitBtn;
    BitBtnAdd: TBitBtn;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    PopupMenuAdd: TPopupMenu;
    Median3: TMenuItem;
    Average3x31: TMenuItem;
    Planedelete1: TMenuItem;
    Surfacedelete1: TMenuItem;
    Bmpfilecreate1: TMenuItem;
    Panel1: TPanel;
    FilterListBox: TListBox;
    BitBtnClear: TBitBtn;
    procedure BitBtnAddMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Median3Click(Sender: TObject);
    procedure BitBtnOpenDocClick(Sender: TObject);
    procedure Average3x31Click(Sender: TObject);
    procedure Planedelete1Click(Sender: TObject);
    procedure Surfacedelete1Click(Sender: TObject);
    procedure BitBtnDelActClick(Sender: TObject);
    procedure BitBtnClearClick(Sender: TObject);
  private
    { Private declarations }
    FilterList:Tlist;
    lnx,lny:integer;
    ldatadraw:Tdata;
  public
    { Public declarations }
       constructor Create(AOwner:TComponent;nx,ny:integer; var Datadraw:Tmas2);
  end;

var
  Scriptplay: TScriptplay;

implementation

 uses surfacetools,OpenGlDraw;

{$R *.dfm}
constructor TScriptplay.Create(AOwner:TComponent;nx,ny:integer; var Datadraw:Tmas2);
var i:integer;
begin
 inherited Create(AOwner);
  filterlist:=Tlist.Create;
end;

procedure TScriptplay.BitBtnAddMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var point,pointa:Tpoint;
begin
    point.x:=x;
    point.y:=y;
    pointa:=BitBtnAdd.ClientToScreen(point);
    PopupMenuAdd.Popup(pointa.X,pointa.y);
end;

procedure TScriptplay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  ScriptPlay:=nil;
  filterlist.free;
end;

procedure TScriptplay.Median3Click(Sender: TObject);
var
filter:pff;
begin
 filter:=@MedianFilt3;
 filterlist.Add(filter);
  FilterlistBox.ItemIndex:=0;
 FilterlistBox.items.add('Median 3');
end;


procedure TScriptplay.BitBtnOpenDocClick(Sender: TObject);
var i:integer;
 Action:ff;
begin
     for i:=0 to filterlist.count-1 do
     begin
      @Action:=filterlist.items[i];
      if  assigned(ActiveGLW)  then Action(ActiveGLW.DataDraw.Nx,ActiveGLW.DataDraw.Ny,ActiveGLW.DataDraw.Data);
      ActiveGLW.Redraw;
    end;
end;

procedure TScriptplay.Average3x31Click(Sender: TObject);
var
filter:pff;
begin
 filter:=@AverageFilt3X3;
 filterlist.Add(filter);
 FilterlistBox.ItemIndex:=0;
 FilterlistBox.items.add('Average 3x3');
end;

procedure TScriptplay.Planedelete1Click(Sender: TObject);
 var
filter:pff;
begin
 filter:=@DelFiltPlane;
 filterlist.Add(filter);
 FilterlistBox.ItemIndex:=0;
 FilterlistBox.items.add('Plane delete');
end;

procedure TScriptplay.Surfacedelete1Click(Sender: TObject);
var
filter:pff;
begin
 filter:=@Del2XSurface;
 filterlist.Add(filter);
 FilterlistBox.ItemIndex:=0;
 FilterlistBox.items.add('Surface delete');
end;

procedure TScriptplay.BitBtnDelActClick(Sender: TObject);
var index:integer;
begin
  index:=FilterlistBox.ItemIndex;
  FilterlistBox.items.delete(Index);
  filterlist.delete(Index)
end;

procedure TScriptplay.BitBtnClearClick(Sender: TObject);
begin
 filterlist.Clear;
 FilterlistBox.Clear;
end;

end.
