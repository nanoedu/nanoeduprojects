unit MtpLib_TLB;

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
// File generated on 07.09.2009 11:20:07 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\MTP\tlb\mtp.tlb (1)
// LIBID: {C400000E-0DA6-4275-B110-0C924467CF1C}
// LCID: 0
// Helpfile: 
// HelpString: MTP 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Error creating palette bitmap of (TWindowsMtp) : Server C:\WINDOWS\system32\wpdmtp.dll contains no icons
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

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants,Dialogs;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  MtpLibMajorVersion = 1;
  MtpLibMinorVersion = 0;

  LIBID_MtpLib: TGUID = '{C400000E-0DA6-4275-B110-0C924467CF1C}';

  IID_IMtp: TGUID = '{E555A570-9F2D-4CDC-9AAE-DFC68F0122F5}';
  IID_IMtpHackInfo: TGUID = '{E21A9E98-D909-4E27-B46A-B86CA5193131}';
  IID_IMtpEventCallback: TGUID = '{6A6597FA-8583-4AEA-BA0A-2A503584CE25}';
  IID_IMtpEvent: TGUID = '{48F5F5DB-CEFA-42DA-91E2-419AA7FAA510}';
  IID_IMtpDeviceInfo: TGUID = '{CB7E044F-874D-433C-87D7-E888D77D4A74}';
  IID_IMtpStorageInfo: TGUID = '{C6A38F8C-5184-4F76-AF09-32D635208CC6}';
  IID_IMtpObjectInfo: TGUID = '{8AC54A8C-2CDD-4197-8957-08B30F565FBE}';
  IID_IMtpDevicePropDesc: TGUID = '{BCAA3A2A-E895-48BD-B046-625D494E2FBA}';
  IID_IMtpObjectPropDesc: TGUID = '{809AB06C-B17C-44B4-872B-FA6F6FAB2D70}'; //GetObjectPropDesc
  IID_IEnumMtpPropConfig: TGUID = '{E16CA25D-F30F-42AA-B7EB-E9E994DD7479}'; //
  IID_IMtpPropConfig: TGUID = '{FB35E977-1D70-4821-95F5-EAF5359E5315}';   //
  IID_IEnumObjectPropDesc: TGUID = '{F51CC4CA-9E43-4BE4-B4A5-141F7CDB87DF}';  //IMtpPropConfig
  IID_IMtpResponse: TGUID = '{4E883058-3964-413F-9E90-5577C128071F}'; //EndTransferEx;  ExecuteCommand
  IID_IMtpCommand: TGUID = '{9C0D73E4-DD65-4EC8-9E27-CCC3ED7CA564}';  //NewCommand
  CLASS_WindowsMtp: TGUID = '{F1AAAA76-BD01-42E1-A6C0-34FA86ACBB90}';
//  ClassGUID={EEC5AD98-8080-425f-922A-DABF3DE3F69A}

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0004


type
  __MIDL___MIDL_itf_mtp_0000_0000_0004 = TOleEnum;
const
  MTP_EVENTCODE_UNDEFINED = $00004000;
  MTP_EVENTCODE_CANCELTRANSACTION = $00004001;
  MTP_EVENTCODE_OBJECTADDED = $00004002;
  MTP_EVENTCODE_OBJECTREMOVED = $00004003;
  MTP_EVENTCODE_STOREADDED = $00004004;
  MTP_EVENTCODE_STOREREMOVED = $00004005;
  MTP_EVENTCODE_DEVICEPROPCHANGED = $00004006;
  MTP_EVENTCODE_OBJECTINFOCHANGED = $00004007;
  MTP_EVENTCODE_DEVICEINFOCHANGED = $00004008;
  MTP_EVENTCODE_REQUESTOBJECTTRANSFER = $00004009;
  MTP_EVENTCODE_STOREFULL = $0000400A;
  MTP_EVENTCODE_DEVICERESET = $0000400B;
  MTP_EVENTCODE_STORAGEINFOCHANGED = $0000400C;
  MTP_EVENTCODE_CAPTURECOMPLETE = $0000400D;
  MTP_EVENTCODE_UNREPORTEDSTATUS = $0000400E;
  MTP_EVENTCODE_RESERVED_FIRST = $0000400F;
  MTP_EVENTCODE_RESERVED_LAST = $00004FFF;
  MTP_EVENTCODE_VENDOREXTENSION_FIRST = $0000C000;
  MTP_EVENTCODE_VENDOREXTENSION_LAST = $0000CFFF;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0016
type
  __MIDL___MIDL_itf_mtp_0000_0000_0016 = TOleEnum;
const
  MTP_FUNCTIONALMODE_STANDARD = $00000000;
  MTP_FUNCTIONALMODE_SLEEP = $00000001;
  MTP_FUNCTIONALMODE_RESERVED_FIRST = $00000002;
  MTP_FUNCTIONALMODE_RESERVED_LAST = $00007FFF;
  MTP_FUNCTIONALMODE_VENDOREXTENSION_FIRST = $00008000;
  MTP_FUNCTIONALMODE_VENDOREXTENSION_LAST = $0000FFFF;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0002
type
  __MIDL___MIDL_itf_mtp_0000_0000_0002 = TOleEnum;
const
  MTP_OPCODE_UNDEFINED = $00001000;
  MTP_OPCODE_GETDEVICEINFO = $00001001;
  MTP_OPCODE_OPENSESSION = $00001002;
  MTP_OPCODE_CLOSESESSION = $00001003;
  MTP_OPCODE_GETSTORAGEIDS = $00001004;
  MTP_OPCODE_GETSTORAGEINFO = $00001005;
  MTP_OPCODE_GETNUMOBJECTS = $00001006;
  MTP_OPCODE_GETOBJECTHANDLES = $00001007;
  MTP_OPCODE_GETOBJECTINFO = $00001008;
  MTP_OPCODE_GETOBJECT = $00001009;
  MTP_OPCODE_GETTHUMB = $0000100A;
  MTP_OPCODE_DELETEOBJECT = $0000100B;
  MTP_OPCODE_SENDOBJECTINFO = $0000100C;
  MTP_OPCODE_SENDOBJECT = $0000100D;
  MTP_OPCODE_INITIATECAPTURE = $0000100E;
  MTP_OPCODE_FORMATSTORE = $0000100F;
  MTP_OPCODE_RESETDEVICE = $00001010;
  MTP_OPCODE_SELFTEST = $00001011;
  MTP_OPCODE_SETOBJECTPROTECTION = $00001012;
  MTP_OPCODE_POWERDOWN = $00001013;
  MTP_OPCODE_GETDEVICEPROPDESC = $00001014;
  MTP_OPCODE_GETDEVICEPROPVALUE = $00001015;
  MTP_OPCODE_SETDEVICEPROPVALUE = $00001016;
  MTP_OPCODE_RESETDEVICEPROPVALUE = $00001017;
  MTP_OPCODE_TERMINATECAPTURE = $00001018;
  MTP_OPCODE_MOVEOBJECT = $00001019;
  MTP_OPCODE_COPYOBJECT = $0000101A;
  MTP_OPCODE_GETPARTIALOBJECT = $0000101B;
  MTP_OPCODE_INITIATEOPENCAPTURE = $0000101C;
  MTP_OPCODE_GETOBJECTPROPSSUPPORTED = $00009801;
  MTP_OPCODE_GETOBJECTPROPDESC = $00009802;
  MTP_OPCODE_GETOBJECTPROPVALUE = $00009803;
  MTP_OPCODE_SETOBJECTPROPVALUE = $00009804;
  MTP_OPCODE_GETOBJECTPROPLIST = $00009805;
  MTP_OPCODE_SETOBJECTPROPLIST = $00009806;
  MTP_OPCODE_GETINTERDEPENDENTPROPDESC = $00009807;
  MTP_OPCODE_SENDOBJECTPROPLIST = $00009808;
  MTP_OPCODE_GETOBJECTREFERENCES = $00009810;
  MTP_OPCODE_SETOBJECTREFERENCES = $00009811;
  MTP_OPCODE_UPDATEDEVICEFIRMWARE = $00009812;
  MTP_OPCODE_RESETOBJECTPROPVALUE = $00009813;
  MTP_OPCODE_RESERVED_FIRST = $00001026;
  MTP_OPCODE_RESERVED_LAST = $00001FFF;
  MTP_OPCODE_VENDOREXTENSION_FIRST = $00009000;
  MTP_OPCODE_VENDOREXTENSION_LAST = $00009FFF;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0005
type
  __MIDL___MIDL_itf_mtp_0000_0000_0005 = TOleEnum;
const
  MTP_DEVICEPROPCODE_NOTUSED = $00000000;
  MTP_DEVICEPROPCODE_ALL = $FFFFFFFF;
  MTP_DEVICEPROPCODE_UNDEFINED = $00005000;
  MTP_DEVICEPROPCODE_BATTERYLEVEL = $00005001;
  MTP_DEVICEPROPCODE_FUNCTIONMODE = $00005002;
  MTP_DEVICEPROPCODE_IMAGESIZE = $00005003;
  MTP_DEVICEPROPCODE_COMPRESSIONSETTING = $00005004;
  MTP_DEVICEPROPCODE_WHITEBALANCE = $00005005;
  MTP_DEVICEPROPCODE_RGBGAIN = $00005006;
  MTP_DEVICEPROPCODE_FNUMBER = $00005007;
  MTP_DEVICEPROPCODE_FOCALLENGTH = $00005008;
  MTP_DEVICEPROPCODE_FOCUSDISTANCE = $00005009;
  MTP_DEVICEPROPCODE_FOCUSMODE = $0000500A;
  MTP_DEVICEPROPCODE_EXPOSUREMETERINGMODE = $0000500B;
  MTP_DEVICEPROPCODE_FLASHMODE = $0000500C;
  MTP_DEVICEPROPCODE_EXPOSURETIME = $0000500D;
  MTP_DEVICEPROPCODE_EXPOSUREPROGRAMMODE = $0000500E;
  MTP_DEVICEPROPCODE_EXPOSUREINDEX = $0000500F;
  MTP_DEVICEPROPCODE_EXPOSURECOMPENSATION = $00005010;
  MTP_DEVICEPROPCODE_DATETIME = $00005011;
  MTP_DEVICEPROPCODE_CAPTUREDELAY = $00005012;
  MTP_DEVICEPROPCODE_STILLCAPTUREMODE = $00005013;
  MTP_DEVICEPROPCODE_CONTRAST = $00005014;
  MTP_DEVICEPROPCODE_SHARPNESS = $00005015;
  MTP_DEVICEPROPCODE_DIGITALZOOM = $00005016;
  MTP_DEVICEPROPCODE_EFFECTMODE = $00005017;
  MTP_DEVICEPROPCODE_BURSTNUMBER = $00005018;
  MTP_DEVICEPROPCODE_BURSTINTERVAL = $00005019;
  MTP_DEVICEPROPCODE_TIMELAPSENUMBER = $0000501A;
  MTP_DEVICEPROPCODE_TIMELAPSEINTERVAL = $0000501B;
  MTP_DEVICEPROPCODE_FOCUSMETERINGMODE = $0000501C;
  MTP_DEVICEPROPCODE_UPLOADURL = $0000501D;
  MTP_DEVICEPROPCODE_ARTIST = $0000501E;
  MTP_DEVICEPROPCODE_COPYRIGHTINFO = $0000501F;
  MTP_DEVICEPROPCODE_SYNCHRONIZATIONPARTNER = $0000D401;
  MTP_DEVICEPROPCODE_DEVICEFRIENDLYNAME = $0000D402;
  MTP_DEVICEPROPCODE_RESERVED_FIRST = $00005020;
  MTP_DEVICEPROPCODE_RESERVED_LAST = $00005FFF;
  MTP_DEVICEPROPCODE_VENDOREXTENSION_FIRST = $0000D000;
  MTP_DEVICEPROPCODE_VENDOREXTENSION_LAST = $0000DFFF;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0007
type
  __MIDL___MIDL_itf_mtp_0000_0000_0007 = TOleEnum;
const
  MTP_FORMATCODE_NOTUSED = $00000000;
  MTP_FORMATCODE_ALLIMAGES = $FFFFFFFF;
  MTP_FORMATCODE_UNDEFINED = $00003000;
  MTP_FORMATCODE_ASSOCIATION = $00003001;
  MTP_FORMATCODE_SCRIPT = $00003002;
  MTP_FORMATCODE_EXECUTABLE = $00003003;
  MTP_FORMATCODE_TEXT = $00003004;
  MTP_FORMATCODE_HTML = $00003005;
  MTP_FORMATCODE_DPOF = $00003006;
  MTP_FORMATCODE_AIFF = $00003007;
  MTP_FORMATCODE_WAVE = $00003008;
  MTP_FORMATCODE_MP3 = $00003009;
  MTP_FORMATCODE_AVI = $0000300A;
  MTP_FORMATCODE_MPEG = $0000300B;
  MTP_FORMATCODE_ASF = $0000300C;
  MTP_FORMATCODE_RESERVED_FIRST = $0000300D;
  MTP_FORMATCODE_RESERVED_LAST = $000037FF;
  MTP_FORMATCODE_IMAGE_UNDEFINED = $00003800;
  MTP_FORMATCODE_IMAGE_EXIF = $00003801;
  MTP_FORMATCODE_IMAGE_TIFFEP = $00003802;
  MTP_FORMATCODE_IMAGE_FLASHPIX = $00003803;
  MTP_FORMATCODE_IMAGE_BMP = $00003804;
  MTP_FORMATCODE_IMAGE_CIFF = $00003805;
  MTP_FORMATCODE_IMAGE_GIF = $00003807;
  MTP_FORMATCODE_IMAGE_JFIF = $00003808;
  MTP_FORMATCODE_IMAGE_PCD = $00003809;
  MTP_FORMATCODE_IMAGE_PICT = $0000380A;
  MTP_FORMATCODE_IMAGE_PNG = $0000380B;
  MTP_FORMATCODE_IMAGE_TIFF = $0000380D;
  MTP_FORMATCODE_IMAGE_TIFFIT = $0000380E;
  MTP_FORMATCODE_IMAGE_JP2 = $0000380F;
  MTP_FORMATCODE_IMAGE_JPX = $00003810;
  MTP_FORMATCODE_IMAGE_RESERVED_FIRST = $00003811;
  MTP_FORMATCODE_IMAGE_RESERVED_LAST = $00003FFF;
  MTP_FORMATCODE_UNDEFINEDFIRMWARE = $0000B802;
  MTP_FORMATCODE_WINDOWSIMAGEFORMAT = $0000B881;
  MTP_FORMATCODE_UNDEFINEDAUDIO = $0000B900;
  MTP_FORMATCODE_WMA = $0000B901;
  MTP_FORMATCODE_UNDEFINEDVIDEO = $0000B980;
  MTP_FORMATCODE_WMV = $0000B981;
  MTP_FORMATCODE_UNDEFINEDCOLLECTION = $0000BA00;
  MTP_FORMATCODE_ABSTRACTMULTIMEDIAALBUM = $0000BA01;
  MTP_FORMATCODE_ABSTRACTIMAGEALBUM = $0000BA02;
  MTP_FORMATCODE_ABSTRACTAUDIOALBUM = $0000BA03;
  MTP_FORMATCODE_ABSTRACTVIDEOALBUM = $0000BA04;
  MTP_FORMATCODE_ABSTRACTAUDIOVIDEOPLAYLIST = $0000BA05;
  MTP_FORMATCODE_ABSTRACTCONTACTGROUP = $0000BA06;
  MTP_FORMATCODE_ABSTRACTMESSAGEFOLDER = $0000BA07;
  MTP_FORMATCODE_ABSTRACTCHAPTEREDPRODUCTION = $0000BA08;
  MTP_FORMATCODE_WPLPLAYLIST = $0000BA10;
  MTP_FORMATCODE_M3UPLAYLIST = $0000BA11;
  MTP_FORMATCODE_MPLPLAYLIST = $0000BA12;
  MTP_FORMATCODE_ASXPLAYLIST = $0000BA13;
  MTP_FORMATCODE_PLSPLAYLIST = $0000BA14;
  MTP_FORMATCODE_UNDEFINEDDOCUMENT = $0000BA80;
  MTP_FORMATCODE_ABSTRACTDOCUMENT = $0000BA81;
  MTP_FORMATCODE_UNDEFINEDMESSAGE = $0000BB00;
  MTP_FORMATCODE_ABSTRACTMESSAGE = $0000BB01;
  MTP_FORMATCODE_UNDEFINEDCONTACT = $0000BB80;
  MTP_FORMATCODE_ABSTRACTCONTACT = $0000BB81;
  MTP_FORMATCODE_VCARD2 = $0000BB82;
  MTP_FORMATCODE_VCARD3 = $0000BB83;
  MTP_FORMATCODE_UNDEFINEDCALENDARITEM = $0000BE00;
  MTP_FORMATCODE_ABSTRACTCALENDARITEM = $0000BE01;
  MTP_FORMATCODE_VCALENDAR1 = $0000BE02;
  MTP_FORMATCODE_UNDEFINEDWINDOWSEXECUTABLE = $0000BE80;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0003
type
  __MIDL___MIDL_itf_mtp_0000_0000_0003 = TOleEnum;
const
  MTP_RESPONSECODE_UNDEFINED = $00002000;
  MTP_RESPONSECODE_OK = $00002001;
  MTP_RESPONSECODE_GENERALERROR = $00002002;
  MTP_RESPONSECODE_SESSIONNOTOPEN = $00002003;
  MTP_RESPONSECODE_INVALIDTRANSACTIONID = $00002004;
  MTP_RESPONSECODE_OPERATIONNOTSUPPORTED = $00002005;
  MTP_RESPONSECODE_PARAMETERNOTSUPPORTED = $00002006;
  MTP_RESPONSECODE_INCOMPLETETRANSFER = $00002007;
  MTP_RESPONSECODE_INVALIDSTORAGEID = $00002008;
  MTP_RESPONSECODE_INVALIDOBJECTHANDLE = $00002009;
  MTP_RESPONSECODE_INVALIDPROPERTYCODE = $0000200A;
  MTP_RESPONSECODE_INVALIDOBJECTFORMATCODE = $0000200B;
  MTP_RESPONSECODE_STOREFULL = $0000200C;
  MTP_RESPONSECODE_OBJECTWRITEPROTECTED = $0000200D;
  MTP_RESPONSECODE_STOREWRITEPROTECTED = $0000200E;
  MTP_RESPONSECODE_ACCESSDENIED = $0000200F;
  MTP_RESPONSECODE_NOTHUMBNAILPRESENT = $00002010;
  MTP_RESPONSECODE_SELFTESTFAILED = $00002011;
  MTP_RESPONSECODE_PARTIALDELETION = $00002012;
  MTP_RESPONSECODE_STORENOTAVAILABLE = $00002013;
  MTP_RESPONSECODE_NOSPECIFICATIONBYFORMAT = $00002014;
  MTP_RESPONSECODE_NOVALIDOBJECTINFO = $00002015;
  MTP_RESPONSECODE_INVALIDCODEFORMAT = $00002016;
  MTP_RESPONSECODE_UNKNOWNVENDORCODE = $00002017;
  MTP_RESPONSECODE_CAPTUREALREADYTERMINATED = $00002018;
  MTP_RESPONSECODE_DEVICEBUSY = $00002019;
  MTP_RESPONSECODE_INVALIDPARENT = $0000201A;
  MTP_RESPONSECODE_INVALIDPROPFORMAT = $0000201B;
  MTP_RESPONSECODE_INVALIDPROPVALUE = $0000201C;
  MTP_RESPONSECODE_INVALIDPARAMETER = $0000201D;
  MTP_RESPONSECODE_SESSIONALREADYOPENED = $0000201E;
  MTP_RESPONSECODE_TRANSACTIONCANCELLED = $0000201F;
  MTP_RESPONSECODE_DESTINATIONUNSUPPORTED = $00002020;
  MTP_RESPONSECODE_RESERVED_FIRST = $00002021;
  MTP_RESPONSECODE_RESERVED_LAST = $00002FFF;
  MTP_RESPONSECODE_VENDOREXTENSION_FIRST = $0000A000;
  MTP_RESPONSECODE_VENDOREXTENSION_LAST = $0000A7FF;
  MTP_RESPONSECODE_INVALIDOBJECTPROPCODE = $0000A801;
  MTP_RESPONSECODE_INVALIDOBJECTPROPFORMAT = $0000A802;
  MTP_RESPONSECODE_INVALIDOBJECTPROPVALUE = $0000A803;
  MTP_RESPONSECODE_INVALIDOBJECTREFERENCE = $0000A804;
  MTP_RESPONSECODE_INVALIDDATASET = $0000A806;
  MTP_RESPONSECODE_OBJECTTOOLARGE = $0000A807;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0011
type
  __MIDL___MIDL_itf_mtp_0000_0000_0011 = TOleEnum;
const
  MTP_STORAGETYPE_UNDEFINED = $00000000;
  MTP_STORAGETYPE_FIXEDROM = $00000001;
  MTP_STORAGETYPE_REMOVABLEROM = $00000002;
  MTP_STORAGETYPE_FIXEDRAM = $00000003;
  MTP_STORAGETYPE_REMOVABLERAM = $00000004;
  MTP_STORAGETYPE_RESERVED_FIRST = $00000005;
  MTP_STORAGETYPE_RESERVED_LAST = $0000FFFF;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0012
type
  __MIDL___MIDL_itf_mtp_0000_0000_0012 = TOleEnum;
const
  MTP_FILESYSTEMTYPE_UNDEFINED = $00000000;
  MTP_FILESYSTEMTYPE_FLAT = $00000001;
  MTP_FILESYSTEMTYPE_HIERARCHICAL = $00000002;
  MTP_FILESYSTEMTYPE_DCF = $00000003;
  MTP_FILESYSTEMTYPE_RESERVED_FIRST = $00000004;
  MTP_FILESYSTEMTYPE_RESERVED_LAST = $00007FFF;
  MTP_FILESYSTEMTYPE_VENDOREXTENSION_FIRST = $00008000;
  MTP_FILESYSTEMTYPE_VENDOREXTENSION_LAST = $0000FFFF;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0013
type
  __MIDL___MIDL_itf_mtp_0000_0000_0013 = TOleEnum;
const
  MTP_STORAGEACCESSCAPABILITY_RWD = $00000000;
  MTP_STORAGEACCESSCAPABILITY_R = $00000001;
  MTP_STORAGEACCESSCAPABILITY_RD = $00000002;
  MTP_STORAGEACCESSCAPABILITY_RESERVED_FIRST = $00000003;
  MTP_STORAGEACCESSCAPABILITY_RESERVED_LAST = $0000FFFF;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0014
type
  __MIDL___MIDL_itf_mtp_0000_0000_0014 = TOleEnum;
const
  MTP_PROTECTIONSTATUS_NONE = $00000000;
  MTP_PROTECTIONSTATUS_READONLY = $00000001;
  MTP_PROTECTIONSTATUS_READONLYDATA = $00000002;
  MTP_PROTECTIONSTATUS_RESERVED_FIRST = $00000003;
  MTP_PROTECTIONSTATUS_RESERVED_LAST = $0000FFFF;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0015
type
  __MIDL___MIDL_itf_mtp_0000_0000_0015 = TOleEnum;
const
  MTP_ASSOCIATIONTYPE_UNDEFINED = $00000000;
  MTP_ASSOCIATIONTYPE_GENERICFOLDER = $00000001;
  MTP_ASSOCIATIONTYPE_ALBUM = $00000002;
  MTP_ASSOCIATIONTYPE_TIMESEQUENCE = $00000003;
  MTP_ASSOCIATIONTYPE_HPANORAMIC = $00000004;
  MTP_ASSOCIATIONTYPE_VPANORAMIC = $00000005;
  MTP_ASSOCIATIONTYPE_2DPANORAMIC = $00000006;
  MTP_ASSOCIATIONTYPE_ANCILLARYDATA = $00000007;
  MTP_ASSOCIATIONTYPE_RESERVED_FIRST = $00000008;
  MTP_ASSOCIATIONTYPE_RESERVED_LAST = $00007FFF;
  MTP_ASSOCIATIONTYPE_VENDOREXTENSION_FIRST = $00008000;
  MTP_ASSOCIATIONTYPE_VENDOREXTENSION_LAST = $0000FFFF;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0001
type
  __MIDL___MIDL_itf_mtp_0000_0000_0001 = TOleEnum;
const
  MTP_DATATYPE_UNDEFINED = $00000000;
  MTP_DATATYPE_INT8 = $00000001;
  MTP_DATATYPE_UINT8 = $00000002;
  MTP_DATATYPE_INT16 = $00000003;
  MTP_DATATYPE_UINT16 = $00000004;
  MTP_DATATYPE_INT32 = $00000005;
  MTP_DATATYPE_UINT32 = $00000006;
  MTP_DATATYPE_INT64 = $00000007;
  MTP_DATATYPE_UINT64 = $00000008;
  MTP_DATATYPE_INT128 = $00000009;
  MTP_DATATYPE_UINT128 = $0000000A;
  MTP_DATATYPE_AINT8 = $00004001;
  MTP_DATATYPE_AUINT8 = $00004002;
  MTP_DATATYPE_AINT16 = $00004003;
  MTP_DATATYPE_AUINT16 = $00004004;
  MTP_DATATYPE_AINT32 = $00004005;
  MTP_DATATYPE_AUINT32 = $00004006;
  MTP_DATATYPE_AINT64 = $00004007;
  MTP_DATATYPE_AUINT64 = $00004008;
  MTP_DATATYPE_AINT128 = $00004009;
  MTP_DATATYPE_AUINT128 = $0000400A;
  MTP_DATATYPE_STRING = $0000FFFF;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0010
type
  __MIDL___MIDL_itf_mtp_0000_0000_0010 = TOleEnum;
const
  MTP_PROPGETSET_GETONLY = $00000000;
  MTP_PROPGETSET_GETSET = $00000001;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0009
type
  __MIDL___MIDL_itf_mtp_0000_0000_0009 = TOleEnum;
const
  MTP_FORMFLAGS_NONE = $00000000;
  MTP_FORMFLAGS_RANGE = $00000001;
  MTP_FORMFLAGS_ENUM = $00000002;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0006
type
  __MIDL___MIDL_itf_mtp_0000_0000_0006 = TOleEnum;
const
  MTP_OBJECTPROPCODE_NOTUSED = $00000000;
  MTP_OBJECTPROPCODE_ALL = $FFFFFFFF;
  MTP_OBJECTPROPCODE_UNDEFINED = $0000D000;
  MTP_OBJECTPROPCODE_STORAGEID = $0000DC01;
  MTP_OBJECTPROPCODE_OBJECTFORMAT = $0000DC02;
  MTP_OBJECTPROPCODE_PROTECTIONSTATUS = $0000DC03;
  MTP_OBJECTPROPCODE_OBJECTSIZE = $0000DC04;
  MTP_OBJECTPROPCODE_ASSOCIATIONTYPE = $0000DC05;
  MTP_OBJECTPROPCODE_ASSOCIATIONDESC = $0000DC06;
  MTP_OBJECTPROPCODE_OBJECTFILENAME = $0000DC07;
  MTP_OBJECTPROPCODE_DATECREATED = $0000DC08;
  MTP_OBJECTPROPCODE_DATEMODIFIED = $0000DC09;
  MTP_OBJECTPROPCODE_KEYWORDS = $0000DC0A;
  MTP_OBJECTPROPCODE_PARENT = $0000DC0B;
  MTP_OBJECTPROPCODE_PERSISTENTUNIQUEOBJECTIDENTIFIER = $0000DC41;
  MTP_OBJECTPROPCODE_SYNCID = $0000DC42;
  MTP_OBJECTPROPCODE_PROPERTYBAG = $0000DC43;
  MTP_OBJECTPROPCODE_NAME = $0000DC44;
  MTP_OBJECTPROPCODE_CREATEDBY = $0000DC45;
  MTP_OBJECTPROPCODE_ARTIST = $0000DC46;
  MTP_OBJECTPROPCODE_DATEAUTHORED = $0000DC47;
  MTP_OBJECTPROPCODE_DESCRIPTION = $0000DC48;
  MTP_OBJECTPROPCODE_URLREFERENCE = $0000DC49;
  MTP_OBJECTPROPCODE_LANGUAGELOCALE = $0000DC4A;
  MTP_OBJECTPROPCODE_COPYRIGHTINFORMATION = $0000DC4B;
  MTP_OBJECTPROPCODE_SOURCE = $0000DC4C;
  MTP_OBJECTPROPCODE_ORIGINLOCATION = $0000DC4D;
  MTP_OBJECTPROPCODE_DATEADDED = $0000DC4E;
  MTP_OBJECTPROPCODE_NONCONSUMABLE = $0000DC4F;
  MTP_OBJECTPROPCODE_REPRESENTATIVESAMPLEFORMAT = $0000DC81;
  MTP_OBJECTPROPCODE_REPRESENTATIVESAMPLESIZE = $0000DC82;
  MTP_OBJECTPROPCODE_REPRESENTATIVESAMPLEHEIGHT = $0000DC83;
  MTP_OBJECTPROPCODE_REPRESENTATIVESAMPLEWIDTH = $0000DC84;
  MTP_OBJECTPROPCODE_REPRESENTATIVESAMPLEDURATION = $0000DC85;
  MTP_OBJECTPROPCODE_REPRESENTATIVESAMPLEDATA = $0000DC86;
  MTP_OBJECTPROPCODE_WIDTH = $0000DC87;
  MTP_OBJECTPROPCODE_HEIGHT = $0000DC88;
  MTP_OBJECTPROPCODE_DURATION = $0000DC89;
  MTP_OBJECTPROPCODE_USERRATING = $0000DC8A;
  MTP_OBJECTPROPCODE_TRACK = $0000DC8B;
  MTP_OBJECTPROPCODE_GENRE = $0000DC8C;
  MTP_OBJECTPROPCODE_CREDITS = $0000DC8D;
  MTP_OBJECTPROPCODE_LYRICS = $0000DC8E;
  MTP_OBJECTPROPCODE_SUBSCRIPTIONCONTENTID = $0000DC8F;
  MTP_OBJECTPROPCODE_PRODUCEDBY = $0000DC90;
  MTP_OBJECTPROPCODE_USECOUNT = $0000DC91;
  MTP_OBJECTPROPCODE_SKIPCOUNT = $0000DC92;
  MTP_OBJECTPROPCODE_LASTACCESSED = $0000DC93;
  MTP_OBJECTPROPCODE_PARENTALRATING = $0000DC94;
  MTP_OBJECTPROPCODE_METAGENRE = $0000DC95;
  MTP_OBJECTPROPCODE_COMPOSER = $0000DC96;
  MTP_OBJECTPROPCODE_EFFECTIVERATING = $0000DC97;
  MTP_OBJECTPROPCODE_SUBTITLE = $0000DC98;
  MTP_OBJECTPROPCODE_ORIGINALRELEASEDATE = $0000DC99;
  MTP_OBJECTPROPCODE_ALBUMNAME = $0000DC9A;
  MTP_OBJECTPROPCODE_ALBUMARTIST = $0000DC9B;
  MTP_OBJECTPROPCODE_MOOD = $0000DC9C;
  MTP_OBJECTPROPCODE_DRMPROTECTION = $0000DC9D;
  MTP_OBJECTPROPCODE_SUBDESCRIPTION = $0000DC9E;
  MTP_OBJECTPROPCODE_ISCROPPED = $0000DCD1;
  MTP_OBJECTPROPCODE_ISCOLOURCORRECTED = $0000DCD2;
  MTP_OBJECTPROPCODE_TOTALBITRATE = $0000DE91;
  MTP_OBJECTPROPCODE_BITRATETYPE = $0000DE92;
  MTP_OBJECTPROPCODE_SAMPLERATE = $0000DE93;
  MTP_OBJECTPROPCODE_NUMBEROFCHANNELS = $0000DE94;
  MTP_OBJECTPROPCODE_AUDIOBITDEPTH = $0000DE95;
  MTP_OBJECTPROPCODE_BLOCKALIGNMENT = $0000DE96;
  MTP_OBJECTPROPCODE_SCANTYPE = $0000DE97;
  MTP_OBJECTPROPCODE_COLOURRANGE = $0000DE98;
  MTP_OBJECTPROPCODE_AUDIOFORMATCODE = $0000DE99;
  MTP_OBJECTPROPCODE_AUDIOBITRATE = $0000DE9A;
  MTP_OBJECTPROPCODE_VIDEOFORMATCODE = $0000DE9B;
  MTP_OBJECTPROPCODE_VIDEOBITRATE = $0000DE9C;
  MTP_OBJECTPROPCODE_FRAMESPERMILLISECOND = $0000DE9D;
  MTP_OBJECTPROPCODE_KEYFRAMEDISTANCE = $0000DE9E;
  MTP_OBJECTPROPCODE_BUFFERSIZE = $0000DE9F;
  MTP_OBJECTPROPCODE_QUALITY = $0000DEA0;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0000_0008
type
  __MIDL___MIDL_itf_mtp_0000_0000_0008 = TOleEnum;
const
  MTP_PROPERTYGROUP_UNDEFINED = $00000000;
  MTP_PROPERTYGROUP_NOTUSED = $00000000;

// Constants for enum __MIDL___MIDL_itf_mtp_0000_0013_0001
type
  __MIDL___MIDL_itf_mtp_0000_0013_0001 = TOleEnum;
const
  HACK_MODEL_NONE = $00000000;
  HACK_MODEL_DC4800 = $00000001;
  HACK_MODEL_NIKON_E2500 = $00000002;
  HACK_MODEL_SONY = $00000003;
  HACK_MODEL_KODAK_MC3 = $00000004;
  HACK_MODEL_SIGMATEL128 = $00000005;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IMtp = interface;
  IMtpHackInfo = interface;
  IMtpEventCallback = interface;
  IMtpEvent = interface;
  IMtpDeviceInfo = interface;
  IMtpStorageInfo = interface;
  IMtpObjectInfo = interface;
  IMtpDevicePropDesc = interface;
  IMtpObjectPropDesc = interface;
  IEnumMtpPropConfig = interface;
  IMtpPropConfig = interface;
  IEnumObjectPropDesc = interface;
  IMtpResponse = interface;
  IMtpCommand = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  WindowsMtp = IMtp;


// *********************************************************************//
// Declaration of structures, unions and aliases.
// *********************************************************************//
  PUINT1 = ^LongWord; {*}
  POleVariant1 = ^OleVariant; {*}
  PUserType1 = ^MTP_OBJECTPROPCODE; {*}
  PUserType2 = ^MTP_PROPLIST_ITEM; {*}
  PByte1 = ^Byte; {*}
  PUserType3 = ^MTP_OPCODE; {*}
  PUserType4 = ^MTP_EVENTCODE; {*}
  PUserType5 = ^MTP_DEVICEPROPCODE; {*}
  PUserType6 = ^MTP_FORMATCODE; {*}

  MTP_EVENTCODE = __MIDL___MIDL_itf_mtp_0000_0000_0004;
  MTP_FUNCTIONALMODE = __MIDL___MIDL_itf_mtp_0000_0000_0016;
  MTP_OPCODE = __MIDL___MIDL_itf_mtp_0000_0000_0002;
  MTP_DEVICEPROPCODE = __MIDL___MIDL_itf_mtp_0000_0000_0005;
  MTP_FORMATCODE = __MIDL___MIDL_itf_mtp_0000_0000_0007;
  MTP_RESPONSECODE = __MIDL___MIDL_itf_mtp_0000_0000_0003;
  MTP_STORAGETYPE = __MIDL___MIDL_itf_mtp_0000_0000_0011;
  MTP_FILESYSTEMTYPE = __MIDL___MIDL_itf_mtp_0000_0000_0012;
  MTP_STORAGEACCESSCAPABILITY = __MIDL___MIDL_itf_mtp_0000_0000_0013;
  MTP_PROTECTIONSTATUS = __MIDL___MIDL_itf_mtp_0000_0000_0014;
  MTP_ASSOCIATIONTYPE = __MIDL___MIDL_itf_mtp_0000_0000_0015;
  MTP_DATATYPE = __MIDL___MIDL_itf_mtp_0000_0000_0001;
  MTP_PROPGETSET = __MIDL___MIDL_itf_mtp_0000_0000_0010;
  MTP_FORMFLAGS = __MIDL___MIDL_itf_mtp_0000_0000_0009; 
  MTP_OBJECTPROPCODE = __MIDL___MIDL_itf_mtp_0000_0000_0006;
  MTP_PROPERTYGROUP = __MIDL___MIDL_itf_mtp_0000_0000_0008;

  __MIDL___MIDL_itf_mtp_0000_0000_0030 = packed record
    ObjectHandle: LongWord;
    PropCode: __MIDL___MIDL_itf_mtp_0000_0000_0006;
    DataType: __MIDL___MIDL_itf_mtp_0000_0000_0001;
    PropValue: OleVariant;
  end;

  MTP_PROPLIST_ITEM = __MIDL___MIDL_itf_mtp_0000_0000_0030; 
  MTP_HACK_MODEL = __MIDL___MIDL_itf_mtp_0000_0013_0001; 

// *********************************************************************//
// Interface: IMtp
// Flags:     (0)
// GUID:      {E555A570-9F2D-4CDC-9AAE-DFC68F0122F5}
// *********************************************************************//
  IMtp = interface(IUnknown)
    ['{E555A570-9F2D-4CDC-9AAE-DFC68F0122F5}']
    function Open(const bstrDevicePortName: WideString; 
                  const pIMtpEventCallback: IMtpEventCallback; dwReserved: LongWord): HResult; stdcall;
    function Close: HResult; stdcall;
    function GetDeviceInfo(out ppDeviceInfo: IMtpDeviceInfo; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function OpenSession(dwSessionId: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function CloseSession(out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetStorageIDs(out pcelt: Integer; out ppStorageIds: PUINT1; 
                           out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetStorageInfo(StorageId: LongWord; out ppStorageInfo: IMtpStorageInfo;
                            out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetNumObjects(StorageId: LongWord; FormatCode: MTP_FORMATCODE;
                           ParentObjectHandle: LongWord; out pNumObjects: SYSUINT;
                           out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetObjectHandles(StorageId: LongWord; FormatCode: MTP_FORMATCODE;
                              ParentObjectHandle: LongWord; out pcelt: Integer;
                              out ppObjectHandles: PUINT1; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetObjectInfo(ObjectHandle: LongWord; out ppObjectInfo: IMtpObjectInfo;
                           out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
//    function GetObject(ObjectHandle: LongWord;  out pBuffer:pcHAR{ Byte};  out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;

    function GetThumb(ObjectHandle: LongWord; {out} pBuffer: PByte1; cbBufferLen: SYSUINT;
                      out pcbBytesRead: SYSUINT; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function DeleteObject(ObjectHandle: LongWord; FormatCode: MTP_FORMATCODE;
                          out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function SendObjectInfo(StorageId: LongWord; ParentObjectHandle: LongWord;
                            const pIObjectInfo: IMtpObjectInfo; out pResultStorageId: LongWord;
                            out pResultParentObjectHandle: LongWord;
                            out pResultObjectHandle: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function InitiateCapture(StorageId: LongWord; FormatCode: MTP_FORMATCODE;
                             out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function FormatStore(StorageId: LongWord; FilesystemFormat: MTP_FILESYSTEMTYPE;
                         out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function ResetDevice(out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function SelfTest(SelfTestType: Word; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function SetObjectProtection(ObjectHandle: LongWord; ProtectionStatus: MTP_PROTECTIONSTATUS;
                                 out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function PowerDown(out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetDevicePropDesc(PropCode: MTP_DEVICEPROPCODE; out ppPropDesc: IMtpDevicePropDesc;
                               out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetDevicePropValue(PropCode: MTP_DEVICEPROPCODE; MtpDataType: MTP_DATATYPE;
                                out pPropValue: OleVariant; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function SetDevicePropValue(PropCode: MTP_DEVICEPROPCODE; var pNewPropValue: OleVariant;
                                out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function ResetDevicePropValue(PropCode: MTP_DEVICEPROPCODE; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function TerminateCapture(TransactionId: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function MoveObject(ObjectHandle: LongWord; StorageId: LongWord; ParentObjectHandle: LongWord;
                        out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function CopyObject(ObjectHandle: LongWord; StorageId: LongWord; ParentObjectHandle: LongWord;
                        out pResultObjectHandle: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetPartialObject(ObjectHandle: LongWord; Offset: SYSUINT;{out} pBuffer:PByte1;
                              cbToRead: SYSUINT; out pcbRead: SYSUINT;
                              out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
 (* !!!!   error    do not work incorrect type pbuffer       10.12.09
   function GetPartialObject(ObjectHandle: LongWord; Offset: SYSUINT;pBuffer:Byte;
                              cbToRead: SYSUINT; out pcbRead: SYSUINT;
                              out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;

 *)
   function InitiateOpenCapture(StorageId: LongWord; FormatCode: MTP_FORMATCODE;
                                 out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetObjectReferences(ObjectHandle: LongWord; out pcelt: LongWord;
                                 out ppReferences: PUINT1; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function SetObjectReferences(ObjectHandle: LongWord; celt: LongWord; var pReferences: LongWord;
                                 out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetObjectPropDesc(PropCode: MTP_OBJECTPROPCODE; FormatCode: MTP_FORMATCODE;
                               out ppPropDesc: IMtpObjectPropDesc;
                               out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetObjectPropertiesSupported(FormatCode: MTP_FORMATCODE; out pcelt: LongWord;
                                          out ppPropCodes: PUserType1;
                                          out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetObjectPropValue(ObjectHandle: LongWord; PropCode: MTP_OBJECTPROPCODE;
                                MtpDataType: MTP_DATATYPE; out pPropValue: OleVariant;
                                out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function SetObjectPropValue(ObjectHandle: LongWord; PropCode: MTP_OBJECTPROPCODE;
                                var pNewPropValue: OleVariant; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function ResetObjectPropValue(ObjectHandle: LongWord; PropCode: MTP_OBJECTPROPCODE;
                                  out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetObjectPropList(ObjectHandle: LongWord; FormatCode: MTP_FORMATCODE;
                               PropCode: MTP_OBJECTPROPCODE; PropGroup: MTP_PROPERTYGROUP;
                               StorageId: LongWord; out pcelt: LongWord;
                               out ppPropValuesList: PUserType2; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function UpdateDeviceFirmware(FirmwareObjectHandle: LongWord;
                                  out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetInterdependentPropDesc(FormatCode: MTP_FORMATCODE; out ppEnum: IEnumMtpPropConfig;
                                       out pceltConfigs: LongWord;
                                       out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function SetObjectPropList(celt: LongWord; var pPropValuesList: MTP_PROPLIST_ITEM;
                               out pdwFailedPropIndex: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function SendObjectPropList(StorageId: LongWord; ParentObjectHandle: LongWord;
                                FormatCode: MTP_FORMATCODE; cbObjectSize: Largeuint;
                                celt: LongWord; var pPropValuesList: MTP_PROPLIST_ITEM;
                                out pResultStorageId: LongWord;
                                out pResultParentObjectHandle: LongWord;
                                out pResultObjectHandle: LongWord;
                                out pdwFailedPropIndex: LongWord;
                                out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function BeginGetObject(ObjectHandle: LongWord; out pcbReportedDataSize: SYSUINT): HResult; stdcall;
    function BeginSendObject(cbDataSize: SYSUINT): HResult; stdcall;
    function ReadDataChunk({out} pBuffer: PByte1; cbBufferLen: SYSUINT; out pcbBytesRead: SYSUINT): HResult; stdcall;
    function WriteDataChunk({out} pBuffer: PByte1;cbBufferLen: SYSUINT): HResult; stdcall;
  //  function WriteDataChunk(var pBuffer: Byte;cbBufferLen: SYSUINT): HResult; stdcall;
    function CancelTransfer: HResult; stdcall;
    function EndTransferEx(out ppIResponse: IMtpResponse): HResult; stdcall;
    function EndTransfer(out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function AbortIO: HResult; stdcall;
    function ExecuteCommand(const pICommand: IMtpCommand; out ppIResponse: IMtpResponse): HResult; stdcall;
    function ExecuteCommandGetData(const pICommand: IMtpCommand; out pcbReportedDataSize: SYSUINT): HResult; stdcall;
    function ExecuteCommandSendData(const pICommand: IMtpCommand; cbDataSize: SYSUINT): HResult; stdcall;
    function NewCommand(out ppIMtpCommand: IMtpCommand): HResult; stdcall;
    function NewObjectInfo(out ppIMtpObjectInfo: IMtpObjectInfo): HResult; stdcall;
    function GetLastTransactionId(out pTransactionId: LongWord): HResult; stdcall;
    function IsDeviceOpen(out pbDeviceOpen: Integer): HResult; stdcall;
    function IsSessionOpen(out pbSessionOpen: Integer): HResult; stdcall;
    function ClearErrorConditions: HResult; stdcall;
    function SetTimeoutMode(NormalOpTimeout: SYSUINT; SlowOpTimeout: SYSUINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMtpHackInfo
// Flags:     (0)
// GUID:      {E21A9E98-D909-4E27-B46A-B86CA5193131}
// *********************************************************************//
  IMtpHackInfo = interface(IUnknown)
    ['{E21A9E98-D909-4E27-B46A-B86CA5193131}']
    function SetupHackInfo(const pIDeviceInfo: IMtpDeviceInfo; out pHackModel: MTP_HACK_MODEL; 
                           out pHackVersion: Double): HResult; stdcall;
    function GetHackModel(out pHackModel: MTP_HACK_MODEL): HResult; stdcall;
    function GetHackVersion(out pHackVersion: Double): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMtpEventCallback
// Flags:     (0)
// GUID:      {6A6597FA-8583-4AEA-BA0A-2A503584CE25}
// *********************************************************************//
  IMtpEventCallback = interface(IUnknown)
    ['{6A6597FA-8583-4AEA-BA0A-2A503584CE25}']
    function EventCallback(const pIEvent: IMtpEvent): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMtpEvent
// Flags:     (0)
// GUID:      {48F5F5DB-CEFA-42DA-91E2-419AA7FAA510}
// *********************************************************************//
  IMtpEvent = interface(IUnknown)
    ['{48F5F5DB-CEFA-42DA-91E2-419AA7FAA510}']
    function GetEventCode(out pEventCode: MTP_EVENTCODE): HResult; stdcall;
    function GetNumParams(out pnParams: LongWord): HResult; stdcall;
    function GetParam(nIndex: LongWord; out pdwParamValue: LongWord): HResult; stdcall;
    function GetTransactionId(out pdwTransactionId: LongWord): HResult; stdcall;
    function SetEventCode(EventCode: MTP_EVENTCODE; bClearParams: Integer): HResult; stdcall;
    function AddParam(dwParamValue: LongWord): HResult; stdcall;
    function SetTransactionId(dwTransactionId: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMtpDeviceInfo
// Flags:     (0)
// GUID:      {CB7E044F-874D-433C-87D7-E888D77D4A74}
// *********************************************************************//
  IMtpDeviceInfo = interface(IUnknown)
    ['{CB7E044F-874D-433C-87D7-E888D77D4A74}']
    function GetVersion(out pwVersion: Word): HResult; stdcall;
    function GetVendorExtId(out pdwVendorExtId: LongWord): HResult; stdcall;
    function GetVendorExtVersion(out pwVendorExtVersion: Word): HResult; stdcall;
    function GetVendorExtDesc(out pbstrVendorExtDesc: WideString): HResult; stdcall;
    function GetFuncMode(out pFuncMode: MTP_FUNCTIONALMODE): HResult; stdcall;
    function GetSupportedOps(out pcelt: Integer; out ppSupportedOps: PUserType3): HResult; stdcall;
    function GetSupportedEvents(out pcelt: Integer; out ppSupportedEvents: PUserType4): HResult; stdcall;
    function GetSupportedProps(out pcelt: Integer; out ppSupportedProps: PUserType5): HResult; stdcall;
    function GetSupportedCaptureFmts(out pcelt: Integer; out ppSupportedCaptureFmts: PUserType6): HResult; stdcall;
    function GetSupportedObjectFmts(out pcelt: Integer; out ppSupportedObjectFmts: PUserType6): HResult; stdcall;
    function GetManufacturer(out pbstrManufacturer: WideString): HResult; stdcall;
    function GetModel(out pbstrModel: WideString): HResult; stdcall;
    function GetDeviceVersion(out pbstrDeviceVersion: WideString): HResult; stdcall;
    function GetSerialNumber(out pbstrSerialNumber: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMtpStorageInfo
// Flags:     (0)
// GUID:      {C6A38F8C-5184-4F76-AF09-32D635208CC6}
// *********************************************************************//
  IMtpStorageInfo = interface(IUnknown)
    ['{C6A38F8C-5184-4F76-AF09-32D635208CC6}']
    function GetStorageId(out pdwStorageId: LongWord): HResult; stdcall;
    function GetStorageType(out pStorageType: MTP_STORAGETYPE): HResult; stdcall;
    function GetFileSystemType(out pFileSystemType: MTP_FILESYSTEMTYPE): HResult; stdcall;
    function GetAccessCapability(out pAccessCapability: MTP_STORAGEACCESSCAPABILITY): HResult; stdcall;
    function GetMaxCapacity(out pqwMaxCapacity: Largeuint): HResult; stdcall;
    function GetFreeSpaceInBytes(out pqwFreeSpaceInBytes: Largeuint): HResult; stdcall;
    function GetFreeSpaceInObjects(out pdwFreeSpaceInObjects: LongWord): HResult; stdcall;
    function GetStorageDesc(out pbstrStorageDesc: WideString): HResult; stdcall;
    function GetStorageLabel(out pbstrStorageLabel: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMtpObjectInfo
// Flags:     (0)
// GUID:      {8AC54A8C-2CDD-4197-8957-08B30F565FBE}
// *********************************************************************//
  IMtpObjectInfo = interface(IUnknown)
    ['{8AC54A8C-2CDD-4197-8957-08B30F565FBE}']
    function GetObjectHandle(out pdwObjectHandle: LongWord): HResult; stdcall;
    function SetObjectHandle(dwObjectHandle: LongWord): HResult; stdcall;
    function GetStorageId(out pdwStorageId: LongWord): HResult; stdcall;
    function SetStorageId(dwStorageId: LongWord): HResult; stdcall;
    function GetFormatCode(out pFormatCode: MTP_FORMATCODE): HResult; stdcall;
    function SetFormatCode(FormatCode: MTP_FORMATCODE): HResult; stdcall;
    function GetProtectionStatus(out pProtectionStatus: MTP_PROTECTIONSTATUS): HResult; stdcall;
    function SetProtectionStatus(ProtectionStatus: MTP_PROTECTIONSTATUS): HResult; stdcall;
    function GetCompressedSize(out pdwCompressedSize: LongWord): HResult; stdcall;
    function SetCompressedSize(dwCompressedSize: LongWord): HResult; stdcall;
    function GetThumbFormat(out pThumbFormat: MTP_FORMATCODE): HResult; stdcall;
    function SetThumbFormat(ThumbFormat: MTP_FORMATCODE): HResult; stdcall;
    function GetThumbCompressedSize(out pdwThumbCompressedSize: LongWord): HResult; stdcall;
    function SetThumbCompressedSize(dwThumbCompressedSize: LongWord): HResult; stdcall;
    function GetThumbPixWidth(out pdwThumbPixWidth: LongWord): HResult; stdcall;
    function SetThumbPixWidth(dwThumbPixWidth: LongWord): HResult; stdcall;
    function GetThumbPixHeight(out pdwThumbPixHeight: LongWord): HResult; stdcall;
    function SetThumbPixHeight(dwThumbPixHeight: LongWord): HResult; stdcall;
    function GetImagePixWidth(out pdwImagePixWidth: LongWord): HResult; stdcall;
    function SetImagePixWidth(dwImagePixWidth: LongWord): HResult; stdcall;
    function GetImagePixHeight(out pdwImagePixHeight: LongWord): HResult; stdcall;
    function SetImagePixHeight(dwImagePixHeight: LongWord): HResult; stdcall;
    function GetImageBitDepth(out pdwImageBitDepth: LongWord): HResult; stdcall;
    function SetImageBitDepth(dwImageBitDepth: LongWord): HResult; stdcall;
    function GetParentHandle(out pdwParentHandle: LongWord): HResult; stdcall;
    function SetParentHandle(dwParentHandle: LongWord): HResult; stdcall;
    function GetAssociationType(out pAssociationType: MTP_ASSOCIATIONTYPE): HResult; stdcall;
    function SetAssociationType(AssociationType: MTP_ASSOCIATIONTYPE): HResult; stdcall;
    function GetAssociationDesc(out pdwAssociationDesc: LongWord): HResult; stdcall;
    function SetAssociationDesc(dwAssociationDesc: LongWord): HResult; stdcall;
    function GetSequenceNumber(out pdwSequenceNumber: LongWord): HResult; stdcall;
    function SetSequenceNumber(dwSequenceNumber: LongWord): HResult; stdcall;
    function GetFileName(out pbstrFileName: WideString): HResult; stdcall;
    function SetFileName(const bstrFileName: WideString): HResult; stdcall;
    function GetCaptureDate(out pbstrCaptureDate: WideString): HResult; stdcall;
    function SetCaptureDate(const bstrCaptureDate: WideString): HResult; stdcall;
    function GetModificationDate(out pbstrModificationDate: WideString): HResult; stdcall;
    function SetModificationDate(const bstrModificationDate: WideString): HResult; stdcall;
    function GetKeywords(out pbstrKeywords: WideString): HResult; stdcall;
    function SetKeywords(const bstrKeywords: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMtpDevicePropDesc
// Flags:     (0)
// GUID:      {BCAA3A2A-E895-48BD-B046-625D494E2FBA}
// *********************************************************************//
  IMtpDevicePropDesc = interface(IUnknown)
    ['{BCAA3A2A-E895-48BD-B046-625D494E2FBA}']
    function GetPropCode(out pPropCode: MTP_DEVICEPROPCODE): HResult; stdcall;
    function GetMtpDataType(out pDataType: MTP_DATATYPE): HResult; stdcall;
    function GetAccessRights(out pGetSet: MTP_PROPGETSET): HResult; stdcall;
    function GetDefaultValue(out pDefault: OleVariant): HResult; stdcall;
    function GetCurrentValue(out pCurrent: OleVariant): HResult; stdcall;
    function GetFormFlag(out pFormFlag: MTP_FORMFLAGS): HResult; stdcall;
    function GetRangeInfo(out pRangeMin: OleVariant; out pRangeMax: OleVariant; 
                          out pRangeStep: OleVariant): HResult; stdcall;
    function GetEnumSize(out pnElements: Integer): HResult; stdcall;
    function GetEnumValues(out pcelt: Integer; out ppValues: POleVariant1): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMtpObjectPropDesc
// Flags:     (0)
// GUID:      {809AB06C-B17C-44B4-872B-FA6F6FAB2D70}
// *********************************************************************//
  IMtpObjectPropDesc = interface(IUnknown)
    ['{809AB06C-B17C-44B4-872B-FA6F6FAB2D70}']
    function GetPropCode(out pPropCode: MTP_OBJECTPROPCODE): HResult; stdcall;
    function GetMtpDataType(out pDataType: MTP_DATATYPE): HResult; stdcall;
    function GetAccessRights(out pGetSet: MTP_PROPGETSET): HResult; stdcall;
    function GetDefaultValue(out pDefault: OleVariant): HResult; stdcall;
    function GetGroupCode(out pGroupCode: SYSUINT): HResult; stdcall;
    function GetFormFlag(out pFormFlag: MTP_FORMFLAGS): HResult; stdcall;
    function GetRangeInfo(out pRangeMin: OleVariant; out pRangeMax: OleVariant;
                          out pRangeStep: OleVariant): HResult; stdcall;
    function GetEnumSize(out pnElements: Integer): HResult; stdcall;
    function GetEnumValues(out pcelt: Integer; out ppValues: POleVariant1): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEnumMtpPropConfig
// Flags:     (0)
// GUID:      {E16CA25D-F30F-42AA-B7EB-E9E994DD7479}
// *********************************************************************//
  IEnumMtpPropConfig = interface(IUnknown)
    ['{E16CA25D-F30F-42AA-B7EB-E9E994DD7479}']
    function Next(celt: LongWord; out ppElements: IMtpPropConfig; out pceltFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Clone(out ppEnum: IEnumMtpPropConfig): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMtpPropConfig
// Flags:     (0)
// GUID:      {FB35E977-1D70-4821-95F5-EAF5359E5315}
// *********************************************************************//
  IMtpPropConfig = interface(IUnknown)
    ['{FB35E977-1D70-4821-95F5-EAF5359E5315}']
    function GetCount(out pcelt: LongWord): HResult; stdcall;
    function GetEnumerator(out ppEnum: IEnumObjectPropDesc): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEnumObjectPropDesc
// Flags:     (0)
// GUID:      {F51CC4CA-9E43-4BE4-B4A5-141F7CDB87DF}
// *********************************************************************//
  IEnumObjectPropDesc = interface(IUnknown)
    ['{F51CC4CA-9E43-4BE4-B4A5-141F7CDB87DF}']
    function Next(celt: LongWord; out ppElements: IMtpObjectPropDesc; out pceltFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Clone(out ppEnum: IEnumObjectPropDesc): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMtpResponse
// Flags:     (0)
// GUID:      {4E883058-3964-413F-9E90-5577C128071F}
// *********************************************************************//
  IMtpResponse = interface(IUnknown)
    ['{4E883058-3964-413F-9E90-5577C128071F}']
    function GetResponseCode(out pResponseCode: MTP_RESPONSECODE): HResult; stdcall;
    function GetNumParams(out pnParams: LongWord): HResult; stdcall;
    function GetParam(nIndex: LongWord; out pdwParamValue: LongWord): HResult; stdcall;
    function GetTransactionId(out pdwTransactionId: LongWord): HResult; stdcall;
    function SetResponseCode(ResponseCode: MTP_RESPONSECODE; bClearParams: Integer): HResult; stdcall;
    function AddParam(dwParamValue: LongWord): HResult; stdcall;
    function SetTransactionId(dwTransactionId: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMtpCommand
// Flags:     (0)
// GUID:      {9C0D73E4-DD65-4EC8-9E27-CCC3ED7CA564}
// *********************************************************************//
  IMtpCommand = interface(IUnknown)
    ['{9C0D73E4-DD65-4EC8-9E27-CCC3ED7CA564}']
    function GetOpCode(out pOpCode: MTP_OPCODE): HResult; stdcall;
    function GetNumParams(out pnParams: LongWord): HResult; stdcall;
    function GetParam(nIndex: LongWord; out pdwParamValue: LongWord): HResult; stdcall;
    function GetTransactionId(out pdwTransactionId: LongWord): HResult; stdcall;
    function SetOpCode(OpCode: MTP_OPCODE; bClearParams: Integer): HResult; stdcall;
    function AddParam(dwParamValue: LongWord): HResult; stdcall;
    function SetTransactionId(dwTransactionId: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoWindowsMtp provides a Create and CreateRemote method to          
// create instances of the default interface IMtp exposed by              
// the CoClass WindowsMtp. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWindowsMtp = class
    class function Create: IMtp;
    class function CreateRemote(const MachineName: string): IMtp;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TWindowsMtp
// Help String      : Windows MTP class
// Default Interface: IMtp
// Def. Intf. DISP? : No
// Event   Interface:
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TWindowsMtpProperties= class;
{$ENDIF}
  TWindowsMtp = class(TOleServer)
  private
    FIntf: IMtp;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TWindowsMtpProperties;
    function GetServerProperties: TWindowsMtpProperties;
{$ENDIF}
    function GetDefaultInterface: IMtp;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMtp);
    procedure Disconnect; override;
    function Open(const bstrDevicePortName: WideString;
                  const pIMtpEventCallback: IMtpEventCallback; dwReserved: LongWord): HResult;
    function Close: HResult;
    function GetDeviceInfo(out ppDeviceInfo: IMtpDeviceInfo; out pResponseCode: MTP_RESPONSECODE): HResult;
    function OpenSession(dwSessionId: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult;
    function CloseSession(out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetStorageIDs(out pcelt: Integer; out ppStorageIds: PUINT1;
                           out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetStorageInfo(StorageId: LongWord; out ppStorageInfo: IMtpStorageInfo;
                            out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetNumObjects(StorageId: LongWord; FormatCode: MTP_FORMATCODE;
                           ParentObjectHandle: LongWord; out pNumObjects: SYSUINT;
                           out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetObjectHandles(StorageId: LongWord; FormatCode: MTP_FORMATCODE;
                              ParentObjectHandle: LongWord; out pcelt: Integer;
                              out ppObjectHandles: PUINT1; out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetObjectInfo(ObjectHandle: LongWord; out ppObjectInfo: IMtpObjectInfo;
                           out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetThumb(ObjectHandle: LongWord; {out} pBuffer: PByte1; cbBufferLen: SYSUINT;
                      out pcbBytesRead: SYSUINT; out pResponseCode: MTP_RESPONSECODE): HResult;
    function DeleteObject(ObjectHandle: LongWord; FormatCode: MTP_FORMATCODE;
                          out pResponseCode: MTP_RESPONSECODE): HResult;
    function SendObjectInfo(StorageId: LongWord; ParentObjectHandle: LongWord;
                            const pIObjectInfo: IMtpObjectInfo; out pResultStorageId: LongWord;
                            out pResultParentObjectHandle: LongWord;
                            out pResultObjectHandle: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult;
    function InitiateCapture(StorageId: LongWord; FormatCode: MTP_FORMATCODE;
                             out pResponseCode: MTP_RESPONSECODE): HResult;
    function FormatStore(StorageId: LongWord; FilesystemFormat: MTP_FILESYSTEMTYPE;
                         out pResponseCode: MTP_RESPONSECODE): HResult;
    function ResetDevice(out pResponseCode: MTP_RESPONSECODE): HResult;
    function SelfTest(SelfTestType: Word; out pResponseCode: MTP_RESPONSECODE): HResult;
    function SetObjectProtection(ObjectHandle: LongWord; ProtectionStatus: MTP_PROTECTIONSTATUS;
                                 out pResponseCode: MTP_RESPONSECODE): HResult;
    function PowerDown(out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetDevicePropDesc(PropCode: MTP_DEVICEPROPCODE; out ppPropDesc: IMtpDevicePropDesc;
                               out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetDevicePropValue(PropCode: MTP_DEVICEPROPCODE; MtpDataType: MTP_DATATYPE;
                                out pPropValue: OleVariant; out pResponseCode: MTP_RESPONSECODE): HResult;
    function SetDevicePropValue(PropCode: MTP_DEVICEPROPCODE; var pNewPropValue: OleVariant;
                                out pResponseCode: MTP_RESPONSECODE): HResult;
    function ResetDevicePropValue(PropCode: MTP_DEVICEPROPCODE; out pResponseCode: MTP_RESPONSECODE): HResult;
    function TerminateCapture(TransactionId: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult;
    function MoveObject(ObjectHandle: LongWord; StorageId: LongWord; ParentObjectHandle: LongWord;
                        out pResponseCode: MTP_RESPONSECODE): HResult;
    function CopyObject(ObjectHandle: LongWord; StorageId: LongWord; ParentObjectHandle: LongWord;
                        out pResultObjectHandle: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetPartialObject(ObjectHandle: LongWord; Offset: SYSUINT; {out} pBuffer:PByte1;
                              cbToRead: SYSUINT; out pcbRead: SYSUINT;
                              out pResponseCode: MTP_RESPONSECODE): HResult;
    function InitiateOpenCapture(StorageId: LongWord; FormatCode: MTP_FORMATCODE;
                                 out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetObjectReferences(ObjectHandle: LongWord; out pcelt: LongWord;
                                 out ppReferences: PUINT1; out pResponseCode: MTP_RESPONSECODE): HResult;
    function SetObjectReferences(ObjectHandle: LongWord; celt: LongWord; var pReferences: LongWord;
                                 out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetObjectPropDesc(PropCode: MTP_OBJECTPROPCODE; FormatCode: MTP_FORMATCODE;
                               out ppPropDesc: IMtpObjectPropDesc;
                               out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetObjectPropertiesSupported(FormatCode: MTP_FORMATCODE; out pcelt: LongWord;
                                          out ppPropCodes: PUserType1;
                                          out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetObjectPropValue(ObjectHandle: LongWord; PropCode: MTP_OBJECTPROPCODE;
                                MtpDataType: MTP_DATATYPE; out pPropValue: OleVariant;
                                out pResponseCode: MTP_RESPONSECODE): HResult;
    function SetObjectPropValue(ObjectHandle: LongWord; PropCode: MTP_OBJECTPROPCODE;
                                var pNewPropValue: OleVariant; out pResponseCode: MTP_RESPONSECODE): HResult;
    function ResetObjectPropValue(ObjectHandle: LongWord; PropCode: MTP_OBJECTPROPCODE;
                                  out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetObjectPropList(ObjectHandle: LongWord; FormatCode: MTP_FORMATCODE;
                               PropCode: MTP_OBJECTPROPCODE; PropGroup: MTP_PROPERTYGROUP;
                               StorageId: LongWord; out pcelt: LongWord;
                               out ppPropValuesList: PUserType2; out pResponseCode: MTP_RESPONSECODE): HResult;
    function UpdateDeviceFirmware(FirmwareObjectHandle: LongWord;
                                  out pResponseCode: MTP_RESPONSECODE): HResult;
    function GetInterdependentPropDesc(FormatCode: MTP_FORMATCODE; out ppEnum: IEnumMtpPropConfig;
                                       out pceltConfigs: LongWord;
                                       out pResponseCode: MTP_RESPONSECODE): HResult;
    function SetObjectPropList(celt: LongWord; var pPropValuesList: MTP_PROPLIST_ITEM;
                               out pdwFailedPropIndex: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult;
    function SendObjectPropList(StorageId: LongWord; ParentObjectHandle: LongWord;
                                FormatCode: MTP_FORMATCODE; cbObjectSize: Largeuint;
                                celt: LongWord; var pPropValuesList: MTP_PROPLIST_ITEM;
                                out pResultStorageId: LongWord;
                                out pResultParentObjectHandle: LongWord;
                                out pResultObjectHandle: LongWord;
                                out pdwFailedPropIndex: LongWord;
                                out pResponseCode: MTP_RESPONSECODE): HResult;
    function BeginGetObject(ObjectHandle: LongWord; out pcbReportedDataSize: SYSUINT): HResult;
    function BeginSendObject(cbDataSize: SYSUINT): HResult;
    function ReadDataChunk({out} pBuffer:PByte1; cbBufferLen: SYSUINT; out pcbBytesRead: SYSUINT): HResult;
    function WriteDataChunk({var} pBuffer:PByte1; cbBufferLen: SYSUINT): HResult;
    function CancelTransfer: HResult;
    function EndTransferEx(out ppIResponse: IMtpResponse): HResult;
    function EndTransfer(out pResponseCode: MTP_RESPONSECODE): HResult;
    function AbortIO: HResult;
    function ExecuteCommand(const pICommand: IMtpCommand; out ppIResponse: IMtpResponse): HResult;
    function ExecuteCommandGetData(const pICommand: IMtpCommand; out pcbReportedDataSize: SYSUINT): HResult;
    function ExecuteCommandSendData(const pICommand: IMtpCommand; cbDataSize: SYSUINT): HResult;
    function NewCommand(out ppIMtpCommand: IMtpCommand): HResult;
    function NewObjectInfo(out ppIMtpObjectInfo: IMtpObjectInfo): HResult;
    function GetLastTransactionId(out pTransactionId: LongWord): HResult;
    function IsDeviceOpen(out pbDeviceOpen: Integer): HResult;
    function IsSessionOpen(out pbSessionOpen: Integer): HResult;
    function ClearErrorConditions: HResult;
    function SetTimeoutMode(NormalOpTimeout: SYSUINT; SlowOpTimeout: SYSUINT): HResult;
    property DefaultInterface: IMtp read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TWindowsMtpProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TWindowsMtp
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TWindowsMtpProperties = class(TPersistent)
  private
    FServer:    TWindowsMtp;
    function    GetDefaultInterface: IMtp;
    constructor Create(AServer: TWindowsMtp);
  protected
  public
    property DefaultInterface: IMtp read GetDefaultInterface;
  published
  end;
{$ENDIF}
Tmyclass=class(TinterfacedObject,IMtpEventCallback)
    function EventCallback(const pIEvent: IMtpEvent): HResult; stdcall;
  end;


procedure Register;

resourcestring
  dtlServerPage = 'mtp';

  dtlOcxPage = 'mtp';

implementation

uses ComObj;
function Tmyclass.EventCallback(const pIEvent: IMtpEvent): HResult;
var
 i:integer;
 pEventCode: MTP_EVENTCODE ;
 pnParams: LongWord;
 nIndex: LongWord;
 pdwParamValue: LongWord   ;
 pdwTransactionId: LongWord;
 EventCode: MTP_EVENTCODE; bClearParams: Integer;
 dwParamValue: LongWord;
 dwTransactionId: LongWord;

(*    function GetNumParams(out pnParams: LongWord): HResult; stdcall;
    function GetParam(nIndex: LongWord; out pdwParamValue: LongWord): HResult; stdcall;
    function GetTransactionId(out pdwTransactionId: LongWord): HResult; stdcall;
    function SetEventCode(EventCode: MTP_EVENTCODE; bClearParams: Integer): HResult; stdcall;
    function AddParam(dwParamValue: LongWord): HResult; stdcall;
    function SetTransactionId(dwTransactionId: LongWord): HResult; stdcall;
  *)
begin
     pIEvent.GetEventCode(pEventCode);
     pIEvent.GetNumParams(pnParams);
      for i:=0 to  pnParams-1 do
        begin
           pIEvent.GetParam(i, pdwParamValue);
        end;
       pIEvent.GetTransactionId(pdwTransactionId);
       case pEventCode of
(* MTP_EVENTCODE_UNDEFINED = $00004000;
  MTP_EVENTCODE_CANCELTRANSACTION = $00004001;
  MTP_EVENTCODE_OBJECTADDED = $00004002;
  MTP_EVENTCODE_OBJECTREMOVED = $00004003;
  MTP_EVENTCODE_STOREADDED = $00004004;
  MTP_EVENTCODE_STOREREMOVED = $00004005;
  MTP_EVENTCODE_DEVICEPROPCHANGED = $00004006;
  MTP_EVENTCODE_OBJECTINFOCHANGED = $00004007;
  MTP_EVENTCODE_DEVICEINFOCHANGED = $00004008;
  MTP_EVENTCODE_REQUESTOBJECTTRANSFER = $00004009;
  MTP_EVENTCODE_STOREFULL = $0000400A;
  MTP_EVENTCODE_DEVICERESET = $0000400B;
  MTP_EVENTCODE_STORAGEINFOCHANGED = $0000400C;
  MTP_EVENTCODE_CAPTURECOMPLETE = $0000400D;
  MTP_EVENTCODE_UNREPORTEDSTATUS = $0000400E;
  MTP_EVENTCODE_RESERVED_FIRST = $0000400F;
  MTP_EVENTCODE_RESERVED_LAST = $00004FFF;
  MTP_EVENTCODE_VENDOREXTENSION_FIRST = $0000C000;
  MTP_EVENTCODE_VENDOREXTENSION_LAST = $0000CFFF;
  *)
  MTP_EVENTCODE_UNDEFINED:MessageDlg('undefine event',mtwarning,[mbYes,mbNo],0);
  MTP_EVENTCODE_DEVICEPROPCHANGED:MessageDlg('dev pro change',mtwarning,[mbYes,mbNo],0);
  MTP_EVENTCODE_STOREADDED: MessageDlg('store add',mtwarning,[mbYes,mbNo],0);
  MTP_EVENTCODE_STOREREMOVED: MessageDlg('store remove',mtwarning,[mbYes,mbNo],0);
  MTP_EVENTCODE_CAPTURECOMPLETE:MessageDlg('capture complite',mtwarning,[mbYes,mbNo],0);
  MTP_EVENTCODE_OBJECTINFOCHANGED:MessageDlg('object info changed',mtwarning,[mbYes,mbNo],0);
  MTP_EVENTCODE_OBJECTREMOVED:  MessageDlg('file remove',mtwarning,[mbYes,mbNo],0);
  MTP_EVENTCODE_OBJECTADDED: MessageDlg('file add',mtwarning,[mbYes,mbNo],0);
         end;
   pIEvent._release;
end;


class function CoWindowsMtp.Create: IMtp;
begin
  Result := CreateComObject(CLASS_WindowsMtp) as IMtp;
end;

class function CoWindowsMtp.CreateRemote(const MachineName: string): IMtp;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WindowsMtp) as IMtp;
end;

procedure TWindowsMtp.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F1AAAA76-BD01-42E1-A6C0-34FA86ACBB90}';
    IntfIID:   '{E555A570-9F2D-4CDC-9AAE-DFC68F0122F5}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TWindowsMtp.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMtp;
  end;
end;

procedure TWindowsMtp.ConnectTo(svrIntf: IMtp);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TWindowsMtp.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TWindowsMtp.GetDefaultInterface: IMtp;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TWindowsMtp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TWindowsMtpProperties.Create(Self);
{$ENDIF}
end;

destructor TWindowsMtp.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TWindowsMtp.GetServerProperties: TWindowsMtpProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TWindowsMtp.Open(const bstrDevicePortName: WideString; 
                          const pIMtpEventCallback: IMtpEventCallback; dwReserved: LongWord): HResult;
begin
  Result := DefaultInterface.Open(bstrDevicePortName, pIMtpEventCallback, dwReserved);
end;

function TWindowsMtp.Close: HResult;
begin
  Result := DefaultInterface.Close;
end;

function TWindowsMtp.GetDeviceInfo(out ppDeviceInfo: IMtpDeviceInfo; 
                                   out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetDeviceInfo(ppDeviceInfo, pResponseCode);
end;

function TWindowsMtp.OpenSession(dwSessionId: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.OpenSession(dwSessionId, pResponseCode);
end;

function TWindowsMtp.CloseSession(out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.CloseSession(pResponseCode);
end;

function TWindowsMtp.GetStorageIDs(out pcelt: Integer; out ppStorageIds: PUINT1; 
                                   out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetStorageIDs(pcelt, ppStorageIds, pResponseCode);
end;

function TWindowsMtp.GetStorageInfo(StorageId: LongWord; out ppStorageInfo: IMtpStorageInfo; 
                                    out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetStorageInfo(StorageId, ppStorageInfo, pResponseCode);
end;

function TWindowsMtp.GetNumObjects(StorageId: LongWord; FormatCode: MTP_FORMATCODE; 
                                   ParentObjectHandle: LongWord; out pNumObjects: SYSUINT; 
                                   out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetNumObjects(StorageId, FormatCode, ParentObjectHandle, pNumObjects, 
                                           pResponseCode);
end;

function TWindowsMtp.GetObjectHandles(StorageId: LongWord; FormatCode: MTP_FORMATCODE; 
                                      ParentObjectHandle: LongWord; out pcelt: Integer; 
                                      out ppObjectHandles: PUINT1; 
                                      out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetObjectHandles(StorageId, FormatCode, ParentObjectHandle, pcelt, 
                                              ppObjectHandles, pResponseCode);
end;

function TWindowsMtp.GetObjectInfo(ObjectHandle: LongWord; out ppObjectInfo: IMtpObjectInfo;
                                   out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetObjectInfo(ObjectHandle, ppObjectInfo, pResponseCode);
end;

function TWindowsMtp.GetThumb(ObjectHandle: LongWord; {out} pBuffer: PByte1; cbBufferLen: SYSUINT;
                              out pcbBytesRead: SYSUINT; out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetThumb(ObjectHandle, pBuffer, cbBufferLen, pcbBytesRead,
                                      pResponseCode);
end;

function TWindowsMtp.DeleteObject(ObjectHandle: LongWord; FormatCode: MTP_FORMATCODE; 
                                  out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.DeleteObject(ObjectHandle, FormatCode, pResponseCode);
end;

function TWindowsMtp.SendObjectInfo(StorageId: LongWord; ParentObjectHandle: LongWord; 
                                    const pIObjectInfo: IMtpObjectInfo; 
                                    out pResultStorageId: LongWord; 
                                    out pResultParentObjectHandle: LongWord; 
                                    out pResultObjectHandle: LongWord; 
                                    out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.SendObjectInfo(StorageId, ParentObjectHandle, pIObjectInfo, 
                                            pResultStorageId, pResultParentObjectHandle, 
                                            pResultObjectHandle, pResponseCode);
end;

function TWindowsMtp.InitiateCapture(StorageId: LongWord; FormatCode: MTP_FORMATCODE; 
                                     out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.InitiateCapture(StorageId, FormatCode, pResponseCode);
end;

function TWindowsMtp.FormatStore(StorageId: LongWord; FilesystemFormat: MTP_FILESYSTEMTYPE;
                                 out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.FormatStore(StorageId, FilesystemFormat, pResponseCode);
end;

function TWindowsMtp.ResetDevice(out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.ResetDevice(pResponseCode);
end;

function TWindowsMtp.SelfTest(SelfTestType: Word; out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.SelfTest(SelfTestType, pResponseCode);
end;

function TWindowsMtp.SetObjectProtection(ObjectHandle: LongWord; 
                                         ProtectionStatus: MTP_PROTECTIONSTATUS; 
                                         out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.SetObjectProtection(ObjectHandle, ProtectionStatus, pResponseCode);
end;

function TWindowsMtp.PowerDown(out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.PowerDown(pResponseCode);
end;

function TWindowsMtp.GetDevicePropDesc(PropCode: MTP_DEVICEPROPCODE; 
                                       out ppPropDesc: IMtpDevicePropDesc; 
                                       out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetDevicePropDesc(PropCode, ppPropDesc, pResponseCode);
end;

function TWindowsMtp.GetDevicePropValue(PropCode: MTP_DEVICEPROPCODE; MtpDataType: MTP_DATATYPE; 
                                        out pPropValue: OleVariant; 
                                        out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetDevicePropValue(PropCode, MtpDataType, pPropValue, pResponseCode);
end;

function TWindowsMtp.SetDevicePropValue(PropCode: MTP_DEVICEPROPCODE; 
                                        var pNewPropValue: OleVariant; 
                                        out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.SetDevicePropValue(PropCode, pNewPropValue, pResponseCode);
end;

function TWindowsMtp.ResetDevicePropValue(PropCode: MTP_DEVICEPROPCODE; 
                                          out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.ResetDevicePropValue(PropCode, pResponseCode);
end;

function TWindowsMtp.TerminateCapture(TransactionId: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.TerminateCapture(TransactionId, pResponseCode);
end;

function TWindowsMtp.MoveObject(ObjectHandle: LongWord; StorageId: LongWord; 
                                ParentObjectHandle: LongWord; out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.MoveObject(ObjectHandle, StorageId, ParentObjectHandle, pResponseCode);
end;

function TWindowsMtp.CopyObject(ObjectHandle: LongWord; StorageId: LongWord; 
                                ParentObjectHandle: LongWord; out pResultObjectHandle: LongWord; 
                                out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.CopyObject(ObjectHandle, StorageId, ParentObjectHandle, 
                                        pResultObjectHandle, pResponseCode);
end;

function TWindowsMtp.GetPartialObject(ObjectHandle: LongWord; Offset: SYSUINT; {out} pBuffer:PByte1;
                                      cbToRead: SYSUINT; out pcbRead: SYSUINT; 
                                      out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetPartialObject(ObjectHandle, Offset, pBuffer, cbToRead, pcbRead,
                                              pResponseCode);
end;

function TWindowsMtp.InitiateOpenCapture(StorageId: LongWord; FormatCode: MTP_FORMATCODE; 
                                         out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.InitiateOpenCapture(StorageId, FormatCode, pResponseCode);
end;

function TWindowsMtp.GetObjectReferences(ObjectHandle: LongWord; out pcelt: LongWord; 
                                         out ppReferences: PUINT1; 
                                         out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetObjectReferences(ObjectHandle, pcelt, ppReferences, pResponseCode);
end;

function TWindowsMtp.SetObjectReferences(ObjectHandle: LongWord; celt: LongWord; 
                                         var pReferences: LongWord; 
                                         out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.SetObjectReferences(ObjectHandle, celt, pReferences, pResponseCode);
end;

function TWindowsMtp.GetObjectPropDesc(PropCode: MTP_OBJECTPROPCODE; FormatCode: MTP_FORMATCODE; 
                                       out ppPropDesc: IMtpObjectPropDesc; 
                                       out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetObjectPropDesc(PropCode, FormatCode, ppPropDesc, pResponseCode);
end;

function TWindowsMtp.GetObjectPropertiesSupported(FormatCode: MTP_FORMATCODE; out pcelt: LongWord; 
                                                  out ppPropCodes: PUserType1; 
                                                  out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetObjectPropertiesSupported(FormatCode, pcelt, ppPropCodes, 
                                                          pResponseCode);
end;

function TWindowsMtp.GetObjectPropValue(ObjectHandle: LongWord; PropCode: MTP_OBJECTPROPCODE; 
                                        MtpDataType: MTP_DATATYPE; out pPropValue: OleVariant; 
                                        out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetObjectPropValue(ObjectHandle, PropCode, MtpDataType, pPropValue, 
                                                pResponseCode);
end;

function TWindowsMtp.SetObjectPropValue(ObjectHandle: LongWord; PropCode: MTP_OBJECTPROPCODE; 
                                        var pNewPropValue: OleVariant; 
                                        out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.SetObjectPropValue(ObjectHandle, PropCode, pNewPropValue, pResponseCode);
end;

function TWindowsMtp.ResetObjectPropValue(ObjectHandle: LongWord; PropCode: MTP_OBJECTPROPCODE; 
                                          out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.ResetObjectPropValue(ObjectHandle, PropCode, pResponseCode);
end;

function TWindowsMtp.GetObjectPropList(ObjectHandle: LongWord; FormatCode: MTP_FORMATCODE; 
                                       PropCode: MTP_OBJECTPROPCODE; PropGroup: MTP_PROPERTYGROUP; 
                                       StorageId: LongWord; out pcelt: LongWord; 
                                       out ppPropValuesList: PUserType2; 
                                       out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetObjectPropList(ObjectHandle, FormatCode, PropCode, PropGroup, 
                                               StorageId, pcelt, ppPropValuesList, pResponseCode);
end;

function TWindowsMtp.UpdateDeviceFirmware(FirmwareObjectHandle: LongWord; 
                                          out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.UpdateDeviceFirmware(FirmwareObjectHandle, pResponseCode);
end;

function TWindowsMtp.GetInterdependentPropDesc(FormatCode: MTP_FORMATCODE; 
                                               out ppEnum: IEnumMtpPropConfig; 
                                               out pceltConfigs: LongWord; 
                                               out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.GetInterdependentPropDesc(FormatCode, ppEnum, pceltConfigs,
                                                       pResponseCode);
end;

function TWindowsMtp.SetObjectPropList(celt: LongWord; var pPropValuesList: MTP_PROPLIST_ITEM; 
                                       out pdwFailedPropIndex: LongWord; 
                                       out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.SetObjectPropList(celt, pPropValuesList, pdwFailedPropIndex, 
                                               pResponseCode);
end;

function TWindowsMtp.SendObjectPropList(StorageId: LongWord; ParentObjectHandle: LongWord; 
                                        FormatCode: MTP_FORMATCODE; cbObjectSize: Largeuint; 
                                        celt: LongWord; var pPropValuesList: MTP_PROPLIST_ITEM; 
                                        out pResultStorageId: LongWord; 
                                        out pResultParentObjectHandle: LongWord; 
                                        out pResultObjectHandle: LongWord; 
                                        out pdwFailedPropIndex: LongWord; 
                                        out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.SendObjectPropList(StorageId, ParentObjectHandle, FormatCode, 
                                                cbObjectSize, celt, pPropValuesList, 
                                                pResultStorageId, pResultParentObjectHandle, 
                                                pResultObjectHandle, pdwFailedPropIndex, 
                                                pResponseCode);
end;

function TWindowsMtp.BeginGetObject(ObjectHandle: LongWord; out pcbReportedDataSize: SYSUINT): HResult;
begin
  Result := DefaultInterface.BeginGetObject(ObjectHandle, pcbReportedDataSize);
end;

function TWindowsMtp.BeginSendObject(cbDataSize: SYSUINT): HResult;
begin
  Result := DefaultInterface.BeginSendObject(cbDataSize);
end;

function TWindowsMtp.ReadDataChunk({out} pBuffer: PByte1;cbBufferLen: SYSUINT;
                                   out pcbBytesRead: SYSUINT): HResult;
begin
  Result := DefaultInterface.ReadDataChunk(pBuffer, cbBufferLen, pcbBytesRead);
end;

function TWindowsMtp.WriteDataChunk({var }pBuffer: PByte1; cbBufferLen: SYSUINT): HResult;
begin
  Result := DefaultInterface.WriteDataChunk(pBuffer, cbBufferLen);
end;

function TWindowsMtp.CancelTransfer: HResult;
begin
  Result := DefaultInterface.CancelTransfer;
end;

function TWindowsMtp.EndTransferEx(out ppIResponse: IMtpResponse): HResult;
begin
  Result := DefaultInterface.EndTransferEx(ppIResponse);
end;

function TWindowsMtp.EndTransfer(out pResponseCode: MTP_RESPONSECODE): HResult;
begin
  Result := DefaultInterface.EndTransfer(pResponseCode);
end;

function TWindowsMtp.AbortIO: HResult;
begin
  Result := DefaultInterface.AbortIO;
end;

function TWindowsMtp.ExecuteCommand(const pICommand: IMtpCommand; out ppIResponse: IMtpResponse): HResult;
begin
  Result := DefaultInterface.ExecuteCommand(pICommand, ppIResponse);
end;

function TWindowsMtp.ExecuteCommandGetData(const pICommand: IMtpCommand; 
                                           out pcbReportedDataSize: SYSUINT): HResult;
begin
  Result := DefaultInterface.ExecuteCommandGetData(pICommand, pcbReportedDataSize);
end;

function TWindowsMtp.ExecuteCommandSendData(const pICommand: IMtpCommand; cbDataSize: SYSUINT): HResult;
begin
  Result := DefaultInterface.ExecuteCommandSendData(pICommand, cbDataSize);
end;

function TWindowsMtp.NewCommand(out ppIMtpCommand: IMtpCommand): HResult;
begin
  Result := DefaultInterface.NewCommand(ppIMtpCommand);
end;

function TWindowsMtp.NewObjectInfo(out ppIMtpObjectInfo: IMtpObjectInfo): HResult;
begin
  Result := DefaultInterface.NewObjectInfo(ppIMtpObjectInfo);
end;

function TWindowsMtp.GetLastTransactionId(out pTransactionId: LongWord): HResult;
begin
  Result := DefaultInterface.GetLastTransactionId(pTransactionId);
end;

function TWindowsMtp.IsDeviceOpen(out pbDeviceOpen: Integer): HResult;
begin
  Result := DefaultInterface.IsDeviceOpen(pbDeviceOpen);
end;

function TWindowsMtp.IsSessionOpen(out pbSessionOpen: Integer): HResult;
begin
  Result := DefaultInterface.IsSessionOpen(pbSessionOpen);
end;

function TWindowsMtp.ClearErrorConditions: HResult;
begin
  Result := DefaultInterface.ClearErrorConditions;
end;

function TWindowsMtp.SetTimeoutMode(NormalOpTimeout: SYSUINT; SlowOpTimeout: SYSUINT): HResult;
begin
  Result := DefaultInterface.SetTimeoutMode(NormalOpTimeout, SlowOpTimeout);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TWindowsMtpProperties.Create(AServer: TWindowsMtp);
begin
  inherited Create;
  FServer := AServer;
end;

function TWindowsMtpProperties.GetDefaultInterface: IMtp;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TWindowsMtp]);
end;

end.
