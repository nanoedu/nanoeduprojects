unit MathUtils;

{$N+,S-}

interface

uses
  BaseTypes;

type
  TValueSign = -1..1;

const
  FuzzFactor = 1000;
  ExtendedResolution = 1E-19 * FuzzFactor;
  DoubleResolution   = 1E-15 * FuzzFactor;
  SingleResolution   = 1E-7 * FuzzFactor;
  NaN = 0.0 / 0.0;
  NegativeValue = Low(TValueSign);
  ZeroValue = 0;
  PositiveValue = High(TValueSign);

function IsNan(const AValue: Double): Boolean; overload;
function IsNan(const AValue: Single): Boolean; overload;
function IsNan(const AValue: Extended): Boolean; overload;

function IsZero(const A: Extended; Epsilon: Extended = 0): Boolean; overload;
function IsZero(const A: Double; Epsilon: Double = 0): Boolean; overload;
function IsZero(const A: Single; Epsilon: Single = 0): Boolean; overload;

function Log10(const X: Extended): Extended;
function Log2(const X: Extended): Extended;
function IntPower(const Base: Extended; const Exponent: Integer): Extended;
procedure SinCos(const Theta: Extended; var Sin, Cos: Extended);
function Tan(const X: Extended): Extended;
function Cosh(const X: Extended): Extended;
function Sinh(const X: Extended): Extended;
function Tanh(const X: Extended): Extended;
function ArcCos(const X : Extended) : Extended; overload;
function ArcCos(const X : Double) : Double; overload;
function ArcCos(const X : Single) : Single; overload;
function ArcSin(const X : Extended) : Extended; overload;
function ArcSin(const X : Double) : Double; overload;
function ArcSin(const X : Single) : Single; overload;
function RadToDeg(const Radians: Extended): Extended; inline;   { Degrees := Radians * 180 / PI }
function DegToRad(const Degrees: Extended): Extended;  { Degrees := Radians * 180 / PI }
function RadToGrad(const Radians: Extended): Extended; inline;  { Grads := Radians * 200 / PI }
function RadToCycle(const Radians: Extended): Extended; inline; { Cycles := Radians / 2PI }

function Min(const A, B: Integer): Integer; overload; inline;
function Min(const A, B: Int64): Int64; overload; inline;
function Min(const A, B: Single): Single; overload; inline;
function Min(const A, B: Double): Double; overload; inline;
function Min(const A, B: Extended): Extended; overload; inline;

function Max(const A, B: Integer): Integer; overload; inline;
function Max(const A, B: Int64): Int64; overload; inline;
function Max(const A, B: Single): Single; overload; inline;
function Max(const A, B: Double): Double; overload; inline;
function Max(const A, B: Extended): Extended; overload; inline;

function Sign(const AValue: Integer): TValueSign; overload;
function Sign(const AValue: Int64): TValueSign; overload;
function Sign(const AValue: Single): TValueSign; overload;
function Sign(const AValue: Double): TValueSign; overload;
function Sign(const AValue: Extended): TValueSign; overload;

function Ceil(const X: Extended):Integer;
function Floor(const X: Extended): Integer;

function IntToStr(Value: Integer): string; overload;
function IntToStr(Value: Int64): string; overload;

function InRange(const AValue, AMin, AMax: Integer): Boolean; overload;
function InRange(const AValue, AMin, AMax: Int64): Boolean; overload;
function InRange(const AValue, AMin, AMax: Double): Boolean; overload;
function EnsureRange(const AValue, AMin, AMax: Integer): Integer; overload;
function EnsureRange(const AValue, AMin, AMax: Int64): Int64; overload;
function EnsureRange(const AValue, AMin, AMax: Double): Double; overload;

function IfThen(const AValue: Boolean; const ATrue: Integer; const AFalse: Integer = 0): Integer; overload; inline;
function IfThen(const AValue: Boolean; const ATrue: Int64; const AFalse: Int64 = 0): Int64; overload; inline;
function IfThen(const AValue: Boolean; const ATrue: Double; const AFalse: Double = 0.0): Double; overload; inline;
function IfThen(const AValue: Boolean; const ATrue: string; const AFalse: string = ''): string; overload; inline;

implementation

//------------------------------------------------------------------------------
function IsNan(const AValue: Single): Boolean;
begin
  Result := ((PLongWord(@AValue)^ and $7F800000)  = $7F800000) and
            ((PLongWord(@AValue)^ and $007FFFFF) <> $00000000);
end;
//------------------------------------------------------------------------------
function IsNan(const AValue: Double): Boolean;
begin
  Result := ((PInt64(@AValue)^ and $7FF0000000000000)  = $7FF0000000000000) and
            ((PInt64(@AValue)^ and $000FFFFFFFFFFFFF) <> $0000000000000000);
end;
//------------------------------------------------------------------------------
function IsNan(const AValue: Extended): Boolean;
type
  TExtented = packed record
    Mantissa: Int64;
    Exponent: Word;
  end;
  PExtended = ^TExtented;
begin
  Result := ((PExtended(@AValue)^.Exponent and $7FFF)  = $7FFF) and
            ((PExtended(@AValue)^.Mantissa and $7FFFFFFFFFFFFFFF) <> 0);
end;
//------------------------------------------------------------------------------
function IsZero(const A: Extended; Epsilon: Extended): Boolean;
begin
  if Epsilon = 0 then
    Epsilon := ExtendedResolution;
  Result := Abs(A) <= Epsilon;
end;
//------------------------------------------------------------------------------
function IsZero(const A: Double; Epsilon: Double): Boolean;
begin
  if Epsilon = 0 then
    Epsilon := DoubleResolution;
  Result := Abs(A) <= Epsilon;
end;
//------------------------------------------------------------------------------
function IsZero(const A: Single; Epsilon: Single): Boolean;
begin
  if Epsilon = 0 then
    Epsilon := SingleResolution;
  Result := Abs(A) <= Epsilon;
end;
//------------------------------------------------------------------------------
function Tan(const X: Extended): Extended;
{  Tan := Sin(X) / Cos(X) }
asm
        FLD    X
        FPTAN
        FSTP   ST(0)      { FPTAN pushes 1.0 after result }
        FWAIT
end;
//------------------------------------------------------------------------------
procedure SinCos(const Theta: Extended; var Sin, Cos: Extended);
asm
        FLD     Theta
        FSINCOS
        FSTP    tbyte ptr [edx]    // Cos
        FSTP    tbyte ptr [eax]    // Sin
        FWAIT
end;
//------------------------------------------------------------------------------
function IntPower(const Base: Extended; const Exponent: Integer): Extended;
asm
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fwait
end;
//------------------------------------------------------------------------------
function Log10(const X: Extended): Extended;
  { Log.10(X) := Log.2(X) * Log.10(2) }
asm
        FLDLG2     { Log base ten of 2 }
        FLD     X
        FYL2X
        FWAIT
end;
//------------------------------------------------------------------------------
function Log2(const X: Extended): Extended;
asm
        FLD1
        FLD     X
        FYL2X
        FWAIT
end;
//------------------------------------------------------------------------------
function Cosh(const X: Extended): Extended;
begin
  if IsZero(X) then
    Result := 1
  else
    Result := (Exp(X) + Exp(-X)) / 2;
end;
//------------------------------------------------------------------------------
function Sinh(const X: Extended): Extended;
begin
  if IsZero(X) then
    Result := 0
  else
    Result := (Exp(X) - Exp(-X)) / 2;
end;
//------------------------------------------------------------------------------
function Tanh(const X: Extended): Extended;
begin
  if IsZero(X) then
    Result := 0
  else
    Result := SinH(X) / CosH(X);
end;
//------------------------------------------------------------------------------
function ArcCos(const X : Extended) : Extended;
asm
  //Result := ArcTan2(Sqrt((1+X) * (1-X)), X)
  FLD   X
  FLD1
  FADD  ST(0), ST(1)
  FLD1
  FSUB  ST(0), ST(2)
  FMULP ST(1), ST(0)
  FSQRT
  FXCH
  FPATAN
end;
//------------------------------------------------------------------------------
function ArcCos(const X : Double) : Double;
asm
  //Result := ArcTan2(Sqrt((1+X) * (1-X)), X)
  FLD   X
  FLD1
  FADD  ST(0), ST(1)
  FLD1
  FSUB  ST(0), ST(2)
  FMULP ST(1), ST(0)
  FSQRT
  FXCH
  FPATAN
end;
//------------------------------------------------------------------------------
function ArcCos(const X : Single) : Single;
asm
  //Result := ArcTan2(Sqrt((1+X) * (1-X)), X)
  fld1
  fld    X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fxch
  fpatan
end;
//------------------------------------------------------------------------------
function ArcSin(const X : Extended) : Extended;
asm
  //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
  fld1
  fld    X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fpatan
end;
//------------------------------------------------------------------------------
function ArcSin(const X : Double) : Double;
asm
  //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
  FLD   X
  FLD1
  FADD  ST(0), ST(1)
  FLD1
  FSUB  ST(0), ST(2)
  FMULP ST(1), ST(0)
  FSQRT
  FPATAN
end;
//------------------------------------------------------------------------------
function ArcSin(const X : Single) : Single;
asm
  //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
  fld1
  fld    X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fpatan
end;
//------------------------------------------------------------------------------
function RadToDeg(const Radians: Extended): Extended;  { Degrees := Radians * 180 / PI }
begin
  Result := Radians * (180 / PI);
end;
//------------------------------------------------------------------------------
function DegToRad(const Degrees: Extended): Extended;  { Degrees := Radians * 180 / PI }
begin
  Result := Degrees * (PI / 180);
end;
//------------------------------------------------------------------------------
function RadToGrad(const Radians: Extended): Extended; { Grads := Radians * 200 / PI}
begin
  Result := Radians * (200 / PI);
end;
//------------------------------------------------------------------------------
function RadToCycle(const Radians: Extended): Extended;{ Cycles := Radians / 2PI }
begin
  Result := Radians / (2 * PI);
end;
//------------------------------------------------------------------------------
function Min(const A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;
//------------------------------------------------------------------------------
function Min(const A, B: Int64): Int64;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;
//------------------------------------------------------------------------------
function Min(const A, B: Single): Single;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;
//------------------------------------------------------------------------------
function Min(const A, B: Double): Double;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;
//------------------------------------------------------------------------------
function Min(const A, B: Extended): Extended;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;
//------------------------------------------------------------------------------
function Max(const A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;
//------------------------------------------------------------------------------
function Max(const A, B: Int64): Int64;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;
//------------------------------------------------------------------------------
function Max(const A, B: Single): Single;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;
//------------------------------------------------------------------------------
function Max(const A, B: Double): Double;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;
//------------------------------------------------------------------------------
function Max(const A, B: Extended): Extended;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;
//------------------------------------------------------------------------------
function Sign(const AValue: Integer): TValueSign;
begin
  if AValue < 0 then
    Result := NegativeValue
  else if AValue > 0 then
    Result := PositiveValue
  else
    Result := ZeroValue;
end;
//------------------------------------------------------------------------------
function Sign(const AValue: Int64): TValueSign;
begin
  if AValue < 0 then
    Result := NegativeValue
  else if AValue > 0 then
    Result := PositiveValue
  else
    Result := ZeroValue;
end;
//------------------------------------------------------------------------------
function Sign(const AValue: Single): TValueSign;
begin
  if AValue < 0 then
    Result := NegativeValue
  else if AValue > 0 then
    Result := PositiveValue
  else
    Result := ZeroValue;
end;
//------------------------------------------------------------------------------
function Sign(const AValue: Double): TValueSign;
begin
  if ((PInt64(@AValue)^ and $7FFFFFFFFFFFFFFF) = $0000000000000000) then
    Result := ZeroValue
  else if ((PInt64(@AValue)^ and $8000000000000000) = $8000000000000000) then
    Result := NegativeValue
  else
    Result := PositiveValue;
end;
//------------------------------------------------------------------------------
function Sign(const AValue: Extended): TValueSign;
begin
  if AValue < 0 then
    Result := NegativeValue
  else if AValue > 0 then
    Result := PositiveValue
  else
    Result := ZeroValue;
end;
//------------------------------------------------------------------------------
function Ceil(const X: Extended): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) > 0 then
    Inc(Result);
end;
//------------------------------------------------------------------------------
function Floor(const X: Extended): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) < 0 then
    Dec(Result);
end;
//------------------------------------------------------------------------------


procedure CvtInt;
{ IN:
    EAX:  The integer value to be converted to text
    ESI:  Ptr to the right-hand side of the output buffer:  LEA ESI, StrBuf[16]
    ECX:  Base for conversion: 0 for signed decimal, 10 or 16 for unsigned
    EDX:  Precision: zero padded minimum field width
  OUT:
    ESI:  Ptr to start of converted text (not start of buffer)
    ECX:  Length of converted text
}
asm
        OR      CL,CL
        JNZ     @CvtLoop
@C1:    OR      EAX,EAX
        JNS     @C2
        NEG     EAX
        CALL    @C2
        MOV     AL,'-'
        INC     ECX
        DEC     ESI
        MOV     [ESI],AL
        RET
@C2:    MOV     ECX,10

@CvtLoop:
        PUSH    EDX
        PUSH    ESI
@D1:    XOR     EDX,EDX
        DIV     ECX
        DEC     ESI
        ADD     DL,'0'
        CMP     DL,'0'+10
        JB      @D2
        ADD     DL,('A'-'0')-10
@D2:    MOV     [ESI],DL
        OR      EAX,EAX
        JNE     @D1
        POP     ECX
        POP     EDX
        SUB     ECX,ESI
        SUB     EDX,ECX
        JBE     @D5
        ADD     ECX,EDX
        MOV     AL,'0'
        SUB     ESI,EDX
        JMP     @z
@zloop: MOV     [ESI+EDX],AL
@z:     DEC     EDX
        JNZ     @zloop
        MOV     [ESI],AL
@D5:
end;

function IntToStr(Value: Integer): string;
//  FmtStr(Result, '%d', [Value]);
asm
        PUSH    ESI
        MOV     ESI, ESP
        SUB     ESP, 16
        XOR     ECX, ECX       // base: 0 for signed decimal
        PUSH    EDX            // result ptr
        XOR     EDX, EDX       // zero filled field width: 0 for no leading zeros
        CALL    CvtInt
        MOV     EDX, ESI
        POP     EAX            // result ptr
        CALL    System.@LStrFromPCharLen
        ADD     ESP, 16
        POP     ESI
end;

procedure CvtInt64;
{ IN:
    EAX:  Address of the int64 value to be converted to text
    ESI:  Ptr to the right-hand side of the output buffer:  LEA ESI, StrBuf[32]
    ECX:  Base for conversion: 0 for signed decimal, or 10 or 16 for unsigned
    EDX:  Precision: zero padded minimum field width
  OUT:
    ESI:  Ptr to start of converted text (not start of buffer)
    ECX:  Byte length of converted text
}
asm
        OR      CL, CL
        JNZ     @start             // CL = 0  => signed integer conversion
        MOV     ECX, 10
        TEST    [EAX + 4], $80000000
        JZ      @start
        PUSH    [EAX + 4]
        PUSH    [EAX]
        MOV     EAX, ESP
        NEG     [ESP]              // negate the value
        ADC     [ESP + 4],0
        NEG     [ESP + 4]
        CALL    @start             // perform unsigned conversion
        MOV     [ESI-1].Byte, '-'  // tack on the negative sign
        DEC     ESI
        INC     ECX
        ADD     ESP, 8
        RET

@start:   // perform unsigned conversion
        PUSH    ESI
        SUB     ESP, 4
        FNSTCW  [ESP+2].Word     // save
        FNSTCW  [ESP].Word       // scratch
        OR      [ESP].Word, $0F00  // trunc toward zero, full precision
        FLDCW   [ESP].Word

        MOV     [ESP].Word, CX
        FLD1
        TEST    [EAX + 4], $80000000 // test for negative
        JZ      @ld1                 // FPU doesn't understand unsigned ints
        PUSH    [EAX + 4]            // copy value before modifying
        PUSH    [EAX]
        AND     [ESP + 4], $7FFFFFFF // clear the sign bit
        PUSH    $7FFFFFFF
        PUSH    $FFFFFFFF
        FILD    [ESP + 8].QWord     // load value
        FILD    [ESP].QWord
        FADD    ST(0), ST(2)        // Add 1.  Produces unsigned $80000000 in ST(0)
        FADDP   ST(1), ST(0)        // Add $80000000 to value to replace the sign bit
        ADD     ESP, 16
        JMP     @ld2
@ld1:
        FILD    [EAX].QWord         // value
@ld2:
        FILD    [ESP].Word          // base
        FLD     ST(1)
@loop:
        DEC     ESI
        FPREM                       // accumulator mod base
        FISTP   [ESP].Word
        FDIV    ST(1), ST(0)        // accumulator := acumulator / base
        MOV     AL, [ESP].Byte      // overlap long FPU division op with int ops
        ADD     AL, '0'
        CMP     AL, '0'+10
        JB      @store
        ADD     AL, ('A'-'0')-10
@store:
        MOV     [ESI].Byte, AL
        FLD     ST(1)           // copy accumulator
        FCOM    ST(3)           // if accumulator >= 1.0 then loop
        FSTSW   AX
        SAHF
        JAE @loop

        FLDCW   [ESP+2].Word
        ADD     ESP,4

        FFREE   ST(3)
        FFREE   ST(2)
        FFREE   ST(1);
        FFREE   ST(0);

        POP     ECX             // original ESI
        SUB     ECX, ESI        // ECX = length of converted string
        SUB     EDX,ECX
        JBE     @done           // output longer than field width = no pad
        SUB     ESI,EDX
        MOV     AL,'0'
        ADD     ECX,EDX
        JMP     @z
@zloop: MOV     [ESI+EDX].Byte,AL
@z:     DEC     EDX
        JNZ     @zloop
        MOV     [ESI].Byte,AL
@done:
end;

function IntToStr(Value: Int64): string;
//  FmtStr(Result, '%d', [Value]);
asm
        PUSH    ESI
        MOV     ESI, ESP
        SUB     ESP, 32        // 32 chars
        XOR     ECX, ECX       // base 10 signed
        PUSH    EAX            // result ptr
        XOR     EDX, EDX       // zero filled field width: 0 for no leading zeros
        LEA     EAX, Value;
        CALL    CvtInt64

        MOV     EDX, ESI
        POP     EAX            // result ptr
        CALL    System.@LStrFromPCharLen
        ADD     ESP, 32
        POP     ESI
end;

//------------------------------------------------------------------------------
function InRange(const AValue, AMin, AMax: Integer): Boolean;
begin
  Result := (AValue >= AMin) and (AValue <= AMax);
end;
//------------------------------------------------------------------------------
function InRange(const AValue, AMin, AMax: Int64): Boolean;
begin
  Result := (AValue >= AMin) and (AValue <= AMax);
end;
//------------------------------------------------------------------------------
function InRange(const AValue, AMin, AMax: Double): Boolean;
begin
  Result := (AValue >= AMin) and (AValue <= AMax);
end;
//------------------------------------------------------------------------------
function EnsureRange(const AValue, AMin, AMax: Integer): Integer;
begin
  Result := AValue;
  assert(AMin <= AMax);
  if Result < AMin then
    Result := AMin;
  if Result > AMax then
    Result := AMax;
end;
//------------------------------------------------------------------------------
function EnsureRange(const AValue, AMin, AMax: Int64): Int64;
begin
  Result := AValue;
  assert(AMin <= AMax);
  if Result < AMin then
    Result := AMin;
  if Result > AMax then
    Result := AMax;
end;
//------------------------------------------------------------------------------
function EnsureRange(const AValue, AMin, AMax: Double): Double;
begin
  Result := AValue;
  assert(AMin <= AMax);
  if Result < AMin then
    Result := AMin;
  if Result > AMax then
    Result := AMax;
end;
//------------------------------------------------------------------------------
function IfThen(const AValue: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;
//------------------------------------------------------------------------------
function IfThen(const AValue: Boolean; const ATrue: Int64; const AFalse: Int64): Int64;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;
//------------------------------------------------------------------------------
function IfThen(const AValue: Boolean; const ATrue: Double; const AFalse: Double): Double;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;
//------------------------------------------------------------------------------
function IfThen(const AValue: Boolean; const ATrue: string; const AFalse: string): string;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;
//------------------------------------------------------------------------------



end.
