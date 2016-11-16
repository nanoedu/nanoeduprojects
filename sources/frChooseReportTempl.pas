unit frChooseReportTempl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl,  Buttons, siComp, siLngLnk;

type
  TFormLabDlg = class(TForm)
    FileListBox: TFileListBox;
    CancelBitBtn: TBitBtn;
    OKBitBtn: TBitBtn;
    EditFileName: TEdit;
    Label1: TLabel;
    DriveComboBox: TDriveComboBox;
    DirListBox: TDirectoryListBox;
    BitBtnDef: TBitBtn;
    siLangLinked1: TsiLangLinked;
    Label2: TLabel;
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure OKBitBtnClick(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure FileListBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnDefClick(Sender: TObject);
    procedure DirListBoxChange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLabDlg: TFormLabDlg;

implementation
uses GlobalVar,mMain;
{$R *.dfm}
const
	str1: string = ''; (* Directory do not exists *)
	str2: string = ''; (* Choose template file. *)
procedure TFormLabDlg.OKBitBtnClick(Sender: TObject);
begin
  if EditFileName.Text='' then
  begin
    siLangLinked1.MessageDlg(str2{'Choose template file.'},mtwarning,[mbOK],0);
    modalresult:=mrNone;
    exit
  end;
  ReportTemplPath:= DirListBox.Directory+'\';//ExtractFilePath(FileListBox.FileName);
  ReportTemplFile:=ExtractFileName(EditFileName.Text);
  modalresult:=mrOK;
end;

procedure TFormLabDlg.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TFormLabDlg.UpdateStrings;
begin
  str1 := siLangLinked1.GetTextOrDefault('strstr1');
  str2 := siLangLinked1.GetTextOrDefault('strstr2');
end;

procedure TFormLabDlg.CancelBitBtnClick(Sender: TObject);
begin
 modalresult:=mrCancel;
end;

procedure TFormLabDlg.FileListBoxChange(Sender: TObject);
begin
  EditFileName.Text:=ExtractFileName(FileListBox.FileName);
end;

procedure TFormLabDlg.FormCreate(Sender: TObject);
begin
  UpdateStrings;
siLangLinked1.ActiveLanguage:=Lang;
   if  DirectoryExists( ReportTemplPath) then   DirListBox.Directory:=ReportTemplPath
    else begin siLangLinked1.MessageDlg(str1{'Directory do not exists'},mtwarning,[mbOK],0); close; exit end;
 with FileListBox do
 begin
  MultiSelect:=False;
  Mask:='*.tmpl';
 end;
end;

procedure TFormLabDlg.BitBtnDefClick(Sender: TObject);
begin
   if sLanguage='RUS' then DirListBox.Directory:=CommonNanoeduDocumentsPath+ReportTemplRDefPath
                      else DirListBox.Directory:=CommonNanoeduDocumentsPath+ReportTemplEDefPath;
end;

procedure TFormLabDlg.DirListBoxChange(Sender: TObject);
begin
   ReportTemplPath:=(DirListBox.Directory);
end;

end.


