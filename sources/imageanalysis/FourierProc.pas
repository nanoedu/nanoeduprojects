//{$R+}
unit FourierProc;
// Folder IMAGEANALYSIS!!
interface

uses  SysUtils, Classes,GlobalType,GlobalScanDataType,GlobalDCL;
(* type
    PMas1=array of single;
   type
    PMasInt=array of integer;
 type DataFloat=double;
// type PMas2=array of array of DataFloat;    // in Globaldcl
 type PMas2Sing=array of array of single;

 type
     Tcom=record   // Complex value ;
	   re: DataFloat;
	   im: DataFloat;
     end;


 type
     MasCom=array of Tcom;   // Array of complex values;   *)

 (*type TData=class(Tobject)
  private
       	function max :datatype;
	function min :datatype;
	function mean :single;
  public
        flg:byte;   //type data Topo,Phase or ...
        caption:string; //axies unit
      	Nx,Ny: integer;
        XStep,YStep,ZStep:single;
        data:Tmas2;
        constructor Create;
        destructor Destroy; override;
        property DataMin:datatype read min;
        property DataMax:datatype read max;
        property DataMean:single  read mean;
    end;{class}


  type TDataFloatCount=class(TObject)
   private
   protected
   public
	data: PMas2;
	NX,NY: integer;
	//min,max: double;
	function max :DataFloat;
	function min : DataFloat;
	function mean :DataFloat;
	constructor Create;
	destructor Destroy; override;
	published
     end; {class}

 *)
 procedure cfft2(var Tp:MasCom; // Input(Output) Image as 1-D indexed structure
                n2,n1: integer; // Image Width and Height;
                sign: integer //(=-1) - Direct FFT2, (=1) Inverce;
                        );

  procedure fourG(var dat:PMas1;  //Input(Output) data (1-D)
                n:integer; // Length of input data
                sign:integer //(=-1) - Direct FFT,(=1) Inverce;
                            );

  procedure fftmodules(var dat:MasCom; n1,n2: integer);
  procedure Shiftfft (var dat:MasCom; n1,n2: integer);
  procedure FourierSp(var dat:TDataFloatCount);
 // procedure DelSteps(var dat:TData);
  procedure ImgContinue(var dat:TDataFloatCount; convsize:integer);
  procedure DelConvSurf(var dat:TDataFloatCount; convsize:integer);
  procedure Conv2m2(var Data:TDataFloatCount; S:integer);
  function BarlettW(sizeX,sizeY,sizeW:integer; var WX,WY:integer):PMas2Sing;
  procedure Filter2(var Data:TDataFloatCount; Window:PMas2Sing;WX,WY:integer);
implementation

procedure fourG(var dat:PMas1; n:integer; sign: integer);
 var
 Work: PMas1;
 i,ind,idiv,igo,nrem,ndone,istep,ipo,imax: integer;
 i1,i2,i3,i23,j2,i231,i321 : integer;
 theta,wr,wi,temp: double;
label A,B,C,D;
begin
  ipo:=2;
  nrem:=n;
  ind:=-1;
  idiv:=2; igo:=-1;
  try
   SetLength(work,2*n);
  goto C;
  A: idiv:=1;
     igo:=0;
  B: idiv:=idiv+2;
     if (idiv*idiv>nrem) then
        begin
          idiv:=nrem;
          igo:=1;
          if (idiv<=1) then goto D;
        end;
 C: while ((nrem-idiv*(nrem div idiv)=0)){ and (idiv>1)) }do
  begin
   ndone:=n div nrem;
   nrem:=nrem div idiv;
   for i3:=1 to ndone do
    for i2:=1 to idiv do
     begin
      i23:=((i2-1)*ndone+i3-1)*nrem;
      theta:=6.283185*(i23)/(sign*n);
      wr:=cos(theta);
      wi:=sin(theta);
      istep:=nrem*ipo;
     for i1:=1 to nrem do
       begin
       i231:=(i23+i1-1)*ipo+1;
       i321:=((i3*idiv-1)*nrem+i1-1)*ipo+1;
       if (ind<=0) then
         begin
         work[i231-1]:=dat[i321-1];
         work[i231]:=dat[i321];
         for j2:=2 to idiv do
            begin
            i321:=i321-istep;
            temp:=work[i231-1];
            work[i231-1]:=wr*temp-wi*work[i231]+dat[i321-1];
            work[i231]:=wr*work[i231]+wi*temp+dat[i321];
            end;
         end
         else
         begin
         dat[i231-1]:=work[i321-1];
         dat[i231]:=work[i321];
         for j2:=2 to idiv do
            begin
            i321:=i321-istep;
            temp:=dat[i231-1];
            dat[i231-1]:=wr*temp-wi*dat[i231]+work[i321-1];
            dat[i231]:=wr*dat[i231]+wi*temp+work[i321];
            end;
         end; {else}
     end;  {for(i1)}
     end; {for(i2,i3)}
     ind:=-ind;

   end;  {while}

    if (igo<0)then goto A
    else if (igo=0) then goto B
    else goto D;

  D:  imax:=ipo*n;
    if (ind<=0) then
       for i:=1 to imax do
           dat[i-1]:=dat[i-1]
    else
       for i:=1 to imax do
           dat[i-1]:=work[i-1];

 finally
   work:=nil;
 end;
end;

procedure cfft2(var Tp:MasCom; n2,n1:integer; sign:integer) ;
var  Wk: PMas1;//array of double;
     n,i1,i2:integer;
begin
if n1>n2 then  n:=n1
         else n:=n2;
 try
  SetLength(Wk,2*n);
  for i2:=0 to n2-1  do
   begin
    for i1:=0 to n1-1 do
		 begin
  		 Wk[i1*2]:=Tp[i1*n2+i2].re;
	  	 Wk[i1*2+1]:=Tp[i1*n2+i2].im;
		 end;
		 fourG(Wk,n1,sign);
		 for i1:=0 to n1-1 do
		    begin
		    	Tp[i1*n2+i2].re:=Wk[i1*2];
		    	Tp[i1*n2+i2].im:=Wk[i1*2+1];
		    end;
		end;
	for i1:=0 to n1-1 do
		begin
		 for i2:=0 to n2-1 do
		  begin
		   Wk[i2*2]:=Tp[i1*n2+i2].re;
		   Wk[i2*2+1]:=Tp[i1*n2+i2].im;
		  end;
		  fourG(Wk,n2,sign);
		  for i2:=0 to n2-1 do
			begin
			 Tp[i1*n2+i2].re:=Wk[i2*2];
			 Tp[i1*n2+i2].im:=Wk[i2*2+1];
			end;
		 end;
 finally
  Wk:=nil;
 end;
end; {cfft2}

procedure fftmodules(var dat: MasCom; n1,n2: integer);
     //Procedure of the spectrum  modules calculation
var
   s,i1,i2,n: integer;
   Wm: PMas1; //array of double;
begin

  if n1>n2 then  n:=n1 else n:=n2;
try
 SetLength(Wm,2*n);
 for i1:=0 to n1-1 do
  begin
	 for i2:=0 to n2-1 do
	 begin
  	 Wm[i2*2]:=dat[i1*n2+i2].re;
	   Wm[i2*2+1]:=dat[i1*n2+i2].im;
	 end;

   for s:=0 to n2-1 do
   begin
  	Wm[s]:=Wm[2*s]* Wm[2*s]+Wm[2*s+1]* wm[2*s+1];
	  Wm[s]:=sqrt(Wm[s]);
	 end;

   for i2:=0 to n2-1 do dat[i1*n2+i2].re:=Wm[i2];
  end;
 finally
  Wm:=nil;
 end;
end;  {fftmodules}

procedure FourierSp(var dat:TDataFloatCount);
var
Tp: MasCom;    //Complex array of data for Fourier;
Hp: MasCom;    // Complex array of etalone for Fourier;
//Cp: PMas2;     // Result of correlation with etalone;
Fsp:TextFile;
X1,Y1,TopoX1,TopoY1:integer;
Sum:single;
Aver: single;            // Mean value of the elements
El: single;              // Buffer for the reading
n1,n2: integer;
i1,i2: integer;
FiltSiz:integer;
Part: integer;
W:single;
BarlettWnd:PMas2Sing;
SizeBW,BWX,BWY:integer;
begin
  Part:=1;
  X1:=Dat.NX;
  Y1:=Dat.NY;
  FiltSiz:=1;//X1 div Part;
  TopoY1:=Y1+FiltSiz-1;
  TopoX1:=X1+FiltSiz-1;
 n1:=TopoY1;
 n2:=TopoX1;
 if ( (n1-2*(n1 div 2))<>0) then   n1:=n1+1;
 if ( (n2-2*(n2 div 2))<>0) then   n2:=n2+1;

try
 SetLength(Tp,n1*n2);
 Sum:=0;
 Aver:=Dat.mean;
	  for i1:=0 to Y1-1 do
 		 for i2:=0 to X1-1  do
	    begin
			 El:=Dat.data[i2,i1]-Aver; //Topo[X1*i1+i2];
       W:=(0.25*(1-cos(2*pi*i1/(Y1+1)))*(1-cos(2*pi*i2/(X1+1))));
       Tp[n2*i1+i2].re:=El*W; // Hann2D window;
      end;
cfft2(Tp,n2,n1,-1);  // Now Tp is FFT2 of input data
for i1:=0 to n1-1 do
for i2:=0 to n2-1 do
begin
 Tp[n2*i1+i2].re:=Tp[n2*i1+i2].re/n2/n1;
 Tp[n2*i1+i2].im:=Tp[n2*i1+i2].im/n2/n1;
end;
//  Spectrum modules calculation
      	 fftmodules(Tp,n1 ,n2);
         Shiftfft(Tp,n1,n2);
         //DatTmp:=TData.Create;
         Dat.NX:=n2;
         Dat.NY:=n1;
         Dat.data:=nil;

         SetLength(Dat.data,n2,n1);

         for i1:=0 to n1-1 do
         for i2:=0 to n2-1 do Dat.data[i2,i1]:=Tp[i1*n2+i2].re;

          FiltSiz:=n1;
          if n2<n1 then FiltSiz:=n2;
          SizeBW:=round(FiltSiz/3);   // 3 - Empirical Parametr
          BarlettWnd:=BarlettW(n2,n1,SizeBW,BWX,BWY);
          if BWX>n2 then BWX:=n2;
          if BWY>n1 then BWY:=n1;
          Filter2(Dat,BarlettWnd,BWX,BWY);

 finally
  Tp:=nil;
 end;

end; {FourierSp}

procedure Shiftfft (var Dat:MasCom; n1,n2: integer) ;
var
  Bu: double;
  m1,m2,i1,i2: integer;
begin
  m1:=n1 div 2;
  m2:=n2 div 2;

  for i1:=0 to m1-1 do
  for i2:=0 to m2-1 do
   begin
	  Bu:=Dat[i1*n2+i2].re;
	  Dat[i1*n2+i2].re:=Dat[n2*m1+m2*(2*i1+1)+i2].re;
	  Dat[n2*m1+m2*(2*i1+1)+i2].re:=Bu;
    Bu:=Dat[i1*n2+i2].im;
	  Dat[i1*n2+i2].im:=Dat[n2*m1+m2*(2*i1+1)+i2].im;
	  Dat[n2*m1+m2*(2*i1+1)+i2].im:=Bu;
   end;
  for i1:=0 to m1-1 do
  for i2:=0 to m2-1 do
   begin
	  Bu:=Dat[m2*(2*i1+1)+i2].re;
	  Dat[m2*(2*i1+1)+i2].re:=Dat[n2*m1+i1*n2+i2].re;
	  Dat[n2*m1+i1*n2+i2].re:=Bu;
    Bu:=Dat[m2*(2*i1+1)+i2].im;
	  Dat[m2*(2*i1+1)+i2].im:=Dat[n2*m1+i1*n2+i2].im;
	  Dat[n2*m1+i1*n2+i2].im:=Bu;
  end;
end;


procedure Conv2m2(var Data:TDataFloatCount; S:integer);
// S=2*n+1;
var
  i,j,kx,ky,ix,iy:integer;
  Shift:integer;
  X,Y:integer;
  res: double;
  ires: integer;
  Temp:TDataFloatCount;
begin
   Shift:=(S-1) div 2;
   X:=Data.NX; Y:=Data.NY;
   Temp:=TDataFloatCount.Create;
try
   SetLength(Temp.data,X,Y);
   Temp.NX:=X; Temp.NY:=Y;
  for iy:=0 to Y-1 do
   begin
     for ix:=0 to X-1 do
        begin
             res:=0.0; ires:=0;
             for ky:=-Shift to Shift do
             begin
                for kx:=-Shift to Shift do
                begin
                     i:=ix+kx; j:=iy+ky;
                     if (i >= 0) and (i < X)
                        and (j >= 0) and (j < Y) then
                     begin
                        ires:=ires+1;
                        res:=res+Data.data[i,j];
                     end;
                end; {for kx}
             end; {for ky}
             if ires > 0 then
             begin
                Temp.data[ix,iy]:=(res/ires);
             end
             else begin
                Temp.data[ix,iy]:=Data.data[ix,iy];
             end;
        end; {for ix}
   end; {for iy}

   for iy:=0 to Y-1 do
     for ix:=0 to X-1 do   Data.data[ix,iy]:=Temp.data[ix,iy];

finally
   FreeandNil(Temp);//.Destroy;
end; {finally}
end; {Conv2m2}


procedure ImgContinue(var dat:TDataFloatCount; convsize:integer);
begin
end;

procedure DelConvSurf(var dat:TDataFloatCount; convsize:integer);
begin
end;

{TData}
(*constructor TData.Create;
begin
  inherited;
  flg:=0;//Topography;
  Caption:='';
  NX:=0;
  NY:=0;
  XStep:=0;
  YStep:=0;
//  SetLength(data,NY,NX);
end; {TData.Create}

destructor TData.Destroy;
var i:integer;
begin
     NX:=0;
     NY:=0;
     XStep:=0;
     YStep:=0;
     Finalize(data);
     inherited;
end; {TData.Destroy}

function TData.max : datatype;
var i , j : integer;
    a : datatype;
begin
     if (NX > 0) and (NY > 0) then
     begin
          a:=data[0,0];
         for j:=0 to NY-1 do
          begin
  	       for i:=0 to NX-1 do
               begin
                    if data[i,j] > a then a:= data[i,j];
               end;
          end;
     end
     else a:=0;
     max:=a;
end; {TData.max}

function TData.min: datatype;
var  i, j : integer;
     a : datatype;
begin
     if (NX > 0) and (NY > 0) then
     begin
          a:=data[0,0];
          for j:=0 to NY-1 do
          begin
               for i:=0 to NX-1 do
               begin
                    if data[i,j] < a then a:=data[i,j];
               end;
          end;
     end
     else a:=0;
     min:=a;
end; {TData.min}

function TData.mean : single;
var i , j : integer;
    S : single;
begin
     S:=0.0;
     if (NX > 0) and (NY > 0) then
     begin
          for j:=0 to NY-1 do
          begin
               for i:=0 to NX-1 do
               begin
                    S:=S+data[i,j];
               end;
          end;
          S:=S/NX/NY;
     end;
     mean:=S;
end; {TData.mean}



{TDataFloatCount}
function TDataFloatCount.max : double;
var i , j : integer;
    a : double;
begin
     if (NX > 0) and (NY > 0) then
     begin
          a:=data[0,0];
          for i:=0 to NY-1 do
          begin
  	       for j:=0 to NX-1 do
               begin
                    if data[j,i] > a then a:= data[j,i];
               end;
          end;
     end
     else a:=0.0;
     max:=a;
end; {TData.max}

function TDataFloatCount.min: double;
var  i, j : integer;
     a : double;
begin
     if (NX > 0) and (NY > 0) then
     begin
          a:=data[0,0];
          for i:=0 to NY-1 do
          begin
               for j:=0 to NX-1 do
               begin
                    if data[j,i] < a then a:=data[j,i];
               end;
          end;
     end
     else a:=0.0;
     min:=a;
end; {TData.min}

function TDataFloatCount.mean : double;
var i , j : integer;
    S : double;
begin
     S:=0.0;
     if (NX > 0) and (NY > 0) then
     begin
          for i:=0 to NY-1 do
          begin
               for j:=0 to NX-1 do
               begin
                    S:=S+data[j,i];
               end;
          end;
          S:=S/NX/NY;
     end;
     mean:=S;
end; {TData.mean}

constructor TDataFloatCount.Create;
begin
  inherited;
  NX:=0;
  NY:=0;
  SetLength(data,NY,NX);
end; {TDataFloatCount.Create}

destructor TDataFloatCount.Destroy;
begin
     NX:=0;
     NY:=0;
     Finalize(data);
     inherited;
end; {TDataFloatCount.Destroy}
 *)
function BarlettW(sizeX,sizeY,sizeW:integer; var WX,WY:integer):PMas2Sing;
var i,j,LX,LY:integer;
i0,j0,iend,jend,istep,jstep:single;
Temp:PMas2Sing;
g:integer;
begin
if (sizeX mod sizeW) =0 then sizeX:=sizeX+1;
if (sizeY mod sizeW) =0 then sizeY:=sizeY+1;
g:=2;
iEnd:=g/sizeW;
jEnd:=g/sizeW;
iStep:=1/sizeY;
jStep:=1/sizeX;
LX:=2*g*round(sizeX/sizeW)+1;
LY:=2*g*round(sizeY/sizeW)+1;
try
  Setlength(Temp,LX,LY);
  i:=0;
  j:=0;
  i0:=-2/sizeW;
  for i:=0 to LY-1 do
    begin
      j0:=-2/sizeW;
      for j:=0 to LX-1 do
        begin
           Temp[j,i]:=Sqr(SizeW*sin(Pi*i0*sizeW)*sin(Pi*j0*sizeW)/
                            (Pi*i0*sizeW)/(Pi*j0*sizeW));
            j0:=j0+jStep;
        end;
      i0:=i0+iStep;
    end;
BarlettW:=Temp;
WX:=LX;
WY:=LY;
finally
 Temp:=nil;
end;
end; {BarlettW}

procedure Filter2(var Data:TDataFloatCount; Window:PMas2Sing;WX,WY:integer);
var
  i,j,kx,ky,ix,iy:integer;
  ShiftX,ShiftY:integer;
  X,Y:integer;
  res: double;
  ires: double;
  Temp:TDataFloatCount;
begin
   ShiftX:=(WX-1) div 2;
   ShiftY:=(WY-1) div 2;
   X:=Data.NX; Y:=Data.NY;
   Temp:=TDataFloatCount.Create;
   SetLength(Temp.data,X,Y);
   Temp.NX:=X; Temp.NY:=Y;
try
  for iy:=0 to Y-1 do
   begin
     for ix:=0 to X-1 do
        begin
             res:=0.0; ires:=0;
           for ky:=-ShiftY to ShiftY do
             begin
             for kx:=-ShiftX to ShiftX do
                begin
                     i:=ix+kx; j:=iy+ky;
                    if (i >= 0) and (i < X-1) and (j >= 0) and (j < Y-1)
                     then
                     begin
                        ires:=ires+Window[kx+ShiftX,ky+ShiftY];
                        res:=res+Data.data[i,j]*Window[kx+ShiftX,ky+ShiftY];
                     end;
                end; {for kx}
             end; {for ky}
             if ires > 0 then   Temp.data[ix,iy]:=(res/ires)
                         else  Temp.data[ix,iy]:=Data.data[ix,iy];
        end; {fir ix}
   end; {for iy}

   for iy:=0 to Y-1 do
   begin
        for ix:=0 to X-1 do
        begin
            Data.data[ix,iy]:=Temp.data[ix,iy];
        end;
   end;

finally
   FreeandNil(Temp);;//.Destroy;    { TODO : 271007 }
end; {finally}
end; {Filter2}


end.
//{$R-}
