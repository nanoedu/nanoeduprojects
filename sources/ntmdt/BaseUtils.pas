unit BaseUtils;

interface
{$IFNDEF FPC}
uses
  Messages, Windows, SysUtils, ShellApi, ShlObj, ComObj, ActiveX, Registry, WinSock,
  MultiMon, WinInet, MAPI, Math, StrUtils,
  BaseTypes;

{$I jedi.inc}
{$ELSE}
uses
  Windows, BaseTypes,SysUtils,Math;
{$ENDIF}

//************************************************************
//******* System constants, types and functions **************
//************************************************************
type
  TShortcutType = (stDesktop, stQuickLaunch, stSendTo, stStartMenu, stOtherFolder);
{$IFNDEF FPC}
  TWMSizing = TWMMoving;
{$ENDIF}

const
  OS_WINNT = 1; { WINDOWS NT}
  OS_WIN32S = 2; { WIN32 UNDER WIN3.1}
  OS_WINXP = 3; { XP }
  OS_WIN2k = 4; { Win2k }
  OS_WIN95 = 5; { Win 95 }
  OS_WIN98 = 6; { WIn 98 }
  OS_WIN98SE = 7; { Windows 98 Second Edition }
  OS_WINME = 8; { windows Millenium }
  OS_LINUX = 9; { Linux }

  RT_HTML = MakeIntResource(23);

  DEF_NAMESEPARATOR = '/';
  DEF_NAMESEPARATORA: AnsiChar = '/';
  DEF_NAMESEPARATORW: WideChar = '/';

{$IFNDEF FPC}
function IsDelphiRunning: Boolean;
function GetWindowsTempPath: string;
function GetWindowsTempDir: string;
function GetWindowsDir: string;
function GetSystemDir: string;
function GetComputerName: string;
function GetUserName: string;
function GetCountryEnglishName: string;
function GetLocalIPAddress: AnsiString;
function GetWorkArea: TRect;
function GetScreenHeight: Integer;
function GetScreenWidth: Integer;
function GetVirtualScreenHeight: Integer;
function GetVirtualScreenWidth: Integer;
function GetVirtualScreenX0: Integer;
function GetVirtualScreenY0: Integer;

function GetCurrentModuleName: string;
function GetCurrentModuleDir: string;
function GetExeName: string;
function GetExeDir: string;
function GetFullDir(ABaseDir, ARelativeDir: string): string;

function InPort8(Address: Word): Byte;
procedure OutPort8(Address: Word; Value: Byte);
function InPort16(Address: Word): Word;
procedure OutPort16(Address: Word; Value: Word);
function InPort32(Address: Word): LongWord;
procedure OutPort32(Address: Word; Value: LongWord);

procedure OpenURL(URL: string);
procedure ShellSendMail(Addr, CC, BCC, Subject, Body: string);
function SendMail(From, Dest, Subject, Text, AttachFileName: AnsiString; Outlook: Boolean): Integer;

function GetWindowsVersion: Integer;
function GetWindowsVersionString: string;

procedure CopyFiles(FilesFrom, FilesTo: array of string);
procedure DeleteFiles(Files: array of string); overload;
//function DeleteFiles(const FileMask: string): Boolean; overload;

function CreateShortcut(Location: TShortcutType; SourceFileName, LinkName,
  SubFolder, WorkingDir, Parameters, Description, IconLocation: string;
  IconIndex: Integer): string;
{$ENDIF}
procedure ShowMessage(const Text: string; const Caption: string = '';
  const Flags: UINT = 0); overload;
procedure ShowMessage(Text: PChar); overload;
function MessageDlg(const Text: string; Flags: DWORD = 0; const Caption: string = ''): Integer;
procedure OutDebug(const AFormat: string; const Args: array of const);
procedure ShowError(const AFormat: string; const Args: array of const);
{$IFNDEF FPC}
function IsUNCFileName(FileName: string): Boolean;

function GetErrorString(ErrorCode: DWORD): string;
function GetLastErrorString: string;

function CalculateCRC32(InitCRC: UInt32; var Buffer; Length: Integer): UInt32;
function GetFileCRC32(FileName: string): UInt32;

function RomanToInt(Roman: string): Integer;
function IntToRoman(Number: Integer): string;

function GetProductVersion(AFileName: string; var Ver0, Ver1, Ver2, Ver3: Word): string;

//function FileExists(const FileName: WideString): Boolean; overload;
function ClassIsRegistered(const clsid: TCLSID): Boolean;

procedure SendDebugMessage(AMessage: string);

function StartTimer: Int64;
function GetTimerInterval(AStartTime: Int64): Double;
{$ENDIF}

function SameName(const AName1, AName2: Ansistring): Boolean; overload; inline;
function SameName(const AName1, AName2: WideString): Boolean; overload; inline;
function PosChar(const AChar: AnsiChar; const AString: AnsiString; AForward: Boolean = True): Integer; overload;
function PosChar(const AChar: WideChar; const AString: WideString; AForward: Boolean = True): Integer; overload;
function TrimName(const AName: AnsiString; ANameSeparator: AnsiChar = DEF_NAMESEPARATOR): AnsiString; overload;
function TrimName(const AName: WideString; ANameSeparator: WideChar = DEF_NAMESEPARATOR): WideString; overload;
function ConcatNames(const AName1, AName2: AnsiString; ANameSeparator: AnsiChar = DEF_NAMESEPARATOR): AnsiString; overload;
function ConcatNames(const AName1, AName2: WideString; ANameSeparator: WideChar = DEF_NAMESEPARATOR): WideString; overload;
procedure ParseName(const AName: AnsiString; var ASection, AKey: AnsiString; ANameSeparator: AnsiChar = DEF_NAMESEPARATOR); overload;
procedure ParseName(const AName: WideString; var ASection, AKey: WideString; ANameSeparator: WideChar = DEF_NAMESEPARATOR); overload;
{$IFDEF DELPHI2009_UP}
procedure BackParseName(const AName: string; var AHead, ATail: string; ANameSeparator: Char = DEF_NAMESEPARATOR); overload;
{$ENDIF}
procedure BackParseName(const AName: AnsiString; var AHead, ATail: AnsiString; ANameSeparator: AnsiChar = DEF_NAMESEPARATOR); overload;
procedure BackParseName(const AName: WideString; var AHead, ATail: WideString; ANameSeparator: WideChar = DEF_NAMESEPARATOR); overload;
function MemberOfSection(const AMember, ASection: AnsiString; ATailKey: PAnsiString = nil; ANameSeparator: AnsiChar = DEF_NAMESEPARATOR): Boolean; overload;
function MemberOfSection(const AMember, ASection: WideString; ATailKey: PWideString = nil; ANameSeparator: WideChar = DEF_NAMESEPARATOR): Boolean; overload;
function NameIndex(const AName: AnsiString; ABaseName: PAnsiString = nil): Integer; overload;
function NameIndex(const AName: WideString; ABaseName: PWideString = nil): Integer; overload;
function NameDigitSuffix(const AName: AnsiString; ABaseName: PAnsiString = nil): Integer; overload;
function NameDigitSuffix(const AName: WideString; ABaseName: PWideString = nil): Integer; overload;
function TrimNameParams(const AName: AnsiString): AnsiString; overload;
function TrimNameParams(const AName: WideString): WideString; overload;
function IndexedName(const AName: AnsiString; AIndex: Integer): AnsiString; overload;
function IndexedName(const AName: WideString; AIndex: Integer): WideString; overload;
function NameSection(const AName: AnsiString; ANameKey: PAnsiString = nil; ANameSeparator: AnsiChar = DEF_NAMESEPARATOR): AnsiString; overload;
function NameSection(const AName: WideString; ANameKey: PWideString = nil; ANameSeparator: WideChar = DEF_NAMESEPARATOR): WideString; overload;
function NameKey(const AName: AnsiString; ANameSeparator: AnsiChar = DEF_NAMESEPARATOR): AnsiString; overload;
function NameKey(const AName: WideString; ANameSeparator: WideChar = DEF_NAMESEPARATOR): WideString; overload;
function IncLetterValue(const AValue: AnsiString; AIncValue: Integer = 1): AnsiString; overload;
function IncLetterValue(const AValue: WideString; AIncValue: Integer = 1): WideString; overload;
procedure CheckDecimalPoint(var AFloatText: string);
function StrToFloatEx(const AFloatText: string; const Default: Double): Double;
function TryStrToFloatEx(const AFloatText: string; const Default: Double;
  out Value: Double): Boolean;
function ExtractFileNameOnly(const AFileName: string): string;
function RemoveSubName(const AName, ASubName: WideString; ANameSeparator: WideChar): WideString;
function SubNameExists(const AName, ASubName: WideString; ANameSeparator: WideChar): Boolean;
function CompareMethod(aM1, aM2: TMethod): boolean;
function CreateTempFile: TFileName;

implementation

function CreateTempFile: TFileName;
// Creates a temporal file and returns its path name
var
  TmpDir: array [0 .. MAX_PATH - 1] of char;
  TempFileName: array [0 .. MAX_PATH - 1] of char;
begin
  GetTempPath(MAX_PATH, TmpDir);
  Result := '';
  if GetTempFileName(TmpDir, '.', 0, TempFileName) > 0 then
    Result := TempFileName;
end;
//------------------------------------------------------------------------------
{$IFNDEF FPC}
//------------------------------------------------------------------------------
function IsDelphiRunning: Boolean;
var
  ProgName: string;
begin
  ProgName := UpperCase(ParamStr(0));
  Result := (Pos('DELPHI32.EXE', ProgName) > 0) or (Pos('BDS.EXE', ProgName) > 0);
end;
//------------------------------------------------------------------------------
function GetWindowsTempPath: string;
var
  Buffer: array[0..MAX_PATH] of Char;
begin
  SetString(Result, Buffer, GetTempPath(Length(Buffer), Buffer));
end;
//------------------------------------------------------------------------------
function GetWindowsTempDir: string;
begin
  Result := ExtractFileDir(GetWindowsTempPath);
end;
//------------------------------------------------------------------------------
function GetWindowsDir: string;
var
  Buffer: array[0..MAX_PATH] of Char;
begin
  SetString(Result, Buffer, GetWindowsDirectory(Buffer, Length(Buffer)));
end;
//------------------------------------------------------------------------------
function GetSystemDir: string;
var
  Buffer: array[0..MAX_PATH] of Char;
begin
  SetString(Result, Buffer, GetSystemDirectory(Buffer, Length(Buffer)));
end;
//------------------------------------------------------------------------------
function GetComputerName: string;
var
  Buffer: array[0..MAX_COMPUTERNAME_LENGTH] of Char;
  Size: DWORD;
begin
  Size := Length(Buffer);
  FillChar(Buffer, Size * SizeOf(Char), 0);
  Windows.GetComputerName(Buffer, Size);
  SetString(Result, Buffer, Size);
end;
//------------------------------------------------------------------------------
function GetUserName: string;
var
  Buffer: array[0..255] of Char;
  Size: DWORD;
begin
  Size := Length(Buffer);
  FillChar(Buffer, Size * SizeOf(Char), 0);
  Windows.GetUserName(Buffer, Size);
  SetString(Result, Buffer, Size);
end;
//------------------------------------------------------------------------------
function GetCountryEnglishName: string;
var
  Buffer: array[0..127] of Char;
begin
  SetString(Result, Buffer,
    GetLocaleInfo(GetThreadLocale, LOCALE_SENGCOUNTRY, Buffer, Length(Buffer)));
end;
//------------------------------------------------------------------------------
function GetLocalIPAddress: AnsiString;
var
  WSAData: TWSAData;
  p: PHostEnt;
  Name: array [0..255] of AnsiChar;
begin
  WSAStartup($0101, WSAData);
  GetHostName(Name, 255);
  p := GetHostByName(Name);
  Result := (inet_ntoa(PInAddr(p^.h_addr_list^)^));
  WSACleanup;
end;
//------------------------------------------------------------------------------
{
function GetUserLanguage: string;
var
  Buffer: array[0..255] of Char;
  Size: DWORD;
begin
  GetUserGeoID(
  Size := Length(Buffer);
  Windows.GetUserName(Buffer, Size);
  SetString(Result, Buffer, Size);
end;
}
//------------------------------------------------------------------------------
function GetCurrentModuleName: string;
begin
  Result := GetModuleName(HInstance);
end;
//------------------------------------------------------------------------------
function GetCurrentModuleDir: string;
begin
  Result := ExtractFileDir(GetModuleName(HInstance));
end;
//------------------------------------------------------------------------------
function GetExeName: string;
begin
  Result := GetModuleName(MainInstance);
end;
//------------------------------------------------------------------------------
function GetExeDir: string;
begin
  Result := ExtractFileDir(GetModuleName(MainInstance));
end;
//------------------------------------------------------------------------------
function GetFullDir(ABaseDir, ARelativeDir: string): string;
var
  vOldDir: string;
begin
  vOldDir := GetCurrentDir;
  SetCurrentDir(ABaseDir);
  Result := ExpandUNCFileName(ARelativeDir);
  SetCurrentDir(vOldDir);
end;
//------------------------------------------------------------------------------
function GetWorkArea: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0);
end;
//------------------------------------------------------------------------------
function GetScreenHeight: Integer;
begin
  Result := GetSystemMetrics(SM_CYSCREEN);
end;
//------------------------------------------------------------------------------
function GetScreenWidth: Integer;
begin
  Result := GetSystemMetrics(SM_CXSCREEN);
end;
//------------------------------------------------------------------------------
function GetVirtualScreenHeight: Integer;
begin
  Result := GetSystemMetrics(SM_CYVIRTUALSCREEN);
end;
//------------------------------------------------------------------------------
function GetVirtualScreenWidth: Integer;
begin
  Result := GetSystemMetrics(SM_CXVIRTUALSCREEN);
end;
//------------------------------------------------------------------------------
function GetVirtualScreenX0: Integer;
begin
  Result := GetSystemMetrics(SM_XVIRTUALSCREEN);
end;
//------------------------------------------------------------------------------
function GetVirtualScreenY0: Integer;
begin
  Result := GetSystemMetrics(SM_YVIRTUALSCREEN);
end;
//------------------------------------------------------------------------------
function InPort8(Address: Word): Byte;
asm
        MOV     DX, Address
        IN      AL, DX
end;
//------------------------------------------------------------------------------
procedure OutPort8(Address: Word; Value: Byte);
asm
        MOV     DX, Address
        MOV     AL, Value
        OUT     DX, AL
end;
//------------------------------------------------------------------------------
function InPort16(Address: Word): Word;
asm
        MOV     DX, Address
        IN      AX, DX
end;
//------------------------------------------------------------------------------
procedure OutPort16(Address: Word; Value: Word);
asm
        MOV     DX, Address
        MOV     AX, Value
        OUT     DX, AX
end;
//------------------------------------------------------------------------------
function InPort32(Address: Word): LongWord;
asm
        MOV     DX, Address
        IN      EAX, DX
end;
//------------------------------------------------------------------------------
procedure OutPort32(Address: Word; Value: LongWord);
asm
        MOV     DX, Address
        MOV     EAX, Value
        OUT     DX, EAX
end;
//------------------------------------------------------------------------------
procedure OpenURL(URL: string);
begin
  ShellExecute(
    0,	        // handle to parent window
    nil,	// pointer to string that specifies operation to perform
    PChar(URL),	// pointer to filename or folder name string
    nil,	// pointer to string that specifies executable-file parameters
    nil,	// pointer to string that specifies default directory
    0 	        // whether file is shown when opened
   );
end;
//------------------------------------------------------------------------------
//MAPISendMail-?????????? - MAPI.hlp
procedure ShellSendMail(Addr, CC, BCC, Subject, Body: string);
begin
  ShellExecute(
    0,	        // handle to parent window
    nil,	// pointer to string that specifies operation to perform
    PChar('mailto:<' + Addr + '>?subject=<' + Subject + '>&cc=<' + cc +
      '>&bcc=<' + '>&body=<' + Body + '>'),	// pointer to filename or folder name string
    nil,	// pointer to string that specifies executable-file parameters
    nil,	// pointer to string that specifies default directory
    0    	// whether file is shown when opened
   );
end;
//------------------------------------------------------------------------------
function SendMail(From, Dest, Subject, Text, AttachFileName: AnsiString; Outlook: Boolean): Integer;
var
  MAPI_FLAG: Cardinal;
  Msg: TMapiMessage;
  Recipient, Sender: TMapiRecipDesc;
  FileAttachment: TMapiFileDesc;
begin
  FillChar(Msg, SizeOf(TMapiMessage), 0);
  if Length(From) > 0 then
  begin
    FillChar(Sender, SizeOf(Sender), 0);
    Sender.ulRecipClass := MAPI_ORIG;
    Sender.lpszAddress := PAnsiChar(From);
    Msg.lpOriginator := @Sender;
  end;
  if Length(Dest) > 0 then
  begin
    FillChar(Recipient, SizeOf(Recipient), 0);
    Recipient.ulRecipClass := MAPI_TO;
    Recipient.lpszAddress := PAnsiChar(Dest);
    Msg.nRecipCount := 1;
    Msg.lpRecips := @Recipient;
  end;
  if FileExists(string(AttachFileName)) then
  begin
    FillChar(FileAttachment, SizeOf(FileAttachment), 0);
    FileAttachment.nPosition := Cardinal(-1);
    FileAttachment.lpszPathName := PAnsiChar(AttachFileName);
    Msg.nFileCount := 1;
    Msg.lpFiles := @FileAttachment;
  end;
  if Length(Subject) > 0 then
    Msg.lpszSubject := PAnsiChar(Subject);
  if Length(Text) > 0 then
    Msg.lpszNoteText := PAnsiChar(Text);
  if Outlook then MAPI_FLAG := MAPI_DIALOG
  else MAPI_FLAG := 0;
  Result := MAPISendMail(0, 0{Application.Handle}, Msg, MAPI_FLAG, 0);
end;
//------------------------------------------------------------------------------
function GetWindowsVersionString: string;
var
  Ver: Integer;
begin
  Ver := GetWindowsVersion;
  case Ver of
    OS_WINNT:
      Result := Format('Windows NT (Version %d.%d Build %d)',
        [Win32MajorVersion, Win32MinorVersion, Win32BuildNumber]);
    OS_WIN32S:
      Result := 'Windows 3.1 with Win32S';
    OS_WINXP:
      Result := Format('Windows XP (Version %d.%d Build %d)',
        [Win32MajorVersion, Win32MinorVersion, Win32BuildNumber]);
    OS_WIN2k:
      Result := Format('Windows 2000 (Version %d.%d Build %d)',
        [Win32MajorVersion, Win32MinorVersion, Win32BuildNumber]);
    OS_WIN95:
      Result := 'Windows 95';
    OS_WIN98:
      Result := 'Windows 98';
    OS_WIN98SE:
      Result := 'Windows 98 Second Edition';
    OS_WINME:
      Result := 'Windows Millenium';
  else
    Result := 'Unknown Windows Version';
  end;
end;
//------------------------------------------------------------------------------
function GetWindowsVersion: Integer;
var
  OSVerInfo: TOSVersionInfo;
begin
  OSVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(OSVerInfo);
  case OSVerInfo.dwPlatformID of
    // Win 32s on Win3.x
    VER_PLATFORM_WIN32s: Result := OS_WIN32S;
    // Windows 9x
    VER_PLATFORM_WIN32_WINDOWS:
      case OSVerInfo.dwMinorVersion of
        0: result := OS_WIN95;
        10:
          if (OsVerInfo.szCSDVersion <> '') then
            result := OS_WIN98SE
          else
            result := OS_WIN98;
        90: result := OS_WINME;
      else
        result := OS_WIN98;
      end;
    // Windows NT
    VER_PLATFORM_WIN32_NT:
      if OSVerInfo.dwMajorVersion < 5 then
        Result := OS_WINNT
      else if (OSVerInfo.dwMajorVersion = 5) and (OSVerInfo.dwMinorVersion < 1) then
        Result := OS_WIN2k
      else
        Result := OS_WINXP;
  else
    // no idea at all
    Result := OSVerInfo.dwPlatformID;
  end;
end;
//------------------------------------------------------------------------------
function StringArrayToPCharZZ(Strings: array of string): PChar;
var
  i, Pos, Len, FullLen: Integer;
begin
  FullLen := 0;
  for i := Low(Strings) to High(Strings) do
    Inc(FullLen, (Length(Strings[i]) + 1) * SizeOf(Char));
  Inc(FullLen, SizeOf(Char));
  GetMem(Result, FullLen);
  FillChar(Result^, FullLen, 0);
  Pos := 0;
  for i := Low(Strings) to High(Strings) do
  begin
    Len := Length(Strings[i]);
    Move(PChar(Strings[i])^, (Result + Pos)^, Len * SizeOf(Char));
    Inc(Pos, (Len + 1) * SizeOf(Char));
  end;
end;
//------------------------------------------------------------------------------
{ See in JvJCLUtils
function DeleteFiles(const FileMask: string): Boolean;
var
  SearchRec: TSearchRec;
begin
  Result := SysUtils.FindFirst(ExpandFileName(FileMask), faAnyFile, SearchRec) = 0;
  try
    if Result then
      repeat
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and
          (SearchRec.Attr and faVolumeID <> faVolumeID) and
          (SearchRec.Attr and faDirectory <> faDirectory) then
        begin
          Result := SysUtils.DeleteFile(ExtractFilePath(FileMask) + SearchRec.Name);
          if not Result then
            Break;
        end;
      until SysUtils.FindNext(SearchRec) <> 0;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;
}
//------------------------------------------------------------------------------
procedure DeleteFiles(Files: array of string);
var
  FileOp: TSHFileOpStruct;
begin
  FileOp.Wnd := 0;
  FileOp.wFunc := FO_DELETE;
  FileOp.pFrom := StringArrayToPCharZZ(Files);
  FileOp.pTo := nil;
  FileOp.fFlags := FOF_MULTIDESTFILES or FOF_NOCONFIRMATION;
  FileOp.fAnyOperationsAborted := False;
  FileOp.hNameMappings := nil;
  FileOp.lpszProgressTitle := 'Deleting Files...';
  SHFileOperation(FileOp);
  ReallocMem(FileOp.pFrom, 0);
end;
//------------------------------------------------------------------------------
procedure CopyFiles(FilesFrom, FilesTo: array of string);
var
  FileOp: TSHFileOpStruct;
begin
  if Length(FilesFrom) <> Length(FilesTo) then
    Exit;
  FileOp.Wnd := 0;
  FileOp.wFunc := FO_COPY;
  FileOp.pFrom := StringArrayToPCharZZ(FilesFrom);
  FileOp.pTo := StringArrayToPCharZZ(FilesTo);
  FileOp.fFlags := FOF_MULTIDESTFILES or FOF_NOCONFIRMATION;
  FileOp.fAnyOperationsAborted := False;
  FileOp.hNameMappings := nil;
  FileOp.lpszProgressTitle := 'Copying Files...';
  SHFileOperation(FileOp);
  FreeMem(FileOp.pFrom, 0);
  FreeMem(FileOp.pTo, 0);
end;
//------------------------------------------------------------------------------
function CreateShortcut(
  Location: TShortcutType; // shortcut location
  SourceFileName: string; // the file the shortcut points to
  LinkName: string;
  SubFolder: string;  // subfolder of location (stOtherFolder)
  WorkingDir: string; // working directory property of the shortcut
  Parameters: string;
  Description: string; //  description property of the shortcut
  IconLocation: string;
  IconIndex: Integer
    ): string;
const
  SHELL_FOLDERS_ROOT = 'Software\MicroSoft\Windows\CurrentVersion\Explorer';
  QUICK_LAUNCH_ROOT = 'Software\MicroSoft\Windows\CurrentVersion\GrpConv';
var
  MyObject: IUnknown;
  MySLink: IShellLink;
  MyPFile: IPersistFile;
  Directory: string;
  WFileName: WideString;
  Reg: TRegIniFile;
begin
  MyObject := CreateComObject(CLSID_ShellLink);
  MySLink := MyObject as IShellLink;
  MyPFile := MyObject as IPersistFile;
  MySLink.SetPath(PChar(SourceFileName));
  MySLink.SetArguments(PChar(Parameters));
  MySLink.SetDescription(PChar(Description));
  if IconLocation <> '' then
    MySLink.SetIconLocation(PChar(IconLocation), IconIndex);
  if LinkName = '' then
    LinkName := ExtractFileName(SourceFileName);
  LinkName := ChangeFileExt(LinkName, '.lnk');
  // Quicklauch
  if Location = stQuickLaunch then
  begin
    Reg := TRegIniFile.Create(QUICK_LAUNCH_ROOT);
    try
      Directory := Reg.ReadString('MapGroups', 'Quick Launch', '');
    finally
      Reg.Free;
    end;
  end
  else
  // Other locations
  begin
    Reg := TRegIniFile.Create(SHELL_FOLDERS_ROOT);
    try
    case Location of
      stOtherFolder : Directory := SubFolder;
      stDesktop     : Directory := Reg.ReadString('Shell Folders', 'Desktop', '');
      stStartMenu   : Directory := Reg.ReadString('Shell Folders', 'Start Menu', '');
      stSendTo      : Directory := Reg.ReadString('Shell Folders', 'SendTo', '');
    end;
    finally
      Reg.Free;
    end;
  end;
  if Directory <> '' then
  begin
    if (SubFolder <> '') and (Location <> stOtherFolder) then
      WFileName := Directory + '\' + SubFolder + '\' + LinkName
    else
      WFileName := Directory + '\' + LinkName;
    if WorkingDir = '' then
      MySLink.SetWorkingDirectory(PChar(ExtractFilePath(SourceFileName)))
    else
      MySLink.SetWorkingDirectory(PChar(WorkingDir));
    MyPFile.Save(PWChar(WFileName), False);
    Result := WFileName;
  end;
end;
{$ENDIF}
//------------------------------------------------------------------------------
procedure ShowMessage(const Text: string; const Caption: string; const Flags: UINT);
begin
  MessageBox(0, PChar(Text), PChar(Caption), MB_TASKMODAL or Flags);
end;
//------------------------------------------------------------------------------
procedure ShowMessage(Text: PChar);
begin
  MessageBox(0, Text, '', MB_TASKMODAL);
end;
//------------------------------------------------------------------------------
function MessageDlg(const Text: string; Flags: DWORD; const Caption: string): Integer;
begin
  Result := MessageBox(0, PChar(Text), PChar(Caption), MB_TASKMODAL or Flags);
end;
//------------------------------------------------------------------------------
procedure OutDebug(const AFormat: string; const Args: array of const);
begin
  OutputDebugString(PChar(Format(AFormat, Args)));
end;
//------------------------------------------------------------------------------
procedure ShowError(const AFormat: string; const Args: array of const);
var
  Text: string;
begin
  Text := Format(AFormat, Args);
  OutputDebugString(PChar(Text));
  ShowMessage(Text, 'Error', MB_ICONERROR);
end;
{$IFNDEF FPC}
//------------------------------------------------------------------------------
function IsUNCFileName(FileName: string): Boolean;
begin
  Result := Pos('\\', FileName) = 1;
end;
//------------------------------------------------------------------------------
function GetErrorString(ErrorCode: DWORD): string;
var
  lpMsgBuf: LPTSTR;
begin
  if InRange(ErrorCode, INTERNET_ERROR_BASE, INTERNET_ERROR_LAST) then
  begin
    FormatMessage(
      FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_HMODULE,
      Pointer(GetModuleHandle('wininet.dll')),
      ErrorCode,
      LANG_USER_DEFAULT,
      @lpMsgBuf,
      256,
      nil);
{
    IntErrorLen := 0;
    if not InternetGetLastResponseInfo(IntErrorCode, nil, IntErrorLen) then
      showmessage(getlasterrorstring);
    lpMsgBuf := LPTSTR(LocalAlloc(LPTR, IntErrorLen));
    InternetGetLastResponseInfo(IntErrorCode, lpMsgBuf, IntErrorLen);
}
  end
  else
  FormatMessage(
    FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM or
    FORMAT_MESSAGE_IGNORE_INSERTS,
    nil,
    ErrorCode,
    LANG_USER_DEFAULT,
    @lpMsgBuf,
    0,
    nil);
  if lpMsgBuf <> nil then
    SetString(Result, lpMsgBuf, StrLen(lpMsgBuf) - 2)
  else
    Result := '';
  LocalFree(HLOCAL(lpMsgBuf));
end;
//------------------------------------------------------------------------------
function GetLastErrorString: string;
begin
  Result := GetErrorString(GetLastError);
end;
//------------------------------------------------------------------------------
function CalculateCRC32(InitCRC: UInt32; var Buffer; Length: Integer): UInt32;
const
  Crc32Tab: array[0..255] of UInt32 = (
    $00000000, $77073096, $ee0e612c, $990951ba, $076dc419, $706af48f,
    $e963a535, $9e6495a3, $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988,
    $09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91, $1db71064, $6ab020f2,
    $f3b97148, $84be41de, $1adad47d, $6ddde4eb, $f4d4b551, $83d385c7,
    $136c9856, $646ba8c0, $fd62f97a, $8a65c9ec, $14015c4f, $63066cd9,
    $fa0f3d63, $8d080df5, $3b6e20c8, $4c69105e, $d56041e4, $a2677172,
    $3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b, $35b5a8fa, $42b2986c,
    $dbbbc9d6, $acbcf940, $32d86ce3, $45df5c75, $dcd60dcf, $abd13d59,
    $26d930ac, $51de003a, $c8d75180, $bfd06116, $21b4f4b5, $56b3c423,
    $cfba9599, $b8bda50f, $2802b89e, $5f058808, $c60cd9b2, $b10be924,
    $2f6f7c87, $58684c11, $c1611dab, $b6662d3d, $76dc4190, $01db7106,
    $98d220bc, $efd5102a, $71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433,
    $7807c9a2, $0f00f934, $9609a88e, $e10e9818, $7f6a0dbb, $086d3d2d,
    $91646c97, $e6635c01, $6b6b51f4, $1c6c6162, $856530d8, $f262004e,
    $6c0695ed, $1b01a57b, $8208f4c1, $f50fc457, $65b0d9c6, $12b7e950,
    $8bbeb8ea, $fcb9887c, $62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65,
    $4db26158, $3ab551ce, $a3bc0074, $d4bb30e2, $4adfa541, $3dd895d7,
    $a4d1c46d, $d3d6f4fb, $4369e96a, $346ed9fc, $ad678846, $da60b8d0,
    $44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9, $5005713c, $270241aa,
    $be0b1010, $c90c2086, $5768b525, $206f85b3, $b966d409, $ce61e49f,
    $5edef90e, $29d9c998, $b0d09822, $c7d7a8b4, $59b33d17, $2eb40d81,
    $b7bd5c3b, $c0ba6cad, $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a,
    $ead54739, $9dd277af, $04db2615, $73dc1683, $e3630b12, $94643b84,
    $0d6d6a3e, $7a6a5aa8, $e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1,
    $f00f9344, $8708a3d2, $1e01f268, $6906c2fe, $f762575d, $806567cb,
    $196c3671, $6e6b06e7, $fed41b76, $89d32be0, $10da7a5a, $67dd4acc,
    $f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5, $d6d6a3e8, $a1d1937e,
    $38d8c2c4, $4fdff252, $d1bb67f1, $a6bc5767, $3fb506dd, $48b2364b,
    $d80d2bda, $af0a1b4c, $36034af6, $41047a60, $df60efc3, $a867df55,
    $316e8eef, $4669be79, $cb61b38c, $bc66831a, $256fd2a0, $5268e236,
    $cc0c7795, $bb0b4703, $220216b9, $5505262f, $c5ba3bbe, $b2bd0b28,
    $2bb45a92, $5cb36a04, $c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d,
    $9b64c2b0, $ec63f226, $756aa39c, $026d930a, $9c0906a9, $eb0e363f,
    $72076785, $05005713, $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38,
    $92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21, $86d3d2d4, $f1d4e242,
    $68ddb3f8, $1fda836e, $81be16cd, $f6b9265b, $6fb077e1, $18b74777,
    $88085ae6, $ff0f6a70, $66063bca, $11010b5c, $8f659eff, $f862ae69,
    $616bffd3, $166ccf45, $a00ae278, $d70dd2ee, $4e048354, $3903b3c2,
    $a7672661, $d06016f7, $4969474d, $3e6e77db, $aed16a4a, $d9d65adc,
    $40df0b66, $37d83bf0, $a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9,
    $bdbdf21c, $cabac28a, $53b39330, $24b4a3a6, $bad03605, $cdd70693,
    $54de5729, $23d967bf, $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94,
    $b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d
    );
begin
  asm
         PUSH   ESI
         PUSH   EDI
         PUSH   EAX
         PUSH   EBX
         PUSH   ECX
         PUSH   EDX
         LEA    EDI, Crc32Tab
         MOV    ESI, Buffer
         MOV    AX, WORD PTR InitCRC
         MOV    DX, WORD PTR InitCRC + 2
         MOV    ECX, Length
         OR     ECX, ECX
         JZ     @@done
@@loop:
         XOR    EBX, EBX
         MOV    BL, AL
         LODSB
         XOR    BL, AL
         MOV    AL, AH
         MOV    AH, DL
         MOV    DL, DH
         XOR    DH, DH
         SHL    BX, 1
         SHL    BX, 1
         ADD    EBX, EDI
         XOR    AX, [EBX]
         XOR    DX, [EBX + 2]
         LOOP   @@loop
@@done:
         MOV    WORD PTR Result, AX
         MOV    WORD PTR Result + 2, DX
         POP    EDX
         POP    ECX
         POP    EBX
         POP    EAX
         POP    EDI
         POP    ESI
  end;
end;
//------------------------------------------------------------------------------
function GetFileCRC32(FileName: string): UInt32;
var
  FHandle, FSize: Integer;
  p: Pointer;
begin
  Result := $FFFFFFFF;
  FHandle := FileOpen(FileName, fmOpenRead or fmShareDenyWrite);
//  FHandle := Integer(CreateFile(PChar(FileName),
//    GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0));
  if FHandle = -1 then Exit;
  try
    FSize := FileSeek(FHandle, 0, FILE_END);
    if FSize <> 0 then
    begin
      GetMem(p, FSize);
      try
        FileSeek(FHandle, 0, FILE_BEGIN);
        FileRead(FHandle, p^, FSize);
        Result := CalculateCRC32(Result, p^, FSize);
      finally
        FreeMem(p, FSize);
      end;
      Result := not Result;
    end;
  finally
    FileClose(FHandle);
  end;
end;
//------------------------------------------------------------------------------
function RomanToInt(Roman: string): Integer;
  function Valueof(ch: Char): Integer;
  begin
    case ch of
      'I': Valueof := 1;
      'V': Valueof := 5;
      'X': Valueof := 10;
      'L': Valueof := 50;
      'C': Valueof := 100;
      'D': Valueof := 500;
      'M': Valueof := 1000;
    else
      Valueof := -1;
    end;
  end; { Valueof }

  function AFive(ch: Char): Boolean; { Returns True if ch = 5,50,500 }
  begin
    AFive := CharInSet(ch, ['V', 'L', 'D']);
  end; { AFive }

var
  Position: Byte;
  TheValue, CurrentValue: Integer;
  HighestPreviousValue: Integer;
begin
  Position := Length(Roman); { Initialize all Variables }
  TheValue := 0;
  HighestPreviousValue := Valueof(Roman[Position]);
  while Position > 0 do
  begin
    CurrentValue := Valueof(Roman[Position]);
    if CurrentValue < 0 then
    begin
      RomantoInt := -1;
      Exit;
    end;
    if CurrentValue >= HighestPreviousValue then
    begin
      TheValue := TheValue + CurrentValue;
      HighestPreviousValue := CurrentValue;
    end
    else
    begin { if the digit precedes something larger }
      if AFive(Roman[Position]) then
      begin
        result := -1; { A five digit can't precede anything }
        Exit;
      end;
      if HighestPreviousValue div CurrentValue > 10 then
      begin
        Result := -1; { e.g. 'XM', 'IC', 'XD'... }
        Exit;
      end;
      TheValue := TheValue - CurrentValue;
    end;
    Dec(Position);
  end;
  result := TheValue;
end;
//------------------------------------------------------------------------------
function IntToRoman(Number: Integer): string;
var
  TempStr: string; { Temporary storage for the result string }
begin
  TempStr := '';
  if (Number > 0) and (Number < 4000) then
  begin
    { One 'M' for every 1000 }
    TempStr := Copy('MMM', 1, Number div 1000);
    Number := Number mod 1000;
    if Number >= 900 then
    { Number >= 900, so append 'CM' }
    begin
      TempStr := TempStr + 'CM';
      Number := Number - 900;
    end
    else
    { Number < 900 }
    begin
      if Number >= 500 then
      { Number >= 500, so append 'D' }
      begin
        TempStr := TempStr + 'D';
        Number := Number - 500;
      end
      else
        if Number >= 400 then
        { 400 <= Number < 500, so append 'CD' }
        begin
          TempStr := TempStr + 'CD';
          Number := Number - 400;
        end;
      { Now Number < 400!!! One 'C' for every 100 }
      TempStr := TempStr + Copy('CCC', 1, Number div 100);
      Number := Number mod 100;
    end;
    if Number >= 90 then
    { Number >= 90, so append 'XC' }
    begin
      TempStr := TempStr + 'XC';
      Number := Number - 90;
    end
    else
    { Number < 90 }
    begin
      if Number >= 50 then
      { Number >= 50, so append 'L'}
      begin
        TempStr := TempStr + 'L';
        Number := Number - 50;
      end
      else
        if Number >= 40 then
        { 40 <= Number < 50, so append 'XL' }
        begin
          TempStr := TempStr + 'XL';
          Number := Number - 40;
        end;
      { Now Number < 40!!! One 'X' for every 10 }
      TempStr := TempStr + Copy('XXX', 1, Number div 10);
      Number := Number mod 10;
    end;
    if Number = 9 then
    { Number = 9, so append 'IX' }
    begin
      TempStr := TempStr + 'IX';
    end
    else
    { Number < 9 }
    begin
      if Number >= 5 then
      { Number >= 5, so append 'V' }
      begin
        TempStr := TempStr + 'V';
        Number := Number - 5;
      end
      else
        if Number = 4 then
        { Number = 4, so append 'IV' }
        begin
          TempStr := TempStr + 'IV';
          Number := Number - 4;
        end;
      { Now Number < 4!!! One 'I' for every 1 }
      TempStr := TempStr + Copy('III', 1, Number);
    end;
  end;
  Result := TempStr;
end;
//------------------------------------------------------------------------------
function GetProductVersion(AFileName: string; var Ver0, Ver1, Ver2, Ver3: Word): string;
var
  FileName: string;
  pInfo: Pointer;
  pFI: PVSFixedFileInfo;
  InfoSize, Wnd, FISize: DWORD;
begin
  Result := '';
  FileName := AFileName;
  UniqueString(FileName);
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(pInfo, InfoSize);
    GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, pInfo);
    VerQueryValue(pInfo, '\', Pointer(pFI), FISize);
    Ver0 := (pFI^.dwProductVersionMS shr 16) and $ffff;
    Ver1 := pFI^.dwProductVersionMS and $ffff;
    Ver2 := (pFI^.dwProductVersionLS shr 16) and $ffff;
    Ver3 := pFI^.dwProductVersionLS and $ffff;
    Result := Format('%d.%d.%d.%d', [Ver0, Ver1, Ver2, Ver3]);
{
    with pFI^ do
    ShowMessage(Format(
      'dwSignature = %X'+ CrLf +
      'dwSignature = %X'+ CrLf +
      'dwStrucVersion = %X'+ CrLf +
      'dwFileVersionMS = %X'+ CrLf +
      'dwFileVersionLS = %X'+ CrLf +
      'dwProductVersionMS = %X'+ CrLf +
      'dwProductVersionLS = %X'+ CrLf +
      'dwFileFlagsMask = %X'+ CrLf +
      'dwFileFlags = %X'+ CrLf +
      'dwFileOS = %X'+ CrLf +
      'dwFileType = %X'+ CrLf +
      'dwFileSubtype = %X'+ CrLf +
      'dwFileDateMS = %d'+ CrLf +
      'dwFileDateLS = %d'+ CrLf,
      [
      dwSignature,
      dwSignature,
      dwStrucVersion,
      dwFileVersionMS,
      dwFileVersionLS,
      dwProductVersionMS,
      dwProductVersionLS,
      dwFileFlagsMask,
      dwFileFlags,
      dwFileOS,
      dwFileType,
      dwFileSubtype,
      dwFileDateMS,
      dwFileDateLS]
      ));
}
    FreeMem(pInfo);
  end;
end;
//------------------------------------------------------------------------------
{
function FileExists(const FileName: WideString): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributesW(PWideChar(FileName));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code = 0);
end;
}
//------------------------------------------------------------------------------
function ClassIsRegistered(const clsid: TCLSID): Boolean;
var
  OleStr: POleStr;
  Reg: TRegIniFile;
  Key, Filename: WideString;
begin
  // First, check to see if there is a ProgID.  This will tell if the
  // control is registered on the machine.  No ProgID, control won't run
  Result := ProgIDFromCLSID(clsid, OleStr) = S_OK;
  if not Result then Exit;  //Bail as soon as anything goes wrong.

  // Next, make sure that the file is actually there by rooting it out
  // of the registry
  Key := WideFormat('\SOFTWARE\Classes\CLSID\%s', [GUIDToString(clsid)]);
  Reg := TRegIniFile.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Result := Reg.OpenKeyReadOnly(Key);
    if not Result then Exit; // Bail as soon as anything goes wrong.

    FileName := Reg.ReadString('InProcServer32', '', EmptyStr);
    if (Filename = EmptyStr) then // try another key for the file name
    begin
      FileName := Reg.ReadString('InProcServer', '', EmptyStr);
    end;
    Result := Filename <> EmptyStr;
    if not Result then Exit;
    Result := FileExists(Filename);
  finally
    Reg.Free;
  end;
end;
//------------------------------------------------------------------------------
procedure SendDebugMessage(AMessage: string);
begin
  OutputDebugString(PChar(Format('[%.8X] %s'#10, [GetCurrentProcessId, AMessage])));
end;
//------------------------------------------------------------------------------
function StartTimer: Int64;
begin
  QueryPerformanceCounter(Result);
end;
//------------------------------------------------------------------------------
function GetTimerInterval(AStartTime: Int64): Double;
var
  vCurTime, vFreq: Int64;
begin
  QueryPerformanceFrequency(vFreq);
  QueryPerformanceCounter(vCurTime);
  Result := (((vCurTime - AStartTime) * 1000) div vFreq) / 1000.0;
end;
{$ENDIF}
//------------------------------------------------------------------------------
function SameName(const AName1, AName2: AnsiString): Boolean;
begin
  Result := AnsiSameText(string(AName1), string(AName2));
end;
//------------------------------------------------------------------------------
function SameName(const AName1, AName2: WideString): Boolean;
begin
  Result := WideSameText(AName1, AName2);
end;
//------------------------------------------------------------------------------
function PosChar(const AChar: AnsiChar; const AString: AnsiString;
  AForward: Boolean = True): Integer;
var
  i: Integer;
begin
  if AForward then
    Result := Pos(AChar, AString)
  else
  begin
    i := Length(AString);
    while (i > 0) and (AString[i] <> AChar) do
      Dec(i);
    Result := i;
  end;
end;
//------------------------------------------------------------------------------
function PosChar(const AChar: WideChar; const AString: WideString;
  AForward: Boolean = True): Integer;
var
  i: Integer;
begin
  if AForward then
    Result := Pos(AChar, AString)
  else
  begin
    i := Length(AString);
    while (i > 0) and (AString[i] <> AChar) do
      Dec(i);
    Result := i;
  end;
end;
//------------------------------------------------------------------------------
function TrimName(const AName: AnsiString; ANameSeparator: AnsiChar = DEF_NAMESEPARATOR): AnsiString;
var
  i, vLen: Integer;
begin
  vLen := Length(AName);
  i := 1;
  while (i <= vLen) and ((AName[i] = ANameSeparator) or (AName[i] <= ' ')) do
    Inc(i);

  if i <= vLen then
  begin
    while (vLen > i) and ((AName[vLen] = ANameSeparator) or (AName[vLen] <= ' ')) do
      Dec(vLen);
    Result := Copy(AName, i, vLen - i + 1);
  end
  else Result := '';
end;
//------------------------------------------------------------------------------
function TrimName(const AName: WideString; ANameSeparator: WideChar = DEF_NAMESEPARATOR): WideString;
var
  i, vLen: Integer;
begin
  vLen := Length(AName);
  i := 1;
  while (i <= vLen) and ((AName[i] = ANameSeparator) or (AName[i] <= ' ')) do
    Inc(i);

  if i <= vLen then
  begin
    while (vLen > i) and ((AName[vLen] = ANameSeparator) or (AName[vLen] <= ' ')) do
      Dec(vLen);
    Result := Copy(AName, i, vLen - i + 1);
  end
  else Result := '';
end;
//------------------------------------------------------------------------------
function ConcatNames(const AName1, AName2: AnsiString;  ANameSeparator: AnsiChar = DEF_NAMESEPARATOR): AnsiString;
begin
  Result := TrimName(TrimName(AName1, ANameSeparator) + ANameSeparator + TrimName(AName2, ANameSeparator), ANameSeparator);
end;
//------------------------------------------------------------------------------
function ConcatNames(const AName1, AName2: WideString;  ANameSeparator: WideChar = DEF_NAMESEPARATOR): WideString;
begin
  Result := TrimName(TrimName(AName1, ANameSeparator) + ANameSeparator + TrimName(AName2, ANameSeparator), ANameSeparator);
end;
//------------------------------------------------------------------------------
procedure ParseName(const AName: AnsiString; var ASection, AKey: AnsiString;  ANameSeparator: AnsiChar = DEF_NAMESEPARATOR);
var
  i: Integer;
begin
  ASection := TrimName(AName, ANameSeparator);
  i := PosChar(ANameSeparator, ASection, False);
  if i > 0 then
  begin
    AKey := Copy(ASection, i + 1, Length(ASection) - i);
    SetLength(ASection, i - 1);
  end
  else
  begin
    AKey := ASection;
    ASection := '';
  end;
end;
//------------------------------------------------------------------------------
procedure ParseName(const AName: WideString; var ASection, AKey: WideString; ANameSeparator: WideChar = DEF_NAMESEPARATOR);
var
  i: Integer;
begin
  ASection := TrimName(AName, ANameSeparator);
  i := PosChar(ANameSeparator, ASection, False);
  if i > 0 then
  begin
    AKey := Copy(ASection, i + 1, Length(ASection) - i);
    SetLength(ASection, i - 1);
  end
  else
  begin
    AKey := ASection;
    ASection := '';
  end;
end;
//------------------------------------------------------------------------------
{$IFDEF DELPHI2009_UP}
procedure BackParseName(const AName: string; var AHead, ATail: string;  ANameSeparator: Char = DEF_NAMESEPARATOR);
var
  i: Integer;
begin
  AHead := TrimName(AName, ANameSeparator);
  i := PosChar(ANameSeparator, AHead, True);
  if i > 0 then
  begin
    ATail := Copy(AHead, i + 1, Length(AHead) - i);
    SetLength(AHead, i - 1);
  end
  else
    ATail := '';
end;
{$ENDIF}
//------------------------------------------------------------------------------
procedure BackParseName(const AName: AnsiString; var AHead, ATail: AnsiString;
  ANameSeparator: AnsiChar = DEF_NAMESEPARATOR);
var
  i: Integer;
begin
  AHead := TrimName(AName, ANameSeparator);
  i := PosChar(ANameSeparator, AHead, True);
  if i > 0 then
  begin
    ATail := Copy(AHead, i + 1, Length(AHead) - i);
    SetLength(AHead, i - 1);
  end
  else
    ATail := '';
end;
//------------------------------------------------------------------------------
procedure BackParseName(const AName: WideString; var AHead, ATail: WideString;
  ANameSeparator: WideChar = DEF_NAMESEPARATOR);
var
  i: Integer;
begin
  AHead := TrimName(AName, ANameSeparator);
  i := PosChar(ANameSeparator, AHead, True);
  if i > 0 then
  begin
    ATail := Copy(AHead, i + 1, Length(AHead) - i);
    SetLength(AHead, i - 1);
  end
  else
    ATail := '';
end;
//------------------------------------------------------------------------------
function MemberOfSection(const AMember, ASection: AnsiString;
  ATailKey: PAnsiString = nil; ANameSeparator: AnsiChar = DEF_NAMESEPARATOR): Boolean;
var
  vParentSection, vKey: AnsiString;
  vSectionLen: Integer;
begin
  Result := SameName(AMember, ASection);
  if not Result then
  begin
    vSectionLen    := Length(ASection);
    vParentSection := AMember;
    if ATailKey <> nil then
      ATailKey^ := '';
    while (Length(vParentSection) > vSectionLen) and not Result do
    begin
      ParseName(vParentSection, vParentSection, vKey, ANameSeparator);
      Result := SameName(vParentSection, ASection);
      if ATailKey <> nil then
        ATailKey^ := ConcatNames(vKey, ATailKey^, ANameSeparator);
    end;
  end;
end;
//------------------------------------------------------------------------------
function MemberOfSection(const AMember, ASection: WideString;
  ATailKey: PWideString = nil; ANameSeparator: WideChar = DEF_NAMESEPARATOR): Boolean;
var
  vParentSection, vKey: WideString;
  vSectionLen: Integer;
begin
  Result := SameName(AMember, ASection);
  if not Result then
  begin
    vSectionLen    := Length(ASection);
    vParentSection := AMember;
    if ATailKey <> nil then
      ATailKey^ := '';
    while (Length(vParentSection) > vSectionLen) and not Result do
    begin
      ParseName(vParentSection, vParentSection, vKey, ANameSeparator);
      Result := SameName(vParentSection, ASection);
      if ATailKey <> nil then
        ATailKey^ := ConcatNames(vKey, ATailKey^, ANameSeparator);
    end;
  end;
end;
//------------------------------------------------------------------------------
function NameIndex(const AName: AnsiString; ABaseName: PAnsiString = nil): Integer;
var
  i: Integer;
begin
  i := PosChar(':', AName, False);
  if i > 0 then
  begin
    if ABaseName <> nil then
      ABaseName^ := Copy(AName, 1, i - 1);
    Result := StrToInt(string(Copy(AName, i + 1, Length(AName) - i)));
  end
  else
  begin
    Result := 0;
    if ABaseName <> nil then
      ABaseName^ := AName;
  end;
end;
//------------------------------------------------------------------------------
function NameIndex(const AName: WideString; ABaseName: PWideString = nil): Integer;
var
  i: Integer;
begin
  i := PosChar(':', AName, False);
  if i > 0 then
  begin
    if ABaseName <> nil then
      ABaseName^ := Copy(AName, 1, i - 1);
    Result := StrToInt(Copy(AName, i + 1, Length(AName) - i));
  end
  else
  begin
    Result := 0;
    if ABaseName <> nil then
      ABaseName^ := AName;
  end;
end;
//------------------------------------------------------------------------------
function NameDigitSuffix(const AName: AnsiString; ABaseName: PAnsiString = nil): Integer;
var
  i, vLen: Integer;
begin
  Result := 0;
  vLen   := Length(AName);
  if vLen > 0 then
  begin
    i := vLen;
    while (i > 0) and (AName[i] >= '0') and (AName[i] <= '9') do
      Dec(i);

    if i <= 0 then
      Result := StrToInt(string(AName))
    else if (i >= vLen) and (ABaseName <> nil) then
      ABaseName^ := AName
    else if i < vLen then
    begin
      if ABaseName <> nil then
        ABaseName^ := Copy(AName, 1, i);
      Result := StrToInt(string(Copy(AName, i + 1, vLen - i)));
    end;
  end;
end;
//------------------------------------------------------------------------------
function NameDigitSuffix(const AName: WideString; ABaseName: PWideString = nil): Integer;
var
  i, vLen: Integer;
begin
  Result := 0;
  vLen   := Length(AName);
  if vLen > 0 then
  begin
    i := vLen;
    while (i > 0) and (AName[i] >= '0') and (AName[i] <= '9') do
      Dec(i);

    if i <= 0 then
      Result := StrToInt(AName)
    else if (i >= vLen) and (ABaseName <> nil) then
      ABaseName^ := AName
    else if i < vLen then
    begin
      if ABaseName <> nil then
        ABaseName^ := Copy(AName, 1, i);
      Result := StrToInt(Copy(AName, i + 1, vLen - i));
    end;
  end;
end;
//------------------------------------------------------------------------------
function TrimNameParams(const AName: AnsiString): AnsiString;
begin
  Result := AName;
  NameIndex(AName, @Result);
end;
//------------------------------------------------------------------------------
function TrimNameParams(const AName: WideString): WideString;
begin
  Result := AName;
  NameIndex(AName, @Result);
end;
//------------------------------------------------------------------------------
function IndexedName(const AName: AnsiString; AIndex: Integer): AnsiString;
begin
  Result := TrimNameParams(AName) + ':' + AnsiString(IntToStr(AIndex));
end;
//------------------------------------------------------------------------------
function IndexedName(const AName: WideString; AIndex: Integer): WideString;
begin
  Result := TrimNameParams(AName) + ':' + IntToStr(AIndex);
end;
//------------------------------------------------------------------------------
function NameSection(const AName: AnsiString; ANameKey: PAnsiString = nil;
  ANameSeparator: AnsiChar = DEF_NAMESEPARATOR): AnsiString;
var
  vKey: AnsiString;
begin
  ParseName(AName, Result, vKey, ANameSeparator);
  if ANameKey <> nil then
    ANameKey^ := vKey;
end;
//------------------------------------------------------------------------------
function NameSection(const AName: WideString; ANameKey: PWideString = nil;
  ANameSeparator: WideChar = DEF_NAMESEPARATOR): WideString;
var
  vKey: WideString;
begin
  ParseName(AName, Result, vKey, ANameSeparator);
  if ANameKey <> nil then
    ANameKey^ := vKey;
end;
//------------------------------------------------------------------------------
function NameKey(const AName: AnsiString; ANameSeparator: AnsiChar = DEF_NAMESEPARATOR): AnsiString;
begin
  NameSection(AName, @Result, ANameSeparator);
end;
//------------------------------------------------------------------------------
function NameKey(const AName: WideString; ANameSeparator: WideChar = DEF_NAMESEPARATOR): WideString;
begin
  NameSection(AName, @Result, ANameSeparator);
end;
//------------------------------------------------------------------------------
const
  C_LetterDigitNumber = 26;
//------------------------------------------------------------------------------
function IncLetterValue(const AValue: AnsiString; AIncValue: Integer = 1): AnsiString;
var
  vLen, vIncVal1, vIncVal2: Integer;
  vZero: AnsiChar;
begin
  Result := '';
  vLen   := Length(AValue);
  if vLen > 0 then
  begin
    Result := Copy(AValue, 1, vLen - 1);
    vZero  := AValue[vLen];
    if vZero > 'z' then
    begin
      vZero    := 'a';
      vIncVal1 := C_LetterDigitNumber - 1 + AIncValue;
    end
    else if vZero >= 'a' then
    begin
      vIncVal1 := Ord(vZero) - Ord('a') + AIncValue;
      vZero    := 'a';
    end
    else if (vZero > 'Z') and (vZero < 'a') then
    begin
      vZero    := 'A';
      vIncVal1 := C_LetterDigitNumber - 1 + AIncValue;
    end
    else if vZero >= 'A' then
    begin
      vIncVal1 := Ord(vZero) - Ord('A') + AIncValue;
      vZero    := 'A';
    end
    else
    begin
      vZero    := 'A';
      vIncVal1 := AIncValue;
    end;

    if vIncVal1 >= (C_LetterDigitNumber + 1) * C_LetterDigitNumber then
    begin
      vIncVal2 := C_LetterDigitNumber;
      vIncVal1 := C_LetterDigitNumber - 1;
    end
    else
    begin
      vIncVal2 := vIncVal1 div C_LetterDigitNumber;
      vIncVal1 := vIncVal1 mod C_LetterDigitNumber;
    end;

    if vIncVal2 > 0 then
      Result := Result + AnsiChar(Ord(vZero) + vIncVal2 - 1);
    Result := Result + AnsiChar(Ord(vZero) + vIncVal1);
  end;
end;
//------------------------------------------------------------------------------
function IncLetterValue(const AValue: WideString; AIncValue: Integer = 1): WideString;
var
  vLen, vIncVal1, vIncVal2: Integer;
  vZero: WideChar;
begin
  Result := '';
  vLen   := Length(AValue);
  if vLen > 0 then
  begin
    Result := Copy(AValue, 1, vLen - 1);
    vZero  := AValue[vLen];
    if vZero > 'z' then
    begin
      vZero    := 'a';
      vIncVal1 := C_LetterDigitNumber - 1 + AIncValue;
    end
    else if vZero >= 'a' then
    begin
      vIncVal1 := Ord(vZero) - Ord('a') + AIncValue;
      vZero    := 'a';
    end
    else if (vZero > 'Z') and (vZero < 'a') then
    begin
      vZero    := 'A';
      vIncVal1 := C_LetterDigitNumber - 1 + AIncValue;
    end
    else if vZero >= 'A' then
    begin
      vIncVal1 := Ord(vZero) - Ord('A') + AIncValue;
      vZero    := 'A';
    end
    else
    begin
      vZero    := 'A';
      vIncVal1 := AIncValue;
    end;

    if vIncVal1 >= (C_LetterDigitNumber + 1) * C_LetterDigitNumber then
    begin
      vIncVal2 := C_LetterDigitNumber;
      vIncVal1 := C_LetterDigitNumber - 1;
    end
    else
    begin
      vIncVal2 := vIncVal1 div C_LetterDigitNumber;
      vIncVal1 := vIncVal1 mod C_LetterDigitNumber;
    end;

    if vIncVal2 > 0 then
      Result := Result + WideChar(Ord(vZero) + vIncVal2 - 1);
    Result := Result + WideChar(Ord(vZero) + vIncVal1);
  end;
end;
//------------------------------------------------------------------------------
procedure CheckDecimalPoint(var AFloatText: string);
var
  i: Integer;
begin
  if AFloatText <> '' then
  begin
    if DecimalSeparator = '.' then
      i := Pos(',', AFloatText)
    else
      i := Pos('.', AFloatText);

    if i <> 0 then
      AFloatText[i] := DecimalSeparator;
  end;
end;
//------------------------------------------------------------------------------
function StrToFloatEx(const AFloatText: string; const Default: Double): Double;
var
  s: string;
begin
  s := AFloatText;
  CheckDecimalPoint(s);
  Result := StrToFloatDef(s, Default);
end;
//------------------------------------------------------------------------------
function TryStrToFloatEx(const AFloatText: string; const Default: Double;
  out Value: Double): Boolean;
var
  s: string;
begin
  s := AFloatText;
  CheckDecimalPoint(s);
  Result := TryStrToFloat(s, Value);
  if not Result then
    Value := Default;
end;
//------------------------------------------------------------------------------
function ExtractFileNameOnly(const AFileName: string): string;
var
  vDotPos: Integer;
begin
  Result := ExtractFileName(AFileName);
  vDotPos := PosChar('.', Result, False);
  if vDotPos > 0 then
    Result := Copy(Result, 1, vDotPos - 1);
end;
//------------------------------------------------------------------------------
function RemoveSubName(const AName, ASubName: WideString; ANameSeparator: WideChar): WideString;
var
  vSubName, vTail: WideString;
begin
  if (AName <> '') and (ASubName <> '') then
  begin
    vSubName := TrimName(ASubName, ANameSeparator);
    if vSubName <> '' then
    begin
      BackParseName(AName, Result, vTail, ANameSeparator);
      if SameName(Result, vSubName) then
        Result := RemoveSubName(vTail, vSubName, ANameSeparator)
      else
        Result := ConcatNames(Result, RemoveSubName(vTail, ASubName, ANameSeparator), ANameSeparator);
    end
    else
      Result := AName;
  end
  else
    Result := AName;
end;
//------------------------------------------------------------------------------
function SubNameExists(const AName, ASubName: WideString; ANameSeparator: WideChar): Boolean;
var
  vSubName, vHead, vTail: WideString;
begin
  Result := False;
  if (AName <> '') and (ASubName <> '') then
  begin
    vSubName := TrimName(ASubName, ANameSeparator);
    if vSubName <> '' then
    begin
      BackParseName(AName, vHead, vTail, ANameSeparator);
      Result := SameName(vHead, vSubName);
      if not Result then
        Result := SubNameExists(vTail, vSubName, ANameSeparator);
    end;
  end;
end;
//------------------------------------------------------------------------------
function CompareMethod(aM1, aM2: TMethod): boolean;
begin
  Result := (aM1.Code = aM2.Code) and (aM1.Data = aM2.Data);
end;


end.
