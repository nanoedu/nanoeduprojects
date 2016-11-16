unit MDTFileExport;

interface

uses MDTStrct,BaseTypes,SysUtils,DateUtils,Classes;

type
  PData = ^smallint;

  MDTaddFieldStrct = packed record
    NameSize              : Integer;
    CommentSize           : Integer;
    FrameSpecialSize      : Integer;
    ViewInfoSize          : Integer;
    SourceInfoSize        : Integer;
    FrameGUIDSize         : Integer;
    FrameGUID             : TGUID;
    MeasurementGUID       : TGUID;
  end;

  PCurvesCoordHeader = ^TCurvesCoordHeader;
  TCurvesCoordHeader = packed record
    HeaderSize: Int32;
    CoordRecordSize: Int32;
    Version: Int32;
  end;

  PCurvesCoordHeader_201 = ^TCurvesCoordHeader_201;
  TCurvesCoordHeader_201 = packed record
    Header: TCurvesCoordHeader;
    CoordDOSUnits: Int16;
  end;

  NewCurve = packed record
    nx,ny : Single;
    nFor, nBack : Integer;
    forPtr , backPtr :Pointer;
  end;

  ScanFrame = packed record
    hdr   : hdr_r;
    axsc  : xyz_ru0;
    sc_vr : scn_var;
    mode  : mode_r;
    data  : Pointer;
    add_fd: MDTaddFieldStrct;
    Order : Integer;
    sName : string;
  end;

  CurvFrame = packed record
    hdr   : hdr_r;
    axsc  : xyz_ru0;
    CCH   : TCurvesCoordHeader_201;
    mode  : mode_r;
    NC    : Array of NewCurve;
    add_fd: MDTaddFieldStrct;
    Order : Integer;
    cName : string;
  end;


  MDFileExport = class (TObject)
private
  //LastGUID : TGUID;
  title : f_title;
  Nom   : Integer;
  SF : Array of ScanFrame;
  CF : Array of CurvFrame;
  procedure WriteScanF(str: TStream;frame : ScanFrame);
  procedure WriteCurveF(str: TStream;frame : CurvFrame);
public
  x0, xr, y0, yr, z0, zr : Single;
  xUnit, yUnit, zUnit : Smallint;
  Name : string;
  constructor Create; overload;

  constructor Create(nx,ny:integer; x0,y0,z0,xr,yr,zr:Single; xUnit,yUnit,zUnit : Smallint; data_p:pointer); overload;
  destructor  Destroy; override;
// compatibility

  procedure   AddScan (nx,ny:integer; data_p: PData);

  procedure   AddSpectroscopy ;
  procedure   AddSpectroPoint (xt,yt:Single; nForward : integer; nBackward : integer;  forwardBuf : PData;     backwardBuf : PData );

  //procedure AddCurve        ( nPoints : integer;   pointsBuf : PData );

// Frame properties
// output
  procedure WriteToStream(stream: TStream);
  procedure SaveToFile(const filename:string);

  function GetLastGUID : TGUID;

end;

implementation

const ZeroGUID: TGUID = '{00000000-0000-0000-0000-000000000000}';

procedure MDFileExport.WriteScanF(str: TStream;frame : ScanFrame);
begin
  with str,frame do
  begin
    Write(hdr,sizeof(hdr_r));
    Write(axsc,sizeof(xyz_ru0));
    Write(sc_vr,sizeof(scn_var));
    Write(mode,sizeof(mode_r));
    Write(data^,mode.m_nx*mode.m_ny*sizeof(Int16));
    if add_fd.NameSize=0 then Write(add_fd,sizeof(MDTaddFieldStrct))
    else
    begin
      Write(add_fd.NameSize,sizeof(add_fd.NameSize));
      Write(sName[1],add_fd.NameSize);
      Write(add_fd.CommentSize,sizeof(MDTaddFieldStrct)-sizeof(add_fd.NameSize));
    end;
  end;
end;

procedure MDFileExport.WriteCurveF(str: TStream;frame : CurvFrame);
var
  I : Integer;
  FreeSpace : Pointer;
begin
  FreeSpace := nil;
  ReallocMem(FreeSpace,CF[0].hdr.h_am - sizeof(xyz_ru0));
  with str,frame do
  begin
    Write(hdr,sizeof(hdr_r));
    Write(axsc,sizeof(xyz_ru0));
    Write(FreeSpace^,hdr.h_am - sizeof(xyz_ru0));
    Write(mode,sizeof(mode_r));
    Write(CCH,sizeof(TCurvesCoordHeader_201));
    for I := 0 to Length(NC) - 1 do
    begin
      with NC[I] do
      begin
        Write(nx,sizeof(Single));
        Write(ny,sizeof(Single));
        Write(nFor,sizeof(Int32));
        Write(nBack,sizeof(Int32));
      end;
    end;
    for I := 0 to Length(NC) - 1 do
    begin
      with NC[I] do
      begin
        Write(ForPtr^,nFor*sizeof(Int16));
        Write(BackPtr^,nBack*sizeof(Int16));
      end;
    end;
    if add_fd.NameSize=0 then Write(add_fd,sizeof(MDTaddFieldStrct))
    else
    begin
      Write(add_fd.NameSize,sizeof(add_fd.NameSize));
      Write(cName[1],add_fd.NameSize);
      Write(add_fd.CommentSize,sizeof(MDTaddFieldStrct)-sizeof(add_fd.NameSize));
    end;
  end;
  FreeMemory(FreeSpace);

end;

function MDFileExport.GetLastGUID : TGUID;
begin
  if Length(SF)>0 then Result := SF[Length(SF)-1].add_fd.MeasurementGUID
  else Result := ZeroGUID;
end;

constructor MDFileExport.Create;
begin

  with title do
  begin
    f_msk := $FF93B001;
    f_sz := 0;
    f_isz0 := 0;
    f_nt := 0;
    f_r0 := 0;
    f_str := '{c} 1998, NT-MDT';
  end;

  x0 := 0;
  xr := 0;
  y0 := 0;
  yr := 0;
  z0 := 0;
  zr := 0;
  xUnit := 0;
  yUnit := 0;
  zUnit := 0;
  Name := '';
  Nom := 0;
end;

constructor MDFileExport.Create(nx,ny:integer; x0,y0,z0,xr,yr,zr:Single;
                    xUnit,yUnit,zUnit : Smallint; data_p:pointer);
begin
  inherited Create;
  Self.x0 := x0;
  Self.xr := xr;
  Self.y0 := y0;
  Self.yr := yr;
  Self.z0 := z0;
  Self.zr := zr;
  Self.xUnit := xUnit;
  Self.yUnit := yUnit;
  Self.zUnit := zUnit;
  Name := '';
  Nom := 0;

  with title do
  begin
    f_msk := $FF93B001;
    f_sz := 0;
    f_isz0 := 0;
    f_nt := 0;
    f_r0 := 0;
    f_str := '{c} 1998, NT-MDT';
  end;

  AddScan(nx,ny,data_p);

end;

procedure MDFileExport.AddScan(nx,ny:integer; data_p: PData);
var
  DT : TDateTime;
begin
  SetLength(SF,Length(SF)+1);
  with SF[Length(SF)-1].hdr do
  begin
  DT := Now;
  DecodeDateTime(DT,h_yea,h_mon,h_day,h_h,h_m,h_s,h_am);
    h_sz := sizeof(hdr_r)+sizeof(xyz_ru0)+sizeof(scn_var)+sizeof(mode_r)+sizeof(Int16)*nx*ny+sizeof(MDTaddFieldStrct)+Length(Name);
    h_what := 0;
    h_ver  :=  $0307;
    h_am := 442;
  end;

  with SF[Length(SF)-1].axsc do
  begin
    x.r0 := x0;
    x.r  := xr;
    x.u  := xUnit;
    y.r0 := y0;
    y.r  := yr;
    y.u  := yUnit;
    z.r0 := z0;
    z.r  := zr;
    z.u  := zUnit;
  end;

  with SF[Length(SF)-1].sc_vr do
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

  with SF[Length(SF)-1].mode do
  begin
    m_mode := 0;
    m_nx := nx;
    m_ny := ny;
    m_nd := 0;
  end;

  SF[Length(SF)-1].sName := Name;

  with SF[Length(SF)-1].add_fd do
  begin
    NameSize := Length(Name);
    CommentSize := 0;
    FrameSpecialSize := 0;
    ViewInfoSize := 0;
    SourceInfoSize := 0;
    FrameGUIDSize := 32;
    CreateGUID(FrameGUID);
    CreateGUID(MeasurementGUID);
  end;

  GetMem(SF[Length(SF)-1].data , nx*ny*sizeof(Int16));
  Move (data_p^,SF[Length(SF)-1].data^, nx*ny*sizeof(Int16));
//  SF[Length(SF)-1].data := data_p;
  Inc(Nom);
  SF[Length(SF)-1].Order := Nom;

end;

procedure MDFileExport.AddSpectroscopy;
var
  DT : TDateTime;
begin
  SetLength(CF,Length(CF)+1);
  with CF[Length(CF)-1].hdr do
  begin
  DT := Now;
  DecodeDateTime(DT,h_yea,h_mon,h_day,h_h,h_m,h_s,h_am);
    h_sz := 0;                                                ///m
    h_what := 201;
    h_ver  :=  $0307;
    h_am := 182;
  end;

  with CF[Length(CF)-1].axsc do
  begin
    x.r0 := x0;
    x.r  := xr;
    x.u  := xUnit;
    y.r0 := 0;
    y.r  := 0;
    y.u  := 0;
    z.r0 := y0;
    z.r  := yr;
    z.u  := yUnit;
  end;

  with CF[Length(CF)-1].mode do
  begin
    m_mode := 0;
    m_nx := 2000;      ///m?
    m_ny := 0;         ///m
    m_nd := 0;         ///m
  end;

  with CF[Length(CF)-1].CCH do
  begin
    with Header do
    begin
      HeaderSize := 14;
      CoordRecordSize := 16;
      Version := 0;
    end;
    CoordDOSUnits := xUnit;
  end;

  CF[Length(CF)-1].cName := Name;

  with CF[Length(CF)-1].add_fd do
  begin
    NameSize := Length(Name);
    CommentSize := 0;
    FrameSpecialSize := 0;
    ViewInfoSize := 0;
    SourceInfoSize := 0;
    FrameGUIDSize := 32;
    CreateGUID(FrameGUID);
    MeasurementGUID := GetLastGUID;
  end;

  Inc(Nom);
  CF[Length(CF)-1].Order := Nom;
end;

procedure MDFileExport.AddSpectroPoint (xt,yt:Single; nForward, nBackward : integer;
                                  forwardBuf, backwardBuf : PData );
begin
  if Length(CF)>0 then
  begin
    with CF[Length(CF)-1] do
    begin
      SetLength(NC,Length(NC)+1);
      with NC[Length(NC)-1] do
      begin
        nx := xt;
        ny := yt;
        nFor := nForward;
        GetMem (forPtr,nForward*sizeof(int16));
        GetMem (backPtr,nBackward*sizeof(int16));
        Move (forwardBuf^,forPtr^,nForward*sizeof(int16));
        Move (backwardBuf^,backPtr^,nBackward*sizeof(int16));
//        forPtr := forwardBuf;
        nBack := nBackward;
//        backPtr := backwardBuf;
      end;
    end;
  end;
end;

procedure MDFileExport.WriteToStream(stream: TStream);
var
  I, J, Sum: Integer;
begin
  for I := 0 to Length(SF) - 1 do
    title.f_sz := title.f_sz + sizeof(hdr_r)+sizeof(xyz_ru0)+sizeof(scn_var)+
                  sizeof(mode_r)+sizeof(Int16)*SF[I].sc_vr.s_nx*SF[I].sc_vr.s_ny+
                  sizeof(MDTaddFieldStrct)+SF[I].add_fd.NameSize;
  for I := 0 to Length(CF) - 1 do
  begin
    Sum := sizeof(hdr_r)+ 182 + sizeof(mode_r)+
              sizeof(TCurvesCoordHeader_201)+sizeof(MDTaddFieldStrct)+CF[I].add_fd.NameSize;
    for J := 0 to Length(CF[I].NC) - 1 do
    begin
      Sum := Sum + 4*sizeof(Int32)+sizeof(Int16)*(CF[I].NC[I].nFor+CF[I].NC[I].nBack);
    end;

    with CF[I] do
    begin
      hdr.h_sz := Sum;
      mode.m_nx := NC[0].nFor+NC[0].nBack;
      mode.m_ny := Length(NC);
      mode.m_nd := Length(NC);
    end;
    title.f_sz := title.f_sz + Sum;
  end;
  title.f_nt := Nom - 1;

  stream.Write(title,sizeof(f_title));

  for I := 1 to Nom do
  begin
   for J:=0 to Length(SF)-1 do
     if I=SF[J].Order then WriteScanF(stream,SF[J]);
   for J := 0 to Length(CF) - 1 do
     if I=CF[J].Order then WriteCurveF(stream,CF[J]);
  end;
end;
destructor MDFileExport.Destroy;
var i,j:integer;
begin
 for i:= 0 to length(SF) - 1 do FreeMemory(SF[i].data);
  Finalize(SF);
 for i:= 0 to length(CF) - 1 do
 begin
  for j:=0  to length(CF[i].NC) - 1 do
  begin
   FreeMemory(CF[i].NC[j].forPtr);
   FreeMemory(CF[i].NC[j].backPtr);
   Finalize(CF[i].NC[j]);
  end;
 end;
  Finalize(CF);
 inherited Destroy;
end;
procedure MDFileExport.SaveToFile(const filename : string);
var
  fstr : TFileStream;
begin
  if FileExists(filename) then fstr:= TFileStream.Create(filename,fmOpenWrite)
  else fstr:= TFileStream.Create(filename,fmCreate);
  WriteToStream(fstr);
  fstr.Free;
end;




end.

