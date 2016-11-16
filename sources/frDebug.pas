unit frDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, siComp, siLngLnk;

type
  TFormLog = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    MemoLog: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    siLangLinked1: TsiLangLinked;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    count:integer;
  public
    { Public declarations }
  end;

var
  FormLog: TFormLog;

implementation

{$R *.dfm}
  uses globalvar,mMain;

procedure TFormLog.BitBtn1Click(Sender: TObject);
 var
    Year, Month, Day, Hour, Minut, Sec, MSec: Word;
    Present: TDateTime;
    presentdate:string;
    filename:string;
begin
         inc(count);
    if not DirectoryExists(workdirectory+'\debug') then CreateDir(workdirectory+'\debug');
    FileName:=workdirectory+'\debug\'+inttostr(count) +'.txt';
    Memolog.Lines.SaveToFile(FileName);
 end;

procedure TFormLog.BitBtn2Click(Sender: TObject);
 var
    filename:string;
    fdebug:TFormLog;
begin
  FileName:=workdirectory+'\debug\'+inttostr(count) +'.txt';
  if FileExists(FileName) then
  begin
   fdebug:=TFormLog.Create(self);
   fdebug.Show;
   fdebug.Memolog.Lines.LoadfromFile(FileName);
   fdebug.caption:='debug '+inttostr(count) +'.txt';
  end;
end;

procedure TFormLog.FormCreate(Sender: TObject);
 var
    Year, Month, Day, Hour, Minut, Sec, MSec: Word;
    Present: TDateTime;
    presentdate:string;
    presenttime:string;
 begin
 siLangLinked1.ActiveLanguage:=Lang;
 count:=0;
 top:=0;
 left:=screen.width-width;
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minut, Sec, MSec);
  presenttime:='time='+intTostr(Hour)+'.'+inttostr(Minut);
  presentdate:='date='+intTostr(day)+'.'+inttostr(month)+'.'+inttostr(year);
  memolog.Lines.add(presentdate);
  memolog.Lines.add(presenttime);
end;

end.
