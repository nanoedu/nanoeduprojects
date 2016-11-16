//110703    programmer student Zotin
unit SpmChart;

//Make non visible item Linearlization goto AllowEdit ;
//080103
// LinearizationChartPopUpMenu.Visible:=AllowEditChartMenu.Checked;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, Menus, StdCtrls;

const     MaxDxyLabel = 102;   //20
type
  TChartLabel = ^MyChartLabel;

  MyChartLabel = record
    x_pos,y_pos: single;
    number: integer;
    next: TChartLabel;
  end;

  TLabelResult = class(TPanel)
    Label_dx: TLabel;
    Label_dy: TLabel;
    Label_dyx: TLabel;
    Label_number: TPanel;
    constructor Create(var AOwner: TComponent; Const i: integer);
    destructor  Destroy(); override;
    procedure   FillLabel(Const x,y: double; Const x_name,y_name,yx_name,x_axis,y_axis: string);
  end;


  MyResultLabelMassiv = array[1..MaxDxyLabel] of TLabelResult;

//ChartGraphica!!!

  TChartGraphica = class(TPanel)
    Chart: TChart;
    PanelResult: TScrollBox;
    CursorPanel: TPanel;
    CopySaveDialog: TSaveDialog;
    AxisXLabel: TLabel;
    AxisYLabel: TLabel;
    CursorLabel: TLabelResult; //Cursor coordinates
  {----------------Main Menu-----------------------}
    EditChartMenu: TMenuItem;
      CopyToFileChartMenu: TMenuItem;
      None1ChartMenu: TMenuItem;
      {---------Linearization--------------------}
      LinearizationXChartMenu: TMenuItem;
        AddLinearizationXLabelChartMenu: TMenuItem;
        SaveLinearizationXLabelChartMenu: TMenuItem;
      LinearizationYChartMenu: TMenuItem;
        AddLinearizationYLabelChartMenu: TMenuItem;
        SaveLinearizationYLabelChartMenu: TMenuItem;
      NoneLineanizationChartMenu: TMenuItem;
      {---------Linearization--------------------}
      AllowEditChartMenu: TMenuItem;
      EditLabelChartMenu: TMenuItem;
      AddLabelChartMenu: TMenuItem;
      DeleteLabelChartMenu: TMenuItem;
      DeleteAllLabelChartMenu: TMenuItem;
      CursorChartMenu: TMenuItem;
      SetCursorChartMenu: TMenuItem;
      DeleteCursorChartMenu: TMenuItem;
  //    ResultChartMenu: TMenuItem;
  //    ShowResultChartMenu: TMenuItem;
  //    HideResultChartMenu: TMenuItem;
  {----------------Main Menu-----------------------}

  {----------------PopUp Menu----------------------}
      EditChartPopUpMenu: TPopUpMenu;
      CopyToFileChartPopUpMenu: TMenuItem;
      None1ChartPopUpMenu: TMenuItem;
      {---------Linearization--------------------}
      LinearizationXChartPopUpMenu: TMenuItem;
      AddLinearizationXLabelChartPopUpMenu: TMenuItem;
      SaveLinearizationXLabelChartPopUpMenu: TMenuItem;
      LinearizationYChartPopUpMenu: TMenuItem;
      AddLinearizationYLabelChartPopUpMenu: TMenuItem;
      SaveLinearizationYLabelChartPopUpMenu: TMenuItem;
      NoneLineanizationChartPopUpMenu: TMenuItem;
      {---------Linearization--------------------}
      AllowEditChartPopUpMenu: TMenuItem;
      EditLabelChartPopUpMenu: TMenuItem;
        AddLabelChartPopUpMenu: TMenuItem;
        DeleteLabelChartPopUpMenu: TMenuItem;
        DeleteAllLabelChartPopUpMenu: TMenuItem;
      CursorChartPopUpMenu: TMenuItem;
        SetCursorChartPopUpMenu: TMenuItem;
        DeleteCursorChartPopUpMenu: TMenuItem;
  //    ResultChartPopUpMenu: TMenuItem;
  //      ShowResultChartPopUpMenu: TMenuItem;
  //      HideResultChartPopUpMenu: TMenuItem;
  {----------------PopUp Menu-----------------------}

    constructor Create(var AOwner: TComponent); virtual;
    destructor Destroy(); virtual;
    procedure DrawLabel(ChartLabel: TChartLabel);
    procedure DrawAllLabel(); virtual;
    procedure AddLabel(Const x,y: double);
    procedure SetCurrentLabelAdded();
    function  DeleteLabel(Const number: integer): boolean;
    procedure DeleteAllLabel();
    procedure IsMouseInAllLabel(Const X,Y:integer);
    function  IsMouseInFirstLabel(ChartLabel: TChartLabel; Const X,Y:integer): boolean;
    function  IsMouseInSecondLabel(ChartLabel: TChartLabel;Const X,Y:integer): boolean;
    procedure CreateShowResultList; virtual;
    procedure Action(Const Key: Integer); virtual;
   protected

    lb_Action: TListBox;
    MaxLabelAdd: integer;
    Cursor_index: integer;
    ResultLabelMassiv: MyResultLabelMassiv;
    FirstChartLabel: TChartLabel;
    IsLinearization: boolean;
    procedure SeriesActiveAfterAdd(Sender: TChartSeries;ValueIndex: Integer); virtual;
    procedure ChartResize(Sender: TObject);
    procedure ChartAfterDraw(Sender: TObject); virtual;
    procedure ChartMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer); virtual;
    procedure ChartClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,Y: Integer); virtual;

    procedure lb_ActionKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure DrawCursor(Const X,Y: integer);
    {--------Main Menu Click-----------------}
  //  procedure AllowEditClick(Sender: TObject); virtual;
    procedure CopyToFileClick(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure DeleteAllClick(Sender: TObject);
 //   procedure SetCursorClick(Sender: TObject); virtual;
    procedure DeleteCursorClick(Sender: TObject);
//    procedure HideResultClick(Sender: TObject);
//    procedure ShowResultClick(Sender: TObject);
       {---------Linearization--------------------}
    procedure AddLinearization(Sender: TObject);
    procedure SaveLinearizationX(Sender: TObject);
    procedure SaveLinearizationY(Sender: TObject);
       {---------Linearization--------------------}
    {--------Main Menu Click-----------------}
    procedure SetActiveSeries(Series: TLineSeries); virtual;
///******************************************!!!!!!!****************************
    procedure SaveLinearizationToFile(const Direction:string);
///***************************************************************************
  public
    InitSensitiveX,InitSensitiveY:single;
    ActiveLabelNumber: integer;
    CurrentLabelAdded: integer;
    IsCursor: boolean;
    IsChartEdit: boolean;
    //IsAction: boolean;
    IsResultPanelVisible: boolean;
    ChartScannerIniFile:string;
     ActiveSeries: TLineSeries;
     procedure AllowEditClick(Sender: TObject); virtual;
     procedure SetCursorClick(Sender: TObject); virtual;
     property  Series1 : TLineSeries read ActiveSeries write SetActiveSeries;
  end;//TChartGraphica

//Basic!!!!!

  TBasicChart=class(TChartGraphica)
  {----------------Main Menu-----------------------}
    None2ChartMenu: TMenuItem;
    EditFindLineChartMenu: TMenuItem;
    ActiveFindLineChartMenu: TMenuItem;
    DeActiveFindLineChartMenu: TMenuItem;
  {----------------Main Menu-----------------------}
  {----------------PopUp Menu----------------------}
    None2ChartPopUpMenu: TMenuItem;
    EditFindLineChartPopUpMenu: TMenuItem;
    ActiveFindLineChartPopUpMenu: TMenuItem;
    DeActiveFindLineChartPopUpMenu: TMenuItem;
  {----------------PopUp Menu----------------------}


    constructor Create(var AOwner: TComponent); override;
    destructor  Destroy(); override;
    procedure   Action(Const Key: Integer); override;
  protected
    IsFindLineActive: boolean;
    IsMoving: boolean;
    Max_Y,Min_Y: double;

    procedure SeriesActiveAfterAdd(Sender: TChartSeries; ValueIndex: Integer); override;

    procedure ChartAfterDraw(Sender: TObject); override;

    procedure DrawFindLine;      virtual;

    procedure ChartMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer); override;
    procedure ChartMouseMove(Sender: TObject;Shift: TShiftState; X, Y: Integer); virtual;
    procedure ChartMouseUp(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  virtual;
    procedure ChartClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState;
      X,Y: Integer); override;

    {--------Main Menu Click-----------------}
    procedure AllowEditClick(Sender: TObject); override;
 //   procedure   SetCursorClick(Sender: TObject); override;
    procedure ActivateFindLineClick(Sender: TObject);
    procedure DeActivateFindLineClick(Sender: TObject);
    {--------Main Menu Click-----------------}
  public
    FindLine_pos: single;
    IsAutoDetection: boolean;
    procedure SetFindLine_pos(Const X: double); virtual;
    procedure SetCursorClick(Sender: TObject); override;

  private
    FSetPriborParameters: TNotifyEvent;
    procedure DoSetPriborParameters;
  published
    property  OnSetPriborParameters: TNotifyEvent read FSetPriborParameters  write FSetPriborParameters;
  end;//TBasicChart
              //ChartResonance!!!!

  TChartResonance = class (TBasicChart)
    BottomPanel: TPanel;
    FindLineLabel: TLabel;
    FindLineEdit: TLabel;//SpmEdit;
    ValueFindLineLabel: TLabel;
    QLabel: TLabel;
    constructor Create(var AOwner: TComponent); override;
    destructor  Destroy(); override;
    procedure   Action(Const Key: Integer); override;
  private
    cursorsaved:Tcursor;
  protected
    procedure DrawFindLine; override;
    procedure ChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure ChartMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); override;
    procedure ChartMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SeriesActiveAfterAdd(Sender: TChartSeries;ValueIndex: Integer); override;
    procedure FindLineEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SetFindLineEditText;  virtual;
  public
    procedure SetFindLine_pos(Const X: double); override;
  end;//TChartResonance

//SeriesList!!!

  TSeriesList = ^MySeriesList;
  MySeriesList = record
 //   prev:  TSeriesList;
    Series: TLineSeries;
    next: TSeriesList;
           end;//MySeriesList

//ChartSpectroscopy!!!

  TChartSpectrographi=class(TChartResonance)
   constructor Create(var AOwner: TComponent); override;
   destructor  Destroy(); override;
    function  AddSeries(SeriesColor: TColor = clred): TLineSeries;
    function  DeleteSeries(Series: TLineSeries): boolean;
    procedure DeleteAllSeries;
    procedure ClearAllSeries;
    procedure Action(Const Key: Integer); override;
    procedure CreateShowResultList; override;
  protected
   //   function  FindSeries(Series:TSeries):TSeries;
    procedure SeriesActiveAfterAdd(Sender: TChartSeries; ValueIndex: Integer); override;
    procedure SetMaxMinFindLine;
    procedure ChartMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer); override;
  public
     flgFilter:boolean;
     FilterSeries:TLineSeries;
     HeadSeriesList: TSeriesList;
    procedure SetActiveSeries(Series: TLineSeries); override;
    procedure SetActiveSeriesNext;
    procedure SetActiveSeriesPred;
    procedure SetCursorClick(Sender: TObject);  override;
    procedure SetFindLine_pos(Const X: double); override;
    procedure FiltrAverage;    virtual;
//    procedure FiltrMedian;
end;

  TChartSpectrographiZ=class( TChartSpectrographi)//(TBasicChart)
   constructor Create(var AOwner: TComponent); override;
   procedure   Action(Const Key: Integer); override;
  protected
   procedure   SetFindLineEditText;   override;
   procedure   SetActiveSeries(Series: TLineSeries); override;
   procedure   CreateShowResultList; override;
   procedure   DrawAllLabel(); override;

//   procedure   FiltrAverage;  override;
  public
end;
  TChartSpectrographiTerra=class( TChartSpectrographi)//(TBasicChart)
   constructor Create(var AOwner: TComponent); override;
  protected
   procedure   SetFindLineEditText;   override;
   procedure   SetActiveSeries(Series: TLineSeries); override;
   procedure   SeriesActiveAfterAdd(Sender: TChartSeries; ValueIndex: Integer); override;
//   procedure   CreateShowResultList; override;
//   procedure   DrawAllLabel(); override;
//   procedure   FiltrAverage;  override;
  public
  end;
  TChartSpectrographiV=class( TChartSpectrographi)//(TBasicChart)
   constructor Create(var AOwner: TComponent); override;
    procedure  Action(Const Key: Integer); override;
  protected
   procedure   ChartAfterDraw(Sender: TObject);  override;
   procedure   CreateShowResultList; override;
   procedure   DrawAllLabel(); override;
end;

implementation

uses   uFileOp,GlobalVar,CSPMVar,inifiles,frNoFormUnitLoc;

const
   ResultWidth: integer =130;//120;// 130;
   NearLine: integer = 3;
   MaxLinearizationLabel: integer = 60;
   Chartdx: integer = 13;
   Chartdy: integer = 22;
   CursorPanelHeight: integer = 61;
   CursorPanelHeightSpectr: integer = 71;
{------------------------ TLabelResult ----------------------------------------}
constructor TLabelResult.Create(var AOwner: TComponent; Const i: integer);
begin
  inherited Create(AOwner);
    Self.Align:= alTop;
    Self.Height:= 0;
    Color:=MyMenuColor;//$00DCDDDB;//true;
  Label_number:= TPanel.Create(Self);  { TODO : 150607 }
    Label_number.ParentColor:=true;
    Label_number.Parent:= Self;
    Label_number.Font.Size:= 10;
    Label_number.Align:= alLeft;
    Label_number.Alignment:= taCenter;
    Label_number.Width:= 15;//20;
    Label_number.BevelInner:= bvNone;
    Label_number.BevelOuter:= bvNone;
    Label_number.Caption:= IntToStr(i);

  Label_dx:= TLabel.Create(Self);
    Label_dx.Parent:= Self;
    Label_dx.Font.Size:= 10;
    Label_dx.Top:= 1;
    Label_dx.Left:= 23;
    Label_dx.Alignment:= taLeftJustify;

  Label_dy:= TLabel.Create(Self);
    Label_dy.Parent:= Self;
    Label_dy.Font.Size:= 10;
    Label_dy.Top:= 20;
    Label_dy.Left:= 23;
    Label_dy.Alignment:= taLeftJustify;

 Label_dyx:= TLabel.Create(Self);
    Label_dyx.Parent:= Self;
    Label_dyx.Font.Size:= 10;
    Label_dyx.Top:= 39;
    Label_dyx.Left:= 23;
    Label_dyx.Alignment:= taLeftJustify;
end;//constructor TLabelResult.Create

destructor TLabelResult.Destroy();
begin
  Label_dx.Destroy;
  Label_dy.Destroy;
  Label_dyx.Destroy;
  inherited Destroy;
end;//destructor TLabelResult.Destroy();

procedure TLabelResult.FillLabel(Const x,y: double;
                                 Const x_name,y_name,yx_name,x_axis,y_axis: string);
begin
  Label_dx.Caption := x_name + FloatToStrF(x,fffixed,7,2)+' '+x_axis;
  Label_dy.Caption := y_name + FloatToStrF(y,fffixed,7,2)+' '+y_axis;
  if yx_name<>'' then
   if x<>0 then Label_dyx.Caption := yx_name + FloatToStrF(y/x,fffixed,7,3);
end;//procedure TLabelResult.FillLabel();


{------------------------ TChartGraphica --------------------------------------}
constructor TChartGraphica.Create(var AOwner: TComponent);
var
  i: integer;
begin
  inherited Create(AOwner);
    ParentColor:= false;
    Color:=$00DCDDDB;//clBtnFace;
    Parent:= TWinControl(AOwner);
    BevelInner:= bvNone;
    BevelOuter:= bvNone;
    Height:= 200;
    Width:= 200;
{----------------Create Main Menu-----------------------}

    EditChartMenu:= TMenuItem.Create(EditChartMenu);
    EditChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_0' (* 'Tools' *) );
    EditChartMenu.GroupIndex:= 10;

(*  CopyToFileChartMenu:= TMenuItem.Create(EditChartMenu);
    CopyToFileChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_1' { 'Save to bmp file' } );
    CopyToFileChartMenu.OnClick:= CopyToFileClick;
    EditChartMenu.Add(CopyToFileChartMenu);
 *)

    AllowEditChartMenu:= TMenuItem.Create(EditChartMenu);
    AllowEditChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_2' (* 'Analysis' *) );
    AllowEditChartMenu.OnClick:= AllowEditClick;
    EditChartMenu.Add(AllowEditChartMenu);

    None1ChartMenu:= TMenuItem.Create(EditChartMenu);
    None1ChartMenu.Caption:= '-';
    None1ChartMenu.Visible:= false;
    EditChartMenu.Add(None1ChartMenu);

  {---------Linearization--------------------}
    LinearizationXChartMenu:= TMenuItem.Create(EditChartPopUpMenu);
    LinearizationXChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_3' (* 'Linearization X' *) );
    LinearizationXChartMenu.Visible:= false;
    EditChartMenu.Add(LinearizationXChartMenu);
    AddLinearizationXLabelChartMenu:= TMenuItem.Create(LinearizationXChartMenu);
      AddLinearizationXLabelChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_4' (* 'Add Label' *) );
      AddLinearizationXLabelChartMenu.OnClick:= AddLinearization;
      LinearizationXChartMenu.Add(AddLinearizationXLabelChartMenu);
    SaveLinearizationXLabelChartMenu:= TMenuItem.Create(LinearizationXChartMenu);
      SaveLinearizationXLabelChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_5' (* 'Save' *) );
      SaveLinearizationXLabelChartMenu.OnClick:= SaveLinearizationX;
      LinearizationXChartMenu.Add(SaveLinearizationXLabelChartMenu);

    LinearizationYChartMenu:= TMenuItem.Create(EditChartMenu);
    LinearizationYChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_6' (* 'Linearization Y' *) );
    LinearizationYChartMenu.Visible:= false;
    EditChartMenu.Add(LinearizationYChartMenu);
    AddLinearizationYLabelChartMenu:= TMenuItem.Create(LinearizationYChartMenu);
      AddLinearizationYLabelChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_4' (* 'Add Label' *) );
      AddLinearizationYLabelChartMenu.OnClick:= AddLinearization;
      LinearizationYChartMenu.Add(AddLinearizationYLabelChartMenu);
    SaveLinearizationYLabelChartMenu:= TMenuItem.Create(LinearizationYChartMenu);
      SaveLinearizationYLabelChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_5' (* 'Save' *) );
      SaveLinearizationYLabelChartMenu.OnClick:= SaveLinearizationY;
      LinearizationYChartMenu.Add(SaveLinearizationYLabelChartMenu);
    NoneLineanizationChartMenu:= TMenuItem.Create(EditChartMenu);
      NoneLineanizationChartMenu.Caption:= '-';
      NoneLineanizationChartMenu.Visible:= false;
      EditChartMenu.Add(NoneLineanizationChartMenu);
  {---------Linearization--------------------}
    EditLabelChartMenu:= TMenuItem.Create(EditChartMenu);
      EditLabelChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_9' (* 'Labels' *) );
      EditLabelChartMenu.Visible:= false;
      EditChartMenu.Add(EditLabelChartMenu);
      AddLabelChartMenu:= TMenuItem.Create(EditLabelChartMenu);
      AddLabelChartMenu.OnClick:= AddClick;
      AddLabelChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_10' (* 'Add' *) );
      EditLabelChartMenu.Add(AddLabelChartMenu);
    DeleteLabelChartMenu:= TMenuItem.Create(EditLabelChartMenu);
      DeleteLabelChartMenu.OnClick:= DeleteClick;
      DeleteLabelChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_11' (* 'Delete' *) );
      EditLabelChartMenu.Add(DeleteLabelChartMenu);
    DeleteAllLabelChartMenu:= TMenuItem.Create(EditLabelChartMenu);
      DeleteAllLabelChartMenu.OnClick:= DeleteAllClick;
      DeleteAllLabelChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_12' (* 'Delete All' *) );
      EditLabelChartMenu.Add(DeleteAllLabelChartMenu);

    CursorChartMenu:= TMenuItem.Create(EditChartMenu);
      CursorChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_13' (* 'Cursor' *) );
    CursorChartMenu.Visible:= false;
    EditChartMenu.Add(CursorChartMenu);
    SetCursorChartMenu:= TMenuItem.Create(CursorChartMenu);
      SetCursorChartMenu.OnClick:= SetCursorClick;
      SetCursorChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_14' (* 'Set Cursor' *) );
      CursorChartMenu.Add(SetCursorChartMenu);
    DeleteCursorChartMenu:= TMenuItem.Create(CursorChartMenu);
      DeleteCursorChartMenu.OnClick:= DeleteCursorClick;
      DeleteCursorChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_15' (* 'Delete Cursor' *) );
      CursorChartMenu.Add(DeleteCursorChartMenu);

(* ResultChartMenu:= TMenuItem.Create(EditChartMenu);
    ResultChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_16' { 'Result' } );
    ResultChartMenu.Visible:= false;
    EditChartMenu.Add(ResultChartMenu);
    ShowResultChartMenu:= TMenuItem.Create(ResultChartMenu);
      ShowResultChartMenu.OnClick:= ShowResultClick;
      ShowResultChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_17' { 'Show Result' } );
      ShowResultChartMenu.Checked:= true;
      ResultChartMenu.Add(ShowResultChartMenu);
    HideResultChartMenu:= TMenuItem.Create(ResultChartMenu);
      HideResultChartMenu.OnClick:= HideResultClick;
      HideResultChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_18' (* 'Hide Result' } );
      ResultChartMenu.Add(HideResultChartMenu);
  *)
{----------------Create Main Menu-----------------------}
{----------------Create PopUp Menu----------------------}

     EditChartPopUpMenu:= TPopUpMenu.Create(EditChartPopUpMenu);

(*  CopyToFileChartPopUpMenu:= TMenuItem.Create(EditChartPopUpMenu);
    CopyToFileChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_1' { 'Save to bmp file' } );
    CopyToFileChartPopUpMenu.OnClick:= CopyToFileClick;
    EditChartPopUpMenu.Items.Add(CopyToFileChartPopUpMenu);
*)
  AllowEditChartPopUpMenu:= TMenuItem.Create(EditChartPopUpMenu);
    AllowEditChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_2' (* 'Analysis' *) );
    AllowEditChartPopUpMenu.OnClick:= AllowEditClick;
    EditChartPopUpMenu.Items.Add(AllowEditChartPopUpMenu);

  None1ChartPopUpMenu:= TMenuItem.Create(EditChartPopUpMenu);
    None1ChartPopUpMenu.Caption:= '-';
    EditChartPopUpMenu.Items.Add(None1ChartPopUpMenu);

  {---------Linearization--------------------}
  LinearizationXChartPopUpMenu:= TMenuItem.Create(EditChartPopUpMenu);
    LinearizationXChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_3' (* 'Linearization X' *) );
    LinearizationXChartPopUpMenu.Visible:= false;
    EditChartPopUpMenu.Items.Add(LinearizationXChartPopUpMenu);
    AddLinearizationXLabelChartPopUpMenu:= TMenuItem.Create(LinearizationXChartPopUpMenu);
      AddLinearizationXLabelChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_4' (* 'Add Label' *) );
      AddLinearizationXLabelChartPopUpMenu.OnClick:= AddLinearization;
      LinearizationXChartPopUpMenu.Add(AddLinearizationXLabelChartPopUpMenu);
    SaveLinearizationXLabelChartPopUpMenu:= TMenuItem.Create(LinearizationXChartPopUpMenu);
      SaveLinearizationXLabelChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_5' (* 'Save' *) );
      SaveLinearizationXLabelChartPopUpMenu.OnClick:= SaveLinearizationX;
      LinearizationXChartPopUpMenu.Add(SaveLinearizationXLabelChartPopUpMenu);

  LinearizationYChartPopUpMenu:= TMenuItem.Create(EditChartPopUpMenu);
    LinearizationYChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_6' (* 'Linearization Y' *) );
    LinearizationYChartPopUpMenu.Visible:= false;
    EditChartPopUpMenu.Items.Add(LinearizationYChartPopUpMenu);
    AddLinearizationYLabelChartPopUpMenu:= TMenuItem.Create(LinearizationYChartPopUpMenu);
      AddLinearizationYLabelChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_4' (* 'Add Label' *) );
      AddLinearizationYLabelChartPopUpMenu.OnClick:= AddLinearization;
      LinearizationYChartPopUpMenu.Add(AddLinearizationYLabelChartPopUpMenu);
    SaveLinearizationYLabelChartPopUpMenu:= TMenuItem.Create(LinearizationYChartPopUpMenu);
      SaveLinearizationYLabelChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_5' (* 'Save' *) );
      SaveLinearizationYLabelChartPopUpMenu.OnClick:= SaveLinearizationY;
      LinearizationYChartPopUpMenu.Add(SaveLinearizationYLabelChartPopUpMenu);

  NoneLineanizationChartPopUpMenu:= TMenuItem.Create(EditChartPopUpMenu);
    NoneLineanizationChartPopUpMenu.Caption:= '-';
    NoneLineanizationChartPopUpMenu.Visible:= false;
    EditChartPopUpMenu.Items.Add(NoneLineanizationChartPopUpMenu);
  {---------Linearization--------------------}

  EditLabelChartPopUpMenu:= TMenuItem.Create(EditChartPopUpMenu);
    EditLabelChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_9' (* 'Labels' *) );
    EditLabelChartPopUpMenu.Visible:= false;
    EditChartPopUpMenu.Items.Add(EditLabelChartPopUpMenu);
    AddLabelChartPopUpMenu:= TMenuItem.Create(EditLabelChartPopUpMenu);
      AddLabelChartPopUpMenu.OnClick:= AddClick;
      AddLabelChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_10' (* 'Add' *) );
      EditLabelChartPopUpMenu.Add(AddLabelChartPopUpMenu);
    DeleteLabelChartPopUpMenu:= TMenuItem.Create(EditLabelChartPopUpMenu);
      DeleteLabelChartPopUpMenu.OnClick:= DeleteClick;
      DeleteLabelChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_11' (* 'Delete' *) );
      EditLabelChartPopUpMenu.Add(DeleteLabelChartPopUpMenu);
    DeleteAllLabelChartPopUpMenu:= TMenuItem.Create(EditLabelChartPopUpMenu);
      DeleteAllLabelChartPopUpMenu.OnClick:= DeleteAllClick;
      DeleteAllLabelChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_12' (* 'Delete All' *) );
      EditLabelChartPopUpMenu.Add(DeleteAllLabelChartPopUpMenu);

    CursorChartPopUpMenu:= TMenuItem.Create(EditChartPopUpMenu);
    CursorChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_13' (* 'Cursor' *) );
    CursorChartPopUpMenu.Visible:= false;
    EditChartPopUpMenu.Items.Add(CursorChartPopUpMenu);
    SetCursorChartPopUpMenu:= TMenuItem.Create(CursorChartPopUpMenu);
      SetCursorChartPopUpMenu.OnClick:= SetCursorClick;
      SetCursorChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_14' (* 'Set Cursor' *) );
      CursorChartPopUpMenu.Add(SetCursorChartPopUpMenu);
    DeleteCursorChartPopUpMenu:= TMenuItem.Create(CursorChartPopUpMenu);
      DeleteCursorChartPopUpMenu.OnClick:= DeleteCursorClick;
      DeleteCursorChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_15' (* 'Delete Cursor' *) );
      CursorChartPopUpMenu.Add(DeleteCursorChartPopUpMenu);

 (* ResultChartPopUpMenu:= TMenuItem.Create(EditChartPopUpMenu);
    ResultChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_16' (* 'Result' } );
    ResultChartPopUpMenu.Visible:= false;
    EditChartPopUpMenu.Items.Add(ResultChartPopUpMenu);
    ShowResultChartPopUpMenu:= TMenuItem.Create(ResultChartPopUpMenu);
      ShowResultChartPopUpMenu.OnClick:= ShowResultClick;
      ShowResultChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_17' (* 'Show Result' } );
      ShowResultChartPopUpMenu.Checked:= false;
      ResultChartPopUpMenu.Add(ShowResultChartPopUpMenu);
    HideResultChartPopUpMenu:= TMenuItem.Create(ResultChartPopUpMenu);
      HideResultChartPopUpMenu.OnClick:= HideResultClick;
      HideResultChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_18' (* 'Hide Result' } );
      ResultChartPopUpMenu.Add(HideResultChartPopUpMenu);
  *)
{----------------Create PopUp Menu----------------------}
  MaxLabelAdd:= MaxDxyLabel;

  PanelResult:= TScrollBox.Create(TComponent(Self));
    PanelResult.ParentColor:= false;
    PanelResult.Parent:= Self;
    PanelResult.parentColor:=true;// clBtnFace;
    PanelResult.Width:= ResultWidth;
    PanelResult.Align:= alRight;
    PanelResult.AutoScroll:= true;
    PanelResult.PopupMenu:= EditChartPopUpMenu;
    PanelResult.Visible:=False;
    PanelResult.VertScrollBar.size:=3;
  new(FirstChartLabel);
    FirstChartLabel.number:= 0;
    FirstChartLabel.next:= nil;
  CurrentLabelAdded:= 2;
  ActiveLabelNumber:= -1;
  IsCursor:= false;
  lb_Action:= TListBox.Create(Self);
    lb_Action.OnKeyDown:= lb_ActionKeyDown;
    lb_Action.Parent:= Self;
  CursorPanel:= TPanel.Create(PanelResult);
    CursorPanel.ParentColor:= true;
    CursorPanel.Left:= 0;
    CursorPanel.Width:= PanelResult.Width-2;
    CursorPanel.Height:= 1;
    CursorPanel.Top:= 0;
    CursorPanel.Align:= alTop;
    CursorPanel.Parent:= PanelResult;
    CursorPanel.PopupMenu:= EditChartPopUpMenu;
    { TODO : 251103 }
  for i:= MaxDxyLabel downto 1 do begin
    ResultLabelMassiv[i]:= TLabelResult.Create(TComponent(PanelResult),i);
    ResultLabelMassiv[i].ParentColor:= false;
    ResultLabelMassiv[i].Color:= MyMenuColor;//clBtnFace;
    ResultLabelMassiv[i].Parent:= PanelResult;
    ResultLabelMassiv[i].Align:= alTop;
    ResultLabelMassiv[i].PopupMenu:= EditChartPopUpMenu;
  end;

  Chart := TChart.Create(Self);
    Chart.Parent:= Self;
    Chart.Color:=MyMenuColor;
    Chart.Align:= alClient;
    Chart.View3D:= False;
    Chart.PopupMenu:= EditChartPopUpMenu;
    Chart.AllowPanning:= pmNone;
    Chart.AllowZoom:= false;
    ActiveSeries:= TLineSeries.Create(Chart);
    ActiveSeries.OnAfterAdd:= SeriesActiveAfterAdd;//ActiveSeriesAfterAdd;
    Chart.AddSeries(ActiveSeries);
  with ActiveSeries.Pointer do
  begin
   Visible:=true;
   Style:=psCircle;
   HorizSize:=2;
   VertSize:=2;
  end;
  Chart.Legend.Visible:=False;
  Chart.OnClickSeries:= ChartClickSeries;
  Chart.OnAfterDraw:= ChartAfterDraw;
  Chart.OnMouseDown:= ChartMouseDown;
  Chart.OnResize:= ChartResize;

  IsResultPanelVisible:= true;
  AxisYLabel:= TLabel.Create(Chart);
    AxisYLabel.Parent:= Chart;
    AxisYLabel.Left:= 10;
    AxisYLabel.Top:= 10;
    AxisYLabel.Caption:='';// NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_37' (* 'nm' *) );
    AxisYLabel.AutoSize:=True;
    AxisYLabel.PopupMenu:= EditChartPopUpMenu;
  AxisXLabel:= TLabel.Create(Chart);
    AxisXLabel.AutoSize:=true;
    AxisXLabel.Parent:= Chart;
    AxisXLabel.PopupMenu:= EditChartPopUpMenu;
    //AxisXLabel.Left:= Chart.Width-20;
    //AxisXLabel.Top:= Chart.Height-12;
    AxisXLabel.Caption:='';// NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_37' (* 'nm' *) );
  CursorLabel:= TLabelResult.Create(TComponent(Chart),1);
    CursorLabel.Font.Size:=10;
    CursorLabel.Align:= alNone;
    CursorLabel.Visible:= false;
    CursorLabel.Width:= ResultWidth;
    CursorLabel.BevelInner:= bvNone;
    CursorLabel.BevelOuter:= bvNone;
    CursorLabel.Top:= 0;
    CursorLabel.Left:= 0;
    CursorLabel.Height:= CursorPanelHeight-1;
    CursorLabel.Parent:= CursorPanel;//Chart;
    CursorLabel.Label_number.Align:= alNone;
    CursorLabel.Label_number.Width:= CursorPanel.Width;
    CursorLabel.Label_number.Height:= 20;
    CursorLabel.Label_number.Top:= 0;
    CursorLabel.Label_number.Left:= 1;
    CursorLabel.Label_number.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_39' (* 'Cursor:' *) );
    CursorLabel.Label_dx.Caption:= 'x = ';
    CursorLabel.Label_dx.Left:= 6;
    CursorLabel.Label_dx.Top:= 20;
    CursorLabel.Label_dx.Height:= 20;
    CursorLabel.Label_dx.Width:= CursorPanel.Width-2;
    CursorLabel.Label_dy.Caption:= 'y = ';
    CursorLabel.Label_dy.Left:= 6;
    CursorLabel.Label_dy.Top:= 40;
    CursorLabel.Label_dy.Height:= 20;
    CursorLabel.Label_dy.Width:= CursorPanel.Width-2;
    CursorLabel.PopupMenu:= EditChartPopUpMenu;
end;//constructor TChartGraphica.Create(var AOwner: TComponent);

destructor TChartGraphica.Destroy();
var
  i: integer;
begin
  FreeAndNil(lb_Action);
  DeleteAllLabel;
  FreeAndNil(CursorLabel);
  FreeAndNil(CursorPanel);
  Dispose(FirstChartLabel);
   for i:= MaxDxyLabel downto 1 do  FreeAndNil(ResultLabelMassiv[i]);
  FreeAndNil(PanelResult);
  FreeAndNil(AxisYLabel);
  FreeAndNil(AxisXLabel);
   { TODO : 130607 }
   FreeAndNil(ActiveSeries);
   FreeAndNil(Chart);
{--------------Destroy Main Menu-------------------------}
{   HideResultChartMenu.Destroy;
    ShowResultChartMenu.Destroy;
    ResultChartMenu.Destroy;
}
(*    DeleteCursorChartMenu.Destroy;
      SetCursorChartMenu.Destroy;
    CursorChartMenu.Destroy;
      DeleteAllLabelChartMenu.Destroy;
      DeleteLabelChartMenu.Destroy;
      AddLabelChartMenu.Destroy;
    EditLabelChartMenu.Destroy;
    {---------Linearization--------------------}
    NoneLineanizationChartMenu.Destroy;
      SaveLinearizationXLabelChartMenu.Destroy;
      AddLinearizationXLabelChartMenu.Destroy;
    LinearizationXChartMenu.Destroy;
    SaveLinearizationYLabelChartMenu.Destroy;
      AddLinearizationYLabelChartMenu.Destroy;
    LinearizationYChartMenu.Destroy;
    {---------Linearization--------------------}
    None1ChartMenu.Destroy;
    AllowEditChartMenu.Destroy;
  //  CopyToFileChartMenu.Destroy;
  EditChartMenu.Destroy;
  {--------------Destroy Main Menu-------------------------}
  {--------------Destroy PopUp Menu------------------------}
 { HideResultChartPopUpMenu.Destroy;
      ShowResultChartPopUpMenu.Destroy;
    ResultChartPopUpMenu.Destroy;
}
      DeleteCursorChartPopUpMenu.Destroy;
      SetCursorChartPopUpMenu.Destroy;
    CursorChartPopUpMenu.Destroy;
      DeleteAllLabelChartPopUpMenu.Destroy;
      DeleteLabelChartPopUpMenu.Destroy;
      AddLabelChartPopUpMenu.Destroy;
    EditLabelChartPopUpMenu.Destroy;
    {---------Linearization--------------------}
    NoneLineanizationChartPopUpMenu.Destroy;
      SaveLinearizationXLabelChartPopUpMenu.Destroy;
      AddLinearizationXLabelChartPopUpMenu.Destroy;
    LinearizationXChartPopUpMenu.Destroy;
      SaveLinearizationYLabelChartPopUpMenu.Destroy;
      AddLinearizationYLabelChartPopUpMenu.Destroy;
    LinearizationYChartPopUpMenu.Destroy;
    {---------Linearization--------------------}
    None1ChartPopUpMenu.Destroy;
    AllowEditChartPopUpMenu.Destroy;
    //CopyToFileChartPopUpMenu.Destroy;
  EditChartPopUpMenu.Destroy;
  *)
  {--------------Destroy PopUp Menu------------------------}
 // CopySaveDialog.Destroy;
    FreeAndNil(DeleteCursorChartMenu);
    FreeAndNil(SetCursorChartMenu);
    FreeAndNil(CursorChartMenu);
      FreeAndNil(DeleteAllLabelChartMenu);
      FreeAndNil(DeleteLabelChartMenu);
      FreeAndNil(AddLabelChartMenu);
    FreeAndNil(EditLabelChartMenu);
    {---------Linearization--------------------}
    FreeAndNil(NoneLineanizationChartMenu);
      FreeAndNil(SaveLinearizationXLabelChartMenu);
      FreeAndNil(AddLinearizationXLabelChartMenu);
    FreeAndNil(LinearizationXChartMenu);
    FreeAndNil(SaveLinearizationYLabelChartMenu);
      FreeAndNil(AddLinearizationYLabelChartMenu);
    FreeAndNil(LinearizationYChartMenu);
    {---------Linearization--------------------}
    FreeAndNil(None1ChartMenu);
    FreeAndNil(AllowEditChartMenu);
  //  CopyToFileChartMenu.Destroy;
    FreeAndNil(EditChartMenu);
  {--------------Destroy Main Menu-------------------------}
  {--------------Destroy PopUp Menu------------------------}
 { HideResultChartPopUpMenu.Destroy;
      ShowResultChartPopUpMenu.Destroy;
    ResultChartPopUpMenu.Destroy;
}
      FreeAndNil(DeleteCursorChartPopUpMenu);
      FreeAndNil(SetCursorChartPopUpMenu);
      FreeAndNil(CursorChartPopUpMenu);
      FreeAndNil(DeleteAllLabelChartPopUpMenu);
      FreeAndNil(DeleteLabelChartPopUpMenu);
      FreeAndNil(AddLabelChartPopUpMenu);
      FreeAndNil(EditLabelChartPopUpMenu);
    {---------Linearization--------------------}
      FreeAndNil(NoneLineanizationChartPopUpMenu);
      FreeAndNil(SaveLinearizationXLabelChartPopUpMenu);
      FreeAndNil(AddLinearizationXLabelChartPopUpMenu);
      FreeAndNil(LinearizationXChartPopUpMenu);
      FreeAndNil(SaveLinearizationYLabelChartPopUpMenu);
      FreeAndNil(AddLinearizationYLabelChartPopUpMenu);
    FreeAndNil(LinearizationYChartPopUpMenu);
    {---------Linearization--------------------}
    FreeAndNil(None1ChartPopUpMenu);
    FreeAndNil(AllowEditChartPopUpMenu);
    //CopyToFileChartPopUpMenu.Destroy;
    FreeAndNil(EditChartPopUpMenu);
  inherited Destroy;
end;//destructor TChartGraphica.Destroy();

procedure TChartGraphica.Action(Const Key: Integer);
var
  CurrentLabel: TChartLabel;
begin
  Case Key of
vk_Escape: begin
            DeleteAllLabel;
           end;//vk_Escape
vk_Delete: begin
            DeleteLabel(ActiveLabelNumber);
            CreateShowResultList;
           end;//vk_Delete
vk_home: begin
          if IsCursor then
          begin
           Cursor_Index:= 0;
           Chart.Repaint;
          end;
         end;//vk_home
vk_end: begin
        if IsCursor then
         begin
          Cursor_Index:= ActiveSeries.XValues.Count-1;
          Chart.Repaint;
         end;
        end;//vk_end
vk_left: begin
           if IsCursor then
             if (Cursor_index>0) then
               begin
                Cursor_index:= Cursor_index-1;
                Chart.repaint;
               end;
         end;//vk_left
vk_right: begin
           if IsCursor then
             if (Cursor_index<ActiveSeries.XValues.Count-1) then
             begin
              Cursor_index:= Cursor_index+1;
              Chart.repaint;
             end;
          end;//vk_right
vk_up: begin
        CurrentLabel:= FirstChartLabel;
        while (CurrentLabel.next<>nil) and (CurrentLabel.number<>ActiveLabelNumber) do
          CurrentLabel:= CurrentLabel.next;
        if (CurrentLabel.next<>nil) then  ActiveLabelNumber:= CurrentLabel.next.number;
        Chart.repaint;
       end;//vk_up
vk_down: begin
          CurrentLabel:= FirstChartLabel;
          while (CurrentLabel.next<>nil) and (CurrentLabel.next.number<>ActiveLabelNumber) do
          CurrentLabel:= CurrentLabel.next;
          if (CurrentLabel<>FirstChartLabel) then ActiveLabelNumber:= CurrentLabel.number;
          Chart.repaint;
         end;//vk_down
vk_Return: begin  //Enter
            if (IsCursor) and (CurrentLabelAdded<MaxLabelAdd) then
              begin
                 AddLabel(ActiveSeries.XValues.Value[Cursor_index],
                          ActiveSeries.YValues.Value[Cursor_index]);
                  if not(IsLinearization) then  CreateShowResultList;
             end;
           end;//vk_Return
                        end;//Case Msg.wParam
end;//procedure Action

{-------------------------Main Menu Click--------------------------------------}
procedure TChartGraphica.AllowEditClick(Sender: TObject);
begin
  AllowEditChartMenu.Checked:= not(AllowEditChartMenu.Checked);
  AllowEditChartPopUpMenu.Checked:= not(AllowEditChartPopUpMenu.Checked);
  IsChartEdit:= AllowEditChartMenu.Checked;
  PanelResult.Visible:=IsChartEdit;
  {----------------Main Menu------------------------------}
  None1ChartMenu.Visible:= AllowEditChartMenu.Checked;
      {---------Linearization--------------------}
      { TODO : 161004 }
  LinearizationXChartMenu.Visible:=FlgLinVisible;//AllowEditChartMenu.Checked;
  LinearizationYChartMenu.Visible:=FlgLinVisible;//AllowEditChartMenu.Checked;
  NoneLineanizationChartMenu.Visible:=AllowEditChartMenu.Checked;
      {---------Linearization--------------------}
  EditLabelChartMenu.Visible:= AllowEditChartMenu.Checked;
  AddLabelChartMenu.Visible:= AllowEditChartMenu.Checked;
  CursorChartMenu.Visible:= AllowEditChartMenu.Checked;
//  ResultChartMenu.Visible:= AllowEditChartMenu.Checked;
{----------------Main Menu------------------------------}
{----------------PopUp Menu-----------------------------}
  None1ChartPopUpMenu.Visible:= AllowEditChartMenu.Checked;
     {---------Linearization--------------------}
      {080103}
  LinearizationXChartPopUpMenu.Visible:=FlgLinVisible;//Make non visible item AllowEditChartMenu.Checked;
  LinearizationYChartPopUpMenu.Visible:=FlgLinVisible;//Make non visible item AllowEditChartMenu.Checked;
  NoneLineanizationChartPopUpMenu.Visible:= AllowEditChartMenu.Checked;
     {---------Linearization--------------------}
  EditLabelChartPopUpMenu.Visible:= AllowEditChartMenu.Checked;
  CursorChartPopUpMenu.Visible:= AllowEditChartMenu.Checked;
//  ResultChartPopUpMenu.Visible:= AllowEditChartMenu.Checked;
{----------------PopUp Menu-----------------------------}
 { TODO : 160507 }
  if not(AllowEditChartMenu.Checked) then
   begin
    DeleteAllLabel;
    IsCursor:= false;
    CursorLabel.Visible:= false;
    Chart.Repaint;
  end;
end;//procedure TChartGraphica.AllowEditClick(Sender: TObject)

procedure TChartGraphica.CopyToFileClick(Sender: TObject);
var
  ActiveCanvas: TCanvas;
  Bitmap: TBitmap;
  Rect: TRect;
begin
  ActiveCanvas := TCanvas.Create;
  Bitmap := TBitmap.Create;
  ForceCurrentDirectory :=True;
  try
    ActiveCanvas.Handle := GetDC(Handle);
    Rect:=Bounds(0, 0, Width, Height);
    Bitmap.Width := ClientWidth;
    Bitmap.Height :=ClientHeight;
    Bitmap.Canvas.CopyRect(Rect, ActiveCanvas, Rect);
    Bitmap.SaveToFile(workdirectory+'\Screen.bmp'); { Сохраняем  экран в файл}
  finally
    FreeAndNil(Bitmap);
  end;
   if CopySaveDialog.execute then
    begin
     FileCopyStream(workdirectory+'\Screen.bmp',CopySaveDialog.FileName);
     // ReNameFile('Screen.bmp',CopySaveDialog.FileName+'.bmp')
   end;
end;//procedure CopyToFileClick(Sender: TObject);

procedure TChartGraphica.AddClick(Sender: TObject);
begin
  MaxLabelAdd:= MaxDxyLabel;
  LinearizationXChartPopUpMenu.Checked:= false;
  LinearizationYChartPopUpMenu.Checked:= false;
  IsLinearization:= false;
  if (IsCursor) and (CurrentLabelAdded<MaxLabelAdd) then
   begin
    AddLabel(ActiveSeries.XValues.Value[Cursor_index],ActiveSeries.YValues.Value[Cursor_index]);
    CreateShowResultList;
    Chart.RePaint;
  end;
end;//procedure AddClick(Sender: TObject);

procedure TChartGraphica.DeleteClick(Sender: TObject);
begin
  DeleteLabel(ActiveLabelNumber);
end;//procedure DeleteClick(Sender: TObject);

procedure TChartGraphica.DeleteAllClick(Sender: TObject);
var
  i: integer;
begin
  DeleteAllLabel;
  for i:= MaxDxyLabel downto 1 do   ResultLabelMassiv[i].Height:= 0;  //Hide All Result
  //if not(IsResultPanelVisible) then
  //   PanelResult.Width:= 0;
  RePaint;
end;//procedure DeleteAllClick(Sender: TObject);

procedure TChartGraphica.SetCursorClick(Sender: TObject);
begin
  if (ActiveSeries.YValues.Count>0) then
   begin
    IsCursor:= true;
    CursorPanel.Height:= CursorPanelHeight;
    CursorLabel.Visible:= true;
    Chart.Repaint;
   end;
    lb_Action.SetFocus;
end;//procedure SetCursorClick(Sender: TObject);

procedure TChartGraphica.DeleteCursorClick(Sender: TObject);
begin
  IsCursor:= false;
  CursorLabel.Visible:= false;
  CursorPanel.Height:= 0;
  Chart.Repaint;
end;//procedure DeleteCursorClick(Sender: TObject);

(*procedure TChartGraphica.ShowResultClick(Sender: TObject);
var
  i: integer;
begin
{ TODO : 251103 }
  for i:= 1 to MaxDxyLabel{9} do  ResultLabelMassiv[i].Height:= 0;
  CreateShowResultList;
  PanelResult.Width:= ResultWidth;
  IsResultPanelVisible:= true;
  ShowResultChartMenu.Checked:= true;
  ShowResultChartPopUpMenu.Checked:= true;
  HideResultChartMenu.Checked:= false;
  HideResultChartPopUpMenu.Checked:= false;
end;//procedure ShowResultClick(Sender: TObject);
*)
procedure TChartGraphica.AddLinearization(Sender: TObject);
begin
  DeleteAllClick(Sender);
  MaxLabelAdd:= MaxLinearizationLabel;
  IsLinearization:= true;
if (TMenuItem(Sender)=AddLinearizationXLabelChartPopUpMenu) then
begin
  LinearizationXChartPopUpMenu.Checked:= true;
  LinearizationYChartPopUpMenu.Enabled:=false;
end;
if (TMenuItem(Sender)=AddLinearizationYLabelChartPopUpMenu) then
begin
  LinearizationYChartPopUpMenu.Checked:= true;
  LinearizationXChartPopUpMenu.Enabled:=false;
end;
end;//procedure AddLinearization(Sender: TObject);

procedure TChartGraphica.SaveLinearizationX(Sender: TObject);
begin
 if (IsLinearization) then
  begin
    SaveLinearizationToFile('X');
    DeleteAllClick(Sender);
  end;
end;//procedure SaveLinearization(Sender: TObject);

procedure TChartGraphica.SaveLinearizationY(Sender: TObject);
begin
  if (IsLinearization) then
  begin
       SaveLinearizationToFile('Y');
       DeleteAllClick(Sender);
  end;
end;

procedure TChartGraphica.SetActiveSeries(Series: TLineSeries);
begin
  ActiveSeries:= Series;
end;

procedure TChartGraphica.SaveLinearizationToFile(const Direction:string);
var
  CurrentLabel: TChartLabel;
  Present: TDateTime;
  presentdate:string;
  sFile:string;
  Year, Month, Day, Hour, Minute, Sec, MSec: Word;
  FL:File;
  iniCSPM:TiniFile;
  PointNumb,i:integer;
  GridCell:integer;
  RealSens, InitSens, SensKoef:single;
  Xpos0:single;
begin
 sFile:=ScannerIniFilesPath +   ScannerIniFileX;// ChartScannerIniFile;
 if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    Rewrite(FL);
    CloseFile(FL);
  end;
//  SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
  begin
   PointNumb:=ReadInteger((HardWareOpt.ScannerNumb), Direction+'Points Number',0);
   if PointNumb<>0 then
   begin
    DeleteKey((HardWareOpt.ScannerNumb),Direction+'Points Number');
   for i:=1 to PointNumb do
    DeleteKey((HardWareOpt.ScannerNumb),Direction+IntToStr(i));
  end;
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minute, Sec, MSec);
  presentdate:=intTostr(day)+'-'+inttostr(month)+'-'+inttostr(year);
  try
   WriteString((HardWareOpt.ScannerNumb), 'Linearization Date',presentdate);
  except
     on IO: EInOutError do
        begin
            case IO.Errorcode  of
       104:  MessageDlg(NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_47' (* 'error write flash' *) ),mtWarning,[mbOk],0);
               end;
        end;
     else
       begin
         flgSaveProcess:=false;
         MessageDlg(NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_47' (* 'error write flash' *) ),mtWarning,[mbOk],0);
         iniCSPM.Free;
         exit;
        end;
  end;
  GridCell:=ReadInteger((HardWareOpt.ScannerNumb),'Grid Cell Size',4000);
  PointNumb:=1;
 if assigned(FirstChartLabel.next) then
  begin
    CurrentLabel:= FirstChartLabel.next;
    Xpos0:=CurrentLabel.x_pos;
   while assigned(CurrentLabel.next) do
    begin
      CurrentLabel:= CurrentLabel.next;
      inc(PointNumb);
    end;

  if Direction='X' then InitSens:= InitSensitiveX
                   else InitSens:= InitSensitiveY;
   SensKoef:=(PointNumb-1)*GridCell/(CurrentLabel.x_pos-Xpos0);
   RealSens:=InitSens*SensKoef;
   end;
   PointNumb:=1;
  if assigned(FirstChartLabel.next) then
  begin
    CurrentLabel:= FirstChartLabel.next;
   while assigned(CurrentLabel.next) do
    begin
      WriteString((HardWareOpt.ScannerNumb), Direction+IntToStr(PointNumb),
                  FloatToStrF((CurrentLabel.x_pos-Xpos0)*SensKoef,ffFixed,6,0));
      CurrentLabel:= CurrentLabel.next;
      inc(PointNumb);
    end;
 WriteString((HardWareOpt.ScannerNumb), Direction+IntToStr(PointNumb),
                                      FloatToStrF((CurrentLabel.x_pos-XPos0)*SensKoef,ffFixed,6,0));

 WriteInteger((HardWareOpt.ScannerNumb), Direction+'Points Number',PointNumb);

 WriteString((HardWareOpt.ScannerNumb),'Sensitiv'+Direction,FloatToStrF(RealSens,ffFixed,3,0));
  end;
end;
 finally
  iniCSPM.Free;
 end;
  //  SetFileAttribute_ReadOnly(sfile,true);
 sFile:=ScannerIniFilesPath +  ScannerIniFileY;
if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    Rewrite(FL);
    CloseFile(FL);
  end;
//  SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
  with iniCSPM do
  begin
   PointNumb:=ReadInteger((HardWareOpt.ScannerNumb), Direction+'Points Number',0);
   if PointNumb<>0 then
   begin
    DeleteKey((HardWareOpt.ScannerNumb),Direction+'Points Number');
   for i:=1 to PointNumb do
    DeleteKey((HardWareOpt.ScannerNumb),Direction+IntToStr(i));
   end;
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minute, Sec, MSec);
  presentdate:=intTostr(day)+'-'+inttostr(month)+'-'+inttostr(year);
 // To remember sensitivities of Linearization file
  WriteString((HardWareOpt.ScannerNumb), 'Linearization Date',presentdate);
  PointNumb:=1;
  if assigned(FirstChartLabel.next) then
  begin
    CurrentLabel:= FirstChartLabel.next;
   while assigned(CurrentLabel.next) do
    begin
      WriteString((HardWareOpt.ScannerNumb), Direction+IntToStr(PointNumb),
                  FloatToStrF((CurrentLabel.x_pos-Xpos0)*SensKoef,ffFixed,6,0));
      CurrentLabel:= CurrentLabel.next;
      inc(PointNumb);
    end;
   WriteString((HardWareOpt.ScannerNumb), Direction+IntToStr(PointNumb),
                  FloatToStrF((CurrentLabel.x_pos-Xpos0)*SensKoef,ffFixed,6,0));
   WriteInteger((HardWareOpt.ScannerNumb), Direction+'Points Number',PointNumb);
   WriteString((HardWareOpt.ScannerNumb),'Sensitiv'+Direction,FloatToStrF(RealSens,ffFixed,3,0));
  end;
end;
 finally
  iniCSPM.Free;
 end;
  //  SetFileAttribute_ReadOnly(sfile,true);
end;//procedure SaveLinearizationToFile;

(*procedure TChartGraphica.HideResultClick(Sender: TObject);
begin
  IsResultPanelVisible:= false;
  ShowResultChartMenu.Checked:= false;
  ShowResultChartPopUpMenu.Checked:= false;
  HideResultChartMenu.Checked:= true;
  HideResultChartPopUpMenu.Checked:= true;
end;//procedure HideResultClick(Sender: TObject);
*)
{-------------------------Main Menu Click--------------------------------------}

procedure TChartGraphica.SeriesActiveAfterAdd(Sender: TChartSeries;ValueIndex: Integer);
begin
  Cursor_index:= 0;
end;

procedure TChartGraphica.IsMouseInAllLabel(Const X,Y:integer);
var
  CurrentLabel: TChartLabel;
begin
  if (FirstChartLabel.number<>0) then
  begin
    CurrentLabel:= FirstChartLabel;  { TODO : 210607 }
    if (CurrentLabel.next<>nil) then
    Repeat
      CurrentLabel:= CurrentLabel.next;
      if (CurrentLabel.number mod 2 = 0) then
       begin
        if IsMouseInFirstLabel(CurrentLabel,X,Y) then  break;
       end else
          if IsMouseInSecondLabel(CurrentLabel,X,Y) then  break;
    Until (CurrentLabel.next=nil);
  end;
end;//procedure IsMouseInAllLabel(Const X,Y:integer);

function TChartGraphica.IsMouseInFirstLabel(ChartLabel: TChartLabel;Const X,Y:integer): boolean;
var
  koef_k,koef_b: double;
  x_pos,y_pos: integer;
begin
  x_pos:= Chart.BottomAxis.CalcXPosValue(ChartLabel.x_pos);
  y_pos:= Chart.LeftAxis.CalcYPosValue(ChartLabel.y_pos);
  koef_k:= -Chartdy/Chartdx;
  koef_b:= y_pos+Chartdy/2-koef_k*(x_pos-Chartdx/2);
  if ((koef_k*x-y+koef_b)<0) then
   begin
    koef_k:= Chartdy/Chartdx;
    koef_b:= y_pos+Chartdy/2-koef_k*(x_pos+Chartdx/2);
    if ((koef_k*x-y+koef_b)<0) then
     begin
      if (y_pos+Chartdy>y) then
      begin
        ActiveLabelNumber:= ChartLabel.number;
        DrawAllLabel();
        IsMouseInFirstLabel:= true;
      end
       else
        begin
         IsMouseInFirstLabel:= false;
        end;
    end
    else
     begin
      IsMouseInFirstLabel:= false;
     end;
  end
   else
    begin
     IsMouseInFirstLabel:=false;
    end;
end;//function IsMouseInFirstLabel


function TChartGraphica.IsMouseInSecondLabel(ChartLabel: TChartLabel;
  Const X,Y:integer): boolean;
var
  koef_k,koef_b: double;
  x_pos,y_pos: integer;
begin
  x_pos:= Chart.BottomAxis.CalcXPosValue(ChartLabel.x_pos);
  y_pos:= Chart.LeftAxis.CalcYPosValue(ChartLabel.y_pos);
  koef_k:= -Chartdy/Chartdx;
  koef_b:= y_pos+Chartdy/2-koef_k*(x_pos+Chartdx/2);
  if ((koef_k*x-y+koef_b)>0) then
  begin
    koef_k:= Chartdy/Chartdx;
    koef_b:= y_pos+Chartdy/2-koef_k*(x_pos+Chartdx/2);
    if ((koef_k*x-y+koef_b)>0) then
     begin
      if (y_pos-Chartdy<y) then
      begin
        ActiveLabelNumber:= ChartLabel.number;
        IsMouseInSecondLabel:= true;
        DrawAllLabel();
      end
     else
      begin
        IsMouseInSecondLabel:= false;
      end;
    end
     else
     begin
      IsMouseInSecondLabel:= false;
     end;
  end
  else
  begin
    IsMouseInSecondLabel:=false;
  end;
end;//function IsMouseInSecondLabel

procedure TChartGraphica.lb_ActionKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if (IsChartEdit) then Action(Round(Key));
end;

procedure TChartGraphica.DrawCursor(Const X,Y: integer);
begin
  Chart.Canvas.Pen.Color:= clBlack;//Teal;//clgreen;
  Chart.Canvas.Pen.Width:= 2;
  with Chart.Canvas do
  begin
    MoveTo(x-8,y);
    LineTo(x+8,y);
    MoveTo(x,y-8);
    LineTo(x,y+8);
  end;
  Chart.Canvas.Pen.Width:= 1;
end;//procedure DrawCursor(Const X,Y: integer);

procedure TChartGraphica.DrawLabel(ChartLabel: TChartLabel);
var
  x_pos,y_pos,dx: integer;
  OldBkMode:integer;
begin
  x_pos:= Chart.BottomAxis.CalcXPosValue(ChartLabel.x_pos);
  y_pos:= Chart.LeftAxis.CalcYPosValue(ChartLabel.y_pos);
  dx:=3;
  if ChartLabel.Number>=10 then dx:=5;
  with Chart.Canvas do
   begin
    Pen.Color:= clBlack;
   if (ChartLabel.number=ActiveLabelNumber) then    Brush.Color:= clLime
    else
      Brush.Color:= clAqua;
      Brush.Style:= bsSolid;
      Chart.Canvas.Font.Size:= 8;
 if IsLinearization then
   begin
      Polygon([Point(x_pos-Chartdx,y_pos+Chartdy),Point(x_pos+Chartdx,y_pos+Chartdy),Point(x_pos,y_pos)]);
                  OldBkMode := SetBkMode(Handle, TRANSPARENT);
                TextOut(x_pos-dx,y_pos+6,IntToStr(ChartLabel.number-1));
                 SetBkMode(Handle, OldBkMode);

    end
    else
      if (ChartLabel.number mod 2 = 0) then
      begin
        Polygon([Point(x_pos-Chartdx,y_pos+Chartdy),Point(x_pos+Chartdx,y_pos+Chartdy),Point(x_pos,y_pos)]);
                      OldBkMode := SetBkMode(Handle, TRANSPARENT);
                TextOut(x_pos-dx,y_pos+6,IntToStr(ChartLabel.number div 2));

                 SetBkMode(Handle, OldBkMode);
      end
       else
      begin //if not(if_label_down) then
        Polygon([Point(x_pos-Chartdx,y_pos-Chartdy),Point(x_pos+Chartdx,y_pos-Chartdy),Point(x_pos,y_pos)]);
                         OldBkMode := SetBkMode(Handle, TRANSPARENT);
                TextOut(x_pos-dx,y_pos-21,IntToStr(ChartLabel.number div 2));
                 SetBkMode(Handle, OldBkMode);
      end;
  end;
end;//procedure DrawLabel(Const x_in,y_in: integer; Series: TChartSeries);

procedure TChartGraphica.DrawAllLabel();
var CurrentLabel: TChartLabel;
begin
 if (FirstChartLabel.next<>nil) then
  begin
    CurrentLabel:= FirstChartLabel.next;
    while (CurrentLabel.next<>nil) do
    begin
      DrawLabel(CurrentLabel);
      CurrentLabel:= CurrentLabel.next;
    end;
    DrawLabel(CurrentLabel);
  end;
  if IsCursor then
   begin             { TODO : 210607 }
    if Cursor_index<ActiveSeries.XValues.count   then
    begin
      DrawCursor(Chart.BottomAxis.CalcXPosValue(ActiveSeries.XValues.Value[Cursor_index]),
                 Chart.LeftAxis.CalcYPosValue(ActiveSeries.YValues.Value[Cursor_index]));
      CursorLabel.FillLabel(ActiveSeries.XValues.Value[Cursor_index],
                            ActiveSeries.YValues.Value[Cursor_index],'x = ','z = ','',AxisXLabel.Caption,AxisYLabel.Caption);
    end;
   end;
end;//procedure DrawAllLabel();

procedure TChartGraphica.SetCurrentLabelAdded();
var
  CurrentLabel: TChartLabel;
begin
  CurrentLabel:= FirstChartLabel;
  while assigned(CurrentLabel.next) and (CurrentLabel.number+1=CurrentLabel.next.number) do
    CurrentLabel:= CurrentLabel.next;
  CurrentLabelAdded:= CurrentLabel.number+1;
  if (CurrentLabel=FirstChartLabel) and assigned(FirstChartLabel.next) then
    ActiveLabelNumber:= FirstChartLabel.next.number
  else
    ActiveLabelNumber:= CurrentLabelAdded-1;
end;//procedure SetCurrentLabelAdded();

procedure TChartGraphica.AddLabel(Const x,y: double);
var
  NewLabel,CurrentLabel: TChartLabel;
begin
  if (CurrentLabelAdded<MaxLabelAdd) then
  begin
    if (FirstChartLabel.number=0) then
     begin
      FirstChartLabel.number:= 1;
      new(NewLabel);
      FirstChartLabel.next:= NewLabel;
        NewLabel.x_pos:= x;   //Chart.BottomAxis.CalcPosPoint(x);
        NewLabel.y_pos:= y; //Chart.LeftAxis.CalcPosPoint(y);
        NewLabel.number:= 2;
        NewLabel.next:= nil;
      CurrentLabelAdded:= 3;
      ActiveLabelNumber:= 2;
    end
    else
    begin
      CurrentLabel:= FirstChartLabel;
      while assigned(CurrentLabel.next) and (CurrentLabel.next.number<=CurrentLabelAdded) do
        CurrentLabel:= CurrentLabel.next;
      if (CurrentLabel.next<>nil) then
      begin
        new(NewLabel);
        NewLabel.next:= CurrentLabel.next;
        CurrentLabel.next:= NewLabel;
        NewLabel.x_pos:=x; //Chart.BottomAxis.CalcPosPoint(x);
        NewLabel.y_pos:=y; //Chart.LeftAxis.CalcPosPoint(y);
        NewLabel.number:= CurrentLabelAdded;
        SetCurrentLabelAdded();
      end
      else
       begin
        new(NewLabel);
        CurrentLabel.next:= NewLabel;
        NewLabel.x_pos:=x; //Chart.BottomAxis.CalcPosPoint(x);
        NewLabel.y_pos:=y; // Chart.LeftAxis.CalcPosPoint(y);
        NewLabel.number:= CurrentLabelAdded;
        NewLabel.next:= nil;
        CurrentLabelAdded:= CurrentLabelAdded+1;
        ActiveLabelNumber:= NewLabel.number;
       end;
    end;
  end;
  Chart.Repaint;
end;//procedure AddLabel(Const x,y: double);

function TChartGraphica.DeleteLabel(Const number: integer): boolean;
var
  CurrentLabel,DeleteLabel: TChartLabel;
  IsDelete: boolean;
begin
  IsDelete:= false;
  if assigned(FirstChartLabel.next) then
   begin
    CurrentLabel:= FirstChartLabel;
    while (CurrentLabel.next.number<number) and (CurrentLabel.next<>nil) do
      CurrentLabel:= CurrentLabel.next;
    if (CurrentLabel.next.number=number) and assigned(CurrentLabel.next) then
     begin
      DeleteLabel:= CurrentLabel.next;
      CurrentLabel.next:=  DeleteLabel.next;
      SetCurrentLabelAdded;
      Dispose(DeleteLabel);
      IsDelete:= true;
    end;
  end;
  Chart.Repaint;
  CreateShowResultList;
  Result:= IsDelete;
end;//procedure DeleteLabel(Const x,y: double);

procedure TChartGraphica.DeleteAllLabel();
var
  NextLabel,CurrentLabel: TChartLabel;
  i: integer;
begin
  if assigned(FirstChartLabel.next) then
  begin
    CurrentLabel:= FirstChartLabel.next;
    FirstChartLabel.next:= nil;
    if (CurrentLabel.next=nil) then  Dispose(CurrentLabel)
    else
     begin
      while assigned(CurrentLabel.next) do
      begin
        NextLabel:= CurrentLabel.next;
        Dispose(CurrentLabel);
        CurrentLabel:= NextLabel;
      end;
      Dispose(CurrentLabel);
    end;
  end;
  CurrentLabelAdded:= 2;
  for i:= MaxDxyLabel downto 1 do  ResultLabelMassiv[i].Height:= 0;  //Hide All Result
  Chart.Repaint;
end;//procedure DeleteAllLabel();

procedure TChartGraphica.CreateShowResultList;
var
  CurrentLabel: TChartLabel;
  dx,dy: double;
  i: integer;
  IsPare: boolean;
begin
  if assigned(FirstChartLabel.next) then
  begin
    CurrentLabel:= FirstChartLabel.next;
    while (CurrentLabel.next<>nil) do
     begin
      if (CurrentLabel.number div 2 = CurrentLabel.next.number div 2) then
       begin
        dx:= CurrentLabel.next.x_pos - CurrentLabel.x_pos;
        dy:= CurrentLabel.next.y_pos - CurrentLabel.y_pos;
        ResultLabelMassiv[CurrentLabel.number div 2].FillLabel(abs(dx),abs(dy),'dx = ','dz = ','',AxisXLabel.Caption,AxisYLabel.Caption);
        ResultLabelMassiv[CurrentLabel.number div 2].Height:= 45;   //41
        CurrentLabel:= CurrentLabel.next;
      end
       else ResultLabelMassiv[CurrentLabel.number div 2].Height:= 0;
      if assigned(CurrentLabel.next) then CurrentLabel:= CurrentLabel.next;
    end;

    CurrentLabel:= FirstChartLabel;
    while assigned(CurrentLabel.next.next) do
      CurrentLabel:= CurrentLabel.next;
    if (CurrentLabel.number div 2 = CurrentLabel.next.number div 2) then
     begin
        dx:= CurrentLabel.next.x_pos - CurrentLabel.x_pos;
        dy:= CurrentLabel.next.y_pos - CurrentLabel.y_pos;
        ResultLabelMassiv[CurrentLabel.number div 2].FillLabel(abs(dx),abs(dy),'dx = ','dz = ','',AxisXLabel.Caption,AxisYLabel.Caption);
        ResultLabelMassiv[CurrentLabel.number div 2].Height:= 45; //41
      end else  ResultLabelMassiv[CurrentLabel.next.number div 2].Height:= 0;
  end;

  IsPare:= false;
  for i:= MaxDxyLabel downto 1 do
    if (ResultLabelMassiv[i].Height>0) then
    begin
      IsPare:= true;
      break;
    end;
    PanelResult.Width:= ResultWidth
end;//procedure CreateShowResultList;

procedure TChartGraphica.ChartClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X,Y: Integer);
var
  AddNumber: integer;
  dr: double;
begin
(*  if (Button=mbLeft) and (IsChartEdit) then
   begin
    AddNumber:= 0;
    dr:= sqrt(sqr(abs(Series.XValues.Value[0]-Chart.BottomAxis.CalcPosPoint(x)))+
              sqr(Series.YValues.Value[0]-Chart.LeftAxis.CalcPosPoint(y)));
    for i:= 0 to Series.XValues.Count-1 do
    begin
      if (sqrt(sqr(abs(Series.XValues.Value[i]-Chart.BottomAxis.CalcPosPoint(x)))+
               sqr(abs(Series.YValues.Value[i]-Chart.LeftAxis.CalcPosPoint(y))))<dr)
      then
       begin
        dr:= sqrt(sqr(abs(Series.XValues.Value[i]-Chart.BottomAxis.CalcPosPoint(x)))+
                  sqr(abs(Series.YValues.Value[i]-Chart.LeftAxis.CalcPosPoint(y))));
        AddNumber:= i;
      end;
    end;
    AddLabel(Series.XValues.Value[AddNumber],
             Series.YValues.Value[AddNumber]);
    if not(IsLinearization) then
      CreateShowResultList;
  end;
*)
end;//procedure ChartClickSeries

procedure TChartGraphica.ChartResize(Sender: TObject);
begin
  AxisXLabel.Left:= Chart.Width-35;
  AxisXLabel.Top:= Chart.Height-17;
end;//procedure TChartGraphica.ChartResize(Sender: TObject);

procedure TChartGraphica.ChartAfterDraw(Sender: TObject);
begin
  DrawAllLabel;
end;//procedure ChartAfterDraw

procedure TChartGraphica.ChartMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var flgAdd:boolean;
  i,AddNumber: integer;
  rmax,r,rmin:double;
begin
   rmax:=15;
  lb_Action.SetFocus;
 if (Button=mbLeft) and IsChartEdit then
  begin
    AddNumber:= 0;
    flgAdd:=false;
    rmin:=rmax;
    for i:= 0 to ActiveSeries.XValues.Count-1 do
    begin
     r:=(sqrt(sqr(abs(Chart.BottomAxis.CalcPosValue(ActiveSeries.XValues.Value[i])-x))+
               sqr(abs(Chart.LeftAxis.CalcPosValue(ActiveSeries.YValues.Value[i])-y))));
      if (r<rmin) and (r<rmax)  then
       begin
        rmin:= r;
        AddNumber:= i;
        flgAdd:=true;
      end;
    end;
  if flgAdd then AddLabel(ActiveSeries.XValues.Value[AddNumber],ActiveSeries.YValues.Value[AddNumber]);
   if not(IsLinearization) then  CreateShowResultList;
    IsMouseInAllLabel(X,Y);
    Chart.repaint;
 end;
end;//procedure ChartMouseDown
{------------------------ TChartGraphica --------------------------------------}

{-------------------------- TBasicChart ---------------------------------------}
constructor TBasicChart.Create(var AOwner: TComponent);
begin
  inherited Create(AOwner);
  Chart.OnMouseDown:= ChartMouseDown;
  Chart.OnMouseMove:= ChartMouseMove;
  Chart.OnMouseUp:= ChartMouseUp;
  IsFindLineActive:= false;
  IsMoving:= false;
  ActiveSeries.Pointer.Visible:=false;
  IsAutoDetection:= false;//true;
  {----------------Create Main Menu-----------------------}
  None2ChartMenu:= TMenuItem.Create(EditChartMenu);
    None2ChartMenu.Caption:= '-';
    None2ChartMenu.Visible:= false;
    EditChartMenu.Add(None2ChartMenu);
  EditFindLineChartMenu:= TMenuItem.Create(EditChartMenu);
    EditFindLineChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_63' (* 'Find Line' *) );
    EditFindLineChartMenu.Visible:= false;
    EditChartMenu.Add(EditFindLineChartMenu);
    ActiveFindLineChartMenu:= TMenuItem.Create(EditFindLineChartMenu);
      ActiveFindLineChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_64' (* 'Activate' *) );
      ActiveFindLineChartMenu.OnClick:= ActivateFindLineClick;
      EditFindLineChartMenu.Add(ActiveFindLineChartMenu);
    DeActiveFindLineChartMenu:= TMenuItem.Create(EditFindLineChartMenu);
      DeActiveFindLineChartMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_65' (* 'DeActivate' *) );
      DeActiveFindLineChartMenu.OnClick:= DeActivateFindLineClick;
      EditFindLineChartMenu.Add(DeActiveFindLineChartMenu);
  if IsAutoDetection then
    EditFindLineChartMenu.Enabled:= False;
  {----------------Create Main Menu-----------------------}
  {----------------Create PopUp Menu----------------------}
  None2ChartPopUpMenu:= TMenuItem.Create(EditChartPopUpMenu);
    None2ChartPopUpMenu.Caption:= '-';
    EditChartPopUpMenu.Items.Add(None2ChartPopUpMenu);

  EditFindLineChartPopUpMenu:= TMenuItem.Create(EditChartPopUpMenu);
    EditFindLineChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_63' (* 'Find Line' *) );
    EditFindLineChartPopUpMenu.Visible:= false;
    EditChartPopUpMenu.Items.Add(EditFindLineChartPopUpMenu);
    ActiveFindLineChartPopUpMenu:= TMenuItem.Create(EditFindLineChartPopUpMenu);
      ActiveFindLineChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_64' (* 'Activate' *) );
      ActiveFindLineChartPopUpMenu.OnClick:= ActivateFindLineClick;
      EditFindLineChartPopUpMenu.Add(ActiveFindLineChartPopUpMenu);
    DeActiveFindLineChartPopUpMenu:= TMenuItem.Create(EditFindLineChartPopUpMenu);
      DeActiveFindLineChartPopUpMenu.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_65' (* 'DeActivate' *) );
      DeActiveFindLineChartPopUpMenu.OnClick:= DeActivateFindLineClick;
      EditFindLineChartPopUpMenu.Add(DeActiveFindLineChartPopUpMenu);
  if IsAutoDetection then EditFindLineChartPopUpMenu.Enabled:= False;
  {----------------Create PopUp Menu----------------------}
end;//constructor TChartResonance.Create(var AOwner: TComponent);

destructor TBasicChart.Destroy();
begin
  {--------------Destroy Main Menu-------------------------}
  FreeAndNil(DeActiveFindLineChartMenu);
  FreeAndNil(ActiveFindLineChartMenu);
 //  EditFindLineChartMenu.Clear;   { TODO : 250907 }
   FreeAndNil(EditFindLineChartMenu);
   FreeAndNil(None2ChartMenu);
  {--------------Destroy Main Menu-------------------------}
  {--------------Destroy PopUp Menu------------------------}
   FreeAndNil(DeActiveFindLineChartPopUpMenu);
   FreeAndNil(ActiveFindLineChartPopUpMenu);
   FreeAndNil(EditFindLineChartPopUpMenu);
   FreeAndNil(None2ChartPopUpMenu);
  {--------------Destroy PopUp Menu------------------------}
  inherited Destroy;
end;//destructor TBasicChart.Destroy();

procedure TBasicChart.Action(Const Key: Integer);
var
  x: integer;
begin
  if not(IsFindLineActive) then  inherited Action(Key)
  else
   begin
    if not(IsAutoDetection) then
    begin
      x:=  Chart.BottomAxis.CalcXPosValue(FindLine_pos);
      Case Key of
        vk_home:begin
                  FindLine_pos:= ActiveSeries.MinXValue;
                  Chart.Repaint;
                  DoSetPriborParameters;
                end;//vk_home
        vk_end: begin
                 FindLine_pos:= ActiveSeries.MaxXValue;
                 Chart.Repaint;
                 DoSetPriborParameters;
                end;//vk_end
        vk_left:begin
                  x:= x-1;
                  if (Chart.BottomAxis.CalcPosPoint(x)>ActiveSeries.MinXValue) then
                  FindLine_pos:= Chart.BottomAxis.CalcPosPoint(x);
                  Chart.repaint;
                  DoSetPriborParameters;
                end;//vk_left
       vk_right:begin
                  x:= x+1;
                  if (Chart.BottomAxis.CalcPosPoint(x)<ActiveSeries.MaxXValue) then
                  FindLine_pos:= Chart.BottomAxis.CalcPosPoint(x);
                  Chart.repaint;
                  DoSetPriborParameters;
                end;//vk_right
     vk_Return: begin  //Enter
                  IsFindLineActive:= false;
                end;//Enter
      end;//Case Msg.wParam
    end;//if not(IsAutoDetection)
  end;//if Move FindLine
end;//procedure Action


procedure TBasicChart.DoSetPriborParameters;
begin
  if Assigned(FSetPriborParameters) then    FSetPriborParameters(Self);
end;//procedure TBasicChart.DoSetPriborParameters;

procedure TBasicChart.SeriesActiveAfterAdd(Sender: TChartSeries; ValueIndex: Integer);
begin
  inherited SeriesActiveAfterAdd(Sender,ValueIndex);
  FindLine_pos:= ActiveSeries.XValues.Value[0];
  Min_Y:=Chart.LeftAxis.minimum;     //081112 ActiveSeries.MinYValue
  Max_Y:= ActiveSeries.MaxYValue;
end;//procedure TBasicChart.ActiveSeriesAfterAdd

procedure TBasicChart.ChartAfterDraw(Sender: TObject);
begin
  inherited ChartAfterDraw(Sender);
  DrawFindLine;
end;//procedure TBasicChart.ChartAfterDraw(Sender: TObject);

procedure TBasicChart.DrawFindLine;
var
  x: integer;
begin
  if (Max_Y<>Min_Y) then
  begin
    x:= Chart.BottomAxis.CalcXPosValue(FindLine_pos);
    Chart.Canvas.Pen.Color:= clGreen;//clblue;
    Chart.Canvas.Pen.Width:= 2;
    with Chart.Canvas do
     begin
      MoveTo(x,Chart.LeftAxis.CalcYPosValue(Min_Y));     //081211   Min_Y
      LineTo(x,Chart.LeftAxis.CalcYPosValue(Max_Y));
      LineTo(x-8,Chart.LeftAxis.CalcYPosValue(Max_Y)-6);
      LineTo(x+8,Chart.LeftAxis.CalcYPosValue(Max_Y)-6);
      LineTo(x,Chart.LeftAxis.CalcYPosValue(Max_Y));
    end;
    Chart.Canvas.Pen.Width:= 1;
  end;
end;//procedure TBasicChart.DrawFindLine;

procedure TBasicChart.ChartMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lb_Action.SetFocus;
  if not(IsAutoDetection) and (Button=mbLeft) and
  (Y<Chart.LeftAxis.CalcYPosValue(Min_Y)) and
  (Y>Chart.LeftAxis.CalcYPosValue(Max_Y)) and
  (abs(Chart.BottomAxis.CalcXPosValue(FindLine_pos)-x)<NearLine) then
  begin
    IsMoving:= true;
    Chart.AllowZoom:= false;
    if (Chart.BottomAxis.CalcPosPoint(x)>ActiveSeries.MinXValue) then
      if (Chart.BottomAxis.CalcPosPoint(x)<ActiveSeries.MaxXValue) then
        FindLine_pos:= Chart.BottomAxis.CalcPosPoint(x);
    Chart.repaint;
  end//if FindLineSelected
  else
    inherited ChartMouseDown(Sender,Button,Shift,X,Y);
end;//procedure TBasicChart.ChartMouseDown

procedure TBasicChart.ChartMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if not(IsAutoDetection) and IsMoving then
   begin
    if (Chart.BottomAxis.CalcPosPoint(x)>ActiveSeries.MinXValue) then
      if (Chart.BottomAxis.CalcPosPoint(x)<ActiveSeries.MaxXValue) then
      begin
        FindLine_pos:= Chart.BottomAxis.CalcPosPoint(x);
      end;
    Chart.repaint;
  end;
end;//procedure TBasicChart.ChartMouseMove;

procedure TBasicChart.ChartMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not(IsAutoDetection) and IsMoving then
  begin
    if (Chart.BottomAxis.CalcPosPoint(x)>ActiveSeries.MinXValue) then
      if (Chart.BottomAxis.CalcPosPoint(x)<ActiveSeries.MaxXValue) then
       begin
        FindLine_pos:= Chart.BottomAxis.CalcPosPoint(x);
        DoSetPriborParameters;
      end;
    //Chart.AllowZoom:= true;
    IsMoving:= false;
    Chart.repaint;
  end;
end;//procedure TBasicChart.ChartMouseUp()

procedure TBasicChart.ChartClickSeries(Sender: TCustomChart; Series: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
begin
  if not(IsAutoDetection) and (Button=mbLeft) and
        (abs(Chart.BottomAxis.CalcXPosValue(FindLine_pos)-x)<NearLine) then
  begin
    {IsMoving:= true;
    Chart.AllowZoom:= false;
    if (Chart.BottomAxis.CalcPosPoint(x)>ActiveSeries.MinXValue) then
      if (Chart.BottomAxis.CalcPosPoint(x)<ActiveSeries.MaxXValue) then
        FindLine_pos:= Chart.BottomAxis.CalcPosPoint(x);
      Chart.repaint;}
  end
   else
    inherited ChartClickSeries(Sender,Series,ValueIndex,Button,Shift,X,Y);
end;//procedure TBasicChart.ChartClickSeries

procedure TBasicChart.AllowEditClick(Sender: TObject);
begin
  inherited AllowEditClick(Sender);
  {----------------Main Menu-----------------------}
  None2ChartMenu.Visible:= AllowEditChartMenu.Checked;
  EditFindLineChartMenu.Visible:= AllowEditChartMenu.Checked;
  {----------------Main Menu-----------------------}
  {----------------PopUp Menu----------------------}
  None2ChartPopUpMenu.Visible:= AllowEditChartMenu.Checked;
  EditFindLineChartPopUpMenu.Visible:= AllowEditChartMenu.Checked;
  {----------------PopUp Menu----------------------}
end;//procedure TBasicChart.AllowEditClick(Sender: TObject);

procedure TBasicChart.SetCursorClick(Sender: TObject);
var
  i: integer;
  dr: double;
begin
  //inherited SetCursorClick(Sender);
  cursor_index:= 0;
  if (ActiveSeries.YValues.Count>0) then
   begin
    dr:= abs(ActiveSeries.XValues.Value[0]-Findline_pos);
    for i:= 0 to ActiveSeries.XValues.Count-1 do
     begin
      if abs(ActiveSeries.XValues.Value[i]-Findline_pos)<dr then
       begin
        dr:= abs(ActiveSeries.XValues.Value[i]-Findline_pos);
         cursor_index:= i;
       end;
     end;
    IsCursor:= true;
    CursorPanel.Height:= CursorPanelHeight;
    CursorLabel.Visible:= true;
    Chart.Repaint;
   end;
  lb_Action.SetFocus;
  IsFindLineActive:= false;
end;//procedure TBasicChart.SetCursorClick(Sender: TObject);

procedure TBasicChart.ActivateFindLineClick(Sender: TObject);
begin
  IsFindLineActive:= true;
  lb_Action.SetFocus;
end;//procedure TBasicChart.ActivateFindLineClick

procedure TBasicChart.DeActivateFindLineClick(Sender: TObject);
begin
  IsFindLineActive:= false;
end;//procedure TBasicChart.DeActivateFindLineClick;

procedure TBasicChart.SetFindLine_pos(Const X: double);
begin
  if (X<ActiveSeries.MinXValue) then  FindLine_pos:= ActiveSeries.MinXValue
  else
  begin
    if (X>ActiveSeries.MaxXValue) then   FindLine_pos:= ActiveSeries.MaxXValue
                                  else   FindLine_pos:= X;
  end;
  DoSetPriborParameters;
end;//procedure TBasicChart.SetFindLine_pos(Const x: double);
{-------------------------- TBasicChart ---------------------------------------}

{------------------------ TChartResonance -------------------------------------}
constructor TChartResonance.Create(var AOwner: TComponent);
begin
  inherited Create(AOwner);
    cursorsaved:=Chart.OriginalCursor;
    Chart.Align:= alNone;
    BottomPanel:= TPanel.Create(Self);
    BottomPanel.Align:= albottom;
    BottomPanel.Parent:= Self;
    BottomPanel.Height:= 35;
    BottomPanel.BevelInner:= bvNone;
    BottomPanel.BevelOuter:= bvNone;
    BottomPanel.ParentColor:= false;
    BottomPanel.Color:=$00DCDDDB;// clSilver;//Gray;
    BottomPanel.PopupMenu:= EditChartPopUpMenu;
    FindLineLabel:= TLabel.Create(BottomPanel);
    FindLineLabel.Parent:= BottomPanel;
    FindLineLabel.AutoSize:= true;
    FindLineLabel.Font.Size:= 10;
    FindLineLabel.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_69' (* 'Frequency =' *) );
    FindLineLabel.Top:= 5;
    FindLineLabel.Left:=self.width div 5;//}100;
 //   FindLineLabel.Width:= 195;
    FindLineLabel.Height:= 20;
    FindLineLabel.PopupMenu:= EditChartPopUpMenu;
    FindLineEdit:= TLabel.Create(BottomPanel);
    FindLineEdit.Parent:= BottomPanel;
    FindLineEdit.Font.Size:= 9;
    FindLineEdit.Font.Color:=clRed;
    FindLineEdit.Font.Style:=[fsBold];
  //  FindLineEdit.Enabled:=false;
    FindLineEdit.Left:= FindLineLabel.Left+FindLineLabel.Width+10;
    FindLineEdit.Top:= 5;
    FindLineEdit.Height:= 18; FindLineEdit.width:=50;
    FindLineEdit.Color:= clWhite;
  //  FindLineEdit.OnKeyDown:= FindLineEditKeyDown;
    FindLineEdit.PopupMenu:= EditChartPopUpMenu;
    SetFindLineEditText;
    ValueFindLineLabel:= TLabel.Create(BottomPanel);
    ValueFindLineLabel.Parent:= BottomPanel;
    ValueFindLineLabel.Font.Size:= 9;
    ValueFindLineLabel.Top:= 5;
    ValueFindLineLabel.Height:= 18;
    ValueFindLineLabel.Left:= FindLineEdit.Left+FindLineEdit.Width+20;
    //ValueFindLineLabel.Color:= ;
    ValueFindLineLabel.PopupMenu:= PopUpMenu;
  //
     Qlabel:=TLabel.Create(BottomPanel);
     Qlabel.Parent:= BottomPanel;
     Qlabel.Font.Size:= 9;
     Qlabel.Top:= 5;
     Qlabel.Height:= 18;
     Qlabel.Left:= ValueFindLineLabel.Left+ValueFindLineLabel.Width+250;
  //
    Chart.Align:= alClient;
    Chart.Color:=$00DCDDDB;
   AllowEditChartPopUpMenu.Visible:=false;
   AllowEditChartMenu.Visible:=false;
   EditChartMenu.Visible:=false;
 //   EditChartPopUpMenu.Visible:=false;
end;//constructor TChartResonance.Create(var AOwner: TComponent);

destructor TChartResonance.Destroy();
var
  CurrentSeries: TSeriesList;
begin
   FreeAndNil(ValueFindLineLabel);
   FreeAndNil(FindLineEdit);
   FreeAndNil(FindLineLabel);
   FreeAndNil(BottomPanel);
   ActiveSeries:= nil;
  inherited Destroy;
end;//destructor TChartResonance.Destroy();

procedure TChartResonance.Action(Const Key: Integer);
begin
  inherited Action(Key);
  SetFindLineEditText;
end;//procedure TChartResonance.Action(Const Key: Integer);

procedure TChartResonance.DrawFindLine;
var
  x: integer;
begin
  if (Max_Y<>Min_Y) then
  begin
    x:= Chart.BottomAxis.CalcXPosValue(FindLine_pos);
    Chart.Canvas.Pen.Color:= clGreen;//clblue;
    Chart.Canvas.Pen.Width:= 2;
    with Chart.Canvas do
     begin
      MoveTo(x,Chart.LeftAxis.CalcYPosValue(0));     //081211   Min_Y
      LineTo(x,Chart.LeftAxis.CalcYPosValue(Max_Y));
      LineTo(x-8,Chart.LeftAxis.CalcYPosValue(Max_Y)-6);
      LineTo(x+8,Chart.LeftAxis.CalcYPosValue(Max_Y)-6);
      LineTo(x,Chart.LeftAxis.CalcYPosValue(Max_Y));
    end;
    Chart.Canvas.Pen.Width:= 1;
  end;
end;
procedure TChartResonance.ChartMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited ChartMouseDown(Sender,Button,Shift,X,Y);
  if IsMoving then
   begin
    SetFindLineEditText;
    Chart.OriginalCursor := crHandPoint;
    Application.processmessages;
   end;
end;//procedure TChartResonance.ChartMouseDown

procedure TChartResonance.ChartMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
  //inherited ChartMouseMove(Sender,Shift,X,Y);
  if not(IsAutoDetection) then
  if IsMoving then
   begin
    if (Chart.BottomAxis.CalcPosPoint(x)>ActiveSeries.MinXValue) then
      if (Chart.BottomAxis.CalcPosPoint(x)<ActiveSeries.MaxXValue) then
      begin
        FindLine_pos:= Chart.BottomAxis.CalcPosPoint(x);
        SetFindLineEditText;
        DoSetPriborParameters;
        Chart.Repaint;
      end;
  end
  else
  begin
   if (abs(Chart.BottomAxis.CalcXPosValue(FindLine_pos)-x)<NearLine)
      then Chart.OriginalCursor := crHandPoint
      else Chart.OriginalCursor := CursorSaved;
      Application.processmessages;
  end;;
end;//procedure TChartResonance.ChartMouseMove

procedure TChartResonance.ChartMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited ChartMouseUp(Sender,Button,Shift,X,Y);
  if not(IsMoving) then   SetFindLineEditText;
   { TODO : 090607 !!!!!!!!!!!!!!!!!!!!! problem  when click right button and close windows }
  if assigned(Chart) then Chart.OriginalCursor:=CursorSaved;
end;
//procedure TChartResonanceChartMouseUp

procedure TChartResonance.SeriesActiveAfterAdd(Sender: TChartSeries; ValueIndex: Integer);
begin
  inherited SeriesActiveAfterAdd(Sender,ValueIndex);
  FindLineEdit.caption:= FloatToStrF(FindLine_pos/1000,fffixed,8,2);
end;
//procedure TChartResonance.ActiveSeriesAfterAdd

procedure TChartResonance.FindLineEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Round(Key) of
    vk_return: begin //Enter
                SetFindLine_pos(strtofloat(FindLineEdit.Caption));
         //     FindLineEdit.SelStart:= Length(Text);
         //     FindLineEdit.SelText:='';
                SetFindLineEditText;
                Chart.Repaint;
              end;//Enter
          end;
end;


procedure TChartResonance.SetFindLineEditText;
var
  i:integer;
  y:single;
begin
  FindLineEdit.caption:=floattostrf(FindLine_pos/1000,fffixed,5,2)+NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_73' (* ' kHz' *) );
  i:= 0;
  while (i+1<ActiveSeries.Count-1) and (ActiveSeries.XValues[i+1]<FindLine_pos) do inc(i);
  if (ActiveSeries.Count>1) then
  begin
    y:= (ActiveSeries.YValues[i]+((FindLine_pos-ActiveSeries.XValues[i])/
              (ActiveSeries.XValues[i+1]-ActiveSeries.XValues[i]))*
              (ActiveSeries.YValues[i+1]-ActiveSeries.YValues[i]));
    ValueFindLineLabel.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_70' (* 'Probe Oscillation Amplitude= ' *) )+FloatToStrF(y,ffFixed ,5,3)+NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_71' (* ' V' *) );
    ValueFindLineLabel.hint:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_72' (* 'Probe Oscillation Amplitude V' *) );
    ValueFindLineLabel.showhint:=true;
  end;
  Application.ProcessMessages;
end;


procedure TChartResonance.SetFindLine_pos(Const X: double);
begin
  inherited SetFindLine_pos(X);
  SetFindLineEditText;
end;//procedure TChartResonance.SetFindLine_pos(Const x: double);
{------------------------ TChartResonance -------------------------------------}


{---------------------- TChartSpectrographi -----------------------------------}
constructor TChartSpectrographi.Create(var AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TChartSpectrographi.Destroy();
begin
  DeleteAllSeries;
  IsCursor:= false;
  inherited Destroy;
end;//destructor TChartSpectrographi.Destroy(); override;

procedure TChartSpectrographi.ChartMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited ChartMouseDown(Sender,Button,Shift,X,Y);
end;//procedure TChartResonance.ChartMouseDown

function TChartSpectrographi.AddSeries(SeriesColor: TColor = clred): TLineSeries;
var
  CurrentSeries, NewSeries: TSeriesList;
begin
  if (HeadSeriesList=nil) then
  begin
    new(NewSeries);
    NewSeries.next:= nil;
    NewSeries.Series:= TLineSeries.Create(Chart);
    Chart.AddSeries(NewSeries.Series);
    HeadSeriesList:= NewSeries;
    ActiveSeries:= NewSeries.Series;
    SetActiveSeries(NewSeries.Series);
  end
  else
  begin
    CurrentSeries:= HeadSeriesList;
    while assigned(CurrentSeries.next) do   CurrentSeries:= CurrentSeries.next;
    new(NewSeries);
    NewSeries.next:= nil;
    NewSeries.Series:= TLineSeries.Create(Chart);
    Chart.AddSeries(NewSeries.Series);
    CurrentSeries.next:= NewSeries;
    SetActiveSeries(NewSeries.Series);
  end;
  NewSeries.Series.SeriesColor:= SeriesColor;
  NewSeries.Series.OnAfterAdd:= SeriesActiveAfterAdd;
  AddSeries:= NewSeries.Series;
  NewSeries.Series.Pointer.Style:=psCircle;
  NewSeries.Series.Pointer.Visible:=false;
  NewSeries.Series.Pointer.VertSize:=2;
  NewSeries.Series.Pointer.HorizSize:=2;
  ActiveSeries.Pointer.Visible:=AllowEditChartMenu.Checked;
end;

function TChartSpectrographi.DeleteSeries(Series: TLineSeries): boolean;
var
  CurrentSeries, DelSeries: TSeriesList;
begin
  if assigned(HeadSeriesList) then
  begin
    CurrentSeries:= HeadSeriesList;
    if (CurrentSeries.Series=Series) then
    begin
      HeadSeriesList:= HeadSeriesList.next;
      if (CurrentSeries.Series=ActiveSeries) and (HeadSeriesList<>nil)then
       begin
        SetActiveSeries(HeadSeriesList.Series);
        SetMaxMinFindLine;
      end;
      if (HeadSeriesList=nil) then
      begin
        Max_Y:= 0;
        Min_Y:= 0;
      end;
      if   CurrentSeries.Series=FilterSeries then flgFilter:=false;
      DeleteAllLabel;
      Chart.RemoveSeries(CurrentSeries.Series);
     { TODO : 300507 }
      FreeAndNil(CurrentSeries.Series);
   //   CurrentSeries.Series.Destroy;
      Dispose(CurrentSeries);
      DeleteSeries:= true;
    end//series
    else
    begin
      if assigned(CurrentSeries.next) then
        while assigned(CurrentSeries.next.next) and (CurrentSeries.next.Series<>Series) do
          CurrentSeries:= CurrentSeries.next;
      if (CurrentSeries.next.Series=Series) then
       begin
        DelSeries:= CurrentSeries.next;
        if   DelSeries.Series=FilterSeries then flgFilter:=false;
        CurrentSeries.next:= DelSeries.next;
        DeleteAllLabel;
        Chart.RemoveSeries(DelSeries.Series); { TODO : 300507 }
        FreeAndNil(DelSeries.Series);//.Destroy;
        Dispose(DelSeries);
        DeleteSeries:= true;
        ActiveSeries:= CurrentSeries.Series;
        SetActiveSeries(CurrentSeries.Series);
        SetMaxMinFindLine;
      end
      else//there is no Series in List
        DeleteSeries:= false;
    end;
  end
  else//if HeadSeriesList=nil
    DeleteSeries:= false;
end;//function TChartSpectrographi.DeleteSeries(Series: TLineSeries): boolean;

procedure TChartSpectrographi.DeleteAllSeries;
var
  CurrentSeries: TSeriesList;
begin
 { TODO :  }
  DeleteAllLabel;
  Chart.RemoveAllSeries;
  if assigned(HeadSeriesList) then
   begin
    while assigned(HeadSeriesList.next) do
    begin
      CurrentSeries:= HeadSeriesList;
      HeadSeriesList:= HeadSeriesList.next; { TODO : 300507 }
      FreeAndNil(CurrentSeries.Series);//.Destroy;
      Dispose(CurrentSeries);
    end;
        { TODO : 300507 }
    FreeAndNil(HeadSeriesList.Series);//.Destroy;
    Dispose(HeadSeriesList);
     { TODO : 180507 }
    HeadSeriesList:=nil;
  end;
  ActiveSeries:= nil;
  FilterSeries:=nil;
end;//procedure TChartSpectrographi.DeleteAllSeries;

procedure TChartSpectrographi.ClearAllSeries;
var
  CurrentSeries: TSeriesList;
begin
  DeleteAllLabel;
  if assigned(HeadSeriesList) then
   begin
    CurrentSeries:= HeadSeriesList;
    while assigned(CurrentSeries.next) do
     begin
      CurrentSeries.Series.Clear;
      CurrentSeries:= CurrentSeries.next;
     end;
    CurrentSeries.Series.Clear;
  end;
end;//procedure TChartSpectrographi.ClearAllSeries;

procedure TChartSpectrographi.Action(Const Key: Integer);
begin
  inherited Action(Key);
end;


procedure TChartSpectrographi.SetActiveSeriesPred;
var
  CurrentSeries: TSeriesList;
begin
  if assigned(HeadSeriesList) then
   begin
    CurrentSeries:= HeadSeriesList;
    if assigned(CurrentSeries.next) and (HeadSeriesList.Series<>ActiveSeries) then
     begin
      while assigned(CurrentSeries.next.next) and (CurrentSeries.next.Series<>ActiveSeries)
                     do  CurrentSeries:= CurrentSeries.next;
      SetActiveSeries(CurrentSeries.Series);
      Chart.Repaint;
    end;
  end;
end;

procedure TChartSpectrographi.SetActiveSeriesNext;
var
  CurrentSeries: TSeriesList;
begin
  if assigned(HeadSeriesList) then
  begin
    CurrentSeries:= HeadSeriesList;
    CurrentSeries.Series.Pointer.Visible:=false;
    while assigned(CurrentSeries.next) and (CurrentSeries.Series<>ActiveSeries) do
    begin
     CurrentSeries:= CurrentSeries.next;
    end;
    if assigned(CurrentSeries.next) then
    begin
     SetActiveSeries(CurrentSeries.next.Series);
     CurrentSeries.next.Series.Pointer.Style:=psCircle;
     CurrentSeries.next.Series.Pointer.Visible:=true;
     Chart.Repaint;
    end;
  end;
end;

procedure TChartSpectrographi.SeriesActiveAfterAdd(Sender: TChartSeries; ValueIndex: Integer);
begin
  inherited SeriesActiveAfterAdd(Sender,ValueIndex);
  SetMaxMinFindLine;
end;

procedure TChartSpectrographi.SetMaxMinFindLine;
var
  CurrentSeries: TSeriesList;
begin
  if assigned(HeadSeriesList) then
   begin
    Max_y:= -MaxLongInt;
    Min_y:= MaxLongInt;
    CurrentSeries:= HeadSeriesList;
    while assigned(CurrentSeries.next) do
     begin
      if (Max_Y<CurrentSeries.Series.MaxYValue) then Max_Y:= CurrentSeries.Series.MaxYValue;
      if (Min_y>CurrentSeries.Series.MinYValue) then Min_Y:= CurrentSeries.Series.MinYValue;
      CurrentSeries:= CurrentSeries.next;
     end;
    //CurrentSeries.next=nil:
    if (Max_Y<CurrentSeries.Series.MaxYValue) then Max_Y:= CurrentSeries.Series.MaxYValue;
    if (Min_y>CurrentSeries.Series.MinYValue) then Min_Y:= CurrentSeries.Series.MinYValue;
  end;
end;

procedure TChartSpectrographi.SetCursorClick(Sender: TObject);
var
  i: integer;
  dr: double;
begin
  cursor_index:= 0;
  if (ActiveSeries.YValues.Count>0) then
   begin
    dr:= abs(ActiveSeries.XValues.Value[0]-Findline_pos);
    for i:= 0 to ActiveSeries.XValues.Count-1 do
     begin
      if abs(ActiveSeries.XValues.Value[i]-Findline_pos)<dr then
       begin
        dr:= abs(ActiveSeries.XValues.Value[i]-Findline_pos);
         cursor_index:= i;
       end;
     end;
    IsCursor:= true;
    CursorPanel.Height:= CursorPanelHeight;
    CursorLabel.Visible:= true;
    Chart.Repaint;
   end;
  lb_Action.SetFocus;
  IsFindLineActive:= false;
end;//procedure TBasicChart.SetCursorClick(Sender: TObject);

procedure TChartSpectrographi.CreateShowResultList;
var
  CurrentLabel: TChartLabel;
  dx,dy: double;
  i: integer;
  IsPare: boolean;
begin
  if assigned(FirstChartLabel.next) then
  begin
    CurrentLabel:= FirstChartLabel.next;
    while (CurrentLabel.next<>nil) do
     begin
      if (CurrentLabel.number div 2 = CurrentLabel.next.number div 2) then
       begin
        dx:= CurrentLabel.next.x_pos - CurrentLabel.x_pos;
        dy:= CurrentLabel.next.y_pos - CurrentLabel.y_pos;
        ResultLabelMassiv[CurrentLabel.number div 2].Height:=CursorPanelHeightSpectr;
        ResultLabelMassiv[CurrentLabel.number div 2].FillLabel(abs(dx),abs(dy),'dx = ','dy = ','dy/dx=',AxisXLabel.Caption,AxisYLabel.Caption);
        CurrentLabel:= CurrentLabel.next;
      end
       else ResultLabelMassiv[CurrentLabel.number div 2].Height:= 0;
      if assigned(CurrentLabel.next) then CurrentLabel:= CurrentLabel.next;
    end;

    CurrentLabel:= FirstChartLabel;
    while assigned(CurrentLabel.next.next) do
      CurrentLabel:= CurrentLabel.next;
    if (CurrentLabel.number div 2 = CurrentLabel.next.number div 2) then
     begin
        dx:= CurrentLabel.next.x_pos - CurrentLabel.x_pos;
        dy:= CurrentLabel.next.y_pos - CurrentLabel.y_pos;
        ResultLabelMassiv[CurrentLabel.number div 2].FillLabel(abs(dx),abs(dy),'dx = ','dy = ','dy/dx=',AxisXLabel.Caption,AxisYLabel.Caption);
        ResultLabelMassiv[CurrentLabel.number div 2].Height:= CursorPanelHeightSpectr;
      end else  ResultLabelMassiv[CurrentLabel.next.number div 2].Height:= 0;
  end;

  IsPare:= false;
  for i:= MaxDxyLabel downto 1 do
    if (ResultLabelMassiv[i].Height>0) then
    begin
      IsPare:= true;
      break;
    end;
  //if IsPare and IsResultPanelVisible then
    PanelResult.Width:= ResultWidth
  //else
  //  PanelResult.Width:= 0;
end;//procedure CreateShowResultList;



{---------------------- TChartSpectrographi -----------------------------------}
procedure TChartSpectrographi.SetFindLine_Pos(Const X: double);
begin
  inherited SetFindLine_pos(X);
  DrawFindLine;
  SetFindLineEditText;
//  Chart.RePaint;
end;

procedure TChartSpectrographi.FiltrAverage;
var
  i,m,n,k,imax:integer;
  x,sum:single;
  CurrentSeries: TSeriesList;
begin
 if assigned(HeadSeriesList) then
 begin
   m:=Chart.SeriesCount;
  if not assigned(FilterSeries) then
  begin
   AddSeries(clGreen);
   FilterSeries:=ActiveSeries;
  end
  else
  begin
   dec(m);
   FilterSeries.Clear;
   SetActiveSeries(FilterSeries);
  end;
  ActiveSeries.title:=NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_79' (* '  average' *) );
  CurrentSeries:=HeadSeriesList;
  n:=CurrentSeries.Series.Count;
  CurrentSeries:=CurrentSeries.next;
  k:=CurrentSeries.Series.Count;
  imax:=k;
  flgFilter:=true;
 if n<imax then imax:=n;
  for i:=0 to imax-1 do
  begin
    sum:=0;
    CurrentSeries:= HeadSeriesList;
    sum:=sum+CurrentSeries.Series.YValue[i];
    x:=CurrentSeries.Series.XValue[i];
    while assigned(CurrentSeries.next) do
    begin
     CurrentSeries:= CurrentSeries.next;
     if (CurrentSeries.Series<>FilterSeries) then
     begin
      sum:=sum+CurrentSeries.Series.YValue[i];
     end;
    end;
    sum:=sum/m;
    ActiveSeries.AddXY(x,sum);
   end;
  end;
end;

////// TChartSpectrographiV

constructor TChartSpectrographiV.Create(var AOwner: TComponent);
var i:integer;
begin
   inherited Create(AOwner);
  IsFindLineActive:= false;
  IsMoving:= false;
  IsAutoDetection:= false;
  FreeAndNil(ActiveSeries);//.Destroy;
  Chart.AllowZoom:=False;
  PanelResult.Visible:=false;
  BottomPanel.Visible:= false;
  AxisYLabel.Caption:=' ';
  AllowEditChartPopUpMenu.Visible:=true;
  AllowEditChartMenu.Visible:=true;
  EditChartMenu.Visible:=false;
end;

procedure TChartSpectrographiV.Action(Const Key: Integer);
begin
  inherited Action(Key);
(*  Case Key of
    vk_Prior: //Page Up
      SetActiveSeriesNext;
    vk_Next: //Page Down
      SetActiveSeriesPred;
  end;//Case Key of
*)
end;


procedure TChartSpectrographiV.ChartAfterDraw(Sender: TObject);
begin
   DrawAllLabel;
end;
procedure TChartSpectrographiV.CreateShowResultList;
var
  CurrentLabel: TChartLabel;
  dx,dy: double;
  i: integer;
  IsPare: boolean;
begin
  if assigned(FirstChartLabel.next) then
  begin
    CurrentLabel:= FirstChartLabel.next;
    while (CurrentLabel.next<>nil) do
     begin
      if (CurrentLabel.number div 2 = CurrentLabel.next.number div 2) then
       begin
        dx:= CurrentLabel.next.x_pos - CurrentLabel.x_pos;
        dy:= CurrentLabel.next.y_pos - CurrentLabel.y_pos;
        ResultLabelMassiv[CurrentLabel.number div 2].Height:=CursorPanelHeightSpectr;
        ResultLabelMassiv[CurrentLabel.number div 2].FillLabel(abs(dx),abs(dy),'dV = ','dI = ','dI/dV=',AxisXLabel.Caption,AxisYLabel.Caption);
        CurrentLabel:= CurrentLabel.next;
      end
       else ResultLabelMassiv[CurrentLabel.number div 2].Height:= 0;
      if assigned(CurrentLabel.next) then CurrentLabel:= CurrentLabel.next;
    end;

    CurrentLabel:= FirstChartLabel;
    while assigned(CurrentLabel.next.next) do
      CurrentLabel:= CurrentLabel.next;
    if (CurrentLabel.number div 2 = CurrentLabel.next.number div 2) then
     begin
        dx:= CurrentLabel.next.x_pos - CurrentLabel.x_pos;
        dy:= CurrentLabel.next.y_pos - CurrentLabel.y_pos;
        ResultLabelMassiv[CurrentLabel.number div 2].FillLabel(abs(dx),abs(dy),'dV = ','dI = ','dI/dV=',AxisXLabel.Caption,AxisYLabel.Caption);
        ResultLabelMassiv[CurrentLabel.number div 2].Height:= CursorPanelHeightSpectr;
      end else  ResultLabelMassiv[CurrentLabel.next.number div 2].Height:= 0;
  end;

  IsPare:= false;
  for i:= MaxDxyLabel downto 1 do
    if (ResultLabelMassiv[i].Height>0) then
    begin
      IsPare:= true;
      break;
    end;
  //if IsPare and IsResultPanelVisible then
    PanelResult.Width:= ResultWidth
  //else
  //  PanelResult.Width:= 0;
end;//procedure CreateShowResultList;


///////

constructor TChartSpectrographiZ.Create(var AOwner: TComponent);
begin
   inherited Create(AOwner);
  FreeAndNil(ActiveSeries);
  FreeAndNil(FilterSeries);
  Chart.AllowZoom:=False;
  PanelResult.Visible:=false;
  BottomPanel.Visible:= true;
 if not SpectrParams.flgIZ then FindLineLabel.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_80' (* 'Amplitude suppression= ' *) )
                           else FindLineLabel.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_81' (* 'Current = ' *) );
  ValueFindLineLabel.visible:=false;
  FindLineEdit.Left:= FindLineLabel.Left+FindLineLabel.Width+10;
  AxisYLabel.Caption:=' ';
  AllowEditChartPopUpMenu.Visible:=true;
  AllowEditChartMenu.Visible:=true;
  EditChartMenu.Visible:=false;
end;

procedure TChartSpectrographiZ.Action(Const Key: Integer);
begin
  inherited Action(Key);
(*  Case Key of
    vk_Prior: //Page Up
      SetActiveSeriesNext;
    vk_Next: //Page Down
      SetActiveSeriesPred;
  end;//Case Key of
*)
end;

procedure TChartSpectrographiZ.SetFindLineEditText;
var
  i:integer;
  y:single;
begin
  i:= 0;
  while (i+1<ActiveSeries.Count-1) and (ActiveSeries.XValues[i+1]<FindLine_pos) do   inc(i);
  if (ActiveSeries.Count>1) then
  begin
    y:= ActiveSeries.YValues[i];
   if not SpectrParams.flgIZ then  FindLineEdit.caption:=floattostrf((1-y),fffixed,5,2)
                             else  FindLineEdit.caption:=floattostrf(y,fffixed,5,2)
  end;
  Application.ProcessMessages;
end;

procedure TChartSpectrographi.SetActiveSeries(Series: TLineSeries);
begin
 if assigned(ActiveSeries) then
 begin
   ActiveSeries.LinePen.Width:= 1;
   ActiveSeries.Pointer.Visible:=false;
 end;
  ActiveSeries:= Series;
  ActiveSeries.LinePen.Width:= 2;
  ActiveSeries.Pointer.Visible:=true;
end;

procedure TChartSpectrographiZ.SetActiveSeries(Series: TLineSeries);
begin
  inherited;
    SetFindLineEditText;
end;

procedure TChartSpectrographiZ.DrawAllLabel();
var CurrentLabel: TChartLabel;
begin
 if (FirstChartLabel.next<>nil) then
  begin
    CurrentLabel:= FirstChartLabel.next;
    while (CurrentLabel.next<>nil) do
    begin
      DrawLabel(CurrentLabel);
      CurrentLabel:= CurrentLabel.next;
    end;
    DrawLabel(CurrentLabel);
  end;
  if IsCursor then
   begin             { TODO : 210607 }
    if Cursor_index<ActiveSeries.XValues.count   then
    begin
      DrawCursor(Chart.BottomAxis.CalcXPosValue(ActiveSeries.XValues.Value[Cursor_index]),
                 Chart.LeftAxis.CalcYPosValue(ActiveSeries.YValues.Value[Cursor_index]));
      CursorLabel.FillLabel(ActiveSeries.XValues.Value[Cursor_index],
                            ActiveSeries.YValues.Value[Cursor_index],'z = ','y = ','',AxisXLabel.Caption,AxisYLabel.Caption);
    end;
   end;
end;//procedure DrawAllLabel();
procedure TChartSpectrographiV.DrawAllLabel();
var CurrentLabel: TChartLabel;
begin
 if (FirstChartLabel.next<>nil) then
  begin
    CurrentLabel:= FirstChartLabel.next;
    while (CurrentLabel.next<>nil) do
    begin
      DrawLabel(CurrentLabel);
      CurrentLabel:= CurrentLabel.next;
    end;
    DrawLabel(CurrentLabel);
  end;
  if IsCursor then
   begin             { TODO : 210607 }
    if Cursor_index<ActiveSeries.XValues.count   then
    begin
      DrawCursor(Chart.BottomAxis.CalcXPosValue(ActiveSeries.XValues.Value[Cursor_index]),
                 Chart.LeftAxis.CalcYPosValue(ActiveSeries.YValues.Value[Cursor_index]));
      CursorLabel.FillLabel(ActiveSeries.XValues.Value[Cursor_index],
                            ActiveSeries.YValues.Value[Cursor_index],'V = ','I = ','',AxisXLabel.Caption,AxisYLabel.Caption);
    end;
   end;
end;//procedure DrawAllLabel();
procedure TChartSpectrographiZ.CreateShowResultList;
var
  CurrentLabel: TChartLabel;
  dx,dy: double;
  i: integer;
  IsPare: boolean;
begin
  if assigned(FirstChartLabel.next) then
  begin
    CurrentLabel:= FirstChartLabel.next;
    while (CurrentLabel.next<>nil) do
     begin
      if (CurrentLabel.number div 2 = CurrentLabel.next.number div 2) then
       begin
        dx:= CurrentLabel.next.x_pos - CurrentLabel.x_pos;
        dy:= CurrentLabel.next.y_pos - CurrentLabel.y_pos;
        ResultLabelMassiv[CurrentLabel.number div 2].Height:=CursorPanelHeightSpectr;
        ResultLabelMassiv[CurrentLabel.number div 2].FillLabel(abs(dx),abs(dy),'dz = ','dy = ','dy/dz=',AxisXLabel.Caption,AxisYLabel.Caption);
        CurrentLabel:= CurrentLabel.next;
      end
       else ResultLabelMassiv[CurrentLabel.number div 2].Height:= 0;
      if assigned(CurrentLabel.next) then CurrentLabel:= CurrentLabel.next;
    end;

    CurrentLabel:= FirstChartLabel;
    while assigned(CurrentLabel.next.next) do
      CurrentLabel:= CurrentLabel.next;
    if (CurrentLabel.number div 2 = CurrentLabel.next.number div 2) then
     begin
        dx:= CurrentLabel.next.x_pos - CurrentLabel.x_pos;
        dy:= CurrentLabel.next.y_pos - CurrentLabel.y_pos;
        ResultLabelMassiv[CurrentLabel.number div 2].FillLabel(abs(dx),abs(dy),'dz = ','dy = ','dy/dz=',AxisXLabel.Caption,AxisYLabel.Caption);
        ResultLabelMassiv[CurrentLabel.number div 2].Height:= CursorPanelHeightSpectr;
      end else  ResultLabelMassiv[CurrentLabel.next.number div 2].Height:= 0;
  end;

  IsPare:= false;
  for i:= MaxDxyLabel downto 1 do
    if (ResultLabelMassiv[i].Height>0) then
    begin
      IsPare:= true;
      break;
    end;
  //if IsPare and IsResultPanelVisible then
    PanelResult.Width:= ResultWidth
  //else
  //  PanelResult.Width:= 0;
end;//procedure CreateShowResultList;


(*procedure   TChartSpectrographiZ.FiltrAverage;
begin
   inherited  FiltrAverage;
end;
*)
constructor TChartSpectrographiTerra.Create(var AOwner: TComponent);
begin
   inherited Create(AOwner);
  FreeAndNil(ActiveSeries);
  FreeAndNil(FilterSeries);
  Chart.AllowZoom:=False;
  PanelResult.Visible:=false;
  BottomPanel.Visible:= true;
 if not SpectrParams.flgIZ then FindLineLabel.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_80' (* 'Amplitude suppression= ' *) )
                           else FindLineLabel.Caption:= NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_81' (* 'Current = ' *) );
  ValueFindLineLabel.visible:=false;
  FindLineEdit.Left:= FindLineLabel.Left+FindLineLabel.Width+10;
  AxisYLabel.Caption:=' ';
  AllowEditChartPopUpMenu.Visible:=true;
  AllowEditChartMenu.Visible:=true;
  EditChartMenu.Visible:=false;
end;



procedure TChartSpectrographiTerra.SetFindLineEditText;
var
  i:integer;
  y:single;
begin
  i:= 0;
  while (i+1<ActiveSeries.Count-1) and (ActiveSeries.XValues[i+1]<FindLine_pos) do   inc(i);
  if (ActiveSeries.Count>1) then
  begin
    y:= ActiveSeries.YValues[i];
   if not SpectrParams.flgIZ then  FindLineEdit.caption:=floattostrf((1-y),fffixed,5,2)
                             else  FindLineEdit.caption:=floattostrf(y,fffixed,5,2)
  end;
  Application.ProcessMessages;
end;

procedure TChartSpectrographiTerra.SetActiveSeries(Series: TLineSeries);
begin
  inherited;
    SetFindLineEditText;
end;
 procedure TChartSpectrographiTerra.SeriesActiveAfterAdd(Sender: TChartSeries; ValueIndex: Integer);
begin
//
end;
end.

