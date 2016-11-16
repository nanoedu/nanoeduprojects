

//290705
library MSVideoLib;
uses
  SysUtils,
  Classes,
  Forms,
  VfW in 'VfW.pas',
  VideoSettingsUnit in 'VideoSettingsUnit.pas' {VideoSettings},
  MSVideo in 'MSVideo.pas' {MSVideoForm};

{$R *.res}

function (AppHandle:THandle;FormHandle:THandle;MsgBack:integer; VLang:integer; configpath:string):boolean;
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

exports StartVideo,StopVideo;

end.
