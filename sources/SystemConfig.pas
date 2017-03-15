
//300703
unit SystemConfig;

interface

uses  Windows,Forms,Messages,Classes,ShellApi,  SysUtils, Dialogs, inifiles,
CSPMVar, GlobalType, UNanoeduClasses, UNanoeduBaseClasses;


var
  ZnmdiscrConv:single;
  DefaultOptions:Boolean;

procedure SysVarDef;
procedure SysVarLast;
procedure LoadPIDParamsDef;
procedure LoadPIDSTMParamsDef;
procedure LoadPIDSFMParamsDef;
//procedure LoadPIDScanParamsDef;
procedure ResonanceParamsDef;
procedure ScannerMovXYZParamsDef;
procedure UsersParamsDef;
procedure UsersParamsLast(const FileName:string);
//procedure SpectrParamsDef;
procedure ScannerCorrectLast;
procedure SpectrParamsDef;
procedure SetScanParamsDefInitPrev; //init x,yprevious  Renishaw
procedure SetScanParamsDef;
procedure SetScanParamsDefF;
procedure SetScanParamsDefAtom;
procedure SetScanParamsDefAtomF;
procedure SetScanParamsDefSEM;
procedure SetScanParamsDefSEMF;
procedure SetScanParamsDefGrand;
procedure SetScanParamsDefGrandF;
procedure SetScanAreaDefR;
procedure SetSEMScanAreaDefR;
procedure SetScanAreaDefF;
procedure SetAtomScanAreaDefR;
procedure SetAtomScanAreaDefF;
procedure SetDemoParamsDef;
procedure LoadHeadConfig;
procedure ConfigDef;
procedure LoadConfigOSC;
procedure SaveConfigOSC;
procedure LoadConfigPID;
procedure SaveConfigPID;
//procedure SaveConfig;
procedure SaveConfigUsers;
//procedure LoadReniShawConfig;
procedure LoadConfig;
procedure LoadVideoParams;
procedure SaveVideoParams;
procedure LoadScannerParams(flgLoadFromAdapter:boolean);
procedure LoadPIDConfig;
procedure SaveScannerParams;
procedure SaveAdapterDataToInifiles;
procedure SaveCorrectedI_VTranformParams(ScannerOpt:RScannerOptMod); //correction I_V //281210
//procedure SaveElectronicParams;
procedure SDSignalsLast;
procedure SDSignalsDef;
procedure LoadCurveLinFromIniFile(filename:string;var pAdapterLinModXX,pADapterLinModXY: PAdapterLinPointsRecord);
procedure StoreScannerOpt( var ScannerOptMod,ScannerOptOtherMod:RScannerOptMod;
                           var PAdapterOptMod,PAdapterOptModOther:PAdapterOptFloatRecord);
procedure StoreSensitivToAdapter(var PAdapterOptMod:PAdapterOptFloatRecord);
procedure LoadScannerOptGeneral(const fileNameX,FileNameY:string);
procedure LoadScannerOPtGeneralFromAdapter;
procedure ScannerCorrectLastMod(const FileName:string; var ScannerOpt:RScannerOptMod;var PAdapterOptMod:PAdapterOptFloatRecord);
procedure ScannerCorrectLastModeFromAdapter( var ScannerOpt:RScannerOptMod; PAdapterOptMod:PAdapterOptFloatRecord);
procedure InitPIDFine(Val:PidType; MaxAbsVal:PidType;var MinFineLimit, MaxFineLimit:PidType);
function  ConvertLinDateToInt(date:string):integer;
function  ConvertLinDateToStr(date:integer):string;
function  ReadFormSizeandPosition(var frmparams:rformparam):boolean;
function  SaveFormSizeandPosition(frmparams:rformparam):boolean;
//procedure CreateScannerData( PageNmb:integer;Inifilename:string; var dataArray:ArrayInt);
//function GetDaviceName:string;
function  SaveMLPCDataAsINI(dataArray:ArrayInt; ScannerFileName:string):integer;

implementation

uses mHardWareOpt,GlobalVar,RenishawVars,GlobalFunction,math,frNoFormUnitLoc,frDebug,uScannerCorrect, SIOCSPM;

var flgsaveScannerIni:boolean;

(*procedure SetScannerDetectedAuto;
 var FL:File;
    iniCSPM:TiniFile;
    sFile:string;
    YSectionBias:single;
begin
 sFile:=ConfigUsersIniFilePath + ConfigUsersIniFile;
 if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    Rewrite(FL);
    CloseFile(FL);
  end;
 // SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
     with iniCSPM do
   begin
     if  HardWareOpt.flgFlash then  HardWareOpt.flgAutoScanner:=1;
    WriteInteger('Physical Unit Options','Set Scanner Number Auto',HardWareOpt.flgAutoScanner);
   end;

  //  SetFileAttribute_ReadOnly(sfile,true);
 finally
    IniCSPM.Free;
 end;
 end;
 *)

function  GetLastScanner(const FileName:string):string;
  var iniCSPM:TiniFile;
       sFile:string;
begin
  sFile:=GetConfigUsersFileName;
  iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
     begin
            case flgUnit of
nano,Pipette,terra:   Result:=ReadString('Physical Unit Options','Scanner Number','1');
        baby:         Result:=ReadString('Physical Unit Options','Scanner Number Atom Unit','Atom');
        ProBeam:      Result:=ReadString('Physical Unit Options','Scanner Number SEM  Unit','SEM');
        grand:        Result:='stepmotor';
             end;
     end;
  finally
    iniCSPM.Free;
  end;
end;

procedure ScannerCorrectLastMod(const FileName:string; var ScannerOpt:RScannerOptMod;var PAdapterOptMod:PAdapterOptFloatRecord);
var
    SFile:string;
    iniCSPM:TiniFile;
    YSectionBias:single; // degrees
    ss,ssX,ssY:string;
    ScannerNameFlash:TStrings;
    res:Thandle;
    windowsdir:Pchar;
label 100;
begin
  flgSaveScannerIni:=false;
  sFile:=ScannerIniFilesPath+ FileName;
 if (not FileExists(sFile)) then
  begin  // b1
   NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Scanner Ini File'}+FileName+strcom6{'. Default Ini File Used!!'});
 //  if  FileName=ScannerIniFile then          // ??????? Не понятно. зачем это сравнение
 //   begin   // b2
     sFile:=ScannerDefIniFilesPath+ ScannerDefIniFile;
     if (not FileExists(sFile)) then
      begin   // b3
       NoFormUnitLoc.silang1.ShowMessage(strcom7{'No Default Scanner Ini File'}+#13+ NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_50' (* ' Default scanner is used !!' *) ));
       SFile:=ScanneriniBasePath+'default\'+  FileName;
        if (not FileExists(sFile)) then
      begin    // b4
       ShowMessage(NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_52' (* ' No ini files for Default scanner !! ' *) )+strcom10{'. Program Terminated!!'} );
       Application.Terminate;
      end       // e4
      end      // e3
  //    end     // e2
  //  else Application.Terminate;
  end;     // e1
   iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
    ///????????????
    (*
     HardWareOpt.flgFlash:=not ((ScannerIniFilesPath=UserNanoeduApplDataPath) or (flgUnit<>nano) and (flgUnit<>Pipette));
     if HardWareOpt.flgFlash then
      begin
        ScannerNameFlash:=TStringlist.create;
        ReadSections(ScannerNameFlash);
       if ScannerNameFlash.Count<>1 then
       begin
        NoFormUnitLoc.silang1.ShowMessage(strcom13{'Error file!'}+#13+strcom14{' More one scanner in the file '}+FileName+strcom10{'. Program Terminated!!'});
        GetMem(windowsdir,Max_path);
        try
         GetWindowsDirectory(windowsdir,Max_Path);
         ExecAndWait(Pchar(windowsdir)+'\notepad.exe', Pchar(SFile),SWP_NOMOVE or SW_showNORMAL);
        finally
         FreeMem(windowsdir);
        end;
        ScannerNameFlash.Free;
        Halt;
       end //<>1
       else
       begin
        HardWareOpt.ScannerNumb:=ScannerNameFlash[0];
        ScannerNameFlash.Free;
       end;    //=1
      end;   //flash
    *)
     if  not SectionExists((HardWareOpt.ScannerNumb)) then
//     if PathFlash='' then
      begin
        NoFormUnitLoc.silang1.MessageDlg(strcom16{'Scanner '}+HardWareOpt.ScannerNumb+strcom17{' doesn''t exist. Manual regime is set!'}+#13+strcom18{'Don''t forget to choose scanner needed!!'},mtwarning,[mbOk],0);
      //  HardWareOpt.flgAutoScanner:=0;  //false
  //      SetScannerDetectedAuto;
  (*      HardWareOpt.ScannerNumb:=GetLastScanner(ConfigUsersIniFile);//
         if  not SectionExists((HardWareOpt.ScannerNumb)) then
          begin
             ScannerNameFlash:=TStringlist.create;
             ReadSections(ScannerNameFlash);
             HardWareOpt.ScannerNumb:=ScannerNameFlash[0];
             ScannerNameFlash.Free;
          end;
    *)
      end;
      with   ScannerOpt    do
      begin
       PathMode:=ReadInteger(HardWareOpt.ScannerNumb, 'pathmode',0);
       LinearizationDate:=ReadString(HardWareOpt.ScannerNumb, 'Linearization Date','??');
       NonLinFieldX:=ReadInteger(HardWareOpt.ScannerNumb, 'NonLiniar Field X',25000);
       NonLinFieldY:=ReadInteger(HardWareOpt.ScannerNumb, 'NonLiniar Field Y',25000);     //nm
       GridCellSize:=ReadInteger(HardWareOpt.ScannerNumb, 'Grid Cell Size',3000);
       YSectionBias:=ReadFloatConvert(iniCSPM,(HardWareOpt.ScannerNumb), ' Y Section Bias(degrees)', 0);
       YBiasTan:=tan(YSectionBias*pi/180);
       SensitivZ:=ReadFloatConvert(iniCSPM,HardWareOpt.ScannerNumb,'SensitivZ',40);
       SensitivX:=ReadFloatConvert(iniCSPM,HardWareOpt.ScannerNumb,'SensitivX',250);
       SensitivY:=ReadFloatConvert(iniCSPM,HardWareOpt.ScannerNumb,'SensitivY',250);
       I_VTransfKoef:=ReadFloatConvert(iniCSPM,HardWareOpt.ScannerNumb,'I_VTransfKoef',240)//A/mVolt
     end ;
  end;
     with PAdapterOptMod^  do
     begin
       case ScannerOpt.PathMode of
    0: PageNmb:=1; //5    from   file name
    1: PageNmb:=4; //5    from   file name
         end;
       PageTypeId:=AdaptPgType_params;
       DataLengthInt:=sizeof(RAdapterOptFloatRecord) div sizeof(Integer);
       NonLinFieldX:=ScannerOpt.NonLinFieldX;
       NonLinFieldY:=ScannerOpt.NonLinFieldY;     //nm
       GridCellSize:=ScannerOpt.GridCellSize;  //nm
       YBiasTan:=ScannerOpt.YBiasTan; //single;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=ScannerOpt.SensitivZ; //single;
       SensitivX:=ScannerOpt.SensitivX; ;//single;
       SensitivY:=ScannerOpt.SensitivY; ;//single;
       I_VTransfKoef:=ScannerOpt.I_VTransfKoef; ;//single;
    end;
  finally
    iniCSPM.Free;
  end;
end;  {ScannerCorrectLastMod}
procedure ScannerCorrectLastModeFromAdapter( var ScannerOpt:RScannerOptMod; PAdapterOptMod:PAdapterOptFloatRecord);
begin
      with   ScannerOpt    do
      begin
         case PAdapterOptMod^.PageNmb of
     1: begin PathMode:=0; LinearizationDate:=PadapterLinModXAxisX.LinearizationDate; end;
     4: begin PathMode:=1; LinearizationDate:=PadapterLinModYAxisX.LinearizationDate; end;
         end;
       NonLinFieldX:=PAdapterOptMod^.NonLinFieldX;
       NonLinFieldY:=PAdapterOptMod^.NonLinFieldY;     //nm
       GridCellSize:=PAdapterOptMod^.GridCellSize;
       YBiasTan:=PAdapterOptMod^.YBiasTan;
       SensitivZ:=PAdapterOptMod^.SensitivZ;
       SensitivX:=PAdapterOptMod^.SensitivX;
       SensitivY:=PAdapterOptMod^.SensitivY;
       I_VTransfKoef:=PAdapterOptMod^.I_VTransfKoef;
      end ;
end;

procedure SysVarDef;
begin

end;

procedure SysVarLast;
begin
     // Reading from FILE
end;
procedure LoadPIDParamsDef;
begin
   LoadPIDSFMParamsDef;
end;
procedure LoadPIDSTMParamsDef;
begin
with PIDSTMParams do
  begin
   dT:=100;
   Te:=0;
   Td:=0;
   Ti:=60;
   sgnTi:=1;
   TiApproach:=60;
   TiScan:=5;
   dTAbsMax:=4000;
   TeAbsMax:=100;
   TdAbsMax:=100;
   TiAbsMax:=1000;    //100
   FineScale:=12;
   InitPIDFine(Te, TeAbsMax, pidTeL1,pidTeL2);
   InitPIDFine(Td, TdAbsMax, pidTdL1,pidTdL2);
   InitPIDFine(abs(Ti), TiAbsMax,pidTiL1,pidTiL2);
  end;

end;
procedure LoadPIDSFMParamsDef;
begin
with PIDSFMParams do
  begin
   dT:=100;//1000;  29.08.13
   Te:=0;
   Td:=0;
   Ti:=60;
   sgnTI:=-1;
   TiApproach:=60;        //-60
   TiScan:=10;            //-15
   dTAbsMax:=4000;
   TeAbsMax:=100;
   TdAbsMax:=100;
   TiAbsMax:=1000; //100
   FineScale:=12;
   InitPIDFine(Te, TeAbsMax, pidTeL1,pidTeL2);
   InitPIDFine(Td, TdAbsMax, pidTdL1,pidTdL2);
   InitPIDFine(abs(Ti), TiAbsMax,pidTiL1,pidTiL2);
  end;
end;

procedure StoreScannerOpt( var ScannerOptMod,ScannerOptOtherMod:RScannerOptMod;
                          var PAdapterOptMod,PAdapterOptModOther:PAdapterOptFloatRecord);
begin
with ScannerOptMod do
begin
  //     DZdclnX:=ScannerCorrect.DZdclnX;
  //     DZdclnY:=ScannerCorrect.DZdclnY;
       NonLinFieldX:=ScannerCorrect.NonLinFieldX;
       NonLinFieldY:=ScannerCorrect.NonLinFieldY;     //nm
       GridCellSize:=ScannerCorrect.GridCellSize; //nm
       YBiasTan:=ScannerCorrect.YBiasTan;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=ScannerCorrect.SensitivZ;
       SensitivX:=ScannerCorrect.SensitivX;
       SensitivY:=ScannerCorrect.SensitivY;
       I_VTransfKoef:=ScannerCorrect.I_VTransfKoef;
end;
with  PAdapterOptMod^ do
begin
  //     DZdclnX:=ScannerCorrect.DZdclnX;
  //     DZdclnY:=ScannerCorrect.DZdclnY;
       NonLinFieldX:=ScannerCorrect.NonLinFieldX;
       NonLinFieldY:=ScannerCorrect.NonLinFieldY;     //nm
       GridCellSize:=ScannerCorrect.GridCellSize; //nm
       YBiasTan:=ScannerCorrect.YBiasTan;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=ScannerCorrect.SensitivZ;
       SensitivX:=ScannerCorrect.SensitivX;
       SensitivY:=ScannerCorrect.SensitivY;
       I_VTransfKoef:=ScannerCorrect.I_VTransfKoef;
end;

with ScannerOptOtherMod do
begin
   //    DZdclnX:=ScannerCorrect.DZdclnX;
   //    DZdclnY:=ScannerCorrect.DZdclnY;
       GridCellSize:=ScannerCorrect.GridCellSize; //nm
       YBiasTan:=ScannerCorrect.YBiasTan;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=ScannerCorrect.SensitivZ;
       I_VTransfKoef:=ScannerCorrect.I_VTransfKoef;
end;
with   PAdapterOptModOther^ do
begin
    //   DZdclnX:=ScannerCorrect.DZdclnX;
    //   DZdclnY:=ScannerCorrect.DZdclnY;
       GridCellSize:=ScannerCorrect.GridCellSize; //nm
       YBiasTan:=ScannerCorrect.YBiasTan;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=ScannerCorrect.SensitivZ;
       I_VTransfKoef:=ScannerCorrect.I_VTransfKoef;
end;

end;
procedure StoreSensitivToAdapter(var PAdapterOptMod:PAdapterOptFloatRecord);
begin
  with  PAdapterOptMod^ do
begin
       SensitivX:=ScannerCorrect.SensitivX;
       SensitivY:=ScannerCorrect.SensitivY;
 end;
end;
procedure ScannerCorrectLast();
begin
 with  ScannerCorrect do
if ScanParams.ScanPath=0 then //X+
    begin
       NonLinFieldX:=ScannerOptModX.NonLinFieldX;
       NonLinFieldY:=ScannerOptModX.NonLinFieldY;     //nm
       GridCellSize:=ScannerOptModX.GridCellSize; //nm
       YBiasTan:=ScannerOptModX.YBiasTan;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=ScannerOptModX.SensitivZ;
       SensitivX:=ScannerOptModX.SensitivX;
       SensitivY:=ScannerOptModX.SensitivY;
       I_VTransfKoef:=ScannerOptModX.I_VTransfKoef;
    end
 else //Y+
    begin
       NonLinFieldX:=ScannerOptModY.NonLinFieldX;
       NonLinFieldY:=ScannerOptModY.NonLinFieldY;     //nm
       GridCellSize:=ScannerOptModY.GridCellSize; //nm
       YBiasTan:=ScannerOptModY.YBiasTan;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=ScannerOptModY.SensitivZ;
       SensitivX:=ScannerOptModY.SensitivX;
       SensitivY:=ScannerOptModY.SensitivY;
       I_VTransfKoef:=ScannerOptModY.I_VTransfKoef;
    end;
end;


procedure LoadScannerOptGeneral(const fileNameX,FileNameY:string);
begin
// flgVideoOscConflict:=true;
 ScannerCorrectLastMod(filenameX, ScannerOptModX,PAdapterOptModX);
 ScannerCorrectLastMod(filenameY, ScannerOptModY,PAdapterOptModY);
 if flgsaveScannerIni then  SaveCorrectedI_VTranformParams(ScannerOptModX);
  flgsaveScannerIni:=false;
  LoadCurveLinFromIniFile(filenameX,  pAdapterLinModXAxisX,pAdapterLinModXAxisY);
  LoadCurveLinFromIniFile(filenameY,  pAdapterLinModYAxisX,pADapterLinModYAxisY);
end;

procedure LoadHeadConfig;
  var SFile:string;
    iniCSPM:TiniFile;
    videocam:string;
begin
   sFile:=ScannerIniFilesPath+ ConfigHeadIniFile;
 if (not FileExists(sFile)) then
  begin
    flgVideoOscConflict:=true;
    exit;
   end;
   iniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
     if  not SectionExists('Video') then
         begin
          flgVideoOscConflict:=true;
         end
      else
      begin
       videocam:= Readstring('Video', 'videocamera','');
       flgVideoOscConflict:=not (videocam='creative webcam notebook');
      end;
     end;
   finally
    iniCSPM.Free;
  end;
end;

procedure ResonanceParamsDef;
   var iniCSPM:TiniFile;
       sFile:string;
       str:string;
begin
   with   ResonanceParams do
   begin
     Delay:=2;      //ms
     FreqStartRoughDef:=6000;
     FreqEndRoughDef:=12000;
     FreqStartRough:=FreqStartRoughDef;//8000;
     FreqEndRough:=FreqEndRoughDef; // 10000;
     FreqStart:=FreqStartRough;  //Hrz
     FreqEnd:=FreqEndRough;
     StepFine:=1;//HRz
     NPoints:=400;//round((FreqEnd-FreqStart)/Step)-1;
     StepRough:=round((FreqEnd-FreqStart)/(Npoints-1));
     Step:=StepRough;
     DeltaFine:=210; //500 Hrz   1/2 fine windows size
     AmplStep:=1/TransformUnit.AmplV_d;
     Nchannels:=4;       //add drawdone channel number 2
     // number of java channel; 1:  freq{i},Ampl[i]- outchannel; freqres
     //  write delay
  //   Gain_AM:=491;
   end;
   // add 160911
// Reading Params Value from IniFile
  sFile:=GetConfigUsersFileName;
  iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
  begin
      ResonanceParams.Delay:=ReadInteger('Resonance','Delay',2) ;
   case flgUnit of
Probeam:begin
         with   ResonanceParams do
        begin
         FreqStartRoughDef:=ReadInteger('Resonance','FreqStartRough',6000);
         FreqEndRoughDef:=ReadInteger('Resonance','FreqEndRough',12000) ;
         FreqStartRough:=FreqStartRoughDef;//8000;
         FreqEndRough:=FreqEndRoughDef; // 10000;
         FreqStart:=FreqStartRough;  //Hrz
         FreqEnd:=FreqEndRough;
         StepFine:=1;//HRz
         NPoints:=400;//round((FreqEnd-FreqStart)/Step)-1;
         StepRough:=round((FreqEnd-FreqStart)/(Npoints-1));
         Step:=StepRough;
        end;
        end;
   end;
  end;
  finally
    iniCSPM.Free;
  end;
 //
end;
procedure ScannerMovXYZParamsDef;
begin
       ScannerMoveXYZParams.PMActiveTime:=600;// 07.11.14  1001;//mcs
       ScannerMoveXYZParams.PMPAUSE:=15;//16;    //mcs
       ScannermoveXYZParams.XMax:=100;
       ScannermoveXYZParams.YMax:=100;
       ScannermoveXYZParams.StepsNumbSlow:=1;
       ScannermoveXYZParams.StepsNumbFast:=10;
       ScannerMoveXYZParams.StepsCountY:=0;
       ScannerMoveXYZParams.StepsCountX:=0;
       ScannerMoveXYZParams.StepsCountZ:=0;
       ScannerMoveXYZParams.NChannels:=4;
       ScannerMoveXYZParams.Speed:=(ScannerMoveXYZParams.PMActiveTime shl 4) +(ScannerMoveXYZParams.PMPause);
 end;
procedure UsersParamsDef;
begin
   if  STMFlg then                // STM Regime
    begin
        ApproachParams.LandingSetPoint:=1;
        ApproachParams.SetPoint:=ApproachParams.LandingSetPoint*0.2;
        ApproachParams.BiasV:=1;//ReadFloatConvert(iniCSPM,'STM Approach Parameters','BiasV',3.4 );
        ApproachParams.FreqBandF:=3;//ReadInteger('STM Approach Parameters','FreqBandF',3);
        ApproachParams.ScannerDecay:=120;//ReadInteger('STM Approach Parameters',' ScannerDecay',100);
        ApproachParams.IntegratorDelay:=2000;//ReadInteger('STM Approach Parameters',' IntegratorDelay',1000 );
        ApproachParams.ZGateMax:=0.8;//ReadFloatConvert(iniCSPM,'STM Approach Parameters','ZGateMax', 0.8);
        ApproachParams.ZGateMin:=0.3;//ReadFloatConvert(iniCSPM,'STM Approach Parameters','ZGateMin', 0.3);
        ApproachParams.LevelIT:=0.15;//0.2;//ReadFloatConvert(iniCSPM,'STM Approach Parameters','LevelIT',0.2 );
        ApproachParams.ZUpStepsNumb:=10;//(ReadInteger('Approach Parameters','ZUpStepsNumb', 10));
        ApproachParams.ZFastStepsNumb:=5;//(ReadInteger('Approach Parameters','ZFastStepsNumb', 10));
        ApproachParams.ScaleMaxIT:=1.5;//ReadFloatConvert(iniCSPM,'Approach Parameters','ScaleMaxIT',1.5);
        if flgUnit<>pipette then   ApproachParams.MaxITIndicator:=2//1  edited 03.06.16
                            else   ApproachParams.MaxITIndicator:=100;
         ApproachParams.FreqBandR:=6;
     end
   else
     begin
        ApproachParams.LandingSetPoint:=0.8;
        ApproachParams.SetPoint:=0.9;//ApproachParams.LandingSetPoint;
        ApproachParams.BiasV:=3.4;//ReadFloatConvert(iniCSPM,'Approach Parameters','BiasV',3.4 );
        ApproachParams.FreqBandF:=3;//ReadInteger('Approach Parameters','FreqBandF',3);
       // ApproachParams.FreqBandR:=ReadInteger('Approach Parameters','FreqBandR', 2);
        ApproachParams.ScannerDecay:=120;//ReadInteger('Approach Parameters',' ScannerDecay',100);
        ApproachParams.IntegratorDelay:=800;//ReadInteger('Approach Parameters',' IntegratorDelay',200 );
        ApproachParams.ZGateMax:=0.8;//ReadFloatConvert(iniCSPM,'Approach Parameters','ZGateMax', 0.8);
        ApproachParams.ZGateMin:=0.3;//ReadFloatConvert(iniCSPM,'Approach Parameters','ZGateMin', 0.3);
        ApproachParams.LevelUAM:=0.9;//0.9;//ReadFloatConvert(iniCSPM,'Approach Parameters','LevelUAM',0.9 );
        ApproachParams.ZUpStepsNumb:=10;//(ReadInteger('Approach Parameters','ZUpStepsNumb', 10));
        ApproachParams.ZFastStepsNumb:=5;//(ReadInteger('Approach Parameters','ZFastStepsNumb', 10));
        ApproachParams.ExtremAmplitude:=1.5;//ReadFloatConvert(iniCSPM,'Approach Parameters','ExtremAmplitude',1.5);
        ApproachParams.MaxAmp_M:=60;//mv
        ApproachParams.Amp_M:=8;
        ApproachParams.F0:=10;
        ApproachParams.FreqBandR:=6;
     end;
        ApproachParams.IMaxCut:=0.1;
        ApproachParams.flgAutorunCamera:=true;
        ApproachParams.ZStepsNumb:=1;
        ApproachParams.ZUnCntlStepsNumb:=100;
        ApproachParams.PMActiveTime:=500;//300;//ReadInteger('Approach Parameters','PM Active time',100);
        ApproachParams.PMPAUSE:=15;
        ApproachParams.NChannels:=4;
        ApproachParams.flgControlTopPosition:=not FlgReniShawUnitExists and (flgUnit<>baby) and (flgUnit<>ProBeam) and (flgUnit<>MicProbe);

               case flgUnit of
     baby:  begin
                             ApproachNScrpt:=ApproachPMScrpt;
                             ApproachNOneScrpt:=ApproachPMOneScrpt;
                             MTestScrpt:=PMTestScrpt;   //piezo
                             ApproachParams.TypeMover:=1;
                             ApproachParams.MaxSuppress:=0.5;
                             ApproachParams.flgControlTopPosition:=false;
            end;
    probeam:begin
                             ApproachNScrpt:=ApproachPMSEMScrpt;
                             ApproachNOneScrpt:=ApproachPMSEMOneScrpt;
                             MTestScrpt:=PMSEMTestScrpt;   //piezo
                             ApproachParams.TypeMover:=4; //pmz
                             ApproachParams.MaxSuppress:=1;
                             ApproachParams.flgControlTopPosition:=false;
             end;
    micprobe:begin
                             ApproachNScrpt:=ApproachPMSEMScrpt;
                             ApproachNOneScrpt:=ApproachPMSEMOneScrpt;
                             MTestScrpt:=PMSEMTestScrpt;   //piezo
                             ApproachParams.TypeMover:=4; //pmz
                             ApproachParams.MaxSuppress:=0.5;
                             ApproachParams.flgControlTopPosition:=false;
             end;
    nano,nanotutor,
    terra:  begin
                             ApproachNScrpt:=ApproachSMScrpt;
                             ApproachNOneScrpt:=ApproachSMOneScrpt;
                             MTestScrpt:=SMTestScrpt;     //stepmover
                             ApproachParams.TypeMover:=0;
                             ApproachParams.MaxSuppress:=0.5;
             end;
   pipette: begin
                             ApproachNScrpt:=ApproachPipetteScrpt;
                             ApproachNOneScrpt:=ApproachPipetteOneScrpt;
                             MTestScrpt:=SMTestScrpt;     //stepmover
                             ApproachParams.TypeMover:=0;
                             ApproachParams.MaxSuppress:=0.5;
             end;

   grand:    begin
                             ApproachNScrpt:=ApproachSMScrpt;
                             ApproachNOneScrpt:=ApproachSMOneScrpt;
                             MTestScrpt:=SMTestScrpt;     //stepmover
                             ApproachParams.TypeMover:=0;
                             ApproachParams.MaxSuppress:=1.0
             end;
               end;
                ScanParams.ScanDrawDelay  :=400;
                ScanParams.LithoDrawDelay  :=400;
                ScanParams.FastDrawDelay  :=4000;
                ScanParams.flgOneFrame:=true;
                ScanParams.TimMeasurePoint:=0.01;//ms
                ScanParams.TimMicroStep:=0.005;//      // milisec, Time of one microstep;
                ScanParams.ScanRateLimParameter  := 400;  // 20/12/2016 this parameter is max valid ratio: NPoints/lineTime_c
                ScanParams.WaitForPrepareFastPath:=5000; //ms
                ScanParams.flgFastSimulator:= false;
                ScanParams.flgMovetoZero:=false;
    //               Nanoedu.TurnOn;  //add 16/12/06
  end;


procedure UsersParamsLast(const FileName:string);
 var iniCSPM:TiniFile;
       sFile:string;
       str:string;
begin
// Reading Params Value from IniFile
  sFile:=GetConfigUsersFileName;
  iniCSPM:=TIniFile.Create(sFile);
 try
   with iniCSPM do
  begin
  if  STMFlg then                // STM Regime
    begin
        ApproachParams.LandingSetPoint:=1;
        ApproachParams.SetPoint:=ApproachParams.LandingSetPoint*0.2;//ReadFloatConvert(iniCSPM,'STM Approach Parameters','SetPoint',0.5);     //nm
        ApproachParams.BiasV:=1;//0.5;//ReadFloatConvert(iniCSPM,'STM Approach Parameters','BiasV',3.4 );
        ApproachParams.FreqBandF:=ReadInteger('STM Approach Parameters','FreqBandF',3);
      //  ApproachParams.FreqBandR:=ReadInteger('STM Approach Parameters','FreqBandR', 2);
        ApproachParams.ScannerDecay:=ReadInteger('STM Approach Parameters',' ScannerDecay',100);
        ApproachParams.IntegratorDelay:=ReadInteger('STM Approach Parameters',' IntegratorDelay',2000 );
        ApproachParams.ZGateMax:=ReadFloatConvert(iniCSPM,'STM Approach Parameters','ZGateMax', 0.8);
        ApproachParams.ZGateMin:=ReadFloatConvert(iniCSPM,'STM Approach Parameters','ZGateMin', 0.3);
        ApproachParams.LevelIT:=ReadFloatConvert(iniCSPM,'STM Approach Parameters','LevelIT',0.15 );
        ApproachParams.ZUpStepsNumb:=(ReadInteger('Approach Parameters','ZUpStepsNumb', 10));
        ApproachParams.ZFastStepsNumb:=(ReadInteger('Approach Parameters','ZFastStepsNumb', 10));
        ApproachParams.ScaleMaxIT:=ReadFloatConvert(iniCSPM,'Approach Parameters','ScaleMaxIT',1.5);
      if flgUnit<>pipette then
       begin
        if   ValueExists('STM Approach Parameters','MaxITIndicatorNonePipe')
                          then  ApproachParams.MaxITIndicator:=ReadInteger('STM Approach Parameters','MaxITIndicatorNonePipe', 15)//A/mVolt
                          else
                          begin
                              ApproachParams.MaxITIndicator:=ReadInteger('STM Approach Parameters','MaxITIndicatorPipe', 100)
                          end
       end
       else ApproachParams.MaxITIndicator:=ReadInteger('STM Approach Parameters','MaxITIndicator', 100);
        ApproachParams.FreqBandR:=6
     end
   else
     begin
        ApproachParams.LandingSetPoint:=0.8;
        ApproachParams.SetPoint:=0.9;//ReadFloatConvert(iniCSPM,'Approach Parameters','SetPoint',0.9);
        ApproachParams.BiasV:=ReadFloatConvert(iniCSPM,'Approach Parameters','BiasV',3.4 );
        ApproachParams.FreqBandF:=ReadInteger('Approach Parameters','FreqBandF',3);
        ApproachParams.ScannerDecay:=ReadInteger('Approach Parameters',' ScannerDecay',100);
        ApproachParams.IntegratorDelay:=ReadInteger('Approach Parameters',' IntegratorDelay',800 );
        ApproachParams.ZGateMax:=ReadFloatConvert(iniCSPM,'Approach Parameters','ZGateMax', 0.8);
        ApproachParams.ZGateMin:=ReadFloatConvert(iniCSPM,'Approach Parameters','ZGateMin', 0.3);
        ApproachParams.LevelUAM:=ReadFloatConvert(iniCSPM,'Approach Parameters','LevelUAM',0.9 );
        ApproachParams.ZUpStepsNumb:=(ReadInteger('Approach Parameters','ZUpStepsNumb', 10));
        ApproachParams.ZFastStepsNumb:=(ReadInteger('Approach Parameters','ZFastStepsNumb', 5));
        ApproachParams.ExtremAmplitude:=ReadFloatConvert(iniCSPM,'Approach Parameters','ExtremAmplitude',1.5);
        //ApproachParams.MaxSuppress:=ReadFloatConvert(iniCSPM,'Approach Parameters','MaxSuppress',0.5);
        ApproachParams.MaxAmp_M:=ReadInteger('Approach Parameters','MaxAmp_M', 60);
        ApproachParams.Amp_M:=ReadInteger('Approach Parameters','Amp_M',8);
        ApproachParams.F0:=10;
        ApproachParams.FreqBandR:=6
     end;
         ApproachParams.IMaxCut:=ReadFloatConvert(iniCSPM,'STM Approach Parameters','IMaxCut',1.0 );
         ApproachParams.ZUnCntlStepsNumb:=100;
         ApproachParams.flgAutorunCamera:=ReadBool('Approach Parameters','Autorun camera',true) ;
         ApproachParams.ZStepsNumb:=1;
         str:=ReadString('Approach Parameters','Type Mover','stepmover');
                case flgUnit of
     baby:   begin
                             ApproachNScrpt:=ApproachPMScrpt;
                             ApproachNOneScrpt:=ApproachPMOneScrpt;
                             MTestScrpt:=PMTestScrpt;   //piezo
                             ApproachParams.TypeMover:=1;
                             ApproachParams.MaxSuppress:=0.5;
                             ApproachParams.flgControlTopPosition:=false;
             end;
   ProBeam: begin
                             ApproachNScrpt:=ApproachPMSEMScrpt;
                             ApproachNOneScrpt:=ApproachPMSEMOneScrpt;
                             MTestScrpt:=PMSEMTestScrpt;   //piezo
                             ApproachParams.TypeMover:=4; //pmz
                             ApproachParams.MaxSuppress:=1;
                             ApproachParams.flgControlTopPosition:=false;

             end;
   micprobe: begin
                             ApproachNScrpt:=ApproachPMSEMScrpt;
                             ApproachNOneScrpt:=ApproachPMSEMOneScrpt;
                             MTestScrpt:=PMSEMTestScrpt;   //piezo
                             ApproachParams.TypeMover:=4; //pmz
                             ApproachParams.MaxSuppress:=0.5;
                             ApproachParams.flgControlTopPosition:=false;

             end;
    nano,nanotutor,
    terra:    begin
                             ApproachNScrpt:=ApproachSMScrpt;
                             ApproachNOneScrpt:=ApproachSMOneScrpt;
                             MTestScrpt:=SMTestScrpt;     //stepmover
                             ApproachParams.TypeMover:=0;
                             ApproachParams.MaxSuppress:=0.5;
                             ApproachParams.flgControlTopPosition:=boolean(ReadInteger('Approach Parameters','Control Top Position',1))and (not FlgReniShawUnitExists);
              end;
   pipette:  begin
                             ApproachNScrpt:=ApproachPipetteScrpt;
                             ApproachNOneScrpt:=ApproachPipetteOneScrpt;
                             MTestScrpt:=SMTestScrpt;     //stepmover
                             ApproachParams.TypeMover:=0;
                             ApproachParams.MaxSuppress:=0.5;
                             ApproachParams.flgControlTopPosition:=boolean(ReadInteger('Approach Parameters','Control Top Position',1))and (not FlgReniShawUnitExists);
             end;

   grand:    begin
                             ApproachNScrpt:=ApproachSMScrpt;
                             ApproachNOneScrpt:=ApproachSMOneScrpt;
                             MTestScrpt:=SMTestScrpt;     //stepmover
                             ApproachParams.TypeMover:=0;
                             ApproachParams.MaxSuppress:=1.0;
                             ApproachParams.flgControlTopPosition:=boolean(ReadInteger('Approach Parameters','Control Top Position',1)) and (not FlgReniShawUnitExists);

             end;
                             end;
   //     ApproachParams.PMActiveTime:=50;//
   //    if CurrentUserLevel='Demo' then ApproachParams.flgControlTopPosition:=false;
       ApproachParams.NChannels:=4;
       ApproachParams.PMActiveTime:=ReadInteger('Approach Parameters','PM Active time',20);
       ApproachParams.PMPAUSE:=15;//11/11/2016 ; ReadInteger('Approach Parameters','PM PAUSE',1);
       ScannerMoveXYZParams.PMActiveTime:=ReadInteger('Scannermovexy Parameters','PM Active time',20);
       ScannerMoveXYZParams.PMPAUSE:=15;// 11/11/2016 ReadInteger('Scannermovexy Parameters','PM PAUSE',1);
       ScannermoveXYZParams.XMax:=100;
       ScannermoveXYZParams.YMax:=100;
       ScannermoveXYZParams.StepsNumbSlow:=1;
       ScannermoveXYZParams.StepsNumbFast:=10;
       ScannerMoveXYZParams.StepsCountY:=0;
       ScannerMoveXYZParams.StepsCountX:=0;
       ScannerMoveXYZParams.StepsCountZ:=0;
       ScanParams.TerraTDelay:=ReadInteger('Scanning Parameters','TerraTDelay', 100);
       ScanParams.ScanDrawDelay  :=ReadInteger('Scanning Parameters','ScanDrawDelay', 300);//191211
       ScanParams.LithoDrawDelay :=ReadInteger('Scanning Parameters','LithoDrawDelay',400);//191211
       ScanParams.FastDrawDelay  :=ReadInteger('Scanning Parameters','FastDrawDelay',4000);//05.12.16
       ScanParams.flgOneFrame:=boolean(ReadInteger('Scanning Parameters','OneFrame',1));
       PidParams.Ti:= PidParams.TiApproach;
       ScanParams.TimMeasurePoint:=0.01;//ms
       ScanParams.TimMicroStep:=0.005;// // milisec, minimum Time of one microstep;
       ScanParams.ScanRateLimParameter:= ReadInteger('Scanning Parameters','Rate_Limit_Parameter',400);//300;  // 20/12/2016 this parameter is max valid ratio: NPoints/lineTime_c
       ScanParams.flgMovetoZero:=boolean(ReadInteger('Scanning Parameters','Move to Zero',0));
       //       ScanParams.flgFastSimulator:= boolean(ReadInteger('Scanning Parameters','Fast_Simulation',0));
       ScanParams.WaitForPrepareFastPath:=6000; //ms
    end;
 finally
   iniCSPM.Free;
 end;
end;

procedure SpectrParamsDef;
begin
 with SpectrParams do
 begin
   NSpectrPoints:=1;
   NPoints:=100;
   Step:=3; //nm
             case  flgUnit of
        Terra:begin T:=200; StartP:=-3000;end;
         else begin T:=1; StartP:=-300; end;
               end;

   EndP:=100;//nm
   NCurves:=5;
   if flgUnit<>pipette then LevelSFM:=70
                       else LevelSFM:=30;
   LevelIZ:=200;
   NAv:=3;
   StartV:=-5000;  //mV
   StopV:=5000;
   nchannels:=3;// 4   for terra  parrams channel   040213 
 end;
end;
procedure SetScanParamsDefInitPrev;
begin
  with ScanParams do
    begin
     XPrevious:=-ScanParams.Xshift;
     YPrevious:=-ScanParams.Xshift;
   end;
end;

procedure SetScanParamsDef;
begin
   with ScanParams do
    begin
     if flgSetScanArea then  SetSEMScanAreaDefR;
     nChannels:=4;
     CurrentScanCount:=Nx;
     DACZTimeDelay:=300;
     IntegrDecay:=120;
     TerraTDelay:=200;    //ms
     ScanRate:= 4000; //double, nm/s;
     ScanRateBW:= 8000; //double, nm/s;
     ScanPath:=OneX;//integer; {X+:0;+:1,}
     Microstep:=1;//integer;
     MicrostepDelay:=5;//integer;
     XMicrostepNmb:=100;//integer;
     YMicrostepNmb:=100;//integer;
     PassIIDz:=-100; //nm
     flgTopoLevelDel:=true;
     flgTopoCurLinePlDel:=true; //delete plane Current line windows
     flgTopoTopViewPlDel:=true; //delete plane Top View windows
     flgTopoTopViewSDel:=false; //delete surface Top View windows
     PiezoMoverSzStepsXY:=100;//nm
//     LithoDrawDelay:=400;
//     ScanDrawDelay:=300;
    end;
   with  LithoParams   do
   begin
     TimeAct:=100;   //time action for   lithography
     ScaleAct:=0.5;  //action for lithography
     Amplifier:=1;
     nchannels:=4;  ///?????
   end;
   MoveToScanParams.nchannels:=2;                 //????
end;
procedure SetScanParamsDefSEM;
begin
   with ScanParams do
    begin
     if flgSetScanArea then  SetSEMScanAreaDefR;
     CurrentScanCount:=Nx;
     nChannels:=3;
     DACZTimeDelay:=300;
     IntegrDecay:=120;
     ScanRate:= 4000; //double, nm/s;
     ScanRateBW:= 8000; //double, nm/s;
     ScanPath:=OneX;//integer; {X+:0;+:1,}
     Microstep:=1;//integer;
     MicrostepDelay:=5;//integer;
     XMicrostepNmb:=100;//integer;
     YMicrostepNmb:=100;//integer;
     PassIIDz:=-100; //nm
     flgTopoLevelDel:=true;
     flgTopoCurLinePlDel:=true; //delete plane Current line windows
     flgTopoTopViewPlDel:=true; //delete plane Top View windows
     flgTopoTopViewSDel:=false; //delete surface Top View windows
     PiezoMoverSzStepsXY:=100; //nm
     //LithoDelay:=400;
     //ScanDelay:=300;
    end;
   with  LithoParams   do
   begin
     TimeAct:=100;   //time action for   lithography
     ScaleAct:=0.5;  //action for lithography
     Amplifier:=1;
   end;
    MoveToScanParams.nchannels:=2;
end;
procedure SetScanParamsDefF;
begin
  with ScanParams do
    begin
     if flgSetScanArea then  SetScanAreaDefF;
     CurrentScanCount:=Nx;
     DACZTimeDelay:=300;
     nChannels:=3;
     IntegrDecay:=120;
     //TerraTDelay:=200;
     ScanRate:= 4000; //double, nm/s;
     ScanRateBW:= 8000; //double, nm/s;
     ScanPath:=OneX;//integer; {X+:0;+:1,}
    // LithoDelay:=400;
    // ScanDelay:=300;
     Microstep:=1;//integer;
     MicrostepDelay:=5;//integer;
     XMicrostepNmb:=100;//integer;
     YMicrostepNmb:=100;//integer;
//     StepXY:=X/Nx;
     PassIIDz:=-100; //nm
 //    flgStepXY:=false;      //flg fix step
     flgTopoLevelDel:=true;
     flgTopoCurLinePlDel:=true; //delete plane Current line windows
     flgTopoTopViewPlDel:=true; //delete plane Top View windows
     flgTopoTopViewSDel:=false; //delete surface Top View windows
    end;
     LithoParams.TimeAct:=100;   //time action for   lithography
     LithoParams.ScaleAct:=0.5;  //action for lithography
     LithoParams.Amplifier:=1;
end;
procedure SetScanParamsDefSEMF;
begin
 SetScanAreaDefF;
  with ScanParams do
    begin
     nChannels:=3;
     CurrentScanCount:=Nx;
     DACZTimeDelay:=300;
     IntegrDecay:=120;
     ScanRate:= 4000; //double, nm/s;
     ScanRateBW:= 8000; //double, nm/s;
     ScanPath:=OneX;//integer; {X+:0;+:1,}
     Microstep:=1;//integer;
     MicrostepDelay:=5;//integer;
     XMicrostepNmb:=100;//integer;
     YMicrostepNmb:=100;//integer;
//     StepXY:=X/Nx;
     PassIIDz:=-100; //nm
 //    flgStepXY:=false;      //flg fix step
     flgTopoLevelDel:=true;
     flgTopoCurLinePlDel:=true; //delete plane Current line windows
     flgTopoTopViewPlDel:=true; //delete plane Top View windows
     flgTopoTopViewSDel:=false; //delete surface Top View windows
    end;
     LithoParams.TimeAct:=100;   //time action for   lithography
     LithoParams.ScaleAct:=0.5;  //action for lithography
     LithoParams.Amplifier:=1;
     MoveToScanParams.nchannels:=2;
end;
procedure SetScanParamsDefAtom;
begin
  with ScanParams do
    begin
    if flgSetScanArea then  SetSEMScanAreaDefR;
     nChannels:=3;
     CurrentScanCount:=Nx;
     ScanRate:= 500; //double, nm/s;
     ScanRateBW:= 500; //double, nm/s;
     ScanPath:=OneX;//integer; {X+:0;+:1,}
     DACZTimeDelay:=300;
     IntegrDecay:=120;
     Microstep:=1;//integer;
     MicrostepDelay:=5;//integer;
     XMicrostepNmb:=100;//integer;
     YMicrostepNmb:=100;//integer;
     StepXY:=X/Nx;
     PassIIDz:=-100; //nm
     flgStepXY:=false;      //flg fix step
     flgTopoLevelDel:=true;
     flgTopoCurLinePlDel:=true; //delete plane Current line windows
     flgTopoTopViewPlDel:=true; //delete plane Top View windows
     flgTopoTopViewSDel:=false; //delete surface Top View windows
     PiezoMoverSzStepsXY:=100; //nm
     PiezoMoverStepsZUp:=100;
     PiezoMoverStepsZDown:=100;
     //LithoDelay:=400;
     //ScanDelay:=300;
    end;
     LithoParams.TimeAct:=100;   //time action for   lithography
     LithoParams.ScaleAct:=0.5;  //action for lithography
     LithoParams.Amplifier:=1;
     MoveToScanParams.nchannels:=2;
end;
procedure SetScanParamsDefAtomF;
begin
 SetAtomScanAreaDefF;
  with ScanParams do
    begin
      nChannels:=3;
     CurrentScanCount:=Nx;
     ScanRate:= 500; //double, nm/s;
     ScanRateBW:= 500; //double, nm/s;
     ScanPath:=OneX;//integer; {X+:0;+:1,}
     DACZTimeDelay:=300;
     IntegrDecay:=120;
     Microstep:=1;//integer;
     MicrostepDelay:=5;//integer;
     XMicrostepNmb:=100;//integer;
     YMicrostepNmb:=100;//integer;
     StepXY:=X/Nx;
     PassIIDz:=-100; //nm
     flgStepXY:=false;      //flg fix step
     flgTopoLevelDel:=true;
     flgTopoCurLinePlDel:=true; //delete plane Current line windows
     flgTopoTopViewPlDel:=true; //delete plane Top View windows
     flgTopoTopViewSDel:=false; //delete surface Top View windows
     //LithoDelay:=400;
   //  ScanDelay:=300;
    end;
     LithoParams.TimeAct:=100;   //time action for   lithography
     LithoParams.ScaleAct:=0.5;  //action for lithography
     LithoParams.Amplifier:=1;
     MoveToScanParams.nchannels:=2;
end;

procedure SetScanParamsDefGrand;
begin
  with ScanParams do
    begin
     X:=ScanAreaStartXR;
     Y:=ScanAreaStartYR;
     XBegin:=ScanAreaBeginXR;
     YBegin:=ScanAreaBeginYR;
     NX:=100;
     NY:=100;
     CurrentScanCount:=Nx;
     ScanRate:= 400000; //double, nm/s;
     ScanRateBW:= 800000; //double, nm/s;
     ScanPath:=OneX;//integer; {X+:0;+:1,}
     Microstep:=1;//integer;
     MicrostepDelay:=5;//integer;
     XMicrostepNmb:=100;//integer;
     YMicrostepNmb:=100;//integer;
     StepXY:=X/Nx;
     PassIIDz:=-100; //nm
     flgStepXY:=false;      //flg fix step
     flgSQ:=true;         //flg Square Area  draw
     flgSetScanArea:=true;
     flgTopoLevelDel:=true;
     flgTopoCurLinePlDel:=true; //delete plane Current line windows
     flgTopoTopViewPlDel:=true; //delete plane Top View windows
     flgTopoTopViewSDel:=false; //delete surface Top View windows
    end;
     LithoParams.TimeAct:=100;   //time action for   lithography
     LithoParams.ScaleAct:=0.5;  //action for lithography
     LithoParams.Amplifier:=1;
end;

procedure SetScanParamsDefGrandF;
begin
  with ScanParams do
    begin
     X:=ScanAreaStartXR;
     Y:=ScanAreaStartYR;
     XBegin:=ScanAreaBeginXR;
     YBegin:=ScanAreaBeginYR;
     NX:=100;
     NY:=100;
     CurrentScanCount:=Nx;
     ScanRate:= 400000; //double, nm/s;
     ScanRateBW:= 800000; //double, nm/s;
     ScanPath:=0;//integer; {X+:0;+:1,}
     Microstep:=1;//integer;
     MicrostepDelay:=5;//integer;
     XMicrostepNmb:=100;//integer;
     YMicrostepNmb:=100;//integer;
     StepXY:=X/Nx;
     PassIIDz:=-100; //nm
     flgStepXY:=false;      //flg fix step
     flgSQ:=true;         //flg Square Area  draw
     flgSetScanArea:=true;
     flgTopoLevelDel:=true;
     flgTopoCurLinePlDel:=true; //delete plane Current line windows
     flgTopoTopViewPlDel:=true; //delete plane Top View windows
     flgTopoTopViewSDel:=false; //delete surface Top View windows
    end;
     LithoParams.TimeAct:=100;   //time action for   lithography
     LithoParams.ScaleAct:=0.5;  //action for lithography
     LithoParams.Amplifier:=1;
end;

procedure SetScanAreaDefR;
begin
(*      if flgCurrentUserLevel=Demo then
       begin
        ScanAreaBeginXR:=round(CSPMSignals[8].MaxDiscr/TransformUnit.XPnm_d-Scanparams.xshift);
        ScanAreaBeginYR:=round(CSPMSignals[9].MaxDiscr/TransformUnit.YPnm_d-Scanparams.yshift);
       end
       else
       begin
        ScanAreaBeginXR:=10;
        ScanAreaBeginYR:=10;
       end;
       *)
 with ScanParams do
    begin
     ScanAreaStartXR:=5000;
     ScanAreaStartYR:=5000;
     ScanAreaStartXF:=1000;
     ScanAreaStartYF:=1000;
     ScanAreaBeginXF:=10;
     ScanAreaBeginYF:=10;
     ScanAreaBeginXR:=10;
     ScanAreaBeginYR:=10;
     X:=ScanAreaStartXR;
     Y:=ScanAreaStartYR;
     XBegin:=ScanAreaBeginXR;
     YBegin:=ScanAreaBeginYR;
     if flgReniShawUnit then
     begin
       Xshift:=100*Renishawparams.Period_nm;
       Yshift:=100*Renishawparams.Period_nm; //shift zero point coordinate for renishaw
     end
     else
     begin
       Xshift:=0;//100;  { TODO : 041012 }
       Yshift:=0;//100;
     end;
     NX:=100;
     NY:=100;
     flgSQ:=true; //
  end;
end;
procedure SetSEMScanAreaDefR;
begin
 with ScanParams do
    begin
     ScanAreaStartXR:=3000;
     ScanAreaStartYR:=3000;
     ScanAreaStartXF:=1000;
     ScanAreaStartYF:=1000;
     ScanAreaBeginXF:=10;
     ScanAreaBeginYF:=10;
     ScanAreaBeginXR:=10;
     ScanAreaBeginYR:=10;
     X:=ScanAreaStartXR;
     Y:=ScanAreaStartYR;
     XBegin:=ScanAreaBeginXR;
     YBegin:=ScanAreaBeginYR;
     if flgReniShawUnit then
     begin
       Xshift:=100*Renishawparams.Period_nm;
       Yshift:=100*Renishawparams.Period_nm; //shift zero point coordinate for renishaw
     end
     else
     begin
       Xshift:=0;//100;  { TODO : 041012 }
       Yshift:=0;//100;
     end;
     NX:=100;
     NY:=100;
     flgSQ:=true; //
  end;
end;

procedure SetScanAreaDefF;
begin
 with ScanParams do
    begin
     X:=ScanAreaStartXF;
     Y:=ScanAreaStartYF;
     XBegin:=ScanAreaBeginXF;
     YBegin:=ScanAreaBeginYF;
     if flgReniShawUnit then
     begin
       Xshift:=2*Renishawparams.Period_nm;
       Yshift:=2*Renishawparams.Period_nm; //shift zero point coordinate for renishaw
     end
     else
     begin
       Xshift:=100;
       Yshift:=100;
     end;
     NX:=100;
     NY:=100;
     flgSQ:=true; //
  end;
end;
procedure SetAtomScanAreaDefR;
begin
  with ScanParams do
    begin
     X:=ScanAreaStartXR;
     Y:=ScanAreaStartYR;
     XBegin:=ScanAreaBeginXR;
     YBegin:=ScanAreaBeginYR;
     NX:=100;
     NY:=100;
     flgSQ:=true;         //flg Square Area  draw
    end;
end;
procedure SetAtomScanAreaDefF;
begin
  with ScanParams do
    begin
     X:=ScanAreaStartXF;
     Y:=ScanAreaStartYF;
     XBegin:=ScanAreaBeginXF;
     YBegin:=ScanAreaBeginYF;
     NX:=100;
     NY:=100;
     flgSQ:=true;         //flg Square Area  draw
    end;
end;
procedure SetDemoParamsDef;
begin
 with  DemoParams do
 begin
  Z:=MinApiType+1;
  OscAmp:=MaxApiType-1;
  OscAmplRes:=0;
  TunnelCurrent:=0;
  NZStepsApproach:=5;
  NZStepsFastApproach:=40;
 end;
end;


procedure SDSignalsLast;
var iniCSPM:TiniFile;
      sFile:string;
begin
 sFile:=GetConfigUsersFileName;
  iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
    with ApproachParams do
     begin
    //   ResFreqR:= $80;
     //  ResFreqF:= $80;
       Amp_M:=ReadInteger('Approach Parameters','Amp_M',254);
       Gain_FM:=ReadInteger('Approach Parameters','Gain_FM',128);
   //    Gain_AM:=ReadInteger('Approach Parameters','Gain_AM',100);
    end;
 finally
  iniCSPM.Free;
 end;
end;
procedure SDSignalsDef;
var iniCSPM:TiniFile;
      sFile:string;
begin
    with ApproachParams do
     begin
    //   ResFreqR:= $80;
     //  ResFreqF:= $80;
       Amp_M:=15;//254;       //1000
       Gain_FM:=128;
    //   Gain_AM:=100;
    end;
end;
procedure LoadCurveLinFromIniFile(filename:string;var pAdapterLinModXX,pADapterLinModXY: PAdapterLinPointsRecord);
var
  i:integer;
  PathMode:integer;
  iniCSPM:TiniFile;
  sFile:string;
begin
  sFile:=ScannerIniFilesPath + Filename;
  iniCSPM:=TIniFile.Create(sFile);
try
  (*    pageNmb:integer;
       PageTypeId: integer; //Memorypagetype;
       DataLengthInt:integer;
       intLinearizationDate:integer;
       NPoints:integer;
       Points:array[1..59] of integer;     // array[1..64] of integer;
 *)
  with iniCSPM do
   begin
   PathMode:=ReadInteger(HardWareOpt.ScannerNumb, 'pathmode',0);
   with pAdapterLinModXX^ do
   begin
     case PathMode of
   0: PageNMb:=2;     //X+
   1: PageNMb:=5;
     end;
    PageTypeId:=AdaptPgType_curve;
    DataLengthInt:=64;
    LinearizationDate:=ReadString(HardWareOpt.ScannerNumb,'Linearization Date','31-12-12');
    NPoints:=ReadInteger((HardWareOpt.ScannerNumb), 'X'+'Points Number',1);
    for i:=1 to NPoints do
      begin
       Points[i]:=round(ReadFloatConvert(iniCSPM,(HardWareOpt.ScannerNumb), 'X'+IntToStr(i), 1));
       end;
   end;
    with pAdapterLinModXY^ do
   begin
         case PathMode of
   0: PageNMb:=3;        //X+
   1: PageNMb:=6;
     end;
    PageTypeId:=AdaptPgType_curve;
    DataLengthInt:=64;
    LinearizationDate:=ReadString(HardWareOpt.ScannerNumb,'Linearization Date','31-12-12');
    NPoints:=ReadInteger((HardWareOpt.ScannerNumb), 'Y'+'Points Number',1);
    for i:=1 to NPoints do
      begin
       Points[i]:=Round(ReadFloatConvert(iniCSPM,(HardWareOpt.ScannerNumb), 'Y'+IntToStr(i), 1));
       end;
   end;
 end;
 finally
  iniCSPM.Free;
 end;
end;
procedure LoadPIDConfig;
begin
   LoadPIDParamsDef;
   LoadPIDSTMParamsDef;
   PIDParams:=PIDSFMParams;       //SFM default
end;

procedure LoadScannerParams(flgLoadFromAdapter:boolean);
begin
 if  flgLoadFromAdapter  then LoadScannerOPtGeneralFromAdapter
                         else LoadScannerOptGeneral(ScannerIniFileX,ScannerIniFileY) ;
  ScannerCorrectLast();
  TransformUnitInit;
end;
procedure LoadConfig;
var DiscrVal:integer;
begin
   LoadVideoParams;
   LoadConfigOSC;
   HardWareOptLast;
   CSPMSignalsInit;
   if (flgUnit=ProBeam)or (flgUnit=MicProbe) then ConfigSEMfile:=GetSEMConfigPath;
   SDSignalsLast;
   TransformUnitInit;

     case flgUnit of
   nano,terra,
   Pipette:begin
          if FlgReniShawUnitExists then
          begin
           RenishawParamsDef;
           ReniShawOscParamsDef;
           RenishawParamsLast;
          end;
          SetScanParamsDef;
          SetScanParamsDefInitPrev;
        end;
   baby:begin
          if FlgReniShawUnitExists then  //????
          begin
           RenishawParamsDef;
           ReniShawOscParamsDef;
           RenishawParamsLast;
          end;
          SetScanParamsDefAtom;
          SetScanParamsDefInitPrev;
        end;
   ProBeam,
   MicProbe:
         begin
          if FlgReniShawUnitExists then  //????
          begin
           RenishawParamsDef;
           ReniShawOscParamsDef;
           RenishawParamsLast;
          end;
          SetScanParamsDefSEM;
          SetScanParamsDefInitPrev;
        end;
  grand:begin
         SetScanParamsDefGrand;
        end;
         end;
   ResonanceParamsDef;
   SpectrParamsDef;
   SetDemoParamsDef;
   ScannerMovXYZParamsDef;
end;
procedure LoadVideoParams;
 var iniCSPM:TiniFile;
       sFile:string;
       str:string;
begin
// Reading Params Value from IniFile
 sFile:=GetConfigUsersFileName;
  iniCSPM:=TIniFile.Create(sFile);
 try
   with iniCSPM do
  begin
       flgRunFirmCamera:=ReadInteger('Video','FirmCamera',0) ;
       FirmCameraWinName:='CTLVCentral3.exe'; //  FirmCameraWinName:=ReadString('Video','FirmCameraWinName','');
       FirmCameraSoftPath:=ReadString('Video','FirmCameraSoftPath','');
  end;
 finally
    iniCSPM.Free;
 end;
end;
procedure SaveVideoParams;
 var iniCSPM:TiniFile;
       sFile:string;
       str:string;
begin
// Reading Params Value from IniFile
 sFile:=GetConfigUsersFileName;
  iniCSPM:=TIniFile.Create(sFile);
 try
   with iniCSPM do
  begin
       WriteInteger('Video','FirmCamera',flgRunFirmCamera) ;
       WriteString('Video','FirmCameraWinName',FirmCameraWinName);
       WriteString('Video','FirmCameraSoftPath',FirmCameraSoftPath);
  end;
 finally
    iniCSPM.Free;
 end;
end;
procedure SaveConfigUsers;
var FL:File;
    iniCSPM:TiniFile;
    sFile:string;
    YSectionBias:single;
    ww:string;
begin

 SaveConfigOSC;

 SaveConfigPID;

 sFile:=ConfigUsersIniFilePath + ConfigUsersIniFile;
 if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    Rewrite(FL);
    CloseFile(FL);
  end;
 // SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
//  iniCSPM.WriteString('Files','Main', ExeFilePath{ ParamStr(0)});
  iniCSPM.WriteString('Files','Work Directory',WorkDirectory);
  iniCSPM.WriteBool('Install parameters','first time stm',flgfirsttimestm);
  iniCSPM.WriteBool('Install parameters','first time sfm',flgfirsttimesfm);
  iniCSPM.WriteString('Files','View Directory',OpenDirectory);
  iniCSPM.WriteString('Files','Litho Template Directory',LithoTemplDirectory);
  ww:='false' ;
  if flgShowWellcomeWindow then ww:='true';
  iniCSPM.WriteString('Users','Show welcome window',ww);

  with iniCSPM do
   begin
   // Approach Parameters
   if STMFlg then
    begin
       WriteString('STM Approach Parameters','BiasV',FloatToStrF( ApproachParams.BiasV,ffFixed,5,3));
       WriteInteger('STM Approach Parameters','FreqBandF', ApproachParams.FreqBandF);
       WriteInteger('STM Approach Parameters','FreqBandR', ApproachParams.FreqBandR);
       WriteInteger('STM Approach Parameters',' ScannerDecay', ApproachParams.ScannerDecay);
       WriteInteger('STM Approach Parameters',' IntegratorDelay', ApproachParams.IntegratorDelay);
       WriteString('STM Approach Parameters','ZGateMax', FloatToStrF(ApproachParams.ZGateMax,ffFixed,3,2));
       WriteString('STM Approach Parameters','ZGateMin', FloatToStrF(ApproachParams.ZGateMin,ffFixed,3,2));
       WriteString('STM Approach Parameters','LevelIT', FloatToStrF(ApproachParams.LevelIT,ffFixed,3,2));
       WriteInteger('STM Approach Parameters','ZUpStepsNumb', abs(ApproachParams.ZUpStepsNumb));
       WriteInteger('STM Approach Parameters','ZFastStepsNumb', abs(ApproachParams.ZFastStepsNumb));
       WriteString('STM Approach Parameters','ScaleMaxIT', FloatToStrF(ApproachParams.ScaleMaxIT,ffFixed,4,2));
       WriteString('STM Approach Parameters','ScaleMaxIT', FloatToStrF(ApproachParams.ScaleMaxIT,ffFixed,4,2));
    if flgUnit<>pipette then
       WriteString('STM Approach Parameters','MaxITIndicatorNonePipe', IntToStr(ApproachParams.MaxITindicator))
       else
       WriteString('STM Approach Parameters','MaxITIndicator', IntToStr(ApproachParams.MaxITindicator));

    end
    else
    begin
       WriteString('Approach Parameters','SetPoint', FloatToStrF(ApproachParams.SetPoint,ffFixed,4,2));
       WriteString('Approach Parameters','BiasV', FloatToStrF(ApproachParams.BiasV,ffFixed,5,2));
       WriteInteger('Approach Parameters','FreqBandF', ApproachParams.FreqBandF);
       WriteInteger('Approach Parameters','FreqBandR', ApproachParams.FreqBandR);
       WriteInteger('Approach Parameters',' ScannerDecay', ApproachParams.ScannerDecay);
       WriteInteger('Approach Parameters',' IntegratorDelay', ApproachParams.IntegratorDelay);
       WriteString('Approach Parameters','ZGateMax', FloatToStrF(ApproachParams.ZGateMax,ffFixed,3,2));
       WriteString('Approach Parameters','ZGateMin', FloatToStrF(ApproachParams.ZGateMin,ffFixed,3,2));
       WriteString('Approach Parameters','LevelUAM', FloatToStrF(ApproachParams.LevelUAM,ffFixed,3,2));
       WriteInteger('Approach Parameters','ZUpStepsNumb', abs(ApproachParams.ZUpStepsNumb));
       WriteInteger('Approach Parameters','ZFastStepsNumb', abs(ApproachParams.ZFastStepsNumb));
       WriteString('Approach Parameters','ExtremAmplitude', FloatToStrF(ApproachParams.ExtremAmplitude,ffFixed,4,2));
  //     WriteString('Approach Parameters','MaxSuppress', FloatToStrF(ApproachParams.MaxSuppress,ffFixed,4,2));
       WriteInteger('Approach Parameters','MaxAmp_M', ApproachParams.MaxAmp_M);
       WriteInteger('Approach Parameters','Amp_M', ApproachParams.Amp_M);
       WriteInteger('Approach Parameters','Gain_FM',ApproachParams.Gain_FM);
    //   WriteInteger('Approach Parameters','Gain_AM',ApproachParams.Gain_AM);
    end;
       WriteString('STM Approach Parameters','IMaxCut', FloatToStrF(ApproachParams.IMaxCut,ffFixed,4,2));
       WriteBool('Approach Parameters','Autorun Camera', ApproachParams.flgAutorunCamera);
       WriteInteger('Approach Parameters','PM Active time', ApproachParams.PMActiveTime);
       WriteInteger('Approach Parameters','PM PAUSE', ApproachParams.PMPAUSE);

       WriteInteger('Scanning Parameters','TerraTDelay',ScanParams.TerraTDelay);
       WriteInteger('Scanning Parameters','LithoDrawDelay',ScanParams.LithoDrawDelay);
       WriteInteger('Scanning Parameters','ScanDrawDelay',ScanParams.ScanDrawDelay);
       WriteInteger('Scanning Parameters','FastDrawDelay',ScanParams.FastDrawDelay);
       WriteInteger('Scanning Parameters','Rate_Limit_Parameter',round(ScanParams.ScanRateLimParameter));
       WriteInteger('Scanning Parameters','Fast_Simulation',integer(ScanParams.flgFastSimulator));
       WriteInteger('Scannermovexy Parameters','PM Active time', ScannermoveXYZParams.PMActiveTime);
       WriteInteger('Scannermovexy Parameters','PM PAUSE', ScannermoveXYZParams.PMPAUSE);

 if (flgUnit=Nano) or (flgUnit=pipette) or (flgUnit=terra) or (flgUnit=ProBeam) or (flgUnit=MicProbe) then  WriteInteger('Approach Parameters','Control Top Position',integer(ApproachParams.flgControlTopPosition));
    if ApproachParams.TypeMover=0 then  WriteString('Approach Parameters','Type Mover','stepmover')
                                  else  WriteString('Approach Parameters','Type Mover','piezomover');

 //     WriteInteger('Physical Unit Options','Use Flash drive',byte(HardWareOpt.flgFlash));
 //     if  HardWareOpt.flgFlash then  HardWareOpt.flgAutoScanner:=1;
//      WriteInteger('Physical Unit Options','Set Scanner Number Auto',HardWareOpt.flgAutoScanner);

   //Physical Unit Options:

             case  flgUNit of
  baby:        WriteString('Physical Unit Options','Scanner Number Atom Unit',HardWareOpt.ScannerNumb);
  ProBeam,MicProbe:  begin
                       WriteInteger('Resonance','FreqStartRough',ResonanceParams.FreqStartRough);
                       WriteInteger('Resonance','FreqEndRough',ResonanceParams.FreqEndRough);
                     end;
  nano,Pipette,terra:begin
                      //debug
                      if HardWareOpt.ScannerNumb=' ' then  NoFormUnitLoc.silang1.showmessage('scanner= ');
                      WriteString('Physical Unit Options','Scanner Number',HardWareOpt.ScannerNumb);
                    end;
  grand:
                     end;
     //Analog HardWare Options
      WriteString('Analog HardWare Options','Electronic Number',HardWareOpt.ElectronicNumb);
    end;
//   { TODO : 101008 }
//    SetScriptsName;
//    SetFileAttribute_ReadOnly(sfile,true);
   finally
     IniCSPM.Free;
   end;
end;
(*procedure SaveConfig;
var FL:File;
    iniCSPM:TiniFile;
    sFile:string;
begin
 sFile:=ConfigIniFilePath + ConfigIniFile;
 if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    Rewrite(FL);
    CloseFile(FL);
  end;
 // SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
   with iniCSPM do
   begin
      WriteString('Analog HardWare Options', 'UFBMaxOUT',FloatToStrF(HardWareOpt.UFBMaxOUT,ffFixed,5,2));
      WriteString('Analog HardWare Options', 'TappingKoef',FloatToStrF(HardWareOpt.TappingKoef,ffFixed,5,2));
      WriteInteger('Analog HardWare Options', 'NewElectronic',1)
   end;
//    SetFileAttribute_ReadOnly(sfile,true);
   finally
     IniCSPM.Free;
   end;
end;
*)
procedure ConfigDef;   //first start
var FL:File;
    iniCSPM:TiniFile;
    sFile:string;
begin
 sFile:=ConfigUsersIniFilePath + ConfigUsersIniFile;
 if (not FileExists(sFile)) then
  begin
    NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Config Ini File '}+sFile);
   end;
    iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
    begin
       WriteString('Users','User Level','Demo');
       WriteString('Files','Work Directory',UserNanoeduDocumentsPath);
  //     WriteInteger('Physical Unit Options','Set Scanner Number Auto',1);
 //      WriteInteger('Physical Unit Options','Use Flash drive',1);
       WriteString('Users','Show Welcome Window','true');
    end;
  finally
    iniCSPM.Free;
  end;
end;
procedure LoadConfigOSC;   //first start
var FL:File;
    iniCSPM:TiniFile;
    sFile:string;
begin
 sFile:=ConfigUsersIniFilePath + OSCConfigIniFile;
 if (not FileExists(sFile)) then
  begin
  //  NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Config Ini File '}+sFile);
   end;
    iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
    begin
             OSCParams.NameChannel1:=ReadString('Signals','Channel1','X');
             OSCParams.NameChannel2:=ReadString('Signals','Channel2','Y');
      end;
  finally
    iniCSPM.Free;
  end;


end;
procedure SaveConfigOSC;   //first start
var FL:File;
    iniCSPM:TiniFile;
    sFile:string;
begin
 sFile:=ConfigUsersIniFilePath + OSCConfigIniFile;
 if (not FileExists(sFile)) then
  begin
  //  NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Config Ini File '}+sFile);
   end;
    iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
    begin
       WriteString('SIGNALS','Channel1',OSCParams.NameChannel1);
       WriteString('SIGNALS','Channel2',OSCParams.NameChannel2);
    end;
  finally
    iniCSPM.Free;
  end;
end;
procedure LoadConfigPID;   //first start
var FL:File;
    iniCSPM:TiniFile;
    sFile:string;
begin
 sFile:=ConfigUsersIniFilePath + PIDConfigIniFile;
 if (not FileExists(sFile)) then
  begin
//    NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Config Ini File '}+sFile);
   end;
    iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
    begin
             with    PIDParams do
             begin
              dT:=ReadInteger('PARAMETERS','dT',100);
              Te:=ReadDoubleConvert(iniCSPM,'PARAMETERS','Te',0.0);
              TiScan:=ReadDoubleConvert(iniCSPM,'PARAMETERS','Ti',15.0);    //-15
              Td:=ReadDoubleConvert(iniCSPM,'PARAMETERS','Td',0.0);
             end;
    end;
  finally
    iniCSPM.Free;
  end;
end;
procedure SaveConfigPID;   //first start
var FL:File;
    iniCSPM:TiniFile;
    sFile:string;
begin
 sFile:=ConfigUsersIniFilePath + PIDConfigIniFile;
 if (not FileExists(sFile)) then
  begin
    NoFormUnitLoc.silang1.ShowMessage(strcom5{'No Config Ini File '}+sFile);
   end;
    iniCSPM:=TIniFile.Create(sFile);
  try
   with iniCSPM do
    begin
     with  PIDParams  do
     begin
       WriteInteger('PARAMETERS','dT',dT);
       WriteString('PARAMETERS','Te',FloatToStrf(Te, fffixed,5,2));
       WriteString('PARAMETERS','Ti',FloatToStrf(TiScan, fffixed,5,2));
       WriteString('PARAMETERS','Td',FloatToStrf(Td, fffixed,5,2));
     end;
    end;
  finally
    iniCSPM.Free;
  end;
end;
procedure SaveCorrectedI_VTranformParams(ScannerOpt:RScannerOptMod); //correction I_V //281210
var FL:File;
    iniCSPM:TIniFile;
    sFile:string;
    OtherDirIniFile:string;
    YSectionBias:single;
begin
 flgSaveProcess:=true;
 sFile:=ScannerIniFilesPath + ScannerIniFile;
if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    ReWrite(FL);
    CloseFile(FL);
  end;
//try
  SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
  begin
   with   ScannerOpt     do
    begin
     try
      WriteString((HardWareOpt.ScannerNumb),'I_VTransfKoef',FloatToStrF(I_VTransfKoef,ffFixed,3,0)); //281210
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
      end;
  end;
 finally
  IniCSPM.Free;
 end;
  SetFileAttribute_ReadOnly(sfile,true);
  case  ScanParams.ScanPath of
    OneX:  OtherDirIniFile:= ScannerIniFileY;
    OneY:  OtherDirIniFile:= ScannerIniFileX;
   end;

    sFile:=ScannerIniFilesPath + OtherDirIniFile;
if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    ReWrite(FL);
    CloseFile(FL);
  end;
  SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
   with   ScannerOpt     do
      begin
       WriteString((HardWareOpt.ScannerNumb),'I_VTransfKoef',FloatToStrF(I_VTransfKoef,ffFixed,3,0));
      end;

  SetFileAttribute_ReadOnly(sfile,true);
//{$I-}
 flgSaveProcess:=false;
 finally
   IniCSPM.Free;
 end;
end;

procedure SaveScannerParams;
var FL:File;
    iniCSPM:TIniFile;
    sFile:string;
    OtherDirIniFile:string;
    YSectionBias:single;
begin
 flgSaveProcess:=true;
 sFile:=ScannerIniFilesPath + ScannerIniFile;
if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    ReWrite(FL);
    CloseFile(FL);
  end;
//try
  SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
  begin
   with   ScannerCorrect     do
    begin
       WriteInteger((HardWareOpt.ScannerNumb), 'NonLiniar Field X',NonLinFieldX);
       WriteInteger((HardWareOpt.ScannerNumb), 'NonLiniar Field Y',NonLinFieldY);
       WriteInteger((HardWareOpt.ScannerNumb), 'Grid Cell Size',GridCellSize);
       YSectionBias:=180*arctan2(YBiasTan,1)/pi;    // degrees
       WriteString((HardWareOpt.ScannerNumb), ' Y Section Bias(degrees)',FloatToStrF(YSectionBias,ffFixed,4,2));
       WriteString((HardWareOpt.ScannerNumb),'SensitivZ',FloatToStrF(SensitivZ,ffFixed,6,2));
       WriteString((HardWareOpt.ScannerNumb),'SensitivX',FloatToStrF(SensitivX,ffFixed,6,2));
       WriteString((HardWareOpt.ScannerNumb),'SensitivY',FloatToStrF(SensitivY,ffFixed,6,2));
       WriteString((HardWareOpt.ScannerNumb),'I_VTransfKoef',FloatToStrF(I_VTransfKoef,ffFixed,3,0)); //281210
     end;
  end;
 finally
  IniCSPM.Free;
 end;
  SetFileAttribute_ReadOnly(sfile,true);
  case  ScanParams.ScanPath of
    OneX:  OtherDirIniFile:= ScannerIniFileY;
    OneY:  OtherDirIniFile:= ScannerIniFileX;
   end;

    sFile:=ScannerIniFilesPath + OtherDirIniFile;
if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    ReWrite(FL);
    CloseFile(FL);
  end;
  SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
   with   ScannerCorrect     do
      begin
       WriteInteger((HardWareOpt.ScannerNumb), 'Grid Cell Size',GridCellSize);
       WriteString((HardWareOpt.ScannerNumb), ' Y Section Bias(degrees)',FloatToStrF(YSectionBias,ffFixed,4,2));
       WriteString((HardWareOpt.ScannerNumb),'SensitivZ',FloatToStrF(SensitivZ,ffFixed,6,2));
       WriteString((HardWareOpt.ScannerNumb),'I_VTransfKoef',FloatToStrF(I_VTransfKoef,ffFixed,3,0));
      end;

  SetFileAttribute_ReadOnly(sfile,true);
//{$I-}
 flgSaveProcess:=false;
 finally
   IniCSPM.Free;
 end;
end;
procedure SaveAdapterDataToInifiles;
var i:integer;
    FL:File;
    iniCSPM:TIniFile;
    sFile:string;
    OtherDirIniFile:string;
    YSectionBias:single;
begin
 flgSaveProcess:=true;
 sFile:=ScannerIniFilesPath + ScannerIniFile;
if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    ReWrite(FL);
    CloseFile(FL);
  end;
  SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
  begin
    eraseSection(HardWareOpt.ScannerNumb);   // очистка файла
       with ScannerOptModX do
        begin
           WriteInteger((HardWareOpt.ScannerNumb), 'pathmode',pathmode);
           WriteInteger((HardWareOpt.ScannerNumb), 'NonLiniar Field X',NonLinFieldX);
           WriteInteger((HardWareOpt.ScannerNumb), 'NonLiniar Field Y',NonLinFieldY);
           WriteInteger((HardWareOpt.ScannerNumb), 'Grid Cell Size',GridCellSize);
           YSectionBias:=180*arctan2(YBiasTan,1)/pi;    // degrees
           WriteString((HardWareOpt.ScannerNumb), ' Y Section Bias(degrees)',FloatToStrF(YSectionBias,ffFixed,4,2));
           WriteString((HardWareOpt.ScannerNumb),'SensitivZ',FloatToStrF(SensitivZ,ffFixed,6,2));
           WriteString((HardWareOpt.ScannerNumb),'SensitivX',FloatToStrF(SensitivX,ffFixed,6,2));
           WriteString((HardWareOpt.ScannerNumb),'SensitivY',FloatToStrF(SensitivY,ffFixed,6,2));
           WriteString((HardWareOpt.ScannerNumb),'I_VTransfKoef',FloatToStrF(I_VTransfKoef,ffFixed,3,0)); //281210
        end;
        with  PAdapterLinModXAxisX^ do
        begin
            WriteString(HardWareOpt.ScannerNumb, 'Linearization Date',LinearizationDate);
            WriteString(HardWareOpt.ScannerNumb, 'XPoints Number',InttoStr(NPoints));
            for i:=1  to NPoints  do
             WriteInteger(HardWareOpt.ScannerNumb, 'X'+inttostr(i),Points[i]);
        end;
        with  PAdapterLinModXAxisY^ do
        begin

            WriteString(HardWareOpt.ScannerNumb, 'YPoints Number',InttoStr(NPoints));
            for i:=1 to NPoints  do
             WriteInteger(HardWareOpt.ScannerNumb, 'Y'+inttostr(i),Points[i]);
        end;
  end;
 finally
    IniCSPM.Free;
 end;
  sFile:=ScannerIniFilesPath + ScannerIniFileY;
if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    ReWrite(FL);
    CloseFile(FL);
  end;
  SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
  begin
       eraseSection(HardWareOpt.ScannerNumb);   // очистка файла
       with ScannerOptModY do
        begin
           WriteInteger((HardWareOpt.ScannerNumb), 'pathmode',pathmode);
           WriteInteger((HardWareOpt.ScannerNumb), 'NonLiniar Field X',NonLinFieldX);
           WriteInteger((HardWareOpt.ScannerNumb), 'NonLiniar Field Y',NonLinFieldY);
           WriteInteger((HardWareOpt.ScannerNumb), 'Grid Cell Size',GridCellSize);
           YSectionBias:=180*arctan2(YBiasTan,1)/pi;    // degrees
           WriteString((HardWareOpt.ScannerNumb), ' Y Section Bias(degrees)',FloatToStrF(YSectionBias,ffFixed,4,2));
           WriteString((HardWareOpt.ScannerNumb),'SensitivZ',FloatToStrF(SensitivZ,ffFixed,6,2));
           WriteString((HardWareOpt.ScannerNumb),'SensitivX',FloatToStrF(SensitivX,ffFixed,6,2));
           WriteString((HardWareOpt.ScannerNumb),'SensitivY',FloatToStrF(SensitivY,ffFixed,6,2));
           WriteString((HardWareOpt.ScannerNumb),'I_VTransfKoef',FloatToStrF(I_VTransfKoef,ffFixed,3,0)); //281210
        end;
        with  PAdapterLinModYAxisX^ do
        begin
            WriteString(HardWareOpt.ScannerNumb, 'Linearization Date',LinearizationDate);
             WriteString(HardWareOpt.ScannerNumb, 'XPoints Number',InttoStr(NPoints));
            for i:=1  to NPoints  do
             WriteInteger(HardWareOpt.ScannerNumb, 'X'+inttostr(i),Points[i]);
        end;
        with  PAdapterLinModYAxisY^ do
        begin
            WriteString(HardWareOpt.ScannerNumb, 'YPoints Number',InttoStr(NPoints));
            for i:=1  to NPoints do
             WriteInteger(HardWareOpt.ScannerNumb, 'Y'+inttostr(i),Points[i]);
        end;
  end;
 finally
    IniCSPM.Free;
 end;
end;
procedure LoadScannerOPtGeneralFromAdapter;
begin
  {$IFDEF DEBUG}
 //   Formlog.memolog.Lines.add('set scanner parameters adapter ');
  {$ENDIF};
 ScannerIniFilesPath:=  ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';//  ExeFilePath;//
 ScannerDefIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
 ScannerCorrectLastModeFromAdapter(ScannerOptModX,PAdapterOptModX);
 ScannerCorrectLastModeFromAdapter(ScannerOptModY,PAdapterOptModY);
end;
procedure InitPIDFine(Val:PidType; MaxAbsVal:PidType;var MinFineLimit, MaxFineLimit:PidType);
var fineScalelen2:PidType;
begin
   fineScalelen2:= MaxAbsVal/PidParams.fineScale/2;
   if (Val-fineScalelen2>0) and (Val+fineScalelen2<MaxAbsVal) then begin
                            MinFineLimit:=Val-fineScalelen2;
                            MaxFineLimit:= Val+fineScalelen2;
                           end
                      else begin
                            if Val-fineScalelen2<=0 then
                                  begin
                                     MinFineLimit:=0;
                                     MaxFineLimit:=2*fineScalelen2;
                                  end;
                             if Val+fineScalelen2>=MaxAbsVal then
                                 begin
                                    MinFineLimit:=MaxAbsVal-2*fineScalelen2;
                                    MaxFineLimit:=MaxAbsVal;
                                 end;
                           end;

   MinFineLimit:=round(MinFineLimit);
   MaxFineLimit:=round(MaxFineLimit);
end;
procedure InitPIDRough(Val:PidType; MaxAbsVal:PidType;var MinFineLimit, MaxFineLimit:PidType);
var fineScalelen2:PidType;
begin

   fineScalelen2:= MaxAbsVal/PidParams.fineScale/2;
   if (Val-fineScalelen2>0) and (Val+fineScalelen2<MaxAbsVal) then begin
                            MinFineLimit:=Val-fineScalelen2;
                            MaxFineLimit:= Val+fineScalelen2;
                           end
                      else begin
                            if Val-fineScalelen2<=0 then
                                  begin
                                     MinFineLimit:=0;
                                     MaxFineLimit:=2*fineScalelen2;
                                  end;
                             if Val+fineScalelen2>=MaxAbsVal then
                                 begin
                                    MinFineLimit:=MaxAbsVal-2*fineScalelen2;
                                    MaxFineLimit:=MaxAbsVal;
                                 end;
                           end;

   MinFineLimit:=round(MinFineLimit);
   MaxFineLimit:=round(MaxFineLimit);
end;
(*
procedure CreateScannerData(PageNmb:integer; Inifilename:string; var dataArray:ArrayInt);
Var iniDataLength:integer;
    i, cnt:integer;

    ScannerOpt:RScannerOptMod;

begin
 ScannerCorrectLastMod(Inifilename, ScannerOpt,);  // Fills the structure ScannerOpt:RScannerOptMod

  ScannerIniFile:= Inifilename;                              // Without Path
  GetSpline(HardWareOpt.ScannerNumb,'X', XXSp,YXSp,NXSplines);   // Считываются из текущего ини файла данные
                                                                  //для оси 'X' в массив YXSp (XXSp - отсчеты по 3 мкм)


  GetSpline(HardWareOpt.ScannerNumb,'Y', XYSp,YYSp,NYSplines);      // Считываются из текущего ини файла данные
                                                                  //для оси 'Y' в массив XYSp (XXSp - отсчеты по 3 мкм)

  iniDataLength:=1+  // data length
                 1+   // pagenmb
                 11+ // data from ini file
                 1+  // NXSplines
                 1+   // NYSplines
                 NXSplines+  // X axis Linearization

                 NYSplines;  // Y axis Linearization
  Finalize(DataArray);
  setLength(DataArray, iniDataLength);
  cnt:=0;
  with ScannerOpt do
    begin
       DataArray[0]:= iniDataLength;
       DataArray[1]:= pagenmb;
       DataArray[2]:= ConvertLinDateToInt(LinearizationDate);
       DataArray[3]:= round(DZdclnX);
       DataArray[4]:= round(DZdclnY);
       DataArray[5]:= round(NonLinFieldX);
       DataArray[6]:= round(NonLinFieldY);     //nm
       DataArray[7]:= GridCellSize; //nm
       DataArray[8]:= round(YBiasTan);   // tang of angle between OY and Y-Section (22.01.03, Olya)
       DataArray[9]:= round(SensitivZ);
       DataArray[10]:= round(SensitivX);
       DataArray[11]:= round(SensitivY);
       DataArray[12]:= round(I_VTransfKoef);
    end;
    DataArray[13]:=NXSplines;
    DataArray[14]:=NYSplines;
    inc(cnt,15);
    for I := 0 to NXSplines - 1 do
       DataArray[15+i]:=round(YXSp[i+1]);
   for I := 0 to NYSplines - 1 do
       DataArray[15+NXSplines+i]:=round(YYSp[i+1]);
  end;
*)
function SaveMLPCDataAsINI(dataArray:ArrayInt; ScannerFileName:string):integer;
var NLinField:integer;
 i,L:integer;
  iniCSPM:TiniFile;
  Present: TDateTime;
  presentdate:string;
  Year, Month, Day, Hour, Minute, Sec, MSec: Word;
  OldPointNumb:integer;
  sday,smonth:string;
  Dir:string;
  date, datecode:string;
  XPointsCount, YPointsCount:integer;
begin
 result:=0;
 L:=dataArray[0];

  SetFileAttribute_ReadOnly(ScannerFileName,false);
  if fileexists(ScannerFileName) then Deletefile(ScannerFileName);
  datecode:=InttoStr(dataArray[2]);
  date:='';
  if datecode[1] = '9' then  datecode[1]:='0'; // "9" был записан, если первым при сохранении
                                          // даты был 0
  date:=datecode[1]+ datecode[2]+'-'+datecode[3]+datecode[4]+'-'+
             datecode[5]+datecode[6]+datecode[7]+datecode[8];
 iniCSPM:=TIniFile.Create(ScannerFileName);

try
 with iniCSPM do
   begin
   Try
     WriteString((HardWareOpt.ScannerNumb), 'Linearization Date',date);
   except
     on IO: EInOutError do
        begin
            case IO.Errorcode  of
       104:  MessageDlg('error write flash',mtWarning,[mbOk],0);
         end;

        end;
     else
       begin
        result:=1;
        flgSaveProcess:=false;
 //       siLang1.MessageDlg(str1{'error write flash'},mtWarning,[mbOk],0);
        iniCSPM.free;
        Exit;
        end;
   end;
      WriteInteger((HardWareOpt.ScannerNumb), 'Plane del tanx',dataArray[3]);
      WriteInteger((HardWareOpt.ScannerNumb), 'Plane del tany',dataArray[4]);
      WriteInteger(HardWareOpt.ScannerNumb, 'NonLiniar Field '+'X', dataArray[5] );
      WriteInteger(HardWareOpt.ScannerNumb, 'NonLiniar Field '+'Y', dataArray[6] );
      WriteInteger((HardWareOpt.ScannerNumb), 'Grid Cell Size',dataArray[7]);
      WriteInteger((HardWareOpt.ScannerNumb), ' Y Section Bias(degrees)',dataArray[8]);
      WriteString((HardWareOpt.ScannerNumb),'Sensitiv'+'Z', InttoStr(DataArray[9]));
      WriteString((HardWareOpt.ScannerNumb),'Sensitiv'+'X', InttoStr(DataArray[10]));
      WriteString((HardWareOpt.ScannerNumb),'Sensitiv'+'Y', InttoStr(DataArray[11]));
      WriteInteger((HardWareOpt.ScannerNumb),'I_VTransfKoef',DataArray[12]);

        XPointsCount:=dataArray[13];
        YPointsCount:=dataArray[14];
        WriteInteger(HardWareOpt.ScannerNumb, 'X'+'Points Number', XPointsCount);
        WriteInteger(HardWareOpt.ScannerNumb, 'Y'+'Points Number',YPointsCount);

       for i:=0 to  XPointsCount-1 do
           WriteString((HardWareOpt.ScannerNumb), 'X'+IntToStr(i+1),
                  InttoStr(dataArray[i+15]));
       for i:=0 to  YPointsCount-1 do
           WriteString((HardWareOpt.ScannerNumb), 'Y'+IntToStr(i+1),
                  InttoStr(dataArray[i+15+XPointsCount]));
       end;

finally
     iniCSPM.Free;
end;

end;

(*
procedure WriteScannerIniToMLPC(StartPageNmb:integer; Inifilename:string; var PagesNmb:integer);
var LdataArray:ArrayInt;
    //Method:T
    n,L:integer;
begin
   Finalize(LdataArray);
   CreateScannerData(StartPageNmb, Inifilename, LdataArray);
   L:= length(LdataArray);
   n:= L div 64;
   if n*64 = L then  PagesNmb:=n
               else  PagesNmb:=n+1;

   Nanoedu.WritetoMLPCMethod(LdataArray);
   Nanoedu.Method.Launch;
   WaitforJavanotActive;
   Finalize( LdataArray);
   FreeandNil(Nanoedu.Method);
end;
*)
function ConvertLinDateToInt(date:string):integer;
var ss, s1:string;
   l,i:integer;
begin
// date format = DD-MM-YYYY , example 03-04-2012
  ss:='';
  l:=length(date);
  if date[1] ='0' then   date[1]:='9';
  
  for i:=1 to l do
    begin
      s1:=date[i];
      if s1<>'-' then
      ss:=ss+S1;
    end;

  try
  result:=StrtoInt(ss);
  except
   on EConvertError do
    begin
      result:=-1;
    end;
  end;
end;

function ConvertLinDateToStr(date:integer):string;
var ss:string;
begin

end;

 function    ReadFormSizeandPosition(var frmparams:rformparam):boolean;
 var inifile:TiniFile;
       sFile:string;
       str:string;
begin
// Reading Params Value from IniFile
  sFile:=ConfigUsersIniFilePath+ConfigMainForm;
 if FileExists(sFile) then
  begin
   inifile:=TIniFile.Create(sFile);
 try
  with inifile do
  begin
   frmparams.top:=ReadInteger('position','top',0);
   frmparams.left:=ReadInteger('position','left',0);
   frmparams.width:=ReadInteger('position','width',0);
   frmparams.height:=ReadInteger('position','height',0)
  end;
 finally
   inifile.Free;
 end;
  result:=true;
 end
 else
  result:=false;
 // messagedlg(BaseForm.siLang.GetTextOrDefault('IDS_428' (* 'file ' *) )+sfile+BaseForm.siLang.GetTextOrDefault('IDS_430' (* ' not exists' *) ),mtwarning,[mbOK],0);
end;

function    SaveFormSizeandPosition(frmparams:rformparam):boolean;
 var inifile:TiniFile;
       sFile:string;
       str:string;
begin
// Saving Params Value to IniFile
  sFile:=ConfigUsersIniFilePath+ConfigMainForm;
 if FileExists(sFile) then
  begin
   inifile:=TIniFile.Create(sFile);
 try
   with inifile do
   begin
      WriteInteger('position','top',frmparams.top);
      WriteInteger('position','left',frmparams.left);
      WriteInteger('position','width',frmparams.width);
      WriteInteger('position','height',frmparams.height);
   end;
 finally
   inifile.Free;
 end;
  result:=true;
 end
 else
  result:=false;
 // messagedlg(BaseForm.siLang.GetTextOrDefault('IDS_428' (* 'file ' *) )+sfile+BaseForm.siLang.GetTextOrDefault('IDS_430' (* ' not exists' *) ),mtwarning,[mbOK],0);
end;
end.


