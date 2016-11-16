unit FLabWorkId;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, globalvar;

type
  TFormLabWorkId = class(TForm)
    Edit1: TEdit;
    OKBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    Label1: TLabel;
    procedure OKBitBtnClick(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLabWorkId: TFormLabWorkId;

implementation

{$R *.dfm}

procedure TFormLabWorkId.OKBitBtnClick(Sender: TObject);
begin
LabWorkIdentificator:= Edit1.Text;
Close;
end;

procedure TFormLabWorkId.CancelBitBtnClick(Sender: TObject);
begin
LabWorkIdentificator:= 'Report_';
Close;
end;

end.
