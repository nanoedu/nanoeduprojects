unit NL3LFBLib_TLB_Demo;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 8291 $
// File generated on 06.05.2011 12:55:17 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\nanoeducator\nanoedudig\exe\NL3LFB.dll (1)
// LIBID: {7A8BEDEB-C047-40ED-A180-A876684014DE}
// LCID: 0
// Helpfile: 
// HelpString: NL3LFB 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// Parent TypeLibrary:
//   (0) v1.0 MLPC_API2Lib, (D:\MTP\lmt\current\MLPC_API2.tlb)
// Errors:
//   Hint: Symbol 'type' renamed to 'type_'
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  NL3LFBLibMajorVersion = 1;
  NL3LFBLibMinorVersion = 0;

  LIBID_NL3LFBLib: TGUID = '{7A8BEDEB-C047-40ED-A180-A876684014DE}';

  IID_INamedCollection: TGUID = '{F6132E23-F230-45AF-991B-4E5C54AD0DE8}';
  CLASS_NamedCollection: TGUID = '{13C2ACB1-8D5D-4202-8A34-F359BECF32FD}';
  IID_ILFB: TGUID = '{3F251803-14C1-42FC-BB0A-E7BECC719E72}';
  CLASS_LFB_CELL_TMP: TGUID = '{E50D7C91-5F78-4246-B266-B1D95F8C41FF}';
  IID_IEnumUnknown: TGUID = '{00000100-0000-0000-C000-000000000046}';
  IID_ICollectionUnknown: TGUID = '{DDB0DB40-77A5-46BC-916C-53DC3A3EA13F}';
  IID_INamesDB: TGUID = '{63FDEE4E-FA5E-4CAE-A7A4-4BC82B9D4CEE}';
  IID_ISequentialStream: TGUID = '{0C733A30-2A1C-11CE-ADE5-00AA0044773D}';
  IID_IStream: TGUID = '{0000000C-0000-0000-C000-000000000046}';
  CLASS_LFB_CELL_INPUT: TGUID = '{2D8F5298-BD1C-4686-9C56-14E091CC3450}';
  CLASS_LFB_CELL_CONST: TGUID = '{F37430F9-C694-41F5-9197-F6271A66E2AD}';
  CLASS_LFB_CELL: TGUID = '{D7FC60C0-0AA0-40CF-9C47-1D549B2CA2B8}';
  CLASS_LFB_CORDIC: TGUID = '{6A1CC978-8A04-43BF-8ABA-DE181C09DA32}';
  CLASS_LFB_CELL_ENA: TGUID = '{AA58EC4C-56B9-444F-A6C0-3958A4341757}';
  CLASS_LFB_ADDSUB: TGUID = '{BEC3FD65-A762-44A0-B32B-38F569D26AB2}';
  CLASS_LFB_ADD: TGUID = '{13868731-B416-47F6-89CD-58841F54F772}';
  CLASS_LFB_SUB: TGUID = '{A02BEB4B-7E7A-4371-906E-BDF70654EC5C}';
  CLASS_LFB_NEG: TGUID = '{CF68FFA8-6502-4659-8515-ECA03CAF03DE}';
  CLASS_LFB_MULT: TGUID = '{D4BF9905-EBA3-472C-9157-D9F4B3C8E836}';
  CLASS_LFB_MULT_INT: TGUID = '{3BF7FC1E-BA35-47A9-B924-B767232EB6C6}';
  CLASS_LFB_MUX: TGUID = '{C4278E4F-9C06-488B-807D-71949B3360D8}';
  CLASS_LFB_CCTRL: TGUID = '{84CEB24E-CC36-4154-8E37-99397F72DF16}';
  CLASS_LFB_ABSMAX: TGUID = '{8AAA4E03-E823-4B5F-88E9-4EE3C193F32E}';
  CLASS_LFB_FIR: TGUID = '{7101A5E0-BE6F-47AE-9FDC-F48C689798AC}';
  CLASS_LFB_IIR: TGUID = '{54FCD8CB-914F-416A-BD8C-F96C440E7806}';
  CLASS_LFB_PID: TGUID = '{80FB6EF7-FFD7-482E-9DFF-21FEA259870A}';
  CLASS_LFB_CHECK: TGUID = '{A172373D-793F-4D92-BBCF-5A254D5DBE9A}';
  CLASS_LFB_VSCOPE: TGUID = '{99EFA692-66F2-42EB-A7F2-8B26B3FA1E50}';
  CLASS_LFB_XYZ: TGUID = '{49626A1C-2ADA-48D9-A3F3-B4A12F3569F6}';
  CLASS_LFB_TABLE: TGUID = '{2226662A-7739-4789-BAA1-400687006F85}';
  CLASS_NamesDB: TGUID = '{836D0DB3-21C6-4C85-8FCE-A37A52607B41}';
  CLASS_LFB_DXCHG: TGUID = '{80143A87-AB9A-42C7-864D-3B7AA10AB2E4}';
  CLASS_LFB_LRX: TGUID = '{1B12C15E-6002-4800-AB74-69F5FD09FB76}';
  CLASS_LFB_LTX: TGUID = '{F7790A35-1984-44F9-B97B-340B0558A528}';
  CLASS_LFB_CELL_ENA_TMP: TGUID = '{3C62FFD5-9625-4887-B5F2-BC43FC0E3B35}';
  CLASS_LFB_NTABLE: TGUID = '{39C3501A-D50B-4930-A9CA-4E0B5E29C86E}';
  IID_INamedParameter: TGUID = '{1BD80387-867B-4AE8-B1DA-BFE199081569}';
  CLASS_NamedParameter: TGUID = '{29794808-FDA7-4AD0-97B5-417F2B7442B5}';
  CLASS_CollectionUnknown: TGUID = '{9B2018BC-CD30-4196-B993-727E62AA5E65}';
  IID_ILFB_CELL: TGUID = '{4C6B03BA-274C-4FF7-B9AA-E1F21F38FE8B}';
  IID_ILFB_PID: TGUID = '{55FD7268-F830-4957-AAF6-94677B8AFCF8}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  INamedCollection = interface;
  ILFB = interface;
  ILFBDisp = dispinterface;
  IEnumUnknown = interface;
  ICollectionUnknown = interface;
  INamesDB = interface;
  ISequentialStream = interface;
  IStream = interface;
  INamedParameter = interface;
  ILFB_CELL = interface;
  ILFB_CELLDisp = dispinterface;
  ILFB_PID = interface;
  ILFB_PIDDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  NamedCollection = INamedCollection;
  LFB_CELL_TMP = ILFB;
  LFB_CELL_INPUT = ILFB;
  LFB_CELL_CONST = ILFB;
  LFB_CELL = ILFB;
  LFB_CORDIC = ILFB;
  LFB_CELL_ENA = ILFB;
  LFB_ADDSUB = ILFB;
  LFB_ADD = ILFB;
  LFB_SUB = ILFB;
  LFB_NEG = ILFB;
  LFB_MULT = ILFB;
  LFB_MULT_INT = ILFB;
  LFB_MUX = ILFB;
  LFB_CCTRL = ILFB;
  LFB_ABSMAX = ILFB;
  LFB_FIR = ILFB;
  LFB_IIR = ILFB;
  LFB_PID = ILFB;
  LFB_CHECK = ILFB;
  LFB_VSCOPE = ILFB;
  LFB_XYZ = ILFB;
  LFB_TABLE = ILFB;
  NamesDB = INamesDB;
  LFB_DXCHG = ILFB;
  LFB_LRX = ILFB;
  LFB_LTX = ILFB;
  LFB_CELL_ENA_TMP = ILFB;
  LFB_NTABLE = ILFB;
  NamedParameter = INamedParameter;
  CollectionUnknown = ICollectionUnknown;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PByte1 = ^Byte; {*}

  _LARGE_INTEGER = packed record
    QuadPart: Int64;
  end;

  _ULARGE_INTEGER = packed record
    QuadPart: Largeuint;
  end;

  _FILETIME = packed record
    dwLowDateTime: LongWord;
    dwHighDateTime: LongWord;
  end;

  tagSTATSTG = packed record
    pwcsName: PWideChar;
    type_: LongWord;
    cbSize: _ULARGE_INTEGER;
    mtime: _FILETIME;
    ctime: _FILETIME;
    atime: _FILETIME;
    grfMode: LongWord;
    grfLocksSupported: LongWord;
    clsid: TGUID;
    grfStateBits: LongWord;
    reserved: LongWord;
  end;


// *********************************************************************//
// Interface: INamedCollection
// Flags:     (0)
// GUID:      {F6132E23-F230-45AF-991B-4E5C54AD0DE8}
// *********************************************************************//
  INamedCollection = interface(IUnknown)
    ['{F6132E23-F230-45AF-991B-4E5C54AD0DE8}']
    function Put(const Name: WideString; Value: OleVariant): HResult; stdcall;
    function Get(const Name: WideString; out pVal: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ILFB
// Flags:     (448) Dual NonExtensible OleAutomation
// GUID:      {3F251803-14C1-42FC-BB0A-E7BECC719E72}
// *********************************************************************//
  ILFB = interface(IUnknown)
    ['{3F251803-14C1-42FC-BB0A-E7BECC719E72}']
    procedure Create(const Parameters: IEnumUnknown; const DPU: IEnumUnknown); safecall;
    procedure Delete; safecall;
    procedure get_Parameters(const pCol: ICollectionUnknown); safecall;
    procedure Initialize; safecall;
    procedure EnumFE(out ppenum: IEnumUnknown); safecall;
    procedure get_Name(out pVal: WideString); safecall;
    procedure put_Name(const Value: WideString); safecall;
    procedure get_Nets(out pNets: Integer; out pCount: Integer); safecall;
    procedure get_ParentLFB(out ppUnk: IUnknown); safecall;
    procedure put_ParentLFB(const pUnk: IUnknown); safecall;
    procedure put_NamesDB(const Names: INamesDB); safecall;
    procedure get_Type(out pType: Integer); safecall;
    procedure PrepareDynamicConfiguration; safecall;
    procedure MakeDynamicConfiguration(const pstm: IStream); safecall;
  end;

// *********************************************************************//
// DispIntf:  ILFBDisp
// Flags:     (448) Dual NonExtensible OleAutomation
// GUID:      {3F251803-14C1-42FC-BB0A-E7BECC719E72}
// *********************************************************************//
  ILFBDisp = dispinterface
    ['{3F251803-14C1-42FC-BB0A-E7BECC719E72}']
    procedure Create(const Parameters: IEnumUnknown; const DPU: IEnumUnknown); dispid 1610678272;
    procedure Delete; dispid 1610678273;
    procedure get_Parameters(const pCol: ICollectionUnknown); dispid 1610678274;
    procedure Initialize; dispid 1610678275;
    procedure EnumFE(out ppenum: IEnumUnknown); dispid 1610678276;
    procedure get_Name(out pVal: WideString); dispid 1610678277;
    procedure put_Name(const Value: WideString); dispid 1610678278;
    procedure get_Nets(out pNets: Integer; out pCount: Integer); dispid 1610678279;
    procedure get_ParentLFB(out ppUnk: IUnknown); dispid 1610678280;
    procedure put_ParentLFB(const pUnk: IUnknown); dispid 1610678281;
    procedure put_NamesDB(const Names: INamesDB); dispid 1610678282;
    procedure get_Type(out pType: Integer); dispid 1610678283;
    procedure PrepareDynamicConfiguration; dispid 1610678284;
    procedure MakeDynamicConfiguration(const pstm: IStream); dispid 1610678285;
  end;

// *********************************************************************//
// Interface: IEnumUnknown
// Flags:     (0)
// GUID:      {00000100-0000-0000-C000-000000000046}
// *********************************************************************//
  IEnumUnknown = interface(IUnknown)
    ['{00000100-0000-0000-C000-000000000046}']
    function RemoteNext(celt: LongWord; out rgelt: IUnknown; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICollectionUnknown
// Flags:     (0)
// GUID:      {DDB0DB40-77A5-46BC-916C-53DC3A3EA13F}
// *********************************************************************//
  ICollectionUnknown = interface(IUnknown)
    ['{DDB0DB40-77A5-46BC-916C-53DC3A3EA13F}']
    function Add(const pUnk: IUnknown): HResult; stdcall;
    function get_Count(out pVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: INamesDB
// Flags:     (0)
// GUID:      {63FDEE4E-FA5E-4CAE-A7A4-4BC82B9D4CEE}
// *********************************************************************//
  INamesDB = interface(IUnknown)
    ['{63FDEE4E-FA5E-4CAE-A7A4-4BC82B9D4CEE}']
    function AddName(const Name: WideString; CaseSensitive: WordBool; out pIndex: Integer): HResult; stdcall;
    function EnumNames(out pNames: IEnumVARIANT): HResult; stdcall;
    function get_Count(out pCount: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISequentialStream
// Flags:     (0)
// GUID:      {0C733A30-2A1C-11CE-ADE5-00AA0044773D}
// *********************************************************************//
  ISequentialStream = interface(IUnknown)
    ['{0C733A30-2A1C-11CE-ADE5-00AA0044773D}']
    function RemoteRead(out pv: Byte; cb: LongWord; out pcbRead: LongWord): HResult; stdcall;
    function RemoteWrite(var pv: Byte; cb: LongWord; out pcbWritten: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStream
// Flags:     (0)
// GUID:      {0000000C-0000-0000-C000-000000000046}
// *********************************************************************//
  IStream = interface(ISequentialStream)
    ['{0000000C-0000-0000-C000-000000000046}']
    function RemoteSeek(dlibMove: _LARGE_INTEGER; dwOrigin: LongWord; 
                        out plibNewPosition: _ULARGE_INTEGER): HResult; stdcall;
    function SetSize(libNewSize: _ULARGE_INTEGER): HResult; stdcall;
    function RemoteCopyTo(const pstm: IStream; cb: _ULARGE_INTEGER; out pcbRead: _ULARGE_INTEGER; 
                          out pcbWritten: _ULARGE_INTEGER): HResult; stdcall;
    function Commit(grfCommitFlags: LongWord): HResult; stdcall;
    function Revert: HResult; stdcall;
    function LockRegion(libOffset: _ULARGE_INTEGER; cb: _ULARGE_INTEGER; dwLockType: LongWord): HResult; stdcall;
    function UnlockRegion(libOffset: _ULARGE_INTEGER; cb: _ULARGE_INTEGER; dwLockType: LongWord): HResult; stdcall;
    function Stat(out pstatstg: tagSTATSTG; grfStatFlag: LongWord): HResult; stdcall;
    function Clone(out ppstm: IStream): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: INamedParameter
// Flags:     (0)
// GUID:      {1BD80387-867B-4AE8-B1DA-BFE199081569}
// *********************************************************************//
  INamedParameter = interface(IUnknown)
    ['{1BD80387-867B-4AE8-B1DA-BFE199081569}']
    function get_Name(out pName: WideString): HResult; stdcall;
    function put_Name(const Name: WideString): HResult; stdcall;
    function get_Value(out pVal: OleVariant): HResult; stdcall;
    function put_Value(Value: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ILFB_CELL
// Flags:     (320) Dual OleAutomation
// GUID:      {4C6B03BA-274C-4FF7-B9AA-E1F21F38FE8B}
// *********************************************************************//
  ILFB_CELL = interface(IUnknown)
    ['{4C6B03BA-274C-4FF7-B9AA-E1F21F38FE8B}']
    procedure Read(out pVal: OleVariant); safecall;
    procedure Write(Value: OleVariant); safecall;
    procedure ReadEx(out pVal: OleVariant; out pAttr: Integer); safecall;
    procedure WriteEx(Value: OleVariant; Attr: Integer); safecall;
  end;

// *********************************************************************//
// DispIntf:  ILFB_CELLDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {4C6B03BA-274C-4FF7-B9AA-E1F21F38FE8B}
// *********************************************************************//
  ILFB_CELLDisp = dispinterface
    ['{4C6B03BA-274C-4FF7-B9AA-E1F21F38FE8B}']
    procedure Read(out pVal: OleVariant); dispid 1610678272;
    procedure Write(Value: OleVariant); dispid 1610678273;
    procedure ReadEx(out pVal: OleVariant; out pAttr: Integer); dispid 1610678274;
    procedure WriteEx(Value: OleVariant; Attr: Integer); dispid 1610678275;
  end;

// *********************************************************************//
// Interface: ILFB_PID
// Flags:     (320) Dual OleAutomation
// GUID:      {55FD7268-F830-4957-AAF6-94677B8AFCF8}
// *********************************************************************//
  ILFB_PID = interface(IUnknown)
    ['{55FD7268-F830-4957-AAF6-94677B8AFCF8}']
    procedure Write(dt: Integer; Te: Double; Td: Double; Ti: Double); safecall;
  end;

// *********************************************************************//
// DispIntf:  ILFB_PIDDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {55FD7268-F830-4957-AAF6-94677B8AFCF8}
// *********************************************************************//
  ILFB_PIDDisp = dispinterface
    ['{55FD7268-F830-4957-AAF6-94677B8AFCF8}']
    procedure Write(dt: Integer; Te: Double; Td: Double; Ti: Double); dispid 1610678272;
  end;

// *********************************************************************//
// The Class CoNamedCollection provides a Create and CreateRemote method to          
// create instances of the default interface INamedCollection exposed by              
// the CoClass NamedCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNamedCollection = class
    class function Create: INamedCollection;
    class function CreateRemote(const MachineName: string): INamedCollection;
  end;

// *********************************************************************//
// The Class CoLFB_CELL_TMP provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_CELL_TMP. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_CELL_TMP = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_CELL_INPUT provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_CELL_INPUT. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_CELL_INPUT = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_CELL_CONST provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_CELL_CONST. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_CELL_CONST = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_CELL provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_CELL. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_CELL = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_CORDIC provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_CORDIC. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_CORDIC = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_CELL_ENA provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_CELL_ENA. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_CELL_ENA = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_ADDSUB provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_ADDSUB. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_ADDSUB = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_ADD provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_ADD. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_ADD = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_SUB provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_SUB. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_SUB = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_NEG provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_NEG. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_NEG = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_MULT provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_MULT. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_MULT = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_MULT_INT provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_MULT_INT. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_MULT_INT = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_MUX provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_MUX. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_MUX = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_CCTRL provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_CCTRL. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_CCTRL = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_ABSMAX provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_ABSMAX. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_ABSMAX = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_FIR provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_FIR. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_FIR = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_IIR provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_IIR. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_IIR = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_PID provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_PID. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_PID = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_CHECK provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_CHECK. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_CHECK = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_VSCOPE provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_VSCOPE. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_VSCOPE = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_XYZ provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_XYZ. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_XYZ = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_TABLE provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_TABLE. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_TABLE = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoNamesDB provides a Create and CreateRemote method to          
// create instances of the default interface INamesDB exposed by              
// the CoClass NamesDB. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNamesDB = class
    class function Create: INamesDB;
    class function CreateRemote(const MachineName: string): INamesDB;
  end;

// *********************************************************************//
// The Class CoLFB_DXCHG provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_DXCHG. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_DXCHG = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_LRX provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_LRX. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_LRX = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_LTX provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_LTX. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_LTX = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_CELL_ENA_TMP provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_CELL_ENA_TMP. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_CELL_ENA_TMP = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoLFB_NTABLE provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass LFB_NTABLE. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLFB_NTABLE = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;

// *********************************************************************//
// The Class CoNamedParameter provides a Create and CreateRemote method to          
// create instances of the default interface INamedParameter exposed by              
// the CoClass NamedParameter. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNamedParameter = class
    class function Create: INamedParameter;
    class function CreateRemote(const MachineName: string): INamedParameter;
  end;

// *********************************************************************//
// The Class CoCollectionUnknown provides a Create and CreateRemote method to          
// create instances of the default interface ICollectionUnknown exposed by              
// the CoClass CollectionUnknown. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCollectionUnknown = class
    class function Create: ICollectionUnknown;
    class function CreateRemote(const MachineName: string): ICollectionUnknown;
  end;

implementation

uses ComObj;

class function CoNamedCollection.Create: INamedCollection;
begin
  Result := CreateComObject(CLASS_NamedCollection) as INamedCollection;
end;

class function CoNamedCollection.CreateRemote(const MachineName: string): INamedCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NamedCollection) as INamedCollection;
end;

class function CoLFB_CELL_TMP.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_CELL_TMP) as ILFB;
end;

class function CoLFB_CELL_TMP.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_CELL_TMP) as ILFB;
end;

class function CoLFB_CELL_INPUT.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_CELL_INPUT) as ILFB;
end;

class function CoLFB_CELL_INPUT.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_CELL_INPUT) as ILFB;
end;

class function CoLFB_CELL_CONST.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_CELL_CONST) as ILFB;
end;

class function CoLFB_CELL_CONST.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_CELL_CONST) as ILFB;
end;

class function CoLFB_CELL.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_CELL) as ILFB;
end;

class function CoLFB_CELL.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_CELL) as ILFB;
end;

class function CoLFB_CORDIC.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_CORDIC) as ILFB;
end;

class function CoLFB_CORDIC.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_CORDIC) as ILFB;
end;

class function CoLFB_CELL_ENA.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_CELL_ENA) as ILFB;
end;

class function CoLFB_CELL_ENA.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_CELL_ENA) as ILFB;
end;

class function CoLFB_ADDSUB.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_ADDSUB) as ILFB;
end;

class function CoLFB_ADDSUB.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_ADDSUB) as ILFB;
end;

class function CoLFB_ADD.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_ADD) as ILFB;
end;

class function CoLFB_ADD.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_ADD) as ILFB;
end;

class function CoLFB_SUB.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_SUB) as ILFB;
end;

class function CoLFB_SUB.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_SUB) as ILFB;
end;

class function CoLFB_NEG.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_NEG) as ILFB;
end;

class function CoLFB_NEG.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_NEG) as ILFB;
end;

class function CoLFB_MULT.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_MULT) as ILFB;
end;

class function CoLFB_MULT.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_MULT) as ILFB;
end;

class function CoLFB_MULT_INT.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_MULT_INT) as ILFB;
end;

class function CoLFB_MULT_INT.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_MULT_INT) as ILFB;
end;

class function CoLFB_MUX.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_MUX) as ILFB;
end;

class function CoLFB_MUX.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_MUX) as ILFB;
end;

class function CoLFB_CCTRL.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_CCTRL) as ILFB;
end;

class function CoLFB_CCTRL.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_CCTRL) as ILFB;
end;

class function CoLFB_ABSMAX.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_ABSMAX) as ILFB;
end;

class function CoLFB_ABSMAX.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_ABSMAX) as ILFB;
end;

class function CoLFB_FIR.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_FIR) as ILFB;
end;

class function CoLFB_FIR.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_FIR) as ILFB;
end;

class function CoLFB_IIR.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_IIR) as ILFB;
end;

class function CoLFB_IIR.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_IIR) as ILFB;
end;

class function CoLFB_PID.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_PID) as ILFB;
end;

class function CoLFB_PID.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_PID) as ILFB;
end;

class function CoLFB_CHECK.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_CHECK) as ILFB;
end;

class function CoLFB_CHECK.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_CHECK) as ILFB;
end;

class function CoLFB_VSCOPE.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_VSCOPE) as ILFB;
end;

class function CoLFB_VSCOPE.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_VSCOPE) as ILFB;
end;

class function CoLFB_XYZ.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_XYZ) as ILFB;
end;

class function CoLFB_XYZ.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_XYZ) as ILFB;
end;

class function CoLFB_TABLE.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_TABLE) as ILFB;
end;

class function CoLFB_TABLE.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_TABLE) as ILFB;
end;

class function CoNamesDB.Create: INamesDB;
begin
  Result := CreateComObject(CLASS_NamesDB) as INamesDB;
end;

class function CoNamesDB.CreateRemote(const MachineName: string): INamesDB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NamesDB) as INamesDB;
end;

class function CoLFB_DXCHG.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_DXCHG) as ILFB;
end;

class function CoLFB_DXCHG.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_DXCHG) as ILFB;
end;

class function CoLFB_LRX.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_LRX) as ILFB;
end;

class function CoLFB_LRX.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_LRX) as ILFB;
end;

class function CoLFB_LTX.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_LTX) as ILFB;
end;

class function CoLFB_LTX.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_LTX) as ILFB;
end;

class function CoLFB_CELL_ENA_TMP.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_CELL_ENA_TMP) as ILFB;
end;

class function CoLFB_CELL_ENA_TMP.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_CELL_ENA_TMP) as ILFB;
end;

class function CoLFB_NTABLE.Create: ILFB;
begin
  Result := CreateComObject(CLASS_LFB_NTABLE) as ILFB;
end;

class function CoLFB_NTABLE.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LFB_NTABLE) as ILFB;
end;

class function CoNamedParameter.Create: INamedParameter;
begin
  Result := CreateComObject(CLASS_NamedParameter) as INamedParameter;
end;

class function CoNamedParameter.CreateRemote(const MachineName: string): INamedParameter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NamedParameter) as INamedParameter;
end;

class function CoCollectionUnknown.Create: ICollectionUnknown;
begin
  Result := CreateComObject(CLASS_CollectionUnknown) as ICollectionUnknown;
end;

class function CoCollectionUnknown.CreateRemote(const MachineName: string): ICollectionUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CollectionUnknown) as ICollectionUnknown;
end;

end.
