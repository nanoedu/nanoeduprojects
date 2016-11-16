unit UfindProcess;

interface

 uses classes,windows;

procedure CreateWinNTProcessList(List: TstringList);
procedure GetProcessList(var List: TstringList);
function  EXE_Running(FileName: string; bFullpath: Boolean): Boolean;

implementation

uses  SysUtils,PsApi;


procedure CreateWinNTProcessList(List: TstringList);
var
  PIDArray: array [0..1023] of DWORD;
  cb: DWORD;
  I: Integer;
  ProcCount: Integer;
  hMod: HMODULE;
  hProcess: THandle;
  ModuleName: array [0..300] of Char;
begin
  if List = nil then Exit;
  EnumProcesses(@PIDArray, SizeOf(PIDArray), cb);
  ProcCount := cb div SizeOf(DWORD);
  for I := 0 to ProcCount - 1 do
  begin
    hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,False,PIDArray[I]);
    if (hProcess <> 0) then
    begin
      EnumProcessModules(hProcess, @hMod, SizeOf(hMod), cb);
      GetModuleFilenameEx(hProcess, hMod, ModuleName, SizeOf(ModuleName));
      List.Add(ModuleName);
      CloseHandle(hProcess);
    end;
  end;
end;

procedure GetProcessList(var List: TstringList);
var
  ovi: TOSVersionInfo;
begin
  if List = nil then Exit;
 CreateWinNTProcessList(List);
end;

function EXE_Running(FileName: string; bFullpath: Boolean): Boolean;
var
  i: Integer;
  MyProcList: TstringList;
begin
  MyProcList := TStringList.Create;
  try
    GetProcessList(MyProcList);
    Result := False;
    if MyProcList = nil then Exit;
    for i := 0 to MyProcList.Count - 1 do
    begin
      if not bFullpath then
      begin
        if CompareText(ExtractFileName(MyProcList.Strings[i]), FileName) = 0 then
          Result := True
      end
      else if CompareText(MyProcList.strings[i], FileName) = 0 then Result := True;
      if Result then Break;
    end;
  finally
    MyProcList.Free;
  end;
end;
(*
 function EXE_Running(FileName: string; bFullpath: Boolean): Boolean;
var
  PIDArray: array [0..1023] of DWORD;
  cb: DWORD;
  I: Integer;
  ProcCount: Integer;
  hMod: HMODULE;
  hProcess: THandle;
  ModuleName: array [0..300] of Char;
  MyProcList: TstringList;
begin
  EnumProcesses(@PIDArray, SizeOf(PIDArray), cb);
  ProcCount := cb div SizeOf(DWORD);
 for I := 0 to ProcCount - 1 do
 begin
  try
    hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,False,PIDArray[I]);
    if (hProcess <> 0) then
    begin
      EnumProcessModules(hProcess, @hMod, SizeOf(hMod), cb);
      GetModuleFilenameEx(hProcess, hMod, ModuleName, SizeOf(ModuleName));
     if not bFullpath then
      begin
        if CompareText(ExtractFileName(MODULENAME), FileName) = 0 then   Result := True
      end
      else if CompareText(MODULENAME, FileName) = 0 then Result := True;
      if Result then
      begin
          TerminateProcess(HProcess,4);
          Break;
      end;
   end;
  finally
      CloseHandle(hProcess);
  end;
 end;
end;
 *)
end.
