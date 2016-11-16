unit frChangeDir;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,StrUtils, FileCtrl, Buttons,mMain, siComp, siLngLnk,
  ComCtrls, NTShellCtrls, ExtCtrls;

type
  TChangeDir = class(TForm)
    siLangLinked1: TsiLangLinked;
    NTShellChangeNotifier1: TNTShellChangeNotifier;
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    Edit: TEdit;
    BitBtnCancel: TBitBtn;
    BitBtnOK: TBitBtn;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    EdWorkDir: TEdit;
    BitBtnNew: TBitBtn;
    BitBtnDef: TBitBtn;
    Panel4: TPanel;
    NTShellComboBox: TNTShellComboBox;
    NTShellTreeView: TNTShellTreeView;
    BitBtn2: TBitBtn;
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure NTShellTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure NTShellTreeViewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtnDefClick(Sender: TObject);
    procedure BitBtnNewClick(Sender: TObject);
    procedure NTShellTreeViewRenameFile(Sender: TObject; Node: TTreeNode);
    procedure NTShellTreeViewDeleteFile(Sender: TObject; Node: TTreeNode);
    procedure BitBtn2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChangeDir: TChangeDir;

implementation

uses GlobalVar,GlobalFunction,nanoeduhelp,IniFiles,frSetWorkDir;

{$R *.DFM}
const
	strchd0: string = ''; (* The Gallery directory can not be used as work directory! Choose another directory *)
	strchd1: string = ''; (* Cannot create directory. Try Again *)
	strchd2: string = ''; (* New directory created *)
	strchd3: string = ''; (* Series Files with name  *)
	strchd4: string = ''; (*  exist! Rewrite? *)
	strchd5: string = ''; (* Change folder!  *)



procedure TChangeDir.BitBtnOKClick(Sender: TObject);
var
    i,ps:integer;
    ires,iresD,res:integer;
    fl:File;
    FF:File;
    iniCSPM:TIniFile;
    sFile,CurrDir:string;
    sSr,sSrD:TsearchRec;
    Drv:Char;
    DirPart,FilePart:string;
    currentworkdir:string;
begin
  flgReWrite:=true;
  currentworkdir:=workdirectory;
  WorkNameFileMaskCur:=Edit.text;
   if   AnsiContainsStr(edWorkDir.text,ScanGalleryDir) then
   begin
     siLangLinked1.MessageDlg(strchd0{'Gallery directory can not be used as work directory'}, mtWarning, [mbOk], 0);
     ModalResult:=mrNone;
     exit
   end;
  CurrDir:=GetCurrentDir;
  if not DirectoryExists(edWorkDir.text)then
  begin
   {$I-}
   { Get directory name from TEdit control }
    CreateDir(edWorkDir.text);  //Mkdir
   if IOResult <> 0 then
   begin
      siLangLinked1.MessageDlg(strchd1{'Cannot create directory. Try Again'}, mtWarning, [mbOk], 0);
      exit
   end
   else  siLangLinked1.MessageDlg(strchd2{'New directory created'}, mtInformation, [mbOk], 0);
   {$I+}
  end;
(*    ProcessPath (edWorkDir.text,Drv,DirPart,FilePart);
    if  DirPart='\' then WorkDirectory:=Drv+':\'
                    else WorkDirectory:=edWorkDir.text;
 *)
     WorkDirectory:=edWorkDir.text;
     WorkDirectory:=DeleteLastSlash(WorkDirectory);
     FMDTServiceForm.StorePath:=workdirectory+'\';
    self.NTShellTreeView.Path:=edWorkDir.text;//WorkDirectory;
   for i:=1 to 20 do
    if FileExists(WorkDirectory+'\' +WorkNamefileMaskCur+inttostr(i)+WorkExtFile)and (WorkNamefileMaskCur<>WorkNamefileMaskDef) then
       begin
          if siLangLinked1.MessageDlg(strchd3{'Series Files with name '}+WorkNamefileMaskCur+' +i '+WorkExtFile+strchd4{' exist! Rewrite?'},mtwarning,[mbYes,mbNo],0)=mrYes
           then
           begin
              flgReWrite:=true;
          (*   iresD:=FindFirst(WorkDirectory+'\'+WorkFileMask,faAnyFile,sSRD);
              while iresD = 0 do
               begin
                 if  (AnsiContainsText(ExtractFileName(sSRD.Name),WorkNamefileMaskCur)) then
                  begin
                    AssignFile(FF,WorkDirectory+'\'+sSRD.Name);
                    Erase(FF);
                  end;
                   iresD:=FindNext(sSRD);
               end;
                FindClose(sSRD);
            *)
           end
           else
           begin
            flgReWrite:=false ;
            siLangLinked1.MessageDlg(strchd5{'Change folder! '},mtwarning,[mbOK],0);
           end;
           break;
       end;
       ForceCurrentDirectory :=True;
       sFile:=ConfigUsersIniFilePath + ConfigUsersIniFile;
 if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    Rewrite(FL);
    CloseFile(FL);
  end;
//  SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
try
  iniCSPM.WriteString('Files','Work Directory',WorkDirectory);
finally
   INiCSPM.Free;
end;
    SaveAsDirectory:=workdirectory;
    if assigned(WorkView) and (workdirectory<>currentworkdir) then     WorkView.Redraw;
    ModalResult:=mrOK;
end;

procedure TChangeDir.BitBtnDefClick(Sender: TObject);
begin
     NTShellComboBox.Path:=UserNanoeduWorkDocumentsPath;
     NTShellTreeView.Path:= UserNanoeduWorkDocumentsPath;
     Application.processmessages;
     edWorkDir.text:=NTShellTreeView.Path;
end;

procedure TChangeDir.BitBtnNewClick(Sender: TObject);
begin
  SetNewWorkDir:=TSetNewWorkDir.Create(self,edWorkDir.text);
  SetNewWorkDir.ShowModal;
  if SetNewWorkDir.ModalResult=mrOK then
  begin
//   NTShellTreeView.Refresh();
   edWorkDir.text:=WorkDirectory;
//   NTShellComboBox.Path:=WorkDirectory;
 //  NTShellTreeView.Path:= WorkDirectory;
//   Application.processmessages;
//     edWorkDir.text:=NTShellTreeView.Path;
  end;
end;

procedure TChangeDir.BitBtn2Click(Sender: TObject);
begin
     WorkDirectory:=WorkLastDirectory;
     NTShellComboBox.Path:=WorkDirectory;
     NTShellTreeView.Path:= WorkDirectory;
     Application.processmessages;
     edWorkDir.text:=NTShellTreeView.Path;
end;

procedure TChangeDir.BitBtnCancelClick(Sender: TObject);
begin
    flgReWrite:=True;
    ModalResult:=mrCancel;
end;

procedure TChangeDir.FormCreate(Sender: TObject);
begin
      siLangLinked1.ActiveLanguage:=Lang;
      UpdateStrings;
      edit.text:= WorkNameFileMaskCur;
end;

procedure TChangeDir.FormShow(Sender: TObject);
begin
     NTShellComboBox.Path:=WorkDirectory;
     NTShellTreeView.Path:= WorkDirectory;
     Application.processmessages;
     edWorkDir.text:=NTShellTreeView.Path;// .Folders[i].PathName;//WorkDirectory;
end;

procedure TChangeDir.NTShellTreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  edWorkDir.text:=NTShellTreeView.Path;
end;

procedure TChangeDir.NTShellTreeViewClick(Sender: TObject);
begin
  edWorkDir.text:=NTShellTreeView.Path;
end;

procedure TChangeDir.NTShellTreeViewDeleteFile(Sender: TObject;  Node: TTreeNode);
begin
// inherited;
 NTShellTreeView.reset;
end;

procedure TChangeDir.NTShellTreeViewRenameFile(Sender: TObject;   Node: TTreeNode);
begin
inherited;
 NTShellTreeView.reset;
end;

procedure TChangeDir.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TChangeDir.UpdateStrings;
begin
  strchd0 := siLangLinked1.GetTextOrDefault('strstrchd0');
  strchd5 := siLangLinked1.GetTextOrDefault('strstrchd5');
  strchd4 := siLangLinked1.GetTextOrDefault('strstrchd4');
  strchd3 := siLangLinked1.GetTextOrDefault('strstrchd3');
  strchd2 := siLangLinked1.GetTextOrDefault('strstrchd2');
  strchd1 := siLangLinked1.GetTextOrDefault('strstrchd1');
end;

procedure TChangeDir.FormClose(Sender: TObject; var Action: TCloseAction);
begin
       Main.ToolBtnDir.visible:=true;
       Main.ToolBtnDir.Enabled:=True;
       Application.ProcessMessages;
       Action:=CaFree;
end;

procedure TChangeDir.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
 CanClose:=true;
 if not flgReWrite then  CanClose:=false;
end;

procedure TChangeDir.BitBtn1Click(Sender: TObject);
begin
    Application.Helpcontext(IDH_Change_work_dir);
end;

end.



