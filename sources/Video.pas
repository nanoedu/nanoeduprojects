unit Video;

interface
type
  pStartVideo=function(AppHandle:THandle;FormHandle:THandle;MsgBack:integer;Lang:integer;configpath:string):boolean;
  PStopVideo =procedure;
var
   StartVideo:PStartVideo;
   StopVideo:PStopVideo;
   LibVideoHandle:THandle;

implementation

end.
