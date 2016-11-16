unit frControllerDetect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,setupAPI, ExtCtrls, siComp,
    {$IFDEF DEBUG}
              frDebug,
       {$ENDIF}
      siLngLnk,unewdev;


type
 TIsWow64Process = function (H: THandle; Value: PBOOL): BOOL; stdcall;
type

PINSTALLSELECTEDDRIVER=function(hwndParent:HWND;DeviceInfoSet:HDEVINFO;
                       Reserved:LPCWSTR;Backup:BOOL;pReboot:PDWORD):bool;

type
  TControllerDetect = class(TForm)
    LogMemo: TMemo;
    label1:tlabel;
    Timer: TTimer;
    siLangLinked1: TsiLangLinked;
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    flgDisappear:boolean;
    i:integer;

    flgremovedev:boolean;
    strmicroscope: string;
    strosc: string ;
    strvidcontroller,
    strvidosc: string;//PAnsiChar ;
    deviceSerialToUpdate:string;
    infPath:Pchar;
    pathdrvinf:string;
  public

    DeviceClassesList:TStringList;
//    procedure AddAllDevices;
//    procedure AddDevices(aNode:TTreeNode;aGUID:TGUID);
    procedure OnDeviceChange(var Msg: TMessage); message WM_DEVICECHANGE;
    function  NanoeduDigDetect:boolean;
    function  NanoeduDriversDetect:boolean;
    function  CSPMDriverSetUp:boolean;
    function  CSPMDriver64SetUp:boolean;
  end;

 const GUID_DEVCLASS_IMAGE: TGUID       = '{6BDD1FC6-810F-11D0-BEC7-08002BE2092F}';

var
  ControllerDetect: TControllerDetect;
  lpInterfaceDetailData:PSPDeviceInterfaceDetailData;
  spInterfaceData:TSPDeviceInterfaceData;
  dwInterfaceDetailDataSize:DWORD;
  //dwErrCode,dwReqSize:DWORD;
  //bStatus:Boolean;


implementation

{$R *.dfm}

uses globalvar,globalfunction,cspmvar,mMain,configmgr,shellapi;

const
 INSTALLFLAG_FORGE=$00000001;  // Force the installation of the specified driver
//#define INSTALLFLAG_READONLY            0x00000002  // Do a read-only install (no file copy)
//#define INSTALLFLAG_NONINTERACTIVE      0x00000004  // No UI shown at all. API will fail if any UI must be shown.
//#define INSTALLFLAG_BITS                0x00000007
(*
  EDU_HARDWARE_ID :string= 'USB\Vid_0438&Pid_0f00&Rev_0001';
  EDU_INSTANCE_ID_PREF:string ='USB\VID_0438&PID_0F00\';
//  EDU_NAME_PREFFIX: string     = '\\?\USB#Vid_0438&Pid_0f00#';    //change to digital
  EDU_NAME_PREFFIX: string     = '\\?\USB#VID_0438&PID_0FDF';         //digital
*)
	strturnon: string = ''; (*   turn on!! *)
	strturnoff: string = ''; (*  turn off!! *)
	strcontroller: string = ''; (* Nanoeducator controller *)
	strosc: string = ''; (* Nanoeducator osclilloscope *)
(*procedure TControllerDetect.AddAllDevices;
var
  _i:DWORD;
  Res:CONFIGRET;
  GUID: PGUID;
  Buffer: array [0..1023] of CHAR;
  BufSize: DWORD;
  Node:TTreeNode;
begin
  DeviceClassesList:=TStringList.Create;
  _i:=0;
  repeat
    GetMem(GUID, SizeOf(TGUID));
    Res := CM_Enumerate_Classes(_i, GUID^, 0);
    if Res <> CR_NO_SUCH_VALUE then
    begin
      SetupDiGetClassDescription(GUID^, @Buffer[0], Length(Buffer), BufSize);
      DeviceClassesList.AddObject(Pchar(@Buffer[0]), TObject(GUID));
    end;
    Inc(_i);
  until Res = CR_NO_SUCH_VALUE;

  for _i:=0 to DeviceClassesList.Count-1 do
   begin
    Node:=DeviceTreeView.Items.AddChild(nil,DeviceClassesList.Strings[_i]);
    GUID := PGUID(DeviceClassesList.Objects[_i]);
    AddDevices(Node,GUID^);
   end;
end;
 *)
procedure RunAsAdmin(hWnd: HWND; aFile: string;aParameters: string);
var
 sei: TShellExecuteInfo;
begin
 FillChar(sei, SizeOf(sei), 0);
 sei.cbSize := sizeof(sei);
 sei.Wnd := hWnd;
 sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
 sei.lpVerb := 'runas';
 sei.lpFile := PChar(aFile);
 sei.lpParameters := PChar(aParameters);
 sei.nShow := SW_SHOWNORMAL;
 if not ShellExecuteEx(@sei) then RaiseLastOSError;
end;
function GetDeviceName(PnPHandle: HDEVINFO;{ const }DevData: TSPDevInfoData): string;
var
  BytesReturned: PDWORD;  //p
  RegDataType: PDWORD;    //p
  Buffer: array [0..256] of CHAR;
begin
  BytesReturned := 0;
  RegDataType := 0;
  Buffer[0] := #0;
  SetupDiGetDeviceRegistryProperty(PnPHandle, DevData, SPDRP_FRIENDLYNAME,
    RegDataType, PByte(@Buffer[0]), SizeOf(Buffer), BytesReturned);
  Result := Buffer;
  if Result<>'' then exit;
  BytesReturned := 0;
  RegDataType := 0;
  Buffer[0] := #0;
  SetupDiGetDeviceRegistryProperty(PnPHandle, DevData, SPDRP_DEVICEDESC,
    RegDataType, PByte(@Buffer[0]), SizeOf(Buffer), BytesReturned);
  Result:=Buffer;
end;
(*function GetDeviceName(PnPHandle: HDEVINFO;   DevData: TSPDevInfoData): string;
var
  BytesReturned: PDWORD;
  RegDataType: PDWORD;
  Buffer: array [0..256] of CHAR;
begin
  BytesReturned := 0;
  RegDataType := 0;
  Buffer[0] := #0;
  SetupDiGetDeviceRegistryProperty(PnPHandle, DevData, SPDRP_FRIENDLYNAME,
    RegDataType, PByte(@Buffer[0]), SizeOf(Buffer), BytesReturned);
  Result := Buffer;
  if Result<>'' then exit;
  BytesReturned := 0;
  RegDataType := 0;
  Buffer[0] := #0;
  SetupDiGetDeviceRegistryProperty(PnPHandle, DevData, SPDRP_DEVICEDESC,
    RegDataType, PByte(@Buffer[0]), SizeOf(Buffer), BytesReturned);
  Result:=Buffer;
end;
*)
(*procedure TControllerDetect.AddDevices(aNode: TTreeNode; aGUID: TGUID);
var
  PnPHandle: HDEVINFO;
  DevData: TSPDevInfoData;
  RES: LongBool;
  Devn: Integer;
  _DN,_PN:ULONG;
begin
  PnPHandle := SetupDiGetClassDevs(@aGUID, nil, 0, DIGCF_PRESENT);
  if PnPHandle = INVALID_HANDLE_VALUE then  Exit;

  Devn := 0;
  repeat
   DevData.cbSize := SizeOf(DevData);
   RES := SetupDiEnumDeviceInfo(PnPHandle, Devn, DevData);
   if (RES) and (_DN<>DN_ROOT_ENUMERATED) then
    begin
     DeviceTreeView.Items.AddChild(aNode, GetDeviceName(PnPHandle, DevData));
     Inc(Devn);
    end;
   if Devn=0 then
    begin
     DeviceTreeView.Items.Delete(aNode);
     break;
    end;
  until not RES;
  SetupDiDestroyDeviceInfoList(PnPHandle);
end;
*)
(*
procedure TControllerDetect.Button1Click(Sender: TObject);
begin
  AddAllDevices;
end;
*)
function DWORDtoDiskNames(val:DWORD):string;
var
  _i: integer;
begin
  Result:='';
  for _i := 0 to 25 do
   begin
    if ((val mod 2)=1) then Result:=result+ chr(_i + 65);
    val:=val shr 1;
   end;
end;
function DetectNanoeduFlashDisk(name:char):boolean;
Var
  S : String;
  I : Integer;
  VolumeName,FileSystemName : String;
  VolumeSerialNo,MaxComponentLength,FileSystemFlags:LongWord;
begin
result:=false;
  {Если диск существует/вставлен ...}
  if GetHDDInfo(name, VolumeName, FileSystemName, VolumeSerialNo, MaxComponentLength, FileSystemFlags)
   then {... тогда собираем информацию}
    if VolumeName='NANOEDU' then begin result:=true;exit; end;
end;
function  TControllerDetect.NanoeduDigDetect:boolean;
begin

end;
function  TControllerDetect.NanoeduDriversDetect:boolean;
 var
  DrivePnPHandle: HDEVINFO;
  DeviceNumber:DWORD;
  DevData: TSPDevInfoData;
  RES:BOOL;
  devName:string;
  HND:THandle;
  bStatus:Boolean;
begin
  result:=false;
  DrivePnPHandle := SetupDiGetClassDevs(nil, nil, 0,DIGCF_ALLCLASSES);
//   if (DrivePnPHandle=INVALID_HANDLE_VALUE) then  Exit;
  DeviceNumber := 0;
repeat
   spInterfaceData.cbSize := SizeOf(TSPDeviceInterfaceData);
   DevData.cbSize := SizeOf(TSPDevInfoData);
   RES := SetupDiEnumDeviceInfo(DrivePnPHandle, DeviceNumber, DevData);
   if (RES) then
   begin
     devName:= GetDeviceName(DrivePnPHandle, DevData);
     if (LowerCase(devName) = LowerCase(DigNanoeduDevName{'Scanning Probe Microscope Controller'})) then
      begin
       result:=true;
       break;
      end;//nanoedu controller
     Inc(DeviceNumber);
   end//res
  until not RES;
//  SetupDiDestroyDeviceInfoList(DrivePnPHandle);
end;
function  TControllerDetect.CSPMDriverSetUp:boolean;
var
    res:boolean;
    flg64:boolean;
    str:string;
    IsWow64ProcedureExists:boolean;
    IsWow64ProcessExists:Bool;
    fnIsWow64Process:TIsWow64Process;
begin
infpath:=Pchar(ExeFilePath+'DriverSetUp\cspm.inf');
pathdrvinf:='';
flg64:=false;
IsWow64ProcedureExists :=GetProcAddress(GetModuleHandle('kernel32'),'IsWow64Process') <> nil;
if  IsWow64ProcedureExists then
    begin
       fnIsWow64Process:=GetProcAddress(GetModuleHandle('kernel32'),'IsWow64Process');
      if assigned(fnIsWow64Process) then
       res:=fnIsWow64Process(GetCurrentProcess,@IsWow64ProcessExists);
      if res then
       if IsWow64ProcessExists then
       begin
         infpath:=Pchar(ExeFilePath+'DriverSetUp\Wow64\install\nanoedu.inf');
         pathdrvinf:=ExeFilePath+'DriverSetUp\Wow64\install\nanoedu.inf';
         flg64:=true;
       end;
      if assigned(fnIsWow64Process) then  fnIsWow64Process:=nil;
    end;
 if flg64 then CSPMDriver64SetUp
          else  res:=UpdateDriverForPlugandPlayDevicesA(handle,PChar('USB\VID_0438&PID_0F00'),
                               infpath,INSTALLFLAG_FORGE,nil);
 if (not res) then
   begin
     str:=SysErrorMessage(GetlastError);
    MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_4' (* 'Nanoeducator installation error' *) )+str, mtInformation,[mbOk],0);
     result:=false;
     exit;
   end;
   MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_5' (* 'Nanoeducator installed successfully' *) ), mtInformation,[mbOk],0);
   result:=true;
end;

function  TControllerDetect.CSPMDriver64SetUp:boolean;
var
    i:integer;
    Err:DWORD;
    DeviceInfoSet:HDEVINFO;
    DeviceInfoData:TSPDevInfoData;//SP_DEVINFO_DATA;
    DriverInfoData:TSPDrvInfoData;//SP_DRVINFO_DATA;
  //  DeviceInfoData:SP_DEVINFO_DATA;
  //  DriverInfoData:SP_DRVINFO_DATA;
    DeviceInstallParams:SP_DEVINSTALL_PARAMS_A;
    NewDevPath:array [0..MAX_PATH]of CHAR;
    hNewDev:HMODULE;
    InstallSelectedDriver:PINSTALLSELECTEDDRIVER;
    Reboot:PDWORD;
    label clean0;
begin
   ShellExecute(0,
    'open',
    'drvinst.exe',
    PChar('"'+EDU_INSTANCE_ID_PREF+deviceSerialToUpdate+'" "'+pathdrvinf+'"'),
    PChar(ExeFilePath),
    1);

(*
  Err:=NO_ERROR;
  DeviceInfoSet:=Pointer(INVALID_HANDLE_VALUE);
//  hNewDev:=nil;
   InstallSelectedDriver:=nil;

   DeviceInfoSet:=SetupDiCreateDeviceInfoList(nil,0);
  //
  // Create an empty device information list.
  //
    if (DeviceInfoSet=Pointer(INVALID_HANDLE_VALUE)) then
    begin
        Err:= GetLastError();
        goto clean0;
    end;
    //
    // Add the device that is referenced by the device instance id parameter
    // to the device information list.
    //
    DeviceInfoData.cbSize:=sizeof(DeviceInfoData);
   // EDU_INSTATCE_ID_PREF+deviceSerialToUpdate
    if (not SetupDiOpenDeviceInfo(DeviceInfoSet,
                               PAnsiChar(EDU_INSTANCE_ID_PREF+deviceSerialToUpdate),
                               0,
                               0,
                               DeviceInfoData)) then
     begin
        Err:= GetLastError();
        goto clean0;
    end;
   //
    // InstallSelectedDriver works on the selected device and on the
    // selected driver on that device. Therefore, set this device as the
    // selected one in the device information list.
    //
    if (not SetupDiSetSelectedDevice(DeviceInfoSet,
                                  DeviceInfoData))then
    begin
        Err:=GetLastError();
        goto clean0;
    end;

    //
    // You now have a SP_DEVINFO_DATA structure
    // representing your device.  Next, get a SP_DRVINFO_DATA
    // structure to install on that device.
    //
    DeviceInstallParams.cbSize:= sizeof(DeviceInstallParams);
    if (not SetupDiGetDeviceInstallParams(DeviceInfoSet,
                                       DeviceInfoData,
                                       DeviceInstallParams))then


  if (not SetupDiGetDeviceInstallParams(DeviceInfoSet,
                                       DeviceInfoData,
                                       DeviceInstallParams))then
    begin
        Err:= GetLastError();
        goto clean0;
    end;

    //
    // Only build the driver list out of the passed-in INF.
    // To do this, set the DI_ENUMSINGLEINF flag, and copy the
    // full path of the INF into the DriverPath field of the
    // DeviceInstallParams structure.
    //
   DeviceInstallParams.Flags:=DeviceInstallParams.Flags or DI_ENUMSINGLEINF;
//   DeviceInstallParams.Flags |= DI_ENUMSINGLEINF;
   for i:=0 to length(pathdrvinf) - 1 do

    DeviceInstallParams.DriverPath[i]:=pathdrvinf[i];
    //
    // Set the DI_FLAGSEX_ALLOWEXCLUDEDDRVS flag so that you can use
    // this INF even if it is marked as ExcludeFromSelect.
    // ExcludeFromSelect means do not show the INF in the legacy Add
    // Hardware Wizard.
    //
    DeviceInstallParams.FlagsEx:=DeviceInstallParams.FlagsEx or DI_FLAGSEX_ALLOWEXCLUDEDDRVS;
  //     DeviceInstallParams.FlagsEx |= DI_FLAGSEX_ALLOWEXCLUDEDDRVS;

    if (not SetupDiSetDeviceInstallParams(DeviceInfoSet,
                                        DeviceInfoData,
                                        DeviceInstallParams)) then
    begin
        Err:=GetLastError();
        goto clean0;
    end;

    //
    // Build up a Driver Information List from the specified INF.
    // Build a compatible driver list, meaning only include the
    // driver nodes that match one of the hardware or compatible Ids of
    // the device.
    //
    if (not SetupDiBuildDriverInfoList(DeviceInfoSet,
                                    &DeviceInfoData,
                                    SPDIT_COMPATDRIVER))then
    begin
        Err:=GetLastError();
        goto clean0;
    end;

    //
    // Pick the best driver in the list of drivers that was built.
    //
    if (not SetupDiCallClassInstaller(DIF_SELECTBESTCOMPATDRV,
                                   DeviceInfoSet,
                                   &DeviceInfoData)) then
    begin
        Err:=GetLastError();
        goto clean0;
    end;

    //
    // Get the selected driver node.
    // Note: If this list does not contain any drivers, this call
    // will fail with ERROR_NO_DRIVER_SELECTED.
    //
    DriverInfoData.cbSize:=sizeof(DriverInfoData);
    if ( not SetupDiGetSelectedDriver(DeviceInfoSet,
                                  &DeviceInfoData,
                                  &DriverInfoData)) then
    begin
        Err:=GetLastError();
        goto clean0;
    end;

    //
    // At this point, you have a valid SP_DEVINFO_DATA structure and a
    // valid SP_DRVINFO_DATA structure.
    // Load newdev.dll, GetProcAddress(InstallSelectedDriver), and call
    // that API.
    //
    // To be more secure, make sure to load the newdev.dll file from the
    // system 32 directory.
    //
    if (GetSystemDirectory(NewDevPath, length(NewDevPath)) = 0) then
    begin
        Err:= GetLastError();
        goto clean0;
    end;
    hNewDev:=LoadLibrary('NEWDEV.DLL'{NewDevPath});
    if (hNewDev<=32) then
     begin
            Err:= GetLastError();
        goto clean0;
    end;

    InstallSelectedDriver:= GetProcAddress(hNewDev, 'InstallSelectedDriver');
    if  not assigned(InstallSelectedDriver) then
     begin
        Err:= GetLastError();
        goto clean0;
    end;

    //
    // Call pInstallSelectedDriver to install the selected driver on
    // the selected device.
    //
    InstallSelectedDriver(0,
                           DeviceInfoSet,
                           0,
                           TRUE,
                           &Reboot);

  clean0:
    if hNewDev<=0 then
    begin
        FreeLibrary(hNewDev);
//        hNewDev:=nil;
    end;
    if (DeviceInfoSet <>Pointer(INVALID_HANDLE_VALUE)) then
     begin
        SetupDiDestroyDeviceInfoList(DeviceInfoSet);
        DeviceInfoSet:=Pointer(INVALID_HANDLE_VALUE);
     end;
    result:=bool(Err);
*)
    (*typedef
BOOL
(*PINSTALLSELECTEDDRIVER)(
  HWND hwndParent,
  HDEVINFO DeviceInfoSet,
  LPCWSTR Reserved,
  BOOL Backup,
  PDWORD pReboot
  );


int
__cdecl
wmain(
    IN int   argc,
    IN WCHAR *argv[]
    )
{
    DWORD Err = NO_ERROR;
    HDEVINFO DeviceInfoSet = INVALID_HANDLE_VALUE;
    SP_DEVINFO_DATA DeviceInfoData;
    SP_DRVINFO_DATA DriverInfoData;
    SP_DEVINSTALL_PARAMS DeviceInstallParams;
    TCHAR NewDevPath[MAX_PATH];
    HMODULE hNewDev = NULL;
    PINSTALLSELECTEDDRIVER pInstallSelectedDriver = NULL;
    DWORD Reboot;

    //
    // The command line will contain a device instance Id and a full
    // path of an INF.
    //
    if (argc < 3) {
        printf("Usage: iseldr \"device instance id\" \"full path to the INF file\"\n");
        return ERROR_INVALID_PARAMETER;
    }

    printf("%ws\n", argv[1]);
    printf("%ws\n", argv[2]);

    //
    // Create an empty device information list.
    //
    DeviceInfoSet = SetupDiCreateDeviceInfoList(NULL, NULL);
    if (DeviceInfoSet == INVALID_HANDLE_VALUE) {
        Err = GetLastError();
        goto clean0;
    }

    //
    // Add the device that is referenced by the device instance id parameter
    // to the device information list.
    //
    DeviceInfoData.cbSize = sizeof(DeviceInfoData);
    if (!SetupDiOpenDeviceInfo(DeviceInfoSet,
                               (PCWSTR)argv[1],
                               NULL,
                               0,
                               &DeviceInfoData)) {
        Err = GetLastError();
        goto clean0;
    }

    //
    // InstallSelectedDriver works on the selected device and on the
    // selected driver on that device. Therefore, set this device as the
    // selected one in the device information list.
    //
    if (!SetupDiSetSelectedDevice(DeviceInfoSet,
                                  &DeviceInfoData)) {
        Err = GetLastError();
        goto clean0;
    }

    //
    // You now have a SP_DEVINFO_DATA structure
    // representing your device.  Next, get a SP_DRVINFO_DATA
    // structure to install on that device.
    //
    DeviceInstallParams.cbSize = sizeof(DeviceInstallParams);
    if (!SetupDiGetDeviceInstallParams(DeviceInfoSet,
                                       &DeviceInfoData,
                                       &DeviceInstallParams)) {
        Err = GetLastError();
        goto clean0;
    }

    //
    // Only build the driver list out of the passed-in INF.
    // To do this, set the DI_ENUMSINGLEINF flag, and copy the
    // full path of the INF into the DriverPath field of the 
    // DeviceInstallParams structure.
    //
    DeviceInstallParams.Flags |= DI_ENUMSINGLEINF;
    if (FAILED(StringCchCopy(DeviceInstallParams.DriverPath,
                             SIZECHARS(DeviceInstallParams.DriverPath),
                             argv[2]))) {
        //
        // The file path that was passed in was too big.
        //
        Err = ERROR_INVALID_PARAMETER;
        goto clean0;
    }

    //
    // Set the DI_FLAGSEX_ALLOWEXCLUDEDDRVS flag so that you can use
    // this INF even if it is marked as ExcludeFromSelect.
    // ExcludeFromSelect means do not show the INF in the legacy Add   
    // Hardware Wizard.
    //
    DeviceInstallParams.FlagsEx |= DI_FLAGSEX_ALLOWEXCLUDEDDRVS;

    if (!SetupDiSetDeviceInstallParams(DeviceInfoSet,
                                       &DeviceInfoData,
                                       &DeviceInstallParams)) {
        Err = GetLastError();
        goto clean0;
    }

    //
    // Build up a Driver Information List from the specified INF.
    // Build a compatible driver list, meaning only include the
    // driver nodes that match one of the hardware or compatible Ids of     
    // the device.
    //
    if (!SetupDiBuildDriverInfoList(DeviceInfoSet,
                                    &DeviceInfoData,
                                    SPDIT_COMPATDRIVER)) {
        Err = GetLastError();
        goto clean0;
    }

    //
    // Pick the best driver in the list of drivers that was built.
    //
    if (!SetupDiCallClassInstaller(DIF_SELECTBESTCOMPATDRV,
                                   DeviceInfoSet,
                                   &DeviceInfoData)) {
        Err = GetLastError();
        goto clean0;
    }

    //
    // Get the selected driver node.
    // Note: If this list does not contain any drivers, this call
    // will fail with ERROR_NO_DRIVER_SELECTED.
    //
    DriverInfoData.cbSize = sizeof(DriverInfoData);
    if (!SetupDiGetSelectedDriver(DeviceInfoSet,
                                  &DeviceInfoData,
                                  &DriverInfoData)) {
        Err = GetLastError();
        goto clean0;
    }

    //
    // At this point, you have a valid SP_DEVINFO_DATA structure and a
    // valid SP_DRVINFO_DATA structure.
    // Load newdev.dll, GetProcAddress(InstallSelectedDriver), and call
    // that API.
    //
    // To be more secure, make sure to load the newdev.dll file from the
    // system 32 directory.
    //
    if (GetSystemDirectory(NewDevPath, SIZECHARS(NewDevPath)) == 0) {
        Err = GetLastError();
        goto clean0;
    }

    if (FAILED(StringCchCat(NewDevPath, SIZECHARS(NewDevPath), TEXT("\\NEWDEV.DLL")))) {
        Err = ERROR_INSUFFICIENT_BUFFER;
        goto clean0;
    }

    hNewDev = LoadLibrary(NewDevPath);
    if (!hNewDev) {
        Err = GetLastError();
        goto clean0;
    }

    pInstallSelectedDriver = (PINSTALLSELECTEDDRIVER)GetProcAddress(hNewDev, "InstallSelectedDriver");
    if (!pInstallSelectedDriver) {
        Err = GetLastError();
        goto clean0;
    }

    //
    // Call pInstallSelectedDriver to install the selected driver on
    // the selected device.
    //
    pInstallSelectedDriver(NULL,
                           DeviceInfoSet,
                           NULL,
                           TRUE,
                           &Reboot);

    if (Reboot & (DI_NEEDREBOOT | DI_NEEDRESTART)) {
        //
        // A reboot is required.
        //
    }

clean0:
    if (hNewDev) {
        FreeLibrary(hNewDev);
        hNewDev = NULL;
    }

    if (DeviceInfoSet != INVALID_HANDLE_VALUE) {
        SetupDiDestroyDeviceInfoList(DeviceInfoSet);
        DeviceInfoSet = INVALID_HANDLE_VALUE;
    }

    printf("iseldrv returned 0x%X\n", Err);
    return Err;
*)
end;
procedure TControllerDetect.OnDeviceChange(var Msg: TMessage);
var
  MSGSTR:String;
  str:string;
  diskname:char;
begin
str:='';
  if Msg.WParam=DBT_DEVICEARRIVAL then
   begin
    case PDEV_BROADCAST_HDR(Msg.LParam)^.dbch_devicetype of
  DBT_DEVTYP_DEVICEINTERFACE:
     begin
      str:={'Nanoeducator controller turn on!!'+}pchar(@PDEV_BROADCAST_DEVICEINTERFACE(Msg.LParam)^.dbcc_name[0]);
     LogMemo.Lines.Add(strturnon);//'вставлен новый интерфейс: '+pchar(@PDEV_BROADCAST_DEVICEINTERFACE(Msg.LParam)^.dbcc_name[0]));
    {$IFDEF DEBUG}
      if assigned(FormLog) then  Formlog.memolog.Lines.add('interface added '+str);
    {$ENDIF}
      //deviceSerialToUpdate:=  Copy(str,length(EDU_NAME_PREFFIX)+1,9);
      if AnsiPos(LowerCase(strvidcontroller),LowerCase(str))<>0 then
      begin
       {$IFDEF DEBUG}
         Formlog.memolog.Lines.add(DigNanoeduDevName+' found ');
      {$ENDIF}
           Main.ActionNew.Enabled:=true;
       if not  flgdetectdev then
       begin
        show ;
        LogMemo.Lines.Add(strcontroller+strturnon );
        flgDetectDev:=true;
        flgremovedev:=false;
        i:=0;
        self.alphablendvalue:=255;
        timer.enabled:=true;
       end;
      end;
     (* else
       if AnsiPos(LowerCase(strvidosc),LowerCase(str))<>0 then
       begin
        LogMemo.Lines.Add(strosc+strturnon );
        timer.enabled:=true;
        show ;
      end
     *)
     end;
     DBT_DEVTYP_HANDLE:
      LogMemo.Lines.Add('новый системный хендл');
     DBT_DEVTYP_OEM:
      LogMemo.Lines.Add('новое OEM- или IHV- устройство');
     DBT_DEVTYP_PORT:
      LogMemo.Lines.Add('новый порт: '+pchar(@PDEV_BROADCAST_PORT(Msg.LParam)^.dbcp_name[0]));
    DBT_DEVTYP_VOLUME:
     begin
      MSGSTR:='новый диск'+MSGSTR;
      diskname:=DWORDtoDiskNames(PDEV_BROADCAST_VOLUME(Msg.LParam)^.dbcv_unitmask)[1];
//       LogMemo.Lines.Add(MSGSTR+' '+diskname{DWORDtoDiskNames(PDEV_BROADCAST_VOLUME(Msg.LParam)^.dbcv_unitmask)}+':');
       if DetectNanoeduFlashDisk(diskname) then
       begin
        LogMemo.Lines.Add(MSGSTR+' '+diskname{DWORDtoDiskNames(PDEV_BROADCAST_VOLUME(Msg.LParam)^.dbcv_unitmask)}+':');
         timer.enabled:=true;
         show;
       end;
    end;
    end;
   end;

  if Msg.WParam=DBT_DEVICEREMOVECOMPLETE then
   begin
    case PDEV_BROADCAST_HDR(Msg.LParam)^.dbch_devicetype of
     DBT_DEVTYP_DEVICEINTERFACE:
     begin
      str:={'Nanoeducator controler turn off!!'+}pchar(@PDEV_BROADCAST_DEVICEINTERFACE(Msg.LParam)^.dbcc_name[0]);
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('interface removed '+str);
      {$ENDIF}
    if AnsiPos(LowerCase(strvidcontroller),LowerCase(str))<>0 then
      begin
       {$IFDEF DEBUG}
         Formlog.memolog.Lines.add(DigNanoeduDevName+'removed !');

      {$ENDIF}
        if FlgCurrentUserLevel<>Demo then   Main.ActionNew.Enabled:=false;
       if not  flgremovedev then
       begin
        show;
        LogMemo.Lines.Add(strcontroller+strturnoff );
        flgDetectDev:=false;
        flgremovedev:=true;
        i:=0;
        self.alphablendvalue:=255;
        timer.enabled:=true;
       end;
      end
      else
      if AnsiPos(LowerCase(strvidosc),LowerCase(str))<>0 then
      begin
        show ;
        LogMemo.Lines.Add(strosc+strturnoff);
        timer.enabled:=true;
      end
     end;
     DBT_DEVTYP_HANDLE:
      LogMemo.Lines.Add('уничтожен системный хендл');
     DBT_DEVTYP_OEM:
      LogMemo.Lines.Add('извлечено OEM- или IHV- устройство');
     DBT_DEVTYP_PORT:
      ShowMessage('извлечён порт: '+pchar(@PDEV_BROADCAST_PORT(Msg.LParam)^.dbcp_name[0]));
     DBT_DEVTYP_VOLUME:
      begin
       MSGSTR:='извлечён диск'+MSGSTR;
       diskname:=DWORDtoDiskNames(PDEV_BROADCAST_VOLUME(Msg.LParam)^.dbcv_unitmask)[1];
       LogMemo.Lines.Add(MSGSTR+' '+diskname{DWORDtoDiskNames(PDEV_BROADCAST_VOLUME(Msg.LParam)^.dbcv_unitmask)}+':');
       if DetectNanoeduFlashDisk(diskname) then show;
      end;
    end;
   end;

 if Msg.WParam=DBT_DEVNODES_CHANGED then
  begin
//   LogMemo.Lines.Add('конфигурация изменена');
  end;
//  Button2Click(nil);
//  Button6Click(nil);
end;



procedure TControllerDetect.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TControllerDetect.TimerTimer(Sender: TObject);
begin
 Timer.Enabled:=false;
if  flgDisappear then
 begin
   inc(i,6);
   self.alphablendvalue:=255-i;
 end;
  if self.alphablendvalue<=4 then begin hide; flgDisappear:=false; exit; end;
 Timer.Enabled:=true;
end;

procedure TControllerDetect.UpdateStrings;
begin
  strosc := siLangLinked1.GetTextOrDefault('strstrosc');
  strcontroller := siLangLinked1.GetTextOrDefault('strstrcontroller');
  strturnoff := siLangLinked1.GetTextOrDefault('strstrturnoff');
  strturnon := siLangLinked1.GetTextOrDefault('strstrturnon');

end;

procedure TControllerDetect.FormCreate(Sender: TObject);
var
  NF:TDEV_BROADCAST_DEVICEINTERFACE;
  tmp:TGUID;
begin
 siLangLinked1.ActiveLanguage:=Lang;
  UpdateStrings;
  flgdetectdev:=false;
  flgremovedev:=false;
  flgDisappear:=true;
  strvidcontroller:=EDU_INSTANCE_ID_PREF;//'Vid_0438&Pid_0f00';
  strvidosc:=EDU_INSTANCE_ID_PREF;//'Vid_0438&Pid_0f00';
  top:=main.Top+150;
  left:=main.clientwidth-width-100;
  i:=0;   flgDisappear:=true;
  LogMemo.Clear;
  //****** CODE fragment: ******
(*
DEV_BROADCAST_DEVICEINTERFACE NotificationFilter;
GUID tmp={0,0,0,""};
ZeroMemory( &NotificationFilter, sizeof(NotificationFilter) );

NotificationFilter.dbcc_size = sizeof(DEV_BROADCAST_DEVICEINTERFACE);
NotificationFilter.dbcc_devicetype = DBT_DEVTYP_DEVICEINTERFACE;
NotificationFilter.dbcc_classguid = tmp;

m_hDevNotify = RegisterDeviceNotification(m_hWnd ,&NotificationFilter,
DEVICE_NOTIFY_WINDOW_HANDLE|DEVICE_NOTIFY_ALL_INTERFACE_CLASSES);

//****** end CODE fragment: ******
*)
//  tmp:={0,0,0,''};
//  ZeroMemory( NF, sizeof(NF));
//  NF.dbcc_classguid = tmp;
  NF.dbcc_size:=sizeof(TDEV_BROADCAST_DEVICEINTERFACE);
  NF.dbcc_devicetype:=DBT_DEVTYP_DEVICEINTERFACE;
  RegisterDeviceNotification(Handle,@NF,DEVICE_NOTIFY_WINDOW_HANDLE or DEVICE_NOTIFY_ALL_INTERFACE_CLASSES);
end;

(*#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <windows.h>
#include <objbase.h>
#include <tchar.h>
#include <setupapi.h>
#include <strsafe.h>

#define SIZECHARS(x)         (sizeof((x))/sizeof(TCHAR))
//
// The following is the prototype for the newdev!InstallSelectedDriver API.
//


(*
procedure TControllerDetect.Button3Click(Sender: TObject);
begin
 LogMemo.Clear;
end;
*)
(*
procedure TControllerDetect.Button2Click(Sender: TObject);
var
  NetPnPHandle: HDEVINFO;
  DeviceNumber:DWORD;
  DevData: TSPDevInfoData;
  DeviceInterfaceData: TSPDeviceInterfaceData;
  RES:BOOL;
begin
  NetDevicesListBox.Clear;

  NetPnPHandle := SetupDiGetClassDevs(@GUID_DEVCLASS_NET, nil, 0, DIGCF_PRESENT );

  if NetPnPHandle = INVALID_HANDLE_VALUE then  Exit;

  DeviceNumber := 0;
  repeat
   DeviceInterfaceData.cbSize := SizeOf(TSPDeviceInterfaceData);
   DevData.cbSize := SizeOf(TSPDevInfoData);
   RES := SetupDiEnumDeviceInfo(NetPnPHandle, DeviceNumber, DevData);
   if RES then
    begin
     NetDevicesListBox.Items.Add(GetDeviceName(NetPnPHandle, DevData));
     Inc(DeviceNumber);
    end;
  until not RES;
  NetDevicesListBox.Enabled:=True;

  SetupDiDestroyDeviceInfoList(NetPnPHandle);
end;
*)
(*
procedure EnableNetDevice(aState:boolean;index:integer);
var
  NetPnPHandle:HDEVINFO;
  PCHP:TSPPropChangeParams;
  DeviceData:TSPDevInfoData;
begin
  NetPnPHandle:=SetupDiGetClassDevs(@GUID_DEVCLASS_NET, 0, 0, DIGCF_PRESENT);
  if NetPnPHandle=INVALID_HANDLE_VALUE then exit;

  DeviceData.cbSize:=sizeof(TSPDevInfoData);
  SetupDiEnumDeviceInfo(NetPnPHandle, index, DeviceData);

  PCHP.ClassInstallHeader.cbSize:=sizeof(TSPClassInstallHeader);

  if SetupDiSetClassInstallParams(NetPnPHandle,@DeviceData,@PCHP,sizeof(TSPPropChangeParams)) then
   begin
    PCHP.ClassInstallHeader.cbSize := sizeof(TSPClassInstallHeader);
    PCHP.ClassInstallHeader.InstallFunction := DIF_PROPERTYCHANGE;
    PCHP.Scope := DICS_FLAG_CONFIGSPECIFIC;
    if aState then
     PCHP.StateChange := DICS_ENABLE
              else
     PCHP.StateChange := DICS_DISABLE;
    SetupDiSetClassInstallParams(NetPnPHandle,@DeviceData,@PCHP,sizeof(TSPPropChangeParams));
    SetupDiCallClassInstaller(DIF_PROPERTYCHANGE,NetPnPHandle,@DeviceData);
   end;
  DeviceData.cbSize := sizeof(TSPDevInfoData);
  SetupDiDestroyDeviceInfoList(NetPnPHandle);
end;
*)
function CompareMem(p1, p2: Pointer; len: DWORD): boolean;
var
  i: DWORD;
begin
  result := false;
  if len = 0 then exit;
  for i := 0 to len-1 do
   if PByte(DWORD(p1) + i)^ <> PByte(DWORD(p2) + i)^ then exit;
  result := true;
end;
(*
function IsUSBDevice(DevInst: DWORD): boolean;
var
  IDLen: DWORD;
  ID: PChar;
begin
  result := false;
  if (CM_Get_Device_ID_Size(IDLen, DevInst, 0) <> 0) or (IDLen = 0) then exit;
  inc(IDLen);
  ID := GetMemory(IDLen);
  if ID = nil then exit;
  if (CM_Get_Device_ID(DevInst, ID, IDLen, 0) <> 0) or (not CompareMem(ID, PChar('USBSTOR'), 7)) then
   begin
    FreeMemory(ID);
    exit;
   end;
  FreeMemory(ID);
  result := true;
end;
*)
(*procedure RemoveDrive(index:integer);
var
  DrivesPnPHandle: HDEVINFO;
  DevInfo: SP_DEVINFO_DATA;
  i: Integer;
  Parent: DWORD;
  VetoName:array[0..MAX_PATH] of char;
begin
  DevInfo.cbSize := sizeof(SP_DEVINFO_DATA);
  DrivesPnPHandle := SetupDiGetClassDevsA(@GUID_DEVCLASS_DISKDRIVE, nil, 0, 2);
  if DrivesPnPHandle = INVALID_HANDLE_VALUE then exit;

  if SetupDiEnumDeviceInfo(DrivesPnPHandle, index, DevInfo) then
   begin
    if (IsUSBDevice(DevInfo.DevInst)) and (CM_Get_Parent(Parent, DevInfo.DevInst, 0) = CR_SUCCESS)
     then
      begin
       CM_Request_Device_Eject(Parent, nil, @VetoName, MAX_PATH, 0);
       if VetoName='' then
        ShowMessage('Устройство может быть извлечено')
                      else
        ShowMessage('Устройство не может быть извлечено');
      end
     else
      ShowMessage('Это не USB устройство');
   end;
  SetupDiDestroyDeviceInfoList(DrivesPnPHandle);
end;

procedure TControllerDetect.Button4Click(Sender: TObject);
begin
  if NetDevicesListBox.ItemIndex<0 then exit;

  EnableNetDevice(false,NetDevicesListBox.ItemIndex);

  NetDevicesListBox.Enabled:=false;

  Button2Click(nil);
end;

procedure TControllerDetect.Button5Click(Sender: TObject);
begin
  if NetDevicesListBox.ItemIndex<0 then exit;

  EnableNetDevice(true,NetDevicesListBox.ItemIndex);
  NetDevicesListBox.Clear;
  NetDevicesListBox.Enabled:=false;
 Button2Click(nil);
end;
*)
procedure TControllerDetect.FormShow(Sender: TObject);
begin
 siLangLinked1.ActiveLanguage:=Lang;
 LogMemo.Clear;
 i:=0;
 self.alphablendvalue:=255;
 flgDisappear:=true;
//  Button2Click(nil);
//  Button6Click(nil);
end;

(*procedure TControllerDetect.GetDevice(Sender: TObject);
var
  DrivePnPHandle: HDEVINFO;
  DeviceNumber:DWORD;
  DevData: TSPDevInfoData;
  DeviceInterfaceData: TSPDeviceInterfaceData;
  RES:BOOL;
  devName:string;
  GUID:TGUID;
// lpInterfaceDetailData:PSPDeviceInterfaceDetailData;
//  spInterfaceData:TSPDeviceInterfaceData;
//  dwInterfaceDetailDataSize:DWORD;


  dwErrCode:DWORD;
  dwReqSize:PDWORD;
  bStatus:Boolean;
begin
  DrivesListBox.Clear;
  //DrivePnPHandle := SetupDiGetClassDevs(@GUID_DEVCLASS_DISKDRIVE, nil, 0, DIGCF_PRESENT {or DIGCF_PROFILE});
  DrivePnPHandle := SetupDiGetClassDevs(@GUID_DEVCLASS_IMAGE, nil, 0, {DIGCF_PRESENT } DIGCF_PROFILE);
  if DrivePnPHandle = INVALID_HANDLE_VALUE then  Exit;

  DeviceNumber := 0;
  repeat
  // DevData:=GetMemory(sizeof(TSPDevInfoData));

   //DeviceInterfaceData.cbSize := SizeOf(TSPDeviceInterfaceData);
   spInterfaceData.cbSize := SizeOf(TSPDeviceInterfaceData);
   DevData.cbSize := SizeOf(TSPDevInfoData);
   RES := SetupDiEnumDeviceInfo(DrivePnPHandle, DeviceNumber, DevData);
   if (RES) then
    begin
     devName:= GetDeviceName(DrivePnPHandle, DevData);
     DrivesListBox.Items.Add(devName);


        Inc(DeviceNumber);
    end;
  until not RES;
  NetDevicesListBox.Enabled:=True;

  SetupDiDestroyDeviceInfoList(DrivePnPHandle);
  DrivesListBox.Enabled:=true;
end;
*)
(*
procedure TControllerDetect.Button7Click(Sender: TObject);
begin
  if DrivesListBox.ItemIndex<0 then exit;

  RemoveDrive(DrivesListBox.ItemIndex);

  DrivesListBox.Clear;
  DrivesListBox.Enabled:=false;

  Button6Click(nil);
end;
*)
end.


