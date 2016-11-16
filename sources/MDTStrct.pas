unit MDTStrct;

interface

uses
  Windows, SysUtils, Classes,
  BaseTypes, SysUnits;

const
  SizeOf_FileHeader = 33;
  c_mod    = 8;  // sizeof(mode_r);
  c_hdr    = 22; // sizeof(hdr_r);
  c_xyz    = 30; // sizeof(xyz_ru0);
  txt_am   = 10;

  nab0  = 3;
  N_max  = 1000;

// h_what constants
  ftScan    = 0;
  ftSpec    = 1;
  ftText    = 3;
  ftOldMDA  = 105;
  ftMDA     = 106;
  ftPalette = 107;
  ftNewSpec = 201;

// h_ver constants (for MDA: $320..$3ff)


  a_oem: array[0..14] of string =
    ('NT-MDT', 'PSI', 'Omicron', 'SM2', 'DI', 'Topo', 'Rscope', 'WAT', 'PCX',
     'PGM', 'HDF', 'PLU', 'MMD', 'WSxM', 'Unknown');

type
  a_b3 = array[0..nab0]  of UInt8;
  a_i3 = array[0..nab0]  of Int16;
  a_sp = array[0..N_max + 10] of Int16;
  p_sp  = ^a_sp;

  Ts_pl2z = record
    bon  : UInt8;    //number of surface substractions
    k00  : Float32; // A
    k10  : Float32; // Bx
    k01  : Float32; // BY
    k20  : Float32; // Bxx
    k02  : Float32; // Byy
    k11  : Float32; // Cxy
    az00 : Float32; //Evplov
    azk0 : Float32; //Evplov
  end;

//***************************** MDT File structure ****************************

  f_title = packed record
    f_msk  : Int32;     // mask of *.mdt
    f_sz   : Int32;     // size of all records
    f_isz0 : Int32;     // size of image record
    f_nt   : Int16;     // total records 0..N
    f_r0   : UInt8;      //
    f_str  : string[32-15];
  end;

  hdr_r = packed record
    h_sz    :  Int32;      // size of record
    h_what  :  Int16;      // 0-scan;1-spec;3-text
    h_ver   :  Int16;      // version
    h_yea   :  UInt16;     // year
    h_mon   :  UInt16;     // month
    h_day   :  UInt16;     // day
    h_h     :  UInt16;     // houre
    h_m     :  UInt16;     // min
    h_s     :  UInt16;     // sec
    h_am    :  UInt16;     // bytes of variables
  end;

  TDosAxis = packed record
    r0: Float32;
    r: Float32;     // x norm.
    u: Int16;       // x unit
  end;

  xyz_ru0 = packed record
    x: TDosAxis;
    y: TDosAxis;
    z: TDosAxis;
  end;

  mode_r = packed record
    m_mode:  UInt16;     // mode of record
    m_nx:  UInt16;     // nx
    m_ny:  UInt16;     // ny
    m_nd:  UInt16;     // dots number
  end;

type
  TPlane3DData = packed record
    plane: UInt8;        //0:arbitrary; 1:XY,2:YZ,3:XZ,4:alt arbitrary,5:YX,6:ZY,7:ZX
    e1: TPoint3D_F32;
    e2: TPoint3D_F32;
    e3: TPoint3D_F32;
    normal: TPoint3D_F32;
  end;

type
  scn_var = packed record          //  h_what=0
    s_mode         : UInt8;        // Channel of measurement - depends on ADC (s_a1`2)
    s_dev          : UInt8;        // 0: STM, 1: AFM
    s_nx           : Int16;        // 2byte// Nx - pixels
    s_ny           : Int16;        // 2byte// Ny - pixels
    s_rv6          : Int16;        // Reserved  {sq - ac step in old versions?????????}
    s_rs           : Float32;      // 4byte // step   (  A )
    s_adt          : UInt16;       // averaging 1..100
    s_adc_a        : UInt8;        // ADC amplifyer 0..3=1,10,100,1000
    s_a12          : UInt8;        // adc # 0-adc1,1-adc2
    s_8xx          : UInt8;        // program version 8xx  ???????   //s_smp_in       : UInt8;        // Ex5,Bv,E sample input ?????????????
    z_03           : UInt8;        // 0..3àTz03             ???????   //s_spl          : UInt8;        // off,1-slope,2nd slope
    s_xy           : UInt8;        // Scan Dir +Y,+X,-Y,-X   & Pass 7bit (1 - II pass, 0 - I pass)
    s_2n           : Bool8;        // s_nx ,s_ny = 2**n
    s_vel          : Float32;      // scan velocity Ang/sec
    s_i0           : Float32;      // SP (nA)
    s_ut           : Float32;      // Bv (v)
    s_draw         : Bool8;        // during scan \ after
    s_2b           : Bool8;        // BackScan
    s_x00          : Int32;        // Dac'x offset of scan
    s_y00          : Int32;        // Dac'x offset of scan
    s_cor          : Bool8;        // NLCor:  On\Off
    s_oem          : UInt8;        // 0: MDT \ 1: PARK
    s_shos         : UInt8;        // show scope data
    s_shsl         : UInt8;        // show scan lines
    z_tune         : UInt8;        // xxxx
    s_fbg          : Float32;      // FB gain
    s_s            : Int32;        // DAC Step
    s_resc         : Bool8;        // redraw each scan
    s_rv1          : UInt8;        // reserved//(s_me3: Bool8;       // median filter}
//TODO: s_rv2 = Bool32 ???? îøèáêà ????????
    s_rv2          : Bool8;        // reserved//{s_av3: Bool8;       // average filter}
    s_rv3          : UInt8;        // reserved//{s_bbb: UInt8;        // xxx           }
    s_mAD          : a_b3;         // scan A,B,C,D:
    s_di3          : a_b3;         // dir  A,B,C,D:
    s_gn3          : a_b3;         // gain A,B,C,D
    s_ms3          : a_b3;         // A&B, C&D ADC measure
    s_xov          : Int16;        // overscan
    s_tem          : Float32;      // temperature
    k_qsc          : UInt8;        // FScan #
    p_rv1          : Float32;      // Reserved // z_go:Float32// DAC_ua
    s_ex7          : Float32;      // DAC_ex7
    s_lps          : Float32;      // DAC SD Lpass
    s_lpr          : Float32;      // DAC Rms Lpass
    s_lp0          : Float32;      // ADC1 Filter Low Pass

    s_fbo          : UInt8;        // FB out
    k_fun          : UInt8;        // Modul-on OUT
    s_fbv          : UInt8;        // FB on/off
    s_fbn          : UInt8;        // FB inp
    s_ipr          : UInt8;        // p47h  [I]
    k_sdi          : UInt8;        // SD Inp
    k_rmi          : UInt8;        // RMS Inp
    p_in1          : UInt8;        // Phase input 1
    p_in2          : UInt8;        // Phase input 2
    p_phi          : UInt8;        // PhDet inp high/low
    k_hl           : UInt8;        // PhDet SD high/low
    p_ou1          : Int16;        // Ph: out1   //????????? K_RV1???
    p_ou2          : Int16;        // Ph: out2
    k_har          : Int16;        // SD harmonic
    k_f0           : Float32;      // Fmin ?????????
    k_f1           : Float32;      // F    ?????????
    k_fr           : Float32;      // Fmax ?????????
    k_gen          : Float32;      // Modul-n Amplitude
    p_rv2 {z_gen}  : Float32;      // Phase IGain
    p_rv3 {z_mul}  : Float32;      // Phase PGain
    k_fas          : Float32;      // Modul-n Phase
    k_mul          : Float32;      // SD gain
    k_sd_10        : UInt8;        // SD 0|1|2 DFL,Ipr,Ext x10
    p_vc_0 {k_st_10}: UInt8;       //Phase1 E
    p_fb1  {k_ex_10}: UInt8;       //Phase1 FB
    k_sd_x         : UInt8;        //Modulation probe gain x0.1...x10
    z_lift         : Float32;      // Z-lift
    {z_fr : Float32;}              //    Obsolete
    {z_fas : Float32;}             //   Obsolete

    s_av3          : Bool8;        //Average filter
    s_me3          : Bool8;        //Median filter
    s_35x          : UInt8;        // .3. .5. NxN
    s_ex5          : UInt8;        //EX5
    s_dfm          : UInt8;        //DFM mode
    s_fbs          : UInt8;        //xor 1 FB sign
    s_las          : UInt8;        //laser
    s_ili          : UInt8;        //puls litho
    s_smp_in       : UInt8;        //Ex5, Bv,E
    s_spl          : UInt8;        //slope subtract 0..4
{    z_har          : Int16;}     // obsolete
    z_all          : UInt8;        //MFM///Exten
    z_rv1{z_tune}  : UInt8;        //reserved ????????????????

    s_lsrr         : Float32;     //RL mover coord
    s_lslr         : Float32;     //RL mover coord

//-------------version
    s_hsmp         : Float32;     //???????????????????????????????

    s_rev          : string[10];  // reserv
    rv             : UInt16;        { adjust for i_p0->xxx0h}
{----additional-----------------------------------}
    as_spl0        : TS_pl2z;
// 3+  - was bug with Bool and Bool8 in s_rv2
    as_rev         : string[3+127-1];{ reserv}
    ZRelativeCoord : UInt8; // 0 - undefined; 1 - Absolute; 2 - Relative
//SFOM project
    plane3DData: TPlane3DData; //3Dimensional plane parameters
  end;
{
  sp_var = record                //h_what=1
    sp_mode        : UInt16;      // spec mode
    sp_filtr       : UInt16;      // adc filtr
    sp_ub,sp_ue    : Float32;     // spec Ut: begin \ end
    sp_z           : Float32;     // Z diap for It(z)
    sp_adt         : UInt16;      // averaging
    sp_scn         : Bool8;       // scan+ spec
    sp_osc         : Bool8;       // scan+ spec
    sp_rev         : string[20];  // reserv
    sp_ev2         : UInt8;        // reserv
    sp_res         : word32;      // reserv
    scn_guid       : TGUID;       // scan guid
  end;
}
  sp_var = record                //h_what=1
    sp_mode        : UInt16;      // spec mode
    sp_filtr       : UInt16;      // adc filtr
    sp_ub,sp_ue    : Float32;     // spec Ut: begin \ end
    sp_zu, sp_zd   : Int16;       // Z diap for It(z)
    sp_adt         : UInt16;      // averaging      .
    sp_rep         : Bool8;       // repeat
    sp_back        : Bool8;       // & back
    sp_4nx         : Int16;       // =0 or sp_nx
    sp_osc         : Bool8;       // show spec by scope
    sp_n4          : UInt8;        // (.) x50..All
    sp_4x0         : Float32;     // si_rx0 for All
    sp_4xr         : Float32;     // si_rx for All
    sp_4u          : Int16;       // si_un  for All
    sp_4i          : Int16;       // Section index
    sp_nx          : Int16;       // Points
    sp_res         : string[96 - 1];  // Reserved for DOS version
    // Windows version
    sp_ver         : Int8;        // Curves version: 0 - old; 1 - new
    scn_guid       : TGUID;       // scan guid
  end;

  // Oder in Many Demantional Frame (h_what=105)    <---- Kto eto napisal ??????
  // hdr_r  -  header of frame
  mdf_h = packed record      // Header of MDF
    h_par_dim: Int32;   // Dimension
    h_func_dim: Int32;
    h_type: Int32;  // Type
    sz_com: Int32;  // Size of Commentary
    sz_name: Int32;
    sz_info: Int32;
  end;
  // Commentary - sz_com UInt8
  // DetectorName - sz_name
  // DetectorInfo - sz_info
  // h_dem count
  mdf_k = packed record
    k_x, k_x0: double;
    k_ux: Int32;
    Nx: Int32;
    DeviceID:string[115];
    ParameterID:string[115];
  end;
  // data

  mda_var = packed record
    MDAHeader: mdf_h;
    SizeOfData: Int32; //size of 1 unit data in file
    Comment: AnsiString;
    DetectorName : AnsiString;
    DetectorInfo : TMemoryStream;
    Dim: array of mdf_k;
    DataOffset: cardinal;
    DataSize: cardinal;
//    Fun: array of mdf_k;
  end;

  PExtFrameHeader = ^TExtFrameHeader;
  TExtFrameHeader = packed record
    Size         : int32; // Size of record
    TotalSize    : int32; // Total header size
    GUID         : TGUID; // GUID of a frame
    MesGUID      : TGUID; // Measurement QUID
    Status       : int32; // Frame status
    NameSize     : int32; // The size of frame's name
    CommSize     : int32; // The size of frame's comment
    SpecSize     : int32; // The size of frame's special string (reserved)
    ViewInfoSz   : int32; // The size of frame's view info
    SourceInfoSz : int32; // The size of frame's source info
    VarSize      : int32; // The size of variables
    DataOffset   : int32; // The offset of the main frame's data (anywhere in a file!)
    DataSize     : int32; // The size of the main frame's data
    // ...
  end; { Just after this record Name, Comment, Special strings, ViewInfo, SourceInfo
  and Var follows in MDT file. Further other information (data) can follow
  so far as hdr_r.h_sz allows.}

type p_scn_v = ^scn_var;
type p_sp_v  = ^sp_var;
type p_mda_v = ^mda_var;
type xyz_ru0_p = ^xyz_ru0;
type hdr_r_p = ^hdr_r;
type mode_r_p = ^mode_r;

//function GetDosChannnelName(aScnVar:TScnVar):string;
function GetDosChannnelNameByIndex(ADCIndex,ChannelIndex:integer):string; //ADC=0 ~ ADC1; ADC=1~ADC2
function GetOldUnitSymbolByIndex(aIndex:integer):string;
function GetOldUnitTypeByIndex(aIndex:integer):string;
function GetOldUnitIndexBySymbol(aUnitSymbol:string):integer;
function AllUnitNamesToStr:string;
function OldUnitIndexToSIIndex(aIndex:integer; var Coefficient:double):integer;//Negative Value - look a_un, positive - SI equivalent exist
//function OldUnitIndexToSIUnit(aIndex:integer):TUnit;
procedure OldUnitIndexToSIUnit(aIndex:integer;var AUnit:TUnit);
function SIIndexToOldUnitIndex(aIndex:integer; var Coefficient:double):integer;//Negative Value - look a_un, positive - SI equivalent exist
function SiUnitToOldUnitIndex(aUnit:TUnit):integer;
function IsValidOldUnitIndex(aIndex:integer):boolean;
function GetDOSUnitScale(aIndex:integer): Double;

function DOSAxis(r0, r: Float32; u: Int16):TDosAxis;
procedure SetDefaultAxisCoeff(var AAxis: TDosAxis);


implementation
const                                   //ADC1 //ADC2
  str_off       = '  Off';              //-1 //-1
  str_height    = 'Height';             //0  //0
  str_nf        = '  DFL';              //1  //1
  str_lf        = 'Lateral F';          //2  //2
  str_biasv     = 'Bias V';             //3  //3
  str_current   = 'Current';            //4  //4
  str_fbout     = 'FB-OUT';             //5  //5
  str_mod       = '  MAG';              //6  //6
  str_msi       = 'MAG*Sin';            //7  //7
  str_mco       = 'MAG*Cos';            //8  //8
  str_rms       = '  RMS';              //9  //9
  str_cmod      = 'CalcMAG';            //10 //10
  str_phase1    = 'Phase1';             //11 //11
  str_phase2    = 'Phase2';             //12 //12
  str_phasecalc = 'CalcPhase';          //13 //13
  str_ex1       = '  Ex1';              //14
  str_ex2       = '  Ex2';              //15
  str_ex3       = '  Ex3';                   //14
  str_ex4       = '  Ex4';
  str_ex5       = '  Ex5';
  str_ex6       = '  Ex6';
  str_ex7       = '  Ex7';
  str_hvx       = '  HvX';              //16 //16
  str_hvy       = '  HvY';              //17 //17
  str_SnapBack  = 'Snap Back';          //18 //18


MinOldUnitIndex = -10;
MaxOldUnitIndex =  39;
a_su   : array[MinOldUnitIndex..MaxOldUnitIndex] of string =
('1/cm',
{-9}    'N-9','N-8','N-7','N-6',             //Reserved
{-5}    'm','cm','mm','µm','nm','Angstrom',  //Metric
{1}     'nA','V','','kHz','°','%','øC','V',  //Misc
{9}     'sec','ms','µs','ns',                //Time
{13}    'Counts','Pixels',                   //Numbers
{15}    'N15','N16','N17','N18','N19',       //Reserved for SFOM
{20}    'A','mA','µA','nA','pA',             //Current
{25}    'V','mV','µV','nV','pV',             //Voltage
{30}    'N','mN','µN','nN','pN',             //Force
{35}    'N35','N36','N37','N38','N39'        //Reserved for DOS version (Ext)
);
a_sm   : array[MinOldUnitIndex..MaxOldUnitIndex] of string =
('Raman Shift',
''{N-9},''{N-8},''{N-7},''{N-6},                                     //Reserved
'Length','Length','Length','Length','Length','Length',                  //Metric
'Current','Voltage','','Frequency','Angle','','Temperature','Voltage',  //Misc
'Time','Time','Time','Time',                    //Time
'','',                               //Numbers
''{N15},''{N16},''{N17},''{N18},''{N19},       //Reserved for SFOM
{20}'Current','Current','Current','Current','Current', //Current
{25}'Voltage','Voltage','Voltage','Voltage','Voltage', //Voltage
{30}'Force','Force','Force','Force','Force',   //Force
{35}''{N35},''{N36},''{N37},''{N38},''{N39}   //Reserved for DOS version (Ext)
);

a_siui : array[MinOldUnitIndex..MaxOldUnitIndex] of integer =
(-1{Raman Shift},
7{N-9},7{N-8},7{N-7},7{N-8},
0,0,0,0,0,0,
3,16,7,10,8,7,4,16,
2,2,2,2,
7,7,
7{N15},7{N16},7{N17},7{N18},7{N19},  //Reserved for SFOM
{20}3,3,3,3,3,
{25}16,16,16,16,16,
{30}11,11,11,11,11,
{35}7{N35},7{N36},7{N37},7{N38},7{N39}        //Reserved for DOS version (Ext)
);


a_un   : array[-1..16] of string =
(
{-1}'Raman Shift',
{0}'Length',
{1}'Weight',
{2}'Time',
{3}'Current',
{4}'Temperature',
{5}'amount of substance',
{6}'luminous intensity',
{7}'',
{8}'Plane Angle',
{9}'Solid Angle',
{10}'Frequency',
{11}'Force',
{12}'pressure',
{13}'energy',
{14}'power',
{15}'electric charge',
{16}'Voltage'
);

a_buc : array[MinOldUnitIndex..MaxOldUnitIndex] of extended =
(1,
1{N-9},1{N-8},1{N-7},1{N-8},
1,1E-2,1E-3,1E-6,1E-9,1E-10,
1E-9,1,1,1E+3,1,1,1,1,
1,1E-3,1E-6,1E-9,
1,1,
1{N15},1{N16},1{N17},1{N18},1{N19},  //Reserved for SFOM
{20}1,1E-3,1E-6,1E-9,1E-12,
{25}1,1E-3,1E-6,1E-9,1E-12,
{30}1,1E-3,1E-6,1E-9,1E-12,
{35}1{N35},1{N36},1{N37},1{N38},1{N39}        //Reserved for DOS version (Ext)
);
MinDosChannelIndex=-1;
MaxDosChannelIndex=18;
WinChannelShift=32;

a_scfA: array[MinDosChannelIndex..MaxDosChannelIndex] of string[9]=
  (str_off,str_height,str_nf,str_lf,str_biasv,str_current,str_fbout,
   str_mod,str_msi,str_mco,str_rms,str_cmod,str_phase1,str_phase2,str_phasecalc,
   str_ex1,
   str_ex2,
   str_hvx,str_hvy,str_SnapBack
   );

a_scfB: array[MinDosChannelIndex..MaxDosChannelIndex] of string[9]=
  (str_off,str_height,str_nf,str_lf,str_biasv,str_current,str_fbout,
   str_mod,str_msi,str_mco,str_rms,str_cmod,str_phase1,str_phase2,str_phasecalc,
   str_ex3,
  {$IFDEF Umeno}'  T0'{$ELSE} '  Tø1' {$ENDIF},
   str_hvx,str_hvy,str_SnapBack
   );

function GetDosChannnelNameByIndex(ADCIndex,ChannelIndex:integer):string; //ADC=0 ~ ADC1; ADC=1~ADC2
begin
  if
    (ChannelIndex>=MinDosChannelIndex)
     and
    (ChannelIndex<=MaxDosChannelIndex)
     and
    (ADCIndex in [0,1])
  then
    case ADCIndex of
        0: Result:=a_scfA[ChannelIndex];
        1: Result:=a_scfB[ChannelIndex];
    end
  else
    Result:='ADC#'+IntToStr(ADCIndex*32+ChannelIndex);
end;

var
  OldUnitNames:TStringList;
function OldUnitIndexToSIIndex(aIndex:integer; var Coefficient:double):integer;//Negative Value - look a_un, positive - SI equivalent exists
begin
  Result:=-32767;
  Coefficient:=1;
  if (MinOldUnitIndex<=aIndex)and(aIndex<=MaxOldUnitIndex) then
  begin
    Result:=a_siui[aindex];
    Coefficient:=a_buc[aindex];
  end
  else
    if (aIndex>=1000)and(aIndex<1000+SIUnitCount-1) then
      Result:=(aIndex-1000) div 17;
end;

{function OldUnitIndexToSIUnit(aIndex:integer):TUnit;
begin
  Result:=SI.units[7];
  if (MinOldUnitIndex<=aIndex)and(aindex<=MaxOldUnitIndex) then
  begin
    if (a_siui[aindex]>0) and (a_siui[aindex]<SIUnitCount-1) then
      Result:=si.units[a_siui[aindex]];
  end
  else
    if (aIndex>=1000)and(aIndex<1000+SIUnitCount-1) then
      Result:=SI.units[(aIndex-1000) div 17];
end;}

procedure OldUnitIndexToSIUnit(aIndex:integer;var AUnit:TUnit);
begin
  CopyUnit(AUnit,SI.units[7]);
  if (MinOldUnitIndex<=aIndex)and(aindex<=MaxOldUnitIndex) then
  begin
    if (a_siui[aindex]>-1) and (a_siui[aindex]<SIUnitCount-1) then
      CopyUnit(AUnit,si.units[a_siui[aindex]]);
  end
  else
    if (aIndex>=1000)and(aIndex<1000+SIUnitCount-1) then
      CopyUnit(AUnit,SI.units[(aIndex-1000) div 17]);
end;

function GetOldUnitSymbolByIndex(aIndex:integer):string;  //??????
begin
  Result:='';
  if (MinOldUnitIndex<=aIndex)and(aIndex<=MaxOldUnitIndex) then
    Result:=a_su[aIndex]
  else
    if (aIndex>=1000)and(aIndex<1000+SIUnitCount*17-1) then
      Result:=Si.Units[(aIndex-1000) div 17].Symbol;
end;

function GetOldUnitTypeByIndex(aIndex:integer):string;
begin
  Result:='';
  if (MinOldUnitIndex<=aIndex)and(aindex<=MaxOldUnitIndex) then
    Result:=a_sm[aindex]
  else
    if (aIndex>=1000)and(aIndex<1000+SIUnitCount*17-1) then
      Result:=Si.Units[(aIndex-1000) div 17].Comment;
end;

function GetOldUnitIndexBySymbol(aUnitSymbol:string):integer;
var
  i: Integer;
begin
  i := OldUnitNames.IndexOf(aUnitSymbol);
  if i > -1 then
    Result:=MinOldUnitIndex+i
  else
  begin
    i := GetSIUnitBySymbol(aUnitSymbol);
    if i = -1 then
      Result := 3
    else
      Result := 1000 + i * 17;
  end;
//    Result:=1000+GetSIUnitBySymbol(aUnitSymbol)*17;
//  if Result=-1 then Result:=3;
end;

function SIIndexToOldUnitIndex(aIndex:integer; var Coefficient:double):integer;
var i:integer;
begin
  Result:=-1;
  for i:=MinOldUnitindex to MaxOldUnitindex do
    if a_siui[i]=aIndex then
    begin
      Result:=i;
      Coefficient:=a_buc[aindex];
    end;
  if Result=-1 then
  begin
    Result:=1000+aindex*17;
    Coefficient:=1;
  end;
end;

function SiUnitToOldUnitIndex(aUnit:TUnit):integer;
var coeff:double;
begin
  Result:=FindNextSIUnitByPowers(0,aUnit.Powers);
  if Result>=1000 then
    Result:=3
  else
    Result:=SIIndexToOldUnitIndex(Result,coeff);
end;

function IsValidOldUnitIndex(aIndex:integer):boolean;
begin
  Result:=not((aIndex<MinOldUnitIndex) or (aIndex>MaxOldUnitIndex));
end;

function GetDOSUnitScale(aIndex:integer): Double;
begin
  GetSIUnitByText(GetOldUnitSymbolByIndex(aIndex), Result);
end;

function AllUnitNamesToStr:string;
begin
  Result:=OldUnitNames.Text;
end;

function DOSAxis(r0, r: Float32; u: Int16): TDosAxis;
begin
  Result.r0 := r0;
  Result.r := r;
  Result.u := u;
end;

procedure SetDefaultAxisCoeff(var AAxis: TDosAxis);
begin
  AAxis := DOSAxis(0, 1, 3);
end;

procedure InitUnitNames;
var
  i: Integer;
begin
  OldUnitNames := TStringList.Create;
  for i := MinOldUnitIndex to MaxOldUnitIndex do
    OldUnitNames.Add(a_su[i]);
end;

procedure FinitUnitNames;
begin
  OldUnitNames.Free;
end;

initialization
  InitUnitNames;

finalization
  FinitUnitNames;

end.






