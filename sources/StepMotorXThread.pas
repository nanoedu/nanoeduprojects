unit StepMotorXThread;

interface

uses
  Classes;

type
  TEtchingStep = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure EtchingStep.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ EtchingStep }

procedure TEtchingStep.Execute;
begin
  { Place thread code here }
   while (not Terminated) do
   begin
    	NanoEdu.EtcherApproach.NSteps:=EtchingParams.StepsNumb;
     while(SMZ_STEP!=0)
     do sleep(EtchingParams.StepDelay);
   end;
end;{finally}


end.
