//150207
unit SurfaceTools;

interface
uses GlobalType;
type
 TDataRect=record
    StartX,EndX ,
    StartY,EndY:smallint;
  end;

  ArrayOfDouble0   = array[0..$FFFFFF] of Double;
  PArrayOfDouble0   = ^ArrayOfDouble0;

  ArrayOfInteger0   = array[0..$FFFFFF] of Integer;
  PArrayOfInteger0   = ^ArrayOfInteger0;

  ArrayOfSmallInt0  = array[0..$FFFFFF]  of SmallInt;
  PArrayOfSmallInt0  = ^ArrayOfSmallInt0;


// Procedure AverageFilt(Kp, Kq, Kr : integer;Nx, Ny : integer;var p:Tmas2);stdCall ; external 'surfTools.dll';

 procedure AverageFilt3X3(Nx, Ny : integer;var p:Tmas2; FileName:PChar);   stdCall ; external 'surfTools.dll';

 procedure MedianFilt3(Nx,Ny:integer; var p:Tmas2; FileName:PChar);        stdCall ; external 'surfTools.dll';

 Procedure DelFiltLevel(Nx,Ny: integer; var p : Tmas2; FileName:PChar);    stdCall ;external 'surfTools.dll';

 procedure DelStepsX(Nx,Ny:integer; var p:TMas2; FileName:PChar);          stdcall; external 'surfTools.dll';

 procedure DelStepsY(Nx,Ny:integer; var p:TMas2; FileName:PChar);          stdcall; external 'surfTools.dll';

 procedure DelFiltLevelOne(Nx,Ny: integer; var p : Tmas2; FileName:PChar); stdcall; external 'surfTools.dll';

 procedure Del2xSurface(NX,NY: integer; var p : Tmas2; FileName:PChar);    stdcall; external 'surfTools.dll';

 procedure DelFiltPlane(Nx, Ny:integer; var p : Tmas2; FileName:PChar);    StdCall ;external 'surfTools.dll';

 procedure ExecuteFourierFiltrat(Nx, Ny:integer; var p : Tmas2;  FileName:Pchar);    StdCall ;external 'surfTools.dll';

//****
 function  Get2xSurfaceVector(pIn: pArrayOfSmallInt0; m_nx, m_ny:Integer; Window: TDataRect; a: pArrayOfDouble0): Boolean;   StdCall ;external 'surfTools.dll';
//Функция вычисляет коэффициенты наилучшего приближения для поверхности второго порядка a массив из 9 элементов
//Память под коэффициенты должна быь выделена до вызова функции
 procedure Subtract2xSurfaceByVector(pIn,pOut: pArrayOfSmallInt0; m_nx, m_ny:Integer; Window: TDataRect;a: pArrayOfDouble0);  StdCall ;external 'surfTools.dll';
///*******

(*
 function  GetSubtractPlaneVector(pIn: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect; var A,B,C: Double): Boolean; StdCall ;external 'surfTools.dll';

 procedure SubtractPlaneByVector(pIn,pOut: pArrayOfSmallInt0; m_nx, m_ny:Integer;Window: TDataRect; A,B,C: Double);  StdCall ;external 'surfTools.dll';

 function  SubtractPlane(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer): Boolean;  StdCall ;external 'surfTools.dll';
*)
 Procedure LinDelFiltPlaneParm( Nx : integer;var p : TLineSingle; var sfA:single; var sfB:single); StdCall ;external 'surfTools.dll';

 Procedure DelFiltSurface( Nx1, Ny1, Nx2, Ny2,  NxMax, NyMax : integer; var p : TMas2); StdCall ;external 'surfTools.dll';

 procedure Convolution(var Mas:TLineSingle;const Size,S:integer);        StdCall ;external 'surfTools.dll';

 function  Normal(const TopoCell:mcell; x,y,StepX,StepY:double):Vector;  stdcall;  external 'surfTools.dll';

implementation
(* Procedure LinDelFiltPlaneParm( Nx : integer;
                          var p : TLineSingle; var sfA:single; var sfB:single);
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
 *)
end.
