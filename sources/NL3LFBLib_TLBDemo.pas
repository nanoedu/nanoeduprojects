unit NL3LFBLib_TLBDemo;

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

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants,NL3LFBLib_TLB;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  IID_INamesDBDemo: TGUID = '{CF7D2B91-AE79-4BDF-932B-E4AF4006DD80}';
  IID_ICollectionUnknown: TGUID = '{C2D360E7-5E97-4407-B5D0-FAAAB62C25EF}';
  IID_ILFBdemo: TGUID = '{470BF1AA-62CD-412C-B88D-34030F123C97}';
//  CLASS_LFB_CELLDemo: TGUID = '{D7FC60C0-0AA0-40CF-9C47-1D549B2CA2B8}';
//  CLASS_LFB_PID: TGUID = '{80FB6EF7-FFD7-482E-9DFF-21FEA259870A}';
  IID_ILFB_CELLDEmo: TGUID = '{C05BD2ED-B36F-4316-BE25-CD72679C07FC}';
  IID_ILFB_PIDDemo: TGUID = '{893D2511-0DC4-4132-AE1A-087E8140624C}';

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  ILFBDemo = interface;
  ILFB_CELLDemo = interface;
  INamesDBDEmo = interface;
  ICollectionUnknownDemo = interface;
  ILFB_PIDDemo = interface;
// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  LFB_CELLDemo = ILFBDemo;
  LFB_PIDDEmo = ILFBDemo;
  // *********************************************************************//
// Interface: INamesDB
// Flags:     (0)
// GUID:      {63FDEE4E-FA5E-4CAE-A7A4-4BC82B9D4CEE}
// *********************************************************************//
  INamesDBDemo = interface(INamesDB)
['{CF7D2B91-AE79-4BDF-932B-E4AF4006DD80}']
    function AddName(const Name: WideString; CaseSensitive: WordBool; out pIndex: Integer): HResult; stdcall;
    function EnumNames(out pNames: IEnumVARIANT): HResult; stdcall;
    function get_Count(out pCount: Integer): HResult; stdcall;
  end;
   TNamesDBDemo =  Class(TInterfacedObject,INamesDB)
    function AddName(const Name: WideString; CaseSensitive: WordBool; out pIndex: Integer): HResult; stdcall;
    function EnumNames(out pNames: IEnumVARIANT): HResult; stdcall;
    function get_Count(out pCount: Integer): HResult; stdcall;
  end;
 // *********************************************************************//
// Interface: ICollectionUnknown
// Flags:     (0)
// GUID:      {DDB0DB40-77A5-46BC-916C-53DC3A3EA13F}
// *********************************************************************//
  ICollectionUnknownDemo = interface(ICollectionUnknown)
   ['{C2D360E7-5E97-4407-B5D0-FAAAB62C25EF}']
    function Add(const pUnk: IUnknown): HResult; stdcall;
    function get_Count(out pVal: Integer): HResult; stdcall;
  end;
  TCollectionUnknownDemo =Class(TInterfacedObject,ICollectionUnknown)
    function Add(const pUnk: IUnknown): HResult; stdcall;
    function get_Count(out pVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ILFB
// Flags:     (448) Dual NonExtensible OleAutomation
// GUID:      {3F251803-14C1-42FC-BB0A-E7BECC719E72}
// *********************************************************************//
  ILFBDemo = interface(ILFB)
    ['{470BF1AA-62CD-412C-B88D-34030F123C97}']
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
    procedure put_NamesDB(const Names: INamesDBDemo); safecall;
    procedure get_Type(out pType: Integer); safecall;
    procedure PrepareDynamicConfiguration; safecall;
    procedure MakeDynamicConfiguration(const pstm: IStream); safecall;
  end;

  TLFBDemo = Class(TInterfacedObject,ILFB)
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
// Interface: ILFB_CELL
// Flags:     (320) Dual OleAutomation
// GUID:      {4C6B03BA-274C-4FF7-B9AA-E1F21F38FE8B}
// *********************************************************************//
  ILFB_CELLDemo = interface(ILFB_CELL)
    ['{C05BD2ED-B36F-4316-BE25-CD72679C07FC}']
    procedure Read(out pVal: OleVariant); safecall;
    procedure Write(Value: OleVariant); safecall;
    procedure ReadEx(out pVal: OleVariant; out pAttr: Integer); safecall;
    procedure WriteEx(Value: OleVariant; Attr: Integer); safecall;
  end;
  TLFB_CELLDemo =  Class(TInterfacedObject,ILFB_CELL)
    procedure Read(out pVal: OleVariant); safecall;
    procedure Write(Value: OleVariant); safecall;
    procedure ReadEx(out pVal: OleVariant; out pAttr: Integer); safecall;
    procedure WriteEx(Value: OleVariant; Attr: Integer); safecall;
  end;

   ILFB_PIDDemo = interface(ILFB_PID)
 ['{893D2511-0DC4-4132-AE1A-087E8140624C}']
    procedure Write(dt: Integer; Te: Double; Td: Double; Ti: Double); safecall;
  end;
   TLFB_PIDDemo =  Class(TInterfacedObject, ILFB_PIDDemo)
    procedure Write(dt: Integer; Te: Double; Td: Double; Ti: Double); safecall;
  end;
// *********************************************************************//
// The Class CoLFB_CELL provides a Create and CreateRemote method to
// create instances of the default interface ILFB exposed by
// the CoClass LFB_CELL. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoLFB_CELLDemo = class
    class function Create: ILFBDemo;
  end;

implementation

uses ComObj;

  function TNamesDBDemo.AddName(const Name: WideString; CaseSensitive: WordBool; out pIndex: Integer): HResult; stdcall;
   begin
    result:=S_OK;
    end;
  function TNamesDBDemo.EnumNames(out pNames: IEnumVARIANT): HResult; stdcall;
  begin
   result:=S_OK;
   end;
  function TNamesDBDemo.get_Count(out pCount: Integer): HResult; stdcall;
     begin
      result:=S_OK;
     end;
 //
    function TCollectionUnknownDemo.Add(const pUnk: IUnknown): HResult; stdcall;
     begin
      result:=S_OK;
     end;
    function TCollectionUnknownDemo.get_Count(out pVal: Integer): HResult; stdcall;
     begin
      result:=S_OK;
     end;

 //
    procedure TLFBDemo.Create(const Parameters: IEnumUnknown; const DPU: IEnumUnknown); safecall;
     begin

     end;
    procedure TLFBDemo.Delete; safecall;
     begin
     end;
    procedure TLFBDemo.get_Parameters(const pCol: ICollectionUnknown); safecall;
     begin
     end;
    procedure TLFBDemo.Initialize; safecall;
     begin
     end;
    procedure TLFBDemo.EnumFE(out ppenum: IEnumUnknown); safecall;
     begin
     end;
    procedure TLFBDemo.get_Name(out pVal: WideString); safecall;
     begin
     end;
    procedure TLFBDemo.put_Name(const Value: WideString); safecall;
     begin
     end;
    procedure TLFBDemo.get_Nets(out pNets: Integer; out pCount: Integer); safecall;
     begin
     end;
    procedure TLFBDemo.get_ParentLFB(out ppUnk: IUnknown); safecall;
     begin
     end;
    procedure TLFBDemo.put_ParentLFB(const pUnk: IUnknown); safecall;
     begin
     end;
    procedure TLFBDemo.put_NamesDB(const Names: INamesDB); safecall;
     begin
     end;
    procedure TLFBDemo.get_Type(out pType: Integer); safecall;
     begin
     end;
    procedure TLFBDemo.PrepareDynamicConfiguration; safecall;
     begin
     end;
    procedure TLFBDemo.MakeDynamicConfiguration(const pstm: IStream); safecall;
    begin
    end;

//
    procedure TLFB_CELLDemo.Read(out pVal: OleVariant); safecall;
    begin

    end;
    procedure TLFB_CELLDemo.Write(Value: OleVariant); safecall;
    begin

    end;
    procedure TLFB_CELLDemo.ReadEx(out pVal: OleVariant; out pAttr: Integer); safecall;
    begin

    end;
    procedure TLFB_CELLDemo.WriteEx(Value: OleVariant; Attr: Integer); safecall;
    begin
    
    end;
//
    procedure  TLFB_PIDDemo.Write(dt: Integer; Te: Double; Td: Double; Ti: Double); safecall;
    begin

    end;

class function CoLFB_CELLDemo.Create: ILFBDemo;
begin
  Result :=TLFB_CELLDemo.Create as ILFBDemo;
end;

end.
