unit frProgressMoveto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  ComCtrls,
  //ntspb
    GlobalVar, GlobalType,CSpmVar,mMain,
  {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
   ExtCtrls, siComp, siLngLnk;

type
  TProgressMoveTo = class(TForm)
    ProgressBar: TProgressBar;
    siLangLinked1: TsiLangLinked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
   value:apitype;
   dt:word;
   PositionCur:word;
   v:single;
   Present: TDateTime;
   timestart,timecur,timeprev:word;
    Hour, Minut, Sec, MSec: Word;
    procedure ThreadDone(var AMessage: TMessage);  message WM_ThreadDoneMsg; // keep track of when and which thread is done executing

  public
    { Public declarations }
     timemove:single;
    procedure    StartMoveDraw(x0,y0,xend,yend:integer);
//    constructor  Create;
  end;

var
  ProgressMoveTo: TProgressMoveTo;

implementation

{$R *.dfm}
uses SioCSPM,UNanoEduBaseClasses,ScanWorkThread,ProgressMoveToDrawThread;


procedure TProgressMoveTo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
   ProgressMoveTo:=Nil;
end;


procedure TProgressMoveTo.FormCreate(Sender: TObject);
begin
 siLangLinked1.ActiveLanguage:=Lang;
 PostMessage(ProgressBar.Handle, $0409, 0, clGreen);
end;

procedure    TProgressMoveTo.StartMoveDraw(x0,y0,xend,yend:integer);
 var
   PositionCur:word;
   z:smallint;
   zs,zx:single;
begin
           timemove:=0;
           v:=Scanparams.ScanRate*TransformUnit.XPnm_d;
       if V>0 then
           timemove:=(abs(x0-xend)+abs(y0-yend))/v ;
       if timemove=0 then timemove:=1;
           Present:= Now;
           DecodeTime(Present, Hour, Minut, Sec, MSec);
  //         timestart:=Hour*3600+Minut*60+sec;  170327 edited
  //         timeprev:=timestart;        //        170327 edited
 //          caption:=siLangLinked1.GetTextOrDefault('IDS_2' (* 'Please, wait while scanner moves to the start point' *) );
           ProgressBar.Max:=abs(x0-XEnd)+abs(y0-yend);
       if ProgressBar.Max=0 then ProgressBar.Max:=1;
           ProgressBar.Min:=0;
           ProgressBar.Position:=0;
           PositionCur:=0;
//           ScanParams.TimeWait:=round(timemove); //sec
   {$IFDEF DEBUG}
        Formlog.memolog.Lines.add('init progress thread');
   {$ENDIF}
   if not assigned(ThreadMoveToProgress) or (not ThreadMoveToProgressActive) then // make sure its not already running
       begin
        ThreadMoveToProgress:=  TThreadProgressMoveTo.Create;
     {$IFDEF DEBUG}
        Formlog.memolog.Lines.add('Start progress thread');
   {$ENDIF}
        ThreadMoveToProgressActive := True;
       end ;

 end;
  procedure TProgressMoveTo.ThreadDone(var AMessage: TMessage);  // keep track of when and which thread is done executing
   begin
  if  (mDrawing=AMessage.WParam) then
  begin
    if assigned(ThreadMoveToProgress) then
    begin
     ThreadMoveToProgress:=nil;
     ThreadMoveToProgressActive:=false;
     while assigned( NanoEdu.Method) do    Application.processmessages;     //23/11/12
//    WaitforJavaNotActive; // 220113

  {$IFDEF DEBUG}
       if not flgJavaRunning then    Formlog.memolog.Lines.add('Stop Java');
  {$ENDIF}
     Close;
    end;
  end;
   if mScanning=AMessage.WParam then
    begin
     if  flgControlerTurnON   then
      begin
       NanoEdu.Method.FreeBuffers;
      end;
      if Assigned(scWorkThread) then FreeAndNil(scWorkThread);
      FreeAndNil(NanoEdu.Method);
    end;
 end;
end.
