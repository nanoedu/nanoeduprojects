unit ControlThread;

interface

uses
  Classes;

type
  TControlThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
        constructor Create;
      destructor Destroy; override;

  end;
 var CtrlThread: TControlThread ;
implementation
uses CSPMVar,uNanoEduScanClasses,
     UNanoEduInterface,SpectrDrawThread;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TControlThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TControlThread }
constructor TControlThread.Create;
begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpHigher{tpNormal});
   Suspended := false;// Resume;
 end;

destructor TControlThread.Destroy;
begin
//   PostMessage(ScanWND.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;

procedure TControlThread.Execute;
begin
  { Place thread code here }
    while (not Terminated) and (CurrentScanCount<ScanParams.ScanLines) do
   begin


   end;
end;

end.
