unit ScanWorkThread;

interface

uses
  Classes, Windows, Messages,dialogs,sysutils;

type
  TScanWorkThread = class(TThread)
  private

  protected
       procedure Execute; override; // Main thread execution
  published
       constructor Create();
//     destructor Destroy; override;
  end;

var   ScWorkThread:TScanWorkThread;

implementation

uses   SioCSPM,frNoFormUnitLoc,CSpmVar;

constructor TScanWorkThread.Create;
begin
  inherited Create(true);      // Create thread suspended
  Priority := TThreadPriority(tpNormal{Higher}); // Set Priority Level
//  FreeOnTerminate := True; // Thread Free Itself when terminated
  FreeOnTerminate := False; // Thread Free Itself when terminated
  Suspended := false;         // Continue the thread
end;

//destructor TScanWorkThread.Destroy;
// begin
//  ThreadFlg:=Scannig;
  // PostMessage(ScanWnd.Handle,wm_ThreadDoneMsg,ThreadFlg{ThreadID},0);
   {
     This posts a message to the main form, tells us when and which thread
     is done executing.
//   }
//   inherited destroy;
// end;

procedure TScanWorkThread.Execute;
var i:Dword;
begin
 i:=ScanWork();
  if i<>0 then
  begin
   flgControlerTurnON:=false;
   NoFormUnitLoc.siLang1.MessageDlg(strub3{* Error during ScanWork() execution *},mterror ,[mbYes],0);
//  raise   Exception.Create('File Write ERROR ');
//  PostMessage (Scanwnd.handle, WM_UserMsgScanError, 1, 0);
  end;
 end;
end.
