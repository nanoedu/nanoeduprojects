unit SpectrTerraDrawThread;       //030213

interface

uses
  Classes,windows,SysUtils,
  {$IFDEF DEBUG}
   frDebug,
   {$ENDIF}
  Globaltype;

type
  TSpectrTerraDrawThread = class(TThread)
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
var  SpectrTerraThread:TSpectrTerraDrawThread;
     SpectrTerraThreadActive:boolean;
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
uses    CspmVar,GlobalVar, GlobalDCl,GlobalFunction, SioCSPM,frSpectroscopyTerra;

procedure TSpectrTerraDrawThread.Execute;
var flgLine,flgtestline:boolean;
    newpoints,pointsNmb:integer;
    CurrentPoint:integer;
    ds:integer;
    NewPCount,NPC:longint;
    i:dword;
     //NE LE
    hr:HResult;
    flgEnd:boolean;
    NChElements,CurChElements,nRead,nwrite:integer;
    ID:integer;
    data:integer;
    errcnt,errorcountstop,count:integer;
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
        sleep(300);
//      if FlgStopJava then
//         begin
   if spectrdatacount>=NChElements*ElementSize then FlgEnd:=true;

       if FlgStopJava then
         begin
           PintegerArray(StopBuf)[0]:=StopJava;
           repeat
           begin
            nwrite:=1;
            hr:=arPCChannel[ch_stop].ChannelWrite.Write(StopBuf,nwrite);     //read stop channel  if stopbutton pressed  pStopval^=done
            if Failed(hr) then
                {$IFDEF DEBUG}
                  Formlog.memolog.Lines.add('error write stop channel' +inttostr(nwrite)+ 'hr=' +inttostr(hr))
                 else
                    Formlog.memolog.Lines.add('write stop channel =' +inttostr(PIntegerArray(StopBuf)[0])+' '+inttostr(nwrite));
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
                  Formlog.memolog.Lines.add( 'error read stop channel' +inttostr(nread)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('read stop channel =' +inttostr(PIntegerArray(DoneBuf)[0])+' '+inttostr(nread));
            {$ENDIF}
            inc(count);
            sleep(100);
          until  (PIntegerArray(DoneBuf)[0]=done) or (count=20);
         if PIntegerArray(DoneBuf)[0]=done then   flgEnd:=true; //stop button press       stop scanning
         end;

 //
(*            hr:=arPCChannel[ch_Draw_done].ChannelRead.Read(DoneBuf,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
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

*)
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
      //     SetLength(TempAquiData,4{3}*n);
           SetLength(TempAquiData,3*n);
           TempAquiDataIT:=nil;
           SetLength(TempAquiDataIT,3*n);

           GetLineData;
           Synchronize(DrawCurrentLine);
   end;// NewPpoint>0
  end; //nread>=1
   end; {while ScanCount}
    PostMessage(SpectrWndTerra.Handle,wm_ThreadDoneMsg,mScanning,0);
    ScanDone;
    FreeChannels;
  end; //channel out
 end;  //create channels
 finally
   if (not Terminated) then  Self.Terminate;
 end;{finally}
end;

procedure TSpectrTerraDrawThread.GetLineData;
(*var i,kt,mt,j:integer;
   Uc,Uc2:apitype;
   a1,a2,a3,b1,b2,b3:apitype;
   valueZ:datatype;
begin
  mt:=dataoutcount;  kt:=spectrdatacount;
  i:=0;      j:=0;
  while i<bufsize*n do
  begin
     a1:=datatype(PIntegerArray(DataBuf)[mt+i]);
     b1:=datatype(PIntegerArray(DataBuf)[mt+i+1]);
     a2:=datatype(PIntegerArray(DataBuf)[mt+i+2]);
     b2:=datatype(PIntegerArray(DataBuf)[mt+i+3]);
     a3:=datatype(PIntegerArray(DataBuf)[mt+i+4]);
     b3:=datatype(PIntegerArray(DataBuf)[mt+i+5]);
     valueZ:=datatype(PIntegerArray(DataBuf)[mt+i+6]);
   {  median filtr}
     Uc:=a1;
     if Uc>a2 then begin a1:=a2; a2:=Uc; Uc:=a2; end  else  Uc:=a2;
     if Uc>a3 then begin a2:=a3; a3:=Uc; Uc:=a1; end;
     if Uc>a2 then begin a1:=a2; a2:=Uc;         end;
     Uc:=a2;
     Uc2:=b1;        //IT
     if Uc2>b2 then begin b1:=b2; b2:=Uc2; Uc2:=b2; end  else  Uc2:=b2;
     if Uc2>b3 then begin b2:=b3; b3:=Uc2; Uc2:=b1; end;
     if Uc2>b2 then begin b1:=b2; b2:=Uc2;         end;
     Uc2:=b2;
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,kt]:=UC;              //discrets
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,kt+1]:= valueZ;
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,kt+2*SpectrParams.NPoints]:=UC2;              //discrets
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,kt+2*SpectrParams.NPoints+1]:= valueZ;
     TempAquiData[j]:=UC;
     TempAquiData[j+1]:=valueZ;
     TempAquiDataIT[j]:=UC2;
     TempAquiDataIT[j+1]:=valueZ;
     inc(kt,2);
     inc(i,bufsize);
     inc(j,2);
  end;
  dataoutcount:=mt+i;
  spectrdatacount:=kt;
  *)
    var dir,i,J,kt,mt:integer;
   fUAM,fIT:datatype;
   valueZ:datatype;
begin
  i:=0;         J:=0;
  kt:=CurrentP;
  dataoutcount:=0;
//  mt:=0;
//  if FlgCurrentUserLevel<>Demo then dataoutcount:=0;
  while (i<ElementSize*n) do          //3
  begin
     fIT:=datatype(PIntegerArray(DataBuf)[i+dataoutcount]  shr 16);
     fUAM:=datatype(PIntegerArray(DataBuf)[i+1+dataoutcount]  shr 16);
     valueZ:=datatype(PIntegerArray(DataBuf)[i+2+dataoutcount] shr 16);
     dir:= datatype(PIntegerArray(DataBuf)[i+3+dataoutcount]);
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,kt]:=fUAM;       //discrets
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,kt+1]:= valueZ;
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,kt+2*SpectrParams.NPoints]:=fIT;              //discrets
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,kt+2*SpectrParams.NPoints+1]:= valueZ;

     TempAquiData[j]:=fUAM;
     TempAquiData[j+1]:=valueZ;
     TempAquiData[j+2]:=dir;
     TempAquiDataIT[j]:=fIT;
     TempAquiDataIT[j+1]:=valueZ;
     TempAquiDataIT[j+2]:=dir;
     inc(kt,2);       //????
     inc(i,4{3});
     inc(j,3);     //3
  end;
  inc(dataoutcount,ElementSize*n);      //3
  inc(spectrdatacount,ElementSize*n);
  CurrentP:=kt;
 end;

procedure TSpectrTerraDrawThread.DrawCurrentLine;
var i,dir,i0,k:integer;
value,z:single;
umstart:single;
begin
  umstart:=round( ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,1]*SpectrWNdTerra.ZStepMin);;
//  umstop:=round(UData[2*nz-1]*SpectrWNd.ZStepMin);
     i:=0;
 (*   case Currentgraph of
    0:begin                 //red          landing   UAM
       SpectrWndTerra.ArChart[SpectrParams.CurrentLine].SetActiveSeries(SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Series);
       for k:=0 to (N-1) do
       begin
          Z:=TempAquiData[i+1]*SpectrWndTerra.ZStepMin;
          value:=TempAquiData[i]*SpectrWndTerra.StepValueMin;
          SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Series.AddXY(Z,Value);
          inc(i,2);
       end;
      SpectrWndTerra.ArChart[SpectrParams.CurrentLine].SetActiveSeries(SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Next.Series);
     i:=0;
     for k:=0 to (N-1) do  //blue   landing     IT
       begin
          Z:=TempAquiDataIT[i+1]*SpectrWndTerra.ZStepMin;
          value:=TempAquiDataIT[i]*SpectrWndTerra.StepValueMinIT;
          SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Next.Series.AddXY(Z,Value);
          inc(i,2);
       end;
       i0:=i;
      end;
 else begin      //blue        rising
     (*  i:=i0;
       SpectrWnd.ArChart[SpectrParams.CurrentLine].SetActiveSeries(SpectrWnd.ArChart[SpectrParams.CurrentLine].HeadSeriesList.next.Series);
       for k:=0 to (N-1) do
       begin
          Z:=TempAquiData[i+1]*SpectrWnd.ZStepMin;
          value:=TempAquiData[i]*SpectrWnd.StepValueMin;
          inc(i,2);
        if Z>=umstart then
         begin
           SpectrWnd.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Next.Series.AddXY(Z,Value);//,'',seriesColor[j]);
         end
         else if not (flgCurrentUserLevel=Demo) then  SpectrWnd.lblwarning.Visible:=true;
        end;
        i:=i0;
       SpectrWnd.ArChart[SpectrParams.CurrentLine].SetActiveSeries(SpectrWnd.ArChart[SpectrParams.CurrentLine].HeadSeriesList.next.Series);
        for k:=0 to (N-1) do
       begin
          Z:=TempAquiData[i+1]*SpectrWnd.ZStepMin;
          value:=TempAquiData[i]*SpectrWnd.StepValueMin;
          inc(i,2);
        if Z>=umstart then
         begin
           SpectrWnd.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Next.Series.AddXY(Z,Value);//,'',seriesColor[j]);
         end
         else if not (flgCurrentUserLevel=Demo) then  SpectrWnd.lblwarning.Visible:=true;
        end;
       *)
(*      end;
    end; //case
*)
  while i<3*n do
  begin
//     value:=TempAquiData[i]*SpectrWndTerra.StepValueMin;
//     Z:=TempAquiData[i+1]*SpectrWndTerra.ZStepMin;
     dir:=TempAquiData[i+2];
   case dir of
1: begin
     value:=TempAquiData[i]*SpectrWndTerra.StepValueMin;
     Z:=TempAquiData[i+1]*SpectrWndTerra.ZStepMin;
     SpectrWndTerra.ArChart[SpectrParams.CurrentLine].SetActiveSeries(SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Series);
     SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Series.AddXY(Z,Value);

     SpectrWndTerra.ArChart[SpectrParams.CurrentLine].SetActiveSeries(SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Next.Series);
     value:=TempAquiDataIT[i]*SpectrWndTerra.StepValueMinIT;;
     Z:=TempAquiDataIT[i+1]*SpectrWndTerra.ZStepMin;
     SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Next.Series.AddXY(Z,Value);

     inc(SpectrParams.NewPoints);

    end;
{-1: begin
     value:=TempAquiData[i]*SpectrWndTerra.StepValueMin;
     Z:=TempAquiData[i+1]*SpectrWndTerra.ZStepMin;
     SpectrWndTerra.ArChart[SpectrParams.CurrentLine].SetActiveSeries(SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Next.Series);
     SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Series.AddXY(Z,Value);

     SpectrWndTerra.ArChart[SpectrParams.CurrentLine].SetActiveSeries(SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Next.Series);
     value:=TempAquiDataIT[i]*SpectrWndTerra.StepValueMinIT;;
     Z:=TempAquiDataIT[i+1]*SpectrWndTerra.ZStepMin;
     SpectrWndTerra.ArChart[SpectrParams.CurrentLine].HeadSeriesList.Next.Series.AddXY(Z,Value);

    end;
    }
      end; //case
      inc(i,3);
  end;

end;

constructor TSpectrTerraDrawThread.Create;
begin
  inherited Create(True);
    FreeOnTerminate:=true;
    Priority := TThreadPriority(tpNormal);
    Suspended := false;// Resume;
 end;

destructor TSpectrTerraDrawThread.Destroy;
begin
   ThreadFlg:=mDrawing;
   PostMessage(SpectrWNDTerra.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;
end.
