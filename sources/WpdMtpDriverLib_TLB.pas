unit WpdMtpDriverLib_TLB;

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
// File generated on 26.01.2010 0:28:54 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\WINDOWS\system32\DRIVERS\UMDF\wpdmtpdr.dll (1)
// LIBID: {BA0DEFED-4BC5-4F27-AF2B-D0566D9E067A}
// LCID: 0
// Helpfile: 
// HelpString: WPD MTP Driver for WUDF 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
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
  WpdMtpDriverLibMajorVersion = 1;
  WpdMtpDriverLibMinorVersion = 0;

  LIBID_WpdMtpDriverLib: TGUID = '{BA0DEFED-4BC5-4F27-AF2B-D0566D9E067A}';

  IID_IDriverEntry: TGUID = '{1BEC7499-8881-4F2B-B01C-A1A907304AFC}';
  CLASS_WpdMtpDriver: TGUID = '{AAAE762B-A6A2-4C45-B5D8-9A83AFB6BB70}';
  IID_IWDFObject: TGUID = '{64275C66-2E71-4060-B5F4-3A76DF96ED3C}';
  IID_IWDFDriver: TGUID = '{AD368EBE-4139-43E3-A875-69B266A9139C}';
  IID_IObjectCleanup: TGUID = '{244ABE3A-ABBC-43B1-A877-F00077550E6A}';
  IID_IWDFDeviceInitialize: TGUID = '{74CC381C-0871-43C1-878B-3F7C9D16933D}';
  IID_IWDFNamedPropertyStore: TGUID = '{394B48C9-BCA0-498F-8E2C-01225464A932}';
  IID_IWDFDevice: TGUID = '{D657FE45-460A-49C3-8219-766AE8032A80}';
  IID_IWDFIoTarget: TGUID = '{CC060D79-C0C2-407F-8B10-A5E900FC3474}';
  IID_IWDFFile: TGUID = '{CC8FE04B-FE8B-4245-AFD6-C31BC830C791}';
  IID_IWDFIoRequest: TGUID = '{896DF312-22B4-4A9D-95DD-A364AAF59769}';
  IID_IRequestCallbackRequestCompletion: TGUID = '{8A7CC8CB-CEB2-46F6-9851-77BD347A15C2}';
  IID_IWDFRequestCompletionParams: TGUID = '{707A2B42-69B8-4971-A49C-4031861E7AFF}';
  IID_IWDFMemory: TGUID = '{AB098F88-8F16-472A-B0BC-ECA46486C102}';
  IID_IRequestCallbackCancel: TGUID = '{4E9F1A77-4587-4235-81C4-E6D24545A656}';
  IID_IWDFIoQueue: TGUID = '{AE1162B9-8B11-4714-993D-93DC48CC9E8A}';
  IID_IQueueCallbackStateChange: TGUID = '{E7ECE381-7CB1-468A-BC43-ABD5948FFC75}';
  IID_IImpersonateCallback: TGUID = '{99B01D17-9FBD-4AA6-B16D-82DAB6A4107F}';
  IID_IWDFDriverCreatedFile: TGUID = '{B7615D26-494B-47A6-B4CF-0271BCC3DA4B}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum _WDF_CALLBACK_CONSTRAINT
type
  _WDF_CALLBACK_CONSTRAINT = TOleEnum;
const
  None = $00000000;
  WdfDeviceLevel = $00000001;
  WdfLevelReserved = $00000002;
  WdfLevelMaximum = $00000003;

// Constants for enum _WDF_PROPERTY_STORE_RETRIEVE_FLAGS
type
  _WDF_PROPERTY_STORE_RETRIEVE_FLAGS = TOleEnum;
const
  WdfPropertyStoreNormal = $00000000;
  WdfPropertyStoreCreateIfMissing = $00000001;

// Constants for enum _WDF_PROPERTY_STORE_DISPOSITION
type
  _WDF_PROPERTY_STORE_DISPOSITION = TOleEnum;
const
  CreatedNewStore = $00000001;
  OpenedExistingStore = $00000002;

// Constants for enum _WDF_TRI_STATE
type
  _WDF_TRI_STATE = TOleEnum;
const
  WdfUseDefault = $00000000;
  WdfFalse = $00000001;
  WdfTrue = $00000002;

// Constants for enum _WDF_PNP_CAPABILITY
type
  _WDF_PNP_CAPABILITY = TOleEnum;
const
  WdfPnpCapInvalid = $00000000;
  WdfPnpCapLockSupported = $00000001;
  WdfPnpCapEjectSupported = $00000002;
  WdfPnpCapRemovable = $00000003;
  WdfPnpCapDockDevice = $00000004;
  WdfPnpCapSurpriseRemovalOk = $00000005;
  WdfPnpCapNoDisplayInUI = $00000006;
  WdfPnpCapMaximum = $00000007;

// Constants for enum _WDF_REQUEST_TYPE
type
  _WDF_REQUEST_TYPE = TOleEnum;
const
  WdfRequestUndefined = $00000000;
  WdfRequestCreate = $00000001;
  WdfRequestCleanup = $00000002;
  WdfRequestRead = $00000003;
  WdfRequestWrite = $00000004;
  WdfRequestDeviceIoControl = $00000005;
  WdfRequestClose = $00000006;
  WdfRequestUsb = $00000007;
  WdfRequestOther = $00000008;
  WdfRequestInternalIoctl = $00000009;
  WdfRequestTypeNoFormat = $0000000A;
  WdfRequestMaximum = $0000000B;

// Constants for enum _WDF_IO_QUEUE_STATE
type
  _WDF_IO_QUEUE_STATE = TOleEnum;
const
  WdfIoQueueAcceptRequests = $00000001;
  WdfIoQueueDispatchRequests = $00000002;
  WdfIoQueueNoRequests = $00000004;
  WdfIoQueueDriverNoRequests = $00000008;
  WdfIoQueuePnpHeld = $00000010;

// Constants for enum _SECURITY_IMPERSONATION_LEVEL
type
  _SECURITY_IMPERSONATION_LEVEL = TOleEnum;
const
  SecurityAnonymous = $00000000;
  SecurityIdentification = $00000001;
  SecurityImpersonation = $00000002;
  SecurityDelegation = $00000003;

// Constants for enum _WDF_IO_QUEUE_DISPATCH_TYPE
type
  _WDF_IO_QUEUE_DISPATCH_TYPE = TOleEnum;
const
  WdfIoQueueDispatchSequential = $00000001;
  WdfIoQueueDispatchParallel = $00000002;
  WdfIoQueueDispatchManual = $00000003;
  WdfIoQueueDispatchMaximum = $00000004;

// Constants for enum _WDF_EVENT_TYPE
type
  _WDF_EVENT_TYPE = TOleEnum;
const
  WdfEventReserved = $00000000;
  WdfEventBroadcast = $00000001;
  WdfEventMaximum = $00000002;

// Constants for enum _WDF_PNP_STATE
type
  _WDF_PNP_STATE = TOleEnum;
const
  WdfPnpStateInvalid = $00000000;
  WdfPnpStateDisabled = $00000001;
  WdfPnpStateFailed = $00000002;
  WdfPnpStateRemoved = $00000003;
  WdfPnpStateResourcesChanged = $00000004;
  WdfPnpStateDontDisplayInUI = $00000005;
  WdfPnpStateNotDisableable = $00000006;
  WdfPnpStateMaximum = $00000007;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDriverEntry = interface;
  IWDFObject = interface;
  IWDFDriver = interface;
  IObjectCleanup = interface;
  IWDFDeviceInitialize = interface;
  IWDFNamedPropertyStore = interface;
  IWDFDevice = interface;
  IWDFIoTarget = interface;
  IWDFFile = interface;
  IWDFIoRequest = interface;
  IRequestCallbackRequestCompletion = interface;
  IWDFRequestCompletionParams = interface;
  IWDFMemory = interface;
  IRequestCallbackCancel = interface;
  IWDFIoQueue = interface;
  IQueueCallbackStateChange = interface;
  IImpersonateCallback = interface;
  IWDFDriverCreatedFile = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  WpdMtpDriver = IDriverEntry;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PByte1 = ^Byte; {*}
  PUserType1 = ^UMDF_VERSION_DATA; {*}
  PWord1 = ^Word; {*}
  PPPrivateAlias1 = ^Pointer; {*}
  PUserType2 = ^TGUID; {*}
  PUserType3 = ^_WDFMEMORY_OFFSET; {*}
  PComp1 = ^Int64; {*}

  ULONG_PTR = LongWord; 

  _WDFMEMORY_OFFSET = packed record
    BufferOffset: ULONG_PTR;
    BufferLength: ULONG_PTR;
  end;

  UMDF_VERSION_DATA = packed record
    MajorNumber: LongWord;
    MinorNumber: LongWord;
    ServiceNumber: LongWord;
  end;


// *********************************************************************//
// Interface: IDriverEntry
// Flags:     (512) Restricted
// GUID:      {1BEC7499-8881-4F2B-B01C-A1A907304AFC}
// *********************************************************************//
  IDriverEntry = interface(IUnknown)
    ['{1BEC7499-8881-4F2B-B01C-A1A907304AFC}']
    function OnInitialize(const pWdfDriver: IWDFDriver): HResult; stdcall;
    function OnDeviceAdd(const pWdfDriver: IWDFDriver; const pWdfDeviceInit: IWDFDeviceInitialize): HResult; stdcall;
    procedure OnDeinitialize(const pWdfDriver: IWDFDriver); stdcall;
  end;

// *********************************************************************//
// Interface: IWDFObject
// Flags:     (512) Restricted
// GUID:      {64275C66-2E71-4060-B5F4-3A76DF96ED3C}
// *********************************************************************//
  IWDFObject = interface(IUnknown)
    ['{64275C66-2E71-4060-B5F4-3A76DF96ED3C}']
    function DeleteWdfObject: HResult; stdcall;
    function AssignContext(const pCleanupCallback: IObjectCleanup; var pContext: Pointer): HResult; stdcall;
    function RetrieveContext(out ppvContext: Pointer): HResult; stdcall;
    procedure AcquireLock; stdcall;
    procedure ReleaseLock; stdcall;
  end;

// *********************************************************************//
// Interface: IWDFDriver
// Flags:     (512) Restricted
// GUID:      {AD368EBE-4139-43E3-A875-69B266A9139C}
// *********************************************************************//
  IWDFDriver = interface(IWDFObject)
    ['{AD368EBE-4139-43E3-A875-69B266A9139C}']
    function CreateDevice(const pDeviceInit: IWDFDeviceInitialize; 
                          const pCallbackInterface: IUnknown; out ppDevice: IWDFDevice): HResult; stdcall;
    function CreateWdfObject(const pCallbackInterface: IUnknown; const pParentObject: IWDFObject; 
                             out ppWdfObject: IWDFObject): HResult; stdcall;
    function CreatePreallocatedWdfMemory(var pBuff: Byte; BufferSize: ULONG_PTR; 
                                         const pCallbackInterface: IUnknown; 
                                         const pParentObject: IWDFObject; 
                                         out ppWdfMemory: IWDFMemory): HResult; stdcall;
    function CreateWdfMemory(BufferSize: ULONG_PTR; const pCallbackInterface: IUnknown; 
                             const pParentObject: IWDFObject; out ppWdfMemory: IWDFMemory): HResult; stdcall;
    function IsVersionAvailable(var pMinimumVersion: UMDF_VERSION_DATA): Integer; stdcall;
    function RetrieveVersionString(pVersion: PWideChar; var pdwVersionLength: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IObjectCleanup
// Flags:     (512) Restricted
// GUID:      {244ABE3A-ABBC-43B1-A877-F00077550E6A}
// *********************************************************************//
  IObjectCleanup = interface(IUnknown)
    ['{244ABE3A-ABBC-43B1-A877-F00077550E6A}']
    procedure OnCleanup(const pWdfObject: IWDFObject); stdcall;
  end;

// *********************************************************************//
// Interface: IWDFDeviceInitialize
// Flags:     (512) Restricted
// GUID:      {74CC381C-0871-43C1-878B-3F7C9D16933D}
// *********************************************************************//
  IWDFDeviceInitialize = interface(IUnknown)
    ['{74CC381C-0871-43C1-878B-3F7C9D16933D}']
    procedure SetFilter; stdcall;
    procedure SetLockingConstraint(LockType: _WDF_CALLBACK_CONSTRAINT); stdcall;
    function RetrieveDevicePropertyStore(var pcwszServiceName: Word; 
                                         Flags: _WDF_PROPERTY_STORE_RETRIEVE_FLAGS; 
                                         out ppPropStore: IWDFNamedPropertyStore; 
                                         out pDisposition: _WDF_PROPERTY_STORE_DISPOSITION): HResult; stdcall;
    procedure SetPowerPolicyOwnership(fTrue: Integer); stdcall;
    procedure AutoForwardCreateCleanupClose(State: _WDF_TRI_STATE); stdcall;
    function RetrieveDeviceInstanceId(Buffer: PWideChar; var pdwSizeInChars: LongWord): HResult; stdcall;
    procedure SetPnpCapability(Capability: _WDF_PNP_CAPABILITY; Value: _WDF_TRI_STATE); stdcall;
    function GetPnpCapability(Capability: _WDF_PNP_CAPABILITY): _WDF_TRI_STATE; stdcall;
  end;

// *********************************************************************//
// Interface: IWDFNamedPropertyStore
// Flags:     (0)
// GUID:      {394B48C9-BCA0-498F-8E2C-01225464A932}
// *********************************************************************//
  IWDFNamedPropertyStore = interface(IUnknown)
    ['{394B48C9-BCA0-498F-8E2C-01225464A932}']
    function GetNamedValue(pszName: PWideChar; out pv: Pointer): HResult; stdcall;
    function SetNamedValue(pszName: PWideChar; pv: PPPrivateAlias1): HResult; stdcall;
    function GetNameCount(out pdwCount: LongWord): HResult; stdcall;
    function GetNameAt(iProp: LongWord; out ppwszName: PWideChar): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IWDFDevice
// Flags:     (512) Restricted
// GUID:      {D657FE45-460A-49C3-8219-766AE8032A80}
// *********************************************************************//
  IWDFDevice = interface(IWDFObject)
    ['{D657FE45-460A-49C3-8219-766AE8032A80}']
    function RetrieveDevicePropertyStore(var pcwszServiceName: Word; 
                                         Flags: _WDF_PROPERTY_STORE_RETRIEVE_FLAGS; 
                                         out ppPropStore: IWDFNamedPropertyStore; 
                                         out pDisposition: _WDF_PROPERTY_STORE_DISPOSITION): HResult; stdcall;
    procedure GetDriver(out ppWdfDriver: IWDFDriver); stdcall;
    function RetrieveDeviceInstanceId(Buffer: PWideChar; var pdwSizeInChars: LongWord): HResult; stdcall;
    procedure GetDefaultIoTarget(out ppWdfIoTarget: IWDFIoTarget); stdcall;
    function CreateWdfFile(pcwszFileName: PWideChar; out ppFile: IWDFDriverCreatedFile): HResult; stdcall;
    procedure GetDefaultIoQueue(out ppWdfIoQueue: IWDFIoQueue); stdcall;
    function CreateIoQueue(const pCallbackInterface: IUnknown; bDefaultQueue: Integer; 
                           DispatchType: _WDF_IO_QUEUE_DISPATCH_TYPE; bPowerManaged: Integer; 
                           bAllowZeroLengthRequests: Integer; out ppIoQueue: IWDFIoQueue): HResult; stdcall;
    function CreateDeviceInterface(var pDeviceInterfaceGuid: TGUID; pReferenceString: PWideChar): HResult; stdcall;
    function AssignDeviceInterfaceState(var pDeviceInterfaceGuid: TGUID; 
                                        pReferenceString: PWideChar; Enable: Integer): HResult; stdcall;
    function RetrieveDeviceName(pDeviceName: PWideChar; var pdwDeviceNameLength: LongWord): HResult; stdcall;
    function PostEvent(var EventGuid: TGUID; EventType: _WDF_EVENT_TYPE; var pbData: Byte; 
                       cbDataSize: LongWord): HResult; stdcall;
    function ConfigureRequestDispatching(const pQueue: IWDFIoQueue; RequestType: _WDF_REQUEST_TYPE; 
                                         Forward: Integer): HResult; stdcall;
    procedure SetPnpState(State: _WDF_PNP_STATE; Value: _WDF_TRI_STATE); stdcall;
    function GetPnpState(State: _WDF_PNP_STATE): _WDF_TRI_STATE; stdcall;
    procedure CommitPnpState; stdcall;
    function CreateRequest(const pCallbackInterface: IUnknown; const pParentObject: IWDFObject; 
                           out ppRequest: IWDFIoRequest): HResult; stdcall;
    function CreateSymbolicLink(pSymbolicLink: PWideChar): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IWDFIoTarget
// Flags:     (512) Restricted
// GUID:      {CC060D79-C0C2-407F-8B10-A5E900FC3474}
// *********************************************************************//
  IWDFIoTarget = interface(IWDFObject)
    ['{CC060D79-C0C2-407F-8B10-A5E900FC3474}']
    procedure GetTargetFile(out ppWdfFile: IWDFFile); stdcall;
    procedure CancelSentRequestsForFile(const pFile: IWDFFile); stdcall;
    function FormatRequestForRead(const pRequest: IWDFIoRequest; const pFile: IWDFFile; 
                                  const pOutputMemory: IWDFMemory; 
                                  var pOutputMemoryOffset: _WDFMEMORY_OFFSET; 
                                  var DeviceOffset: Int64): HResult; stdcall;
    function FormatRequestForWrite(const pRequest: IWDFIoRequest; const pFile: IWDFFile; 
                                   const pInputMemory: IWDFMemory; 
                                   var pInputMemoryOffset: _WDFMEMORY_OFFSET; 
                                   var DeviceOffset: Int64): HResult; stdcall;
    function FormatRequestForIoctl(const pRequest: IWDFIoRequest; IoctlCode: LongWord; 
                                   const pFile: IWDFFile; const pInputMemory: IWDFMemory; 
                                   var pInputMemoryOffset: _WDFMEMORY_OFFSET; 
                                   const pOutputMemory: IWDFMemory; 
                                   var pOutputMemoryOffset: _WDFMEMORY_OFFSET): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IWDFFile
// Flags:     (512) Restricted
// GUID:      {CC8FE04B-FE8B-4245-AFD6-C31BC830C791}
// *********************************************************************//
  IWDFFile = interface(IWDFObject)
    ['{CC8FE04B-FE8B-4245-AFD6-C31BC830C791}']
    function RetrieveFileName(pFileName: PWideChar; var pdwFileNameLengthInChars: LongWord): HResult; stdcall;
    procedure GetDevice(out ppWdfDevice: IWDFDevice); stdcall;
  end;

// *********************************************************************//
// Interface: IWDFIoRequest
// Flags:     (512) Restricted
// GUID:      {896DF312-22B4-4A9D-95DD-A364AAF59769}
// *********************************************************************//
  IWDFIoRequest = interface(IWDFObject)
    ['{896DF312-22B4-4A9D-95DD-A364AAF59769}']
    procedure CompleteWithInformation(CompletionStatus: HResult; Information: ULONG_PTR); stdcall;
    procedure SetInformation(Information: ULONG_PTR); stdcall;
    procedure Complete(CompletionStatus: HResult); stdcall;
    procedure SetCompletionCallback(const pCompletionCallback: IRequestCallbackRequestCompletion; 
                                    var pContext: Pointer); stdcall;
    function GetType: _WDF_REQUEST_TYPE; stdcall;
    procedure GetCreateParameters(out pOptions: LongWord; out pFileAttributes: Word; 
                                  out pShareAccess: Word); stdcall;
    procedure GetReadParameters(out pSizeInBytes: ULONG_PTR; out pullOffset: Int64; 
                                out pulKey: LongWord); stdcall;
    procedure GetWriteParameters(out pSizeInBytes: ULONG_PTR; out pullOffset: Int64; 
                                 out pulKey: LongWord); stdcall;
    procedure GetDeviceIoControlParameters(out pControlCode: LongWord; 
                                           out pInBufferSize: ULONG_PTR; 
                                           out pOutBufferSize: ULONG_PTR); stdcall;
    procedure GetOutputMemory(out ppWdfMemory: IWDFMemory); stdcall;
    procedure GetInputMemory(out ppWdfMemory: IWDFMemory); stdcall;
    procedure MarkCancelable(const pCancelCallback: IRequestCallbackCancel); stdcall;
    function UnmarkCancelable: HResult; stdcall;
    function CancelSentRequest: Integer; stdcall;
    function ForwardToIoQueue(const pDestination: IWDFIoQueue): HResult; stdcall;
    function Send(const pIoTarget: IWDFIoTarget; Flags: LongWord; Timeout: Int64): HResult; stdcall;
    procedure GetFileObject(out ppFileObject: IWDFFile); stdcall;
    procedure FormatUsingCurrentType; stdcall;
    function GetRequestorProcessId: LongWord; stdcall;
    procedure GetIoQueue(out ppWdfIoQueue: IWDFIoQueue); stdcall;
    function Impersonate(ImpersonationLevel: _SECURITY_IMPERSONATION_LEVEL; 
                         const pCallback: IImpersonateCallback; var pvCallbackContext: Pointer): HResult; stdcall;
    function IsFrom32BitProcess: Integer; stdcall;
    procedure GetCompletionParams(out ppCompletionParams: IWDFRequestCompletionParams); stdcall;
  end;

// *********************************************************************//
// Interface: IRequestCallbackRequestCompletion
// Flags:     (512) Restricted
// GUID:      {8A7CC8CB-CEB2-46F6-9851-77BD347A15C2}
// *********************************************************************//
  IRequestCallbackRequestCompletion = interface(IUnknown)
    ['{8A7CC8CB-CEB2-46F6-9851-77BD347A15C2}']
    procedure OnCompletion(const pWdfRequest: IWDFIoRequest; const pIoTarget: IWDFIoTarget; 
                           const pParams: IWDFRequestCompletionParams; var pContext: Pointer); stdcall;
  end;

// *********************************************************************//
// Interface: IWDFRequestCompletionParams
// Flags:     (512) Restricted
// GUID:      {707A2B42-69B8-4971-A49C-4031861E7AFF}
// *********************************************************************//
  IWDFRequestCompletionParams = interface(IUnknown)
    ['{707A2B42-69B8-4971-A49C-4031861E7AFF}']
    function GetCompletionStatus: HResult; stdcall;
    function GetInformation: ULONG_PTR; stdcall;
    function GetCompletedRequestType: _WDF_REQUEST_TYPE; stdcall;
  end;

// *********************************************************************//
// Interface: IWDFMemory
// Flags:     (512) Restricted
// GUID:      {AB098F88-8F16-472A-B0BC-ECA46486C102}
// *********************************************************************//
  IWDFMemory = interface(IWDFObject)
    ['{AB098F88-8F16-472A-B0BC-ECA46486C102}']
    function CopyFromMemory(const Source: IWDFMemory; var SourceOffset: _WDFMEMORY_OFFSET): HResult; stdcall;
    function CopyToBuffer(SourceOffset: ULONG_PTR; var TargetBuffer: Pointer; 
                          NumOfBytesToCopyTo: ULONG_PTR): HResult; stdcall;
    function CopyFromBuffer(DestOffset: ULONG_PTR; var SourceBuffer: Pointer; 
                            NumOfBytesToCopyFrom: ULONG_PTR): HResult; stdcall;
    function GetSize: ULONG_PTR; stdcall;
    function GetDataBuffer(out BufferSize: ULONG_PTR): Pointer; stdcall;
    procedure SetBuffer(var Buffer: Pointer; BufferSize: ULONG_PTR); stdcall;
  end;

// *********************************************************************//
// Interface: IRequestCallbackCancel
// Flags:     (512) Restricted
// GUID:      {4E9F1A77-4587-4235-81C4-E6D24545A656}
// *********************************************************************//
  IRequestCallbackCancel = interface(IUnknown)
    ['{4E9F1A77-4587-4235-81C4-E6D24545A656}']
    procedure OnCancel(const pWdfRequest: IWDFIoRequest); stdcall;
  end;

// *********************************************************************//
// Interface: IWDFIoQueue
// Flags:     (512) Restricted
// GUID:      {AE1162B9-8B11-4714-993D-93DC48CC9E8A}
// *********************************************************************//
  IWDFIoQueue = interface(IWDFObject)
    ['{AE1162B9-8B11-4714-993D-93DC48CC9E8A}']
    procedure GetDevice(out ppWdfDevice: IWDFDevice); stdcall;
    function ConfigureRequestDispatching(RequestType: _WDF_REQUEST_TYPE; Forward: Integer): HResult; stdcall;
    function GetState(out pulNumOfRequestsInQueue: LongWord; out pulNumOfRequestsInDriver: LongWord): _WDF_IO_QUEUE_STATE; stdcall;
    function RetrieveNextRequest(out ppRequest: IWDFIoRequest): HResult; stdcall;
    function RetrieveNextRequestByFileObject(const pFile: IWDFFile; out ppRequest: IWDFIoRequest): HResult; stdcall;
    procedure Start; stdcall;
    procedure Stop(const pStopComplete: IQueueCallbackStateChange); stdcall;
    procedure StopSynchronously; stdcall;
    procedure Drain(const pDrainComplete: IQueueCallbackStateChange); stdcall;
    procedure DrainSynchronously; stdcall;
    procedure Purge(const pPurgeComplete: IQueueCallbackStateChange); stdcall;
    procedure PurgeSynchronously; stdcall;
  end;

// *********************************************************************//
// Interface: IQueueCallbackStateChange
// Flags:     (512) Restricted
// GUID:      {E7ECE381-7CB1-468A-BC43-ABD5948FFC75}
// *********************************************************************//
  IQueueCallbackStateChange = interface(IUnknown)
    ['{E7ECE381-7CB1-468A-BC43-ABD5948FFC75}']
    procedure OnStateChange(const pWdfQueue: IWDFIoQueue; QueueState: _WDF_IO_QUEUE_STATE); stdcall;
  end;

// *********************************************************************//
// Interface: IImpersonateCallback
// Flags:     (512) Restricted
// GUID:      {99B01D17-9FBD-4AA6-B16D-82DAB6A4107F}
// *********************************************************************//
  IImpersonateCallback = interface(IUnknown)
    ['{99B01D17-9FBD-4AA6-B16D-82DAB6A4107F}']
    procedure OnImpersonate(var Context: Pointer); stdcall;
  end;

// *********************************************************************//
// Interface: IWDFDriverCreatedFile
// Flags:     (512) Restricted
// GUID:      {B7615D26-494B-47A6-B4CF-0271BCC3DA4B}
// *********************************************************************//
  IWDFDriverCreatedFile = interface(IWDFFile)
    ['{B7615D26-494B-47A6-B4CF-0271BCC3DA4B}']
    procedure Close; stdcall;
  end;

// *********************************************************************//
// The Class CoWpdMtpDriver provides a Create and CreateRemote method to          
// create instances of the default interface IDriverEntry exposed by              
// the CoClass WpdMtpDriver. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWpdMtpDriver = class
    class function Create: IDriverEntry;
    class function CreateRemote(const MachineName: string): IDriverEntry;
  end;

implementation

uses ComObj;

class function CoWpdMtpDriver.Create: IDriverEntry;
begin
  Result := CreateComObject(CLASS_WpdMtpDriver) as IDriverEntry;
end;

class function CoWpdMtpDriver.CreateRemote(const MachineName: string): IDriverEntry;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WpdMtpDriver) as IDriverEntry;
end;

end.
