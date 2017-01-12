unit MLPC_APILib_Demo;     //280113

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
// HelpString: Ѕиблиотека типов MLPC_API 1.0
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

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants,MLPC_APILib_TLB,  frDebug,SysUtils;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//

const
  IID_IMLPCChannelReadDemo: TGUID =     '{C6491F2D-0F11-49CA-B63C-5D573A40B55D}';
  IID_IMLPCChannelRead2Demo: TGUID =    '{3D997BF1-722A-4FE8-BEFC-A4FBE12F8A56}';
  IID_IMLPCChannelWriteDemo: TGUID =    '{A42F1DE0-F264-44D5-8D6C-B80CE3858540}';
  IID_IMLPCChannelWrite2Demo: TGUID =   '{51BD238A-651D-46A0-8E62-04CA14A948C9}';
  IID_IMLPCChannelManagerDemo: TGUID =  '{B6B65D31-C187-43BC-81FA-F16BEDE4BA03}';
  IID_IMLPCChannelManager2Demo: TGUID = '{E2A35B62-1FD9-4946-ADC1-812B86643920}';
  IID_IMLPCChannelDemo: TGUID =         '{22262A2F-589D-4C56-AE8C-3B265F5B42B3}';

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IMLPCChannelReadDemo = interface;
  IMLPCChannelRead2Demo = interface;
  IMLPCChannelWriteDemo = interface;
//  IMLPCChannelWrite2Demo = interface;
  IMLPCChannelManagerDemo = interface;
  IMLPCChannelManager2Demo = interface;
  IMLPCChannelDemo = interface;

//  MLPCChannelManagerDemo = IMLPCChannelManagerDemo;
//  MLPCChannelDEmo = IMLPCChannelDEmo;
  PInteger1 = ^Integer; {*}
  PUINT1 = ^LongWord; {*}
  PByte1 = ^Byte; {*}

 IMLPCChannelReadDemo = interface(IMLPCChannelRead)
   ['{C6491F2D-0F11-49CA-B63C-5D573A40B55D}']
    function Read( Data: PInteger; var pCount: Integer): HResult; stdcall;
    function get_Count(out pN: Integer): HResult; stdcall;
  end;
  TMLPCChannelReadDemo =class(TInterfacedObject,IMLPCChannelReadDemo)
    function Read( Data: PInteger; var pCount: Integer): HResult; stdcall;
    function get_Count(out pN: Integer): HResult; stdcall;
    constructor Create(DataBufIn:pinteger; iSizeElements,iNElements:integer);
   public
    fcount:integer;
    fDataBufin:Pinteger;
    fSizeElements:integer;
    fNElements:integer;
    fPATH_SPDDemo:integer;
  end;
  IMLPCChannelRead2Demo = interface(IMLPCChannelRead2)
   ['{3D997BF1-722A-4FE8-BEFC-A4FBE12F8A56}']
   function Read( Data: PInteger; var pCount: Integer): HResult; stdcall;
    function get_Count(out pN: Integer): HResult; stdcall;
    function ReadWait(Data: PInteger; var pCount: Integer; Timeout: Integer): HResult; stdcall;
   end;
  TMLPCChannelRead2Demo = class(TInterfacedObject,IMLPCChannelRead2Demo)
    function    Read( Data: PInteger; var pCount: Integer): HResult; stdcall;
   function    get_Count(out pN: Integer): HResult; stdcall;
    function    ReadWait(Data: PInteger; var pCount: Integer; Timeout: Integer): HResult; stdcall;
    constructor Create(DataBufIn:pinteger; iSizeElements,iNElements:integer);
  public
    fcount:integer;
    fDataBufin:Pinteger;
    fSizeElements:integer;
    fNElements:integer;
    fPATH_SPDDemo:integer;
  end;

  IMLPCChannelWriteDemo = interface(IMLPCChannelWrite)
  ['{A42F1DE0-F264-44D5-8D6C-B80CE3858540}']
    function Write(Data: pInteger; var pCount: Integer): HResult; stdcall;
    function get_Count(out pN: Integer): HResult; stdcall;
  end;

  TMLPCChannelWriteDemo =class(TInterfacedObject,IMLPCChannelWriteDemo)
    function Write(Data: pInteger; var pCount: Integer): HResult; stdcall;
    function get_Count(out pN: Integer): HResult; stdcall;
  end;

   IMLPCChannelWrite2Demo = interface(IMLPCChannelWrite2)
    ['{51BD238A-651D-46A0-8E62-04CA14A948C9}']
    function WriteWait( Data: PInteger; var pCount: Integer; Timeout: Integer): HResult; stdcall;
  end;

  TMLPCChannelWrite2Demo = interface(IMLPCChannelWrite2Demo)
    ['{07485649-5D89-45B3-8D44-C354A3F6F1CC}']
    function Write(Data: pInteger; var pCount: Integer): HResult; stdcall;
    function get_Count(out pN: Integer): HResult; stdcall;
    function WriteWait( Data: PInteger; var pCount: Integer; Timeout: Integer): HResult; stdcall;
  end;

  IMLPCChannelManagerDemo = interface(IMLPCChannelManager)
    ['{B6B65D31-C187-43BC-81FA-F16BEDE4BA03}']
    function Connect(const pUnk: IUnknown): HResult; stdcall;
    function Disconnect: HResult; stdcall;
    function EnumChannels(out ppUnk: IUnknown): HResult; stdcall;
  end;
  TMLPCChannelManagerDemo = class(TInterfacedObject,IMLPCChannelManagerDemo)
    function Connect(const pUnk: IUnknown): HResult; stdcall;
    function Disconnect: HResult; stdcall;
    function EnumChannels(out ppUnk: IUnknown): HResult; stdcall;
  end;

  IMLPCChannelManager2Demo = interface(IMLPCChannelManager2)
    ['{E2A35B62-1FD9-4946-ADC1-812B86643920}']
    function Connect(const pUnk: IUnknown): HResult; stdcall;
    function Disconnect: HResult; stdcall;
    function EnumChannels(out ppUnk: IUnknown): HResult; stdcall;
    function WaitChannel(id: Integer; Timeout: Integer; out ppUnk: IUnknown): HResult; stdcall;
  end;
  TMLPCChannelManager2Demo =class(TInterfacedObject,IMLPCChannelManager2Demo)
    function Connect(const pUnk: IUnknown): HResult; stdcall;
    function Disconnect: HResult; stdcall;
    function EnumChannels(out ppUnk: IUnknown): HResult; stdcall;
    function WaitChannel(id: Integer; Timeout: Integer; out ppUnk: IUnknown): HResult; stdcall;
  end;

  IMLPCChannelDemo = interface(IMLPCChannel)
    ['{22262A2F-589D-4C56-AE8C-3B265F5B42B3}']
    function get_Geometry(out pN: Integer; out pW: Integer): HResult; stdcall;
    function get_Name(out pName: WideString): HResult; stdcall;
    function get_ID(out pID: Integer): HResult; stdcall;
    function Disconnect: HResult; stdcall;
  end;
  TMLPCChannelDemo =class(TInterfacedObject,IMLPCChannelDemo)
   private
    fid:integer;
    fNElement:integer;
    fSizeElement:integer;
    function get_Geometry(out pN: Integer; out pW: Integer): HResult; stdcall;
    function get_Name(out pName: WideString): HResult; stdcall;
    function get_ID(out pID: Integer): HResult; stdcall;
    function Disconnect: HResult; stdcall;
   public
   property ID:integer  read  fID write fID;
   property NElements:integer     read  fNElement   write fNElement;
   property SizeELements:integer  read fSizeElement write fSizeElement;
  end;

  CoMLPCChannelManagerDemo = class
    class function Create: IMLPCChannelManagerDemo;
  end;
  CoMLPCChannelDemo = class
    class function Create: IMLPCChannelDemo;
  end;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj,CSPMVar;

constructor TMLPCChannelRead2Demo.Create(DataBufIn:pinteger;iSizeElements,iNElements:integer);
begin
 inherited Create;
 fDataBufin:=DataBufIn;
 fSizeElements:=iSizeElements;
 fNElements:=iNElements;
 fcount:=0;
 fPATH_SPDDemo:=PATH_SPDDemo;
end;
 function TMLPCChannelRead2Demo.Read( Data: PInteger; var pCount: Integer): HResult; stdcall;
 begin
 end;
 function TMLPCChannelRead2Demo.get_Count(out pN: Integer): HResult; stdcall;
 begin
   if FCount<(FNElements-AlgParams.NGetCountEvent) then pN:=AlgParams.NGetCountEvent
                                                   else pN:=FNElements-FCount;
   result:=S_OK;
 end;
 function TMLPCChannelRead2Demo.ReadWait(Data: PInteger; var pCount: Integer; Timeout: Integer): HResult; stdcall;
var i,j,k:integer;
     ZGatediscr_min, ZGateDiscr_max:integer;
 begin
  //   Sleep(PATH_SPDDemo);
  k:=0;
  if  ApprOnProgr   then                       // открыто окно ѕодвода
  begin
       ZGatediscr_min:= round(-65536*ApproachParams.ZGateMin + MaxApitype);   // нижн€€ риска - положит. значени€
       ZGatediscr_max:= round(-65536*ApproachParams.ZGateMax + MaxApitype);    // верхн€€ риска - отрицат. значени€

  end;

  if  ApprOnProgr   and                      // открыто окно ѕодвода
         (((ApproachParams.ZStepsDone) < 0)    // «онд выше зоны, в которой измен€етс€ его длина
          or (ApproachParams.ZStepsNumb < 0))       //или  выполн€етс€ отвод
      then
         begin
           for i := 0 to pCount - 1 do
             begin
                DemoParams.Z:= -32767;
                if STMFlg then
                    DemoParams.TunnelCurrent:= 0
                    else
                    DemoParams.oscAmp:= 32767;

                PIntegerArray(DATA)[i*fSizeElements]:=0;
                PIntegerArray(DATA)[i*fSizeElements+1]:=DemoParams.Z shl 16;
                if STMFlg then
                PIntegerArray(DATA)[i*fSizeElements+2]:=DemoParams.TunnelCurrent shl 16
                  else
                   PIntegerArray(DATA)[i*fSizeElements+2]:=DemoParams.oscAmp shl 16;
                ApproachParams.ZStepsDone:=ApproachParams.ZStepsDone+ApproachParams.ZStepsNumb;
                PIntegerArray(DATA)[i*fSizeElements+3]:=ApproachParams.ZStepsDone;
                inc (k,fSizeElements);
             end;

            result:=S_OK;
         end
    else
      if  ApprOnProgr   and                      // открыто окно ѕодвода
              (ApproachParams.ZStepsNumb > 0) and // ѕодвод при уже захваченном взаимодействии
              (abs(DemoParams.Z) < abs(ZGatediscr_min)) and (abs(DemoParams.Z) < abs(ZGatediscr_max))  then
             begin
              for i := 0 to pCount - 1 do
                begin
                   PIntegerArray(DATA)[i*fSizeElements]:=3;
                   PIntegerArray(DATA)[i*fSizeElements+1]:=DemoParams.Z shl 16;             // Z  в положени захвата
                   if STMflg then
                      PIntegerArray(DATA)[i*fSizeElements+2]:=round(-TransformUnit.nA_d*ApproachParams.LandingSetPoint) shl 16
                     else
                       PIntegerArray(DATA)[i*fSizeElements+2]:=round(maxApitype*ApproachParams.LandingSetPoint) shl 16 ;
                   ApproachParams.ZStepsDone:=ApproachParams.ZStepsDone;   // идти не надо
                   PIntegerArray(DATA)[i*fSizeElements+3]:= ApproachParams.ZStepsDone;
                   inc(k,AlgParams.SizeElements);
                end;
              result:=S_OK;
             end

  else
  begin
   k:=0;                  // „итать из буфера
   for i:=0 to pCount*fSizeElements- 1 do
   begin
     if (fcount*fSizeElements+i)< fNElements*fSizeElements then    //     !!!
   begin
       PIntegerArray(DATA)[i]:=PIntegerArray(fDataBufIn)[(fcount*fSizeElements+i)];
       inc(k,1);   //280113
   end;
   end;
   //    inc(fcount,pCount);        //280113
 //
     k:=k div fSizeElements;   //280113
     inc(fcount,k);       //280113
     pcount:=k;         //280113
 //
     result:=S_OK;
     {$IFDEF DEBUG}
          Formlog.memolog.Lines.add('fcount= '+inttostr(fcount));
     {$ENDIF}
  end;
 end;

 function  TMLPCChannelReadDemo.Read( Data: PInteger; var pCount: Integer): HResult; stdcall;
 var i,j,k:integer;
     ZGatediscr_min, ZGateDiscr_max:integer;
 begin
  //   Sleep(PATH_SPDDemo);
  k:=0;
  if  ApprOnProgr   then                       // открыто окно ѕодвода
  begin
       ZGatediscr_min:= round(-65536*ApproachParams.ZGateMin + MaxApitype);   // нижн€€ риска - положит. значени€
       ZGatediscr_max:= round(-65536*ApproachParams.ZGateMax + MaxApitype);    // верхн€€ риска - отрицат. значени€

  end;

  if  ApprOnProgr   and                      // открыто окно ѕодвода
         (((ApproachParams.ZStepsDone) < 0)    // «онд выше зоны, в которой измен€етс€ его длина
          or (ApproachParams.ZStepsNumb < 0))       //или  выполн€етс€ отвод
      then   //approach simulation
         begin
           for i := 0 to pCount - 1 do
             begin
                DemoParams.Z:= -32767;
                if STMFlg then
                    DemoParams.TunnelCurrent:= 0
                    else
                    DemoParams.oscAmp:= 32767;

                PIntegerArray(DATA)[i*fSizeElements]:=0;
                PIntegerArray(DATA)[i*fSizeElements+1]:=DemoParams.Z shl 16;
                if STMFlg then    PIntegerArray(DATA)[i*fSizeElements+2]:=DemoParams.TunnelCurrent shl 16
                  else            PIntegerArray(DATA)[i*fSizeElements+2]:=DemoParams.oscAmp shl 16;
                ApproachParams.ZStepsDone:=ApproachParams.ZStepsDone+ApproachParams.ZStepsNumb;
                PIntegerArray(DATA)[i*fSizeElements+3]:=ApproachParams.ZStepsDone;
                inc (k,fSizeElements);
             end;
            result:=S_OK;
         end
       else
           if  ApprOnProgr   and                      // открыто окно ѕодвода
              (ApproachParams.ZStepsNumb > 0) and // ѕодвод при уже захваченном взаимодействии
              (abs(DemoParams.Z) < abs(ZGatediscr_min)) and (abs(DemoParams.Z) < abs(ZGatediscr_max))  then
             begin
              for i := 0 to pCount - 1 do
                begin
                   PIntegerArray(DATA)[i*fSizeElements]:=3;
                   PIntegerArray(DATA)[i*fSizeElements+1]:=DemoParams.Z shl 16;             // Z  в положени захвата
                   if STMflg then
                      PIntegerArray(DATA)[i*fSizeElements+2]:=round(-TransformUnit.nA_d*ApproachParams.LandingSetPoint) shl 16
                     else
                       PIntegerArray(DATA)[i*fSizeElements+2]:=round(maxApitype*ApproachParams.LandingSetPoint) shl 16 ;
                   ApproachParams.ZStepsDone:=ApproachParams.ZStepsDone;   // идти не надо
                   PIntegerArray(DATA)[i*fSizeElements+3]:= ApproachParams.ZStepsDone;
                   inc(k,AlgParams.SizeElements);
                end;
              result:=S_OK;
             end

  else
  begin
   k:=0;                  // „итать из буфера
   for i:=0 to pCount*fSizeElements- 1 do
   begin
     if (fcount*fSizeElements+i)< fNElements*fSizeElements then    //     !!!
   begin
       PIntegerArray(DATA)[i]:=PIntegerArray(fDataBufIn)[(fcount*fSizeElements+i)];
       inc(k,1);   //280113
   end;
   end;
   //    inc(fcount,pCount);        //280113
 //
     k:=k div fSizeElements;   //280113
     inc(fcount,k);       //280113
     pcount:=k;         //280113
 //
     result:=S_OK;
     {$IFDEF DEBUG}
          Formlog.memolog.Lines.add('fcount= '+inttostr(fcount));
     {$ENDIF}
  end;
end;

constructor TMLPCChannelReadDemo.Create(DataBufIn:pinteger;iSizeElements,iNElements:integer);
begin
 inherited Create;
 fDataBufin:=DataBufIn;
 fSizeElements:=iSizeElements;
 fNElements:=iNElements;
 fcount:=0;
 fPATH_SPDDemo:=PATH_SPDDemo;
end;

 function  TMLPCChannelReadDemo.get_Count(out pN: Integer): HResult; stdcall;
 begin
 result:=S_OK;
 fPATH_SPDDemo:=fPATH_SPDDemo-GETCOUNT_DELAY;
 if fPATH_SPDDemo>0 then
 begin
  pN:=0;
  exit;
 end
 else fPATH_SPDDemo:=PATH_SPDDemo;
  if FCount<(FNElements-AlgParams.NGetCountEvent) then pN:=AlgParams.NGetCountEvent
                                                  else pN:=FNElements-FCount;

 end;

 function TMLPCChannelWriteDemo.Write(Data: pInteger; var pCount: Integer): HResult; stdcall;
 begin
   result:=S_OK;
 end;
 function TMLPCChannelWriteDemo.get_Count(out pN: Integer): HResult; stdcall;
 begin
   result:=S_OK;
 end;
(* function TMLPCChannelWrite2Demo.WriteWait( Data: PInteger; var pCount: Integer; Timeout: Integer): HResult; stdcall;
  begin
   result:=S_OK;
 end;
 *)
//
 function TMLPCChannelManagerDemo.Connect(const pUnk: IUnknown): HResult; stdcall;
 begin
   result:=S_OK;
 end;
 function TMLPCChannelManagerDemo.Disconnect: HResult; stdcall;
 begin
   result:=S_OK;
 end;
 function TMLPCChannelManagerDemo.EnumChannels(out ppUnk: IUnknown): HResult; stdcall;
 begin
   result:=S_OK;
 end;
 function TMLPCChannelManager2Demo.Connect(const pUnk: IUnknown): HResult; stdcall;
 begin
   result:=S_OK;
 end;
 function TMLPCChannelManager2Demo.Disconnect: HResult; stdcall;
 begin
   result:=S_OK;
 end;
 function TMLPCChannelManager2Demo.EnumChannels(out ppUnk: IUnknown): HResult; stdcall;
 begin
   result:=S_OK;
 end;
 function TMLPCChannelManager2Demo.WaitChannel(id: Integer; Timeout: Integer; out ppUnk: IUnknown): HResult; stdcall;
 begin
   sleep(100);
    ppUnk:=TMLPCChannelDemo.Create as IMLPCChannelDemo;
   result:=S_OK;
 end;
 //
 function  TMLPCChannelDemo.get_Geometry(out pN: Integer; out pW: Integer): HResult; stdcall;
 begin
   pn:=AlgParams.NElements;
   pW:=AlgParams.SizeElements;
   result:=S_OK;
 end;
 function TMLPCChannelDemo.get_Name(out pName: WideString): HResult; stdcall;
 begin
   result:=S_OK;
 end;
 function TMLPCChannelDemo.get_ID(out pID: Integer): HResult; stdcall;
 begin
   pID:=ch_Data_OUT;//fID;
   result:=S_OK;
 end;
 function TMLPCChannelDemo.Disconnect: HResult; stdcall;
   begin
   result:=S_OK;
 end;
 class function CoMLPCChannelManagerDemo.Create: IMLPCChannelManagerDemo;
begin
  Result := TMLPCChannelManagerDemo.Create as IMLPCChannelManagerDemo;
end;
class function CoMLPCChannelDemo.Create: IMLPCChannelDemo;
begin
  Result := TMLPCChannelDemo.Create as IMLPCChannelDemo;
end;
end.
