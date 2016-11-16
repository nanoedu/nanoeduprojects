unit frNamePal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TNamePal = class(TForm)
    Panel1: TPanel;
    EditPal: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NamePal: TNamePal;

implementation

{$R *.dfm}
uses  frSetPalette;
procedure TNamePal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
     NamePal:=nil;
end;

procedure TNamePal.BitBtn1Click(Sender: TObject);
begin
     ModalResult := mrOK;
     PaletteForm.ComboBoxPal.text:=editpal.text;
end;

procedure TNamePal.BitBtn2Click(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TNamePal.FormCreate(Sender: TObject);
begin
     height:=130;
     width:=360;
 end;

end.
