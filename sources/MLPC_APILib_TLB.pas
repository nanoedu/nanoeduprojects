unit MLPC_APILib_TLB;

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
// File generated on 01.06.2011 16:25:57 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\MTP\lmt\current\MLPC_API.tlb (1)
// LIBID: {2E66CF4C-4320-49F3-85D6-63B657CA995A}
// LCID: 0
// Helpfile: 
// HelpString: Библиотека типов MLPC_API 1.0
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// Errors:
//   Error creating palette bitmap of (TMLPCConnect) : Server D:\MTP\lmt\current\MLPC_API.dll contains no icons
//   Error creating palette bitmap of (TMTPIO) : Server D:\MTP\lmt\current\MLPC_API.dll contains no icons
//   Error creating palette bitmap of (TMLPCChannelManager) : Server D:\MTP\lmt\current\MLPC_API.dll contains no icons
//   Error creating palette bitmap of (TMLPCChannel) : Server D:\MTP\lmt\current\MLPC_API.dll contains no icons
//   Error creating palette bitmap of (TVScopeProxy) : Server D:\MTP\lmt\current\MLPC_API.dll contains no icons
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
  MLPC_APILibMajorVersion = 1;
  MLPC_APILibMinorVersion = 0;

  LIBID_MLPC_APILib: TGUID = '{2E66CF4C-4320-49F3-85D6-63B657CA995A}';

  IID_IMLPCChannelRead: TGUID = '{33AEC2A8-CB49-4249-B2A1-0599FFF87962}';
  IID_IMLPCChannelRead2: TGUID = '{7A630BCA-EA01-43BD-8C24-608B27C5BEA7}';
  IID_IMLPCChannelWrite: TGUID = '{FBDB2868-EF6E-472A-A372-1F19C053E97A}';
  IID_IMLPCChannelWrite2: TGUID = '{07485649-5D89-45B3-8D44-C354A3F6F1CC}';
  IID_IMLPCChannelManager: TGUID = '{14B9E1E1-B881-4263-B7EE-AF361D0CD92D}';
  IID_IMLPCChannelManager2: TGUID = '{AB3E67F1-CCF8-4112-8E10-5E1AB89C26EE}';
  IID_IDeviceProxy: TGUID = '{14ED1ABA-84AB-4D74-BB5C-6B62551D3C76}';
  IID_IDeviceInfo: TGUID = '{7DA29717-3960-443D-AAE9-93DAF93ADF63}';
  IID_IDeviceChannelsInfo: TGUID = '{B74558AF-F063-4BE2-B8AE-1FAA1BE51CBC}';
  IID_IMLPCErrorControl: TGUID = '{1A3B25B0-397B-4924-8C39-7BF3048397FF}';
  IID_IMLPCConnect: TGUID = '{3D27E12E-38C4-4720-AFAF-80B320C459F8}';
  CLASS_MLPCConnect: TGUID = '{802D5EB9-1939-49C1-9298-4064904A0E8A}';
  IID_IMTPIO: TGUID = '{970CCC7B-BBAD-474E-9D18-2DA3989B233B}';
  CLASS_MTPIO: TGUID = '{3CCFFE01-A1F0-40BC-BF22-233DAC519453}';
  DIID__IMLPCChannelManagerEvents: TGUID = '{91D7D7AE-3812-44DA-8FF8-72D450F14963}';
  CLASS_MLPCChannelManager: TGUID = '{1D07F1B6-216E-4221-9AB7-A55820271589}';
  DIID__IMLPCChannelEvents: TGUID = '{435A0ADA-5B98-4623-A6C1-36C125010E7D}';
  IID_IMLPCChannel: TGUID = '{523DCD28-01D1-4D47-9C44-7278D0DC2A23}';
  CLASS_MLPCChannel: TGUID = '{2D0BEB9F-5433-4F67-9B58-ABC231ED808D}';
  CLASS_VScopeProxy: TGUID = '{896A4034-0F7A-457B-94FA-1CCEEFE9C900}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IMLPCChannelRead = interface;
  IMLPCChannelRead2 = interface;
  IMLPCChannelWrite = interface;
  IMLPCChannelWrite2 = interface;
  IMLPCChannelManager = interface;
  IMLPCChannelManager2 = interface;
  IDeviceProxy = interface;
  IDeviceInfo = interface;
  IDeviceChannelsInfo = interface;
  IMLPCErrorControl = interface;
  IMLPCConnect = interface;
  IMTPIO = interface;
  _IMLPCChannelManagerEvents = dispinterface;
  _IMLPCChannelEvents = dispinterface;
  IMLPCChannel = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  MLPCConnect = IMLPCConnect;
  MTPIO = IMTPIO;
  MLPCChannelManager = IMLPCChannelManager;
  MLPCChannel = IMLPCChannel;
  VScopeProxy = IUnknown;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PInteger1 = ^Integer; {*}
  PUINT1 = ^LongWord; {*}
  PByte1 = ^Byte; {*}


// *********************************************************************//
// Interface: IMLPCChannelRead
// Flags:     (0)
// GUID:      {33AEC2A8-CB49-4249-B2A1-0599FFF87962}
// *********************************************************************//
  IMLPCChannelRead = interface(IUnknown)
    ['{33AEC2A8-CB49-4249-B2A1-0599FFF87962}']
    function Read( Data: PInteger; var pCount: Integer): HResult; stdcall;
    function get_Count(out pN: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMLPCChannelRead2
// Flags:     (0)
// GUID:      {7A630BCA-EA01-43BD-8C24-608B27C5BEA7}
// *********************************************************************//
  IMLPCChannelRead2 = interface(IMLPCChannelRead)
    ['{7A630BCA-EA01-43BD-8C24-608B27C5BEA7}']
    function ReadWait(Data: PInteger; var pCount: Integer; Timeout: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMLPCChannelWrite
// Flags:     (0)
// GUID:      {FBDB2868-EF6E-472A-A372-1F19C053E97A}
// *********************************************************************//
  IMLPCChannelWrite = interface(IUnknown)
    ['{FBDB2868-EF6E-472A-A372-1F19C053E97A}']
    function Write(Data: pInteger; var pCount: Integer): HResult; stdcall;
    function get_Count(out pN: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMLPCChannelWrite2
// Flags:     (0)
// GUID:      {07485649-5D89-45B3-8D44-C354A3F6F1CC}
// *********************************************************************//
  IMLPCChannelWrite2 = interface(IMLPCChannelWrite)
    ['{07485649-5D89-45B3-8D44-C354A3F6F1CC}']
    function WriteWait( Data: PInteger; var pCount: Integer; Timeout: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMLPCChannelManager
// Flags:     (0)
// GUID:      {14B9E1E1-B881-4263-B7EE-AF361D0CD92D}
// *********************************************************************//
  IMLPCChannelManager = interface(IUnknown)
    ['{14B9E1E1-B881-4263-B7EE-AF361D0CD92D}']
    function Connect(const pUnk: IUnknown): HResult; stdcall;
    function Disconnect: HResult; stdcall;
    function EnumChannels(out ppUnk: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMLPCChannelManager2
// Flags:     (0)
// GUID:      {AB3E67F1-CCF8-4112-8E10-5E1AB89C26EE}
// *********************************************************************//
  IMLPCChannelManager2 = interface(IMLPCChannelManager)
    ['{AB3E67F1-CCF8-4112-8E10-5E1AB89C26EE}']
    function WaitChannel(id: Integer; Timeout: Integer; out ppUnk: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDeviceProxy
// Flags:     (0)
// GUID:      {14ED1ABA-84AB-4D74-BB5C-6B62551D3C76}
// *********************************************************************//
  IDeviceProxy = interface(IUnknown)
    ['{14ED1ABA-84AB-4D74-BB5C-6B62551D3C76}']
    function Connect(out pConnected: LongWord): HResult; stdcall;
    function IsConnected(out pConnected: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDeviceInfo
// Flags:     (0)
// GUID:      {7DA29717-3960-443D-AAE9-93DAF93ADF63}
// *********************************************************************//
  IDeviceInfo = interface(IUnknown)
    ['{7DA29717-3960-443D-AAE9-93DAF93ADF63}']
    function GetDirtyFormat(out pFmtBytesJunk: LongWord; out pFmtBytesData: LongWord): HResult; stdcall;
    function GetDevicePath(out pPathBSTR: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDeviceChannelsInfo
// Flags:     (0)
// GUID:      {B74558AF-F063-4BE2-B8AE-1FAA1BE51CBC}
// *********************************************************************//
  IDeviceChannelsInfo = interface(IUnknown)
    ['{B74558AF-F063-4BE2-B8AE-1FAA1BE51CBC}']
    function SetChannelBits(index: SYSUINT; bits: SYSUINT): HResult; stdcall;
    function UpdateChannelBits: HResult; stdcall;
    function GetCount(out pCount: SYSUINT): HResult; stdcall;
    function GetChannelCid(index: SYSUINT; out pCid: Integer): HResult; stdcall;
    function GetChannelName(index: SYSUINT; out pName: WideString): HResult; stdcall;
    function GetChannelBits(index: SYSUINT; out pBits: SYSUINT): HResult; stdcall;
    function GetChannelRange(index: SYSUINT; out pMin: Single; out pMax: Single): HResult; stdcall;
    function GetChannelUnits(index: SYSUINT; out pName: WideString): HResult; stdcall;
    function Lock: HResult; stdcall;
    function Unlock: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMLPCErrorControl
// Flags:     (0)
// GUID:      {1A3B25B0-397B-4924-8C39-7BF3048397FF}
// *********************************************************************//
  IMLPCErrorControl = interface(IUnknown)
    ['{1A3B25B0-397B-4924-8C39-7BF3048397FF}']
    function get_ErrorMode(out pMode: Integer): HResult; stdcall;
    function put_ErrorMode(Mode: Integer): HResult; stdcall;
    function get_ErrorString(hresult: Integer; out description: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMLPCConnect
// Flags:     (0)
// GUID:      {3D27E12E-38C4-4720-AFAF-80B320C459F8}
// *********************************************************************//
  IMLPCConnect = interface(IUnknown)
    ['{3D27E12E-38C4-4720-AFAF-80B320C459F8}']
    function Connect(out ppUnk: IUnknown): HResult; stdcall;
    function get_Path(out pPath: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMTPIO
// Flags:     (0)
// GUID:      {970CCC7B-BBAD-474E-9D18-2DA3989B233B}
// *********************************************************************//
  IMTPIO = interface(IUnknown)
    ['{970CCC7B-BBAD-474E-9D18-2DA3989B233B}']
    function Connect(const pUnk: IUnknown): HResult; stdcall;
    function Disconnect: HResult; stdcall;
    function SendCommand(operation: LongWord; var param: LongWord; pCount: LongWord; 
                         out res: LongWord; rcount: LongWord): HResult; stdcall;
    function SendCommandWrite(operation: LongWord; var param: LongWord; pCount: LongWord; 
                              var buf: Byte; size: LongWord; out pcnt: LongWord; out res: LongWord; 
                              rcount: LongWord): HResult; stdcall;
    function SendCommandRead(operation: LongWord; var param: LongWord; pCount: LongWord; 
                             out pbuf: PByte1; out psize: LongWord; out res: LongWord; 
                             rcount: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  _IMLPCChannelManagerEvents
// Flags:     (4096) Dispatchable
// GUID:      {91D7D7AE-3812-44DA-8FF8-72D450F14963}
// *********************************************************************//
  _IMLPCChannelManagerEvents = dispinterface
    ['{91D7D7AE-3812-44DA-8FF8-72D450F14963}']
    procedure OnListUpdate; dispid 1;
  end;

// *********************************************************************//
// DispIntf:  _IMLPCChannelEvents
// Flags:     (4096) Dispatchable
// GUID:      {435A0ADA-5B98-4623-A6C1-36C125010E7D}
// *********************************************************************//
  _IMLPCChannelEvents = dispinterface
    ['{435A0ADA-5B98-4623-A6C1-36C125010E7D}']
    procedure OnUpdate; dispid 1;
  end;

// *********************************************************************//
// Interface: IMLPCChannel
// Flags:     (0)
// GUID:      {523DCD28-01D1-4D47-9C44-7278D0DC2A23}
// *********************************************************************//
  IMLPCChannel = interface(IUnknown)
    ['{523DCD28-01D1-4D47-9C44-7278D0DC2A23}']
    function get_Geometry(out pN: Integer; out pW: Integer): HResult; stdcall;
    function get_Name(out pName: WideString): HResult; stdcall;
    function get_ID(out pID: Integer): HResult; stdcall;
    function Disconnect: HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoMLPCConnect provides a Create and CreateRemote method to          
// create instances of the default interface IMLPCConnect exposed by              
// the CoClass MLPCConnect. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMLPCConnect = class
    class function Create: IMLPCConnect;
    class function CreateRemote(const MachineName: string): IMLPCConnect;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMLPCConnect
// Help String      : MLPCConnect Class
// Default Interface: IMLPCConnect
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMLPCConnectProperties= class;
{$ENDIF}
  TMLPCConnect = class(TOleServer)
  private
    FIntf: IMLPCConnect;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMLPCConnectProperties;
    function GetServerProperties: TMLPCConnectProperties;
{$ENDIF}
    function GetDefaultInterface: IMLPCConnect;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMLPCConnect);
    procedure Disconnect; override;
    function Connect1(out ppUnk: IUnknown): HResult;
    function get_Path(out pPath: WideString): HResult;
    property DefaultInterface: IMLPCConnect read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMLPCConnectProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMLPCConnect
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMLPCConnectProperties = class(TPersistent)
  private
    FServer:    TMLPCConnect;
    function    GetDefaultInterface: IMLPCConnect;
    constructor Create(AServer: TMLPCConnect);
  protected
  public
    property DefaultInterface: IMLPCConnect read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoMTPIO provides a Create and CreateRemote method to          
// create instances of the default interface IMTPIO exposed by              
// the CoClass MTPIO. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMTPIO = class
    class function Create: IMTPIO;
    class function CreateRemote(const MachineName: string): IMTPIO;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMTPIO
// Help String      : MTPIO Class
// Default Interface: IMTPIO
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMTPIOProperties= class;
{$ENDIF}
  TMTPIO = class(TOleServer)
  private
    FIntf: IMTPIO;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMTPIOProperties;
    function GetServerProperties: TMTPIOProperties;
{$ENDIF}
    function GetDefaultInterface: IMTPIO;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMTPIO);
    procedure Disconnect; override;
    function Connect1(const pUnk: IUnknown): HResult;
    function Disconnect1: HResult;
    function SendCommand(operation: LongWord; var param: LongWord; pCount: LongWord; 
                         out res: LongWord; rcount: LongWord): HResult;
    function SendCommandWrite(operation: LongWord; var param: LongWord; pCount: LongWord; 
                              var buf: Byte; size: LongWord; out pcnt: LongWord; out res: LongWord; 
                              rcount: LongWord): HResult;
    function SendCommandRead(operation: LongWord; var param: LongWord; pCount: LongWord; 
                             out pbuf: PByte1; out psize: LongWord; out res: LongWord; 
                             rcount: LongWord): HResult;
    property DefaultInterface: IMTPIO read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMTPIOProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMTPIO
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMTPIOProperties = class(TPersistent)
  private
    FServer:    TMTPIO;
    function    GetDefaultInterface: IMTPIO;
    constructor Create(AServer: TMTPIO);
  protected
  public
    property DefaultInterface: IMTPIO read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoMLPCChannelManager provides a Create and CreateRemote method to          
// create instances of the default interface IMLPCChannelManager exposed by              
// the CoClass MLPCChannelManager. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMLPCChannelManager = class
    class function Create: IMLPCChannelManager;
    class function CreateRemote(const MachineName: string): IMLPCChannelManager;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMLPCChannelManager
// Help String      : MLPCChannelManager Class
// Default Interface: IMLPCChannelManager
// Def. Intf. DISP? : No
// Event   Interface: _IMLPCChannelManagerEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMLPCChannelManagerProperties= class;
{$ENDIF}
  TMLPCChannelManager = class(TOleServer)
  private
    FOnListUpdate: TNotifyEvent;
    FIntf: IMLPCChannelManager;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMLPCChannelManagerProperties;
    function GetServerProperties: TMLPCChannelManagerProperties;
{$ENDIF}
    function GetDefaultInterface: IMLPCChannelManager;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMLPCChannelManager);
    procedure Disconnect; override;
    function Connect1(const pUnk: IUnknown): HResult;
    function Disconnect1: HResult;
    function EnumChannels(out ppUnk: IUnknown): HResult;
    property DefaultInterface: IMLPCChannelManager read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMLPCChannelManagerProperties read GetServerProperties;
{$ENDIF}
    property OnListUpdate: TNotifyEvent read FOnListUpdate write FOnListUpdate;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMLPCChannelManager
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMLPCChannelManagerProperties = class(TPersistent)
  private
    FServer:    TMLPCChannelManager;
    function    GetDefaultInterface: IMLPCChannelManager;
    constructor Create(AServer: TMLPCChannelManager);
  protected
  public
    property DefaultInterface: IMLPCChannelManager read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoMLPCChannel provides a Create and CreateRemote method to          
// create instances of the default interface IMLPCChannel exposed by              
// the CoClass MLPCChannel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMLPCChannel = class
    class function Create: IMLPCChannel;
    class function CreateRemote(const MachineName: string): IMLPCChannel;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMLPCChannel
// Help String      : MLPCChannel Class
// Default Interface: IMLPCChannel
// Def. Intf. DISP? : No
// Event   Interface: _IMLPCChannelEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMLPCChannelProperties= class;
{$ENDIF}
  TMLPCChannel = class(TOleServer)
  private
    FOnUpdate: TNotifyEvent;
    FIntf: IMLPCChannel;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMLPCChannelProperties;
    function GetServerProperties: TMLPCChannelProperties;
{$ENDIF}
    function GetDefaultInterface: IMLPCChannel;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMLPCChannel);
    procedure Disconnect; override;
    function get_Geometry(out pN: Integer; out pW: Integer): HResult;
    function get_Name(out pName: WideString): HResult;
    function get_ID(out pID: Integer): HResult;
    function Disconnect1: HResult;
    property DefaultInterface: IMLPCChannel read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMLPCChannelProperties read GetServerProperties;
{$ENDIF}
    property OnUpdate: TNotifyEvent read FOnUpdate write FOnUpdate;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMLPCChannel
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMLPCChannelProperties = class(TPersistent)
  private
    FServer:    TMLPCChannel;
    function    GetDefaultInterface: IMLPCChannel;
    constructor Create(AServer: TMLPCChannel);
  protected
  public
    property DefaultInterface: IMLPCChannel read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoVScopeProxy provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass VScopeProxy. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVScopeProxy = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TVScopeProxy
// Help String      : VScopeProxy Class
// Default Interface: IUnknown
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TVScopeProxyProperties= class;
{$ENDIF}
  TVScopeProxy = class(TOleServer)
  private
    FIntf: IUnknown;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TVScopeProxyProperties;
    function GetServerProperties: TVScopeProxyProperties;
{$ENDIF}
    function GetDefaultInterface: IUnknown;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IUnknown);
    procedure Disconnect; override;
    property DefaultInterface: IUnknown read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TVScopeProxyProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TVScopeProxy
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TVScopeProxyProperties = class(TPersistent)
  private
    FServer:    TVScopeProxy;
    function    GetDefaultInterface: IUnknown;
    constructor Create(AServer: TVScopeProxy);
  protected
  public
    property DefaultInterface: IUnknown read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoMLPCConnect.Create: IMLPCConnect;
begin
  Result := CreateComObject(CLASS_MLPCConnect) as IMLPCConnect;
end;

class function CoMLPCConnect.CreateRemote(const MachineName: string): IMLPCConnect;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MLPCConnect) as IMLPCConnect;
end;

procedure TMLPCConnect.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{802D5EB9-1939-49C1-9298-4064904A0E8A}';
    IntfIID:   '{3D27E12E-38C4-4720-AFAF-80B320C459F8}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMLPCConnect.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMLPCConnect;
  end;
end;

procedure TMLPCConnect.ConnectTo(svrIntf: IMLPCConnect);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMLPCConnect.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMLPCConnect.GetDefaultInterface: IMLPCConnect;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMLPCConnect.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMLPCConnectProperties.Create(Self);
{$ENDIF}
end;

destructor TMLPCConnect.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMLPCConnect.GetServerProperties: TMLPCConnectProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TMLPCConnect.Connect1(out ppUnk: IUnknown): HResult;
begin
  Result := DefaultInterface.Connect(ppUnk);
end;

function TMLPCConnect.get_Path(out pPath: WideString): HResult;
begin
  Result := DefaultInterface.get_Path(pPath);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMLPCConnectProperties.Create(AServer: TMLPCConnect);
begin
  inherited Create;
  FServer := AServer;
end;

function TMLPCConnectProperties.GetDefaultInterface: IMLPCConnect;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoMTPIO.Create: IMTPIO;
begin
  Result := CreateComObject(CLASS_MTPIO) as IMTPIO;
end;

class function CoMTPIO.CreateRemote(const MachineName: string): IMTPIO;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MTPIO) as IMTPIO;
end;

procedure TMTPIO.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{3CCFFE01-A1F0-40BC-BF22-233DAC519453}';
    IntfIID:   '{970CCC7B-BBAD-474E-9D18-2DA3989B233B}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMTPIO.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMTPIO;
  end;
end;

procedure TMTPIO.ConnectTo(svrIntf: IMTPIO);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMTPIO.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMTPIO.GetDefaultInterface: IMTPIO;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMTPIO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMTPIOProperties.Create(Self);
{$ENDIF}
end;

destructor TMTPIO.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMTPIO.GetServerProperties: TMTPIOProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TMTPIO.Connect1(const pUnk: IUnknown): HResult;
begin
  Result := DefaultInterface.Connect(pUnk);
end;

function TMTPIO.Disconnect1: HResult;
begin
  Result := DefaultInterface.Disconnect;
end;

function TMTPIO.SendCommand(operation: LongWord; var param: LongWord; pCount: LongWord; 
                            out res: LongWord; rcount: LongWord): HResult;
begin
  Result := DefaultInterface.SendCommand(operation, param, pCount, res, rcount);
end;

function TMTPIO.SendCommandWrite(operation: LongWord; var param: LongWord; pCount: LongWord; 
                                 var buf: Byte; size: LongWord; out pcnt: LongWord; 
                                 out res: LongWord; rcount: LongWord): HResult;
begin
  Result := DefaultInterface.SendCommandWrite(operation, param, pCount, buf, size, pcnt, res, rcount);
end;

function TMTPIO.SendCommandRead(operation: LongWord; var param: LongWord; pCount: LongWord; 
                                out pbuf: PByte1; out psize: LongWord; out res: LongWord; 
                                rcount: LongWord): HResult;
begin
  Result := DefaultInterface.SendCommandRead(operation, param, pCount, pbuf, psize, res, rcount);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMTPIOProperties.Create(AServer: TMTPIO);
begin
  inherited Create;
  FServer := AServer;
end;

function TMTPIOProperties.GetDefaultInterface: IMTPIO;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoMLPCChannelManager.Create: IMLPCChannelManager;
begin
  Result := CreateComObject(CLASS_MLPCChannelManager) as IMLPCChannelManager;
end;

class function CoMLPCChannelManager.CreateRemote(const MachineName: string): IMLPCChannelManager;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MLPCChannelManager) as IMLPCChannelManager;
end;

procedure TMLPCChannelManager.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{1D07F1B6-216E-4221-9AB7-A55820271589}';
    IntfIID:   '{14B9E1E1-B881-4263-B7EE-AF361D0CD92D}';
    EventIID:  '{91D7D7AE-3812-44DA-8FF8-72D450F14963}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMLPCChannelManager.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IMLPCChannelManager;
  end;
end;

procedure TMLPCChannelManager.ConnectTo(svrIntf: IMLPCChannelManager);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TMLPCChannelManager.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TMLPCChannelManager.GetDefaultInterface: IMLPCChannelManager;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMLPCChannelManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMLPCChannelManagerProperties.Create(Self);
{$ENDIF}
end;

destructor TMLPCChannelManager.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMLPCChannelManager.GetServerProperties: TMLPCChannelManagerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMLPCChannelManager.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnListUpdate) then
         FOnListUpdate(Self);
  end; {case DispID}
end;

function TMLPCChannelManager.Connect1(const pUnk: IUnknown): HResult;
begin
  Result := DefaultInterface.Connect(pUnk);
end;

function TMLPCChannelManager.Disconnect1: HResult;
begin
  Result := DefaultInterface.Disconnect;
end;

function TMLPCChannelManager.EnumChannels(out ppUnk: IUnknown): HResult;
begin
  Result := DefaultInterface.EnumChannels(ppUnk);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMLPCChannelManagerProperties.Create(AServer: TMLPCChannelManager);
begin
  inherited Create;
  FServer := AServer;
end;

function TMLPCChannelManagerProperties.GetDefaultInterface: IMLPCChannelManager;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoMLPCChannel.Create: IMLPCChannel;
begin
  Result := CreateComObject(CLASS_MLPCChannel) as IMLPCChannel;
end;

class function CoMLPCChannel.CreateRemote(const MachineName: string): IMLPCChannel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MLPCChannel) as IMLPCChannel;
end;

procedure TMLPCChannel.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2D0BEB9F-5433-4F67-9B58-ABC231ED808D}';
    IntfIID:   '{523DCD28-01D1-4D47-9C44-7278D0DC2A23}';
    EventIID:  '{435A0ADA-5B98-4623-A6C1-36C125010E7D}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMLPCChannel.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IMLPCChannel;
  end;
end;

procedure TMLPCChannel.ConnectTo(svrIntf: IMLPCChannel);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TMLPCChannel.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TMLPCChannel.GetDefaultInterface: IMLPCChannel;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMLPCChannel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMLPCChannelProperties.Create(Self);
{$ENDIF}
end;

destructor TMLPCChannel.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMLPCChannel.GetServerProperties: TMLPCChannelProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMLPCChannel.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnUpdate) then
         FOnUpdate(Self);
  end; {case DispID}
end;

function TMLPCChannel.get_Geometry(out pN: Integer; out pW: Integer): HResult;
begin
  Result := DefaultInterface.get_Geometry(pN, pW);
end;

function TMLPCChannel.get_Name(out pName: WideString): HResult;
begin
  Result := DefaultInterface.get_Name(pName);
end;

function TMLPCChannel.get_ID(out pID: Integer): HResult;
begin
  Result := DefaultInterface.get_ID(pID);
end;

function TMLPCChannel.Disconnect1: HResult;
begin
  Result := DefaultInterface.Disconnect;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMLPCChannelProperties.Create(AServer: TMLPCChannel);
begin
  inherited Create;
  FServer := AServer;
end;

function TMLPCChannelProperties.GetDefaultInterface: IMLPCChannel;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoVScopeProxy.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_VScopeProxy) as IUnknown;
end;

class function CoVScopeProxy.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VScopeProxy) as IUnknown;
end;

procedure TVScopeProxy.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{896A4034-0F7A-457B-94FA-1CCEEFE9C900}';
    IntfIID:   '{00000000-0000-0000-C000-000000000046}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TVScopeProxy.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IUnknown;
  end;
end;

procedure TVScopeProxy.ConnectTo(svrIntf: IUnknown);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TVScopeProxy.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TVScopeProxy.GetDefaultInterface: IUnknown;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TVScopeProxy.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TVScopeProxyProperties.Create(Self);
{$ENDIF}
end;

destructor TVScopeProxy.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TVScopeProxy.GetServerProperties: TVScopeProxyProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TVScopeProxyProperties.Create(AServer: TVScopeProxy);
begin
  inherited Create;
  FServer := AServer;
end;

function TVScopeProxyProperties.GetDefaultInterface: IUnknown;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TMLPCConnect, TMTPIO, TMLPCChannelManager, TMLPCChannel, 
    TVScopeProxy]);
end;

end.
