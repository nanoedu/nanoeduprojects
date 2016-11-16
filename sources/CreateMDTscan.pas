unit CreateMDTscan;  //170309 Gruzdev

interface

uses SysUtils,DateUtils,Classes;

type
// data structures
  Int32         = Integer;
  Int8          = ShortInt;
  UInt8         = Byte;
  Int16         = Smallint;
  UInt16        = Word;
  Float32       = Single;
  Bool8         = ByteBool;
  a_b3 = array[0..3]  of UInt8;

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

  TPoint3D_F32 = packed record
    x: Float32;
    y: Float32;
    z: Float32;
  end;

  TPlane3DData = packed record
    plane: UInt8;        //0:arbitrary; 1:XY,2:YZ,3:XZ,4:alt arbitrary,5:YX,6:ZY,7:ZX
    e1: TPoint3D_F32;
    e2: TPoint3D_F32;
    e3: TPoint3D_F32;
    normal: TPoint3D_F32;
  end;

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

  MDTaddFieldStrct = packed  record
    NameSize              : Integer;
    CommentSize           : Integer;
    FrameSpecialSize      : Integer;
    ViewInfoSize          : Integer;
    SourceInfoSize        : Integer;
    FrameGUIDSize         : Integer;
    FrameGUID             : TGUID;
    MeasurementGUID       : TGUID;
  end;

 MDTscanCreate = class (TObject)
  private
  title : f_title;
  hdr   : hdr_r;
  axsc  : xyz_ru0;
  sc_vr : scn_var;
  mode  : mode_r;
  data  : Pointer;
  add_fd: MDTaddFieldStrct;
  public

  constructor Create(nx,ny:integer; x0,y0,z0,xr,yr,zr:double;
              xUnit,yUnit,zUnit:string; data_p:pointer); overload;
  procedure   WriteToStream(stream:TStream);
  procedure   SaveToFile(const filename:string);

  end;

implementation

function UnitCode(const name:string):integer;
begin
    if name='nm' then Result := -1
    else if name='a.u' then Result := 3    //  dimensionless
    else if name='N' then Result := 13     // counts
    else if name='V' then Result := 25
    else if name='nA' then Result := 23
    else Result:=-1;
end;

constructor MDTscanCreate.Create(nx,ny:integer; x0,y0,z0,xr,yr,zr:double;
                        xUnit,yUnit,zUnit:string; data_p:pointer);
var
  DT : TDateTime;
begin
  inherited Create;
  with title do
  begin
    f_msk := $FF93B001;
    f_sz := sizeof(hdr_r)+sizeof(xyz_ru0)+sizeof(scn_var)+sizeof(mode_r)+sizeof(Int16)*nx*ny+sizeof(MDTaddFieldStrct);
    f_isz0 := 0;
    f_nt := 0;
    f_r0 := 0;
    f_str := '{c} 1998, NT-MDT';
  end;

  with hdr do
  begin
  DT := Now;
  DecodeDateTime(DT,h_yea,h_mon,h_day,h_h,h_m,h_s,h_am);
    h_sz := title.f_sz;
    h_what := 0;
    h_ver  :=  $0307;
  //Hi(h_ver) := 3;
  {  h_yea := 2009;
    h_mon := 0;
    h_day := 0;
    h_h := 0;
    h_m := 0;
    h_s := 0; }
    h_am := 442;
  end;

  with axsc do
  begin
    x.r0 := x0;
    x.r  := xr;
    x.u  := -1;
    y.r0 := y0;
    y.r  := yr;
    y.u  := -1;
    z.r0 := z0;
    z.r  := zr;
    z.u  := -1;
  end;

  with sc_vr do
  begin
  s_mode := 0;
    s_dev  := 0;
    s_nx   := nx;
    s_ny   := ny;
    s_rv6  := 0;
    s_rs   := 0;
    s_adt  := 0;
    s_adc_a:= 0;
    s_a12  := 0;
    s_8xx  := 0;
    z_03   := 0;
    s_xy   := 0;
    s_2n   := false;
    s_vel  := 0;
    s_i0   := 0;
    s_ut   := 0;
    s_draw := false;
    s_2b   := false;
    s_x00  := 0;
    s_y00  := 0;
    s_cor  := false;
    s_oem  := 0;
    s_shos := 0;
    s_shsl := 0;
    z_tune := 0;
    s_fbg  := 0;
    s_s    := 0;
    s_resc := false;
    s_rv1  := 0;
    s_rv2  := false;
    s_rv3  := 0;
    s_mAD[0]  := 0;
    s_mAD[1]  := 0;
    s_mAD[2]  := 0;
    s_mAD[3]  := 0;
    s_di3[0]  := 0;
    s_di3[1]  := 0;
    s_di3[2]  := 0;
    s_di3[3]  := 0;
    s_gn3[0]  := 0;
    s_gn3[1]  := 0;
    s_gn3[2]  := 0;
    s_gn3[3]  := 0;
    s_ms3[0]  := 0;
    s_ms3[1]  := 0;
    s_ms3[2]  := 0;
    s_ms3[3]  := 0;
    s_xov  := 0;
    s_tem  := 0;
    k_qsc  := 0;
    p_rv1  := 0;
    s_ex7  := 0;
    s_lps  := 0;
    s_lpr  := 0;
    s_lp0  := 0;
    s_fbo  := 0;
    k_fun  := 0;
    s_fbv  := 0;
    s_fbn  := 0;
    s_ipr  := 0;
    k_sdi  := 0;
    k_rmi  := 0;
    p_in1  := 0;
    p_in2  := 0;
    p_phi  := 0;
    k_hl   := 0;
    p_ou1  := 0;
    p_ou2  := 0;
    k_har  := 0;
    k_f0   := 0;
    k_f1   := 0;
    k_fr   := 0;
    k_gen  := 0;
    p_rv2  := 0;
    p_rv3  := 0;
    k_fas  := 0;
    k_mul  := 0;
    k_sd_10:= 0;
    p_vc_0 := 0;
    p_fb1  := 0;
    k_sd_x := 0;
    z_lift := 0;
    s_av3  := false;
    s_me3  := false;
    s_35x  := 0;
    s_ex5  := 0;
    s_dfm  := 0;
    s_fbs  := 0;
    s_fbs  := 0;
    s_las  := 0;
    s_ili  := 0;
    s_smp_in := 0;
    s_spl  := 0;
    z_all  := 0;
    z_rv1  := 0;
    s_lsrr := 0;
    s_lslr := 0;
    s_hsmp := 0;
    s_rev  := '';
    rv     := 0;
    as_spl0.bon   := 0;
    as_spl0.k00   := 0;
    as_spl0.k10   := 0;
    as_spl0.k01   := 0;
    as_spl0.k20   := 0;
    as_spl0.k02   := 0;
    as_spl0.k11   := 0;
    as_spl0.az00   := 0;
    as_spl0.azk0   := 0;
    as_rev := '';
    ZRelativeCoord := 0;
    with plane3DData do
    begin
      plane := 0;
      e1.x  := 0;
      e1.y  := 0;
      e1.z  := 0;
      e2.x  := 0;
      e2.y  := 0;
      e2.z  := 0;
      e3.x  := 0;
      e3.y  := 0;
      e3.z  := 0;
      normal.x := 0;
      normal.y := 0;
      normal.z := 0;
    end;
  end;

  with mode do
  begin
    m_mode := 0;
    m_nx := nx;
    m_ny := ny;
    m_nd := 0;
  end;

  with add_fd do
  begin
    NameSize := 0;
    CommentSize := 0;
    FrameSpecialSize := 0;
    ViewInfoSize := 0;
    SourceInfoSize := 0;
    FrameGUIDSize := sizeof(TGuid)*2;
    CreateGUID(FrameGUID);
    CreateGUID(MeasurementGUID);
  end;

  data := data_p;
end;

procedure MDTscanCreate.WriteToStream(stream:TStream);
begin
  with stream do
  begin
    Write(title,sizeof(f_title));
    Write(hdr,sizeof(hdr_r));
    Write(axsc,sizeof(xyz_ru0));
    Write(sc_vr,sizeof(scn_var));
    Write(mode,sizeof(mode_r));
    Write(data^,mode.m_nx*mode.m_ny*sizeof(Int16));
    Write(add_fd,sizeof(MDTaddFieldStrct));
  end;

end;

procedure MDTscanCreate.SaveToFile(const filename:string);
var  srteam : TFileStream;
begin
    srteam:= TFileStream.Create(filename,fmCreate);
    self.WriteToStream(srteam);
    srteam.free;
end;

end.
