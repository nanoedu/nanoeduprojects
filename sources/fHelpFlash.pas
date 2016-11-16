unit fHelpFlash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, HHOPENLib_TLB;

type
  TfHelpHtml = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fHelpHtml: TfHelpHtml;

implementation

{$R *.DFM}

procedure TfHelpHtml.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
end;

end.
