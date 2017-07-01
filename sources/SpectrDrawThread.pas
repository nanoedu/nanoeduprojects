unit SpectrDrawThread;

interface

uses
   Classes,windows,SysUtils,Globaltype,MLPC_APILib_TLB,
   {$IFDEF DEBUG}
   frDebug,
   {$ENDIF}
   Activex;

type
  TSpectrDrawThread = class(TThread)
  private
    { Private declarations }
     FlgLine:Boolean;
     bufsize:integer;
     CurrentP,newline:integer;
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
      constructor Create;
      destructor Destroy; override;
  end;
var  SpectrThread:TSpectrDrawThread;
     SpectrThreadActive:boolean;
implementation

uses    CspmVar,GlobalVar, GlobalDCl,GlobalFunction, SioCSPM,frSpectroscopy;

procedure TSpectrDrawThread.Execute;
var flgLine,flgtestline:boolean;
    newpoints,pointsNmb:integer;
    CurrentPoint:integer;
    ds:integer;
    NewPCount,NPC:longint;
    i:dword;
    hr:HResult;
    flgEnd:boolean;
    NChElements,CurChElements,nRead:integer;
    ID:integer;
    data:integer;
    errcnt:integer;
begin
  GetTimeNow(StartHour, startMin, StartSec, startMsec);
   flgLine:=false;
   newline:=0;
   flgtestline:=true;
   bufsize:=7;       //4
   PointsNmb:=2*SpectrParams.NPoints;  //7
   CurrentPoint:=0;
   CurrentP:=0;
   dataoutcount:=0;   spectrdatacount:=0;
   CurrentGraph:=0;
   SpectrParams.NewPoints:=0;
   PrevZ:=SpectrParams.StartP;
   ds:=1;
try
   {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start Spectr drawing');
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
    CurChElements:=0;   // current of elements
    nread:=0;

  while (not Terminated) and (not flgEnd)  do
   begin
       nread:=AlgParams.NGetCountEvent;//1;
        sleep(500);
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

       hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(nread);     //get new data count
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('spectrdraw data to read '+inttostr(nread));
       {$ENDIF}
    if nread >= 1 then
    begin
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
      NewPCount:=nread;

     if  (NewPCount>0) then
     begin
           n:=NewPCount;
           NewPCount:=0;
           TempAquiData:=nil;
           SetLength(TempAquiData,3*n);
           GetLineData;
           Synchronize(DrawCurrentLine);
          if spectrdatacount>=NChElements*ElementSize then FlgEnd:=true;   //
         //  FlgEnd:=true;
     end;// NewPpoint>0
    end; //nread>=1
   end; {while ScanCount}
    ScanDone;
    FreeChannels;
    PostMessage(SpectrWnd.Handle,wm_ThreadDoneMsg,mScanning,0);
  end; //channel out
 end;  //create channels
 finally
   if (not Terminated) then  Self.Terminate;
 end;{finally}
end;

procedure TSpectrDrawThread.GetLineData;
var dir,i,kt,mt:integer;
   valueSignal:datatype;
   valueZ:datatype;
begin
  i:=0;
  kt:=CurrentP;
  dataoutcount:=0;
  while (i<ElementSize*n) do          //3
  begin
     valueSignal:=datatype(PIntegerArray(DataBuf)[i+dataoutcount]  shr 16);
     valueZ:=datatype(PIntegerArray(DataBuf)[i+1+dataoutcount] shr 16);
     dir:= datatype(PIntegerArray(DataBuf)[i+2+dataoutcount]);
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,kt]  :=valueSignal;       //discrets
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,kt+1]:= valueZ;
     TempAquiData[i]:=valueSignal;
     TempAquiData[i+1]:=valueZ;
     TempAquiData[i+2]:=dir;
     inc(kt,2);
     inc(i,ElementSize);         //3
  end;
  inc(dataoutcount,ElementSize*n);      //3
  inc(spectrdatacount,ElementSize*n);
  CurrentP:=kt;
 end;


procedure TSpectrDrawThread.DrawCurrentLine;
var dir,i,k:integer;
valueSignal,z:single;
umstart:single;
begin
  umstart:=round( ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,1]*SpectrWNd.ZStepMin);;
  i:=0;
 while i<3*n do
  begin
     valueSignal:=TempAquiData[i]*SpectrWnd.StepValueMin;
     Z:=TempAquiData[i+1]*SpectrWnd.ZStepMin;
     dir:=TempAquiData[i+2];
   case dir of
1: begin
     SpectrWnd.ArChart[SpectrParams.CurrentLine].SetActiveSeries(SpectrWnd.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Series);
     SpectrWnd.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Series.AddXY(Z,valueSignal);
     inc(SpectrParams.NewPoints);
    end;
-1: begin
     SpectrWnd.ArChart[SpectrParams.CurrentLine].SetActiveSeries(SpectrWnd.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Next.Series);
     SpectrWnd.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Next.Series.AddXY(Z,valueSignal);
    end;
      end; //case
      inc(i,3);
  end;
end;

constructor TSpectrDrawThread.Create;
begin
  inherited Create(True);
    FreeOnTerminate:=true;
    Priority := TThreadPriority(tpNormal);
    Suspended := false;// Resume;
 end;

destructor TSpectrDrawThread.Destroy;
begin
   ThreadFlg:=mDrawing;
   PostMessage(SpectrWND.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;
end.
