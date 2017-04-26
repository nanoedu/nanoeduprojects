

{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O-,P+,Q+,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}

unit mMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ActnList, ComCtrls, ToolWin,ShellApi,GlobalDcl, Db,
  Qrctrls, QuickRpt, ExtCtrls, OleCtrls, StrUtils,HTmlHelpViewer, {WinHelpViewer,}
  jpeg, ImgList, {HHOPENLib_TLB,FShockwave} {,ShockwaveFlashObjects_TLB,}
  Buttons, IniFiles,FileCtrl,ClipBrd, MPlayer,Registry,
  StdCtrls, FullScreenUnit,Tlhelp32,
  //ntspb
  GlobalScanDataType,frSPM_Browser,frSPM_BrowserFull{,U_USB},CSPMVar,
  //ntspb
   Tabs, DockTabSet, XPMan, ActnMan, ActnCtrls,
  siComp,OneHist,  ServerForm,  siDialog, AppEvnts,
  SystemCriticalU,
  ExceptionLog,SyncObjs,ActiveX,frTEst, SHDocVw,ComOBJ;
 const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority =(Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS = $00000220;

//  const       DBT_DEVICEARRIVAL=$8000;
//        DBT_DEVICEREMOVECOMPLETE=$8004;
 Const
  DisplayGuid : TGUID = '{4d36e968-e325-11ce-bfc1-08002be10318}';
  HidGuid     : TGUID = '{745a17a0-74d3-11d0-b6fe-00a0c90f57da}';
  USBGuid     : TGUID = '{36FC9E60-C465-11CF-8056-444553540000}';
 const

  EDU_RAW_DRIVER_NAME_SUFFIX: string = '{A5DCBF10-6530-11D2-901F-00C04FB951ED}';

  EDU_NEW_DRIVER_NAME_SUFFIX:string ='{3274056E-E061-4192-8E0B-BA00E277B382}';
  EDU_OLD_DRIVER_NAME_SUFFIX:string ='{4770EB05-F69D-4005-92F4-EB4B43E0EB5F}';

//  EDU_NAME_PREFFIX: string     = '\\?\USB#Vid_0438&Pid_0f00#';

(*
  EDU_HARDWARE_ID :string= 'USB\Vid_0438&Pid_0f00&Rev_0001';
  EDU_INSTATCE_ID_PREF:string ='USB\VID_0438&PID_0F00\';
 *)
 

type
   TWMDEviceChange=record
   MSG:Cardinal;
   Event:UINT;
   dwDATA:pointer;
   Result:LongInt;
   end;
(* type
   PDevBroadcastHdr = ^TDevBroadcastHdr;
   TDevBroadcastHdr = packed record
     dbcd_size: DWORD;
     dbcd_devicetype: DWORD;
     dbcd_reserved: DWORD;
   end;
 *)  
 type
  _OSVERSIONINFOEX = record
    dwOSVersionInfoSize : DWORD;
    dwMajorVersion      : DWORD;
    dwMinorVersion      : DWORD;
    dwBuildNumber       : DWORD;
    dwPlatformId        : DWORD;
    szCSDVersion        : array[0..127] of AnsiChar;
    wServicePackMajor   : WORD;
    wServicePackMinor   : WORD;
    wSuiteMask          : WORD;
    wProductType        : BYTE;
    wReserved           : BYTE;
  end;
  TOSVERSIONINFOEX = _OSVERSIONINFOEX;
type
  TMain = class(TForm)
    MainMenu1: TMainMenu;
    FileItem: TMenuItem;
    NewItem: TMenuItem;
    OpenItem: TMenuItem;
    SaveAsItem: TMenuItem;
    FileInfItem: TMenuItem;
    PrintItem: TMenuItem;
    tutor1: TMenuItem;
    mWindows: TMenuItem;
    ArrangeWindows1: TMenuItem;
    Vertical1: TMenuItem;
    Horizontal1: TMenuItem;
    Cascade1: TMenuItem;
    PopupMenuAdj: TPopupMenu;
    Position: TMenuItem;
    Slow: TMenuItem;
    Exit1: TMenuItem;
    flash: TMenuItem;
    PrintDialog1: TPrintDialog;
    StatusBarMain: TStatusBar;
    N1: TMenuItem;
    ImageListMainTools: TImageList;
    Help: TMenuItem;
    VideoMenu: TMenuItem;
    OpenDialog: TOpenDialog;
    LabsWork: TMenuItem;
    HelpMedia: TMenuItem;
    MainTimerUp: TTimer;
    Forum: TMenuItem;
    LeaveActiveImage1: TMenuItem;
    NextImage1: TMenuItem;
    CloseAllImages1: TMenuItem;
    Manual1: TMenuItem;
    Report1: TMenuItem;
    ReportGenerator: TMenuItem;
    ExportItem: TMenuItem;
    SaveAsASCIIFile: TMenuItem;
    PopupMenuExp: TPopupMenu;
    toASCIIFileItem: TMenuItem;
    mSetLanguage: TMenuItem;
    mHelp: TMenuItem;
    mAbout: TMenuItem;
    itemShowwellcomewindow: TMenuItem;
    PrinterSetupDialog: TPrinterSetupDialog;
    PrinterSetup: TMenuItem;
    ImageListVwork: TImageList;
    ImageListScanTool: TImageList;
    ToolBar1: TToolBar;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ActionListControlPanelTools: TActionList;
    Scanning: TAction;
    Resonance: TAction;
    Landing: TAction;
    Camera: TAction;
    Training: TAction;
    RunOscilloscope: TAction;
    ShowOptions: TAction;
    ActionListLanding: TActionList;
    LandingFast: TAction;
    ImageListlanding: TImageList;
    LandingSlow: TAction;
    ImageListScanToolDis: TImageList;
    ActionListWorkDir: TActionList;
    ActionListMainToolBar: TActionList;
    ActionNew: TAction;
    ActionOpen: TAction;
    ActionGallery: TAction;
    ActionSaveAs: TAction;
    ActionExport: TAction;
    ActionPrint: TAction;
    ActionFAQ: TAction;
    ActionService: TAction;
    PopupMenuServ: TPopupMenu;
    mDriversSetup: TMenuItem;
    mCopyScripts: TMenuItem;
    mViewConfigFile: TMenuItem;
    RenishawLinearization1: TMenuItem;
    ActionSetWorkDir: TAction;
    ActionViewWorkdir: TAction;
    PopupMenuWorkDir: TPopupMenu;
    SetWorkDirectory: TMenuItem;
    ViewWorkDirectory1: TMenuItem;
    ImageListWorkDir: TImageList;
    ActionListWindowsArrange: TActionList;
    ActionVertical: TAction;
    ActionHorizontal: TAction;
    ActionCascade: TAction;
    ActionLeaveActive: TAction;
    ActionNextImage: TAction;
    ActionCloseAll: TAction;
    siLang1: TsiLang;
    siLangDispatcher1: TsiLangDispatcher;
    SendScanTo: TMenuItem;
    PanelMain: TPanel;
    Panel4: TPanel;
    PanelRight: TPanel;
    ToolBarDir: TToolBar;
    ToolbtnDir: TToolButton;
    PanelLvUnit: TPanel;
    PanelLevel: TPanel;
    PanelUnit: TPanel;
    ComboBoxLevel: TComboBox;
    ComboBoxSFMSTM: TComboBox;
    PanelWorkDir: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LabelUnit: TLabel;
    PanelControl_main: TPanel;
    PanelMonitor: TPanel;
    Panelleft: TPanel;
    PanelMainBar: TPanel;
    ToolBarMain: TToolBar;
    ToolBtnNew: TToolButton;
    ToolBtnOpen: TToolButton;
    ToolBtnGal: TToolButton;
    ToolBtnSave: TToolButton;
    ToolBtnExp: TToolButton;
    ToolBtnPrint: TToolButton;
    ToolBtnFAQ: TToolButton;
    ToolBtnDrv: TToolButton;
    ToolBtnTools: TToolButton;
    PanelControl: TPanel;
    ToolScanBar: TToolBar;
    ResonanceBtn: TToolButton;
    ToolbtnLanding: TToolButton;
    ScanBtn: TToolButton;
    ToolBtnOsc: TToolButton;
    ToolBtnTest: TToolButton;
    ToolBtnOpt: TToolButton;
    ToolBtnVideo: TToolButton;
    ToolBtnHelp: TToolButton;
    ActionHelp: TAction;
    UnitImage: TImage;
    TimerStartProgram: TTimer;
    V1: TMenuItem;
    ActionImageTools: TAction;
    GalleryShow: TMenuItem;
    toMDTfile: TMenuItem;
    Updates1: TMenuItem;
    ToolButtonRStest: TToolButton;
    ActionRSTest: TAction;
    toMDTfile1: TMenuItem;
    ActionExporttoASCII: TAction;
    ActionExporttoMDT: TAction;
    ImageList24: TImageList;
    ToolBtnPosXY: TToolButton;
    PositionXY: TAction;
    EurekaLog1: TEurekaLog;
    Askonline: TMenuItem;
    ToolBtnLog: TToolButton;
    ToolBtnADService: TToolButton;
    PopupMenuIniFiles: TPopupMenu;
    GetDeviceId1: TMenuItem;
    Adapter1: TMenuItem;
    TimerDetectMTPDev: TTimer;
    ActionListAdService: TActionList;
    ActionGetAdapterID: TAction;
    ActionAdapterService: TAction;
    SetpathtofirmVideoCamera: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    siSaveDialog1: TsiSaveDialog;
    TrayIcon1: TTrayIcon;
    MenuItemSelectScheme: TMenuItem;
    ChooseSampleBtn: TToolButton;
    simulation1: TMenuItem;
    Influenceoftheformofatipontheimage1: TMenuItem;
    SmesharikiPinCode: TMenuItem;
    ActionChooseSample: TAction;
    SynchroSEM: TMenuItem;
    OpenDialogSEM: TOpenDialog;
    RestoreUsersConfigFile1: TMenuItem;
    procedure PositionXYExecute(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ToolButtonRStestClick(Sender: TObject);
    procedure Updates1Click(Sender: TObject);
    procedure SaveAsMDTFileClick(Sender: TObject);
    procedure GalleryShowClick(Sender: TObject);
    procedure V1Click(Sender: TObject);
    procedure TimerStartProgramTimer(Sender: TObject);
    procedure ActionHelpExecute(Sender: TObject);
    procedure ToImageAnalys31Click(Sender: TObject);
    procedure UpdateStrings;
    procedure siLang1ChangeLanguage(Sender: TObject);
    procedure ToolBtnDrvClick(Sender: TObject);
    procedure ToolbtnDirClick(Sender: TObject);
    procedure ActionNextImageExecute(Sender: TObject);
    procedure ActionLeaveActiveExecute(Sender: TObject);
    procedure ActionCascadeExecute(Sender: TObject);
    procedure ActionHorizontalExecute(Sender: TObject);
    procedure ActionVerticalExecute(Sender: TObject);
    procedure ActionCloseAllExecute(Sender: TObject);
    procedure ActionImageToolsExecute(Sender: TObject);
    procedure ActionViewWorkdirExecute(Sender: TObject);
    procedure ActionSetWorkDirExecute(Sender: TObject);
    procedure ActionFAQExecute(Sender: TObject);
    procedure ActionPrintExecute(Sender: TObject);
//    procedure ActionExportExecute(Sender: TObject);
    procedure ActionSaveAsExecute(Sender: TObject);
    procedure ActionGalleryExecute(Sender: TObject);
    procedure ActionOpenExecute(Sender: TObject);
    procedure ActionNewExecute(Sender: TObject);
    procedure ActionUnregisterExecute(Sender: TObject);
    procedure ActionViewConfigExecute(Sender: TObject);
    procedure ActionRegisterExecute(Sender: TObject);
  //  procedure TimerHungUpTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RunCloseExecute(Sender: TObject);
    procedure ToolBtnCloseClick(Sender: TObject);
    procedure RunHelpExecute(Sender: TObject);
    procedure ComboBoxSFMSTMSelect(Sender: TObject);
    procedure EtchingExecute(Sender: TObject);
    function  STMExecute:boolean;//(Sender: TObject);
    function  SFMExecute:boolean;//(Sender: TObject);
    procedure TrainingExecute(Sender: TObject);
    procedure LandingFastExecute(Sender: TObject);
    procedure LandingSlowExecute(Sender: TObject);
    procedure ShowOptionsExecute(Sender: TObject);
    procedure RunOscilloscopeExecute(Sender: TObject);
    procedure CameraExecute(Sender: TObject);
    procedure LandingExecute(Sender: TObject);
    procedure ResonanceExecute(Sender: TObject);
    procedure ScanningExecute(Sender: TObject);
    procedure HintHandler(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure FlashClick(Sender: TObject);
    procedure HelphtmlClick(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure CopytoClipBoardClick(Sender: TObject);
    procedure CopytoClipBoardWindows1Click(Sender: TObject);
    procedure ScannerClick(Sender: TObject);
    procedure ResonanceClick(Sender: TObject);
    procedure VideoMenuClick(Sender: TObject);
    procedure LabsWorkClick(Sender: TObject);
    procedure HelpMediaClick(Sender: TObject);
    procedure StatusBarMainDrawPanel(StatusBar: TStatusBar;Panel: TStatusPanel; const Rect: TRect);
    procedure MainTimerUpTimer(Sender: TObject);
    procedure ActionAdjustOscExecute(Sender: TObject);
    procedure ForumClick(Sender: TObject);
    procedure Manual1Click(Sender: TObject);
    procedure ToolBtnClientClick(Sender: TObject);
    procedure ComboBoxLevelSelect(Sender: TObject);
    procedure SetLanguage1Click(Sender: TObject);
    procedure RepTemplateClick(Sender: TObject);
    procedure ReportGeneratorClick(Sender: TObject);
    procedure ToolBtnGalClick(Sender: TObject);
    procedure FileInfItemClick(Sender: TObject);
    procedure SaveAsASCIIFileClick(Sender: TObject);
    procedure ToolBtnExpMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure About2Click(Sender: TObject);
    procedure ItemShowWellcomeWindowClick(Sender: TObject);
    procedure UnitImageClick(Sender: TObject);
    procedure AskonlineClick(Sender: TObject);
    procedure ToolBtnLogClick(Sender: TObject);
    procedure GetDeviceId1Click(Sender: TObject);
    procedure Adapter1Click(Sender: TObject);
//    procedure ToolBtnIniFilesClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure TimerDetectMTPDevTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionListAdServiceExecute(Action: TBasicAction; var Handled: Boolean);
    procedure ActionAdapterServiceExecute(Sender: TObject);
    procedure ActionGetAdapterIDExecute(Sender: TObject);
    procedure SetpathtofirmVideoCameraClick(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure MenuItemSelectSchemeClick(Sender: TObject);
    procedure ToolBtnSampleClick(Sender: TObject);
    procedure ToolbtnChooseSampleClick(Sender: TObject);
    procedure TooltnChooseSampleClick(Sender: TObject);
    procedure ComboBoxLevelChange(Sender: TObject);
    procedure Influenceoftheformofatipontheimage1Click(Sender: TObject);
    procedure SmesharikiPinCodeClick(Sender: TObject);
    procedure ActionChooseSampleExecute(Sender: TObject);
    procedure SynchroSEMClick(Sender: TObject);
    procedure RestoreUsersConfigFile1Click(Sender: TObject);

  private
    { Private declarations }
    FlgAutorising:boolean;
    flgCanClose:boolean;
    flgError:byte;
    TimeLimitDetectDEv:integer;
    HungUpTime :integer;
    widthrightpanel:integer;
    basecaption:string;
    addcaption:string;
    addworkdirectory:string;
    baseworkdircaption:string;
    HDEVNOT:HDEVNOTIFY;
    QuickRep: TQuickRep;
    DetailBand: TQRBand;
    QRImageTop: TQRImage;
    QRLabel: TQRLabel;
    QRImageBottom: TQRImage;
    siSaveDialog: TsiSaveDialog;
    tSaveExecutionState:Execution_State;

    procedure  WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure  GetWorkDirAndFirstTimeDetectPath(Filename:STRING);
    function   PrepareScannerData:integer;
    function   SetUnit:boolean;
    function   SetUnitDemo:boolean;
    procedure  WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    function   FindNotSavedScans:boolean;
    procedure  RestoreState;
    procedure  UnitInit;
    procedure  MoveToStartPoint(XStartnm, YStartnm:integer);
    procedure  ChooseWorkDir;
    function   NanoeduUnitCreate:boolean;
    function   ExecAndWaitEtch(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
    procedure  DispatchMyMSG(msg: TPrilipalkaMSG);
    procedure  NotifyAllToPrilipat;
    procedure  WMMOve(var Mes:TWMMove); message WM_Move;
    function   CreateQuickReportComponent:boolean;
    function   IsAdmin: Boolean;
    procedure  SaveSelectedData(const AFileName:string);
    procedure  SMOtherInstanceExecuted(var Message: TMessage); message SM_OTHER_INSTANCE_EXECUTED;
    function   ExecAndWaitDrivers(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
//    procedure  WMDDeviceChange(var MSG:TWMDeviceChange);message WM_DEVICECHANGE;
//    procedure  WMDDeviceChange(var MSG:TMessage);message WM_DEVICECHANGE;
    function   NanoeduControllerDetect:boolean;
    function   RunFirmSoftVideoCamera:boolean;
    function   CloseOsciloscope:boolean;
    function   KillTask(ExeFileName: string): integer;
    function   TestControllerParams:boolean;
    protected
  procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    widthmonitor:integer;
    flgTwoMonitors:boolean;
    procedure miFullScreenClick;
    function  ProcessTerminate{(dwPID:Cardinal)}:Boolean;
    procedure CreateMDIChild(Sender: TObject;const FileName:string;FlgView:integer;flgScan:boolean; flgRenishawCorrect:boolean); //flgScan =true -scan create during scanning; false open saved scan
//  procedure CreateMDIChildOne(Sender: TObject;const FileName:string;FlgReadBlock:integer);//  message Wm_CreateMDIChild;
    procedure CreateMDIChildSection(Sender: TObject;Section:TDataLine;n:integer;const Title:string;const 	FileHeadRcd:HeadParmType);
    procedure ActivateMenuItem(Sender:Tobject);
    function  ExecAndWaitMainOSC(const FileName, Params: ShortString;const winname:string; const WinState: Word):boolean;
    function  ExecAndWaitMainVideo(const FileName, Params: String;const winname:string; const WinState: Word): boolean;
    procedure MainStatusBarFill;
    procedure CreateWorkViewWnd(flg:boolean);
    procedure CopytoClipboardPrepare(Activeform:Tform);
    procedure CopytoClipBoardExecute(activeform:Tform);
    procedure ThreadDone(var AMessage : TMessage); message WM_ThreadDoneMsg;
    procedure ProcComboboxLevelSelect(Sender: TObject);
  end;

function MessageDlgCtr(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
const
	 strm1: string = ''; (* Demo version!! *)
	 strm2: string = ''; (* Please wait, while the probe is rising to the start position!!! *)
	 strm3: string = ''; (* Attention!!! *)
	 strm4: string = ''; (* The step motor has achieved top position! *)
	 strm5: string = ''; (* Chooose Device! *)
	 strm6: string = ''; (* error free cspmlib *)
	 strm7: string = ''; (* Not saved  work  files series exist. Save? *)
	 strm8: string = ''; (* Be attention! This operation can make only  Serviceman !! *)
   strm9: string = ''; (* Please wait, while  process will not be finished! *)
	strm10: string = ''; (* Turn on Controller!! *)
	strm11: string = ''; (* Nanoeducator; *)
	strm12: string = ''; (*  Work Directory -  *)
	strm13: string = ''; (* You have not Administrator rights.Change user status!  *)
	strm14: string = ''; (* No Config Ini File  *)
	strm15: string = ''; (* . Default Config Ini File Used! *)
	strm16: string = ''; (* Close Oscilloscope program!!  *)
	strm17: string = ''; (* Move probe away!! *)
	strm18: string = ''; (* Close all windows! *)
	strm19: string = ''; (* Save Work Files Series  *)
	strm20: string = ''; (* Delete All Work Files Series  *)
	strm21: string = ''; (* Attention! *)
	strm22: string = ''; (* STM is intendend for working with conductive samples,otherwise the probe will be destroyed!! *)
	strm23: string = ''; (* Check up  value of a voltage. *)
	strm24: string = ''; (* Close Scanner Trainning Windows! *)
	strm25: string = ''; (* Close Nanoeducator Video Camera, before Start Etching! *)
	strm26: string = ''; (* Printer is not connected. *)
	strm28: string = ''; (* Stop Scanning before exit!!! *)
	strm29: string = ''; (* Move away! *)
	strm30: string = ''; (* Stop approach before exit!!! *)
	strm31: string = ''; (* Close approach windows before exit!!! *)
	strm32: string = ''; (* Close Control Panel! *)
	strm33: string = ''; (* Close Video before Start! *)
	strm34: string = ''; (* Gallery directory do not exists!! *)
	strm35: string = ''; (* Controller drivers are not installed. Ask the administrator to install drivers! *)
	strm36: string = ''; (* Controller drivers are not installed. Install drivers! *)
	strm37: string = ''; (* program is active or error start program  *)
	strm38: string = ''; (* If it is error,close control panel and restart again *)
	strm39: string = ''; (* Before install updates of the program, don't forget to close the program 'Nanoeducator'. *)
	strm40: string = ''; (* To make updating the program you should  have administrator rights   *)
	strm41: string = ''; (* MSVideo *)
	strm42: string = ''; (* Close Scanner Trainning Windows! *)
	strm43: string = ''; (* Move the probe away! *)
	strm44: string = ''; (* There is no application associated with the given file name extension.Install flash player? *)
	strm45: string = ''; (* If you have problem with  instalation of drivers, run the Nanoeducator  as administrator! *)
	strm46: string = ''; (* NanoeducatorLE controller is turn off! *) // TSI: Localized (Don't modify!)
	strm461: string = ''; (* Continue work in turn off regime? *) // TSI: Localized (Don't modify!)
	strm462: string = ''; (* Turn on controller and continue work! *) // TSI: Localized (Don't modify!)
	str463: string = ''; (* Turn on controller! *)
	str50: string = ''; (* The videocamera firm software has not installed!! *)
	str51: string = ''; (* Install software and set path to software!! *)
	str52: string = ''; (* Restore Users Config File? *) // TSI: Localized (Don't modify!)
	strHintNewTurnon: string = ''; (* turn on the controller *) // TSI: Localized (Don't modify!)
	strHintNewOk: string = ''; (* start new experimnent *) // TSI: Localized (Don't modify!)
	strfilenotexists: string = ''; (*  file not exists *)
	strcontrer: string = ''; (* Controller parameters have not setted! *) // TSI: Localized (Don't modify!)
  var
  FlgTrans:Boolean;
  Rgn,FullRgn: THandle;
  strutf8:  UTF8String ;   //  function AnsiToUtf8(const S: string): UTF8String;
  WINDOWS_VERSION:string;
  ArFrmSpectr:Tlist;
  ArFrmGl:Tlist;         //global list GL windows
  ArScanFrm:TList;
  ArFrmSect:Tlist;      //global list of section windows
  Main: TMain;
//  USBDetect:TComponentUSB;
  WorkView:TfrSPMView;
  DirView:TfrSPMViewFull;
  FMDTServiceForm : TMDTServiceForm;

implementation

uses Globaltype,GlobalVar,GlobalFunction,SioCSPM,frControllerDetect,frWelCome,frChangeDir,frOpenGLDraw,frSectionDraw,
     frtools, frHeader,frAbout, UUpdater,UAdapterService,
     uFileOp, spm_browserclasses, fShockwave, uScannerCorrect,frStartwork,dllImageAnalWnd,
     frSetPalette, frScale,SystemConfig,mHardWareOpt, {, MainUnitClient, MainUnitServer,,}
     UFindProcess,Video, UNanoEduBaseClasses, uNanoEduClasses,UNanoEduDemoClasses,
     frMedia,frExperimParams,frLanguage, frBeginnerGuide,frSpectroscopy, frSpectroscopyTerra,frSpectroscopyV,frScanWnd,
     frReport,NanoeduHelp,frPositionXYZ, frResonance, frScannerTraining,FrControllerTurnOn
     {,SetupApi}, frApproachnew, ReadandExport,configmgr,frProgressMoveto,frAdapterService, UNanoEduInterface,
     {$IFDEF DEBUG}
       frDebug,
      {$ENDIF}
     FrInform,{ DockWorkViewWnd} frViewConfigFile, frSetOSCParams, frDeviceReady, frVideoSoftSetting,
     frNoFormUnitLoc,{ frDockWorkViewWnd,} frChooseUnit, frChooseSample, RenishawVars, frRenishawOsc,
     MLPC_API2Lib_TLB,MLPC_API2DEMOLIB,NL3LFBLib_TLB,MLPC_APILib_TLB,setupAPI,
     ThreadReadFromAdapter,ThreadGetDeviceId,ThreadWriteToAdapter,frUnitInitEtap, MSVideoDEMO,
    frChangePath, frProgramSettings,UControllerService, ThreadGetControllerParams;
const
    strManMes1='';
    strManMes2='';
    strManMes3='';
//	strManMesVer: string =  'Demo version!!;
//	strManMesTurnon: string ='Turn on Controller! ;
    strManMes4='';
{$R *.DFM}
var  flgCascadGL:Boolean;
     ires:integer;
     swapm,ramm:integer;   //swap file size; ram memory size
     sSr:TsearchRec;
     FF:File;

function GetVersionExA(var lpVersionInformation: TOSVersionInfoEX): BOOL; stdcall;   external kernel32;

function OSInfo():String;
var
  NTBres, BRes: Boolean;
  OSVI: TOSVERSIONINFO;
  OSVI_NT: TOSVERSIONINFOEX;
  TmpStr: String;
begin
  Result := 'Error';
  NTBRes := False;
  try
    OSVI_NT.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFOEX);
    NTBRes := GetVersionExA(OSVI_NT);
    OSVI.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    BRes := GetVersionEx(OSVI);
  except
    OSVI.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    BRes := GetVersionEx(OSVI);
  end;
  if (not BRes) and (not NTBres) then Exit;
  Move(OSVI, OSVI_NT, SizeOf(TOSVersionInfo));

  case OSVI_NT.dwPlatformId of
    VER_PLATFORM_WIN32_NT:
    begin
      if OSVI_NT.dwMajorVersion <= 4 then Result := 'Windows NT' ;
       if  (OSVI_NT.dwMajorVersion = 5) and
        (OSVI_NT.dwMinorVersion = 0) then Result := 'Windows 2000';
      if  (OSVI_NT.dwMajorVersion = 5) and
        (OSVI_NT.dwMinorVersion = 1) then Result := 'Windows XP';
      if (OSVI_NT.dwMajorVersion = 6) and
        (OSVI_NT.dwMinorVersion = 0) then Result := 'Windows Vista';
    end
  else  Result :=' Old Version'
  end;
end;
function MessageDlgCtr(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  with  Main.siLang1.CreateMessageDialog(Msg, DlgType, Buttons) do
  try
    HelpContext := HelpCtx;
    if assigned(Screen.ActiveForm) then
     begin
     Left := Screen.ActiveForm.Left + (Screen.ActiveForm.Width div 2) -
      (Width div 2);

     Top := Screen.ActiveForm.Top + (Screen.ActiveForm.Height div 2) -
      (Height div 2);
     end;
    Result := ShowModal;
  finally
    Free;
  end;
end;



procedure TMain.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    ExStyle := ExStyle or WS_EX_APPWINDOW;
    WndParent := GetDesktopWindow;
  end;
end;

procedure TMain.WMSysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = SC_MINIMIZE then     ShowWindow(Handle, SW_MINIMIZE)
                               else      inherited;
end;  

function   TMain.FindNotSavedScans:boolean;
var dr:string;
      FF:File;
    sFile:string;
    ires,iresD,res:integer;
    sSr,sSrD:TsearchRec;
begin
    result:=false;
    ires:=FindFirst(WorkDirectory+'\'+WorkFileMask,faAnyFile,sSR);
     while ires = 0 do
      begin
         if  (AnsiContainsText(ExtractFileName(sSR.Name),WorkNamefileMaskCur)){ and  (ExtractFileName(sSR.Name)<>ExtractFileName(WorkNameFile)) }then
          begin
           if not assigned(WorkView) then  CreateWorkViewWnd(true);
            Application.ProcessMessages;
            if silang1.MessageDlg(strm7{'Not saved  work  files series exist. Save?'},mtConfirmation,[mbYes,mbNo,mbHelp],IDH_SaveResults)=mrYes then
            begin
            if assigned(DirView) then
                                 begin
                                   DirView.SetFocus;
                                 end
                                 else
                                 begin
                                   OpenDirectory:=WorkDirectory;
                                   ActionOpenExecute(nil);
                                 end;
              FindClose(sSR);
              result:=true;
              ActionNew.Visible:=true;
              ActionNew.Enabled:=true;
              exit;
           end
           else
           begin
             FindClose(sSR);
             iresD:=FindFirst(WorkDirectory+'\'+WorkFileMask,faAnyFile,sSRD);
             while iresD = 0 do
               begin
                 if  (AnsiContainsText(ExtractFileName(sSRD.Name),WorkNamefileMaskCur)) then
                  begin
                    AssignFile(FF,WorkDirectory+'\'+sSRD.Name);
                    Erase(FF);
                  end;
                   iresD:=FindNext(sSRD);
               end;
                FindClose(sSRD);
                if assigned(DirView)then
                                  begin
                                    DirView.SetFocus;
                                    DirView.ReDraw
                                  end;
               if  assigned(WorkView)then
                                  begin
                                    WorkView.SetFocus;
                                    WorkView.ReDraw
                                  end;
           end;
           break;
          end;
         ires:=FindNext(sSR);
      end;
    FindClose(sSR);
end;

procedure TMain.SaveSelectedData(const AFileName:string);
var  inFileName:string;
begin
 if (ActiveMDIChild is  TfrmGL) or (ActiveMDIChild is  TSpectroscopy)
 { or(ActiveMDIChild is  TSpectroscopyV )} then
 begin
  if ActiveMDIChild is  TfrmGL        then inFileName:=TfrmGL(ActiveMDIChild).FileNameGL;
  if ActiveMDIChild is  TSpectroscopy then inFileName:=TSpectroscopy(ActiveMDIChild).LFileName;
   SaveAsMDT(inFileName, AFileName);
 end;
 // TfrmGL(ActiveMDIChild).SaveAsMDT(AFileName);
end;
procedure TMain.SmesharikiPinCodeClick(Sender: TObject);
var locdir:string;
    InitialDir,filename:string;
begin
   SmesharikiPinCode.enabled:=False;
  if lang = 2 then
  begin
   locdir:='rus';
   InitialDir:=CommonNanoeduDocumentsPath+'video' +'\'+locdir;
   fileName:=InitialDir+'\'+tutanima;
   if Fileexists(Filename) then   ExecAndWaitMainVideo(Filename,'','',SW_showNORMAL)
                          else   silang1.MessageDlg(Filename+strfilenotexists,mtWarning ,[mbOK],0);
  end
  else
  begin
   locdir:='eng';
   InitialDir:=CommonNanoeduDocumentsPath+'video' +'\'+locdir;
   fileName:=InitialDir+'\'+tutanima;
  end;
 if Fileexists(Filename) then   ExecAndWaitMainVideo(Filename,'','',SW_showNORMAL)
                         else   silang1.MessageDlg(Filename+strfilenotexists,mtWarning ,[mbOK],0);
   SmesharikiPinCode.enabled:=True;
end;

procedure  TMain.SMOtherInstanceExecuted(var Message: TMessage);
var flgRScor:boolean;
fileToOpen:string;
begin
  if Message.WParam <> 0 then
  begin
   fileToOpen  := string(PChar(Message.WParam));
   if fileexists(fileToOpen) then
   begin
    flgRScor:=MakeFileRSCorrection(FiletoOpen);
    CreateMDIChild(self,FiletoOpen,1,false,FlgRSCor);
    application.ProcessMessages;
 //   sleep(1000);
   end;
    StrDispose(PChar(Message.WParam));
  end;
end;

procedure TMain.WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo);
var
Sz : SIZE;
begin
 Sz := FullScreenHandler.MaxSize;
 with Message.MinMaxInfo^ do begin
  ptMaxSize := TPoint(Sz);
  ptMaxTrackSize := TPoint(Sz);
end;
end;

function   TMain.SetUnit:boolean;
begin


              case flgUnit of
             Probeam:begin
                       if flgMotor=PiezoM then
                         if fileexists(ExeFilePath+'Data\'+'sem.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'sem.jpg');
                       if flgMotor=StepM then
                        begin
                         ShowMessage(' SEM Device doesn''t suit to Step Mover; Educator Device is On! ');
                         if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
                         flgUnit:=Nano;
                         pAdapterHead^.aflgUnit:=Nano;
                        end;
                    end;
             MicProbe:begin
                       if flgMotor=PiezoM then
                         if fileexists(ExeFilePath+'Data\'+'micprobe.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'micprobe.jpg');
                       if flgMotor=StepM then
                        begin
                         ShowMessage(' SEM Device doesn''t suit to Step Mover; Educator Device is On! ');
                         if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
                         flgUnit:=Nano;
                         pAdapterHead^.aflgUnit:=Nano;
                        end;
                    end;
              Terra:begin
                         if flgMotor=PiezoM then flgUnit:=Terra;
                         if flgMotor=StepM  then
                         begin
                         ShowMessage(' Terra Device doesn''t suit to Step Mover; Educator Device is On! ');
                          flgUnit:=Nano;
                          pAdapterHead^.aflgUnit:=Nano;
                          if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
                         end;
                         if flgUnit=Terra then
                         begin
                           ScanMScrpt:=ScanMScrptTerra;
                           SpectrNScrpt:=SpectrNScrptTerra;
                            if fileexists(ExeFilePath+'Data\'+'terrahrz.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'terrahrz.jpg');
                         end;
                    end;
              Nano: begin
                       flgUnit:=nano;
            //           flgUnit:=Terra;
                         if flgUnit=Terra then
                         begin
                           ScanMScrpt:=ScanMScrptTerra;
                           SpectrNScrpt:=SpectrNScrptTerra;
                            if fileexists(ExeFilePath+'Data\'+'terrahrz.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'terrahrz.jpg');
                         end;

                       if flgMotor=StepM then
                          if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
                       if flgMotor=PiezoM then
                        begin
                        ShowMessage(' Educator Device doesn''t suit to Piezo Mover; SEM Device is On! ');
                         FlgUnit:=Probeam;
                         pAdapterHead^.aflgUnit:=ProBeam;
                         if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
                        end;
                    end;
           nanoTutor: begin
                          flgUnit:=nano;
                          if flgMotor<>PiezoM then
                          begin
                           ShowMessage(' Nanotutor device doesn''t suit to Step Mover; Naoeducator device is On! ');
                           if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
                          end;
                     end;
                                     end;

end;
function   TMain.SetUnitDemo:boolean;
begin
              case flgUnit of
            Probeam:begin
                      flgMotor:=PiezoM ;
                       if fileexists(ExeFilePath+'Data\'+'sem.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'sem.jpg');
                    end;
           MicProbe:begin
                       flgMotor:=PiezoM ;
                       if fileexists(ExeFilePath+'Data\'+'micprobe.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'micprobe.jpg');
                    end;
              Terra:begin
                         flgMotor:=PiezoM;
                         flgUnit:=Terra;
                         if flgUnit=Terra then
                         begin
                           ScanMScrpt:=ScanMScrptTerra;
                           SpectrNScrpt:=SpectrNScrptTerra;
                            if fileexists(ExeFilePath+'Data\'+'terrahrz.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'terrahrz.jpg');
                         end;
                    end;
              Nano: begin
                         flgUnit:=nano;
                         flgMotor:=StepM;
                       if flgUnit=Terra then
                         begin
                           ScanMScrpt:=ScanMScrptTerra;
                           SpectrNScrpt:=SpectrNScrptTerra;
                            if fileexists(ExeFilePath+'Data\'+'terrahrz.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'terrahrz.jpg');
                         end;
                       if flgMotor=StepM then
                          if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
                    end;
         NanoTutor: begin
                          flgUnit:=nano;
                          flgMotor:=StepM;
                           if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
                     end;
                                         end;

end;
function TMain.PrepareScannerData:integer;
var taskdata:integer;
    fname:string;
begin
//result   =0 ok, 1= not connection;    999- not define
    if  (not FlgDataScannerHaveRead) or (flgCurrentUserLevel=Demo) then
   begin
     result:=0;
     flgAdapterLink:=false;
        if assigned(NanoEdu) then
         begin
          AdapterID:=0;
          Nanoedu.GetAdapterID;
          {$IFDEF DEBUG}
            Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_15' (* 'Get adapter ID ' *) ));
          {$ENDIF};
         if assigned(formInitUnitEtape) then  formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_15' (* 'Get adapter ID ' *) ));
          if flgCurrentUserLevel=Demo then
          begin
            if assigned(formInitUnitEtape) then
            begin
             formInitUnitEtape.CheckListBox.Checked[idgetadapterid]:=true;
             formInitUnitEtape.CheckListBox.Checked[idreadparams]:=true;
            end;
          end;

          while  assigned(Nanoedu.Method) do application.processmessages;

         if not flgAdapterLink then //not connection
                          begin

                           // if assigned(formInitUnitEtape) then  formInitUnitEtape.Close;
                            result:=1;  //not connection
                            exit;
                           end; // exit messages
         Nanoedu.GetControllerParams;
               {$IFDEF DEBUG}
            Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('Get Controller param '  ));
          {$ENDIF};
  (*        if assigned(formInitUnitEtape) then  formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_15' {* 'Get adapter ID ' }) ));
          if flgCurrentUserLevel=Demo then
          begin
            if assigned(formInitUnitEtape) then
            begin
             formInitUnitEtape.CheckListBox.Checked[idgetadapterid]:=true;
             formInitUnitEtape.CheckListBox.Checked[idreadparams]:=true;
            end;
          end;
   *)
             while  assigned(Nanoedu.Method) do application.processmessages;


            SetDefaultIniFilesPath;

           case AdapterID of
          AdNanoId,
          AdReniId,
          AdPMId:begin
                     case AdapterID of
          AdPMId:    flgMotor:=PiezoM;     //need combine PM+Reni; StepM+Reni
          AdNanoId:  flgMotor:=StepM;
          AdReniId:  flgMotor:=StepM;//flgReniShaw:=
                       end;
                     flgAllDataReadFromAdapter:=false;
                     flgGetScannerOptModeX:=false;
                     flgGetScannerOptModeY:=false;
                     flgGetLinModXAxisX:=false;
                     flgGetLinModXAxisY:=false;
                     flgGetLinModYAxisX:=false;
                     flgGetLinModYAxisY:=false;

                     Nanoedu.TestAdapterIsNew;

                     if assigned(formInitUnitEtape) then  formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_23' (* 'Test if  adapter is new ' *) ));

                    while assigned(Nanoedu.Method) do application.processmessages;
                if flgAdapterEmpty or flgAdapterNotFilled then
                     begin
                       if flgAdapterEmpty then
                       begin
                          {$IFDEF DEBUG}
                            Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_24' (* 'Adapter is empty!!' *) ));
                          {$ENDIF};
                       if assigned(formInitUnitEtape) then   formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_24' (* 'Adapter is empty!!' *) ));
                        silang1.MessageDlg(siLang1.GetTextOrDefault('IDS_24' (* 'Adapter is empty!!' *) ), mtInformation,[mbYes], 0);
                        SetDefaultIniFilesPath;
                       end
                       else
                       if flgAdapterNotFilled then
                       begin    //notfilled
                         if not FindScannerInDbase then
                            begin
                              CreateNewScanner(HardWareopt.ScannerNumb);
                              SetScannerIniPath;
                              LoadScannerParams(false);
                              initAdapterHeaderBufRecord;
                              ShowMessage(siLang1.GetTextOrDefault('IDS_52' (* 'Scanner ' *) )+ HardWareopt.ScannerNumb
                                 +siLang1.GetTextOrDefault('IDS_54' (* ' is created in DBase by default scanner data' *) )+#13+
                                 siLang1.GetTextOrDefault('IDS_56' (* 'If you have got new data for this scanner copy it by hand' *) ));
                            end;

                         {$IFDEF DEBUG}
                           Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_27' (* 'Adapter is not filled!!' *) ));
                         {$ENDIF};
                        if assigned(formInitUnitEtape) then  formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_27' (* 'Adapter is not filled!!' *) ));
                        silang1.MessageDlg(siLang1.GetTextOrDefault('IDS_27' (* 'Adapter is not filled!!' *) ), mtInformation,[mbYes], 0);
                        if flgGetHeader then SetScannerIniPath
                       end;
                  //     SetUnit;   // Ola     закомментировано 03/07/2013
                      initAdapterHeaderBufRecord;
                      UnitInit;
                      FlgDataScannerHaveRead:=true;
                      AdapterService:= TAdapterService.Create(Application);   // если нет, открыть форму и записать в адаптер из Базы
                      if AdapterService.ShowModal<>mrOK then ;//exit;                              // или создать новую папку сканера в базе
                       if assigned(formInitUnitEtape) then
                       begin
                        formInitUnitEtape.CheckListBox.Checked[idreadparams]:=true;
                        formInitUnitEtape.ProgressBar.position:=idreadparams;
                       end;
                    end
                     else
                     begin
                    //read from adapter
                      Taskdata:=$7F;      //read all
                     if assigned(formInitUnitEtape) then
                     begin
                       formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_30' (* 'Adapter has scanner parameters' *) ));
                       formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_31' (* 'Read data from adapter' *) ));
                     end;
                      NanoEdu.ReadFromDataAdapter(taskdata);
                      while assigned(Nanoedu.Method) do application.processmessages;
                     end;
                    end;
          AdDemoId:begin
                     flgAllDataReadFromAdapter:=false;//170113
                     SetDemoIniFilesPath;
                     initAdapterHeaderBufRecord;
                     //12.08.13
                     SetUnitDemo;
                   //  flgUnit:=nano;  11/01/16
                   //  flgMotor:=StepM; 11/01/16
                   //  if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
                     //
                     UnitInit;
                   end;
                end;
           end;
   end
   else
    begin
    UnitInit;
    end;
//            result:=0;//true;
           NanoEdu.TurnOn;               // too early-  not set parameters
end;
procedure TMain.miFullScreenClick;
begin
if NOT FullScreenHandler.InFullScreenMode
           then  begin PanelMain.Visible:=false; FullScreenHandler.Maximize(Self); end
           else  begin PanelMain.Visible:=true;  FullScreenHandler.Restore(Self);  end;
end;
procedure TMain.RestoreState;
begin
   case STMflg of
true: begin
       STMExecute;//(self);
       ComboBoxSFMSTM.ItemIndex:=1;
      end;
false:begin
        SFMExecute;//(self);
        ComboBoxSFMSTM.ItemIndex:=0;
      end;
      end;
end;
procedure TMain.RestoreUsersConfigFile1Click(Sender: TObject);
begin
    if fileexists(ExeFilePath+ConfigUsersDefIniFile)   then
       begin
       if (silang1.MessageDlg(str52,mtConfirmation,[mbYes,mbNo],0)=mrYES) then
          FileCopyStream(ExeFilePath+ConfigUsersDefIniFile,ConfigUsersIniFilePath+ConfigUsersIniFile);
       end;
end;

function TMain.ExecAndWaitEtch(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
var StartInfo: TStartupInfo;
     ProcInfo: TProcessInformation;
      CmdLine: ShortString;
            H: hWnd;
            R:TRECT;
begin { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
   CmdLine := '"' + Filename + '" ' + Params;
   FillChar(StartInfo, SizeOf(StartInfo), #0);
   with StartInfo do
    begin //cb := SizeOf(SUInfo);
     dwFlags := STARTF_USESHOWWINDOW;
     wShowWindow := WinState;
    end;
     Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
     { Ожидаем завершения приложения }
    if Result then
     begin
      WaitForSingleObject(ProcInfo.hProcess, INFINITE); { Free the Handles }
      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);
     end;
end;

function TMain.NanoeduUnitCreate:boolean;
 var
  FormCoord: TPoint;
  LinError:integer;
  NewItem:TMenuItem;
  lFlgStatusStep:apitype;
  reg:TRegistry;
  res,error:integer;
  olddir:string;
   MLPCNPages:integer;
begin
   result:=false;
   flgLinYScanner:=false;
   flgLinXScanner:=false;
   SetIntActOnProgr:=False;
//      ChooseWorkDir;
      LoadPIDConfig;
      InitAdapterBufers;
      InitControllerBufers;
     // Здесь создается Nanoedu
      case STMflg of
   true: if not  STMExecute then
         begin
           if assigned(formInitUnitEtape) then
           begin
            formInitUnitEtape.flgactive:=false;
             formInitUnitEtape.close;
           end;
           exit;
         end;//(self);
  false: if not  SFMExecute then
         begin
           if assigned(formInitUnitEtape) then
           begin
            formInitUnitEtape.flgactive:=false;
            formInitUnitEtape.close;
           end;
          exit;
         end;//(self);                          // Здесь создается Nanoedu
      end;

       ChooseWorkDir;          //02.02.13

       if assigned(formInitUnitEtape) then
           begin
            formInitUnitEtape.CheckListBox.Checked[idsetparams]:=true;
            formInitUnitEtape.ProgressBar.Position:=10+idsetparams;
            formInitUnitEtape.CheckListBox.Checked[idready]:=true;
            formInitUnitEtape.ProgressBar.Position:=10+idready;
           end;
           sleep(1000);
       if assigned(formInitUnitEtape) then
       begin
        formInitUnitEtape.flgactive:=false;
        formInitUnitEtape.close;
       end;

       Inform:=TInform.Create(Application);
       Inform.labelinf.caption:=strm2{'Please wait, while the probe is rising to the start position!!!'};
       Inform.Show;
       Application.ProcessMessages;
       //*****************
       //move to start position
       //*******************
     if flgAutoRising then      //what about sfm->stm
     begin
      flgNanoeduUnitCreate:=true;
      if (flgUnit=ProBeam) then lFlgStatusStep:=NanoEdu.RisingToStartPoint(100)     //changed sign - -> +
         else
         if (flgUnit=MicProbe) then lFlgStatusStep:=NanoEdu.RisingToStartPoint(100)  //changed sign - -> +      // need to known!!!!!!!!!!!!!!
                               else lFlgStatusStep:=NanoEdu.RisingToStartPoint(30);   //changed 220316
      flgNanoeduUnitCreate:=false;
      sleep(1000);   // 010913
     NanoEdu.TurnOff;
     end;

        Inform.Close;

      // nanoeduII
   if FlgCurrentUserLevel<>Beginner then
   begin
        ToolScanBar.Visible:=TRUE;
        ToolScanbar.Enabled:=true;
        MenuItemSelectScheme.Enabled:=true;//False;
        RunOscilloscope.visible:=(FlgCurrentUserLevel=Advanced);
        PositionXY.Visible:=(flgUnit=ProBeam) or (flgUnit=MicProbe);          //160208 for testing
        Application.ProcessMessages;
      case STMFLG  of
  false:begin
         Landing.Visible:=false; //  true; 160114
         Training.Visible:=true;
         Resonance.Visible:=true;
        end;
  True: begin
         Landing.Visible:=true;
         Training.Visible:=true;
         Resonance.Visible:=false;
         Scanning.Visible:=false;//true;// test false;
        end;
             end;
   end;// not begginer

        case FlgUnit of
 ProBeam,MicProbe,
 Baby:
        begin
          Camera.Visible:=false;
          VideoMenu.Visible:=false;
          ApproachParams.flgAutorunCamera:=false;
          ApproachParams.flgControlTopPosition:=false;
        end;
        end;
//       Training.Visible:=FlgCurrentUserLevel<>demo;
       ToolButtonRStest.visible:=flgReniShawUNit;
       NewItem := TMenuItem.Create(Self);
       NewItem.Caption :='-';
       Main.mWindows.Add(NewItem);
       NewItem := TMenuItem.Create(Self);
       NewItem.Caption := self.Caption;
       NewItem.OnClick:=Main.ActivateMenuItem;
       Main.mWindows.Add(NewItem);
       result:=true;
end;
//
procedure TMain.DispatchMyMSG(msg: TPrilipalkaMSG);
var
  i: integer;
  cMsg: TPrilipalkaMSG;
begin
//пробегаемся по всем компонентам объекта Application
//и отсылаем им свое сообщение
cMsg:=msg;
(*with Application do
  for i:=0 to ComponentCount-1 do
    begin
      cMsg:=msg;
      Application.Components[i].Dispatch(cMsg);
    end;    *)
      if assigned(workview)   then Workview.dispatch(cMSg);
      if assigned(ImageTools) then ImageTools.dispatch(cMSg);
end;


procedure Tmain.NotifyAllToPrilipat;
var
  pm: TPrilipalkaMSG;
begin
//задаем параметры сообщения
  pm.Msg:=CM_PrilipalkaMove;
  with pm do
    begin
        mfLeft:=Left;
         mfTop:=Top;
       mfRight:=Left+Width;
      mfBottom:=Top+Height;
    end;
//отправляем это сообщение всем формам эксперимента
  DispatchMyMSG(pm);
end;

procedure TMain.toImageAnalys31Click(Sender: TObject);
var filename:string;
begin
 if (ActiveMDIChild is TfrmGl) then
 begin
   filename:=TfrmGl(ActiveMDIChild).FileNameGL;
   ExecAndWait(ExeFilePath+'\ia3\ia3.exe' , Pchar(Filename),{SWP_NOMOVE or} SW_showNORMAL);
 end;
end;

procedure TMain.SaveAsMDTFileClick(Sender: TObject);
var
   NewFile,OldFile,TmpName:string;
   CurDir,Dir:string;
   inFileName:string;
begin
 if (ActiveMDIChild is TfrmGl)  or (ActiveMDIChild is TSpectroscopy)
     or (ActiveMDIChild is TSpectroscopyV) then
 begin
   siSaveDialog:=TsiSaveDialog.Create(self);
   siSaveDialog.siLang:=siLang1;
   siSaveDialog.Options:=[ofOverWritePrompt,ofShowHelp,ofEnableSizing];
   siSaveDialog.siLang.ActiveLanguage:=lang;
   CurDir:=GetCurrentDir;
   siSaveDialog.FilterIndex:=1;
   ForceCurrentDirectory :=True;
   siSaveDialog.DefaultExt:='mdt';
   siSaveDialog.Filter:=' MDT file *.mdt|*.mdt';
   if siSaveDialog.Execute then
   begin
     NewFile:=siSaveDialog.FileName;
     if ActiveMDIChild is  TfrmGL        then  inFileName:=TfrmGL(ActiveMDIChild).FileNameGL;
     if ActiveMDIChild is  TSpectroscopy then  inFileName:=TSpectroscopy(ActiveMDIChild).LFileName;
     SaveAsMDT(inFileName, NewFile);
   end;
  FreeAndNil(siSaveDialog);
 end;
end;

procedure TMain.ShowOptionsExecute(Sender: TObject);
begin
  if not assigned(Nanoedu) then
 begin
  MessageDlgCtr(strm5{'Chooose Device!'},mtwarning,[mbYes],0);
  exit;
 end;
 if not assigned(ApproachOpt) then
  begin
   ApproachOpt:=TApproachOpt.Create(self,ApproachOpt);
    with ApproachOpt do
     begin
          ScanOptSheet.TabVisible:=True;
          ApprOptSheet.TabVisible:=True;
    end;
  end
  else ApproachOpt.SetFocus;
end;

procedure TMain.siLang1ChangeLanguage(Sender: TObject);
begin
   UpdateStrings;
    basecaption:=ProgramName;//strm11{'NanoeducatorLE;'};
    baseworkdircaption:=strm12{' Work Directory - '};
    addcaption:='';
    caption:=basecaption;
  UpdateStrings;
end;

procedure TMain.RunOscilloscopeExecute(Sender: TObject);
var H:HWnd;
begin
 begin
   RunOscilloscope.enabled:=False;
 if   flgVideoOscConflict then
 begin
  h:=FindWindow(nil,Pchar(strm41{'MSVideo'}));
   if h=0 then
   begin
   if sLanguage='RUS'  then
  begin
     ExecAndWaitMainOSC(ExeFilePath+'oscilloscope\oscilloscope.exe' ,'','Oscilloscope',SW_showNORMAL);
  end
  else
  begin
   ExecAndWaitMainOSC(ExeFilePath+'oscilloscope\eng\oscilloscope.exe' ,'','Oscilloscope',SW_showNORMAL);
  end;
    sleep(300);
   end
   else  silang1.MessageDlg(strm33{'Close Video before Start!'},mtWarning ,[mbOK],0);
 end
 else
 begin             //SiGraph library test
//     ExecAndWaitMainOSC(ExeFilePath+'oscilloscope\oscilloscope' ,'','Oscilloscope',SW_showNORMAL);
  if sLanguage='RUS'  then
  begin
     ExecAndWaitMainOSC(ExeFilePath+'oscilloscope\oscilloscope.exe' ,'','Oscilloscope',SW_showNORMAL);
  end
  else
  begin
   ExecAndWaitMainOSC(ExeFilePath+'oscilloscope\eng\oscilloscope.exe' ,'','Oscilloscope',SW_showNORMAL);
  end;

    sleep(300);
 end;
     RunOscilloscope.enabled:=True;
end;
end;

procedure Tmain.MainStatusBarFill;
var
  MemInfo : TMemoryStatus;
begin
  MemInfo.dwLength := Sizeof (MemInfo);
  GlobalMemoryStatus (MemInfo);
  ramm:=MemInfo.dwAvailPhys div  (MemInfo.dwTotalPhys div 100);
  swapm:=MemInfo.dwAvailPageFile div (MemInfo.dwTotalPageFile div 100);
//  if rm<15 then beep;
//  if sw<20 then beep;
  StatusBarMain.Panels[0].Text := siLang1.GetTextOrDefault('IDS_20' (* 'Memory Status. Free: RAM  ' *) )
  + IntToStr(ramm)
    + siLang1.GetTextOrDefault('IDS_21' (* ' %;   Swap file  ' *) ) +
  IntToStr(swapm) + ' %';
end;

 procedure TMain.RunCloseExecute(Sender: TObject);
 var   lFlgStatusStep:apitype;
 begin
   if not FlgStopScan then
    begin
      ShowMessage(siLang1.GetTextOrDefault('strstrm28' (* 'Stop Scanning before exit!!!' *) ));
      exit;
    end;
  if assigned(ScanWnd) then
    begin
      ShowMessage(siLang1.GetTextOrDefault('IDS_46' (* 'Close Scan Window!!!' *) ));
      exit;
    end;
  if  flgApproachOK then
   begin
      if silang1.MessageDlg(strm17{'Move away!'},mtinformation,[mbYes,mbNo],0)=mrYes then
        begin
        Inform:=TInform.Create(Application);
         Inform.labelinf.caption:=strm2{'Please wait, while the probe is rising to the start position!!!'};
         Inform.Show;
         Application.ProcessMessages;
         if flgAutoRising then
         begin
//          lFlgStatusStep:=NanoEdu.RisingToStartPoint(30);    edited 14/03/17
             if (flgUnit=ProBeam) then lFlgStatusStep:=NanoEdu.RisingToStartPoint(100) else    //change sign - -> +
              if (flgUnit=MicProbe) then lFlgStatusStep:=NanoEdu.RisingToStartPoint(100)       // need to known!!!!!!!!!!!!!!
                                    else lFlgStatusStep:=NanoEdu.RisingToStartPoint(30);   //changed 220316
         end;
        Inform.Close;
       end;
        flgApproachOK:=false;
   end;
 if assigned(ApproachOpt) then  ApproachOpt.Close;
 Application.processmessages;

 if ( flgCurrentUserLevel<>Demo)then
 begin
  SaveConfigUsers;
 end;

 if assigned(WorkView) then
 begin
   WorkView.close;
 end;
  ToolScanBar.visible:=false;
  ActionNew.Enabled:=true;
  ActionNew.visible:=true;
  MenuItemSelectScheme.Enabled:=True;
  ComboBoxLevel.Enabled:=boolean(flgchangeUserLevel);
  {$IFDEF DEMO}
        ComboBoxLevel.Enabled:=false;
   {$ENDIF}
  caption:=basecaption;

 if assigned(formInitUnitEtape) then
 begin
  formInitUnitEtape.flgactive:=false;
  formInitUnitEtape.Close;
 end;

  FreeAndNil(NanoEdu);

  FreeAdapterBufers;

  FreeControllerBufers;

  if assigned(NanoeduDevice)    then
    begin
     DisconnectController;
    end;
end;

procedure TMain.RunHelpExecute(Sender: TObject);
begin
   Application.Helpcontext(IDH_Device_Panel);
end;

procedure TMain.ActionNewExecute(Sender: TObject);
var dr:string;
      FF:File;
    sFile:string;
    ires,iresD,res:integer;
     sSr,sSrD:TsearchRec;
     HR:HResult;
     DiscrVal:integer;
begin
ActionNew.Enabled:=false;
flgCanClose:=false;    //180114
SetFlgSetScanArea;
  case FlgCurrentUserLevel of
  Beginner:;
  Advanced:  ;//   ActionChooseSample.Visible:=false;
  Demo    : begin
              DemoSample:='stm\samples\'+'cd_pits';
              ChooseSample:= TChooseSample.Create(Application);
              ChooseSample.ShowModal;
           end;
       end;
 if not ToolScanBar.Visible then
 begin
    LinePointsMax:=ScanSizeMax;
    ComboBoxLevel.Enabled:=false;
    ComboBoxSFMSTM.Enabled:=false;
  if not InitParametersNanoedu then
   begin
    ActionNew.Enabled:=true;
    ComboBoxLevel.Enabled:=boolean(flgchangeUserLevel);
    ComboBoxSFMSTM.Enabled:=true;
    flgCanClose:=true;   //180114
    exit;
   end;

    GetScriptsName;

 if   FindNotSavedScans then
 begin
  flgCanClose:=true;   //180114
  exit;
 end;

 formInitUnitEtape:=TformInitUnitEtape.Create(self);
 formInitUnitEtape.Show;
 formInitUnitEtape.flgactive:=true;
    case   FlgCurrentUserLevel of
Beginner,
Advanced:begin
           Dr:=GetCurrentDir;
           ChDir(ExeFilePath);
        //   libHandle:=0;
           flgControlerTurnON:=false;
           {$IFDEF DEBUG}
             Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_49' (* 'try to create com' *) ));
           {$ENDIF}
           if assigned(formInitUnitEtape) then  formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_49' (* 'try to create com' *) ));
           NanoeduDevice:=CoMLabDevice.Create;
           {$IFDEF DEBUG}
             Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_51' (* 'com created' *) ));
           {$ENDIF}
            if assigned(formInitUnitEtape) then
            begin
             formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_51' (* 'com created' *) ));
             formInitUnitEtape.CheckListBox.Checked[idcom]:=true;
             formInitUnitEtape.ProgressBar.position:=idcom;
            end;
           HR:=NanoeduDevice.Connect('');
          if not FAILED(HR)  then
          begin
             {$IFDEF DEBUG}
               Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_53' (* 'device connect' *) ));
             {$ENDIF};
           if assigned(formInitUnitEtape) then
           begin
            formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_53' (* 'device connect' *) ));
            formInitUnitEtape.CheckListBox.Checked[idconnect]:=true;
            formInitUnitEtape.ProgressBar.position:=idconnect;
           end;
            flgControlerError:=not ConnectController;  //  load scheme
            flgControlerTurnON:=true;
          end
          else
          begin
           {$IFDEF DEBUG}
               Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_55' (* 'device not connect' *) ));
           {$ENDIF};
           if assigned(formInitUnitEtape) then  formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_53' (* 'device connect' *) ));
           flgControlerTurnON:=false;
          end;
          if not flgControlerError then
           begin
            if not flgControlerTurnON  then
            begin
             FormControllerTurnOn:=TFormControllerTurnOn.Create(Self);
             res:=FormControllerTurnOn.ShowModal;
                     case res of
          mrCancel: begin
                     ActionNew.visible:=true;
                     ComboBoxLevel.Enabled:=true;
                     ComboBoxSFMSTM.Enabled:=true;
                     ActionNew.Enabled:=false;
                     flgControlerTurnON:=false;
                     flgCanClose:=true; //180114
                     exit;
                    end;
              mrOK: begin
                     flgControlerTurnON:=true;
                     flgControlerError:=not ConnectController;
                       if flgControlerError then
                       begin
                        flgCanClose:=true; //180114
                        exit
                       end;
                    end;
                        end;
            end
           end
           else
           begin  //050213
            ActionNew.visible:=true;
            ActionNew.Enabled:=false;
            ComboBoxLevel.Enabled:=boolean(flgchangeUserLevel);
            ComboBoxSFMSTM.Enabled:=true;
            formInitUnitEtape.flgactive:=false;
            formInitUnitEtape.Close;
            flgCanClose:=true; //180114
            exit;
           end;

            Application.ProcessMessages;
            ChDir(Dr);

           flgAutoRising:=true;
//           flgAutoRising:=false;

          if flgControlerTurnON then
                          begin
                           ActionNew.visible:=true;
                           ActionNew.Enabled:=true;
                           ComboBoxLevel.Enabled:=boolean(flgchangeUserLevel);
                           ComboBoxSFMSTM.Enabled:=true;
                          end
                          else
                          begin
                           ActionNew.visible:=true;
                           ActionNew.Enabled:=false;
                           ComboBoxLevel.Enabled:=boolean(flgchangeUserLevel);
                           ComboBoxSFMSTM.Enabled:=true;
                           flgCanClose:=true; //180114
                           exit;
                          end;
                   case  FlgCurrentUserLevel of
           Beginner: FrBeginner:=TFrBeginner.Create(Application);
                     end;
       end;
  Demo:begin
             Dr:=GetCurrentDir;
             ChDir(ExeFilePath);
             flgControlerTurnON:=false;
           {$IFDEF DEBUG}
             Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_49' (* 'try to create com' *) ));
           {$ENDIF}
           if assigned(formInitUnitEtape) then  formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_49' (* 'try to create com' *) ));
           NanoeduDevice:=CoMLabDeviceDemo.Create;  //demo com !!!! need wrap com
           {$IFDEF DEBUG}
             Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_51' (* 'com created' *) ));
           {$ENDIF}
           if assigned(formInitUnitEtape) then  formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_51' (* 'com created' *) ));
          formInitUnitEtape.CheckListBox.Checked[idcom]:=true;
          formInitUnitEtape.ProgressBar.position:=idcom;
          begin
             {$IFDEF DEBUG}
               Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_53' (* 'device connect' *) ));
             {$ENDIF};
            if assigned(formInitUnitEtape) then
            begin
             formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_53' (* 'device connect' *) ));
             formInitUnitEtape.CheckListBox.Checked[idconnect]:=true;
             formInitUnitEtape.ProgressBar.position:=idconnect;
            end;
            flgControlerError:=not ConnectController;  //  load scheme
            flgControlerTurnON:=true;
          end;
           if  flgControlerError then
           begin
            ActionNew.visible:=true;
            ActionNew.Enabled:=false;
            ComboBoxLevel.Enabled:=boolean(flgchangeUserLevel);
            ComboBoxSFMSTM.Enabled:=true;
            formInitUnitEtape.Close;
              flgCanClose:=true; //180114
            exit;
           end;
             ChDir( Dr);
             Application.ProcessMessages;
             flgControlerTurnON:=true;
        end;
                  end; //case
               ComboBoxSFMSTM.Enabled:=true;
               ComboBoxLevel.Enabled:=boolean(flgchangeUserLevel);
               {$IFDEF DEMO}
                 ComboBoxLevel.Enabled:=false;
               {$ENDIF}
                   if not flgControlerTurnON then
                          begin
                           ActionNew.visible:=true;
                           ActionNew.Enabled:=false;
                           ComboBoxLevel.Enabled:=boolean(flgchangeUserLevel);
                           ComboBoxSFMSTM.Enabled:=true;
                             flgCanClose:=true; //180114
                           exit;
                          end
                          else
                          begin
                           ActionNew.visible:=true;
                           ActionNew.Enabled:=false;//true;
                           ComboBoxLevel.Enabled:=boolean(flgchangeUserLevel);
                           ComboBoxSFMSTM.Enabled:=true;
                          end;
     if not  NanoeduUnitCreate then
     begin
                           ActionNew.visible:=true;
                           ActionNew.Enabled:=true; //
                           ComboBoxLevel.Enabled:=boolean(flgchangeUserLevel);
                           ComboBoxSFMSTM.Enabled:=true;
     end
     else
     begin
         //
    with ScanParams do
    begin
     case  flgUnit of
      nano,terra,Pipette:  SetScanAreaDefR ;
      baby: ;
      ProBeam,MicProbe:    SetScanAreaDefR;
       end;
    end;


         //
          Voltage_toDiscr('X',0, DiscrVal, ScanAreaBeginXR)  ;     // Выход в точку 0 В по Х и Y
          Voltage_toDiscr('Y',0, DiscrVal, ScanAreaBeginYR)  ;

          if flgCurrentUserLevel = Demo then
                                         begin
                                           ScanAreaBeginXR:=0;
                                           ScanAreaBeginYR :=0;
                                         end;

          ScanParams.XBegin:= ScanAreaBeginXR;  // nm
          ScanParams.YBegin:= ScanAreaBeginYR;  // nm

        if ScanParams.flgMovetoZero then   MoveToStartPoint(ScanAreaBeginXR, ScanAreaBeginYR);
     end;
      Application.ProcessMessages;
 end;
 flgCanClose:=true;
end;

procedure TMain.ActionNextImageExecute(Sender: TObject);
begin
   Next;
  while not (ActiveMDIChild is  TfrmGL) and not (ActiveMDIChild is  TSection)
   and not (ActiveMDIChild is  TSpectroscopy) and not (ActiveMDIChild is  TSpectroscopyV) do Next;

end;

procedure TMain.ActionOpenExecute(Sender: TObject);
begin
 ActionOpen.Enabled:=False;
if assigned(WorkView) then  WorkView.DeActivate;
 if assigned(DirView) then DirView.SetFocus
                      else
                      begin
                       LoadDefPaletName(DefPaletName);    // Reads ConfigIni File
                       LoadPalette(DefPaletName);         // Reads PaletteIni File;
                       EvalPaletteLines();
                       DirView:=TfrSPMViewFull.Create(Self,OpenDirectory,{DirView,}1);
                      end;
 ActionOpen.Enabled:=true;
end;

procedure TMain.ActionPrintExecute(Sender: TObject);
 var
  i,x0,y0:integer;
  h:hwnd;
  ActiveCanvas: TCanvas;
  Frm: TfrmGL;
  Bitmap_Pic,BitMap_Header: TBitmap;
  Rect,RectDesc: TRect;
  old_top,old_left,old_width,old_height: integer;
  flgVisTools:boolean;
begin
if  (ActiveMDIChild is TfrmGl) then
begin
    CopytoClipBoardExecute(ActiveMDIChild);
      old_left:= ActiveMDICHild.Left;
      old_top:= ActiveMDICHild.Top;
      old_width:= ActiveMDICHild.Width;
      old_height:= ActiveMDICHild.Height;
      if not  CreateQuickReportComponent then  exit;
      Bitmap_Pic := TBitmap.Create;
      Bitmap_Header := TBitmap.Create;
    try
      Bitmap_pic.Width :=ClientWidth;
      Bitmap_pic.Height :=ClientHeight;
      Bitmap_pic.LoadFromClipBoardFormat(cf_BitMap,ClipBoard.GetAsHandle(cf_Bitmap),0);
      QRLabel.Height:=20;
      QRLabel.top:=0;
      QRLabel.Left:= 0;
      QRLabel.Width:= QRLabel.Parent.Width;
      QRLabel.Alignment:= taCenter;
      QRLabel.Font.Size:= 16;
      QRLabel.Caption:= ActiveMDICHild.Caption;
      QRImageTop.Top:= QRLabel.Height;
      QRImageTop.Width:= (QRImageTop.Parent.ClientWidth div 4)*3;//  Bitmap_pic.Width
      QRImageTop.Height:=round(QRImageTop.Width*Bitmap_pic.Height/Bitmap_pic.Width);
      QRImageTop.Left:= (QRImageTop.Parent.Width - QRImageTop.Width) div 2;
      QRImageTop.AutoSize:= false;
      QRImageTop.Stretch:= true;
      QRImageTop.Canvas.Pen.Style:= psClear;
      QRImageTop.Canvas.Brush.Color:= clWhite;
      QRImageTop.Canvas.Rectangle(Rect);
      QRImageTop.Picture.Assign(BitMap_pic);
      Rect:= Bounds(0,0,QRImageTop.Width,QRImageTop.Height);
      ActiveMDICHild.Top:= old_top;
      ActiveMDICHild.Left:= old_left;
      ActiveMDICHild.Width:= old_width;
      ActiveMDICHild.Height:= old_height;
      Frm:= TfrmGL(ActiveMDICHild);
      FileHeaderForm:=TFileHeaderForm.Create(Application,Frm.FileNameGL);
      FileHeaderForm.HeaderGrid.Color:= clWhite;
      FileHeaderForm.panel1.Color:= clWhite;
      FileHeaderForm.PanelBtns.Visible:=false;
      FileHeaderForm.Refresh;
      Application.ProcessMessages;
      old_width:= FileHeaderForm.HeaderGrid.width;//+FileHeaderForm.HeaderGrid.GridLineWidth;//567;//537;
      old_height:=FileHeaderForm.HeaderGrid.Height+FileHeaderForm.HeaderGrid.GridLineWidth
                 +FileHeaderForm.Memo.height+20;//320;//313;
      old_left:= FileHeaderForm.HeaderGrid.left;
      old_top:= FileHeaderForm.HeaderGrid.top;

      CopytoClipboardExecute(FileHeaderForm);

      Bitmap_header.Width :=old_width;
      Bitmap_header.Height :=old_height;
      Bitmap_header.LoadFromClipBoardFormat(cf_BitMap,ClipBoard.GetAsHandle(cf_Bitmap),0);
      QRImageBottom.Top   := QRLabel.Height+QRImageTop.Height;
      QRImageBottom.Width := (QRImageBottom.Parent.ClientWidth div 4)*3;//round(old_width*1.2);
      QRImageBottom.Height:=round(QRImageBottom.Width*Bitmap_header.Height/Bitmap_header.Width);// round(old_height*1.2);
      QRImageBottom.Left  := (QRImageBottom.Parent.Width - QRImageBottom.Width) div 2;
      QRImageBottom.Stretch:= true;
      QRImageBottom.Center:= true;
      QRImageBottom.Picture.Assign(BitMap_header);
      FileHeaderForm.Close;
      Application.processmessages;
      QuickRep.PreviewModal;
    finally
       FreeAndNil(Bitmap_Pic);
       FreeAndNil(Bitmap_Header);
    end;
   end
 else
  if (ActiveMDIChild is TSection) then
    begin
      old_left:= ActiveMDICHild.Left;
      old_top:= ActiveMDICHild.Top;
      old_width:= ActiveMDICHild.Width;
      old_height:= ActiveMDICHild.Height;
      if not  CreateQuickReportComponent then  exit;
      Application.Processmessages;
         { TODO : 101107 }
      Sleep(1000);
      Bitmap_Pic := TBitmap.Create;
   try
      Bitmap_pic.Width :=ClientWidth;
      Bitmap_pic.Height :=ClientHeight;
      CopyToClipBoardExecute(ActiveMDICHild);
      Bitmap_pic.LoadFromClipBoardFormat(cf_BitMap,ClipBoard.GetAsHandle(cf_Bitmap),0);
      QRLabel.Height:=20;
      QRLabel.Left:=0;
      QRLabel.Top:=0;
      QRLabel.Width:=QRLabel.Parent.Width;
      QRLabel.Alignment:=taCenter;
      QRLabel.Font.Size:=16;
      QRLabel.Caption:= ActiveMDICHild.Caption;
      QRImageTop.Top:= QRLabel.Height;
      QRImageTop.Width:=Bitmap_pic.Width;
      QRImageTop.Height:=Bitmap_pic.Height;
      QRImageTop.Left:=(QRImageTop.Parent.Width - QRImageTop.Width) div 2;
      QRImageTop.AutoSize:= false;
      QRImageTop.Stretch:= true;
      Rect:= Bounds(0,0,QRImageTop.Width,QRImageTop.Height);
      QRImageTop.Canvas.Pen.Style:= psClear;
      QRImageTop.Canvas.Brush.Color:= clWhite;
      QRImageTop.Canvas.Rectangle(Rect);
      QRImageTop.Picture.Assign(BitMap_pic);
      ActiveMDICHild.Top:= old_top;
      ActiveMDICHild.Left:= old_left;
      ActiveMDICHild.Width:= old_width;
      ActiveMDICHild.Height:= old_height;
      Application.Processmessages;
      QuickRep.PreviewModal;
      QuickRep.Visible:=false;
    finally
       FreeAndNil(Bitmap_Pic);
    end;
  end
else
 if (ActiveMDIChild is TSpectroscopy) then
 begin
   TSpectroscopy(ActiveMDIChild).BitBtnPrintClick(sender);
 end
else
if (ActiveMDIChild is TSpectroscopyV) then
 begin
   TSpectroscopyV(ActiveMDIChild).BitBtnPrintClick(sender);
 end;
end;

procedure TMain.ActionSaveAsExecute(Sender: TObject);
 var
  flgDeleteOld,flgRSCor:Boolean;
  lflgview:byte;
  h:HWND;
  count,i,old_top,old_left,ChildCount: integer;
  NewFile,OldFile,TmpName:string;
//  Opendir:string;
  //CurDir
  Dir,s:string;
  ActiveCanvas: TCanvas;
  Bitmap: TBitmap;
  jp:TJpegImage;
  Rect: TRect;
  ActiveForm:Tform;
  arrayformhide:array of Tform;
  fext:string;
  filtind:integer;
begin
   siSaveDialog:=TsiSaveDialog.Create(self);
   siSaveDialog.siLang:=siLang1;
   siSaveDialog.InitialDir:=saveasdirectory;//080410
   siSaveDialog.Options:=[ofOverWritePrompt,ofShowHelp,ofEnableSizing];
   siSaveDialog.siLang.ActiveLanguage:=lang;
    ActionSaveAs.enabled:=False;
 //   opendir:=GetCurrentDir;
 //   setcurrentdir(saveasdirectory);
 //   CurDir:=saveasdirectory;
    siSaveDialog.FilterIndex:=1;

if (ActiveMDIChild is TfrmGl)or (ActiveMDIChild is TSpectroscopy)
    or (ActiveMDIChild is TSpectroscopyV) then
 begin
      ForceCurrentDirectory :=True;
      old_left:= ActiveMDICHild.Left;
      old_top:= ActiveMDICHild.Top;
      siSaveDialog.FileName:='';
 if (ActiveMDIChild is TfrmGl)then
   begin
      siSaveDialog.DefaultExt:='spm|bmp|jpg';
      siSaveDialog.Filter:=' spm file *.spm| *.spm|image  files *.bmp|*.bmp|image  files *.jpg|*.jpg';
    if TfrmGL( ActiveMDICHild).flgModify then
     begin
      siSaveDialog.Filter:='modified spm files *.mspm| *.mspm|image  files *.bmp|*.bmp|image  files *.jpg|*.jpg';
      siSaveDialog.DefaultExt:='mspm';
     end;
  end
  else
  begin
      siSaveDialog.DefaultExt:='spm|bmp|jpg';
      siSaveDialog.Filter:=' spm file *.spm| *.spm|image  files *.bmp|*.bmp|image  files *.jpg|*.jpg';
  end;

///
  if siSaveDialog.execute then
  begin
      NewFile:=siSaveDialog.FileName;
      fext:=extractfileext(NewFile);
      filtind:=1;
      if (lowercase(fext) = '.spm') or (lowercase(fext) = '.mspm')  then  filtind:=1
      else if  lowercase(fext) = '.bmp' then  filtind:=2
      else if  lowercase(fext) = '.jpg' then  filtind:=3;

      Dir:=ExtractFileDir(NewFile);
      if not DirectoryExists(Dir)then CreateDir(Dir);

      // case  siSaveDialog.FilterIndex   of
        case  filtind   of
   1:begin    //spm
        if  ActiveMDIChild is TfrmGL then
         begin
           TmpName:=ExtractFileName(TfrmGL(ActiveMDIChild).TopoSPM.ImFileName);
           OldFile:=TfrmGL(ActiveMDIChild).PathFileNameGL+TmpName;
         end;
        if  ActiveMDIChild is TSpectroscopy then
         begin
           //   TmpName:=ExtractFileName(TSpectroscopy(ActiveMDIChild).lFileName);
           //   OldFile:=TmpName;
             if (ActiveMDIChild as TSpectroscopy).flgSpectrDone then
             OldFile:=TSpectroscopy(ActiveMDIChild).lFileName else
               begin   ActionSaveAs.enabled:=true; exit;   end;
         end;
        if  ActiveMDIChild is TSpectroscopyV then
         begin
           //   TmpName:=ExtractFileName(TSpectroscopyV(ActiveMDIChild).lFileName);
            //  OldFile:=TmpName;
             if (ActiveMDIChild as TSpectroscopyV).flgSpectrDone then
               OldFile:=TSpectroscopyV(ActiveMDIChild).lFileName else
             begin   ActionSaveAs.enabled:=true; exit;   end;
         end;
//      ChDir(CurDir);
      flgDeleteOld:=false;
      if (ActiveMDICHild is TfrmGL) and  not TfrmGL( ActiveMDICHild).flgModify   then  flgDeleteOld:=true;
      if (ActiveMDICHild is TSpectroscopy)  or (ActiveMDICHild is TSpectroscopyV)then  flgDeleteOld:=true;
      if flgDeleteOld then
       begin
        try
          FileCopyStream(OldFile,NewFile);
        except
        on IO: EInOutError do
         begin
          Case IO.errorcode of
           2: s:='file '''+Oldfile+'''not find';
           3: s:='error file name '''+newfile+'''';
           4: s:='file '''+newfile+''' accept denied ';
         101: s:='disk is full';
         106: s:='input error '+newfile+'''';
                    end;
            silang1.messageDlg(s+' try again!',mtwarning,[mbOk],0);
             ActionSaveAs.enabled:=true;
        //    SaveAsItem.Enabled:=true;
            exit;
         end;
        end;  //try
       lflgview:=TfrmGL(ActiveMDIChild).FlgView;
      end
      else   TfrmGL(ActiveMDIChild).SaveAs(NewFile);
     if  ArFrmGL.Count>0 then
     begin
      Count:=ArFrmGL.Count;
          for  i:=(Count-1)  downto 0  do
          begin
           ActiveForm:=ArFrmGL.Items[i];
           if pos(ExtractFileName(oldfile),ActiveForm.Caption)<>0 then
           begin
             flgRSCor:= TfrmGL(ActiveForm).flgRenishawCorrected;
             ActiveForm.Close;
             Application.ProcessMessages;
           end;
          end;
//           Application.ProcessMessages;
//           flgRSCor:= TfrmGL(ActiveForm).flgRenishawCorrected;
           CreateMDIChild(Sender,NewFile,FlgViewDef,false,flgRSCor);
      end;
            Application.ProcessMessages;
              ActionSaveAs.enabled:=true;
           //   ToolBtnSave.enabled:=True;
           // SaveAsItem.Enabled:=true;
         if assigned(DirView) and (Opendirectory=ExtractFileDir(siSaveDialog.FileName)) then begin {setcurrentdir(opendir);} DirView.ReDraw ; end;
         if assigned(WorkView)and (Workdirectory=ExtractFileDir(siSaveDialog.FileName)) then begin {setcurrentdir(workdirectory);} WorkView.ReDraw ; end;
        end;  //1,2,3
(*  2:  begin        //mdt
        if  ActiveMDIChild is TfrmGL then
         begin
         //  TmpName:=ExtractFileName(TfrmGL(ActiveMDIChild).TopoSPM.ImFileName);
         //  OldFile:=TfrmGL(ActiveMDIChild).PathFileNameGL+TmpName;
           (ActiveMDIChild as TfrmGL).SaveAsMDT(NewFile);
         end;
      end;
 *)
  2,3:   //bmp,jpg

   begin
    CopytoClipBoardExecute(ActiveMDIChild);
    Bitmap := TBitMap.create;
    try
     Bitmap.LoadFromClipBoardFormat(cf_BitMap,ClipBoard.GetAsHandle(cf_Bitmap),0);
    //  case siSaveDialog.FilterIndex of
    case  filtind   of
    2: begin
           Bitmap.SaveToFile(siSaveDialog.FileName);
       end;
    3: begin
          jp := TJpegImage.Create;
           try
             with jp do
              begin
               Assign(Bitmap);
               SaveToFile(siSaveDialog.FileName);
              end;
           finally
             FreeAndNil(jp);
           end;
       end;
         end;       //case
    finally
      Bitmap.free;
    end;
   end;
       end;  //case
    end;    // dialogfilesave.execute
  end
  else  //not  (ActiveMDIChild is TfrmGl)or (ActiveMDIChild is TSpectroscopy) or (ActiveMDIChild is TSpectroscopyV)
  if  (ActiveMDIChild is TfrSPMView)  then
  begin
   if assigned(stm_active) then
    if  stm_active.stm_label.caption<>'' then
    begin
     siSaveDialog.DefaultExt:=ExtractFileExt(stm_active.lname);//'spm';
     siSaveDialog.Filter:=' spm file *.spm;modified spm files *.mspm| *.spm; *.mspm';
     if siSaveDialog.execute then
     begin
        NewFile:=siSaveDialog.FileName;
       Dir:=ExtractFileDir(NewFile);
      if not DirectoryExists(Dir)then CreateDir(Dir);
      fext:=extractfileext(NewFile);
      filtind:=1;
      if lowercase(fext) = '.spm' then  filtind:=1
      else if  lowercase(fext) = '.mspm' then  filtind:=2;

     // case  siSaveDialog.FilterIndex   of
     case filtind of

   1,2:begin
              OldFile:=stm_active.lname;//OpenDirectory+'\'+stm_active.stm_label.caption;
         //     ChDir(CurDir);    080410
           try
              FileCopyStream(OldFile,NewFile);
           except
           on IO: EInOutError do
            begin
              Case IO.errorcode of
             2: s:='file '''+Oldfile+'''not find';
             3: s:='error file name '''+newfile+'''';
             4: s:='file '''+newfile+''' accept denied ';
            101: s:='disk is full';
            106: s:='input error '+newfile+'''';
                    end;
              silang1.messageDlg(s+siLang1.GetTextOrDefault('IDS_76' (* ' try again!' *) ),mtwarning,[mbOk],0);
              ActionSaveAs.enabled:=true;
         //       SaveAsItem.Enabled:=true;
         //     ToolBtnSave.enabled:=True;
              exit;
            end; //error copy
           end; //try
 //          setcurrentdir(opendir);
         if assigned(DirView) and (Opendirectory=ExtractFileDir(siSaveDialog.FileName)) then begin {setcurrentdir(opendir);} DirView.ReDraw ; end;
         if assigned(WorkView)and (Workdirectory=ExtractFileDir(siSaveDialog.FileName)) then begin {setcurrentdir(workdirectory);} WorkView.ReDraw ; end;
       end; //1,2 index
            end; //case FilterIndex
     end;   // execute
    end; //caption=''
   end// is TfrSPMView
   else
    if   assigned(ActiveMDIChild) then
    begin
      ForceCurrentDirectory :=True;
       old_left:= ActiveMDICHild.Left;
       old_top:= ActiveMDICHild.Top;
       siSaveDialog.DefaultExt:='bmp';
       siSaveDialog.Filter:=' image  files *.bmp|*.bmp|image  files *.jpg|*.jpg';
     if siSaveDialog.execute then
     begin
        CopyToClipBoardExecute(ActiveMDICHild);
        NewFile:=siSaveDialog.FileName;
        Dir:=ExtractFileDir(NewFile);
       if not DirectoryExists(Dir)then CreateDir(Dir);
        Bitmap := TBitMap.create;
      try
       Bitmap.LoadFromClipBoardFormat(cf_BitMap,ClipBoard.GetAsHandle(cf_Bitmap),0);
      fext:=extractfileext(NewFile);
      filtind:=1;

       if  lowercase(fext) = '.bmp' then  filtind:=1
      else if  lowercase(fext) = '.jpg' then  filtind:=2;
     //      case  siSaveDialog.FilterIndex   of
      case filtind of
        
        1: begin
             Bitmap.SaveToFile(siSaveDialog.FileName); { TюїЁрэ хь  ¤ъЁрэ т Їрщы}
           end;
        2: begin
             jp := TJpegImage.Create;
            try
             with jp do
              begin
               Assign(Bitmap);
               SaveToFile(siSaveDialog.FileName);
              end;
            finally
              FreeAndNil(jp);
            end;
           end;
        end;      //case
     finally
      FreeAndNil(Bitmap);
     end;
    end;    // dialogfilesave.execute
   end;
    saveasdirectory:=ExtractFileDir(siSaveDialog.FileName);
   FreeAndNil(siSaveDialog);
 //  saveasdirectory:=getcurrentdir;
   ActionSaveAs.enabled:=true;
end;

procedure TMain.CopytoClipboardPrepare(Activeform:Tform);
var bmp:Tbitmap;
   H: HDC;
   ClientOriginPoint:TPoint;
   ClientSource:TRect;
begin
try
  bmp := TBitmap.Create;
  bmp.Width  := Activeform.clientWidth;
  bmp.Height := Activeform.clientHeight;
  h := GetWindowDC(GetDesktopWindow);

  ClientOriginPoint:=Activeform.ClientOrigin;

  Windows.GetClientRect(Activeform.handle, ClientSource);

  BitBlt(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, h, ClientOriginPoint.x+ClientSource.Left,ClientOriginPoint.y+ClientSource.Top, SRCCOPY);

  finally
    ReleaseDC(0, h);
  end;
  ClipBoard.Assign(bmp);
  FreeAndNil(bmp);
end;

procedure TMain.CopytoClipBoardExecute(ActiveForm:Tform);
var
  DC : HDC;
  hrc: HGLRC;
  ActiveCanvas: TCanvas;
  Bitmap: TBitmap;
  Rect: TRect;
  i,old_top,old_left,ChildCount: integer;
  arrayformhide:array of TForm;//boolean;
  h:HWND;
begin
    old_Top:= ActiveForm.Top;
    old_Left:= ActiveForm.Left;
    setlength(arrayformhide,Screen.Formcount);
 try
     for  i := 0 to Screen.FormCount-1 do
         if  (Screen.Forms[i].Formstyle=fsStayOnTop) and Screen.Forms[i].visible then
            begin
             arrayformhide[i]:= Screen.Forms[i];
             Screen.Forms[i].Hide;
           end;
    ActiveForm.Top:= 0;
    ActiveForm.Left := 0;
//130509
  Application.ProcessMessages;

  { TODO : 101107 }
  Sleep(1000);
//     Application.processmessages;

     CopytoClipboardPrepare(Activeform);

    ActiveForm.Top:= old_top;
    ActiveForm.Left:= old_left;
    Application.processmessages;
   //
    for  I := 0 to length(arrayformhide)-1 do
           begin
            if assigned( arrayformhide[i]) then  arrayformhide[i].Show;
           end;

(*    for  i := 0 to Screen.FormCount-1 do
          begin
             if  (Screen.Forms[I].Formstyle=fsStayOnTop) and   arrayformhide[i] then Screen.Forms[I].Show;
           end;
*)
  if assigned(ReportForm) then   BringWindowToTop(ReportForm.handle);
  if h<>0 then ShowWindow(h, SW_RESTORE);
   Application.processmessages;
 finally
   Finalize(arrayformhide);
 end;
end;

procedure TMain.ActionSetWorkDirExecute(Sender: TObject);
var
res:integer;
olddir:string;
begin
//      ToolBtnDir.visible:=False;
      ToolBtnDir.down:=true;
      olddir:=workdirectory;
      ChangeDir:=TChangeDir.Create(self);
      res:=ChangeDir.ShowModal;
    if res=mrOK then
     begin
     if assigned(WorkView) and (olddir<>workdirectory) then
      begin
        WorkView.Redraw;//Close;
     //   CreateWorkViewWnd(true);
      end;
     end;
      ToolBtnDir.down:=false;
      Application.ProcessMessages;
     addworkdirectory:=baseworkdircaption+workdirectory;
     caption:=basecaption+addcaption+addworkdirectory;
end;

procedure TMain.ActionCascadeExecute(Sender: TObject);
  var i,step:integer;
     Frm:TForm;
     dy:integer;
begin
     step:=30;
     dy:=TopStart-step;
if FlgCascadGL then
    begin
    for i:=0 to (ArFrmSect.Count-1)    do
     begin
         Frm:=TSection(ArFrmSect.Items[i]);
         dy:=dy+step;
         SetWindowPos(Frm.handle,HWND_TOP,i*step,dy,100,100, SWP_NOSIZE);
     end;
    for i:=0 to (ArFrmGl.Count-1)    do
     begin
         dy:=dy+step;
         Frm:=ArFrmGl.items[i];
         SetWindowPos(Frm.handle,HWND_TOP,i*step,dy,100,100, SWP_NOSIZE);
     end;
     for i:=0 to (ArFrmSpectr.Count-1)    do
       begin
         Frm:=ArFrmSpectr.Items[i];
         dy:=dy+step;
         SetWindowPos(Frm.handle,HWND_TOP,i*step,dy,100,100, SWP_NOSIZE);
       end;

    end
   else
     begin
      for i:=0 to (ArFrmGl.Count-1)    do
       begin
         dy:=dy+step;
         Frm:=ArFrmGl.items[i];
         SetWindowPos(Frm.handle,HWND_TOP,i*step,dy,100,100, SWP_NOSIZE);
       end;
      for i:=0 to (ArFrmSect.Count-1)    do
       begin
         Frm:=TSection(ArFrmSect.Items[i]);
         dy:=dy+step;
         SetWindowPos(Frm.handle,HWND_TOP,i*step,dy,100,100, SWP_NOSIZE);
       end;
      for i:=0 to (ArFrmSpectr.Count-1)    do
       begin
         Frm:=(ArFrmSpectr.Items[i]);
         dy:=dy+step;
         SetWindowPos(Frm.handle,HWND_TOP,i*step,dy,100,100, SWP_NOSIZE);
       end;
    end;

end;

procedure TMain.ActionChooseSampleExecute(Sender: TObject);
begin
   if (not FlgApproachOK) and flgStopScan then
       begin
         ChooseSample:= TChooseSample.Create(Application);
         ChooseSample.ShowModal;
         landing.Visible:=false;
         Scanning.Visible:=false;
         flgResonance:=false;
       end
    else
      if not flgStopScan then ShowMessage(siLang1.GetTextOrDefault('IDS_321'))
       else if FlgApproachOK then ShowMessage(siLang1.GetTextOrDefault('IDS_322'));
end;

procedure TMain.ActionCloseAllExecute(Sender: TObject);
 var i,Count:integer;
        Frm:TForm;
begin
// if assigned(ImageTools) then  ImageTools.close;
// Application.processmessages;
 if  ArFrmSect.Count<>0    then
 begin
   Count:= ArFrmSect.Count ;
  for i:=Count-1 downto 0 do
     begin
      Frm:=ArFrmSect.Items[i];
      ArFrmSect.Delete(i);
      Frm.Close;
      Application.processmessages;
     end;
 end;
 if  ArFrmGl.Count<>0 then
 begin
   Count:= ArFrmGl.Count ;
  for i:=Count-1 downto 0 do
     begin
      Frm:=ArFrmGl.items[i];
      Frm.Close;
      Application.processmessages;
     end;
 end;
 if  ArFrmSpectr.Count<>0 then
 begin
   Count:= ArFrmSpectr.Count ;
  for i:=Count-1 downto 0 do
     begin
      Frm:=ArFrmSpectr.items[i];
      Frm.Close;
      Application.processmessages;
     end;
 end;
 ArScanFrm.Clear;
 CountClose:=0;
end;

procedure TMain.ActionUnregisterExecute(Sender: TObject);
var res:integer;
begin
(*res:= MessageDlgCtr(strm8{'Be attention! This operation can make only  Serviceman !!'}, mtInformation,mbOKCancel,0);
if res=mrOk then
begin
  //  libHandle:=0;
    if not ControllerDetect.NanoeduDriversDetect   then
    // if (not  fileexists(dirsys32+'\urpci.dll')) or (not  fileexists(dirsys32drivers+'\cspm.sys') )    then
        begin
          if not flgadmin
           then messagedlg(siLang1.GetTextOrDefault('strstrm35' (* 'Controller drivers are not installed. Ask the administrator to install drivers!' *} ),mtwarning,[mbOK],0)
           else messagedlg(siLang1.GetTextOrDefault('IDS_94' {* 'Controller drivers are not installed. Install drivers!' *} ),mtwarning,[mbOK],0);
            ComboBoxLevel.Enabled:=true;
            ActionNew.Visible:=true;
            exit;
        end;
 //    libHandle:=LoadCSPMlib(CSPMLib);
         if libHandle<=32   then
          begin
            FormControllerTurnOn:=TFormControllerTurnOn.Create(Self);
            res:=FormControllerTurnOn.ShowModal;
                     if res=mrCancel then
                          begin
                           exit;
                          end;
           end;
            Application.ProcessMessages;
            sleep(1000);
       Inform:=TInform.Create(Application);
       Inform.labelinf.caption:=strm9{'Please wait, while  process will not be finished!'};
       Inform.Show;
       Application.ProcessMessages;
 if  (FlgCurrentUserLevel<>Demo) and (FlgCurrentUserLevel<>Beginner) then
           ExecAndWait(Pchar(ExeFilePath)+'Scripts\scriptwriter.exe','',SW_showNORMAL)
           else MessageDlgCtr(strm1{'Demo version.!!'}, mtInformation,[mbOk],0);
       Inform.close;

end;  *)
  UnRegisterOCX('SiGraph.dll');
  UnRegisterOCX('NL3Cntx.dll');
  UnRegisterOCX('MLPC_API2.dll');
  UnRegisterOCX('MLPC_API.dll');
  UnRegisterOCX('NL3LFB.dll');
  UnRegisterOCX('NL3FB.dll');
end;

procedure TMain.ActionRegisterExecute(Sender: TObject);
var lmname:string;
cmd,cmd1:string;//Pchar;
cmd0:string;//Pchar;
res:integer;
begin
if WINDOWS_VERSION<>'Windows XP' then
 MessageDlgCtr(strm45{'Information run as admin!!'}, mtInformation,[mbOk],0);
 lmname:=GetUserAccountName;
 cmd0:=PChar('/user:'+lmname+' ' +ExeFilePath+'DriverSetUp\dsetup.exe');
 cmd:='runas.exe';// /user:'+lmname+'\administrator ';//+ ExeFilePath+'DriverSetUp\dsetup.exe';
 cmd:='runas.exe ';// /user:'+lmname+' ';//+ ExeFilePath+'DriverSetUp\dsetup.exe';
 cmd1:=ExeFilePath+'DriverSetUp';

 RegisterOCX('NL3FB.dll');
 RegisterOCX('NL3LFB.dll');
 RegisterOCX('MLPC_API.dll');
 RegisterOCX('MLPC_API2.dll');
 RegisterOCX('NL3Cntx.dll');
 RegisterOCX('SiGraph.dll');
end;

procedure TMain.ActionFAQExecute(Sender: TObject);
 var res:Thandle;
  filename:string;
begin
 if sLanguage='RUS' then filename:=CommonNanoeduDocumentsPath+'FAQ\rus\faq_r.pdf'
                    else filename:=CommonNanoeduDocumentsPath+'FAQ\eng\faq_e.pdf';
 if fileExists(Filename) then
    res:= ShellExecute(handle,nil,Pchar(fileName),nil,nil,SW_RESTORE);
end;

procedure TMain.ActionGalleryExecute(Sender: TObject);
begin
  if not directoryexists(ScanGalleryDir) then
  begin MessageDlgCtr(strm34{'Gallery directory do not exists!!'},mtwarning,[mbOk],0);   exit; end;
 ActionOpen.Enabled:=False;
 ActionOpen.visible:=False; { TODO : 250908 }
 LoadDefPaletName(DefPaletName);    // Reads ConfigIni File
 LoadPalette(DefPaletName);         // Reads PaletteIni File;
 EvalPaletteLines();
 if assigned(DirView)  then  DirView.Close;
 if assigned(WorkView) then  WorkView.DeActivate;

 Application.processmessages;

 DirView:=TfrSPMViewFull.Create(Self,ScanGalleryDir,2);
end;

procedure TMain.ActionHelpExecute(Sender: TObject);
 var   HlpContext:integer;
begin
       case stmflg  of
   true:     HlpContext:=IDH_Start_STM;
   false:    HlpContext:=IDH_Start_SFM;
          end;
        Application.HelpContext(HlpContext);//
end;

procedure TMain.ActionHorizontalExecute(Sender: TObject);
    var wWidth,i,j,k:integer;
    Frm:TFrmGl;
begin
  wWidth:=ClientHeight div 2; ;
 if wWidth > ClientWidth then  wWidth:=ClientWidth;
       wWidth:=wWidth-15;
       i:=0;   k:=0; j:=0;
 while  j<=(ArFrmGl.Count-1)   do
   begin
    Frm:=ArFrmGl.items[j];
    SetWindowPos(Frm.handle,HWND_TOP,i*wWidth,k*wWidth+TopStart,wWidth,wWidth,SWP_SHOWWINDOW);
  if i=2 then  begin inc(k); i:=0; end  else inc(i);
     inc(j);
   end;
end;

procedure TMain.ActionImageToolsExecute(Sender: TObject);
begin
      flgViewTools:=True;
     ActionImageTools.visible:=false;
  //    ToolBtnTools.enabled:=false;
     if not assigned(ImageTools) then
      begin
       ImageTools:=TImageTools.Create(application);
       if assigned(ActiveGLW) then
       begin
        //  ActiveGLW.ToolsPanel.checked:=not ActiveGLW.ToolsPanel.checked;
         with ActiveGLW do
         begin
           ImageTools.SpeedBtnPal.visible{Enabled}:=false;
           ImageTools.SpeedBtnL.visible{Enabled}:=true;
           ImageTools.SpeedBtnM.visible{Enabled}:=true;
          if (FlgView=D3Geo) or (FlgView=D2Geo) then
          begin
           ImageTools.SpeedBtnPal.visible{Enabled}:=true;
           ImageTools.SpeedBtnL.visible{Enabled}:=false;
           ImageTools.SpeedBtnM.visible{Enabled}:=false;
          end;
         end;
       end;
       H:=FindWindow(nil,'Image Analysis');
       if h=0 then
       begin
        ImageTools.SpeedBtnData.enabled:=true;
        if assigned(ActiveGLW) then
        begin
         ActiveGLW.ImageAnalysis1.enabled:=true;
         ActiveGLW.ImageAnalysis2.enabled:=true;
        end;
       end;
      end;
// if assigned(Workview)     then NotifyAllToPrilipat;
 if assigned(ImageTools)   then NotifyAllToPrilipat;
 APPLICATION.ProcessMessages
 end;

procedure TMain.ActionLeaveActiveExecute(Sender: TObject);
var i,Count:integer;
    Frm:TFrmGl;
    FrmS:TSection;
begin
 if ArFrmSect.Count<>0 then
 begin
    Count:= ArFrmSect.Count ;
    for i:=Count-1 downto 0 do
     begin
      FrmS:=ArFrmSect.Items[i];
      ArFrmSect.Delete(i);
      FrmS.Close;
      Application.processmessages;
     end;
 end;
 if ArFrmGL.Count<>0 then
 begin
    Count:= ArFrmGl.Count ;
  for i:=Count-1 downto 0 do
     begin
      Frm:=ArFrmGl.items[i];
      if Frm<>ActiveMDIChild then
      begin
        Frm.Close;
        Application.processmessages;
      end;
     end;
 end;
 if ArFrmSpectr.count<>0 then
 begin
     Count:= ArFrmSpectr.Count ;
  for i:=Count-1 downto 0 do
   begin
      Frm:=ArFrmSpectr.items[i];
    if Frm<>ActiveMDIChild then
    begin
     Frm.Close;
     Application.processmessages;
    end;
   end;
 end;
end;

procedure TMain.ActionListAdServiceExecute(Action: TBasicAction; var Handled: Boolean);
begin
   AdapterService:=TAdapterService.Create(self);
   AdapterService.ShowModal;
end;

procedure TMain.ActionVerticalExecute(Sender: TObject);
  var wWidth,i,k,j:Integer;
      Frm:TFrmGl;
begin
  wWidth:=ClientHeight div 3;
  if wWidth > ClientWidth then  wWidth:=ClientWidth;
   wWidth:=wWidth-15;
   i:=0;   k:=0; j:=0;
 while  j<= (ArFrmGl.Count-1)
  do
   begin
    Frm:=ArFrmGl.items[j];
    SetWindowPos(Frm.handle,HWND_TOP,i*wWidth,k*wWidth+TopStart,wWidth,wWidth,SWP_SHOWWINDOW);
     if k=2 then
             begin k:=0; inc(i); end
             else inc(k);
     inc(j);
   end;
   InvalidateRect(0, nil, False);
end;

procedure TMain.ActionViewConfigExecute(Sender: TObject);
   var windowsdir:Pchar;
begin
    ViewConfigFile:=TViewConfigFile.Create(Application,ConfigIniFilePath+ConfigIniFile);
    ViewConfigFile.ShowModal;
end;

procedure TMain.ActionViewWorkdirExecute(Sender: TObject);
begin
  if not assigned( WorkView) then
  begin
      CreateWorkViewWnd(true);
      if Addworkdirectory='' then
      begin
          Addworkdirectory:=baseworkdircaption+workdirectory;
          Caption:=basecaption+addcaption+addworkdirectory;
      end;
  end ;
end;

procedure Tmain.ActivateMenuItem(Sender:Tobject);
 var  i:integer;
      str:string;
 begin
     with Sender as TMenuItem do
      begin
         str:=StripHotKey(TMenuItem(Sender).Caption);
        for i:=0 to MDICHildCount-1 do
         begin
          if MDIChildren[i].Caption=str
            then
             begin
                SetWindowPos(MDIChildren[i].handle,HWND_TOP,0,0,0,0, SWP_NOSIZE or SWP_NOMOVE);
                ActiveMDIChild.windowState:=wsNormal;
                exit;
             end;
        end;
      end;
 end;

procedure TMain.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
//
end;

procedure TMain.AskonlineClick(Sender: TObject);
var
  ie: IWebBrowser2;
  Url, Flags, TargetFrameName, PostData, Headers: OleVariant;
begin
  // Uses ComObj + SHDocVw_TLB
  ie := CreateOleObject('InternetExplorer.Application') as IWebBrowser2;
   case lang of
 2: URL:='http://www.ntspb.ru';
 1: URL:='http://www.ntspb.ru';
  end;
  ie.Navigate2(Url,Flags,TargetFrameName,PostData,Headers);
  ie.Visible := true;
(* case lang of
 2: ShellExecute(self.WindowHandle, 'open', PChar('http://www.ntmdt.ru/online'), nil, nil,SW_SHOWNORMAL);
 1: ShellExecute(self.WindowHandle, 'open', PChar('http://www.ntmdt.com/online'), nil, nil,SW_SHOWNORMAL);
  end;
  *)
 end;

procedure TMain.HintHandler(Sender: TObject);
begin
{      with StatusBarMain do
   begin
StatusR.right:=StatusBarMain.left;
StatusR.left:=StatusBarMain.width+StatusBarMain.left;;
StatusR.Bottom:=StatusBarMain.height+StatusBarMain.top;
StatusR.top:=StatusBarMain.top;
end;
    StatusBarMainDrawPanel(StatusBarMain,StatusBarMain.Panels[0],StatusR);
  // 	StatusBarMain.SimpleText := Application.Hint;
}
end;

procedure TMain.FormCreate(Sender: TObject);
var iniCSPM:TiniFile;
    sFile:string;
    videofilename:string;
    deflang,verwindow:string;
       oSVER:STRING;
   MajVer,MinVer:BYTE;
   BuildNo:WORD;
   NF:TDEV_BROADCAST_DEVICEINTERFACE;
//   flgTwoMonitors:boolean;
begin
  UpdateStrings;
  flgCanClose:=true;

 inherited;

 Events:=TEvent.Create(nil,true,false,'wait');

  tSaveExecutionState:= SetThreadExecutionState(ES_CONTINUOUS or ES_SYSTEM_REQUIRED or ES_DISPLAY_REQUIRED); //set not sleep system
  TimeLimitDetectDev:=0;
  widthrightpanel:=65;
  widthmonitor:=88;
  WINDOWS_VERSION:=OSInfo();
  flgAdmin:=true;
  verwindow:=OSInfo;
 if not (WINDOWS_VERSION='Windows 98') then
  if not  IsAdmin  then
   begin
    flgAdmin:=false;
    mdriverssetup.Visible:=false;
    mcopyscripts.Visible:=false;
   end;
     InitDirectories;
     sLanguage:= GetLanguage;
     deflang:=WhichLanguage;

   if  ( AnsiContainsStr(deflang,'Russian'))  or ( AnsiContainsStr(deflang,'Русский')) then   sLanguage:='RUS'
   else   sLanguage:='ENG';
// sLanguage:='ENG'; //for Torzo
     InitTutor;
   if sLanguage='RUS' then
                    begin
                        ReportTemplPath:=CommonNanoeduDocumentsPath+ReportTemplRDefPath;
                        Application.HelpFile :=ExeFilePath+'NanoEduHelp.chm';
                        tutsimulator:=tutsimulatorrus;
                        tutexperiment:=tutexperimentrus;
                        tutvideo:=tutvideorus;
                        tutanima:=tutanimarus;
                        Lang:=2;
                        siLang1.ActiveLanguage:=2;
                        sFile:=CommonNanoeduDocumentsPath+'video' +'\rus\'+tutanima;//'\3D_Модель_NanoEducator_LE.mp4'
                        SmesharikiPinCode.Visible:=Fileexists(sfile);
                    end
                    else
                    begin
                        tutsimulator:=tutsimulatoreng;
                        tutexperiment:=tutexperimenteng;
                        tutvideo:=tutvideoeng;
                        tutanima:=tutanimaeng;
                        Lang:=1;
                        siLang1.ActiveLanguage:=1;
                        ReportTemplPath:=CommonNanoeduDocumentsPath+ReportTemplEDefPath;
                        Application.HelpFile :=ExeFilePath+'NanoEduHelpEng.chm';
                        SmesharikiPinCode.Visible:=false;
                    end;
   UpdateStrings;
 if not assigned(NoFormUnitLoc) then  NoFormUnitLoc:= TNoFormUnitLoc.Create(self);
 if not assigned(Formlog)       then  FormLog:=TFormlog.Create(self);
     {$IFDEF DEBUG}
             Formlog.memolog.Lines.add(deflang);
             Formlog.memolog.Lines.add(sLanguage);
      {$ENDIF}
    DigNanoeduDevName:=ProgramName;
    basecaption:=ProgramName;//strm11{'Nanoeducator;'};
    baseworkdircaption:=strm12{' Work Directory - '};
    addcaption:='';
    caption:=basecaption;
    flgOnlineService:=GetflgOnlineService;
    AskOnline.Visible:=boolean(flgOnLineService);
    flgChangeUserLevel:=GetflgChangeUserLevel;
     case flgChangeUserLevel of
      1: ComboboxLevel.Enabled:=true;
      0: ComboboxLevel.Enabled:= false;
    end;
    CurrentUserLevel:=GetUserLevel;
   {$IFDEF DEMO}
        CurrentUserLevel:='Demo';
        ComboBoxLevel.Enabled:=false;
   {$ENDIF}
   if CurrentUserLevel='Beginner' then
   begin
        PanelUnit.Visible:=false;
        WorkNameFileMaskCur:= WorkNameFileMaskDef;
        ComboBoxLevel.ItemIndex:=Beginner;
        ComboBoxLevel.Hint:=siLang1.GetTextOrDefault('IDS_84' (* 'The Beginning User' *) );
   end;
   if CurrentUserLevel='Advanced' then
     begin
        Actionnew.Enabled:=false;
        ActionChooseSample.Visible:=false;
        WorkNameFileMaskCur:= WorkNameFileMaskDef;
        ComboBoxLevel.ItemIndex:=Advanced;//1;
        ComboBoxLevel.Hint:=siLang1.GetTextOrDefault('IDS_88' (* 'The Advanced User' *) );
      end;
   if CurrentUserLevel='Demo' then
    begin
         Actionnew.Enabled:=true;
         ActionChooseSample.Visible:=true;
         WorkNameFileMaskCur:= WorkNameFileMaskDemo;
         ComboBoxLevel.ItemIndex:=Demo;
         ComboBoxLevel.Hint:=siLang1.GetTextOrDefault('IDS_92' (* 'The Demo Version' *) );
    end;

   FlgCurrentUserLevel:=ComboBoxLevel.ItemIndex;

   WorkDefDirectory:=UserNanoeduWorkDocumentsPath;

   if DirectoryExists(WorkDefDirectory) then  CreateDir(WorkDefDirectory);

   WorkDirectory:=UserNanoeduWorkDocumentsPath;

   sFile:=GetConfigUsersFileName;

   GetWorkDirAndFirstTimeDetectPath(sFile);

    flgUnit:=GetDeviceName;

  if sLanguage='RUS' then
  begin
   videofileName:=CommonNanoeduDocumentsPath+'video\rus\'+tutvideorus;//'\3D_Модель_NanoEducator_LE.mp4'
  end
  else
  begin
   videofileName:=CommonNanoeduDocumentsPath+'video\eng\'+tutvideoeng;//'\3D_Model_NanoEducator_LE.mp4'
  end;
   if Fileexists(videofilename) then VideoMenu.visible:=true
                                else VideoMenu.visible:=false;
 //  VideoMenu.visible:=true;//for Muhin

    ScanParams.flgFastSimulator:=GetFlgFastSimulation;
      case   flgUnit of
   nano,
   nanotutor: if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then  UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
   Terra:if fileexists(ExeFilePath+'Data\'+'terrahrz.jpg')         then  UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'terrahrz.jpg');
   baby: if fileexists(ExeFilePath+'Data\'+'babyunit.jpg')         then  UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'babyunit.jpg');
  grand: if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg')      then  UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
  ProBeam: if fileexists(ExeFilePath+'Data\'+'sem.jpg')            then
            begin
              SynchroSEM.visible:=true;
               UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'sem.jpg');
            end;
  MicProbe: if fileexists(ExeFilePath+'Data\'+'micporbe.jpg')      then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'micprobe.jpg');

  Pipette:  if fileexists(ExeFilePath+'Data\'+'pipette.jpg')       then  UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'pipette.jpg');
                  end;
      SaveAsDirectory:=workdirectory;
      Main.ArrangeWindows1.Enabled:=False;
      FileItem.Hint := siLang1.GetTextOrDefault('IDS_108' (* 'File Menu' *) );
      OpenItem.Hint := siLang1.GetTextOrDefault('IDS_109' (* 'Open Saved Experiment' *) );
      NewItem.Hint :=  siLang1.GetTextOrDefault('IDS_110' (* 'New Experiment' *) );
      Application.OnHint := HintHandler;
      flgControlerTurnON:=false;
      FlgTrans:=False;
      flgViewTools:=True;
      flgStopScan:=True;
      flgStopApproach:=True;
      flgStopResonance:=True;
      ActiveGlW:=nil;
      ArFrmGl:=TList.Create;
      ArFrmGl.Clear;
      ArFrmGL.Capacity:=20;
      ArScanFrm:=TList.Create;
      ArScanFrm.Clear;
      ArScanFrm.Capacity:=20;
      ArFrmSpectr:=TList.Create;
      ArFrmSpectr.Clear;
      ArFrmSpectr.Capacity:=20;
      ArFrmSect:=TList.Create;
      ArFrmSect.Clear;
      ArFrmSect.Capacity:=20;
  (*    width:=Screen.workareawidth;
      height:=Screen.workareaheight;
      left:=Screen.workarealeft;//-WorkView.width;
      top:=Screen.workareatop;
    *)
      ActionPrint.enabled:=true;
      FileInfItem.Enabled:=False;
      PrintItem.Enabled:=False;
      MainStatusBarFill;
      Screen.Cursors[crAimCursor] := LoadCursor(HInstance, 'CursorAim');
      Screen.Cursors[crPen]       := LoadCursor(HInstance, 'Pen');
      Screen.Cursors[crRectDraw]  := LoadCursor(HInstance, 'RectDraw');

 { Set up a hint message and the animation interval. }

 TrayIcon1.Hint := 'Hello World!';
 TrayIcon1.AnimateInterval := 200;

 { Set up a hint balloon. }
 TrayIcon1.BalloonTitle := 'Restoring the window.';
 TrayIcon1.BalloonHint :=
   'Double click the system tray icon to restore the window.';
 TrayIcon1.BalloonFlags := bfInfo;


   //   libHandle:=0;
/// send spm files to Image Analysis
  FMDTServiceForm := TMDTServiceForm.Create(Self);
//  FMDTServiceForm.OnLoadFile := OnLoadFile;
  FMDTServiceForm.OnSaveFile := SaveSelectedData;
//  FMDTServiceForm.OnShowWarning := OnShowWarning;
  FMDTServiceForm.SubMenuItem := SendScanTo;//SendScanTo;
  FMDTServiceForm.StorePath:=workdirectory+'\';

//  Actionnew.Enabled:=FindControler;
  NF.dbcc_size:=sizeof(TDEV_BROADCAST_DEVICEINTERFACE);
  NF.dbcc_devicetype:=DBT_DEVTYP_DEVICEINTERFACE;
  HDEVNOT:=RegisterDeviceNotification(Handle,@NF,DEVICE_NOTIFY_ALL_INTERFACE_CLASSES);
  flgTwoMonitors:=Screen.MonitorCount>1;
//flgTwoMonitors:=true;
  if flgTwoMonitors then
  begin
   ReadFormSizeandPosition(FormParam);
    FormParam.left:= Screen.Monitors[1].width;
   if  (FormParam.top<>0) or (FormParam.left<>0)   then
    begin
     top:=FormParam.top;
     left:=FormParam.left;
    end;
   if (left>(2*(Screen.Monitors[0].width div 3))) then
   begin
      width:=Screen.Monitors[1].width;
      height:=Screen.Monitors[1].height;
      left:=Screen.Monitors[1].left;//-WorkView.width;
      top:=Screen.Monitors[1].top;
   end
   else
   begin
      width:=Screen.Monitors[0].width;
      height:=Screen.Monitors[0].height;
      left:=Screen.Monitors[0].left;//-WorkView.width;
      top:=Screen.Monitors[0].top;
   end;
  end
  else
  begin
      width:=Screen.workareawidth;
      height:=Screen.workareaheight;
      left:=Screen.workarealeft;//-WorkView.width;
      top:=Screen.workareatop;
  end;end;

procedure   TMain.GetWorkDirAndFirstTimeDetectPath(Filename:STRING);
var iniCSPM:Tinifile;
begin
  UpdateStrings;
   iniCSPM:=TIniFile.Create((Filename));
try
   with iniCSPM do
    begin
     WorkDirectory:=ReadString('Files','Work Directory',UserNanoeduWorkDocumentsPath);
     WorkLastDirectory:=WorkDirectory;
     WorkDirectory:=WorkDefDirectory;
     OpenDirectory:=ReadString('Files','View Directory',UserNanoeduWorkDocumentsPath);
 //    if not flgAdmin then
      begin
       flgfirsttimesfm:=readbool('Install parameters','first time sfm',true);
       flgfirsttimestm:=readbool('Install parameters','first time stm',true);
       if flgfirsttimesfm and flgfirsttimestm then
        begin
            WorkDirectory:=UserNanoeduWorkDocumentsPath;
            OpenDirectory:=UserNanoeduWorkDocumentsPath;
        end;
//       firsttime:=0;
      end;
     if not DirectoryExists(workdirectory) then  WorkDirectory:=UserNanoeduWorkDocumentsPath;//ExeFilePath+'work';
      SetCurrentDir(WorkDirectory);
     if not DirectoryExists(OpenDirectory) then  OpenDirectory:=UserNanoeduWorkDocumentsPath;//ExeFilePath+'work';
      LithoTemplDirectory:=ReadString('Files','Litho Template Directory', ScanGalleryDir+'\lithography');
     if not DirectoryExists(LithoTemplDirectory) then  LithoTemplDirectory:=ScanGalleryDir+'\lithography';
  end;
 finally
     iniCSPM.Free;
 end;
end;

procedure TMain.FormDblClick(Sender: TObject);
begin
 // miFullScreenClick;
end;

procedure TMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) then
   begin
     if (Key=ord('V')) then
      begin
   if ToolScanBar.visible then   ActionGetAdapterID.visible:= not  ActionGetAdapterID.visible;
      end;
    end;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
       ires:integer;
        res:word;
         FF:File;
    iniCSPM:TiniFile;
      sFile:string;
         ww:string;
         sSr:TsearchRec;
begin
  FreeAndNil(Events);
 if assigned(DataWriteToAdapterList) then
 begin
  DataWriteToAdapterList.Clear;
  FreeAndNil( DataWriteToAdapterList);
 end;
if assigned(NoFormUnitLoc) then NoFormUnitLoc.close;
if assigned(ImgAnalysWnd)  then ImgAnalysWnd.close;
 SetUserLevel;
 SetflgChangeUserLevel;
 SetDeviceName(flgUnit);
 SetOnlineService;
 sFile:=ConfigUsersIniFilePath + ConfigUsersIniFile;
 if (not FileExists(sFile)) then
  begin
    AssignFile(FF,sFile);
    Rewrite(FF);
    CloseFile(FF);
  end;
  formParam.left:=left;
  formParam.top:=top;
  if flgTwoMonitors then SaveFormSizeandPosition(formparam);
  //   SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
try
  iniCSPM.WriteString('Files','View Directory',OpenDirectory);
  iniCSPM.WriteString('Files','Litho Template Directory',LithoTemplDirectory);
   ww:='false' ;
  if flgShowWellcomeWindow then ww:='true';
  iniCSPM.WriteString('Users','Show welcome window',ww);
finally
  iniCspm.Free;
end;
//  SetFileAttribute_ReadOnly(sfile,true);
 chDir(WorkDirectory);
 if assigned(workview)      then Workview.close;
 SetLanguage;
 FreeAndNil(ArFrmSpectr);
 FreeAndNil(ArFrmGl);
// if ArScanFrm.count>1 then ArScanFrm.clear;
 FreeAndNil(ArScanFrm);
 FreeAndNil(ArFrmSect);
 PtFrag:=nil;
 PtSect:=nil;
 MainTimerUp.Interval:=0;
 MainTimerUp.Free;
 CloseOsciloscope;
 if assigned(FMDTServiceForm) then FreeAndNil(FMDTServiceForm);
 if assigned(NoFormUnitLoc) then FreeAndNil(NoFormUnitLoc);
if tSaveExecutionState <>0 then  SetThreadExecutionState(tSaveExecutionState);
UnregisterDeviceNotification(HDEVNOT);
Action:=caFree;
end;

procedure TMain.CreateMDIChildSection(Sender: TObject;Section:TDataLine;n:integer;const Title:string;const FileHeadRcd:HeadParmType);
 var ChildGraphica:TSection;
begin
   ChildGraphica := TSection.Create(self,Section,n,Title,FileHeadRcd);
   ArFrmSect.Add(ChildGraphica);
   flgCascadGL:=False;
   ActionCascadeExecute(Sender);
   MainStatusBarFill;
end;

procedure TMain.CreateMDIChild(Sender: TObject;const FileName: string;FlgView:integer;flgScan:boolean; flgRenishawCorrect:boolean );
var
    flgGlReadBlock:integer;
    FrmGl:  TfrmGL;
    FrmGLt:  TfrmGL;
    frmSpectr:TForm;
    LSpectrWnd:TSpectroscopy;
    LSpectrWndTerra:TSpectroscopyTerra;
    LSpectrWndSTM:TSpectroscopyV;
begin
//flgScan=true      create and add to work array
  { create a new MDI child window }
   FlgCascadGL:=True;
   FileInfItem.Enabled:=true;
   ArrangeWindows1.Enabled:=true;
   Application.ProcessMessages;
     {$IFDEF DEBUG}
      if assigned(Formlog) then   Formlog.memolog.Lines.add('Open '+FileName);
     {$ENDIF}

   if ReadHeader(FileName,flgGlReadBlock,head,mainrc)>0 then exit;

   if ArFrmGl.count=0 then flgViewTools:=True;

   if Head.HAquiSpectr then flgGlReadBlock:=spectr;

     if (flgGlReadBlock in  ScanmethodSetNoAdd) then
       begin
         if (flgGlReadBlock in  ScanmethodSetTopo) then
           begin
             FrmGl:=TfrmGL.Create(Application,FileName,TopoGraphy,FlgView,flgRenishawCorrect,flgError);
             if flgError=0 then
             begin
              ArFrmGl.Add(frmGL);
              if flgScan  then ArScanFrm.Add(frmGl) ;
              ActionCascadeExecute(Sender);
             end
             else exit;
           end
           else
           if (flgGlReadBlock in  ScanmethodSetOneL) then
            begin
             FrmGl:=TfrmGL.Create(Application,FileName,OneLineScan,FlgView,flgRenishawCorrect,flgError);
             if flgError=0 then
             begin
              ArFrmGl.Add(FrmGL);
              if flgScan  then ArScanFrm.Add(frmGl);
              ActionCascadeExecute(Sender);
             end
             else exit;
            end;
       end
       else
       if (flgGlReadBlock in  ScanmethodSetAdd) then
        begin
             if  Head.HAquiTopo then
              begin
               FrmGl:=TfrmGL.Create(Application,FileName,TopoGraphy,FlgView,flgRenishawCorrect,flgError);
               if flgError=0 then
               begin
                 ArFrmGl.Add(FrmGL);
                 if flgScan  then ArScanFrm.Add(frmGl);
               end
               else exit;
              end;
               FrmGl:=TfrmGL.Create(Application,FileName,flgGlReadBlock,FlgView,flgRenishawCorrect,flgError);
               if flgError=0 then
               begin
                ArFrmGl.Add(FrmGL);
                if flgScan  then ArScanFrm.Add(frmGl);
                ActionCascadeExecute(Sender);
               end
               else exit;
        end// add
        else
        if (flgGlReadBlock in  ScanmethodSetSpectr) then
           begin      //Topo + Spectr
                  case Head.HProbeType  of
            1:begin
               case Head.HTypeSpectr of
               0:begin
                  LSpectrWndSTM:=TSpectroscopyV.Create(Application,FileName);
//                  LSpectrWndSTM.Show;
                  ArFrmSpectr.Add(LSpectrWndSTM);
                 end;
               1:begin
                   LSpectrWnd:=TSpectroscopy.Create(Application,FileName);
                   ArFrmSpectr.Add(LSpectrWnd);
                 end;
               end;
               if flgScan  then ArScanFrm.Add(frmGl);
              end;
            0:begin
                 case flgUnit of
          terra: begin
                   SpectrWndTerra:=TSpectroscopyTerra.Create(Application,FileName);
                   ArFrmSpectr.Add(LSpectrWndTerra);
                 end;//; LSpectrWnd.Show;
          else   begin
                   LSpectrWnd:=TSpectroscopy.Create(Application,FileName);
                   ArFrmSpectr.Add(LSpectrWnd);
                 end
                        end;
                 if flgScan  then ArScanFrm.Add(frmGl);
              end;
                   end;
               ActionCascadeExecute(Sender);
               exit;
           end;

  APPLICATION.ProcessMessages ;

 with ActiveGLW do
 begin
  if flgViewTools  then
   if not flgScan or (not assigned(WorkView))  then
   begin
    if not assigned(ImageTools) then
    begin
      ImageTools:=TImageTools.Create(application);
      Application.processmessages;
    end;
    if assigned(ImageTools) then
    begin
     if (flgView=D3Geo) or (flgView=D2Geo) then
     begin
      ImageTools.SpeedBtnPal.visible:=true;
      ImageTools.SpeedBtnL.visible:=false;
      ImageTools.SpeedBtnM.visible:=false;
     end
     else
     begin
      ImageTools.SpeedBtnPal.visible:=false;
      ImageTools.SpeedBtnL.visible:=true;
      ImageTools.SpeedBtnM.visible:=true;
     end;
     ImageTools.SpeedBtnFrag.Down:=False;
     ImageTools.SpeedBtnSect.Down:=False;
     ImageAnalysis1.enabled:=ImageTools.SpeedBtnData.Enabled;
     ImageAnalysis2.enabled:=ImageTools.SpeedBtnData.Enabled;
    end;
   end;
//
 //  ToolsPanel.checked:=flgViewTools;
///
   if flgViewTools then   ActionImageTools.Visible:=false;
 end; //with

 if assigned(ImageTools)   then NotifyAllToPrilipat;
 APPLICATION.ProcessMessages ;
end;

(*
procedure TMain.TimerHungUpTimer(Sender: TObject);
begin
 TimerHungUp.enabled:=false;
 MessageDlg(siLang1.GetTextOrDefault('IDS_203' {* 'Controler do n''t answer. Please , turn off/on controller and restart program!' *} ),mtWarning ,[mbOK],0)
end;
 *)

procedure TMain.CameraExecute(Sender: TObject);
 var h:Hwnd;
 res:cardinal;
    Result:boolean;
    libload:Dword;
    R:TRect;
    StartInfo: TStartupInfo;
     ProcInfo: TProcessInformation;
      CmdLine: ShortString;
begin
 Camera.Enabled:=False;  { TODO : 130906 }
 if   flgVideoOscConflict then
 begin
  if   EXE_Running('Oscilloscope.exe', false) then
  begin
   h:=findwindow(nil,Pchar('oscilloscope'));
   if h<>0  then
   begin
    h:=0;
    h:=FindWindow(nil,'Oscilloscope');
    if  h>0 then
      begin
       silang1.MessageDlg(strm16{'Close Oscilloscope program!! '},mtWarning ,[mbOK],0);
       Camera.Enabled:=True;
       exit;
      end;
   end;
  end
 end;
 if not boolean(flgRunFirmCamera) then
  begin
    h:=findwindow(nil,Pchar(strm41{'MSVideo'}));
   if h=0  then
    begin
     if(FlgCurrentUserLevel<>DEMO) then
     begin
      if GetModuleHandle('MSVideoLib.dll')=0 then
      begin
        @StartVideo:=nil; @StopVideo:=nil;
        LibVideoHandle:=0;
        LibVideoHandle:=LoadLibrary(PChar(ExeFilePath+'MSVideoLib.dll'));
        if  LibVideoHandle<=32 then
                                  begin
                                   silang1.MessageDlg(siLang1.GetTextOrDefault('IDS_211' (* 'Library MSVideoLib.dll Load Error' *) )+ IntToStr(GetLastError)+'!',mtWarning,[mbOk],0);
                                   exit;
                                  end
                               else
                                  begin
                                    StartVideo:=GetProcAddress(LibVideoHandle,'StartVideo');
                                    StopVideo:=GetProcAddress(LibVideoHandle,'StopVideo');
                                  end;
      end;
      if   StartVideo(Application.Handle,self.Handle,WM_UserCloseVideo,Lang,ConfigUsersIniFilePath) then
      begin
        h:=findwindow(nil,Pchar(strm41{'MSVideo'}));
        if h<>0  then
        begin
         GetWindowRect(h,R);
         SetWindowPos(h,HWND_TOPMost,Main.Left+5,Main.Top+Main.ClientHeight-(R.Bottom-R.Top),50,50,SWP_NOSIZE or SWP_SHOWWINDOW);
        end;
      end;
     end //not demo
     else
     begin //demo
       MSVideoForm:=TMSVideoForm.Create(self,PathToApproachVideo,false,false);
       MSVideoFORM.show;
         h:=findwindow(nil,Pchar(strm41{'MSVideo'}));
        if h<>0  then
        begin
         GetWindowRect(h,R);
         SetWindowPos(h,HWND_TOPMost,Main.Left+5,Main.Top+Main.ClientHeight-(R.Bottom-R.Top),50,50,SWP_NOSIZE or SWP_SHOWWINDOW);
        end;
     end;
   end   //h=0
  end //not firm
  else
  begin
   RunFirmSoftVideoCamera;
  end;
   camera.Enabled:=True;
end;

procedure TMain.ExitClick(Sender: TObject);
begin
   Close;
end;

procedure TMain.FlashClick(Sender: TObject);
var res:Thandle;
 begin
   flash.enabled:=false;
   OpenDialog.Filter:='flash files (*.swf);|*.swf';
   OpenDialog.InitialDir:=CommonNanoeduDocumentsPath+'animation';
   OpenDialog.FileName:='';
 if OpenDialog.execute then
 begin { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
  if false {(WINDOWS_VERSION<>'Windows XP') and (WINDOWS_VERSION<>'Windows Vista')} then
  begin
   res:= ShellExecute(handle,nil,Pchar(OPenDialog.filename),nil,nil,SW_SHOWNORMAL or SW_RESTORE{ or SW_MAXIMIZE}	);
   if  Res<32 then
   begin
     case res of
   SE_ERR_NOASSOC:begin
                 if silang1.MessageDlg(siLang1.GetTextOrDefault('strstrm44' (* 'There is no application associated with the given file name extension.Install flash player?' *) ),mtwarning,[mbYes,mbNo],0)=mrYes then
                 begin
                 if FileExists(InstallFlashplayerpath) then
                   ShellExecute(handle,nil,Pchar(InstallFlashplayerpath),nil,nil,SW_RESTORE or SW_MAXIMIZE	);
                 end;
               end;
                end; //case
(*0 The operating system is out of memory or resources.
ERROR_FILE_NOT_FOUND The specified file was not found.
ERROR_PATH_NOT_FOUND The specified path was not found.
ERROR_BAD_FORMAT The .exe file is invalid (non-Microsoft Win32 .exe or error in .exe image).
SE_ERR_ACCESSDENIED The operating system denied access to the specified file.
SE_ERR_ASSOCINCOMPLETE The file name association is incomplete or invalid.
SE_ERR_DDEBUSY The Dynamic Data Exchange (DDE) transaction could not be completed because other DDE transactions were being processed.
SE_ERR_DDEFAIL The DDE transaction failed.
SE_ERR_DDETIMEOUT The DDE transaction could not be completed because the request timed out.
SE_ERR_DLLNOTFOUND The specified DLL was not found.
SE_ERR_FNF The specified file was not found.     =2  file not found
SE_ERR_NOASSOC There is no application associated with the given file name extension. This error will also be returned if you attempt to print a file that is not printable.
SE_ERR_OOM There was not enough memory to complete the operation.
SE_ERR_PNF The specified path was not found.      = path not found
SE_ERR_SHARE A sharing violation occurred.
#define SE_ERR_FNF              2       // file not found
#define SE_ERR_PNF              3       // path not found
#define SE_ERR_ACCESSDENIED     5       // access denied
#define SE_ERR_OOM              8       // out of memory
#define SE_ERR_DLLNOTFOUND              32

#endif /* WINVER >= 0x0400 */

/* error values for ShellExecute() beyond the regular WinExec() codes */
#define SE_ERR_SHARE                    26
#define SE_ERR_ASSOCINCOMPLETE          27
#define SE_ERR_DDETIMEOUT               28
#define SE_ERR_DDEFAIL                  29
#define SE_ERR_DDEBUSY                  30
#define SE_ERR_NOASSOC                  31

*)
    end;
  end
  else
  begin
    ShockWave:=TShockWave.create(Sender,OPenDialog.filename);
    ShockWave.Show;
    ShockWave.ShockwaveFlash.play;
  end;
 end;
    flash.enabled:=true;
end;

procedure TMain.HelpHTMLClick(Sender: TObject);
//var Helpflash:TfHelpHtml;
begin
 //HelpFlash:= TfHelpHtml.create(Self);
 // 221102
 // hhOpen.OpenHelp(widestring(ExeFilePath+'Newproject.chm'),widestring('First_Topic.htm'));
 // OpenHelp(const HelpFile: WideString; const HelpSection: WideString): Integer;
 // CloseHelp;
   Application.HelpContext(1);
end;


procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var lflgstatusstep:apitype;
    res:word;
    i:integer;
     h:HWNd;
  TheWindow : HWND;
    uExitCode:word;
 ProcessHandle : THandle;
 ProcessID: Integer;
 ProcInfo: TProcessInformation;
 label 100;
function FileDeleteRB(const AFileName:string): boolean;
var Struct: TSHFileOpStruct;
    pFromc: array[0..255] of char;
    Resultval: integer;

begin
   if not FileExists(AFileName) then begin
      Result := False;
      exit;
   end
   else
   begin
      fillchar(pfromc,sizeof(pfromc),0) ;
      StrPCopy(pfromc,expandfilename(AFileName)+#0#0) ;
      Struct.wnd := 0;
      Struct.wFunc := FO_DELETE;
      Struct.pFrom := pFromC;
      Struct.pTo := nil;
      Struct.fFlags:= FOF_ALLOWUNDO or FOF_NOCONFIRMATION
                       or FOF_SILENT;
      Struct.fAnyOperationsAborted := false;
      Struct.hNameMappings := nil;
      Resultval := ShFileOperation(Struct) ;
      Result := (Resultval = 0) ;
   end;
end;
begin    { TODO : 140908 }
// if not flgAdmin then begin  CanClose := True;exit; end;
 // need to close when close main windows cick X)
   CanClose := CanClose;
   if  not FlgCanClose then        //true;   180114
   begin
     CanClose:=false;
     exit;
   end;
if  flgApproachOK then
 begin
//   silang1.MessageDlg(strm17{'Move probe away!!'}, mtInformation,[mbOk], 0);
   if silang1.MessageDlg(strm17{'Move probe away!!'}, mtInformation,[mbYes,mbNo], 0)=mrYes
   then
   begin
    if  assigned(FrBeginner)   then  FrBeginner.Close;
    if not assigned(Approach){ or not assigned(Fastland)}then
     begin
    //   NanoEdu.ApproachRegime;
    //   NanoEdu.ScannerApproach.TurnOn;
     end;
       Inform:=TInform.Create(Application);
       Inform.labelinf.caption:=strm2{'Please wait, while the probe is rising to the start position!!!'};
       Inform.Show;
       Application.ProcessMessages;
       //edited 14/03/17
       if (flgUnit=ProBeam) then  lFlgStatusStep:=NanoEdu.RisingToStartPoint(100) else       //change sign - -> +
         if (flgUnit=MicProbe) then lFlgStatusStep:=NanoEdu.RisingToStartPoint(100)       // need to known!!!!!!!!!!!!!!
                                 else lFlgStatusStep:=NanoEdu.RisingToStartPoint(30);   //changed 220316
// lFlgStatusStep:=NanoEdu.RisingToStartPoint(30);
       flgApproachOK:=false;
        Inform.Close;
        Application.ProcessMessages;
   end
   else flgApproachOK:=false;
 end;
begin
 if assigned(QRLabel)       then FreeAndNil(QRLabel);
 if assigned(QRImageTop)    then FreeAndNil(QRImageTop);
 if assigned(QRImageBottom) then FreeAndNil(QRImageBottom);
 if assigned(DetailBand)    then FreeAndNil(DetailBand);
 if assigned(QuickRep)      then begin FreeAndNil(QuickRep);  end;

  h:=FindWindow(nil,Pchar(strm41{'MSVideo'}));
   if(FlgCurrentUserLevel<>DEMO) then begin if h<>0 then  StopVideo; end
    else  if assigned(MSVideoForm) then MSVideoForm.Close;

  if EXE_Running('Oscilloscope.exe', false) then
  begin
   TheWindow:=FindWindow(nil,'Oscilloscope');
   if  TheWindow<>0 then
   begin
    GetWindowThreadProcessID(TheWindow, @ProcessID);
    ProcessHandle := OpenProcess(PROCESS_TERMINATE, FALSE, ProcessId);
    if not (ProcessHandle=0) then
    begin
     TerminateProcess(ProcessHandle,0{4});
     CloseHandle(ProcessHandle);
    end;
   end;
  end;
  if CountStart>=1 then
  begin
   if  (WorkNamefileMaskCur=WorkNamefileMaskDef) or (WorkNamefileMaskCur=WorkNamefileMaskDemo) then
    begin
     res:=silang1.MessageDlg(strm19{'Save Work Files Series '}+WorkNamefileMaskCur+' +i.spm?',mtConfirmation,[mbYes,mbNo],IDH_SaveResults);
     if  res=mrNo then
     begin
       res:=silang1.MessageDlg(strm20{'Delete All Work Files Series '}+WorkNamefileMaskCur+' +i.spm?',mtConfirmation,[mbYes,mbNo],IDH_SaveResults);
      if  res=mrYes then
      begin
      ires:=FindFirst(WorkDirectory+'\'+WorkFileMask,faAnyFile,sSR);
      while ires = 0 do
        begin
         if  (AnsiContainsText(ExtractFileName(sSR.Name),WorkNamefileMaskCur)){ and  (ExtractFileName(sSR.Name)<>ExtractFileName(WorkNameFile)) }then
           begin
             FileDeleteRB(WorkDirectory+'\'+sSR.Name);//Erase(FF);
           end;
          ires:=FindNext(sSR);
        end;
       FindClose(sSR);
      end;
     end
     else
      if  res=mrYes then
       begin
            if assigned(DirView) then DirView.SetFocus
                                 else
                                 begin
                                   OpenDirectory:=WorkDirectory;
                                   ActionOpenExecute(Sender);
                                 end;
              ActionNew.Enabled:=true;
              NewItem.Enabled:=True;
              CanClose := false;
              exit;
       end
    end;
  end;
   { TODO : 101008 }
// if ( CurrentUserLevelflg<>Demo) then   SaveConfig;
 if assigned(PaletteForm)    then  PaletteForm.Close;
 if assigned(ImageTools)     then  ImageTools.Close;
 if assigned(ScaleGL)        then  ScaleGL.Close;
 if Assigned(frBeginner)     then  frBeginner.Close;
 if Assigned(ReportForm)     then  ReportForm.Close;
  Application.ProcessMessages;
  for I:=MDIChildCount-1 downto 0 do
  begin
   if not (MDIChildren[i] is TfrmGL) then MDIChildren[i].close      //not OpenGl wnd
  end;
  Application.ProcessMessages;
  for I:=MDIChildCount-1 downto 0 do
  begin
   if  (MDIChildren[i] is TfrmGL) then
   if  assigned((MDIChildren[i] as TfrmGL).ParentFragW) then  MDIChildren[i].close;   // attempt close fargments  wnd;
  end;
  Application.ProcessMessages;
  for I:=MDIChildCount-1 downto 0 do
  begin
   if  (MDIChildren[i] is TfrmGL) then MDIChildren[i].close       // close rest    wnd;
  end;
 end;
 if ToolScanBar.visible then  RunCloseExecute(sender);
end;

procedure TMain.aboutClick(Sender: TObject);
var About:TFormAbout;
 begin
    About:=TFormAbout.Create(Application);
    About.Show;
 end;

(* procedure TMain.WMDisplayChange(var message: TMessage);
begin
     FormResize(self);
end;
*)
 procedure TMain.StatusBarMainDrawPanel(StatusBar: TStatusBar;Panel: TStatusPanel; const Rect: TRect);
var OldBkMode:integer;
begin
     StatusBarMain.Color:=clWhite;
     StatusBarMain.Canvas.Font.Color := clBlack;
    if Panel = StatusBarMain.Panels[0] then
     begin
       if (ramm<10) or (swapm<15) then
                                  begin
                                    StatusBarMain.Visible:=true;
                                    StatusBarMain.Canvas.Font.Color := clRed;
                                  end
                                  else
                                  begin
                                    StatusBarMain.Visible:=false;
                                    StatusBarMain.Canvas.Font.Color := clBlack;
                                  end;
      OldBkMode := SetBkMode(StatusBarMain.Canvas.Handle, TRANSPARENT);
      StatusBarMain.Canvas.TextOut(Rect.Left, Rect.Top, StatusBarMain.Panels[0].Text);
      SetBkMode(StatusBarMain.Canvas.Handle, OldBkMode);
     end;
end;

function TMain.STMExecute:boolean;//(Sender: TObject);
var FID:INteger;
    taskdata:integer;
    tmp:integer;
begin
        result:=false;
        PIDParams:=PIDSTMParams;
        STMflg:=true;
        addcaption:=siLang1.GetTextOrDefault('IDS_3' (* '  Scanning Tunneling Microscope; ' *) );
        ComboBoxSFMSTM.Hint:=siLang1.GetTextOrDefault('IDS_147' (* 'Scanning Tunneling Microscope' *) );
        Resonance.visible:=false;
        Scanning.Visible:=False;
        Scanning.Hint:=siLang1.GetTextOrDefault('IDS_1' (* 'Make Landing before Scanning' *) );
        Landing.Visible:=True;
        Landing.Hint:=siLang1.GetTextOrDefault('IDS_2' (* 'Landing' *) );
        Training.visible:=not FlgApproachOK;
        if assigned(Approach)  then
        begin
          Approach.flgCancel:=true;
          Approach.Close;
        end;
        if flgfirsttimeSTM then UsersParamsDef
                            else
                            begin
                             UsersParamsLast(ConfigUsersIniFile);
                             ScanParams.flgFastSimulator:=false;
                            end;
        flgfirsttimeSTM:=false;
        FreeAndNil(NanoEdu);
  case FlgCurrentUserLevel of
  Beginner,
  Advanced: NanoEdu:=TSTMNanoEdu.Create;
  Demo    : begin
             NanoEdu:=TSTMNanoEduDemo.Create;
            end;
          end;
       case  PrepareScannerData of

   0:  ; //ok
   1:  begin
        if assigned(NanoeduDevice)    then
         begin
          if assigned(formInitUnitEtape) then  begin
          formInitUnitEtape.PageControl1.ActivePageIndex:=1;
          formInitUnitEtape.TabSheetErr.TabVisible:=true;
          end;
          Reloadscheme;
          if PrepareScannerData =1 then
            begin
                 if assigned(formInitUnitEtape) then formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_17' (* 'Adapter is not connected!' *) ));
                 silang1.MessageDlg(siLang1.GetTextOrDefault('IDS_17' (* 'Adapter is not connected!' *) )+
                                                                            #13+siLang1.GetTextOrDefault('IDS_19' (* 'Turn off Controller.' *) )+#13+
                                                                            siLang1.GetTextOrDefault('IDS_22' (* 'Test connection Head-Controller!' *) ),mtWarning,[mbOk],0);


            end;
         end;
       end;
   999:  begin RunCloseExecute(nil); ActionNew.Enabled:=true; exit; end;
        end;
         if FlgApproachOK then  LandingSlowExecute(nil);
        caption:=basecaption+addcaption+addworkdirectory;
        result:=true;
end;


procedure TMain.SynchroSEMClick(Sender: TObject);
begin
 if OpenDialogSEM.execute then
 begin
    ConfigSEMPath:=Extractfilepath(OpenDialogSEM.filename);
    ConfigSEMfile:= ConfigSEMPath+'user.config'  ;
    SetSEMConfigPath(ConfigSEMfile);
 end;
end;

procedure TMain.HelpClick(Sender: TObject);
begin
   Application.HelpCommand(Help_Finder,0);
end;

procedure TMain.CopyToClipboardClick(Sender: TObject);
 var bitmap:Tbitmap;
begin
 bitmap:=Tbitmap.Create;
 bitmap.Width:=ActiveMDIChild.ClientWidth;
 bitmap.Height:=ActiveMDIChild.ClientHeight;
 try
  with bitmap.Canvas do
    CopyRect(ActiveMDIChild.ClientRect,ActiveMDIChild.Canvas,ActiveMDIChild.ClientRect);
  ClipBoard.Assign(bitmap);
 finally
   FreeAndNil(bitmap)
 end;
end;

procedure TMain.CopytoClipBoardWindows1Click(Sender: TObject);
var bitmap:Tbitmap;
  r:Trect;
begin
 bitmap:=Tbitmap.Create;
 r.top:=ActiveMDIChild.top;
 r.bottom:=ActiveMDIChild.top+ActiveMDIChild.height+2*ActiveMDIChild.borderwidth;
 r.left:=ActiveMDIChild.left;
 r.right:=ActiveMDIChild.left+ActiveMDIChild.width+2*ActiveMDIChild.borderwidth;
 bitmap.Width:=ActiveMDIChild.width+2*ActiveMDIChild.borderwidth;
 bitmap.Height:=ActiveMDIChild.height+2*ActiveMDIChild.borderwidth;
 try
  with bitmap.Canvas do   CopyRect(r,Main.Canvas,r);
  ClipBoard.Assign(bitmap);
 finally
   FreeAndNil(bitmap)
 end;
end;

procedure TMain.ScannerClick(Sender: TObject);
begin
    ShockWave:=TShockWave.create(Sender,ExeFilePath+'scanner.swf');
    ShockWave.Show;
    ShockWave.Caption:='Scanner Design';
    ShockWave.ShockwaveFlash.play;
end;

procedure TMain.ScanningExecute(Sender: TObject);
begin
  if assigned(FormScannerTraining) then
 begin
   silang1.MessageDlg(strm24{'Close Scanner Trainning Windows!'}, mtInformation,[mbOk], 0);
   exit;
 end;
 if  assigned(ScannerPositionXYZ) then
  begin
   silang1.MessageDlg(siLang1.GetTextOrDefault('IDS_237' (* 'Close PositionXYZ  Windows!' *) ), mtInformation,[mbOk], 0);
   exit;
 end;

 if assigned(Approach) then
  begin
     Approach.flgCancel:=false;
     Approach.Close;
     application.ProcessMessages;
  end
  else
  if not assigned(Scanwnd) then ScanWND:=TScanWND.Create(Application);
   Scanning.Visible:=false;
   Training.Visible:=false;//(not FlgApproachOK) and (not FlgTooClose);//not FlgApproachOK;//false;
   Resonance.Visible:=false;//(not FlgApproachOK) and (not FlgTooClose);
   Landing.Visible:=false;
end;

procedure TMain.ResonanceClick(Sender: TObject);
begin
    ShockWave:=TShockWave.create(Sender,ExeFilePath+'resonance.swf');
    ShockWave.Show;
    ShockWave.Caption:=siLang1.GetTextOrDefault('IDS_157' (* 'Frequency Scanning. Adjust  Resonance' *) );
    ShockWave.ShockwaveFlash.play;
end;

procedure TMain.ResonanceExecute(Sender: TObject);

begin
if assigned(AutoResonance) then  AutoResonance.SetFocus
                           else  AutoResonance:=TAutoResonance.Create(Application);
// Training.Enabled:=False;

end;

procedure TMain.V1Click(Sender: TObject);
begin
  ViewConfigFile:=TViewConfigFile.Create(Application,ConfigUsersIniFilePath+ConfigUsersIniFile);
  ViewConfigFile.ShowModal;
end;

procedure TMain.VideoMenuClick(Sender: TObject);
var locdir:string;
    InitialDir,filename:string;
begin
   Videomenu.enabled:=False;
//   OpenDialog.Filter:='movie files (*.wmv;*.avi;*.mp4)|*.wmv;*.avi;*.mp4;|all files (*.*)|*.*' ;
(*   if lang = 2 then locdir:='rus'
   else  locdir:='eng';

   OpenDialog.InitialDir:=CommonNanoeduDocumentsPath+'video' +'\'+locdir;
   OpenDialog.FileName:='';
  if Opendialog.execute then
   begin
     ExecAndWaitMainVideo(Opendialog.Filename,'','',SW_showNORMAL);
   end;
   *)
  if lang = 2 then
  begin
   locdir:='rus';
   InitialDir:=CommonNanoeduDocumentsPath+'video' +'\'+locdir;
   fileName:=InitialDir+'\'+tutvideorus;//'\3D_Модель_NanoEducator_LE.mp4'
  end
  else
  begin
   locdir:='eng';
   InitialDir:=CommonNanoeduDocumentsPath+'video' +'\'+locdir;
   fileName:=InitialDir+'\'+tutvideoeng;//'\3D_Model_NanoEducator_LE.mp4'
  end;
 if Fileexists(Filename) then   ExecAndWaitMainVideo(Filename,'','',SW_showNORMAL)
                         else   silang1.MessageDlg(Filename+strfilenotexists,mtWarning ,[mbOK],0);
   Videomenu.enabled:=True;
end;

procedure TMain.UnitImageClick(Sender: TObject);
begin
//{$IFDEF FULL}
if not ToolScanBar.visible then
begin
 FChooseUnit:=TFChooseUnit.Create(Application);
 FChooseUnit.ShowModal;
       case   flgUnit of
 nano: if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg');
 terra:if fileexists(ExeFilePath+'Data\'+'terrahrz.jpg')    then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'terrahrz.jpg');
 baby: if fileexists(ExeFilePath+'Data\'+'babyunit.jpg')    then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'babyunit.jpg')    ;
//grand: if fileexists(ExeFilePath+'Data\'+'nanoeduunit.jpg') then  UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'nanoeduunit.jpg')    ;
 ProBeam: if fileexists(ExeFilePath+'Data\'+'sem.jpg')         then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'sem.jpg')    ;
 MicProbe: if fileexists(ExeFilePath+'Data\'+'micprobe.jpg')         then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'micprobe.jpg');
 Pipette:if fileexists(ExeFilePath+'Data\'+'pipette.jpg')    then UnitImage.Picture.LoadFromFile(ExeFilePath+'Data\'+'pipette.jpg')    ;
       end;
 InitDirectories;
 InitTutor;
end;
//{$ENDIF}
end;

procedure TMain.ChooseWorkDir;
var res:integer;
  olddir:string;
begin
   if not assigned(WorkView) then  CreateWorkViewWnd(true);
    Application.ProcessMessages;
    olddir:=workdirectory;
    ToolBtnDir.visible:=False;
    ToolBtnDir.Enabled:=False;
    ChangeDir:=TChangeDir.Create(self);
    res:=ChangeDir.ShowModal;
    Application.ProcessMessages;
    if res=mrOK then
     begin
      if assigned(WorkView)  then
      begin
       if (olddir<>workdirectory) then  WorkView.Redraw;//Close;
      end
      else  CreateWorkViewWnd(true);
     end;
      addworkdirectory:=baseworkdircaption+workdirectory;
      caption:=basecaption+addcaption+addworkdirectory;
      if assigned(formInitUnitEtape) then
      begin
       formInitUnitEtape.CheckListBox.Checked[idchoosedir]:=true;
       formInitUnitEtape.ProgressBar.position:=idchoosedir;
      end;
end;
procedure  TMain.UnitInit;
var  LinError:integer;
     DiscrVal:integer;
begin
  flgAnodeLithoEnable:=true;//false;
  flgRenishawEnable:=false;
 with ScanParams do
  begin
    case  flgUnit of
 nano,terra,
 Pipette:begin
        flgAnodeLithoEnable:=true;
        flgRenishawEnable:=false;
  (*
        if flgCurrentUserLevel<>Demo then  flgAnodeLithoEnable:=Nanoedu.TestForAnodeLitho
                                     else
        if flgCurrentUserLevel<>Demo then  flgRenishawEnable:=Nanoedu.TestForRenishaw
                                     else
  *)
        FlgReniShawUnitExists:=FlgRenishawUnitExists  and flgRenishawEnable;
//
        FlgReniShawUnit:=FlgRenishawUnitExists and (flgUnit=nano);
        FlgReniShawUnit:=FlgReniShawUnit and (FlgCurrentUserLevel<>Demo);
//
         LoadConfig;

         LoadScannerParams(flgAllDataReadFromAdapter);  //  28/11/12

  /////*********************************************
       if flgSetScanArea then
       begin
        Voltage_toDiscr('X',0, DiscrVal, ScanAreaBeginXR)  ;     // Выход в точку 0 В по Х и Y
        Voltage_toDiscr('Y',0, DiscrVal, ScanAreaBeginYR)  ;
        if flgCurrentUserLevel = Demo then begin
                                           ScanAreaBeginXR:=0;
                                           ScanAreaBeginYR :=0;
                                         end;
          ScanParams.XBegin:= ScanAreaBeginXR;  // nm
          ScanParams.YBegin:= ScanAreaBeginYR;  // nm
         if FlgCurrentUserLevel<>Demo then flgSetScanArea:=false;
       end;
  /////*******************
        //  MoveToStartPoint(ScanAreaBeginXR, ScanAreaBeginYR);
         if not flgAllDataReadFromAdapter then LinError:=TestErrorScannerIniFile
                                          else
                                          begin
                                           LinError:=0;
                                           //add 161101
                                           flgLinXScanner:=true;
                                           flgLinYScanner:=true;
                                           //
                                          end;

         SetLinSplineZero;

       with ScannerCorrect    do
        begin
         FlgXYLinear:=True;   { TODO : 041012 }
         FlgZLinear:=false;
         FlgZLinAbs:=true;
         FlgZSurfCorr:=False;
         flgPlnDel:=True;
         flgPlnDelHW:=True;
         flgHideLine:=True;
        end;
        if flgUNit=Terra then  ScannerCorrect.FlgXYLinear:=false;       ///???????

        case LinError of
          5:                                               ;//no scanner.ini file
        3,4:begin ScannerCorrect.FlgXYLinear:=False;         end;
          0: begin
             if not flgAllDataReadFromAdapter then LoadLinSpline(HardWareOpt.ScannerNumb)
                                              else LoadLinSplineFromAdapter;       //O'K
             end;
          2:;                                                //new scanner
            end;
        if LinError =0 then                 // OLA
          begin
           // initScannerLinRecords(0);
           // initScannerBufRecords(0);
          end;

       end;
 baby: begin
        LoadConfig;
        if flgSetScanArea then
        begin
          if FlgCurrentUserLevel<>Demo then flgSetScanArea:=false;
        end;
        SetLinSplineZero;
        with ScannerCorrect    do
        begin
         FlgXYLinear:=false;
         FlgZLinear:=false;
         FlgZLinAbs:=true;
         FlgZSurfCorr:=False;
         flgPlnDel:=True;
         flgPlnDelHW:=false;//True;
         flgHideLine:=True;
        end;
        FlgReniShawUnitExists:=false;  FlgReniShawUnit:=false;
      end;
 ProBeam,
 MicProbe:
        begin
        SynchroSEM.Visible:=true;
        if flgCurrentUserLevel<>Demo then  flgAnodeLithoEnable:=Nanoedu.TestForAnodeLitho
                                     else  flgAnodeLithoEnable:=true;
        if flgCurrentUserLevel<>Demo then  flgRenishawEnable:=Nanoedu.TestForRenishaw
                                     else  flgRenishawEnable:=false;
        FlgReniShawUnitExists:=false;
        FlgReniShawUnit:=false;

        LoadConfig;
         if flgSetScanArea then
         begin
          if FlgCurrentUserLevel<>Demo then flgSetScanArea:=false;
         end;

        LoadScannerParams(flgAllDataReadFromAdapter);  //  28/11/12

        if not flgAllDataReadFromAdapter then LinError:=TestErrorScannerIniFile
                                         else
                                         begin
                                          LinError:=0;
                                          //add 161101
                                          flgLinXScanner:=true;
                                          flgLinYScanner:=true;
                                          //
                                         end;

        SetLinSplineZero;
       with ScannerCorrect    do
        begin
         FlgXYLinear:= True; //false;  180713  //True;  { TODO : 041012 }
         FlgZLinear:=true;
         FlgZLinAbs:=true;
         FlgZSurfCorr:=False;
         flgPlnDel:=True;
         flgPlnDelHW:=false;//True;
         flgHideLine:=True;
        end;
        case LinError of
          5:                                               ;//no scanner.ini file
        3,4:begin ScannerCorrect.FlgXYLinear:=False;         end;
          0:begin
             if not flgAllDataReadFromAdapter then LoadLinSpline(HardWareOpt.ScannerNumb)
                                              else LoadLinSplineFromAdapter;
           end;
         2:;                                                //new scanner
            end;
      end;
grand:begin
        (*ScanAreaStartXR:=500000;
        ScanAreaStartYR:=500000;
        ScanAreaStartXF:=1000;
        ScanAreaStartYF:=1000;
        ScanAreaBeginXR:=0;
        ScanAreaBeginYR:=0;
        ScanAreaBeginXF:=0;
        ScanAreaBeginYF:=0;
        *)

         LoadConfig;
         LinError:=TestErrorScannerIniFile;
         SetLinSplineZero;
       with ScannerCorrect    do
        begin
         FlgXYLinear:=false;
         FlgZSurfCorr:=False;
         flgPlnDel:=True;
         flgPlnDelHW:=True;
         flgHideLine:=True;
        end;
          case LinError of
          5:                                               ;//no scanner.ini file
        3,4:begin ScannerCorrect.FlgXYLinear:=False;         end;
          0: LoadLinSpline(HardWareOpt.ScannerNumb);       //O'K
          2:;                                                //new scanner
            end;
            FlgReniShawUnitExists:=false; FlgReniShawUnit:=false;
      end;
           end;  //case
      end;
end;

procedure  TMain.MoveToStartPoint(XStartnm, YStartnm:integer);
var tmpdelay, tmpDiscrNumInMicroStep:integer;
    error:integer;
begin
 flgCanClose:=false;
  ToolScanBar.Enabled:=false; // add 13.08.13
  tmpdelay:=ScanParams.MicrostepDelay;
  ScanParams.MicrostepDelay:=1;
  tmpDiscrNumInMicroStep:= Scanparams.DiscrNumInMicroStep;
  Scanparams.DiscrNumInMicroStep:=10;

   NanoEdu.ScanMoveToX0Y0Method( XStartnm, YStartnm);  // 150416
       error:=NanoEdu.Method.Launch;
        if error<>0 then
        begin

          exit
        end;
       while assigned(ProgressMoveTo) do
           begin sleep(10); application.processmessages; end;
           
  ScanParams.MicrostepDelay:= tmpdelay;
  Scanparams.DiscrNumInMicroStep:= tmpDiscrNumInMicroStep;
  ToolScanBar.Enabled:=true;    //13.08.13
 flgCanClose:=true;
end;

procedure TMain.EtchingExecute(Sender: TObject);
   var
   i:integer;
   H:HWND;
   R:TRect;
 begin
 //  Windowstate:=wsMinimized;

 RunCloseExecute(Sender);

 if EXE_Running('Oscilloscope.exe', false) then
  begin
    silang1.MessageDlg(strm16{'Close Oscilloscope program!! '},mtWarning ,[mbOK],0);
    exit;
  end;
(*  if (ScanWND<>nil) or (Approach<>nil) or (AutoResonance <>nil)
                    or (FastLand<>nil) or (FormScannerTraining<>nil)
                    then
      begin
         silang1.MessageDlg(strm18{'Close all windows!'},mtWarning ,[mbOK],0);
         //ShowMessage(strm18{});
         exit;
      end ;
 *)
 if   flgVideoOscConflict then
 begin
   h:=FindWindow(nil,Pchar(strm41{'MSVideo'}));
   if h<>0 then
    begin  silang1.MessageDlg(strm25{'Close Nanoeducator Video Camera, before Start Etching!'},mtWarning ,[mbOK],0);  RestoreState; exit   end;
 end;
   //     Main.ToolBtnDir.Enabled:=False;
   //     if assigned(Nanoedu) then FreeAndNil(NanoEdu);
       for  i := 0 to Screen.FormCount-1 do
         begin
            if  Screen.Forms[i].Formstyle=fsStayOnTop then Screen.Forms[i].Hide;
         end;
      Main.windowstate:=wsMinimized;
         Application.ProcessMessages;
if not EXE_Running('Etching.exe', false) then
  begin
    ExecAndWaitEtch(ExeFilePath+'Etching.exe' ,'','tip etching',SW_showNORMAL);
    h:=findwindow(nil,Pchar(strm41{'MSVideo'}));
    if h<>0  then   StopVideo;
    Main.WindowState:=wsMaximized;
    RestoreState;
       for  i := 0 to Screen.FormCount-1 do
         begin
            if  Screen.Forms[i].Formstyle=fsStayOnTop then Screen.Forms[i].show;
         end;
    Application.ProcessMessages;
  end;
end;
function Tmain.ExecAndWaitMainOsc(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
var StartInfo: TStartupInfo;
     ProcInfo: TProcessInformation;
      CmdLine: ShortString;
            H: hWnd;
            R:TRECT;
           IU:IUNKnown;
           i:integer;
           count:dword;
           name:widestring;
           logstr:string;
         IOSC:IDeviceChannelsInfo;
begin { Iiiauaai eiy oaeea ia?ao eaau?eaie, n niae?aaieai anao i?iaaeia a eiaiao Win9x }
 if not EXE_Running('oscilloscope.exe',false) then  // h:=FindWindow(nil,Pchar(winname));
  begin
//   frOSCParams:=TOSCParams.Create(self);
//    frOSCParams.ShowModal;
    SchematicControl.QueryLFB(WideString('OSC1'),IU);
    IOSC:=IU as IDeviceChannelsInfo;
(*    IOSC.GetCount(count);
    Setlength(aOSCParamVal,count);
    Setlength(aOSCParamName,count);
    OSCParams.NChannels:=count;
*)
   for I := 0 to OSCParams.NChannels-1 do
   begin
   //  IOSC.GetChannelName(i,name);
   //  aOSCParamName[i]:=name;
     {$IFDEF DEBUG}
           logstr:=aOSCParamName[i]+' = '+inttostr(i);
           Formlog.memolog.Lines.add(logstr);
      {$ENDIF}
   end;
       frOSCParams:=TOSCParams.Create(self);
       frOSCParams.ShowModal;
 (*
    IOSC.SetChannelBits(0,OSCParams.LRX);
    IOSC.SetChannelBits(1,OSCParams.phase);
    IOSC.SetChannelBits(2,OSCParams.amplitude);   //  phase
    IOSC.SetChannelBits(3,OSCParams.piderror);
    IOSC.SetChannelBits(4,OSCParams.adcZ);
    IOSC.SetChannelBits(5,OSCParams.dacX);
    IOSC.SetChannelBits(6,OSCParams.dacY);
    IOSC.SetChannelBits(7,OSCParams.dacZ);      //      piderror
 *)
// check
    IOSC.GetChannelName(0,name);

   for I := 0 to OSCParams.NChannels - 1 do
    IOSC.SetChannelBits(i,aOSCParamVal[i]);

  (*
    IOSC.SetChannelBits(0,OSCParams.LRX);
    IOSC.SetChannelBits(1,OSCParams.amplitude);
    IOSC.SetChannelBits(2,OSCParams.dacX);
    IOSC.SetChannelBits(3,OSCParams.dacY);
    IOSC.SetChannelBits(4,OSCParams.phase);
    IOSC.SetChannelBits(5,OSCParams.adcZ);
    IOSC.SetChannelBits(6,OSCParams.piderror);
    IOSC.SetChannelBits(7,OSCParams.dacZ);      //
    IOSC.SetChannelBits(8,OSCParams.U);
    IOSC.SetChannelBits(9,OSCParams.U);
    IOSC.SetChannelBits(10,OSCParams.PID);
  *)
    IOSC.UpdateChannelBits;

   CmdLine := '"' + Filename + '" ' + Params;
   FillChar(StartInfo, SizeOf(StartInfo), #0);
   with StartInfo do
    begin //cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
    end;
     Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
     { I?eaaai caaa?oaiey i?eei?aiey }
    if Result then
     begin
      h:=0;
      while h=0 do  h:=FindWindow(nil,Pchar(winname));
      GetWindowRect(h,R);
 // changed 220316   SetWindowPos(h,HWND_TOPMost,Main.Left+50+Main.ClientWidth-(R.right-R.left),0,50,50,SWP_NOSIZE {or SWP_NOMOVE} or SWP_SHOWWINDOW);
     if(Screen.MonitorCount=1)then
           SetWindowPos(h,HWND_TOPMost,Left+50+ClientWidth-(R.right-R.left),50,50,50,SWP_NOSIZE {or SWP_NOMOVE} or SWP_SHOWWINDOW)
      else SetWindowPos(h,HWND_TOPMost,50+ClientWidth-(R.right-R.left),50,50,50,SWP_NOSIZE {or SWP_NOMOVE} or SWP_SHOWWINDOW)
  end;
   end
  else
   begin
    Result:=false;
    MessageDlgCtr(strm37{'program is active or error start program '}+winname+'!!'+#13+strm38{'If it is error,close control panel and restart again'},mtWarning ,[mbOK,mbHelp],1);
   end;
end;

function Tmain.ExecAndWaitMainVideo(const FileName, Params: String;const winname:string; const WinState: Word): boolean;
 var      H: hWnd;
     fVideo:TMedia;
     res:Thandle;
begin { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
     res:= ShellExecute(handle,nil,Pchar(fileName),nil,nil,SW_RESTORE or SW_MAXIMIZE	);
    if  Res<32 then
     begin
      fVideo:=TMedia.Create(Application);
      //  two monitirs
      fVideo.Show;
      fVideo.MediaPlayer.filename:=FileName;
      fVideo.MediaPlayer.open;
     // fVideo.MediaPlayer.play;
    end;
end;

procedure  TMain.WMMOve(var Mes:TWMMove);
begin
 if assigned(Workview)  then NotifyAllToPrilipat;
 if assigned(ImageTools)   then NotifyAllToPrilipat;
 APPLICATION.ProcessMessages
end;
(*
procedure TMain.WriteXdatatodevice1Click(Sender: TObject);
var  MLPCNPages:integer;
begin

    //OpenDialog for ini files
    MLPCStartPage:=1;
    WriteScannerIniToMLPC(MLPCStartPage, ScannerInifileX,  MLPCNPages);
  //    WaitforJavaNotActive;
  //    ReadScannerIniFromMLPC(MLPCStartPage,  MLPCNPages);

end;

procedure TMain.WriteXModParams1Click(Sender: TObject);
begin
    Nanoedu.WritePagetoMemoryMethod(pgXmodeParams);
    Nanoedu.Method.Launch;
end;

procedure TMain.WriteYDatatoDevice1Click(Sender: TObject);
var  MLPCNPages:integer;
begin
      //OpenDialog for ini files
    MLPCStartPage:=3;
    WriteScannerIniToMLPC(MLPCStartPage, ScannerInifileY,  MLPCNPages);
end;
*)
function TMain.CreateQuickReportComponent:boolean;
begin
   result:=true;
  if not Assigned(QuickRep) then
  begin
    result:=true;
    try
     QuickRep:=TQuickRep.Create(self);
    except
     begin
      silang1.MessageDlg(strm26{'Printer is not connected.'},mtwarning,[mbYes],0);
      result:=false;
      exit;
     end;
    end
  end
  else
  begin
    freeandnil(QRImageBottom);
    freeandnil(QRImageTop);
    freeAndNil(QRLabel);
    freeAndNil(DetailBand);
    FreeandNil(QuickRep);
    try
     QuickRep:=TQuickRep.Create(self);
    except
     begin
      silang1.MessageDlg(strm26{'Printer is not connected.'},mtwarning,[mbYes],0);
      result:=false;
      exit;
     end;
    end
  end;
    QuickRep.Parent:=self;
    QuickRep.visible:=false;
//    QuickRep.Page.PaperSize:
    DetailBand:=TQRBand.Create(QuickRep);;
    DetailBand.parent:=QuickRep;
    QRImageTop:=TQRImage.Create(DetailBand);;
    QRImageTop.parent:=DetailBand;
    QRLabel:=TQRLabel.Create(DetailBand);
    QRLabel.parent:=DetailBand;
    QRImageBottom:=TQRImage.Create(DetailBand);
    QRImageBottom.parent:=DetailBand;
    Application.Processmessages;
end;

procedure TMain.Influenceoftheformofatipontheimage1Click(Sender: TObject);
var filename:string;
begin
 simulation1.Enabled:=false;
case lang of
2:filename:=CommonNanoeduDocumentsPath+'animation\scan_model_ru.swf';
1:filename:=CommonNanoeduDocumentsPath+'animation\scan_model_eng.swf';
      end;

 if Fileexists(filename) then
 begin
  if not assigned(ShockWave) then    ShockWave:=TShockWave.create(Sender,filename);
    ShockWave.Show;
    ShockWave.ShockwaveFlash.play;
 end
 else  silang1.MessageDlg('File not exists!',mtwarning,[mbYes],0);
 simulation1.Enabled:=true;
end;

function TMain.IsAdmin: Boolean;
var
  hAccessToken: THandle;
  ptgGroups: PTokenGroups;
  dwInfoBufferSize: DWORD;
  psidAdministrators: PSID;
  x: Integer;
  bSuccess: BOOL;
begin
  Result   := False;
  bSuccess := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True,
    hAccessToken);
  if not bSuccess then
  begin
    if GetLastError = ERROR_NO_TOKEN then
      bSuccess := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY,
        hAccessToken);
  end;
  if bSuccess then
  begin
    GetMem(ptgGroups, 1024);
    bSuccess := GetTokenInformation(hAccessToken, TokenGroups,
      ptgGroups, 1024, dwInfoBufferSize);
    CloseHandle(hAccessToken);
    if bSuccess then
    begin
      AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
        SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS,
        0, 0, 0, 0, 0, 0, psidAdministrators);
      {$R-}
      for x := 0 to ptgGroups.GroupCount - 1 do
        if EqualSid(psidAdministrators, ptgGroups.Groups[x].Sid) then
        begin
          Result := True;
          Break;
        end;
      {$R+}
      FreeSid(psidAdministrators);
    end;
    FreeMem(ptgGroups);
  end;
end;


(*procedure  TMain.WMDDeviceChange(var MSG:TWMDEviceChange);

begin
     case MSg.Event of
DBT_DEVICEARRIVAL:
begin


end; ;     { if  not   flgControlerTurnON then
                            if    FindControler then
                             MessageDlg(siLang1.GetTextOrDefault('IDS_276' ({ 'Controller detected' *} ),mtWarning ,[mbYes],0);
                          }

DBT_DEVICEREMOVECOMPLETE:
begin


(*      if  not  FindControler then
        begin
         flgControlerTurnON:=false;
         MessageDlg(siLang1.GetTextOrDefault('IDS_277' (* 'Controller is turned off or disconnected!' *} )+#13+siLang1.GetTextOrDefault('IDS_278' (* 'Program is terminated.' *} )+#13+siLang1.GetTextOrDefault('IDS_279' (* 'Don''t forget turn off/turn on Controller!!!' *} ),mtWarning ,[mbYes],0);
         ProcessTerminate;//  halt;
       //  if  not FreeCSPMLib(libHandle) then ShowMessage('error free cspmlib');
        end;
     end

end;{if    flgControlerTurnON  then
                               if not FindControler then
                                MessageDlg(siLang1.GetTextOrDefault('IDS_281' (* 'Controller turn off' *} ),mtWarning ,[mbYes],0);
                             }
(*else begin
      if {(flgControlerTurnON) or }(libHandle>32) then
      begin
        if  not  FindControler then
        begin
         flgControlerTurnON:=false;
         MessageDlg(siLang1.GetTextOrDefault('IDS_277' {* 'Controller is turned off or disconnected!' *} )+#13+siLang1.GetTextOrDefault('IDS_278' (* 'Program is terminated.' *} )+#13+siLang1.GetTextOrDefault('IDS_279' (* 'Don''t forget turn off/turn on Controller!!!' *} ),mtWarning ,[mbYes],0);
         ProcessTerminate;//  halt;
       //  if  not FreeCSPMLib(libHandle) then ShowMessage('error free cspmlib');
        end;
      end
//      else  if  FindControler then
//      begin  flgControlerTurnON:=true;  MessageDlg('Controller detected',mtWarning ,[mbYes],0)  end;
     end;

                    end;  //case
end;
*)
(*procedure  TMain.WMDDeviceChange(var MSG:TMessage);
var str:string;
       strvidcontroller,
    strvidosc: string;
begin
  strvidcontroller:=EDU_INSTANCE_ID_PREF;//'Vid_0438&Pid_0f00';
  strvidosc:=EDU_INSTANCE_ID_PREF;//'Vid_0438&Pid_0f00';

  if Msg.WParam=DBT_DEVICEARRIVAL then
   begin
    case PDEV_BROADCAST_HDR(Msg.LParam)^.dbch_devicetype of
  DBT_DEVTYP_DEVICEINTERFACE:
     begin
     //  DevName := string(PChar(@TDevBroadcastDeviceInterface(Msg.dwData^).dbcc_name));
      //  DeviceSerial :=   Copy(DevName,length(EDU_NAME_PREFFIX)+1,9);

      str:={'Nanoeducator controller turn on!!'+}pchar(@PDEV_BROADCAST_DEVICEINTERFACE(Msg.LParam)^.dbcc_name[0]);
   //   LogMemo.Lines.Add(strturnon);//'вставлен новый интерфейс: '+pchar(@PDEV_BROADCAST_DEVICEINTERFACE(Msg.LParam)^.dbcc_name[0]));
//      deviceSerialToUpdate:=  Copy(str,length(EDU_NAME_PREFFIX)+1,9);
      if AnsiPos(LowerCase(strvidcontroller),LowerCase(str))<>0 then
      begin
       if not  flgdetectdev then
       begin
         {$IFDEF DEBUG}
         Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_286' (* 'Start drawing' *} ));
       {$ENDIF}
        flgDetectDev:=true;
   //     flgremovedev:=false;
        end;
      end;
     end;

DBT_DEVICEREMOVECOMPLETE:
begin

end;

                    end;  //case
   end;
end;
*)
(*function GetDeviceName(PnPHandle: HDEVINFO;  DevData: TSPDevInfoData): string;
var
  BytesReturned: DWORD;
  RegDataType: DWORD;
  Buffer: array [0..256] of CHAR;
begin
  BytesReturned := 0;
  RegDataType := 0;
  Buffer[0] := #0;
  SetupDiGetDeviceRegistryProperty(PnPHandle, DevData, SPDRP_FRIENDLYNAME,
    RegDataType, PByte(@Buffer[0]), SizeOf(Buffer), BytesReturned);
  Result := Buffer;
  if Result<>'' then exit;
  BytesReturned := 0;
  RegDataType := 0;
  Buffer[0] := #0;
  SetupDiGetDeviceRegistryProperty(PnPHandle, DevData, SPDRP_DEVICEDESC,
    RegDataType, PByte(@Buffer[0]), SizeOf(Buffer), BytesReturned);
  Result:=Buffer;
end;
 *)
function TMain.RunFirmSoftVideoCamera:boolean;
 var h:Hwnd;
     res:cardinal;
    fResult:boolean;
    libload:Dword;
    R:TRect;
    StartInfo: TStartupInfo;
     ProcInfo: TProcessInformation;
      CmdLine: ShortString;
begin
    Result:=false;
    if not  FileExists(FirmCameraSoftPath+FirmCameraWinName) then
    begin
       silang1.MessageDlg(str50{'Videocamera firm software has not installed!'}+#13+str51,mtWarning ,[mbOK],0);
       exit;
    end;
  if   EXE_Running(FirmCameraWinName{'CTLVCentral3.exe'}, false) then
   begin
    h:=findwindow(nil,Pchar(FirmCameraWinName));
    if h=0  then
    begin
    res:=ShellExecute(handle,nil,Pchar(FirmCameraSoftPath+FirmCameraWinName{'CTLVCentral3.exe'}),nil,nil,SW_SHOWNORMAL or SW_RESTORE{ or SW_MAXIMIZE}	);
    if Res>0 then
     begin
  (*    h:=0;
      while h=0 do   h:=FindWindow(nil,Pchar(FirmCameraWinName));
      GetWindowRect(h,R);
      result:=true;
      SetWindowPos(h,HWND_TOPMost,Main.Left+50+Main.ClientWidth-(R.right-R.left),0,50,50,SWP_NOSIZE {or SWP_NOMOVE} or SWP_SHOWWINDOW);
      *)
       end;

    end;
   end
   else
   begin
    CmdLine := '"' + FirmCameraSoftPath+FirmCameraWinName{'CTLVCentral3.exe'} + '" ';// + Params;
    FillChar(StartInfo, SizeOf(StartInfo), #0);
   with StartInfo do
    begin //cb := SizeOf(SUInfo);
     dwFlags := STARTF_USESHOWWINDOW;
     wShowWindow :=SW_showNORMAL;
    end;
 //   res:=ShellExecute(handle,nil,Pchar(FirmCameraSoftPath+FirmCameraWinName{'CTLVCentral3.exe'}),nil,nil,SW_SHOWNORMAL or SW_RESTORE{ or SW_MAXIMIZE}	);
     fResult := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(FirmCameraSoftPath)),StartInfo,ProcInfo);
     { I?eaaai caaa?oaiey i?eei?aiey }
    if fResult then
     begin
     (* h:=0;
      while h=0 do  h:=FindWindow(nil,Pchar(FirmCameraWinName));
      GetWindowRect(h,R);
      SetWindowPos(h,HWND_TOPMost,Main.Left+50+Main.ClientWidth-(R.right-R.left),0,50,50,SWP_NOSIZE {or SWP_NOMOVE} or SWP_SHOWWINDOW);
      *)
     end;
   end
end;
function   TMain.CloseOsciloscope:boolean;
var H:HWND;
begin
  if   EXE_Running('Oscilloscope.exe', false) then
           Killtask('Oscilloscope.exe');
end;

function  TMain.KillTask(ExeFileName: string): integer;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;

  FSnapshotHandle := CreateToolhelp32Snapshot
  (TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,
  FProcessEntry32);

  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
    UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
    UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(OpenProcess(
      PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;

  CloseHandle(FSnapshotHandle);
end;
function   TMain.TestControllerParams:boolean;
var val:single;
begin
   val:= PControllerParams^.X_Min+PControllerParams^.Y_Min+PControllerParams^.X_Min+PControllerParams^.X_Max+PControllerParams^.Y_Max+PControllerParams^.Z_Max;
  if val=0 then
  begin
   silang1.MessageDlg(strcontrer,mtError,[mbYes],0);
   PControllerParams^.X_Min:=-50;
   PControllerParams^.Y_Min:=-50;
   PControllerParams^.Z_Min:=-50;
   PControllerParams^.X_Max:=150;
   PControllerParams^.Y_Max:=150;
   PControllerParams^.Z_Max:=150;
  end;
end;
function TMain.NanoeduControllerDetect:boolean;
 var
  DrivePnPHandle: HDEVINFO;
  DeviceNumber:DWORD;
  DevData: TSPDevInfoData;
  RES:BOOL;
  devName:string;
  HND:THandle;
  bStatus:Boolean;
begin
(*  result:=false;
  DrivePnPHandle := SetupDiGetClassDevs(nil, nil, 0,DIGCF_ALLCLASSES);
   if DrivePnPHandle = INVALID_HANDLE_VALUE then  Exit;
  DeviceNumber := 0;
repeat
   spInterfaceData.cbSize := SizeOf(TSPDeviceInterfaceData);
   DevData.cbSize := SizeOf(TSPDevInfoData);
   RES := SetupDiEnumDeviceInfo(DrivePnPHandle, DeviceNumber, DevData);
   if (RES) then
   begin
     devName:= GetDeviceName(DrivePnPHandle, DevData);
     if (LowerCase(devName) = LowerCase(DigNanoeduDevName{'Scanning Probe Microscope Controller'})) then
      begin
       result:=true;
       break;
      end;//nanoedu controller
     Inc(DeviceNumber);
   end//res
  until not RES;
//  SetupDiDestroyDeviceInfoList(DrivePnPHandle);
*)
end;
function TMain.ProcessTerminate{(dwPID:Cardinal)}:Boolean;
var
 hToken:THandle;
 SeDebugNameValue:Int64;
 tkp:TOKEN_PRIVILEGES;
 ReturnLength:Cardinal;
 hProcess:THandle;
begin
 Result:=false;
(* // Добавляем привилегию SeDebugPrivilege
 // Для начала получаем токен нашего процесса
 if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES
  or TOKEN_QUERY, hToken ) then
    exit;

 // Получаем LUID привилегии
 if not LookupPrivilegeValue( nil, 'SeDebugPrivilege', SeDebugNameValue )
  then begin
   CloseHandle(hToken);
   exit;
  end;

 tkp.PrivilegeCount:= 1;
 tkp.Privileges[0].Luid := SeDebugNameValue;
 tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

 // Добавляем привилегию к нашему процессу
 AdjustTokenPrivileges(hToken,false,tkp,SizeOf(tkp),tkp,ReturnLength);
 if GetLastError()< > ERROR_SUCCESS  then exit;
*)
 // Завершаем процесс. Если у нас есть SeDebugPrivilege, то мы можем
 // завершить и системный процесс
 // Получаем дескриптор процесса для его завершения
 hProcess := OpenProcess(PROCESS_TERMINATE, FALSE,GetCurrentProcessId{dwPID});
 if hProcess =0  then exit;
  // Завершаем процесс
   if not TerminateProcess(hProcess, DWORD(-1)) then exit;
 CloseHandle( hProcess );

 // Удаляем привилегию
 tkp.Privileges[0].Attributes := 0;
 AdjustTokenPrivileges(hToken, FALSE, tkp, SizeOf(tkp), tkp, ReturnLength);
 if GetLastError() <>  ERROR_SUCCESS  then exit;
 Result:=true;
end;


procedure TMain.CreateWorkViewWnd(flg:boolean);
//flg -true   change size main windows
//flg -false  no change
begin
//      DockWorkView:= TDockWorkView.Create(application);
//      DockWorkView.show;
      if assigned(DirView) then       DirView.DeActivate;
      WorkView:=TfrSPMView.Create(self,Workdirectory,{WorkView,}0);
 //     WorkView.Caption:=siLang1.GetTextOrDefault('IDS_97' (* 'Work Directory' *) );
 //    WorkView.ManualDock( DockWorkView.Panel1);
 //     WorkView.DragKind:=dkDock;
 //     WorkView.DragMode:=dmAutomatic; WorkView.Show;
      Application.processmessages;
 //     WorkView.Formstyle:=fsStayOnTop;

  if (Screen.MonitorCount=1) then
  begin
      WorkView.Formstyle:=fsStayOnTop;
      WorkView.top:=Screen.workareatop;
      WorkView.left:=Screen.workarealeft;
      WorkView.height:=screen.workareaHeight;
      WorkView.width:=140+WorkView.new_panel.VertScrollBar.size;;
    if flg then
     begin
      width:=width-WorkView.width;
      left:=Screen.workarealeft+WorkView.width;//+WorkView.left;
      top:=Screen.workareatop;
     end;
  end
  else
  begin
      WorkView.Formstyle:=fsStayOnTop;
      WorkView.top:=top;
      WorkView.left:=left;
      WorkView.height:=Height;
      WorkView.width:=140+WorkView.new_panel.VertScrollBar.size;
    if flg then
     begin
      width:=width-WorkView.width;
      left:=WorkView.width+WorkView.left;
      top:=top;
     end;
  end;

 (*     WorkView.top:=top;
      WorkView.left:=left;
      WorkView.height:=Height;
      WorkView.width:=140+WorkView.new_panel.VertScrollBar.size;
    if flg then
     begin
      width:=width-WorkView.width;
      left:=WorkView.width+WorkView.left;
      top:=top;
     end;
     *)
end;


function TMain.ExecAndWaitDrivers(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
var StartInfo: TStartupInfo;
     ProcInfo: TProcessInformation;
      CmdLine: ShortString;
            H: hWnd;
            R:TRECT;
begin { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
(*void main( VOID )
{
    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );

    // Start the child process.
    if( !CreateProcess( NULL, // No module name (use command line).
        "MyChildProcess", // Command line.
        NULL,             // Process handle not inheritable.
        NULL,             // Thread handle not inheritable.
        FALSE,            // Set handle inheritance to FALSE.
        0,                // No creation flags.
        NULL,             // Use parent's environment block.
        NULL,             // Use parent's starting directory.
        &si,              // Pointer to STARTUPINFO structure.
        &pi )             // Pointer to PROCESS_INFORMATION structure.
    )
    {
        ErrorExit( "CreateProcess failed." );
    }

    // Wait until child process exits.
    WaitForSingleObject( pi.hProcess, INFINITE );

    // Close process and thread handles.
    CloseHandle( pi.hProcess );
    CloseHandle( pi.hThread );
}
*)
   CmdLine := '"' + Filename + '" ' + Params;
   FillChar(StartInfo, SizeOf(StartInfo), #0);
   with StartInfo do
    begin //cb := SizeOf(SUInfo);
     dwFlags := STARTF_USESHOWWINDOW;
     wShowWindow := WinState;
    end;
   Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
     { Ожидаем завершения приложения }
end;

procedure TMain.LabsWorkClick(Sender: TObject);
var    res:Thandle;
       filename:string;
begin
   OpenDialog.Filter:='Labs Works *.doc;*.pdf|*.doc;*.pdf|all files (*.*)|*.*' ;
   OpenDialog.FileName:='';
   if sLanguage='RUS' then OpenDialog.InitialDir:=CommonNanoeduDocumentsPath+'labs\rus'
                      else OpenDialog.InitialDir:=CommonNanoeduDocumentsPath+'labs\eng';
  if OpenDialog.execute then
   begin
    res:= ShellExecute(handle,nil,Pchar(Opendialog.fileName),nil,nil,SW_RESTORE);
  end;
end;

procedure TMain.LandingExecute(Sender: TObject);
var point,pointa:Tpoint;
begin
if assigned(ScannerPositionXYZ)
 then   silang1.MessageDlg(siLang1.GetTextOrDefault('IDS_293' (* 'Close ScannerPozitionXYZ windows!' *) ), mtInformation,[mbOk], 0)
 else   if assigned(AutoResonance) then
     begin
      AutoResonance.NormalizeUAM;
      AutoResonance.flgCancel:=false;
      AutoResonance.Close;
      Application.processmessages;
     end
     else LandingSlowExecute(Sender);
end;

procedure TMain.HelpMediaClick(Sender: TObject);
var    res:Thandle;
      filename:string;
begin
   filename:=CommonNanoeduDocumentsPath+'tutor\tutor.chm';
   res:= ShellExecute(handle,nil,Pchar(fileName),nil,nil,SW_RESTORE);
end;

procedure TMain.MainTimerUpTimer(Sender: TObject);
begin
    MainStatusBarFill;
end;

procedure TMain.PositionXYExecute(Sender: TObject);
begin
if assigned(Approach )
then   silang1.MessageDlg(siLang1.GetTextOrDefault('IDS_295' (* 'Close Approach windows!' *) ), mtInformation,[mbOk], 0)
else
if  assigned(Scanwnd) then  silang1.MessageDlg(siLang1.GetTextOrDefault('IDS_296' (* 'Close Scan windows!' *) ), mtInformation,[mbOk], 0)
 else
if not assigned(ScannerPositionXYZ) then ScannerPositionXYZ:=TScannerPositionXYZ.Create(self);
end;

procedure TMain.ActionGetAdapterIDExecute(Sender: TObject);
begin
//
end;


procedure TMain.ActionAdapterServiceExecute(Sender: TObject);
begin
   AdapterService:=TAdapterService.Create(self);
   AdapterService.ShowModal;
end;

procedure TMain.ActionAdjustOscExecute(Sender: TObject);
var   res:Thandle;
      filename:string;
      reg:Tregistry;
      sMax:string;
      s:integer;
procedure WriteData(const name:string;fadr,fcolor:integer;const sMin,sMax:string;fm:integer;const sUn:string);
begin
 Reg.OpenKey('software', true);            //Открываю раздел SYSTEM
 Reg.OpenKey('CSPM', true);                //Открываю раздел CurrentControlSet
 Reg.OpenKey('Oscilloscope', true);
 Reg.OpenKey('Source', true);
 Reg.OpenKey(Name, true);
 Reg.WriteInteger('Address',fadr);
 Reg.WriteInteger('color',fcolor);
 Reg.WriteString('Min',sMin);
 Reg.WriteString('Max',sMax);
 Reg.WriteInteger('Modifier',fm);
 Reg.WriteString('Unit',sUn);
 Reg.CloseKey;
end;
begin
 Reg:=Tregistry.Create;
try
 Reg.RootKey:=HKEY_CURRENT_USER;
 WriteData('ADC _Phase',$0000000a, $000080ff, '-10000', '10000',$00000000,'mv');
 s:=round(CSPMSignals[11].MaxDiscr/TransformUnit.nA_d*ITCor);
 sMax:=IntToStr(s);
 WriteData('ADC_Current',$0000000d, $00ff80ff, '-'+sMax, sMax,$00000000,'nA');
 WriteData('ADC_Current_mV',$0000000d, $00c080ff, '-10000', '10000',$00000000,'mv');
 s:= round(ScannerCorrect.SensitivZ*HardwareOpt.UFBMaxOut*HardwareOpt.AMPGainZ);
 sMax:=IntToStr(s);
 WriteData('ADC_Z',$00000008, $0080ffff, '-'+SMax, SMax,$00000000,'nm');
 s:=round(CSPMSignals[8].MaxDiscr/TransformUnit.Xnm_d);
 sMax:=IntToStr(s);
 WriteData('DAC_X',$00000002, $0000ff80,'-'+SMax, SMax,$00000000,'nm');
 s:=round(CSPMSignals[9].MaxDiscr/TransformUnit.Ynm_d);
 sMax:=IntToStr(s);
 WriteData('DAC_Y',$00000003, $00ff8000,'-'+SMax, SMax,$00000000,'nm');
 s:= round(ScannerCorrect.SensitivZ*HardwareOpt.UFBMaxOut*HardwareOpt.AMPGainZ);
 sMax:=IntToStr(s);
 WriteData('DAC_Z',$00000001, $00c080ff,'-'+SMax, SMax,$00000000,'nm');
 WriteData('DAC_BiasVoltage',$00000006, $00ff00ff, '-10000', '10000',$00000000,'mv');
 s:=round(CSPMSignals[11].MaxDiscr/TransformUnit.nA_d);
 sMax:=IntToStr(s);
 WriteData('DAC_REF_Current',$00000004, $0000ff00, '-'+sMax, sMax,$00000000,'nA');
 WriteData('Probe Oscillation Amplitude',$0000000f, $00ffff00, '-10000', '10000',$00000000,'mv');
 ///Write Last Date
 if not Reg.KeyExists('software\CSPM\Oscilloscope\Last') then
 begin
 Reg.OpenKey('software', true);           //Открываю раздел SYSTEM
 Reg.OpenKey('CSPM', true);               //Открываю раздел CurrentControlSet
 Reg.OpenKey('Oscilloscope', true);
 Reg.OpenKey('Last', true);
 Reg.WriteInteger('Compact',0);
 Reg.WriteInteger('DisplayMS',289);
 Reg.WriteInteger('ChNumber',2);
 Reg.WriteInteger('Place 0',65537);
 Reg.WriteString('Channel 0','ADC_X');
 Reg.WriteInteger('Lock 0',3);
 Reg.WriteString('Channel 1','ADC_Y');
 Reg.WriteInteger('Place 1',65537);
 Reg.WriteInteger('Lock 1',3);
 Reg.WriteInteger('Scale 0',1);
 Reg.WriteInteger('Scale 1',1);
 Reg.WriteInteger('Align 1',0);
 Reg.WriteInteger('Align 0',0);
 Reg.WriteInteger('Sec 1',0);
 Reg.CloseKey;
 end;
 Reg.OpenKey('software', true);           //Открываю раздел SYSTEM
 Reg.OpenKey('CSPM', true);               //Открываю раздел CurrentControlSet
 Reg.OpenKey('Oscilloscope', true);
 Reg.WriteString('C','1.0');
 Reg.WriteInteger('FPS',25);
 Reg.WriteString('R','1.0');
 Reg.CloseKey;
 finally
  Reg.Free;    //Освобождаю объект
 end;
end;



procedure TMain.TrainingExecute(Sender: TObject);
begin
        if not flgApproachOK then
                       begin
                          Training.visible:=false;
                          Resonance.visible:=false;
                          FormScannerTraining:= TFormScannerTraining.Create(Application);
                         end
                       else silang1.MessageDlg(strm43{'Move the probe away!'},mtwarning,[mbYes],0);

end;


procedure TMain.TrayIcon1DblClick(Sender: TObject);
begin
   { Hide the tray icon and show the window,
 setting its state property to wsNormal. }
(* TrayIcon1.Visible := False;
 Show();
 WindowState := wsNormal;
 Application.BringToFront();
 *)
end;

procedure TMain.Updates1Click(Sender: TObject);
var res:Thandle;
 begin
// siLang1.messagedlg(strm39{'Before install updates of the program, don''t forget to close the program ''Nanoeducator''.'} ,mtwarning,[mbOK],0);
if  flgAdmin then   siLang1.messagedlg(strm39{' Before install updates of the program, don''t forget to close the program ''Nanoeducator''.'} ,mtwarning,[mbOK],0)
              else  siLang1.messagedlg(strm40{'To make updating the program you should  have administrator rights  '},mtwarning,[mbOK],0);
// res:= ShellExecute(handle,'open'	,Pchar('http://downloads.ntmdt.com/windows/nanoeducator/'),nil,nil,SW_RESTORE);
 if not assigned(UpdaterForm) then
 begin
     UpdaterForm:=TUpdaterForm.Create(Application);
 end;// res:= ShellExecute(handle,'open'	,Pchar('http://downloads.ntmdt.com/windows/nanoeducator/'),nil,nil,SW_RESTORE);
  UpdaterForm.Show;
  UpdaterForm.flgDisappear:=false;
end;


procedure TMain.UpdateStrings;
begin
  str52 := siLang1.GetTextOrDefault('strstr52' (* 'Restore Users Config File?' *) );
  strcontrer := siLang1.GetTextOrDefault('strstrcontrer' (* 'Controller parameters have not setted!' *) );
  strfilenotexists := siLang1.GetTextOrDefault('strstrfilenotexists');
  strHintNewOk := siLang1.GetTextOrDefault('strstrHintNewOk' (* 'start new experimnent' *) );
  strHintNewTurnon := siLang1.GetTextOrDefault('strstrHintNewTurnon' (* 'turn on the controller' *) );
  str51 := siLang1.GetTextOrDefault('strstr51');
  str50 := siLang1.GetTextOrDefault('strstr50');
  str463 := siLang1.GetTextOrDefault('strstr463');
  strm462 := siLang1.GetTextOrDefault('strstrm462' (* 'Turn on controller and continue work!' *) );
  strm461 := siLang1.GetTextOrDefault('strstrm461' (* 'Continue work in turn off regime?' *) );
  strm46 := siLang1.GetTextOrDefault('strstrm46' (* 'NanoeducatorLE controller is turn off!' *) );
  strm45 := siLang1.GetTextOrDefault('strstrm45');
  strm44 := siLang1.GetTextOrDefault('strstrm44');
  strm43 := siLang1.GetTextOrDefault('strstrm43');
  strm42 := siLang1.GetTextOrDefault('strstrm42');
  strm43 := siLang1.GetTextOrDefault('strstrm43');
  strm42 := siLang1.GetTextOrDefault('strstrm42');
  strm41 := siLang1.GetTextOrDefault('strstrm41');
  strm40 := siLang1.GetTextOrDefault('strstrm40');
  strm39 := siLang1.GetTextOrDefault('strstrm39');
  strm38 := siLang1.GetTextOrDefault('strstrm38');
  strm37 := siLang1.GetTextOrDefault('strstrm37');
  strm36 := siLang1.GetTextOrDefault('strstrm36');
  strm35 := siLang1.GetTextOrDefault('strstrm35');
  strm34 := siLang1.GetTextOrDefault('strstrm34');
  strm33 := siLang1.GetTextOrDefault('strstrm33');
  strm32 := siLang1.GetTextOrDefault('strstrm32');
  strm31 := siLang1.GetTextOrDefault('strstrm31');
  strm30 := siLang1.GetTextOrDefault('strstrm30');
  strm29 := siLang1.GetTextOrDefault('strstrm29');
  strm28 := siLang1.GetTextOrDefault('strstrm28');
  strm26 := siLang1.GetTextOrDefault('strstrm26');
  strm25 := siLang1.GetTextOrDefault('strstrm25');
  strm24 := siLang1.GetTextOrDefault('strstrm24');
  strm23 := siLang1.GetTextOrDefault('strstrm23');
  strm22 := siLang1.GetTextOrDefault('strstrm22');
  strm21 := siLang1.GetTextOrDefault('strstrm21');
  strm20 := siLang1.GetTextOrDefault('strstrm20');
  strm19 := siLang1.GetTextOrDefault('strstrm19');
  strm18 := siLang1.GetTextOrDefault('strstrm18');
  strm17 := siLang1.GetTextOrDefault('strstrm17');
  strm16 := siLang1.GetTextOrDefault('strstrm16');
  strm15 := siLang1.GetTextOrDefault('strstrm15');
  strm14 := siLang1.GetTextOrDefault('strstrm14');
  strm13 := siLang1.GetTextOrDefault('strstrm13');
  strm12 := siLang1.GetTextOrDefault('strstrm12');
  strm11 := siLang1.GetTextOrDefault('strstrm11');
  strm10 := siLang1.GetTextOrDefault('strstrm10');
  strm9 := siLang1.GetTextOrDefault('strstrm9');
  strm8 := siLang1.GetTextOrDefault('strstrm8');
  strm7 := siLang1.GetTextOrDefault('strstrm7');
  strm6 := siLang1.GetTextOrDefault('strstrm6');
  strm5 := siLang1.GetTextOrDefault('strstrm5');
  strm4 := siLang1.GetTextOrDefault('strstrm4');
  strm3 := siLang1.GetTextOrDefault('strstrm3');
  strm2 := siLang1.GetTextOrDefault('strstrm2');
  strm1 := siLang1.GetTextOrDefault('strstrm1');
end;

procedure TMain.ToolBtnCloseClick(Sender: TObject);
begin
//


end;


procedure TMain.ToolbtnDirClick(Sender: TObject);
 var point,pointa:Tpoint;
begin
    point.x:=ToolbtnDir.width div 3;
    point.y:=ToolbtnDir.height-10;
    pointa:=ToolbtnDir.ClientToScreen(point);
    PopUpMenuWorkDir.Popup(pointa.X,pointa.y);
 end;
procedure TMain.ForumClick(Sender: TObject);
var res:Thandle;
begin
   OpenDialog.Filter:=' *.doc;*.pdf|*.doc;*.pdf|all files (*.*)|*.*' ;
   OpenDialog.FileName:='';
  if sLanguage='RUS' then OpenDialog.InitialDir:=CommonNanoeduDocumentsPath+'FAQ\rus'
                     else OpenDialog.InitialDir:=CommonNanoeduDocumentsPath+'FAQ\eng';
  if OpenDialog.execute then
   begin
    res:= ShellExecute(handle,nil,Pchar(Opendialog.fileName),nil,nil,SW_RESTORE);
   end;
end;

procedure TMain.GalleryShowClick(Sender: TObject);
  var
    res:Thandle;
  filename:string;
begin
filename:='GalleryShow.ppsx';
if  siLang1.ActiveLanguage=2 then  filename:='GalleryShow_R.ppsx';
  if not directoryexists(ScanGalleryDir) then
  begin MessageDlgCtr(strm34{'Gallery directory do not exists!!'},mtwarning,[mbOk],0);   exit; end;
     res:= ShellExecute(handle,nil,Pchar(ScanGalleryDir+'\'+filename),nil,nil,SW_RESTORE);
end;

procedure TMain.GetDeviceId1Click(Sender: TObject);
var fID:integer;
begin
 (*    if assigned(NanoEdu) then
      begin
          fID:=Nanoedu.GetAdapterID;
           case fID of
          AdNotConnectedId: ; // exit messages
          AdNanoId,AdReniId,AdSEMId: if Nanoedu.TestAdapterIsNew then
                     begin
                      SetDefaultIniFilesPath;
                      AdapterService:= TAdapterService.Create(Application);   // если нет, открыть форму и записать в адаптер из Базы
                      AdapterService.ShowModal;                              // или создать новую папку сканера в базе
                     end;
          AdDemoId:  SetDemoIniFilesPath;
               end;
      end;
      
        FormTest:=TFormTest.create(self);  *)
end;

procedure TMain.FormShow(Sender: TObject);
var i,l:integer;
FiletoOpen:string;
begin
(*    flgShowWellComeWindow:=ShowWellComeWindow;
    itemShowWellComeWindow.Checked:=flgShowWellComeWindow;
   if flgShowWellComeWindow then  WellCome:=TWellCome.Create(application);
     SetCurrentDir(WorkDirectory);
 if not assigned(NoFormUnitLoc) then NoFormUnitLoc:=TNoFormUnitLoc.Create(application);
  InitParameters;
    L:=  ParamCount;
   if L>=1 then
   begin
    FiletoOpen:=ParamStr(1);
    if FiletoOpen<>'-m' then
       CreateMDIChild(Sender,FiletoOpen,1,true);
   end;
 *)
  timerstartprogram.Enabled:=true;

//  FlgActiveSendtoIA:=SendScanto.visible;
 end;


procedure TMain.Manual1Click(Sender: TObject);
  var    res:Thandle;
  Initialdir,filename:string;
begin
 // OpenDialog.Filter:='Manuals *.doc;*.pdf|*.doc;*.pdf|all files (*.*)|*.*' ;
(*  OpenDialog.FileName:='';
   if sLanguage='RUS' then OpenDialog.InitialDir:=CommonNanoeduDocumentsPath+'docs\rus'
                      else OpenDialog.InitialDir:=CommonNanoeduDocumentsPath+'docs\eng';
  if OpenDialog.execute then
   begin
    res:= ShellExecute(handle,nil,Pchar(Opendialog.fileName),nil,nil,SW_RESTORE);
  end;
*)
  Manual1.enabled:=false;
  if sLanguage='RUS'  then
  begin
   InitialDir:=CommonNanoeduDocumentsPath+'docs\rus';
     case ComboBoxLevel.ItemIndex of
  0: filename:=InitialDir+'\Experiment\'+tutexperiment;//Описание работы Nanoeducator LE.pdf';
  1: filename:=InitialDir+'\Simulator\' +tutsimulator; //Описание работы Тренажер.pdf'
            end;
  end
  else
  begin
   InitialDir:=CommonNanoeduDocumentsPath+'docs\eng';
     case ComboBoxLevel.ItemIndex of
  0: filename:=InitialDir+'\Experiment\'+tutexperiment;//'Manual Nanoeducator LE.pdf';
  1: filename:=InitialDir+'\Simulator\' +tutsimulator;//'Manual Simulator.pdf'
            end;
  end;
  if FileExists(fileName) then
  begin
  //two monitors
    res:= ShellExecute(handle,nil,Pchar(fileName),nil,nil,SW_RESTORE);
  end
                          else  silang1.MessageDlg(Filename+strfilenotexists,mtWarning ,[mbOK],0);

     Manual1.enabled:=true;
end;

procedure TMain.TimerDetectMTPDevTimer(Sender: TObject);
begin
 TimerDetectMTPDev.Enabled:=false;
 ActionNew.Hint:=strHintNewOK;
 if  CurrentUserLevel<>'Demo' then
 begin
  Actionnew.Enabled:=FindControler;// and FindNanoeduAtMyPC;
  if not Actionnew.Enabled then
  begin
   inc(TimeLimitDetectDev);
   if TimeLimitDetectDev>=5 then
    begin
     ActionNew.Hint:=strHintNewTurnon;
     FormStartWork:=TFormStartWork.Create(self);
     FormStartWork.Show;
     TimeLimitDetectDev:=0;
    end
    else begin TimerDetectMTPDev.Enabled:=true;  end;
  end
  else
  begin
   ActionNew.Hint:=strHintNewOK;
   {$IFDEF DEBUG}
      if assigned(FormLog) then   Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_379' (* 'NanoeducatorLE controler is turned on!' *) ));
    {$ENDIF};
  end;
 end
 else
 begin
  // TimerDetectMTPDev.Enabled:=false;
   ActionNew.Enabled:=true;
 end;
end;

procedure TMain.TimerStartProgramTimer(Sender: TObject);
  var flgRScor:boolean;
  i,l:integer;
FiletoOpen:string;
begin
    timerstartprogram.Enabled:=false;
    flgShowWellComeWindow:=ShowWelComeWindow;
    itemShowWellComeWindow.Checked:=flgShowWellComeWindow;
 if flgShowWellComeWindow       then WellCome:=TWellCome.Create(application);
     SetCurrentDir(WorkDirectory);
 if not assigned(NoFormUnitLoc) then NoFormUnitLoc:=TNoFormUnitLoc.Create(application);
  InitParameters;
    L:=  OpenParamList.Count;
   for I := 0 to L-1 do
   begin
       flgRSCor:=MakeFileRSCorrection(OpenParamList[i]);
       CreateMDIChild(Sender,OpenParamList[i],1,false{true},flgRSCor);
       application.ProcessMessages;
   end;
   OpenParamList.Free;
   TimerDetectMTPDev.Enabled:=true;
end;

procedure TMain.ToolbtnChooseSampleClick(Sender: TObject);
begin
 if (not flgApproachOK) and flgstopScan then
    begin
    ChooseSample:= TChooseSample.Create(Application);
    ChooseSample.ShowModal;
    end
    else
    if not flgstopScan then ShowMessage(siLang1.GetTextOrDefault('IDS_321' (* 'Stop scanning before you choose #13 new sample!!' *) ))
    else if flgApproachOK then ShowMessage(siLang1.GetTextOrDefault('IDS_322' (* 'Rise tip before you choose #13 new sample!!' *) ));
         
    
end;

procedure TMain.ToolBtnClientClick(Sender: TObject);
begin
//   MainFormClient:=TMainFormClient.Create(Application);
end;

procedure TMain.ComboBoxLevelChange(Sender: TObject);
begin
   ComboBoxLevelSelect(Sender);
end;

procedure TMain.ComboBoxLevelSelect(Sender: TObject);
begin
    ProcComboboxLevelSelect(Sender);
end;

procedure TMain.ProcComboboxLevelSelect(Sender: TObject);
begin
if   FlgCurrentUserLevel<>ComboBoxLevel.ItemIndex then
begin
 if  ToolScanBar.visible  then
  begin
    if not FlgStopScan then
    begin
       ShowMessage(strm28{'Stop Scanning before exit!!!'});
       ComboBoxLevel.ItemIndex:=FlgCurrentUserLevel;
       exit;
    end;
    if assigned(ScanWnd) then
    begin
      ScanWnd.Close;
    end;
   if assigned(Approach) then
    if not FlgStopApproach then
    begin
      MessageDlgCtr(strm33{'Stop approach before exit!!!'}, mtInformation,[mbOk],0);
      ComboBoxLevel.ItemIndex:=FlgCurrentUserLevel;
      exit;
    end
    else
    begin
      Approach.close;
    end;
    if assigned(AutoResonance) then   AutoResonance.close;
    Application.ProcessMessages;
    RunCloseExecute(Sender);
 end
 else
 if Assigned(FrBeginner) then
  begin
   silang1.MessageDlg(strm32{'Close Control Panel!'}, mtInformation,[mbOk], 0);
   ComboBoxLevel.ItemIndex:=FlgCurrentUserLevel;
   exit
  end;
   PanelUnit.Visible:=true;
   FlgCurrentUserLevel:=ComboBoxLevel.ItemIndex;
                case FlgCurrentUserLevel of
Beginner:begin
           FlgDataScannerHaveRead:=false;
           ActionNew.Enabled:=false;
           CurrentUserLevel:='Beginner';
           WorkNameFileMaskCur:= WorkNameFileMaskDef;
           PanelUnit.Visible:=false;
           ComboBoxLevel.Hint:=siLang1.GetTextOrDefault('IDS_84' (* 'The Beginner User' *) );
           TimerDetectMTPDev.Enabled:=true;
          end;
Advanced:begin
           FlgDataScannerHaveRead:=false;
           ActionNew.Enabled:=false;
           ActionChooseSample.Visible:=false;
           CurrentUserLevel:='Advanced';
           WorkNameFileMaskCur:= WorkNameFileMaskDef;
           ComboBoxLevel.Hint:=siLang1.GetTextOrDefault('IDS_88' (* 'The Advanced User' *) );
           TimerDetectMTPDev.Enabled:=true;
          end;
    Demo:begin
           TimerDetectMTPDev.Enabled:=false;
           FlgDataScannerHaveRead:=false;
           CurrentUserLevel:='Demo';
           ActionNew.Enabled:=true;
           ActionChooseSample.Visible:=true;
           WorkNameFileMaskCur:= WorkNameFileMaskDemo;
           ComboBoxLevel.Hint:=siLang1.GetTextOrDefault('IDS_92' (* 'The Demo version' *) );
          end;
                 end;
  end; //change level;
end;

procedure TMain.ComboBoxSFMSTMSelect(Sender: TObject);
begin
  ScanParams.flgSpectr:=false;
      case   ComboBoxSFMSTM.ItemIndex of
  0: begin
       STMflg:=false;
       addcaption:=siLang1.GetTextOrDefault('IDS_3' (* '  Scanning Tunneling Microscope; ' *) );
       ComboBoxSFMSTM.Hint:=siLang1.GetTextOrDefault('IDS_147' (* 'Scanning Tunneling Microscope' *) );
        case FlgCurrentUserLevel of
  Beginner,
  Advanced: ;
  Demo    : begin
             if ToolScanBar.visible then
             begin
               DemoSample:='sfm\samples\'+'cd_pits';
               ChooseSample:= TChooseSample.Create(Application);
               ChooseSample.ShowModal;
             end;
           end;
       end;
       if  assigned(nanoedu) then SFMExecute;//(Sender);
     {$IFDEF DEBUG}
        Formlog.memolog.Lines.add('Set SFM');
     {$ENDIF}
     end;
  1: begin
         STMflg:=true;

   case FlgCurrentUserLevel of
  Beginner,
  Advanced: ;
  Demo    : begin
            if ToolScanBar.visible then
             begin
              DemoSample:='stm\samples\'+'cd_pits';
              ChooseSample:= TChooseSample.Create(Application);
              ChooseSample.ShowModal;
             end;
           end;
       end;
       addcaption:=siLang1.GetTextOrDefault('IDS_3' (* '  Scanning Tunneling Microscope; ' *) );
       ComboBoxSFMSTM.Hint:=siLang1.GetTextOrDefault('IDS_147' (* 'Scanning Tunneling Microscope' *) );
       silang1.MessageDlg(strm21{'Attention!'}+#13+strm22{'STM is intendend for working with conductive samples,otherwise the probe will be destroyed!!'}+#13+strm23{'Check up  value of a voltage.'},mtWarning ,[mbOK],0);
       if  assigned(nanoedu) then STMExecute;//(Sender);
    {$IFDEF DEBUG}
        Formlog.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_390' (* 'Set STM' *) ));
    {$ENDIF}
     end;
      end;
end;

procedure TMain.MenuItemSelectSchemeClick(Sender: TObject);
begin
    FormProgramSettings:= TFormProgramSettings.Create(Self);
    FormProgramSettings.ShowModal ;
end;

procedure TMain.SetLanguage1Click(Sender: TObject);
var res:integer;
videofileName:string;
begin
 if (MDIChildCount>0) then
 begin
  silang1.MessageDlg(strm18{'Close all windows!'},mtWarning ,[mbOK],0);
  exit
 end;
  if not assigned(frLang) then
   begin
     frLang:=TfrLang.Create(self);
     res:=frLang.ShowModal;
    if res=mrOK then
    begin
     if   sLanguage='RUS' then
      begin
        Application.HelpFile :=ExeFilePath+'NanoEduHelp.chm';
        tutsimulator:=tutsimulatorrus;
        tutexperiment:=tutexperimentrus;
        tutvideo:=tutvideorus;
        ReportTemplPath:=CommonNanoeduDocumentsPath+ReportTemplRDefPath;
        Lang:=2;
      end
      else
      begin
        Lang:=1;
        sLanguage:='ENG';
        tutsimulator:=tutsimulatoreng;
        tutexperiment:=tutexperimenteng;
        tutvideo:=tutvideoeng;
        Application.HelpFile :=ExeFilePath+'NanoEduHelpEng.chm';
        ReportTemplPath:=CommonNanoeduDocumentsPath+ReportTemplEDefPath;
      end;
      if  assigned( WorkView) then
       begin
          WorkView.close;
          Application.ProcessMessages;
          CreateWorkViewWnd(true);
       end;
         Application.ProcessMessages;
       end;

  if assigned(NoFormUnitLoc) then
  begin
   NoFormUnitLoc.siLangDispatcher1.ActiveLanguage:=Lang;
   NoFormUnitLoc.siLangLinked1ChangeLanguage(Sender);
  end;
   siLang1.ActiveLanguage:=Lang;
   siLangDispatcher1.ActiveLanguage:=lang;
 end;
  InitParametersAxes;
   if sLanguage='RUS' then
  begin
   videofileName:=CommonNanoeduDocumentsPath+'video\rus\'+tutvideorus;//'\3D_Модель_NanoEducator_LE.mp4'
  end
  else
  begin
   videofileName:=CommonNanoeduDocumentsPath+'video\eng\'+tutvideoeng;//'\3D_Model_NanoEducator_LE.mp4'
  end;
   if Fileexists(videofilename) then VideoMenu.visible:=true
                                else VideoMenu.visible:=false;
 //                               VideoMenu.visible:=true;

//  NoFormUnitLoc.UpdateStrings;
end;

procedure TMain.SetpathtofirmVideoCameraClick(Sender: TObject);
begin
 VideoSoftSetting:=TVideoSoftSetting.Create(application);
 VideoSoftSetting.ShowModal
(* if  =mrOK then
 begin
     FirmCameraSoftPath:=ChangePathResult;
     SaveVideoParams;
 end;
 *)
end;

function TMain.SFMExecute:boolean;//(Sender: TObject);
var error:integer;
   fID,taskdata:integer;
begin
        result:=false;
        PIDParams:=PIDSFMParams;
        STMflg:=false;
        addcaption:=siLang1.GetTextOrDefault('IDS_6' (* '  Scanning Force Microscope; ' *) );
        Resonance.visible:=true;
        ComboBoxSFMSTM.Hint:=siLang1.GetTextOrDefault('IDS_280' (* 'Scanning Force Microscope' *) );
        Scanning.Visible:=false;//true;
        Training.Visible:=not FlgApproachOK;
        Landing.Visible:=false;//true;
        Application.ProcessMessages;
        FlgApproachOK:=False;
        FlgStopScan:=True;
        SetIntActOnProgr:=False;
        if flgfirsttimeSFM then UsersParamsDef
                           else
                           begin
                            UsersParamsLast(ConfigUsersIniFile);
                            ScanParams.flgFastSimulator:=false;
                           end;
        flgfirsttimeSFM:=false;
        FreeAndNil(NanoEdu);
             case FlgCurrentUserLevel of
  Beginner,
  Advanced: NanoEdu:=TSFMNanoEdu.Create;
  Demo    : begin
              NanoEdu:=TSFMNanoEduDemo.Create;
            end;
                    end;     //case
           case  PrepareScannerData of
   0:  if assigned(formInitUnitEtape) then formInitUnitEtape.TabSheetErr.TabVisible:=false; //ok
   1:  begin
        if assigned(NanoeduDevice)    then
         begin
          if assigned(formInitUnitEtape) then
          begin
           formInitUnitEtape.PageControl1.ActivePageIndex:=1;
           formInitUnitEtape.TabSheetErr.TabVisible:=true;
          end;
          Reloadscheme;
          if PrepareScannerData=1 then
            begin
              if assigned(formInitUnitEtape) then formInitUnitEtape.memolog.Lines.add(siLang1.GetTextOrDefault('IDS_17' (* 'Adapter is not connected!' *) ));
              silang1.MessageDlg(siLang1.GetTextOrDefault('IDS_17' (* 'Adapter is not connected!' *) )+
                                                                            #13+siLang1.GetTextOrDefault('IDS_19' (* 'Turn off Controller.' *) )+#13+
                                                                            siLang1.GetTextOrDefault('IDS_22' (* 'Test connection Head-Controller!' *) ),mtWarning,[mbOk],0);

              RunCloseExecute(nil);
              exit;
            end;
          formInitUnitEtape.PageControl1.ActivePageIndex:=0;
          formInitUnitEtape.TabSheetErr.TabVisible:=false;
  end;
       end;
   999:  begin
            RunCloseExecute(nil);
            ActionNew.Enabled:=true;
            exit;
         end;
            end;
(*         if flgfirsttimeSFM then ApproachParamsDef
                              else ApproachParamsLast(ConfigUsersIniFile);
         flgfirsttimeSFM:=false;
 *)        
         Scanning.Hint:=siLang1.GetTextOrDefault('IDS_4' (* 'Make Resonance and Landing before Scanning' *) );
         Landing.Hint:=siLang1.GetTextOrDefault('IDS_5' (* 'Make Resonance before Landing' *) );
         Caption:=basecaption+addcaption+addworkdirectory;
         result:=true;
end;

procedure TMain.LandingSlowExecute(Sender: TObject);
var h:HWND;
 res:cardinal;
 Result:boolean;
 R:TRect;
 StartInfo: TStartupInfo;
 ProcessHandle : THandle;
 ProcessID: Integer;
 ProcInfo: TProcessInformation;
    CmdLine: ShortString;
begin
 Landing.Visible:=false;
 Training.Visible:=false;
 Resonance.Visible:=false;
 Scanning.Visible:=false;
 if assigned(FormScannerTraining) then
 begin
   silang1.MessageDlg(strm42, mtInformation,[mbOk], 0);
   Landing.Visible:=true;
   exit;
 end;
//
if ApproachParams.flgAutorunCamera then
begin
 if   flgVideoOscConflict then
 begin
  if EXE_Running('Oscilloscope.exe', false) then
  begin
   h:=FindWindow(nil,'Oscilloscope');
   if  h<>0 then
   begin
    GetWindowThreadProcessID(h, @ProcessID);
    ProcessHandle := OpenProcess(PROCESS_TERMINATE, FALSE, ProcessId);
    if not (ProcessHandle=0) then
    begin
     TerminateProcess(ProcessHandle,0);
     CloseHandle(ProcessHandle);
    end;
   end;
  end;
 end;
end;

 Approach:=TApproach.Create(Application);

 Application.ProcessMessages;

 if ApproachParams.flgAutorunCamera then
 begin
  if  FlgCurrentUserLevel<>Demo then
  begin
   if not boolean(flgRunFirmCamera) then
   begin
    h:=findwindow(nil,Pchar(strm41{'MSVideo'}));
    if h=0  then
    begin
    if GetModuleHandle('MSVideoLib.dll')=0 then
     begin
      @StartVideo:=nil;
      @StopVideo:=nil;
      LibVideoHandle:=0;
      LibVideoHandle:=LoadLibrary(PChar(ExeFilePath+'MSVideoLib.dll'));
       if  LibVideoHandle<=32 then begin
                                    silang1.MessageDlg('Library MSVideoLib.dll Load Error'+ IntToStr(GetLastError)+'!. Test USB Connection. ',mtWarning,[mbOk],0);
                                    exit;
                                   end
                              else
                                  begin
                                    StartVideo:=GetProcAddress(LibVideoHandle,'StartVideo');
                                    StopVideo:=GetProcAddress(LibVideoHandle,'StopVideo');
                                  end;
     end;
       StartVideo(Application.Handle,self.Handle,WM_UserCloseVideo,Lang,ConfigUsersIniFilePath);
       h:=findwindow(nil,Pchar(strm41{'MSVideo'}));
      if h<>0  then
       begin
        GetWindowRect(h,R);
        SetWindowPos(h,HWND_TOPMost,Main.Left+5,Main.Top+Main.ClientHeight-(R.Bottom-R.Top),50,50,SWP_NOSIZE or SWP_SHOWWINDOW);
       end;
    end;
    end
    else //run firm soft
    begin
     RunFirmSoftVideoCamera;
    end;
   end;
 end;
end;

procedure TMain.RepTemplateClick(Sender: TObject);
begin
end;
(*
procedure TMain.ReadDiviceHeader1Click(Sender: TObject);
begin
   ReadScannerIniFromMLPC(1);
end;

procedure TMain.ReadfromDevice1Click(Sender: TObject);
var   MLPCNPages:integer;
begin
(*   MLPCStartPage:=1;
   MLPCNPages:=2;
   flgControlXData:=True;
   ReadScannerIniFromMLPC(MLPCStartPage,  MLPCNPages);

end;

procedure TMain.ReadXModParams1Click(Sender: TObject);
var  StartPage,pagesnmb:integer;
begin
 (*   StartPage:=pgXmodeParams;
    pagesnmb:=1;
    Nanoedu.ReadFromMLPCMethod(StartPage,pagesnmb);
    Nanoedu.Method.Launch;
  
end;
*)
procedure TMain.Adapter1Click(Sender: TObject);
begin
   AdapterService:=TAdapterService.Create(self);
   AdapterService.ShowModal;
end;

procedure TMain.ReportGeneratorClick(Sender: TObject);
function IsWordInstalled: Boolean;
var
  Reg: TRegistry;
//  s: string;
begin
  Reg := TRegistry.Create; 
  try 
    Reg.RootKey := HKEY_CLASSES_ROOT; 
    Result := Reg.KeyExists('Word.Application');
  finally 
    reg.Free;
  end;
end; 
begin
 if  not IsWordInstalled then  ShowMessage(siLang1.GetTextOrDefault('IDS_412' (* 'MS Word is  not installed.' *) ))
                         else
                          begin
                           ReportForm:=TReportForm.create(self);
                           ReportGenerator.Enabled:=false;
                          end;
end;



procedure TMain.ToolBtnGalClick(Sender: TObject);
begin
 OpenItem.Enabled:=False;
ActionOpen.Enabled:=False;
ActionOpen.visible:=False;
// ForceCurrentDirectory :=True;
// SetCurrentDir(ScanGalleryDir);
 LoadDefPaletName(DefPaletName);    // Reads ConfigIni File
 LoadPalette(DefPaletName);         // Reads PaletteIni File;
 EvalPaletteLines();
 if assigned(DirView) then DirView.Close;
  DirView:=TfrSPMViewFull.Create(Self,ScanGalleryDir,{DirView,}2);
end;


(*procedure TMain.ToolBtnIniFilesClick(Sender: TObject);
    var point,pointa:Tpoint;
begin
    point.x:=ToolbtnINifiles.width div 3;
    point.y:=ToolbtnINifiles.height-10;
    pointa:=ToolbtnINifiles.ClientToScreen(point);
    PopUpMenuIniFiles.Popup(pointa.X,pointa.y);
end;
 *)
procedure TMain.ToolBtnLogClick(Sender: TObject);
begin
 if assigned(Formlog) then  Formlog.Show;
end;


procedure TMain.ToolBtnSampleClick(Sender: TObject);
begin
   ChooseSample:= TChooseSample.Create(Application);
   ChooseSample.ShowModal;
end;

procedure TMain.ToolButtonRStestClick(Sender: TObject);
begin
if flgCurrentUserlevel<>demo then
begin
 ToolButtonRStest.visible:=false;
 FormRenishawOsc:= TFormRenishawOsc.Create(Application)
end
else   MessageDlgCtr(strm1{'Demo version.!!'}, mtInformation,[mbOk],0);
end;

procedure TMain.TooltnChooseSampleClick(Sender: TObject);
begin
    if (not FlgApproachOK) and flgStopScan then
       begin
         ChooseSample:= TChooseSample.Create(Application);
         ChooseSample.ShowModal;
       end
    else if not flgStopScan then ShowMessage(siLang1.GetTextOrDefault('IDS_101' (* 'Stop Scanning before you change the sample!' *) ))
    else if FlgApproachOK   then ShowMessage(siLang1.GetTextOrDefault('IDS_102' (* 'Rise the tip before you change the sample!' *) ))

end;

procedure TMain.LandingFastExecute(Sender: TObject);
 var H:HWND;
    R:TRect;
 ProcessHandle : THandle;
 ProcessID: Integer;
 ProcInfo: TProcessInformation;
begin
 Landing.Visible:=false;
 Training.Visible:=false;
 Resonance.Visible:=false;
 Scanning.Visible:=False;
 Application.processmessages;
 if assigned(FormScannerTraining) then
 begin
   silang1.MessageDlg(strm42, mtInformation,[mbOk], 0);
   Landing.Visible:=true;
   exit;
 end;
if ApproachParams.flgAutorunCamera then
begin
 if EXE_Running('Oscilloscope.exe', false) then
 begin
  h:=FindWindow(nil,'Oscilloscope');
  if  h<>0 then
  begin
   GetWindowThreadProcessID(h, @ProcessID);
   ProcessHandle := OpenProcess(PROCESS_TERMINATE, FALSE, ProcessId);
   if not (ProcessHandle=0) then
   begin
    TerminateProcess(ProcessHandle,0{4});
    CloseHandle(ProcessHandle);
   end;
  end;
 end;
end;

//  FastLand:=TFastLand.Create(Application);
    Application.ProcessMessages;
 if ApproachParams.flgAutorunCamera then
 begin
  if  FlgCurrentUserLevel<>Demo then
  Begin
   h:=findwindow(nil,Pchar(strm41{'MSVideo'}));
   if h=0  then
    begin
    if GetModuleHandle('MSVideoLib.dll')=0 then
     begin
      @StartVideo:=nil;
      @StopVideo:=nil;
      LibVideoHandle:=0;
      LibVideoHandle:=LoadLibrary(PChar(ExeFilePath+'MSVideoLib.dll'));
       if  LibVideoHandle<=32 then begin
                                    silang1.MessageDlg('Library MSVideoLib.dll Load Error'+ IntToStr(GetLastError)+'!. Test USB Connection. ',mtWarning,[mbOk],0);
                                    exit;
                                   end
                              else
                                  begin
                                    StartVideo:=GetProcAddress(LibVideoHandle,'StartVideo');
                                    StopVideo:=GetProcAddress(LibVideoHandle,'StopVideo');
                                  end;
     end;
       StartVideo(Application.Handle,self.Handle,WM_UserCloseVideo,Lang,ConfigUsersIniFilePath);
       h:=findwindow(nil,Pchar(strm41{'MSVideo'}));
      if h<>0  then
       begin
        GetWindowRect(h,R);
        SetWindowPos(h,HWND_TOPMost,Main.Left+5,Main.Top+Main.ClientHeight-(R.Bottom-R.Top),50,50,SWP_NOSIZE or SWP_SHOWWINDOW);
       end;
    end;
  end;
 end;
end;

procedure TMain.FileInfItemClick(Sender: TObject);
begin
   if  not assigned( FileHeaderForm)then
     FileHeaderForm:=TFileHeaderForm.Create(Application,ActiveGLW.FileNameGL)
   else
    begin
     FileHeaderForm.ReadParam(ActiveGLW.FileNameGL);
     FileHeaderForm.Refresh;
   end;
end;

procedure TMain.SaveAsASCIIFileClick(Sender: TObject);
var
   NewFile,OldFile,TmpName:string;
   CurDir,Dir:string;
begin
   siSaveDialog:=TsiSaveDialog.Create(self);
   siSaveDialog.siLang:=siLang1;
   siSaveDialog.Options:=[ofOverWritePrompt,ofShowHelp,ofEnableSizing];
   siSaveDialog.siLang.ActiveLanguage:=lang;
   CurDir:=GetCurrentDir;
   siSaveDialog.FilterIndex:=0;
   ForceCurrentDirectory :=True;
   siSaveDialog.DefaultExt:='txt';
   siSaveDialog.Filter:=' text file *.txt|*.txt';
 if (ActiveMDIChild is TfrmGl) then
 begin
  if siSaveDialog.Execute then
          begin
          NewFile:=siSaveDialog.FileName;
          Dir:=ExtractFileDir(NewFile);
          if not DirectoryExists(Dir)then CreateDir(Dir);
           TmpName:=ExtractFileName(TfrmGL(ActiveMDIChild).TopoSPM.ImFileName);
              OldFile:=TfrmGL(ActiveMDIChild).PathFileNameGL+TmpName;
              ChDir(CurDir);
               if OldFile=NewFile then
                begin
                 silang1.messageDlg(siLang1.GetTextOrDefault('IDS_426' (* 'Error!!' *) )+#13+siLang1.GetTextOrDefault('IDS_427' (* 'Change file name' *) ),mtwarning,[mbOk],0);
                 exit;
                end;
           TfrmGL(ActiveMDIChild).SaveAsASCII(NewFile);
           end;
 end
 else if (ActiveMDIChild is TSection) then
 begin
   if siSaveDialog.Execute then
          begin
          NewFile:=siSaveDialog.FileName;
          (ActiveMDIChild as TSection).SaveSectionAsASCII(NewFile);
         end;
 end
  else if  (ActiveMDIChild is TAutoResonance) then
     begin
       if siSaveDialog.Execute then
         begin
          NewFile:=siSaveDialog.FileName;
          (ActiveMDIChild as TAutoResonance).SaveAmplitudesAsASCII(NewFile);
         end;
     end
  else if (ActiveMDIChild is TSpectroscopy) then
     begin
       if siSaveDialog.Execute then
         begin
          NewFile:=siSaveDialog.FileName;
          (ActiveMDIChild as TSpectroscopy).SaveAsASCII(NewFile);
         end;
     end
       else if (ActiveMDIChild is TSpectroscopyTerra) then
     begin
       if siSaveDialog.Execute then
         begin
          NewFile:=siSaveDialog.FileName;
          (ActiveMDIChild as TSpectroscopyTerra).SaveAsASCII(NewFile);
         end;
     end;

 FreeAndNil(siSaveDialog);
end;

procedure TMain.ToolBtnDrvClick(Sender: TObject);
    var point,pointa:Tpoint;
begin
    point.x:=ToolbtnDrv.width div 3;
    point.y:=ToolbtnDrv.height-10;
    pointa:=ToolbtnDrv.ClientToScreen(point);
   PopUpMenuServ.Popup(pointa.X,pointa.y);
end;

procedure TMain.ToolBtnExpMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var point,pointa:Tpoint;
  begin
    point.x:=x;
    point.y:=y;
    pointa:=ToolBtnExp.ClientToScreen(point);
    PopupMenuExp.Popup(pointa.X,pointa.y);
end;
(*
procedure TMain.ToolBtnDrvClick(Sender: TObject);
begin
  MessageDlgCtr(siLang1.GetTextOrDefault('strstrm10' (* 'Turn on Controller!!' *} ), mtInformation,[mbOk],0);
 if  CurrentUserLevelFlg<>Demo then
           ExecAndWaitDrivers(Pchar(ExeFilePath)+'\DriverSetUp\dsetup.exe','','',SW_showNORMAL)
           else MessageDlgCtr(siLang1.GetTextOrDefault('IDS_98' (* 'Demo version.!!' *} ), mtInformation,[mbOk],0);
end;
*)
procedure TMain.About2Click(Sender: TObject);
 var About:TFormAbout;
 begin
    About:=TFormAbout.Create(Application);
    About.Show;
end;

procedure TMain.itemShowWellcomeWindowClick(Sender: TObject);
begin
   flgShowWellComeWindow:=not flgShowWellComeWindow;
   itemShowwellcomewindow.Checked:= not itemShowwellcomewindow.Checked;
   Application.ProcessMessages;
   if assigned(WellCome) then WellCome.CheckBoxView.Checked:=flgShowWellComeWindow
   else   begin WellCome:=TWellCome.Create(application);end;
end;


procedure TMain.ThreadDone(var AMessage : TMessage);           // Ola
begin
   if  (mReadingMLPC=AMessage.WParam)then
   begin
    if assigned(ReadFromAdapterThread) then
    begin
       ReadFromAdapterThread:=nil;
       ReadFromAdapterThreadActive := false;
    end;
    if assigned(NanoEdu.Method) then
    begin
      NanoEdu.Method.FreeBuffers;
      FreeAndNil(NanoEdu.Method);
    end;
    if flgAllDataReadFromAdapter then
    begin
     LoadScannerParams(flgAllDataReadFromAdapter);
     SetUnit;
     UnitInit;
     if not FindScannerInDbase then
     begin
      if MessageDlg(siLang1.GetTextOrDefault('IDS_372' (* 'Scanner=' *) )+HardWareOpt.ScannerNumb+ siLang1.GetTextOrDefault('IDS_373' (* ' doesn't exist in Dbase! Add to DBase?' *) ), mtInformation,[mbOK,mbNo], 0)=mrOk
       then  AdScannerToDbase;
     end;
     if assigned(formInitUnitEtape) then
     begin
      formInitUnitEtape.CheckListBox.Checked[idreadparams]:=true;
      formInitUnitEtape.ProgressBar.position:=10+idreadparams;
     end;
     silang1.MessageDlg(siLang1.GetTextOrDefault('IDS_431' (* 'Data scanner from Adapter has read!' *) ), mtInformation,[mbYes], 0);
     FlgDataScannerHaveRead:=true;
    end;
  end;

  if  (mGetDeviceId=AMessage.WParam)then
  begin
    if assigned(GetDevIdThread) then
     begin
        GetDevIdThread:=nil;
        GetDevIdThreadActive := false;
        if assigned(formInitUnitEtape) then
        begin
         formInitUnitEtape.CheckListBox.Checked[idgetadapterid]:=true;
         formInitUnitEtape.ProgressBar.position:=idgetadapterid;
        end;
     end;
    if assigned(NanoEdu.Method) then
    begin
      NanoEdu.Method.FreeBuffers;
      FreeAndNil(NanoEdu.Method);
    end;
  end;
    if  (mGetControllerParams=AMessage.WParam)then
  begin
    if assigned(GetControllerParamsThread) then
     begin
        GetControllerParamsThread:=nil;
        GetControllerParamsActive := false;
      end;
    if assigned(NanoEdu.Method) then
    begin
      NanoEdu.Method.FreeBuffers;
      FreeAndNil(NanoEdu.Method);
      TestControllerParams;
    end;
  end;

  if  (mMemWriteDone=AMessage.WParam)then
  begin
    if assigned(WriteToAdapterThread) then
     begin
        WriteToAdapterThread:=nil;
        WriteToAdapterThreadActive := false;
     end;
   if assigned(NanoEdu.Method) then
    begin
      NanoEdu.Method.FreeBuffers;
      FreeAndNil(NanoEdu.Method);
    end;
  end;
end;
  initialization
  finalization
   CoUninitialize;
     ires:=FindFirst(TempDirectory+'*.tmp',faAnyFile,sSR);
     while ires = 0 do
        begin
          AssignFile(FF,TempDirectory+sSR.Name);
          Erase(FF);
          ires:=FindNext(sSR);
        end;
     FindClose(sSR);
     ires:=FindFirst(TempDirectory+'*.spm',faAnyFile,sSR);
     while ires = 0 do
        begin
          AssignFile(FF,TempDirectory+sSR.Name);
          Erase(FF);
          ires:=FindNext(sSR);
        end;
    FindClose(sSR);
  //   SetFileAttribute_ReadOnly(true);
 end.



















