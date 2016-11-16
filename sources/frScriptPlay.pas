//271007
unit frScriptPlay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Menus, GlobalType,GlobalScanDataType,GlobalDcl, siComp,
  siLngLnk, ComCtrls, ToolWin;

type tfilter=procedure(Nx,Ny : integer;var p:Tmas2;filename:PChar);  stdcall ;
     ptfilter=^tfilter;

type ScriptAction= record
     filter:ptfilter;
     name:string[20];
    end;

type PScriptAction=^ScriptAction;

type
  TScriptPlay = class(TForm)
    PanelTop: TPanel;
    PanelUp: TPanel;
    GroupBoxAct: TGroupBox;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    PopupMenuAdd: TPopupMenu;
    Median3: TMenuItem;
    Average3x31: TMenuItem;
    Planedelete1: TMenuItem;
    Surfacedelete1: TMenuItem;
    mSaveAsBMP: TMenuItem;
    Panel1: TPanel;
    FilterListBox: TListBox;
    StepDelete1: TMenuItem;
    LevelDelete1: TMenuItem;
    mSaveAsJPG: TMenuItem;
    FourierFiltration1: TMenuItem;
    siLangLinked1: TsiLangLinked;
    ToolBar: TToolBar;
    StartBtn: TToolButton;
    HelpBtn: TToolButton;
    ToolBar1: TToolBar;
    BitBtnAdd: TToolButton;
    BitBtnDelAct: TToolButton;
    BitBTnClear: TToolButton;
    procedure BitBtnAddMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Median3Click(Sender: TObject);
    procedure BitBtnRunClick(Sender: TObject);
    procedure Average3x31Click(Sender: TObject);
    procedure Planedelete1Click(Sender: TObject);
    procedure Surfacedelete1Click(Sender: TObject);
    procedure BitBtnDelActClick(Sender: TObject);
    procedure BitBtnClearClick(Sender: TObject);
    procedure StepDelete1Click(Sender: TObject);
    procedure LevelDelete1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mSaveAsBMPClick(Sender: TObject);
    procedure mSaveAsJPGClick(Sender: TObject);
    procedure FourierFiltration1Click(Sender: TObject);
    procedure BitBtnHClick(Sender: TObject);
    procedure BitBtnAddClick(Sender: TObject);
  private
    { Private declarations }
    lnx,lny:integer;
    ldatadraw:TData;
  public
    { Public declarations }
     constructor Create(AOwner:TComponent;nx,ny:integer; var DataDraw:Tmas2);
     procedure   RunScript;
  end;

var
   ScriptPlay: TScriptPlay;
   FilterList:Tlist;

implementation

 uses Globalvar,nanoeduhelp,surfacetools,frOpenGlDraw,frTools,mMain;

{$R *.dfm}
constructor TScriptPlay.Create(AOwner:TComponent;nx,ny:integer; var DataDraw:Tmas2);
var    i:integer;
playaction:PScriptAction;
begin
 inherited Create(AOwner);
siLangLinked1.ActiveLanguage:=Lang;
 StartBtn.Enabled:=false;
 if not assigned(filterlist) then  filterlist:=Tlist.Create
         else
         begin
           if filterlist.Count>=1 then
           begin
            StartBtn.Enabled:=true;
            for i:=0 to filterlist.Count- 1 do
            begin
             playaction:=filterlist[i];
             FilterlistBox.items.add(playaction.name);
            end;
           end;
         end ;
end;

procedure TScriptPlay.BitBtnAddClick(Sender: TObject);
 var point,pointa:Tpoint;
 begin
    point.x:=BitBtnAdd.width div 3;
    point.y:=BitBtnAdd.height-10;
    pointa:=BitBtnAdd.ClientToScreen(point);
   PopupMenuAdd.Popup(pointa.X,pointa.y);
end;

procedure TScriptPlay.BitBtnAddMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var point,pointa:Tpoint;
begin
   (* point.x:=x;
    point.y:=y;
    pointa:=BitBtnAdd.ClientToScreen(point);
    PopupMenuAdd.Popup(pointa.X,pointa.y);
    *)
 //   bitbtnadd.Down:=false;
end;

procedure TScriptPlay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if assigned(FilterList) then
  begin
   if FilterList.count>=1 then
       if assigned(ImageTools) then ImageTools.BitBTnRunScript.enabled:=true;
  end
  else  filterlist.free;
  FilterListBox.Clear;
  action:=cafree;
  ScriptPlay:=nil;
end;

procedure TScriptPlay.Median3Click(Sender: TObject);
var
playaction:PScriptAction;
begin
 new(playaction);
 StartBtn.Enabled:=true;
 playaction.filter:=@MedianFilt3;
 playaction^.name:='Median 3x3';
 filterlist.Add(playaction);
 FilterlistBox.items.add(playaction.name);
 FilterlistBox.ItemIndex:= FilterlistBox.items.count-1;
end;


procedure TScriptPlay.BitBtnRunClick(Sender: TObject);
begin
 StartBtn.Enabled:=false;
 Application.ProcessMessages;
 RunScript;
 StartBtn.Enabled:=true;
 StartBtn.down:=false;
 Application.ProcessMessages;
end;

procedure TScriptPlay.RunScript;
var i:integer;
 playAction:pScriptAction ;
 actionfilter:tfilter;
begin
     for i:=0 to filterlist.count-1 do
     begin
      playaction:=filterlist[i];
      @actionfilter:=playaction.filter;
      if  assigned(ActiveGLW)  then
      begin
      if  (playaction.name='Save as bmp file') or  (playaction.name='Save as jpg file')  then hide;
       application.ProcessMessages;
       Actionfilter(ActiveGLW.DataDraw.Nx,ActiveGLW.DataDraw.Ny,ActiveGLW.DataDraw.Data,PChar(ExeFilePath+'DATA\'+FourierFiltTemplFile));
       ActiveGLW.ReDraw;
       if  (playaction.name='Save as bmp file') or  (playaction.name='Save as jpg file')  then show;
       application.ProcessMessages;
      end;
     end;
end;

procedure TScriptPlay.Average3x31Click(Sender: TObject);
var
playaction:PScriptAction;
begin
 new(playaction);
 StartBtn.Enabled:=true;
 playaction.filter:=@AverageFilt3X3;
 playaction.name:='Average 3x3' ;
 filterlist.Add(playaction);
 FilterlistBox.items.add(playaction.name);
 FilterlistBox.ItemIndex:= FilterlistBox.items.count-1;
end;

procedure TScriptPlay.Planedelete1Click(Sender: TObject);
 var
playaction:PScriptAction;
begin
 new(playaction);
 StartBtn.Enabled:=true;
 playaction.filter:=@DelFiltPlane;
 playaction.name:='Plane delete';
 filterlist.Add(playaction);
 FilterlistBox.items.add(playaction.name);
 FilterlistBox.ItemIndex:= FilterlistBox.items.count-1;
end;

procedure TScriptPlay.Surfacedelete1Click(Sender: TObject);
var
 playaction:PScriptAction;
begin
 new(playaction);
 StartBtn.Enabled:=true;
 playaction.filter:=@Del2XSurface;
 playaction.name:='Surface delete';
 filterlist.Add(playaction);
 FilterlistBox.items.add(playaction.name);
 FilterlistBox.ItemIndex:= FilterlistBox.items.count-1;
end;

procedure TScriptPlay.BitBtnDelActClick(Sender: TObject);
var index:integer;
  playaction:pScriptAction;
begin
if  filterlist.count<>0 then
 begin
  index:=FilterlistBox.ItemIndex;
  FilterlistBox.items.delete(Index);
  playaction:= filterlist[Index];
  playaction.filter:=nil;
  filterlist.delete(Index);
  dispose(playaction);
  if filterlist.count=0 then
    begin
      if assigned(ImageTools) then ImageTools.BitBTnRunScript.enabled:=false;
      StartBtn.Enabled:=false;
    end
    else  FilterlistBox.ItemIndex:=0;
 end;
end;

procedure TScriptPlay.BitBtnClearClick(Sender: TObject);
var i:integer;
playaction:pScriptAction;
begin
  for i:=filterlist.Count-1 downto 0 do
  begin
   playaction:= filterlist[i];
   playaction.filter:=nil;
   filterlist.delete(i);
   dispose(playaction);
  end;
 filterlist.Clear;
 FilterlistBox.Clear;
 StartBtn.Enabled:=false;
 if assigned(ImageTools) then ImageTools.BitBTnRunScript.enabled:=false;
end;

procedure TScriptPlay.StepDelete1Click(Sender: TObject);
var
faction:pScriptAction;
begin
 new(faction);
 StartBtn.Enabled:=true;
 if  assigned(ActiveGLW)  then
 begin
  with  ActiveGLW  do
   if (TopoSpm.FileHeadRcd.HPathMode=0) or (TopoSpm.FileHeadRcd.HPathMode=2)
    then faction.filter:=@DelStepsX
    else faction.filter:=@DelStepsY;
      faction.name:='Step Delete';
      filterlist.Add(faction);
      FilterlistBox.items.add(faction.name);
      FilterlistBox.ItemIndex:= FilterlistBox.items.count-1;
 end;
end;

procedure TScriptPlay.LevelDelete1Click(Sender: TObject);
 var
playaction:pScriptAction;
begin
 new(playaction);
 StartBtn.Enabled:=true;
 playaction.filter:=@DelFiltLevel;
 playaction.name:='Level Delete';
 filterlist.Add(playaction);
 FilterlistBox.items.add(playaction.name);
 FilterlistBox.ItemIndex:= FilterlistBox.items.count-1;
end;

procedure TScriptPlay.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
var index:integer;
begin
     case Key of
VK_DELETE:
 begin
  if  filterlist.count<>0 then
  begin
  index:=FilterlistBox.ItemIndex;
  FilterlistBox.items.delete(Index);
  filterlist.delete(Index);
  if filterlist.count=0 then
    begin if assigned(ImageTools) then ImageTools.BitBTnRunScript.enabled:=false;end
    else  FilterlistBox.ItemIndex:=0;
  end;
 end;
    end;//case
end;

procedure TScriptPlay.mSaveAsBMPClick(Sender: TObject);
var
playaction:pScriptAction;
begin
  new(playaction);
  StartBtn.Enabled:=true;
 playaction.filter:=@SaveAsBMP;
 playaction.name:='Save as bmp file';
 filterlist.Add(playaction);
 FilterlistBox.items.add(playaction.name);
 FilterlistBox.ItemIndex:= FilterlistBox.items.count-1;
end;

procedure TScriptPlay.mSaveAsJPGClick(Sender: TObject);
var
playaction:pScriptAction;
begin
 new(playaction);
 StartBtn.Enabled:=true;
 playaction.filter:=@SaveAsJPG;
 playaction.name:='Save as jpg file';
 filterlist.Add(playaction);
 FilterlistBox.items.add(playaction.name);
 FilterlistBox.ItemIndex:= FilterlistBox.items.count-1;
end;


procedure TScriptPlay.FourierFiltration1Click(Sender: TObject);
  var
playaction:pScriptAction;
begin
 new(playaction);
 StartBtn.Enabled:=true;
 playaction.filter:=@ExecuteFourierFiltrat;
 playaction.name:='Fourier Filtration';
 filterlist.Add(playaction);
 FilterlistBox.items.add(playaction.name);
 FilterlistBox.ItemIndex:= FilterlistBox.items.count-1;
end;

procedure TScriptPlay.BitBtnHClick(Sender: TObject);
begin
  HlpContext:=IDH_Instr_Panel;
  Application.HelpContext(HlpContext);
end;

end.
