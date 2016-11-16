unit PortableDeviceConst;

interface

uses PortableDeviceApiLib_TLB;
(*
 * VARENUM usage key,
 *
 * * [V] - may appear in a VARIANT
 * * [T] - may appear in a TYPEDESC
 * * [P] - may appear in an OLE property set
 * * [S] - may appear in a Safe Array
 *
 *
 *  VT_EMPTY            [V]   [P]     nothing
 *  VT_NULL             [V]   [P]     SQL style Null
 *  VT_I2               [V][T][P][S]  2 byte signed int
 *  VT_I4               [V][T][P][S]  4 byte signed int
 *  VT_R4               [V][T][P][S]  4 byte real
 *  VT_R8               [V][T][P][S]  8 byte real
 *  VT_CY               [V][T][P][S]  currency
 *  VT_DATE             [V][T][P][S]  date
 *  VT_BSTR             [V][T][P][S]  OLE Automation string
 *  VT_DISPATCH         [V][T]   [S]  IDispatch *
 *  VT_ERROR            [V][T][P][S]  SCODE
 *  VT_BOOL             [V][T][P][S]  True=-1, False=0
 *  VT_VARIANT          [V][T][P][S]  VARIANT *
 *  VT_UNKNOWN          [V][T]   [S]  IUnknown *
 *  VT_DECIMAL          [V][T]   [S]  16 byte fixed point
 *  VT_RECORD           [V]   [P][S]  user defined type
 *  VT_I1               [V][T][P][s]  signed char
 *  VT_UI1              [V][T][P][S]  unsigned char
 *  VT_UI2              [V][T][P][S]  unsigned short
 *  VT_UI4              [V][T][P][S]  unsigned long
 *  VT_I8                  [T][P]     signed 64-bit int
 *  VT_UI8                 [T][P]     unsigned 64-bit int
 *  VT_INT              [V][T][P][S]  signed machine int
 *  VT_UINT             [V][T]   [S]  unsigned machine int
 *  VT_INT_PTR             [T]        signed machine register size width
 *  VT_UINT_PTR            [T]        unsigned machine register size width
 *  VT_VOID                [T]        C style void
 *  VT_HRESULT             [T]        Standard return type
 *  VT_PTR                 [T]        pointer type
 *  VT_SAFEARRAY           [T]        (use VT_ARRAY in VARIANT)
 *  VT_CARRAY              [T]        C style array
 *  VT_USERDEFINED         [T]        user defined type
 *  VT_LPSTR               [T][P]     null terminated string
 *  VT_LPWSTR              [T][P]     wide null terminated string
 *  VT_FILETIME               [P]     FILETIME
 *  VT_BLOB                   [P]     Length prefixed bytes
 *  VT_STREAM                 [P]     Name of the stream follows
 *  VT_STORAGE                [P]     Name of the storage follows
 *  VT_STREAMED_OBJECT        [P]     Stream contains an object
 *  VT_STORED_OBJECT          [P]     Storage contains an object
 *  VT_VERSIONED_STREAM       [P]     Stream with a GUID version
 *  VT_BLOB_OBJECT            [P]     Blob contains an object
 *  VT_CF                     [P]     Clipboard format
 *  VT_CLSID                  [P]     A Class ID
 *  VT_VECTOR                 [P]     simple counted array
 *  VT_ARRAY            [V]           SAFEARRAY*
 *  VT_BYREF            [V]           void* for local use
 *  VT_BSTR_BLOB                      Reserved for system use
 */
 *)
CONST
  VT_EMPTY	= 0;
	VT_NULL	= 1;
	VT_I2	= 2;
	VT_I4	= 3;
	VT_R4	= 4;
	VT_R8	= 5;
	VT_CY	= 6;
	VT_DATE	= 7;
	VT_BSTR	= 8;
	VT_DISPATCH	= 9;
	VT_ERROR	= 10;
	VT_BOOL	= 11;
	VT_VARIANT	= 12;
	VT_UNKNOWN	= 13;
	VT_DECIMAL	= 14;
	VT_I1	= 16;
	VT_UI1	= 17;
	VT_UI2	= 18;
	VT_UI4	= 19;
	VT_I8	= 20;
	VT_UI8	= 21;
	VT_INT	= 22;
	VT_UINT	= 23;
	VT_VOID	= 24;
	VT_HRESULT	= 25;
	VT_PTR	= 26;
	VT_SAFEARRAY	= 27;
	VT_CARRAY	= 28;
	VT_USERDEFINED	= 29;
	VT_LPSTR	= 30;
	VT_LPWSTR	= 31;
	VT_RECORD	= 36;
	VT_INT_PTR	= 37;
	VT_UINT_PTR	= 38;
	VT_FILETIME	= 64;
	VT_BLOB	= 65;
	VT_STREAM	= 66;
	VT_STORAGE	= 67;
	VT_STREAMED_OBJECT	= 68;
	VT_STORED_OBJECT	= 69;
	VT_BLOB_OBJECT	= 70;
	VT_CF	= 71;
	VT_CLSID	= 72;
	VT_VERSIONED_STREAM	= 73;
	VT_BSTR_BLOB	= $fff;
	VT_VECTOR	= $1000;
	VT_ARRAY	= $2000;
	VT_BYREF	= $4000;
	VT_RESERVED	= $8000;
	VT_ILLEGAL	= $ffff;
	VT_ILLEGALMASKED	= $fff;
	VT_TYPEMASK	= $fff;

var
 WPD_OBJECT_PARENT_ID :_tagpropertykey;
 WPD_OBJECT_NAME:_tagpropertykey;
 WPD_OBJECT_SIZE:_tagpropertykey;
 WPD_OBJECT_FORMAT:_tagpropertykey;
 WPD_OBJECT_ID :_tagpropertykey;
 WPD_OBJECT_CONTENT_TYPE:_tagpropertykey;
 WPD_CLIENT_NAME:_tagpropertykey;
 WPD_CLIENT_MAJOR_VERSION:_tagpropertykey;
 WPD_CLIENT_MINOR_VERSION:_tagpropertykey;
 WPD_CLIENT_REVISION :_tagpropertykey;
 WPD_DEVICE_DATETIME :_tagpropertykey;
 WPD_DEVICE_FRIENDLY_NAME:_tagpropertykey;
 WPD_DEVICE_POWER_LEVEL:_tagpropertykey;
 WPD_PROPERTY_COMMON_COMMAND_CATEGORY:_tagpropertykey;
 WPD_DEVICE_MANUFACTURER:_tagpropertykey;

 WPD_RESOURCE_DEFAULT:_tagpropertykey;
 WPD_COMMAND_COMMON_RESET_DEVICE:_tagpropertykey;
 WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITHOUT_DATA_PHASE:_tagpropertykey;
 WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_READ:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_OPERATION_CODE:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_RESPONSE_CODE:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_RESPONSE_PARAMS:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_OPERATION_PARAMS:_tagpropertykey;
 WPD_COMMAND_MTP_EXT_READ_DATA:_tagpropertykey;
 WPD_COMMAND_MTP_EXT_WRITE_DATA:_tagpropertykey;
 WPD_COMMAND_MTP_EXT_GET_VENDOR_EXTENSION_DESCRIPTION:_tagpropertykey;
 WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_WRITE:_tagpropertykey;
 WPD_COMMAND_MTP_EXT_END_DATA_TRANSFER:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_VENDOR_OPERATION_CODES:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_TRANSFER_CONTEXT:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_TRANSFER_TOTAL_DATA_SIZE:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_TO_READ:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_READ:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_TO_WRITE:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_WRITTEN:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_TRANSFER_DATA :_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_OPTIMAL_TRANSFER_BUFFER_SIZE:_tagpropertykey;
 WPD_PROPERTY_MTP_EXT_VENDOR_EXTENSION_DESCRIPTION:_tagpropertykey;
//   [ VT_UI4 ] Specifies the command ID, which is the PID portion of the PROPERTYKEY indicating the command.
 WPD_PROPERTY_COMMON_COMMAND_ID:_tagpropertykey;
 WPD_PROPERTY_COMMON_HRESULT:_tagpropertykey;
// PTP_OPCODE_GETNUMOBJECT:
WPD_CONTENT_TYPE_FUNCTIONAL_OBJECT :TGUID;
WPD_CONTENT_TYPE_FOLDER            :TGUID;
WPD_CONTENT_TYPE_IMAGE             :TGUID;
WPD_CONTENT_TYPE_DOCUMENT          :TGUID;
WPD_CONTENT_TYPE_CONTACT           :TGUID;
WPD_CONTENT_TYPE_AUDIO             :TGUID;
WPD_CONTENT_TYPE_UNSPECIFIED       :TGUID;
WPD_CONTENT_TYPE_ALL               :TGUID;
WPD_OBJECT_FORMAT_EXIF             :TGUID;

WPD_OBJECT_FORMAT_WMA              :TGUID;
WPD_OBJECT_FORMAT_VCARD2           :TGUID;
WPD_OBJECT_FORMAT_ALL                :TGUID;
WPD_OBJECT_FORMAT_PROPERTIES_ONLY    :TGUID;
WPD_OBJECT_FORMAT_UNSPECIFIED        :TGUID;


 function DEFINE_PROPERTYKEY(var name:_tagpropertykey;d1:longword;d2:word;d3:word;b0:byte;b1:byte;b2:byte;b3:byte;b4:byte;b5:byte;b6:byte;b7:byte; pid:longword):boolean;
 function  DEFINE_GUID(var name:TGUID; d1:longword; d2:word; d3:word; b0:byte; b1:byte; b2:byte; b3:byte;
                                                         b4:byte; b5:byte; b6:byte; b7:byte):boolean;
implementation

function DEFINE_PROPERTYKEY(var name:_tagpropertykey;d1:longword;d2:word;d3:word;b0:byte;
                                                b1:byte;b2:byte;b3:byte;b4:byte;b5:byte;b6:byte;b7:byte;pid:longword):boolean;
begin
  name.fmtid.D1:=d1;
  name.fmtid.D2:=d2;
  name.fmtid.D3:=d3;
  name.fmtid.D4[0]:=b0;
  name.fmtid.D4[1]:=b1;
  name.fmtid.D4[2]:=b2;
  name.fmtid.D4[3]:=b3;
  name.fmtid.D4[4]:=b4;
  name.fmtid.D4[5]:=b5;
  name.fmtid.D4[6]:=b6;
  name.fmtid.D4[7]:=b7;
  name.pid:=pid;
end;

(******
#ifdef INITGUID
#define DEFINE_PROPERTYKEY(name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8, pid) EXTERN_C const PROPERTYKEY DECLSPEC_SELECTANY name = { { l, w1, w2, { b1, b2,  b3,  b4,  b5,  b6,  b7,  b8 } }, pid }
#else
#define DEFINE_PROPERTYKEY(name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8, pid) EXTERN_C const PROPERTYKEY name
#endif // INITGUID



#ifndef EXTERN_C
#ifdef __cplusplus
#define EXTERN_C    extern "C"
#else
#define EXTERN_C    extern
#endif
#endif

#ifdef DEFINE_GUID
#undef DEFINE_GUID
#endif

#ifdef INITGUID
#define DEFINE_GUID(name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8) \
        EXTERN_C const GUID DECLSPEC_SELECTANY name \
                = { l, w1, w2, { b1, b2,  b3,  b4,  b5,  b6,  b7,  b8 } }
#else
#define DEFINE_GUID(name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8) \
    EXTERN_C const GUID FAR name
#endif // INITGUID
 ******)
 function  DEFINE_GUID(var name:TGUID; d1:longword; d2:word; d3:word; b0:byte; b1:byte; b2:byte; b3:byte;
                                                         b4:byte; b5:byte; b6:byte; b7:byte):boolean;
 begin
    name.D1:=d1;
  name.D2:=d2;
  name.D3:=d3;
  name.D4[0]:=b0;
  name.D4[1]:=b1;
  name.D4[2]:=b2;
  name.D4[3]:=b3;
  name.D4[4]:=b4;
  name.D4[5]:=b5;
  name.D4[6]:=b6;
  name.D4[7]:=b7;
 end;
initialization
 // WPD_OBJECT_FORMAT
//   [ VT_CLSID ] Indicates the format of the object's data.
DEFINE_PROPERTYKEY( WPD_OBJECT_FORMAT , $EF6B490D, $5CD8, $437A, $AF, $FC, $DA, $8B, $60, $EE, $4A, $3C , 6 );
// WPD_RESOURCE_DEFAULT
//   Represents the entire object's data. There can be only one default resource on an object. 
DEFINE_PROPERTYKEY( WPD_RESOURCE_DEFAULT , $E81E79BE, $34F0, $41BF, $B5, $3F, $F1, $A0, $6A, $E8, $78, $42 , 0 );

 DEFINE_PROPERTYKEY( WPD_OBJECT_SIZE , $EF6B490D, $5CD8, $437A, $AF, $FC, $DA, $8B, $60, $EE, $4A, $3C , 11 );
 DEFINE_PROPERTYKEY( WPD_OBJECT_NAME , $EF6B490D, $5CD8, $437A, $AF, $FC, $DA, $8B, $60, $EE, $4A, $3C ,  4 );
 // WPD_OBJECT_PARENT_ID 
//   [ VT_LPWSTR ] Object identifier indicating the parent object.
DEFINE_PROPERTYKEY( WPD_OBJECT_PARENT_ID , $EF6B490D, $5CD8, $437A, $AF, $FC, $DA, $8B, $60, $EE, $4A, $3C , 3 );
// WPD_OBJECT_CONTENT_TYPE 
//   [ VT_CLSID ] The abstract type for the object content, indicating the kinds of properties and data that may be supported on the object. 
DEFINE_PROPERTYKEY( WPD_OBJECT_CONTENT_TYPE , $EF6B490D, $5CD8, $437A, $AF, $FC, $DA, $8B, $60, $EE, $4A, $3C , 7 );
// WPD_OBJECT_ID
//   [ VT_LPWSTR ] Uniquely identifies object on the Portable Device.
DEFINE_PROPERTYKEY( WPD_OBJECT_ID , $EF6B490D, $5CD8, $437A, $AF, $FC, $DA, $8B, $60, $EE, $4A, $3C , 2 );

//
 DEFINE_PROPERTYKEY( WPD_CLIENT_NAME , $204D9F0C, $2292, $4080, $9F, $42, $40, $66, $4E, $70, $F8, $59 , 2 );
 DEFINE_PROPERTYKEY( WPD_CLIENT_MAJOR_VERSION , $204D9F0C, $2292, $4080, $9F, $42, $40, $66, $4E, $70, $F8, $59 , 3 );
 DEFINE_PROPERTYKEY( WPD_CLIENT_MINOR_VERSION , $204D9F0C, $2292, $4080, $9F, $42, $40, $66, $4E, $70, $F8, $59 , 4 );
 DEFINE_PROPERTYKEY( WPD_CLIENT_REVISION ,$204D9F0C, $2292, $4080, $9F, $42, $40, $66, $4E, $70, $F8, $59 , 5 );

 DEFINE_PROPERTYKEY( WPD_DEVICE_DATETIME , $26D4979A, $E643, $4626, $9E, $2B, $73, $6D, $C0, $C9, $2F, $DC , 11 );
 DEFINE_PROPERTYKEY( WPD_DEVICE_FRIENDLY_NAME ,  $26D4979A, $E643, $4626, $9E, $2B, $73, $6D, $C0, $C9, $2F, $DC , 12 );
 DEFINE_PROPERTYKEY( WPD_DEVICE_POWER_LEVEL ,  $26D4979A, $E643, $4626, $9E, $2B, $73, $6D, $C0, $C9, $2F, $DC , 4 );
 // WPD_DEVICE_MANUFACTURER
//   [ VT_LPWSTR ] Identifies the device manufacturer. 
 DEFINE_PROPERTYKEY( WPD_DEVICE_MANUFACTURER ,  $26D4979A, $E643, $4626, $9E, $2B, $73, $6D, $C0, $C9, $2F, $DC , 7 );

 DEFINE_PROPERTYKEY( WPD_PROPERTY_COMMON_COMMAND_CATEGORY , $F0422A9C, $5DC8, $4440, $B5, $BD, $5D, $F2, $88, $35, $65, $8A , 1001 );
 DEFINE_PROPERTYKEY( WPD_PROPERTY_COMMON_HRESULT ,$F0422A9C, $5DC8, $4440, $B5, $BD, $5D, $F2, $88, $35, $65, $8A  , 1003 );
 DEFINE_PROPERTYKEY( WPD_PROPERTY_COMMON_COMMAND_ID , $F0422A9C, $5DC8, $4440, $B5, $BD, $5D, $F2, $88, $35, $65, $8A, 1002 );

// WPD_COMMAND_COMMON_RESET_DEVICE
//     This command is sent by clients to reset the device. 
//  Access:   (FILE_READ_ACCESS | FILE_WRITE_ACCESS)
//  Parameters:   None
//  Results:   None
DEFINE_PROPERTYKEY( WPD_COMMAND_COMMON_RESET_DEVICE , $F0422A9C, $5DC8, $4440, $B5, $BD, $5D, $F2, $88, $35, $65, $8A , 2 );

 //
// Cmd Key: WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITHOUT_DATA_PHASE 
// Usage:   sends a MTP command block that no data phase follows
// Inputs:  WPD_PROPERTY_MTP_EXT_OPERATION_CODE (VT_UI4): identifies the vendor-extended MTP operation code
//          WPD_PROPERTY_MTP_EXT_OPERATION_PARAMS: An IPortableDevicePropVariantCollection (of VT_UI4)
//                                                 which identifies the required params for the vendor operation code.
// Outputs: WPD_PROPERTY_MTP_EXT_RESPONSE_CODE: [VT_UI4] the response code to the vendor operation code, and 
//          WPD_PROPERTY_MTP_EXT_RESPONSE_PARAMS: An IPortableDevicePropVariantCollection (of VT_UI4) identifying response params if any (could be empty)
DEFINE_PROPERTYKEY( WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITHOUT_DATA_PHASE , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 12 );

//
// Cmd Key: WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_READ
// Usage:   sends a MTP command block followed by a data phase with data from Device to Host
// Inputs:  WPD_PROPERTY_MTP_EXT_OPERATION_CODE (VT_UI4): identifies the vendor-extended MTP operation code
//          WPD_PROPERTY_MTP_EXT_OPERATION_PARAMS: An IPortableDevicePropVariantCollection (of VT_UI4)
//                                                 which identifies the required params for the vendor operation code.
// Outputs: WPD_PROPERTY_MTP_EXT_TRANSFER_TOTAL_DATA_SIZE: [VT_UI8] Returns the total data size in bytes (excluding any overhead) coming from device.
//          if Devie reports unknown datasize ($FFFFFFFF), call ReadData() repeatedly until a short chunk received
//          WPD_PROPERTY_MTP_EXT_OPTIMAL_TRANSFER_BUFFER_SIZE: [VT_UI4] Returns the optimal size of the transfer buffer
//          WPD_PROPERTY_MTP_EXT_TRANSFER_CONTEXT: [VT_LPWSTR] Returned as a context idetifier for subsequent data transfer
DEFINE_PROPERTYKEY( WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_READ , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 13 );

//
// Cmd Key: WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_WRITE
// Usage:   sends a MTP command block followed by a data phase with data from Host to Device
// Inputs:  WPD_PROPERTY_MTP_EXT_OPERATION_CODE (VT_UI4): identifies the vendor-extended MTP operation code
//          WPD_PROPERTY_MTP_EXT_OPERATION_PARAMS: An IPortableDevicePropVariantCollection (of VT_UI4)
//                                                 which identifies the required params for the vendor operation code.
//          WPD_PROPERTY_MTP_EXT_TRANSFER_TOTAL_DATA_SIZE: [VT_UI8] Specifies the total data size in bytes (excluding any overhead) to be sent to device
// Outputs: WPD_PROPERTY_MTP_EXT_OPTIMAL_TRANSFER_BUFFER_SIZE: [VT_UI4] Returns the optimal size of the transfer buffer
//          WPD_PROPERTY_MTP_EXT_TRANSFER_CONTEXT: [VT_LPWSTR] Returned as a context idetifier for subsequent data transfer
DEFINE_PROPERTYKEY( WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_WRITE , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 14 );


//
// Cmd Key: WPD_COMMAND_MTP_EXT_READ_DATA
// Usage:   receives a chunk of data from device following WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_READ
// Inputs:  WPD_PROPERTY_MTP_EXT_TRANSFER_CONTEXT: [VT_LPWSTR] The context idetifier returned in previous calls
//          WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_TO_READ: [VT_UI4] specifies the next number of bytes to read.
//          WPD_PROPERTY_MTP_EXT_TRANSFER_DATA: [VT_VECTOR|VT_UI1] specifies the buffer to which the data from device will be copied
// Outputs: WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_READ: [VT_UI4] returns actual number of bytes (no overhead) received from device in a read call
//          WPD_PROPERTY_MTP_EXT_TRANSFER_DATA: [VT_VECTOR|VT_UI1] Returns the buffer with received data
//
DEFINE_PROPERTYKEY( WPD_COMMAND_MTP_EXT_READ_DATA , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 15 );

//
// Cmd Key: WPD_COMMAND_MTP_EXT_WRITE_DATA
// Usage:   sends a chunk of data to device following WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_WRITE
// Inputs:  WPD_PROPERTY_MTP_EXT_TRANSFER_CONTEXT: [VT_LPWSTR] The context idetifier returned in previous calls
//          WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_TO_WRITE: [VT_UI4] specifies the next number of bytes to write.
//          WPD_PROPERTY_MTP_EXT_TRANSFER_DATA: [VT_VECTOR|VT_UI1] specifies the buffer which contains the data to send to device
// Outputs: WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_WRITTEN: [VT_UI4] returns actual number of bytes (no overhead) sent to device in a write call
//
DEFINE_PROPERTYKEY( WPD_COMMAND_MTP_EXT_WRITE_DATA , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 16 );

//
// Cmd Key: WPD_COMMAND_MTP_EXT_END_DATA_TRANSFER
// Usage:   completes a data transfer and read response from device. The transfer is initiated by either
//              WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_READ, or WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_WRITE
// Inputs:  WPD_PROPERTY_MTP_EXT_TRANSFER_CONTEXT: [VT_LPWSTR] The context idetifier returned in previous calls
// Outputs: WPD_PROPERTY_MTP_EXT_RESPONSE_CODE: [VT_UI4] the response code to the vendor operation code, and
//          WPD_PROPERTY_MTP_EXT_RESPONSE_PARAMS: An IPortableDevicePropVariantCollection (of VT_UI4) identifying response params if any (could be empty)
//
DEFINE_PROPERTYKEY( WPD_COMMAND_MTP_EXT_END_DATA_TRANSFER , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 17 );

//
// Cmd Key: WPD_COMMAND_MTP_EXT_GET_VENDOR_EXTENSION_DESCRIPTION
// Usage:   retrieves the vendor extension description string (as defined by DeviceInfo dataset)
// Inputs:  None
// Outputs: WPD_PROPERTY_MTP_EXT_VENDOR_EXTENSION_DESCRIPTION: [VT_LPWSTR] contains the vendor extension description string
DEFINE_PROPERTYKEY( WPD_COMMAND_MTP_EXT_GET_VENDOR_EXTENSION_DESCRIPTION , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 18 );

// Command Parameters
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_OPERATION_CODE , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1001 );    // [ VT_UI4 ] : Input param which identifies the vendor-extended MTP operation code
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_OPERATION_PARAMS , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1002 );    // [ VT_UNKNOWN ] : Input IPortableDevicePropVariantCollection (of VT_UI4) specifying the params for the vendor operation
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_RESPONSE_CODE , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1003 );    // [ VT_UI4 ] : Output param which identifies the response code for the vendor operation
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_RESPONSE_PARAMS , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1004 );    // [ VT_UNKNOWN ] : Returns an IPortableDevicePropVariantCollection (of VT_UI4) of response params for the vendor operation
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_VENDOR_OPERATION_CODES , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1005 );    // [ VT_UNKNOWN ] : Returns an IPortableDevicePropVariantCollection (of VT_UI4) of Vendor-extended MTP codes
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_TRANSFER_CONTEXT , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1006 );    // [ VT_LPWSTR ] : Returned as a context idetifier (a string value) for subsequent data transfer
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_TRANSFER_TOTAL_DATA_SIZE , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1007 );    // [ VT_UI8 ] : Input (when writing data) or output (when reading data) param which specifies total data size in bytes (excluding any overhead)
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_TO_READ , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1008 ); // [ VT_UI4 ] : Input param specifying the number of bytes to read from device in a series of read calls
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_READ , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1009 ); // [ VT_UI4 ] : Output param specifying the actual number of bytes (no overhead) received from device in a read call
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_TO_WRITE , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1010 ); // [ VT_UI4 ] : Input specifying the number of bytes to send to device in a series of write calls
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_WRITTEN , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1011 ); // [ VT_UI4 ] : Returns the actual number of bytes (no overhead) sent to device in a write call
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_TRANSFER_DATA , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1012 ); // [ VT_VECTOR|VT_UI1 ] : Stores the binary data to transfer from/to device
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_OPTIMAL_TRANSFER_BUFFER_SIZE , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1013 ); // [ VT_UI4 ] : Returns the optimal size of the transfer buffer
DEFINE_PROPERTYKEY( WPD_PROPERTY_MTP_EXT_VENDOR_EXTENSION_DESCRIPTION , $4d545058, $1a2e, $4106, $a3, $57, $77, $1e, $8, $19, $fc, $56 , 1014 ); // [ VT_LPWSTR ] : Returns vendor extension description string


//****************************************************************************
//* This section defines all WPD content types
//****************************************************************************/
// 
// WPD_CONTENT_TYPE_FUNCTIONAL_OBJECT
//   Indicates this object represents a functional object, not content data on the device. 
DEFINE_GUID(WPD_CONTENT_TYPE_FUNCTIONAL_OBJECT, $99ED0160, $17FF, $4C44, $9D, $98, $1D, $7A, $6F, $94, $19, $21 );
// 
// WPD_CONTENT_TYPE_FOLDER
//   Indicates this object is a folder.
DEFINE_GUID(WPD_CONTENT_TYPE_FOLDER, $27E2E392, $A111, $48E0, $AB, $0C, $E1, $77, $05, $A0, $5F, $85 );
//
// WPD_CONTENT_TYPE_IMAGE
//   Indicates this object represents image data (e.g. a JPEG file) 
DEFINE_GUID(WPD_CONTENT_TYPE_IMAGE, $ef2107d5, $a52a, $4243, $a2, $6b, $62, $d4, $17, $6d, $76, $03 );
// 
// WPD_CONTENT_TYPE_DOCUMENT
//   Indicates this object represents document data (e.g. a MS WORD file, TEXT file, etc.) 
DEFINE_GUID(WPD_CONTENT_TYPE_DOCUMENT, $680ADF52, $950A, $4041, $9B, $41, $65, $E3, $93, $64, $81, $55 );
//
// WPD_CONTENT_TYPE_CONTACT
//   Indicates this object represents contact data (e.g. name/number, or a VCARD file)
DEFINE_GUID(WPD_CONTENT_TYPE_CONTACT, $EABA8313, $4525, $4707, $9F, $0E, $87, $C6, $80, $8E, $94, $35 );
// WPD_CONTENT_TYPE_AUDIO
//   Indicates this object represents audio data (e.g. a WMA or MP3 file) 
DEFINE_GUID(WPD_CONTENT_TYPE_AUDIO, $4AD2C85E, $5E2D, $45E5, $88, $64, $4F, $22, $9E, $3C, $6C, $F0 );
// WPD_CONTENT_TYPE_UNSPECIFIED
//   Indicates this object doesn't fall into the predefined WPD content types 
DEFINE_GUID(WPD_CONTENT_TYPE_UNSPECIFIED, $28D8D31E, $249C, $454E, $AA, $BC, $34, $88, $31, $68, $E6, $34 );
// 
// WPD_CONTENT_TYPE_ALL
//   This content type is only valid as a parameter to API functions and driver commands. It should not be reported as a supported content type by the driver. 
DEFINE_GUID(WPD_CONTENT_TYPE_ALL, $80E170D2, $1055, $4A3E, $B9, $52, $82, $CC, $4F, $8A, $86, $89 );

// WPD_OBJECT_FORMAT_EXIF
//   Image file format (Exchangeable File Format), JEIDA standard 
DEFINE_GUID(WPD_OBJECT_FORMAT_EXIF, $38010000, $AE6C, $4804, $98, $BA, $C5, $7B, $46, $96, $5F, $E7 );

// WPD_OBJECT_FORMAT_WMA
//   Audio file format (Windows Media Audio)
DEFINE_GUID(WPD_OBJECT_FORMAT_WMA, $B9010000, $AE6C, $4804, $98, $BA, $C5, $7B, $46, $96, $5F, $E7 );
// WPD_OBJECT_FORMAT_VCARD2
//   VCARD file format (VCARD Version 2)
DEFINE_GUID(WPD_OBJECT_FORMAT_VCARD2, $BB820000, $AE6C, $4804, $98, $BA, $C5, $7B, $46, $96, $5F, $E7 );

// WPD_OBJECT_FORMAT_ALL
//   This format is only valid as a parameter to API functions and driver commands. It should not be reported as a supported format by the driver.
DEFINE_GUID(WPD_OBJECT_FORMAT_ALL, $C1F62EB2, $4BB3, $479C, $9C, $FA, $05, $B5, $F3, $A5, $7B, $22 );
// WPD_OBJECT_FORMAT_PROPERTIES_ONLY
//   This object has no data stream and is completely specified by properties only.
DEFINE_GUID(WPD_OBJECT_FORMAT_PROPERTIES_ONLY, $30010000, $AE6C, $4804, $98, $BA, $C5, $7B, $46, $96, $5F, $E7 );
//
// WPD_OBJECT_FORMAT_UNSPECIFIED
//   An undefined object format on the device (e.g. objects that can not be classified by the other defined WPD format codes)
DEFINE_GUID(WPD_OBJECT_FORMAT_UNSPECIFIED, $30000000, $AE6C, $4804, $98, $BA, $C5, $7B, $46, $96, $5F, $E7 );
//

end.
