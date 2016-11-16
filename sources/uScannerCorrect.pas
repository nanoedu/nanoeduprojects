unit uScannerCorrect;

interface
uses windows,dialogs,GlobalType, inifiles, classes;


 //   Const  GridCellSize=1600; //nm
 //   Const ApprLineY0=3700;   //!!!!!!!!!!!!!!!Must be changed
 //   Const ApprLineX0=3700;    //!!!!!!!!!!!!!!


 type vector2D=record
     x,y:single;
     end;
type TZCell=array[1..2] of array[1..2] of vector2D; //nm
type Point3D=record
     X,Y,Z:single;
     i3D,j3D:integer;
  end;

  function SEVAL(N : integer;
               U : float;
               var X,Y,B,C,D : ArraySpline) : float;
 procedure Spline(N : integer;
                 var X, Y, B, C, D : ArraySpline);

// function  GetSpline(ScannerNum,Direction:string; var XSp,YSp:ArraySpline; var NSplines:integer):integer;
 procedure Smooth1(var Dat:ArraySpline; N,S:integer);
 //function  LineKoef(YSp:ArraySpline; NSplines:integer; Bound:integer):single;
 procedure ReadZSurf();
 function  ZCorrCalculate(Xnm,Ynm:single):single;
 function  TestErrorScannerIniFile:byte;
 function  LoadLinSpline(const ScannerNum:string):integer;
 function  LoadLinSplineFromAdapter:integer;
 procedure SetLinSplineZero ;
 procedure ApprLinesParamsCalc(const ScannerNum:string);
 procedure ApprLinesParamsCalcFromAdapter;
 function  GetSpline(const ScannerNum,Direction:string; var XSp,YSp:ArraySpline; var NSplines:integer):integer;
 function  GetSplineFromAdapter(ScanPathMode:integer; Direction:string; var XSp,YSp:ArraySpline; var NSplines:integer):integer;
 function LineKoef(const YSp:ArraySpline; NSplines:integer; Bound:integer; Mode:string; Axes:string):single;
 function ZLinCorrect(ZValdiscr:integer):integer;

implementation

  uses GlobalVar,GlobalFunction,CSPMVar,sysutils,forms,math,frNoFormUnitLoc;

   procedure Spline(N : integer; var X, Y, B, C, D : ArraySpline);
//
//     BÛ×ÈCËßÞTCß KOÝÔÔÈÖÈEHTÛ B(I),C(I) È D(I),I=1,
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
//       X     =AÁCÖÈCCÛ ÓÇËOB B CTPOÃO BOÇPACTAÞÙEM
//              ÏOPßÄKE
//       Y     =OPÄÈHATÛ ÓÇËOB
//
//     BÛXOÄHAß ÈHÔOPMAÖÈß.
//
//       B,C,D =MACCÈBÛ OÏPEÄEËEHHÛX BÛØE KOÝÔÔÈ-
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
//     C ÏOMOÙÜÞ COÏPOBOÆÄAÞÙEÉ ÏOÄÏPOÃPAMMÛ-ÔÓHK-
//     ÖÈÈ SEVAL MOÆHO BÛ×ÈCËßTÜ ÇHA×EHÈß CÏËAÉHA.
//
var I : integer;
    T : float;
    fl : boolean;
begin

//
//  Ïðîâåðêà: âñå äàííûå ðàçíûå
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
//     ÏOCTPOÈTÜ TPEXÄÈAÃOHAËÜHÓÞ CÈCTEMÓ
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
//     X(1) È X(N) BÛ×ÈCËßÞTCß C ÏOMOÙÜÞ PAÇÄEËEHHÛX
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
//     BÛ×ÈCËÈTÜ KOÝÔÔÈÖÈEHTÛ ÏOËÈHOMOB
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
//  ÝTA ÏOÄÏPOÃPAMMA BÛ×ÈCËßET ÇHA×EHÈE KÓÁÈ×ECKOÃO
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
//     B,C,D -MACCÈBÛ KOÝÔÔÈÖÈEHTOB CÏËAÉHA, BÛ×ÈCËEHHÛE
//            ÏOÄÏPOÃPAMMOÉ SPLINE
//
//  ECËÈ ÏO CPABHEHÈÞ C ÏPEÄÛÄÓÙÈM BÛÇOBOM U HE
//  HAXOÄÈTCß B TOM ÆE ÈHTEPBAËE, TO ÄËß PAÇÛCKAHÈß
//  HÓÆHOÃO ÈHTEPBAËA ÏPÈMEHßETCß ÄBOÈ×HÛÉ ÏOÈCK.
//
const I : integer = 1;
var J,K : integer;
    DX : float;
begin
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


function GetSpline(const ScannerNum,Direction:string; var XSp,YSp:ArraySpline; var NSplines:integer):integer;
var
  i:integer;
  Buf:float;
  iniCSPM:TiniFile;
  sFile:string;
begin
  NSplines:=1;
  sFile:=ScannerIniFilesPath + ScannerIniFile;
  iniCSPM:=TIniFile.Create(sFile);
try
  with iniCSPM do
   begin
     NSplines:=ReadInteger((HardWareOpt.ScannerNumb), Direction+'Points Number',1);
    for i:=1 to NSplines do
      begin
       XSp[i]:=(i-1)*ScannerCorrect.GridCellSize;
       YSp[i]:= ReadFloatConvert(iniCSPM,(HardWareOpt.ScannerNumb), Direction+IntToStr(i), XSp[i]);
      end;
 end;
 Buf:=YSp[1];
 for i:=1 to NSpLines do
  begin
   YSp[i]:=YSp[i]-Buf;
  end;
  Smooth1(YSp,NSplines,3);       //procedure Smooth1 was changed by Ola 13/01/04
 finally
  iniCSPM.Free;
 end;
end;   {GetSpline}

function GetSplineFromAdapter(ScanPathMode:integer;Direction:string; var XSp,YSp:ArraySpline; var NSplines:integer):integer;
var
  i:integer;
  Buf:float;
begin
  NSplines:=1;
   case ScanPathMode of
0: begin        //X+
       if LowerCase(Direction)=lowerCase('X') then
        begin
         NSplines:=PadapterLinModXAxisX^.NPoints;
         for i:=1 to NSplines do
         begin
          XSp[i]:=(i-1)*ScannerCorrect.GridCellSize;
          YSp[i]:=PadapterLinModXAxisX^.Points[i];
         end;
        end;
       if LowerCase(Direction)=LowerCase('Y') then
       begin
         NSplines:=PadapterLinModXAxisY^.NPoints;
          for i:=1 to NSplines do
         begin
          XSp[i]:=(i-1)*ScannerCorrect.GridCellSize;
          YSp[i]:=PadapterLinModXAxisY^.Points[i];
         end;
       end;
   end;
1: begin            //Y+
       if LowerCase(Direction)=lowerCase('X') then
        begin
         NSplines:=PadapterLinModYAxisX^.NPoints;
          for i:=1 to NSplines do
         begin
          XSp[i]:=(i-1)*ScannerCorrect.GridCellSize;
          YSp[i]:=PadapterLinModYAxisX^.Points[i];
         end;
        end;
       if LowerCase(Direction)=LowerCase('Y') then
       begin
        NSplines:=PadapterLinModYAxisY^.NPoints;
         for i:=1 to NSplines do
         begin
          XSp[i]:=(i-1)*ScannerCorrect.GridCellSize;
          YSp[i]:=PadapterLinModYAxisY^.Points[i];
         end;
       end;
   end;
             end;  //case

 Buf:=YSp[1];
 for i:=1 to NSpLines do
  begin
   YSp[i]:=YSp[i]-Buf;
  end;
  Smooth1(YSp,NSplines,3);       //procedure Smooth1 was changed by Ola 13/01/04
end;   {GetSpline}


function LineKoef(const YSp:ArraySpline; NSplines:integer; Bound:integer; Mode:string; Axes:string):single;
var i,i0,k:integer;
Sum,Dist:single;
begin
Sum:=0;
k:=0;
i0:=ceil(Bound/ScannerCorrect.GridCellSize);
if i0>=NSpLines then
begin
 LineKoef:=1;
  //NoFormUnitLoc.siLang1.MessageDlg(NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_8' (* 'Linearization is not full! Check None linear region in the Option!!!' *) ), mtInformation,[mbOk], 0);
 MessageDlg( NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_19' (* 'Linearization for ' *) )+ Mode+ NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_32' (* ' Mode, ' *) )+ Axes +NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_33' (* ' Axes is not full! Check None linear region in the Option!!!' *) )  , mtInformation,[mbOk], 0);
 end
else
 for i:=i0 to NSplines-1 do
  begin
   Dist:=YSp[i+1]-YSp[i];
   Sum:=Sum+Dist;
   k:=k+1;
  end;
  if k<>0 then
      LineKoef:=(Sum/k/ScannerCorrect.GridCellSize)
    else  LineKoef:=1;
end;

procedure Smooth1(var Dat:ArraySpline; N,S:integer);
var
  i,kx,ix:integer;
  Shift:integer;
  res: double;
  ires: integer;
  Temp:ArraySpline;       // array of integer;
  iStart:integer;          // Done by Ola 13/01/04
begin
   iStart:=4 ;
   Shift:=(S-1) div 2;
   if N<ArraySplineLen{maxval} then
   Dat[N+1]:=Dat[N];  //useful for S=3;
      for ix:=istart to N do
        begin
             res:=0.0; ires:=0;
              for kx:=-Shift to Shift do
                begin
                     i:=ix+kx;
                     if (i > 0) and (i <= N)
                         then
                     begin
                        ires:=ires+1;
                        res:=res+Dat[i];
                     end;
                end; {for kx}
           if (ires>0) and (ix > Shift)  and(ix<N-shift+1) then
             begin
                Temp[ix]:=round(res/ires);
             end
             else
             begin
                Temp[ix]:=Dat[ix];
             end;
        end; {for ix}
      for ix:=iStart to N do
        begin
            Dat[ix]:=Temp[ix];
        end;
end; {Smooth1}

procedure ReadZSurf();
var
 FileHndl,iBytesRead:integer;
 DatBuf:PWord;
  sFile:string;
  i,j:integer;
  NX,NY:integer;      // Values for ZSurf
begin
// Read ZSurf from file;
NY:=387;
NX:=450;
sFile:=ExeFilePath+ 'ZSurf.bin';
FileHndl:=FileOpen(sFile,fmOpenRead);
SetLength(ZMatr,NY,NX);
try
  try
                     GetMem(DatBuf,Nx*Ny*sizeof(DataType));
                           except
                               on EOutOfMemory        do
                               NoFormUnitLoc.siLang1.MessageDlg(strusc2{NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_20' (* 'OUT memory 1' *) )},mtWarning,[mbOk],0);
                           end;
                            iBytesRead:=FileRead(FileHndl,DatBuf^,sizeof(DataType)*Nx*Ny);
                           if (iBytesRead<>-1) then
                               begin
                                for j:=0 to Ny-1 do
                                  for i:=0 to Nx-1 do
                                   begin
                                       ZMatr[j,i]:=datatype(PWordArray(DatBuf)[j*Nx+i]);          //
                                   end;
                               end;
  FileClose(FileHndl);
 for j:=0 to Ny-1 do
   for i:=0 to Nx-1 do
      begin
        ZMatr[j,i]:=ZMatr[j,i]-ZMatr[0,0];          //
      end;
 finally
//  ZMatr:=nil;
  FreeMem(DatBuf);
 end;
end;

function ZCorrCalculate(Xnm,Ynm:single):single;
{ZMatr}
var
ZCell:TZCell;
P1,P2,P3:Vector;
NX,NY:integer;      // Values for ZSurf
ZMatrStep:single;
ZCellj,ZCelli:integer;
DXCell,DYCell:single;
S1,S2,S3,S4,S5:single;
begin
// Read ZSurf from file;
NY:=387;
NX:=450;
ZMatrStep:=158.07;
if(Xnm>NX*ZMatrStep) then Xnm:=NX*ZMatrStep;
if(Ynm>NY*ZMatrStep) then Ynm:=NY*ZMatrStep;

ZCellj:=floor(Xnm/ZMatrStep);
zCelli:=floor(Ynm/ZMatrStep);
ZCell[1,1].X:=ZCellj*ZMatrStep;
ZCell[1,1].Y:=ZCelli*ZMatrStep;
ZCell[1,2].X:=ZCell[1,1].X+ZMatrStep;
ZCell[1,2].Y:=ZCell[1,1].Y;
ZCell[2,1].X:=ZCell[1,1].X;
ZCell[2,1].Y:=ZCell[1,1].Y+ZMatrStep;
ZCell[2,2].X:=ZCell[1,1].X+ZMatrStep;
ZCell[2,2].Y:=ZCell[1,1].Y+ZMatrStep;
DXCell:=Xnm-ZCell[1,1].X;
DYCell:=Ynm-ZCell[1,1].Y;
with P1 do
begin
  X:=ZCell[1,1].X;
  Y:=ZCell[1,1].Y;
  Z:=ZMatr[zCelli,ZCellj];
end;

with P3 do
begin
  X:=ZCell[2,2].X;
 Y:=ZCell[2,2].Y;
 Z:=ZMatr[zCelli+1,ZCellj+1];
end;
if (DXCell>DYCell) then
with P2 do
begin
 X:=ZCell[1,2].X;
 Y:=ZCell[1,2].Y;
 Z:=ZMatr[zCelli,ZCellj+1];
end
else
with P2 do
begin
 X:=ZCell[2,1].X;
 Y:=ZCell[2,1].Y;
 Z:=ZMatr[zCelli+1,ZCellj];
end;

{ Plane for 3 points
  |x-x1   y-y1    z-z1   |
  |x2-x1  y2-y1  z2-z1   |  =0
  |x3-x1  y3-y1  z3-z1   |
 }
S1:=(Xnm-P1.X)*(P2.Y-P1.Y)*(P3.Z-P1.Z);
S2:=(Ynm-P1.Y)*(P2.Z-P1.Z)*(P3.X-P1.X);
S3:=(Xnm-P1.X)*(P2.Z-P1.Z)*(P3.X-P1.X);
S4:=(Ynm-P1.Y)*(P2.X-P1.X)*(P3.Z-P1.Z);
S5:=(P2.X-P1.X)*(P3.Y-P1.Y)-(P2.Y-P1.Y)*(P3.X-P1.X);
Result:=P1.Z+(S3+S4-S1-S2)/S5;
end;

procedure SetLinSplineZero ;
 var i:integer;
begin
    for i:=1 to ArraySplineLen
    do
     begin
           XXSp[i]:=0;
           YYSp[i]:=0;
           XYSp[i]:=0;
           YXSp[i]:=0;
     end;
 end;


function TestErrorScannerIniFile:byte;
(*
   result=0    O'K
         =1   New Controller detected'
         =2    'No Data for Scanner Number!!! '
         =3  'No Linearization Data for X Direction'
         =4   'No Linearization Data for Y Direction'
         =5   No Scanner.ini File

         =7   No Controller.ini File
*)
var
 FName:string;
 i:integer;
 tresultX,tresultY:string;
 iniCSPM:TiniFile;
 ScannerData:TStrings;
begin
  Result:=0;
try
  ScannerData:=TStringlist.Create;
  ScannerData.Capacity:=100;
(*  FName:=ControllerIniFilePath + ControllerIniFile;
 if FileExists(FName) then
  begin
    iniCSPM:=TIniFile.Create(FName);
   try
    with iniCSPM do
      if not SectionExists((HardWareOpt.ElectronicNumb)) then
       begin
        Result:=1;
        NoFormUnitLoc.siLang1.MessageDlg(NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_26' {* 'New Electronic ' })+HardWareOpt.ElectronicNumb+NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_27' { ' detected!' })  ,mtInformation ,[mbOK],0);
        exit;
      end;
   finally
    iniCSPM.Free;
   end;
  end
  else
  begin
    NoFormUnitLoc.siLang1.MessageDlg(NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_28' { 'Error!!!' } )+#13+NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_29' { 'Controller.ini File Not Exists !'}  ), mtInformation,[mbOk],0);
    Result:=7;
    exit;
  end;
  *)
   FName:=ScannerIniFilesPath + ScannerIniFile;
 if FileExists(FName) then
  begin
    iniCSPM:=TIniFile.Create(FName);
  try
   with iniCSPM do
    begin
      if   not SectionExists((HardWareOpt.ScannerNumb)) then
      begin
        Result:=2;
        NoFormUnitLoc.siLang1.MessageDlg(NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_30' { 'New Scanner ' } )+HardWareOpt.ScannerNumb+NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_31' { ' detected!!!!' } ) ,mtInformation ,[mbOK],0);
        exit;
      end;
      ReadSection(HardWareOpt.ScannerNumb,ScannerData);
      Result:=3;
      flgLinYScanner:=True;
      flgLinXScanner:=True;
    for i:=0 to ScannerData.Count-1  do
      if ScannerData.Strings[i]=XLinId then
         begin
           Result:=0;
           break;
          end;
      if Result=3 then
         begin
           flgLinXScanner:=False;
         case   flgUnit of
    nano,terra,Pipette: begin
           ShowMessage(NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_24' (* 'No Linearization Data for X Direction' *) ));
          end;
             end;
             exit;
         end;
      Result:=4;
      for i:=0 to ScannerData.Count-1  do
        if ScannerData.Strings[i]=YLinId then
         begin
           Result:=0;
           break;
         end;
      if Result=4 then
         begin
           flgLinYScanner:=False;
         if (flgUnit=nano) or (flgUnit=Pipette) or (flgUnit=terra)then  ShowMessage(NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_25' (* 'No Linearization Data for Y Direction' *) ));
           exit;
         end;
        end //with
     finally
      IniCSPM.Free;
     end;
    end
    else
       begin
          NoFormUnitLoc.siLang1.MessageDlg(NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_28' (* 'Error!!!' *) )+#13+NoFormUnitLoc.siLang1.GetTextOrDefault('IDS_44' (* 'ScannerIniFile Not Exists !' *) ), mtInformation,[mbOk], 0);
          Result:=5;
          exit;
       end;
 finally
    ScannerData.Free;
 end;
end;

function LoadLinSpline(const ScannerNum:string):integer;
var ss:string;
begin
        SetLinSplineZero;
        GetSpline(ScannerNum,'X', XXSp,YXSp,NXSplines);
        GetSpline(ScannerNum,'Y', XYSp,YYSp,NYSplines);
        if ScanParams.ScanPath = 0 then  ss:='X'
        else ss:='Y';
        LineXKoef:=LineKoef(YXSp,NXSplines,ScannerCorrect.NonLinFieldX, ss, 'X');
        LineYKoef:=LineKoef(YYSp,NYSplines,ScannerCorrect.NonLinFieldY, ss, 'Y');
        Spline(NXSpLines,XXsp,YXsp,BX,CX,DX);
        Spline(NYSpLines,XYsp,YYsp,BY,CY,DY);
end;
function LoadLinSplineFromAdapter:integer;
var ss:string;
begin
        SetLinSplineZero;
        GetSplineFromAdapter(ScanParams.Scanpath,'X', XXSp,YXSp,NXSplines);
        GetSplineFromAdapter(ScanParams.Scanpath,'Y', XYSp,YYSp,NYSplines);
         if ScanParams.ScanPath = 0 then  ss:='X'
        else ss:='Y';
        LineXKoef:=LineKoef(YXSp,NXSplines,ScannerCorrect.NonLinFieldX, ss, 'X');
        LineYKoef:=LineKoef(YYSp,NYSplines,ScannerCorrect.NonLinFieldY, ss, 'Y');
        Spline(NXSpLines,XXsp,YXsp,BX,CX,DX);
        Spline(NYSpLines,XYsp,YYsp,BY,CY,DY);
end;

procedure ApprLinesParamsCalc(const ScannerNum:string);
var BoundPointX, BoundPointY:single;
    XXSploc,YXSploc,XYSploc,YYSploc:ArraySpline;
    NXSplinesloc, NYSplinesloc:integer;
    Bxloc,CXloc,DXloc,BYloc,CYloc,DYloc:ArraySpline;
    ScanneriniFileBuf:string;
begin
ScanneriniFileBuf:=ScannerIniFile;
if ScannerCorrect.FlgXYLinear  then
 begin
 ScannerIniFile:=ScannerIniFileX;
  GetSpline(ScannerNum,'X', XXSploc,YXSploc,NXSplinesloc);
  GetSpline(ScannerNum,'Y', XYSploc,YYSploc,NYSplinesloc);
  ScannerOptModX.ApprLineXKoef:=LineKoef(YXSploc,NXSplinesloc,ScannerOptModX.NonLinFieldX, 'X', 'X');
  ScannerOptModX.ApprLineYKoef:=LineKoef(YYSploc,NYSplinesloc,ScannerOptModX.NonLinFieldY, 'X', 'Y');
  Spline(NXSpLines,XXsploc,YXsploc,BXloc,CXloc,DXloc);
  Spline(NYSpLines,XYsploc,YYsploc,BYloc,CYloc,DYloc);
  BoundPointX:=SEVAL(NXSplines,ScannerOptModX.NonLinFieldX,XXsploc,YXsploc,Bxloc,CXloc,DXloc);
  BoundPointY:=SEVAL(NYSplines,ScannerOptModX.NonLinFieldY,XYsploc,YYsploc,BYloc,CYloc,DYloc);
  ScannerOptModX.ApprLineX0:=BoundPointX-ScannerOptModX.ApprLineXKoef*ScannerOptModX.NonLinFieldX;
  ScannerOptModX.ApprLineY0:=BoundPointY-ScannerOptModX.ApprLineYKoef*ScannerOptModX.NonLinFieldY;

 ScannerIniFile:=ScannerIniFileY;
  GetSpline(ScannerNum,'X', XXSploc,YXSploc,NXSplinesloc);
  GetSpline(ScannerNum,'Y', XYSploc,YYSploc,NYSplinesloc);
  ScannerOptModY.ApprLineXKoef:=LineKoef(YXSploc,NXSplinesloc,ScannerOptModY.NonLinFieldX, 'Y','X');
  ScannerOptModY.ApprLineYKoef:=LineKoef(YYSploc,NYSplinesloc,ScannerOptModY.NonLinFieldY, 'Y', 'Y');
   Spline(NXSpLines,XXsploc,YXsploc,BXloc,CXloc,DXloc);
  Spline(NYSpLines,XYsploc,YYsploc,BYloc,CYloc,DYloc);
  BoundPointX:=SEVAL(NXSplines,ScannerOptModY.NonLinFieldX,XXsploc,YXsploc,Bxloc,CXloc,DXloc);
  BoundPointY:=SEVAL(NYSplines,ScannerOptModY.NonLinFieldY,XYsploc,YYsploc,BYloc,CYloc,DYloc);
  ScannerOptModY.ApprLineX0:=BoundPointX-ScannerOptModY.ApprLineXKoef*ScannerOptModY.NonLinFieldX;
  ScannerOptModY.ApprLineY0:=BoundPointY-ScannerOptModY.ApprLineYKoef*ScannerOptModY.NonLinFieldY;
 end;
 ScannerIniFile:=ScannerIniFileBuf;
end;
procedure ApprLinesParamsCalcFromAdapter;
var BoundPointX, BoundPointY:single;
    XXSploc,YXSploc,XYSploc,YYSploc:ArraySpline;
    NXSplinesloc, NYSplinesloc:integer;
    Bxloc,CXloc,DXloc,BYloc,CYloc,DYloc:ArraySpline;
begin
if ScannerCorrect.FlgXYLinear  then
 begin
  GetSplineFromAdapter(0,'X', XXSploc,YXSploc,NXSplinesloc);
  GetSplineFromAdapter(0,'Y', XYSploc,YYSploc,NYSplinesloc);
  ScannerOptModX.ApprLineXKoef:=LineKoef(YXSploc,NXSplinesloc,ScannerOptModX.NonLinFieldX, 'X', 'X');
  ScannerOptModX.ApprLineYKoef:=LineKoef(YYSploc,NYSplinesloc,ScannerOptModX.NonLinFieldY, 'X', 'Y');
  Spline(NXSpLines,XXsploc,YXsploc,BXloc,CXloc,DXloc);
  Spline(NYSpLines,XYsploc,YYsploc,BYloc,CYloc,DYloc);
  BoundPointX:=SEVAL(NXSplines,ScannerOptModX.NonLinFieldX,XXsploc,YXsploc,Bxloc,CXloc,DXloc);
  BoundPointY:=SEVAL(NYSplines,ScannerOptModX.NonLinFieldY,XYsploc,YYsploc,BYloc,CYloc,DYloc);
  ScannerOptModX.ApprLineX0:=BoundPointX-ScannerOptModX.ApprLineXKoef*ScannerOptModX.NonLinFieldX;
  ScannerOptModX.ApprLineY0:=BoundPointY-ScannerOptModX.ApprLineYKoef*ScannerOptModX.NonLinFieldY;
//????
  GetSplineFromAdapter(1,'X', XXSploc,YXSploc,NXSplinesloc);
  GetSplineFromAdapter(1,'Y', XYSploc,YYSploc,NYSplinesloc);
  ScannerOptModY.ApprLineXKoef:=LineKoef(YXSploc,NXSplinesloc,ScannerOptModY.NonLinFieldX, 'Y', 'X');
  ScannerOptModY.ApprLineYKoef:=LineKoef(YYSploc,NYSplinesloc,ScannerOptModY.NonLinFieldY, 'Y', 'Y');
  Spline(NXSpLines,XXsploc,YXsploc,BXloc,CXloc,DXloc);
  Spline(NYSpLines,XYsploc,YYsploc,BYloc,CYloc,DYloc);
  BoundPointX:=SEVAL(NXSplines,ScannerOptModY.NonLinFieldX,XXsploc,YXsploc,Bxloc,CXloc,DXloc);
  BoundPointY:=SEVAL(NYSplines,ScannerOptModY.NonLinFieldY,XYsploc,YYsploc,BYloc,CYloc,DYloc);
  ScannerOptModY.ApprLineX0:=BoundPointX-ScannerOptModY.ApprLineXKoef*ScannerOptModY.NonLinFieldX;
  ScannerOptModY.ApprLineY0:=BoundPointY-ScannerOptModY.ApprLineYKoef*ScannerOptModY.NonLinFieldY;
 end;
end;
function ZLinCorrect(ZValdiscr:integer):integer;
 var  BoundPointX,ApprLineX0:single;
      Z_nm, U_um:float ;
      U_discr: integer;
 begin
  //  BoundPointX:=SEVAL(NXSplines,ScannerCorrect.NonLinFieldX,XXsp,YXsp,Bx,CX,DX);
 //ApprLineX0:=BoundPointX-LineXKoef*ScannerCorrect.NonLinFieldX;
 // Äëÿ âûïîëíåíèÿ ëèíåàðèçàöèè ïî îñè Z áåðåòñÿ áûñòðàÿ îñü
 // (Õ èëè Ó â çàâèñèìîñòè îò íàïðâàëåíèÿ ñêàíèðîâàíèÿ)
 Z_nm := ZValdiscr/TransformUnit.Znm_d ;
 case ScanParams.ScanPath of
 Multi,OneX:   // X
 begin
     if( Z_nm < ScannerOptModX.NonLinFieldX) then   //ScannerCorrect.NonLinFieldX
     U_um :=SEVAL(NXSplines,Z_nm,XXsp,YXsp,Bx,CX,DX)
     else
     U_um :=  ScannerOptModX.ApprLineX0+ScannerOptModX.ApprLineXKoef*Z_nm;
 end;
 MultiY,OneY:   // Y
 begin
      if( Z_nm < ScannerOptModY.NonLinFieldY) then   //ScannerCorrect.NonLinFieldY
     U_um :=SEVAL(NYSplines,Z_nm,XYsp,YYsp,By,CY,DY)
     else
     U_um :=  ScannerOptModY.ApprLineY0+ScannerOptModY.ApprLineYKoef*Z_nm;
 end;
 end; 
 U_discr :=round(U_um*TransformUnit.Znm_d);
 result :=  U_discr;
 end;
end.
