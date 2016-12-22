{B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O-,P+,Q+,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
unit frScanWnd;
//corrected 16/12/22
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls,Math, StdCtrls,StrUtils,Buttons, Menus,ShellApi,
  ImgList, ExtDlgs, TeeProcs, TeEngine, Chart, Series, ClipBrd,
  GlobalType, CSPMVar,frSignalsMod, AppEvnts, RuleMod4, XPMan, siComp, siLngLnk,
  siDialog,
     {$IFDEF DEBUG}
              frDebug,
       {$ENDIF}
   ToolWin;

  const   CELL = 1;
  MaxSpeedValue=1000000;
type
  TScanWnd = class(TForm)
    PanelTop: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    MainMenu1: TMainMenu;
    Timer: TTimer;
    PanelDown: TPanel;
    Panel3: TPanel;
    PageCtlLeft: TPageControl;
    TabSheetSideL: TTabSheet;
    ImageSideL: TImage;
    TabSheetTopoL: TTabSheet;
    Panel4: TPanel;
    PageCtlRight: TPageControl;
    TabSheetTopoR: TTabSheet;
    TabSheetPhaseR: TTabSheet;
    TabSheetUAMR: TTabSheet;
    TabSheetSpectrR: TTabSheet;
    TabSheetCurR: TTabSheet;
    TabSheetFastTopo: TTabSheet;
    ImageFastTopo: TImage;
    TabSheetLitho: TTabSheet;
    TabSheetMatrix: TTabSheet;
    PanelMatrix: TPanel;
    PanelMatParam: TPanel;
    TabSheetTopoError: TTabSheet;
    BitBtnLoadIm: TBitBtn;
    Label7: TLabel;
    edNxM: TEdit;
    UpDown1: TUpDown;
    Label14: TLabel;
    EdNyM: TEdit;
    UpDown2: TUpDown;
    Label15: TLabel;
    EdStepXYM: TEdit;
    LabelAction: TLabel;
    ScrollBarLitho: TScrollBar;
    Label17: TLabel;
    Label18: TLabel;
    BitBtnProject: TBitBtn;
    PanelSpectr: TPanel;
    PanelRight: TPanel;
    PanelChart: TPanel;
    ImgRPanel: TPanel;
    TabSheetScanTran: TTabSheet;
    TabSheetSens: TTabSheet;
    BitBTnActLitho: TEdit;
    BitBtnTimeAct: TEdit;
    PanelLChart: TPanel;
    PanelChartL: TPanel;
    ImgLPanel: TPanel;
    ImgLChart: TChart;
    Series2: TLineSeries;
    RadioTypeLitho: TRadioGroup;
    UpDownAct: TUpDown;
    PanelChartError: TPanel;
    SpeedBtnPldelL: TSpeedButton;
    SpeedBtnSurDelL: TSpeedButton;
    SpeedBtnCapL: TSpeedButton;
    PanelChartLEr: TPanel;
    ImgLPanelEr: TPanel;
    ImgLChartEr: TChart;
    LineSeries1: TLineSeries;
    UpAct: TBitBtn;
    DownAct: TBitBtn;
    Panel2: TPanel;
    SpeedBtnCaptureL: TSpeedButton;
    SpeedBtnDelTopL: TSpeedButton;
    SpeedBtnSDelTopL: TSpeedButton;
    Panel11: TPanel;
    PanelFltr: TPanel;
    LabelFltr: TLabel;
    LabelNm: TLabel;
    ComboBoxFilter: TComboBox;
    LEditDz: TLabeledEdit;
    SpdBtnRecord: TSpeedButton;
    SpdBtnFB: TSpeedButton;
    ApplicationEvents: TApplicationEvents;
    Panel12: TPanel;
    Panel7: TPanel;
    LabelZ: TLabel;
    ZIndicatorScan: TRuleMod4;
    Label13: TLabel;
    LabelZV: TLabel;
    PanelSpectrF: TPanel;
    BitBtnClChart: TBitBtn;
    ComboBoxIZ: TComboBox;
    PanelScanF: TPanel;
    SpeedBtnDelTop: TSpeedButton;
    SpeedBtnSDelTop: TSpeedButton;
    SpeedBtnCapture: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedBtnPal: TSpeedButton;
    PopupMenu1: TPopupMenu;
    siLangLinked1: TsiLangLinked;
    Panel13: TPanel;
    Panel14: TPanel;
    ImageMatrix: TImage;
    RadioGroupBW: TRadioGroup;
    SpeedBtnContrast: TSpeedButton;
    SpeedBtnContrL: TSpeedButton;
    UpDownLithostep: TUpDown;
    CheckBoxDrift: TCheckBox;
    Label6: TLabel;
    Edit1: TMenuItem;
    Copytoclipboard1: TMenuItem;
    CheckBoxRS: TCheckBox;
    ToolBarScanWnd: TToolBar;
    StartBtn: TToolButton;
    RStartBtn: TToolButton;
    LandingBtn: TToolButton;
    OptionsBtn: TToolButton;
    SaveExpBtn: TToolButton;
    StopBtn: TToolButton;
    ToolBarHelp: TToolBar;
    AnimationBtn: TToolButton;
    HelpBtn: TToolButton;
    ImageList2: TImageList;
    Label19: TLabel;
    EditDacZSpeed: TEdit;
    LblEditDecay: TLabeledEdit;
    LabelDecayII: TLabel;
    PanelTopRight: TPanel;
    ScanParamsWND: TPanel;
    PageCtrlScan: TPageControl;
    TabSheetScanArea: TTabSheet;
    PanelScanM: TPanel;
    LblYmax: TLabel;
    BitBtnMgIn: TSpeedButton;
    BitBtnMgOut: TSpeedButton;
    BtnClear: TSpeedButton;
    BitBtnSq: TBitBtn;
    BitBtnRect: TBitBtn;
    BitBtnX0Y0: TBitBtn;
    BtnZoom: TBitBtn;
    PanelScanImage: TPanel;
    ImageScanArea: TImage;
    LblXmax: TLabel;
    TabSheetCurLine: TTabSheet;
    PageCtrlAdd: TPageControl;
    TabSheetCurScan: TTabSheet;
    Panel1: TPanel;
    SpeedBtnPlDel: TSpeedButton;
    BitBtnZoomCurLine: TBitBtn;
    TabSheetCurLineAdd: TTabSheet;
    BitBtn1: TBitBtn;
    ChartCurrentLine: TChart;
    SeriesLine: TFastLineSeries;
    SeriesAddLine: TFastLineSeries;
    BitBtnOpenLock: TBitBtn;
    Panel8: TPanel;
    PanelScanParam: TPanel;
    Label2: TLabel;
    PanelParam: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    FrameTime: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label16: TLabel;
    edNX: TEdit;
    EdNY: TEdit;
    EdScanRate: TEdit;
    EdX: TEdit;
    EdY: TEdit;
    UpDownNx: TUpDown;
    EdStepXY: TEdit;
    UpDownNy: TUpDown;
    CheckBoxStep: TCheckBox;
    ComboBoxPath: TComboBox;
    UpDownSpeed: TUpDown;
    EdScanRateBW: TEdit;
    UpDownSpeedBW: TUpDown;
    BitBtnLock: TBitBtn;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Image1: TImage;
    Panel20: TPanel;
    Panel21: TPanel;
    Image2: TImage;
    CheckBoxOnNets: TCheckBox;
    UpDownRS: TUpDown;
    ApplyBitBtn: TBitBtn;
    BoxFast: TGroupBox;
    LabelLineNum: TLabel;
    LabelHeight: TLabel;
    EdScanNMb: TEdit;
    EdDz: TEdit;
    SignalsMode: TSignalsMod;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImgRChart: TChart;
    Series1: TLineSeries;
    PanelTerra: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    lbleditTterra: TEdit;
    ScrollBarTTErra: TScrollBar;
    ScrollBarTime: TScrollBar;
    TabSheetProfiler: TTabSheet;
    SpdBtnOneFrame: TSpeedButton;
    procedure EditDacZSpeedKeyPress(Sender: TObject; var Key: Char);
    procedure EditDacZSpeedChange(Sender: TObject);
    procedure LblEditDecayKeyPress(Sender: TObject; var Key: Char);
    procedure LblEditDecayChange(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure ApplicationEventsActionExecute(Action: TBasicAction;    var Handled: Boolean);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure LabeledEditSpeedKeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEditSpeedChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure CheckBoxRSClick(Sender: TObject);
    procedure CopytoClipboard1Click(Sender: TObject);
    procedure CheckBoxDriftClick(Sender: TObject);
    procedure UpDownLithostepClick(Sender: TObject; Button: TUDBtnType);
    procedure UpDownRSClick(Sender: TObject; Button: TUDBtnType);
    procedure CheckBoxOnNetsClick(Sender: TObject);
    procedure RadioGroupBWClick(Sender: TObject);
    procedure SpeedBtnContrLClick(Sender: TObject);
    procedure SpeedBtnContrastClick(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure SpeedBtnPalClick(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure OptionsBtnClick(Sender: TObject);
    procedure ButtonSaveFileClick(Sender: TObject);
    procedure ApplyBtnClick(Sender: TObject);
    procedure PageCtlRightChange(Sender: TObject);
    procedure PageCtlLeftChange(Sender: TObject);
    procedure BitBtnPointClearClick(Sender: TObject);
    procedure TimerUp(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
    procedure edScanRateChange(Sender: TObject);
    procedure ImageScanAreaMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure ImageScanAreaMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure ImageScanAreaMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure BitBtnMClick(Sender: TObject);
    procedure edNXKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure edXChange(Sender: TObject);
    procedure edNXChange(Sender: TObject);
    procedure edNXKeyPress(Sender: TObject; var Key: Char);
    procedure EdXKeyPress(Sender: TObject; var Key: Char);
    procedure edYChange(Sender: TObject);
    procedure EdYKeyPress(Sender: TObject; var Key: Char);
    procedure EdStepXYChange(Sender: TObject);
    procedure EdNYChange(Sender: TObject);
    procedure EdNYKeyPress(Sender: TObject; var Key: Char);
    procedure EdScanRateKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure BitBtnRectClick(Sender: TObject);
    procedure BitBtnSQClick(Sender: TObject);
    procedure EdStepXYKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxStepClick(Sender: TObject);
    procedure ComboBoxPathChange(Sender: TObject);
    procedure BitBtnLoadImClick(Sender: TObject);
    procedure BitBtnProjectClick(Sender: TObject);
    procedure BitBtnActLithoClick(Sender: TObject);
    procedure EdStepXYMChange(Sender: TObject);
    procedure ScrollBarLithoScroll(Sender: TObject;ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure PageCtrlScanChange(Sender: TObject);
    procedure BitBtnHelpLithoClick(Sender: TObject);
    procedure BitBtnSpectrHelpClick(Sender: TObject);
    procedure UpDownSpeedClick(Sender: TObject; Button: TUDBtnType);
    procedure BitBtnTutorClick(Sender: TObject);
    procedure BitBtnTimeActClick(Sender: TObject);
    procedure ScrollBarTimeScroll(Sender: TObject; ScrollCode: TScrollCode;var ScrollPos: Integer);
    procedure ImgRChartZoom(Sender: TObject);
    procedure ImgRChartUndoZoom(Sender: TObject);
    procedure ImgRChartMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure ImgRChartMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure ImgRChartMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure UpDownNyClick(Sender: TObject; Button: TUDBtnType);
    procedure UpDownNxClick(Sender: TObject; Button: TUDBtnType);
    procedure ImgLChartAfterDraw(Sender: TObject);
    procedure ImgRChartAfterDraw(Sender: TObject);
    procedure EdNYKeyDown(Sender: TObject;            var Key: Word;  Shift: TShiftState);
    procedure BitBTnActLithoKeyPress(Sender: TObject; var Key: Char);
    procedure BitBTnActLithoKeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState);
    procedure BitBtnTimeActKeyDown(Sender: TObject;   var Key: Word; Shift: TShiftState);
    procedure BitBtnTimeActKeyPress(Sender: TObject;  var Key: Char);
    procedure BitBTnActLithoChange(Sender: TObject);
    procedure BitBtnTimeActChange(Sender: TObject);
    procedure BitBtnX0Y0Click(Sender: TObject);
    procedure SpeedBtnPlDelClick(Sender: TObject);
    procedure RStartBtnClick(Sender: TObject);
    procedure PageCtlRightChanging(Sender: TObject; var AllowChange: Boolean);
    procedure PageCtrlAddChange(Sender: TObject);
    procedure TabSheetCurScanShow(Sender: TObject);
    procedure TabSheetCurLineAddShow(Sender: TObject);
    procedure ComboBoxIZSelect(Sender: TObject);
    procedure EdXKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure EdYKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject;var Key: Word;  Shift: TShiftState);
    procedure BtnZoomClick(Sender: TObject);
    procedure SpeedBtnDelTopClick(Sender: TObject);
    procedure SpeedBtnSDelTopLClick(Sender: TObject);
    procedure SpeedBtnDelTopLClick(Sender: TObject);
    procedure SpeedBtnSDelTopClick(Sender: TObject);
    procedure ChartCurrentLineDblClick(Sender: TObject);
    procedure BitBtnZoomCurLineClick(Sender: TObject);
    procedure RadioTypeLithoClick(Sender: TObject);
    procedure SpeedBtnCaptureClick(Sender: TObject);
    procedure ScrollBarLithoChange(Sender: TObject);
    procedure UpDownActClick(Sender: TObject; Button: TUDBtnType);
    procedure ComboBoxFilterChange(Sender: TObject);
    procedure UpActClick(Sender: TObject);
    procedure DownActClick(Sender: TObject);
    procedure LEditDzChange(Sender: TObject);
    procedure LEditDzKeyPress(Sender: TObject; var Key: Char);
    procedure EdScanRateBWChange(Sender: TObject);
    procedure EdScanRateBWKeyPress(Sender: TObject; var Key: Char);
    procedure UpDownSpeedBWClick(Sender: TObject; Button: TUDBtnType);
    procedure SpdBtnRecordClick(Sender: TObject);
    procedure SpdBtnFBClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;  var Handled: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure edNXExit(Sender: TObject);
    procedure EdNYExit(Sender: TObject);
    procedure edNXEnter(Sender: TObject);
    procedure EdNYEnter(Sender: TObject);
    procedure LandingBtnClick(Sender: TObject);
    procedure SignalsModeButton1Click(Sender: TObject);
    procedure BitBtnLockClick(Sender: TObject);
    procedure SpeedBtnRenishawClick(Sender: TObject);
    procedure EditTterraKeyPress(Sender: TObject; var Key: Char);
    procedure LblEditTTerraKeyPress(Sender: TObject; var Key: Char);
    procedure LblEditTTerraEnter(Sender: TObject);
    procedure LblEditTTerraExit(Sender: TObject);
    procedure ScrollBarTTErraScroll(Sender: TObject; ScrollCode: TScrollCode;      var ScrollPos: Integer);
    procedure LineTimerTimer(Sender: TObject);
    procedure SignalsModeBtnBiasSFMClick(Sender: TObject);
    procedure SignalsModebtnSetPointClick(Sender: TObject);
    procedure SpdBtnOneFrameClick(Sender: TObject);
  private
     flgApproachClick:boolean;
     flgblw:boolean;
     oldFlgXYLinear:boolean;
     InsertOn : boolean;
     InsertOnAct : boolean;
     InsertOnTimeAct : boolean;
     InsertOnY : boolean;
     flagMoveArea:boolean;
     flgFineSpeedLock:boolean;
     flgSpeedLock:boolean; //lock FW BW speed
     flgFieldZoom:boolean;
     FlgTimerActive,flgReStart,FlgDrawArea:boolean;
     flgProjection:boolean;
     OldflgFixStep:boolean;
     flgLoadMatrixImage:boolean;
     FlgFirstDrawImgR, FlgFirstDrawImgL:Boolean;
     FlgAllowZoom:Boolean;
     flgImgRghtScanArea:boolean;
     ZBegin:Boolean;
     errScan:word;
     oldCountStart:integer;
     UpDownACT_position:integer;
     szfill,MargL,MargR:integer;
     ChartFieldX,ChartFieldY:integer;
     mX0,mY0:integer;
     X0ch,Y0ch:integer;
     DemoInfoStructResult:integer;
     LithoTransform,
     DelImg2nm:single; // nm, Distance between points in the ImageScanArea;
     CaptionAdd,CaptionBase,CaptionDemo,CaptionRenishaw:string;
     R_Ch:TRect;
     ScanParTemp:RScanParams;
     BitMapTemp:TBitMap;
     BitMapLTemp:TBitMap;
     ChRect:TRect;
     TimeActScale:single;
     ChScaleX,ChScaleY:single;
     DemoDataInfoArray:TDemoDataInfoArray;
     cursorsaved:TCursor;
     CurrentActivePage:TTabSheet;
     siSaveDialog:TsiSaveDialog;
     LithoAmplifierPow:integer;   // Power of 2 for LithoAmplifier
     mcrn:string;
     flgShowLine:boolean;
     ScanSumX,ScanSumY:integer;  // перенесено из локальных переменных процедуры LinearMatrix
                                 // 20/12/2013, т.к. при линеаризации другая длина линии в дискретах,
                                 // и задержки вычисл. неправильно

    procedure CheckBoxOnNetsExecute;
    procedure SpeedBtnRenishawExecute;
    procedure RebuildWindowRgn;
    procedure BLW_GRAYConvert;
    procedure DisableTopPanel(flg:boolean);
    procedure InitWinScanAreaParams;
    procedure SetImageSideLSize;
    function  SetScanParameters:byte ;
    procedure SetWndComponetsSize;
    function  SetMotionParameters:byte;
    procedure SetLinearPathParameters;
    procedure SetDemoPointsLimit(N:integer);
    procedure SetXYMaxDemo(N:integer);
    procedure ImgSizeCorr(Chart:TChart);
    procedure ImgRInit;
    procedure ImgLInit;
    procedure ClearTabImages;
 // procedure ScanDataInit;
    Procedure SideViewInit;
    procedure ThreadDone(var AMessage : TMessage);       message WM_ThreadDoneMsg;     // Message to be sent back from thread when its done
    procedure MultiThreadDone(var AMessage : TMessage);  message WM_MultiThreadDoneMsg;     // Message to be sent back from thread when its done
    procedure ScanErrorMessage(var AMessage : TMessage); message WM_UserMsgScanError;
    procedure Scanning;
    procedure FastScanning;
    procedure ScanningMulti(sender:Tobject);
    procedure Lithography;
    procedure Spectroscopy;
    procedure Profiling;
    function  TestDiskFreeSpace:byte;
    procedure TestLimitPoint(ScanDiscrNumb,NPoints:integer);
    function  CurrentLithoTimeEtch(Nx,NY:integer):single;
    procedure LinearMatrix(NX,NY:integer);
    procedure WMMOve(var Mes:TWMMove); message WM_Move;
    procedure WMNCLButton(var Message: TMessage);  message WM_NCLButtonDown;
    procedure CopyMe(tobmp: TBitmap; frbmp : TGraphic);
    function  PointInside(CurrPoint:Tpoint ; ChRect:TRect):boolean;
    procedure CalcChartFields(Chart:TChart);    // 09/04/04 Ola
    procedure FitChartToPanel(Chart:TChart; LX,LY,PanelW,PanelH:integer);
    procedure CopyClipboard;
    function  CheckLithoField(XPoints,yPoints:integer; Step:single):boolean;
    procedure FieldMouseDown(Chart:TChart; Sender: TObject; Button:TMouseButton; X,Y:integer);
    procedure FieldMouseMove(Chart:TChart; Sender: TObject; X,Y:integer);
    function  FillStructure(const FName:string;PageNmb:integer):integer;
    function  CreateDemoInfoStruct:integer;
    function  CreateDemoLithoInfoStruct:integer;
    function  ConfigDemoScanWnd(N:integer):integer;
    procedure DrawRectScanArea;

    //  procedure WMDisplayChange(var message: TMessage); message  WM_DISPLAYCHANGE;
public
    FlgReg:byte;             //Region Wnd
    FlgPressApply:byte;
    flgBlickApply:boolean;
    flgBlickSave:Boolean;
    FlgMouseDown :boolean;
    flgTopRDraw:boolean;
    X0,Y0,xt,yt:integer;
//    sz:integer;              //number  view Topo+ ..
    R:TRect;
    R_S:TRect;
    DelImgX,DelImgY:single; // nm, Distance between points in the ImageScanArea;
    DelImg2,DelImg2S:single;
    TopVScale,SideVScale:single;
    Img2Xbegin, Img2Ybegin:single; //nm
    FullRgn: THandle;
    flgChange:boolean;
    ScanAreaBitMapTemp:TBitMap;
    ImgRBitMapTemp:TBitMap;

    procedure ZIndicatorDraw(Z:apitype);
    procedure ScanAreaUpdate;
    procedure SetTypeScanPath;
    procedure RestoreStartSFM;
//    procedure Convolution(var Mas:TLineSingle;const Size, S:integer);
    procedure PrepareScanError(var aScan:Tlinesingle);
    procedure ReloadScanParams;
    procedure UserMessage (var Msg: TMessage); message WM_UserScanWndUpdated;
end;
 const
	strsdrw: string = ''; (* Topo ,nm *)
	strsdrw2: string = ''; (* Phase,a.u *)
	strsdrw3: string = ''; (* Force,mv *)
	strsdrw4: string = ''; (* Current,nA *)
  strtime:string='';
	errorscan: string = ''; (* Scannning error! *) // TSI: Localized (Don't modify!)
	scan1: string = ''; (* Max Valid Points Number for this Scan length is: %d  *)
	scan2: string = ''; (* ;  Scan Field Error!!! *)
	scan3: string = ''; (* No Interaction!!!! *)
	scan4: string = ''; (* You have changed ScanParameters. Press Apply button, before start Scan  *)
	scan5: string = ''; (* Make scanner linearization! *)
	scan6: string = ''; (* You scan without linealization! Continue scan? *)
	scan7: string = ''; (* Load Image for Lithography!!! *)
	scan8: string = ''; (* Project Matrix on the Area!!! *)
	scan9: string = ''; (* Input points for Spectroscopy!! *)
	scan10: string = ''; (* Try again! *)
	scan11: string = ''; (* Make Scanning before Spectroscopy!! *)
	scan12: string = ''; (* Stop Scanning before exit!!! *)
	scan13: string = ''; (* Error!! *)
	scan14: string = ''; (* Maximal value X is exceeded. Reduce a field of scanning. *)
	scan15: string = ''; (* Maximal value Y is exceeded. Reduce a field of scanning. *)
	scan16: string = ''; (* You have to increase X or decrease Nx *)
	scan17: string = ''; (* Disk is full. Clean up disk  or change work disk!! *)
	scan18: string = ''; (* Input StepXY parameter!! *)
	scan19: string = ''; (* Input Nx parameter!! *)
	scan20: string = ''; (* Input Ny parameter!! *)
	scan21: string = ''; (* Zero input *)
	scan22: string = ''; (* Input X parameter!! *)
	scan23: string = ''; (* Input Y parameter!! *)
	scan24: string = ''; (* Input Nx parameter!! *)
	scan25: string = ''; (* You have changed ScanParameters. Press Apply button, before to choose new regime  *)
	scan26: string = ''; (* Input Ny parameter!! *)
	scan27: string = ''; (* OUT memory TopoSPM *)
	scan28: string = ''; (* no Demo Data!!! *)
	scan29: string = ''; (* Projection exeeds Scan Field Limits.  *)
	scan30: string = ''; (* Demo Lithography file not exists!!! *)
	scan31: string = ''; (* You have changed ScanParameters. Press Apply button, before change direction! *)
	scan32: string = ''; (* error input *)
	scan33: string = ''; (* Maximal value Y is exceeded. Reduce a field of scanning. *)
	scan34: string = ''; (* Maximal value X is exceeded. Reduce a field of scanning. *)
	scan35: string = ''; (* Stop Scan before change parameters and then repeat save *)
	scan36: string = ''; (* Error input Nx *)
	scan37: string = ''; (* Error input Ny *)
	scan38: string = ''; (* OUT memory TopoSPM *)
	scan39: string = ''; (* Error! Scanning speed v=0 *)
	scan40: string = ''; (* The Multipass scanning don't work with Renishaw! *)

var
  FlgScanError,flgContrastTopView:Boolean;
  imW,imH:integer;
  w,h:integer;
//side view parameters
  XLeft,YLeft, XRight,YRight:integer;
  PointSelectKoef, ScanSelectKoef:integer;
  hgt, href: integer;
  SideLinePointsNmb:integer;
  TopHoriz,BottHoriz:ArrayInt;
  Z_d_nm:single;//d->nm
  kh, kw: single;
  cos1, cos2, sin1, sin2: single;
////
  ScanWnd: TScanWnd;

 implementation

uses GlobalDcl,GlobalVar,GlobalFunction,SystemConfig,mHardWareOpt,uScannerCorrect,frExperimParams,
     ScanWorkThread,ScanDrawThread,ScanFastDrawThread,ScanDrawThreadLitho, mMain, mScanRate,
     frSPM_Browser,frSpectroscopy,frSpectroscopyTerra,frSpectroscopyV,frOpenGLDraw, SioCSPM,
     uFileOp,FileCtrl,DlgComment, fShockwave,frX0Y0Change,UNanoeduInterface,
     UNanoEduBaseClasses,UNanoEduClasses, UNanoEduScanClasses,nanoeduhelp,
     frChangeDir, frScanFieldZoom, frCurrentLine, frBeginnerGuide,SurfaceTools,frReport,
     frSetPalette, frSetInteraction,frContrastTopView, frProgress,frProgressMoveto,RenishawVars,frProfiler;


 Const
	strRun: string = ''; (* RUN *)
	strReRun: string = ''; (* ReSTART *)
	strStop: string = ''; (* STOP *)

    strMes1='';
    strMes2='';
    strMes3='';
    strMes4='';
       {$R *.DFM}
var
    FlgScanDone:Boolean;
    flgLeftBtn:boolean;
    SideLinePointsScale, SideScansScale:integer;     //=100;
    a,b:integer;
    xm,ym:integer;
    cl:longword;
    DlgComnt:TDlgComnt;
    CurScanWindowH:single;

 const
  alpha1 = Pi/12 + Pi/8;
  alpha2 = Pi/3  + Pi/4;


  procedure     TScanWnd.DrawRectScanArea;
  begin
          with ImageScanArea do
          begin
               with Canvas.Pen do
              begin
                 Style:=psSolid;
                 Color:=clBlack;
                 Width:=2;
                 Mode:=pmCopy;
              end;
              Canvas.MoveTo(1,1);   //0
              Canvas.LineTo(1,Height-1);
              Canvas.LineTo(Width-1,Height-1);  { TODO : 010906 }
              Canvas.LineTo(Width-1,1);   //0
              Canvas.LineTo(1,1);    //0
         end;

  end;

procedure TScanWnd.EditDacZSpeedChange(Sender: TObject);
begin
  ScanParams.DacZTimeDelay:=strtoint(EditDacZSpeed.Text);
end;

procedure TScanWnd.EditDacZSpeedKeyPress(Sender: TObject; var Key: Char);
begin
 if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TScanWnd.EditTterraKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure  TScanWnd.TestLimitPoint(ScanDiscrNumb,NPoints:integer);
begin
if (ScanDiscrNumb<NPoints) then
 begin
  showmessage(Format(scan1{'Max Valid Points Number for this Scan length is: %d '},
                        [ScanDiscrNumb])+scan2{';  Scan Field Error!!!'});
  if FlgStopScan then
   begin
      with ScanParams do
       begin
         case ScanParams.ScanPath of
 Multi,OneX: begin
                NX:=ScanDiscrNumb;
                StepXY:=X/NX;
                NY:=round(Y/StepXY);
              end;
 MultiY,OneY: begin
               NY:=ScanDiscrNumb;
               StepXY:=Y/NY;
               NX:=round(X/StepXY);
              end;
                      end;
         edNX.Text:=IntToStr(NX);
         edNY.Text:=IntToStr(NY);
        if HardWareOpt.XYtune='Fine' then edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,2)
                                     else edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,1);
     end;
    end
  end;
end;

procedure    TScanWnd.ScanAreaUpdate;
 var  XMaxTmp,YMaxTmp:single;
begin
//    oldFlgXYLinear:=ScannerCorrect.FlgXYLinear;
    if(ScanParams.XBegin+ScanParams.X)>ScanParams.XMax then ScanParams.Xbegin:=ScanParams.XMax-ScanParams.X{*0.5};
    if(ScanParams.YBegin+ScanParams.Y)>ScanParams.YMax then ScanParams.Ybegin:=ScanParams.YMax-ScanParams.Y{*0.5};
   with ScanParamsWnd do
     begin
          DelImgX:=(ScanParams.XMax/ImageScanArea.Width);
          DelImgY:=(ScanParams.YMax/ImageScanArea.Height);
          with ScanParams do
           begin
                   if HardWareOpt.XYTune='Rough' then
                                     begin
                                       edX.Text:=FloatToStrF(floor(ScanParams.X),fffixed,8,0);
                                       edY.Text:=FloatToStrF(floor(ScanParams.Y),fffixed,8,0);
                                     end
                                     else
                                     begin
                                       edX.Text:=FloatToStrF((ScanParams.X),fffixed,8,1);
                                       edY.Text:=FloatToStrF((ScanParams.Y),fffixed,8,1);
                                     end;
             edNX.Text:=format('%d',[ScanParams.NX]);
             edNY.Text:=format('%d',[ScanParams.NY]);
             edScanRate.Text:=FloatToStrF(round(ScanParams.ScanRate),ffFixed,10,0);
             edScanRateBW.Text:=FloatToStrF(round(ScanParams.ScanRateBW),ffFixed,10,0);
             R_S.Left:= round(XBegin/DelImgX);
             R_S.Top:= ImageScanArea.Height-round((YBegin+Y)/DelImgY);
             R_S.Right:=round((XBegin+X)/DelImgX);
             R_S.Bottom:=ImageScanArea.Height-round((YBegin)/DelImgY);
           end;
       with ImageScanArea do
        begin
           Canvas.Brush.Color:=clWindow;
           Canvas.FillRect(Rect(0,0,Width,Height));
           Application.ProcessMessages;
           ScanAreaBitMapTemp.Assign(ImageScanArea.Picture.Bitmap);
           DrawRectScanArea;
           Canvas.Pen.Color:=clBlack;
           Canvas.Pen.Mode:=pmCopy;
           Canvas.Pen.Style:=psSolid;
           Canvas.Polyline([Point(R_S.Left,R_S.Bottom),Point(R_S.Left,R_S.Top),
           Point(R_S.Right,R_S.Top),Point(R_S.Right,R_S.Bottom),Point(R_S.Left,R_S.Bottom)]);
           R:=R_S;
        end; //ScanArea
      end; //ScanParamWND
     BitBtnRect.Visible:=Scanparams.flgSQ;
     BitBtnSQ.Visible:=not Scanparams.flgSQ;
     ComboBoxPath.itemindex:=Scanparams.ScanPath;

     //060309
 (*  if   flgReniShawUnit then
     begin
        if ReniShawparams.flgSteponNets then
         begin
           ScanParams.StepXY:= RenishawParams.Period_nm;
           UpDownRS.Visible:=true;
           edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,1);
           flgchange:=true;
           EdStepXYM.text:=edStepXY.text;
           EdStepXYM.enabled:=false;
         end
         else
         begin
          UpDownRS.Visible:=false;
          EdStepXYM.enabled:=true;
          EdStepXYM.text:=edStepXY.text;
         end;
       EdStepXY.Enabled:= not ReniShawparams.flgSteponNets;
     end;
   *)
 //060309
     ApplyBtnClick(self);
end;

procedure  TScanWnd.UserMessage (var Msg: TMessage);
begin
if FlgStopScan then
begin
        case Msg.wparam of
0:begin
   LoadScannerOptGeneral(ScanneriniFileX,ScanneriniFileY);
   ScannerCorrectLast();
   TransformUnitInit ;
   if FlgCurrentUserLevel =Demo then  SetXYMaxDemo(PageCtlRight.ActivePageIndex)
   else
   begin
    ApprLinesParamsCalc(HardWareOpt.ScannerNumb);
    SetXYMax;
   end;
//   RenishawParamsDef;
  if (HardWareOpt.XYtune='Rough') then  SetScanAreaDefR
                                  else  SetScanAreaDefF;
//   SetScanParamsDef;// SetScanAreaDef;
//   SetScanPath;
   ScanAreaUpdate;
   ApplyBitBtn.Font.Color:=clRed;
  end;
1:begin
   SetLinSplineZero;
   LoadLinSpline(HardWareOpt.ScannerNumb);
    ApprLinesParamsCalc(HardWareOpt.ScannerNumb);
    SetXYMax;
   ApplyBitBtn.Font.Color:=clRed;
  end;
    end;
  Application.ProcessMessages;
end
 else   siLangLinked1.MessageDlg(scan35(* 'Stop Scan before change parameters and then repeat save' *),mtWarning,[mbOk],0);
end;

procedure TScanWnd.ReloadScanParams;
begin
end;

(*procedure TScanWnd.Convolution(var Mas:TLineSingle;const Size,S:integer);
var
 i,r:integer;
 Q,Buf:single;
  Shift,L:integer;
 Temp:  TLineSingle;
begin
 L:=Size;//Length(Mas);
 Shift:=(S-1) div 2;
 SetLength(Temp,L);
 for i:=0 to L-1 do Temp[i]:=Mas[i];
 for i:=0 to Shift-1 do    // Set boundary elements
    begin                // for convolution;
     Temp[i]:=Mas[i];
     Temp[i+L-Shift]:=Mas[i+L-Shift];
    end ;
 for i:=Shift to L-Shift-1 do
   begin
     Q:=0;
    for r:=0 to S-1 do
     begin
      Buf:=Mas[i+r-Shift];
      Q:=Q+Buf;
     end;
     Q:=Q /S;{ TODO : 300305 }
     Temp[i]:=Q;
  end;
  for i:=0 to L-1 do Mas[i]:=Temp[i];
  Temp:=nil;
end;
*)
procedure TScanWnd.PrepareScanError(var aScan:Tlinesingle);
var i,asz:integer;
   atemp:Tlinesingle;
begin
   asz:=length(aScan);
   setlength(atemp,asz);

   for i:=1 to aSz-2   do  atemp[i]:=aScan[i]-aScan[i-1];

   atemp[asz-1]:=aScan[asz-1];

   atemp[0]:=aScan[0]-scanparams.dataInPrev;

   for i:=0 to asz-1   do  aScan[i]:=atemp[i];
   scanparams.dataInNext:=trunc(atemp[asz-1]);
   atemp:=nil;
end;

procedure TScanWnd.CopyMe(tobmp: TBitmap; frbmp : TGraphic);
begin
  tobmp.Width := frbmp.Width;
  tobmp.Height := frbmp.Height;
  tobmp.PixelFormat := pf24bit;
  tobmp.Canvas.Draw(0,0,frbmp);
end;

procedure TScanWnd.CopytoClipboard1Click(Sender: TObject);
begin
    Main.CopytoClipBoardExecute(self);
end;

procedure TScanWnd.SetImageSideLSize;
var wh:integer;
begin
     BitBtnCLChart.visible   :=ScanParams.flgSpectr;
     ImageSideL.Width:=TabSheetSideL.width-3;
     ImageSideL.Height:=TabSheetSideL.height-3;
     wh:=min(ImageSideL.Width,ImageSideL.Height);
     ImageSideL.Height:=wh;
     ImageSideL.Width:=wh;
      with ImageSideL.Canvas.ClipRect do
       begin
          w := Round(Abs(Right-Left)) + 1;
          h := Round(Abs(Bottom-Top)) + 1;
       end;
end;

procedure TScanWnd.ImgRInit;
var wh:integer;
  m,n,PointColor:integer;
begin
     ChartFieldX:=40;
     ChartFieldY:=40;
     ImgRPanel.Left:=0;
     ImgRPanel.Top:=2;
     ImgRPanel.Width:= ImgRPanel.parent.width-3;
     ImgRPanel.Height:= ImgRPanel.parent.height-3;
     wh:=min(ImgRPanel.Width,ImgRPanel.Height);
     ImgRPanel.Height:=wh;
     ImgRPanel.Width:=wh;
  with ImgRChart do
   begin
       Left:=0;
       Top:=0;
       Width:=ImgRPanel.Width;
       Height:=ImgRPanel.Height;
       marginright:=6;
           case ScanParams.ScanPath of
 Multi,
 OneX: begin
       if ScanParams.ScanMethod<>OneLineScan then
         begin
          LeftAxis.SetMinMax( 0, ScanParams.NY*ScanParams.StepXY);
          BottomAxis.SetMinMax( 0, ScanParams.NX*ScanParams.StepXY);
          LeftAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );
          BottomAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) )
         end
        else
         begin
       //   LeftAxis.SetMinMax( 0,ScanParams.Ny);          //201213
          LeftAxis.SetMinMax( 0,strtofloat(Frametime.Caption));
          BottomAxis.SetMinMax( 0, ScanParams.NX*ScanParams.StepXY );
          LeftAxis.Title.Caption:=strtime;//'s';
          BottomAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) )
         end;
       end;
 MultiY,
 OneY: begin
        if ScanParams.ScanMethod<>OneLineScan then
         begin
          LeftAxis.SetMinMax( 0, ScanParams.NY*ScanParams.StepXY);
          BottomAxis.SetMinMax( 0, ScanParams.NX*ScanParams.StepXY);
          LeftAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );
          BottomAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) )
         end
        else
         begin
   //       BottomAxis.SetMinMax( 0,ScanParams.Nx);
          BottomAxis.SetMinMax( 0,strtofloat(Frametime.Caption));
          LeftAxis.SetMinMax( 0, ScanParams.NY*ScanParams.StepXY );
          BottomAxis.Title.Caption:=strtime;//'s';
          LeftAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) )
         end;
       end;
              end;
       LeftAxis.Title.Angle:=90;
       BackImageInside:=True;
       BackImageMode:=pbmStretch;
       Canvas.Pen.Mode:=pmCopy;
       Canvas.Pen.Color:=clRed;
       Canvas.Pen.Width:=3;
       AllowZoom:=false;
     end;
      CalcChartFields(ImgRChart);
      FitChartToPanel(ImgRChart, ScanParams.NX,ScanParams.NY,ImgRPanel.Width,ImgRPanel.Height);
      ImgRChart.BackImage.Bitmap.Width:=ScanParams.NX;
      ImgRChart.BackImage.Bitmap.Height:=ScanParams.NY;
      m:=ScanParams.NY;
      n:=ScanParams.NX;
      ImgRChart.Repaint;
      ImgSizeCorr(ImgRChart);
end;{ImgRInit}

procedure TScanWnd.ImgLInit;
var
 wh:integer;
begin
     ImgLPanel.Left:=0;
     ImgLPanel.Top:=2;
     ImgLPanel.Width:= ImgLPanel.parent.width-3;
     ImgLPanel.Height:= ImgLPanel.parent.height-3;
     wh:=min(ImgLPanel.Width,ImgLPanel.Height);
     ImgLPanel.Height:=wh;
     ImgLPanel.Width:=wh;
    with ImgLChart do
     begin
       Left:=0;
       Top:=0;
       Width:=ImgLPanel.Width;
       Height:=ImgLPanel.Height;
       LeftAxis.SetMinMax( 0, ScanParams.NY*ScanParams.StepXY );
       LeftAxis.Title.Angle:=90;
       LeftAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );
       BottomAxis.SetMinMax( 0, ScanParams.NX*ScanParams.StepXY );
       BottomAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );
       BackImageInside:=True;
       BackImageMode:=pbmStretch;
       Canvas.Pen.Mode:=pmCopy;
       Canvas.Pen.Color:=clRed;
       Canvas.Pen.Width:=3;
       AllowZoom:=false;
     end;
     CalcChartFields(ImgLChart);
     FitChartToPanel(ImgLChart, ScanParams.NX,ScanParams.NY,ImgLPanel.Width,ImgLPanel.Height);
     with ImgLChart.BackImage.Bitmap do
       begin
         Width:=ScanParams.NX;
         Height:=ScanParams.NY;
//         ImgLChart.BackImageInside:=True;
       end;
//      m:=ScanParams.NY;
//      n:=ScanParams.NX;
      ImgLChart.Repaint;
      ImgSizeCorr(ImgLChart);
//ChartError
     ImgLPanelEr.Left:=0;
     ImgLPanelEr.Top:=2;
     ImgLPanelEr.Width:= ImgLPanelEr.parent.width-3;
     ImgLPanelEr.Height:= ImgLPanelEr.parent.height-3;
     wh:=min(ImgLPanelEr.Width,ImgLPanelEr.Height);
     ImgLPanelEr.Height:=wh;
     ImgLPanelEr.Width:=wh;
    with ImgLChartEr do
     begin
       Left:=0;
       Top:=0;
       Width:=ImgLPanelEr.Width;
       Height:=ImgLPanelER.Height;
       LeftAxis.SetMinMax( 0, ScanParams.NY*ScanParams.StepXY );
       LeftAxis.Title.Angle:=90;
       LeftAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );
       BottomAxis.SetMinMax( 0, ScanParams.NX*ScanParams.StepXY );
       BottomAxis.Title.Caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );
       BackImageInside:=True;
       BackImageMode:=pbmStretch;
       Canvas.Pen.Mode:=pmCopy;
       Canvas.Pen.Color:=clRed;
       Canvas.Pen.Width:=3;
       AllowZoom:=false;
     end;
     CalcChartFields(ImgLChartEr);
     FitChartToPanel(ImgLChartEr, ScanParams.NX,ScanParams.NY,ImgLPanelEr.Width,ImgLPanelEr.Height);
     with ImgLChartEr.BackImage.Bitmap do
       begin
         Width:=ScanParams.NX;
         Height:=ScanParams.NY;
  //       ImgLChartEr.BackImageInside:=True;
       end;
//      m:=ScanParams.NY;
//      n:=ScanParams.NX;
      ImgLChartEr.Repaint;
      ImgSizeCorr(ImgLChartEr);
end; {ImgLInit}

procedure TScanWnd.ImgSizeCorr(Chart:TChart);
var H0,W0,CH,CW,HeightChartNew,WidthChartNew:integer;
    LX,LY:integer;
begin
 LX:=ScanParams.NX;
 LY:=ScanParams.NY;
if (LX<>0) and (LY<>0) then
 with Chart do
  begin
   BottomAxis.Labels:=True;
   LeftAxis.Labels:=True;
   H0:=Height;
   W0:=Width;
   CH:=ChartHeight;
   CW:=ChartWidth;
   if LX>=LY then
   begin
     HeightChartNew:=round(CW*LY/LX)+H0-CH;
     Height:= HeightChartNew;
   end
   else if LY>LX then
   begin
     WidthChartNew:=round(CH*LX/LY)+W0-CW;
     Width:= WidthChartNew;
   end;
   RePaint;
 end;
end; {ImgRSizeCorr}

procedure TScanWnd.ClearTabImages;
begin
(*      with ImgRChart.BackImage.Bitmap do
      begin
          PatBlt(Canvas.Handle,
                      0,
                      0,
                      Width,
                      Height,
                      WHITENESS);
      end;
  *)
  with ImgRChart.BackImage.Bitmap do
      begin
         Canvas.CopyMode:=cmWhiteness;     {Очистка картины}
         Canvas.CopyRect(Rect(0,0,Width,Height),Canvas,Rect(0,0,Width,Height));
      end;
 if TabSheetTopoL.TabVisible then
   with ImgLChart.BackImage.Bitmap do
      begin
         Canvas.CopyMode:=cmWhiteness;     {Очистка картины}
         Canvas.CopyRect(Rect(0,0,Width,Height),Canvas,Rect(0,0,Width,Height));
      end;
 if TabSheetTopoError.TabVisible then
   with ImgLChartEr.BackImage.Bitmap do
      begin
         Canvas.CopyMode:=cmWhiteness;     {Очистка картины}
         Canvas.CopyRect(Rect(0,0,Width,Height),Canvas,Rect(0,0,Width,Height));
      end;
   with ImageSideL do
      begin
        Canvas.Brush.Color:=clWhite;//Window;
        Canvas.FillRect(Rect(0,0,Width,Height));
      end;
end;

Procedure TScanWnd.SideViewInit;
var i,Nx,Ny:integer;
    desired: single;
    S1,S2,lin1koef,lin2koef,lin1A0,lin2A0:single;
    S:integer;
begin
    SideLinePointsScale:=100;
    SideScansScale:=100;
    PointSelectKoef:=1;
    ScanSelectKoef:=1;
    SideVScale:=8;
    hgt := h div 10;
    cos1 := Cos(alpha1);
    cos2 := Cos(alpha2);
    desired := cos1*ScanParams.ScanLines - cos2*ScanParams.ScanPoints + 0.001;
    kh := (h - hgt)/desired;
    href := Trunc(hgt + kh*cos1*ScanParams.ScanLines);
    sin1 := Sin(alpha1);
    sin2 := Sin(alpha2);
    desired := sin1*ScanParams.ScanLines + sin2*ScanParams.ScanPoints;
    kw := w/desired;
    S:=round(kw*sin2*ScanParams.ScanPoints);
    S1:=h-(href - Trunc(kh*(cos1*ScanParams.ScanLines + cos2*ScanParams.ScanPoints)));
    S2:=h-hRef;
    lin2Koef:=S1/(w-S);
    lin1Koef:=-S2/S;
    lin1A0:=S2;//-lin1koef*S;
    lin2A0:=-lin2koef*S;

   if ScanParams.ScanLines>ScanParams.ScanPoints then SideVScale:=SideVScale*ScanParams.ScanLines/ScanParams.ScanPoints/2;

   if (SideLinePointsScale> (w div 3)) then SideLinePointsScale:=w div 3;

   if (SideScansScale> (h div 2))      then SideScansScale:=h div 2;

   if ScanParams.ScanPoints>SideLinePointsScale   then PointSelectKoef:=ScanParams.ScanPoints div SideLinePointsScale;

   if ScanParams.ScanLines>SideScansScale         then ScanSelectKoef:=ScanParams.ScanLines div SideScansScale;

   SideLinePointsNmb:=ceil(ScanParams.ScanPoints/PointSelectKoef);

 XLeft:=-1;
 YLeft:=-1;
 XRight:=-1;
 YRight:=-1;
 SetLength(TopHoriz,ImageSideL.Width);
 SetLength(BottHoriz,ImageSideL.Width);
//set horizont
 for i:=0  to S-1 do
   begin
     TopHoriz[i]:=0;
     BottHoriz[i]:=ImageSideL.Height;
   end;
 for i:=S  to ImageSideL.Width-1 do
   begin
     TopHoriz[i]:=round(lin2koef*i+lin2A0);
     BottHoriz[i]:=TopHoriz[i];
   end;
end;

procedure TScanWnd.BLW_GRAYConvert;
var mheight: array of word;
  i,j:integer;
  dlt:single;
 BitMap:Tbitmap;
 P:PByteArray;
 VRed,VBlue,VGreen: word;
 Nx,Ny:integer;
 CL:WORD;
procedure converttogreybit24;
begin
                  VBlue :=mheight[floor( P[3*i]/dlt)];
                  VGreen:=mheight[floor( P[3*i+1]/dlt)];
                  VRed  :=mheight[floor( P[3*i+2]/dlt)];
                  CL:= (vblue+vgreen+vred) div 3;
                  PByteArray(BitMap.ScanLine[j])[3*i]:=cl;
                  PByteArray(BitMap.ScanLine[j])[3*i+1]:=cL;
                  PByteArray(BitMap.ScanLine[j])[3*i+2]:=CL;

end;
begin
    BitMap:=TBitMap.Create;
  try
    Ny:=ImageMatrix.Picture.Bitmap.Height;
    Nx:=ImageMatrix.Picture.Bitmap.Width;

     CopyMe(BitMap,ImageMatrix.Picture.Graphic);

               case flgblw of
    true:  begin
             setlength(mheight,2);
             mheight[0]:=0;
             mheight[1]:=255;
             dlt:=128;
             for j:= 0 to BitMap.height -1 do
              begin
                  P := Bitmap.ScanLine[j];
                  for i := 0 to BitMap.width -1 do
                 begin
                  converttogreybit24;
                 end;
                  P:=nil;
               end;
           end;
    false: begin  //gray
             setlength(mheight,8);
             dlt:=(255/7);
             for i := 0 to 7 do  mheight[i]:=round(dlt*i)
           end;
                   end;

    for j:= 0 to BitMap.height -1 do
     begin
         P := Bitmap.ScanLine[j];
        for i := 0 to BitMap.width -1 do
         begin
             converttogreybit24;
         end;
         P:=nil;
     end;
     ImageMatrix.Picture.Graphic.assign(BitMap);
 finally
     FreeAndNil(BitMap);
 end;
     Finalize(mheight);
end;

procedure TScanWnd.DisableTopPanel(flg:boolean);
begin
//     210211
 //         PanelTop.Enabled   :=not flg;
 //          UPDownSpeed.enabled:=not flg;
//          edScanRate.enabled :=not flg;
          OptionsBtn.enabled :=not flg;
   //       edScanRateBW.enabled :=(not flg) and (not flgSpeedLock);
   //       UPDownSpeedBW.enabled:=(not flg) and (not flgSpeedLock);
              case ScanParams.ScanMethod of
    OneLineScan: begin
                  edScanRate.enabled:=false;
                  edScanRateBW.enabled:=false;
                  UPDownSpeed.enabled:=false;
                  UPDownSpeedBW.enabled:=false;
                 end;
                     end;
         SignalsMode.enabled:=not flg;
end;

procedure TScanWnd.WMMOve(var Mes:TWMMove);
begin
//    if Mes.YPos<(Main.ToolBar1.Height+2) then Top:=Main.ToolBar1.Height+2;
end;
procedure TScanWND.WMNCLButton(var Message: TMessage);
 begin
       case Message.wParam of
HTCAPTION:
          begin
           if AltDown  then        // copy to clipboard    for report
             if  assigned(ReportForm) then
             begin
               PanelParam.BeginDrag(False);
               Main.CopyToClipBoardExecute(self);
               ReportForm.CaptureSourceImage(PanelParam);
             end;
           end;
      end;
      inherited;
 end;

procedure TScanWND.LinearMatrix(NX,NY:integer);
var
 i,YSum,LinFieldXBound, LinFieldYBound:integer;
 U0,U1:float;
 xcount,ycount:single;
 BoundPointX,BoundPointY:single;
 ApprLineX0, ApprLineY0:single;
begin
 BoundPointX:=SEVAL(NXSplines,ScannerCorrect.NonLinFieldX,XXsp,YXsp,Bx,CX,DX);
 BoundPointY:=SEVAL(NYSplines,ScannerCorrect.NonLinFieldY,XYsp,YYsp,BY,CY,DY);
 ApprLineX0:=BoundPointX-LineXKoef*ScannerCorrect.NonLinFieldX;
 ApprLineY0:=BoundPointY-LineYKoef*ScannerCorrect.NonLinFieldY;
 ScanSumX:=0;
 ScanSumY:=0;
 YSum:=0;
 xcount:=0;
 U0:=SEVAL(NXSplines,xcount,XXsp,YXsp,Bx,CX,DX);
 for i:=0 to NX-1 do
  begin
    xcount:=xcount+ScanParams.StepXY;//*TransformUnit.Xnm_d);
   if (xcount<=ScannerCorrect.NonLinFieldX)
        then U1:=SEVAL(NXSplines,xcount,XXsp,YXsp,BX,CX,DX)
        else U1:=ApprLineX0+LineXKoef*xcount;
   JMPX[i]:=round((U1-U0)*TransformUnit.Xnm_d);
   ScanSumX:=ScanSumX+JMPX[i];
    if (JMPX[i]<1) then JMPX[i]:=1;

   (* if ScanSumX+ScanParams.XBegin*TransformUnit.XPnm_d>=MAXapitype   then
                                        begin
                                         ScanSumX:=ScanSumX-JMPX[i];
                                         JMPX[i]:=0;
                                        end;  *)

   (* if (ScanSumX-round(ScanParams.XBegin*TransformUnit.XPnm_d)+CSPMSignals[8].MaxDiscr) <= CSPMSignals[8].MinDiscr then
                                       begin
                                         ScanSumX:=ScanSumX-JMPX[i];
                                         JMPX[i]:=0;
                                        end;  *)

    if ScanSumX+round(ScanParams.XBegin*TransformUnit.XPnm_d) >= CSPMSignals[8].MaxDiscr - CSPMSignals[8].MinDiscr  then
                                        begin
                                         ScanSumX:=ScanSumX-JMPX[i];
                                         JMPX[i]:=0;
                                        end;
    U0:=U1;
  end;
 LinFieldXBound:=ceil(ScanParams.XBegin*TransformUnit.XPnm_d)+ScanSumX;     //discr
 if (LinFieldXBound>abs(CSPMSignals[8].MaxDiscr- CSPMSignals[8].MinDiscr)) then  siLangLinked1.MessageDlg(scan13{'Error'}+#13+scan34(* 'Maximal value X is exceeded. Reduce a field of scanning.' *)  ,mtError ,[mbOK],0);
  ycount:=0;
  U0:=SEVAL(NYSplines,ycount,XYsp,YYsp,BY,CY,DY);
 for i:=0 to NY-1 do
  begin
   ycount:=ycount+ScanParams.StepXY;
    if (ycount<=ScannerCorrect.NonLinFieldY)
         then  U1:=SEVAL(NYSplines,ycount,XYsp,YYsp,BY,CY,DY)
         else  U1:=ApprLineY0+LineYKoef*ycount;
   JMPY[i]:=round((U1-U0)*TransformUnit.Ynm_d);
   ScanSumY:=ScanSumY+JMPY[i];
   if (JMPY[i]<1) then JMPY[i]:=1;

  (* if ScanSumY+ScanParams.YBegin*TransformUnit.YPnm_d>=MAXapitype    then
                                              begin
                                                 ScanSumY:=ScanSumY-JMPY[i];
                                                 JMPY[i]:=0;
                                              end;*)
    if ScanSumY+round(ScanParams.YBegin*TransformUnit.YPnm_d) >= CSPMSignals[9].MaxDiscr - CSPMSignals[9].MinDiscr  then
                                        begin
                                         ScanSumY:=ScanSumY-JMPY[i];
                                         JMPY[i]:=0;
                                        end;
                                          
    U0:=U1;
  end;
    { TODO :  DacY OverFlow Test , Ola 020404 }
   LinFieldYBound:=ceil(scanParams.YBegin*TransformUnit.YPnm_d)+ScanSumY;     //discr
   if (LinFieldYBound>abs(CSPMSignals[9].MaxDiscr- CSPMSignals[9].MinDiscr)) then siLangLinked1.MessageDlg(scan13{'Error!!' }+#13+scan33(* 'Maximal value Y is exceeded. Reduce a field of scanning.' *)  ,mtError ,[mbOK],0);
 // Calculate scanner bias
 ScanParams.ScanShift:=round(ScanSumY*ScannerCorrect.YBiasTan/NY);
//Scan Shift :discr;  YBiasTang tang of angle between OY and Y-Section
 JMPX[NX]:=ScanSumX-ScanParams.ScanShift; // Additional element for back path;
 JMPY[NY]:=ScanSumY-ScanParams.ScanShift; // Addi
end;
procedure TScanWnd.LineTimerTimer(Sender: TObject);
var
    ddn, dmn,m,n:integer;
    linerect:Trect;
    col:TColor;
    linewidth:integer;
    ImgH,ImgW:integer;
begin
   ddn:=ScanParams.CurrentScanCount;
   dmn:=1;
   m:=ScanParams.NY;
   n:= ScanParams.NX;
   linewidth:=1;
   ImgH:= abs(ImgRChart.chartrect.top-ImgRChart.chartrect.Bottom);
   ImgW:= ImgRChart.chartrect.Right-ImgRChart.chartrect.Left;
   if  flgShowLine then col:= clGreen else col:= clWhite;

              ImgRChart.BackImage.Bitmap.Canvas.Brush.Color:=col;
              ImgLChart.BackImage.Bitmap.Canvas.Brush.Color:=col;
              case ScanParams.ScanPath of
     Multi,OneX:   begin
                    if ImgH <= m then  linewidth:=( m div ImgH) +3;
                    if ddn = 0  then  inc( linewidth);
                    
                    if Scanparams.ScanMethod <> Litho then
                         ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(0,m-ddn,n,m-ddn-linewidth)) ;
                   // else
                    ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(0,m-ddn,n,m-ddn-linewidth)) ;
                   // ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(0,m,n,m-10));
                   end;
    MultiY,OneY:   begin
                     if ImgW <= n then  linewidth:=( n div ImgW) +3;
                      if ddn = 0  then  inc( linewidth);
                     if Scanparams.ScanMethod <> Litho then
                    ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,0,ddn+linewidth,m));
                  //  else
                    ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,0,ddn+linewidth,m));
                   end;
                       end; //case

    flgShowLine:=not flgShowLine;
end;

procedure TScanWND.SetWndComponetsSize;
var
   wh:integer;
begin
//don't move
    {  Top:=TopStart-20;
      if Top<20 Then Top:=20;
    }
     Top:=2;
     Left:=LeftStart;
//     Width:=Main.ClientWidth-30;
   //  panel5.left:=0;
   //  panel5.top:=2;
     if Screen.Height>800 then
                       begin
                          paneltop.Height:=259;
                       end
                       else
                       begin
                         paneltop.Height:=236;
                       end;
     panel5.Width:=265;//200
    (* panel5.Height:=PanelTop.height-2;//-panel8.height-2;
     SignalsMode.Height:=panel5.height;
     SignalsMode.Left:=panel5.left+panel5.width;
     SignalsMode.Top:=Panel5.top;
     ScanParamsWND.Top:=panel5.top;
     ScanParamsWND.Left:=PanelTop.width- ScanParamsWND.Width;//SignalsMode.left+SignalsMode.width;
     ScanParamsWND.Height:=panel5.height;
     ScanParamsWND.Width:=PageCtrlScan.Width+PanelScanParam.width+15;
   *)
     ScanParamsWND.width:=493; //478
   //  PanelTopRight.width:=700;  //707
     PageCtrlScan.Height:=ScanParamsWND.Height;
     PageCtrlScan.Width:=ScanParamsWND.Height;
(* //    panel8.width:=panelTop.width;
 //    panel8.top:=panelTop.height-panel8.height;
//     panel8.left:=0;
     Panel9.Top:=0;
     Panel9.Left:=0;
     panel9.width:=Panel8.width div 2;
     Panel10.Top:=0;
     Panel10.Left:=Panel9.width;
     panel10.width:=panel9.width;
     BtnCloseL.top:=1;
     BtnOpenL.top:=1;
     BtnCloseL.left:=panel9.width-BtnCloseL.width-2;
     BtnOpenL.left:=panel9.width-BtnCloseL.width-2;
     BtnCloseR.top:=1;
     BtnOpenR.top:=1;
     BtnCloseR.left:=panel10.width-BtnCloseR.width-2;
     BtnOpenR.left:=panel10.width-BtnCloseR.width-2;
 *)
     Constraints.MaxWidth:=950;//Panel5.width+ScanParamsWND.Width+3+SignalsMode.width;
     Constraints.MinWidth:=950;//Panel5.width+ScanParamsWND.Width+3+SignalsMode.width;//;Panel5.width+ScanParamsWND.Width+3;
     if Screen.Height<=800  then
                            begin
                             Constraints.MaxHeight:=round(2.6*PanelTop.Height);
                             Constraints.MinHeight:=round(2.6*PanelTop.Height)
                            end
                            else
                            begin
                              Constraints.MaxHeight:=3*PanelTop.Height;
                              Constraints.MinHeight:=3*PanelTop.Height
                            end;
     Panel3.width:=PanelDown.width div 2;
     Panel3.height:=PanelDown.height;
     Panel3.Top:=0;
     Panel3.Left:=0;
     panel4.top:=0;
     Panel4.Left:=Panel3.width;
     Panel4.width:=PanelDown.width-panel3.width;
     Panel4.height:=Panel3.height;
     PageCtlLeft.align:=alClient;
     ImageSideL.Left:=0;
     ImageSideL.Top:=2;
     ImageMatrix.Left:=0;
     ImageMatrix.Top:=2;
     PanelRight.Align:=alClient;
     PanelChartL.left:=1;
     PanelChartL.top:=28;
     PanelChartL.width:=TabSheetTopoL.ClientWidth-3;
     PanelChartL.height:=TabSheetTopoL.ClientHeight-28;
     PanelChart.left:=1;
     PanelChart.top:=28;
     PanelChart.width:=PanelRight.ClientWidth-3;
     PanelChart.height:=PanelRight.ClientHeight-28;
     PanelChartLEr.left:=1;
     PanelChartLEr.top:=28;
     PanelChartLEr.width:=TabSheetTopoL.ClientWidth-3;
     PanelChartLEr.height:=TabSheetTopoL.ClientHeight-28;
//***************************
      SetImageSideLSize;//SetImagesSize;
      ImgRInit;
      ImgLInit;
//****************************
     panelScanM.top:=0;
     panelScanM.Height:=26;
     panelScanM.Align:=alTop;
     PanelScanImage.Align:=alClient;
     wh:=PanelScanImage.ClientWidth;
  if wh>PanelScanImage.ClientHeight then wh:=PanelScanImage.ClientHeight;
     ImageScanArea.Height:=wh;
     ImageScanArea.Width:=wh;
     ImageScanArea.Picture.Bitmap.width:=wh;
     ImageScanArea.Picture.Bitmap.height:=wh;
     ImageScanArea.top:=0;
     ImageScanArea.left:=0;
     Img2XBegin:=0;
     Img2YBegin:=0;
     DelImgX:=(ScanParams.XMax/ImageScanArea.Width);
     DelImgY:=(ScanParams.YMax/ImageScanArea.Height);

     ScanAreaBitMapTemp.width:=ImageScanArea.Picture.Bitmap.width;
     ScanAreaBitMapTemp.height:=ImageScanArea.Picture.Bitmap.height;

   with ScanParams do
    begin
     R_S.Left  := round(XBegin/DelImgX);
     if R_S.Left<0 then R_S.Left:=0;
     R_S.Top   := ImageScanArea.Height-round((YBegin+Y)/DelImgY);
     if R_S.Top<0  then  R_S.Top:=0;
     R_S.Right :=round((XBegin+X)/DelImgX);
     if R_S.Right> ImageScanArea.width then   R_S.Right:=ImageScanArea.width;
     R_S.Bottom:=ImageScanArea.Height-round((YBegin)/DelImgY);
     if   R_S.Bottom>ImageScanArea.Height then  R_S.Bottom:=ImageScanArea.Height;
    end;
   with ImageScanArea do
    begin
      DrawRectScanArea;
      Canvas.Polyline([Point(R_S.Left,R_S.Bottom),Point(R_S.Left,R_S.Top),
      Point(R_S.Right,R_S.Top),Point(R_S.Right,R_S.Bottom),Point(R_S.Left,R_S.Bottom)]);
     end;
     R:=R_S;
end;

procedure TScanWnd.FormCreate(Sender: TObject);
var
    XMaxTmp,YMaxTmp:single;
    value: single;
    NewItem:TMenuItem;
    DemoInfoStructResult:integer;
    discrVal:integer;
begin
//   UpdateStrings;
  //     FlgApproachOK:=true; //291012
   flgNew_XYBegin:=true; // 11/02/13         or false; ??????
if (flgUNit=ProBeam) or (flgUnit=MicProbe)then MinValidMicroStepDelay:=MinValidMicroStepDelaySEM;
  // Nanoedu.GetCurrentPosition;
   CaptionAdd:='';
   StopBtn.Down:=true;
   ReniShawparams.flgSteponNets:=false;
// oldFlgXYLinear:=ScannerCorrect.FlgXYLinear;
   FlgReniShawUnit:=FlgRenishawUnitExists and ((flgUnit=nano) or (flgUnit=pipette) or (flgUnit=terra) );
   FlgReniShawUnit:=FlgReniShawUnit and (FlgCurrentUserLevel<>Demo);
   flgApproachClick:=false;
   LandingBtn.Visible:=not (FlgCurrentUserLevel=Beginner);
   ScanAreaBitMapTemp:=TBitmap.Create;
   ImgRBitMapTemp:=TBitmap.Create;
   CursorSaved:=Screen.Cursor;
   siLangLinked1.ActiveLanguage:=Lang;
   signalsmode.siLangLinkedf1.ActiveLanguage:=Lang;
   mcrn:=#181+'m';
   if Lang=2 then     mcrn:='мкм' ;
    CaptionDemo:='';
 //  if CurrentUserLevel='Demo' then CaptionDemo:=siLangLinked1.GetTextOrDefault('IDS_34' { 'Демо!!  ' } );
      UpdateStrings;
     

    Application.ProcessMessages;
  //  RadioTypeLitho.visible:=false;
    PanelFltr.visible:=false;
    RadioTypeLitho.visible:=true;
    RadioTypeLitho.enabled:=true;
 {$IFDEF FULL}
    PanelFltr.visible:=true;
    if   ComboBoxPath.Items.count<>4 then
    begin
      ComboBoxPath.Items.Add('X+X+');
      ComboBoxPath.Items.Add('Y+Y+');
    end;
 {$ENDIF}
     tmax:=1;
     tmin:=0;
     tmaxph:=1;
     tminph:=0;
     LinePointsMax:=ScanSizeMax;

     PidParams.Ti:=PidParams.TiScan;

    with PidParams do
    begin
      with SignalsMode do
      sbTi.Position:=round(PidParams.Ti);// round(sbTi.Max*(abs(PidParams.Ti))/PidParams.TiAbsMax); 250112
      NanoEdu.SetPIDParameters;
    end;

    case STMflg of
false:  NanoEdu.SetPoint:=ApproachParams.SetPoint;
 true:  NanoEdu.SetPoint:=ApiType(round(ApproachParams.SetPoint*TransformUnit.nA_d));
      end;
     if not FlgApproachOK  then
      if assigned(frBeginner) then
        siLangLinked1.MessageDlgPos(scan3(* 'No Interaction!!!!' *) ,mtwarning,[mbOK],0, frBeginner.left{300},
                     frBeginner.top+frBeginner.height div 3{100})
      else    MessageDlgCtr(scan3 (* 'No Interaction!!!!' *) ,mtwarning,[mbOK],0) ;
     flagMoveArea:=False;
     WorkNameFile:= workdirectory+'\'+WorkNameFileMaskCur+WorkExtFile;
     FlgFirstDrawImgR:=True;
     FlgFirstDrawImgL:=True;
     flgReg:=0;  //Windows Region active
     flgChange:=false;
     flgLoadMatrixImage:=false;
     flgImgRghtScanArea:=false;
     flgProjection:=false;
     flgTopRDraw:=False;
     flgMouseDown:=False;
     OldFlgFixStep:=false;//True;//false;
     FlgPressApply:=0;
     flgScanDone:=False;
     flgStopScan:=True;
     flgViewTypeL:=0; //side
     flgRightView:=true;
     flgLeftView:=true;
     FlgScanError:=False;
     RadioTypeLitho.Visible:=flgAnodeLithoEnable;
     RadioTypeLitho.itemindex:=0;
     LithoParams.VMax:=$7FFF;    // 10 V discret
     LithoParams.VMin:=apitype($8000);   //-10 Vdiscret

      case RadioTypeLitho.itemindex of
    0: begin   //Force
        Scanparams.ScanMethod:=Litho;
        TimeActScale:=1e-6;
        LithoTransform:=TransformUnit.Znm_d ;
        LabelAction.Caption:=siLangLinked1.GetTextOrDefault('IDS_40' (* 'Action nm' *) );
                with ScrollBarLitho do
                 begin
                   Min:=0;
                   Max:=round((MaxApiType div 2)/TransformUnit.Znm_d/100)*100 ;//Max:=MaxApiType div 4 ; //071116 
                   SmallChange:=50;
                   LargeChange:=50;
                   LithoParams.ScaleAct:=0.5;
                   Position:=100;//round(255*LithoParams.ScaleAct);
                   if Position>Max then Position:=Max;
                   if Position<Min then Position:=Min;
                    Visible:=True;
                    Value:=Position;///LithoTransform;
                 end;
       end;
    1: begin     //Current
        Scanparams.ScanMethod:=LithoCurrent;
        TimeActScale:=1e-3;
        LithoTransform:=TransformUnit.BiasV_d ;
        LabelAction.Caption:=siLangLinked1.GetTextOrDefault('IDS_41' (* 'Action V' *) );
           with ScrollBarLitho do
                 begin
                   Min:=Round(apitype($8000)/LithoTransform)*10;
                   Max:=Round($7FFF/LithoTransform)*10;
                   SmallChange:=1;
                   LargeChange:=1;
                   LithoParams.ScaleAct:=0;
                   Position:=0;
                   if Position>Max then Position:=Max;
                   if Position<Min then Position:=Min;
                    Visible:=True;
                    Value:=Position;///LithoTransform;
                 end;
         LithoParams.TimeAct:=250;
         LithoParams.V:=round(value*LithoTransform);
         with ScrollBarTime do
         begin
                  Max:=5000;
                  Min:=0;
                  Position:=250;
                  SmallChange:=10;
                  LargeChange:=10;
         end;
       end;
              end;//case
     BitBtnActLitho.Font.Color:=clRed;
     BitBtnTimeAct.Font.Color:=clRed;
     BitBtnTimeAct.text:=Format('%d',[round(LithoParams.TimeAct/ScrollBarTime.LargeChange)*ScrollBarTime.LargeChange]);
     ScanData:=TExperiment.Create;
     ArPntSpector:=TList.Create;
     ArPntSpector.Clear;
     ArPntSpector.Capacity:=20;
     ScDrawThreadActive :=False;
     ScDrawLithoThreadActive :=False;
     ScanOnProgr:=True;      //Active ScanWND
     SetScanNormData(ScanNormData);
     SetScanNormData(ScanNormData_2_Pass);
     TopVScale:=2;
     SideVScale:=8;
     CurScanWindowH:=0.8;
     UpDownNx.Max:=LinePointsMax;
     UpDownNy.Max:=LinePointsMax;
     with  Main do
     begin
      ComboBoxSFMSTM.enabled:=false;
      Scanning.visible:=False;
      Landing.visible:=False;
      Resonance.visible:=False;
     end;
   if assigned( ApproachOpt) then  ApproachOpt.ComboBoxPath.Enabled:=false;
     SaveExpBtn.Enabled:=False;   SaveExpBtn.Visible:=False;
     BitBtnRect.visible:=Scanparams.flgSQ;
     BitBtnSQ.visible:=not Scanparams.flgSQ;
     SpeedBtnPlDel.Down:=ScanParams.flgTopoCurLinePlDel;
     SpeedBtnDelTop.Down:=ScanParams.flgTopoTopViewPlDel;
     SpeedBtnDelTopL.Down:=ScanParams.flgTopoTopViewPlDel;
     SpeedBtnSDelTopL.Down:=ScanParams.flgTopoTopViewSDel;
     SpeedBtnSDelTop.Down:=ScanParams.flgTopoTopViewSDel;
     edNY.Enabled:=False;
     UpDownNy.enabled:=true ;
     ZIndicatorScan.Maximum:=MaxApiType;
     ZIndicatorScan.HighLimit:=round(ApproachParams.ZGateMax*MaxApiType);
     ZIndicatorScan.LowLimit:=round(ApproachParams.ZGateMin*MaxApiType);
     ZIndicatorScan.IndicColor:=clNavy;
     ZIndicatorScan.Hint:=siLangLinked1.GetTextOrDefault('IDS_43' (* 'the Indicator Z' *) );
     a:=0;
     b:=ZIndicatorScan.Maximum;//-a;
     ScanParams.ScanMethod:=Topography;  { TODO : 220506 }
     ScanParams.flgSpectr:=false;
     ScanParams.flgProfile:=false;
     PageCtlRight.ActivePage:=TabsheetTopoR;  { TODO : 060906 }
     CurrentActivePage:=PageCtlRight.ActivePage;
     TabSheetTopoR.TabVisible:=True;
     TabSheetTopoL.TabVisible:=False;
     TabSheetMatrix.TabVisible:=False;
     TabSheetSideL.TabVisible:=True;
     TabSheetTopoR.HighLighted:=True;
     TabSheetSideL.HighLighted:=True;
     TabSheetCurScan.Caption:=siLangLinked1.GetTextOrDefault('IDS_44' (* 'Topo, nm' *) );
     if  FlgCurrentUserLevel=Demo    then TabSheetScanTran.TabVisible:=false;  // Demo
     if (ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY) then TabSheetTopoError.TabVisible:=true;
       ComboBoxIZ.Visible:=false;
   (*    if  flgUnit=Pipette then
       begin
        ComboBoxIZ.Items.Add('A-Z');
        comboBoxIZ.ItemIndex:=2;
        SpectrParams.flgIZ:=false;
       end;
    *)
       CaptionAdd:='';
              case  STMFlg of
   True: begin
            labelAction.Caption:=siLangLinked1.GetTextOrDefault('IDS_41' (* 'Action V' *) );
            TabSheetLitho.TabVisible:=false;
            TabSheetUAMR.TabVisible:=False;
            TabSheetPhaseR.TabVisible:=False;
            if true{FlgCurrentUserLevel>Beginner} then
            begin
             if ((flgUnit=ProBeam)or (flgUnit=MicProbe)) and (FlgCurrentUserLevel<>Demo) then
             begin
              TabSheetFastTopo.TabVisible:=True;
             // CaptionBase:=CaptionDemo+siLangLinked1.GetTextOrDefault('IDS_47' (* 'Sample Surface Scanning; STM Fine Regime' *) );
              CaptionBase:=CaptionDemo+siLangLinked1.GetTextOrDefault('IDS_48' (* 'Sample Surface Scanning; STM Rough Regime' *) );
              Caption:=CaptionBase+Captionadd+CaptionRenishaw;
             end
             else
             begin
            //  TabSheetFastTopo.TabVisible:=true;//True;        23/12/15
              CaptionBase:=CaptionDemo+siLangLinked1.GetTextOrDefault('IDS_48' (* 'Sample Surface Scanning; STM Rough Regime' *) );
              Caption:=CaptionBase+Captionadd+CaptionRenishaw;
             end;
             TabSheetCurR.TabVisible:=True;
             TabSheetSpectrR.TabVisible:=True;
             SignalsMode.tbSTM.TabVisible:=True;
            end
            else
            begin
             TabSheetCurR.TabVisible:=False;
             TabSheetSpectrR.TabVisible:=false;
            end;
            TabSheetCurR.HighLighted:=False;
            TabSheetLitho.HighLighted:=False;
            SignalsMode.LabelFB.Caption:=FloatToStrf(PIDParams.Ti, fffixed,5,2);
            SignalsMode.tbSFMCUR.TabVisible:=False;
            SignalsMode.tbSFM.TabVisible:=False;
            SignalsMode.btnSetPoint.Caption:=
                      FloatToStrF(ApproachParams.SetPoint*ITCor,fffixed,5,2)+siLangLinked1.GetTextOrDefault('IDS_49' (* ' nA' *) );
            if ApproachParams.BiasV<0 then   SignalsMode.btnBiasV.Font.Color:=clBlue
                                      else   SignalsMode.btnBiasV.Font.Color:=clRed ;
            SignalsMode.btnBiasV.Caption:=
                      FloatToStrF(ApproachParams.BiasV,fffixed,5,2)+siLangLinked1.GetTextOrDefault('IDS_50' (* ' V' *) );
           end;
    False: begin //SFM
             SignalsMode.lbSuppress.Caption:=FloatToStrF((1-ApproachParams.SetPoint),fffixed,4,2);
             SignalsMode.lbSuppressI.Caption:=FloatToStrF((1-ApproachParams.SetPoint),fffixed,4,2);
              TabSheetUAMR.TabVisible:=True;
              TabSheetPhaseR.TabVisible:=True ;
              TabSheetSpectrR.TabVisible:=True;
              TabSheetLitho.TabVisible:=(flgUnit<>Pipette) and (flgUnit<>Terra);//and (flgUnit<>ProBeam);  //250116
              TabSheetCurR.TabVisible:=False;
             if flgUnit=Terra then      TabSheetCurR.TabVisible:=true;
             if ((flgUnit=ProBeam)or (flgUnit=MicProbe)) and (FlgCurrentUserLevel<>Demo) then  TabSheetFastTopo.TabVisible:=true;//True;   //231215
              CaptionBase:=CaptionDemo+siLangLinked1.GetTextOrDefault('IDS_53' (* 'Sample Surface Scanning; SFM Rough Regime' *) );
              Caption:=CaptionBase+Captionadd+CaptionRenishaw;
              TabSheetUAMR.HighLighted:=False;
              TabSheetPhaseR.HighLighted:=False;
              TabSheetSpectrR.HighLighted:=False;
              TabSheetFastTopo.HighLighted:=False;
              TabSheetLitho.HighLighted:=False;
              SignalsMode.tbSFMCUR.TabVisible:=False;
              SignalsMode.tbSFM.TabVisible:=True;
              SignalsMode.tbSTM.TabVisible:=False;
             if ApproachParams.BiasV<0 then  SignalsMode.btnBiasSFM.Font.Color:=clBlue
                                       else  SignalsMode.btnBiasSFM.Font.Color:=clRed ;
             {$IFDEF FULL}
                 if flgUnit=Pipette  then
                  begin
                    SignalsMode.tbSTM.TabVisible:=False;
                    SignalsMode.tbSFM.TabVisible:=False;
                    SignalsMode.tbSFMCUR.TabVisible:=True;
                  end;
              {$ENDIF}
            SignalsMode.LabelFB.Caption:=FloatToStrf(PIDParams.Ti, fffixed,5,2);
            SignalsMode.GainFMbtn.Caption:=FloatToStrF(ApproachParams.Gain_FM,fffixed,5,2);
           end
             end; //case STMflg

   if PageCtlRight.ActivePage.PageIndex=1   then    SignalsMode.PanelGain.Visible:= True;
   if STMflg  then TabSheetFastTopo.Caption:=siLangLinked1.GetTextOrDefault('IDS_185' (* 'Fast Scan/Current' *) )
              else TabSheetFastTopo.Caption:=siLangLinked1.GetTextOrDefault('IDS_186' (* 'Fast Scan/Phase' *) );

     PageCtrlAdd.ActivePage:=TabSheetCurScan;
     TabSheetCurScan.HighLighted:=true;
     SeriesLine.Active:= (PageCtrlAdd.ActivePage=TabSheetCurScan);
     SeriesAddLine.Active:=not  (PageCtrlAdd.ActivePage=TabSheetCurScan);
     ChartCurrentLine.LeftAxis.SetMinMax(0,1);
     ChartCurrentLine.BottomAxis.Automatic:=false;
     ChartCurrentLine.LeftAxis.Automatic:=false;
     TabSheetCurLineAdd.TabVisible:=(ScanParams.ScanMethod<>Topography) and (ScanParams.ScanMethod<>OneLineScan);      //???
     TabSheetProfiler.TabVisible:=(flgUnit=ProBeam)or (flgUnit=MicProbe);
    // SignalsMode.FrequencyTrack.Position:= ApproachParams.FreqBandF;
       // FINE PID CONTROL
 (*   with PidParams do
    begin
            // rough
        with SignalsMode do
          sbTi.Position:= round(sbTi.Max*(abs(PidParams.Ti))/PidParams.TiAbsMax);

    //  InitPIDFine(abs(Ti), TiAbsMax, pidTiL1, pidTiL2);
    //  with SignalsMode do
    //       sbTi.Position:= round(sbTi.Max*(abs(Ti)-pidTiL1)/(pidTiL2-pidTiL1));
    end;
    *)
     ImageSideL.Stretch:=True;
     ImgRChart.ControlStyle :=  ImgRChart.ControlStyle  + [csOpaque];
     ImgLChart.ControlStyle :=  ImgRChart.ControlStyle  + [csOpaque];
     ImageSideL.ControlStyle:=  ImageSideL.ControlStyle + [csOpaque];
     PageCtrlScan.ControlStyle  := PageCtrlScan.ControlStyle + [csOpaque];
     ImageScanArea.ControlStyle := ImageScanArea.ControlStyle + [csOpaque];
  //   Panel8.Visible:=True;
 (*  180211
  if STMFlg then  SignalsMode.PageControl1.ActivePageIndex:=1
      else
       begin
        with SignalsMode do
         begin
          PageControl1.ActivePageIndex:=0;
          PanelGain.Visible:=False;
         end;
       end;
  *)
   if FlgCurrentUserLevel=Demo then          { TODO : 14/03/06 }
        begin
          DemoInfoStructResult:=CreateDemoInfoStruct;
        end;
   if flgAllDataReadFromAdapter then ApprLinesParamsCalcFromAdapter
                                else ApprLinesParamsCalc(HardWareOpt.ScannerNumb);
    SetXYMax;
  if FlgCurrentUserLevel =Demo then   SetXYMaxDemo(PageCtlRight.ActivePageIndex);
  InitWinScanAreaParams;
  PageCtrlScan.ActivePage:=TabSheetScanArea;
  PageCtrlScan.ActivePage.HighLighted:=True;

/////****************//////////

  SetWndComponetsSize;
  ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_58' (* 'Topography' *) );
  ClearTabImages;
  ComboBoxPath.ItemIndex:=ScanParams.ScanPath;
  ComboBoxFilter.ItemIndex:=1;
// ****
   SetTypeScanPath;

     ScanParams.flgFilter:=ComboBoxFilter.ItemIndex;
     EditDacZSpeed.text:=inttostr(ScanParams.DACZTimeDelay);
     LblEDitDecay.Text:=inttostr(ScanParams.IntegrDecay);
     LEditDz.Text:=inttostr(ScanParams.PassIIDz);
     PanelChartL.height:=TabSheetTopoL.ClientHeight-28;
     PanelChartLEr.height:=TabSheetTopoError.ClientHeight-28;
     ImgLInit;
  if  Scanparams.flgStepXY then  CheckBoxStepClick(Sender);
  BitMapTemp:=TBitMap.Create;
  BitMapLTemp:=TBitMap.Create;
/////****************//////////
  PageCtlLeft.ActivePage:=TabSheetSideL;
  PageCtlRight.ActivePage:=TabSheetTopoR;
  ImageSideL.Canvas.Pen.Color:=clBlack;
  edScanRate.Text:=FloatToStrF(ScanParams.ScanRate,ffFixed,10,0);
  edScanRateBW.Text:=FloatToStrF(ScanParams.ScanRateBW,ffFixed,10,0);
  flgSpeedLock:=true;
  EdScanRateBW.Enabled:=not flgSpeedLock;
  UpDownSpeedBW.Enabled:=not flgSpeedLock;
      case  flgUnit  of
nano,ProBeam, MicProbe,
Pipette,
terra: begin
        lblYmax.Caption:=InttoStr(round(ScanParams.Ymax/1000))+' '+mcrn{#181+'m'};  //micron
        lblXmax.Caption:=InttoStr(round(ScanParams.Xmax/1000))+' '+mcrn{#181+'m'};
       end;
baby: begin
        lblYmax.Caption:=InttoStr(round(ScanParams.Ymax))+ siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );  //nm
        lblXmax.Caption:=InttoStr(round(ScanParams.Xmax))+ siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );
       end;
grand: begin
        lblYmax.Caption:=InttoStr(round(ScanParams.Ymax/1000))+' '+mcrn;//micron;  //nm
        lblXmax.Caption:=InttoStr(round(ScanParams.Xmax/1000))+' '+mcrn;
       end;
           end;
           ScrollBarTTerra.position:=Scanparams.TerraTDelay;
          lblEditTTerra.text:=inttostr(ScanParams.TerraTDelay);
 //  flgMoveToBeginDAC:=false;
   CheckboxDrift.Checked:=false;
  {$IFNDEF DEBUG}
//   if  (CurrentUserLevelFlg=Demo) then  FlgRenishawUnitExists:=false;
  {$ENDIF}
  //150909
//   FlgReniShawUnit:=FlgRenishawUnitExists and (flgUnit=nano) and flgRenishawEnable;
//   FlgReniShawUnit:=FlgReniShawUnit and (FlgCurrentUserLevel<>Demo);

 (*  if FlgReniShawUnit then
    begin
      BitBtnMgOut.Visible:=FALSE;
      BitBtnMgIn.Visible:=FALSE;
    end;
   *)

//   SpeedBtnRenishaw.visible:=FlgReniShawUnit;
//   SpeedBtnRenishaw.down:=not FlgReniShawUnit;
   CheckBoxonNets.Visible:=FlgReniShawUnit;
  if FlgReniShawUnit then
  begin
    CheckBoxRS.Visible:=FlgReniShawUnit;
    CheckBoxRS.Checked:=FlgReniShawUnit;
    SpeedBtnRenishawExecute;
 //   flgMoveToBeginDAC:=true;
    CheckBoxDrift.Checked:=false;
  end;
  if SetMotionParameters>0 then exit;

  BitBtnMgOut.Visible:=false;//(HardWareOpt.XYTune='Fine');// and not FlgReniShawUnit;
  BitBtnMgIn.Visible:=false;//not (HardWareOpt.XYTune='Fine');// and not FlgReniShawUnit;
   case  ScanParams.flgOneFrame of
true: begin  SpdBtnOneFrame.Caption:='1'; SpdBtnRecord.visible:=false; end;
false: begin SpdBtnOneFrame.Caption:='V'; SpdBtnRecord.visible:=true; end;
             end;
  NanoEdu.FineXY:=(HardWareOpt.XYTune='Fine');
        TabSheetLItho.Visible:=true;
        UpDownNx.position:=0;
        UpDownNy.position:=0;
        NewItem := TMenuItem.Create(Self);
        NewItem.Caption :='-';
        Main.mWindows.Add(NewItem);
        NewItem := TMenuItem.Create(Self);
        NewItem.Caption := self.Caption;
        NewItem.OnClick:=Main.ActivateMenuItem;
        Main.mWindows.Add(NewItem);

        LabelZV.Font.color:=clNavy;
        ApplyBtnClick(sender);//;.Perform(BM_Click,0,0);
        ImageList2.GetBitmap(9,SpdBtnRecord.glyph) ;
        FlgTimerActive:=false;
        flgStopTimer:=false;
        Timer.Enabled:=true;
        Timer.Interval:=200;
        Scanparams.flgspectr:=false;
        CaptionRenishaw:='';
        if FlgRenishawUnit then  CaptionRenishaw:=siLangLinked1.GetTextOrDefault('IDS_18' (* '  Renishaw' *) );
         Caption:=captionBase+captionadd+CaptionRenishaw;
end;

procedure TScanWnd.FormResize(Sender: TObject);
begin
  SetWndComponetsSize;
end;
(*
procedure TScanWnd.WMDisplayChange(var message: TMessage);
begin
     SetWndComponetsSize;
     ImgRInit;
     ClearTabImages;
     RebuildWindowRgn;
end;
*)

procedure TScanWnd.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
 begin
     FreeAndNil(ScanData);
     FreeAndNil(BitMapTemp);
     FreeAndNil(BitMapLTemp);
     FreeAndNil(ScanAreaBitmapTemp);
     FreeAndNil(ImgRBitMapTemp);
     JMPX:=nil;
     JMPY:=nil;
     ScanOnProgr:=False;
    if assigned(FieldZoom)       then FieldZoom.Close;
    if assigned(CurrentLineWnd)  then CurrentLineWnd.Close;
    if assigned(fX0Y0Change)     then fX0Y0Change.Close;
    if assigned(SetInteraction) then  SetInteraction.close;
    Application.processmessages;
       if FlgApproachOK and STMflg then  Main.ComboBoxSFMSTM.Enabled:=false
                                   else  Main.ComboBoxSFMSTM.Enabled:=true;
       Main.Scanning.Visible:=true;
   //if FlgUnit<>SEM then
    Main.Training.Visible:=(not FlgApproachOK) and (not FlgTooClose);//not FlgApproachOK;//false;
   if not STMflg then
   begin
       Main.Resonance.Visible:=(not flgApproachOK) and (not FlgTooClose);
   end;
       Main.Landing.Visible:=True;
 if assigned(ApproachOpt) then  ApproachOpt.ComboBoxPath.Enabled:=true;
 if assigned(ArPntSpector)then
  begin
   for i := 0 to (ArPntSpector.Count - 1) do
    begin
     PntSpector := ArPntSpector.Items[i];
     Dispose(PntSpector);
    end;
    FreeAndNil(ArPntSpector);
  end;
  if assigned(SpectrWnd)  then  SpectrWnd.close;
  if assigned(SpectrWndV) then  SpectrWndV.close;
    Application.processmessages;
    Action:=caFree;
    ScanWND:=nil;
    Finalize(DemoDataInfoArray);
    if  flgApproachClick then  Main.LandingSlowExecute(sender);
end;

procedure TScanWnd.RebuildWindowRgn;
var
  Rgn: THandle;
  ClientX, ClientY: Integer;
begin
  // определяем относительные координаты клиенской части
  ClientX:= (Width - ClientWidth) div 2;
  ClientY:= Height - ClientHeight - ClientX;
  // создаем регион для всей формы
  FullRgn:= CreateRectRgn(0, 0, Width, Height);
// создаем регион для клиентской части формы
// и вычитаем его из FullRgn
          case  flgreg of
  0: begin             //open   3 when 4 close
     end;
  1: begin             //open
     with Panel3 do
      begin
        Rgn:= CreateRectRgn(PanelDown.left-ClientX+left, ClientY+PanelDown.top+Top, ClientX+PanelDown.left +left+ width, 2*ClientY-3 +
        Height+PanelDown.top+Top);
        CombineRgn(FullRgn, FullRgn, Rgn, rgn_or);
      end
     end;
  2: begin               //close
      with Panel3 do
       begin
        Rgn:= CreateRectRgn(PanelDown.left-ClientX+left, ClientY+PanelDown.top+Top, ClientX+PanelDown.left+left+ width, 2*ClientY-3 +
        Height+PanelDown.top+Top);
        CombineRgn(FullRgn, FullRgn, Rgn, rgn_Diff);
       end
     end;
  3: begin        // open
     with Panel4 do
      begin
        Rgn:= CreateRectRgn(ClientX+PanelDown.left+left, ClientY+PanelDown.top+Top, 2*ClientX+3+PanelDown.left +left+ width, 2*ClientY+3 +
        Height++PanelDown.top+Top);
        CombineRgn(FullRgn, FullRgn, Rgn, rgn_or);
      end
     end;
  4: begin         //close
      with Panel4 do
       begin
         Rgn:= CreateRectRgn(ClientX+PanelDown.left+left, ClientY+PanelDown.top+Top, 2*ClientX+3 +PanelDown.left+left+ width, 2*ClientY+3 +
         Height+PanelDown.top+Top);
         CombineRgn(FullRgn, FullRgn, Rgn, rgn_Diff);
       end
     end;
   5: begin         //close
      with PanelDown do
       begin
         Rgn:= CreateRectRgn(-ClientX+left, ClientY+Top, 2*ClientX+3 +left+ width, 2*ClientY+3 +
         Height+Top);
         CombineRgn(FullRgn, FullRgn, Rgn, rgn_Diff);
       end
      end;
  6: begin   //open  4 when 3 close
      with Panel4 do
      begin
        Rgn:= CreateRectRgn(ClientX+PanelDown.left+left, ClientY+PanelDown.top+Top, 2*ClientX+3+PanelDown.left +left+ width, 2*ClientY+3 +
        Height++PanelDown.top+Top);
        CombineRgn(FullRgn, FullRgn, Rgn, rgn_or);
      end;
      with Panel3 do
       begin
        Rgn:= CreateRectRgn(PanelDown.left-ClientX+left, ClientY+PanelDown.top+Top, ClientX+PanelDown.left+left+ width, 2*ClientY-3 +
        Height+PanelDown.top+Top);
        CombineRgn(FullRgn, FullRgn, Rgn, rgn_Diff);
       end
     end;
         end; //case
  // устанавливаем новый регион окна
  SetWindowRgn(Handle, FullRgn, True);
end;

procedure TScanWnd.OptionsBtnClick(Sender: TObject);
begin
if not assigned(ApproachOpt) then
 begin
   ApproachOpt:=TApproachOpt.Create(Application,ApproachOpt);
  with ApproachOpt do
  begin
     ScanOptSheet.TabVisible:=True;
     ApprOptSheet.TabVisible:=True;
  end;
//  Main.ShowOptions.Enabled:=False;
 end
 else  ApproachOpt.SetFocus;
end;

procedure TScanWnd.RestoreStartSFM;
begin
       case STMflg of
 False:begin
        if true{FlgCurrentUserLevel>Beginner} then
        begin
         TabSheetUAMR.TabVisible:=True;
         if (flgUnit<>Pipette) and (flgUnit<>Terra)  then TabSheetLitho.TabVisible:=True; //250116
         TabSheetPhaseR.TabVisible:=True;
        // {$IFDEF FULL}
            TabSheetCurR.TabVisible:=flgUnit=Terra;//true;
        // {$ELSE}
        //    TabSheetCurR.TabVisible:=False;
      //   {$ENDIF}
        if  FlgCurrentUserLevel<>Demo            then  TabSheetScanTran.TabVisible:=True;
         if (ScanParams.ScanMethod<>Topography)  and (ScanParams.ScanMethod<>OneLineScan)  and (ScanParams.ScanMethod<>FastScan)
         and (ScanParams.ScanMethod<>FastScanPhase)
          { and (not ScanParams.flgSpectr)  }    then TabSheetTopoL.TabVisible:=True
                                                 else TabSheetTopoL.TabVisible:=False;
         if (ScanParams.ScanMethod=Litho) or (ScanParams.ScanMethod=LithoCurrent) then TabSheetSideL.TabVisible:=False;
         //if HardWareOpt.XYtune='Fine'   then
        //if (FlgCurrentUserLevel<>Demo) then TabSheetFastTopo.TabVisible:=true;//True;    231215
        end
        else
        begin
         if (flgUnit<>Pipette)  and  (flgUnit<>Terra) (*and (flgUnit<>ProBeam)*)then TabSheetLitho.TabVisible:=True;  //250116
        end;
       end;
  True:begin
        if true{FlgCurrentUserLevel>Beginner} then
        begin
         TabSheetLitho.TabVisible:=false;
         TabSheetUAMR.TabVisible:=False;
         TabSheetPhaseR.TabVisible:=False;
         TabSheetCurR.TabVisible:=True;
     //    TabSheetTopoL.TabVisible:=False;
         if  FlgCurrentUserLevel<>Demo            then  TabSheetScanTran.TabVisible:=True;
         if (ScanParams.ScanMethod<>Topography)and (ScanParams.ScanMethod<>OneLineScan) and (ScanParams.ScanMethod<>FastScan)
         and (ScanParams.ScanMethod<>FastScanPhase)
                                      then TabSheetTopoL.TabVisible:=True
                                      else TabSheetTopoL.TabVisible:=False;
         //if HardWareOpt.XYtune='Fine' then
         if (flgUnit=ProBeam) or (flgUnit=MicProbe)then TabSheetFastTopo.TabVisible:=true;//false;//True; 231215
         if (ScanParams.ScanMethod=FastScan)   or (ScanParams.ScanMethod=FastScanPhase) then
         begin
          StopBtn.enabled:=true;
          RStartBtn.enabled:=true;
         end;

        end;
       end;
           end;
      if  true{FlgCurrentUserLevel>Beginner} then
      begin
       TabSheetSpectrR.TabVisible:=True;
      // SignalsMode.FrequencyTrack.Enabled:=True;
      end;
         TabSheetTopoR.TabVisible:=True;  //
         BitBtnRect.Visible:=ScanParams.flgSQ;//  true;
         BitBtnSq.Visible:=not ScanParams.flgSQ;//true;
         BtnZoom.Visible:=true;
         BitBtnMgIn.Visible:=false;//NOT (HardWareOpt.XYtune='Fine');// and not FlgReniShawUnit;//True;
         BitBtnMgOut.Visible:=false;//(HardWareOpt.XYtune='Fine');// and not FlgReniShawUnit;//True;
         BitBtnX0Y0.visible:=true;
         BtnClear.visible:=true;
      if (ScanParams.ScanMethod=Litho) or  (ScanParams.ScanMethod=LithoCurrent) then
         begin
            edNX.Enabled:=false;
            UpAct.Visible:=false;
            DownAct.Visible:=false;
            edNY.Enabled:=false;
            UpDownNX.enabled:=false;
            UpDownNY.enabled:=false;
            edStepXYM.Enabled:=true;
            BitBtnProject.Enabled:=true;
            BitBtnLoadIm.Enabled:=true;
            BitBtnActLitho.Enabled:=true;
            ScrollBarLitho.Enabled:=true; //100210
            BitBtnRect.Visible:=false;
            BitBtnSq.Visible:=false;
            BitBtnMgIn.Visible:=false;
            BitBtnMgOut.Visible:=false;
            UpDownAct.visible:=false;
            CheckBoxStep.Enabled:=false;
         end
         else
         begin
           edX.enabled:=not CheckBoxStep.checked;
           edY.enabled:=not CheckBoxStep.checked;
         if not CheckBoxstep.Checked then
          case ScanParams.ScanPath of
     Multi,
      OneX:begin
            edNX.Enabled:=True;
            edNY.Enabled:=false;
            UpDownNX.enabled:=true;
            UpDownNY.enabled:=false;
           end;
    MultiY,
      OneY:begin
            edNX.Enabled:=false;
            edNY.Enabled:=True;
            UpDownNX.enabled:=false;
            UpDownNY.enabled:=true;
           end;
                end;
         end;
        if Assigned(ApproachOpt) then
        begin
         ApproachOpt.ScanCorSheet.enabled:=true;
         ApproachOpt.HardWareSheet.enabled:=true;
         ApproachOpt.TabSheetSetScan.enabled:=true;
         ApproachOpt.OkBtn.enabled:=true;
         ApproachOpt.DefaultBtn.enabled:=true;
         ApproachOpt.BitBtnSave.enabled:=lowercase(HardWareOpt.ScannerNumb)<>'demo';
 //       if  lowercase(HardWareOpt.ScannerNumb)<>'demo' then  ApproachOpt.BitBtnSave.enabled:=true;
//       ApproachOpt.BitBtnSave.enabled:=true;
        end;
          DisableTopPanel(false);
          BtnClear.Enabled:=True;
          Main.ToolBtnDir.Enabled:=True;
 //         StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_71' (* '&RUN' *) );
     //     StartBtn.Glyph.Assign(BitMapStart);
     //     StartBtn.Font.Color:=clBlack;
          StartBtn.Enabled:=True;
          flgStopTimer:=false;
          if assigned(Timer) then Timer.Enabled:=TRUE;//    Timer.Enabled:=true;
          ComboBoxPath.enabled:=true;
          ScrollBarLitho.Enabled:=true;

       case  ComboBoxPath.ItemIndex of
    multi,
    multiY : begin
              TabSheetLitho.TabVisible:=false;
              TabSheetSpectrR.TabVisible:=false;
              TabSheetFastTopo.TabVisible:=false;
             end;
                        end;
                          { TODO : 260506 }
       //speed    { TODO : 290607 }
          UpDownSpeed.Enabled:=true;
          EdScanRate.Enabled:=true;
          EdScanRateBW.Enabled:=not flgSpeedLock;
          UpDownSpeedBW.Enabled:=not flgSpeedLock;
       //
       if (ScanParams.ScanMethod<>litho) and (ScanParams.ScanMethod<>lithocurrent)then
       begin
        edX.enabled:=not CheckBoxStep.checked;
        edY.enabled:=not CheckBoxStep.checked;
       end
      else CheckBoxStep.Enabled:=false;
     CheckBoxStep.enabled:=not FlgRenishawUnit and not ((ScanParams.ScanMethod=litho) or (ScanParams.ScanMethod=lithocurrent));
     edStepXY.Enabled:=CheckBoxStep.Checked and (not ReniShawparams.flgSteponNets);
     CheckBoxOnNets.Enabled:=FlgRenishawUnit;
     if UpdownRs.visible then UpdownRs.Enabled:=true;
          SpeedBTnCaptureL.Visible:=false;//ScanWnd.TabSheetTopoL.visible;
          SpeedBTnCapture.Visible :=false;//not ScanWnd.TabSheetTopoL.visible;
          SpeedBtnContrast.Visible :=false;
          SpeedBtnContrL.Visible :=false;
          ScanError:=nil;
          RadioTypeLitho.enabled:=false;
          RadioTypeLitho.enabled:=true;
     if  CheckBoxRS.Visible then   CheckBoxRS.enabled:=true;
  // if  SpeedBtnRenishaw.Visible then   SpeedBtnRenishaw.enabled:=true;
         if FlgReniShawUnit then
             begin
              if Scanparams.ScanMethod in ScanmethodSetOneL then CheckBoxOnNets.Enabled:=true;
            end;
           main.setworkdirectory.enabled:=true;
           TabSheetProfiler.TabVisible:=(flgUnit=ProBeam)or (flgUnit=MicProbe);
           FlgStopScan:=True;
           FlgStopJava:=false;//  210113;
           StopBtn.Down:=true;
           StartBtn.Down:=false;
           LandingBtn.visible:=true;
           if ((flgUnit=ProBeam)or (flgUnit=MicProbe)) and (FlgCurrentUserLevel<>Demo) then TabSheetFastTopo.tabvisible:=true
            else TabSheetFastTopo.tabvisible:=false;
end;

procedure TScanWnd.StartBtnClick(Sender: TObject);
var i:integer;
begin
 if FlgBlickApply then
   begin
    siLangLinked1.MessageDLG(scan4(* 'You have changed ScanParameters. Press Apply button, before start Scan ' *) , mtwarning,[mbOK],0);
     StopBtn.Down:=true;   StartBtn.Down:=false;
     exit
   end;
 if not flgReniShawUnit then
  if (not ScannerCorrect.FlgXYLinear) and (PageCtlRight.ActivePage=TabSheetLitho)     then
   begin
     siLangLinked1.MessageDLG(scan5(* 'Make scanner linearization!' *), mtwarning,[mbOK],0);
     StopBtn.Down:=true;   StartBtn.Down:=false;
     exit
   end;
if (Scanparams.ScanMethod in ScanmethodSetNeedV) and  not ScanParams.flgSpectr then
if (flgUnit<>Terra) and (ApproachParams.BiasV=0) then
    begin
      siLangLinked1.MessageDLG( siLangLinked1.GetTextOrDefault('IDS_69' (* 'Voltage Bias=0. Set Voltage' *) ) , mtwarning,[mbOK],0);
      StopBtn.Down:=true;
      StartBtn.Down:=false;
      exit
    end;
   (* if  not FlgStopScan then //Stop    Scanning
 begin
       FlgStopMulti:=true;
       RStartBtn.Visible:=true;//false;
       StartBtn.Enabled:=false;
       NanoEdu.Method.StopWork;
       NanoEdu.Method.WaitStopWork;
 end
 *)
if   FlgStopScan then       //Start  Scanning
 begin
   FlgStopJava:=False;
   flgStopPressed:=False;
   if flgRenishawUnit then
   begin
   // ScannerCorrect.FlgXYLinear:=False ;
    if UpdownRs.visible then UpdownRs.Enabled:=false;
   end;
    errScan:=0;
    main.setworkdirectory.enabled:=false;
    application.processmessages;
    if flgCurrentUserLevel=Demo then
     if (ConfigDemoScanWnd(PageCtlRight.ActivePageIndex)>0)  then
     begin
      StopBtn.Down:=true;   StartBtn.Down:=false;
      exit;
     end;
     if not flgRenishawUnit then
       if   HardWareOpt.XYtune<>'Fine'   then
         if (not ScannerCorrect.FlgXYLinear) and ((flgUnit=nano) or (flgUnit=Pipette)or (flgUnit=ProBeam) or (flgUnit=MicProbe)) then
           if siLangLinked1.MessageDlg(scan6{ 'You scan without linealization! Continue scan?' },mtConfirmation ,[mbYes,mbNo],0)=mrNo then exit;
     if assigned(ApproachOpt) then
    begin
     ApproachOpt.ScanCorSheet.enabled:=false;
     ApproachOpt.HardWareSheet.enabled:=false;
     ApproachOpt.TabSheetSetScan.enabled:=false;
     ApproachOpt.OkBtn.enabled:=false;
     ApproachOpt.DefaultBtn.enabled:=false;
     ApproachOpt.BitBtnSave.enabled:=false;
    end;
       LandingBtn.visible:=false;
       oldCountStart:=CountStart;
       inc(CountStart);   inc(CountClose);
       Scanparams.CurrentScanCount:=0;
       SeriesLine.Clear;
       SeriesAddLine.Clear;
       Main.setworkdirectory.Enabled:=False;
       WorkNameFile:=workdirectory+'\'+WorkNameFileMaskCur+ScandataWorkFileNameEm(CountStart)+WorkExtFile;
       FlgStopMulti:=False;
       FlgBlickApply:=False;
       FlgStopScan:=False;
       StopBtn.Down:=false;
 //      ToolBarScanWnd.Font.Color:=clRed;
       StartBtn.Enabled:=False;
      if  CheckBoxRS.Visible then   CheckBoxRS.enabled:=false;
       edNX.Enabled:=False;
       UpDownNX.enabled:=false;
       UpDownNY.enabled:=false;
       edNy.Enabled:=False;
       edY.Enabled:=False;
       edX.Enabled:=False;
       CheckBoxStep.enabled:=False;
       CheckBoxOnNets.Enabled:=false;
       ScrollBarLitho.Enabled:=false;
       ComboBoxPath.enabled:=false;
       BtnClear.Enabled:=False;
       BitBtnRect.Visible:=false;
       BitBtnSq.Visible:=false;
       BitBtnMgIn.Visible:=false;
       BitBtnMgOut.Visible:=false;
       BtnZoom.visible:=false;
       BtnClear.visible:=false;
       BitBtnX0Y0.visible:=false;
       if  (ScanParams.ScanMethod=OneLineScan) then
       begin
           edScanRate.Enabled:=false;
          UpDownSpeed.Enabled:=false;
         EdScanRateBW.Enabled:=false;
        UpDownSpeedBW.Enabled:=false;
       end
       else
       begin
         if  HardWareOpt.XYTune='Rough' then
         begin
              edScanRate.Enabled:=true;
             UpDownSpeed.Enabled:=true;
            EdScanRateBW.Enabled:=not flgSpeedLock ;
           UpDownSpeedBW.Enabled:=not flgSpeedLock;
         end
         else
         begin
           if  flgFineSpeedLock then
           begin
                    edScanRate.Enabled:=false;
                   UpDownSpeed.Enabled:=false;
                  EdScanRateBW.Enabled:=false;
                 UpDownSpeedBW.Enabled:=false;
           end
           else
           begin
               edScanRate.Enabled:=true;
              UpDownSpeed.Enabled:=true;
             EdScanRateBW.Enabled:=not flgSpeedLock ;
             UpDownSpeedBW.Enabled:=not flgSpeedLock;
           end;
         end;
       end;
       edStepXY.Enabled:=false;
       RadioTypeLitho.enabled:=false;
       flgStopTimer:=true;
       Timer.Enabled:=false;

       for i:=0 to PageCtlRight.PageCount-1 do
       begin
         PageCtlRight.Pages[i].TabVisible:=PageCtlRight.Pages[i].Highlighted;
       end;
  with PageCtrlScan do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
   ActivePage.HighLighted:=True;
  end;
   Z_d_nm:=1/Transformunit.Znm_d;
 if  ScanParams.flgSpectr then  Spectroscopy
 else
 //if  ScanParams.flgProfile then  Profiling
 //else
 begin    //scanning
   Captionadd:= '  '+ExtractFileName(WorkNameFile);
   Caption:=CaptionBase+CaptionAdd+CaptionRenishaw;
        case ScanParams.ScanMethod of
 Litho,
 LithoCurrent:
         begin
          if    flgLoadMatrixImage and  FlgProjection then
          begin
           Lithography
          end
          else
           begin
           if  not flgLoadMatrixImage then siLangLinked1.MessageDlg(scan7 (* 'Load Image for Lithography!!!' *) ,mtWarning,[mbOk,mbHelp],IDH_LItho);
           if  not flgProjection      then siLangLinked1.MessageDlg(scan8 (* 'Project Matrix on the Area!!!' *) ,mtWarning,[mbOk,mbHelp],IDH_LItho);
             RestoreStartSFM;
           end;
        end;
 FastScan,
 FastScanPhase:
        begin
            case ScanParams.ScanPath of
          OneX,OneY: FastScanning;
                  end;
        end;
   else
        begin
         BitBtnPointClearClick(Sender); //for what?
         SideViewInit;
                case ScanParams.ScanPath of
            OneX,OneY: Scanning;
         MultiY,Multi: ScanningMulti(Sender);
                 end;
        end;
               end;   //case
  end;
 end;   //Start
//{$ENDIF}
end;

procedure TScanWnd.StopBtnClick(Sender: TObject);
var bmp:TBitMap;
begin
 if  not FlgStopScan then //Stop    Scanning
 begin
       flgStopPressed:=true;
       bmp:=Tbitmap.Create();
       flgRecord:= false;
       ImageList2.GetBitmap(9,bmp) ;
       SpdBtnRecord.glyph.assign(bmp);
       FreeandNil(BMP);
       FlgReStart:=false;
       FlgStopMulti:=true;
       StartBtn.Down:=false;
       RStartBtn.Visible:=true;//false;
       StartBtn.Enabled:=false;
//  if assigned(Nanoedu.Method) then
   begin
    flgStopJava:=true;
//    Nanoedu.Method.StopWork
   end;
 end
end;

procedure TScanWnd.Scanning;
var
   i,error:integer;
begin
flgShowLine:=True;
 if not flgRestart then ClearTabImages
                  else
                   begin
                    with ImageSideL do
                     begin
                       Canvas.Brush.Color:=clWhite;
                       Canvas.FillRect(Rect(0,0,Width,Height));
                    end;
                    FlgRestart:=false;
                   end;
  DisableTopPanel(true);
  if flgUnit=Grand then nanoedu.ScanMotorTurnOn;

(*
        NanoEdu.ScanMoveToX0Y0Method(ScanParams.XBias0,ScanParams.YBias0);
        error:=NanoEdu.Method.Launch;
        while assigned(ProgressMoveTo) do application.processmessages;

*)
 if flgNew_XYBegin then      // 11/02/13
    begin
       NanoEdu.ScanMoveToX0Y0Method(ScanParams.Xbegin,ScanParams.Ybegin);
       error:=NanoEdu.Method.Launch;
        if error<>0 then
        begin
          RestoreStartSFM;
          exit
        end;
       while assigned(ProgressMoveTo) do
           begin sleep(10); application.processmessages; end; //23/11/12
     end;
//   FreeAndNil(NanoEdu.Method);         //23/11/12
 //nanoeduII
  error:=0;
  if flgUnit=Grand then nanoedu.ScanMotorTurnOff;

  Application.ProcessMessages;
  DisableTopPanel(false);
  self.enabled:=True;
  StartBtn.Enabled:=true;
  SaveExpBtn.Enabled:=False;  SaveExpBtn.Visible:=False;
  flgFirstPass:=true;
  if (HardWareOpt.XYTune='Fine') and flgFineSpeedLock then
         begin
            edScanRate.Enabled:=false;   edScanRateBW.Enabled:=false;
            UpDownSpeed.Enabled:=false;  UpDownSpeedBW.Enabled:=false;
         end;
  SetLength(ScanError,Scanparams.ScanPoints);       ///don't foget =nil???
  if flgUnit=Grand then nanoedu.ScanMotorTurnOn;
  flgProgressError:=false;
  Application.ProcessMessages;
  PageCtrlScan.ActivePage:=TabSheetCurLine;
  with PageCtrlScan do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
   ActivePage.HighLighted:=True;
  end;
   RStartBtn.Visible:=true;
  with ScanParamsWnd do
      begin
          edScanNmb.Text:='0';
          edDZ.Text:= floattostrf(ScanNormData.ScaleZ0*Z_d_nm,fffixed,5,0);
      end;
    if flgUnit=Grand then nanoedu.ScanMotorTurnOn;
    NanoEdu.ScanningMethod;

    Application.ProcessMessages;
     ScanParams.ScanLineTime:=round(strtofloat(Frametime.Caption)*1000/ScanParams.ScanLines); //ms
     if NanoEdu.Method.Launch<>0 then
     begin FreeAndNil(NanoEdu.Method); RestoreStartSFM; exit end;

    StartBtn.Enabled := True;
    DisableTopPanel(false);
    if  (ScanParams.ScanMethod=OneLineScan) then
       begin
           edScanRate.Enabled:=false;
          UpDownSpeed.Enabled:=false;
         EdScanRateBW.Enabled:=false;
        UpDownSpeedBW.Enabled:=false;
       end
       else
       begin
         if  HardWareOpt.XYTune='Rough' then
         begin
              edScanRate.Enabled:=true;
             UpDownSpeed.Enabled:=true;
            EdScanRateBW.Enabled:=not flgSpeedLock;
           UpDownSpeedBW.Enabled:=not flgSpeedLock;
         end
         else
         begin
           if  flgFineSpeedLock then
           begin
                    edScanRate.Enabled:=false;
                   UpDownSpeed.Enabled:=false;
                  EdScanRateBW.Enabled:=false;
                 UpDownSpeedBW.Enabled:=false;
           end
           else
           begin
               edScanRate.Enabled:=true;
              UpDownSpeed.Enabled:=true;
             EdScanRateBW.Enabled:=not flgSpeedLock;
             UpDownSpeedBW.Enabled:=not flgSpeedLock;
           end;
         end;
       end;

end;   //St

procedure TScanWnd.FastScanning;
var i,error:integer;
begin
   ClearTabImages;
   DisableTopPanel(true);
 if flgNew_XYBegin then      // 11/02/13
    begin
       NanoEdu.ScanMoveToX0Y0Method(ScanParams.Xbegin,ScanParams.Ybegin);
       error:=NanoEdu.Method.Launch;
        if error<>0 then
        begin
          RestoreStartSFM;
          exit
        end;
     while assigned(ProgressMoveTo) do
           begin sleep(10); application.processmessages; end; //23/11/12
     end;
 //nanoeduII
  error:=0;
   //
  Application.ProcessMessages;
  DisableTopPanel(false);
  self.enabled:=True;
  StartBtn.Enabled:=false;  SaveExpBtn.Visible:=False;     RStartBtn.Enabled:=false;
  StopBtn.Enabled:=true;
  flgFirstPass:=true;
 // if (HardWareOpt.XYTune='Fine') and flgFineSpeedLock then
         begin
            edScanRate.Enabled:=false;   edScanRateBW.Enabled:=false;
            UpDownSpeed.Enabled:=false;  UpDownSpeedBW.Enabled:=false;
         end;
  SetLength(ScanError,Scanparams.ScanPoints);       ///don't foget =nil???
  if flgUnit=Grand then nanoedu.ScanMotorTurnOn;
  flgProgressError:=false;

  Application.ProcessMessages;
  PageCtrlScan.ActivePage:=TabSheetScanArea;
  with PageCtrlScan do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
   ActivePage.HighLighted:=True;
  end;
   RStartBtn.Visible:=true;
  with ScanParamsWnd do
      begin
          edScanNmb.Text:='0';
          edDZ.Text:= floattostrf(ScanNormData.ScaleZ0*Z_d_nm,fffixed,5,0);
      end;
   ScanParams.ScanLineTime:=round(strtofloat(Frametime.Caption)*1000); //ms
    NanoEdu.FastTopoMethod;
    Application.ProcessMessages;
    if NanoEdu.Method.Launch<>0 then
     begin FreeAndNil(NanoEdu.Method); RestoreStartSFM; exit end;

//    StartBtn.Enabled := True;
    DisableTopPanel(false);
 //   TabSheetCurLine.Tabvisible:=false;
  (* if  HardWareOpt.XYTune='Rough' then
         begin
              edScanRate.Enabled:=true;
             UpDownSpeed.Enabled:=true;
            EdScanRateBW.Enabled:=not flgSpeedLock;
           UpDownSpeedBW.Enabled:=not flgSpeedLock;
         end;
         *)
   //
 (*
   SpdBtnFB.down:=true;
   SpdBtnFB.Visible:=true;
  *)
end;   //fastscanning

procedure TScanWnd.Lithography;
var i,error:integer;
begin
   ClearTabImages;
   DisableTopPanel(True);
   //NanoEdu.Method:=TScanMoveToX0Y0.Create(ScanParams.Xbegin,ScanParams.Ybegin);
   if flgNew_XYBegin then      // 11/02/13
    begin
      NanoEdu.ScanMoveToX0Y0Method(ScanParams.Xbegin,ScanParams.Ybegin);
      error:=NanoEdu.Method.Launch;
      if error<>0 then begin  RestoreStartSFM; exit end;
      while assigned(ProgressMoveTo) do application.processmessages;
    end;
   // FreeAndNil(NanoEdu.Method);

   DisableTopPanel(false);
   self.enabled:=True;
   StartBtn.Enabled:=False;
   edStepXYM.Enabled:=false;
   BitBtnProject.Enabled:=false;
   BitBtnLoadIm.Enabled:=false;
   BitBtnActLitho.Enabled:=false;
   ScrollBarLitho.Enabled:=false;

   SaveExpBtn.Enabled:=False;  SaveExpBtn.Visible:=False;
//   ToolBarScanwnd.Font.Color:=clRed;
  // StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_75' (* '&STOP' *) );
 //  StartBtn.Glyph.Assign(BitMapStop);
   flgFirstPass:=true;
   PageCtlLeft.ActivePage:=TabSheetTopoL;
   with PageCtlLeft do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
   flgProgressError:=false;
(*
  NanoEdu.ScanCalibrateMethod;
  error:=NanoEdu.Method.Launch;
  while assigned(Progress) do application.processmessages;
  FreeAndNil(NanoEdu.Method);
  if flgProgressError then
   begin
   RestoreStartSFM;
   exit
  end;

   Application.ProcessMessages;
  *)
   with ScanParamsWnd do
      begin
          edScanNmb.Text:='0';
          edDZ.Text:= floattostrf( ScanNormData.ScaleZ0*Z_d_nm,fffixed,5,0);
      end;
   //NanoEdu.Method:=TLithoSFM.Create;
   UpDownACT_position:=1;
   LithoParams.Amplifier:=1;   { TODO : 171008 }
   LithoAmplifierPow:=0;
   ScanParams.ScanLineTime:=round(strtofloat(Frametime.Caption)*1000/ScanParams.ScanLines); //ms
   Nanoedu.LithoSFMMethod;
   if NanoEdu.Method.Launch<>0 then
   begin   FreeAndNil(NanoEdu.Method); RestoreStartSFM; exit end;
   StartBtn.Enabled := True;
 //  UpDownACT_position:=1;
   if Scanparams.Scanmethod=Litho then
   begin
    UpAct.Visible:=true;
    DownAct.Visible:=true;     // 28.02.12
   end; 
//   UpDownAct.visible:=true;
end;   //St
procedure TScanWnd.Profiling;
begin
   ProfilerWND:=TProfiler.Create(Application);
end;
procedure TScanWnd.Spectroscopy;
begin
      ToolBarScanwnd.Font.Color:=clBlack;
   //   StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_71' (* '&RUN' *) );
  //    StartBtn.Glyph.Assign(BitMapStart);
      StartBtn.Enabled:=False;
  if  ArPntSpector.Count=0 then
      begin
       siLangLinked1.MessageDLG(scan9(* 'Input points for Spectroscopy!!' *) , mtWarning,[mbOK],0);
       RestoreStartSFM;
       exit;
      end;

          SpectrParams.NSpectrPoints:=ArPntSpector.Count;


      case STMflg of
  False:begin
             SpectrParams.NCurves:=1;
             case FlgUnit of
pipette:
            begin
(*              if SpectrParams.flgIZ
                              then
                               begin
                                   SpectrWnd:=TSpectroscopy.Create(Application);
                               end
                               else
                               begin
                                   SpectrWndV:=TSpectroscopyV.Create(Application);
                               end;
                               *)

              SpectrWnd:=TSpectroscopy.Create(Application);
            end;
 terra:     SpectrWndTerra:=TSpectroscopyTerra.Create(Application);
 else       SpectrWnd:=TSpectroscopy.Create(Application);
               end;
        end;
  True:begin
         if SpectrParams.flgIZ then
                                begin
                                  SpectrParams.NCurves:=1; //2
                                 case  flgUnit of
                                 terra:  SpectrWndTerra:=TSpectroscopyTerra.Create(Application);
                                 else SpectrWnd:=TSpectroscopy.Create(Application);
                                         end;
                                 end
                               else
                               begin
                                  SpectrParams.NCurves:=1; //2
                                  SpectrWndV:=TSpectroscopyV.Create(Application);
                               end;
        end;
           end;
end;


procedure TScanWnd.ScanningMulti(sender:Tobject);
(************************* 060503 *************************************
Необходимо изменить скрипт сканирования.
datain - ранее предполагалось, что приращения >0, знак определяется
знаком prim_step_zx,y и направлением движение по осям x,y и он не меняется

************************************************************************)
var
 MAX_COUNT,PT,i,j,s,error:integer;
           Z0,st:apitype;
begin
 DisableTopPanel(true);
 if not flgRestart then ClearTabImages
                  else
                   begin
                    with ImageSideL do
                     begin
                       Canvas.Brush.Color:=clWhite;
                       Canvas.FillRect(Rect(0,0,Width,Height));
                    end;
                    FlgRestart:=false;
                   end;
   NanoEdu.ScanMoveToX0Y0Method(ScanParams.Xbegin,ScanParams.Ybegin);//Method:=TScanMoveToX0Y0.Create;
   error:=NanoEdu.Method.Launch;
   FreeAndNil(NanoEdu.Method);
  if error<>0 then
  begin
   RestoreStartSFM;
   exit
  end;
  Application.ProcessMessages;

  SaveExpBtn.Enabled:=False;
  SaveExpBtn.Visible:=False;
//  DisableTopPanel(true);
  FlgFirstPass:=true;
  SetScanNormData(ScanNormData);
  SetScanNormData(ScanNormData_2_Pass);
   { TODO : 240306 }
  Z0:=API.Z;
  if  Z0>0 then Z0:=0 else   Z0:=-(Z0+1);
  ScanParams.DataInprev:=0;//Z0;
  ScanParams.DataInNext:=0;
  SetLength(ScanError,Scanparams.ScanPoints+1);
//  SetLength(ScanErrorY,Scanparams.ScanPoints);
   DisableTopPanel(false);
 NanoEdu.ScanCalibrateMethod;
  error:=NanoEdu.Method.Launch;
  while assigned(Progress) do application.processmessages;
  FreeAndNil(NanoEdu.Method);
  if flgProgressError then
   begin
   RestoreStartSFM;
   exit
  end;
  FlgFirstPass:=false;
  Application.ProcessMessages;
                case ScanParams.flgFilter of
                             0: ;
                             1:  Convolution(ScanError,ScanParams.ScanPoints,3);
                             2:  Convolution(ScanError,ScanParams.ScanPoints,5);
                                    end;
//                                     Convolution(ScanError,ScanParams.ScanPoints,5);
 (* PrepareScanError(ScanError);
   NanoEdu.ScanCalibrateMethod;///Method:=TScanCalibrate.Create;
  error:=NanoEdu.Method.Launch;
  FreeAndNil(NanoEdu.Method);
 if error<>0 then  begin  RestoreStartSFM; exit end;
  { TODO : 240306 }
    Z0:=API.Z;
  if  Z0>0 then Z0:=0 else   Z0:=-(Z0+1);
  ScanParams.DataInprev:=0;//Z0;
  ScanParams.DataInNext:=0;
  Application.ProcessMessages;
  PageCtrlScan.ActivePage:=TabSheetCurLine;
  with PageCtrlScan do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
   ActivePage.HighLighted:=True;
  end;
   StartBtn.Font.Color:=clRed;
   StartBtn.Caption:=siLangLinked1.GetTextOrDefault('IDS_75' (* '&STOP'  );
   StartBtn.Glyph.Assign(BitMapStop);
   BitBtnRStart.Visible:=true;
  with ScanParamsWnd do
      begin
          edScanNmb.Text:='0';
          edDZ.Text:= floattostrf(ScanNormData.ScaleZ0*Z_d_nm,fffixed,5,0);
      end;
///////////////////***********************************///////////////////
  *)
    Z0:=API.Z;
    if  Z0>0 then Z0:=0 else   Z0:=-(Z0+1);
    ScanParams.DataInprev:=0;//Z0;
    ScanParams.DataInNext:=0;
    NanoEdu.Method:=TMultiTopography.Create;
    if NanoEdu.Method.Launch<>0 then
     begin FreeAndNil(NanoEdu.Method); RestoreStartSFM; exit end;
    Application.ProcessMessages;
//    StartBtn.Enabled := True;
//    DisableTopPanel(false);
//
    if  (ScanParams.ScanMethod=OneLineScan) then
       begin
           edScanRate.Enabled:=false;
          UpDownSpeed.Enabled:=false;
         EdScanRateBW.Enabled:=false;
        UpDownSpeedBW.Enabled:=false;
       end
       else
       begin
         if  HardWareOpt.XYTune='Rough' then
         begin
              edScanRate.Enabled:=true;
             UpDownSpeed.Enabled:=true;
            EdScanRateBW.Enabled:=not flgSpeedLock;
           UpDownSpeedBW.Enabled:=not flgSpeedLock;
         end
         else
         begin
           if  flgFineSpeedLock then
           begin
                    edScanRate.Enabled:=false;
                   UpDownSpeed.Enabled:=false;
                  EdScanRateBW.Enabled:=false;
                 UpDownSpeedBW.Enabled:=false;
           end
           else
           begin
               edScanRate.Enabled:=true;
              UpDownSpeed.Enabled:=true;
             EdScanRateBW.Enabled:=not flgSpeedLock;
             UpDownSpeedBW.Enabled:=not flgSpeedLock;
           end;
         end;
       end;
       //
end;   //MultiScan
/////////////////////***************************

(*procedure ScanParamsUpdate(var AMessage : TMessage); message WM_ScanParamsUpdate;     // Message to be sent back from thread when its done
begin
   if ApprochOpt<>nil then ApprochOpt.ScanCorrSheetInit;
   ScannerCorrectLast(FileName:string);
end;
*)

procedure TScanWND.ThreadDone(var AMessage: TMessage); // keep track of when and which thread is done executing
var flgold:boolean;
     hr:Hresult;
    Sender:TObject;
    i:integer;
    controllererror:integer;
    ww:TForm;
    label 100;
procedure CommentPrepare;
var j:integer;
begin
    with ScanData.FileHeadRcd do
       begin
        HMaterial:=strcomment[0];
          for j := 0 to 7 do  Comments[j]:=strcomment[j+1];
      (*  Comm1:=strcomment[1];
        Comm2:=strcomment[2];
        Comm3:=strcomment[3];
        Comm4:=strcomment[4];
        Comm5:=strcomment[5];  *)
       end;
end;
procedure CopyTopViewToScanArea(distcv:Tbitmap);
var xs,ys,ws,hs,xd,yd,wd,hd:integer;
    rsource,rdist:Trect;
begin
          case ScanParams.ScanPath of
     Multi,
      OneX: begin
              xs:=0;
              ys:= ImgRBitMapTemp.Height-round(ImgRBitMapTemp.Height*ScanParams.CurrentScanCount/Scanparams.ScanLines);
              ws:= ImgRBitMapTemp.Width;
              hs:= round(ImgRBitMapTemp.Height*ScanParams.CurrentScanCount/Scanparams.ScanLines);
              xd:=R.Left;
              yd:=R.Bottom-round((R.Bottom-R.top)*ScanParams.CurrentScanCount/Scanparams.ScanLines);
              wd:=R.Right-R.left;
              hd:=round((R.Bottom-R.top)*ScanParams.CurrentScanCount/Scanparams.ScanLines);
              SetStretchBltMode(distcv.canvas.Handle, COLORONCOLOR);
              StretchBlt(distcv.canvas.Handle,xd, yd,wd,hd,
              ImgRBitMapTemp.Canvas.handle, xs,ys,ws,hs,SRCCOPY);
            end;
      MultiY,
      OneY: begin
              xs:=0;
              ys:=0;
              ws:=round(ImgRBitMapTemp.width*ScanParams.CurrentScanCount/Scanparams.ScanLines);;
              hs:=ImgRBitMapTemp.Height;
              xd:=R.Left;
              yd:=R.top;
              wd:=round((R.right-R.left)*ScanParams.CurrentScanCount/Scanparams.ScanLines);
              hd:=(R.Bottom-R.top);
              SetStretchBltMode(distcv.canvas.Handle, COLORONCOLOR);
              StretchBlt(distcv.canvas.Handle,xd, yd,wd,hd,
              ImgRBitMapTemp.Canvas.handle, xs,ys,ws,hs,SRCCOPY);
            end;

            end;
end;

begin
   RStartBtn.visible:=true;//false;
  if  (mDrawing=AMessage.WParam) or (mFastDrawing=AMessage.WParam) then
  begin
    controllererror:=AMessage.LParam;
    if assigned(ScDrawLithoThread) then
     begin
      ScDrawLithoThreadActive := false;
      ScDrawLithoThread:=nil;
     if  FlgScanError or FlgReStart then
      begin
        dec(CountStart);      dec(CountClose);
      end
      else
      begin
        CopyTopViewToScanArea(ImageScanArea.Picture.BitMap);
        CopyTopViewToScanArea(ScanAreaBitMapTemp);
        ScanData.HeaderPrepare;
        ScanData.PrepareSaveData;
        DlgComnt:=TDlgComnt.Create(Application);
        DlgComnt.ShowModal;
        CommentPrepare;
       if ScanData.SaveExperiment<>0 then begin FlgScanError:=true; goto 100  end;
        SaveExpBtn.Enabled:=True;   SaveExpBtn.Visible:=True;
 //       SaveExpBtn.Font.Color:=clGreen;
        flgBlickSave:=True;
        Caption:=CaptionBase+Captionadd+CaptionRenishaw;
        Main.CreateMDIChild(Sender,WorkNameFile,FlgViewDef,true,FlgRenishawCorrection);
      end;
    end; //litho
    if assigned(ScDrawThread) then
     begin
        ScDrawThread:=nil;
        ScDrawThreadActive := false;
        ScanNormData.PrevLine:=nil;
        ScanError:=nil;
        ScanNormData_2_Pass.PrevLine:=nil;
       if  FlgScanError  or FlgReStart then
        begin
         dec(CountStart);      dec(CountClose);
        end
        else
        begin
         if  (ScanParams.ScanMethod<>OneLineScan) then
         begin
          CopyTopViewToScanArea(ImageScanArea.Picture.BitMap);
          CopyTopViewToScanArea(ScanAreaBitMapTemp);
         end;
         ScanData.HeaderPrepare;
         if ScanParams.flgTopoLevelDel then ScanData.PrepareSaveData;
         DlgComnt:=TDlgComnt.Create(Application);
         DlgComnt.ShowModal;
         CommentPrepare;
        if ScanData.SaveExperiment<>0 then begin FlgScanError:=true; goto 100  end;
         SaveExpBtn.Enabled:=True;
         SaveExpBtn.Visible:=True;
         flgBlickSave:=True;
         Caption:=CaptionBase+Captionadd+CaptionRenishaw;
//         if not flgStopTimer then   //
          Main.CreateMDIChild(Sender,WorkNameFile,FlgViewDef,true,FlgRenishawCorrection);
         flgScanDone:=True;
        end;
     end;//drawthread
    if assigned(ScFastDrawThread) then
     begin
      ScFastDrawThreadActive := false;
      ScFastDrawThread:=nil;
      if  FlgScanError     then
       begin  dec(CountStart);  dec(CountClose); end
       else
       begin
        CopyTopViewToScanArea(ImageScanArea.Picture.BitMap);
        CopyTopViewToScanArea(ScanAreaBitMapTemp);
        ScanData.HeaderPrepare;
//        ScanData.PrepareSaveData;
        DlgComnt:=TDlgComnt.Create(Application);
        DlgComnt.ShowModal;
        CommentPrepare;
        if ScanData.SaveExperiment<>0 then begin FlgScanError:=true; goto 100  end;
        SaveExpBtn.Enabled:=True;    SaveExpBtn.Visible:=True;
        flgBlickSave:=True;
        Caption:=CaptionBase+Captionadd+CaptionRenishaw;
      // if not flgStopTimer then    ???????
       Main.CreateMDIChild(Sender,WorkNameFile,FlgViewDef,true,FlgRenishawCorrection);
        flgScanDone:=True;
      end;
     end;//fastdraw
100:    Caption:=CaptionBase+Captionadd+CaptionRenishaw;
      // disableTopPanel(true);
       while assigned(nanoedu.method) do application.ProcessMessages;  { TODO : 051207 }    //wait for  end scanning
       if flgUnit=Grand then nanoedu.ScanMotorTurnOn;
        flgold:=flgMoveToBeginbyRS;
       if errScan > 1 then
        begin
           flgMoveToBeginbyRS:=false;  //don't follow drift renishaw
           ScanParams.XPrevious:=ScanParams.XBegin;
           ScanParams.YPrevious:=ScanParams.YBegin;
         case errScan of
    XRightOver:
    begin
     ShowMessage(siLangLinked1.GetTextOrDefault('IDS_20' (* 'Scanning  is Finished. Right limit scan area is reached ' *) ));
    end;
    XLeftOver:
    begin
     ShowMessage(siLangLinked1.GetTextOrDefault('IDS_23' (* 'Scanning  is Finished. Left limit scan area is reached ' *) ));
    end;
    YTopOver:
    begin
     ShowMessage(siLangLinked1.GetTextOrDefault('IDS_25' (* 'Scanning  is Finished. Top limit scan area is reached ' *) ));
    end;
    YBottomOver:
    begin
     ShowMessage(siLangLinked1.GetTextOrDefault('IDS_26' (* 'Scanning  is Finished. Bottom limit scan area is reached ' *) ));
    end;
              end;//errScan
 end;
     if  (flgControlerTurnON and flgStopPressed) or (controllererror=lError)then
     begin
       if (controllererror=lError) then  siLangLinked1.MessageDLG(errorscan, mtwarning,[mbOK],0);
       NanoEdu.ScanMoveToX0Y0Method(ScanParams.Xbegin,ScanParams.Ybegin);
       NanoEdu.Method.Launch;
       while assigned(ProgressMoveTo) do
       begin
        application.processmessages;
       end;
     end;
        flgNew_XYBegin:=False;
        flgMoveToBeginbyRS:=flgold;
        if flgUnit=Grand then nanoedu.ScanMotorTurnOff;
        DisableTopPanel(false);
   //    RestoreStartSFM;
      PageCtrlScan.ActivePage:=TabSheetScanArea;
       with PageCtrlScan do
       begin
          for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
          ActivePage.HighLighted:=True;
       end;
          ImageScanArea.Canvas.Pen.Color:=clgreen;
          ImageScanArea.Canvas.Pen.Mode:=pmcopy;
          ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                           Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
          ImageScanArea.Canvas.Polyline([Point(R.Left,R.Top),Point(R.Left,R.Top),
                           Point(R.Left,R.Top),Point(R.Left,R.Top)]);


      WaitforJavaNotActive;
      // RestoreStartSFM;       // Было в этом месте - я перенесла вниз, и перестал работать Рестарт
                                // т.к. в RestoreStartSFM уст-ся флаг   FlgStopScan

   if  assigned(WorkView) and (not FlgScanError) then
     if  WorkView.visible  then
     begin
        sleep(1000);
        for I := ArScanFrm.count - 1  downto 0 do
        begin
          TForm(ArScanFrm.items[i]).close;
          Application.processmessages;
         end;
        WorkView.Redraw;
        application.processmessages;
        WorkView.ActivateIcon(WorkNameFile);
        if assigned(DirView) then  DirView.DeActivate;
      end;
        // add 07/09/16
    if  assigned(DirView) and (not FlgScanError) then
     if DirView.visible  then
     begin
        sleep(1000);
        DirView.Redraw;
        application.processmessages;
       if (OpenDirectory=workdirectory) then
       begin DirView.ActivateIcon(WorkNameFile);
        if assigned(WorkView) then  WorkView.DeActivate;
       end;
      end;
  // 07/09/16
//????
         if assigned(ApplyBitBtn) then ApplyBitBtn.Font.color:=clBlack;
          flgBlickApply:=False;
          Application.processmessages;
          FlgScanError:=False;
        if FlgRestart then
        begin
           while assigned(nanoedu.method) do sleep(100);    //add sleep 170616
           flgNew_XYBegin:=true;   //11/02/13
           FlgStopScan:= true;     // 05/04/13
           StartBtnClick(self); StartBtn.down:=true;
        end
        else
        begin
//          flgStopTimer:=false;
//         if assigned(Timer) then Timer.Enabled:=TRUE;
          RestoreStartSFM;
        end;
    //    RestoreStartSFM;
 end;
 //draw
   if mScanning=AMessage.WParam then
    begin
      if flgRenishawUnit then
      begin
        NanoEdu.Method.PreviousPointCnt();
        errScan:= NanoEdu.Method.GetLastError;
      end;
     if  flgControlerTurnON   then
      begin
        NanoEdu.Method.FreeBuffers;
      end;
      if Assigned(scWorkThread) then FreeAndNil(scWorkThread);
      if (Scanparams.ScanMethod=FastScan) or (Scanparams.ScanMethod=FastScanPhase)then
       begin NanoEdu.Method.TurnOnFB; SpdBtnFb.down:=true;   SpdBtnFB.Visible:=false end;
      if (Scanparams.ScanMethod=LithoCurrent)then   NanoEdu.Bias:=0;
      if flgUnit=Grand then nanoedu.ScanMotorTurnOff;
      if assigned(frContrast) then frContrast.close;
      FreeAndNil(NanoEdu.Method);
    end;
end;

procedure TScanWND.MultiThreadDone(var AMessage: TMessage); // keep track of when and which thread is done executing
var Sender:TObject;
    i:integer;
procedure CommentPrepare;
var j:integer;
begin
    with ScanData.FileHeadRcd do
       begin
        HMaterial:=strcomment[0];
           for j := 1 to 7 do  Comments[j]:=strcomment[j];
       end;
end;
begin
 if  (mDrawing=AMessage.WParam)  then
  begin
     if assigned(ScDrawThread) then
     begin
        ScDrawThread:=nil;
        ScDrawThreadActive := false;
       if not flgFirstpass then
                            begin
                              Scanparams.dataInPrev:=Scanparams.dataInCur;
                              Scanparams.dataInCur:=Scanparams.dataInNext;
                            end;
       if  FlgStopMulti then
       begin
         RStartBtn.visible:=true;
         ScanNormData.PrevLine:=nil;
         ScanNormData_2_Pass.PrevLine:=nil;
         ScanError:=nil;
         if  FlgScanError  or FlgReStart then
         begin
          FlgScanError:=False;
          dec(CountStart);
         end
         else
         begin
          ScanData.HeaderPrepare;
          ScanData.PrepareSaveData;
          DlgComnt:=TDlgComnt.Create(Application);
          DlgComnt.ShowModal;
          CommentPrepare;
          ScanData.FileHeadRcd.SecondPass:=false;
          ScanData.SaveExperiment;
          Main.CreateMDIChild(Sender,ScanData.WorkFileName,FlgViewDef,true,
                                                       FlgRenishawCorrection);
          ScanDataSecondPass.HeaderPrepare;
          ScanDataSecondPass.PrepareSaveData;
          DlgComnt:=TDlgComnt.Create(Application);
          DlgComnt.ShowModal;
          CommentPrepare;
          ScanDataSecondPass.FileHeadRcd.SecondPass:=true;
          ScanDataSecondPass.SaveExperiment;
          Main.CreateMDIChild(Sender,ScanDataSecondPass.WorkFileName,FlgViewDef,true,
                                                         FlgRenishawCorrection);
          SaveExpBtn.Enabled:=True; SaveExpBtn.Visible:=True;
          flgBlickSave:=True;
         end;
           flgScanDone:=True;
           flgStopTimer:=false;
           Timer.Enabled:=TRUE;
     end // stop
    else
    begin
      if NanoEdu.Method.Launch<>0 then
      begin FreeAndNil(NanoEdu.Method); RestoreStartSFM; exit end;
      exit;// Multi
    end;
   end;//drawthread
       if assigned(ScanDataSecondPass) then FreeAndNil(ScanDataSecondPass);
       disableTopPanel(true);
       while assigned(nanoedu.method) do application.ProcessMessages;
       Nanoedu.TurnONFBMethod;
       NanoEdu.Method.Launch;
       FreeAndNil(NanoEdu.Method);
        if  flgControlerTurnON and flgStopPressed then
        begin
          NanoEdu.ScanMoveToX0Y0Method(ScanParams.Xbegin,ScanParams.Ybegin);
          NanoEdu.Method.Launch;
           while assigned(ProgressMoveTo) do application.processmessages;
        end;
       // FreeAndNil(NanoEdu.Method);
       DisableTopPanel(false);
       edScanRate.enabled:=true;
       edScanRateBW.Enabled:=false;
       upDownSpeed.Enabled:=true;
       RestoreStartSFM;
       PageCtrlScan.ActivePage:=TabSheetScanArea;
       with PageCtrlScan do
       begin
          for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
          ActivePage.HighLighted:=True;
       end;
     if  assigned(WorkView)  then
       if  WorkView.visible  then
       begin
        sleep(1000);
        for I := ArScanFrm.count - 1  downto 0 do
       begin
          TForm(ArScanFrm.items[i]).close;
          application.processmessages;
       end;
        WorkView.Redraw;
        application.processmessages;
        WorkView.ActivateIcon(WorkNameFile);
        if assigned(DirView) then  DirView.DeActivate;
      end;
          Application.processmessages;

       if FlgRestart then
                  begin
                   flgNew_XYBegin:=true; 
                   StartBtnClick(self);
                  end;
 end; //draw
    if mScanning=AMessage.WParam then
    begin
      if flgRenishawUnit then
      begin
        NanoEdu.Method.PreviousPointCnt();
        errScan:= NanoEdu.Method.GetLasterror;
      end;
      NanoEdu.Method.ScanWorkDone;
      NanoEdu.Method.FreeBuffers;
      if Assigned(scWorkThread) then FreeAndNil(scWorkThread);
      if assigned(frContrast) then frContrast.close;
      if  FlgStopMulti then  FreeAndNiL(NanoEdu.Method);
    end;
    ApplyBitBtn.Font.color:=clBlack;
    flgBlickApply:=False;
end;
procedure TScanWND.ScanErrorMessage(var AMessage : TMessage);
begin
   FlgStopScan:=true;
   startbtn.Enabled:=false;
   RestoreStartSFM;
end;
procedure TScanWnd.ButtonSaveFileClick(Sender: TObject);
var
  i:integer;
  ActiveW:TfrmGL;
  NewFile,OldFile:string;
  curdir,dir:string;
  s:string;
begin
   siSaveDialog:=TsiSaveDialog.Create(self);
   siSaveDialog.siLang:=siLangLinked1;
   siSaveDialog.InitialDir:=WorkDirectory;//080410
   siSaveDialog.Options:=[ofOverWritePrompt,ofShowHelp,ofEnableSizing];
   siSaveDialog.siLang.ActiveLanguage:=lang;
   siSaveDialog.Filter:=' spm file *.spm|*.spm';
   siSaveDialog.FilterIndex:=1;
   siSaveDialog.DefaultExt:='spm';
   siSaveDialog.FileName:='';
   { DONE -om : fill header before saving file }
  if siSaveDialog.execute then begin
        flgBlickSave:=False;
 //       SaveExpBtn.Font.Color:=clBlack;
        SaveExpBtn.Enabled:=False;   SaveExpBtn.Visible:=False;
        OldFile:={WorkDirectory+'\'+ExtractFileName(} WorkNameFile;
        NewFile:=siSaveDialog.FileName;
       // if FileExists(NewFile) and (newFile<>OldFile) then DeleteFile(NewFile);
     //   ChDir(CurDir);
        dir:=ExtractFileDir(NewFile);
        if not DirectoryExists(dir)then CreateDir(dir);
    //     ChDir(CurDir);
         try
          FileCopyStream(OldFile,NewFile);
        except
        on IO: EInOutError do
         begin
          Case IO.errorcode of
           2: s:=siLangLinked1.GetTextOrDefault('IDS_90' (* 'file ''' *) )+Oldfile+siLangLinked1.GetTextOrDefault('IDS_91' (* 'not find' *) );
           3: s:=siLangLinked1.GetTextOrDefault('IDS_92' (* 'error file name ''' *) )+newfile+'''';
           4: s:=siLangLinked1.GetTextOrDefault('IDS_90' (* 'file ''' *) )+newfile+siLangLinked1.GetTextOrDefault('IDS_94' (* ' accept denied ' *) );
         101: s:=siLangLinked1.GetTextOrDefault('IDS_95' (* 'disk is full' *) );
         106: s:=siLangLinked1.GetTextOrDefault('IDS_96' (* 'input error ' *) )+newfile+'''';
                    end;
            siLangLinked1.messageDlg(s+scan10 (* ' try again!' *) ,mtwarning,[mbOk],0);
            flgBlickSave:=True;
 //           SaveExpBtn.Font.Color:=clGreen;
            SaveExpBtn.Enabled:=true;   SaveExpBtn.Visible:=True;
            exit;
         end;
        end;  //try
//        DeleteFile(OLdFile);
    (*  if  ArFrmGL.Count>0 then
       begin
        ActiveW:=ArFrmGL.Items[ArFrmGL.Count-1];
       if ActiveW.Caption=ExtractFileName(WorkNameFile) then
        begin
          ActiveW.Close;
          Main.CreateMDIChild(Sender,NewFile,FlgViewDef);
         for i:=0 to MDICHildCount-1 do
           begin
            if MDIChildren[i].Caption=DirViewCaption
              then
                begin
                   DirView.ReDraw;
                   exit;
                end;
            end;
          end;
        end;
      *)
       if  ArFrmGL.Count>0 then
       begin
          for  i:=(ArFrmGL.Count-1)  downto 0  do
          begin
           ActiveW:=ArFrmGL.Items[i];
           if pos(ExtractFileName(WorkNameFile),ActiveW.Caption)<>0 then
           begin
             ActiveW.Close;
           end;
          end;

           Main.CreateMDIChild(Sender,NewFile,FlgViewDef,false,ActiveW.flgRenishawCorrected);
      end;
     if assigned(DirView) and (Opendirectory=ExtractFileDir(siSaveDialog.FileName)) then begin {setcurrentdir(opendir);} DirView.ReDraw ; end;
     if assigned(WorkView)and (Workdirectory=ExtractFileDir(siSaveDialog.FileName)) then begin {setcurrentdir(workdirectory);} WorkView.ReDraw ; end;
   end;
     FreeAndNil(siSaveDialog);
     ActiveW:=nil;
 end;

procedure TScanWnd.ExitBtnClick(Sender: TObject);
begin
  Close;
end;

 (*
procedure TScanWnd.BtnCloseRClick(Sender: TObject);
begin
      if flgreg=2 then flgreg:=5 else  flgreg:=4;
        RebuildWindowRgn;
        flgRightView:=False;
         BtnOpenR.Visible:=not  BtnOpenR.Visible;
        BtnCloseR.Visible:=not  BtnCloseR.Visible;
end;

procedure TScanWnd.BtnOpenRClick(Sender: TObject);
begin
    if FlgLeftView then   flgreg:=3 else
      begin
        flgreg:=3;
        flgLeftView:=true;
        BtnCloseL.Visible:=not  BtnCloseL.Visible;
         BtnOpenL.Visible:=not  BtnOpenL.Visible;
      end;
      RebuildWindowRgn;
      flgRightView:=true;
      BtnCloseR.Visible:=not  BtnCloseR.Visible;
       BtnOpenR.Visible:=not  BtnOpenR.Visible;
end;

procedure TScanWnd.BtnCloseLClick(Sender: TObject);
begin
    if flgreg=4 then flgreg:=5 else  flgreg:=2;
       RebuildWindowRgn;
      flgLeftView:=False;
      BtnCloseL.Visible:=not  BtnCloseL.Visible;
       BtnOpenL.Visible:=not  BtnOpenL.Visible;
end;

procedure TScanWnd.BtnOpenLClick(Sender: TObject);
begin
    if FlgRightView then   flgreg:=1 else
    begin
      flgreg:=1 ;
         flgRightView:=True;
         BtnCloseR.Visible:=not  BtnCloseR.Visible;
          BtnOpenR.Visible:=not  BtnOpenR.Visible;
    end;
      RebuildWindowRgn;
      flgleftView:=True;
      BtnOpenL.Visible:= not  BtnOpenL.Visible;
      BtnCloseL.Visible:=not BtnCloseL.Visible;//   ScannerCorrect.flgHideLine:=True;
end;
*)
procedure TScanWnd.PageCtlRightChange(Sender: TObject);
var    flgchk:boolean;
  valDiscr:apitype;
    HlpCntext:integer;
          i,k:integer;
           wh:integer;
       prevScanMethod:byte;
         t:single;
begin
   BitMapTemp.Assign(ImgRChart.BackImage.Bitmap);   //   20/06/06 Ola
   BitMapLTemp.Assign(ImgLChart.BackImage.Bitmap);
   if FlgCurrentUserLevel=Demo  then
    begin
     if DemoDataInfoArray[PageCtlRight.ActivePageIndex].Nx<>0 then SetXYMaxDemo(PageCtlRight.ActivePageIndex);
     ScanAreaUpdate;
     ApplyBtnClick(self);
    end;
     RestoreStartSFM;   { TODO : 090906 }
     CheckBoxStep.Enabled:=True;
     CheckBoxStep.Enabled:=(not ReniShawparams.flgSteponNets) and (not FlgReniShawUnit);
      if  OldFlgFixStep <> scanparams.flgStepxy then
       begin
          CheckBoxStep.checked:=false;
          CheckBoxStepClick(sender);
       //   OldFlgFixStep:=false;//True;
       end;
//       else edStepXY.enabled:=True;
         if FlgReniShawUnit then
         begin
          EdStepXY.Enabled:=(not ReniShawparams.flgSteponNets);
         end;
         PanelParam.Hint:='';
         BitBtnRect.Visible:=ScanParams.flgSQ;//  true;
         BitBtnSq.Visible:=not ScanParams.flgSQ;//true;
         BitBtnMgIn.Visible:=false;//not (HardWareOpt.XYtune='Fine');//and not FlgReniShawUnit;//True;
         BitBtnMgOut.Visible:=false;//(HardWareOpt.XYtune='Fine');//and not FlgReniShawUnit;//True;
         BtnZoom.Visible:=true;
         BtnClear.visible:=true;
         BitBtnX0Y0.visible:=true;
              ScanParamsWnd.Enabled:=True;
              PageCtlLeft.Visible:=true;
              LabelLineNum.visible:=true;
              LabelHeight.Visible:=true;
              EdDz.Visible:=true;
              BitBtnClChart.visible:=false;
   //           BitBtnSpectrHelp.visible:=false;
              panelScanf.Visible:=true;
              SpeedBtnDelTop.visible:=true;
              SpeedBtnSDelTop.visible:=true;
              PanelChart.left:=1;
              PanelChart.top:=28;
              PanelChart.width:=PanelRight.ClientWidth-3;
              PanelChart.height:=PanelRight.ClientHeight-28;
              TabSheetTopoL.Caption:=siLangLinked1.GetTextOrDefault('IDS_100' (* 'Topography/ Top View' *) );
           if not CheckBoxStep.Checked then
             with Scanparams do
                case ScanPath of
          OneX: begin
                 edNX.enabled:=true;
                 UpDownNX.enabled:=true;
                end;
           OneY:begin
                  edNY.enabled:=true;
                  UpDownNY.enabled:=true;
                 end;
          Multi:begin        //X+X+
                 edNX.enabled:=true;
                 UpDownNX.enabled:=true;
                 if ScanParams.ScanMethod<>Topography then TabSheetTopoError.TabVisible:=True;
                end;
         MultiY:begin        //X+X+
                 edNY.enabled:=true;
                 UpDownNY.enabled:=true;
                 if ScanParams.ScanMethod<>Topography then TabSheetTopoError.TabVisible:=True;
                end;
                               end;
    ///**************************?????????????
              with Scanparams do
              begin
                case ScanPath of
          OneX: begin
                   t:=ceil(X*Ny/ScanRate+X*Ny/ScanRateBW);
                 end;
           OneY:begin
                  t:=ceil(Y*Nx/ScanRate+Y*Nx/ScanRateBW);
                end;
                                end;
           if FlgUnit=terra then  t:=t+0.001*(2*0.001*ScanParams.TimMeasurePoint+ScanParams.TerraTDelay)*NX*NY;
              end;

        if (t<10)  then FrameTime.Caption:=FloatToStrF(t,ffFixed,7,1)
        else FrameTime.Caption:=FloatToStrF(t,ffFixed,7,0);
          edScanRate.enabled:=true;
          edScanRateBW.Enabled:=not flgSpeedLock;//false;
          UPDownSpeed.enabled:=true;
          UPDownSpeedBW.enabled:=not flgSpeedLock;//
          flgRecord:=false;
          flgProjection:=false;
          TabSheetCurLine.TabVisible:=True;
          TabSheetCurScan.TabVisible:=True;
          TabSheetCurLineAdd.TabVisible:=False;
//          SignalsMode.PanelBias.Visible:=False;   { TODO : 091008 }
          ComboBoxIZ.Visible:=false;
          SignalsMode.tbSFMCUR.TabVisible:=false;
          PanelSpectrF.Visible:=true;
//(*  open when multi use
       {$IFDEF FULL}
        if comboboxpath.items.Count=2 then
         begin
          comboboxpath.items.add('X+X+');
          comboboxpath.items.add('Y+Y+');
          SpdBtnRecord.Visible:=false;
          SpdBtnOneFRame.Visible:=false;
     //     SpdBtnFB.Visible:=false;
         end;

        {$ENDIF}
//*)
          SpdBtnRecord.Visible:=false;
          SpdBtnOneFrame.Visible:=false;
    //      SpdBtnFB.Visible:=false;
          ScanParams.flgSpectr:=false;
          ScanParams.flgProfile:=false;
          SpectrParams.flgIZ:=ComboBoxIZ.Visible and (ComboBoxIZ.ItemIndex=1);
          BitBtnPointClearClick(Sender);
           panelterra.visible:=false;

           { TODO : 010807 }
       (*      {$IFDEF FULL}
                 SignalsMode.tbSFM.TabVisible:=not STMflg;
             {$ENDIF}
            SignalsMode.tbSFMCUR.TabVisible:=False;
            *)
      case PageCtlRight.ActivePage.PageIndex of
    0:  begin   //topo
              SignalsMode.tbSTM.TabVisible:=STMflg;
              SignalsMode.tbSFM.TabVisible:=not STMflg;
              SignalsMode.tbSFMCUR.TabVisible:=False;
            {$IFDEF FULL}
              if not STMflg then
                begin
                 if flgUnit<>Pipette  then
                 begin
                  ApproachParams.BiasV:=0;
                  Nanoedu.Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
                 end;
                end;
              if flgUnit=Pipette  then
                begin
                    SignalsMode.tbSFM.TabVisible:=false;
                    SignalsMode.tbSFMCUR.TabVisible:=not STMflg;
                end;
            {$ENDIF}
              ScanParams.flgAquiAdd:=false;
              flgScanDone:=false;
              ScanParams.ScanMethod:=TopoGraphy;
              TabSheetSideL.TabVisible:=True;
              TabSheetTopoL.TabVisible:=False;
              TabSheetMatrix.TabVisible:=False;
              PageCtlLeft.ActivePageIndex:=0;
              SignalsMode.PanelGain.Visible:=False;
              ImgRInit;
              ClearTabImages;
              ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_58' (* 'Topography' *) );
              TabSheetCurScan.Caption:=siLangLinked1.GetTextOrDefault('IDS_44' (* 'Topo, nm' *) );
              SpeedBTnplDel.Visible:=true;
              TabSheetTopoError.Caption:=siLangLinked1.GetTextOrDefault('IDS_105' (* 'Topography/Top View II Pass' *) );
         end;
    1:  begin              //phase
             SignalsMode.tbSFM.TabVisible:=true;
             SignalsMode.tbSFMCUR.TabVisible:=False;
            {$IFDEF FULL}
              if flgUnit<>Pipette  then
              begin
                 ApproachParams.BiasV:=0;
                 Nanoedu.Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
              end;
              if flgUnit=Pipette  then
                begin
                    SignalsMode.tbSFM.TabVisible:=false;
                    SignalsMode.tbSFMCUR.TabVisible:=true;
                end;
            {$ENDIF}
              flgScanDone:=false;
              ScanParams.flgAquiAdd:=true;
              ScanParams.ScanMethod:=Phase;
              SpeedBtnDelTop.visible:=false;
              SpeedBtnSDelTop.visible:=false;
              if (ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY) then TabSheetTopoError.TaBVisible:=True;
              TabSheetTopoL.TabVisible:=True;
              TabSheetSideL.TabVisible:=True;
              TabSheetMatrix.TabVisible:=False;
              PageCtlLeft.ActivePage:=TabSheetTopoL;
           //    PageCtlLeft.ActivePageIndex:=0;
              ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_106' (* 'Phase Shift' *) );
              TabSheetCurLineAdd.TabVisible:=True;
              PageCtrlAdd.ActivePage:=TabSheetCurScan;
              TabSheetTopoError.Caption:=siLangLinked1.GetTextOrDefault('IDS_107' (* 'Phase II Pass' *) );
              TabSheetCurLineAdd.Caption:=siLangLinked1.GetTextOrDefault('IDS_108' (* 'Phase, a.u' *) );
              with SignalsMode do
               begin
                 PanelGain.Visible:=True;
                 GainFmBtn.Caption:=FloattoStrF(ApproachParams.Gain_FM/($FF-ApproachParams.Gain_FM),ffFixed,5,2);
               end;
         //     StartBtn.Enabled:=False;

         //    (NanoEdu as TSFMNanoEdu).AdjustPhaseMethod;

         //     NanoEdu.Method.Launch;
             //Adjust Zero Phase Bias
         //     FreeAndNil(NanoEdu.Method);      { TODO : 250907 }
         //     Application.ProcessMessages;
         //     StartBtn.Enabled:=True;
              ImgRInit;
              ImgLInit;
              ClearTabImages;
        end;
    2:  begin                                   //uam
            SignalsMode.tbSFM.TabVisible:=true;
            SignalsMode.tbSFMCUR.TabVisible:=False;
            {$IFDEF FULL}
               if flgUnit<>Pipette  then
               begin
                ApproachParams.BiasV:=0;//  ApproachParams.BiasV:=0;
                Nanoedu.Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
               end;
               if flgUnit=Pipette  then
                begin
                    SignalsMode.tbSFM.TabVisible:=false;
                    SignalsMode.tbSFMCUR.TabVisible:=true;
                end;
            {$ENDIF}
            SignalsMode.PanelGain.Visible:=False;
            flgScanDone:=false;
            ScanParams.flgAquiAdd:=true;
            ScanParams.ScanMethod:=UAM;
            SpeedBtnDelTop.visible:=false;
            SpeedBtnSDelTop.visible:=false;
            if (ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY) then TabSheetTopoError.TaBVisible:=True;
            TabSheetTopoL.TabVisible:=True;
            TabSheetSideL.TabVisible:=True;
            TabSheetMatrix.TabVisible:=False;
            PageCtlLeft.ActivePage:=TabSheetTopoL;
          //  PageCtlLeft.ActivePageIndex:=0;
            TabSheetCurLineAdd.TabVisible:=True;
            PageCtrlAdd.ActivePage:=TabSheetCurScan;
            TabSheetTopoError.Caption:=siLangLinked1.GetTextOrDefault('IDS_109' (* 'ForceImage II Pass' *) );
            TabSheetCurLineAdd.Caption:=siLangLinked1.GetTextOrDefault('IDS_110' (* 'Force, mV' *) );
            ImgRInit;
            ImgLInit;
            ClearTabImages;
            ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_111' (* 'Force Image' *) );
        end;
    3:  begin
        //          { TODO : 090906 }   spectroscopy
            SignalsMode.tbSTM.TabVisible:=STMflg;
            SignalsMode.tbSFM.TabVisible:=not STMflg;
            SignalsMode.tbSFMCUR.TabVisible:=False;
         {$IFDEF FULL}
             if not STMflg then
             begin
              if flgUnit<>Pipette  then
               begin
                ApproachParams.BiasV:=0;//  ApproachParams.BiasV:=0;
                Nanoedu.Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
               end;
             end;
             if flgUnit=Pipette  then
             begin
                  SignalsMode.tbSTM.TabVisible:=STMflg;
                  SignalsMode.tbSFM.TabVisible:=false;
                  SignalsMode.tbSFMCUR.TabVisible:=not STMflg;
             end;
        {$ENDIF}
         edNX.Enabled:=False;
         UpDownNX.enabled:=false;
         UpDownNY.enabled:=false;
         edNy.Enabled:=False;
         edY.Enabled:=False;
         edX.Enabled:=False;
         UpDownSpeed.Enabled:=not (ScanParams.ScanMethod=OneLineScan);
         CheckBoxStep.enabled:=False;
         ScrollBarLitho.Enabled:=false;
         ComboBoxPath.enabled:=false;
         BtnClear.Enabled:=False;
        //
          PanelParam.Hint:=siLangLinked1.GetTextOrDefault('IDS_112' (* 'Not available in Spectroscopy mode' *) );
        //spectr
        if STMFlg then HlpCntext:=IDH_Spectroscopy_STM else  HlpCntext:=IDH_Spectroscopy;
           ScanParams.flgSpectr:=true;
           ScanParamsWnd.Enabled:=false;
           BitBtnX0Y0.visible:=false;
           BitBtnRect.Visible:=false;
           BitBtnSQ.Visible:=false;
           BitBtnMgIn.Visible:=false;
           BitBtnMgOut.Visible:=false;
           BtnZoom.visible:=false;
           BtnClear.visible:=false;
           BitBtnClChart.visible:=true;
           panelScanF.Visible:=false;
           PanelChart.left:=1;
           PanelChart.top:=28;
           PanelChart.width:=PanelRight.ClientWidth-3;
           PanelChart.height:=PanelRight.ClientHeight-28;
           ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_114' (* 'Spectroscopy' *) );
         with ImgRChart.BackImage.Bitmap.Canvas do
         begin
           if  ScanParams.NX<200          then  begin szfill:=1;    ImgRChart.BackImage.Bitmap.Canvas.Font.Size:=-4    end
           else   if (ScanParams.NX>=200) and (ScanParams.NX<300) then begin  szfill:=2;Font.Size:=-9  end
           else   if (ScanParams.NX>=300) and (ScanParams.NX<400) then begin  szfill:=3;Font.Size:=-11 end
           else   if (ScanParams.NX>400)  and (ScanParams.NX<500) then begin  szfill:=3;Font.Size:=-12 end
           else   if (ScanParams.NX>=500) then begin  szfill:=4;Font.Size:=-13 ; end;;
         end;
              TabSheetMatrix.TabVisible:=False;
              TabSheetSideL.TabVisible:=True;
              TabSheetTopoR.TabVisible:=True;
              TabSheetScanTran.HighLighted:=False;
              TabSheetCurScan.Caption:=siLangLinked1.GetTextOrDefault('IDS_44' (* 'Topo, nm' *) );
              if STMflg  {or (flgUnit=pipette)} then
              begin
                 with SignalsMode do
                  begin
                     btnBiasV.Caption:=FloattoStrF(ApproachParams.BiasV,ffFixed,5,2)+siLangLinked1.GetTextOrDefault('IDS_50' (* ' V' *) );
                  end;
                 ComboBoxIZ.Visible:=true;
                 SpectrParams.flgIZ:=ComboBoxIZ.Visible and (ComboBoxIZ.ItemIndex=1);
                 ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_117' (* 'Spectroscopy/ Current-Voltage characteristics  ' *) );
              end
             else
              begin
                ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_118' (* 'Force Spectroscopy/Oscillation Apmlitude-sample distance' *) );
              end;
              ImgRChart.BackImage.Bitmap.Assign(BitMapTemp);
              ImgLChart.BackImage.Bitmap.Assign(BitMapLTemp);
              SignalsMode.PanelGain.Visible:=False;
         end;
     4:  begin  //  Current
             if flgUnit=Terra then   panelterra.visible:=true;
             SignalsMode.tbSFM.TabVisible:=false;
             SignalsMode.tbSTM.TabVisible:=STMflg;
             SignalsMode.tbSFMCUR.TabVisible:=false;
             {$IFDEF FULL}
                SignalsMode.tbSFMCUR.TabVisible:=not STMflg;
             {$ENDIF}
              flgScanDone:=false;
              ScanParams.flgAquiAdd:=true;
              ScanParams.ScanMethod:=Current;
              SpeedBtnDelTop.visible:=false;
              SpeedBtnSDelTop.visible:=false;
              TabSheetTopoL.TabVisible:=True;
              TabSheetSideL.TabVisible:=True;
              TabSheetMatrix.TabVisible:=False;
              PageCtlLeft.ActivePage:=TabSheetTopoL;
          //    PageCtlLeft.ActivePageIndex:=0;
              TabSheetCurLineAdd.TabVisible:=True;
              PageCtrlAdd.ActivePage:=TabSheetCurScan;
              TabSheetCurLineAdd.Caption:=siLangLinked1.GetTextOrDefault('IDS_119' (* 'Current, nA' *) );
              TabSheetTopoError.Caption:=siLangLinked1.GetTextOrDefault('IDS_120' (* 'Current II Pass' *) );
              if  STMflg then
                with SignalsMode do
                  begin
                     btnBiasV.Caption:=FloattoStrF(ApproachParams.BiasV,ffFixed,5,2)+siLangLinked1.GetTextOrDefault('IDS_50' (* ' V' *) );
                  end
                  else
                    with SignalsMode do
                  begin
                     btnBiasSFM.Caption:=FloattoStrF(ApproachParams.BiasV,ffFixed,5,2)+siLangLinked1.GetTextOrDefault('IDS_50' (* ' V' *) );
                  end;
              Nanoedu.Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
              ImgRInit;
              ImgLInit;
              ClearTabImages;
              ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_122' (* 'Current' *) );
         end;
     5:  begin      //fast Topo Phase  - Current
//          (*  open when multi use
          SignalsMode.tbSTM.TabVisible:=STMflg;
          SignalsMode.tbSFM.TabVisible:=not STMflg;
          SignalsMode.tbSFMCUR.TabVisible:=False;
         {$IFDEF FULL}
           if comboboxpath.items.Count=4 then
            begin
               ComboBoxPath.items.Delete(3);
               ComboBoxPath.items.Delete(2);
            end;
          PanelSpectrF.Visible:=false;
          SpdBtnOneFRame.visible:=true;
            case  ScanParams.flgOneFrame of
true: begin  SpdBtnOneFrame.Caption:='1'; SpdBtnRecord.visible:=false; end;
false: begin SpdBtnOneFrame.Caption:='V'; SpdBtnRecord.visible:=true; end;
             end;
       //   SpdBtnFB.Visible:=true;//false;      { TODO : 071007 }
          if not STMflg then
          begin
           if flgUnit<>Pipette  then
               begin
                ApproachParams.BiasV:=0;
                Nanoedu.Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
               end;
          end;
        {$ENDIF}
              SpdBtnOneFRame.visible:=true;
                case  ScanParams.flgOneFrame of
true: begin  SpdBtnOneFrame.Caption:='1'; SpdBtnRecord.visible:=false; end;
false: begin SpdBtnOneFrame.Caption:='V'; SpdBtnRecord.visible:=true; end;
             end;
          //    SpdBtnFB.Visible:=true;//270515
              flgScanDone:=false;
              ScanParams.flgAquiAdd:=false;
              PageCtlLeft.Visible:=false;
              BoxFast.Caption:=siLangLinked1.GetTextOrDefault('IDS_123' (* 'Frames' *) );
              LabelLineNum.visible:=false;
              LabelHeight.Visible:=false;
              EdDz.Visible:=false;
              TabSheetCurLine.TabVisible:=False;
          if  STMflg then
                with SignalsMode do
                  begin
                     btnBiasV.Caption:=FloattoStrF(ApproachParams.BiasV,ffFixed,5,2)+siLangLinked1.GetTextOrDefault('IDS_50' (* ' V' *) );
                  end
                  else
                    with SignalsMode do
                  begin
                     btnBiasSFM.Caption:=FloattoStrF(ApproachParams.BiasV,ffFixed,5,2)+siLangLinked1.GetTextOrDefault('IDS_50' (* ' V' *) );
                  end;

           if STMflg then
             begin
                ScanParams.ScanMethod:=FastScan;
                Nanoedu.Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
                ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_125' (* 'Fast Scanning/Current Visialization;  ' *) );
             end
             else  //SFM
             begin
                 ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_126' (* 'Fast Scanning/Phase Shift Visialization;  ' *) );
                 ScanParams.ScanMethod:=FastScanPhase;
             end;
              ImgRInit;
              ClearTabImages;
        end;
     6: begin   //lithography
           SignalsMode.tbSTM.TabVisible:=false;
           SignalsMode.tbSFM.TabVisible:=true;
  (*         {$IFDEF FULL}
                 SignalsMode.tbSFM.TabVisible:=not STMflg;
                 SignalsMode.tbSFMCUR.TabVisible:=False;
           {$ENDIF}
 *)
               finalize(MatrixLitho);
           //    finalize(MatrixLithoAct);
               flgprojection:=false;// flgLoadMatrixImage:=false;
               ScanParams.flgAquiAdd:=false;
               flgScanDone:=false;
               flgchk:=OldflgFixstep;
      //    open when multi use
             {$IFDEF FULL}
              ComboBoxPath.items.Delete(3);
              ComboBoxPath.items.Delete(2);
             {$ENDIF}
             SignalsMode.PanelGain.Visible:=False;
              case RadioTypeLitho.itemindex of
       0: begin   //Force
            Scanparams.ScanMethod:=Litho;
          {$IFDEF FULL}
            SignalsMode.tbSFMCUR.TabVisible:=true;
            SignalsMode.tbSFM.TabVisible:=false;
            ApproachParams.BiasV:=0;
            Nanoedu.Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
            SignalsMode.btnBiasSFM.Caption:='0'+siLangLinked1.GetTextOrDefault('IDS_50' (* ' V' *) );
            SignalsMode.tbSFM.TabVisible:=false;
          {$ENDIF}
          end;
       1: begin     //Current
           Scanparams.ScanMethod:=LithoCurrent;
            ApproachParams.BiasV:=0;
           Nanoedu.Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
          {$IFDEF FULL}
            SignalsMode.tbSFMCUR.TabVisible:=false;//true;
            SignalsMode.tbSFM.TabVisible:=true;//false;
          {$ENDIF}
          end;
              end;
        if not flgProjection   then
        begin
                       with Scanparams do
              begin
               case  ScanPath of
    OneX:           t:=ceil(X*Ny/ScanRate+X*Ny/ScanRateBW+CurrentLithoTimeEtch(Nx,NY));
    OneY:           t:=ceil(Y*Nx/ScanRate+Y*Nx/ScanRateBW+CurrentLithoTimeEtch(Nx,NY));
                      end;
              end;
   //        if Flgterra then  t:=t+0.001*(2*ScanParams.TimMeasurePoint+ScanParams.TerraTDelay)*NX*NY;

              if (t<10)  then FrameTime.Caption:=FloatToStrF(t,ffFixed,7,1)
                 else FrameTime.Caption:=FloatToStrF(t,ffFixed,7,0);
           end;
          //    panelScanF.Visible:=false;
              SpeedBtnDelTop.visible:=false;
              SpeedBtnSDelTop.visible:=false;
              TabSheetTopoL.TabVisible:=True;
              TabSheetSideL.TabVisible:=False;
              TabSheetMatrix.TabVisible:=True;
              TabSheetCurLine.TabVisible:=true;
              PageCtlLeft.ActivePage:=TabSheetMatrix;
              with PageCtlLeft do
               begin
              //  ActiveIndex:=ActivePageIndex;
                for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
                ActivePage.HighLighted:=True;
              end;
              EdStepXYM.text:=edStepXY.text;
              //ScanParams.FlgStepXY;
              ScanParams.FlgStepXY:=True;
              CheckBoxStep.checked:=True;
              OldFlgFixStep:=flgchk;
              CheckBoxStep.Enabled:=False;
              edX.enabled:=false;
              edY.enabled:=false;
              edNX.enabled:=false;
              edNY.enabled:=false;
              edStepXY.enabled:=not ReniShawparams.flgSteponNets;   //   { TODO : 200209 }
              UpDownNx.enabled:=false;
              UpDownNY.enabled:=false;
              BitBtnRect.Visible:=false;
              BitBtnSQ.Visible:=false;
              BitBtnMgIn.Visible:=false;
              BitBtnMgOut.Visible:=false;
             if not flgLoadMatrixImage then BitBtnProject.Enabled:=False;
             ImgRInit;
             ClearTabImages;
             ImgRChart.BackImage.Bitmap.Assign(BitMapTemp);
           //   ImgLChart.BackImage.Bitmap.Assign(BitMapLTemp);
             ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_127' (* 'Lithography' *) );
             TabSheetCurScan.TabVisible:=True;//False;
             TabSheetCurScan.Caption:=siLangLinked1.GetTextOrDefault('IDS_44' (* 'Topo, nm' *) );
        end;
     7: begin   //ONe line Scanning
        //    (*  open when multi use
              SignalsMode.PanelGain.Visible:=False;
              SignalsMode.tbSFM.TabVisible:=not STMflg;
              SignalsMode.tbSTM.TabVisible:=STMflg;
              SignalsMode.tbSFMCUR.TabVisible:=False;
             {$IFDEF FULL}
              ComboBoxPath.items.Delete(3);
              ComboBoxPath.items.Delete(2);
              if flgUnit<>Pipette  then
              begin
               ApproachParams.BiasV:=0;//  ApproachParams.BiasV:=0;
               Nanoedu.Bias:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
              end;
              if flgUnit=Pipette  then
                begin
                    SignalsMode.tbSFM.TabVisible:=false;
                    SignalsMode.tbSFMCUR.TabVisible:=not STMflg;
                end;
            {$ENDIF}
       //     *)
              TabSheetTopoError.Caption:=siLangLinked1.GetTextOrDefault('IDS_129' (* 'One Line II Pass' *) );
              ScanParams.flgAquiAdd:=false;
              ScanParams.ScanMethod:=OneLineScan;
              SpeedBtnDelTop.visible:=false;
              SpeedBtnSDelTop.visible:=false;
              SpeedBTnplDel.Visible:=true;
              TabSheetCurScan.Caption:=siLangLinked1.GetTextOrDefault('IDS_44' (* 'Topo, nm' *) );
              TabSheetSideL.TabVisible:=True;
              TabSheetTopoL.TabVisible:=False;
              TabSheetMatrix.TabVisible:=False;
              PageCtlLeft.ActivePageIndex:=0;
               TabSheetCurLineAdd.TabVisible:=false;
              CheckBoxOnNets.Enabled:=not FlgReniShawUnit;
              ImgRInit;
              ClearTabImages;
              case ScanParams.ScanPath of
        OneX: ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_131' (* 'Multi times scanning along X-axies: Nx- points; Ny- times' *) );
        OneY: ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_132' (* 'Multi times scanning along Y-axies: Ny- points; Nx- times' *) );
       Multi: ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_133' (* 'Multi times two pass scanning along X-axies: Nx- points; Ny- times' *) );
      MultiY: ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_134' (* 'Multi times two pass scanning along Y-axies: NY- points; Nx- times' *) );
                  end;
        end;
    9:  begin //profiler
              TabSheetMatrix.TabVisible:=False;
              TabSheetSideL.TabVisible:=True;
              TabSheetTopoR.TabVisible:=True;
              TabSheetScanTran.HighLighted:=False;
              ScanParams.flgProfile:=true;
        end;
                     end;//case
         PanelChartL.height:=TabSheetTopoL.ClientHeight-28;
         PanelChartLEr.height:=TabSheetTopoError.ClientHeight-28;
         ImgLinit;

  with PageCtlRight do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
   with PageCtlLeft do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
   ScanParams.ScanLineTime:=round(strtofloat(Frametime.Caption)*1000); //msScanParams.TimeWait:=round(t*1000); //ms
end;

procedure TScanWnd.PageCtlLeftChange(Sender: TObject);
var i:integer;
begin
  with PageCtlLeft do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
   FlgViewTypeL:=PageCtlLeft.ActivePage.PageIndex;
   ImgLInit;
end;

procedure TScanWnd.BitBtnPointClearClick(Sender: TObject);
var i:integer;
begin
if ScanParams.flgSpectr    then
begin
  ImgRChart.BackImage.Bitmap.Assign(BitMapTemp);
   if TabSheetTopoL.TabVisible then
     ImgLChart.BackImage.Assign(BitMapLTemp);
end;
if assigned(ArPntSpector)  then
 begin
 for i := 0 to (ArPntSpector.Count - 1) do
   begin
     PntSpector := ArPntSpector.Items[i];
     Dispose(PntSpector);
   end;
   ArPntSpector.Clear;
 end;
end;

procedure TScanWnd.ZIndicatorDraw(Z:apitype);
var i:integer;
begin
  if assigned(ScanWnd) then
  begin
 //    ZIndicatorScan.Value:=round((MinAPITYPE+1)*(Z-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));
 ZIndicatorScan.Value:=round((MaxAPITYPE)*(1-(Z-MinAPITYPE)/(MaxAPITYPE-MinAPITYPE))); // Нормировка изменена 30/07/2013
// ZIndicatorScan.Value:=Z;
//  ZIndicatorVal:=round((MinAPITYPE+1)*(TempAquiData[i]-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));


     LabelZV.Font.color:=clGreen;
     ZIndicatorScan.IndicColor:=clGreen;
     LabelZV.Caption:=FloattoStrF(ZIndicatorScan.Value/Maxapitype,fffixed,3,2);
   if  (ZIndicatorScan.Value < 3200) then
    begin
        ZIndicatorScan.IndicColor:=clRed;
        LabelZV.Font.color:=clRed;
        i:=0;
    end
    else
     begin
     if  (ZIndicatorScan.Value >29000) then
      begin
          ZIndicatorScan.IndicColor:=clNavy;
          LabelZV.Font.color:=clNavy ;
       //   Beep;
      end
    end;
    ZindicatorScan.RePaint;
  end;
end;


procedure TScanWnd.TimerUp(Sender: TObject);
var z:integer;
begin
 Timer.Enabled:=false;
 flgTimerActive:=True;
// if Timer.Enabled then    { TODO : 271007 }
//  begin
    Application.ProcessMessages;
      z:=NanoEdu.ZValue;
      ZIndicatorDraw(z);
     if flgBlickApply then
           begin
            if cl=$000000FF then cl:=$0000000 else cl:=$000000FF;
             if assigned(Scanwnd) then ApplyBitBtn.Font.Color:=TColor(cl);//clRed;
           end;
     if flgBlickSave then
           begin
            if cl=$0000FF00 then cl:=$0000000 else cl:=$0000FF00;
   //           if assigned(Scanwnd) then SaveExpBtn.Font.Color:=TColor(cl);//
           end;
//  end;
   flgTimerActive:=false;
  if not flgStopTimer then Timer.Enabled:=true;  { TODO : 271007 }
end;

procedure TScanWnd.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  flgStopTimer:=true;
  CanClose := False;
  if not FlgStopScan then
    begin
      siLangLinked1.ShowMessage(scan12(* 'Stop Scanning before exit!!!' *) );
    end
    else
    begin
       if not  FlgTimerActive then
       begin // while FlgTimerActive do Application.ProcessMessages;
         if assigned(Timer) then
         begin
          Timer.Enabled:=false;
          FreeAndNil(Timer);
         end;
         CanClose := True;
       end
       else
       begin
        flgStopTimer:=true;
        while  FlgTimerActive do
        begin
          sleep(100);
          application.processmessages;
        end;
        CanClose := True;
       end;
    end;
end;

 function  TScanWnd.CurrentLithoTimeEtch(Nx,NY:integer):single;
var T:single;
    i,j:integer;
 begin
 t:=0;
 if assigned(MatrixLitho) then
  for I := 0 to Scanparams.Nx - 1 do
   for j := 0 to Scanparams.Ny - 1 do
    begin
      if MatrixLitho[j,i]>2 then
      t:=t+ LithoParams.TimeAct*TimeActScale
    end;
   result:=t;
 end;

function  TScanWnd.SetMotionParameters:byte;
var FastAxisDiscrNumb, SlowAxisDiscrNumb:integer;
    t:single;
begin
    ScanParams.ScanRate:= StrToFloat(edScanRate.Text);
    ScanParams.ScanRateBW:= StrToFloat(edScanRateBW.Text);
if (ScanParams.ScanRate=0) or (ScanParams.ScanRateBW=0) then
begin
  siLangLinked1.MessageDlg(scan39,mtError ,[mbOK],0);
  result:=1;
  exit;
end;
if (ScanParams.Nx=0) or (ScanParams.Ny=0) then
begin
  siLangLinked1.MessageDlg(scan36,mtError ,[mbOK],0);
  result:=1;
  exit;
end;
   if ScannerCorrect.FlgXYLinear then    SetLinearPathParameters;
  case ScanParams.ScanPath of
Multi,
OneX:begin
        if ScannerCorrect.FlgXYLinear then
               begin
                  FastAxisDiscrNumb:= ScanSumX;
                  SlowAxisDiscrNumb:= ScanSumY;
               end
               else
               begin
                  FastAxisDiscrNumb:=round(ScanParams.X*TransformUnit.Xnm_d);
                  SlowAxisDiscrNumb:=round(ScanParams.Y*TransformUnit.Ynm_d);
               end;
       if  FlgStopScan  then
                        begin
                            if (( ScanParams.ScanMethod <> FastScan) and (ScanParams.ScanMethod <> FastScanPhase)) then
                               CalcScanRateDriverLimit(ScanParams.X, ScanParams.Nx, ScanParams.ScanRateLimParameter,  ScanParams.ScanRate);

                            SetScanRate(ScanParams.X,FastAxisDiscrNumb,ScanParams.Nx,ScanParams.ScanRate,ScanParams.MicrostepDelay);
                            SetScanRate(ScanParams.X,FastAxisDiscrNumb,ScanParams.Nx,ScanParams.ScanRateBW,ScanParams.MicrostepDelayBW)
                        end
                        else
                        if  (HardWareOpt.XYtune='Rough')
                              then
                                  begin
                                   if (( ScanParams.ScanMethod <> FastScan) and (ScanParams.ScanMethod <> FastScanPhase)) then
                                      CalcScanRateDriverLimit(ScanParams.X, ScanParams.Nx, ScanParams.ScanRateLimParameter,  ScanParams.ScanRate);
                                   SetScanRate(ScanParams.X,FastAxisDiscrNumb,ScanParams.Nx,ScanParams.ScanRate,ScanParams.MicrostepDelay);
                                   SetScanRate(ScanParams.X,FastAxisDiscrNumb,ScanParams.Nx,ScanParams.ScanRateBW,ScanParams.MicrostepDelayBW)
                                  end
                              else  SetScanRateFine(ScanParams.X,FastAxisDiscrNumb,ScanParams.Nx);
        with ScanParams do
         begin
           XMicrostepNmb:= tMicroStepNmb;// JMP;
           YMicrostepNmb:= floor(SlowAxisDiscrNumb/NY/DiscrNumInMicroStep);
           if YMicrostepNmb<1 then YMicrostepNmb:=1;
              case ScanMethod of
     Litho,LithoCurrent:      t:=ceil(X*Ny/ScanRate+X*Ny/ScanRateBW+CurrentLithoTimeEtch(Nx,Ny));
                   else       t:=ceil(X*Ny/ScanRate+X*Ny/ScanRateBW);
                 end;
           if FlgUnit=terra then  t:=t+0.001*(2*0.001*ScanParams.TimMeasurePoint+ScanParams.TerraTDelay)*NX*NY;
          ScanParams.PiezoMoverNStepsXY:=round(ScanParams.X/ScanParams.PiezoMoverSzStepsXY);
                   if (t<10)  then FrameTime.Caption:=FloatToStrF(t,ffFixed,7,1)
                   else FrameTime.Caption:=FloatToStrF(t,ffFixed,7,0);

        end;
      end;
MultiY,
OneY: begin
       if ScannerCorrect.FlgXYLinear then
               begin
                  FastAxisDiscrNumb:= ScanSumY;
                  SlowAxisDiscrNumb:= ScanSumX;
               end
               else
               begin
                 FastAxisDiscrNumb:=round(ScanParams.Y*TransformUnit.Ynm_d);
                 SlowAxisDiscrNumb:=round(ScanParams.X*TransformUnit.Xnm_d);
               end;
        if  FlgStopScan  then
                         begin
                          if (( ScanParams.ScanMethod <> FastScan) and (ScanParams.ScanMethod <> FastScanPhase)) then
                               CalcScanRateDriverLimit(ScanParams.Y, ScanParams.NY, ScanParams.ScanRateLimParameter,  ScanParams.ScanRate);
                           SetScanRate(ScanParams.Y,FastAxisDiscrNumb,ScanParams.NY,ScanParams.ScanRate,ScanParams.MicrostepDelay);
                           SetScanRate(ScanParams.Y,FastAxisDiscrNumb,ScanParams.NY,ScanParams.ScanRateBW,ScanParams.MicrostepDelayBW)
                         end
                         else
                         if  (HardWareOpt.XYtune='Rough')
                              then
                              begin
                                if (( ScanParams.ScanMethod <> FastScan) and (ScanParams.ScanMethod <> FastScanPhase)) then
                                   CalcScanRateDriverLimit(ScanParams.Y, ScanParams.NY, ScanParams.ScanRateLimParameter,  ScanParams.ScanRate);
                                SetScanRate(ScanParams.Y,FastAxisDiscrNumb,ScanParams.NY,ScanParams.ScanRate,ScanParams.MicrostepDelay);
                                SetScanRate(ScanParams.Y,FastAxisDiscrNumb,ScanParams.NY,ScanParams.ScanRateBW,ScanParams.MicrostepDelayBW)
                              end
                              else SetScanRateFine(ScanParams.Y,FastAxisDiscrNumb,ScanParams.NY);
        with ScanParams do
         begin
           YMicrostepNmb:= tMicroStepNmb;// JMP;
           XMicrostepNmb:= floor(SlowAxisDiscrNumb/NX/DiscrNumInMicroStep);
           if XMicrostepNmb<1 then XMicrostepNmb:=1;
               case ScanMethod of
     Litho,LithoCurrent:    t:=ceil(Y*Nx/ScanRate+Y*Nx/ScanRateBW+Ny*Nx*LithoParams.TimeAct*TimeActScale);
                   else     t:=ceil(Y*Nx/ScanRate+Y*Nx/ScanRateBW);
             end;
       if FlgUnit=terra then  t:=t+0.001*(2*0.001*ScanParams.TimMeasurePoint+ScanParams.TerraTDelay)*NX*NY;
               if (t<10)  then FrameTime.Caption:=FloatToStrF(t,ffFixed,7,1)
                 else FrameTime.Caption:=FloatToStrF(t,ffFixed,7,0);
   
         end;
          ScanParams.PiezoMoverNStepsXY:=round(ScanParams.Y/ScanParams.PiezoMoverSzStepsXY);
     end;  //Y
         end;
   edScanRate.Text:=FloatToStrF(ScanParams.ScanRate,ffFixed,10,0);
   edScanRateBW.Text:=FloatToStrF(ScanParams.ScanRateBW,ffFixed,10,0);
   flgFineSpeedLock:=(ScanParams.DiscrNumInMicroStep>1);
   MStepsX:=ScanParams.XMicrostepNmb;     // Number of microsteps between measures (main)
   MStepsY:=ScanParams.YMicrostepNmb;      // Number of microsteps between measures (main)
   result:=0;
 if (ScanParams.DiscrNuminMicroStep*ScanParams.xMicrostepNmb*StrToInt(edNx.Text)>=(MaxApiType-MinApiType)) then  //   $8000     { TODO : 041012 }
     begin
      siLangLinked1.MessageDlg(scan13(*Error!!' *) +#13+scan14 (* 'Maximal value X is exceeded. Reduce a field of scanning.' *)  ,mtError ,[mbOK],0);
      result:=1;
      exit;
     end;
 if (ScanParams.DiscrNuminMicroStep*ScanParams.yMicrostepNmb*StrToInt(edNy.Text)>=(MaxApiType-MinApiType)) then     // $8000
     begin
      siLangLinked1.MessageDlg(scan13 (* 'Error!!' *) +#13+scan15{*siLangLinked1.GetTextOrDefault('strscan33' { 'Maximal value Y is exceeded. Reduce a field of scanning.' } ,mtError ,[mbOK],0);
      result:=1;
      exit;
     end;
 if (tMicroStepNmb=0) then
   begin
      siLangLinked1.MessageDlg(scan16 (* 'You have to increase X or decrease Nx' *)  ,mtError ,[mbOK],0);
      result:=1;
      exit;
   end;
  if assigned(NanoEdu.Method) then
    if (NanoEdu.Method is TScanMoveToX0Y0) or (FlgCurrentUserLevel = Demo) then  NanoEdu.Method.SetSpeed
                                         else  NanoEdu.Method.SetUsersParams;
    //ScanParams.TimeWait:=round(t*1000); //ms
end;

procedure TScanWND.SetLinearPathParameters;
var
  BoundPointX,BoundPointY:single;
  ApprLineX0, ApprLineY0:single;
  LinScanLen, DacOverLen:integer;
begin
  if assigned(JMPX) then JMPX:=nil;
  if assigned(JMPY) then JMPY:=nil;
  SetLength(JMPX,ScanParams.NX+1);
  SetLength(JMPY,ScanParams.NY+1);

  BoundPointX:=SEVAL(NXSplines,ScannerCorrect.NonLinFieldX,XXsp,YXsp,Bx,CX,DX);
  BoundPointY:=SEVAL(NYSplines,ScannerCorrect.NonLinFieldY,XYsp,YYsp,BY,CY,DY);
  ApprLineX0:=BoundPointX-LineXKoef*ScannerCorrect.NonLinFieldX;
  ApprLineY0:=BoundPointY-LineYKoef*ScannerCorrect.NonLinFieldY;
  if (ScanParams.X<=ScannerCorrect.NonLinFieldX)
   then LinScanLen:=ceil(SEVAL(NXSplines,ScanParams.X,XXsp,YXsp,BX,CX,DX)*TransformUnit.Xnm_d)
   else LinScanLen:=ceil((ApprLineX0+LineXKoef*ScanParams.X)*TransformUnit.Xnm_d);

 DACOverLen:=ceil(ScanParams.XBegin*TransformUnit.XPnm_d)+LinScanLen+1-(CSPMSignals[8].MaxDiscr-CSPMSignals[8].MinDiscr)+2;  //discr  ???  { TODO : 041012 }

 if DACOverLen>0 then
 begin
   ScanParams.XBegin:=ScanParams.XBegin-DACOverLen/TransformUnit.Xnm_d;
   if ScanParams.XBegin<0 then
    begin
     ScanParams.X:=ScanParams.Xmax-abs(ScanParams.XBegin);
     ScanParams.XBegin:=0;
    end;
 end;
 if (ScanParams.Y<=ScannerCorrect.NonLinFieldY)
  then LinScanLen:=ceil(SEVAL(NYSplines,ScanParams.Y,XYsp,YYsp,BY,CY,DY)*TransformUnit.Ynm_d)
  else LinScanLen:=ceil((ApprLineY0+LineYKoef*ScanParams.Y)*TransformUnit.Ynm_d);

 DACOverLen:=ceil(ScanParams.YBegin*TransformUnit.YPnm_d)+LinScanLen+1-(CSPMSignals[9].MaxDiscr-CSPMSignals[9].MinDiscr); { TODO : 041012 } //discr  $7FFF

 if DACOverLen>0 then
  begin
   ScanParams.YBegin:=ScanParams.YBegin-DACOverLen/TransformUnit.Ynm_d;
   if ScanParams.YBegin<0 then
    begin
     ScanParams.Y:=ScanParams.Ymax-abs(ScanParams.YBegin);
     ScanParams.YBegin:=0;
    end;
  end;
 LinearMatrix(ScanParams.NX,ScanParams.NY);
end;

function TScanWND.TestDiskFreeSpace:byte;
var
 FreeDiskSpace,flsz: Int64;
 diskName:string;
 disknmb:byte;
begin
 result:=0;
 flsz:=(ScanParams.Nx*ScanParams.NY)*2
       *sizeof(apitype)+sizeof(HeadParmType)+sizeof(MainFileRec);       //file size
 diskName:=ExtractFileDrive(WorkDirectory);
 disknmb:=Ord(diskName[1])-Ord('A')+1;
 FreeDiskSpace:=diskFree(disknmb);
if FreeDiskSpace<>-1 then
 if FreeDiskSpace<1.1*flsz then
 begin
   siLangLinked1.MessageDlg(scan17(* 'Disk is full. Clean up disk  or change work disk!!' *) , mtInformation,[mbOk], 0);
   result:=1;
   Main.setworkdirectory.Enabled:=False;
   ChangeDir:=TChangeDir.Create(self);
   ChangeDir.ShowModal;
 end;
end;
 procedure TScanWND.SetTypeScanPath;
var code:integer;
 begin
                   case  ScanParams.ScanPath of
 OneX : begin     //'X+'
         ComboBoxPath.Hint:=siLangLinked1.GetTextOrDefault('IDS_205' (* 'Scanning along axis X' *) );
         PanelFltr.visible:=false;
         ScannerIniFile:= ScannerIniFileX;
         ScannerDefIniFile:= ScannerDefIniFileX;
         ScannerCorrectLast();
        if assigned(ApproachOpt)then  ApproachOpt.ScanCorrSheetInit;
        code:=TestErrorScannerIniFile;
        SetLinSplineZero;
        if (Code=0) then //LoadLinSpline(HardWareOpt.ScannerNumb);
                         LoadLinSplineFromAdapter;    // изменено 26/04/2013
        if (ScanParams.ScanMethod<>litho) and (ScanParams.ScanMethod<>lithoCurrent)  then
         begin
          edNy.Enabled:=false;
          edNX.Enabled:=true;
          UpDownNx.enabled:=true
         end
         else
         begin
          edNy.Enabled:=false;
          edNX.Enabled:=false;
          UpDownNx.enabled:=false
         end;
         UpDownNx.Visible:=true;
         UpDownNy.Visible:=false;
         UpDownNx.position:=ScanParams.Nx;
        end;
 OneY : begin     //  'Y+'
         ComboBoxPath.Hint:=siLangLinked1.GetTextOrDefault('IDS_206' (* 'Scanning along axis Y' *) );
         PanelFltr.visible:=false;// ComboBoxFilter.Visible:=false; labelFltr.visible:=false;
         ScannerIniFile:= ScannerIniFileY;
         ScannerDefIniFile:= ScannerDefIniFileY;
         ScannerCorrectLast();
         if assigned(ApproachOpt)then ApproachOpt.ScanCorrSheetInit;
         code:=TestErrorScannerIniFile;
         SetLinSplineZero;
         if (Code=0) then //LoadLinSpline(HardWareOpt.ScannerNumb);
                          LoadLinSplineFromAdapter;    // изменено 22/11/2016
         if (ScanParams.ScanMethod<>litho) and (ScanParams.ScanMethod<>lithoCurrent)  then
         begin
          edNx.Enabled:=false;
          edNy.Enabled:=true;
          UpDownNy.enabled:=true
         end
         else
         begin
          edNy.Enabled:=false;
          edNX.Enabled:=false;
          UpDownNy.enabled:=false
         end;
         UpDownNx.Visible:=false;
         UpDownNy.Visible:=true;
         UpDownNy.position:=ScanParams.Ny;
        end;
Multi : begin    // 'MULTI'   //x++
         ComboBoxPath.Hint:=siLangLinked1.GetTextOrDefault('IDS_207' (* 'Two Pass Scanning along axis X' *) );
         PanelFltr.visible:=true;// ComboBoxFilter.Visible:=true; labelFltr.visible:=true;
         ScannerIniFile:= ScannerIniFileX;
         ScannerDefIniFile:= ScannerDefIniFileX;
         ScannerCorrectLast();
        if assigned(ApproachOpt)then  ApproachOpt.ScanCorrSheetInit;
         code:=TestErrorScannerIniFile;
         SetLinSplineZero;
        if (Code=0) then LoadLinSpline(HardWareOpt.ScannerNumb);
         TabSheetTopoError.TabVisible:=True;
         TabSheetLitho.TabVisible:=false;
         TabSheetSpectrR.TabVisible:=false;
         TabSheetMatrix.TabVisible:=false;
        if (ScanParams.ScanMethod<>litho) and (ScanParams.ScanMethod<>lithoCurrent)  then
         begin
          edNy.Enabled:=false;
          edNX.Enabled:=true;
          UpDownNx.enabled:=true
         end
         else
         begin
          edNy.Enabled:=false;
          edNX.Enabled:=false;
          UpDownNx.enabled:=false
         end;
         UpDownNx.Visible:=true;
         UpDownNy.Visible:=false;
         UpDownNx.position:=ScanParams.Nx;
        end;
MultiY : begin     //  'Y++'
         ComboBoxPath.Hint:=siLangLinked1.GetTextOrDefault('IDS_208' (* 'Two Pass Scanning along axis Y' *) );
         PanelFltr.visible:=true;//ComboBoxFilter.Visible:=true;     labelFltr.visible:=true;
         ScannerIniFile:= ScannerIniFileY;
         ScannerDefIniFile:= ScannerDefIniFileY;
         ScannerCorrectLast();
         if assigned(ApproachOpt)then ApproachOpt.ScanCorrSheetInit;
         code:=TestErrorScannerIniFile;
         SetLinSplineZero;
         if (Code=0) then LoadLinSpline(HardWareOpt.ScannerNumb);
         if (ScanParams.ScanMethod<>litho) and (ScanParams.ScanMethod<>lithoCurrent)  then
         begin
          edNx.Enabled:=false;
          edNy.Enabled:=true;
          UpDownNy.enabled:=true
         end
         else
         begin
          edNy.Enabled:=false;
          edNX.Enabled:=false;
          UpDownNy.enabled:=false
         end;
         UpDownNx.Visible:=false;
         UpDownNy.Visible:=true;
         UpDownNy.position:=ScanParams.Ny;
         TabSheetTopoError.TabVisible:=True;
         TabSheetLitho.TabVisible:=false;
         TabSheetSpectrR.TabVisible:=false;
         TabSheetFastTopo.TabVisible:=false;
         TabSheetScanTran.TabVisible:=false;
         TabSheetMatrix.TabVisible:=false;
        end;
                  end; //case
  if ScanParams.ScanMethod=OneLineScan then
                          case ScanParams.ScanPath of
      OneX: ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_131' { 'Multi times scanning along X-axies: Nx- points; Ny- times' } );
      OneY: ImgRChart.Hint:=siLangLinked1.GetTextOrDefault('IDS_132' { 'Multi times scanning along Y-axies: Ny- points; Nx- times' } );
                     end;
 end;
function TScanWND.SetScanParameters:byte ;
var   tol,FastAxisDiscrNumb:integer;
      NRS_inStep:integer;
      delta:single;
begin
 result:=0;
 if HardWareOpt.XYTune='Rough' then tol:=0
                               else tol:=1;
 with ScanParams do
 begin
  if FlgStepXY then
    begin
     if edStepXY.text='' then
       begin  siLangLinked1.messageDLg(scan18(* 'Input StepXY parameter!!' *) , mtWarning,[mbOk],0);  exit end;
     if edNx.text='' then
       begin  siLangLinked1.messageDLg(scan19(* 'Input Nx parameter!!' *), mtWarning,[mbOk],0); result:=1; exit end;
     NX:=StrToInt(edNx.text);
     if edNy.text='' then
       begin  siLangLinked1.messageDLg(scan20(* 'Input Ny parameter!!' *) , mtWarning,[mbOk],0); result:=1; exit end;
     NY:=StrToInt(edNy.text);
     if  odd(Nx) then begin dec(Nx);  edNx.Text:=IntToStr(Nx);  end;
     if  odd(Ny) then begin dec(Ny);  edNy.Text:=IntToStr(Ny);  end;
       X:=NX*scanparams.Stepxy;
       Y:=NY*scanparams.Stepxy;
       edX.text:=FloattostrF(floor(X),fffixed,8,tol);  //step
       edY.text:=FloattostrF(floor(Y),fffixed,8,tol);
     if (X<0.00001) or (Y<0.00001) or (NX=0) or (Ny=0) then
      begin   siLangLinked1.messageDLg(scan21 (* 'zero input' *), mtWarning,[mbOk],0); result:=1;exit end;
      if ((X+XBegin)>XMax) then
       begin
        if not (Scanparams.scanmethod in ScanmethodSetLitho) then
         begin
         Nx:=round((XMax-XBegin)/StepXY);
         X:= Nx*StepXY;
         if  odd(Nx) then dec(Nx);
         edNx.Text:=IntToStr(Nx);
         edX.text:=FloattostrF(floor(X),fffixed,8,tol);  //step
         if FlgSQ then
         begin
          Ny:=Nx;
          Y:= Ny*StepXY;
          edNy.Text:=IntToStr(Ny);
          edY.text:=FloattostrF(floor(Y),fffixed,8,tol);
         end;
         end
         else
         begin
           if not CheckLithoField(Nx,Ny,StepXY)then
            begin result:=1; exit; end;
         end;
        end;
     if ((Y+YBegin)>YMax) then
      begin
       if not (Scanparams.scanmethod in ScanmethodSetLitho) then
        begin
         NY:=round((YMax-YBegin)/StepXY);
        Y:= Ny*StepXY;
        if  odd(Ny) then dec(Ny);
        edNy.Text:=IntToStr(Ny);
        edY.text:=FloattostrF(floor(Y),fffixed,8,tol);
       if FlgSQ then
        begin
         Nx:=NY;
         X:= Nx*StepXY;
         edNx.Text:=IntToStr(Nx);
         edX.text:=FloattostrF(floor(X),fffixed,8,tol);  //step
        end;
        end
        else
        begin
          if not CheckLithoField(Nx,Ny,StepXY)then begin result:=1; exit; end;
         end;
      end;
   end  //fix step
   else   // not fix step
   begin
     if edX.text='' then
      begin  siLangLinked1.messageDLg(scan22(* 'Input X parameter!!' *) , mtWarning,[mbOk],0); result:=1; exit end;
     if edY.text='' then
      begin  siLangLinked1.messageDLg(scan23(* 'Input Y parameter!!' *) , mtWarning,[mbOk],0); result:=1; exit end;
       X:=StrToFloat(edX.Text);
       Y:=StrTofloat(edY.Text);
    case ScanParams.ScanPath of
Multi,OneX:begin
     if edNx.text='' then
      begin  siLangLinked1.messageDLg(scan24(* 'Input Nx parameter!!' *), mtWarning,[mbOk],0); result:=1; exit end;
     NX:=StrToInt(edNX.Text);
     if  odd(nx) then
      begin
       dec(nx);
       edNx.text:=inttostr(nx);
      end;
     if (x<0.00001) or (y<0.00001) or (NX=0) then
      begin   siLangLinked1.messageDLg(scan21(* 'Zero input' *) , mtWarning,[mbOk],0); result:=1; exit end;
     StepXY:=X/NX;
     NY:=round(Y/StepXY);
     if  odd(Ny) then dec(Ny);
     if Ny<=1 then Ny:=2;
     if Ny>LinePointsMax then
      begin
       siLangLinked1.MessageDlg('Ny<='+inttostr(LinePointsMax),mtWarning,[mbOk],0);
       Ny:=LinePointsMax;
       edNy.Text:=IntToStr(LinePointsMax);//'1024';
       y:=ny*StepXY;
       edY.text:=FloattostrF(floor(Y),fffixed,8,tol);
      end;
       edNY.Text:=IntToStr(NY);
     end;
MultiY,OneY:begin
      if edNy.text='' then
        begin  siLangLinked1.messageDLg(scan26(* 'Input Ny parameter!!' *) , mtWarning,[mbOk],0); result:=1; exit end;
      NY:=StrToInt(edNY.Text);
      if  odd(ny) then
      begin
       dec(ny);
       edNy.text:=inttostr(ny);
      end;
      if (x<0.00001) or (y<0.00001) or (NY=0) then
        begin   siLangLinked1.messageDLg(scan21(* 'Zero input' *) , mtWarning,[mbOk],0); result:=1;exit end;
      StepXY:=Y/NY;
      NX:=round(X/StepXY);
      if odd(Nx) then dec(Nx);
      if NX<=1   then NX:=2;
      if NX>LinePointsMax then
      begin
         siLangLinked1.MessageDlg('Nx<='+inttostr(LinePointsMax),mtWarning,[mbOk],0);
         Nx:=LinePointsMax;
         edNx.Text:=IntToStr(LinePointsMax);//'1024';
         x:=nx*StepXY;
         edx.text:=FloattostrF(floor(x),fffixed,8,tol);
      end;
      edNX.Text:=IntToStr(NX);
    end;
               end;
      if HardWareOpt.XYtune='Fine' then edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,2)
                                   else edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,1);
 end; // not fix step
      ScanRate:=StrToFloat(edScanRate.Text);
    ScanRateBW:=StrToFloat(edScanRateBW.Text);
    Xbegin:=Xbegin+Img2XBegin;
    Ybegin:=Ybegin+Img2YBegin;
    R.Left:= round(XBegin/DelImgX);
    R.Top:= ImageScanArea.Height-round((YBegin+Y)/DelImgY);
    R.Right:=round((XBegin+X)/DelImgX);
    R.Bottom:=ImageScanArea.Height-round((YBegin)/DelImgY);
    flgTopRDraw:=False;
    Img2XBegin:=0;
    Img2YBegin:=0;
 end;//with scanparams
 if (StrToFloat(edX.Text)>ScanParams.XMax) then
     begin
       siLangLinked1.messageDLg('X>XMax!!', mtWarning,[mbOk],0);
       result:=1;
       exit;
     end;
 if (StrToFloat(edY.Text)>ScanParams.YMax) then
     begin
      siLangLinked1.messageDLg('Y>Ymax!!', mtWarning,[mbOk],0);
      result:=1;
      exit;
     end;
       case ScanParams.ScanPath of
 Multi,OneX:
        begin
          ChartCurrentLine.BottomAxis.SetMinMax(0,ScanParams.X);
        end;
 MultiY,OneY:
        begin
          ChartCurrentLine.BottomAxis.SetMinMax(0,ScanParams.Y);
        end;
                end;
   if assigned(ApproachOpt) then ApproachOpt.ScanOptGridInit;
      { TODO : 101008 }
         case ScanParams.ScanPath of
Multi,
OneX:  begin
        FastAxisDiscrNumb:=round(ScanParams.X*TransformUnit.Xnm_d);
        TestLimitPoint(FastAxisDiscrNumb,ScanParams.Nx); { TODO : 300506 }
       end ;
MultiY,
OneY: begin
        FastAxisDiscrNumb:=round(ScanParams.Y*TransformUnit.Ynm_d);
        TestLimitPoint(FastAxisDiscrNumb,ScanParams.NY); { TODO : 300506 }
      end;
             end;
  if flgReniShawUnit then
   begin
   //***  MF       200209  OLa
     delta:=Renishawparams.Period_nm/12;
     if Renishawparams.flgSteponNets  or (abs(Renishawparams.Period_nm-ScanParams.StepXY)<delta) then
     begin
            case ScanParams.ScanPath of
Multi,
OneX:    Renishawparams.flgscriptname:=1;
MultiY,
OneY:    Renishawparams.flgscriptname:=4;
              end;
    if (abs(Renishawparams.Period_nm-ScanParams.StepXY)<delta)
     then   ScanParams.StepXY:=Renishawparams.Period_nm;
        ReniShawParams.NParts_inStep:=round(ScanParams.StepXY / Renishawparams.Period_nm);
        ReniShawParams.stepScale:=1;
     end
     else
     begin  //small
      if Renishawparams.Period_nm>ScanParams.StepXY then
      begin
             case ScanParams.ScanPath of
Multi,
OneX:  Renishawparams.flgscriptname:=2;  //small
MultiY,
OneY:  Renishawparams.flgscriptname:=5;
              end;
         ReniShawParams.NParts_inStep:=1;
         ReniShawParams.stepScale:=round(Renishawparams.Period_nm/ScanParams.StepXY);  // 240 nm = ReniShaw PULSEs INTERVAL
     //    if (ReniShowParams.stepScale>1) and odd(ReniShowParams.stepScale) then inc(ReniShowParams.stepScale);
         if (ReniShawParams.stepScale>12) then ReniShawParams.stepScale:=12;
         ScanParams.StepXY:=(Renishawparams.Period_nm/ReniShawParams.stepScale);
         ScanParams.NX:= ReniShawParams.stepScale*(ScanParams.NX div ReniShawParams.stepScale);
         ScanParams.NY:= ReniShawParams.stepScale*(ScanParams.NY div ReniShawParams.stepScale);
      end
      else   //large
      begin
      with RenishawParams do
      begin
        FrontsDistnm:=round(Period_nm);//round(RenishawPeriod *ReniShawScale);
        NRS_inStep:=(round(ScanParams.StepXY)-1) div FrontsDistnm;  // FrontsDistnm =240
        if (ScanParams.StepXY=NRS_inStep*FrontsDistnm) then stepScale:=1
         else  stepScale:= round(FrontsDistnm /(ScanParams.StepXY-NRS_inStep*FrontsDistnm)) ;
      // if (ReniShowParams.stepScale>1) and odd(ReniShowParams.stepScale) then inc(ReniShowParams.stepScale);
         if (RenishawParams.stepScale>12) then RenishawParams.stepScale:=12;
         ScanParams.StepXY:=FrontsDistnm*(NRS_inStep+1/stepScale);
         NParts_inStep:=NRS_inStep* stepScale+1;
      end;
      if ReniShawParams.stepScale=1 then
        case ScanParams.ScanPath of
           Multi,
           OneX:  Renishawparams.flgscriptname:=7; //large
           MultiY,
           OneY:  Renishawparams.flgscriptname:=8;
        end
      else
      begin
       if Scanparams.scanmethod in  ScanmethodSetLitho then
       begin
        MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_35' (* 'Lithograph can be executed only on Renishaw nets!. Choose mode Renishaw nets ' *) ),mtwarning,[mbYes],0);
        result:=1;
        exit;
       end
       else
       begin
        case ScanParams.ScanPath of
         Multi,
         OneX:  Renishawparams.flgscriptname:=3; //large
         MultiY,
         OneY:  Renishawparams.flgscriptname:=6;
            end;
         end;
      end;
     end;
   end;  //renishaw
   //***    MF
         ScanParams.X:= ScanParams.StepXY* ScanParams.NX;
         ScanParams.Y:= ScanParams.StepXY* ScanParams.NY;
         edNx.Text:=IntToStr(ScanParams.Nx);
         edX.text:=FloattostrF(floor(ScanParams.X),fffixed,8,tol);
         edNy.Text:=IntToStr(ScanParams.Ny);
         edY.text:=FloattostrF(floor(ScanParams.Y),fffixed,8,tol);
         edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,1);
   end;
end;   //SetScanParameters

procedure TScanWND.ApplyBtnClick(Sender: TObject);
var wh:integer;
begin
if FlgStopScan then
 begin
 if not (ScanParams.ScanMethod in ScanMethodSetLitho) then
  begin
     edX.enabled:=not CheckBoxStep.checked;
     edY.enabled:=not CheckBoxStep.checked;
  (*   if flgblw then  LithoParams.ScaleAct:=0
      else
       if LithoParams.V>=0
        then  LithoParams.ScaleAct:= (LithoParams.VMax- LithoParams.V)/255
        else  LithoParams.ScaleAct:= (LithoParams.VMin- LithoParams.V)/255
   *)
  end;
 if FlgChange then begin
                        ImageScanArea.Picture.Bitmap.assign(ScanAreaBitMapTemp);
                        ImageScanArea.Canvas.Pen.Color:=clGreen ;
                   end
  else
  begin
   ImageScanArea.Canvas.Pen.Color:=clBlack;
   ImageScanArea.Canvas.Pen.Mode:=pmNotXor;
   ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                             Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
  end;

   DrawRectScanArea;

 if  SetScanParameters>0 then exit;

   SetImageSideLSize;

 if sqrt(sqr(R.left-R.Right)+sqr(R.top-r.Bottom))>5 then
    begin
     ImageScanArea.Canvas.Pen.Color:=clGreen;
     ImageScanArea.Canvas.Pen.Mode:=pmCopy;
     ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                                   Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
   end;
 if ScannerCorrect.FlgXYLinear and (hardWareOpt.XYTune='Rough') then  SetLinearPathParameters;
      case ScanParams.ScanPath of
 Multi,OneX: begin
         ScanParams.ScanPoints:=ScanParams.NX;
         ScanParams.ScanLines:= ScanParams.NY;
        end;
 MultiY,OneY:begin
         ScanParams.ScanPoints:=ScanParams.NY;
         ScanParams.ScanLines:= ScanParams.NX;
        end;
          end;
       ImgRBitMapTemp.Width:=ScanParams.NX;
       ImgRBitMapTemp.Height:=ScanParams.NY;
  ClearTabImages;
  ImgRInit;
  ImgLInit;
  ClearTabImages;
  if Assigned(CurrentLineWnd)   then CurrentLineWnd.ReDraw;
           case  flgUnit  of
nano,ProBeam,MicProbe,
Pipette,
terra: begin
        lblYmax.Caption:=InttoStr(round(ScanParams.Ymax/1000))+' '+mcrn;  //micron
        lblXmax.Caption:=InttoStr(round(ScanParams.Xmax/1000))+' '+mcrn;
       end;
baby: begin
        lblYmax.Caption:=InttoStr(round(ScanParams.Ymax))+siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );  //nm
        lblXmax.Caption:=InttoStr(round(ScanParams.Xmax))+siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );
       end;
grand: begin
        lblYmax.Caption:=InttoStr(round(ScanParams.Ymax/1000))+' '+mcrn;  //micron
        lblXmax.Caption:=InttoStr(round(ScanParams.Xmax/1000))+' '+mcrn;
       end;           end;
end; //flgstopscan
 if SetMotionParameters>0 then exit;
    if (( ScanParams.ScanMethod = FastScan) or (ScanParams.ScanMethod = FastScanPhase)) then
                         if (ScanParams.FastDrawDelay/1000) < strtofloat(FrameTime.caption) then
                                siLangLinked1.MessageDlg('Increase FastDrawDelay or Speed' ,mtwarning,[mbOK],0);

 if  ScanParams.ScanMethod=OneLineScan then ImgRInit;

     edX.Font.Color:=clBlack;
     edY.Font.Color:=clBlack;
     edNx.Font.Color:=clBlack;
     edNy.Font.Color:=clBlack;
     edScanRate.Font.Color:=clBlack;   edScanRateBW.Font.Color:=clBlack;
     ApplyBitBtn.Font.Color:=clBlack;
     flgBlickApply:=False;
   // SideViewInit; only after Start  button press
   ScanParams.ScanLineTime:=round(strtofloat(Frametime.Caption)*1000); //ms
 if  TestDiskFreeSpace>0 then exit;
end;

procedure TScanWND.BtnClearClick(Sender: TObject);
begin
   with ImageScanArea do
      begin
        Canvas.Brush.Color:=clWindow;
        Canvas.FillRect(Rect(0,0,Width,Height));
        ScanAreaBitMapTemp.Assign(ImageScanArea.Picture.Bitmap);
        DrawRectScanArea;
   with Canvas.Pen do
       begin
         Color:=clBlack;
         Mode:=pmCopy;
         Style:=psSolid;
       end;
   end;
      ApplyBitBtn.Font.Color:=clBlack;
      EdX.Text:=Format('%d',[0]);
      EdY.Text:=Format('%d',[0]);
end;

procedure TScanWND.ImageScanAreaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var rCurs: TRect;
   pr: PRect;
   p1,p2:TPoint;
begin
  p1.x:=0;
  p1.y:=0;
  p2.x:=ImageScanArea.width;   p2.y:=ImageScanArea.height;
  rCurs.topleft:=ImageScanArea.ClienttoScreen(p1);
  rCurs.bottomright:=ImageScanArea.ClienttoScreen(p2);
  pr:=@rCurs;
  ClipCursor(pr);
  flagMoveArea:=false;
  flgLeftBtn:=false;
 if FlgStopScan then
  begin
    X0:=X;
    Y0:=Y;
    FlgMouseDown:=True;
    if not (((ScanParams.ScanMethod=Litho) or (ScanParams.ScanMethod=LithoCurrent)) and (Button=mbLeft)) then
      ImageScanArea.Picture.Bitmap.assign(ScanAreaBitMapTemp);
      DrawRectScanArea;
     if (Button=mbLeft) then
     begin
      flgLeftBtn:=True;
       if (ScanParams.ScanMethod<>Litho) and (ScanParams.ScanMethod<>LithoCurrent) then
       begin
         flgDrawArea:=false;
         Screen.Cursor:=crPen;
         R.TopLeft:=Point(X0,Y0);
         R.BottomRight:=Point(X0,Y0);
       end
       else
       begin
         flgLeftBtn:=false;
         flagMoveArea:=false;
       end;
    end
    else
    if (Button=mbRight) then //btn right
       begin
       if ((X>R.Left) and (X<R.Right) and (Y>R.Top) and (Y<R.Bottom))
        then
         begin
           flagMoveArea:=true;
           Screen.Cursor:=crDrag;
           ImageScanArea.Canvas.Pen.Mode:=pmnotXOR;
           ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                        Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
         end
         else
         begin
           ImageScanArea.Canvas.Pen.Color:=clGreen;
           ImageScanArea.Canvas.Pen.Mode:=pmcopy;
           ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                        Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
         end;
          flgLeftBtn:=False;
      end;
   end;
end;

procedure TScanWND.ImageScanAreaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var n:integer;
label 100;
begin
  Application.Processmessages;
if flgLeftBtn or flagMoveArea then
begin
if FlgMouseDown and FlgStopScan then
 begin
  if ((abs(x-x0)>5) or (abs(y-y0)>5)) then
   begin
       flgDrawArea:=true;
       edX.enabled:=false;
       edY.enabled:=false;
       ImageScanArea.Canvas.Pen.Color:=clBlack;
       ImageScanArea.Canvas.Pen.Mode:=pmNOTXOR;
       ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                           Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
       ImageScanArea.Canvas.Polyline([Point(R.Left,R.Top),Point(R.Left,R.Top),
                           Point(R.Left,R.Top),Point(R.Left,R.Top)]);
    if flgLeftBtn  and (ScanParams.ScanMethod<>Litho) and (ScanParams.ScanMethod<>LithoCurrent)then
     begin
       if (X0<X)
        then
         begin
          R.Left:=X0; R.Right:=X;
         end
        else
         begin
          R.Left:=X;  R.Right:=X0;
         end;
       if (Y0<Y)
         then
          begin
            R.Top:=Y0;
            if ScanParams.FlgSQ then
             begin
              if (X0>X) then
               begin
                R.Bottom:=Y0-(X-X0);
                if R.Bottom>ImageScanArea.Height then
                 begin   R.Bottom:=ImageScanArea.Height; R.Left:=R.Right-(R.Bottom-R.top) end
               end
              else
               begin
                R.Bottom:=Y0+(X-X0);
                if R.Bottom>ImageScanArea.Height then
                 begin   R.Bottom:=ImageScanArea.Height; R.Right:=R.left+(R.Bottom-R.top) end
               end
              end
              else R.Bottom:=Y; //FlgSQ=false
          end
         else       //Y0>y
          begin
             R.Bottom:=Y0;
             if ScanParams.FlgSQ then
               begin
                if (X0<X) then
                      begin
                        R.Top:=Y0-(X-X0); if R.Top<0 then begin R.Top:=0; R.Right:=R.left+(R.Bottom-R.Top); end
                      end
                     else
                      begin
                        R.Top:=Y0+(X-X0); if R.Top<0 then begin R.Top:=0; R.Left:=R.Right-(R.Bottom-R.Top);  end
                      end
                end
                     else R.Top:=Y;   //flgSq:=False
          end;
      end
      else     //right button
      if flagMoveArea then
      begin
       if ((R.Right+(X-X0+1)<=ImageScanArea.Width) and ((R.Left+(X-X0)-1)>=0)
           and ((R.Bottom+(Y-Y0)-1)<=ImageScanArea.Height) and ((R.Top+(Y-Y0)+1)>=0)) then
        begin
         R.Left:=R.Left+(X-X0);
         R.Right:=R.Right+(X-X0);
         R.Bottom:=R.Bottom+(Y-Y0);
         R.Top:=R.Top+(Y-Y0);
         X0:=X;
         y0:=Y;
        end;
      end;  //right
    EdX.Text:=Format('%d',[0] );    //to do Apply Red

       if HardWareOpt.XYTune='Rough' then
                                     begin
                                        if flgLeftBtn then
                                         begin
                                          EdX.Text:=FloatToStrF(floor((R.Right-R.Left)*DelImgX),fffixed,8,0);
                                          EdY.Text:=FloatToStrF(floor((R.Bottom-R.Top)*DelImgY),fffixed,8,0);
                                         end
                                        else
                                         begin
                                          EdX.Text:=FloatToStrF(ScanParams.X,fffixed,8,0);
                                          EdY.Text:=FloatToStrF(ScanParams.Y,fffixed,8,0);
                                         end;
                                     end
                                     else
                                     begin
                                       if flgLeftBtn then
                                         begin
                                          EdX.Text:=FloatToStrF(((R.Right-R.Left)*DelImgX),fffixed,8,1);
                                          EdY.Text:=FloatToStrF(((R.Bottom-R.Top)*DelImgY),fffixed,8,1);
                                         end
                                         else
                                          begin
                                          EdX.Text:=FloatToStrF(ScanParams.X,fffixed,8,0);
                                          EdY.Text:=FloatToStrF(ScanParams.Y,fffixed,8,0);
                                         end;
                                     end;
 if (ScanParams.FlgStepXY and (ScanParams.ScanMethod<>Litho)and(ScanParams.ScanMethod<>LithoCurrent) )then
  begin
     n:=floor((R.Right-R.Left)*DelImgX/ScanParams.StepXY);
    if N>LinePointsMax then
    begin
     MessageDlgCtr(scan13(* 'Error!!' *) +#13+' NX>'+inttostr(LinePointsMax),mtwarning,[mbOk],0);
      goto 100;
    end;
    edNX.text:=intToStr(N);
    n:=floor((R.Bottom-R.Top)*DelImgY/ScanParams.StepXY);
    if N>LinePointsMax then
    begin
       MessageDlgCtr(scan13(* 'Error!!' *) +#13+' NY>'+inttostr(LinePointsMax),mtwarning,[mbOk],0);
        goto 100;
    end;
    edNY.text:=intToStr(N);
  end;
    if (EdX.Text='0') then EdX.Text:='1';
    if (EdY.Text='0') then EdY.Text:='1';

   ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                           Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
   ImageScanArea.Canvas.Polyline([Point(R.Left,R.Top),Point(R.Left,R.Top),
                           Point(R.Left,R.Top),Point(R.Left,R.Top)]);
100:
    end;   //(x-x0)>5
  end;
 end;
end;

procedure TScanWND.ImageScanAreaMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var StepXYTmp:single;
    NXTmp,NYTmp:integer;
 begin
     ClipCursor(nil);
     Screen.Cursor:=cursorsaved;
     FlgMouseDown:=False;
     FlgLeftBtn:=False;

 if FlgStopScan then
  begin
   if flgDrawArea   then
    begin
     ScanParams.XBegin:=R.Left*DelImgX;
     ScanParams.YBegin:=(ImageScanArea.Height-R.Bottom)*DelImgY;
     ScanParams.X:=(R.Right-R.Left)*DelImgX;
     ScanParams.Y:=(R.Bottom-R.Top)*DelImgY;
    end
    else
    if not flagMoveArea   then
    begin
     R.Left:= round( ScanParams.XBegin/DelImgX);
     R.Top:= ImageScanArea.Height-round(( ScanParams.YBegin+ ScanParams.Y)/DelImgY);
     R.Right:=round(( ScanParams.XBegin+ ScanParams.X)/DelImgX);
     R.Bottom:=ImageScanArea.Height-round(( ScanParams.YBegin)/DelImgY);
     ImageScanArea.Canvas.Pen.Color:=clGreen;
     ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
           Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
    end;

   with ScanParams do
           case ScanPath of
Multi,OneX:  begin //X+
      if (NX<=1) then NX:=2;
       if not flgStepXY then
        begin
          StepXYTmp:= StrToFloat(EdX.Text)/NX;
          NYTmp:=round(StrToFloat(EdY.Text)/StepXYTmp );
          if NYTmp<=1 then  NYTmp:=2;
          edNY.Text:=IntToStr(NYTmp);
        end
        else
        begin
        end
   end;
MultiY,OneY:    // Y+
     begin
       if (NY<=1) then NY:=2;
       if not flgStepXY then
        begin
          StepXYTmp:= StrToFloat(EdY.Text)/NY;
          NXTmp:=round(StrToFloat(EdX.Text)/StepXYTmp );
          if NXTmp<=1 then  NXTmp:=2;
           edNX.Text:=IntToStr(NXTmp);
         end;
      end;
           end;
            DrawRectScanArea;
     end;
     FlgChange:=false;   flagMoveArea:=False;
     if flgBlickapply then  flgNew_XYBegin:=True;     // 11/02/13
     
end;

procedure TScanWND.edXChange(Sender: TObject);
begin
  edX.Font.Color:=clRed;
  ApplyBitBtn.Font.Color:=clRed;
  flgBlickApply:=True;
  if edX.text='' then  exit
  else
  begin
  try
   if FlgChange then
     begin
    if StrToFloat(edX.text)>(ScanParams.Xmax-ScanParams.XBegin) then
        if HardWareOpt.XYTune='Rough' then
                                     begin
                                       edX.text:=FloatToStrF((ScanParams.Xmax-Scanparams.XBegin),fffixed,8,0);
                                      end
                                     else
                                     begin
                                       edX.text:=FloatToStrF((ScanParams.Xmax-Scanparams.XBegin),fffixed,8,1);
                                     end;
//        edX.text:=FloatToStrF((ScanParams.Xmax-Scanparams.XBegin),fffixed,8,0);

      if ScanParams.FlgSQ then
        begin
         edY.text:=edX.text;
        end;
     end;
 except
    on EConvertError do
     begin siLangLinked1.MessageDlg(scan32 (* 'error input' *) ,mtWarning,[mbOk],0);edX.text:='0';end;
  end;
  end;
end;

procedure TScanWND.edYChange(Sender: TObject);
begin
 edY.Font.Color:=clRed;
 ApplyBitBtn.Font.Color:=clRed;
 flgBlickApply:=True;
 if edY.text='' then  exit
 else
 begin
 try
 if FlgChange then
  begin
   if StrToFloat(edY.text)>(ScanParams.Ymax-Scanparams.YBegin) then edY.text:=FloatToStrF((ScanParams.Ymax-Scanparams.YBegin),fffixed,8,0);
   if ScanParams.FlgSQ then
     begin
       edX.text:=edY.text;
     end;
  end;
 except
    on EConvertError do
    begin siLangLinked1.MessageDlg(scan32(* 'error input' *) ,mtWarning,[mbOk],0); edY.text:='0';end;
 end;
 end;
end;

procedure TScanWND.edNXChange(Sender: TObject);
var nxt:integer;
begin
 edNX.Font.Color:=clRed;
 ApplyBitBtn.Font.Color:=clRed;
  flgBlickApply:=True;
(* if edNX.text='' then  exit
  else
  begin
 try
  {$I-}
  nxt:=strtoint(edNX.text);
 if nxt>LinePointsMax then
   begin
    MessageDlg('Nx<='+inttostr(LinePointsMax),mtWarning,[mbOk],0);
    nxt:=LinePointsMax;
    edNx.text:=inttostr(nxt);
   end;
 except
    on EConvertError do
    begin MessageDlg(siLangLinked1.GetTextOrDefault('IDS_172' (* 'error input'  ),mtWarning,[mbOk],0); edNx.text:='0'end;
  end;
   {$I+}
 flgBlickApply:=True;
 end;
 *)
end;

procedure TScanWND.edScanRateChange(Sender: TObject);
var v:single;
begin
  edScanRate.Font.Color:=clRed;
  ApplyBitBtn.Font.Color:=clRed;
  FlgBlickApply:=True;
 try
  v:=strtofloat(edScanRate.text);
 except
    on EConvertError do
    begin siLangLinked1.MessageDlg(scan32(* 'error input' *),mtWarning,[mbOk],0); edScanRate.text:='1000'; v:=1000;end;
 end;
   if flgSpeedLock then
     begin
      edScanRateBW.Text:=format('%d',[round(v*ScanParams.ScanRateBW/Scanparams.ScanRate)]);
     end;
end;

procedure TScanWND.BitBtnMClick(Sender: TObject);
var XMaxTmp,YMaxTmp:single;
   i, error:integer;
   ScanPathold:word;
begin
 DisableTopPanel(true);
//  NanoEdu.ScanMoveToX0Y0Method(Scanparams.XBegin,Scanparams.YBegin);
  NanoEdu.Method:=TScanMoveToZeroPoint.Create(0,0);     { TODO : 041012 }
  error:=NanoEdu.Method.Launch;
   while assigned(ProgressMoveTo) do application.processmessages;
// FreeAndNil(NanoEdu.Method);
  if error<>0 then
  begin
   RestoreStartSFM;
   exit
  end;
  Application.ProcessMessages;
 DisableTopPanel(false);
  ScanPathold:=Scanparams.ScanPath;
  ClearTabImages;
   if HardWareOpt.XYtune='Fine'      //fine->rough
   then
     begin

          BitBtnMgIn.Visible:=false;// {not FlgReniShawUnit and} True;
          BitBtnMgOut.Visible:=false;//{ not FlgReniShawUnit and} False;
      if STMflg then  CaptionBase:=CaptionDemo+siLangLinked1.GetTextOrDefault('IDS_48' (* 'Sample Surface Scanning; STM Rough Regime' *) )
                else  CaptionBase:=CaptionDemo+siLangLinked1.GetTextOrDefault('IDS_53' (* 'Sample Surface Scanning; SFM Rough Regime' *) );
        Caption:=CaptionBase+Captionadd+CaptionRenishaw;
        TabSheetFastTopo.TabVisible:=False;

       with  HardWareOpt do
        begin
              XYTune:='Rough';
              AMPGainX:=AMPGainRX;
              AMPGainY:=AMPGainRY;
       end ;
       case flgUnit of
   nano,
   Pipette,
   terra: SetScanParamsDef;
   ProBeam,MicProbe: SetScanParamsDefSEM;
   baby: SetScanParamsDefAtom;
   grand: SetScanParamsDefGrand;
         end;
         if FlgReniShawUnit then
         begin
            CheckBoxOnNets.Checked:=true;
            Scanparams.StepXY:=RenishawParams.Period_nm ;
            UPdownRS.position:=0;//050510
         end;
        { TODO : 071007 }
         edScanRate.Text  :=FloatToStrF(ScanParams.ScanRate,ffFixed,10,0);
         edScanRateBW.Text:=FloatToStrF(ScanParams.ScanRateBW,ffFixed,10,0);
         PageCtlRight.Height:=50;
         { TODO : 071007 }
     end
  else           //Rough    - Fine
     begin
          PageCtlRight.Height:=65;
          
          BitBtnMgIn.Visible:={not FlgReniShawUnit and} False;
          TabSheetFastTopo.TabVisible:=True;
          if STMflg then   CaptionBase:=CaptionDemo+siLangLinked1.GetTextOrDefault('IDS_47' (* 'Sample Surface Scanning; STM Fine Regime' *) )
                    else   CaptionBase:=CaptionDemo+siLangLinked1.GetTextOrDefault('IDS_52' (* 'Sample Surface Scanning; SFM Fine Regime' *) );
          Caption:=CaptionBase+Captionadd+CaptionRenishaw;
          BitBtnMgOut.Visible:=false;//{ not FlgReniShawUnit and} True;
     if STMflg  then TabSheetFastTopo.Caption:=siLangLinked1.GetTextOrDefault('IDS_185' (* 'Fast Scan/Current' *) )
                else TabSheetFastTopo.Caption:=siLangLinked1.GetTextOrDefault('IDS_186' (* 'Fast Scan/Phase' *) );
       with  HardWareOpt do
        begin
            XYTune:='Fine';
            AMPGainX:=AMPGainFX;
            AMPGainY:=AMPGainFY;
        end;
          case flgUnit of
   nano,
   Pipette,
   terra: SetScanParamsDefF;
 ProBeam,MicProbe: SetScanParamsDefSEMF;
    baby: SetScanParamsDefAtomF;
   grand: SetScanParamsDefGrandF;
           end;
         if FlgReniShawUnit then
         begin
            CheckBoxOnNets.Checked:=false;
            Scanparams.StepXY:=RenishawParams.Period_nm*0.10 ;
         end;

    end;    /// end if   HardWareOpt.XYtune='Fine'
    ///
      Scanparams.ScanPath:=ScanPathold;
      TransformUnitInit ;
      NanoEdu.FineXY:=(HardWareOpt.XYTune='Fine');
      SetXYMax;
      if FlgCurrentUserLevel =Demo then  SetXYMaxDemo(PageCtlRight.ActivePageIndex);
          case  flgUnit  of
nano,ProBeam,MicProbe,
Pipette,
terra:
       begin
        lblYmax.Caption:=InttoStr(round(ScanParams.Ymax/1000))+' '+mcrn;  //micron
        lblXmax.Caption:=InttoStr(round(ScanParams.Xmax/1000))+' '+mcrn;
       end;
baby: begin
        lblYmax.Caption:=InttoStr(round(ScanParams.Ymax))+' '+siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );  //nm
        lblXmax.Caption:=InttoStr(round(ScanParams.Xmax))+' ' +siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );
       end;
grand: begin
        lblYmax.Caption:=InttoStr(round(ScanParams.Ymax))+' '+siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );  //nm
        lblXmax.Caption:=InttoStr(round(ScanParams.Xmax))+' ' +siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) );
       end;
            end;
//{$IFDEF DEBUG}
(*   if HardWareOpt.XYtune='Rough' then
    begin
      if  FlgRenishawUnitExists then
       begin
        CheckBoxdrift.Visible:=true;
        SpeedBtnRenishaw.Visible:=true;
        FlgRenishawUnit:=true;
        SpeedBtnRenishawExecute; //turn on RS
       end
    end
    else
    begin //fine
        SpeedBtnRenishaw.Visible:=false;
        FlgRenishawUnit:=false;
        SpeedBtnRenishawExecute;
    end;
 *)
   (*  if  FlgRenishawUnit then
       begin
         FlgRenishawUnit:=true;
     //    Scanparams.flgStepXY:=Checkboxonnets.checked;
    //    if Scanparams.flgStepXY then Scanparams.StepXY:=RenishawParams.Period_nm;
         SpeedBtnRenishawExecute;
      end;
    *)
// {$ENDIF}
      if ScanParams.X>ScanParams.XMax then ScanParams.X:=ScanParams.XMax{*0.5};
      if ScanParams.Y>ScanParams.YMax then ScanParams.Y:=ScanParams.YMax{*0.5};
      DelImgX:=(ScanParams.XMax/ImageScanArea.Width);
      DelImgY:=(ScanParams.YMax/ImageScanArea.Height);
           with ScanParams do
           begin
               if HardWareOpt.XYTune='Rough' then
                                     begin
                                       edX.Text:=FloatToStrF(ScanParams.X,fffixed,8,0);//format('%d',[round(ScanParams.X)]);
                                       edY.Text:=FloatToStrF(ScanParams.Y,fffixed,8,0);//format('%d',[round(ScanParams.Y)]);
                                     end
                                     else
                                     begin
                                       edX.Text:=FloatToStrF(ScanParams.X,fffixed,8,1);//format('%d',[round(ScanParams.X)]);
                                       edY.Text:=FloatToStrF(ScanParams.Y,fffixed,8,1);//format('%d',[round(ScanParams.Y)]);
                                     end;
            edNX.Text:=format('%d',[ScanParams.NX]);
            edNY.Text:=format('%d',[ScanParams.NY]);
           if HardWareOpt.XYtune='Fine' then edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,2)
                                        else edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,1);
            R_S.Left:= round(XBegin/DelImgX);
            R_S.Top:= ImageScanArea.Height-round((YBegin+Y)/DelImgY);
            R_S.Right:=round((XBegin+X)/DelImgX);
            R_S.Bottom:=ImageScanArea.Height-round((YBegin)/DelImgY);
           end;
           with ImageScanArea do
           begin
             Canvas.Brush.Color:=clWindow;
             Canvas.FillRect(Rect(0,0,Width,Height));
             ScanAreaBitMapTemp.Assign(ImageScanArea.Picture.Bitmap);
             DrawRectScanArea;
              with Canvas.Pen do
               begin
                Color:=clBlack;
                Mode:=pmCopy;
                Style:=psSolid;
               end;
              Canvas.Polyline([Point(R_S.Left,R_S.Bottom),Point(R_S.Left,R_S.Top),
               Point(R_S.Right,R_S.Top),Point(R_S.Right,R_S.Bottom),Point(R_S.Left,R_S.Bottom)]);
              R:=R_S;
          end;
      InvalidateRect(handle,nil,False);
    if  (Scanparams.Scanmethod=FastScan) or  (Scanparams.Scanmethod=FastScanPhase) then
       begin
         ApplyBtnClick(self);
         PageCtlRight.SelectNextPage(True);
         PageCtlRight.SelectNextPage(True);
       end;

  with PageCtlRight do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
   with PageCtlLeft do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
             edScanRate.Enabled:=true;
             UpDownSpeed.Enabled:=true;
            EdScanRateBW.Enabled:=not flgSpeedLock;
           UpDownSpeedBW.Enabled:=not flgSpeedLock;
(* DisableTopPanel(true);
  NanoEdu.ScanMoveToX0Y0Method(Scanparams.XBegin,Scanparams.YBegin);
  error:=NanoEdu.Method.Launch;
  FreeAndNil(NanoEdu.Method);
  if error<>0 then
  begin
   RestoreStartSFM;
   exit
  end;
  Application.ProcessMessages;
 DisableTopPanel(false);
 *)
end;

procedure TScanWnd.FormActivate(Sender: TObject);
begin
   inherited;
   self.setFocus;
end;

procedure TScanWnd.EdXKeyPress(Sender: TObject; var Key: Char);
begin
   if not(Key in ['0'..'9',#8]) then Key :=#0;
   flgChange:=true;
end;

procedure TScanWnd.EdYKeyPress(Sender: TObject; var Key: Char);
begin
  flgChange:=true;
   if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TScanWnd.edNXKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TScanWnd.edNXKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
    var nxt:integer;
begin
  if (key=VK_DELETE) or (Key=VK_BACK)   then flgchange:=true;
  if (Key = VK_INSERT) and (Shift = []) then   InsertOn := not InsertOn;
  if (Key=VK_RETURN) then
begin
 edNy.Font.Color:=clRed;
 ApplyBitBtn.Font.Color:=clRed;
 if edNx.text='' then  siLangLinked1.MessageDlg(scan36(* 'error input Nx' *) ,mtWarning,[mbOk],0)
  else
  begin
 try
 {$I-}
  nxt:=strtoint(edNX.text);
 if  nxt>LinePointsMax then
   begin
        MessageDlg('Nx<='+inttostr(LinePointsMax),mtWarning,[mbOk],0);
        nxt:=LinePointsMax;
        edNx.text:=inttostr(nxt);
   end;
  except
    on EConvertError do
    begin siLangLinked1.MessageDlg(scan36(* 'error input Nx' *),mtWarning,[mbOk],0); edNx.text:='0'end;
  end;
  {$I+}
 flgBlickApply:=True;
  Application.processmessages;
 end;
end;
end;

procedure TScanWnd.EdScanRateKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TScanWnd.BitBtnHelpClick(Sender: TObject);
begin
 if STMFlg then
  begin
        case ScanParams.ScanMethod of
 Topography,
    Current      : HlpContext:=IDH_Scanning_STM;
  OneLineScan    : HlpContext:=IDH_One_Line_STM;
  FastScan       : HlpContext:=IDH_Fast_Scan_STM;
  Spectr         : HlpContext:=IDH_Spectroscopy_STM;
        end;
   end
  else
   begin
      case ScanParams.ScanMethod of
  Topography,Phase,
  UAM:             HlpContext:=IDH_Scanning_SFM;
  OneLineScan  :   HlpContext:=IDH_One_Line_SCAN;
  FastScanPhase:   HlpContext:=IDH_Fast_Scan;
  Spectr:          HlpContext:=IDH_Spectroscopy;
  Litho:           HlpContext:=IDH_Litho;
  LithoCurrent:    HlpContext:=IDH_CurrentLitho;  ///!!!!!!!!!!!!!!!!!!!!!!HELP
        end;
   end;
  Application.HelpContext(HlpContext);
end;

procedure TScanWnd.BitBtnRectClick(Sender: TObject);
begin
     ScanParams.flgSQ:=false;
     BitBtnRect.visible:=False;
     BitBtnSQ.visible:=True;
     MargL:=0;
     MargR:=0;
end;

procedure TScanWnd.BitBtnSqClick(Sender: TObject);
begin
     ScanParams.flgSQ:=true;
     BitBtnRect.visible:=True;
     BitBtnSQ.visible:=False;
     MargL:=0;
     MargR:=0;
end;

procedure TScanWnd.EdStepXYChange(Sender: TObject);
begin
if ScanParams.FlgStepXY then
 begin
  with ScanParams do
  begin
   if edStepXY.text='' then   exit;
 try
   StepXY:=StrToFloat(edStepXY.text);
   if  FlgRenishawUnit then
   begin
     if StepXY>2*ReniShawParams.Period_nm then
     begin
       siLangLinked1.MessageDlg(siLangLinked1.GetTextOrDefault('IDS_147' (* 'The current step more then the maximum step= ' *) )+floattostrf(2*ReniShawParams.Period_nm,fffixed,8,3) ,mtWarning,[mbOk],0);
       StepXY:=2*ReniShawParams.Period_nm;
       if HardWareOpt.XYtune='Fine' then edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,2)
                                    else edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,1);
     end;
   end;
    x:=StepXY*Nx;
    y:=StepXY*Ny;
          if HardWareOpt.XYTune='Rough' then
                                     begin
                                       edX.Text:=FloatToStrF(floor(X),fffixed,8,0);//format('%d',[round(ScanParams.X)]);
                                       edY.Text:=FloatToStrF(floor(Y),fffixed,8,0);//format('%d',[round(ScanParams.Y)]);
                                     end
                                     else
                                     begin
                                       edX.Text:=FloatToStrF(X,fffixed,8,1);//format('%d',[round(ScanParams.X)]);
                                       edY.Text:=FloatToStrF(Y,fffixed,8,1);//format('%d',[round(ScanParams.Y)]);
                                     end;
  except
    on EConvertError do
    begin siLangLinked1.MessageDlg(scan32 (* 'error input' *) ,mtWarning,[mbOk],0); edStepxy.text:='50'end;
end;
  flgchange:=true;{ TODO : 170209 }
end;
  flgBlickApply:=True;
 end;
end;

procedure TScanWnd.EdNYChange(Sender: TObject);
var nyt:integer;
begin
edNy.Font.Color:=clRed;
 ApplyBitBtn.Font.Color:=clRed; flgBlickApply:=True;
(* if edNy.text='' then  exit
  else
  begin
 try
 {$I-}
  nyt:=strtoint(edNy.text);

 if  nyt>LinePointsMax then
   begin
        MessageDlg('Ny<='+inttostr(LinePointsMax),mtWarning,[mbOk],0);
        nyt:=LinePointsMax;
        edNy.text:=inttostr(nyt);
   end;
  except
    on EConvertError do
    begin MessageDlg(siLangLinked1.GetTextOrDefault('IDS_172' (* 'error input'  ),mtWarning,[mbOk],0); edNy.text:='0'end;
  end;
  {$I+}
 flgBlickApply:=True;
 end;
 *)
end;


procedure TScanWnd.EdNYKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9',#8]) then Key :=#0;
//   if ((edNY.SelLength = 0) and (not InsertOnY)) then
//    edNY.SelLength := 1;

end;


procedure TScanWnd.EdStepXYKeyPress(Sender: TObject; var Key: Char);
begin
   flgChange:=True;
   if not(Key in ['0'..'9',decimalseparator,#8]) then Key :=#0;
end;


procedure TScanWnd.CheckBoxDriftClick(Sender: TObject);
begin
  flgMoveToBeginbyRS:=checkboxdrift.Checked;
end;

procedure TScanWnd.CheckBoxOnNetsClick(Sender: TObject);
begin
 ReniShawparams.flgSteponNets:= not ReniShawparams.flgSteponNets;
 if ReniShawparams.flgSteponNets then UpDownRS.position:=0;
 CheckBoxOnNetsExecute;
end;
procedure TScanWnd.CheckBoxOnNetsExecute;
begin
     if ReniShawparams.flgSteponNets then
         begin
           ScanParams.StepXY:= RenishawParams.Period_nm;
           UpDownRS.Visible:=true;
           edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,1);
           flgchange:=true;
         end
         else
         begin
          UpDownRS.Visible:=false;
         end;
     EdStepXY.Enabled:= not ReniShawparams.flgSteponNets;
end;
procedure TScanWnd.CheckBoxRSClick(Sender: TObject);
begin
  FlgRenishawUnit:=CheckBoxRS.checked;//not FlgRenishawUnit;
  SpeedBtnRenishawExecute;
end;

procedure TScanWnd.CheckBoxStepClick(Sender: TObject);
begin
    UpDownNx.position:=0;
    UpDownNy.position:=0;
   if CheckBoxStep.checked then
    begin
     ScanParams.FlgStepXY:=True;
     edX.enabled:=false;
     edY.enabled:=false;
     edNX.enabled:=false;
     edNY.enabled:=false;
     UpDownNx.Enabled:=false;
     UpDownNy.Enabled:=false;
     edStepXY.enabled:=True;
     EdStepXY.Enabled:= not ReniShawparams.flgSteponNets;
     edStepXY.Color:=clWhite;
     OldFlgFixStep:=true;
    end
    else
    begin
      ScanParams.FlgStepXY:=false;
      edX.enabled:=true;
      edY.enabled:=true;
      case  ScanParams.ScanPath of
 Multi,
 OneX: begin
         edNX.enabled:=true;
         edNY.enabled:=false;
         UpDownNx.Enabled:=true;
         UpDownNy.Enabled:=false;
        end;
 MultiY,
 OneY:  begin
         edNX.enabled:=false;
         edNY.enabled:=True;
         UpDownNx.Enabled:=false;
         UpDownNy.Enabled:=true;
        end;
          end;
      edStepXY.Color:=clMenu;
      edStepXY.enabled:=false;
      OldFlgFixStep:=false;
     end;
end;

procedure TScanWnd.ComboBoxPathChange(Sender: TObject);
var code,i:integer;
begin
  if FlgBlickApply then
   begin
     siLangLinked1.MessageDLG(scan31 (* 'You have changed ScanParameters. Press Apply button, before change direction!' *) , mtwarning,[mbOK],0);
     ComboBoxPath.ItemIndex:=ScanParams.ScanPath;
     exit
   end;
   case  ComboBoxPath.ItemIndex of
   2,3 : begin
          if FlgRenishawUnit then
          begin
            siLangLinked1.MessageDLG(scan40{'The Multipass scanning don''t work with Renishaw!'} , mtwarning,[mbOK],0);
            ComboBoxPath.ItemIndex:=ScanParams.ScanPath;
            exit
          end;
         end;
                  end;
    ApplyBitBtn.Font.Color:=clRed;
    flgBlickApply:=True;
    TabSheetTopoError.TaBVisible:=False; // 'MULTI'

    if not STMflg and (flgUnit<>Pipette) (*and (flgUnit<>ProBeam)*) then TabSheetLitho.TabVisible:=true;      //250116
        TabSheetSpectrR.TabVisible:=true;
        TabSheetFastTopo.TabVisible:=true;//(HardWareOpt.XYTune='Fine');
    if  FlgCurrentUserLevel<>Demo            then     TabSheetScanTran.TabVisible:=true;
   ScanParams.ScanPath:=ComboBoxPath.ItemIndex;
   SetTypeScanPath;
        PanelChartL.height:=TabSheetTopoL.ClientHeight-28;
        PanelChartLEr.height:=TabSheetTopoError.ClientHeight-28;
        ImgLinit;
  with PageCtlRight do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
   with PageCtlLeft do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
      TransformUnitInit ;
   if FlgCurrentUserLevel =Demo then  SetXYMaxDemo(PageCtlRight.ActivePageIndex)
                                else
                                begin
                   //                 ApprLinesParamsCalc(HardWareOpt.ScannerNumb);
                   //                 SetXYMax;
                                end;
 //    ScanAreaUpdate;        { TODO : 2220906 }
      ApplyBitBtn.Font.Color:=clRed;
      ApplyBtnClick(self);
      if Assigned(CurrentLineWnd)   then CurrentLineWnd.ReDraw
end;

procedure TScanWnd.BitBtnLoadImClick(Sender: TObject);
 var BitMap:TBitMap;
  kh,kw:single;
  MatrixBitMapFileName:string;
  OpenPictureDlg:TOPenPictureDialog;
begin
  OpenPictureDlg:=TOPenPictureDialog.Create(self);
  OpenPictureDlg.InitialDir:=LithoTemplDirectory;
  OpenPictureDlg.DefaultExt:='bmp';
  OpenPictureDlg.Filter:='image  files *.bmp|*.bmp';
 if FlgCurrentUserLevel=Demo then   OpenPictureDlg.InitialDir:=DemoDataDirectory+DemoSampleLitho;
 Application.processmessages;
 if OpenPictureDlg.Execute then
  begin
   if FlgCurrentUserLevel=Demo then
    begin
     MatrixBitMapFileName:=DemoDataDirectory+DemoSampleLitho+'\'+'DemoLithoSFM.bmp';
     if not FileExists(MatrixBitMapfileName) then
     begin
      MessageDlgCtr(scan30(* 'Demo Lithography file not exists!!!' *) , mtInformation,[mbOk],0);
      exit
     end;
    end
    else MatrixBitMapfileName:=OpenPictureDlg.FileName;
    if FlgCurrentUserLevel<>Demo then LithoTemplDirectory:=ExtractFilePath(MatrixBitMapfileName);
    BitMap:= TBitmap.Create;
   try
    Bitmap.LoadFromFile(MatrixBitMapfileName);
    if odd(Bitmap.Height) then  Bitmap.Height:=Bitmap.Height-1;
    if odd(Bitmap.Width)  then  Bitmap.Width:=Bitmap.Width-1;


 //   if Bitmap.Height*Bitmap.Width*sizeof(integer) mod 512 =0 then
 //    Bitmap.Width:=Bitmap.Width+2;
     

    ImageMatrix.Top:=0;
    ImageMatrix.Left:=0;
    kh:=PanelMatrix.Height/BitMap.Height;
    kw:=PanelMatrix.Width/BitMap.Width;
    if kh>kw then
     begin
        ImageMatrix.Width:=PanelMatrix.Width;
        ImageMatrix.Height:=round(ImageMatrix.Width*BitMap.Height/BitMap.Width);
     end
     else
     begin
        ImageMatrix.Height:=PanelMatrix.Height;
        ImageMatrix.Width:=round(ImageMatrix.Height*BitMap.Width/BitMap.Height);
     end;
    edNxM.text:=IntTostr(BitMap.Width);
    edNyM.text:=IntTostr(BitMap.Height);
    ImageMatrix.Picture.Assign(BitMap);
    flgblw:=(RadioGroupBW.Itemindex=0);
    BLW_GRAYConvert;
    flgLoadMatrixImage:=true;
    BitBtnProject.enabled:=True;
    flgProjection:=false;

   finally
     FreeAndNil(Bitmap);
     OpenPictureDlg.destroy;
   end;
  end;
end;

procedure TScanWnd.BitBtnProjectClick(Sender: TObject);
var
 i,j:integer;
 BitMap:TBitMap;
 P:PByteArray;
 VRed,VBlue,VGreen:array of array of word;
 height:array of word;
 Nx,Ny:integer;
 dlt,Step:single;
 bufMatrix:array of array of Smallint;
// flgblw:boolean;
begin
    flgProjection:=false;
    flgblw:=(RadioGroupBW.Itemindex=0);
    edNx.text:=edNxM.text;
    edNy.text:=edNyM.text;
    Ny:=ImageMatrix.Picture.Bitmap.Height;
    Nx:=ImageMatrix.Picture.Bitmap.Width;
    if (Nx>LinePointsMax)  then
    begin  siLangLinked1.MessageDlg('Nx>'+inttostr(LinePointsMax),mtWarning,[mbOk],0); exit end;
    if (NY>LinePointsMax)  then
    begin  siLangLinked1.MessageDlg('Ny>'+inttostr(LinePointsMax),mtWarning,[mbOk],0); exit end;

    Step:=StrToFloat(edStepXY.text);
    if  not  CheckLithoField(Nx,Ny,Step) then exit;
    if Nx=Ny then BitBtnSqClick(Sender)
             else BitBtnRectClick(Sender);
    BitBtnSq.visible:=false;  BitBtnRect.Visible:=false;    { TODO : 230107 }
//200209 set stepxym in visible
//    edStepXYM.text:=FloatToStrF(Step,ffFixed,5,0);
//    edStepXY.text:=edStepXYM.text;
    CheckBoxStep.checked:=True;
    ApplyBitBtn.Font.Color:=clRed;
    FlgBlickApply:=true;
    PageCtrlScan.ActivePageIndex:=0;
    ImageScanArea.Picture.Bitmap.assign(ScanAreaBitMapTemp);
    flgchange:=true;
     /////!!!!ApplyBtnClick(Sender);
//  if assigned(MatrixLitho) then MatrixLitho:=nil;
      setlength(matrixlitho,0,0);
      setLength(MatrixLitho,Ny,Nx);

    //  setlength(matrixlithoact,0,0);
    //  setLength(MatrixLithoAct,Ny,Nx);

      ApplyBtnClick(Sender);        //  16/02/2009 Ola

      BitMap:=TBitMap.Create;
      setLength(VBlue,Ny,Nx);
      setLength(VGreen,Ny,Nx);
      setLength(VRed,Ny,Nx);


 try
     CopyMe(BitMap,ImageMatrix.Picture.Graphic);
             case flgblw of
    true:  begin
             setlength(height,2);
             height[0]:=0;
             height[1]:=255;
             dlt:=128;
           end;
    false: begin
             setlength(height,8);
             dlt:=(255/7);
             for i := 0 to 7 do  height[i]:=round(dlt*i)
           end;
                   end;

    for j:= 0 to BitMap.height -1 do
     begin
         P := BitMap.ScanLine[j];
        for i := 0 to BitMap.width -1 do
         begin
              VBlue[j,i] :=height[floor( P[3*i]/dlt)];
              VGreen[j,i]:=height[floor( P[3*i+1]/dlt)];
              VRed[j,i]  :=height[floor( P[3*i+2]/dlt)];
           MatrixLitho[BitMap.height-1-j,i] := round((255-(VBlue[j,i]+VGreen[j,i]+VRed[j,i])/3));
         end;
         P:=nil;
     end;

    finally
     VBlue:=nil;
     VGreen:=nil;
     VRed:=nil;
     FreeAndNil(BitMap);
 end;
     flgProjection:=True;
     ApplyBtnClick(Sender);
end;


procedure TScanWnd.ScrollBarLithoScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
  var value:apitype;
begin
 case  Scanparams.ScanMethod of
   lithocurrent:if ScrollPos>=0 then BitBtnActLitho.Font.color:=clRed else BitBtnActLitho.Font.color:=clBlue;
          else   BitBtnActLitho.Font.color:=clRed;
                     end;

    case RadioTypeLitho.itemindex of
   0: begin   //Force
       Value:=round(ScrollPos*LithoTransform);
       BitBtnActLitho.text:=FloatToStrF(ScrollPos,fffixed,5,0);
       LithoParams.ScaleAct:=value/255;
      end;
   1: begin   //Current
        Value:=round(ScrollBarLitho.Position*LithoTransform/10);    //discret
        BitBtnActLitho.text:=FloatToStrF(ScrollBarLitho.Position/10,fffixed,5,1);  //nm
        LithoParams.V:=value;
      if flgblw then  LithoParams.ScaleAct:=0
      else
       if value>0
        then  LithoParams.ScaleAct:= (LithoParams.VMax- LithoParams.V)/255
        else  LithoParams.ScaleAct:= (LithoParams.VMin- LithoParams.V)/255
       end;
          end;
     FlgProjection:=false;
 end;

procedure TScanWnd.BitBtnActLithoClick(Sender: TObject);
begin
   ScrollBarLitho.Visible:=True;
end;

procedure TScanWnd.EdStepXYMChange(Sender: TObject);
begin
    FlgProjection:=False;
end;


procedure TScanWnd.PageCtrlScanChange(Sender: TObject);
var i:integer;
begin
  with PageCtrlScan do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
     ActivePage.HighLighted:=True;
  end;
  with PageCtrlAdd do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
end;

procedure TScanWnd.BitBtnHelpLithoClick(Sender: TObject);
begin
   if STMFlg then HlpContext:=IDH_Litho else  HlpContext:=IDH_Litho;
   Application.HelpContext(HlpContext);
end;

procedure TScanWnd.BitBtnSpectrHelpClick(Sender: TObject);
begin
 if STMFlg then HlpContext:=IDH_Spectroscopy_STM else  HlpContext:=IDH_Spectroscopy;
   Application.HelpContext(HlpContext);
end;

procedure TScanWnd.InitWinScanAreaParams;
begin
 edScanNmb.Text:='0';
 edDZ.Text:='0';
 if HardWareOpt.XYTune='Rough' then
                                begin
                                  edX.Text:=FloatToStrF(round(ScanParams.X),fffixed,8,0);
                                  edY.Text:=FloatToStrF(round(ScanParams.Y),fffixed,8,0);
                                end
                                else
                                begin
                                  edX.Text:=FloatToStrF(ScanParams.X,fffixed,8,1);
                                  edY.Text:=FloatToStrF(ScanParams.Y,fffixed,8,1);
                               end;

 edNX.Text:=format('%d',[ScanParams.NX]);
 edNY.Text:=format('%d',[ScanParams.NY]);
// edScanRate.Text:=format('%d',[round(ScanParams.ScanRate)]);
 if HardWareOpt.XYtune='Fine' then edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,2)
                              else edStepXY.Text:=FloatToStrF(ScanParams.StepXY,ffFixed,7,1);
 edScanRate.Text:=FloatToStrF(ScanParams.ScanRate,ffFixed,10,0);
 edScanRateBW.Text:=FloatToStrF(ScanParams.ScanRateBW,ffFixed,10,0);
 ScanParams.StepXY:=StrToFloat(edX.Text)/ScanParams.NX;
 ApplyBitBtn.Font.Color:=clBlack;
 edX.Font.color:=clBlack;
 edY.Font.color:=clBlack;
 edNX.Font.color:= clBlack;
 edNY.Font.color:= clBlack;
 edScanRate.Font.Color:= clBlack ;  edScanRateBW.Font.Color:= clBlack ;
end;

procedure TScanWnd.UpDownSpeedClick(Sender: TObject; Button: TUDBtnType);
begin
    if (Button = btNext) then
    begin
    try
     if strtoint(edScanRate.Text)<MaxSpeedValue div 2 then
     edScanRate.Text:=floattostrf(2*strtoint(edScanRate.Text),fffixed,10,0);
    except
    on EConvertError do
      edScanRate.Text:='1000';
    end;
    end
   else
    begin
      edScanRate.Text:=floattostrf(round(0.5*strtoint(edScanRate.Text)),fffixed,10,0);
      if  strtoint(edScanRate.Text)=0 then  edScanRate.Text:='1';
    end;
end;

procedure TScanWnd.BitBtnTutorClick(Sender: TObject);
var filename:string;
   res:Thandle;
begin
case Scanparams.ScanMethod of
Litho:           filename:='Animation\afm_lithography-dynamic_plowing.swf';
LithoCurrent:    filename:='Animation\afm_oxidation_Lithography.swf';
else
begin
    case  STMFLG  of
false:    filename:='Animation\semicontact_mode2.swf';
true :   filename:='Animation\Constant Current mode_ru.swf';
         end;
end;
         end;
 if  FileExists(CommonNanoeduDocumentsPath+filename) then
  begin
  (* res:= ShellExecute(handle,nil,Pchar(CommonNanoeduDocumentsPath+filename),nil,nil,SW_SHOWNORMAL or SW_RESTORE {or SW_MAXIMIZE}	);
   if  Res<32 then
    begin
     case res of
   SE_ERR_NOASSOC:begin
                 if silanglinked1.MessageDlg('There is no application associated with the given file name extension.Install flash player?',mtwarning,[mbYes,mbNo],0)=mrYes then
                 begin
                 if FileExists(InstallFlashplayerpath) then
                   ShellExecute(handle,nil,Pchar(InstallFlashplayerPath),nil,nil,SW_RESTORE or SW_MAXIMIZE	);
                 end;
               end;
                end; //case
 end
   else
   *)
  begin
    ShockWave:=TShockWave.create(Sender,Pchar(CommonNanoeduDocumentsPath+filename));
    ShockWave.Show;
    ShockWave.ShockwaveFlash.play;
  end;

(*    ShockWave:=TShockWave.create(Sender,CommonNanoeduDocumentsPath+filename);
    ShockWave.PanelBottom.Visible:=not (Scanparams.ScanMethod in ScanmethodSetLitho);
    ShockWave.Show;
  if ShockWave.PanelBottom.Visible then ShockWave.Caption:=siLangLinked1.GetTextOrDefault('IDS_227' { 'Scanner Design' } );
    ShockWave.ShockwaveFlash.play;
    *)
  end;

end;

procedure TScanWnd.BitBtnTimeActClick(Sender: TObject);
begin
   ScrollBarTime.Visible:=true;
end;

procedure TScanWnd.ScrollBarTimeScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
var t:single;
begin
         LithoParams.TimeAct:=ScrollBarTime.position;
         LithoParams.TimeAct:=round(LithoParams.TimeAct/ScrollBarTime.LargeChange)*ScrollBarTime.LargeChange;
         with ScrollBarTime do
      begin
      case ScrollCode of
 scLineUp,scLinedown :
              begin
                  BitBtnTimeAct.text:=Format('%d',[round(LithoParams.TimeAct/ScrollBarTime.LargeChange)*ScrollBarTime.LargeChange]);
              end;
 scTrack:     begin
                  BitBtnTimeAct.text:=Format('%d',[round(LithoParams.TimeAct/ScrollBarTime.LargeChange)*ScrollBarTime.LargeChange]);
               end;
 scEndScroll: begin
                 BitBtnTimeAct.text:=Format('%d',[round(LithoParams.TimeAct/ScrollBarTime.LargeChange)*ScrollBarTime.LargeChange]);
                 ScrollBarTime.Visible:=true
              end;
           end;
    //nanoeduII
      if Assigned(Nanoedu.Method) then Nanoedu.Method.SetUsersParams;
//     SetCommonUserVar(ch_TimeAction,LithoParams.TimeAct);  //aTimeLithoZ=$92;      ->$98
       //
        end;
                     with   Scanparams do
             begin
                 case ScanPath of
          OneX:       t:=ceil(X*Ny/ScanRate+X*Ny/ScanRateBW+CurrentLithoTimeEtch(Nx,NY));
          OneY:       t:=ceil(Y*Nx/ScanRate+Y*Nx/ScanRateBW+CurrentLithoTimeEtch(Nx,NY));
                      end;
                   if FlgUnit=terra then  t:=t+0.001*(2*0.001*ScanParams.TimMeasurePoint+ScanParams.TerraTDelay)*NX*NY;
           end;
                   if (t<10)  then FrameTime.Caption:=FloatToStrF(t,ffFixed,7,1)
                    else FrameTime.Caption:=FloatToStrF(t,ffFixed,7,0);

end;

procedure TScanWnd.ScrollBarTTErraScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
                case ScrollCode of
 scTrack,
 scLineUp,
 scLineDown:  begin
                  ScanParams.TerraTDelay:=ScrollPos;
                  lbleditTterra.Text:=inttostr(ScanParams.TerraTDelay);
                   ApplyBitBtn.Font.Color:=clRed;
                   FlgBlickApply:=True;
                  // SetCommonUserVar(ch_TerraDelay,ScanParams.TerraTDelay);//   if assigned(NanoEdu.Method)  and (NanoEdu.Method is TTopography) then NanoEdu.Method.SetSpeed;
              end;
 scEndScroll: begin
                  ScanParams.TerraTDelay:=ScrollPos;
                  ApplyBitBtn.Font.Color:=clRed;
                  FlgBlickApply:=True;
                  lbleditTterra.Text:=inttostr(ScanParams.TerraTDelay);
                //  SetCommonUserVar(ch_TerraDelay,ScanParams.TerraTDelay);//
               //  if assigned(NanoEdu.Method)  then NanoEdu.Method.SetUsersParams;
              end;
                 end;

end;

procedure TScanWnd.ImgRChartZoom(Sender: TObject);
begin
// To remember last ScanParams
R_S.Left:=round(ImgRChart.BottomAxis.Minimum);
R_S.right:=round(ImgRChart.BottomAxis.Maximum);
R_S.top:=round(ImgRChart.LeftAxis.Maximum);
R_S.Bottom:=round(ImgRChart.LeftAxis.Minimum);
if r_S.Left<0 then R.Left:=0;
if r_S.Top<0  then R.Top:=0;
if r_S.Right>ScanParams.NX-1  then R.Right:=ScanParams.NX-1;
if r_S.Bottom>ScanParams.NY-1 then R.Bottom:=ScanParams.NY-1;
//ImgRChart.UndoZoom;//ercent(100);

ImgRChart.BackImage.Bitmap.Canvas.FrameRect(R_S);

  //if  flgStepXY then
       begin
           with ScanParams do
         begin
           X:=abs(R_S.Right-R_S.Left);
           Y:= abs(R_S.Bottom-R_S.top);
           NX:= round(X/StepXY);
           NY:= round(Y/StepXY);
               if HardWareOpt.XYTune='Rough' then
                                     begin
                                       edX.Text:=FloatToStrF(X,fffixed,8,0);//format('%d',[round(ScanParams.X)]);
                                       edY.Text:=FloatToStrF(Y,fffixed,8,0);//format('%d',[round(ScanParams.Y)]);
                                     end
                                     else
                                     begin
                                       edX.Text:=FloatToStrF(X,fffixed,8,1);//format('%d',[round(ScanParams.X)]);
                                       edY.Text:=FloatToStrF(Y,fffixed,8,1);//format('%d',[round(ScanParams.Y)]);
                                     end;
       //   edX.text:=FloatToStrF(X,fffixed,8,0);
      //    edY.text:=FloatToStrF(Y,fffixed,8,0);
           edNX.text:=IntToStr(NX);
           edNy.text:=IntToStr(NY);
           end;
       end  ;
end;

procedure TScanWnd.ImgRChartUndoZoom(Sender: TObject);
begin
// Restore previous ScanParams
end;

procedure TScanWnd.ImgRChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  rr: TRect;
    pr: PRect;
begin
  rr.topleft:=ImgRchart.ClienttoScreen(ImgRChart.ChartRect.topleft);
  rr.bottomright:=ImgRchart.ClienttoScreen(ImgRChart.ChartRect.bottomright);
  pr := @rr;
  ClipCursor(pr);
  flgLeftBtn:=false;
 if (Button=mbLeft) then
     begin flgLeftBtn:=True; FieldMouseDown( ImgRChart,Sender,Button,X,Y);   end;
end;

procedure TScanWnd.ImgRChartMouseMove(Sender: TObject; Shift: TShiftState;X, Y: Integer);
begin
if flgMouseDown then
 if FlgStopScan then
  begin
  if (flgLeftBtn) then
   begin
     FieldMouseMove(ImgRChart, Sender,  X,Y);
   if (abs( R_S.Right-R_S.Left)>5) or  (abs(R_S.Bottom-R_S.Top)>5) then
    begin
      flgImgRghtScanArea:=true;
        if HardWareOpt.XYTune='Rough' then
                                  begin
                                    edX.Text:=FloatToStrF(round(R_S.Right-R_S.Left)*ScanParams.StepXY,fffixed,8,0);//format('%d',[round(ScanParams.X)]);
                                    edY.Text:=FloatToStrF(round(R_S.Bottom-R_S.Top)*ScanParams.StepXY,fffixed,8,0);//format('%d',[round(ScanParams.Y)]);
                                  end
                                  else
                                  begin
                                    edX.Text:=FloatToStrF((R_S.Right-R_S.Left)*ScanParams.StepXY,fffixed,8,1);//format('%d',[round(ScanParams.X)]);
                                    edY.Text:=FloatToStrF((R_S.Bottom-R_S.Top)*ScanParams.StepXY,fffixed,8,1);//format('%d',[round(ScanParams.Y)]);
                                  end;
     if ScanParams.FlgStepXY then
     begin
      edNX.text:=intToStr(round(StrToFloat(edX.text)/scanparams.stepxy));
      edNY.text:=intToStr(round(StrToFloat(edY.text)/scanparams.stepxy));
     end;
    end;
   end;
end;
end;

procedure TScanWnd.ImgRChartMouseUp(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var OldBkMode:integer;
    maxpoint:integer;
begin
 ClipCursor(nil);
 self.Cursor:=cursorsaved;
if not ScanParams.flgSpectr then
begin
ZBegin:=False;  flgMouseDown:=False;
if FlgStopScan  and flgImgRghtScanArea then
 begin
 if flgLeftBtn then
  begin
   FlgChange:=True; flgImgRghtScanArea:=false;
  Img2XBegin:=R_S.Left*ScanParams.StepXY;
  Img2YBegin:=(ScanParams.NY-R_S.Bottom)*ScanParams.StepXY;
  flgnew_XYBegin:=True;
     if  ScanParams.flgStepXY then
       begin
           edNX.text:=IntToStr(R_S.Right-R_S.Left);
           edNy.text:=IntToStr(R_S.Bottom-R_S.top);
                if HardWareOpt.XYTune='Rough' then
                                     begin
                                       edX.Text:=FloatToStrF(ScanParams.X,fffixed,8,0);//format('%d',[round(ScanParams.X)]);
                                       edY.Text:=FloatToStrF(ScanParams.Y,fffixed,8,0);//format('%d',[round(ScanParams.Y)]);
                                     end
                                     else
                                     begin
                                       edX.Text:=FloatToStrF(ScanParams.X,fffixed,8,1);//format('%d',[round(ScanParams.X)]);
                                       edY.Text:=FloatToStrF(ScanParams.Y,fffixed,8,1);//format('%d',[round(ScanParams.Y)]);
                                     end;
       end
   end;
  end;
 end
 else
 begin   //spectroscopy
 // if flgScanDone then
   with ImgRChart.BackImage.Bitmap.Canvas do
     begin
       Brush.Color:=clRed;
       Font.Color := clBlue;
       maxpoint:=max(ScanParams.NX,ScanParams.NY);
   if maxpoint<=90 then    Font.Size:=-8
       else
       if maxpoint<=200 then      Font.Size:=-8
       else
        begin
         if (maxpoint>200) and (maxpoint<=300) then   Font.Size:=-10
         else   if maxpoint>300 then  Font.Size:=-11 ;
        end;
       FillRect(Rect(mx0-szfill,my0-szfill,mx0+szfill,my0+szfill));
       OldBkMode := SetBkMode(Handle, TRANSPARENT);
       TextOut(mx0+5,my0-13,IntToStr(ArPntSpector.Count+1));
       SetBkMode(Handle, OldBkMode);
        Brush.Color:=ImgRChart.Color;//clWhite;
      end;
   if TabSheetTopoL.TabVisible then
     with ImgLChart.BackImage.Bitmap.Canvas do
     begin
       Brush.Color:=clRed;
       Font.Color := clBlue;
       maxpoint:=max(ScanParams.NX,ScanParams.NY);
   if maxpoint<=90 then    Font.Size:=-8
       else
       if maxpoint<=200 then      Font.Size:=-8
       else
        begin
         if (maxpoint>200) and (maxpoint<=300) then   Font.Size:=-10
         else   if maxpoint>300 then  Font.Size:=-11 ;
        end;
       FillRect(Rect(mx0-szfill,my0-szfill,mx0+szfill,my0+szfill));
       OldBkMode := SetBkMode(Handle, TRANSPARENT);
       TextOut(mx0+5,my0-13,IntToStr(ArPntSpector.Count+1));
       SetBkMode(Handle, OldBkMode);
       Brush.Color:=ImgLChart.Color;//clWhite;
      end;
           new(PntSpector);
       PntSpector^.Point.x:=round(mx0*ScanParams.StepXY+ScanParams.XBegin);
       PntSpector^.Point.y:=round(abs((ScanParams.NY-my0)*ScanParams.StepXY+ScanParams.YBegin));
       ArPntSpector.Add(PntSpector);

 (*  else
   begin
       MessageDlgCtr(siLangLinked1.GetTextOrDefault('IDS_113' (* 'Make Scanning before Spectroscopy!!'  ), mtInformation,[mbOk,mbHelp],IDH_Scanning_SFM);
   end;
  *)
 end;
end;

function TScanWnd.PointInside(CurrPoint:Tpoint ; ChRect:TRect):boolean;
begin
Result:=False;
if  (CurrPoint.X >=ChRect.Left)   and (CurrPoint.X<=ChRect.Right)
    and (CurrPoint.Y>=ChRect.Top) and (CurrPoint.Y<=ChRect.Bottom)
    then Result:=True;
end;


procedure TScanWnd.UpDownNyClick(Sender: TObject; Button: TUDBtnType);
begin
   if (Button = btNext) then
    begin
       if (ScanParams.Ny+10)< LinePointsMax then ScanParams.Ny:= ScanParams.Ny+10 ;
    end
    else
    begin
      if (ScanParams.Ny-10)>=10 then ScanParams.Ny:= ScanParams.Ny-10 ;
    end;
      edNy.Text:=inttostr(ScanParams.Ny);
end;

procedure TScanWnd.UpDownRSClick(Sender: TObject; Button: TUDBtnType);
begin
     if (Button = btNext) then
    begin
     edStepXY.Text:=floattostrf((strtofloat(edStepXY.Text)+ReniShawParams.Period_nm),fffixed,10,0);
    end
   else
    begin
      edStepXY.Text:=floattostrf((strtofloat(edStepXY.Text)-ReniShawParams.Period_nm),fffixed,10,0);
    end;
end;

procedure TScanWnd.UpDownNxClick(Sender: TObject; Button: TUDBtnType);
begin
   if (Button = btNext) then
    begin
      if (ScanParams.Nx+10)<=LinePointsMax then ScanParams.Nx:= ScanParams.Nx+10 ;
    end
    else
    begin
      if (ScanParams.Nx-10)>=10 then ScanParams.Nx:= ScanParams.Nx-10 ;
    end;
      edNx.Text:=inttostr(ScanParams.Nx);
end;

procedure TScanWnd.CalcChartFields(Chart:TChart);
var LX,LY:integer;
begin
 LX:=ScanParams.NX;
 LY:=ScanParams.NY;
 ChartFieldX:=40;
 ChartFieldY:=40;
 Chart.MarginLeft:=0;//MargL;
 Chart.MarginRight:=5;//0;//MargR;
 Chart.Title.Text.Clear;
 Chart.LeftAxis.LabelsSize:=0;
 Chart.BottomAxis.LabelsSize:=0;
 if LX/LY >6 then
   begin
      Chart.BottomAxis.LabelsSize:=10;
      ChartFieldY:=ChartFieldY+Chart.BottomAxis.LabelsSize;
   end;
 if LX/LY <0.2 then
   begin
     Chart.LeftAxis.LabelsSize:=10;
     Chart.LeftAxis.Title.caption:=' ';
     Chart.MarginLeft:=20;
     Chart.MarginRight:=10;
     Chart.Title.Text.Add(siLangLinked1.GetTextOrDefault('IDS_9' (* 'nm' *) ));
     ChartFieldX:=ChartFieldX+Chart.LeftAxis.LabelsSize+Chart.MarginLeft+Chart.MarginRight;
   end;
end;

procedure TscanWND.FitChartToPanel(Chart:TChart; LX,LY,PanelW,PanelH:integer);
begin
   with Chart do
   if LX>=LY then
   begin
    Width:=PanelW;
    Height:=round((Width-ChartFieldX)*LY/LX)+ChartFieldY;
    Left:=0;
    Top:=PanelH div 2-Height div 2;
   end
   else
   begin
     Height:=PanelH;
     Width:= round((Height-ChartFieldY)*LX/LY)+ChartFieldX;
     Top:=0;
     left:=(PanelW) div 2-Width div 2;
   end;
end;

procedure  TscanWND.CopyClipboard;
var i:integer;
    H:HWND;
    bitmap:Tbitmap;
begin
     for  i := 0 to Screen.FormCount-1 do
         begin
            if  Screen.Forms[i].Formstyle=fsStayOnTop then Screen.Forms[i].Hide;
         end;
    h:=findwindow(PChar('TImgAnalysWnd'),nil);
    if h<>0 then ShowWindow(h, SW_HIDE);
     Position:=poMainFormCenter;
     Repaint;
     Application.ProcessMessages;
 try
  bitmap:=Tbitmap.Create;
  bitmap.Width:=ClientWidth;
  bitmap.Height:=ClientHeight;
  with bitmap.Canvas do CopyRect(ClientRect,Canvas,ClientRect);
  ClipBoard.Assign(bitmap);
 finally
  FreeAndNil(bitmap)
 end;
   for  i := 0 to Screen.FormCount-1 do
           begin
             if  Screen.Forms[i].Formstyle=fsStayOnTop then Screen.Forms[i].Show;
           end;
   if h<>0 then ShowWindow(h, SW_RESTORE);
end;

function TScanWnd.CheckLithoField(XPoints,yPoints:integer;Step:single):boolean;
var MaxValidStepX, maxValidStepY, maxValidStep:single;
begin
result:=true;
with ScanParams do
     begin
        MaxValidStepX:=(XMax-XBegin)/XPoints;
        MaxValidStepY:=(YMax-YBegin)/YPoints;
     end;
 if  MaxValidStepX>MaxValidStepY then
     MaxValidStep:=MaxValidStepY else MaxValidStep:=MaxValidStepX;
  if Step>MaxValidStep then
  begin
   Step:=floor(MaxValidStep)-1;
   result:=false;
   siLangLinked1.messageDlg(scan29(* 'Projection exeeds Scan Field Limits. ' *) +#13+siLangLinked1.GetTextOrDefault('IDS_238' (* 'Shift Scan Field or decrease Step XY' *) )+#13 +siLangLinked1.GetTextOrDefault('IDS_239' (* 'to ' *) ) +
   FloatToStrF(Step,ffFixed,5,0)+ siLangLinked1.GetTextOrDefault('IDS_240' (* ' nm' *) ),mtwarning,[mbOk],0);
  end;
end;

procedure TScanWnd.ImgLChartAfterDraw(Sender: TObject);
begin
if FlgFirstDrawImgL then
  begin
    FlgFirstDrawImgL:=False;
    ImgSizeCorr(ImgLChart);
    MargL:=ImgRChart.MarginLeft;
    MargR:=ImgRChart.MarginRight;
  end;
end;

procedure TScanWnd.ImgRChartAfterDraw(Sender: TObject);
begin
if FlgFirstDrawImgR then
  begin
    FlgFirstDrawImgR:=False;
    ImgSizeCorr(ImgRChart);
    MargL:=ImgRChart.MarginLeft;
    MargR:=ImgRChart.MarginRight;
  end;
end;

procedure TScanWnd.EdNYKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var nyt:integer;
begin
  if (Key = VK_INSERT) and (Shift = []) then  InsertOnY := not InsertOnY;
  if (Key = VK_RETURN)   then
  begin
   edNy.Font.Color:=clRed;
   ApplyBitBtn.Font.Color:=clRed;
   if edNy.text='' then siLangLinked1.MessageDlg(scan37 (* 'error input Ny' *) ,mtWarning,[mbOk],0)
   else
   begin
   try
  {$I-}
    nyt:=strtoint(edNy.text);
   if  nyt>LinePointsMax then
   begin
        MessageDlg('Ny<='+inttostr(LinePointsMax),mtWarning,[mbOk],0);
        nyt:=LinePointsMax;
        edNy.text:=inttostr(nyt);
   end;
   except
    on EConvertError do
    begin siLangLinked1.MessageDlg(scan37 (* 'error input Ny' *) ,mtWarning,[mbOk],0); edNy.text:='0'end;
  end;
  {$I+}
  flgBlickApply:=True;
  Application.processmessages;
  end;
 end;
end;

procedure TScanWnd.BitBTnActLithoKeyPress(Sender: TObject; var Key: Char);
begin
   case RadioTypeLitho.itemindex of
   0:  if not(Key in ['0'..'9',#8])     then Key :=#0;
   1:  if not(Key in ['-','0'..'9',#8]) then Key :=#0;
       end;
end;

procedure TScanWnd.BitBTnActLithoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if (Key = VK_INSERT) and (Shift = []) then  InsertOnAct := not InsertOnAct;
end;

procedure TScanWnd.BitBtnTimeActKeyDown(Sender: TObject; var Key: Word;   Shift: TShiftState);
begin
    if (Key = VK_INSERT) and (Shift = []) then  InsertOnTimeAct := not InsertOnTimeAct;
end;

procedure TScanWnd.BitBtnTimeActKeyPress(Sender: TObject; var Key: Char);
begin
    if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TScanWnd.BitBTnActLithoChange(Sender: TObject);
begin
 if BitBtnActLitho.text='' then  exit
  else
  begin
   try
     case  Scanparams.ScanMethod of
   lithocurrent:if StrToFloat(BitBtnActLitho.text)>=0 then BitBtnActLitho.Font.color:=clRed else BitBtnActLitho.Font.color:=clBlue;
      else   BitBtnActLitho.Font.color:=clRed;
              end;

      case RadioTypeLitho.itemindex of
    0: begin   //Force
        if StrToFloat(BitBtnActLitho.text)>ScrollBarLitho.Max then
             BitBtnActLitho.text:=FloatToStrF(ScrollBarLitho.Max,fffixed,6,0);
         ScrollBarLitho.position:=StrToint(BitBtnActLitho.text);
       end;
    1: begin   //Current
         if StrToFloat(BitBtnActLitho.text)*10>ScrollBarLitho.Max then
             BitBtnActLitho.text:=FloatToStrF(ScrollBarLitho.Max/10,fffixed,6,0);
       //   ScrollBarLitho.position:=round(StrToFloat(BitBtnActLitho.text)*10);
         if StrToFloat(BitBtnActLitho.text)*10<ScrollBarLitho.Min then
             BitBtnActLitho.text:=FloatToStrF(ScrollBarLitho.Min/10,fffixed,6,0);
          ScrollBarLitho.position:=round(StrToFloat(BitBtnActLitho.text)*10);
        end;
                 end;   except
    on EConvertError do
     begin siLangLinked1.MessageDlg(scan32(* 'error input' *) ,mtWarning,[mbOk],0); BitBtnActLitho.text:='100';end;
   end;
  end;
end;

procedure TScanWnd.BitBtnTimeActChange(Sender: TObject);
begin
  if BitBtnTimeAct.text='' then  exit
  else
  begin
   try
    if StrToFloat(BitBtnTimeAct.text)>ScrollBarTime.Max then
                      BitBtnTimeAct.text:=FloatToStrF(ScrollBarTime.Max,fffixed,5,0);
      ScrollBarTime.position:=StrToint(BitBtntimeAct.text);
               LithoParams.TimeAct:=ScrollBarTime.position;
      //    SetCommonUserVar(ch_TimeAction,LithoParams.TimeAct);  //aTimeLithoZ=$92;      ->$98
     except
    on EConvertError do
     begin siLangLinked1.MessageDlg(scan32(* 'error input' *) ,mtWarning,[mbOk],0); BitBtnTimeAct.text:='1';end;
   end;
  end;
end;

procedure TScanWnd.BitBtnX0Y0Click(Sender: TObject);
begin
 BitBtnX0Y0.Enabled:=False;
 SetScanParameters;        //problem R:=R_S cannot set step < discr imagescan area!!!
 fX0Y0Change:= TfX0Y0Change.Create(ScanWnd);
 fX0Y0Change.Show;
end;

procedure TScanWnd.SpeedBtnPlDelClick(Sender: TObject);
begin
 ScanParams.flgTopoCurLinePlDel:=not ScanParams.flgTopoCurLinePlDel;
end;

procedure TScanWnd.RStartBtnClick(Sender: TObject);
begin
  FlgReStart:=true;
  if  not FlgStopScan then //Stop    Scanning
   begin
   if assigned(ApproachOpt) then
    begin
     ApproachOpt.ScanCorSheet.enabled:=true;
     ApproachOpt.HardWareSheet.enabled:=true;
     ApproachOpt.TabSheetSetScan.enabled:=true;
    end;
       StartBtn.Enabled:=False;
     if assigned(Nanoedu.Method) then
     begin
       flgStopJava:=true;
       Nanoedu.Method.StopWork
     end;
    //   NanoEdu.Method.WaitStopWork;
       flgStopMulti:=true;
      //  if ScanParams.ScanPath=Multi then  MultiPassThreadDone;
   end
end;

procedure TScanWnd.PageCtlRightChanging(Sender: TObject; var AllowChange: Boolean);
var  HlpCntext:integer;
begin
  AllowChange:=true;
    if FlgBlickApply then
          begin
           siLangLinked1.MessageDLG(scan25(* 'You have changed ScanParameters. Press Apply button, before to choose new regime ' *) , mtwarning,[mbOK],0);
           AllowChange:=false;
           exit
          end;
 (*     if not flgScanDone  then
         begin
             if STMFlg then HlpCntext:=IDH_Spectroscopy_STM else  HlpCntext:=IDH_Spectroscopy;
             MessageDlg(siLangLinked1.GetTextOrDefault('IDS_113' (* 'Make Scanning before Spectroscopy!!'  ), mtInformation,[mbOk,mbHelp],HlpCntext);
             AllowChange:=false;
        end;
 *)       
end;

procedure TScanWnd.PageCtrlAddChange(Sender: TObject);
var i:integer;
begin
 SeriesLine.Active:= (PageCtrlAdd.ActivePage=TabSheetCurScan);
 SeriesAddLine.Active:=not  (PageCtrlAdd.ActivePage=TabSheetCurScan);
 SpeedBtnPlDel.Visible:=(PageCtrlAdd.ActivePage.PageIndex=0);
  with PageCtrlAdd do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
if assigned(CurrentLineWnd) then
 begin
    CurrentLineWnd.SeriesLine.Active:= (PageCtrlAdd.ActivePage=TabSheetCurScan);
    CurrentLineWnd.SeriesAddLine.Active:=not  (PageCtrlAdd.ActivePage=TabSheetCurScan);
    if CurrentLineWnd.SeriesAddLine.Active then
    begin
     CurrentLineWnd.ChartCurrentLine.LeftAxis.SetMinMax(tminph,tmaxph);
     CurrentLineWnd.Caption:=siLangLinked1.GetTextOrDefault('IDS_249' (* 'Current Line ' *) )+TabSheetCurLineAdd.Caption ;
    end
    else
    begin
     CurrentLineWnd.Caption:=siLangLinked1.GetTextOrDefault('IDS_249' (* 'Current Line ' *) )+TabSheetCurScan.Caption;
     CurrentLineWnd.ChartCurrentLine.LeftAxis.SetMinMax(tmin,tmax);
    end;
 end;
end;

procedure TScanWnd.TabSheetCurScanShow(Sender: TObject);
begin
    SeriesLine.Active:= true;
    SeriesAddLine.Active:=false;
    ChartCurrentLine.LeftAxis.SetMinMax(tMin,tMax);
end;

procedure TScanWnd.TabSheetCurLineAddShow(Sender: TObject);
begin
    SeriesAddLine.Active:=true;
    SeriesLine.Active:= false;
    ChartCurrentLine.LeftAxis.SetMinMax(tminph,tmaxph);
end;

procedure TScanWnd.ComboBoxIZSelect(Sender: TObject);
begin
    case ComboBoxIZ.ItemIndex of
    0: SpectrParams.flgIZ:=false;
    1: SpectrParams.flgIZ:=true;
    2: SpectrParams.flgIZ:=false;  //101210
      end;
end;

procedure TScanWnd.EdXKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_DELETE) or (Key=VK_BACK) then flgchange:=true;
end;

procedure TScanWnd.EdYKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
    if (key=VK_DELETE) or (Key=VK_BACK) then flgchange:=true;
end;

procedure TScanWnd.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
if (ssAlt in Shift) then
begin
  flgDragForm:=true;
end;
end;

procedure  TScanWnd.FieldMouseDown(Chart:TChart; Sender: TObject; Button:TMouseButton; X,Y:integer);
var CurrPoint:TPoint;
     n,n1,n2:integer;
begin
 ChScaleX:= Chart.ChartWidth/ScanParams.NX;
 ChScaleY:= Chart.ChartHeight/ScanParams.NY;
 ChRect:=Chart.ChartRect;
if not ScanParams.flgSpectr then
 begin
 X0ch:=X;
 Y0ch:=Y;
 ZBegin:=True;
 CurrPoint:=point(X,Y);
 if FlgStopScan then
  if PointInside(CurrPoint,ChRect) then
    begin
      X:=round((X-ChRect.Left)/ChScaleX);//round(X*DelImg2);
      Y:=round((Y-Chrect.Top)/ChscaleY);
      mX0:=X;
      mY0:=Y;
    if (Sender is TChart)then
      with TChart(Sender) do
       begin
        with  BackImage.BitMap do
        begin
         Canvas.Pen.Style:= psSolid;
         Canvas.Brush.Style:= bsSolid;
         n1:=scanparams.nx div BackImage.width ;
         n2:=scanparams.ny div BackImage.height ;
         N:=max(n1,n2) ;
        if (scanparams.nx<BackImage.width) and (scanparams.ny<BackImage.height)
                               then Canvas.Pen.Width:=1
                               else Canvas.Pen.Width:=1;//N+1;
         Canvas.Pen.Color:=clBlack;
         Canvas.Pen.Mode:=pmNOTXOR;
        if flgTopRDraw then
         begin
          Canvas.Polyline([Point(R_S.Left,R_S.Bottom),Point(R_S.Left,R_S.Top),
          Point(R_S.Right,R_S.Top),Point(R_S.Right,R_S.Bottom),Point(R_S.Left,R_S.Bottom)])
         end;
       end;
      end;
      R_S.TopLeft:=Point(X,Y);
      R_S.BottomRight:=Point(X,Y);
      flgMouseDown:=True;
      DelImg2nm:=ScanParams.X/ScanParams.Nx;
    end;
  end
  else
   begin
      xm:=X;
      ym:=Y;
      X:=round((X-ChRect.Left)/ChScaleX);
      Y:=round((Y-Chrect.Top)/ChscaleY);
      mx0:=x;
      my0:=y;
   end;
end;  {FieldMouseDown}

procedure   TScanWnd.FieldMouseMove(Chart:TChart; Sender: TObject;  X,Y:integer);
begin

    begin
     flgTopRDraw:=True;
      X:=round((X-ChRect.Left)/ChScaleX);//round(X*DelImg2);
      Y:=round((Y-Chrect.Top)/ChscaleY);
    if (Sender is TChart{Image})then
      with TChart(Sender) do
         begin
          Backimage.BitMap.Canvas.Polyline([Point(R_S.Left,R_S.Bottom),Point(R_S.Left,R_S.Top),
          Point(R_S.Right,R_S.Top),Point(R_S.Right,R_S.Bottom),Point(R_S.Left,R_S.Bottom)]);
         end;
       if (MX0<X)  then begin R_S.Left:=MX0; R_S.Right:=X;   end
                   else begin R_S.Left:=X;   R_S.Right:=MX0; end;
       if (MY0<Y)
         then
          begin
            R_S.Top:=MY0;
            if ScanParams.FlgSQ then
             begin
              if (MX0>X) then
               begin
                R_S.Bottom:=MY0-(X-MX0);
              if R_S.Bottom>scanparams.ny{TImage(Sender).Height} then begin   R_S.Bottom:=scanparams.ny;{TImage(Sender).Height;} R_S.Left:=R_S.Right-(R_S.Bottom-R_S.top) end
               end
              else
               begin
                R_S.Bottom:=MY0+(X-MX0);
                if R_S.Bottom>scanparams.ny{TImage(Sender).Height} then begin   R_S.Bottom:=scanparams.ny{TImage(Sender).Height}; R_S.Right:=R_S.left+(R_S.Bottom-R_S.top) end
               end
              end
              else R_S.Bottom:=Y; //FlgSQ=false
          end
         else       //Y0>y
          begin
             R_S.Bottom:=MY0;
             if ScanParams.FlgSQ then
               begin
                if (MX0<X) then
                      begin
                        R_S.Top:=MY0-(X-MX0); if R_S.Top<0 then begin R_S.Top:=0; R_S.Right:=R_S.left+(R_S.Bottom-R_S.Top);end
                      end
                     else
                      begin
                        R_S.Top:=MY0+(X-MX0); if R_S.Top<0 then begin R_S.Top:=0; R_S.Left:=R_S.Right-(R_S.Bottom-R_S.Top);end
                      end
                end
                     else R_S.Top:=Y;   //flgSq:=False
          end;
    if (Sender is TChart)then
    with TChart(Sender) do
     begin
          BackImage.BitMap.Canvas.Polyline([Point(R_S.Left,R_S.Bottom),Point(R_S.Left,R_S.Top),
          Point(R_S.Right,R_S.Top),Point(R_S.Right,R_S.Bottom),Point(R_S.Left,R_S.Bottom)]);
     end;
 end;
end;{FieldMouseMove}

procedure TScanWnd.BtnZoomClick(Sender: TObject);
var FieldZoomResult:integer;
begin
  FlgFieldZoom:=True;
  BtnZoom.enabled:=false;
 if FlgBlickApply then    ApplyBtnClick(self);
 FieldZoom:=TFieldZoom.Create(Application, ScanAreaBitMapTemp);
 FieldZoomResult:= FieldZoom.ShowModal;
 if FieldZoomResult<>mrCancel then  ApplyBtnClick(self);
 BtnZoom.enabled:=true;
end;

procedure TScanWnd.SpeedBtnDelTopClick(Sender: TObject);
begin
 ScanParams.flgTopoTopViewPlDel:=not ScanParams.flgTopoTopViewPlDel;
 ScanParams.flgTopoTopViewSDel:=false;
 SpeedBtnDelTopL.Down:=ScanParams.flgTopoTopViewPlDel;
end;


procedure TScanWnd.SpeedBtnSDelTopLClick(Sender: TObject);
begin
 ScanParams.flgTopoTopViewSDel:=not ScanParams.flgTopoTopViewSDel;
 ScanParams.flgTopoTopViewPlDel:=false;
 SpeedBtnSDelTop.Down:=ScanParams.flgTopoTopViewSDel;
end;

procedure TScanWnd.SpdBtnOneFrameClick(Sender: TObject);
begin
  Scanparams.flgOneFrame:= not   Scanparams.flgOneFrame;
   case  ScanParams.flgOneFrame of
true: begin  SpdBtnOneFrame.Caption:='1'; SpdBtnRecord.visible:=false; end;
false: begin SpdBtnOneFrame.Caption:='V'; SpdBtnRecord.visible:=true; end;
             end;
end;

procedure TScanWnd.SpeedBtnContrastClick(Sender: TObject);
begin
  flgContrastTopView:= SpeedBtnContrast.down;
//  flgContrastTopView:=false;
 if not assigned(frContrast)then frContrast:=TfrContrast.Create(self)
                            else frContrast.SetFocus;
end;

procedure TScanWnd.SpeedBtnContrLClick(Sender: TObject);
begin
   flgContrastTopView:= SpeedBtnContrast.down;
//  flgContrastTopView:=false;
 if not assigned(frContrast)then frContrast:=TfrContrast.Create(self)
                            else frContrast.SetFocus;

end;

procedure TScanWnd.SpeedBtnPalClick(Sender: TObject);
begin
    if not assigned(PaletteForm) then
  begin
    PaletteForm:=TPaletteForm.Create(Self);
  end
  else PaletteForm.SetFocus;
end;

procedure TScanWnd.SpeedBtnDelTopLClick(Sender: TObject);
begin
 ScanParams.flgTopoTopViewPlDel:=not ScanParams.flgTopoTopViewPlDel;
 SpeedBtnDelTop.Down:=ScanParams.flgTopoTopViewPlDel;
 ScanParams.flgTopoTopViewSDel:=false;
end;

procedure TScanWnd.SpeedBtnSDelTopClick(Sender: TObject);
begin
 ScanParams.flgTopoTopViewSDel:=not ScanParams.flgTopoTopViewSDel;
 ScanParams.flgTopoTopViewPlDel:=false;
 SpeedBtnSDelTopL.Down:=ScanParams.flgTopoTopViewSDel;

end;

procedure TScanWnd.ChartCurrentLineDblClick(Sender: TObject);
begin
    if not assigned(CurrentLineWnd) then CurrentLineWnd:=TCurrentLineWnd.Create(self)
                                    else CurrentLineWnd.SetFocus;

end;

procedure TScanWnd.BitBtnZoomCurLineClick(Sender: TObject);
begin
    BitBtnZoomCurLine.enabled:=false;
    SeriesLine.Clear;
    SeriesAddLine.Clear;
   if not assigned(CurrentLineWnd) then CurrentLineWnd:=TCurrentLineWnd.Create(self)
                                    else CurrentLineWnd.SetFocus;
    BitBtnZoomCurLine.enabled:=true;
end;

procedure TScanWnd.RadioGroupBWClick(Sender: TObject);
begin
    flgblw:=(RadioGroupBW.Itemindex=0);
    if flgblw then  LithoParams.ScaleAct:=0
      else
       if LithoParams.V>0
        then  LithoParams.ScaleAct:= (LithoParams.VMax- LithoParams.V)/255
        else  LithoParams.ScaleAct:= (LithoParams.VMin- LithoParams.V)/255;
    BLW_GRAYConvert;
    FlgProjection:=false;
end;

procedure TScanWnd.RadioTypeLithoClick(Sender: TObject);
var value,t:single;
begin
        case RadioTypeLitho.itemindex of
    0: begin   //Force
        Scanparams.ScanMethod:=Litho;
        DemoSampleLitho:='sfm\litho';
        BitBtnActLitho.Font.color:=clRed;
        LithoTransform:=TransformUnit.Znm_d ;
        Label18.caption:=siLangLinked1.GetTextOrDefault('IDS_51' (* 'mcs' *) );
        LabelAction.Caption:=siLangLinked1.GetTextOrDefault('IDS_40' (* 'Action nm' *) );
      {$IFDEF FULL}
            SignalsMode.tbSFMCUR.TabVisible:=true;
            SignalsMode.tbSFM.TabVisible:=false;
        {$ENDIF}

         with ScrollBarLitho do
                 begin
                   Min:=0;
                   Max:=round((MaxApiType div 2)/TransformUnit.Znm_d/100)*100 ;  //071116 4-> 2
                   SmallChange:=50;
                   LargeChange:=50;
                   LithoParams.ScaleAct:=0.5;//5;
                   Position:=100;//round(255*LithoParams.ScaleAct);
                   if Position>Max then Position:=Max;
                   if Position<Min then Position:=Min;
                   Visible:=True;
                   Value:=Position;
                 end;
           LithoParams.TimeAct:=100;
            with ScrollBarTime do
                 begin
                  Max:=5000;
                  Min:=0;
                  Position:=LithoParams.TimeAct;
                  SmallChange:=20;
                  LargeChange:=20;
                 end;
           BitBtnTimeAct.text:=Format('%d',[round(LithoParams.TimeAct/ScrollBarTime.LargeChange)*ScrollBarTime.LargeChange]);
           TimeActScale:=1e-6;
       end;
    1: begin     //Current
        Label18.caption:=siLangLinked1.GetTextOrDefault('IDS_54' (* 'ms' *) );
        BitBtnActLitho.Font.color:=clRed;
        Nanoedu.Bias:=0;
        Scanparams.ScanMethod:=LithoCurrent;
        DemoSampleLitho:='sfm\lithoanode';
        LithoTransform:=TransformUnit.BiasV_d ;
        Scanparams.ScanMethod:=LithoCurrent;
          {$IFDEF FULL}
            SignalsMode.tbSFM.TabVisible:=true;
            SignalsMode.tbSFMCUR.TabVisible:=false;
          {$ENDIF}
        LabelAction.Caption:=siLangLinked1.GetTextOrDefault('IDS_41' (* 'Action V' *) );
           with ScrollBarLitho do
                 begin
                   Min:=Round(apitype($8000)/TransformUnit.BiasV_d)*10;
                   Max:=Round($7FFF/TransformUnit.BiasV_d)*10;
                   SmallChange:=1;
                   LargeChange:=1;
                   LithoParams.ScaleAct:=0;
                   Position:=0;//round(255*LithoParams.ScaleAct);
                   if Position>Max then Position:=Max;
                   if Position<Min then Position:=Min;
                    Visible:=True;
                    Value:=Position;///LithoTransform;
                 end;
               LithoParams.V:=Round(value*LithoTransform);
               LithoParams.TimeAct:=250;
               with ScrollBarTime do
                 begin
                  Max:=500;
                  Min:=0;
                  Position:=LithoParams.TimeAct;
                  SmallChange:=10;
                  LargeChange:=10;
                 end;
              BitBtnTimeAct.text:=Format('%d',[round(LithoParams.TimeAct/ScrollBarTime.LargeChange)*ScrollBarTime.LargeChange]);
              TimeActScale:=1e-3;
       end;
              end;       //case

       if FlgCurrentUserLevel=Demo then          { TODO : 14/03/06 }
        begin
          DemoInfoStructResult:=CreateDemoLithoInfoStruct;
       end;
         with   Scanparams do
             begin
                 case ScanPath of
          OneX:       t:=ceil(X*Ny/ScanRate+X*Ny/ScanRateBW+CurrentLithoTimeEtch(Nx,NY));
          OneY:       t:=ceil(Y*Nx/ScanRate+Y*Nx/ScanRateBW+CurrentLithoTimeEtch(Nx,NY));
                  end;
               if FlgUnit=terra then  t:=t+0.001*(2*0.001*ScanParams.TimMeasurePoint+ScanParams.TerraTDelay)*NX*NY;
             end;
             if (t<10)  then FrameTime.Caption:=FloatToStrF(t,ffFixed,7,1)
                 else FrameTime.Caption:=FloatToStrF(t,ffFixed,7,0);

     BitBtnActLitho.Font.Color:=clRed;
     Flgprojection:=false;
//     BitBtnActLitho.Text:=FloatToStrF(round(Value/ScrollBarLitho.LargeChange)*ScrollBarLitho.LargeChange,fffixed,5,0);
end;

procedure TScanWnd.SpeedBtnCaptureClick(Sender: TObject);

procedure CommentPrepare;
var j:integer;
begin
    with ScanData.FileHeadRcd do
       begin
        HMaterial:=strcomment[0];
                 for j := 1 to 7 do  Comments[j]:=strcomment[j];
(* Comm1:=strcomment[1];
        Comm2:=strcomment[2];
        Comm3:=strcomment[3];
        Comm4:=strcomment[4];
        Comm5:=strcomment[5];*)
       end;
end;
procedure DataCapture(flg:boolean;addstr:string ;var Data:TExperiment);
var i,j:integer;
    ScanDataCapture:TExperiment;
begin
      ScanDataCapture:=TExperiment.Create;
  try
       case ScanParams.ScanPath of
Multi,OneX: begin
          ScanDataCapture.AquiTopo.Nx:=ScanParams.ScanPoints;
          ScanDataCapture.AquiTopo.Ny:=ScanParams.CurrentScanCount;
         if flgRenishawUnit then
         begin
           ScanDataCapture.AquiRenishaw.Nx:= ScanParams.ScanPoints+1;
           ScanDataCapture.AquiRenishaw.Ny:= ScanParams.CurrentScanCount;
         end;
         end;
MultiY,OneY:begin
          ScanDataCapture.AquiTopo.Nx:=ScanParams.CurrentScanCount;
          ScanDataCapture.AquiTopo.Ny:=ScanParams.ScanPoints;
         if flgRenishawUnit then
         begin
           ScanDataCapture.AquiRenishaw.Nx:= ScanParams.CurrentScanCount;
           ScanDataCapture.AquiRenishaw.Ny:= ScanParams.ScanPoints+1;
         end;
        end;
          end;

     ScanDataCapture.AquiTopo.XStep:=Data.AquiTopo.XStep;
     SetLength(ScanDataCapture.AquiTopo.Data,ScanDataCapture.AquiTopo.Nx,ScanDataCapture.AquiTopo.Ny);   //23.11.01   x->y
      try
        for i:=0 to ScanDataCapture.AquiTopo.Nx-1 do
        for j:=0 to ScanDataCapture.AquiTopo.Ny-1 do
        ScanDataCapture.AquiTopo.Data[i,j]:=Data.AquiTopo.Data[i,j];
      except
              on EOutOfMemory        do
              siLangLinked1.MessageDlg(scan38(* 'OUT memory TopoSPM' *),mtWarning,[mbOk],0);
      end;

  if ScanParams.flgAquiAdd or (ScanParams.ScanMethod=FastScan) or (ScanParams.ScanMethod=FastScanPhase)  then
      begin
        ScanDataCapture.AquiAdd.Nx:=ScanDataCapture.AquiTopo.Nx;
        ScanDataCapture.AquiAdd.Ny:= ScanDataCapture.AquiTopo.Ny;
        ScanDataCapture.AquiAdd.XStep:=ScanData.AquiTopo.XStep;
        SetLength(ScanDataCapture.AquiAdd.Data,ScanDataCapture.AquiTopo.Nx,ScanDataCapture.AquiTopo.Ny);
      for i:=0 to ScanDataCapture.AquiTopo.Nx-1 do
       try
        for j:=0 to ScanDataCapture.AquiTopo.Ny-1 do
        ScanDataCapture.AquiAdd.Data[i,j]:=Data.AquiAdd.Data[i,j];
       except
              on EOutOfMemory        do
             siLangLinked1.MessageDlg(Scan27 (* 'OUT memory TopoSPM' *),mtWarning,[mbOk],0);

       end;
      end;
 if flgRenishawUnit then
 begin
      SetLength(ScanDataCapture.AquiRenishaw.Data,ScanDataCapture.AquiRenishaw.Nx,ScanDataCapture.AquiRenishaw.Ny);
      for i:=0 to ScanDataCapture.AquiRenishaw.Nx-1 do
       try
        for j:=0 to ScanDataCapture.AquiRenishaw.Ny-1 do
        ScanDataCapture.AquiRenishaw.Data[i,j]:=Data.AquiRenishaw.Data[i,j];
       except
              on EOutOfMemory        do
             siLangLinked1.MessageDlg(Scan27 (* 'OUT memory TopoSPM' *),mtWarning,[mbOk],0);
       end;

 end;
        ScanDataCapture.FileHeadRcd:=Data.FileHeadRcd;
       if ScanParams.flgTopoLevelDel then  ScanDataCapture.PrepareSaveData;
        ScanDataCapture.WorkFileName:=TempDirectory+'ScanDataCapture'+ScandataWorkFileNameEm(countcapture)+addstr+'.spm';
        ScanDataCapture.HeaderPrepare;
        ScanDataCapture.FileHeadRcd.SecondPass:=flg;
        ScanDataCapture.SaveExperiment;
        Finalize(ScanDataCapture.AquiTopo.Data);
       if flgRenishawUnit       then  Finalize(ScanDataCapture.AquiRenishaw.Data);
       if ScanParams.flgAquiAdd then  Finalize(ScanDataCapture.AquiAdd.Data);
        Main.CreateMDIChild(Sender, ScanDataCapture.WorkFileName,FlgViewDef,false,FlgRenishawCorrection);
  finally
    FreeAndNil(ScanDataCapture);
  end;
end;
begin
  { TODO : 140606 }
// if ScanParams.CurrentScanCount>4 then
// begin
   //FIRST PASS
  inc(countcapture);
  if (ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY) then
  begin
    DataCapture(false,'_1',ScanData);
    DataCapture(true,'_2',ScanDataSecondPass);
  end
  else  DataCapture(false,'',ScanData);
// end;
end;

procedure TScanWnd.ScrollBarLithoChange(Sender: TObject);
var value:apitype;
begin
         case RadioTypeLitho.itemindex of
    0: begin   //Force
        Value:=round(ScrollBarLitho.Position*LithoTransform);    //discret
        BitBtnActLitho.text:=FloatToStrF(ScrollBarLitho.Position,fffixed,5,0);  //nm
        LithoParams.ScaleAct:=Value/255;
       end;
    1: begin   //Current
        Value:=round(ScrollBarLitho.Position*LithoTransform/10);    //discret
        BitBtnActLitho.text:=FloatToStrF(ScrollBarLitho.Position/10,fffixed,5,1);  //nm
        LithoParams.V:=value;
      if flgblw then  LithoParams.ScaleAct:=0
      else
       if value>=0
        then  LithoParams.ScaleAct:= (LithoParams.VMax- LithoParams.V)/255
        else  LithoParams.ScaleAct:= (LithoParams.VMin- LithoParams.V)/255
       end;
           end;
end;


procedure TScanWnd.UpDownActClick(Sender: TObject; Button: TUDBtnType);
var value:single;
begin
   if (Button = btNext) then
    begin
       case  UpDownACT.position of
    2:begin
       ScrollBarLitho.position:=ScrollBarLitho.position*2;
       LithoParams.Amplifier:=2;
      end;
    3:begin
       LithoParams.Amplifier:=4;
       ScrollBarLitho.position:=ScrollBarLitho.position*2;
      end;
        end;
    end
    else
    begin
         case  UpDownAct.position of
    1:begin
        LithoParams.Amplifier:=1;
       ScrollBarLitho.position:=round(ScrollBarLitho.position/2);
      end;
    2:begin
       LithoParams.Amplifier:=2;
       ScrollBarLitho.position:=round(ScrollBarLitho.position/2);
      end;
        end;
    end;
   SetCommonUserVar(ch_Amplifier,LithoParams.Amplifier);  //aAmplLitho=$96;   ? $9C 110210
end;

procedure TScanWnd.UpDownLithostepClick(Sender: TObject; Button: TUDBtnType);
begin
  if (Button = btNext) then
    begin
     edStepXYM.Text:=floattostrf((strtofloat(edStepXYM.Text)+ReniShawParams.Period_nm),fffixed,10,0);
    end
    else
    begin
      edStepXYM.Text:=floattostrf((strtofloat(edStepXYM.Text)-ReniShawParams.Period_nm),fffixed,10,0);
    end;
end;

procedure TScanWnd.ComboBoxFilterChange(Sender: TObject);
begin
  ScanParams.flgFilter:=ComboBoxFilter.ItemIndex;
end;

procedure TScanWnd.UpActClick(Sender: TObject);
begin
   (*    inc(UpDownACT_position);
       case  UpDownACT_position of
    2:begin
       if  ScrollBarLitho.position*2<=ScrollBarLitho.Max then
        begin
         ScrollBarLitho.position:=ScrollBarLitho.position*2;
         LithoParams.Amplifier:=2;
         DownAct.Visible:=true;
         if Assigned(Nanoedu.Method) then Nanoedu.Method.SetUsersParams;
// SetCommonUserVar(ch_Amplifier,LithoParams.Amplifier); //aAmplLitho=$96;     ->$9C
        end
        else dec(UpDownACT_position); ;
      end;
    3:begin
      if  ScrollBarLitho.position*2<=ScrollBarLitho.Max then
        begin
         LithoParams.Amplifier:=4;
         ScrollBarLitho.position:=ScrollBarLitho.position*2;
         UpAct.Visible:=false;
       if Assigned(Nanoedu.Method) then Nanoedu.Method.SetUsersParams;
//   SetCommonUserVar(ch_Amplifier,LithoParams.Amplifier);  //aAmplLitho=$96;   ->$9C
        end else dec(UpDownACT_position);
      end;
            end; *)
     if  ScrollBarLitho.position*2<=ScrollBarLitho.Max then
        begin
           inc(LithoAmplifierPow);
           LithoParams.Amplifier:=round(math.Power(2,abs(LithoAmplifierPow)));
           if LithoAmplifierPow < 0 then LithoParams.Amplifier:=-LithoParams.Amplifier;
           ScrollBarLitho.position:=ScrollBarLitho.position*2;
           if Assigned(Nanoedu.Method) then Nanoedu.Method.SetUsersParams;
        end;
end;

procedure TScanWnd.UpdateStrings;
begin
  errorscan := siLangLinked1.GetTextOrDefault('strerrorscan' (* 'Scannning error!' *) );
  scan40 := siLangLinked1.GetTextOrDefault('strscan40');
  scan39 := siLangLinked1.GetTextOrDefault('strscan39');
  strsdrw4 := siLangLinked1.GetTextOrDefault('strstrsdrw4');
  strsdrw3 := siLangLinked1.GetTextOrDefault('strstrsdrw3');
  strsdrw2 := siLangLinked1.GetTextOrDefault('strstrsdrw2');
  strsdrw := siLangLinked1.GetTextOrDefault('strstrsdrw');
  scan38 := siLangLinked1.GetTextOrDefault('strscan38');
  scan37 := siLangLinked1.GetTextOrDefault('strscan37');
  scan36 := siLangLinked1.GetTextOrDefault('strscan36');
  scan35 := siLangLinked1.GetTextOrDefault('strscan35');
  scan34 := siLangLinked1.GetTextOrDefault('strscan34');
  scan33 := siLangLinked1.GetTextOrDefault('strscan33');
  scan32 := siLangLinked1.GetTextOrDefault('strscan32');
  scan31 := siLangLinked1.GetTextOrDefault('strscan31');
  scan30 := siLangLinked1.GetTextOrDefault('strscan30');
  scan29 := siLangLinked1.GetTextOrDefault('strscan29');
  scan28 := siLangLinked1.GetTextOrDefault('strscan28');
  scan27 := siLangLinked1.GetTextOrDefault('strscan27');
  scan26 := siLangLinked1.GetTextOrDefault('strscan26');
  scan25 := siLangLinked1.GetTextOrDefault('strscan25');
  scan24 := siLangLinked1.GetTextOrDefault('strscan24');
  scan23 := siLangLinked1.GetTextOrDefault('strscan23');
  scan22 := siLangLinked1.GetTextOrDefault('strscan22');
  scan21 := siLangLinked1.GetTextOrDefault('strscan21');
  scan20 := siLangLinked1.GetTextOrDefault('strscan20');
  scan19 := siLangLinked1.GetTextOrDefault('strscan19');
  scan18 := siLangLinked1.GetTextOrDefault('strscan18');
  scan17 := siLangLinked1.GetTextOrDefault('strscan17');
  scan16 := siLangLinked1.GetTextOrDefault('strscan16');
  scan15 := siLangLinked1.GetTextOrDefault('strscan15');
  scan14 := siLangLinked1.GetTextOrDefault('strscan14');
  scan13 := siLangLinked1.GetTextOrDefault('strscan13');
  scan12 := siLangLinked1.GetTextOrDefault('strscan12');
  scan11 := siLangLinked1.GetTextOrDefault('strscan11');
  scan10 := siLangLinked1.GetTextOrDefault('strscan10');
  scan9 := siLangLinked1.GetTextOrDefault('strscan9');
  scan8 := siLangLinked1.GetTextOrDefault('strscan8');
  scan7 := siLangLinked1.GetTextOrDefault('strscan7');
  scan6 := siLangLinked1.GetTextOrDefault('strscan6');
  scan5 := siLangLinked1.GetTextOrDefault('strscan5');
  scan4 := siLangLinked1.GetTextOrDefault('strscan4');
  scan3 := siLangLinked1.GetTextOrDefault('strscan3');
  scan2 := siLangLinked1.GetTextOrDefault('strscan2');
  scan1 := siLangLinked1.GetTextOrDefault('strscan1');
  strStop := siLangLinked1.GetTextOrDefault('strstrStop');
  strReRun := siLangLinked1.GetTextOrDefault('strstrReRun');
  strRun := siLangLinked1.GetTextOrDefault('strstrRun');
  strtime:= siLangLinked1.GetTextOrDefault('strstrtime');
end;

procedure TScanWnd.DownActClick(Sender: TObject);
begin
  (* dec(UpDownACT_position);
         case  UpDownAct_position of
    1:begin
        LithoParams.Amplifier:=1;
       ScrollBarLitho.position:=round(ScrollBarLitho.position/2);
       UpAct.Visible:=true;
   //    DownAct.Visible:=false;     28.02.12
      end;
    2:begin
       LithoParams.Amplifier:=2;
       UpAct.Visible:=true;
       DownAct.Visible:=true;
       ScrollBarLitho.position:=round(ScrollBarLitho.position/2);
      end;
        end;  *)
    dec(LithoAmplifierPow);
    LithoParams.Amplifier:=round(math.Power(2,abs(LithoAmplifierPow)));
    if LithoAmplifierPow < 0 then LithoParams.Amplifier:=-LithoParams.Amplifier;

    ScrollBarLitho.position:=round(ScrollBarLitho.position/2);
    if Assigned(Nanoedu.Method) then Nanoedu.Method.SetUsersParams;
 //  SetCommonUserVar(ch_Amplifier,LithoParams.Amplifier);  //aAmplLitho=$96; ->$9C
end;
function TScanWnd.FillStructure(const FName:string;PageNmb:integer):integer;
var    flg:integer;
  DemoInf:RDemoDataInfo;
begin
  Result:=0;
    if FileExists(FName) then
          begin
          ReadHeader(FName,flg,head,mainrc);
          with DemoInf do
            begin
              ScanRegimeIdent:=flg;//Topography;
              DataExists:=True;
              NX:=head.HNxTopo;
              NY:=head.HNyTopo;
              XLengthNM:=head.HNxTopo*Head.HStepXY;
              YLengthNM:=head.HNyTopo*Head.HStepXY;
              fSensX:=head.HSensX;       // for Demo 2013
              fSensY:=head.HSensY;       // for Demo 2013
              fsensZ:=head.HSensZ;       // for Demo 2013
//       18/01/14
//   (CSPMSignals[13].MaxDiscr-CSPMSignals[13].MinDiscr)/(CSPMSignals[13].MaxV-CSPMSignals[13].MinV);
           if Head.HAmplV_d=0 then
              begin
                fAmplV_d:=$3FF8/5;   //
              end
              else  fAmplV_d:= Head.HAmplV_d;
           if Head.HBiasV_d=0 then
              begin
                fBiasV_d:=$3FF8/5;
              end
              else  fBiasV_d:= Head.HBiasV_d;
           if Head.HnA_D=0 then
              begin
                fnA_d:=480*$7FFF/10000;
              end
              else  fnA_d:= Head.HnA_D;;

              if Head.HYnm_d=0 then
              begin
               fYnm_d:=$7FFF/(10*25*fsensY)
              end
              else  fYnm_d:=Head.HYnm_d;

              if Head.HXnm_d=0 then
              begin
               fXnm_d:=$7FFF/(10*25*fsensX)
              end
              else  fXnm_d:=Head.HXnm_d;

            if mainrc.version>=16 then fZnm_d:=1000/(fsensZ*Head.HDiscrZmvolt)
                                  else fZnm_d:=1000/(fsensZ*25*Head.HDiscrZmvolt)

           end;

            DemoDataInfoArray[PageNmb]:=DemoInf;
          end
     else
     begin
     Result:=-1;
      with DemoInf do
            begin
              ScanRegimeIdent:=flg;//Topography;
              DataExists:=False;
              NX:=ScanParams.Nx;
              NY:=ScanParams.Ny;
              XLengthNM:=ScanParams.X;
              YLengthNM:=ScanParams.Y;
              fSensX:=ScannerCorrect.SensitivX;       // for Demo 2013
              fSensY:=ScannerCorrect.SensitivY;       // for Demo 2013
              fsensZ:=ScannerCorrect.SensitivZ;
              fAmplV_d:=TransformUnit.AmplV_d;
              fBiasV_d:=TransformUnit.BiasV_d;
              fnA_d:=TransformUnit.nA_d;
              fZnm_d:=TransformUnit.Znm_d;
              fXnm_d:=TransformUnit.Xnm_d;
              fYnm_d:=TransformUnit.Ynm_d;
            end;
            DemoDataInfoArray[PageNmb]:=DemoInf;
     end;
end;
function TScanWnd.CreateDemoInfoStruct:integer;
var Ident:integer;
    FileName:string;
////////
begin
  SetLength(DemoDataInfoArray, PageCtlRight.PageCount);
//  if (Scanparams.ScanPath=Multi) or  (Scanparams.ScanPath=MultiY) then exit;
  if STMflg then
          begin
           FileName:=DemoDataDirectory+DemoSample+'\'+DemoTopoSTMFile;
           Result:= FillStructure(FileName,0);
           FileName:=DemoDataDirectory+DemoSample+'\'+DemoSpectrSTMIVFile;
           Result:= FillStructure(FileName,3);
           if Result<>0 then
          end;
  if not STMflg then
        begin
         FileName:=DemoDataDirectory+DemoSample+'\'+DemoTopoSFMFile;
         Result:= FillStructure(FileName,0);
         FileName:=DemoDataDirectory+DemoSample+'\'+ DemoPhaseFile;
         Result:= FillStructure(FileName,1);
         FileName:=DemoDataDirectory+ DemoSample+'\'+DemoForceFile;
         Result:= FillStructure(FileName,2);
         FileName:=DemoDataDirectory+ DemoSample+'\'+DemoCurrentFile;
         Result:= FillStructure(FileName,4);
         FileName:=DemoDataDirectory+DemoSample+'\'+DemoTopoSFMFile;
         Result:= FillStructure(FileName,5);
         FileName:=DemoDataDirectory+ DemoSample+'\'+DemoTopoSFMFile;
         Result:= FillStructure(FileName,7);
         DemoSampleLitho:='sfm\litho';
         FileName:=DemoDataDirectory+ DemoSampleLitho+'\'+DemoLithoSFMFile;
         Result:= FillStructure(FileName,6);
         DemoDataInfoArray[6].XLengthNM:= 4*DemoDataInfoArray[6].XLengthNM;
         DemoDataInfoArray[6].YLengthNM:= DemoDataInfoArray[6].XLengthNM;
         FileName:=DemoDataDirectory+DemoSample+'\'+ DemoTopoSFMFile;
         Result:= FillStructure(FileName,3);       //spectr
        end;
end;
function TScanWnd.CreateDemoLithoInfoStruct:integer;
var Ident:integer;
    FileName:string;
begin
 result:=1;
  if not STMflg then
        begin
          FileName:=DemoDataDirectory+ DemoSampleLitho+'\'+DemoLithoSFMFile;
         Result:= FillStructure(FileName,6);
        end;
end;
function TScanWnd.ConfigDemoScanWnd(N:integer):integer;
var i:integer;
begin
result:=0;
 if   (Scanparams.ScanPath=Multi) or  (Scanparams.ScanPath=MultiY)  or (Scanparams.ScanMethod=OneLineScan) then
 begin
  result:=1;
  MessageDlgCtr(scan28 (* 'no Demo Data!!!' *) , mtInformation,[mbOk],0);
  exit;
 end;
 if DemoDataInfoArray<>nil then
  begin
         if not DemoDataInfoArray[N].DataExists then
          begin
           MessageDlgCtr(scan28 (* 'no Demo Data!!!' *) , mtInformation,[mbOk],0);
            result:=1;
           exit;
          end;
   end;
end;

procedure TScanWnd.SetDemoPointsLimit(N:integer);
var
  XT,YT,Size:integer;
begin
 XT:=DemoDataInfoArray[N].Nx;
 YT:=DemoDataInfoArray[N].Ny;
 Size:=min(XT,YT);

if size<ScanParams.Nx then  ScanParams.NX:=Size;
if size<ScanParams.NY then  ScanParams.NY:=Size;

 //ScanParams.ScanPoints:=Size;
// ScanParams.ScanLines:=Size;

 LinePointsMax:=Size;
 edNX.Text:=IntToStr(ScanParams.NX);
 edNY.Text:=IntToStr(ScanParams.NY);
end;


procedure TScanWnd.SetXYMaxDemo(N:integer);
var
  XNM,YNM,SizeNM:single;
  XMaxTmp,YMaxTmp, XMaxTmp1,YMaxTmp1:single;
begin
 with  TransformUnit do
  begin
    AmplV_d:=DemoDataInfoArray[N].fAmplV_d;
    BiasV_d:=DemoDataInfoArray[N].fBiasV_d;
    nA_d:=DemoDataInfoArray[N].fZnm_d;
    Znm_d:=DemoDataInfoArray[N].fZnm_d;
    Ynm_d:=DemoDataInfoArray[N].fYnm_d;
    Xnm_d:=DemoDataInfoArray[N].fXnm_d;
(*    if(Scanparams.ScanPath=OneX) or (Scanparams.ScanPath=Multi)   then
    begin
     XPnm_d:=Xnm_d;   //use sensivity for position x
     YPnm_d:=Ynm_d;   //use sensivity for position y
    end;
    *)
  end;
 XNM:=DemoDataInfoArray[N].XLengthNM;
 YNM:=DemoDataInfoArray[N].YLengthNM;
 SizeNM:=min(XNM,YNM);
 SizeNM:=min( SizeNM,ScanParams.XMax);

if sizeNM<ScanParams.X then  ScanParams.X:=SizeNM;
if sizeNM<ScanParams.Y then  ScanParams.Y:=SizeNM;

 //ScanParams.ScanPoints:=Size;
// ScanParams.ScanLines:=Size;

 ScanParams.XMax:=SizeNM;
 ScanParams.YMax:=SizeNM;

 //ScannerCorrect.SensitivX:=DemoDataInfoArray[N].fSensX;    // for Demo 2013
 //ScannerCorrect.SensitivY:=DemoDataInfoArray[N].fSensY;    // for Demo 2013

// ScannerCorrect.SensitivZ:=DemoDataInfoArray[N].fSensZ;    // for Demo 2013

   if HardWareOpt.XYtune='Fine' then
   begin
   with HardWareOpt do
          begin
            XMaxTmp:= (CSPMSignals[8].MaxV*ScannerOptModY.SensitivX*AMPGainX);
            YMaxTmp:= (CSPMSignals[9].MaxV*ScannerOptModY.SensitivY*AMPGainY);
            XMaxTmp1:= (CSPMSignals[8].MaxV*ScannerOptModX.SensitivX*AMPGainX);
            YMaxTmp1:= (CSPMSignals[9].MaxV*ScannerOptModX.SensitivY*AMPGainY);
          end;

         XMaxTmp:=min(XMaxTmp1,XMaxTmp);
         YMaxTmp:=min(YMaxTmp1,YMaxTmp);
         ScanParams.XMax:=min(XMaxTmp,YMaxTmp);
         ScanParams.YMax:=ScanParams.XMax;
   end;

 edX.Text:=FloatToStrF(floor(ScanParams.X),fffixed,8,0);
 edY.Text:=FloatToStrF(floor(ScanParams.Y),fffixed,8,0);
end;


procedure TScanWnd.LEditDzChange(Sender: TObject);
begin
    if LEditDz.text='' then  exit;
    ScanParams.PassIIDz:=strtoint(LEditDz.text);

end;

procedure TScanWnd.LEditDzKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['-','0'..'9',#8]) then Key :=#0;
end;

procedure TScanWnd.EdScanRateBWChange(Sender: TObject);
 var v:single;
begin
  edScanRateBW.Font.Color:=clRed;
  ApplyBitBtn.Font.Color:=clRed;
  FlgBlickApply:=True;
 try
  if  strtoint(edScanRateBW.Text)=0 then  edScanRateBW.Text:='1';
  v:=strtofloat(edScanRateBW.text);
 except
    on EConvertError do
    begin siLangLinked1.MessageDlg(scan32 (* 'error input' *) ,mtWarning,[mbOk],0); edScanRateBW.text:='1000';end;
 end;
end;

procedure TScanWnd.EdScanRateBWKeyPress(Sender: TObject; var Key: Char);
begin
   if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TScanWnd.UpDownSpeedBWClick(Sender: TObject; Button: TUDBtnType);
begin
  if (Button = btNext) then
    begin
     try
     if strtoint(edScanRateBW.Text)<MaxSpeedValue div 2 then
     edScanRateBW.Text:=format('%d',[2*strtoint(edScanRateBW.Text)])
   except
    on EConvertError do
      edScanRateBW.Text:='1000';
     end;
    end
   else
    begin
       edScanRateBW.Text:=format('%d',[round(0.5*strtoint(edScanRateBW.Text))]);
       if  strtoint(edScanRateBW.Text)=0 then  edScanRateBW.Text:='1';
    end;
end;

procedure TScanWnd.SpdBtnRecordClick(Sender: TObject);
var bmp:Tbitmap;
begin
bmp:=Tbitmap.Create();
    flgRecord:= not FlgRecord;
          case flgRecord of
     true: ImageList2.GetBitmap(8,bmp) ;
     false:ImageList2.GetBitmap(9,bmp) ;
     end;

  SpdBtnRecord.glyph.assign(bmp);
  FreeandNil(BMP);
    application.ProcessMessages;
 //   SpdBTnRecord.Down:=not   SpdBTnRecord.Down;
end;

procedure TScanWnd.SpdBtnFBClick(Sender: TObject);
begin
  if (NanoEdu.Method<>nil) then
  case SpdBtnFB.Down of
true:     Nanoedu.Method.TurnOnFB;
false:    Nanoedu.Method.TurnOffFB;
          end;
end;

procedure TScanWnd.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
 if True then
 

end;

procedure TScanWnd.ApplicationEventsActionExecute(Action: TBasicAction;   var Handled: Boolean);
begin
//

end;

procedure TScanWnd.ApplicationEventsException(Sender: TObject; E: Exception);
begin
//
  siLanglinked1.MessageDlg(' Error during ScanWork() execution ',mterror ,[mbYes],0);

end;

procedure TScanWnd.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if flgDragForm then
    if Msg.message=WM_LButtonDown then
   begin
   if  getkeystate(VK_Menu)<0 then
   begin
       PanelTop.BeginDrag(true);
       CopyClipboard;
       handled:=true;
    end;
   end;
      flgDragForm:=false;
end;

procedure TScanWnd.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
    begin
      flgDragForm:=false;
    end
end;

procedure TScanWnd.edNXExit(Sender: TObject);
var nxt:integer;
begin
 edNX.Font.Color:=clRed;
 ApplyBitBtn.Font.Color:=clRed;

 if edNX.text='' then  siLangLinked1.MessageDlg(scan36 (* 'error input NX' *) ,mtWarning,[mbOk],0)
  else
  begin
 try
  {$I-}
  nxt:=strtoint(edNX.text);
 if nxt>LinePointsMax then
   begin
    siLangLinked1.MessageDlg('Nx<='+inttostr(LinePointsMax),mtWarning,[mbOk],0);
    nxt:=LinePointsMax;
    edNx.text:=inttostr(nxt);
   end;
 except
    on EConvertError do
    begin siLangLinked1.MessageDlg(scan36(* 'error input NX' *),mtWarning,[mbOk],0); edNx.text:='0'end;
  end;
   {$I+}
 flgBlickApply:=True;
  Application.processmessages;
 end;
end;

procedure TScanWnd.EdNYExit(Sender: TObject);
var nyt:integer;
begin
 edNy.Font.Color:=clRed;
 ApplyBitBtn.Font.Color:=clRed;

 if edNy.text='' then  siLangLinked1.MessageDlg(scan37 (* 'error input Ny' *) ,mtWarning,[mbOk],0)
  else
  begin
 try
 {$I-}
  nyt:=strtoint(edNy.text);
 if  nyt>LinePointsMax then
   begin
        siLangLinked1.MessageDlg('Ny<='+inttostr(LinePointsMax),mtWarning,[mbOk],0);
        nyt:=LinePointsMax;
        edNy.text:=inttostr(nyt);
   end;
  except
    on EConvertError do
    begin siLangLinked1.MessageDlg(scan37  (* 'error input Ny' *),mtWarning,[mbOk],0); edNy.text:='0'end;
  end;
  {$I+}
 flgBlickApply:=True;
  Application.processmessages;
 end;

end;

procedure TScanWnd.edNXEnter(Sender: TObject);
var nyt:integer;
begin

end;

procedure TScanWnd.EdNYEnter(Sender: TObject);
var nyt:integer;
begin
end;

procedure TScanWnd.LabeledEditSpeedChange(Sender: TObject);
begin
    ScanParams.DacZTimeDelay:=strtoint(EditDacZSpeed.Text);
end;

procedure TScanWnd.LabeledEditSpeedKeyPress(Sender: TObject; var Key: Char);
begin
   if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TScanWnd.LblEditTTerraEnter(Sender: TObject);
begin
    if lblEditTTerra.text='' then  exit;
     ApplyBitBtn.Font.Color:=clRed;
     FlgBlickApply:=True;
     ScanParams.TerraTDelay:=strtoint(lblEditTTerra.text);
     SetCommonUserVar(ch_TerraDelay,ScanParams.TerraTDelay);//   if assigned(NanoEdu.Method)  and (NanoEdu.Method is TTopography) then NanoEdu.Method.SetSpeed;
end;

procedure TScanWnd.LblEditTTerraExit(Sender: TObject);
begin
    if lblEditTTerra.text='' then  exit;
     ApplyBitBtn.Font.Color:=clRed;
     FlgBlickApply:=True;
     ScanParams.TerraTDelay:=strtoint(lblEditTTerra.text);
     SetCommonUserVar(ch_TerraDelay,ScanParams.TerraTDelay);//   if assigned(NanoEdu.Method)  and (NanoEdu.Method is TTopography) then NanoEdu.Method.SetSpeed;
end;

procedure TScanWnd.LblEditTTerraKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TScanWnd.LandingBtnClick(Sender: TObject);
begin
  flgStopTimer:=true;
  flgApproachClick:=true;
  Close;
//  if  FlgStopScan then  Main.LandingSlowExecute(sender);
end;

procedure TScanWnd.LblEditDecayChange(Sender: TObject);
begin
     ScanParams.IntegrDecay:=strtoint(LblEditDecay.Text);
end;

procedure TScanWnd.LblEditDecayKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TScanWnd.SignalsModeBtnBiasSFMClick(Sender: TObject);
begin
  SignalsMode.btnBiasVClick(Sender);

end;

procedure TScanWnd.SignalsModebtnSetPointClick(Sender: TObject);
begin
  SignalsMode.btnSetPointClick(Sender);

end;

procedure TScanWnd.SignalsModeButton1Click(Sender: TObject);
begin
  SignalsMode.BtnSetInterClick(Sender);
end;

procedure TScanWnd.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TScanWnd.BitBtnLockClick(Sender: TObject);
begin
  flgSpeedLock:=not flgSpeedLock;
  EdScanRateBW.Enabled:=not flgSpeedLock;
  UpDownSpeedBW.Enabled:=not flgSpeedLock;
  BitBtnLock.Visible:=flgSpeedLock;
  BitBtnOpenLock.Visible:=not flgSpeedLock;
end;

procedure TScanWnd.SpeedBtnRenishawClick(Sender: TObject);
 begin
 FlgRenishawUnit:=not FlgRenishawUnit;
 SpeedBtnRenishawExecute;
end;

procedure TScanWnd.SpeedBtnRenishawExecute;
var ScanPathold:word;
begin
  if HardWareOpt.XYtune='Fine' then BitBtnMClick(Self);  //fine-rough
    CaptionRenishaw:='';
    ScanPathold:=scanparams.ScanPath;
    CheckBoxOnNets.Visible:= FlgRenishawUnit;
    BitBtnPointClearClick(self);
  if FlgRenishawUnit then
   begin
     CaptionRenishaw:=siLangLinked1.GetTextOrDefault('IDS_18' (* '  Renishaw' *) );
  //   ScannerCorrect.FlgXYLinear:=false;
     if assigned(MatrixLitho) then
       begin
         finalize(MatrixLitho);
       //  finalize(MatrixLithoAct);
         flgprojection:=false;
       end;
               case flgUnit of
     nano,
     Pipette,
     terra:  Setscanparamsdef;     //fine; rough
    ProBeam,MicProbe:   SetScanParamsDefSEM;
     baby:   SetscanparamsdefAtom;
    grand:   SetscanparamsdefGrand;
              end;

     CheckBoxStep.checked:=true;
     CheckBoxStep.enabled:=false;
     CheckBoxOnNets.visible:=true;
     CheckBoxOnNets.Checked:=True;
     CheckBoxOnNets.enabled:=true;
     FlgRenishawCorrection:=true;
     Checkboxdrift.Visible:=false;//true;
   end
   else            //not renishaw
   begin
     if   HardWareOpt.XYtune='Rough' then
     begin
        case flgUnit of
     nano,
     Pipette,
     terra:  Setscanparamsdef;     //fine; rough
    ProBeam,MicProbe:   SetScanParamsDefSEM;
     baby:   SetscanparamsdefAtom;
    grand:   SetscanparamsdefGrand;
              end;
      end;
//      ScannerCorrect.FlgXYLinear:=oldFlgXYLinear;
      scanparams.ScanPath:=ScanPathold;
      Checkboxdrift.Visible:=false;
       if assigned(MatrixLitho) then
       begin
         finalize(MatrixLitho);
        // finalize(MatrixLithoAct);
         flgprojection:=false;
       end;
    //   ScanAreaUpdate;
       CheckBoxOnNets.Checked:=false;
       CheckBoxOnNets.Visible:=false;
       CheckBoxStep.checked:=false;
       CheckBoxStep.enabled:=true;
       CaptionRenishaw:='';
       FlgRenishawCorrection:=false;
   end;
   Caption:=captionbase+Captionadd+CaptionRenishaw;
   SetXYMax;
   ScanAreaUpdate;
   ApplyBtnClick(self);
end;
initialization
 begin

 end;

end.







