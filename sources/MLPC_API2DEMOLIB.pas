unit MLPC_API2DEMOLIB;

interface
//uses Windows,Classes,ActiveX, OleServer,,Variants;
uses Windows, ActiveX, Classes, Graphics, MLPC_API2Lib_TLB, NL3LFBLib_TLBDemo, OleServer, StdVCL, Variants;
const
 CLASS_MLabDeviceDemo: TGUID ='{491AD2AA-4F94-4333-9300-DF7AD1BD60BD}';
 IID_IMLabDeviceDEmo: TGUID = '{ECF11323-F729-4658-A9FA-9995EF494CC0}';
 IID_ISchematicControlDemo: TGUID ='{11A71B1F-16E9-4DC6-91F3-9BF7F99D4A18}';
 IID_IJavaControlDemo: TGUID = '{4D5F8CF6-87D2-4198-B085-E128E55207F6}';


type
 IMLabDeviceDemo = interface;
 ISchematicControlDemo = interface;
 IJavaControlDemo = interface;

 IMLabDeviceDemo=interface(IMLabDevice)
   ['{ECF11323-F729-4658-A9FA-9995EF494CC0}']
    function Connect(const path: WideString): HResult; stdcall;
    function Disconnect: HResult; stdcall;
    function get_Path(out pVal: WideString): HResult; stdcall;
    function get_Device(out ppVal: IUnknown): HResult; stdcall;
    function QuerySchematic(out ppVal: IUnknown): HResult; stdcall;
    function QueryJava(out ppVal: IUnknown): HResult; stdcall;
  end;

// MLabDeviceDemo = IMLabDeviceDemo;

 TMLabDeviceDemo = Class(TInterfacedObject,IMLabDeviceDemo)
    function Connect(const path: WideString): HResult; stdcall;
    function Disconnect: HResult; stdcall;
    function get_Path(out pVal: WideString): HResult; stdcall;
    function get_Device(out ppVal: IUnknown): HResult; stdcall;
    function QuerySchematic(out ppVal: IUnknown): HResult; stdcall;
    function QueryJava(out ppVal: IUnknown): HResult; stdcall;
  end;

 IJavaControlDemo = interface(IJavaControl)
   ['{4D5F8CF6-87D2-4198-B085-E128E55207F6}']
    function Download(const FileName: WideString; const ObjectName: WideString): HResult; stdcall;
    function Upload(const FileName: WideString; const ObjectName: WideString): HResult; stdcall;
    function Delete(const ObjectName: WideString): HResult; stdcall;
    function Run(const ObjectName: WideString): HResult; stdcall;
    function Stop: HResult; stdcall;
    function IsRunning(out pRunning: WordBool): HResult; stdcall;
  end;

  TJavaControlDemo = class(TInterfacedObject, IJavaControlDemo)
    function Download(const FileName: WideString; const ObjectName: WideString): HResult; stdcall;
    function Upload(const FileName: WideString; const ObjectName: WideString): HResult; stdcall;
    function Delete(const ObjectName: WideString): HResult; stdcall;
    function Run(const ObjectName: WideString): HResult; stdcall;
    function Stop: HResult; stdcall;
    function IsRunning(out pRunning: WordBool): HResult; stdcall;
  end;

 ISchematicControlDemo = interface(ISchematicControl)
  ['{11A71B1F-16E9-4DC6-91F3-9BF7F99D4A18}']
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

 TSchematicControlDemo = class(TInterfacedObject,ISchematicControlDemo)
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

   CoMLabDeviceDemo = class
    class function Create: IMLabDeviceDemo;
  end;
   procedure Register;

implementation
 uses ComObj;

  class function CoMLabDeviceDemo.Create: IMLabDeviceDemo;
begin
  Result :=TMLabDeviceDemo.Create as IMLabDeviceDemo;
end;


function TMLabDeviceDemo.get_Device(out ppVal: IUnknown): HResult;
begin
 //  ppVal:=
   result:=S_OK;
end;
function TMLabDeviceDemo.Connect(const path: WideString): HResult;
begin
  result:=S_OK;
end;
 function TMLabDeviceDemo.Disconnect: HResult;
 begin
  result:=S_OK;
 end;
 function TMLabDeviceDemo.QuerySchematic(out ppVal: IUnknown): HResult;
 begin
  ppVal:=TSchematicControlDemo.Create as  ISchematicControlDemo;
  result:=S_OK;
 end;
 function  TMLabDeviceDemo.get_Path(out pVal: WideString): HResult;
 begin
  result:=S_OK;
 end;
 function TMLabDeviceDemo.QueryJava(out ppVal: IUnknown): HResult;
 begin
  ppVal:=TJavaControlDemo.Create as IJavaControlDemo;
  result:=S_OK;
 end;

 function TJavaControlDemo.Download(const FileName: WideString; const ObjectName: WideString): HResult;
 BEGIN
   result:=S_OK;
 END;
 function TJavaControlDemo.Upload(const FileName: WideString; const ObjectName: WideString): HResult;
 BEGIN
    result:=S_OK;
 END;
 function TJavaControlDemo.Delete(const ObjectName: WideString): HResult;
 begin
   result:=S_OK;
 end;
 function TJavaControlDemo.Run(const ObjectName: WideString): HResult;
 begin
   result:=S_OK;
 end;
 function TJavaControlDemo.Stop: HResult;
 begin
    result:=S_OK;
 end;
 function TJavaControlDemo.IsRunning(out pRunning: WordBool): HResult;
 begin
   result:=S_OK;
 end;
////schematic demo
 function TSchematicControlDemo.Load(const FileName: WideString): HResult; stdcall;
 begin
   result:=S_OK;
 end;
 function TSchematicControlDemo.Unload: HResult; stdcall;
 begin
   result:=S_OK;
 end;
  function TSchematicControlDemo.IsLoaded(out pLoaded: WordBool): HResult; stdcall;
  begin
   pLoaded:=true;
   result:=S_OK;
 end;
    function TSchematicControlDemo.Run: HResult; stdcall;
  begin
   result:=S_OK;
 end;
    function TSchematicControlDemo.IsRunning(out pRunning: WordBool): HResult; stdcall;
  begin
   pRunning:=true;
   result:=S_OK;
 end;
    function TSchematicControlDemo.Stop: HResult; stdcall;
  begin
   result:=S_OK;
 end;
    function TSchematicControlDemo.Debug(steps: Integer): HResult; stdcall;
  begin
   result:=S_OK;
 end;
    function TSchematicControlDemo.EnumLFB(out ppUnk: IUnknown): HResult; stdcall;
  begin
   result:=S_OK;
 end;
 function TSchematicControlDemo.QueryLFB(const Name: WideString; out ppUnk: IUnknown): HResult; stdcall;
var Parameters: IEnumUnknown;
    DPU: IEnumUnknown;
  begin
  if WideString('pid')='pid' then  ppUnk:= TLFB_PIDDemo.Create as  ILFB_PIDDemo;
//                             else  ppUnk:= TLFBDemo.Create(Parameters,DPU) as  ILFBDemo;
   result:=S_OK;
 end;


 procedure Register;
begin
 // RegisterComponents(dtlServerPage, [TMLabDeviceDEmo]);
end;

end.
