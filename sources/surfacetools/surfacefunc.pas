//250707
unit surfacefunc;

interface
const MaxMatr=6;
 type datatype=smallint;
 type TMas2=array of array of datatype;
 type massiv = array [1..maxMatr] of single;
      ipvmassiv = array [1..maxMatr] of integer;
      matrix = array [1..maxMatr] of massiv;
 type float=single;
 type TLine=array of datatype;
 type TLineSingle=array of single;
 type mcell=array[1..3,1..3] of single;
 type
    Vector=record
 	x, y, z:single;
 end;
 const MAXSMALLINT=$7FFF;
 type
    PMas1=array of single;
  type
    PMasInt=array of integer;
  type
     Tcom=record   // Complex value ;
	   re: double;
	   im: double;
     end;

  type
     MasCom=array of Tcom;   // Array of complex values;

procedure DelStepsX(Nx,Ny:integer; var datmas:TMas2; FileName:PChar); StdCall;

procedure DelStepsY(Nx,Ny:integer; var datmas:TMas2; FileName:PChar); StdCall;

function vectorminus(v1,v2:Vector):Vector;

function vectorplus(v1,v2:Vector):Vector;

function vectormult(v1,v2:Vector):Vector;

function Normal(TopoCell:mcell; x,y,StepX,StepY:double):Vector;  stdcall;


procedure Solv(neqn : integer;  var ptrmat : matrix; var work : massiv; var ipv : ipvmassiv);

procedure Dcomp(neqn : integer;  var ptrmat : matrix; var cond : float;
                var work : massiv; var ipv : ipvmassiv);


procedure Dsolv (Dimen        : integer;
                 var Coefficients : matrix;
                 var Constants    : massiv;
                 var Solution     : massiv;
                 var Error : byte;
                 var Cond : float);



Procedure DelFiltLevel(NX,NY: integer; var p : Tmas2; FileName:PChar); stdcall;

Procedure DelFiltLevelOne(NX,NY: integer; var p : Tmas2; FileName:PChar); stdcall;

Procedure DelFiltPlane(Nx, Ny:integer;var p : Tmas2; FileName:PChar) ;  stdcall;


Procedure DelFiltSurface(Nx1, Ny1, Nx2, Ny2 , NxMax, NyMax: integer; var p : Tmas2); stdcall;


Procedure AverageFilt3X3(Nx, Ny : integer;var p:Tmas2; FileName:PChar); stdcall;

procedure MedianFilt3(Nx,Ny:integer; var p:Tmas2; FileName:PChar); stdcall;

Procedure LinDelFiltPlaneParm( Nx : integer; var p : TLineSingle; var sfA:single; var sfB:single);  stdcall;

procedure Convolution(var Mas:TLineSingle;const Size,S:integer);   stdcall;


implementation

uses  fitutils;

procedure Convolution(var Mas:TLineSingle;const Size,S:integer);
var
 i,r:integer;
 Q,Buf:single;
  Shift,L:integer;
 Temp:  TLineSingle;
begin
 L:=Size;//Length(Mas);
 Shift:=(S-1) div 2;
 SetLength(Temp,L);
 for i:=0 to L-1 do Temp[i]:=Mas[i];
 for i:=0 to Shift-1 do    // Set boundary elements
    begin                // for convolution;
     Temp[i]:=Mas[i];
     Temp[i+L-Shift]:=Mas[i+L-Shift];
    end ;
 for i:=Shift to L-Shift-1 do
   begin
     Q:=0;
    for r:=0 to S-1 do
     begin
      Buf:=Mas[i+r-Shift];
      Q:=Q+Buf;
     end;
     Q:=Q /S;{ TODO : 300305 }
     Temp[i]:=Q;
  end;
  for i:=0 to L-1 do Mas[i]:=Temp[i];
  Temp:=nil;
end;

procedure DelStepsX(Nx,Ny:integer; var datmas:TMas2; FileName:PChar); StdCall;
var Aver:integer;
     i,j:integer;
     X1,Y1,El,Sum:integer;
     ScanAver:TLine;  // type PLine is declared in GlobalDcl;
begin
  Aver:=0;
     if (NX > 0) and (NY > 0) then
     begin
          for j:=0 to NY-1 do
          begin
              for i:=0 to NX-1 do
               begin
                  Aver:=Aver+datmas[i,j];
               end;
          end;
          Aver:=round(Aver/NX/NY);
     end;
 X1:=NX;
 Y1:=NY;
    SetLength(ScanAver,Y1);
     for i:=0 to Y1-1 do        //Lines (scans)
     begin
      Sum:=0;
		 for j:=0 to X1-1  do     // Rows
		    begin
	   		 El:=Datmas[j,i]; //Topo[X1*i1+i2];
   			 Sum:=Sum+El;
        end;
      ScanAver[i]:=Sum div X1;
     end;
      for i:=0 to Y1-1 do        //Lines (scans)
        for j:=0 to X1-1  do     // Rows
          begin
            Datmas[j,i]:=Datmas[j,i]-ScanAver[i]+Aver;
          end;
end;

procedure DelStepsY(Nx,Ny:integer; var datmas:TMas2; FileName:PChar); StdCall;
var Aver:integer;
     i,j:integer;
     X1,Y1,El,Sum:integer;
     ScanAver:TLine;  // type PLine is declared in GlobalDcl;
begin
  Aver:=0;
     if (NX > 0) and (NY > 0) then
     begin
          for j:=0 to NY-1 do
          begin
              for i:=0 to NX-1 do
               begin
                  Aver:=Aver+datmas[i,j];
               end;
          end;
          Aver:=round(Aver/NX/NY);
     end;
 X1:=NX;
 Y1:=NY;
       SetLength(ScanAver,X1);
     for j:=0 to X1-1 do        //Lines (scans)
     begin
      Sum:=0;
		 for i:=0 to Y1-1  do     // Rows
		    begin
	   		 El:=Datmas[j,i]; //Topo[X1*i1+i2];
   			 Sum:=Sum+El;
        end;
      ScanAver[j]:=Sum div Y1;
     end;
      for j:=0 to X1-1 do        //Lines (scans)
        for i:=0 to Y1-1  do     // Rows
          begin
            Datmas[j,i]:=Datmas[j,i]-ScanAver[j]+Aver;
          end;
end;
function vectorminus(v1,v2:Vector):Vector;
begin
 Result.x:=v1.x-v2.x;
 Result.y:=v1.y-v2.y;
 Result.z:=v1.z-v2.z;
end;

function vectorplus(v1,v2:Vector):Vector;
begin
 Result.x:=v1.x+v2.x;
 Result.y:=v1.y+v2.y;
 Result.z:=v1.z+v2.z;
end;

function vectormult(v1,v2:Vector):Vector;
begin
 Result.x:=v1.y*v2.z-v1.z*v2.y;
 Result.y:=v1.z*v2.x-v1.x*v2.z;
 Result.z:=v1.x*v2.y-v1.y*v2.x;
end;

function Normal(TopoCell:mcell; x,y,StepX,StepY:double):Vector;  stdcall;
var  v0,v1,v2,v3,v4,v5,v6,n1,n2,n3,n4,n5,n6,n:Vector;
begin
 v0.x:=x;
 v0.y:=y;
 v0.z:=(TopoCell[2,2]);
 v1.x:=x;
 v1.y:=y+StepY;
 v1.z:=TopoCell[1,2];
 v2.x:=x-StepX;
 v2.y:=y+StepY;
 v2.z:=TopoCell[1,1];
 v3.x:=x-StepX;
 v3.y:=y;
 v3.z:=TopoCell[2,1];
 v4.x:=x;
 v4.y:=y-StepY;
 v4.z:=TopoCell[3,2];
 v5.x:=x+StepX;
 v5.y:=y-StepY;
 v5.z:=TopoCell[3,3];
 v6.x:=x+StepX;
 v6.y:=y;
 v6.z:=TopoCell[2,3];
  v1:=vectorminus(v1,v0);
  v2:=vectorminus(v2,v0);
  v3:=vectorminus(v3,v0);
  v4:=vectorminus(v4,v0);
  v5:=vectorminus(v5,v0);
  v6:=vectorminus(v6,v0);
  n1:=vectormult(v1,v2);
  n2:=vectormult(v2,v3);
  n3:=vectormult(v3,v4);
  n4:=vectormult(v4,v5);
  n5:=vectormult(v5,v6);
  n6:=vectormult(v6,v1);
  n:=vectorplus(n1,n2);
  n:=vectorplus(n,n3);
  n:=vectorplus(n,n4);
  n:=vectorplus(n,n5);
  n:=vectorplus(n,n6);
 {n:=n1+n2+n3+n4+n5+n6;}
  Normal:=n;{ Normalize(n);}
end;

procedure Solv(neqn : integer;  var ptrmat : matrix; var work : massiv; var ipv : ipvmassiv);
var i,k,m : byte;
    t     : float;
begin
      for k:=1 to neqn-1 do
      begin
           m:=ipv[k];
              t:=work[m];
              work[m]:=work[k];
              work[k]:=t;
           for i:= k+1 to neqn do
                               work[i]:=work[i]+ptrmat[i][k]*t;
      end;

      for k:=neqn downto 2 do
      begin
            t:=work[k]/ptrmat[k][k];
            work[k]:=t;
            for i:=1 to k-1 do
                            work[i]:=work[i]-ptrmat[i][k]*t;
      end;

      work[1]:=work[1]/ptrmat[1][1];

end;   {Solv}

procedure Dcomp(neqn : integer;  var ptrmat : matrix; var cond : float;
                var work : massiv; var ipv : ipvmassiv);
var i,j,k,m : byte;
    ek,t,
    anorm,
    ynorm,
    znorm   : float;
begin
      ipv[neqn]:=1;
      if neqn = 1 then begin
                  if ptrmat[1][1] = 0.0E0 then begin
                                              cond:=1.0E+32;
                                              end
                                         else cond:=1.0E0;
                  exit;
                  end;

      {compute anorm}
      anorm:=0.0E0;
      for j:=1 to neqn do
                       begin
                           t:=0.0E0;
                           for i:=1 to neqn do t:=t+abs(ptrmat[i][j]);
                           if anorm < t then anorm:=t;
                       end;

      {Gauss decomposition}
      for k:=1 to neqn-1 do
                        begin
                        {find max element in row}
                             m:=k;
                             ek:=abs(ptrmat[k][k]);
                             for i:=k+1 to neqn do
                                        if abs(ptrmat[i][k]) > ek then
                                           begin
                                           ek:=abs(ptrmat[i][k]);
                                           m:=i;
                                           end;
                        if ek = 0.0E0 then begin
                                          cond:=1.0E+32;
                                          exit;
                                          end;
                        ipv[k]:=m;
                        if m <> k then
                                  for i:=k to neqn do begin
                                            t:=ptrmat[m][i];
                                            ptrmat[m][i]:=ptrmat[k][i];
                                            ptrmat[k][i]:=t;
                                            end;
                        ek:=ptrmat[k][k];
                        for i:=k+1 to neqn do begin
                                   {calculate multiples}
                                              t:=-ptrmat[i][k]/ek;
                                              ptrmat[i][k]:=t;
                                   {substraction}
                                              for j:=k+1 to neqn do
                                                  ptrmat[i][j]:=
                                                    ptrmat[i][j]+
                                                    t*ptrmat[k][j];
                                              end;

                       end;   {end of decomposition}

      {calculation of cond}

      {solv system : transp(ptrmat) * y = e   (e(i)= (+/-) 1 ) }

      {forward step}
      for k:=1 to neqn do
                       begin
                             t:=0.0E0;
                             for i:=1 to k-1 do t:=t+ptrmat[i][k]*work[i];
                             if t < 0.0E0 then ek:=-1.0E0 else ek:=+1.0E0;
                             work[k]:=-(ek+t)/ptrmat[k][k];
                       end;

      {backward step}
      for k:=neqn-1 downto 1 do
                             begin
                                  t:=0.0E0;
                                  ek:=work[k];
                                  for i:=k+1 to neqn do
                                             t:=t+ptrmat[i][k]*ek;
                                  m:=ipv[k];
                                  work[k]:=work[m];
                                  work[m]:=t;
                             end;

      ynorm:=0.0E0;
      for i:=1 to neqn do ynorm:=ynorm+abs(work[i]);

      {solv system : ptrmat * z = y }

      Solv(neqn,ptrmat,work,ipv);

      znorm:=0.0E0;
      for i:=1 to neqn do znorm:=znorm+abs(work[i]);

      {cond=}
      cond:=anorm*znorm/ynorm;
      if cond < 1.0E0 then cond:=1.0E0;

end;   {Dcomp}


procedure Dsolv (Dimen        : integer;
                 var Coefficients : matrix;
                 var Constants    : massiv;
                 var Solution     : massiv;
                 var Error : byte;
                 var Cond : float);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-                Input: Dimen, Coefficients, Constants                     -}
{-               Output: Solution, Error                                    -}
{-                                                                          -}
{-             Purpose : Calculate the solution of a linear set of          -}
{-                       equations using Gaussian elimination and           -}
{-                       backwards substitution.                            -}
{-                                                                          -}
{-                                                                          -}
{-    Global Variables : Dimen : integer; Dimension of the square  matrix   -}
{-                       Coefficients :  Square matrix                      -}
{-                       Constants    :  Constants of each equation         -}
{-                       Solution     : Unique solution to the equations    -}
{-                       Error        : integer;  Flags if something goes   -}
{-                                                wrong.                    -}
{-                                                                          -}
{-              Errors:  0: No errors;                                      -}
{-                       1: Dimen < 1                                       -}
{-                       2: no solution exists                              -}
{-                                                                          -}
{----------------------------------------------------------------------------}

var ipv  : ipvmassiv;
    i : integer;

begin
     if Dimen < 1 then begin error:=1; exit; end;

     Dcomp(Dimen,Coefficients,cond,Solution,ipv);
     if cond > 1.0E+30 then begin
                           error:=2;
                           for i:=1 to Dimen do Solution[i]:=0.0E0;
                           exit;
                           end;
     for i:=1 to Dimen do Solution[i]:=Constants[i];
     Solv(Dimen,Coefficients,Solution,ipv);
     error:=0;

end;

Procedure DelFiltLevel(NX,NY: integer; var p : Tmas2; FileName:PChar); stdcall;
var i, j : integer;
    iSf : integer;
 begin
    iSf:=p[0,0];
    for j:=0 to Nx-1 do
     for i:=0 to Ny-1 do    if p[j,i] < iSf then iSf := p[j,i];
       for j:=0 to Nx-1 do
         for i:=0 to Ny-1 do     p[j,i]:=p[j,i]-iSf;
 end; {DelFiltLevel}

 Procedure DelFiltLevelOne(NX,NY: integer; var p : Tmas2; FileName:PChar); stdcall;
var i, j : integer;
    iSf : integer;
 begin
    for j:=0 to Ny-1 do
    begin
     iSf:=p[0][j];
      for i:=0 to Nx-1 do p[i][j]:=p[i][j]-iSf;
    end;
 end; {DelFiltLevel}

Procedure DelFiltPlane(Nx, Ny : integer;var p : Tmas2; FileName:PChar) ;  stdcall;

var hlp, AF, AX, AY : extended;
    AFX, AFY, AXX, AYY : extended;
    A1, A2, A3 : extended;
    i1, i2, j1, j2, Nxt, Nyt : integer;
    i, j : integer;
    ISf : integer;
    ch : char;
begin
      i1:=0; i2:=Ny-1; j1:=0; j2:=Nx-1;
  
      Nxt:=Ny; Nyt:=Nx;

      AX:=0.0;
       for i:=i1 to i2 do AX:=AX+i;
      AX:=AX/Nxt;
      AXX:=0.0;
      for i:=i1 to i2 do AXX:=AXX+sqr(i-AX);
      AXX:=AXX/Nxt;
      AY:=0.0;
      for j:=j1 to j2 do AY:=AY+j;
      AY:=AY/Nyt;
      AYY:=0.0;
      for j:=j1 to j2 do AYY:=AYY+sqr(j-AY);
      AYY:=AYY/Nyt;
      AF:=0.0;
   for i:=i1 to i2 do
      begin
           hlp:=0.0;
           for j:=j1 to j2 do hlp:=hlp+p[j,i];
           AF:=AF+(hlp/Nyt);
      end;
      AF:=AF/Nxt;
      AFX:=0.0;
    for i:=i1 to i2 do
      begin
           hlp:=0.0;
           for j:=j1 to j2 do hlp:=hlp+(p[j,i]-AF);
           AFX:=AFX+(hlp/Nyt)*(i-AX);
      end;
      AFX:=AFX/Nxt;
      AFY:=0.0;
    for j:=j1 to j2 do
      begin
           hlp:=0.0;
           for i:=i1 to i2 do hlp:=hlp+(p[j,i]-AF);
           AFY:=AFY+(hlp/Nxt)*(j-AY);
      end;
      AFY:=AFY/Nyt;
      A3:=AF; A1:=AFX/AXX; A2:=AFY/AYY;
     for j:=0 to Nyt-1 do
      begin
           for i:=0 to Nxt-1 do
           begin
               isf:=round(A1*(i-AX) + A2*(j-AY) + A3);
               p[j,i]:=p[j,i] - isf;
           end;
      end;
     iSf:=round(p[j1,i1]);
    for j:=j1 to j2 do
     begin
         for i:=i1 to i2 do
         begin
             if p[j,i] < isf then isf := round(p[j,i]);
         end;
     end;
    for j:=0 to Nyt-1 do
     begin
        for i:=0 to Nxt-1 do
         begin
              p[j,i]:=p[j,i]-isf;
         end;
     end;
end; {DelFiltPlane}

Procedure DelFiltSurface(Nx1, Ny1, Nx2, Ny2 , NxMax, NyMax: integer; var p : Tmas2); stdcall;

var coef, coefx : float;
    CF, CX, CY : extended;
    CFX, CFY, CFXX, CFYY, CFXY : extended;
    CX2, CX3, CX4, CY2, CY3, CY4 : extended;
    A, AX, AY, AXX, AYY, AXY : extended;
    hlp, hlpX, hlpY : extended;
    i, j : integer;
    i1, i2, j1, j2, Nx, Ny : integer;
    Isf : integer;
    ch : char;

begin
      Nx:=NxMax; Ny:=NYMax;
      i1:=Nx1; i2:=Nx2; j1:=Ny1; j2:=Ny2;
      if i1 < 1 then i1:=1; if i2 > Nx then i2:=Nx;
      if j1 < 1 then j1:=1; if j2 > Ny then j2:=Ny;

      Nx:=(i2-i1)+1; Ny:=(j2-j1)+1;

      CX:=0.0;  for i:=i1 to i2 do CX:=CX+i;
      hlpX:=1.0/Nx; CX:=CX*hlpX;

      CX2:=0.0; CX3:=0.0; CX4:=0.0;
      for i:=i1 to i2 do
      begin
           hlp:=(i-CX);
           CX2:=CX2+sqr(hlp);
           CX3:=CX3+hlp*sqr(hlp);
           CX4:=CX4+sqr(sqr(hlp));
      end;
      CX2:=CX2*hlpX; CX3:=CX3*hlpX; CX4:=CX4*hlpX;

      CY:=0.0;  for j:=j1 to j2 do CY:=CY+j;
      hlpY:=1.0/Ny; CY:=CY*hlpY;

      CY2:=0.0; CY3:=0.0; CY4:=0.0;
      for j:=j1 to j2 do
      begin
           hlp:=(j-CY);
           CY2:=CY2+sqr(hlp);
           CY3:=CY3+hlp*sqr(hlp);
           CY4:=CY4+sqr(sqr(hlp));
      end;
      CY2:=CY2*hlpY; CY3:=CY3*hlpY; CY4:=CY4*hlpY;

      CF:=0.0;
      for i:=i1 to i2 do
      begin
           hlp:=0.0;
           for j:=j1 to j2 do hlp:=hlp+p[j,i];
           CF:=CF+(hlp/Ny);
      end;
      CF:=CF/Nx;

      CFX:=0.0; CFY:=0.0; CFXX:=0.0;  CFYY:=0.0;  CFXY:=0.0;
      for i:=i1 to i2 do
      begin
           for j:=j1 to j2 do
           begin
                hlp:=p[j,i]-CF;
                hlpX:=i-CX;
                hlpY:=j-CY;
                CFX:=CFX+hlp*hlpX;
                CFY:=CFY+hlp*hlpY;
                CFXX:=CFXX+hlp*sqr(hlpX);
                CFYY:=CFYY+hlp*sqr(hlpY);
                CFXY:=CFYY+hlp*hlpX*hlpY;
           end;
      end;
      hlp:=(1.0/Nx)/Ny; CFX:=CFX*hlp; CFY:=CFY*hlp;
      CFXX:=CFXX*hlp; CFYY:=CFYY*hlp; CFXY:=CFXY*hlp;

      AXY:=CFXY/(CX2*CY2);
      AXX:=(CFXX*CX2-CFX*CX3)/(CX2*CX4-CX2*CX2*CX2-CX3*CX3);
      AYY:=(CFYY*CY2-CFY*CY3)/(CY2*CY4-CY2*CY2*CY2-CY3*CY3);
      AX:=(CFX-AXX*CX3)/CX2;
      AY:=(CFY-AYY*CY3)/CY2;
      A:=CF-CX2*AXX-CY2*AYY;
    {
      OpenWnd(5, 5, 33, 14, 16*LightGray+Blue, 1,31,0,31,' Results ');
      OutStr(1,2,'  Axx = '+ConvReal(AXX*coef*sqr(coefx),8,4,true),-1,0);
      OutStr(1,3,'  Ayy = '+ConvReal(AYY*coef*sqr(coefx),8,4,true),-1,0);
      OutStr(1,4,'  Axy = '+ConvReal(AXY*coef*sqr(coefx),8,4,true),-1,0);
      OutStr(1,6,'  Ax  = '+ConvReal(AX*coef*coefx,8,4,true),-1,0);
      OutStr(1,7,'  Ay  = '+ConvReal(AY*coef*coefx,8,4,true),-1,0);
      OutStr(1,9,'  A   = '+ConvReal(A*coef,8,4,true),-1,0);
      OutStr(1,11,'  Press any key (Esc - exit)',-1,16*LightGray+White);

     }

      for j:=0 to Ny-1 do
      begin
         for i:=0 to Nx-1 do
         begin
              hlpX:=i-CX;
              hlpY:=j-CY;
              isf:=round(AXX*sqr(hlpX) + AYY*sqr(hlpY) + AXY*hlpX*hlpY
                         + AX*hlpX + AY*hlpY + A);
              p[j,i]:=p[j,i] - isf;
         end;
      end;

      iSf:=round(p[j1,i1]);
      for j:=j1 to j2 do
      begin
         for i:=i1 to i2 do
         begin
             if p[j,i] < isf then isf := round(p[j,i]);
         end;
      end;
      for j:=0 to Ny-1 do
      begin
         for i:=0 to Nx-1 do
         begin
              p[j,i]:=p[j,i]-isf;
         end;
      end;

end; {DelFiltSurface}

Procedure  AverageFilt3x3(Nx, Ny : integer;var p:Tmas2; FileName:PChar); stdcall;
var IP : array {[0..MaxDimTopo]} of single;
var i, j, IP2, IPH : integer;
    pz, qz, rz, zz : float;
    j1, j2, i1, i2 : integer;
    Kp, Kq, Kr : integer;

Function Average3(R1, R2, R3, R4, R5, R6, R7, R8, R9 : single ) : single;
var zz : float;
begin
    zz:=rz*R9;
    zz:=zz+pz*R1+pz*R2+pz*R3+pz*R4;
    zz:=zz+qz*R5+qz*R6+qz*R7+qz*R8;
    Average3:=round(zz);
end;
begin
      Kp:=0;
      Kq:=0;
      Kr:=0;
      SetLength(IP,Ny);
     i1:=0; j1:=0; i2:=Ny-1; j2:=Nx-1;
      IP2:=(4*Kp)+(4*Kq)+Kr;
   if IP2 = 0 then
     begin
         pz:=1.0/36.0; qz:=4.0/36.0; rz:=16.0/36.0;
     end
     else begin
         zz:=1.0/IP2; pz:=Kp*zz; qz:=Kq*zz; rz:=Kr*zz;
     end;

     if ((j2-j1+1) < 3) or ((i2-i1+1) < 3) then exit;

     for i:=i1 to i2 do IP[i]:=p[j1][i];

     for i:=i1+1 to i2-1 do
     begin
         p[j1][i]:=round(Average3(p[j1+1][i-1],p[j1+1][i+1],p[j1+1][i-1],p[j1+1][i+1],
                           IP[i-1],IP[i+1],p[j1+1][i],p[j1+1][i],
                           IP[i]));
     end;

     p[j1][i1]:=round(Average3(p[j1+1][i1+1],p[j1+1][i1+1],p[j1+1][i1+1],p[j1+1][i1+1],
                       IP[i1+1],IP[i1+1],p[j1+1][i1],p[j1+1][i1],
                       IP[i1]));
     p[j1][i2]:=round(Average3(p[j1+1][i2-1],p[j1+1][i2-1],p[j1+1][i2-1],p[j1+1][i2-1],
                        p[j1+1][i2],p[j1+1][i2],IP[i2-1],IP[i2-1],
                        IP[i2]));

     for j:=j1+1 to j2-1 do
     begin
          IP2:=p[j][i1];
          p[j][i1]:=round(Average3(IP[i1+1],p[j+1][i1+1],IP[i1+1],p[j+1][i1+1],
                            p[j][i1+1],p[j][i1+1],p[j+1][i1],IP[i1],
                            IP2));
          for i:=i1+1 to i2-1 do
          begin
               IPH:=round(Average3(IP[i-1],IP[i+1],p[j+1][i-1],p[j+1][i+1],
                            IP2,p[j][i+1],p[j-1][i],p[j+1][i],
                            p[j][i]));
               IP[i-1]:=IP2; IP2:=p[j][i]; p[j][i]:=IPH;
          end; {for i}
          IPH:=round(Average3(IP[i2-1],IP[i2-1],p[j+1][i2-1],p[j+1][i2-1],
                        IP2,IP2,p[j+1][i2],p[j-1][i2],
                        p[j][i2]));
          IP[i2-1]:=IP2; IP[i2]:=p[j][i2]; p[j][i2]:=IPH;
     end; {for j}

     IP2:=p[j2][1];

     p[j2][i1]:=round(Average3(p[j2-1][i1+1],p[j2-1][i1+1],p[j2-1][i1+1],p[j2-1][i1+1],
                        IP[i1],IP[i1],p[j2][i1+1],p[j2][i1+1],
                        IP2));

     for i:=i1+1 to i2-1 do
     begin
         IPH:=round(Average3(IP[i-1],IP[i+1],IP[i-1],IP[i+1],
                        IP2,IP[i],IP[i],p[j2][i+1],
                        p[j2][i]));
         IP[i-1]:=IP2; IP2:=p[j2][i];
         p[j2][i]:=IPH;
     end;

     p[j2][i2]:=round(Average3(IP[i2-1],IP[i2-1],IP[i2-1],IP[i2-1],
                         IP2,IP2,IP[i2],IP[i2],
                         p[j2][i2]));

      Finalize(IP);

end; {AverageFilt}


procedure MedianFilt3(Nx,Ny:integer; var p:Tmas2; FileName:PChar); stdcall;
 var
 	 IP:array{[0..MaxDimTopo]} of single;
	 IPP:array[0..9] of single;
	   IP2, IPH:single;
	 i2,j2:integer;
	   i, j, k,kk,j1,i1 :integer;

 begin
 i2:=Ny; j2:=Nx;
           SetLength(IP,I2);
		i1:=0; //i2:=TopoSPM.Ny;
		j1:=0; //j2:=TopoSPM.Nx;
   for i:=i1 to (i2-1) do begin IP[i]:=p[j1,i];end;

     for i:=i1+1 to (i2-2) do
	 begin
          IPP[0]:=IP[i-1];   IPP[1]:=IP[i];   IPP[2]:=IP[i+1];
          IPP[3]:=p[(j1+1),i-1]; IPP[4]:=p[(j1+1),i]; IPP[5]:=p[(j1+1),i+1];
         for kk:=0 to 5 do
		 begin
                  k:=kk-1; IPH:=IPP[kk];
              while ((k >= 0) and (IPP[k] > IPH))
			do begin IPP[k+1]:=IPP[k]; k:=k-1; end;
          IPP[k+1]:=IPH;
         end;//kk
       //
    p[j1,i]:=round(0.5*IPP[2]+0.5*IPP[3]);
	 end;//i

     IPP[0]:=IP[0]; IPP[1]:=p[j1+1,i1];
     IPP[2]:=IP[1]; IPP[3]:=p[j1+1,i1+1];
   for kk:=0 to 3 do
     begin
          k:=kk-1; IPH:=IPP[kk];
        while ((k >= 0) and (IPP[k] > IPH)) do
		  begin IPP[k+1]:=IPP[k]; k:=k-1;end;
          IPP[k+1]:=IPH;
     end;//kk
     p[j1,i1]:=round(0.5*IPP[1]+0.5*IPP[2]);
     IPP[0]:=IP[i2-1]; IPP[1]:=p[1,i2-1];
     IPP[2]:=IP[i2-2]; IPP[3]:=p[j1+1,i2-2];
   for kk:=0 to 3 do
     	 begin
                k:=kk-1; IPH:=IPP[kk];
          while ((k >= 0) and (IPP[k] > IPH)) do
		  begin IPP[k+1]:=IPP[k]; k:=k-1; end;
               IPP[k+1]:=IPH;
	 end;//kk
     p[j1,i2-1]:=round(0.5*IPP[1]+0.5*IPP[2]);

   for j:=j1+1 to (j2-2) do
     begin
          IP2:=p[j,i1];
          IPP[0]:=IP[i1];     IPP[1]:=IP[i1+1];
          IPP[2]:=p[j,i1];   IPP[3]:=p[j,i1+1];
          IPP[4]:=p[j+1,i1]; IPP[5]:=p[j+1,i1+1];
         for kk:=0 to 5 do
           begin
               k:=kk-1; IPH:=IPP[kk];
               while ((k >= 0) and (IPP[k] > IPH)) do
               begin
                    IPP[k+1]:=IPP[k]; k:=k-1;
               end;
               IPP[k+1]:=IPH;
          end;//kk
          p[j,i1]:=round(0.5*IPP[3]+0.5*IPP[4]);

        for i:=i1+1 to (i2-2) do
          begin
               IPP[0]:=p[j,i];
               IPP[1]:=IP[i-1];
               IPP[2]:=p[j+1,i+1];
               IPP[3]:=IP[i+1];
               IPP[4]:=p[j+1,i-1];
               IPP[5]:=IP2;
               IPP[6]:=p[j,i+1];
               IPP[7]:=IP[i];
               IPP[8]:=p[j+1,i];

               for kk:=0 to 8 do
                begin
				   k:=kk-1; IPH:=IPP[kk];
                    while ((k >= 0) and (IPP[k] > IPH) ) do
                    begin
                         IPP[k+1]:=IPP[k]; k:=k-1;
                    end;
                    IPP[k+1]:=IPH;
               end;


               IP[i-1]:=IP2; IP2:=p[j,i]; p[j,i]:=round(IPP[4]);
          end; //{for i}

          IPP[0]:=IP[i2-1];     IPP[1]:=IP[i2-2];
          IPP[2]:=p[j,i2-1];   IPP[3]:=IP2;
          IPP[4]:=p[j+1,i2-1]; IPP[5]:=p[j+1,i2-2];
          for kk:=0 to 5 do
           begin
               k:=kk-1; IPH:=IPP[kk];
               while ((k >= 0) and (IPP[k] > IPH) )    do
               begin
                    IPP[k+1]:=IPP[k]; k:=k-1;
               end;
               IPP[k+1]:=IPH;
           end;

          IP[i2-2]:=IP2; IP[i2-1]:=p[j,i2-1];
          p[j,i2-1]:=round(0.5*IPP[3]+0.5*IPP[4]);

     end; //{for j}

     IP2:=p[j2-1,0];

     IPP[0]:=IP2;      IPP[1]:=p[j2-1,1];
     IPP[2]:=IP[0];    IPP[3]:=IP[1];
     for kk:=0 to 3 do
     begin
          k:=kk-1; IPH:=IPP[kk];
          while ((k >= 0) and (IPP[k] > IPH))    do
          begin
               IPP[k+1]:=IPP[k]; k:=k-1;
          end;
          IPP[k+1]:=IPH;
     end;
     p[j2-1,0]:=round(0.5*IPP[1]+0.5*IPP[2]);

     for i:=i1+1 to i2-2 do
	 begin
         IPP[0]:=IP[i-1];    IPP[1]:=IP[i];    IPP[2]:=IP[i+1];
         IPP[3]:=IP2; IPP[4]:=p[j2-1,i]; IPP[5]:=p[j2-1,i+1];
         for kk:=0 to 5 do
         begin              k:=kk-1; IPH:=IPP[kk];
              while ((k >= 0) and (IPP[k] > IPH) )  do
                          begin
			   IPP[k+1]:=IPP[k]; k:=k-1; IPP[k+1]:=IPH;
                           end;
         end;

         IP[i-1]:=IP2; IP2:=p[j2-1,i];
         p[j2-1,i]:=round(0.5*IPP[2]+0.5*IPP[3]);

     end;//i

     IPP[0]:=IP2;         IPP[1]:=p[j2-1,i2-1];
     IPP[2]:=IP[i2-2];    IPP[3]:=IP[i2-1];
     for kk:=0 to 3 do
     begin
          k:=kk-1; IPH:=IPP[kk];
          while ((k >=0) and (IPP[k] > IPH))  do
		  begin IPP[k+1]:=IPP[k]; k:=k-1; end;
          IPP[k+1]:=IPH;
     end;
     p[j2-1,i2-1]:=round(0.5*IPP[1]+0.5*IPP[2]);
     Finalize(IP);
//
end;

Procedure LinDelFiltPlaneParm( Nx : integer;
                          var p : TLineSingle; var sfA:single; var sfB:single);  stdcall;
var i : integer;
     H, fA1, fA2, fB1, fB2, YY1, YY2 : single;
    i1, i2 : integer;
begin
      i1:=0; i2:=Nx-1;
         YY1:=0.0; YY2:=0.0; fA1:=0.0; fA2:=0.0; fB1:=0.0; fB2:=0.0;
      for i:=0 to Nx-1 do
        begin
            H:=p[i];
            YY1:=YY1+H; YY2:=YY2+H*(i-i1+1);
        end;
        YY1:=YY1/(Nx); YY2:=YY2/(Nx);
        fA1:=1.0; fA2:=0.5*(i2-i1+2);
        fB1:=fA2; fB2:=(i2-i1+2)*(2.0*(i2-i1)+3.0)/6.0;
        H:=fA1*fB2-fA2*fB1;
        if H=0 then h:=1;
        sfA:=(YY1*fB2-yy2*fA2)/H; sfB:=(YY2*fA1-YY1*fB1)/H;
  {    for i:=i1 to i2 do
        begin
            p[i]:=round(p[i]-sfA-sfB*(i-i1+1));
        end;}
  end; {DelFiltPlane}


end.
