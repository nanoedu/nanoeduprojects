unit SysUnits;

interface

uses
  Windows, Classes, SysUtils, Math,
  BaseTypes;

type
  TFormatUnit = record
    UnitText: string;
    Scale: Float64;
    FactorPower: Int32;
    Precision: Int32;
  end;
  PFormatUnit = ^TFormatUnit;

  TDisplayUnit = packed record
    UnitText: WideString;
    Scale: Float64;
    FactorPower: Int32;
    Precision: Int32;
  end;
  PDisplayUnit = ^TDisplayUnit;

  PUnits = ^TUnits;
  TUnits = packed array[0..7] of Int8; //System of Units ID & Powers of according basic units
  PUnit = ^TUnit;
  TUnit = packed record //Size: 32 bytes
    Comment: PWChar;
    Name: PWChar;       // Name of the system of units
    Symbol: PWChar;
    Powers: TUnits;     // Powers of according basic units
    Shift: Float64;
    Scale: Float64;
    Status: Int8;       //0-Basic 1-Derived 2-Acceptable 3-Custom
    UsePrefix: Int8;    //0-Use 1-Possible 2- Sometimes 3-Never
    SIPrefix: Int8;     //prefix to use to get standard SI unit
    State: Int8;        //reserved
    UsePrefixEx: Int32; // Bit(Power/3 + 8): 1-Use 0-Not use
  end;

const
  UseYocto = $00000001;
  UseZepto = $00000002;
  UseAtto = $00000004;
  UseFemto = $00000008;
  UsePico = $00000010;
  UseNano = $00000020;
  UseMicro = $00000040;
  UseMilli = $00000080;
  UseNone = $00000100;
  UseKilo = $00000200;
  UseMega = $00000400;
  UseGiga = $00000800;
  UseTera = $00001000;
  UsePeta = $00002000;
  UseExa = $00004000;
  UseZetta = $00008000;
  UseYotta = $00010000;

type
// SystemOfUnits is implyed to be a static object and have single instance at a momement.
  TSystemOfUnits = record         // Size=???
    Comment: PWChar;              // Comment to the system of units
    Name: PWChar;                 // Name of the system of units
    BasicCount: Int32;            // Count of basic units
    DerivCount: Int32;            // Count of derived units
    AcceptCount: Int32;           // Count of Acceptable units
    CustomCount: Int32;           // Count of Custom units
    Units: array[0..35] of TUnit; // Size=32*11 bytes Basic units Array
    //Possible developement of index technology
  end;

{
Units outside the SI that are accepted for use with the SI
  time minute min  60 s
  time hour   h  3600 s
  time day    d  86400 s

  angle degree 1/180 rad
  angle minute 1/10800 rad
  angle second 1/648000 rad

  volume liter  L 10-3 m3
  mass metric ton t 103 kg
  neper  Np  1
  bel B (1/2) ln 10 Np (c)
  electronvolt eV  1.602 18 x 10-19 J
  unified atomic mass unit u 1.660 54 x 10-27 kg
  astronomical unit ua 1.495 98 x 1011 m
}

const
  SI_ID : byte    = 1;
  SI_Meter_ID     = 0;
  SI_Kilogram_ID  = 1;
  SI_Second_ID    = 2;
  SI_Ampere_ID    = 3;
  SI_Kelvin_ID    = 4;
  SI_Mole_ID      = 5;
  SI_Candela_ID   = 6;
  SI_None_ID      = 7;
  SI_Radian_ID    = 8;
  SI_Steradian_ID = 9;
  SI_Hertz_ID     = 10;
  SI_Newton_ID    = 11;
  SI_Pascal_ID    = 12;
  SI_Joule_ID     = 13;
  SI_Watt_ID      = 14;
  SI_Coulomb_ID   = 15;
  SI_Volt_ID      = 16;
  SI_Farad_ID     = 17;
  SI_Ohm_ID       = 18;
  SI_Siemens_ID   = 19;
  SI_Weber_ID     = 20;
  SI_Tesla_ID     = 21;
  SI_Henry_ID     = 22;
  SI_Lumen_ID     = 23;
  SI_Lux_ID       = 24;
  SI_Becquerel_ID = 25;
  SI_Gray_ID      = 26;
  SI_Sievert_ID   = 27;
//Name and Symbol are both unique fields and should be indexed by database.
//Name can consists of a..z only Symbol can also contain Greek letters
  SI: TSystemOfUnits = (
    Comment     : 'International System of Units';
    Name        : 'SI';
    BasicCount  : 7;
    DerivCount  : 20;
    AcceptCount : 4;                   // Count of Acceptable units
    CustomCount : 4;                   // Count of Custom units
    Units: (
      //Basic
      (Comment: 'length';                    Name: 'meter';             Symbol: 'm';        Powers: (1, 1, 0, 0, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 0; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: (UseNano or UseMicro or UseMilli or UseNone or UseKilo)), //0 //0
      (Comment: 'mass';                      Name: 'gram';              Symbol: 'g';        Powers: (1, 0, 1, 0, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 0; UsePrefix: 0; SiPrefix: 1; State: 0; UsePrefixEx: (UseMilli or UseNone or UseKilo)), //1 //1
      (Comment: 'time';                      Name: 'second';            Symbol: 's';        Powers: (1, 0, 0, 1, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 0; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: (UsePico or UseNano or UseMicro or UseMilli or UseNone)), //2 //2
      (Comment: 'electric current';          Name: 'ampere';            Symbol: 'A';        Powers: (1, 0, 0, 0, 1, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 0; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: (UsePico or UseNano or UseMicro or UseMilli or UseNone)), //3 //3
      (Comment: 'thermodynamic temperature'; Name: 'kelvin';            Symbol: 'K';        Powers: (1, 0, 0, 0, 0, 1, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 0; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //4 //4
      (Comment: 'amount of substance';       Name: 'mole';              Symbol: 'mol';      Powers: (1, 0, 0, 0, 0, 0, 1, 0); Shift: 0.0; Scale: 1.0;        Status: 0; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //5 //5
      (Comment: 'luminous intensity';        Name: 'candela';           Symbol: 'cd';       Powers: (1, 0, 0, 0, 0, 0, 0, 1); Shift: 0.0; Scale: 1.0;        Status: 0; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //6 //6
      //Deriv
      (Comment: '';                          Name: '';                  Symbol: '';         Powers: (1, 0, 0, 0, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //0 //7
      (Comment: 'plane angle';               Name: 'radian';            Symbol: 'rad';      Powers: (1, 0, 0, 0, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //1 //8
      (Comment: 'solid angle';               Name: 'steradian';         Symbol: 'sr';       Powers: (1, 0, 0, 0, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //2 //9
      (Comment: 'frequency';                 Name: 'hertz';             Symbol: 'Hz';       Powers: (1, 0, 0,-1, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: (UseNone or UseKilo or UseMega or UseGiga)), //3 //10
      (Comment: 'force';                     Name: 'newton';            Symbol: 'N';        Powers: (1, 1, 1,-2, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: (UsePico or UseNano or UseMicro or UseNone or UseKilo)), //4 //11
      (Comment: 'pressure';                  Name: 'pascal';            Symbol: 'Pa';       Powers: (1,-1, 1,-2, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: (UseNone or UseKilo)), //5 //12
      (Comment: 'energy';                    Name: 'joule';             Symbol: 'J';        Powers: (1, 2, 1,-2, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: (UseNone or UseKilo)), //6 //13
      (Comment: 'power';                     Name: 'watt';              Symbol: 'W';        Powers: (1, 2, 1,-3, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: (UseMilli or UseNone or UseKilo or UseMega or UseGiga)), //7 //14
      (Comment: 'electric charge';           Name: 'coulomb';           Symbol: 'C';        Powers: (1, 0, 0, 1, 1, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone),//8 //15
      (Comment: 'potential difference';      Name: 'volt';              Symbol: 'V';        Powers: (1, 2, 1,-3,-1, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: (UsePico or UseNano or UseMicro or UseMilli or UseNone or UseKilo)), //9 //16
      (Comment: 'capacitance';               Name: 'farad';             Symbol: 'F';        Powers: (1,-2,-1, 4, 2, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: (UsePico or UseNano or UseMicro or UseMilli or UseNone)), //10 //17
      (Comment: 'electric resistance';       Name: 'ohm';               Symbol: 'Ohm';      Powers: (1, 2, 1,-3,-2, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: (UseNone or UseKilo or UseMega)), //11 //18
      (Comment: 'electric conductance';      Name: 'siemens';           Symbol: 'S';        Powers: (1,-2,-1, 3, 2, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //12 //19
      (Comment: 'magnetic flux';             Name: 'weber';             Symbol: 'Wb';       Powers: (1, 2, 1,-2,-1, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //13 //20
      (Comment: 'magnetic flux density';     Name: 'tesla';             Symbol: 'T';        Powers: (1, 0, 1,-2,-1, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //14 //21
      (Comment: 'inductance';                Name: 'henry';             Symbol: 'H';        Powers: (1, 2, 1,-2,-2, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //15 //22
      (Comment: 'luminous flux';             Name: 'lumen';             Symbol: 'lm';       Powers: (1, 0, 0, 0, 0, 0, 0, 1); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //16 //23
      (Comment: 'illuminance';               Name: 'lux';               Symbol: 'lx';       Powers: (1,-2, 0, 0, 0, 0, 0, 1); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //17 //24
      (Comment: 'radioactivity';             Name: 'becquerel';         Symbol: 'Bq';       Powers: (1, 0, 0,-1, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //18 //25
      (Comment: 'absorbed dose';             Name: 'gray';              Symbol: 'Gy';       Powers: (1, 2, 0,-2, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //19 //26
      (Comment: 'dose equivalent';           Name: 'sievert';           Symbol: 'Sv';       Powers: (1, 2, 0,-2, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 1; UsePrefix: 0; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), //20 //27
      // Accept:
      (Comment: 'time';                      Name: 'minute';            Symbol: 'min';      Powers: (1, 0, 0, 1, 0, 0, 0, 0); Shift: 0.0; Scale: 60;         Status: 2; UsePrefix: 3; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), // //28
      (Comment: 'time';                      Name: 'hour';              Symbol: 'h';        Powers: (1, 0, 0, 1, 0, 0, 0, 0); Shift: 0.0; Scale: 3600;       Status: 2; UsePrefix: 3; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), // //29
      (Comment: 'time';                      Name: 'day';               Symbol: 'd';        Powers: (1, 0, 0, 1, 0, 0, 0, 0); Shift: 0.0; Scale: 86400;      Status: 2; UsePrefix: 3; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), // //30
      (Comment: 'length';                    Name: 'Astronomical unit'; Symbol: 'ua';       Powers: (1, 1, 0, 0, 0, 0, 0, 0); Shift: 0.0; Scale: 1.49598E11; Status: 2; UsePrefix: 0; SiPrefix: 0; State: 2; UsePrefixEx: UseNone), // //31
      // Custom:
      (Comment: 'length';                    Name: 'angstrom';          Symbol: 'Angstrom'; Powers: (1, 1, 0, 0, 0, 0, 0, 0); Shift: 0.0; Scale: 1E-10;      Status: 3; UsePrefix: 3; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), // //32
      (Comment: 'plane angle';               Name: 'degree';            Symbol: '°';        Powers: (1, 0, 0, 0, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 3; UsePrefix: 3; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), // //33
      (Comment: 'part of smth';              Name: 'percent';           Symbol: '%';        Powers: (1, 0, 0, 0, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 3; UsePrefix: 3; SiPrefix: 0; State: 0; UsePrefixEx: UseNone), // //34
      (Comment: 'temperature';               Name: 'degree Celsius';    Symbol: '°C';       Powers: (1, 0, 0, 0, 0, 0, 0, 0); Shift: 0.0; Scale: 1.0;        Status: 3; UsePrefix: 3; SiPrefix: 0; State: 0; UsePrefixEx: UseNone)  // //35
    )
  );

type
  Prefix = record
    Power: Int32;
    Name: PWChar;
    Symbol: PWChar;
  end;

  TSIUnitPrefix = (
    up_yocto,
    up_zepto,
    up_atto,
    up_femto,
    up_pico,
    up_nano,
    up_micro,
    up_milli,
    up_none,
    up_kilo,
    up_mega,
    up_giga,
    up_tera,
    up_peta,
    up_exa,
    up_zetta,
    up_yotta
  );

const
  SI_Prefix_Set: array[-8..8] of Prefix =(
    (Power: -24; Name: 'yocto'; Symbol: 'y'),
    (Power: -21; Name: 'zepto'; Symbol: 'z'),
    (Power: -18; Name:  'atto'; Symbol: 'a'),
    (Power: -15; Name: 'femto'; Symbol: 'f'),
    (Power: -12; Name:  'pico'; Symbol: 'p'),
    (Power:  -9; Name:  'nano'; Symbol: 'n'),
    (Power:  -6; Name: 'micro'; Symbol: 'µ'),
    (Power:  -3; Name: 'milli'; Symbol: 'm'),
    (Power:   0; Name:      ''; Symbol:  ''),
    (Power:   3; Name:  'kilo'; Symbol: 'k'),
    (Power:   6; Name:  'mega'; Symbol: 'M'),
    (Power:   9; Name:  'giga'; Symbol: 'G'),
    (Power:  12; Name:  'tera'; Symbol: 'T'),
    (Power:  15; Name:  'peta'; Symbol: 'P'),
    (Power:  18; Name:   'exa'; Symbol: 'E'),
    (Power:  21; Name: 'zetta'; Symbol: 'Z'),
    (Power:  24; Name: 'yotta'; Symbol: 'Y')
  );

{Si_EXT_Prefix_Set_Min=-24;
Si_EXT_Prefix_Set_Max= 24;
Si_EXT_Prefix_Set : array[Si_EXT_Prefix_Set_Min..Si_EXT_Prefix_Set_Max] of Prefix =(
(Power:-24; Name:'yocto'    ; Symbol:'y'    ),
(Power:-23; Name:'10 yocto' ; Symbol:'10*y' ),
(Power:-22; Name:'100 yocto'; Symbol:'100*y'),
(Power:-21; Name:'zepto'    ; Symbol:'z'    ),
(Power:-20; Name:'10 zepto' ; Symbol:'10*z' ),
(Power:-19; Name:'100 zepto'; Symbol:'100*z'),
(Power:-18; Name:'atto'     ; Symbol:'a'    ),
(Power:-17; Name:'10 atto'  ; Symbol:'10*a' ),
(Power:-16; Name:'100 atto' ; Symbol:'100*a'),
(Power:-15; Name:'femto'    ; Symbol:'f'    ),
(Power:-14; Name:'10 femto' ; Symbol:'10*f' ),
(Power:-13; Name:'100 femto'; Symbol:'100*f'),
(Power:-12; Name:'pico'     ; Symbol:'p'    ),
(Power:-11; Name:'10 pico'  ; Symbol:'10*p' ),
(Power:-10; Name:'100 pico' ; Symbol:'100*p'),
(Power:-9;  Name:'nano'     ; Symbol:'n'    ),
(Power:-8;  Name:'10 nano'  ; Symbol:'10*n' ),
(Power:-8;  Name:'100 nano' ; Symbol:'100*n'),
(Power:-6;  Name:'micro'    ; Symbol:'µ'    ),
(Power:-5;  Name:'10 micro' ; Symbol:'10*µ' ),
(Power:-4;  Name:'100 micro'; Symbol:'100*µ'),
(Power:-3;  Name:'milli'    ; Symbol:'m'    ),
(Power:-2;  Name:'centi'    ; Symbol:'c'    ),
(Power:-1;  Name:'deci'     ; Symbol:'d'    ),
(Power:0;   Name:''         ; Symbol:''     ),
(Power:1;   Name:'deka'     ; Symbol:'da'   ),
(Power:2;   Name:'hecto'    ; Symbol:'h'    ),
(Power:3;   Name:'kilo'     ; Symbol:'k'    ),
(Power:4;   Name:'10 kilo'  ; Symbol:'10*k' ),
(Power:5;   Name:'100 kilo' ; Symbol:'100*k'),
(Power:6;   Name:'mega'     ; Symbol:'M'    ),
(Power:7;   Name:'10 mega'  ; Symbol:'10*M' ),
(Power:8;   Name:'100 mega' ; Symbol:'100*M'),
(Power:9;   Name:'giga'     ; Symbol:'G'    ),
(Power:10;  Name:'10 giga'  ; Symbol:'10*G' ),
(Power:11;  Name:'100 giga' ; Symbol:'100*G'),
(Power:12;  Name:'tera'     ; Symbol:'T'    ),
(Power:13;  Name:'10 tera'  ; Symbol:'10*T' ),
(Power:14;  Name:'100 tera' ; Symbol:'100*T'),
(Power:15;  Name:'peta'     ; Symbol:'P'    ),
(Power:16;  Name:'10 peta'  ; Symbol:'10*P' ),
(Power:17;  Name:'100 peta' ; Symbol:'100*P'),
(Power:18;  Name:'exa'      ; Symbol:'E'    ),
(Power:19;  Name:'10 exa'   ; Symbol:'10*E' ),
(Power:20;  Name:'100 exa'  ; Symbol:'100*E'),
(Power:21;  Name:'zetta'    ; Symbol:'Z'    ),
(Power:22;  Name:'10 zetta' ; Symbol:'10*Z' ),
(Power:23;  Name:'100 zetta'; Symbol:'100*Z'),
(Power:24;  Name:'yotta'    ; Symbol:'Y'    )
);}

function CreatePCharCopy(Source: PChar): PChar;
function CreatePWCharCopy(Source: PWChar): PWChar;
function SIUnitCount: Int32;
function GetSIUnitBySymbol(ASymbol: WideString): Int32;
function GetPowerBySymbol(ASymbol: WideString): Int32;
function GetSIUnitByText(AValue: WideString; var Coefficient: Float64): Int32;
function FindNextSIUnitByPowers(AStartIndex: Int32; APowers: TUnits): Int32;
function FindClosestSIUnit(AUnit: TUnit): Int32;
procedure CombineTwoUnits(Unit1, Unit2: TUnit; Power1, Power2: Int8; var AUnit: TUnit);
procedure CombineUnits(UnitArray: PArrayOfPointer; PowerArray: PArrayOfInt8;
  Count: Int32; AUnit: TUnit);

function InitNewUnit: TUnit;
procedure ReleaseUnit(var AUnit: TUnit);
procedure CopyUnit(var Unit1: TUnit; Unit2: TUnit);
function CreateUnit(AName, AComment, ASymbol: WideString; APowers: TUnits;
  AShift, AScale: Float64; AStatus, AUsePrefix, ASIPrefix, AState: Int8): TUnit;
function CreateSIUnit(AName, AComment, ASymbol: WideString; APowers: TUnits): TUnit;
procedure DeleteUnit(var APUnit: PUnit);
function GetSIUnit(AIndex: Int32): PUnit;

function FormatUnit(AUnitText: string = ''; AScale: Float64 = 1.0;
  AFactorPower: Int32 = 0; APrecision: Int32 = 0): TFormatUnit;
function DisplayUnit(AUnitText: WideString = ''; AScale: Float64 = 1.0;
  AFactorPower: Int32 = 0; APrecision: Int32 = 0): TDisplayUnit;
function GetDistanceUnit(const XUnit, YUnit: TFormatUnit): TFormatUnit;

implementation

//------------------------------------------------------------------------------
function GetSIUnit(AIndex: Int32): PUnit;
begin
  with Si do
    if (AIndex < 0) or (AIndex > BasicCount + DerivCount + AcceptCount + CustomCount) then
      Result := nil
  else
    Result := @Units[AIndex];
end;
//------------------------------------------------------------------------------
function CreatePCharCopy(Source: PChar): PChar;
begin
  Result := nil;
  if Source <> nil then
  begin
    ReallocMem(Result, (lstrlen(Source) + 1) * SizeOf(Char));
    lstrcpy(Result, Source);
  end;
end;
//------------------------------------------------------------------------------
function CreatePWCharCopy(Source: PWChar): PWChar;
begin
  Result := nil;
  if Source <> nil then
  begin
    ReallocMem(Result, (lstrlenW(Source) + 1) * SizeOf(WChar));
    lstrcpyW(Result, Source);
  end;
end;
//------------------------------------------------------------------------------
function SIUnitCount: Int32;
begin
  Result := Si.BasicCount + Si.DerivCount + Si.AcceptCount + Si.CustomCount;
end;
//------------------------------------------------------------------------------
function GetSIUnitBySymbol(ASymbol: WideString): Int32;
var
  i: Int32;
begin
  Result := -1;
  for i := 0 to SIUnitCount - 1 do
    if si.Units[i].Symbol = ASymbol then
    begin
      Result := i;
      Break;
    end;
end;
//------------------------------------------------------------------------------
function GetPowerBySymbol(ASymbol: WideString): Int32;
var
  i: Int32;
begin
  Result := 50;
  for i := -8 to 8 do
    if Si_Prefix_Set[I].Symbol^ = ASymbol[1] then
    begin
      Result := Si_Prefix_Set[I].Power;
      Break;
    end;
end;
//------------------------------------------------------------------------------
function GetSIUnitByText(AValue: WideString; var Coefficient: Float64): Int32;
var
  TmpPower: Int32;
begin
  Coefficient := 1;
  Result := GetSIUnitBySymbol( AValue );
  if Result < 0 then
  begin
    if Length(AValue) > 1 then
    begin
      Result := GetSIUnitBySymbol(Copy(AValue, 2, Length(AValue) - 1));
      if Result >= 0 then
      begin
        TmpPower := GetPowerBySymbol(AValue);
        if TmpPower >= 50 then
          Result := -1
        else
          case TmpPower of
            -24: Coefficient := 1e-24;
            -21: Coefficient := 1e-21;
            -18: Coefficient := 1e-18;
            -15: Coefficient := 1e-15;
            -12: Coefficient := 1e-12;
             -9: Coefficient := 1e-9;
             -6: Coefficient := 1e-6;
             -3: Coefficient := 1e-3;
              0: Coefficient := 1;
              3: Coefficient := 1e3;
              6: Coefficient := 1e6;
              9: Coefficient := 1e9;
             12: Coefficient := 1e12;
             15: Coefficient := 1e15;
             18: Coefficient := 1e18;
             21: Coefficient := 1e21;
             24: Coefficient := 1e24;
          else
            Coefficient := IntPower(10, TmpPower);
          end;
      end;
    end;
  end
  else
    Coefficient := SI.Units[Result].Scale;
end;
//------------------------------------------------------------------------------
function GetSIUnitByName(AName: WideString): Int32;
var
  i: Int32;
begin
  Result := -1;
  for i := 0 to SIUnitCount - 1 do
    if si.Units[i].Name = AName then
    begin
      Result := i;
      Break;
    end;
end;
//------------------------------------------------------------------------------
function FindNextSIUnitByPowers(AStartIndex: Int32; APowers: TUnits): Int32;
var
  i: Int32;
begin
  Result := -1;
  for i := AStartIndex to SIUnitCount - 1 do
    if CompareMem(@si.Units[i].Powers, @APowers, Sizeof(TUnits)) then
      Result := i;
end;
//------------------------------------------------------------------------------
function FindClosestSIUnit(AUnit: TUnit): Int32;
var
  i: Int32;
  List: TList;
begin
  Result := -1;
  List := TList.Create;
  try
    for i := 0 to SIUnitCount - 1 do
      if CompareMem(@si.Units[i].Powers, @AUnit.Powers, SizeOf(TUnits)) then
        List.Add(Pointer(i));
    if List.Count > 0 then
    begin
      Result := Int32(List[0]);
      if List.Count > 1 then
        for i := List.Count - 1 downto 0 do
          if (AUnit.Scale <> Si.Units[Int32(List[i])].Scale) or
            (AUnit.Shift <> Si.Units[Int32(List[i])].Shift) then
            List.Delete(i);
    end;
    if List.Count > 0 then
    begin
      Result := Int32(List[0]);
      if List.Count > 1 then
        for i := List.Count - 1 downto 0 do
          if (AUnit.Name <> Si.Units[Int32(List[i])].Name) or
            (AUnit.Symbol <> Si.Units[Int32(List[i])].Symbol) then
            List.Delete(i);
    end;
    if List.Count > 0 then
      Result := Int32(List[0]);
  finally
    List.Free;
  end;
end;
//------------------------------------------------------------------------------
procedure ReplaceChar(var Str: WideString; OldChar, NewChar: WChar);
var
  i: Int32;
begin
  for i := 1 to Length(Str) do
    if Str[i] = OldChar then
      Str[i] := NewChar;
end;
//------------------------------------------------------------------------------
procedure UnitSubStrToStrAndPower(var StrList: TStringList;var PowerList: TList);
var
  i: Int32;
  CurPowerSymbolPos: Int32;
begin
  for i := 0 to StrList.Count - 1 do
  begin
    CurPowerSymbolPos := Pos('^', StrList[i]);
    if CurPowerSymbolPos <> 0 then
    begin
      PowerList.Add(Pointer(StrToInt(Copy(StrList[i], CurPowerSymbolPos + 1,
        Length(StrList[i]) - CurPowerSymbolPos))));
      StrList[i] := Copy(StrList[i], 1, CurPowerSymbolPos - 1);
    end
    else
      PowerList.Add(pointer(1));
  end
end;
//------------------------------------------------------------------------------
procedure ParseUnitName(Name: WideString; StrList: TStringList; PowerList: TList);
begin
  ReplaceChar(Name, '*', #13);
  StrList.Text := Name;
  UnitSubStrToStrAndPower(StrList, PowerList);
end;
//------------------------------------------------------------------------------
function CombineTwoUnitStrNames(Name1, Name2: WideString; Power1, Power2: Int32): WideString;
var
  StrList1: TStringList;
  StrList2: TStringList;
  PowerList1: TList;
  PowerList2: TList;
  i: Int32;
  CurIndex: Int32;
begin
  StrList1 := TStringList.Create;
  StrList2 := TStringList.Create;
  PowerList1 := TList.Create;
  PowerList2 := TList.Create;
  try
    ParseUnitName(Name1, StrList1, PowerList1);
    ParseUnitName(Name2, StrList2, PowerList2);
    for i := 0 to StrList1.Count - 1 do
      PowerList1[i] := Pointer(Int32(PowerList1[i]) * Power1);
    for i := 0 to StrList2.Count - 1 do
      PowerList2[i] := Pointer(Int32(PowerList2[i]) * Power2);
    for i := 0 to StrList1.Count - 1 do
    begin
      CurIndex := StrList2.IndexOf(StrList1[i]);
      //if CurIndex=-1 then exit;
      if CurIndex <> -1 then
      begin
        PowerList1[i] := Pointer(Int32(PowerList1[i]) + Int32(PowerList2[CurIndex]));
        StrList2.Delete(CurIndex);
        PowerList2.Delete(CurIndex);
      end;
    end;
    Result := '';
    for i := 0 to StrList1.Count - 1 do
      Result := Result + StrList1[i] + '^' + IntToStr(Int32(PowerList1[i])) + '*';
    for i := 0 to StrList2.Count - 1 do
      Result := Result + StrList2[i] + '^' + IntToStr(Int32(PowerList2[i])) + '*';
    if Result[Length(Result)] = '*' then
      Result := Copy(Result, 1, Length(Result) - 1);
  finally
    StrList1.Free;
    StrList2.Free;
    PowerList1.Free;
    PowerList2.Free;
  end;
end;
//------------------------------------------------------------------------------
function CombineTwoUnitNames(Name1, Name2: PWChar; Power1, Power2: Int8): WideString;
var
  StrName1, StrName2: WideString;
begin
  StrName1 := Name1;
  StrName2 := Name2;
  Result := CombineTwoUnitStrNames(StrName1, StrName2, Power1, Power2);
end;
//------------------------------------------------------------------------------
procedure CombineTwoUnits(Unit1, Unit2: TUnit; Power1, Power2: Int8; var AUnit: TUnit);
var
  i: Int32;
  Name, Symbol: WideString;
begin
  AUnit.Powers[0] := 1;
  for i := 1 to 7 do
    AUnit.Powers[i] := Unit1.Powers[i] * Power1 + Unit2.Powers[i] * Power2;
  i := FindClosestSIUnit(AUnit);
  if i <> -1 then
    CopyUnit(AUnit, si.Units[i])
  else
  begin
    ReallocMem(AUnit.Name,(Length('Custom unit') + 1) * SizeOf(WChar));
    lstrcpyW(AUnit.Comment, 'Custom unit');
    Name := CombineTwoUnitNames(Unit1.Name, Unit2.Name, Power1, Power2);
    ReallocMem(AUnit.Name, (Length(Name) + 1) * SizeOf(WChar));
    lstrcpyW(AUnit.Name, PWChar(Name));
    Symbol := CombineTwoUnitNames(Unit1.Symbol, Unit2.Symbol, Power1, Power2);
    ReallocMem(AUnit.Symbol, (Length(Symbol) + 1) * SizeOf(WChar));
    lstrcpyW(AUnit.Symbol, PWChar(Symbol));
  end;
end;
//------------------------------------------------------------------------------
function CombineUnitNames(UnitArray: PArrayOfPointer; PowerArray: PArrayOfInt8;
  Count: Int32; var AUnit: TUnit): WideString;
var
  StrList1: TStringList;
  StrList2: TStringList;
  PowerList1: TList;
  PowerList2: TList;
  i, j: Int32;
  CurIndex: Int32;
  Power: Int32;
  Symbol: WideString;
  Name: WideString;
begin
  StrList1 := TStringList.Create;
  StrList2 := TStringList.Create;
  PowerList1 := TList.Create;
  PowerList2 := TList.Create;
  try
    for j := 0 to Count - 1 do
    begin
      Name := TUnit(UnitArray[j]^).Name;
      Symbol := TUnit(UnitArray[j]^).Symbol;
      Power := PowerArray[j];
      ParseUnitName(Name, StrList2, PowerList2);
       for i := 0 to StrList2.Count - 1 do
        PowerList2[i] := Pointer(Int32(PowerList2[i]) * Power);
      for i := 0 to StrList1.Count - 1 do
      begin
        CurIndex := StrList2.IndexOf(StrList1[i]);
        if CurIndex = -1 then
          Exit;
        PowerList1[i] := Pointer(Int32(PowerList1[i]) + Int32(PowerList2[CurIndex]));
        StrList2.Delete(CurIndex);
        PowerList2.Delete(CurIndex);
      end;
      StrList1.AddStrings(StrList2);
      for i := 0 to PowerList2.Count - 1 do
        PowerList1.Add(PowerList2[i]);
      StrList2.Clear;
      PowerList2.Clear;
    end;
    Result := '';
    for i := 0 to StrList1.Count - 1 do
      Result := Result + StrList1[i] + '^' + IntToStr(Int32(PowerList1[i])) + '*';
    if Result[Length(Result)] = '*' then
      Result := Copy(Result, 1, Length(Result) - 1);
  finally
    StrList1.Free;
    StrList2.Free;
    PowerList1.Free;
    PowerList2.Free;
  end;
end;
//------------------------------------------------------------------------------
procedure CombineUnits(UnitArray: PArrayOfPointer; PowerArray: PArrayOfInt8;
  Count: Int32; AUnit: TUnit);
var
  i, j: Int32;
begin
  for i := 1 to 7 do
  begin
    AUnit.Powers[i] := 0;
    for j := 0 to Count - 1 do
      AUnit.Powers[i] := AUnit.Powers[i] + TUnit(UnitArray[j]^).Powers[i] * PowerArray[j];
  end;
  i := FindClosestSIUnit(AUnit); //?????
  if i <> -1 then
    CopyUnit(AUnit, si.Units[i])
  else
  begin
    ReallocMem(AUnit.Name, (Length('Custom unit') + 1) * SizeOf(WChar));
    lstrcpyW(AUnit.Comment, 'Custom unit');
    CombineUnitNames(UnitArray, PowerArray, Count, AUnit);
  end;
end;
//------------------------------------------------------------------------------
function InitNewUnit: TUnit;
var
  i: Int32;
begin
  with Result do
  begin
    Comment := nil;
    Name := nil;
    Symbol := nil;
    Powers[0] := 1;
    for i := 1 to 7 do
      Powers[i] := 0;
    Shift := 0.0;
    Scale := 1.0;
    Status := 0;
    UsePrefix := 0;
    SIPrefix := 0;
    State := 0;
  end;
end;
//------------------------------------------------------------------------------
procedure ReleaseUnit(var AUnit: TUnit);
begin
  ReallocMem(AUnit.Comment, 0);
  ReallocMem(AUnit.Name, 0);
  ReallocMem(AUnit.Symbol, 0);
end;
//------------------------------------------------------------------------------
procedure CopyUnit(var Unit1: TUnit; Unit2: TUnit);
begin
  ReallocMem(Unit1.Comment, ((lstrlenW(Unit2.Comment) + 1) * SizeOf(WChar)));
  lstrcpyW(Unit1.Comment, Unit2.Comment);
  ReallocMem(Unit1.Name, (lstrlenW(Unit2.Name) + 1) * SizeOf(WChar));
  lstrcpyW(Unit1.Name, Unit2.Name);
  ReallocMem(Unit1.Symbol, (lstrlenW(Unit2.Symbol) + 1) * SizeOf(WChar));
  lstrcpyW(Unit1.Symbol, Unit2.Symbol);
  Unit1.Powers := Unit2.Powers;
  Unit1.Shift := Unit2.Shift;
  Unit1.Scale := Unit2.Scale;
  Unit1.Status := Unit2.Status;
  Unit1.UsePrefix := Unit2.UsePrefix;
  Unit1.SIPrefix := Unit2.SIPrefix;
  Unit1.State := Unit2.State;
end;
//------------------------------------------------------------------------------
function CreateUnit(AName, AComment, ASymbol: WideString; APowers: TUnits;
  AShift, AScale: Float64; AStatus, AUsePrefix, ASIPrefix, AState: Int8): TUnit;
begin
  with Result do
  begin
    Comment := CreatePWCharCopy(PWChar(AComment));
    Name := CreatePWCharCopy(PWChar(AName));
    Symbol := CreatePWCharCopy(PWChar(ASymbol));
    Powers := APowers;
    Shift := AShift;
    Scale := AScale;
    Status := AStatus;       //0-Basic 1-Derived 2-Acceptable 3-Custom
    UsePrefix := AUsePrefix; //0-Use 1-Possible 2- Sometimes 3-Never
    SIPrefix := ASIPrefix;   //prefix to use to get standard SI unit
    State := AState;         //reserved
  end;
end;
//------------------------------------------------------------------------------
function CreateSIUnit(AName, AComment, ASymbol: WideString; APowers: TUnits): TUnit;
begin
  Result := CreateUnit(AName, AComment, ASymbol, APowers, 0, 1, 3, 3, 0, 0);
end;
//------------------------------------------------------------------------------
procedure DeleteUnit(var APUnit:PUnit);
begin
  ReallocMem(APUnit^.Comment, 0);
  ReallocMem(APUnit^.Name, 0);
  ReallocMem(APUnit^.Symbol, 0);
  Dispose(APUnit);
end;
//------------------------------------------------------------------------------
function FormatUnit(AUnitText: string = ''; AScale: Float64 = 1.0;
  AFactorPower: Int32 = 0; APrecision: Int32 = 0): TFormatUnit;
begin
  Result.UnitText    := AUnitText;
  Result.Scale       := AScale;
  Result.FactorPower := AFactorPower;
  Result.Precision   := APrecision;
end;
//------------------------------------------------------------------------------
function DisplayUnit(AUnitText: WideString = ''; AScale: Float64 = 1.0;
  AFactorPower: Int32 = 0; APrecision: Int32 = 0): TDisplayUnit;
begin
  Result.UnitText := AUnitText;
  Result.Scale := AScale;
  Result.FactorPower := AFactorPower;
  Result.Precision := APrecision;
end;
//------------------------------------------------------------------------------
function GetDistanceUnit(const XUnit, YUnit: TFormatUnit): TFormatUnit;
var
  XCoeff, YCoeff: Float64;
begin
  Result := FormatUnit;
  if GetSIUnitByText(XUnit.UnitText, XCoeff) = GetSIUnitByText(YUnit.UnitText, YCoeff) then
    if XCoeff <= YCoeff then
      Result := XUnit
    else
      Result := YUnit;
{
  Result.Scale := SQRT(XUnit.Scale*XUnit.Scale + YUnit.Scale*YUnit.Scale);
  if GetSIUnitByText(XUnit.UnitText, XCoeff) = GetSIUnitByText(YUnit.UnitText, YCoeff) then
  begin
    if XCoeff < YCoeff then
    begin
      Inc(Result.FactorPower, GetValueExponent(Result.Scale / XUnit.Scale));
      Result.UnitText := XUnit.UnitText;
    end
    else
    begin
      Inc(Result.FactorPower, GetValueExponent(Result.Scale / YUnit.Scale));
      Result.UnitText := YUnit.UnitText;
    end;
  end;
}
end;
//------------------------------------------------------------------------------

end.
