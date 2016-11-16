unit HHOPENLib_TLB;

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

// PASTLWTR : $Revision:   1.88  $
// File generated on 13.06.02 16:44:49 from Type Library described below.

// ************************************************************************ //
// Type Lib: C:\WINDOWS\SYSTEM\HHOPEN.OCX (1)
// IID\LCID: {130D7740-5F5A-11D1-B676-00A0C9697233}\0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\STDVCL40.DLL)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  HHOPENLibMajorVersion = 1;
  HHOPENLibMinorVersion = 0;

  LIBID_HHOPENLib: TGUID = '{130D7740-5F5A-11D1-B676-00A0C9697233}';

  DIID__DHhopen: TGUID = '{130D7741-5F5A-11D1-B676-00A0C9697233}';
  DIID__DHhopenEvents: TGUID = '{130D7742-5F5A-11D1-B676-00A0C9697233}';
  CLASS_Hhopen: TGUID = '{130D7743-5F5A-11D1-B676-00A0C9697233}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DHhopen = dispinterface;
  _DHhopenEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Hhopen = _DHhopen;


// *********************************************************************//
// DispIntf:  _DHhopen
// Flags:     (4112) Hidden Dispatchable
// GUID:      {130D7741-5F5A-11D1-B676-00A0C9697233}
// *********************************************************************//
  _DHhopen = dispinterface
    ['{130D7741-5F5A-11D1-B676-00A0C9697233}']
    property isHelpOpened: WordBool dispid 1;
    function  OpenHelp(const HelpFile: WideString; const HelpSection: WideString): Integer; dispid 2;
    procedure CloseHelp; dispid 3;
  end;

// *********************************************************************//
// DispIntf:  _DHhopenEvents
// Flags:     (4096) Dispatchable
// GUID:      {130D7742-5F5A-11D1-B676-00A0C9697233}
// *********************************************************************//
  _DHhopenEvents = dispinterface
    ['{130D7742-5F5A-11D1-B676-00A0C9697233}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : THhopen
// Help String      : Hhopen Control
// Default Interface: _DHhopen
// Def. Intf. DISP? : Yes
// Event   Interface: _DHhopenEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  THhopen = class(TOleControl)
  private
    FIntf: _DHhopen;
    function  GetControlInterface: _DHhopen;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function  OpenHelp(const HelpFile: WideString; const HelpSection: WideString): Integer;
    procedure CloseHelp;
    property  ControlInterface: _DHhopen read GetControlInterface;
    property  DefaultInterface: _DHhopen read GetControlInterface;
  published
    property isHelpOpened: WordBool index 1 read GetWordBoolProp write SetWordBoolProp stored False;
  end;

procedure Register;

implementation

uses ComObj;

procedure THhopen.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{130D7743-5F5A-11D1-B676-00A0C9697233}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure THhopen.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DHhopen;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function THhopen.GetControlInterface: _DHhopen;
begin
  CreateControl;
  Result := FIntf;
end;

function  THhopen.OpenHelp(const HelpFile: WideString; const HelpSection: WideString): Integer;
begin
  Result := DefaultInterface.OpenHelp(HelpFile, HelpSection);
end;

procedure THhopen.CloseHelp;
begin
  DefaultInterface.CloseHelp;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[THhopen]);
end;

end.
