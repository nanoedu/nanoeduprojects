unit uEtchingClasses;

interface
uses   classes, windows,sysutils,UNanoEduBaseClasses;
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

implementation
uses    UNanoeduInterface;
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

end.
