program DetectNanoeduController;

uses
  sysutils,
  SvcMgr,
  types,
  windows,
  forms,
  winsvc,
  Nanoeduservice in '..\sources\Nanoeduservice.pas' {NanoeduControllerDetect: TService},
  frAboutService in '..\sources\frAboutService.pas' {About};

{$R *.RES}
function installing: boolean;
begin
result:=findcmdlineswitch('install',['-','\','/'], true) or
findcmdlineswitch('uninstall',['-','\','/'], true);
end;
function startservice: boolean;
var mgr, svc: integer;
username, servicestartname: string;
config: pointer;
size: dword;
begin
result:=false;
mgr:=openscmanager(nil, nil, sc_manager_all_access);
if mgr <> 0 then
begin
svc:=openservice(mgr, pchar('myservice'), service_all_access);
result:=svc <> 0;
if result then
begin
queryserviceconfig(svc, nil, 0, size);
config:=allocmem(size);
try
queryserviceconfig(svc, config, size, size);
servicestartname:=pqueryserviceconfig(config)^.lpservicestartname;
if comparetext(servicestartname, 'localsystem') = 0 then
servicestartname:='system';
finally
dispose(config);
end;
closeservicehandle(svc);
end;
closeservicehandle(mgr);
end;
if result then
begin
size:=256;
setlength(username, size);
getusername(pchar(username), size);
setlength(username, strlen(pchar(username)));
result:=comparetext(username, servicestartname) = 0;
end;
end;

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
(*  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TNanoeduControllerDetect, NanoeduControllerDetect);
  Application.CreateForm(TAbout, About);
  Application.Run;

  begin
  *)
if installing or startservice then
begin
svcmgr.application.initialize;
fromservice:=true;
svcmgr.application.createform(tabout, about);
svcmgr.application.createform(TNanoeduControllerDetect, NanoeduControllerDetect);
svcmgr.application.run;
end
else
begin
forms.application.showmainform:=false;
forms.application.initialize;
fromservice:=false;
forms.application.createform(tabout, about);
forms.application.createform(TNanoeduControllerDetect, NanoeduControllerDetect);
forms.application.run;
end;
end.

end.
