unit frAboutService;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TAbout = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    fromservice: boolean
  end;

var
  About: TAbout;
   fromservice: boolean;
implementation

{$R *.dfm}

end.
