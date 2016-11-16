unit MLPCVariablesThread;

interface

uses
  Classes,windows,SysUtils,Globaltype,MLPC_APILib_TLB,comobj,activex,
  NL3LFBLib_TLB;

type
  TMLPCVariablesThread = class(TThread)
  private
    { Private declarations }
  protected
  logstr:string;
 //  NanoeduPC_PID:ILFB_PID;
    function  fSetPIDParameters:boolean;
    procedure Log;
    procedure Execute; override;
  public
    constructor Create;
    destructor  Destroy; override;
  end;

  var
   VarsThread:TMLPCVariablesThread;
   VarsThreadActive:Boolean;

implementation
 uses dialogs,CspmVar,GlobalVar,
     {$IFDEF DEBUG}
       frDebug,
      {$ENDIF}
      GlobalDCl, SioCSPM,MLPC_API2Lib_TLB,UNanoEduBaseClasses;


{ TMLPCVariablesThread }
constructor TMLPCVariablesThread.Create;
begin
 inherited Create(True);
    FreeOnTerminate:=true;
    Priority := TThreadPriority(tpNormal);
    Suspended := false;// Resume;
end;

destructor  TMLPCVariablesThread.Destroy;
begin
 VarsThreadActive:=False;
 inherited destroy;
end;

procedure TMLPCVariablesThread.Execute;
begin
  CoInitializeEx(nil,COINIT_MULTITHREADED);
 // fSetPIDParameters;
  NanoEdu.SetPoint:=ApproachParams.SetPoint;
  CoUnInitialize;
  Self.Terminate;
end;

function   TMLPCVariablesThread.fSetPIDParameters:boolean;
 var hr:HRESULT;
      IU:IUnknown;
begin
// Nanoedu.SetPIDParameters;
 if Assigned(SchematicControl) then
     begin
       SchematicControl.QueryLFB(WideString('pid'),IU);

       NanoeduPC_PID:= (IU as ILFB_PID);
       {$IFDEF DEBUG}
               logstr:='*********ILFB_PID';
               Synchronize(log);

       {$ENDIF};
       with PIDParams do
       NanoeduPC_PID.Write(dT,Te,Td,Ti);
       {$IFDEF DEBUG}
               logstr:='****WRITE PID Params OK';
               Synchronize(log);
       {$ENDIF};
     end;
end;

procedure TMLPCVariablesThread.log;
begin
      {$IFDEF DEBUG}
           Formlog.memolog.Lines.add(logstr);
      {$ENDIF}
end;

end.
