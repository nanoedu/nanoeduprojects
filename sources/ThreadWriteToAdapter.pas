unit ThreadWriteToAdapter;

interface

uses
 Classes,windows,SysUtils,Globaltype,MLPC_APILib_TLB,comobj,activex,
    {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
      GlobalDCl;

type
  TWriteToAdapterThread  = class(TThread)
  private
   CurrentP:integer;
  protected
    procedure Execute; override;
    procedure drawprogress;
    procedure PrepareDataIn(i:integer);
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
 WriteToAdapterThread :TWriteToAdapterThread ;
 WriteToAdapterThreadActive:boolean;

implementation

uses GlobalVar,SioCSPM,mMain,CSPMVar, frAdapterService;

procedure TWriteToAdapterThread.PrepareDataIn(i:integer);
begin
 MoveMemory(DataInBuf,DataWriteToAdapterList[i],64*sizeof(Integer));
end;


constructor TWriteToAdapterThread.Create;
begin
  inherited Create(True);
   CoInitializeEx(nil,COINIT_MULTITHREADED);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;
end;

destructor TWriteToAdapterThread.Destroy;
begin
    CoUnInitialize;
    ThreadFlg:=mMemWriteDone;
    if assigned(AdapterService) then   PostMessage(AdapterService.Handle,wm_ThreadDoneMsg,ThreadFlg,0)
                                else   PostMessage(Main.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
    inherited destroy;
end;

 procedure   TWriteToAdapterThread.Drawprogress;
 begin
    AdapterService.ProgressBar.Position:=CurrentP+1;
 end;
procedure TWriteToAdapterThread.Execute;
var
    nwrite,ntoread:integer;
//NE II
    hr:HResult;
    flgEnd:boolean;
    NChElements,nRead:integer;
    i,n,ID:integer;
    data:integer;
    pstopval:Pinteger;
    errcnt:integer;
    ElementSize:integer;
    //
begin
  flgEnd:=false;
  i:=0;
   if assigned(AdapterService) then
   begin
    AdapterService.ProgressBar.Max:=DataWriteToAdapterList.Count;
    AdapterService.ProgressBar.Position:=0;
   end;

    {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start write data to adapter');
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
  while (not Terminated) {and (not flgEnd)} do
  begin
        sleep(300);
             nread:=1;
            hr:=arPCChannel[ch_Draw_done].ChannelRead.Read(DoneBuf,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error read done channel'+inttostr(nread)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('read done channel ='+inttostr(PIntegerArray(DoneBuf)[0])+' '+inttostr(nread));
            {$ENDIF}
         if PIntegerArray(DoneBuf)[0]=done then  break;// flgEnd:=true; //stop button press       stop scanning
       PrepareDataIn(i);
        nwrite:=1;
        hr:=arPCChannel[ ch_Data_IN].ChannelWrite.Write(DataInBuf,nwrite);     //WRITE TO READ NEXT PAGE
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error write page to adapter'+inttostr(nwrite)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('write page=' +inttostr(PintegerArray(DataInBuf)[0])+' to adapter ='+inttostr(nwrite));
             {$ENDIF}
          CurrentP:=i;
          if assigned(AdapterService) then      synchronize(DrawProgress);
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
   inc(i);
  end;//while
   ScanDone;
   FreeChannels;
 end;
  if (not Terminated) then  Self.Terminate;
 end;



end.
