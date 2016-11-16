unit ServerForm;
//{$DEFINE USE_TBX}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, Winsock, shlobj, SyncObjs,
{$IFDEF USE_TBX}TBX, ComCtrls{$ELSE}menus, ComCtrls{$ENDIF};

const
  kDNSServiceInterfaceIndexAny = 0;
  kDNSServiceInterfaceIndexLocalOnly = $FFFFFFFF;
  MyRegType = '_mdtframe._tcp.';
  MaxClients = 10;

type
  DNSServiceRef = pointer;
  PDNSServiceRef = ^DNSServiceRef;
  DNSServiceFlags = cardinal;
  DNSServiceErrorType = longint;

  TResolveThread = class;

  TServiceListChangeNotification = procedure(AServiceNames: TStringList) of
    object;
  TResolveEndNotification = procedure(resolveThread: TResolveThread) of object;
  TMDTServiceCallback = procedure(const AParam: string) of object;
{$IFDEF USE_TBX}
  MySubmenuType = TTBXSubmenuItem;
  MyMenuItemType = TTBXItem;
{$ELSE}
  MySubmenuType = TMenuItem;
  MyMenuItemType = TMenuItem;
{$ENDIF}

  TBrowseThread = class(TThread)
  private
    FServiceNames: TStringList;
    FStopFlag: Boolean;

    FOnServiceListChange: TServiceListChangeNotification;

    procedure AddService(AServ: string);
    procedure RemoveService(AServ: string);
    procedure StopBrowse;
    procedure UpdateGUIList;
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    property ServiceNames: TStringList read FServiceNames;
    property OnServiceListChange: TServiceListChangeNotification write
      FOnServiceListChange;
  end;

  TResolveThread = class(TThread)
  protected
    procedure Execute; override;
  private
    FNameToResolve: string;
    FIsResolved: boolean;
    FAddress: string;
    FPort: integer;
    FOnResolveEnd: TResolveEndNotification;
    procedure SetAddressAndPort(AAddr: string; AMport: Integer);
    procedure ResolveEnd;
  public
    procedure Resolve(AName: string);
    property Port: Integer read FPort;
    property Address: string read FAddress;
    property Resolved: boolean read FIsResolved;
    property OnResolveEnd: TResolveEndNotification read FOnResolveEnd write
      FOnResolveEnd;
  end;

  SessionRecord = record
    rSocket: TCustomWinSocket;
    rStream: TFileStream;
    rFileName: string;
    rBytesReceived: integer;
  end;

  TMDTServiceForm = class(TForm)
    ServiceNameEdit: TEdit;
    cbLocalOnly: TCheckBox;
    Label1: TLabel;
    StartButton: TButton;
    StopButton: TButton;
    ServerSocket1: TServerSocket;
    FrameSendSocket: TClientSocket;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    Edit1: TEdit;
    procedure StartButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FrameSendSocketWrite(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FrameSendSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FrameSendSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure FrameSendSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure FrameSendSocketConnecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Edit1Change(Sender: TObject);
  private
    FServiceRef: DNSServiceRef;
    FDnsLibrary: THANDLE;
    //    FResolveThread: TResolveThread;
    FBrowseThread: TBrowseThread;
    //    FMS: TMemoryStream;

    FOnLoadFile: TMDTServiceCallback;
    FOnSaveFile: TMDTServiceCallback;
    FOnShowWarning: TMDTServiceCallback;
    FSubMenuItem: MySubmenuType;
    FStorePath: string;
    ReceivedIndex: integer;
    FLastWarning: string;

    sendSessions, receivedSessions: array[0..MaxClients - 1] of SessionRecord;
    reseiveLock, sendLock: TCriticalSection;
    FrameSendSockets: array[0..MaxClients - 1] of TClientSocket;

    procedure ServiceListChanged(AList: TStringList);
    procedure SendFramesMenuSelected(Sender: TObject);
    procedure ResolveEnds(resolveThread: TResolveThread);
    procedure SetSendServicesEnabled(AState: boolean);
    function SendEnabled: boolean;
    function SaveFramesToFile(const filename: string): boolean;
    property SendServicesEnabled: boolean write SetSendServicesEnabled;

    procedure SetLocalHostOnly(AMode: boolean);
    function GetLocalHostOnly: boolean;
    procedure SetServiceName(AName: string);
    function GetServiceName: string;
    procedure SetStarted(AStarted: boolean);
    function GetStarted: boolean;
    procedure SetStatusString(AString: string; AWarning: boolean = false);
    procedure SetSubMenuItem(ASubMenuItem: MySubmenuType);
    procedure SetOnShowWarning(AOnShowWarning: TMDTServiceCallback);
  public
    property OnLoadFile: TMDTServiceCallback read FOnLoadFile write FOnLoadFile;
    property OnSaveFile: TMDTServiceCallback read FOnSaveFile write FOnSaveFile;

    property OnShowWarning: TMDTServiceCallback read FOnShowWarning write
      SetOnShowWarning;
    property SubMenuItem: MySubmenuType read FSubMenuItem write SetSubMenuItem;

    property LocalHostOnly: boolean read GetLocalHostOnly write
      SetLocalHostOnly;
    property ServiceName: string read GetServiceName write SetServiceName;
    property Started: boolean read GetStarted write SetStarted;
    property StorePath: string read FStorePath write FStorePath;
  end;

  DNSServiceRegisterReply = procedure
    (sdRef: DNSServiceRef;
    flags: DNSServiceFlags;
    errorCode: DNSServiceErrorType;
    name, { may be NULL }
    regtype,
    domain: PAnsiChar;
    context: TMDTServiceForm
    ); stdcall;

  DNSServiceBrowseReply = procedure
    (
    sdRef: DNSServiceRef;
    flags: DNSServiceFlags;
    interfaceIndex: cardinal;
    errorCode: DNSServiceErrorType;
    serviceName,
    regtype,
    replyDomain: PAnsiChar;
    context: TBrowseThread
    ); stdcall;

  DNSServiceResolveReply = procedure
    (
    sdRef: DNSServiceRef;
    flags: DNSServiceFlags;
    interfaceIndex: cardinal;
    errorCode: DNSServiceErrorType;
    fullname,
    hosttarget: PAnsiChar;
    port: WORD;
    txtLen: WORD;
    txtRecord: PAnsiChar;
    context: TResolveThread
    ); stdcall;

  // Extrnal functions from dnssd.dll

  DNSServiceRegisterFunct = function(sdRef: PDNSServiceRef;
    flags: DNSServiceFlags;
    interfaceIndex: cardinal;
    name, { may be NULL }
    regtype,
    domain, (* may be NULL *)
    host: PAnsiChar; (* may be NULL *)
    port: WORD;
    txtLen: WORD;
    txtRecord: pointer; (* may be NULL *)
    callBack: DNSServiceRegisterReply; (* may be NULL *)
    context: pointer (* may be NULL *)
    ): DNSServiceErrorType; stdcall; //external  'dnssd';

  DNSServiceRefDeallocateFunct = procedure(sdRef: DNSServiceRef); stdcall;
  //  external  'dnssd';
  DNSServiceRefSockFDFunct = function(sdRef: DNSServiceRef):
    DNSServiceErrorType; stdcall; //  external  'dnssd';
  DNSServiceProcessResultFunct = function(sdRef: DNSServiceRef):
    DNSServiceErrorType; stdcall; //external  'dnssd';
  //=======================================================================
  DNSServiceBrowseFunct = function
    (
    sdRef: PDNSServiceRef;
    flags: DNSServiceFlags;
    interfaceIndex: cardinal;
    regtype: PAnsiChar;
    domain: PAnsiChar; (* may be NULL *)
    callBack: DNSServiceBrowseReply;
    context: pointer (* may be NULL *)
    ): DNSServiceErrorType; stdcall; // external  'dnssd';

  //=======================================================================
  DNSServiceResolveFunct = function
    (
    sdRef: PDNSServiceRef;
    flags: DNSServiceFlags;
    interfaceIndex: cardinal;
    name,
    regtype,
    domain: PAnsiChar;
    callBack: DNSServiceResolveReply;
    context: pointer (* may be NULL *)
    ): DNSServiceErrorType; stdcall; //external  'dnssd';

  //=======================================================================
function GetLastErrorText(): string;
implementation

{$R *.dfm}

var
  DNSServiceRegister: DNSServiceRegisterFunct;
  DNSServiceRefDeallocate: DNSServiceRefDeallocateFunct;
  DNSServiceRefSockFD: DNSServiceRefSockFDFunct;
  DNSServiceProcessResult: DNSServiceProcessResultFunct;
  DNSServiceBrowse: DNSServiceBrowseFunct;
  DNSServiceResolve: DNSServiceResolveFunct;

  //Reply procedures

procedure DNSServiceRegisterReplyProc(sdRef: DNSServiceRef;
  flags: DNSServiceFlags;
  errorCode: DNSServiceErrorType;
  name, { may be NULL }
  regtype,
  domain: PAnsiChar;
  context: TMDTServiceForm); stdcall;
begin
  //context.Button1.Enabled:=true;
end;

procedure DNSServiceBrowseReplyProc(sdRef: DNSServiceRef; flags:
  DNSServiceFlags;
  interfaceIndex: cardinal; errorCode: DNSServiceErrorType; serviceName,
  regtype, replyDomain: PAnsiChar; context: TBrowseThread); stdcall;
begin
  if flags and 2 <> 0 then
    context.AddService(serviceName)
  else
    context.RemoveService(serviceName);
end;

procedure DNSServiceResolveReplyProc(sdRef: DNSServiceRef; flags:
  DNSServiceFlags;
  interfaceIndex: cardinal; errorCode: DNSServiceErrorType; fullname,
  hosttarget: PAnsiChar;
  port: WORD; txtLen: WORD; txtRecord: PAnsiChar; context: TResolveThread);
  stdcall;
var
  Host: Phostent;
  addr: In_Addr;
  address: string;
begin
  Host := gethostbyname(hosttarget);
  addr := PInAddr(Host^.h_addr_list^)^;
  address := inet_ntoa(addr);
  context.SetAddressAndPort(address, (port shr 8) or ((port and $FF) shl 8));
end;

procedure TResolveThread.Execute;
var
  res: integer;
  result: DNSServiceErrorType;
  browseService: DNSServiceRef;
begin
  Result := DNSServiceResolve(@browseService, 0, kDNSServiceInterfaceIndexAny,
    PAnsiChar(AnsiString(FNameToResolve)), MyRegType, PAnsiChar('local.'),
    DNSServiceResolveReplyProc, self);
  if Result = 0 then
  begin
    repeat
      Res := DNSServiceProcessResult(browseService);
      FIsResolved := Res = 0;
      Sleep(10);
    until (Res <> 0) or FIsResolved;
    DNSServiceRefDeallocate(browseService);
  end;
  Synchronize(ResolveEnd)

end;

procedure TResolveThread.ResolveEnd;
begin
  if Assigned(OnResolveEnd) then
    OnResolveEnd(Self);
end;

procedure TResolveThread.SetAddressAndPort(AAddr: string; AMport: Integer);
begin
  FAddress := AAddr;
  FPort := AMport;
  FIsResolved := true;
end;

procedure TResolveThread.Resolve(AName: string);
begin
  FNameToResolve := AName;
  FIsResolved := false;

  Resume;
end;

//=======================================================================

constructor TBrowseThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FServiceNames := TStringList.Create;
end;

destructor TBrowseThread.Destroy;
begin
  FServiceNames.Free;
  inherited;
end;

procedure TBrowseThread.UpdateGUIList;
begin
  if Assigned(FOnServiceListChange) then
    FOnServiceListChange(FServiceNames);
end;

procedure TBrowseThread.AddService(AServ: string);
begin
  FServiceNames.Add(AServ);
  Synchronize(UpdateGUIList);
end;

procedure TBrowseThread.RemoveService(AServ: string);
var
  i, count: integer;
begin
  count := FServiceNames.Count;
  if FServiceNames.Count > 0 then
  begin
    for i := 0 to count - 1 do
    begin
      if AServ = FServiceNames[i] then
      begin
        FServiceNames.Delete(i);
        Break;
      end;
    end;
    Synchronize(UpdateGUIList);
  end;
end;

procedure TBrowseThread.Execute;
var
  res: integer;
  result: DNSServiceErrorType;
  browseService: DNSServiceRef;

  sock: TSocket;
  wfds: Tfdset;
  tv: Ttimeval;

begin
  FStopFlag := false;
  Result := DNSServiceBrowse(@browseService, 0, kDNSServiceInterfaceIndexAny,
    MyRegType, nil, DNSServiceBrowseReplyProc, Self);
  if Result = 0 then
  begin
    sock := DNSServiceRefSockFD(browseService);
    repeat
      FD_ZERO(wfds);
      FD_SET(sock, wfds);

      tv.tv_sec := 1;
      tv.tv_usec := 0;
      res := select(0, @wfds, nil, nil, @tv);
      if res > 0 then
        if FD_ISSET(sock, wfds) then
          res := DNSServiceProcessResult(browseService)
        else
        begin
          Sleep(100);
          res := 0;
        end;
    until (res <> 0) or FStopFlag;
    DNSServiceRefDeallocate(browseService);
  end;
end;

procedure TBrowseThread.StopBrowse;
begin
  FStopFlag := True;
end;

//=======================================================================

procedure TMDTServiceForm.ServiceListChanged(AList: TStringList);
var
  i: integer;
  lItem: MyMenuItemType;
begin
  if FSubMenuItem <> nil then
  begin
    FSubMenuItem.Enabled := AList.Count > 0;
    FSubMenuItem.Clear;
    for i := 0 to AList.Count - 1 do
    begin
      lItem := MyMenuItemType.Create(FSubMenuItem);
      lItem.Caption := AList.Strings[i];
      lItem.OnClick := SendFramesMenuSelected;
      FSubMenuItem.Add(lItem);
    end;
  end;
end;

procedure TMDTServiceForm.SendFramesMenuSelected(Sender: TObject);
var
  tmpstr: string;
begin
  if FDnsLibrary <= 0 then
    Exit;

  with TResolveThread.Create(true) do
  begin
    FreeOnTerminate := true;
    OnResolveEnd := ResolveEnds;
    tmpstr := MyMenuItemType(Sender).Caption;
{$IFNDEF USE_TBX}
    tmpstr := Copy(tmpstr, 2, Length(tmpstr) - 1);
{$ENDIF}
    Resolve(tmpstr);
  end;

//  SendServicesEnabled := false;

end;

procedure TMDTServiceForm.ResolveEnds(resolveThread: TResolveThread);
var
   i : integer;
begin

  if resolveThread.Resolved then
  begin
  for i := 0 to MaxClients - 1 do
  with  FrameSendSockets[i] do
  if not Active then   // find free socket
  begin
    Port := resolveThread.Port;
    host := '';
    Address := resolveThread.Address;
    Active := true;
    Exit;
  end ;
       SetStatusString('No free sockets left', true);
       SendServicesEnabled := false;
  end
  else
  begin
    //    if Assigned(FOnShowWarning) then
    //      FOnShowWarning('Communication error');
    SetStatusString('Communication error', true);
//    SendServicesEnabled := false;
  end;

end;

procedure TMDTServiceForm.SetSendServicesEnabled(AState: boolean);
var
  i: integer;
begin
  if Assigned(FSubMenuItem) then
  begin
    for i := 0 to FSubMenuItem.Count - 1 do
    begin
      FSubMenuItem.Items[i].Enabled := AState;
    end;
  end;

end;

procedure TMDTServiceForm.Edit1Change(Sender: TObject);
var
  port: integer;
begin
  if not ServerSocket1.Active and TryStrToInt(Edit1.Text, port) and (port > 0)
    and (port < 65535) then
    ServerSocket1.Port := port
  else
    Edit1.Text := format('%d', [ServerSocket1.Port]);
end;

procedure TMDTServiceForm.FormCreate(Sender: TObject);
var
  buffer: array[0..MAX_PATH] of char;
  function GetComputerName: string;
  var
    Buffer: array[0..MAX_COMPUTERNAME_LENGTH] of Char;
    Size: DWORD;
  begin
    Size := Length(Buffer);
    FillChar(Buffer, Size, 0);
    Windows.GetComputerName(Buffer, Size);
    SetString(Result, Buffer, Size);
  end;
  var
     i : integer;
begin
  reseiveLock := TCriticalSection.Create;
  sendLock := TCriticalSection.Create;
  for I := 0 to MaxClients - 1 do
  begin
      FrameSendSockets [ i ] := TClientSocket.Create(self);
      FrameSendSockets [ i ].OnConnect := FrameSendSocketConnect;
      FrameSendSockets [ i ].OnConnecting := FrameSendSocketConnecting;
      FrameSendSockets [ i ].OnDisconnect := FrameSendSocketDisconnect;
      FrameSendSockets [ i ].OnError := FrameSendSocketError;
      FrameSendSockets [ i ].OnWrite := FrameSendSocketWrite;
      FrameSendSockets [ i ].ClientType := ctNonBlocking;
  end;

  FDnsLibrary := LoadLibrary('dnssd.dll');
  if FDnsLibrary > 0 then
  begin
    @DNSServiceRegister := GetProcAddress(FDnsLibrary, 'DNSServiceRegister');
    //DNSServiceRegisterFunct;
    @DNSServiceRefDeallocate := GetProcAddress(FDnsLibrary,
      'DNSServiceRefDeallocate'); //DNSServiceRefDeallocateFunct;
    @DNSServiceRefSockFD := GetProcAddress(FDnsLibrary, 'DNSServiceRefSockFD');
    //DNSServiceRefSockFDFunct;
    @DNSServiceProcessResult := GetProcAddress(FDnsLibrary,
      'DNSServiceProcessResult'); //DNSServiceProcessResultFunct;
    @DNSServiceBrowse := GetProcAddress(FDnsLibrary, 'DNSServiceBrowse');
    //DNSServiceBrowseFunct;
    @DNSServiceResolve := GetProcAddress(FDnsLibrary, 'DNSServiceResolve');
    //DNSServiceResolveFunct;

    FBrowseThread := TBrowseThread.Create(true);
    FBrowseThread.OnServiceListChange := ServiceListChanged;

    FBrowseThread.Resume;
  end
  else
    SetStatusString('Bonjour is not Installed', true);
  //  else if Assigned(FOnShowWarning) then
  //    FOnShowWarning('Bonjour is not Installed');

  ServiceName := 'Image analysis at ' + GetComputerName;
  LocalHostOnly := true;
  if SHGetSpecialFolderPath(0, buffer, CSIDL_PERSONAL, true) then
  begin
    StorePath := buffer;
    StorePath := StorePath + '\';
  end;
  Edit1.Text := format('%d', [ServerSocket1.Port]);
end;

procedure TMDTServiceForm.FormDestroy(Sender: TObject);
begin
  if FDnsLibrary > 0 then
  begin
    FBrowseThread.StopBrowse;
    FBrowseThread.WaitFor;
    FBrowseThread.free;
    FreeLibrary(FDnsLibrary);
  end;
  reseiveLock.Free;
  sendLock.Free;
end;

procedure TMDTServiceForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
  end;
end;

procedure TMDTServiceForm.StartButtonClick(Sender: TObject);
begin
  Started := true;
end;

procedure TMDTServiceForm.StopButtonClick(Sender: TObject);
begin
  Started := false;
end;

procedure TMDTServiceForm.FrameSendSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);

  function GetTempDir: string;
  var
    Buffer: array[0..MAX_PATH] of Char;
  begin
    SetString(Result, Buffer, GetTempPath(Length(Buffer), Buffer));
  end;

var
  TempFileName: array[0..MAX_PATH] of char;
  i: integer;
  TempName: string;
  guid: tguid;
  selectedIndex : integer;
  needsRemove : boolean;
begin
  CreateGUID(guid);
  if GetTempFileName(PChar(GetTempDir), PChar(GUIDToString(guid)), 1,
    TempFileName) = 0 then
  begin
    raise Exception.Create(SysErrorMessage(GetLastError));
    exit;
  end;
  TempName := TempFileName + '.mdt';

  if SendEnabled then
  begin
    sendLock.Enter;
    selectedIndex := -1;
    for i := 0 to MaxClients - 1 do
      with sendSessions[i] do
        if rSocket = nil then
        begin
          rSocket   := Socket;
          rFileName := TempName;
          selectedIndex := i;
          break;
        end;
     sendLock.Leave;

     needsRemove := false;
     if selectedIndex>=0 then
     with sendSessions[selectedIndex] do
     begin

     rBytesReceived := 0;

     if SaveFramesToFile(TempName) then
     try
            rStream := TFileStream.Create(TempName, fmOpenRead);

     except
            needsRemove := true;
     end
     else   needsRemove := true;

     if   needsRemove  then
     begin
            sendLock.Enter;
            rStream := nil;
            rSocket := nil;
            rFileName := '';
            sendLock.Leave;

            if Assigned(FOnShowWarning) then
                   FOnShowWarning('Error sending data');
            SetStatusString('Error sending data: ' + GetLastErrorText, true);
            Socket.Close;
     end;
     end;

  end;
end;

procedure TMDTServiceForm.FrameSendSocketConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  //
end;

function GetLastErrorText(): string;
var
  dwSize: DWORD;
  lpszTemp: PChar;
begin
  dwSize := 512;
  lpszTemp := nil;
  try
    GetMem(lpszTemp, dwSize);
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_ARGUMENT_ARRAY,
      nil, GetLastError(), LANG_NEUTRAL, lpszTemp, dwSize, nil);
  finally
    Result := lpszTemp;
    FreeMem(lpszTemp)
  end
end;

procedure TMDTServiceForm.FrameSendSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i: integer;
  tmpName : string;
begin
  //  FMS := nil;
  tmpName := '';
  sendLock.Enter;
  for i := 0 to MaxClients - 1 do
    with sendSessions[i] do
      if rSocket = Socket then
      begin
        rSocket := nil;
        rStream := nil;
        tmpName := rFileName;
        break;
      end;
  sendLock.Leave;
  if tmpName<>'' then DeleteFile(tmpName);
  SendServicesEnabled := true;
end;

procedure TMDTServiceForm.FrameSendSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  //  if Assigned(FOnShowWarning) then
  //    FOnShowWarning('Error sending data');
  SetStatusString('Error sending data: ' + GetLastErrorText, true);
  FrameSendSocketDisconnect(Sender, Socket);
end;

function TMDTServiceForm.SendEnabled: boolean;
begin
  Result := (FDnsLibrary > 0) and Assigned(OnSaveFile);
end;

function TMDTServiceForm.SaveFramesToFile(const filename: string): boolean;
begin
  if Assigned(OnSaveFile) then
    OnSaveFile(filename);
  Result := FileExists(filename);
end;

procedure TMDTServiceForm.FrameSendSocketWrite(Sender: TObject;
  Socket: TCustomWinSocket);
const
  buflen = 1024;

var
  i: integer;
  tmpStream : TStream;
begin

  tmpStream := nil;
  sendLock.Enter;
  for i := 0 to MaxClients - 1 do
    with sendSessions[i] do
      if rSocket = Socket then
      begin
        tmpStream := rStream;
        break;
      end;
  sendLock.Leave;

  if tmpStream<>nil  then
                Socket.SendStreamThenDrop(tmpStream);

end;

procedure TMDTServiceForm.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i: integer;
  function NewFileName(Prefix: string): string   ;
  var
    guid: TGUID;
    i: integer;
  begin
      for I := 0 to 1000 do
      begin
         Result := format('%s_%d.mdt',[ Prefix , i]);
         if not FileExists(Result) then exit;
      end;
      CreateGUID(guid);
      Result :=  Prefix + GUIDToString(guid) + '.mdt';
  end;
begin
  if LocalHostOnly and (Socket.RemoteAddress <> Socket.LocalAddress) then
    Exit;

  reseiveLock.Enter;
  for i := 0 to MaxClients - 1 do
    with receivedSessions[i] do
      if rSocket = nil then
      begin
        rBytesReceived := 0;
        rSocket := Socket;
        rFileName :=  NewFileName(StorePath+Socket.RemoteHost);
        DeleteFile(rFileName);
        rStream := nil;
        try
          rStream := TFileStream.Create(rFileName, fmCreate or fmOpenWrite or
            fmShareDenyNone);
        except
          rStream := nil;
          rSocket := nil;
          rFileName := '';
        end;
        break;
      end;
  reseiveLock.Leave;
end;

procedure TMDTServiceForm.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i: integer;
begin
  reseiveLock.Enter;
  for i := 0 to MaxClients - 1 do
    with receivedSessions[i] do
      if rSocket = Socket then
      begin
        if rStream <> nil then
        begin
          rStream.Free;
          if Assigned(FOnLoadFile) and (rBytesReceived > 0) then
            FOnLoadFile(rFileName)
          else
            DeleteFile(rFileName);
        end;
        rStream := nil;
        rSocket := nil;
        rFileName := '';
        rBytesReceived := 0;
      end;
  reseiveLock.Leave;
end;

procedure TMDTServiceForm.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  if Assigned(FOnShowWarning) then
    FOnShowWarning(GetLastErrorText);
end;

procedure TMDTServiceForm.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
const
  buflen = 1024;
var
  buffer: array[0..buflen - 1] of byte;
  rdata: Integer;
  Stream: TFileStream;
  local, wr: boolean;
  tempname: string;
  suffix: string;
  i, currentI, rLen: integer;

begin
  Stream := nil;
  reseiveLock.Enter;
  currentI := -1;
  for i := 0 to MaxClients - 1 do
    with receivedSessions[i] do
      if rSocket = Socket then
      begin
        Stream := rStream;
        currentI := i;
        break;
      end;

  rLen := Socket.ReceiveLength;
  if currentI>=0 then
  repeat
    if rLen > buflen then
      rLen := buflen;
    rdata := Socket.ReceiveBuf(buffer, buflen);
    if (rdata > 0) and (Stream <> nil) then
    begin
      Stream.WriteBuffer(buffer, rdata);
      Inc(receivedSessions[currentI].rBytesReceived, rData);
    end;
    rLen := Socket.ReceiveLength;
  until rLen = 0;

  reseiveLock.Leave;

//  if (rdata < 0) and Assigned(FOnShowWarning) then
//    FOnShowWarning(GetLastErrorText);

end;

procedure TMDTServiceForm.SetLocalHostOnly(AMode: boolean);
begin
  cbLocalOnly.Checked := aMode;
end;

procedure TMDTServiceForm.SetOnShowWarning(AOnShowWarning: TMDTServiceCallback);
begin
  FOnShowWarning := AOnShowWarning;
  if FLastWarning <> '' then
    FOnShowWarning(FLastWarning);
end;

function TMDTServiceForm.GetLocalHostOnly: boolean;
begin
  Result := cbLocalOnly.Checked;
end;

procedure TMDTServiceForm.SetServiceName(AName: string);
begin
  ServiceNameEdit.Text := AName;
end;

function TMDTServiceForm.GetServiceName: string;
begin
  result := ServiceNameEdit.Text;
end;

procedure TMDTServiceForm.SetStarted(AStarted: boolean);
var
  result: DNSServiceErrorType;
  port: integer;
  interf: cardinal;
begin
  if (AStarted = Started) or (FDnsLibrary <= 0) then
    Exit;

  if AStarted then
  begin
    if FServiceRef = nil then
    begin
      port := 30000 + random(30000);
      ServerSocket1.port := Port;
      ServerSocket1.Active := true;
      port := ServerSocket1.port;

      if LocalHostOnly then
        interf := kDNSServiceInterfaceIndexLocalOnly
      else
        interf := kDNSServiceInterfaceIndexAny;

      Result := DNSServiceRegister(@FServiceRef, 0,
        interf,
        PAnsiChar(AnsiString(ServiceName)), MyRegType, nil, nil,
        ((port and $FF) shl 8) or (port shr 8), 0, nil,
        DNSServiceRegisterReplyProc,
        Self);

      if Result = 0 then
      begin
        StartButton.Enabled := false;
        Edit1.Enabled := false;
        StopButton.Enabled := true;
        cbLocalOnly.Enabled := false;
        DNSServiceProcessResult(FServiceRef);
        SetStatusString('Service started');
      end
      else
      begin
        ServerSocket1.Close;
        SetStatusString('Service start error. Check if bonjour installed and name is unique.');
      end;
    end;
  end
  else
  begin
    if FServiceRef <> nil then
    begin
      DNSServiceRefDeallocate(FServiceRef);
      ServerSocket1.Active := false;
      FServiceRef := nil;
      StartButton.Enabled := true;
      Edit1.Enabled := true;
      StopButton.Enabled := false;
      cbLocalOnly.Enabled := true;
      SetStatusString('Service disabled');
    end;
  end;
end;

procedure TMDTServiceForm.SetStatusString(AString: string; AWarning: boolean =
  false);
begin
  if AWarning then
  begin
    FLastWarning := AString;
    if Assigned(FOnShowWarning) then
      FOnShowWarning(AString);
  end;
  Statusbar1.Panels[0].text := AString;
end;

procedure TMDTServiceForm.SetSubMenuItem(ASubMenuItem: MySubmenuType);
begin
  FSubMenuItem := ASubMenuItem;
  if Assigned(FBrowseThread) then
    FBrowseThread.UpdateGUIList;
end;

function TMDTServiceForm.GetStarted: boolean;
begin
  Result := FServiceRef <> nil;
end;
end.

