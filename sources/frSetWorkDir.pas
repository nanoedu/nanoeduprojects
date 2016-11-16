unit frSetWorkDir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,
//ntspb
  GlobalVar;

type
  TSetNewWorkDir = class(TForm)
    Panel1: TPanel;
    BitBtnOk: TBitBtn;
    BitBtncancel: TBitBtn;
    LblEditDir: TLabeledEdit;
    procedure BitBtnOkClick(Sender: TObject);
    procedure BitBtncancelClick(Sender: TObject);
  private
    { Private declarations }
    currentdir:string;
  public
    { Public declarations }
    constructor Create(owner:TComponent; str:string);
  end;

var
  SetNewWorkDir: TSetNewWorkDir;

implementation

{$R *.dfm}

 constructor TSetNewWorkDir.Create(owner:TComponent; str:string);
 begin
  inherited Create(owner);
   currentdir:=str;
 end;
procedure TSetNewWorkDir.BitBtncancelClick(Sender: TObject);
begin
 ModalResult:=mrCancel;
end;

procedure TSetNewWorkDir.BitBtnOkClick(Sender: TObject);
begin
 WorkDirectory:=Currentdir+'\'+LblEditDir.Text;
  if not DirectoryExists(WorkDirectory) then CreateDir(WorkDirectory);
 ModalResult:=mrOK;
end;

end.
