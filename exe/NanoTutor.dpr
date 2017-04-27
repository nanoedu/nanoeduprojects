{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O-,P+,Q+,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}

//201007
program NanoTutor;

uses
  ExceptionLog,
  OneHist in '..\sources\OneHist.pas',
  Forms,
  frSectionDraw in '..\sources\frSectionDraw.pas' {Section},
  fHelpFlash in '..\sources\fHelpFlash.pas' {fHelpHtml},
  frResonance in '..\sources\frResonance.pas' {AutoResonance},
  frParInput in '..\sources\frParInput.pas' {FrameParInput: TFrame},
  frSetInteraction in '..\sources\frSetInteraction.pas' {SetInteraction},
  frTools in '..\sources\frTools.pas' {Imagetools},
  frOpenGlDraw in '..\sources\frOpenGlDraw.pas' {frmGL},
  GlobalDcl in '..\sources\GlobalDcl.pas',
  SystemConfig in '..\sources\SystemConfig.pas',
  SioCSPM in '..\sources\SioCSPM.pas',
  mHardWareOpt in '..\sources\mHardWareOpt.pas',
  frSignalsMod in '..\sources\frSignalsMod.pas' {SignalsMod: TFrame},
  mSetSignal in '..\sources\mSetSignal.pas' {SetSignal},
  mScanRate in '..\sources\mScanRate.pas',
  ScanDrawThreadLitho in '..\sources\ScanDrawThreadLitho.pas',
  ScanWorkThread in '..\sources\ScanWorkThread.pas',
  frSPM_browser in '..\sources\frSPM_browser.pas' {frSPMView},
  spm_browserclasses in '..\sources\spm_browserclasses.pas',
  frHeader in '..\sources\frHeader.pas' {FileHeaderForm},
  SpmChart in '..\sources\SpmChart.pas',
  uScannerCorrect in '..\sources\uScannerCorrect.pas',
  frScannerCorrVisual in '..\sources\frScannerCorrVisual.pas' {ScannerCorrVisual},
  GlobalVar in '..\sources\GlobalVar.pas',
  Windows,
  frChangeDir in '..\sources\frChangeDir.pas' {ChangeDir},
  uFileOp in '..\sources\uFileOp.pas',
  mSetGridApr in '..\sources\mSetGridApr.pas' {SetGridParam},
  ScanFastDrawThread in '..\sources\ScanFastDrawThread.pas',
  FrSpectroscopyV in '..\sources\FrSpectroscopyV.pas' {SpectroScopyV},
  fShockwave in '..\sources\fShockwave.pas' {ShockWave},
  frMedia in '..\sources\frMedia.pas' {Media},
  ScanDrawThread in '..\sources\ScanDrawThread.pas',
  frSpectroscopy in '..\sources\frSpectroscopy.pas' {Spectroscopy},
  frScanWnd in '..\sources\frScanWnd.pas' {ScanWnd},
  frExperimParams in '..\sources\frExperimParams.pas' {ApproachOpt},
  frScannerMemo in '..\sources\frScannerMemo.pas' {MemoScanner},
  frLightOption in '..\sources\frLightOption.pas' {LightOption},
  frSetMaterialOpt in '..\sources\frSetMaterialOpt.pas' {SetMaterialOption},
  frScale in '..\sources\frScale.PAS' {ScaleGL},
  SurfaceTools in '..\sources\SurfaceTools.pas',
  frNamePal in '..\sources\frNamePal.pas' {NamePal},
  GlobalType in '..\sources\GlobalType.pas',
  frLogo in '..\sources\frLogo.pas' {Logo},
  GlobalFunction in '..\sources\GlobalFunction.pas',
  TrainDrawThread in '..\sources\TrainDrawThread.pas',
  frBeginnerGuide in '..\sources\frBeginnerGuide.pas' {FrBeginner},
  frX0Y0Change in '..\sources\frX0Y0Change.pas' {fX0Y0Change},
  UNanoEduBaseClasses in '..\sources\UNanoEduBaseClasses.pas',
  unanoeduScanClasses in '..\sources\unanoeduScanClasses.pas',
  frReport in '..\sources\frReport.pas' {ReportForm},
  frStepTest in '..\sources\frStepTest.pas' {StepsTest},
  TestStepDrawThread in '..\sources\TestStepDrawThread.pas',
  Video in '..\sources\Video.pas',
  frCurrentLine in '..\sources\frCurrentLine.pas' {CurrentLineWnd},
  UNanoeduInterface in '..\sources\UNanoeduInterface.pas',
  frWelCome in '..\sources\frWelCome.pas' {WellCome},
  UfindProcess in '..\sources\UfindProcess.pas',
  frScriptPlay in '..\sources\frScriptPlay.pas' {ScriptPlay},
  uNanoEduBaseMethodClass in '..\sources\uNanoEduBaseMethodClass.pas',
  uNanoEduClasses in '..\sources\uNanoEduClasses.pas',
  ModuleLoader in '..\sources\ModuleLoader.pas',
  frChooseUnit in '..\sources\frChooseUnit.pas' {FChooseUnit},
  FrControllerTurnOn in '..\sources\FrControllerTurnOn.pas' {FormControllerTurnOn},
  UNanoEduDemoClasses in '..\sources\UNanoEduDemoClasses.pas',
  HHOPENLib_TLB in '..\sources\HHOPENLib_TLB.pas',
  ShockwaveFlashObjects_TLB in '..\sources\ShockwaveFlashObjects_TLB.pas',
  CSPMVar in '..\sources\CSPMVar.pas',
  frLanguage in '..\sources\frLanguage.pas' {frLang},
  frViewConfigFile in '..\sources\frViewConfigFile.pas' {ViewConfigFile},
  frNoFormUnitLoc in '..\sources\frNoFormUnitLoc.pas' {NoFormUnitLoc},
  FrInform in '..\sources\FrInform.pas' {Inform},
  frScanFieldZoom in '..\sources\frScanFieldZoom.pas' {FieldZoom},
  frAbout in '..\sources\frAbout.pas' {FormAbout},
  frScannerTraining in '..\sources\frScannerTraining.pas' {FormScannerTraining},
  frProgress in '..\sources\frProgress.pas' {Progress},
  frDragFormToSave in '..\sources\frDragFormToSave.pas' {DragFormToSave},
  DlgComment in '..\sources\DlgComment.pas' {DlgComnt},
  frChooseSample in '..\sources\frChooseSample.pas' {ChooseSample},
  frChooseLabWork in '..\sources\frChooseLabWork.pas' {Chooselabwork},
  frSetPalette in '..\sources\frSetPalette.pas' {PaletteForm},
  frContrastTopView in '..\sources\frContrastTopView.pas' {frContrast},
  frChooseReportTempl in '..\sources\frChooseReportTempl.pas' {FormLabDlg},
  ProgressDrawThread in '..\sources\ProgressDrawThread.pas',
  RenishawVars in '..\sources\RenishawVars.pas',
  frReniShowDiagn in '..\sources\frReniShowDiagn.pas' {FormReniShDiagn},
  Nanoeduhelp in '..\sources\Nanoeduhelp.pas',
  frRenishawSlowFronts in '..\sources\frRenishawSlowFronts.pas' {FormSlowFronts},
  frRenishawNomogram in '..\sources\frRenishawNomogram.pas' {FormRenishNomogram},
  CreateMDTscan in '..\sources\CreateMDTscan.pas',
  UUpdater in '..\sources\UUpdater.pas' {UpdaterForm},
  frRenishawOsc in '..\sources\frRenishawOsc.pas' {FormRenishawOsc},
  RenishawOscThread in '..\sources\RenishawOscThread.pas',
  ServerForm in '..\sources\ServerForm.pas' {MDTServiceForm},
  frControllerDetect in '..\sources\frControllerDetect.pas' {ControllerDetect},
  SetupAPI in '..\sources\SetupAPI.pas',
  configmgr in '..\sources\configmgr.pas',
  frPositionXYZ in '..\sources\frPositionXYZ.pas' {ScannerPositionXYZ},
  ScannermoveXYZDrawThread in '..\sources\ScannermoveXYZDrawThread.pas',
  frapproachnew in '..\sources\frapproachnew.pas' {Approach},
  MDTStrct in '..\sources\MDTStrct.pas',
  SysUnits in '..\sources\SysUnits.pas',
  frSPM_browserFull in '..\sources\frSPM_browserFull.pas' {frSPMViewFull},
  uImageAnalysis in '..\sources\uImageAnalysis.pas',
  dllImageAnalWnd in '..\sources\imageanalysis\dllImageAnalWnd.pas' {ImgAnalysWnd},
  FourierFiltrat in '..\sources\imageanalysis\FourierFiltrat.pas',
  Interpolation2D in '..\sources\imageanalysis\Interpolation2D.pas',
  MDTFileExport in '..\sources\MDTFileExport.pas',
  ReadandExport in '..\sources\ReadandExport.pas',
  uNewdev in '..\sources\uNewdev.pas',
  SpectrTerraDrawThread in '..\sources\SpectrTerraDrawThread.pas',
  frSpectroscopyTerra in '..\sources\frSpectroscopyTerra.pas' {SpectroscopyTerra},
  NTShellConsts in '..\sources\components\NTShellConsts.pas',
  NTShellCtrls in '..\sources\components\NTShellCtrls.pas',
  frViewLogFile in '..\sources\frViewLogFile.pas' {ViewLogFile},
  NL3LFBLib_TLB in '..\sources\NL3LFBLib_TLB.pas',
  MLPC_APILib_Demo in '..\sources\MLPC_APILib_Demo.pas',
  ResDrawThread in '..\sources\ResDrawThread.pas',
  frSetOSCParams in '..\sources\frSetOSCParams.pas' {OSCParams},
  frDebug in '..\sources\frDebug.pas' {FormLog},
  UDeviceEvents in '..\sources\UDeviceEvents.pas',
  PortableDeviceApiLib_TLB in '..\sources\PortableDeviceApiLib_TLB.pas',
  PortableDeviceTypesLib_TLB in '..\sources\PortableDeviceTypesLib_TLB.pas',
  MtpLib_TLB in '..\sources\MtpLib_TLB.pas',
  MLPC_API2Lib_TLB in '..\sources\MLPC_API2Lib_TLB.pas',
  MLPCVariablesThread in '..\sources\MLPCVariablesThread.pas',
  frProgressMoveto in '..\sources\frProgressMoveto.pas' {ProgressMoveTo},
  ProgressMoveToDrawThread in '..\sources\ProgressMoveToDrawThread.pas',
  TestTIDrawThread in '..\sources\TestTIDrawThread.pas',
  SpectrDrawThread in '..\sources\SpectrDrawThread.pas',
  SpectrSTMDrawThread in '..\sources\SpectrSTMDrawThread.pas',
  MLPC_API2DEMOLIB in '..\sources\MLPC_API2DEMOLIB.pas',
  MLPC_APILib_TLB in '..\sources\MLPC_APILib_TLB.pas',
  NL3LFBLib_TLBDemo in '..\sources\NL3LFBLib_TLBDemo.pas',
  ApproachThreadDrawNew in '..\sources\ApproachThreadDrawNew.pas',
  frAdapterService in '..\sources\frAdapterService.pas' {AdapterService},
  ThreadReadFromAdapter in '..\sources\ThreadReadFromAdapter.pas',
  ThreadWriteToAdapter in '..\sources\ThreadWriteToAdapter.pas',
  THreadGetDeviceId in '..\sources\THreadGetDeviceId.pas',
  FullScreenUnit in '..\sources\FullScreenUnit.pas',
  UAdapterService in '..\sources\UAdapterService.pas',
  frUnitInitEtap in '..\sources\frUnitInitEtap.pas' {formInitUnitEtape},
  ushellfunction in '..\sources\ushellfunction.pas',
  frStartWork in '..\sources\frStartWork.pas' {FormStartWork},
  frChangePath in '..\sources\frChangePath.pas' {ChangePath},
  frVideoSoftSetting in '..\sources\frVideoSoftSetting.pas' {VideoSoftSetting},
  FourierProc in '..\sources\imageanalysis\FourierProc.pas',
  ThreadWriteToControllerEEProm in '..\sources\ThreadWriteToControllerEEProm.pas',
  UControllerService in '..\sources\UControllerService.pas',
  ThreadGetControllerParams in '..\sources\ThreadGetControllerParams.pas',
  frSetWorkDir in '..\sources\frSetWorkDir.pas' {SetNewWorkDir},
  GlobalScanDataType in '..\sources\GlobalScanDataType.pas',
  frProgramSettings in '..\sources\frProgramSettings.pas' {FormProgramSettings},
  mMain in '..\sources\mMain.pas' {Main},
  OpenCV_core in '..\sources\Opencv\OpenCV_core.pas',
  OpenCV_highgui in '..\sources\Opencv\OpenCV_highgui.pas',
  OpenCV_imgproc in '..\sources\Opencv\OpenCV_imgproc.pas',
  OpenCV_types in '..\sources\Opencv\OpenCV_types.pas',
  OpenCV_utils in '..\sources\Opencv\OpenCV_utils.pas',
  OpenCV_video in '..\sources\Opencv\OpenCV_video.pas',
  SysUtils,
  MSVideoDEMO in '..\sources\MSVideoDEMO.pas' {MSVideoForm},
  ThreadVideoStream in '..\sources\ThreadVideoStream.pas';

{FormProgramSettings}

// SetupApi in '..\sources\SetupApi.pas';

{$R *.RES}

begin
 // FreeLibrary(GetModuleHandle('OleAut32'));
  Application.Initialize;
//  Logo:=TLogo.Create(Application);
//  Logo.ShowModal;
  flgUnit:=nano;
 {$IFDEF SIMULATOR}
   videofile:=ExtractFilePath(Application.ExeName)+'Data\VideoCameraSimulation\startwork.mp4';
   lang:=1;
   MSVideoForm:=TMSVideoFORM.Create(Application,videofile,true,true);
   MSVideoForm.WindowState:=wsMaximized;
   MSVideoForm.ShowModal;
  {$ELSE}
  {$IFDEF SEM}
    flgUnit:=nano;
   {$ENDIF}
  {$ENDIF}
   videofile:=ExtractFilePath(Application.ExeName)+'Data\VideoCameraSimulation\startwork.mp4';
   if Fileexists(videofile) then
   begin
    lang:=1;
    MSVideoForm:=TMSVideoFORM.Create(Application,videofile,true,true);
    MSVideoForm.WindowState:=wsMaximized;
    MSVideoForm.ShowModal;
   end;

  flgUnit:=nano;
  Application.Title := 'NanoTutor';
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TControllerDetect, ControllerDetect);
  Application.Mainformontaskbar:=True;
  //
  Application.Run;

end.
