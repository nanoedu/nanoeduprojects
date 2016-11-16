unit UControllerService;

interface
uses  Windows;

 procedure InitControllerBufers;
 procedure FreeControllerBufers;

implementation

uses CSPMVar,GlobalVar;

procedure InitControllerBufers;
var val:integer;
begin
   val:=0;
  GetMem(pControllerParams,sizeof(RControllerParamsRecord));
  FillMemory(pControllerParams,sizeof(RControllerParamsRecord),val)
end;
procedure FreeControllerBufers;
begin
  FreeMem(pControllerParams);
 end;
end.
