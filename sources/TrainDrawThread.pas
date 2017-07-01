unit TrainDrawThread;

interface

uses
  Classes,windows,Forms,Messages,SysUtils,
  MLPC_APILib_TLB,MLPC_APILib_Demo,
  {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
   Activex;
type
  TTrainThreadDraw = class(TThread)
  private
    { Private declarations }
    CurrentCycle:Integer;

  protected
    procedure Execute; override;
      procedure DrawProgress;
  public
          constructor Create;
      destructor Destroy; override;
  end;
 var   DrawTrainThread:TTrainThreadDraw;
       TrainDrawThreadActive:Boolean;

implementation

 uses GlobalType,CSPMVar,SioCSPM,frScannerTraining;

   { Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TTrainningThreadDraw.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TTrainningThreadDraw }
 constructor TTrainThreadDraw.Create;
begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;// Resume;
end;

destructor TTrainThreadDraw.Destroy;
begin
   PostMessage(FormScannerTraining.Handle,wm_ThreadTrainDoneMsg,TrainDrawing,0);
   inherited destroy;
end;
procedure TTrainThreadDraw.Execute;
var
 i,ds:integer;
 //NE II
    hr:HResult;
    flgEnd:boolean;
    ElementSize:Integer;
    nChElements,nRead:integer;
    n,ID,nwrite,errorcountstop,count:integer;
    data:integer;
    errcnt:integer;
begin
   CurrentCycle:=0;
   ds:=1;
   {$IFDEF DEBUG}
      Formlog.memolog.Lines.add('Start training');
   {$ENDIF}
if CreateChannels(AlgParams.NChannels) then
 begin
   arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
  if ID=ch_Data_OUT then
  begin
    flgEnd:=false;
    hr:=arPCChannel[ch_Data_out].Main.get_Geometry(NChElements,ElementSize);
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read geometry'+inttostr(nread)+'hr='+inttostr(hr));
         Formlog.memolog.Lines.add('Channel data; Elements='+inttostr(NChElements)+'size='+inttostr(ElementSize));
      {$ENDIF}
     nread:=0;
  while (not Terminated) and (CurrentCycle<ScanParams.CycleCount) and (not flgEnd) do
    begin
      nread:=1;
      if FlgStopJava then
         begin
           PintegerArray(StopBuf)[0]:=StopJava;
           repeat
           begin
            nwrite:=1;
            hr:=arPCChannel[ch_stop].ChannelWrite.Write(StopBuf,nwrite);     //read stop channel  if stopbutton pressed  pStopval^=done
            if Failed(hr) then
                {$IFDEF DEBUG}
                  Formlog.memolog.Lines.add('error write stop channel'+inttostr(nwrite)+'hr='+inttostr(hr))
               {$ENDIF}
                else
               {$IFDEF DEBUG}
                    Formlog.memolog.Lines.add('write stop channel ='+inttostr(PIntegerArray(StopBuf)[0])+' '+inttostr(nwrite));
               {$ENDIF};
               inc(errorcountstop)
           end
           until not Failed(hr) and (errorcountstop<50);
           sleep(300);
          repeat
            nread:=1;
            hr:=arPCChannel[ch_Draw_done].ChannelRead.Read(DoneBuf,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error read stop channel'+inttostr(nread)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('read stop channel ='+inttostr(PIntegerArray(DoneBuf)[0])+' '+inttostr(nread));
            {$ENDIF}
            inc(count);
      //      if flgCurrentUserLevel<>Demo then StopBuf^:=done;
            sleep(100);
          until  (PIntegerArray(DoneBuf)[0]=done) or (count=20);
         if PIntegerArray(DoneBuf)[0]=done then
         begin
           flgEnd:=true; //stop button press       stop scanning
           break;
         end;
       end; //stopjava
    // sleep(3000);
     sleep(GETCOUNT_DELAY);
     hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(nread);     //get new data count
       {$IFDEF DEBUG}
     if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(nread)+'hr='+inttostr(hr))
                   else Formlog.memolog.Lines.add('trainning data to read '+inttostr(nread));
       {$ENDIF}

    if   nread>0 then
     begin
      hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,nread);    /// read data //nread is not number of elements ????
      {$IFDEF DEBUG}
       if Failed(hr) then Formlog.memolog.Lines.add('error read channel data '+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('training data has read '+inttostr(nread));
      {$ENDIF}
       Synchronize(DrawProgress);
      CurrentCycle:=CurrentCycle+nread;
     end;//>0
  end; {while ScanCount}
   end; //id
    ScanDone;
   FreeChannels;
 end; //create channel
      PostMessage(FormScannerTraining.Handle,wm_ThreadTrainDoneMsg, TrainScanning,0);
  if (not Terminated) then  Self.Terminate;
  { Place thread code here }
end;

 procedure TTrainThreadDraw.DrawProgress;
 begin
   FormScannerTraining.ProgressBar.Position:=CurrentCycle;
 end;
end.
