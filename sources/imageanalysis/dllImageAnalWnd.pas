//150307   plane delete change
// {$R+}
unit dllImageAnalWnd;

interface

uses
   Windows, Messages, SysUtils,Classes, Graphics, Controls, Forms,
   ExtCtrls, StdCtrls, Buttons, Series,IniFiles, jpeg,
   Chart,math, GlobalDCL, FourierProc,  ComCtrls, TeEngine, GlobalType,GlobalScanDataType,
   TeeProcs, AppEvnts,Dialogs, ClipBrd, uImageAnalysis, siComp;


	const strCounts: string = ''; (* Counts *) // TSI: Localized (Don't modify!)
type RRealRect=record
      Left,top,right,bottom:single;
     end;

type ArraySpline=array[1..ArraySplineLen] of float;

type
  TImgAnalysWnd = class(TForm)
    PanelRight: TPanel;
    TabSheetRoughness: TTabSheet;
    Panel4: TPanel;
    HistChart: TChart;
    Series2: TBarSeries;
    Panel5: TPanel;
    RichEdit1: TRichEdit;
    tabSheetSpectr: TTabSheet;    
    PanelFourier: TPanel;
    SpectrumChart: TChart;
    Series3: TLineSeries;
    PanelSpecTools: TPanel;
    SpeedBtnFreq: TSpeedButton;
    SpeedBtnAngle: TSpeedButton;
    PanelindFrq: TPanel;
    PanelCalibrTools: TPanel;
    SpeedBtnCalibrDist: TSpeedButton;
    TabSheetCalibration: TTabSheet;
    PanelLeftBot: TPanel;
    PageControl1: TPageControl;
    TabSheetImage: TTabSheet;
    PanelLeft: TPanel;
    PanelImgTools: TPanel;
    SpeedBtnDist: TSpeedButton;
    SpeedBtnAngleImg: TSpeedButton;
    PanelLeftChart: TPanel;
    PanelZ: TPanel;
    ImageZGrad: TImage;
    Label1: TLabel;
    Label2: TLabel;
    PanelIndPeriod: TPanel;
    TabSheetCurves: TTabSheet;
    PanelChart1: TPanel;
    Chart1: TChart;
    SeriesLinX: TLineSeries;
    SeriesLinY: TLineSeries;
    Labeldist: TLabel;
    Labeldistleft: TLabel;
    LabelScannerNmb: TLabel;
    GroupBoxFiltration: TGroupBox;
    AddBitBtn: TBitBtn;
    GbFiltKoefs: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    EdSelected: TEdit;
    CbUnselected: TComboBox;
    BitBtnExecute: TBitBtn;
    TabSheetBackFFT: TTabSheet;
    PanelBackFFT: TPanel;
    LabelInfoSpectr: TLabel;
    PanelBackFFTTools: TPanel;
    SpeedBtnDistBackFFT: TSpeedButton;
    SpeedBtnAngleBackFFT: TSpeedButton;
    LabelInfoBackFFT: TLabel;
    TabSheetAutoLin: TTabSheet;
    PanelAutoLinChart: TPanel;
    AutoLinChart: TChart;
    PanelAutoLin: TPanel;
    Bevel1: TBevel;
    LabelScanMode: TLabel;
    RadioGrLinDir: TRadioGroup;
    Bevel2: TBevel;
    LabelSens: TLabel;
    LabelInitSens: TLabel;
    LabelCorrSens: TLabel;
    EdInitSens: TEdit;
    EdCorrSens: TEdit;
    CheckBoxScanMode: TCheckBox;
    BitBtnSaveAutoLin: TBitBtn;
    Series6: TLineSeries;
    Series8: TPointSeries;
    TabSheetAutoLinCurve: TTabSheet;
    ChartCorrLine: TChart;
    Series9: TLineSeries;
    Label3: TLabel;
    EdGridPeriod: TEdit;
    Label14: TLabel;
    EdNonLinField: TEdit;
    Label15: TLabel;
    SpeedButton1: TSpeedButton;
    BitBtnApplyFilt: TBitBtn;
    BitBtnNewFilt: TBitBtn;
    PanelStatistics: TPanel;
    LabelDistStat: TLabel;
    LabelNDistStat: TLabel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    PageControlResults: TPageControl;
    Panel1: TPanel;
    PanelRightChart: TPanel;
    PanelCalibration: TPanel;
    PanelSensitiv: TPanel;
    GrBoxSensitivity: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EdSensX: TEdit;
    EdSensY: TEdit;
    BitBtnApply: TBitBtn;
    BitBtnSaveSens: TBitBtn;
    BitBtnSetDef: TBitBtn;
    PanelNonLinCorr: TPanel;
    GrBoxNonLinCorr: TGroupBox;
    BitBtnNonLinCorr: TBitBtn;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    EdNonLinFieldX: TEdit;
    EdNonLinFieldY: TEdit;
    BitBtnSave: TBitBtn;
    BitBtnZoomIn: TBitBtn;
    BitBtnZoomOut: TBitBtn;
    Series7: TAreaSeries;
    SpeedBtnSave: TSpeedButton;
    ImAnalSaveDialog: TSaveDialog;
    SpeedBtnSave2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    BitBtnSaveFltr: TBitBtn;
    siLang1: TsiLang;
    siLangDispatcher1: TsiLangDispatcher;
    Label16: TLabel;
    Panel3: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    SpeedButton7: TSpeedButton;
    BackFFTChart: TChart;
    Series5: TLineSeries;
    ImgChart: TChart;
    Series1: TLineSeries;
    ImgCalibrateChart: TChart;
    Series4: TLineSeries;
    BitBtnHelp: TBitBtn;
    procedure SpeedButton7Click(Sender: TObject);
    procedure UpdateStrings;
    procedure siLang1ChangeLanguage(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GrBoxNonLinCorrClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControlResultsChange(Sender: TObject);
    procedure ImgChartAfterDraw(Sender: TObject);
    procedure SpectrumChartAfterDraw(Sender: TObject);
    procedure ImgChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImgChartMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure ImgChartMouseUp(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure SpectrumChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SpectrumChartMouseMove(Sender: TObject; Shift: TShiftState;  X, Y: Integer);
    procedure SpectrumChartMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ClearImgSpeedBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BitBtnApplyClick(Sender: TObject);
    procedure ImgCalibrateChartAfterDraw(Sender: TObject);
    procedure BitBtnNonLinCorrClick(Sender: TObject);
    procedure ImgCalibrateChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImgCalibrateChartMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ImgCalibrateChartMouseUp(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SeriesLinYClick(Sender: TChartSeries; ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Chart1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure Chart1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SeriesLinXClick(Sender: TChartSeries; ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BitBtnSaveSensClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure SpeedBtnCalibrDistClick(Sender: TObject);
    procedure SpeedBtnDistClick(Sender: TObject);
    procedure AddBitBtnClick(Sender: TObject);
    procedure BitBtnExecuteClick(Sender: TObject);
    procedure BackFFTChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BackFFTChartMouseMove(Sender: TObject; Shift: TShiftState; X,  Y: Integer);
    procedure BackFFTChartMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
 //   procedure SpeedButton3Click(Sender: TObject);
    procedure BitBtnSaveAutoLinClick(Sender: TObject);
    procedure RadioGrLinDirClick(Sender: TObject);
    procedure BitBtnSetDefClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedBtnFreqClick(Sender: TObject);
    procedure SpeedBtnAngleClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtnApplyFiltClick(Sender: TObject);
    procedure BitBtnNewFiltClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure EdSensXKeyPress(Sender: TObject; var Key: Char);
    procedure EdSensYKeyPress(Sender: TObject; var Key: Char);
    procedure EdNonLinFieldXKeyPress(Sender: TObject; var Key: Char);
    procedure EdNonLinFieldYKeyPress(Sender: TObject; var Key: Char);
    procedure EdSelectedKeyPress(Sender: TObject; var Key: Char);
    procedure CbUnselectedKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnZoomInClick(Sender: TObject);
    procedure BitBtnZoomOutClick(Sender: TObject);
    procedure SpeedBtnSaveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtnSaveFltrClick(Sender: TObject);
    procedure BitBtnViewFltClick(Sender: TObject);
    procedure EdSensXChange(Sender: TObject);
    procedure EdSensYChange(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);


(*  procedure HistChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelIndPeriodMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelLeftChartMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelZMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelindFrqMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupBoxFiltrationMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
 *)
  private

 //itMap:TBitMap;
   FlgFourierCounted:Boolean;
   FlgNewFilter:boolean;
   flgSaveProcess:Boolean;
   AngleBegin, FreqBegin:Boolean;
   AngleImgBegin,DistBegin, FiltratBegin:Boolean;
   FlagAllowCalibration:boolean;
   SecondClick:boolean;
   FlagLinearDLL:Boolean;
   FlgImgChrtFirstDraw,FlgSpecChrtFirstDraw:boolean;
   FlgCalibrChrtFirstDraw:boolean;
   CXBegin, CYBegin, MouseBegin:Boolean;   // флаги начала коррекции графиков
   LinXChanged, LinYChanged: boolean; //флаги : были ли изменения в данных линеариз.
   ScanModeDLL:Byte;
   lLang:integer;
   LX,LY,LXCal,LYCal:integer;
   X0,Y0,X1,Y1:integer;
   ZoomCount:integer;
   Percents:integer;
   PointNumb:integer;
   PrevPointX, NextPointX:integer;
   LX1,LY1:integer;
   ChartFieldY,ChartFieldX:integer; //Estimate of axes fields
   LocMaxCount:integer;
   RfAver,RfSq:single;
   Dmin, Dmax:real;
   XFreq,Yfreq:single;
   Angle0,Angle1,Angle:single;
   ChX0,ChY0:single;
   SensX1,SensY1:single;
   InitSensX,InitSensY:single; // !!!!!??????????????
   XOld,YOld:single;
   RealSens:single;
   freqMax:single;
   StepZ:single;
   DataFloatMas:TDataFloatCount;
   SpectrumPicture:TDataFloatCount;
   iRusLCID,iEngUsLCID:LCID;
   FiltFileName:PChar;
   LinerizData:ArraySpline;
   Dat:TData;
   hpal:HPALETTE;
   ScannerNameDLL,ScannerFileDLL, ScannerDefFileDLL:string;
   FourierFiltTemplFileDLL:string;
   Measure1:string;

   { Private declarations }
   procedure WMNCLButton(var Message: TMessage); message WM_NCLButtonDown;
   procedure FloatMasInit(Dat:TData);
   procedure SpectrSheetInit(Dat:TData);
   procedure LinerizDataOut(LDataGraph:TLineSeries; LinerizData:ArraySpline; NLin,NonLinField:integer);
   procedure SetWindowsSize;
   procedure CalcChartFields(Chart:TChart);
   procedure FileAutoLinearization(Dir:String);
   Procedure ShowHistogram(Dat:TData);
   procedure ShowCalibration(Dat:TData);
   procedure ShowSpectrum(Dat:TData);
   procedure ShowAutoLinearization(Dat:TData);
   procedure ChangeCurrentSheet;
   procedure SpectrumZoom(Percents:integer; Count:integer);
   procedure Clear;
   function  SetFileAttribute_ReadOnly(filename:string;flg:boolean):boolean;
   procedure CopyToClipBoard;
   procedure MouseDownToDrag(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
 //  procedure MouseDownProc(ImageChart:TChart);
 //  procedure MouseMoveProc(ImageChart:TChart);
   procedure SaveFiltTemplateAsASCII(const FileName:string);
   function  ReadFiltTemplate(const FileName:String; var UData:TDataFloatCount):integer;
   procedure ShowImage(UData:TDataFloatCount);
  public
    FormHandle: THandle;
    ScanFormHandle: THandle;
    ApproachOptFormHandle:THandle;
    MsgBack: Integer;
    MsgScanBack:Integer;
    MsgApproachOptBack:Integer;

  constructor Create(AOwner:TComponent;DataIn:ImageAnalysisDataIn);
  destructor Destroy; override;
  procedure MakePalette(BitMap: TBitMap);
  procedure DrawData( BitMap: TBitMap; Dat:TData); //overload;
  procedure DrawDataFloat( BitMap: TBitMap; Dat:TDataFloatCount); //overload;
  procedure GradientRect (FromRGB, ToRGB: TColor;Canvas:tcanvas;ZTop,ZBottom:integer);
  procedure BuildChart(IChart:TChart; LimWidth,LimHeight:integer; NX,NY:single);
  function  ReadScannerParams(Direction:string; var LSection:ArraySpline; var NSplines, NonLinField:integer):integer;
  function  ReadShortScannerParams(Direction:string; var NonLinField:integer):integer;
  function  SaveAutoLin(dir:string; ScannerFileName:string):integer;
  function  WriteToAdapterLinStructure(dir:string; Pathmode:integer;N:integer;NField:integer; data:string):boolean;
end;
 function  Hist(Dat:TData;var MinVal:integer):TMas1;
 function  HistAreas(Dat:TData; NAreas:integer;MinValue:integer; HistStep:single):TMas1;
 procedure RoughnessParam(Dat:tdata; var Ra,Rq:single);


var

   ImgAnalysWnd: TImgAnalysWnd;
   Step:single;
   LinerizDataX,LinerizDataY:ArraySpline;
   NLinX,NLinY:integer; // number of points for linearization
   GridCellSize:integer;
   NonLinFieldX,NonLinFieldY:integer;
   RFreq{,RFreqSymmetr}:RRealRect;       //270404
   R:TRect;
   RSym:TRect;
   X0Pos,Y0Pos:integer;
   X0Sym,Y0Sym:integer;
   TemplateBuf:TDataFloatCount;

implementation

{$R *.dfm}

uses CSPMVar,GlobalVar,GlobalFunction, FourierFiltrat, nanoeduHelp, Interpolation2D, SurfaceTools,SystemConfig,FrReport,
   uScannerCorrect,frExperimParams,frScanWnd, //add 22/1/16
  mMain;{,LCUnit}//,UReportClasses;
// procedure TImgAnalysWnd.WMMOve(var Mes:TWMMove);
{begin
    if Mes.YPos<Main.ToolBar1.Height+3 then Top:=Main.ToolBar1.Height+3;
end;
}

const
	str1: string = ''; (* error write flash *)
	str3: string = ''; (*  No Filter Template *)
	str4: string = ''; (*  File not exist *)
	str5: string = ''; (*  Open ERROR! *)
	str6: string = ''; (* File is not Filt Template! *)
	strdrawarea: string = ''; (* Draw  selected area by mouse *)

function sign(x:single):single;
begin
 result:=1;
 if x<0 then result:=-1;
end;
function  TImgAnalysWnd.SetFileAttribute_ReadOnly(filename:string;flg:boolean):boolean;
begin
   case flg of
true:begin
      if FileExists(filename)
          then SetFileAttributes(PChar(filename), FILE_ATTRIBUTE_READONLY or FILE_ATTRIBUTE_ARCHIVE	{faReadOnly});
      end;
false:begin
       if FileExists(filename)
         then SetFileAttributes(Pchar(filename), FILE_ATTRIBUTE_ARCHIVE	{faReadOnly});
        end;
          end;
end;
procedure  TImgAnalysWnd.Clear;
begin
 SpectrumChart.Repaint;
 BitBtnExecute.Enabled:=False;
 AddBitBtn.Enabled:=False;
 BitBtnApplyFilt.Enabled:=False;
 FlgNewFilter:=True;
 with R do
   begin
     Left:=0;
     Right:=0;
     Top:=0;
     Bottom:=0;
   end;
end;

procedure  TImgAnalysWnd.SetWindowsSize;
begin
 panelLeftBot.top:=0;
 panelLeftBot.left:=0;
 panelRight.top:=0;
 panelLeftBot.Height:=clientheight;
 panelLeftBot.width:=(clientwidth div 2) -2;
 panelRight.Left:=panelLeftBot.width;
 panelRight.Height:=clientheight;
 panelRight.width:=clientwidth div 2;
 panelRight.left:=panelLeftBot.width+2;
 panelLeftChart.top:=panelLeft.top+PanelImgTools.Height;
 panelLeftChart.left:=0;
 panelLeftChart.Height:=panelLeft.ClientHeight-PanelIndPeriod.Height-PanelImgTools.Height;
 panelLeftChart.width:=panelLeft.clientwidth;
 PanelIndPeriod.top:=panelLeftChart.Height+panelLeftChart.top;
 PanelIndPeriod.left:=0;
 PanelIndPeriod.Width:=panelLeft.ClientWidth;
 PanelZ.top:=2;
 PanelZ.Left:=Panelleftchart.Width-Panelz.Width+4;
 PanelZ.Height:=Panelleftchart.height-4;
 Label2.Top:=PanelZ.Height-16-10-label2.Height;
 ImageZgrad.left:=10;
 ImageZgrad.Height:=PanelZ.Height-2*15-2*16-label1.Height-label2.Height-2*10;
 ImageZgrad.Top:=15+label1.Height+10;
 PanelImgTools.left:=0;
 PanelImgTools.Top:=0;
 PanelImgTools.width:=panelLeft.clientwidth;
 Panel4.Height:=TabSheetRoughness.Height*2 div 3;
 Panel4.Width:=TabSheetRoughness.Width;
 Panel4.Top:=0;
 Panel4.Left:=0;
Panel5.Top:=Panel4.Height;
Panel5.Left:=0;
Panel5.Height:=TabSheetRoughness.Height-Panel4.Height;
Panel5.Width:=TabSheetRoughness.Width;
PanelSpecTools.Width:=TabSheetSpectr.ClientWidth;
PanelSpecTools.Height:=50;
PanelSpecTools.top:=0;
PanelSpecTools.left:=0;
PanelIndFrq.left:=0;
PanelIndFrq.width:=TabSheetSpectr.Clientwidth;
//PanelIndFrq.height:=50;
PanelIndFrq.width:=TabSheetSpectr.Clientwidth;
with PanelFourier do
begin
 width:=TabSheetSpectr.clientWidth;
 height:=TabSheetSpectr.clientHeight-PanelSpecTools.Height-PanelindFrq.Height;
 Left:=0;
 Top:=PanelSpecTools.Height+1;
end;
 PanelIndFrq.Top:=PanelFourier.Top+PanelFourier.Height+1;

with PanelCalibrTools do
 begin
    Top:=0;
    Left:=0;
    width:=TabSheetCalibration.clientWidth;
    Height:=50;
 end;

with PanelCalibration do
 begin
    Top:=TabSheetCalibration.clientHeight-150;
    Left:=0;
    width:=TabSheetCalibration.clientWidth;
    Height:=150;
 end;
with Panel1 do
begin
 width:=TabSheetCalibration.clientWidth;
 height:=TabSheetCalibration.clientHeight-PanelCalibrTools.Height-PanelSensitiv.Height-2;
 left:=0;
 Top:=PanelCalibrTools.Height+1;
end;

 with PanelSensitiv do
  begin
    Top:=0;
    Left:=0;
    width:=PanelCalibration.ClientWidth   div 2;
    height:=PanelCalibration.ClientHeight;
  end;
with PanelNonLinCorr do
 begin
   Top:=0;
   Left:=PanelSensitiv.Width+1;
   Height:=PanelCalibration.ClientHeight;
   Width:= TabSheetCalibration.Width-PanelSensitiv.Width-1;
 end;
 with PanelBackFFT do
   begin
     Left:=PanelLeftChart.Left;
     Top:= PanelLeftChart.Top;
     Width:=PanelLeftChart.Width;
     Height:=PanelLeftChart.Height;
   end;
 SpectrSheetInit(Dat);
end;

constructor TImgAnalysWnd.Create(AOwner:TComponent;DataIn:ImageAnalysisDataIn);
var i,j:integer;
 XL,Yl,XR,yR:integer;
 R:TRect;
 H:TMas1;
 L,StartInd:integer;
 ss:string;
 HeightChartNew,WidthChartNew:integer;
 H0,W0,CH,CW:integer;
 MinVal,HistMin,HistMax:integer;
 FromRGB, ToRGB: TColor;
 BitMap:TBitMap;
 t,slanguage,deflang,str:string;
(*function WhichLanguage:string;
var
  ID: LangID;
  Language: array [0..100] of char;
begin
  ID := GetSystemDefaultLangID;
  VerLanguageName(ID, Language, 100);
  Result := string(Language);
end;
*)
function ShowDllPath:string;
var
  TheFileName : array[0..MAX_PATH] of char;
  str:string;
begin
  FillChar(TheFileName, sizeof(TheFileName), #0);
  GetModuleFileName(hInstance, TheFileName, sizeof(TheFileName));
  result:=string( TheFileName);
  //  MessageBox(0, TheFileName, 'The DLL file name is:', mb_ok);
end;
begin
 lLang:=datain.lang;
str:=ShowDllPath  ;//TApplication(datain.appHandle).}application.exeName;
     iEngUsLCID := LANG_ENGLISH + SUBLANG_ENGLISH_US shl 10 + SORT_DEFAULT shl 16; { US English LCID }
    IRusLCID:= 1049;//LANG_Russiah + SUBLANG_ENGLISH_US shl 10 + SORT_DEFAULT shl 16;

 MouseBegin:=False;
 CYBegin:=False;
 CXBegin:=False;
 LinXChanged:=False;
 LinYChanged:=False;
 ScannerNameDLL:=DataIn.PScannerName;
 ScannerFileDLL:=DataIn.PScannerFile;
 FourierFiltTemplFileDLL:=DataIn.PFourierFiltTemplFile;
 ScannerDefFileDLL:=DataIn.PScannerDefFile;
 FlagLinearDLL:= DataIn.FlagLinear;
 ScanModeDLL:=DataIn.SourceScanMode;
 FlagAllowCalibration:=datain.FlagAllowCalibration;
 FromRGB:=$00FFFFFF;
 ToRGB:=$00000000;
 FlgImgChrtFirstDraw:=True;
 FlgSpecChrtFirstDraw:=True;
 FlgCalibrChrtFirstDraw:=True;
 inherited Create(AOwner);//(Sender as TComponent);
 TemplateBuf:=TDataFloatCount.Create;   // Prepare to Save Filter
//    deflang:=WhichLanguage;
// if  (deflang='Russian')  or (deflang='Русский') then   sLanguage:='RUS';
//    if sLanguage='RUS' then
  siLang1.ActiveLanguage:=lLang;
 if not FlagAllowCalibration   then
 begin
   TabSheetAutoLin.TabVisible:=False;
   TabSheetCalibration.TabVisible:=False;
 end
 else
 begin
   if lowercase(ScannerNameDLL)='demo' then
   begin
     bitbtnsaveautolin.Enabled:=false;
     bitbtnsavesens.Enabled:=false;
     bitbtnsave.Enabled:=false;
   end;
   
 end;
 Visible:=false;
 PageControl1.ActivePageIndex:=0;
 TabSheetCurves.TabVisible:=False;
 TabSheetAutolin.TabVisible:=False;
 GroupBoxFiltration.Visible:=false;
 PanelNonLinCorr.visible:=true;
 ZoomCount:=0;
 Percents:=20;
 SpectrumPicture:=TDataFloatCount.Create;
// TabSheetCalibration.TabVisible:=false;
 Dat:=TData.Create;
with Dat do
begin
 NX:=DataIn.SourceNX;
 NY:=DataIn.SourceNY;
 Dat.CaptionZ:=DataIn.dataUnits;
 Dat.CaptionX:=DataIn.XUnits;
 Dat.CaptionY:=DataIn.YUnits;
 Dat.Caption:='';
 XStep:=DataIn.SourceStep;
 YStep:=DataIn.SourceStep;
 (* if ((lowercase(Dat.captionX) = lowercase(' нм')) and
      (((XStep*NX)> 1000) or ((YStep*NY)> 1000))) then
      begin
        Dat.CaptionX:='мкм';
        Dat.CaptionY:='мкм';
        XStep:=XStep/1000;
        YStep:=YStep/1000;
      end;
  *)
 SetLength(data,Nx,Ny);
   for i:=0 to Ny-1 do
   for j:=0 to Nx-1 do    data[j,i]:=DataIn.Sourcedata[j,i];
end;

 FlgFourierCounted:=False; // It becomes True if Fourier spectrum is counted;
 FlgNewFilter:=True;
 ChartFieldY:=2*40;
 ChartFieldX:= 40;
 AngleBegin:=False;
 AngleImgBegin:=False;
 FreqBegin:=False;
 DistBegin:=False;
 FiltratBegin :=False;
 SecondClick:=False;
 measure1:=Dat.captionZ;//.GetTextOrDefault('IDS_4' (* 'nm' *) );//datEagles;
 width:=1050;//DataIn.MainW*3 div 4;
 height:=700;//DataIn.MainH*3 div 4;
 //MainH*3 div 4;
 with PageControlResults do
 begin
   Align:=alClient;
   ActivePage:=TabSheetRoughness;
 end;
 LX:=Dat.Nx;
 LY:=Dat.Ny;
 LXCal:=Dat.Nx;
 LYCal:=Dat.Ny;
 Dmin:=Dat.datamin;
 Dmax:=Dat.datamax;
 Step:=Dat.XStep;
 InitSensX:=DataIn.SensitivityX;
 InitSensY:=DataIn.SensitivityY;
 StepZ:=DataIn.SourceStepZ;
 EdSensX.Text:=FloatToStr(InitSensX);
 EdSensY.Text:=FloatToStr(InitSensY);;
 BitMap:=TBitMap.Create;
 DrawData(BitMap,Dat);
 SetWindowsSize;
 Series1.Clear;
with ImgCalibrateChart do
begin
 LeftAxis.SetMinMax( 0, LY*Step );
 LeftAxis.Title.Angle:=90;
 LeftAxis.Title.Caption:=Dat.captionY;
 BottomAxis.SetMinMax( 0, LX*Step );
 BottomAxis.Title.Caption:=Dat.captionX;
end;
CalcChartFields(ImgCalibrateChart);
with ImgCalibrateChart do
begin
 (* if LX>=LY then
   begin
    Width:=PanelRightchart.ClientWidth-20;
    Height:=round((Width-ChartFieldX)*LY/LX)+ChartFieldY;
    Left:=1;
    Top:=PanelRightchart.ClientHeight div 2-Height div 2;    //client
   end
   else
   begin
     Height:=PanelRightchart.ClientHeight-20;
     Width:= round((Height-ChartFieldY)*LX/LY)+ChartFieldX;
     Top:=1;
     left:=(PanelRightchart.ClientWidth ) div 2-Width div 2;      //
   end;   *)
  BackImage.Assign(BitMap);
  FreeAndNil(Bitmap);
  BackImageInside:=True;
end; {with}
  BuildChart(ImgCalibrateChart,PanelRightchart.ClientWidth, PanelRightchart.ClientHeight,LXCal,LYCal);
with  SpectrumChart.Title.Text do
begin
 Clear;
 Add(siLang1.GetTextOrDefault('IDS_5' (* ' Fourier Spectrum' *) ));
end;

with ImgChart do
begin
 LeftAxis.SetMinMax( 0, LY*Step );
 LeftAxis.Title.Angle:=90;
 LeftAxis.Title.Caption:=Dat.captionY;//(dat.Caption);
 BottomAxis.SetMinMax( 0, LX*Step );
 BottomAxis.Title.Caption:=Dat.captionX;//Dat.Caption;
end;
with  ImgChart.Title.Text do
begin
 Clear;
end;
with BackFFTChart do
begin
 LeftAxis.SetMinMax( 0, LY*Step );
 LeftAxis.Title.Angle:=90;
 LeftAxis.Title.Caption:=Dat.captionY;//(dat.Caption);
 BottomAxis.SetMinMax( 0, LX*Step );
 BottomAxis.Title.Caption:=Dat.captionX;//Dat.Caption;
end;
with  BackFFTChart.Title.Text do
begin
 Clear;
end;

LabelScannerNmb.Caption:= siLang1.GetTextOrDefault('IDS_6' (* ' Scanner  ' *) )+ScannerNameDLL;
with  HistChart.Title.Text do
begin
 Clear;
 Add(siLang1.GetTextOrDefault('IDS_2' (* 'Image Histogram' *) ));
end;
 HistChart.BottomAxis.Title.Caption:='Z, '+dat.captionZ;
 HistChart.LeftAxis.Title.Caption:=strCounts;
 BitMap:=TBitMap.Create;
 DrawData(BitMap,Dat);

 CalcChartFields(ImgChart);
with ImgChart do
begin
  if LX>=LY then
   begin
    Width:=PanelLeftChart.ClientWidth-20-PanelZ.Width;
    Height:=round((Width-ChartFieldX)*LY/LX)+ChartFieldY;
    Left:=1;
    Top:=Panelleftchart.ClientHeight div 2-Height div 2; //
   end
   else
   begin
     Height:=Panelleftchart.ClientHeight-20;
     Width:= round((Height-ChartFieldY)*LX/LY)+ChartFieldX;
     Top:=1;
     left:=(Panelleftchart.ClientWidth -PanelZ.Width) div 2-Width div 2;
   end;
  BackImage.Assign(BitMap);
  FreeAndNil(Bitmap);
  BackImageInside:=True;
end;
R:=ImgChart.ChartBounds;
XL:=ImgChart.ChartBounds.Left;
GradientRect(FromRGB,ToRGB,ImageZGrad.Canvas,0,255);
Label1.Caption:=FloatToStrF(Dmax*StepZ,fffixed,5,0)+' '+dat.captionZ;
Label2.Caption:=FloatToStrF(Dmin*StepZ,fffixed,5,0)+' '+dat.captionZ;

ShowHistogram(Dat);
HistChart.AllowZoom:=False;

FloatMasInit(Dat);
PageControlResults.ActivePage.HighLighted:=True;
caption:=siLang1.GetTextOrDefault('IDS_9' (* 'Image Analysis ' *) )+DataIn.ImgTitle;
TabSheetBackFFT.TabVisible:=False;
SelectedAreaKoef:=1;
PanelimgTools.Width:=panelleft.ClientWidth;
PanelBackFFTTools.Width:=TabSheetBackFFT.ClientWidth;
AddBitBtn.Enabled:=False;
BitBtnExecute.Enabled:=False;
BitBtnApplyFilt.Enabled:=False;
BitBtnNewFilt.Enabled:=True;
LabelDistLeft.Caption:=' ';

 HistChart.OnMouseDown:=MouseDownToDrag;
 PanelIndPeriod.OnMouseDown:=MouseDownToDrag;
 Panel5.OnMouseDown:=MouseDownToDrag;
 PanelLeftChart.OnMouseDown:=MouseDownToDrag;
 PanelZ.OnMouseDown:=MouseDownToDrag;
 PanelFourier.OnMouseDown:=MouseDownToDrag;
 PanelindFrq.OnMouseDown:=MouseDownToDrag;
 GroupBoxFiltration.OnMouseDown:=MouseDownToDrag;
end; {Create}
 destructor TImgAnalysWnd.Destroy;
 begin
      Application.Handle:=0;
      PostMessage (FormHandle, MsgBack, 0, 0);
      inherited;
 end;
procedure TImgAnalysWnd.WMNCLButton(var Message: TMessage);
 begin
      case Message.wParam of
HTCAPTION:
          begin
           if AltDown  then        // copy to clipboard    for report
             if  assigned(ReportForm) then
             begin
               PageControl1.BeginDrag(False);
               CopyToClipBoard;
               ReportForm.CaptureSourceImage(PageControl1);
             end;
           end;
      end;
      inherited;
     Message.Result := 0;
end;


procedure TImgAnalysWnd.FloatMasInit(Dat:TData);
var i,j:integer;
begin
 if assigned(DataFloatMas) then FreeandNil(DataFloatMas); { TODO : 271007 }
 DataFloatMas:=TDataFloatCount.Create;
with DataFloatMas do
begin
  NX:=Dat.Nx;
  Ny:=Dat.Ny;
  SetLength(data,Nx,Ny);
  for i:=0 to Ny-1 do
   for j:=0 to Nx-1 do
    data[j,i]:=Dat.data[j,i];
end;
end;

procedure TImgAnalysWnd.SpectrSheetInit(Dat:TData);
var
tmp:integer;
//freqMax:single;
begin
freqMax:=1/Step/2;
with SpectrumChart do
begin
//  if LX>=LY then
   begin
    tmp:= PanelFourier.Width-20-PanelZ.Width;
    Width:=min(tmp,PanelFourier.Height);
    Height:=Width;
    Left:=0;
    Top:=0;//Panel6.Height div 2-Height div 2;
   end
 (*  else
   begin
    tmp:= PanelFourier.Height-20;
     Height:= min(tmp,PanelFourier.Width);
    Width:= Height;
     Top:=0;
     left:=50;//Panel6.Width ) div 2-Width div 2;
   end;  *)
end;
with SpectrumChart do
begin
 LeftAxis.SetMinMax( -freqMax, freqMax );
 LeftAxis.Title.Angle:=90;
 LeftAxis.Title.Caption:=('1/'+Dat.CaptionX);
 BottomAxis.SetMinMax( -freqMax, freqMax );
 BottomAxis.Title.Caption:='1/'+Dat.CaptionY;
end;
end;

procedure TImgAnalysWnd.MakePalette(BitMap: TBitMap);
var i : Integer;
    pal : PLogPalette;
begin
{$R-}
  pal := nil;
  try
   GetMem(pal, sizeof(TLogPalette) + sizeof(TPaletteEntry) * 255);
  begin
    pal.palVersion := $300;
    pal.palNumEntries := 256;
    for i := 0 to 255 do
    begin
      pal.palPalEntry[i].peRed   := i;
      pal.palPalEntry[i].peGreen := i;
      pal.palPalEntry[i].peBlue  := i;
      pal.palPalEntry[i].peFlags := pc_nocollapse;
    end;
    if hPal<>0 then  DeleteObject(hPal);
    hpal := CreatePalette(pal^);
    if hpal <> 0 then BitMap.Palette := hpal; // Это место где созданная палитра присваиваеться Bitmap.
                             // Если писать без классов то надо писать так Bitmap.Palette:=hpal
  end
  finally
    FreeMem(pal);
  end;
  {$R+}
end; {MakePalette}

procedure TImgAnalysWnd.DrawData( BitMap: TBitMap; Dat:TData);
var GreyEntr: integer;
    zscale: real;
    x,y: Integer;
    P:PByteArray;
    Height,Width: Integer;
    PointColor:integer;
begin
       BitMap.PixelFormat:=pf8bit ;
       BitMap.Height:=Dat.NY;
       BitMap.Width:=Dat.NX;
       Height:=Dat.NY;
       Width:=Dat.NX;
       GreyEntr:=255;

       if (Dmax-Dmin)<>0 then zscale:= GreyEntr/(Dmax-Dmin)
                         else zscale:=1;

       MakePalette(BitMap);
       for y:=0 to Height-1 do
       begin
            P:=BitMap.ScanLine[y];
            for x:=0 to Width-1 do
            begin
                 PointColor:=round(zscale*(Dat.Data[x,height-y-1]-Dmin));
                 if (PointColor >255) then   PointColor:=255 ;
                 if (PointColor <0)   then   PointColor:=0 ;
                 P[x]:=PointColor;
            end;

       end;

end; {DrawData}

procedure TImgAnalysWnd.DrawDataFloat( BitMap: TBitMap; Dat:TDataFloatCount);
var GreyEntr: integer;
    zscale: real;
    x,y: Integer;
    P:PByteArray;
    Height,Width: Integer;
    PointColor:integer;
begin
       BitMap.PixelFormat:=pf8bit ;
       BitMap.Height:=Dat.NY;
       BitMap.Width:=Dat.NX;
       Height:=Dat.NY;
       Width:=Dat.NX;
       GreyEntr:=255;
       if (Dmax-Dmin)<>0 then   zscale:= GreyEntr/(Dmax-Dmin)
                         else   zscale:=1;

       MakePalette(BitMap);
       for y:=0 to Height-1 do
       begin
            P:=BitMap.ScanLine[y];
            for x:=0 to Width-1 do
            begin
                 PointColor:=round(zscale*(Dat.Data[x,height-y-1]-Dmin));
                 if (PointColor >255) then   PointColor:=255 ;
                 if (PointColor <0)   then   PointColor:=0 ;
                 P[x]:=PointColor;
            end;
       end;

end; {DrawData}

function Hist(Dat:TData; var MinVal:integer):TMas1;
 var
 i,j:integer;
 a: integer;
 Histogr: TMas1;
 len: integer; // Histogram Length;
begin
 MinVal:=(round(Dat.datamin));
 len:=(round(Dat.datamax)-MinVal)+1;
 if len<0 then  exit;
 SetLength(Histogr,len+1);
 for i:=0 to Dat.NY-1 do
  for j:=0 to Dat.NX-1 do
    begin
     a:=(round(Dat.data[j,i]));
     Histogr[a-MinVal]:=Histogr[a-MinVal]+1;
    end;
  Hist:=Histogr;
  Histogr:=nil;
end; {Histogr}

function HistAreas(Dat:TData; NAreas:integer;  MinValue:integer; HistStep:single):TMas1;
 var
 i,j:integer;
 a: integer;
 Histogr: TMas1;
 len: integer; // Histogram Length;
 MaxValue:integer;
 begin

 //len:=(round(Dat.datamax)-MinVal)+1;
 len:=NAreas;

 if len<0 then  exit;
 SetLength(Histogr,len+1);
 for i:=0 to Dat.NY-1 do
  for j:=0 to Dat.NX-1 do
    begin
 //    SiseModStep:= round((SizesArray[k]-minval)/HistStep-0.5);  {floor}
 //    SizesHist[SiseModStep]:=SizesHist[SiseModStep]+1;
     a:=round((Dat.data[j,i]-MinValue)/HistStep-0.5);
     if a<0 then a:=0; 
     if a>len then a:=len; 
       Histogr[a]:=Histogr[a]+1;
    end;
  HistAreas:=Histogr;
  Finalize(Histogr);//:=nil;
end; {HistAreas}


procedure TImgAnalysWnd.ImgChartMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:integer;
begin
 if (Button=mbLeft) and (ssAlt in Shift) then
 begin
    if (left< (screen.workarealeft+10))
         or ((Top+height)>(Screen.workareatop+Screen.workareaheight)) then
    SetWindowPos(handle,HWND_TOP,screen.workarealeft+40,screen.workareatop+200,Width,Height,SWP_SHOWWINDOW);
    RePaint;
    CopyToClipBoard;
    PostMessage (FormHandle, MsgBack, 2, 0);
    exit;
 end;

if  SpeedBtnDist.Down or SpeedBtnAngleImg.Down then
 if not SecondClick then
  begin
   ImgChart.Repaint;
   X0:=X; X1:=X;
   y0:=Y; Y1:=Y;
   chX0:=ImgChart.BottomAxis.CalcPosPoint(X0);
   chY0:=  ImgChart.LeftAxis.CalcPosPoint(Y0);
  end
  else {SecondClick}
  begin
   X0:=X1;
   Y0:=Y1;
   chX0:=ImgChart.BottomAxis.CalcPosPoint(X0);
   chY0:=  ImgChart.LeftAxis.CalcPosPoint(Y0);
  With ImgChart do
  begin
   with Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clBlue;//brush.color;
        Width:=1;
        Mode:=pmnotXOR;
       end;
    Canvas.MoveTo(X0,Y0);
    Canvas.LineTo(X,Y);
   end;
  end;
  X1:=X;
  y1:=Y;
With ImgChart do
   if SpeedBtnDist.Down then
	  begin
     with Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clBlue;//brush.color;
        Width:=1;
        Mode:=pmnotXOR;
       end;
     DistBegin:=True;
	  end
    else if SpeedBtnAngleImg.Down then
    begin
      labeldistleft.Caption:=' ';
     with Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clblue;//clblack;
        Width:=1;
        Mode:=pmnotXOR;
       end;
     AngleImgBegin:=True;
   end;
end;  {onMouseDown}


procedure TImgAnalysWnd.ImgChartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var dist,dx,dy:single;
begin
if DistBegin   then
 begin
   with ImgChart.Canvas do
    begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     MoveTo(X0,Y0);
     LineTo(X,Y);
    end;
     X1:=X;
     Y1:=Y;

     dx:=ImgChart.BottomAxis.CalcPosPoint(X)-chX0;
     dy:=ImgChart.LeftAxis.CalcPosPoint(Y)- chY0;

     dist:=sqrt(dx*dx+dy*dy);
     labeldistleft.Caption:=siLang1.GetTextOrDefault('IDS_12' (* 'Distance= ' *) )+FloatToStrF(Dist,fffixed,6,0)+
                                  ' '+Dat.captionY;
 end
 else if ( AngleImgBegin) then
  begin
   with ImgChart.Canvas do
    begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     MoveTo(X0,Y0);
     LineTo(X,Y);
     X1:=X;
     Y1:=Y;
    end;
    if SecondClick then
    begin
      dX:=ImgChart.BottomAxis.CalcPosPoint(X)-chX0;
      dY:=ImgChart.LeftAxis.CalcPosPoint(Y)-chY0;
      if dx<>0 then Angle1:=arctan2(dY,dX)
               else Angle1:=sign(dy)*pi/2;
      if Angle1<0 then Angle1:=2*pi-abs(Angle1);
      Angle:=Angle0-Angle1;
      Angle:=abs(Angle*180/pi);
      if Angle>180 then
      Angle:=360-Angle;
    //  Angle0:=Angle0*180/pi;
       labeldistleft.Caption:=siLang1.GetTextOrDefault('IDS_13' (* 'Angle= ' *) )+  FloatToStrF(Angle,fffixed,5,0)+#176;//' Degrees';
  end ;
end;
end;{onMouseMove}

procedure TImgAnalysWnd.ImgChartMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var dx,dy:single;
begin
if (DistBegin) or AngleImgBegin then

with ImgChart.Canvas do
   begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     Pen.Mode:=pmCopy;
     Pen.Color:=TColor($0200FF00);
     MoveTo(X0,Y0);
     LineTo(X,Y);
     X1:=X; Y1:=Y;
  end;

 if AngleImgBegin and SpeedBtnAngleImg.Down then
  begin
  if  not SecondClick then
    begin
      dX:=chX0-ImgChart.BottomAxis.CalcPosPoint(X);
      dY:=chY0-ImgChart.LeftAxis.CalcPosPoint(Y);
      if dx<>0 then  Angle0:=arctan2(dy,dx)
               else Angle0:=sign(dy)*pi/2;
      if Angle0 <0 then Angle0:=2*pi-abs(Angle0);
    end ;{not SecondClick}
   if (abs(X-X0)>5) or (abs(Y-Y0)>5) then SecondClick:=not SecondClick;
  end;
  DistBegin:=False;
  AngleImgBegin:=False;
end;{onMouseUp}

procedure RoughnessParam(Dat:tdata; var Ra,Rq:single);
var X,Y:integer;
i,j:integer;
Sum:double;
Aver:single;
begin
X:= Dat.Nx;
Y:=Dat.Ny;
Sum:=0;
Aver:=Dat.DataMean;
for i:=0 to Y-1 do
 for j:=0 to X-1 do Sum:=Sum+abs(Dat.Data[j,i]-Aver);
Ra:=Sum/X/Y;
Sum:=0;
for i:=0 to Y-1 do
 for j:=0 to X-1 do Sum:=Sum+(Dat.Data[j,i]-Aver)*(Dat.Data[j,i]-Aver);

Rq:=sqrt(Sum/X/Y);

end; {Roughness}

procedure TImgAnalysWnd.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
 FreeAndNil(SpectrumPicture);
 DeleteObject(hpal);
 FreeAndNil(Dat);//.data:=nil;
 if assigned(Template)      then FreeAndNil(Template);//.Data:=nil;
 if assigned(TemplateBuf)   then FreeandNil(TemplateBuf);
 if assigned(BackFFTResult) then FreeandNil(BackFFTResult); { TODO : 271007 }
 if assigned(DataFloatMas)  then FreeandNil(DataFloatMas);
 Action:=caFree;
 ImgAnalysWnd:=nil;  { TODO : 271007 }
end;

procedure TImgAnalysWnd.PageControlResultsChange(Sender: TObject);
var    i:integer;
begin
 TabSheetCurves.TabVisible:=false;
 TabSheetAutoLinCurve.TabVisible:=false;
 TabSheetBackFFT.TabVisible:=false;
 ZoomCount:=0;
 BitBtnZoomIn.Enabled:=true;
 BitBtnZoomOut.Enabled:=true;
 SpectrumChart.BottomAxis.SetMinMax(-FreqMax,FreqMax);
 SpectrumChart.LeftAxis.SetMinMax(-FreqMax,FreqMax);
 with PageControlResults do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
    ActivePage.HighLighted:=True;
  end;
//  IndicateLabel.Caption:=' ';
  labeldistleft.Caption:=' ';
  LabelInfoSpectr.Caption:=' ';
  if PageControlResults.ActivePage.name='tabSheetSpectr' then
   begin
    AddBitBtn.enabled:=False;
    BitBtnExecute.enabled:=False;
    EdSelected.Text:=FloattoStrF(SelectedAreaKoef,fffixed,5,2);
    cbUnSelected.ItemIndex:=0;
    ShowSpectrum(Dat);
   end
  else
   if PageControlResults.ActivePage.name='TabSheetCalibration' then
     begin
      ShowCalibration(Dat);
     end
  else
   if PageControlResults.ActivePage.name='TabSheetAutoLin' then
   begin
     ShowAutoLinearization(Dat);
   end;
end;

procedure TImgAnalysWnd.ImgChartAfterDraw(Sender: TObject);
var H0,W0,CH,CW,HeightChartNew,WidthChartNew:integer;
begin
if FlgImgChrtFirstDraw then
begin
 FlgImgChrtFirstDraw:=False;
 with ImgChart do
  begin
  H0:=Height;
  W0:=Width;
  CH:=ChartHeight;
  CW:=ChartWidth;
  if LX>=LY then
   begin
     HeightChartNew:=round(CW*LY/LX)+H0-CH;
     Height:= HeightChartNew;
     left:=1;
   end
   else
   begin
     WidthChartNew:=round(CH*LX/LY)+W0-CW;
     Width:= WidthChartNew;
     top:=1;
   end;
   Repaint;
  end;
  end;
end;

procedure TImgAnalysWnd.SpectrumChartAfterDraw(Sender: TObject);
var H0,W0,CH,CW,HeightChartNew,WidthChartNew:integer;
begin

end;

procedure TImgAnalysWnd.SpectrumChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Freq, Period:single;
i,j:integer;
begin
  if (Button=mbLeft) and (ssAlt in Shift) then
 begin
     if (left< (screen.workarealeft+10))
         or ((Top+height)>(Screen.workareatop+Screen.workareaheight)) then
    SetWindowPos(handle,HWND_TOP,screen.workarealeft+40,screen.workareatop+200,Width,Height,SWP_SHOWWINDOW);
(*     for  I := 0 to Screen.FormCount-1 do
      begin
       if  Screen.Forms[I].Formstyle=fsStayOnTop then Screen.Forms[I].Hide;
      end;
 *)
        RePaint;
        CopyToClipBoard;
        PostMessage (FormHandle, MsgBack, 2, 0);
 (*    for  I := 0 to Screen.FormCount-1 do
       begin
          if  Screen.Forms[I].Formstyle=fsStayOnTop then  Screen.Forms[I].Show;
       end;
  *)     
   exit;
 end;
  //SpectrumChart.Invalidate;//Repaint;
  With SpectrumChart do
    if SpeedBtnFreq.Down then
	  begin
    SpectrumChart.Invalidate;
     FreqBegin:=True;
	  end
    else
    if SpeedBtnAngle.Down then
     begin
      SpectrumChart.Invalidate;
      labeldistleft.Caption:=' ';
      with Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clblack;
        Width:=1;
        Mode:=pmnotXOR;
       end;
      X0:=ChartXCenter;//X;
      X1:=X;
      Y0:= ChartYCenter;//Y;
      Y1:=Y;
      XFreq:={BottomAxis.CalcPosPoint}(X)-X0;
      YFreq:={LeftAxis.CalcPosPoint}(Y)-Y0;
      if Xfreq<>0 then Angle0:=arctan2(YFreq,Xfreq)
                  else Angle0:=sign(Yfreq)*pi/2;
      AngleBegin:=True;
     end
     else // Choose areas for Filtration
     begin
         X0:=X;
         Y0:=Y;
         X0Pos:=ChartXCenter+1;
         Y0Pos:=ChartYCenter-1;
      if FlgNewFilter then
       begin
         SpectrumChart.Invalidate;
         FlgNewFilter:=False;
         if ImgAnalysWnd.cbUnSelected.ItemIndex=0 then
         NonSelectedAreaKoef:=0.0
         else NonSelectedAreaKoef:=1;
          for i:=0 to TNY-1 do
          for j:=0 to TNX-1do
            begin
              Template.data[j,i]:=NonSelectedAreaKoef;
            end;
       end;
      if  SpectrumChart.Canvas.Pen.Color<>clRed then
      begin
      with SpectrumChart.Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clblack;
        Width:=1;
        Mode:=pmnotXOR;
       end;
        SpectrumChart.Canvas.Arc(R.Left,R.Top,R.Right,R.Bottom,R.Left,R.Top,R.Left,R.Top);
        SpectrumChart.Canvas.Arc(RSym.Left,RSym.Top,RSym.Right,RSym.Bottom,RSym.Left,RSym.Top,RSym.Left,RSym.Top);
       end
       else
       with SpectrumChart.Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clblack;
        Width:=1;
        Mode:=pmnotXOR;
       end;
      R.TopLeft:=Point(X,Y);
      R.BottomRight:=Point(X,Y);
      X0Sym:=X0Pos+(X0Pos-X);
      Y0Sym:=Y0Pos+(Y0Pos-Y);
      RSym.TopLeft:=Point(X0Pos+(X0Pos-X),Y0Pos+(Y0Pos-Y));
      RSym.BottomRight:=Point(X0Pos+(X0Pos-X),Y0Pos+(Y0Pos-Y));
      FiltratBegin:=True;
    end;
end; {SpectrumChartMoseDown}

procedure TImgAnalysWnd.SpectrumChartMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
var dX,DY,DL:integer;
begin
 if ( AngleBegin) then
 begin
  with SpectrumChart.Canvas do
  begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     MoveTo(X0,Y0);
     LineTo(X,Y);
     X1:=X;
     Y1:=Y;
     XFreq:={SpectrumChart.BottomAxis.CalcPosPoint}(X)-X0;
     YFreq:={SpectrumChart.LeftAxis.CalcPosPoint}(Y)-Y0;
     if XFreq<>0 then Angle1:=arctan2(YFreq,Xfreq)
                 else Angle1:=sign(YFreq)*pi/2;
      Angle:=Angle0-Angle1;
      Angle:=abs(Angle*180/pi);
     if Angle>180 then   Angle:=360-Angle;
      LabelInfoSpectr.Caption:=siLang1.GetTextOrDefault('IDS_13' (* 'Angle= ' *) )+  FloatToStrF(Angle,fffixed,5,2)+#176;
  end;
end;
 if FiltratBegin then
   begin
    SpectrumChart.Canvas.Arc(R.Left,R.Top,R.Right,R.Bottom,R.Left,R.Top,R.Left,R.Top);
    SpectrumChart.Canvas.Arc(RSym.Left,RSym.Top,RSym.Right,RSym.Bottom,RSym.Left,
                                   RSym.Top,RSym.Left,RSym.Top);

     DX:=abs(X0-X);
     DY:=abs(Y0-Y);
     if DX>DY then DL:=DY else DL:=DX;
     DL:=round(sqrt(DX*DX+DY*DY));
    if (X0<X)then begin R.Left:=X0-DL; R.Right:=X0+DL;
                       RSym.Left:=X0Sym-DL; RSym.Right:=X0Sym+DL;  end
              else begin R.Left:=X0-DL; R.Right:=X0+DL;
                        RSym.Left:=X0Sym-DL; RSym.Right:=X0Sym+DL;   end;
     if (Y0<Y)then begin R.Top:=Y0-DL; R.Bottom:=Y0+DL;
                       RSym.Top:=Y0Sym-DL; RSym.Bottom:=Y0Sym+DL;end
              else begin R.Top:=Y0-DL; R.Bottom:=Y0+DL;
                       RSym.Top:=Y0Sym-DL; RSym.Bottom:=Y0Sym+DL;end;
      SpectrumChart.Canvas.Arc(R.Left,R.Top,R.Right,R.Bottom,R.Left,R.Top,R.Left,R.Top);
      SpectrumChart.Canvas.Arc(RSym.Left,RSym.Top,RSym.Right,RSym.Bottom,RSym.Left,
                                   RSym.Top,RSym.Left,RSym.Top);
  end;
end; {SpectrumChartMouseMove}

procedure TImgAnalysWnd.SpectrumChartMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Freq, Period:single;
    dX,DY,DL:integer;
    SpPixelW,SpPixelH:integer;
begin
if FreqBegin then
begin
with spectrumChart do
begin
 with Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clYellow;//clblack;
        Width:=1;
        Mode:=pmcopy;// pmnotXOR;
       end;
  //    Canvas.MoveTo( X0,Y0 );
	//    Canvas.LineTo( ChartXCenter, ChartYCenter );
      SpPixelW:=round(0.5*SpectrumChart.ChartWidth/BackImage.BitMap.Width);
      SpPixelH:=round(0.5*SpectrumChart.ChartHeight/BackImage.BitMap.Height);
    	Canvas.MoveTo( X,Y );
	    Canvas.LineTo( ChartXCenter+SpPixelW, ChartYCenter-SpPixelH );
      XFreq:=BottomAxis.CalcPosPoint(X)-BottomAxis.CalcPosPoint(ChartXCenter+SpPixelW);
      YFreq:=LeftAxis.CalcPosPoint(Y)-LeftAxis.CalcPosPoint(ChartYCenter-SpPixelH);;
      Freq:=sqrt(XFreq*XFreq+YFreq*YFreq);
      Period:=1/Freq;
   //   IndicateLabel.Caption:='Frequency= '+FloatToStrF(Freq,fffixed,8,5)+' 1/'+Measure1;
      LabelInfoSpectr.Caption:=siLang1.GetTextOrDefault('IDS_18' (* 'Freq= ' *) )+FloatToStrF(Freq,fffixed,8,5)+' 1/'+Dat.captionX;
      labeldistleft.Caption:=siLang1.GetTextOrDefault('IDS_20' (* 'Period= ' *) )+  FloatToStrF(Period,fffixed,7,1)+' '+Dat.captionX;
      X0:=X;
      y0:=Y;
     end;
end;
if (AngleBegin) then
 with SpectrumChart.Canvas do
  begin
    MoveTo(X0,Y0);
    LineTo(X1,Y1);
   //  Pen.Mode:=pmCopy;
    MoveTo(X0,Y0);
    LineTo(X,Y);
    X1:=X; Y1:=Y;
  end;
  AngleBegin:=False;
  FreqBegin:=False;
  if FiltratBegin then
   begin
    with RFreq do
        begin
         Left:=SpectrumChart.BottomAxis.CalcPosPoint(R.Left);
         Right:=SpectrumChart.BottomAxis.CalcPosPoint(R.Right);
         Top:=SpectrumChart.LeftAxis.CalcPosPoint(R.Top);
         Bottom:=SpectrumChart.LeftAxis.CalcPosPoint(R.Bottom);
        end;
   AddBitBtn.enabled:=True;
   FiltratBegin:=False;
  end;
end;  {SpectrumChart Mouse Up}

procedure TImgAnalysWnd.ClearImgSpeedBtnClick(Sender: TObject);
begin
 ImgChart.Repaint;
end;

(*procedure TImgAnalysWnd.ClearBitBtnClick(Sender: TObject);
begin
 SpectrumChart.Repaint;
 BitBtnExecute.Enabled:=False;
 AddBitBtn.Enabled:=False;
 BitBtnApplyFilt.Enabled:=False;
 FlgNewFilter:=True;
 with R do
   begin
     Left:=0;
     Right:=0;
     Top:=0;
     Bottom:=0;
   end;
end;
*)
procedure TImgAnalysWnd.GradientRect (FromRGB, ToRGB: TColor;Canvas:tcanvas;ZTop,ZBottom:integer);
var
    RGBFrom : array[0..2] of Byte; { from RGB values }
    RGBDiff : array[0..2] of integer; { difference of from/to RGB values }
    ColorBand : TRect; { color band rectangular coordinates }
    WhiteBand:TRect;
    BlackBand:TRect;
     I : Integer; { color band index }
     R : Byte; { a color band's R value }
     G : Byte; { a color band's G value }
     B : Byte; { a color band's B value }
     h,h0,iL,iR:integer;
begin
  { extract from RGB values}
  RGBFrom[0] := GetRValue (ColorToRGB (FromRGB));
  RGBFrom[1] := GetGValue (ColorToRGB (FromRGB));
  RGBFrom[2] := GetBValue (ColorToRGB (FromRGB));
  { calculate difference of from and to RGB values}
  RGBDiff[0] := GetRValue (ColorToRGB (ToRGB)) - RGBFrom[0];
  RGBDiff[1] := GetGValue (ColorToRGB (ToRGB)) - RGBFrom[1];
  RGBDiff[2] := GetBValue (ColorToRGB (ToRGB)) - RGBFrom[2];

  { set pen sytle and mode}
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Mode := pmCopy;
  h0:=(canvas.ClipRect.Bottom-Canvas.ClipRect.Top);
  h:=h0-round(h0*(Ztop+255-Zbottom)/255);
  { set color band's left and right coordinates}
   iL:=round(h0*Ztop/255);
   ColorBand.Left := 0;
   ColorBand.Right:=Canvas.ClipRect.Right-Canvas.ClipRect.left;
   WhiteBand.Left := 0;
   WhiteBand.Right:=Canvas.ClipRect.Right-Canvas.ClipRect.left;
   WhiteBand.Top:=0;
   WhiteBand.Bottom:=iL;
   iR:=round(h0*ZBottom/255);
   BlackBand.Top:=iR;
   BlackBand.Bottom:=Canvas.ClipRect.Bottom;
   BlackBand.Left := 0;
   BlackBand.Right:=Canvas.ClipRect.Right-Canvas.ClipRect.left;
   for I := 0 to $ff do
     begin
      { calculate color band's top and bottom coordinates}
      ColorBand.Top := MulDiv (I , h, $100)+iL;
      ColorBand.Bottom := MulDiv (I + 1,h, $100)+iL;
      { calculate color band color}
       R := RGBFrom[0] + MulDiv (I, RGBDiff[0], $ff);
       G := RGBFrom[1] + MulDiv (I, RGBDiff[1], $ff);
       B := RGBFrom[2] + MulDiv (I, RGBDiff[2], $ff);
       { select brush and paint color band}
       Canvas.Brush.Color := RGB (R, G, B);
       Canvas.FillRect (ColorBand);
     end;
       Canvas.Brush.Color :=$00FFFFFF;
       Canvas.FillRect (WhiteBand);
       Canvas.Brush.Color :=$00000000;
       Canvas.FillRect (BlackBand);
end;  procedure TImgAnalysWnd.GrBoxNonLinCorrClick(Sender: TObject);
begin

end;

{GradientRect}


procedure TImgAnalysWnd.FormResize(Sender: TObject);
begin
 if ( initSensX <=0 ) or ( initSensY <=0 )or ( LX <=0 ) or  ( LY <=0 ) then exit;
   SetWindowsSize;

   LXCal:=round(Dat.Nx*sensX1/initSensX);//NInterpX;
   LYCal:=round(Dat.Ny*sensY1/initSensY);
   BuildChart(ImgCalibrateChart,PanelRightchart.ClientWidth,
                   PanelRightchart.ClientHeight,LXCal,LYCal);
(*with ImgCalibrateChart do
begin
 if LX>=LY then
   begin
    Width:=PanelRightchart.Width-20;
    Height:=round((Width-ChartFieldX)*LY/LX)+ChartFieldY;
    Left:=1;
    Top:=PanelRightchart.Height div 2-Height div 2;
   end
   else
   begin
     Height:=PanelRightchart.Height-20;
     Width:= round((Height-ChartFieldY)*LX/LY)+ChartFieldX;
     Top:=1;
     left:=(PanelRightchart.Width ) div 2-Width div 2;
   end;
 end; *){with}
 with ImgChart do
 begin
  if LX>=LY then
   begin
    Width:=Panelleftchart.Width-PanelZ.Width;//-20
    Height:=round((Width-ChartFieldX)*LY/LX)+ChartFieldY;
    Left:=1;
    Top:=Panelleftchart.Height div 2-Height div 2;
   end
   else
   begin
     Height:=Panelleftchart.Height;//-20;
     Width:= round((Height-ChartFieldY)*LX/LY)+ChartFieldX;
     Top:=1;
     left:=(Panelleftchart.Width -PanelZ.Width) div 2-Width div 2;
   end;
 end;

  with BackFFTChart do
 begin
  if LX>=LY then
   begin
    Width:=Panelleftchart.Width-20-PanelZ.Width;
    Height:=round((Width-ChartFieldX)*LY/LX)+ChartFieldY;
    Left:=1;
    Top:=Panelleftchart.Height div 2-Height div 2;
   end
   else
   begin
     Height:=Panelleftchart.Height-20;
     Width:= round((Height-ChartFieldY)*LX/LY)+ChartFieldX;
     Top:=1;
     left:=(Panelleftchart.Width -PanelZ.Width) div 2-Width div 2;
   end;
 end;
end;


procedure TImgAnalysWnd.BitBtnApplyClick(Sender: TObject);
var
  SensX1,SensY1:single;
  ss:string;
begin
FlgCalibrChrtFirstDraw :=true;
ss:=EdSensX.Text;
if ss='' then
  begin
   ss:=FloatTostrF(initSensX,fffixed,6,2);
   EdSensX.Text:=ss;
  end;
SensX1:=StrtoFloat(ss);
ss:=EdSensY.Text;
if ss='' then
  begin
   ss:=FloatTostrF(initSensY,fffixed,6,2);
   EdSensY.Text:=ss;
  end;
SensY1:=StrtoFloat(ss);

 LXCal:=round(Dat.Nx*SensX1/InitSensX);
 LYcal:=round(Dat.Ny*SensY1/InitSensY);
 with ImgCalibrateChart do
  begin
   LeftAxis.SetMinMax( 0, LYCal*Step );
   BottomAxis.SetMinMax( 0, LXCal*Step );
  end;
 BuildChart(ImgCalibrateChart,PanelRightchart.ClientWidth, PanelRightchart.ClientHeight,LXCal,LYCal);
end;

procedure TImgAnalysWnd.BuildChart(IChart:TChart; LimWidth,LimHeight:integer; NX,NY:single);
begin
 with IChart do
 if NX>=NY then
   begin
    Width:=LimWidth-2;//-20;//PanelRightchart.Width-20;
    Height:=round((Width-ChartFieldX)*NY/NX)+ChartFieldY;
    Left:=1;
    Top:=LimHeight{PanelRightchart.Height} div 2-Height div 2;
   end
   else
   begin
     Height:=LimHeight-2;//{PanelRightchart.Height}-20;
     Width:= round((Height-ChartFieldY)*NX/NY)+ChartFieldX;
     Top:=1;
     left:=(PanelRightchart.Width ) div 2-Width div 2;
   end;
   IChart.Title.caption:='';
end;

procedure TImgAnalysWnd.ImgCalibrateChartAfterDraw(Sender: TObject);
var H0,W0,CH,CW,HeightChartNew,WidthChartNew:integer;
begin
//if FlgCreate then
if FlgCalibrChrtFirstDraw then
 begin
 FlgCalibrChrtFirstDraw:=False;
 with ImgCalibrateChart do
  begin
  H0:=Height;
  W0:=Width;
  CH:=ChartHeight;
  CW:=ChartWidth;

  if LXCal>=LYCal then
   begin
     HeightChartNew:=round(CW*LYCal/LXCal)+H0-CH;
     Height:= HeightChartNew;
   end
   else
   begin
     WidthChartNew:=round(CH*LXCal/LYCal)+W0-CW;
     Width:= WidthChartNew;
   end;
   repaint;
  end;
 end;
end;


procedure TImgAnalysWnd.BitBtnNonLinCorrClick(Sender: TObject);
var ZInterp2D:TMas2;
ZRes:TData;
i,j:integer;
NInterpX,NInterpY:integer;
BitMap:TBitMap;

  ss:string;
begin
FlgCalibrChrtFirstDraw :=true;
// Вставлено 24/07/2013  ,
// чтобы учитывать при перерисовке новую чувствительность
(*ss:=EdSensX.Text;
if ss='' then
  begin
   ss:=FloatTostrF(initSensX,fffixed,6,2);
   EdSensX.Text:=ss;
  end;
SensX1:=StrtoFloat(ss);
ss:=EdSensY.Text;
if ss='' then
  begin
   ss:=FloatTostrF(initSensY,fffixed,6,2);
   EdSensY.Text:=ss;
  end;
SensY1:=StrtoFloat(ss);   *)
// 1) read File Header
// 2) read Linearization data
//
//BitBtnNonLinCorr.Enabled:=False;

LinerizDataOut(SeriesLinX,LinerizDataX, NLinX, NonLinFieldX);
LinerizDataOut(SeriesLinY,LinerizDataY, NLinY, NonLinFieldY);
PageControl1.ActivePageIndex:=1;
TabSheetCurves.TabVisible:=True;
NonLinearInterp(Dat,ZInterp2D,NInterpX,NInterpY);

// 3) Draw Image
 ZRes:=TData.Create;
 ZRes.Nx:=NInterpX;
 ZRes.Ny:=NInterpY;
 SetLength(ZRes.data,NInterpX,NInterpY);
 for i:=0 to NInterpY-1 do
  for j:=0 to NInterpX-1 do ZRes.data[j,i]:=ZInterp2D[i,j];
 Dmin:=ZRes.datamin;
 Dmax:=ZRes.datamax;
 BitMap:=TBitMap.Create;
 DrawData(BitMap,ZRes);
 LXCal:=round(Dat.Nx*sensX1/initSensX);//NInterpX;
 LYCal:=round(Dat.Ny*sensY1/initSensY);// NInterpY;
 with ImgCalibrateChart do
begin
 LeftAxis.SetMinMax( 0, LYCal*Step );
 LeftAxis.Title.Angle:=90;
 LeftAxis.Title.Caption:=Dat.captionY;
 BottomAxis.SetMinMax( 0, LXCal*Step );
 BottomAxis.Title.Caption:=Dat.captionX;
 (* if LXCal>=LYCal then
   begin
    Width:=PanelRightchart.Width-20;
    Height:=round((Width-ChartFieldX)*LYCal/LXCal)+ChartFieldY;
    Left:=0;
    Top:=PanelRightchart.Height div 2-Height div 2;
   end
   else
   begin
     Height:=PanelRightchart.Height-20;
     Width:= round((Height-ChartFieldY)*LXCal/LYCal)+ChartFieldX;
     Top:=0;
     left:=(PanelRightchart.Width ) div 2-Width div 2;
   end;     *)
  BackImage.Assign(BitMap);
  FreeAndNil(Bitmap);
  BackImageInside:=True;
end; {with}
 BuildChart(ImgCalibrateChart,PanelRightchart.ClientWidth, PanelRightchart.ClientHeight,LXCal,LYCal);
 Invalidate;
 FreeAndnil(ZRes);//.data:=nil;
  Zinterp2D:=nil;
end;

procedure TImgAnalysWnd.ImgCalibrateChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if  SpeedBtnCalibrDist.Down   then
 begin
  ImgCalibrateChart.Repaint;
  X0:=X; X1:=X;
  y0:=Y; Y1:=Y;
  chX0:=ImgCalibrateChart.BottomAxis.CalcPosPoint(X0);
  chY0:=ImgCalibrateChart.LeftAxis.CalcPosPoint(Y0);
 end ;

With ImgCalibrateChart do
    if SpeedBtnCalibrDist.Down then
	  begin
           with Canvas.Pen do
       begin
       Style:=psSolid;
        Color:=clBlue;//brush.color;
        Width:=1;
        Mode:=pmnotXOR;
       end;
   //  Canvas.MoveTo(X0,Y0);
    // Canvas.LineTo(X1,Y1);

     DistBegin:=True;
	  end ;
end;

procedure TImgAnalysWnd.ImgCalibrateChartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var dist,dx,dy:single;
begin
if DistBegin   then
 begin
   with ImgCalibrateChart.Canvas do
    begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     MoveTo(X0,Y0);
     LineTo(X,Y);
    end;
     X1:=X;
     Y1:=Y;
     dx:=ImgCalibrateChart.BottomAxis.CalcPosPoint(X)-chX0;
     dy:=ImgCalibrateChart.LeftAxis.CalcPosPoint(Y)- chY0;
     dist:=sqrt(dx*dx+dy*dy);
     LabelDist.Caption:=siLang1.GetTextOrDefault('IDS_21' (* 'Distance=   ' *) )+FloatToStrF(Dist,fffixed,6,2)+
                                  ' '+Dat.captionX;
 end;
end;

procedure TImgAnalysWnd.ImgCalibrateChartMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var dx,dy:single;
begin
if (DistBegin)  then
 with ImgCalibrateChart.Canvas do
 begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     Pen.Mode:=pmCopy;
     Pen.Color:=TColor($0200FF00);
     MoveTo(X0,Y0);
     LineTo(X,Y);
     X1:=X; Y1:=Y;
 end;
 DistBegin:=False;
end;

function TImgAnalysWnd.ReadScannerParams(Direction:string; var LSection:ArraySpline;
                    var NSplines, NonLinField:integer):integer;
var
  i:integer;
  Buf:float;
  iniCSPM:TiniFile;
  sFile:string;
begin
  Result:=0;
  NSplines:=1;
  iniCSPM:=TIniFile.Create(
  ScannerFileDLL);
  with iniCSPM do
   begin
     if not SectionExists(ScannerNameDLL) then
     begin
      Result:=-1;
      exit;
     end;
     NSplines:=ReadInteger((ScannerNameDLL), Direction+'Points Number',1);
     GridCellSize:=ReadInteger((ScannerNameDLL), 'Grid Cell Size', 3000);
     NonLinField:=ReadInteger((ScannerNameDLL),'NonLiniar Field '+Direction , 25000);
    for i:=1 to NSplines do
      begin
        LSection[i]:= ReadFloat((ScannerNameDLL), Direction+IntToStr(i),0);
      end;
   end;
 Buf:=LSection[1];
 for i:=1 to NSpLines do
  begin
   LSection[i]:=LSection[i]-Buf;
  end;
  iniCSPM.Free;
end; {ReadScannerParams}

function TImgAnalysWnd.ReadShortScannerParams(Direction:string;
                    var NonLinField:integer):integer;
var
  i:integer;
  Buf:float;
  iniCSPM:TiniFile;
  sFile:string;
begin
  Result:=0;
  iniCSPM:=TIniFile.Create(ScannerFileDLL);
  with iniCSPM do
   begin
     if not SectionExists(ScannerNameDLL) then
     begin
      Result:=-1;
      exit;
     end;

     GridCellSize:=ReadInteger((ScannerNameDLL), 'Grid Cell Size', 3000);
     NonLinField:=ReadInteger((ScannerNameDLL),'NonLiniar Field '+Direction , 25000);
  end;
  iniCSPM.Free;
end; {ReadShortScannerParams}

procedure  TImgAnalysWnd.LinerizDataOut(LDataGraph:TLineSeries; LinerizData:ArraySpline;
                                        NLin,NonLinField:integer);

var
i,j:integer;
DistArray:ArraySpline;
begin
 LDataGraph.Clear;
 for i:=1 to NLin-1 do
  begin
    DistArray[i]:=LinerizData[i+1]-LinerizData[i];
    LDataGraph.AddXY(GridCellSize*i,DistArray[i]);
  end;
end; {LinerizDataOut}

procedure TImgAnalysWnd.SeriesLinYClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var YCh:single;
Val1,Val2:single;
begin
PointNumb:=ValueIndex;

if PointNumb >0 then Val1:=SeriesLinY.XValues[PointNumb-1]
                else Val1:=SeriesLinY.XValues[0]-Step;
if PointNumb<SeriesLinY.Count-1 then Val2:=SeriesLinY.XValues[PointNumb+1]
                 else Val2:=SeriesLinY.XValues[SeriesLinY.Count-1]+Step;
 PrevPointX:=Chart1.BottomAxis.CalcPosValue(Val1);
 NextPointX:=Chart1.BottomAxis.CalcPosValue(Val2);
 CYBegin:=true;
 LinYChanged:=True;
end;

procedure TImgAnalysWnd.Chart1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if CYBegin or CXBegin then MouseBegin:=True;
end;

procedure TImgAnalysWnd.Chart1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var XCh,YCh:single;
begin
if MouseBegin then
 if CYBegin  then
  begin
    with SeriesLinY do
      begin
        if PointNumb<=Count-1 then
         begin
         if (X<NextPointX )and (X>PrevPointX )then
          begin
           XCh:=SeriesLinY.XValues[PointNumb];
           Delete(PointNumb);
           YCh:=Chart1.LeftAxis.CalcPosPoint(Y);
           AddXY(XCh,YCh);
          end;
         end;
      end;
  end
  else
  if CXBegin  then
  begin
    with SeriesLinX do
      begin
       if PointNumb<=Count-1 then
        begin
         if (X<NextPointX )and (X>PrevPointX )then
         begin
           XCh:=SeriesLinX.XValues[PointNumb];
           Delete(PointNumb);
           YCh:=Chart1.LeftAxis.CalcPosPoint(Y);
           AddXY(XCh,YCh);
         end;
        end;
      end;
  end;
end;

procedure TImgAnalysWnd.Chart1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
ZInterp2D:TMas2;
ZRes:TData;
i,j:integer;
NInterpX,NInterpY:integer;
ErrCod:integer;
BitMap:TBitMap;
begin
 if MouseBegin then
  begin
   LinerizDataY[1]:=0;
   LinerizDataX[1]:=0;
  for i:=2 to SeriesLinY.Count+1 do
  begin
    LinerizDataY[i]:=LinerizDataY[i-1]+SeriesLinY.YValues[i-2];
  end;
  for i:=2 to SeriesLinX.Count+1 do
  begin
    LinerizDataX[i]:=LinerizDataX[i-1]+SeriesLinX.YValues[i-2];
  end;
NonLinearInterp(Dat,ZInterp2D,NInterpX,NInterpY);
// 3) Draw Image
 ZRes:=TData.Create;
 ZRes.Nx:=NInterpX;
 ZRes.Ny:=NInterpY;
 SetLength(ZRes.data,NInterpX,NInterpY);
 for i:=0 to NInterpY-1 do
  for j:=0 to NInterpX-1 do  ZRes.data[j,i]:=ZInterp2D[i,j];
 Dmin:=ZRes.datamin;
 Dmax:=ZRes.datamax;
 BitMap:=TBitMap.Create;
 DrawData(BitMap,ZRes);
 LXCal:=round(Dat.Nx*sensX1/initSensX);//NInterpX;
 LYCal:=round(Dat.Ny*sensY1/initSensY);// NInterpY;
 FlgCalibrChrtFirstDraw:=True;
 with ImgCalibrateChart do
begin
 LeftAxis.SetMinMax( 0, LYCal*Step );
 LeftAxis.Title.Angle:=90;
 LeftAxis.Title.Caption:=Dat.captionY;
 BottomAxis.SetMinMax( 0, LXCal*Step );
 BottomAxis.Title.Caption:=Dat.captionX;
 (* if LXCal>=LYCal then
   begin
    Width:=PanelRightchart.Width-20;
    Height:=round((Width-ChartFieldX)*LYCal/LXCal)+ChartFieldY;
    Left:=0;
    Top:=PanelRightchart.Height div 2-Height div 2;
   end
   else
   begin
     Height:=PanelRightchart.Height-20;
     Width:= round((Height-ChartFieldY)*LXCal/LYCal)+ChartFieldX;
     Top:=0;
     left:=(PanelRightchart.Width ) div 2-Width div 2;
   end;  *)
  BackImage.Assign(BitMap);
  FreeAndNil(Bitmap);
  BackImageInside:=True;
  FreeAndNil(ZRes);//.data:=nil;
  Zinterp2D:=nil;
end; {with}
BuildChart(ImgCalibrateChart,PanelRightchart.ClientWidth,
                              PanelRightchart.ClientHeight,LXCal,LYCal);
  MouseBegin:=False;
  CYBegin:=False;
  CXBegin:=False;
 end;
end;

procedure TImgAnalysWnd.SeriesLinXClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var XCh:single;
Val1,Val2:single;
begin
PointNumb:=ValueIndex;
if PointNumb >0 then Val1:=SeriesLinX.XValues[PointNumb-1]
                else Val1:=SeriesLinX.XValues[0]-Step;
//if PointNumb<Count then
if PointNumb<SeriesLinX.Count-1 then Val2:=SeriesLinX.XValues[PointNumb+1]
                                else Val2:=SeriesLinX.XValues[SeriesLinX.Count-1]+Step;
PrevPointX:=Chart1.BottomAxis.CalcPosValue(Val1);
NextPointX:=Chart1.BottomAxis.CalcPosValue(Val2);
CXBegin:=true;
LinXChanged:=True;
end;

procedure TImgAnalysWnd.BitBtnSaveSensClick(Sender: TObject);
var SensX,SensY:single;
 k:integer;
  iniCSPM:TiniFile;
  sFile:string;
begin
 flgSaveProcess:=true;
 SensX:=StrToFloat(EdSensX.Text);
 SensY:=StrTofloat(EdSensY.Text);
 SetFileAttribute_ReadOnly(ScannerFileDLL,false);
 iniCSPM:=TIniFile.Create(ScannerFileDLL);
try
  with iniCSPM do
   begin
    try
     WriteString((ScannerNameDLL),'SensitivX', FloatToStrF(SensX,ffFixed,6,2));
    except
     on IO: EInOutError do
        begin
            case IO.Errorcode  of
       104:  MessageDlg(str1{'error write flash'},mtWarning,[mbOk],0);
               end;
        end;
     else
       begin
        flgSaveProcess:=false;
        siLang1.MessageDlg(str1{'error write flash'},mtWarning,[mbOk],0);
        iniCSPM.free;
        Exit;
        end;
      end;
      WriteString((ScannerNameDLL),'SensitivY', FloatToStrF(SensY,ffFixed,6,2));
   end;
finally
 iniCSPM.Free;
end;
  SetFileAttribute_ReadOnly(ScannerFileDLL,true);
   if ScanModeDLL=0 then     StoreSensitivToAdapter(PAdapterOptModX)
                    else     StoreSensitivToAdapter(PAdapterOptModY);

  flgSaveProcess:=false;
 // if ApproachOptFormHandle<>0 then PostMessage(ApproachOptFormHandle,MsgApproachOptBack,0,0);
 // if ScanFormHandle<>0        then PostMessage(ScanFormHandle, MsgScanBack,0,0);
 if assigned(ApproachOpt) then PostMessage(ApproachOpt.Handle,MsgApproachOptBack,0,0);
 if assigned(ScanWnd)     then PostMessage(ScanWnd.Handle, MsgScanBack,0,0);
end;

procedure TImgAnalysWnd.BitBtnSaveClick(Sender: TObject);
var NLinFieldX, NLinFieldY:integer;
 i:integer;
  iniCSPM:TiniFile;
  sFile:string;
     Present: TDateTime;
   presentdate:string;
   Year, Month, Day, Hour, Minute, Sec, MSec: Word;

begin
 flgSaveProcess:=true;
 RealSens :=0;        // Вставлено 22.11.2016, чтобы исправить ситуацию обнуления чувствительностей
                      // теперь если  RealSens =0, перезапись чувствит. в структурах не производится
 NLinFieldX:=StrToInt(EdNonLinFieldX.Text);
 NLinFieldY:=StrToInt(EdNonLinFieldY.Text);
 SetFileAttribute_ReadOnly(ScannerFileDLL,false);
try
 iniCSPM:=TIniFile.Create(ScannerFileDLL);
 with iniCSPM do
   begin
    // NonLinField:=ReadInteger((ScannerNameDLL),'NonLiniar Field '+Direction , 25000);
   try
     WriteInteger(ScannerNameDLL, 'NonLiniar Field X', NLinFieldX );
   except
     on IO: EInOutError do
        begin
            case IO.Errorcode  of
       104:  siLang1.MessageDlg(str1{'error write flash'},mtWarning,[mbOk],0);
               end;
        end;
   else
       begin
        flgSaveProcess:=false;
        siLang1.MessageDlg(str1{'error write flash'},mtWarning,[mbOk],0);
        iniCSPM.free;
        Exit;
        end;
   end;
   WriteInteger(ScannerNameDLL, 'NonLiniar Field Y', NLinFieldY );
    if LinXChanged then
      begin
        for i:=1 to  NLinX do
           WriteString((ScannerNameDLL), 'X'+IntToStr(i),
                  FloatToStrF(LinerizDataX[i],ffFixed,5,1));

           for i:=1 to  NLinX do
              LinerizData[i]:= LinerizDataX[i];
           WriteToAdapterLinStructure('X', ScanModeDLL,NlinX,NLinFieldX, presentdate);
      end;
    if LinYChanged then
      begin
        for i:=1 to  NLinY do
           WriteString((ScannerNameDLL), 'Y'+IntToStr(i),
                  FloatToStrF(LinerizDataY[i],ffFixed,5,1));


           for i:=1 to  NLinY do
              LinerizData[i]:= LinerizDataY[i];
           WriteToAdapterLinStructure('Y', ScanModeDLL,NlinY,NLinFieldY, presentdate);
      end;
   end;
finally
 iniCSPM.Free;
end;
 SetFileAttribute_ReadOnly(ScannerFileDLL,true);
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minute, Sec, MSec);
  presentdate:=intTostr(day)+'-'+inttostr(month)+'-'+inttostr(year);


 WriteToAdapterLinStructure('Y', ScanModeDLL,NLinY,NLinFieldY, presentdate);
 LoadLinSplineFromAdapter;    // изменено 22/11/2016
 flgSaveProcess:=false;
 if assigned(ApproachOpt) then PostMessage(ApproachOpt.Handle,MsgApproachOptBack,0,0);
 if assigned(ScanWnd)     then PostMessage(ScanWnd.Handle, MsgScanBack,0,0);
// if ScanFormHandle<>0        then PostMessage(ScanFormHandle, MsgScanBack,1,0);
//   if ApproachOptFormHandle<>0 then PostMessage(ApproachOptFormHandle, MsgApproachOptBack,1,0);

///copy to scannery.ini!!!!!!!!!!!!!!!!
 end;

procedure TImgAnalysWnd.SpeedBtnCalibrDistClick(Sender: TObject);
begin
if  not SpeedBtnCalibrDist.Down then
      begin
        LabelDist.Caption:='';
        ImgCalibrateChart.repaint;
      end;
end;

procedure TImgAnalysWnd.SpeedBtnDistClick(Sender: TObject);
begin
 if  not SpeedBtnDist.Down then
      begin
        labeldistleft.Caption:='';
        ImgChart.repaint;
      end;
end;

procedure TImgAnalysWnd.CalcChartFields(Chart:TChart);
begin
 ChartFieldX:=40;
 ChartFieldY:=40;
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
     Chart.MarginLeft:=20;
     Chart.MarginRight:=15;
     Chart.LeftAxis.Title.caption:=' ';
     Chart.Title.Text.Add(siLang1.GetTextOrDefault('IDS_4' (* 'nm' *) ));
     ChartFieldX:=ChartFieldX+Chart.LeftAxis.LabelsSize+Chart.MarginLeft+
                              Chart.MarginRight;
   end;
(* if LX/LY <1 then
  begin

     Chart.MarginLeft:=15;
   //  Chart.MarginRight:=10;
      ChartFieldX:=ChartFieldX+Chart.LeftAxis.LabelsSize+Chart.MarginLeft+
                              Chart.MarginRight;
   end;   *)

end;
procedure TImgAnalysWnd.AddBitBtnClick(Sender: TObject);
begin
  AddSelected();
  BitBtnExecute.Enabled:=true;
end;

procedure TImgAnalysWnd.BitBtnExecuteClick(Sender: TObject);
var BitMap:TBitMap;
begin
  BitBtnExecute.Enabled:=False;
  AddBitBtn.Enabled:=False;
  ExecuteFiltrat();
  TabSheetBackFFT.TabVisible:=True;
  PageControl1.ActivePageIndex:=2;
  with BackFFTChart do
    begin
       Left:=ImgChart.Left;
       Top:= ImgChart.Top;
       Width:=ImgChart.Width;
       Height:=ImgChart.Height;
    end;

    BitMap:=TBitMap.Create;
    Dmin:=BackFFTResult.min;
    Dmax:=BackFFTResult.max;
    ImgAnalysWnd.DrawdataFloat(BitMap,BackFFTResult);
    with BackFFTChart do
      begin
        BackImage.Assign(BitMap);
        BackImageInside:=True;
        BackImageMode:=pbmStretch;
      end;
  FreeAndNil(Bitmap);
  FlgNewFilter:=True;
  //DataFloatMas.data:=nil;
  FloatMasInit(Dat);
  FiltrationInit(DataFloatMas);
  BitBtnApplyFilt.Enabled:=True;
{  R.TopLeft:=Point(0,0);
  R.BottomRight:=Point(0,0);
   RSym.TopLeft:=Point(0,0);
  RSym.BottomRight:=Point(0,0);   }
end;

procedure TImgAnalysWnd.BitBtnHelpClick(Sender: TObject);
begin
   HlpContext:= IDH_Image_Analysis;  //51;//
   Application.HelpContext(HlpContext);
end;

procedure TImgAnalysWnd.BackFFTChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if (Button=mbLeft) and (ssAlt in Shift) then
 begin
   CopyToClipBoard;
   PostMessage (FormHandle, MsgBack, 2, 0);
   exit;
 end;

 if  SpeedBtnDistBackFFT.Down or SpeedBtnAngleBackFFT.Down then
 if not SecondClick then
  begin
   BackFFTChart.Repaint;
   X0:=X; X1:=X;
   y0:=Y; Y1:=Y;
   chX0:=BackFFTChart.BottomAxis.CalcPosPoint(X0);
   chY0:=  BackFFTChart.LeftAxis.CalcPosPoint(Y0);
  end
  else {SecondClick}
  begin
   X0:=X1;
   Y0:=Y1;
   chX0:=BackFFTChart.BottomAxis.CalcPosPoint(X0);
   chY0:=  BackFFTChart.LeftAxis.CalcPosPoint(Y0);
   With BackFFTChart do
   begin
    with Canvas.Pen do
       begin
       Style:=psSolid;
        Color:=clBlue;//brush.color;
        Width:=1;
        Mode:=pmnotXOR;
       end;
    Canvas.MoveTo(X0,Y0);
    Canvas.LineTo(X,Y);
   end;
  end;
  X1:=X;
  y1:=Y;
 With BackFFTChart do
  if SpeedBtnDistBackFFT.Down then
	  begin
           with Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clBlue;//brush.color;
        Width:=1;
        Mode:=pmnotXOR;
       end;
    //  Canvas.MoveTo(X0,Y0);
    // Canvas.LineTo(X1,Y1);
     DistBegin:=True;
	  end
    else if SpeedBtnAngleBackFFT.Down then
    begin
      labeldistleft.Caption:=' ';
     with Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clblue;//clblack;
        Width:=1;
        Mode:=pmnotXOR;
       end;
     AngleImgBegin:=True;
   end;
end;

procedure TImgAnalysWnd.BackFFTChartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
 var dist,dx,dy:single;
begin
if DistBegin   then
begin
   with BackFFTChart.Canvas do
    begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     MoveTo(X0,Y0);
     LineTo(X,Y);
    end;
     X1:=X;
     Y1:=Y;
     dx:=BackFFTChart.BottomAxis.CalcPosPoint(X)-chX0;
     dy:=BackFFTChart.LeftAxis.CalcPosPoint(Y)- chY0;
     dist:=sqrt(dx*dx+dy*dy);
     LabelinfoBackFFT.Caption:=siLang1.GetTextOrDefault('IDS_12' (* 'Distance= ' *) )+FloatToStrF(Dist,fffixed,6,2)+
                                  ' '+Dat.captionX;
     end
 else if ( AngleImgBegin) then
 begin
 with BackFFTChart.Canvas do
  begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     MoveTo(X0,Y0);
     LineTo(X,Y);
     X1:=X;
     Y1:=Y;
   end;
    if SecondClick then
    begin
      dX:=BackFFTChart.BottomAxis.CalcPosPoint(X)-chX0;
      dY:=BackFFTChart.LeftAxis.CalcPosPoint(Y)-chY0;
      if dx<>0 then Angle1:=arctan2(dY,dX)
               else Angle1:=sign(dy)*pi/2;
      if Angle1<0 then Angle1:=2*pi-abs(Angle1);
      Angle:=Angle0-Angle1;
      Angle:=abs(Angle*180/pi);
      if Angle>180 then Angle:=360-Angle;
    //  Angle0:=Angle0*180/pi;
      LabelinfoBackFFT.Caption:=siLang1.GetTextOrDefault('IDS_13' (* 'Angle= ' *) )+  FloatToStrF(Angle,fffixed,5,2)+#176;
  end ;
end;
end;

procedure TImgAnalysWnd.BackFFTChartMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var dx,dy:single;
begin
if (DistBegin) or AngleImgBegin then
 with BackFFTChart.Canvas do
  begin
     MoveTo(X0,Y0);
     LineTo(X1,Y1);
     Pen.Mode:=pmCopy;
     Pen.Color:=TColor($0200FF00);
     MoveTo(X0,Y0);
     LineTo(X,Y);
     X1:=X; Y1:=Y;
  end;
 if AngleImgBegin and SpeedBtnAngleBackFFT.Down then
  begin
  if  not SecondClick then
    begin
      dX:=chX0-BackFFTChart.BottomAxis.CalcPosPoint(X);
      dY:=chY0-BackFFTChart.LeftAxis.CalcPosPoint(Y);
      if dx<>0 then Angle0:=arctan2(dy,dx)
               else Angle0:=sign(dy)*pi/2;
      if Angle0 <0 then Angle0:=2*pi-abs(Angle0);
    end ;{not SecondClick}
     if (abs(X-X0)>5) or (abs(Y-Y0)>5) then  SecondClick:=not SecondClick;
  end;
  DistBegin:=False;
  AngleImgBegin:=False;
end;

(*procedure TImgAnalysWnd.SpeedButton3Click(Sender: TObject);
begin

 BackFFTChart.Repaint;
end;
*)
procedure TImgAnalysWnd.FileAutoLinearization(Dir:String);
var
 i:integer;
 LinLine:TLine;
 MaxPointsArray:TLine;
 L:integer;
 LocalMaxPos:TLine;
 DistArray:ArraySpline;
 SensKoef:Single;
 PointNumb:integer;
 AverageDist, Disperce, Sigma, Sum:single;
 NormAverageDist, NormSigma:single;
begin
 try
  if Dir='X' then
  begin
   L:=Dat.NX;
   SetLength(LinLine,L);
   for i:=0 to L-1 do   LinLine[i]:=Dat.Data[i,Dat.NY-1];  // Last ScanLine of Data
  end
  else
   begin
    L:=Dat.NY;
    SetLength(LinLine,L);
    for i:=0 to L-1 do LinLine[i]:=Dat.Data[Dat.NX-1,i];  // Last ScanLine of Data
  end;

  ConvolutionI(LinLine,3);
  Series6.Clear;
  Series9.Clear;
  Series8.Clear;
  for i:=0 to L-1 do  Series6.AddXY(i*Dat.XStep,LinLine[i]);
  LocalMaxPos:=nil;
  LocalMaxPos:=LocalMax(LinLine,LocMaxCount);
  SensKoef:=1;
  if  LocMaxCount>3 then
   begin
    for i:=0 to LocMaxCount-1 do
    Series8.AddXY(LocalMaxPos[i]*Dat.XStep,LinLine[LocalMaxPos[i]]);
    PageControl1.ActivePageIndex:=3;
    for i:=1 to  LocMaxCount do
    LinerizData[i]:=(LocalMaxPos[i-1]-LocalMaxPos[0])*Dat.XStep;

    for i:=1 to  LocMaxCount-1 do
    begin
     DistArray[i]:=LinerizData[i+1]-LinerizData[i];
     Series9.AddXY(i*GridCellSize,DistArray[i]);
    end;

    if (LinerizData[LocMaxCount])<>0 then
    SensKoef:=(LocMaxCount-1)*GridCellSize/(LinerizData[LocMaxCount]);

    for i:=1 to LocMaxCount do  LinerizData[i]:=LinerizData[i]*SensKoef;

   end;
   if Dir='X' then RealSens:=InitSensX*SensKoef
              else RealSens:=InitSensY*SensKoef ;
    EdCorrSens.Text:=FloatToStrF(RealSens,ffFixed,5,0);
  {---------------Statistics-----------------}
    LabelDistStat.Caption :=' ';
    LabelNDistStat.Caption:=' ';
    PointNumb:= LocMaxCount;
  if PointNumb>1 then
  begin
    Sum:=0;
    for i:=1 to PointNumb-1 do  Sum:=Sum+ DistArray[i];
    AverageDist:=Sum/(PointNumb-1);
    NormAverageDist:=abs(100*(AverageDist-3000)/3000);
    Sum:=0;
    for i:=1 to PointNumb-1 do  Sum:=Sum+ sqr(DistArray[i]-AverageDist);
     Disperce:=0;
     Sigma:=0;
     NormSigma:=0;
    if PointNumb>3 then
      begin
        Disperce:=(Sum)/(PointNumb-2);
        Sigma:=sqrt(Disperce);
        NormSigma:=100*Sigma/3000;  //!!!! or /AverageDist
      end;

    LabelDistStat.Caption := siLang1.GetTextOrDefault('IDS_38' (* 'Grid Period= ' *) ) + FloatToStrF(AverageDist,fffixed,5,2)+' +/- '+
                                FloatToStrF(Sigma,fffixed,4,0)+ siLang1.GetTextOrDefault('IDS_39' (* ' nm' *) );
    LabelNDistStat.Caption := 'NL= ' + FloatToStrF(NormAverageDist,fffixed,3,1)+' % +/- '+
                                FloatToStrF(NormSigma,fffixed,3,0)+ '%';
   end;
  {---------------End of Statistics-----------------}

   with  ChartCorrLine.Title.Text do
      begin
        Clear;
        if ScannerNameDLL<>'None' then
        Add(siLang1.GetTextOrDefault('IDS_41' (* 'Scanner  ' *) )+ScannerNameDLL +siLang1.GetTextOrDefault('IDS_42' (* '  Linearization  ' *) )+Dir)
        else Add('    '+siLang1.GetTextOrDefault('IDS_42' (* '  Linearization  ' *) )+Dir);
      end;
 finally
  LinLine:=nil;
  LocalMaxPos:=nil;
 end;
end;
function TImgAnalysWnd.WriteToAdapterLinStructure(dir:string; Pathmode:integer;N:integer;NField:integer;data:string):boolean;
var i:integer;
begin
   if LowerCase(dir) =lowercase('X') then
   begin
          case Pathmode  of
    0: begin
        with PadapterLinModXAxisX^ do
        begin
         pageNmb:=2;
         DataLengthInt:=1;
         LinearizationDate:=data;
         NPoints:=N;
         for I:= 1 to NPoints  do   Points[i]:=round(LinerizData[i]);
        end;
        with PAdapterOptModX^ do
        begin
         NonLinFieldX:=NField;//StrToInt(EdNonLinField.Text);
         if(RealSens >0) then
         SensitivX:=RealSens;//single;
        end;
        with ScanneroptModX do
          begin
             NonLinFieldX:=NField;
             if(RealSens >0) then
               SensitivX:=RealSens;
          end;
      end;
   1: begin
       with PadapterLinModYAxisX^ do
       begin
        pageNmb:=5;
        DataLengthInt:=1;
        LinearizationDate:=data;
        NPoints:=N;
        for I:= 1 to NPoints do   Points[i]:=round(LinerizData[i]);
       end;
       with PAdapterOptModY^ do
       begin
        NonLinFieldX:=NField;//StrToInt(EdNonLinField.Text);
     //   GridCellSize:=PAdapterOptFloatRecord(databuf)^.GridCellSize; //nm
        if(RealSens >0) then
        SensitivX:=RealSens;//single;
       end;
        with ScanneroptModY do
          begin
             NonLinFieldX:=NField;
             if(RealSens >0) then
             SensitivX:=RealSens;
          end;
      end;
          end;  //case
  end; //x

   if LowerCase(dir) =lowercase('Y') then
   begin
          case Pathmode  of
    0: begin
        with PadapterLinModXAxisY^ do
        begin
         pageNmb:=3;
         DataLengthInt:=1;
         LinearizationDate:=data;
         NPoints:=N;
         for I:= 1 to NPoints  do   Points[i]:=round(LinerizData[i]);
        end;
        with PAdapterOptModX^ do
        begin
         NonLinFieldY:=NField;//StrToInt(EdNonLinField.Text);
    //     GridCellSize:=PAdapterOptFloatRecord(databuf)^.GridCellSize; //nm
         if(RealSens >0) then
         SensitivY:=RealSens;//single;
        end;
         with ScanneroptModX do
          begin
             NonLinFieldY:=NField;
             if(RealSens >0) then
             SensitivY:=RealSens;
          end;
      end;
   1: begin
       with PadapterLinModYAxisY^ do
       begin
        pageNmb:=6;
        DataLengthInt:=1;
        LinearizationDate:=data;
        NPoints:=N;
        for I:= 1 to NPoints  do   Points[i]:=round(LinerizData[i]);
       end;
       with PAdapterOptModY^ do
       begin
        NonLinFieldY:=NField;//StrToInt(EdNonLinField.Text);
    //    GridCellSize:=PAdapterOptFloatRecord(databuf)^.GridCellSize; //nm
        if(RealSens >0) then
        SensitivY:=RealSens;//single;
       end;
        with ScanneroptModY do
          begin
             NonLinFieldY:=NField;
             if(RealSens >0) then
             SensitivY:=RealSens;
          end;
      end;
          end;  //case
  end; 
end;
function TImgAnalysWnd.SaveAutoLin(dir:string; ScannerFileName:string):integer;
var NLinField:integer;
    i:integer;
   iniCSPM:TiniFile;
   Present: TDateTime;
   presentdate:string;
   Year, Month, Day, Hour, Minute, Sec, MSec: Word;
   OldPointNumb:integer;
   pathMode:integer;
begin
 result:=0;
 NLinField:=StrToInt(EdNonLinField.Text);
 SetFileAttribute_ReadOnly(ScannerFileName,false);
 iniCSPM:=TIniFile.Create(ScannerFileName);
try
 with iniCSPM do
 begin
  pathmode:=ReadInteger(ScannerNameDLL,'pathmode',0);
  OldPointNumb:=ReadInteger(ScannerNameDLL, Dir+'Points Number',0);
  if OldPointNumb<>0 then
  begin
   DeleteKey((ScannerNameDLL),Dir+'Points Number');
    for i:=1 to OldPointNumb do
   DeleteKey((ScannerNameDLL),Dir+IntToStr(i));
  end;
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minute, Sec, MSec);
  presentdate:=intTostr(day)+'-'+inttostr(month)+'-'+inttostr(year);
 Try
     WriteString((ScannerNameDLL), 'Linearization Date',presentdate);
 except
     on IO: EInOutError do
        begin
            case IO.Errorcode  of
       104:  siLang1.MessageDlg(str1{'error write flash'},mtWarning,[mbOk],0);
               end;
        end;
     else
       begin
        result:=1;
        flgSaveProcess:=false;
        siLang1.MessageDlg(str1{'error write flash'},mtWarning,[mbOk],0);
        iniCSPM.free;
        Exit;
       end;
 end;
     WriteString((ScannerNameDLL),'Sensitiv'+Dir, FloatToStrF(RealSens,ffFixed,3,0));
     if  not FlagLinearDLL then
       begin
        WriteInteger(ScannerNameDLL, 'NonLiniar Field '+dir, NLinField );
        WriteInteger(ScannerNameDLL, Dir+'Points Number',LocMaxCount);
         for i:=1 to  LocMaxCount do   WriteString((ScannerNameDLL), Dir+IntToStr(i),
        FloatToStrF(LinerizData[i],ffFixed,7,0));
       end;

end;
finally
  iniCSPM.Free;
end; //with
    WriteToAdapterLinStructure(dir,pathmode,LocMaxCount,NLinField,presentdate);  
    SetFileAttribute_ReadOnly(ScannerFileName,true);
  // if ScanFormHandle<>0        then PostMessage(ScanFormHandle, MsgScanBack,0,0);
  // if ApproachOptFormHandle<>0 then PostMessage(ApproachOptFormHandle, MsgApproachOptBack,0,0);
 if assigned(ApproachOpt) then PostMessage(ApproachOpt.Handle,MsgApproachOptBack,0,0);
 if assigned(ScanWnd)     then PostMessage(ScanWnd.Handle, MsgScanBack,0,0);
end;

procedure TImgAnalysWnd.BitBtnSaveAutoLinClick(Sender: TObject);
var  FPath:string;
     OtherDirFile:string;
     dir:string;
begin
if siLang1.MessageDlg(siLang1.GetTextOrDefault('IDS_52' (* 'Rewrite Linearization Data ?' *) ),mtwarning,[mbYes,mbNo],0)=mrYes
then
 begin
  flgSaveProcess:=true;
  if RadioGrLinDir.ItemIndex=0 then dir:='X' else  dir:='Y';
  if SaveAutoLin(dir, ScannerFileDLL)>0 then exit;
  if CheckBoxScanMode.Checked then
  begin
   FPath:=ExtractfilePath(ScannerFileDLL);
   if ScanModeDLL=0 then  OtherDirFile:='SPMScannerY.ini' ///!!!!!!!!!
                    else  OtherDirFile:='SPMScanner.ini' ; //!!!!!!!!!!!!
   OtherDirFile:=FPath+OtherDirFile;
  if SaveAutoLin(dir, OtherDirFile)>0 then exit; ;
  end;
  LoadLinSplineFromAdapter;    // изменено 22/11/2016
  flgSaveProcess:=false;
 // if ApproachOptFormHandle<>0 then PostMessage(ApproachOptFormHandle,MsgApproachOptBack,1,0);
 // if ScanFormHandle<>0        then PostMessage(ScanFormHandle, MsgScanBack,1,0);
  if assigned(ApproachOpt) then PostMessage(ApproachOpt.Handle,MsgApproachOptBack,0,0);
  if assigned(ScanWnd)     then PostMessage(ScanWnd.Handle, MsgScanBack,0,0);
 end;
end;

procedure TImgAnalysWnd.RadioGrLinDirClick(Sender: TObject);
begin
if RadioGrLinDir.ItemIndex=0 then
begin
 LabelSens.Caption:=siLang1.GetTextOrDefault('IDS_54' (* 'Sensitivity X' *) );
 EdInitSens.Text:=FloatToStr(InitSensX);
 ReadShortScannerParams('X',NonLinFieldX);
 EdNonLinField.Text:=InttoStr(NonLinFieldX);
 FileAutoLinearization('X');
end;
if RadioGrLinDir.ItemIndex=1 then
begin
 LabelSens.Caption:=siLang1.GetTextOrDefault('IDS_55' (* 'Sensitivity Y' *) );
 EdInitSens.Text:=FloatToStr(InitSensY);
 ReadShortScannerParams('Y',NonLinFieldY);
 EdNonLinField.Text:=InttoStr(NonLinFieldY);
 FileAutoLinearization('Y');
end;
end;

procedure TImgAnalysWnd.BitBtnSetDefClick(Sender: TObject);
var
    iniCSPM:TiniFile;
    YSectionBias:single; // degrees
    ss,ssX,ssY:string;
    SensX, SensY:single;
 begin
   iniCSPM:=TIniFile.Create(ScannerDefFileDLL);
    with iniCSPM do
    begin
      SensX:=ReadFloat(ScannerNameDLL,'SensitivX',250);
      SensY:=ReadFloat(ScannerNameDLL,'SensitivY',250);
    end;
   iniCSPM.Free;
    EdSensX.Text:=FloatToStrF(SensX,fffixed,6,2);
    EdSensY.Text:=FloatToStrF(SensY,fffixed,6,2);
    BitBtnApplyClick(Sender);
    BitBtnSaveSensClick(Sender);
end;


procedure TImgAnalysWnd.SpeedButton1Click(Sender: TObject);
begin
 if   SpeedButton1.Down then
 begin
  Clear;
  GroupBoxFiltration.visible:=True;
  GroupBoxFiltration.enabled:=True;
  SpectrumChart.hint:=strdrawarea;
  PanelFourier.hint:=strdrawarea;
 end;
end;

procedure TImgAnalysWnd.SpeedBtnFreqClick(Sender: TObject);
begin
 SpectrumChart.Repaint;
 SpectrumChart.hint:='';
  PanelFourier.hint:='';
 BitBtnExecute.Enabled:=False;
 AddBitBtn.Enabled:=False;
 GroupBoxFiltration.visible:=False;
 PageControl1.ACtivepage:=TabSheetImage;
end;

procedure TImgAnalysWnd.SpeedBtnAngleClick(Sender: TObject);
begin
 SpectrumChart.Repaint;
 BitBtnExecute.Enabled:=False;
 AddBitBtn.Enabled:=False;
 GroupBoxFiltration.visible:=False;
 SpectrumChart.hint:='';
  PanelFourier.hint:='';
end;

procedure TImgAnalysWnd.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
if flgSaveProcess then CanClose:=false
                  else CanClose:=true;
end;

procedure TImgAnalysWnd.FormCreate(Sender: TObject);
begin
  UpdateStrings;
   SpectrumChart.hint:='';
  PanelFourier.hint:='';
  DoubleBuffered:=True;
end;

procedure TImgAnalysWnd.BitBtnApplyFiltClick(Sender: TObject);
begin
    PostMessage (FormHandle, MsgBack, 1, 0);
end;

procedure TImgAnalysWnd.BitBtnNewFiltClick(Sender: TObject);
begin
//ClearBitBtnClick(Sender);
 Clear;
PageControl1.ActivePageIndex:=0;
end;

procedure TImgAnalysWnd.PageControl1Change(Sender: TObject);
var  i:integer;
begin
  with PageControl1 do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
    ActivePage.HighLighted:=True;
  end;
end;

procedure TImgAnalysWnd.SpeedButton4Click(Sender: TObject);
var BitMap:TBitMap;
begin
 MedianFilt3(Dat.Nx,Dat.Ny,Dat.Data, FiltFileName);
 Dmin:=Dat.datamin;
 Dmax:=Dat.datamax;
 BitMap:=TBitMap.Create;
 DrawData(BitMap,Dat);
 With ImgChart do
   begin
      BackImage.Assign(BitMap);
   end;
   FreeAndNil(Bitmap);
   Label1.Caption:=FloatToStrF(Dmax*StepZ,fffixed,5,0)+' '+dat.captionZ;
   Label2.Caption:=FloatToStrF(Dmin*StepZ,fffixed,5,0)+' '+dat.captionZ;
   ChangeCurrentSheet;
end;

procedure TImgAnalysWnd.SpeedButton2Click(Sender: TObject);
var BitMap:TBitMap;
begin
 AverageFilt3x3(Dat.Nx,Dat.Ny,Dat.Data, FiltFileName);
 Dmin:=Dat.datamin;
 Dmax:=Dat.datamax;
 BitMap:=TBitMap.Create;
 DrawData(BitMap,Dat);
 With ImgChart do
   begin
      BackImage.Assign(BitMap);
   end;
   FreeAndNil(Bitmap);
   Label1.Caption:=FloatToStrF(Dmax*StepZ,fffixed,5,0)+' '+dat.captionZ;
   Label2.Caption:=FloatToStrF(Dmin*StepZ,fffixed,5,0)+' '+dat.captionZ;
   ChangeCurrentSheet;
end;

procedure TImgAnalysWnd.SpeedButton5Click(Sender: TObject);
var BitMap:TBitMap;
begin
 DelFiltPlane(Dat.Nx,Dat.Ny,Dat.Data, FiltFileName) ;  //x->y
 Dmin:=Dat.datamin;
 Dmax:=Dat.datamax;
 BitMap:=TBitMap.Create;
 DrawData(BitMap,Dat);
 With ImgChart do
   begin
      BackImage.Assign(BitMap);
   end;
  FreeAndNil(Bitmap);
  Label1.Caption:=FloatToStrF(Dmax*StepZ,fffixed,5,0)+' '+dat.captionZ;
  Label2.Caption:=FloatToStrF(Dmin*StepZ,fffixed,5,0)+' '+dat.captionZ;
  ChangeCurrentSheet;
end;

procedure TImgAnalysWnd.SpeedButton6Click(Sender: TObject);
var BitMap:TBitMap;
begin
// if (ScanModeDLL=0) or(ScanModeDLL=2) then
  DelStepsY(Dat.Nx,Dat.Ny,Dat.data, FiltFileName);
//                                      else  DelStepsY(Dat.Nx,Dat.Ny,Dat.data, FiltFileName);
   Dmin:=Dat.datamin;
   Dmax:=Dat.datamax;
   BitMap:=TBitMap.Create;
   DrawData(BitMap,Dat);
 With ImgChart do
   begin
      BackImage.Assign(BitMap);
   end;
   FreeAndNil(Bitmap);
   Label1.Caption:=FloatToStrF(Dmax*StepZ,fffixed,5,0)+' '+dat.captionZ;
   Label2.Caption:=FloatToStrF(Dmin*StepZ,fffixed,5,0)+' '+dat.captionZ;
   ChangeCurrentSheet;
end;

procedure TImgAnalysWnd.SpeedButton7Click(Sender: TObject);
var BitMap:TBitMap;
begin
   DelStepsX(Dat.Nx,Dat.Ny,Dat.data, FiltFileName);
   Dmin:=Dat.datamin;
   Dmax:=Dat.datamax;
   BitMap:=TBitMap.Create;
   DrawData(BitMap,Dat);
 With ImgChart do
   begin
      BackImage.Assign(BitMap);
   end;
   FreeAndNil(Bitmap);
   Label1.Caption:=FloatToStrF(Dmax*StepZ,fffixed,5,0)+' '+dat.captionZ;
   Label2.Caption:=FloatToStrF(Dmin*StepZ,fffixed,5,0)+' '+dat.captionZ;
   ChangeCurrentSheet;
end;

procedure TImgAnalysWnd.UpdateStrings;
begin
  strCounts := siLang1.GetTextOrDefault('strstrCounts' (* 'Counts' *) );
  strdrawarea := siLang1.GetTextOrDefault('strstrdrawarea');
  str6:=siLang1.GetTextOrDefault('strstr6');
  str5:=siLang1.GetTextOrDefault('strstr5');
  str4:=siLang1.GetTextOrDefault('strstr4');
  str3:= siLang1.GetTextOrDefault('strstr3');
  str1:= siLang1.GetTextOrDefault('strstr1');

end;

procedure TImgAnalysWnd.ShowHistogram(Dat:TData);
var  MinValue,MaxValue,L,i:integer;
     H:TMas1;
     HistMin, HistMax:integer;
     RfAver,RfSq:single;
     NAreas:integer;
     HistStep,Current:single;
begin
MinValue:=(round(Dat.datamin));
MaxValue:=(round(Dat.datamax));
NAreas:=1+round(sqrt(MaxValue-MinValue));// div 100;//20;
//if NAreas=0 then NAreas:=1;
HistStep:=(maxvalue-minvalue+1)/NAreas;
H:=HistAreas(Dat, NAreas, MinValue, HistStep);
//  H:=Hist(Dat, MinValue);
 L:=Length(H);
 HistMin:=H[0];
for i:=0 to L -1 do
 begin
   if H[i]<HistMin then HistMin:=H[i];
 end;
 HistMax:=H[0];
for i:=0 to L -1 do
 begin
   if H[i]>HistMax then HistMax:=H[i];
 end;

with HistChart.BottomAxis do
begin
 Automatic:=False;
 //SetMinMax( MinValue, MinValue+L*HistStep );
 SetMinMax(StepZ*minvalue,StepZ*(maxvalue+HistStep));
end;
Series7.Stairs:=True;
Series7.Clear;
//for i:=0 to L-1 do Series2.AddY(H[i]);
Current:=StepZ*minvalue;
for i:=0 to NAreas do
begin
if i<> Nareas then Series7.AddXY(Current,H[i])
              else Series7.AddXY(Current,0);
 Current:=Current+StepZ*HistStep;
end;
RoughnessParam(Dat,RfAver,RfSq);
with RichEdit1 do
  begin
   Clear;
   Lines.Add(siLang1.GetTextOrDefault('IDS_58' (* 'Roughness Average   ' *) )+ FloatToStrF(stepZ*RfAver,fffixed,5,2)+' '+dat.captionZ);
   Lines.Add(siLang1.GetTextOrDefault('IDS_59' (* 'Root Mean Square    ' *) )+ FloatToStrF(Stepz*RfSq,fffixed,5,2)+' '+dat.captionZ);
  end;
end;


procedure TImgAnalysWnd.ShowCalibration(Dat:TData);
var BitMapCalibr:TBitMap;
    ErrCod:Integer;
begin
  Dmin:=Dat.datamin;
  Dmax:=Dat.datamax;
  BitMapCalibr:=TBitMap.Create;
  DrawData(BitMapCalibr,Dat);
 With ImgCalibrateChart do
   begin
      BackImage.Assign(BitMapCalibr);
   end;
  FreeAndNil( BitMapCalibr);
 if FlagLinearDLL then
                begin
                 // GrBoxNonLinCorr.Enabled:=false;
                  PanelNonLinCorr.visible:=false;
                  BitBtnSave.Enabled:=false;
                  BitBtnNonLinCorr.Enabled:=False;
                end
                else
                  begin
                   ErrCod:=ReadScannerParams('X', LinerizDataX, NLinX, NonLinFieldX);
                   if ErrCod=-1 then
                   begin
                     GrBoxNonLinCorr.Enabled:=false;
                     PanelNonLinCorr.visible:=false;
                     BitBtnNonLinCorr.Enabled:=False ;
                     BitBtnSave.Enabled:=False ;
                   end
                   else
                   begin
                       ErrCod:=ReadScannerParams('Y', LinerizDataY, NLinY, NonLinFieldY);
                       GrBoxNonLinCorr.Enabled:=true;
                       PanelNonLinCorr.visible:=true;
                       if lowercase(ScannerNameDLL)='demo' then
                       begin
                        bitbtnsavesens.Enabled:=false;
                        bitbtnsave.Enabled:=false;
                      end;
//                       BitBtnSave.Enabled:=true;
                       BitBtnNonLinCorr.Enabled:=True;
                       TabSheetCurves.TabVisible:=True;
                       LinerizDataOut(SeriesLinX,LinerizDataX, NLinX, NonLinFieldX);
                       LinerizDataOut(SeriesLinY,LinerizDataY, NLinY, NonLinFieldY);
                       PageControl1.ActivePageIndex:=1;
                       TabSheetCurves.Highlighted:=true;
                   end;
                end;
   EdNonLinFieldX.Text:=IntToStr(NonLinFieldX);
   EdNonLinFieldY.Text:=IntToStr(NonLinFieldY);
end; {ShowCalibration}

procedure TImgAnalysWnd.ShowSpectrum(Dat:TData);
var  BitMapSpectr:TBitMap;
i,j:integer;
begin
    FloatMasInit(Dat);
    FiltrationInit(DataFloatMas);
    FourierSp(DataFloatMas);

    SpectrumPicture.NX:=DataFloatMas.NX;
     SpectrumPicture.NY:=DataFloatMas.NY;
      SpectrumPicture.data:=nil;
   SetLength(SpectrumPicture.data,SpectrumPicture.NX,SpectrumPicture.NY);
      for i:=0 to  SpectrumPicture.NY-1 do
      for j:=0 to  SpectrumPicture.NX-1 do
        SpectrumPicture.data[j,i]:=DataFloatMas.data[j,i];
   FlgFourierCounted:=True;
    BitMapSpectr:=TBitMap.Create;
    Dmin:=DataFloatMas.min;
    Dmax:=DataFloatMas.max;
    DrawdataFloat(BitMapSpectr,DataFloatMas);
    with SpectrumChart do
      begin
        BackImage.Assign(BitMapSpectr);
        BackImageInside:=True;
        BackImageMode:=pbmStretch;
      end;
      FreeAndNil(BitMapSpectr);
 //  DataFloatMas.Free;
end;


procedure TImgAnalysWnd.siLang1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TImgAnalysWnd.ShowImage(UData:TDataFloatCount);
var  BitMapImage:TBitMap;
i,j:integer;
begin
    BitMapImage:=TBitMap.Create;
    Dmin:=UData.min;
    Dmax:=UData.max;
    DrawdataFloat(BitMapImage,UData);
    with SpectrumChart do
      begin
        BackImage.Assign(BitMapImage);
        BackImageInside:=True;
        BackImageMode:=pbmStretch;
      end;
   FreeAndNil(BitMapImage);
end;

procedure TImgAnalysWnd.ShowAutoLinearization(Dat:TData);
var i:integer;
begin
 if  FlagLinearDLL then BitBtnSaveAutoLin.Enabled:= False
                   else BitBtnSaveAutoLin.Enabled:= (lowercase(ScannerNameDLL)<>'demo');
 TabSheetAutoLinCurve.TabVisible:=true;
// TabSheetAutoLinCurve.Highlighted:=true;
 PageControl1.ActivePage:= TabSheetAutolinCurve; // TabSheetAutolin;
 with PageControl1 do
  begin
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
    ActivePage.HighLighted:=True;
  end;
// AutoLinChart.Width:= PanelAutoLinChart.Width;
 with  AutoLinChart.Title.Text do
      begin
        Clear;
        if ScannerNameDLL<>'None' then Add('Scanner  '+ScannerNameDLL)
                                  else Add('    ');
      end;
if ScanModeDLL=0 then
 begin
  ReadShortScannerParams('X',NonLinFieldX);
  EdNonLinField.Text:=InttoStr(NonLinFieldX);
  LabelScanMode.Caption:=siLang1.GetTextOrDefault('IDS_61' (* 'ScanMode X' *) );
  LabelSens.Caption:=siLang1.GetTextOrDefault('IDS_54' (* 'Sensitivity X' *) );
  EdInitSens.Text:=FloatToStr(InitSensX);
  RadioGrLinDir.ItemIndex:=0;
  FileAutoLinearization('X');
 end
 else
 begin
  ReadShortScannerParams('Y',NonLinFieldY);
  EdNonLinField.Text:=InttoStr(NonLinFieldY);
  LabelScanMode.Caption:=siLang1.GetTextOrDefault('IDS_63' (* 'ScanMode Y' *) );
  LabelSens.Caption:=siLang1.GetTextOrDefault('IDS_55' (* 'Sensitivity Y' *) );
  EdInitSens.Text:=FloatToStr(InitSensY);
  RadioGrLinDir.ItemIndex:=1;
  FileAutoLinearization('Y');
 end;
 EdGridPeriod.Text:=InttoStr(GridCellSize);
end;

procedure TImgAnalysWnd.ChangeCurrentSheet;
begin
 ZoomCount:=0;
 BitBtnZoomIn.Enabled:=true;
 BitBtnZoomOut.Enabled:=true;
 SpectrumChart.BottomAxis.SetMinMax(-FreqMax,FreqMax);
 SpectrumChart.LeftAxis.SetMinMax(-FreqMax,FreqMax);
if PageControlResults.ActivePage.Name='tabSheetSpectr'                then ShowSpectrum(Dat)
  else if PageControlResults.ActivePage.Name='TabSheetRoughness'      then ShowHistogram(Dat)
    else if PageControlResults.ActivePage.Name='TabSheetAutoLin'      then ShowAutoLinearization(Dat)
     else if PageControlResults.ActivePage.Name='TabSheetCalibration' then ShowCalibration(Dat);
end;

procedure TImgAnalysWnd.EdSensXChange(Sender: TObject);
begin
if EdSensX.Text = '' then  exit;
  SensX1:=StrtoFloat(EdSensX.Text);
end;

procedure TImgAnalysWnd.EdSensXKeyPress(Sender: TObject; var Key: Char);
begin
     if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0 ;
end;                           

procedure TImgAnalysWnd.EdSensYChange(Sender: TObject);
begin
if EdSensY.Text = '' then  exit;
SensY1:= StrtoFloat(EdSensY.Text);

end;

procedure TImgAnalysWnd.EdSensYKeyPress(Sender: TObject; var Key: Char);
begin
     if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0 ;
end;

procedure TImgAnalysWnd.EdNonLinFieldXKeyPress(Sender: TObject;
  var Key: Char);
begin
     if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TImgAnalysWnd.EdNonLinFieldYKeyPress(Sender: TObject;
  var Key: Char);
begin
     if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TImgAnalysWnd.EdSelectedKeyPress(Sender: TObject; var Key: Char);
begin
    if not(Key in ['0'..'9',DecimalSeparator,#8]) then Key :=#0 ;
end;

procedure TImgAnalysWnd.CbUnselectedKeyPress(Sender: TObject;
  var Key: Char);
begin
    if not(Key in ['0','1']) then Key :=#0 ;
end;

procedure TImgAnalysWnd.BitBtnZoomInClick(Sender: TObject);
var   FreqLim:single;
begin
  // Percents:=20;
  if (ZoomCount+1)*Percents<100 then
   begin
     ZoomCount:=ZoomCount+1;
      if (ZoomCount+1)*Percents>=100 then BitBtnZoomIn.Enabled:=true;
     FreqLim:=FreqMax*(1-0.01*Percents*ZoomCount);
     SpectrumChart.BottomAxis.SetMinMax(-FreqLim,FreqLim);
     SpectrumChart.LeftAxis.SetMinMax(-FreqLim,FreqLim);
     SpectrumZoom(Percents,ZoomCount);
     BitBtnZoomOut.Enabled:=true;
   end
   else  BitBtnZoomIn.Enabled:=true;
end;

procedure TImgAnalysWnd.BitBtnZoomOutClick(Sender: TObject);
var FreqLim:single;
begin
    if ZoomCount>0 then
    begin
     ZoomCount:=ZoomCount-1;
     if ZoomCount=0 then  BitBtnZoomOut.Enabled:=true;
     SpectrumZoom(Percents,ZoomCount);
     FreqLim:=FreqMax*(1-0.01*Percents*ZoomCount);
     SpectrumChart.BottomAxis.SetMinMax(-FreqLim,FreqLim);
     SpectrumChart.LeftAxis.SetMinMax(-FreqLim,FreqLim);
     BitBtnZoomIn.Enabled:=True;
   end ;
end;

procedure  TImgAnalysWnd.SpectrumZoom(Percents:integer; Count:integer);
var  BitMapSpectr:TBitMap;
     ZoomData:TDataFloatCount;
     PersKoef:single;
     i,j,XShift,YShift:integer;
begin
   PersKoef:=Count*Percents/100;
   ZoomData:= TDataFloatCount.Create;
   XShift:=round(0.5*SpectrumPicture.NX*PersKoef);
   YShift:=round(0.5*SpectrumPicture.NY*PersKoef);

     ZoomData.Data:=nil;
     ZoomData.NX:=round(SpectrumPicture.NX*(1-PersKoef));
     ZoomData.NY:=round(SpectrumPicture.NY*(1-PersKoef));
     SetLength(ZoomData.Data,ZoomData.NX,ZoomData.NY);
     for i:=0 to ZoomData.NY-1 do
      for j:=0 to ZoomData.NX-1 do   ZoomData.Data[j,i]:= SpectrumPicture.Data[ XShift+j,YShift+i];

    BitMapSpectr:=TBitMap.Create;
    Dmin:=ZoomData.min;
    Dmax:=ZoomData.max;
    DrawdataFloat(BitMapSpectr,ZoomData);
    with SpectrumChart do
      begin
        BackImage.Assign(BitMapSpectr);
        BackImageInside:=True;
        BackImageMode:=pbmStretch;
      end;
      FreeAndNil(BitmapSpectr);
      FreeAndNil(ZoomData);    { TODO : 271007 }
end;


procedure TImgAnalysWnd.SpeedBtnSaveClick(Sender: TObject);
var  ActiveCanvas: TCanvas;
  Bitmap: TBitmap;
  jp:TJpegImage;
  Rect: TRect;
  i,old_top,old_left: integer;
  NewFile,OldFile,TmpName:string;
  CurDir,Dir,s:string;
begin
      ForceCurrentDirectory :=True;
      ActiveCanvas :=TCanvas.Create;
      Bitmap := TBitmap.Create;
 try
    with  ImgAnalysWnd  do
     begin
      ActiveCanvas.Handle :=GetDC(Handle);
      Rect:=Bounds(0, 0, Width, Height);
      Bitmap.Width :=ClientWidth;
      Bitmap.Height :=ClientHeight;
     end;
      Bitmap.Canvas.CopyRect(Rect, ActiveCanvas, Rect);
      ImAnalSaveDialog.DefaultExt:='bmp';
      ImAnalSaveDialog.Filter:=' image  files *.bmp|*.bmp|image  files *.jpg|*.jpg';
    if ImAnalSaveDialog.execute then
     begin
         NewFile:=ImAnalSaveDialog.FileName;
         Dir:=ExtractFileDir(NewFile);
         if not DirectoryExists(Dir)then CreateDir(Dir);
      case  ImAnalSaveDialog.FilterIndex   of
        1: begin
             Bitmap.SaveToFile(ImAnalSaveDialog.FileName); { TюїЁрэ хь  ¤ъЁрэ т Їрщы}
           end;
        2: begin
             jp := TJpegImage.Create;
             with jp do
              begin
               Assign(Bitmap);
               SaveToFile(ImAnalSaveDialog.FileName);
              end;
             jp.Free;
           end;
        end;      //case
    end;    // dialogfilesave.execute
 finally
     FreeAndNil(Bitmap);
     ActiveCanvas.Free;
 end;
end;

procedure TImgAnalysWnd.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
 if  FlagAllowCalibration
then
  if (ssCtrl in Shift) then
   begin
      ActiveControl:=PageControl1;
   if (Key=ord('V')) then TabSheetAutolIn.TabVisible:= not TabSheetAutolIn.TabVisible;
   end;
end;

procedure TImgAnalysWnd.FormShortCut(var Msg: TWMKey;  var Handled: Boolean);
begin
// if Msg.CharCode=ord('V') then TabSheetAutolIn.TabVisible:= not TabSheetAutolIn.TabVisible;
end;

procedure TImgAnalysWnd.SpeedButton3Click(Sender: TObject);
begin
   SpectrumChart.LeftAxis.Grid.Visible  :=not SpectrumChart.LeftAxis.Grid.Visible;
   SpectrumChart.BottomAxis.Grid.Visible:=not SpectrumChart.BottomAxis.Grid.Visible;
   SpectrumChart.Repaint;
end;

(*procedure TImgAnalysWnd.CopyToClipBoard;
var bitmap:Tbitmap;
begin
 try
  bitmap:=Tbitmap.Create;
  bitmap.Width:=ClientWidth;
  bitmap.Height:=ClientHeight;
  with bitmap.Canvas do CopyRect(ClientRect,Canvas,ClientRect);
  ClipBoard.Assign(bitmap);
 finally
  FreeAndNil(bitmap)
 end;
end;
*)
procedure TImgAnalysWnd.CopyToClipBoard;
var  ActiveCanvas: TCanvas;
  Bitmap: TBitmap;
  Rect: TRect;
begin
      ActiveCanvas :=TCanvas.Create;
      Bitmap := TBitmap.Create;
   try
    with  ImgAnalysWnd  do
     begin
      ActiveCanvas.Handle :=GetDC(Handle);
      Rect:=Bounds(0, 0, Width, Height);
      Bitmap.Width :=ClientWidth;
      Bitmap.Height :=ClientHeight;
     end;
      Bitmap.Canvas.CopyRect(Rect, ActiveCanvas, Rect);
      ClipBoard.Assign(BitMap);
  finally
      FreeAndNil(Bitmap);
      ActiveCanvas.Free;
  end;
end;

procedure TImgAnalysWnd.MouseDownToDrag(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:integer;
begin
if (Button=mbLeft) and (ssAlt in Shift) then
 begin
   //   if Assigned(ReportForm) then
             begin
              if (left< (screen.workarealeft+10))
                or ((Top+height)>(Screen.workareatop+Screen.workareaheight)) then
               SetWindowPos(handle,HWND_TOP,screen.workarealeft+40,screen.workareatop+200,Width,Height,SWP_SHOWWINDOW);
        (*       for  I := 0 to Screen.FormCount-1 do
                  begin
                if  (Screen.Forms[I].Formstyle=fsStayOnTop) and (Screen.Forms[I]<>ImgAnalysWnd)   then Screen.Forms[I].Hide;
                   end;
          *)     RePaint;
               CopyToClipBoard;
               PostMessage (FormHandle, MsgBack, 2, 0);
            (*   for  I := 0 to Screen.FormCount-1 do
                  begin
              if  (Screen.Forms[I].Formstyle=fsStayOnTop) and (Screen.Forms[I]<>ImgAnalysWnd) then  Screen.Forms[I].Show;
                   end;
             *)
             end;
  end;
end;

procedure TImgAnalysWnd.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=18 then
begin
 // ImgChart.EndDrag(False);

 // Cursor
end;
end;



procedure TImgAnalysWnd.BitBtnSaveFltrClick(Sender: TObject);
begin
 SaveFiltTemplateAsASCII(FourierFiltTemplFileDLL);
end;

procedure TImgAnalysWnd.SaveFiltTemplateAsASCII(const FileName:string);
var Fl:TextFile;
    s:STRING;
    i,j:integer;
    Year, Month, Day, Hour, Minut, Sec, MSec: Word;
    Present: TDateTime;
    presentdate:string;
begin
if assigned(TemplateBuf) then
   begin
    AssignFile(Fl, FileName);
    ReWrite(Fl);
    S:=siLang1.GetTextOrDefault('IDS_71' (* 'File Format = ASCII' *) );
    Writeln(Fl, S);
    S:= IdentifSpectrTempl;
    Writeln(Fl, S);
    S:=siLang1.GetTextOrDefault('IDS_72' (* 'File: ' *) )+FileName;
    Writeln(Fl, S);
    Writeln(Fl, TemplateBuf.Nx);
    Writeln(Fl, TemplateBuf.Ny);
    Writeln(Fl,  'Start of Data : ');

    for i:=0 to TemplateBuf.Ny-1 do
    begin
     for j:=0 to TemplateBuf.Nx-1 do
        Write(Fl, round(10*TemplateBuf.data[j,i]),' ');
     writeln(Fl);
    end;
    CloseFile(Fl);
 //    BitBtnViewFlt.Enabled:=True;
   end
   else
     siLang1.ShowMessage(str3{' No Filter Template'});
end;




function  TImgAnalysWnd.ReadFiltTemplate(const FileName:String;
                                        var UData:TDataFloatCount ):integer;
var Fl:TextFile;
    s:STRING;
    i,j:integer;
    buf:integer;
begin

  if not FileExists(FileName) then
        begin
           siLang1.ShowMessage(FileName+str4{' File not exist'});
           result:=1;
           exit;
        end;
   result:=0;
  try
    AssignFile(Fl, FileName);
  except
      on IO: EInOutError do
            begin
              siLang1.messageDlg(FileName+str5{' Open ERROR!'},mtwarning,[mbOk],0);
              result:=1;
              exit;
            end;
    end;
   try
    Reset(Fl);
    Readln(Fl, S);
    Readln(Fl, S);
    i:=0;
    if  (S=IdentifSpectrTempl) then
     begin
      Readln(Fl, S);

      Read(Fl, S);
      Readln(Fl);
      UData.Nx:=StrToInt(S);
      Read(Fl, S);
      UData.NY:=StrToInt(S);
      Readln(Fl);
      SetLength(UData.data,UData.Nx,UData.Ny);

       Readln(Fl, S);
       if (S='Start of Data : ')then
  //   while (not EOF)
       for i:=0 to UData.NY-1 do
          begin
          for j:=0 to UData.NX-1 do
              begin
                Read(Fl,buf);
                UData.data[j,i]:=buf/10;
              end;
              Readln(Fl);
           end;

      end
      else
      begin
           siLang1.ShowMessage(FileName+str6{'File is not Filt Template!'});
           result:=1;
           exit;
      end;; {if S=IdentifDemo}
    finally
    CloseFile(Fl);
    end;
end; {}




procedure TImgAnalysWnd.BitBtnViewFltClick(Sender: TObject);
var i:integer;
 FiltTemplate:TDataFloatCount;
begin
  FiltTemplate:=TDataFloatCount.Create;
  i:=ReadFiltTemplate(FourierFiltTemplFileDLL, FiltTemplate);
  ShowImage(FiltTemplate);
  FreeAndNil(FiltTemplate);
end;



end.


//{$R-}

