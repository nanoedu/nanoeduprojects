unit ResDrawThread;

interface

uses
  Classes,windows,SysUtils,Globaltype,MLPC_APILib_TLB,comobj,activex;

type
  TResDrawThread = class(TThread)
  private
    { Private declarations }
     FlgLine:Boolean;
     ElementSize:integer;
     nElements,dataoutcount:Integer;
     TempAquiData:TlwLine;
     pointscnt:integer;
     procedure   GetLineData;
     procedure   DrawCurrentLine;
  protected
     procedure   Execute; override;
  public
     constructor Create;
     destructor  Destroy; override;
  end;

var  ResThread:TResDrawThread;
     ResThreadActive:boolean;

implementation



Uses  dialogs,CspmVar,GlobalVar,
     {$IFDEF DEBUG}
       frDebug,
      {$ENDIF}
      GlobalDCl, SioCSPM,NL3LFBLib_TLB,MLPC_API2Lib_TLB,frResonance;




procedure TResDrawThread.Execute;
 var flgEnd:boolean;
    NChElements,CurChElements,nRead:integer;
    n,ID:integer;
    NewPCount:longint;
    nwrite,data,i:integer;
//    pval:Pinteger;
    hr:Hresult;
begin
  { Place thread code here }
  //create channels interface
  pointscnt:=0;
 CoInitializeEx(nil,COINIT_MULTITHREADED);

     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add(AutoResonance.siLangLinked1.GetTextOrDefault('IDS_7' (* 'Start resonance drawing' *) ));
    {$ENDIF}

 if CreateChannels(AlgParams.NChannels) then
 begin
 //  arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
  if arPCChannel[ch_Data_out].ID=ch_Data_OUT then
  begin
    flgEnd:=false;
    hr:=arPCChannel[ch_Data_out].Main.get_Geometry(NChElements,ElementSize);
    {$IFDEF DEBUG}
      if Failed(hr) then
                   Formlog.memolog.Lines.add(AutoResonance.siLangLinked1.GetTextOrDefault('IDS_8' (* 'error read geometry' *) )+inttostr(nread))
                  else
        Formlog.memolog.Lines.add(AutoResonance.siLangLinked1.GetTextOrDefault('IDS_28' (* 'Channel data; Elements=' *) )+inttostr(NChElements)+AutoResonance.siLangLinked1.GetTextOrDefault('IDS_33' (* 'size=' *) )+inttostr(ElementSize));
    {$ENDIF}
    if (NChElements=0)  or (ElementSize=0) then  showmessage(AutoResonance.siLangLinked1.GetTextOrDefault('IDS_34' (* 'error channel params' *) ));

    CurChElements:=0;   // current of elements
    dataoutcount:=0; nread:=0;
    try
     while (not Terminated) and (CurChElements<NChElements) do
     begin
  //   JavaControl.IsRunning(flgJavaRunning);
   //  sleep(400);
  // sleep(40);   // 13/03/13 - уменьшена задержка
      sleep(GETCOUNT_DELAY );
      if flgStopJava {or (not flgJavaRunning)} then   flgEnd:=true;
   //   nread:=(NChElements-CurChElements);
      hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(nread);
      {$IFDEF DEBUG}
        if Failed(hr) then  Formlog.memolog.Lines.add(AutoResonance.siLangLinked1.GetTextOrDefault('IDS_35' (* 'error get count ' *) )+inttostr(nread));
       {$ENDIF};
      hr:=arPCChannel[ch_Data_out].ChannelRead.Read((DataBuf),nread);    /// nread is not number of elements ????
       if Failed(hr) then
       {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(AutoResonance.siLangLinked1.GetTextOrDefault('IDS_36' (* 'error read channel ' *) )+inttostr(nread))
              else
               Formlog.memolog.Lines.add(AutoResonance.siLangLinked1.GetTextOrDefault('IDS_38' (* 'res draw ' *) )+inttostr(nread));
       {$ENDIF};
      if (nread+CurChElements)>NChElements then  nread:=(NChElements-CurChElements);
      if nread<0 then nread:=0;
      NewPCount:=nread;
      while  (NewPCount>0) do
      begin
        if ((CurChElements+(nread))=NChElements) then
          begin
            FlgEnd:=True;
          end;
           nElements:=nread;
           NewPCount:=0;
           TempAquiData:=nil;
           SetLength(TempAquiData,nread*ElementSize);
           GetLineData;
     //  if (AutoResonance.flgMode=Manual) or
       //    ((AutoResonance.flgMode=Auto) and (AutoResonance.flgRegime=Rough))
           Synchronize(DrawCurrentLine);
           CurChElements:=CurChElements+nElements;//have read;
      end;// NewPpoint>0
      if flgEnd then
        begin
         ScanDone;
         FreeChannels;
         PostMessage(AutoResonance.Handle,wm_ThreadDoneMsg,mScanning,0);
         break;
        end;
      end; {while ScanCount}
   // set resonance freq
    finally
     TempAquiData:=nil;
    end;{finally}
 end; //dataout
  end; //channel create
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add(AutoResonance.siLangLinked1.GetTextOrDefault('IDS_39' (* 'end resonance drawing' *) ));
    {$ENDIF}
     CoUnInitialize;
    if (not Terminated) then  Self.Terminate;
end;

procedure TResDrawThread.GetLineData;
var i,k,mt,j:integer;
   Ampl:datatype;
   frq:longword;
   fData:int64;
begin
  mt:=dataoutcount;
  i:=0;
  k:=0;
  j:=0;
  while i<nElements do
  begin
     fdata:=int64(PIntegerArray(DataBuf)[k])*million;
     fData:=fdata shr 32;
     frq:=longword(FData);
    if (PIntegerArray(DataBuf)[k+1] shr 16) > 32767 then   Ampl:=32767
     else
     begin
       if (PIntegerArray(DataBuf)[k+1] shr 16) < -32768 then AMpl:=-32768
       else    Ampl:=datatype(PIntegerArray(DataBuf)[k+1] shr 16);    //convert to single V
      end;
//    ScanData.AquiTopo.Data[mt+k,0]:=frq;
//    ScanData.AquiTopo.Data[mt+k+1,0]:=Ampl;
     TempAquiData[j]:=frq;
     TempAquiData[j+1]:=Ampl;
     inc(i,1);
     inc(j,2);
     inc(k,2);
   end;
  dataoutcount:=k;
end;

procedure TResDrawThread.DrawCurrentLine;
var i,k:integer;
    ampl,frq:single;
begin
       i:=0;
       for k:=0 to (nElements-1) do
       begin                               //            PVal*1000000 shr 32;    //freq  Hrz  -> word
           frq:=TempAquiData[i];//*ResonanceParams.Step;     //HRz
           Ampl:=TempAquiData[i+1]*ResonanceParams.AmplStep;
           AutoResonance.ResonanceCurve[pointscnt]:=Ampl;
           AutoResonance.ResonanceFreqVals[pointscnt]:=frq;
           inc(pointscnt);
        //   if (AutoResonance.flgMode=Manual) or                                             // changed 010316
        //   ((AutoResonance.flgMode=Auto) and (AutoResonance.flgRegime=Rough)) then
           AutoResonance.ChartPanel.Series1.AddXY(frq,Ampl);     // Рисовать кривую
           inc(i,2);
       end;
end;

constructor TResDrawThread.Create;
begin
  inherited Create(True);
    FreeOnTerminate:=true;
    Priority := TThreadPriority(tpNormal);
    Suspended := false;// Resume;
end;

destructor TResDrawThread.Destroy;
begin
   ThreadFlg:=mDrawing;
   PostMessage(Autoresonance.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;
end.
