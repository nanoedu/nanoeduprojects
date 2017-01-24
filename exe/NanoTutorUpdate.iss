; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=NanoTutor
AppVerName=NanoTutor ver 17.01.13.7
OutputBaseFilename=NanoTutorUpdate-17.01.13.7
AppPublisher=NT-SPb Inc.
AppPublisherURL=http://www.ntspb.ru
AppSupportURL=http://www.ntspb.ru
AppUpdatesURL=http://www.ntspb.ru
DefaultDirName=C:\NT-SPb\NanoTutor
DefaultGroupName=NT-SPb
AllowNoIcons=yes
WizardImageFile=data\screen.bmp
ChangesAssociations=yes
OutputDir=output\update
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
[Files]
Source: "NanoTutor.exe";   DestDir: "{app}"; Flags: ignoreversion
Source: "SPMConfig.ini"; DestDir: "{app}"; Flags: ignoreversion;
Source: "SPMConfigDef.ini"; DestDir: "{app}"; Flags: ignoreversion;
Source: "SPMConfigUsersNanoTutor.ini";    DestDir: "{userappdata}\NanoTutor"; DestName:"SPMconfigUsers.ini";    Flags: ignoreversion;
Source: "SPMConfigDefUsersNanoTutor.ini"; DestDir: "{app}"; DestName:"SPMconfigDefUsers.ini"; Flags: ignoreversion;
Source: "javabin\*.jar";DestDir: "{app}\javabin"; Flags: ignoreversion recursesubdirs;
Source: "scheme\*.bin"; DestDir: "{app}\scheme"; Flags: ignoreversion recursesubdirs;
Source: "Demodata\*.*"; DestDir: "{app}\Demodata"; Flags:  ignoreversion    recursesubdirs;
[INI]
[Icons]
[Registry]
[Run]
Filename: "{app}\NanoTutor.exe";                                Description: "Launch NanoTutor";                        Flags: nowait postinstall skipifsilent
[UninstallRun]
[UninstallDelete]
[Files]

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
    'Personal Information', 'How will you use NanoTutor?',
    'Please specify how you would like to use NanoTutor, then click Next.',
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

