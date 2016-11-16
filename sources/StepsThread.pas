//020204
unit StepsThread;

interface

uses
  Classes,SysUtils,Windows,Graphics,QControls,Dialogs,SystemConfig,SioCSPM,GlobalVar;

type
  TStepsThread = class(TThread)
  private
    { Private declarations }
      StepCount:integer;
      FlgStatusStep:word;
  protected
      procedure Execute; override;
      procedure  StepsUpdate;
      procedure  Steps;
  public
      constructor Create;
      destructor Destroy; override;
  end;

implementation

uses fApproach;

constructor TStepsThread.Create;
begin
  inherited Create(True);
   FreeOnTerminate:=true;
   StepCount:=0;
   Priority := TThreadPriority(tpNormal);
   Suspended := False;
end;

destructor TStepsThread.Destroy;
var ThreadFlg:integer;
begin
  inherited destroy;
 ThreadFlg:=FlgStatusStep;
  PostMessage(Approach.Handle,wm_ThreadStepsDoneMsg,ThreadFlg,0);
end;

procedure  TStepsThread.StepsUpdate;
begin
  with Approach do
  begin
     StepCount:=StepCount+nsteps;
     edStepsCounter.Text:=Format('%d',[-StepCount]);
  end;
end;

procedure  TStepsThread.Steps;
var i:integer;
begin
         FlgStatusStep:=0;
   //    Critical.Enter;
        SetCommonVar(StatusStep,FlgStatusStep);
        SetCommonVar(StatusApproach,word(Start));
        repeat  //waiting for the end one step
          FlgStatusStep:=getCommonVar(StatusStep);
        until (FlgStatusStep<>0);
     //   Critical.Leave;
          case FlgStatusStep of
      3: begin  //ok
              for i:=0  to 5 do beep;
              FlgApproachOK:=True;
              FlgStopApproach:=True;
            end;
      2: begin   //too close
            for i:=0  to 5 do beep;
             setCommonVar(ITR_RES,0);
             FlgStopApproach:=True;
             FlgApproachOK:=false;
          end;    //too close
      4: begin    //out boundary
            for i:=0  to 5 do beep;
            FlgStopApproach:=True;
            FlgApproachOK:=false
         end;
              end;                //case

end;

procedure TStepsThread.Execute;
var val:word;
begin
  while (not Terminated) and (not FlgStopApproach) do
   begin
      Steps;
      Synchronize(StepsUpdate);
   end;
   FlgStopApproach:=True;
end;
end.
