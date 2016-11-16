//161003
unit  mHardWareOpt;

interface

uses Windows,Forms, Messages, SysUtils, Classes,IniFiles,Dialogs;

procedure HardWareOptLast;
procedure ConfigOptLast;
procedure ConfigUsersOptLast;
procedure ControllerOptLast(const FileName:string);
procedure CSPMSignalsInit;
procedure TransformUnitInit;
function  ControllerNumClick:string;
function  Voltage_toDiscr(dir:string; VoltVal:single; var DiscrVal:integer; var nmVal:integer): integer;      // nm

implementation

uses CSPMVar,GlobalVar,GlobalFunction,SioCSPM,UNanoEduBaseClasses,frNoFormUnitLoc;

procedure HardWareOptLast;
begin
   ConfigOptLast;
   ConfigUsersOptLast;
   ControllerOptLast(ControllerIniFile);
end;

function ControllerNumClick:string;
var sernum:PWideChar;
    len:pDword;
    tst:DWord;
begin
(* GetMem(sernum,Max_path);
 new(len);
 len^:=255;
 tst:=GetSerialNumber(sernum,len);
 if tst=0 then  Result:=string(sernum)
          else  Result:='error';
 dispose(len); //nil
 FreeMem(sernum);
 *)
end;


procedure ConfigOptLast;
 var iniCSPM:TiniFile;
       sFile:string;
begin
    HardWareOpt.XYTune:='Rough';
end;

procedure ConfigUsersOptLast;
 var iniCSPM:TiniFile;
       sFile:string;
begin
if flgCurrentUserLevel=demo then HardWareOpt.ScannerNumb:='demo';

(*   sFile:=GetConfigUsersFileName;
   iniCSPM:=TIniFile.Create(sFile);
 try
   with iniCSPM do
    begin
//Physical Unit Options:
         case FlgUnit of
nano,Pipette:begin
         HardWareOpt.flgFlash:=Boolean(ReadInteger('Physical Unit Options','Use Flash drive',0));
         HardWareOpt.flgAutoScanner:=ReadInteger('Physical Unit Options','Set Scanner Number Auto',1);
         // nanoeduII
         HardWareOpt.flgFlash:=false;
    //     HardWareOpt.flgAutoScanner:=1;
         // nanoeduII
     //  if  HardWareOpt.flgFlash then    HardWareOpt.flgAutoScanner:=1;
           case  HardWareOpt.flgAutoScanner  of
       0: begin      //manual
          HardWareOpt.ScannerNumb   :=ReadString('Physical Unit Options','Scanner Number','1');
          HardWareOpt.ElectronicNumb:=ReadString('Analog HardWare Options','Electronic Number','1');
         end;
       1: begin      //auto
         // nanoeduII                                                            { TODO : 26/03/06 }
            HardWareOpt.ElectronicNumb:='D1';
          //        nanoeduII
          // nanoeduII
                                   // nanoeduII
            HardWareOpt.ScannerNumb:=HardWareOpt.ElectronicNumb;
          end;

              end;  //case autoscanner
      end;
baby:  begin
          HardWareOpt.ScannerNumb:='atom';

          HardWareOpt.ElectronicNumb:='D1';
          HardWareOpt.flgFlash:=false;
          HardWareOpt.flgAutoScanner:=1;  //0
          HardWareOpt.ScannerNumb:=HardWareOpt.ElectronicNumb;
       end;
ProBeam:  begin
          HardWareOpt.ScannerNumb:='sem';
      //    HardWareOpt.ElectronicNumb:='D1';
          HardWareOpt.flgFlash:=false;
          HardWareOpt.flgAutoScanner:=0;    //0
      //    HardWareOpt.ScannerNumb:=HardWareOpt.ElectronicNumb;
       end;
grand: begin
         HardWareOpt.ScannerNumb:='stepmotor';
         if  NanoEdu.ControllerNumber<>'error' then HardWareOpt.ElectronicNumb:=NanoEdu.ControllerNumber
                                               else HardWareOpt.ElectronicNumb:='Demo';
         HardWareOpt.flgFlash:=false;
         HardWareOpt.flgAutoScanner:=0;
       end;
         end;  //case
     end; //with
  finally
    iniCSPM.Free;
  end;
  *)
end;

procedure ControllerOptLast(const FileName:string);
var iniCSPM:TiniFile;
      sFile:string;
begin
         HardWareOpt.AMPGainRZ:=1;
         HardWareOpt.AMPGainRX:=1;
         HardWareOpt.AMPGainRY:=1;
         HardWareOpt.AMPGainFZ:=1;
         HardWareOpt.AMPGainFX:=1;
         HardWareOpt.AMPGainFY:=1;
         HardWareOpt.AMPGainZ:=HardWareOpt.AMPGainRZ;
         HardWareOpt.AMPGainX:=HardWareOpt.AMPGainRX;
         HardWareOpt.AMPGainY:=HardWareOpt.AMPGainRY;

 (*  sFile:=GetControllerFileName;
   HardWareOpt.ElectronicNumb:='Demo';
  sFile:=ControllerIniFilePath+ FileName;
if (not FileExists(sFile)) then
  begin
   NoFormUnitLoc.siLang1.ShowMessage(strcom8{'No Controller Ini File '}+FileName+strcom6{'. Default Ini File Used!!'});
   if  FileName=ControllerIniFile then
    begin
     sFile:=ControllerIniFileDefPath+ ControllerDefIniFile;
     if (not FileExists(sFile)) then
      begin
       NoFormUnitLoc.siLang1.ShowMessage(strcom9{'No Default Controller Ini File '}+FileName+strcom10{'. Program Terminated!!'});
       Application.Terminate;
      end
    end
    else Application.Terminate;
  end;

  iniCSPM:=TIniFile.Create(sFile);
 try
   with iniCSPM do
    begin
     if not SectionExists((HardWareOpt.ElectronicNumb)) then
       begin
         NoFormUnitLoc.siLang1.MessageDlg(strcom11{'New Electronic  '}+HardWareOpt.ElectronicNumb+ strcom12{' detected !!!. Default data used'},mtInformation,[mbOK],0);
       // Analog HardWare Options:
  //      SetFileAttribute_ReadOnly(sfile,false);
         HardWareOpt.AMPGainRZ:=25;
         HardWareOpt.AMPGainRX:=25;
         HardWareOpt.AMPGainRY:=25;
         HardWareOpt.AMPGainFZ:=1;
         HardWareOpt.AMPGainFX:=1;
         HardWareOpt.AMPGainFY:=1;
         WriteFloat((HardWareOpt.ElectronicNumb), 'AMPGainRZ',HardWareOpt.AMPGainRZ);
         WriteFloat((HardWareOpt.ElectronicNumb), 'AMPGainRX',HardWareOpt.AMPGainRX);
         WriteFloat((HardWareOpt.ElectronicNumb), 'AMPGainRY',HardWareOpt.AMPGainRY);
         WriteFloat((HardWareOpt.ElectronicNumb), 'AMPGainFZ',HardWareOpt.AMPGainFZ);
         WriteFloat((HardWareOpt.ElectronicNumb), 'AMPGainFX',HardWareOpt.AMPGainFX);
         WriteFloat((HardWareOpt.ElectronicNumb), 'AMPGainFY',HardWareOpt.AMPGainFY);
 //        SetFileAttribute_ReadOnly(sfile,true);
       end
       else
       begin        // Analog HardWare Options:
        HardWareOpt.AMPGainRZ:=1;//ReadFloatConvert(iniCSPM,HardWareOpt.ElectronicNumb, 'AMPGainRZ',25);
        HardWareOpt.AMPGainRX:=1;//ReadFloatConvert(iniCSPM,HardWareOpt.ElectronicNumb, 'AMPGainRX',25);
        HardWareOpt.AMPGainRY:=1;//ReadFloatConvert(iniCSPM,HardWareOpt.ElectronicNumb, 'AMPGainRY',25);
        HardWareOpt.AMPGainFZ:=1;//ReadFloatConvert(iniCSPM,HardWareOpt.ElectronicNumb, 'AMPGainFZ',1);
        HardWareOpt.AMPGainFX:=1;//ReadFloatConvert(iniCSPM,HardWareOpt.ElectronicNumb, 'AMPGainFX',1);
        HardWareOpt.AMPGainFY:=1;//ReadFloatConvert(iniCSPM,HardWareOpt.ElectronicNumb, 'AMPGainFY',1);
       end;
   end ;
  if HardWareOpt.ZTune='Rough' then HardWareOpt.AMPGainZ:=HardWareOpt.AMPGainRZ
                               else HardWareOpt.AMPGainZ:=HardWareOpt.AMPGainFZ ;
  if flgUNit=grand then
  begin
   HardWareOpt.AMPGainRX:=8000;
   HardWareOpt.AMPGainRY:=8000;
   HardWareOpt.AMPGainFX:=8000;
   HardWareOpt.AMPGainFY:=8000;
  end;
  HardWareOpt.AMPGainX:=HardWareOpt.AMPGainRX;
  HardWareOpt.AMPGainY:=HardWareOpt.AMPGainRY;
 finally
     iniCSPM.Free;
 end;       *)
end;

procedure CSPMSignalsInit;
begin
   with CSPMSignals[1] do
     begin
       Name:='ADC_UFM';      //phase
       MinV:=-10;
       MaxV:=10;
       DeviceClass:=12;
       MinDiscr:=smallint($800);
       ZeroVal:=0;
       MaxDiscr:=$7FF;
     end;
     with CSPMSignals[3] do
     begin
       Name:='ADC_UAM';      //amplitude
       MinV:=-10;
       MaxV:=10;
       DeviceClass:=12;
       MinDiscr:=smallint($8000);
       ZeroVal:=0;
       MaxDiscr:=$7FFF;
     end;
      with CSPMSignals[4] do
     begin
       Name:='ADC_IT';         //current
   (*
       MinV:=-10;       { TODO : edited }
       MaxV:=10;
   *)
       ZeroVal:=0;
       MinV:=0;
       MaxV:=5;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       MaxDiscr:=$7FFF;
     end;

      with CSPMSignals[6] do
     begin
       Name:='ADC_UAM';   //amplitude
       MinV:=-10;
       MaxV:=10;
       DeviceClass:=12;
       MinDiscr:=smallint($800);
       ZeroVal:=0;
       MaxDiscr:=$7FF;
     end;
(*      with CSPMSignals[7] do
     begin
       Name:='ADC_Z';
       MinV:=-10;
       MaxV:=10;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       ZeroVal:=0;
       MaxDiscr:=$7FFF;
     end;
     *)
(*     case   flgUnit of
ProBeam: begin
        with CSPMSignals[7] do
     begin
       Name:='ADC_Z';
       MinV:=-20;
       MaxV:=120;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       ZeroVal:=0;
       MaxDiscr:=$7FFF;
     end;
      with CSPMSignals[8] do
     begin
       Name:='DAC_X';
       MinV:=-20;//-10;
       MaxV:=120;//10;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       MaxDiscr:=$7FFF;
       ZeroVal:=0;
     end;
        with CSPMSignals[9] do
     begin
       Name:='DAC_Y';
       MinV:=-20;//-10;
       MaxV:=120;//10;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       ZeroVal:=0;
       MaxDiscr:=$7FFF;
     end;
        with CSPMSignals[10] do
     begin
       Name:='DAC_Z';
       MinV:=-20;//-10;
       MaxV:=120;//10;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       ZeroVal:=0;
       MaxDiscr:=$7FFF;
     end;
   end;
else
*) begin
  (*       with CSPMSignals[8] do
  // Обратить внимание!
  //  MinV соответствует MaxDiscr  !!!
     begin
       Name:='DAC_X';
       MinV:=-50;//-10;
       MaxV:=150;//10;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       MaxDiscr:=$7FFF;
       ZeroVal:=0;
     end;
        with CSPMSignals[9] do
     begin
       Name:='DAC_Y';
       MinV:=-50;//-10;
       MaxV:=150;//10;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       ZeroVal:=0;
       MaxDiscr:=$7FFF;
     end;
        with CSPMSignals[10] do
     begin
       Name:='DAC_Z';
       MinV:=-50;
       MaxV:=150;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       ZeroVal:=0;
       MaxDiscr:=$7FFF;
     end;
      *)
      with CSPMSignals[8] do
     begin
       Name:='DAC_X';
       MinV:=PControllerParams^.X_Min;//-10;
       MaxV:=PControllerParams^.X_Max;//10;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);    // = -32768
       MaxDiscr:=$7FFF;              // = 32767

       ZeroVal:=0;
     end;
        with CSPMSignals[9] do
     begin
       Name:='DAC_Y';
       MinV:=PControllerParams^.Y_Min;//-10;
       MaxV:=PControllerParams^.Y_Max;//10;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       MaxDiscr:=$7FFF;
       ZeroVal:=0;
     end;
        with CSPMSignals[10] do
     begin
       Name:='DAC_Z';
       MinV:=PControllerParams^.Z_Min;
       MaxV:=PControllerParams^.Z_Max;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       ZeroVal:=0;
       MaxDiscr:=$7FFF;
     end;
       with CSPMSignals[7] do
     begin
       Name:='ADC_Z';
       MinV:=PControllerParams^.Z_Min;
       MaxV:=PControllerParams^.Z_Max;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       ZeroVal:=0;
       MaxDiscr:=$7FFF;
     end;
     end;
  //     end;
    with CSPMSignals[11] do
     begin
       Name:='DAC_REF';
       MinV:=-25;//-10;   07/02/12
       MaxV:=25;//10;
       DeviceClass:=16;
       MinDiscr:=smallint($8000);
       ZeroVal:=0;
       MaxDiscr:=$7FFF;
     end;

     with CSPMSignals[13] do
     begin
       Name:='DAC_VT';
       //130909
      if flgAnodeLithoEnable then
       begin
         MinV:=-10;
         MaxV:=10;
       end
       else
       begin
         MinV:=-10;    //  -5        240112
         MaxV:=10;     //   5        240112
       end;
       DeviceClass:=12;
       MinDiscr:=smallint($8000);
       ZeroVal:=0;
       MaxDiscr:=$7FFF;//$3FF8;
     end;
     ///////////////////////////////////////////
(*     with CSPMSignals[2] do
     begin
       Name:='ADC_LAZER_H';
       MinV:=-10;
       MaxV:=10;
       DeviceClass:=12;
       MinDiscr:=smallint($800);
       ZeroVal:=0;
       MaxDiscr:=$7FF;
     end;
    with CSPMSignals[12] do
     begin
       Name:='DAC_LC';
       MinV:=-5;
       MaxV:=5;
       DeviceClass:=12;
       MinDiscr:=smallint($800);
       ZeroVal:=0;
       MaxDiscr:=$3FF8;
     end;
      with CSPMSignals[5] do
     begin
       Name:='ADC_LAT';
       MinV:=-10;
       MaxV:=10;
       DeviceClass:=12;
       MinDiscr:=smallint($800);
       ZeroVal:=0;
       MaxDiscr:=$7FF;
     end;
  *)
 end;

procedure TransformUnitInit;
begin
with  TransformUnit do
 with ScannerCorrect do
  with HardWareOpt do
   begin
    nA_d:=I_VTransfKoef/1000*CSPMSignals[11].MaxDiscr/CSPMSignals[11].MaxV;   //    { TODO : 041012 }
    A_d_SetPoint:= 1;
    Znm_d:=(CSPMSignals[7].MaxDiscr-CSPMSignals[7].MinDiscr)/((CSPMSignals[7].MaxV-CSPMSignals[7].MinV)*SensitivZ);//CSPMSignals[7].MaxDiscr/(SensitivZ*UFBMaxOut*AMPGainZ); //transfer nm->discret
    Ynm_d:=(CSPMSignals[9].MaxDiscr-CSPMSignals[9].MinDiscr)/((CSPMSignals[9].MaxV-CSPMSignals[9].MinV)*SensitivY);
    Xnm_d:=(CSPMSignals[8].MaxDiscr-CSPMSignals[8].MinDiscr)/((CSPMSignals[8].MaxV-CSPMSignals[8].MinV)*SensitivX);
    if(Scanparams.ScanPath=OneX) or (Scanparams.ScanPath=Multi)   then
    begin
     XPnm_d:=Xnm_d;   //use sensivity for position x
     YPnm_d:=Ynm_d;   //use sensivity for position y
    end;
  //amplitude Discr-V tranform koeff
///?????????????????????????????????
    AmplV_d:=2*(CSPMSignals[3].MaxDiscr-CSPMSignals[3].MinDiscr)/(CSPMSignals[3].MaxV-CSPMSignals[3].MinV);  //amplitude
//////////??????????????
    BiasV_d:=(CSPMSignals[13].MaxDiscr-CSPMSignals[13].MinDiscr)/(CSPMSignals[13].MaxV-CSPMSignals[13].MinV);
    mA_dE:=MaxDATATYPE/142; // //mili Am ->discret
   end;
  ScanParams.XBias0:=-(ScannerXYBiasZero-CSPMSignals[8].MaxDiscr)/TransformUnit.XPnm_d-Scanparams.xshift;
  ScanParams.YBias0:=-(ScannerXYBiasZero-CSPMSignals[9].MaxDiscr)/TransformUnit.YPnm_d-Scanparams.yshift;
 end;

function  Voltage_toDiscr(dir:string; VoltVal:single; var DiscrVal:integer; var nmVal:integer): integer;      // nm
var
    ind:integer;
begin
result:=0;
if lowercase(dir) = lowercase('X') then
       ind:=8
 else if lowercase(dir) = lowercase('Y') then ind:=9
 else begin ShowMessage('Wrong Direction in SetXYVoltage!!');
            result:= -1;
          exit;
      end;
     discrVal:=round( CSPMSignals[ind].MaxDiscr+(VoltVal-CSPMSignals[ind].MinV)*(CSPMSignals[ind].MinDiscr-CSPMSignals[ind].MaxDiscr)
                                       /(CSPMSignals[ind].MaxV-CSPMSignals[ind].MinV))  ;
    if discrVal < CSPMSignals[ind].MinDiscr then discrVal := CSPMSignals[ind].MinDiscr ;
    if discrVal > CSPMSignals[ind].MaxDiscr then discrVal := CSPMSignals[ind].MaxDiscr ;
  if lowercase(dir) = lowercase('X') then
       begin
        // API.DACX:= discrVal ;
         nmVal:= round((VoltVal- CSPMSignals[ind].MinV)*ScannerCorrect.SensitivX);    // nm
       end
       else
       begin
       //  API.DACY:=discrVal;
         nmVal:= round((VoltVal- CSPMSignals[ind].MinV)*ScannerCorrect.SensitivY);  // nm
       end;

end;

end.
