unit RenishawOscThread;

interface
uses
  Classes,  Windows,Forms, Messages,SysUtils, Dialogs,  Graphics, Controls,
  GlobalType;

  type
  TRenishawOscThread = class(TThread)
  private
     sz, lsz:integer;
     CurrentPoint, CurrentPozinDOut:integer;
     TempSignal, TempSignalDetected: array of  apitype;
  protected
    procedure Execute; override;
    procedure GetData;
    procedure DrawGraphics;
  public
    constructor Create;
    destructor Destroy; override;
  end;

var  ReniShawThr:TReniShawOscThread;
     ReniShawThreadActive:Boolean;

implementation

uses Chart, RenishawVars,CSPMVar, GlobalVar, frReniShawOsc,SioCSPM, uNanoEduBaseClasses,
uNanoEduScanClasses, uNanoeduInterface ;

constructor TReniShawOscThread.Create;
begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;// Resume;
end;

destructor TReniShawOscThread.Destroy;
begin
   PostMessage(FormReniShawOsc.Handle,wm_ReniShawThreadDoneMsg,ReniShawDrawing,0);
   //Finalize(TempSignal);
  // Finalize(TempSignalDetected);
  SetLength(TempSignal,0);
  SetLength(TempSignalDetected,0);
   inherited destroy;
end;
procedure TReniShawOscThread.Execute;
var
 i,ds:integer;
 NewPCount,NPc:longint;
 PointsNmb:integer;
// fs:fifo_desc;
begin
   CurrentPoint:=0;
   CurrentPozinDOut:=0;
   sz:=2;
  // PointsNmb:=2*(32700-abs(API.DACX));
   PointsNmb:=2*(Nanoedu.Method as TReniShawOsc).n_Points;//ScanParams.CycleCount;
   ds:=1;
//   MoveMemory(@fs,@f,sizeof(fifo_desc));
//   fs.out_count:=REPORT_NO_WAIT;
   try
    while (not Terminated) do
   begin
 //    i:=ScanReport(@fs);
 //      if fs.out_count<=0 then fs.out_count:=0;
 //     NewPCount:=PointsNmb-fs.out_count-CurrentPozinDOut;
       if odd(NewPCount) then dec(NewPCount);
     while  (NewPCount>0) do
       begin
              NPC:=NewPCount;
              NewPCount:=0;
              lsz:=NPC div  sz;
              SetLength(TempSignal,lsz);
              SetLength(TempSignalDetected,lsz);
              GetData;
              Synchronize(DrawGraphics);

             // XPos:=XPos+lsz;  //NPC
        end;// NewPpoint>0
    if i=0 then
      begin
          PostMessage(FormReniShawOsc.Handle,WM_ReniShawThreadDoneMsg, ReniShawScanning,0);
          break;
      end;
 //     fs.in_count:=REPORT_WAIT;
//      fs.path_count:=REPORT_WAIT;
//    if fs.out_count>ds then  fs.out_count:=fs.out_count-ds
//                       else  fs.out_count:=REPORT_WAIT;
 //  TempSignal:=nil;
 //  TempSignalDetected:=nil;
   end; {while }
 finally
//   fs.Pin:=nil;
//   fs.Pout:=nil;
//   fs.PPath:=nil;
   TempSignal:=nil;
   TempSignalDetected:=nil;
  if (not Terminated) then  Self.Terminate;
  end;{finally}

end;

procedure TReniShawOscThread.GetData;
var i,j:integer;
    value:apitype;
begin
for i:=0 to lsz-1 do
  begin
    value :=datatype(PIntegerArray(DataBuf)[CurrentPozinDOut]);

    if value<0 then value:=0;
    TempSignal[i]:=value;
    (Nanoedu.Method as TREniShawOsc).reniShowSignal[CurrentPoint]:=value;
    inc(CurrentPozinDOut);


    value :=datatype(PIntegerArray(DataBuf)[CurrentPozinDOut]);

    TempSignalDetected[i]:=value;
    (Nanoedu.Method as TREniShawOsc).signal_scrdetected[CurrentPoint]:=value;
    inc(CurrentPozinDOut);
    inc(CurrentPoint);
  end;
end;

procedure TReniShawOscThread.DrawGraphics;
var i:integer;
begin
  FormReniShawOsc.ChartCurrentSignal.BottomAxis.Automatic:=True;
  for i:=0 to lsz-1 do
    begin
       if FormReniShawOsc.SerCurrentRSSignal.Count>1500 then
         begin
            FormReniShawOsc.SerCurrentRSSignal.Delete(0);
            FormReniShawOsc.SerCurrentRSPulses.Delete(0);
          end;
        FormReniShawOsc.SerCurrentRSSignal.AddXY(LastDrawnPoint,TempSignal[i]);
        FormReniShawOsc.SerRSSignalHist.AddXY(LastDrawnPoint,TempSignal[i]);
        FormReniShawOsc.SerRSPulsesHist.AddXY(LastDrawnPoint,TempSignalDetected[i]);
        FormReniShawOsc.SerCurrentRSPulses.AddXY(LastDrawnPoint,TempSignalDetected[i]);
       inc(LastDrawnPoint);
    end;
end;


end.
