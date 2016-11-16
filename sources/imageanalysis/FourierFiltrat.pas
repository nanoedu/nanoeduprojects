// {$R+}
unit FourierFiltrat;

interface
uses Classes, Graphics, Controls, Forms,
     ExtCtrls, StdCtrls, Buttons,SysUtils,chart,FourierProc,
     Windows,GlobalScanDataType, GlobalDcl;

var  TNX,TNY:integer;
     NX0,NY0:integer;
     SpectrWndNmb:integer;
     PSpecWnd:pointer;
     delfx, delfy:single;
     delfxWide, delfyWide:single;
     RRingFreq,XCRingFreq,YCRingFreq:single;
     RXY:single;
     Aver:single;
     NonSelectedAreaKoef:single;   // {0,1}
     SelectedAreaKoef:single;
     FreqFilterSize:single;
     FilteredData:MasCom;
     Hp: MasCom;    // Complex array for Fourier;
     PSpectr,PImage:TData;
     BackFFTResult:TDataFloatCount;
     Template:TDataFloatCount;


     procedure FiltrationInit(dat:TDataFloatCount);
     procedure AddSelected();
     procedure ExecuteFiltrat();
     procedure GenerateFilt();
     procedure SaveTemplateToBuf();


implementation
uses DllImageAnalWnd;
procedure FiltrationInit(dat:TDataFloatCount);
var i,j:integer;
begin
 FreqFilterSize:=1/8;
 SelectedAreaKoef:=1;
 if Assigned(Template) then FreeAndNil(Template);

 Template:=TDataFloatCount.Create;

 NX0:=dat.NX;
 NY0:=dat.NY;
 TNX:=round(NX0*(1+FreqFilterSize));
 TNY:=round(NY0*(1+FreqFilterSize));
 if odd(TNX) then inc(TNX);
 if odd(TNY) then inc(TNY);
with Template do
begin
  NX:=TNX;
  NY:=TNY;
  SetLength(Template.data,TNX,TNY);
end;
 NonSelectedAreaKoef:=0.0;
 delfx:=1/NX0/step;
 delfy:=1/NY0/step;
 delfxWide:=1/TNX/step;
 delfyWide:=1/TNY/step;

 SetLength(FilteredData,TNY*TNX);
   Aver:=Dat.mean;

     for i:=0 to NY0-1 do
       for j:=0 to NX0-1 do             // Dat.data записана по столбцам
         FilteredData[i*TNX+j].re:=Dat.data[j,i]-Aver;  // FilteredData записана по ст;

end; { procedure FiltrationInit();}

procedure AddSelected();
var g:single;
    X2,Y2:integer;
    i,j:integer;
    FreqScale:single;
    TMax,Tmin:single;
    RCountWide,RCountWideSymmetr:tRect;
    RFreqSymmetr:RRealRect;
    ss:string;
    XC,YC,XCSym,YCSym:integer;
    XR,YR,XRSym,YRSym:integer;
begin
ss:=ImgAnalysWnd.edSelected.text;
if ss='' then
begin
  ss:='1';
  ImgAnalysWnd.edSelected.text:=ss;
end;
 SelectedAreaKoef:=strToFloat(ss);
  with ImgAnalysWnd.Spectrumchart.Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clRed;
        Width:=2;
        Mode:=pmCopy;
       end;
  with ImgAnalysWnd.Spectrumchart.BackImage.Bitmap.Canvas.Pen do
       begin
        Style:=psSolid;
        Color:=clred;
        Width:=2;
        Mode:=pmCopy;
       end;
  ImgAnalysWnd.Spectrumchart.Canvas.Arc(R.Left,R.Top,R.Right,R.Bottom,
                           R.Left,R.Top,R.Left,R.Top);
  ImgAnalysWnd.Spectrumchart.Canvas.{Ellipse(R);}Arc(RSym.Left,RSym.Top,RSym.Right,RSym.Bottom,
                           RSym.Left,RSym.Top,RSym.Left,RSym.Top);


  X2:=round(TNX*0.5);
  Y2:=round(TNY*0.5);
  with RCountWide do
  begin
   Left:=round(X2+RFreq.Left/delfxWide);
   Top:= round(Y2-RFreq.Top/delfyWide);
   Right:=round(X2+RFreq.Right/delfxWide);
   Bottom:=round(Y2-RFreq.Bottom/delfyWide);
   XC:=(Right+Left) div 2;      // Центр овала
   YC:=(Bottom+Top) div 2;
   XR:=(Right-Left) div 2;      // Размер овала
   YR:=(Bottom-Top) div 2;
   xR:=XR*XR;     //XR^2
   YR:=YR*YR;
  end;

  With RFreqSymmetr do
    begin
      Right:=-RFreq.Left;
      Bottom:=-RFreq.Top;
      Left:=-RFreq.Right;
      Top:=-RFreq.Bottom;
    end;

  with RCountWideSymmetr do
   begin
    Right:=round(X2+RFreqSymmetr.right/delfxWide);
    Bottom:= round(Y2-RFreqSymmetr.bottom/delfyWide);
    Left:=round(X2+RFreqSymmetr.left/delfxWide);
    Top:=round(Y2-RFreqSymmetr.top/delfyWide);
    XCSym:=(Right+Left) div 2;
    YCSym:=(Bottom+Top) div 2;
    XRSym:=(Right-Left) div 2;
    YRSym:=(Bottom-Top) div 2;
    xRSym:=XRSym*XRSym;     //XRSym^2
    YRSym:=YRSym*YRSym;
   end;
  for i:=0 to TNY-1 do
   for j:=0 to TNX-1 do
  (*  begin
      if ((j<=RCountWide.Right) and (j>=RCountWide.Left) and (i>=RCountWide.Top)
                             and (i<=RCountWide.Bottom ) )    //or  { TODO : 031104 }
      then  Template.data[j,TNY-i-1]:= SelectedAreaKoef;    //else  { TODO : 031104 }
      if ((j<=RCountWideSymmetr.Right) and (j>=RCountWideSymmetr.Left) and (i>=RCountWideSymmetr.Top)
                             and (i<=RCountWideSymmetr.Bottom ))
      then  Template.data[j,TNY-i-1]:= SelectedAreaKoef;
    end;
    *)
    begin
      if ((j-XC)*(j-XC)/XR+(i-YC)*(i-YC)/YR)<=1 then
           Template.data[j,TNY-i-1]:= SelectedAreaKoef;
      if  ((j-XCSym)*(j-XCSym)/XRSym+(i-YCSym)*(i-YCSym)/YRSym )<=1 then
           Template.data[j,TNY-i-1]:= SelectedAreaKoef;
    end;


     TMax:=Template.max;
     Tmin:=Template.min;
     SaveTemplateToBuf();
     ImgAnalysWnd.BitBtnExecute.enabled:=True;
end;{AddBitBtn}

procedure ExecuteFiltrat();
var
    i,j,i1,i2:integer;
    XF:integer;
    FiltrResultMinVal,nxy:single;
    TMax,TMin:single;
begin
  SaveTemplateToBuf();
 try
   SetLength(Hp,TNY*TNX);
   GenerateFilt();
    for i:=0 to TNY-1 do
       for j:=0 to TNX-1 do
         Template.data[j,i]:=HP[i*TNX+j].re;
         cfft2(FilteredData,TNX,TNY,-1);
         FilteredData[0].re:=Aver*NX0*NY0;  // !!!!!!!!!!!!!!!!!!!
         Shiftfft(FilteredData,TNY,TNX);
   for i:=0 to TNY-1 do
    for j:=0 to TNX-1 do
       begin
          FilteredData[i*TNX+j].re:=FilteredData[i*TNX+j].re*Hp[i*TNX+j].re;
          FilteredData[i*TNX+j].im:=FilteredData[i*TNX+j].im*Hp[i*TNX+j].re;
       end;
    Shiftfft(FilteredData,TNY,TNX);
    cfft2(FilteredData,TNX,TNY,1);
    FiltrResultMinVal:=0;
    nxy:=1/NY0/NX0;
 for i1:=0 to TNY-1 do
  for i2:=0 to TNX-1 do
   begin
    FilteredData[TNX*i1+i2].re:=FilteredData[TNX*i1+i2].re*nxy;{/NY0/NX0;}
    FilteredData[TNX*i1+i2].im:=FilteredData[TNX*i1+i2].im*nxy;{/NY0/NX0;}
    if (FilteredData[TNX*i1+i2].re<FiltrResultMinVal) then
                               FiltrResultMinVal:=FilteredData[TNX*i1+i2].re;
   end;
  FiltrResultMinVal:=abs(FiltrResultMinVal);
 for i1:=0 to TNY-1 do
  for i2:=0 to TNX-1 do
   begin
    FilteredData[TNX*i1+i2].re:=FilteredData[TNX*i1+i2].re+FiltrResultMinVal;
   end;

     FFTModules(FilteredData,TNY,TNX);
     if assigned(BackFFTResult) then FreeAndNil(BackFFTResult);
     BackFFTResult:=TDataFloatCount.Create;
     BackFFTResult.NX:=NX0;
     BackFFTResult.NY:=NY0;
     BackFFTResult.data:=nil;
    try
     SetLength(BackFFTResult.data,NX0,NY0);
     XF:=round(TNX*freqFilterSize/2);
         for i:=0 to  NY0-1 do
          for j:=0 to  NX0-1 do
             begin
               BackFFTResult.data[j,i]:=FilteredData[i*TNX+j].re;
             end;
   finally
   end; {finally}
 finally
   FreeAndNil(Template);
   Finalize(Hp);//:=nil;
   Finalize(FilteredData);//:=nil;
 end; {finally}
end; {procedure ExecuteFiltrat();}

procedure GenerateFilt();
var
 Tp: MasCom;    //Complex array of data for Fourier;
 X1,Y1,TopoX1,TopoY1:integer;
 ik,iy,XF,YF:integer;
 i1,i2,i01,i02,i,j: integer;
 Tnxy,El:single;
begin
 try
    SetLength(Tp,TNY*TNX);
	  for i1:=0 to TNY-1 do
		 for i2:=0 to TNX-1  do
		    begin
  			 El:=Template.data[i2,i1];
         Tp[TNX*i1+i2].re:=El;
        end;
  cfft2(Tp,TNX,TNY,-1);  // Now Tp is FFT2 of input data
  Shiftfft(Tp,TNY,TNX);
  XF:=round(TNX*freqFilterSize*0.5);
  YF:=round(TNY*freqFilterSize*0.5);
  ik:=TNX div 2-XF;
  iy:= TNY div 2-YF;
try
 for i1:=0 to 2*YF-1 do
  for i2:=0 to 2*XF-1  do
	 begin
     Hp[i1*(TNX)+i2]:=Tp[(i1+iy)*(TNX)+i2+ik];
   end;
  for i:=0 to TNY-1 do
       for j:=0 to TNX-1 do
         Template.data[j,i]:=sqrt(HP[i*TNX+j].re*HP[i*TNX+j].re+HP[i*TNX+j].im*HP[i*TNX+j].im);
except
 Finalize(Hp);//:=nil;
end;
finally
 Finalize(Tp);//:=nil;
end;
 cfft2(Hp,TNX,TNY,1);
  tnxy:=1/TNX/TNY;
  for i1:=0 to TNY-1 do
  	 for i2:=0 to TNX-1  do
		    begin
          Hp[i1*TNX+i2].re:=Hp[i1*TNX+i2].re*tnxy;{/TNX/TNY;}
          Hp[i1*TNX+i2].im:=Hp[i1*TNX+i2].im*tnxy;{/TNX/TNY;}
    		end ;
 fftmodules(Hp,TNY ,TNX);
end; {GenerateFilt}


procedure SaveTemplateToBuf();
var i,j:integer;
begin
 try
 with TemplateBuf do
   begin
     NX:=Template.NX;
     NY:=Template.NY;
   SetLength(TemplateBuf.data, NX,NY);
    for i:=0 to NY-1 do
     for j:=0 to NX-1 do
       TemplateBuf.data[j,i]:=Template.data[j,i];
    end;
   except
      FreeandNil(TemplateBuf);
   end;
end;

end.

// {$R-}
