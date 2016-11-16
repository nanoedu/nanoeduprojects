//290507 drag to report need no modal form
unit frSpectroscopyTerra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frParInput, TeEngine, Series, StdCtrls, Buttons, ExtCtrls, TeeProcs,
  Chart,ComCtrls,Math, ClipBrd, AppEvnts,GlobalType, GlobalDCl,
  QuickRpt, QRCtrls,SpmChart, siComp, siLngLnk, Menus, ToolWin,CSPMVar;

 type
  smar=array[0..16383] of smallint;
  Psmallarray=^smar;

  TSpectroscopyTerra = class(TForm)
    PanelMain: TPanel;
    StatusBar1: TStatusBar;
    Panel: TPanel;
    Panel6: TPanel;
    PageControl: TPageControl;
    Panel7: TPanel;
    BitBtnApply: TBitBtn;
    BitBtnSave: TBitBtn;
    BitBtnExit: TBitBtn;
    ControlPanel: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    FrT: TFrameParInput;
    FrNPoints: TFrameParInput;
    FrEndPoint: TFrameParInput;
    FrStartP: TFrameParInput;
    FrSupLevel: TFrameParInput;
    Panel5: TPanel;
    LabelStep: TLabel;
    LabelStepMin: TLabel;
    ApplicationEvents: TApplicationEvents;
    siLangLinked: TsiLangLinked;
    MainMenu1: TMainMenu;
    Edit1: TMenuItem;
    Copytoclipboard1: TMenuItem;
    ToolBar1: TToolBar;
    StartBtn: TToolButton;
    ToolBar2: TToolBar;
    PrintBtn: TToolButton;
    Lblwarning: TStatusBar;
    ToolButton1: TToolButton;
    PanelEditBtns: TPanel;
    PanelLabels: TPanel;
    PanelCurves: TPanel;
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure LblwarningDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure CopytoClipboard1Click(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinkedChangeLanguage(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure BitBtnApplyClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure FrStartPEditFrmChange(Sender: TObject);
    procedure FrNPointsEditFrmChange(Sender: TObject);
    procedure FrEndPointEditFrmChange(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure FrameParInput1EditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FrTEditFrmChange(Sender: TObject);
    procedure FrStartPEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrEndPointEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrNPointsEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrTEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrSupLevelEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrSupLevelEditFrmChange(Sender: TObject);
    procedure FrStartPBitBtnFrmClick(Sender: TObject);
    procedure FrFrmExit(Sender: TObject);
    procedure PageControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure BitBtn1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BitBtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FrTScrollBarFrmScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
  private
    { Private declarations }
   lflgIZ:boolean;
   flgProcess:boolean;
   flgStopSpectr:Boolean;
   FlgSurfaceData:Boolean;
   DBegin:Boolean;
   SpectrPointNmb, SpectrPointNmb_Data:integer;
   ChartNmb:integer;
   T,TC:word;
   StartPointZ,EndPointZ:ApiType;
   Error:integer;
   VertMin:word;
   NumbP:word;
   ActiveIndex:integer;
   NGraphP:integer; //Numbers Graph in Point
   NPage:integer;
   prevUAMMax:datatype;
   prevScanMethod:byte;
   ZStep:single;
   lZ_d_nm:single;  //coeff discr->nm     for spectroscopy  file
   BottAxMin,BottAxMax:single;
   Max_Y,Min_Y: single;
   FindLine_Pos:single;
   cursorsaved:Tcursor;
   BaseCaption,BaseCaptionStep,BaseCaptionStepMin,
   AddCaption:string;
   SeriesColor:array[0..3] of TColor;
   TabSheetTopo:TTabSheet;
   TabTopoPanel:TPanel;
   ImageTopo:TImage;
   TabSheetAdd:TTabSheet;
   TabAddPanel:TPanel;
   ImageAdd:TImage;
   QuickRep: TQuickRep;
   QRBand: TQRBand;
   QRImage: TQRImage;
   procedure ThreadDone(var AMessage : TMessage);  message WM_ThreadDoneMsg;
   procedure WMNCLButton(var Message: TMessage);  message WM_NCLButtonDown;
   function  CreateQuickReportComponent:boolean;
   procedure TestStepSize;
   procedure SpectrImgCreate(var TabSheetSpectr:TTabSheet;var TabSpectrPanel:TPanel;var IMageSpectr:TImage;const ImageCaption:string);
   procedure ScanImageDraw(TabSheetSpectr:TTabSheet;TabSpectrPanel:TPanel;var ImageSpectr:TImage;BitMap:TBitMap;  nx,ny:integer);
   procedure SpectrImgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
   procedure SpectrGraphCreate;
   procedure ReStoreStart;
   function  LoadDemoCurves(const FileName:string;  var Curves:TMas2):integer;
   procedure CopyMe(tobmp: TBitmap; frbmp : TGraphic);
  protected
   procedure DrawGraphics(const i:integer; UData:Array of datatype; const StepZ,StepValue:single);
   procedure DrawPicture(const mas_stm_in: TMas2;mas_x,mas_y:integer; max_in,min_in: single; var BitMap:TBitMap);
   procedure DrawSpectrPoints(const Points:TLine; NPoints:integer;const Header:HeadParmType;  BitMap:TBitMap);
  public
    { Public declarations }
     flgSpectrDone:boolean;
     ZStepMin,StepValueMin,StepValueMinIT:single;
     LFileName:string;
     ArTabSheet:array of TTabSheet;
     ArChart:array of TChartSpectrographiTerra;
     TabSheetSpectr:TTabSheet;
     TabSpectrPanel:TPanel;
     ImageSpectr:TImage;
     ActiveSeries: TLineSeries;
     constructor Create(AOwner:TComponent);       overload;
     constructor Create(AOwner:TComponent;const FileName:string);  overload;
     procedure   SaveAsASCII(const FileName:string);
     procedure   SaveAsMDT(const FileName:string);
  end;
var
   SpectrWndTerra: TSpectroscopyTerra;
   xMax:array[0..3]  of single;

implementation

uses nanoeduhelp, frScanWnd, GlobalVar,SIOCSPM,UNanoEduBaseClasses,UNanoEduClasses,
     uNanoEduScanClasses,frReport,GlobalFunction,mMain, frSetInteraction,frProgressMoveto,
     frApproachnew,frSPM_Browser,NanoedutoMDTFileExport,ScanWorkThread,SpectrTerraDrawThread;

{$R *.DFM}
//var     SeriesColor:array[0..3] of TColor;

const
	strs1: string = ''; (* no Demo Data!!! *)
	strs2: string = ''; (* The step too small! *)
	strs3: string = ''; (* Change Parameters. *)
	strs4: string = ''; (* The step too small!Change Parameters. *)
	strs5: string = ''; (* Error input. Start point must be <=0! *)
	strs6: string = ''; (* Error input *)
	strs7: string = ''; (* Printer is not connected.   *)
	strs8: string = ''; (*  File not exist *)
	strs9: string = ''; (* Click Right Button- Popup Menu;Labels ( Click  Left Button - Add ;  Del - Delete;Up,Down-Next,Previous ); *)
	strs10: string = ''; (* Curves (Pg up,Pg down- next, previous) *)
	strstart: string = ''; (* &Start *)
	strstop: string = ''; (* S&top *)
constructor TSpectroscopyTerra.Create(AOwner:TComponent);
 var  STopUAM:single;
      FileName,TabImgCaption:string;
begin
 inherited Create(AOwner);
 siLangLinked.ActiveLanguage:=Lang;
 frStartP.siLangLinked1.ActiveLanguage:=Lang;
 frEndPoint.siLangLinked1.ActiveLanguage:=Lang;
 frNPoints.siLangLinked1.ActiveLanguage:=Lang;
 frT.siLangLinked1.ActiveLanguage:=Lang;
 frSupLevel.siLangLinked1.ActiveLanguage:=Lang;
 UpdateStrings;
 flgSpectrDone:=false;
 flgStopSpectr:=true;
 BaseCaptionStep:=siLangLinked.GetTextOrDefault('IDS_0' (* 'Step=' *) ) ;
 BaseCaptionStepMin:=siLangLinked.GetTextOrDefault('IDS_1' (* 'Step Min=' *) ) ;
 prevScanMethod:=ScanParams.ScanMethod;
 FlgSurfaceData:=not SetIntActOnProgr;//    True;
 BaseCaption:=siLangLinked.GetTextOrDefault('IDS_2' (* 'Spectroscopy' *) );
 Caption:=BaseCaption;
 DemoSpectrCnt:=0;
 Top:=TopStart;
 left:=(main.Clientwidth-Clientwidth) div 2;
 Error:=0;
 lflgIZ:=SpectrParams.flgIZ;
 if assigned(ScanWnd) then Scanwnd.StartBtn.Enabled:=false;
 LblWarning.Visible:=false;
 LabelStep.Caption:='';
 SpectrParams.NCurves:=2;  //130314 
 NPage:=SpectrParams.NSpectrPoints;
 NGraphP:=SpectrParams.NCurves;
 FindLine_Pos:=0;
 T:=SpectrParams.T;
 TC:=ApproachParams.ScannerDecay;
 NumbP:=SpectrParams.NPoints;
 seriesColor[0]:=clblue;
 seriesColor[1]:=clred;
 seriesColor[2]:=clgreen;
 seriesColor[3]:=clblack;
 StartPointZ:=SpectrParams.StartP;    //nm
 EndPointZ:=SpectrParams.EndP;       //nm
 ZStepMin:=(1/TransformUnit.Znm_d);
 if lflgIZ then StepValueMin:=1/TransformUnit.nA_d
           else StepValueMin:=1/ApproachParams.UAMmax;
 StepValueMinIT:=1/TransformUnit.AmplV_d*1000;//???? // mv ScannerCorrect.I_VTransfKoef/TransformUnit.nA_d;
 if FlgCurrentUserLevel<> Demo then
   begin
      SpectrParams.StartPointLimit:=-4000;
      SpectrParams.FinalPointLimit:=1000;
   end
   else  //Demo
   begin
     FileName:=DemoDataDirectory+DemoSample+'\'+DemoSpectrSFMFile;
     Error:=LoadDemoCurves(FileName,DemoSpectrCurves);
     if Error<>0 then
       begin
        SpectrParams.StartPointLimit:=-1000;
        SpectrParams.FinalPointLimit:=1000;
       end;
      StepValueMin:=1/DemoSpectrNorm;
      prevUAMMax:= ApproachParams.UAMmax;
      ApproachParams.UAMmax:=DemoSpectrNorm;
      ZStepMin:=DemoSpectrStep;
   end;
    SetLength(ScanData.AquiSpectr.Data,SpectrParams.NSpectrPoints,2*4*SpectrParams.NPoints);   // 2*(I,Z) 2*(UAM,Z)*Npoints
    SetLength(ScanData.AquiSpectrPoint,3{2}*SpectrParams.NSpectrPoints);
   { TODO : 290507 }
   /////!!!!!!!!!!!!!!!
    ScanData.HeaderPrepare;
  with   FrT   do              //delay
   begin
    ScrollBarFrm.Max:=10000;    //ms
    ScrollBarFrm.Min:=1;
    ScrollBarFrm.Position:=SpectrParams.T;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:=siLangLinked.GetTextOrDefault('IDS_3' (* 'ms' *) );
   end;
  with   FrStartP   do
   begin
    ScrollBarFrm.Min:=SpectrParams.StartPointLimit;
    ScrollBarFrm.Max:=0;
    ScrollBarFrm.Position:=SpectrParams.StartP;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:=siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
   end;
  with FrEndPoint do
   begin
    ScrollBarFrm.Max:=SpectrParams.FinalPointLimit;
    ScrollBarFrm.Position:=SpectrParams.EndP;
    ScrollBarFrm.Min:=1;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:=siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
   end;
  with FrSupLevel do
   begin
    ScrollBarFrm.Max:=100;
    ScrollBarFrm.Min:= 0;
    ScrollBarFrm.Position:=SpectrParams.LevelSFM;
    Visible:=true;
    if  lflgIZ then
    begin
     VertMin:=round(ScrollBarFrm.Position*0.01*MaxApiType);
     BitBtnFrm.Caption:=siLangLinked.GetTextOrDefault('IDS_6' (* 'Limit IT %' *) )
    end
    else
    begin
     VertMin:=round((ScrollBarFrm.Max-ScrollBarFrm.Position)*0.01*ApproachParams.UAMMax);   //discr
     BitBtnFrm.Caption:=siLangLinked.GetTextOrDefault('IDS_7' (* 'Suppression ' *) )
    end;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:='%';
   end;

   with FrNPoints do
   begin
    ScrollBarFrm.Max:=600;
    ScrollBarFrm.Min:= 1;
    ScrollBarFrm.Position:=SpectrParams.NPoints;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:='';
   end;
    if  lflgIZ then
    begin
     Lblwarning.Panels[0].Text:=siLangLinked.GetTextOrDefault('IDS_8' (* 'Warning! The set limit of current is achieved!!! ' *) ) ;
//     label1.caption:='Level IT'
    end
    else
    begin
     Lblwarning.Panels[0].text:=siLangLinked.GetTextOrDefault('IDS_9' (* 'Warning! The set limit of suppression of a amplitude oscillation is achieved!!! ' *) ) ;
     Lblwarning.Panels[1].text:=siLangLinked.GetTextOrDefault('IDS_5' (* 'Change final point.' *) )  ;
//     label1.caption:='Amplitude suppression'
    end;
    StartPointZ:=StrToInt(FrStartP.EditFrm.Text);    //nm
    EndPointZ:=StrToInt(FrEndPoint.EditFrm.Text);       //nm
    NumbP:=StrToInt(FrNPoints.EditFrm.Text);
    ZStep:=(abs(StartPointZ)+EndPointZ)/(NumbP-1);
    LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
    LabelStepMin.Caption:=BaseCaptionStepMin+FloatToStrF(ZStepMin,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );

   if flgSurfaceData then
    begin
        case  ScanData.FileHeadRcd.HAquiADD of
  TopoGraphy:    TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_12' (* 'Topography/Top View' *) );
   Phase:        TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_13' (* 'Phase Shift' *) );
    UAM:         TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_14' (* 'Force Image' *) );
    Current:     TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_15' (* 'Current Image' *) );
             end;
   SpectrImgCreate(TabSheetTopo,TabTopoPanel,ImageTopo, siLangLinked.GetTextOrDefault('IDS_12' (* 'Topography/Top View' *) ));
 if ScanData.FileHeadRcd.HAquiADD=0 then
  begin
   ScanImageDraw(TabSheetTopo,TabTopoPanel,ImageTopo,ScanWnd.ImgRChart.BackImage.Bitmap, ScanParams.Nx, ScanParams.Ny);
  end;
  if ScanData.FileHeadRcd.HAquiADD<>0 then
  begin
    ScanImageDraw(TabSheetTopo,TabTopoPanel,ImageTopo,ScanWnd.ImgLChart.BackImage.Bitmap, ScanParams.Nx, ScanParams.Ny);
    SpectrImgCreate(TabSheetAdd,TabAddPanel,ImageAdd,TabImgCaption);
    ScanImageDraw(TabSheetAdd,TabAddPanel,ImageAdd,ScanWnd.ImgRChart.BackImage.Bitmap, ScanParams.Nx, ScanParams.Ny);
   end;
     end;
    SpectrGraphCreate;
 if assigned(ScanWnd) then ScanWnd.WindowState:=wsMinimized;
end;

constructor TSpectroscopyTerra.Create(AOwner:TComponent;const FileName:string);
 var
  j,i,Nx,maxpoints,sz:integer;
  DemoExperiment:TExperiment;
  ImgBitMap:TBitMap;
  TabImgCaption:string;
begin
 inherited Create(AOwner);
  siLangLinked.ActiveLanguage:=Lang;
  frStartP.siLangLinked1.ActiveLanguage:=Lang;
  frEndPoint.siLangLinked1.ActiveLanguage:=Lang;
  frNPoints.siLangLinked1.ActiveLanguage:=Lang;
  frT.siLangLinked1.ActiveLanguage:=Lang;
  frSupLevel.siLangLinked1.ActiveLanguage:=Lang;
  UpdateStrings;
  top:=TopStart;
  left:=LeftStart;
  BaseCaptionStep:=siLangLinked.GetTextOrDefault('IDS_0' (* 'Step=' *) ) ;
  BaseCaptionStepMin:=siLangLinked.GetTextOrDefault('IDS_1' (* 'Step Min=' *) ) ;
  LFileName:=FileName;
  FormStyle:=fsMDIChild;
  BitBtnSave.Visible:=false;
  ControlPanel.Visible:=False;
  baseCaption:=siLangLinked.GetTextOrDefault('IDS_2' (* 'Spectroscopy' *) );
  addCaption:=ExtractFileName(FileName);
  Caption:=baseCaption+' '+addCaption;
  LblWarning.Visible:=false;
  seriesColor[0]:=clblue;
  seriesColor[1]:=clred;
  seriesColor[2]:=clgreen;
  seriesColor[3]:=clblack;
  DemoExperiment:=TExperiment.Create;
try
  DemoExperiment.imFileName:=FileName;
  DemoExperiment.Readsurface(spectr);
  NPage:=DemoExperiment.MainRcd.NyPoint;
  lflgIZ:=Boolean(DemoExperiment.FileHeadRcd.HTypeSpectr);
   { TODO : 170507 }
  SpectrParams.flgIZ:=lflgIZ;
  NGraphP:=2;
  FlgSurfaceData:=True;
  if  DemoExperiment.MainRcd.NxTop<=0 then   FlgSurfaceData:=False;
  if FlgSurfaceData then
   begin
       case  DemoExperiment.FileHeadRcd.HAquiADD of
  TopoGraphy:    TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_12' (* 'Topography/Top View' *) );
   Phase:        TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_13' (* 'Phase Shift' *) );
    UAM:         TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_14' (* 'Force Image' *) );
    Current:     TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_15' (* 'Current Image' *) );
             end;
   try
     ImgBitMap:=TBitMap.Create;
     SpectrImgCreate(TabSheetTopo,TabTopoPanel,ImageTopo,siLangLinked.GetTextOrDefault('IDS_12' (* 'Topography/Top View' *) ));
     with  DemoExperiment do
     begin
      ReadSurface(Topography);
      DrawPicture(AquiTopo.data,FileHeadRcd.HNxTopo,FileHeadRcd.HNyTopo, AquiTopo.DataMax,AquiTopo.DataMin,ImgBitMap);
      DrawSpectrPoints(AquiSpectrPoint,MainRcd.NyPoint,FileHeadRcd, ImgBitMap);
      ScanImageDraw(TabSheetTopo,TabTopoPanel,ImageTopo,ImgBitMap,FileHeadRcd.HNxTopo,FileHeadRcd.HNyTopo );
     if FileHeadRcd.HAquiADD >0 then
      begin
       SpectrImgCreate(TabSheetAdd,TabAddPanel,ImageAdd,TabImgCaption);
       ReadSurface( FileHeadRcd.HAquiADD);
       DrawPicture(AquiAdd.data,FileHeadRcd.HNxTopo,FileHeadRcd.HNyTopo,AquiAdd.DataMax,AquiAdd.DataMin,ImgBitMap);
       DrawSpectrPoints(AquiSpectrPoint,MainRcd.NyPoint,FileHeadRcd, ImgBitMap);
       ScanImageDraw(TabSheetAdd,TabAddPanel,ImageAdd,ImgBitMap,FileHeadRcd.HNxTopo,FileHeadRcd.HNyTopo );
      end
     end;
   finally
    FreeAndNil(ImgBitMap);
   end;
  end;

  SpectrGraphCreate;

 if DemoExperiment.FileHeadRcd.HTypeSpectr=1 then StepValueMin:=ScannerCorrect.I_VTransfKoef/DemoExperiment.FileHeadRcd.HnA_d
                                             else StepValueMin:=1/DemoExperiment.FileHeadRcd.HUAMMax;
 // stepZ:=TransformUnit.Znm_d;
 StepValueMinIT:=1/DemoExperiment.FileHeadRcd.HBiasV_d*1000;//mv//ScannerCorrect.I_VTransfKoef/DemoExperiment.FileHeadRcd.HnA_d;

   ZStepMin:=0.001* DemoExperiment.FileHeadRcd.HSensZ*
                DemoExperiment.FileHeadRcd.HAMP_GainZ*
                DemoExperiment.FileHeadRcd.HDiscrZmvolt;

   LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
   LabelStepMin.Caption:=BaseCaptionStepMin+FloatToStrF(ZStepMin,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );


  for i:=0 to NPage-1 do
    begin
       DrawGraphics(i,DemoExperiment.AquiSpectr.Data[i],ZStepMin,StepValueMin);
    end;
 // Main.ActionExport.visible:=true;
   flgSpectrDone:=true;
//   Main.ActionExporttoMDT.enabled:=true;
  //  if assigned(ScanWnd) then ScanWnd.WindowState:=wsMinimized;
 finally
    FreeAndNil(DemoExperiment);
 end;
end;

procedure  TSpectroscopyTerra.SaveAsASCII(const FileName:string);
var Fl:TextFile;
    s,flname:STRING;
    k,i,j:integer;
    Year, Month, Day, Hour, Minut, Sec, MSec: Word;
    Present: TDateTime;
    presentdate:string;
    npoints,npoints2:integer;
    xval:single;
begin
if flgSpectrDone then
begin
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minut, Sec, MSec);
  presentdate:=intTostr(day)+'.'+inttostr(month)+'.'+inttostr(year);
 for i:=0 to Npage-1 do
 begin
   CutExtention(filename,flname);
   flname:=flname+'_'+inttostr(i)+'.txt';
 if ArChart[i].HeadSeriesList.Series.Count>0 then
 begin
   npoints:=1;
   xval:= ArChart[i].HeadSeriesList.Series.XValue[0];
  for k:=1 to   ArChart[i].HeadSeriesList.Series.Count -1 do
  begin
   if  (ArChart[i].HeadSeriesList.Series.XValue[k]<>xval) then
   inc(npoints);
   xval:=ArChart[i].HeadSeriesList.Series.XValue[k];
  end;
  npoints2:=ArChart[i].HeadSeriesList.Next.series.Count;
  npoints:=min(npoints,npoints2);
 try
    AssignFile(Fl, flName);
    ReWrite(Fl);
    S:='File Format = ASCII';
    Writeln(Fl, S);
    S:= 'Created by NanoEducator, NT-MDT, lmt. '+presentdate ;
    Writeln(Fl, S);
    S:=LFileName;
    Writeln(Fl, S);
    Writeln(Fl, 'Curves= ',inttostr(2));
    Writeln(Fl, 'NPoints in Curve= ',inttostr(npoints));
    Writeln(Fl, Format('Scale X = %5.2f',[1.0]));
    Writeln(Fl, Format('Scale Data = %5.2f',[1.0]));
    Writeln(Fl, 'Unit X = ', 'nm');
    Writeln(Fl, 'Unit Data = ','r.units');
    Writeln(Fl,  'Start of Data : ');
     for j:=0 to npoints-1 do
        begin
         Writeln(Fl,ArChart[i].HeadSeriesList.Series.XValues[j],' ',ArChart[i].HeadSeriesList.Series.YValues[j],' ',ArChart[i].HeadSeriesList.Next.Series.YValues[j])
        end;
(*     for j:=0 to npoints-1 do
        begin
         Writeln(Fl,ArChart[i].HeadSeriesList.Next.Series.XValues[j],' ',ArChart[i].HeadSeriesList.Next.Series.YValues[j])
        end;
 *)
 finally
    CloseFile(Fl);
 end;
 end;
end;  //i
end;//done
end;
Procedure   TSpectroscopyTerra.SaveAsMDT(const FileName:string);
var
  i,j,n,k:integer;
  dt : Pointer;
  FP, BP :PData;
  MDTFile:MDFileExport;
  srt : TFileStream;
  DemoExperiment:TExperiment;
begin
  DemoExperiment:=TExperiment.Create;
try
  DemoExperiment.imFileName:=lFileName;
  DemoExperiment.Readsurface(spectr);
  dt := nil;   FP:=nil; BP:=nil;
  MDTFile := MDFileExport.Create;
 if FlgSurfaceData then
 begin
   DemoExperiment.Readsurface(Topography);
   GetMem(dt,DemoExperiment.AquiTopo.NX*DemoExperiment.AquiTopo.Ny*sizeof(Apitype));
 try
  with MDTFile do
  begin
   if DemoExperiment.FileHeadRcd.HAquiTopo then
    begin
      DemoExperiment.Readsurface(Topography);
      x0 :=DemoExperiment.FileHeadRcd.HXBegin;
      xr :=DemoExperiment.AquiTopo.XStep;
      y0 :=DemoExperiment.FileHeadRcd.HYBegin;
      yr :=DemoExperiment.AquiTopo.YStep;;
      z0 := 0;
      zr :=DemoExperiment.AquiTopo.ZStep;
      dt:= DemoExperiment.AquiTopo;
      Name:=DemoExperiment.AquiTopo.Caption;
      AddScan(DemoExperiment.AquiTopo.NX,DemoExperiment.AquiTopo.NY,dt);
    end;
    if DemoExperiment.FileHeadRcd.HAquiADD<>0 then
    begin
      DemoExperiment.Readsurface(DemoExperiment.FileHeadRcd.HAquiADD);
      zr:=DemoExperiment.AquiAdd.ZStep;
      dt:= DemoExperiment.AquiAdd;
      Name :=DemoExperiment.AquiAdd.Caption;
      AddScan(DemoExperiment.AquiTopo.NX,DemoExperiment.AquiTopo.NY,dt);
    end;
   end;
  finally
  end;
 end;
   if DemoExperiment.FileHeadRcd.HTypeSpectr=1 then
                                          begin
                                            MDTFile.yr:=1/DemoExperiment.FileHeadRcd.HnA_d;
                                            MDTFile.YUnit:=23;
                                          end
                                          else
                                          begin
                                           MDTFile.yr:=1/DemoExperiment.FileHeadRcd.HUAMMax;
                                           MDTFile.YUnit:=3;
                                          end;

 //   MDTFile.xr:=1;    MDTFile.yr:=1;
   MDTFile.XUnit:=-1;     MDTFile.YUnit:=3;
   MDTFile.x0:=0.001* DemoExperiment.FileHeadRcd.HSensZ*
                      DemoExperiment.FileHeadRcd.HAMP_GainZ*
                      DemoExperiment.FileHeadRcd.HDiscrZmvolt
                      *DemoExperiment.AquiSpectr.Data[0,1];
   MDTFile.xr:=0.001* DemoExperiment.FileHeadRcd.HSensZ*
                      DemoExperiment.FileHeadRcd.HAMP_GainZ*
                      DemoExperiment.FileHeadRcd.HDiscrZmvolt
                      *(DemoExperiment.AquiSpectr.Data[0,3]-DemoExperiment.AquiSpectr.Data[0,1]);
   MDTFile.AddSpectroscopy;
 for i:=0 to DemoExperiment.MainRcd.NyPoint-1 do
 begin
   n:=DemoExperiment.MainRcd.NxSpec div 4;
   GetMem(FP,n*sizeof(smallint));
   Getmem(BP,n*sizeof(smallint));
  try
  j:=0;
  for k:=0 to n-1 do
       begin
          Psmallarray(FP)[k]:=DemoExperiment.AquiSpectr.Data[i,j];
          j:=j+2;
        end;
        j:=4*n-2;
  for k:=0 to n-1 do
        begin
          Psmallarray(BP)[k]:=DemoExperiment.AquiSpectr.Data[i,j];
          j:=j-2;
        end;
   MDTFile.AddSpectroPoint( DemoExperiment.AquiSpectrPoint[i]*MDTFile.xr,
                      DemoExperiment.AquiSpectrPoint[i+1]*MDTFile.yr,n,n,FP,BP);
  finally
    Freemem(BP);
    Freemem(FP);
  end;
 end; //i
  srt:= TFileStream.Create(FileName,fmCreate);
  MDTFile.WriteToStream(srt);
  srt.Free;
  FreeAndNil(MDTFile);
finally
  FreeAndNil(DemoExperiment);
end;
end;




procedure TSpectroscopyTerra.ScanImageDraw(TabSheetSpectr:TTabSheet;TabSpectrPanel:TPanel;var ImageSpectr:TImage;BitMap:TBitMap; nx,ny:integer);
var
    wh:integer;
    DelImg2XS,DelImg2YS,DelImg2S:single;
     SquareBitmap, BitMapTmp:TBitMap;
    RBufImage, GBufImage, BBufImage: WordArray2D ;
    P:PByteArray;
    i,j:integer;
begin
     SquareBitmap:=TBitMap.Create;
     BitmapTmp:=TBitMap.Create;
 try
     SetLength( RBufImage,BitMap.Height,BitMap.Width);
     SetLength( GBufImage,BitMap.Height,BitMap.Width);
     SetLength( BBufImage,BitMap.Height,BitMap.Width);
          with ImageSpectr do
          begin
              Align:=alNone;
             Stretch:=True;
             left:=0;
             Width:=TabSheetSpectr.width-3;
             Height:=TabSheetSpectr.height-3;
             wh:=min(Width,Height);
             Height:=wh;
             Width:=wh;
             DelImg2XS:=(NX/Width);
             DelImg2YS:=(NY/Height);
             DelImg2S:=max(DelImg2XS,DelImg2YS);
             Width:=max(round(NX/DelImg2s),round(NY/DelImg2s)) ;
             Height:=Width ;
             CopyMe(BitMapTmp,Bitmap);
            for i:= 0 to BitMap.Height -1 do
                begin
                   P := BitMapTmp.ScanLine[i];
                   for j:= 0 to BitMap.Width-1 do
                   begin
                    BBufImage[i,j]:=P[3*j];
                    GBufImage[i,j]:=P[3*j+1];
                    RBufImage[i,j]:=P[3*j+2];
                   end
                end;
            wh:=max(BitMap.Height,BitMap.Width);
            SquareBitmap.Height:=wh;
            SquareBitmap.Width:= wh;
            SquareBitMap.PixelFormat:=pf24bit;
           for i:= 0 to BitMap.Height -1 do
             begin
              P := SquareBitMap.ScanLine[i+(wh-BitMap.Height)];
              for j:= 0 to BitMap.Width-1 do
              begin
                 P[3*j]:=BBufImage[i,j];
               P[3*j+1]:=GBufImage[i,j];
               P[3*j+2]:=RBufImage[i,j];
              end;
             end;
             Picture.Bitmap.Assign( SquareBitMap);
             top:=TabSheetSpectr.Height- Height+1;
             Finalize(RBufImage);
             Finalize(GBufImage);
             Finalize(BBufImage);
          end;
   finally
             FreeandNil(SquareBitmap);
             FreeandNil(BitMapTmp);
   end;
end;

procedure TSpectroscopyTerra.siLangLinkedChangeLanguage(Sender: TObject);
begin

  UpdateStrings;
end;

procedure TSpectroscopyTerra.CopyMe(tobmp: TBitmap; frbmp : TGraphic);
begin
  tobmp.Width := frbmp.Width;
  tobmp.Height := frbmp.Height;
  tobmp.PixelFormat := pf24bit;
  tobmp.Canvas.Draw(0,0,frbmp);
end;
procedure TSpectroscopyTerra.PageControlChange(Sender: TObject);
var i:integer;
begin
  inherited;
   ActiveIndex:=PageControl.ActivePageIndex;
  with PageControl do
  begin
   ActiveIndex:=ActivePageIndex;
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
   ActivePage.HighLighted:=True;
  end;
  if not SetIntActOnProgr then
   begin
     if ActiveIndex<(PageControl.PageCount-Npage) then exit;
      Dec(ActiveIndex,PageControl.PageCount-Npage);
       ArChart[ActiveIndex].RePaint;
   end;
end;
procedure TSpectroscopyTerra.SpectrImgCreate(var TabSheetSpectr:TTabSheet;var TabSpectrPanel:TPanel;var IMageSpectr:TImage;const ImageCaption:string);
begin
      TabSheetSpectr:=TTabSheet.Create(PageControl);
      TabSheetSpectr.PageControl:=PageControl;
      TabSheetSpectr.TabVisible:=True;
      TabSheetSpectr.Caption:=ImageCaption;
      TabSpectrPanel:=TPanel.Create(TabSheetSpectr);
      TabSpectrPanel.parent:=TabSheetSpectr;
      TabSpectrPanel.Align:=alClient;
      IMageSpectr:=TImage.Create(TabSheetSpectr);
      IMageSpectr.parent:=TabSpectrPanel;
      IMageSpectr.OnMouseDown:=SpectrImgMouseDown;
      TabSpectrPanel.OnMouseDown:=SpectrImgMouseDown;
end;
procedure TSpectroscopyTerra.SpectrImgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 (*       if (Button=mbLeft) and (ssAlt in Shift) then
            begin
             PageControl.BeginDrag(False);
             CopyToClipboard;
            end
              *)
end;

procedure TSpectroscopyTerra.SpectrGraphCreate;
var i,j,nx,ny,wh:integer;
    DelImg2XS,DelImg2YS,DelImg2S:single;
begin
  SetLength(ArTabSheet,NPage);
  SetLength(ArChart,NPage);
 for i:=0 to (NPage-1) do
    begin
      ArTabSheet[i]:=TTabSheet.Create(PageControl);
      ArTabSheet[i].PageControl:=PageControl;
      ArTabSheet[i].TabVisible:=True;
      ArTabSheet[i].Caption:=siLangLinked.GetTextOrDefault('IDS_36' (* 'Point= ' *) )+IntToStr(i+1);
      ArChart[i]:=TChartSpectrographiTerra.Create(TComponent(ArTabSheet[i]));
      ArChart[i].Align:=alClient;
      ArChart[i].AllowEditChartMenu.Checked:=false;
      InvalidateRect( ArChart[i].Handle, nil, False);
      ArChart[i].Chart.Legend.Visible:=True;
      ArChart[i].Chart.Legend.LegendStyle:=lsAuto;
      ArChart[i].Chart.Legend.ResizeChart:=true;
      ArChart[i].Chart.LeftAxis.Automatic:=True;
      ArChart[i].Chart.LeftAxis.Title.Angle:=90;
      ArChart[i].Chart.LeftAxis.LabelsSize:=30;
      ArChart[i].Chart.ShowHint:=true;
      ArChart[i].Chart.hint:=siLangLinked.GetTextOrDefault('IDS_37' (* 'Click Left Button to set label; Click Right Button to show popup menu' *) );
      if lflgIZ then ArChart[i].Chart.LeftAxis.Title.Caption:=siLangLinked.GetTextOrDefault('IDS_38' (* 'I nA' *) )
                else
                begin
                 ArChart[i].Chart.LeftAxis.Title.Caption:=siLangLinked.GetTextOrDefault('IDS_39' (* 'r.u. A/Amax' *) );
                 ArChart[i].Chart.RightAxis.Title.Caption:=siLangLinked.GetTextOrDefault('IDS_26' (* 'mV' *) );
                end;
      ArChart[i].Chart.BottomAxis.Title.Angle:=0;
      ArChart[i].Chart.BottomAxis.Title.Caption:=siLangLinked.GetTextOrDefault('IDS_40' (* 'Z  nm' *) );
    if not  ArChart[i].AllowEditChartMenu.Checked then ArChart[i].AllowEditClick(self);
     with ArChart[i].Chart.Title.Text do
        begin
       	 Clear;
         Add(siLangLinked.GetTextOrDefault('IDS_41' (* 'Spectroscopy Curve' *) ));
        end;

        ArChart[i].EditFindLineChartPopUpMenu.Visible:=false;
        ArChart[i].EditFindLineChartMenu.Visible:=false;
        ArChart[i].AddSeries(clred);    //uam
//        ArChart[i].AddSeries(clmaroon); //it
        ArChart[i].AddSeries(clBlue);  //uam backward
//        ArChart[i].AddSeries(clblack); //it backward

        ArChart[i].HeadSeriesList.Series.title:=siLangLinked.GetTextOrDefault('IDS_43' {* ' landing' *} ); //rising   red;
        ArChart[i].HeadSeriesList.Series.SeriesColor:=clRed;
        ArChart[i].HeadSeriesList.Series.Pointer.Style:=psCircle;
        ArChart[i].HeadSeriesList.Series.Pointer.VertSize:=2;
        ArChart[i].HeadSeriesList.Series.Pointer.HorizSize:=2;
 
(*      ArChart[i].HeadSeriesList.Next.Series.title:=siLangLinked.GetTextOrDefault('IDS_43' {* ' landing' *} ); //rising   red;
        ArChart[i].HeadSeriesList.Next.Series.SeriesColor:=clmaroon;
        ArChart[i].HeadSeriesList.Next.Series.Pointer.Style:=psCircle;
        ArChart[i].HeadSeriesList.Next.Series.Pointer.VertSize:=2;
        ArChart[i].HeadSeriesList.Next.Series.Pointer.HorizSize:=2;
        ArChart[i].HeadSeriesList.Next.Series.vertaxis:= aRightAxis;
*)

        ArChart[i].HeadSeriesList.Next.Series.title:=siLangLinked.GetTextOrDefault('IDS_42' {* ' rising' *} ); //landing' blue;
        ArChart[i].HeadSeriesList.Next.Series.SeriesColor:=clBlue;
        ArChart[i].HeadSeriesList.Next.Series.Pointer.Style:=psCircle;
        ArChart[i].HeadSeriesList.Next.Series.Pointer.VertSize:=2;
        ArChart[i].HeadSeriesList.Next.Series.Pointer.HorizSize:=2;
        ArChart[i].HeadSeriesList.Next.Series.vertaxis:= aRightAxis;

(*
        ArChart[i].HeadSeriesList.Next.Series.title:=siLangLinked.GetTextOrDefault('IDS_42' {* ' rising' *} ); //landing' blue;
        ArChart[i].HeadSeriesList.Next.Series.SeriesColor:=clblack;
        ArChart[i].HeadSeriesList.Next.Series.Pointer.Style:=psCircle;
        ArChart[i].HeadSeriesList.Next.Series.Pointer.VertSize:=2;
        ArChart[i].HeadSeriesList.Next.Series.Pointer.HorizSize:=2;
        ArChart[i].HeadSeriesList.Next.Series.vertaxis:= aRightAxis;
*)
   end;
end;

procedure TSpectroscopyTerra.StartBtnClick(Sender: TObject);
var i,j,index:integer;
    x0nm,y0nm:double;
    nCor,NumbPupdate:apitype;
    ZStepD:word;//discr
begin
 if LabelStep.Font.Color=clRed then
 begin
  MessageDlg(strs2{'Step too small!'}+#13+strs3{'Change Parameters.'},mtError,[mbOk],0);
  exit;
 end;
 if Error=0 then
 begin
  if  not flgStopSpectr then //Stop    Scanning
   begin
       StartBtn.Enabled:=false;
       flgStopJava:=true;
  //     NanoEdu.Method.StopWork;
  //     NanoEdu.Method.WaitStopWork;
   end
   else       //Start  Scannning
   begin
 // try
    flgStopSpectr:=false;
    StartBtn.Caption:=strstop;// '&STOP';
//    StartBtn.Font.Color:=clRed;
    StartBtn.Enabled:=true;
    Caption:=BaseCaption;
    BitBtnSave.Enabled:=false;
    BitBtnExit.Enabled:=false;
    inc(countStart);
    WorkNameFile:=workdirectory+'\'+WorkNameFileMaskCur+ScandataWorkFileNameEm(CountStart)+WorkExtFile;
    T:=StrToInt(FrT.EditFrm.Text);
    StartPointZ:=StrToInt(FrStartP.EditFrm.Text);        //nm
    EndPointZ:=StrToInt(FrEndPoint.EditFrm.Text);       //nm
    NumbP:=StrToInt(FrNPoints.EditFrm.Text);
    if  lflgIZ then VertMin:=round(StrtoInt(FrSupLevel.EditFrm.Text)*0.01*MaxApiType)
               else VertMin:=round((100-StrtoInt(FrSupLevel.EditFrm.Text))*0.01*ApproachParams.UAMMax);   //discr
    flgProcess:=true;
    ZStep:=(abs(StartPointZ)+EndPointZ)/(NumbP-1);
    ZStepD:=round(ZStep*TransformUnit.Znm_d); //discrete
    nCor:=(round((EndPointZ-StartPointZ)*TransformUnit.Znm_d)-ZStepD*(NumbP-1)) div ZStepD;
    NumbPUpdate:=NumbP+nCor;
    lblWarning.Visible:=false;
   if ZStepD<1 then  begin  MessageDlg(strs4{siLangLinked1.GetTextOrDefault('IDS_46' (* 'Step too small!Change Parameters.' *) )},mtWarning,[mbOk],0); exit; end;
    LabelStep.Caption:=siLangLinked.GetTextOrDefault('IDS_47' (* 'Step = ' *) )+FloatToStrF(ZStep,ffFixed,5,2)+ siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
    SpectrParams.StartP:=StartPointZ;    //nm
    SpectrParams.EndP:=EndPointZ;       //nm
    SpectrParams.NPoints:=NumbPUpdate;
    SpectrParams.NSpectrPoints:=ArPntSpector.Count;  //number point when spectroscopy are  made
    SpectrParams.T:=T ;
    SpectrParams.TC:=ApproachParams.ScannerDecay;
    SpectrParams.LevelSFM:=StrtoInt(FrSupLevel.EditFrm.Text);
    SpectrParams.Step:=ZStep;  { TODO : 220506 }
    SetLength(ScanData.AquiSpectr.Data,SpectrParams.NSpectrPoints,2*4*SpectrParams.NPoints);   // 2*(UAM,Z)*Npoints
    SetLength(ScanData.AquiSpectrPoint,3*SpectrParams.NSpectrPoints);
    ScanData.HeaderPrepare;

   for i:=0 to (NPage-1) do ArChart[i].ClearAllSeries;

   SpectrPointNmb:=0;
   SpectrPointNmb_Data:=0;  //
//   for i:=0 to NPage-1 do
   Index:=0;
   PageControl.Pages[Index].HighLighted:=False;
   if Assigned(TabSheetSpectr) then  inc(Index);
      PageControl.ActivePageIndex:=Index;
      PageControl.ActivePage.HighLighted:=True;
      PntSpector:=ArPntSpector.items[SpectrPointNmb];
      x0nm:=PntSpector^.point.x;
      y0nm:=PntSpector^.point.y;
      ScanData.AquiSpectrPoint[0]:=-round((x0nm+Scanparams.xshift)*TransformUnit.xPnm_d)+CSPMSignals[8].MaxDiscr;//round(x0nm*TransformUnit.XPnm_d);    //discrets
      ScanData.AquiSpectrPoint[1]:=-round((y0nm+Scanparams.yshift)*TransformUnit.yPnm_d)+CSPMSignals[9].MaxDiscr;//round(y0nm*TransformUnit.YPnm_d);
      ScanData.AquiSpectrPoint[SpectrPointNmb_Data+2]:=1;
//      inc(SpectrPointNmb_Data,3);
 if not assigned(Approach) then
 begin
       NanoEdu.ScanMoveToX0Y0Method(X0nm,y0nm);
       error:=NanoEdu.Method.Launch;
      while assigned(ProgressMoveTo) do application.processmessages;
       if error<>0 then
       begin
        RestoreStart;
        exit
       end;
 end;
//      Application.ProcessMessages;
      SpectrParams.CurrentLine:=0;
      SpectrPointNmb:=0;
      SpectrPointNmb_Data:=0;
      DemoSpectrCnt:=0;
      NanoEdu.SpectroscopyMethod;
     if NanoEdu.Method.Launch<>0 then
      begin FreeAndNil(NanoEdu.Method); ReStoreStart; exit; end;
    (*
      SpectrParams.CurrentLine:=SpectrPointNmb;
      DemoSpectrCnt:=SpectrPointNmb;
      NanoEdu.SpectroscopyMethod;
      if NanoEdu.Method.Launch<>0 then begin FreeAndNil(NanoEdu.Method); ReStoreStart; exit; end;
  *)
   end{Error=0}    
  end
 else
    MessageDlgCtr(strs1{'no Demo Data!!!'}, mtInformation,[mbOk],0);
end;

procedure TSpectroscopyTerra.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
   if Panel = StatusBar.Panels[0] then
  begin
    StatusBar.Canvas.Font.Color := clBlack;
    StatusBar.Canvas.Font.Size:=-9;
//    StatusBar.Canvas.Font.Style.fsBold:=true;
    StatusBar.Canvas.TextOut(Rect.Left, Rect.Top,strs9{'Click Right Button- Popup Menu;Labels ( Click  Left Button - Add ;  Del - Delete;Up,Down-Next,Previous );'})
  end
  else
  begin
    StatusBar.Canvas.Font.Color := clBlack;
    StatusBar.Canvas.Font.Size:=-9;
//    StatusBar.Canvas.Font.Style:=fsBold;
    StatusBar.Canvas.TextOut(Rect.Left, Rect.Top,strs10{'Curves (Pg up,Pg down- next, previous)'});
  end;

end;

procedure  TSpectroscopyTerra.ReStoreStart;
begin
(*   StartBtn.Enabled:=True;
   StartBtn.Caption:=strstart;// '&START';
   BitBtnExit.Enabled:=true;
   flgProcess:=false;
*)
   StartBtn.Caption:=strstart;// '&START';
   flgStopSpectr:=true;
   StartBtn.Down:=false;
   StartBtn.Enabled:=True;
   BitBtnExit.Enabled:=true;
   flgProcess:=false;
   flgStopJava:=false;
end;

procedure TSpectroscopyTerra.DrawGraphics(const i:integer; UData:Array of datatype; const StepZ,StepValue:single);
var
    k,j,m,Index:integer;
    umstart,umstop:single;
    Z,Value:single;
    nz:integer;
    zprev,udata1,udata0:datatype;
begin
  Nz:=length(UData) div 4 ;
  umstart:=(UData[1]*ZStepMin);
  umstop:=(UData[2*nz-1]*ZStepMin);
   Index:=i;
   PageControl.Pages[Index].HighLighted:=False;
   if Assigned(TabSheetTopo) then  inc(Index);
      if Assigned(TabSheetAdd) then  inc(Index);
     PageControl.ActivePageIndex:=Index;
     PageControl.ActivePage.HighLighted:=True;
 for j:=0 to (NgraphP-1) do
  begin
    case j of
    0: begin     //red          landing
        m:=0;
        ArChart[i].SetActiveSeries(ArChart[i].HeadSeriesList.Series);
        zprev:=MinDATATYPE;
      for k:=0 to (Nz-1) do
       begin
          udata1:=UData[m+1];
          udata0:=UData[m];
          Z:=UData1*ZStepMin;
          value:=UData0*StepValueMin;
    //    if (udata1>zprev) then
   //     begin
          ArChart[i].HeadSeriesList.Series.AddXY(Z,Value);
          zprev:= udata1;
   //     end;
           inc(m,2);
       end;
      end;
    1: begin      //blue        rising
        m:=2*Nz;
       ArChart[i].SetActiveSeries(ArChart[i].HeadSeriesList.next.Series);
       for k:=Nz to (2*Nz-1) do
       begin
         Z:=UData[m+1]*ZStepMin;
         value:=UData[m]*StepValueMinIT;
        // if Z>=umstart then
        // begin
           ArChart[i].HeadSeriesList.Next.Series.AddXY(Z,Value);//,'',seriesColor[j]);
         //end
       // else flgLimitSpectr:=true;
             inc(m,2);
       end;
        if not (flgCurrentUserLevel=Demo)and flgLimitSpectr then  lblwarning.Visible:=true;

           Application.ProcessMessages;
      end;
    end; //case
  end; //j
    ActiveIndex:= PageControl.ActivePageIndex;
    if Assigned(TabSheetTopo) then  dec(ActiveIndex);
      if Assigned(TabSheetAdd) then  dec(ActiveIndex);// inc(Index);

    ArChart[i].SetActiveSeries(ArChart[i].HeadSeriesList.Series);
    ArChart[ActiveIndex].SetFindLine_pos(0);
    ArChart[ActiveIndex].RePaint;
end;

(*
procedure TSpectroscopy.ChartResMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var XPosition:longint;
  i:integer;
begin
 if (Button=mbLeft) and (ssAlt in Shift) then
            begin
             ArChart[0].BeginDrag(False);
             CopyClipboard;
             exit;
            end
(*  else
  begin
   for i:=0 to NPage-1 do ArChart[i].AllowZoom:=True;
   XPosition:=ArChart[ActiveIndex].BottomAxis.CalcPosValue(FindLine_pos);
   if (abs(XPosition- X)<8) then
   begin
    DBegin:=True;  { TODO : 160107 }
    ArChart[ActiveIndex].OriginalCursor := crHandPoint;
    ArChart[ActiveIndex].AllowZoom:=False;
   end;
  end;

end;
procedure TSpectroscopy.DrawFindLine(i:integer);
var
  x: integer;
begin
  if (Max_Y<>Min_Y) then
  begin
    x:= ArChart[i].Chart.BottomAxis.CalcXPosValue(FindLine_pos);
    ArChart[i].Chart.Canvas.Pen.Color:= clGreen;
    ArChart[i].Chart.Canvas.Pen.Width:= 2;
    ArChart[i].Chart.Canvas.Pen.Mode:=pmNotXOR;
    ArChart[i].Chart.Canvas.Brush.Color:=clGreen;
    ArChart[i].Chart.Canvas.Brush.Style:=bsSolid;
    with ArChart[i].Chart.Canvas do
     begin
      MoveTo(x,ArChart[i].Chart.LeftAxis.CalcYPosValue(Min_Y));
      LineTo(x,ArChart[i].Chart.LeftAxis.CalcYPosValue(Max_Y));
      LineTo(x-8,ArChart[i].Chart.LeftAxis.CalcYPosValue(Max_Y)-6);
      LineTo(x+8,ArChart[i].Chart.LeftAxis.CalcYPosValue(Max_Y)-6);
      LineTo(x,ArChart[i].Chart.LeftAxis.CalcYPosValue(Max_Y));
     end;
    ArChart[i].Chart.Canvas.Pen.Width:= 1;
  end;
end;

procedure TSpectroscopy.ChartResMouseMove(Sender: TObject;Shift: TShiftState; X, Y: Integer);
var
    Yvalue:single;
begin
  if DBegin then
    begin
        DrawFindLine(ActiveIndex);
        FindLine_pos:=ArSeries[ActiveIndex,0].XScreenToValue(X);
        ActiveSeries:=ArSeries[ActiveIndex,0];
        SetFindLine_Pos(ActiveIndex,FindLine_pos);
        DrawFindLine(ActiveIndex);
        ActiveSeries:=ArSeries[ActiveIndex,0];
    if FindYValue( ActiveSeries,FindLine_Pos,Yvalue)then
    if lflgIZ then edSetPoint.Caption:=FloatToStrF(Yvalue,ffFixed,5,2 )
              else edSetPoint.Caption:=FloatToStrF((1-Yvalue),ffFixed,5,2 );
   end
   else
  begin
   if (abs(ArChart[ActiveIndex].BottomAxis.CalcXPosValue(FindLine_pos)-x)<8)
      then ArChart[ActiveIndex].OriginalCursor := crHandPoint
      else ArChart[ActiveIndex].OriginalCursor :=CursorSaved;
      Application.processmessages;
  end;;
end;

procedure TSpectroscopy.ChartResMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
//var i:integer;
 begin
  DBegin:=False;
  arChart[ActiveIndex].OriginalCursor:=CursorSaved;
 end;
*)
procedure TSpectroscopyTerra.BitBtnApplyClick(Sender: TObject);
begin
 //
end;

procedure TSpectroscopyTerra.BitBtnCancelClick(Sender: TObject);
begin
     Close;
end;
procedure TSpectroscopyTerra.FormClose(Sender: TObject;var Action: TCloseAction);
var i:integer;
begin
 Application.ProcessMessages;
 if ControlPanel.Visible then   //????
 begin
  if flgCurrentUserLevel=Demo then ApproachParams.UAMmax:=prevUAMMax;
   if assigned(ScanWnd) then
   begin
    Scanwnd.RestoreStartSFM;     { TODO : 160906 }
   end;
   ScanParams.ScanMethod:=prevScanMethod;
   Finalize(DemoSpectrCurves);
    if (not assigned(ScanWnd)) and assigned(ScanData)   then  FreeAndNil(ScanData);
    if assigned(ScanWnd)        then  ScanWnd.WindowState:=wsNormal;
    if Assigned(Approach)       then  Approach.WindowState:=wsNormal;
    if Assigned(SetInteraction) then  SetInteraction.WindowState:=wsNormal;
 end;
    for i:=0 to  NPage-1 do
    begin
      ArChart[i].Destroy;
      ArChart[i]:=nil;
      ArTabSheet[i].Destroy;
      ArTabSheet[i]:=nil;
    end;
    Finalize(ArChart);
    Finalize(ArTabSheet);
 if assigned(QRImage)  then FreeAndNil(QRImage);
 if assigned(QRBand)   then FreeAndNil(QRBand);
 if assigned(QuickRep) then FreeAndNil(QuickRep);
 if (ArFrmGl.count=0)then
   begin
    Main.ActionImageTools.Visible:=false;
    Main.FileInfItem.Enabled:=False;
 //   Main.PrintItem.Enabled:=False;
//    Main.ActionPrint.Enabled:=false;
//    Main.FileInfItem.Enabled:=false;
//    Main.ActionExport.enabled:=false;
   end;
   if (ArFrmSpectr.count=0) and (ArFrmGl.count=0) then
   begin
    Main.ArrangeWindows1.Enabled:=False;
//    Main.ActionExporttoMDT.enabled:=false;
    Main.ActionPrint.Enabled:=false;
 //    Main.ActionSaveAs.Enabled:=false;
 //   Main.PrintItem.Enabled:=False;
 //   Main.ActionPrint.Enabled:=false;
  //  Main.ActionExport.enabled:=false;
   end;
//   Main.ActionExport.enabled:=false;
  if not ControlPanel.Visible then   //????
  begin  ArFrmSpectr.Remove(self); end;
    Action:=caFree;
  if (self=SpectrWndTerra) then  SpectrWndTerra:=nil;
end;

procedure TSpectroscopyTerra.FrStartPEditFrmChange(Sender: TObject);
var Val:integer;
begin
  if (FrStartP.editFrm.text='') or (FrStartP.editFrm.text='-') then   exit;
  try
      val:=StrToInt(FrStartP.EditFrm.Text);
    if val<FrStartP.ScrollBarFrm.Min then
    begin
     val:=FrStartP.ScrollBarFrm.Min;
     FrStartP.EditFrm.Text:=inttostr(val);
    end;
    if val>FrStartP.ScrollBarFrm.Max then
    begin
     val:=FrStartP.ScrollBarFrm.Max;
     FrStartP.EditFrm.Text:=inttostr(val);
    end;
   StartPointZ:=StrToInt(FrStartP.EditFrm.Text);
    ZStep:=(EndPointZ-StartPointZ)/(NumbP-1);
    FrStartP.ScrollBarFrm.Position:=StartPointZ;
    LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+ siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
    LabelStep.Font.Color:=clBlack;
  if ZStep<ZStepMin then
     begin
      LabelStep.Font.Color:=clRed;
     end;
except
    on EConvertError do
     begin
      MessageDlg(strs5{'Error input. Start point must be <=0!'},mtWarning,[mbOk],0);
      FrStartP.editFrm.text:=siLangLinked.GetTextOrDefault('IDS_53' (* '-200' *) );
    end;
 end;
end;

procedure TSpectroscopyTerra.FrNPointsEditFrmChange(Sender: TObject);
var val:integer;
begin
 try
  if (FrNpoints.editFrm.text='')  then   exit;
   val:=StrToInt(FrNpoints.EditFrm.Text);
    if val<FrNpoints.ScrollBarFrm.Min then
    begin
     val:=FrNpoints.ScrollBarFrm.Min;
     FrNpoints.EditFrm.Text:=inttostr(val);
    end;
    if val>FrNpoints.ScrollBarFrm.Max then
    begin
     val:=FrNpoints.ScrollBarFrm.Max;
     FrNpoints.EditFrm.Text:=inttostr(val);
    end;
    NumbP:=StrToInt(FrNPoints.EditFrm.Text);
    ZStep:=(EndPointZ-StartPointZ)/(NumbP-1);
    LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+ siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
    LabelStep.Font.Color:=clBlack;
    { TODO : 250607 }
    FrNpoints.ScrollBarFrm.position:=NumbP;
    if ZStep<ZStepMin then
     begin
      LabelStep.Font.Color:=clRed;
     end;
  except
    on EConvertError do
     begin MessageDlg(strs6{'error input'},mtWarning,[mbOk],0);FrNpoints.editFrm.text:=siLangLinked.GetTextOrDefault('IDS_57' (* '100' *) );end;
  end;
end;

procedure TSpectroscopyTerra.FrEndPointEditFrmChange(Sender: TObject);
begin
   FrEndPoint.EditFrmChange(Sender);
try
 if  (FrEndPoint.EditFrm.Text='')  or (FrEndPoint.EditFrm.Text='-') then exit;
  EndPointZ:=StrToInt(FrEndPoint.EditFrm.Text);
   ZStep:=(EndPointZ-StartPointZ)/(NumbP-1);
   LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+ siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
   LabelStep.Font.Color:=clBlack;
  if ZStep<ZStepMin then
     begin
      LabelStep.Font.Color:=clRed;
     end;
    FrEndPoint.ScrollBarFrm.position:=EndPointZ;
except
    on EConvertError do
     begin MessageDlg(strs6{'error input'},mtWarning,[mbOk],0);FrEndPoint.editFrm.text:=siLangLinked.GetTextOrDefault('IDS_57' (* '100' *) );end;
 end;

end;

procedure TSpectroscopyTerra.BitBtnSaveClick(Sender: TObject);
var i:integer;
ww:Tform;
begin
  ScanData.workfilename:=worknamefile;//DemoDataDirectory+DemoSpectrSFMFile;
  ScanData.HeaderPrepare;
  ScanData.SaveSpectr;
  LFileName:=worknamefile;
  addCaption:=ExtractFileName(worknamefile);
  Caption:=BaseCaption+' '+addCaption;
  if assigned(DirView)      then   DirView.ReDraw;
  if assigned(WorkView) and  WorkView.visible then
  begin
        WorkView.Redraw;
        Application.processmessages;
        WorkView.ActivateIcon(WorkNameFile);
  end;
end;


procedure TSpectroscopyTerra.BitBtnHelpClick(Sender: TObject);
begin
    Application.HelpContext(IDH_Spectroscopy{39});
end;
procedure TSpectroscopyTerra.WMNCLButton(var Message: TMessage);
 begin
       case Message.wParam of
HTCAPTION:
          begin
           if AltDown  then        // copy to clipboard    for report
             if  assigned(ReportForm) then
             begin
               Panelmain.BeginDrag(False);
               Main.CopyToClipBoardExecute(self);
               ReportForm.CaptureSourceImage(Panelmain);
             end;
           end;
      end;
      inherited;
 end;

procedure TSpectroscopyTerra.ThreadDone(var AMessage : TMessage);      // Message to be sent back from thread when its done
 // Message to be sent back from thread when its done
 var i,NEWPOINTS:integer;
 x0nm,y0nm:double;
 begin
 if  (mDrawing=AMessage.WParam)  then
  begin
    if assigned(SpectrTerraThread) then
     begin
        SpectrTerraThread:=nil;
        SpectrTerraThreadActive := false;
     end;//drawthread
     inc(SpectrPointNmb);
   if SpectrPointNmb<NPage then
    begin
      PageControl.Pages[SpectrPointNmb-1].HighLighted:=False;
      PageControl.ActivePageIndex:=SpectrPointNmb+1;
      PageControl.ActivePage.HighLighted:=True;
      Application.ProcessMessages;
      PntSpector:=ArPntSpector.items[SpectrPointNmb];      //ChartNMb????? 080212
      x0nm:=PntSpector^.point.x;
      y0nm:=PntSpector^.point.y;
      inc(SpectrPointNmb_Data,3);    //010213
      ScanData.AquiSpectrPoint[SpectrPointNmb_Data]:=-round((X0nm+Scanparams.xshift)*TransformUnit.XPnm_d)+CSPMSignals[8].MaxDiscr;     //discrets   add P round(x0nm*TransformUnit.XPnm_d);    //discrets
      ScanData.AquiSpectrPoint[SpectrPointNmb_Data+1]:=-round((y0nm+Scanparams.yshift)*TransformUnit.yPnm_d)+CSPMSignals[9].MaxDiscr;//round(y0nm*TransformUnit.YPnm_d);
      ScanData.AquiSpectrPoint[SpectrPointNmb_Data+2]:=1;
//     
      while assigned(nanoedu.method) do application.ProcessMessages; //211211
      NanoEdu.ScanMoveToX0Y0Method(X0nm,y0nm);
      error:=NanoEdu.Method.Launch;
      FreeAndNil(NanoEdu.Method);
     if error<>0 then
      begin
       RestoreStart;
       exit
      end;
      Application.ProcessMessages;
      SpectrParams.CurrentLine:=SpectrPointNmb;
      DemoSpectrCnt:=SpectrPointNmb;
      NanoEdu.SpectroscopyMethod;
      if NanoEdu.Method.Launch<>0 then begin FreeAndNil(NanoEdu.Method); ReStoreStart; exit; end;
      Startbtn.Enabled:=true;
   end
   else
   begin
     with PageControl do
     begin
     for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
     ActivePage.HighLighted:=True;
     end;
     flgSpectrDone:=true;
(*     newpoints:=(NanoEdu.Method as TSpectroscopySFMTerra).getnpoints;
     flgLimitSpectr:=false;
     if SpectrParams.NPoints>newpoints then
      begin
       SpectrParams.NPoints:=newpoints;
       flgLimitSpectr:=true;
      end;
 *)
     flgLimitSpectr:=false;
     if SpectrParams.NPoints>SpectrParams.NewPoints then
      begin
       flgLimitSpectr:=true;
      end;
     ReStoreStart;
     BitBtnSaveClick(Self);
   end;
 end;
 //draw
 if mScanning=AMessage.WParam then
    begin
      NanoEdu.Method.ScanWorkDone;
      NanoEdu.Method.FreeBuffers;
      NanoEdu.Method.TurnOnFB;  
      if Assigned(scWorkThread) then FreeAndNil(scWorkThread);
      FreeAndNil(NanoEdu.Method);
    end;
end;


function TSpectroscopyTerra.CreateQuickReportComponent:boolean;
begin
   result:=true;
  if not Assigned(QuickRep) then
  begin
    result:=true;
    try
     QuickRep:=TQuickRep.Create(self);
    except
     begin
      MessageDlg(strs7{'Printer is not connected.  '},mtwarning,[mbYes],0);
      result:=false;
      exit;
     end;
    end
  end
  else
  begin
     FreeandNil(QuickRep);
    try
     QuickRep:=TQuickRep.Create(self);
    except
     begin
      MessageDlg(strs7{'Printer is not connected.  '},mtwarning,[mbYes],0);
      result:=false;
      exit;
     end;
    end
  end;
    QuickRep.Parent:=self;
    QuickRep.visible:=false;
    QRBand:=TQRBand.Create(QuickRep);;
    QRBand.parent:=QuickRep;
    QRImage:=TQRImage.Create(QRBand);;
    QRImage.parent:=QRBand;
    Application.Processmessages;
end;

procedure TSpectroscopyTerra.BitBtnPrintClick(Sender: TObject);
var Bitmap_Pic:TBitmap;
  Rect: TRect;
begin
 PrintBtn.Enabled:=false;
  if not  CreateQuickReportComponent then  exit;
  Bitmap_Pic := TBitmap.Create;
 try
      Bitmap_pic.Width :=ClientWidth;
      Bitmap_pic.Height :=ClientHeight;
      Main.CopyToClipBoardExecute(self);
      Bitmap_pic.LoadFromClipBoardFormat(cf_BitMap,ClipBoard.GetAsHandle(cf_Bitmap),0);
      QRImage.AutoSize:= false;
      QRImage.Stretch:= true;
      QRImage.Top:= 0;
      QRImage.Width:= (Bitmap_pic.Width div 4)*3;
      QRImage.Height:= (Bitmap_pic.Height div 4)*3;;
      QRImage.Left:=0;
      Rect:= Bounds(0,0,QRImage.Width,QRImage.Height);
      QRImage.Canvas.Pen.Style:= psClear;
      QRImage.Canvas.Brush.Color:= clWhite;
      QRImage.Canvas.Rectangle(Rect);
      QRImage.Picture.Assign(BitMap_pic);
      QuickRep.PreviewModal;
       PrintBtn.Enabled:=true;
  finally
      FreeAndNil(Bitmap_Pic);
  end;
end;

(*procedure TSpectroscopy.FrNPointsBitBtnFrmClick(Sender: TObject);
begin
  FrNPoints.BitBtnFrmClick(Sender);  var val:integer;
begin
   FrT.EditFrmChange(Sender);
  try
   val:=StrToInt(FrT.EditFrm.Text);
    if val<FrT.ScrollBarFrm.Min then
    begin
     val:=FrT.ScrollBarFrm.Min;
     FrT.EditFrm.Text:=inttostr(val);
    end;
    if val>FrT.ScrollBarFrm.Max then
    begin
     val:=FrT.ScrollBarFrm.Max;
     FrT.EditFrm.Text:=inttostr(val);
    end;
  NumbP:=StrToInt(FrNPoints.EditFrm.Text);
  ZStep:=(abs(StartPointZ)+EndPointZ)/NumbP;
  LabelStep.Caption:=siLangLinked1.GetTextOrDefault('IDS_47' 'Step = ' )FloatToStrF(ZStep,ffFixed,5,1)+ siLangLinked1.GetTextOrDefault('IDS_4'  'nm'  );
  if round(ZStep*TransformUnit.Znm_d)<1 then
  begin
    MessageDlg(siLangLinked1.GetTextOrDefault('IDS_46'  'Step too small!Change Parameters.'  ),mtWarning,[mbOk],0);
    NumbP:=round((abs(StartPointZ)+EndPointZ)/ZStepMin)+1;
    FrNPoints.EditFrm.Text:=inttostr(NumbP);
    exit;
  end;
end;
*)
procedure TSpectroscopyTerra.FrameParInput1EditFrmKeyPress(Sender: TObject;  var Key: Char);
begin
     if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TSpectroscopyTerra.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
var i,j:integer;
begin
    i:=PageControl.ActivePageIndex;
    if (ssCtrl in Shift) then
    begin
      if (Key=ord('V')) then
      begin
          FrSupLevel.Visible:= not FrSupLevel.Visible;
      end;
      if (Key=ord('E')) then
      begin
      for j:=0 to (NPage-1) do
       if assigned(ArChart[j]) then
       begin
        ArChart[j].AllowEditClick(sender)
       end;
      end;
      if Key=ord('A') then
      begin
   (*  if  not flgSurfaceData then
        begin
         ArChart[i].FiltrAverage;
         ArChart[i].SetFindLine_pos(0);
        end
        else
        if i<>0 then
         begin
             dec(i);
             ArChart[i].FiltrAverage;
             ArChart[i].SetFindLine_pos(0);
         end;
    *)
      end;
    end
    else
    if (ssAlt in Shift) then
     begin
       flgDragForm:=true;
     end
    else
      Case Key of
    vk_Prior: //Page Up
             begin
              if not flgSurfaceData{SetIntActOnProgr}  then
              begin
               ArChart[i].SetActiveSeriesNext;
              end
              else
              begin
               if i>=(PageControl.PageCount-Npage) then begin dec(i,PageControl.PageCount-Npage); ArChart[i].SetActiveSeriesNext;end;
              end;
             end;
    vk_Next: //Page Down
             begin
              if not flgSurfaceData {SetIntActOnProgr}  then
              begin
               ArChart[i].SetActiveSeriesPred;
              end
              else
              begin
               if i>=(PageControl.PageCount-Npage)  then begin dec(i,PageControl.PageCount-Npage); ArChart[i].SetActiveSeriesPred;end;
              end;
             end;
                          end;//Case Key of
end;

(*procedure TSpectroscopy.FrEndPointEditFrmChange(Sender: TObject);
begin
   FrEndPoint.EditFrmChange(Sender);
 if  (FrEndPoint.EditFrm.Text='')  or (FrEndPoint.EditFrm.Text='-') then exit;
  EndPointZ:=StrToInt(FrEndPoint.EditFrm.Text);
   ZStep:=(abs(StartPointZ)+EndPointZ)/NumbP;
   LabelStep.Caption:=siLangLinked1.GetTextOrDefault('IDS_47'  'Step = '  )+FloatToStrF(ZStep,ffFixed,5,1)+ siLangLinked1.GetTextOrDefault('IDS_4' 'nm'  );
   if ZStep<ZStepMin then
     begin
       MessageDlg(siLangLinked1.GetTextOrDefault('IDS_46'  'Step too small!Change Parameters.'  ),mtWarning,[mbOk],0);
    //   FrEndPoint.EditFrm.Text:=inttostr(round((abs(StartPointZ)+NumbP*ZStepMin)-1));
       exit;
     end;
end;
 *)
procedure TSpectroscopyTerra.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
    CanClose:=not flgProcess;
 //     bitbtn1.Perform(WM_Lbuttondown,0,0);
 //     bitbtn1.Perform(WM_LbuttonUp,0,0);
//      application.processmessages;
//  for i:=0 to Npage-1 do
//       FreeAndNil( ArChart[i].EditChartPopUpMenu);
         //:=false
end;




procedure TSpectroscopyTerra.FormCreate(Sender: TObject);
begin
  UpdateStrings;

end;

procedure TSpectroscopyTerra.Copytoclipboard1Click(Sender: TObject);
begin
  Main.CopytoClipBoardExecute(self);
end;

procedure TSpectroscopyTerra.PanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 (*      if (Button=mbLeft) and (ssAlt in Shift) then
            begin
             PageControl.BeginDrag(False);
             CopyClipboard;
             exit;
            end
   *)
end;

procedure TSpectroscopyTerra.Panel2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
(*           if (Button=mbLeft) and (ssAlt in Shift) then
            begin
             Panel4.BeginDrag(False);
             CopyClipboard;
            end
            *)
end;

procedure TSpectroscopyTerra.FrTEditFrmChange(Sender: TObject);
begin
  FrT.EditFrmChange(Sender);
  SpectrParams.T:=StrToInt(FrT.EditFrm.Text);
  SetCommonUserVar(ch_Spectr_T,SpectrParams.T);  //Spectr_T
end;

procedure TSpectroscopyTerra.FrStartPEditFrmKeyPress(Sender: TObject;  var Key: Char);
begin
    FrStartP.EditFrmKeyPress(Sender, Key);
    if not(Key in ['-','0'..'9',#8]) then Key :=#0 ;
end;

procedure TSpectroscopyTerra.FrEndPointEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  FrEndPoint.EditFrmKeyPress(Sender, Key);
  if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TSpectroscopyTerra.FrNPointsEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  FrNPoints.EditFrmKeyPress(Sender, Key);
   if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TSpectroscopyTerra.FrTEditFrmKeyPress(Sender: TObject; var Key: Char);
begin
  FrT.EditFrmKeyPress(Sender, Key);
   if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TSpectroscopyTerra.FrTScrollBarFrmScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  FrT.ScrollBarFrmScroll(Sender, ScrollCode, ScrollPos);
  SpectrParams.T:=StrToInt(FrT.EditFrm.Text);
if assigned(Nanoedu.Method) then NanoEdu.Method.SetUsersParams;
//               else  SetCommonUserVar(ch_Spectr_T,SpectrParams.T);  //aTDelay=$94;
end;

procedure TSpectroscopyTerra.FrSupLevelEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  FrSupLevel.EditFrmKeyPress(Sender, Key);
  if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;

procedure TSpectroscopyTerra.FrSupLevelEditFrmChange(Sender: TObject);
var val:integer;
begin
try
  FrSupLevel.EditFrmChange(Sender);
    val:=StrToInt(FrSupLevel.EditFrm.Text);
    if val<FrSupLevel.ScrollBarFrm.Min then
    begin
     val:=FrSupLevel.ScrollBarFrm.Min;
     FrSupLevel.EditFrm.Text:=inttostr(val);
    end;
    if val>FrSupLevel.ScrollBarFrm.Max then
    begin
     val:=FrSupLevel.ScrollBarFrm.Max;
     FrSupLevel.EditFrm.Text:=inttostr(val);
    end;
  except
    on EConvertError do
     begin MessageDlg(strs6{'error input'},mtWarning,[mbOk],0);end;
  end;
end;

procedure TSpectroscopyTerra.LblwarningDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar.Panels[0] then
  begin
    StatusBar.Canvas.Font.Color := clRed;
    StatusBar.Canvas.Font.Size:=-9;
//    StatusBar.Canvas.Font.Style.fsBold:=true;
    StatusBar.Canvas.TextOut(Rect.Left, Rect.Top,siLangLinked.GetTextOrDefault('IDS_9'{ 'Warning! The level of suppression of amplitude oscillation is achieved! '}))
  end
  else
  begin
    StatusBar.Canvas.Font.Color := clRed;
    StatusBar.Canvas.Font.Size:=-9;
//    StatusBar.Canvas.Font.Style:=fsBold;
    StatusBar.Canvas.TextOut(Rect.Left, Rect.Top, siLangLinked.GetTextOrDefault('IDS_5'{ 'Change Final Point'}));
  end;
end;

function  TSpectroscopyTerra.LoadDemoCurves(const FileName:string;  var Curves:TMas2):integer;
var
   Nx:integer;
  DemoExperimentCurve:TExperiment;
begin
   result:=0;
   if not FileExists(FileName) then
       begin
           ShowMessage(FileName+strs8{' File not exist'});
           result:=1;
           exit;
        end;
 DemoExperimentCurve:=TExperiment.Create;
try
 DemoExperimentCurve.imFileName:=FileName;
 DemoExperimentCurve.Readsurface(spectr);
 Nx:=(DemoExperimentCurve.MainRcd.NxSpec );
 SetLength(Curves,DemoExperimentCurve.MainRcd.NyPoint,Nx);
Curves:=DemoExperimentCurve.AquiSpectr.Data;
DemoSpectrNCurves:=DemoExperimentCurve.MainRcd.NyPoint;
DemoSpectrNPoints:=Nx;
DemoSpectrStep:=0.001*DemoExperimentCurve.FileHeadRcd.HSensZ*DemoExperimentCurve.FileHeadRcd.HAMP_GainZ*
         DemoExperimentCurve.FileHeadRcd.HDiscrZmvolt; //mvo
if not flgApproachOK then DemoSpectrNorm:=100
                     else DemoSpectrNorm:=DemoExperimentCurve.FileHeadRcd.HUAMMax;//}HStepXY;
with SpectrParams do
  begin
   StartPointLimit:=round(Curves[0,1]*DemoSpectrStep);
   FinalPointLimit:=round(Curves[0,(DemoSpectrNPoints div 2)+1] *DemoSpectrStep);
   SpectrParams.NPoints:=DemoSpectrNPoints div 4;
  end;
finally
 FreeAndNil(DemoExperimentCurve);
end;
end;

procedure TSpectroscopyTerra.FrStartPBitBtnFrmClick(Sender: TObject);
begin
  FrStartP.BitBtnFrmClick(Sender);
end;

procedure TSpectroscopyTerra.DrawPicture(const mas_stm_in: TMas2;mas_x,mas_y:integer; max_in,min_in: single; var BitMap:TBitMap);
var
  x,y: integer;
 // BitMap: TBitMap;
  koef: single;
    PointColor:integer;
   RGBCol:TColor;
begin
 try
    BitMap.Width:= max(mas_x-1, mas_y-1);
    BitMap.Height:=BitMap.Width;
    with Bitmap do
      begin
         Canvas.CopyMode:=cmWhiteness;     {Очистка картины}
         Canvas.CopyRect(Rect(0,0,Width,Height),Canvas,Rect(0,0,Width,Height));
      end;

  if (max_in<>min_in) then koef:= 255/(max_in-min_in)
                      else koef:= 0;
  for y:= 0 to (mas_y-1) do
  for x:= 0 to (mas_x-1) do
  begin
    PointColor:=round(koef*(mas_stm_in[x][y]-min_in))  ;
    if (PointColor >255) then PointColor:=255
                       else if (PointColor <0)   then PointColor:=0   ;
    RGBCol:= TCOlor($02000000 or (RPaletteKoef[PointColor])
                                    or (GPaletteKoef[PointColor] shl 8)
                                    or (BPaletteKoef[PointColor] shl 16) );
   BitMap.Canvas.Pixels[x,BitMap.Height-1-y]:=RGBCol;
  end;
  finally
  end;
end;{procedure DrawPicture;}

procedure TSpectroscopyTerra.DrawSpectrPoints(const Points:TLine; NPoints:integer;const Header:HeadParmType;  BitMap:TBitMap);
var i,k:integer;
    mx0,my0:integer;      //pixels
    sz:integer;
    OldBkMode:integer;
    maxpoints:integer;
    oldBrushclr:Tcolor;
    oldFontclr:Tcolor;
begin
    with Bitmap.Canvas do
     begin
      oldBrushclr:=Brush.Color;
      oldFontclr:=Font.Color;
       Brush.Color:=clRed;
       Font.Color := clBlue;
       maxpoints:=max(BitMap.Height,BitMap.width);
      if  maxpoints<200    then  begin sz:=1;   end
           else   if (maxpoints>=200) and (maxpoints<300) then begin  sz:=2; end
           else   if (maxpoints>=300) and (maxpoints<400) then begin  sz:=3; end
           else   if (maxpoints>400)  and (maxpoints<500) then begin  sz:=3; end
           else   if (maxpoints>=500) then begin  sz:=4; end;

       k:=0;
       OldBkMode := SetBkMode(Handle, TRANSPARENT);
       with Header do
        for   i:=0 to  NPoints-1 do
                  begin
                   mx0:=round((Points[k]/Header.HXnm_d-HXBegin)/HStepXY);
                   my0:=round((BitMap.Height-1-(Points[k+1]/Header.HYnm_d-HYBegin)/HStepXY));
                   inc(k,3);
                   FillRect(Rect(mx0-sz,my0-sz,mx0+sz,my0+sz));
                   TextOut(mx0+3,my0-13,IntToStr(i+1));
                  end;
       SetBkMode(Handle, OldBkMode);
       Brush.Color:=oldBrushclr;
       Font.Color:=oldFontclr;
      end;
end;
procedure TSpectroscopyTerra.TestStepSize;
begin
    LabelStep.Font.Color:=clBlack;
   if ZStep<ZStepMin then
     begin
      MessageDlg(strs2{'The step too small!'}+#13+strs3{'Change parameters to increase the step.'},mtWarning,[mbOk],0);
      LabelStep.Font.Color:=clRed;
     end;
end;

procedure TSpectroscopyTerra.UpdateStrings;
begin
  strstop := siLangLinked.GetTextOrDefault('strstrstop');
  strstart := siLangLinked.GetTextOrDefault('strstrstart');
  strs10 := siLangLinked.GetTextOrDefault('strstrs10');
  strs9 := siLangLinked.GetTextOrDefault('strstrs9');
  strs8 := siLangLinked.GetTextOrDefault('strstrs8');
  strs7 := siLangLinked.GetTextOrDefault('strstrs7');
  strs6 := siLangLinked.GetTextOrDefault('strstrs6');
  strs5 := siLangLinked.GetTextOrDefault('strstrs5');
  strs4 := siLangLinked.GetTextOrDefault('strstrs4');
  strs3 := siLangLinked.GetTextOrDefault('strstrs3');
  strs2 := siLangLinked.GetTextOrDefault('strstrs2');
  strs1 := siLangLinked.GetTextOrDefault('strstrs1');

end;

procedure TSpectroscopyTerra.FrFrmExit(Sender: TObject);
begin
   TestStepSize
end;
procedure TSpectroscopyTerra.PageControlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
(*    if (Button=mbLeft) and (ssAlt in Shift) then
            begin
             PageControl.BeginDrag(False);
             CopyClipboard;
            end
            *)
end;


procedure TSpectroscopyTerra.ApplicationEventsMessage(var Msg: tagMSG;  var Handled: Boolean);
begin
 if flgDragForm then
  if Msg.message=WM_LButtonDown then
   begin
   if  getkeystate(VK_Menu)<0 then
    begin
       PageControl.BeginDrag(true);
       Main.CopyToClipBoardExecute(self);
       handled:=true;
         flgDragForm:=false;
    end;
   end ;

end;

procedure TSpectroscopyTerra.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
    begin
      flgDragForm:=false;
    end
end;

procedure TSpectroscopyTerra.BitBtn1MouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:integer;
  begin
  close;
   i:=0;
   Application.processmessages;
end;

procedure TSpectroscopyTerra.BitBtnExitClick(Sender: TObject);
begin
 close
end;

end.





