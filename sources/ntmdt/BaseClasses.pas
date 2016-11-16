unit BaseClasses;

interface

uses
  Windows, Messages, Classes, SysUtils, SyncObjs, Math,
  BaseTypes{$IFNDEF FPC}, MMSystem{$ENDIF};

const
  NIL_ID = -1;

type
//----- InterObject notify model (Server -> Client)
//----- (direct call)
//-----  &
//------ InterThread notify model (Thread (Server) -> Main thread (Client))
//------ (PostMessage to Main thread window handle)
  TNTNotifyEvent = procedure(Sender: TObject; AEventID: Integer; AData: Pointer) of object;
  TNTNotifyClient = class;
  TNotifyClientRecord = record
    Client: TNTNotifyClient;
    ThreadID: DWORD;
  end;
  PNotifyClientRecord = ^TNotifyClientRecord;


// TNTNotifyServer object must freed with FreeAndNil(Notifier) method !
//   It's prevents from calls SendNotify after release
  TNTNotifyServer = class
  private
    FCriticalSection: TCriticalSection;
    FClientList: TList;
    FOwner: TObject;
    FDestroying: Boolean;
    function IndexOf(AClient: TNTNotifyClient): PNotifyClientRecord;
    procedure ClearClientList;
  protected
    procedure SendEventToClient(AClientRec: PNotifyClientRecord;
      AEventID: Integer; AData: Pointer); virtual;
  public
    constructor Create(AOwner: TObject); virtual;
    destructor Destroy; override;
    procedure BindClient(AClient: TNTNotifyClient);
    procedure UnbindClient(AClient: TNTNotifyClient);
    procedure SendEvent(AEventID: Integer; AData: Pointer);
  end;

  TNTNotifyClient = class
  private
    FCriticalSection: TCriticalSection;
    FServerList: TList;
    FOnEvent: TNTNotifyEvent;
    FDestroying: Boolean;
{$IFNDEF FPC}	
    FWndHandle: HWND;
{$ENDIF}	
    procedure BindServer(AServer: TNTNotifyServer);   // for server use only
    procedure UnbindServer(AServer: TNTNotifyServer); // for server use only
    procedure WndHandler(var Message: TMessage);
    procedure ClearServerList;
  protected
    procedure DoEvent(ASender: TObject; AEventID: Integer; AData: Pointer); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property OnEvent: TNTNotifyEvent read FOnEvent write FOnEvent;
  end;

//----- InterThread forward call queue model (Main thread -> Usual Thread)
//----- (adding function in thread context)
const
  INFINITY_EXECUTE_COUNT = 0;

type
  TThreadProcedure = procedure(ANotifier: TNTNotifyServer) of object;
  TThreadProcRecord = record
    Proc: TThreadProcedure;
    ExecuteCount: Integer;
    Period: Integer; // ms
   //---- Temporarily ---
    FirstTickCount: DWORD;
    ExecuteIndex: Integer;
  end;
  PThreadProcRecord = ^TThreadProcRecord;
  TThreadListAction = (tlaAdd, tlaRemove, tlaClear);
  TThreadListActionRecord = record
    Action: TThreadListAction;
    ProcRecord: PThreadProcRecord;
  end;
  PThreadListActionRecord = ^TThreadListActionRecord;

  TNTThread = class(TThread)
  private
    FName: string;
    FActionCS: TCriticalSection;
    FActionList: TList;
    FProcList: TList;
    FNotifier: TNTNotifyServer;
    FDestroying: Boolean;
    FSleepTime: Integer;
    procedure DoProcList;
    procedure DoActionList;
    procedure ClearProcList;
    procedure ClearActionList(FullClear: Boolean);
    procedure SetName(const Value: string);
  protected
    procedure Execute; override;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function ExecuteProc(AProc: TThreadProcedure; AExecuteCount, APeriod: Integer): Integer;
    procedure TerminateProc(AThreadProcID: Integer);
    procedure ClearProcs;
    property Notifier: TNTNotifyServer read FNotifier;
    property Name: string read FName write SetName;
    property SleepTime: Integer read FSleepTime write FSleepTime;
  end;

procedure SetThreadName(AName: string; ThreadID: Integer);

{$IFNDEF FPC}
type
  TRTTimer = class(TThread)
  private
    FTimerID: Cardinal;
    FSignalEvent: THandle;
    FTerminateEvent: THandle;
    FInterval: Cardinal;
    FResolution: Cardinal;
    FTimeCaps: TTimeCaps;
    FEnabled: Boolean;
    FOnTimer: TNotifyEvent;
    procedure UpdateTimer;
    procedure SetEnabled(Value: Boolean);
    procedure SetInterval(Value: Cardinal);
    procedure SetResolution(Value: Cardinal);
    procedure SetOnTimer(Value: TNotifyEvent);
  protected
    procedure Timer; dynamic;
    procedure Execute; override;
    procedure DoTerminate; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Terminate;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Interval: Cardinal read FInterval write SetInterval;
    property MinInterval: Cardinal read FTimeCaps.wPeriodMin;
    property MaxInterval: Cardinal read FTimeCaps.wPeriodMax;
    property Resolution: Cardinal read FResolution write SetResolution;
    property OnTimer: TNotifyEvent read FOnTimer write SetOnTimer;
  end;
{$ENDIF}  
//-----------------------------------------------------------------------------
  { TNTPublished is the ancestor for all nested property classes }
type
  TNTPublished = class(TPersistent)
  private
    FOnChange: TNotifyEvent;

  protected
    FNotifyLockCnt: Integer;

    function GetNotifyLocked: Boolean;
    procedure VirtAssign(AValue: TNTPublished); virtual;
    procedure OnNestedChange(Sender: TObject);

  public
    constructor Create;
    procedure Assign(AValue: TPersistent); override;
    procedure Invalidate; virtual;
    procedure LockNotify; virtual;
    procedure UnlockNotify; virtual;

    property NotifyLocked : Boolean       read GetNotifyLocked;
    property OnChange     : TNotifyEvent  read FOnChange write FOnChange;
  end;

//-----------------------------------------------------------------------------
  { TNTRect is Rect published property }

  TNTRect = class(TNTPublished)
  private
    FLeft   : Integer;
    FTop    : Integer;
    FRight  : Integer;
    FBottom : Integer;

  protected
    procedure VirtAssign(AValue: TNTPublished); override;
    procedure SetLeft(AValue: Integer);
    procedure SetTop(AValue: Integer);
    procedure SetRight(AValue: Integer);
    procedure SetBottom(AValue: Integer);

  public
    constructor Create;
    procedure Init(ARect: TRect);
    function GetRect: TRect;

  published
    property Left   : Integer read FLeft   write SetLeft;
    property Top    : Integer read FTop    write SetTop;
    property Right  : Integer read FRight  write SetRight;
    property Bottom : Integer read FBottom write SetBottom;
  end;

//-----------------------------------------------------------------------------

  TNTAlgorithm = class
  protected
    FPresetting        : Integer;
    FProcessing        : Integer;
    FStartPresetBusy   : Boolean;
    FFinishPresetBusy  : Boolean;
    FStartProcessBusy  : Boolean;
    FFinishProcessBusy : Boolean;
    FStopNeeded        : Boolean;
    FDestroying        : Boolean;

    FOnStartPreset     : TNotifyEvent;
    FOnFinishPreset    : TNotifyEvent;
    FOnStartProcess    : TNotifyEvent;
    FOnFinishProcess   : TNotifyEvent;

    procedure InnerPreset;
    procedure InnerExecute;

    procedure DoStartPreset;
    procedure DoFinishPreset;
    procedure DoStartProcess;
    procedure DoFinishProcess;

    procedure VirtStartPreset; virtual;
    procedure VirtFinishPreset; virtual;
    procedure VirtStartProcess; virtual;
    procedure VirtFinishProcess; virtual;

    // Here is algorithm body
    procedure VirtPreset; virtual;
    procedure VirtProcess; virtual;

  public
    constructor Create;
    procedure BeforeDestruction; override;
    destructor Destroy; override;

    procedure Preset;
    procedure Execute;
    procedure Stop;
    function GetPresetting: Boolean;
    function GetProcessing: Boolean;

    property Presetting      : Boolean      read GetPresetting;
    property Processing      : Boolean      read GetProcessing;
    property StopNeeded      : Boolean      read FStopNeeded;

    property OnStartPreset   : TNotifyEvent read FOnStartPreset   write FOnStartPreset;
    property OnFinishPreset  : TNotifyEvent read FOnFinishPreset  write FOnFinishPreset;
    property OnStartProcess  : TNotifyEvent read FOnStartProcess  write FOnStartProcess;
    property OnFinishProcess : TNotifyEvent read FOnFinishProcess write FOnFinishProcess;
  end;

//-----------------------------------------------------------------------------
function IDtoObject(AObjectID: Integer): TObject;
function ObjectToID(AObject: TObject): Integer;
procedure ManualFreeNeeded(const AObject: TObject);
function InterfacedFreeAndNil(var AObject): Boolean;
function InterfacedFree(AObject: TObject): Boolean;
function GetIntf(AObject: IUnknown; const IID: TGUID; out AIntf): Boolean;

procedure FreeAndNil(var Obj);


implementation

//------------------------------------------------------------------------------
//------------------------------ TNTNotifyServer -------------------------------
//------------------------------------------------------------------------------
const
  SM_THREAD_NOTIFY = WM_USER + 8111;
type
  TSendEventRecord = record
    Sender: TObject;
    EventID: Integer;
    Data: Pointer;
  end;
  PSendEventRecord = ^TSendEventRecord;
//------------------------------------------------------------------------------
constructor TNTNotifyServer.Create(AOwner: TObject);
begin
  FCriticalSection := TCriticalSection.Create;
  FClientList := TList.Create;
  FOwner := AOwner;
  FDestroying := False;
end;
//------------------------------------------------------------------------------
destructor TNTNotifyServer.Destroy;
begin
  FDestroying := True;
  FCriticalSection.Enter;
  ClearClientList;
  FClientList.Free;
  FCriticalSection.Free;
  inherited;
//  Self = nil; ????
//TODO: TNTNotifyServer.Destroy -> Self = nil. Протестировать!
end;
//------------------------------------------------------------------------------
function TNTNotifyServer.IndexOf(AClient: TNTNotifyClient): PNotifyClientRecord;
var
  i: Integer;
  pncr: PNotifyClientRecord;
begin
  Result := nil;
  for i := 0 to FClientList.Count - 1 do
  begin
    pncr := FClientList[i];
    if pncr^.Client = AClient then
    begin
      Result := pncr;
      Break;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTNotifyServer.ClearClientList;
var
  i: Integer;
  pncr: PNotifyClientRecord;
begin
  for i := 0 to FClientList.Count - 1 do
  begin
    pncr := FClientList[i];
    pncr^.Client.UnbindServer(Self);
    Dispose(pncr);
  end;
  FClientList.Clear;
end;
//------------------------------------------------------------------------------
procedure TNTNotifyServer.BindClient(AClient: TNTNotifyClient);
var
  pncr: PNotifyClientRecord;
begin
  if (Self = nil) or FDestroying then
    Exit;
  FCriticalSection.Enter;
  try
    if IndexOf(AClient) = nil then
    begin
      New(pncr);
      pncr^.Client := AClient;
      pncr^.ThreadID := {$IFNDEF FPC}GetCurrentThreadId{$ELSE}DWord(GetCurrentThreadId){$ENDIF};
      FClientList.Add(pncr);
      AClient.BindServer(Self);
    end;
  finally
    FCriticalSection.Leave;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTNotifyServer.UnbindClient(AClient: TNTNotifyClient);
var
  pncr: PNotifyClientRecord;
begin
  if (Self = nil) or FDestroying then
    Exit;
  FCriticalSection.Enter;
  try
    pncr := IndexOf(AClient);
    if pncr <> nil then
    begin
      pncr^.Client.UnbindServer(Self);
      FClientList.Remove(pncr);
      Dispose(pncr);
    end;
  finally
    FCriticalSection.Leave;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTNotifyServer.SendEvent(AEventID: Integer; AData: Pointer);
var
  i: Integer;
  ppList: PPointerList;
  ListCount: Integer;
begin
  if (Self = nil) or FDestroying then
    Exit;
  FCriticalSection.Enter;
  try
    ListCount := FClientList.Count;
    GetMem(ppList, ListCount * 4);
    try
  // это нужно, если клиент вызовет RemoveClient в вызванном событии
      System.Move(FClientList.List^, ppList^, ListCount * 4);
      for i := 0 to ListCount - 1 do
        if FClientList.IndexOf(ppList^[i]) <> -1 then
          SendEventToClient(ppList^[i], AEventID, AData);
    finally
      FreeMem(ppList);
    end;
  finally
    FCriticalSection.Leave;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTNotifyServer.SendEventToClient(AClientRec: PNotifyClientRecord;
  AEventID: Integer; AData: Pointer);
{$IFNDEF FPC}  
var
  pser: PSendEventRecord;
begin
  if (AClientRec^.ThreadID = MainThreadID) and (AClientRec^.ThreadID <> GetCurrentThreadId) then
  begin
    New(pser);
    pser^.Sender := FOwner;
    pser^.EventID := AEventID;
    pser^.Data := AData;
    PostMessage(AClientRec^.Client.FWndHandle, SM_THREAD_NOTIFY, Integer(pser), 0);
  end
  else
{$ELSE}
begin
{$ENDIF}	  
    AClientRec^.Client.DoEvent(FOwner, AEventID, AData);
end;
//------------------------------------------------------------------------------
//------------------------------ TNTNotifyClient -------------------------------
//------------------------------------------------------------------------------
constructor TNTNotifyClient.Create;
begin
  FCriticalSection := TCriticalSection.Create;
  FServerList := TList.Create;
{$IFNDEF FPC}  
  FWndHandle := AllocateHWnd(WndHandler);
{$ENDIF}  
  FDestroying := False;
end;
//------------------------------------------------------------------------------
destructor TNTNotifyClient.Destroy;
begin
  FDestroying := True;
{$IFNDEF FPC}  
  DeallocateHWnd(FWndHandle);
{$ENDIF}  
  FCriticalSection.Enter;
  ClearServerList;
  FServerList.Free;
  FCriticalSection.Free;
  inherited;
end;
//------------------------------------------------------------------------------
procedure TNTNotifyClient.ClearServerList;
var
  i: Integer;
begin
  for i := 0 to FServerList.Count - 1 do
    TNTNotifyServer(FServerList[i]).UnbindClient(Self);
  FServerList.Clear;
end;
//------------------------------------------------------------------------------
procedure TNTNotifyClient.BindServer(AServer: TNTNotifyServer);
begin
  if FDestroying then
    Exit;
  FCriticalSection.Enter;
  try
    if FServerList.IndexOf(AServer) = -1 then
      FServerList.Add(AServer);
  finally
    FCriticalSection.Leave;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTNotifyClient.UnbindServer(AServer: TNTNotifyServer);
begin
  if FDestroying then
    Exit;
  FCriticalSection.Enter;
  try
    FServerList.Remove(AServer);
  finally
    FCriticalSection.Leave;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTNotifyClient.WndHandler(var Message: TMessage);
var
  pser: PSendEventRecord;
begin
  if Message.Msg = SM_THREAD_NOTIFY then
  begin
    pser := PSendEventRecord(Message.WParam);
    DoEvent(pser^.Sender, pser^.EventID, pser^.Data);
    Dispose(pser);
  end;
end;
//------------------------------------------------------------------------------
procedure TNTNotifyClient.DoEvent(ASender: TObject; AEventID: Integer;
  AData: Pointer);
begin
  if Assigned(FOnEvent) then
    FOnEvent(ASender, AEventID, AData);
end;
//------------------------------------------------------------------------------
//---------------------------- TNTThread ---------------------------------------
//------------------------------------------------------------------------------
type
  TThreadNameInfo = record
    FType: LongWord;     // must be 0x1000
    FName: PChar;        // pointer to name (in user address space)
    FThreadID: LongWord; // thread ID (-1 indicates caller thread)
    FFlags: LongWord;    // reserved for future use, must be zero
  end;

procedure SetThreadName(AName: string; ThreadID: Integer);
var
  ThreadNameInfo: TThreadNameInfo;
begin
  if AName <> '' then
  begin
    ThreadNameInfo.FType := $1000;
    ThreadNameInfo.FName := PChar(AName);
    ThreadNameInfo.FThreadID := ThreadID;
    ThreadNameInfo.FFlags := 0;
	{$IFNDEF FPC}
    try
      RaiseException($406D1388, 0, SizeOf(ThreadNameInfo) div SizeOf(LongWord), @ThreadNameInfo);
    except
    end;
	{$ENDIF}
  end;
end;
//------------------------------------------------------------------------------
constructor TNTThread.Create;
begin
  FDestroying := False;
	inherited Create(True);
  FActionCS := TCriticalSection.Create;
  FActionList := TList.Create;
  FProcList := TList.Create;
  FNotifier := TNTNotifyServer.Create(Self);
  FSleepTime := 20;
end;
//------------------------------------------------------------------------------
destructor TNTThread.Destroy;
begin
  FDestroying := True;
	inherited Destroy;
  OutputDebugString('TNTThread.Destroy after ancestor destuctor');
  // after Execute finished
  FActionCS.Enter; // if Action calling then wait
  ClearActionList(True);
  FActionList.Free;
  ClearProcList;
  FProcList.Free;
  FActionCS.Free;
  FreeAndNil(FNotifier);
end;
//------------------------------------------------------------------------------
procedure TNTThread.SetName(const Value: string);
begin
  FName := Value;
  if {$IFNDEF FPC}(DebugHook <> 0) and{$ENDIF} not Suspended then
    SetThreadName(Value, {$IFNDEF FPC}ThreadID{$ELSE}DWORD(ThreadID){$ENDIF});
end;
//------------------------------------------------------------------------------
function TNTThread.ExecuteProc(AProc: TThreadProcedure; AExecuteCount, APeriod: Integer): Integer;
var
  ptlar: PThreadListActionRecord;
begin
  Result := 0;
  if FDestroying then
    Exit;
  FActionCS.Enter;
  try
    New(ptlar);
    ptlar^.Action := tlaAdd;
    New(ptlar^.ProcRecord);
    ptlar^.ProcRecord^.Proc := AProc;
    ptlar^.ProcRecord^.ExecuteCount := AExecuteCount;
    ptlar^.ProcRecord^.Period := APeriod;
    ptlar^.ProcRecord^.FirstTickCount := GetTickCount; // just in case
    ptlar^.ProcRecord^.ExecuteIndex := 0;
    Result := Integer(ptlar^.ProcRecord);
    FActionList.Add(ptlar);
  finally
    FActionCS.Leave;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTThread.TerminateProc(AThreadProcID: Integer);
var
  ptlar: PThreadListActionRecord;
begin
  if FDestroying then
    Exit;
  FActionCS.Enter;
  try
    New(ptlar);
    ptlar^.Action := tlaRemove;
    ptlar^.ProcRecord := Pointer(AThreadProcID);
    FActionList.Add(ptlar);
  finally
    FActionCS.Leave;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTThread.ClearProcs;
var
  ptlar: PThreadListActionRecord;
begin
  if FDestroying then
    Exit;
  FActionCS.Enter;
  try
    New(ptlar);
    ptlar^.Action := tlaClear;
    FActionList.Add(ptlar);
  finally
    FActionCS.Leave;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTThread.Execute;
begin
  SetName(FName);
  repeat
    DoProcList;
    DoActionList;
    Sleep(FSleepTime);
  until Terminated or FDestroying;
  OutputDebugString('TNTThread.Execute finished');
end;
//------------------------------------------------------------------------------
procedure TNTThread.DoProcList;
var
  i: Integer;
  ptpr: PThreadProcRecord;

  function HasPeriodFinished: Boolean;
  begin
    Result := (GetTickCount - ptpr^.FirstTickCount) /
      (ptpr^.Period * (ptpr^.ExecuteIndex + 1)) >= 1;
  end;

begin
  for i := 0 to FProcList.Count - 1 do
  begin
    ptpr := PThreadProcRecord(FProcList[i]);
    if (ptpr^.Period = 0) or (ptpr^.ExecuteIndex = 0) or HasPeriodFinished then
    begin
      ptpr^.Proc(FNotifier);
//      ptpr^.LastTickCount := GetTickCount;
      Inc(ptpr^.ExecuteIndex);
      if (ptpr^.ExecuteCount > 0) and (ptpr^.ExecuteIndex = ptpr^.ExecuteCount) then
        TerminateProc(Integer(ptpr));
      Sleep(0);
//      OutputDebugString(PChar(Format(
//        'Execute: ProcIndex = %d; ExecuteIndex = %d; ', [i, ptpr^.ExecuteIndex])));
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTThread.DoActionList;
var
  i: Integer;
  ptlar: PThreadListActionRecord;
begin
  FActionCS.Enter;
  try
    if FActionList.Count > 0 then
    begin
      for i := 0 to FActionList.Count - 1 do
      begin
        ptlar := PThreadListActionRecord(FActionList[i]);
        case ptlar^.Action of
          tlaAdd:
            begin
              // New in AddProc (because it returns ThreadProcID)
              FProcList.Add(ptlar^.ProcRecord);
            end;
          tlaRemove:
            begin
              FProcList.Remove(ptlar^.ProcRecord);
              Dispose(ptlar^.ProcRecord);
            end;
          tlaClear:
            ClearProcList;
        end;
      end;
      ClearActionList(False);
    end;
  finally
    FActionCS.Leave;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTThread.ClearProcList;
var
  i: Integer;
  ptpr: PThreadProcRecord;
begin
  for i := 0 to FProcList.Count - 1 do
  begin
    ptpr := FProcList[i];
    ptpr^.Proc := nil; // Proc call protection
    Dispose(ptpr);
  end;
  FProcList.Clear;
end;
//------------------------------------------------------------------------------
procedure TNTThread.ClearActionList(FullClear: Boolean);
var
  i: Integer;
  ptlar: PThreadListActionRecord;
begin
  for i := 0 to FActionList.Count - 1 do
  begin
    ptlar := FActionList[i];
    if FullClear and (ptlar^.Action = tlaAdd) then
      Dispose(ptlar^.ProcRecord);
    Dispose(ptlar);
  end;
  FActionList.Clear;
end;
{$IFNDEF FPC}
//------------------------------------------------------------------------------
//----------------------------- TRTTimer ---------------------------------------
//------------------------------------------------------------------------------
constructor TRTTimer.Create;
begin
  inherited Create(False);
  Priority := tpTimeCritical;
  FEnabled := False;
  FillChar(FTimeCaps, SizeOf(FTimeCaps), 0);
  if timeGetDevCaps(@FTimeCaps, SizeOf(FTimeCaps)) = TIMERR_STRUCT then
    raise Exception.Create('Error retrieving multimedia timer device capabilities');
  FInterval := FTimeCaps.wPeriodMin;
  FResolution := FTimeCaps.wPeriodMin;
//  FResolution := 1;
//  FInterval := 10;
  FSignalEvent := CreateEvent(nil, False, False, nil);
  FTerminateEvent := CreateEvent(nil, True, False, nil);
end;
//------------------------------------------------------------------------------
destructor TRTTimer.Destroy;
begin
  if Suspended then
    Suspended := False;
  Terminate;
//  SetEvent(FTerminateEvent);
  CloseHandle(FSignalEvent);
  FEnabled := False;
  UpdateTimer;
  inherited Destroy;
end;
//------------------------------------------------------------------------------
procedure TRTTimer.DoTerminate;
begin
  CloseHandle(FTerminateEvent);
  FTerminateEvent := 0;
  inherited DoTerminate;
end;
//------------------------------------------------------------------------------
procedure TRTTimer.Terminate;
begin
  inherited Terminate;
  SetEvent(FTerminateEvent);
end;
//------------------------------------------------------------------------------
procedure TRTTimer.Execute;
var
  WaitHandles: array[0..1] of THandle;
begin
  WaitHandles[0] := FTerminateEvent;
  WaitHandles[1] := FSignalEvent;
  repeat
    case WaitForMultipleObjects(2, @WaitHandles, False, INFINITE) of
      WAIT_OBJECT_0:
        Break;
      WAIT_OBJECT_0 + 1:
        Timer;
    end;
  until Terminated;
end;
//------------------------------------------------------------------------------
procedure TRTTimer.UpdateTimer;
var
  TimerCallback: TFNTimeCallback;
begin
  if FTimerID <> 0 then
  begin
    if not Suspended then
      Suspended := True;
    timeKillEvent(FTimerID);
    FTimerID := 0;
  end;
  if InRange(FInterval, FTimeCaps.wPeriodMin, FTimeCaps.wPeriodMax) and
    FEnabled and Assigned(FOnTimer) then
  begin
    TimerCallback := TFNTimeCallback(FSignalEvent);
    FTimerID := timeSetEvent(FInterval, FResolution, TimerCallback, DWORD(Self),
      TIME_PERIODIC or TIME_CALLBACK_EVENT_PULSE);
    if FTimerID = 0 then
    begin
      FEnabled := False;
      raise Exception.Create('Error setting multimedia event timer');
    end;
    if Suspended then
      Suspended := False;
  end;
end;
//------------------------------------------------------------------------------
procedure TRTTimer.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    UpdateTimer;
  end;
end;
//------------------------------------------------------------------------------
procedure TRTTimer.SetInterval(Value: Cardinal);
begin
  if Value <> FInterval then
  begin
    FInterval := Value;
    UpdateTimer;
  end;
end;
//------------------------------------------------------------------------------
procedure TRTTimer.SetResolution(Value: Cardinal);
begin
  if Value <> FResolution then
  begin
    FResolution := Value;
    UpdateTimer;
  end;
end;
//------------------------------------------------------------------------------
procedure TRTTimer.SetOnTimer(Value: TNotifyEvent);
begin
  FOnTimer := Value;
  UpdateTimer;
end;
//------------------------------------------------------------------------------
procedure TRTTimer.Timer;
begin
  if Assigned(FOnTimer) then
    FOnTimer(Self);
end;
//------------------------------------------------------------------------------
{$ENDIF}




//------------------------------------------------------------------------------
//-------<C l a s s   T N T P u b l i s h e d>----------------------------------
//------------------------------------------------------------------------------
constructor TNTPublished.Create;
begin
  inherited Create;
  FNotifyLockCnt := 0;
  FOnChange      := nil;
end;
//------------------------------------------------------------------------------
procedure TNTPublished.Assign(AValue: TPersistent);
begin
  inherited Assign(AValue);
  if Assigned(AValue) and (AValue is TNTPublished) then
  begin
    LockNotify;
    try
      VirtAssign(TNTPublished(AValue));
    finally
      UnlockNotify;
    end;
    Invalidate;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTPublished.Invalidate;
begin
  if Assigned(OnChange) and not NotifyLocked then OnChange(Self);
end;
//------------------------------------------------------------------------------
procedure TNTPublished.LockNotify;
begin
  Inc(FNotifyLockCnt);
end;
//------------------------------------------------------------------------------
procedure TNTPublished.UnlockNotify;
begin
  Dec(FNotifyLockCnt);
  if FNotifyLockCnt < 0 then FNotifyLockCnt := 0;
end;
//------------------------------------------------------------------------------
function TNTPublished.GetNotifyLocked: Boolean;
begin
  Result := (FNotifyLockCnt > 0);
end;
//------------------------------------------------------------------------------
procedure TNTPublished.VirtAssign(AValue: TNTPublished);
begin
end;
//------------------------------------------------------------------------------
procedure TNTPublished.OnNestedChange(Sender: TObject);
begin
  Invalidate;
end;
//------------------------------------------------------------------------------
//-------<C l a s s   T N T R e c t>--------------------------------------------
//------------------------------------------------------------------------------
constructor TNTRect.Create;
begin
  inherited Create;
  FLeft   := 0;
  FTop    := 0;
  FRight  := 0;
  FBottom := 0;
end;
//------------------------------------------------------------------------------
procedure TNTRect.Init(ARect: TRect);
begin
  FLeft   := ARect.Left;
  FTop    := ARect.Top;
  FRight  := ARect.Right;
  FBottom := ARect.Bottom;
end;
//------------------------------------------------------------------------------
procedure TNTRect.VirtAssign(AValue: TNTPublished);
begin
  inherited;
  if AValue is TNTRect then
    Init(TNTRect(AValue).GetRect);
end;
//------------------------------------------------------------------------------
function TNTRect.GetRect: TRect;
begin
  Result := Rect(FLeft, FTop, FRight, FBottom);
end;
//------------------------------------------------------------------------------
procedure TNTRect.SetLeft(AValue: Integer);
begin
  if FLeft <> AValue then
  begin
    FLeft := AValue;
    Invalidate;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTRect.SetTop(AValue: Integer);
begin
  if FTop <> AValue then
  begin
    FTop := AValue;
    Invalidate;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTRect.SetRight(AValue: Integer);
begin
  if FRight <> AValue then
  begin
    FRight := AValue;
    Invalidate;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTRect.SetBottom(AValue: Integer);
begin
  if FBottom <> AValue then
  begin
    FBottom := AValue;
    Invalidate;
  end;
end;
//------------------------------------------------------------------------------
//-------<C l a s s   T N T A l g o r i t h m>---------------------------------
//------------------------------------------------------------------------------
constructor TNTAlgorithm.Create;
begin
  inherited;
  FPresetting        := 0;
  FProcessing        := 0;
  FStartPresetBusy   := False;
  FFinishPresetBusy  := False;
  FStartProcessBusy  := False;
  FFinishProcessBusy := False;
  FStopNeeded        := False;
  FDestroying        := False;
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.BeforeDestruction;
begin
  inherited;
  FDestroying := True;
  Stop;
  while Presetting do;
  while Processing do;
end;
//------------------------------------------------------------------------------
destructor TNTAlgorithm.Destroy;
begin
  inherited;
end;
//------------------------------------------------------------------------------
//-------<W o r k   m e t h o d s>---------------------------------------------
//------------------------------------------------------------------------------
procedure TNTAlgorithm.InnerPreset;
var
  LPresetted: Integer;
begin
  if not FDestroying then
  begin
    LPresetted := InterlockedExchange(FPresetting, 1);
    if LPresetted = 0 then
    begin
      try
        FStopNeeded := False;
        DoStartPreset;
        VirtPreset;
        DoFinishPreset;
      finally
        FPresetting := 0;
      end;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.InnerExecute;
var
  LExecuted: Integer;
begin
  if not FDestroying then
  begin
    LExecuted := InterlockedExchange(FProcessing, 1);
    if LExecuted = 0 then
    begin
      try
        FStopNeeded := False;
        DoStartProcess;
        VirtProcess;
        DoFinishProcess;
      finally
        FProcessing := 0;
      end;
    end;
  end;
end;
//------------------------------------------------------------------------------
//-------<E v e n t   m e t h o d s>-------------------------------------------
//------------------------------------------------------------------------------
procedure TNTAlgorithm.DoStartPreset;
begin
  if not FStartPresetBusy then
  begin
    FStartPresetBusy := True;
    try
      VirtStartPreset;
      if Assigned(FOnStartPreset) then FOnStartPreset(Self);
    finally
      FStartPresetBusy := False;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.DoFinishPreset;
begin
  if not FFinishPresetBusy then
  begin
    FFinishPresetBusy := True;
    try
      VirtFinishPreset;
      if Assigned(FOnFinishPreset) then FOnFinishPreset(Self);
    finally
      FFinishPresetBusy := False;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.DoStartProcess;
begin
  if not FStartProcessBusy then
  begin
    FStartProcessBusy := True;
    try
      VirtStartProcess;
      if Assigned(FOnStartProcess) then FOnStartProcess(Self);
    finally
      FStartProcessBusy := False;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.DoFinishProcess;
begin
  if not FFinishProcessBusy then
  begin
    FFinishProcessBusy := True;
    try
      VirtFinishProcess;
      if Assigned(FOnFinishProcess) then FOnFinishProcess(Self);
    finally
      FFinishProcessBusy := False;
    end;
  end;
end;
//------------------------------------------------------------------------------
//-------<V i r t u a l   m e t h o d s>---------------------------------------
//------------------------------------------------------------------------------
procedure TNTAlgorithm.VirtStartPreset;
begin
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.VirtFinishPreset;
begin
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.VirtStartProcess;
begin
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.VirtFinishProcess;
begin
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.VirtPreset;
begin
(* For long time Presetting check StopNeeded periodically *)
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.VirtProcess;
begin
(* For long time Processing check StopNeeded periodically *)
end;
//------------------------------------------------------------------------------
//-------<I n t e r f a c e>---------------------------------------------------
//------------------------------------------------------------------------------
procedure TNTAlgorithm.Preset;
begin
  InnerPreset;
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.Execute;
begin
  InnerExecute;
end;
//------------------------------------------------------------------------------
procedure TNTAlgorithm.Stop;
begin
  FStopNeeded := True;
end;
//------------------------------------------------------------------------------
function TNTAlgorithm.GetPresetting: Boolean;
begin
  Result := (FPresetting <> 0);
end;
//------------------------------------------------------------------------------
function TNTAlgorithm.GetProcessing: Boolean;
begin
  Result := (FProcessing <> 0);
end;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
function IDtoObject(AObjectID: Integer): TObject;
begin
  Result := nil;
  if AObjectID <> NIL_ID then Result := TObject(Pointer(AObjectID));
end;
//------------------------------------------------------------------------------
function ObjectToID(AObject: TObject): Integer;
begin
  Result := NIL_ID;
  if AObject <> nil then Result := Integer(Addr(AObject)^);
end;
//------------------------------------------------------------------------------
// Calling after Object.Create guarantees any Interface.Release will not destroy the object
procedure ManualFreeNeeded(const AObject: TObject);
var
  vUnknownIntf: IInterface;
begin
  if (AObject <> nil) and AObject.GetInterface(IInterface, vUnknownIntf) then
    vUnknownIntf._AddRef;
end;
//------------------------------------------------------------------------------
// Use coupled with ManualFreeNeeded to manual destroy the object after posibile using interfaces
function InterfacedFreeAndNil(var AObject): Boolean;
var
  vObject: TObject;
  vUnknownIntf: IInterface;
  vRefCntSign: Integer;
begin
  vObject := TObject(AObject);
  if vObject <> nil then
  begin
    // Try get IUnknown
    if vObject.GetInterface(IInterface, vUnknownIntf) then
    begin
      // Release ManualFreeNeeded()->_AddRef call
      vUnknownIntf._Release;

      // Release previous implicit GetInterface()->_AddRef call
      // and get true RefCount sign
      vRefCntSign := vUnknownIntf._Release;

      // Skip Delphi implicit vUnknownIntf._Release called at end
      Pointer(vUnknownIntf) := nil;

      if vRefCntSign = 0 then
        // Ok: The Object was self destroyed during last Release call
        Pointer(AObject) := nil
      else if vRefCntSign < 0 then
        // Ok: The Object ignores RefCount (like TComponent)
        FreeAndNil(AObject);
      (*else Fail: AObject can not be destroyed now
                   because some Object Interface reference was not released *)
    end
    else
      // Ok: The Object has no interfaces
      FreeAndNil(AObject);
  end;
  Result := (Pointer(AObject) = nil);
end;
//------------------------------------------------------------------------------
function InterfacedFree(AObject: TObject): Boolean;
var
  vObject: TObject;
begin
  vObject := AObject;
  Result := InterfacedFreeAndNil(vObject);
end;
//------------------------------------------------------------------------------
function GetIntf(AObject: IUnknown; const IID: TGUID; out AIntf): Boolean;
begin
  Result := (AObject <> nil);
  if Result then
    Result := (AObject.QueryInterface(IID, AIntf) = S_OK);
end;
//------------------------------------------------------------------------------
procedure FreeAndNil(var Obj);
var
  Temp: TObject;
begin
  Temp := TObject(Obj);
  Pointer(Obj) := nil;
  Temp.Free;
end;
//------------------------------------------------------------------------------

end.
