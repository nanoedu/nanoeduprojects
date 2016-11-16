unit frChooseLabWork;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls,Inifiles, siComp, siLngLnk;

type
  TChooselabwork = class(TForm)
    Panel1: TPanel;
    ListBoxLab: TListBox;
    LabelNAME: TLabel;
    Label2: TLabel;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    siLangLinked1: TsiLangLinked;
    procedure ListBoxLabClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnOKClick(Sender: TObject);
  private
    { Private declarations }
    nActive:integer;
    ActiveFileName:string;
    labinifilename:string;
    filelist:TStringlist;
    sectionlist:Tstringlist;
    function ReadConfigLabFile:boolean;
    function WriteConfigLabFile:boolean;
  public
    { Public declarations }
  end;

var
  Chooselabwork: TChooselabwork;

implementation

{$R *.dfm}
 uses globalvar,cspmvar,mMain;

procedure TChooselabwork.ListBoxLabClick(Sender: TObject);
var i:integer;
begin
     nActive:=Listboxlab.itemindex;
  //   ActiveFileName:=FileList.Strings[Listboxlab.itemindex];
     LabelName.Caption:=Listboxlab.items[nActive];
end;

function TChooselabwork.ReadConfigLabFile:boolean;
var iniCSPM:TiniFile;
    i:integer;
begin
// Reading Params Value from IniFile
 if (not FileExists(labinifilename)) then
  begin
   ShowMessage('No Config Default Ini File '+labinifilename+' Program will be terminated!!');
   exit;//Close;
  end;
 iniCSPM:=TIniFile.Create(labinifilename);
 try
   with iniCSPM do
   begin
       nActive:=ReadInteger('Active lab','lab number',1);
      if SectionExists('Labs')then  ReadSection('Labs',sectionlist);
      for i:=0 to sectionlist.count-1 do
         ListBoxLab.Items[i]:=readstring('Labs',sectionlist.strings[i],'');
      if ListBoxLab.Count=0 then exit;
       ListBoxLab.ItemIndex:=nActive;
      if SectionExists('Files')then ReadSection('Files',FileList);
   end;
 finally
   iniCSPM.Free;
 end;
end;

function TChooselabwork.WriteConfigLabFile:boolean;
begin

end;
procedure TChooselabwork.FormCreate(Sender: TObject);
var labpath:string;
begin
   case stmflg  of
true: labpath:='stm\';

false:labpath:='sfm\';
   end;
  labinifilename:=ConfigLabListFilePath+labpath+ConfigLabListFile;
  filelist:=TStringlist.Create;
  sectionlist:=Tstringlist.create;
  ReadConfigLabFile;
   LabelName.Caption:=Listboxlab.items[nActive];
end;

procedure TChooselabwork.BitBtnSaveClick(Sender: TObject);
begin
  //  ConfigLabListFilePath;
end;

procedure TChooselabwork.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      FileList.Clear;
      FileList.Free;
      ListBoxLab.items.Clear;
      sectionlist.Clear;
      sectionlist.Free;
      action:=caFree;
      ChooseLabWork:=nil;
end;

procedure TChooselabwork.BitBtnOKClick(Sender: TObject);
begin
   modalresult:=mrOk;
end;

end.
