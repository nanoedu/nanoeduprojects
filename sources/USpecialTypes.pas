unit USpecialTypes;

interface
uses
PortableDeviceApiLib_TLB,PortableDeviceConst;

const MAX_PATH = 156;
 type WideCharArray = array [1..81] of WideCHAR;
      PWideCharArray = ^WideCharArray;

 WCPathArray = array [1..MAX_PATH] of WideCHAR;
      PWCPathArray = ^WCPathArray;

  type PIPortableDeviceValues = ^IPortableDeviceValues;
implementation

end.
