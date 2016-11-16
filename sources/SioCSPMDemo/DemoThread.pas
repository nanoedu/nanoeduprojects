unit DemoThread;

interface

uses
  Classes, SysUtils, DemoDcl, Windows;

type
  DEmoDataThread = class(TThread)
  private
    { Private declarations }
    hMutex:THandle;
  protected

    procedure Execute; override;
  public
  constructor Create(f:PFifo);
  Destructor Destroy; override;
  end;

var DemoDataTh:DemoDataThread;
    // FTemp:PFifo;
    Points_cnt{, Points_Nmb}:longint;
implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure DEmoDataThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ DEmoDataThread }

constructor DemoDataThread.Create(f:PFifo);
begin
inherited Create(True);
HMutex:=CreateMutex(nil,false,nil);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpHigher{tpLowest});
   Suspended := True;//false;// Resume;
  // Points_cnt:= f.in_count;
   Points_cnt:= f.out_count;

end;

procedure DemoDataThread.Execute;
//var cnt:LongInt;
begin
//  cnt:=0;
  while (not Terminated) do
    begin
    //  FTemp.out_count:=FTemp.out_count-1;
      WaitForSingleObject(HMutex,INFINITE);
        Points_cnt:=Points_cnt-1;
      ReleaseMutex(HMutex);
      sleep(PathDelay);
    end;
end;

Destructor DemoDataThread.Destroy;
begin

 CloseHandle(HMutex);
 inherited
end;

end.
