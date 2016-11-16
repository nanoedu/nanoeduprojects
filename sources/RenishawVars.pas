unit RenishawVars;

interface
uses GlobalType, GlobalDcl,Windows,Forms,Messages,Classes,
       ShellApi,  SysUtils, Dialogs, inifiles,
//ntspb
       GlobalScanDataType;

const XFast :string = 'XFast';
const XSlow :string = 'XSlow';
const YFast :string = 'YFast';
const YSlow :string = 'YSlow';
const Z     :string = 'Z';

// ReniShow
//  const  aFlgFinish=$88;//$8A ;
//  const  aNoise_W=$92;
//  const  aPULSES_CNT=$94;
//  const  aX_POINTS = $96;
//  const  aY_POINTS = $98;
//  const  aSTEP_SCALE = $9A;
//  const  aScannerDecay = $9C;
 // const  aslPULSES_CNT = $9E;    // for XYAngle;


Type RRenishawParams=packed record
     flgXSlow:boolean;
     flgSteponNets:boolean;
     flgscriptname:byte; //1 -x renis nets, 2-; 3;
     delt_discr:datatype;
     noiseW_discr:datatype;
     Length_discr:datatype;
     microstep_Delay:datatype;
     XBeginDiscr,YBeginDiscr:datatype;
     NX,NY:datatype;
     Axis:datatype;       // X = 0, Y = 1, Z = 2
     stepScale:datatype;
     NParts_inStep:datatype; // =1, if StepXY <= RS size
                            // >1, if StepXY > RS size
     curveScale:datatype;
     FrontsDistnm:datatype;
     ReniShawSlowCoord:array of smallint;
     RenishawPeriod:datatype;          //=100nm
     ReniShawScale:single;     // = 2.4
     Period_nm:single;
     DisperceMax:single;
     LineToLineTimemk:integer;
     SlowAxisScanRate:single; // (nm/s)
     flgLineToLineTime:boolean;
  //   XshiftBRS,YshiftBRS:single; //nm shift zero point coordinate for renishaw
end;

Type RRenishawStendParams=packed record
     flgSmooth:boolean;
     flgAutosave:boolean;
     flgLinearizationOn:boolean;
     flgXFast_forAngle:Boolean;
     delt_discr:datatype;
     noiseW_discr:datatype;
     LengthFast_discr, LengthSlow_discr, LengthZ_discr:datatype;
    // microstepFast_Delay, microstepSlow_Delay:integer;
     RateFastAxis, RateSlowAxis: datatype;  // nm/s
     microstep_Delay:datatype;              // ms
     XBeginDiscr,YBeginDiscr:datatype;
     YBeginDiscr_forXYAngle:datatype;
     LengthAcross_discr:datatype;
     NX,NY:integer;
     TrainFastLines,TrainSlowLines:integer;
     curveScale:integer;
      NLinearTestPoints:integer;
     TimeProgressMax_s:integer;
     HistPulseKoordnm,
     HistPulseInd,
     HistItemsNmb,
     HistLinesLength,
     HistLinesNmb:integer;
     RenishawPeriod:datatype;
     ReniShawScale:single;
     TransformkoefX, TransformkoefY, TransformkoefZ :single;
     SensX, SensY, SensZ:single;
     Period_nm:single;
     LinearJumpsArray: array of integer;
     DisperceMax:single;

end;

Type RRenishawOscParams=packed record
     AxisName:string;
     delt_discr:datatype;
     noiseW_discr:datatype;
     LengthFast_discr, LengthSlow_discr, LengthZ_discr:datatype;
    // microstepFast_Delay, microstepSlow_Delay:integer;
     RateFastAxis, RateSlowAxis: datatype;  // nm/s
     microstep_Delay:datatype;              // ms
     XBeginnm,YBeginnm:datatype;
     MovingDirection:word;
     NX,NY:integer;
     curveScale:integer;
     HistPulseKoordnm,
     HistPulseInd,
     HistItemsNmb,
     HistLinesLength,
     HistLinesNmb:integer;
    // RenishawPeriod:datatype;
    // ReniShawScale:single;
     TransformkoefX, TransformkoefY, TransformkoefZ :single;
     SensX, SensY, SensZ:single;
     Period_nm:single;
  end;

const WM_ReniShawThreadDoneMsg = WM_User + 23;
var
  FlgRenishawUnit:boolean;
  FlgRenishawUnitExists:boolean;
  FlgRenishawCorrection:boolean;
  flgMoveToBeginbyRS:boolean;  //follow drift renishaw
  ReniShawStepScale:integer;
  RenishawLinDirectory:string;
  ReniShawFrontsImg:TData;
  ReniShawParams:RReniShawParams;
  RenishawStendParams:RRenishawStendParams;
  ReniShawOscParams:RRenishawOscParams;
  LastDrawnPoint:integer;  //

    procedure RenishawParamsDef;
    procedure RenishawStendParamsDef;
    procedure ReniShawOscParamsDef;
 // Renishaw correction procedures
    procedure ReniShawDACCorrect2D(var zData:TData; DACData:TData; mode:integer; stepScale:integer;period:single);
    procedure ReniShawCreateFrontsMap(ExperimData:TData; mode:integer; stepScale:integer);
    procedure ReniShawFreeFrontsMap;
    procedure Smooth1(var Dat:ArraySpline; N,S:integer);
    procedure ReniShawFrontsSmooth();
    procedure ReniShawSlowAxisCorr(var ZData:TData; DACData:TData; mode:integer; stepScale:integer;period:single);
    procedure SaveRenishawParams;
    procedure RenishawParamsLast;

implementation
uses CSPMVar, GlobalVar, GlobalFunction, UScannerCorrect, frNoFormUnitLoc;

procedure RenishawParamsDef;
begin
  with RenishawParams do
   begin
     delt_discr:=1;
     microstep_Delay:=500;     //ms
     XBeginDiscr:=500;   //discr
     YBeginDiscr:=500;   //discr
     stepScale:=1;
     NParts_inStep:=1;
     Renishawperiod:=100;
     if RenishawPeriod=100 then    ReniShawParams.noiseW_discr:=20
                           else    ReniShawParams.noiseW_discr:=5;
     ReniShawScale:=2.4;
     Period_nm:=Renishawperiod*ReniShawScale;
     flgSteponNets:=false;
     LineToLineTimemk:=6000;
   end;
end;

procedure ReniShawStendParamsDef;
begin
  with RenishawStendParams do
   begin
     Renishawperiod:=100;
     ReniShawScale:=1;
     Period_nm:=Renishawperiod*ReniShawScale;
     delt_discr:=1;
     noiseW_discr:=10;
     LengthFast_discr:=10000;
     LengthSlow_discr:=10000;
     LengthZ_discr:=10000;
     LengthAcross_discr:=3000;
     RateFastAxis:=8000;
     RateSlowAxis:=16000;
     microstep_Delay:=300;  // To avoid non-definity
     XBeginDiscr:=50;
     YBeginDiscr:=50;
     YBeginDiscr_forXYAngle:=1500;  //!!!!!
     TrainFastLines:=2;
     TrainSlowLines:=2;
     curveScale:=8;
     flgSmooth:=True;
     flgLinearizationOn:=False;
     NLinearTestPoints:=100;
     HistPulseKoordnm:=1000;
     HistItemsNmb:=5;
     HistLinesLength:=1500;
     HistLinesNmb:=20;
     flgXFast_forAngle:=True;

    //   Znm_d:=CSPMSignals[7].MaxVal/(SensitivZ*UFBMaxOut*AMPGainZ); //transfer nm->discret
    TransformkoefZ:=CSPMSignals[7].MaxDiscr/(HardWareOpt.UFBMaxOut*HardWareOpt.AMPGainZ);
    TransformkoefY:=(CSPMSignals[9].MaxDiscr-CSPMSignals[9].MinDiscr)/((CSPMSignals[9].MaxV-CSPMSignals[9].MinV)*HardWareOpt.AMPGainY);    // nm-> discr
    TransformkoefX:=(CSPMSignals[8].MaxDiscr-CSPMSignals[8].MinDiscr)/((CSPMSignals[8].MaxV-CSPMSignals[8].MinV)*HardWareOpt.AMPGainX);    // nm-> discr
   end;
end;
procedure ReniShawOscParamsDef;
begin
  with RenishawOscParams do
   begin
     AxisName:=XFast;
    // Renishawperiod:=100;
    // ReniShawScale:=2.45;
   //  Period_nm:=Renishawperiod*ReniShawScale;
     delt_discr:=1;
     noiseW_discr:=10;
     LengthFast_discr:=30000;
     LengthSlow_discr:=10000;
     LengthZ_discr:=30000;
     MovingDirection:=0;
     RateFastAxis:=8000;
     RateSlowAxis:=16000;
     microstep_Delay:=300;  // To avoid non-definity
     XBeginnm:=1000;
     YBeginnm:=1000;

     curveScale:=8;

     HistPulseKoordnm:=1000;
     HistItemsNmb:=5;
     HistLinesLength:=1500;
     HistLinesNmb:=20;


    //   Znm_d:=CSPMSignals[7].MaxDiscr/(SensitivZ*UFBMaxOut*AMPGainZ); //transfer nm->discret
    TransformkoefZ:=CSPMSignals[7].MaxDiscr/(HardWareOpt.UFBMaxOut*HardWareOpt.AMPGainZ);
    TransformkoefY:=(CSPMSignals[9].MaxDiscr-CSPMSignals[9].MinDiscr)/((CSPMSignals[9].MaxV-CSPMSignals[9].MinV)*HardWareOpt.AMPGainY);    // nm-> discr
    TransformkoefX:=(CSPMSignals[8].MaxDiscr-CSPMSignals[8].MinDiscr)/((CSPMSignals[8].MaxV-CSPMSignals[8].MinV)*HardWareOpt.AMPGainX);    // nm-> discr
 end;
end;

procedure  ReniShawDACCorrect2D(var zData:TData; DACData:TData; mode:integer; stepScale:integer;period:single);
var i,j,i1:integer;
    MeasuresDiscrLine,ZValues, RSFrontsCoord:ArraySpline;
    RSFrontsCoordnm,pointsCoordnm:ArraySpline;
    pointsCnt:integer;
    nX,nY, val0,val:integer;
    A,B,C: ArraySpline;
    Stepnm, NewPnm:single;
    Pdiscr:integer;
    FrontsN:integer;
    AverZ:integer;
begin
    nX:=DACData.Nx;
    nY:=DACData.Ny;
    if mode=1 then dec(nY) else dec(Nx);
    AverZ:=round(zData.DataMean);

      if mode=1 then   begin
                         FrontsN:=ny div stepscale;
                         Stepnm:=zData.YStep;
                       end
                else  begin
                         FrontsN:=nx div stepscale ;    // X Mode
                         Stepnm:=zData.XStep;
                      end;
    if stepscale>1 then inc( FrontsN);

    if mode=1 then
      begin
      for j:=0 to nX - 1 do
        begin
            pointsCnt:=1;

            if  stepscale>1 then
                 RSFrontsCoordnm[1]:=period{240}/stepscale
               else  RSFrontsCoordnm[1]:=0;

          for i1:=0 to FrontsN-1 do
            begin
              if i1>0 then
                 RSFrontsCoordnm[i1+1]:=period{240}*(i1);
              RSFrontsCoord[i1+1]:=ReniShawFrontsImg.data[j,i1];
            end;
           // Smooth1(RSFrontsCoord, FrontsN,3);
           Spline(FrontsN,RSFrontsCoord,RSFrontsCoordnm,A,B,C);
          for i := 0 to nY - 1 do
            begin
              val:= DACData.Data[j,i];
              if val<>val0 then
                begin
                   if val<0  then
                       MeasuresDiscrLine[pointsCnt]:=-val
                    else   // val>0
                      MeasuresDiscrLine[pointsCnt]:=val;
                   val0:=val;
                   ZValues[pointsCnt]:= ZData.Data[j,i];
                   inc( pointsCnt);
                  end;   //  val<>val0
            end;  //i

        dec(pointsCnt);
         if MeasuresDiscrLine[1]<RSFrontsCoord[1] then MeasuresDiscrLine[1]:=RSFrontsCoord[1];
         for I1 := 1 to pointsCnt do
            begin
              pointsCoordnm[i1]:=0;
            end;
        for I1 := 1 to pointsCnt do
            begin

              pointsCoordnm[i1]:=round(SEVAL(FrontsN,MeasuresDiscrLine[i1],RSFrontsCoord,RSFrontsCoordnm,A,B,C));
            end;
        Spline(pointsCnt,pointsCoordnm,ZValues,A,B,C);
        NewPnm:=0;
        if stepscale>1 then  NewPnm:=stepnm;

        for I1 := 0 to nY-1 do
          begin
             if (NewPnm<pointsCoordnm[1]) or (NewPnm>pointsCoordnm[pointsCnt]) then
                ZData.Data[j,i1]:=AverZ
             else ZData.Data[j,i1]:=round(SEVAL(pointsCnt,NewPnm,pointsCoordnm,ZValues,A,B,C));
             NewPnm:=NewPnm+stepnm;
          end;
        end;   // j
       end // mode=1
       else // mode=0
       begin
        for i:=0 to ny - 1 do
        begin
            pointsCnt:=1;

            if  stepscale>1 then  RSFrontsCoordnm[1]:=period{240}/stepscale
                            else  RSFrontsCoordnm[1]:=0;

          for i1:=0 to FrontsN-1 do
            begin
              if i1>0 then   RSFrontsCoordnm[i1+1]:=period{240}*(i1);
              RSFrontsCoord[i1+1]:=ReniShawFrontsImg.data[i1,i];
            end;
           // Smooth1(RSFrontsCoord, FrontsN,3);
           Spline(FrontsN,RSFrontsCoord,RSFrontsCoordnm,A,B,C);
          for j := 0 to nX - 1 do
            begin
              val:= DACData.Data[j,i];
              if val<>val0 then
                begin
                   if val<0  then  MeasuresDiscrLine[pointsCnt]:=-val
                             else MeasuresDiscrLine[pointsCnt]:=val;  // val>0
                   val0:=val;
                   ZValues[pointsCnt]:= ZData.Data[j,i];
                   inc( pointsCnt);
                  end;   //  val<>val0
            end;  //i
        dec(pointsCnt);
    if MeasuresDiscrLine[1]<RSFrontsCoord[1] then MeasuresDiscrLine[1]:=RSFrontsCoord[1];
       for I1 := 1 to pointsCnt do
            begin
              pointsCoordnm[i1]:=0;
            end;
        for I1 := 1 to pointsCnt do
            begin
              pointsCoordnm[i1]:=round(SEVAL(FrontsN,MeasuresDiscrLine[i1],RSFrontsCoord,RSFrontsCoordnm,A,B,C));
            end;
        Spline(pointsCnt,pointsCoordnm,ZValues,A,B,C);
        NewPnm:=0;
        if stepscale>1 then  NewPnm:=stepnm;

        for I1 := 0 to nX-1 do
          begin
             if (NewPnm<pointsCoordnm[1]) or (NewPnm>pointsCoordnm[pointsCnt]) then
                ZData.Data[i1,i]:=AverZ
             else ZData.Data[i1,i]:=round(SEVAL(pointsCnt,NewPnm,pointsCoordnm,ZValues,A,B,C));
             NewPnm:=NewPnm+stepnm;
          end;
        end;   // j
       end; // mode=0

     //  AverZ:=round(zData.DataMean);
       if mode=0 then
         for I := 0 to zData.nY-1 do
         begin
            ZData.Data[0,i]:=ZData.Data[1,i];//AverZ;
            ZData.Data[zData.nX-1,i]:=ZData.Data[zData.nX-2,i];//AverZ;
         end
       else
         for I := 0 to zData.nX-1 do
         begin
            ZData.Data[i,0]:=ZData.Data[i,1];//AverZ;
            ZData.Data[i,zData.nY-1]:=ZData.Data[i,zData.nY-2];//AverZ;
         end;  
end;

procedure ReniShawFrontsSmooth();
var i,i1:integer;
     Buf:ArraySpline;
begin
    for i:=0 to  ReniShawFrontsImg.Nx-1 do
       begin
         for i1:=0 to ReniShawFrontsImg.Ny-1 do
           Buf[i1+1]:= ReniShawFrontsImg.data[i,i1];
           smooth1(Buf,ReniShawFrontsImg.Ny,3);
         for i1:=0 to ReniShawFrontsImg.Ny-1 do
           ReniShawFrontsImg.data[i,i1]:=round(Buf[i1+1]);
       end;

      for i:=0 to  ReniShawFrontsImg.Ny-1 do
       begin
         for i1:=0 to ReniShawFrontsImg.Nx-1 do
           Buf[i1+1]:= ReniShawFrontsImg.data[i1,i];
          smooth1(Buf,ReniShawFrontsImg.Nx,3);
         for i1:=0 to ReniShawFrontsImg.Nx-1 do
           ReniShawFrontsImg.data[i1,i]:=round(Buf[i1+1]);
       end;
end;
procedure ReniShawFreeFrontsMap;
begin
 FreeAndNil(ReniShawFrontsImg);
end;

procedure ReniShawCreateFrontsMap(ExperimData:TData; mode:integer; stepScale:integer);
var i,j,k:integer;
    nX,nY:integer;
    oneStepMeasuresCnt, RSFrontsCnt:integer;
    val,val0:integer;
begin
    nX:=ExperimData.Nx;
    nY:=ExperimData.Ny;
//    if mode=OneY then dec(nY) else dec(Nx);
    ReniShawFrontsImg:=tData.Create;
     case  mode of
 OneY: begin
       dec(nY);
       ReniShawFrontsImg.Nx:=nX ;
       ReniShawFrontsImg.Ny:=ny div stepscale ;
       if stepScale>1 then inc(ReniShawFrontsImg.Ny);
     end;
OneX:     // X Mode
     begin
       dec(Nx);
       ReniShawFrontsImg.Ny:=ny ;
       ReniShawFrontsImg.Nx:=nx div stepscale ;
       if stepScale>1 then inc(ReniShawFrontsImg.Nx);
     end;
        end;
    oneStepMeasuresCnt:=0;
    SetLength(ReniShawFrontsImg.data,0,0);
    SetLength(ReniShawFrontsImg.data, ReniShawFrontsImg.Nx,ReniShawFrontsImg.Ny);  //?????? ?  ReniShawFrontsImg ?? ????????
    case mode of
OneY:
      begin
      for j:=0 to nX - 1 do
        begin
          val0:= ExperimData.Data[j,0];
          // RSFrontsCoord[1]:=(val0); //
           ReniShawFrontsImg.data[j,0]:=abs(val0);
           RSFrontsCnt:=1;
          for i := 1 to nY - 1 do
            begin
              val:= ExperimData.Data[j,i];
              if (val)<>(val0) then
                begin
                  if val<0  then
                    begin
                       if RSFrontsCnt<ReniShawFrontsImg.Ny then
                       ReniShawFrontsImg.data[j,RSFrontsCnt]:=-val;
                       inc(RSFrontsCnt);
                       oneStepMeasuresCnt:=0;
                     end
                   else   // val>0
                      begin
                       if oneStepMeasuresCnt>=stepScale-1 then  //
                           begin
                              ReniShawFrontsImg.data[j,RSFrontsCnt]:=val;

                              inc(RSFrontsCnt);
                              oneStepMeasuresCnt:=0;
                           end
                           else inc(oneStepMeasuresCnt);
                        end;
                   val0:=val;
               end;   //  val<>val0
            end;  //i
        end; //j
      end; // Y_Mode  (mode=1)
OneX:
     begin
        for i:=0 to nY - 1 do
        begin
          val0:= ExperimData.Data[0,i];
          // RSFrontsCoord[1]:=(val0); //
           ReniShawFrontsImg.data[0,i]:=abs(val0);
           RSFrontsCnt:=1;
          for j := 1 to nX - 1 do
            begin
              val:= ExperimData.Data[j,i];
              if (val)<>(val0) then
                begin
                  if val<0  then
                    begin
                     if RSFrontsCnt<ReniShawFrontsImg.Nx then
                       ReniShawFrontsImg.data[RSFrontsCnt,i]:=-val;
                       inc(RSFrontsCnt);
                       oneStepMeasuresCnt:=0;
                     end
                   else   // val>0
                      begin
                       if oneStepMeasuresCnt>=stepScale-1 then  //
                           begin
                              ReniShawFrontsImg.data[RSFrontsCnt,i]:=val;
                              inc(RSFrontsCnt);
                              oneStepMeasuresCnt:=0;
                           end
                           else inc(oneStepMeasuresCnt);
                        end;
                   val0:=val;

                end;   //  val<>val0
            end;  //j
        end; //i
       end;//Onex
    end; //case
end;



procedure ReniShawSlowAxisCorr(var ZData:TData;DACData:TData;  mode:integer; stepScale:integer;period:single);
var i,j:integer;
    buf:integer;
    PointsSlAxCoord:TData;
    Fronts_Corrected, DACSlow_Data:TData;
    mode_slow:integer;  // is opposite to  ScanMode:
                    // _mode=0  for Y mode
                    // _mode=1 for X mode
begin
  PointsSlAxCoord:=TData.Create;
  case mode of
OneX:   mode_slow := 1;
OneY:   mode_slow := 0;
  end;
  if mode_slow = 0 then
    begin
      PointsSlAxCoord.Nx:= ZData.Nx;//(ReniShowParams.ReniShawSlowCoord);
      PointsSlAxCoord.Ny:= 1;
      setlength(PointsSlAxCoord.data,PointsSlAxCoord.Nx,PointsSlAxCoord.Ny);
      for i:=0 to PointsSlAxCoord.Nx-1 do
         PointsSlAxCoord.data[i,0]:= DACData.data[i,DacData.Ny-1];
    end
    else
    begin
      PointsSlAxCoord.Ny:= ZData.Ny;//length(ReniShowParams.ReniShawSlowCoord);
      PointsSlAxCoord.Nx:= 1;
      setlength(PointsSlAxCoord.data,PointsSlAxCoord.Nx,PointsSlAxCoord.Ny);
      for i:=0 to PointsSlAxCoord.Ny-1 do
         PointsSlAxCoord.data[0,i]:= DacData.data[DacData.Nx-1,i];
    end;
  ReniShawCreateFrontsMap(PointsSlAxCoord, mode_slow, stepScale);
  ReniShawFrontsSmooth();
  Fronts_Corrected:=TData.Create;
  DACSlow_Data:= TData.Create;
  DACSlow_Data.Nx:= ZData.Nx;
  DACSlow_Data.Ny:= ZData.Ny;
  SetLength(DACSlow_Data.data,DACSlow_Data.Nx,DACSlow_Data.Ny);

  if mode_slow = 0 then
    begin
     for i:=0 to DACSlow_Data.Ny-1 do
       for j:=0 to DACSlow_Data.Nx-1 do
          DACSlow_Data.data[j,i]:=PointsSlAxCoord.data[j,0];//DACData.Data[DacData.Ny-1,j];
      Fronts_Corrected.Nx:=ReniShawFrontsImg.Nx;
      Fronts_Corrected.Ny:=ZData.Ny;
      SetLength(Fronts_Corrected.data,Fronts_Corrected.Nx,Fronts_Corrected.Ny);
     for i:=0 to Fronts_Corrected.Ny-1 do
       for j:=0 to Fronts_Corrected.Nx-1 do
          Fronts_Corrected.data[j,i]:=ReniShawFrontsImg.data[j,0] ;
   end
   else
   begin
      for i:=0 to DACSlow_Data.Ny-1 do
       for j:=0 to DACSlow_Data.Nx-1 do
          DACSlow_Data.data[j,i]:=PointsSlAxCoord.data[0,i];//DACData.Data[j,DacData.Nx-1];
      Fronts_Corrected.Nx:=ZData.Nx;
      Fronts_Corrected.Ny:=ReniShawFrontsImg.Ny;
      SetLength(Fronts_Corrected.data,Fronts_Corrected.Nx,Fronts_Corrected.Ny);
      for i:=0 to Fronts_Corrected.Ny-1 do
       for j:=0 to Fronts_Corrected.Nx-1 do
          Fronts_Corrected.data[j,i]:=ReniShawFrontsImg.data[0,i] ;
   end;
    SetLength(ReniShawFrontsImg.data,0,0);
    ReniShawFrontsImg.Nx:= Fronts_Corrected.Nx;
    ReniShawFrontsImg.Ny:= Fronts_Corrected.Ny;
    SetLength(ReniShawFrontsImg.data, ReniShawFrontsImg.Nx, ReniShawFrontsImg.Ny);
     for i:=0 to Fronts_Corrected.Ny-1 do
       for j:=0 to Fronts_Corrected.Nx-1 do
          ReniShawFrontsImg.data[j,i]:=Fronts_Corrected.data[j,i];
    //FreeandNil(Fronts_Corrected);
    Fronts_Corrected.Free;
   //FreeandNil(PointsSlAxCoord);
    PointsSlAxCoord.Free;
    ReniShawDACCorrect2D(ZData, DACSlow_Data, mode_slow, ReniShawStepScale,period);
    DACSlow_Data.Free;
    ReniShawFrontsImg.Free;
end;
procedure Smooth1(var Dat:ArraySpline; N,S:integer);
var
  i,kx,ix:integer;
  Shift:integer;
  res: double;
  ires: integer;
  Temp:ArraySpline;       // array of integer;
  iStart:integer;
begin
   iStart:=1 ;
   Shift:=(S-1) div 2;
   if N<ArraySplineLen{MaxDiscr} then
   Dat[N+1]:=Dat[N];  //useful for S=3;
      for ix:=istart to N do
        begin
             res:=0.0; ires:=0;
              for kx:=-Shift to Shift do
                begin
                     i:=ix+kx;
                     if (i > 0) and (i <= N)
                         then
                     begin
                        ires:=ires+1;
                        res:=res+Dat[i];
                     end;
                end; {for kx}
           if (ires>0) and (ix > Shift)  and(ix<N-shift+1) then
             begin
                Temp[ix]:=round(res/ires);
             end
             else
             begin
                Temp[ix]:=Dat[ix];
             end;
        end; {for ix}
      for ix:=iStart to N do
        begin
            Dat[ix]:=Temp[ix];
        end;
end; {Smooth1}


procedure SaveRenishawParams;
var FL:File;
    iniCSPM:TIniFile;
    sFile:string;
    OtherDirIniFile:string;
    YSectionBias:single;
begin
 flgSaveProcess:=true;
 sFile:=ScannerIniFilesPath+ScannerReniSIniFile;
if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    ReWrite(FL);
    CloseFile(FL);
  end;
//try
//  SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
  begin
   with   ScannerCorrect     do
    begin
     try
       WriteInteger('Parameters', 'Renishaw Period',RenishawParams.RenishawPeriod);
     except
     on IO: EInOutError do
        begin
            case IO.Errorcode  of
       104:  NoFormUnitLoc.silang1.MessageDlg(strcom15{'error write flash'},mtWarning,[mbOk],0);
               end;
                flgSaveProcess:=false;
                 Exit;
        end;
     else
       begin
        flgSaveProcess:=false;
        NoFormUnitLoc.silang1.MessageDlg(strcom15{'error write flash'},mtWarning,[mbOk],0);
        Exit;
        end;
      end;
       WriteString('Parameters', 'Koeff',FloatToStrF(RenishawParams.RenishawScale,ffFixed,4,2));
       WriteString('Parameters', 'LineToLineTime mk',IntToStr(RenishawParams.LineToLineTimemk));

     end;
  end;
 finally
  IniCSPM.Free;
  flgSaveProcess:=false;
 end;
//  SetFileAttribute_ReadOnly(sfile,true);

end;

procedure RenishawParamsLast;
var SFile:string;
    iniCSPM:TiniFile;
    YSectionBias:single; // degrees
    ss,ssX,ssY:string;
    ScannerNameFlash:TStrings;
    res:Thandle;
    windowsdir:Pchar;
label 100;
begin
   sFile:=ScannerIniFilesPath+ ScannerReniSIniFile;
 if (not FileExists(sFile)) then
  begin
   NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Scanner Ini File'}+ScannerReniSIniFile+strcom6{'. Default Ini File Used!!'});
     if (not FileExists(sFile)) then
      begin
       NoFormUnitLoc.silang1.ShowMessage(strcom7{'No Default Scanner Ini File'}+ScannerReniSIniFile+strcom10{'. Program Terminated!!'});
       Application.Terminate;
      end
  end;
   iniCSPM:=TIniFile.Create(sFile);
  try
  with iniCSPM do
   with   RenishawParams    do
    begin
       RenishawPeriod:=ReadInteger('Parameters',  'Renishaw Period' ,100);
       RenishawScale:=ReadFloatConvert(iniCSPM,'Parameters', 'Koeff',2.45);
       SlowAxisScanRate:= ReadFloatConvert(iniCSPM,'Parameters', 'SlowAxisScanRate',200);
       flgLineToLineTime:=False;
       if  RenishawPeriod=100 then    noiseW_discr:=20
                              else    noiseW_discr:=5;
       Period_nm:=Renishawperiod*ReniShawScale;
   end;
  finally
    iniCSPM.Free;
  end;
end;


initialization
//??????
//RenishawLinDirectory:= ExeFilePath+'ReniShawLin\';
//FlgRenishawUnit:=True;
//FlgRenishawCorrection:=True;
end.
