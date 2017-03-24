; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!
; copy english version sigraph.dll   to exe dir changed 09/06/16
[Setup]
AppName=ProBeam
AppVerName=ProBeam ver 17.01.13.9
OutputBaseFilename=ProBeam-17.01.13.9
AppPublisher=NT-SPb Inc.
AppPublisherURL=http://www.ntspb.ru
AppSupportURL=http://www.ntspb.ru
AppUpdatesURL=http://www.ntspb.ru
DefaultDirName=C:\NT-SPb\ProBeam
DefaultGroupName=NT-SPb
AllowNoIcons=yes
WizardImageFile=data\screen.bmp
ChangesAssociations=yes
OutputDir=output\full
PrivilegesRequired=admin
WindowResizable=yes
WizardStyle=modern
ShowLanguageDialog=yes
;WizardSmallImageFile=mysmallimage.bmp

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
;Name: "ru"; MessagesFile: "compiler:Languages\russian.isl"

[Tasks]
; NOTE: The following entry contains English phrases ("Create a desktop icon" and "Additional icons"). You are free to translate them into another language if required.
Name: "desktopicon"; Description: "Create a &desktop icon"; GroupDescription: "Additional icons:"
; NOTE: The following entry contains English phrases ("Create a Quick Launch icon" and "Additional icons"). You are free to translate them into another language if required.
Name: "quicklaunchicon"; Description: "Create a &Quick Launch icon"; GroupDescription: "Additional icons:"; Flags: unchecked
[Dirs]
;Name:"{commonappdata}\nanoeducator"
 Name:"{commondocs}\ProBeam"
 Name:"{userdocs}\ProBeam\Temp\"
 Name:"{userdocs}\ProBeam\Work\"
; Name:"(userappdata)\Temp"                                                                                        ;
 Name:"{app}\Oscilloscope"
; Name:"(userappdata)\Work"
 Name:"{app}\FONTS"
 Name:"{commondocs}\ProBeam"
 Name:"{commondocs}\ProBeam\Gallery"
 Name:"{commondocs}\ProBeam\Animation"
 Name:"{commondocs}\ProBeam\Video"
 Name:"{commondocs}\ProBeam\Docs\Rus"
 Name:"{commondocs}\ProBeam\Docs\Eng"
 Name:"{commondocs}\ProBeam\Labs\Rus"
 Name:"{commondocs}\ProBeam\Labs\Eng"
 Name:"{commondocs}\ProBeam\FAQ\Rus"
 Name:"{commondocs}\ProBeam\FAQ\Eng"
 Name:"{commondocs}\ProBeam\Reporttmpl\Rus"
 Name:"{commondocs}\ProBeam\Reporttmpl\Eng"
 Name:"{app}\VCredistr"
 Name:"{app}\ImageAnalysis"
 Name:"{app}\PowerPointViewer"
 Name:"{app}\AcrobatReader"
 Name:"{app}\Scripts"
 Name:"{app}\Data"
 Name:"{app}\Data\Rus"
 Name:"{app}\Data\Eng"
 Name:"{app}\javabin"
 Name:"{app}\scheme"
 Name:"{app}\ScannerIniDBase"
 Name:"{app}\DemoData"
 Name:"{app}\DemoData\stm"
 Name:"{app}\DemoData\sfm"
 Name:"{app}\Reporttmpl\Rus"
 Name:"{app}\Reporttmpl\Eng"
 Name:"{userappdata}\ProBeam"
 Name:"{userappdata}\ProBeam\Data"
 Name:"{userappdata}\ProBeam\Reporttmpl\Rus"
 Name:"{userappdata}\ProBeam\Reporttmpl\Eng"
[Files]
Source: "ProBeam.exe";   DestDir: "{app}"; Flags: ignoreversion
Source: "WHATNEW.TXT";   DestDir: "{app}"; Flags: ignoreversion
Source: "*.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "output\Image Analysis\*.exe"; DestDir: "{app}\ImageAnalysis"; Flags: ignoreversion
Source: "InterfaceProBeam.ini"; DestDir: "{app}"; DestName: "Interface.ini"; Flags: ignoreversion;
Source: "SPMConfig.ini"; DestDir: "{app}"; Flags: ignoreversion;
Source: "SPMConfigDef.ini"; DestDir: "{app}"; Flags: ignoreversion;
Source: "SPMOSC.ini";   DestDir: "{userappdata}\ProBeam"; Flags: ignoreversion;
Source: "SPMPID.ini";   DestDir: "{userappdata}\ProBeam"; Flags: ignoreversion;
Source: "SPMvideo.ini"; DestDir: "{userappdata}\ProBeam"; Flags: ignoreversion;
;Source: "SPMupdates.ini"; DestDir: "{userappdata}\nanoeducator"; Flags: ignoreversion;
Source: "SPMConfigUsersProBeam.ini";    DestDir: "{userappdata}\ProBeam"; DestName:"SPMconfigUsers.ini";    Flags: ignoreversion;
Source: "SPMConfigDefUsersProBeam.ini"; DestDir: "{app}"; DestName:"SPMconfigDefUsers.ini"; Flags: ignoreversion;
;Source: "SPMScanner.ini"; DestDir: "{userappdata}\ProBeam"; Flags: ignoreversion;
;Source: "SPMScannerDef.ini"; DestDir: "{app}"; Flags: ignoreversion;
;Source: "SPMScannerY.ini"; DestDir: "{userappdata}\ProBeam"; Flags: ignoreversion;
;Source: "SPMScannerYDef.ini"; DestDir: "{app}"; Flags: ignoreversion;
Source: "SPMPalettes.ini"; DestDir: "{userappdata}\ProBeam"; Flags: ignoreversion;
Source: "SPMPalettesDef.ini"; DestDir: "{app}"; Flags: ignoreversion;
Source: "ScannerIniDBase\*.*"; DestDir: "{app}\ScannerIniDBase"; Flags: ignoreversion recursesubdirs
Source: "oscilloscope\*.*"; DestDir: "{app}\oscilloscope"; Flags: ignoreversion recursesubdirs;
; copy english version sigraph.dll   to exe dir changed 09/06/16
Source: "oscilloscope\*.dll"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs;        
Source: "javabin\*.jar";DestDir: "{app}\javabin"; Flags: ignoreversion recursesubdirs;
Source: "scheme\*.bin"; DestDir: "{app}\scheme"; Flags: ignoreversion recursesubdirs;
Source: "data\*.*";     DestDir: "{app}\data"; Flags: ignoreversion;
Source: "data\Rus\*.*"; DestDir: "{app}\data\Rus"; Flags: skipifsourcedoesntexist;
Source: "data\Eng\*.*"; DestDir: "{app}\data\Eng"; Flags: skipifsourcedoesntexist;
Source: "Demodata\*.*"; DestDir: "{app}\Demodata"; Flags:  ignoreversion    recursesubdirs;
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\help\probeam\rus\*.chm";   DestDir: "{app}"; Flags: ignoreversion;
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\help\probeam\eng\*.chm";   DestDir: "{app}"; Flags: ignoreversion;
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\VCredistr\*.*"; DestDir: "{app}\VCRedistr"; Flags: ignoreversion recursesubdirs;
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\HardWareSoft\*.*"; DestDir: "{app}\HardwareSoft"; Flags: ignoreversion recursesubdirs;
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\gallery\*.*";  DestDir: "{commondocs}\ProBeam\gallery"; Flags: ignoreversion    recursesubdirs
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\animation\*.*";DestDir: "{commondocs}\ProBeam\animation"; Flags: ignoreversion ;
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\docs\probeam\*.pdf";   DestDir: "{commondocs}\ProBeam\docs\"; Flags: ignoreversion    recursesubdirs;
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\labs\probeam\*.pdf";   DestDir: "{commondocs}\ProBeam\labs\"; Flags: ignoreversion    recursesubdirs
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\labs\probeam\*.tmpl";  DestDir: "{commondocs}\ProBeam\labs\";Flags: ignoreversion    recursesubdirs
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\FAQ\probeam\*.pdf";    DestDir: "{commondocs}\ProBeam\FAQ\"; Flags: ignoreversion    recursesubdirs
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\Reporttmpl\*.*"; DestDir: "{commondocs}\ProBeam\Reporttmpl"; Flags: ignoreversion    recursesubdirs;
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\FONTS\*.*"; DestDir: "{app}\FONTS"; Flags: ignoreversion
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\flashplayer\*.*"; DestDir: "{app}\flashplayer"; Flags: ignoreversion
Source: "d:\ntspbprojects\nanoeduprojects\CommonData\AcrobatReader\*.*"; DestDir: "{app}\AcrobatReader"; Flags: ignoreversion recursesubdirs;
;Source: "d:\ntspbprojects\ProBeam\CommonData\video\*.*"; DestDir: "{commondocs}\ProBeam\video"; Flags: ignoreversion recursesubdirs;
Source: "register_NT-MDT\*.*";      DestDir: "{app}";Flags:    ignoreversion recursesubdirs;
Source: "registerprobeam.bat";      DestDir: "{app}";DestName: "register.bat";     Flags: ignoreversion
Source: "register64probeam.bat";    DestDir: "{app}";DestName: "register64.bat";   Flags: ignoreversion
Source: "unregisterprobeam.bat";    DestDir: "{app}";DestName: "unregister.bat";   Flags: ignoreversion
Source: "unregister64probeam.bat";  DestDir: "{app}";DestName: "unregister64.bat"; Flags: ignoreversion


;Source: "unregisterOld.bat";  DestDir: "{app}"; Flags: ignoreversion;
;Source: "unregister64Old.bat";  DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[INI]
Filename: "{app}\ProBeam.url"; Section: "InternetShortcut"; Key: "URL"; String: "http://www.ntspb.ru"
Filename: "{userappdata}\ProBeam\SPMconfigUsers.ini"; Section: "Install parameters"; Key: "first time stm"; String: "1"
Filename: "{userappdata}\ProBeam\SPMconfigUsers.ini"; Section: "Install parameters"; Key: "first time sfm"; String: "1"
Filename: "{userappdata}\ProBeam\SPMconfigUsers.ini"; Section: "Physical Unit Options"; Key: "Use Flash drive"; String: "1"
Filename: "{userappdata}\ProBeam\SPMconfigUsers.ini"; Section: "Users"; Key: "Show Welcome Window"; String: "true"
;Filename: "{userappdata}\NanoeducatorLE\SPMconfigUsers.ini"; Section: "Users"; Key: "User Level"; String: "Demo"
Filename: "{userappdata}\ProBeam\SPMconfigUsers.ini"; Section: "Approach Parameters"; Key: "Autorun Camera"; String: "1"
Filename: "{userappdata}\ProBeam\SPMconfigUsers.ini"; Section: "Approach Parameters"; Key: "Control Top Position"; String: "1"
Filename: "{userappdata}\ProBeam\SPMconfigUsers.ini"; Section: "Language"; Key: "Help"; String: "ENG"    
;disabled
Filename: "{userappdata}\ProBeam\SPMconfigUsers.ini"; Section: "Users"; Key: "Flg Change User Level"; String:  "1"  ; 
Filename: "{userappdata}\ProBeam\SPMconfigUsers.ini"; Section: "Users"; Key: "User Level"; String:  "{code:GetUser}"
[Icons]
Name: "{group}\ProBeam"; Filename: "{app}\ProBeam.exe"
; NOTE: The following entry contains an English phrase ("on the Web"). You are free to translate it into another language if required.
Name: "{group}\ProBeam on the Web"; Filename: "{app}\ProBeam.url"
; NOTE: The following entry contains an English phrase ("Uninstall"). You are free to translate it into another language if required.
Name: "{group}\Uninstall ProBeam"; Filename: "{uninstallexe}"
;Name: "{userdesktop}\NanoEducatorLoc"; Filename: "{app}\NanoEdu.exe";Tasks: desktopicon
Name: "{commondesktop}\ProBeam"; Filename: "{app}\ProBeam.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\ProBeam"; Filename: "{app}\ProBeam.exe"; Tasks: quicklaunchicon;
;Name: "{commondesktop}\3D ProBeam"; Filename: "{commondocs}\ProBeam\video\rus\3D_������_ProBeam.mp4"; Tasks: desktopicon

[Registry]
; Start "Software\My Company\My Program" keys under HKEY_CURRENT_USER
; and HKEY_LOCAL_MACHINE. The flags tell it to always delete the
; "My Program" keys upon uninstall, and delete the "My Company" keys
; if there is nothing left in them.
Root: HKCU; Subkey: "Software\NT-SPb"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\NT-SPb\ProBeam"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\NT-SPb"; Flags: uninsdeletekeyifempty
Root: HKLM; Subkey: "Software\NT-SPb\ProBeam"; Flags: uninsdeletekey;
Root: HKCR; Subkey: ".spm"; ValueType: string; ValueName:  ""; ValueData: "ProBeamSpm"; Flags: uninsdeletevalue
Root: HKCR; Subkey: ".mspm"; ValueType: string; ValueName: ""; ValueData: "ProBeamSpm"; Flags: uninsdeletevalue
Root: HKCR; Subkey: "ProBeamSpm"; ValueType: string; ValueName: ""; ValueData: "ProBeam Spm File"; Flags: uninsdeletekey
Root: HKCR; Subkey: "ProBeamSpm\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\ProBeam.EXE,0"
Root: HKCR; Subkey: "ProBeamSpm\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\ProBeam.EXE"" ""%1"""
[Run]
; NOTE: The following entry contains an English phrase ("Launch"). You are free to translate it into another language if required.
;Filename: "{app}\DriversVideoCamera\Live Cam Notebook Pro(VF0400)\Drivers\Setup\setup.exe"; Description: "Videocamera  Live Notebook Pro(VF0400) drivers instalation"; Flags:  waituntilterminated postinstall skipifsilent
; NOTE: The following entry contains an English phrase ("Launch"). You are free to translate it into another language if required.
;Filename: "{app}\flashplayer\rus\PotPlayer_x86_Rus.exe";   Description: "Install flash player";  check: IsX32;   Flags:  waituntilterminated postinstall skipifsilent;
;Filename: "{app}\flashplayer\Install_flash_player_11x32.exe";   Description: "Install flash player Active X component"; Flags:  waituntilterminated postinstall skipifsilent;
;Filename: "{app}\flashplayer\KMPlayer.exe";                Description: "Install flash player";                  Flags:  waituntilterminated postinstall skipifsilent;
;Filename: "{app}\PowerPointViewer\PowerPointViewer.exe";   Description: "Install PowerPoint viewer";             Flags:  waituntilterminated postinstall skipifsilent;
Filename: "{app}\VCredistr\install.exe";   Description: "Launch VC8 redistributive pack";                          Flags:  waituntilterminated postinstall skipifsilent ;
Filename: "{app}\register.bat";   Description: "Launch register ProBeam server";          check: IsX32;          Flags:  waituntilterminated postinstall skipifsilent ;
Filename: "{app}\register64.bat"; Description: "Launch register ProBeam server";          check: IsWin64;        Flags:  waituntilterminated postinstall skipifsilent ;
Filename: "{app}\flashplayer\Install_flashplayer_11.exe";       Description: "Install flash player Active X component"; Flags:  waituntilterminated postinstall skipifsilent;
Filename: "{app}\AcrobatReader\setup.exe";            Description: "Install AcrobatReader";                   Flags:  waituntilterminated postinstall skipifsilent;
Filename: "{app}\ImageAnalysis\ImageAnalysis.exe";              Description: "Install ImageAnalysis";                   Flags:  waituntilterminated postinstall skipifsilent;
Filename: "{app}\ProBeam.exe";                                Description: "Launch ProBeam";                        Flags: nowait postinstall skipifsilent
[UninstallRun]
;Filename: "{app}\unregister.bat";            check: IsX32;   Flags:  waituntilterminated;
;Filename: "{app}\unregister64.bat";          check: IsWin64; Flags:  waituntilterminated;

[UninstallDelete]
Type: files; Name: "{app}\ProBeam.url"
Type: filesandordirs; Name: "{userappdata}\ProBeam\*.*"
Type: filesandordirs; Name: "{userappdata}\ProBeam"
Type: filesandordirs; Name: "{commondocs}\ProBeam\*.*"
Type: filesandordirs; Name: "{commondocs}\ProBeam"
Type: filesandordirs; Name: "{app}\ScannerIniDBase\*.*"
Type: filesandordirs; Name: "{app}\demodata\*.*"
Type: filesandordirs; Name: "{app}\*.*"
Type: filesandordirs; Name: "{app}"

[Files]
;Source: "5.0.44.0__swflash.ocx"; DestDir: "{sys}\macromed\flash";   Flags: onlyifdoesntexist restartreplace sharedfile regserver

[Code]
var lng:string;
  UserPage: TInputQueryWizardPage;
  UsagePage: TInputOptionWizardPage;
  userlevel:string;


function CheckLangR:Boolean;
begin
  lng:='RUS';
  RegQueryStringValue(HKU, '.Default\Control Panel\International', 'sLanguage', lng);
  result:=false;
  if lng='RUS' then result:=true
end;
function IsX64: Boolean;
begin
  Result := Is64BitInstallMode and (ProcessorArchitecture = paX64);
end;
function IsX32: Boolean;
begin
  Result :=not IsWin64;//not  Is64BitInstallMode {and (ProcessorArchitecture = paX64)};
end;
function RegMLPCservers(dllname:string):boolean;
var str:string;
 begin
  Result := MsgBox( ExpandConstant('{app}\MLPC_API2.dll'), mbConfirmation, MB_YESNO) = idYes;

 if  IsX64 then RegisterServer(true, ExpandConstant('{app}\MLPC_API2.dll'), False)
           else RegisterServer(false,ExpandConstant('{app}\MLPC_API2.dll'), False);
end;


function CheckLangE:Boolean;
begin
  lng:='RUS';
  RegQueryStringValue(HKU, '.Default\Control Panel\International', 'sLanguage', lng);
  result:=true;
  if lng='RUS' then result:=false;
end;

procedure InitializeWizard;
begin
  { Create the pages }
   UsagePage := CreateInputOptionPage(wpWelcome,
    'Personal Information', 'How will you use ProBeam?',
    'Please specify how you would like to use ProBeam, then click Next.',
    True, False);
  UsagePage.Add('Experiment (full functionality)');
  UsagePage.Add('Simulator  (simulator full functionality)');

 { Set default values, using settings that were stored last time if possible }
  UsagePage.SelectedValueIndex := 0;
   case GetPreviousData('UsageMode', '') of
    'Advanced': UsagePage.SelectedValueIndex := 0;
    'Demo': UsagePage.SelectedValueIndex := 1;
  else
    UsagePage.SelectedValueIndex := 1;
  end;
end;
procedure RegisterPreviousData(PreviousDataKey: Integer);
var
  UsageMode: String;
begin
  { Store the settings so we can restore them next time }
  case UsagePage.SelectedValueIndex of
    0: UsageMode := 'Advanced';
    1: UsageMode := 'Demo';           end;
  SetPreviousData(PreviousDataKey, 'UsageMode', UsageMode);
end;
function NextButtonClick(CurPageID: Integer): Boolean;
begin
  { Validate certain pages before allowing the user to proceed }
  if CurPageID = UsagePage.ID then 
  begin
    case UsagePage.SelectedValueIndex of
0: userlevel:='Advanced';
1: userlevel:='Demo';
       end;
// MsgBox('User level='+userlevel, mberror, MB_OK);
  end;  
    Result := True;
end;
function GetUser(Param: String): String;
begin
  { Return a user value }
  { Could also be split into separate GetUserName and GetUserCompany functions }
  Result := userlevel;
 end;

 
