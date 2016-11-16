
//051205

unit frReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, buttons, stdctrls, clipbrd, comObj, ActiveX, grids,  chart,
  iniFiles, comctrls, OleServer,  Menus, siComp, siLngLnk, ImgList;

const

      wdRow=           $0000000A;   // Table Row
      wdColumn=        $00000009;   // Table  Column
      wdCell=          $0000000C;   // Table  Cell
      wdTable=         $0000000F;   // Table
      wdParagraph=     $00000004;
      wdCollapseEnd=   $00000000;   // New obgect is at the end of Fragment
      wdCollapseStart= $00000001;   // New obgect is at the begin of Fragment
      wdWord=          $00000002;
      wdSaveChanges=   $FFFFFFFF;   // SaveChanges in Document
      wdPromptUser=    $00000002;   // Dialod Window Save as
      wdWindowStateMaximize= $00000001;

type WordArray2D=array of array of word;

type TTextContainer=TRichEdit;

type
 TBaseElement=class(TPanel)
   TitleBtn:TSpeedButton;
   TitlePanel:TPanel;
   ControlImage:TImage;
   BitBtnOpen:TBitBtn;
   BitBtnClose:TBitBtn;
   TypeContainer:TPanel;
   TitleContainer:TTextContainer;
   TextPanel:TPanel;
  protected
    FlgBlockOpened:Boolean;
    HElement:integer;
    procedure   DeActivate;  virtual;
    procedure   ElementResize(Sender: TObject);
  public
     Position:Integer;
     constructor Create(var AOwner: TComponent;const title:string);
     destructor  Destroy;    override;
     procedure   Activate;    virtual;
     procedure   ControlImageClick(Sender: TObject);
     procedure   TitleContainerClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
     procedure   TitleContainerExit(Sender: TObject);
end;


type TTextElement=class( TBaseElement)
  TextContainer:TTextContainer;
  constructor Create(var AOwner: TComponent;const title:string);
  procedure   TextContainerClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  procedure   TextContainerExit(Sender: TObject);
end;

type TPict=class(TPanel)
 private
   PictBitMap:TBitMap;
  ComprBitMap:TBitMap;
    BufBitMap:TBitMap;
  procedure   Compr8bitBMP(K,L:integer);
  procedure   Compr24bitBMP(K:integer);
  procedure   ComprPicture(BMPFormat:integer; ComprCoef:integer; SmoothArea:integer);
  function    Convolute2D(iy,ix:integer; Data:WordArray2D; FieldSize:integer):integer;
  procedure   MakePalette(BitMap: TBitMap);
  procedure   DeActivate;
 public
  ReportPicture:TImage;
  PictTitle:TTextContainer;
  constructor Create(var AOwner: TComponent);
  Destructor  Destroy; override;
  procedure   ConvertBMPTo8Bit(tobmp: TBitmap; frbmp : TGraphic);
  procedure   ReportPictureMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
  procedure   Activate;
  procedure   PictureTitleExit(sender:Tobject);
end;

type TPicturesElement=class( TBaseElement)
private
  PictList:TList;
 procedure AddPicture;
 procedure DeletePicture(Pict:TPict);
 procedure RepaintPictureList;
 procedure ElementResize(sender:TObject);
 procedure PicturesElementDragOver(Sender, Source: TObject; X,  Y: Integer; State: TDragState; var Accept: Boolean);
 Procedure PicturesElementDragDrop(Sender, Source: TObject; X,  Y: Integer);
public
 constructor Create(var AOwner: TComponent;const  title:string);
 destructor  Destroy;    override;
 procedure   DeActivate;  override;
 function    CaptureImage(Source: TObject):boolean;
end;

type TBaseArray=array of TBaseElement;

//  WORD Declarations

type TWordReport=class
private
  procedure Error(i:integer;str:string); //intro
  procedure ReRun;
public
  MsWord:Variant; // Main
//  function Version:string; //shadow
  Procedure Run;
  procedure NewDoc;
  procedure Insert(const info:string;SourceFont:TFont; _center:boolean);
  procedure InsertText(Source:TTextContainer);
  procedure Hide;
  procedure Show;
  procedure Quit;
  procedure Free;
  procedure Close;  //Закрыть документ WORD:
  procedure Save(const Name:string);   //Сохранить активный документ:
  procedure SaveAs;
  procedure Print;  //Отправка активного документа на печать:
  procedure NewPage; //Разрыв страницы - переход к новой странице.
  procedure Paste;   // вставить из буфера
  procedure NextCell; // Go to next cell in table
  procedure InsertPicture(Pict:TPict);
  procedure Search(const data:string);
  procedure AddBookMark(const BookMark:string);
  procedure CreateTable(NLines, NRows:integer);
  procedure InsertAfter(Str:string);
  procedure Move(MoveType, Number:integer);
end;

type
  TReportForm = class(TForm)
    PanelTop: TPanel;
    SaveDialog: TSaveDialog;
    PanelBottom: TPanel;
    PanelUp: TPanel;
    GroupBox1: TGroupBox;
    BitBtnOpenDoc: TBitBtn;
    BitBtnPrint: TBitBtn;
    BitBtnSave: TBitBtn;
    BitBtnH: TBitBtn;
    RadioGroup: TRadioGroup;
    GroupBoxPersData: TGroupBox;
    EdName2: TEdit;
    Label2: TLabel;
    EdName1: TEdit;
    Label3: TLabel;
    EdGroup: TEdit;
    GroupBoxAct: TGroupBox;
    PopupMenuAdd: TPopupMenu;
    TextContainer: TMenuItem;
    PictureContainer: TMenuItem;
    BitBtnDelAct: TBitBtn;
    BitBtnAdd: TBitBtn;
    //BitBtnSaveTmpl: TBitBtn;
    BitBtnLoad: TBitBtn;
    PopupMenuDel: TPopupMenu;
    DelContainer: TMenuItem;
    DelImage: TMenuItem;
    BitBtnFont: TBitBtn;
    FontDialog: TFontDialog;
    BitBtnSaveTmpl: TBitBtn;
    Panelreport: TScrollBox;
    siLangLinked1: TsiLangLinked;
    Timer: TTimer;
    StatusBar: TStatusBar;
    ImageList1: TImageList;
    procedure TimerTimer(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;   Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure BitBtnOpenDocClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure TextContainerClick(Sender: TObject);
    procedure PictureContainerClick(Sender: TObject);
    procedure BitBtnAddMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BitBtnDelActClick(Sender: TObject);
    procedure BitBtnSaveTmplClick(Sender: TObject);
    procedure BitBtnLoadClick(Sender: TObject);
    procedure BitBtnDelActMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure DelContainerClick(Sender: TObject);
    procedure DelImageClick(Sender: TObject);
    procedure BitBtnFontClick(Sender: TObject);
    procedure BitBtnHClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PanelReportResize(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
     Title1Font, Title2Font :TFont;
     WordReport:TWordReport;
     VisibleDocument:Boolean;
     PictureBlocksCNT:integer;
     HeightMin:integer;
     Caption0:string;
//     CursorPos:TPoint;
     procedure MakeDelImage;
     procedure ClearTemplateFile(const LabWorkId:string);
     procedure WordDocument;
     procedure WriteTextSection(iniFile:TIniFile; BlockNmb:integer );
     procedure WritePictureSection (iniFile:TIniFile; BlockNmb:integer);
     procedure AddTextBlock(const Title:string);
     procedure AddPictureBlock(const Title:string);
     procedure CutExtention(const InName:string ; var OutName:string);
     procedure DeActivateAll;
    { Private declarations }
  public
    { Public declarations }
    ReportElements:TList;
    ActiveText:TTextContainer;
    procedure  SaveTemplate(const LabWorkId:string);
    procedure  ReadTemplate(const ReportFile :string);
    function   CaptureSourceImage(Source: TObject):boolean;
  end;

var
  ReportForm: TReportForm;
  ActiveElement:TBaseElement;

implementation

uses Globalvar,nanoeduhelp,frChooseReportTempl,mMain;

{$R *.dfm}
{$R nanoeduadd.res}

const BaseH=200;//200
      BaseW=720;//720;
      TitleH=50;//46;
	strrp0: string = ''; (* Error!!  *)
	strrp2: string = ''; (* File   *)
	strrp3: string = ''; (*    exists. Rewrite it? *)
	strrp4: string = ''; (*  No Report Templates File  *)
	strrp5: string = ''; (* Input Header  *)
	strrp6: string = ''; (* Open Container *)
	strrp7: string = ''; (* Close Container *)
	strrp8: string = ''; (* Input Text in Container *)
	strrp9: string = ''; (* Text *)
	strrp10: string = ''; (* Images *)
	strrp11: string = ''; (* press Alt and then Drag and Drop Image to Container *)
	strrp12: string = ''; (* Microsoft Word is not Installed! *)
	strrp13: string = ''; (* файл не найден *)
var
  ServerIsRunning:Boolean;
  ElementsN:integer;
  CursorPos:TPoint;
  ActivePict:TPict;
  bBitMapOPen:TBitMap;
  bBitMapClose:Tbitmap;
  ColorActive:Tcolor;
  ColorPassive:TColor;

constructor TPict.Create(var AOwner: TComponent);
var ComprKoef, SmoothArea:integer;
    BMPFormat:integer;
begin
  inherited Create(AOwner);
  ComprKoef:=8;
  SmoothArea:=3;
  BMPFormat:=8;//24;
  DragMode:=dmAutomatic;
  ReportPicture:=TImage.Create(Self);
  height:=50;
  With ReportPicture do
  begin
     parent:=Self;
     Left:=2;
     top:=2;
     width:=50;
     Height:=width;
  end;
  PictBitMap:=TBitMap.Create;
  PictBitMap.Assign(ClipBoard);
  ReportPicture.Picture.Bitmap.Assign(Clipboard);
  ReportPicture.Stretch:=True;
  ReportPicture.OnMouseDown:=ReportPictureMouseDown;
  PictTitle:=TTextContainer.Create(Self);
  with PictTitle do
  begin
     parent:=Self;
     Left:=ReportPicture.Left+ReportPicture.Width+4;
     top:=2;
     Height:=50;
     ScrollBars:=ssBoth;
     WordWrap:=False;
     plaintext:=false;
     parentfont:=true;
     OnMouseDown:=ReportPictureMouseDown;
     OnExit:=PictureTitleExit;
  end;
end;

Destructor TPict.Destroy;
begin
 FreeandNil(PictBitMap);
 FreeAndNil(PictTitle);
 FreeAndNil(ReportPicture);
inherited Destroy;
end;

procedure TPict.ConvertBMPTo8Bit(tobmp: TBitmap; frbmp : TGraphic);
begin
  tobmp.Width := frbmp.Width;
  tobmp.Height := frbmp.Height;
  tobmp.PixelFormat := pf8bit;
  tobmp.Canvas.Draw(0,0,frbmp);
end;

procedure TPict.Compr8BitBMP(K,L:integer);
var i,j:integer;
     P:PByteArray;
     BufImage, ComprImage: WordArray2D ;
     X,Y:integer;
     Shift:integer;
begin
if PictBitMap<> nil then
begin
 ComprBitMap:=TBitMap.Create;
 Y:= PictBitMap.Height div K;
 ComprBitMap.Height:=Y;
 X:= PictBitMap.Width div K;
 ComprBitMap.Width:= X;
 comprBitMap.PixelFormat:=pf8bit;
 MakePalette(comprBitMap);
 SetLength( BufImage,BufBitMap.Height,BufBitMap.Width);
 SetLength( ComprImage, Y,X);
try
 //  if L>K then L:=K;
   Shift:= (L-1) div 2;
   for i:= 0 to PictBitMap.Height -1 do
     begin
        P := BufBitMap.ScanLine[i];
        for j:= 0 to PictBitMap.Width-1 do  BufImage[i,j]:=P[j];
     end;

   for i:=0 to Y-1 do
    for j:=0 to X-1 do
      //ComprImage[i,j]:=BufImage[i*K,j*K];
        if ((i-Shift)>0) and ((i+Shift)<PictBitMap.Height) and
          (  (j-Shift)>0 )and ((i+Shift)<PictBitMap.Width )
          then  ComprImage[i,j]:=convolute2D(i*K,j*K,BufImage,L)
          else  ComprImage[i,j]:=BufImage[i*K,j*K];

       for i:= 0 to Y -1 do
        begin
         P := ComprBitMap.ScanLine[i];
         for j:= 0 to X-1 do  P[j]:=ComprImage[i,j];
        end;

 finally
  BufImage:=nil;
  ComprImage:=nil;
  FreeAndNil(BufBitMap);
  P:=nil;
 end;
end;
end;

procedure TPict.Compr24bitBMP(K:integer);
var i,j:integer;
     P:PByteArray;
     RBufImage,  RComprImage,
     GBufImage,  GComprImage,
     BBufImage,  BComprImage: WordArray2D ;
     X,Y:integer;
     Shift:integer;
begin
if PictBitMap<> nil then
begin
ComprBitMap:=TBitMap.Create;
Y:= PictBitMap.Height div K;
ComprBitMap.Height:=Y;
X:= PictBitMap.Width div K;
ComprBitMap.Width:= X;
comprBitMap.PixelFormat:=pf24bit;
SetLength( RBufImage,PictBitMap.Height,PictBitMap.Width);
SetLength( GBufImage,PictBitMap.Height,PictBitMap.Width);
SetLength( BBufImage,PictBitMap.Height,PictBitMap.Width);
SetLength( RComprImage, Y,X);
SetLength( GComprImage, Y,X);
SetLength( BComprImage, Y,X);
try
    Shift:=(K-1) div 2;

   for i:= 0 to PictBitMap.Height -1 do
     begin
        P := PictBitMap.ScanLine[i];
        for j:= 0 to PictBitMap.Width-1 do
         begin
          BBufImage[i,j]:=P[3*j];
          GBufImage[i,j]:=P[3*j+1];
          RBufImage[i,j]:=P[3*j+2];
         end;
     end;

   for i:=0 to Y-1 do
    for j:=0 to X-1 do
     begin
    //  RComprImage[i,j]:=RBufImage[i*K,j*K];
    //  GComprImage[i,j]:=GBufImage[i*K,j*K];
    //  BComprImage[i,j]:=BBufImage[i*K,j*K];
    {     if ((i-Shift)>0) and ((i+Shift)<PictBitMap.Height) and
          (  (j-Shift)>0 )and ((i+Shift)<PictBitMap.Width )then
            begin
           RComprImage[i,j]:=convolute2D(i*K,j*K,RBufImage,K);
           GComprImage[i,j]:=convolute2D(i*K,j*K,GBufImage,K);
           BComprImage[i,j]:=convolute2D(i*K,j*K,BBufImage,K);
            end else
        }    begin
              RComprImage[i,j]:=RBufImage[i*K,j*K];
              GComprImage[i,j]:=GBufImage[i*K,j*K];
              BComprImage[i,j]:=BBufImage[i*K,j*K];
            end;
     end;

       P:=nil;
       for i:= 0 to Y -1 do
        begin
         P := ComprBitMap.ScanLine[i];
         for j:= 0 to X-1 do
          begin
           P[3*j]:=BComprImage[i,j];
           P[3*j+1]:=GComprImage[i,j];
           P[3*j+2]:=RComprImage[i,j];
          end;
        end;
finally
 RBufImage:=nil;
 RComprImage:=nil;
 GBufImage:=nil;
 GComprImage:=nil;
 BBufImage:=nil;
 BComprImage:=nil;
 P:=nil;
end;
end;
end;


function TPict.Convolute2D(iy,ix:integer; Data:WordArray2D; FieldSize:integer):integer;
// FieldSize=2*n+1;
var
  i,j,kx,ky:integer;
  Shift:integer;
  X,Y:integer;
  res: double;
  ires: integer;

begin
   Shift:=(FieldSize-1) div 2;
            res:=0.0; ires:=0;
             for ky:=-Shift to Shift do
             begin
                for kx:=-Shift to Shift do
                begin
                     i:=ix+kx; j:=iy+ky;
                     ires:=ires+1;
                     res:=res+Data[j,i];
                end; {for kx}
             end; {for ky}
             if ires <> 0 then Result:=round(res/ires)
                          else Result:=Data[j,i];
end; {Conv2m2}

procedure TPict.MakePalette(BitMap: TBitMap);
var i : Integer;
    pal : PLogPalette;
    hpal:HPALETTE;
begin
  pal := nil;
  GetMem(pal, sizeof(TLogPalette) + sizeof(TPaletteEntry) * 255);
 try
  begin
    pal.palVersion := $300;
    pal.palNumEntries := 256;
    for i := 0 to 255 do
    begin
      pal.palPalEntry[i].peRed := RPaletteKoef[i];
      pal.palPalEntry[i].peGreen := GPaletteKoef[i];
      pal.palPalEntry[i].peBlue := BPaletteKoef[i];
      pal^.palPalEntry[i].peFlags := pc_nocollapse;
    end;
    if hPal<>0   then  DeleteObject(hPal);
    hpal := CreatePalette(pal^);
    if hpal <> 0 then  BitMap.Palette := hpal;
  end
  finally
    FreeMem(pal);
    DeleteObject(hPal);
  end;
end; {MakePalette}


procedure TPict.ComprPicture(BMPFormat:integer; ComprCoef:integer; SmoothArea:integer); // BMPFormat=8 or 24
begin
if BMPFormat=8 then
begin
 BufBitMap:=TBitMap.Create;
 ConvertBMPTo8Bit(BufBitMap,PictBitMap);
 Compr8bitBMP( ComprCoef, SmoothArea);
end
else  Compr24bitBMP( ComprCoef);
end;

procedure  TPict.Activate;
begin
  Color:=ColorActive;  { TODO : 060707 }
  //setfocus;
end;
procedure  TPict.DeActivate;
begin
  Color:=ColorPassive;
end;
procedure  TPict.PictureTitleExit;
begin
  CursorPos:=PictTitle.CaretPos;
end;
procedure TPict.ReportPictureMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var  i:integer;
     Element:TPicturesElement ;
     P:TPict;
begin
if Button=(mbLeft) then
begin
if (ActiveElement<>TPicturesElement((self.parent).parent)) then
 begin
  ReportForm.DeActivateAll;
  ActiveElement:=TPicturesElement((self.parent).parent) ;
  ActiveElement.Activate;
 end;
 if (not (ssShift in Shift)) and assigned(ActivePict) then
  begin
     Element:=(ActiveElement as TpicturesElement);
     for i:=0 to Element.PictList.Count-1 do
      begin
       P:=Element.PictList.Items[i];
       P.DeActivate;
      end;
    end;
  Activate;
//  Self.Parent.SetFocus;
  ActivePict:=Self;
  ReportForm.ActiveText:= PictTitle;
 end;
end;

//TBaseElement
constructor TBaseElement.Create(var AOwner: TComponent ;const  title:string);
var Bitmap:Tbitmap;
begin
   inherited Create(AOwner);
    Self.Width:=BaseW-4;
    Self.Height:=TitleH+10;
    HElement:=BaseH;
    TitlePanel:=TPanel.Create(Self);
    FlgBlockOpened:=False;
    color:=ColorActive;
    ShowHint:=true;
    with TitlePanel do
    begin
      Parent:=self;
      Left:=5;
      Top:=5;
      Width:=Parent.Width-21;
      Height:=TitleH;
      BevelInner:=bvNone;
      BevelOuter:=bvRaised;
      BevelWidth:=4;
    end;
    TypeContainer:=TPanel.Create(self);
    with TypeContainer do
    begin
      Parent:=TitlePanel;
      Left:=5;
      Top:=5;
      Width:=height+14;
      Height:=Parent.height-8;
      font.Style:=[fsBold];
      font.Size:=6;
     end;
    TitleContainer:=TTextContainer.Create(Self);
    with TitleContainer do
    begin
      Parent:=TitlePanel;
      parentfont:=false;
      Left:=TypeContainer.width+12;
      Top:=6;
      Width:=Parent.Width-2*TypeContainer.width;
      Height:=parent.Height-11;
      BevelInner:=bvNone;
      BevelOuter:=bvNone;
      BevelKind:=bkNone;
      BorderStyle:=bsNone;
      ScrollBars:=ssBoth;
      PlainText:=false;
      WordWrap:=False;
      Hint:=strrp5{'Input Header'};
       With DefAttributes do
       begin
         Name:='MS Sans Serif';
         Style:=[fsBold];
         Size:=10;
       end;
         With SelAttributes do
       begin
         Name:='MS Sans Serif';
         Style:=[fsBold];
         Size:=10;
       end;
         With SelAttributes do
       begin
         Name:='MS Sans Serif';
         Style:=[fsBold];
         Size:=10;
       end;
      Font.Style:=[fsBold];
      Font.Size:=10;
    end;
     ControlImage:=TImage.Create(Self);
     with ControlImage do
       begin
          Parent:=TitlePanel;
          Left:=titlecontainer.Left+titlecontainer.Width+5;
          Top:=8;
          Height:=Parent.Height-8;
          Width:=Height+10;
          OnClick:=ControlImageClick;
          Picture.Bitmap.Assign(bBitmapOPen);
          ShowHint:=true;
          Hint:=strrp6{'Open Container'};
       end;
      TextPanel:=TPanel.Create(Self);
     with TextPanel do
     begin
      Parent:=self;
      Left:=0;
      Top:= TitlePanel.Top+TitlePanel.Height+2;
      Width:=Parent.Width;
      Height:=0;
      color:=clSkyBlue;
     end;
    OnResize:=ElementResize;
    TitleContainer.OnMouseDown:=TitleContainerClick; { TODO : 150607 }
    TypeContainer.OnMouseDown:=TitleContainerClick;
    TitleContainer.OnExit:=TitleContainerExit;
end;

procedure TBaseElement.ElementResize(Sender: TObject);
begin
 Width:=Parent.ClientWidth-15;  //10
 TitlePanel.Width:=width-11;//21;
 TitleContainer.Width:=TitlePanel.Width-2*typecontainer.width-4;
 ControlImage.Left:=titlecontainer.Left+ TitleContainer.Width+5;
 TextPanel.Width:=Width-4; //  TitlePanel.Width;
end;

Destructor TBaseElement.Destroy;
begin
//FreeandNil(PictBitMap);
// PictTitle.Destroy;//Free;
// ReportPicture.Destroy;//Free;
inherited Destroy;
end;

procedure TBaseElement.TitleContainerClick(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if (not (ssShift in Shift))  then
  begin
     ReportForm.DeActivateAll;
  end;
 Activate;
 ReportForm.ActiveText:=TitleContainer;
 { TODO : 051205 }
 TitleContainer.SetFocus;
end;

procedure TBaseElement.TitleContainerExit(Sender: TObject);
begin
 CursorPos:=TitleContainer.CaretPos;
end;

procedure TBaseElement.ControlImageClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to ReportForm. ReportElements.Count-1 do TBaseElement(reportForm. ReportElements.Items[i]).DeActivate;
 TitleContainer.Color:=clWindow;
 Activate;
 if  FlgBlockOpened then    // To close Block
 begin
  FlgBlockOpened:=False;
  height:=height-TextPanel.Height;
  TextPanel.Height:=0;
  TitlePanel.BevelOuter:=bvRaised;
//  ReportForm.height:=ReportForm.height-HElement;
  ControlImage.Picture.Bitmap.Assign(bBitmapOPen);
  ControlImage.Hint:=strrp6{'Open Container'};
 end
 else
 begin                     // To Open Block;
   FlgBlockOpened:=True;
   TextPanel.Height:=HElement;
   TitlePanel.BevelOuter:=bvLowered;
   height:=height+TextPanel.Height;
 //  ReportForm.Height:=ReportForm.height+TextPanel.Height;//baseH;
   ControlImage.Picture.Bitmap.Assign(bBitmapClose);
   ControlImage.Hint:=strrp7{'Close Container'};
 end;
  ReportForm.resize;
end;

constructor TTextElement.Create(var AOwner: TComponent;const title:string);
begin
inherited create(AOwner, title);
 TextPanel.Color:= clGreen;
 TextContainer:=TTextContainer.Create(Self);
with TextContainer do
 begin
  Parent:=TextPanel;
  Align:=alClient;
  Left:=5;
  Top:=5;
  Width:=Parent.Width-10;
  Height:=Parent.Height-10;
  MaxLength:=0;
  ScrollBars:=ssBoth;
  WordWrap:=False;
  parentfont:=False;
  PlainText:=false;
  With DefAttributes do
   begin
      Name:='MS Sans Serif';
      Style:=[fsBold];
      Size:=8;
   end;
 end;
  TextPanel.Hint:=strrp8{'Input Text in Container'};
  OnResize:=ElementResize;
  TypeContainer.Caption:=strrp9{'Text'};
  TextContainer.OnMouseDown:=TextContainerClick;
  TextContainer.OnExit:=TextContainerExit;
end;

procedure TTextElement.TextContainerClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 ReportForm.ActiveText:=TextContainer;
  if (not (ssShift in Shift))  then
  begin
     ReportForm.DeActivateAll;
  end;
 Activate;
end;
procedure TTextElement.TextContainerExit(Sender: TObject);
begin
  CursorPos:=TextContainer.CaretPos;
end;//TPicturesElement


constructor TPicturesElement.Create(var AOwner: TComponent;const  title:string);
begin
inherited Create(AOwner, title);
 TypeContainer.Caption:=strrp10{'Images'};
 TextPanel.OnDragOver:= PicturesElementDragOver;
 TextPanel.OnDragdrop:= PicturesElementDragDrop;
 TextPanel.ParentFont:=true;
 PictList:=TList.Create;
 OnResize:=ElementResize;
 TextPanel.Hint:=strrp11{'press Alt and then Drag and Drop Image to Container'};
end;

destructor TPicturesElement.Destroy;
begin
  PictList.Clear;
  FreeAndNil(PictList);
 inherited Destroy;
end;

procedure TBaseElement.Activate;
begin
  Color:=ColorActive;
  TitleContainer.color:=clwhite;
  ActiveElement:=self;
 { TitleContainer.Font.Name:='MS Sans Serif';  }
end;
procedure TBaseElement.DeActivate;
begin
 Color:=ColorPassive;
 TitleContainer.color:=clbtnface;
end;

procedure TPicturesElement.AddPicture;
var TempPict:tPict;
begin
 TempPict:= TPict.Create(TComponent(Self));//(TextPanel));
 TempPict.parent:=TextPanel;
 PictList.Add(TempPict);
 TempPict.Height:=58;
 TempPict.Left:=2;
 TempPict.Top:=(pictlist.count-1)*TempPict.height+2;
 TempPict.Width:=Parent.Width-TempPict.Left*2;
 TempPict.PictTitle.Width:=TempPict.ClientWidth- TempPict.PictTitle.Left-4;
 if  (TempPict.Top+2*TempPict.Height)>=TextPanel.Height then
   begin
     HElement:=HElement+2*TempPict.Height;
     TextPanel.Height:= HElement;
     Height:=TextPanel.Height+TitlePanel.Height;
     ReportForm.Resize;
   end;

 with TempPict.PictTitle.DefAttributes do
  begin
    Name:='Times New Roman';
    size:=10;
    style:=[fsBold];
    Color:=clBlack;
  end;
  with TempPict.PictTitle.SelAttributes do
  begin
    Name:='Times New Roman';
    size:=10;
    style:=[fsBold];
    Color:=clBlack;
  end;
 TempPict.PictTitle.SetFocus; 
 ActivePict:=TempPict;
 ReportForm.ActiveText:= TempPict.PictTitle;
end;

procedure TPicturesElement.DeletePicture(Pict:Tpict);
var P:TPict;
    i:integer;
begin
for i:= PictList.Count-1 downto 0  do
 begin
   P:=Tpict(PictList.Items[i]) ;
   if P=Pict then
      begin
         if  TextPanel.Height>BaseH then
          begin                     { TODO : 250607 }
           HElement:=HElement-{2*}Pict.Height;
           TextPanel.Height:=HElement;
           Height:=TextPanel.Height+TitlePanel.Height;
           ReportForm.Resize;
          end;
          FreeAndNil(Pict);
          Pict:=nil;
          PictList.Delete(i);
          RepaintPictureList
      end;
 end;
end;

procedure TPicturesElement.RepaintPictureList;
var i:integer;
    P:TPict;
begin
for i:=0 to PictList.Count-1 do
  begin
      P:=(PictList.Items[i]) ;
      P.Top:=i*P.Height;
  end;
end;

procedure TPicturesElement.ElementResize(Sender:TObject);
var i:integer;
    P:TPict;
begin
 Width:=Parent.ClientWidth-15;//10;
 TitlePanel.Width:=Width-10;//21;
 TitleContainer.Width:=TitlePanel.Width-2*TypeContainer.width-4;
 TextPanel.Width:=Width-4;
 ControlImage.Left:=TitleContainer.Left+TitleContainer.Width+4;
for i:=0 to PictList.Count-1 do
  begin
      P:=Tpict(PictList.Items[i]) ;
      P.Top:=i*P.Height;
      P.width:=Parent.ClientWidth-Left*2;
      P.PictTitle.Width:=Width-P.PictTitle.Left-4;
  end;
end;

procedure  TPicturesElement.DeActivate;
var I:integer;
begin
inherited;
 for i:=0 to PictList.Count-1 do
  begin
   TPict(PictList.Items[i]).Color:=clBtnFace;
  end;
end;
function  TPicturesElement.CaptureImage(Source: TObject):boolean;
begin
 ReportForm.DeActivateAll;
 self.Activate;
 AddPicture;
 ActivePict.activate;
 ReportForm.BitBTnH.SetFocus;
 TControl(Source).EndDrag(false);
end;

// WORD Implementation


procedure TWordReport.Error(i:integer;str:string);
begin
   messageDlg('Error!! ' +str,mtwarning,[mbOk],0);
end;

Procedure TWordReport.Run;
var
AppProgId:string;
Result:Hresult;
UnKnown:IUnKnown;
begin
 AppProgId:='Word.Application';
 ServerIsRunning:=False;
 try
 // MsWord:=CreateOleObject('Word.Application');
  Result:=GetActiveObject(ProgIdToClassId(AppProgId),nil,Unknown);
  if (Result= MK_E_UNAVAILABLE) then
  begin
    MsWord:=CreateOleObject(AppProgId);
//    MSWord.Documents.Items(1).Windows.WindowState :=wdWindowStateNormal;
  end
  else
  begin
   MsWord:=GetActiveOleObject(AppProgId);
   ServerIsRunning:=True;
  end;
 // MsWord.Visible:=true;
 except
  error(1,strrp12{'Microsoft Word is not Installed!'});
 end;
end;

procedure TWordReport.ReRun;
var
AppProgId:string;
Result:HResult;
UnKnown:IUnKnown;
begin
 AppProgId:='Word.Application';
 try
  Result:=GetActiveObject(ProgIdToClassId(AppProgId),nil,Unknown);
  if (Result= MK_E_UNAVAILABLE) then
  begin
   MsWord:=CreateOleObject(AppProgId);
   ServerIsRunning:=False;
  end;
 //   MSWord.Documents.Items(1).Windows.WindowState :=wdWindowStateNormal;

 except
    error(1,'Microsoft Word is not Installed!');
 end;
end;


procedure TWordReport.NewDoc;
begin
 try
  MsWord.Documents.Add(EmptyParam,EmptyParam);
  MSWord.WindowState :=wdWindowStateMaximize;//Normal;
  MsWord.ActiveDocument.Activate;
 except
  Error(2,strrp13{'файл не найден'});
 end;
end;



procedure TWordReport.insert(const info:string; SourceFont:TFont; _center:boolean);
begin
  MsWord.Selection.Font.Name:=SourceFont.Name;
  MsWord.Selection.Font.Bold:=(fsBold in SourceFont.Style);
  MsWord.Selection.Font.italic:=(fsItalic in SourceFont.Style);
//  MsWord.Selection.Font.StrikeThrough:=_StrikeThrough;
//  MsWord.Selection.Font.Underline:=_Underline;
  MsWord.Selection.Font.Size:=SourceFont.Size;
  MsWord.Selection.ParagraphFormat.Alignment:=0;
  if _center=true then MsWord.Selection.ParagraphFormat.Alignment:=1;
  MsWord.selection.TypeText(info);
end;

procedure  TWordReport.InsertText(Source:TTextContainer);
var info:string;
    CursorPosition:integer;
    StrColor:TColor;
begin
 Source.SelectAll;
 Source.CopyToClipboard;
 Paste;
end;

procedure TWordReport.Hide;
begin
  MsWord.Visible:=False;
end;

procedure TWordReport.Show;
begin
  MsWord.Visible:=True;
end;

procedure TWordReport.Quit;
var Unknown:IUnknown;
begin
   if GetActiveObject(ProgIdToClassId('Word.Application'),nil,Unknown)<>MK_E_UNAVAILABLE
   then    MsWord.Quit;
end;

procedure TWordReport.Free;
begin
   MsWord:=UnAssigned;
end;

//Закрыть документ WORD:
procedure TWordReport.Close;
begin
  MsWord.ActiveDocument.Close(0);
end;

//Сохранить активный документ:
procedure TWordReport.Save(const Name:string);
begin
  MsWord.ActiveDocument.SaveAs(FileName:=Name);
end;

procedure TWordReport.SaveAs;
begin
  MsWord.ActiveDocument.Close(wdSaveChanges, wdPromptUser);
end;

//Отправка активного документа на печать:
procedure TWordReport.Print;
begin
  MsWord.ActiveDocument.PrintOut;
end;

//Разрыв страницы - переход к новой странице. Реализуется так:
procedure TWordReport.NewPage;
begin
 MsWord.Selection.InsertBreak;
end;

procedure TWordReport.Paste;
begin
 MsWord.Selection.Paste;
end;


procedure TWordReport.NextCell;
begin
  MsWord.Run('NextCell');
end;

procedure TWordReport.Search(const data:string);
var What,Which,Count,Name:OLEVariant;
begin
  What:=-1;
  Which:=unAssigned;
  Count:=unAssigned;
  Name:=data;
  MsWord.Selection.GoTo(What,Which,Count,Name);
end;


procedure TWordReport.InsertPicture(Pict:TPict);
Var Rng:olevariant;
begin
 Rng:=MsWord.Selection.Range;
 Rng.Collapse(wdCollapseEnd);
 Rng.InsertAfter('');
 Rng.InsertParagraphAfter;
 Rng.InsertAfter('2');
 Rng.InsertParagraphAfter;
 Rng.ConvertToTable(',');
 ClipBoard.Assign(Pict.PictBitMap);
 Paste; //Paste Picture From Buffer;
 NextCell;
 Pict.PictTitle.SelectAll;
 Pict.PictTitle.CopyToClipboard;
//Insert(#13,TitleFont1,false);
 Paste;
end;


procedure TWordReport.AddBookMark(const BookMark:string);
begin
 MsWord.ActiveDocument.BookMarks.Add(BookMark);
end;

procedure TWordReport.CreateTable(NLines, NRows:integer);
Var Rng:olevariant;
    i,j:integer;
begin
(*Rng:=MsWord.Selection.Range;
Rng.Collapse(wdCollapseEnd);
for i:=1 to NLines
Rng.InsertAfter('');
Rng.InsertParagraphAfter;
Rng.InsertAfter('2');
Rng.InsertParagraphAfter;
Rng.ConvertToTable(',');    *)
end;

procedure TWordReport.InsertAfter(Str:string);
begin
 MsWord.Selection.InsertAfter(Str);
end;

procedure TWordReport.Move(MoveType, Number:integer);
begin
 MsWord.Selection.Range.Move(MoveType, Number);
end;
//REportForm


procedure TReportForm.FormCreate(Sender: TObject);
var
 workid:string;
begin
inherited;
  siLangLinked1.activelanguage:=Lang;
  UpdateStrings;
  Caption0:=siLangLinked1.GetTextOrDefault('IDS_23' (* 'Report Generator' *) ) ;
  Caption:=Caption0;
  Width:=BaseW+30;
  ElementsN:=3;
  self.top:=100;
  self.left:=Screen.WorkAreaWidth-self.width-5;
  HeightMin:=(BaseH+5)*ElementsN;
  PanelReport.Height:=(BaseH+5)*(ElementsN);
  height:=HeightMin;
  ReportElements:=TList.Create;
  bBitmapOpen := TBitmap.Create;
  bBitmapOPen.Handle := LoadBitmap(hInstance, 'OPEN');
  Canvas.Draw(0,0,bBitmapOPen);
  bBitmapClose := TBitmap.Create;
  bBitmapClose.Handle := LoadBitmap(hInstance, 'Close');
  Canvas.Draw(0,0,bBitmapClose);
  WordReport:=TWordReport.Create;
  WordReport.Run;
  ReportTemplFile:='default.tmpl';
  CutExtention(ReportTemplFile, WorkId );
  Caption:=Caption0+'   '+ WorkId;
  Timer.Enabled:=true;
end;

procedure TReportForm.FormClose(Sender: TObject;  var Action: TCloseAction);
var i:integer;
   element:TBaseElement;
begin
 FreeAndNil(bBitMapOpen);
 FreeAndNil(bBitMapClose);
 if assigned(Title1Font) then freeandnil(Title1Font);
 if assigned(Title2Font) then freeandnil(Title2Font);

  for i:= ReportElements.count-1 downto 0 do
  begin
    element:=TBaseElement(ReportElements.items[i]);
    element.DeActivate;
    FreeAndNil(element);
    ReportElements.delete(i);
  end;
 ReportElements.Clear;
 FreeAndNil(ReportElements);
 if not ServerisRunning then  WordReport.Quit;
 FreeAndNil(WordReport);
  action:=caFree;
 ReportForm:=nil;
 Main.ReportGenerator.enabled:=true;
end;

procedure TReportForm.WordDocument;
var
 i,N:integer;
 ss:string;
PROCEDURE InsertText(i:integer);
begin
 WordReport.InsertText(TBaseElement(ReportElements.Items[i]).TitleContainer);
 WordReport.Insert((#13),Title2Font,false);
 WordReport.InsertText(TTextElement(ReportElements.Items[i]).TextContainer);
 WordReport.Insert((#13),Title2Font,false);
end;

PROCEDURE InsertPictureBlock(i:integer);
var j:integer;
    P:TPict;
begin
// Add the BookMark
 WordReport.InsertText(TBaseElement(ReportElements.Items[i]).TitleContainer);
 WordReport.Insert((#13),Title2Font,false);
 WordReport.AddBookMark('PicturesBookMark'+inttostr(i));
 WordReport.Insert((#13),Title2Font,false);
 n:=(TBaseElement(ReportElements[i]) as TPicturesElement).PictList.Count;
for j:=n-1 downto 0 do
 begin
  P:=(TBaseElement(ReportElements.items[i]) as TPicturesElement).PictList.Items[j];
  WordReport.InsertPicture(P);
  WordReport.Search('PicturesBookMark'+inttostr(i));
  WordReport.Insert((#13),Title2Font,false);
  P:=nil;
 end;
 WordReport.Search('EndOfDocument'+IntToStr(PictureBlocksCNT));
 inc(PictureBlocksCNT);
 WordReport.Insert({'Marker of ENd'+IntToStr(PictureBlocksCNT)+} #13+ #13,Title1Font,false);
 WordReport.AddBookMark('EndOfDocument'+IntToStr(PictureBlocksCNT));
 WordReport.Search('EndOfDocument'+IntToStr(PictureBlocksCNT-1));
end; //

begin
 Title1Font:=TFont.Create;
 with  Title1Font do
 begin
   Name:='Arial';
   Size:=10;
   Style:=[fsBold];
 end;
 Title2Font:=TFont.Create;
 with  Title2Font do
 begin
   Name:='TimesNewRoman';
   Color:=clGreen;
   Size:=10;
   Style:=[fsBold];
 end;
 if sLanguage='RUS' then ss:='  Группа No  '
                    else ss:='  Group No  '  ;

 WordReport.Insert(edName1.Text+ '  '+ edName2.Text, Title1Font,false);
 if edGroup.Text<>'' then
 WordReport.Insert(ss +edGroup.Text+ #13+#13, Title1Font,false);
 
 PictureBlocksCNT:=0;
 WordReport.AddBookMark('StartOfDocument');
 WordReport.Insert({'Marker of ENd'+IntToStr(PictureBlocksCNT)+} #13+ #13,Title1Font,false);
 WordReport.AddBookMark('EndOfDocument'+IntToStr(PictureBlocksCNT));
 WordReport.Search('StartOfDocument');
 for i:=0 to ReportElements.count-1 do
 begin
  if (TBaseElement(ReportElements.Items[i]) is TTextElement )      then InsertText(i);
  if (TBaseElement(ReportElements.Items[i]) is TPicturesElement )  then InsertPictureBlock(i);
 end;
end;


procedure TReportForm.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
var i:integer;
    P:TPict;
    element:TBaseElement;
begin
if (ssCtrl in Shift) then
begin
 if Key=vk_Delete then
 if assigned(ActiveElement) then
 if (ActiveElement is  TPicturesElement) then
// if not (ActiveControl is TTextContainer) then
 begin
  if assigned(ActivePict) then
  begin
   BitBtnH.SetFocus;
   Application.ProcessMessages;
   for i:=TPicturesElement(ActiveElement).PictList.Count-1 downto 0 do
   begin
    P:= TPicturesElement(ActiveElement).PictList.Items[i];
    if  P.Color=ColorActive then
     begin
     TPicturesElement(ActiveElement).DeletePicture(P);
  //   ActivePict:=nil ;  { TODO : 150607 }
     P:=nil;
     end;
   end;    { TODO : 150607 }
   if TPicturesElement(ActiveElement).PictList.Count>=1 then
   begin
    ActivePict:=TPicturesElement(ActiveElement).PictList.Items[0];
    ActivePict.Activate;
   end
   else   ActivePict:=nil ;
   Repaint;
  end;
end;
end;
if assigned(ActiveElement) then
 begin
//  if (key=vk_Delete) and   (ssCtrl in Shift) then
//                              begin bitbtn1.CLICK;{ DelContainer.click;}  end;
 end;
end;

procedure TReportForm.ClearTemplateFile(const LabWorkId:string);
var   iniTempl:TIniFile;
      sFile:string;
      i:integer;
      SectionsList:TStrings;
begin
 sFile:=ReportTemplPath +  LabWorkId+'.tmpl';
 if (not FileExists(sFile)) then  exit
                            else  iniTempl:=TIniFile.Create(sFile);
  try
   with iniTempl do
   begin
     SectionsList:=TStringList.Create;
     SectionsList.Capacity:=100;
     ReadSections(SectionsList);
     for i:=0 to SectionsList.Count-1 do
       begin
         EraseSection(SectionsList.Strings[i]);
       end;
   end;
  finally
   IniTempl.Free;
   SectionsList.Free;
  end;
end;

(*procedure TReportForm.SaveTemplate(LabWorkId:string);
var   F:File;
    iniTempl:TIniFile;
    sFile:string;
     i:integer;
begin
 sFile:=ReportTemplPath + LabWorkId+'.tmpl';
 if (not FileExists(sFile)) then
  begin
    AssignFile(F,sFile);
    ReWrite(F);
    CloseFile(F);
  end else
 if MessageDlg('File ' +  LabWorkId + '  exists. Rewrite it?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
    clearTemplateFile(LabWorkId)    else exit;

  iniTempl:=TIniFile.Create(SFile);
  try
 for i:=0 to ReportElements.count-1 do
  begin
   if (TBaseElement(ReportElements.Items[i]) is TTextElement )      then WriteTextSection(iniTempl,i);
   if (TBaseElement(ReportElements.Items[i]) is TPicturesElement )  then WritePictureSection(iniTempl,i);
  end;
  finally
    iniTempl.Free;
  end;
end;
*)
procedure TReportForm.SaveTemplate(const LabWorkId:string);
var   Fl:File;
    iniTempl:TIniFile;
    sFile:string;
     i:integer;
begin
 sFile:=ReportTemplPath + LabWorkId+'.tmpl';
 if (not FileExists(sFile)) then
  begin
    AssignFile(Fl,sFile);
    ReWrite(Fl);
    CloseFile(Fl);
  end else
      if siLangLinked1.MessageDlg(strrp2{'File '} +  LabWorkId + strrp3{'  exists. Rewrite it?'}, mtConfirmation, [mbYes, mbNo], 0) = IDYes
                                    then  clearTemplateFile(LabWorkId)    else exit;

  iniTempl:=TIniFile.Create(SFile);
  try
 for i:=0 to ReportElements.count-1 do
  begin
   if (TBaseElement(ReportElements.Items[i]) is TTextElement )      then WriteTextSection(iniTempl,i);
   if (TBaseElement(ReportElements.Items[i]) is TPicturesElement )  then WritePictureSection(iniTempl,i);
  end;
  finally
    iniTempl.Free;
  end;
end;

procedure TReportForm.siLangLinked1ChangeLanguage(Sender: TObject);
begin

  UpdateStrings;
end;

(*
procedure TReportForm.WriteTextSection(iniFile:TIniFile; BlockNmb:integer );
var  iniTempl:TIniFile;
     SectionName:string;
     P:TTextElement;
     i:integer;
     value:Tmemorystream;
   // value:Tstringstream;
    s:string;
begin
 SectionName:='T'+intToStr(BlockNmb);
 P:= TBaseElement(ReportElements.items[BlockNmb]) as TTextElement;
  with iniFile do
  begin
   WriteInteger(SectionName,'TitleStrNmb', p.titlecontainer.Lines.count);
   for i:=0 to p.titlecontainer.Lines.count-1 do
   begin
    value:=TStringStream.create('');
   try
    p.titlecontainer.plaintext:=false;
    value.Position := 0;
    p.titlecontainer.lines.SaveToStream(value);
   // value.writestring(p.titlecontainer.lines.strings[i]);
    value.Position := 0;
    WriteBinaryStream(SectionName, 'BlockTitle'+intTostr(i), Value);
   finally
    value.Free;
   end;
   end;
   WriteInteger(SectionName,'TextStrNmb', p.textcontainer.Lines.count);
     for i:=0 to p.textcontainer.Lines.count-1 do
   begin
    value:=TStringStream.create('');
    try
    p.textcontainer.plaintext:=false;
    value.Position := 0;
    p.textcontainer.lines.SaveToStream(value);
//    value.writestring(p.textcontainer.lines.strings[i]);
    value.Position := 0;
    WriteBinaryStream(SectionName, 'BlockText'+intTostr(i), Value);
    finally
    value.Free;
    end;
   end;

  end;
(*
  //  // Memory Stream for each line
  SectionName:='T'+intToStr(BlockNmb);
 P:= TBaseElement(ReportElements.items[BlockNmb]) as TTextElement;
  with iniFile do
  begin
   WriteInteger(SectionName,'TitleStrNmb', p.titlecontainer.Lines.count);
   for i:=0 to p.titlecontainer.Lines.count-1 do
   begin
   value:=TMemoryStream.create;
    try
     p.titlecontainer.Lines.SaveToStream( value);
     value.Position := 0;
     WriteBinaryStream(SectionName, 'BlockTitle'+intTostr(i), Value);
   finally
    value.Free;
   end;
   end;
   WriteInteger(SectionName,'TextStrNmb', p.textcontainer.Lines.count);
     for i:=0 to p.textcontainer.Lines.count-1 do
   begin
    value:=TMemoryStream.create;
    try
      p.textcontainer.lines.SaveToStream( value);
      value.Position := 0;
      WriteBinaryStream(SectionName,'BlockText' +intTostr(i),value);
    finally
    value.Free;
    end;
   end;

  end;
*)
(*end;
*)

 procedure TReportForm.WriteTextSection(iniFile:TIniFile; BlockNmb:integer );
var 
     SectionName:string;
     P:TTextElement;
     i:integer;
    value:Tstringstream;
    s:string;
begin

  SectionName:='T'+intToStr(BlockNmb);
 P:= TBaseElement(ReportElements.items[BlockNmb]) as TTextElement;
  with iniFile do
  begin
   WriteInteger(SectionName,'TitleStrNmb', p.titlecontainer.Lines.count);
   for i:=0 to p.titlecontainer.Lines.count-1 do
   begin
    value:=TStringStream.create(s);
   try
    value.Position := 0;
    value.writestring(p.titlecontainer.lines.strings[i]);
    value.Position := 0;
    WriteBinaryStream(SectionName, 'BlockTitle'+intTostr(i), Value);
   finally
    value.Free;
   end;
   end;
   WriteInteger(SectionName,'TextStrNmb', p.textcontainer.Lines.count);
     for i:=0 to p.textcontainer.Lines.count-1 do
   begin
    value:=TStringStream.create(s);
    try
    value.Position := 0;
    value.writestring(p.textcontainer.lines.strings[i]);
    value.Position := 0;
    WriteBinaryStream(SectionName, 'BlockText'+intTostr(i), Value);
    finally
    value.Free;
    end;
   end;

  end;
end;
 procedure TReportForm.WritePictureSection(iniFile:TIniFile; BlockNmb:integer );
var  SectionName:string;
     P:TPicturesElement;
     i:integer;
     value:Tstringstream;
     s:string;
begin

  SectionName:='P'+intToStr(BlockNmb);
 P:= TBaseElement(ReportElements.items[BlockNmb]) as TPicturesElement;
  with iniFile do
  begin
   WriteInteger(SectionName,'TitleStrNmb', p.titlecontainer.Lines.count);
   for i:=0 to p.titlecontainer.Lines.count-1 do
   begin
    value:=TStringStream.create(s);
   try
    value.Position := 0;
    value.writestring(p.titlecontainer.lines.strings[i]);
    value.Position := 0;
    WriteBinaryStream(SectionName, 'BlockTitle'+intTostr(i), Value);
   finally
    value.Free;
   end;
   end;
  end;
end;

(*
procedure TReportForm.WritePictureSection (iniFile:TIniFile; BlockNmb:integer );
var  iniTempl:TIniFile;
     SectionName:string;
     P:TPicturesElement;
//     i:integer;
     value:Tmemorystream;
begin
 SectionName:='P'+intToStr(BlockNmb);
 P:= TBaseElement(ReportElements.items[BlockNmb]) as TPicturesElement;
 with iniFile do
  begin
   value:=Tmemorystream.create;
  try
   p.titlecontainer.Lines.SaveToStream( value);
   value.Position := 0;
   WriteBinaryStream(SectionName, 'BlockTitle', Value);
  finally
   value.Free;
  end;
 end;
end;

*)
(*
procedure TReportForm.WritePictureSection (iniFile:TIniFile; BlockNmb:integer );
var  iniTempl:TIniFile;
     SectionName:string;
     P:TPicturesElement;
     i:integer;
   //  value:Tmemorystream;
   value:TStringstream;
   s:string;
begin
 SectionName:='P'+intToStr(BlockNmb);
 P:= TBaseElement(ReportElements.items[BlockNmb]) as TPicturesElement;
 with iniFile do
  begin
   WriteInteger(SectionName,'TitleStrNmb', p.titlecontainer.Lines.count);
   for i:=0 to p.titlecontainer.Lines.count-1 do
   begin
  // value:=Tmemorystream.create;
  value:=TStringstream.Create(s);
  try
 //  p.titlecontainer.Lines.SaveToStream( value);
   value.Position := 0;
   p.titlecontainer.plaintext:=false;
   p.titlecontainer.Lines.SaveToStream( value);
   // value.writestring(p.titlecontainer.lines.strings[i]);
   value.Position := 0;
   WriteBinaryStream(SectionName, 'BlockTitle'+intTostr(i), Value);
  finally
   value.Free;
  end;
 end;
 end;
end;
*)
procedure TReportForm.DeActivateAll;
var i:integer;
begin
if  ReportElements.Count>0 then
 for i:=0 to ReportElements.Count-1 do
  TBaseElement(ReportElements.Items[i]).DeActivate;
end;

(*
procedure TReportForm.ReadTemplate(const ReportFile :string);
var SFile:string;
    iniTemp:TiniFile;
    TitleStrNmb, goalsNmb, QuestionsNmb, i,j:integer;
    NSections, StrNmb:integer;
    ss:string;
    SectionName, BlockTitle,s:string;
    SectionsList:TStrings;
 //   P:TTextElement;
 //   value:Tmemorystream;
    value:Tstringstream;
    NStr,count, ICount:integer;
    TMPStrings:TStringList;
begin
if ReportElements.count>0 then
  begin
    for i:=ReportElements.count-1  downto 0 do
     begin
     TObject(ReportElements.items[i]).Free;
     ReportElements.delete(i);
     end;
     ReportElements.Free;
   end;
ReportElements:=TLIst.Create;
TMPStrings:=TStringList.Create;
TmpStrings.Capacity:=20;
sFile:=ReportFile;
if (not FileExists(sFile)) then
  begin
   ShowMessage('No Report Templates File ');
   exit;
  end
 else
  begin
  iniTemp:=TIniFile.Create(sFile);
  try
    with iniTemp do
    begin
       SectionsList:=TStringList.Create;
       SectionsList.Capacity:=100;
       ReadSections(SectionsList);
       NSections:=SectionsList.Count;
       for i:=0 to NSections-1 do
       begin
         SectionName:=SectionsList.Strings[i];
         if SectionName[1]='T' then
             begin
               AddTextBlock(BlockTitle);
               Resize;
               NStr:=ReadInteger(SectionName, 'TitleStrNmb', 0);
               for j:=0 to NStr-1 do
                 begin
                   value:=Tstringstream.create('');
                    try
                       ICount:=ReadBinaryStream(SectionName, 'BlockTitle'+IntToStr(j), Value);
                       if icount>0 then
                      begin
                     // value.Position:=0;
                    //  ActiveElement.titlecontainer.Lines.LoadFromStream( value);
                      TMPStrings.LoadFromStream( value);
                  //    s:=TMPStrings.Strings[0];
                 //     ActiveElement.titlecontainer.Lines.add(TMPStrings.Strings[0]);
                      TTextElement(ActiveElement).titlecontainer.plaintext:=false;
                      TTextElement(ActiveElement).titlecontainer.text:=value.DataString;
                      end;
                    finally
                        value.Free;
                        TMPStrings.Clear;
                    end;
                 end;
                ActiveElement.titlecontainer.SelStart:=0;
                ActiveElement.titlecontainer.Perform(EM_SCROLLCARET, 0, 0);
                  NStr:=ReadInteger(SectionName, 'TextStrNmb', 0);
               for j:=0 to NStr-1 do
                 begin
                   value:=Tstringstream.create('');
                    try
                       ICount:=ReadBinaryStream(SectionName, 'BlockText'+IntToStr(j), Value);
                       if icount>0 then
                       begin
                       // value.Position:=0;
                       //  TTextElement(ActiveElement).textcontainer.Lines.LoadFromStream( value);

                        TMPStrings.LoadFromStream( value);
                        TTextElement(ActiveElement).textcontainer.plaintext:=false;
                        TTextElement(ActiveElement).textcontainer.text:=value.DataString;
                      // s:= TMPStrings.Strings[0];
                     //  TTextElement(ActiveElement).textcontainer.Lines.add(s);
                       end;
                    finally
                    value.Free;
                    TMPStrings.Clear;
                    end;
                 end;
                    TTextElement(ActiveElement).textcontainer.SelStart:=0;
                    TTextElement(ActiveElement).titlecontainer.Perform(EM_SCROLLCARET, 0, 0);
              end
             else
             begin
               AddPictureBlock(BlockTitle);
               Resize;
                 NStr:=ReadInteger(SectionName, 'TitleStrNmb', 0);
               for j:=0 to NStr-1 do
                 begin
                   value:=Tstringstream.create('');
                    try
                       ICount:=ReadBinaryStream(SectionName, 'BlockTitle'+IntToStr(j), Value);
                      if icount>0 then
                      begin
                       value.Position:=0;
                    //   ActiveElement.titlecontainer.Lines.LoadFromStream( value);
                        TMPStrings.LoadFromStream( value);
                        TTextElement(ActiveElement).titlecontainer.plaintext:=false;
                        TTextElement(ActiveElement).titlecontainer.text:=value.DataString;
                 // TMPStrings.LoadFromStream( value);
                      //  s:=TMPStrings.Strings[0];
                      //  ActiveElement.titlecontainer.Lines.add(s);//( TMPStrings.Strings[0]);
                       end;
                      finally
                        value.Free;
                        TMPStrings.Clear;
                      end;
                  end;
                 ActiveElement.titlecontainer.SelStart:=0;
                 ActiveElement.titlecontainer.Perform(EM_SCROLLCARET, 0, 0);
               end;
        end;
      end;
  finally
   iniTemp.Free;
   SectionsList.Free;
   TmpStrings.Free;
  end;
 end;
{  with ActiveElement.TitleContainer.DefAttributes do
                              begin
                                Name:='MS Sans Serif';
                                Style:=[fsBold];
                                Size:=10;
                              end;  }
{ with ActiveElement.TitleContainer.SelAttributes do
                              begin
                                Name:='Arial';
                                Style:=[fsBold];
                                Size:=11;
                              end;
 if  ActiveElement is  TTextElement then
 with TTextElement(ActiveElement).TextContainer.SelAttributes do
                              begin
                                Name:='Arial';
                                Style:=[fsBold];
                                Size:=11;
                              end;  }
(*end;   {ReadTemplate}
*)
 function   TReportForm.CaptureSourceImage(Source: TObject):boolean;
 begin
         result:=false;
             if (ActiveElement is TPicturesElement)then
                begin
                (ActiveElement as TPicturesElement).CaptureImage(Source);
                 result:=true;
                end;
 end;

procedure TReportForm.ReadTemplate(const ReportFile :string);
var SFile:string;
    iniTemp:TiniFile;
    TitleStrNmb, goalsNmb, QuestionsNmb, i,j:integer;
    NSections, StrNmb:integer;
    ss:string;
    SectionName, BlockTitle,s:string;
    SectionsList:TStrings;
    value:Tmemorystream;
    NStr,count, ICount:integer;
    TMPStrings:TStringList;
begin
if ReportElements.count>0 then
  begin
    for i:=ReportElements.count-1  downto 0 do
     begin
     TObject(ReportElements.items[i]).Free;
     ReportElements.delete(i);
     end;
   //  ReportElements.Free;
   end;
//ReportElements:=TList.Create;

TMPStrings:=TStringList.Create;
try
 TmpStrings.Capacity:=20;
 sFile:=ReportFile;
 if (not FileExists(sFile)) then
  begin
   ShowMessage(strrp4{'No Report Templates File '});
   exit;
  end
 else
  begin
  iniTemp:=TIniFile.Create(sFile);
   try
    with iniTemp do
    begin
       SectionsList:=TStringList.Create;
       SectionsList.Capacity:=100;
       ReadSections(SectionsList);
       NSections:=SectionsList.Count;
       for i:=0 to NSections-1 do
       begin
         SectionName:=SectionsList.Strings[i];
         if SectionName[1]='T' then
             begin
               AddTextBlock(BlockTitle);
               Resize;
               NStr:=ReadInteger(SectionName, 'TitleStrNmb', 0);
               for j:=0 to NStr-1 do
                 begin
                   value:=Tmemorystream.create;
                    try
                       ICount:=ReadBinaryStream(SectionName, 'BlockTitle'+IntToStr(j), Value);
                       if icount>0 then
                      begin
                      TMPStrings.LoadFromStream( value);
                      s:=TMPStrings.Strings[0];
                      ActiveElement.titlecontainer.Lines.add(TMPStrings.Strings[0]);
                      end;
                    finally
                        value.Free;
                        TMPStrings.Clear;
                    end;
                 end;
                ActiveElement.titlecontainer.SelStart:=0;
                ActiveElement.titlecontainer.Perform(EM_SCROLLCARET, 0, 0);
                  NStr:=ReadInteger(SectionName, 'TextStrNmb', 0);
               for j:=0 to NStr-1 do
                 begin
                   value:=Tmemorystream.create;
                    try
                       ICount:=ReadBinaryStream(SectionName, 'BlockText'+IntToStr(j), Value);
                       if icount>0 then
                       begin
                       TMPStrings.LoadFromStream( value);
                       s:= TMPStrings.Strings[0];
                       TTextElement(ActiveElement).textcontainer.Lines.add(s);
                       end;
                    finally
                     value.Free;
                     TMPStrings.Clear;
                    end;
                 end;
                    TTextElement(ActiveElement).textcontainer.SelStart:=0;
                    TTextElement(ActiveElement).titlecontainer.Perform(EM_SCROLLCARET, 0, 0);
              end
             else
             begin
               AddPictureBlock(BlockTitle);
               Resize;
                 NStr:=ReadInteger(SectionName, 'TitleStrNmb', 0);
               for j:=0 to NStr-1 do
                 begin
                   value:=Tmemorystream.create;
                    try
                       ICount:=ReadBinaryStream(SectionName, 'BlockTitle'+IntToStr(j), Value);
                      if icount>0 then
                      begin
                        TMPStrings.LoadFromStream( value);
                        s:=TMPStrings.Strings[0];
                        ActiveElement.titlecontainer.Lines.add(s);//( TMPStrings.Strings[0]);
                       end;
                      finally
                        value.Free;
                        TMPStrings.Clear;
                      end;
                  end;
                 ActiveElement.titlecontainer.SelStart:=0;
                 ActiveElement.titlecontainer.Perform(EM_SCROLLCARET, 0, 0);
               end;
        end;
      end;
   finally
     iniTemp.Free;
     SectionsList.Free;
   end;
   end
   finally
    TmpStrings.Free;
   end;
  with ActiveElement.TitleContainer.DefAttributes do
                              begin
                                Name:='MS Sans Serif';
                                Style:=[fsBold];
                                Size:=10;
                              end;
 with ActiveElement.TitleContainer.SelAttributes do
                              begin
                                Name:='MS Sans Serif';
                                Style:=[fsBold];
                                Size:=10;
                              end;
end;   {ReadTemplate}

Procedure TPicturesElement.PicturesElementDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 BringWindowToTop(ReportForm.handle);
 Accept:=(Source is TPanel) or(Source is TPageControl)or (Source is TStringGrid) or (Source is TChart) or  FlgImgAnalysDrag
 or (Source is TImage);
end;

Procedure TPicturesElement.PicturesElementDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
 ReportForm.DeActivateAll;
 self.Activate;
 AddPicture;
 ActivePict.activate;
 ReportForm.BitBTnH.SetFocus;
 TControl(Source).EndDrag(false);
end;

procedure TReportForm.FormResize(Sender: TObject);
var H,i:integer;
begin
if Assigned(ReportElements) then
 begin
  if ReportElements.Count>0 then
  begin
     TBaseElement(ReportElements.items[0]).Top:=5;
     H:=TBaseElement(ReportElements.items[0]).height+5;//5;
     TBaseElement(ReportElements.items[0]).width:=PanelReport.Width-15;//20;
    for i:=1 to ReportElements.Count -1  do
     begin
     TBaseElement(ReportElements.Items[i]).Top:= TBaseElement(ReportElements.Items[i-1]).Top+
                                                 TBaseElement(ReportElements.items[i-1]).Height+5;
      TBaseElement(ReportElements.items[i]).width:=PanelReport.Width-15;
      H:=H+TBaseElement(ReportElements.items[i]).height+8;
         end;
     height:=PanelTop.Height+H+50;
   end;
 end;
 statusbar.panels[0].width:=width div 2;
end;

procedure SetFont(TextContainer:TTextContainer; FontColor:TColor; FontStyle:TFontStyles; FontSize:integer );
begin
With   TextContainer.SelAttributes do
begin
 Color:=FontColor;
 Style:=FontStyle;
 Size:=FontSize;
end;
end;

procedure TReportForm.BitBtnPrintClick(Sender: TObject);
begin
 WordReport.ReRun;
 WordReport.NewDoc;
 WordDocument;
 Wordreport.Print;
 WordReport.Close;
end;

procedure TReportForm.BitBtnOpenDocClick(Sender: TObject);
begin
 WordReport.ReRun;
 WordReport.NewDoc;
 WordDocument;
 WordReport.Show;
end;

procedure TReportForm.BitBtnSaveClick(Sender: TObject);
begin
 WordReport.ReRun;
 WordReport.NewDoc;
 WordDocument;
  SaveDialog.initialdir:=workdirectory;
if SaveDialog.Execute then WordReport.Save(SaveDialog.FileName);
 WordReport.Close;
end;
procedure TReportForm.TextContainerClick(Sender: TObject);
begin
   AddTextBlock('');
//   ActiveElement.SetFocus;
   Resize;
end;

procedure TReportForm.TimerTimer(Sender: TObject);
begin
   Timer.Enabled:=false;
   ReadTemplate(ReportTemplPath+ReportTemplFile);
end;

procedure TReportForm.UpdateStrings;
begin
  strrp0 := siLangLinked1.GetTextOrDefault('strstrrp0');
  strrp13 := siLangLinked1.GetTextOrDefault('strstrrp13');
  strrp12 := siLangLinked1.GetTextOrDefault('strstrrp12');
  strrp11 := siLangLinked1.GetTextOrDefault('strstrrp11');
  strrp10 := siLangLinked1.GetTextOrDefault('strstrrp10');
  strrp9 := siLangLinked1.GetTextOrDefault('strstrrp9');
  strrp8 := siLangLinked1.GetTextOrDefault('strstrrp8');
  strrp7 := siLangLinked1.GetTextOrDefault('strstrrp7');
  strrp6 := siLangLinked1.GetTextOrDefault('strstrrp6');
  strrp5 := siLangLinked1.GetTextOrDefault('strstrrp5');
  strrp4 := siLangLinked1.GetTextOrDefault('strstrrp4');
  strrp3 := siLangLinked1.GetTextOrDefault('strstrrp3');
  strrp2 := siLangLinked1.GetTextOrDefault('strstrrp2');
end;

procedure TReportForm.PictureContainerClick(Sender: TObject);
begin
  AddPictureBlock('');
//  ActiveElement.SetFocus;
  Resize;
end;

procedure TReportForm.AddTextBlock(const Title:string);
var element: TTextElement;
    s:string;
begin
  DeActivateAll;
  Element:=TTextElement.Create(TComponent(PanelReport),Title);
  ActiveElement:=Element;
  ReportElements.Add(Element);
  Element.Parent:=PanelReport;
  Element.Left:=5;
  Element.top:=0;
  ActiveElement.TitleContainer.SetFocus;
  s:= ActiveElement.TitleContainer.SelAttributes.Name;
  with ActiveElement.TitleContainer.DefAttributes do
  begin
    // Name:='MS Sans Serif';
     Name:='Arial';
     Style:=[fsBold];
     Size:=11;
     Color:=clBlack;
  end;
  with ActiveElement.TitleContainer.SelAttributes do
  begin
    // Name:='MS Sans Serif';
     Name:='Arial';
     Style:=[fsBold];
     Size:=11;
     Color:=clBlack;
  end;

  with (ActiveElement as TTextElement).TextContainer.DefAttributes do
  begin
    // Name:='Times New Roman';//'MS Sans Serif';
     Name:='Arial';
     Size:=12;
     Color:=clBlack;
  end;
  with (ActiveElement as TTextElement).TextContainer.SelAttributes do
  begin
    // Name:='Times New Roman';//'MS Sans Serif';
     Name:='Arial';
     Size:=12;
     Color:=clBlack;
  end;
  ActiveText:=ActiveElement.TitleContainer;
end;

procedure TReportForm.AddPictureBlock(const Title:string);
var
  element:TPicturesElement;
begin
  DeActivateAll;
  element:=TPicturesElement.Create(TComponent(PanelReport),Title);
  ActiveElement:=element;
  ReportElements.Add(Element);
  Element.Parent:=PanelReport;
  Element.Left:=5;
  Element.top:=0;
  ActiveElement.TitleContainer.SetFocus;
  ActiveText:=ActiveElement.TitleContainer;
   with ActiveElement.TitleContainer.DefAttributes do
  begin
    // Name:='MS Sans Serif';
     Name:='Arial';
     Style:=[fsBold];
     Size:=11;
     Color:=clBlack;
  end;
  with ActiveElement.TitleContainer.SelAttributes do
  begin
    // Name:='MS Sans Serif';
     Name:='Arial';
     Style:=[fsBold];
     Size:=11;
     Color:=clBlack;
  end;
end;

procedure TReportForm.BitBtnAddMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var point,pointa:Tpoint;
begin
    point.x:=x;
    point.y:=y;
    pointa:=BitBtnAdd.ClientToScreen(point);
    PopupMenuAdd.Popup(pointa.X,pointa.y);
end;

procedure TReportForm.BitBtnDelActClick(Sender: TObject);
var i, n:integer;
    element:TbaseElement;
begin
 for i:= ReportElements.count-1 downto 0 do
  begin
   n:=i;
   element:=TBaseElement(ReportElements.items[i]);
   if element=ActiveElement then
   begin
    element.DeActivate;
    FreeAndNil(element);
    ReportElements.delete(i);
   end;
  end;
   Resize;
  if ReportElements.count>0 then
  begin
     ActiveElement:=ReportElements.items[ReportElements.count-1];
     ActiveElement.Activate;
  end;
end;

procedure TReportForm.BitBtnSaveTmplClick(Sender: TObject);
var WorkId:string;
begin
 FormLabDlg:=TFormLabDlg.Create(self);
 FormLabDlg.Caption:=siLangLinked1.GetTextOrDefault('IDS_90' (* 'Save Template' *) );
if  FormLabDlg.ShowModal=mrOK then
 begin
  CutExtention(ReportTemplFile, WorkId );
  SaveTemplate(WorkId);
 end;
end;

procedure TReportForm.BitBtnLoadClick(Sender: TObject);
var WorkId:string;
begin
 FormLabDlg:=TFormLabDlg.Create(self);
 FormLabDlg.Caption:=siLangLinked1.GetTextOrDefault('IDS_91' (* 'Chooose Report Template' *) );
if  FormLabDlg.ShowModal=mrOK then
 begin
  CutExtention(ReportTemplFile, WorkId );
  Caption:=Caption0+'   '+ WorkId;
  ReadTemplate(ReportTemplPath+ReportTemplFile);
 end;
 if Assigned(ReportElements) then
  begin
   if ReportElements.Count>0 then
   begin
     DeActivateAll;
     TBaseElement(ReportElements.Items[0]).Activate;
     ActiveText:=TBaseElement(ReportElements.Items[0]).TitleContainer;
     TBaseElement(ReportElements.Items[0]).TitleContainer.SetFocus;
   end;
 end;
end;

procedure TReportForm.CutExtention(const InName:string ; var OutName:string);
var
  name,ext:string;
  newName:string;
  i,L:integer;
begin
 name:=ExtractFileName(InName);
 ext:=ExtractFileExt(inName);
 L:= Length(ext);
 L:=Length(name)-L;
 SetLength(NewName,L);
 for i:=1 to L do   NewName[i]:=name[i];
 OutName:=NewName;
end;

procedure TReportForm.BitBtnDelActMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var point,pointa:Tpoint;
begin
    point.x:=x;
    point.y:=y;
    pointa:=BitBtnDelAct.ClientToScreen(point);
    PopupMenuDel.Popup(pointa.X,pointa.y);
end;


procedure TReportForm.DelContainerClick(Sender: TObject);
var      i:integer;
   element:TbaseElement;
begin
 for i:= ReportElements.count-1 downto 0 do
  begin
   element:=TBaseElement(ReportElements.items[i]);
   if element.Color=ColorActive then
   begin
    element.DeActivate;
    FreeAndNil(element);
    ReportElements.delete(i);
   end;
  end;
   Resize;
  if ReportElements.count>0 then
  begin
     ActiveElement:=ReportElements.items[ReportElements.count-1];
     ActiveElement.Activate;
  end;
end;

procedure TReportForm.DelImageClick(Sender: TObject);
 var i:integer;
    P:TPict;
begin  { TODO : 150607 }
  MakeDelImage;
end;
procedure TReportForm.MakeDelImage;
 var i,ii:integer;
    P:TPict;
 begin
// if not(ActiveControl is  TTextContainer) then
 begin
  BitBtnH.SetFocus;
  if assigned(ActivePict) then
  for i:=TPicturesElement(ActiveElement).PictList.Count-1 downto 0 do
  begin
   P:= TPicturesElement(ActiveElement).PictList.Items[i];
   if  P.Color=ColorActive then
   begin
     TPicturesElement(ActiveElement).DeletePicture(P);
     ActivePict:=nil ;
     ii:=i;
     P:=nil;
   end;
  end;
  if TPicturesElement(ActiveElement).PictList.Count>0 then
   begin
      ActivePict:=TPicturesElement(ActiveElement).PictList.Items[0];
       ActivePict.Activate;
   end;

  RePaint;
 end;
end;
procedure TReportForm.BitBtnFontClick(Sender: TObject);
begin
if Assigned(ActiveText) then FontDialog.Font.Assign(ActiveText.SelAttributes);
if FontDialog.execute then
 begin
 if assigned(ActiveText) then
  begin
    ActiveText.SelAttributes.Assign(FontDialog.Font);
  // ActiveElement.TitleContainer.SelAttributes.Assign(FontDialog.Font);
  // if (ActiveElement is TTextElement) then  TTextElement(ActiveElement).TextContainer.SelAttributes.Assign(FontDialog.Font);
    ActiveText.CaretPos:=CursorPos;
    ActiveText.SetFocus;
  end;
 end;
end;

procedure TReportForm.BitBtnHClick(Sender: TObject);
begin
  HlpContext:=IDH_reportR;
  Application.HelpContext(HlpContext);
end;


procedure TReportForm.FormShow(Sender: TObject);
//var workId:string;
begin
(*  ReportTemplFile:='default.tmpl';
  CutExtention(ReportTemplFile, WorkId );
  Caption:=Caption0+'   '+ WorkId;
  ReadTemplate(ReportTemplPath+ReportTemplFile);
*)
end;

procedure TReportForm.PanelreportResize(Sender: TObject);
begin
   if PanelReport.height>700 then
                                begin
                                 PanelReport.AutoScroll:=true;
                                 PanelReport.VertScrollBar.Position:=0
                                end
                               else
                               begin
                                PanelReport.VertScrollBar.Position:=0;
                                PanelReport.AutoScroll:=false;
                               end;
end;

procedure TReportForm.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
   if (Msg.CharCode = VK_DELETE) and (GetKeyState(VK_CONTROL) < 0) then
   begin
     MakeDelImage;
     Handled := True;
   end
end;

initialization
begin
 ColorActive:=clActiveCaption;
 ColorPassive:=clInActiveCaption;
end;

end.


