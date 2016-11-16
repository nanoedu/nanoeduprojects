unit Udrvinstall;

interface
uses windows,setupapi;
(*
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <windows.h>
#include <objbase.h>
#include <tchar.h>
#include <setupapi.h>
#include <strsafe.h>

#define SIZECHARS(x)         (sizeof((x))/sizeof(TCHAR))
 typedef
BOOL
(*PINSTALLSELECTEDDRIVER)(
  HWND hwndParent,
  HDEVINFO DeviceInfoSet,
  LPCWSTR Reserved,
  BOOL Backup,
  PDWORD pReboot
  );

*)

type INSTALLSELECTEDDRIVER=function(hwndParent:HWND; DeviceInfoSet:HDEVINFO; Reserved:PwideCHar; Backup:boolean; pReboot:PDword):boolean; stdcall;

 function Installdrv:boolean;
implementation
{ /* You can build the following code sample by using the following command-line arguments after you select the correct build environment, such as XP Checked:

cl -nologo -DUNICODE <SourceFile.cpp> -link setupapi.lib

NOTE: <SourceFile.cpp> represents the name of the source file.
*/
    //
// The following is the prototype for the newdev!InstallSelectedDriver API.
//
}
 (*function sizechars(x):Integer;
 begin
//  result:=sizeof(x)/sizeof(Tchar);
 end;
 *)
function Installdrv:boolean;
var
     Err:DWORD;
     DeviceInfoSet:HDEVINFO ;
     DeviceInfoData:SP_DEVINFO_DATA;
     DriverInfoData:SP_DRVINFO_DATA;
     DeviceInstallParams:TSPDevInstallParams;
     NewDevPath:array[0..MAX_PATH] of Char;
     hNewDev:HMODULE;
     pInstallSelectedDriver:INSTALLSELECTEDDRIVER;
     Reboot:DWORD;
     label Clean0;
begin
    //
    // The command line will contain a device instance Id and a full
    // path of an INF.
    //
    //
    // Create an empty device information list.
    //
    Err:= NO_ERROR;
    //DeviceInfoSet:= INVALID_HANDLE_VALUE;
    pInstallSelectedDriver:=nil;
    DeviceInfoSet:= SetupDiCreateDeviceInfoList(0,0);
    if (DeviceInfoSet=INVALID_HANDLE_VALUE) then
   begin
        Err:= GetLastError();
        goto clean0;
   end;

    //
    // Add the device that is referenced by the device instance id parameter
    // to the device information list.
    //
    DeviceInfoData.cbSize := sizeof(DeviceInfoData);
    if (not SetupDiOpenDeviceInfo(DeviceInfoSet,
                               PWideChar('USB\VID_04338&PID_0F00'),
                               nil,
                               0,
                               DeviceInfoData))then
    begin
        Err:=GetLastError();
        goto clean0;
    end;
    //
    // InstallSelectedDriver works on the selected device and on the
    // selected driver on that device. Therefore, set this device as the
    // selected one in the device information list.
    //
    if (not SetupDiSetSelectedDevice(DeviceInfoSet,
                                  DeviceInfoData)) then
   begin
        Err:= GetLastError();
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
                                       DeviceInstallParams)) then
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
    DeviceInstallParams.Flags |= DI_ENUMSINGLEINF;
    infpath:=Pchar(ExeFilePath+'DriverSetUp\cspm.inf');
   (* if (FAILED(StringCchCopy(DeviceInstallParams.DriverPath,
                             SIZECHARS(DeviceInstallParams.DriverPath),
                             argv[2]))) then

   begin
        //
        // The file path that was passed in was too big.
        //
        Err:= ERROR_INVALID_PARAMETER;
        goto clean0;
   end;
    *)
    //
    // Set the DI_FLAGSEX_ALLOWEXCLUDEDDRVS flag so that you can use
    // this INF even if it is marked as ExcludeFromSelect.
    // ExcludeFromSelect means do not show the INF in the legacy Add
    // Hardware Wizard.
    //
    DeviceInstallParams.FlagsEx |= DI_FLAGSEX_ALLOWEXCLUDEDDRVS;

    if (not SetupDiSetDeviceInstallParams(DeviceInfoSet,
                                       DeviceInfoData,
                                       DeviceInstallParams))then
                                       begin
        Err:= GetLastError();
        goto clean0;
    end;

    //
    // Build up a Driver Information List from the specified INF.
    // Build a compatible driver list, meaning only include the
    // driver nodes that match one of the hardware or compatible Ids of
    // the device.
    //
    if ( not SetupDiBuildDriverInfoList(DeviceInfoSet,
                                    DeviceInfoData,
                                    SPDIT_COMPATDRIVER)) then
begin
        Err:= GetLastError();
        goto clean0;
 end;

    //
    // Pick the best driver in the list of drivers that was built.
    //
    if ( not SetupDiCallClassInstaller(DIF_SELECTBESTCOMPATDRV,
                                   DeviceInfoSet,
                                   &DeviceInfoData)) then
   begin
        Err:= GetLastError();
        goto clean0;
    end;

    //
    // Get the selected driver node.
    // Note: If this list does not contain any drivers, this call
    // will fail with ERROR_NO_DRIVER_SELECTED.
    //
    DriverInfoData.cbSize = sizeof(DriverInfoData);
    if ( not SetupDiGetSelectedDriver(DeviceInfoSet,
                                  DeviceInfoData,
                                  DriverInfoData)) then
   begin
        Err:= GetLastError();
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
    if (GetSystemDirectory(NewDevPath, SIZECHARS(NewDevPath)) = 0) then
    begin
        Err:= GetLastError();
        goto clean0;
    end;
 (*
    if (FAILED(StringCchCat(NewDevPath, SIZECHARS(NewDevPath), TEXT("\\NEWDEV.DLL")))) then
    begin
        Err:= ERROR_INSUFFICIENT_BUFFER;
        goto clean0;
    end;
   *)
    NewDevPath:='NEWDEV.DLL';
    hNewDev:=LoadLibrary(NewDevPath);
    if (not hNewDev) then
    begin
        Err:= GetLastError();
        goto clean0;
    end;

    pInstallSelectedDriver = GetProcAddress(hNewDev, 'InstallSelectedDriver');
    if ( not pInstallSelectedDriver) then
begin
        Err:= GetLastError();
        goto clean0;
    end;

    //
    // Call pInstallSelectedDriver to install the selected driver on
    // the selected device.
    //
    pInstallSelectedDriver(nil,
                           DeviceInfoSet,
                           nil,
                           TRUE,
                           Reboot);

(*    if (Reboot and (DI_NEEDREBOOT or DI_NEEDRESTART)) then
     begin
        //
        // A reboot is required.
        //
    end;
 *)
clean0:
    if (hNewDev) then
    begin
        FreeLibrary(hNewDev);
        hNewDev:= nil;
    end;

    if (DeviceInfoSet <> INVALID_HANDLE_VALUE) then
     begin
        SetupDiDestroyDeviceInfoList(DeviceInfoSet);
        DeviceInfoSet:= INVALID_HANDLE_VALUE;
    end;

//    printf("iseldrv returned 0x%X\n", Err);
    result:=Err;
end;

end.
