unit PortableDeviceTypesLib_TLB;

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

// PASTLWTR : 1.2
// File generated on 23.01.2010 19:09:46 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\WINDOWS\system32\portabledevicetypes.dll (1)
// LIBID: {2B00BA2F-E750-4BEB-9235-97142EDE1D3E}
// LCID: 0
// Helpfile: 
// HelpString: PortableDeviceTypes 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Hint: Symbol 'type' renamed to 'type_'
// ************************************************************************ //
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
  PortableDeviceTypesLibMajorVersion = 1;
  PortableDeviceTypesLibMinorVersion = 0;

  LIBID_PortableDeviceTypesLib: TGUID = '{2B00BA2F-E750-4BEB-9235-97142EDE1D3E}';

  IID_IWpdSerializer: TGUID = '{B32F4002-BB27-45FF-AF4F-06631C1E8DAD}';
  CLASS_WpdSerializer: TGUID = '{0B91A74B-AD7C-4A9D-B563-29EEF9167172}';
  IID_IPortableDeviceValues: TGUID = '{6848F6F2-3155-4F86-B6F5-263EEEAB3143}';
  IID_ISequentialStream: TGUID = '{0C733A30-2A1C-11CE-ADE5-00AA0044773D}';
  IID_IStream: TGUID = '{0000000C-0000-0000-C000-000000000046}';
  IID_IStorage: TGUID = '{0000000B-0000-0000-C000-000000000046}';
  IID_IEnumSTATSTG: TGUID = '{0000000D-0000-0000-C000-000000000046}';
  IID_IRecordInfo: TGUID = '{0000002F-0000-0000-C000-000000000046}';
  IID_ITypeInfo: TGUID = '{00020401-0000-0000-C000-000000000046}';
  IID_ITypeComp: TGUID = '{00020403-0000-0000-C000-000000000046}';
  IID_ITypeLib: TGUID = '{00020402-0000-0000-C000-000000000046}';
  IID_IPortableDevicePropVariantCollection: TGUID = '{89B2E422-4F1B-4316-BCEF-A44AFEA83EB3}';
  IID_IPortableDeviceKeyCollection: TGUID = '{DADA2357-E0AD-492E-98DB-DD61C53BA353}';
  IID_IPortableDeviceValuesCollection: TGUID = '{6E3F2D79-4E07-48C4-8208-D8C2E5AF4A99}';
  IID_IPropertyStore: TGUID = '{886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99}';
  CLASS_PortableDeviceValues: TGUID = '{0C15D503-D017-47CE-9016-7B3F978721CC}';
  CLASS_PortableDeviceKeyCollection: TGUID = '{DE2D022D-2480-43BE-97F0-D1FA2CF98F4F}';
  CLASS_PortableDevicePropVariantCollection: TGUID = '{08A99E2F-6D6D-4B80-AF5A-BAF2BCBE4CB9}';
  CLASS_PortableDeviceValuesCollection: TGUID = '{3882134D-14CF-4220-9CB4-435F86D83F60}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum tagTYPEKIND
type
  tagTYPEKIND = TOleEnum;
const
  TKIND_ENUM = $00000000;
  TKIND_RECORD = $00000001;
  TKIND_MODULE = $00000002;
  TKIND_INTERFACE = $00000003;
  TKIND_DISPATCH = $00000004;
  TKIND_COCLASS = $00000005;
  TKIND_ALIAS = $00000006;
  TKIND_UNION = $00000007;
  TKIND_MAX = $00000008;

// Constants for enum tagDESCKIND
type
  tagDESCKIND = TOleEnum;
const
  DESCKIND_NONE = $00000000;
  DESCKIND_FUNCDESC = $00000001;
  DESCKIND_VARDESC = $00000002;
  DESCKIND_TYPECOMP = $00000003;
  DESCKIND_IMPLICITAPPOBJ = $00000004;
  DESCKIND_MAX = $00000005;

// Constants for enum tagFUNCKIND
type
  tagFUNCKIND = TOleEnum;
const
  FUNC_VIRTUAL = $00000000;
  FUNC_PUREVIRTUAL = $00000001;
  FUNC_NONVIRTUAL = $00000002;
  FUNC_STATIC = $00000003;
  FUNC_DISPATCH = $00000004;

// Constants for enum tagINVOKEKIND
type
  tagINVOKEKIND = TOleEnum;
const
  INVOKE_FUNC = $00000001;
  INVOKE_PROPERTYGET = $00000002;
  INVOKE_PROPERTYPUT = $00000004;
  INVOKE_PROPERTYPUTREF = $00000008;

// Constants for enum tagCALLCONV
type
  tagCALLCONV = TOleEnum;
const
  CC_FASTCALL = $00000000;
  CC_CDECL = $00000001;
  CC_MSCPASCAL = $00000002;
  CC_PASCAL = $00000002;
  CC_MACPASCAL = $00000003;
  CC_STDCALL = $00000004;
  CC_FPFASTCALL = $00000005;
  CC_SYSCALL = $00000006;
  CC_MPWCDECL = $00000007;
  CC_MPWPASCAL = $00000008;
  CC_MAX = $00000009;

// Constants for enum tagVARKIND
type
  tagVARKIND = TOleEnum;
const
  VAR_PERINSTANCE = $00000000;
  VAR_STATIC = $00000001;
  VAR_CONST = $00000002;
  VAR_DISPATCH = $00000003;

// Constants for enum tagSYSKIND
type
  tagSYSKIND = TOleEnum;
const
  SYS_WIN16 = $00000000;
  SYS_WIN32 = $00000001;
  SYS_MAC = $00000002;
  SYS_WIN64 = $00000003;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IWpdSerializer = interface;
  IPortableDeviceValues = interface;
  ISequentialStream = interface;
  IStream = interface;
  IStorage = interface;
  IEnumSTATSTG = interface;
  IRecordInfo = interface;
  ITypeInfo = interface;
  ITypeComp = interface;
  ITypeLib = interface;
  IPortableDevicePropVariantCollection = interface;
  IPortableDeviceKeyCollection = interface;
  IPortableDeviceValuesCollection = interface;
  IPropertyStore = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  WpdSerializer = IWpdSerializer;
  PortableDeviceValues = IPortableDeviceValues;
  PortableDeviceKeyCollection = IPortableDeviceKeyCollection;
  PortableDevicePropVariantCollection = IPortableDevicePropVariantCollection;
  PortableDeviceValuesCollection = IPortableDeviceValuesCollection;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  wirePSAFEARRAY = ^PUserType5; 
  wireSNB = ^tagRemSNB; 
  PUserType6 = ^_FLAGGED_WORD_BLOB; {*}
  PUserType7 = ^_wireVARIANT; {*}
  PUserType14 = ^_wireBRECORD; {*}
  PUserType5 = ^_wireSAFEARRAY; {*}
  PPUserType1 = ^PUserType5; {*}
  PUserType11 = ^tagTYPEDESC; {*}
  PUserType12 = ^tagARRAYDESC; {*}
  PUserType2 = ^tag_inner_PROPVARIANT; {*}
  PByte1 = ^Byte; {*}
  PUINT1 = ^LongWord; {*}
  PUserType1 = ^_tagpropertykey; {*}
  PUserType3 = ^TGUID; {*}
  PUserType4 = ^_FILETIME; {*}
  POleVariant1 = ^OleVariant; {*}
  PUserType8 = ^tagTYPEATTR; {*}
  PUserType9 = ^tagFUNCDESC; {*}
  PUserType10 = ^tagVARDESC; {*}
  PUserType13 = ^tagTLIBATTR; {*}

  _tagpropertykey = packed record
    fmtid: TGUID;
    pid: LongWord;
  end;

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

  tagCLIPDATA = packed record
    cbSize: LongWord;
    ulClipFmt: Integer;
    pClipData: ^Byte;
  end;

  tagBSTRBLOB = packed record
    cbSize: LongWord;
    pData: ^Byte;
  end;

  tagBLOB = packed record
    cbSize: LongWord;
    pBlobData: ^Byte;
  end;

  tagVersionedStream = packed record
    guidVersion: TGUID;
    pStream: IStream;
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


  tagRemSNB = packed record
    ulCntStr: LongWord;
    ulCntChar: LongWord;
    rgString: ^Word;
  end;

  tagCAC = packed record
    cElems: LongWord;
    pElems: ^Shortint;
  end;

  tagCAUB = packed record
    cElems: LongWord;
    pElems: ^Byte;
  end;


  _wireSAFEARR_BSTR = packed record
    Size: LongWord;
    aBstr: ^PUserType6;
  end;

  _wireSAFEARR_UNKNOWN = packed record
    Size: LongWord;
    apUnknown: ^IUnknown;
  end;

  _wireSAFEARR_DISPATCH = packed record
    Size: LongWord;
    apDispatch: ^IDispatch;
  end;

  _FLAGGED_WORD_BLOB = packed record
    fFlags: LongWord;
    clSize: LongWord;
    asData: ^Word;
  end;


  _wireSAFEARR_VARIANT = packed record
    Size: LongWord;
    aVariant: ^PUserType7;
  end;


  _wireBRECORD = packed record
    fFlags: LongWord;
    clSize: LongWord;
    pRecInfo: IRecordInfo;
    pRecord: ^Byte;
  end;


  __MIDL_IOleAutomationTypes_0005 = record
    case Integer of
      0: (lptdesc: PUserType11);
      1: (lpadesc: PUserType12);
      2: (hreftype: LongWord);
  end;

  tagTYPEDESC = packed record
    __MIDL__IOleAutomationTypes0004: __MIDL_IOleAutomationTypes_0005;
    vt: Word;
  end;

  tagSAFEARRAYBOUND = packed record
    cElements: LongWord;
    lLbound: Integer;
  end;

  ULONG_PTR = LongWord; 

  tagIDLDESC = packed record
    dwReserved: ULONG_PTR;
    wIDLFlags: Word;
  end;

  DWORD = LongWord; 

  tagPARAMDESCEX = packed record
    cBytes: LongWord;
    varDefaultValue: OleVariant;
  end;

  tagPARAMDESC = packed record
    pparamdescex: ^tagPARAMDESCEX;
    wParamFlags: Word;
  end;

  tagELEMDESC = packed record
    tdesc: tagTYPEDESC;
    paramdesc: tagPARAMDESC;
  end;

  tagFUNCDESC = packed record
    memid: Integer;
    lprgscode: ^SCODE;
    lprgelemdescParam: ^tagELEMDESC;
    funckind: tagFUNCKIND;
    invkind: tagINVOKEKIND;
    callconv: tagCALLCONV;
    cParams: Smallint;
    cParamsOpt: Smallint;
    oVft: Smallint;
    cScodes: Smallint;
    elemdescFunc: tagELEMDESC;
    wFuncFlags: Word;
  end;

  __MIDL_IOleAutomationTypes_0006 = record
    case Integer of
      0: (oInst: LongWord);
      1: (lpvarValue: ^OleVariant);
  end;

  tagVARDESC = packed record
    memid: Integer;
    lpstrSchema: PWideChar;
    __MIDL__IOleAutomationTypes0005: __MIDL_IOleAutomationTypes_0006;
    elemdescVar: tagELEMDESC;
    wVarFlags: Word;
    varkind: tagVARKIND;
  end;

  tagTLIBATTR = packed record
    guid: TGUID;
    lcid: LongWord;
    syskind: tagSYSKIND;
    wMajorVerNum: Word;
    wMinorVerNum: Word;
    wLibFlags: Word;
  end;

  _wireSAFEARR_BRECORD = packed record
    Size: LongWord;
    aRecord: ^PUserType14;
  end;

  _wireSAFEARR_HAVEIID = packed record
    Size: LongWord;
    apUnknown: ^IUnknown;
    iid: TGUID;
  end;

  _BYTE_SIZEDARR = packed record
    clSize: LongWord;
    pData: ^Byte;
  end;

  _SHORT_SIZEDARR = packed record
    clSize: LongWord;
    pData: ^Word;
  end;

  _LONG_SIZEDARR = packed record
    clSize: LongWord;
    pData: ^LongWord;
  end;

  _HYPER_SIZEDARR = packed record
    clSize: LongWord;
    pData: ^Int64;
  end;

  tagCAI = packed record
    cElems: LongWord;
    pElems: ^Smallint;
  end;

  tagCAUI = packed record
    cElems: LongWord;
    pElems: ^Word;
  end;

  tagCAL = packed record
    cElems: LongWord;
    pElems: ^Integer;
  end;

  tagCAUL = packed record
    cElems: LongWord;
    pElems: ^LongWord;
  end;

  tagCAH = packed record
    cElems: LongWord;
    pElems: ^_LARGE_INTEGER;
  end;

  tagCAUH = packed record
    cElems: LongWord;
    pElems: ^_ULARGE_INTEGER;
  end;

  tagCAFLT = packed record
    cElems: LongWord;
    pElems: ^Single;
  end;

  tagCADBL = packed record
    cElems: LongWord;
    pElems: ^Double;
  end;

  tagCABOOL = packed record
    cElems: LongWord;
    pElems: ^WordBool;
  end;

  tagCASCODE = packed record
    cElems: LongWord;
    pElems: ^SCODE;
  end;

  tagCACY = packed record
    cElems: LongWord;
    pElems: ^Currency;
  end;

  tagCADATE = packed record
    cElems: LongWord;
    pElems: ^TDateTime;
  end;

  tagCAFILETIME = packed record
    cElems: LongWord;
    pElems: ^_FILETIME;
  end;

  tagCACLSID = packed record
    cElems: LongWord;
    pElems: ^TGUID;
  end;

  tagCACLIPDATA = packed record
    cElems: LongWord;
    pElems: ^tagCLIPDATA;
  end;

  tagCABSTR = packed record
    cElems: LongWord;
    pElems: ^WideString;
  end;

  tagCABSTRBLOB = packed record
    cElems: LongWord;
    pElems: ^tagBSTRBLOB;
  end;

  tagCALPSTR = packed record
    cElems: LongWord;
    pElems: ^PChar;
  end;

  tagCALPWSTR = packed record
    cElems: LongWord;
    pElems: ^PWideChar;
  end;


  tagCAPROPVARIANT = packed record
    cElems: LongWord;
    pElems: PUserType2;
  end;

  __MIDL___MIDL_itf_PortableDeviceTypes_0003_0015_0001 = record
    case Integer of
      0: (cVal: Shortint);
      1: (bVal: Byte);
      2: (iVal: Smallint);
      3: (uiVal: Word);
      4: (lVal: Integer);
      5: (ulVal: LongWord);
      6: (intVal: SYSINT);
      7: (uintVal: SYSUINT);
      8: (hVal: _LARGE_INTEGER);
      9: (uhVal: _ULARGE_INTEGER);
      10: (fltVal: Single);
      11: (dblVal: Double);
      12: (boolVal: WordBool);
      13: (bool: WordBool);
      14: (scode: SCODE);
      15: (cyVal: Currency);
      16: (date: TDateTime);
      17: (filetime: _FILETIME);
      18: (puuid: ^TGUID);
      19: (pClipData: ^tagCLIPDATA);
      20: (bstrVal: {!!WideString}Pointer);
      21: (bstrblobVal: tagBSTRBLOB);
      22: (blob: tagBLOB);
      23: (pszVal: PChar);
      24: (pwszVal: PWideChar);
      25: (punkVal: {!!IUnknown}Pointer);
      26: (pdispVal: {!!IDispatch}Pointer);
      27: (pStream: {!!IStream}Pointer);
      28: (pStorage: {!!IStorage}Pointer);
      29: (pVersionedStream: ^tagVersionedStream);
      30: (parray: wirePSAFEARRAY);
      31: (cac: tagCAC);
      32: (caub: tagCAUB);
      33: (cai: tagCAI);
      34: (caui: tagCAUI);
      35: (cal: tagCAL);
      36: (caul: tagCAUL);
      37: (cah: tagCAH);
      38: (cauh: tagCAUH);
      39: (caflt: tagCAFLT);
      40: (cadbl: tagCADBL);
      41: (cabool: tagCABOOL);
      42: (cascode: tagCASCODE);
      43: (cacy: tagCACY);
      44: (cadate: tagCADATE);
      45: (cafiletime: tagCAFILETIME);
      46: (cauuid: tagCACLSID);
      47: (caclipdata: tagCACLIPDATA);
      48: (cabstr: tagCABSTR);
      49: (cabstrblob: tagCABSTRBLOB);
      50: (calpstr: tagCALPSTR);
      51: (calpwstr: tagCALPWSTR);
      52: (capropvar: tagCAPROPVARIANT);
      53: (pcVal: ^Shortint);
      54: (pbVal: ^Byte);
      55: (piVal: ^Smallint);
      56: (puiVal: ^Word);
      57: (plVal: ^Integer);
      58: (pulVal: ^LongWord);
      59: (pintVal: ^SYSINT);
      60: (puintVal: ^SYSUINT);
      61: (pfltVal: ^Single);
      62: (pdblVal: ^Double);
      63: (pboolVal: ^WordBool);
      64: (pdecVal: ^TDecimal);
      65: (pscode: ^SCODE);
      66: (pcyVal: ^Currency);
      67: (pdate: ^TDateTime);
      68: (pbstrVal: ^WideString);
      69: (ppunkVal: {!!^IUnknown}Pointer);
      70: (ppdispVal: {!!^IDispatch}Pointer);
      71: (pparray: ^wirePSAFEARRAY);
      72: (pvarVal: PUserType2);
  end;


  tag_inner_PROPVARIANT = packed record
    vt: Word;
    wReserved1: Byte;
    wReserved2: Byte;
    wReserved3: LongWord;
    __MIDL____MIDL_itf_PortableDeviceTypes_0003_00150001: __MIDL___MIDL_itf_PortableDeviceTypes_0003_0015_0001;
  end;


  __MIDL_IOleAutomationTypes_0004 = record
    case Integer of
      0: (llVal: Int64);
      1: (lVal: Integer);
      2: (bVal: Byte);
      3: (iVal: Smallint);
      4: (fltVal: Single);
      5: (dblVal: Double);
      6: (boolVal: WordBool);
      7: (scode: SCODE);
      8: (cyVal: Currency);
      9: (date: TDateTime);
      10: (bstrVal: ^_FLAGGED_WORD_BLOB);
      11: (punkVal: {!!IUnknown}Pointer);
      12: (pdispVal: {!!IDispatch}Pointer);
      13: (parray: ^PUserType5);
      14: (brecVal: ^_wireBRECORD);
      15: (pbVal: ^Byte);
      16: (piVal: ^Smallint);
      17: (plVal: ^Integer);
      18: (pllVal: ^Int64);
      19: (pfltVal: ^Single);
      20: (pdblVal: ^Double);
      21: (pboolVal: ^WordBool);
      22: (pscode: ^SCODE);
      23: (pcyVal: ^Currency);
      24: (pdate: ^TDateTime);
      25: (pbstrVal: ^PUserType6);
      26: (ppunkVal: {!!^IUnknown}Pointer);
      27: (ppdispVal: {!!^IDispatch}Pointer);
      28: (pparray: ^PPUserType1);
      29: (pvarVal: ^PUserType7);
      30: (cVal: Shortint);
      31: (uiVal: Word);
      32: (ulVal: LongWord);
      33: (ullVal: Largeuint);
      34: (intVal: SYSINT);
      35: (uintVal: SYSUINT);
      36: (decVal: TDecimal);
      37: (pdecVal: ^TDecimal);
      38: (pcVal: ^Shortint);
      39: (puiVal: ^Word);
      40: (pulVal: ^LongWord);
      41: (pullVal: ^Largeuint);
      42: (pintVal: ^SYSINT);
      43: (puintVal: ^SYSUINT);
  end;

  __MIDL_IOleAutomationTypes_0001 = record
    case Integer of
      0: (BstrStr: _wireSAFEARR_BSTR);
      1: (UnknownStr: _wireSAFEARR_UNKNOWN);
      2: (DispatchStr: _wireSAFEARR_DISPATCH);
      3: (VariantStr: _wireSAFEARR_VARIANT);
      4: (RecordStr: _wireSAFEARR_BRECORD);
      5: (HaveIidStr: _wireSAFEARR_HAVEIID);
      6: (ByteStr: _BYTE_SIZEDARR);
      7: (WordStr: _SHORT_SIZEDARR);
      8: (LongStr: _LONG_SIZEDARR);
      9: (HyperStr: _HYPER_SIZEDARR);
  end;

  _wireSAFEARRAY_UNION = packed record
    sfType: LongWord;
    u: __MIDL_IOleAutomationTypes_0001;
  end;

  _wireVARIANT = packed record
    clSize: LongWord;
    rpcReserved: LongWord;
    vt: Word;
    wReserved1: Word;
    wReserved2: Word;
    wReserved3: Word;
    __MIDL__IOleAutomationTypes0002: __MIDL_IOleAutomationTypes_0004;
  end;


  tagTYPEATTR = packed record
    guid: TGUID;
    lcid: LongWord;
    dwReserved: LongWord;
    memidConstructor: Integer;
    memidDestructor: Integer;
    lpstrSchema: PWideChar;
    cbSizeInstance: LongWord;
    typekind: tagTYPEKIND;
    cFuncs: Word;
    cVars: Word;
    cImplTypes: Word;
    cbSizeVft: Word;
    cbAlignment: Word;
    wTypeFlags: Word;
    wMajorVerNum: Word;
    wMinorVerNum: Word;
    tdescAlias: tagTYPEDESC;
    idldescType: tagIDLDESC;
  end;

  tagARRAYDESC = packed record
    tdescElem: tagTYPEDESC;
    cDims: Word;
    rgbounds: ^tagSAFEARRAYBOUND;
  end;


  _wireSAFEARRAY = packed record
    cDims: Word;
    fFeatures: Word;
    cbElements: LongWord;
    cLocks: LongWord;
    uArrayStructs: _wireSAFEARRAY_UNION;
    rgsabound: ^tagSAFEARRAYBOUND;
  end;


// *********************************************************************//
// Interface: IWpdSerializer
// Flags:     (0)
// GUID:      {B32F4002-BB27-45FF-AF4F-06631C1E8DAD}
// *********************************************************************//
  IWpdSerializer = interface(IUnknown)
    ['{B32F4002-BB27-45FF-AF4F-06631C1E8DAD}']
    function GetIPortableDeviceValuesFromBuffer(var pBuffer: Byte; dwInputBufferLength: LongWord; 
                                                out ppParams: IPortableDeviceValues): HResult; stdcall;
    function WriteIPortableDeviceValuesToBuffer(dwOutputBufferLength: LongWord; 
                                                const pResults: IPortableDeviceValues; 
                                                out pBuffer: Byte; out pdwBytesWritten: LongWord): HResult; stdcall;
    function GetBufferFromIPortableDeviceValues(const pSource: IPortableDeviceValues; 
                                                out ppBuffer: PByte1; out pdwBufferSize: LongWord): HResult; stdcall;
    function GetSerializedSize(const pSource: IPortableDeviceValues; out pdwSize: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPortableDeviceValues
// Flags:     (0)
// GUID:      {6848F6F2-3155-4F86-B6F5-263EEEAB3143}
// *********************************************************************//
  IPortableDeviceValues = interface(IUnknown)
    ['{6848F6F2-3155-4F86-B6F5-263EEEAB3143}']
    function GetCount(var pcelt: LongWord): HResult; stdcall;
    function GetAt(index: LongWord; var pKey: _tagpropertykey; var pValue: tag_inner_PROPVARIANT): HResult; stdcall;
    function SetValue(var key: _tagpropertykey; var pValue: tag_inner_PROPVARIANT): HResult; stdcall;
    function GetValue(var key: _tagpropertykey; out pValue: tag_inner_PROPVARIANT): HResult; stdcall;
    function SetStringValue(var key: _tagpropertykey; Value: PWideChar): HResult; stdcall;
    function GetStringValue(var key: _tagpropertykey; out pValue: PWideChar): HResult; stdcall;
    function SetUnsignedIntegerValue(var key: _tagpropertykey; Value: LongWord): HResult; stdcall;
    function GetUnsignedIntegerValue(var key: _tagpropertykey; out pValue: LongWord): HResult; stdcall;
    function SetSignedIntegerValue(var key: _tagpropertykey; Value: Integer): HResult; stdcall;
    function GetSignedIntegerValue(var key: _tagpropertykey; out pValue: Integer): HResult; stdcall;
    function SetUnsignedLargeIntegerValue(var key: _tagpropertykey; Value: Largeuint): HResult; stdcall;
    function GetUnsignedLargeIntegerValue(var key: _tagpropertykey; out pValue: Largeuint): HResult; stdcall;
    function SetSignedLargeIntegerValue(var key: _tagpropertykey; Value: Int64): HResult; stdcall;
    function GetSignedLargeIntegerValue(var key: _tagpropertykey; out pValue: Int64): HResult; stdcall;
    function SetFloatValue(var key: _tagpropertykey; Value: Single): HResult; stdcall;
    function GetFloatValue(var key: _tagpropertykey; out pValue: Single): HResult; stdcall;
    function SetErrorValue(var key: _tagpropertykey; Value: HResult): HResult; stdcall;
    function GetErrorValue(var key: _tagpropertykey; out pValue: HResult): HResult; stdcall;
    function SetKeyValue(var key: _tagpropertykey; var Value: _tagpropertykey): HResult; stdcall;
    function GetKeyValue(var key: _tagpropertykey; out pValue: _tagpropertykey): HResult; stdcall;
    function SetBoolValue(var key: _tagpropertykey; Value: Integer): HResult; stdcall;
    function GetBoolValue(var key: _tagpropertykey; out pValue: Integer): HResult; stdcall;
    function SetIUnknownValue(var key: _tagpropertykey; const pValue: IUnknown): HResult; stdcall;
    function GetIUnknownValue(var key: _tagpropertykey; out ppValue: IUnknown): HResult; stdcall;
    function SetGuidValue(var key: _tagpropertykey; var Value: TGUID): HResult; stdcall;
    function GetGuidValue(var key: _tagpropertykey; out pValue: TGUID): HResult; stdcall;
    function SetBufferValue(var key: _tagpropertykey; var pValue: Byte; cbValue: LongWord): HResult; stdcall;
    function GetBufferValue(var key: _tagpropertykey; out ppValue: PByte1; out pcbValue: LongWord): HResult; stdcall;
    function SetIPortableDeviceValuesValue(var key: _tagpropertykey; 
                                           const pValue: IPortableDeviceValues): HResult; stdcall;
    function GetIPortableDeviceValuesValue(var key: _tagpropertykey; 
                                           out ppValue: IPortableDeviceValues): HResult; stdcall;
    function SetIPortableDevicePropVariantCollectionValue(var key: _tagpropertykey; 
                                                          const pValue: IPortableDevicePropVariantCollection): HResult; stdcall;
    function GetIPortableDevicePropVariantCollectionValue(var key: _tagpropertykey; 
                                                          out ppValue: IPortableDevicePropVariantCollection): HResult; stdcall;
    function SetIPortableDeviceKeyCollectionValue(var key: _tagpropertykey; 
                                                  const pValue: IPortableDeviceKeyCollection): HResult; stdcall;
    function GetIPortableDeviceKeyCollectionValue(var key: _tagpropertykey; 
                                                  out ppValue: IPortableDeviceKeyCollection): HResult; stdcall;
    function SetIPortableDeviceValuesCollectionValue(var key: _tagpropertykey; 
                                                     const pValue: IPortableDeviceValuesCollection): HResult; stdcall;
    function GetIPortableDeviceValuesCollectionValue(var key: _tagpropertykey; 
                                                     out ppValue: IPortableDeviceValuesCollection): HResult; stdcall;
    function RemoveValue(var key: _tagpropertykey): HResult; stdcall;
    function CopyValuesFromPropertyStore(const pStore: IPropertyStore): HResult; stdcall;
    function CopyValuesToPropertyStore(const pStore: IPropertyStore): HResult; stdcall;
    function Clear: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISequentialStream
// Flags:     (0)
// GUID:      {0C733A30-2A1C-11CE-ADE5-00AA0044773D}
// *********************************************************************//
  ISequentialStream = interface(IUnknown)
    ['{0C733A30-2A1C-11CE-ADE5-00AA0044773D}']
    //function RemoteRead(out pv: Byte; cb: LongWord; out pcbRead: LongWord): HResult; stdcall;
   // function RemoteWrite(var pv: Byte; cb: LongWord; out pcbWritten: LongWord): HResult; stdcall;
    function RemoteRead(out pv: PByte; cb: LongWord; out pcbRead: LongWord): HResult; stdcall;
    function RemoteWrite(var pv: PByte; cb: LongWord; out pcbWritten: LongWord): HResult; stdcall;
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
// Interface: IStorage
// Flags:     (0)
// GUID:      {0000000B-0000-0000-C000-000000000046}
// *********************************************************************//
  IStorage = interface(IUnknown)
    ['{0000000B-0000-0000-C000-000000000046}']
    function CreateStream(pwcsName: PWideChar; grfMode: LongWord; reserved1: LongWord; 
                          reserved2: LongWord; out ppstm: IStream): HResult; stdcall;
    function RemoteOpenStream(pwcsName: PWideChar; cbReserved1: LongWord; var reserved1: Byte; 
                              grfMode: LongWord; reserved2: LongWord; out ppstm: IStream): HResult; stdcall;
    function CreateStorage(pwcsName: PWideChar; grfMode: LongWord; reserved1: LongWord; 
                           reserved2: LongWord; out ppstg: IStorage): HResult; stdcall;
    function OpenStorage(pwcsName: PWideChar; const pstgPriority: IStorage; grfMode: LongWord; 
                         var snbExclude: tagRemSNB; reserved: LongWord; out ppstg: IStorage): HResult; stdcall;
    function RemoteCopyTo(ciidExclude: LongWord; var rgiidExclude: TGUID; 
                          var snbExclude: tagRemSNB; const pstgDest: IStorage): HResult; stdcall;
    function MoveElementTo(pwcsName: PWideChar; const pstgDest: IStorage; pwcsNewName: PWideChar; 
                           grfFlags: LongWord): HResult; stdcall;
    function Commit(grfCommitFlags: LongWord): HResult; stdcall;
    function Revert: HResult; stdcall;
    function RemoteEnumElements(reserved1: LongWord; cbReserved2: LongWord; var reserved2: Byte; 
                                reserved3: LongWord; out ppenum: IEnumSTATSTG): HResult; stdcall;
    function DestroyElement(pwcsName: PWideChar): HResult; stdcall;
    function RenameElement(pwcsOldName: PWideChar; pwcsNewName: PWideChar): HResult; stdcall;
    function SetElementTimes(pwcsName: PWideChar; var pctime: _FILETIME; var patime: _FILETIME; 
                             var pmtime: _FILETIME): HResult; stdcall;
    function SetClass(var clsid: TGUID): HResult; stdcall;
    function SetStateBits(grfStateBits: LongWord; grfMask: LongWord): HResult; stdcall;
    function Stat(out pstatstg: tagSTATSTG; grfStatFlag: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEnumSTATSTG
// Flags:     (0)
// GUID:      {0000000D-0000-0000-C000-000000000046}
// *********************************************************************//
  IEnumSTATSTG = interface(IUnknown)
    ['{0000000D-0000-0000-C000-000000000046}']
    function RemoteNext(celt: LongWord; out rgelt: tagSTATSTG; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumSTATSTG): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRecordInfo
// Flags:     (0)
// GUID:      {0000002F-0000-0000-C000-000000000046}
// *********************************************************************//
  IRecordInfo = interface(IUnknown)
    ['{0000002F-0000-0000-C000-000000000046}']
    function RecordInit(out pvNew: Pointer): HResult; stdcall;
    function RecordClear(var pvExisting: Pointer): HResult; stdcall;
    function RecordCopy(var pvExisting: Pointer; out pvNew: Pointer): HResult; stdcall;
    function GetGuid(out pguid: TGUID): HResult; stdcall;
    function GetName(out pbstrName: WideString): HResult; stdcall;
    function GetSize(out pcbSize: LongWord): HResult; stdcall;
    function GetTypeInfo(out ppTypeInfo: ITypeInfo): HResult; stdcall;
    function GetField(var pvData: Pointer; szFieldName: PWideChar; out pvarField: OleVariant): HResult; stdcall;
    function GetFieldNoCopy(var pvData: Pointer; szFieldName: PWideChar; out pvarField: OleVariant; 
                            out ppvDataCArray: Pointer): HResult; stdcall;
    function PutField(wFlags: LongWord; var pvData: Pointer; szFieldName: PWideChar; 
                      var pvarField: OleVariant): HResult; stdcall;
    function PutFieldNoCopy(wFlags: LongWord; var pvData: Pointer; szFieldName: PWideChar; 
                            var pvarField: OleVariant): HResult; stdcall;
    function GetFieldNames(var pcNames: LongWord; out rgBstrNames: WideString): HResult; stdcall;
    function IsMatchingType(const pRecordInfo: IRecordInfo): Integer; stdcall;
    function RecordCreate: Pointer; stdcall;
    function RecordCreateCopy(var pvSource: Pointer; out ppvDest: Pointer): HResult; stdcall;
    function RecordDestroy(var pvRecord: Pointer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITypeInfo
// Flags:     (0)
// GUID:      {00020401-0000-0000-C000-000000000046}
// *********************************************************************//
  ITypeInfo = interface(IUnknown)
    ['{00020401-0000-0000-C000-000000000046}']
    function RemoteGetTypeAttr(out ppTypeAttr: PUserType8; out pDummy: DWORD): HResult; stdcall;
    function GetTypeComp(out ppTComp: ITypeComp): HResult; stdcall;
    function RemoteGetFuncDesc(index: SYSUINT; out ppFuncDesc: PUserType9; out pDummy: DWORD): HResult; stdcall;
    function RemoteGetVarDesc(index: SYSUINT; out ppVarDesc: PUserType10; out pDummy: DWORD): HResult; stdcall;
    function RemoteGetNames(memid: Integer; out rgBstrNames: WideString; cMaxNames: SYSUINT; 
                            out pcNames: SYSUINT): HResult; stdcall;
    function GetRefTypeOfImplType(index: SYSUINT; out pRefType: LongWord): HResult; stdcall;
    function GetImplTypeFlags(index: SYSUINT; out pImplTypeFlags: SYSINT): HResult; stdcall;
    function LocalGetIDsOfNames: HResult; stdcall;
    function LocalInvoke: HResult; stdcall;
    function RemoteGetDocumentation(memid: Integer; refPtrFlags: LongWord; 
                                    out pbstrName: WideString; out pBstrDocString: WideString; 
                                    out pdwHelpContext: LongWord; out pBstrHelpFile: WideString): HResult; stdcall;
    function RemoteGetDllEntry(memid: Integer; invkind: tagINVOKEKIND; refPtrFlags: LongWord; 
                               out pBstrDllName: WideString; out pbstrName: WideString; 
                               out pwOrdinal: Word): HResult; stdcall;
    function GetRefTypeInfo(hreftype: LongWord; out ppTInfo: ITypeInfo): HResult; stdcall;
    function LocalAddressOfMember: HResult; stdcall;
    function RemoteCreateInstance(var riid: TGUID; out ppvObj: IUnknown): HResult; stdcall;
    function GetMops(memid: Integer; out pBstrMops: WideString): HResult; stdcall;
    function RemoteGetContainingTypeLib(out ppTLib: ITypeLib; out pIndex: SYSUINT): HResult; stdcall;
    function LocalReleaseTypeAttr: HResult; stdcall;
    function LocalReleaseFuncDesc: HResult; stdcall;
    function LocalReleaseVarDesc: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITypeComp
// Flags:     (0)
// GUID:      {00020403-0000-0000-C000-000000000046}
// *********************************************************************//
  ITypeComp = interface(IUnknown)
    ['{00020403-0000-0000-C000-000000000046}']
    function RemoteBind(szName: PWideChar; lHashVal: LongWord; wFlags: Word; 
                        out ppTInfo: ITypeInfo; out pDescKind: tagDESCKIND; 
                        out ppFuncDesc: PUserType9; out ppVarDesc: PUserType10; 
                        out ppTypeComp: ITypeComp; out pDummy: DWORD): HResult; stdcall;
    function RemoteBindType(szName: PWideChar; lHashVal: LongWord; out ppTInfo: ITypeInfo): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITypeLib
// Flags:     (0)
// GUID:      {00020402-0000-0000-C000-000000000046}
// *********************************************************************//
  ITypeLib = interface(IUnknown)
    ['{00020402-0000-0000-C000-000000000046}']
    function RemoteGetTypeInfoCount(out pcTInfo: SYSUINT): HResult; stdcall;
    function GetTypeInfo(index: SYSUINT; out ppTInfo: ITypeInfo): HResult; stdcall;
    function GetTypeInfoType(index: SYSUINT; out pTKind: tagTYPEKIND): HResult; stdcall;
    function GetTypeInfoOfGuid(var guid: TGUID; out ppTInfo: ITypeInfo): HResult; stdcall;
    function RemoteGetLibAttr(out ppTLibAttr: PUserType13; out pDummy: DWORD): HResult; stdcall;
    function GetTypeComp(out ppTComp: ITypeComp): HResult; stdcall;
    function RemoteGetDocumentation(index: SYSINT; refPtrFlags: LongWord; 
                                    out pbstrName: WideString; out pBstrDocString: WideString; 
                                    out pdwHelpContext: LongWord; out pBstrHelpFile: WideString): HResult; stdcall;
    function RemoteIsName(szNameBuf: PWideChar; lHashVal: LongWord; out pfName: Integer; 
                          out pBstrLibName: WideString): HResult; stdcall;
    function RemoteFindName(szNameBuf: PWideChar; lHashVal: LongWord; out ppTInfo: ITypeInfo; 
                            out rgMemId: Integer; var pcFound: Word; out pBstrLibName: WideString): HResult; stdcall;
    function LocalReleaseTLibAttr: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPortableDevicePropVariantCollection
// Flags:     (0)
// GUID:      {89B2E422-4F1B-4316-BCEF-A44AFEA83EB3}
// *********************************************************************//
  IPortableDevicePropVariantCollection = interface(IUnknown)
    ['{89B2E422-4F1B-4316-BCEF-A44AFEA83EB3}']
    function GetCount(var pcElems: LongWord): HResult; stdcall;
    function GetAt(dwIndex: LongWord; var pValue: tag_inner_PROPVARIANT): HResult; stdcall;
    function Add(var pValue: tag_inner_PROPVARIANT): HResult; stdcall;
    function GetType(out pvt: Word): HResult; stdcall;
    function ChangeType(vt: Word): HResult; stdcall;
    function Clear: HResult; stdcall;
    function RemoveAt(dwIndex: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPortableDeviceKeyCollection
// Flags:     (0)
// GUID:      {DADA2357-E0AD-492E-98DB-DD61C53BA353}
// *********************************************************************//
  IPortableDeviceKeyCollection = interface(IUnknown)
    ['{DADA2357-E0AD-492E-98DB-DD61C53BA353}']
    function GetCount(var pcElems: LongWord): HResult; stdcall;
    function GetAt(dwIndex: LongWord; var pKey: _tagpropertykey): HResult; stdcall;
    function Add(var key: _tagpropertykey): HResult; stdcall;
    function Clear: HResult; stdcall;
    function RemoveAt(dwIndex: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPortableDeviceValuesCollection
// Flags:     (0)
// GUID:      {6E3F2D79-4E07-48C4-8208-D8C2E5AF4A99}
// *********************************************************************//
  IPortableDeviceValuesCollection = interface(IUnknown)
    ['{6E3F2D79-4E07-48C4-8208-D8C2E5AF4A99}']
    function GetCount(var pcElems: LongWord): HResult; stdcall;
    function GetAt(dwIndex: LongWord; out ppValues: IPortableDeviceValues): HResult; stdcall;
    function Add(const pValues: IPortableDeviceValues): HResult; stdcall;
    function Clear: HResult; stdcall;
    function RemoveAt(dwIndex: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPropertyStore
// Flags:     (0)
// GUID:      {886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99}
// *********************************************************************//
  IPropertyStore = interface(IUnknown)
    ['{886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99}']
    function GetCount(out cProps: LongWord): HResult; stdcall;
    function GetAt(iProp: LongWord; out pKey: _tagpropertykey): HResult; stdcall;
    function GetValue(var key: _tagpropertykey; out pv: tag_inner_PROPVARIANT): HResult; stdcall;
    function SetValue(var key: _tagpropertykey; var propvar: tag_inner_PROPVARIANT): HResult; stdcall;
    function Commit: HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoWpdSerializer provides a Create and CreateRemote method to          
// create instances of the default interface IWpdSerializer exposed by              
// the CoClass WpdSerializer. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWpdSerializer = class
    class function Create: IWpdSerializer;
    class function CreateRemote(const MachineName: string): IWpdSerializer;
  end;

// *********************************************************************//
// The Class CoPortableDeviceValues provides a Create and CreateRemote method to          
// create instances of the default interface IPortableDeviceValues exposed by              
// the CoClass PortableDeviceValues. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPortableDeviceValues = class
    class function Create: IPortableDeviceValues;
    class function CreateRemote(const MachineName: string): IPortableDeviceValues;
  end;

// *********************************************************************//
// The Class CoPortableDeviceKeyCollection provides a Create and CreateRemote method to          
// create instances of the default interface IPortableDeviceKeyCollection exposed by              
// the CoClass PortableDeviceKeyCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPortableDeviceKeyCollection = class
    class function Create: IPortableDeviceKeyCollection;
    class function CreateRemote(const MachineName: string): IPortableDeviceKeyCollection;
  end;

// *********************************************************************//
// The Class CoPortableDevicePropVariantCollection provides a Create and CreateRemote method to          
// create instances of the default interface IPortableDevicePropVariantCollection exposed by              
// the CoClass PortableDevicePropVariantCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPortableDevicePropVariantCollection = class
    class function Create: IPortableDevicePropVariantCollection;
    class function CreateRemote(const MachineName: string): IPortableDevicePropVariantCollection;
  end;

// *********************************************************************//
// The Class CoPortableDeviceValuesCollection provides a Create and CreateRemote method to          
// create instances of the default interface IPortableDeviceValuesCollection exposed by              
// the CoClass PortableDeviceValuesCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPortableDeviceValuesCollection = class
    class function Create: IPortableDeviceValuesCollection;
    class function CreateRemote(const MachineName: string): IPortableDeviceValuesCollection;
  end;

implementation

uses ComObj;

class function CoWpdSerializer.Create: IWpdSerializer;
begin
  Result := CreateComObject(CLASS_WpdSerializer) as IWpdSerializer;
end;

class function CoWpdSerializer.CreateRemote(const MachineName: string): IWpdSerializer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WpdSerializer) as IWpdSerializer;
end;

class function CoPortableDeviceValues.Create: IPortableDeviceValues;
begin
  Result := CreateComObject(CLASS_PortableDeviceValues) as IPortableDeviceValues;
end;

class function CoPortableDeviceValues.CreateRemote(const MachineName: string): IPortableDeviceValues;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PortableDeviceValues) as IPortableDeviceValues;
end;

class function CoPortableDeviceKeyCollection.Create: IPortableDeviceKeyCollection;
begin
  Result := CreateComObject(CLASS_PortableDeviceKeyCollection) as IPortableDeviceKeyCollection;
end;

class function CoPortableDeviceKeyCollection.CreateRemote(const MachineName: string): IPortableDeviceKeyCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PortableDeviceKeyCollection) as IPortableDeviceKeyCollection;
end;

class function CoPortableDevicePropVariantCollection.Create: IPortableDevicePropVariantCollection;
begin
  Result := CreateComObject(CLASS_PortableDevicePropVariantCollection) as IPortableDevicePropVariantCollection;
end;

class function CoPortableDevicePropVariantCollection.CreateRemote(const MachineName: string): IPortableDevicePropVariantCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PortableDevicePropVariantCollection) as IPortableDevicePropVariantCollection;
end;

class function CoPortableDeviceValuesCollection.Create: IPortableDeviceValuesCollection;
begin
  Result := CreateComObject(CLASS_PortableDeviceValuesCollection) as IPortableDeviceValuesCollection;
end;

class function CoPortableDeviceValuesCollection.CreateRemote(const MachineName: string): IPortableDeviceValuesCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PortableDeviceValuesCollection) as IPortableDeviceValuesCollection;
end;

end.
