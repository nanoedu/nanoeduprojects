program farplugsetup;

uses
  Forms,
  setupplugfar in 'setupplugfar.pas' {farplugin};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfarplugin, farplugin);
  Application.Run;
end.
