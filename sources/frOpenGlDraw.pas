//030309  correction section
unit frOpenGlDraw;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OpenGL, Menus, StdCtrls, ExtCtrls,Math,ClipBrd,
  GlobalType,GlobalScanDataType,CSPMVar,GlobalDcl, siComp, siLngLnk,uImageAnalysis;
 // цвет осей координат

 const str_s: string = ''; (*  s *) // TSI: Localized (Don't modify!)
 type
    TPtFrag=^FragGL;
    FragGL=record
          Frag:pointer;
          GLList:GLUint;
        end;
 // PrImgAnal=procedure(AOwner:TComponent;DataIn:ImageAnalysysDataIn);
//  PrStopAnal=procedure;
//  PrReceiveData=procedure(var Dataout:TMas2);
 type
   TfrmGL = class(TForm)
    MainMenu1: TMainMenu;
    View: TMenuItem;
    View3DTop: TMenuItem;
    View3D: TMenuItem;
    Tools1: TMenuItem;
    Filters1: TMenuItem;
    Median1: TMenuItem;
    GeoView: TMenuItem;
    Geo3DView: TMenuItem;
    Edit1: TMenuItem;
    FragmentCut: TMenuItem;
    PlaneDelete1: TMenuItem;
    SurfaceDelete1: TMenuItem;
    Undo1: TMenuItem;
    SectionCut: TMenuItem;
    ContrastMenu: TMenuItem;
    copytofile1: TMenuItem;
    CopySaveDialog: TSaveDialog;
    PopupMenuGL: TPopupMenu;
    PlaneDelete2: TMenuItem;
    SurfaceDelete2: TMenuItem;
    ContrastPopUp: TMenuItem;
    FileHeader1: TMenuItem;
    FileHeader2: TMenuItem;
    LevelDelete: TMenuItem;
    Undo2: TMenuItem;
    Average3x31: TMenuItem;
    Average3x32: TMenuItem;
    Stepsdelete1: TMenuItem;
    LevelDelete1: TMenuItem;
    StepsDelete2: TMenuItem;
    Zoom1: TMenuItem;
    zoom150: TMenuItem;
    zoom130: TMenuItem;
    zoom200: TMenuItem;
    zoom50: TMenuItem;
    FragmentCutPP: TMenuItem;
    SectionCutPP: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N4: TMenuItem;
    N8: TMenuItem;
    ToolsPanel: TMenuItem;
    Rule: TMenuItem;
    RulePP: TMenuItem;
    Angle: TMenuItem;
    ppZoom: TMenuItem;
    N501: TMenuItem;
    N1301: TMenuItem;
    N1501: TMenuItem;
    N2001: TMenuItem;
    AnglePP: TMenuItem;
    ImageAnalysis1: TMenuItem;
    ImageAnalysis2: TMenuItem;
    CopytoClipboard1: TMenuItem;
    Panel: TPanel;
    PanelGrd: TPanel;
    LabelMax: TLabel;
    LabelMin: TLabel;
    LabelMean: TLabel;
    PanelIm: TPanel;
    ImageGrGL: TImage;
    N9: TMenuItem;
    mSetPalette: TMenuItem;
    mLights: TMenuItem;
    mMaterial: TMenuItem;
    pLights: TMenuItem;
    pMaterial: TMenuItem;
    pSetPalette: TMenuItem;
    ZScale1: TMenuItem;
    ZScale2: TMenuItem;
    savesabmp1: TMenuItem;
    FourierFiltration1: TMenuItem;
    Rubber: TMenuItem;
    miAreaRubber: TMenuItem;
    miLineRubber: TMenuItem;
    RubberPP: TMenuItem;
    AreaRubberPP: TMenuItem;
    LineRubberPP: TMenuItem;
    Invert: TMenuItem;
    Invertpp: TMenuItem;
    siLangLinked1: TsiLangLinked;
    MirrorY: TMenuItem;
    MirrorYPp: TMenuItem;
    MirrorX: TMenuItem;
    MirrorXPP: TMenuItem;
    SaveasSPM: TMenuItem;
    procedure MirrorXClick(Sender: TObject);
    procedure MirrorYClick(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);  overload ;
    procedure FormResize(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure View3DClick(Sender: TObject);
    procedure View3DTopClick(Sender: TObject);
    procedure View2DGeoClick(Sender: TObject);
    procedure View3DGeoClick(Sender: TObject);
    procedure MeshClick(Sender: TObject);
    procedure CutFragmentClick(Sender: TObject);
    procedure CutSectionClick(Sender: TObject);
//filters
    procedure MedianClick(Sender: TObject);
    procedure Average3x3Click(Sender: TObject);
    procedure PlaneDeleteClick(Sender: TObject);
    procedure SurfaceDeleteClick(Sender: TObject);
    procedure LevelDeleteClick(Sender: TObject);
    procedure StepsXDeleteClick(Sender: TObject);
    procedure StepsYDeleteClick(Sender: TObject);
//
    procedure UndoClick(Sender: TObject);
    procedure ContrastClick(Sender: TObject);
    procedure CopyToFileClick(Sender: TObject);
    procedure FileHeaderClick(Sender: TObject);
    procedure Zoom150Click(Sender: TObject);
    procedure Zoom50Click(Sender: TObject);
    procedure Zoom130Click(Sender: TObject);
    procedure Zoom200Click(Sender: TObject);
    procedure mOptionDrawClick(Sender: TObject);
    procedure ToolsPanelClick(Sender: TObject);
    procedure RuleClick(Sender: TObject);
    procedure AngleClick(Sender: TObject);
    procedure ImageAnalysis1Click(Sender: TObject);
    procedure CopytoClipboard1Click(Sender: TObject);
    procedure mSetPaletteClick(Sender: TObject);
    procedure mLightsClick(Sender: TObject);
    procedure mMaterialClick(Sender: TObject);
    procedure ZScale1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure FourierFiltration1Click(Sender: TObject);
    procedure miAreaRubberClick(Sender: TObject);
    procedure miLineRubberClick(Sender: TObject);
    procedure InvertClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure SaveasSPMClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
 //   procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
 //     Shift: TShiftState; X, Y: Integer);
 private
    flgAction:boolean;
    flgInvert:boolean;
    LibAnalysisHandle:THandle;
    DC : HDC;
    hrc: HGLRC;
    lengthline:single;
    xrot,xrot0,yrot,yrot0,zrot,zrot0:  GLfloat;
    zmov,dx,dy: GLfloat;
    alf,scale:GLFloat;  { TODO : 100406 }
    TopoMin,TopoMax:GlFloat;
    XMin,XMax,YMin,YMax,ZMin,ZMax:GLFloat;                  //Value for drawing axies
    XMinIn,XMaxIn,YMinIn,YMaxIn,ZMinIn,ZmaxIn:GLFloat;     //Real Value
    listcount,linelistcount,quadlistcount:integer;
    ITCorGL:integer;  //IT correction coeffiecient
    CountAnglePoints:integer;
    flgFormActivateFirst:Boolean;
    FlgCube :Boolean;          //cube
    FlgAxes :Boolean;         // показывать ли ось
    FlgMouseDown,
    FlgMouseMove,
    FlgMouseUp,
    FlgQuad,FlgLine,
    FlgCut,FlgSection,
    FlgFirstMouseDown,
  //  DragFlag,
    FlgClose,
    FlgMirrorX,
    FlgMirrorY,
    FlgDirectionSection:Boolean;         //x- TRue;
    FlgNewLnRubberDraw,
    FlgNewArRubberDraw:Boolean;
    ClientX0,ClientY0,ClientHW,PanelGrdWidth:Integer;
    ZMaxGr,ZMinGr:integer;
    mend,nend: integer;
    NyStart,NyEnd,NxStart,NxEnd:integer;
    MouseXStart,MouseYStart,MouseXEnd,MouseYEnd,MouseXend2,MouseYEnd2:integer;
    TopoNorm,RealScaleNorm:single;
    ZScaleK:single;
    vLeft, vRight, vBottom, vTop, vNear, vFar : GLFloat;
    Xs,Ys,Xe,Ye,Ye2,Xe2:GLfloat;
    List:array of GLUint;
    LineList:array of GLUint;
    QuadList:array of GLUint;
    LRDistr, LGDistr, LBDistr:array[0..maxVal-1] of float;//0..1
    LXR,LYR,LXG,LYG,LXB,LYB:ArraySpline;
    LNRed,LNBlue,LNGreen:integer;
    Cyrilic:cardinal;
    base:GLuint;  //basefont list
    TopoUnitsX,TopoUnitsY,TopoUnitsZ:TSignalUnits;
    CursorSaved:Tcursor;
    STRINVERT:STRING;
//  procedure WMEXITSIZEMOVE(var message: TMessage); message WM_EXITSIZEMOVE;

 (*   wParam
Specifies which edge of the window is being sized. This parameter can be one of the following values.
WMSZ_BOTTOM
Bottom edge
WMSZ_BOTTOMLEFT
Bottom-left corner
WMSZ_BOTTOMRIGHT
Bottom-right corner
WMSZ_LEFT
Left edge
WMSZ_RIGHT
Right edge
WMSZ_TOP
Top edge
WMSZ_TOPLEFT
Top-left corner
WMSZ_TOPRIGHT
Top-right corner
lParam
Pointer to a RECT structure with the screen coordinates of the drag rectangle. To change the size or position of the drag rectangle, an application must change the members of this structure.
*)
    CountUndo:integer;
    procedure WMSizing(var Message: TMessage) ; message WM_SIZING;
//    procedure WMNCMOUSEMOVE(var Message: TMessage); message WM_NCMOUSEMOVE;
    procedure WMNCLButton(var Message: TMessage); message WM_NCLButtonDown;
    procedure CopyToClipboard;
    procedure GradientRect (FromRGB, ToRGB: TColor;Canvas:tcanvas;ZTop,ZBottom:integer);
    procedure SetGlWindows;
    procedure WMExitSizeMove(var Message: TMessage) ; message WM_EXITSIZEMOVE;
    procedure WMGetMinMaxInfo(var info:TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure SetDCPixelFormat (hdc : HDC);
    procedure Axes;
    procedure OutText (Litera : PansiChar);
    procedure InitMaterials;
    procedure Init;
    procedure DrawScene;
    procedure InitSurface;
    function  ReniShawCorrection:integer;
    procedure GradientLabels;
    procedure DrawSurface();
    procedure CutSection(Sender:Tobject);
    Procedure CutSurface(Sender:TObject);
    procedure Cube ();
    procedure Line(var ln:single);
    procedure LineA();
    procedure Quad();
    procedure NonVisibleLine();
    procedure GradientLine();
    procedure ScreenToSpace(xm,ym:GLFloat; var x,y:GLFloat);
    procedure SpaceToScreen(x,y:GLFloat; var xm,ym:GLFloat);
    procedure WMMOve(var Mes:TWMMove); message WM_Move;
    procedure CopyDataDrawToTopo;
    function  MouseIntoSPMImage(x,y:GlFloat):boolean;
    procedure LnRubberAction(var DataDraw:TData);
    procedure ArRubberAction(var DataDraw:TData);
    procedure SaveCurrentPict();
    procedure BuildFont(Const FontName:String; Const Height:Integer=-24; Width:Integer=0; Italic:Integer=0; Underline:Integer=0; Strikeout:Integer=0);
    procedure KillFontBase;
    procedure BuildCyrilicFont;

 protected
    procedure CreateParams(var Params:TCreateParams); override;
 public
    FileNameGL:string;
    PathFileNameGL:string;
    AddCaption:String;
    FlgRubber,FlgRule,FlgAngle,FlgRealScale,FlgModify:Boolean;
    FlgArRubber, FlgLnRubber:Boolean;
    FlgZZero:Boolean;
    FlgOneLineScan,FlgZStretch:Boolean;
    flgRenishawCorrected:Boolean;
    ColorMaterialGLW,
    PaletteIndexGLW,
    FlgView:integer;
  //  flgGlReadBlock:integer;
    flgGlReadBlock:integer;
    ZScaleP:integer;
    TrackBarR:integer;
    TrackBarL:integer;
    TopoSPM:TExperiment;
    ArFrmSectLoc:Tlist;    // list of section windows was born by this window
    ArFrmFragLoc:Tlist;    // list of fragment windows was born by this window
    ParentFragW:TfrmGL;    // fragment window  parent    if it is fragment
    PaletteNameGLW:string;
    front_mat_emission  : array[0..3] of GLfloat;
    front_mat_shininess : array[0..0] of GLfloat;
    front_mat_specular  : array[0..3] of GLfloat;
    front_mat_diffuse   : array[0..3] of GLfloat;
    front_mat_ambient   : array[0..3] of GLfloat;
    position0           : array[0..3] of GLfloat ;
    position1           : array[0..3] of GLfloat ;
    gl1ambient : Array [0..3]   of single;
    gl1diffuse : Array [0..3]   of single;
    DataDraw:TData;
 constructor Create(AOwner:TComponent;const FileNameIn:string;flgReadBlock:integer;
                           FlgView:integer; flgReniShawCorrection:boolean; var flgError:byte);
 procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
 procedure Contrast(Sender: TObject);
 procedure ScaleZ(Sender:Tobject);
 procedure OptionLight;
 procedure UpdatevMaterialOpt;
 procedure SaveAs(const FileName:string);
 procedure SaveAsASCII(const FileName:string);
 procedure SaveAsMDT(const FileName:string);
 procedure UserMessage (var Msg: TMessage); message wm_userfreelib;
 procedure Material(Sender: TObject);
 procedure PalletteGeo(Sender: TObject);
 procedure GetOriginXY(var x,y:integer);
 procedure ReDraw;
end;

 procedure SaveAsJPG(Nx, Ny : integer;var p:Tmas2); stdcall;
 procedure SaveAsBMP(Nx, Ny : integer;var p:Tmas2); stdcall;

// procedure CopyData(var DataDraw:TData; DataIn:TData);


// var  MakeAnalysis:PrImgAnal;
//      StopAnalysis:PrStopAnal;
//      ReceiveData:PrReceiveData;
var    ZContrMax, ZContrMin:GLFloat;
      PrevX,PrevY:Integer;
      ActiveGlW:TfrmGL;
      PtFrag:TPtFrag;
      flgContrastZ:boolean;


implementation

uses jpeg,GlobalFunction,GlobalVar,CreateMDTscan,uFileOp,SurFaceTools,frScanWnd,mMain,frHeader,Grids,
     frSectionDraw,frLightOption,frSetMaterialOpt, frScale, frSetPalette, frExperimParams,
     frReport, frDragFormToSave, frTools, RenishawVars, frRenishowDiagn;


{$R *.DFM}
const
   ColorAxes : Array[0..3] of GLFloat = (0.0, 0.0, 0.0, 0.5);
   id_Text = 1000;
   GLF_START_LIST = 1200;
   GLSECT_START_LIST =3000;
   GLQUAD_START_LIST =3100; //
   NMaxSect=10; //max number section
   D3=1;
   D3Top=2;
   D2Geo=3;
   D3Geo=4;
	strgl0: string = ''; (* OUT memory TopoSPM *)
	strgl1: string = ''; (* Close all Fragments of the Image! *)
	strgl2: string = ''; (* Library Load Error *)
	strg13: string = ''; (* It is not enough points. Increase a fragment. *)

var
 smooth              : boolean = TRUE;
 lighting            : boolean = TRUE;
 steprot,stepmov     : GLfloat;

procedure TfrmGL.BuildFont(Const FontName:String; Const Height:Integer=-24; Width:Integer=0;
                    Italic:Integer=0; Underline:Integer=0; Strikeout:Integer=0);
var font, oldfont: HFONT;                            // Windows Font ID
begin
 // base := glGenLists(96);                   // Storage For 96 Characters
  base:=glGenLists(255);
  //the rest is all WINDOWS calls
  font := CreateFont(Height,                            // Height Of Font
                     Width,                                                // Width Of Font
                     0,                                                           // Angle Of Escapement
                     0,                                                           // Orientation Angle
                     FW_BOLD,                                  // Font Weight
                     Italic,                                               // Italic
                     Underline,                                             // Underline
                     Strikeout,                                             // Strikeout
                     ANSI_CHARSET,                            // Character Set Identifier
                     OUT_TT_PRECIS,                      // Output Precision
                     CLIP_DEFAULT_PRECIS,                // Clipping Precision
                     ANTIALIASED_QUALITY,                       // Output Quality
                     FF_DONTCARE or DEFAULT_PITCH,// Family And Pitch
                     PChar(FontName));                               // Font Name

  oldfont:=SelectObject(DC, font);                // Selects The previous font
//  wglUseFontBitmaps(h_DC, 32, 96, base);// Builds 96 Characters Starting At Character 32
  wglUseFontBitmaps(DC, 0, 255, base);// Builds 96 Characters Starting At Character 32
  SelectObject(DC, oldfont);          // Put back the old font
  DeleteObject(font)                    // Delete the font we just created (we already have it in the Display list)
end;
procedure TfrmGL.KillFontBase;                                     // Delete The Font
begin
  glDeleteLists(base, 255);                               // Delete the 96 Characters
end;
procedure CutExtention(FileNameIn:string;var FileNameOut:string);
 var   ps:integer;
    point:string;
begin
  point:='.';
  ps:=Pos(point,FileNameIn);
  Delete(FileNameIn,Ps,(Length(FileNameIn)-Ps+1));
  FileNameOut:=FileNameIn;
end;

function GetError : String;
begin
 Case glGetError of
    GL_INVALID_ENUM      : Result := 'Неверный аргумент!';
    GL_INVALID_VALUE     : Result := 'Неверное значение аргумента!';
    GL_INVALID_OPERATION : Result := 'Неверная операция!';
    GL_STACK_OVERFLOW    : Result := 'Переполнение стека!';
    GL_STACK_UNDERFLOW   : Result := 'Потеря значимости стека!';
    GL_OUT_OF_MEMORY     : Result := 'Не хватает памяти!';
    GL_NO_ERROR          : Result := 'Нет ошибок.';
 end;
end;


procedure TfrmGL.CopyToClipboard;
var i:integer;
    h:HWND;
    bitmap:Tbitmap;
    x0,y0:integer;
    arrayformhide:array of boolean;
begin
 setlength(arrayformhide,Screen.Formcount);
try
     for  i := 0 to Screen.FormCount-1 do
         begin
            arrayformhide[i]:= Screen.Forms[i].visible;
            if  Screen.Forms[i].Formstyle=fsStayOnTop then Screen.Forms[i].Hide;
         end;
    h:=findwindow(PChar('TImgAnalysWnd'),nil);
    if h<>0 then ShowWindow(h, SW_HIDE);
      x0:= screen.workarealeft+10;
      y0:=(Screen.workareaheight div 2) -(height div 2);
  if (left<(screen.workarealeft+10))
            or ((Top+height)>(Screen.workareatop+Screen.workareaheight)) then
      SetWindowPos(self.handle,HWND_TOP,x0,y0,Width,Height,SWP_SHOWWINDOW);
   Application.ProcessMessages;
     { TODO : 200607 }
  DC:=GetDC(handle);
   wglMakeCurrent(DC, hrc);
   InvalidateRect(Handle, nil, False);
  ReleaseDC(handle,DC);
  Application.ProcessMessages;
  { TODO : 101107 }
  Sleep(1000);
  bitmap:=TBitmap.Create;
 try
  bitmap.Width:=ClientWidth;
  bitmap.Height:=ClientHeight;
  with bitmap.Canvas do CopyRect(ClientRect,Canvas,ClientRect);
  ClipBoard.Assign(bitmap);
  if assigned(ReportForm) then   BringWindowToTop(ReportForm.handle);
  application.ProcessMessages;
  for  i := 0 to Screen.FormCount-1 do
           begin
             if  (Screen.Forms[I].Formstyle=fsStayOnTop) and   arrayformhide[i] then Screen.Forms[I].Show;
           end;
  if h<>0 then ShowWindow(h, SW_RESTORE);
  finally
  FreeAndNil(bitmap)
 end;
finally
   Finalize(arrayformhide);
end;
end;

procedure TfrmGL.SetGLWindows;
var H,W:integer;
begin
 H:=ClientHeight;
 W:=ClientWidth-Panel.Width;
// if FlgView=D2GEO then W:=ClientWidth-Panel.Width else W:=ClientWidth;
 if H < W then
  begin
   ClientX0:=round((W-H)*0.5);
   ClientY0:=0;
   ClientHW:=H;
  end
 else
  begin
    ClientX0:=0;
    ClientY0:=round((H-W)*0.5);
    ClientHW:=W;
  end;
end;
procedure TfrmGL.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
  InitParametersAxes;
  GradientLabels;
  Application.ProcessMessages;
  UpdateStrings;
end;

procedure TfrmGL.ReDraw;
var ImFileNameOut,FileName:string;
begin
   DC:=GetDC(handle);
    inc(CountUndo);       //???
    new(PntFileName);
    fileName:=ExtractFileName( FileNameGL);
    CutExtention(FileName,ImFileNameOut);
    PntFileName^.FileName:=TempDirectory+ImFileNameOut+IntToStr(CountUndo)+'.tmp';
    TopoSPM.ArFileNameEdit.Add(PntFileName);
    TopoSPM.ImFileName:=PntFileName^.FileName;
    TopoSPM.WorkFileName:=PntFileName^.FileName;
    TopoSpm.SaveExperiment;
    InitSurface;
    flgModify:=true;
    InvalidateRect(Handle, nil, False);
    GradientLabels;
    CopyDataDrawToTopo;
  ReleaseDc(Handle,DC);
 end;

procedure SaveAsBMP(Nx, Ny : integer;var p:Tmas2);
var
   i,old_top,old_left:integer;
   h:hwnd;
   x0,y0:integer;
   arrayformhide:array of Tform;
   bmp:Tbitmap;
   Hd: HDC;
   ClientOriginPoint:TPoint;
   ClientSource:TRect;
begin
     old_Top:= ActiveGLW.Top;
    old_Left:= ActiveGLW.Left;
    setlength(arrayformhide,Screen.Formcount);
try
  for  i := 0 to Screen.FormCount-1 do
         if  (Screen.Forms[i].Formstyle=fsStayOnTop) and Screen.Forms[i].visible then
            begin
             arrayformhide[i]:= Screen.Forms[i];
             Screen.Forms[i].Hide;
           end;
    ActiveGLW.Top:= 0;
    ActiveGLW.Left := 0;
  Application.ProcessMessages;

  Sleep(1000);

try
  bmp := TBitmap.Create;
  bmp.Width  := ActiveGLW.clientWidth;
  bmp.Height := ActiveGLW.clientHeight;

  hd := GetWindowDC(GetDesktopWindow);

  ClientOriginPoint:=ActiveGLW.ClientOrigin;

  Windows.GetClientRect(ActiveGLW.handle, ClientSource);

  BitBlt(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, hd, ClientOriginPoint.x+ClientSource.Left,ClientOriginPoint.y+ClientSource.Top, SRCCOPY);

  finally
    ReleaseDC(0, hd);
    Bmp.SaveToFile(ActiveGLW.PathFileNameGL{workdirectory}+'\'+ActiveGLW.caption+'.bmp');
    FreeAndNil(bmp);
  end;

  //restore

    ActiveGLW.Top:= old_top;
    ActiveGLW.Left:= old_left;
    Application.processmessages;
   //
    for  I := 0 to length(arrayformhide)-1 do
           begin
            if assigned( arrayformhide[i]) then  arrayformhide[i].Show;
           end;

  if assigned(ReportForm) then   BringWindowToTop(ReportForm.handle);
  if h<>0 then ShowWindow(h, SW_RESTORE);
   Application.processmessages;
 finally
  Finalize(arrayformhide);
 end;
end;

procedure SaveAsJPG(Nx, Ny : integer;var p:Tmas2);
var
   i,old_top,old_left:integer;
   h:hwnd;
   x0,y0:integer;
   arrayformhide:array of Tform;
   bmp:Tbitmap;
   jp:TJpegImage;
   Hd: HDC;
   ClientOriginPoint:TPoint;
   ClientSource:TRect;
begin
     old_Top:= ActiveGLW.Top;
    old_Left:= ActiveGLW.Left;
    setlength(arrayformhide,Screen.Formcount);
try
  for  i := 0 to Screen.FormCount-1 do
         if  (Screen.Forms[i].Formstyle=fsStayOnTop) and Screen.Forms[i].visible then
            begin
             arrayformhide[i]:= Screen.Forms[i];
             Screen.Forms[i].Hide;
           end;
    ActiveGLW.Top:= 0;
    ActiveGLW.Left := 0;
  Application.ProcessMessages;

  Sleep(1000);

try
  bmp := TBitmap.Create;
  bmp.Width  := ActiveGLW.clientWidth;
  bmp.Height := ActiveGLW.clientHeight;

  hd := GetWindowDC(GetDesktopWindow);

  ClientOriginPoint:=ActiveGLW.ClientOrigin;

  Windows.GetClientRect(ActiveGLW.handle, ClientSource);

  BitBlt(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, hd, ClientOriginPoint.x+ClientSource.Left,ClientOriginPoint.y+ClientSource.Top, SRCCOPY);

  finally
    ReleaseDC(0, hd);
    jp := TJpegImage.Create;
           try
             with jp do
              begin
               Assign(Bmp);
               SaveToFile(ActiveGLW.PathFileNameGL{workdirectory}+'\'+ActiveGLW.caption+'.jpg');
              end;
           finally
             FreeAndNil(jp);
           end;
    FreeAndNil(bmp);
  end;

  //restore

    ActiveGLW.Top:= old_top;
    ActiveGLW.Left:= old_left;
    Application.processmessages;
   //
    for  I := 0 to length(arrayformhide)-1 do
           begin
            if assigned( arrayformhide[i]) then  arrayformhide[i].Show;
           end;

  if assigned(ReportForm) then   BringWindowToTop(ReportForm.handle);
  if h<>0 then ShowWindow(h, SW_RESTORE);
   Application.processmessages;
 finally
  Finalize(arrayformhide);
 end;
end;

procedure TfrmGL.GradientLabels;
var     decim:integer;
begin
  decim:=0;
  if ZmaxIn<2 then decim:=1;
   LabelMax.Caption:=FloatTostrF(ZMaxIn/TopoUnitsZ.coef,ffFixed,5,decim)+''+TopoUnitsZ.text;
   LabelMin.Caption:=FloatTostrF(ZMinIn/TopoUnitsZ.coef,ffFixed,5,decim)+''+TopoUnitsZ.text;
   LabelMean.Caption:=FloatTostrF((ZMaxIn+ZMinIn)*0.5/TopoUnitsZ.coef,ffFixed,5,decim);
end;

procedure TfrmGL.GradientRect (FromRGB, ToRGB: TColor;Canvas:tcanvas;ZTop,ZBottom:integer);
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
  h0:=(Canvas.ClipRect.Bottom-Canvas.ClipRect.Top);
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
   for i := 0 to $ff do
     begin
      { calculate color band's top and bottom coordinates}
      ColorBand.Top :=iL+h -MulDiv (I , h, $100);
      ColorBand.Bottom :=iL+h -MulDiv (I+ 1,h, $100);
      { calculate color band color}
       R :=  (RGBFrom[0] + MulDiv (round(255*LRDistr[I]), RGBDiff[0], $ff));
       G :=  (RGBFrom[1] + MulDiv (round(255*LGDistr[I]), RGBDiff[1], $ff));
       B :=  (RGBFrom[2] + MulDiv (round(255*LBDistr[I]), RGBDiff[2], $ff));
       { select brush and paint color band}
       Canvas.Brush.Color := RGB (R, G, B);
       Canvas.FillRect (ColorBand);
     end;
       R:=round(255*RDistr[MaxVal]);
       G:=round(255*GDistr[Maxval]);
       B:=round(255*BDistr[MaxVal]);
       Canvas.Brush.Color := RGB (R, G, B);
//       Canvas.Brush.Color :=$00FFFFFF;
       Canvas.FillRect (WhiteBand);
       R:=round(255*RDistr[1]);
       G:=round(255*GDistr[1]);
       B:=round(255*BDistr[1]);
       Canvas.Brush.Color := RGB (R, G, B);
(*
       Canvas.Brush.Color :=$00FFFFFF;
       Canvas.FillRect (WhiteBand);
       Canvas.Brush.Color :=$00000000;
 *)
       Canvas.FillRect (BlackBand);

end;



procedure TfrmGL.PalletteGeo(Sender: TObject);
var i:integer;
begin
// PaletteIndexGLW:= InitPalIndex;
 PaletteNameGLW:=PaletteName;
 LNRed:=NRed;
 LNBlue:=NBlue;
 LNGreen:=NGreen;
for i:=1 to NRed do
begin
 LXR[i]:=XR[i];
 LYR[i]:=YR[i];
end;
for i:=1 to NGreen do
begin
 LXG[i]:=XG[i];
 LYG[i]:=YG[i];
end;
for i:=1 to NBlue do
begin
 LXB[i]:=XB[i];
 LYB[i]:=YB[i];
end;
 for i:=1 to MaxVal do
   begin
     LRDistr[i-1]:=RDistr[i];
     LGDistr[i-1]:=GDistr[i];
     LBDistr[i-1]:=BDistr[i];
   end;
  DC:=GetDC(handle);
   wglMakeCurrent(DC, hrc);
   InitSurface{(DataDraw)};
   InvalidateRect(Handle, nil, False);    //refresh
   wglMakeCurrent(0,0);
  ReleaseDc(Handle,DC);
            case flgView of
     D3:   begin View3DGeoClick(Sender);    end;
     D3Top:begin View2DGeoClick(Sender)     end;
                end;
if  flgView=D2Geo then  GradientRect (FromRGB, ToRGB,ImageGrGl.Canvas,ZMinGr,ZMaxGr);
end;

procedure TfrmGL.SaveAs(const FileName:string);
begin
 TopoSpm.WorkFileName:=FileName;
 TopoSpm.MainRcd.flags:=word(flgModify);
 TopoSpm.SaveExperiment;
end;


procedure TfrmGL.SaveAsASCII(const FileName:string);
var Fl:TextFile;
    s:STRING;
    i,j:integer;
    Year, Month, Day, Hour, Minut, Sec, MSec: Word;
    Present: TDateTime;
    presentdate:string;
begin
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minut, Sec, MSec);
  presentdate:=intTostr(day)+'.'+inttostr(month)+'.'+inttostr(year);

    AssignFile(Fl, FileName);
    ReWrite(Fl);
    S:='File Format = ASCII';
    Writeln(Fl, S);
    S:= 'Created by NanoEducatorLE, NT-SPb, lmt. '+presentdate ;
    Writeln(Fl, S);
    S:='File: '+FileName;
    Writeln(Fl, S);
    Writeln(Fl, 'NX = ',DataDraw.Nx);
    Writeln(Fl, 'NY = ',DataDraw.Ny);
    Writeln(Fl, Format('Scale X = %5.2f',[DataDraw.XStep]));
    Writeln(Fl, Format('Scale Y = %5.2f',[DataDraw.YStep]));
    Writeln(Fl, Format('Scale Data = %5.2f',[DataDraw.ZStep]));
    Writeln(Fl, 'Bias X = 0,0');
    Writeln(Fl, 'Bias Y = 0,0');
    Writeln(Fl, 'Bias Data = ',0);
    Writeln(Fl, 'Unit X = ', DataDraw.CaptionX);
    Writeln(Fl, 'Unit Y = ',DataDraw.CaptionY);
    Writeln(Fl, 'Unit Data = ',DataDraw.CaptionZ);
    Writeln(Fl,  'Start of Data : ');

    for i:=0 to DataDraw.Ny-1 do
    begin
     for j:=0 to DataDraw.Nx-1 do
        Write(Fl, DataDraw.data[j,i],' ');
     writeln(Fl);
    end;
    CloseFile(Fl);
end;
procedure TfrmGL.SaveAsMDT(const FileName:string);
var  scan:MDTscanCreate;
     i,j:integer;
     nx,ny,total:integer;
     data : Pointer;
     temp : ^Int16;
     min,max:integer;
begin
    nx := DataDraw.Nx;
    ny := DataDraw.Ny;
    total := nx*ny;
    GetMem(data, total*sizeof(Int16));
    temp := data;
    min :=  DataDraw.data[0,0];
    max := min;
    for i:=0 to ny-1 do
      for j:=0 to nx-1 do
      begin
       temp^ := DataDraw.data[j,i];
       if min >temp^ then min := temp^;
       if max <temp^ then max := temp^;
       Inc(Temp);
      end;
     scan:= MDTscanCreate.Create(nx,ny,0,0,0,
      DataDraw.XStep,DataDraw.YStep,DataDraw.ZStep,
      DataDraw.CaptionX,DataDraw.CaptionY,
      DataDraw.CaptionZ,data);
     scan.SaveToFile(FileName);
     scan.free;
     FreeMem(data);
end;


procedure TfrmGL.SaveasSPMClick(Sender: TObject);
begin
 Main.ActionSaveAsExecute(sender);
end;

procedure TfrmGL.UserMessage (var Msg: TMessage);
begin
 case Msg.WParam of
0:begin
   if assigned(ImageTools) then ImageTools.SpeedBtnData.enabled:=true;
    ImageAnalysis1.enabled:=true;
    ImageAnalysis2.enabled:=true;
    Application.ProcessMessages;
    FreeLibrary(LibAnalysisHandle);
    LibAnalysisHandle:=0;
   end;
1: begin
     DC:=GetDC(handle);
      ReceiveData(DataDraw.data);
      flgModify:=true;
      InitSurface{{DataDraw)};
      InvalidateRect(Handle, nil, False);
     ReleaseDc(Handle,DC);
   end;
2: begin
     FlgImgAnalysDrag:=True;
     Panel.BeginDrag(False);
    if assigned(ReportForm) then   BringWindowToTop(ReportForm.handle);
    end;
      end;
end;

procedure TfrmGL.CreateParams(var Params:TCreateParams);
begin
 inherited CreateParams(Params);
//Params.Style:=Params.Style  WS_MaximizeBox;
end;
procedure  TfrmGL.WMMOve(var Mes:TWMMove);
begin
   if Mes.YPos<(Main.ToolBarMain.Height div 2) then Top:=5;
(*   if assigned(ReportForm) then
    if  getkeystate(VK_Menu)<0  then
    begin
           flgDragForm:=true;
           if Assigned(ReportForm) then
             begin
               Panel.BeginDrag(False);
               Main.CopyToClipBoardExecute(self);
              end;
             flgDragForm:=false;
    end
    else Panel.EndDrag(False);
    *)
end;
procedure TfrmGL.WMSizing(var Message: TMessage) ;
begin
 panel.visible:=false;
end;
procedure  TfrmGL.BuildCyrilicFont;  // Построение нашего растрового шрифта
var
  font:HFONT;
          // Идентификатор фонта
begin
  Cyrilic:=glGenLists(256);  // Выделим место для 96 символов ( НОВОЕ )
 (* oldFont: = SelectObject(DC, font);   Запоминание старого фонта
   DeleteObject(font);               удаление нового
    SelectObject(DC, oldFont);       восстановление старого
    *)
  font:= CreateFont(
    -14,        // Высота фонта ( НОВОЕ )    -24
      0,        // Ширина фонта
      0,        // Угол отношения
      0,        // Угол Наклона
      FW_BOLD,      // Ширина шрифта
      0,        // Курсив
      0,        // Подчеркивание
      0,        // Перечеркивание
      DEFAULT_CHARSET ,      // Идентификатор набора символов    ANSI
      OUT_TT_PRECIS,      // Точность вывода
      CLIP_DEFAULT_PRECIS,    // Точность отсечения
      ANTIALIASED_QUALITY,    // Качество вывода
      FF_DONTCARE or DEFAULT_PITCH,  // Семейство и Шаг
      0{'Courier New'});      // Имя шрифта
(*  HFONT CreateFont(  int nHeight,               // height of font
  int nWidth,                // average character width
  int nEscapement,           // angle of escapement
  int nOrientation,          // base-line orientation angle
  int fnWeight,              // font weight
  DWORD fdwItalic,           // italic attribute option
  DWORD fdwUnderline,        // underline attribute option
  DWORD fdwStrikeOut,        // strikeout attribute option
  DWORD fdwCharSet,          // character set identifier
  DWORD fdwOutputPrecision,  // output precision
  DWORD fdwClipPrecision,    // clipping precision
  DWORD fdwQuality,          // output quality
  DWORD fdwPitchAndFamily,   // pitch and family
  LPCTSTR lpszFace           // typeface name);

*)
  SelectObject(DC, font);        // Выбрать шрифт, созданный нами ( НОВОЕ )

  wglUseFontBitmaps(DC, 0, 256, Cyrilic); // Построить 96 символов начиная с пробела 32( НОВОЕ )
  //с 32 символов с кириллицей всего 224
 end;
procedure TfrmGL.WMNCLButton(var Message: TMessage);
 begin
      case Message.wParam of
HTCAPTION:
          begin
           if AltDown  then        // copy to clipboard    for report
             if  assigned(ReportForm) then
             begin
               Panel.BeginDrag(False);
               Main.CopyToClipBoardExecute(self);
               ReportForm.CaptureSourceImage(Panel);
             end;
           end;
//  s:= 'HTCAPTION';

(*
          HTCLIENT:

                  s:= 'HTCLIENT';

           HTERROR:

                  s:= 'HTERROR';

          HTTRANSPARENT:

                  s:= 'HTTRANSPARENT';

            HTNOWHERE:

                  s:= 'HTNOWHERE'
            HTSYSMENU:

                  s:= 'HTSYSMENU';

            HTSIZE:

                  s:= 'HTSIZE';

            HTMENU:

                 s:= 'HTMENU';

            HTHSCROLL:

                  s:= 'HTHSCROLL';

            HTVSCROLL:

                  s:= 'HTVSCROLL';

            HTMINBUTTON:

                  s:= 'HTMINBUTTON';

            HTMAXBUTTON:

                  s:= 'HTMAXBUTTON';

            HTLEFT:

                  s:= 'HTLEFT';

            HTRIGHT:

                  s:= 'HTRIGHT';

            HTTOP:

                  s := 'HTTOP';

            HTTOPLEFT:

                  s:= 'HTTOPLEFT';

            HTTOPRIGHT:

                  s:= 'HTTOPRIGHT';

            HTBOTTOM:

                  s:= 'HTBOTTOM';

            HTBOTTOMLEFT:

                  s:= 'HTBOTTOMLEFT';

            HTBOTTOMRIGHT:

                  s:= 'HTBOTTOMRIGHT';

            HTBORDER:

                  s:= 'HTBORDER';

            HTOBJECT:

                  s:= 'HTOBJECT';

            HTCLOSE:

                  s:= 'HTCLOSE';

            HTHELP:

                  s:= 'HTHELP';

            else;
            //s:= '';
            *)
           end;  //case
           inherited;
      Message.Result := 0;
 end;
(*procedure TfrmGL.WMNCMOUSEMOVE(var Message: TMessage);
var
 begin
      case Message.wParam of
HTCAPTION:
          begin
           if AltDown  then        // copy to clipboard    for report
             if  assigned(ReportForm) then
             begin
               Panel.BeginDrag(False);
               Main.CopyToClipBoardExecute(self);
               ReportForm.CaptureSourceImage(Panel);
             end;
           end;
//  s:= 'HTCAPTION';

(*
          HTCLIENT:

                  s:= 'HTCLIENT';

           HTERROR:

                  s:= 'HTERROR';

          HTTRANSPARENT:

                  s:= 'HTTRANSPARENT';

            HTNOWHERE:

                  s:= 'HTNOWHERE'
            HTSYSMENU:

                  s:= 'HTSYSMENU';

            HTSIZE:

                  s:= 'HTSIZE';

            HTMENU:

                 s:= 'HTMENU';

            HTHSCROLL:

                  s:= 'HTHSCROLL';

            HTVSCROLL:

                  s:= 'HTVSCROLL';

            HTMINBUTTON:

                  s:= 'HTMINBUTTON';

            HTMAXBUTTON:

                  s:= 'HTMAXBUTTON';

            HTLEFT:

                  s:= 'HTLEFT';

            HTRIGHT:

                  s:= 'HTRIGHT';

            HTTOP:

                  s := 'HTTOP';

            HTTOPLEFT:

                  s:= 'HTTOPLEFT';

            HTTOPRIGHT:

                  s:= 'HTTOPRIGHT';

            HTBOTTOM:

                  s:= 'HTBOTTOM';

            HTBOTTOMLEFT:

                  s:= 'HTBOTTOMLEFT';

            HTBOTTOMRIGHT:

                  s:= 'HTBOTTOMRIGHT';

            HTBORDER:

                  s:= 'HTBORDER';

            HTOBJECT:

                  s:= 'HTOBJECT';

            HTCLOSE:

                  s:= 'HTCLOSE';

            HTHELP:

                  s:= 'HTHELP';

            else;
            //s:= '';

           end;  //case
      Message.Result := 0;
 end;
 *)
procedure TfrmGL.WMExitSizeMove(var Message: TMessage) ;
var H,W,x,y:Integer;
begin
(*    SetGLWindows;
 DC:=GetDC(handle);
  wglMakeCurrent(DC, hrc);
  glViewport(ClientX0,ClientY0, ClientHW, ClientHW);
  wglMakeCurrent(0, 0);
  InvalidateRect(Handle, nil, False);
 ReleaseDC(handle,DC);
 *)
   panel.visible:=true;
   Panel.Height:=ClientHeight;
   Panel.Left:=ClientWidth-Panel.Width;
   PanelGrd.Height:=Panel.ClientHeight*2 div 3;
   PanelGrd.Top:=Panel.ClientHeight-round(PanelGrd.Height*(2-scale));
//   PanelGrd.Top:=ROUND(Panel.ClientHeight*0.85)-PanelGrd.Height;
   PanelGrd.Left:=0;
   PanelIm.Left:=PanelGrd.width-PanelIm.width;
   LabelMean.Top:=PanelGrd.ClientHeight div 2;
   GradientRect (FromRGB,ToRGB,ImageGRGL.Canvas,ZMinGr,ZMaxGr);

end; (*WMExitSizeMove*)
function TfrmGL.ReniShawcorrection:integer;
var   NLines:integer;
      period:single;
 begin
  result:=0;
 if  TopoSpm.FileHeadRcd.HAquiRenishaw then
  begin
     if TopoSPM.ReadRenishawData()=2 then
           begin
             messageDlg(' No Renishaw Data block!',mterror,[mbOk],0);
             result:=2;
             exit;
           end;
       // procedures of correction  for  block = flgGlReadBlock

      period:=TopoSPM.FileHeadRcd.HRenishawPeriod*TopoSPM.FileHeadRcd.HRenishawSensorPos;
      ReniShawStepScale:= round(period/TopoSPM.FileHeadRcd.HStepXY); // 240 nm = ReniShaw PULSEs INTERVAL

    if (ReniShawStepScale < 2) then
      begin
         ReniShawStepScale:=1;
         period:=TopoSPM.FileHeadRcd.HStepXY;
      end;
        ReniShawCreateFrontsMap(TopoSPM.AquiReniShaw, TopoSpm.FileHeadRcd.HPathMode,ReniShawStepScale);
        ReniShawFrontsSmooth();
        ReniShawDACCorrect2D(DataDraw, TopoSPM.AquiReniShaw, TopoSpm.FileHeadRcd.HPathMode, ReniShawStepScale,period);
        ReniShawFreeFrontsMap;
        case TopoSpm.FileHeadRcd.HPathMode of
    Onex:   NLines:= TopoSPM.AquiTopo.Ny;
    Oney:   NLines:= TopoSPM.AquiTopo.Nx;
        end;

   if FlgGLReadBlock <>Onelinescan then
     if ReniShawStepScale*(NLines div ReniShawStepScale) = NLines  then
              ReniShawSlowAxisCorr(DataDraw, TopoSPM.AquiRenishaw, TopoSpm.FileHeadRcd.HPathMode, ReniShawStepScale,period) ;

      flgRenishawCorrected:=True;
      TopoSPM.FileHeadRcd.HRenishawCorrected :=True;
//      FreeAndNil(TopoSPM.AquiRenishaw);
    end;
 end;


procedure TfrmGL.WMGetMinMaxInfo(var info:TWMGetMinMaxInfo);
 begin
 with INfo.MinMaxInfo^ do
   begin
    ptMinTrackSize.x:=0;
    ptMinTrackSize.y:=0;
    ptMaxPosition.x:=BoundsRect.Left;
    ptMaxPosition.y:=BoundsRect.Right;
    PtMaxTrackSize.x:=Main.ClientWidth-100;
    ptMaxTrackSize.y:=Main.ClientHeight-100;;
  end;
end;
procedure TfrmGL.CopyDataDrawToTopo;
begin  { TODO : 261108_1 }
(*     case      FlgGlReadBlock   of
 TopoGraphy,
 Litho,LithoCurrent,OneLineScan:
             begin
               TopoSPM.AquiTopo:=DataDraw ;
             end;
Phase,
FastScanPhase,UAM,
BackPass,CurrentSTM,
 WorkF,FastScan:
            begin
              TopoSPM.AquiAdd:=DataDraw;
            end;
                       end;  //of
 *)
          if (flgGlReadBlock in  ScanmethodSetAdd) then
               begin
               TopoSPM.AquiAdd:=DataDraw;
              end
              else
              begin
               TopoSPM.AquiTopo:=DataDraw ;
              end;
end;


 {=================================================Создание формы}
constructor TfrmGL.Create(Aowner: TComponent;const FileNameIn:string;flgReadBlock:integer;
                         FlgView:integer; flgReniShawCorrection:boolean; var flgError:byte);
var    i,H,W,wWidth:Integer;
     NewItem:TMenuItem;
     adCaptionMulti:string;
begin
  FlgImgAnalysDrag:=False;
  flgInvert:=false;  strinvert:='';//'; Invert.';
  flgFormActivateFirst:=False; //before inherited Create
  FlgMirrorX:=false;
  FlgMirrorY:=false;
  FromRGB:=$00000000;;
  ToRGB:= $00FFFFFF;
  ZminGr:=0;
  ZmaxGr:=255;
  LNRed:=NRed;
  LNBlue:=NBlue;
  LNGreen:=NGreen;
  PaletteNameGLW:=PaletteName;
for i:=1 to NRed do
begin
 LXR[i]:=XR[i];
 LYR[i]:=YR[i];
end;
for i:=1 to NGreen do
begin
 LXG[i]:=XG[i];
 LYG[i]:=YG[i];
end;
for i:=1 to NBlue do
begin
 LXB[i]:=XB[i];
 LYB[i]:=YB[i];
end;
for i:=1 to MaxVal do
 begin
     LRDistr[i-1]:=RDistr[i];
     LGDistr[i-1]:=GDistr[i];
     LBDistr[i-1]:=BDistr[i];
 end;
   ZContrMax:=1.0;
   ZContrMin:=0;
   CountAnglePoints:=0;
   flgRealScale:=False;
   flgZZero:=false;
   FlgOneLineScan:=false;
   Main.ArrangeWindows1.Enabled:=True;
   Main.FileInfItem.Enabled:=True;
   Main.ActionPrint.Enabled:=True;
   ColorMaterialGLW:= ColorMaterial;
   TrackBarR:=255;
   TrackBarL:=0;
   ArFrmSectLoc:=TList.Create;
   ArFrmSectLoc.Clear;
   ArFrmSectLoc.Capacity:=20;
   SetLength(LineList,NMaxSect);
   LineListCount:=0;
   for i:=0 to (NMaxSect-1) do LineList[i]:=i+GLSECT_START_LIST;
    ArFrmFragLoc:=TList.Create;
    ArFrmFragLoc.Clear;
    ArFrmFragLoc.Capacity:=20;
    QuadListCount:=0;
    SetLength(QuadList,NMaxSect);
   for i:=0 to (NMaxSect-1) do QuadList[i]:=i+GLQuad_START_LIST;
    ParentFragW:=nil;
    CountUndo:=0;
    Scale:=0.70;
    FlgRule:=False;
    FlgAngle:=False;
    FlgClose:=False;
    FlgSection:=False;
    FlgCut:=False;
    FlgRubber:=False;
    FlgArRubber:=False;
    FlgLnRubber:=False;
    FlgMouseDown:=False;
    FlgMouseMove:=False;
    FlgMouseUp:=True;
    FlgFirstMouseDown:=False;
    FlgDirectionSection:=True;
//    DragFlag:=False;
    FlgView :=FlgViewDef;
//**********************************
    TopoSPM:=TExperiment.Create;
 //   DataDraw:=TData.Create;      { TODO : 250907 }
//**********************************
(**)
 position0[0]:=ltposition0[0];//-20.0;
 position0[1]:=ltposition0[1];//-20.0;
 position0[2]:=ltposition0[2];//20.0;
 position0[3]:=ltposition0[3];//0.0;
 position1[0]:=ltposition1[0];//-20.0;
 position1[1]:=ltposition1[1];//20.0;
 position1[2]:=ltposition1[2];//20.0;//-20
 position1[3]:=ltposition1[3];//0.0;
for i:=0 to 3 do  gl1ambient[i]:=l1ambient[i];
for i:=0 to 3 do  gl1diffuse[i]:=l1diffuse[i];
    case ColorMaterialGLW of
   0: renderTeapot (0.0215, 0.1745, 0.0215,0.07568, 0.61424, 0.07568, 0.633, 0.727811, 0.633, 0.6);
   1: renderTeapot (0.329412, 0.223529, 0.027451, 0.780392, 0.568627, 0.113725, 0.992157, 0.941176, 0.807843,0.21794872);
   2: renderTeapot (0.2125, 0.1275, 0.054,0.714, 0.4284, 0.18144, 0.393548, 0.271906, 0.166721, 0.2);
   3: renderTeapot (0.25, 0.25, 0.25,0.4, 0.4, 0.4, 0.774597, 0.774597, 0.774597, 0.6);
   4: renderTeapot (0.19125, 0.0735, 0.0225,0.7038, 0.27048, 0.0828, 0.256777, 0.137622, 0.086014, 0.1);
   5: renderTeapot (0.24725, 0.1995, 0.0745,0.75164, 0.60648, 0.22648, 0.628281, 0.555802, 0.366065, 0.4);
   6: renderTeapot (0.19225, 0.19225, 0.19225,0.50754, 0.50754, 0.50754, 0.508273, 0.508273, 0.508273, 0.4);
            end;
 for i:=0 to 3 do
   begin
    front_mat_emission[i]:=emission[i];
    front_mat_specular[i]:=specular[i];
    front_mat_diffuse[i]:=diffuse[i];
    front_mat_ambient[i]:=ambient[i];
   end;

 front_mat_shininess[0]:=shininess[0] ;
 vLeft := -1;
 vRight := 1;
 vBottom := -1;
 vTop := 1;
 vNear := 4.5;
 vFar := 10.5;
 steprot:=5;
 zmov:=0;
 stepmov:=0.1;
 xrot:=-120.0;
 zrot:=210.0;
 yrot:=180.0;

 inherited Create(AOwner);

 siLangLinked1.ActiveLanguage:=Lang;
 UpdateStrings;
 wWidth:=Main.ClientWidth div 2;
 if wWidth > (Main.ClientHeight div 2) then  wWidth:=(Main.ClientHeight div 2);
 wWidth:=wWidth-30;
 width:= wWidth;
 height:=width;
 PanelGrdWidth:=100;//80    //100
 Panel.Top:=0;
// Panel.Width:=0;
// if FlgView=D2Geo then  Panel.Width:=PanelGrdWidth;
 Panel.Height:=ClientHeight;
 PanelGrd.Top:=Panel.ClientHeight div 4;
 PanelGrd.Left:=0;
 PanelGrd.Width:=90;
 PanelGrd.Height:=Panel.ClientHeight div 2;
 PanelIm.width:=15;   //30
 Panel.Left:=ClientWidth-Panel.Width;
 PathFileNameGL:=ExtractFilePath(FileNameIN);
 TopoSPM.ImFileName:=FileNameIN;
 FileNameGL:=TopoSPM.ImFileName;
 FlgGlReadBlock:=FlgReadBlock;
  SetGLWindows;
 DC := GetDC (Handle);
  SetDCPixelFormat(DC);
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
   wglUseFontBitmaps (Canvas.Handle, 0, 255, GLF_START_LIST);
   Init;
  wglMakeCurrent(0, 0);

new(PntFileName);
 PntFileName^.FileName:=TopoSPM.ImFileName;
 TopoSPM.ArFileNameEdit.Add(PntFileName);

 flgError:=0;

 ///*************************************////
 if TopoSPM.ReadSurface(FlgGLReadBlock)>0 then
  begin  ReleaseDC(handle,DC); Close;  flgError:=1; exit end;
///*************************************////

  flgModify:=TopoSpm.MainRcd.flags=1;
if (TopoSpm.FileHeadRcd. HProbeType=1{STM}) and (flgGlReadBlock=Current) then ITCorGL:=ITCor else ITCorGL:=1;
          AddCaption:='';     { TODO : 261108 }
          if (flgGlReadBlock in  ScanmethodSetAdd) then
               begin
                 TopoSpm.FileHeadRcd.HAquiTopo:=False;
                 DataDraw:=TopoSPM.AquiAdd;
              end
              else
              begin
               if (flgGlReadBlock in  ScanmethodSetOneL) then
                begin
                FlgOneLineScan:=true;
                TopoSpm.FileHeadRcd.HAquiTopo:=True;
                TopoSpm.FileHeadRcd.HAquiAdd:=0;
                DataDraw:=TopoSPM.AquiTopo;
                end
                else
                begin
                 TopoSpm.FileHeadRcd.HAquiTopo:=True;
                 TopoSpm.FileHeadRcd.HAquiAdd:=0;
                 DataDraw:=TopoSPM.AquiTopo;
                end;
              end;
           AddCaption:=DataDraw.Caption;

    if  (TopoSpm.FileHeadRcd.HPathMode=Multi) OR (TopoSpm.FileHeadRcd.HPathMode=MultiY) then
         if  TopoSpm.FileHeadRcd.SecondPass then  AddCaption:=AddCaption+' II Pass';

    ZScaleK:=1;
    ZScaleP:=0;
 //////************ RENISHAW CORRECTION ***************///////////

 flgRenishawCorrected:=False;
 if TopoSpm.FileHeadRcd.HAquiRenishaw and (not TopoSPM.FileHeadRcd.HRenishawCorrected) then
 begin
   if  flgReniShawCorrection  then
   begin
     ReniShawcorrection ;
   end
   else AddCaption:=AddCaption+siLangLinked1.GetTextOrDefault('IDS_35' (* ' No  RS Correction' *) );
 end;
     InitSurface;
       case FlgView of
  D2Geo:  View2DGeoClick(Self);
  D3Top:  View3DTopClick(Self);
  D3:     View3DClick(Self);
  D3Geo:  View3DGeoClick(Self);
       end;

   ReleaseDC(handle,DC);
   Caption :=ExtractFileName(FileNameGL)+ADDCaption;
 //  Main.ActionExporttoMDT.enabled:=true;
   NewItem := TMenuItem.Create(Self);
   NewItem.Caption := '-';
   Main.mWindows.Add(NewItem);
   NewItem := TMenuItem.Create(Self);
   NewItem.Caption := self.Caption;
   Main.mWindows.Add(NewItem);
   NewItem.OnClick:=Main.ActivateMenuItem;
end;

procedure TfrmGL.UpdateStrings;
begin
  str_s := siLangLinked1.GetTextOrDefault('strstr_s' (* ' s' *) );
  strg13 := siLangLinked1.GetTextOrDefault('strstrg13');
  strgl2 := siLangLinked1.GetTextOrDefault('strstrgl2');
  strgl1 := siLangLinked1.GetTextOrDefault('strstrgl1');
  strgl0 := siLangLinked1.GetTextOrDefault('strstrgl0');
end;

procedure TfrmGL.UpdatevMaterialOpt;
var i:integer;
begin
 for i:=0 to 3 do
   begin
    emission[i]:=front_mat_emission[i];
    specular[i]:=front_mat_specular[i];
    diffuse[i]:=front_mat_diffuse[i];
    ambient[i]:=front_mat_ambient[i];
   end;
 shininess[0]:=front_mat_shininess[0];
 vSetMaterialOpt.UpdateMaterials;
end;


procedure TfrmGL.InitSurface;
var i,m,n:GLUint;
     x,y,xstart,ystart,ColorNorm,zt:GLfloat;
     vNormal:Vector;
     topocell:mcell;
     aVertex:array[0..1,0..2] of GLfloat ;
     nVertex:array[0..1,0..2] of GLfloat ;
     cVertex:array[0..1,0..3] of GLfloat;
     ZeroPoint:GLFloat;
     ZeroNorm:GLFloat;
     ZmaxC,ZminC:GLFloat;
     a1,a11,a2,a22:single;
     zc:integer;
begin
    wglMakeCurrent(DC, hrc);
     if assigned(list) then
       begin   glDeleteLists(list[0],listcount); list:=nil end;
   ///!!!!!! sometime error   DataDraw=nil
     try
      SetLength(list,DataDraw.Ny);
     except
              on EOutOfMemory        do
              begin
               siLangLinked1.MessageDlg(strgl0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
               exit;
              end;
     end;

      for i:=0 to DataDraw.Ny-1 do list[i]:=i+1;
      listcount:=0;

      TopoMin:=DataDraw.DataMin;
      TopoMax:=DataDraw.DataMax;

      //axies label
      XMinIn:=0.0;
      XMaxIn:=DataDraw.XStep*DataDraw.Nx;
      YMinIn:=0.0;
      YMaxIn:=DataDraw.YStep*DataDraw.Ny;
      ZMinIn:=0;//TopoSPM.DataMin*TopoSPM.ZStep;
      ZMaxIn:=(TopoMax-TopoMin)*DataDraw.ZStep;
               case      FlgGlReadBlock   of
OneLineScan:
      begin
                case TopoSPM.FileHeadRcd.HPathMode of
              0:begin   { TODO : 030707 }
                 TopoUnitsY:=OneLineTopoUnits;
                 TopoUnitsX:=TopoUnitsnmXY;
               //  if flgUnit=grand then  TopoUnitsX:=TopoUnitsmcnXY;   //  !!!! mcn-nm
                if XMaxIn> TopoUnitsX.Limit  then  TopoUnitsX:=TopoUnitsmcnXY;
                end;
              1:begin    { TODO : 030707 }
                 TopoUnitsX:=OneLineTopoUnits;
                 TopoUnitsY:=TopoUnitsnmXY;
               {if flgUnit=grand then TopoUnitsY:=TopoUnitsmcnXY;   //!!!! mcn-nm}
                 if YMaxIn> TopoUnitsX.Limit  then  TopoUnitsY:=TopoUnitsmcnXY;
                end;
                   END;
      end
      else
      begin
        TopoUnitsX:=TopoUnitsnmXY;    TopoUnitsY:=TopoUnitsnmXY;
        {if flgUnit=grand then}  if Max(XMaxIn,YMaxIn)> TopoUnitsX.Limit  then            //      !!!! mcn-nm
        begin
         TopoUnitsX:=TopoUnitsmcnXY;   TopoUnitsY:=TopoUnitsmcnXY;
        end;
      end;
                     end;

       TopoUnitsZ:=TopoUnitsnmZ ;
     // if ZmaxIn> TopoUnitsZ.Limit then  TopoUnitsZ:=TopoUnitsmcnZ;     !!!! mcn-nm
{ TODO : 261108_2 }
(*     case flgGlReadBlock of
TopoGraphy,
OneLineScan,
BackPass,Litho,LithoCurrent:begin TopoUnitsZ:=TopoUnitsnmZ ; DataDraw.captionZ:=TopoUnitsZ.text; end;
FastScan,CurrentSTM        :begin TopoUnitsZ:=CurrentUnits  end;
UAM                        :begin TopoUnitsZ:=ForceUnits    end;
FastScanPhase,Phase        :begin TopoUnitsZ:=PhaseUnits    end;
                                   end;

*)
if (flgGlReadBlock in  ScanmethodSetZnm) then begin TopoUnitsZ:=TopoUnitsnmZ ; DataDraw.captionZ:=TopoUnitsZ.text; end
 else
 if (flgGlReadBlock in  ScanmethodSetZAm)then begin TopoUnitsZ:=CurrentUnits  end
   else
   if (flgGlReadBlock in  ScanmethodSetZUAM) then begin TopoUnitsZ:=ForceUnits  end
    else
     if (flgGlReadBlock in  ScanmethodSetZph) then begin TopoUnitsZ:=PhaseUnits  end;

      TopoNorm:=abs(TopoMax-TopoMin);
      RealScaleNorm:=Max(XMaxIn,YMaxIn);
      RealScaleNorm:=Max(RealScaleNorm,ZMaxIn);
      ZScaleK:=1+(TopoNorm*DataDraw.ZStep/RealScaleNorm-1)*ZScaleP*0.01;
      { TODO : 261108_3 }
//      if flgGlReadBlock<>Topography then ZScaleK:=1-ZScaleP*0.01;
      if not (flgGlReadBlock in ScanmethodSetZnm) then ZScaleK:=1-ZScaleP*0.01;
      if flgRealScale               then TopoNorm:= RealScaleNorm;//only for Topography
      if TopoNorm<0.0000001         then TopoNorm:=1.0;
        ZeroPoint:=0;
        ZeroNorm:=1;
      if flgZZero then
        begin
          ZeroPoint:=-1;
          ZeroNorm:=2;
        end;
        xstart:=-1.0;
      	ystart:=-1.0;

        if FlgGLReadBlock<>OneLineScan then
        begin
         if (XmaxIn>YmaxIn) then
          begin
              dx:=-2.0*xstart/(DataDraw.Nx-1);
              dy:=-2.0*ystart/(DataDraw.Ny-1)*YMaxIn/XMaxIn;
          end
         else
          begin
              dx:=-2.0*xstart/(DataDraw.Nx-1)*XMaxIn/YMaxIn;
              dy:=-2.0*ystart/(DataDraw.Ny-1);
          end
        end
        else
        begin
              dx:=-2.0*xstart/(DataDraw.Nx-1);
              dy:=-2.0*ystart/(DataDraw.Ny-1);
        end;

        Mend:=(DataDraw.Ny-2);       //-1
        Nend:=(DataDraw.Nx-2);       //-2
        XMin:=xstart;
        XMax:=xstart+dx*nend;
        YMin:=ystart;
        YMax:=ystart+dy*mend;
        ZMin:=ZeroPoint;//TopoNorm;
        ZMax:=ZeroPoint+ZeroNorm*(TopoMax-TopoMin)/TopoNorm*ZScaleK;  //1;
        ColorNorm:=(ZContrMax-ZContrMin)*ZScaleK;///Ncolors;
        ZMaxC:=ZContrMax*ZScaleK;
        ZMinC:=ZContrMin*ZScaleK;
     if ColorNorm<0.0000001 then ColorNorm:=1.0;
        a1:=1.7;
        a2:=3.0;
        a11:=(1+a1)/a1;
        a22:=(1+a2)/a2;
  for  m:=1 to Mend-1 do
   begin {step y }
     i:=0 ;
     inc(listcount);
     glNewList(list[m-1],GL_COMPILE);
     glBegin(GL_TRIANGLE_STRIP);
    for  n:=1 to Nend do
         begin  {step x}
                {            triangle strip  TopoX * 2      }
                         topocell[1,1]:= DataDraw.data[n-1,m+1];
                         topocell[1,2]:= DataDraw.data[n,m+1];
                         topocell[2,1]:= DataDraw.data[n-1,m];
                         topocell[2,2]:= DataDraw.data[n,m];
                         topocell[2,3]:= DataDraw.data[n+1,m];
                         topocell[3,2]:= DataDraw.data[n,m-1];
                         topocell[3,3]:= DataDraw.data[n+1,m-1];
                         x:=xstart+(n-1)*dx;         //n---(N-1)
                         aVertex[i,0]:=x;
            		      	 y:=ystart+(m-1)*dy;         //m-- (m-1)    6.11.01
 		                     aVertex[i,1]:=y  ;         //2
                    	   aVertex[i,2]:=ZeroPoint+ZeroNorm*(DataDraw.data[n,m]-TopoMin)/TopoNorm*ZScaleK;
                         zt:=aVertex[i,2]/ZeroNorm;
             { TODO : 021208 }
                (*         cVertex[i,0]:=LRDistr[0];//0;
                         cVertex[i,1]:=LGDistr[0];
                         cVertex[i,2]:=LBDistr[0];
                         cVertex[i,3]:=alf;
                      if (zt>ZMinC) and (zt<ZMaxC) then
                         begin
                          zc:=floor(255*(zt-ZMinC)/ColorNorm);
                          cVertex[i,0]:=LRDistr[ZC];
                          cVertex[i,1]:=LGDistr[ZC];
                          cVertex[i,2]:=LBDistr[ZC];
                         end
                         else
                          if  zt>=ZMaxC then
                               begin
                                  cVertex[i,0]:=LRDistr[255];//1;
                                  cVertex[i,1]:=LGDistr[255];//1;
                                  cVertex[i,2]:=LBDistr[255];//1;
                                end;
                  *)
                           zc:=floor(255*(zt-ZMinC)/ColorNorm);
                           if zc>255 then zc:=255
                                     else if zc<0 then  zc:=0;

                          cVertex[i,0]:=LRDistr[ZC];
                          cVertex[i,1]:=LGDistr[ZC];
                          cVertex[i,2]:=LBDistr[ZC];

                          vNormal:=Normal(topocell,x,y,dx,dy);
                  			 nVertex[i,0]:=vNormal.x;
                  			 nVertex[i,2]:=vNormal.y;
                  			 nVertex[i,1]:=vNormal.z;
                  			 aVertex[i+1,0]:=x;
                  			 y:=y+dy;
                  		   aVertex[i+1,1]:=y;            //2
                  			 aVertex[i+1,2]:=ZeroPoint+ZeroNorm*(DataDraw.data[n,m+1]-TopoMin)/TopoNorm*ZScaleK;
                         zt:=aVertex[i+1,2]/ZeroNorm;
          { TODO : 021208_1 }
               (*          cVertex[i+1,0]:=LRDistr[0];//0;
                         cVertex[i+1,1]:=LGDistr[0];//0;
                         cVertex[i+1,2]:=LBDistr[0];//0;
                         cVertex[i+1,3]:=alf;
                     if (zt>ZMinC) and (zt<ZMaxC) then
                         begin
                          zc:=floor(255*(zt-ZMinC)/ColorNorm);
                          cVertex[i+1,0]:=LRDistr[ZC];
                          cVertex[i+1,1]:=LGDistr[ZC];
                          cVertex[i+1,2]:=LBDistr[ZC];
                         end
                         else
                           if  zt>=ZMaxC then
                               begin
                                  cVertex[i+1,0]:=LRDistr[255];//1;
                                  cVertex[i+1,1]:=LGDistr[255];//1;
                                  cVertex[i+1,2]:=LBDistr[255];//1;
                                end;
                 *)
                           zc:=floor(255*(zt-ZMinC)/ColorNorm);
                            if zc>255 then zc:=255
                                     else if zc<0 then  zc:=0;
                          cVertex[i+1,0]:=LRDistr[ZC];
                          cVertex[i+1,1]:=LGDistr[ZC];
                          cVertex[i+1,2]:=LBDistr[ZC];

                         topocell[1,1]:= DataDraw.data[n-1,m+2];
                         topocell[1,2]:= DataDraw.data[n,m+2];
                         topocell[2,1]:= DataDraw.data[n-1,m+1];
                         topocell[2,2]:= DataDraw.data[n,m+1];
                         topocell[2,3]:= DataDraw.data[n+1,m+1];
                         topocell[3,2]:= DataDraw.data[n,m];
                         topocell[3,3]:= DataDraw.data[n+1,m];
          vNormal:=Normal(topocell,x,y,dx,dy);
			    nVertex[i+1,0]:=vNormal.x;
			    nVertex[i+1,2]:=vNormal.y;
			    nVertex[i+1,1]:=vNormal.z;
         for i:=0 to 1 do
           begin
            glColor3fv(@cVertex[i]);
	       	  glNormal3fv(@nVertex[i]);
		        glVertex3fV(@aVertex[i]);
           end;
           i:=0;
       end; //n
         glEnd();
        glEndlist;
      end; //m
     wglMakeCurrent(0,0);
end;

procedure OutText (Litera : PChar);
begin
   glListBase(GLF_START_LIST);
   glCallLists(Length (Litera), GL_UNSIGNED_BYTE, Litera);
end;

procedure TfrmGl.ScaleZ(sender:Tobject);
begin
   DC:=GetDC(handle);
//    ZScaleK:=1+(TopoNorm{*DataDraw.zStep}/RealScaleNorm-1)*ZScaleP*0.01;
    if assigned(DataDraw) then     InitSurface;//(DataDraw);
           case flgView of
     D3Top:begin View3DClick(Sender);    end;
     D2Geo:begin View3DGeoClick(Sender)  end;
                end;
    InvalidateRect(Handle, nil, False);
   ReleaseDC(Handle,DC);
end;

procedure TfrmGl.CutSection(Sender:Tobject);
var  i,j:integer;
     m,n:integer;
     K,a0,st:single;
     t,dNx,dNy:integer;
     L,count:integer;
     ActiveW:TSection;
     Title:string;
     Section,SectionY_X: TDataLine;
     yy:smallint;
     NewItem:TMenuItem;
     dN:single;
     buf:smallint;
     NPoints:integer;
     dPoint:single;
      txs,tys, txe,tye:single;
begin
      DC:=GetDC(Handle);
       wglMakeCurrent(DC, hrc);
         inc(LineListCount);
         glPushMatrix;
       glNewList(LineList[LineListCount-1],GL_COMPILE);
         glPushAttrib (GL_ALL_ATTRIB_BITS );
         glDisable(GL_LIGHTING);
         glColor3f(1,0,0);
         glRasterPos3f(XE, YE, -1.0);
         OutText (PChar(IntToStr(LineListCount)));
         glLineWidth(1.0);
         glColor3f(1,0,0);
         glBegin (GL_LINE_STRIP);
         glVertex3f (XS,YS,-1.0);
         glVertex3f (XE,YE,-1.0);
         glEnd;
         glEnable(GL_LIGHTING);
         glPopAttrib;
       glEndlist;
         glPopMatrix;
      wglMakeCurrent(0, 0);
        FlgFirstMouseDown:=False;
        dNx:=(NxEnd-NxStart);
        dNy:=(NyEnd-NyStart);
        txs:=(xs/scale+1.0)/dx*datadraw.xstep;
        tys:=(ys/scale+1.0)/dy*datadraw.xstep;
        txe:=(xe/scale+1.0)/dx*datadraw.xstep;
        tye:=(ye/scale+1.0)/dy*datadraw.xstep;

 if (sqr(dNx)+sqr(dNy))<10 then exit;
 if  abs(dNx)>abs(dNy)     then
   begin
      k:=(tye-tys)/(txe-txs);
      a0:=(tYs-K*tXs);
//     K:=dNy/dNx; a0:=NyStart-K*NxStart;
     FlgDirectionSection:=True;
     t:=abs(NxEnd-NxStart);
     Section:=TDataLine.Create(t+1);
     SectionY_X:=TDataLine.Create(t+1);
     Section.DataLineX[0]:=txs;//NxStart;
     Section.DataLineY[0]:=tys;//NyStart;
     st:=abs((txe-txs)/dnx);
   if ((NxEnd-NxStart)<0) then st:=-st;// else st:=1;
    for i:=1 to t do
     begin
      Section.DataLineX[i]:=Section.DataLineX[i-1]+st;
      Section.DataLineY[i]:=(K*Section.DataLineX[i]+a0);
     end;
   end
 else
   begin
     k:=(txe-txs)/(tye-tys);
    a0:=(tXs-K*tYs);
    FlgDirectionSection:=False;
    t:=round(abs(NyEnd-NyStart));
    Section:=TDataLine.Create(t+1);
    SectionY_X:=TDataLine.Create(t+1);
    Section.DataLineX[0]:=txs;
    Section.DataLineY[0]:=tys;
    st:=abs((tye-tys)/dny);
    if ((NyEnd-NyStart)<0) then st:=-st;////////////// else st:=1;
     for i:=1 to t do
      begin
       Section.DataLineY[i]:=Section.DataLineY[i-1]+st;
       Section.DataLineX[i]:=Section.DataLineY[i]*K+a0;
      end;
   end;
       L:=Length(Section.DataLineX);
       j:=0;
          for i:=0 to L-1 do
            begin
             if  FlgDirectionSection then
              begin
              //if (Section.DataLineX[i]>nend)  or (Section.DataLineY[i]>mend)
                 // or (Section.DataLineX[i]<0) or (Section.DataLineY[i]<0)
                //  then YY:=0
               //   else
                  begin
                      m:=round(Section.DataLineX[i]/datadraw.xstep);
                      n:=round(Section.DataLineY[i]/datadraw.xstep);
                      YY:=DataDraw.Data[m,n];
//                    SectionY_X.DataLineX[j]:=Section.DataLineX[i]*dN;
                    SectionY_X.DataLineY[j]:=YY;
                    inc(j);
                  end;
            end
            else
            begin
             //   if (Section.DataLineX[i]>nend) or (Section.DataLineY[i]>mend)
             //      or (Section.DataLineX[i]<0) or (Section.DataLineY[i]<0)
             //        then YY:=0
             //        else
                     begin
                      m:=round(Section.DataLineX[i]/datadraw.xstep);
                      n:=round(Section.DataLineY[i]/datadraw.xstep);
                      YY:=DataDraw.Data[m,n];
                //      SectionY_X.DataLineX[j]:=Section.DataLineY[i]*dN;
                      SectionY_X.DataLineY[j]:=YY;
                      inc(j);
                    end;
           end
           end;
       //     SectionY_X.XStep:=Lengthline/t{DataDraw.XStep}/TopoUnitsX.coef;
            SectionY_X.YStep:=DataDraw.ZStep*ITCorGL/TopoUnitsZ.coef;
              { TODO : 190606 }
            SectionY_X.yAxisTitle:=TopoUnitsZ.text;//DataDraw.CaptionZ;
            SectionY_X.Nx:=j; /// 30/11/05
            NPoints:= SectionY_X.Nx;
 //           dPoint:= (SectionY_X.DataLineX[NPoints-1]-SectionY_X.DataLineX[0])/(NPoints-1);
//            for i:=0 to NPoints-1 do  SectionY_X.DataLineX[i]:=i*abs(dPoint);
 //           if SectionY_X.DataLineX[NPoints-1]*SectionY_X.XStep*TopoUnitsX.coef<=TopoUnitsX.limit
          if Lengthline< TopoUnitsX.limit then
                                               begin
                                                 //  SectionY_X.XStep:=DataDraw.XStep;
                                                   SectionY_X.XStep:=Lengthline/t/TopoUnitsnmXY.coef;
                                                   SectionY_X.xAxisTitle:=TopoUnitsnmXY.text;
                                                end
                                                else
                                                 begin
                                                  // SectionY_X.XStep:=DataDraw.XStep/TopoUnitsX.coef;
                                                   SectionY_X.XStep:=Lengthline/t/TopoUnitsmcnXY.coef;
                                                   SectionY_X.xAxisTitle:=TopoUnitsmcnXY.text;  //    TopoUnitsX:=TopoUnitsmcnXY;
                                                end;

       Title := 'Section_'  +IntToStr(LineListCount)+'_'+ExtractFileName(FilenameGL)+' '+AddCaption;
        if flgInvert then  Title:=Title+strinvert ;
        Main.CreateMDIChildSection(Sender,SectionY_X,j,Title,TopoSPM.FileHeadRcd);
        Count:=ArFrmSect.Count;
        ActiveW:=ArFrmSect.Items[Count-1];
        ActiveW.ParentSectW:=self;
        new(PtSect);
        PtSect.Sect:=ActiveW;
        PtSect^.GLList:=LineList[LineListCount-1];
        ArFrmSectLoc.Add(PtSect);
        NewItem := TMenuItem.Create(Application);
        NewItem.Caption :='-';
        Main.mWindows.Add(NewItem);
        NewItem := TMenuItem.Create(Application);
        NewItem.Caption := ActiveW.Caption;
        NewItem.OnClick:=Main.ActivateMenuItem;
        Main.mWindows.Add(NewItem);
        ActiveW:=nil;
        SectionY_X.Destroy;
        Section.Destroy;
       ReleaseDC(Handle,DC);
end;
(*
procedure TfrmGl.CutSection(Sender:Tobject);
var  i,j:integer;
     K,a0:single;
     t,st,dNx,dNy:integer;
     L,count:integer;
     ActiveW:TSection;
     Title:string;
     Section,SectionY_X: TDataLine;
     yy:smallint;
     NewItem:TMenuItem;
     dN:single;
     buf:smallint;
     NPoints:integer;
     dPoint:single;
begin
      DC:=GetDC(Handle);
       wglMakeCurrent(DC, hrc);
         inc(LineListCount);
         glPushMatrix;
       glNewList(LineList[LineListCount-1],GL_COMPILE);
         glPushAttrib (GL_ALL_ATTRIB_BITS );
         glDisable(GL_LIGHTING);
         glColor3f(1,0,0);
         glRasterPos3f(XE, YE, -1.0);
         OutText (PChar(IntToStr(LineListCount)));
         glLineWidth(1.0);
         glColor3f(1,0,0);
         glBegin (GL_LINE_STRIP);
         glVertex3f (XS,YS,-1.0);
         glVertex3f (XE,YE,-1.0);
         glEnd;
         glEnable(GL_LIGHTING);
         glPopAttrib;
       glEndlist;
         glPopMatrix;
      wglMakeCurrent(0, 0);
        FlgFirstMouseDown:=False;
        dNx:=(NxEnd-NxStart);
        dNy:=(NyEnd-NyStart);
 if (sqr(dNx)+sqr(dNy))<10 then exit;
 if  abs(dNx)>abs(dNy)     then
   begin
     K:=dNy/dNx; a0:=NyStart-K*NxStart;
     FlgDirectionSection:=True;
     t:=abs(NxEnd-NxStart);
     Section:=TDataLine.Create(t+1);
     SectionY_X:=TDataLine.Create(t+1);
     Section.DataLineX[0]:=NxStart;
     Section.DataLineY[0]:=NyStart;
   if ((NxEnd-NxStart)<0) then st:=-1 else st:=1;
    for i:=1 to t do
     begin
      Section.DataLineX[i]:=Section.DataLineX[i-1]+st;
      Section.DataLineY[i]:=round(K*Section.DataLineX[i]+a0);
     end;
   end
 else
   begin
    K:=dNx/dNy; a0:=NxStart-K*NyStart;
    FlgDirectionSection:=False;
    t:=round(abs(NyEnd-NyStart));
    Section:=TDataLine.Create(t+1);
    SectionY_X:=TDataLine.Create(t+1);
    Section.DataLineX[0]:=NxStart;
    Section.DataLineY[0]:=NyStart;
    if ((NyEnd-NyStart)<0) then st:=-1 else st:=1;
     for i:=1 to t do
      begin
       Section.DataLineY[i]:=Section.DataLineY[i-1]+st;
       Section.DataLineX[i]:=round(Section.DataLineY[i]*K+a0);
      end;
   end;
       L:=Length(Section.DataLineX);
       DN:=sqrt(sqr(dNX)+sqr(dNy))/(L-1);
       j:=0;
          for i:=0 to L-1 do
            begin
             if  FlgDirectionSection then
              begin
              if (Section.DataLineX[i]>nend)  or (Section.DataLineY[i]>mend)
                  or (Section.DataLineX[i]<0) or (Section.DataLineY[i]<0)
                  then YY:=0
                  else
                  begin
                    YY:=DataDraw.Data[round(Section.DataLineX[i]),round(Section.DataLineY[i])];
                    SectionY_X.DataLineX[j]:=Section.DataLineX[i]*dN;
                    SectionY_X.DataLineY[j]:=YY;
                    inc(j);
                  end;
            end
            else
            begin
                if (Section.DataLineX[i]>nend) or (Section.DataLineY[i]>mend)
                   or (Section.DataLineX[i]<0) or (Section.DataLineY[i]<0)
                     then YY:=0
                     else
                     begin
                      YY:=DataDraw.Data[round(Section.DataLineX[i]),round(Section.DataLineY[i])];
                      SectionY_X.DataLineX[j]:=Section.DataLineY[i]*dN;
                      SectionY_X.DataLineY[j]:=YY;
                      inc(j);
                    end;
           end
           end;
       //     SectionY_X.XStep:=Lengthline/t{DataDraw.XStep}/TopoUnitsX.coef;
            SectionY_X.YStep:=DataDraw.ZStep*ITCorGL/TopoUnitsZ.coef;
              { TODO : 190606 }
            SectionY_X.yAxisTitle:=TopoUnitsZ.text;//DataDraw.CaptionZ;
            SectionY_X.Nx:=j; /// 30/11/05
            NPoints:= SectionY_X.Nx;
            dPoint:= (SectionY_X.DataLineX[NPoints-1]-SectionY_X.DataLineX[0])/(NPoints-1);
            for i:=0 to NPoints-1 do  SectionY_X.DataLineX[i]:=i*abs(dPoint);
 //           if SectionY_X.DataLineX[NPoints-1]*SectionY_X.XStep*TopoUnitsX.coef<=TopoUnitsX.limit
          if Lengthline< TopoUnitsX.limit then
                                               begin
                                                 //  SectionY_X.XStep:=DataDraw.XStep;
                                                   SectionY_X.XStep:=Lengthline/t/TopoUnitsnmXY.coef;
                                                   SectionY_X.xAxisTitle:=TopoUnitsnmXY.text;
                                                end
                                                else
                                                 begin
                                                  // SectionY_X.XStep:=DataDraw.XStep/TopoUnitsX.coef;
                                                   SectionY_X.XStep:=Lengthline/t/TopoUnitsmcnXY.coef;
                                                   SectionY_X.xAxisTitle:=TopoUnitsmcnXY.text;  //    TopoUnitsX:=TopoUnitsmcnXY;
                                                end;
      Title := 'Section_'  +IntToStr(LineListCount)+'_'+ExtractFileName(FilenameGL)+' '+AddCaption;
        if flgInvert then  Title:=Title+strinvert ;
        Main.CreateMDIChildSection(Sender,SectionY_X,j,Title,TopoSPM.FileHeadRcd);
        Count:=ArFrmSect.Count;
        ActiveW:=ArFrmSect.Items[Count-1];
        ActiveW.ParentSectW:=self;
        new(PtSect);
        PtSect.Sect:=ActiveW;
        PtSect^.GLList:=LineList[LineListCount-1];
        ArFrmSectLoc.Add(PtSect);
        NewItem := TMenuItem.Create(Application);
        NewItem.Caption :='-';
        Main.mWindows.Add(NewItem);
        NewItem := TMenuItem.Create(Application);
        NewItem.Caption := ActiveW.Caption;
        NewItem.OnClick:=Main.ActivateMenuItem;
        Main.mWindows.Add(NewItem);
        ActiveW:=nil;
        SectionY_X.Destroy;
        Section.Destroy;
       ReleaseDC(Handle,DC);
end;
*)
Procedure TfrmGl.CutSurface(Sender:TObject);
var TopoSPM1:TExperiment;
    NX,Ny,i,j,Count:integer;
    ActiveW:TfrmGL;
    TMax0,TMax,TMin0,TMin,tm: DataType;
begin
   Ny:=1+NyEnd-NyStart;
   Nx:=1+NxEnd-NxStart;
if (Nx>3) and (Ny>3) then
begin
 if FlgcontrastZ  then
  begin
   if not TopoSPM.FileHeadRcd.HAquiTopo then
    begin
     tMax0:=TopoSPM.AquiAdd.DataMax;
     tMin0:=TopoSPM.AquiAdd.DataMin;
    end
    else
    begin
     tMax0:=TopoSPM.AquiTopo.DataMax;
     tMin0:=TopoSPM.AquiTopo.DataMin;
    end;
    tMax:=TMin0;
    tMin:=TMax0;
     for i:=0 to Ny-1 do
      for j:=0 to Nx-1 do
       begin
         tm:=DataDraw.Data[(j+NxStart),(i+NyStart)];
         if tm>tMax then tMax:=tm;
         if tm<tMin then tMin:=tm;
       end;
     if assigned(ImageTools) then
     begin
      ImageTools.ZTrackBarLeft.position:=255-round(255*(TMax-TMin0)/(TMax0-TMin0));   //221007
      ImageTools.ZTrackBarRight.position:=255-round(255*(TMin-TMin0)/(TMax0-TMin0));  //
     end;
      Contrast(Sender);
  end//contrast
  else
  begin
   TopoSPM1:=TExperiment.Create;
  try
   if not TopoSPM.FileHeadRcd.HAquiTopo then
    begin
      try
       SetLength(TopoSPM1.AquiAdd.Data,Nx,Ny);
      except
              on EOutOfMemory        do
              siLangLinked1.MessageDlg(strgl0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
      end;
      for i:=0 to Ny-1 do
       for j:=0 to Nx-1 do  TopoSPM1.AquiAdd.Data[j,i]:=DataDraw.Data[(j+NxStart),(i+NyStart)];
            TopoSPM1.AquiAdd.Ny:=Ny;
            TopoSPM1.AquiAdd.Nx:=Nx;
            TopoSPM1.AquiAdd.XStep:=TopoSPM.AquiAdd.XStep;
            TopoSPM1.AquiAdd.YStep:=TopoSPM.AquiAdd.YStep;
            TopoSPM1.FileHeadRcd:=TopoSPM.FileHeadRcd;
            TopoSPM1.MainRcd:=TopoSPM.MainRcd;
            TopoSPM1.AquiTopo.Ny:=0;
            TopoSPM1.AquiTopo.Nx:=0;
    end
    else     //topo
    begin
      try
         SetLength(TopoSPM1.AquiTopo.data,Nx,Ny);
      except
              on EOutOfMemory        do
            siLangLinked1.MessageDlg(strgl0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
     end;
     for i:=0 to Ny-1 do
      for j:=0 to Nx-1 do  TopoSPM1.AquiTopo.data[j,i]:=DataDraw.data[(j+NxStart),(i+NyStart)];
            TopoSPM1.AquiTopo.Ny:=Ny;
            TopoSPM1.AquiTopo.Nx:=Nx;
            TopoSPM1.AquiTopo.XStep:=TopoSPM.AquiTopo.XStep;
            TopoSPM1.AquiTopo.YStep:=TopoSPM.AquiTopo.YStep;
            TopoSPM1.FileHeadRcd:=TopoSPM.FileHeadRcd;
            TopoSPM1.MainRcd:=TopoSPM.MainRcd;
            TopoSPM1.FileHeadRcd.HAquiAdd:=0;

    end;
       TopoSPM1.WorkFileName:=TempDirectory+'Fragment_'+IntToStr(QuadListCount+1)
                                                       +'_'+ExtractFileName(FileNameGl);
      if flgInvert then  TopoSPM1.WorkFileName:=TopoSPM1.WorkFileName+strinvert ;

       TopoSPM1.ImFileName:=  TopoSPM1.WorkFileName;

       TopoSPM1.SaveExperiment;

       Main.CreateMDIChild(Sender,TopoSPM1.Workfilename,ActiveGLW.FlgView,false,false);

            Count:=ArFrmGL.Count;
            inc(QuadListCount);
          ActiveW:=ArFrmGL.Items[Count-1];
          ActiveW.ParentFragW:=self;
        if self.FlgView=D2Geo then   ActiveW.View2DGeoClick(Sender);
        if self.FlgView=D3Top then   ActiveW.View3DTopClick(Sender);
                new(PtFrag);
                PtFrag.Frag:=TfrmGL(ActiveW);
             DC:=GetDC(handle);
                wglMakeCurrent(DC, hrc);
                 glPushMatrix;
                 glNewList(QuadList[QuadListCount-1],GL_COMPILE);
                  glPushAttrib (GL_ALL_ATTRIB_BITS );
                  glDisable(GL_LIGHTING);
                  glColor3f(1,1,1);
                  glRasterPos3f(XE, YE, -1.0);
                  OutText(PChar(IntToStr(QuadListCount)));
                  glLineWidth(1.0);
                  glColor3f(1,0,0);
                 glBegin (GL_LINE_STRIP);
                   glVertex3f (XS,YS,-1.0);
                   glVertex3f (XE,YS,-1.0);
                   glVertex3f (XE,YE,-1.0);
                   glVertex3f (XS,YE,-1.0);
                   glVertex3f (XS,YS,-1.0);
                 glEnd;
                  glEnable(GL_LIGHTING);
                  glPopAttrib;
                glEndlist;
                glPopMatrix;
                wglMakeCurrent(0, 0);
            ReleaseDC(handle,DC);
               PtFrag^.GLList:=QuadList[QuadListCount-1];
               ArFrmFragLoc.Add(PtFrag);
     finally
      FreeAndNil(TopoSpm1);
     end;
   end  //cut
  end   //nx,ny>3
  else
  begin
    siLangLinked1.MessageDlg(strg13{'It is not enough points. Increase a fragment.'},mtWarning,[mbOk],0);
  end;
     ActiveW:=nil;
end;
 {======================================Вывод текста}
procedure TfrmGL.SpaceToScreen(x,y:GLFloat; var xm,ym:GLFloat);
 begin
  xm:=ClientHW/2+ClientX0;
  ym:=ClientHW/2+ClientY0;
 end;
procedure TfrmGL.ScreenToSpace(xm,ym:GLFloat; var x,y:GLFloat);
 begin
  x:=(2/ClientHW*(xm-ClientX0)-1);
  y:=(-2/ClientHW*(ym-ClientY0)+1);
 end;
//======================================================================
{Рисование линий осей координат new version}
(*procedure TfrmGL.Axes(DataDraw:TData);
var i:integer;
    s,AxStepIn,Axstep,AyStepIn,Aystep,Azstep,AZStepIn,delta:GLFloat;
    xAxesScale,yAxesScale,zAxesScale:array[0..7] of GLFloat;
    addstr:string;
    NaxisY,NaxisX,NaxisZ,xf:integer;
    ZeroPoint:GlFloat;
 procedure AxiesSteps(var step:GLFloat);
 begin
   if (step<1)                       then begin                                   exit end;
   if (step>=1)     and (step<10)    then begin step:=round(step);            exit end;
   if (step>=10)    and (step<100)   then begin step:=10*round(step/10);      exit end;
   if (step>=100)   and (step<1000)  then begin step:=100*round(step/100);    exit end;
   if (step>=1000)  and (step<10000) then begin step:=1000*round(step/1000);  exit end;
   if (step>=10000) and (step<100000)then begin step:=10000*round(step/10000);exit end;
   if (step>=100000)                   then begin step:=100000*round(step/100000);exit end;

 end;
begin
  addstr:=DataDraw.captionZ;
  ZeroPoint:=0.0;
  if flgZZero then ZeroPoint:=-1;
  delta:=0.03;
  glPushMatrix;
  glPushAttrib (GL_ALL_ATTRIB_BITS );
  glDisable(gl_Lighting);
  glEnable(GL_LINE_SMOOTH);
  XMinIn:=0.0;
  XMaxIn:=DataDraw.XStep*DataDraw.Nx;
  YMinIn:=0.0;//ystart;
  if    FlgGlReadBlock=OneLineScan then YMaxIn:=DataDraw.Ny;
  Axstep:=(XmaxIn-XminIn)*0.2;
  ZMinIn:=0.0;
  //ZMaxIn:=(TopoMax-TopoMin){(DataDraw.DataMax-DataDraw.DataMin)}*DataDraw.ZStep;
        case flgGlReadBlock of
TopoGraphy,
OneLineScan,                                        { TODO : 100406 }
BackPass,
Litho,LithoCurrent        :begin addstr:=siLangLinked1.GetTextOrDefault('IDS_14' { 'nm' }); ZMaxIn:=(TopoMax-TopoMin){(DataDraw.DataMax-DataDraw.DataMin)}*DataDraw.ZStep; end;
FastScan,CurrentSTM       :begin addstr:=siLangLinked1.GetTextOrDefault('IDS_15' { 'nA' )}; ZMaxIn:=(TopoMax-TopoMin){(DataDraw.DataMax-DataDraw.DataMin)}*DataDraw.ZStep; end;
UAM                       :begin addstr:=siLangLinked1.GetTextOrDefault('IDS_16' { 'mV'  )}; ZMaxIn:=(TopoMax-TopoMin){(DataDraw.DataMax-DataDraw.DataMin)}*DataDraw.ZStep; end;
FastScanPhase,Phase       :begin addstr:='';          {ZmaxIn:=1;}                      end;
                                   end;

  { TODO : axis make yaxis  scale  mark depend on Y value }
 if (Ymax<-0.2) then                 begin NaxisY:=1;Aystep:=(YMaxIn-YMinIn)/(NaxisY+1) end ;
 if (-0.2<Ymax) and (Ymax<0)   then  begin NaxisY:=2;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
 if Ymax>0.0    then                 begin NaxisY:=4;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end;

 if (Xmax<-0.3) then                 begin NaxisX:=1;Axstep:=(XmaxIn-XminIn)/(NaxisX+1) end ;
 if (-0.3<Xmax) and (Xmax<0.1) then  begin NaxisX:=2;Axstep:=(XmaxIn-XminIn)/(NaxisX+1) end ;
 if Xmax>0.1    then                 begin NaxisX:=4;Axstep:=(XmaxIn-XminIn)/(NaxisX+1) end;

 if (Zmax<-0.2) then                 begin NaxisZ:=1;Azstep:=(ZMaxIn-ZMinIn)/(NaxisZ+1) end ;
 if (-0.2<Zmax) and (Zmax<0.1) then  begin NaxisZ:=1;Azstep:=(ZmaxIn-ZminIn)/(NaxisZ+1) end ;
 if Zmax>0.1    then                 begin NaxisZ:=3;Azstep:=(ZmaxIn-ZminIn)/(NaxisZ+1) end;

 if  FlgGlReadBlock=OneLineScan then
 case  TopoSpm.FileHeadRcd.HPathMode of
 0: begin
      if (YmaxIn<2)                  then  begin NaxisY:=0;Aystep:=(YMaxIn-YMinIn)/(NaxisY+1) end ;
      if (2<YmaxIn) and (YmaxIn<3)   then  begin NaxisY:=1;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
      if (3<YmaxIn) and (YmaxIn<=5)  then  begin NaxisY:=2;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
      if (5<YmaxIn) and (YmaxIn<10)  then  begin NaxisY:=3;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
      if Ymax>10                     then  begin NaxisY:=4;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end;
    end;
 1: begin
      if (XmaxIn<2)                  then  begin NaxisX:=0;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if (2<XmaxIn) and (XmaxIn<3)   then  begin NaxisX:=1;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if (3<XmaxIn) and (XmaxIn<=5)  then  begin Naxisx:=2;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if (5<XmaxIn) and (XmaxIn<10)  then  begin Naxisx:=3;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if Xmax>10                     then  begin Naxisx:=4;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end;
    end;
         end;
    AxiesSteps(AXstep);   AxiesSteps(AYstep);     AxiesSteps(AZstep);
    AxStepIn:=AxStep;
    AyStepIn:=AyStep;
    AzStepIn:=AzStep;
  for i:=0 to 7 do
   begin
    xAxesScale[i]:=XMinIn+AXstep*i;
    yAxesScale[i]:=YMinIn+AYstep*i;
    zAxesScale[i]:=ZMinIn+AZstep*i;
   end;
   if FlgGLReadBlock<>OneLineScan then
     begin
      if (XmaxIn>YmaxIn) then
      begin
          AxStep:=2*AxStep/(XMaxIn-XMinIn);
          AyStep:=2*AyStep/(YMaxIn-YMinIn)*YMaxIn/XMaxIn;
      end
      else
      begin
          AxStep:=2*AxStep/(XMaxIn-XMinIn)*XMaxIn/YMaxIn;;
          AyStep:=2*AyStep/(YMaxIn-YMinIn);
      end;
     end
     else
     begin
         AxStep:=2*AxStep/(XMaxIn-XMinIn);
         AyStep:=2*AyStep/(YMaxIn-YMinIn);
     end;
  AZstep:=AZStep/(ZMaxIn-ZMinIN);
  glBegin (GL_LINE_STRIP);
  glColor3f(0.0,0.0,0.0);
   s:=Xmin-Axstep;
  while (s<(Xmax-Axstep)) do
   begin
        s:=s+AXstep;
        glVertex3f(s, YMin, ZeroPoint);
        glVertex3f(s, YMin-delta, ZeroPoint);
        glVertex3f(s, YMin, ZeroPoint);
   end;
    glVertex3f (XMax, YMin, ZeroPoint);
    s:=YMin-AYstep;
  while (s<(Ymax-AyStep))   do
   begin
        s:=s+AYStep;
        glVertex3f(XMin, s, ZeroPoint);
        glVertex3f(XMin-delta, s, ZeroPoint);
        glVertex3f(XMin,s, ZeroPoint);
   end;
    glVertex3f (XMin, YMax, ZeroPoint);
  if (FlgView=D3) or (FlgView=D3Geo) then
    begin
      s:=ZeroPoint-AZStep;
    while (s<=(ZMax/ZScaleK-AZStep))
     do
      begin
        s:=s+AZStep;
        glVertex3f (XMin, YMax, s*ZScaleK);
        glVertex3f (XMin-delta,YMAX,s*ZScaleK);
        glVertex3f (XMin, YMax,s*ZScaleK);
//        glVertex3f (XMin, YMax,s+Azstep);
      end;
   end;
  glEnd;
  s:=Xmin-AXStep;
  i:=0;
 while (s<(Xmax-AXStep))
  do
  begin
       s:=s+AXStep;
       glRasterPos3f(s, YMin-10*delta,ZeroPoint );
       OutText (PChar(FloatToStrF((XMinIn+AxStepIn*i),ffFixed,6,0)));
       inc(i);
  end;
  s:=Ymin-AYStep;
  i:=0;
 while (s<(Ymax-AYStep))
  do
  begin
       s:=s+AYStep;
       glRasterPos3f(XMin-12*delta,s, ZeroPoint);
       OutText (PChar(FloatToStrF((YMinIn+AyStepIn*i),ffFixed,6,0)));
       inc(i);
  end;
     glRasterPos3f(Xmax+3*delta, YMin,ZeroPoint);
     OutText (Pchar('X '+DataDraw.CaptionX));
     glRasterPos3f(XMin-0.1,YMax, ZeroPoint) ;
     OutText (Pchar('Y '+DataDraw.CaptionY));
    if  (FlgView=D3) or (FlgView=D3Geo) then
     begin
      glRasterPos3f(XMin,YMax,ZMax+5*delta);
           case flgGlReadBlock of
    Topography,
    BackPass,
    Litho,LithoCurrent:      OutText (pcHAR('Z'+addstr));
    Phase:      OutText (pcHAR(siLangLinked1.GetTextOrDefault('IDS_46' { 'Phase a.u.' } )+addstr));
    UAM:        OutText (pcHAR(siLangLinked1.GetTextOrDefault('IDS_47'  {'Force ' } )+addstr));
    CurrentSTM,
    FastScan:   OutText (pcHAR(siLangLinked1.GetTextOrDefault('IDS_48' {'I ' } )+addstr));
              end;
  s:=Zmin-AZStep;
  i:=0;
  xf:=0;
  if (0.5<ZmaxIn) and (ZmaxIn<5) then xf:=1
   else  if ZmaxIn<0.5   then xf:=2;
  if    ZScaleK>0.5 then
 while (s<(Zmax/ZScaleK-AZStep))
  do
  begin
       s:=s+AZStep;
       glRasterPos3f(XMin-6*delta,YMax+6*delta, S*ZScaleK);
       OutText (PChar(FloatToStrF((ZMinIn+AZStepIn*i),ffFixed,6,xf)));
       inc(i);
  end
  else
   begin
   glRasterPos3f(XMin,YMax,ZMax);
   OutText (PChar(FloattostrF(ITCorGL*ZMaxIn,ffFixed,6,xf)));
   end;
 end;
  glEnable(gl_Lighting);
  glPopAttrib;
  glPopMatrix;
end;
*)
procedure TfrmGL.Axes;//{(DataDraw:TData)};      //nm-micron
var i:integer;
    s,AxStepIn,Axstep,AyStepIn,Aystep,Azstep,AZStepIn,delta:GLFloat;
    xAxesScale,yAxesScale,zAxesScale:array[0..7] of GLFloat;
    addstr,str:ansistring;   // //300813
    NaxisY,NaxisX,NaxisZ,xf:integer;
    ZeroPoint:GlFloat;
 procedure AxiesSteps(var step:GLFloat);
 begin
   if (step<1)                       then begin                                 exit end;
   if (step>=1)     and (step<10)    then begin step:=round(step);              exit end;
   if (step>=10)    and (step<100)   then begin step:=10*round(step/10);        exit end;
   if (step>=100)   and (step<1000)  then begin step:=100*round(step/100);      exit end;
   if (step>=1000)  and (step<10000) then begin step:=1000*round(step/1000);    exit end;
   if (step>=10000) and (step<100000)then begin step:=10000*round(step/10000);  exit end;
   if (step>=100000)                 then begin step:=100000*round(step/100000);exit end;

 end;

begin
  BuildCyrilicFont;
  addstr:=DataDraw.captionZ;
  ZeroPoint:=0.0;
  if flgZZero then ZeroPoint:=-1;
  delta:=0.03;
  glPushMatrix;
  glPushAttrib (GL_ALL_ATTRIB_BITS );
  glDisable(gl_Lighting);
  glEnable(GL_LINE_SMOOTH);
  XMinIn:=0.0;
  XMaxIn:=DataDraw.XStep*DataDraw.Nx;
  YMinIn:=0.0;//ystart;
//  if    FlgGlReadBlock = OneLineScan then   { TODO : 030707 }
if    FlgGlReadBlock in ScanmethodSetOneL then   case  TopoSpm.FileHeadRcd.HPathMode of
 0:YMaxIn:=DataDraw.Ystep*DataDraw.Ny; //YMaxIn:=DataDraw.Ny;        //201213
 1:begin YMaxIn:=DataDraw.yStep*DataDraw.Ny; XMaxIn:=DataDraw.Nx; end;
     end;
  Axstep:=(XmaxIn-XminIn)*0.2;
  ZMinIn:=0.0;
if (flgGlReadBlock in  ScanmethodSetZnm) then begin addstr:=TopoUnitsZ.text; ZMaxIn:=(TopoMax-TopoMin){(DataDraw.DataMax-DataDraw.DataMin)}*DataDraw.ZStep; end
 else
 if (flgGlReadBlock in  ScanmethodSetZAm)then begin addstr:=TopoUnitsZ.text;{'nA' }; ZMaxIn:=(TopoMax-TopoMin){(DataDraw.DataMax-DataDraw.DataMin)}*DataDraw.ZStep; end
   else
   if (flgGlReadBlock in  ScanmethodSetZUAM) then begin addstr:=TopoUnitsZ.text;{ 'mV' } ; ZMaxIn:=(TopoMax-TopoMin){(DataDraw.DataMax-DataDraw.DataMin)}*DataDraw.ZStep; end
    else
     if (flgGlReadBlock in  ScanmethodSetZph) then begin addstr:=TopoUnitsZ.text;{''};          {ZmaxIn:=1;}                      end;

  { TODO : axis make yaxis  scale  mark depend on Y value }
 if (Ymax<-0.2) then                 begin NaxisY:=1;Aystep:=(YMaxIn-YMinIn)/(NaxisY+1) end ;
 if (-0.2<Ymax) and (Ymax<0)   then  begin NaxisY:=2;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
 if Ymax>0.0    then                 begin NaxisY:=4;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end;

 if (Xmax<-0.3) then                 begin NaxisX:=1;Axstep:=(XmaxIn-XminIn)/(NaxisX+1) end ;
 if (-0.3<Xmax) and (Xmax<0.1) then  begin NaxisX:=2;Axstep:=(XmaxIn-XminIn)/(NaxisX+1) end ;
 if Xmax>0.1    then                 begin NaxisX:=4;Axstep:=(XmaxIn-XminIn)/(NaxisX+1) end;

 if (Zmax<-0.2) then                 begin NaxisZ:=1;Azstep:=(ZMaxIn-ZMinIn)/(NaxisZ+1) end ;
 if (-0.2<Zmax) and (Zmax<0.1) then  begin NaxisZ:=1;Azstep:=(ZmaxIn-ZminIn)/(NaxisZ+1) end ;
 if Zmax>0.1    then                 begin NaxisZ:=3;Azstep:=(ZmaxIn-ZminIn)/(NaxisZ+1) end;

 if  FlgGlReadBlock=OneLineScan then
 case  TopoSpm.FileHeadRcd.HPathMode of
 0: begin
      if (YmaxIn<2)                  then  begin NaxisY:=0;Aystep:=(YMaxIn-YMinIn)/(NaxisY+1) end ;
      if (2<YmaxIn) and (YmaxIn<3)   then  begin NaxisY:=1;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
      if (3<YmaxIn) and (YmaxIn<=5)  then  begin NaxisY:=2;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
      if (5<YmaxIn) and (YmaxIn<10)  then  begin NaxisY:=3;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
      if Ymax>10                     then  begin NaxisY:=4;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end;
    end;
 1: begin
      if (XmaxIn<2)                  then  begin NaxisX:=0;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if (2<XmaxIn) and (XmaxIn<3)   then  begin NaxisX:=1;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if (3<XmaxIn) and (XmaxIn<=5)  then  begin Naxisx:=2;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if (5<XmaxIn) and (XmaxIn<10)  then  begin Naxisx:=3;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if Xmax>10                     then  begin Naxisx:=4;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end;
    end;
         end;
    AxiesSteps(AXstep);   AxiesSteps(AYstep);     AxiesSteps(AZstep);
    AxStepIn:=AxStep;
    AyStepIn:=AyStep;
    AzStepIn:=AzStep;
  for i:=0 to 7 do
   begin
    xAxesScale[i]:=XMinIn+AXstep*i;
    yAxesScale[i]:=YMinIn+AYstep*i;
    zAxesScale[i]:=ZMinIn+AZstep*i;
   end;
   if FlgGLReadBlock<>OneLineScan then
     begin
      if (XmaxIn>YmaxIn) then
      begin
          AxStep:=2*AxStep/(XMaxIn-XMinIn);
          AyStep:=2*AyStep/(YMaxIn-YMinIn)*YMaxIn/XMaxIn;
      end
      else
      begin
          AxStep:=2*AxStep/(XMaxIn-XMinIn)*XMaxIn/YMaxIn;;
          AyStep:=2*AyStep/(YMaxIn-YMinIn);
      end;
     end
     else
     begin
         AxStep:=2*AxStep/(XMaxIn-XMinIn);
         AyStep:=2*AyStep/(YMaxIn-YMinIn);
     end;
  AZstep:=AZStep/(ZMaxIn-ZMinIN);
  glBegin (GL_LINE_STRIP);
  glColor3f(0.0,0.0,0.0);
   s:=Xmin-Axstep;
  while (s<(Xmax-Axstep)) do
   begin
        s:=s+AXstep;
        glVertex3f(s, YMin, ZeroPoint);
        glVertex3f(s, YMin-delta, ZeroPoint);
        glVertex3f(s, YMin, ZeroPoint);
   end;
    glVertex3f (XMax, YMin, ZeroPoint);
    s:=YMin-AYstep;
  while (s<(Ymax-AyStep))   do
   begin
        s:=s+AYStep;
        glVertex3f(XMin, s, ZeroPoint);
        glVertex3f(XMin-delta, s, ZeroPoint);
        glVertex3f(XMin,s, ZeroPoint);
   end;
    glVertex3f (XMin, YMax, ZeroPoint);
  if (FlgView=D3) or (FlgView=D3Geo) then
    begin
      s:=ZeroPoint-AZStep;
    while (s<=(ZMax/ZScaleK-AZStep))
     do
      begin
        s:=s+AZStep;
        glVertex3f (XMin, YMax, s*ZScaleK);
        glVertex3f (XMin-delta,YMAX,s*ZScaleK);
        glVertex3f (XMin, YMax,s*ZScaleK);
//        glVertex3f (XMin, YMax,s+Azstep);
      end;
   end;
  glEnd;
  s:=Xmin-AXStep;
  i:=0;
   xf:=0;
  if AXStepIN/TopoUnitsX.coef<1 then xf:=1;
 while (s<(Xmax-AXStep))
  do
  begin
       s:=s+AXStep;
       glRasterPos3f(s, YMin-10*delta,ZeroPoint );
       OutText (PAnsiChar(AnsiString(FloatToStrF((XMinIn+AxStepIn*i)/TopoUnitsX.coef,ffFixed,6,xf))));
       inc(i);
  end;
  s:=Ymin-AYStep;
  i:=0;
  xf:=0;
  if AYStepIN/TopoUnitsY.coef<1 then xf:=1;
 while (s<(Ymax-AYStep))
  do
  begin
       s:=s+AYStep;
       glRasterPos3f(XMin-12*delta,s, ZeroPoint);
       OutText (PAnsiChar(AnsiString(FloatToStrF((YMinIn+AyStepIn*i)/TopoUnitsY.coef,ffFixed,6,xf))));
       inc(i);
  end;
     glRasterPos3f(Xmax+3*delta, YMin,ZeroPoint);
     str:=AnsiString('X ')+AnsiString(TopoUnitsX.text);
     OutText (PAnsichar(str));
     glRasterPos3f(XMin-0.1,YMax, ZeroPoint) ;
     str:=AnsiString('Y ')+AnsiString(TopoUnitsY.text);
     OutText (PAnsichar(str));
    if  (FlgView=D3) or (FlgView=D3Geo) then
     begin
      glRasterPos3f(XMin,YMax,ZMax+5*delta);

if (flgGlReadBlock in  ScanmethodSetZnm) then
 begin str:=AnsiString('Z ')+TopoUnitsZ.text; OutText (pAnsiCHAR(str));end
 else
 if (flgGlReadBlock in  ScanmethodSetZAm)then
  begin
  str:=AnsiString(siLangLinked1.GetTextOrDefault('IDS_48' {* 'I ' *} ))+TopoUnitsZ.text;
  OutText (pAnsiCHAR(str)) end
   else
   if (flgGlReadBlock in  ScanmethodSetZUAM) then
    begin
    str:=AnsiString(siLangLinked1.GetTextOrDefault('IDS_47' {* 'Force ' *}  ))+TopoUnitsZ.text{addstr};
     OutText (pAnsiCHAR(str)); end
    else
     if (flgGlReadBlock in  ScanmethodSetZph) then
      begin
      str:=AnsiString(siLangLinked1.GetTextOrDefault('IDS_53' {* 'Phase ' *} ))+TopoUnitsZ.text{addstr};
      OutText(pAnsiCHAR(str))    end;


   s:=Zmin-AZStep;
  i:=0;
  xf:=0;
   if (0.5<ZmaxIn/TopoUnitsZ.coef) and (ZmaxIn/TopoUnitsZ.coef<5) then xf:=1
                 else  if ZmaxIn/TopoUnitsZ.coef<0.5   then xf:=2;

 if    ZScaleK>0.5 then
 while (s<(Zmax/ZScaleK-AZStep))
  do
  begin
       s:=s+AZStep;
       glRasterPos3f(XMin-6*delta,YMax+6*delta, S*ZScaleK);
       OutText (PAnsiChar(AnsiString(FloatToStrF((ZMinIn+AZStepIn*i)/TopoUnitsZ.coef,ffFixed,6,xf))));
       inc(i);
  end
  else
   begin
   glRasterPos3f(XMin,YMax,ZMax);
   OutText (PAnsiChar(AnsiString(FloattostrF(ITCorGL*ZMaxIn/TopoUnitsZ.coef,ffFixed,6,xf))));
   end;
 end;
  glEnable(gl_Lighting);
  glPopAttrib;
  glPopMatrix;
end;    //axis

//
(* 11/09/13
procedure TfrmGL.Axes;//{(DataDraw:TData)};      //nm-micron
var i:integer;
    s,AxStepIn,Axstep,AyStepIn,Aystep,Azstep,AZStepIn,delta:GLFloat;
    xAxesScale,yAxesScale,zAxesScale:array[0..7] of GLFloat;
    addstr:string;
    NaxisY,NaxisX,NaxisZ,xf:integer;
    ZeroPoint:GlFloat;
 procedure AxiesSteps(var step:GLFloat);
 begin
   if (step<1)                       then begin                                 exit end;
   if (step>=1)     and (step<10)    then begin step:=round(step);              exit end;
   if (step>=10)    and (step<100)   then begin step:=10*round(step/10);        exit end;
   if (step>=100)   and (step<1000)  then begin step:=100*round(step/100);      exit end;
   if (step>=1000)  and (step<10000) then begin step:=1000*round(step/1000);    exit end;
   if (step>=10000) and (step<100000)then begin step:=10000*round(step/10000);  exit end;
   if (step>=100000)                 then begin step:=100000*round(step/100000);exit end;

 end;
begin
  addstr:=DataDraw.captionZ;
  ZeroPoint:=0.0;
  if flgZZero then ZeroPoint:=-1;
  delta:=0.03;
  glPushMatrix;
  glPushAttrib (GL_ALL_ATTRIB_BITS );
  glDisable(gl_Lighting);
  glEnable(GL_LINE_SMOOTH);
  XMinIn:=0.0;
  XMaxIn:=DataDraw.XStep*DataDraw.Nx;
  YMinIn:=0.0;//ystart;
//  if    FlgGlReadBlock = OneLineScan then   { TODO : 030707 }
if    FlgGlReadBlock in ScanmethodSetOneL then   case  TopoSpm.FileHeadRcd.HPathMode of
 0: YMaxIn:=DataDraw.Ny;
 1:begin YMaxIn:=DataDraw.yStep*DataDraw.Ny; XMaxIn:=DataDraw.Nx; end;
     end;
  Axstep:=(XmaxIn-XminIn)*0.2;
  ZMinIn:=0.0;
  //ZMaxIn:=(TopoMax-TopoMin){(DataDraw.DataMax-DataDraw.DataMin)}*DataDraw.ZStep;

if (flgGlReadBlock in  ScanmethodSetZnm) then begin addstr:=TopoUnitsZ.text; ZMaxIn:=(TopoMax-TopoMin){(DataDraw.DataMax-DataDraw.DataMin)}*DataDraw.ZStep; end
 else
 if (flgGlReadBlock in  ScanmethodSetZAm)then begin addstr:=TopoUnitsZ.text;{'nA' }; ZMaxIn:=(TopoMax-TopoMin){(DataDraw.DataMax-DataDraw.DataMin)}*DataDraw.ZStep; end
   else
   if (flgGlReadBlock in  ScanmethodSetZUAM) then begin addstr:=TopoUnitsZ.text;{ 'mV' } ; ZMaxIn:=(TopoMax-TopoMin){(DataDraw.DataMax-DataDraw.DataMin)}*DataDraw.ZStep; end
    else
     if (flgGlReadBlock in  ScanmethodSetZph) then begin addstr:=TopoUnitsZ.text;{''};          {ZmaxIn:=1;}                      end;

  { TODO : axis make yaxis  scale  mark depend on Y value }
 if (Ymax<-0.2) then                 begin NaxisY:=1;Aystep:=(YMaxIn-YMinIn)/(NaxisY+1) end ;
 if (-0.2<Ymax) and (Ymax<0)   then  begin NaxisY:=2;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
 if Ymax>0.0    then                 begin NaxisY:=4;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end;

 if (Xmax<-0.3) then                 begin NaxisX:=1;Axstep:=(XmaxIn-XminIn)/(NaxisX+1) end ;
 if (-0.3<Xmax) and (Xmax<0.1) then  begin NaxisX:=2;Axstep:=(XmaxIn-XminIn)/(NaxisX+1) end ;
 if Xmax>0.1    then                 begin NaxisX:=4;Axstep:=(XmaxIn-XminIn)/(NaxisX+1) end;

 if (Zmax<-0.2) then                 begin NaxisZ:=1;Azstep:=(ZMaxIn-ZMinIn)/(NaxisZ+1) end ;
 if (-0.2<Zmax) and (Zmax<0.1) then  begin NaxisZ:=1;Azstep:=(ZmaxIn-ZminIn)/(NaxisZ+1) end ;
 if Zmax>0.1    then                 begin NaxisZ:=3;Azstep:=(ZmaxIn-ZminIn)/(NaxisZ+1) end;

 if  FlgGlReadBlock=OneLineScan then
 case  TopoSpm.FileHeadRcd.HPathMode of
 0: begin
      if (YmaxIn<2)                  then  begin NaxisY:=0;Aystep:=(YMaxIn-YMinIn)/(NaxisY+1) end ;
      if (2<YmaxIn) and (YmaxIn<3)   then  begin NaxisY:=1;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
      if (3<YmaxIn) and (YmaxIn<=5)  then  begin NaxisY:=2;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
      if (5<YmaxIn) and (YmaxIn<10)  then  begin NaxisY:=3;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end ;
      if Ymax>10                     then  begin NaxisY:=4;Aystep:=(YmaxIn-YminIn)/(NaxisY+1) end;
    end;
 1: begin
      if (XmaxIn<2)                  then  begin NaxisX:=0;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if (2<XmaxIn) and (XmaxIn<3)   then  begin NaxisX:=1;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if (3<XmaxIn) and (XmaxIn<=5)  then  begin Naxisx:=2;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if (5<XmaxIn) and (XmaxIn<10)  then  begin Naxisx:=3;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end ;
      if Xmax>10                     then  begin Naxisx:=4;Axstep:=(xMaxIn-xMinIn)/(NaxisX+1) end;
    end;
         end;
    AxiesSteps(AXstep);   AxiesSteps(AYstep);     AxiesSteps(AZstep);
    AxStepIn:=AxStep;
    AyStepIn:=AyStep;
    AzStepIn:=AzStep;
  for i:=0 to 7 do
   begin
    xAxesScale[i]:=XMinIn+AXstep*i;
    yAxesScale[i]:=YMinIn+AYstep*i;
    zAxesScale[i]:=ZMinIn+AZstep*i;
   end;
   if FlgGLReadBlock<>OneLineScan then
     begin
      if (XmaxIn>YmaxIn) then
      begin
          AxStep:=2*AxStep/(XMaxIn-XMinIn);
          AyStep:=2*AyStep/(YMaxIn-YMinIn)*YMaxIn/XMaxIn;
      end
      else
      begin
          AxStep:=2*AxStep/(XMaxIn-XMinIn)*XMaxIn/YMaxIn;;
          AyStep:=2*AyStep/(YMaxIn-YMinIn);
      end;
     end
     else
     begin
         AxStep:=2*AxStep/(XMaxIn-XMinIn);
         AyStep:=2*AyStep/(YMaxIn-YMinIn);
     end;
  AZstep:=AZStep/(ZMaxIn-ZMinIN);
  glBegin (GL_LINE_STRIP);
  glColor3f(0.0,0.0,0.0);
   s:=Xmin-Axstep;
  while (s<(Xmax-Axstep)) do
   begin
        s:=s+AXstep;
        glVertex3f(s, YMin, ZeroPoint);
        glVertex3f(s, YMin-delta, ZeroPoint);
        glVertex3f(s, YMin, ZeroPoint);
   end;
    glVertex3f (XMax, YMin, ZeroPoint);
    s:=YMin-AYstep;
  while (s<(Ymax-AyStep))   do
   begin
        s:=s+AYStep;
        glVertex3f(XMin, s, ZeroPoint);
        glVertex3f(XMin-delta, s, ZeroPoint);
        glVertex3f(XMin,s, ZeroPoint);
   end;
    glVertex3f (XMin, YMax, ZeroPoint);
  if (FlgView=D3) or (FlgView=D3Geo) then
    begin
      s:=ZeroPoint-AZStep;
    while (s<=(ZMax/ZScaleK-AZStep))
     do
      begin
        s:=s+AZStep;
        glVertex3f (XMin, YMax, s*ZScaleK);
        glVertex3f (XMin-delta,YMAX,s*ZScaleK);
        glVertex3f (XMin, YMax,s*ZScaleK);
//        glVertex3f (XMin, YMax,s+Azstep);
      end;
   end;
  glEnd;
  s:=Xmin-AXStep;
  i:=0;
   xf:=0;
  if AXStepIN/TopoUnitsX.coef<1 then xf:=1;
 while (s<(Xmax-AXStep))
  do
  begin
       s:=s+AXStep;
       glRasterPos3f(s, YMin-10*delta,ZeroPoint );
       OutText (PChar(FloatToStrF((XMinIn+AxStepIn*i)/TopoUnitsX.coef,ffFixed,6,xf)));
       inc(i);
  end;
  s:=Ymin-AYStep;
  i:=0;
  xf:=0;
  if AYStepIN/TopoUnitsY.coef<1 then xf:=1;
 while (s<(Ymax-AYStep))
  do
  begin
       s:=s+AYStep;
       glRasterPos3f(XMin-12*delta,s, ZeroPoint);
       OutText (PChar(FloatToStrF((YMinIn+AyStepIn*i)/TopoUnitsY.coef,ffFixed,6,xf)));
       inc(i);
  end;
     glRasterPos3f(Xmax+3*delta, YMin,ZeroPoint);
     OutText (Pchar('X '+TopoUnitsX.text));
     glRasterPos3f(XMin-0.1,YMax, ZeroPoint) ;
     OutText (Pchar('Y '+TopoUnitsY.text));
    if  (FlgView=D3) or (FlgView=D3Geo) then
     begin
      glRasterPos3f(XMin,YMax,ZMax+5*delta);

if (flgGlReadBlock in  ScanmethodSetZnm) then begin OutText (pcHAR('Z'+TopoUnitsZ.text));end
 else
 if (flgGlReadBlock in  ScanmethodSetZAm)then begin OutText (pcHAR(siLangLinked1.GetTextOrDefault('IDS_48' {* 'I ' *} )+TopoUnitsZ.text{addstr})) end
   else
   if (flgGlReadBlock in  ScanmethodSetZUAM) then begin OutText (pcHAR(siLangLinked1.GetTextOrDefault('IDS_47' {* 'Force ' *} )+TopoUnitsZ.text{addstr})); end
    else
     if (flgGlReadBlock in  ScanmethodSetZph) then begin OutText(pcHAR(siLangLinked1.GetTextOrDefault('IDS_53' {* 'Phase ' *} )+TopoUnitsZ.text{addstr}))    end;


   s:=Zmin-AZStep;
  i:=0;
  xf:=0;
   if (0.5<ZmaxIn/TopoUnitsZ.coef) and (ZmaxIn/TopoUnitsZ.coef<5) then xf:=1
                 else  if ZmaxIn/TopoUnitsZ.coef<0.5   then xf:=2;

 if    ZScaleK>0.5 then
 while (s<(Zmax/ZScaleK-AZStep))
  do
  begin
       s:=s+AZStep;
       glRasterPos3f(XMin-6*delta,YMax+6*delta, S*ZScaleK);
       OutText (PChar(FloatToStrF((ZMinIn+AZStepIn*i)/TopoUnitsZ.coef,ffFixed,6,xf)));
       inc(i);
  end
  else
   begin
   glRasterPos3f(XMin,YMax,ZMax);
   OutText (PChar(FloattostrF(ITCorGL*ZMaxIn/TopoUnitsZ.coef,ffFixed,6,xf)));
   end;
 end;
  glEnable(gl_Lighting);
  glPopAttrib;
  glPopMatrix;
end;    //axis
*)
procedure TfrmGl.Line(var ln:single);
 var
   ns,ms,ne,me:integer;
   txs,tys,tye,txe:single;
   strline:string;
   v,tn{,ln}, zV:single;
   deltax,deltay, deltaZ:single;
 begin
    ScreenToSpace( MouseXStart,MouseYStart,XS,YS);
    ScreenToSpace( MouseXEnd,MouseYEnd,XE,YE);
    if (xe/scale)>xmax then xe:=xmax*scale;
    if ye/scale>ymax then ye:=ymax*scale;
    if xs/scale<xmin then xs:=xmin*scale;
    if ys/scale<ymin then ys:=ymin*scale;
    if xe/scale<xmin then xe:=xmin*scale;
    if ye/scale<ymin then ye:=ymin*scale;
    ns:=round((xs/scale+1.0)/dx);
    ms:=round((ys/scale+1.0)/dy);
    ne:=round((xe/scale+1.0)/dx);
    me:=round((ye/scale+1.0)/dy);

    txs:=(xs/scale+1.0)/dx;
    tys:=(ys/scale+1.0)/dy;
    txe:=(xe/scale+1.0)/dx;
    tye:=(ye/scale+1.0)/dy;

    NxStart:=ns;
    NyStart:=ms;
    NxEnd:=ne;
    NyEnd:=me;
   //ln:=sqrt(sqr((ns-ne)*DataDraw.XStep)+sqr((ms-me)*DataDraw.YStep));
    ln:=sqrt(sqr((txs-txe)*DataDraw.XStep)+sqr((tys-tye)*DataDraw.YStep));
    deltax:= (txs-txe)*DataDraw.XStep;
    deltay:= (tys-tye)*DataDraw.YStep;
// Вычисление перепада по Z, введено 25/12/2013
// выводится в заголовке окна
    if (txe > 0) and (txs > 0) and (tye > 0) and (tys > 0) and
      (txe < DataDraw.Nx) and (txs < DataDraw.Nx) and (tye < DataDraw.Ny) and (tys < DataDraw.Ny) then
             deltaZ:= DataDraw.data[round(txe), round(tye)]- Datadraw.data[round(txs), round(tys)];


    glPushAttrib (GL_ALL_ATTRIB_BITS );
    glLineWidth(1.0);
    glDisable(GL_LIGHTING);
    glColor3f(1,0,0);
    glBegin (GL_LINE_STRIP);
     glVertex3f (XS,YS,-1.0);
     glVertex3f (XE,YE,-1.0);
    glEnd;
    glEnable(GL_LIGHTING);
    glPopAttrib;
  if FlgRule then
   begin
    if  flgGlReadBlock=OneLineScan then
    begin

       case  TopoSpm.FileHeadRcd.HPathMode of
Multi,
OneX:begin
       ln:=(ns-ne)*DataDraw.XStep;
       tn:=abs(ms-me)*DataDraw.YStep+(ln/TopoSpm.FileHeadRcd.HScanRate);
       if tn=0 then v:=1 else v:=abs(ln)/tn;
       Caption:= 'dx=' +FloatToStrF(abs(ln),ffFixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_57' (* ' nm; ' *) )+ siLangLinked1.GetTextOrDefault('IDS_58' (* ' Time=' *) )+
       FloatToStrF(tn,ffFixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_59' (* ' s; v=' *) )+FloatToStrF(v,ffFixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_60' (* ' nm/s' *) );
      end;
MultiY,
OneY:begin
       ln:=(ms-me)*DataDraw.YStep;
       tn:=abs(ns-ne)*DataDraw.XStep+(ln/TopoSpm.FileHeadRcd.HScanRate);
       if tn=0 then  v:=1 else v:=abs(ln)/tn;
        Caption:= 'dy=' +FloatToStrF(abs(ln),ffFixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_57' (* ' nm; ' *) )+ siLangLinked1.GetTextOrDefault('IDS_58' (* ' Time=' *) )+
        FloatToStrF(tn,ffFixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_59' (* ' s; v=' *) )+FloatToStrF(v,ffFixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_60' (* ' nm/s' *) );
      end;
      end;
       if tn=0 then zV:=1 else zV:=abs(deltaZ/tn);
     Caption:=Caption +siLangLinked1.GetTextOrDefault('IDS_39' (* '; dZ= ' *) )  + FloatToStrF((deltaz),ffFixed,8,3) + ' ' + DataDraw.captionZ+
                           siLangLinked1.GetTextOrDefault('IDS_40' (* '; zV= ' *) )+ FloatToStrF((zV),ffFixed,8,3) + DataDraw.captionZ+'/'+str_s ;
    end
    else
    begin
      StrLine:='l= '+FloatToStrF(ln,ffFixed,8,3);
      Caption:=strline+siLangLinked1.GetTextOrDefault('IDS_66' (* ' nm' *) )+' dx='+FloatToStrF(abs(deltax),ffFixed,8,3)+';dy='+FloatToStrF(abs(deltay),ffFixed,8,3);
      Caption:=Caption +siLangLinked1.GetTextOrDefault('IDS_43' (* ' ;dZ= ' *) )  + FloatToStrF((deltaz),ffFixed,8,3)+ ' ' + DataDraw.captionZ;
    end;

  end;
end;

procedure TfrmGl.LineA();
 var
   ns,ms,ne,me,ne2,me2:integer;
   strline:string;
   a,b,c,angl:single;
 begin
   ScreenToSpace( MouseXStart,MouseYStart,XS,YS);
   ScreenToSpace( MouseXEnd,MouseYEnd,XE,YE);
   ScreenToSpace( MouseXEnd2,MouseYEnd2,XE2,YE2);
   if (xe2/scale)>xmax then xe2:=xmax*scale;
    if ye2/scale>ymax then  ye2:=ymax*scale;
    if xs/scale<xmin then xs:=xmin*scale;
     if ys/scale<ymin then ys:=ymin*scale;
       if xe2/scale<xmin then xe2:=xmin*scale;
         if ye2/scale<ymin then ye2:=ymin*scale;
  ns:=round((xs/scale+1.0)/dx);
    ms:=round((ys/scale+1.0)/dy);
    ne:=round((xe/scale+1.0)/dx);
    me:=round((ye/scale+1.0)/dy);
    ne2:=round((xe2/scale+1.0)/dx);
    me2:=round((ye2/scale+1.0)/dy);
    NxStart:=ns;
    NyStart:=ms;
    NxEnd:=ne;
    NyEnd:=me;
    a:=sqrt(sqr((ns-ne2)*DataDraw.XStep)+sqr((ms-me2)*DataDraw.YStep));
    b:=sqrt(sqr((ns-ne)*DataDraw.XStep)+sqr((ms-me)*DataDraw.yStep));
    c:=sqrt(sqr((ne-ne2)*DataDraw.XStep)+sqr((me-me2)*DataDraw.YStep));
    angl:=0;
    if (b>0) and (c>0) then angl:=arccos( (sqr(a)-sqr(b)-sqr(c))*0.5/b/c);
  glPushAttrib (GL_ALL_ATTRIB_BITS );
  glLineWidth(1.0);
  glDisable(GL_LIGHTING);
  glColor3f(1,0,0);
  glBegin (GL_LINE_STRIP);
  glVertex3f (XS,YS,-1.0);
  glVertex3f (XE,YE,-1.0);
  glVertex3f (XE2,YE2,-1.0);
  glEnd;
  glEnable(GL_LIGHTING);
  glPopAttrib;
  angl:=pi-angl;
  StrLine:=FloatToStrF(angl,ffFixed,8,3);
  Caption:=siLangLinked1.GetTextOrDefault('IDS_67' (* 'angle=' *) )+FloatToStrF(180/pi*angl,ffFixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_68' (* '°; ' *) )+strline+siLangLinked1.GetTextOrDefault('IDS_69' (* ' radian;' *) );
end;

procedure TfrmGL.Quad();
var
     ns,ms,ne,me:integer;
     label 100;
begin
    ScreenToSpace( MouseXStart,MouseYStart,XS,YS);
    ScreenToSpace( MouseXEnd,MouseYEnd,XE,YE);
 //   if xs>xmax then xs:=xmax;
 //    if ys>ymax then ys:=ymax;
    if (xe/scale)>xmax then xe:=xmax*scale;
    if ye/scale>ymax   then ye:=ymax*scale;
    if xs/scale<xmin   then xs:=xmin*scale;
    if ys/scale<ymin   then ys:=ymin*scale;
    if xe/scale<xmin   then xe:=xmin*scale;
    if ye/scale<ymin   then ye:=ymin*scale;
    ns:=round((xs/scale+1.0)/dx);
    ms:=round((ys/scale+1.0)/dy);
    ne:=round((xe/scale+1.0)/dx);
    me:=round((ye/scale+1.0)/dy);

   if (ns>nend) and (ms>mend) and (me>mend) and (ne>nend) then
     begin NxStart:=0; NyStart:=0; NxEnd:=0; NyEnd:=0; exit; end;
     if ns<0    then ns:=0;
     if ms<0    then ms:=0;
     if ns>nend then ns:=nend;
     if ms>mend then ms:=mend;
     if ne<0    then ne:=0;
     if me<0    then me:=0;
     if ne>nend then ne:=nend;
     if me>mend then me:=mend;
    NxStart:=MIN(ns,ne);
    NyStart:=MIN(ms,me);
    NxEnd:=MAX(ns,ne);
    NyEnd:=MAX(ms,me);
 100: glPushAttrib (GL_ALL_ATTRIB_BITS );
  glLineWidth(1.0);
  glDisable(GL_LIGHTING);
  glColor3f(1,0,0); //   glColor3f(1,0,0);
  glBegin (GL_LINE_STRIP);
  glVertex3f (XS,YS,-1.0);
  glVertex3f (XE,YS,-1.0);
  glVertex3f (XE,YE,-1.0);
  glVertex3f (XS,YE,-1.0);
  glVertex3f (XS,YS,-1.0);
  glEnd;
  glEnable(GL_LIGHTING);
  glPopAttrib;
end;

procedure TfrmGL.NonVisibleLine();
 var
   ns,ms,ne,me:integer;
   txs,tys,tye,txe:single;
begin
    ScreenToSpace( MouseXStart,MouseYStart,XS,YS);
    ScreenToSpace( MouseXEnd,MouseYEnd,XE,YE);
    ns:=round((xs/scale+1.0)/dx);
    ms:=round((ys/scale+1.0)/dy);
    ne:=round((xe/scale+1.0)/dx);
    me:=round((ye/scale+1.0)/dy);

    txs:=(xs/scale+1.0)/dx;
    tys:=(ys/scale+1.0)/dy;
    txe:=(xe/scale+1.0)/dx;
    tye:=(ye/scale+1.0)/dy;

    NxStart:=ns;
    NyStart:=ms;
    NxEnd:=ne;
    NyEnd:=me;
end;

procedure  TfrmGL.GradientLine();
var
   ns,ms,ne,me:integer;
   txs,tys,tye,txe:single;
   strline:string;
   v,tn,ln:single;
begin
    ScreenToSpace( MouseXStart,MouseYStart,XS,YS);
    ScreenToSpace( MouseXEnd,MouseYEnd,XE,YE);
    ns:=round((xs/scale+1.0)/dx);
    ms:=round((ys/scale+1.0)/dy);
    ne:=round((xe/scale+1.0)/dx);
    me:=round((ye/scale+1.0)/dy);

    txs:=(xs/scale+1.0)/dx;
    tys:=(ys/scale+1.0)/dy;
    txe:=(xe/scale+1.0)/dx;
    tye:=(ye/scale+1.0)/dy;

    NxStart:=ns;
    NyStart:=ms;
    NxEnd:=ne;
    NyEnd:=me;
   //ln:=sqrt(sqr((ns-ne)*DataDraw.XStep)+sqr((ms-me)*DataDraw.YStep));
    ln:=sqrt(sqr((txs-txe)*DataDraw.XStep)+sqr((tys-tye)*DataDraw.YStep));

    glPushAttrib (GL_ALL_ATTRIB_BITS );
    glLineWidth(3.0);
    glDisable(GL_LIGHTING);
    glColor3f(1,0,0);
    glBegin (GL_LINE_STRIP);
     glVertex3f (XS,YS,-1.0);
  //  glColor3f(1,1,0);   ////
     glVertex3f (XE,YE,-1.0);
    glEnd;
    glEnable(GL_LIGHTING);
    glPopAttrib;
end;



procedure TfrmGL.Cube ({mode : GLenum});
 begin
  glPushMatrix;
  glPushAttrib (GL_ALL_ATTRIB_BITS );
  glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
  glEnable(GL_LINE_SMOOTH);
  glMaterialfv (GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @ColorAxes);

  // рисование шести сторон куба
  glBegin (GL_QUADS);
    glVertex3f (1.0, 1.0, 1.0);
    glVertex3f (-1.0, 1.0, 1.0);
    glVertex3f (-1.0, -1.0, 1.0);
    glVertex3f (1.0, -1.0, 1.0);
  glEnd;

  glBegin (GL_QUADS);
   glVertex3f (1.0, 1.0, -1.0);
   glVertex3f (1.0, -1.0, -1.0);
   glVertex3f (-1.0, -1.0, -1.0);
   glVertex3f (-1.0, 1.0, -1.0);
  glEnd;

  glBegin (GL_QUADS);
   glVertex3f (-1.0, 1.0, 1.0);
   glVertex3f (-1.0, 1.0, -1.0);
   glVertex3f (-1.0, -1.0, -1.0);
   glVertex3f (-1.0, -1.0, 1.0);
  glEnd;

  glBegin (GL_QUADS);
   glVertex3f (1.0, 1.0, 1.0);
   glVertex3f (1.0, -1.0, 1.0);
   glVertex3f (1.0, -1.0, -1.0);
   glVertex3f (1.0, 1.0, -1.0);
  glEnd;

  glBegin (GL_QUADS);
   glVertex3f (-1.0, 1.0, -1.0);
   glVertex3f (-1.0, 1.0, 1.0);
   glVertex3f (1.0, 1.0, 1.0);
   glVertex3f (1.0, 1.0, -1.0);
  glEnd;

  glBegin(GL_QUADS);
   glVertex3f (-1.0, -1.0, -1.0);
   glVertex3f (1.0, -1.0, -1.0);
   glVertex3f (1.0, -1.0, 1.0);
   glVertex3f (-1.0, -1.0, 1.0);
  glEnd;
   glPopAttrib;
   glPopMatrix;
end;

procedure TfrmGL.DrawSurface();
var i:integer;
begin
    for i:=0 to  listcount-1 do glCallList(list[i]);
end;

procedure   TfrmGL.InitMaterials;
const
// Lambient : Array[0..3] of GLfloat = (0.0, 0.0, 0.0, 1.0);
// Ldiffuse : Array[0..3] of GLfloat = (1.0, 1.0, 1.0, 1.0);
// ambient  : Array[0..3] of GLfloat = ( 0.1, 0.1, 0.1, 1.0 );
// diffuse  : Array[0..3] of GLfloat = ( 0.5, 1.0, 1.0, 1.0 );
   //spotdirection       : array[0..2] of GLfloat;// = ( 1.0, 1.0, 1.0 );
   lmodel_ambient      : array[0..3] of GLfloat = ( 1.0, 1.0, 1.0, 1.0 );
var spotdirection       : array[0..2] of GLfloat;
begin
 glLightfv(GL_LIGHT0, GL_AMBIENT,  @gl1Ambient);
 glLightfv(GL_LIGHT0, GL_DIFFUSE,  @gl1Diffuse);
 glLightfv(GL_LIGHT0, GL_POSITION, @position0);
//if (flgView=D3) or (flgView=D3Top) then
 glEnable(GL_LIGHT0);
 glLightfv(GL_LIGHT1, GL_AMBIENT,  @gl1Ambient);
 glLightfv(GL_LIGHT1, GL_DIFFUSE,  @gl1Diffuse);
 glLightfv(GL_LIGHT1, GL_POSITION, @position1);
 glLightf(GL_LIGHT1, GL_SPOT_CUTOFF,90);
 spotdirection[0]:=-position1[0];
 spotdirection[1]:=-position1[1];
 spotdirection[2]:=-position1[2];
 glLightfV(GL_LIGHT1, GL_SPOT_DIRECTION,@spotdirection);
 glLightfv(GL_LIGHT1, GL_POSITION, @position1);
 glEnable(GL_LIGHT1);
 glLightModelfv(GL_LIGHT_MODEL_AMBIENT, @lmodel_Ambient);
//if (flgView=D3) or (flgView=D3Top) then
 glEnable(GL_LIGHTING);
 glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, @front_mat_emission);
 glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS,@front_mat_shininess);
 glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, @front_mat_specular);
 glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,  @front_mat_diffuse);
 glMaterialfv(GL_FRONT_AND_BACK, GL_ambient,  @front_mat_ambient);
end;

procedure   TfrmGL.Init;
begin
  glClearColor(1.0, 1.0, 1.0, 0.0);   //0->1 090102
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_NORMALIZE);
//  glEnable(GL_SCISSOR_TEST);
  InitMaterials;
  flgAxes := True;    // показывать ли ось
  FlgCube:=False;
  FlgQuad:=False;
  FlgLine:=False;
 if FlgView=D3 then
  begin
   glMatrixMode(GL_PROJECTION);
   glLoadIdentity;
   glViewport(ClientX0,ClientY0, ClientHW, ClientHW);
 //  glScissor(ClientX0,ClientY0, ClientHW, ClientHW);
   glFrustum(vLeft,vRight,vBottom,vTop,vNear,vFar  );
   glMatrixMode(GL_MODELVIEW);
   glLoadIdentity;
   glTranslatef( 0.0, 0.0, -7.5 );
  end
 else
  begin
   glMatrixMode(GL_PROJECTION);
   glLoadIdentity;
   glViewport(ClientX0,ClientY0, ClientHW, ClientHW);
 //  glScissor(ClientX0,ClientY0, ClientHW, ClientHW);
   glMatrixMode(GL_MODELVIEW);
   glLoadIdentity;
  end;
end;

{=======================================================================
Формат пикселя}
procedure TfrmGl.SetDCPixelFormat (hdc : HDC);
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  :={PFD_SUPPORT_GDI or }PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 pfd.iLayerType := PFD_MAIN_PLANE;      //051010  for windows7 screen capture
 nPixelFormat := ChoosePixelFormat (hdc, @pfd);
 SetPixelFormat (hdc, nPixelFormat, @pfd);
 //DescribePixelFormat(DC, nPixelFormat, sizeof(TPixelFormatDescriptor), pfd);
 // NColors:= 1 shl pfd.cColorBits;
end;
procedure TfrmGl.OutText (Litera : PansiChar);
//var Ln:integer;
begin
   glListBase(Cyrilic);
// glListBase(GLF_START_LIST);
 //  ln:=Length (Litera);
   glCallLists(Length (Litera),{GL_UNSIGNED_SHORT}GL_UNSIGNED_BYTE, Litera);
(*
   glListBase(GLF_START_LIST);
   glCallLists(Length (Litera), GL_UNSIGNED_BYTE, Litera);
*)
end;

procedure TfrmGL.DrawScene;//(DataDraw:TData);
var ps:PAINTSTRUCT;
     i:integer;
  
begin
 DC:=GetDC(Handle);
 wglMakeCurrent(DC, hrc);
  BeginPaint(Handle, ps);
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glPushMatrix;
     case FlgView of
 D3,D3Geo:begin
             glRotatef( yrot, 0.0, 1.0, 0.0 );
             glRotatef( xrot, 1.0, 0.0, 0.0 );
             glRotatef( zrot, 0.0, 0.0, 1.0 );
             DrawSurface();
          end
      else
          begin
             glScale(scale,scale,scale);
             DrawSurface();
           if FlgCut  then
            begin
             glPushMatrix;
             glScale(1/scale,1/scale,1/scale);
             if flgQuad  and flgAction then  Quad;
             for i:=0 to ArFrmFragLoc.Count-1 do
              begin
                 PtFrag:=ArFrmFragLoc.Items[i];
                 glCallList(PtFrag^.GLList);
              end;
               glPopMatrix;
            end;
           if FlgSection   then
            begin
            glPushMatrix;
            glScale(1/scale,1/scale,1/scale);
            if flgline and flgAction then Line(lengthline);
            for i:=0 to ArFrmSectLoc.Count-1 do
             begin
              PtSect:=ArFrmSectLoc.Items[i];
              glCallList(PtSect^.GLList);
             end;
             glPopMatrix;
            end;
           if FlgRule  and flgAction then
            begin
             glPushMatrix;
             glScale(1/scale,1/scale,1/scale);
             if flgline then Line(lengthline);
             glPopMatrix;
           end;
           if FlgAngle  and flgAction then
            begin
             glPushMatrix;
             glScale(1/scale,1/scale,1/scale);
             case  CountAnglePoints of
             1: line(lengthline);
             3: lineA();
               end;
               glPopMatrix;
            end;
          end;
                    end;//case

   if flgAxes then  Axes;
   if FlgCube then  Cube;

   glPopMatrix;

   SwapBuffers(DC);

  EndPaint (Handle,ps);
  wglMakeCurrent(0, 0);
 ReleaseDC(handle,DC);
end;

 {================================================Перерисовка окна}
procedure TfrmGL.WMPaint(var Msg: TWMPaint);
begin
  DrawScene;
end;

procedure TfrmGL.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var OldCaption:string;
begin
//   wglMakeCurrent(DC, hrc);
     OldCaption:=Caption;
 { TODO : 30/08/08 }
(*     if   (ssAlt in Shift) then
     begin
       CopyToClipBoard;
       DragFormToSave:=TDragFormToSave.Create(Application);
       DragFormToSave.Show;
     end;
     *)
 { TODO : 30/08/08 }
     case Key of
VK_ESCAPE:Close;
VK_LEFT:  begin
           yrot := yrot -  steprot;
           Caption:='X='+FloattoStr(Xrot)+' Y='+FloatToStr(Yrot)+' Z='+FloattoStr(Zrot);
           InvalidateRect(Handle, nil, False);
          end;
VK_RIGHT: begin
           yrot := yrot +  steprot;
           Caption:='X='+FloattoStr(Xrot)+' Y='+FloatToStr(Yrot)+' Z='+FloattoStr(Zrot);
           InvalidateRect(Handle, nil, False);
         end;
VK_UP :  begin
           xrot := xrot +  steprot;
           Caption:='X='+FloattoStrF(Xrot,ffFixed,4,0)+' Y='+FloatToStrF(Yrot,ffFixed,4,0)+' Z='+FloattoStrF(Zrot,ffFixed,4,0);
           InvalidateRect(Handle, nil, False);
         end;
VK_DOWN: begin
           xrot := xrot - steprot;
           Caption:='X='+FloattoStrF(Xrot,ffFixed,4,0)+' Y='+FloatToStrF(Yrot,ffFixed,4,0)+' Z='+FloattoStrF(Zrot,ffFixed,4,0);
           InvalidateRect(Handle, nil, False);
         end;
Ord('Z'):begin
          if ssShift in Shift then  zrot := zrot - steprot
                              else  zrot := zrot + steprot;
          Caption:='X='+FloattoStrF(Xrot,ffFixed,4,0)+' Y='+FloatToStrF(Yrot,ffFixed,4,0)+' Z='+FloattoStrF(Zrot,ffFixed,4,0);
          InvalidateRect(Handle, nil, False);
         end;
Ord ('M'):begin
           if ssShift in Shift then   zmov:=zmov+stepmov
                               else   zmov:=zmov-stepmov;
           InvalidateRect(Handle, nil, False);
          end;
Ord ('S'):begin
           DC:=GetDC(Handle);
            if ssShift in Shift then   {scale:=0.8//} glScalef(0.8,0.8,0.8)
                               else   {scale:=1.2;//}glScalef(1.2,1.2,1.2);
            InvalidateRect(Handle, nil, False);
           ReleaseDC(Handle,DC);
          end;
Ord ('B'):begin
(*   If ssCtrl in Shift then    glSCalef(1.0,1.0,0.8)
    else glSCalef(1.0,1.0,1.2); *)
          InvalidateRect(Handle, nil, False);
         end;
Ord ('L'):begin
           InvalidateRect(Handle, nil, False);
          end;
Ord ('T'):begin
           InvalidateRect(Handle, nil, False);
          end;

              end; //of
  Caption:=OldCaption;
end;
//procedure TfrmGL.WMEXITSIZEMOVE(var message: TMessage);
procedure TfrmGL.FormResize(Sender: TObject);
begin
 SetGLWindows;
 DC:=GetDC(handle);
  wglMakeCurrent(DC, hrc);
  glViewport(ClientX0,ClientY0, ClientHW, ClientHW);
 // glScissor(ClientX0,ClientY0, ClientHW, ClientHW);
  wglMakeCurrent(0, 0);
 InvalidateRect(Handle, nil, False);
 ReleaseDC(handle,DC);
   Panel.Height:=ClientHeight;
   Panel.Left:=ClientWidth-Panel.Width;     
   PanelGrd.Height:=Panel.ClientHeight*2 div 3;
   PanelGrd.Top:=Panel.ClientHeight-round(PanelGrd.Height*(2-scale));
   PanelGrd.Left:=0;
   PanelIm.Left:=PanelGrd.width-PanelIm.width;
   LabelMean.Top:=PanelGrd.ClientHeight div 2;
   GradientRect (FromRGB,ToRGB,ImageGRGL.Canvas,ZMinGr,ZMaxGr);
   Application.processmessages;
end;

procedure TfrmGL.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var H:Hwnd;
begin
    if assigned(ArFrmFragLoc) then
     if ArFrmFragLoc.Count<>0 then
       begin
         siLangLinked1.ShowMessage(strgl1{'Close all Fragments of the Image!'});
         CanClose:=False;
       end;
   H:=FindWindow(nil,Pchar('Image Analysis '+Caption));
   if h<>0 then
   begin
    StopAnalysis;
    if assigned(ImageTools) then ImageTools.SpeedBtnData.Enabled:=true;   { TODO : 031007 }
  end;
end;



procedure TfrmGL.FormCreate(Sender: TObject);
begin
  UpdateStrings;

end;

procedure TfrmGL.FormDblClick(Sender: TObject);
begin
 Main. miFullScreenClick;
 Height:=round(Screen.Height);
 Width:=round(Screen.Height);
 InvalidateRect(Handle, nil, False);
end;

procedure TfrmGL.FormDeactivate(Sender: TObject);
begin
// flgAction:=false;
// Main.ActionExport.enabled:=false;
// Main.ActionSaveAs.enabled:=false;
 if flgInvert then  caption:=ExtractFileName(FileNameGL)+AddCaption+strinvert
              else  caption:=ExtractFileName(FileNameGL)+AddCaption ;
end;

procedure TfrmGL.FormClose(Sender: TObject; var Action: TCloseAction);
var i,j,count:integer;
    Frm:TfrmGL;
    FrmS:TSection;
    H:Hwnd;
begin   { TODO : 250907 }
 with  TopoSPM do
  begin
   if  assigned(ArFileNameEdit) then
    begin
     count:=ArFileNameEdit.Count;
     for i := (Count - 1)  downto 1 do
      begin
       PntFileName := ArFileNameEdit.Items[i];
       DeleteFile(PntFileName^.FileName);
       PntFileName^.FileName:='';
       Dispose(PntFileName);
      end;
  ///  300907
       PntFileName := ArFileNameEdit.Items[0];
       PntFileName^.FileName:='';
       Dispose(PntFileName);
 ////
    ArFileNameEdit.Clear;
   end;
   if (Pos('Fragment_' ,FileNameGL)<>0) then DeleteFile(FileNameGL);;
  end;
 if assigned(ParentFragW) then
  begin
   Count:=ParentFragW.ArFrmFragLoc.Count;
    for i:=(Count-1) downto 0 do                    //delete fraq picture on the picture
     begin
      PtFrag:=ParentFragW.ArFrmFragLoc.Items[i];
       Frm:=TfrmGL(PtFrag.Frag);         { TODO : 300907 }
    if Frm.Caption=self.Caption then    { TODO : 300907 }
       begin
         glDeleteLists(PtFrag^.GLList,1);
         PtFrag.Frag:=nil;
         dispose(ptFrag);       { TODO : 250907 }
         ParentFragW.ArFrmFragLoc.Delete(i);
         InvalidateRect(ParentFragW.handle,nil,false);
       end;
     end;
 end;
 if assigned(ArFrmSectLoc) then  { TODO : 021007 }
  if ArFrmSectLoc.Count<>0 then
   begin
     Count:=ArFrmSectLoc.Count;
    for i:=(Count-1) downto 0 do
      begin
       PtSect:=ArFrmSectLoc.Items[i];
       FrmS:=PTSect.Sect;
       FrmS.Close;
       Frms.ParentSectW:=nil;
     end;
    glDeleteLists(LineList[0],LineListCount);
    ArFrmSectLoc.Clear;
   end;
    FreeAndNil(ArFrmSectLoc);
    FreeAndNil(ArFrmFragLoc);
    ArFrmGl.Remove(self);
    if ArScanFrm.count>0 then
    begin
      count:= ArScanFrm.count;
      for i:=0 to count - 1 do
        if ArScanFrm.items[i]=self then
        begin
         ArScanFrm.delete(i);
         dec(CountClose);
         break;
        end;
    end;    //????
   if ArFrmGl.Count>1 then TfrmGL(ArFrmGl.items[ArFrmGl.count-1]).Activate;  { TODO : 031007 }

  if (ArFrmSpectr.count=0)  and   (ArFrmGl.count=0) then
   begin
    Main.ActionImageTools.Visible:=false;
    Main.ArrangeWindows1.Enabled:=False;
    Main.ActionPrint.Enabled:=true;
   end;
  if ArFrmGl.Count=0 then
   begin
    Main.ActionImageTools.Visible:=false;
    Main.FileInfItem.Enabled:=False;
    Main.ActionPrint.Enabled:=true;
    ActiveGlW:=nil;;
   if assigned(ImageTools) then
    begin
    ImageTools.close;
//     if assigned(ScaleGL) then ScaleGL.close;   080410
//     Application.processmessages;
     ToolsPanel.checked:=False;
    end;
   end;
 if listcount<>0 then glDeleteLists(list[0],listcount);
 glDeleteLists(GLF_START_LIST,256);
 wglMakeCurrent(0, 0);
 wglDeleteContext(hrc);
 ReleaseDC (Handle, DC);
 DeleteDC (DC);
 FreeAndNil(TopoSPM);
 DataDraw:=nil;
 //DataDraw.free;
 Finalize(List);        { TODO : 250907 }
 List:=nil;
 Finalize(LineList);   { TODO : 250907 }
 LineList:=nil;
 Finalize(QuadList); { TODO : 250907 }
 QuadList:=nil;
 Action:=caFree;
 FlgClose:=True;
 Frm:=nil;
 FrmS:=nil;
 self:=nil;

end;

procedure TfrmGL.FormActivate(Sender: TObject);
var i:integer;
begin
// Main.ActionExport.enabled:=true;
// Main.ActionExportToMDT.enabled:=true;
// Main.ActionSaveAs.enabled:=true;
 ActiveGLW:=self;
 NRed:=LNRed;
 NBlue:=LNBlue;
 NGreen:=LNGreen;
 PaletteName:=PaletteNameGLW;
 for i:=1 to NRed do
  begin
   XR[i]:=LXR[i];
   YR[i]:=LYR[i];
  end;
 for i:=1 to NGreen do
  begin
   XG[i]:=LXG[i];
   YG[i]:=LYG[i];
  end;
 for i:=1 to NBlue do
  begin
   XB[i]:=LXB[i];
   YB[i]:=LYB[i];
  end;
 for i:=1 to MaxVal do
  begin
    RDistr[i]:=LRDistr[i-1];
    GDistr[i]:=LGDistr[i-1];
    BDistr[i]:=LBDistr[i-1];
  end;

 if flgFormActivateFirst then
 begin
   if (FlgView=D2Geo) or (flgView=D3Geo) then
      begin
       mLights.visible:=false;
       mMaterial.visible:=false;
       mSetPalette.visible:=true;
       pLights.visible:=false;
       pMaterial.visible:=false;
       pSetPalette.visible:=true;
      end
      else
      begin
       mLights.visible:=true;
       mMaterial.visible:=true;
       mSetPalette.visible:=FALSE;
       pLights.visible:=true;
       pMaterial.visible:=true;
       pSetPalette.visible:=false;
      end;

  if assigned(ImageTools) then
   begin
      case FlgView of
    D2Geo:begin
           ImageTools.SpeedBtnL.visible:=false;
           ImageTools.SpeedBtnM.visible:=false;
           ImageTools.SpeedBtnPal.visible:=true;
           ImageTools.SpeedBtn2DG.Down:=true;
          end;
    D3Geo:begin
           ImageTools.SpeedBtnL.visible:=false;
           ImageTools.SpeedBtnM.visible:=false;
           ImageTools.SpeedBtnPal.visible:=true;
           ImageTools.SpeedBtn3DG.Down:=true;
          end;
    D3Top:begin
           ImageTools.SpeedBtnPal.visible:=false;
           ImageTools.SpeedBtnL.visible:=true;
           ImageTools.SpeedBtnM.visible:=true;
           ImageTools.SpeedBtn2D.Down:=true;
          end;
    D3:   begin
            ImageTools.SpeedBtnPal.visible:=false;
            ImageTools.SpeedBtnL.visible:=true;
            ImageTools.SpeedBtnM.visible:=true;
            ImageTools.SpeedBtn3D.Down:=true;
          end;
                   end;
         ImageTools.SpeedBtnFrag.enabled:= not FlgOneLineScan;
         ImageTools.SpeedBtnSect.enabled:= not FlgOneLineScan;
         ImageTools.SpeedBtnAngle.enabled:=not FlgOneLineScan;
         Imagetools.MirrorY.Checked:=FlgMirrorY;
         Imagetools.MirrorX.Checked:=FlgMirrorX;

      if ImageTools.PanelContrust.Visible then
       begin
         ImageTools.ZTrackBarLeft.position:=TrackBarL;
         ImageTools.ZTrackBarRight.position:=TrackBarR;
         ImageTools.ReDrawGr;
       end;
     if assigned(vSetMaterialOpt)then
        begin
         UpdatevMaterialOpt;
        end;
     if assigned(ScaleGL) then
        begin
         ScaleGL.TrackBarSc.position:=ZScaleP;
(*         if flgGlReadBlock<>Topography then ScaleGL.label1.Caption:=siLangLinked1.GetTextOrDefault('IDS_88' {* 'Minimum' *} )
                                       else ScaleGL.label1.Caption:=siLangLinked1.GetTextOrDefault('IDS_89' {* 'Real Scale' *} );
       end;
*)
       if flgGlReadBlock in ScanmethodSetZnm then ScaleGL.label1.Caption:=siLangLinked1.GetTextOrDefault('IDS_89' {* 'Real Scale' *} )
                                            else ScaleGL.label1.Caption:=siLangLinked1.GetTextOrDefault('IDS_88' {* 'Minimum' *} );
       end;
       if assigned(LightOption)    then LightOption.UpdatePosition;
       if assigned(PaletteForm)    then PaletteForm.ReDraw;
        ImageTools.SpeedBtnFrag.Down:=FlgCut;
        ImageTools.SpeedBtnSect.Down:=FlgSection;
        ImageTools.SpeedBtnRule.Down:=FlgRule;
        ImageTools.SpeedBtnRubber.Down:=FlgRubber;
        ImageTools.SpeedBtnAngle.Down:=FlgAngle;
        ImageTools.BitBtnInvert.down:=flgInvert;
        ImageTools.Renishawdiagnbtn.Visible:=Topospm.FileHeadRcd.HAquiRenishaw;// and flgRenishawCorrected;
        ImageTools.Update;
   end;
    if assigned( FileHeaderForm)then
     begin
       FileHeaderForm.ReadParam( FileNameGL);
       FileHeaderForm.Refresh;
     end;
 end;
 flgFormActivateFirst:=True;
end;

procedure TfrmGL.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var xe,ye:GlFloat;
    i:integer;
    h:HWND;
begin
   if (Button=mbLeft) and (ssAlt in Shift) then        // copy to clipboard    for report
         begin
           flgDragForm:=true;
           if Assigned(ReportForm) then
             begin
                Panel.BeginDrag(False);
                Main.CopyToClipBoardExecute(self);
                ReportForm.CaptureSourceImage(Panel);
             end;
           flgDragForm:=false;
        end
        else
          case  Button of
    mbLeft:begin
             FlgMouseDown:=true;

            if not FlgFirstMouseDown   then
             begin
              inc(CountAnglePoints);
               case CountAnglePoints of
           1:begin
              MouseXStart:=x; MouseYStart:=y;
              MouseXEnd:=x; MouseYEnd:=y;
             end;
           3:begin
              MouseXEnd2:=x; MouseYEnd2:=y;
             end;
                     end;
            ScreenToSpace( MouseXStart,MouseYStart,XS,YS);
            FlgAction:=(xs/scale>xmin) and (ys/scale>ymin)  and (xs/scale<xmax) and (ys/scale<ymax);
            FlgFirstMouseDown:= True;
           end;
              case FlgView of
    D3,D3Geo: begin
               xrot0:=xrot;
               zrot0:=zrot;
              end
              else
              begin
               ScreenToSpace( x,y,XE,YE);
              end;
                end;    //case
                InvalidateRect(Handle, nil, False);

             if FlgRubber then
              SaveCurrentPict();
              end;
 mbRight:     begin
                  FormActivate(Sender);
              end;
                  end;   //case
end;

function  TfrmGL.MouseIntoSPMImage(x,y:GlFloat):boolean;
var xt,yt:GLFloat;
begin
  ScreenToSpace( x,y,Xt,Yt);
  result:=((xt/scale>xmin) and (yt/scale>ymin) and (xt/scale<xmax) and (yt/scale<ymax));
end;

procedure TfrmGL.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
if   MouseIntoSPMImage(x,y) then cursor:=crAimCursor
                            else cursor:=cursorsaved;
      if not flgMouseDown then exit;
        case CountAnglePoints of
      1:begin MouseXEnd :=x; MouseYEnd :=y;  end;
      3:begin MouseXEnd2:=x; MouseYEnd2:=y;  end;
                  end;
            FlgQuad:=False;
            FlgLine:=False;
       case FlgView of
 D3,D3Geo: begin
            FlgCube:=True;
            xrot:=xrot0-(MouseYEnd-MouseYStart)*0.3;
            zrot:=zrot0+(MouseXEnd-MouseXStart)*0.3;
           end
   else      // 2DView
     begin
       if (abs(MouseXEnd-MouseXStart)>10) or (abs(MouseYEnd-MouseYStart)>10)
        then
         begin
          if  FlgCut                then begin FlgQuad:=True; FlgLine:=False end;
          if (FlgSection or FlgRule or FlgAngle)
                                    then begin FlgLine:=True; FlgQuad:=False end;
          end
     end;
             end; //case
      InvalidateRect(Handle, nil, False);
end;
procedure TfrmGL.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
(*  if assigned(ReportForm)and DragFlag then
   begin
       Panel.EndDrag(false);
       DragFlag:=False;
   end;
   *)
  if Button=mbLeft then
   begin
         inc(CountAnglePoints);
         case CountAnglePoints of
      2:begin
          MouseXEnd:=x; MouseYEnd:=y;
        end;
      4:begin MouseXEnd2:=x; MouseYEnd2:=y;end;
           end;

      if FlgAngle then  begin if CountAnglePoints=4 then   CountAnglePoints:=0;end
                  else  begin    CountAnglePoints:=0;end
            end;

        FlgMouseDown:=False;
      case FlgView of
 D3,D3Geo: begin
            FlgFirstMouseDown:=False;
            Caption:=ExtractFileName(FileNameGL)+AddCaption;
            FlgCube:=False;
            InvalidateRect(Handle, nil, False);
          end
    else
          begin
            FlgFirstMouseDown:=False;
           if FlgQuad and FlgCut  and flgAction then
             begin
               FlgFirstMouseDown:=False;
               CutSurface(Sender);
               FlgMouseMove:=False;
               FlgQuad:=False;
             end;
          if FlgSection and FlgLine and flgAction then
             begin
                CutSection(Sender);
                FlgMouseMove:=False;
                FlgLine:=False;
             end;
          if FlgRubber then
              begin
                 FlgMouseMove:=False;
                 FlgFirstMouseDown:=False;
                 FlgNewLnRubberDraw:=True;
                 FlgNewArRubberDraw:=True;
                DC:=GetDC(handle);
                 NonVisibleLine();
                 if flgArRubber then ArRubberAction(DataDraw)
                                else LnRubberAction(DataDraw);

                 InitSurface;
                 flgModify:=true;
                 InvalidateRect(Handle, nil, False);
                 CopyDataDrawToTopo;
                ReleaseDC(Handle,DC);
              end;
     end;
  end;
end;

procedure TfrmGL.View2DGeoClick(Sender: TObject);
var   addstr:string;
       R,G,B:byte;
begin
       Panel.Visible:=true;
       mLights.visible:=false;
       mMaterial.visible:=false;
       mSetPalette.visible:=true;
       pLights.visible:=false;
       pMaterial.visible:=false;
       pSetPalette.visible:=true;
  if FlgView<>D2Geo then
  begin
   Panel.Width:=PanelGrdWidth+10;   //10
   width:=width+Panel.Width;;
   Panel.left:=ClientWidth-Panel.Width;
  end;
    GradientRect (FromRGB, ToRGB,ImageGrGl.Canvas,ZMinGr,ZMaxGr);
    GradientLabels;
    MouseXStart:=0; MouseYStart:=0; MouseXEnd:=0; MouseYEnd:=0;
    FlgView:=D2Geo;
    GeoView.checked:=True;
    Geo3DView.checked:=False;
    View3D.checked:=False;
    View3DTop.checked:=False;

   SetGLWindows;

  DC:=GetDC(handle);
   wglMakeCurrent(DC, hrc);
    glDisable(gl_Lighting);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity;
    glViewport(ClientX0,ClientY0, ClientHW,ClientHW);
  //  glScissor(ClientX0,ClientY0, ClientHW, ClientHW);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity;
    wglMakeCurrent(DC, hrc);
    InvalidateRect(Handle, nil, False);
 ReleaseDC(handle,DC);
   if assigned(ImageTools) then
    begin
     ImageTools.SpeedBtnPal.visible:=true;
     ImageTools.SpeedBtnL.visible:=false;
     ImageTools.SpeedBtnM.visible:=false;
     ImageTools.SpeedBtn2DG.Down:=true;
   end;
   if assigned(vSetMaterialOpt) then vSetMaterialOpt.close;
   if assigned(LightOption)     then LightOption.close;
end;

procedure TfrmGL.View3DClick(Sender: TObject);
begin
    width:=width-Panel.Width;
    Panel.Width:=0;
    SetGLWindows;
    MouseXStart:=0;MouseYStart:=0;MouseXEnd:=0;MouseYEnd:=0;
    Geo3DView.checked:=False;
    GeoView.checked:=False;
    View3D.checked:=True;
    View3DTop.checked:=False;
    mLights.visible:=true;
    mMaterial.visible:=true;
    mSetPalette.visible:=false;
    pLights.visible:=true;
    pMaterial.visible:=true;
    pSetPalette.visible:=false;
    if FlgCut     then CutFragmentClick(sender);
    if FlgSection then CutSectionClick(sender);
  DC:=GetDC(Handle);
   wglMakeCurrent(DC, hrc);
    glEnable(gl_Lighting);
    FlgView:=D3;
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity;
    glViewport(ClientX0,ClientY0, ClientHW,ClientHW);
 //   glScissor(ClientX0,ClientY0, ClientHW, ClientHW);
    glFrustum(vLeft,vRight,vBottom,vTop,vNear,vFar  );
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity;
    glTranslatef( 0.0, 0.0, -8.0 );
    wglMakeCurrent(0, 0);
    InvalidateRect(Handle, nil, False);
  ReleaseDC(Handle,DC);
  if assigned(ImageTools) then
    begin
     ImageTools.SpeedBtnPal.visible:=false;
     ImageTools.SpeedBtnL.visible:=true;
     ImageTools.SpeedBtnM.visible:=true;
     ImageTools.SpeedBtn3D.Down:=true;
    end;
  if assigned(PaletteForm) then PaletteForm.close;
end;

procedure TfrmGL.View3DTopClick(Sender: TObject);
begin
 width:=width-Panel.Width;
 Panel.Width:=0;
 SetGLWindows;
   MouseXStart:=0;MouseYStart:=0;MouseXEnd:=0;MouseYEnd:=0;
    Geo3DView.checked:=False;
    GeoView.checked:=False;
    View3D.checked:=False;
    View3DTop.checked:=True;
       mLights.visible:=true;
       mMaterial.visible:=true;
       mSetPalette.visible:=false;
       pLights.visible:=true;
       pMaterial.visible:=true;
       pSetPalette.visible:=false;

 DC:=GetDC(Handle);
  wglMakeCurrent(DC, hrc);
    glEnable(gl_Lighting);
    FlgView:=D3Top;
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity;
    glViewport(ClientX0,ClientY0, ClientHW, ClientHW);
  //  glScissor(ClientX0,ClientY0, ClientHW, ClientHW);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity;
   wglMakeCurrent(0, 0);
    InvalidateRect(Handle, nil, False);
 ReleaseDC(Handle,DC);
  if assigned(ImageTools) then
    begin
     ImageTools.SpeedBtnPal.visible:=false;
     ImageTools.SpeedBtnL.visible:=true;
     ImageTools.SpeedBtnM.visible:=true;
     ImageTools.SpeedBtn2D.Down:=true;
   end;
  if assigned(PaletteForm) then PaletteForm.close;
end;


procedure TfrmGL.View3DGeoClick(Sender: TObject);
begin
 width:=width-Panel.Width;
 Panel.Width:=0;
 SetGLWindows;
 mLights.visible:=false;
 mMaterial.visible:=false;
 mSetPalette.visible:=true;
 pLights.visible:=false;
 pMaterial.visible:=false;
 pSetPalette.visible:=true;
    MouseXStart:=0;MouseYStart:=0;MouseXEnd:=0;MouseYEnd:=0;
    FlgView:=D3Geo;
    Geo3DView.checked:=True;
    GeoView.checked:=False;
    View3D.checked:=False;
    View3DTop.checked:=False;
    if FlgCut     then CutFragmentClick(sender) ;
    if FlgSection then CutSectionClick(sender);
 DC:=GetDC(Handle);
   wglMakeCurrent(DC, hrc);
    glDisable(gl_Lighting);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity;
    glViewport(ClientX0,ClientY0, ClientHW,ClientHW);
 //   glScissor(ClientX0,ClientY0, ClientHW, ClientHW);
    glFrustum(vLeft,vRight,vBottom,vTop,vNear,vFar  );
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity;
    glTranslatef( 0.0, 0.0, -8.0 );
   wglMakeCurrent(0,0);
  InvalidateRect(Handle, nil, False);
 ReleaseDC(Handle,DC);
 if assigned(ImageTools) then
    begin
     ImageTools.SpeedBtnPal.visible:=true;
     ImageTools.SpeedBtnL.visible:=false;
     ImageTools.SpeedBtnM.visible:=false;
     ImageTools.SpeedBtn3DG.Down:=true;
   end;
   if assigned(vSetMaterialOpt) then vSetMaterialOpt.close;
   if assigned(LightOption)     then LightOption.close;
end;

procedure TfrmGL.MedianClick(Sender: TObject);
var filename,ImFileNameOut:string;
begin
   if FlgNewLnRubberDraw then
   begin
    SaveCurrentPict();
    FlgNewLnRubberDraw:=False;
   end;
  if FlgNewArRubberDraw then
   begin
    SaveCurrentPict();
    FlgNewArRubberDraw:=False;
   end;
  DC:=GetDC(handle);
    MedianFilt3(DataDraw.Nx,DataDraw.Ny,DataDraw.Data, FiltFileName);      //x->y
    inc(CountUndo);
    new(PntFileName);
    fileName:=ExtractFileName( FileNameGL);
    CutExtention(FileName,ImFileNameOut);
    PntFileName^.FileName:=TempDirectory+ImFileNameOut+IntToStr(CountUndo)+'.tmp';
    TopoSPM.ArFileNameEdit.Add(PntFileName);
    TopoSPM.ImFileName:=PntFileName^.FileName;
    TopoSPM.WorkFileName:=PntFileName^.FileName;
    //for version <12 do not work undo
    TopoSPM.SaveExperiment;
    InitSurface;//(DataDraw);
    InvalidateRect(Handle, nil, False);
    GradientLabels;
    CopyDataDrawToTopo;
    flgModify:=true;
  ReleaseDc(Handle,DC);
end;

procedure TfrmGL.PlaneDeleteClick(Sender: TObject);
var ImFileNameOut,filename:string;
begin
  if FlgNewLnRubberDraw then
   begin
    SaveCurrentPict();
    FlgNewLnRubberDraw:=False;
   end;
  if FlgNewArRubberDraw then
   begin
    SaveCurrentPict();
    FlgNewArRubberDraw:=False;
   end;
   DC:=GetDC(handle);
    DelFiltPlane(DataDraw.Nx,DataDraw.Ny,DataDraw.Data, FiltFileName) ;  //x->y
    inc(CountUndo);
    new(PntFileName);
    FileName:=ExtractFileName( FileNameGL);
    CutExtention(FileName,ImFileNameOut);
    PntFileName^.FileName:=TempDirectory+ImFileNameOut+IntToStr(CountUndo)+'.tmp';
 //  CutExtention(FileNameGL,ImFileNameOut);
 //  PntFileName^.FileName:=ImFileNameOut+IntToStr(CountUndo);
    TopoSpm.ArFileNameEdit.Add(PntFileName);
    TopoSpm.ImFileName:=PntFileName^.FileName;
    TopoSpm.WorkFileName:=PntFileName^.FileName;
    TopoSpm.SaveExperiment;
 //   Dispose(PntFileName);
    InitSurface;//(DataDraw);
    flgModify:=true;
    InvalidateRect(Handle, nil, False);
    GradientLabels;
    CopyDataDrawToTopo;
 ReleaseDC(Handle,DC);
end;

procedure TfrmGL.SurfaceDeleteClick(Sender: TObject);
var ImFileNameOut,FileName:string;
 NX,NY,k,i,j:integer;
begin
 NX:=DataDraw.Nx;
 Ny:=DataDraw.NY;
 if FlgNewLnRubberDraw then
   begin
    SaveCurrentPict();
    FlgNewLnRubberDraw:=False;
   end;
 if FlgNewArRubberDraw then
   begin
    SaveCurrentPict();
    FlgNewArRubberDraw:=False;
   end;
 DC:=GetDC(handle);
    Del2xSurface(NX,NY,DataDraw.Data, FiltFileName);
    inc(CountUndo);
    new(PntFileName);
    fileName:=ExtractFileName( FileNameGL);
    CutExtention(FileName,ImFileNameOut);
    PntFileName^.FileName:=TempDirectory+ImFileNameOut+IntToStr(CountUndo)+'.tmp';
    TopoSPM.ArFileNameEdit.Add(PntFileName);
    TopoSPM.ImFileName:=PntFileName^.FileName;
    TopoSPM.WorkFileName:=PntFileName^.FileName;
    TopoSpm.SaveExperiment;
    InitSurface;
    flgModify:=true;
    InvalidateRect(Handle, nil, False);
    GradientLabels;
    CopyDataDrawToTopo;
  ReleaseDc(Handle,DC);
end;

procedure TfrmGL.UndoClick(Sender: TObject);
begin
//undo don't work for data version <12  AMPGainZ????
 if CountUndo>0 then
   begin
    dec(CountUndo);
    with TopoSpm do
    begin  { TODO : 300907 }
       PntFileName := ArFileNameEdit.Items[ArFileNameEdit.Count-1];
       DeleteFile(PntFileName^.FileName);
       PntFileName^.FileName:='';
       Dispose(PntFileName);
        { TODO : 300907 }
     ArFileNameEdit.Delete(ArFileNameEdit.Count-1);//   ????
     PntFileName:=ArFileNameEdit.items[ArFileNameEdit.Count-1];//????   -1
     ImFileName:=PntFileName^.FileName;
 //    ArFileNameEdit.Delete(ArFileNameEdit.Count-1);//   ????
    end;
   DC:=GetDC(handle);
    wglMakeCurrent(DC, hrc);
    Init;
    wglMakeCurrent(0,0);
    TopoSPM.ReadSurface(FlgGLReadBlock);

    AddCaption:='';
     { TODO : 261108 }

(*
     case      FlgGlReadBlock   of
 TopoGraphy,
 Litho,
 LithoCurrent:begin
                TopoSpm.FileHeadRcd.HAquiTopo:=True;
                TopoSpm.FileHeadRcd.HAquiAdd:=0;
                DataDraw:=TopoSPM.AquiTopo;
              end;
 Phase,
 UAM,
 BackPass,
 WorkF,
 CurrentSTM,
 FastScan,
 FastScanPhase:begin
                 TopoSpm.FileHeadRcd.HAquiTopo:=False;
                 DataDraw:=TopoSPM.AquiAdd;
               end;
               end;  //of
*)

         if (flgGlReadBlock in  ScanmethodSetAdd) then
               begin
                 TopoSpm.FileHeadRcd.HAquiTopo:=False;
                 DataDraw:=TopoSPM.AquiAdd;
              end
              else
              begin
                TopoSpm.FileHeadRcd.HAquiTopo:=True;
                TopoSpm.FileHeadRcd.HAquiAdd:=0;
                DataDraw:=TopoSPM.AquiTopo;
              end;
      AddCaption:=DataDraw.caption;
      if (TopoSpm.FileHeadRcd.HPathMode=Multi) OR (TopoSpm.FileHeadRcd.HPathMode=MultiY) then
              if  TopoSpm.FileHeadRcd.SecondPass then  AddCaption:=AddCaption+' II Pass';

if TopoSpm.FileHeadRcd.HAquiRenishaw and (CountUndo=0) then
if TopoSpm.FileHeadRcd.HStepXY<= TopoSpm.FileHeadRcd.HRenishawPeriod*TopoSpm.FileHeadRcd.HRenishawSensorPos{240} then //(RenishawParams.Periodnm*RenishawParams.ReniShawScale) then
begin
  ReniShawcorrection;
end;
     InitSurface;//(DataDraw);

     case     flgView of
         D3: View3DClick(Sender) ;
      D3Geo: View3DGeoClick(Sender) ;
      D2Geo: View2DGeoClick(Sender) ;
      D3Top: View3DTopClick(Sender);
                end;
//     if flgInvert then  Caption:=Caption+strinvert;
     InvalidateRect(Handle, nil, False);//Refresh;
     GradientLabels;
   ReleaseDc(Handle,DC);
 end;
end;

procedure TfrmGL.CutFragmentClick(Sender: TObject);
begin
    SectionCut.checked:=false;
    SectionCutPP.checked:=false;
    Angle.checked:=False;
    AnglePP.checked:=False;
    Rule.checked:=False;
    RulePP.checked:=False;
    FragmentCut.checked:=not  FragmentCut.checked;
    FragmentCutPP.checked:=not  FragmentCutPP.checked;
   if assigned(ImageTools)   then ImageTools.SpeedBtnFrag.Down:=not  ImageTools.SpeedBtnFrag.Down;
    FlgCut:=not FlgCut;
    FlgSection:=False;
    FlgAngle:=false;
    FlgRule:=False;
    FlgRubber:=False;
  if FlgCut then
    begin
      if (FlgView=D3)   then  View3DTopClick(Sender);
      if (FlgView=D3Geo)then  View2DGeoClick(Sender);
    end;
     if flgInvert then  caption:=ExtractFileName(FileNameGL)+AddCaption+strinvert
                  else  caption:=ExtractFileName(FileNameGL)+AddCaption ;
//       if flgInvert then  caption:=ExtractFileName(FileNameGL)+AddCaption+' Invert.' ;
 // Caption:=ExtractFileName(FileNameGL)+AddCaption;
end;

procedure TfrmGL.CutSectionClick(Sender: TObject);
begin
      SectionCut.checked:=not SectionCut.checked;
      SectionCutPP.checked:=not SectionCutPP.checked;
      FragmentCut.checked:=False;
      FragmentCutPP.checked:=False;
      Angle.checked:=False;
      AnglePP.checked:=False;
      Rule.checked:=False;
      RulePP.checked:=False;
   if assigned(ImageTools)   then ImageTools.SpeedBtnSect.Down:=not  ImageTools.SpeedBtnSect.Down;
      flgSection:=not flgSection;
      flgRule:=false;
      flgLine:=not flgLine;
      FlgRubber:=False;
      flgAngle:=false;
      flgCut:=False;
     if flgSection then
      begin
       if (FlgView=D3)   then View3DTopClick(Sender);
       if (FlgView=D3Geo)then View2DGeoClick(Sender);
      end;
      if flgInvert then  caption:=ExtractFileName(FileNameGL)+AddCaption+strinvert
                   else  caption:=ExtractFileName(FileNameGL)+AddCaption ;
end;

procedure TfrmGL.ContrastClick(Sender: TObject);
begin
    if not assigned(ImageTools) then
      begin
       ImageTools:=TImageTools.Create(application);
 //      ImageTools.BitBtnContrClick(Sender);
 //      ImageTools.BitBtnContr.Down:=not ImageTools.BitBtnContr.Down;
     end;
         ImageTools.BitBtnContrClick(Sender);
         ImageTools.BitBtnContr.Down:=not ImageTools.BitBtnContr.Down;
 end;

procedure TfrmGL.Contrast(Sender: TObject);
var t:GLFLoat;
begin
    ZContrMax:=(255-ImageTools.ZTrackBarLeft.position)/255;
    ZContrMin:=(255-ImageTools.ZTrackBarRight.position)/255;
    ZMinGr:=ImageTools.ZTrackBarLeft.position;
    ZMaxGr:=ImageTools.ZTrackBarRight.position;
    t:=ZContrMax;
 if ZContrMax<ZContrMin then
    begin
     ZContrMax:=ZContrMin;
     ZContrMin:=t;
    end;
   DC:=GetDC(handle);
   InitSurface;
   ReleaseDc(Handle,DC);
       case flgView of
     D3:   begin View3DGeoClick(Sender);    end;
     D3Top:begin View2DGeoClick(Sender)     end;
     else  InvalidateRect(Handle, nil, False);
                end;
   if flgView=D2Geo then  GradientRect (FromRGB, ToRGB,ImageGrGl.Canvas,ZMinGr,ZMaxGr);
end;

procedure TfrmGL.CopyToFileClick(Sender: TObject);
var
  Bitmap: TBitmap;
begin
  CopySaveDialog.FilterIndex:=1;
  CopySaveDialog.Filter:='image  files *.bmp|*.bmp';
 if CopySaveDialog.execute then
  begin
    Main.CopytoClipBoardExecute(self);
    Bitmap := TBitMap.create;
    try
     Bitmap.LoadFromClipBoardFormat(cf_BitMap,ClipBoard.GetAsHandle(cf_Bitmap),0);
     Bitmap.SaveToFile(CopySaveDialog.FileName);
    finally
      FreeAndNil(Bitmap);
    end;
   end; 
end;

procedure TfrmGL.FileHeaderClick(Sender: TObject);
begin
  if  not assigned( FileHeaderForm)then
     FileHeaderForm:=TFileHeaderForm.Create(Application,FileNameGL)
   else
    begin
     FileHeaderForm.ReadParam(FileNameGL);
     FileHeaderForm.Refresh;
   end;
end;

procedure TfrmGL.MeshClick(Sender: TObject);
var  wrk:GLUInt;
begin
 DC:=GetDC(handle);
   wglMakeCurrent(DC, hrc);
   glGetIntegerv(GL_POLYGON_MODE,@wrk);
             case  wrk of
   GL_FILL:  begin
       //       mesh1.caption:='Fill';
      //        mesh2.caption:='Fill';
              glDisable(GL_LIGHT0);
              glDisable(GL_LIGHT1);
              glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
             end;
   GL_LINE:  begin
           //   mesh1.caption:='Line';
          //     mesh2.caption:='Line';
               glEnable(GL_LIGHT0);
               glEnable(GL_LIGHT1);
               glPolygonMode(GL_FRONT_AND_BACK,GL_FILL);
              end;
                    end;

   wglMakeCurrent(0,0);
//      ActiveGLW:=TfrmGL(ActiveMDIChild);
   InvalidateRect(0, nil, False);
   releaseDc(Handle,DC);
end;

procedure TfrmGL.LevelDeleteClick(Sender: TObject);
var filename,ImFileNameOut:string;
begin
     if FlgNewLnRubberDraw then
   begin
   SaveCurrentPict();
   FlgNewLnRubberDraw:=False;
   end;

  if FlgNewArRubberDraw then
   begin
   SaveCurrentPict();
   FlgNewArRubberDraw:=False;
   end;
   DC:=GetDC(handle);
   if  TopoSpm.FileHeadRcd.SecondPass then   DelFiltLevelOne(DataDraw.Nx,DataDraw.Ny,DataDraw.Data, FiltFileName)
                                      else   DelFiltLevel(DataDraw.Nx,DataDraw.Ny,DataDraw.Data, FiltFileName);
    inc(CountUndo);
    new(PntFileName);
    fileName:=ExtractFileName( FileNameGL);
    CutExtention(FileName,ImFileNameOut);
    PntFileName^.FileName:=TempDirectory+ImFileNameOut+IntToStr(CountUndo)+'.tmp';
// CutExtention(FileNameGL,ImFileNameOut);
//    PntFileName^.FileName:=ImFileNameOut+IntToStr(CountUndo);
    TopoSPM.ArFileNameEdit.Add(PntFileName);
    TopoSpm.ImFileName:=PntFileName^.FileName;
    TopoSpm.WorkFileName:=PntFileName^.FileName;
    TopoSpm.SaveExperiment;
    InitSurface;
    InvalidateRect(Handle, nil, False);
     GradientLabels;
     CopyDataDrawToTopo;
    ReleaseDC(Handle,DC);
end;


procedure TfrmGL.Average3x3Click(Sender: TObject);
var filename,ImFileNameOut:string;
begin
   if FlgNewLnRubberDraw then
   begin
   SaveCurrentPict();
   FlgNewLnRubberDraw:=False;
   end;
  if FlgNewArRubberDraw then
   begin
   SaveCurrentPict();
   FlgNewArRubberDraw:=False;
   end;
   DC:=GetDC(handle);
    AverageFilt3x3(DataDraw.Nx,DataDraw.Ny,DataDraw.Data, FiltFileName);
    inc(CountUndo);
    new(PntFileName);
    fileName:=ExtractFileName( FileNameGL);
    CutExtention(FileName,ImFileNameOut);
    PntFileName^.FileName:=TempDirectory+ImFileNameOut+IntToStr(CountUndo)+'.tmp';
    TopoSPM.ArFileNameEdit.Add(PntFileName);
    TopoSpm.ImFileName:=PntFileName^.FileName;
    TopoSpm.WorkFileName:=PntFileName^.FileName;
    TopoSpm.SaveExperiment;
    InitSurface;//(dataDraw);
    InvalidateRect(Handle, nil, False);
    GradientLabels;
    flgModify:=true;
     CopyDataDrawToTopo;
   ReleaseDC(Handle,DC);
end;

procedure TfrmGL.StepsXDeleteClick(Sender: TObject);
var filename,ImFileNameOut:string;
begin
   if FlgNewLnRubberDraw then
   begin
   SaveCurrentPict();
   FlgNewLnRubberDraw:=False;
   end;

  if FlgNewArRubberDraw then
   begin
   SaveCurrentPict();
   FlgNewArRubberDraw:=False;
   end;
    DC:=GetDC(handle);
//    if (TopoSpm.FileHeadRcd.HPathMode=0) or (TopoSpm.FileHeadRcd.HPathMode=2)
//    then
      DelStepsX(DataDraw.Nx,DataDraw.Ny,DataDraw.data, FiltFileName);
//    else  DelStepsY(DataDraw.Nx,DataDraw.Ny,DataDraw.data, FiltFileName);
    inc(CountUndo);
    new(PntFileName);
    fileName:=ExtractFileName( FileNameGL);
    CutExtention(FileName,ImFileNameOut);
    PntFileName^.FileName:=TempDirectory+ImFileNameOut+IntToStr(CountUndo)+'.tmp';
 //  CutExtention(FileNameGL,ImFileNameOut);
 //   PntFileName^.FileName:=ImFileNameOut+IntToStr(CountUndo);
    TopoSPM.ArFileNameEdit.Add(PntFileName);
    TopoSpm.ImFileName:=PntFileName^.FileName;
    TopoSpm.WorkFileName:=PntFileName^.FileName;
    TopoSpm.SaveExperiment;
    InitSurface;//(DataDraw);
    InvalidateRect(Handle, nil, False);
    GradientLabels;
    CopyDataDrawToTopo;
  releaseDc(Handle,DC);
end;
procedure TfrmGL.StepsYDeleteClick(Sender: TObject);
var filename,ImFileNameOut:string;
begin
   if FlgNewLnRubberDraw then
   begin
   SaveCurrentPict();
   FlgNewLnRubberDraw:=False;
   end;
  if FlgNewArRubberDraw then
   begin
   SaveCurrentPict();
   FlgNewArRubberDraw:=False;
   end;

    DC:=GetDC(handle);
 //   if (TopoSpm.FileHeadRcd.HPathMode=0) or (TopoSpm.FileHeadRcd.HPathMode=2)
 //   then
      DelStepsY(DataDraw.Nx,DataDraw.Ny,DataDraw.data, FiltFileName);
 //   else  DelStepsX(DataDraw.Nx,DataDraw.Ny,DataDraw.data, FiltFileName);
    inc(CountUndo);
    new(PntFileName);
    fileName:=ExtractFileName( FileNameGL);
    CutExtention(FileName,ImFileNameOut);
    PntFileName^.FileName:=TempDirectory+ImFileNameOut+IntToStr(CountUndo)+'.tmp';
 //  CutExtention(FileNameGL,ImFileNameOut);
 //   PntFileName^.FileName:=ImFileNameOut+IntToStr(CountUndo);
    TopoSPM.ArFileNameEdit.Add(PntFileName);
    TopoSpm.ImFileName:=PntFileName^.FileName;
    TopoSpm.WorkFileName:=PntFileName^.FileName;
    TopoSpm.SaveExperiment;
    InitSurface;//(DataDraw);
    InvalidateRect(Handle, nil, False);
    GradientLabels;
    CopyDataDrawToTopo;
  releaseDc(Handle,DC);
end;
procedure TfrmGL.zoom150Click(Sender: TObject);
begin
     Height:=round(Height*1.5);
     Width:=round(Width*1.5);
     InvalidateRect(Handle, nil, False);
end;

procedure TfrmGL.zoom50Click(Sender: TObject);
begin
     Height:=round(Height*0.5);
     Width:=round(Width*0.5);
     InvalidateRect(Handle, nil, False);
end;

procedure TfrmGL.zoom130Click(Sender: TObject);
begin
     Height:=round(Height*1.3);
     Width:=round(Width*1.3);
     InvalidateRect(Handle, nil, False);
end;

procedure TfrmGL.zoom200Click(Sender: TObject);
begin
     Height:=Height*2;
     Width:=Width*2;
     InvalidateRect(Handle, nil, False);
end;

procedure TfrmGL.OptionLight;
begin
  DC:=GetDC(handle);
  wglMakeCurrent(DC, hrc);
   InitMaterials;
   if (flgView=D2GEO) or  (flgView=D3GEO) then glDisable(gl_Lighting);
   InvalidateRect(Handle, nil, False);
   wglMakeCurrent(0,0);
  ReleaseDc(Handle,DC);
end;

procedure TfrmGL.mOptionDrawClick(Sender: TObject);
 var i:integer;
begin
   flgGlbZZero:=self.flgZZero;
   flgGlbRealScale:=self.flgRealScale;
   flgGlbZStretch:=self.flgZStretch;
  begin
   for i:=0 to 3 do
    begin
   //  position0[i]:=;
   //  position1[i]:=;
     front_mat_specular[i]:=specular[i];
     front_mat_diffuse[i]:=diffuse[i];
     front_mat_ambient[i]:=ambient[i];
    end;
   front_mat_shininess[0]:={128*}shininess[0] ;
   self.flgZZero:=flgGlbZZero;
   self.flgRealScale:=flgGlbRealScale;
   self.flgZStretch:=flgGlbZStretch;
  end;
  DC:=GetDC(handle);
  wglMakeCurrent(DC, hrc);
  InitMaterials;
 if (flgView=D2GEO) or  (flgView=D3GEO) then glDisable(gl_Lighting);
  InitSurface;//(DataDraw);
  InvalidateRect(Handle, nil, False);    //refresh
  wglMakeCurrent(0,0);
  ReleaseDc(Handle,DC);
end;

procedure TfrmGL.Material(Sender: TObject);
var i:integer;
begin
   for i:=0 to 3 do
    begin
     front_mat_specular[i]:=specular[i];
     front_mat_diffuse[i]:=diffuse[i];
     front_mat_ambient[i]:=ambient[i];
    end;
   front_mat_shininess[0]:={128*}shininess[0] ;
  DC:=GetDC(handle);
  wglMakeCurrent(DC, hrc);
  InitMaterials;
   if (flgView=D2GEO) or  (flgView=D3GEO) then glDisable(gl_Lighting);
  InitSurface;//(DataDraw);
  InvalidateRect(Handle, nil, False);    //refresh
  wglMakeCurrent(0,0);
  ReleaseDc(Handle,DC);
end;

procedure TfrmGL.ToolsPanelClick(Sender: TObject);
var h:Hwnd;
begin
  if  not ToolsPanel.checked then
    begin
     flgViewTools:=True;
     ToolsPanel.checked:=not ToolsPanel.checked;
     if not assigned(ImageTools) then
      begin
       ImageTools:=TImageTools.Create(application);
       if assigned(ActiveGLW) then
       begin
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
        ImageAnalysis1.enabled:=true;
        ImageAnalysis2.enabled:=true;
       end;
      end;
     end
  else
     begin
       if assigned(ImageTools) then
        if ImageTools.Visible  then
          begin
           ImageTools.Close;
           flgViewTools:=false;
         //  ToolsPanel.checked:=not ToolsPanel.checked;
          end;
     end;
end;

procedure TfrmGL.RuleClick(Sender: TObject);
begin
     flgRule:=not FlgRule;
     flgRubber:=False;
     flgAngle:=False;
     flgCut:=false;
     flgSection:=false;
     Angle.checked:=false;
     AnglePP.checked:=false;
     SectionCut.checked:=False;
     SectionCutPP.checked:=False;
     FragmentCut.checked:=False;
     FragmentCutPP.checked:=False;
     Rule.checked:= not Rule.checked;
     RulePP.checked:= not Rule.checked;
     if assigned(ImageTools)  then     ImageTools. SpeedBtnRule.Down:=not ImageTools.SpeedBtnRule.Down;
     if not flgRule    then
      if flgInvert then  caption:=ExtractFileName(FileNameGL)+AddCaption+strinvert
                   else  caption:=ExtractFileName(FileNameGL)+AddCaption ;
     if (FlgView=D3)   then  View3DTopClick(Sender);
     if (FlgView=D3Geo)then  View2DGeoClick(Sender);
     InvalidateRect(Handle, nil, False);
end;

procedure TfrmGL.AngleClick(Sender: TObject);
begin
      SectionCut.checked:=false;
      SectionCutPP.checked:=false;
      FragmentCut.checked:=False;
      FragmentCutPP.checked:=False;
      Rule.checked:=False;
      RulePP.checked:=False;
      Angle.checked:= not Angle.checked;
      AnglePP.checked:= not AnglePP.checked;
      flgAngle:=not flgAngle;
      flgRule:=False;
      flgRubber:=False;
      flgCut:=false;
      flgSection:=false;
     if assigned(ImageTools)  then  ImageTools. SpeedBtnAngle.Down:=not ImageTools.SpeedBtnAngle.Down;
     if not flgAngle       then
          if flgInvert then  caption:=ExtractFileName(FileNameGL)+AddCaption+strinvert
                       else  caption:=ExtractFileName(FileNameGL)+AddCaption ;
     if (FlgView=D3)       then  View3DTopClick(Sender);
     if (FlgView=D3Geo)    then  View2DGeoClick(Sender);
 end;

procedure TfrmGL.ImageAnalysis1Click(Sender: TObject);
var
    FileN,ScannerFile,
    ScannerDefFile:string;
    MainH,MainW:integer;
    flg:integer;
    lhead: HeadParmType;
    lmainrc:MainFileRec;
    sensX,SensY:single;
    FlagLinear:boolean;
    ScannerName:string;
    DataIn:ImageAnalysisDataIn;
begin
     FileN:=ExtractFileName(FileNameGL)+AddCaption;
     DataIn.FlagAllowCalibration:=false;
     Datain.Lang:=siLangLinked1.ActiveLanguage;
     ReadHeader(FileNameGL,flg,lHead,lMainRc);
     sensX:=lHead.HSensX;
     SensY:=lHead.HSensY;
     FlagLinear:=lHead.HFlagLinear;
 //    ScannerIniFilesPath:=UserIniFilesPath;//exefilepath;  ?????
     ScannerName:=lHead.HScannerName;
   if ScannerName='' then
    begin
     ScannerName:=string('None');
     DataIn.FlagAllowCalibration:=false;
    end
    else
    begin
     case flgUnit of
nano,terra,Pipette:begin
      if WorkFlash then
      begin
      //  PathFlash:= GetPathMTPDevice;
        if PathFlash<>'' then
         begin
           ScannerIniFilesPath:=PathFlash+':\';
           ScannerFile:=ScannerIniFilesPath +  ScannerIniFileX;
           if CheckScannerName(ScannerFile,ScannerName)then
            begin
             ScannerFile:=ScannerIniFilesPath +  ScannerIniFileY;
             DataIn.FlagAllowCalibration:=CheckScannerName(ScannerFile,ScannerName)
            end;
        end
        else DataIn.FlagAllowCalibration:=false;
      end
      else
      begin  // not workflash;
          ScannerFile:=ScannerIniFilesPath +  ScannerIniFileX;
          if CheckScannerName(ScannerFile,ScannerName)then
            begin
             ScannerFile:=ScannerIniFilesPath +  ScannerIniFileY;
             DataIn.FlagAllowCalibration:=CheckScannerName(ScannerFile,ScannerName)
            end;
      end;
     end;
ProBeam,MicProbe:begin
    (*  if WorkFlash then
      begin
        PathFlash:= GetPathFlash;
        if PathFlash<>'' then
         begin
           ScannerIniFilesPath:=PathFlash+':\';
           ScannerFile:=ScannerIniFilesPath +  ScannerIniFileX;
           if CheckScannerName(ScannerFile,ScannerName)then
            begin
             ScannerFile:=ScannerIniFilesPath +  ScannerIniFileY;
             DataIn.FlagAllowCalibration:=CheckScannerName(ScannerFile,ScannerName)
            end;
        end
        else DataIn.FlagAllowCalibration:=false;
      end
      else    *)
      begin  // not workflash;
          ScannerFile:=ScannerIniFilesPath +  ScannerIniFileX;
          if CheckScannerName(ScannerFile,ScannerName)then
            begin
             ScannerFile:=ScannerIniFilesPath +  ScannerIniFileY;
             DataIn.FlagAllowCalibration:=CheckScannerName(ScannerFile,ScannerName)
            end;
      end;
     end;
baby,
grand:      ;
             end;//case
     end;    //scannernumber<>''
 with DataIn do
 begin
      MainW:=Main.width;
      MainH:=Main.Height;
      SourceData:=DataDraw.data;
      SourceNX:=DataDraw.NX;
      SourceNY:=DataDraw.NY;
      ImgTitle:= PChar(FileN);
      dataunits:=PChar(DataDraw.CaptionZ);
      XUnits:=PChar(DataDraw.CaptionX);
      YUnits:=PChar(DataDraw.CaptionY);
      SensitivityX:=sensX;
      SensitivityY:=sensY;
      FlagLinear:=lHead.HFlagLinear;
      SourceScanMode:=lHead.HPathMode;
      SourceStepZ:=DataDraw.ZStep;
      case   SourceScanMode of
 Multi,OneX:begin
         SourceStep:= DataDraw.XStep;
         ScannerFile:=ScannerIniFilesPath + ScannerIniFile;
         ScannerDefFile:=ScannerDefIniFilesPath + ScannerDefIniFile;
        end;
MultiY,OneY:begin
         SourceStep:= DataDraw.YStep;
         ScannerFile:=ScannerIniFilesPath + ScannerIniFileY;
         ScannerDefFile:=ScannerDefIniFilesPath + ScannerDefIniFileY;
        end;
             end;
      PScannerName:=PChar(ScannerName);
      PScannerFile:=PChar(ScannerFile);
      PScannerDefFile:=PChar(ScannerDefFile);
      PFourierFiltTemplFile:=PChar(UserIniFilesPath+'DATA\'+FourierFiltTemplFile);
      AppHandle:=Application.Handle;
      FormHandle:=Handle;
      if assigned(ScanWnd)    then ScanFormHandle:=ScanWnd.Handle
                              else ScanFormHandle:=0;
      if assigned(ApproachOpt)then ApproachOptFormHandle:=ApproachOpt.handle
                              else ApproachOptFormHandle:=0;
      MsgBack:=WM_userFreeLib;
      MsgScanBack:= WM_UserScanWndUpdated ;
      MsgApproachOptBack:=WM_UserApproachOptUpdated;
 end;
(* @MakeAnalysis:=nil;
 @StopAnalysis:=nil;
 @ReceiveData:=nil;
  LibAnalysisHandle:=0;
  LibAnalysisHandle:=LoadLibrary(PChar(ExeFilePath+'ImageAnalysis.dll'));
  if  LibAnalysisHandle<=0 then
    siLangLinked1.MessageDlg(strgl2{'Library Load Error'}+ IntToStr(GetLastError)+'!;',mtWarning,[mbOk,mbHelp],60)
   else
   begin
    MakeAnalysis:=GetProcAddress(LibAnalysisHandle,'MakeAnalysis');
    StopAnalysis:=GetProcAddress(LibAnalysisHandle,'StopAnalysis');
    ReceiveData:= GetProcAddress(LibAnalysisHandle,'ReceiveData');
    MakeAnalysis(main,DataIn);
   end;
   *)
    MakeAnalysis(main,DataIn);
//    if assigned(ImageTools) then ImageTools.Hide;
end;

procedure TfrmGL.CopytoClipboard1Click(Sender: TObject);
begin
  Main.CopytoClipBoardExecute(self);
end;

procedure TfrmGL.mSetPaletteClick(Sender: TObject);
begin
 if not  assigned(PaletteForm) then PaletteForm:=TPaletteForm.Create(Application)
                               else PaletteForm.SetFocus;
end;

procedure TfrmGL.mLightsClick(Sender: TObject);
begin
 if not assigned(LightOption) then LightOption:= TLightOption.Create(Self)
                              else LightOption.SetFocus;;
end;

procedure TfrmGL.mMaterialClick(Sender: TObject);
begin
 if not assigned(vSetMaterialOpt) then  vSetMaterialOpt:=TSetMaterialOption.Create(Self)
                                  else  vSetMaterialOpt.SetFocus;
end;

procedure TfrmGL.ZScale1Click(Sender: TObject);
begin
 if not  assigned(ScaleGL) then
    begin
      ScaleGL:=TScaleGL.Create(self);
    end
    else
    begin
      ScaleGL.SetFocus;
      if assigned(ActiveGLW) then ScaleGL.TrackBarSc.Position:=ActiveGLW.ZScaleP;
    end;
end;

procedure TfrmGL.FormKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
(*if Key=VK_MENU then
 begin
  if Dragflag then
  begin
   Panel.EndDrag(False);
   Dragflag:=false;
  end;
 end;
 *)
end;

procedure TfrmGL.GetOriginXY(var x,y:integer);
var Viewport:array[0..3] of Glint;
    mvMatrix,ProjMatrix:Array[0..15] of GlDouble;
    wx,wy,wz:Gldouble;
begin
 glGetIntegerv(GL_VIEWPORT,@Viewport);
 glGetDoublev(GL_MODELVIEW_MATRIX,@mvMatrix);
 glGetDoublev(GL_PROJECTION_MATRIX,@PROjMATRIX);
 gluProject(0,0,0,@mvMatrix,@ProjMatrix,@Viewport,wx,wy,wz);
 x:=round(wx);
 y:=ClientHeight-round(wy);
end;
{procedure TfrmGL.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (Button=mbLeft) and (ssAlt in Shift) then
            begin
             // DragFlag:=True;
              if assigned(FileHeaderForm) then FileHeaderForm.Hide;
              if assigned(ReportForm)     then ReportForm.Hide;
            //  Image1.Visible:=true;
           //    InvalidateRect(Handle, nil, False);
               RePaint;
          //    Image1.DragMode:=dmAutomatic;
              Image1.BeginDrag(False);
              CopytoClipboard1Click(Sender);
              if assigned(FileHeaderForm) then FileHeaderForm.Show;
              if assigned(ReportForm)     then ReportForm.Show;

            end else
end;
}

procedure TfrmGL.FourierFiltration1Click(Sender: TObject);
 var filename,ImFileNameOut:string;
   PFiltTemplFile:PChar;
begin
    DC:=GetDC(handle);
    PFiltTemplFile:=PChar(UserIniFilesPath+'DATA\'+FourierFiltTemplFile);

    ExecuteFourierFiltrat(DataDraw.Nx,DataDraw.Ny,DataDraw.data, PFiltTemplFile);
    inc(CountUndo);
    new(PntFileName);
    fileName:=ExtractFileName( FileNameGL);
    CutExtention(FileName,ImFileNameOut);
    PntFileName^.FileName:=TempDirectory+ImFileNameOut+IntToStr(CountUndo)+'.tmp';
 //  CutExtention(FileNameGL,ImFileNameOut);
 //   PntFileName^.FileName:=ImFileNameOut+IntToStr(CountUndo);
    TopoSPM.ArFileNameEdit.Add(PntFileName);
    TopoSpm.ImFileName:=PntFileName^.FileName;
    TopoSpm.WorkFileName:=PntFileName^.FileName;
    TopoSpm.SaveExperiment;
    InitSurface;//(DataDraw);
    InvalidateRect(Handle, nil, False);
    GradientLabels;
    CopyDataDrawToTopo;
  releaseDc(Handle,DC);

end;


procedure TfrmGL.miAreaRubberClick(Sender: TObject);
begin
      SectionCut.checked:=false;
      SectionCutPP.checked:=false;
      FragmentCut.checked:=False;
      FragmentCutPP.checked:=False;
      Rule.checked:=False;
      RulePP.checked:=False;
      Angle.checked:= False;
      AnglePP.checked:= False;
      Rubber.Checked:=not Rubber.checked;
      RubberPP.Checked:=not RubberPP.checked;
    //  flgRubber:=not flgRubber;
      flgRubber:=True;
      FlgArRubber:=True;
      FlgLnRubber:=False;
      FlgAngle:=False;
      flgRule:=False;
      flgCut:=false;
      flgSection:=false;
     if assigned(ImageTools)  then  ImageTools. SpeedBtnRubber.Down:=not ImageTools.SpeedBtnRubber.Down;
     if (FlgView=D3)       then  View3DTopClick(Sender);
     if (FlgView=D3Geo)    then  View2DGeoClick(Sender);

end;

procedure TfrmGL.miLineRubberClick(Sender: TObject);
begin
    SectionCut.checked:=false;
      SectionCutPP.checked:=false;
      FragmentCut.checked:=False;
      FragmentCutPP.checked:=False;
      Rule.checked:=False;
      RulePP.checked:=False;
      Angle.checked:= False;
      AnglePP.checked:= False;
      Rubber.Checked:=not Rubber.checked;
      RubberPP.Checked:=not RubberPP.checked;
      //flgRubber:=not flgRubber;
      flgRubber:=True;
      FlgLnRubber:=True;
      FlgArRubber:=False;
      FlgAngle:=False;
      flgRule:=False;
      flgCut:=false;
      flgSection:=false;
     if assigned(ImageTools)  then  ImageTools. SpeedBtnRubber.Down:=not ImageTools.SpeedBtnRubber.Down;

     if (FlgView=D3)       then  View3DTopClick(Sender);
     if (FlgView=D3Geo)    then  View2DGeoClick(Sender);

end;

procedure TfrmGL.MirrorYClick(Sender: TObject);
 var i,j:integer;
   datadrawtmp:Tdata;
 begin
   DataDrawTmp:=TData.Create;
try
 SetLength(DataDrawTmp.Data,DataDraw.Nx,DataDraw.Ny);
     for i:=0 to DataDraw.Ny-1 do
       for j:=0 to DataDraw.Nx-1 do
              DataDrawTmp.data[j,i]:=DataDraw.data[DataDraw.Nx-1-j,i];
      for i:=0 to DataDraw.Ny-1 do
       for j:=0 to DataDraw.Nx-1 do
              DataDraw.data[j,i]:=DataDrawTmp.data[j,i];
       FlgMirrorY:=not  FlgMirrorY;
      MirrorY.checked:=not  MirrorY.checked;
    MirrorYPP.checked:=not  MirrorYPP.checked;
   if assigned(ImageTools) then
    begin
     Imagetools.MirrorY.Checked:=not  Imagetools.MirrorY.Checked;
    end;

  if assigned(ImageTools) then  ImageTools.SpdBtnMir.Down:=not ImageTools.SpdBtnMir.Down;
 DC:=GetDC(handle);
    InitSurface;
    InvalidateRect(Handle, nil, False);
    CopyDataDrawToTopo;
    flgModify:=true;
  ReleaseDc(Handle,DC);
finally
FreeandNil(DataDrawTmp);
end;
end;

procedure TfrmGL.MirrorXClick(Sender: TObject);
 var i,j:integer;
   datadrawtmp:Tdata;
 begin
   DataDrawTmp:=TData.Create;
try
 SetLength(DataDrawTmp.Data,DataDraw.Nx,DataDraw.Ny);
     for i:=0 to DataDraw.Nx-1 do
       for j:=0 to DataDraw.Ny-1 do
              DataDrawTmp.data[i,j]:=DataDraw.data[i,DataDraw.Ny-1-j];
      for i:=0 to DataDraw.Ny-1 do
       for j:=0 to DataDraw.Nx-1 do
              DataDraw.data[j,i]:=DataDrawTmp.data[j,i];
        FlgMirrorX:=not  FlgMirrorX;
      MirrorX.checked:=not  MirrorX.checked;
    MirrorXPP.checked:=not  MirrorXPP.checked;
    if assigned(ImageTools) then
    begin
      Imagetools.MirrorX.Checked:=not  Imagetools.MirrorX.Checked;
    end;

  if assigned(ImageTools) then  ImageTools.SpdBtnMir.Down:=not ImageTools.SpdBtnMir.Down;
 DC:=GetDC(handle);
    InitSurface;
    InvalidateRect(Handle, nil, False);
    CopyDataDrawToTopo;
    flgModify:=true;
  ReleaseDc(Handle,DC);
finally
FreeandNil(DataDrawTmp);
end;
end;
procedure TfrmGL.LnRubberAction(var DataDraw:TData);
var i,j:integer;
    V1,V2:datatype;
 ImgValMax,ImgValMin:datatype;
begin

        if  NxStart<0 then NxStart:=0;
        if  NxStart>nend then  NxStart:=nend;

        if  NyStart<0 then NyStart:=0;
        if  NyStart>mend then  NyStart:=mend;

        case TopoSPM.FileHeadRcd.HPathMode of
        0:  for i:=0 to DataDraw.Nx-1 do
              begin
               DataDraw.data[i,NyStart+1]:=round((DataDraw.data[i,NyStart]+DataDraw.data[i,NyStart+2])/2);
             end;
        1:    for i:=0 to DataDraw.Ny-1 do
             begin
               DataDraw.data[NxStart+1,i]:=round((DataDraw.data[NxStart,i]+DataDraw.data[NxStart+2,i])/2);
             end;
        end; {case}

     ImgValMax:= DataDraw.DataMax;
     ImgValMin:= DataDraw.DataMin;
     for i:=0 to DataDraw.Nx-1 do
       for j:=0 to DataDraw.Ny-1 do
           DataDraw.data[i,j]:= round(255*( DataDraw.data[i,j]- ImgValMin)/(ImgValMax-ImgValMin));
end;

procedure TfrmGL.ArRubberAction(var DataDraw:TData);
var
     i,j:integer;
     K,a0:single;
     t,st,dNx,dNy:integer;
     L,count:integer;
     Section: TDataLine;
     YYStart,YYEnd:integer;
     dYY:single;
     ImgValMax,ImgValMin:datatype;
     XIndex,YIndex:integer;
begin
        if  NxEnd<0      then  NxEnd:=0;
        if  NxEnd>nend   then  NxEnd:=nend;
        if  NxStart<0    then  NxStart:=0;
        if  NxStart>nend then  NxStart:=nend;

        if  NyEnd<0      then  NyEnd:=0;
        if  NyEnd>nend   then  NyEnd:=mend;
        if  NyStart<0    then  NyStart:=0;
        if  NyStart>mend then  NyStart:=mend;

        dNx:=(NxEnd-NxStart);
        dNy:=(NyEnd-NyStart);
        YYStart:=DataDraw.Data[NxStart,NyStart];
        YYEnd:=DataDraw.Data[NxEnd,NyEnd];
// if (sqr(dNx)+sqr(dNy))<10 then exit;
 if  abs(dNx)>abs(dNy)     then
   begin
     K:=dNy/dNx; a0:=NyStart-K*NxStart;
     FlgDirectionSection:=True;
     t:=abs(NxEnd-NxStart);
     Section:=TDataLine.Create(t+1);
     Section.DataLineX[0]:=NxStart;
     Section.DataLineY[0]:=NyStart;

   if ((NxEnd-NxStart)<0) then st:=-1 else st:=1;
    for i:=1 to t do
     begin
      Section.DataLineX[i]:=Section.DataLineX[i-1]+st;
      Section.DataLineY[i]:=round(K*Section.DataLineX[i]+a0);
     end;
   end
 else
   begin
    K:=dNx/dNy; a0:=NxStart-K*NyStart;
    FlgDirectionSection:=False;
    t:=round(abs(NyEnd-NyStart));
    Section:=TDataLine.Create(t+1);
    Section.DataLineX[0]:=NxStart;
    Section.DataLineY[0]:=NyStart;
    if ((NyEnd-NyStart)<0) then st:=-1 else st:=1;
     for i:=1 to t do
      begin
       Section.DataLineY[i]:=Section.DataLineY[i-1]+st;
       Section.DataLineX[i]:=round(Section.DataLineY[i]*K+a0);
      end;
   end;

     L:=Length(Section.DataLineX);
     dYY:=( YYEnd -YYStart)/L;
       for i:=0 to L-1 do
          begin
               Xindex:=round(Section.DataLineX[i]);
               YIndex:=round(Section.DataLineY[i]);
              if ( Xindex<nend)  and (YIndex<mend)
                  and ( Xindex>0) and (YIndex>0)
                  then
                      if abs(dNx)>abs(dNy) then
                        begin
                          DataDraw.Data[XIndex,YIndex-1]:=round(YYStart+dYY*i);
                          DataDraw.Data[XIndex,YIndex]:=round(YYStart+dYY*i);
                          DataDraw.Data[XIndex,YIndex+1]:=round(YYStart+dYY*i);
                        end
                        else
                          begin
                          DataDraw.Data[XIndex-1,YIndex]:=round(YYStart+dYY*i);
                          DataDraw.Data[XIndex,YIndex]:=round(YYStart+dYY*i);
                          DataDraw.Data[XIndex+1,YIndex]:=round(YYStart+dYY*i);
                        end ;
               end;
     finalize(Section);
  (*   ImgValMax:= DataDraw.DataMax;
     ImgValMin:= DataDraw.DataMin;
     for i:=0 to DataDraw.Nx-1 do
       for j:=0 to DataDraw.Ny-1 do
           DataDraw.data[i,j]:= round(255*( DataDraw.data[i,j]- ImgValMin)/(ImgValMax-ImgValMin));
*)
end;

procedure TfrmGL.SaveCurrentPict();
 var fileName, ImFileNameOut:string;
begin
    inc(CountUndo);
    new(PntFileName);
    fileName:=ExtractFileName( FileNameGL);
    CutExtention(FileName,ImFileNameOut);
    PntFileName^.FileName:=TempDirectory+ImFileNameOut+IntToStr(CountUndo)+'.tmp';
// CutExtention(FileNameGL,ImFileNameOut);
//    PntFileName^.FileName:=ImFileNameOut+IntToStr(CountUndo);
    TopoSPM.ArFileNameEdit.Add(PntFileName);
    TopoSpm.ImFileName:=PntFileName^.FileName;
    TopoSpm.WorkFileName:=PntFileName^.FileName;
    TopoSpm.SaveExperiment;

end;

procedure TfrmGL.InvertClick(Sender: TObject);
var i,j:integer;
    max:datatype;
    filename,ImFileNameOut:string;
begin
    max:=DataDraw.DataMax;
     for i:=0 to DataDraw.Nx-1 do
       for j:=0 to DataDraw.Ny-1 do
              DataDraw.data[i,j]:=max-Datadraw.data[i,j];
  flgInvert:=not flgInvert;
  if flgInvert then  caption:=caption+strinvert
               else if pos(strinvert,caption)<>0 then caption:=StringReplace(caption,strinvert,'',[rfReplaceAll]);
    invert.checked:=not  invert.checked;
    invertPP.checked:=not  invertPP.checked;
  if assigned(ImageTools) then  ImageTools.BitBtnInvert.Down:=not ImageTools.BitBtnInvert.Down;
 DC:=GetDC(handle);
    InitSurface;
    InvalidateRect(Handle, nil, False);
    CopyDataDrawToTopo;
    flgModify:=true;
  ReleaseDc(Handle,DC);
end;




end.




