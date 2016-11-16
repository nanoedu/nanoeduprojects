unit PortableDeviceEventConst;

interface
uses PortableDeviceApiLib_TLB, PortableDeviceConst;

var
WPD_EVENT_PARAMETER_PNP_DEVICE_ID:_tagpropertykey;
WPD_EVENT_PARAMETER_EVENT_ID:_tagpropertykey;
WPD_EVENT_NOTIFICATION: TGUID;
WPD_EVENT_OBJECT_ADDED,
WPD_EVENT_OBJECT_REMOVED,
WPD_EVENT_OBJECT_UPDATED,
WPD_EVENT_DEVICE_RESET,
WPD_EVENT_DEVICE_CAPABILITIES_UPDATED,
WPD_EVENT_STORAGE_FORMAT,
WPD_EVENT_OBJECT_TRANSFER_REQUESTED,
WPD_EVENT_DEVICE_REMOVED,
WPD_EVENT_SERVICE_METHOD_COMPLETE: TGUID;


implementation

initialization
// WPD_EVENT_PARAMETER_PNP_DEVICE_ID 
//   [ VT_LPWSTR ] Indicates the device that originated the event. 
DEFINE_PROPERTYKEY( WPD_EVENT_PARAMETER_PNP_DEVICE_ID , $15AB1953, $F817, $4FEF, $A9, $21, $56, $76, $E8, $38, $F6, $E0 , 2 );
//
// WPD_EVENT_PARAMETER_EVENT_ID 
//   [ VT_CLSID ] Indicates the event sent. 
DEFINE_PROPERTYKEY( WPD_EVENT_PARAMETER_EVENT_ID , $15AB1953, $F817, $4FEF, $A9, $21, $56, $76, $E8, $38, $F6, $E0 , 3 );
//

// WPD_EVENT_NOTIFICATION
//   This GUID is used to identify all WPD driver events to the event sub-system. The driver uses this as the GUID identifier when it queues an event with IWdfDevice::PostEvent(). Applications never use this value. 
DEFINE_GUID(WPD_EVENT_NOTIFICATION, $2BA2E40A, $6B4C, $4295, $BB, $43, $26, $32, $2B, $99, $AE, $B2 );
// 
// WPD_EVENT_OBJECT_ADDED
//   This event is sent after a new object is available on the device. 
DEFINE_GUID(WPD_EVENT_OBJECT_ADDED, $A726DA95, $E207, $4B02, $8D, $44, $BE, $F2, $E8, $6C, $BF, $FC );
// 
// WPD_EVENT_OBJECT_REMOVED
//   This event is sent after a previously existing object has been removed from the device. 
DEFINE_GUID(WPD_EVENT_OBJECT_REMOVED, $BE82AB88, $A52C, $4823, $96, $E5, $D0, $27, $26, $71, $FC, $38 );
// 
// WPD_EVENT_OBJECT_UPDATED
//   This event is sent after an object has been updated such that any connected client should refresh its view of that object. 
DEFINE_GUID(WPD_EVENT_OBJECT_UPDATED, $1445A759, $2E01, $485D, $9F, $27, $FF, $07, $DA, $E6, $97, $AB );
// 
// WPD_EVENT_DEVICE_RESET
//   This event indicates that the device is about to be reset, and all connected clients should close their connection to the device. 
DEFINE_GUID(WPD_EVENT_DEVICE_RESET, $7755CF53, $C1ED, $44F3, $B5, $A2, $45, $1E, $2C, $37, $6B, $27 );
//
// WPD_EVENT_DEVICE_CAPABILITIES_UPDATED
//   This event indicates that the device capabilities have changed. Clients should re-query the device if they have made any decisions based on device capabilities. 
DEFINE_GUID(WPD_EVENT_DEVICE_CAPABILITIES_UPDATED, $36885AA1, $CD54, $4DAA, $B3, $D0, $AF, $B3, $E0, $3F, $59, $99 );
// 
// WPD_EVENT_STORAGE_FORMAT
//   This event indicates the progress of a format operation on a storage object. 
DEFINE_GUID(WPD_EVENT_STORAGE_FORMAT, $3782616B, $22BC, $4474, $A2, $51, $30, $70, $F8, $D3, $88, $57 );
// 
// WPD_EVENT_OBJECT_TRANSFER_REQUESTED
//   This event is sent to request an application to transfer a particular object from the device. 
DEFINE_GUID(WPD_EVENT_OBJECT_TRANSFER_REQUESTED, $8D16A0A1, $F2C6, $41DA, $8F, $19, $5E, $53, $72, $1A, $DB, $F2 );
// 
// WPD_EVENT_DEVICE_REMOVED
//   This event is sent when a driver for a device is being unloaded. This is typically a result of the device being unplugged. 
DEFINE_GUID(WPD_EVENT_DEVICE_REMOVED, $E4CBCA1B, $6918, $48B9,$85, $EE, $02, $BE, $7C, $85, $0A, $F9 );
// 
// WPD_EVENT_SERVICE_METHOD_COMPLETE
//   This event is sent when a driver has completed invoking a service method. This event must be sent even when the method fails.
DEFINE_GUID(WPD_EVENT_SERVICE_METHOD_COMPLETE, $8A33F5F8, $0ACC, $4D9B, $9C, $C4, $11, $2D, $35, $3B, $86, $CA );

end.
