unit ThreadGetControllerParams;

interface

uses
  Classes,windows,Forms,SysUtils,Globaltype,MLPC_APILib_TLB,comobj,activex,
    {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
      GlobalDCl;
type
  TThreadGetControllerParams = class(TThread)
  private
     PointsNmb:integer;
  protected
    procedure Execute; override;
    procedure GetScanData;
  public
    constructor Create;
    destructor  Destroy; override;
  end;
 var
 GetControllerParamsThread:TThreadGetControllerParams;
 GetControllerParamsActive:boolean;
implementation

uses GlobalVar,SioCSPM,mMain,CSPMVar;


{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TThreadGetControllerParams.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TThreadGetControllerParams }

constructor TThreadGetControllerParams.Create;
begin
  inherited Create(True);
   CoInitializeEx(nil,COINIT_MULTITHREADED);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;// Resume;
end;

destructor TThreadGetControllerParams.Destroy;
begin
    CoUnInitialize;
    ThreadFlg:=mGetControllerParams;
    PostMessage(Main.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
    inherited destroy;
end;


procedure TThreadGetControllerParams.Execute;
var
    ntoread:integer;
//NE II
    hr:HResult;
    flgEnd:boolean;
    nRead:integer;
    n,ID:integer;
    NChElements,ElementSize:integer;
//
begin
  flgEnd:=false;
    {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start Get Controller Params');
    {$ENDIF}
if CreateChannels(AlgParams.NChannels) then
 begin
   arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
  if ID=ch_Data_OUT then
  begin
    hr:=arPCChannel[ch_Data_out].Main.get_Geometry(PointsNmb,ElementSize);
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read geometry'+inttostr(nread)+'hr='+inttostr(hr));
         Formlog.memolog.Lines.add('Channel data; Elements='+inttostr(NChElements)+'size='+inttostr(ElementSize));
      {$ENDIF}
  while (not Terminated) and (not flgEnd) do
  begin
      sleep(100);
      nread:=1;
      hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(ntoread);     //get new data count
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(ntoread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add(' data to read '+inttostr(ntoread));
       {$ENDIF}

     nread:=ntoread;

     if nread>0 then
     begin
       hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,nread);    /// read data //nread is not number of elements ????
      {$IFDEF DEBUG}
       if Failed(hr) then Formlog.memolog.Lines.add('error read channel data '+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('Params  has read '+inttostr(nread));
      {$ENDIF}
        flgEnd:=true;
        GetScanData;
     end;
    end;
  end;
//   Events.SetEvent;
   Application.ProcessMessages;
   ScanDone;
   FreeChannels;
   end;
  if (not Terminated) then  Self.Terminate;
 end;

procedure TThreadGetControllerParams.GetScanData;
begin
  MoveMemory(Pinteger(PControllerParams),Pinteger(integer(databuf)),sizeof(RControllerParamsRecord));
end;
end.
