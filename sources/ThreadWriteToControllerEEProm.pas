unit ThreadWriteToControllerEEProm;

interface

uses
 Classes,windows,SysUtils,Globaltype,extctrls,MLPC_APILib_TLB,comobj,activex,
    {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
      GlobalDCl;

type
  TThreadSetControllerParams = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure PrepareDataIn;
  public
    constructor Create;
    destructor Destroy; override;

  end;
var SetControllerParamsThread: TThreadSetControllerParams;
    SetControllerParamsThreadActive:boolean;
implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure SetControllerParams.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ SetControllerParams }
uses GlobalVar,SioCSPM,mMain,CSPMVar,frExperimParams;

constructor TThreadSetControllerParams.Create;
begin
  inherited Create(True);
   CoInitializeEx(nil,COINIT_MULTITHREADED);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;
   PrepareDataIn;
end;

destructor TThreadSetControllerParams.Destroy;
begin
    CoUnInitialize;
    ThreadFlg:= mEEPromWriteDone;
  if assigned(ApproachOpt) then   PostMessage(ApproachOpt.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
    inherited destroy;
end;
procedure  TThreadSetControllerParams.PrepareDataIn;
var i:integer;
begin
 for i:=0 to 15  do
 PAnsiCharArray(dataInbuf)[i]:=(PControllerParams^.SN_NTSPB[i]);
//  MoveMemory(DataInBuf,PInteger(integer(PControllerParams)+3),16);
end;

procedure TThreadSetControllerParams.Execute;
var
    nwrite,ntoread:integer;
//NE II
    hr:HResult;
    NChElements,nRead:integer;
    n,ID:integer;
    data:integer;
    pstopval:Pinteger;
    errcnt:integer;
    ElementSize:integer;
 //
begin
    {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start write number of the controller');
    {$ENDIF}
if CreateChannels(AlgParams.NChannels) then
 begin
   arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
  if ID=ch_Data_OUT then
  begin
    hr:=arPCChannel[ch_Data_out].Main.get_Geometry(NChElements,ElementSize);
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read geometry'+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('Channel data; Elements='+inttostr(NChElements)+'size='+inttostr(ElementSize));
      {$ENDIF}

  end;
  while (not Terminated) do
  begin
        nwrite:=1;
        hr:=arPCChannel[ ch_Data_IN].ChannelWrite.Write(DataInBuf,nwrite);     //WRITE TO READ NEXT PAGE
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error write page to adapter'+inttostr(nwrite)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('write page=' +inttostr(PintegerArray(DataInBuf)[0])+' to adapter ='+inttostr(nwrite));
             {$ENDIF}
   repeat        //wait for  writen  page i
       sleep(100);
        hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(ntoread);     //get new data count
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(ntoread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('scandraw data to read '+inttostr(ntoread));
       {$ENDIF}
      if ntoread >0 then
       begin
        hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,ntoread);
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read channel data '+inttostr(nread)+'hr='+inttostr(hr))
                     else Formlog.memolog.Lines.add('data has read from adapter'+inttostr(nread));
       {$ENDIF}
       end;
   until ntoread>0;
   Terminate;
  end;//while
   ScanDone;
   FreeChannels;
 end;
  if (not Terminated) then  Self.Terminate;
 end;

end.
