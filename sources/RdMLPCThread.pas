unit RdMLPCThread;

interface

uses
  Classes,windows,SysUtils,Globaltype,MLPC_APILib_TLB,comobj,activex,
    {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
      GlobalDCl;

type
  TReadMLPCThread = class(TThread)
  private
    PointsNmb:integer;
  protected
    procedure Execute; override;
    procedure GetScanData(var n:longint; var Data:ArrayInt);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  var
  ReadMLPCThread:TReadMLPCThread;
  ReadMLPCThreadActive:boolean;

implementation

uses GlobalVar,SioCSPM,mMain,CSPMVar;

constructor TReadMLPCThread.Create;
begin
  inherited Create(True);
   CoInitializeEx(nil,COINIT_MULTITHREADED);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;// Resume;
end;

destructor TReadMLPCThread.Destroy;
begin
    CoUnInitialize;
    ThreadFlg:=mReadingMLPC;
    PostMessage(Main.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
    inherited destroy;
end;

procedure TReadMLPCThread.Execute;
var
    CurrentP:integer;
    ntoread:integer;
//NE II
    hr:HResult;
    flgEnd:boolean;
    NChElements,CurChElements,nRead:integer;
    n,ID:integer;
    data:integer;
    pstopval:Pinteger;
    errcnt:integer;
    ElementSize:integer;
    //
begin
  flgEnd:=false;
  PointsNmb:= 64;//AlgReadfromMLPCParams.PagesNmb*64;
  CurrentP:=0;

    {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start drawing');
    {$ENDIF}
if CreateChannels(3) then
 begin
   arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
  if ID=ch_Data_OUT then
  begin
    flgEnd:=false;
//    elsize:=2;       // {frq,Ampl}
    hr:=arPCChannel[ch_Data_out].Main.get_Geometry(PointsNmb,ElementSize);
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read geometry'+inttostr(nread)+'hr='+inttostr(hr));
         Formlog.memolog.Lines.add('Channel data; Elements='+inttostr(NChElements)+'size='+inttostr(ElementSize));
      {$ENDIF}

  while (not Terminated) and (CurrentP<PointsNmb) and (not flgEnd) do
  begin
      nread:=1;
      if FlgStopJava then
         begin
            hr:=arPCChannel[ch_Draw_done].ChannelRead.Read(pStopval,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error read stop channel'+inttostr(nread)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('read stop channel ='+inttostr(pStopval^)+' '+inttostr(nread));
            {$ENDIF}

           if pStopval^=done then   flgEnd:=true; //stop button press       stop scanning
         end;
      // sleep(300);
      hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(ntoread);     //get new data count
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(ntoread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('scandraw data to read '+inttostr(ntoread));
       {$ENDIF}

       nread:=ntoread;
       {$IFDEF DEBUG}
       if (ntoread <> Pointsnmb) then Formlog.memolog.Lines.add(' N channel data <> N Data!! '+inttostr(ntoread))
                      else Formlog.memolog.Lines.add('OK: To read : '+inttostr(ntoread));
      {$ENDIF}
       CurrentP:=nRead;
       hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,nread);    /// read data //nread is not number of elements ????
     // hr:=(arPCChannel[ch_Data_out].Main as IMLPCChannelRead2).ReadWait(data_out,nread,1000);
      {$IFDEF DEBUG}
       if Failed(hr) then Formlog.memolog.Lines.add('error read channel data '+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('scandraw data has read '+inttostr(nread));
      {$ENDIF}
        flgEnd:=true;
        if Failed(hr) then
                    begin
                      nread:=0;
                      inc(errcnt); //
                   end;
       if errcnt> 100  then
                 begin
                    flgEnd:=true;
                      {$IFDEF DEBUG}
                            Formlog.memolog.Lines.add('STOP : NMB of CHANNEL ERRORS =   '+inttostr(errcnt));
                      {$ENDIF}
                 end;
    end;
         Finalize(DataFromMLPC);
         GetScanData(N , DataFromMLPC);
  end;
   ScanDone;      // ???
   FreeChannels;
 end;
end;

procedure TReadMLPCThread.GetScanData(var n:longint; var Data:ArrayInt);
var i:integer;
begin
 SetLength(Data, PointsNmb);
 n:= PointsNmb;
 for i:=  0 to PointsNmb - 1 do
    Data[i] :=PIntegerArray(DataBuf)[i];
end;
end.
