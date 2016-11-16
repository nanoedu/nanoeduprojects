unit frRenishawNomogram;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, GlobalType,GlobalScanDataType, GlobalDcl,
  StdCtrls, AppEvnts;

type
TDataS=class
private

protected

public
m: array of array of smallint;
NX,NY: integer;
//min,max: double;
 function max :double;
 function min : double;
 function mean :double;
constructor Create;
destructor Destroy;
published

end;


type
  TFormRenishNomogram = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Chart1: TChart;
    Series1: TLineSeries;
    Label1: TLabel;
    Label2: TLabel;
    ApplicationEvents1: TApplicationEvents;
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
   // procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Scan, ScanImg:TDataS;
    BitMap:TBitMap;
    procedure  CopyToClipboard;
  public
    constructor Create(AOwner: TComponent; FastAxisDAC:TData; SlowAxisDAC:TLine;
                       Mode:integer; flgOneLineScan:boolean);
  end;


procedure MakePalette(BitMap: TBitMap);
procedure Drawdata(out BitMap: TBitMap; Dat:TdataS);

var
  FormRenishNomogram: TFormRenishNomogram;
  Dat: TDataS;
  hpal : HPALETTE;


implementation
uses  ClipBrd,Globalvar,CSPMVar,mMain, Math, frReport;
 {$R *.DFM}

 function TDataS.max : double;
 var
 i,j:integer;
 a: double;
  begin
  a:=MinDATATYPE;
  for i:=0 to NY-1 do
  for j:=0 to NX-1 do
  if m[i,j]>a then
    a:= m[i,j];
    max:=a;
   end;

 function TDataS.min: double;
 var
 i,j:integer;
 a:double;
 begin
  a:=MaxDATATYPE;
  for i:=0 to NY-1 do
  for j:=0 to NX-1 do
  if m[i,j]<a then
    a:=m[i,j];
    min:=a;
  end;

  function TDataS.mean : double;
  var i,j:integer;
  S:double;
  begin
  for i:=0 to NY-1 do
  for j:=0 to NX-1 do
  S:=S+m[i,j];

  S:=S/NX/NY;
  mean:=S;

  end;

  constructor TDataS.Create;
  begin
  NX:=0;
  NY:=0;
  SetLength(m,NY,NX);
  end;

  destructor TDataS.Destroy;
  begin
  NX:=0;
  NY:=0;
  finalize(m);
  end;

 procedure MakePalette(BitMap: TBitMap);
var i : Integer;
    pal : PLogPalette;
 //   hpal : HPALETTE;
begin
  pal := nil;
  GetMem(pal, sizeof(TLogPalette) + sizeof(TPaletteEntry) * 255);
  try
  begin
    pal.palVersion := $300;
    pal.palNumEntries := 256;
    for i := 0 to 255 do
    begin
      pal.palPalEntry[i].peRed := i;
      pal.palPalEntry[i].peGreen := i;
      pal.palPalEntry[i].peBlue := i;
      pal^.palPalEntry[i].peFlags := pc_nocollapse;
    end;
    if hPal<>0 then
    DeleteObject(hPal);
    hpal := CreatePalette(pal^);
  //  HandleNeeded;
  //  hpal := CreateHalftonePalette(Handle);
    if hpal <> 0 then
       BitMap.Palette := hpal; // Это место где созданная палитра присваиваеться Bitmap.
                             // Если писать без классов то надо писать так Bitmap.Palette:=hpal
  end
  finally
    FreeMem(pal);
  end;
end;


procedure DrawData(out BitMap: TBitMap; Dat:TDataS);
var //BitMap: TBitMap;
    GreyEntr: integer;
    Dmin, Dmax:real;
    zscale: real;
    x,y: Integer;
    P:PByteArray;
    LHeight,LWidth: Integer;
    PointColor:integer;
begin
       BitMap:=TBitMap.Create;
       //PixelFormat:=pf8bit; // Это установка формата пиксела 8 бит на точку
        BitMap.PixelFormat:=pf8bit ;
       //BitMap.Palette:=CopyPalette(Palette);
       BitMap.Height:=Dat.NY;
       BitMap.Width:=Dat.NX;
       LHeight:=Dat.NY;
       LWidth:=Dat.NX;
       GreyEntr:=255;
       Dmin:=Dat.Min;
       Dmax:=Dat.Max;
       if (Dmax-Dmin)<>0 then
       zscale:= GreyEntr/(Dmax-Dmin)
       else
       zscale:=1;


       MakePalette(BitMap);
       for y:=0 to LHeight-1 do
       begin
            P:=BitMap.ScanLine[y];
            for x:=0 to LWidth-1 do
            begin
                 PointColor:=round(zscale*(Dat.m[y,x]-Dmin));
                 if (PointColor >255) then PointColor:=255 ;
                 if (PointColor <0)   then   PointColor:=0 ;
                 P[x]:=PointColor;
            end;
       end;


  
    (*  for y:=0 to LHeight-1 do
      for x:=0 to LWidth-1 do
      begin
      PointColor:=round(zscale*(Dat.m[y,x]-Dmin));
                 if (PointColor >255) then PointColor:=255 ;
                 if (PointColor <0)   then   PointColor:=0 ;
     // BitMap.Canvas.Pixels[x,{Height-1-}y]:=
      //  Round(zscale*(Dat.m[y,x]-Dmin))*$00010101;

      Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                             or ((PointColor ) shl 8) or ((PointColor div 2) shl 16) );
      Bitmap.Canvas.FillRect(Rect(x,y,x+1,y+1));


      end;  *)
end; {DrawData}


//procedure TFormReniShDiagn.FormCreate(Sender: TObject);
constructor TFormRenishNomogram.Create(AOwner: TComponent; FastAxisDAC:TData;
                                       SlowAxisDAC:TLine; Mode:integer;  flgOneLineScan:boolean);
var i,j, k,s:integer;
  LineWidth:integer;
  yStretch, xStretch:integer;
  absMin, absMax, tmp:integer;
  scaleX, scaleY, scal:single;
  H,W,SlowDataLen:integer;
  CurrentPos:integer;
  cripValuediscr:integer;
  DFastdiscr, DSlowdiscr:integer;
  DreifAngle, DreifAngleTang:single;
  ScaleKoeff:single;
  MaxValidImgSize:integer;
begin
inherited Create(AOwner);
  with Panel1 do
    begin
      Left:=0;
      Top:=0;
    end;
   with Panel2 do
    begin
      Left:=0;
      Top:=Panel1.Height+3;
    end;
    MaxValidImgSize:=5000;
    SlowDataLen:=length( SlowAxisDAC);
    absMin:=MaxDATATYPE;
    absMax:=MinDATATYPE;
     for j:=0 to FastAxisDAC.Nx-1do
       for i:=0 to FastAxisDAC.Ny-1 do
       begin
         tmp:=abs(FastAxisDAC.data[j,i]);
        if  (tmp<absMin) then absMin:=tmp;
        if  (tmp>absMax) then absMax:=tmp;
       end;
  cripValuediscr:= abs(FastAxisDAC.data[0,0])-absMin;
  label1.caption:= 'Crip value = '+ IntTostr(cripValuediscr) + ' discr;' ;

  ScaleKoeff:=1;
  if absMax>MaxValidImgSize then
   begin
        ScaleKoeff:=absMax/MaxValidImgSize;
        absMin:= round(absMin/ScaleKoeff);
        absMax:= round(absMax/ScaleKoeff);
        for j:=0 to FastAxisDAC.Nx-1do
       for i:=0 to FastAxisDAC.Ny-1 do
                FastAxisDAC.data[j,i]:=round((FastAxisDAC.data[j,i])/ScaleKoeff);
       for j:=0 to SlowDataLen-1 do
         SlowAxisDAC[j]:= round(SlowAxisDAC[j]/ScaleKoeff);
   end;

  LineWidth:=1;
  Scan:=TDataS.Create;
  Scanimg:=TDataS.Create;
  if Mode=0 then  // Mode X+
  begin
    Scan.NX:=absMax+40; //ExperimData.DataMax +40;
    Scan.NY:=FastAxisDAC.Ny;
    SetLength(Scan.m, Scan.Ny,Scan.Nx);
   for i:=0 to Scan.NY-1 do
   begin
      k:=0;
     for j:=  0 to Scan.NX-1 do
       begin
         if j< abs(FastAxisDAC.data[k,i])  then
               Scan.m[i,j]:=0
          else
            begin
               if  (FastAxisDAC.data[k,i]>0) then
                  Scan.m[i,j]:=1
                else Scan.m[i,j]:=-1;
               k:=k+1;
            end;
          if (k>= FastAxisDAC.Nx) then break;
        end;
    end;

  ScanImg.NX:=Scan.NX-absMin+1 ;//div 5 ;
  if  flgOneLineScan then
     begin
         yStretch:=400 div Scan.NY;
         ScanImg.NY:=yStretch*Scan.NY;
     end
  else
  ScanImg.NY:= abs(abs(SlowAxisDAC[SlowDataLen-1])- abs(SlowAxisDAC[0]))+
                    abs(SlowAxisDAC[SlowDataLen-1])-abs(SlowAxisDAC[SlowDataLen-2])+20;;
 // Image1.Width:=ScanImg.NX;
 // Image1.Height:=ScanImg.NY;

  if ScanImg.NX > (Main.ClientWidth-200) then
    begin
      LineWidth:= ScanImg.NX div (Main.ClientWidth-200);
      ScanImg.NX:=ScanImg.NX+LineWidth;
    end;
    SetLength(Scanimg.m, ScanImg.Ny,ScanImg.Nx);
    CurrentPos:=0;
  for i:=0 to Scan.NY-1 do
   begin
    if  (not flgOneLineScan) and (i< Scan.NY-1) then
          yStretch:=abs(SlowAxisDAC[i+1])- abs(SlowAxisDAC[i]);

     for j:=  0 to Scan.NX-1 do
          if Scan.m[i,j]<>0 then
              begin
                for s:=0 to  LineWidth do
                 for k:=0 to  yStretch-1 do
                  Scanimg.m[ScanImg.Ny-1-(CurrentPos+k), j-absMin+1+s {div 5}]:=Scan.m[i,j];   // 1 or -1
              end ;
      CurrentPos:=CurrentPos+ yStretch;
   end;
    Chart1.BottomAxis.SetMinMax(absMin*ScaleKoeff-100,absMax*ScaleKoeff+100);
    //Chart1.LeftAxis.SetMinMax(1,Scan.NY);
    if flgOneLineScan then
      begin
        Chart1.LeftAxis.SetMinMax(1,Scan.NY);
        Chart1.LeftAxis.Title.Caption:='Line number';
      end
      else
      begin
         Chart1.LeftAxis.SetMinMax(abs(SlowAxisDAC[0]*ScaleKoeff)-100,abs(SlowAxisDAC[SlowDataLen-1]*ScaleKoeff)+100);
         Chart1.LeftAxis.Title.Caption:='DAC Y, discrets';//'Line number';
      end;

    Chart1.BottomAxis.Title.Caption:='DAC X, discrets';


    DFastdiscr:= abs(FastAxisDAC.data[FastAxisDAC.Nx-1, FastAxisDAC.Ny-1])-
                      abs(FastAxisDAC.data[FastAxisDAC.Nx-1,0]);

  end
  else // Y Mode
  begin
    Scan.NX:=FastAxisDAC.Nx ;
    Scan.NY:=absMax+40;//ExperimData.DataMax+40;
    SetLength(Scan.m, Scan.Ny, Scan.Nx);
   for j:=0 to Scan.Nx-1 do
   begin
      k:=0;
     for i:=  0 to Scan.Ny-1 do
       begin
         if i< abs(FastAxisDAC.data[j,k])    then  Scan.m[i,j]:=0
          else
            begin
               if  (FastAxisDAC.data[j,k]>0) then Scan.m[i,j]:=1
                                             else Scan.m[i,j]:=-1;
               k:=k+1;
            end;
          if (k>= FastAxisDAC.Ny) then break;
        end;
    end;

    ScanImg.NY:=(Scan.NY-absMin+1) ;
    if flgOneLineScan then
       begin
          xStretch:=700 div Scan.Nx;
          ScanImg.NX:=xStretch*Scan.NX ;//div 5 ;
       end
    else
       ScanImg.NX:= abs(abs(SlowAxisDAC[SlowDataLen-1])- abs(SlowAxisDAC[0]))+
               abs(SlowAxisDAC[SlowDataLen-1])-abs(SlowAxisDAC[SlowDataLen-2])+20;

  SetLength(Scanimg.m, ScanImg.Ny,ScanImg.Nx);
 /// Image1.Width:=ScanImg.NX;
 // Image1.Height:=ScanImg.NY ;

   if ScanImg.NY> (Main.ClientWidth-200) then
    begin
      LineWidth:= ScanImg.NY div (Main.ClientHeight-200);
     // LineWidth:= round(LineWidth / ScaleKoeff);
      ScanImg.NY:=ScanImg.NY+LineWidth;
    end;
    SetLength(Scanimg.m, ScanImg.Ny,ScanImg.Nx);
  for i:=0 to Scan.NY-1 do
   begin
     CurrentPos:=0;
     for j:=  0 to Scan.NX-1 do
     begin
         if (not flgOneLineScan) and (j< Scan.NX-1) then
          xStretch:=abs(SlowAxisDAC[j+1])- abs(SlowAxisDAC[j]);
          if Scan.m[i,j]<>0 then
              begin
                for s:=0 to  LineWidth do
                 for k:=0 to  xStretch-1 do
                 Scanimg.m[ScanImg.Ny-1-(i-absMin+1+s), CurrentPos+k ]:=Scan.m[i,j];   // 1 or -1
              end;
         CurrentPos:=CurrentPos+xStretch;
     end;
   end;

   if flgOneLineScan then
     begin
       Chart1.BottomAxis.SetMinMax(1,Scan.Nx);
       Chart1.BottomAxis.Title.Caption:='Line number';
     end
    else
     begin
       Chart1.BottomAxis.SetMinMax(abs(SlowAxisDAC[0]*ScaleKoeff)-100,abs(SlowAxisDAC[SlowDataLen-1]*ScaleKoeff)+100);
       Chart1.BottomAxis.Title.Caption:='DAC X, discrets';
     end;
   Chart1.LeftAxis.SetMinMax(absMin*ScaleKoeff-100,absMax*ScaleKoeff+100);

   Chart1.LeftAxis.Title.Caption:='DAC Y, discrets';


    DFastdiscr:=abs(FastAxisDAC.data[FastAxisDAC.Nx-1, FastAxisDAC.Ny-1])-
                      abs(FastAxisDAC.data[0, FastAxisDAC.Ny-1]);

  end;   // YMode

     scaleX:=1;
     scaleY:=1;
     if ScanImg.NX>Main.ClientWidth-200  then   scaleX:= (Main.ClientWidth-200)/ScanImg.NX;
     if ScanImg.NY>Main.ClientHeight-200 then   scaleY:= (Main.ClientHeight-200)/ScanImg.NY;

     if (scalex<=scaley) then scal:= scalex
                         else scal:= scaley;
     DrawData(BitMap,ScanImg);
     //ClientHeight:=round(ScanImg.NY*scaleY);// + 10;
     //ClientWidth:= round(ScanImg.NX*scaleX);// + 10;
    // Image1.Height:= round(ScanImg.NY*scaleY);//ClientHeight;
   //  Image1.Width:=round(ScanImg.NX*scaleX);//ClientWidth;//Dat.NX ;
    // Image1.Picture.Assign(BitMap);

          Chart1.Left:=0;
          Chart1.Top:=0;
          Chart1.Height:=round(ScanImg.NY*scaleY)+80;
          Chart1.Width:=round(ScanImg.NX*scaleX)+80;
          Chart1.BackImageInside:=True;


    // Chart1.BackImage.Assign(Image1.Picture);
    Chart1.BackImage.Assign(BitMap) ;

    Panel2.ClientHeight:= Chart1.Height;
    Panel2.ClientWidth:=Chart1.Width;
    Panel1.Width:=Chart1.Width;
     //ClientHeight:=Chart1.Height;
    // ClientWidth:=Chart1.Width;
     ClientHeight:=Panel1.Height+Panel2.Height;
     ClientWidth:=Panel1.Width;

     if (not flgOneLineScan ) then
        begin
           DSlowdiscr:= abs(SlowAxisDAC[SlowDataLen-1])-abs(SlowAxisDAC[0]);
           DreifAngletang:=DFastdiscr/DSlowdiscr;
           DreifAngle:=180*Math.ArcTan2(DFastdiscr,DSlowdiscr)/3.14;
           Label2.Caption:='Non Ortogonal Angle = '+FloatToStrF( DreifAngle, fffixed,5,2)+
                         ' Degrees';
        end
      else Label2.Caption:='Diference for Fast axis (discr) =  '+IntToStr(DFastdiscr);//'One Line Scanning; Dreif is not counted';
end;

procedure TFormRenishNomogram.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
    if assigned(BitMap)  then Freeandnil(BitMap);
    if assigned(Scan)    then Freeandnil(Scan);
    if assigned(ScanImg) then Freeandnil(ScanImg);
end;




procedure TFormRenishNomogram.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if (ssAlt in Shift) then
    begin
      flgDragForm:=true;
    end
end;

procedure TFormRenishNomogram.FormKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if (ssAlt in Shift) then
    begin
      flgDragForm:=false;
    end
end;
procedure TFormRenishNomogram.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if flgDragForm then
  if Msg.message=WM_LButtonDown then
   begin
   if  getkeystate(VK_Menu)<0 then
    begin
       Chart1.BeginDrag(true);
      Main.CopyToClipBoardExecute(self);
       handled:=true;
    end;
   end;
     flgDragForm:=false;

end;

procedure  TFormRenishNomogram.CopyToClipboard;
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
end.
