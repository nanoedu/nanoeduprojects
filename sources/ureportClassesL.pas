//150705
unit UReportClasses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, buttons, stdctrls, clipbrd, comObj, ActiveX, grids,  chart, globalvar,
  iniFiles, comctrls, OpenGLDraw, OleServer, WordXP, Menus;

const BaseH=200;
      BaseW=720;

      wdRow=           $0000000A;   // Table Row
      wdColumn=        $00000009;   // Table  Column
      wdCell=          $0000000C;   // Table  Cell
      wdTable=         $0000000F;   // Table
      wdParagraph=     $00000004;
      wdCollapseEnd=   $00000000;  // New obgect is at the end of Fragment
      wdCollapseStart= $00000001;  // New obgect is at the begin of Fragment
      wdWord=          $00000002;
      wdSaveChanges=   $FFFFFFFF;   // SaveChanges in Document
      wdPromptUser=    $00000002;  // Dialod Window Save as
//  WordXP.pas

const ReportTemplFile='RepTemp.tmpl';

type WordArray2D=array of array of word;

type TBaseElement=class(TPanel)
   TitleBtn:TSpeedButton;
   TextPanel:TPanel;
  protected
    HElement:integer;
  public
     Position:Integer;
     constructor Create(var AOwner: TComponent; title:string);
     destructor Destroy;
     procedure TitleBtnClick(Sender: TObject);
     procedure ElementResize(Sender: TObject);
end;

type TTextContainer=TRichEdit;//TMemo;

type TTextElement=class( TBaseElement)
  TextContainer:TTextContainer;
  constructor Create(var AOwner: TComponent; title:string);
 // destructor Destroy; override;
end;

type TPict=class(TPanel)
 private
  PictBitMap:tBitMap;
  ComprBitMap:TBitMap;
  BufBitMap:TBitMap;
  procedure Compr8bitBMP(K,L:integer);
  procedure Compr24bitBMP(K:integer);
  procedure ComprPicture(BMPFormat:integer; ComprCoef:integer; SmoothArea:integer);
  function  Convolute2D(iy,ix:integer; Data:WordArray2D; FieldSize:integer):integer;
  procedure MakePalette(BitMap: TBitMap);
 public
  ReportPicture:tImage;
  PictTitle:TTextContainer;
  constructor Create(var AOwner: TComponent);
  Destructor Destroy; override;
  procedure  ConvertBMPTo8Bit(tobmp: TBitmap; frbmp : TGraphic);
  procedure  ReportPictureMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
end;

type TPicturesElement=class( TBaseElement)
private
  TestPicture:TPict;
  PictList:TList;
 procedure AddTestPicture;
 procedure DeleteTestPicture;
 procedure AddPicture;
 procedure DeletePicture(Pict:TPict);
 procedure RepaintPictureList;
 procedure ElementResize(sender:TObject);
 procedure PicturesElementDragOver(Sender, Source: TObject; X,  Y: Integer; State: TDragState; var Accept: Boolean);
 Procedure PicturesElementDragDrop(Sender, Source: TObject; X,  Y: Integer);

public
 constructor Create(var AOwner: TComponent; title:string);
 destructor Destroy;// override;
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
    cbLabNmb: TComboBox;
    Label1: TLabel;
    PanelUp: TPanel;
    GroupBox1: TGroupBox;
    BitBtnOpenDoc: TBitBtn;
    BitBtnPrint: TBitBtn;
    BitBtnSave: TBitBtn;
    Button1: TButton;
    BitBtnH: TBitBtn;
    RadioGroup1: TRadioGroup;
    GroupBox2: TGroupBox;
    EdName2: TEdit;
    Label2: TLabel;
    EdName1: TEdit;
    Label3: TLabel;
    EdGroup: TEdit;
    GroupBox3: TGroupBox;
    BitBtn1: TBitBtn;
    PopupMenuAdd: TPopupMenu;
    Title: TMenuItem;
    TextContainer: TMenuItem;
    PictureContainer: TMenuItem;
    BitBtn2: TBitBtn;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;   Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure PanelReportResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbLabNmbChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure BitBtnOpenDocClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);

  private
     Title1Font, Title2Font :TFont;
     WordReport:TWordReport;
     VisibleDocument:Boolean;
     procedure WordDocument;
    { Private declarations }
  public
    { Public declarations }
    ReportElements:TList;

    procedure ClearTemplateFile(LabWorkId:string);
    procedure SaveTemplate(LabWorkId:string; TitleStrNmb, GoalsNmb, QuestionsNmb :integer;
                             Title, Goals, Questions:TTextContainer);
    procedure ReadTemplate( LabWorkId:string; Title, Goals, Questions:TTextContainer);
  end;


var
  ReportForm: TReportForm;
  ElementsN:integer;
  ServerIsRunning:Boolean;

procedure SetFont(TextContainer:TTextContainer; {FontName:TFontName;} FontColor:TColor; FontStyle:TFontStyles; FontSize:integer );

implementation

{$R *.dfm}

var
  ActivePict:TPict;

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

 // ComprPicture(BMPFormat,ComprKoef, SmoothArea);
 // ReportPicture.Picture.Bitmap.Assign(ComprBitMap);

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
//FreeandNil(PictBitMap);
// PictTitle.Destroy;//Free;
// ReportPicture.Destroy;//Free;
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
//comprBitMap.Palette:=(BufBitMap.Palette);
//SetLength( BufImage,PictBitMap.Height,PictBitMap.Width);
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

procedure TPict.ReportPictureMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
if Button=(mbLeft) then
begin
// Self.SetFocus;
 Self.Color:=clHighlight;
 ActivePict:=Self;
end;
end;

//TBaseElement
constructor TBaseElement.Create(var AOwner: TComponent ; title:string);
begin
   inherited Create(AOwner);
//    Position:=ElementPos;
    Self.Width:=BaseW-4;
    HElement:=BaseH;
    TitleBtn:=TSpeedButton.Create(Self);
    with   TitleBtn do
    begin
      Parent:=self;
      allowAllUp:=True;
      Left:=1;
      Top:=1;
      Width:=Parent.Width-26;
      Height:=18;
      Caption:=title;
      GroupIndex:=1;
      OnClick:=TitleBtnClick;
      Down:=false;
    end;
     Self.Height:=TitleBtn.height;
     TextPanel:=TPanel.Create(Self);
     with TextPanel do
     begin
      Parent:=self;
      Left:=0;
      Top:= TitleBtn.Top+TitleBtn.Height+2;
      Width:=Parent.Width;
      Height:=BaseH-Top-2;
      color:=clSkyBlue;
     end;
     OnResize:=ElementResize;
end;

Destructor TBaseElement.Destroy;
begin
//FreeandNil(PictBitMap);
// PictTitle.Destroy;//Free;
// ReportPicture.Destroy;//Free;
inherited Destroy;
end;

procedure TBaseElement.TitleBtnClick(Sender: TObject);
var i:integer;
begin
 if  not TitleBtn.Down then
 begin
//  ReportForm.height:=ReportForm.height-TextPanel.Height;
  height:=height-TextPanel.Height;
  TextPanel.Height:=0;
  TitleBtn.Font.Color:=clBlack;
  ReportForm.height:=ReportForm.height-HElement;
 end
 else
 begin
   TextPanel.Height:=HElement;
   TitleBtn.Font.Color:=clGreen;
   height:=height+TextPanel.Height;
   ReportForm.Height:=ReportForm.height+TextPanel.Height;//baseH;
 end;
  ReportForm.Repaint;
end;

procedure TBaseElement.ElementResize(Sender: TObject);
begin
 Width:=Parent.ClientWidth-10;
 TitleBtn.Width:=Width-2;
 TitleBtn.Height:=16;
 TextPanel.Width:=Width-4;
end;

//TTextElement=class( TBaseElement)

constructor TTextElement.Create(var AOwner: TComponent; title:string);
begin
inherited create(AOwner, title);
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
     Height:=TextPanel.Height+TitleBtn.Height;
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
   P:=(PictList.Items[i]) ;
   if P=Pict then
      begin
         if  TextPanel.Height>BaseH then
          begin
           HElement:=HElement-2*Pict.Height;
           TextPanel.Height:=HElement;
           Height:=TextPanel.Height+TitleBtn.Height;
           ReportForm.Resize;
          end;
          FreeAndNil(Pict);
          PictList.Delete(i);
          RepaintPictureList
      end;
 end;
end;


procedure TPicturesElement.AddTestPicture;
begin
 TestPicture:= TPict.Create(TComponent(Self));//(TextPanel));
 TestPicture.Parent:=TextPanel;
with TestPicture do
begin
 PictBitMap:=tBitMap.Create;
try
 PictBitMap.Assign(ClipBoard);
 Top:=0;
 Width:=Parent.ClientWidth-Left*2;
 Height:=40;
 PictTitle.Width:=ClientWidth-PictTitle.Left-4;
finally
 FreeAndNil(PictBitMap);
end;
end;
end;

procedure TPicturesElement.DeleteTestPicture;
begin
 TestPicture.Destroy;
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
 TitleBtn.Width:=Width-2;
 TitleBtn.Height:=16;
 TextPanel.Width:=Width-4;
for i:=0 to PictList.Count-1 do
  begin
      P:=Tpict(PictList.Items[i]) ;
      P.Top:=i*P.Height;
      P.width:=Parent.ClientWidth-Left*2;
      P.PictTitle.Width:=Width-P.PictTitle.Left-4;
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
 PanelReport.Height:=BaseH*(ElementsN);
 ReportElements:=TLIst.Create;
// SetLength(ReportElements,ElementsN);

for i:=0 to 2 do
begin
 ReportElements.Add(TTextElement.Create(TComponent(PanelReport),ss));
end;
 ReportElements.Add(TPicturesElement.Create(TComponent(PanelReport),'PICTURES'));

for i:=0 to ReportElements.Count -1  do
begin
  TBaseElement(ReportElements.Items[i]).Parent:=PanelReport;
  TBaseElement(ReportElements.Items[i]).Left:=5;
  TBaseElement(ReportElements.Items[i]).top:=5+i*BaseH;
end;
 TBaseElement(ReportElements.Items[0]).TitleBtn.Caption:='WORK TITLE';
 TBaseElement(ReportElements.Items[1]).TitleBtn.Caption:='The GOALS of the EXPERIMENT';
 TBaseElement(ReportElements.Items[2]).TitleBtn.Caption:='VERIFICATION QUESTIONS';
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
 ss:=cbLabNmb.Text;
if ss<>'None' then
begin
 WordReport.Insert(ss+ #13, Title1Font,false);
 ss:=edName1.Text;
 WordReport.Insert(ss+ #13, Title1Font,false);
 ss:=edName2.Text;
 WordReport.Insert(ss+ #13, Title1Font,false);
 ss:=edGroup.Text;
 WordReport.Insert(ss+ #13+ #13, Title1Font,false);
end;
for i:=0 to ReportElements.count-2 do
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
end;


procedure TReportForm.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
if  Key =vk_Delete then
begin
 Button1.SetFocus;
(TBaseElement(ReportElements.items[ReportElements.count -1]) as TPicturesElement).DeletePicture(ActivePict);
 Repaint;
end;
end;

procedure TReportForm.Button1Click(Sender: TObject);
begin
 (TBaseElement(ReportElements.items[ReportElements.count -1])  as TPicturesElement).DeletePicture(ActivePict);
end;


procedure TReportForm.FormPaint(Sender: TObject);
var i:integer;
begin
 if (ReportElements.Count>1) then
    begin
     TBaseElement(ReportElements.items[0]).Top:=5;
      for i:= 1 to ReportElements.Count-1 do
       TBaseElement(ReportElements.Items[i]).Top:= TBaseElement(ReportElements.Items[i-1]).Top
        + TBaseElement(ReportElements.items[i-1]).Height+5;
    end;
end;

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
begin
 sFile:=exeFilePath + ReportTemplFile;
 if (not FileExists(sFile)) then  exit
                            else  iniTempl:=TIniFile.Create(sFile);
  try
   with iniTempl do
   begin
     N:= readInteger(LabWorkId, 'TitleStrNmb',0 );
     for i:=1 to N do DeleteKey(LabWorkId,'TitleStrNmb'+IntToStr(i));

     N:= readInteger(LabWorkId, 'GoalsNmb',0 );
     for i:=1 to N do DeleteKey(LabWorkId,'GoalsNmb'+IntToStr(i));

     N:= readInteger(LabWorkId, 'QuestionsNmb',0 );
     for i:=1 to N do  DeleteKey(LabWorkId,'QuestionsNmb'+IntToStr(i));
   end;
  finally
   IniTempl.Free;
  end;
end;


procedure TReportForm.SaveTemplate(LabWorkId:string; TitleStrNmb, GoalsNmb, QuestionsNmb :integer;
                                   Title, Goals, Questions:TTextContainer);
var   F:File;
    iniTempl:TIniFile;
    sFile:string;
     i:integer;
begin
 sFile:=exeFilePath + ReportTemplFile;
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


procedure TReportForm.ReadTemplate( LabWorkId:string; Title, Goals, Questions:TTextContainer);
var SFile:string;
    iniTemp:TiniFile;
    TitleStrNmb, goalsNmb, QuestionsNmb, i:integer;
    ss:string;
begin
sFile:=exeFilePath+ ReportTemplFile;
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

      TitleStrNmb:= ReadInteger(LabWorkId, 'TitleStrNmb', 0);
       for i:=1 to TitleStrNmb do
       begin
       ss:= ReadString(LabWorkId, 'WorkTitle'+IntToStr(i), IntToStr(i));
       Title.Lines.Add(ss);
       end;

       GoalsNmb:=readInteger(LabWorkId, 'GoalsNmb',0 );
       for i:=1 to GoalsNmb do
       begin
       ss:= ReadString(LabWorkId, 'WorkGoals'+IntToStr(i), IntToStr(i));
       Goals.Lines.Add(ss);
       end;
       QuestionsNmb:=ReadInteger(LabWorkId, 'QuestionsNmb',0 );
       for i:=1 to QuestionsNmb do
       begin
       ss:=ReadString(LabWorkId, 'Questions'+IntToStr(i), IntToStr(i));
       SetFont( Questions, clRed, [fsBold], 10);
       Questions.Lines.Add(ss);
        SetFont( Questions, clBlack,[ ], 8);
        Questions.Lines.Add('');
       end;
      // Questions.SelAttributes.Assign(Questions.DefAttributes);

    end;
  finally
   iniTemp.Free;
  end;
 end;
end;   {ReadTemplate}

Procedure TPicturesElement.PicturesElementDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 Accept:=(Source is TImage) or (Source is TStringGrid) or (Source is TChart) or
 FlgImgAnalysDrag;
end;

Procedure TPicturesElement.PicturesElementDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
 AddPicture;
 if Source is TImage then (Source as TImage).Visible:=False;
end;

procedure TReportForm.FormResize(Sender: TObject);
var h,i:integer;
begin
if Assigned(ReportElements) then
begin
  H:=0;
  for i:=0 to ReportElements.Count -1  do

     begin
        TBaseElement(ReportElements.items[i]).width:=ClientWidth-10;
        H:=H+TBaseElement(ReportElements.items[i]).height+16
     end;
   self.height:=H+PanelTop.Height;
end;
end;

procedure TReportForm.FormShow(Sender: TObject);
var I,H:integer;
begin
(*H:=0;
for i:=0 to Length(ReportElements) -1  do
begin
  H:=H+ReportElements[i].height+14;
end;
 self.height:=H+PanelTop.Height;
*)
end;

procedure TReportForm.cbLabNmbChange(Sender: TObject);
var
 LabWorkId:string;
 TitleMem, GoalsMem, QuestionsMem:TTextContainer;
begin

 TitleMem:=(TBaseElement(ReportElements.items[0]) as TTextElement).TextContainer;
 GoalsMem:=(TBaseElement(ReportElements.items[1]) as TTextElement).TextContainer;
 QuestionsMem:=(TBaseElement(ReportElements.items[2]) as TTextElement).TextContainer;

 TitleMem.Lines.Clear;
 GoalsMem.Lines.Clear;
 QuestionsMem.Lines.Clear;

if cbLabNmb.Text<>'None' then
begin
LabWorkId:=cbLabNmb.Text;
if sLanguage='RUS' then  LabWorkId:=LabWorkId+'R'
                   else LabWorkId:=LabWorkId+'E';
 ReadTemplate( LabWorkId, TitleMem, GoalsMem, QuestionsMem);
end;
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

procedure TReportForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if assigned(ActiveGLW) then ActiveGLW.Image1.Visible:=False;
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
end.
