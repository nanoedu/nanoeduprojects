unit BaseTypes;

{$IFNDEF FPC}
{$I jedi.inc}
{$ENDIF}

interface

uses
  Types;

const
  CrLf = #13#10;

// DataType Constants Definition
const
  MinSingle   =  1.5e-45;
  MaxSingle   =  3.4e+38;
  MinDouble   =  5.0e-324;
  MaxDouble   =  1.7e+308;
  MinExtended =  3.4e-4932;
  MaxExtended =  1.1e+4932;
  MinComp     = -9.223372036854775807e+18;
  MaxComp     =  9.223372036854775807e+18;
  MinFloat48  =  2.9e-39;
  MaxFloat48  =  1.7e+38;

  MinPhysValue                 = 1E-50;
  MaxPhysValue                 = 1E+50;
  MinPhysValuePower            = -50;
  MaxPhysValuePower            = 50;
  C_MinPhysMantissa            = 1E-14;
  C_MinAlignAngleStep : Double = 360.0 / 1000000000;
  C_MaxAlignAngleStep : Double = 360.0;
  C_AngleEpsilon      : Double = 360.0 * C_MinPhysMantissa;

  MinFloat32  = MinSingle;
  MaxFloat32  = MaxSingle;
  MinFloat64  = MinDouble;
  MaxFloat64  = MaxDouble;
  MinFloat80  = MinExtended;
  MaxFloat80  = MaxExtended;
  MinFloatFix = MinComp;
  MaxFloatFix = MaxComp;

  Int8ID     = -1;
  UInt8ID    = 1;
  Word8ID    = 1;
  Int16ID    = -2;
  UInt16ID   = 2;
  Word16ID   = 2;
  Int32ID    = -4;
  UInt32ID   = 4;
  Word32ID   = 4;
  Int64ID    = -8;
  Float32ID  = -(4 + 23 * 256);
  Float48ID  = -(6 + 39 * 256);
  Float64ID  = -(8 + 52 * 256);
  Float80ID  = -(10 + 63 * 256);
  FloatFixID = -(8 + $10000);

  I8ID    = Int8ID;
  UI8ID   = UInt8ID;
  W8ID    = Word8ID;
  I16ID   = Int16ID;
  UI16ID  = UInt16ID;
  W16ID   = Word16ID;
  I32ID   = Int32ID;
  UI32ID  = UInt32ID;
  W32ID   = Word32ID;
  I64ID   = Int64ID;
  F32ID   = Float32ID;
  F48ID   = Float48ID;
  F64ID   = Float64ID;
  F80ID   = Float80ID;
  FFxID   = FloatFixID;

  ByteID     = Word8ID;
  ShortIntID = Int8ID;
  WordID     = Word16ID;
  SmallIntID = Int16ID;
  CardinalID = Word32ID;
  IntegerID  = Int32ID;
  CompID     = Int64ID;
  SingleID   = Float32ID;
  Real48ID   = Float48ID;
  RealID     = Float48ID;
  DoubleID   = Float64ID;
  ExtendedID = Float80ID;
  CurrencyID = FloatFixID;
type
  USHORT = Word;

//DataType type names definition
  Bool8         = ByteBool;
  PBool8        = ^Bool8;
  Bool16        = WordBool;
  PBool16       = ^Bool16;
  Bool32        = LongBool;
  PBool32       = ^Bool32;
  Int32         = Integer;
  PInt32        = ^Int32;
  UInt32        = Cardinal;
  PUInt32       = ^UInt32;
  Word32        = Cardinal;
  PWord32       = ^Word32;
  Int16         = Smallint;
  PInt16        = ^Int16;
  UInt16        = Word;
  PUInt16       = ^UInt16;
  Word16        = Word;
  PWord16       = ^Word16;
  Int8          = ShortInt;
  PInt8         = ^Int8;
  UInt8         = Byte;
  PUInt8        = ^UInt8;
  Word8         = Byte;
  PWord8        = ^Word8;
  Float32       = Single;
  PFloat32      = ^Float32;
  Float48       = Real48;
  PFloat48      = ^Float48;
  Float64       = Double;
  PFloat64      = ^Float64;
  Float80       = Extended;
  PFloat80      = ^Float80;
  FloatFix      = Currency;
  PFloatFix     = ^FloatFix;
{$IFDEF DARWIN}
  Real48 = Double;
{$ENDIF}

  B8    = Bool8;
  B16   = Bool16;
  B32   = Bool32;
  I8    = Int8;
  UI8   = Word8;
  W8    = Word8;
  I16   = Int16;
  UI16  = Word16;
  W16   = Word16;
  I32   = Int32;
  UI32  = Word32;
  W32   = Word32;
  I64   = Int64;
  F32   = Float32;
  F48   = Float48;
  F64   = Float64;
  F80   = Float80;
  FFx   = Currency;

  SingleComplex = packed record
    R: Float32;
    I: Float32;
  end;

  DoubleComplex = packed record
    R: Float64;
    I: Float64;
  end;

  ExtendedComplex = packed record
    R: Float80;
    I: Float80;
  end;

  Complex = DoubleComplex;

  PDigitVar = ^TDigitVar;
  TDigitVar = record
//    Reserved0: Word;
    case DigitTypeID: Int32 of
      Int8ID:       (VInt8: Int8);
      Int16ID:      (VInt16: Int16);
      Int32ID:      (VInt32: Int32);
      Int64ID:      (VInt64: Int64);
      Word8ID:      (VWord8: Word8);
      Word16ID:     (VWord16: Word16);
      Word32ID:     (VWord32: Word32);
      Float32ID:    (VFloat32: Float32);
      Float48ID:    (VFloat48: Float48);
      Float64ID:    (VFloat64: Float64);
      Float80ID:    (VFloat80: Float80);
      0:            (VAny: array[0..0] of Byte);
  end;

const
  MinInt16 = Low(Int16);
  MaxInt16 = High(Int16);
  Int16Range = 65535;

  RangeI16: Integer = High(I16) - Low(I16) - 2;
  MinI16:   Integer = Low(I16) + 1;

type
{$IFDEF FPC}
  TArrayOfShortInt = array[0..10000] of ShortInt;
  TArrayOfByte = array[0..10000] of Byte;
  TArrayOfSmallInt = array[0..10000] of SmallInt;
  TArrayOfWord = array[0..10000] of Word;
  TArrayOfInteger = array[0..10000] of Integer;
  TArrayOfCardinal = array[0..10000] of Cardinal;
  TArrayOfInt64 = array[0..10000] of Int64;
  TArrayOfReal48 = array[0..10000] of Real48;
  TArrayOfSingle = array[0..10000] of Single;
  TArrayOfDouble = array[0..10000] of Double;
  TArrayOfExtended = array[0..10000] of Extended;
  TArrayOfComp = array[0..10000] of Comp;
  TArrayOfCurrency = array[0..10000] of Currency;
{$ELSE}
  TArrayOfShortInt = array[0..High(Integer) div Sizeof(ShortInt) - 1] of ShortInt;
  TArrayOfByte = array[0..High(Integer) div Sizeof(Byte) - 1] of Byte;
  TArrayOfSmallInt = array[0..High(Integer) div Sizeof(SmallInt) - 1] of SmallInt;
  TArrayOfWord = array[0..High(Integer) div Sizeof(Word) - 1] of Word;
  TArrayOfInteger = array[0..High(Integer) div Sizeof(Integer) - 1] of Integer;
  TArrayOfCardinal = array[0..High(Integer) div Sizeof(Cardinal) - 1] of Cardinal;
  TArrayOfInt64 = array[0..High(Integer) div Sizeof(Int64) - 1] of Int64;
  TArrayOfReal48 = array[0..High(Integer) div Sizeof(Real48) - 1] of Real48;
  TArrayOfSingle = array[0..High(Integer) div Sizeof(Single) - 1] of Single;
  TArrayOfDouble = array[0..High(Integer) div Sizeof(Double) - 1] of Double;
  TArrayOfExtended = array[0..High(Integer) div Sizeof(Extended) - 1] of Extended;
  TArrayOfComp = array[0..High(Integer) div Sizeof(Comp) - 1] of Comp;
  TArrayOfCurrency = array[0..High(Integer) div Sizeof(Currency) - 1] of Currency;
{$ENDIF}

  PArrayOfShortInt = ^TArrayOfShortInt;
  PArrayOfByte = ^TArrayOfByte;
  PArrayOfSmallInt = ^TArrayOfSmallInt;
  PArrayOfWord = ^TArrayOfWord;
  PArrayOfInteger = ^TArrayOfInteger;
  PArrayOfCardinal = ^TArrayOfCardinal;
  PArrayOfInt64 = ^TArrayOfInt64;
  PArrayOfReal48 = ^TArrayOfReal48;
  PArrayOfSingle = ^TArrayOfSingle;
  PArrayOfDouble = ^TArrayOfDouble;
  PArrayOfExtended = ^TArrayOfExtended;
  PArrayOfComp = ^TArrayOfComp;
  PArrayOfCurrency = ^TArrayOfCurrency;

  TArrayOfInt8 = TArrayOfShortInt;
  TArrayOfUInt8 = TArrayOfByte;
  TArrayOfWord8 = TArrayOfByte;
  TArrayOfInt16 = TArrayOfSmallInt;
  TArrayOfUInt16 = TArrayOfWord;
  TArrayOfWord16 = TArrayOfWord;
  TArrayOfInt32 = TArrayOfInteger;
  TArrayOfUInt32 = TArrayOfCardinal;
  TArrayOfWord32 = TArrayOfCardinal;
  TArrayOfFloat32 = TArrayOfSingle;
  TArrayOfFloat48 = TArrayOfReal48;
  TArrayOfFloat64 = TArrayOfDouble;
  TArrayOfFloat80 = TArrayOfExtended;
  TArrayOfFloatFix = TArrayOfCurrency;

  PArrayOfInt8 = PArrayOfShortInt;
  PArrayOfUInt8 = PArrayOfByte;
  PArrayOfWord8 = PArrayOfByte;
  PArrayOfInt16 = PArrayOfSmallInt;
  PArrayOfUInt16 = PArrayOfWord;
  PArrayOfWord16 = PArrayOfWord;
  PArrayOfInt32 = PArrayOfInteger;
  PArrayOfUInt32 = PArrayOfCardinal;
  PArrayOfWord32 = PArrayOfCardinal;
  PArrayOfFloat32 = PArrayOfSingle;
  PArrayOfFloat48 = PArrayOfReal48;
  PArrayOfFloat64 = PArrayOfDouble;
  PArrayOfFloat80 = PArrayOfExtended;
  PArrayOfFloatFix = PArrayOfCurrency;

  AI8  = TArrayOfInt8;
  AUI8 = TArrayOfUInt8;
  AW8  = TArrayOfWord8;
  AI16 = TArrayOfInt16;
  AUI16 = TArrayOfUInt16;
  AW16 = TArrayOfWord16;
  AI32 = TArrayOfInt32;
  AUI32 = TArrayOfUInt32;
  AW32 = TArrayOfWord32;
  AI64 = TArrayOfInt64;
  AF32 = TArrayOfFloat32;
  AF48 = TArrayOfFloat48;
  AF64 = TArrayOfFloat64;
  AF80 = TArrayOfFloat80;
  AFFix = TArrayOfFloatFix;

  PAI8  = PArrayOfInt8;
  PAUI8  = PArrayOfUInt8;
  PAW8  = PArrayOfWord8;
  PAI16 = PArrayOfInt16;
  PAUI16 = PArrayOfUInt16;
  PAW16 = PArrayOfWord16;
  PAI32 = PArrayOfInt32;
  PAUI32 = PArrayOfUInt32;
  PAW32 = PArrayOfWord32;
  PAI64 = PArrayOfInt64;
  PAF32 = PArrayOfFloat32;
  PAF48 = PArrayOfFloat48;
  PAF64 = PArrayOfFloat64;
  PAF80 = PArrayOfFloat80;
  PAFFix = PArrayOfFloatFix;

  TPhysLimits = packed record
    Min: Float64;
    Max: Float64;
  end;

  TPhysPoint = packed record
    X: Float64;
    Y: Float64;
  end;

  TPhysLine = packed record
    case Integer of
      0: (BeginX, BeginY, EndX, EndY: Float64);
      1: (BeginXY, EndXY: TPhysPoint);
  end;

  TPhysRect = packed record
    case Integer of
      0: (MinX, MinY, MaxX, MaxY: Float64);
      1: (MinXY, MaxXY: TPhysPoint);
  end;
  PPhysRect = ^TPhysRect;

  TDataRect = packed record
    case Integer of
      0: (StartX, StartY, EndX, EndY: Integer);
      1: (StartXY, EndXY: TPoint);
  end;

  TRGB = record
    B, G, R: Byte;
  end;
  PRGB = ^TRGB;

  TRGBQuad = packed record
    rgbBlue: Byte;
    rgbGreen: Byte;
    rgbRed: Byte;
    rgbReserved: Byte;
  end;
  PRGBQuad = ^TRGBQuad;

  TRGBTriple = packed record
    rgbtBlue: Byte;
    rgbtGreen: Byte;
    rgbtRed: Byte;
  end;
  PRGBTriple = ^TRGBTriple;

  TArrayOfBoolean = array[0..High(Integer) div Sizeof(Boolean) - 1] of Boolean;
  PArrayOfBoolean = ^TArrayOfBoolean;
  TArrayOfPointer = array[0..High(Integer) div Sizeof(Pointer) - 1] of Pointer;
  PArrayOfPointer = ^TArrayOfPointer;
  TArrayOfString = array[0..High(Integer) div Sizeof(string) - 1] of string;
  PArrayOfString = ^TArrayOfString;
  TArrayOfPoint = array[0..High(Integer) div Sizeof(TPoint) - 1] of TPoint;
  PArrayOfPoint = ^TArrayOfPoint;
  TArrayOfRect = array[0..High(Integer) div Sizeof(TRect) - 1] of TRect;
  PArrayOfRect = ^TArrayOfRect;
  TArrayOfDataRect = array[0..High(Integer) div Sizeof(TDataRect) - 1] of TDataRect;
  PArrayOfDataRect = ^TArrayOfDataRect;
  TArrayOfPhysRect = array[0..High(Integer) div Sizeof(TPhysRect) - 1] of TPhysRect;
  PArrayOfPhysRect = ^TArrayOfPhysRect;
  TArrayOfRGBQuad = array[0..High(Integer) div Sizeof(TRGBQuad) - 1] of TRGBQuad;
  PArrayOfRGBQuad = ^TArrayOfRGBQuad;
  TArrayOfRGBTriple = array[0..High(Integer) div Sizeof(TRGBTriple) - 1] of TRGBTriple;
  PArrayOfRGBTriple = ^TArrayOfRGBTriple;

  TArrayOfComplex = array[0..High(Integer) div Sizeof(Complex) - 1] of Complex;
  PArrayOfComplex = ^TArrayOfComplex;
  TArrayOfGUID = array[0..High(Integer) div Sizeof(TGUID) - 1] of TGUID;
  PArrayOfGUID = ^TArrayOfGUID;

  TAdjustment = (aFloor, aCeil, aRound);
  TParamsStorage = (psIniFile, psRegistry{, psResource, psStream, psXML});
  TViewerType = (vt1D, vt2D, vt3D, vtText);

  TOrientation = (oHorizontal, oVertical);
  TDirection = (dirForward, dirBackward);
  TDirOrientation = (doForwHoriz, doBackHoriz, doForwVert, doBackVert);
  TAxisEnum = (axX, axY, axZ);

  TObjProcedure = procedure of object;

// Scan definitions
  TScanLocation = (slHLT, slHLB, slHRT, slHRB, slVLT, slVLB, slVRT, slVRB);
  TScanLocationRecord = packed record
    Orient: TOrientation;
    FastDir: TDirection;
    SlowDir: TDirection;
  end;
const
  ScanLocations: array[TScanLocation] of TScanLocationRecord = (
    (Orient: oHorizontal; FastDir: dirForward;  SlowDir: dirBackward),
    (Orient: oHorizontal; FastDir: dirForward;  SlowDir: dirForward ),
    (Orient: oHorizontal; FastDir: dirBackward; SlowDir: dirBackward),
    (Orient: oHorizontal; FastDir: dirBackward; SlowDir: dirForward ),
    (Orient: oVertical;   FastDir: dirBackward; SlowDir: dirForward ),
    (Orient: oVertical;   FastDir: dirForward;  SlowDir: dirForward ),
    (Orient: oVertical;   FastDir: dirBackward; SlowDir: dirBackward),
    (Orient: oVertical;   FastDir: dirForward;  SlowDir: dirBackward)
  );
  ScanLocationNames: array[TScanLocation] of string = (
    'Horizontal Left Top', 'Horizontal Left Bottom', 'Horizontal Right Top',
    'Horizontal Right Bottom', 'Vertical Left Top', 'Vertical Left Bottom',
    'Vertical Right Top', 'Vertical Right Bottom');
  ScanLocationShortNames: array [TScanLocation] of string =
    ('HLT', 'HLB', 'HRT', 'HRB', 'VLT', 'VLB', 'VRT', 'VRB');
//

type
  TArrayTransProc = procedure(pSrc, pDst: Pointer; Size: Integer);

//3D point type definition
  TPoint2D_I32 = packed record
    x: Int32;
    y: Int32;
  end;

  TPoint3D_F80 = packed record
    x: Float80;
    y: Float80;
    z: Float80;
  end;

  TPoint3D_F64 = packed record
    x: Float64;
    y: Float64;
    z: Float64;
  end;

  TPoint3D_I32 = packed record
    x: Int32;
    y: Int32;
    z: Int32;
  end;

  TPoint3D_F32 = packed record
    x: Float32;
    y: Float32;
    z: Float32;
  end;

  TPoint2D_F32 = packed record
    x: Float32;
    y: Float32;
  end;


//-----------------------------------------------------------------------------
const
  GUID_NULL: TGUID = '{00000000-0000-0000-0000-000000000000}';
  RECT_NULL: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);

function DataTypeMemSize(DataType: Integer): Integer; register; inline;

function RectWidth( ARect: TRect ): Integer;
function RectHeight( ARect: TRect ): Integer;

function DataRect(AStartX, AStartY, AEndX, AEndY: Integer): TDataRect; inline;
function PhysPoint(AX, AY: Double): TPhysPoint; inline;
function PhysLine(ABeginX, ABeginY, AEndX, AEndY: Double): TPhysLine; inline;
function PhysRect(AMinX, AMinY, AMaxX, AMaxY: Double): TPhysRect; inline;

function Point3D_F80(X, Y, Z: Float80): TPoint3D_F80; inline;
function Point3D_I32(X, Y, Z: Int32): TPoint3D_I32; inline;

function IsPhysZero(AValue: Double): Boolean; overload;
function IsPhysZero(AValue, Epsilon: Double): Boolean; overload;
function NotPhysZero(AValue: Double): Boolean; overload;
function NotPhysZero(AValue, Epsilon: Double): Boolean; overload;
function IsPhysSame(AValue1, AValue2: Double ): Boolean; overload;
function IsPhysSame(AValue1, AValue2, Epsilon: Double ): Boolean; overload;
function NotPhysSame(AValue1, AValue2: Double ): Boolean; overload;
function NotPhysSame(AValue1, AValue2, Epsilon: Double ): Boolean; overload;
function IsPhysLess(AValue1, AValue2: Double ): Boolean; overload;
function IsPhysLess(AValue1, AValue2, Epsilon: Double ): Boolean; overload;
function IsPhysLarger(AValue1, AValue2: Double ): Boolean; overload;
function IsPhysLarger(AValue1, AValue2, Epsilon: Double ): Boolean; overload;
function IsPhysEqualLess(AValue1, AValue2: Double ): Boolean; overload;
function IsPhysEqualLess(AValue1, AValue2, Epsilon: Double ): Boolean; overload;
function IsPhysEqualLarger(AValue1, AValue2: Double ): Boolean; overload;
function IsPhysEqualLarger(AValue1, AValue2, Epsilon: Double ): Boolean; overload;

function IsPhysRectEmpty(APhysRect: TPhysRect): Boolean;

function EnsureDataRect(AStartX, AStartY, AEndX, AEndY: Integer): TDataRect; overload;
function EnsureDataRect(ADataRect: TDataRect): TDataRect; overload;
function EnsureDataRect(AStartX, AStartY, AEndX, AEndY,
  ABoundStartX, ABoundStartY, ABoundEndX, ABoundEndY: Integer): TDataRect; overload;
function EnsureDataRect(ADataRect, ABoundsRect: TDataRect): TDataRect; overload;
function EnsureRect(ALeft, ATop, ARight, ABottom: Longint): TRect; overload;
function EnsureRect(ARect: TRect): TRect; overload;
function EnsurePhysRect(AMinX, AMinY, AMaxX, AMaxY: Double): TPhysRect; overload;
function EnsurePhysRect(APhysRect: TPhysRect): TPhysRect; overload;
function EnsurePhysLine(ABeginX, ABeginY, AEndX, AEndY: Double): TPhysLine; overload;
function EnsurePhysLine(APhysLine: TPhysLine): TPhysLine; overload;

function BorderToRect(ARect: TRect): TRect;
function RectToBorder(ARect: TRect): TRect;
function DataRectToRect(ADataRect: TDataRect): TRect;
function RectToDataRect(ARect: TRect): TDataRect;
function RectInRect(r1, r2: TRect): Boolean;
function RectOutRect(r1, r2: TRect): Boolean;
function GetInnerRect(ABounds, AMargins: TRect): TRect;
procedure ResizeRect(var ARect: TRect; dx, dy: Integer; Side: Integer);

function PointInDataRect(ADataRect: TDataRect; APoint: TPoint): Boolean;
function DataRectInRect(ADataRect1, ADataRect2: TDataRect): Boolean;
function DataRectOutRect(ADataRect1, ADataRect2: TDataRect): Boolean;
procedure OffsetDataRect(var ADataRect: TDataRect; dx, dy: Integer);
function IntersectDataRect(var DstDataRect: TDataRect; ADataRect1, ADataRect2: TDataRect): Boolean;

function PhysRectInRect(r1, r2: TPhysRect): Boolean;
function PhysRectOutRect(r1, r2: TPhysRect): Boolean;
function IntersectPhysRect(var Dst: TPhysRect; Src1, Src2: TPhysRect): Boolean;
procedure OffsetPhysRect(var APhysRect: TPhysRect; dx, dy: Double);
procedure InflatePhysRect(var APhysRect: TPhysRect; dx, dy: Double);
procedure ScalePhysRect(var APhysRect: TPhysRect; kx, ky: Double);
function PhysPointInRect(APhysRect: TPhysRect; APhysPoint: TPhysPoint): Boolean;
function PhysLineOutRect(p0, p1: TPhysPoint; r: TPhysRect): Boolean;
function ShiftPhysPointToBounds(ABoundsPhysRect: TPhysRect; var APhysPoint: TPhysPoint): Boolean;
function ShiftPhysRectToBounds(ABoundsPhysRect: TPhysRect; var APhysRect: TPhysRect): Boolean;

function AdjustValue(Value: Double; Adjustment: TAdjustment): Integer;
function DataToPhysPoint(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  ADataPoint: TPoint): TPhysPoint;
function PhysToDataPoint(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  APhysPoint: TPhysPoint; AdjX: TAdjustment = aRound; AdjY: TAdjustment = aRound): TPoint;
function PhysToDataRect(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  APhysRect: TPhysRect; AdjX0: TAdjustment = aRound; AdjY0: TAdjustment = aRound;
  AdjX1: TAdjustment = aRound; AdjY1: TAdjustment = aRound): TDataRect;
function DataToPhysRect(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  ADataRect: TDataRect): TPhysRect;
function  PhysToScreenPoint(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  APhysPoint: TPhysPoint): TPoint;
function  ScreenToPhysPoint(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  AScreenPoint: TPoint): TPhysPoint;
function  PhysToScreenRect(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  APhysRect: TPhysRect): TRect;
function  ScreenToPhysRect(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  AScreenRect: TRect): TPhysRect;
function FloatDataToPhysPoint(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  AFloatDataPoint: TPhysPoint): TPhysPoint;
function PhysToFloatDataPoint(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  APhysPoint: TPhysPoint): TPhysPoint;
function PhysToFloatDataRect(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  APhysRect: TPhysRect): TPhysRect;
function FloatDataToPhysRect(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  AFloatDataRect: TPhysRect): TPhysRect;
function  PhysToScreenX(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  AValue: Double): Integer;
function  ScreenToPhysX(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  AValue: Integer): Double;
function  PhysToScreenY(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  AValue: Double): Integer;
function  ScreenToPhysY(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  AValue: Integer): Double;

function Compare(const v1, v2: Double): Boolean; overload;
function Compare(const v1, v2: TDataRect): Boolean; overload;
function Compare(const v1, v2: TPoint): Boolean; overload;
function Compare(const v1, v2: TRect): Boolean; overload;
function Compare(const v1, v2: TPhysPoint): Boolean; overload;
function Compare(const v1, v2: TPhysRect): Boolean; overload;
function Compare(const guid1, guid2: TGUID): Boolean; overload;

procedure Exchange(var v1, v2: Float32); overload; inline;
procedure Exchange(var v1, v2: Float64); overload; inline;
{$IFNDEF FPC}
procedure Exchange(var v1, v2: Float80); overload; inline;
{$ENDIF}
procedure Exchange(var v1, v2: Int8); overload; inline;
procedure Exchange(var v1, v2: Int16); overload; inline;
procedure Exchange(var v1, v2: Int32); overload; inline;
procedure Exchange(var v1, v2: Pointer); overload; inline;

procedure Exchange(var v1, v2; DataType: Integer); overload;

//function IsEqualGUID(const guid1, guid2: TGUID): Boolean;

function RemoveSpace(s: string): string;

function Ceil64(const X: Double): Int64;
function Floor64(const X: Double): Int64;
function MathRound(AValue: Double): Integer; inline;
function GetFloorExponent(AValue: Double): Integer;
function GetValueExponent(AValue: Double): Integer;
function AdjustDegree(Angle: Double): Double;
function AngleBySinCos(ASin, ACos: Double; AllowNegativeResult: Boolean = True): Double;

{$IFDEF DELPHI2009_UP}
type
  CPointer = PByte;
  CPItem = Byte;
{$ELSE}
type
  CPointer = PChar;
  CPItem = Char;
  TSysCharSet = set of AnsiChar;
function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean; overload; inline;
function CharInSet(C: WideChar; const CharSet: TSysCharSet): Boolean; overload; inline;
function StrLen(const Str: PAnsiChar): Cardinal; overload;
function StrLen(const Str: PWideChar): Cardinal; overload;
function StrMove(Dest: PAnsiChar; const Source: PAnsiChar; Count: Cardinal): PAnsiChar; overload;
function StrMove(Dest: PWideChar; const Source: PWideChar; Count: Cardinal): PWideChar; overload;
function AnsiStrAlloc(Size: Cardinal): PAnsiChar;
function WideStrAlloc(Size: Cardinal): PWideChar;
{$ENDIF}

implementation

uses
	{$IFNDEF FPC}MathUtils{$ELSE}Math{$ENDIF};

//function IsEqualGUID; external 'ole32.dll' name 'IsEqualGUID';


function DataTypeMemSize(DataType: Integer): Integer; register; inline;
begin
  case DataType of
    W8ID:  Result := 1;
    I8ID:  Result := 1;
    W16ID: Result := 2;
    I16ID: Result := 2;
    W32ID: Result := 4;
    I32ID: Result := 4;
    I64ID: Result := 8;
    F32ID: Result := 4;
    F48ID: Result := 6;
    F64ID: Result := 8;
    F80ID: Result := 10;
  else
    Result := 0;
  end;
end;
//------------------------------------------------------------------------------
function RectWidth(ARect: TRect): Integer;
begin
  with ARect do
    if Right >= Left then
      Result := Right - Left
    else
      Result := Left - Right;
end;
//------------------------------------------------------------------------------
function RectHeight(ARect: TRect): Integer;
begin
  with ARect do
    if Bottom >= Top then
      Result := Bottom - Top
    else
      Result := Top - Bottom;
end;
//------------------------------------------------------------------------------
function DataRect(AStartX, AStartY, AEndX, AEndY: Integer): TDataRect;
begin
  Result.StartX := AStartX;
  Result.StartY := AStartY;
  Result.EndX := AEndX;
  Result.EndY := AEndY;
end;
//------------------------------------------------------------------------------
function PhysPoint(AX, AY: Double): TPhysPoint;
begin
  Result.X := AX;
  Result.Y := AY;
end;
//------------------------------------------------------------------------------
function PhysLine(ABeginX, ABeginY, AEndX, AEndY: Double): TPhysLine;
begin
  Result.BeginX := ABeginX;
  Result.BeginY := ABeginY;
  Result.EndX := AEndX;
  Result.EndY := AEndY;
end;
//------------------------------------------------------------------------------
function PhysRect(AMinX, AMinY, AMaxX, AMaxY: Double): TPhysRect;
begin
  Result.MinX := AMinX;
  Result.MinY := AMinY;
  Result.MaxX := AMaxX;
  Result.MaxY := AMaxY;
end;
//------------------------------------------------------------------------------
function Point3D_F80(X, Y, Z: Float80): TPoint3D_F80;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;
//------------------------------------------------------------------------------
function Point3D_I32(X, Y, Z: Int32): TPoint3D_I32;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;
//------------------------------------------------------------------------------
function EnsureDataRect(AStartX, AStartY, AEndX, AEndY: Integer): TDataRect;
begin
  Result := DataRect(Min(AStartX, AEndX), Min(AStartY, AEndY), Max(AStartX, AEndX),
    Max(AStartY, AEndY));
end;
//------------------------------------------------------------------------------
function EnsureDataRect(ADataRect: TDataRect): TDataRect;
begin
  with ADataRect do
    Result := EnsureDataRect(StartX, StartY, EndX, EndY);
end;
//------------------------------------------------------------------------------
function EnsureDataRect(AStartX, AStartY, AEndX, AEndY,
  ABoundStartX, ABoundStartY, ABoundEndX, ABoundEndY: Integer): TDataRect;
begin
  Result := EnsureDataRect(AStartX, AStartY, AEndX, AEndY);
  with Result do
  begin
    if StartX < ABoundStartX then StartX := ABoundStartX;
    if StartY < ABoundStartY then StartY := ABoundStartY;
    if EndX > ABoundEndX then EndX := ABoundEndX;
    if EndY > ABoundEndY then EndY := ABoundEndY;
  end;
end;
//------------------------------------------------------------------------------
function EnsureDataRect(ADataRect: TDataRect; ABoundsRect: TDataRect): TDataRect;
begin
  Result := EnsureDataRect(
    ADataRect.StartX, ADataRect.StartY, ADataRect.EndX, ADataRect.EndY,
    ABoundsRect.StartX, ABoundsRect.StartY, ABoundsRect.EndX, ABoundsRect.EndY);
end;
//------------------------------------------------------------------------------
function EnsureRect(ALeft, ATop, ARight, ABottom: Longint): TRect;
begin
  Result := Rect(Min(ALeft, ARight), Min(ATop, ABottom), Max(ALeft, ARight),
    Max(ATop, ABottom));
end;
//------------------------------------------------------------------------------
function EnsureRect(ARect: TRect): TRect;
begin
  with ARect do
    Result := EnsureRect(Left, Top, Right, Bottom);
end;
//------------------------------------------------------------------------------
function EnsurePhysRect(AMinX, AMinY, AMaxX, AMaxY: Double): TPhysRect;
begin
  Result := PhysRect(Min(AMinX, AMaxX), Min(AMinY, AMaxY), Max(AMinX, AMaxX),
    Max(AMinY, AMaxY));
end;
//------------------------------------------------------------------------------
function EnsurePhysRect(APhysRect: TPhysRect): TPhysRect;
begin
  with APhysRect do
    Result := EnsurePhysRect(MinX, MinY, MaxX, MaxY);
end;
//------------------------------------------------------------------------------

function IsPhysZero(AValue: Double): Boolean;                                    begin
  Result := IsZero(AValue, MinPhysValue);                                        end;

function IsPhysZero(AValue, Epsilon: Double): Boolean;                           begin
  Result := IsZero(AValue, Epsilon);                                             end;

function NotPhysZero(AValue: Double): Boolean;                                   begin
  Result := not IsZero(AValue, MinPhysValue);                                    end;

function NotPhysZero(AValue, Epsilon: Double): Boolean;                          begin
  Result := not IsZero(AValue, Epsilon);                                         end;

function IsPhysSame(AValue1, AValue2: Double): Boolean;                          begin
  Result := IsZero(AValue1 - AValue2, MinPhysValue);                             end;

function IsPhysSame(AValue1, AValue2, Epsilon: Double): Boolean;                 begin
  Result := IsZero(AValue1 - AValue2, Epsilon);                                  end;

function NotPhysSame(AValue1, AValue2: Double): Boolean;                         begin
  Result := not IsPhysSame(AValue1, AValue2);                                    end;

function NotPhysSame(AValue1, AValue2, Epsilon: Double): Boolean;                begin
  Result := not IsPhysSame(AValue1, AValue2, Epsilon);                           end;

function IsPhysLess(AValue1, AValue2: Double): Boolean;                          begin
  Result := (AValue1 < AValue2) and not IsZero(AValue1 - AValue2, MinPhysValue); end;

function IsPhysLess(AValue1, AValue2, Epsilon: Double): Boolean;                 begin
  Result := (AValue1 < AValue2) and not IsZero(AValue1 - AValue2, Epsilon);      end;

function IsPhysLarger(AValue1, AValue2: Double): Boolean;                        begin
  Result := (AValue1 > AValue2) and not IsZero(AValue1 - AValue2, MinPhysValue); end;

function IsPhysLarger(AValue1, AValue2, Epsilon: Double): Boolean;               begin
  Result := (AValue1 > AValue2) and not IsZero(AValue1 - AValue2, Epsilon);      end;

function IsPhysEqualLess(AValue1, AValue2: Double): Boolean;                     begin
  Result := (AValue1 < AValue2) or IsZero(AValue1 - AValue2, MinPhysValue);      end;

function IsPhysEqualLess(AValue1, AValue2, Epsilon: Double): Boolean;            begin
  Result := (AValue1 < AValue2) or IsZero(AValue1 - AValue2, Epsilon);           end;

function IsPhysEqualLarger(AValue1, AValue2: Double): Boolean;                   begin
  Result := (AValue1 > AValue2) or IsZero(AValue1 - AValue2, MinPhysValue);      end;

function IsPhysEqualLarger(AValue1, AValue2, Epsilon: Double): Boolean;          begin
  Result := (AValue1 > AValue2) or IsZero(AValue1 - AValue2, Epsilon);           end;

//------------------------------------------------------------------------------

function IsPhysRectEmpty(APhysRect: TPhysRect): Boolean;
begin
  with APhysRect do
    Result := Compare(MinX, MaxX) or Compare(MinY, MaxY);
end;
//------------------------------------------------------------------------------
function EnsurePhysLine(ABeginX, ABeginY, AEndX, AEndY: Double): TPhysLine;
begin
  Result := PhysLine(Min(ABeginX, AEndX), Min(ABeginY, AEndY), Max(ABeginX, AEndX),
    Max(ABeginY, AEndY));
end;
//------------------------------------------------------------------------------
function EnsurePhysLine(APhysLine: TPhysLine): TPhysLine; overload;
begin
  with APhysLine do
    Result := EnsurePhysLine(BeginX, BeginY, EndX, EndY);
end;
//------------------------------------------------------------------------------
function BorderToRect(ARect: TRect): TRect;
begin
  Result := Rect(ARect.Left, ARect.Top, ARect.Right + 1, ARect.Bottom + 1);
end;
//------------------------------------------------------------------------------
function RectToBorder(ARect: TRect): TRect;
begin
  Result := Rect(ARect.Left, ARect.Top, ARect.Right - 1, ARect.Bottom - 1);
end;
//------------------------------------------------------------------------------
function DataRectToRect(ADataRect: TDataRect): TRect;
begin
  Result :=
    Rect(ADataRect.StartX, ADataRect.StartY, ADataRect.EndX + 1, ADataRect.EndY + 1);
end;
//------------------------------------------------------------------------------
function RectToDataRect(ARect: TRect): TDataRect;
begin
  Result := DataRect(ARect.Left, ARect.Top, ARect.Right - 1, ARect.Bottom - 1);
end;
//------------------------------------------------------------------------------
function RectInRect(r1, r2: TRect): Boolean;
begin
  Result := (r2.Left <= r1.Left) and (r1.Right <= r2.Right) and
    (r2.Top <= r1.Top) and (r1.Bottom <= r2.Bottom);
end;
//------------------------------------------------------------------------------
function RectOutRect(r1, r2: TRect): Boolean;
begin
  Result := (r1.Right <= r2.Left) or (r2.Right <= r1.Left) or
    (r1.Top >= r2.Bottom) or (r2.Top >= r1.Bottom);
end;
//------------------------------------------------------------------------------
function GetInnerRect(ABounds, AMargins: TRect): TRect;
begin
  Result := Rect(ABounds.Left + AMargins.Left, ABounds.Top + AMargins.Top,
    ABounds.Right - AMargins.Right, ABounds.Bottom - AMargins.Bottom);
end;
//------------------------------------------------------------------------------
procedure ResizeRect(var ARect: TRect; dx, dy: Integer; Side: Integer);
const
  WMSZ_LEFT = 1;
  WMSZ_RIGHT = 2;
  WMSZ_TOP = 3;
  WMSZ_TOPLEFT = 4;
  WMSZ_TOPRIGHT = 5;
  WMSZ_BOTTOM = 6;
  WMSZ_BOTTOMLEFT = 7;
  WMSZ_BOTTOMRIGHT = 8;
begin
  case Side of
    WMSZ_LEFT: Inc(ARect.Left, dx);
    WMSZ_RIGHT: Inc(ARect.Right, dx);
    WMSZ_TOP: Inc(ARect.Top, dy);
    WMSZ_BOTTOM: Inc(ARect.Bottom, dy);
    WMSZ_TOPLEFT:
      begin
        Inc(ARect.Top, dy);
        Inc(ARect.Left, dx);
      end;
    WMSZ_TOPRIGHT:
      begin
        Inc(ARect.Top, dy);
        Inc(ARect.Right, dx);
      end;
    WMSZ_BOTTOMLEFT:
      begin
        Inc(ARect.Bottom, dy);
        Inc(ARect.Left, dx);
      end;
    WMSZ_BOTTOMRIGHT:
      begin
        Inc(ARect.Bottom, dy);
        Inc(ARect.Right, dx);
      end;
  end;
end;
//------------------------------------------------------------------------------
function PointInDataRect(ADataRect: TDataRect; APoint: TPoint): Boolean;
begin
  Result := PtInRect(BorderToRect(TRect(ADataRect)), APoint);
end;
//------------------------------------------------------------------------------
function DataRectInRect(ADataRect1, ADataRect2: TDataRect): Boolean;
begin
  Result := RectInRect(BorderToRect(TRect(ADataRect1)), BorderToRect(TRect(ADataRect2)));
end;
//------------------------------------------------------------------------------
function DataRectOutRect(ADataRect1, ADataRect2: TDataRect): Boolean;
begin
  Result := RectOutRect(BorderToRect(TRect(ADataRect1)), BorderToRect(TRect(ADataRect2)));
end;
//------------------------------------------------------------------------------
procedure OffsetDataRect(var ADataRect: TDataRect; dx, dy: Integer);
begin
  Inc(ADataRect.StartX, dx);
  Inc(ADataRect.EndX, dx);
  Inc(ADataRect.StartY, dy);
  Inc(ADataRect.EndY, dy);
end;
//------------------------------------------------------------------------------
function IntersectDataRect(var DstDataRect: TDataRect; ADataRect1, ADataRect2: TDataRect): Boolean;
var
  TempRect: TRect;
begin
  Result := IntersectRect(TempRect, BorderToRect(TRect(ADataRect1)), BorderToRect(TRect(ADataRect2)));
  DstDataRect := TDataRect(RectToBorder(TempRect));
end;
//------------------------------------------------------------------------------
function PhysRectInRect(r1, r2: TPhysRect): Boolean;
begin
  Result := ((r2.MinX <= r1.MinX) and (r1.MaxX <= r2.MaxX))
                                  and
            ((r2.MinY <= r1.MinY) and (r1.MaxY <= r2.MaxY));
end;
//------------------------------------------------------------------------------
function PhysRectOutRect(r1, r2: TPhysRect): Boolean;
begin
  Result := (r1.MaxX < r2.MinX) or (r2.MaxX < r1.MinX)
                                or
            (r1.MinY > r2.MaxY) or (r2.MinY > r1.MaxY);
end;
//------------------------------------------------------------------------------
function IntersectPhysRect(var Dst: TPhysRect; Src1, Src2: TPhysRect): Boolean;
begin
  Result := false;
  if PhysRectOutRect(Src1, Src2) then Exit;
  if Src1.MinX < Src2.MinX then Dst.MinX := Src2.MinX else Dst.MinX := Src1.MinX;
  if Src1.MaxX < Src2.MaxX then Dst.MaxX := Src1.MaxX else Dst.MaxX := Src2.MaxX;
  if Src1.MinY < Src2.MinY then Dst.MinY := Src2.MinY else Dst.MinY := Src1.MinY;
  if Src1.MaxY < Src2.MaxY then Dst.MaxY := Src1.MaxY else Dst.MaxY := Src2.MaxY;
  Result := true;
end;
//------------------------------------------------------------------------------
procedure OffsetPhysRect(var APhysRect: TPhysRect; dx, dy: Double);
begin
  with APhysRect do
  begin
    MinX := MinX + dx;
    MaxX := MaxX + dx;
    MinY := MinY + dy;
    MaxY := MaxY + dy;
  end;
end;
//------------------------------------------------------------------------------
procedure InflatePhysRect(var APhysRect: TPhysRect; dx, dy: Double);
begin
  with APhysRect do
  begin
    MinX := MinX - dx;
    MaxX := MaxX + dx;
    MinY := MinY - dy;
    MaxY := MaxY + dy;
  end;
end;
//------------------------------------------------------------------------------
procedure ScalePhysRect(var APhysRect: TPhysRect; kx, ky: Double);
begin
  with APhysRect do
  begin
    MinX := MinX * kx;
    MaxX := MaxX * kx;
    MinY := MinY * ky;
    MaxY := MaxY * ky;
  end;
end;
//------------------------------------------------------------------------------
function PhysPointInRect(APhysRect: TPhysRect; APhysPoint: TPhysPoint): Boolean;
begin
  with APhysRect, APhysPoint do
    Result := (MinX <= X) and (X <= MaxX) and (MinY <= Y) and (Y <= MaxY);
end;
//------------------------------------------------------------------------------
function PhysLineOutRect(p0, p1: TPhysPoint; r: TPhysRect): Boolean;
// Result: ( -1 = Above; 0 = touch; 1 = Below )
  function SideHalfPlane(p0, p1: TPhysPoint; x, y: Double): Integer;
  var t: Double;
  begin
    if Compare(p0.X, p1.X) then t := x - p0.X
    else if Compare(p0.Y, p1.Y) then t := p0.Y - y
    else t := p0.Y + (x - p0.X) * (p1.Y - p0.Y) / (p1.X - p0.X) - y;
    if Compare(t, 0) then Result := 0
    else Result := Round(Abs(t) / t);
  end;
var
  t: Integer;
begin
  t := SideHalfPlane(p0, p1, r.MinX, r.MinY) +
    SideHalfPlane(p0, p1, r.MinX, r.MaxY) +
    SideHalfPlane(p0, p1, r.MaxX, r.MinY) +
    SideHalfPlane(p0, p1, r.MaxX, r.MaxY);
  if Abs(t) <> 4 then
    Result := (max(p0.X, p1.X) < r.MinX) or (r.MaxX < min(p0.X, p1.X)) or
              (max(p0.Y, p1.Y) < r.MinY) or (r.MaxY < min(p0.Y, p1.Y))
  else
    Result := True;
end;
//------------------------------------------------------------------------------
function ShiftPhysPointToBounds(ABoundsPhysRect: TPhysRect;
  var APhysPoint: TPhysPoint): Boolean;
begin
  Result := True;
  with APhysPoint, ABoundsPhysRect do
  begin
    if x < MinX then x := MinX;
    if y < MinY then y := MinY;
    if x > MaxX then x := MaxX;
    if y > MaxY then y := MaxY;
  end;
end;
//------------------------------------------------------------------------------
function ShiftPhysRectToBounds(ABoundsPhysRect: TPhysRect;
  var APhysRect: TPhysRect): Boolean;
var
  dx, dy: Double;
begin
  dx := 0; dy := 0;
  Result := false;
  with ABoundsPhysRect do
  begin
    if APhysRect.MinX < MinX then dx := MinX - APhysRect.MinX
    else if APhysRect.MaxX > MaxX then dx := MaxX - APhysRect.MaxX;
    if APhysRect.MinY < MinY then dy := MinY - APhysRect.MinY
    else if APhysRect.MaxY > MaxY then dy := MaxY - APhysRect.MaxY;
  end;
  if (dx <> 0) or (dy <> 0) then
  begin
    OffsetPhysRect(APhysRect, dx, dy);
    Result := true;
  end;
end;
//------------------------------------------------------------------------------
function AdjustValue(Value: Double; Adjustment: TAdjustment): Integer;
begin
  case Adjustment of
    aFloor: Result := Floor(Value);
    aCeil: Result := Ceil(Value);
  else //aRound
    Result := Round(Value);
  end;
end;
//------------------------------------------------------------------------------
function DataToPhysPoint(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  ADataPoint: TPoint): TPhysPoint;
begin
  if ABoundsDataRect.StartX < ABoundsDataRect.EndX then
    Result.X := ABoundsPhysRect.MinX + (ADataPoint.X - ABoundsDataRect.StartX) *
      (ABoundsPhysRect.MaxX - ABoundsPhysRect.MinX) /
      (ABoundsDataRect.EndX - ABoundsDataRect.StartX)
  else
    Result.X := ABoundsPhysRect.MinX;

  if ABoundsDataRect.StartY < ABoundsDataRect.EndY then
    Result.Y := ABoundsPhysRect.MinY + (ADataPoint.Y - ABoundsDataRect.StartY) *
      (ABoundsPhysRect.MaxY - ABoundsPhysRect.MinY) /
      (ABoundsDataRect.EndY - ABoundsDataRect.StartY)
  else
    Result.Y := ABoundsPhysRect.MinY;
end;
//------------------------------------------------------------------------------
function PhysToDataPoint(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  APhysPoint: TPhysPoint; AdjX, AdjY: TAdjustment): TPoint;
begin
  if ABoundsPhysRect.MinX < ABoundsPhysRect.MaxX then
    Result.X := AdjustValue(
      (ABoundsDataRect.StartX + (APhysPoint.X - ABoundsPhysRect.MinX) *
      (ABoundsDataRect.EndX - ABoundsDataRect.StartX) /
      (ABoundsPhysRect.MaxX - ABoundsPhysRect.MinX)), AdjX)
  else
    Result.X := ABoundsDataRect.StartX;
  if ABoundsPhysRect.MinY < ABoundsPhysRect.MaxY then
    Result.Y := AdjustValue(
      (ABoundsDataRect.StartY + (APhysPoint.Y - ABoundsPhysRect.MinY) *
      (ABoundsDataRect.EndY - ABoundsDataRect.StartY) /
      (ABoundsPhysRect.MaxY - ABoundsPhysRect.MinY)), AdjY)
  else
    Result.Y := ABoundsDataRect.StartY;
  Result.X := EnsureRange(Result.X, ABoundsDataRect.StartX, ABoundsDataRect.EndX);
  Result.Y := EnsureRange(Result.Y, ABoundsDataRect.StartY, ABoundsDataRect.EndY);
end;
//------------------------------------------------------------------------------
function PhysToDataRect(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  APhysRect: TPhysRect; AdjX0, AdjY0, AdjX1, AdjY1: TAdjustment): TDataRect;
begin
  Result.StartXY :=
    PhysToDataPoint(ABoundsDataRect, ABoundsPhysRect, APhysRect.MinXY, AdjX0, AdjY0);
  Result.EndXY :=
    PhysToDataPoint(ABoundsDataRect, ABoundsPhysRect, APhysRect.MaxXY, AdjX1, AdjY1);
end;
//------------------------------------------------------------------------------
function DataToPhysRect(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  ADataRect: TDataRect): TPhysRect;
begin
  Result.MinXY :=
    DataToPhysPoint(ABoundsDataRect, ABoundsPhysRect, ADataRect.StartXY);
  Result.MaxXY :=
    DataToPhysPoint(ABoundsDataRect, ABoundsPhysRect, ADataRect.EndXY);
end;
//------------------------------------------------------------------------------
function FloatDataToPhysPoint(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  AFloatDataPoint: TPhysPoint): TPhysPoint;
begin
  if ABoundsDataRect.StartX < ABoundsDataRect.EndX then
    Result.X := ABoundsPhysRect.MinX + (AFloatDataPoint.X - ABoundsDataRect.StartX) *
      (ABoundsPhysRect.MaxX - ABoundsPhysRect.MinX) /
      (ABoundsDataRect.EndX - ABoundsDataRect.StartX)
  else
    Result.X := ABoundsPhysRect.MinX;

  if ABoundsDataRect.StartY < ABoundsDataRect.EndY then
    Result.Y := ABoundsPhysRect.MinY + (AFloatDataPoint.Y - ABoundsDataRect.StartY) *
      (ABoundsPhysRect.MaxY - ABoundsPhysRect.MinY) /
      (ABoundsDataRect.EndY - ABoundsDataRect.StartY)
  else
    Result.Y := ABoundsPhysRect.MinY;
end;
//------------------------------------------------------------------------------
function PhysToFloatDataPoint(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  APhysPoint: TPhysPoint): TPhysPoint;
begin
  if ABoundsPhysRect.MinX < ABoundsPhysRect.MaxX then
    Result.X := ABoundsDataRect.StartX + (APhysPoint.X - ABoundsPhysRect.MinX) *
      (ABoundsDataRect.EndX - ABoundsDataRect.StartX) /
      (ABoundsPhysRect.MaxX - ABoundsPhysRect.MinX)
  else
    Result.X := ABoundsDataRect.StartX;
  if ABoundsPhysRect.MinY < ABoundsPhysRect.MaxY then
    Result.Y := ABoundsDataRect.StartY + (APhysPoint.Y - ABoundsPhysRect.MinY) *
      (ABoundsDataRect.EndY - ABoundsDataRect.StartY) /
      (ABoundsPhysRect.MaxY - ABoundsPhysRect.MinY)
  else
    Result.Y := ABoundsDataRect.StartY;
  Result.X := EnsureRange(Result.X, ABoundsDataRect.StartX, ABoundsDataRect.EndX);
  Result.Y := EnsureRange(Result.Y, ABoundsDataRect.StartY, ABoundsDataRect.EndY);
end;
//------------------------------------------------------------------------------
function PhysToFloatDataRect(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  APhysRect: TPhysRect): TPhysRect;
begin
  Result.MinXY :=
    PhysToFloatDataPoint(ABoundsDataRect, ABoundsPhysRect, APhysRect.MinXY);
  Result.MaxXY :=
    PhysToFloatDataPoint(ABoundsDataRect, ABoundsPhysRect, APhysRect.MaxXY);
end;
//------------------------------------------------------------------------------
function FloatDataToPhysRect(ABoundsDataRect: TDataRect; ABoundsPhysRect: TPhysRect;
  AFloatDataRect: TPhysRect): TPhysRect;
begin
  Result.MinXY :=
    FloatDataToPhysPoint(ABoundsDataRect, ABoundsPhysRect, AFloatDataRect.MinXY);
  Result.MaxXY :=
    FloatDataToPhysPoint(ABoundsDataRect, ABoundsPhysRect, AFloatDataRect.MaxXY);
end;
//------------------------------------------------------------------------------
function PhysToScreenPoint(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  APhysPoint: TPhysPoint): TPoint;
begin
  if ABoundsPhysRect.MinX < ABoundsPhysRect.MaxX then
    Result.x := ABoundsScreenRect.Left + Round((APhysPoint.X - ABoundsPhysRect.MinX) *
      (ABoundsScreenRect.Right - ABoundsScreenRect.Left - 1) /
      (ABoundsPhysRect.MaxX - ABoundsPhysRect.MinX))
  else
    Result.x := ABoundsScreenRect.Left;
  if ABoundsPhysRect.MinY < ABoundsPhysRect.MaxY then
    Result.y := ABoundsScreenRect.Top + Round((ABoundsPhysRect.MaxY - APhysPoint.Y) *
      (ABoundsScreenRect.Bottom - ABoundsScreenRect.Top - 1) /
      (ABoundsPhysRect.MaxY - ABoundsPhysRect.MinY))
  else
    Result.y := ABoundsScreenRect.Top;
end;
//------------------------------------------------------------------------------
function ScreenToPhysPoint(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  AScreenPoint: TPoint): TPhysPoint;
begin
  if ABoundsScreenRect.Left < ABoundsScreenRect.Right - 1 then
    Result.x := ABoundsPhysRect.MinX + (AScreenPoint.X - ABoundsScreenRect.Left) *
      ((ABoundsPhysRect.MaxX - ABoundsPhysRect.MinX) /
      (ABoundsScreenRect.Right - ABoundsScreenRect.Left - 1))
  else
    Result.x := ABoundsPhysRect.MinX;
  if ABoundsScreenRect.Top < ABoundsScreenRect.Bottom - 1 then
    Result.y := ABoundsPhysRect.MaxY - (AScreenPoint.Y - ABoundsScreenRect.Top) *
      ((ABoundsPhysRect.MaxY - ABoundsPhysRect.MinY) /
      (ABoundsScreenRect.Bottom - ABoundsScreenRect.Top - 1))
  else
    Result.y := ABoundsPhysRect.MaxY;
end;
//------------------------------------------------------------------------------
function PhysToScreenRect(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  APhysRect: TPhysRect): TRect;
var
  p: TPoint;
begin
  p := PhysToScreenPoint(ABoundsScreenRect, ABoundsPhysRect, APhysRect.MinXY);
  Result.Left := p.x;
  Result.Bottom := p.y;
  p := PhysToScreenPoint(ABoundsScreenRect, ABoundsPhysRect, APhysRect.MaxXY);
  Result.Right := p.x;
  Result.Top := p.y;
  Result := BorderToRect(Result);
end;
//------------------------------------------------------------------------------
function ScreenToPhysRect(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect;
  AScreenRect: TRect): TPhysRect;
var
  pp: TPhysPoint;
begin
  AScreenRect := RectToBorder(AScreenRect);
  pp := ScreenToPhysPoint(ABoundsScreenRect, ABoundsPhysRect, AScreenRect.TopLeft);
  Result.MinX := pp.X;
  Result.MaxY := pp.Y;
  pp := ScreenToPhysPoint(ABoundsScreenRect, ABoundsPhysRect, AScreenRect.BottomRight);
  Result.MaxX := pp.X;
  Result.MinY := pp.Y;
end;
//-----------------------------------------------------------------------------
function PhysToScreenX(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect; AValue: Double): Integer;
begin
  Result := PhysToScreenPoint(ABoundsScreenRect, ABoundsPhysRect, PhysPoint(AValue, 0)).X;
end;
//------------------------------------------------------------------------------
function ScreenToPhysX(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect; AValue: Integer): Double;
begin
  Result := ScreenToPhysPoint(ABoundsScreenRect, ABoundsPhysRect, Point(AValue, 0)).X;
end;
//------------------------------------------------------------------------------
function PhysToScreenY(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect; AValue: Double): Integer;
begin
  Result := PhysToScreenPoint(ABoundsScreenRect, ABoundsPhysRect, PhysPoint(0, AValue)).Y;
end;
//------------------------------------------------------------------------------
function ScreenToPhysY(ABoundsScreenRect: TRect; ABoundsPhysRect: TPhysRect; AValue: Integer): Double;
begin
  Result := ScreenToPhysPoint(ABoundsScreenRect, ABoundsPhysRect, Point(0, AValue)).Y;
end;
//------------------------------------------------------------------------------
function Compare(const v1, v2: Double): Boolean;
begin
  Result := (Abs(v2 - v1) < 1e-100);
end;
//------------------------------------------------------------------------------
function Compare(const v1, v2: TDataRect): Boolean;
begin
  Result := (v1.StartX = v2.StartX) and (v1.StartY = v2.StartY) and
    (v1.EndX = v2.EndX) and (v1.EndY = v2.EndY);
//  Result := CompareMem(@v1, @v2, SizeOf(TDataRect));
end;
//------------------------------------------------------------------------------
function Compare(const v1, v2: TPoint): Boolean;
begin
  Result := (v1.X = v2.X) and (v1.Y = v2.Y);
//  Result := CompareMem(@v1, @v2, SizeOf(TPoint));
end;
//------------------------------------------------------------------------------
function Compare(const v1, v2: TRect): Boolean;
begin
  Result := (v1.Left = v2.Left) and (v1.Top = v2.Top) and
    (v1.Right = v2.Right) and (v1.Bottom = v2.Bottom);
//  Result := CompareMem(@v1, @v2, SizeOf(TRect));
end;
//------------------------------------------------------------------------------
function Compare(const v1, v2: TPhysPoint): Boolean;
begin
  Result := (v1.X = v2.X) and (v1.Y = v2.Y);
//  Result := CompareMem(@v1, @v2, SizeOf(TPhysPoint));
{
  Result := Compare(v1.X, v2.X) and Compare(v1.Y, v2.Y);
}
end;
//------------------------------------------------------------------------------
function Compare(const v1, v2: TPhysRect): Boolean;
begin
  Result := (v1.MinX = v2.MinX) and (v1.MinY = v2.MinY) and
    (v1.MaxX = v2.MaxX) and (v1.MaxY = v2.MaxY);
//  Result := CompareMem(@v1, @v2, SizeOf(TPhysRect));
{
  Result := Compare(v1.MinX, v2.MinX) and
            Compare(v1.MaxX, v2.MaxX) and
            Compare(v1.MinY, v2.MinY) and
            Compare(v1.MaxY, v2.MaxY);
}
end;
//------------------------------------------------------------------------------
function Compare(const guid1, guid2: TGUID): Boolean;
begin
  Result := (guid1.D1 = guid2.D1) and (guid1.D2 = guid2.D2) and
  (guid1.D3 = guid2.D3) and (Int64(guid1.D4) = Int64(guid2.D4));
//  Result := IsEqualGUID(guid1, guid2);
end;
//------------------------------------------------------------------------------
procedure Exchange(var v1, v2: Float32);
var
  t: Float32;
begin
  t := v1;
  v1 := v2;
  v2 := t;
end;
//------------------------------------------------------------------------------
procedure Exchange(var v1, v2: Float64);
var
  t: Float64;
begin
  t := v1;
  v1 := v2;
  v2 := t;
end;
{$IFNDEF FPC}
//------------------------------------------------------------------------------
procedure Exchange(var v1, v2: Float80);
var
  t: Float80;
begin
  t := v1;
  v1 := v2;
  v2 := t;
end;
{$ENDIF}
//------------------------------------------------------------------------------
procedure Exchange(var v1, v2: Int8);
var
  t: Int8;
begin
  t := v1;
  v1 := v2;
  v2 := t;
end;
//------------------------------------------------------------------------------
procedure Exchange(var v1, v2: Int16);
var
  t: Int16;
begin
  t := v1;
  v1 := v2;
  v2 := t;
end;
//------------------------------------------------------------------------------
procedure Exchange(var v1, v2: Int32);
var
  t: Int32;
begin
  t := v1;
  v1 := v2;
  v2 := t;
end;
//------------------------------------------------------------------------------
procedure Exchange(var v1, v2: Pointer);
var
  t: Pointer;
begin
  t := v1;
  v1 := v2;
  v2 := t;
end;
//------------------------------------------------------------------------------
function RemoveSpace(s: string): string;
var
  i: Integer;
begin
  i := Pos(' ', s);
  while i > 0 do
  begin
    Delete(s, i, 1);
    i := Pos(' ', s);
  end;
  Result := s;
end;
//------------------------------------------------------------------------------
procedure Exchange(var v1, v2; DataType: Integer);
var
  t: array[0..9] of Byte;
  Size: Integer;
begin
  Size := DataTypeMemSize(DataType);
  Move(v1, t, Size);
  Move(v2, v1, Size);
  Move(t, v2, Size);
end;
//------------------------------------------------------------------------------
function Ceil64(const X: Double): Int64;
begin
  Result := Trunc(X);
  if Frac(X) > 0 then
    Inc(Result);
end;
//------------------------------------------------------------------------------
function Floor64(const X: Double): Int64;
begin
  Result := Trunc(X);
  if Frac(X) < 0 then
    Dec(Result);
end;
//------------------------------------------------------------------------------
function MathRound(AValue: Double): Integer; inline;
begin
  if AValue >= 0.0 then
    Result := Trunc(AValue + 0.5)
  else
    Result := Trunc(AValue - 0.5);
end;
//------------------------------------------------------------------------------
function GetFloorExponent(AValue: Double): Integer;
var
  TmpValue: Double;
begin
  TmpValue := Abs(AValue);
  if TmpValue < MinPhysValue then Result := MinPhysValuePower
  else if TmpValue > MaxPhysValue then Result := MaxPhysValuePower
  else Result := Floor(Log10(TmpValue));
end;
//------------------------------------------------------------------------------
function GetValueExponent(AValue: Double): Integer;
var
  TmpValue: Double;
begin
  TmpValue := Abs(AValue);
  if TmpValue < MinPhysValue then Result := MinPhysValuePower
  else if TmpValue > MaxPhysValue then Result := MaxPhysValuePower
  else Result := Round(Log10(TmpValue));
end;
//------------------------------------------------------------------------------
function AdjustDegree(Angle: Double): Double;
begin
  if Abs(Angle) >= 360 then
    Angle := Angle - 360 * Trunc(Angle / 360);
  if Angle < 0 then
    Angle := 360 + Angle;
  Result := Angle;
end;
//------------------------------------------------------------------------------
function AngleBySinCos(ASin, ACos: Double; AllowNegativeResult: Boolean = True): Double;
begin
  Result := ArcSin(ASin);
  if ACos < 0 then
  begin
    if ASin < 0 then
      Result := -Pi - Result
    else
      Result := Pi - Result;
  end;

  if (not AllowNegativeResult) and (Result < 0) then
    Result := Pi * 2 + Result;
end;
//------------------------------------------------------------------------------
{$IFNDEF DELPHI2009_UP}
function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean;
begin
  Result := C in CharSet;
end;

function CharInSet(C: WideChar; const CharSet: TSysCharSet): Boolean;
begin
  Result := (C < #$0100) and (AnsiChar(C) in CharSet);
end;

{$IFNDEF FPC}
function StrLen(const Str: PAnsiChar): Cardinal;
asm
  {Check the first byte}
  cmp byte ptr [eax], 0
  je @ZeroLength
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Word align}
  add eax, 1
  and eax, -2
@ScanLoop:
  mov cx, [eax]
  add eax, 2
  test cl, ch
  jnz @ScanLoop
  test cl, cl
  jz @ReturnLess2
  test ch, ch
  jnz @ScanLoop
  lea eax, [eax + edx - 1]
  ret
@ReturnLess2:
  lea eax, [eax + edx - 2]
  ret
@ZeroLength:
  xor eax, eax
end;

function StrLen(const Str: PWideChar): Cardinal;
asm
  {Check the first byte}
  cmp word ptr [eax], 0
  je @ZeroLength
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
@ScanLoop:
  mov cx, [eax]
  add eax, 2
  test cx, cx
  jnz @ScanLoop
  lea eax, [eax + edx - 2]
  shr eax, 1
  ret
@ZeroLength:
  xor eax, eax
end;
{$ELSE}
function StrLen(const Str: PAnsiChar): Cardinal;
var
  lStart : PByte;
begin
	Result :=0;
	lStart :=pByte(Str);
	while lStart^<>0 do 
	begin
		Inc(lStart); 		
		Inc(Result);
	end;	
end;
function StrLen(const Str: PWideChar): Cardinal;
var
  lStart : PWord16;
begin
	Result :=0;
	lStart := PWord16(Str);
	while lStart^<>0 do 
	begin
		Inc(lStart); 		
		Inc(Result);
	end;	
end;
{$ENDIF}

function StrMove(Dest: PAnsiChar; const Source: PAnsiChar; Count: Cardinal): PAnsiChar;
begin
  Result := Dest;
  Move(Source^, Dest^, Count * SizeOf(AnsiChar));
end;

function StrMove(Dest: PWideChar; const Source: PWideChar; Count: Cardinal): PWideChar;
begin
  Result := Dest;
  Move(Source^, Dest^, Count * SizeOf(WideChar));
end;

function AnsiStrAlloc(Size: Cardinal): PAnsiChar;
begin
  Inc(Size, SizeOf(Cardinal));
  GetMem(Result, Size);
  Cardinal(Pointer(Result)^) := Size;
  Inc(Result, SizeOf(Cardinal));
end;

function WideStrAlloc(Size: Cardinal): PWideChar;
begin
  //BJK: Size should probably be char count, not bytes; but at least 'div 2' below prevents overrun.
  Size := Size * SizeOf(WideChar);
  Inc(Size, SizeOf(Cardinal));
  GetMem(Result, Size);
  Cardinal(Pointer(Result)^) := Size;
  Inc(Result, SizeOf(Cardinal) div 2);
end;
{$ENDIF}

end.

