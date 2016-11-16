unit uNanoeduEtchingClasses;

interface
uses classes, dialogs, messages,SysUtils,IniFiles,
 UNanoEduBaseClasses,uNanoEduBaseMethodClass;

type


 TEtchingNanoEdu=class(TBaseNanoEdu )
private
public
   Motor:TStepMotorX;
  Constructor Create;
  function TurnOn:boolean;            override;
  function TurnOff:boolean;           override;
  destructor  Destroy();              override;
end;



TEtchingMethod=class(TScanMethod)
private
  PathArray:Array of Word;
  DataInArray:Array of Word;
  newPathInd,newDataInInd:integer;
  function  InitBuffers:integer; override;
  procedure LinearPath;          override;
  procedure SetDataIn;           override;
  procedure SetPath;             override;
  function  InitRegimeVars:integer;      override;
  procedure StartDraw;           override;
  procedure SetIlevel(val:integer);
  procedure Set_NonStopTime(val:integer);
  function  Get_NonStopTime:integer;
  procedure Set_SessionTakts(val:integer);
  function  Get_SessionTakts:integer;
  procedure Set_CurrentControlLevel(val:integer);
  function  Get_STATUSETCHING:integer;
  procedure Set_LevelJumps(val:integer);
  function  Get_LevelJumps:integer;

public
 SessionTaktsNmb:integer;
 property   ILevel:integer       write SetILevel;
constructor Create;              overload;
 function   Launch:integer;      override;
 procedure  SaveEtchParams;
 procedure  SetSpeed;            override;
 property   NonStopTime:integer   read  Get_NonStopTime  write Set_NonStopTime;
 property   SessionTakts:integer  read  Get_SessionTakts  write Set_SessionTakts;
 property   CurrentControlLevel:integer    write Set_CurrentControlLevel;
 property   STATUSETCHING:integer read  Get_STATUSETCHING;
 property   LevelJumps:integer    read  Get_LevelJumps  write Set_LevelJumps;
end;

(*var
 EtchingParams: REtchingParams;
 EtchMetDirectory:string;
 EtchingIniFilePath:string;
 DefaultEtchMethodName:string;
 EtchSessionParams:REtchSessionParams;
*)
implementation

uses GlobalType,SIOCSPM, EtchingVar,GlobalVar,UNanoEduInterface,EtchingDrawThead,frEtchingGUI, CSPMVar;


function TEtchingNanoEdu.TurnOff:boolean;
begin
  Motor.Turnoff;
  Bias:=0;
end;

destructor  TEtchingNanoEdu.Destroy();
begin
     FreeAndNil(Motor);
     inherited Destroy;
end;

Constructor TEtchingNanoEdu.Create;
begin
  inherited;
   Motor:=TStepMotorX.Create;
end;

function TEtchingNanoEdu.TurnOn:boolean;
var CZTune:word;
begin
    Motor.TurnOff;
    API.ADCMCH_ENA:=16;    //adc_lat
    Bias:=0;
end;

function  TEtchingMethod.InitBuffers:integer;
var i:integer;
    P:TEtchingElement;
    NCycles:integer;
    nPausePoints:integer;
begin
  result:=0;
  PathLength:=0;
  Data_out_BufferLength:=0;
  Data_in_BufferLength:=0;
  for i:=0 to EtchingSessionList.Count-1 do
    begin
      P:=(EtchingSessionList.Items[i]);
     // P.PathCount:=Data_out_BufferLength div 2;
      nPausePoints:=round(EtchSessionParams.PauseEtching_Step*EtchingParams.Freq/1000); // Default, if STEPS is the First Element
      case P.ElementType of
      STEPSELEMENT: begin
                         PathLength:=PathLength+2+2;
                         Data_out_BufferLength:=Data_out_BufferLength+3*2*nPausePoints; //2
                         P.PointsCount:=2*nPausePoints;
                         Data_in_BufferLength:=Data_in_BufferLength+6;
                    end;
      ETCHSIGNALELEMENT : begin
                             NCycles:=round((P as TEtchingSignalElement).EtchingTime*
                                                            (P as TEtchingSignalElement).Freq);
                             PathLength:=PathLength+2*(NCycles*(P as TEtchingSignalElement).PointsNmb+1)+2;
                             nPausePoints:=round(EtchSessionParams.PauseEtching_Step*
                                                                 (P as TEtchingSignalElement).Freq/1000);
                             Data_out_BufferLength:=Data_out_BufferLength+3*(NCycles+2*nPausePoints);  //2
                             P.PointsCount:=NCycles+2*nPausePoints;
                             Data_in_BufferLength:=Data_in_BufferLength+6;
                          end;
      ETCHANDSTEPSELEMENT: begin
                             NCycles:=round((P as TEtchingAndStepsElement).EtchingTime*
                                                             (P as TEtchingAndStepsElement).Freq);
                             PathLength:=PathLength+2*(NCycles*(P as TEtchingAndStepsElement).PointsNmb+1)*
                                                             (P as TEtchingAndStepsElement).CyclesE_StNmb+2;
                             nPausePoints:=round(EtchSessionParams.PauseEtching_Step*
                                                                 (P as TEtchingAndStepsElement).Freq/1000);
                             Data_out_BufferLength:=Data_out_BufferLength+3*(P as TEtchingAndStepsElement).CyclesE_StNmb*     //2
                                                              (NCycles+2*nPausePoints);
                             P.PointsCount:= (P as TEtchingAndStepsElement).CyclesE_StNmb*(NCycles+2*nPausePoints);
                             Data_in_BufferLength:=Data_in_BufferLength+6;
                          end;

    end; {case}
 end;

 // Data_in_BufferLength:=1;


 try
  GetMem(data_path,(PathLength)*sizeof(word));
 except
              on EOutOfMemory        do
         begin
              MessageDlg('OUT memory decrease action time or frequecy or point numbers!',mtWarning,[mbOk],0);
             result:=1;
             exit;
         end;
  end;
 try
  GetMem(data_out,Data_out_BufferLength*sizeof(word));
  except
              on EOutOfMemory        do
            begin
              MessageDlg('OUT memory decrease action time or frequecy !',mtWarning,[mbOk],0);
                result:=2;
                 exit;
            end;
  end;
  try
   GetMem(data_in,(Data_in_BufferLength+1)*sizeof(word));
  except
              on EOutOfMemory        do
             begin
              MessageDlg('OUT memory decrease action time or frequecy or point numbers!',mtWarning,[mbOk],0);
                 result:=3;
                 exit;
             end;
  end;
  EtchingParams.OutBufferLength:=Data_out_BufferLength;
  PathArray:=nil;
 try
  SetLength(PathArray,PathLength);
 except      on   ERangeError do
             begin
             MessageDlg('OUT memory decrease action time or frequecy or point numbers!',mtWarning,[mbOk],0);
             result:=4;
             exit;

             end;
              on EOutOfMemory        do
             begin
              MessageDlg('OUT memory decrease action time or frequecy or point numbers!',mtWarning,[mbOk],0);
             result:=4;
             exit;
            end;
  end;
 DataInArray:=nil;
 try
  SetLength(DataInArray,Data_in_BufferLength);
 except       on   ERangeError do
             begin
             MessageDlg('OUT memory decrease action time or frequecy or point numbers!',mtWarning,[mbOk],0);
             result:=4;
             exit;

             end;
              on EOutOfMemory        do
            begin
              MessageDlg('OUT memory decrease action time or frequecy or point numbers!',mtWarning,[mbOk],0);
             result:=5;
             exit;
           end;
  end;

end;



procedure TEtchingMethod.LinearPath;
var i,j,k,l,s,newPathInd:integer;
    temp: integer;
    val:integer;
    NTakts, LConstSignStart:integer;
    FuncType:integer;
    flgEndPath:Boolean;
    ZeroVoltageCnt:integer;
    LocalAmpl:integer;
    P:TEtchingElement;
    UAmpl, StepUT:single;
    Frequency, NCycles, NPoints, NCyclesE_St, StepAuto:integer;
    TimeCount:single;
    TaktsCount:integer;
    FlgSetNonStopTakts:boolean;
    MinSteps,MaxSteps, StepsCnt:integer;
begin
 // funcType:=EtchingParams.flgtypefunction;
 	f.Ppath:= data_path;
 	f.path_count:=PathLength;
  FlgSetNonStopTakts:=False;
  k:=0;
  TaktsCount:=0;
  TimeCount:=0;
  flgEndPath:=False;
  ZeroVoltageCnt:=0;
  StepsCnt:=0;
  MinSteps:=0;
  MaxSteps:=0;
 // NTakts:=EtchingParams.NCycles*EtchingParams.NCyclesE_St-EtchingParams.SessionTaktsPassed;
   for s:=0 to EtchingSessionList.Count-1 do
    begin
      P:=(EtchingSessionList.Items[s]);
      case P.ElementType of
      STEPSELEMENT: begin

                        StepAuto:=-(P as TStepsElement).StepsNmb;
                        PathArray[k]:= 4;//Read DATA_IN;
                        PathArray[k+1]:=4;
                        inc(k,2);
                        PathArray[k]:= $0020;//5; // ONLY STEPS;
                        PathArray[k+1]:=word(StepAuto);
                        inc(k,2);
                        inc(StepsCnt,-StepAuto);
                        if MinSteps>StepsCnt then MinSteps:=StepsCnt;
                        if MaxSteps<StepsCnt then MaxSteps:=StepsCnt;
                        TimeCount:=TimeCount+2*0.001*EtchSessionParams.PauseEtching_Step;
                    end;
      ETCHSIGNALELEMENT : begin  with  (P as TEtchingSignalElement) do
                                       begin
                                         UAmpl:=Amplitude;
                                         Frequency:=Freq;
                                         NCycles:=round(EtchingTime*Freq);//-EtchingParams.SessionTaktsPassed;
                                         NPoints:=PointsNmb;
                                         StepUT:=1/Frequency/(Npoints-1);
                                         funcType:=SignalType;
                                       end;
                            PathArray[k]:= 4;//Read DATA_IN;
                            PathArray[k+1]:=4;
                            inc(k,2);
                           for i:=0 to NCycles-1   do
                              begin
                               for j:=0 to Npoints-1  do
                                   begin
                                     case  funcType of
                                      0: temp:=(round(UAmpl*5/7*TransformUnit.BiasV_d*
                                                  sin(2*pi*Frequency*j*StepUT-PI/2)));

                                      1: temp:= round(UAmpl*5/7*TransformUnit.BiasV_d);
                                     end; {case}
                               // 	PWordArray(data_path)[k]:= word($C000);
                               //   PWordArray(data_path)[k+1]:=word(temp);;
                                  PathArray[k]:= 2;//ETCHING SIGNAL;
                                  PathArray[k+1]:=word(temp);
                                  inc(k,2);

                                   end;
                                 inc(TaktsCount);
                                 TimeCount:=TimeCount+1/Frequency;
                                 if TimeCount>=EtchSessionParams.NonStopTimeVal then
                                                             begin
                                                               if not FlgSetNonStopTakts then
                                                                 begin
                                                                  EtchSessionParams.NonStopTakts:=TaktsCount;
                                                                  FlgSetNonStopTakts:=True;
                                                                 end;
                                                             end;
                              end;
                          	PathArray[k]:= $0010;//3;//STEPS AFTER ETCHING;
                            PathArray[k+1]:=0;
                            inc(k,2);
                            TimeCount:=TimeCount+2*0.001*EtchSessionParams.PauseEtching_Step;
                          end;
      ETCHANDSTEPSELEMENT: begin  with (P as TEtchingAndStepsElement) do
                                       begin
                                         UAmpl:=Amplitude;
                                         Frequency:=Freq;
                                         NCycles:=round(EtchingTime*Freq);//-EtchingParams.SessionTaktsPassed;
                                         NPoints:=PointsNmb;
                                         StepUT:=1/Frequency/(Npoints-1);
                                         NCyclesE_St:=CyclesE_StNmb;
                                         funcType:=SignalType;
                                         StepAuto:=-StepsNmb;
                                       end;
                            PathArray[k]:= 4;//Read DATA_IN;
                            PathArray[k+1]:=4;
                            inc(k,2);
                       l:=0;
                       repeat
                          begin
                           for i:=0 to NCycles-1   do
                              begin
                               for j:=0 to Npoints-1  do
                                   begin
                                     case  funcType of
                                      0: temp:=(round(UAmpl*5/7*TransformUnit.BiasV_d*
                                                  sin(2*pi*Frequency*j*StepUT-PI/2)));

                                      1: temp:= round(UAmpl*5/7*TransformUnit.BiasV_d);
                                     end; {case}
           	                       PathArray[k]:= 2;//ETCHING SIGNAL;
                                   PathArray[k+1]:=word(temp);;
                                   inc(k,2);
                                  end;
                                  inc(TaktsCount);
                                  TimeCount:=TimeCount+1/Frequency;
                                  if TimeCount>=EtchSessionParams.NonStopTimeval then
                                                             begin
                                                               if not FlgSetNonStopTakts then
                                                                 begin
                                                                  EtchSessionParams.NonStopTakts:=TaktsCount;
                                                                  FlgSetNonStopTakts:=True;
                                                                 end;
                                                             end;
                              end;

          	                PathArray[k]:=$0010;//3;// STEPS AFTER ETCHING;;
                            PathArray[k+1]:=word(StepAuto);
                            inc(k,2);
                            inc(l);
                            inc(StepsCnt,-StepAuto);
                            if MinSteps>StepsCnt then MinSteps:=StepsCnt;
                            if MaxSteps<StepsCnt then MaxSteps:=StepsCnt;
                            TimeCount:=TimeCount+2*0.001*EtchSessionParams.PauseEtching_Step;
                         end   {repeat}
                      until (l>(NCyclesE_St-1));// or (flgEndPath);

    end; {case}
 end;

  end;   {with}

  newPathInd:= $FFFC*EtchSessionParams.PassedPathCntOldReg+EtchSessionParams.PassedPathCnt;

  for i:=newPathInd to PathLength-1 do
     PWordArray(data_path)[i-newPathInd]:=PathArray[i];

     PathArray:=nil;
    if not FlgSetNonStopTakts then val:=TaktsCount
      else
         val:=EtchSessionParams.NonStopTakts-EtchSessionParams.SessionTaktsPassed;
    if val<0 then val:=0;
    NonStopTime:=val;
   // EtchSessionParams.FullEtchingTime:= TimeCount;
    EtchSessionParams.MinStepsNmb:=MinSteps;
    EtchSessionParams.MaxStepsNmb:=MaxSteps;
end;  {LinearPath}



Constructor TEtchingMethod.Create;
begin
 inherited create;

end;

function TEtchingMethod.InitRegimeVars:integer;
var
  val:smallint;
   P:TEtchingElement;
begin

   begin
     P:=EtchingSessionList.Items[EtchSessionParams.Element_OnProgress_Ind];
     if P is TEtchingSignalElement then
              begin
                 val:=round(1E6/(P as TEtchingSignalElement).Freq/(P as TEtchingSignalElement).PointsNmb);
                 SetCommonVar(adr84, val);  //aDelay_E=$84
                 val:= round(EtchingParams.TimeOfSumming*(P as TEtchingSignalElement).Freq/1000);
                 SetCommonVar(adr90, val); //aNPeriodsInStep=$90
                 val:=round(EtchingParams.ControlDelay*(P as TEtchingSignalElement).Freq);
                 SetCommonVar(adr8A,val);  //aNStart=$8A
                 val:= (P as TEtchingSignalElement).PointsNmb;
                 SetCommonVar(adr8C, val); //aPointsPerPeriod=$8C
              end;
    end;
   //!!!!!! Одно значение Pause Et_St для всех элем
 //SetCommonVar(aPause, EtchSessionParams.PauseEtching_Step);

 SetCommonVar(adr88, EtchingParams.Ilevel); //aLevelIT=$88 //stop etching I

 CurrentControlLevel:=EtchingParams.CurrentControlLevelVal;
 LevelJumps:= EtchingParams.levelJumps;

 (*SetCommonVar(aDelay_E, EtchingParams.EtchDelay);
 SetCommonVar(aNstart, EtchingParams.NStart);   // start compare I Зависит от частоты!
 SetCommonVar(aPointsPerPeriod, EtchingParams.Npoints);    ///!!! Зафиксировано, одинаково для всех элем.
 SetCommonVar(aNPeriodsInStep, EtchingParams.NPeriodsInStep); // !! Зависит от частоты  в каждом элементе!!!
 *)

// val:=EtchingParams.NonStopTime*EtchingParams.Freq-EtchingParams.SessionTaktsPassed;  //???
 result:=0;
if  InitBuffers>0 then begin result:=1; exit; end;
 SetPath;
 SetDataIn;
end;

Procedure TEtchingMethod.SetDataIn;
var i,k, newDataInInd:integer;
    P:TEtchingElement;

begin
  k:=0;
  for i:=0 to EtchingSessionList.Count-1 do
    begin
      P:=(EtchingSessionList.Items[i]);
      if P is TEtchingSignalElement then
        begin
           DataInArray[k]:=round(1E6/(P as TEtchingSignalElement).Freq/
                                           (P as TEtchingSignalElement).PointsNmb);  //  aDelay_E; DELAY
           DataInArray[k+1]:= round(EtchingParams.TimeOfSumming*(P as TEtchingSignalElement).Freq/1000); //NPeriodsInStep
           DataInArray[k+2]:= round(EtchingParams.ControlDelay*(P as TEtchingSignalElement).Freq); // NStart
           DataInArray[k+3]:= (P as TEtchingSignalElement).PointsNmb;
           DataInArray[k+4]:= round(EtchSessionParams.PauseEtching_Step*
                                             (P as TEtchingSignalElement).Freq/1000); //NPausePoints (между сигналом и шагами)
           DataInArray[k+5]:= round(1000/(P as TEtchingSignalElement).Freq); // задержка (ms) между точками, выводимыми при паузе
                                                                              // передается для таймера скрипта
           k:=k+6;
        end
        else     // For Steps Element;
        begin
           DataInArray[k]:=round(1E6/EtchingParams.Freq/
                                           EtchingParams.Npoints);  //  aDelay_E; DELAY
           DataInArray[k+1]:= round(EtchingParams.TimeOfSumming*EtchingParams.Freq/1000); //NPeriodsInStep
           DataInArray[k+2]:= round(EtchingParams.ControlDelay*EtchingParams.Freq); // NStart
           DataInArray[k+3]:= EtchingParams.Npoints;
           DataInArray[k+4]:= round(EtchSessionParams.PauseEtching_Step*
                                             EtchingParams.Freq/1000); //NPausePoints (между сигналом и шагами)
           DataInArray[k+5]:= round(1000/EtchingParams.Freq); // задержка (ms) между точками, выводимыми при паузе
                                                                              // передается для таймера скрипта
           k:=k+6;
        end;
    end;

    newDataInInd:= 0;
    if   not EtchSessionParams.FlgNewSession then   // if not new session
                       newDataInInd:=(EtchSessionParams.Element_OnProgress_Ind+1)*6;

   for i:=newDataInInd to Data_in_BufferLength-1 do
        PWordArray(data_in)[i-newDataInInd]:=DataInArray[i];

        DataInArray:=nil;
end;


Procedure TEtchingMethod.SetPath;
begin
  LinearPath;
end;

procedure TEtchingMethod.StartDraw;
begin
 if not assigned(EtchingDrawThread) or (not EtchingDrawThreadActive) then
       begin
          EtchingDrawThread:= TEtchingDrawThread.Create;
          EtchingDrawThreadActive := True;
       end ;
end;

procedure TEtchingMethod.SetIlevel(val:integer);
begin
 SetCommonVar(adr88,apitype(val)); //aLevelIT=$88
end;


procedure TEtchingMethod.Set_NonStopTime(val:integer);
begin
 SetCommonVar(adr92,unapitype(val));  //aNonStopTime= $92
end;
function  TEtchingMethod.Get_NonStopTime:integer;
begin
 Result:=GetCommonVar(adr92);  //aNonStopTime= $92
end;


procedure TEtchingMethod.Set_SessionTakts(val:integer);
begin
// SetCommonVar(aSessionTakts, val);
   SetCommonVar(adr8E,unapitype(val));  //aNMeasures=$8E
end;

procedure TEtchingMethod.Set_CurrentControlLevel(val:integer);
begin
  SetCommonVar(adr98,unapitype(val));   //aCurrentControlLevel=$98
end;

function  TEtchingMethod.Get_SessionTakts:integer;
begin
 Result:=GetCommonVar(adr8E);//aNMeasures=$8E//(aSessionTakts);
end;

function  TEtchingMethod.Get_STATUSETCHING:integer;
begin
 Result:=GetCommonVar(adr96); //aSTATUSETCHING=$96
end;

procedure TEtchingMethod.Set_LevelJumps(val:integer);
begin
  SetCommonVar(adr9A,unapitype(val));//aLevelJumps=$9A
end;

function  TEtchingMethod.Get_LevelJumps:integer;
begin
 Result:=GetCommonVar(adr9A);  //aLevelJumps=$9A
end;

function  TEtchingMethod.Launch:integer;
begin
 result:=0;
 InitRegimeVars;
 if StartWork(EtchingScrpt)<>0 then
  begin
  FreeBuffer;
  result:=1;
  exit;
 end;
 StartDraw;
end;

procedure  TEtchingMethod.SaveEtchParams;
begin
  EtchingParams.EtchDelay:=GetCommonVar(adr84);   //aDelay_E=$84
 EtchingParams.NStart:=GetCommonVar(adr8A); //aNStart=$8A  // start compare I Зависит от частоты!
 EtchingParams.Npoints:=GetCommonVar(adr8C); //aPointsPerPeriod=$8C   ///!!! Зафиксировано, одинаково для всех элем.
 EtchingParams.NPeriodsInStep:=GetCommonVar(adr90);//aNPeriodsInStep=$90 // !! Зависит от частоты  в каждом элементе!!!

end;

procedure  TEtchingMethod.SetSpeed;
begin
  SetCommonVar(adr84, EtchingParams.EtchDelay); //aDelay_E=$84
end;




end.
