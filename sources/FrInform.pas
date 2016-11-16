unit FrInform;

interface

uses
  Forms, Classes, StdCtrls, Controls, ExtCtrls,mMain, siComp, siLngLnk;

type
  TInform = class(TForm)
    Labelinf: TLabel;
    siLangLinked1: TsiLangLinked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 Inform: TInform;

implementation

{$R *.DFM}
uses globalvar;

procedure TInform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  Inform:=nil;
end;

procedure TInform.FormCreate(Sender: TObject);
begin
 siLangLinked1.ActiveLanguage:=Lang;
end;

end.
