unit UDeviceEvents;

interface
 uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL,SysUtils,
      Variants,PortableDeviceApiLib_TLB,PortableDeviceConst,PortableDeviceEventConst,
      ShLwApi, USpecialTypes,
       {$IFDEF DEBUG}
        frDebug,
       {$ENDIF}
        Comobj;


 type CPortableDeviceEventsCallback = class(TInterfacedObject,IPortableDeviceEventCallback)
 public
// function QueryInterface(  const riid:TGUID;  out ppvObj) :HRESULT;  stdcall; //
  function AddRef(): Integer;  safecall;
//  function Release(): ULONG;  safecall;
   // Main OnEvent handler called for events

  function OnEvent(const pEventParameters: IPortableDeviceValues): HResult; stdcall;
    // Register for device events.
  function  Register( pDevice:IPortableDevice):HRESULT;

    // Unregister from device event notification
   function  UnRegister( pDevice:IPortableDevice):HRESULT;
   function   Release(): Integer;
   constructor Create();
private
    // Ref-counter
       m_cRef:Integer;   //ulong
     // pwszObjectAlgId:LPWSTR ;
   //   pwszObjectParamId:LPWSTR ;
//   strAlg:string;
//   strParam:string;
    // Cookie to use while unadvising
      m_pwszEventCookie:LPWSTR;
 end;

// var
 //spEventParameters:IPortableDeviceValues;
 //g_strEventRegistrationCookie:PChar;  //CAtlStringW

 implementation
 uses Dialogs,Globalvar,CSPMVar;


// IPortableDeviceEventCallback implementation for use with
// device events.

  constructor CPortableDeviceEventsCallback.Create();
  begin
   m_cRef:=1;
  end;

  (*function CPortableDeviceEventsCallback.QueryInterface(const riid:TGUID;  out ppvObj) :HRESULT ;

  var hr:HRESULT;
  begin
         hr := S_OK;
        if (pointer(ppvObj) = Nil) then
        begin
            hr := E_INVALIDARG;
            result:= hr;
        end;

        if (ISEQUALIID(riid, IID_IUnknown) or
            ISEQUALIID(riid , IID_IPortableDeviceEventCallback)) then
        begin
            AddRef();
            ppvObj := Pointer(Self);
        end
        else
        begin
            Pointer(ppvObj) := Nil;
            hr := E_NOINTERFACE;
        end;
        result:= hr;
    end;
  *)
    function CPortableDeviceEventsCallback.AddRef(): Integer;  //safecall;
  /// ULONG __stdcall AddRef()
    begin
        InterlockedIncrement(m_cRef);
        result:= m_cRef;
    end;

    function CPortableDeviceEventsCallback.Release(): Integer;  //safecall;
    ////ULONG __stdcall Release()
    var ulRefCount:integer;
    begin
        ulRefCount := m_cRef - 1;

        if (InterlockedDecrement(m_cRef) = 0) then
          begin

            result:= 0;
            inherited   Destroy;
          end;
        result:= ulRefCount;
    end;


    function CPortableDeviceEventsCallback.OnEvent(const pEventParameters: IPortableDeviceValues): HResult; stdcall;
   var hr:HRESULT;
       EventId:TGUID ;
       pwszEventId:LPWSTR ;
       pwszObjectId:LPWSTR ;
       pwszObjectName:LPWSTR;

    begin
    (*    if (pEventParameters <> nil) then
        begin
            ShowMessage('***************************\n** Device event received **\n***************************\n');
           // DisplayStringProperty(pEventParameters, WPD_EVENT_PARAMETER_PNP_DEVICE_ID, L"WPD_EVENT_PARAMETER_PNP_DEVICE_ID");
            //DisplayGuidProperty(pEventParameters, WPD_EVENT_PARAMETER_EVENT_ID, L"WPD_EVENT_PARAMETER_EVENT_ID");
        end;

        result:= S_OK;
     *)
     hr := S_OK;
     if (pEventParameters = Nil ) then

        hr := E_POINTER;

            // Display the event that was fired

    if (hr = S_OK) then

      hr := pEventParameters.GetGuidValue(WPD_EVENT_PARAMETER_EVENT_ID, EventId);


  (*  pwszEventId := Nil;
    if (hr = S_OK) then

        hr := StringFromCLSID(EventId, &pwszEventId);

    if (hr = S_OK) then
     ShowMessage( '***** Event ***'+ pwszEventId);

      if (pwszEventId <> Nil) then

        CoTaskMemFree(pwszEventId);
     *)

       // Display the ID of the object that was affected
    // We can also obtain WPD_OBJECT_NAME, WPD_OBJECT_PERSISTENT_UNIQUE_ID,
    // WPD_OBJECT_PARENT_ID, etc.

    pwszObjectId:= Nil;

    pwszObjectName:= Nil;

    if (hr = S_OK) then

        hr := pEventParameters.GetStringValue(WPD_OBJECT_ID, pwszObjectId); // &pwszObjectId

        hr := pEventParameters.GetStringValue(WPD_OBJECT_NAME, pwszObjectName);   //&pwszObjectName

   // if (hr = S_OK)then

    //    ShowMessage('Object ID: '+ pwszObjectId);

    {$IFDEF DEBUG}
     if ISEQUALIID(EventId, WPD_EVENT_OBJECT_ADDED)then
     begin
            // ShowMessage( '***** Event ***'+ 'OBJECT ADDED')
        Formlog.memolog.Lines.add((*'OBJECT ADDED  '+ 'Object ID: '+ pwszObjectId+*)'added File: '+ pwszObjectName);
          if (pwszObjectName=AlgorithmJava)     then
           begin
            flgfilealguploaded:=true;
           // GetMem(pwszObjectAlgId,2*(Length(pwszObjectId)  + 1));
          // strcpyW(pwszObjectAlgId, pwszObjectId);
         // strAlg:=WideCharToString(pwszObjectId);
             flgfilealgdeleted:=false;
           end;
          if (pwszObjectName=InitParamFileJava) then
          begin
            flgfileparamuploaded:=true;
         //   pwszObjectParamId:=pwszObjectId;
         //   strParam:=WideCharToString(pwszObjectId);
            flgfileparamdeleted:=false;
          end;
            if (pwszObjectName=MaskLithoFileJava) then
          begin
            flgfilemaskuploaded:=true;
         //   pwszObjectParamId:=pwszObjectId;
         //   strParam:=WideCharToString(pwszObjectId);
            flgfilemaskdeleted:=false;
          end;
        end
     else if ISEQUALIID(EventId, WPD_EVENT_OBJECT_REMOVED)then
          begin
            Formlog.memolog.Lines.Add((* 'OBJECT REMOVED  ' +'Object ID: '+ pwszObjectId+*)'removed file: '+ pwszObjectName);
             // flgfiledeleted:=true;
  (*         if (pwszObjectAlgID=pwszObjectId)      then
            begin
             flgfilealgdeleted:=true;
             flgfilealguploaded:=false;
            end;
           if (pwszObjectParamID=pwszObjectId)  then
           begin
             flgfileparamdeleted:=true;
             flgfileparamuploaded:=false;
           end;
   *)
            flgfileparamdeleted:=true;
     //       flgfileparamuploaded:=false;
            flgfilealgdeleted:=true;
            flgfilemaskdeleted:=true; //
     //       flgfilealguploaded:=false;
          end
 // MTP_EVENTCODE_STOREADDED = $00004004;
//  MTP_EVENTCODE_STOREREMOVED = $00004005;

     else if ISEQUALIID(EventId, WPD_EVENT_DEVICE_RESET)then
           begin
              Formlog.memolog.Lines.Add( 'DEVICE RESET  ');
           end;
(*
    else
             Formlog.memolog.Lines.Add( '***** UNKNOWN EVENT ***'+ 'Object ID: '+ pwszObjectId);
 *)
   {$ENDIF}
      if (pwszObjectId <> nil) then

        CoTaskMemFree(pwszObjectId);

      if (pwszObjectName <> nil) then

        CoTaskMemFree(pwszObjectName);


    // Note that we intentionally do not call Release on pEventParameters since we 
    // do not own it

    result:= hr;

end;



function  CPortableDeviceEventsCallback.Register( pDevice:IPortableDevice):HRESULT;
 var hr:HRESULT;
// spEventParameters:IPortableDeviceValues;
 begin
    // Check if we are already registered. If so
    // return S_FALSE
    //
    if (m_pwszEventCookie <> Nil) then
      begin
        result:= S_FALSE;
        exit;
      end;

     hr := S_OK;

   (* CComPtr<IPortableDeviceValues> spEventParameters;

    if (hr = S_OK)   then
    begin
        hr:=CoCreateInstance(CLSID_PortableDeviceValues,
                              NULL,
                              CLSCTX_INPROC_SERVER,
                              IID_IPortableDeviceValues,
                               &spEventParameters);
    end;
    *)
    if (hr = S_OK) then

    // IPortableDevice::Advise is used to register for event notifications
    // This returns a cookie (string) that is needed while unregistering
 (*  if (hr = S_OK)  then
    begin
        hr = pDevice.Advise(0,self, spEventParameters, &m_pwszEventCookie);
    end;
*)

        hr := pDevice.Advise(0, self, spClientInfo, &m_pwszEventCookie);
     //  function Advise(dwFlags: LongWord; const pCallback: IPortableDeviceEventCallback;
     //               const pParameters: IPortableDeviceValues; out ppszCookie: PWideChar): HResult; stdcall;

    result:=hr;
end;

function  CPortableDeviceEventsCallback.UnRegister( pDevice:IPortableDevice):HRESULT;
var   hr:HRESULT;
begin
     hr := S_OK;
    if (pDevice = Nil) then    exit;
    hr := pDevice.Unadvise(m_pwszEventCookie);
    if (FAILED(hr)) then      ShowMessage('Failed to unregister for device events!!');
 //   if (hr = S_OK)  then      ShowMessage('UNRegistered!!');

 //    CoTaskMemFree(m_pwszEventCookie);
 //    m_pwszEventCookie:=nil;

 //nanoed II
 CoTaskMemFree(m_pwszEventCookie);
 m_pwszEventCookie:=nil;
end;


end.
