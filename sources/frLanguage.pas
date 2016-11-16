unit frLanguage;

interface

uses
  Windows,  Variants, Classes, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrLang = class(TForm)
    Panel1: TPanel;
    RGroupLang: TRadioGroup;
    BitBtnOk: TBitBtn;
    BitBtnCancel: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnOkClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frLang: TfrLang;

implementation

uses  GlobalVar;
{$R *.dfm}

procedure TfrLang.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  FrLang:=nil;
end;

procedure TfrLang.FormCreate(Sender: TObject);
begin
     if  sLanguage='RUS' then  RGroupLang.ItemIndex:=0
                         else  RGroupLang.ItemIndex:=1;
end;

procedure TfrLang.BitBtnOkClick(Sender: TObject);
begin
            case RGroupLang.ItemIndex of
   0: begin
        sLanguage:='RUS';
       end;
   1: begin
        sLanguage:='ENG';
       end;
        end;
   modalresult:=mrOK;
end;

procedure TfrLang.BitBtnCancelClick(Sender: TObject);
begin
   modalresult:=mrcancel;
end;

end.
