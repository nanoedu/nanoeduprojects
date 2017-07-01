unit uNanoEduBaseMethodClass;

interface
uses windows,forms,dialogs,
SysUtils,
 {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
 globaltype;


type

TScanMethod=class

private

protected
 pathlength,
 data_in_Bufferlength,
 data_out_Bufferlength:integer;
 function  InitBuffers:integer; virtual; abstract;
 procedure SetPath;             virtual; abstract;
 procedure SetDataIn;           virtual; abstract;
 procedure NonLinearPath;       virtual; abstract;
 procedure LinearPath;          virtual; abstract;
 function  InitRegimeVars:integer; virtual; abstract;
 procedure StartDraw;           virtual; abstract;
 procedure StopDraw;            virtual; abstract;
 procedure GetData;             virtual; abstract;
 function   WriteToChannel(Id:integer; PData:pointer; n:integer):boolean;
 procedure SetJump;
 procedure SetPrimStep;
 procedure SetPathSpeed;        virtual;
 function  GetRS_XPeriods:apitype;
 function  GetRS_YPeriods:apitype;
 function  InitAlgorithmParamsFile:integer;     virtual;  abstract;
 function  CreateAlgorithmParamsFile:integer;   virtual;// abstract;
public
 procedure TurnOnFB;
 function  SetUsersParams:boolean;         virtual; abstract;
 procedure ScannerProtract;   // вытянуть
 procedure ScannerRetract;   // втянуть
 procedure TurnOffFB;
 procedure SetSpeed;          virtual;
 function  StartWork(const ScriptName:widestring):integer;
 function  FreeBuffers:integer;         virtual;
 function  StopWork:boolean;            virtual;
 Procedure WaitStopWork;
 Procedure ScanWorkDone;
 function    Launch:integer;      virtual;
 destructor  Destroy;             override;
 constructor Create;

 property  RS_XPeriods:apitype    read GetRS_XPeriods;
 property  RS_YPeriods:apitype    read GetRS_YPeriods;
 procedure PreviousPointCnt();
 function  GetLastError:datatype;
end;

implementation
uses
  Classes,globalvar,UNanoEduInterface, SIOCSPM, CSPMVar, MLPC_APILib_TLB,
  frNoFormUnitLoc,nanoeduhelp,RenishawVars,Ole2;

procedure TScanMethod.TurnOnFB;
begin
// API.FBENA:=0;
end;

procedure TScanMethod.TurnOffFB;
begin
//  API.FBENA:=1;
end;
procedure TScanMethod.ScannerProtract;
begin
if STMflg then API.ITRRES:=4
          else API.ITRRES:=MinDATATYPE;
    sleep(ApproachParams.ScannerDecay);
end;

procedure TScanMethod.ScannerRetract;
begin
    API.ITRRES:=0;
    sleep(ApproachParams.IntegratorDelay);
end;


procedure TScanMethod.SetSpeed;
begin
//Javacontrol.IsRunning(flgJavaRunning);
// if flgJavaRunning then
 begin
   SetPathSpeed;
   SetJump;
   SetPrimStep;
 end;
end;

procedure TScanMethod.SetPathSpeed;
var val:integer;
begin
// val:=round(2*((ScanParams.DiscrNumInMicroStep shl 16)/ScanParams.MicrostepDelay));
 val:=round ((1 shl 17) /ScanParams.MicrostepDelay) shl 14;
 SetCommonVar(U_VECTOR,val);
//  val:=round(2*((ScanParams.DiscrNumInMicroStep shl 16)/ScanParams.MicrostepDelayBW));
// SetCommonVar(U_VECTOR_BW,val);
end;
function  TScanMethod.CreateAlgorithmParamsFile:integer;
var HNDL:integer;
    icod:integer;
    LRec:integer;
//    StreamFile:TFileStream;
    filename:widestring;
 begin
  result:=0;
  LRec:=Sizeof(AlgParams);
  filename:=InitParamFileJavaPath+InitParamFileJava;
 if FileExists(FileName) then DeleteFile(FileName);
  try
  HNDL:=FileCreate(FileName);
   icod:=FileWrite(HNDL,AlgParams,LRec);
    if (icod<>LRec)    then
    begin
      NoFormUnitLoc.siLang1.MessageDlg('File write error. Maybe you have not rights to create files. Ask administrator',mtWarning,[mbOk],0);
      result:=1;
      exit;
    end;
  finally
      FileClose(HNDL);
  end;
end;
procedure TScanMethod.SetJump;
begin
 //SetCommonVar(adr88,1); //aJUMP=$88;
end;
function   TScanMethod.WriteToChannel(Id:integer; PData:pointer; n:integer):boolean;
var
hr:HResult;
 error:integer;
 fcount:integer;
begin
  result:=true;
  fCount:=0;
  repeat
   result:=true;
       hr:=arPCChannel[Id].ChannelWrite.Write(PData,n);   //as  IMLPCChannelWrite2 writewait;
     if Failed(hr) then
     begin
       inc(fcount);
       result:=false;
      {$IFDEF DEBUG}
       showmessage('error write  user parameters to channel='+inttostr(n));
     {$ENDIF}
     end
     else
    {$IFDEF DEBUG}
        Formlog.memolog.Lines.add('done sending  parameters');
    {$ENDIF}
  until  fcount<10 ;

end;
procedure TScanMethod.SetPrimStep;
begin
// SetCommonVar(adr84,unapitype(-ScanParams.DiscrNumInMicroStep)); //aPRIM_STEP_X=$84
// SetCommonVar(adr86,unapitype(-ScanParams.DiscrNumInMicroStep)); //aPRIM_STEP_Y=$86
// SetCommonVar(adr8C,unapitype(1));                               //aPRIM_STEP_ZX=$8C;
// SetCommonVar(adr8E,unapitype(1));                               //aPRIM_STEP_ZY=$8E;
end;


function TScanMethod.StartWork(const ScriptName:widestring):integer;
begin
  {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start work '+ScriptName);
    {$ENDIF}
   Result:=0;
  if ScanInit<>0 then        // copy initparameters file to the javamachine
                begin
                 NoFormUnitLoc.silang1.ShowMessage(strub2{'Error in ScanInit()'});
                 raise EDivByZero.Create('');
                 result:=3;
                 exit;
                end;

   case  LoadScript(ScriptName) of
  1: begin
      NoFormUnitLoc.silang1.MessageDlg(strub4+ScriptName,mtError ,[mbOK,mbHelp],IDH_Recording_scripts);
      Result:=1;
      exit;
     end;
  2: begin
      NoFormUnitLoc.silang1.MessageDlg(strub4+ScriptName+'!'+#13+strub5,mtError ,[mbOK,mbHelp],IDH_Recording_scripts);
      result:=1;
      exit;
    end;
            end;
     ScanWork;
end;

function TScanMethod.FreeBuffers:integer;
begin
 FreeMem(StopBuf);
 FreeMem(DoneBuf);
 FreeMem(DataBuf);
 result:=0;
end;

function TScanMethod.StopWork:boolean;
begin
result:=true;
if not ScanStop then  result:=ScanStop;
end;

Procedure TScanMethod.WaitStopWork;
begin
 (*     ScWorkThread.WaitFor;
        ScWorkThread.Destroy;
        ScWorkThread := nil;
  *)
end;

(*Procedure TScanMethod.WaitStopDraw;
begin
       ScDrawThread.WaitFor;
       ScDrawThreadActive := false;
       ScDrawThread:=nil;
end;
*)
destructor TScanMethod.Destroy();
begin    { TODO : 160606 }
    inherited ;
end;
function  TScanMethod.Launch:integer;
begin
 result:=0;
 InitRegimeVars;
if StartWork(AlgorithmJava)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
StartDraw;
end;

constructor TScanMethod.Create;
begin
 inherited ;   { TODO : 160606 }
// ScanData:=TExperiment.Create
end;

Procedure TScanMethod.ScanWorkDone;
var pval:PInteger;
     n:integer;
begin
(*       try
          PVal:=CoTaskMemAlloc(sizeof(Integer));
          pval^:= 1;
          n:=1;
          arPCChannel[ch_draw_done].Write.Write(pval,n); //drawdone
         finally
           CoTaskMemFree(pval);
        end;
        *)
end;


function  TScanMethod.GetRS_XPeriods:apitype;
begin
//  result:=GetCommonVar(adr92);  //aRSX_Periods=$92;
end;
function  TScanMethod.GetRS_YPeriods:apitype;
begin
 // result:=GetCommonVar(adr94);  //aRSY_Periods=$94;
end;



procedure  TScanMethod.PreviousPointCnt();
var LNX,LNY, FastAxisDir:apitype;
begin
// FastAxisDir:=GetCommonVar(adr96); //aRS_FastAxisDir=$96;
case ScanParams.ScanPath of
 OneX: begin
         LNx:=RS_XPeriods;
         lNy:= RS_YPeriods;
         if FastAxisDir=2 then
                begin
                 LNx:=(ReniShawParams.NParts_inStep*ScanParams.NX div ReniShawParams.stepScale)-LNx;
                 if ReniShawParams.stepScale<>1 then inc(LNx,2);  // Look in scripts

                end;
         if ScanParams.ScanMethod in ScanmethodSetOneL then
         begin
           Lny:=0;
         end;

      end;
 OneY: begin
         LNx:=RS_XPeriods;
         lNy:= RS_YPeriods;
         if FastAxisDir=2 then
                begin
                  LNy:=(ReniShawParams.NParts_inStep*ScanParams.NY div ReniShawParams.stepScale)-LNy;
                   if ReniShawParams.stepScale<>1 then inc(LNy,2);  //  Look in scripts
                end;
         if ScanParams.ScanMethod in ScanmethodSetOneL then
         begin
           Lnx:=0;
         end;
      end;

end;
  with ScanParams do
     begin
       XPrevious:=XBegin+LNx* RenishawParams.Period_nm{+ScanParams.Xshift};
       YPrevious:=YBegin+LNy* RenishawParams.Period_nm{+ScanParams.Yshift};
     end;
end;

 function  TScanMethod.GetLasterror:apitype;
 begin
//   result:= GetCommonVar(adr88);  //aJUMP
 end;
end.
