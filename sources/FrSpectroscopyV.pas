unit FrSpectroscopyV;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frParInput, ExtCtrls, ComCtrls,TeEngine, Series, StdCtrls, Buttons, TeeProcs,Clipbrd,
  Chart, SpmChart, math,GlobalType,GlobalDCl,CSPMVar, QuickRpt, QRCtrls,
  AppEvnts, siComp, siLngLnk, Menus, ToolWin;

type  TList_Curves_in_Point=Tlist;

type
  TSpectroScopyV = class(TForm)
    StatusBar: TStatusBar;
    Panel1: TPanel;
    Panel3: TPanel;
    PanelMain: TPanel;
    PageControl: TPageControl;
    Panel5: TPanel;
    BitBtnSave: TBitBtn;
    BitBtnExit: TBitBtn;
    ControlPanel: TPanel;
    Panel6: TPanel;
    FrT: TFrameParInput;
    FrNPoints: TFrameParInput;
    FrStopV: TFrameParInput;
    FrStartV: TFrameParInput;
    frNGraph: TFrameParInput;
    Panel2: TPanel;
    LabelStep: TLabel;
    LabelStepMin: TLabel;
    PanelLeftUp: TPanel;
    ApplicationEvents: TApplicationEvents;
    siLangLinked: TsiLangLinked;
    MainMenu1: TMainMenu;
    MainMenu2: TMainMenu;
    Edit1: TMenuItem;
    Copytoclipboard1: TMenuItem;
    ToolBar1: TToolBar;
    StartBtn: TToolButton;
    ToolBar2: TToolBar;
    PrintBtn: TToolButton;
    ToolButton1: TToolButton;
    procedure Copytoclipboard1Click(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinkedChangeLanguage(Sender: TObject);
    procedure FrStopVBitBtnFrmClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure FrNPointsEditFrmChange(Sender: TObject);
    procedure FrNPointsEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure frNGraphEditFrmChange(Sender: TObject);
    procedure frNGraphEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
 //   procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure FrStartVEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrStartVEditFrmChange(Sender: TObject);
    procedure FrStopVEditFrmChange(Sender: TObject);
    procedure FrStopVEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrTEditFrmChange(Sender: TObject);
    procedure FrTEditFrmKeyPress(Sender: TObject; var Key: Char);
    procedure FrFrmExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure BitBtnExitClick(Sender: TObject);

 private
   FlgSurfaceData,
   flgProcess:Boolean;

   DBegin:Boolean;
   prevScanMethod:byte;
   Error:integer;
   DStepV,DStartV:smallint;
   NPoint,NAv:word;    //NAv Number points for average
   NCurves:integer; //Numbers Graph in Point
   NPage:integer;
   SpectrPointNmb:integer;
   SpectrPointNmb_Data:integer;
   PStartV,PStopV:apitype;
   T,TC:word;
   ActiveIndex:integer;
   PStepV:single;
   UStep:single;
   Max_Y,Min_Y: single;
   FindLine_Pos:single;
   BottAxMin,BottAxMax:single;
   BaseCaptionStep,  BaseCaptionStepMin,
   BaseCaption,
   AddCaption:string;
   SeriesColor:array of TColor;
   ArTabSheet:array of TTabSheet;

// ArSeries:array of array of TLineSeries;
   ArCurves_in_Point:array of TList_Curves_in_Point;
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
   procedure WMNCLButton(var Message: TMessage); message WM_NCLButtonDown;
   function  CreateQuickReportComponent:boolean;
   procedure TestStepSize;
   procedure SpectrImgCreate(var TabSheetSpectr:TTabSheet;var TabSpectrPanel:TPanel;var IMageSpectr:TImage;const ImageCaption:string);
   procedure ScanImageDraw(TabSheetSpectr:TTabSheet;TabSpectrPanel:TPanel;var ImageSpectr:TImage;BitMap:TBitMap;  nx,ny:integer);
   procedure CopyMe(tobmp: TBitmap; frbmp : TGraphic);
   procedure SpectrGraphCreate;
   function  LoadDemoCurvesparams(const FileName:string;  var Curves:TMas2):integer;
   function  FindYValue(ActiveSeries:TlineSeries;X:single; var Y:single):Boolean;
   procedure RestoreStart;
 protected
   procedure ChartMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
   procedure DrawGraphics(i:integer; UData:array of ApiType; const StepU,StepValue:single);
   procedure DrawPicture(const mas_stm_in: TMas2;mas_x,mas_y:integer; max_in,min_in: single; var BitMap:TBitMap);
   procedure DrawSpectrPoints(Points:TLine; NPoints:integer;const Header:HeadParmType; var BitMap:TBitMap);
   procedure CopyClipboardMes(var AMessage : TMessage); message WM_CopyClipboardMsg;
 public
    { Public declarations }
    flgSpectrDone:boolean;
    UStepMin:single;
    IStepMin:single;
    lFileName:string;
     ArChart:array of TChartSpectrographiV;
    constructor Create(AOwner:TComponent);                           overload;
    constructor Create(AOwner:TComponent;const FileName:string);     overload;
 end;
var
   SpectrWndV: TSpectroscopyV;
implementation

uses  GlobalVar, GlobalFunction,frScanWnd, UNanoEduBaseClasses,uNanoEduScanClasses,nanoeduhelp, frReport,
      mMain,frSPM_Browser,frProgressMoveto,SpectrSTMDrawThread, frapproachnew;
{$R *.DFM}
 const
	strsv0: string = ''; (* Step too small! *)
	strsv2: string = ''; (* Change Parameters. *)
	strsv3: string = ''; (* Wrong parameters! *)
	strsv4: string = ''; (* error input *)
	strsv5: string = ''; (*  File not exist *)
	strsv6: string = ''; (* The step too small!Change parameters to increase the step. *)


var    FlgOnePointSpectr:boolean;// true spectroscopy i one point(N curve); false in N -point

constructor   TSpectroscopyV.Create(AOwner:TComponent);
var i,j,NCurvesMax:integer;
    FileName,TabImgCaption:string;
begin
 inherited Create(AOwner);
 siLangLinked.ActiveLanguage:=Lang;
 frStartV.siLangLinked1.ActiveLanguage:=Lang;
 frStopV.siLangLinked1.ActiveLanguage:=Lang;
 frNPoints.siLangLinked1.ActiveLanguage:=Lang;
 frNGraph.siLangLinked1.ActiveLanguage:=Lang;
 frT.siLangLinked1.ActiveLanguage:=Lang;
 Updatestrings;

    FrT.Enabled:=True;
    FrNPoints.Enabled:=True;
    FrStopV.Enabled:=True;
    FrStartV.Enabled:=True;

    if FlgCurrentUserLevel = Demo then
       begin
         FrT.Enabled:=False;
         FrNPoints.Enabled:=False;
         FrStopV.Enabled:=False;
         FrStartV.Enabled:=False;
       end;

 flgSpectrDone:=false;
 Top:=TopStart;
 left:=(main.Clientwidth-Clientwidth) div 2;
 BaseCaptionStep:=siLangLinked.GetTextOrDefault('IDS_0' (* 'Step=' *) ) ;      BaseCaptionStepMin:=siLangLinked.GetTextOrDefault('IDS_1' (* 'Step Min=' *) ) ;
 prevScanMethod:=ScanParams.ScanMethod;
 if assigned(ScanWnd) then Scanwnd.StartBtn.Enabled:=false;
 BaseCaption:=siLangLinked.GetTextOrDefault('IDS_2' (* 'Spectroscopy' *) );
 Caption:=BaseCaption;
 BitBtnSave.Enabled:=false;
// StartBtn.Glyph.Assign(BitMapStart);
 FindLine_Pos:=0;
 NAv:=SpectrParams.NAv; //3;                 //points for Average
 T:=SpectrParams.T;
 TC:=ApproachParams.ScannerDecay;
 NPoint:=SpectrParams.NPoints;                         //line points
 NCurves:=SpectrParams.NCurves;                        //graphic in the spectr point
 NPage:=SpectrParams.NSpectrPoints;//ArPntSpector.Count;    // spectr points
 NCurvesMax:=10;
 SetLength(SeriesColor,NCurvesMax);
 seriesColor[0]:=clblue;
 seriesColor[1]:=clred;
 seriesColor[2]:=clnavy;
 seriesColor[3]:=clmaroon;
 seriesColor[4]:=clgray;
 seriesColor[5]:=clteal;
 seriesColor[6]:=clyellow;
 seriesColor[7]:=clblack;
 seriesColor[8]:=clpurple;
 seriesColor[9]:=clolive;

 IStepMin:=1/TransformUnit.nA_d;
 UStepMin:=1/TransformUnit.BiasV_d*1000;    //UV 220113

 if FlgCurrentUserLevel<> Demo then
   begin
      SpectrParams.StartPointLimit:=-5000;
      SpectrParams.FinalPointLimit:=5000;
   end
   else
   begin
     FileName:=DemoDataDirectory+DemoSample+'\'+DemoSpectrSTMIVFile;
     Error:=LoadDemoCurvesparams(FileName,DemoSpectrCurves);
     if Error<>0 then
       begin
        SpectrParams.StartPointLimit:=-5000;
        SpectrParams.FinalPointLimit:=5000;
       end;
   end;
  with   FrT   do              //delay
   begin
    ScrollBarFrm.Max:=5000;
    ScrollBarFrm.Min:=1000;
    ScrollBarFrm.Position:=3000;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:=siLangLinked.GetTextOrDefault('IDS_3' (* 'ms' *) );
   end;
  with   FrStartV   do
   begin
    ScrollBarFrm.Max:=SpectrParams.FinalPointLimit;
    ScrollBarFrm.Min:=SpectrParams.StartPointLimit;
    ScrollBarFrm.Position:=SpectrParams.StartV;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:=siLangLinked.GetTextOrDefault('IDS_4' (* 'mV' *) );
   end;
  with FrStopV do
   begin
    ScrollBarFrm.Max:=SpectrParams.FinalPointLimit;
    ScrollBarFrm.Position:=SpectrParams.StopV;
    ScrollBarFrm.Min:=SpectrParams.StartPointLimit;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:=siLangLinked.GetTextOrDefault('IDS_4' (* 'mV' *) );
   end;
  with FrNPoints do
  begin
   ScrollBarFrm.Max:=300;
   ScrollBarFrm.Min:= 2;
   ScrollBarFrm.Position:=SpectrParams.Npoints;
   EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
   LabelUnit.Caption:='';
  end;
  with FrNGraph do
  begin
   ScrollBarFrm.Max:=10;
   ScrollBarFrm.Min:= 1;
   ScrollBarFrm.SmallChange:=1;
   ScrollBarFrm.Position:=SpectrParams.NCurves;
   EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
   LabelUnit.Caption:='';
  end;
   Ustep:=(-PStartV+PStopV)/NPoint;
   LabelStep.Caption:=BaseCaptionStep+FloatToStrF(UStep,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_4' (* 'mV' *) );
   LabelStepMin.Caption:=BaseCaptionStepMin+FloatToStrF(UStepMin,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_4' (* 'mV' *) );

        case  ScanData.FileHeadRcd.HAquiADD of
  TopoGraphy:    TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_8' (* 'Topography/Top View' *) );
    Current:     TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_11' (* 'Current Image' *) );
             end;

   SpectrImgCreate(TabSheetTopo,TabTopoPanel,ImageTopo, siLangLinked.GetTextOrDefault('IDS_8' (* 'Topography/Top View' *) ));
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
  SpectrGraphCreate;
 if assigned(ScanWnd) then ScanWnd.WindowState:=wsMinimized;
end;

constructor TSpectroscopyV.Create(AOwner:TComponent;const  FileName:string);
 var
  j,i,k, Nx,
  currentpointband,
  NCurvesMax:integer;
  DemoExperiment:TExperiment;
  ImgBitMap:TBitMap;
  TabImgCaption:string;
  ArCurvesSaved_in_Point:array of TList_Curves_in_Point;
begin
 inherited Create(AOwner);
   if sLanguage='RUS' then
      begin
       siLangLinked.ActiveLanguage:=2;
       frStartV.siLangLinked1.ActiveLanguage:=2;
       frStopV.siLangLinked1.ActiveLanguage:=2;
       frNPoints.siLangLinked1.ActiveLanguage:=2;
       frT.siLangLinked1.ActiveLanguage:=2;
      end
   else
    begin
       siLangLinked.ActiveLanguage:=1;
       frstartV.siLangLinked1.ActiveLanguage:=1;
       frStopV.siLangLinked1.ActiveLanguage:=1;
       frNPoints.siLangLinked1.ActiveLanguage:=1;
       frT.siLangLinked1.ActiveLanguage:=1;
    end;
  BaseCaptionStep:=siLangLinked.GetTextOrDefault('IDS_0' (* 'Step=' *) ) ;
  lfilename:=filename;
  ControlPanel.Visible:=False;
  BitBtnSave.Visible:=false;
  FormStyle:=fsMDIChild;
  baseCaption:=siLangLinked.GetTextOrDefault('IDS_13' (* 'Spectroscopy I-V' *) );
  addCaption:=ExtractFileName(FileName);
  Caption:=baseCaption+' '+addCaption;
 Top:=TopStart;
 left:=LeftStart;

  NCurvesMax:=10;
  SetLength(SeriesColor,NCurvesMax);
 seriesColor[0]:=clblue;
 seriesColor[1]:=clred;
 seriesColor[2]:=clnavy;
 seriesColor[3]:=clmaroon;
 seriesColor[4]:=clgray;
 seriesColor[5]:=clteal;
 seriesColor[6]:=clyellow;
 seriesColor[7]:=clblack;
 seriesColor[8]:=clpurple;
 seriesColor[9]:=clolive;
 
  DemoExperiment:=TExperiment.Create;
try
  DemoExperiment.imFileName:=FileName;
  DemoExperiment.Readsurface(spectr);
  NPage:=DemoExperiment.MainRcd.NyPoint;
  NCurves:=DemoExperiment.AquiSpectrPoint[2];
  SetLength(ArCurvesSaved_in_Point,NPage);    { TODO : 040906 }
    FlgSurfaceData:=True;
  if DemoExperiment.MainRcd.NxTop<=0 then   FlgSurfaceData:=False;
  if FlgSurfaceData then
   begin
        case  DemoExperiment.FileHeadRcd.HAquiADD of
  TopoGraphy:    TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_8' (* 'Topography/Top View' *) );
    Current:     TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_11' (* 'Current Image' *) );
             end;
    try
     ImgBitMap:=TBitMap.Create;
     SpectrImgCreate(TabSheetTopo,TabTopoPanel,ImageTopo,siLangLinked.GetTextOrDefault('IDS_8' (* 'Topography/Top View' *) ));
     with  DemoExperiment do
     begin
      Readsurface(Topography);
      DrawPicture(AquiTopo.data,FileHeadRcd.HNxTopo,FileHeadRcd.HNyTopo, AquiTopo.DataMax,AquiTopo.DataMin,ImgBitMap);
      DrawSpectrPoints(AquiSpectrPoint,MainRcd.NyPoint,FileHeadRcd, ImgBitMap);
      ScanImageDraw(TabSheetTopo,TabTopoPanel,ImageTopo,ImgBitMap,FileHeadRcd.HNxTopo,FileHeadRcd.HNyTopo );
     if FileHeadRcd.HAquiADD >0 then
      begin
       SpectrImgCreate(TabSheetAdd,TabAddPanel,ImageAdd,TabImgCaption);
       Readsurface( FileHeadRcd.HAquiADD);
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
  IStepMin:=1/DemoExperiment.FileHeadRcd.HnA_d;
  UStepMin:=1/DemoExperiment.FileHeadRcd.HBiasV_d*1000;
   currentpointband:=0;
   i:=0;  k:=0;
   for k:=0 to NPage-1 do
    begin
      NCurves:=DemoExperiment.AquiSpectrPoint[i+2];
      ArCurvesSaved_in_Point[k]:=TList_Curves_in_Point.Create;
      ArChart[k].SetActiveSeries(ArChart[k].HeadSeriesList.Series);
      for j:=0 to NCurves-1 do
      begin
        DrawGraphics(k,DemoExperiment.AquiSpectr.Data[j+currentpointband],UStepMin,IStepMin);
        ArCurvesSaved_in_Point[k].add(DemoExperiment.AquiSpectr.Data[j+currentpointband]);
        ArChart[k].SetActiveSeriesNext;
      end;
       inc(i,3);
       currentpointband:=currentpointband+NCurves;
    end;
  Ustep:=(-PStartV+PStopV)/NPoint;
  LabelStep.Caption:=BaseCaptionStep+FloatToStrF(UStep,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_4' (* 'mV' *) );
  LabelStepMin.Caption:=BaseCaptionStepMin+FloatToStrF(UStepMin,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_4' (* 'mV' *) );
 finally
  FreeAndNil(DemoExperiment);
  for i:=0 to  NPage-1 do
   begin  ArCurvesSaved_in_Point[i].Clear; FreeAndNil(ArCurvesSaved_in_Point[i]); end;
   Finalize(ArCurvesSaved_in_Point);
 end;
   flgSpectrDone:=true;
end;

procedure TSpectroScopyV.frNGraphEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  try
     if not(Key in ['0'..'9',#8]) then Key :='1' ;
  except
  on EConvertError do
    begin   FrNGraph.EditFrm.text:='1'end;
  end;
end;

procedure TSpectroscopyV.ScanImageDraw(TabSheetSpectr:TTabSheet;TabSpectrPanel:TPanel;var ImageSpectr:TImage;BitMap:TBitMap;  nx,ny:integer);
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

procedure TSpectroScopyV.siLangLinkedChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TSpectroscopyV.CopyMe(tobmp: TBitmap; frbmp : TGraphic);
begin
  tobmp.Width := frbmp.Width;
  tobmp.Height := frbmp.Height;
  tobmp.PixelFormat := pf24bit;
  tobmp.Canvas.Draw(0,0,frbmp);
end;


procedure TSpectroscopyV.SpectrImgCreate(var TabSheetSpectr:TTabSheet;var TabSpectrPanel:TPanel;var IMageSpectr:TImage;const ImageCaption:string);
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
  //    IMageSpectr.OnMouseDown:=SpectrImgMouseDown;
 //     TabSpectrPanel.OnMouseDown:=SpectrImgMouseDown;
 end;


procedure TSpectroscopyV.SpectrGraphCreate;
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
      ArTabSheet[i].Caption:=siLangLinked.GetTextOrDefault('IDS_20' (* 'Point= ' *) )+IntToStr(i+1);
      ArChart[i]:=TChartSpectrographiV.Create(Tcomponent(ArTabSheet[i]));
      ArChart[i].Align:=alClient;
      ArChart[i].AllowEditChartMenu.Checked:=false;
      ArChart[i].Chart.View3d:=False;
      ArChart[i].Chart.Align:=alClient;
      ArChart[i].Chart.Color:=clWhite;
      ArChart[i].Chart.Legend.Visible:=False;
      ArChart[i].Chart.LeftAxis.LabelsSize:=30;
      ArChart[i].Chart.LeftAxis.Automatic:=True;
      ArChart[i].Chart.LeftAxis.Title.Angle:=0;
      ArChart[i].Chart.LeftAxis.Title.Caption:=siLangLinked.GetTextOrDefault('IDS_21' (* 'nA' *) );
      ArChart[i].Chart.BottomAxis.Title.Angle:=0;
      ArChart[i].Chart.BottomAxis.Title.Caption:=siLangLinked.GetTextOrDefault('IDS_4' (* 'mV' *) );
      ArChart[i].Chart.ShowHint:=true;
      ArChart[i].Chart.hint:=siLangLinked.GetTextOrDefault('IDS_23' (* 'Click Left Button to set label; Click Right Button to show popup menu' *) );
      ArChart[i].flgFilter:=false;
       { TODO : 290507 }
     if  not ArChart[i].AllowEditChartMenu.Checked then ArChart[i].AllowEditClick(self);
       with ArChart[i].Chart.Title.Text do
        begin
	       Clear;
         Add(siLangLinked.GetTextOrDefault('IDS_24' (* 'Spectroscopy Curve STM' *) ));
        end;
        ArChart[i].EditFindLineChartPopUpMenu.Visible:=false;
        ArChart[i].EditFindLineChartMenu.Visible:=false;

      for j:=0 to (NCurves-1) do
       begin
           ArChart[i].AddSeries(seriescolor[j]);
      end;
   end;
end;

procedure TSpectroScopyV.frNGraphEditFrmChange(Sender: TObject);
var
   val:integer;
begin
 if FrNGraph.EditFrm.Text<>'' then
  begin
   try
    val:=StrToInt(FrNGraph.EditFrm.Text);
    if val<FrNGraph.ScrollBarFrm.Min then
    begin
     val:=FrNGraph.ScrollBarFrm.Min;
     FrNGraph.EditFrm.Text:=inttostr(val);
    end;
    if val>FrNGraph.ScrollBarFrm.Max then
    begin
     val:=FrNGraph.ScrollBarFrm.Max;
     FrNGraph.EditFrm.Text:=inttostr(val);
    end;
    NCurves:=StrToInt(FrNGraph.EditFrm.Text);
    FrNGraph.ScrollBarFrm.Position:=NCurves;
  except
    on EConvertError do
    begin   FrNGraph.EditFrm.text:='1'end;
   end;
  end;
end;

procedure TSpectroscopyV.StartBtnClick(Sender: TObject);
var i,j,k,currentpointband,index,error:integer;
    x0nm,y0nm:double;
begin
if LabelStep.Font.Color=clRed then
begin
  siLangLinked.MessageDlg(strsv0{'Step too small!'}+#13+strsv2{'Change Parameters.'},mtError,[mbOk],0);
  exit;
end;
 try
    BitBtnSave.Enabled:=false;
    BitBtnExit.Enabled:=false;
    T:=StrToInt(FrT.EditFrm.Text);
  try
    PStartV:=StrToInt(FrStartV.EditFrm.Text);    //nm
  except
    on EConvertError do
   begin
    siLangLinked.MessageDlg(strsv3{'Wrong parameters!'}+#13+strsv2{'Change Parameters.'},mtError,[mbOk],0);
    exit;
   end;
  end;
   try
    PStopV:=StrToInt(FrStopV.EditFrm.Text);
   except
    on EConvertError do
   begin
    siLangLinked.MessageDlg(strsv3{'Wrong parameters!'}+#13+strsv2{'Change Parameters.'},mtError,[mbOk],0);
    exit;
   end;
  end;
  try
   NPoint:=StrToInt(FrNPoints.EditFrm.Text);
     except
    on EConvertError do
   begin
    siLangLinked.MessageDlg(strsv3{'Wrong parameters!'}+#13+strsv2{'Change Parameters.'},mtError,[mbOk],0);
    exit;
   end;
  end;
   try
    NCurves:=StrToInt(FrNGraph.EditFrm.Text);
    except
    on EConvertError do
    begin
     siLangLinked.MessageDlg(strsv3{'Wrong parameters!'}+#13+strsv2{'Change Parameters.'},mtError,[mbOk],0);
     exit;
    end;
   end;
    FlgSurfaceData:=True;
    NPage:=ArPntSpector.Count;
    StartBtn.Enabled:=False;
    flgProcess:=true;
    SpectrPointNmb:=0;
    SpectrPointNmb_Data:=0;
    SpectrParams.StartV:=PStartV;    //nm
    SpectrParams.StopV:=PStopV;       //nm
    SpectrParams.NPoints:=NPoint;      //points in line
    SpectrParams.NSpectrPoints:=NPage;//number of points of the spectroscopy
    SpectrParams.NCurves:=NCurves;    //in the one points
    SpectrParams.T:=T;     
    SpectrParams.NAv:=NAv;
    inc(countStart);
    WorkNameFile:=workdirectory+'\'+WorkNameFileMaskCur+ScandataWorkFileNameEm(CountStart)+WorkExtFile;
    FlgOnePointSpectr:= (ArPntSpector.Count=1);
    PStepV:=(PStopV-PStartV)/(SpectrParams.NPoints);
    DStepV:=round(0.001*PStepV*TransformUnit.BiasV_d);       //220113
    DStartV:=round(0.001*PStartV*TransformUnit.BiasV_d);     //220113
    SpectrParams.Step:=PStepV;
//    StartBtn.Font.Color:=clRed;
    ScanData.AquiSpectr.Data:=nil;   // 2*(UAM,Z)*Npoints
    ScanData.AquiSpectrPoint:=nil;
 //   ArCurves_in_Point:=nil;
 //   SetLength(ArCurves_in_Point,NPage);    { TODO : 040906 }
    SetLength(ScanData.AquiSpectr.Data,SpectrParams.NSpectrPoints*SpectrParams.NCurves,2*SpectrParams.NPoints);   //23.11.01   x->y
    SetLength(ScanData.AquiSpectrPoint,3*SpectrParams.NSpectrPoints);

   for i:=0 to (NPage-1) do ArChart[i].DeleteAllSeries;
   for i:=0 to (NPage-1) do
    for j:=0 to (NCurves-1) do
       begin
           ArChart[i].AddSeries(SeriesColor[j])
       end;
      j:=0;
      currentpointband:=0;
//      for i:=0 to NPage-1 do
      i:=0;
//      begin
  //     ArCurves_in_Point[i]:=TList_Curves_in_Point.Create;
       ArChart[i].parent:=ArTabSheet[i];
       PntSpector:=ArPntSpector.items[i];
       SeriesColor[i]:=clBlue;
       ArChart[i].Chart.BottomAxis.SetMinMax(SpectrParams.StartV,SpectrParams.StopV);
       x0nm:=PntSpector^.point.x;
       y0nm:=PntSpector^.point.y;
       ScanData.AquiSpectrPoint[j]  :=-round((x0nm+Scanparams.xshift)*TransformUnit.xPnm_d)+CSPMSignals[8].MaxDiscr;;    //discrets
       ScanData.AquiSpectrPoint[j+1]:=-round((y0nm+Scanparams.yshift)*TransformUnit.yPnm_d)+CSPMSignals[9].MaxDiscr;;
       ScanData.AquiSpectrPoint[j+2]:=NCurves;
       inc(j,3);

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
       PageControl.ActivePage.HighLighted:=False;
       Index:=i+1;
       PageControl.ActivePageIndex:=Index;
       PageControl.ActivePage.HighLighted:=True;
       SpectrParams.CurrentLine:=i;       //current point I-V
       NanoEdu.SpectroscopyMethod;
     if NanoEdu.Method.Launch<>0 then
      begin FreeAndNil(NanoEdu.Method); ReStoreStart; exit; end;
(*      NanoEdu.SpectroscopyMethod;
       ArChart[i].SetActiveSeries(ArChart[i].HeadSeriesList.Series);
     for k:=0 to NCurves-1  do
      begin
       SpectrParams.CurrentLine:=currentpointband+k;
       if NanoEdu.Method.Launch<>0 then begin FreeAndNil(NanoEdu.Method); ReStoreStart; exit; end;
       DrawGraphics(i,(Nanoedu.Method as TSpectroscopySTM).U,UStepMin,IStepMin);
       ArCurves_in_Point[i].add(ScanData.AquiSpectr.Data[SpectrParams.CurrentLine]);
       ArChart[i].SetActiveSeriesNext;
       Application.ProcessMessages;
      end;
      if ArChart[i].flgFilter then
      begin
        ArChart[i].FiltrAverage;
        ArChart[i].SetFindLine_pos(0);
      end;
      flgSpectrDone:=true;
   { TODO : 290507 }
  //     ArChart[i].AllowEditClick(self);
        Application.ProcessMessages;
        FreeAndNil(NanoEdu.Method);
        inc(currentpointband,NCurves);
   end;  //i   { TODO : 071007 }//move to x0,y0

   while assigned(nanoedu.method) do Application.ProcessMessages;    //wait for  end scanning
  NanoEdu.ScanMoveToX0Y0Method(ScanParams.Xbegin,ScanParams.Ybegin);
  NanoEdu.Method.Launch;
  while assigned(ProgressMoveTo) do application.processmessages;
  // FreeAndNil(NanoEdu.Method);
  BitBtnSaveClick(Sender);
 with PageControl do
  begin
    for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
   Activepage:= ArTabSheet[0];
   ActivePage.HighLighted:=True;
  end;  RestoreStart;
  BitBtnSave.Enabled:=false;
*)
  except
   on EConvertError do
    begin end;

  end;
end;

procedure TSpectroscopyV.RestoreStart;
begin
  StartBtn.Down:=false;
 StartBtn.Enabled:=true;
 BitBtnExit.Enabled:=true;
// StartBtn.Font.Color:=clBlack;
 flgProcess:=false;
end;

procedure TSpectroscopyV.DrawGraphics(i:integer; UData:array of ApiType; const StepU,StepValue:single);
var
    nu,k,ii,j0:integer;
   umstart,umstop,V:Single;
    IU:ApiType;
begin
  nu:=length(UData);
  umstart:=(UData[0]*UStepMin);
  umstop:=(UData[nu-2]*UStepMin);
  nu:=nu div 2;
  ArChart[i].Chart.BottomAxis.SetMinMax(umstart,umstop);
  ArChart[i].Chart.LeftAxis.Automatic:=True;
     j0:=4;     //must be even value
      ii:=j0;
    for k:=j0 to ((nu-1)) do
       begin
         V:=UData[ii]*UStepMin;
         IU:=UData[ii+1];
          ArChart[i].ActiveSeries.AddXY(V, ITCor*IU*IStepMin,'',ClTeeColor);
         inc(ii,2);
       end;
end;

procedure TSpectroscopyV.DrawPicture(const mas_stm_in: TMas2;mas_x,mas_y:integer; max_in,min_in: single; var BitMap:TBitMap);
var
  x,y: integer;
 // BitMap: TBitMap;
  koef: single;
    PointColor:integer;
   RGBCol:TColor;
begin
// BitMap:=TBitMap.Create;
 try
 //   BitMap.Width:= mas_x-1;
 //  BitMap.Height:= mas_y-1;
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
   BitMap.Canvas.Pixels[x,{mas_y}BitMap.Height-1-y]:=RGBCol;{Round(koef*(mas_stm_in[x][y]-min_in))*$00010101;}
  end;
//  ScanImageDraw1(BitMap,mas_x,mas_y );
//  ImageSpectr.Picture.BitMap.Assign(BitMap);
  finally
 //  FreeAndNil(BitMap);
  end;
end;{procedure DrawPicture;}

procedure TSpectroscopyV.CopyClipboardMes(var AMessage : TMessage);
begin
 Main.CopyToClipBoardExecute(self);
end;

procedure TSpectroscopyV.DrawSpectrPoints(Points:TLine; NPoints:integer;const Header:HeadParmType; var BitMap:TBitMap);
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

procedure TSpectroscopyV.FormClose(Sender: TObject;var Action: TCloseAction);
var i:integer;
begin
   if assigned(ArCurves_in_Point) then
    for i:=NPage-1 downto  0 do
     begin  ArCurves_in_Point[i].Clear; FreeAndNil(ArCurves_in_Point[i]); end;
    ArCurves_in_Point:=nil;
    for i:=0 to (NPage-1) do
    begin
      ArChart[i].Destroy;
      ArChart[i]:=nil;
      ArTabSheet[i].Destroy;
      ArTabSheet[i]:=nil;
    end;
    Finalize(ArChart);
    Finalize(ArTabSheet);
   if (ArFrmGl.count=0)then
   begin
    Main.FileInfItem.Enabled:=False;
 //   Main.PrintItem.Enabled:=False;
    Main.ActionPrint.Enabled:=false;
    Main.FileInfItem.Enabled:=false;
//    Main.ActionExport.enabled:=false;
    Main.ActionImageTools.Visible:=false;
   end;
   if (ArFrmSpectr.count=0) and (ArFrmGl.count=0) then
   begin
    Main.ArrangeWindows1.Enabled:=False;
 //   Main.ActionSaveAs.Enabled:=false;
//    Main.PrintItem.Enabled:=False;
    Main.ActionPrint.Enabled:=true;
   end;
if assigned(QRImage)  then FreeAndNil(QRImage);
if assigned(QRBand)   then FreeAndNil(QRBand);
if assigned(QuickRep) then FreeAndNil(QuickRep);
if ControlPanel.Visible then
begin
  if assigned(ScanWnd) then
   begin
    Scanwnd.RestoreStartSFM;   { TODO : 160906 }
   end;
    ScanParams.ScanMethod:=prevScanMethod; { TODO : 040906 } // -1
     Finalize(DemoSpectrCurves);
  if assigned(ScanWnd) then  ScanWnd.WindowState:=wsNormal;
end
else   ArFrmSpectr.Remove(self);
  Action:=caFree;
 if self=SpectrWndV then SpectrWndV:=nil;
end;

procedure TSpectroscopyV.BitBtnCancelClick(Sender: TObject);
begin
     Close;
end;

procedure TSpectroscopyV.FrNPointsEditFrmChange(Sender: TObject);
 var NumbP,val:integer;
begin
try
  val:=StrToInt(FrNPoints.EditFrm.Text);
  if val<FrNPoints.ScrollBarFrm.Min then
    begin
     val:=FrNPoints.ScrollBarFrm.Min;
     FrNPoints.EditFrm.Text:=inttostr(val);
    end;
  if val>FrNPoints.ScrollBarFrm.Max then
    begin
     val:=FrNPoints.ScrollBarFrm.Max;
     FrNPoints.EditFrm.Text:=inttostr(val);
    end;
    UStep:=(-PStartV+PStopV)/val;
    LabelStep.Caption:=BaseCaptionStep+FloatToStrF(UStep,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_35' (* ' mV' *) );
     LabelStep.Font.Color:=clBlack;
   if abs(UStep)<abs(UStepMin) then
     begin
 //     MessageDlg('The step too small!Change parameters to increase the step.',mtWarning,[mbOk],0);
      LabelStep.Font.Color:=clRed;
     end;
    FrNPoints.ScrollBarFrm.Position:=val;
  except
    on EConvertError do
     begin siLangLinked.MessageDlg(strsv4{'error input'},mtWarning,[mbOk],0);FrNpoints.editFrm.text:=siLangLinked.GetTextOrDefault('IDS_37' (* '100' *) );end;
  end;
end;

procedure TSpectroscopyV.FrNPointsEditFrmKeyPress(Sender: TObject;  var Key: Char);
begin
    if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;


procedure TSpectroscopyV.BitBtnSaveClick(Sender: TObject);
var I:integer;
    ww:TForm;
begin
  ScanData.workfilename:=worknamefile;
  ScanData.HeaderPrepare;
  ScanData.SaveSpectr;
  addCaption:=ExtractFileName(worknamefile);
  lfilename:=worknamefile;
  Caption:=BaseCaption+' '+addCaption;
  if assigned(DirView)      then   DirView.ReDraw;
  if assigned(WorkView) and  WorkView.visible then
  begin
        WorkView.Redraw;
        Application.processmessages;
        WorkView.ActivateIcon(WorkNameFile);
  end;
end;

procedure TSpectroscopyV.PageControlChange(Sender: TObject);
var i:integer;
begin
  inherited;
  with PageControl do
  begin
   ActiveIndex:=ActivePageIndex;
   for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
   ActivePage.HighLighted:=True;
  end;
 if ActiveIndex>=PageControl.PageCount-Npage then
  begin
    ArChart[ActiveIndex-(PageControl.PageCount-Npage)].RePaint;
  end;
end;

function  TSpectroscopyV.LoadDemoCurvesparams(const FileName:string;  var Curves:TMas2):integer;
var
   Nx:integer;
  DemoExperimentCurve:TExperiment;
   lIStepMin, lUStepMin:single;
begin
   result:=0;
   if not FileExists(FileName) then
       begin
           siLangLinked.ShowMessage(FileName+strsv5{' File not exist'});
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
DemoSpectrNPoints:=Nx;                       // полное колич. точек (U +I)
 lIStepMin:=1/DemoExperimentCurve.FileHeadRcd.HnA_d;
 lUStepMin:=1/DemoExperimentCurve.FileHeadRcd.HBiasV_d*1000;
with SpectrParams do
  begin
   StartPointLimit:=round(Curves[0,0]*lUStepMin);
   //FinalPointLimit:=round(Curves[0,(Nx div 2)+1] *lUStepMin);
   FinalPointLimit:=round(Curves[0,Nx-2] *lUStepMin);
      //NPoints:=DemoExperiment.AquiSpectr.Nx;
  end;
finally
 FreeAndNil(DemoExperimentCurve);
end;
end;

function TSpectroscopyV.FindYValue(ActiveSeries:TLineSeries;X:single; var Y:single):Boolean;
var  j:integer;
     x0,x1:double;
begin
    Result:=False;
  for j:=0 to ActiveSeries.Count-2 do
   begin
      x0:=ActiveSeries.XValues[j];
      x1:=ActiveSeries.XValues[j+1];
    if (X>=x0) and (X<=x1)then
     begin
       Y:=ActiveSeries.YValues[j]+
       (x-x0)*(ActiveSeries.YValues[j+1]-ActiveSeries.YValues[j])/(x1-x0);
       Result:=True;
       break;
     end
   end
end;

(*procedure TSpectroscopyV.SetFindLine_pos(i:integer;Const X: double);
begin
  if (X<ArChart[i].BottomAxis.Minimum) then
    FindLine_pos:= ArChart[i].BottomAxis.Minimum
  else
   begin
    if (X>ArChart[i].BottomAxis.Maximum) then
      FindLine_pos:= ArChart[i].BottomAxis.Maximum
       else    FindLine_pos:= X;
   end;
end;
 procedure  TSpectroscopyV.ChartAfterDraw(Sender: TObject);
var  Yvalue:single;
  begin
   Max_Y:=ArChart[ActiveIndex].LeftAxis.Maximum;
   Min_Y:=ArChart[ActiveIndex].LeftAxis.Minimum;
   ActiveSeries:=ArSeries[ActiveIndex,0];
   SetFindLine_Pos(ActiveIndex,FindLine_Pos);
   DrawFindLine(ActiveIndex);
//   if FindYValue( ActiveSeries,FindLine_Pos,Yvalue)then  edSetPoint.Text:=FloatToStrF((1-Yvalue),ffFixed,5,2 );
end;
*)

procedure TSpectroscopyV.BitBtnHelpClick(Sender: TObject);
begin
    application.helpcontext(IDH_Spectroscopy_STM{58});
end;


procedure TSpectroScopyV.BitBtnPrintClick(Sender: TObject);
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

procedure TSpectroScopyV.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose:=not  flgProcess;
end;


procedure TSpectroScopyV.Copytoclipboard1Click(Sender: TObject);
begin
 Main.CopytoClipBoardExecute(self);
end;


(*
procedure TSpectroscopyV.ChartMouseDownV(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var XPosition:longint;
  i:integer;
begin
  if (Button=mbLeft) and (ssAlt in Shift) then
   begin
     Panel3.BeginDrag(False);
     CopyClipboard;
     exit;
  end
  else
  begin
   for i:=0 to NPage-1 do ArChart[i].Chart.AllowZoom:=True;
  end;
  inherited  ChartMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
end;
*)
procedure TSpectroscopyV.ChartMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:integer;
begin
 for i:=0 to NPage-1 do ArChart[i].Chart.AllowZoom:=false;
end;



procedure TSpectroScopyV.FrStartVEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  FrStartV.EditFrmKeyPress(Sender, Key);
   if not(Key in ['-','0'..'9',#8]) then Key :=#0 ;
end;

procedure TSpectroScopyV.FrStartVEditFrmChange(Sender: TObject);
var val:integer;
begin
 try
  if (FrStartV.EditFrm.Text='')  or (FrStartV.EditFrm.Text='-') then exit;
    val:=StrToInt(FrStartV.EditFrm.Text);
    if val<FrStartV.ScrollBarFrm.Min then
    begin
     val:=FrStartV.ScrollBarFrm.Min;
     FrStartV.EditFrm.Text:=inttostr(val);
    end;
    if val>FrStartV.ScrollBarFrm.Max then
    begin
     val:=FrStartV.ScrollBarFrm.Max;
     FrStartV.EditFrm.Text:=inttostr(val);
    end;
  PStartV:=val;
  UStep:=(PStopV-PStartV)/NPoint;
  LabelStep.Caption:=BaseCaptionStep+FloatToStrF(UStep,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_35' (* ' mV' *) );
  LabelStep.Font.Color:=clBlack;
   if abs(UStep)<abs(UStepMin) then
     begin
      LabelStep.Font.Color:=clRed;
     end;
   FrStartV.ScrollBarFrm.Position:=PStartV;
 except
    on EConvertError do
    begin   FrStartV.EditFrm.text:='-5000'end;
 end;
end;

procedure TSpectroScopyV.FrStopVBitBtnFrmClick(Sender: TObject);
begin
  FrStopV.BitBtnFrmClick(Sender);

end;

procedure TSpectroScopyV.FrStopVEditFrmChange(Sender: TObject);
var val:integer;
begin
  try
   if (FrStopV.EditFrm.Text='')  or (FrStopV.EditFrm.Text='-') then exit;
    val:=StrToInt(FrStopV.EditFrm.Text);
    if val<FrStopV.ScrollBarFrm.Min then
    begin
     val:=FrStopV.ScrollBarFrm.Min;
     FrStopV.EditFrm.Text:=inttostr(val);
    end;
    if val>FrStopV.ScrollBarFrm.Max then
    begin
     val:=FrStopV.ScrollBarFrm.Max;
     FrStopV.EditFrm.Text:=inttostr(val);
    end;
     val:=StrToInt(FrStopV.EditFrm.Text);
     pStopV:=val;
     UStep:=(val-PStartV)/NPoint;
     LabelStep.Caption:=BaseCaptionStep+FloatToStrF(UStep,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_35' (* ' mV' *) );
     LabelStep.Font.Color:=clBlack;
   if abs(UStep)<abs(UStepMin) then
     begin
      LabelStep.Font.Color:=clRed;
     end;
    FrStopV.ScrollBarFrm.Position:=pStopV;
  except
    on EConvertError do
    begin   FrStopV.EditFrm.text:='5000'end;
   end;
end;

procedure TSpectroScopyV.FrStopVEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  FrStopV.EditFrmKeyPress(Sender, Key);
  if not(Key in ['-','0'..'9',#8]) then Key :=#0 ;
end;

procedure TSpectroScopyV.FrTEditFrmChange(Sender: TObject);
var val:integer;
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
    FrT.ScrollBarFrm.Position:=val;
  except
    on EConvertError do
    begin   FrT.EditFrm.text:='1'end;
   end;
end;

procedure TSpectroScopyV.FrTEditFrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  FrT.EditFrmKeyPress(Sender, Key);
  if not(Key in ['0'..'9',#8]) then Key :=#0 ;
end;


procedure TSpectroScopyV.FrFrmExit(Sender: TObject);
begin
  TestStepSize
end;

procedure TSpectroScopyV.TestStepSize;
begin
    LabelStep.Font.Color:=clBlack;
   if abs(UStep)<abs(UStepMin) then
     begin
      siLangLinked.MessageDlg(strsv6{'The step too small!Change parameters to increase the step.'},mtWarning,[mbOk],0);
      LabelStep.Font.Color:=clRed;
     end;
end;
procedure TSpectroScopyV.UpdateStrings;
begin
  strsv6 := siLangLinked.GetTextOrDefault('strstrsv6');
  strsv5 := siLangLinked.GetTextOrDefault('strstrsv5');
  strsv4 := siLangLinked.GetTextOrDefault('strstrsv4');
  strsv3 := siLangLinked.GetTextOrDefault('strstrsv3');
  strsv2 := siLangLinked.GetTextOrDefault('strstrsv2');
  strsv0 := siLangLinked.GetTextOrDefault('strstrsv0');
end;
procedure TSpectroscopyV.WMNCLButton(var Message: TMessage);
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

procedure TSpectroscopyV.ThreadDone(var AMessage : TMessage);      // Message to be sent back from thread when its done
 // Message to be sent back from thread when its done
 var i,NEWPOINTS:integer;
 x0nm,y0nm:double;
 begin
 if  (mDrawing=AMessage.WParam)  then
  begin
    if assigned(SpectrSTMThread) then
     begin
        SpectrSTMThread:=nil;
        SpectrSTMThreadActive := false;
     end;//drawthread

   if SpectrPointNmb<(NPage-1) then
    begin
      inc(SpectrPointNmb);
      PageControl.Pages[SpectrPointNmb-1].HighLighted:=False;
      PageControl.ActivePageIndex:=SpectrPointNmb+1;
      PageControl.ActivePage.HighLighted:=True;
      Application.ProcessMessages;
      PntSpector:=ArPntSpector.items[SpectrPointNmb];
      x0nm:=PntSpector^.point.x;
      y0nm:=PntSpector^.point.y;
      inc( SpectrPointNmb_Data,3);
      ScanData.AquiSpectrPoint[ SpectrPointNmb_Data]:=round(x0nm*TransformUnit.XPnm_d);    //discrets
      ScanData.AquiSpectrPoint[ SpectrPointNmb_Data+1]:=round(y0nm*TransformUnit.YPnm_d);
      ScanData.AquiSpectrPoint[ SpectrPointNmb_Data+2]:=SpectrParams.NCurves;//1;

     
      while assigned(nanoedu.method) do application.ProcessMessages;
      NanoEdu.ScanMoveToX0Y0Method(X0nm,y0nm);
      error:=NanoEdu.Method.Launch;
     while assigned(ProgressMoveTo) do application.processmessages;
//  FreeAndNil(NanoEdu.Method);
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
     ReStoreStart;
     BitBtnSaveClick(Self);
   end;
 end;
 //draw
 if mScanning=AMessage.WParam then
    begin
 //     NanoEdu.Method.ScanWorkDone;
      NanoEdu.Method.FreeBuffers;
      NanoEdu.Method.TurnOnFB;
 //     if Assigned(scWorkThread) then FreeAndNil(scWorkThread);
      FreeAndNil(NanoEdu.Method);
    end;
end;

function TSpectroScopyV.CreateQuickReportComponent:boolean;
begin
   result:=true;
  if not Assigned(QuickRep) then
  begin
    result:=true;
    try
     QuickRep:=TQuickRep.Create(self);
    except
     begin
      siLangLinked.MessageDlg(siLangLinked.GetTextOrDefault('IDS_30' (* 'Printer is not connected.  ' *) ),mtwarning,[mbYes],0);
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
      siLangLinked.MessageDlg(siLangLinked.GetTextOrDefault('IDS_30' (* 'Printer is not connected.  ' *) ),mtwarning,[mbYes],0);
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
    Application.ProcessMessages;
end;

procedure TSpectroScopyV.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i:integer;
  begin
     i:=PageControl.ActivePageIndex;
    if (ssCtrl in Shift) then
    begin
      if (Key=vk_Delete) then
      begin
         if not FlgSurfaceData then
        begin
          if assigned(ArChart[i]) then
          ArChart[i].DeleteSeries(ArChart[i].ActiveSeries);
        end
        else
         if i<>0 then
          if assigned(ArChart[i-1]) then  ArChart[i-1].DeleteSeries(ArChart[i-1].ActiveSeries);
      end;
      if Key=ord('A') then
      begin
        if not FlgSurfaceData then
        begin
         ArChart[i].FiltrAverage;
        end
        else
        if i<>0 then
         begin
          ArChart[i-1].FiltrAverage;
         end;
      end;
   end
   else
    if (ssAlt in Shift) then
    begin
      flgDragForm:=true;//CopyClipboard;
    end
    else
   Case Key of
    vk_Prior: //Page Up
             begin
              if not FlgSurfaceData  then
              begin
               ArChart[i].SetActiveSeriesNext;
              end
              else
              begin
               if i>=(PageControl.PageCount-Npage)  then begin dec(i,(PageControl.PageCount-Npage) ); ArChart[i].SetActiveSeriesNext;end;
              end;
             end;
    vk_Next: //Page Down
             begin
              if not FlgSurfaceData  then
              begin
               ArChart[i].SetActiveSeriesPred;
              end
              else
              begin
               if i>=(PageControl.PageCount-Npage)  then begin dec(i,(PageControl.PageCount-Npage) ); ArChart[i].SetActiveSeriesPred;end;
              end;
            end;
          end;//Case Key of
end;

procedure TSpectroScopyV.ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
begin
 if flgDragForm then
  if Msg.message=WM_LButtonDown then
   begin
   if  getkeystate(VK_Menu)<0 then
   begin
       PageControl.BeginDrag(true);
       Main.CopyToClipBoardExecute(self);
       handled:=true;
      // ApplicationEvents1.CancelDispatch;
    end;
  end;
  flgDragForm:=false;
end;

procedure TSpectroScopyV.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (ssAlt in Shift) then
    begin
      flgDragForm:=false;
    end 
end;

procedure TSpectroScopyV.BitBtnExitClick(Sender: TObject);
begin
      close
end;

end.

