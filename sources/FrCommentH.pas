unit FrCommentH;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids,
  ScanDrawThread;

type
  TfrComment = class(TForm)
    OKBtn: TButton;
    Label1: TLabel;
    edMaterial: TEdit;
    CommentMemo: TMemo;
    Label2: TLabel;
 //   procedure OKBtnClick(Sender: TObject);
//    procedure CommentMemoKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frComment: TfrComment;

implementation

{$R *.DFM}


{procedure TfrComment.OKBtnClick(Sender: TObject);
begin
  with CommentMemo.Lines do
   begin
   with ScanData.FileHeadRcd do
      begin
       Comm1:=Strings[0];
       Comm2:=Strings[1];
       Comm3:=Strings[2];
       Comm4:=Strings[3];
       Comm5:=Strings[4];
      end;

    FrComment.Close;
    end;
end;
}

{procedure TfrComment.CommentMemoKeyPress(Sender: TObject; var Key: Char);
len:integer;
begin
len:=sizeof(ScanData.FileHeadRcd.Comm1);
with  CommentMemo do
if CaretPos.X>=len then
  begin
   Lines.Strings[CaretPos.Y]
  end;
end;
 }
end.
