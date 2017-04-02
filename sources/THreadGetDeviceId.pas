unit ThreadGetDeviceId;

interface

uses
 Classes,windows,Forms,SysUtils,Globaltype,MLPC_APILib_TLB,comobj,activex,
    {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
      GlobalDCl;

type
  TThreadGetDevId = class(TThread)
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
 GetDevIdThread:TThreadGetDevId;
 GetDevIdThreadActive:boolean;
implementation

uses GlobalVar,SioCSPM,mMain,CSPMVar;

constructor TThreadGetDevId.Create;
begin
  inherited Create(True);
   CoInitializeEx(nil,COINIT_MULTITHREADED);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;// Resume;
end;

destructor TThreadGetDevId.Destroy;
begin
    CoUnInitialize;
    ThreadFlg:=mGetDeviceId;
    PostMessage(Main.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
    inherited destroy;
end;


procedure TThreadGetDevId.Execute;
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
         Formlog.memolog.Lines.add('Start Get Device Id');
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
                      else Formlog.memolog.Lines.add('data to read '+inttostr(ntoread));
       {$ENDIF}

     nread:=ntoread;

     if nread>0 then
     begin
       hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,nread);    /// read data //nread is not number of elements ????
      {$IFDEF DEBUG}
       if Failed(hr) then Formlog.memolog.Lines.add('error read channel data '+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('ID  has read '+inttostr(nread));
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

procedure TThreadGetDevId.GetScanData;
var i,val:integer;
    ch:array[0..136] of char;
begin

(***
	  Определение версии прошивки ПЛИС АГ и типа АГ.
	  getAdaptorVerId - {id[4],ver_hi[8],ver_lo[4]},
	  GetAdaptorType  - тип АГ (ADPT_NE2, ADPT_NEA_REN, ...).

	public static native int getAdaptorVerId( );
	public static int GetAdaptorType( )
	{
		return ((getAdaptorVerId() >> 12) & 0x0F);
	}
    ***)
   val:=PIntegerArray(DataBuf)[0];
  // AdapterId:=val;//
  AdapterId:=(val shr 12) and $0000000F;
  AdapterVer_hi  := (val shr 4) and $000000FF;
  AdapterVer_lo  := val and $0000000F;
   val:=PIntegerArray(DataBuf)[1];
   FlgAdapterLink:=false;
  if not boolean(val and integer($80000000)) then          // edited 170227
            FlgAdapterLink:=boolean(val and $00000001);
   MoveMemory(Pinteger(PControllerParams),Pinteger(integer(databuf)+8),sizeof(RControllerParamsRecord));
end;

end.
