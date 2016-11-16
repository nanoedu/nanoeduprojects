unit uImageAnalysis;

interface

 uses   forms,classes,GlobalType,FourierFiltrat;

type ImageAnalysisDataIn=record
      Lang:integer;
      MainW,MainH:integer;
      SourceData:TMas2;
      SourceNX,SourceNY:integer;
      SourceStep:single;
      SourceStepZ:single;
      ImgTitle, DataUnits, XUnits,YUnits:PChar;
      SensitivityX:single;
      SensitivityY:single;
      FlagLinear:boolean;
      SourceScanMode:byte;
      PScannerName:PChar;
      PScannerFile:PChar;
      PScannerDefFile:PChar;
      PFourierFiltTemplFile:PChar;
      AppHandle:THandle;
      FormHandle:THandle;
      ScanFormHandle:THandle;
      ApproachOptFormHandle:THandle;
      MsgBack:integer;
      MsgScanBack:integer;
      MsgApproachOptBack:integer;
      FlagAllowCalibration:boolean;
    end;
procedure MakeAnalysis(AOwner:TComponent;DataIn:ImageAnalysisDataIn);
procedure ReceiveData(var DataOut:TMas2{ NX,NY:integer});
procedure StopAnalysis;

implementation

 uses   dllImageAnalWnd;

procedure MakeAnalysis(AOwner:TComponent;DataIn:ImageAnalysisDataIn);
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

end.
