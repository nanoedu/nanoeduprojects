unit frUnitInitEtap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, ComCtrls,GlobalVar, siComp, siLngLnk;
const
 idcom=0;
 idconnect=1;
 idloadscheme=2;
 idruntopo=3;
 idgetadapterid=4;
 idreadparams=5;
 idsetparams=6;
 idchoosedir=7;
 idready=8;
 iderrstopscheme=0;
 iderrunloadscheme=1;
 iderrloadscheme=2;
 iderrruntopo=3;
 iderrgetadapterid=4;

type
  TformInitUnitEtape = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Memolog: TMemo;
    siLangLinked1: TsiLangLinked;
    PageControl1: TPageControl;
    TabSheetStatus: TTabSheet;
    TabSheetErr: TTabSheet;
    GroupBox1: TGroupBox;
    CheckListBox: TCheckListBox;
    ProgressBar: TProgressBar;
    GroupBox2: TGroupBox;
    CheckListBoxErr: TCheckListBox;
    ProgressBar1: TProgressBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }

  public
    { Public declarations }
        flgactive:boolean;
  end;

var
  formInitUnitEtape: TformInitUnitEtape;

implementation

{$R *.dfm}

uses mMain;

procedure TformInitUnitEtape.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  formInitUnitEtape:=nil;
end;

procedure TformInitUnitEtape.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  if flgactive  then canclose:=false
                else canclose:=true;
end;

procedure TformInitUnitEtape.FormCreate(Sender: TObject);
begin
  siLangLinked1.ActiveLanguage:=Lang;
end;

end.
