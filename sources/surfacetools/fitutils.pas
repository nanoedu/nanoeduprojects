//161104
unit fitutils;

interface

uses Globaltype ;
type
  TDataRect=record
    StartX,EndX ,
    StartY,EndY:smallint;
  end;

  ArrayOfDouble0   = array[0..$FFFFFF] of Double;
  PArrayOfDouble0   = ^ArrayOfDouble0;

  ArrayOfInteger0   = array[0..$FFFFFF] of Integer;
  PArrayOfInteger0   = ^ArrayOfInteger0;

  ArrayOfSmallInt0  = array[0..$FFFFFF] of SmallInt;
  PArrayOfSmallInt0  = ^ArrayOfSmallInt0;

  ArrayOfByte0 = array[0..$FFFFFF] of Byte;
  PArrayOfByte0=^ArrayOfByte0;

//Значение
//Отклонение
//Координата
  TPointFitInfo = record
    XVal: double;
    YVal: double;
    Error: double;
  end;
  ArrayOfPointFitInfo0=array[0..$FFFFFF] of TPointFitInfo;
  PArrayOfPointFitInfo0=^ArrayOfPointFitInfo0;

  ArrayOfDoublePointer0=array[0..$FFFFFF] of PArrayOfDouble0;
  PArrayOfDoublePointer0=^ArrayOfDoublePointer0;

  ArrayOfSmallIntPointer0=array[0..$FFFFFF] of PArrayOfSmallInt0;
  PArrayOfSmallIntPointer0=^ArrayOfSmallIntPointer0;

  TBasisFunction = procedure (XCoord: Double; BasisFuncsValues: pArrayOfDouble0; FuncsNum: Integer);

const
  SmallestPolyCoeff = 1E-10;
  DelPointsProIteration = 4;
  MaxIterationCount = 1;

function AllocDMatrix(var A: PArrayOfDoublePointer0; N,M:Integer): Boolean;
//  Функция выделяет память под матрицу A[0..N-1][0..M-1] N строк M столбцов
function FreeDMatrix(var A: PArrayOfDoublePointer0; N,M:Integer): Boolean;
//  Функция освобождает память матрицы A[0..N-1][0..M-1] N строк M столбцов

function GaussJordanElimination(A,B: PArrayOfDoublePointer0; N,M: Integer) : Boolean;
//Linear equation solution by Gauss-Jordan elimination, equation (2.1.1) above. a[0..N-1][0..N-1]
//is the input matrix. b[00..N-1][0..M-1] is input containing the m right-hand side vectors. On
//output, a is replaced by its matrix inverse, and b is replaced by the corresponding set of solution
//vectors.

//ma- степень полинома фитирования + 1
//ma = 1 - полином 0 степени

function LeastSquaresFit(x,y,sig: pArrayOfDouble0; ndat: Integer; a: PArrayOfDouble0; ia: PArrayOfInteger0;
		  ma : Integer; covar: PArrayOfDoublePointer0; var chisq: Double; funcs: TBasisFunction): Boolean;

//	Given a set of data points x[1..ndat], y[1..ndat] with individual standard deviations
//	sig[1..ndat], use x2 minimization to t for some or all of the coecients a[1..ma] of
//	a function that depends linearly on a, y = .i ai ?~ afunci(x). The input array ia[1..ma]
//	indicates by nonzero entries those components of a that should be tted for, and by zero entries
//	those components that should be held xed at their input values. The program returns values
//	for a[1..ma], x2 = chisq, and the covariance matrix covar[1..ma][1..ma]. (Parameters
//	held xed will return zero covariances.)Th e user supplies a routine funcs(x,afunc,ma) that
//	returns the ma basis functions evaluated at x = x in the array afunc[1..ma].
//
procedure polynombasis(x: Double; afunc: pArrayOfDouble0; m: Integer);

//1D Routines
function FastDoubleLSFit(x,y: pArrayOfDouble0; ndat: Integer; a: PArrayOfDouble0;ma : Integer; funcs: TBasisFunction): Boolean;
function FastSmallIntLSFit(y: pArrayOfSmallInt0; ndat: Integer; a: PArrayOfDouble0;ma : Integer): Boolean;
function FastSmallIntLSAreaFit(x,y: pArrayOfSmallInt0; ndat: Integer; a: PArrayOfDouble0;ma : Integer; funcs: TBasisFunction): Boolean;
function AdaptiveLSFit(y: pArrayOfSmallInt0; ndat: Integer; a: PArrayOfDouble0;ma : Integer): Boolean;
function AdaptiveDoubleLSFit(x,y: pArrayOfDouble0; ndat: Integer; a: PArrayOfDouble0;ma : Integer): Boolean;
function SubFittedData(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer; polyorder: Integer; Xfit,IgnoreOffset: Boolean):Boolean;

//2D Routines
function  GetSubtractPlaneVector(pIn: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect; var A,B,C: Double): Boolean;
procedure SubtractPlaneByVector(pIn,pOut: pArrayOfSmallInt0; m_nx, m_ny:Integer;Window: TDataRect; A,B,C: Double);
function  SubtractPlane(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer): Boolean;
function  SubtractPlaneByArea(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect): Boolean;
function  SubtractPlaneFromArea(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect): Boolean;
function  SubtractPlaneByMask(pIn, pOut: pArrayOfSmallInt0; pMask: PArrayOfByte0; m_nx, m_ny:Integer): Boolean;

procedure Del2xSurface(NX,NY: integer; var p : Tmas2; FileName:PChar);     StdCall;

function Get2xSurfaceVector(pIn: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect; a: pArrayOfDouble0): Boolean;   StdCall
//Функция вычисляет коэффициенты наилучшего приближения для поверхности второго порядка a массив из 9 элементов
//Память под коэффициенты должна быь выделена до вызова функции
procedure Subtract2xSurfaceByVector(pIn,pOut: pArrayOfSmallInt0; m_nx, m_ny:Integer; Window: TDataRect;a: pArrayOfDouble0);   StdCall
//Функция вычитает поверхность второго порядка с коэффициентами a, массива из 9 элементов
//z= a+bx+cy+dxy+ex^2+fy^2+gxy^2+hx^2y+iX^2y^2
function Subtract2xSurface(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer): Boolean;
function Subtract2xSurfaceByArea(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect): Boolean;
function Subtract2xSurfaceFromArea(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect): Boolean;
function Subtract2xSurfaceByMask(pIn, pOut: pArrayOfSmallInt0; pMask: PArrayOfByte0; m_nx, m_ny:Integer): Boolean;

function Subtract3xSurface(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer): Boolean;

function LimitToSmallint (aMinVal,aMaxVal:SmallInt;aVal:Double) : SmallInt;

implementation

uses Math,SysUtils;

function LimitToSmallint (aMinVal,aMaxVal:SmallInt;aVal:Double) : SmallInt;
 begin if aVal<aMinVal then Result:=aMinVal else if aVal>aMaxVal then Result:=aMaxVal else Result:=Round(aVal); end;

function AllocDMatrix(var A: PArrayOfDoublePointer0; N,M:Integer): Boolean;
//  Функция выделяет память под матрицу A[0..N-1][0..M-1]  N строк M столбцов
var
  i: Integer;
begin
  Result:=True;
  try
    GetMem(A, N*SizeOf(PArrayOfDouble0));
    for i:=0 to N-1 do GetMem(A^[i], M*SizeOf(Double));
  except
    Result:=False;
  end;
end;

function AllocD0Matrix(var A: PArrayOfDoublePointer0; N,M:Integer): Boolean;
//  Функция выделяет память под матрицу A[0..N-1][0..M-1]  N строк M столбцов
var
  i: Integer;
begin
  Result:=True;
  try             
    A:= AllocMem(N*SizeOf(PArrayOfDouble0));
    for i:=0 to N-1 do A^[i]:=AllocMem(M*SizeOf(Double));
  except
    Result:=False;
  end;
end;

function FreeDMatrix(var A: PArrayOfDoublePointer0; N,M:Integer): Boolean;
//  Функция освобождает память матрицы A[0..N-1][0..M-1] N строк M столбцов
var
  i: Integer;
begin
  try
    for i:=0 to N-1 do
      ReallocMem(A^[i],0);
    ReallocMem(A,0);
  except
    Result:=False;
  end;
end;


procedure polynombasis(x: Double; afunc: pArrayOfDouble0; m: Integer);
var
  i: Integer;
begin
	afunc^[0]:= 1;
  for i:=1 to m-1 do
    afunc^[i] :=afunc^[i-1]*x;
end;


function GaussJordanElimination(A,B: PArrayOfDoublePointer0; N,M: Integer) : Boolean;
var
	indxc,indxr,ipiv: PArrayOfInteger0;
  i,icol,irow,j,k,l,ll: Integer;
	big,dum,pivinv,swap : Double;
begin
  GetMem(indxc, N*SizeOf(Integer));
  GetMem(indxr, N*SizeOf(Integer));
  GetMem(ipiv,  N*SizeOf(Integer));
// The integer arrays ipiv, indxr, and indxc are used for bookkeeping on the pivoting.

  FillChar(ipiv^, N*SizeOf(Integer),0);

	for i:=0 to N-1 do
  begin //This is the main loop over the columns to be reduced.
		big := 0;

		for j:=0 to N-1 do
    begin //This is the outer loop of the search for a pivot element.
			if (ipiv^[j] <> 1) then
        for k:=0 to N-1 do
        begin
					if (ipiv^[k] = 0) then
          begin
						if (abs(a^[j]^[k]) >= big) then
            begin
							big := abs(a^[j]^[k]);
							irow := j;
							icol := k;
						end;
					end;
				end;
      end;

        ipiv^[icol]:=ipiv^[icol]+1;
				//	We now have the pivot element, so we interchange rows, if needed, to put the pivot
				//	element on the diagonal. The columns are not physically interchanged, only relabeled:
				//	indxc[i], the column of the ith pivot element, is the ith column that is reduced, while
				//	indxr[i] is the row in which that pivot element was originally located. If indxr[i] .=
				//	indxc[i] there is an implied column interchange. With this form of bookkeeping, the
				//	solution b’s will end up in the correct order, and the inverse matrix will be scrambled
				//	by columns.

				if (irow <> icol) then
        begin
					for l:=0 to N-1 do
          begin
            swap:=a^[irow]^[l];
            a^[irow]^[l]:= a^[icol]^[l];
            a^[icol]^[l]:= swap;
          end;      
          for l:=0 to M-1 do
          begin
            swap:= b^[irow]^[l];
            b^[irow]^[l]:=b^[icol]^[l];
            b^[icol]^[l]:=swap;
          end;
 				end;
               
				indxr^[i]:=irow; //We are now ready to divide the pivot row by the pivot element, located at irow and icol.
				indxc^[i]:=icol;

        if (a^[icol]^[icol] = 0.0) then
        begin
          Result:=False;

          FreeMem(ipiv);
          FreeMem(indxr);
          FreeMem(indxc);

          Exit;
        end;


				pivinv:= 1.0/a^[icol]^[icol];
				a^[icol]^[icol]:=1.0;


				for l:=0 to N-1 do a^[icol]^[l] := a^[icol]^[l] * pivinv;
				for l:=0 to M-1 do b^[icol]^[l] := b^[icol]^[l] * pivinv;

				for ll:=0 to N-1 do  //Next, we reduce the rows...
					if (ll <> icol) then //...except for the pivot one, of course.
          begin
						dum := a^[ll]^[icol];
						a^[ll]^[icol]:=0.0;
						for l:=0 to N-1 do a^[ll]^[l] := a^[ll]^[l] -a^[icol]^[l]*dum;
						for l:=0 to M-1 do b^[ll]^[l] := b^[ll]^[l] -b^[icol]^[l]*dum;
					end;
	end;
	//	This is the end of the main loop over columns of the reduction. It only remains to unscramble
	//	the solution in view of the column interchanges. We do this by interchanging pairs of
	//	columns in the reverse order that the permutation was built up.


	for l:= N-1 downto 0 do
  begin
		if (indxr^[l] <> indxc^[l]) then
			for k:=0 to N-1 do
      begin
        swap:= a^[k]^[indxr^[l]];
        a^[k]^[indxr^[l]] := a^[k]^[indxc^[l]];
        a^[k]^[indxc^[l]] := swap;
      end;
  // And we are done.
  end;
	FreeMem(ipiv);
	FreeMem(indxr);
	FreeMem(indxc);
 	Result:=True;
end;

procedure covsrt(covar: PArrayOfDoublePointer0; ma: Integer; ia: PArrayOfInteger0;mfit: Integer);
//
//Expand in storage the covariance matrix covar, so as to take into account parameters that are
//being held .xed. (For the latter, return zero covariances.)
//
var
  i,j,k: Integer;
  swap: Double;
begin
	for i:= mfit to ma-1 do
  begin
		for j:=0 to i-1 do
    begin
      covar^[i]^[j]:=0;
      covar^[j]^[i]:=0.0;
    end;
  end;
  k:=mfit-1;
  for j:= ma-1 downto 0 do
  begin
    if (ia^[j]>0) then
    begin
      for i:=0 to ma-1 do
      begin
        swap:=covar^[i]^[k];
        covar^[i]^[k]:=covar^[i]^[j];
        covar^[i]^[j]:=swap;
      end;
      for i:=0 to ma-1 do
      begin
         swap:= covar^[k]^[i];
         covar^[k]^[i]:=covar^[j]^[i];
         covar^[j]^[i]:= swap;
      end;
      Dec(k);
    end;
  end;
end;




function LeastSquaresFit(x,y,sig: pArrayOfDouble0; ndat: Integer; a: PArrayOfDouble0; ia: PArrayOfInteger0;
		  ma : Integer; covar: PArrayOfDoublePointer0; var chisq: Double; funcs: TBasisFunction): Boolean;

//
//  Given a set of data points x[1..ndat], y[1..ndat] with individual standard deviations
//  sig[1..ndat], use x2 minimization to t for some or all of the coecients a[1..ma] of
//	a function that depends linearly on a, y = .i ai ?~ afunci(x). The input array ia[1..ma]
//	indicates by nonzero entries those components of a that should be tted for, and by zero entries
//	those components that should be held xed at their input values. The program returns values
//	for a[1..ma], x2 = chisq, and the covariance matrix covar[1..ma][1..ma]. (Parameters
//	held xed will return zero covariances.)Th e user supplies a routine funcs(x,afunc,ma) that
//	returns the ma basis functions evaluated at x = x in the array afunc[1..ma].
//
var
  i,j,k,l,m, mfit: Integer;

  ym,wt,sum,sig2i: Double;
  beta: PArrayOfDoublePointer0;
  afunc: pArrayOfDouble0;
begin

  mfit:=0;
	AllocDMatrix(beta,ma,1);
	GetMem(afunc, ma*SizeOf(Double));

	for j:=0 to ma-1 do
    if (ia^[j]>0) then  Inc(mfit);

	if (mfit = 0) then
  begin
    Result:=False;
    FreeDMatrix(beta,ma,1);
    FreeMem(afunc);
    Exit;
  end;


	for j:=0  to mfit-1 do
  begin
			//Initialize the (symmetric)matrix.
			for k:=0 to mfit-1 do  covar^[j]^[k]:=0.0;
			beta^[j]^[0]:=0.0;
	end;

	for i:=0 to ndat-1 do
  begin
			//Loop over data to accumulate coecients of
			//the normal equations.
			funcs(x^[i],afunc,ma);
 			ym:=y^[i];
 			if (mfit < ma) then
      begin
				//Subtract of dependences on known pieces
				//of the fitting function.
				for j:=0 to ma-1 do
          if (ia^[j]=0) then ym := ym -a^[j]*afunc^[j];
      end;

      sig2i:=1.0/SQR(sig^[i]);

      j:=-1;

      for l:=0 to ma-1 do
      begin
        if (ia^[l]>0) then
        begin
            wt:=afunc^[l]*sig2i;
            Inc(j);
            k:=-1;
            for m:=0 to l do
              if (ia^[m]>0) then
              begin
                Inc(k);
                covar^[j]^[k] := covar^[j]^[k]+wt*afunc^[m];
              end;
            beta^[j]^[0] := beta^[j]^[0]+ym*wt;
        end;
      end;
    end;


		for j:=1 to mfit-1 do //Fill in above the diagonal from symmetry.
			for k:=0 to j-1 do     //Sic!!!!
				covar^[k]^[j]:=covar^[j]^[k];

    if (GaussJordanElimination(covar,beta,mfit,1)<>True) then  //Matrix solution.
    begin
      FreeDMatrix(beta,ma,1);
      FreeMem(afunc);
      Result:=False;
      Exit;
    end;
    j:=-1;
    for l:=0 to ma-1 do
      if (ia^[l]>0) then
      begin
        Inc(j);
        a^[l]:=beta^[j]^[0]; //Partition solution to appropriate coe.cients
      end;
    chisq:=0.0;

    for i:=0 to ndat-1 do
    begin
      //Evaluate x2 of the the fit
      funcs(x[i],afunc,ma);
      sum:=0.0;
      for j:=0 to ma-1 do
        sum := sum+ a^[j]*afunc^[j];
      chisq := chisq+ SQR((y^[i]-sum)/sig^[i]);
    end;
		covsrt(covar,ma,ia,mfit); //Sort covariance matrix to true order of fitting coefficients.

    FreeDMatrix(beta,ma,1);
    FreeMem(afunc);
    Result:=True;
end;

//
//That last call to a function covsrt is only for the purpose of spreading the
//covariances back into the full ma . ma covariance matrix, in the proper rows and
//columns and with zero variances and covariances set for variables which were
//held frozen.
//

function FastDoubleLSFit(x,y: pArrayOfDouble0; ndat: Integer; a: PArrayOfDouble0;ma : Integer; funcs: TBasisFunction): Boolean;
var
  i,j,k,l,m: Integer;

  ym,wt: Double;
  beta,covar : PArrayOfDoublePointer0;
  afunc: pArrayOfDouble0;
begin
	AllocD0Matrix(beta,ma,1);
  AllocD0Matrix(covar,ma,ma);
	GetMem(afunc, ma*SizeOf(Double));

	for i:=0 to ndat-1 do
  begin
			//Loop over data to accumulate coecients of
			//the normal equations.
			funcs(x^[i],afunc,ma);
 			ym:=y^[i];

      j:=-1;

      for l:=0 to ma-1 do
      begin
            wt:=afunc^[l];
            Inc(j);
            k:=-1;
            for m:=0 to l do
              begin
                Inc(k);
                covar^[j]^[k] := covar^[j]^[k]+wt*afunc^[m];
              end;
            beta^[j]^[0] := beta^[j]^[0]+ym*wt;
      end;
    end;


		for j:=1 to ma-1 do //Fill in above the diagonal from symmetry.
			for k:=0 to j-1 do
				covar^[k]^[j]:=covar^[j]^[k];

    if (GaussJordanElimination(covar,beta,ma,1)<>True) then
    begin //Matrix solution.
      FreeDMatrix(beta,ma,1);
      FreeDMatrix(covar,ma,ma);
      FreeMem(afunc);
      Result:=False;
      Exit;
    end;

    j:=-1;
    for l:=0 to ma-1 do
    begin
        Inc(j);
        a^[l]:=beta^[j]^[0]; //Partition solution to appropriate coe.cients
    end;

    FreeDMatrix(beta,ma,1);
    FreeDMatrix(covar,ma,ma);
    FreeMem(afunc);
    Result:=True;
end;

function FastSmallIntLSAreaFit(x,y: pArrayOfSmallInt0; ndat: Integer; a: PArrayOfDouble0;ma : Integer; funcs: TBasisFunction): Boolean;
var
  i,j,k,l,m: Integer;

  ym,wt: Double;
  beta,covar : PArrayOfDoublePointer0;
  afunc: pArrayOfDouble0;
begin
	AllocD0Matrix(beta,ma,1);
  AllocD0Matrix(covar,ma,ma);
	GetMem(afunc, ma*SizeOf(Double));

	for i:=0 to ndat-1 do
  begin
			//Loop over data to accumulate coecients of
			//the normal equations.
			funcs(x^[i],afunc,ma);
 			ym:=y^[i];

      j:=-1;

      for l:=0 to ma-1 do
      begin
            wt:=afunc^[l];
            Inc(j);
            k:=-1;
            for m:=0 to l do
              begin
                Inc(k);
                covar^[j]^[k] := covar^[j]^[k]+wt*afunc^[m];
              end;
            beta^[j]^[0] := beta^[j]^[0]+ym*wt;
      end;
    end;


		for j:=1 to ma-1 do //Fill in above the diagonal from symmetry.
			for k:=0 to j-1 do
				covar^[k]^[j]:=covar^[j]^[k];

    if (GaussJordanElimination(covar,beta,ma,1)<>True) then
    begin //Matrix solution.
      FreeDMatrix(beta,ma,1);
      FreeDMatrix(covar,ma,ma);
      FreeMem(afunc);
      Result:=False;
      Exit;
    end;

    j:=-1;
    for l:=0 to ma-1 do
    begin
        Inc(j);
        a^[l]:=beta^[j]^[0]; //Partition solution to appropriate coe.cients
    end;

    FreeDMatrix(beta,ma,1);
    FreeDMatrix(covar,ma,ma);
    FreeMem(afunc);
    Result:=True;
end;


function AdaptiveLSFit(y: pArrayOfSmallInt0; ndat: Integer; a: PArrayOfDouble0;ma : Integer): Boolean;
//Функция итерационно находит лучшее полиномиальное приближение входных данных, находит точки, наиболее удалённые от найденного полинома
//и исключает их из процесса фитирования.
var
  i,j,k,l,m: Integer;

  ym,wt: Double;
  beta,covar,pPolyFuncs : PArrayOfDoublePointer0;


//Число точек, учитываемых при фитировании
  ActivePointsCount: Integer;
  pDelPoint,pPointInfo: PArrayOfPointFitInfo0;
  pMaxErorPoint: TPointFitInfo;
  AlreadySelected: Boolean;
  FinalizeFitting: Boolean;
  PutIndex: Integer;
  IterCount: Integer;

  XValue, YValue: pArrayOfSmallInt0;
  PolyValue: pArrayOfDouble0;


begin
  GetMem(XValue, ndat*SizeOf(SmallInt));
  GetMem(YValue, ndat*SizeOf(SmallInt));
  GetMem(PolyValue, ndat*SizeOf(Double));

  GetMem(pDelPoint,DelPointsProIteration*SizeOf(TPointFitInfo));
  GetMem(pPointInfo,ndat*SizeOf(TPointFitInfo));

//ma- степень полинома фитирования + 1
//ma = 1 - полином 0 степени
  AllocDMatrix(pPolyFuncs,ndat,ma);
  for i:= 0 to ndat-1 do
    begin
    for j:= 0 to ma-1 do
        pPolyFuncs^[i]^[j]:= IntPower(i,j)
    end;

  for i:= 1 to ndat do
    XValue^[i-1]:=i;
  System.Move(y^, YValue^, ndat*SizeOf(SmallInt));





  ActivePointsCount:=ndat;
  FinalizeFitting:= False;
  IterCount:=0;
  repeat
    //Фитирование
    //проверка на True
    FastSmallIntLSAreaFit(XValue,YValue,ActivePointsCount,a,ma,polynombasis);
    //Построение полиномиальной кривой
    Inc(IterCount);
    for i:= 0 to ndat-1 do
    begin
      PolyValue^[i]:=0;
        for j:= 0 to ma-1 do
          PolyValue^[i]:=PolyValue^[i]+a^[j]*pPolyFuncs^[i]^[j];
    end;
  {
    Алгоритм удаления точек
    X[i], Y[i] - набор активных точек
    За итерацию удаляем DelCount точек c максимальным отклонением.
  }
    for i:= 0 to ActivePointsCount-1 do
    begin
      pPointInfo^[i].Error:=abs(YValue^[i]-PolyValue^[XValue^[i]]);
      pPointInfo^[i].XVal:=XValue^[i];
      pPointInfo^[i].YVal:=YValue^[i]
    end;



    pDelPoint^[0].XVal:=pPointInfo^[0].XVal;
    pDelPoint^[0].Error:=pPointInfo^[0].Error;
    pDelPoint^[0].YVal:=pPointInfo^[0].YVal;

    for i:=0 to DelPointsProIteration-1 do
    begin
  //!Sic Выбрать вместо 0 не пересекающийся с уже отобранными начальный индекс

      for j:= 1 to ActivePointsCount-1 do
        if pPointInfo^[j].Error > pDelPoint^[i].Error then
        begin
          AlreadySelected:= False;

          for k:= 0 to i-1 do
            if (j = pDelPoint^[k].XVal) then
            begin
              AlreadySelected:=True;
              Break;
            end;
          if  not AlreadySelected then
          begin
            pDelPoint^[i].XVal:=pPointInfo^[j].XVal;
            pDelPoint^[i].Error:=pPointInfo^[j].Error;
            pDelPoint^[i].YVal:=pPointInfo^[j].YVal;
          end;
        end; //pDelPoint^[j].Error > pDelPoint^[i].Error
      if i <> DelPointsProIteration-1 then
      begin
        l:=1;
        repeat
          for k:= 0 to i do
            if l = pDelPoint^[k].XVal then
            begin
              AlreadySelected:=True;
              Break;
            end;
          Inc(l);
        until not AlreadySelected;

        pDelPoint^[i+1].XVal:=pPointInfo^[l-1].XVal;
        pDelPoint^[i+1].Error:=pPointInfo^[l-1].Error;
        pDelPoint^[i+1].YVal:=pPointInfo^[l-1].YVal;
      end;
    end;

  //Удаление точек:
  for i:= ActivePointsCount-1 downto ActivePointsCount-DelPointsProIteration do  //Идём с конца по всем удаляемым точкам.
  begin
    PutIndex:=-1; //Индекс заполняемого элемента установлен на первый элемент, лежащий в пределах
                  //0.. ActivePointsCount-DelPointsProIteration
    Repeat
      Inc(PutIndex);
    Until  (PutIndex >  DelPointsProIteration-1) or
           (pDelPoint^[PutIndex].XVal < ActivePointsCount-DelPointsProIteration);

    If PutIndex < DelPointsProIteration then
      for j:= ActivePointsCount-1 downto ActivePointsCount-DelPointsProIteration do
      begin
        //Проверка, есть ли этот индекс в массиве удаляемых элементов (Поле: .XVal)
        //Если есть, то переход к следующей итерации цикла.
          XValue^[ Round(pDelPoint^[PutIndex].XVal)]:=Round(pPointInfo^[j].XVal);
          YValue^[ Round(pDelPoint^[PutIndex].XVal)]:=Round(pPointInfo^[j].YVal);
        repeat
          Inc(PutIndex)
        until (PutIndex >  DelPointsProIteration-1) or
                  (pDelPoint^[PutIndex].XVal < ActivePointsCount-DelPointsProIteration);
        if PutIndex < DelPointsProIteration then Break;
        //Все необходимые точки удалены. Оставшиеся находятся в зоне удаления
      end;
  end;
  ActivePointsCount:= ActivePointsCount-DelPointsProIteration;
  if ActivePointsCount <  DelPointsProIteration then
    FinalizeFitting:=True;
  if  ActivePointsCount < 30*ndat/100 then
    FinalizeFitting:=True;
  if pDelPoint^[0].Error/pDelPoint^[0].YVal*100 < 5 then
    FinalizeFitting:=True;
  if IterCount > MaxIterationCount then   FinalizeFitting:=True;
//  FinalizeFitting:= True;
  until FinalizeFitting;


  FreeMem(XValue);
  FreeMem(YValue);
  FreeMem(PolyValue);
  FreeMem(pDelPoint);
  FreeDMatrix(pPolyFuncs,ndat,ma);
end;


function AdaptiveDoubleLSFit(x,y: pArrayOfDouble0; ndat: Integer; a: PArrayOfDouble0;ma : Integer): Boolean;
//Функция итерационно находит лучшее полиномиальное приближение входных данных, находит точки, наиболее удалённые от найденного полинома
//и исключает их из процесса фитирования.
var
  i,j,k,l,m: Integer;

  ym,wt: Double;
  beta,covar,pPolyFuncs : PArrayOfDoublePointer0;


//Число точек, учитываемых при фитировании
  ActivePointsCount: Integer;
  pDelPoint,pPointInfo: PArrayOfPointFitInfo0;
  pMaxErorPoint: TPointFitInfo;
  AlreadySelected: Boolean;
  FinalizFitting: Boolean;
  PutIndex: Integer;
  IterCount: Integer;

  XValue, YValue: pArrayOfDouble0;
  PolyValue: pArrayOfDouble0;
  FinalizeFitting: Boolean;

begin
  GetMem(XValue, ndat*SizeOf(Double));
  GetMem(YValue, ndat*SizeOf(double));
  GetMem(PolyValue, ndat*SizeOf(Double));

  GetMem(pDelPoint,DelPointsProIteration*SizeOf(TPointFitInfo));
  GetMem(pPointInfo,ndat*SizeOf(TPointFitInfo));

//ma- степень полинома фитирования + 1
//ma = 1 - полином 0 степени
  AllocDMatrix(pPolyFuncs,ndat,ma);
  for i:= 0 to ndat-1 do
    begin
    for j:= 0 to ma-1 do
        pPolyFuncs^[i]^[j]:= IntPower(i+1,j)
    end;

  for i:= 1 to ndat do
    XValue^[i-1]:=i;
  System.Move(y^, YValue^, ndat*SizeOf(Double));





  ActivePointsCount:=ndat;
  FinalizeFitting:= False;
  IterCount:=0;
  repeat
    Inc(IterCount);
    //Фитирование
    //проверка на True
    FastDoubleLSFit(XValue,YValue,ActivePointsCount,a,ma,polynombasis);
    //Построение полиномиальной кривой

    for i:= 0 to ndat-1 do
    begin
      PolyValue^[i]:=0;
        for j:= 0 to ma-1 do
          PolyValue^[i]:=PolyValue^[i]+a^[j]*pPolyFuncs^[i]^[j];
    end;
  {
    Алгоритм удаления точек
    X[i], Y[i] - набор активных точек
    За итерацию удаляем DelCount точек c максимальным отклонением.
  }
    for i:= 0 to ActivePointsCount-1 do
    begin
      pPointInfo^[i].Error:=abs(YValue^[i]-PolyValue^[Round(XValue^[i])]);
      pPointInfo^[i].XVal:=XValue^[i];
      pPointInfo^[i].YVal:=YValue^[i]
    end;



    pDelPoint^[0].XVal:=pPointInfo^[0].XVal;
    pDelPoint^[0].Error:=pPointInfo^[0].Error;
    pDelPoint^[0].YVal:=pPointInfo^[0].YVal;

    for i:=0 to DelPointsProIteration-1 do
    begin
  //!Sic Выбрать вместо 0 не пересекающийся с уже отобранными начальный индекс
      for j:= 1 to ActivePointsCount-1 do
        if pPointInfo^[j].Error > pDelPoint^[i].Error then
        begin
          AlreadySelected:= False;

          for k:= 0 to i-1 do
            if (j = pDelPoint^[k].XVal-1) then
            begin
              AlreadySelected:=True;
              Break;
            end;
          if  not AlreadySelected then
          begin
            pDelPoint^[i].XVal:=pPointInfo^[j].XVal;
            pDelPoint^[i].Error:=pPointInfo^[j].Error;
            pDelPoint^[i].YVal:=pPointInfo^[j].YVal;
          end;
        end; //pDelPoint^[j].Error > pDelPoint^[i].Error


      //Поиск начального элемента сравнения, ля поиска максимума, не входящие в уже найденные
      if i <> DelPointsProIteration-1 then
      begin
        l:=1;
        AlreadySelected:= False;
        repeat
          for k:= 0 to i do
            if (l = pDelPoint^[k].XVal) then
            begin
              AlreadySelected:=True;
              Break;
            end;
          Inc(l);
        until not AlreadySelected;

        pDelPoint^[i+1].XVal:=pPointInfo^[l].XVal;
        pDelPoint^[i+1].Error:=pPointInfo^[l].Error;
        pDelPoint^[i+1].YVal:=pPointInfo^[l].YVal;
      end;
    end;
  //Удаление точек:
  for i:= ActivePointsCount-1 downto ActivePointsCount-DelPointsProIteration do  //Идём с конца по всем удаляемым точкам.
  begin
    PutIndex:=-1; //Индекс заполняемого элемента установлен на первый элемент, лежащий в пределах
                  //0.. ActivePointsCount-DelPointsProIteration
    Repeat
      Inc(PutIndex);
    Until  (PutIndex >  DelPointsProIteration-1) or
           (pDelPoint^[PutIndex].XVal < ActivePointsCount-DelPointsProIteration);

    If PutIndex < DelPointsProIteration then
      for j:= ActivePointsCount-1 downto ActivePointsCount-DelPointsProIteration do
      begin
        //Проверка, есть ли этот индекс в массиве удаляемых элементов (Поле: .XVal)
        //Если есть, то переход к следующей итерации цикла.
          XValue^[ Round(pDelPoint^[PutIndex].XVal)]:=pPointInfo^[j].XVal;
          YValue^[ Round(pDelPoint^[PutIndex].XVal)]:= pPointInfo^[j].YVal;
        repeat
          Inc(PutIndex)
        until (PutIndex >  DelPointsProIteration-1) or
                  (pDelPoint^[PutIndex].XVal < ActivePointsCount-DelPointsProIteration);
        if PutIndex < DelPointsProIteration then Break;
        //Все необходимые точки удалены. Оставшиеся находятся в зоне удаления
      end;
  end;
  ActivePointsCount:= ActivePointsCount-DelPointsProIteration;
  if ActivePointsCount <  DelPointsProIteration then
    FinalizeFitting:=True;
  if  ActivePointsCount < 30*ndat/100 then
    FinalizeFitting:=True;
  if pDelPoint^[0].Error/pDelPoint^[0].YVal*100 < 5 then
    FinalizeFitting:=True;
  if IterCount > MaxIterationCount then   FinalizeFitting:=True;
//  FinalizeFitting:= True;
  until FinalizeFitting;


  FreeMem(XValue);
  FreeMem(YValue);
  FreeMem(PolyValue);
  FreeMem(pDelPoint);
  FreeDMatrix(pPolyFuncs,ndat,ma);
end;


//ma- степень полинома фитирования + 1
//ma = 1 - полином 0 степени



function FastSmallIntLSFit(y: pArrayOfSmallInt0; ndat: Integer; a: PArrayOfDouble0;ma : Integer): Boolean;
var
  i,j,k,l,m: Integer;
  ym,wt: Double;
  beta,covar : PArrayOfDoublePointer0;
  afunc: pArrayOfDouble0;
begin
	AllocD0Matrix(beta,ma,1);
  AllocD0Matrix(covar,ma,ma);
	GetMem(afunc, ma*SizeOf(Double));
  afunc^[0]:= 1;
	for i:=0 to ndat-1 do
  begin
			//Loop over data to accumulate coecients of
			//the normal equations.
      for j:=1 to ma-1 do
        afunc^[j] :=afunc^[j-1]*i;

 			ym:=y^[i];

      j:=-1;

      for l:=0 to ma-1 do
      begin
            wt:=afunc^[l];
            Inc(j);
            k:=-1;
            for m:=0 to l do
              begin
                Inc(k);
                covar^[j]^[k] := covar^[j]^[k]+wt*afunc^[m];
              end;
            beta^[j]^[0] := beta^[j]^[0]+ym*wt;
      end;
    end;


		for j:=1 to ma-1 do //Fill in above the diagonal from symmetry.
			for k:=0 to j-1 do
				covar^[k]^[j]:=covar^[j]^[k];

    if (GaussJordanElimination(covar,beta,ma,1)<>True) then //Matrix solution.
    begin
      FreeDMatrix(beta,ma,1);
      FreeDMatrix(covar,ma,ma);
      FreeMem(afunc);
      Result:=False;
      Exit;
    end;;

    j:=-1;
    for l:=0 to ma-1 do
    begin
        Inc(j);
        a^[l]:=beta^[j]^[0]; //Partition solution to appropriate coe.cients
    end;

    FreeDMatrix(beta,ma,1);
    FreeDMatrix(covar,ma,ma);
    FreeMem(afunc);
    Result:=True;
end;


function SubFittedData(pIn,pOut: pArrayOfSmallInt0;m_nx,m_ny:Integer; polyorder: Integer; Xfit,IgnoreOffset: Boolean): Boolean;
var
  a: pArrayOfDouble0;
  pPolyFuncs: PArrayOfDoublePointer0;
  sum: Double;
  pColumn: ParrayOfSmallInt0;
  i,j,k: Integer;
begin
  GetMem(a, (polyorder+1)*Sizeof(Double));

  if Xfit then
  begin
    AllocDMatrix(pPolyFuncs,m_nx,polyorder+1);

    for i:= 0 to m_nx-1 do
    begin
    for j:= 0 to polyorder do
        pPolyFuncs^[i]^[j]:= IntPower(i,j)
    end;

    for k:= 0 to m_ny-1 do
    begin
      FastSmallIntLSFit(Pointer(Integer(pIn)+k*m_nx*SizeOf(SmallInt)),m_nx,a,polyorder+1);
      if IgnoreOffset then a^[0]:=0;
      for i:= 0 to m_nx-1 do
      begin
        sum:=0;
        for j:= 0 to polyorder do
           sum:=sum+a^[j]*pPolyFuncs^[i]^[j];
        pOut^[k*m_nx+i]:= LimitToSmallint(-32768, 32767,pIn^[k*m_nx+i]-sum);
      end;
    end;
    FreeDMatrix(pPolyFuncs,m_nx,polyorder+1);
  end
  else //YFIT
  begin
      AllocDMatrix(pPolyFuncs,m_ny,polyorder+1);
      GetMem(pColumn,m_ny*SizeOf(SmallInt));
        for i:= 0 to m_ny-1 do
        begin
         for j:= 0 to polyorder do
            pPolyFuncs^[i]^[j]:= IntPower(i,j)
        end;

        for k:= 0 to m_nx-1 do
        begin
          for i:=0 to m_ny-1 do
            pColumn^[i]:=pIn^[i*m_nx+k];

          FastSmallIntLSFit(pColumn,m_ny,a,polyorder+1);
          if IgnoreOffset then a^[0]:=0;
          for i:= 0 to m_ny-1 do
            begin
              sum:=0;
              for j:= 0 to polyorder do
                 sum:=sum+a^[j]*pPolyFuncs^[i]^[j];

              pOut^[i*m_nx+k]:= LimitToSmallint(-32768, 32767,pIn^[i*m_nx+k]-sum);
            end;
        end;
        FreeDMatrix(pPolyFuncs,m_ny,polyorder+1);
        FreeMem(pColumn);
  end;
  FreeMem(a);
  Result:=True;
end;

function SubtractPlane(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer): Boolean;
var
  A,B,C: Double;
  FullWindow: TDataRect;
begin
  result:=True;
  FullWindow.StartX:=0;
  FullWindow.EndX:=m_nx-1;
  FullWindow.StartY:=0;
  FullWindow.EndY:=m_ny-1;

  if GetSubtractPlaneVector(pIn, m_nx, m_ny,FullWindow, A,B,C)
  then
    SubtractPlaneByVector(pIn, pOut, m_nx, m_ny,FullWindow,A,B,C)
  else
  begin
    Result:=False;
    System.Move(pIn^, pOut^, m_nx*m_ny*sizeOf(SmallInt))
  end;
end;


function SubtractPlaneByArea(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect): Boolean;
var
  A,B,C: Double;
  k: Integer;
  FullWindow: TDataRect;
begin
  result:=True;
  FullWindow.StartX:=0;
  FullWindow.EndX:=m_nx-1;
  FullWindow.StartY:=0;
  FullWindow.EndY:=m_ny-1;
  if GetSubtractPlaneVector(pIn, m_nx, m_ny,Window, A,B,C)
  then
    SubtractPlaneByVector(pIn, pOut, m_nx, m_ny,FullWindow,A,B,C)
  else
  begin
    Result:=False;
    System.Move(pIn^, pOut^, m_nx*m_ny*sizeOf(SmallInt))
  end;
end;

function SubtractPlaneFromArea(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect): Boolean;
var
  A,B,C: Double;
  k: Integer;
begin
  result:=True;
  if GetSubtractPlaneVector(pIn, m_nx, m_ny,Window, A,B,C)
  then
    SubtractPlaneByVector(pIn, pOut, m_nx, m_ny,Window,A,B,C)
  else
  begin
    Result:=False;
    System.Move(pIn^, pOut^, m_nx*m_ny*sizeOf(SmallInt))
  end;
end;



function GetSubtractPlaneVector(pIn: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect; var A,B,C: Double): Boolean;
var
  i,j,k: Integer;
  Am,Bm: PArrayOfDoublePointer0;
  SII, SIJ, SI, SJJ,SJ,SYI, SYJ, SY: Extended;
  WWidth, WHeight: Integer;
begin
  //SI:=0;SII:=0;
  SIJ:=0; SYI:=0;
  //SJ:=0;  SJJ:=0;
  SYJ:=0; SY:=0;

  if Window.StartX > Window.EndX then
  begin
    k:=Window.StartX;
    Window.StartX:=Window.EndX;
    Window.EndX := k;
  end;
  if Window.StartY > Window.EndY then
  begin
    k:=Window.StartY;
    Window.StartY:=Window.EndY;
    Window.EndY := k;
  end;
  if Window.StartX < 0 then Window.StartX :=0;
  if Window.StartY < 0 then Window.StartY :=0;
  if Window.EndX > m_nx-1 then Window.EndX := m_nx-1;
  if Window.EndY > m_ny-1 then Window.EndY := m_ny-1;


  WWidth:= Window.EndX - Window.StartX+1;
  WHeight:= Window.EndY - Window.StartY+1;

  SI:= (1+WWidth)/2*WWidth;
  SJ:= (1+WHeight)/2*WHeight;
{
  if WHeight > WWidth then
  begin
    for i:= 1 to WWidth do
      SII:=SII+i*i;
    SJJ:=SII;
    for j:= WWidth+1 to WHeight do
      SJJ:=SJJ+j*j;
  end
  else
  begin
    for j:= 1 to WHeight do
      SJJ:=SJJ+j*j;
    SII:=SJJ;
    for i:= WHeight+1 to WWidth do
      SII:=SII+i*i;
  end;    }

  SII:=WWidth*(WWidth+1)/6*(2*WWidth+1); //Summ(X`2) ot 1 do WWidth
  SJJ:= WHeight*(WHeight+1)/6*(2*WHeight+1);


  for j:=1 to WHeight do
    for i:= 1 to WWidth do
    begin
      SIJ:=SIJ+i*j;
      SYI:=SYI+pIn^[Window.StartX+i-1+(Window.StartY+j-1)*m_nx]*i;
      SYJ:=SYJ+pIn^[Window.StartX+i-1+(Window.StartY+j-1)*m_nx]*j;
      SY:=SY+pIn^[Window.StartX+i-1+(Window.StartY+j-1)*m_nx];
    end;

  SII:= SII*WHeight;
  SI:= SI*WHeight;
  SJJ:=SJJ*WWidth;
  SJ:=SJ*WWidth;

  AllocDMatrix(Am,3,3);
  AllocDMatrix(Bm,3,1);


  Am^[0]^[0]:=SII;    Am^[0]^[1]:=SIJ;   Am^[0]^[2]:=SI;
  Am^[1]^[0]:=SIJ;    Am^[1]^[1]:=SJJ;   Am^[1]^[2]:=SJ;
  Am^[2]^[0]:=SI;     Am^[2]^[1]:=SJ;    Am^[2]^[2]:=WWidth*WHeight;

  Bm^[0]^[0]:= SYI;
  Bm^[1]^[0]:= SYJ;
  Bm^[2]^[0]:= SY;


  if (GaussJordanElimination(Am,Bm,3,1)<>True) then  //Bad matrix solution.
    begin
      FreeDMatrix(Am,3,3);
      FreeDMatrix(Bm,3,1);
      A:=0;
      B:=0;
      C:=0;
      Result:=False;
      Exit;
    end;
  A:= Bm^[0]^[0];
  B:= Bm^[1]^[0];
  C:= Bm^[2]^[0];

  FreeDMatrix(Am,3,3);
  FreeDMatrix(Bm,3,1);
  result:=True;
end;

procedure SubtractPlaneByVector(pIn,pOut: pArrayOfSmallInt0; m_nx, m_ny:Integer;Window: TDataRect; A,B,C: Double);
var
  i,j,k: Integer;
begin
  if Window.StartX > Window.EndX then
  begin
    k:=Window.StartX;
    Window.StartX:=Window.EndX;
    Window.EndX := k;
  end;
  if Window.StartY > Window.EndY then
  begin
    k:=Window.StartY;
    Window.StartY:=Window.EndY;
    Window.EndY := k;
  end;
  if Window.StartX < 0 then Window.StartX :=0;
  if Window.StartY < 0 then Window.StartY :=0;
  if Window.EndX > m_nx-1 then Window.EndX := m_nx-1;
  if Window.EndY > m_ny-1 then Window.EndY := m_ny-1;


  for j:=Window.StartY to Window.EndY do
  begin
    for i:=Window.StartX to Window.EndX do
      begin
        k:= j*m_nx+i;
        pOut^[k]:=
        LimitToSmallint(-32768	,32767,
          pIn^[k]- A*(i+1)-B*(j+1)-C);
      end
  end;
end;

function SubtractPlaneByMask(pIn, pOut: pArrayOfSmallInt0; pMask: PArrayOfByte0; m_nx, m_ny:Integer): Boolean;
var
  i,j: Integer;
  Am,Bm: PArrayOfDoublePointer0;
  SII, SIJ, SI, SJJ,SJ,SYI, SYJ, SY: Extended;
  PointsNum: Integer;
  FullWindow: TDataRect;
begin
  FullWindow.StartX:=0;
  FullWindow.EndX:=m_nx-1;
  FullWindow.StartY:=0;
  FullWindow.EndY:=m_ny-1;

  SII:=0; SIJ:=0;
  SI:=0;  SJJ:=0;
  SJ:=0;  SYI:=0;
  SYJ:=0; SY:=0;
  PointsNum:=0;

  for j:=1 to m_ny do
    for i:= 1 to m_nx do
    begin
      if pMask^[i-1+(j-1)*m_nx] = 0 then
        Continue;

      SII:=SII+i*i;
      SI:=SI+I;
      SJJ:=SJJ+j*j;
      SJ:=SJ+J;
      PointsNum:=PointsNum+1;
      SIJ:=SIJ+i*j;
      SYI:=SYI+pIn^[i-1+(j-1)*m_nx]*i;
      SYJ:=SYJ+pIn^[i-1+(j-1)*m_nx]*j;
      SY:=SY+pIn^[i-1+(j-1)*m_nx];
    end;

  AllocDMatrix(Am,3,3);
  AllocDMatrix(Bm,3,1);


  Am^[0]^[0]:=SII;    Am^[0]^[1]:=SIJ;   Am^[0]^[2]:=SI;
  Am^[1]^[0]:=SIJ;    Am^[1]^[1]:=SJJ;   Am^[1]^[2]:=SJ;
  Am^[2]^[0]:=SI;     Am^[2]^[1]:=SJ;    Am^[2]^[2]:=PointsNum;

  Bm^[0]^[0]:= SYI;
  Bm^[1]^[0]:= SYJ;
  Bm^[2]^[0]:= SY;


  if (GaussJordanElimination(Am,Bm,3,1)<>True) then  //Bad matrix solution.
    begin
      FreeDMatrix(Am,3,3);
      FreeDMatrix(Bm,3,1);
      System.Move(pIn^, pOut^, m_nx*m_ny*sizeOf(SmallInt));
      Result:=False;
      Exit;
    end;
  SubtractPlaneByVector(pIn,pOut, m_nx, m_ny, FullWindow,Bm^[0]^[0],Bm^[1]^[0],Bm^[2]^[0]);
  FreeDMatrix(Am,3,3);
  FreeDMatrix(Bm,3,1);
  result:=True;
end;



procedure SecondOrderBasis(XIndex, YIndex: Integer; BasisFuncs:pArrayOfDouble0);
begin
  BasisFuncs^[0]:=1;
  BasisFuncs^[1]:=XIndex;
  BasisFuncs^[2]:=YIndex;
  BasisFuncs^[3]:=XIndex*YIndex;
  BasisFuncs^[4]:=XIndex*XIndex;
  BasisFuncs^[5]:=YIndex*YIndex;
  BasisFuncs^[6]:=XIndex*BasisFuncs^[5];
  BasisFuncs^[7]:=YIndex*BasisFuncs^[4];
  BasisFuncs^[8]:=BasisFuncs^[4]*BasisFuncs^[5];
end;




function Get2xSurfaceVector(pIn: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect; a: pArrayOfDouble0): Boolean;
//Функция вычисляет коэффициенты наилучшего приближения для поверхности второго порядка a массив из 9 элементов
var
  i,j,k,l,m,p: Integer;
  ym,wt,z, zadd: Double;
  beta,covar : PArrayOfDoublePointer0;
  afunc: pArrayOfDouble0;
  WWidth, WHeight: Integer;
begin
  if Window.StartX > Window.EndX then
  begin
    k:=Window.StartX;
    Window.StartX:=Window.EndX;
    Window.EndX := k;
  end;
  if Window.StartY > Window.EndY then
  begin
    k:=Window.StartY;
    Window.StartY:=Window.EndY;
    Window.EndY := k;
  end;
  if Window.StartX < 0 then Window.StartX :=0;
  if Window.StartY < 0 then Window.StartY :=0;
  if Window.EndX > m_nx-1 then Window.EndX := m_nx-1;
  if Window.EndY > m_ny-1 then Window.EndY := m_ny-1;


  WWidth:= Window.EndX - Window.StartX+1;
  WHeight:= Window.EndY - Window.StartY+1;
  Result:=True;

 	AllocD0Matrix(beta,9,1);
  AllocD0Matrix(covar,9,9);
	GetMem(afunc, 9*SizeOf(Double));

  for p:=Window.StartY to Window.EndY do
    for i:=Window.StartX to Window.EndX do
    begin
        SecondOrderBasis(i, p,afunc);
        ym:=pIn^[i+p*m_nx];

        j:=-1;

        for l:=0 to 8 do
        begin
              wt:=afunc^[l];
              Inc(j);
              k:=-1;
              for m:=0 to l do
                begin
                  Inc(k);
                  covar^[j]^[k] := covar^[j]^[k]+wt*afunc^[m];
                end;
              beta^[j]^[0] := beta^[j]^[0]+ym*wt;
        end;
      end;


		for j:=1 to 8 do //Fill in above the diagonal from symmetry.
			for k:=0 to j-1 do
				covar^[k]^[j]:=covar^[j]^[k];

    if (GaussJordanElimination(covar,beta,9,1)<>True) then
    begin //Matrix solution.
      FreeDMatrix(beta,9,1);
      FreeDMatrix(covar,9,9);
      FreeMem(afunc);
      FillChar(a^,9*SizeOf(Double),0);
      Result:=False;
      Exit;
    end;

    j:=-1;
    for l:=0 to 8 do
    begin
        Inc(j);
        a^[l]:=beta^[j]^[0]; //Partition solution to appropriate coe.cients
    end;

    FreeDMatrix(beta,9,1);
    FreeDMatrix(covar,9,9);
    FreeMem(afunc);
    Result:=True;
end;



procedure Subtract2xSurfaceByVector(pIn,pOut: pArrayOfSmallInt0; m_nx, m_ny:Integer;Window: TDataRect; a: pArrayOfDouble0);
//Функция вычитает поверхность второго порядка с коэффициентами a, массива из 9 элементов
//z= a+bx+cy+dxy+ex^2+fy^2+gxy^2+hx^2y+iX^2y^2
var
  i,p: Integer;
  z,zadd,ym,wt: double;
begin
  if Window.StartX > Window.EndX then
  begin
    p:=Window.StartX;
    Window.StartX:=Window.EndX;
    Window.EndX := p;
  end;
  if Window.StartY > Window.EndY then
  begin
    p:=Window.StartY;
    Window.StartY:=Window.EndY;
    Window.EndY := p;
  end;
  if Window.StartX < 0 then Window.StartX :=0;
  if Window.StartY < 0 then Window.StartY :=0;
  if Window.EndX > m_nx-1 then Window.EndX := m_nx-1;
  if Window.EndY > m_ny-1 then Window.EndY := m_ny-1;

  for p:=Window.StartY to Window.EndY do
  begin
    ym:=p*p;
    z:=a^[0]+a^[2]*p+a^[5]*ym;
    for i:=Window.StartX to Window.EndX do
    begin
      wt:=i*i;
      zadd:=a^[1]*i+ a^[3]*i*p+ a^[4]*wt+ a^[6]*i*ym+
      a^[7]*wt*p+a^[8]*wt*ym;

      // zadd:=a^[1]*i+a^[3]*i*p+a^[4]*i*i+a^[6]*i*p*p+
      //  a^[7]*i*i*p+a^[8]*i*i*p*p;
       pOut^[i+p*m_nx]:= LimitToSmallint(-32768	,32767,
        pIn^[i+p*m_nx]- z-zadd);
    end;
  end;
end;

procedure Del2xSurface(NX,NY: integer; var p : Tmas2; FileName:PChar);
var
       a:PArrayofDouble0;
DataOneD:PArrayOfSmallInt0;
DataW: TDataRect;
k,i,j:integer;
begin
 with dataW do
 begin
   StartX:=0;
   EndX:=NX-1;
   StartY:=0;
   EndY:=NY-1;
 end;
 GetMem(a,9*sizeof(double));
 GetMem(DataOneD,NX*NY*sizeof(smallint));

 k:=0;
for i:=0 to  NY-1 do
 for j:=0 to  NX-1 do
 begin
  DataOneD[k]:=p[j,i];
  inc(k);
 end;
  Get2xSurfaceVector(DataOneD,Nx,Ny, dataW, a);
  Subtract2xSurfaceByVector(DataOneD,DataOneD, Nx, Ny, dataW,a);
 k:=0;
for i:=0 to  NY-1 do
 for j:=0 to  NX-1 do
 begin
  p[j,i]:=DataOneD[k];
  inc(k);
 end;
 FreeMem(a);
 FreeMem(DataOneD);
end;


function Subtract2xSurface(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer): Boolean;
//2 порядок z= a+bx+cy+dxy+ex^2+fy^2+gxy^2+hx^2y+iX^2y^2
//число коэффициентов  -9
var
  FullWindow: TDataRect;
  a: PArrayOfDouble0;
begin
  result:=True;
  FullWindow.StartX:=0;
  FullWindow.EndX:=m_nx-1;
  FullWindow.StartY:=0;
  FullWindow.EndY:=m_ny-1;

  GetMem(a, 9*SizeOf(Double));
  if Get2xSurfaceVector(pIn, m_nx, m_ny,FullWindow, a)
  then
    Subtract2xSurfacebyVector(pIn, pOut, m_nx, m_ny,FullWindow,a)
  else
  begin
    Result:=False;
    System.Move(pIn^, pOut^, m_nx*m_ny*sizeOf(SmallInt))
  end;
  FreeMem(a);
end;

function Subtract2xSurfaceByArea(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect): Boolean;
var
  a: pArrayOfDouble0;
  k: Integer;
  FullWindow: TDataRect;
begin
  result:=True;
  FullWindow.StartX:=0;
  FullWindow.EndX:=m_nx-1;
  FullWindow.StartY:=0;
  FullWindow.EndY:=m_ny-1;
  GetMem(a, 9*SizeOf(Double));
  if Get2xSurfaceVector(pIn, m_nx, m_ny,Window, a)
  then
    Subtract2xSurfaceByVector(pIn, pOut, m_nx, m_ny,FullWindow,a)
  else
  begin
    Result:=False;
    System.Move(pIn^, pOut^, m_nx*m_ny*sizeOf(SmallInt))
  end;
  FreeMem(a);
end;

function Subtract2xSurfaceFromArea(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer; Window: TDataRect): Boolean;
var
  a: pArrayOfDouble0;
  k: Integer;
begin
  result:=True;
  GetMem(a, 9*SizeOf(Double));
  if Get2xSurfaceVector(pIn, m_nx, m_ny,Window, a)
  then
    Subtract2xSurfaceByVector(pIn, pOut, m_nx, m_ny,Window,a)
  else
  begin
    Result:=False;
    System.Move(pIn^, pOut^, m_nx*m_ny*sizeOf(SmallInt))
  end;
  FreeMem(a);
end;

function Subtract2xSurfaceByMask(pIn, pOut: pArrayOfSmallInt0; pMask: PArrayOfByte0; m_nx, m_ny:Integer): Boolean;
var
  i,j,k,l,m,p: Integer;

  ym,wt,z, zadd: Double;
  beta,covar : PArrayOfDoublePointer0;
  afunc,a: pArrayOfDouble0;

  WWidth, WHeight: Integer;
  FullWindow: TDataRect;
begin

 	AllocD0Matrix(beta,9,1);
  AllocD0Matrix(covar,9,9);
	GetMem(afunc, 9*SizeOf(Double));
  GetMem(a, 9*SizeOf(Double));
  FullWindow.StartX:=0;
  FullWindow.EndX:=m_nx-1;
  FullWindow.StartY:=0;
  FullWindow.EndY:=m_ny-1;

  for p:=0 to m_ny-1 do
    for i:=0 to m_nx-1 do
    begin
        if pMask^[i+p*m_nx] = 0 then
        Continue;
        SecondOrderBasis(i, p,afunc);
        ym:=pIn^[i+p*m_nx];

        j:=-1;

        for l:=0 to 8 do
        begin
              wt:=afunc^[l];
              Inc(j);
              k:=-1;
              for m:=0 to l do
                begin
                  Inc(k);
                  covar^[j]^[k] := covar^[j]^[k]+wt*afunc^[m];
                end;
              beta^[j]^[0] := beta^[j]^[0]+ym*wt;
        end;
      end;


		for j:=1 to 8 do //Fill in above the diagonal from symmetry.
			for k:=0 to j-1 do
				covar^[k]^[j]:=covar^[j]^[k];

    if (GaussJordanElimination(covar,beta,9,1)<>True) then
    begin //Matrix solution.
      FreeDMatrix(beta,9,1);
      FreeDMatrix(covar,9,9);
      FreeMem(afunc);
      FillChar(a^,9*SizeOf(Double),0);
      Result:=False;
      Exit;
    end;

    j:=-1;
    for l:=0 to 8 do
    begin
        Inc(j);
        a^[l]:=beta^[j]^[0]; //Partition solution to appropriate coe.cients
    end;

    Subtract2xSurfaceByVector(pIn,pOut,m_nx,m_ny,FullWindow,a);

    FreeDMatrix(beta,9,1);
    FreeDMatrix(covar,9,9);
    FreeMem(afunc);
    FreeMem(a);
    Result:=True;
end;






function Subtract3xSurface(pIn,pOut: pArrayOfSmallInt0;m_nx, m_ny:Integer): Boolean;
var
  i,j,k,l,m,p: Integer;
  ym,wt,z, zadd: Double;
  beta,covar : PArrayOfDoublePointer0;
  afunc: pArrayOfDouble0;
  a: PArrayOfDouble0;
procedure TheardOrderBasis(XIndex, YIndex: Integer; BasisFuncs:pArrayOfDouble0);
begin
  BasisFuncs^[0]:=1;
  BasisFuncs^[1]:=XIndex;
  BasisFuncs^[2]:=YIndex;
  BasisFuncs^[3]:=XIndex*YIndex;
  BasisFuncs^[4]:=XIndex*XIndex;
  BasisFuncs^[5]:=YIndex*YIndex;
  BasisFuncs^[6]:=XIndex*BasisFuncs^[5];
  BasisFuncs^[7]:=YIndex*BasisFuncs^[4];
  BasisFuncs^[8]:=BasisFuncs^[4]*BasisFuncs^[5];
  BasisFuncs^[9]:=XIndex*BasisFuncs^[4];
  BasisFuncs^[10]:=YIndex*BasisFuncs^[5];
  BasisFuncs^[11]:=XIndex*BasisFuncs^[10];
  BasisFuncs^[12]:=BasisFuncs^[4]*BasisFuncs^[10];
  BasisFuncs^[13]:=BasisFuncs^[9]*BasisFuncs^[10];
  BasisFuncs^[14]:=YIndex*BasisFuncs^[9];
  BasisFuncs^[15]:=BasisFuncs^[5]*BasisFuncs^[9];
end;


begin
//FastDoubleLSFit(x,y: pArrayOfDouble0; ndat: Integer; a: PArrayOfDouble0;ma : Integer; funcs: TBasisFunction): Boolean;

//3 порядок z= a+bx+cy+dxy+ex^2+fy^2+gxy^2+hx^2y+ix^2y^2+jx^3+ky^3+lxy^3+mx^2y^3+nx^3y^3+ ox^3y+px^3y^2
//число коэффициентов  - 16
  GetMem(a, 16*SizeOf(Double));
 	AllocD0Matrix(beta,16,1);
  AllocD0Matrix(covar,16,16);
	GetMem(afunc, 16*SizeOf(Double));

  for p:=0 to m_ny-1 do
    for i:=0 to m_nx-1 do
    begin
        TheardOrderBasis(i, p,afunc);
        ym:=pIn^[i+p*m_nx];

        j:=-1;

        for l:=0 to 15 do
        begin
              wt:=afunc^[l];
              Inc(j);
              k:=-1;
              for m:=0 to l do
                begin
                  Inc(k);
                  covar^[j]^[k] := covar^[j]^[k]+wt*afunc^[m];
                end;
              beta^[j]^[0] := beta^[j]^[0]+ym*wt;
        end;
      end;


		for j:=1 to 15 do //Fill in above the diagonal from symmetry.
			for k:=0 to j-1 do
				covar^[k]^[j]:=covar^[j]^[k];

    if (GaussJordanElimination(covar,beta,16,1)<>True) then
    begin //Matrix solution.
      FreeDMatrix(beta,16,1);
      FreeDMatrix(covar,16,16);
      FreeMem(afunc);
      Result:=False;
      Exit;
    end;

    j:=-1;
    for l:=0 to 15 do
    begin
        Inc(j);
        a^[l]:=beta^[j]^[0]; //Partition solution to appropriate coe.cients
    end;

//3 порядок z= a+bx+cy+dxy+ex^2+fy^2+gxy^2+hx^2y+ix^2y^2+jx^3+ky^3+lxy^3+mx^2y^3+nx^3y^3+ ox^3y+px^3y^2
//число коэффициентов  - 16

    for p:=0 to m_ny-1 do
    begin
      z:=a^[0]+a^[2]*p+a^[5]*p*p+a^[10]*p*p*p;
      for i:=0 to m_nx-1 do
      begin
         zadd:=a^[1]*i+a^[3]*i*p+a^[4]*i*i+a^[6]*i*p*p+
          a^[7]*i*i*p+a^[8]*i*i*p*p+
          a^[9]*i*i*i+
          a^[11]*i*p*p*p+
          a^[12]*i*i*p*p*p+
          a^[13]*i*i*i*p*p*p+
          a^[14]*i*i*i*p+
          a^[15]*i*i*i*p*p;

         pOut^[i+p*m_nx]:= LimitToSmallint(-32768	,32767,
          pIn^[i+p*m_nx]- z-zadd);
      end;
    end;


    FreeDMatrix(beta,16,1);
    FreeDMatrix(covar,16,16);
    FreeMem(afunc);
    FreeMem(a);
    Result:=True;
end;

end.
