unit SpectrSTMDrawThread;

interface

uses
   Classes,windows,SysUtils,Globaltype,MLPC_APILib_TLB,
   {$IFDEF DEBUG}
   frDebug,
   {$ENDIF}
   Activex;

type
  TSpectrSTMDrawThread = class(TThread)
  private
    { Private declarations }
     FlgLine:Boolean;
     bufsize:integer;
     CurrentP,newline:integer;
     CurrentCurve:integer;
     PrevZ:single;
     n,dataoutcount,spectrdatacount,CurrentGraph:Integer;
     ElementSize:Integer;
     nElements,CurChElements:Integer;
     TempAquiData:TLine;
     TempAquiDataIT:TLine;
    procedure GetLineData;
    procedure DrawCurrentLine;
  protected
    procedure Execute; override;
 public
      curveprev:integer;
      constructor Create;
      destructor Destroy; override;
  end;
var  SpectrSTMThread:TSpectrSTMDrawThread;
     SpectrSTMThreadActive:boolean;


implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure SpectrDrawThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ SpectrDrawThread }

uses    CspmVar,GlobalVar, GlobalDCl, GlobalFunction, SioCSPM,frSpectroscopyV;

procedure TSpectrSTMDrawThread.Execute;
var flgLine,flgtestline:boolean;
    newpoints,pointsNmb:integer;
    CurrentPoint:integer;
    ds:integer;
    NewPCount,NPC:longint;
    i:dword;
     //NE II
    hr:HResult;
    flgEnd:boolean;
    NChElements,CurChElements,nRead,ntoRead,nhasread:integer;
    ID:integer;
    data:integer;
    errcnt:integer;
begin
GetTimeNow(StartHour, startMin, StartSec, startMsec);
  { Place thread code here }
   flgLine:=false;
   newline:=0;
   flgtestline:=true;
   bufsize:=7;       //4
   PointsNmb:=2*SpectrParams.NPoints;  //7
   CurrentPoint:=0;
   CurrentP:=0;
   CurrentCurve:=0;
   dataoutcount:=0;   spectrdatacount:=0;
   CurrentGraph:=0;
   SpectrWndV.ArChart[SpectrParams.CurrentLine].SetActiveSeries(SpectrWndV.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Series);
   ds:=1;
try
   {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start Spectr I-V drawing');
    {$ENDIF}
if CreateChannels(AlgParams.NChannels) then
 begin
  arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
  if ID=ch_Data_OUT then
  begin
    flgEnd:=false;
//    elsize:=2;       // {frq,Ampl}
    hr:=arPCChannel[ch_Data_out].Main.get_Geometry(NChElements,ElementSize);
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read geometry'+inttostr(nread)+'hr='+inttostr(hr));
         Formlog.memolog.Lines.add('Channel data; Elements='+inttostr(NChElements)+'size='+inttostr(ElementSize));
      {$ENDIF}
    CurChElements:=0;   // current of elements
     nread:=0;
  while (not Terminated) and (not flgEnd) do
   begin
       nread:=1;
//      if FlgStopJava then
//         begin


            hr:=arPCChannel[ch_Draw_done].ChannelRead.Read(DoneBuf,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error read stop channel'+inttostr(nread)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('read stop channel ='+inttostr(PIntegerArray(DoneBuf)[0])+' '+inttostr(nread));
            {$ENDIF}

           if PIntegerArray(DoneBuf)[0]=done then
            begin
              flgEnd:=true; //stop button press       stop scanning
              if flgCurrentUserLeveL=Demo then  break;
            end;
//         end;
       sleep(300);
      hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(ntoread);     //get new data count
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(ntoread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('spectrdraw data to read '+inttostr(ntoread));
       {$ENDIF}
   nhasread:=0;
 if ntoread>=SpectrParams.NPoints then
 while  (nhasread<ntoread) do
  begin
    nread:=SpectrParams.NPoints;
    hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,nread);    /// read data //nread is not number of elements ????

       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read channel data '+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('spectrdraw data has read '+inttostr(nread));
       {$ENDIF}
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
   if   nread>0 then
    begin
           nhasread:=nhasread+nread;
           n:=nread;
           TempAquiData:=nil;
           SetLength(TempAquiData,2*n);
           GetLineData;
           Synchronize(DrawCurrentLine);    //draw current series
           CurrentP:=CurrentP+2*n;
           SpectrWndV.ArChart[SpectrParams.CurrentLine].SetActiveSeriesNext;
           if (CurrentP mod SpectrParams.NPoints)=0  then    inc(CurrentCurve);
           if CurrentP >= SpectrParams.NPoints*ElementSize*SpectrParams.NCurves then flgEnd:=True;
   end;
 end; //nread>=1
  end; {while ScanCount}
    ScanDone;
    FreeChannels;
    PostMessage(SpectrWndV.Handle,wm_ThreadDoneMsg,mScanning,0);
  end; //channel out
 end;  //create channels
 finally
   if (not Terminated) then  Self.Terminate;
 end;{finally}
end;

procedure TSpectrSTMDrawThread.GetLineData;
var
   i,shift,j,kt,mt, CurrentCurve0, CurrentCurvet:integer;
   valU:datatype;
   valI:datatype;
begin
  shift:=0;//2*CurrentCurve*SpectrParams.NPoints;//0;
  i:=0;
  j:=0;
  kt:=0;//CurrentP;
//  CurrentCurve0:=CurrentCurve;
  while i<2*n do
  begin
     valU:=datatype(PIntegerArray(DataBuf)[shift+i]  shr 16);
     valI:=-datatype(PIntegerArray(DataBuf)[shift+i+1] shr 16);   //160113 indication
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine*SpectrParams.NCurves+CurrentCurve,kt]:=valU;       //discrets
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine*SpectrParams.NCurves+CurrentCurve,kt+1]:=valI;
     TempAquiData[j]:=valU;
     TempAquiData[j+1]:=valI;
     inc(kt,2);
     inc(j,2);
     inc(i,2);
  end;
end;

procedure TSpectrSTMDrawThread.DrawCurrentLine;
var
k,i,l,j,j0:integer;
valU,valI:single;
begin
  j0:=4;     //must be even value
  i:=j0;// try to kill jump in spectrosopy 23/12/15 change =  0->4;
 for k:=j0 to ((n-1)) do
  begin
     valU:=TempAquiData[i]*SpectrWndV.UStepMin;
     valI:=TempAquiData[i+1]*SpectrWndV.IStepMin;
     SpectrWndV.ArChart[SpectrParams.CurrentLine].ActiveSeries.AddXY(valU,valI);
     inc(i,2);
  end;

 end;

constructor TSpectrSTMDrawThread.Create;
begin
  inherited Create(True);
    FreeOnTerminate:=true;
    Priority := TThreadPriority(tpNormal);
    Suspended := false;
    // Resume;
 end;

destructor TSpectrSTMDrawThread.Destroy;
begin
   ThreadFlg:=mDrawing;
   PostMessage(SpectrWNDV.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;
end.
