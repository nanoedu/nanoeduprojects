library SioCSPMDemo;


uses
  ExceptionLog,
  Windows,
  Classes,
  SysUtils,
  DemoDcl in 'DemoDcl.pas',
  DemoThread in 'DemoThread.pas';

//  FastMM4Messages in '..\..\sources\FastMM4Messages.pas';

{$R *.res}


function ControlSetData( aptr : PBYTE; vptr : PWORD; n : BYTE ):DWORD; export; stdcall;
begin
        Result:=1;
        if (aptr^=$46) then
        begin
        PathDelay:=vptr^;   //millisec
        CntDec:=1;
        if PathDelay<10 then
           begin
             CntDec:=2*((20-PathDelay) div 4);       //3
             PathDelay:=1;
           end;
        end;
end;
function ControlGetData( aptr: PBYTE; vptr : PWORD; n : BYTE):DWORD;  export; stdcall;
begin
        Result:=1;
end;
function ControlGetTTA( buf : PBYTE; len : PDWORD):DWORD;  export; stdcall;
begin
        Result:=1;
end;

// Функции AS API
function ScanLoadAA(P:PByte;len:LongInt):DWORD;  export; stdcall;
begin
        Result:=0;
end;
function ScanStart():DWORD;     export; stdcall;
begin
        Result:=0;

end;
function ScanPause():DWORD;     export; stdcall;
begin
        Result:=1;
end;
function ScanResume():DWORD;    export; stdcall;
begin
        Result:=1;
end;
function ScanStop():DWORD;     export; stdcall;
begin
    //  Result:=DEMO_VERSION;
      Result:=0;
      FlgDone:=True;
end;

function BufRegister():DWORD;     export; stdcall;
begin
        Result:=0;
end;
function BufDeregister():DWORD;      export; stdcall;
begin
        Result:=0;
end;

function ScanInit(f:PFifo):DWORD;  export; stdcall;
begin
        Result:=0;
        Points_cnt:= f.out_count;
        Points_nmb:= f.out_count;
        flgDone:=False;
     //   f.out_count:=f.in_Count;
     {**   DemoDataTh:=DemoDataThread.Create(f);
        DemoDataTh.Resume; **}


end;
function ScanWork():DWORD;   export; stdcall;
var i:integer;
begin
      while (not flgDone) and (Points_cnt>0) do
         begin
           if Points_cnt<CntDec then   Points_cnt:=0
                                else   Points_cnt:=Points_cnt-CntDec;
           sleep(PathDelay);
         end;
           Result:=0;
end;
function ScanReport(f:PFifo):DWORD;    export; stdcall;
begin
        Result:=1;
         if Points_cnt<=0 then
         begin
          Points_cnt:=0;
          Result:=0;
         end;
         f.out_count:=Points_cnt;
         if  flgDone then result:=0;
end;
function ScanDone():DWORD;           export; stdcall;
begin
        Result:=0;
      {**  if assigned(DemoDataTh) then
        DemoDataTh.Terminate;
        DemoDataTh:=nil; **}
end;
function GetCurProc(p:DWORD):DWORD;     export; stdcall;
begin
        Result:=1;
end;

// Функции MISC API
function SelfTest():DWORD;             export; stdcall;
begin
        Result:=1;
end;

function GetSerialNumber(str : PWideChar; len: pDWORD):DWORD;   export; stdcall;
begin
   Result:=1;
end;

exports ControlSetData, ControlGetData, ControlGetTTA, ScanLoadAA, ScanStart,
        ScanPause, ScanResume, ScanStop, BufRegister, BufDeRegister,
        ScanInit, ScanWork, ScanReport, ScanDone, GetCurProc, SelfTest,
        GetSerialNumber;



end.



