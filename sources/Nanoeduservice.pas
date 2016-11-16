unit Nanoeduservice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

type
  TNanoeduControllerDetect = class(TService)
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  NanoeduControllerDetect: TNanoeduControllerDetect;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  NanoeduControllerDetect.Controller(CtrlCode);
end;

function TNanoeduControllerDetect.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TNanoeduControllerDetect.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
   started:=true;
end;

procedure TNanoeduControllerDetect.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
 stopped:=true;
end;

end.
