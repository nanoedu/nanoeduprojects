unit TestTIDrawThread;

interface

uses
  Classes, Messages,Windows,SysUtils,Activex,
   {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
    GlobalType,MLPC_APILib_TLB;

type
  TThreadTestTI = class(TThread)
  private
    { Private declarations }
     function GetScanData:datatype;  protected
    procedure Execute; override;
  public
       constructor Create;
     destructor Destroy; override;
  end;
var
  ThreadTestTIDraw:TThreadTestTI;
  ThreadTestTIDrawActive : boolean;
implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TThreadTestTI.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TThreadTestTI }
uses   GlobalVar,CSPMVar,SioCSPM;


constructor TThreadTestTI.Create;
begin
  inherited Create(True);
   CoInitializeEx(nil,COINIT_MULTITHREADED);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;// Resume;
end;

destructor  TThreadTestTI.Destroy;
begin
    CoUnInitialize;
   ThreadTestTIDrawActive:=false;
   inherited destroy;
   ThreadTestTIDraw:=nil;
end;

function TThreadTestTI.GetScanData:datatype;
begin
  result:=datatype(PIntegerArray(DataBuf)[0]);
end;

procedure TThreadTestTI.Execute;
 var   flgEnd:boolean;
       nRead:integer;
       pStopVal:pInteger;
       hr:Hresult;
 begin
 try
   new(pStopVal);
 if CreateChannels(AlgParams.nchannels) then
  begin
       //set start time

     while (not Terminated) do
       begin
          nread:=1;
            hr:=(arPCChannel[ch_Draw_done].Main as IMLPCChannelRead).Read(pStopval,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error read stop channel'+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('read stop channel ='+inttostr(pStopval^));
            {$ENDIF}
       if pStopval^=done then   flgEnd:=true;
      {$IFDEF DEBUG}
              Formlog.memolog.Lines.add('wait test TI');
       {$ENDIF}
       sleep(500);
        hr:=(arPCChannel[ch_Data_out].Main as IMLPCChannelRead).Get_Count(nread);     //get new data count
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('scandraw data to read '+inttostr(nread));
      {$ENDIF}
           hr:=(arPCChannel[ch_Data_out].Main as IMLPCChannelRead).Read(DataBuf,nread);    /// read data //nread is not number of elements ????
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read channel data '+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('scandraw data has read '+inttostr(nread));
       {$ENDIF}
      if nread=1 then flgEnd:=true;
      if flgEnd then
                begin
                 ApproachParams.IntegratorDelay:=GetScanData;
                 ScanDone;
                 FreeChannels;
                 break;
                end;
       end;  //not terminated
  end;// chanels create
  finally
     dispose(pStopVal);
 end;
    {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('End Test TI');
    {$ENDIF}  { Place thread code here }
end;

end.
