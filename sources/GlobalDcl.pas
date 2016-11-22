//010707
unit Globaldcl;
//{$I Option.inc}
{$A-,R-}
interface
uses SysUtils,Dialogs, Windows,classes,GlobalType,GlobalScanDataType;

//Const   ScanSizeMax=1024;//1024; //Max point number in Scan Line
//Const   LinePointsMax:integer=1024;//1024; //Current Max point number in Scan Line
const   Identif = '(C) STM Data File System ';
//const   IdentifNew = '(C) NT-MDT NanoEducator File Format';
const   IdentifDemo = '(C) NanoEdu Data File System ';
const   IdApproachZ = '(C) NanoEdu Data: Approach Z ';
const   IdApproachOscAmp = '(C) NanoEdu Data: Approach Oscillation Amplitude ';

 type  TScanNormData=record
        previousMin,previousMax,previousDz:single;
        datmin,  // min
        datmax,   // max
        datminph,datmaxph:single;  //  max,min add signal
        ScaleZ0,ScaleAdd:single;
        sfA,sfB:single;   //plane delete params
        Prevline:TLineSingle;
       end;

 type
     TPtSpector=^PtSpector;
      PtSpector=record
        Point:TPoint;
       end;
 type
     TPtFileName=^PtFileName;
      PtFileName=record
        FileName:string;
        end;

 type MainFileRec =packed record
               Ident : string[29];
               Version : word;
               Flags   : word;    //true - SPM file have been  modified   220904
               NumRec  : word;
               {--- Record for Header ---}
               bdata : byte; bhead : byte;
               headsize : word;
               HeadOfs  : longint;
               {--- Record for Topo ---}
               NyTop : datatype;
               NxTop : datatype;
               TopoOfs : longint;
               {--- Record for ADDSURF ---}
               NyAdd  : datatype;
               NxAdd  : datatype;
               AddOfs : longint;
               {--- Record for Spec Points ---}
               NyPoint : datatype;         //NUmber POints Spectr
               NxPoint : datatype;        //=0
               PointOfs: longint;        // x,y for spectr word
               {--- Record for Spectr ---}
               NySpec  : datatype;       //=0
               NxSpec  : datatype; //number point for one graf
               SpecOfs : longint;
               {--- Record for CVC ---}
               NyReni  : datatype;
               NxReni  : datatype;
               ReniOfs : longint;
               {-----------------------}
                   end;

  type HeadParmType = packed record
       HYear, HMonth,  HDay,
       HHour, HMinute, HSecond : word;
       HMaterial    : string[20];
       HScannerName : string[20];   // scanner number       030304
       HTemperature : byte;       // not filled
       HFlagLinear  : boolean;    // flag linearization    090304
      {----------- Data types ------------------}
       HAquiTopo     : boolean;   //false for only AquiAdd Data  !!!
       HAquiADD      : byte;      //1-workF; 2-BackPass;3 -phase ; 4-UAM;  5-Spectr;
                                  //7-CurrentSTM; 8-FastScan; 10-FastScanPhase; 11-ScannerTraining;

       HAquiSpectr   : boolean;
       HAquiRenishaw : boolean;  //HAquiCVC      : boolean;
       HNxTopo,
       HNyTopo       : datatype;    {Rectangular Rastr}
       HNumSpLines   : datatype;    { Number of Spectra or CVC lines }
       HNumSpPoints  : datatype;    { Number of points in one line }
      {------------- Scan Parameters -------------}
       HStepXY       : single;    { X, Y  Step, Angstrom }
       HScanRate     : single;    {nm/s}           //HTimeScanPoint : single;
       HScanVoltage  : single;   {mV}
       HScanCurrent  : single;  { nA }
      {------------- Scaner regimes ---------}
       HProbeType    : byte;     {STM=1, SFM=0}
       HAMP_GainZ    : single;  {value AMP_GAINZ  =AMP_GainRZ or AMP_GainFZ depend on Z_Tune}
       HXBegin       : single; {nm}        //HScanRange    : single;
       HYBegin       : single;  {nm}    //HstepXYmVolt  : single;
       HSetPoint     : datatype;       {percents}
       HPathMode     : byte;{0 -X+; 1- Y+ ; 2-multi ;3-multiY.}
       IReservScan1  : byte;
       HDz           : datatype;     //Multi pass dz      : datatype;
       IReservScan2  : byte;
     {----------- HardWare Coefficients -------}
       HSensX, HSensY, HSensZ  : single  ;    { nm/volt} //Sensitivity, Angstrom/mVolt }
       HDiscrZmvolt  : single;         //  Mvolt/Discrete  Z.
       HGainX        : single;
       HGainY        : single;
       HnA_D         : single;     // koeff current nA to discr      : single  ;   151003
       HBiasV_d      : single;     //koeff Volt to discr        151003

     {--------------- Work Function Parameters ----------}
       HAmpModulation  : integer;   { SD_GEN_M, discrets }
       HScanningTime_sec:word;   //19/12/13  scantime
       HSDGainAM       : word;    {SD_GAIN_AM  }
       HResFreqR       : word;
       HResFreqF       : word;
       HF0             : integer;  {F0, Hz}
       HAmplSuppress   : single; //Ampltude Suppression SFM
     {--------------- Spectroscopy  Parameters -----------}
       HNumberOfStepX  : datatype;         { Number of spectra in X direction }
       HNumberOfStepY  : datatype;         { Number of spectra in Y direction }
       HNumberOfAver   : datatype;    { Number of Averaging }
       HSpVoltageStart,
       HSpVoltageFinal : single;  { Voltage, mV }
       HTimeSpecPoint  : single;             { ms }
       HSpModulation   : single;      { Modulation magnitude, mV }
       HSpDetectorCoef : single;   { Sinhrodetector Coefficient   }
       HAmplV_d     : single;     { amplitude Discr-V tranform koeff }  //180114
       HUAMMax,
       IReservSpec2    : datatype;
     {-------------------------------------------------------}
       HXnm_d,
       HYnm_d          : single;
       {---------- Spectroscopy regimes -----------------}
         HTypeCVC          : datatype;
         HTypeSpectr       : datatype;    // I-Z=1; I-V=0  STM ; A-Z =2 SFM??;
         HTypeConstCurrent : boolean;
         TypeReserv1,
         TypeReserv2,
         Typereserv3      : boolean;
      {----------- Reserved -----------------------------}
        SecondPass  :boolean;  //pass fasle -first; true - second; Multi pass
        HRenishawCorrected   : boolean;
        HFBGain,
        HRenishawPeriod: datatype;//nm
        HRenishawSensorPos,     //none dimention units
        HLithoAction : single;
      {             Gain
      {----------- Comments ------------------------------}
        comments:array[0..7] of string[60];
     //   Comm1, Comm2, Comm3, Comm4,
     //   Comm5, Comm6, Comm7, Comm8 : string[60];
      {---------------------------------------------------}
            end;

  type HeadParmNewType = packed record        //18/01/14
       HYear, HMonth,  HDay,
       HHour, HMinute, HSecond : word;
       HMaterial    : string[20];
       HScannerName : string[20];   // scanner number       030304
       HTemperature : byte;       // not filled
     //  HScanningTime_min :byte;     // 19/07/2013
       HFlagLinear  : boolean;    // flag linearization    090304
      {----------- Data types ------------------}
       HAquiTopo     : boolean;   //false for only AquiAdd Data  !!!
       HAquiADD      : byte;      //1-workF; 2-BackPass;3 -phase ; 4-UAM;  5-Spectr;
                                  //7-CurrentSTM; 8-FastScan; 10-FastScanPhase; 11-ScannerTraining;

       HAquiSpectr   : boolean;
       HAquiRenishaw : boolean;  //HAquiCVC      : boolean;
       HNxTopo,
       HNyTopo       : datatype;    {Rectangular Rastr}
       HNumSpLines   : datatype;    { Number of Spectra or CVC lines }
       HNumSpPoints  : datatype;    { Number of points in one line }
      {------------- Scan Parameters -------------}
       HStepXY       : single;    { X, Y  Step, nm }
       HStepZ        : single;    { Z  Step, nm}     //180114
       HScanRate     : single;    {nm/s}           //HTimeScanPoint : single;
       HScanVoltage  : single;   {mV}
       HScanCurrent  : single;  { nA }
      {------------- Scaner regimes ---------}
       HProbeType    : byte;     {STM=1, SFM=0}
       HAMP_GainZ    : single;  {value AMP_GAINZ  =AMP_GainRZ or AMP_GainFZ depend on Z_Tune}
       HXBegin       : single; {nm}        //HScanRange    : single;
       HYBegin       : single;  {nm}    //HstepXYmVolt  : single;
       HSetPoint     : datatype;       {percents}
       HPathMode     : byte;{0 -X+; 1- Y+ ; 2-multi ;3-multiY.}
       IReservScan1  : byte;
       HDz           : datatype;     //Multi pass dz      : datatype;
       IReservScan2  : byte;
     {----------- HardWare Coefficients -------}
       HSensX, HS3ensY, HSensZ  : single  ;    { nm/volt} //Sensitivity, Angstrom/mVolt }
       HDiscrZmvolt  : single;         //  Mvolt/Discrete  Z.
       HGainX        : single;
       HGainY        : single;
       HnA_D         : single;     // koeff current nA to discr      : single  ;   151003
       HBiasV_d      : single;     //koeff Volt to discr        151003

     {--------------- Work Function Parameters ----------}
       HAmpModulation  : integer;   { SD_GEN_M, discrets }
     //  HSDGainFM       : word;   { SD_GAIN_FM  }
       HScanningTime_sec:word;   //19/12/13  scantime
       HSDGainAM       : word;    {SD_GAIN_AM  }
       HResFreqR       : word;
       HResFreqF       : word;
       HF0             : integer;  {F0, Hz}
       HAmplSuppress   : single; //Ampltude Suppression SFM
     {--------------- Spectroscopy  Parameters -----------}
       HNumberOfStepX  : datatype;         { Number of spectra in X direction }
       HNumberOfStepY  : datatype;         { Number of spectra in Y direction }
       HNumberOfAver   : datatype;    { Number of Averaging }
       HSpVoltageStart,
       HSpVoltageFinal : single;  { Voltage, mV }
       HTimeSpecPoint  : single;             { ms }
       HSpModulation   : single;      { Modulation magnitude, mV }
       HSpDetectorCoef : single;   { Sinhrodetector Coefficient   }
       HResistance     : single;     { Om }
       HUAMMax,
       IReservSpec2    : datatype;
       HXnm_d,
       HYnm_d          : single;
       {---------- Spectroscopy regimes -----------------}
         HTypeCVC          : datatype;
         HTypeSpectr       : datatype;    // I-Z=1; I-V=0  STM ; A-Z =2 SFM??;
         HTypeConstCurrent : boolean;
         TypeReserv1,
         TypeReserv2,
         Typereserv3      : boolean;
      {----------- Reserved -----------------------------}
        SecondPass  :boolean;  //pass fasle -first; true - second; Multi pass
        HRenishawCorrected   : boolean;
        HFBGain,
        HRenishawPeriod: datatype;//nm
        HRenishawSensorPos,     //none dimention units
        HLithoAction : single;
      {             Gain
      {----------- Comments ------------------------------}
        comments:array[0..7] of string[60];
     //   Comm1, Comm2, Comm3, Comm4,
     //   Comm5, Comm6, Comm7, Comm8 : string[60];
      {---------------------------------------------------}
            end;


    type TExperiment=class(TObject)
     private
     protected
     public
        Caption:string;
        ImFileName:string;
        WorkFileName:string;    //scan filename
        ArFileNameEdit:TList;        //array edit work files  for undo operation
       	FileHeadRcd:HeadParmType;
        MainRcd:MainFileRec;
        AquiTopo:TData;  //topography
        AquiAdd: TData;  //add data Phase,Uam, and ...
        AquiSpectr:TData;  //spectroscopy
        AquiRenishaw:Tdata;
        AquiSpectrPoint:TLine;   //points spectroscopy
   { TODO : add point line }
     constructor Create;
     destructor  Destroy; override;
      function   ReadSurface(flgReadBlock:integer):integer;
      function   ReadRenishawData():integer;
      procedure  PrepareSaveData;
      function   SaveExperiment:integer;
      procedure  SaveSpectr;
      procedure  SaveRenishaw;
      procedure  HeaderPrepare;
     end; {class}

  ///////////////////////////////////////////////
  ///////VARIABLES ///////////////////////////////
  var  FlgReadBlock:integer;
       FlgViewTypeL:byte;// 0- Side; 1- Topo; 2- UAM;
       ArPntSpector:Tlist;
       PntSpector:TPtSpector;
       PntFileName:TPtFileName;
       Head: HeadParmType ;
       MainRc:MainFileRec;
       ScanError{,ScanErrorY}:TLinesingle;
       ScanData:TExperiment;
       ScanDataSecondPass:TExperiment;
       ScanNormData:TScanNormData;
       ScanNormData_2_Pass:TScanNormData;
       DataFromMLPC:ArrayInt;     ///// Массив данных, считанных из Контроллера

function  ReadHeader(const FileName:string;var flg:integer;var head:HeadParmType;
                      var main:MainFileRec):integer;

procedure SaveHeader(const FileName:string;const head:HeadParmType;const mainrc:MainFileRec);

procedure SetScanNormData(var NormData:TScanNormData);

function MakeFileRSCorrection(const FileName:string):boolean;

 implementation

uses GlobalVar,CSPMVar,frNoFormUnitLoc, RenishawVars, uScannerCorrect;

constructor TExperiment.Create;
var Year, Month, Day, Hour, Minut, Sec, MSec: Word;
       Present: TDateTime;
       LRec,LHeader:integer;
begin
  inherited;
  WorkFileName:=WorkNameFile;
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minut, Sec, MSec);
  LRec:=Sizeof(MainFileRec);
  LHeader:=Sizeof(HeadParmType);
    ArFileNameEdit:=TList.Create;
    ArFileNameEdit.Clear;
    ArFileNameEdit.Capacity:=20;
 with MainRcd do
  begin
   Ident:=identif;
  // Version:=14;  //14  //ver 10 step z =0  NEW SPECTROSCOPY!!!!!!!!
  // Version:=15;   // With RENISHAW!!!!!!!!!!!!!!!
  //  Version:=16;   //nanoedule
 //  version:=17;      // nanoeduLE 14/08/2013
   version:=18;           //18/01/2014
   HeadOfs:=LRec;
   TopoOfs:=HeadOfs+LHeader;
               NyTop :=0;
               NxTop :=0;
               NyAdd :=0;// datatype;
               NxAdd :=0;// datatype;
               AddOfs :=0;// longint;
               {--- Record for Spec Points ---}
               NyPoint :=0;// datatype;
               NxPoint :=0;// datatype;
               PointOfs :=0;// longint;
               {--- Record for Spectr ---}
               NySpec :=0;// datatype;
               NxSpec :=0;// datatype;
               SpecOfs :=0;// longint;
               {--- Record for CVC ---}
               NyReni :=0;// datatype;
               NxReni :=0;// datatype;
               ReniOfs :=0;// longint;
  end;
  with FileHeadRcd do
   begin
   end;
  AquiTopo  :=TData.Create;
  AquiAdd   :=TData.Create;
  AquiSpectr:=TData.Create;
  AquiRenishaw:=TData.Create;
//
end; {TExperiment.Create}

destructor TExperiment.Destroy;
var i:integer;
begin
 if   ArFileNameEdit<>nil then
  begin
  for i := 0 to (ArFileNameEdit.Count - 1) do
   begin
     PntFileName := ArFileNameEdit.Items[i]; { TODO : 200907 }
     PntFileName.FileName:='';
     Dispose(PntFileName);
   end;
   ArFileNameEdit.Clear;
   ArFileNameEdit.Capacity:=0;
   FreeAndNil(ArFileNameEdit);
 end;
  FreeAndNil(AquiTopo);
  FreeAndNil(AquiAdd);
  FreeAndNil(AquiSpectr);
 if assigned(AquiRenishaw) then FreeAndNil(AquiRenishaw);
    { TODO : 220506 }
  AquiSpectrPoint:=nil;
 // AquiLine.Free;
     inherited;
end; {TExperiment.Destroy}

procedure SetScanNormData(var NormData:TScanNormData);
var i:integer;
begin
   with NormData do
   begin
     previousMin:=MaxDATATYPE;
     previousMax:=MinDATATYPE;
     previousDz:=0;
     datmin:=MaxDATATYPE;  // min
     datmax:=MinDATATYPE;   // max
     datminph:=MaxDATATYPE;
     datmaxph:=MinDATATYPE;  //  max,min add signal
     ScaleZ0:=1;
     ScaleAdd:=1;;
     sfA:=0;
     sfB:=0;;   //plane delete params
     SetLength(PrevLine, ScanParams.ScanPoints);
     for i:=0 to Length(Prevline)-1 do  Prevline[i]:=0;
   end;
end;

procedure SaveHeader(const FileName:string;const head:HeadParmType;const mainrc:MainFileRec);
Var
    HNDL:integer;
    icod:integer;
    LRec,LHeader:integer;
    FileHeadRcd:HeadParmType;
    MainRcd:MainFileRec;
begin
  LRec:=Sizeof(MainFileRec);
  LHeader:=Sizeof(HeadParmType);
  MainRcd:=Mainrc;
  FileHeadRcd:=head;
  if not FileExists(FileName) then
        begin
           NoFormUnitLoc.siLang1.ShowMessage(FileName+strcom{' File not exist'});
        end;
  try
      HNDL := FileOpen(FileName,fmOpenReadWrite);
      FileSeek(HNDL,0,0);
      icod:=FileWrite(HNDL,MainRcd,LRec);
    if (icod<>LRec)    then    raise Exception.Create('File Write ERROR (MainRec)');
    icod:=FileWrite(HNDL,FileHeadRcd,LHeader);
    if (icod<>LHeader) then    raise Exception.Create('File Write ERROR (Header)');
 finally
    FileClose(HNDL);
 end;
end;


function ReadHeader(const FileName:string;var flg:integer;var head:HeadParmType; var Main:MainFileRec ):integer;
var HNDL,HNDL0:integer;
    iBytesRead:integer;
    LRec,LHeader:integer;
    FileHeadRcd:HeadParmType;
    MainRcd:MainFileRec;
 begin
   result:=0;
   LRec:=SizeOf(MainFileRec);
  if not FileExists(FileName) then
        begin
           NoFormUnitLoc.siLang1.ShowMessage(FileName+strcom{' File not exist'});
           result:=1;
           exit;
        end;
  try
    try
      HNDL0 := FileOpen(FileName, fmOpenRead or fmShareDenyNone);
    except
           on IO: EInOutError do
            begin
              result:=1;
              exit;
            end;
    end;
      FileSeek(HNDL0,0,0);
      iBytesRead := FileRead(HNDL0,MainRcd, LRec);
    if iBytesRead=-1 then begin result:=1; exit; end;
    if (MainRcd.Ident = Identif){ or (MainRcd.Ident = IdentifNew)}then //icod:=160
      begin
           LHeader:=SizeOf(HeadParmType);
           HNDL:=FileSeek(HNDL0,MainRcd.HeadOfs,0);
           iBytesRead:=FileRead(HNDL0,FileHeadRcd,LHeader);
         if iBytesRead=-1 then begin result:=1; exit; end;
         if FileHeadRcd.HAquiSpectr then  flg:=Spectr
          else
           case  FileHeadRcd.HAquiADD of  
          0:    flg:=Topography;
          1:    flg:=WorkF;
          2:    flg:=BackPass;
          3:    flg:=Phase;
          4:    flg:=UAM;
          6:    flg:=Litho;
          7:    flg:=Current;
          8:    flg:=FastScan;
          10:   flg:=FastScanPhase;
          11:   flg:=OneLineScan;
          13:   flg:=LithoCurrent;
                end;
      head:=FileHeadRCD;
      main:=MainRCD;
    end
    else result:=1;
   finally
      FileClose(HNDL0);
   end;
 end;
function MakeFileRSCorrection(const FileName:string):boolean;
var  flg:integer;
    lhead:HeadParmType;
    lMain:MainFileRec;
begin
if  ReadHeader(FileName,flg,lhead,lMain)<>0 then result:=false
else
begin
  result:= (not lhead.HRenishawCorrected)  and  lhead.HAquiRenishaw ;
end;
end;

function TExperiment.ReadSurface(flgReadBlock:integer):integer;     //=2,3 ; no data
 var HNDL,HNDL0:integer;
    iBytesRead:integer;
    k,i,j:integer;
    GainZ:integer;
    LRec,LHeader:integer;
    DatBuf:Pword;
    Ofs:longint;
    Nx,Ny:integer;
    sum,s:integer;
 begin
   LRec:=SizeOf(MainFileRec);
   if not FileExists(ImFileName) then
        begin
           NoFormUnitLoc.siLang1.ShowMessage(ImFileName+strcom{' File not exist'});
           result:=1;
           exit;
        end;
   result:=0;
 try
    try
       HNDL0 := FileOpen(ImFileName, fmOpenRead or fmShareDenyNone);
    except
           on IO: EInOutError do
            begin
//              messageDlg(s+' try again!',mtwarning,[mbOk],0);
              result:=1;
              exit;
            end;
    end;
       FileSeek(HNDL0,0,0);
  iBytesRead := FileRead(HNDL0,MainRcd, LRec);
  if (iBytesRead<>-1) then
  begin
    if (MainRcd.Ident = Identif){ or (MainRcd.Ident = IdentifNew)} then
    begin
           LHeader:=SizeOf(HeadParmType);
           HNDL:=FileSeek(HNDL0,MainRcd.HeadOfs,0);
           iBytesRead:=FileRead(HNDL0,FileHeadRcd,LHeader);
      if FlgReadBlock in ScanmethodSetNoAdd then  Ofs:=MainRcd.TopoOfs;
      if FlgReadBlock in ScanmethodSetAdd   then  Ofs:=MainRcd.Addofs;
      if FlgReadBlock in ScanmethodSetNoAdd then // no add data
                 begin
                    if (iBytesRead<>-1) then
                     begin
                           AquiTopo.Nx:=MainRcd.NxTop;
                           AquiTopo.Ny:=MainRcd.NyTop;
                           if (AquiTopo.Nx=0) and (AquiTopo.Ny=0) then
                           begin
                            result:=2; //no topo block
                            exit;
                           end;
                           Nx:=AquiTopo.Nx;
                           Ny:=AquiTopo.Ny;
                           AquiTopo.XStep:=FileHeadRcd.HStepXY;
                           AquiTopo.YStep:=FileHeadRcd.HStepXY;
                           AquiTopo.caption:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_23' (* '  Topography' *) ) ;
                           AquiTopo.captionX:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_37' (* 'nm' *) );
                           AquiTopo.captionY:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_37' (* 'nm' *) );
                           AquiTopo.captionZ:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_37' (* 'nm' *) );
                    if  FlgReadBlock in ScanmethodSetOneL then //one line scan
                      begin
                            AquiTopo.caption:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_45' (* 'Drift ' *) ) ;
                            case  FileHeadRcd.HPathMode of
                   Multi,
                   OneX: begin
                           AquiTopo.captionY:='s'; //number line
                           AquiTopo.YStep:=FileHeadRcd.HScanningTime_sec/NY;
                         //  AquiTopo.YStep:=2*NX*AquiTopo.XStep/FileHeadRcd.HScanRate;
                           end;
                   MultiY,
                   OneY:  begin
                           AquiTopo.captionX:='s'; //number line
                       //    AquiTopo.XStep:=2*NY*AquiTopo.YStep/FileHeadRcd.HScanRate;
                           AquiTopo.XStep:=FileHeadRcd.HScanningTime_sec/Nx;
                          end;
                               end;
                      end;
                      if  MainRcd.Version>=11 then
                          begin
                             if MainRCD.Version>=16 then
                                //AquiTopo.ZStep:=FileHeadRcd.HSensZ*(CSPMSignals[7].MaxV-CSPMSignals[7].MinV)/(CSPMSignals[7].MaxDiscr-CSPMSignals[7].MinDiscr)
                                AquiTopo.ZStep:=0.001*
                                                FileHeadRcd.HSensZ*      //
                                                FileHeadRcd.HDiscrZmvolt //mvolt/discr0
                             else
                             if (MainRCD.Version<16) and  (MainRCD.Version>=12)then
                                   AquiTopo.ZStep:=0.001*
                                                FileHeadRcd.HSensZ*      //
                                                FileHeadRcd.HAMP_GainZ*  //
                                                FileHeadRcd.HDiscrZmvolt //mvolt/discr0
                            else AquiTopo.ZStep:=0.001*
                                                FileHeadRcd.HSensZ*      //
                                                25*   //
                                                FileHeadRcd.HDiscrZmvolt //mvolt

                           end
                      else AquiTopo.ZStep:=1 ;
                        if AquiTopo.ZStep=0 then AquiTopo.ZStep:=1;
                            HNDL:=FileSeek(HNDL0,Ofs,0);
                           try
                              SetLength(AquiTopo.Data,Nx,Ny);
                           except
                              on EOutOfMemory        do
                                  NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
                           end;
                           try
                               GetMem(DatBuf,Nx*Ny*sizeof(DataType));
                           except
                               on EOutOfMemory        do
                               NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory'}+' 1',mtWarning,[mbOk],0);
                           end;
                            iBytesRead:=FileRead(HNDL0,DatBuf^,sizeof(DataType)*Nx*Ny);
                           if (iBytesRead<>-1) then
                               begin
                                for j:=0 to Ny-1 do
                                  for i:=0 to Nx-1 do
                                   begin
                                       AquiTopo.Data[i,j]:=datatype(PWordArray(DatBuf)[j*Nx+i]);          //
                                   end;
                               end;
                     end;  //if
                end; //topo
    if FlgReadBlock in ScanmethodSetAdd  then      //addtional data
         begin
                    if (iBytesRead<>-1) then
                     begin
                            Nx:=MainRcd.NxAdd;
                            Ny:=MainRcd.NyAdd;
                            AquiAdd.Nx:=Nx;
                            AquiAdd.Ny:=Ny;
                            if (AquiAdd.Nx=0) and (AquiAdd.Ny=0) then
                            begin
                             result:=3; //no add block
                             exit;
                           end;
                    (*     if (NX>ScanSizeMax) or (Ny>ScanSizeMax) then
                            begin   NoFormUnitLoc.siLang1.MessageDlg(strcom1{'OUT of range: >'}+intToStr(ScanSizeMax{LinePointsMax}),mtWarning,[mbOk],0); exit end;
                    *)
                            AquiAdd.XStep:=FileHeadRcd.HStepXY;
                            AquiAdd.YStep:=FileHeadRcd.HStepXY;
                            AquiAdd.captionX:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_37' (* 'nm' *) );
                            AquiAdd.captionY:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_37' (* 'nm' *) );
         if FlgReadBlock in ScanmethodSetZnm  then     //back pass
                    begin         //180114
                         if  MainRcd.Version>=11 then
                          begin
                            if MainRCD.Version>=16 then
                                 AquiTopo.ZStep:=0.001*
                                                FileHeadRcd.HSensZ*      //
                                                FileHeadRcd.HDiscrZmvolt //mvolt/discr0
                             else
                             if (MainRCD.Version<16) and  (MainRCD.Version>=12)then
                                   AquiTopo.ZStep:=0.001*
                                                FileHeadRcd.HSensZ*      //
                                                FileHeadRcd.HAMP_GainZ*  //
                                                FileHeadRcd.HDiscrZmvolt //mvolt/discr0
                            else AquiTopo.ZStep:=0.001*
                                                FileHeadRcd.HSensZ*      //
                                                25*   //
                                                FileHeadRcd.HDiscrZmvolt //mvolt

                           end
                           else AquiTopo.ZStep:=1 ;
                           if AquiTopo.ZStep=0 then AquiTopo.ZStep:=1;


                      (*    if   MainRcd.Version>=11 then
                           begin
                              AquiAdd.ZStep:=0.001*FileHeadRcd.HSensZ*  //
                                               FileHeadRcd.HAMP_GainZ*   //
                                               FileHeadRcd.HDiscrZmvolt //mvolt/discr
                           end
                              else AquiAdd.ZStep:=1 ;
                             if AquiAdd.ZStep=0 then AquiAdd.ZStep:=1;
                         *)

                             AquiAdd.captionZ:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_37' (* 'nm' *) );
                             AquiAdd.caption:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_34' (* '  Topography; Back Pass' *) );
                        end;            //backpass
         if FlgReadBlock in ScanmethodSetZPh  then// phase
                        begin
                          AquiAdd.caption:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_35' (* '  Phase' *) );
                          AquiAdd.captionZ:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_36' (* 'a.u' *) );
                          AquiAdd.ZStep:=360/(MaxApiType-MinApiType);//1;     180114
                         end;
         if FlgReadBlock in ScanmethodSetZUAM  then  //force
                         begin
                          AquiAdd.caption:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_38' (* '   Force Image' *) );
                          if MainRCD.Version>=18 then AquiAdd.ZStep:=1/FileHeadRcd.HAmplV_d
                                                 else AquiAdd.ZStep:=1/(FileHeadRcd.HBiasV_d); //  //?????  180114
                          AquiAdd.captionZ:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_40' (* 'mV' *) );
                         end;
         if FlgReadBlock in ScanmethodSetZWrk then   ;      //work function
         if FlgReadBlock in ScanmethodSetZAm  then        //current
                       begin
                            AquiAdd.caption:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_41' (* '  Current' *) );
                            AquiAdd.ZStep:=1/FileHeadRcd.HnA_d;
                            AquiAdd.captionZ:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_42' (* 'nA' *) );
                        end;
                             HNDL:=FileSeek(HNDL0,Ofs,0);
                           try
                              SetLength(AquiAdd.Data,Nx,Ny);
                           except
                              on EOutOfMemory        do
                                  NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
                           end;
                           try
                               GetMem(DatBuf,Nx*Ny*sizeof(DataType));
                           except
                               on EOutOfMemory        do
                               NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 1',mtWarning,[mbOk],0);
                           end;
                           iBytesRead:=FileRead(HNDL0,DatBuf^,sizeof(DataType)*Nx*Ny);
                           if (iBytesRead<>-1) then
                               begin
                                for j:=0 to Ny-1 do
                                   for i:=0 to Nx-1 do
                                     AquiAdd.Data[i,j]:=datatype(PWordArray(DatBuf)[j*Nx+i]);          //
                               end;
                   end;
                end;
    if   FlgReadBlock in ScanmethodSetSpectr then  //Spectroscopy
              begin
               if MainRcd.Version>=14 then
                                      begin
                                       SetLength(AquiSpectrPoint,3*MainRcd.NyPoint);
                                       GetMem(datBuf,3*sizeof(word)*MainRcd.NyPoint);
                                      end
                                      else
                                      begin
                                       SetLength(AquiSpectrPoint,2*MainRcd.NyPoint) ;
                                       GetMem(datBuf,2*sizeof(word)*MainRcd.NyPoint);
                                      end;
                   HNDL:=FileSeek(HNDL0,MainRcd.PointOfs,0);
                   iBytesRead:=FileRead(HNDL0,DatBuf^,sizeof(word)*length(AquiSpectrPoint));
                      i:=0; sum:=0;
                 if (iBytesRead<>-1) then    { TODO : 111207 }
                 begin
                   while I<=(length(AquiSpectrPoint)-1)  do
                  begin
                   AQuiSpectrPoint[i]:=PWordArray(DatBuf)[i];
                   AQuiSpectrPoint[i+1]:=PWordArray(DatBuf)[i+1];
                     if MainRcd.Version>=14 then
                                      begin
                                       AQuiSpectrPoint[i+2]:=PWordArray(DatBuf)[i+2];
                                       sum:=sum+AQuiSpectrPoint[i+2];//nm
                                       inc(i,3);
                                      end
                                      else
                                      begin
                                       inc(i,2);
                                       inc(sum);
                                      end;
                  end;
                end;
                    HNDL:=FileSeek(HNDL0,MainRcd.Specofs,0);
                    FreeMem(DatBuf);
                  try
                   Setlength(AquiSpectr.Data,sum,MainRcd.NxSpec );
                   GetMem(DatBuf,sum*MainRcd.NxSpec*sizeof(word));
                  except
                      on EOutOfMemory  do
                         NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 1',mtWarning,[mbOk],0);
                  end;
                  iBytesRead:=FileRead(HNDL0,DatBuf^,sizeof(word)*sum*MainRcd.NxSpec);
                      if (iBytesRead<>-1) then
                         begin
                            s:=0;
                            for j:=0 to MainRcd.NyPoint-1 do       // количество точек, для которых снимается спектр
                             begin
                              for k:=0 to AQuiSpectrPoint[3*j+2]-1 do  //количество кривых в каждой точке
                               begin
                                 for i:=0 to MainRcd.NxSpec-1 do
                                 begin
                                     AquiSpectr.Data[s,i]:=PWordArray(DatBuf)[s*MainRcd.NxSpec+i];
                                 end;
                                 inc(s);
                               end;
                             end;
                         end;
              end;//spectr
    end    //if indentif
    else result:=1;
  end;
  finally
          FileClose(HNDL0);
          FreeMem(DatBuf);
  end;
end;

function   TExperiment.ReadRenishawData():integer;
var HNDL,HNDL0:integer;
    iBytesRead:integer;
    k,i,j:integer;
    GainZ:integer;
    LRec,LHeader:integer;
    DatBuf:Pword;
    Ofs:longint;
    Nx,Ny:integer;
    sum,s:integer;
 begin
   LRec:=SizeOf(MainFileRec);
   if not FileExists(ImFileName) then
        begin
           NoFormUnitLoc.siLang1.ShowMessage(ImFileName+strcom{' File not exist'});
           result:=1;
           exit;
        end;
   result:=0;
 try
    try
       HNDL0 := FileOpen(ImFileName, fmOpenRead or fmShareDenyNone);
    except
           on IO: EInOutError do
            begin
//              messageDlg(s+' try again!',mtwarning,[mbOk],0);
              result:=1;
              exit;
            end;
    end;
       FileSeek(HNDL0,0,0);
 // iBytesRead := FileRead(HNDL0,MainRcd, LRec);
//  if (iBytesRead<>-1) then
  begin
  
     //      LHeader:=SizeOf(HeadParmType);
        //   HNDL:=FileSeek(HNDL0,MainRcd.HeadOfs,0);
        //   iBytesRead:=FileRead(HNDL0,FileHeadRcd,LHeader);
           Ofs:=MainRcd.Reniofs;
            if (iBytesRead<>-1) then
                     begin
                           AquiRenishaw.Nx:=MainRcd.NxReni;
                           AquiRenishaw.Ny:=MainRcd.NyReni;
                           if (AquiRenishaw.Nx=0) and (AquiRenishaw.Ny=0) then
                           begin
                            result:=2; //no Renishaw block
                            exit;
                           end;
                           Nx:=AquiRenishaw.Nx;
                           Ny:=AquiRenishaw.Ny;
                        (*   if (NX>ScanSizeMax) or (Ny>ScanSizeMax) then
                            begin   NoFormUnitLoc.siLang1.MessageDlg(strcom1{'OUT of range: >'}+intToStr(ScanSizeMax),mtWarning,[mbOk],0); exit end;
                        *)
                     end;
                     HNDL:=FileSeek(HNDL0,Ofs,0);
                           try
                              SetLength(AquiRenishaw.Data,Nx,Ny);
                           except
                              on EOutOfMemory        do
                                  NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
                           end;
                           try
                               GetMem(DatBuf,Nx*Ny*sizeof(DataType));
                           except
                               on EOutOfMemory        do
                               NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory'}+' 1',mtWarning,[mbOk],0);
                           end;
                            iBytesRead:=FileRead(HNDL0,DatBuf^,sizeof(DataType)*Nx*Ny);
                           if (iBytesRead<>-1) then
                               begin
                                for j:=0 to Ny-1 do
                                  for i:=0 to Nx-1 do
                                   begin
                                       AquiRenishaw.Data[i,j]:=datatype(PWordArray(DatBuf)[j*Nx+i]);          //
                                   end;
                               end;
                     end;  //if
  finally
          FileClose(HNDL0);
          FreeMem(DatBuf);
  end;
end;   {ReadRenishawData}



 procedure TExperiment.PrepareSaveData;
 var      maxScanData, minScanData, min:datatype;
                  j,i:integer;

 begin
 //   maxScanData:=AQuiTopo.max;    // Закомментировано 06/08/2013
  
 (*  for j:=0 to AQuiTopo.Ny-1 do
    for i:=0 to AQuiTopo.Nx-1  do
     begin
      if  AQuiTopo.Data[i,j] > maxScanData then  maxScanData:= AQuiTopo.Data[i,j];
     end;
  *)
  // Закомментировано 01/08/2013
(* for j:=0 to AQuiTopo.Ny-1 do
    for i:=0 to AQuiTopo.Nx-1  do
      AQuiTopo.Data[i,j]:=maxScanData-AQuiTopo.Data[i,j];        //0212  *)
      { TODO : 121104 }
 
 if (FileHeadRcd.HAquiADD=Phase) or   (FileHeadRcd.HAquiADD=FastScanPhase) then
 begin
   min:=AQuiAdd.DataMin;
   for j:=0 to AQuiAdd.Ny-1 do
    for i:=0 to AQuiAdd.Nx-1  do
      AQuiAdd.Data[i,j]:=round(360*(AQuiAdd.Data[i,j]-min)/(MaxDATATYPE-MinDATATYPE));        //0212
  end;
end;


procedure TExperiment.HeaderPrepare;
var
  Present: TDateTime;
  Year, Month, Day, Hour, Minute, Sec, MSec: Word;
  scanTimeSecbuf:integer;
 begin
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minute, Sec, MSec);
  ScanTimeSecbuf:=3600*(Hour- StartHour)+60*(Minute-StartMin)+ (Sec-StartSec);
 // if scantimeSecbuf > 255 then  scantimeSecbuf:=255;

 with FileHeadRcd do
  begin
    HYear:=Year; HMonth:=Month;  HDay:=Day;
    HHour:=Hour; HMinute:=Minute; HSecond:=Sec;
    HScannerName:= HardWareOpt.ScannerNumb;
    HFlagLinear:= ScannerCorrect.FlgXYLinear;
    HScanningTime_sec:=scanTimeSecbuf;  // new !! 19/07/2013    word()????
   // HScanVoltage  :=ApproachParams.BiasV;
    if STMFlg then begin
                    HScanCurrent  :=ApproachParams.SetPoint;
                    HScanVoltage  :=ApproachParams.BiasV;
                   end
              else begin
                    if (ScanParams.ScanMethod=LithoCurrent) or (ScanParams.ScanMethod=Current)
                     then    HScanVoltage  :=ApproachParams.BiasV
                     else    HScanVoltage:=0;
                    HScanCurrent  :=0; //single;  { mV,  nA }
                   end;
     { TODO : 240507 }
       case ScanParams.ScanMethod of
   Litho:   HAquiAdd      :=Topography;
   LithoCurrent:
   begin
     HAquiAdd      :=Topography;
     HScanVoltage  :=LithoParams.V/TransformUnit.BiasV_d;
   end
   else HAquiAdd      :=ScanParams.ScanMethod;
            end;
    HAquiTopo     :=True;
    HAquiSpectr   :=False;   { TODO : 1307 06 }
    HAquiRenishaw   :=False;
    if flgRenishawUnit then HAquiRenishaw :=True;
      if ScanParams.ScanMethod in  ScanmethodSetFast then
      Begin
       HAquiRenishaw:=False;
       HAquiTopo:=false;
      End;
    HRenishawPeriod:=ReniShawParams.Renishawperiod;          //nm  100,20,      input 040209
    HRenishawSensorPos:=ReniShawParams.ReniShawScale;  // 040209
   // HStepXY:=ScanParams.X/ScanParams.Nx;         ///Step  , nm
    {------------- Scan Parameters -------------}
    HScanRate     :=ScanParams.ScanRate; //single;    {nm/s}
    HXBegin       :=ScanParams.XBegin; //single; {nm}
    HYBegin       :=ScanParams.YBegin; //   single;  {nm}
    HSetPoint     :=round(100*ApproachParams.SetPoint); //  smallint;       {percents}

                 { TODO : 220506 }


 //   if ScanParams.ScanMethod=Spectr then HStepXY:=ApproachParams.UAMmax;

    {------------- Scaner regimes ---------}
    HProbeType    :=Byte(STMflg); // byte;
    HPathMode     :=ScanParams.ScanPath; // byte;   PathMOde
 if (ScanParams.ScanPath=Multi) or  (ScanParams.ScanPath=MultiY)
                             then HDz:=ScanParams.PassIIDz  //multi pass dz
                             else HDz:=0;
    {----------- HardWare Coefficients -------}
    HSensZ        :=ScannerCorrect.SensitivZ;
    HSensX        :=ScannerCorrect.SensitivX;
    HSensY        :=ScannerCorrect.SensitivY;
    HDiscrZmvolt  :=1000*((CSPMSignals[7].MaxV-CSPMSignals[7].MinV))/(CSPMSignals[7].MaxDiscr-CSPMSignals[7].MinDiscr);

   // if  MainRcd.Version>=16  then
   //                          else  HDiscrZmvolt  :=1000*HardWareOpt.UFBMaxOut/CSPMSignals[7].MaxDiscr;

     {--------------- Work Function Parameters ----------}
    HAmpModulation:= ApproachParams.Amp_M; //integer;   { SD_GEN_M, discrets }
//    HSDGainFM     :=word(ApproachParams.Gain_FM);   { SD_GAIN_FM  }

    HSDGainAM     :=0;//word(ApproachParams.Gain_AM);    {SD_GAIN_AM  }
    HFBGain       :=datatype(round(PIDParams.sgnTI*PIDParams.Ti));
    HResFreqR     :=word(ResonanceParams.ResFreq);
    HResFreqF     :=0;//word(ApproachParams.ResFreqF);
    HF0           :=word(ApproachParams.F0);          //10;
    if STMFlg then HAmplSuppress :=0
              else HAmplSuppress :=(1-ApproachParams.SetPoint);  //  Suppression SFM
    HAMP_GainZ    :=HardwareOpt.AMPGainZ;
    HGainX        :=HardwareOpt.AMPGainX;
    HGainY        :=HardwareOpt.AMPGainY;
    HAmplV_d      :=TransformUnit.AmplV_d;   //180114
    HnA_D         :=TransformUnit.nA_d;     //  new koeff current nA to discr      : single  ;   151003
    HBiasV_d      :=TransformUnit.BiasV_d;   //
    HXnm_d        :=TransformUnit.Xnm_d;
    HYnm_d        :=TransformUnit.Ynm_d;
    if   (HPathMode<>Multi) and (HPathMode<>MultiY) then SecondPass:=false;
    if ScanParams.ScanMethod=Litho then
        HLithoAction:=  LithoParams.ScaleAct*255/TransformUnit.Znm_d;
    if ScanParams.ScanMethod=Lithocurrent then
       HLithoAction:=  LithoParams.ScaleAct*255/TransformUnit.BiasV_d ;
       HRenishawCorrected :=false;
   end;
 end;  //headprepare

function TExperiment.SaveExperiment:integer;
 var
  HNDL:integer;
  i,j,Nx,Ny:integer;
  icod:integer;
  LRec,LHeader:integer;
  DatBuf:Pword;
 begin
  result:=0;
  LRec:=Sizeof(MainFileRec);
  LHeader:=Sizeof(HeadParmType);
 with FileHeadRcd do
  begin
   if HAquiTopo then
     begin
       HNxTopo:=AquiTopo.Nx;
       HNyTopo:=AquiTopo.Ny;
       HStepXY:=AquiTopo.XStep;
     end
    else
     begin
       HNxTopo:=0;
       HNyTopo:=0;
       HStepXY:=AquiAdd.XStep;
     end;
   HNumSpLines  :=0; //datatype;    { Number of Spectra or CVC lines }
   HNumSpPoints :=0; //datatype;    { Number of points in one line }
  end;
 with MainRcd do
 begin
   Ident:=identif;
   if Version=0 then Version:=13;   //ver 10 step z =0  add GainX, GainY
   if FileHeadRcd.HAquiTopo then
    begin
     NyTop:=AquiTopo.Ny;
     NxTOP:=AquiTopo.NX;
    end
    else
    begin
      NyTop:=0;
      NxTOP:=0;
    end;
  AddOfs:=TopoOfs+NyTop*NxTop*sizeof(DataType);
  PointOfs:=AddOfs;
  ReniOfs:=AddOfs;
   if (FileHeadRcd.HAquiAdd>0) and (FileHeadRcd.HAquiAdd<>OneLineScan)and
      (FileHeadRcd.HAquiAdd<>Litho) and (FileHeadRcd.HAquiAdd<>LithoCurrent) then
   begin
     NyAdd:=AquiAdd.Ny;
     NxAdd:=AquiAdd.Nx;
     PointOfs:=Addofs+AquiAdd.Ny*AquiAdd.Nx*sizeof(DataType);
     ReniOfs:=PointOfs;
   end;
   if flgRenishawUnit then     // scanning was with Renishaw
    begin
      NXReni:=AquiRenishaw.Nx;
      NYReni:=AquiRenishaw.Ny;
      PointOfs:= PointOfs+ AquiRenishaw.Nx*AquiRenishaw.Ny*sizeof(DataType);
    end;
end;    //mainrcd
    if FileExists(Pchar(workFileName)) then DeleteFile(Pchar(workFileName));
     HNDL:=FileCreate(workFileName);
     icod:=FileWrite(HNDL,MainRcd,LRec);
    if (icod<>LRec)    then
    begin
//      raise Exception.Create('File Write ERROR (MainRec). Test windows parameters');
      NoFormUnitLoc.siLang1.MessageDlg('File write error. Maybe you have not rights to create files. Ask administrator',mtWarning,[mbOk],0);
      result:=1;
      exit;
    end;
    icod:=FileWrite(HNDL,FileHeadRcd,LHeader);
    if (icod<>LHeader) then    raise Exception.Create('File Write ERROR (Header)');
 if FileHeadRcd.HAquiTopo then
  begin
    try
      GetMem(DatBuf,AquiTopo.Nx*AquiTopo.Ny*sizeof(word));
    except
              on EOutOfMemory        do
              NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 2',mtWarning,[mbOk],0);
    end;
  for j:=0 to AquiTopo.Ny-1 do
    for i:=0 to AquiTopo.Nx-1  do
      PWordArray(DatBuf)[j*AquiTopo.Nx+i]:=word(round(AquiTopo.Data[i,j]));        //0212
      icod:=FileWrite(HNDL,DatBuf^,2*AquiTopo.Nx*AquiTopo.Ny);
    if (icod<>2*AquiTopo.NX*AquiTopo.Ny) then
     raise Exception.Create('File Write ERROR (Datas)');
       FreeMem(DatBuf);
  end;      //Topo
    if ((FileHeadRcd.HAquiADD<>Topography) and (FileHeadRcd.HAquiADD<>OneLineScan))and
       (FileHeadRcd.HAquiAdd<>Litho) and (FileHeadRcd.HAquiAdd<>LithoCurrent) then
     begin
      try
       GetMem(DatBuf,AquiAdd.Nx*AquiAdd.Ny*sizeof(DataType));
      except
              on EOutOfMemory        do
              NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 2',mtWarning,[mbOk],0);
     end;
          for j:=0 to AquiAdd.Ny-1 do
            for i:=0 to AquiAdd.Nx-1  do
              PWordArray(DatBuf)[j*AquiAdd.Nx+i]:=word(round(AquiAdd.Data[i,j]));        //021
         icod:=FileWrite(HNDL,DatBuf^,2*AquiAdd.Nx*AquiAdd.Ny);
            if (icod<>2*AquiAdd.Nx*AquiAdd.Ny) then
             raise Exception.Create('File Write ERROR (Datas Add)');
     FreeMem(DatBuf);
     end;
     if flgRenishawUnit then
     begin
        try
       GetMem(DatBuf,AquiRenishaw.Nx*AquiRenishaw.Ny*sizeof(DataType));
      except
           on EOutOfMemory        do
              NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 2',mtWarning,[mbOk],0);
     end;
          for j:=0 to AquiRenishaw.Ny-1 do
            for i:=0 to AquiRenishaw.Nx-1  do
              PWordArray(DatBuf)[j*AquiRenishaw.Nx+i]:=word(round(AquiRenishaw.Data[i,j]));        //021
         icod:=FileWrite(HNDL,DatBuf^,2*AquiRenishaw.Nx*AquiRenishaw.Ny);
            if (icod<>2*AquiRenishaw.Nx*AquiRenishaw.Ny) then
             raise Exception.Create('File Write ERROR (Datas Add)');
     FreeMem(DatBuf);
     end;
    FileClose(HNDL);
 end;

 procedure TExperiment.SaveSpectr;
 var
  DatBuf:Pword;
  HNDL:integer;
  k,i,j:integer;
  icod:integer;
  sum,s:integer;
  LRec,LHeader:integer;
 begin
  LRec:=Sizeof(MainFileRec);
  LHeader:=Sizeof(HeadParmType);
  with FileHeadRcd do
  begin
  // HAquiCVC :=False;
   HAquiSpectr:=True;
   HTypeSpectr:=byte(SpectrParams.flgIZ);
   if FlgCurrentUserLevel=Demo then HUAMMax:=round(DemoSpectrNorm)
                               else HUAMMax:= ApproachParams.UAMmax;

   if HAquiTopo then
     begin
       HNxTopo:=AquiTopo.Nx;
       HNyTopo:=AquiTopo.Ny;
       HStepXY:=AquiTopo.XStep;
      end
    else
     begin
       HNxTopo:=0;
       HNyTopo:=0;
       HStepXY:=0;//AquiAdd.XStep;
     end;
//   HAquiTopo:= (HNxTopo>0) and (HNyTopo>0) ;                 ////160210
   HNumSpLines  :=SpectrParams.NSpectrPoints; //datatype;    { Number of Spectra or CVC lines }
   HNumSpPoints :=SpectrParams.NPoints; //datatype;    { Number of points in one line for one way}
  end;
 with MainRcd do
 begin
   Ident:=identif;
   if Version=0 then Version:=13;   //ver 10 step z =0  add GainX, GainY
   if FileHeadRcd.HAquiTopo then
    begin
     NyTop:=AquiTopo.Ny;
     NxTOP:=AquiTopo.NX;
     NxAdd:=0;
     NyAdd:=0;
    end
    else
    begin
      NyTop:=0;
      NxTOP:=0;
    end;
     AddOfs:=TopoOfs+NyTop*NxTop*sizeof(DataType);
     PointOfs:=AddOfs;
   if (FileHeadRcd.HAquiAdd>Topography) and (FileHeadRcd.HAquiAdd<>OneLineScan)and
      (FileHeadRcd.HAquiAdd<>Litho) and (FileHeadRcd.HAquiAdd<>LithoCurrent) then
   begin
     NyAdd:=AquiAdd.Ny;
     NxAdd:=AquiAdd.Nx;
     PointOfs:=Addofs+AquiAdd.Ny*AquiAdd.Nx*sizeof(DataType);
   end;
 end;

with MainRcd do
 begin
     NyPoint:=SpectrParams.NSpectrPoints;
     NxPoint:=0;
     NySpec:=0;
   case FileHeadRcd.HProbeType of
 1:  begin                          //stm
        case FileHeadRcd.HTypeSpectr of
    1:  NxSpec:=4*SpectrParams.NPoints;  //i-z  //4*SpectrParams.NPoints; 281211
    0:  NxSpec:=2*SpectrParams.NPoints;  //i-v
         end;
     end;
 0:    NxSpec:=4*SpectrParams.NPoints;//4*SpectrParams.NPoints;  281211
         end;
     SpecOfs:=Pointofs+3*NyPoint*sizeof(word);
 end;    //mainrcd

    if FileExists(Pchar(workFileName)) then DeleteFile(Pchar(workFileName));
     HNDL:=FileCreate(workFileName);
//   HNDL:=FileOpen(workFileName,fmOpenReadWrite);
     icod:=FileWrite(HNDL,MainRcd,LRec);
    if (icod<>LRec) then
      raise Exception.Create('File Write ERROR (MainRec)');
      icod:=FileWrite(HNDL,FileHeadRcd,LHeader);
    if (icod<>LHeader) then
      raise Exception.Create('File Write ERROR (Header)');
  // Save Topography
 if FileHeadRcd.HAquiTopo then
  begin
    try
      GetMem(DatBuf,AquiTopo.Nx*AquiTopo.Ny*sizeof(word));
    except
              on EOutOfMemory        do
              NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 3',mtWarning,[mbOk],0);
    end;
   for j:=0 to AquiTopo.Ny-1 do
    for i:=0 to AquiTopo.Nx-1  do
      PWordArray(DatBuf)[j*AquiTopo.Nx+i]:=word(round(AquiTopo.Data[i,j]));        //0212
      icod:=FileWrite(HNDL,DatBuf^,2*AquiTopo.Nx*AquiTopo.Ny);
    if (icod<>2*AquiTopo.NX*AquiTopo.Ny) then
     raise Exception.Create('File Write ERROR (Datas)');
       FreeMem(DatBuf);
  end;      //Topo
   if MainRcd.PointOfs<>MainRcd.Addofs  then      //ADD
   begin
     try
       GetMem(DatBuf,AquiAdd.Nx*AquiAdd.Ny*sizeof(DataType));
     except
              on EOutOfMemory        do
              NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 3',mtWarning,[mbOk],0);
     end;
          for j:=0 to AquiAdd.Ny-1 do
            for i:=0 to AquiAdd.Nx-1  do
              PWordArray(DatBuf)[j*AquiAdd.Nx+i]:=word(round(AquiAdd.Data[i,j]));        //021
         icod:=FileWrite(HNDL,DatBuf^,2*AquiAdd.Nx*AquiAdd.Ny);
            if (icod<>2*AquiAdd.Nx*AquiAdd.Ny) then
             raise Exception.Create('File Write ERROR (Datas Add)');
     FreeMem(DatBuf);
   end;

     try
          GetMem(DatBuf,3*MainRcd.NyPoint*sizeof(word));
           except
              on EOutOfMemory        do
              NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 3',mtWarning,[mbOk],0);
           end;
               i:=0;
               sum:=0;
              while i<=3*MainRcd.NyPoint-1 do
                begin
                   PWordArray(DatBuf)[i]:=AquiSpectrPoint[i];
                   PWordArray(DatBuf)[i+1]:=AquiSpectrPoint[i+1];
                   PWordArray(DatBuf)[i+2]:=AquiSpectrPoint[i+2];
                   sum:=sum+AquiSpectrPoint[i+2];
                   inc(i,3);
                end;
                 icod:=FileWrite(HNDL,DatBuf^,3*sizeof(word)*MainRcd.NyPoint);
                   if (icod<>3*sizeof(word)*MainRcd.NyPoint) then
                    raise Exception.Create('File Write ERROR (MainRec)');
               FreeMem(Datbuf);
               try
                  GetMem(DatBuf,MainRcd.NxSpec*sum*sizeof(word));
               except
                on EOutOfMemory        do
                 NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 3',mtWarning,[mbOk],0);
                 end;
               if (icod<>-1) then
                 begin
                          s:=0;
                            for j:=0 to MainRcd.NyPoint-1 do
                              for k:=0 to AQuiSpectrPoint[3*j+2]-1 do        //??????? 281211
                                begin
                                for i:=0 to MainRcd.NxSpec-1 do
                                 begin
                                   PWordArray(DatBuf)[s*MainRcd.NxSpec+i]:=AquiSpectr.Data[s,i];
                                 end;
                                 inc(s);
                                end;
                         end;

           icod:=FileWrite(HNDL,DatBuf^,sizeof(word)*sum*MainRcd.NxSpec);
          if (icod<>sizeof(word)*sum*MainRcd.NxSpec) then
                    raise Exception.Create('File Write ERROR (MainRec)');

    FileClose(HNDL);
    FreeMem(DatBuf);
 end;

procedure  TExperiment.SaveRenishaw;
 begin


 end;

end.


