unit frDeviceReady;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFormDeviceReady = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDeviceReady: TFormDeviceReady;

implementation

{$R *.dfm}

procedure TFormDeviceReady.FormCreate(Sender: TObject);
begin
  Timer1.enabled:=true;
end;

procedure TFormDeviceReady.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=false;
  close;
end;

end.
