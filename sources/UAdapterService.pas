unit UAdapterService;

interface
uses  Windows,Forms,Messages,Classes,ShellApi,  SysUtils, Dialogs, inifiles,
 GlobalType, UNanoeduClasses, UNanoeduBaseClasses;

const NTSPBIDEntif_len = 20;
const ScannerNameLen =  12;

function  ReadAdapterHeader1(pRecHeader:PInteger) :boolean;
procedure initScannerLinRecords(Mode:integer);
procedure InitAdapterBufers;
procedure FreeAdapterBufers;
procedure InitAdapterHeaderBufRecord() ;
//procedure CopyLinCurve_toRec(CurveArray:ArraySpline; PointsNmb:integer; curvePageNmb:integer;  Rec: RLinearizationPointsRecord64);
procedure ReadAdapterHeader();
procedure WriteAdapterHeader();
procedure SaveScannernametoIni(ScName:string; FName:string);

var flgAdapterNotFilled:boolean;
    flgAdapterEmpty:boolean;

implementation

uses mHardWareOpt,GlobalVar,CSPMVar,GlobalFunction,Math,frNoFormUnitLoc, uScannerCorrect, SIOCSPM;

function ReadAdapterHeader1(pRecHeader:PInteger) :boolean;
begin

end;

procedure SaveScannernametoIni(ScName:string; FName:string);
var  strings: TStringList;
begin
  strings := TStringList.Create;
  strings.LoadFromFile(fname);
  strings[0]:='['+ScName+']';
  strings.SaveToFile(fname);
  strings.Free;
end;

procedure initAdapterHeaderBufRecord() ;
begin
  with PAdapterHead^ do
    begin
       PageNmb:=0;
       PageTypeId:= AdaptPgType_header;
       aflgUnit:=nano;
       NTSPBId:= NTSPBIdentif;
       ProtocolVers:=1;
       ScannerNumber:=HardWareOpt.ScannerNumb;
    end;
end;


procedure initScannerLinRecords(Mode:integer);
begin
  (*  ScannerOptModX_Adapt, ScannerOptModY_Adapt:ScannerOptFloatRecord;//RScannerOptRecord;
  ScannerHeadRecord:RScannerHeadRecord;
  ScanerLinModXAxisX,ScanerLinModXAxisY,
  ScanerLinModYAxisX, ScanerLinModYAxisY : RLinearizationPointsRecord64;  *)

  (*
  RScannerOptFloatRecord=packed record                // Ola
       PageNmb:integer;
       PageTypeId: integer;//Memorypagetype;
       DataLengthInt:integer;
       DZdclnX:single;
       DZdclnY:single;
       NonLinFieldX,
       NonLinFieldY:integer;     //nm
       GridCellSize:integer; //nm
       intYBiasTan:single;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:single;
       SensitivX:single;
       SensitivY:single;
       I_VTransfKoef:single;

       pgXmodeParams = 1;               // Ola Memory pages consts
 pgXmodeXAxis =  2;
 pgXModeYAxis =  3;
 pgYmodeParams = 4;
 pgYmodeXAxis =  5;
 pgYmodeYAxis =  6;
*)
(*if Mode = OneX then
  begin
  with  ScannerOptModX_Adapt do
    begin
       PageNmb:=pgXmodeParams;
       PageTypeId:= AdaptPgType_params;
       DataLengthInt:=sizeof(RScannerOptFloatRecord) div sizeof(Integer);
       DZdclnX:=ScannerOptModX.DZdclnX;
       DZdclnY:=ScannerOptModX.DZdclnY;
       NonLinFieldX:=ScannerOptModX.NonLinFieldX;
       NonLinFieldY:=ScannerOptModX.NonLinFieldY;     //nm
       GridCellSize:=ScannerOptModX.GridCellSize; //nm
       YBiasTan:=ScannerOptModX.YBiasTan;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=ScannerOptModX.SensitivZ;
       SensitivX:=ScannerOptModX.SensitivX;
       SensitivY:=ScannerOptModX.SensitivY;
       I_VTransfKoef:=ScannerOptModX.I_VTransfKoef;
    end ;
      CopyLinCurve_toRec(XXSp,  NXSplines, pgXmodeXAxis,  ScanerLinModXAxisX);   //для оси 'X' В моде X
      CopyLinCurve_toRec(XYSp,  NYSplines, pgXmodeYAxis,  ScanerLinModXAxisY);  //для оси 'Y' В моде X
  end
  else
  begin
     with  ScannerOptModY_Adapt do
    begin
       PageNmb:=pgYmodeParams;
       PageTypeId:= AdaptPgType_params;
       DataLengthInt:=sizeof(RScannerOptFloatRecord) div sizeof(Integer);
       DZdclnX:=ScannerOptMody.DZdclnX;
       DZdclnY:=ScannerOptMody.DZdclnY;
       NonLinFieldX:=ScannerOptMody.NonLinFieldX;
       NonLinFieldY:=ScannerOptMody.NonLinFieldY;     //nm
       GridCellSize:=ScannerOptMody.GridCellSize; //nm
       YBiasTan:=ScannerOptMody.YBiasTan;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=ScannerOptMody.SensitivZ;
       SensitivX:=ScannerOptMody.SensitivX;
       SensitivY:=ScannerOptMody.SensitivY;
       I_VTransfKoef:=ScannerOptMody.I_VTransfKoef;
    end;
      CopyLinCurve_toRec(XXSp,  NXSplines, pgYmodeXAxis,  ScanerLinModYAxisX); //для оси 'X' В моде Y
      CopyLinCurve_toRec(XYSp,  NYSplines, pgYmodeYAxis,  ScanerLinModYAxisY);   //для оси 'Y' В моде Y
    end;
  *)
end;

(*
procedure CopyLinCurve_toRec(CurveArray:ArraySpline; PointsNmb:integer; curvePageNmb:integer;  Rec: RLinearizationPointsRecord64);
var i:integer;
begin
   with Rec do
     begin
       pageNmb:= curvePageNmb;
       PageTypeId:=AdaptPgType_Curve;
       DataLengthInt:= NPoints+ 5;
       intLinearizationDate:=0;
       NPoints:=PointsNmb;
       for I := 1 to pointsNmb do
          Points[i]:= round( CurveArray[i]);
     end;
end;
*)
procedure InitAdapterBufers;
var val,i:integer;
begin
   val:=0;
  GetMem(pAdapterOptModX,sizeof(RAdapterOptFloatRecord));
  FillMemory(pAdapterOptModX,sizeof(RAdapterOptFloatRecord),val);
  GetMem(pAdapterOptModY,sizeof(RAdapterOptFloatRecord));
  FillMemory(pAdapterOptModY,sizeof(RAdapterOptFloatRecord),val);
  GetMem(pAdapterHead,sizeof(RAdapterHeadRecord));
  FillMemory(pAdapterHead,sizeof(RAdapterHeadRecord),val);
  GetMem(pAdapterLinModXAxisX,sizeof(RAdapterLinPointsRecord64));
  FillMemory(pAdapterLinModXAxisX,sizeof(RAdapterLinPointsRecord64),val);
  GetMem(pAdapterLinModXAxisY,sizeof(RAdapterLinPointsRecord64));
  FillMemory(pAdapterLinModXAxisY,sizeof(RAdapterLinPointsRecord64),val);
  GetMem(pAdapterLinModYAxisX,sizeof(RAdapterLinPointsRecord64));
  FillMemory(pAdapterLinModYAxisX,sizeof(RAdapterLinPointsRecord64),val);
  GetMem(pAdapterLinModYAxisY,sizeof(RAdapterLinPointsRecord64));
  FillMemory(pAdapterLinModYAxisY,sizeof(RAdapterLinPointsRecord64),val);
end;

procedure FreeAdapterBufers;
begin
  FreeMem(pAdapterOptModX);
  FreeMem(pAdapterOptModY);
  FreeMem(pAdapterHead);
  FreeMem(pAdapterLinModXAxisX);
  FreeMem(pAdapterLinModXAxisY);
  FreeMem(pAdapterLinModYAxisX);
  FreeMem(pAdapterLinModYAxisY);
end;

procedure ReadAdapterHeader();
var  StartPage,pagesnmb:integer;
begin
    StartPage:=1;   //   !!
    Nanoedu.ReadFromMLPCMethod(StartPage);
    Nanoedu.Method.Launch;
end;

procedure WriteAdapterHeader();
begin

end;
 initialization
   flgAdapterNotFilled:=False;
end.
