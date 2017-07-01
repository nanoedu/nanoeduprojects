//151102 new version
unit mScanRate;

interface


procedure SetScanRate(L:double;ScanDiscrNumb,NPoints:integer;var Rate:single; var Delay:integer);
procedure SetScanRateFine(L:double;ScanDiscrNumb,NPoints:integer);
procedure CalcScanRateDriverLimit(L:double; NPoints:integer; parameter:single;  var Rate:single; var RateBW:single);
// L - nm, Scan length (X or Y in the dependence of scan direction);
// FieldLen - nm, Max size of scaning field in given direction;
// NPoints - Nx or Ny (depends of scan direction);
// Hardware Options
// They have to be in GlobalDefs;
var
ScanFreq:double;  // 1/sec, Hz
tMicroStepNmb: integer;       // Number of microsteps between
                              //two measured points (in one Step);
//tMicroStepDelay:single;       //milisec
NDiscrBetweenPoints:integer;  // Number of discrets between two points;
const

//MaxDiscrNumb= $8000;        // Maximum number of discrets;
//TimMicroStep=0.005;         // milisec, Time of one microstep;
//TimMeasurePoint:single=0.01;// edited 19/12/16  //0.022 ;   // milisec, Time of measuring in one point;    //0,02

                      // then TMova:=TScan;
//MinValidMicroStepDelay=0.005;//0.001; // milisec
//MinValidMicroStepDelaySEM=0.001;
MaxValidMicroStepDelay=65; // milisec
 var
 MinValidMicroStepDelay:single=0.005;//0.001; // milisec
 MinValidMicroStepDelaySEM:single=0.005;
implementation

uses CSPMVar;

CONST  alfthr=0.1;//0.01;          // if Sum(TMeasurePoint)/TScan <alfthr


procedure CalcScanRateDriverLimit(L:double; NPoints:integer; parameter:single;  var Rate:single; var RateBW:single);
var rateLimit:single;
    lineTime_s:single;
begin
// parameter =  NPoints/lineTime_s;   - такой смысл имеет параметр
  lineTime_s := NPoints/parameter;
  rateLimit :=L/lineTime_s;
  if (Rate > rateLimit)     then Rate:= rateLimit;
  if (RateBW>3*rateLimit)   then RateBW:=3*rateLimit;
end;


procedure SetScanRate(L:double;ScanDiscrNumb,NPoints:integer; var Rate:single; var Delay:integer);
var
 {Scan Rate - physical rate of scanner moving}
 MaxScanRate1,MaxScanRate2:Single;
 TimScan,TimFrame: single; //sec, Time for one scan;
 TimMove: single; //sec,  Time for scanner moving in one scan;
 NMicroStep: integer; // Number of microsteps in one scan;
 alf: double;         //koefficient;
 tMicroStepDelay:single;       //milisec
begin
 {Calculate max possible Scan Rate}
   MaxScanRate1:=1000*L/(NPoints*(ScanParams.TimMeasurePoint)+ScanDiscrNumb*(ScanParams.TimMicroStep+MinValidMicroStepDelay));
   MaxScanRate2:=1000*L/(NPoints*(ScanParams.TimMeasurePoint+ScanParams.TimMicroStep+MinValidMicroStepDelay));
 NDiscrBetweenPoints:=ScanDiscrNumb div NPoints;
 TimScan:=L/Rate;    {sec}
 alf:=ScanParams.TimMeasurePoint*NPoints/TimScan/1000;
 if (alf>alfthr) then    TimMove:=TimScan-ScanParams.TimMeasurePoint*NPoints/1000 {sec}
                 else    TimMove:=TimScan;         //TimMove - time of one way moving
 if  (TimMove<=(ScanParams.TimMicroStep+MinValidMicroStepDelay)*NPoints/1000) then  // sec
     begin
   (*    if HardWareOpt.XYtune='Rough' then
       begin
        tMicroStepDelay:=MinValidMicroStepDelay;
        NMicroStep:=ScanDiscrNumb;
        tMicroStepNmb:=NDiscrBetweenPoints;
        ScanParams.DiscrNumInMicroStep:=1;
        Rate:=MaxScanRate1;
       end
       else      *)
       begin
        tMicroStepDelay:=MinValidMicroStepDelay;
        NMicroStep:=NPoints;
        tMicroStepNmb:=1;
        ScanParams.DiscrNumInMicroStep:=round(ScanDiscrNumb/NPoints);
        NDiscrBetweenPoints:=ScanParams.DiscrNumInMicroStep;
        Rate:=MaxScanRate2;
       end;
        Delay:=round(1000*tMicrostepDelay);
       exit;                  {Scanning with Max Valid Scan Rate}
     end;
  NMicroStep:=round(1000*TimMove/(ScanParams.TimMicroStep+MinValidMicroStepDelay)); // Number of microsteps,which can be done;
  if (NMicroStep>=ScanDiscrNumb) then
   begin
        tMicroStepDelay:=(1000*TimMove-ScanDiscrNumb*ScanParams.TimMicroStep)/ScanDiscrNumb;
       if  tMicroStepDelay<MinValidMicroStepDelay then
           begin
            tMicroStepDelay:=MinValidMicroStepDelay;
            Rate:=MaxScanRate1;
           end;
        ScanParams.DiscrNumInMicroStep:=1;
        tMicroStepNmb:=ScanDiscrNumb div NPoints;
  end
  else
  begin
  (* if HardWareOpt.XYtune='Rough' then
       begin
        tMicroStepDelay:=MinValidMicroStepDelay;
        NMicroStep:=ScanDiscrNumb;
        tMicroStepNmb:=NDiscrBetweenPoints;
        ScanParams.DiscrNumInMicroStep:=1;
        Rate:=MaxScanRate1;
        Delay:=round(1000*tMicrostepDelay);
        exit;
       end
       else      //fine  *)
       begin
        ScanParams.DiscrNumInMicroStep:=round(ScanDiscrNumb/NMicrostep+0.5); //ceil
        NMicroStep:=ScanDiscrNumb div ScanParams.DiscrNumInMicroStep;  // Really doing
       //  number of microsteps
        tMicroStepNmb:=NMicroStep div NPoints;
        if  (tMicroStepNmb<=1) then
         begin
           NMicroStep:=NPoints;
           tMicroStepNmb:=1;
           TimMove:=0.001*ScanParams.TimMicroStep*NMicrostep;   //sec
           TimScan:=TimMove+0.001*ScanParams.TimMeasurePoint*Npoints;
           tMicroStepDelay:=MinValidMicroStepDelay;
           NMicroStep:=NPoints;
           tMicroStepNmb:=1;
           ScanParams.DiscrNumInMicroStep:=round(ScanDiscrNumb/NPoints);
           NDiscrBetweenPoints:=ScanParams.DiscrNumInMicroStep;
           Rate:=MaxScanRate2;
            Delay:=round(1000*tMicrostepDelay);
           exit;      {Scanning with Max Valid Scan Rate}
        end;
       tMicroStepDelay:=(TimMove*1000-ScanParams.TimMicroStep*NMicrostep)/NMicroStep;//milisec ;
       if  tMicroStepDelay<MinValidMicroStepDelay then  tMicroStepDelay:=MinValidMicroStepDelay
      end;
     end;
      if tMicroStepDelay>MaxValidMicroStepDelay then
      begin
       tMicroStepDelay:=MaxValidMicroStepDelay;  // Scan with min valid Scan Rate
       Rate:=1000*L/(TMicrostepNmb*NPoints*(ScanParams.TimMicroStep+TMicroStepDelay)+ScanParams.TimMeasurePoint*NPoints);
      end;
     TimScan:=0.001*(TMicrostepNmb*NPoints*(ScanParams.TimMicroStep+TMicroStepDelay)+ScanParams.TimMeasurePoint*NPoints); //sec
     if flgUnit=Terra then TimScan:=TimScan+0.001*(2*ScanParams.TimMeasurePoint+ScanParams.TerraTDelay)*NPoints;
     TimFrame:=TimScan*2*ScanParams.NY;
//  with ScanParams do
  begin
   Delay:=round(1000*tMicrostepDelay);// mks;
   if Delay=0 then Delay:=1;
  end;
end; { SetScanRate}

procedure SetScanRateFine(L:double;ScanDiscrNumb,NPoints:integer);
var
 {Scan Rate - physical rate of scanner moving}
 MaxScanRate1,MaxScanRate2:Single;
 TimScan,TimFrame: single; //sec, Time for one scan;
 TimMove: single; //sec,  Time for scanner moving in one scan;
 NMicroStep: integer; // Number of microsteps in one scan;
 alf: double;         //koefficient;
 tMicroStepDelay:single;
begin
 {Calculate max possible Scan Rate}
   MaxScanRate1:=1000*L/(NPoints*(ScanParams.TimMeasurePoint)+
                        ScanDiscrNumb*(ScanParams.TimMicroStep+MinValidMicroStepDelay));
 NDiscrBetweenPoints:=ScanDiscrNumb div NPoints;
 TimScan:=L/ScanParams.ScanRate;    {sec}
 alf:=ScanParams.TimMeasurePoint*NPoints/TimScan/1000;
 if (alf>alfthr) then    TimMove:=TimScan-ScanParams.TimMeasurePoint*NPoints/1000 {sec}
                 else    TimMove:=TimScan;         //TimMove - time of one way moving
   if  (TimMove<=0) then
     begin
        tMicroStepDelay:=MinValidMicroStepDelay;
        NMicroStep:=ScanDiscrNumb;
        tMicroStepNmb:=NDiscrBetweenPoints;
        ScanParams.DiscrNumInMicroStep:=1;
        ScanParams.ScanRate:=MaxScanRate1;
       exit;                  {Scanning with Max Valid Scan Rate}
     end;

  NMicroStep:=round(1000*TimMove/(ScanParams.TimMicroStep+MinValidMicroStepDelay)); // Number of microsteps,which can be done;
  if (NMicroStep>=ScanDiscrNumb) then
   begin
        tMicroStepDelay:=(1000*TimMove-ScanDiscrNumb*ScanParams.TimMicroStep)/ScanDiscrNumb;
       if  tMicroStepDelay<MinValidMicroStepDelay then
           begin
            tMicroStepDelay:=MinValidMicroStepDelay;
            ScanParams.ScanRate:=MaxScanRate1;
           end;
        ScanParams.DiscrNumInMicroStep:=1;
        tMicroStepNmb:=ScanDiscrNumb div NPoints;
  end
  else
  begin
        tMicroStepDelay:=MinValidMicroStepDelay;
        NMicroStep:=ScanDiscrNumb;
        tMicroStepNmb:=NDiscrBetweenPoints;
        ScanParams.DiscrNumInMicroStep:=1;
        ScanParams.ScanRate:=MaxScanRate1;
        exit;
  end;
    if tMicroStepDelay>MaxValidMicroStepDelay then
      begin
       tMicroStepDelay:=MaxValidMicroStepDelay;  // Scan with min valid Scan Rate
       ScanParams.ScanRate:=1000*L/(TMicrostepNmb*NPoints*(ScanParams.TimMicroStep+TMicroStepDelay)+ScanParams.TimMeasurePoint*NPoints);
      end;
     TimScan:=0.001*(TMicrostepNmb*NPoints*(ScanParams.TimMicroStep+TMicroStepDelay)+ScanParams.TimMeasurePoint*NPoints); //sec
     TimFrame:=TimScan*2*ScanParams.NY;
  with ScanParams do
  begin
   MicrostepDelay:=round(1000*tMicrostepDelay);// mks;
   if MicrostepDelay=0 then MicrostepDelay:=1;
  end;
  end; { SetScanRate}

  initialization
end.
