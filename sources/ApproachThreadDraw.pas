unit ApproachThreadDraw;

interface

uses
  Classes,Forms,windows,Graphics,MLPC_APILib_TLB,
        {$IFDEF DEBUG}
              frDebug,
       {$ENDIF}
       globaltype,activex;
type
  TApproachthread = class(TThread)
  private
    { Private declarations }
      fcount:integer;
      Z,SignalValue:datatype;
      logstr:string;
      ElementSize:integer;
    procedure DrawIndicators;
  protected
    procedure Execute; override;
    function  MakeSteps:integer;
    procedure GetData;
    procedure ZIndicatorDraw(Z:apitype);
    procedure Log;
    procedure SignalDraw(SignalValue:apitype);
  public
   constructor Create;
   destructor  Destroy; override;
  end;

var
 ApproachThread:TApproachthread;
 ApproachThreadActive:boolean;

implementation

uses  CSPMVAR,globalvar,SioCSPM,UNanoEduBaseClasses,uNanoEduScanClasses,
      MLPC_API2Lib_TLB,frApproachnew,SysUtils;


  procedure TApproachthread.GetData;
  begin
//   if FlgCurrentUserLevel<>Demo then
    fcount:=0;
  if fcount< ApproachParams.DataBufLength then
  begin
  Approach.FlgStepResult:=datatype(PIntegerArray(DataBuf)[fcount]);
                       Z:=datatype(PIntegerArray(DataBuf)[fcount+1] shr 16);
             SignalValue:=datatype(PIntegerArray(DataBuf)[fcount+2] shr 16);
     inc(fcount,3);
  end;
  if FlgCurrentUserLevel=Demo then if FlgStopJava then     Approach.FlgStepResult:=StopDone;
  end;

procedure  TApproachthread.SignalDraw(SignalValue:apitype);
begin
          with Approach do
         begin
                              case STMFlg of                 //151210
      TRUE: begin
             SignalIndicator.Value:=abs(SignalValue*ITCor);   //070212
             if Assigned(Approach) then
                 LabelCur.Caption:=FloatToStrF(ITCor*SignalValue/TransformUnit.nA_d,ffFixed ,8,3)
            end;
      False: begin
              SignalIndicator.Value:=SignalValue  ;
              if Assigned(Approach) then
                 LabelCur.Caption:=FloatToStrF(SignalValue/ApproachParams.UAMMax,ffFixed ,8,2)
             end;
               end; //case
         end;
//           SignalIndicator.Repaint;
end;

procedure TApproachthread.ZIndicatorDraw(Z:apitype);
begin
        with  Approach do
        begin
         ZIndicator.Value:=round((MinAPITYPE+1)*(Z-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));
         LabelZV.Font.color:=clGreen;
         ZIndicator.IndicColor:=clGreen;
         if  (ZIndicator.Value < ZIndicator.LowLimit) then
         begin
          ZIndicator.IndicColor:=clRed;
          LabelZV.Font.color:=clRed;
         end
         else
         if  (ZIndicator.Value >ZIndicator.HighLimit) then
         begin
          ZIndicator.IndicColor:=clNavy;
          LabelZV.Font.color:=clNavy ;
         end ;
         LabelZV.Caption:=FloattoStrF(ZIndicator.Value/Maxapitype,fffixed,3,2);
        end;
 end;

procedure TApproachthread.log;
begin
      {$IFDEF DEBUG}
           Formlog.memolog.Lines.add(logstr);
      {$ENDIF}
end;

constructor TApproachthread.Create;
begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;
 end;

destructor TApproachthread.Destroy;
begin
   ThreadFlg:=mDrawing;
   PostMessage(Approach.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;

function  TApproachThread.MakeSteps:integer;
var lstatus:apitype;
    nwrite,nread:integer;
    hr:Hresult;
begin
 try
    PIntegerArray(DoneBuf)[0]:=Steps;
    nwrite:=1;
    hr:=arPCChannel[ch_Steps_done].ChannelWrite.Write(DoneBuf,nwrite);
    if not Failed(Hr) then
    begin
      repeat
       begin
        sleep(ApproachParams.IntegratorDelay div 4);      //ms       div 2
        nread:=1;
        logstr:='wait for step ';
        Synchronize(log);
         hr:=arPCChannel[ch_Steps_done].ChannelRead.Read(DoneBuf,nread);
         if Failed(hr) then
          begin
              logstr:='error read geometry'+inttostr(nread);
              Synchronize(log);
          end;
         if PIntegerArray(DoneBuf)[0]=done then
         begin
           hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(nread);     //get new data count
          {$IFDEF DEBUG}
           if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(nread)+'hr='+inttostr(hr))
                        else Formlog.memolog.Lines.add('scandraw data to read '+inttostr(nread));
          {$ENDIF}
          nread:=1;
          hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,nread);    /// nread is not number of elements ????
         if Failed(hr) then
             begin
               logstr:='error read channel ='+inttostr(ch_Data_out)+' '+inttostr(nread);
               Synchronize(log);
             end;
               GetData;
           break; //
         end;
         if PIntegerArray(DoneBuf)[0]=0 then break;   //close channel ???
      end;
     until not flgJavaRunning;// or flgEndScript);     //flgStopApproach
     result:=Approach.FlgStepResult;
    end
    else
    begin
     Approach.FlgStepResult:=0; //stop
     result:=Approach.FlgStepResult;
    end;
 finally

 end;
end;

procedure TApproachThread.Execute;
var
  hr:Hresult;
  NChElements,CurChElements,n,nwrite,nread:integer;
  ID,status:integer;
begin
  { Place thread code here }
 CoInitializeEx(nil,COINIT_MULTITHREADED);
       logstr:='Start drawing';
        Synchronize(log);
     fcount:=0;
 if CreateChannels(AlgParams.NChannels) then
  begin
    arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
   if ID=ch_Data_OUT then
   begin
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
      Approach.ToolBarControl.Enabled:=true;
    repeat     // make steps
    begin
     if flgJavaRunning then
     begin
      if flgStopJava then
      begin
           sleep(500);
           PIntegerArray(StopBuf)[0]:=StopJava;
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
      end;
      Approach.FlgStepResult:=MakeSteps;
      logstr:='step done';
      Synchronize(log);
      Approach.StepsCount:=Approach.StepsCount+ApproachParams.ZStepsNumb;
               case Approach.FlgStepResult of
      5,3,2,4: begin
                FlgStopApproach:=true;
                DemoParams.Z:=Z;
                DemoParams.OscAmp:=SignalValue;
               end;      //ok
                     end;
          synchronize(DrawIndicators);
     end
     else
     begin
      FlgStopApproach:=true;
     end;
    end
    until FlgStopApproach ;  // or ApproachParams.flgOneStep;
     ScanDone;
     FreeChannels;
  end; //ID
 end;  //channels create
    logstr:='End drawing';
    Synchronize(log);
    PostMessage(Approach.Handle,wm_ThreadDoneMsg,mScanning,0);
    CoUnInitialize;
    FlgStopJava:=false;
    Self.Terminate;
end;

 procedure TApproachthread.DrawIndicators;
 begin
       Approach.edStepsCounter.Caption:=Format( '%d' ,[ Approach.StepsCount]);
       ZIndicatorDraw(Z);
       SignalDraw(SignalValue);
                  case STMFlg of
     False: begin
              Approach.LabelCur.Caption:=FloatToStrF( Approach.SignalIndicator.Value/ApproachParams.UAMMax,ffFixed ,8,2)
            end;
      TRUE: begin
              Approach.LabelCur.Caption:=FloatToStrF(ITCor*Approach.SignalIndicator.Value/TransformUnit.nA_d,ffFixed ,8,3)
            end;
               end; //case
end;

end.
