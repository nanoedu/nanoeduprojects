unit frReniShowDiagn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,GlobalScanDataType, GlobalDcl, TeEngine, Series, TeeProcs, Chart;
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
  TFormReniShDiagn = class(TForm)
    Image1: TImage;
    Chart1: TChart;
    Series1: TLineSeries;
   // procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Scan, ScanImg:TDataS;
    BitMap:TBitMap;
  public
    constructor Create(AOwner: TComponent; ExperimData:TData; Mode:integer);
  end;


procedure MakePalette(BitMap: TBitMap);
procedure Drawdata(out BitMap: TBitMap; Dat:TdataS);
var
  FormReniShDiagn: TFormReniShDiagn;
  Dat: TDataS;
  hpal : HPALETTE;


implementation
uses  CSPMVar,mMain;
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

   
  
      for y:=0 to LHeight-1 do
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


      end;
end; {DrawData}


//procedure TFormReniShDiagn.FormCreate(Sender: TObject);
constructor TFormReniShDiagn.Create(AOwner: TComponent; ExperimData:TData; Mode:integer);
var i,j, k,s:integer;
  LineWidth:integer;
  yStretch, xStretch:integer;
  absMin, absMax, tmp:integer;
  scaleX, scaleY, scal:single;
  H,W:integer;
begin
inherited Create(AOwner);
  with Image1 do
    begin
      Left:=0;
      Top:=0;
      Stretch:=True;
    end;
    absMin:=MaxDATATYPE;
    absMax:=MinDATATYPE;
     for j:=0 to ExperimData.Nx-1do
       for i:=0 to ExperimData.Ny-1 do
       begin
         tmp:=abs(ExperimData.data[j,i]);
        if  (tmp<absMin) then absMin:=tmp;
        if  (tmp>absMax) then absMax:=tmp;
       end;

  LineWidth:=1;
  Scan:=TDataS.Create;
  Scanimg:=TDataS.Create;
  if Mode=0 then  // Mode X+
  begin
    Scan.NX:=absMax+40; //ExperimData.DataMax +40;
    Scan.NY:=ExperimData.Ny;
    SetLength(Scan.m, Scan.Ny,Scan.Nx);
   for i:=0 to Scan.NY-1 do
   begin
      k:=0;
     for j:=  0 to Scan.NX-1 do
       begin
         if j< abs(ExperimData.data[k,i])  then
               Scan.m[i,j]:=0
          else
            begin
               if  (ExperimData.data[k,i]>0) then
                  Scan.m[i,j]:=1
                else Scan.m[i,j]:=-1;
               k:=k+1;
            end;
          if (k>= ExperimData.Nx) then break;
        end;
    end;

  yStretch:=400 div Scan.NY;
  ScanImg.NX:=Scan.NX-absMin+1 ;//div 5 ;
  ScanImg.NY:=yStretch*Scan.NY;
  Image1.Width:=ScanImg.NX;
  Image1.Height:=ScanImg.NY;

  if ScanImg.NX > (Main.ClientWidth-180) then
    begin
      LineWidth:= ScanImg.NX div (Main.ClientWidth-180);
      ScanImg.NX:=ScanImg.NX+LineWidth;
    end;
    SetLength(Scanimg.m, ScanImg.Ny,ScanImg.Nx);
  for i:=0 to Scan.NY-1 do
     for j:=  0 to Scan.NX-1 do
          if Scan.m[i,j]<>0 then
              begin
                for s:=0 to  LineWidth do
                 for k:=0 to  yStretch-1 do
                  Scanimg.m[ScanImg.Ny-1-(i*yStretch+k), j-absMin+1+s {div 5}]:=Scan.m[i,j];   // 1 or -1
              end ;
    Chart1.BottomAxis.SetMinMax(absMin-100,absMax+100);
    Chart1.LeftAxis.SetMinMax(1,Scan.NY);
    Chart1.BottomAxis.Title.Caption:='DAC X, discrets';
    Chart1.LeftAxis.Title.Caption:='Line number';
  end
  else // Y Mode
  begin
    Scan.NX:=ExperimData.Nx ;
    Scan.NY:=absMax+40;//ExperimData.DataMax+40;
    SetLength(Scan.m, Scan.Ny, Scan.Nx);
   for j:=0 to Scan.Nx-1 do
   begin
      k:=0;
     for i:=  0 to Scan.Ny-1 do
       begin
         if i< abs(ExperimData.data[j,k])    then  Scan.m[i,j]:=0
          else
            begin
               if  (ExperimData.data[j,k]>0) then Scan.m[i,j]:=1
                                             else Scan.m[i,j]:=-1;
               k:=k+1;
            end;
          if (k>= ExperimData.Ny) then break;
        end;
    end;

  xStretch:=700 div Scan.Nx;
  ScanImg.NX:=xStretch*Scan.NX ;//div 5 ;
  ScanImg.NY:=(Scan.NY-absMin+1) ;
  SetLength(Scanimg.m, ScanImg.Ny,ScanImg.Nx);
  Image1.Width:=ScanImg.NX;
  Image1.Height:=ScanImg.NY ;

   if ScanImg.NY> (Main.ClientWidth-160) then
    begin
      LineWidth:= ScanImg.NY div (Main.ClientHeight-160);
      ScanImg.NY:=ScanImg.NY+LineWidth;
    end;
    SetLength(Scanimg.m, ScanImg.Ny,ScanImg.Nx);
  for i:=0 to Scan.NY-1 do
     for j:=  0 to Scan.NX-1 do
          if Scan.m[i,j]<>0 then
              begin
                for s:=0 to  LineWidth do
                 for k:=0 to  xStretch-1 do
                 Scanimg.m[ScanImg.Ny-1-(i-absMin+1+s), j*xStretch+k ]:=Scan.m[i,j];   // 1 or -1
              end;
   Chart1.LeftAxis.SetMinMax(absMin-100,absMax+100);
   Chart1.BottomAxis.SetMinMax(1,Scan.Nx);
   Chart1.LeftAxis.Title.Caption:='DAC Y, discrets';
    Chart1.BottomAxis.Title.Caption:='Line number';
  end;   // YMode

     scaleX:=1;
     scaleY:=1;
     if ScanImg.NX>Main.ClientWidth-100  then   scaleX:= (Main.ClientWidth-100)/ScanImg.NX;
     if ScanImg.NY>Main.ClientHeight-100 then   scaleY:= (Main.ClientHeight-100)/ScanImg.NY;

     if (scalex<=scaley) then scal:= scalex
                         else scal:= scaley;
     DrawData(BitMap,ScanImg);
     //ClientHeight:=round(ScanImg.NY*scaleY);// + 10;
     //ClientWidth:= round(ScanImg.NX*scaleX);// + 10;
     Image1.Height:= round(ScanImg.NY*scaleY);//ClientHeight;
     Image1.Width:=round(ScanImg.NX*scaleX);//ClientWidth;//Dat.NX ;
     Image1.Picture.Assign(BitMap);

          Chart1.Left:=0;
          Chart1.Top:=0;
          Chart1.Height:=Image1.Height+80;
          Chart1.Width:=Image1.Width+80;
          Chart1.BackImageInside:=True;


     Chart1.BackImage.Assign(Image1.Picture);
     ClientHeight:=Chart1.Height;
     ClientWidth:=Chart1.Width;
end;

procedure TFormReniShDiagn.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
    if assigned(BitMap)  then Freeandnil(BitMap);
    if assigned(Scan)    then Freeandnil(Scan);
    if assigned(ScanImg) then Freeandnil(ScanImg);
end;



end.


