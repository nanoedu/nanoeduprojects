//150105
unit GlobalFunction;

interface
uses  windows, Graphics,Forms,Messages,Controls,Dialogs,ShlObj,sysUtils,strUtils,
      IniFiles,Registry,
      //ntspb
      GlobalType,GlobalScanDataType, Globaldcl, uFileOp;
const
 // Следующих идентификаторов нет в ShlObj:
  CSIDL_ADMINTOOLS                = $30;
  // Административные инструменты текущего пользователя (например консоль MMC). Win2000+

  CSIDL_CDBURN_AREA               = $3b;
  // Папка для файлов, подготовленных к записи на CD/DVD
  // (Обычно C:\Documents and Settings\username\Local Settings\Application Data\Microsoft\CD Burning)

  CSIDL_COMMON_ADMINTOOLS         = $2f;
  // Папка, содержащая инструменты администрирования

  CSIDL_COMMON_APPDATA            = $23;
  // Папака AppData для всех пользователей. (обычно C:\Documents and Settings\All Users\Application Data)

  CSIDL_COMMON_DOCUMENTS          = $2e;
  // Папка "Общие документы" (обычно C:\Documents and Settings\All Users\Documents)

  CSIDL_COMMON_TEMPLATES          = $2d;
  // Папка шаблонов документов для всех пользователей (Обычно C:\Documents and Settings\All Users\Templates)

  CSIDL_COMMON_MUSIC              = $35;
  // Папка "Моя музыка" для всех пользователей. (обычно C:\Documents and Settings\All Users\Documents\My Music)

  CSIDL_COMMON_PICTURES           = $36;
  // Папка "Мои рисунки" для всех пользователей. (обычно C:\Documents and Settings\All Users\Documents\My Pictures)

  CSIDL_COMMON_VIDEO              = $37;
  // Папка "Моё видео" для всех пользователей (C:\Documents and Settings\All Users\Documents\My Videos)

  CSIDL_COMPUTERSNEARME           = $3d;
  // Виртуальная папка, представляет список компьютеров в вашей рабочей группе

  CSIDL_CONNECTIONS               = $31;
  // Виртуальная папка, представляет список сетевых подключений

  CSIDL_LOCAL_APPDATA             = $1c;
  // AppData для приложений, которые не переносятся на другой компьютер (обычно C:\Documents and Settings\username\Local Settings\Application Data)

  CSIDL_MYDOCUMENTS               = $0c;
  // Виртуальный каталог, представляющий папку "Мои документы"

  CSIDL_MYMUSIC                   = $0d;
  // Папка "Моя музыка"

  CSIDL_MYPICTURES                = $27;
  // Папка "Мои картинки"

  CSIDL_MYVIDEO                   = $0e;
  // Папка "Моё видео"

  CSIDL_PROFILE                   = $28;
  // Папка пользователя (обычно C:\Documents and Settings\username)

  CSIDL_PROGRAM_FILES             = $26;
  // Папка Program Files (обычно C:\Program Files)

  CSIDL_PROGRAM_FILESX86          = $2a;

  CSIDL_PROGRAM_FILES_COMMON      = $2b;
  // Папка Program Files\Common (обычно C:\Program Files\Common)

  CSIDL_PROGRAM_FILES_COMMONX86   = $2c;

  CSIDL_RESOURCES                 = $38;
  // Папка для ресерсов. Vista и выше (обычно C:\Windows\Resources)

  CSIDL_RESOURCES_LOCALIZED       = $39;

  CSIDL_SYSTEM                    = $25;
  // Папака System (обычно C:\Windows\System32 или C:\Windows\System)

  CSIDL_SYSTEMX86                 = $29;

  CSIDL_WINDOWS                   = $24;
  // Папка Windows. Она же %windir% или %SYSTEMROOT% (обычно C:\Windows)
function  ScandataWorkFileNameEm(n:integer):string;
function  ShowWelComeWindow:Boolean;
function  WhichLanguage:string;
//function  Localization:string;
function  SetFileAttribute_ReadOnly(const filename:string;flg:boolean):boolean;
function  Median3(a1,a2,a3:apitype):apitype;
function  WorkFlash:boolean;
//function  SetFlash(flg:boolean):boolean;
//function  GetScannerFileName:string;
//function  GetScannerYFileName:string;
function  GetExePath:string;
function  GetConfigFileName:string;
function  GetConfigUsersFileName:string;
function  GetControllerFileName:string;
function  GetPaletteFileName:string;
function  GetReniShawFileName:string;
procedure GetScriptsName;
procedure SetScriptsName;
function  GetHDDInfo(Disk : Char;Var VolumeName, FileSystemName : String;
                    Var VolumeSerialNo, MaxComponentLength, FileSystemFlags:LongWord) : Boolean;
procedure CutExtention(const InName:string ; var OutName:string);
function  GetPathMTPDevice:boolean;
function  GetPathFlash:string;
function  GetSpecialPath(CSIDL: word): string;
procedure GetSpecialDirPath;
function  GetLocalMachineName:string;
function  GetUserAccountName:string;
procedure SetFirstStartParams;
function  GetUserLevel:string;
procedure SetUserLevel;
function  GetDeviceInterfaceName:string;
function  GetDeviceName:integer;
procedure SetDeviceName(flg:integer);
function  GetSEMConfigPath:string;
procedure SetSEMConfigPath(path:string);
function  GetflgChangeUserLevel:integer;
procedure SetflgChangeUserLevel;
function  GetflgOnlineService:integer;
procedure SetOnlineService;
function  GetLanguage:string;
procedure SetLanguage;
function  TestAndSetNewVersion:boolean;
procedure RenderTeapot(ambr,ambg,ambb,difr,difg,difb,specr,specg,specb,shine:single);   { Private declarations }
procedure PaletBrownInit();
procedure PaletGreyInit();
procedure PaletBlueToRedInit();
procedure PaletZebraInit();
procedure PaletColorZebraInit();
//procedure LinearApprox(N:integer; XNod,YNod:ArraySpline; var A0,KL:ArraySpline);
//function  Leval( N:integer;U:single; XNod,YNod:ArraySpline; A0,KL:ArraySpline):single; //Result (0..1)
procedure FixedPalette();
procedure EvalPaletteLines();
procedure LoadPalette(const PaletName:string);
procedure SavePalette(const PaletName:string);
procedure LoadDefPaletName(var PaletName:string);
procedure SaveDefPaletName(const PaletName:string);
function  FindScannerInDbase:boolean;
function  AdScannerToDbase:boolean;
procedure InitDirectories;
procedure InitTutor;
procedure InitParametersAxes;
procedure InitParameters;
function  InitParametersNanoEdu:boolean;
function  InitParametersNanoEduLE:boolean;
function  SetScannerIniPath:boolean;
function  DeleteLastSlash(str:string):string;
function  SetDefaultIniFilesPath:boolean;
function  SetDemoIniFilesPath:boolean;
function  ConvertStringtoFloat(S:string):single;
function  ExecAndWait(const FileName, Params: ShortString; const WinState: Word): boolean;
function  ReadFloatConvert(iniCSPM:TiniFile;const Section, Ident: String; Default: single): single;
function  ReadDoubleConvert(iniCSPM:TiniFile;const Section, Ident: String; Default: double): double;
function  CheckScannerName(const ScannerFile, ImgScannerName:string):boolean;
function  ByteInversion(const source:integer):integer;
(*function  MessageDlgCtr(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
  *)
procedure  SetXYMax;
function   Signf(a:single):integer;
function   sign(val:single):integer; overload;
function   sign(val:integer):integer; overload;
function   GetCurrentData:string;
procedure  CreateNewScanner(scannername:string);
procedure  SetSchemeName(SchemeName:string);
procedure  GetTimeNow(var Hour, Minute, Sec, MSec:word);


 function   DemoSmooth_bySpeed(ScanSpeed:single):single;
//function    DemoDepth_bySpeed(ScanSpeed:single):single;
 function   DemoDepth_byFBGain(FBGain:double):single;
 function   DemoNoise_byFBGain(FBGain:double):datatype;
 function   DemoNoise_bySpeed(Speed:double):datatype;
 function   DemoLithoDepth(Action:single):single;

 procedure  CorrectImgSection_Smooth(DemoSmoothnm:single ; var ImgLine:TLine);
 procedure  CorrectImgSection_depth(DemoDepthnm:single ; var ImgLine:TLine);
 function   AltDown : Boolean;
 procedure  AddNoise( DemoNoisediscr:datatype; var ImgLine:TLine);
 procedure  CalcDemoImitationParams( iRate:single; iFBGain:Pidtype; iLithoAction:Single; var smooth_nm:single; var  noise_discr, noise_speed_discr:datatype; var depth_nm:single;
                                    var lithodepth_nm:single);
 procedure  FBGain_Speed_DemoImitation(smooth_nm:single; noise_discr, noise_speed_discr:datatype;
                                         depth_nm:single;  lithodepth_nm:single;   var AquiData:TData; var TempLineData:TLine);


function getletime:string;

implementation

uses math,GlobalVar,CSPMVar,RenishawVars,nanoeduhelp,frNoFormUnitLoc, UAdapterService,SystemConfig,
         Interpolation2D, SurfaceTools;
function getletime:string;
 var
       Hour, Minut, Sec, MSec: Word;
       Present: TDateTime;
       fminut,fhour,fsec:string;
begin
        Present:= Now;
        DecodeTime(Present, Hour, Minut, Sec, MSec);
        if Minut<10   then  fminut:='0'+inttostr(minut)
                      else  fminut:=inttostr(minut);
        if Hour<10    then  fhour:='0'+inttostr(hour)
                      else  fhour:=inttostr(hour);
        if Sec<10     then  fsec:='0'+inttostr(sec)
                      else  fsec:=inttostr(sec);
        result:=fHour+'_'+fMinut+'_'+fSec;//+' ';
end;
function  DeleteLastSlash(str:string):string;
var i,l,ps:integer;
    fstr:string;
begin
  l:=length(str);
  ps:=POS('\',str);
   if str[l]='\' then
   Delete(str,l,1);
  result:=str;
end;
{ Функция MessageDlg располагает диалог над центром активного окна }
function Signf(a:single):integer;
begin
 { TODO : 101202 }
 result:=1;
  if a<0 then result:=-1;
//         else if a=0 then Sign:=1;       ///!!!!!
end;
 function Sign(val:single):integer;
begin
 { TODO : 101202 }
 result:=1;
  if val<0 then result:=-1;
//         else if a=0 then Sign:=1;       ///!!!!!
end;
function Sign(val:integer):integer;
begin
 { TODO : 101202 }
 result:=1;
  if val<0 then result:=-1;
//         else if a=0 then Sign:=1;       ///!!!!!
end;

function  GetCurrentData:string;
var Year, Month, Day, Hour, Minut, Sec, MSec: Word;
     Present: TDateTime;
begin
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minut, Sec, MSec);
  result:=inttostr(Day)+'_'+inttostr(Month)+'_'+inttostr(Year);
end;
function  ByteInversion(const source:integer):integer;
begin
  result:=        ( (source and $FF000000) shr 24) or
                  ( (source and $00FF0000) shr  8) or
                  ( (source and $0000FF00) shl  8) or
                  ( (source and $000000FF) shl 24) ;
end;

function WhichLanguage:string;
var
  ID: LangID;
  Language: array [0..100] of char;
begin
  ID := GetSystemDefaultLangID;
  VerLanguageName(ID, Language, 100);
  Result := string(Language);
end;
function  ScandataWorkFileNameEm(n:integer):string;
var Str:string;
begin
  str:='00';
  if (N<99) AND (N>9) then str:='0'
    else
      if (99<N) AND (N<999) then    str:='0';
  result:=str+inttostr(n);
end;
procedure CutExtention(const InName:string ; var OutName:string);
var
  name,ext:string;
  newName:string;
  i,L:integer;
begin
 name:=ExtractFileName(InName);
 ext:=ExtractFileExt(inName);
 L:= Length(ext);
 L:=Length(name)-L;
 SetLength(NewName,L);
 for i:=1 to L do   NewName[i]:=name[i];
 OutName:=NewName;
end;


function  ShowWelComeWindow:Boolean;
  var iniCSPM:TiniFile;
       sFile:string;
       fileName:string;
       flg:string;
begin
 sFile:=GetConfigUsersFileName;
   iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
     begin
       flg:=ReadString('Users','Show Welcome Window','true');
     result:=false;
       if flg='true' then result:=true;
     end;
  finally
    iniCSPM.Free;
  end;
end;
(*function MessageDlgCtr(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  with  main.{NoFormUnitLoc}.siLang1.CreateMessageDialog(Msg, DlgType, Buttons) do
  try
    HelpContext := HelpCtx;
    if assigned(Screen.ActiveForm) then
     begin
     Left := Screen.ActiveForm.Left + (Screen.ActiveForm.Width div 2) -
      (Width div 2);

     Top := Screen.ActiveForm.Top + (Screen.ActiveForm.Height div 2) -
      (Height div 2);
     end;
    Result := ShowModal;
  finally
    Free;
  end;
end;
*)
function Localization:string;
var   reg:Tregistry;
      lng:string;
begin
 Reg:=Tregistry.Create;
try
 Reg.RootKey:=HKEY_CURRENT_USER;
 Reg.OpenKey('Control Panel', false);
 Reg.OpenKey('International', false);
 result:=Reg.ReadString('sLanguage');
 Reg.CloseKey;
finally
 Reg.Free;
end;
end;

function SetFileAttribute_ReadOnly(const filename:string;flg:boolean):boolean;
begin
   case flg of
true:begin
       if FileExists(filename) then SetFileAttributes(PChar(filename), FILE_ATTRIBUTE_READONLY or FILE_ATTRIBUTE_ARCHIVE);
      end;
false:begin
       if FileExists(filename)then SetFileAttributes(Pchar(filename), FILE_ATTRIBUTE_ARCHIVE);
      end;
          end;
end;

function  ReadFloatConvert(iniCSPM:TiniFile;const Section, Ident: String; Default: single): single;
var temp:string;
    sep:string;
    r:float;
begin
   temp:=iniCSPM.ReadString(section, Ident,floattostrF(Default,fffixed,6,2));
   sep:='.';
   if DecimalSeparator='.' then sep:=',';
   if not AnsiContainsText(temp,DecimalSeparator) then  temp:=AnsiReplaceStr(temp,sep,DecimalSeparator);
   result:=strtofloat(temp);
end;
function  ReadDoubleConvert(iniCSPM:TiniFile;const Section, Ident: String; Default: double): double;
var temp:string;
    sep:string;
begin
   temp:=iniCSPM.ReadString(section, Ident,floattostrF(Default,fffixed,6,2));
   sep:='.';
   if DecimalSeparator='.' then sep:=',';
   if not AnsiContainsText(temp,DecimalSeparator) then  temp:=AnsiReplaceStr(temp,sep,DecimalSeparator);
   result:=strtofloat(temp);
end;
procedure FixedPalette();
var  i:integer;
begin
for i:=1 to MaxVal do
 begin
  RPaletteKoef[i-1]:=round(255*RDistr[i]);   //256
  GPaletteKoef[i-1]:=round(255*GDistr[i]);   //256
  BPaletteKoef[i-1]:=round(255*BDistr[i]);   //256
 end;
end;

procedure  RenderTeapot ( ambr, ambg, ambb,difr, difg, difb, specr, specg, specb, shine : single);
begin
  shininess[0] :=128*shine;
  specular[0]  :=specr;
  specular[1]  :=specg;
  specular[2]  :=specb;
  specular[3]  :=1.0;
  diffuse[0]   := difr;
  diffuse[1]   := difg;
  diffuse[2]   :=difb;
  diffuse[3]   :=1.0;
  ambient[0]   :=ambr;
  ambient[1]   :=ambg;
  ambient[2]   :=ambb;
  ambient[3]   :=1.0;
end;

function GetDisks(TypeOfDisk : Word) : String;{Получить имена нужных дисков}
var
  DriveArray : array[1..26] of Char;
  I : integer;
begin
  DriveArray:='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  for I := 1 to 26 do
    if GetDriveType(PChar(DriveArray[I]+':\')) = TypeOfDisk then Result := Result+DriveArray[I];
end;

Function GetHDDInfo(Disk : Char;Var VolumeName, FileSystemName : String;
                    Var VolumeSerialNo, MaxComponentLength, FileSystemFlags:LongWord) : Boolean;
var _VolumeName,_FileSystemName:array [0..MAX_PATH-1] of Char;
    _VolumeSerialNo,_MaxComponentLength,_FileSystemFlags:LongWord;
Begin
  if GetVolumeInformation(PChar(Disk+':\'),_VolumeName,MAX_PATH,@_VolumeSerialNo,
      _MaxComponentLength,_FileSystemFlags,_FileSystemName,MAX_PATH) then
  Begin
    VolumeName:=_VolumeName;
    VolumeSerialNo:=_VolumeSerialNo;
    MaxComponentLength:=_MaxComponentLength;
    FileSystemFlags:=_FileSystemFlags;
    FileSystemName:=_FileSystemName;
    Result:=True;
  End else Result:=False;
end;

function CheckScannerName(const ScannerFile, ImgScannerName:string):boolean;
var
    iniCSPM:TIniFile;
begin
 Result:=True;
 iniCSPM:=TIniFile.Create(ScannerFile);
 try
  if not iniCSPM.SectionExists(ImgScannerName) then  Result:=False;
 finally
  iniCSPM.Free;
 end;
end;

function  WorkFlash:boolean;
 var SFile:string;
   iniCSPM:TiniFile;
begin
  (*
  sFile:=GetConfigUsersFileName;
    iniCSPM:=TIniFile.Create(sFile);
   try
    with iniCSPM do Result:=Boolean(ReadInteger('Physical Unit Options','Use Flash drive',0));
   finally
    iniCSPM.Free;
   end;
   *)
   result:=false;
end;

function  SetFlash(flg:boolean):boolean;
var SFile:string;
    iniCSPM:TiniFile;
begin
 Result:=false;
 sFile:=GetConfigUsersFileName;
//    SetFileAttribute_ReadOnly(sfile,false);
    iniCSPM:=TIniFile.Create(sFile);
   try
    with iniCSPM do
    begin
     WriteInteger('Physical Unit Options','Use Flash drive',byte(flg));
     WriteInteger('Physical Unit Options','Set Scanner Number Auto',1);
     Result:=true;
    end;
  //  SetFileAttribute_ReadOnly(sfile,true);
   finally
      iniCSPM.Free;
   end;
end;
 function AltDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Menu] and 128) <> 0) ;
end;
 function GetSpecialPath(CSIDL: word): string;
var s:  string;
begin
  SetLength(s, MAX_PATH);
  if not SHGetSpecialFolderPath(0, PChar(s), CSIDL, true)
  then s := '';
  result := PChar(s);
end;
function GetLocalMachineName:string;
var Namesize:Dword;
ComputerName:Pchar;
begin
 ComputerName:=#0;
 NameSize:=Max_ComputerName_Length+1;
try
 GetMem(ComputerName,Namesize);
 Windows.GetComputerName(ComputerName,Namesize) ;
 result:=ComputerName;
finally
  FreeMem(ComputerName);
end;
end;
function  GetUserAccountName:string;
var Namesize:Dword;
ComputerName:Pchar;
begin
 ComputerName:=#0;
 NameSize:=Max_ComputerName_Length+1;
try
 GetMem(ComputerName,Namesize);
 Windows.GetUserName(ComputerName,Namesize) ;
 result:=ComputerName;
finally
  FreeMem(ComputerName);
end;
end;

procedure GetSpecialDirPath;
var tempdir:string;
begin
   dirsys32:=GetSpecialPath( CSIDL_SYSTEM);
   dirsys32drivers:=dirsys32+'\drivers';
       //common appl data files
    CommonApplDataPath:=GetSpecialPath(CSIDL_COMMON_APPDATA);
    GetDeviceInterfaceName;
     //common data files +nanoeducator
    CommonNanoeduApplDataPath:=CommonApplDataPath+'\'+ProgramName+'\';
  // Папка, в которой рограммы должны хранить свои данные
    CommonDocumentsPath:= GetSpecialPath(CSIDL_COMMON_DOCUMENTS);
   //  C:\Documents and Settings\username\Application Data)  +nanoeducator
    CommonNanoeduDocumentsPath:=CommonDocumentsPath+'\'+ProgramName+'\';
   if not DirectoryExists(CommonNanoeduDocumentsPath) then  CreateDir(CommonNanoeduDocumentsPath);

 // Папка пользователя (обычно C:\Documents and Settings\username)
   UserDocAndSetDirPath:=GetSpecialPath(CSIDL_PROFILE);
   // Папка пользователя (обычно C:\Documents and Settings\username\appl data)
   UserApplDataPath:= GetSpecialPath(CSIDL_APPDATA);
   UserNanoeduApplDataPath:=UserApplDataPath+'\'+ProgramName+'\';
   if not DirectoryExists(UserNanoeduApplDataPath) then  CreateDir(UserNanoeduApplDataPath);
//   if not DirectoryExists(UserNanoeduApplDataPath+'Data') then  CreateDir(UserNanoeduApplDataPath+'Data');

 //  tempdir:=CommonNanoeduApplDataPath;
 (*  tempdir:=UserNanoeduApplDataPath;
   if not DirectoryExists(tempdir) then  CreateDir(tempdir);
   if not DirectoryExists(tempdir+'Reporttmpl')     then  CreateDir(tempdir+'Reporttmpl');
   if not DirectoryExists(tempdir+'Reporttmpl\Rus') then  CreateDir(tempdir+'Reporttmpl\Rus');
   if not DirectoryExists(tempdir+'Reporttmpl\Eng') then  CreateDir(tempdir+'Reporttmpl\Eng');
 *)
  // Папка, в которой рограммы должны хранить свои данные
  //(C:\Documents and Settings\username\Application Data)
   UserDocumentsPath:= GetSpecialPath(CSIDL_PERSONAL);
   //  C:\Documents and Settings\username\Application Data)  +nanoeducator
   UserNanoeduDocumentsPath:=UserDocumentsPath+'\'+ProgramName;//+'\';
   if not DirectoryExists(UserNanoeduDocumentsPath) then  CreateDir(UserNanoeduDocumentsPath);
//   if not DirectoryExists(UserNanoeduDocumentsPath+'\work') then  CreateDir(UserNanoeduDocumentsPath+'\work');
// Виртуальный каталог, представляющий папку "Мои документы"
   UserDrivePath:= (ExtractFileDrive(UserDocAndSetDirPath));
   UserNanoeduWorkDocumentsPath:=UserNanoeduDocumentsPath+'\work';
   if not DirectoryExists(UserNanoeduWorkDocumentsPath) then  CreateDir(UserNanoeduWorkDocumentsPath);
end;

procedure setfirststartparams;
  var sFile:string;
  iniCSPM:Tinifile;
begin
// ApproachParamsDef;
 sFile:=ConfigUsersIniFilePath + ConfigUsersIniFile;
 if (not FileExists(sFile)) then
  begin
    NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Config Ini File '}+sFile);
   end;
    iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
    begin
       WriteString('Users','User Level','Demo');
       WriteString('Files','Work Directory',UserNanoeduDocumentsPath);
       WriteInteger('Physical Unit Options','Set Scanner Number Auto',1);
       WriteInteger('Physical Unit Options','Use Flash drive',1);
       WriteString('Users','Show Welcome Window','true');
       WriteBool('Approach Parameters','Autorun Camera',true);
      if (flgUnit=Nano) or (flgUnit=Pipette) or (flgUnit=Terra)  then  WriteInteger('Approach Parameters','Control Top Position',1);
    end;
  finally
    iniCSPM.Free;
  end;
end;

function  GetUserLevel:string;
  var SFile:string;
    iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
    iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
      if SectionExists ('Users') then  result:=ReadString('Users','User Level','Advanced')
      else
       begin
  //       SetFileAttribute_ReadOnly(sfile,false);
         WriteString('Users','User Level','Advanced');
  //       SetFileAttribute_ReadOnly(sfile,true);
        end;
       if result='Advanced' then   FlgCurrentUserLevel:=Advanced;
       if result='Beginner' then   FlgCurrentUserLevel:=Beginner;
       if result='Demo'     then   FlgCurrentUserLevel:=Demo;
    end;
   finally
    iniCSPM.Free;
   end;
end;
function GetSEMConfigPath:string;
 var SFile:string;
    iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
    iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
      if SectionExists ('Files') then  result:=ReadString('Files','sempath','')
    end;
   finally
    iniCSPM.Free;
   end;
end;
procedure SetSEMConfigPath(path:string);
 var SFile:string;
    iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
    iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
         WriteString('Files','sempath',ConfigSEMfile);
     end;
   finally
    iniCSPM.Free;
   end;
end;
procedure  SetUserLevel;
 var SFile:string;
   iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
 //  SetFileAttribute_ReadOnly(sfile,false);
   iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
    begin
       WriteString('Users','User Level',CurrentUserLevel);
    end;
 //   SetFileAttribute_ReadOnly(sfile,true);
  finally
    iniCSPM.Free;
  end;
end;

function  GetflgChangeUserLevel:integer;
 var SFile:string;
    iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
  iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
      if SectionExists ('Users')        then  result:=ReadInteger('Users','Flg Change User Level',1)
      else
      begin
         WriteInteger('Users','Flg Change User Level',1);
         result:=1;
      end;
    end;
   finally
    iniCSPM.Free;
   end;
end;

function  GetflgOnlineService:integer;
 var  SFile:string;
    iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
  iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
     if SectionExists ('Online service') then  result:=ReadInteger('Online service','use online service',0)
      else
       begin
         WriteInteger('Online service','use online service',0);
         result:=0;
        end;
    end;
   finally
    iniCSPM.Free;
   end;

end;
function  GetDeviceName:integer;
 var SFile:string;
    iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
    iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
      if SectionExists ('Physical Unit Options') then  result:=ReadInteger('Physical Unit Options','device',1)
      else
       begin
  //       SetFileAttribute_ReadOnly(sfile,false);
         WriteInteger('Physical Unit Options','device',Nano);
  //       SetFileAttribute_ReadOnly(sfile,true);
        end;
     end;
   finally
    iniCSPM.Free;
   end;
end;
procedure  SetDeviceName(flg:integer);
 var SFile:string;
    iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
    iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
      if SectionExists ('Physical Unit Options') then  WriteInteger('Physical Unit Options','device',flgUnit)
    end;
   finally
    iniCSPM.Free;
   end;
end;

procedure SetOnlineService;

  var SFile:string;
   iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
 //  SetFileAttribute_ReadOnly(sfile,false);
   iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
    begin
        WriteInteger('Online service','use online service',flgOnlineService);
    end;
 //   SetFileAttribute_ReadOnly(sfile,true);
  finally
    iniCSPM.Free;
  end;
end;
procedure SetflgChangeUserLevel;

  var SFile:string;
   iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
 //  SetFileAttribute_ReadOnly(sfile,false);
   iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
    begin
       WriteInteger('Users','Flg Change User Level',flgChangeUserLevel);
    end;
 //   SetFileAttribute_ReadOnly(sfile,true);
  finally
    iniCSPM.Free;
  end;
end;

function  GetLanguage:string;
  var SFile:string;
    iniCSPM:TiniFile;
    lng:string;
begin
   sFile:=ConfigUsersIniFilePath + ConfigUsersIniFile;
if (not FileExists(sFile)) then
  begin
     NoFormUnitLoc.siLang1.MessageDlg(s4{'No Config Ini File. Program Terminated!!'},mtwarning,[mbYes],0);
   Halt;
  end
  else
  begin
    iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
      if SectionExists ('Language') then  result:=ReadString('Language','Help','NONE');
      if not SectionExists ('Language') or (result='NONE') or (result='') then
       begin
   //      SetFileAttribute_ReadOnly(sfile,false);
         lng:=Localization;
         WriteString('Language','Help',lng);
//         SetFileAttribute_ReadOnly(sfile,true);
         result:=lng;
        end;
    end;
   finally
    iniCSPM.Free;
   end;
  end;
end;
function  TestAndSetNewVersion:boolean;
var
   SFile:string;
   iniCSPM:TiniFile;
  VInfoSize, DetSize: DWord;
  pVInfo, pDetail: Pointer;
  majorver,minorver,releasever,buildver:integer;
  majorcurver,minorcurver,releasecurver,buildcurver:integer;
begin
  result:=false;
  sFile:=GetConfigUsersFileName;
//   SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
     majorver:=ReadInteger('Version','Major version number',8);
     minorver:=ReadInteger('Version','Minor version number',9);
     releasever:=ReadInteger('Version','Release version number',25);
     buildver:=ReadInteger('Version','Build version number',4);
    end;
//    SetFileAttribute_ReadOnly(sfile,true);

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
         (* 'Program: Major version number: ' *)
      majorcurver:= (HiWord (dwFileVersionMS));
            (* '; Minor version number: ' *)
      minorcurver:=(LoWord (dwFileVersionMS));
         (* 'Release version number: ' *)
      releasecurver:=(HiWord (dwFileVersionLS));
            (* '; Build version number: ' *)
      buildcurver:=(LoWord (dwFileVersionLS));
      if majorcurver>majorver then result:=true;
        if minorcurver>minorver   then result:=true;
          if releasecurver>releasever then result:=true;
           if buildcurver>buildver      then result:=true;
       end;
    finally
      FreeMem (pVInfo);
    end;
  end;
   if result then
   begin
     with iniCSPM do
    begin
    WriteInteger('Version','Major version number', majorcurver);
    WriteInteger('Version','Minor version number',minorcurver);
    WriteInteger('Version','Release version number',releasecurver);
    WriteInteger('Version','Build version number',buildcurver);
    end;
   end;
  finally
      iniCSPM.Free;
  end;
 end;

procedure  SetLanguage;
 var SFile:string;
   iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
//   SetFileAttribute_ReadOnly(sfile,false);
   iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
       WriteString('Language','Help',sLanguage);
    end;

//    SetFileAttribute_ReadOnly(sfile,true);
  finally
      iniCSPM.Free;
  end;
end;

procedure GetScriptsName;
 var SFile:string;
    iniCSPM:TiniFile;
begin
  sFile:=GetConfigFileName;
    iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
      RisingScrpt:=LowerCase(ReadString('Scripts','Rising', 'rising.jar'));
      TrainScrpt:=LowerCase(ReadString('Scripts','Training', 'trainningnew.jar'));
     if flgUnit=grand then ScanMScrpt:=LowerCase(ReadString('Scripts','ScanningStepMotor', 'scanstepm2.bin'))
                      else ScanMScrpt:=LowerCase(ReadString('Scripts','Scanning', 'scan_new.jar'));
      ScanLinMScrpt:= LowerCase(ReadString('Scripts','ScanningLin', 'scanlin_new.jar'));
      ScanFastScrpt:= LowerCase(ReadString('Scripts','FastScanning', 'fast_scan.jar'));
      TestTIScrpt:=LowerCase('test_TI.jar');
      WriteToMLPCScript:=LowerCase(ReadString('Scripts','WriteToAdapter', 'WriteToMLPC.jar'));
      WriteNumbToController:=LowerCase(ReadString('Scripts','WriteNumbToController', 'setcontrollerid.jar'));
      GetControllerIDScript:=LowerCase(ReadString('Scripts','GetControllerID', 'getcontrollerid.jar'));
      ReadFromMLPCScript:=LowerCase(ReadString('Scripts','ReadFromAdapter', 'ReadFromMLPC.jar'));
      GetDeviceIdScript:= LowerCase(ReadString('Scripts','GetDeviceID', 'GetDeviceId.jar'));
      ClearAdapterScript:= LowerCase(ReadString('Scripts','ClearAdapter', 'clearadapter.jar'));
      ScanMScrptTerra:=LowerCase(ReadString('Scripts','ScanningTerra', 'scanterranew.jar'));
      ScanLinMScrptTerra:=LowerCase(ReadString('Scripts','ScanningLinTerra', 'scanlinterranew.jar'));
      SpectrNScrpt:=LowerCase(ReadString('Scripts','SpectroscopySFM', 'spectrsfm.jar'));
      ProfileLinMScrpt:=LowerCase(ReadString('Scripts','ProfileLin', 'profilelin.jar'));
      ProfileMScrpt:=LowerCase(ReadString('Scripts','Profile', 'profile.jar'));
   //   SpectrScrptPipette:=LowerCase(ReadString('Scripts','SpectroscopySFMPipette', 'spectrzpipe7.bin'));
      if FlgUnit=Pipette  then SpectrNScrpt:= SpectrScrptPipette;
      SpectrNScrptTerra:=LowerCase(ReadString('Scripts','SpectroscopySFMTerra', 'spectrterrasfmnew.jar'));
      SpectrScrptSTM:=LowerCase(ReadString('Scripts','SpectroscopySTM', 'spectrstm.jar'));
    if flgUnit=Terra then
     begin
          ScanMScrpt:=ScanMScrptTerra;
        SpectrNScrpt:=SpectrNScrptTerra;
     end;
      MovetoScrpt:=LowerCase(ReadString('Scripts','MoveTo','Movetonew.jar'));
 //     ScanMIIScrpt:=LowerCase(ReadString('Scripts','ScanningII', 'scanmltpass2_6.bin'));//('scanmltpass2_4.bin');
      ApproachSMScrpt:=LowerCase(ReadString('Scripts','Approach', 'approachnew.jar'));
 //     ApproachPipetteScrpt:=LowerCase(ReadString('Scripts','ApproachPipette', 'landsmpipev19.bin'));
      ApproachPMScrpt:=LowerCase(ReadString('Scripts','ApproachPM', 'approachpmnew.jar'));
//      ApproachSMOneScrpt:=LowerCase(ReadString('Scripts','ApproachSMOne', 'approachsmonev1.bin'));
//      ApproachPipetteOneScrpt:=LowerCase(ReadString('Scripts','ApproachPipetteOne', 'lands1pipev8.bin'));
//      ApproachPMOneScrpt:=LowerCase(ReadString('Scripts','ApproachPMOne', 'approachpmonev1.bin'));
//      PhaseNScrpt:=LowerCase(ReadString('Scripts','PhaseZero', 'phase.bin'));
      ResonanceNScrpt:=LowerCase(ReadString('Scripts','Resonance', 'resonance.jar'));
      LithoScript:=LowerCase(ReadString('Scripts','LithoSFM', 'lithonew.jar'));
      LithoLinScript:=LowerCase(ReadString('Scripts','LithoLinSFM', 'litholinnew.jar'));
      AnodeLithoScript:=LowerCase(ReadString('Scripts','AnodeLithoSFM', 'lithoanodenew.jar'));
      AnodeLinLithoScript:=LowerCase(ReadString('Scripts','AnodeLithoLinSFM', 'lithoanodelinnew.jar'));
 //     ScanFastScrpt:=LowerCase(ReadString('Scripts','FastScanning', 'fastscanph.bin'));
 //     PMTestScrpt:=LowerCase(ReadString('Scripts','TestPM', 'steptestpm.bin'));
      SMTestScrpt:=LowerCase(ReadString('Scripts','TestSM', 'testsm.jar'));
 //     EtchingScrpt:=LowerCase(ReadString('Scripts','Etching', 'etching.bin'));
 //     ApproachSMXScrpt:=LowerCase(ReadString('Scripts','ApproachSMX', 'approachsmx.bin'));
 //     AnodeLithoTestScrpt:=LowerCase(ReadString('Scripts','AnodeLitho', 'anodelitho.bin'));
      ScannerMoveXYZScrpt:=LowerCase(ReadString('Scripts','ScannerSEMXYZ','ScannerSEMPM.jar'));
      ApproachPMSEMScrpt:=LowerCase(ReadString('Scripts','ApproachSEMPM', 'approachnew.jar'));
//      ApproachPMSEMOneScrpt:=LowerCase(ReadString('Scripts','ApproachPMSEMOne', 'land1pmsemv1.bin'));
      PMSEMTestScrpt:=LowerCase(ReadString('Scripts','TestPMSEM', 'steptestpmsemv6.bin'));
      Scheme:=LowerCase(ReadString('Scripts','Scheme', 'nl_ascan3d_v9d.bin'));
      SchemeEng:=LowerCase(ReadString('Scripts','SchemeEng', 'nl_ascan3d_v9deng.bin'));
      if (sLanguage='ENG')then Scheme:=SchemePath+SchemeEng
      else Scheme:=SchemePath+Scheme;//  Scheme:=SchemePath+ 'nl_scheme_2.bin';
      ReniShawTestScrpt:='renishaw.bin';

   (*   if FlgRenishawUnitExists then
      begin
      with iniCSPM do
       begin
        TrainScrpt:=LowerCase(ReadString('RSScripts','Training', 'training2.bin'));
        ScanMIIScrpt:=LowerCase(ReadString('RSScripts','ScanningII', 'scanmltpass2_6.bin'));//('scanmltpass2_4.bin');
        ApproachSMScrpt:=LowerCase(ReadString('Scripts','Approach', 'approachv10.bin'));
        ApproachPMScrpt:=LowerCase(ReadString('Scripts','ApproachPM', 'approachpm.bin'));
        ApproachSMOneScrpt:=LowerCase(ReadString('Scripts','ApproachSMOne', 'approachsmonev1.bin'));
        ApproachPMOneScrpt:=LowerCase(ReadString('Scripts','ApproachPMOne', 'approachpmonev1.bin'));
        SpectrNScrpt:=LowerCase(ReadString('Scripts','SpectroscopySFM', 'spectrz1.bin'));
        SpectrScrptSTM:=LowerCase(ReadString('Scripts','SpectroscopySTM', 'spectrstm.bin'));
        PhaseNScrpt:=LowerCase(ReadString('Scripts','PhaseZero', 'phase.bin'));
        ResonanceNScrpt:=LowerCase(ReadString('Scripts','Resonance', 'resonancev6.bin'));
        LithoScript:=LowerCase(ReadString('Scripts','LithoSFM', 'litho3.bin'));
        ScanFastScrpt:=LowerCase(ReadString('Scripts','FastScanning', 'fastscanph.bin'));
        PMTestScrpt:=LowerCase(ReadString('Scripts','TestPM', 'steptestpm.bin'));
        SMTestScrpt:=LowerCase(ReadString('Scripts','TestSM', 'steptestsm.bin'));
       end;
      end;
    *)
 end;
//   ScanFScrpt:='scanfast.bin';
   finally
     iniCSPM.Free;
   end;
end;
 //
(*function  GetScannerFileName(const FileName:string):string;
var cFileName,cFileNameDef:string;
begin
 cFileName:=ScannerIniFilesPath +FileName;
 if (not FileExists(cFileName)) then
  begin
    NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Config Ini File '}+CFileName+strcom6{'. Default Ini File Used!!'});
    cFileNameDef:=ScannerDefIniFilesPath+ ScannerDefIniFile;
     if (not FileExists(cFileNameDef)) then
      begin
       NoFormUnitLoc.silang1.ShowMessage(strcom7{'No Default Config Ini File '}+cFileNameDef+strcom10);
       Application.Terminate;
      end
      else
      if fileexists(ExeFilePath+ScannerDEfIniFile)
            then  FileCopyStream(ExeFilePath+ScannerDefIniFile,cFileName);
  end;
    result:=cFileName;
end;
function  GetScannerYFileName:string;
var cFileName,cFileNameDef:string;
begin
 cFileName:=ScannerIniFilesPath +ScannerIniFileY;
 if (not FileExists(cFileName)) then
  begin
    NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Config Ini File '}+CFileName+strcom6{'. Default Ini File Used!!'});
    cFileNameDef:=ScannerDefIniFilesPath+ ScannerDefIniFileY;
     if (not FileExists(cFileNameDef)) then
      begin
       NoFormUnitLoc.silang1.ShowMessage(strcom7{'No Default Config Ini File '}+cFileNameDef+strcom10);
       Application.Terminate;
      end
      else
      if fileexists(ExeFilePath+ScannerDEfIniFileY)
            then  FileCopyStream(ExeFilePath+ScannerDefIniFileY,cFileName);
  end;
    result:=cFileName;
end;
*)
procedure SetSchemeName(SchemeName:string);
var SFile:string;
   iniCSPM:TiniFile;
begin
 sFile:=GetConfigFileName;
//   SetFileAttribute_ReadOnly(sfile,false);
   iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
    begin
      WriteString('Scripts','Scheme',SchemeName);
    end;
//    SetFileAttribute_ReadOnly(sfile,true);
  finally
    iniCSPM.Free;
  end;
end;


function  GetDeviceInterfaceName:string;
 var SFile:string;
    iniCSPM:TiniFile;
    commonname:string;
begin
  sFile:=ExeFilePath+'Interface.ini';
 if FileExists(sFile) then
 begin
   iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
     if SectionExists('COMMON') then
       commonname:=ReadString('COMMON','name','NanoeducatorLE');
      if SectionExists(commonname) then
      ProgramName:=ReadString(commonname,'NAME', '')
      else  ProgramName:='NanoeducatorLE';
     end;
  finally
     iniCSPM.Free;
   end;
 end
 else  ProgramName:='NanoeducatorLE';
end;
function GetExePath:string;
begin
  result:=ExtractFilePath(Application.ExeName);
end;
function GetConfigFileName:string;
var cFileName,cFileNameDef:string;
begin
 cFileName:=ConfigIniFilePath + ConfigIniFile;
 if (not FileExists(cFileName)) then
  begin
   // NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Config Ini File '}+CFileName+strcom6{'. Default Ini File Used!!'});
    cFileNameDef:=ConfigDefIniFilePath+ ConfigDefIniFile;
     if (not FileExists(cFileNameDef)) then
      begin
       NoFormUnitLoc.silang1.ShowMessage(strcom7{'No Default Config Ini File '}+cFileNameDef+strcom10);
       Application.Terminate;
      end
      else
      if fileexists(ExeFilePath+ConfigDefIniFile)
            then  FileCopyStream(ExeFilePath+ConfigDefIniFile,cFileName);
  end;
    result:=cFileName;
end;
 function GetConfigUsersFileName:string;
var cFileName,cFileNameDef:string;
begin
 cFileName:=ConfigUsersIniFilePath + ConfigUsersIniFile;
 if (not FileExists(cFileName)) then
  begin
   // NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Config Ini File '}+CFileName+strcom6{'. Default Ini File Used!!'});
    cFileNameDef:=ConfigUsersIniFileDefPath+ ConfigUsersDefIniFile;
     if (not FileExists(cFileNameDef)) then
      begin
       NoFormUnitLoc.silang1.ShowMessage(strcom7{'No Default Config Ini File '}+cFileNameDef+strcom10);
       Application.Terminate;
      end
      else
      if fileexists(ExeFilePath+ConfigUsersDefIniFile)
            then  FileCopyStream(ExeFilePath+ConfigUsersDefIniFile,cFileName);
  end;
    result:=cFileName;
end;
function  GetControllerFileName:string;
var cFileName,cFileNameDef:string;
begin
 cFileName:=ControllerIniFilePath + ControllerIniFile;
 if (not FileExists(cFileName)) then
  begin
 //   NoFormUnitLoc.silang1.ShowMessage(strcom8{'No Config Ini File '}+CFileName+strcom6{'. Default Ini File Used!!'});
    cFileNameDef:=ControllerIniFileDefPath+ ControllerDefIniFile;
     if (not FileExists(cFileNameDef)) then
      begin
       NoFormUnitLoc.silang1.ShowMessage(strcom9{'No Default Config Ini File '}+cFileNameDef+strcom10);
       Application.Terminate;
      end
      else
      if fileexists(ExeFilePath+ControllerDefIniFile)
            then  FileCopyStream(ExeFilePath+ControllerDefIniFile,cFileName);
  end;
    result:=cFileName;
end;
function  GetPaletteFileName:string;
var cFileName,cFileNameDef:string;
begin
 cFileName:=PaletteIniFilePath + PaletteIniFile;
 if (not FileExists(cFileName)) then
  begin
 //   NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Config Ini File '}+CFileName+strcom6{'. Default Ini File Used!!'});
    cFileNameDef:=PaletteDefIniFilePath+ PaletteDefIniFile;
     if (not FileExists(cFileNameDef)) then
      begin
       NoFormUnitLoc.silang1.ShowMessage(strcom7{'No Default Config Ini File '}+cFileNameDef+strcom10);
       Application.Terminate;
      end
      else
      if fileexists(ExeFilePath+PaletteDEfIniFile)
            then  FileCopyStream(ExeFilePath+PaletteDefIniFile,cFileName);
  end;
    result:=cFileName;
end;
function  GetReniShawFileName:string;
var cFileName,cFileNameDef:string;
begin
 cFileName:=PaletteIniFilePath + PaletteIniFile;
 if (not FileExists(cFileName)) then
  begin
    NoFormUnitLoc.silang1.ShowMessage(strcom8{'No Config Ini File '}+CFileName+strcom6{'. Default Ini File Used!!'});
    cFileNameDef:=PaletteDefIniFilePath+ PaletteDefIniFile;
     if (not FileExists(cFileNameDef)) then
      begin
       NoFormUnitLoc.silang1.ShowMessage(strcom9{'No Default Config Ini File '}+cFileNameDef+strcom10);
       Application.Terminate;
      end
      else
      if fileexists(ExeFilePath+PaletteDefIniFile)
            then  FileCopyStream(ExeFilePath+PaletteDefIniFile,cFileName);
  end;
    result:=cFileName;
end;

procedure  SetScriptsName;
 var SFile:string;
   iniCSPM:TiniFile;
begin
 sFile:=GetConfigFileName;
//   SetFileAttribute_ReadOnly(sfile,false);
   iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
    begin
      WriteString('Scripts','Training',TrainScrpt);
      WriteString('Scripts','Scanning', ScanMScrpt);
      WriteString('Scripts','ScanningII', ScanMIIScrpt);
      WriteString('Scripts','Approach', ApproachSMScrpt);
      WriteString('Scripts','ApproachPM',ApproachPMScrpt);
      WriteString('Scripts','SpectroscopySFM',SpectrNScrpt);
      WriteString('Scripts','SpectroscopySTM', SpectrScrptSTM);
      WriteString('Scripts','PhaseZero', PhaseNScrpt);
      WriteString('Scripts','Resonance',ResonanceNScrpt);
      WriteString('Scripts','LithoSFM',LithoScript);
      WriteString('Scripts','AnodeLithoSFM',AnodeLithoScript);
      WriteString('Scripts','FastScanning',ScanFastScrpt);
      WriteString('Scripts','TestPM',PMTestScrpt);
      WriteString('Scripts','TestSM',SMTestScrpt);
      WriteString('Scripts','Etching',EtchingScrpt);
      WriteString('Scripts','ApproachSMX',ApproachSMXScrpt);
    end;
//    SetFileAttribute_ReadOnly(sfile,true);
  finally
    iniCSPM.Free;
  end;
end;

function GetPathMTPDevice:boolean;//string;
Var
  S : String;
  I : Integer;
  VolumeName,FileSystemName : String;
  VolumeSerialNo,MaxComponentLength,FileSystemFlags:LongWord;
begin
result:=false;
S:=GetDisks(DiskHDD); {Получаем список Жёстких дисков (Параметр DiskHDD)}
For I:=1 to Length(S) do {Получаем информацию о всех дисках и пишем в TLabel на форме}
 Begin
  {Если диск существует/вставлен ...}
  if GetHDDInfo(S[I], VolumeName, FileSystemName, VolumeSerialNo, MaxComponentLength, FileSystemFlags)
   then {... тогда собираем информацию}
    if VolumeName='MLPC' then
     begin result:=true; exit; end;
 end;
end;
function GetPathFlash:string;
var
  S : String;
  I : Integer;
  VolumeName,FileSystemName : String;
  VolumeSerialNo,MaxComponentLength,FileSystemFlags:LongWord;
begin
result:='';
S:=GetDisks(DiskFDD); {Получаем список Жёстких дисков (Параметр DiskHDD)}
For I:=1 to Length(S) do {Получаем информацию о всех дисках и пишем в TLabel на форме}
 Begin
  {Если диск существует/вставлен ...}
  if GetHDDInfo(S[I], VolumeName, FileSystemName, VolumeSerialNo, MaxComponentLength, FileSystemFlags)
   then {... тогда собираем информацию}
    if VolumeName='NANOEDU' then
     begin result:=S[I];exit; end;
 end;
end;

function median3 (a1,a2,a3:apitype):apitype;
var Uc:apitype;
begin
          UC:=a1;
     if Uc>a2 then begin a1:=a2; a2:=Uc; Uc:=a2; end  else Uc:=a2;
     if Uc>a3 then begin a2:=a3; a3:=Uc; Uc:=a1; end;
     if Uc>a2 then begin a1:=a2; a2:=Uc;         end;
     Result:=a2;
end;

procedure PaletBrownInit();
var  i:integer;
     RedSet,BlueSet,GreenSet:ColorsSet;
begin
 NRed:=3;
 NGreen:=3;
 NBlue:=3;
 RedSet[1,1]:=0;
 RedSet[2,1]:=0;
 RedSet[1,2]:=0.3;
 RedSet[2,2]:=0.15;         // значение по Оси Х, располож вертикально
 RedSet[1,3]:=1;
 RedSet[2,3]:=1;

 GreenSet[1,1]:=0;
 GreenSet[2,1]:=0;
 GreenSet[1,2]:=0.1;
 GreenSet[2,2]:=0.2;       // значение по Оси Х, располож вертикально
 GreenSet[1,3]:=1;
 GreenSet[2,3]:=1;

 BlueSet[1,1]:=0;
 BlueSet[2,1]:=0;
 BlueSet[1,2]:=0;
 BlueSet[2,2]:=0.6;                // значение по Оси Х, располож вертикально
 BlueSet[1,3]:=1;
 BlueSet[2,3]:=1;

for i:=1 to NRed do
begin
 XR[i]:=RedSet[1,i];
 YR[i]:=RedSet[2,i];
end;
for i:=1 to NGreen do
begin
 XG[i]:=GreenSet[1,i];
 YG[i]:=GreenSet[2,i];
end;
for i:=1 to NBlue do
begin
 XB[i]:=BlueSet[1,i];
 YB[i]:=BlueSet[2,i];
end;
end;

procedure PaletGreyInit();
var  i:integer;
     RedSet:ColorsSet;
begin
 NRed:=2;
 NGreen:=2;
 NBlue:=2;
 redSet[1,1]:=0;
 redSet[2,1]:=0;
 redSet[1,2]:=1;
 redSet[2,2]:=1;         // значение по Оси Х, располож вертикально
for i:=1 to NRed do
 begin
  XR[i]:=redSet[1,i];
  YR[i]:=redSet[2,i];
  XG[i]:=redSet[1,i];
  YG[i]:=redSet[2,i];
  XB[i]:=redSet[1,i];
  YB[i]:=redSet[2,i];
 end;
end;

procedure PaletBlueToRedInit();
var  i:integer;
     RedSet,BlueSet,GreenSet:ColorsSet;
begin
 NRed:=4;
 NGreen:=4;
 NBlue:=4;
 redSet[1,1]:=0;
 redSet[2,1]:=0;
 redSet[1,2]:=0;
 redSet[2,2]:=0.5;         // значение по Оси Х, располож вертикально
 redSet[1,3]:=1;
 redSet[2,3]:=0.75;
 redSet[1,4]:=1;
 redSet[2,4]:=1;

 GreenSet[1,1]:=0;
 GreenSet[2,1]:=0;
 GreenSet[1,2]:=1;
 GreenSet[2,2]:=0.25;       // значение по Оси Х, располож вертикально
 GreenSet[1,3]:=1;
 GreenSet[2,3]:=0.75;
 GreenSet[1,4]:=0;
 GreenSet[2,4]:=1;

 BlueSet[1,1]:=1;
 BlueSet[2,1]:=0;
 BlueSet[1,2]:=1;
 BlueSet[2,2]:=0.25;                // значение по Оси Х, располож вертикально
 BlueSet[1,3]:=0;
 BlueSet[2,3]:=0.5;
 BlueSet[1,4]:=0;
 BlueSet[2,4]:=1;

for i:=1 to NRed do
begin
 XR[i]:=RedSet[1,i];
 YR[i]:=RedSet[2,i];
end;
for i:=1 to NGreen do
begin
 XG[i]:=GreenSet[1,i];
 YG[i]:=GreenSet[2,i];
end;
for i:=1 to NBlue do
begin
 XB[i]:=BlueSet[1,i];
 YB[i]:=BlueSet[2,i];
end;
end;

procedure PaletZebraInit();
var  i:integer;
     RedSet:ColorsSet;
begin
 NRed:=9;
 NGreen:=9;
 NBlue:=9;
 redSet[1,1]:=0;
 redSet[2,1]:=0;
 redSet[1,2]:=1;
 redSet[2,2]:=0.125;         // значение по Оси Х, располож вертикально
 redSet[1,3]:=0;
 redSet[2,3]:=0.25;
 redSet[1,4]:=1;
 redSet[2,4]:=0.375;
 redSet[1,5]:=0;
 redSet[2,5]:=0.5;
 redSet[1,6]:=1;
 redSet[2,6]:=0.625;
 redSet[1,7]:=0;
 redSet[2,7]:=0.75;
 redSet[1,8]:=1;
 redSet[2,8]:=0.875;
 redSet[1,9]:=0;
 redSet[2,9]:=1;

for i:=1 to NRed do
begin
 XR[i]:=RedSet[1,i];
 YR[i]:=RedSet[2,i];
end;
for i:=1 to NGreen do
begin
 XG[i]:=RedSet[1,i];
 YG[i]:=RedSet[2,i];
end;
for i:=1 to NBlue do
begin
 XB[i]:=RedSet[1,i];
 YB[i]:=RedSet[2,i];
end;
end;

procedure PaletColorZebraInit();
var  i:integer;
     RedSet,BlueSet,GreenSet:ColorsSet;
begin
 NRed:=3;
 NGreen:=5;
 NBlue:=4;
 redSet[1,1]:=0;
 redSet[2,1]:=0;
 redSet[1,2]:=0;
 redSet[2,2]:=0.60;         // значение по Оси Х, располож вертикально
 redSet[1,3]:=1;
 redSet[2,3]:=1;

 GreenSet[1,1]:=0;
 GreenSet[2,1]:=0;
 GreenSet[1,2]:=0;
 GreenSet[2,2]:=0.26;       // значение по Оси Х, располож вертикально
 GreenSet[1,3]:=1;
 GreenSet[2,3]:=0.65;
 GreenSet[1,4]:=0;
 GreenSet[2,4]:=0.70;
 GreenSet[1,5]:=0;
 GreenSet[2,5]:=1;

 BlueSet[1,1]:=0;
 BlueSet[2,1]:=0;
 BlueSet[1,2]:=1;
 BlueSet[2,2]:=0.26;                // значение по Оси Х, располож вертикально
 BlueSet[1,3]:=0;
 BlueSet[2,3]:=0.3;
 BlueSet[1,4]:=0;
 BlueSet[2,4]:=1;

for i:=1 to NRed do
begin
 XR[i]:=RedSet[1,i];
 YR[i]:=RedSet[2,i];
end;
for i:=1 to NGreen do
begin
 XG[i]:=GreenSet[1,i];
 YG[i]:=GreenSet[2,i];
end;
for i:=1 to NBlue do
begin
 XB[i]:=BlueSet[1,i];
 YB[i]:=BlueSet[2,i];
end;
end;


procedure LinearApprox(N:integer;const XNod,YNod:ArraySpline; var A0,KL:ArraySpline);
var i:integer;
begin
if N<=1 then exit;
for i:=1 to N-1 do
 begin
  KL[i]:=(YNod[i+1]-YNod[i])/(XNod[i+1]-XNod[i]);
  A0[i]:=YNod[i+1]-KL[i]*XNod[i+1];
 end;
end;

function LEval( N:integer; U:single;const XNod,YNod:ArraySpline;const  A0,KL:ArraySpline):single; //Result (0..1)
const I : integer = 1;
var J,K : integer;
begin
     IF I > N then I:=1;
     IF (U < XNod[I]) or (U > XNod[I+1]) then
      begin
      //
      //  ДBOИЧHЫЙ ПOИCK
      //
        I:=1; J:=N+1;
        repeat
        begin
           K:=(I+J) div 2;
           IF U < XNod[K] then J:=K
                       else I:=K;
           end
        until (J <= (I+1));
      end;
//
//  BЫЧИCЛИTЬ
//
    //  DX:=U-X[I];
      LEval:=A0[i]+KL[i]*U;
end;

procedure EvalPaletteLines();
var i:integer;
   ff:single;
begin
 LinearApprox(NRed,YR,XR,A0R,KLR);
 LinearApprox(NGreen,YG,XG,A0G,KLG);
 LinearApprox(NBlue,YB,XB,A0B,KLB);
for i:=1 to MaxVal do
 begin
   ff:=(LEVAL(NRed,i/256,YR,XR,A0R,KLR));
   if ff>=0 then RDistr[i]:=ff else RDistr[i]:=0;
   if ff>1  then RDistr[i]:=1;
   ff:=(LEVAL(NGreen,i/256,YG,XG,A0G,KLG));
   if ff>=0 then GDistr[i]:=ff else GDistr[i]:=0;
   if ff>1  then GDistr[i]:=1;
   ff:=(LEVAL(NBlue,i/256,YB,XB,A0B,KLB));
   if ff>=0 then BDistr[i]:=ff else BDistr[i]:=0;
   if ff>1  then BDistr[i]:=1;
 end;
end; { procedure EvalPaletteLines();}

procedure LoadPalette(const PaletName:string);
var FL:file;
    str,SFile:string;
    PalIni:TiniFile;
    i:integer;
begin
 sFile:=GetPaletteFileName;
(*  sFile:= PaletteIniFilePath + PaletteIniFile;
  if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    Rewrite(FL);
    CloseFile(FL);
  end;
  *)
    PalIni:=TIniFile.Create(sFile);
 try
    with PalIni do
      begin
       NRed:=ReadInteger(PaletName,'Number of Red Nodes',2 );
       NGreen:=ReadInteger(PaletName,'Number of Green Nodes', 2);
       NBlue:=ReadInteger(PaletName,'Number of Blue Nodes', 2);
        for i:=1 to NRed do
          begin
            XR[i]:=ReadFloatConvert(PalIni,PaletName, 'XR'+IntToStr(i),(i-1));
            YR[i]:=ReadFloatConvert(PalIni,PaletName, 'YR'+IntToStr(i),(i-1));
         // Not Exists, create Grey Palette
          end;
        for i:=1 to NGreen do
         begin
            XG[i]:=ReadFloatConvert(PalIni,PaletName, 'XG'+IntToStr(i),(i-1));
            YG[i]:=ReadFloatConvert(PalIni,PaletName, 'YG'+IntToStr(i),(i-1));
            // Not Exists, create Grey Palette
          end;
        for i:=1 to NBlue do
         begin
          XB[i]:=ReadFloatConvert(PalIni,PaletName, 'XB'+IntToStr(i),(i-1));
          YB[i]:=ReadFloatConvert(PalIni,PaletName, 'YB'+IntToStr(i),(i-1));
         end;
     end;        //with
  finally
    PalIni.Free;
  end;
end; {LoadPalette}

procedure SavePalette(const PaletName:string);
var FL:File;
    PalIni:TiniFile;
    sFile:string;
    i:integer;
begin
 sFile:= PaletteIniFilePath+ PaletteIniFile;
 if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    Rewrite(FL);
    CloseFile(FL);
  end;
 //  SetFileAttribute_ReadOnly(sfile,false);
   PalIni:=TIniFile.Create(sFile);
 try
   with Palini do
     begin
        WriteInteger(PaletName,'Number of Red Nodes', NRed);
        WriteInteger(PaletName,'Number of Green Nodes', NGreen);
        WriteInteger(PaletName,'Number of Blue Nodes', NBlue);
        for i:=1 to NRed do
          begin
           WriteString(PaletName, 'XR'+IntToStr(i),FloatToStrF(XR[i],ffFixed,4,2));
           WriteString(PaletName, 'YR'+IntToStr(i),FloatToStrF(YR[i],ffFixed,4,2));
           end;
        for i:=1 to NGreen do
          begin
           WriteString(PaletName, 'XG'+IntToStr(i),FloatToStrF(XG[i],ffFixed,4,2));
           WriteString(PaletName, 'YG'+IntToStr(i),FloatToStrF(YG[i],ffFixed,4,2));
           end;
        for i:=1 to NBlue do
          begin
           WriteString(PaletName, 'XB'+IntToStr(i),FloatToStrF(XB[i],ffFixed,4,2));
           WriteString(PaletName, 'YB'+IntToStr(i),FloatToStrF(YB[i],ffFixed,4,2));
          end;
   end;

 // SetFileAttribute_ReadOnly(sfile,true);
 finally
   PalIni.Free;
 end;
end; {SavePalette}

procedure LoadDefPaletName(var PaletName:string);
var SFile:string;
    iniCSPM:TiniFile;
begin
  sFile:=GetConfigUsersFileName;
 iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do PaletName:=ReadString('Default Palette','Palette Name','Brown');
 finally
  iniCSPM.Free;
 end;
end;

procedure SaveDefPaletName(const PaletName:string);
var FL:File;
    iniCSPM:TiniFile;
    sFile:string;
begin
 sFile:= ConfigUsersIniFilePath + ConfigUsersIniFile;
 if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    Rewrite(FL);
    CloseFile(FL);
  end;
 // SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
  iniCSPM.WriteString('Default Palette','Palette Name', PaletName);
//  SetFileAttribute_ReadOnly(sfile,true);
 finally
   iniCSPM.Free;
 end;
end;
function AdScannerToDbase:boolean;
var scannerpath:string;
begin
  result:=false;
  scannerpath:=ScannerIniBasePath+HardWareOpt.ScannerNumb;
 if not DirectoryExists(scannerpath) then
 begin
    CreateDir(scannerpath);
    SaveAdapterDataToInifiles;
 end;
end;
function  FindScannerInDbase:boolean;
var scannerpath:string;
begin
  scannerpath:=ScannerIniBasePath+HardWareOpt.ScannerNumb;
  result:=true;
 if not DirectoryExists(scannerpath) then result:=false;
end;
function  InitParametersNanoEduLE:boolean;
begin
      case  flgUnit of
grand:begin
        ScanAreaStartXR:=500000;
        ScanAreaStartYR:=500000;
        ScanAreaStartXF:=0;
        ScanAreaStartYF:=0;
      end;
ProBeam,
MicProbe: begin
        ScanAreaStartXR:=1000;
        ScanAreaStartYR:=1000;
        ScanAreaStartXF:=100;
        ScanAreaStartYF:=100;
      end;
 nano,
 Pipette,
 Terra:begin
//  X0:=-round((X0nm+Scanparams.xshift)*TransformUnit.XPnm_d)+CSPMSignals[8].MaxDiscr;       //discrets   add P
// y0:=-round((y0nm+Scanparams.yshift)*TransformUnit.yPnm_d)+CSPMSignals[9].MaxDiscr;       //discrets   add P
   if flgCurrentUserLevel<>Demo then
       begin
        ScanAreaStartXR:=round(CSPMSignals[8].MaxDiscr/TransformUnit.XPnm_d-Scanparams.xshift);   //!!!!!! 23/11/12
        ScanAreaStartYR:=round(CSPMSignals[9].MaxDiscr/TransformUnit.YPnm_d-Scanparams.yshift);
       end
       else
       begin
        ScanAreaStartXR:=5000;
        ScanAreaStartYR:=5000;
       end;
       ScanAreaStartXF:=1000;
       ScanAreaStartYF:=1000;
      end;
 baby:begin
       ScanAreaStartXR:=100;
       ScanAreaStartYR:=100;
       ScanAreaStartXF:=10;
       ScanAreaStartYF:=10;
      end;
          end;
     HardWareOpt.ScannerNumb:=lowercase('default');
     ScannerIniFilesPath:= ScannerIniFilesDefaultPath;//  ExeFilePath;//
     ScannerDefIniFilesPath:=ScannerIniFilesDefaultPath;
end;
function  InitParametersNanoEdu:boolean;
var tflgFlash:Boolean;
begin
       result:=true;
       FlgStopApproach:=true;
       FlgApproachOK:=false;
       FlgResonance:=False;
       flgLeftView:=True;
       flgRightView:=True;
       FlgLeaveEnabled:=False;     //enabled edit scanner parameters
       CountStart:=0;
       CountClose:=0;
       CountCapture:=0;
     case  flgUnit of
grand:begin
        ScanAreaStartXR:=500000;
        ScanAreaStartYR:=500000;
        ScanAreaStartXF:=0;
        ScanAreaStartYF:=0;
      end;
 ProBeam,
 micProbe: begin
        ScanAreaStartXR:=1000;
        ScanAreaStartYR:=1000;
        ScanAreaStartXF:=100;
        ScanAreaStartYF:=100;
      end;
 nano,
 Pipette,
 terra:begin
//  X0:=-round((X0nm+Scanparams.xshift)*TransformUnit.XPnm_d)+CSPMSignals[8].MaxDiscr;       //discrets   add P
// y0:=-round((y0nm+Scanparams.yshift)*TransformUnit.yPnm_d)+CSPMSignals[9].MaxDiscr;       //discrets   add P

       ScanAreaStartXR:=5000;
       ScanAreaStartYR:=5000;
       ScanAreaStartXF:=1000;
       ScanAreaStartYF:=1000;
      end;
 baby:begin
       ScanAreaStartXR:=100;
       ScanAreaStartYR:=100;
       ScanAreaStartXF:=10;
       ScanAreaStartYF:=10;
      end;
          end;
     HardWareOpt.ScannerNumb:=lowercase('default');
     ScannerIniFilesPath:=  ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';//  ExeFilePath;//
     ScannerDefIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';//ExeFilePath;// IniFilesPath:=ExeFilePath;
end;

function SetDefaultIniFilesPath:boolean;
begin
   ScannerIniFilesPath:=ScannerIniFilesDefaultPath;
end;
function SetDemoIniFilesPath:boolean;
begin
   ScannerIniFilesPath:=ScannerIniFilesDemoPath;
end;

function SetScannerIniPath:boolean;
var tflgFlash:Boolean;
begin
  case  flgUnit  of
nano,
Pipette,
Terra:
     begin
        ScannerIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
        ScannerDefIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
     end  ;
baby:begin
//        ScannerIniFilesPath:=ExeFilePath+ScannerAtomicUnitPath;
//        ScannerDefIniFilesPath:=ExeFilePath+ScannerAtomicUnitPath;
        ScannerIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
        ScannerDefIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
        PathFlash:='';
      end;
grand:begin
 //       ScannerIniFilesPath:=ExeFilePath+ScannerStepMotorUnitPath;
//        ScannerDefIniFilesPath:=ExeFilePath+ScannerStepMotorUnitPath;
        ScannerIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
        ScannerDefIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
        PathFlash:='';
      end;
ProBeam,
MicProbe: begin
 //       ScannerIniFilesPath:=ExeFilePath+ScannerSEMUnitPath;
//        ScannerDefIniFilesPath:=ExeFilePath+ScannerSEMUnitPath;
        ScannerIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
        ScannerDefIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
        PathFlash:='';
      end;
             end;//case
       FlgRenishawUnitExists:=fileexists(ScannerIniFilesPath+ScannerReniSIniFile);
     //   GetScriptsName;      // Перенесено в Main, после InitParametersNanoEdu, т.к. здесь задается путь к схеме
  //   SetFileAttribute_ReadOnly(false); //      change halt on application.terminate
end;

procedure InitDirectories;
begin
   //    ProgramName:='NanoeducatorLE';
       //ProgramName:=ChangeFileExt(ExtractFileName(Application.ExeName), '');
       ScannerIniFilesPath:='';
       PaletteIniFile:=   'SPMPalettes.ini';
       PaletteDefIniFile:='SPMPalettesDef.ini';
       case flgUnit of
baby,
Nano,
Pipette,
terra,
ProBeam,MicProbe,
grand:begin
           ScannerIniFile:=     ScannerIniFileX;
           ScannerDefIniFile:=  ScannerDefIniFileX;
      end;
                end;

       ScannerStepMotorUnitPath:='StepMotorUnit\';
       ScannerAtomicUnitPath:='AtomicUnit\';
       ScannerSEMUnitPath:='SEMUnit\' ;
       WorkNameFileMask:='ScanData';
       WorkNameFileMaskDef:= WorkNameFileMask;//'ScanData';
       WorkNameFileMaskDemo:='ScanDataDemo';
       WorkNameFileMaskCur:=WorkNameFileMaskDef;
       WorkExtFile:='.spm';
       ModExtFile:='.mspm';
       WorkFileMask:='*'+ WorkExtFile;
       ExeFilePath:=ExtractFilePath(Application.ExeName);       ///????????????????
       SchemePath:= ExeFilePath+'scheme\';
       AlgorithmPath:=ExeFilePath+'javabin\';
       GetSpecialDirPath;
       ScanGalleryDir:=CommonNanoeduDocumentsPath+'gallery';
       ScannerIniBasePath:=ExeFilePath+'scannerinidbase\';
       ScannerIniFilesDemoPath:=ScannerIniBasePath+'demo\';
       ScannerIniFilesDefaultPath:=ScannerIniBasePath+'default\';
       UserIniFilesPath:=UserNanoeduApplDataPath;
       InitParamFileJava:='algoritmparams.bin';
       InitParamFileJavaPath:=UserNanoeduApplDataPath;
       MaskLithoFileJavaPath:=UserNanoeduApplDataPath;
       MaskLithoFileJava:='lithomask.bin';
       FileToMemoryWrite:='filetomemory.bin';
       UserIniFilesDefPath:=ExeFilePath;
       ConfigUsersIniFilePath:=UserIniFilesPath;
       ConfigIniFilePath:=ExeFilePath;
       ConfigDefIniFilePath:=ExeFilePath;
       ConfigUsersIniFileDefPath:=ExeFilePath;
       InstallFlashplayerpath:=ExeFilePath+'flashplayer\swp_flv_player.exe';
       ConfigLabListFilePath :=UserNanoeduApplDataPath{ExeFilePath}+'DemoData\';
       PaletteIniFilePath:={CommonNanoeduApplDataPath;//}UserIniFilesPath;
       PaletteDefIniFilePath:=ExeFilePath;
       UpdatesIniFilePath:={CommonNanoeduApplDataPath;//}UserIniFilesPath;
       ControllerIniFilePath:={CommonNanoeduApplDataPath;//}UserIniFilesPath;//ExeFilePath;
       ControllerIniFileDefPath:=ExeFilePath;
       ReportTemplPath:='ReportTmpl\';
       ReportTemplRDefPath:=ReportTemplPath+'rus\';
       ReportTemplEDefPath:=ReportTemplPath+'eng\';
    //   ReportTemplPath:=CommonNanoeduApplDataPath;
       TempDirectory:=UserNanoeduDocumentsPath+'\Temp\';
       DemoDataDirectory:=exefilepath{UserNanoeduApplDataPath}+'DemoData\';   //?????
  if not DirectoryExists(TempDirectory)                  then CreateDir(TempDirectory);
  if not DirectoryExists(CommonNanoeduDocumentsPath+ReportTemplPath)     then CreateDir(CommonNanoeduDocumentsPath+ReportTemplPath);
  if not DirectoryExists(CommonNanoeduDocumentsPath+ReportTemplRDefPath) then CreateDir(CommonNanoeduDocumentsPath+ReportTemplRDefPath);
  if not DirectoryExists(CommonNanoeduDocumentsPath+ReportTemplEDefPath) then CreateDir(CommonNanoeduDocumentsPath+ReportTemplEDefPath);

  //flgAdmin:=false;
// if not flgAdmin then
//  begin
   if (not  fileExists(ConfigUsersIniFilePath+ConfigUsersIniFile)) {or flgNewVersion}   then
    if fileexists(ExeFilePath+ConfigUsersDefIniFile)   then
    begin
      FileCopyStream(ExeFilePath+ConfigUsersDefIniFile,ConfigUsersIniFilePath+ConfigUsersIniFile);
      SetFirstStartParams;
      flgNewVersion:=true;
    end
    else
    begin
     flgNewVersion:=TestAndSetNewVersion;          //
     if flgNewVersion then
      if fileexists(ExeFilePath+ConfigUsersDefIniFile)   then
       begin
        FileCopyStream(ExeFilePath+ConfigUsersDefIniFile,ConfigUsersIniFilePath+ConfigUsersIniFile);
        SetFirstStartParams;
       end;
   end;

    if (not  fileExists(UserNanoeduApplDataPath+ScannerIniFile))or flgNewVersion then
     if fileexists(ExeFilePath+ScannerDefIniFile) then  FileCopyStream(ExeFilePath+ScannerDefIniFile,UserNanoeduApplDataPath+ScannerIniFile);

    if (not  fileExists(UserNanoeduApplDataPath+ScannerIniFileY))or flgNewVersion then
     if fileexists(ExeFilePath+ScannerDefIniFileY) then  FileCopyStream(ExeFilePath+ScannerDefIniFileY,UserNanoeduApplDataPath+ScannerIniFileY);

   if (not  fileExists(PaletteIniFilePath+PaletteIniFile))or flgNewVersion then
    if fileexists(ExeFilePath+PaletteIniFile) then  FileCopyStream(ExeFilePath+PaletteIniFile,PaletteIniFilePath+PaletteIniFile);
 //  if (not  fileExists(UpdatesIniFilePath+UpdatesIniFile))or flgNewVersion then
 //   if fileexists(ExeFilePath+UpdatesIniFile) then  FileCopyStream(ExeFilePath+UpdatesIniFile,UpdatesIniFilePath+UpdatesIniFile);
//   if (not  fileExists(ControllerInifileDefPath+ControllerIniFile))or flgNewVersion then
//    if fileexists(ExeFilePath+ControllerIniFile) then  FileCopyStream(ExeFilePath+ControllerIniFile,ControllerIniFileDefPath+ControllerIniFile);
  //   CopyReportTemplFilestoUserDir;
    if not directoryExists(CommonNanoeduDocumentsPath) then CreateDir(CommonNanoeduDocumentsPath);
    if not directoryExists(CommonNanoeduDocumentsPath+ReportTemplRDefPath) then CreateDir(CommonNanoeduDocumentsPath+ReportTemplRDefPath);
    if (not  fileExists(CommonNanoeduDocumentsPath+ReportTemplRDefPath+'lab1_r.tmpl')) or flgNewVersion then
    if fileexists(ExeFilePath+ReportTemplRDefPath+'lab1_r.tmpl') then  FileCopyStream(ExeFilePath+ReportTemplRDefPath+'lab1_r.tmpl',CommonNanoeduDocumentsPath+ReportTemplRDefPath+'lab1_r.tmpl');
   if (not  fileExists(CommonNanoeduDocumentsPath+ReportTemplEDefPath+'lab1_e.tmpl')) or flgNewVersion then
    if fileexists(ExeFilePath+ReportTemplEDefPath+'lab1_e.tmpl') then  FileCopyStream(ExeFilePath+ReportTemplEDefPath+'lab1_e.tmpl',CommonNanoeduDocumentsPath+ReportTemplEDefPath+'lab1_e.tmpl');
   if (not  fileExists(CommonNanoeduDocumentsPath+ReportTemplRDefPath+'default.tmpl'))  then
    if fileexists(ExeFilePath+ReportTemplRDefPath+'default.tmpl') then  FileCopyStream(ExeFilePath+ReportTemplRDefPath+'default.tmpl',CommonNanoeduDocumentsPath+ReportTemplRDefPath+'default.tmpl');
   if (not  fileExists(CommonNanoeduDocumentsPath+ReportTemplEDefPath+'default.tmpl')) then
    if fileexists(ExeFilePath+ReportTemplEDefPath+'default.tmpl') then  FileCopyStream(ExeFilePath+ReportTemplEDefPath+'default.tmpl',CommonNanoeduDocumentsPath+ReportTemplEDefPath+'default.tmpl');
//  end;
end;
procedure InitTutor;
var InitialDirVideo,
    InitialDirExp,
    InitialDirSim:string;
    SFile:string;
    iniCSPM:TiniFile;
function  findobject(dir:string):string;
var
   ires:integer;
   sSr:TsearchRec;
begin
   ires:=FindFirst(dir,faAnyFile,sSR);
   while (ires = 0)  do
        begin
          result:=sSR.Name;
          ires:=FindNext(sSR);
        end;
    FindClose(sSR);
end;
begin
 if lang = 2 then
  begin
   InitialDirVideo:=CommonNanoeduDocumentsPath+'video' +'\rus\';
   InitialDirExp:=CommonNanoeduDocumentsPath+'docs\rus\Experiment\';
   InitialDirSim:=CommonNanoeduDocumentsPath+'docs\rus\Simulator\';
  end
  else
  begin
   InitialDirVideo:=CommonNanoeduDocumentsPath+'video' +'\eng\';
   InitialDirExp:=CommonNanoeduDocumentsPath+'docs\eng\Experiment\';
   InitialDirSim:=CommonNanoeduDocumentsPath+'docs\eng\Simulator\';
  end;
//  tutvideo:=InitialDirVideo+findobject(InitialDirVideo+'*.*');
//  tutexperiment:=InitialDirExp+findobject(InitialDirExp+'*.pdf');
//  tutsimulator:=InitialDirSim+findobject(InitialDirSim+'*.pdf');
  sFile:=GetConfigUsersFileName;
 iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
  begin
   tutexperimentrus:=ReadString('docs','manualrus','');
   tutsimulatorrus:=ReadString('docs','simulatorrus','');
   tutexperimenteng:=ReadString('docs','manualeng','');
   tutsimulatoreng:=ReadString('docs','simulatoreng','');
   tutvideorus:=ReadString('docs','videorus','');
   tutanimarus:=ReadString('docs','animarus','');
   tutvideoeng:=ReadString('docs','videoeng','');
   flgShowSmeshariki:=boolean(ReadInteger('docs','showanima',1));
   flgShow3DVideo:=boolean(ReadInteger('docs','show3dvideo',1))
  end;
 finally
  iniCSPM.Free;
 end;

end;
procedure InitParametersAxes;
begin
    TopoUnitsnmZ.text:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_37' (* 'nm' *) );
    TopoUnitsnmZ.coef:=1;
    TopoUnitsnmZ.limit:=2000;
    TopoUnitsnmXY.text:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_37' (* 'nm' *) );
    TopoUnitsnmXY.coef:=1;
    TopoUnitsnmXY.limit:=2000;
    mcrn:=#181+'m';
    if Lang=2 then     mcrn:='мкм' ;
    TopoUnitsmcnXY.text:=mcrn;
    TopoUnitsmcnXY.coef:=1000;
    TopoUnitsmcnXY.limit:=2000;
    TopoUnitsmcnZ.text:=mcrn;
    TopoUnitsmcnZ.coef:=1000;
    TopoUnitsmcnZ.limit:=2000;
    PhaseUnits.text:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_36' (* 'a.u' *) );
    PhaseUnits.coef:=1;
    PhaseUnits.limit:=2000;
    ForceUnits.text:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_40' (* 'mV' *) );
    ForceUnits.coef:=1;
    ForceUnits.Limit:=1;
    CurrentUnits.text:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_42' (* 'nA' *) );
    CurrentUnits.coef:=1;
    CurrentUnits.Limit:=1;
  //  TopoUnitsZ:=TopoUNitsnmZ;
 //   TopoUnitsX:=TopoUNitsnmXY;
 //   TopoUnitsY:=TopoUNitsnmXY;
    OneLineTopoUnits.text:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_360' (* 't,c' *) );
    OneLineTopoUnits.coef:=1;
    OneLineTopoUnits.limit:=1;
end;

procedure InitParameters;
var I:integer;
begin
//   ScanmethodSetZnm:=ScanmethodSetTopo+ScanmethodSetOneL;
  ScanmethodSetLitho:= [Litho,LithoCurrent];
  ScanmethodSetTopo:=[Topography,Litho,LithoCurrent];
  ScanmethodSetOneL:=[OneLineScan];
  ScanmethodSetZnm:=ScanmethodSetTopo+ScanmethodSetOneL;
  ScanmethodSetZAm:=[Current,FastScan];
  ScanmethodSetZph:=[Phase,FastScanPhase];
  ScanmethodSetAdd:=[Phase,BackPass,FastScanPhase,UAM,BackPass,WorkF,Current,FastScan];
  ScanmethodSetNoAdd:=[Topography,Litho,LithoCurrent,OneLineScan];
  ScanmethodSetZUAM:=[UAM];
  ScanmethodSetSpectr:=[Spectr];
  ScanmethodSetTopoErr:=[TopoError];
  ScanmethodSetZwrk:=[workf];
  ScanmethodSetNeedV:=[Current,FastScan];
  ScanmethodSetFast:=[FastScan,FastScanPhase];
   FlgViewDef:=D2Geo;
    flgLinVisible:=False;
    TopStart:=20;
 //   ITCor:=2;        240112
    ITCor:=1;
    LeftStart:=10;

//  BitmapStart:=TBitmap.Create;
//  BitmapStart.Handle := LoadBitmap(hInstance, 'START');
//  BitmapStop := TBitmap.Create;
//  BitmapStop.Handle := LoadBitmap(hInstance, 'STOP');
        //material parameters
        //izumrud
       for i:=0 to 8 do  strcomment[i]:=' ';
             ltposition0[0]:=-20.0;
             ltposition0[1]:=-20.0;
             ltposition0[2]:=20.0;      //20
             ltposition0[3]:=1.0;
             ltposition1[0]:=-20.0;
             ltposition1[1]:=20.0;
             ltposition1[2]:=20.0;//-20
             ltposition1[3]:=1.0;
             L1ambient[0]:=0.0;
             L1ambient[1]:=0.0;
             L1ambient[2]:=0.0;
             L1ambient[3]:=1.0;
             L1diffuse[0]:=1.0;
             L1diffuse[1]:=1.0;
             L1diffuse[2]:=1.0;
             L1diffuse[3]:=1.0;
             L2ambient[0]:=0.0;
             L2ambient[1]:=0.0;
             L2ambient[2]:=0.0;
             L2ambient[3]:=1.0;
             L2diffuse[0]:=1.0;
             L2diffuse[1]:=1.0;
             L2diffuse[2]:=1.0;
             L2diffuse[3]:=1.0;

      ColorMaterial:=2; //bronze

       case   ColorMaterial of
   0: renderTeapot (0.0215, 0.1745, 0.0215,0.07568, 0.61424, 0.07568, 0.633, 0.727811, 0.633, 0.6);
   1: renderTeapot (0.329412, 0.223529, 0.027451, 0.780392, 0.568627, 0.113725, 0.992157, 0.941176, 0.807843,0.21794872);
   2: renderTeapot (0.2125, 0.1275, 0.054,0.714, 0.4284, 0.18144, 0.393548, 0.271906, 0.166721, 0.2);
   3: renderTeapot (0.25, 0.25, 0.25,0.4, 0.4, 0.4, 0.774597, 0.774597, 0.774597, 0.6);
   4: renderTeapot (0.19125, 0.0735, 0.0225,0.7038, 0.27048, 0.0828, 0.256777, 0.137622, 0.086014, 0.1);
   5: renderTeapot (0.24725, 0.1995, 0.0745,0.75164, 0.60648, 0.22648, 0.628281, 0.555802, 0.366065, 0.4);
   6: renderTeapot (0.19225, 0.19225, 0.19225,0.50754, 0.50754, 0.50754, 0.508273, 0.508273, 0.508273, 0.4);
   7: renderTeapot (0.135, 0.2225, 0.1575, 0.54, 0.89, 0.63, 0.316228, 0.316228, 0.316228, 0.1);
   8: renderTeapot (0.05375, 0.05, 0.06625,0.18275, 0.17, 0.22525, 0.332741, 0.328634, 0.346435, 0.3);
   9: renderTeapot (0.25, 0.20725, 0.20725,1, 0.829, 0.829, 0.296648, 0.296648, 0.296648, 0.088);
   10:renderTeapot (0.1745, 0.01175, 0.01175,0.61424, 0.04136, 0.04136, 0.727811, 0.626959, 0.626959, 0.6);
   11:renderTeapot (0.1, 0.18725, 0.1745, 0.396, 0.74151, 0.69102, 0.297254, 0.30829, 0.306678, 0.1);
   12:renderTeapot (0.24725, 0.1995, 0.0745,0.75164, 0.60648, 0.22648, 0.628281, 0.555802, 0.366065, 0.4);
   13:renderTeapot (0.19225, 0.19225, 0.19225,0.50754, 0.50754, 0.50754, 0.508273, 0.508273, 0.508273, 0.4);
   14:renderTeapot (0.0, 0.0, 0.0, 0.01, 0.01, 0.01, 0.50, 0.50, 0.50, 0.25);
   15:renderTeapot (0.0, 0.1, 0.06, 0.0, 0.50980392, 0.50980392, 0.50196078, 0.50196078, 0.50196078, 0.25);
   16:renderTeapot (0.0, 0.0, 0.0, 0.1, 0.35, 0.1, 0.45, 0.55, 0.45, 0.25);
   17:renderTeapot (0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.7, 0.6, 0.6, 0.25);
   18:renderTeapot (0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 0.70, 0.70, 0.70, 0.25);
   19:renderTeapot (0.0, 0.0, 0.0, 0.5, 0.5, 0.0,0.60, 0.60, 0.50, 0.25);
   20:renderTeapot (0.02, 0.02, 0.02, 0.01, 0.01,0.01,0.4, 0.4, 0.4, 0.078125);
   21:renderTeapot (0.0, 0.05, 0.05, 0.4, 0.5, 0.5,0.04, 0.7, 0.7, 0.078125);
   22:renderTeapot (0.0, 0.05, 0.0, 0.4, 0.5, 0.4,0.04, 0.7, 0.04, 0.078125);
   23:renderTeapot (0.05, 0.0, 0.0, 0.5, 0.4, 0.4,0.7, 0.04, 0.04, 0.078125);
   24:renderTeapot (0.05, 0.05, 0.05, 0.5, 0.5, 0.5,0.7, 0.7, 0.7, 0.078125);
   25:renderTeapot (0.05, 0.05, 0.0, 0.5, 0.5, 0.4,0.7, 0.7, 0.04, 0.078125);
            end;
// LoadPalette('Brown');        // Reads PaletteIni File;
// EvalPaletteLines();
    LoadDefPaletName(DefPaletName);    // Reads ConfigIni File
    PaletteName:=DefPaletName;
    LoadPalette(DefPaletName);        // Reads PaletteIni File;
    EvalPaletteLines();
    FixedPalette();                   // SCAN DRAW PALLETE
    InitParametersAxes;
end;
function  ConvertStringToFloat(S:string):single;
var sep:string;
begin
   sep:='.';
   if DecimalSeparator='.' then sep:=',';
   if not AnsiContainsText(s,DecimalSeparator) then  s:=AnsiReplaceStr(s,sep,DecimalSeparator);
   result:=strtofloat(s);
end;
function ExecAndWait(const FileName, Params: ShortString; const WinState: Word): boolean;
 var StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
   CmdLine: ShortString;
  begin { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
   CmdLine := '"' + Filename + '" ' + Params;
   FillChar(StartInfo, SizeOf(StartInfo), #0);
   with StartInfo do
    begin //cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
    end;
     Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
     { Ожидаем завершения приложения }
    if Result then
     begin
      WaitForSingleObject(ProcInfo.hProcess, INFINITE); { Free the Handles }
      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);
     end;
  end;

procedure SetXYMax;
var XMaxTmp,YMaxTmp, XMaxTmp1,YMaxTmp1:single;    //nm
    A,A1:single;
    buf:single;
    UDiscr:integer; //nm = 32767
begin
     with HardWareOpt do
           begin           { TODO : 041012 }
            XMaxTmp:=((CSPMSignals[8].MaxV-CSPMSignals[8].MinV)*ScannerOptModY.SensitivX*AMPGainX);
            YMaxTmp:=((CSPMSignals[9].MaxV-CSPMSignals[9].MinV)*ScannerOptModY.SensitivY*AMPGainY);
              if (HardWareOpt.XYtune='Rough') and ScannerCorrect.FlgXYLinear then
               begin
                  UDiscr:= floor((CSPMSignals[8].MaxV-CSPMSignals[8].MinV)*ScannerOptModY.SensitivX*AMPGainX);
                  XMaxTmp:=(UDiscr-ScannerOptModY.ApprLineX0)/ScannerOptModY.ApprLineXKoef;
                  if XMaxTmp>UDiscr then XMaxTmp:=UDiscr;
                  UDiscr:= floor((CSPMSignals[9].MaxV-CSPMSignals[9].MinV)*ScannerOptModY.SensitivY*AMPGainY);
                  YMaxTmp:=(UDiscr-ScannerOptModY.ApprLineY0)/ScannerOptModY.ApprLineYKoef;
                  if YMaxTmp>UDiscr then YMaxTmp:=UDiscr;
                  buf:=  XMaxTmp;
                  XMaxTmp:=XMaxTmp-abs(YMaxTmp*ScannerOptModX.YBiasTan);
                  YMaxTmp:=YMaxTmp-abs(buf*ScannerOptModX.YBiasTan);
                end ;

               A:=min( XMaxTmp,YMaxTmp);
               XMaxTmp1:=((CSPMSignals[8].MaxV-CSPMSignals[8].MinV)*ScannerOptModX.SensitivX*AMPGainX);
               YMaxTmp1:=((CSPMSignals[9].MaxV-CSPMSignals[9].MinV)*ScannerOptModX.SensitivY*AMPGainY);
             if (HardWareOpt.XYtune='Rough') and ScannerCorrect.FlgXYLinear then
              begin
                  UDiscr:= floor((CSPMSignals[8].MaxV-CSPMSignals[8].MinV)*ScannerOptModX.SensitivX*AMPGainX);
                  XMaxTmp1:=(UDiscr-ScannerOptModX.ApprLineX0)/ScannerOptModX.ApprLineXKoef;
                  if XMaxTmp1>UDiscr then XMaxTmp1:=UDiscr;
                  UDiscr:= floor((CSPMSignals[9].MaxV-CSPMSignals[9].MinV)*ScannerOptModX.SensitivY*AMPGainY);
                  YMaxTmp1:=(UDiscr-ScannerOptModX.ApprLineY0)/ScannerOptModX.ApprLineYKoef;
                  if YMaxTmp1>UDiscr then YMaxTmp1:=UDiscr;
                  buf:=  XMaxTmp1;
                  XMaxTmp1:=XMaxTmp1-abs(YMaxTmp1*ScannerOptModY.YBiasTan);
                  YMaxTmp1:=YMaxTmp1-abs(buf*ScannerOptModY.YBiasTan);
              end;
             A1:= min( XMaxTmp1,YMaxTmp1);
           end;
         ScanParams.XMax:=min(A,A1)-ScanParams.Xshift ;
         ScanParams.YMax:=ScanParams.XMax;
         if FlgUnit=grand then
         begin
          if ScanParams.XMax>10E6 then ScanParams.XMax:=10E6;
          ScanParams.YMax:=ScanParams.XMax
         end;
         if flgRenishawUnit then
         begin
           ScanParams.XMax:=ScanParams.XMax*0.8;
           ScanParams.YMax:=ScanParams.XMax;
         end;
end;

procedure  CreateNewScanner(scannername:string);
var DefinifilesPath, fname:string;
begin
   DefinifilesPath:= ScannerIniBasePath+'default\';
   ScannerIniFilesPath:=  ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';//  ExeFilePath;//
   ScannerDefIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
          CreateDir(ScannerIniFilesPath) ;
          fname:=Scannerinifilex;
          FileCopyStream(DefinifilesPath+fname,ScannerIniFilesPath+fname);
          SaveScannernametoIni(scannername, ScannerIniFilesPath+fname);

          fname:=ScannerinifileY;
           FileCopyStream(DefinifilesPath+fname,ScannerIniFilesPath+fname);
           SaveScannernametoIni(scannername, ScannerIniFilesPath+fname);
           fname:=ScannerdefinifileX;
           FileCopyStream(DefinifilesPath+fname,ScannerIniFilesPath+fname);
           SaveScannernametoIni(scannername, ScannerIniFilesPath+fname);

          fname:=ScannerdefinifileY;
           FileCopyStream(DefinifilesPath+fname,ScannerIniFilesPath+fname);
           SaveScannernametoIni(scannername, ScannerIniFilesPath+fname);
end;

function   DemoSmooth_bySpeed(ScanSpeed:single):single;
begin
  if ScanSpeed <= 1000       then   result:=0
  else if ScanSpeed <= 2000  then   result:=200
  else if ScanSpeed <= 4000  then   result:=400
  else if ScanSpeed <= 6000  then   result:=500
  else if ScanSpeed <= 8000  then   result:=700
  else if ScanSpeed <= 10000 then   result:=900
  else if ScanSpeed <= 16000 then   result:=1100
  else result:=1300;
end;

function  DemoDepth_byFBGain(FBGain:double):single;
var val:pidtype;  // double
begin
  if FBGain < 0 then  result:= FBGain*100     // усиление меньше, чем в исходной картинке,
                                                // значит, глубину рельефа надо уменьшить
  else
    begin
     val:= abs(FBGain);
     result:= 80*sqrt(val);         // усиление больше, чем в исходной картинке,
                                    // значит, глубину рельефа надо увеличить
    end;
end;


function   DemoLithoDepth(Action:single):single;
begin
 if ScanParams.ScanMethod = Litho then  result:= Action
                                  else
                                  if ScanParams.ScanMethod = LithoCurrent then result:= 50*Action ; // В этом случае Delta_Action в вольтах                                                              // 50 - эмпирический коэффициент
end;

function   DemoNoise_byFBGain(FBGain:double):datatype;
var val:pidtype;
begin
  if FBGain < 0 then  result:=0     // усиление меньше, чем в исходной картинке,
                                          // дополнительные шумы не нужны
  else begin
   val:= (FBGain);
 (* if val < 2 then
        result:=0
  else if val < 4 then
      result:=4
  else if val < 10 then
      result:=8
 else if val < 30 then
      result:=14 //20
 else if val < 100 then
      result:=25 //100
 else if val < 150 then
      result:=100  //200
 else result:=200 //500;    *)
     result:=round(8*sqrt(val));
  end;
end;

function   DemoNoise_bySpeed(Speed:double):datatype;
var val:pidtype;
begin
  if Speed < 0 then  result:=0     // скорость меньше, чем в исходной картинке,
                                   // дополнительные шумы не нужны
  else begin
   val:= (Speed);
    result:=round(sqrt(val));      //2
  end;
end;

procedure  CorrectImgSection_Smooth(DemoSmoothnm:single ; var ImgLine:TLine);
var i, L:integer;
    SmoothMatrSize:integer;
    bufLine:TLine;

begin
 SmoothMatrSize:= round(DemoSmoothnm/Scanparams.StepXY);
 if not odd(SmoothMatrSize) then dec(SmoothMatrSize);  // нечетный размер матрицы
 if SmoothMatrSize <=2 then
 begin
   exit;
 end
 else
 begin
   L:=Length(ImgLine);
   SetLength(bufLine, L);
  for I := 0 to L - 1 do   bufline[i]:=ImgLine[i];
 //  Convolution(bufLine,ScanParams.ScanPoints,SmoothMatrSize);
  ConvolutionI(bufLine, SmoothMatrSize);
  for I := 0 to L - 1 do       ImgLine[i]:=round(bufline[i]);
  finalize( bufline);
 end;
end;

procedure  CorrectImgSection_depth(DemoDepthnm:single ; var ImgLine:TLine);
 var DepthKoef:single;
     i, L:integer;
     bufval:double;
     minLineVal, newminLineVal, deltVal:double;
     maxLineVal, newmaxLineVal:double;
     isfA, isfB:single;
     tempLine:TLineSingle;
 begin
   DepthKoef:=(2300+DemoDepthnm)/2300;
   L:= Length(ImgLine);
   SetLength(tempLine, L);
   minLineVal:=(ImgLine[0]) ;
   maxLineVal:=(ImgLine[0]) ;
   for I := 0 to L - 1 do
        begin
         if ImgLine[i] < minLineVal then minLineVal:= ImgLine[i];
         if ImgLine[i] > maxLineVal then maxLineVal:= ImgLine[i];
         tempLine[i]:= ImgLine[i];
        end;

  LinDelFiltPlaneParm(L,TempLine,isfA,isfB);     // Вычисление параметров наклона
  for I := 0 to L - 1 do
    TempLine[i]:=DepthKoef*(TempLine[i]-(isfA+i*iSfb));  //   вычитание наклона и масштабирование

   for I := 0 to L - 1 do
     begin
       TempLine[i]:=(TempLine[i]+(isfA+i*iSfb));      // Восстановление наклона
     end;
 (*   newminLineVal:=( TempLine[0]) ;             // нахождение нового минимума
   for I := 0 to L - 1 do
         if  TempLine[i] < newminLineVal then newminLineVal:=  TempLine[i];

   deltVal:= minLineVal- newminLineVal;
   for I := 0 to Length(ImgLine) - 1 do
       begin
         bufval:= TempLine[i]+ deltVal;    // оставить мин. значение линии на прежнем уровне
         if bufval < CSPMSignals[10].MinDiscr then
          ImgLine[i]:= CSPMSignals[10].MinDiscr
          else if bufval > CSPMSignals[10].MaxDiscr then
           ImgLine[i]:= CSPMSignals[10].MaxDiscr
          else ImgLine[i]:=round(bufval);

       end;       *)

     newmaxLineVal:=( TempLine[0]) ;             // нахождение нового максимума
    for I := 0 to L - 1 do
         if  TempLine[i] > newmaxLineVal then newmaxLineVal:=  TempLine[i];

   deltVal:= newmaxLineVal - maxLineVal;
   for I := 0 to Length(ImgLine) - 1 do
       begin
         bufval:= TempLine[i]- deltVal;    // оставить макс. значение линии на прежнем уровне
         if bufval < CSPMSignals[10].MinDiscr then   ImgLine[i]:= CSPMSignals[10].MinDiscr
          else
          if bufval > CSPMSignals[10].MaxDiscr then ImgLine[i]:= CSPMSignals[10].MaxDiscr
                                               else ImgLine[i]:=round(bufval);
       end;
       Finalize(tempLine);
 end;

procedure  AddNoise( DemoNoiseDiscr:datatype; var ImgLine:TLine);
var i, L:integer;
    bufval:integer;
    inoiseval:datatype;
 begin
 //
 if DemoNoiseDiscr<0 then  exit;
  randomize;
  L:=length(  ImgLine);
  for I := 0 to L - 1 do
    begin
     inoiseval:=round( abs(DemoNoiseDiscr)/2 - random(abs(DemoNoiseDiscr)));
     bufval:= ImgLine[i]+inoiseval;
     if bufval < CSPMSignals[10].MinDiscr      then ImgLine[i]:= CSPMSignals[10].MinDiscr
      else
      if bufval > CSPMSignals[10].MaxDiscr then ImgLine[i]:= CSPMSignals[10].MaxDiscr
                                           else ImgLine[i]:=bufval;
//     if True then
    end;
 end;
procedure calcDemoImitationParams( iRate:single; iFBGain:Pidtype; iLithoAction:Single;
                                   var smooth_nm:single;  var  noise_discr, noise_speed_discr:datatype; var depth_nm:single;
                                  var lithodepth_nm:single);
begin
  smooth_nm:=DemoSmooth_bySpeed(iRate);
  depth_nm:=DemoDepth_byFBGain(iFBGain);  // PidParams.Ti, fSourceFBGain - абсолютные величины
  noise_discr:=DemoNoise_byFBGain(iFBGain);
  noise_speed_discr:=DemoNoise_bySpeed(iRate);
  lithodepth_nm := DemoLithoDepth( iLithoAction)
end;

procedure FBGain_Speed_DemoImitation( smooth_nm:single; noise_discr, noise_speed_discr:datatype;
                                         depth_nm:single;  lithodepth_nm:single;   var AquiData:TData; var TempLineData:TLine);
var DemoCorrectLine:TLine;
    i,j,k:integer;
begin
  // Вставить :
                                 // 1) функцию, которая по соотношению скорости и усиления ОС
                                 // вычисляет параметр сглаживания
                                 // 2) По величине усиления ОС вычисляет шум
                                 // Применять эти ф-ции при всех видах сканирования
                                 // Определить скорость сканир. и усиление ОС Демо-файла по заголовку
  SetLength( DemoCorrectLine,ScanParams.ScanPoints);
  case ScanParams.ScanPath of
  OneX: for I := 0 to ScanParams.ScanPoints - 1 do DemoCorrectLine[i]:=AquiData.data[i,ScanParams.CurrentScanCount];
  OneY: for I := 0 to ScanParams.ScanPoints - 1 do DemoCorrectLine[i]:=AquiData.data[ScanParams.CurrentScanCount,i];
  end;
    CorrectImgSection_Smooth(smooth_nm, DemoCorrectLine);
    CorrectImgSection_depth(depth_nm-smooth_nm, DemoCorrectLine) ;
    if ScanParams.ScanMethod = litho then CorrectImgSection_depth(lithodepth_nm, DemoCorrectLine) ;
    AddNoise( noise_discr+noise_speed_discr,  DemoCorrectLine);
 case ScanParams.ScanPath of
  OneX:
    for I := 0 to ScanParams.ScanPoints - 1 do AquiData.data[i,ScanParams.CurrentScanCount]:=DemoCorrectLine[i];
  OneY:
    for I := 0 to ScanParams.ScanPoints - 1 do AquiData.data[ScanParams.CurrentScanCount,i]:=DemoCorrectLine[i];
              end;
    for I := 0 to ScanParams.ScanPoints - 1 do TempLineData[i]:=DemoCorrectLine[i];
 Finalize( DemoCorrectLine);
end;

procedure GetTimeNow(var Hour, Minute, Sec, MSec:word);
var
 Present: TDateTime;
 // Year, Month, Day, Hour, Minute, Sec, MSec: Word;
 begin
  Present:= Now;
//  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minute, Sec, MSec);
 end;

end.
