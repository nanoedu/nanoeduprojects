unit frLogo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg;

type
  TLogo = class(TForm)
    ImageLogo: TImage;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Logo: TLogo;

implementation

{$R *.dfm}

procedure TLogo.Timer1Timer(Sender: TObject);
begin
  Close;
end;

procedure TLogo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Close;
end;

procedure TLogo.FormCreate(Sender: TObject);
var  ExePath:string;
begin
   ExePath:=ExtractFilePath(Application.ExeName);
 if FileExists(ExePath+'Data\Logo.bmp') then
   begin
    timer1.Interval:=2000;
    ImageLogo.Picture.LoadFromFile(ExePath+'Data\Logo.bmp');
   end
   else timer1.Interval:=1;
end;

procedure TLogo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
end;

end.
