unit DlgComment;

interface
                                      
uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, siComp, siLngLnk;

type
  TDlgComnt = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    edMaterial: TEdit;
    CommentMemo: TMemo;
    Label2: TLabel;
    Timer1: TTimer;
    siLangLinked1: TsiLangLinked;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  DlgComnt: TDlgComnt;

implementation

{$R *.DFM}
uses Globalvar,mMain;

procedure TDlgComnt.FormCreate(Sender: TObject);
var i:integer;
begin
siLangLinked1.ActiveLanguage:=Lang;
    Timer1.Interval:=200;
      for i:=0 to 7 do
      begin
       strcomment[i]:='';
       CommentMemo.Lines.Strings[i]:=strcomment[i];
      end;
       strcomment[8]:='';
end;

procedure TDlgComnt.Timer1Timer(Sender: TObject);
begin
 FlashWindow(Self.Handle,True);
end;

procedure TDlgComnt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Timer1.Interval:=0;
end;

procedure TDlgComnt.OKBtnClick(Sender: TObject);
var i:integer;
begin
     strcomment[0]:=edMaterial.text;
     for i:=1 to 8 do  strcomment[i]:=CommentMemo.Lines.Strings[i-1];
end;

procedure TDlgComnt.CancelBtnClick(Sender: TObject);
var i:integer;
begin
       for i:=0 to 8 do  strcomment[i]:=' ';
end;

end.
