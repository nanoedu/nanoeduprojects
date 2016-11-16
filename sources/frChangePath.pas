unit frChangePath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NTShellCtrls, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TChangePath = class(TForm)
    Panel1: TPanel;
    LblPATH: TLabel;
    Label1: TLabel;
    NTShellTreeView: TNTShellTreeView;
    NTShellComboBox: TNTShellComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure NTShellTreeViewClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChangePath: TChangePath;
  ChangePathResult:string;
implementation

{$R *.dfm}
uses Globalvar;

procedure TChangePath.BitBtn1Click(Sender: TObject);
begin
  ChangePathResult:=lblPath.Caption;
// ScannerIniBasePath:=lblPath.Caption;
 ModalREsult:=mrOK;
end;

procedure TChangePath.BitBtn2Click(Sender: TObject);
begin
ModalREsult:=mrCancel;
end;

procedure TChangePath.NTShellTreeViewClick(Sender: TObject);
begin
  lblPATH.Caption:=NTShellTreeView.Path+'\';
end;

end.
