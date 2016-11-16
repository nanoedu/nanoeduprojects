//270705    LIST
// problem  order insert element when add more one
unit UReportClasses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, buttons, stdctrls, clipbrd, comObj, ActiveX, grids,  chart, globalvar,
  iniFiles, comctrls, OpenGLDraw, OleServer, WordXP, Menus;

const BaseH=200;
      BaseW=720;
      TitleH=40;
(*
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
*)
      //  WordXP.pas

//const ReportTemplFile='RepTemp.tmpl';

type WordArray2D=array of array of word;
type TTextContainer=TRichEdit;//TMemo;

type TBaseElement=class(TPanel)
   TitleBtn:TSpeedButton;
   TitlePanel:TPanel;
   ControlImage:TImage;
   TitleContainer:  TTextContainer;
   TextPanel:TPanel;
  protected
    FlgBlockOpened:Boolean;
    HElement:integer;
  public
     Position:Integer;
     constructor Create(var AOwner: TComponent; title:string);
     destructor Destroy;
     procedure Activate;    virtual; abstract;
     procedure DeActivate;  virtual; abstract;
//   procedure TitleBtnClick(Sender: TObject);
     procedure ControlImageClick(Sender: TObject);
     procedure ElementResize(Sender: TObject);
     procedure RichEditClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

end;


type TTextElement=class( TBaseElement)
  TextContainer:TTextContainer;
  constructor Create(var AOwner: TComponent; title:string);
 // destructor Destroy; override;
     procedure Activate;    override;
     procedure DeActivate;  override;
end;

type TPict=class(TPanel)
 private
  PictBitMap:tBitMap;
  ComprBitMap:TBitMap;
  BufBitMap:TBitMap;
  procedure   Compr8bitBMP(K,L:integer);
  procedure   Compr24bitBMP(K:integer);
  procedure   ComprPicture(BMPFormat:integer; ComprCoef:integer; SmoothArea:integer);
  function    Convolute2D(iy,ix:integer; Data:WordArray2D; FieldSize:integer):integer;
  procedure   MakePalette(BitMap: TBitMap);
 public
  ReportPicture:tImage;
  PictTitle:TTextContainer;
  constructor Create(var AOwner: TComponent);
  Destructor  Destroy; override;
  procedure   ConvertBMPTo8Bit(tobmp: TBitmap; frbmp : TGraphic);
  procedure   ReportPictureMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
  procedure   Activate;
  procedure   DeActivate;
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
 constructor Create(var AOwner: TComponent; title:string);
 destructor  Destroy;// override;
 procedure   Activate;   override;
 procedure   DeActivate;  override;
end;

type TBaseArray=array of TBaseElement;

//  WORD Declarations

type TWordReport=class

public
  MsWord:Variant; // Main
//  function Version:string; //shadow
  procedure Error(i:integer;str:string); //intro
  Procedure Run;
  procedure ReRun;
  procedure NewDoc;
  procedure Insert(info:string;SourceFont:TFont; _center:boolean);
  procedure InsertText(Source:TTextContainer);
  procedure Hide;
  procedure Show;
  procedure Quit;
  procedure Free;
  procedure Close;  //Закрыть документ WORD:
  procedure Save(Name:string);   //Сохранить активный документ:
  procedure SaveAs;
  procedure Print;  //Отправка активного документа на печать:
  procedure NewPage; //Разрыв страницы - переход к новой странице.
  procedure Paste;   // вставить из буфера
  procedure NextCell; // Go to next cell in table
  procedure InsertPicture(Pict:TPict);
  procedure Search(data:string);
  procedure AddBookMark(BookMark:string);
  procedure CreateTable(NLines, NRows:integer);
  procedure InsertAfter(Str:string);
  procedure Move(MoveType, Number:integer);
end;

type
  TReportForm = class(TForm)
    PanelReport: TPanel;
    PanelTop: TPanel;
    FontDialog1: TFontDialog;
    SaveDialog: TSaveDialog;
    PanelBottom: TPanel;
    Label1: TLabel;
    PanelUp: TPanel;
    GroupBox1: TGroupBox;
    BitBtnOpenDoc: TBitBtn;
    BitBtnPrint: TBitBtn;
    BitBtnSave: TBitBtn;
    BitBtnH: TBitBtn;
    RadioGroup1: TRadioGroup;
    GroupBox2: TGroupBox;
    EdName2: TEdit;
    Label2: TLabel;
    EdName1: TEdit;
    Label3: TLabel;
    EdGroup: TEdit;
    GroupBoxAct: TGroupBox;
    PopupMenuAdd: TPopupMenu;
    Title: TMenuItem;
    TextContainer: TMenuItem;
    PictureContainer: TMenuItem;
    BitBtnDelAct: TBitBtn;
    BitBtnAdd: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabelWorkId: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;   Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure PanelReportResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure BitBtnOpenDocClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure TextContainerClick(Sender: TObject);
    procedure PictureContainerClick(Sender: TObject);
    procedure BitBtnAddMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BitBtnDelActClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
     Title1Font, Title2Font :TFont;
     WordReport:TWordReport;
     VisibleDocument:Boolean;
     PictureBlocksCNT:integer;
     procedure WordDocument;
     procedure WriteTextSection(iniFile:TIniFile; BlockNmb:integer );
     procedure WritePictureSection (iniFile:TIniFile; BlockNmb:integer);
     procedure AddTextBlock(Title:string);
     procedure AddPictureBlock(Title:string);
     procedure CutExtention(InName:string ; var OutName:string);
    { Private declarations }
  public
    { Public declarations }
    ReportElements:TList;
    procedure ClearTemplateFile(LabWorkId:string);
    procedure  SaveTemplate(LabWorkId:string);
    procedure  ReadTemplate(ReportFile :string);
    procedure  DeActivateAll;
  end;
var
  ReportForm: TReportForm;
  ElementsN:integer;
  ServerIsRunning:Boolean;

procedure SetFont(TextContainer:TTextContainer; {FontName:TFontName;} FontColor:TColor; FontStyle:TFontStyles; FontSize:integer );

implementation

uses FChooseLab, FLabWorkId;

{$R *.dfm}

var
  ActivePict:TPict;
  ActivePictureElement:TpicturesElement;
  ActiveElement:TBaseElement;
constructor TPict.Create(var AOwner: TComponent);
var ComprKoef, SmoothArea:integer;
    BMPFormat:integer;
begin
  inherited Create(AOwner);
  ComprKoef:=8;
  SmoothArea:=3;
  BMPFormat:=8;//24;
  DragMode:=dmAutomatic;
  ReportPicture:=tImage.Create(Self);
  height:=50;
  With ReportPicture do
  begin
     parent:=Self;
     Left:=2;
     top:=2;
     width:=50;;//self.ClientHeight;
     Height:=width;
  end;
  PictBitMap:=tBitMap.Create;
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
     Height:=50;//self.ClientHeight;
     ScrollBars:=ssBoth;
     WordWrap:=False;
  end;
end;

Destructor TPict.Destroy;
begin
FreeandNil(PictBitMap);
 PictTitle.Destroy;//Free;
 ReportPicture.Destroy;//Free;
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
                   //  if (i >= 0) and (i < X)
                  //      and (j >= 0) and (j < Y) then
                  //   begin
                        ires:=ires+1;
                        res:=res+Data[j,i];
                    // end;
                end; {for kx}
             end; {for ky}
             if ires <> 0 then Result:=round(res/ires)
                          else Result:=Data[j,i];
          //   end;
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
     { TODO : 290903 }
    DeleteObject(hPal);
////  ???
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
  Color:=clBlue;
end;
procedure  TPict.DeActivate;
begin
  Color:=clBtnFace;//clGray;
end;
procedure TPict.ReportPictureMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var  i:integer;
     Element:TPicturesElement ;
     P:TPict;
begin
if Button=(mbLeft) then
begin
 // REportForm.DeActivateAll;
  ActivePictureElement:=TpicturesElement((self.parent).parent);
(* if (ActiveElement is TpicturesElement) and (ActiveElement<>TpicturesElement(Self)) then
  begin
     Element:=(ActiveElement as TpicturesElement);
     for i:=0 to Element.PictList.Count-1 do
      begin
      P:= Element.PictList.Items[i];
      P.Color:=clBtnFace;
      end;
  end;  *)
 ActiveElement:=TPicturesElement((self.parent).parent);
 ActiveElement.Activate;
 if (not (ssShift in Shift)) and assigned(ActivePict) then
// ActivePict.Color:=clBtnFace;
  begin
     Element:=(ActiveElement as TpicturesElement);
     for i:=0 to Element.PictList.Count-1 do
      begin
      P:= Element.PictList.Items[i];
      P.DeActivate;//Color:=clBtnFace;
      end;
    end;
  Activate;
// Self.Color:=clHighlight;
 Self.Parent.SetFocus;
 ActivePict:=Self;
 end;
end;

//TBaseElement
constructor TBaseElement.Create(var AOwner: TComponent ; title:string);
begin
   inherited Create(AOwner);
    Self.Width:=BaseW-4;
    Self.Height:=TitleH+10;
    HElement:=BaseH;
    TitlePanel:=TPanel.Create(Self);
    FlgBlockOpened:=False;
    color:=ClBlue;
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

    TitleContainer:=TTextContainer.Create(Self);
    with   TitleContainer do
    begin
      Parent:=TitlePanel;
      Left:=4;
      Top:=4;
      Width:=Parent.Width-TitleH-8;
      Height:=TitleH-8;
      BevelInner:=bvNone;
      BevelOuter:=bvNone;
      BevelKind:=bkNone;
      BorderStyle:=bsNone;
      ScrollBars:=ssBoth;
      WordWrap:=False;
    end;

  (*  TitleBtn:=TSpeedButton.Create(Self);
    with   TitleBtn do
    begin
      Parent:=TitlePanel;//self;
      allowAllUp:=True;
      Left:=TitleContainer.Width+5;
      Top:=3;
      Height:=TitleContainer.height-4;
      Width:=Height;
      Caption:='Open';//title;
      GroupIndex:=1;
      OnClick:=TitleBtnClick;
      Down:=false;
    end;
     *)
     ControlImage:=TImage.Create(Self);
     with ControlImage do
       begin
          Parent:=TitlePanel;//}self;
          Left:=TitleContainer.Width+5;
          Top:=2;
          Height:=Titlepanel{Container}.height-4;
          Width:=Height;
          ControlImage.Canvas.Brush.Color:=clBlue;
          ControlImage.Canvas.FillRect(Rect(0,0,ControlImage.ClientWidth,ControlImage.ClientHeight));
          OnClick:=ControlImageClick;
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
    TitleContainer.OnMouseDown:=RichEditClick;
end;

procedure TBaseElement.ElementResize(Sender: TObject);
begin
 Width:=Parent.ClientWidth-10;
 TitlePanel.Width:=Parent.ClientWidth-21;
 TitleContainer.Width:=TitlePanel.Width-TitleH-8;
 ControlImage.Left:=TitleContainer.Width+5;
 //TitleBtn.Left:=TitleContainer.Width+5;
// TitleBtn.Width:=Width-2;
// TitleBtn.Height:=16;
 TextPanel.Width:=Width-4;
 TitleContainer.Color:=clScrollBar;
end;

Destructor TBaseElement.Destroy;
begin
//FreeandNil(PictBitMap);
// PictTitle.Destroy;//Free;
// ReportPicture.Destroy;//Free;
inherited Destroy;
end;

(*procedure TBaseElement.TitleBtnClick(Sender: TObject);
var i:integer;
begin
 ActiveElement:=self;
 if  not TitleBtn.Down then
 begin
  height:=height-TextPanel.Height;
  TextPanel.Height:=0;
  TitleBtn.Font.Color:=clBlack;
  TitleBtn.Caption:='Open';
  ReportForm.height:=ReportForm.height-HElement;
 end
 else
 begin
   TextPanel.Height:=HElement;
   TitleBtn.Font.Color:=clGreen;
   TitleBtn.Caption:='Close';
   height:=height+TextPanel.Height;
   ReportForm.Height:=ReportForm.height+TextPanel.Height;//baseH;
 end;
  ReportForm.Repaint;
end;
*)

procedure TBaseElement.RichEditClick(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 ReportForm.DeActivateAll;
 Activate;
end;
procedure TBaseElement.ControlImageClick(Sender: TObject);
var I:integer;
begin
 for I:=0 to ReportForm. ReportElements.Count-1 do  TBaseElement(reportForm. ReportElements.Items[i]).DeActivate;
// if Assigned(ActiveElement) then ActiveElement.Activate;//TitleContainer.Color:=clScrollBar;
 ActiveElement:=self;
 TitleContainer.Color:=clWindow;
 Activate;
 if  FlgBlockOpened then    // To close Block
 begin
  FlgBlockOpened:=False;
  height:=height-TextPanel.Height;
  TextPanel.Height:=0;
  ControlImage.Canvas.Brush.Color:=clBlue;
  TitlePanel.BevelOuter:=bvRaised;
  ControlImage.Canvas.FillRect(Rect(0,0,ControlImage.ClientWidth,ControlImage.ClientHeight));
  //TitleBtn.Font.Color:=clBlack;
 // TitleBtn.Caption:='Open';
  ReportForm.height:=ReportForm.height-HElement;
 end
 else
 begin                  // To Open Block;

   FlgBlockOpened:=True;
   TextPanel.Height:=HElement;
   ControlImage.Canvas.Brush.Color:=clGreen;
   // BevelInner:=bvNone;
   // BevelWidth:=4;
   TitlePanel.BevelOuter:=bvLowered;
    ControlImage.Canvas.FillRect(Rect(0,0,ControlImage.ClientWidth,ControlImage.ClientHeight));
  // TitleBtn.Font.Color:=clGreen;
  // TitleBtn.Caption:='Close';
   height:=height+TextPanel.Height;
   ReportForm.Height:=ReportForm.height+TextPanel.Height;//baseH;
 end;
end;


//TTextElement=class( TBaseElement)

constructor TTextElement.Create(var AOwner: TComponent; title:string);
begin
inherited create(AOwner, title);
textPanel.Color:= clGreen;
//TitleContainer.Color:=clMoneyGreen;
TextContainer:=TTextContainer.Create(Self);
with TextContainer do
  begin
  Parent:=textPanel;
  Align:=alClient;
  Left:=5;
  Top:=5;
  Width:=Parent.Width-10;
  Height:=Parent.Height-10;
  MaxLength:=0;
  ScrollBars:=ssBoth;
  WordWrap:=False;
  end;
  OnResize:=ElementResize;
end;

//TPicturesElement


constructor TPicturesElement.Create(var AOwner: TComponent; title:string);
begin
inherited create(AOwner, title);
 TextPanel.OnDragOver:= PicturesElementDragOver;
 textpanel.OnDragdrop:= PicturesElementDragDrop;
 PictList:=TList.Create;
 OnResize:=ElementResize;
end;

destructor TPicturesElement.Destroy;
var cnt:integer;
    temppict:Tpict;
begin
    { Cleanup: must free the list items as well as the list }
   for cnt := 0 to (PictList.Count - 1) do
   begin
     //tempPict :=
     TObject(PictList.Items[cnt]).Free;
    // FreeAndNil(tempPict);
   end;
   PictList.Free;
 inherited Destroy;
end;
procedure TTextElement.Activate;
begin
  Color:=clBlue;
end;
procedure TTextElement.DeActivate;
begin
 Color:=clGray;
end;
procedure TPicturesElement.AddPicture;
var TempPict:tpict;
begin
 TempPict:= TPict.Create(TComponent(Self));//(TextPanel));
 TempPict.parent:=TextPanel;
 PictList.Add(TempPict);
//with TempPict do
begin
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
end;
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
          begin
           HElement:=HElement-2*Pict.Height;
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
 Width:=Parent.ClientWidth-10;
 TitlePanel.Width:=Parent.Width-21;
 TitleContainer.Width:=TitlePanel.Width-TitleH-8;
 TextPanel.Width:=Width-4;
 ControlImage.Left:=TitleContainer.Width+5;
 TitleContainer.Color:=clScrollBar;
for i:=0 to PictList.Count-1 do
  begin
      P:=Tpict(PictList.Items[i]) ;
      P.Top:=i*P.Height;
      P.width:=Parent.ClientWidth-Left*2;
      P.PictTitle.Width:=Width-P.PictTitle.Left-4;
  end;
end;
procedure  TPicturesElement.Activate;
begin
 ReportForm.DeActivateAll;
 Color:=clBlue;
end;
(*procedure  TPicturesElement.Activate(sender:TObject);
begin
// ReportForm.DeActivateAll;
 Color:=clBlue;
end;
*)
procedure  TPicturesElement.DeActivate;
var I:integer;
begin
 Color:=clGray;
 for i:=0 to PictList.Count-1 do
  begin
  TPict(PictList.Items[i]).Color:=clBtnFace;
  end;
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
  error(1,'Microsoft Word is not Installed!');
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
  Error(2,'файл не найден');
 end;
end;



procedure TWordReport.insert(info:string; SourceFont:TFont; _center:boolean);
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
var i:integer;
    info:string;
    CursorPosition:integer;
    StrColor:TColor;
begin
{Source.SelStart:=0;
CursorPosition:=0;
for i:=0 to Source.Lines.Count-1 do
 begin
      info:= Source.Lines.Strings[i];
      Source.SelStart:=CursorPosition;
      CursorPosition:=CursorPosition+Length(info);
     MsWord.Selection.Font.Name:=Source.SelAttributes.Name;
     StrColor:=TColor(Source.SelAttributes.Color);
     MsWord.Selection.Font.Color:=StrColor;
     MsWord.Selection.Font.Size:=Source.SelAttributes.Size;
    // MsWord.Selection.Font.Bold:=(fsBold in Source.SelAttributes.Style);
   //  MsWord.Selection.Font.italic:=(fsItalic in Source.SelAttributes.Style);
      MsWord.selection.TypeText(info+#13);
 end;  }
 Source.SelectAll;
 Source.CopyToClipboard;
 {MsWord.selection.}Paste;
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
procedure TWordReport.Save(Name:string);
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

procedure TWordReport.Search(data:string);
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


procedure TWordReport.AddBookMark(BookMark:string);
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
var i:integer;
   ss:string;
   Temp:TBaseElement;
begin
inherited;
 Width:=BaseW;
 PanelReport.Width:=BaseW;
 ss:='Text';
 ElementsN:=4;
 self.top:=100;
 self.left:=Screen.WorkAreaWidth-self.width-5;
 PanelReport.Height:=(BaseH+5)*(ElementsN);
 ReportElements:=TLIst.Create;

 // SetLength(ReportElements,ElementsN);

(*for i:=0 to 2 do
begin
 ReportElements.Add(TTextElement.Create(TComponent(PanelReport),ss));
end;
 ReportElements.Add(TPicturesElement.Create(TComponent(PanelReport),'PICTURES'));

ActiveElement:=ReportElements.Items[0];
for i:=0 to ReportElements.Count -1  do
begin
  TBaseElement(ReportElements.Items[i]).Parent:=PanelReport;
  TBaseElement(ReportElements.Items[i]).Left:=5;
  TBaseElement(ReportElements.Items[i]).top:=5+i*(BaseH);
end;
 {TBaseElement(ReportElements.Items[0]).TitleBtn.Caption:='WORK TITLE';
 TBaseElement(ReportElements.Items[1]).TitleBtn.Caption:='The GOALS of the EXPERIMENT';
 TBaseElement(ReportElements.Items[2]).TitleBtn.Caption:='VERIFICATION QUESTIONS';
 }
*)
  AddTextBlock('Title');
  AddTextBlock('Text');
  AddPictureBlock('Pictures');
 WordReport:=TWordReport.Create;
 WordReport.Run;
end;

procedure TReportForm.FormClose(Sender: TObject;  var Action: TCloseAction);
var i:integer;
begin
 action:=cafree;
 for i:=0 to ReportElements.count-1 do
 TObject(ReportElements.items[i]).Free;
 ReportElements.Free;
 if not ServerisRunning then    WordReport.Quit;
 WordReport.Free;
 ReportForm:=nil;
end;

procedure TReportForm.WordDocument;
var
//W:Variant;
i,j,N:integer;
ss:string;
P:TPict;
{procedure Insert (SourceTextContainer:TMemo; si:string);
begin
W.Font(SourceTextContainer.Font.Name, SourceTextContainer.Font.Size);
        if (fsBold in SourceTextContainer.Font.Style) then
           W.Bold;
        if (fsItalic in (ReportElements[0] as TTextElement).TextContainer.Font.Style) then
        W.Italic;
        W.Insert(si);
end;
}
PROCEDURE InsertText(i:integer);
begin
 WordReport.Insert((TBaseElement(ReportElements.Items[i]).TitleBtn.Caption+#13+#13),Title1Font,false);
 WordReport.InsertText(TTextElement(ReportElements.Items[i]).TextContainer);
 WordReport.Insert((#13+#13),Title2Font,false);
end;

PROCEDURE InsertPictureBlock(i:integer);
var j:integer;
    P:TPict;
begin
// Add the BookMark
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
end;
begin
{W:=CreateOleObject('Word.Basic');
W.AppShow;
W.FileNew;


for i:=0 to (ReportElements[0] as TTextElement).TextContainer.Lines.Count do
  Insert((ReportElements[0] as TTextElement).TextContainer,
               (ReportElements[0] as TTextElement).TextContainer.Lines[i]+ #13);
}
{WordReport:=TWordReport.Create;
WordReport.Run;
WordReport.NewDoc; }

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
 Size:=14;
 Style:=[fsBold];
end;

//for i:=0 to (ReportElements[0] as TTextElement).TextContainer.Lines.Count do
//  WordReport.Insert(((ReportElements[0] as TTextElement).TextContainer.Lines[i]+ #13),
//             Title1Font, True);
if sLanguage='RUS' then ss:='ОТЧЕТ по лабораторной работе   '
                   else ss:='Lab Work REPORT    '  ;
 WordReport.Insert(ss, Title2Font,false);

begin
 ss:='Lab Work Report';
 WordReport.Insert(ss+ #13, Title1Font,false);
 ss:=edName1.Text;
 WordReport.Insert(ss+ #13, Title1Font,false);
 ss:=edName2.Text;
 WordReport.Insert(ss+ #13, Title1Font,false);
 ss:=edGroup.Text;
 WordReport.Insert(ss+ #13+ #13, Title1Font,false);
end;
(* for i:=0 to ReportElements.count-2 do
begin
 WordReport.Insert((TBaseElement(ReportElements.Items[i]).TitleBtn.Caption+#13+#13),Title1Font,false);
 WordReport.InsertText(TTextElement(ReportElements.Items[i]).TextContainer);
 WordReport.Insert((#13+#13),Title2Font,false);
end;

 WordReport.Insert((TBaseElement(ReportElements.items[ReportElements.count-1]).TitleBtn.Caption+#13+#13),Title1Font,false);
// Add the BookMark
 WordReport.AddBookMark('PicturesBookMark');
 WordReport.Insert((#13),Title2Font,false);
 N:=(TBaseElement(ReportElements[ElementsN-1]) as TPicturesElement).PictList.Count;
for i:=N-1 downto 0 do
begin
 P:=(TBaseElement(ReportElements.items[ReportElements.count-1]) as TPicturesElement).PictList.Items[i];
 WordReport.InsertPicture(P);
 WordReport.Search('PicturesBookMark');
 WordReport.Insert((#13),Title2Font,false);
 P:=nil;
end;
*)

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
begin
if Key =vk_Delete then
if not(ActiveControl is  TTextContainer) then
begin
 BitBtnH.SetFocus;
 if assigned(ActivePict) then
for i:=ActivePictureElement.PictList.Count-1 downto 0 do
 begin
 P:= ActivePictureElement.PictList.Items[i];
 if  P.Color=clBlue{Highlight} then
   begin
     ActivePictureElement.DeletePicture(P);
     ActivePict:=nil ;
     P:=nil;
   End;
 end;
 Repaint;
end;
end;
(*
procedure TReportForm.Button1Click(Sender: TObject);
begin
 (TBaseElement(ReportElements.items[ReportElements.count -1])  as TPicturesElement).DeletePicture(ActivePict);
end;
*)


procedure TReportForm.PanelReportResize(Sender: TObject);
//var i:integer;
begin
(*   if assigned(ReportElements) then
    begin
     ReportElements[0].Top:=5;
     for i:= 1 to Length(ReportElements)-1 do
       ReportElements[i].Top:=ReportElements[i-1].Top+ReportElements[i-1].Height+5;
    end;
*)
end;

procedure TReportForm.ClearTemplateFile(LabWorkId:string);
var   F:File;
      iniTempl:TIniFile;
      sFile:string;
      i, N:integer;
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


procedure TReportForm.SaveTemplate(LabWorkId:string);
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
   ClearTemplateFile(LabWorkId)
   else exit;

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

procedure TReportForm.WriteTextSection(iniFile:TIniFile; BlockNmb:integer );
var  iniTempl:TIniFile;
     SectionName:string;
     P:TTextElement;
     i:integer;
begin

 SectionName:='T'+intToStr(BlockNmb);
 P:= TBaseElement(ReportElements.items[BlockNmb]) as TTextElement;

  with iniFile do
  begin
   WriteString(SectionName,'BlockTitle',P.TitleBtn.Caption);
   WriteInteger(SectionName,'StringsNmb',P.TextContainer.Lines.Count);
   for i:=0 to P.TextContainer.Lines.Count-1 do
     begin
       WriteString(SectionName,'Str'+intToStr(i), P.TextContainer.Lines[i]);
     end;
  end;

end;

procedure TReportForm.WritePictureSection (iniFile:TIniFile; BlockNmb:integer );
var  iniTempl:TIniFile;
     SectionName:string;
     P:TPicturesElement;
     i:integer;
begin

 SectionName:='P'+intToStr(BlockNmb);
 P:= TBaseElement(ReportElements.items[BlockNmb]) as TPicturesElement;

   with iniFile do
     begin
       WriteString(SectionName,'BlockTitle',P.TitleBtn.Caption);
      end;
 end;

(*procedure TReportForm.SaveTemplate(LabWorkId:string; TitleStrNmb, GoalsNmb, QuestionsNmb :integer;
                                   Title, Goals, Questions:TTextContainer);
var   F:File;
    iniTempl:TIniFile;
    sFile:string;
     i:integer;
begin

 sFile:=ReportTemplPath + ReportTemplFile;
if (not FileExists(sFile)) then
  begin
    AssignFile(F,sFile);
    ReWrite(F);
    CloseFile(F);
  end;
//try
//  SetFileAttribute_ReadOnly(sfile,false);
  ClearTemplateFile(LabWorkId);
  iniTempl:=TIniFile.Create(sFile);
 try
  with iniTempl do
  begin
       WriteInteger(LabWorkId, 'TitleStrNmb', TitleStrNmb);
   for i:=1 to TitleStrNmb do WriteString(LabWorkId, 'WorkTitle'+IntToStr(i), Title.Lines[i-1]);
       WriteInteger(LabWorkId, 'GoalsNmb', GoalsNmb);
   for i:=1 to GoalsNmb do writeString(LabWorkId, 'WorkGoals'+IntToStr(i), Goals.Lines[i-1]);
       WriteInteger(LabWorkId, 'QuestionsNmb', QuestionsNmb);
   for i:=1 to QuestionsNmb do WriteString(LabWorkId, 'Questions'+IntToStr(i), Questions.Lines[i-1]);
  end;
 finally
  IniTempl.Free;
 end;
end; {SaveTemplate}

*)
procedure TReportForm.DeActivateAll;
var i:integer;
begin
 for i:=0 to ReportForm. ReportElements.Count-1 do
  TBaseElement(ReportForm. ReportElements.Items[i]).DeActivate;
end;


procedure TReportForm.ReadTemplate(ReportFile :string);
var SFile:string;
    iniTemp:TiniFile;
    TitleStrNmb, goalsNmb, QuestionsNmb, i,j:integer;
    ss:string;
    SectionsList:TStrings;
    NSections, StrNmb:integer;
    SectionName, BlockTitle:string;
    P:TTextElement;
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
               BlockTitle:=ReadString(SectionName,'BlockTitle', 'text');
               AddTextBlock(BlockTitle);
               StrNmb:= ReadInteger(SectionName, 'StringsNmb', 0);
               for j:=0 to StrNmb-1 do
                 begin
                    ss:= ReadString(SectionName, 'Str'+IntToStr(j), IntToStr(j));
                    if  ReportElements.Count>i  then
                    begin
                      P:= TBaseElement(ReportElements.items[i]) as TTextElement;
                      P.TextContainer.Lines.Add(ss);
                    end;
                 end;
             end else
             begin
               BlockTitle:=ReadString(SectionName,'BlockTitle', 'PICTURES');
               AddPictureBlock(BlockTitle);
             end;
       end;
    end;
  finally
   iniTemp.Free;
   SectionsList.Free;
  end;
 end;
end;   {ReadTemplate}

Procedure TPicturesElement.PicturesElementDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 BringWindowToTop(ReportForm.handle);
 Accept:=(Source is TPanel) or (Source is TStringGrid) or (Source is TChart) or
 FlgImgAnalysDrag;
end;

Procedure TPicturesElement.PicturesElementDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
 AddPicture;
end;

procedure TReportForm.FormResize(Sender: TObject);
var h,i:integer;
begin
PanelReport.Width:=ClientWidth;
if Assigned(ReportElements) then
begin
  if ReportElements.Count>=1 then
  begin
     H:=TBaseElement(ReportElements.items[0]).height+5;
     TBaseElement(ReportElements.items[0]).Top:=5;
     TBaseElement(ReportElements.items[0]).width:=ClientWidth-10;
  for i:=1 to ReportElements.Count -1  do
     begin
        TBaseElement(ReportElements.items[i]).width:=ClientWidth-10;
        H:=H+TBaseElement(ReportElements.items[i]).height+8;  //16
        TBaseElement(ReportElements.Items[i]).Top:= TBaseElement(ReportElements.Items[i-1]).Top+
                                                    TBaseElement(ReportElements.items[i-1]).Height+5;

     end;
   PanelReport.Height:=H;
   Height:=H+PanelTop.Height+35; //???
    for i:=1 to ReportElements.Count -1  do
     begin
      end;
   end;
end;
end;

procedure TReportForm.FormPaint(Sender: TObject);
var h,i:integer;
begin
(* if (ReportElements.Count>1) then
    begin
     H:=TBaseElement(ReportElements.items[0]).height+5;
     TBaseElement(ReportElements.items[0]).width:=ClientWidth-10;
     TBaseElement(ReportElements.items[0]).Top:=5;
      for i:= 1 to ReportElements.Count-1 do
       TBaseElement(ReportElements.Items[i]).Top:= TBaseElement(ReportElements.Items[i-1]).Top+
                                                   TBaseElement(ReportElements.items[i-1]).Height+5;
    end;
 *)
end;



procedure SetFont(TextContainer:TTextContainer; {FontName:TFontName;} FontColor:TColor; FontStyle:TFontStyles; FontSize:integer );
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
if SaveDialog.Execute then WordReport.Save(SaveDialog.FileName);
 WordReport.Close;
end;
procedure TReportForm.TextContainerClick(Sender: TObject);
begin
AddTextBlock('text');
(*var element: TTextElement;
begin
 element:=TTextElement.Create(TComponent(PanelReport),'text');
  ReportElements.Add(Element);
  Element.Parent:=PanelReport;
  Element.Left:=5;
  Element.top:=5+ReportElements.count*BaseH;
 *)
   ActiveElement.SetFocus;
   Resize;
end;

procedure TReportForm.PictureContainerClick(Sender: TObject);
begin
AddPictureBlock('PICTURES');
(*var
  element:TPicturesElement;
begin
  element:=TPicturesElement.Create(TComponent(PanelReport),'PICTURES');
  ReportElements.Add(Element);
  Element.Parent:=PanelReport;
  Element.Left:=5;
  Element.top:=5+ReportElements.count*BaseH;
*)
  ActiveElement.SetFocus;
  Resize;
end;

procedure TReportForm.AddTextBlock(Title:string);
var element: TTextElement;
    i:integer;
begin
 if  ReportElements.Count>0 then
    for i:=0 to ReportElements.Count -1  do
     begin
        TTextElement(ReportElements.items[i]).DeActivate;
     end;
  element:=TTextElement.Create(TComponent(PanelReport),Title);
  ActiveElement:=element;
  ReportElements.Add(Element);
  Element.Parent:=PanelReport;
  Element.Left:=5;
  Element.top:=5+ReportElements.count*BaseH;
  Element.TitleContainer.Lines.Add(Title);
end;

procedure TReportForm.AddPictureBlock(Title:string);
var
  element:TPicturesElement;
    i:integer;
begin
 if  ReportElements.Count>0 then
    for i:=0 to ReportElements.Count -1  do
     begin
        TPicturesElement(ReportElements.items[i]).DeActivate;
     end;
  element:=TPicturesElement.Create(TComponent(PanelReport),Title);
  ActiveElement:=element;
  ReportElements.Add(Element);
  Element.Parent:=PanelReport;
  Element.Left:=5;
  Element.top:=5+ReportElements.count*BaseH;
  Element.TitleContainer.Lines.Add(Title);
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
//  if ReportElements.count>0 then
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
   ReSize;

  if ReportElements.count>0 then
  begin
     ActiveElement:=ReportElements.items[ReportElements.count-1];
     ActiveElement.Activate;
  end;   
(*    if (n= ReportElements.count) and (n<>0) then
    ActiveElement:=ReportElements.items[n-1]
    else
     begin
       if  ReportElements.count>0 then
       ActiveElement:=ReportElements.items[n]
       else ActiveElement:=nil;
     end;
  *)
  end;
end;



procedure TReportForm.BitBtn1Click(Sender: TObject);
begin
FormLabWorkId:=TFormLabWorkId.Create(Application);
FormLabWorkId.ShowModal;
SaveTemplate(LabWorkIdentificator);
end;

procedure TReportForm.BitBtn2Click(Sender: TObject);
var WorkId:string;
begin
FormLabDlg:=TFormLabDlg.Create(Application);
FormLabDlg.ShowModal;
CutExtention(ReportTemplFile, WorkId );
LabelWorkId.Caption:=WorkId;
ReadTemplate(ReportTemplFile);
end;

procedure TReportForm.CutExtention(InName:string ; var OutName:string);
var
  name, ext:string;
  newName:string;
  i,L:integer;
begin
  name:=ExtractFileName(InName);
ext:=ExtractFileExt(inName);
L:= Length(ext);
L:=Length(name)-L;
SetLength(NewName,L);
for i:=1 to L do
  NewName[i]:=name[i];
OutName:=NewName;
end;
end.
