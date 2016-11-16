//260304
//flash USB detection;
unit GlobalVar;

interface
uses Classes,Windows,Controls,Graphics,Messages,GlobalType,SysUtils;

  const
        ConfigMainForm:string    =   'MainForm.ini';
        ConfigIniFile:string =       'SPMConfig.ini';
        ConfigHeadIniFile:string =   'SPMConfigHead.ini';
        ConfigUsersIniFile:string=   'SPMConfigUsers.ini';
        ScannerReniSIniFile:string=  'SPMReniShaw.ini';
        ScannerIniFileX:string =     'SPMScanner.ini';
        ScannerIniFileY:string =     'SPMScannerY.ini';
        ScannerDefIniFileX:string =  'SPMScannerDef.ini';
        ScannerDefIniFileY:string =  'SPMScannerYDef.ini';
        ControllerIniFile:string=    'SPMController.ini';
        ConfigDefIniFile:string =    'SPMConfigDef.ini';
        ConfigUsersDefIniFile:string='SPMConfigDefUsers.ini';
        ControllerDefIniFile:string= 'SPMControllerDef.ini';
        FourierFiltTemplFile:string= 'FourierFiltTemplFile.txt';
        ConfigLabListFile:string=    'SPMDemoListLabs.ini';
        UpdatesInifile:string=       'spmupdates.ini' ;
        OscConfigIniFile:string=            'SPMOSC.ini';
        OscDefConfigIniFile:string=         'SPMOSCDef.ini';
        PIDDefConfigIniFile:string=         'SPMPIDDEf.ini';
        PIDConfigIniFile:string=            'SPMPID.ini';
//        ConfigLabListFileSTM:string=    'SPMDemoListLabSTM.ini';
//  Demo Files Name
 const DemoTopoSFMFile:string=          'DemoTopoSFM.spm';
       DemoTopoSTMFile:string=          'DemoTopoSTM.spm';
       DemoPhaseFile:  string=          'DemoPhase.spm';
       DemoForceFile:  string=          'DemoForce.spm';
       DemoLithoSFMFile:  string=       'DemoLithoSFM.spm';
       DemoAnodeLithoSFMFile:  string=  'DemoAnodeLithoSFM.spm';
       DemoCurrentFile:  string=        'DemoCurrent.spm';
       DemoSpectrSFMFile:string=        'DemoSpectrSFM.spm';
       DemoSpectrSTMIVFile:string=      'DemoSpectrSTMIV.spm';
       DemoSpectrSTMIZFile:string=      'DemoSpectrSTMIZ.spm';
       SpectrPictureFile:string=        'SpectrPicture.bmp';
       DemoOneLineSFMFile:string=       'DemoOneLineSFM.spm';

   million=1000000;
   dbltoint=2147483648; 
   D3=1;     //3 d view
   D3Top=2;  //3 d view top
   D2Geo=3;  //2 d  geo top
   D3Geo=4;  //3 d geo view
  Const {Константы для TypeOfDisk функции GetDisks}
// DiskUnknown=0; {Неизвестные диски}
// DiskNone=1; {Отсутствующие диски}
    DiskFDD=DRIVE_REMOVABLE; {Съёмные диски, дискеты}
    DiskHDD=DRIVE_FIXED; {Не съёиные диски, жёсткие диски}
    DiskNet=DRIVE_REMOTE; {Сетевые диски}
    DiskCDROM=DRIVE_CDROM; {CD ROM}
// DiskRAM=DRIVE_RAMDISK; {Диски в ОЗУ}

  const XLinId='XPoints Number';
        YLinId='YPoints Number';
  const crAimCursor = 5;
  const crRectDraw = 6;
  const crPen = 7;
  const crCrip = 8;

 var   flgNewVersion:boolean;
       flgNew_XYBegin :boolean;     // 11/02/13
       flgStopPressed :boolean;     // 11/02/13
       FlgStopMulti:Boolean;
       TimerBackUpState:boolean;
       flgClearAdapter:boolean;
       flgActiveSendtoIA:boolean;
       flgErrorCreateNanoedu:boolean;
       flgDragForm,FlgRecord:Boolean;
       flgShowWellComeWindow,
       flgAdmin,
       FlgImgAnalysDrag,
       FlgReWrite,               //not save work files =true
       FlgStopScan:Boolean;
       FlgStopReniShawOsc:Boolean;
       FlgFirstPass:Boolean;
       FlgStopApproach:Boolean;
       FlgStopScannerMoveXYZ:boolean;
       FlgApproachOK,flgTooClose:Boolean;
       flgStopTimer:boolean;
       flgBlickNorm:Boolean;
       FlgMakeNormalize:Boolean;
       flgLinXScanner:Boolean;
       flgLinYScanner:Boolean;
       FlgStopResonance:Boolean;
       FlgResonance:Boolean;
       flgViewTools:boolean;
       flgLeftView:Boolean;
       flgRightView:Boolean;
       flgfullver:boolean; //full version =true
       flgfrTools:boolean;       //flg Tools is created
       flgLinVisible:boolean;
       //option Draw
       flgGlbZZero:boolean;
       flgGlbZStretch:Boolean;
       flgGlbRealScale:Boolean;
       FlgLeaveEnabled:Boolean;
       flgControlXData:Boolean;   // Добавлено 18/09/2012 для контроля записи-чтения
                                  // ини файлов в устройство
       FlgViewDef:byte;
       FlgCurrentUserLevel:byte;
       flgChangeUserLevel:byte;
       flgOnlineService:integer;
       MLPCStartPage:integer;
       Lang:integer;
       CountStart,CountCapture,CountClose:integer;        // Scan data Files increment
       flgfirsttimeSFM,flgfirsttimeSTM:boolean;
       flgFilterExt:integer;
       TopStart:integer;
       LeftStart:integer;
       ITCor:integer;
       ColorMaterial:integer;
       NRed,NGreen,NBlue:integer;// Pallete Nots
       emission  : array[0..3] of single;
       shininess : array[0..0] of single;
       specular  : array[0..3] of single;
       diffuse   : array[0..3] of single;
       ambient   : array[0..3] of single;
       ltposition0 : array[0..3] of single;
       ltposition1 : array[0..3] of single;
       L1ambient : Array [0..3]   of single;
       L1diffuse : Array [0..3]   of single;
       L2ambient : Array [0..3]   of single;
       L2diffuse : Array [0..3]   of single;
         { TODO : 201108 }
       RDistr, GDistr, BDistr: ArraySpline;//array[1..maxVal] of single;          //Global Palllete
       RPaletteKoef,GPaletteKoef,
       BPaletteKoef: array[0..maxVal-1] of integer;//ScanDraw pallete
       PaletteName:string;
       XR,YR,XG,YG,XB,YB:arraySpline;         //  GlobalVar: Const  maxVal=256;
       A0R,A0G,A0B:arraySpline;
       KLR,KLG,KLB:ArraySpline;
       HlpContext:THelpContext;
       strcomment:array[0..8] of string[60];
       sLanguage:string;
       PathFlash:string;
       CurrentUserLevel:string;

       ConfigIniFilePath:string;
       ConfigDefIniFilePath:string;
       ConfigUsersIniFilePath:string;
       ConfigUsersIniFileDefPath:string;
       ConfigLabListFilePath:string;
//
       ReportTemplPath:string;
       ReportTemplEDefPath:string;
       ReportTemplRDefPath:string;
//
       ControllerIniFilePath:string;
       ControllerIniFileDefPath:string;
//
       ConfigSEMPath:string;
       ConfigSEMFile:string;
//
       ScannerReniSIniFilePath:string;

       InstallFlashPlayerPath:string;

       ScannerIniFile:string;
       ScannerIniFilesPath:string;
       ScannerIniFilesDemoPath:string;
       ScannerIniFilesDefaultPath:string;
       ScannerIniBasePath:string;// Путь к базе ini файлов
       ScannerDefIniFilesPath:string;
       ScannerDefIniFile:string;
       ScannerStepMotorUnitPath:string;
       ScannerAtomicUnitPath:string;
       ScannerSEMUnitPath:string;
       PaletteIniFile:string;
       PaletteDefIniFile:string;
       PaletteIniFilePath:string;
       PaletteDefIniFilePath:string;
       UpdatesIniFilePath:string;
       ExeFilePath:string;
//
       dirsys32,
       dirsys32drivers:string;
       DocAndSetDirPath:string;
       CommonApplDataPath:string;
       CommonNanoeduApplDataPath:string;
       CommonDocumentsPath:string;
       CommonNanoeduDocumentsPath:string;
       UserIniFilesPath,UserIniFilesDefPath, //path for users ini files palette
       UserNanoeduWorkDocumentsPath:string;
       UserDocAndSetDirPath:string;
       UserDrivePath:string;
       UserApplDataPath:string;
       UserNanoeduApplDataPath,UserNanoeduDocumentsPath:string;
       UserName:string;
       ProgramName:string;
       UserDocumentsPath:string;
       SchemePath:widestring;
       Scheme:widestring;
       SchemeEng:widestring;
       InitParamFileJava:widestring;  //имя файла параметров для Java Программы
       InitParamFileJavaPath:widestring;
       MaskLithoFileJavaPath:widestring;
       FileToMemoryWrite:widestring;
       MaskLithoFileJava:widestring;
       AlgorithmPath:widestring;
       AlgorithmJava:widestring;

 //
       OpenDirectory:string;
       LithoTemplDirectory:string;
       ScanGalleryDir:String;
       WorkDirectory:String;
       WorkdefDirectory:String;
       WorkLastDirectory:String;
       SaveAsDirectory:String;
       TempDirectory:string;
       DemoDataDirectory:string;
       WorkNameFile:string;
       ReportTemplRFile:string;
       ReportTemplEFile:string;
       ReportTemplFile:string;
       LabWorkIdentificator:string;
       WorkNameFileMaskCur,              //current mask work name files
       WorkNameFileMask:string;
       WorkNameFileMaskDef:string;      //current default mask work name files
       WorkNameFileMaskDemo:string;   //default mask demo work name files
       WorkFileMask,   //default extention search mask
       CurWorkExtFile, //current extention search mask
       WorkExtFile,
       ModExtFile:string[12];  //default extention modify work files
       DefPaletName:string;
       //documents
       tutexperiment,
       tutsimulator,
       tutvideo, tutanima,
       tutexperimenteng,
       tutsimulatoreng,
       tutvideoeng,
       tutexperimentrus,
       tutsimulatorrus,
       tutvideorus:string;
       tutanimarus:string;
       tutanimaeng:string;
       //
       FiltFileName:PChar;
       RisingScrpt,
       TrainScrpt,MovetoScrpt,ScanMScrpt,ScanMScrptTerra,ScanMIIScrpt,ApproachNScrpt,ApproachNOneScrpt,
       ApproachSMOneScrpt,ScanLinMScrpt,ScanLinMScrptTerra,ProfileLinMScrpt,ProfileMScrpt,
       ApproachSMScrpt,ApproachPipetteScrpt,ApproachPipetteOneScrpt,
       ApproachPMScrpt,ApproachPMOneScrpt,AnodeLithoTestScrpt,ReniShawTestScrpt,
       ApproachSMXScrpt,EtchingScrpt,MTestScrpt,SMTestScrpt,PMTestScrpt:string;
       ScanFastScrpt,LithoScript,AnodeLithoScript,LithoLinScript,
       AnodeLinLithoScript,SpectrNScrpt,SpectrNScrptTerra,SpectrScrptSTM,
       SpectrScrptPipette,PhaseNScrpt,TestTIScrpt,
       ResonanceNScrpt,ScannerMoveXYZScrpt,
       WriteNumbToController,WriteToMLPCScript,ClearAdapterScript, ReadFromMLPCScript,
       GetDeviceIdScript,GetControllerIDScript:string;
       ApproachPMSEMScrpt,ApproachPMSEMOneScrpt,PMSEMTestScrpt:string;
       CursorAim:TCursor;
       DemoSample:string;
       DemoSampleLitho:string;
       DemoSpectrCurves:TMas2; {array of array of datatype;}
       DemoSpectrCnt:integer;
       DemoSpectrStep:single;
       DemoSpectrNorm:datatype;
       DemoSpectrNPoints,
       DemoSpectrNCurves:integer;
       mcrn:string;
       TopoUnitsZ,TopoUnitsXY,TopoUnitsnmZ,TopoUnitsmcnZ,TopoUnitsnmXY,TopoUnitsmcnXY,PhaseUnits,
       OneLineTopoUnits,ForceUnits,CurrentUnits:TSignalUnits;
       MyMenuColor:Tcolor;
       iRusLCID,iEngUsLCID:LCID;

       StartHour, startMin, StartSec, startMsec:word; // Время начала сканирования
       fSourceScanRate:single;    // Параметры, прочитанные из исходного файла для DEMO
       fSourceFBGain: pidtype;
       fSourceLithoAction:single;
       formparam:rformparam;
implementation

initialization

    flgDragForm:=false;  flgClearAdapter:=false;
    MyMenuColor:=$00DCDDDB;
    iEngUsLCID := LANG_ENGLISH + SUBLANG_ENGLISH_US shl 10 + SORT_DEFAULT shl 16; { US English LCID }
    IRusLCID:= 1049;//LANG_Russiah + SUBLANG_ENGLISH_US shl 10 + SORT_DEFAULT shl 16;

finalization
    workNameFile:='';
end.
