unit TestStepDrawThread;

interface

uses
  Classes,windows,SysUtils,GlobalType, MLPC_APILib_TLB,
        {$IFDEF DEBUG}
              frDebug,
       {$ENDIF}
       activex;


type
  TStepTestDraw = class(TThread)
  private
    dout,lsz,CurrentP:integer;
    Z:datatype;
    NSteps:integer;
    logstr:string;
    ElementSize:integer;

    { Private declarations }
  protected
    procedure Execute; override;
    procedure DrawCurrentLine;
    procedure GetData;
    procedure log;
  public
    constructor Create;
    destructor Destroy; override;
  end;
var  StepTestDrawThread:TStepTestDraw;
     StepTestDrawThreadActive : boolean;

implementation

uses CSPMVar,SIOCSPM,Graphics,frStepTest;

constructor TStepTestDraw.Create;
begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpHigher{tpNormal});
   Suspended := false;
end;

destructor TStepTestDraw.Destroy;
begin

  ThreadFlg:=mDrawing;
   PostMessage(StepsTest.Handle,WM_StepTestThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;


procedure TStepTestDraw.Execute;
var
 NewPCount,NPC:longint;
 i:dword;
 PointsNmb:integer;
  hr:Hresult;
  NChElements,CurChElements,n,nwrite,nread:integer;
  ID,status:integer;
  errcnt,count:integer;
  ntoread:integer;
  flgEnd:boolean;

 begin
   PointsNmb:=1001*4;
   CurrentP:=0;
   ScanParams.CurrentScanCount:=0;
   dout:=0;
CoInitializeEx(nil,COINIT_MULTITHREADED);
       logstr:='Start drawing';
        Synchronize(log);
    errcnt:=0;      count:=0;


 if CreateChannels(AlgParams.NChannels) then
  begin
     arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
     flgEnd:=false;
     hr:=arPCChannel[ch_Data_out].Main.get_Geometry(NChElements,ElementSize);
          if Failed(hr) then
                  begin
                    logstr:='error read geometry'+inttostr(nread);
                    Synchronize(log);
                   end
                  else
                  begin
                    logstr:='Channel data; Elements='+inttostr(NChElements)+'size='+inttostr(ElementSize);
                    Synchronize(log);
                  end;
       while (not Terminated) and (not flgEnd) do
      begin
       if flgJavaRunning  then
       begin
         nread:=1;
         sleep(100);
        if FlgStopJava then
         begin
          sleep(500);
           PIntegerArray(StopBuf)[0]:=StopJava;
           repeat
           begin
            nwrite:=1;
            hr:=arPCChannel[ch_stop].ChannelWrite.Write(StopBuf,nwrite);     //read stop channel  if stopbutton pressed  pStopval^=done
            if Failed(hr) then
                {$IFDEF DEBUG}
                  Formlog.memolog.Lines.add('error write stop channel'+inttostr(nwrite)+'hr='+inttostr(hr))
               {$ENDIF}
                else
               {$IFDEF DEBUG}
                    Formlog.memolog.Lines.add('write stop channel ='+inttostr(PIntegerArray(StopBuf)[0])+' '+inttostr(nwrite));
               {$ENDIF};
           end
           until not Failed(hr);
           repeat
             sleep(300);
             hr:=arPCChannel[ch_Draw_done].ChannelRead.Read(DoneBuf,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error read steps channel'+inttostr(nread)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('read step channel ='+inttostr(PIntegerArray(DoneBuf)[0])+' '+inttostr(nread));
            {$ENDIF}
            inc(count);
           until  (PIntegerArray(DoneBuf)[0]=done) or (count=10);
             {$IFDEF DEBUG}
                   Formlog.memolog.Lines.add('step =done'+inttostr(PIntegerArray(DoneBuf)[0])+' '+inttostr(nread));
            {$ENDIF}
             break;
         end; //stop java
         hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(ntoread);     //get new data count
        {$IFDEF DEBUG}
         if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(ntoread)+'hr='+inttostr(hr))
                       else Formlog.memolog.Lines.add('mover data to read '+inttostr(ntoread));
        {$ENDIF}
       //  ntoread:=ElementSize;
         hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,ntoread);    /// read data //nread is not number of elements ????
        {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read channel data '+inttostr(ntoread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('mover data has read '+inttostr(ntoread));
        {$ENDIF}
        if Failed(hr) then
                   begin
                      ntoread:=0;
                      inc(errcnt); //
                   end;
        if errcnt> 100  then
                   begin
                    flgEnd:=true;
                      {$IFDEF DEBUG}
                            Formlog.memolog.Lines.add('STOP : NMB of CHANNEL ERRORS =   '+inttostr(errcnt));
                      {$ENDIF}
                   end;
     if ntoread<> 0  then
     begin
      logstr:=' Test SM step done';
      GetData;
      Synchronize(DrawCurrentLine);
      if ScanParams.CurrentScanCount>= 1001 then  flgEnd:=true;
      
     end
     end;    //java running
   end;    //while
    ScanDone;
    FreeChannels;
 end  //channels create
 else
 begin // error create channels
 end;

    logstr:='End drawing in Step Test';
    Synchronize(log);
    PostMessage(StepsTest.Handle,WM_StepTestThreadDoneMsg,StepTesting,0);
    CoUnInitialize;
    FlgStopJava:=false;
    Self.Terminate;
(* try
  while (not Terminated)and (ScanParams.CurrentScanCount<=1001)  do
   begin
//     i:=ScanReport(@fs);
  //   NewPCount:=PointsNmb-fs.out_count-CurrentP;
     NPC:= NewPCount div 4;
    if NPC>0 then
    begin
           NewPCount:=NPC*4;
           lsz:= NewPCount;
       try
           SetLength(TempAquiData,lsz);
           GetScanData;
           Synchronize(DrawCurrentLine);
           CurrentP:=CurrentP+NewPCount;
           ScanParams.CurrentScanCount:=ScanParams.CurrentScanCount+NPC;
           NewPCount:=0;
       finally
           TempAquiData:=nil;
       end;
    end;
    if i=0 then
      begin
          PostMessage(StepsTest.Handle,WM_StepTestThreadDoneMsg,StepTesting,0);
          break;
      end;
//      fs.in_count:=REPORT_WAIT;       {‘ормирование условий работы функции ScanReport()}
//      fs.path_count:=REPORT_WAIT;     {ѕо потокам IN, PATH мы ожидаем окончани€ сканировани€}
//   if fs.out_count>1 then  fs.out_count:=fs.out_count-1          {”становка следующей метки в потоке OUT дл€ остановки}
//                     else  fs.out_count:=REPORT_WAIT;  {...либо ожидание конца сканировани€, если данных осталось мало}
   end; {while ScanCount}

finally

//   fs.Pin:=nil;
//   fs.Pout:=nil;
//   fs.PPath:=nil;
  if (not Terminated) then  Self.Terminate;
end;{finally}
*)
end;

procedure TStepTestDraw.GetData;
var i,j,k:integer;
begin

      Z:=datatype(PIntegerArray(DataBuf)[0] shr 16);
       NSteps:=datatype(PIntegerArray(DataBuf)[1]);
      ScanParams.CurrentScanCount:=ScanParams.CurrentScanCount+1;
(*  j:=dout;
  i:=0;
 repeat
  begin
    for k:=0 to 2 do
    begin
     TempAquiData[i+k]:=datatype(PIntegerArray(DataBuf)[j+i+k]);
    end;
     i:=i+3;
     TempAquiData[i]:=datatype(PIntegerArray(DataBuf)[j+i]);
     i:=i+1;
  end
  until (i>(lsz-1));
  dout:=dout+lsz; *)
end;

procedure TStepTestDraw.DrawCurrentLine;
var
  i,k:integer;
  a1,a2,a3,x,x0,y:double;
  cl:Tcolor;
begin
 i:=0; k:=0;
 if (ScanParams.CurrentScanCount*abs(Approachparams.ZStepsNumb)+lsz)>Stepstest.dn then
  begin
   Stepstest.dn:=Stepstest.dn+50;
   Stepstest.ChartZ_N.BottomAxis.SetMinMax(0,Stepstest.dn)
  end;
//  repeat
  begin
     (*a1:=TempAquiData[i];
     a2:=TempAquiData[i+1];
     a3:=TempAquiData[i+2];
     y:=round((a1+a2+a3)/3)/TransformUnit.Znm_d;   *)
     y := (maxapitype -Z)/TransformUnit.Znm_d;
     if y > Stepstest.maxZ then         // y это  +nm, отсчитанные от 0
     begin
      Stepstest.maxZ:=(MaxAPITYPE- MinApitype)/TransformUnit.Znm_d;  // максимальное значение в nm
      Stepstest.ChartZ_N.LeftAxis.SetMinMax(Stepstest.maxZ, Stepstest.minZ)
     end;
     if y < Stepstest.minZ then
     begin
      Stepstest.minZ:=0;
      Stepstest.ChartZ_N.LeftAxis.SetMinMax(Stepstest.minZ, Stepstest.maxZ)
     end;
    // x0:=TempAquiData[i+3];
    x0:=NSTEPS;
     if x0 > 0 then cl:=ClRed     // forward
             else cl:=ClBlue;   //backward

     x:=abs(NSteps)*(ScanParams.CurrentScanCount+k);
     StepsTest.SeriesZ_N.AddXY(x,y,'',cl);
  //   i:=i+4;
     inc(k);
  end
//  until (i>(lsz-1));
end;

procedure TStepTestDraw.log;
begin
      {$IFDEF DEBUG}
           Formlog.memolog.Lines.add(logstr);
      {$ENDIF}
end;

end.
