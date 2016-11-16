unit uBaseMethodClass;

interface
uses windows,forms,dialogs, SysUtils,GlobalType;


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
 Procedure InitRegimeVars;      virtual; abstract;
 procedure StartDraw;           virtual; abstract;
 procedure StopDraw;            virtual; abstract;
 procedure GetData;             virtual; abstract;
 procedure SetJump;
 procedure SetPrimStep;
 procedure SetPathSpeed;        virtual;
public
 procedure TurnOnFB;
 procedure TurnOffFB;
 procedure SetSpeed;          virtual;
 function  StartWork(const ScriptName:string):integer;
 procedure FreeBuffer;
 Procedure StopWork;            virtual;
 Procedure WaitStopWork;
 Procedure ScanWorkDone;
 function  Launch:integer;      virtual; abstract;
 destructor  Destroy;          override;
 constructor Create;
end;

implementation
uses
  classes,UNanoEduInterface, SIOCSPM, CSPMVar, GlobalVar,
  ScanWorkThread;

procedure TScanMethod.TurnOnFB;
begin
  API.FBENA:=0;
end;

procedure TScanMethod.TurnOffFB;
begin
  API.FBENA:=1;
end;

procedure TScanMethod.SetSpeed;
begin
   SetPathSpeed;
   SetJump;
   SetPrimStep;
end;

procedure TScanMethod.SetPathSpeed;
begin
  API.PATHSPD:=ScanParams.MicrostepDelay;
  API.PATHSPD_BW:=ScanParams.MicrostepDelayBW;
end;

procedure TScanMethod.SetJump;
begin
  SetCommonVar(aJUMP,1);
end;

procedure TScanMethod.SetPrimStep;
begin
 SetCommonVar(aPRIM_STEP_X,word(-ScanParams.DiscrNumInMicroStep));
 SetCommonVar(aPRIM_STEP_Y,word(-ScanParams.DiscrNumInMicroStep));
 SetCommonVar(aPRIM_STEP_ZX,word(1));
 SetCommonVar(aPRIM_STEP_ZY,word(1));
end;


function TScanMethod.StartWork(const ScriptName:string):integer;
begin
   Result:=0;
   if BufRegister<>0 then
                begin
                   ShowMessage('Unable to register buffers!Reload Controller.');
                   raise EDivByZero.Create('');
                   result:=2;
                   exit
                end;
   if LoadScript(ScriptName)<>0 then
                   begin
                     result:=1;
                     exit;
                   end;


	 if ScanStart<>0 then                             {Запуск функции start()}
                   begin
                    ShowMessage('Unable to execute function start()');
                    raise EDivByZero.Create('');
                    result:=2;
                    exit;
                   end;
	f.Pin:= data_in;
	f.in_count:=data_in_BufferLength;
	f.Ppath:= data_path;     // --> SetPath
	f.Pout:=data_out;
	f.out_count:=data_out_BufferLength;
      if ScanInit(@f)<>0 then
                begin
                 ShowMessage('Error in ScanInit()');
                 raise EDivByZero.Create('');
                 result:=3;
                 exit;
                end;
   ScWorkThread := TScanWorkThread.Create;
end;

procedure TScanMethod.FreeBuffer;
begin
 f.Pin:=nil;
 f.POut:=nil;
 f.PPath:=nil;
 FreeMem(Data_out);
 FreeMem(Data_path);
 FreeMem(Data_in);
end;

Procedure TScanMethod.StopWork;
begin
 ScanStop;
end;

Procedure TScanMethod.WaitStopWork;
begin
        ScWorkThread.WaitFor;
        ScWorkThread.Destroy;
        ScWorkThread := nil;
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

constructor TScanMethod.Create;
begin
 inherited ;   { TODO : 160606 }
// ScanData:=TExperiment.Create
end;

Procedure TScanMethod.ScanWorkDone;
begin
       if ScanDone<>0 then                                     {Завершение сканирования}
                begin
                        ShowMessage('Error in ScanDone()');
                        raise EDivByZero.Create('');
                end;
        BufDeRegister;
        GetCurProc(P_READY);
end;

end.
