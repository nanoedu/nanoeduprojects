//110407
unit frExperimParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, menus,Math, ShellApi, Buttons, ExtCtrls, AppEvnts, IniFiles,
  ComCtrls,StdCtrls,CSPMVar, GlobalType, siComp, siLngLnk, ToolWin,ActiveX;
 type
  TOleChar = WideChar;
  POleStr = PWideChar;

  POleStrList = ^TOleStrList;
  TOleStrList = array[0..65535] of POleStr;

(*   TOleChar = Char;
  POleStr = PChar;

  POleStrList = ^TOleStrList;
  TOleStrList = array[0..65535] of POleStr;
 *)
  TApproachOpt = class(TForm)
    ApplicationEvents: TApplicationEvents;
    OpenDialog: TOpenDialog;
    Panel15: TPanel;
    DefaultBtn: TButton;
    BitBtnCancel: TBitBtn;
    OKBtn: TBitBtn;
    siLangLinked1: TsiLangLinked;
    ToolBar1: TToolBar;
    HelpBtn: TToolButton;
    BitBtn1: TBitBtn;
    Label43: TLabel;
    PageControl: TPageControl;
    ApprOptSheet: TTabSheet;
    Label21: TLabel;
    Label41: TLabel;
    ApproachOptGrid: TStringGrid;
    ComboBoxT: TComboBox;
    PanelPMTime: TPanel;
    Label29: TLabel;
    LabelPMTime: TLabel;
    Label32: TLabel;
    LabelPause: TLabel;
    ScrollBarPMTime: TScrollBar;
    ScrollBarPMPause: TScrollBar;
    CheckBoxControlTopPosition: TCheckBox;
    HardWareSheet: TTabSheet;
    Label3: TLabel;
    LabelCntrlNum: TLabel;
    ValueControllerNum: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label26: TLabel;
    XYTune: TLabel;
    edAMPGainRZ: TEdit;
    edAMPGainFZ: TEdit;
    edAMPGainRX: TEdit;
    edAMPGainFX: TEdit;
    edAMPGainRY: TEdit;
    edAMPGainFY: TEdit;
    edUFBMaxOut: TEdit;
    edTappKoef: TEdit;
    CBoxZTune: TComboBox;
    CBoxXYTune: TComboBox;
    PanelTune: TPanel;
    BitBtnEditIni: TBitBtn;
    CbElectronicNum: TComboBox;
    BBtnContrDelete: TBitBtn;
    BBtnControllerIni: TBitBtn;
    CSPMSheet: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    CSPMSignalsTab: TStringGrid;
    ScanOptsheet: TTabSheet;
    ScanOptGrid: TStringGrid;
    ScanCorSheet: TTabSheet;
    PanelScanCorRight: TPanel;
    PanelScannerCorr: TPanel;
    LabeLLinOn: TLabel;
    LabelScanNmb: TLabel;
    Label31: TLabel;
    BitBtnViewLinCurv: TBitBtn;
    ComboBoxPath: TComboBox;
    Panel16: TPanel;
    GbScanFlags: TGroupBox;
    Label28: TLabel;
    CBoxXYLIn: TComboBox;
    Panel12: TPanel;
    GbImaging: TGroupBox;
    Label30: TLabel;
    Label22: TLabel;
    CBoxDelP: TComboBox;
    CBoxHideLine: TComboBox;
    Panel10: TPanel;
    PanelPlaneDel: TPanel;
    Panel13: TPanel;
    GroupBox3: TGroupBox;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    EdSensZ: TEdit;
    EdSensX: TEdit;
    EdSensY: TEdit;
    EdI_VTransf: TEdit;
    Panel14: TPanel;
    GbLinearization: TGroupBox;
    Label14: TLabel;
    Label23: TLabel;
    Label15: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    EdNonLinRgX: TEdit;
    EdNonLinRgY: TEdit;
    EdGrateStep: TEdit;
    edYSectAngle: TEdit;
    Panel11: TPanel;
    TabSheetVideo: TTabSheet;
    Label24: TLabel;
    LabelOrVideoCaption: TLabel;
    ComboBoxVideo: TComboBox;
    BitBtnBrowser: TBitBtn;
    BitBtnVideo: TBitBtn;
    EdOrVideoCapture: TEdit;
    TabSheetSetScan: TTabSheet;
    Label11: TLabel;
    Label27: TLabel;
    LabelNmbCntr: TLabel;
    cbScannerNum: TComboBox;
    TabSheetOsc: TTabSheet;
    GridOsc: TStringGrid;
    RadioGOpenChanel: TRadioGroup;
    TabSheetRenishaw: TTabSheet;
    Label19: TLabel;
    Label33: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    LabelSlowAxisRate: TLabel;
    EdRenishawPeriodKoef: TEdit;
    BitBtnSaveRenishaw: TBitBtn;
    cbRenishawType: TComboBox;
    EdLineToLineTime: TEdit;
    CbflgLineToLineTime: TCheckBox;
    PanelBufferLen: TPanel;
    Label40: TLabel;
    cbBufferLen: TComboBox;
    TabSheetPID: TTabSheet;
    Label39: TLabel;
    LabeldT: TLabel;
    LabelTe: TLabel;
    RadioGroupTe: TRadioGroup;
    SbdT: TScrollBar;
    sbTd: TScrollBar;
    sbTe: TScrollBar;
    RadioGroupTd: TRadioGroup;
    TabSheet1: TTabSheet;
    TopoStringGrid: TStringGrid;
    LabelTd: TLabel;
    Label42: TLabel;
    CbLinCurvesSource: TComboBox;
    BitBtnSAVE: TBitBtn;
    DeleteScanner: TBitBtn;
    BBtnScannnerIni: TBitBtn;
    BitBtnSaveAdapter: TBitBtn;
    TabSheetController: TTabSheet;
    Panel18: TPanel;
    LblEditNTSPB: TLabeledEdit;
    LblEditLMT: TLabeledEdit;
    PanelDacV: TPanel;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    Panel19: TPanel;
    BitBtnWriteController: TBitBtn;
    BitBtnReadController: TBitBtn;
    ComboBoxLvlDel: TComboBox;
    Label20: TLabel;
    PanelDelay: TPanel;
    Label35: TLabel;
    EditLithoDelay: TEdit;
    EditScanDelay: TEdit;
    Label34: TLabel;
    PanelCurThreshold: TPanel;
    EditIMaxCut: TEdit;
    Label25: TLabel;
    PanelZ: TPanel;
    CBoxZLinAbs: TComboBox;
    Labelabs: TLabel;
    LabelZlin: TLabel;
    CboxZLin: TComboBox;
    lblCutImaxinfo: TLabel;
    procedure cbBufferLenChange(Sender: TObject);
    procedure EdLineToLineTimeKeyPress(Sender: TObject; var Key: Char);
    procedure EdRenishawPeriodKoefKeyPress(Sender: TObject; var Key: Char);
    procedure CbflgLineToLineTimeClick(Sender: TObject);
    procedure cbRenishawTypeChange(Sender: TObject);
    procedure BitBtnSaveRenishawClick(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApproachOptGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
 //   procedure InformSheetShow(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure DefaultBtnClick(Sender: TObject);
    procedure EdTanXKeyPress(Sender: TObject; var Key: Char);
    procedure EdTanYKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnViewLinCurvClick(Sender: TObject);
    procedure ScanOptGridMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure CBoxXYTuneChange(Sender: TObject);
    procedure ApproachOptGridMouseMove(Sender: TObject; Shift: TShiftState;X, Y: Integer);
    procedure edNewElectronicChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ApproachOptGridMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BitBtnEditIniClick(Sender: TObject);
    procedure CBoxZTuneChange(Sender: TObject);
    procedure BBtnScannnerIniClick(Sender: TObject);
    procedure BBtnControllerIniClick(Sender: TObject);
    procedure DeleteScannerClick(Sender: TObject);
    procedure cbScannerNumChange(Sender: TObject);
    procedure BtnDeleteControllerClick(Sender: TObject);
    procedure cbElectronicNumChange(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure BitBtnBrowserClick(Sender: TObject);
    procedure ComboBoxVideoChange(Sender: TObject);
    procedure BitBtnVideoClick(Sender: TObject);
    procedure cbScannerNumSelect(Sender: TObject);
    procedure CbElectronicNumSelect(Sender: TObject);
    procedure EdNonLinRgXChange(Sender: TObject);
    procedure EdNonLinRgYChange(Sender: TObject);
    procedure EdGrateStepChange(Sender: TObject);
    procedure RadioGroupClick(Sender: TObject);
    procedure CBoxXYLInSelect(Sender: TObject);
    procedure EdSensXChange(Sender: TObject);
    procedure CheckBoxFlashClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbScannerNumClick(Sender: TObject);
    procedure BitBtnSAVEClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdSensYKeyPress(Sender: TObject; var Key: Char);
    procedure EdSensXKeyPress(Sender: TObject; var Key: Char);
    procedure EdI_VTransfKeyPress(Sender: TObject; var Key: Char);
    procedure EdSensZKeyPress(Sender: TObject; var Key: Char);
    procedure edYSectAngleKeyPress(Sender: TObject; var Key: Char);
    procedure EdNonLinRgYKeyPress(Sender: TObject; var Key: Char);
    procedure EdNonLinRgXKeyPress(Sender: TObject; var Key: Char);
    procedure EdGrateStepKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxTChange(Sender: TObject);
    procedure ScrollBarPMTimeScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure edAMPGainFZKeyPress(Sender: TObject; var Key: Char);
    procedure edAMPGainFXKeyPress(Sender: TObject; var Key: Char);
    procedure edAMPGainRZKeyPress(Sender: TObject; var Key: Char);
    procedure edAMPGainFYKeyPress(Sender: TObject; var Key: Char);
    procedure edAMPGainRXKeyPress(Sender: TObject; var Key: Char);
    procedure edAMPGainRYKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxPathSelect(Sender: TObject);
    procedure ApproachOptGridKeyPress(Sender: TObject; var Key: Char);
    procedure ScrollBarPMPauseScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ScanOptGridKeyPress(Sender: TObject; var Key: Char);
    procedure ScanOptGridExit(Sender: TObject);
    procedure RadioGOpenChanelClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure EditdTKeyPress(Sender: TObject; var Key: Char);
    procedure EditTeKeyPress(Sender: TObject; var Key: Char);
    procedure EditTdKeyPress(Sender: TObject; var Key: Char);
    procedure EditTiKeyPress(Sender: TObject; var Key: Char);
    procedure RadioGroupTeClick(Sender: TObject);
    procedure RadioGroupTdClick(Sender: TObject);
//    procedure RadioGroupTiClick(Sender: TObject);
    procedure sbTeScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure sbTdScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
//    procedure sbTiScroll(Sender: TObject; ScrollCode: TScrollCode;
//      var ScrollPos: Integer);
    procedure SbdTScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure BitBtnSaveAdapterClick(Sender: TObject);
    procedure BitBtnWriteControllerClick(Sender: TObject);
    procedure LblEditNTSPBExit(Sender: TObject);
    procedure BitBtnReadControllerClick(Sender: TObject);
    procedure ComboBoxLvlDelClick(Sender: TObject);
    procedure EditIMaxCutKeyPress(Sender: TObject; var Key: Char);
    procedure CboxZLinSelect(Sender: TObject);
    procedure CBoxZLinAbsSelect(Sender: TObject);
    procedure EditIMaxCutKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIMaxCutExit(Sender: TObject);
    procedure EditIMaxCutChange(Sender: TObject);
//    procedure BitBtn2Click(Sender: TObject);
  private
      { Private declarations }
       flgManualScanSelect:boolean;
       prevNXYMax:integer;
       EditedSheet:integer;
       Col : integer;
       Row : integer;
       YBiasTanOpen:single;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivXOpen:single;
       SensitivYOpen:single;
       FormVar: ^TApproachOpt;

      function  ChangeMaxArea:boolean;
      procedure ComboBoxLinE(flg:boolean);
      procedure SetAutoScanner(Sender: TObject);
      procedure CSPMSignalsTabInit;
      procedure HardWareSheetInit;
      procedure PIDSheetInit;
      procedure SetScannerNumSheetInit;
      procedure OscGridInit;
      procedure WMMOve(var Mes:TWMMove); message WM_Move;
      procedure PanelScannerCorrEnab;
      procedure SetControllerName;//function ExecAndWait(const FileName, Params: ShortString; const WinState: Word): boolean;
      procedure MakeReloadSplines;

  public
    { Public declarations }
     flgReLoadSpline:Boolean;
     procedure   UpdateOption;
     procedure   ApproachSheetInit;
     procedure   ControllerSheetInit;
     procedure   ScanCorrSheetInit;
     procedure   TopoSheetInit;
     procedure   ScanOptGridInit;
     procedure   RenishawSheetInit;
     procedure   UserMessage (var Msg: TMessage); message  WM_UserApproachOptUpdated;
     constructor Create(AOwner: TComponent; var AFormVar: TApproachOpt);
     destructor  Destroy; override;
     procedure   ThreadDone(var AMessage : TMessage); message WM_ThreadDoneMsg;
end;

var
    ApproachOpt: TApproachOpt;

implementation

uses GlobalVar,GlobalFunction,RenishawVars,SystemConfig, mHardWareOpt,frScannerCorrVisual, UScannerCorrect,
     frApproachnew,frAdapterService,frScanWnd, nanoeduhelp,mSetGridApr,MLPC_API2Lib_TLB,uNanoEduScanClasses,
     FrScannerMemo,UNanoEduBaseClasses,UNanoEduInterface,mMain,ThreadWriteToControllerEEProm;

{$R *.DFM}
const
	ASTMCells00: string = ''; (* IT Level,  nA(>0) *)
	ASFMCells00: string = ''; (* Probe Amplitude Level, arb. units *)
	ACells01: string = ''; (* Z Gate max, arb. units *)
	ACells02: string = ''; (* Z Gate min, arb. units *)
	ACells03: string = ''; (* Scanner Decay, ms *)
	ACells04: string = ''; (* Integrator Delay, ms *)
	ACells05: string = ''; (* Frequency Band Rough *)
	ACells06: string = ''; (* Rising Steps Number *)
	ACells07: string = ''; (* Fast Landing Steps Number *)
	ASTMCells08: string = ''; (* Scale Max IT *)
	ASTMCells08Pipe: string = ''; (* Max. I % *) // TSI: Localized (Don't modify!)
	ASFMCells08: string = ''; (* Max Modulation Amplitude *)
	ACellsSFM09: string = ''; (* Landing Amplitude Suppression *)
	ACellsSTM09: string = ''; (* Landing SetPoint ,nA *)
	ASFMCells09: string = ''; (* Max Oscillation Amplitude, mV *)
	ASFMCells010: string = ''; (* Ampl Koeff (=0.7) *)
	ACells010: string = ''; (* FB Loop Gain *)
	SCells00: string = ''; (* X, (nm) *)
	SCells01: string = ''; (* Y, (nm) *)
	SCells02: string = ''; (* X0, (nm) *)
	SCells03: string = ''; (* Y0, (nm) *)
	SCells04: string = ''; (* Nx, points *)
	SCells05: string = ''; (* Ny, points *)
	SCells06: string = ''; (* Velocity, nm/s *)
	SCells07: string = ''; (* Scan Mode *)
	SCells08: string = ''; (* Microstep, discrets *)
	SCells09: string = ''; (* Delay between microsteps, mks *)
	SCells010: string = ''; (* Number of microsteps in one step *)
	SCells011: string = ''; (* Xmax in nm *)
	SCells012: string = ''; (* Ymax in nm *)
	SCells013: string = ''; (* Step X,Y in nm *)
	SCells014: string = ''; (* Max points in the line *)
	Osc00: string = ''; (* DAC_Z *)
	Osc01: string = ''; (* DAC_X *)
	Osc02: string = ''; (* DAC_Y *)
	Osc03: string = ''; (* DAC_REF *)
	Osc04: string = ''; (* DAC_VT *)
	Osc05: string = ''; (* ADC_Z *)
	Osc06: string = ''; (* ADC_Phase *)
	Osc07: string = ''; (* ADC_CURRENT *)
	Osc08: string = ''; (* Probe Oscillation *)
	Osc20: string = ''; (* SMX_STEP *)
	Osc21: string = ''; (* SMY_STEP *)
	Osc22: string = ''; (* SMZ_STEP *)
	Osc23: string = ''; (* PM_STEP *)
//
   stre: string = ''; (*  No data for  *)
	stre1: string = ''; (*  in  *)
	stre2: string = ''; (*  Add New Controller? *)
	stre4: string = ''; (* Spectroscopy Regime is Active!! Parameters changing is not saved. *)
	stre7: string = ''; (*  Add new Scanner? *)
	stre5: string = ''; (* Error!! Max Compensation X =1 *)
	stre8: string = ''; (* Error!! Max Compensation Y =1 *)
	stre9: string = ''; (* Scanner  *)
 stre10: string = ''; (*  doesn't exist. Manual regime is set! *)
 stre11: string = ''; (* Physical Unit Flash Drive is not connected! Continue work without Flash Drive? *)
 stre12: string = ''; (* Rewrite Scanner Parameters ? *)


var   HintScanGrid:array[0..11] of string;
      HintApproachGrid:array[0..11] of string;

procedure TApproachOpt.UserMessage (var Msg: TMessage);
begin
if MSG.wparam=0 then
 begin
  LoadScannerOptGeneral(ScanneriniFileX,ScanneriniFileY);
  ScannerCorrectLast();
  UpdateOption;
  if ChangeMaxArea then
  begin
 //  RenishawParamsDef;
 //  RenishawParamsLast;
   SetScanAreaDefR;
  // SetScanParamsDef;    161109
  end;
 end;
if MSG.wparam=1 then
 begin
  SetLinSplineZero;
  LoadLinSpline(HardWareOpt.ScannerNumb);
 end;
  Application.ProcessMessages;
end;

procedure TApproachOpt.PanelScannerCorrEnab;
begin
      cbScannerNum.Enabled:=PanelScannerCorr.Enabled;
       edNonLinRgX.enabled:=PanelScannerCorr.Enabled;
       edNonLinRgY.enabled:=PanelScannerCorr.Enabled;
       edGrateStep.enabled:=PanelScannerCorr.Enabled;
      edYSectAngle.enabled:=PanelScannerCorr.Enabled;
         cBoxXYLin.enabled:=PanelScannerCorr.Enabled;
      cBoxHideLine.enabled:=PanelScannerCorr.Enabled;
 BitBtnViewLinCurv.enabled:=PanelScannerCorr.Enabled;
end;

procedure TApproachOpt.WMMOve(var Mes:TWMMove);
begin
//  if Mes.YPos<(Main.ToolBar1.Height div 2) then Top:=5;;//Main.ToolBar1.Height+5;
end;

procedure TApproachOpt.UpdateOption;
begin
//   HardWareSheetInit;
   ScanCorrSheetInit;
   ApproachSheetInit;
   ScanOptGridInit;
    { TODO : 110407 }
  SetScannerNumSheetInit;
end;

procedure TApproachOpt.UpdateStrings;
begin
  ASTMCells08Pipe := siLangLinked1.GetTextOrDefault('strASTMCells08Pipe' (* 'Max. I %' *) );
  SCells014 := siLangLinked1.GetTextOrDefault('strSCells014');
  Osc23 := siLangLinked1.GetTextOrDefault('strOsc23');
  Osc22 := siLangLinked1.GetTextOrDefault('strOsc22');
  Osc21 := siLangLinked1.GetTextOrDefault('strOsc21');
  Osc20 := siLangLinked1.GetTextOrDefault('strOsc20');
  Osc08 := siLangLinked1.GetTextOrDefault('strOsc08');
  Osc07 := siLangLinked1.GetTextOrDefault('strOsc07');
  Osc06 := siLangLinked1.GetTextOrDefault('strOsc06');
  Osc05 := siLangLinked1.GetTextOrDefault('strOsc05');
  Osc04 := siLangLinked1.GetTextOrDefault('strOsc04');
  Osc03 := siLangLinked1.GetTextOrDefault('strOsc03');
  Osc02 := siLangLinked1.GetTextOrDefault('strOsc02');
  Osc01 := siLangLinked1.GetTextOrDefault('strOsc01');
  Osc00 := siLangLinked1.GetTextOrDefault('strOsc00');
  ACells010 := siLangLinked1.GetTextOrDefault('strACells010');
  stre12 := siLangLinked1.GetTextOrDefault('strstre12');
  stre11 := siLangLinked1.GetTextOrDefault('strstre11');
  stre10 := siLangLinked1.GetTextOrDefault('strstre10');
  stre9 := siLangLinked1.GetTextOrDefault('strstre9');
  stre8 := siLangLinked1.GetTextOrDefault('strstre8');
  stre5 := siLangLinked1.GetTextOrDefault('strstre5');
  stre7 := siLangLinked1.GetTextOrDefault('strstre7');
  stre4 := siLangLinked1.GetTextOrDefault('strstre4');
  stre2 := siLangLinked1.GetTextOrDefault('strstre2');
  stre1 := siLangLinked1.GetTextOrDefault('strstre1');
  stre := siLangLinked1.GetTextOrDefault('strstre');
  SCells013 := siLangLinked1.GetTextOrDefault('strSCells013');
  SCells012 := siLangLinked1.GetTextOrDefault('strSCells012');
  SCells011 := siLangLinked1.GetTextOrDefault('strSCells011');
  SCells010 := siLangLinked1.GetTextOrDefault('strSCells010');
  SCells09 := siLangLinked1.GetTextOrDefault('strSCells09');
  SCells08 := siLangLinked1.GetTextOrDefault('strSCells08');
  SCells07 := siLangLinked1.GetTextOrDefault('strSCells07');
  SCells06 := siLangLinked1.GetTextOrDefault('strSCells06');
  SCells05 := siLangLinked1.GetTextOrDefault('strSCells05');
  SCells04 := siLangLinked1.GetTextOrDefault('strSCells04');
  SCells03 := siLangLinked1.GetTextOrDefault('strSCells03');
  SCells02 := siLangLinked1.GetTextOrDefault('strSCells02');
  SCells01 := siLangLinked1.GetTextOrDefault('strSCells01');
  SCells00 := siLangLinked1.GetTextOrDefault('strSCells00');
  ASFMCells010 := siLangLinked1.GetTextOrDefault('strASFMCells010');
  ASFMCells09 := siLangLinked1.GetTextOrDefault('strASFMCells09');
  ACellsSTM09 := siLangLinked1.GetTextOrDefault('strACellsSTM09');
  ACellsSFM09 := siLangLinked1.GetTextOrDefault('strACellsSFM09');
  ASFMCells08 := siLangLinked1.GetTextOrDefault('strASFMCells08');
  ASTMCells08 := siLangLinked1.GetTextOrDefault('strASTMCells08');
  ACells07 := siLangLinked1.GetTextOrDefault('strACells07');
  ACells06 := siLangLinked1.GetTextOrDefault('strACells06');
  ACells05 := siLangLinked1.GetTextOrDefault('strACells05');
  ACells04 := siLangLinked1.GetTextOrDefault('strACells04');
  ACells03 := siLangLinked1.GetTextOrDefault('strACells03');
  ACells02 := siLangLinked1.GetTextOrDefault('strACells02');
  ACells01 := siLangLinked1.GetTextOrDefault('strACells01');
  ASFMCells00 := siLangLinked1.GetTextOrDefault('strASFMCells00');
  ASTMCells00 := siLangLinked1.GetTextOrDefault('strASTMCells00');

end;
procedure    TApproachOpt.TopoSheetInit;
var i:integer;
    str:string;
    pnout:PLongint;
   { OLE character and string types }
    elt:Polestrlist;// of  Pwidestring;
    wchar:PwideChar;
    IU:IUnknown;
    IUStr:IEnumString;    //activeX
    Hr:Hresult;
(*  IEnumString = interface(IUnknown)
    ['{00000101-0000-0000-C000-000000000046}']
    function Next(celt: Longint; out elt;
      pceltFetched: PLongint): HResult; stdcall;
    function Skip(celt: Longint): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out enm: IEnumString): HResult; stdcall;

     TOleChar = WideChar;
  POleStr = PWideChar;

  POleStrList = ^TOleStrList;
  TOleStrList = array[0..65535] of POleStr;
*)

//olstr:TOleStrList;
begin
(*  if Assigned(SchematicControl)  then
  begin
    SchematicControl.IsLoaded(flgSchemeLoaded);
    if flgSchemeLoaded then
    begin
      SchematicControl.EnumLFB(IU);
     if assigned(IU) then
     begin
      IUStr:=IU as  IEnumString;
      i:=0;
       Hr:=IUStr.ReSet;
       new(pnout);
       repeat
        hr:=IUStr.Next(1,elt,pnout);
       if Pnout<>nil then
       begin
        if Pnout^=1 then
         BEGIN
          wchar:=(elt^)[0];
          str:=WideCharToString(wchar);
          TopoStringGrid.Cells[1,i]:=str;
//          CoTaskMemFree(wchar);
          inc(i);
         END;
       end
       else break;
       until  pnout^=0;
     end;
    end;
  end;   *)
end;


procedure TApproachOpt.CSPMSignalsTabInit;
var i:integer;
begin
  with CSPMSignalsTab do
   begin
     ColWidths[0]:=Panel1.Width-2;
     ColWidths[1]:=Panel5.Width-2;
     ColWidths[2]:=Panel6.Width-2;
     ColWidths[3]:=Panel3.Width-2;
     ColWidths[4]:=Panel7.Width-2;
     ColWidths[5]:=Panel8.Width-2;
     ColWidths[6]:=Panel9.Width-2;
     for i:=0 to 12 do
      begin
       Cells[0,i]:=CSPMSignals[i+1].Name;
       Cells[1,i]:=Format('%6.2f',[CSPMSignals[i+1].MinV]);
       Cells[2,i]:=Format('%6.2f',[CSPMSignals[i+1].MaxV]);
       Cells[3,i]:=Format('%d',[CSPMSignals[i+1].DeviceClass]);
       Cells[4,i]:=Format('%d',[CSPMSignals[i+1].MinDiscr]);
       Cells[5,i]:=Format('%d',[CSPMSignals[i+1].ZeroVal]);
       Cells[6,i]:=Format('%d',[CSPMSignals[i+1].MaxDiscr]);
      end;
   end;
end;

procedure TApproachOpt.PIDSheetInit;

var
TeFineMin, TeFineMax,
TdFineMin, TdFineMax,
TiFineMin, TiFineMax :PIDType;
fineScale2: PIDType;
koef:single;
begin
//RadioGroupTi.ItemIndex:=0;
RadioGroupTe.ItemIndex:=0;
RadioGroupTd.ItemIndex:=0;

Labeldt.Caption:=IntToStr(PidParams.dT);
LabelTe.Caption:=floattoStrf(PidParams.Te, fffixed,5,2);
LabelTd.Caption:=floattoStrf(PidParams.Td, fffixed,5,2);
//LabelTi.Caption:=floattoStrf(PidParams.Ti, fffixed,5,2);
sbdT.Max:=PidParams.dTAbsMax;
sbdT.Min:=1;
sbTe.Max:=round(PidParams.TeAbsMax);
sbTe.Min:=0;
//sbTi.Max:=PidParams.dTAbsMax;
//sbTi.Min:=0;
sbTe.Position:=round(PidParams.Te);
sbdT.Position:=PidParams.dT;//*sbdT.Max/PidParams.dTAbsMax);

(*with PidParams do
  begin
//    InitPIDFine(Te, TeAbsMax, pidTeL1,pidTeL2);
    sbTe.Position:= round(sbTe.Max*(Te-pidTeL1)/(pidTeL2-pidTeL1));
//    InitPIDFine(Td, TdAbsMax, pidTdL1,pidTdL2);
    sbTd.Position:= round(sbTd.Max*(Td-pidTdL1)/(pidTdL2-pidTdL1));
    InitPIDFine(abs(Ti), TiAbsMax,pidTiL1,pidTiL2);
    sbTi.Position:= round(sbTi.Max*(abs(Ti)-pidTiL1)/(pidTiL2-pidTiL1));
  end;
 *)
end;
procedure TApproachOpt.HardWareSheetInit;
var     i:integer;
  iniCSPM:TIniFile;
    sFile:string;
begin
 { TODO : 020908 }
 (*    if HardWareOpt.ZTune='Rough' then CBoxZtune.ItemIndex:=0
                                  else CBoxZtune.ItemIndex:=1;
   { TODO : 020908 }

//      CBoxZTune.Text:=HardWareOpt.ZTune;
   if HardWareOpt.XYTune='Rough' then CBoxXYTune.ItemIndex:=0
                                 else CBoxXYTune.ItemIndex:=1;

//    CBoxXYTune.Text:=HardWareOpt.XYTune;
{ TODO : 020908 }

    edAMPGainRZ.Text:=format('%f',[HardWareOpt.AMPGainRZ]);
    edAMPGainRX.Text:=format('%f',[HardWareOpt.AMPGainRX]);
    edAMPGainRY.Text:=format('%f',[HardWareOpt.AMPGainRY]);
    edAMPGainFZ.Text:=format('%f',[HardWareOpt.AMPGainFZ]);
    edAMPGainFX.Text:=format('%f',[HardWareOpt.AMPGainFX]);
    edAMPGainFY.Text:=format('%f',[HardWareOpt.AMPGainFY]);
    edUFBMaxOut.Text:=format('%f',[HardWareOpt.UFBMaxOut]);
     edTappKoef.Text:=format('%f',[HardWareOpt.TappingKoef]);
//    edNewElectronic.itemindex:=0;
    sFile:=ControllerIniFilePath+ ControllerIniFile;
    IniCSPM:=TIniFile.Create(sFile);
  try
    with iniCSPM do
    begin
      ReadSections(cbElectronicNum.Items);
     if  not SectionExists(HardWareOpt.ElectronicNumb) then
      if siLangLinked1.MessageDlg(stre{' No data for '}+ HardWareOpt.ElectronicNumb+stre1{' in '}+
         ControllerIniFile + stre2{' Add New Controller?'}, mtConfirmation, [mbYes, mbNo], 0)= mrYes
      then
         begin
           with  cbElectronicNum do Items.Add(HardWareOpt.ElectronicNumb);
           if boolean(HardWareOpt.FlgAutoScanner) and (not HardWareOpt.FlgFlash) then HardWareOpt.ScannerNumb:=HardWareOpt.ElectronicNumb;
         end;
     end;
      for i:=0 to cbElectronicNum.Items.Count-1 do
       if HardWareOpt.ElectronicNumb=cbElectronicNum.Items[i] then
         begin
            cbElectronicNum.ItemIndex:=i;
         end;
    finally
     IniCSPM.Free;
    end;
    *)
end;

procedure TApproachOpt.HelpBtnClick(Sender: TObject);
begin
  if STMFlg then HlpContext:=	IDH_Parameters  else HlpContext:=IDH_paramers_SSM;
  Application.HelpContext(HlpContext)
end;


procedure TApproachOpt.LblEditNTSPBExit(Sender: TObject);
var i:integer;
begin
  for i:=0 to length(PControllerParams^.SN_NTSPB)-1 do
  PControllerParams^.SN_NTSPB[i]:=#0;
  for i:=0 to length(LblEditNTSPB.Text)-1 do
  PControllerParams^.SN_NTSPB[i]:=AnsiChar(LblEditNTSPB.Text[i+1]);
end;

procedure   TApproachOpt.ControllerSheetInit;
var str:string;
    i:integer;
begin
   str:=PControllerParams^.SN_LMT[0];
    for i:=1 to 15 do
  // if PControllerParams^.SN_LMT[i]<>#0 then
     str:=str+ PControllerParams^.SN_LMT[i];
    LblEditLMT.Text:=str;
      str:=PControllerParams^.SN_NTSPB[0];
    for i:=1 to 15 do
  if PControllerParams^.SN_NTSPB[i]<>#0 then     str:=str+ PControllerParams^.SN_NTSPB[i];
    LblEditNTSPB.Text:=str;
    labeledEdit1.Text:=floattostrF(PControllerParams^.X_Max,fffixed,5,2);
    labeledEdit1.EditLabel.Caption:=PControllerParams^.X_Name+ ' Max';
    labeledEdit4.Text:=floattostrF(PControllerParams^.X_Min,fffixed,5,2);
    labeledEdit4.EditLabel.Caption:=PControllerParams^.X_Name+' Min' ;
    labeledEdit2.Text:=floattostrF(PControllerParams^.Y_Max,fffixed,5,2);
    labeledEdit2.EditLabel.Caption:=PControllerParams^.Y_Name+ ' Max';
    labeledEdit5.Text:=floattostrF(PControllerParams^.Y_Min,fffixed,5,2);
    labeledEdit5.EditLabel.Caption:=PControllerParams^.Y_Name+' Min';
    labeledEdit3.Text:=floattostrF(PControllerParams^.Z_Max,fffixed,5,2);
    labeledEdit3.EditLabel.Caption:=PControllerParams^.Z_Name+ ' Max';
    labeledEdit6.Text:=floattostrF(PControllerParams^.Z_Min,fffixed,5,2);
    labeledEdit6.EditLabel.Caption:=PControllerParams^.Z_Name+' Min';
end;

procedure TApproachOpt.ApproachSheetInit;
begin
 with ApproachOptGrid do
  begin
    if STMFlg then
     begin
       Cells[0,0]:=ASTMCells00;
(*       if flgUnit<>pipette then    Cells[0,8]:=ASTMCells08
                           else
                           *)
       Cells[0,7]:=ASTMCells08Pipe;
       Cells[0,8]:=ACellsSTM09;
     end
     else
     begin
       Cells[0,0]:=ASFMCells00;
       Cells[0,7]:=ASFMCells08;
       Cells[0,8]:=ACellsSFM09;
//       Cells[0,10]:=ASFMCells010;
     end;
     Cells[0,1]:=ACells01;
     Cells[0,2]:=ACells02;
     Cells[0,3]:=ACells03;
     Cells[0,4]:=ACells04;
     Cells[0,5]:=ACells06;
     Cells[0,6]:=ACells07;
 //    Cells[0,7]:=ACells09;
 //    Cells[0,10]:=ACells010;
     ColWidths[0]:=340;
     ColWidths[1]:=70;
   with ApproachParams do
    begin
     if STMFlg then
      begin
       Cells[1,0]:=FloatToStrF(LevelIT*ITCor,fffixed,5,2);   //101210
      (* if flgUnit<>Pipette then    Cells[1,8]:=FloatToStrF(ScaleMaxIT,fffixed,5,2)     //101210
                           else*)
       Cells[1,7]:=IntToStr(MaxITIndicator);
       Cells[1,8]:=Format('%f',[LandingSetPoint*ITcor]);//'Landing Set point';  101210
      end
      else
      begin
       Cells[1,0]:=FloatToStrF(LevelUAM,fffixed,5,2);
       Cells[1,6]:='';//FloatToStrF(ExtremAmplitude,fffixed,5,2);
       Cells[1,7]:=IntToStr(MaxAmp_M);
       Cells[1,8]:=Format('%f',[1-LandingSetPoint]);//'Landing Set point';
      end;
      Cells[1,1]:=Format('%f',[ZGateMax]);//'ZGate max, nm';
      Cells[1,2]:=Format('%f',[ZGateMin]);//'Gate min, nm';
      Cells[1,3]:=Format('%d',[ScannerDecay]);//'Scanner Delay, ms';
      Cells[1,4]:=Format('%d',[IntegratorDelay]); //'Mover Delay, ms';
//      Cells[1,5]:=Format('%d',[FreqBandR]); //'Frequency Band Rough';
      Cells[1,5]:=Format('%d',[ZUpStepsNumb]);//'Z Steps Number';
      Cells[1,6]:=Format('%d',[ZFastStepsNumb]);//'Z Steps Number';
//      Cells[1,10]:=Format('%d',[FreqBandF]);//'FB loop gain';
  //    ComboBoxVideo.Items.add(OrVideoProgram);


    case ApproachParams.TypeMover of
  0:begin                             //stepmotor;
      ComboBoxT.ItemIndex:=0;
      PanelPMTime.visible:=false;
    end;
  1:begin    //piezomotor
      ComboBoxT.ItemIndex:=1;
      PanelPMTime.visible:=true;
      ScrollBarPMTime.Position:=ApproachParams.PMActiveTime;
      LabelPMTime.Caption:=inttostr(ScrollBarPMTime.Position);
      ScrollBarPMPause.Position:=ApproachParams.PMPause;
      LabelPause.Caption:=inttostr(ScrollBarPMPause.Position);
    end;
         end;
    end;
      
  end;
  EditImaxCut.Text:=FloatToStrF(ApproachParams.IMaxCut,fffixed,5,3);
  ComboBoxT.Enabled:=false;
  CheckBoxControlTopPosition.Visible:= (flgUnit=nano) or (flgUnit=Pipette) or (flgUnit=Terra) or (flgUnit=ProBeam) or (flgUnit=MicProbe);
  CheckBoxControlTopPosition.checked:=ApproachParams.flgControlTopPosition
end;

procedure TApproachOpt.CboxZLinSelect(Sender: TObject);
begin
    case  CBoxZLin.ItemIndex of
  0:begin
     ScannerCorrect.FlgZLinear:=true;
     labelabs.Visible:=true;
     CBoxZLinAbs.visible:=true;
    end;
   1:begin
      ScannerCorrect.FlgZLinear:=false;
      labelabs.Visible:=false;
      CBoxZLinAbs.visible:=false;
     end;
   end;
end;

function TApproachOpt.ChangeMaxArea:boolean;
begin
  with   ScannerCorrect do
  begin
        result:=false;
     if  YBiasTanOpen<>YBiasTan   then result:=true;   // tang of angle between OY and Y-Section (22.01.03, Olya)
     if  SensitivXOpen<>SensitivX then result:=true;
     if  SensitivYOpen<>SensitivY then result:=true;
  end;
    flgNew_XYBegin:=True;
end;


procedure TApproachOpt.ApproachOptGridKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
 if ((Key=ord('O')) and (ssAlt in Shift)) then
  begin
   ApproachOptGrid.Options:= [(goFixedHorzLine),(GoEditing)];//:=True;
   EditedSheet:=1;
  end;
end;

procedure TApproachOpt.CancelBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TApproachOpt.OKBtnClick(Sender: TObject);
var      i:integer;
    NXYMax:integer;
    CZTune:word;
   CXYTune:word;
   XMaxTmp,YMaxTmp:single;
   flgOldBlock:Boolean;
   savemode:integer;
begin
 ApproachParams:=ApproachParamsEdited;
 ApproachParams.IMaxCut:=StrToFloat(EditImaxCut.Text);
 if flgRenishawUnitExists then
  begin
    RenishawParams.RenishawScale:=StrToFloat(EdRenishawPeriodKoef.Text);
     case cbRenishawType.ItemIndex of
     0:  RenishawParams.RenishawPeriod:=20;
     1:  RenishawParams.RenishawPeriod:=100;
              end;
       RenishawParams.Period_nm:= RenishawParams.RenishawScale* RenishawParams.RenishawPeriod;
       RenishawParams.LineToLineTimemk:= StrToInt(EdLineToLineTime.Text);
      if cbflgLineToLineTime.Checked then
          begin
             RenishawParams.flgLineToLineTime:=true;
             RenishawParams.LineToLineTimemk:= StrToInt(EdLineToLineTime.Text);
          end
          else  RenishawParams.flgLineToLineTime:=false;
  end;
 if  assigned(ScanWnd) and  (ScanParams.ScanMethod=Spectr) then
 begin
    siLangLinked1.MessageDlg(stre4{'Spectroscopy Regime is Active!! Parameters changing is not saved.'}, mtInformation,[mbOk],0);
    Close;
 end
 else
 begin
  with ApproachParams do
  begin
   if STMFlg then
    begin
         LevelIT:=StrToFloat(ApproachOptGrid.Cells[1,0])/ITCor;  //101210
         if flgUnit<>pipette then ScaleMaxIT:=StrToFloat(ApproachOptGrid.Cells[1,8])
                             else MaxITIndicator:=round(StrToFloat(ApproachOptGrid.Cells[1,8])) ;
         ApproachParams.IMaxCut:=StrToFloat(EditImaxCut.Text);
    end
    else
    begin
      LevelUAM:= StrToFloat(ApproachOptGrid.Cells[1,0]);
      MaxAmp_M:= round(StrToFloat(ApproachOptGrid.Cells[1,7]));
    end;
    CurVideoProgram:=ComboBoxVideo.Text;
     OrVideoCaption:=edOrVideoCapture.Text;
           ZGateMax:=StrToFloat(ApproachOptGrid.Cells[1,1]);
           ZGateMin:=StrToFloat(ApproachOptGrid.Cells[1,2]);
       ScannerDecay:=StrToInt(ApproachOptGrid.Cells[1,3]);
    IntegratorDelay:=StrToInt(ApproachOptGrid.Cells[1,4]);
       ZUpStepsNumb:=abs(StrToInt(ApproachOptGrid.Cells[1,5]));
     ZFastStepsNumb:=abs(StrToInt(ApproachOptGrid.Cells[1,6]));
  //   FreqBandF:=StrToInt(ApproachOptGrid.Cells[1,10]);
     flgControlTopPosition:=CheckBoxControlTopPosition.checked;
  end;
if flgCurrentUserLevel<>Demo then
 begin
   NXYMax:=StrToInt(ScanOptGrid.Cells[1,11]);
   if (NXYMax<>prevNXYMax) then
   begin
    LinePointsMax:=NXYMax;
    ScanSizeMax:=NXYMax;
    ScanParams.NX:=100;
    ScanParams.NY:=100;
   end;
 end;
    for i:=0 to 12 do
     with CSPMSignalsTab do
      begin
       CSPMSignals[i+1].MinV:=StrToFloat(Cells[1,i]);
       CSPMSignals[i+1].MaxV:=StrToFloat(Cells[2,i]);
       CSPMSignals[i+1].DeviceClass:=StrToInt(Cells[3,i]);
       CSPMSignals[i+1].MinDiscr:=StrToInt(Cells[4,i]);
       CSPMSignals[i+1].ZeroVal:=StrToInt(Cells[5,i]);
       CSPMSignals[i+1].MaxDiscr:=StrToInt(Cells[6,i]);
      end;
     with ScannerCorrect do
      begin
         FlgXYLinear:=CBoxXYLin.Text='True';
         FlgZLinear:=CBoxZLin.Text='True';
         FlgPlnDel:=CBoxDelP.Text='True';

         FlgHideLine:=CBoxHideLine.Text='True';
          YBiasTan:=tan(pi*strToFloat(edYSectAngle.text)/180);
         SensitivZ:=StrToFloat(edSensZ.Text);
         SensitivX:=StrToFloat(edSensX.Text);
         SensitivY:=StrToFloat(edSensY.Text);
         I_VTransfKoef:=StrToFloat(edI_VTransf.Text);
         NonLinFieldX:=StrToInt(edNonLinRgX.text);
         NonLinFieldY:=StrToInt(edNonLinRgY.text);
         GridCellSize:=StrToInt(edGrateStep.text);
      end;
  ////////////////////////////////
        TransformUnitInit ;
 ////////////////////////////////
    with ScannerCorrect do
      begin
      // DZdclnX:=strToFloat(edtanX.text);//*TransformUnit.Znm_d/TransformUnit.Xnm_d;
      // DZdclnY:=strToFloat(edtanY.text);//*TransformUnit.Znm_d/TransformUnit.Ynm_d;
      end;
 //    HardWareOpt.ScannerNumb:=cbScannerNum.Text;
 //    HardWareOpt.ElectronicNumb:=cbElectronicNum.Text;
     TestErrorScannerIniFile;
     flgSaveProcess:=true;

    if flgCurrentUserLevel<>Demo then
    begin
//     if flgAdmin then SaveConfig;
     SaveConfigUsers;
    end;

    if ScanParams.ScanPath=0 then     StoreScannerOpt( ScannerOptModX, ScannerOptModY,PAdapterOptModX,PAdapterOptModY)
                             else     StoreScannerOpt( ScannerOptModY, ScannerOptModX,PAdapterOptModY,PAdapterOptModX);

    if FlgCurrentUserLevel<> Demo then
     begin
     //  ApprLinesParamsCalc(HardWareOpt.ScannerNumb);       // 09/09/2016
       ApprLinesParamsCalcFromAdapter;
       SetXYMax;
     end;

    if ChangeMaxArea then
     begin
//       RenishawParamsDef;
//       RenishawParamsLast;
       savemode:=ScanParams.ScanPath;
       SetScanParamsDef;
       ScanParams.ScanPath:=savemode;
     end;
      ScanParams.ScanDelay :=strToInt(EditScanDelay.text);
      ScanParams.LithoDelay:=strToInt(EditLithoDelay.text);
     flgSaveProcess:=false;
// Save Parameters for New Scanner;
     flgOldBlock:=False;
 with  cbScannerNum do
  begin
    for i:=0 to Items.Count-1 do
     if Items[i]=cbScannerNum.Text then
      begin
          flgOldBlock:=True;
          break;
      end;
  if ((Text<>'') and (not flgOldBlock )) then
    begin
       Items.Add(Text);
    end;
  end;
// Save Parameters for New Electronic;
   flgOldBlock:=False;
 with  cbElectronicNum do
    begin
      for i:=0 to Items.Count-1 do
        if Items[i]=cbElectronicNum.Text then
          begin
           flgOldBlock:=True;
           break;
          end;
      if ((Text<>'') and (not flgOldBlock )) then
        begin
          Items.Add(Text);
        end;
    end;

if assigned(Approach) then
  begin
    with ApproachParams do
     begin
         case STMFlg of
 False:begin
//        NanoEdu.ScannerApproach.SetLevel;// SetCommonVar(CLevel,round(ApproachParams.UAMMax*LevelUAM));
//        NanoEdu.SetPoint:=round(LandingSetPoint*UAMMax);
        with Approach.SignalIndicator do
         begin
          HighLimit:=round(LevelUAM*ApproachParams.UAMMax);
          LowLimit:=round(ApproachParams.LandingSetPoint*ApproachParams.UAMMax);
         end;
        Approach.SignalsMode.LbSuppress.Caption:=FloattoStrF((1-LandingSetPoint),fffixed,4,2);
        Approach.SignalsMode.LbSuppressI.Caption:=FloattoStrF((1-LandingSetPoint),fffixed,4,2);
      end;
 True:begin
  //      NanoEdu.ScannerApproach.SetLevel;
  //      NanoEdu.SetPoint:=ApiType(-round(ApproachParams.LandingSetPoint*TransformUnit.nA_d));
        SetPoint:=LandingSetPoint;
       with Approach.SignalIndicator do
         begin
         // if flgUnit=pipette then
          Maximum:=round(MaxITIndicator*MaxApitype/100); //101210
         //                    else Maximum:=round(abs(LandingSetPoint*TransformUnit.nA_d*ScaleMaxIT){/ITCor});//101210
           HighLimit:=round(abs(LevelIT*TransformUnit.nA_d){/ITCor}); //101210
           LowLimit:=round(ApproachParams.SetPoint*TransformUnit.nA_d{/ITCor}); //101210
          end;
         Approach.SignalsMode.btnSetPoint.Caption:=FloattoStrF(LandingSetPoint*ITCor,fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_18' (* ' nA' *) );//101210
      end;
        end;  //case
    if Assigned(Nanoedu.Method) and (Nanoedu.Method is TApproachSFM) then    Nanoedu.Method.SetUsersParams;
    Approach.ZIndicator.HighLimit:=round(ZGateMax*Approach.ZMaxAbility);
    Approach.ZIndicator.LowLimit :=round(ZGateMin*Approach.ZMaxAbility);
    ApproachParams.ZMax:=(CSPMSignals[7].MaxDiscr-CSPMSignals[7].MinDiscr)/TransformUnit.Znm_d;     //edited  03/06/16
    Approach.LabelZMax.caption:='1 ('+FloattoStrF((round(ApproachParams.ZMax/100)/10),ffFixed,4,1)+' '+mcrn+')';
   end;
  end;     //approach wnd

  if assigned(ScanWND) then
  begin
    ScanWnd.ScanAreaUpdate;
    ScanWnd.ZIndicatorScan.HighLimit:=round(ApproachParams.ZGateMax*MaxApiType);
    ScanWnd.ZIndicatorScan.LowLimit:=round(ApproachParams.ZGateMin*MaxApiType);
            case STMFlg of
 False:begin
        NanoEdu.SetPoint:=ApproachParams.SetPoint;(*ApproachParams.UAMMax))*); //190912
       end;
 True: begin
        ApproachParams.LandingSetPoint:=ApproachParams.SetPoint;
        NanoEdu.SetPoint:=ApiType(round(ApproachParams.SetPoint*TransformUnit.nA_d));
        NanoEdu.ImaxCut:=round(ApproachParams.ImaxCut*dbltoint);
       end;
                end;  //case
  end;   //scan wnd
  LoadLinSplineFromAdapter(); // заменено 25/04/2013
  Close;
 end;
end;

procedure TApproachOpt.SetScannerNumSheetInit;
begin
(*  CheckBoxFlash.Checked:=HardWareOpt.FlgFlash;
  CheckBoxFlash.Visible:=HardWareOpt.FlgFlash;
  CheckBoxFlash.Enabled:= not HardWareOpt.FlgFlash;
  if HardWareOpt.FlgFlash then  HardWareOpt.FlgAutoScanner:=0;
      case  HardWareOpt.FlgAutoScanner of
  1:   begin //auto
              RadioGroup.ItemIndex:=0;
              cbElectronicNum.enabled:=False
       end;
  0:   begin  //manual
              RadioGroup.ItemIndex:=1;
              cbElectronicNum.enabled:=True
       end;
               end;
      RadioGroup.Enabled:=not CheckBoxFlash.Checked;
  *)
      LabelScanNmb.Caption:=siLangLinked1.GetTextOrDefault('IDS_19' (* 'Scanner Number =' *) )+HardWareOpt.ScannerNumb;
//      CbScannerNum.Enabled:=not CheckBoxFlash.Checked;
end;
procedure TApproachOpt.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TApproachOPt.OscGridInit;
var i,j:integer;
begin
       for J:= 0 to GridOSC.RowCount - 1 do
        begin
          GridOSC.RowHeights[j]:=30;
        end;
        GridOsc.height:=GridOSC.RowCount*GridOSC.RowHeights[0]+15;
        GridOsc.width:=240+140+15;
  with GridOSC do
  begin
     ColWidths[0]:=120;
     ColWidths[1]:=70;
     ColWidths[2]:=120;
     ColWidths[3]:=70;
     Cells[0,0]:='Signal';
     Cells[0,1]:=osc00;
     Cells[0,2]:=osc01;
     Cells[0,3]:=OSC02;
     Cells[0,4]:=OSC03;
     Cells[0,5]:=OSC04;
     Cells[0,6]:=OSC05;
     Cells[0,7]:=OSC06;
     Cells[0,8]:=OSC07;
     Cells[0,9]:=OSC08;

     Cells[1,0]:='Address';
     Cells[1,1]:='0x00';
     Cells[1,2]:='0x01';
     Cells[1,3]:='0x02';
     Cells[1,4]:='0x04';
     Cells[1,5]:='0x06';
     Cells[1,6]:='0x08';
     Cells[1,7]:='0x0A';
     Cells[1,8]:='0x0D';
     Cells[1,9]:='0x0F';

     Cells[3,0]:='Address';
     Cells[3,1]:='0x17';
     Cells[3,2]:='0x18';
     Cells[3,3]:='0x19';
     Cells[3,4]:='0x13';

     Cells[2,0]:='Signal';
     Cells[2,1]:=OSC20;
     Cells[2,2]:=OSC21;
     Cells[2,3]:=OSC22;
     Cells[2,4]:=OSC23;
  end;
end;

procedure TApproachOpt.ScanOptGridExit(Sender: TObject);
var nxt:integer;
begin
 if ScanOptGrid.Cells[1,11]='' then  siLangLinked1.MessageDlg(scan36 (* 'error input NX' *) ,mtWarning,[mbOk],0)
 else
 begin
  try
  {$I-}
  nxt:=StrToInt(ScanOptGrid.Cells[1,11]);
  if nxt>4096 then
   begin
    siLangLinked1.MessageDlg('Nx<=4096',mtWarning,[mbOk],0);
    nxt:=4096;
    ScanOptGrid.Cells[1,11]:=inttostr(nxt);
   end;
  except
    on EConvertError do
     begin
      siLangLinked1.MessageDlg(scan36(* 'error input NX' *),mtWarning,[mbOk],0);
      ScanOptGrid.Cells[1,11]:='1024';
    end;
  end;
   {$I+}
 end;
end;


procedure TApproachOpt.ScanOptGridInit;
var XMaxTmp,YMaxTmp:single;
begin
if FlgCurrentUserLevel=Demo then
  ScanOptGrid.Options:=ScanOptGrid.Options-[goEditing];

 with ScanOptGrid do
  begin
     ColWidths[0]:=220;
     ColWidths[1]:=70;
     Cells[0,0]:=SCells00;
     Cells[0,1]:=SCells01;
     Cells[0,2]:=SCells02;
     Cells[0,3]:=SCells03;
     Cells[0,4]:=SCells04;
     Cells[0,5]:=SCells05;
     Cells[0,6]:=SCells06;
     Cells[0,7]:=SCells07;
     Cells[0,8]:=SCells08;
     Cells[0,9]:=SCells09;
     Cells[0,10]:=SCells010;
     Cells[0,8]:=SCells011;
     Cells[0,9]:=SCells012;
     Cells[0,10]:=SCells013;
     Cells[0,11]:=SCells014;
     Cells[1,0]:=Format('%d',[round(ScanParams.X)]);
     Cells[1,1]:=Format('%d',[round(ScanParams.Y)]);
     if HardWareOpt.XYtune='Fine' then
       begin
        Cells[1,2]:=Format('%6.1f',[ScanParams.XBegin]);
        Cells[1,3]:=Format('%6.1f',[ScanParams.YBegin]);
       end
     else
       begin
        Cells[1,2]:=Format('%d',[round(ScanParams.XBegin)]);
        Cells[1,3]:=Format('%d',[round(ScanParams.YBegin)]);
       end;
     Cells[1,4]:=Format('%d',[ScanParams.Nx]);
     Cells[1,5]:=Format('%d',[ScanParams.Ny]);
     Cells[1,6]:=Format('%d',[round(ScanParams.ScanRate)]);
     case ScanParams.ScanPath of
    0: Cells[1,7]:='X+';//Format('%d',[ScanParams.ScanPath]);
    1: Cells[1,7]:='Y+';//Format('%d',[ScanParams.ScanPath]);{X+:0,Y+:1,multi:2}
    2: Cells[1,7]:='Multi';//Format('%d',[ScanParams.ScanPath]);
           end;
     Cells[1,8]:=Format('%d',[ScanParams.Microstep]);
     Cells[1,9]:=Format('%d',[ScanParams.MicrostepDelay]);
     Cells[1,10]:=Format('%d',[ScanParams.xMicrostepNmb]);
     if FlgCurrentUserLevel<> Demo then
      begin
         //ApprLinesParamsCalc(HardWareOpt.ScannerNumb);    //09/09/2016
          ApprLinesParamsCalcFromAdapter;
         SetXYMax;
      end;
     Cells[1,8]:=Format('%d',[round(ScanParams.Xmax)]);
     Cells[1,9]:=Format('%d',[round(ScanParams.Ymax)]);
     if HardWareOpt.XYtune='Fine' then  Cells[1,10]:=Format('%6.1f',[ScanParams.StepXY])
                                  else  Cells[1,10]:=Format('%d',[round(ScanParams.StepXY)]);
     Cells[1,11]:=Format('%d',[LinePointsMax]);
  end;
     EditLithoDelay.Text:=IntToStr(ScanParams.LithoDelay);
     EditScanDelay.Text :=IntToStr(ScanParams.ScanDelay);
end;

procedure TApproachOpt.ScanOptGridKeyPress(Sender: TObject; var Key: Char);
begin
    if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure   TApproachOpt.RenishawSheetInit;
begin
 EdRenishawPeriodKoef.Text:=FloatToStrF(RenishawParams.RenishawScale, fffixed,5,2);
 CbflgLineToLineTime.Checked:= RenishawParams.flgLineToLineTime;
 EdLineToLineTime.Enabled:= RenishawParams.flgLineToLineTime;
 EdLineToLineTime.Text:=IntToStr(RenishawParams.LineToLineTimemk);
 RenishawParams.SlowAxisScanRate:= 1000000*ScanParams.StepXY /RenishawParams.LineToLineTimemk;
 LabelSlowAxisRate.Caption:=FloatTostrF(RenishawParams.SlowAxisScanRate,fffixed,10,0);
case RenishawParams.RenishawPeriod of
     20:   cbRenishawType.ItemIndex:=0;
     100:  cbRenishawType.ItemIndex:=1
     else  cbRenishawType.ItemIndex:=1;
   end;
case RenishawParams.RenishawPeriod of
     20:   PanelBufferLen.Enabled:=true;
     100:  PanelBufferLen.Enabled:=False
     else  PanelBufferLen.Enabled:=False;
   end;
case RenishawParams.noiseW_discr of
   10: cbBufferLen.ItemIndex:=0;
   15:  cbBufferLen.ItemIndex:=1;
   20:  cbBufferLen.ItemIndex:=2
   else cbBufferLen.ItemIndex:=2;
 end;
end;

procedure TApproachOpt.SbdTScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
     PidParams.dT:=sbdT.Position{*PidParams.dTAbsMax/sbdT.Max};
     LabeldT.Caption:=IntToStr(PidParams.dT);
     if ScrollCode = scEndScroll then    NanoEdu.SetPIDParameters;
end;

procedure TApproachOpt.sbTdScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
   if RadioGroupTd.ItemIndex = 0 then           // rough
         begin
           PidParams.Td:= sbTd.Position *PidParams.TdAbsMax/sbTd.Max;
           if (ScrollCode = scEndScroll) and flgStopScan  then    NanoEdu.SetPIDParameters;
         end
          else
               begin//fine

               PidParams.Td:=PidParams.pidTeL1+sbTd.Position*(PidParams.pidTdL2-PidParams.pidTdL1)/sbTd.Max;
               if ScrollCode = scEndScroll then    NanoEdu.SetPIDParameters;
               end;
   labelTd.Caption:=FloattoStrF(PidParams.Td, fffixed,5,2);
end;

procedure TApproachOpt.sbTeScroll(Sender: TObject; ScrollCode: TScrollCode;  var ScrollPos: Integer);
begin
   if RadioGroupTe.ItemIndex = 0 then           // rough
        begin
           PidParams.Te:= sbTe.Position *PidParams.TeAbsMax/sbTe.Max;
           if (ScrollCode = scEndScroll) and flgStopScan  then    NanoEdu.SetPIDParameters;
        end
          else
               begin //fine
                 PidParams.Te:=PidParams.pidTeL1+sbTe.Position*(PidParams.pidTeL2-PidParams.pidTeL1)/sbTe.Max;
                 if ScrollCode = scEndScroll then    NanoEdu.SetPIDParameters;
               end;
    labelTe.Caption:=FloattoStrF(PidParams.Te, fffixed,5,2);
end;

procedure TApproachOpt.DefaultBtnClick(Sender: TObject);
begin
if PageControl.ActivePage=HardWareSheet then ControllerOptLast(ControllerDefIniFile);
if PageControl.ActivePage=ApprOptSheet  then ApproachParamsDef;//ApproachParamsLast(ConfigDefIniFile);
if PageControl.ActivePage=ScanOptSheet  then SetScanParamsDef;
if PageControl.ActivePage=ScanCorSheet  then
   begin
    LoadScannerOptGeneral(ScannerDefIniFileX,ScannerDefIniFileY);
    ScannerCorrectLast();
    TransFormUnitInit;
    ScanCorrSheetInit;
    if assigned(ScanWNd) then
    begin
         ScanWnd.ScanAreaUpdate;
    end;
   end;
if self.HardWareSheet.TabVisible then   HardWareSheetInit;
   ApproachSheetInit;
   ScanOptGridInit;
   RenishawSheetInit;
end;

procedure TApproachOpt.EdTanXKeyPress(Sender: TObject; var Key: Char);
begin
 if not(Key in ['-','0'..'9',DecimalSeparator,#8]) then Key :=#0 ; //#8 backspace
end;

procedure TApproachOpt.EdTanYKeyPress(Sender: TObject; var Key: Char);
begin
 if not(Key in ['-','0'..'9',DecimalSeparator,#8]) then Key :=#0 ;
end;

procedure TApproachOpt.ScanCorrSheetInit;
var            i:integer;
 YSectionBias:single;
      iniCSPM:TIniFile;
        sFile:string;
begin
 sFile:=ScannerIniFilesPath+ ScannerIniFile;
 with ScannerCorrect do
  begin
       if FlgXYLinear  then  CBoxXYLin.Itemindex:=0
                       else  CBoxXYLin.Itemindex:=1;
       if FlgZLinear  then  CBoxZLin.Itemindex:=0
                       else  CBoxZLin.Itemindex:=1;

        if FlgZLinAbs  then  CBoxZLinAbs.Itemindex:=0
                       else  CBoxZLinAbs.Itemindex:=1;

       if FlgPlnDel    then  CBoxDelP.ItemIndex:=0
                       else  CBoxDelP.ItemIndex:=1;
       if FlgHideLine  then  CBoxHideLine.ItemIndex:=0
                       else  CBoxHideLine.ItemIndex:=1;

  if (flgUnit = PROBEAM) or (flgUnit=MicProbe) then
  begin
     CBoxZLin.Visible :=true;
     CBoxZLinAbs.Visible:=true;
     Labelabs.Visible:=true;
     LabelZlin.Visible:=true;
  end
  else
  begin
     CBoxZLin.Visible :=false;
     CBoxZLinAbs.Visible:=false;
     Labelabs.Visible:=false;
     LabelZlin.Visible:=false;
  end ;

 case  CBoxXYLin.ItemIndex of
  0:begin
     ComboBoxLinE(true);
    end;
  1:begin
     ComboBoxLinE(false);
    end;
               end;

     ComboBoxLvlDel.Itemindex:=integer(not ScanParams.flgTopoLevelDel);
     YSectionBias:=180*arctan2(YBiasTan,1)/pi;
     edYSectAngle.text:=FloatToStrF(YSectionBias,ffFixed,4,2);
     edSensZ.Text:=FloatToStrF(SensitivZ,ffFixed,6,2);
     edSensX.Text:=FloatToStrF(SensitivX,ffFixed,6,2);
     edSensY.Text:=FloatToStrF(SensitivY,ffFixed,6,2);
  //    edTanX.text:=FloatToStrF(DZdclnX,ffFixed,4,2);
  //    edTanY.text:=FloatToStrF(DZdclnY,ffFixed,4,2);
     edI_VTransf.Text:=FloatToStrF(I_VTransfKoef,ffFixed,3,0);
     edNonLinRgX.text:=IntToStr(NonLinFieldX);
     edNonLinRgY.text:=IntToStr(NonLinFieldY);
     edGrateStep.text:=IntToStr(GridCellSize);
     LabelNmbCntr.caption:=ValueControllerNum.Caption;
 end;
 iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
   begin
    ReadSections(cbScannerNum.Items);
    if  not SectionExists(HardWareOpt.ScannerNumb) then
    if siLangLinked1.MessageDlg(stre{' No data for '}+ HardWareOpt.ScannerNumb+
                   stre1{' in '}+ScannerIniFile+stre7{' Add new Scanner?'},mtConfirmation ,[mbYes, mbNo],0)= mrYes
                then  with  cbScannerNum do    Items.Add(HardWareOpt.ScannerNumb);
  end;
   case ScanParams.ScanPath of
   0: begin ScanCorSheet.Caption:=siLangLinked1.GetTextOrDefault('IDS_48' (* 'Scanner Parameters: Path Mode X' *) ); ComboBoxPath.itemIndex:=0; end;
   1: begin ScanCorSheet.Caption:=siLangLinked1.GetTextOrDefault('IDS_49' (* 'Scanner Parameters: Path Mode Y' *) ); ComboBoxPath.itemIndex:=1; end;
      end;
      for i:=0 to cbScannerNum.Items.Count-1 do
       if lowercase(HardWareOpt.ScannerNumb)=lowercase(cbScannerNum.Items[i]) then
         begin
            cbScannerNum.ItemIndex:=i;
         end;
   if FlgLinVisible then
                    begin
                     LabelLinOn.Visible:=True;
                     LabelLinOn.Caption:=siLangLinked1.GetTextOrDefault('IDS_50' (* 'Linearization On' *) );
                    end
                    else
                    begin
                     LabelLinOn.Caption:=siLangLinked1.GetTextOrDefault('IDS_51' (* 'Linearization Off' *) );
                     LabelLinOn.Visible:=false;
                    end;
  finally
   iniCSPM.Free;
  end;
end;

procedure TApproachOpt.BitBtnViewLinCurvClick(Sender: TObject);
begin
//if flgReLoadSpline  then
(*case CbLinCurvesSource.ItemIndex of
  0: begin end;     // Current Curves from memory (XYSp, YYSp)
  1: LoadLinSpline(HardWareOpt.ScannerNumb);  // Read from Base
  2: LoadLinSplineFromAdapter;         // ReadFromAdapter   structures : PAdapterLinModXAxisX^, .. etc
end; *)
   ScannerCorrVisual:=TScannerCorrVisual.Create(self);
   ScannerCorrVisual.Caption:='Current Curves ';
(*  case CbLinCurvesSource.ItemIndex of
  0: begin ScannerCorrVisual.Caption:='Current Curves ' end;     // Current Curves from memory (XYSp, YYSp)
  1: ScannerCorrVisual.Caption:='Curves from Base';  // Read from Base
  2: ScannerCorrVisual.Caption:='Curves from Adapter Structure';
  end; *)
end;

procedure TApproachOpt.BitBtnWriteControllerClick(Sender: TObject);
begin
  BitBtnWriteController.Enabled:=false;
  NanoEdu.Method:=TSetControllerParams.Create;
  NanoEdu.Method.Launch;
end;

procedure TApproachOpt.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
   Action := caFree;
   ApproachOpt:=nil;
end;

procedure TApproachOpt.ScanOptGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
	r : integer;
	c : integer;
begin
 	ScanOptGrid.MouseToCell(X, Y, C, R);
	with ScanOptGrid do
		begin
     if (C=1) then
      begin
  		 	if ((Row <> R) ) then
				begin
		 			Row := R;
       		Col := C;
					Application.CancelHint;
					ScanOPtGrid.Hint :=HintScanGrid[R];
				end;
	    end;
   end;
end;

procedure TApproachOpt.CBoxXYTuneChange(Sender: TObject);
begin
      with ScanParams do
begin
            case  CBoxXYTune.ItemIndex  of
0:    begin
              X:=  ScanAreaStartXR;
              Y:=  ScanAreaStartYR;

              HardwareOPt.XYTune:='Rough';
       end;
1:     begin
              X:=  ScanAreaStartXF;
              Y:=  ScanAreaStartYF;

              HardwareOPt.XYTune:='Fine';
        end
             end;      //case

              XBegin:=10;
              YBegin:=10;
              NX:=100;
              NY:=100;
end;
   ScanOptGrid.Cells[1,0]:=Format('%f',[ScanParams.X]);
   ScanOptGrid.Cells[1,1]:=Format('%f',[ScanParams.Y]);
end;

procedure TApproachOpt.CBoxZLinAbsSelect(Sender: TObject);
begin
  case  CBoxZLinAbs.ItemIndex of
  0:begin
     ScannerCorrect.FlgZLinAbs:=true;
    end;
  1:begin
     ScannerCorrect.FlgZLinAbs:=false;
    end;
   end;


end;

procedure TApproachOpt.ApproachOptGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
	R : integer;
	c : integer;
begin
 	ApproachOptGrid.MouseToCell(X, Y, C, R);
	with ApproachOptGrid do
		begin
    if (c=1) then
     begin
			if ((Row <> r) ) then
				begin
					Row := r;
					Col := c;
					Application.CancelHint;
					ApproachOPtGrid.Hint :=HintApproachGrid[r];
				end;
	   end;
   end;
end;

procedure TApproachOpt.edNewElectronicChange(Sender: TObject);
begin
  { TODO : 011208-5 }
(*      if not HardWareOpt.flgNewElectronic then
       begin
            case  ApproachParams.FreqBandR of
            1:   ApproachParams.FreqBandR:=6;
            2:   ApproachParams.FreqBandR:=5;
            4:   ApproachParams.FreqBandR:=3;
               end;
        end
        else
        begin
            case  ApproachParams.FreqBandR of
            6:   ApproachParams.FreqBandR:=1;
            5:   ApproachParams.FreqBandR:=2;
            3:   ApproachParams.FreqBandR:=4;
                 end;
        end ;
  *)
        ApproachSheetInit
 end;

procedure TApproachOpt.BitBtn1Click(Sender: TObject);
begin
  if STMFlg then HlpContext:=	IDH_Parameters  else HlpContext:=IDH_paramers_SSM;
  Application.HelpContext(HlpContext)
end;
procedure TApproachOpt.BitBtnReadControllerClick(Sender: TObject);
begin
 BitBtnReadController.Enabled:=false;
 Nanoedu.GetControllerParams;
 while  assigned(Nanoedu.Method) do application.processmessages;
 ControllerSheetInit;
 BitBtnReadController.Enabled:=true;
end;

procedure TApproachOpt.BitBtnSaveAdapterClick(Sender: TObject);
begin
 BitBtnSAVEClick(Sender);
 AdapterService:=TAdapterService.Create(self);
 AdapterService.ShowModal;
end;

(*
procedure TApproachOpt.BitBtn2Click(Sender: TObject);
begin
   NanoEdu.Method:=TTestTI.Create;
   if NanoEdu.Method.Launch<>0 then ;
   sleep(3000);
  LabelT_I.Caption:=inttostr(Approachparams.IntegratorDelay);
  FreeAndNil(NanoEdu.Method);
end;
 *)
procedure TApproachOpt.ApproachOptGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var ACol,ARow:integer;
  begin
   ApproachOptGrid.MouseToCell(X, Y,ACol, ARow) ;
  if ((ACol = 1) {AND      (ARow <> 5)} ) then
   begin
       if (STMFlg) then
        begin
         SetGridParam:=TSetGridParam.Create(self);
         SetGridParam.NRow:=ARow;
         SetGridParam.Top:= Top+ApproachOptGrid.Top+Y;
         SetGridParam.Left:=Left+ApproachOptGrid.left+X;
         SetGridParam.ShowModal;
           with ApproachOptGrid do
            begin
              cells[1,ARow]:=SetGridParam.LabelValue.Caption;
            end;
            if {(flgunit=pipette)and }(ARow=9) then
             if ApproachParamsEdited.LandingSetPoint*TransformUnit.nA_d>ApproachParamsEdited.MaxITindicator then
              begin
              //    ApproachParamsEdited.LandingSetPoint*TransformUnit.nA_d:=ApproachParamsEdited.MaxITindicator
                  silangLinked1.MessageDlg(siLangLinked1.GetTextOrDefault('IDS_57' (* 'Increase maximal value on the indicator of the curent!' *) )  ,mtWarning ,[mbOK],0)
              end;
        end
        else
        begin
  //   if (AROW<>8)
 //       then
         SetGridParam:=TSetGridParam.Create(self);
         SetGridParam.NRow:=ARow;
         SetGridParam.Top:= ApproachOpt.Top+ApproachOptGrid.Top+Y;
         SetGridParam.Left:=ApproachOpt.Left+ApproachOptGrid.left+X;
         SetGridParam.ShowModal;
          with ApproachOptGrid do
            begin
              cells[1,ARow]:=SetGridParam.LabelValue.Caption;
            end;
        end ;
   end;
end;

procedure TApproachOpt.CBoxZTuneChange(Sender: TObject);
begin
 (*      case  CBoxZTune.ItemIndex  of
0:  HardwareOPt.ZTune:='Rough';
1:  HardwareOPt.ZTune:='Fine';
             end;
   { TODO : 020908 }
//       HardwareOPt.ZTune:=CBoxZTune.Text;
*)
end;

procedure TApproachOpt.BitBtnEditIniClick(Sender: TObject);
var windowsdir:Pchar;
begin
   GetMem(windowsdir,Max_path);
   GetWindowsDirectory(windowsdir,Max_Path);
   ExecAndWait(windowsdir+'\notepad.exe' , Pchar(ConfigIniFilePath + ConfigIniFile),{SWP_NOMOVE or} SW_showNORMAL);
   UpdateOption;
   FreeMem(windowsdir);
   OKBtnClick(Sender);
end;

procedure TApproachOpt.BBtnScannnerIniClick(Sender: TObject);
var windowsdir:Pchar;      // array[1..255] of Pchar
code:integer;
 Memo: TMemoScanner;
begin
   Memo:= TMemoScanner.Create(self,HardWareOpt.ScannerNumb, ScanParams.ScanPath);
try
   if Memo.ShowModal=mrOK then
   begin
    UpdateOption;
    OKBtnClick(Sender);
   end;
    { TODO : 261005 }
finally
  FreeAndNil(Memo);
end;
end;

procedure TApproachOpt.BBtnControllerIniClick(Sender: TObject);
var windowsdir:Pchar;
begin
   GetMem(windowsdir,Max_path);
   GetWindowsDirectory(windowsdir,Max_Path);
   ExecAndWait(Pchar(windowsdir)+'\notepad.exe', Pchar(ControllerIniFilePath + ControllerIniFile),SWP_NOMOVE or SW_showNORMAL);
   FreeMem(windowsdir);
   UpdateOption;
   OKBtnClick(Sender);
end;

procedure TApproachOpt.DeleteScannerClick(Sender: TObject);
 var SFile:string;
    iniCSPM:TiniFile;
    ss:string;
 begin
  sFile:=ScannerIniFilesPath + ScannerIniFile;
  iniCSPM:=TIniFile.Create(sFile);
 try
   ss:=cbScannerNum.Text;
    with iniCSPM do
     begin
        EraseSection(cbScannerNum.Text);
        cbScannerNum.DeleteSelected;
        cbScannerNum.itemindex:=0;
        cbScannerNumSelect(sender);
     end;
 finally
     iniCSPM.Free;
 end;
end;

procedure TApproachOpt.cbRenishawTypeChange(Sender: TObject);
begin
   case cbRenishawType.ItemIndex of
     0:  begin
           RenishawParams.RenishawPeriod:=20;
           PanelBufferLen.Enabled:=True;
         end;
     1:  begin
            RenishawParams.RenishawPeriod:=100;
            PanelBufferLen.Enabled:=False;
         end;
   end;
end;

procedure TApproachOpt.cbScannerNumChange(Sender: TObject);
begin
if cbScannerNum.text='' then  exit;
 SetLinSplineZero;
 HardWareOpt.ScannerNumb:=cbScannerNum.text;
 bitbtnSave.enabled:=(lowercase(HardWareOpt.ScannerNumb)<>'demo');
 BitBtnSaveAdapter.Enabled:=BitBtnSave.enabled;
 LabelScanNmb.Caption:=siLangLinked1.GetTextOrDefault('IDS_19' (* 'Scanner Number =' *) )+HardWareOpt.ScannerNumb;
 ScanCorSheet.RePaint;
end;

procedure TApproachOpt.cbBufferLenChange(Sender: TObject);
begin
  case cbBufferLen.ItemIndex of
     0: RenishawParams.noiseW_discr:=10;
     1: RenishawParams.noiseW_discr:=15;
     2: RenishawParams.noiseW_discr:=20;
  end;
end;

procedure TApproachOpt.cbElectronicNumChange(Sender: TObject);
begin
 if cbElectronicNum.text='' then   exit;
end;

procedure TApproachOpt.BtnDeleteControllerClick(Sender: TObject);
var   SFile:string;
      ss:string;
    iniCSPM:TiniFile;
begin
  ss:=cbElectronicNum.Text;
  sFile:=ControllerIniFilePath + ControllerIniFile;
  iniCSPM:=TIniFile.Create(sFile);
 try
    with iniCSPM do
     begin
        EraseSection(cbElectronicNum.Text);
        cbElectronicNum.DeleteSelected;
     end;
 finally
   iniCSPM.Free;
 end;
end;

procedure TApproachOpt.SetControllerName;
begin
 ValueControllerNum.Caption:=NanoEdu.ControllerNumber;
end;

procedure TApproachOpt.PageControlChange(Sender: TObject);
var i:integer;
begin
  with PageControl do
  begin
    for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
    ActivePage.HighLighted:=True;
  end;
end;

procedure TApproachOpt.BitBtnBrowserClick(Sender: TObject);
begin
     if OpenDialog.execute then
      begin
       ComboBoxVideo.Items.Add(Opendialog.FileName);
       Approachparams.OrVideoProgram:=Opendialog.FileName;
       ComboBoxVideo.Text:=Opendialog.FileName
      end;
end;

procedure TApproachOpt.ComboBoxVideoChange(Sender: TObject);
begin
   if  ComboBoxVideo.Text='DirectX' then
     begin
      edOrVideoCapture.Visible:=False;
      LabelOrVideoCaption.Visible:=False;
     end
   else
     begin
      edOrVideoCapture.Visible:=True;
      LabelOrVideoCaption.Visible:=True;
     end;  // ApproachParams.VideoProgram:= ComboBoxVideo.Text;
end;

procedure TApproachOpt.BitBtnVideoClick(Sender: TObject);
begin
   Application.HelpContext(5);
end;

procedure TApproachOpt.cbScannerNumSelect(Sender: TObject);
var ErCode:integer;
begin
  HardWareOpt.ScannerNumb:=cbScannerNum.text;
  LabelScanNmb.Caption:=siLangLinked1.GetTextOrDefault('IDS_19' (* 'Scanner Number =' *) )+HardWareOpt.ScannerNumb;
  bitbtnSave.enabled:=(lowercase(HardWareOpt.ScannerNumb)<>'demo');
  BitBtnSaveAdapter.Enabled:=BitBtnSave.enabled;
  ErCode:=TestErrorScannerIniFile;
  SetLinSplineZero;
       { TODO : 240406 }
// if (ErCode=0) then LoadLinSpline(HardWareOpt.ScannerNumb);
//  flgReLoadSpline:=false;
 if flgManualScanSelect then      // Protection from reading ini files on Create
 begin
   LoadScannerOptGeneral(ScanneriniFileX,ScanneriniFileY);
   ScannerCorrectLast();
   TransformUnitInit;
   ScanCorrSheetInit;
   ScanOptGridInit;
   RenishawSheetInit;
  if flgLinYScanner and flgLinXScanner then
  begin
   cBoxXYLin.Itemindex:=0;
   cBoxXYLin.Enabled:=true;
   ScannerCorrect.FlgXYLinear:=True;
  end
     else
      begin
          cBoxXYLin.Itemindex:=1;
          cBoxXYLin.Enabled:=false;
          ScannerCorrect.FlgXYLinear:=false;
     end;
    flgManualScanSelect:=false;
 end;    { TODO : 240406 }
  if (ErCode=0) then LoadLinSpline(HardWareOpt.ScannerNumb);
  flgReLoadSpline:=false;
//  Main.ActionAdjustOscExecute(Sender);
end;

procedure TApproachOpt.CbElectronicNumSelect(Sender: TObject);
begin
  HardWareOpt.ElectronicNumb:=cbElectronicNum.text;
  ControllerOptLast(ControllerIniFile);
//  HardWareSheetInit;
  TransformUnitInit;
  ScanOptGridInit;
  RenishawSheetInit;
end;

procedure TApproachOpt.CbflgLineToLineTimeClick(Sender: TObject);
begin
  EdLineToLineTime.Enabled:=CbflgLineToLineTime.Checked;
end;

procedure TApproachOpt.EdNonLinRgXChange(Sender: TObject);
begin
 if flgLinXScanner and flgLinYScanner then flgReLoadSpline:=True;
end;

procedure TApproachOpt.EdNonLinRgYChange(Sender: TObject);
begin
 if flgLinXScanner and flgLinYScanner then   flgReLoadSpline:=True;
end;

procedure TApproachOpt.EdGrateStepChange(Sender: TObject);
begin
  if flgLinXScanner and flgLinYScanner then flgReLoadSpline:=True;
end;


procedure TApproachOpt.SetAutoScanner(Sender: TObject);
var i:integer;
    flgnewitem:Boolean;
    CurScannerNumb:string;
begin
(*         flgnewItem:=true;
         HardwareOpt.FlgAutoScanner:=1;
         CurScannerNumb:=HardWareOpt.ScannerNumb;
         HardWareOpt.ScannerNumb:= ValueControllerNum.Caption;
         cbElectronicNum.text:=ValueControllerNum.Caption;
         cbElectronicNum.enabled:=false;
       for i:=0 to cbScannerNum.Items.Count-1 do
       if HardWareOpt.ScannerNumb=cbScannerNum.Items[i] then
         begin
            cbScannerNum.ItemIndex:=i;
            flgManualScanSelect:=True;
            cbScannerNumSelect(sender);
            flgnewItem:=false;
         end;
      if flgnewItem then
       begin
        siLangLinked1.MessageDlg(stre9{'Scanner '}+HardWareOpt.ScannerNumb+stre10{' doesn''t exist. Manual regime is set!'},mtwarning,[mbOk],0);
        HardWareOpt.ScannerNumb:=CurScannerNumb;
        RadioGroup.itemindex:=1;
        SetScannerNumSheetInit;
       RadioGroupClick(sender);
       //   cbScannerNum.Items.Add(HardWareOpt.ScannerNumb);
        exit;
       end;
    //   PanelScannerCorr.Enabled:=false;
       PanelScannerCorrEnab;
     *)  
end;

procedure TApproachOpt.RadioGOpenChanelClick(Sender: TObject);
begin
(*  case RadioGOpenChanel.ItemIndex of
0: API.ADCMCH_ENA:=32;
1: API.ADCMCH_ENA:=8;
  end;
*)  
end;

procedure TApproachOpt.RadioGroupClick(Sender: TObject);
var   flgnewitem:Boolean;
begin
(*        case RadioGroup.ItemIndex of
    0:begin    //auto=true;
        SetAutoScanner(sender);
      end;
    1:begin    // manual
       HardwareOpt.FlgAutoScanner:=0;
       cbScannerNumSelect(Sender);
       cbElectronicNum.enabled:=True ;
       if  flgLinYScanner and flgLinXScanner then CBoxXYLin.Enabled:=true
                                           else
                                           begin
                                            CBoxXYLin.Itemindex:=1;
                                            cBoxXYLin.Enabled:=false;
                                            ScannerCorrect.FlgXYLinear:=false;
                                           end;
      end;
                  end;     //case
   *)               
end;

procedure TApproachOpt.RadioGroupTdClick(Sender: TObject);

begin
   if RadioGroupTd.ItemIndex = 0 then           // rough
              sbTd.Position:= round(sbTd.Max*(PidParams.Td)/PidParams.TdAbsMax)
          else
          begin         //fine
               InitPIDFine(PidParams.Td, PidParams.TdAbsMax, PidParams.pidTdL1,PidParams.pidTdL2);
               sbTd.Position:= round(sbTd.Max*(PidParams.Td-PidParams.pidTdL1)/(PidParams.pidTdL2-PidParams.pidTdL1));
          end;
end;

procedure TApproachOpt.RadioGroupTeClick(Sender: TObject);

begin
   if RadioGroupTe.ItemIndex = 0 then           // rough
         begin
          sbTe.Position:= round(sbTe.Max*(PidParams.Te)/PidParams.TeAbsMax) ;
         end
         else
         begin         //fine
               InitPIDFine(PidParams.Te, PidParams.TeAbsMax, PidParams.pidTeL1,PidParams.pidTeL2);
               sbTe.Position:= round(sbTe.Max*(PidParams.Te-PidParams.pidTeL1)/(PidParams.pidTeL2-PidParams.pidTeL1));
         end;
end;
(*
procedure TApproachOpt.RadioGroupTiClick(Sender: TObject);
begin
   if RadioGroupTi.ItemIndex = 0 then           // rough
          sbTi.Position:= round(sbTi.Max*(abs(PidParams.Ti))/PidParams.TiAbsMax)
          else
          begin         //fine
               InitPIDFine(abs(PidParams.Ti), PidParams.TiAbsMax, PidParams.pidTiL1,PidParams.pidTiL2);
               sbTi.Position:= round(sbTi.Max*(abs(PidParams.Ti)-PidParams.pidTiL1)/(PidParams.pidTiL2-PidParams.pidTiL1));
          end;
end;
*)
procedure TApproachOpt.CBoxXYLinSelect(Sender: TObject);
begin
   case  CBoxXYLin.ItemIndex of
  0:begin
     ScannerCorrect.FlgXYLinear:=true;
     ComboBoxLinE(true);
    end;
  1:begin
     ScannerCorrect.FlgXYLinear:=false;
     ComboBoxLinE(false);
    end;
               end;
end;

procedure TApproachOpt.EdSensXChange(Sender: TObject);
begin
//  if assigned(ScanWnd) then ScanWnd.flgBlickApply:=true;
end;

procedure TApproachOpt.CheckBoxFlashClick(Sender: TObject);
var PathFlash:string;
begin
(*   RadioGroup.Enabled:=not CheckBoxFlash.Checked;
   HardWareOpt.FlgFlash:=CheckBoxFlash.Checked;
   CbScannerNum.Enabled:=not CheckBoxFlash.Checked;
    case  CheckBoxFlash.Checked of
true: begin
        PathFlash:= GetPathFlash;
       if PathFlash=''       //no flash
          then
           begin
            if siLangLinked1.MessageDlg(stre11{'Physical Unit Flash Drive is not connected! Continue work without Flash Drive?'}
                          ,mtConfirmation,[mbYes,mbNo,mbHelp],IDH_Flash_drive)=mrNo
              then   halt
              else
              begin
               CheckBoxFlash.Checked:=not CheckBoxFlash.Checked;
               HardWareOpt.FlgFlash:=CheckBoxFlash.Checked;
               { TODO : 260307 }
               case flgUNit of
    nano,Pipette:  ScannerIniFilesPath:=ExeFilePath;
             sem:  ScannerIniFilesPath:=ExeFilePath+ScannerSEMUnitPath ;
            baby:  ScannerIniFilesPath:=ExeFilePath+ScannerAtomicUnitPath;
           grand:  ScannerIniFilesPath:=ExeFilePath+ScannerStepMotorUnitPath;
                    end;
               exit;
              end;
            end
            else
            begin
               case flgUNit of
     nano,Pipette:  ScannerIniFilesPath:=PathFlash+':\';
             baby:  ScannerIniFilesPath:=ExeFilePath+ScannerAtomicUnitPath;
            grand:  ScannerIniFilesPath:=ExeFilePath+ScannerStepMotorUnitPath;
              sem:  ScannerIniFilesPath:=ExeFilePath+ScannerSEMUnitPath ;
                    end;
            end;
      end;
false:begin
                 case flgUNit of
    nano,Pipette:   ScannerIniFilesPath:=ExeFilePath;
            baby:   ScannerIniFilesPath:=ExeFilePath+ScannerAtomicUnitPath;
           grand:  ScannerIniFilesPath:=ExeFilePath+ScannerStepMotorUNitPath;
             sem:  ScannerIniFilesPath:=ExeFilePath+ScannerSEMUnitPath ;
                      end;
      end;
               end;
    cbScannerNumSelect(Sender);
   *)
end;

procedure TApproachOpt.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if (ssCtrl in Shift) then
   begin
     ActiveControl:=PageControl;
      if (Key=ord('V')) then
      begin
          ScanCorSheet.TabVisible:= not ScanCorSheet.TabVisible;
//          CSPMSheet.TabVisible:= not CSPMSheet.TabVisible;
          TabSheetPID.TabVisible:= not  TabSheetPID.TabVisible;
          BitBtnWriteController.Enabled:= not BitBtnWriteController.Enabled;
          BitBtnReadController.Enabled:= not BitBtnReadController.Enabled;
          LblEditNTSpb.Enabled:= not LblEditNTSpb.Enabled;
          if STMFLG then
          begin
           PanelCurThreshold.Visible:=not  PanelCurThreshold.Visible;
           lblCutImaxinfo.Visible:=not lblCutImaxinfo.Visible;
          end;
          PanelDelay.Visible:=not  PanelDelay.Visible;
     //     HardWareSheet.TabVisible:=not HardWareSheet.TabVisible
      end;
      if (key=ord('L')) then
        begin
          FlgLinVisible:=not FlgLinVisible;
          if FlgLinVisible then
                     begin
                      LabelLinOn.Visible:=True;  LabelLinOn.Caption:=siLangLinked1.GetTextOrDefault('IDS_50' (* 'Linearization On' *) );
                     end
                     else begin LabelLinOn.Caption:=siLangLinked1.GetTextOrDefault('IDS_51' (* 'Linearization Off' *) ); LabelLinOn.Visible:=false; end;
        end;
     if (key=ord('E')) then
        begin
           FlgLeaveEnabled:=not FlgLeaveEnabled;
           BBtnContrDelete.Enabled:=FlgLeaveEnabled;
           DeleteScanner.Enabled:=FlgLeaveEnabled;
        end;
    end;
end;

procedure TApproachOpt.cbScannerNumClick(Sender: TObject);
begin
 flgManualScanSelect:=True;
end;

procedure TApproachOpt.MakeReloadSplines;
var
code:integer;
begin
 flgReLoadSpline:=False;
 HardWareOpt.ScannerNumb:=cbScannerNum.text;
 code:=TestErrorScannerIniFile;
 SetLinSplineZero;
 if (Code=0) then LoadLinSpline(HardWareOpt.ScannerNumb);
end;

procedure TApproachOpt.BitBtnSAVEClick(Sender: TObject);
var savemode:integer;
    DiscrVal, nmVal:integer;
begin
    OKBtn.Enabled:=false;
    BitBtnCancel.Enabled:=false;
    BitBtnSave.Enabled:=false;
    BitBtnSaveAdapter.Enabled:=BitBtnSave.enabled;
    Application.ProcessMessages;
     with ScannerCorrect do
      begin
         FlgXYLinear:=CBoxXYLin.Text='True';
         FlgPlnDel:=CBoxDelP.Text='True';
         FlgHideLine:=CBoxHideLine.Text='True';
         YBiasTan:=tan(pi*strToFloat(edYSectAngle.text)/180);
         SensitivZ:=StrToFloat(edSensZ.Text);
         SensitivX:=StrToFloat(edSensX.Text);
         SensitivY:=StrToFloat(edSensY.Text);
         I_VTransfKoef:=StrToFloat(edI_VTransf.Text);
         NonLinFieldX:=StrToInt(edNonLinRgX.text);
         NonLinFieldY:=StrToInt(edNonLinRgY.text);
         GridCellSize:=StrToInt(edGrateStep.text);
      end;
 ////////////////////////////////
        TransformUnitInit ;
 ////////////////////////////////
 //   ApprLinesParamsCalc(HardWareOpt.ScannerNumb); // 09/09/2016
    ApprLinesParamsCalcFromAdapter;
    SetXYMax;
    with ScannerCorrect do
      begin
    //   DZdclnX:=strToFloat(edtanX.text);
    //   DZdclnY:=strToFloat(edtanY.text);
      end;
 if ScanParams.ScanPath=0 then    StoreScannerOpt( ScannerOptModX, ScannerOptModY,PAdapterOptModX,PAdapterOptModY)
                          else    StoreScannerOpt( ScannerOptModY, ScannerOptModX,PAdapterOptModY,PAdapterOptModX);

 if siLangLinked1.MessageDlg(stre12{'Rewrite Scanner Parameters ?'},mtwarning,[mbYes,mbNo],0)=mrYes
                then  SaveScannerParams;   // Здесь выполняется сохранение в базу данных
 if  ChangeMaxArea    then
  begin
//   RenishawParamsDef;
//   RenishawParamsLast;
   savemode:=ScanParams.ScanPath;
   SetScanParamsDef;
   ScanParams.ScanPath:=savemode;
   Voltage_toDiscr('X',0, DiscrVal, nmVal )  ;
   ScanParams.XBegin:= nmVal;
   Voltage_toDiscr('y',0, DiscrVal, nmVal )  ;
   ScanParams.YBegin :=nmVal;
   flgNew_XYBegin:=True;
  end;
 if Assigned(ScanWnd) then  ScanWnd.ScanAreaUpdate;
// Nanoedu.GetCurrentPosition;

 ScanOptGridInit;
 BitBtnSaveAdapter.Enabled:=BitBtnSave.enabled;
 BitBtnSaveAdapter.Enabled:=true;
 OKBtn.Enabled:=true;
 BitBtnSave.Enabled:=true;
 BitBtnCancel.Enabled:=true;
end;

procedure TApproachOpt.BitBtnSaveRenishawClick(Sender: TObject);
begin
   RenishawParams.RenishawScale:=StrToFloat(EdRenishawPeriodKoef.Text);
   case cbRenishawType.ItemIndex of
     0:  RenishawParams.RenishawPeriod:=20;
     1:  RenishawParams.RenishawPeriod:=100;
   end;
   RenishawParams.Period_nm:= RenishawParams.RenishawScale* RenishawParams.RenishawPeriod;
 if siLangLinked1.MessageDlg(stre12{'Rewrite Scanner Parameters ?'},mtwarning,[mbYes,mbNo],0)=mrYes then SaveScannerParams;
  RenishawParams.flgLineToLineTime:=CbflgLineToLineTime.Checked ;
   if CbflgLineToLineTime.Checked then
       begin
             RenishawParams.LineToLineTimemk:= StrToInt(EdLineToLineTime.Text);
       end;
   SaveRenishawParams;
   Close;
end;

procedure TApproachOpt.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
 CanClose:= not  flgSaveProcess;
end;

procedure TApproachOpt.FormCreate(Sender: TObject);
begin

end;

(*
procedure TApproachOpt.FormCreate(Sender: TObject);
begin
  UpdateStrings;
end;
*)

procedure TApproachOpt.ComboBoxLinE(flg:Boolean);
begin
        EdNonLinRgX.enabled:=flg;
        EdNonLinRgY.enabled:=flg;
       EdYSectAngle.enabled:=flg;
        EdGrateStep.enabled:=flg;
end;

procedure TApproachOpt.ComboBoxLvlDelClick(Sender: TObject);
begin
 ScanParams.flgTopoLevelDel:=not boolean(ComboBoxLvlDel.Itemindex);
end;

procedure TApproachOpt.EdSensYKeyPress(Sender: TObject; var Key: Char);
begin
       if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0;
end;

procedure TApproachOpt.EdSensXKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0;
end;

procedure TApproachOpt.EdI_VTransfKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TApproachOpt.EdLineToLineTimeKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TApproachOpt.EdSensZKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0;
end;

procedure TApproachOpt.edYSectAngleKeyPress(Sender: TObject;
  var Key: Char);
begin
     if not(Key in ['-','0'..'9',#8]) then Key :=#0;
end;

procedure TApproachOpt.EdNonLinRgYKeyPress(Sender: TObject; var Key: Char);
begin
     if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TApproachOpt.EdRenishawPeriodKoefKeyPress(Sender: TObject;
  var Key: Char);
begin
      if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0;
end;

procedure TApproachOpt.EdNonLinRgXKeyPress(Sender: TObject; var Key: Char);
begin
     if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TApproachOpt.EdGrateStepKeyPress(Sender: TObject; var Key: Char);
begin
     if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TApproachOpt.EditdTKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0;
end;

procedure TApproachOpt.EditIMaxCutChange(Sender: TObject);
begin
        case STMFlg of
 True: begin
         ApproachParams.IMaxCut:=StrToFloat(EditImaxCut.Text);
          NanoEdu.ImaxCut:=round(ApproachParams.ImaxCut*dbltoint);
       end;
          end;
end;

procedure TApproachOpt.EditIMaxCutExit(Sender: TObject);
begin
      (*   case STMFlg of
 True: begin
         ApproachParams.IMaxCut:=StrToFloat(EditImaxCut.Text);
          NanoEdu.ImaxCut:=round(ApproachParams.ImaxCut*dbltoint);
       end;
          end;
          *)
end;

procedure TApproachOpt.EditIMaxCutKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
    if (Key=VK_RETURN) then
  begin
         case STMFlg of
 True: begin
         ApproachParams.IMaxCut:=StrToFloat(EditImaxCut.Text);
          NanoEdu.ImaxCut:=round(ApproachParams.ImaxCut*dbltoint);
       end;
          end;
  end;
end;

procedure TApproachOpt.EditIMaxCutKeyPress(Sender: TObject; var Key: Char);
begin
    if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0;
end;

procedure TApproachOpt.EditTdKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0;
end;

procedure TApproachOpt.EditTeKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0;
end;

procedure TApproachOpt.EditTiKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0;
end;

procedure TApproachOpt.ComboBoxTChange(Sender: TObject);
begin
   case ComboBoxT.ItemIndex of
  0:begin                             //stepmotor;
      ApproachParams.TypeMover:=0;
      ApproachNScrpt:=ApproachSMScrpt;
      MTestScrpt:=SMTestScrpt;
      PanelPMTime.visible:=false;
    end;
  1:begin                             //piezomotor
     case flgUnit of
ProBeam,MicProbe:
     begin
      ApproachParams.TypeMover:=4;
      ApproachNScrpt:=ApproachPMSEMScrpt;
      MTestScrpt:=PMSEMTestScrpt;
     end;
baby:begin
      ApproachParams.TypeMover:=1;
      ApproachNScrpt:=ApproachPMScrpt;
      MTestScrpt:=PMTestScrpt;
     end;
           end;
   //    ApproachParams.TypeMover:=1;
   //   ApproachNScrpt:=ApproachPMScrpt;
   //   MTestScrpt:=PMTestScrpt;
      PanelPMTime.visible:=true;
      LabelPMTime.Caption:=inttostr(ApproachParams.PMActiveTime);
      ScrollBarPMTime.Position:=ApproachParams.PMActiveTime;
      ScrollBarPMPause.Position:=ScrollBarPMPause.Max-ApproachParams.PMPause;
      LabelPause.Caption:=inttostr(ScrollBarPMPause.Position);
      end;
         end;
    if Assigned(Approach) then
    begin
//     FreeAndNil(Nanoedu.ScannerApproach);
//     Nanoedu.ApproachRegime;
    end;
end;

procedure TApproachOpt.ScrollBarPMTimeScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
    ApproachParams.PMActiveTime:=ScrollPos;
    LabelPMTime.Caption:=inttostr(scrollpos);
//  if assigned(NanoEdu.ScannerApproach) then
//    NanoEdu.ScannerApproach.Motor.SPEED:=ApproachParams.PMActiveTime;
end;

procedure TApproachOpt.edAMPGainFZKeyPress(Sender: TObject; var Key: Char);
begin
    if not(Key in ['0'..'9',DecimalSeparator,#8]) then Key :=#0;
end;

procedure TApproachOpt.edAMPGainFXKeyPress(Sender: TObject; var Key: Char);
begin
    if not(Key in ['0'..'9',DecimalSeparator,#8]) then Key :=#0;
end;

procedure TApproachOpt.edAMPGainRZKeyPress(Sender: TObject; var Key: Char);
begin
   if not(Key in ['0'..'9',DecimalSeparator,#8]) then Key :=#0;
end;

procedure TApproachOpt.edAMPGainFYKeyPress(Sender: TObject; var Key: Char);
begin
   if not(Key in ['0'..'9',DecimalSeparator,#8]) then Key :=#0;
end;

procedure TApproachOpt.edAMPGainRXKeyPress(Sender: TObject; var Key: Char);
begin
      if not(Key in ['0'..'9',DecimalSeparator,#8]) then Key :=#0;
end;

procedure TApproachOpt.edAMPGainRYKeyPress(Sender: TObject; var Key: Char);
begin
    if not(Key in ['0'..'9',DecimalSeparator,#8]) then Key :=#0;
end;

constructor TApproachOpt.Create(AOwner: TComponent; var AFormVar: TApproachOpt);
var    NewItem:TMenuItem;
       i:integer;
       flgChangeMaxLinePoint:boolean;
begin
 inherited Create(AOwner);
   siLangLinked1.ActiveLanguage:=Lang;
   UpdateStrings;
   ComboBoxT.visible:=false;
   label21.Visible:=false;
   flgChangeMaxLinePoint:=false;
   prevNXYMax:=LinePointsMax;
 {$IFDEF FULL}
  //  ComboBoxT.visible:=true;
 //   label21.Visible:=true;
    RadioGOpenChanel.Visible:=true;
 {$ENDIF}
   FormVar := @AFormVar;
  with  ScannerCorrect do
  begin
       YBiasTanOpen:=YBiasTan;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivXOpen:=SensitivX;
       SensitivYOpen:=SensitivY;
  end;
   flgNew_XYBegin:=False;
   ScannerCorrectLast();
   TopoSheetInit;
   SetControllerName;
   CSPMSignalsTabInit;
 //  HardWareSheetInit;
   ScanCorrSheetInit;
   ApproachSheetInit;
   ControllerSheetInit;
   ScanOptGridInit;
   OscGridInit;
   PIDSheetInit;
   TabSheetRenishaw.tabVisible:=flgRenishawUnitExists;
if TabSheetRenishaw.tabVisible then   RenishawSheetInit;
   OpenDialog.FileName:=ApproachParams.OrVideoProgram;
   BBtnContrDelete.Enabled:=FlgLeaveEnabled;
   DeleteScanner.Enabled:=FlgLeaveEnabled;
   HintApproachGrid[0]:='';
   HintApproachGrid[1]:='';
   HintApproachGrid[2]:='';
   HintApproachGrid[3]:='';
   HintApproachGrid[4]:='';
   HintApproachGrid[6]:='';
   HintApproachGrid[7]:='';
   HintApproachGrid[5]:=siLangLinked1.GetTextOrDefault('IDS_71' (* 'Frequance Band 3,5,6' *) );
   HintScanGrid[0]:=siLangLinked1.GetTextOrDefault('IDS_72' (* 'Width Scan Area in nm' *) );
   HintScanGrid[1]:=siLangLinked1.GetTextOrDefault('IDS_73' (* 'Height Scan Area in nm' *) );
   HintScanGrid[2]:=siLangLinked1.GetTextOrDefault('IDS_74' (* 'Start  point X' *) );
   HintScanGrid[3]:=siLangLinked1.GetTextOrDefault('IDS_75' (* 'Start  point Y' *) );
   HintScanGrid[4]:=siLangLinked1.GetTextOrDefault('IDS_76' (* 'Number points in the Line' *) );
   HintScanGrid[5]:=siLangLinked1.GetTextOrDefault('IDS_76' (* 'Number points in the Line' *) );
   HintScanGrid[6]:=siLangLinked1.GetTextOrDefault('IDS_78' (* 'Scannig Velocity  in nm/s' *) );
   HintScanGrid[7]:=siLangLinked1.GetTextOrDefault('IDS_79' (* 'Scannig Mode 1- scanning along X' *) );
   HintScanGrid[8]:=siLangLinked1.GetTextOrDefault('IDS_80' (* 'Xmax' *) );//'Microstep';
   HintScanGrid[9]:=siLangLinked1.GetTextOrDefault('IDS_81' (* 'YMax' *) ); // 'Delay ';
   HintScanGrid[10]:=siLangLinked1.GetTextOrDefault('IDS_82' (* 'Step X,Y' *) ); //'Number microsteps in one step';
   ScanOptGrid.Hint := '0 0';
   ScanOptGrid.ShowHint := True;
   flgManualScanSelect:=false;
  if (flgStopScan) or (not FlgStopApproach) or (not FlgStopResonance) then
   begin
     cbScannerNum.enabled:=true;
     cbElectronicNum.enabled:=true;
   end
   else
   begin
     cbScannerNum.enabled:=false;
     cbElectronicNum.enabled:=false;
   end;
  if (flgStopScan) and (FlgStopApproach) and (FlgStopResonance) then
     begin  //stop
       OKBtn.Enabled:=True;
       BitBtnSave.enabled:= lowercase(HardWareOpt.ScannerNumb)<>'demo';
       BitBtnSaveAdapter.Enabled:=BitBtnSave.enabled;
       DefaultBtn.Enabled:=True;
       TabSheetSetScan.Enabled:=true;
       ApproachOptGrid.Enabled:=true;
     end
    else
     begin   //run
      ApproachOptGrid.Enabled:=false;
      ScanCorSheet.enabled:=false;
      HardWareSheet.enabled:=false;
      TabSheetSetScan.enabled:=false;
      OkBtn.enabled:=false;
      DefaultBtn.enabled:=false;
      BitBtnSave.enabled:=false;
      BitBtnSaveAdapter.Enabled:=BitBtnSave.enabled;
     end;                       { TODO : 26/03/06 }
   //   ControllerNumber;//ControllerNumClick;
  if assigned(Approach) or assigned(ScanWnd) then  cbScannerNum.Enabled:=False
                                             else  cbScannerNum.Enabled:=True;
  if assigned( ScanWnd) then  ComboBoxPath.Enabled:=false;
        ScanCorSheet.TabVisible:=False;
        HardWareSheet.Tabvisible:=False;
  with PageControl do
  begin
      ActivePage:=ApprOptSheet;
     if assigned(ScanWnd)     then  ActivePage:=ScanOptSheet;
     if assigned(Approach)    then  ActivePage:=ApprOptSheet;
     for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
      ActivePage.HighLighted:=True;
  end;
  PanelZ.visible:=false;
  case flgUnit of
baby:  begin
      //  CheckBoxflash.Visible:=false;
      //  RadioGroup.Visible:=false;
       end;
ProBeam,
MicProbe:begin
            PanelZ.visible:=true;
            LabelPMTime.Caption:=inttostr(ApproachParams.PMActiveTime);
            ScrollBarPMTime.position:= ApproachParams.PMActiveTime;
            LabelPause.Caption:=inttostr(ScrollBarPMPause.Max-ApproachParams.PMPause);
            ScrollBarPMPause.position:=ScrollBarPMPause.Max-ApproachParams.PMPause;
           if ScannerCorrect.FlgZLinear then
           begin
             labelabs.Visible:=true;
             CBoxZLinAbs.visible:=true;
           end;

        end;
          end;
    ApproachParamsEdited:=ApproachParams;
    flgReLoadSpline:=False;
    SetScannerNumSheetInit;
    CBoxXYLin.Enabled:= (flgLinYScanner and flgLinXScanner);
    NewItem := TMenuItem.Create(Self);
    NewItem.Caption :='-';
    Main.mWindows.Add(NewItem);
    NewItem := TMenuItem.Create(Self);
    NewItem.Caption := self.Caption;
    NewItem.OnClick:=Main.ActivateMenuItem;
    Main.mWindows.Add(NewItem);
end;

destructor TApproachOpt.Destroy;
begin
  FormVar^ := nil;
  inherited Destroy;
end;
procedure TApproachOpt.ThreadDone(var AMessage : TMessage);
begin
   if  (mEEPromWriteDone=AMessage.WParam)then
       begin
         if assigned(SetControllerParamsThread) then
           begin
             SetControllerParamsThread:=nil;
             SetControllerParamsThreadActive := false;
           end;
         NanoEdu.Method.FreeBuffers;
         FreeAndNil(NanoEdu.Method);
         BitBtnWriteController.Enabled:=true;
       end;
end;
procedure TApproachOpt.ComboBoxPathSelect(Sender: TObject);
var code:integer;
begin
      case  ComboBoxPath.ItemIndex of
    0 : begin     //'X+'
         ScanParams.ScanPath:=OneX;
         ScannerIniFile:= ScannerIniFileX;
         ScannerDefIniFile:= ScannerDefIniFileX;
         ScannerCorrectLast();
         ScanCorrSheetInit;
        code:=TestErrorScannerIniFile;
        SetLinSplineZero;
        if (Code=0) then LoadLinSpline(HardWareOpt.ScannerNumb);
        end;
    1 : begin     //  'Y+'
         ScanParams.ScanPath:=OneY;
         ScannerIniFile:= ScannerIniFileY;
         ScannerDefIniFile:= ScannerDefIniFileY;
         ScannerCorrectLast();
         ScanCorrSheetInit;
         code:=TestErrorScannerIniFile;
         SetLinSplineZero;
         if (Code=0) then LoadLinSpline(HardWareOpt.ScannerNumb);
        end;
                end;//case
end;

procedure TApproachOpt.ApproachOptGridKeyPress(Sender: TObject;
  var Key: Char);
begin
     if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0;
end;

procedure TApproachOpt.ScrollBarPMPauseScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
      ApproachParams.PMPause:=ScrollPos;
    LabelPause.Caption:=inttostr(scrollpos);
//  if assigned(NanoEdu.ScannerApproach) then
//    NanoEdu.ScannerApproach.Motor.Pause:=ApproachParams.PMPause;

end;


end.









