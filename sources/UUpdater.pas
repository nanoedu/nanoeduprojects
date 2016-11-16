unit UUpdater;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinInet,  msxml, msxmldom,
  ShellApi,  IniFiles,   XMLDoc, XMLIntf, siComp, siLngLnk, ExtCtrls;

const
{$IFDEF FULL}
  AppcastUrlString ='http://ntspb.ru/support/software_manuals';//'http://downloads.ntmdt.com/windows/nanoeducator/le/appcast.php';
  InfoPageUrlString ='ntspb.ru/support/software_manuals';//'http://downloads.ntmdt.com/windows/nanoeducator/le/';
{$ELSE}
  AppcastUrlString ='http://ntspb.ru/support/software_manuals';// 'http://downloads.ntmdt.com/windows/nanoeducator/le/appcast.php';
  InfoPageUrlString ='http://ntspb.ru/support/software_manuals';//'http://downloads.ntmdt.com/windows/nanoeducator/le/';
{$ENDIF}
  ParamsSection = 'PARAMS';
  PosSection = 'POSITION';

  FLAG_ICC_FORCE_CONNECTION=1;

  WM_ThreadDoneMsg = WM_User + 8;

type

  TAppcastDownloadThread = class(TThread)
  public
    appcastString: string;
    url: string;
    parent: THANDLE;
  protected
    procedure Execute; override;
  end;

  TUpdaterForm = class(TForm)
    siLangLinked1: TsiLangLinked;
    Timer: TTimer;
    Image1: TImage;
    Panel1: TPanel;
    CurrentVersionLabel: TLabel;
    CheckAtStartup: TCheckBox;
    Labelinfo: TLabel;
    CheckInterval: TComboBox;
    InfoButton: TButton;
    NewVersionLabel: TLabel;
    DownloadButton: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonCheckUpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DownloadButtonClick(Sender: TObject);
    procedure InfoButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckAtStartupClick(Sender: TObject);
    procedure CheckIntervalChange(Sender: TObject);
  private
    flgNewVersAvalaible:boolean;
    i,count:integer;
    myVersion: string;
    appcastString: string;
    newVersionString: string;
    downloadUrl: string;
    myUrlString: string;
    myInfoFtring: string;
    updateReady: boolean;
    updateStarted: boolean;
    LastCheckDate: TDate;
    dayInterval: integer;
    downloadThread: TAppcastDownloadThread;

    { Private declarations }
    procedure CheckForUpdates;
    procedure ParseAppcastString;
    procedure ReadFromIni;
    procedure SetDefIniFileParams;
    procedure SaveToIni;
    function  GetCurrentVersion:string;
  protected
    function CompareVersions(CurrentVersion, NewVersion: string): boolean;
      virtual;
    function VersionFromFilename(name: string): string; virtual;
    function VersionFromList(a: TStringlist): string; virtual;
    function AppcastUrl: string; virtual;
    function InfoPageUrl: string; virtual;
    function iniFileName: string;
  public
    { Public declarations }
     flgDisappear:boolean;
    function HasUpdates: Boolean;
    function LatestReleaseUrl: string;
    function LatestReleaseString: string;
    function CurrentReleaseString: string;
   procedure DownloadDone(var AMessage: TMessage); message WM_ThreadDoneMsg;
  end;

var
  UpdaterForm: TUpdaterForm;

implementation

{$R *.dfm}
uses globalvar,mMain;

function DownloadURLToString(const url: string): string;
var
  hInet: HINTERNET;
  hFile: HINTERNET;
  localFile: file;
  stream: TStringStream;
  buffer: array[0..1023] of byte;
  bytesRead: DWORD;
  res:DWORD;
  outBuf: PChar;
begin
    result := '';

if  InternetCheckConnection('http://www.ntspb.ru',FLAG_ICC_FORCE_CONNECTION,0) then
begin
  stream := TStringStream.Create('');

  hInet := InternetOpen(PChar(application.title), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

  hFile := InternetOpenURL(hInet, PChar(url), nil, 0, 0, 0);

  if Assigned(hFile) then
  begin
    repeat
      InternetReadFile(hFile, @buffer, Length(buffer), bytesRead);
      stream.Write(buffer[0], bytesRead)
    until bytesRead = 0;
    stream.position := 0;
    result := stream.ReadString(65535);
    InternetCloseHandle(hFile);
  end;
  InternetCloseHandle(hInet);
  stream.free;
end
end;

procedure TAppcastDownloadThread.Execute;
begin
  appcastString := DownloadURLToString(url);
  PostMessage(Parent, WM_ThreadDoneMsg, 0, 0);
end;

function TUpdaterForm.AppcastUrl: string;
begin
  Result := myUrlString;
end;

function TUpdaterForm.InfoPageUrl: string;
begin
  Result := myInfoFtring;
end;

procedure TUpdaterForm.ButtonCheckUpClick(Sender: TObject);
begin
  //  CheckForUpdates;
end;

procedure TUpdaterForm.CheckAtStartupClick(Sender: TObject);
begin
  i:=0;
  self.alphablendvalue:=255;
  timer.Enabled:=false;
  CheckInterval.Visible := CheckAtStartup.Checked;
end;

procedure TUpdaterForm.CheckForUpdates;
begin
  if updateStarted then   Exit;

  DownloadButton.Visible := false;

  InfoButton.Visible :=true;

  LastCheckDate := now;

  updateStarted := true;
(* appcastString := DownloadURLToString(AppcastUrl);
   if appcastString = '' then
  begin
    NewVersionLabel.Caption := siLangLinked1.GetTextOrDefault('IDS_0' { 'Update error. Please try again later.' } );
  end
  else
  begin
    ParseAppcastString;
    if CompareVersions(myVersion, newVersionString) then
    begin
      NewVersionLabel.Caption := siLangLinked1.GetTextOrDefault('IDS_1' { 'Available new version: ' } ) + newVersionString;
      DownloadButton.Visible := true;
      InfoButton.Visible := true;
    end
    else
    begin
      NewVersionLabel.Caption := siLangLinked1.GetTextOrDefault('IDS_2' { 'You have the latest version' } );
 //     DownloadButton.Visible := true;   //   close;
      InfoButton.Visible := true;
    end;
  end;
*)
  downloadThread := TAppcastDownloadThread.Create(true);
  downloadThread.url := AppcastUrl;
  downloadThread.parent := handle;
  downloadThread.Resume;
end;

procedure TUpdaterForm.DownloadDone(var AMessage: TMessage);
begin
 appcastString:='';
if assigned(downloadThread) then
  begin
  appcastString := downloadThread.appcastString;
  FreeAndnil(downloadThread);
  end;
  updateStarted := false;

  if appcastString = '' then
  begin
    NewVersionLabel.Caption := siLangLinked1.GetTextOrDefault('IDS_0' (* 'Update error. Please try again later.' *) );
  end
  else
  begin
    ParseAppcastString;
    if flgNewVersAvalaible{CompareVersions(myVersion, newVersionString)} then
    begin
      NewVersionLabel.Caption := siLangLinked1.GetTextOrDefault('IDS_1' (* 'Available new version: ' *) ) + newVersionString;
      DownloadButton.Visible := true;
      InfoButton.Visible := true;
      if not Visible then Show;
    end
    else
    begin
      NewVersionLabel.Caption := siLangLinked1.GetTextOrDefault('IDS_2' (* 'You have the latest version' *) );
       // close;
    end;
  end;
end;

procedure TUpdaterForm.CheckIntervalChange(Sender: TObject);
begin
 i:=0;    self.alphablendvalue:=255;
timer.Enabled:=false;
  case CheckInterval.itemindex of
    0: dayInterval := 0;
    1: dayInterval := 1;
    2: dayInterval := 7;
    3: dayInterval := 30;
  end;
end;

procedure Split(const Delimiter: Char;  Input: string;  const Strings: TStrings);
begin
  Assert(Assigned(Strings));
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

function TUpdaterForm.VersionFromList(a: TStringlist): string;
begin
  while A.Count < 4 do
    a.Add('0');
  Result := a[0] + '.' + a[1] + '.' + a[2] + '.' + a[3];
end;

function TUpdaterForm.VersionFromFilename(name: string): string;
var
  A: TStringList;

begin
  A := TStringList.Create;
  name := ChangeFileExt(ExtractFileName(name), '');
  Split('-', name, A);
  if A.Count > 0 then
    Split('.', a[1], A)
  else
    a.Clear;
  result := VersionFromList(a);

  a.free;
end;

procedure TUpdaterForm.ParseAppcastString;
var
  FXMLDoc: IXMLDOMDocument;
  items, children: IXMLDOMNodeList;
  attributes: IXMLDOMNamedNodeMap;
  item, child: IXMLDOMNode;
  i, j, count, num: integer;
  filename, fileurl: string;
  tempversion: string;
  lversion: string;
begin

  FXMLDoc := CreateDOMDocument;
  FXMLDoc.validateOnParse := False;
  FXMLDoc.loadXML(appcastString);

  items := FXMLDoc.selectNodes('//channel/item');
  count := items.length;

  lversion := myVersion;

  for I := 0 to count - 1 do
  begin
    item := items[i];
    children := item.childNodes;
    num := children.length;
    filename := '';
    fileurl := '';
    for j := 0 to num - 1 do
    begin
      child := children[j];
      if child.nodeName = 'title' then
        filename := child.text;

      if child.nodeName = 'enclosure' then
      begin
        attributes := child.attributes;
        fileurl := attributes.getNamedItem('url').nodeValue;
      end;
    end;
   if   (Pos('nanoedu-' ,filename)<>0) then
   begin
    tempversion := VersionFromFilename(filename);
    if CompareVersions(lversion, tempversion) then
    begin
      lversion := tempversion;
      downloadUrl := fileurl;
       flgNewVersAvalaible:=true;
    end;
   end;
   if   (Pos('updates-' ,filename)<>0) then
   begin
     lversion := myVersion;
    tempversion := VersionFromFilename(filename);
    if CompareVersions(lversion, tempversion) then
    begin
      lversion := tempversion;
      downloadUrl := fileurl;
       flgNewVersAvalaible:=true;
    end;
   end;
   end;  //i

  newVersionString := lversion;
end;

function TUpdaterForm.CurrentReleaseString: string;
begin

  Result := myVersion;
end;

procedure TUpdaterForm.DownloadButtonClick(Sender: TObject);
begin
timer.Enabled:=false;
i:=0;
self.alphablendvalue:=255;
ShellExecute(self.WindowHandle, 'open', PChar(downloadUrl), nil, nil,SW_SHOWNORMAL);
end;

function TUpdaterForm.CompareVersions(CurrentVersion, NewVersion: string):  Boolean;
var
  a1, a2: TStringList;
  i,ia2,ia1: integer;

  procedure TrimZero(a: TStringList);
  var
    i, j: integer;
    len: integer;
    s: string;
  begin
    for i := 0 to a.Count - 1 do
    begin
      s := a[i];
      len := length(s);

      j := 1;
      while (j < len) and (s[j] = '0') do
        Inc(j);

      if (j <> 1) then
        a[i] := copy(s, j, len - j + 1);
    end;
  end;

begin
  a1 := TStringList.Create;
  a2 := TStringList.Create;
  Split('.', CurrentVersion, a1);  //current
  Split('.', NewVersion, a2);  //internet
  TrimZero(a1);
  TrimZero(a2);

  Result := false;   //your not latest
   i := 0;

  while i < a1.count do
  begin
    ia2:= strtoint(a2[i]);
    ia1:= strtoint(a1[i]);

    if  ia1< ia2  then begin Result := true; break end
    else
      if  ia1> ia2  then begin Result := false; break end;
    inc(i)
  end;
  (*
  i := 0;
  while i < a1.count do
  begin
    if ((i >= a2.count) and (a1[i] <> '0')) then
      break;

    if ((i < a2.count) and (a1[i] < a2[i])) then
    begin
      Result := true;
      break;
    end;
    Inc(I);
  end;
*)
  a1.free;
  a2.free;

  //result:=   NewVersion>CurrentVersion;
end;

function TUpdaterForm.GetCurrentversion:string;
var
  VInfoSize, DetSize: DWord;
  pVInfo, pDetail: Pointer;
begin
result:='';
  VInfoSize := GetFileVersionInfoSize (
    PChar (ParamStr (0)), DetSize);
  if VInfoSize > 0 then
  begin
    GetMem (pVInfo, VInfoSize);
    try
       GetFileVersionInfo (PChar (ParamStr (0)), 0,
         VInfoSize, pVInfo);
       // show the fixed information
       VerQueryValue (pVInfo, '\', pDetail, DetSize);
       with TVSFixedFileInfo (pDetail^) do
       begin
       result:=result+  IntToStr (HiWord (dwFileVersionMS))+'.'+
           IntToStr (LoWord (dwFileVersionMS))+'.';
        result:=result+  IntToStr (HiWord (dwFileVersionLS))+'.'+
           IntToStr (LoWord (dwFileVersionLS));
       end;
     finally
      FreeMem (pVInfo);
    end;
  end;
 end;

procedure TUpdaterForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  if  assigned(downloadThread)then   FreeAndnil(downloadThread);
  timer.Enabled:=false;
  SaveToIni;
  Action:=caFree;
  UpdaterForm:=nil;
end;
procedure TUpdaterForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if  assigned(downloadThread)then   FreeAndnil(downloadThread);
end;

procedure TUpdaterForm.SetDefIniFileParams;
begin
    Left :=20;
    Top :=100 ;

    myUrlString :=Lowercase(AppcastUrlString);
    myInfoFtring :=Lowercase( InfoPageUrlString);
    CheckAtStartup.Checked := false;//true;       //10/02/13
    dayInterval :=  30;

    if dayInterval >= 30     then      CheckInterval.ItemIndex := 3
    else if dayInterval >= 7 then      CheckInterval.ItemIndex := 2
    else if dayInterval >= 1 then      CheckInterval.ItemIndex := 1
                             else      CheckInterval.ItemIndex := 0;

    LastCheckDate := StrToDateTime(DateTimeToStr(now));
    SaveToIni;
end;

procedure TUpdaterForm.FormCreate(Sender: TObject);
const
  InfoNum = 11;
  InfoStr: array[1..InfoNum] of string =
  ('CompanyName', 'FileDescription', 'FileVersion',
    'InternalName', 'LegalCopyright', 'LegalTradeMarks',
    'OriginalFilename', 'ProductName', 'ProductVersion',
    'Comments', 'Author');
var
  flg:boolean;
  version: Cardinal;
  myname: array[0..255] of Char;
  Buf: PChar;
  j: integer;
  n, len: cardinal;
  Value: PChar;
  A: TStringList;
begin
  count:=0;    i:=0;   flgDisappear:=true;   flgNewVersAvalaible:=false;
  if flgAdmin then labelinfo.Visible:=false;
  if sLanguage='RUS' then if sLanguage='RUS' then
                     begin
                        siLanglinked1.ActiveLanguage:=2;
                     end
                     else
                     begin
                        siLanglinked1.ActiveLanguage:=1;
                     end;
  CurrentVersionLabel.Caption := siLangLinked1.GetTextOrDefault('IDS_19' (* 'CurrentVersion is: ' *) ) + myVersion;
  updateStarted := false;
  myVersion:=GetCurrentversion;
  CurrentVersionLabel.Caption := siLangLinked1.GetTextOrDefault('IDS_19' (* 'CurrentVersion is: ' *) ) + myVersion;
 (*  GetModuleFileName(MainInstance, myname, Length(myname));
  version := GetFileVersion(myname);
  n := GetFileVersionInfoSize(myname, n);
  GetMem(Buf, n);
  GetFileVersionInfo(myname, 0, n, Buf);

  if VerQueryValue(Buf, PChar('StringFileInfo\040904E4\' +
    InfoStr[3]), Pointer(Value), Len) then
  begin
    A := TStringList.Create;
    Split('.', value, a);
    myVersion := VersionFromList(a);
    A.free;
    CurrentVersionLabel.Caption := siLangLinked1.GetTextOrDefault('IDS_19' { 'CurrentVersion is: ' } ) + myVersion;
  end;
  FreeMem(Buf);
*)
  ReadFromIni;
  CheckAtStartupClick(self);
//  flg:=    HasUpdates;
 if CheckAtStartup.Checked and (now - LastCheckDate > dayInterval) {and flg } then  Show;
end;

procedure TUpdaterForm.FormShow(Sender: TObject);
begin
  alphablendvalue:=255;
  NewVersionLabel.Caption := siLangLinked1.GetTextOrDefault('IDS_22' (* 'Checking for updates' *) );
  CheckForUpdates;
  Timer.Enabled:=true;
end;

procedure TUpdaterForm.InfoButtonClick(Sender: TObject);
begin
 timer.Enabled:=false;
 self.alphablendvalue:=255;
  flgDisappear:=false;
 ShellExecute(self.WindowHandle, 'open', PChar(InfoPageUrl), nil, nil,SW_SHOWNORMAL);
end;

function TUpdaterForm.HasUpdates: Boolean;
begin
  if updateReady then    result := true
  else
  begin
    CheckForUpdates;
//   while   updateStarted  do  application.processmessages;
//    updateReady := CompareVersions(myVersion, newVersionString);
//    result := updateReady;
  end;
end;

function TUpdaterForm.LatestReleaseString: string;
begin
  result := newVersionString;
end;

function TUpdaterForm.LatestReleaseUrl: string;
begin

  result := downloadUrl;
end;

function TUpdaterForm.iniFileName: string;
begin
  Result :=UpdatesIniFilePath{ExeFilePath}+UpdatesInifile{'spmupdates.ini'};// IniGetFormName(True, iniUpdaterForm);
end;

procedure TUpdaterForm.ReadFromIni;
var
 IniFile: TIniFile;
begin
 if fileexists(iniFileName) then
 begin
   IniFile := TIniFile.Create(iniFileName);
  try
    Left := IniFile.ReadInteger(PosSection, 'Left', Left);
    Top := IniFile.ReadInteger(PosSection, 'Top', Top);
    myUrlString :=Lowercase(AppcastUrlString);// Lowercase(IniFile.ReadString(ParamsSection, 'AppcastURL', AppcastUrlString));
    myInfoFtring :=Lowercase(InfoPageUrlString);// Lowercase(IniFile.ReadString(ParamsSection, 'InfoURL', InfoPageUrlString));
    CheckAtStartup.Checked := IniFile.ReadInteger(ParamsSection, 'UpdateAtStart', 0)
      <> 0;
    dayInterval := IniFile.ReadInteger(ParamsSection, 'CheckInterval', 0);

    if dayInterval >= 30 then
      CheckInterval.ItemIndex := 3
    else if dayInterval >= 7 then
      CheckInterval.ItemIndex := 2
    else if dayInterval >= 1 then
      CheckInterval.ItemIndex := 1
    else
      CheckInterval.ItemIndex := 0;

    LastCheckDate := StrToDateTime(IniFile.ReadString(ParamsSection,
      'LastTimeChecked', DateTimeToStr(now)));
  finally
    IniFile.Free;
  end;
 end
  else  SetDefIniFileParams;
end;

procedure TUpdaterForm.SaveToIni;
var
  IniFile: TIniFile{Ex};
begin
  IniFile := TIniFile{Ex}.Create(iniFileName);
  try
    IniFile.WriteInteger(PosSection, 'Left', Left);
    IniFile.WriteInteger(PosSection, 'Top', Top);

//    IniFile.WriteString(ParamsSection, 'AppcastURL', myUrlString);
//    IniFile.WriteString(ParamsSection, 'InfoURL', myInfoFtring);
    if CheckAtStartup.Checked then
      IniFile.WriteInteger(ParamsSection, 'UpdateAtStart', 1)
    else
      IniFile.WriteInteger(ParamsSection, 'UpdateAtStart', 0);

    IniFile.WriteInteger(ParamsSection, 'CheckInterval', dayInterval);
    IniFile.WriteString(ParamsSection, 'LastTimeChecked',
      DateTimeToStr(LastCheckDate));
  finally
    IniFile.Free;
  end;
end;

procedure TUpdaterForm.TimerTimer(Sender: TObject);
begin
   Timer.Enabled:=false;
if  flgDisappear then
begin
   inc(i,3);
   self.alphablendvalue:=255-i;
end;
  if odd(count) then  labelinfo.font.Color:=clblack
                else  labelinfo.font.Color:=clred;
           inc(count);
  if alphablendvalue<=4 then begin self.visible:=false; flgDisappear:=false;close;  exit; end;
    Timer.Enabled:=true;
end;

end.

