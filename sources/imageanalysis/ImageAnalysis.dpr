//250307
library ImageAnalysis;
uses
  ExceptionLog,
  SysUtils,
  Classes,
  Forms,
  SurfaceTools in '..\SurfaceTools.pas',
  GlobalType in '..\GlobalType.pas',
  FourierFiltrat in 'FourierFiltrat.pas',
  FourierProc in 'FourierProc.pas',
  Interpolation2D in 'Interpolation2D.pas',
  dllImageAnalWnd in 'dllImageAnalWnd.pas' {ImgAnalysWnd};

//  ,FastMM4Messages in '..\..\sources\FastMM4Messages.pas';

{$R *.res}
procedure MakeAnalysis(AOwner:TComponent;DataIn:ImageDataIn);
begin
 Application.Handle:=DataIn.AppHandle;
 ImgAnalysWnd:=TImgAnalysWnd.Create(AOwner,DataIn);
 ImgAnalysWnd.Show;
 ImgAnalysWnd.FormHandle:=DataIn.FormHandle;
 ImgAnalysWnd.ScanFormHandle:=DataIn.ScanFormHandle;
 ImgAnalysWnd.ApproachOptFormHandle:=DataIn.ApproachOptFormHandle;
 ImgAnalysWnd.MsgBack:=DataIn.MsgBack;
 ImgAnalysWnd.MsgScanBack:=DataIn.MsgScanBack;
 ImgAnalysWnd.MsgApproachOptBack:=DataIn.MsgApproachOptBack;
end;

procedure StopAnalysis;
begin
 ImgAnalysWnd.close;
end;

procedure ReceiveData(var DataOut:TMas2{ NX,NY:integer});
var i,j:integer;
begin
 //DataOut.Source:=BackFFtResult;
 for i:=0 to BackFFTResult.NY-1 do
  for j:=0 to BackFFTResult.NX-1 do
    DataOut[j,i]:=round(BackFFTResult.data[j,i]);
 end;

exports
 MakeAnalysis,StopAnalysis,ReceiveData;
end.

