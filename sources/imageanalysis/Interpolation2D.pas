unit Interpolation2D;

interface
uses  SysUtils, Classes,GlobalDcl,FourierProc,GlobalType,GlobalScanDataType, DllImageAnalWnd;

function  LocalMax(DatLine:TLine; var MaxCount:integer):TLine;

procedure ConvolutionI(var Mas:TLine; S:integer);

function SEVAL(N : integer;
               U : float;
               var X,Y,B,C,D : ArraySpline) : float;
procedure Spline(N : integer;
                 var X, Y, B, C, D : ArraySpline);

procedure KnotsVal( NPoints:integer; LinerizData:ArraySpline;NLin:integer;GridCellSize:integer;
                        var Knots:TMas1);
                      //LinerizData: äàííûå ñå÷åíèÿ ëèíåàğèçàöèè;
                      // NLin: êîëè÷åñòâî òî÷åê â ìàññèâå ëèíåàğèçàöèè
procedure InterpData1(Dat:TData; KnotsX,KnotsY:TMas1; var InterpDataX,InterpDataY:TMas2);


procedure NonLinearInterp(Dat:TData;  var ZInterp2D:TMas2; var NInterpX,NInterpY:integer);

implementation


   procedure Spline(N : integer; var X, Y, B, C, D : ArraySpline);
//
//     BÛ×ÈCËßŞTCß KOİÔÔÈÖÈEHTÛ B(I),C(I) È D(I),I=1,
//     2,...,N, ÄËß KÓÁÈ×ECKOÃO ÈHTEPÏOËßÖÈOHHOÃO
//     CÏËAÉHA
//
//       S(X)=Y(I)+B(I)*(X-X(I))+C(I)*(X-X(I))**2+
//       +D(I)*(X-X(I))**3
//       ÄËß X(I).LE.X.LE.X(I+1)
//
//     BXOÄHAß ÈHÔOPMAÖÈß.
//
//       N     =×ÈCËO ÇAÄAHHÛX TO×EK ÈËÈ ÓÇËOB(N.GE.2)
//       X     =AÁCÖÈCCÛ ÓÇËOB B CTPOÃO BOÇPACTAŞÙEM
//              ÏOPßÄKE
//       Y     =OPÄÈHATÛ ÓÇËOB
//
//     BÛXOÄHAß ÈHÔOPMAÖÈß.
//
//       B,C,D =MACCÈBÛ OÏPEÄEËEHHÛX BÛØE KOİÔÔÈ-
//             ÖÈEHTOB CÏËAÉHA.
//
//     ECËÈ OÁOÇHA×ÈTÜ ×EPEÇ P CÈMBOË ÄÈÔÔEPEHÖÈP0-
//     BAHÈß,TO
//
//       Y(I)=S(X(I))
//       B(I)=SP(X(I))
//       C(I)=SPP(X(I))/2
//       D(I)=SPPP(X(I))/6 (ÏPABOCTOPOHßß ÏPOÈÇBOÄHAß)
//
//     C ÏOMOÙÜŞ COÏPOBOÆÄAŞÙEÉ ÏOÄÏPOÃPAMMÛ-ÔÓHK-
//     ÖÈÈ SEVAL MOÆHO BÛ×ÈCËßTÜ ÇHA×EHÈß CÏËAÉHA.
//
var I : integer;
    T : float;
    fl : boolean;
begin

//
//  Ïğîâåğêà: âñå äàííûå ğàçíûå
//
    fl:=false;
    for I:=2 to N do
    begin
        if X[I] <= X[I-1] then fl:=true;
    end;
    if fl then
    begin
         for I:=1 to N do
         begin
              B[I]:=0.0; C[I]:=0.0; D[I]:=0.0;
         end;
         exit;
    end;

    if N < 1 then exit;
    IF N < 2 then
    begin
         B[1]:=0.0; C[1]:=0.0; D[1]:=0.0;
         exit;
    end;
    IF N < 3 then
    begin
        B[1]:=(Y[2]-Y[1])/(X[2]-X[1]);
        C[1]:=0.0;
        D[1]:=0.0;
        B[2]:=B[1];
        C[2]:=0.0;
        D[2]:=0.0;
        exit;
    end;
//
//     ÏOCTPOÈTÜ TPEXÄÈAÃOHAËÜHÓŞ CÈCTEMÓ
//
//     B=ÄÈAÃOHAËÜ,D=HAÄÄÈAÃOHAËÜ,C=ÏPABÛE ×ACTÈ.
//
        D[1]:=X[2]-X[1];
        C[2]:=(Y[2]-Y[1])/D[1];
        for I:=2 to N-1 do
        begin
           D[I]:=X[I+1]-X[I];
           B[I]:=2.0*(D[I-1]+D[I]);
           C[I+1]:=(Y[I+1]-Y[I])/D[I];
           C[I]:=C[I+1]-C[I];
        end;
//
//     ÃPAHÈ×HÛE ÓCËOBÈß: TPETÜÈ ÏPOÈÇBOÄHÛE B TO×KAX
//     X(1) È X(N) BÛ×ÈCËßŞTCß C ÏOMOÙÜŞ PAÇÄEËEHHÛX
//     PAÇHOCTEÉ
//
        B[1]:=-D[1];
        B[N]:=-D[N-1];
        C[1]:=0.0;
        C[N]:=0.0;
        IF N > 3 then
        begin
           C[1]:=C[3]/(X[4]-X[2])-C[2]/(X[3]-X[1]);
           C[N]:=C[N-1]/(X[N]-X[N-2])-C[N-2]/(X[N-1]-X[N-3]);
           C[1]:=C[1]*sqr(D[1])/(X[4]-X[1]);
           C[N]:=-C[N]*sqr(D[N-1])/(X[N]-X[N-3]);
        end;
//
//     ÏPßMOÉ XOÄ
//
        for I:=2 to N do
        begin
           T:=D[I-1]/B[I-1];
           B[I]:=B[I]-T*D[I-1];
           C[I]:=C[I]-T*C[I-1];
        end;
//
//     OÁPATHAß ÏOÄCTAHOBKA
//
        C[N]:=C[N]/B[N];
        for I:=N-1 downto 1 do
        begin
           C[I]:=(C[I]-D[I]*C[I+1])/B[I];
        end;
//
//     B C(I) TEÏEPÜ XPAHÈTCß BEËÈ×ÈHA SIGMA(I)
//
//     BÛ×ÈCËÈTÜ KOİÔÔÈÖÈEHTÛ ÏOËÈHOMOB
//
        B[N]:=(Y[N]-Y[N-1])/D[N-1]+D[N-1]*(C[N-1]+2.0*C[N]);
        for I:=1 to N-1 do
        begin
           B[I]:=(Y[I+1]-Y[I])/D[I]-D[I]*(C[I+1]+2.0*C[I]);
           D[I]:=(C[I+1]-C[I])/D[I];
           C[I]:=3.0*C[I];
        end;
        C[N]:=3.0*C[N];
        D[N]:=D[N-1];
end; {Spline}

function SEVAL(N : integer;
               U : float;
               var X,Y,B,C,D : ArraySpline) : float;
//
//  İTA ÏOÄÏPOÃPAMMA BÛ×ÈCËßET ÇHA×EHÈE KÓÁÈ×ECKOÃO
//  CÏËAÉHA
//
//  SEVAL=Y(I)+B(I)*(U-X(I))+C(I)*(U-X(I))**2+
//             D(I)*(U-X(I))**3
//
//  ÃÄE X(I).LT.U.LT.X(I+1). ÈCÏOËÜÇÓETCß CXEMA
//  ÃOPHEPA
//
//  ECËÈ U.LT.X(1), TO ÁEPETCß ÇHA×EHÈE I=1.
//  ECËÈ U.GE.X(N), TO ÁEPETCß ÇHA×EHÈE I=N.
//
//  BXOÄHAß ÈHÔOPMAÖÈß.
//
//     N     -×ÈCËO ÇAÄAHHÛX TO×EK
//     U     -AÁCÖÈCCA, ÄËß KOTOPOÉ BÛ×ÈCËßETCß ÇHA×EHÈE
//            CÏËAÉHA
//     X,Y   -MACCÈBÛ ÇAÄAHHÛX AÁCÖÈCC È OPÄÈHAT
//     B,C,D -MACCÈBÛ KOİÔÔÈÖÈEHTOB CÏËAÉHA, BÛ×ÈCËEHHÛE
//            ÏOÄÏPOÃPAMMOÉ SPLINE
//
//  ECËÈ ÏO CPABHEHÈŞ C ÏPEÄÛÄÓÙÈM BÛÇOBOM U HE
//  HAXOÄÈTCß B TOM ÆE ÈHTEPBAËE, TO ÄËß PAÇÛCKAHÈß
//  HÓÆHOÃO ÈHTEPBAËA ÏPÈMEHßETCß ÄBOÈ×HÛÉ ÏOÈCK.
//

//const I : integer = 1;  ????????????
var I,J,K : integer;
    DX : float;
begin
      I:=1;
      IF I > N then I:=1;
      IF (U < X[I]) or (U > X[I+1]) then
      begin
      //
      //  ÄBOÈ×HÛÉ ÏOÈCK
      //
        I:=1; J:=N+1;
        repeat
        begin
           K:=(I+J) div 2;
           IF U < X[K] then J:=K
                       else I:=K;
           end
        until (J <= (I+1));
      end;
//
//  BÛ×ÈCËÈTÜ CÏËAÉH
//
      DX:=U-X[I];
      SEVAL:=Y[I]+DX*(B[I]+DX*(C[I]+DX*D[I]));
end;

procedure KnotsVal( NPoints:integer; LinerizData:ArraySpline;NLin:integer;GridCellSize:integer;
                        var Knots:TMas1);
var
GridPoints:ArraySpline;
i,j:integer;
NKnots:integer;
B,C,D:ArraySpline;
a:integer;
begin
for i:=1 to NLin do
GridPoints[i]:=(i-1)*GridCellSize;

Spline(NLin,LinerizData,GridPoints,B,C,D);

// âû÷èñë. ïîñëåäíåé òî÷êè â ìàòğèöå áåç ó÷¸òà NonLin Field
//LastSplinedPoint:=NPoints*StepXY; //!!!!!!!!!!!!
//NKnots:=round(SEVAL(NLin,LastSplinedPoint,LinerizData,GridPointsX,B,C,D)/StepXY);

SetLength(Knots,NPoints);

for i:=0 to Npoints-1 do
  begin
    Knots[i]:=round(SEVAL(NLin,i*Step,LinerizData,GridPoints,B,C,D)/Step);
  end;
//â ñëó÷àå îòğèöàòåëüíûõ çíà÷åíèé óçëîâ ïîñëå ñïëàéí-èíòåğïîëÿöèè:
a:=Knots[0]; {ïîèñê ìèí. çí. óçëà}
for i:=0 to Npoints-1 do
  begin
    if  Knots[i]<a then
    a:=Knots[i];
  end;
for i:=0 to Npoints-1 do
  begin
     Knots[i]:=Knots[i]+abs(a) ;
   end;


end; {KnotsVal}

procedure InterpData1(Dat:TData;KnotsX,KnotsY:TMas1;var InterpDataX,InterpDataY :TMas2);
var
L,L1:integer;
i,j,k:integer;
Row, Absciss:ArraySpline;
B,C,D:ArraySpline;
begin
 L:=length(KnotsX);
 L1:=KnotsX[L-1]+1;
 SetLength(InterpDataX,dat.NY,L1);
 for i:=0 to dat.NY-1  do
   begin
     for k:=1 to L do
     begin
     Absciss[k]:=KnotsX[k-1];
     Row[k]:=Dat.data[k-1,i];
     end;
     Spline(L,Absciss,Row,B,C,D);
     for j:=0 to L1-1 do
       begin
         InterpDataX[i,j]:=round(SEVAL(L,j,Absciss,Row,B,C,D));
       end;
   end;

 L:=length(KnotsY);
 L1:=KnotsY[L-1]+1;
 SetLength(InterpDataY,L1,Dat.NX);
 for j:=0 to Dat.NX-1 do
   begin
     for k:=1 to L do
       begin
        Absciss[k]:=KnotsY[k-1];
        Row[k]:=Dat.data[j,k-1];
       end;
      Spline(L,Absciss,Row,B,C,D);
       for i:=0 to L1-1 do
       begin
         InterpDataY[i,j]:=round(SEVAL(L,i,Absciss,Row,B,C,D));
       end;
   end;
end;{InterpData1}

procedure NonLinearInterp(Dat:TData; var ZInterp2D:TMas2; var NInterpX,NInterpY:integer);
var i,j,ki,kj:integer;
LkX,LkY:  integer;
InterpDataX,InterpDataY:TMas2;
 KnotsX,KnotsY:TMas1;
begin

KnotsVal( Dat.NX, LinerizDataX, NLinX,GridCellSize,  KnotsX);
KnotsVal( Dat.NY, LinerizDataY, NLinY,GridCellSize,  KnotsY);

LkX:=Length(KnotsX);
LkY:=Length(KnotsY);
//ZInterp2D:=TData.Create;
InterpData1(Dat,KnotsX,KnotsY, InterpDataX,InterpDataY);
//ZInterp2D.Nx:=KnotsX[LkX-1]+1;
//ZInterp2D.Ny:=KnotsY[LkY-1]+1;
NInterpX:= KnotsX[LkX-1]+1;
NInterpY:=KnotsY[LkY-1]+1;
SetLength(ZInterp2D,NInterpY,NInterpX);//KnotsY[LkY-1]+1,KnotsX[LkX-1]+1);

for ki:=0 to LkY-2 do
for kj:=0 to LkX-2 do
  begin
     for i:=KnotsY[ki] to KnotsY[ki+1]-1 do
     for j:=KnotsX[kj] to KnotsX[kj+1]-1 do
       begin
       if (i<NInterpY-1) and (j<NInterpX-1) and (i>=0) and (j>=0) then
        ZInterp2D[i,j]:=round(0.25*(InterpDataX[ki,j]+InterpDataX[ki+1,j]+
                              InterpDataY[i,kj]+ InterpDataY[i,kj+1]));
       end;
  end;

InterpDataY:=nil;
InterpDataX:=nil;
KnotsX:=nil;
KnotsY:=nil;
end; {NonLinearInterp}


function  LocalMax(DatLine:TLine; var MaxCount:integer):TLine;
var  i:integer;
     L:integer;
     Temp:TLine;
     b1,b2:TLine;
     LocMaxCount:integer;
begin
L:=Length(DatLine);
SetLength(Temp,L);
SetLength(b1,L);
SetLength(b2,L);
LocMaxCount:=0;
try
for i:=0 to L-2 do
  begin
    if (DatLine[i]<=DatLine[i+1]) then b1[i]:=1;
    if  (DatLine[i]>DatLine[i+1]) then b2[i]:=1;
  end;
for i:=0 to L-3 do
  begin
    if ((b1[i]=1) and (b2[i+1]=1)) then
     begin
      Temp[LocMaxCount]:=i+1;
      LocMaxCount:=LocMaxCount+1;
     end;
  end;
  MaxCount:=LocMaxcount;
finally
b1:=nil;
b2:=nil;
end; {finally}

LocalMax:=Temp;
Temp:=nil;
end;  {LocalMax}

procedure ConvolutionI(var Mas:TLine; S:integer);
 var
 i,r:integer;
 Q, Shift, Buf:integer;
 L:integer;
 Temp:  TLine;
begin
 L:=Length(Mas);
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
     Q:=Q div S;
     Temp[i]:=Q;
  end;
  mas:=temp;
  Temp:=nil;
end;  {convolution}


end.

