unit uNewdev;

interface
uses windows;
(*BOOL
WINAPI
UpdateDriverForPlugAndPlayDevicesA(
    __in_opt  HWND hwndParent,
    __in      LPCSTR HardwareId,
    __in      LPCSTR FullInfPath,
    __in      DWORD InstallFlags,
    __out_opt PBOOL bRebootRequired
    );

BOOL
WINAPI
UpdateDriverForPlugAndPlayDevicesW(
    __in_opt  HWND hwndParent,
    __in      LPCWSTR HardwareId,
    __in      LPCWSTR FullInfPath,
    __in      DWORD InstallFlags,
    __out_opt PBOOL bRebootRequired
    );

#ifdef UNICODE
#define UpdateDriverForPlugAndPlayDevices UpdateDriverForPlugAndPlayDevicesW
#else
#define UpdateDriverForPlugAndPlayDevices UpdateDriverForPlugAndPlayDevicesA
#endif
#endif // (WINVER >= _WIN32_WINNT_WIN2K)
*)

 function UpdateDriverForPlugAndPlayDevicesA(
     hwndParent:HWND;
     HardwareId:PChar;
     FullInfPath:Pchar;
     InstallFlags:dword;
     bRebootRequired:Pboolean
    ):boolean; StdCall; external 'newdev.dll';

// UpdateDriverForPlugAndPlayDevices=UpdateDriverForPlugAndPlayDevicesA;

implementation

end.
