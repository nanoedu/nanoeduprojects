unit frStartWork;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,mMain, StdCtrls, ExtCtrls, siComp, siLngLnk;

type
  TFormStartWork = class(TForm)
    Panel1: TPanel;
    siLangLinked1: TsiLangLinked;
    Memo: TMemo;
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
     flgDisappear,flgBlink:boolean;
     fTransperance:integer;
  public
    { Public declarations }
  end;

var
  FormStartWork: TFormStartWork;

implementation

{$R *.dfm}
uses GlobalVar;

procedure TFormStartWork.FormCreate(Sender: TObject);
begin
  SiLangLinked1.ActiveLanguage:=Lang;
  fTransperance:=0;
  flgblink:=true;
  flgDisappear:=true;
end;

procedure TFormStartWork.TimerTimer(Sender: TObject);
begin
   Timer.Enabled:=false;
if  flgDisappear then
begin
   inc(fTransperance,3);
   self.alphablendvalue:=255-fTransperance;
end;
//  if flgBlink then  Memo.font.Color:=clblack
//              else  Memo.font.Color:=clred;
   flgBlink:=not flgBlink;;
  if alphablendvalue<=4 then begin self.visible:=false; flgDisappear:=false;close;  exit; end;
    Timer.Enabled:=true;
end;

end.
