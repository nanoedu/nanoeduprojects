unit MLPC_API2Lib_TLB;

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
// File generated on 27.05.2011 14:56:53 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\MTP\lmt\current\MLPC_API2.tlb (1)
// LIBID: {69CF7448-D8B5-442A-B829-063403455B02}
// LCID: 0
// Helpfile: 
// HelpString: Библиотека типов MLPC_API2 1.0
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
//   (2) v1.0 NL3LFBLib, (D:\nanoeducator\nanoedudig\exe\NL3LFB.dll)
// Errors:
//   Error creating palette bitmap of (TMLabDevice) : Server D:\MTP\lmt\current\MLPC_API2.dll contains no icons
//   Error creating palette bitmap of (TMLPC_Cell) : Server D:\MTP\lmt\current\MLPC_API2.dll contains no icons
//   Error creating palette bitmap of (TMLPC_PID) : Server D:\MTP\lmt\current\MLPC_API2.dll contains no icons
//   Error creating palette bitmap of (TMLPC_VScope) : Server D:\MTP\lmt\current\MLPC_API2.dll contains no icons
//   Error creating palette bitmap of (TCellPropertyPage) : Server D:\MTP\lmt\current\MLPC_API2.dll contains no icons
//   Error creating palette bitmap of (TPIDPropertyPage) : Server D:\MTP\lmt\current\MLPC_API2.dll contains no icons
//   Error creating palette bitmap of (TVScopePropertyPage) : Server D:\MTP\lmt\current\MLPC_API2.dll contains no icons
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

uses Windows, ActiveX, Classes, Graphics, NL3LFBLib_TLB, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  MLPC_API2LibMajorVersion = 1;
  MLPC_API2LibMinorVersion = 0;

  LIBID_MLPC_API2Lib: TGUID = '{69CF7448-D8B5-442A-B829-063403455B02}';

  IID_ISchematicControl: TGUID = '{C42D151F-12D6-4468-995D-E704817228B9}';
  IID_IJavaControl: TGUID = '{8F39719F-232D-4776-B9EB-8709C65BA5F1}';
  IID_IMLabDevice: TGUID = '{6F298EEC-4D98-4437-91FF-A98AA092CC63}';
  CLASS_MLabDevice: TGUID = '{7AF2485D-21C7-4C71-A917-50AA1D30A1DB}';
  CLASS_MLPC_Cell: TGUID = '{0F8E3015-3C99-4E78-B8D4-D7C600B01999}';
  CLASS_MLPC_PID: TGUID = '{8277555D-6B1A-4A2A-9444-C3256374E354}';
  CLASS_MLPC_VScope: TGUID = '{A5B156E6-8E90-4DEC-B230-7C30C38F5A96}';
  CLASS_CellPropertyPage: TGUID = '{B682C56D-AEF8-4105-BAF0-7243E1284EAA}';
  CLASS_PIDPropertyPage: TGUID = '{0A4B955A-CFD6-43C9-AB10-A6BF96FF0023}';
  CLASS_VScopePropertyPage: TGUID = '{5295B10D-1801-4A81-9D86-9A58BD27E2FF}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISchematicControl = interface;
  IJavaControl = interface;
  IMLabDevice = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  MLabDevice = IMLabDevice;
  MLPC_Cell = ILFB;
  MLPC_PID = ILFB;
  MLPC_VScope = ILFB;
  CellPropertyPage = IUnknown;
  PIDPropertyPage = IUnknown;
  VScopePropertyPage = IUnknown;


// *********************************************************************//
// Interface: ISchematicControl
// Flags:     (0)
// GUID:      {C42D151F-12D6-4468-995D-E704817228B9}
// *********************************************************************//
  ISchematicControl = interface(IUnknown)
    ['{C42D151F-12D6-4468-995D-E704817228B9}']
    function Load(const FileName: WideString): HResult; stdcall;
    function Unload: HResult; stdcall;
    function IsLoaded(out pLoaded: WordBool): HResult; stdcall;
    function Run: HResult; stdcall;
    function IsRunning(out pRunning: WordBool): HResult; stdcall;
    function Stop: HResult; stdcall;
    function Debug(steps: Integer): HResult; stdcall;
    function EnumLFB(out ppUnk: IUnknown): HResult; stdcall;
    function QueryLFB(const Name: WideString; out ppUnk: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IJavaControl
// Flags:     (0)
// GUID:      {8F39719F-232D-4776-B9EB-8709C65BA5F1}
// *********************************************************************//
  IJavaControl = interface(IUnknown)
    ['{8F39719F-232D-4776-B9EB-8709C65BA5F1}']
    function Download(const FileName: WideString; const ObjectName: WideString): HResult; stdcall;
    function Upload(const FileName: WideString; const ObjectName: WideString): HResult; stdcall;
    function Delete(const ObjectName: WideString): HResult; stdcall;
    function Run(const ObjectName: WideString): HResult; stdcall;
    function Stop: HResult; stdcall;
    function IsRunning(out pRunning: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMLabDevice
// Flags:     (0)
// GUID:      {6F298EEC-4D98-4437-91FF-A98AA092CC63}
// *********************************************************************//
  IMLabDevice = interface(IUnknown)
    ['{6F298EEC-4D98-4437-91FF-A98AA092CC63}']
    function Connect(const path: WideString): HResult; stdcall;
    function Disconnect: HResult; stdcall;
    function get_Path(out pVal: WideString): HResult; stdcall;
    function get_Device(out ppVal: IUnknown): HResult; stdcall;
    function QuerySchematic(out ppVal: IUnknown): HResult; stdcall;
    function QueryJava(out ppVal: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoMLabDevice provides a Create and CreateRemote method to
// create instances of the default interface IMLabDevice exposed by
// the CoClass MLabDevice. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoMLabDevice = class
    class function Create: IMLabDevice;
    class function CreateRemote(const MachineName: string): IMLabDevice;
  end;




// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMLabDevice
// Help String      : MLabDevice Class
// Default Interface: IMLabDevice
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMLabDeviceProperties= class;
{$ENDIF}
  TMLabDevice = class(TOleServer)
  private
    FIntf: IMLabDevice;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMLabDeviceProperties;
    function GetServerProperties: TMLabDeviceProperties;
{$ENDIF}
    function GetDefaultInterface: IMLabDevice;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMLabDevice);
    procedure Disconnect; override;
    function Connect1(const path: WideString): HResult;
    function Disconnect1: HResult;
    function get_Path(out pVal: WideString): HResult;
    function get_Device(out ppVal: IUnknown): HResult;
    function QuerySchematic(out ppVal: IUnknown): HResult;
    function QueryJava(out ppVal: IUnknown): HResult;
    property DefaultInterface: IMLabDevice read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMLabDeviceProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}


// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMLabDevice
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMLabDeviceProperties = class(TPersistent)
  private
    FServer:    TMLabDevice;
    function    GetDefaultInterface: IMLabDevice;
    constructor Create(AServer: TMLabDevice);
  protected
  public
    property DefaultInterface: IMLabDevice read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoMLPC_Cell provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass MLPC_Cell. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMLPC_Cell = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMLPC_Cell
// Help String      : MLPC_Cell Class
// Default Interface: ILFB
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMLPC_CellProperties= class;
{$ENDIF}
  TMLPC_Cell = class(TOleServer)
  private
    FIntf: ILFB;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMLPC_CellProperties;
    function GetServerProperties: TMLPC_CellProperties;
{$ENDIF}
    function GetDefaultInterface: ILFB;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ILFB);
    procedure Disconnect; override;
    procedure Create1(const Parameters: IEnumUnknown; const DPU: IEnumUnknown);
    procedure Delete;
    procedure get_Parameters(const pCol: ICollectionUnknown);
    procedure Initialize;
    procedure EnumFE(out ppenum: IEnumUnknown);
    procedure get_Name(out pVal: WideString);
    procedure put_Name(const Value: WideString);
    procedure get_Nets(out pNets: Integer; out pCount: Integer);
    procedure get_ParentLFB(out ppUnk: IUnknown);
    procedure put_ParentLFB(const pUnk: IUnknown);
    procedure put_NamesDB(const Names: INamesDB);
    procedure get_Type(out pType: Integer);
    procedure PrepareDynamicConfiguration;
    procedure MakeDynamicConfiguration(const pstm: IStream);
    property DefaultInterface: ILFB read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMLPC_CellProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMLPC_Cell
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMLPC_CellProperties = class(TPersistent)
  private
    FServer:    TMLPC_Cell;
    function    GetDefaultInterface: ILFB;
    constructor Create(AServer: TMLPC_Cell);
  protected
  public
    property DefaultInterface: ILFB read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoMLPC_PID provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass MLPC_PID. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMLPC_PID = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMLPC_PID
// Help String      : MLPC_PID Class
// Default Interface: ILFB
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMLPC_PIDProperties= class;
{$ENDIF}
  TMLPC_PID = class(TOleServer)
  private
    FIntf: ILFB;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMLPC_PIDProperties;
    function GetServerProperties: TMLPC_PIDProperties;
{$ENDIF}
    function GetDefaultInterface: ILFB;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ILFB);
    procedure Disconnect; override;
    procedure Create1(const Parameters: IEnumUnknown; const DPU: IEnumUnknown);
    procedure Delete;
    procedure get_Parameters(const pCol: ICollectionUnknown);
    procedure Initialize;
    procedure EnumFE(out ppenum: IEnumUnknown);
    procedure get_Name(out pVal: WideString);
    procedure put_Name(const Value: WideString);
    procedure get_Nets(out pNets: Integer; out pCount: Integer);
    procedure get_ParentLFB(out ppUnk: IUnknown);
    procedure put_ParentLFB(const pUnk: IUnknown);
    procedure put_NamesDB(const Names: INamesDB);
    procedure get_Type(out pType: Integer);
    procedure PrepareDynamicConfiguration;
    procedure MakeDynamicConfiguration(const pstm: IStream);
    property DefaultInterface: ILFB read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMLPC_PIDProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMLPC_PID
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMLPC_PIDProperties = class(TPersistent)
  private
    FServer:    TMLPC_PID;
    function    GetDefaultInterface: ILFB;
    constructor Create(AServer: TMLPC_PID);
  protected
  public
    property DefaultInterface: ILFB read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoMLPC_VScope provides a Create and CreateRemote method to          
// create instances of the default interface ILFB exposed by              
// the CoClass MLPC_VScope. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMLPC_VScope = class
    class function Create: ILFB;
    class function CreateRemote(const MachineName: string): ILFB;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMLPC_VScope
// Help String      : MLPC_VScope Class
// Default Interface: ILFB
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMLPC_VScopeProperties= class;
{$ENDIF}
  TMLPC_VScope = class(TOleServer)
  private
    FIntf: ILFB;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMLPC_VScopeProperties;
    function GetServerProperties: TMLPC_VScopeProperties;
{$ENDIF}
    function GetDefaultInterface: ILFB;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ILFB);
    procedure Disconnect; override;
    procedure Create1(const Parameters: IEnumUnknown; const DPU: IEnumUnknown);
    procedure Delete;
    procedure get_Parameters(const pCol: ICollectionUnknown);
    procedure Initialize;
    procedure EnumFE(out ppenum: IEnumUnknown);
    procedure get_Name(out pVal: WideString);
    procedure put_Name(const Value: WideString);
    procedure get_Nets(out pNets: Integer; out pCount: Integer);
    procedure get_ParentLFB(out ppUnk: IUnknown);
    procedure put_ParentLFB(const pUnk: IUnknown);
    procedure put_NamesDB(const Names: INamesDB);
    procedure get_Type(out pType: Integer);
    procedure PrepareDynamicConfiguration;
    procedure MakeDynamicConfiguration(const pstm: IStream);
    property DefaultInterface: ILFB read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMLPC_VScopeProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMLPC_VScope
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMLPC_VScopeProperties = class(TPersistent)
  private
    FServer:    TMLPC_VScope;
    function    GetDefaultInterface: ILFB;
    constructor Create(AServer: TMLPC_VScope);
  protected
  public
    property DefaultInterface: ILFB read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoCellPropertyPage provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass CellPropertyPage. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCellPropertyPage = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCellPropertyPage
// Help String      : CellPropertyPage Class
// Default Interface: IUnknown
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCellPropertyPageProperties= class;
{$ENDIF}
  TCellPropertyPage = class(TOleServer)
  private
    FIntf: IUnknown;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TCellPropertyPageProperties;
    function GetServerProperties: TCellPropertyPageProperties;
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
    property Server: TCellPropertyPageProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCellPropertyPage
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCellPropertyPageProperties = class(TPersistent)
  private
    FServer:    TCellPropertyPage;
    function    GetDefaultInterface: IUnknown;
    constructor Create(AServer: TCellPropertyPage);
  protected
  public
    property DefaultInterface: IUnknown read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoPIDPropertyPage provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass PIDPropertyPage. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPIDPropertyPage = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPIDPropertyPage
// Help String      : PIDPropertyPage Class
// Default Interface: IUnknown
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPIDPropertyPageProperties= class;
{$ENDIF}
  TPIDPropertyPage = class(TOleServer)
  private
    FIntf: IUnknown;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TPIDPropertyPageProperties;
    function GetServerProperties: TPIDPropertyPageProperties;
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
    property Server: TPIDPropertyPageProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPIDPropertyPage
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPIDPropertyPageProperties = class(TPersistent)
  private
    FServer:    TPIDPropertyPage;
    function    GetDefaultInterface: IUnknown;
    constructor Create(AServer: TPIDPropertyPage);
  protected
  public
    property DefaultInterface: IUnknown read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoVScopePropertyPage provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass VScopePropertyPage. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVScopePropertyPage = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TVScopePropertyPage
// Help String      : VScopePropertyPage Class
// Default Interface: IUnknown
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TVScopePropertyPageProperties= class;
{$ENDIF}
  TVScopePropertyPage = class(TOleServer)
  private
    FIntf: IUnknown;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TVScopePropertyPageProperties;
    function GetServerProperties: TVScopePropertyPageProperties;
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
    property Server: TVScopePropertyPageProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TVScopePropertyPage
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TVScopePropertyPageProperties = class(TPersistent)
  private
    FServer:    TVScopePropertyPage;
    function    GetDefaultInterface: IUnknown;
    constructor Create(AServer: TVScopePropertyPage);
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

class function CoMLabDevice.Create: IMLabDevice;
begin
  Result := CreateComObject(CLASS_MLabDevice) as IMLabDevice;
end;

class function CoMLabDevice.CreateRemote(const MachineName: string): IMLabDevice;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MLabDevice) as IMLabDevice;
end;


procedure TMLabDevice.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{7AF2485D-21C7-4C71-A917-50AA1D30A1DB}';
    IntfIID:   '{6F298EEC-4D98-4437-91FF-A98AA092CC63}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMLabDevice.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMLabDevice;
  end;
end;

procedure TMLabDevice.ConnectTo(svrIntf: IMLabDevice);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMLabDevice.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMLabDevice.GetDefaultInterface: IMLabDevice;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMLabDevice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMLabDeviceProperties.Create(Self);
{$ENDIF}
end;

destructor TMLabDevice.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMLabDevice.GetServerProperties: TMLabDeviceProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TMLabDevice.Connect1(const path: WideString): HResult;
begin
  Result := DefaultInterface.Connect(path);
end;

function TMLabDevice.Disconnect1: HResult;
begin
  Result := DefaultInterface.Disconnect;
end;

function TMLabDevice.get_Path(out pVal: WideString): HResult;
begin
  Result := DefaultInterface.get_Path(pVal);
end;

function TMLabDevice.get_Device(out ppVal: IUnknown): HResult;
begin
  Result := DefaultInterface.get_Device(ppVal);
end;

function TMLabDevice.QuerySchematic(out ppVal: IUnknown): HResult;
begin
  Result := DefaultInterface.QuerySchematic(ppVal);
end;

function TMLabDevice.QueryJava(out ppVal: IUnknown): HResult;
begin
  Result := DefaultInterface.QueryJava(ppVal);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMLabDeviceProperties.Create(AServer: TMLabDevice);
begin
  inherited Create;
  FServer := AServer;
end;

function TMLabDeviceProperties.GetDefaultInterface: IMLabDevice;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoMLPC_Cell.Create: ILFB;
begin
  Result := CreateComObject(CLASS_MLPC_Cell) as ILFB;
end;

class function CoMLPC_Cell.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MLPC_Cell) as ILFB;
end;

procedure TMLPC_Cell.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0F8E3015-3C99-4E78-B8D4-D7C600B01999}';
    IntfIID:   '{3F251803-14C1-42FC-BB0A-E7BECC719E72}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMLPC_Cell.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ILFB;
  end;
end;

procedure TMLPC_Cell.ConnectTo(svrIntf: ILFB);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMLPC_Cell.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMLPC_Cell.GetDefaultInterface: ILFB;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMLPC_Cell.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMLPC_CellProperties.Create(Self);
{$ENDIF}
end;

destructor TMLPC_Cell.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMLPC_Cell.GetServerProperties: TMLPC_CellProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMLPC_Cell.Create1(const Parameters: IEnumUnknown; const DPU: IEnumUnknown);
begin
  DefaultInterface.Create(Parameters, DPU);
end;

procedure TMLPC_Cell.Delete;
begin
  DefaultInterface.Delete;
end;

procedure TMLPC_Cell.get_Parameters(const pCol: ICollectionUnknown);
begin
  DefaultInterface.get_Parameters(pCol);
end;

procedure TMLPC_Cell.Initialize;
begin
  DefaultInterface.Initialize;
end;

procedure TMLPC_Cell.EnumFE(out ppenum: IEnumUnknown);
begin
  DefaultInterface.EnumFE(ppenum);
end;

procedure TMLPC_Cell.get_Name(out pVal: WideString);
begin
  DefaultInterface.get_Name(pVal);
end;

procedure TMLPC_Cell.put_Name(const Value: WideString);
begin
  DefaultInterface.put_Name(Value);
end;

procedure TMLPC_Cell.get_Nets(out pNets: Integer; out pCount: Integer);
begin
  DefaultInterface.get_Nets(pNets, pCount);
end;

procedure TMLPC_Cell.get_ParentLFB(out ppUnk: IUnknown);
begin
  DefaultInterface.get_ParentLFB(ppUnk);
end;

procedure TMLPC_Cell.put_ParentLFB(const pUnk: IUnknown);
begin
  DefaultInterface.put_ParentLFB(pUnk);
end;

procedure TMLPC_Cell.put_NamesDB(const Names: INamesDB);
begin
  DefaultInterface.put_NamesDB(Names);
end;

procedure TMLPC_Cell.get_Type(out pType: Integer);
begin
  DefaultInterface.get_Type(pType);
end;

procedure TMLPC_Cell.PrepareDynamicConfiguration;
begin
  DefaultInterface.PrepareDynamicConfiguration;
end;

procedure TMLPC_Cell.MakeDynamicConfiguration(const pstm: IStream);
begin
  DefaultInterface.MakeDynamicConfiguration(pstm);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMLPC_CellProperties.Create(AServer: TMLPC_Cell);
begin
  inherited Create;
  FServer := AServer;
end;

function TMLPC_CellProperties.GetDefaultInterface: ILFB;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoMLPC_PID.Create: ILFB;
begin
  Result := CreateComObject(CLASS_MLPC_PID) as ILFB;
end;

class function CoMLPC_PID.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MLPC_PID) as ILFB;
end;

procedure TMLPC_PID.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{8277555D-6B1A-4A2A-9444-C3256374E354}';
    IntfIID:   '{3F251803-14C1-42FC-BB0A-E7BECC719E72}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMLPC_PID.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ILFB;
  end;
end;

procedure TMLPC_PID.ConnectTo(svrIntf: ILFB);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMLPC_PID.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMLPC_PID.GetDefaultInterface: ILFB;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMLPC_PID.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMLPC_PIDProperties.Create(Self);
{$ENDIF}
end;

destructor TMLPC_PID.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMLPC_PID.GetServerProperties: TMLPC_PIDProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMLPC_PID.Create1(const Parameters: IEnumUnknown; const DPU: IEnumUnknown);
begin
  DefaultInterface.Create(Parameters, DPU);
end;

procedure TMLPC_PID.Delete;
begin
  DefaultInterface.Delete;
end;

procedure TMLPC_PID.get_Parameters(const pCol: ICollectionUnknown);
begin
  DefaultInterface.get_Parameters(pCol);
end;

procedure TMLPC_PID.Initialize;
begin
  DefaultInterface.Initialize;
end;

procedure TMLPC_PID.EnumFE(out ppenum: IEnumUnknown);
begin
  DefaultInterface.EnumFE(ppenum);
end;

procedure TMLPC_PID.get_Name(out pVal: WideString);
begin
  DefaultInterface.get_Name(pVal);
end;

procedure TMLPC_PID.put_Name(const Value: WideString);
begin
  DefaultInterface.put_Name(Value);
end;

procedure TMLPC_PID.get_Nets(out pNets: Integer; out pCount: Integer);
begin
  DefaultInterface.get_Nets(pNets, pCount);
end;

procedure TMLPC_PID.get_ParentLFB(out ppUnk: IUnknown);
begin
  DefaultInterface.get_ParentLFB(ppUnk);
end;

procedure TMLPC_PID.put_ParentLFB(const pUnk: IUnknown);
begin
  DefaultInterface.put_ParentLFB(pUnk);
end;

procedure TMLPC_PID.put_NamesDB(const Names: INamesDB);
begin
  DefaultInterface.put_NamesDB(Names);
end;

procedure TMLPC_PID.get_Type(out pType: Integer);
begin
  DefaultInterface.get_Type(pType);
end;

procedure TMLPC_PID.PrepareDynamicConfiguration;
begin
  DefaultInterface.PrepareDynamicConfiguration;
end;

procedure TMLPC_PID.MakeDynamicConfiguration(const pstm: IStream);
begin
  DefaultInterface.MakeDynamicConfiguration(pstm);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMLPC_PIDProperties.Create(AServer: TMLPC_PID);
begin
  inherited Create;
  FServer := AServer;
end;

function TMLPC_PIDProperties.GetDefaultInterface: ILFB;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoMLPC_VScope.Create: ILFB;
begin
  Result := CreateComObject(CLASS_MLPC_VScope) as ILFB;
end;

class function CoMLPC_VScope.CreateRemote(const MachineName: string): ILFB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MLPC_VScope) as ILFB;
end;

procedure TMLPC_VScope.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{A5B156E6-8E90-4DEC-B230-7C30C38F5A96}';
    IntfIID:   '{3F251803-14C1-42FC-BB0A-E7BECC719E72}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMLPC_VScope.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ILFB;
  end;
end;

procedure TMLPC_VScope.ConnectTo(svrIntf: ILFB);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMLPC_VScope.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMLPC_VScope.GetDefaultInterface: ILFB;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMLPC_VScope.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMLPC_VScopeProperties.Create(Self);
{$ENDIF}
end;

destructor TMLPC_VScope.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMLPC_VScope.GetServerProperties: TMLPC_VScopeProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMLPC_VScope.Create1(const Parameters: IEnumUnknown; const DPU: IEnumUnknown);
begin
  DefaultInterface.Create(Parameters, DPU);
end;

procedure TMLPC_VScope.Delete;
begin
  DefaultInterface.Delete;
end;

procedure TMLPC_VScope.get_Parameters(const pCol: ICollectionUnknown);
begin
  DefaultInterface.get_Parameters(pCol);
end;

procedure TMLPC_VScope.Initialize;
begin
  DefaultInterface.Initialize;
end;

procedure TMLPC_VScope.EnumFE(out ppenum: IEnumUnknown);
begin
  DefaultInterface.EnumFE(ppenum);
end;

procedure TMLPC_VScope.get_Name(out pVal: WideString);
begin
  DefaultInterface.get_Name(pVal);
end;

procedure TMLPC_VScope.put_Name(const Value: WideString);
begin
  DefaultInterface.put_Name(Value);
end;

procedure TMLPC_VScope.get_Nets(out pNets: Integer; out pCount: Integer);
begin
  DefaultInterface.get_Nets(pNets, pCount);
end;

procedure TMLPC_VScope.get_ParentLFB(out ppUnk: IUnknown);
begin
  DefaultInterface.get_ParentLFB(ppUnk);
end;

procedure TMLPC_VScope.put_ParentLFB(const pUnk: IUnknown);
begin
  DefaultInterface.put_ParentLFB(pUnk);
end;

procedure TMLPC_VScope.put_NamesDB(const Names: INamesDB);
begin
  DefaultInterface.put_NamesDB(Names);
end;

procedure TMLPC_VScope.get_Type(out pType: Integer);
begin
  DefaultInterface.get_Type(pType);
end;

procedure TMLPC_VScope.PrepareDynamicConfiguration;
begin
  DefaultInterface.PrepareDynamicConfiguration;
end;

procedure TMLPC_VScope.MakeDynamicConfiguration(const pstm: IStream);
begin
  DefaultInterface.MakeDynamicConfiguration(pstm);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMLPC_VScopeProperties.Create(AServer: TMLPC_VScope);
begin
  inherited Create;
  FServer := AServer;
end;

function TMLPC_VScopeProperties.GetDefaultInterface: ILFB;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoCellPropertyPage.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_CellPropertyPage) as IUnknown;
end;

class function CoCellPropertyPage.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CellPropertyPage) as IUnknown;
end;

procedure TCellPropertyPage.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{B682C56D-AEF8-4105-BAF0-7243E1284EAA}';
    IntfIID:   '{00000000-0000-0000-C000-000000000046}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCellPropertyPage.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IUnknown;
  end;
end;

procedure TCellPropertyPage.ConnectTo(svrIntf: IUnknown);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCellPropertyPage.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCellPropertyPage.GetDefaultInterface: IUnknown;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TCellPropertyPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCellPropertyPageProperties.Create(Self);
{$ENDIF}
end;

destructor TCellPropertyPage.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCellPropertyPage.GetServerProperties: TCellPropertyPageProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCellPropertyPageProperties.Create(AServer: TCellPropertyPage);
begin
  inherited Create;
  FServer := AServer;
end;

function TCellPropertyPageProperties.GetDefaultInterface: IUnknown;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoPIDPropertyPage.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_PIDPropertyPage) as IUnknown;
end;

class function CoPIDPropertyPage.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PIDPropertyPage) as IUnknown;
end;

procedure TPIDPropertyPage.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0A4B955A-CFD6-43C9-AB10-A6BF96FF0023}';
    IntfIID:   '{00000000-0000-0000-C000-000000000046}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPIDPropertyPage.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IUnknown;
  end;
end;

procedure TPIDPropertyPage.ConnectTo(svrIntf: IUnknown);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TPIDPropertyPage.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TPIDPropertyPage.GetDefaultInterface: IUnknown;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TPIDPropertyPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPIDPropertyPageProperties.Create(Self);
{$ENDIF}
end;

destructor TPIDPropertyPage.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPIDPropertyPage.GetServerProperties: TPIDPropertyPageProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPIDPropertyPageProperties.Create(AServer: TPIDPropertyPage);
begin
  inherited Create;
  FServer := AServer;
end;

function TPIDPropertyPageProperties.GetDefaultInterface: IUnknown;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoVScopePropertyPage.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_VScopePropertyPage) as IUnknown;
end;

class function CoVScopePropertyPage.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VScopePropertyPage) as IUnknown;
end;

procedure TVScopePropertyPage.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{5295B10D-1801-4A81-9D86-9A58BD27E2FF}';
    IntfIID:   '{00000000-0000-0000-C000-000000000046}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TVScopePropertyPage.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IUnknown;
  end;
end;

procedure TVScopePropertyPage.ConnectTo(svrIntf: IUnknown);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TVScopePropertyPage.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TVScopePropertyPage.GetDefaultInterface: IUnknown;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TVScopePropertyPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TVScopePropertyPageProperties.Create(Self);
{$ENDIF}
end;

destructor TVScopePropertyPage.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TVScopePropertyPage.GetServerProperties: TVScopePropertyPageProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TVScopePropertyPageProperties.Create(AServer: TVScopePropertyPage);
begin
  inherited Create;
  FServer := AServer;
end;

function TVScopePropertyPageProperties.GetDefaultInterface: IUnknown;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TMLabDevice, TMLPC_Cell, TMLPC_PID, TMLPC_VScope, 
    TCellPropertyPage, TPIDPropertyPage, TVScopePropertyPage]);
end;

end.
