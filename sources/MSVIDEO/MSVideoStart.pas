unit MSVideoStart;
interface
uses
  SysUtils,
  Classes,
  Forms,
  VfW ,
  VideoSettingsUnit,
  MSVideo;
 function  StartVideo(AppHandle:THandle;FormHandle:THandle;MsgBack:integer; VLang:integer; configpath:string):boolean;
 procedure StopVideo;



implementation
function  StartVideo(AppHandle:THandle;FormHandle:THandle;MsgBack:integer; VLang:integer; configpath:string):boolean;
begin
   Application.Handle:=AppHandle;
   Lang:=vLang;
   MSVideoForm:=TMSVideoForm.Create(Application,configpath);
   MSVideoForm.FormHandle:=FormHandle;
   MSVideoForm.MsgBack:=MsgBack;
   result:=true;
   if flgresult =2 then begin result:=false; MSVideoForm.Close; exit; end;
   MSVideoForm.Show;
end;
procedure StopVideo;
begin
   MSVideoForm.Close;
end;

end.
