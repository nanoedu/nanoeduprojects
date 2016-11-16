//200502
unit SurfaceTools;

interface
uses FourierProc;
 const maxMatr = 6;
  type massiv = array [1..maxMatr] of single;
       ipvmassiv = array [1..maxMatr] of integer;
       matrix = array [1..maxMatr] of massiv;
  type float=single;

 Procedure AverageFilt(Kp, Kq, Kr : integer;Nx, Ny : integer;var p:Tmas2);stdCall ; external 'surfTools.dll';

 procedure MedianFilt3(i2,j2:integer; var p:Tmas2); stdCall ; external 'surfTools.dll';

 Procedure DelFiltLevel(NX,NY: integer; var p : Tmas2);  StdCall ;external 'surfTools.dll';

// Procedure DelFiltSurface( Nx1, Ny1, Nx2, Ny2,  NxMax, NyMax : integer; var p : TMas2); StdCall ;external 'surfTools.dll';

 Procedure DelFiltPlane(Nx1, Ny1, Nx2, Ny2, NxMax, NyMax : integer;var p : Tmas2); StdCall ;external 'surfTools.dll';

// Procedure LinDelFiltPlaneParm( Nx : integer;var p : TLine; var sfA:single; var sfB:single);  StdCall ;external 'surfTools.dll';

// function  Normal(TopoCell:mcell; x,y,StepX,StepY:double):Vector;  stdcall;  external 'surfTools.dll';

 procedure DelSteps(flg:byte;Nx,Ny:integer; var datmas:TMas2);   stdcall; external 'surfTools.dll';

 implementation


end.
