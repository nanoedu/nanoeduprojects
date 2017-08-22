unit ApproachThreadDrawNew;
//07.11.14  correction getdata
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
      Z,SignalValue:datatype;
      logstr:string;
      ElementSize:integer;
    procedure DrawIndicators;
  protected
    procedure Execute; override;
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

uses  CSPMVAR,globalvar,globalfunction,SioCSPM,UNanoEduBaseClasses,uNanoEduScanClasses,
      MLPC_API2Lib_TLB,frApproachnew,SysUtils;


  procedure TApproachthread.GetData;
  var res:integer;
  begin
    Approach.FlgStepResult:=datatype(PIntegerArray(DataBuf)[0]);
                         Z:=datatype(PIntegerArray(DataBuf)[1] shr 16);
                case STMFLG  of
      true:  SignalValue:={sign(ApproachParams.BiasV)*}-datatype(PIntegerArray(DataBuf)[2] shr 16);  //160113
     false:  SignalValue:=datatype(PIntegerArray(DataBuf)[2] shr 16);
                end;
        if (FlgCurrentUserLevel <> Demo)
          then
          Begin
             res:= integer(PIntegerArray(DataBuf)[3]);
           case   flgUnit of
nano,nanotutor,terra:  Approach.StepsCount:=res;//datatype(PIntegerArray(DataBuf)[3]); //0711114             //4
    ProBeam,MicProbe:  Approach.StepsCount:=Approach.StepsCount+res;//datatype(PIntegerArray(DataBuf)[3]);  //4
                    end
          End
          else
          begin            //demo
             if Approach.FlgStepResult =0 then   Approach.StepsCount:=Approach.StepsCount+ApproachParams.ZStepsNumb;//
             ApproachParams.ZStepsDone:=Approach.StepsCount;                    // Должно быть в Destroy
          end;
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
         //ZIndicator.Value:=round((MinAPITYPE+1)*(Z-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));
         ZIndicator.Value:=round((MaxAPITYPE)*(1-(Z-MinAPITYPE)/(MaxAPITYPE-MinAPITYPE))); // Нормировка изменена 30/07/2013
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
   Suspended := false;// Resume;
 end;

destructor TApproachthread.Destroy;
begin
   ThreadFlg:=mDrawing;
   PostMessage(Approach.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;


procedure TApproachThread.Execute;
var
  hr:Hresult;
  NChElements,CurChElements,n,nwrite,nread:integer;
  ID,status:integer;
  errcnt,count:integer;
  ntoread:integer;
  flgEnd:boolean;
begin
  { Place thread code here }
//   sleep(1000);
 CoInitializeEx(nil,COINIT_MULTITHREADED);
       logstr:=Approach.siLangLinked1.GetTextOrDefault('IDS_7' (* 'Start drawing' *) );
        Synchronize(log);
    errcnt:=0;      count:=0;
    Approach.ToolBarControl.Enabled:=true;
    Application.ProcessMessages;

 if CreateChannels(AlgParams.NChannels) then
  begin
     arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
     flgEnd:=false;
     hr:=arPCChannel[ch_Data_out].Main.get_Geometry(NChElements,ElementSize);
          if Failed(hr) then
                  begin
                    logstr:=Approach.siLangLinked1.GetTextOrDefault('IDS_21' (* 'error read geometry' *) )+inttostr(nread);
                    Synchronize(log);
                   end
                  else
                  begin
                    logstr:=Approach.siLangLinked1.GetTextOrDefault('IDS_22' (* 'Channel data; Elements=' *) )+inttostr(NChElements)+Approach.siLangLinked1.GetTextOrDefault('IDS_26' (* 'size=' *) )+inttostr(ElementSize);
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
                  Formlog.memolog.Lines.add(Approach.siLangLinked1.GetTextOrDefault('IDS_34' (* 'error write stop channel' *) )+inttostr(nwrite)+Approach.siLangLinked1.GetTextOrDefault('IDS_36' (* 'hr=' *) )+inttostr(hr))
               {$ENDIF}
                else
               {$IFDEF DEBUG}
                    Formlog.memolog.Lines.add(Approach.siLangLinked1.GetTextOrDefault('IDS_37' (* 'write stop channel =' *) )+inttostr(PIntegerArray(StopBuf)[0])+' '+inttostr(nwrite));
               {$ENDIF};
           end
           until not Failed(hr);
           repeat
             sleep(300);
             hr:=arPCChannel[ch_Draw_done].ChannelRead.Read(DoneBuf,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add(Approach.siLangLinked1.GetTextOrDefault('IDS_38' (* 'error read steps channel' *) )+inttostr(nread)+Approach.siLangLinked1.GetTextOrDefault('IDS_36' (* 'hr=' *) )+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add(Approach.siLangLinked1.GetTextOrDefault('IDS_44' (* 'read step channel =' *) )+inttostr(PIntegerArray(DoneBuf)[0])+' '+inttostr(nread));
            {$ENDIF}
            inc(count);
           until  (PIntegerArray(DoneBuf)[0]=done) or (count=10);
             {$IFDEF DEBUG}
                   Formlog.memolog.Lines.add(Approach.siLangLinked1.GetTextOrDefault('IDS_45' (* 'step =done' *) )+inttostr(PIntegerArray(DoneBuf)[0])+' '+inttostr(nread));
            {$ENDIF}
             break;
         end; //stop java
         hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(ntoread);     //get new data count
        {$IFDEF DEBUG}
         if Failed(hr) then Formlog.memolog.Lines.add(Approach.siLangLinked1.GetTextOrDefault('IDS_46' (* 'error get count data ' *) )+inttostr(ntoread)+Approach.siLangLinked1.GetTextOrDefault('IDS_36' (* 'hr=' *) )+inttostr(hr))
                       else Formlog.memolog.Lines.add(Approach.siLangLinked1.GetTextOrDefault('IDS_48' (* 'mover data to read ' *) )+inttostr(ntoread));
        {$ENDIF}
       //  ntoread:=ElementSize;     //??????  160217
         sleep(GETCOUNT_DELAY);
         hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,ntoread);    /// read data //nread is not number of elements ????
        {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add(Approach.siLangLinked1.GetTextOrDefault('IDS_49' (* 'error read channel data ' *) )+inttostr(ntoread)+Approach.siLangLinked1.GetTextOrDefault('IDS_36' (* 'hr=' *) )+inttostr(hr))
                      else Formlog.memolog.Lines.add(Approach.siLangLinked1.GetTextOrDefault('IDS_53' (* 'mover data has read ' *) )+inttostr(ntoread));
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
                            Formlog.memolog.Lines.add(Approach.siLangLinked1.GetTextOrDefault('IDS_54' (* 'STOP : NMB of CHANNEL ERRORS =   ' *) )+inttostr(errcnt));
                      {$ENDIF}
                   end;
     if ntoread<> 0  then
     begin
      logstr:=Approach.siLangLinked1.GetTextOrDefault('IDS_55' (* 'step done' *) );
      GetData;
               case Approach.FlgStepResult of
      5,3,2,4: begin
                FlgEnd:=true;
               end;      //ok
                     end;
      DemoParams.Z:=Z;
      DemoParams.OscAmp:=SignalValue;
      DemoParams.TunnelCurrent:=   SignalValue;
      Synchronize(log);
      synchronize(DrawIndicators);
     end
     end;    //java running
   end;    //while
    ScanDone;
    FreeChannels;
 end  //channels create
 else
 begin // error create channels
 end;
    FlgStopApproach:=true;
    logstr:=Approach.siLangLinked1.GetTextOrDefault('IDS_56' (* 'End drawing' *) );
    Synchronize(log);
    PostMessage(Approach.Handle,wm_ThreadDoneMsg,mScanning,0);
    CoUnInitialize;
    FlgStopJava:=false;
    Self.Terminate;
end;

 procedure TApproachthread.DrawIndicators;
 begin
       Approach.edStepsCounter.Caption:=Format( '%d' ,[-Approach.StepsCount]);          // why minus?
       Approach.ZIndicatorDraw(Z);
       //ZIndicatorDraw(Z);
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
