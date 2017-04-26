library MSVideoLibDemo;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }


uses
  ExceptionLog,
  SysUtils,
  Classes,
  Forms,
  MSVideoDEMO in 'MSVideoDEMO.pas' {MSVideoForm},
  OpenCV_core in '..\Opencv\OpenCV_core.pas',
  OpenCV_highgui in '..\Opencv\OpenCV_highgui.pas',
  OpenCV_imgproc in '..\Opencv\OpenCV_imgproc.pas',
  OpenCV_types in '..\Opencv\OpenCV_types.pas',
  OpenCV_utils in '..\Opencv\OpenCV_utils.pas',
  OpenCV_video in '..\Opencv\OpenCV_video.pas';

{$R *.res}

function StartVideo(AppHandle:THandle;FormHandle:THandle;MsgBack:integer; VLang:integer; configpath:string):boolean;
begin
   Application.Handle:=AppHandle;
   Lang:=vLang;
   MSVideoForm:=TMSVideoForm.Create(Application,configpath);
   MSVideoForm.FormHandle:=FormHandle;
   MSVideoForm.MsgBack:=MsgBack;
   result:=true;
   MSVideoForm.Show;
end;
procedure StopVideo;
begin
   MSVideoForm.Close;
end;


exports StartVideo,StopVideo;

begin
end.
