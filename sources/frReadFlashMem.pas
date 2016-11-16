unit frReadFlashMem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFlashMem = class(TForm)
    OpenDialog1: TOpenDialog;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FlashMem: TFlashMem;

implementation

{$R *.dfm}

end.
