unit ScannermoveXYZDrawThread;

interface

uses
  Classes,Windows,Forms,messages,dialogs,sysutils,MLPC_APILib_TLB,comobj,activex;

type
  TScannermoveXYZDrawThread = class(TThread)
  private
    { Private declarations }
     ElementSize:integer;
     nElements,dataoutcount:Integer;
     logstr:string;
  protected
    procedure DrawSteps;
    procedure Execute; override;
    procedure Log;
    procedure GetData;
  public
      constructor Create;
      destructor Destroy; override;
  end;
var  ScannerMoveXYZThread:TScannermoveXYZDrawThread;
     ScannerMoveXYZThreadActive:boolean;

implementation

uses frPositionXYZ,cspmvar,globalvar,
   {$IFDEF DEBUG}
       frDebug,
      {$ENDIF}
       SioCSPM,NL3LFBLib_TLB,MLPC_API2Lib_TLB;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure ScannermoveXYDrawThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ ScannermoveXYDrawThread }

constructor TScannermoveXYZDrawThread.Create;
begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;
 end;

destructor TScannermoveXYZDrawThread.Destroy;
begin
   ThreadFlg:=mDrawing;
   PostMessage(ScannerPositionXYZ.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;
  procedure TScannermoveXYZDrawThread.GetData;
  begin
//    ScannermoveXYZParams.FlgStepResult:=PIntegerArray(Data_out)[0];
             case ScannerPositionXYZ.RadioGroupDir.itemindex of
 0: ScannerMoveXYZParams.StepsCountX:=ScannerMoveXYZParams.StepsCountX+PIntegerArray(DataBuf)[0];
 1: ScannerMoveXYZParams.StepsCountY:=ScannerMoveXYZParams.StepsCountY+PIntegerArray(DataBuf)[0];
 2: ScannerMoveXYZParams.StepsCountZ:=ScannerMoveXYZParams.StepsCountZ+PIntegerArray(DataBuf)[0];
     end;

  end;
 procedure TScannermoveXYZDrawThread.DrawSteps;
 begin
(*         case ScannerPositionXYZ.RadioGroupDir.itemindex of
 0: ScannerMoveXYZParams.StepsCountX:=ScannerMoveXYZParams.StepsCountX+ScannerMoveXYZParams.StepsNumb;
 1: ScannerMoveXYZParams.StepsCountY:=ScannerMoveXYZParams.StepsCountY+ScannerMoveXYZParams.StepsNumb;
 2: ScannerMoveXYZParams.StepsCountZ:=ScannerMoveXYZParams.StepsCountZ+ScannerMoveXYZParams.StepsNumb;
     end;
 *)
    ScannerPositionXYZ.lblStepsXVal.Caption:=inttostr( ScannerMoveXYZParams.StepsCountX);
    ScannerPositionXYZ.lblStepsYVal.Caption:=inttostr( ScannerMoveXYZParams.StepsCountY);
    ScannerPositionXYZ.lblStepsZVal.Caption:=inttostr(- ScannerMoveXYZParams.StepsCountZ);
 end;
procedure TScannermoveXYZDrawThread.Execute;
  { Place thread code here }
  var flgEnd:boolean;
    errcnt:integer;
    NChElements,CurChElements,nRead:integer;
    n,ID,ntoread:integer;
    NewPCount:longint;
    nwrite,data,i:integer;
    pval:Pinteger;
    hr:Hresult;
//    pstopval:Pinteger;
    count:integer;
    errorcountstop:integer;
begin
  { Place thread code here }
  //create channels interface
 CoInitializeEx(nil,COINIT_MULTITHREADED);
    logstr:='Start moving XYZ';
    Synchronize(log);
//    new(PStopVal);
    errcnt:=0;      count:=0; errorcountstop:=0;
    ScannerPositionXYZ.ToolBarControlX.Enabled:=true;
    Application.ProcessMessages;

 if CreateChannels(AlgParams.NChannels) then
  begin
  //  new(pVaL);
     arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
     flgEnd:=false;
     hr:=arPCChannel[ch_Data_out].Main.get_Geometry(NChElements,ElementSize);
          if Failed(hr) then
                  begin
                    logstr:='error read geometry'+inttostr(nread);
                    Synchronize(log);
                   end
                  else
                  begin
                    logstr:='Channel data; Elements='+inttostr(NChElements)+'size='+inttostr(ElementSize);
                    Synchronize(log);
                  end;
       while (not Terminated) and (not flgEnd) do
      begin
       if flgJavaRunning  then
       begin
         nread:=1;
         sleep(100*(1+round(ScannerMoveXYZParams.StepsNumbFast/100)));
        if FlgStopJava then
         begin
          sleep(500);
           StopBuf^:=StopJava;
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
                    Formlog.memolog.Lines.add('write stop channel ='+inttostr(StopBuf^)+' '+inttostr(nwrite));
               {$ENDIF};
               inc(errorcountstop)
           end
           until not Failed(hr) and (errorcountstop<50);
             sleep(300);
        repeat
            nread:=1;
            hr:=arPCChannel[ch_steps_done].ChannelRead.Read(StopBuf,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error read steps channel'+inttostr(nread)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('read step channel ='+inttostr(StopBuf^)+' '+inttostr(nread));
            {$ENDIF}
            inc(count);
            sleep(100);
          until  (StopBuf^=done) or (count=20);
             {$IFDEF DEBUG}
                   Formlog.memolog.Lines.add('step =done'+inttostr(StopBuf^)+' '+inttostr(nread));
            {$ENDIF}
  //           FlgStopScannerMoveXYZ:=true; //stop button press       stop moving
             break;
         end; //stop java
   //      ScannerMoveXYZThreadActive := True;
         hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(ntoread);     //get new data count
        {$IFDEF DEBUG}
         if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(ntoread)+'hr='+inttostr(hr))
                       else Formlog.memolog.Lines.add('mover data to read '+inttostr(ntoread));
        {$ENDIF}
         ntoread:=ElementSize;
         hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,ntoread);    /// read data //nread is not number of elements ????
        {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read channel data '+inttostr(ntoread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('mover data has read '+inttostr(ntoread));
        {$ENDIF}
        if Failed(hr) then
                    begin
                      ntoread:=0;
                      inc(errcnt); //
                   end;
       if errcnt> 100  then
                 begin
                    flgEnd:=true;
                      {$IFDEF DEBUG}
                            Formlog.memolog.Lines.add('STOP : NMB of CHANNEL ERRORS =   '+inttostr(errcnt));
                      {$ENDIF}
                 end;
     if ntoread<> 0  then
     begin
      logstr:='step done';
      GetData;
      Synchronize(log);
      synchronize(DrawSteps);
     end
     end;    //java running
   end;    //while
    ScanDone;
    FreeChannels;
  end //channel ID
 else  //error create channels
 begin
//    ScannerPositionXYZ.ToolBarControlX.Enabled:=true;
//    ScannerPositionXYZ.StopBtnX.Enabled:=false;
//    Application.ProcessMessages;
 end;  //channels create
    logstr:='End drawing';
    Synchronize(log);
//    dispose(pStopVal);
    FlgStopJava:=false;
    FlgStopScannerMoveXYZ:=true;
    PostMessage(ScannerPositionXYZ.Handle,wm_ThreadDoneMsg,mScanning,0);
    CoUnInitialize;
    Self.Terminate;
end;


procedure TScannermoveXYZDrawThread.log;
begin
      {$IFDEF DEBUG}
           Formlog.memolog.Lines.add(logstr);
      {$ENDIF}
end;
end.
