//corrected fast scan video or one frame
// corrected fast scan freebuffer 28/11/16
//  250406  correction path and buffers set
 //190213  litho changed
unit uNanoEduScanClasses;

interface

uses windows,forms,dialogs, SysUtils,GlobalType,CspmVar,classes,
   {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
   uNanoEduBaseMethodClass,frProgress;

type
(*
TWriteMemoryPage=class(TScanMethod)
protected
// запись ини файлов в память адаптера происходит по схеме:
// 0 стр. - оглавление
// 1 стр.-  параметры Моды X
// 2 стр. - Линеаризация по быстрой оси Х
// 3 стр. - Линеаризация по медленной оси Y
// 4 стр.-  параметры Моды Y
// 5 стр. - Линеаризация по быстрой оси Y
// 6 стр. - Линеаризация по медленной оси X
// 7,8,9 стр. -     def X
// 10,11,12 стр. -     def Y
// Поэтому считывать файл на всякий случай сразу с двух страниц
    fPageNmb:integer;
    fDataLen:integer;
  //  DataArray: ArraySpline;
    ScannerOpt: RAdapterOptRecord;
    LinearizationArray:ArrayInt;
    fRecPointersList:TList;
    function   InitAlgorithmParamsFile:integer;    override;
    //function  CreateAlgorithmParamsFile:integer;  override;
    function   InitRegimeVars:integer;  override;
    function   initBuffers() : integer;
    procedure  SetDataIn; overload;   // не перегруженный метод
  //  procedure  SetDataIn(Data_toWrite: ArrayInt)           ;overload;          // не перегруженный метод
  //  procedure  SetDataIn(RecPointersList:TList)            ;overload;          // не перегруженный метод
    function   GetDataLength(Data_toWrite: RAdapterOptRecord):integer; overload;
    function   GetDataLength(Data_toWrite: ArraySpline):integer; overload;
    procedure  StartDraw;    override;
   // procedure Createheaderdata;
   // procedure CreateScannerData(mode:integer; Inifilename:string; var dataArray:TArrayInt);
   // function  WriteData(startPage:integer; dataArray:TArrayInt):integer;

   // procedure StopDraw;            override;
public
 destructor  Destroy; override;
 constructor Create(RecPointersList:TList);  overload;
end;
 *)
TWriteToAdapter=class(TScanMethod)
private
    fDataWriteList:TList;
    function FreeDataWriteList:boolean;
protected
// запись ини файлов в память адаптера происходит по схеме:
// 0 стр. - оглавление
// 1,2 стр.     - X
// 3,4 стр.     - Y
// 5,6  -     def X
// 7,8  -     def Y
// Поэтому считывать файл на всякий случай сразу с двух страниц
    function  InitAlgorithmParamsFile:integer;    override;
    function  InitRegimeVars:integer;             override;
    procedure SetDataIn;                          override;
    procedure StartDraw;                          override;
    function  InitBuffers:integer;                override;
    function  FreeBuffers:integer;                override;
public
 destructor  Destroy;                             override;
end;


TReadfromAdapter=class(TScanMethod)
private
    function GetPagesCount(pages:integer):integer;
protected
    fRPages:integer;
    function  InitAlgorithmParamsFile:integer;    override;
    function  InitRegimeVars:integer;             override;
    function  InitBuffers:integer;                override;
    procedure StartDraw;                          override;
public
 constructor Create(RPages:integer);  overload;
end;

TGetDeviceId=class(TScanMethod)
protected
    function  InitAlgorithmParamsFile:integer;    override;
    function  InitRegimeVars:integer;  override;
    function  InitBuffers:integer;     override;
    procedure StartDraw;               override;
public

end;
TSetControllerParams=class(TScanMethod)
protected
    function  InitAlgorithmParamsFile:integer;    override;
    function  InitRegimeVars:integer;  override;
    function  InitBuffers:integer;     override;
    function  FreeBuffers:integer;        override;
    procedure StartDraw;               override;
public
end;

TGetControllerParams=class(TScanMethod)
protected
    function  InitAlgorithmParamsFile:integer;    override;
    function  InitRegimeVars:integer;  override;
    function  InitBuffers:integer;     override;
    procedure StartDraw;               override;
public

end;

TScanMoveToX0Y0=class(TScanMethod)
protected
    XEnd,YEnd,x0,y0,DAC_ZEnd:integer;
    smX0nm, smY0nm:single;
    MoveToMicrostepDelay:integer;
    function  InitAlgorithmParamsFile:integer;    override;
    function  InitBuffers:integer;     override;
    procedure NonLinearPath;           override;
    procedure LinearPath;              override;
    procedure SetPath;                 override;
    function  InitRegimeVars:integer;  override;
    procedure StartDraw;               override;
    procedure StopDraw;                override;
public
 constructor Create(X0nm,y0nm:single);  overload;
end;



 TScanMoveToZeroPoint=class(TScanMoveToX0Y0)
protected
public
 constructor Create(X0nm,y0nm:single);  overload;
end;


TRenishawMoveToX0Y0=class(TScanMethod)
private
    NXRenishaw, NYRenishaw:integer;
    XEnd,YEnd, x0,y0,DAC_ZEnd:integer;
    LX0nm, LY0nm:single;
    ProgressCal:TProgress;
    function  InitBuffers:integer; override;
    procedure LinearPath;          override;
    procedure SetPath;             override;
    procedure StartDraw;           override;
    procedure StopDraw;            override;
    function  InitRegimeVars:integer;  override;
public
 constructor Create(X0nm,y0nm:single);  overload;
 function    Launch:integer;           override;
end;

TScanCalibrate=class(TScanMethod)
private
 ProgressCal:TProgress;
 function   InitAlgorithmParamsFile:integer;    override;
 function   CreateAlgorithmParamsFile:integer;  override;
 function   InitBuffers:integer; override;
 function   InitBuffersFirstPass:integer;
 procedure  NonLinearPath;       override;
 procedure  NonLinearPathFirstPass;
 procedure  LinearPath;          override;
 procedure  LinearPathFirstPass;
 procedure  SetPath;             override;
 procedure  SetPathFirstPass;
 procedure  SetDataIn;           override;
 procedure  SetDataInFirstPass;
 procedure  GetData;             override; //do not use now
 function   InitRegimeVars:integer;     override;
 procedure  StopDraw;            override;
protected
  procedure StartDraw;           override;
public
 flgAddData:boolean;
 constructor Create;             overload;
 destructor  Destroy;            override;
 function    Launch:integer;     override;
end;

TScannerTrainnig=class(TScanMethod)
PROTECTED
    function  InitAlgorithmParamsFile:integer;    override;
    function  InitRegimeVars:integer;             override;
    function  InitBuffers:integer; override;
    procedure StartDraw;           override;
public
 constructor Create;               overload;
// function    Launch:integer;       override;
end;

TResonance=class(TScanMethod)
private
 fImax,fAmplMax:apitype;
 function    InitAlgorithmParamsFile:integer;    override;
protected
 function    InitBuffers:integer;                override;
 function    InitRegimeVars:integer;             override;
procedure    StartDraw;                          override;
public
 Constructor Create;
 destructor  Destroy;
// function    Launch:integer;            override;
end;

TScannerMoveXYZ=class(TScanMethod)
private
 function    GetRelStep:integer;    //numbers of steps maded  after run java
 function    InitAlgorithmParamsFile:integer;    override;
 function    SetUsersParams:boolean;             override;
protected
 function    InitBuffers:integer;                override;
 function    InitRegimeVars:integer;             override;
 procedure   StartDraw;                          override;
public
 Constructor Create;
 destructor  Destroy;
// function    Launch:integer;     override;
 property    RelStep:Integer     read   GetRelStep;
end;

TRising=class(TScanMethod)
private
 fn:integer;
 function  InitAlgorithmParamsFile:integer;    override;
protected
 function  InitRegimeVars:integer;             override;
 function  InitBuffers:integer;                override;
 procedure StartDraw;                          override;
public
Constructor Create(n:integer);                 overload;
end;

TApproachSFM=class(TScanMethod)
private
 function  GetRelStep:integer;    //numbers of steps maded  after run java
 function  InitAlgorithmParamsFile:integer;    override;
 function  SetUsersParams:boolean;             override;
protected
 function  InitRegimeVars:integer;             override;
 function  InitBuffers:integer;                override;
 procedure StartDraw;                          override;
public
 Constructor Create;
 destructor  Destroy;
 property    RelStep:Integer     read   GetRelStep;
end;

TApproachSTM=class(TApproachSFM)
private
 function  InitAlgorithmParamsFile:integer;    override;
 function  SetUsersParams:boolean;             override;
protected
 function  InitRegimeVars:integer;             override;
public
  Constructor Create;
end;

TTestTI=class(TScanMethod)
private
 function    InitAlgorithmParamsFile:integer;    override;
 function    CreateAlgorithmParamsFile:integer;  override;
 function    InitBuffers:integer;
 function    InitRegimeVars:integer;             override;
// procedure   StopDraw;           override;
protected
 procedure   StartDraw;          override;
public
 function    Launch:integer;   override;
end;

TTopography=class(TScanMethod)
private
protected
 DataArray: Array of integer;
 function    InitAlgorithmParamsFile:integer;    override;
 function    CreateAlgorithmParamsFile:integer;  override;
 procedure   NonLinearPath;      override;
 procedure   LinearPath;         override;
 procedure   SetPath;            override;
 procedure   SetDataIn;          override;
 function    SetUsersParams:boolean;     override;
 procedure   StopDraw;           override;
 function    InitRegimeVars:integer;     override;
 function    InitBuffers:integer;        override;
 procedure   StartDraw;                  override;
 function    FreeBuffers:integer;        override;
public
 Constructor Create;
 function    Launch:integer;   override;
end;

TProfile=class(TTopography)
private
 function    InitAlgorithmParamsFile:integer;    override;
// function    CreateAlgorithmParamsFile:integer;  override;
// procedure   SetDataIn;          override;
// function    SetUsersParams:boolean;     override;
// procedure   StopDraw;           override;
protected
// DataArray: Array of integer;
 function    InitRegimeVars:integer;     override;
// function    InitBuffers:integer;        override;
// procedure   StartDraw;                  override;
// function    FreeBuffers:integer;        override;
public
// Constructor Create;
// function    Launch:integer;   override;
end;

//  FAST
TFastTopo=class(TTopography)
 private
  function   InitAlgorithmParamsFile:integer;    override;
  function   InitBuffers: integer;       override;
 protected

  function   FreeBuffers:integer; override;
  function   InitRegimeVars:integer;      override;
  procedure  StartDraw;          override;
//  function   FreeBuffers:integer;   override;
 public
  function    Launch:integer;   override;
end;

(*
TScannerPhaseAdjust=class(TTopography)
private
  dx:integer;
  U: array of apitype;
  function  InitAlgorithmParamsFile:integer;    override;
  function  CreateAlgorithmParamsFile:integer;  override;
  function  InitBuffers:integer; override;
  procedure LinearPath;          override;
  procedure SetPath;             override;
//  procedure SetDataIn;         override;
// procedure GetData;            override;
  function  InitRegimeVars:integer;      override;
  procedure StopDraw;            override;
protected
  ProgressCal:TProgress;
  procedure  StartDraw;           override;
public
// constructor Create;             overload;
 destructor  Destroy;            override;
 function    Launch:integer;     override;
end;
*)
TMultiTopography=class(TScanMethod)
private
// function  CreateAlgorithmParamsFile:integer;  override;
 procedure NonLinearPath;      override;
 procedure NonLinearPathFirstPass;
 procedure LinearPath;         override;
 procedure LinearPathFirstPass;
 procedure SetPath;            override;
 procedure SetPathFirstPass;
 procedure SetDataIn;          override;
 procedure SetDataInFirstPass;
 function  InitRegimeVars:integer;    override;
 procedure StartDraw;          override;
 procedure StopDraw;           override;
protected
 function    InitBuffers:integer;override;
 function    InitBuffersFirstPass:integer;
public
 Constructor Create;
 Destructor  Destroy;            override;
 function    Launch:integer;     override;
end;

TMultiTurnONFB=class(TScanMethod)
private
 function  InitBuffers:integer;override;
 function  InitRegimeVars:integer;    override;
public
 Constructor Create;
 function    Launch:integer;     override;
end;


TLithoSFM=class(TScanMethod)
private
  DataArray: Array of integer;
  function  InitAlgorithmParamsFile:integer;    override;
  function  CreateAlgorithmParamsFile:integer;  override;
  function  SetUsersParams:boolean;             override;
  procedure NonLinearPath;       override;
  procedure LinearPath;          override;
  procedure SetPath;             override;
  procedure SetDataIn;           override;
protected
  function  InitRegimeVars:integer;      override;
  function  InitBuffers:integer;                override ;
  procedure StartDraw;           override;
  function  FreeBuffers:integer;        override;
public
 Constructor Create;
 //function    Launch:integer;     override;
end;

TSpectroscopySFM=class(TScanMethod)
private
  function  InitAlgorithmParamsFile:integer;    override;
//  function  CreateAlgorithmParamsFile:integer;  override;
  procedure LinearPath;          override;
  procedure SetPath;             override;
  procedure SetDataIn;           override;
  procedure StartDraw;           override;
protected
  function  InitRegimeVars:integer;      override;
  function  InitBuffers:integer; override ;
//  procedure GetData;             override;
public
// U: array of  apitype;
 Constructor Create;
 function    GetnPoints:apitype;
 function   Launch:integer;      override;
 destructor Destroy;             override;
end;

TSpectroscopySFMTerra=class(TSpectroscopySFM)
private
  function  InitAlgorithmParamsFile:integer;    override;
//  function  CreateAlgorithmParamsFile:integer;  override;
  procedure StartDraw;           override;
protected
  function  SetUsersParams:boolean;             override;

// function  InitRegimeVars:integer;      override;
 function  InitBuffers:integer; override ;
public
// U: array of  apitype;
// function    GetnPoints:apitype;
// function    Launch:integer;      override;
 Constructor Create;
end;

TSpectroscopySPTSFM=class(TSpectroscopySFM)  //scan by setpoint
private
  function  CreateAlgorithmParamsFile:integer;  override;
protected
  function  InitRegimeVars:integer;      override;
public
end;

TSpectroscopySTM=class(TScanMethod)
private
   function  InitAlgorithmParamsFile:integer;    override;
//   function  CreateAlgorithmParamsFile:integer;  override;
   procedure LinearPath;          override;
   Procedure SetPath;             override;
   procedure SetDataIn;           override;
//   procedure GetData;             override;
   procedure StartDraw;           override;
protected
   function  InitRegimeVars:integer;     override;
   function  InitBuffers:integer; override;
public
// U: array of apitype;
 Constructor Create;
// function    Launch:integer;      override;
 destructor  Destroy;             override;
end;

TStepTest=class(TScanMethod)
private
  function  InitAlgorithmParamsFile:integer;    override;
  function  InitBuffers:integer; override;
  function  InitRegimeVars:integer;    override;
  procedure StartDraw;           override;
public
end;

TRenishawOsc=class(TScanMethod)
private
  function  InitBuffers:integer; override;
  function  InitRegimeVars:integer;    override;
  procedure StartDraw;           override;
public
 n_Points:integer;
 PulsesCnt:integer;
 reniShowSignal:      array of  apitype;
 reniShowSignal_sl:   array of  apitype;
 signal_scrdetected:  array of  apitype;
 constructor Create;             overload;
 destructor  Destroy;            override;
 function    Launch:integer;       override;
end;

implementation

uses
  UNanoEduInterface, SIOCSPM,  GlobalVar,frNoFormUnitLoc,MLPC_APILib_TLB,{UConsts,}
  GlobalDcl,GlobalFunction,SurfaceTools,ResDrawThread,ApproachThreadDrawNew,ScanDrawThread,
  ScanDrawThreadLitho,ScanFastDrawThread,SpectrDrawThread,SpectrSTMDrawThread,SpectrTerraDrawThread,TrainDrawThread,
  TestTIDrawThread,TestStepDrawThread, Renishawvars, ScannermoveXYZDrawThread, RenishawOscThread,
  frProgressMoveto,THreadReadFromAdapter,THreadWriteToAdapter,ThreadGetDeviceId,ThreadGetControllerParams,ThreadWriteToControllerEEProm;

(*
procedure TWriteMemoryPage.SetDataIn;
var
    i,j:integer;
    cut:integer;
    HNDL:integer;
    icod:integer;
    LRec:integer;
//    StreamFile:TFileStream;
    filename:widestring;
    MaskFilename:string;
    HR:hRESULT;
    lScannerOpt64: RScannerOptRecord64;
    Ptr:PintegerArray;
    PRec:PScannerOptRecord64;
    a:integer;
begin
(*

       with lScannerOpt64 do
       begin
       pagenmb:= byteinversion(fpagenmb);
      // datalength:=ByteInversion(fdatalen);    // длина полезной информации (в целых)
       PageTypeId:=byteinversion(PageTypeId);      // Обратить внимание на PageTypeId!
   //    intLinearizationDate:= ByteInversion(DatetoStr(ScannerOpt.LinearizationDate));     // Convert Data !!
       intDZdclnX:=ByteInversion(Data_toWrite.intDZdclnX);
       intDZdclnY:=ByteInversion(Data_toWrite.intDZdclnY);
       NonLinFieldX:=ByteInversion(Data_toWrite.NonLinFieldX);
       NonLinFieldY:=ByteInversion(Data_toWrite.NonLinFieldY);    //nm
       GridCellSize:=ByteInversion(Data_toWrite.GridCellSize);
       intYBiasTan:=  ByteInversion(Data_toWrite.intYBiasTan);
       intSensitivZ:=  ByteInversion(Data_toWrite.intSensitivZ);
       intSensitivX:=  ByteInversion(Data_toWrite.intSensitivX);
       intSensitivY:=  ByteInversion(Data_toWrite.intSensitivY);
       intI_VTransfKoef:= ByteInversion(Data_toWrite.intI_VTransfKoef);
       for i := 1 to 52 do
          NoINf[i]:=byteinversion(-1);
       end;

 filename:=UserIniFilesPath+MaskLithoFileJava;//FileToMemoryWrite;
 if FileExists(FileName) then DeleteFile(FileName);
 LRec:=Sizeof(lScannerOpt64);

      //HNDL := FileOpen(FileName,fmOpenReadWrite);
      if FileExists(FileName) then DeleteFile(FileName);
  try
  HNDL:=FileCreate(FileName);
      FileSeek(HNDL,0,0);
      icod:=FileWrite(HNDL,lScannerOpt64,LRec);
                   if (icod<>LRec)    then
                begin
                    NoFormUnitLoc.siLang1.MessageDlg('File write error. Maybe you have not rights to create files. Ask administrator',mtWarning,[mbOk],0);
       //             result:=1;
                    exit;
                end;

   finally
      FileClose(HNDL);
  end;

   if FileExists(filename) then
    begin
      JavaControl.Delete(Widestring(MaskLithoFileJava{FileToMemoryWrite}));
     repeat
       application.processmessages;
     until flgfilemaskdeleted;
  // if flgfilealgdel then
    hr:=JavaControl.UpLoad(Widestring(filename),MaskLithoFileJava {FileToMemoryWrite});
    if not Failed(Hr) then
    {$IFDEF DEBUG}
        Formlog.memolog.Lines.add('Scanner params file uploaded');
    {$ENDIF};
   if FlgCurrentUserLevel<>Demo then
     begin
      repeat
       sleep(200);
       application.processmessages;
      until flgfilemaskuploaded;
    // result:=0;      //OK
     end;
 end;

end;

procedure TWriteMemoryPage.StartDraw;
begin
if (CtrlMemoryWriteThr = nil) or (CtrlMemoryWriteThrActive=False) then // make sure its not already running
    begin
     CtrlMemoryWriteThr:= TCtrlMemoryWriteThr.Create;
     CtrlMemoryWriteThrActive := true;
    end;
end;

function TWriteMemoryPage.GetDataLength(Data_toWrite: RScannerOptRecord):integer;
 begin
 result:=Sizeof(Data_toWrite) div Sizeof(integer);
 end;

function TWriteMemoryPage.GetDataLength(Data_toWrite: ArraySpline):integer;
var i, cnt:integer;
begin
  cnt:=1;
  for i := 2 to ArraySplineLen  do
     begin
       if Data_toWrite[i] = 0 then   break
        else   inc(cnt);
     end;
     Result:=cnt;
end;

 destructor  TWriteMemoryPage.Destroy;
 begin
    fRecPointersList.Clear;
    if assigned(fRecPointersList) then Freeandnil(fRecPointersList);
    inherited Destroy;
 end;
(*
 constructor TWriteMemoryPage.Create( Data_toWrite: RScannerOptMod; PageNmb:integer);
 begin
    fPageNmb:=PageNmb;
     fDataLen:=GetDataLength(ScannerOpt);              //// !!
      with ScannerOpt do
   begin
      // DataLength:= fDataLen;
      // intLinearizationDate:= 0;//Data_toWrite.LinearizationDate;
       PageNmb:= fPagenmb;
       PageTypeId:=   AdaptPgType_params;
       intDZdclnX:=   round(Data_toWrite.DZdclnX);
       intDZdclnY:=   round(Data_toWrite.DZdclnY);
       NonLinFieldX:= Data_toWrite.NonLinFieldX;
       NonLinFieldY:= Data_toWrite.NonLinFieldY;    //nm
       GridCellSize:= Data_toWrite.GridCellSize;
       intYBiasTan:=  round(Data_toWrite.YBiasTan);
       intSensitivZ:= round(Data_toWrite.SensitivZ);
       intSensitivX:= round(Data_toWrite.SensitivX);
       intSensitivY:= round(Data_toWrite.SensitivY);
       intI_VTransfKoef:= round(Data_toWrite.I_VTransfKoef);
   end;


 end;
 constructor TWriteMemoryPage.Create( Data_toWrite: ArraySpline; PageNmb:integer);
 begin
    fPageNmb:=PageNmb;
    fDataLen:=GetDataLength(Data_toWrite);
 end;

constructor TWriteMemoryPage.Create(RecPointersList:TList);
 var i:integer;
 begin
 fRecPointersList:=TList.Create;
 for I := 0 to RecPointersList.Count - 1 do
    fRecPointersList.Add(RecPointersList[i]);
 end;
*)
// TWriteToMLPC
destructor  TWriteToAdapter.Destroy;
begin
   FreeDataWriteList;
   inherited;
end;
function  TWriteToAdapter.InitAlgorithmParamsFile:integer;
begin
  with  AlgParams do
 begin
   NChannels:=4;
   NElements:=0;  //dataout    channel
   SizeElements:=0;  //dataout channel
   NGetCountEvent:=1;
   params[0]:=ByteInversion(DataWriteToAdapterList.count);
 end;
end;
 function  TWriteToAdapter.FreeDataWriteList:boolean;
var i:integer;
 begin
   for I := 0 to DataWriteToAdapterList.count- 1 do
   begin
      FreeMem(DataWriteToAdapterList[i]);
   end;
  DataWriteToAdapterList.Clear;
 end;
 function  TWriteToAdapter.InitBuffers:integer;
begin
    Data_out_BufferLength:=7;
    GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
    GetMem(StopBuf,sizeof(integer));
    GetMem(DoneBuf,sizeof(Integer));
    GetMem(DataInBuf,64*sizeof(Integer));
end;
 function  TWriteToAdapter.FreeBuffers:integer;
 begin
  inherited Freebuffers;
  FreeMem(DataInBuf);
 end;
function  TWriteToAdapter.InitRegimeVars:integer;
begin
 InitAlgorithmParamsFile;
 CreateAlgorithmParamsFile;
 if not flgClearAdapter then AlgorithmJava:=WideString( WriteToMLPCScript)
                        else AlgorithmJava:=WideString( ClearAdapterScript);
// SetDataIn;
 InitBuffers;
end;
procedure  TWriteToAdapter.Startdraw;
begin
if ( WriteToAdapterThread= nil) or (WriteToAdapterThreadActive=False) then // make sure its not already running
    begin
     WriteToAdapterThread:= TWriteToAdapterThread.Create;
     WriteToAdapterThreadActive := true;
    end;
end;

procedure  TWriteToAdapter.SetDatain;
var
    i,j:integer;
    cut:integer;
    HNDL:integer;
    icod:integer;
    LRec:integer;
    filename:widestring;
    MaskFilename:string;
    HR:hRESULT;
    Stream:TfileStream;
begin

  if not flgClearAdapter then
  begin
   maskfilename:=MaskLithoFileJavaPath+MaskLithoFileJava;
   LRec:=64*Sizeof(integer);
   if FileExists(maskfilename) then begin DeleteFile(maskfilename)end;
    try
     Stream:=TFileStream.Create(maskfilename, fmCreate);
      for I := 0 to DataWriteToAdapterList.count- 1 do
     begin
        Stream.WriteBuffer(DataWriteToAdapterList[i]^,LRec);
     end;

     
//  
(*   try
     HNDL:=FileCreate(maskfilename);
     for I := 0 to DataWriteToAdapterList.count- 1 do
     begin
          icod:=FileWrite(HNDL,DataWriteToAdapterList[i]^,LRec);
         if (icod<>LRec)    then
         begin
           NoFormUnitLoc.siLang1.MessageDlg('File write error. Maybe you have not rights to create files. Ask administrator',mtWarning,[mbOk],0);
           exit;
        end;
     end;
    finally
      FileClose(HNDL);
    end;
    *)
    finally
      FreeAndNil(Stream);
    end;
  if Assigned(JavaControl) then
  begin
   if FileExists(maskfilename) then
    begin
      JavaControl.Delete(Widestring(MaskLithoFileJava));
     repeat
       application.processmessages;
     until flgfilemaskdeleted;

     sleep(3000);
  // if flgfilealgdel then
    hr:=JavaControl.UpLoad(Widestring(maskfilename),MaskLithoFileJava);
   {$IFDEF DEBUG}
      if not Failed(Hr) then  Formlog.memolog.Lines.add('litho mask has uploaded')
                        else  Formlog.memolog.Lines.add('litho mask  upload error!');
   {$ENDIF};
     if FlgCurrentUserLevel<>Demo then
     begin
      repeat
       sleep(200);
       application.processmessages;
      until flgfilemaskuploaded;
    // result:=0;      //OK
     end;
   end;
  end;
 end;
end;



function  TReadfromAdapter.InitAlgorithmParamsFile:integer;
begin
  with  AlgParams do
  begin
   NChannels:=3;
   NElements:=0;  //dataout    channel
   SizeElements:=0;  //dataout channel
   NGetCountEvent:=0;
   params[0]:=ByteInversion(fRPages);
 end;
end;

function  TReadfromAdapter.InitBuffers:integer;
begin
    Data_out_BufferLength:=GetPagesCount(fRPages)*64;
    GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
    GetMem(StopBuf,sizeof(integer));
    GetMem(DoneBuf,sizeof(Integer));
end;
function TReadfromAdapter.GetPagesCount(pages:integer):integer;
var i:integer;
    mask:Integer;
begin
   result:=0;
   mask:=$00000001;
   for i:=0 to 16 do
   begin
     if (pages and Mask)=1 then inc(result);
     pages:=pages shr 1;
   end;
end;

function  TReadfromAdapter.InitRegimeVars:integer;
begin
 InitAlgorithmParamsFile;
 CreateAlgorithmParamsFile;
 AlgorithmJava:=WideString(ReadFromMLPCScript);
 InitBuffers;
end;

procedure  TReadfromAdapter.StartDraw;
begin
 if not assigned(ReadFromAdapterThread) or (not ReadFromAdapterThreadActive) then // make sure its not already running
       begin
           ReadFromAdapterThread:= TReadFromAdapterThread.Create;
           ReadFromAdapterThreadActive := True;
       end ;
end;

 constructor TReadfromAdapter.Create(RPages:integer);
// var i,shift:integer;
// const mask=$00000001;
 begin
 inherited Create;
 fRPages:=RPages;
(* fRPages:=0;
  for I := 0 to 7 do
  begin
    if (RPages and mask)=1 then inc(fRPages);
    RPages:=RPages shr 1;
  end;
  *)
 end;


function  TGetDeviceId.InitRegimeVars:integer;
begin
 InitAlgorithmParamsFile;
 CreateAlgorithmParamsFile;
 AlgorithmJava:=WideString(GetDeviceIdScript);
 InitBuffers;
end;
function  TGetDeviceId.InitAlgorithmParamsFile:integer;
begin
  with  AlgParams do
  begin
   NChannels:=3;
   NElements:=1;  //dataout    channel
   SizeElements:=2;//2;  //dataout channel
   NGetCountEvent:=1;
  end;
 end;

 function  TGetDeviceId.InitBuffers:integer;
 begin
    GetMem(StopBuf,sizeof(integer));
    GetMem(DoneBuf,sizeof(Integer));
    GetMem(DataBuf,AlgParams.SizeElements*AlgParams.NElements*sizeof(Integer));
 end;
 procedure TGetDeviceId.StartDraw;
 begin
     if not assigned(GetDevIdThread) or (not GetDevIdThreadActive) then // make sure its not already running
       begin
           GetDevIdThread:= TThreadGetDevId.Create;
           GetDevIdThreadActive := True;
       end ;
 end;


function  TSetControllerParams.InitRegimeVars:integer;
begin
 InitAlgorithmParamsFile;
 CreateAlgorithmParamsFile;
 AlgorithmJava:=WideString(WriteNumbToController);
 InitBuffers;
end;
function  TSetControllerParams.InitAlgorithmParamsFile:integer;
begin
  with  AlgParams do
  begin
   NChannels:=4;
   NElements:=1;  //dataout    channel
   SizeElements:=4;  //dataout channel
   NGetCountEvent:=1;
  end;
 end;

 function TSetControllerParams.InitBuffers:integer;
 begin
    GetMem(StopBuf,sizeof(integer));
    GetMem(DataInBuf,4*sizeof(integer));
    GetMem(DoneBuf,sizeof(Integer));
    GetMem(DataBuf,AlgParams.SizeElements*AlgParams.NElements*sizeof(Integer));
 end;
function  TSetControllerParams.FreeBuffers:integer;
begin
inherited FreeBuffers;
 Freemem(DataInBuf);
end;
 procedure TSetControllerParams.StartDraw;
 begin
     if not assigned(SetControllerParamsThread) or (not SetControllerParamsThreadActive) then // make sure its not already running
       begin
           SetControllerParamsThread:= TThreadSetControllerParams.Create;
           SetControllerParamsThreadActive := True;
       end ;
 end;
function  TGetControllerParams.InitRegimeVars:integer;
begin
 InitAlgorithmParamsFile;
 CreateAlgorithmParamsFile;
 AlgorithmJava:=WideString(GetControllerIDScript);
 InitBuffers;
end;

function  TGetControllerParams.InitAlgorithmParamsFile:integer;
begin
  with  AlgParams do
  begin
   NChannels:=3;
   NElements:=1;  //dataout    channel
   SizeElements:=32;  //dataout channel
   NGetCountEvent:=1;
  end;
 end;

 function TGetControllerParams.InitBuffers:integer;
 begin
    GetMem(StopBuf,sizeof(integer));
    GetMem(DoneBuf,sizeof(Integer));
    GetMem(DataBuf,AlgParams.SizeElements*AlgParams.NElements*sizeof(Integer));
 end;
 procedure TGetControllerParams.StartDraw;
 begin
     if not assigned(GetControllerParamsThread) or (not GetControllerParamsActive) then // make sure its not already running
       begin
           GetControllerParamsThread:= TThreadGetControllerParams.Create;
           GetControllerParamsActive := True;
       end ;
 end;


(*// TWriteToMLPC
constructor TWriteToMLPC.Create(InDataArray: ArrayInt);
var i,L:integer;
begin
 inherited Create;
 L:= length(InDataArray);
 SetLength(DataArray,L);
 for I := 0 to L - 1 do
   DataArray[i]:=InDataArray[i];
 end;
destructor  TWriteToMLPC.Destroy;
begin
  Finalize(DataArray);
  inherited;
end;
function  TWriteToMLPC.InitAlgorithmParamsFile:integer;
var L,i:integer;
begin
L:= length(DataArray);
for i := 0 to L - 1 do
    DataArray[i]:=byteinversion( DataArray[i]);
end;

function  TWriteToMLPC.CreateAlgorithmParamsFile:integer;
var HNDL:integer;
    icod:integer;
    L,i:integer;
//    StreamFile:TFileStream;
    filename:widestring;
    DatBuf:PInt;
 begin
  result:=0;
  L:= length(DataArray);
  filename:=InitParamFileJavaPath+InitParamFileJava;
 if FileExists(FileName) then DeleteFile(FileName);
  try
  HNDL:=FileCreate(FileName);
      try
      GetMem(DatBuf,L*sizeof(integer));
    except
              on EOutOfMemory        do
              NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 2',mtWarning,[mbOk],0);
    end;

    for i:=0 to L-1  do
      PintegerArray(DatBuf)[i]:=round(DataArray[i]);
      icod:=FileWrite(HNDL,DatBuf^,L*sizeof(integer));
    if (icod<>L*sizeof(integer)) then
     raise Exception.Create('File Write ERROR (Datas)');
       FreeMem(DatBuf);
  finally
      FileClose(HNDL);
  end;
end;
function  TWriteToMLPC.InitRegimeVars:integer;
begin
 InitAlgorithmParamsFile;
 CreateAlgorithmParamsFile;
 AlgorithmJava:=WideString( WriteToMLPCScript);
// InitBuffers;
// SetSpeed;
end;


function TWriteToMLPC.Launch:integer;
begin
 result:=0;
 InitRegimeVars;
 if StartWork(AlgorithmJava)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
// StartDraw;    // Запускать поток, ожидающий конец записи
// StopDraw;
// WaitStopWork;
// ScanWorkDone;
// FreeBuffer;
end;

function  TReadFromMLPC.InitAlgorithmParamsFile:integer;
begin
     AlgReadfromMLPCParams.StartPage:=byteinversion(fstartPage);
     AlgReadfromMLPCParams.PagesNmb:= byteinversion(fpagesnmb);
end;
function  TReadfromMLPC.CreateAlgorithmParamsFile:integer;
   var HNDL:integer;
    icod:integer;
    LRec:integer;
//    StreamFile:TFileStream;
    filename:widestring;
 begin
  result:=0;
  LRec:=Sizeof(AlgMoveToParams);
  filename:=InitParamFileJavaPath+InitParamFileJava;
 if FileExists(FileName) then DeleteFile(FileName);
  try
  HNDL:=FileCreate(FileName);
   icod:=FileWrite(HNDL,AlgReadfromMLPCParams,LRec);
    if (icod<>LRec)    then
    begin
      NoFormUnitLoc.siLang1.MessageDlg('File write error. Maybe you have not rights to create files. Ask administrator',mtWarning,[mbOk],0);
      result:=1;
      exit;
    end;
  finally
      FileClose(HNDL);
  end;

end;

function  TReadfromMLPC.InitBuffers:integer;
begin
Data_out_BufferLength:=fPagesnmb*64;
GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;

function  TReadfromMLPC.InitRegimeVars:integer;
begin
 InitAlgorithmParamsFile;
 CreateAlgorithmParamsFile;
 AlgorithmJava:=WideString(ReadFromMLPCScript);
 InitBuffers;
end;
  //  procedure StartDraw;           override;
  //  procedure StopDraw;            override;
  //  procedure GetData;             override;


procedure  TReadfromMLPC.StartDraw;
begin
 if not assigned(ReadMLPCThread) or (not ReadMLPCThreadActive) then // make sure its not already running
       begin
           ReadMLPCThread:= TReadMLPCThread.Create;
           ReadMLPCThreadActive := True;
       end ;
end;

 constructor TReadfromMLPC.Create(startPage:integer; pagesnmb:integer);
 begin
 inherited Create;
  fstartPage:=startPage;
  fPagesnmb:=pagesnmb;
 end;

 destructor  TReadfromMLPC.Destroy;
begin
 // Finalize(DataArray);
  inherited;
end;
(* function    TReadfromMLPC.Launch:integer;
 begin
 result:=0;
 InitRegimeVars;
 if StartWork(AlgorithmJava)<>0 then
 begin
  FreeBuffer;
  result:=1;
  exit;
 end;
 StartDraw;
 end;
*)
 (*function  TGetDeviceId.InitRegimeVars:integer;
 begin
  AlgorithmJava:=WideString(GetDeviceIdScript);
  InitBuffers;
 end;
  
 function  TGetDeviceId.InitBuffers:integer;
 begin
    Data_out_BufferLength:=1;
    GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
 end;
 procedure TGetDeviceId.StartDraw;
 begin
     if not assigned(GetDevIdThread) or (not GetDevIdThreadActive) then // make sure its not already running
       begin
           GetDevIdThread:= TGetDevIdThread.Create;
           GetDevIdThreadActive := True;
       end ;
 end;
   
 constructor TGetDeviceId.Create;
 begin
   inherited Create;
 end;
 destructor TGetDeviceId.Destroy;
 begin
   inherited Destroy;
 end;
*)
(* function    TGetDeviceId.Launch:integer;
 begin
 result:=0;
 InitRegimeVars;
 if StartWork(AlgorithmJava)<>0 then
 begin
  FreeBuffer;
  result:=1;
  exit;
 end;
 StartDraw;
 end;
*)

//TScanMoveToX0Y0
constructor TScanMoveToX0Y0.Create(X0nm,y0nm:single);
var t:extended;
begin

 inherited Create;
                  { TODO : 041012 }
 X0:=-round((X0nm+Scanparams.xshift)*TransformUnit.XPnm_d)+CSPMSignals[8].MaxDiscr;       //discrets   add P
 y0:=-round((y0nm+Scanparams.yshift)*TransformUnit.yPnm_d)+CSPMSignals[9].MaxDiscr;       //discrets   add P
 XEnd:=Api.DacX;
 YEnd:=Api.DacY;
 t:= (Abs(X0-XEnd)+abs(Y0-YEnd))/Scanparams.DiscrNumInMicroStep*Scanparams.MicrostepDelay;
 ScanParams.ScanLineTime:=round(t);

// Y0:=round((Y0nm+Scanparams.yshift)*TransformUnit.YPnm_d);       //Add P
// X0:=round((X0nm+Scanparams.xshift)*TransformUnit.XPnm_d);       //discrets   add P/ Y0:=-round((Y0nm+Scanparams.yshift)*TransformUnit.YPnm_d*(MaxDATAType-MinDATATYPE)/MaxDATAType)+MaxDATAType;       //Add P
 MoveToMicrostepDelay:=ScanParams.MicrostepDelay;
// InitRegimeVars;
end;

constructor TScanMoveToZeroPoint.Create(X0nm,y0nm:single);
begin
 inherited Create;                     { TODO : 180608 }
 X0:=-round((X0nm)*TransformUnit.XPnm_d)+CSPMSignals[8].MaxDiscr;       //discrets   add P
 Y0:=-round((Y0nm)*TransformUnit.YPnm_d)+CSPMSignals[9].MaxDiscr;       //Add P
// InitRegimeVars;
end;

function TScanMoveToX0Y0.InitRegimeVars:integer;
begin
 InitAlgorithmParamsFile;
 CreateAlgorithmParamsFile;
 AlgorithmJava:=WideString(MovetoScrpt);
 InitBuffers;
 SetSpeed;
end;

procedure TScanMoveToX0Y0.SetPath;
begin
  LinearPath;
end;

function  TScanMoveToX0Y0.InitAlgorithmParamsFile:integer;
 begin
  with  AlgParams do
 begin
   NChannels:=MoveToScanParams.nchannels;
   NElements:=0;  //dataout    channel
   SizeElements:=0;  //dataout channel
   NGetCountEvent:=1;
   params[0]:=ByteInversion(X0);
   params[1]:=ByteInversion(Y0);
   params[2]:=ByteInversion(MoveToMicrostepDelay);
   params[3]:=ByteInversion(ScanParams.DiscrNumInMicroStep);
   params[4]:=ByteInversion(ScanParams.ScanLineTime);
 end;
end;

function TScanMoveToX0Y0.InitBuffers;
begin
  GetMem(StopBuf,sizeof(integer));
  GetMem(DoneBuf,sizeof(Integer));
  GetMem(DataBuf,sizeof(Integer));
end;

procedure TScanMoveToX0Y0.LinearPath;
begin
end;  {LinearPath}

procedure TScanMoveToX0Y0.NonLinearPath;
begin
end; {NonLinearPath}

procedure TScanMoveToX0Y0.StartDraw;
begin
 ProgressMoveTo:=TProgressMoveTo.Create(Application);
 ProgressMoveTo.Show;
 ProgressMoveTo.StartMoveDraw(x0,y0,xend,yend);
end;

procedure TScanMoveToX0Y0.StopDraw;
begin
end;

constructor TRenishawMoveToX0Y0.Create(X0nm,y0nm:single);
begin
 inherited Create;
// X0:=round(X0nm*TransformUnit.XPnm_d);       //discrets   add P
// Y0:=round(Y0nm*TransformUnit.YPnm_d);
 X0:=round((X0nm+Scanparams.xshift)*TransformUnit.XPnm_d);       //discrets   add P
 Y0:=round((Y0nm+Scanparams.yshift)*TransformUnit.YPnm_d);       //Add P
 LX0nm:=X0nm;
 LY0nm:=Y0nm;
 NXRenishaw:=round((X0nm{+ScanParams.Xshift}-ScanParams.XPrevious)/RenishawParams.Period_nm);
 NYRenishaw:=round((Y0nm{+ScanParams.Yshift}-ScanParams.YPrevious)/RenishawParams.Period_nm);
   end;

function TRenishawMoveToX0Y0.InitRegimeVars:integer;
begin
(* DAC_ZEnd:=API.DACZ;
 XEnd:=round((scanparams.xshift+scanparams.XPrevious)*TransformUnit.XPnm_d);//(API.DACX);
 YEnd:=round((scanparams.yshift+scanparams.YPrevious)*TransformUnit.YPnm_d);//abs(API.DACY);
 Scanparams.sz:=1;
 Scanparams.flgAquiAdd:=false;
 API.PMSPEED:=0;
 InitBuffers;
 SetSpeed;
 if NXRenishaw>0 then  SetCommonVar(adr84,word(-1))// aPRIM_STEP_X     // forward
                 else  SetCommonVar(adr84,word(1));///aPRIM_STEP_X      // backward
 if NYRenishaw>0 then  SetCommonVar(adr86,word(-1))//aPRIM_STEP_Y
                 else  SetCommonVar(adr86,word(1));//aPRIM_STEP_Y
 SetPath;
 *)
end;
function TRenishawMoveToX0Y0.InitBuffers;
begin
  PathLength:=4;
  data_in_BufferLength:=1;
  data_out_BufferLength:=1;
  GetMem(DataBuf,data_out_BufferLength*sizeof(data_out_type));
end;

procedure TRenishawMoveToX0Y0.LinearPath;
begin
//  PWordArray(data_path)[0]:= word(abs(NXRenishaw));
//	PWordArray(data_path)[1]:= word(abs(NYRenishaw));
//	PWordArray(data_path)[2]:= word(RenishawParams.noiseW_discr);     // 1 ???
end; {NonLinearPath}

procedure TRenishawMoveToX0Y0.SetPath;
begin
  LinearPath;
end;

procedure TRenishawMoveToX0Y0.StartDraw;
begin
 ProgressMoveto:=TProgressMoveto.Create(Application);
 ProgressMoveto.Show;
 ProgressMoveto.StartMoveDraw(x0,y0,xend,yend);
end;

procedure TRenishawMoveToX0Y0.StopDraw;
begin
 Progresscal.Close;
 FreeAndNil(ProgressCal);
end;

function TRenishawMoveToX0Y0.Launch:integer;
var scanscript:string;
 const   RenishawMoveto0Scrpt:string='rsmoveto0.bin';
begin
 RenishawMoveto0Scrpt:='rsmoveto0.bin';
 scanscript:=RenishawMoveto0Scrpt;
 result:=0;
 InitRegimeVars;
 if StartWork(scanscript)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
 StartDraw;
 StopDraw;
 WaitStopWork;
 ScanWorkDone;
   with ScanParams do
   begin
      XPrevious:=LX0nm{+ScanParams.Xshift};      //relative
      YPrevious:=LY0nm{+ScanParams.Yshift};
   end;
 FreeBuffers;
end;
//  TScanCalibrate
destructor TScanCalibrate.Destroy;
begin
  inherited;
end;

constructor TScanCalibrate.Create;
var  valDiscr:apitype;
begin
 inherited;
    case   ScanParams.ScanMethod of
 (*Topography:
            begin
             if STMflg then API.ADCMCH_ENA:=8// 0 SetCommonVar(ADC_MCH_ENA,8)   //current
                       else API.ADCMCH_ENA:=32;//8 SetCommonVar(ADC_MCH_ENA,0); //UAM
            end;
      Phase:begin
             API.ADCMCH_ENA:=1;//SetCommonVar(ADC_MCH_ENA,1);  //turn on UFM
             API.SDGAIN_FM:=ApproachParams.Gain_FM;//128;//SetCommonVar(SD_GEN_M,128);   //set zero other
            end;
      UAM:   API.ADCMCH_ENA:=32;//(ADC_MCH_ENA,32);
  *)
  Current:begin
              valDiscr:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
              API.DACVt:=apitype(valDiscr);//SetCommonVar(DAC_VT,apitype(valDiscr));
          end;
FastScan,
FastScanPhase:begin
               if STMflg then
               begin
                 valDiscr:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
                 API.DACVT:=apitype(valDiscr);// SetCommonVar(DAC_VT,apitype(valDiscr));
               end
               else  //SFM
               begin
               end;
             end;
        end;    //case
end;

function  TScanCalibrate.InitRegimeVars:integer;
VAR I,J:INTEGER;
begin
  AlgorithmJava:=WideString(ScanMScrpt); //wide
 ScanParams.sz:=1;
 Scanparams.flgAquiAdd:=false;
      case  ScanParams.ScanMethod of
 Phase,UAM,Current,
 FastScan,
 FastScanPhase:
           begin
             ScanParams.sz:=2;
             Scanparams.flgAquiAdd:=true;
           end;
             end;
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
     ScanData.AquiAdd.Data:=nil;
     ScanData.AquiTopo.Data:=nil;
     ScanData.AquiTopo.Nx   := ScanParams.Nx;
     ScanData.AquiTopo.Ny   := ScanParams.Ny;
     ScanData.AquiTopo.XStep:= ScanParams.X/ScanParams.Nx;  ;
     try
       SetLength(ScanData.AquiTopo.Data,ScanParams.Nx,ScanParams.Ny);   //23.11.01   x->y

      for i:=0 to ScanParams.Nx-1 do
        for j:=0 to  ScanParams.Ny-1 do ScanData.AquiTopo.Data[i,j]:=0;
           except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
           end;
   if Scanparams.flgAquiAdd then
      begin
        ScanData.AquiAdd.Nx:=ScanData.AquiTopo.Nx;
        ScanData.AquiAdd.Ny:=ScanData.AquiTopo.Ny;
        ScanData.AquiAdd.XStep:=ScanData.AquiTopo.XStep;
       try
        SetLength(ScanData.AquiAdd.Data,ScanParams.Nx,ScanParams.Ny);   //23.11.01   x->y
       for i:=0 to ScanParams.Nx-1 do
        for j:=0 to  ScanParams.Ny-1  do ScanData.AquiAdd.Data[i,j]:=0;
       except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
       end;
      end;
  case flgFirstpass of
true: begin
       InitBuffersFirstPass;
       SetPathFirstPass;
       SetDatainFirstPass;
      end;
false:begin
       InitBuffers;
//       SetPath;
//       SetDatain;
      end;
        end;
  //       SetSpeed;
end;

function TScanCalibrate.Launch:integer;
var ScanScript:string;
begin
 result:=0;
 InitRegimeVars;
 case   FlgFirstPass of
 true:  AlgorithmJava:=widestring(ScanMScrpt);
 false: AlgorithmJava:=widestring(ScanMIIScrpt);
          end;
 if StartWork(AlgorithmJava)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
 StartDraw;
end;

procedure TScanCalibrate.LinearPath;
var
 j,k,N:integer;
 JMP:integer;
 Shift:integer;
begin
(* Shift:=0;
    //Only one Scan line and back
         //    f.path_count:=PathLength;
             j:=0;
             k:=0;
             N:=ScanParams.ScanPoints;
        while j<N do
         begin
              case  ScanParams.ScanPath of
     Multi,OneX:begin
            JMP:=JMPX[j];
            PWordArray(data_path)[k]  := word($4000 or 1) ;     //  x
          end;
     MultiY,OneY:begin
      	    JMP:=JMPY[j];
            PWordArray(data_path)[k]  := word($C000 or 1) ;     //  y
          end;
                 end;
            PWordArray(data_path)[k+1]:= word(JMP);
            inc(j);
            k:=k+2;
        end;     //N
          J:=N-1;
       while j>=0 do //>=1   { TODO : 060406 }
       begin
                case  ScanParams.ScanPath of
Multi,OneX: begin
             PWordArray(data_path)[k]:= word($4000 or 1) ;     // back x
             JMP:=-JMPX[j];
            end;
MultiY,OneY:begin
      	     PWordArray(data_path)[k]:= word($C000 or 1) ;     // back Y
             JMP:=-JMPY[j];
            end;
                    end;
            PWordArray(data_path)[k+1]:=word(JMP);
            dec(j);
            k:=k+2;
         end;
         *)
end;  {LinearPath}

procedure TScanCalibrate.NonLinearPath;
var j,k,N,MStepsN,MStepsM:integer;
  JMP:integer;
begin
(*  case  ScanParams.ScanPath of
  Multi,OneX:begin
        MStepsN:=MStepsX;
        MStepsM:=MStepsY;
       end;
 MultiY,OneY:begin
        MStepsN:=MStepsY;
        MStepsM:=MStepsX;
       end;
         end;
             j:=0;
             k:=0;
             N:=ScanParams.ScanPoints;
        while j<N do
         begin
              case  ScanParams.ScanPath of
     Multi,OneX:begin
            JMP:=MStepsN;
            PWordArray(data_path)[k]  := word($4000 or 1) ;     //  x
           end;
     MultiY,OneY:begin
      	    JMP:=MStepsN;
            PWordArray(data_path)[k]  := word($C000 or 1) ;     //  y
           end;
                 end;
            PWordArray(data_path)[k+1]:= word(JMP);
            inc(j);
            k:=k+2;
        end;     //N
          J:=N-1;
       while j>=0 do
           begin
                case  ScanParams.ScanPath of
      Multi,OneX:begin
             PWordArray(data_path)[k]:= word($4000 or 1) ;     // back x
             JMP:=-MStepsN;
           end;
      MultiY,OneY:begin
        	   PWordArray(data_path)[k]:= word($C000 or 1) ;     // back Y
             JMP:=-MStepsN;
           end;
              end;
            PWordArray(data_path)[k+1]:=word(JMP);
            dec(j);
            k:=k+2;
         end;
       *)  
end; {NonLinearPath}


Procedure TScanCalibrate.SetPath;
begin
 if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') and (not FlgReniShawUnit)
        then  LinearPath
        else  NonLinearPath ;//no linealization
end;
function   TScanCalibrate.InitAlgorithmParamsFile:integer;   
begin
 with  AlgScanParams do
 begin
   // shift <<16 ??? if need
   //   nchannel:=ResonanceParams.nchannels;
   //  user var channels  0...
   //  0 Stop
   //  1 out channel {frq,ampl} ;
   //  delay 2
      NX:=ByteInversion(ScanParams.NX);
      NY:=ByteInversion(ScanParams.NX);
      ScanPath:=ByteInversion(ScanParams.ScanPath); {X+:0,Y+:1,multi -2}
      sz:=ByteInversion(ScanParams.sz);   //=1 ; +add data =2
      ScanMethod:=ByteInversion(ScanParams.ScanMethod); //method
      MicrostepDelay:=ByteInversion(ScanParams.MicrostepDelay);
      MicrostepDelayBW:=ByteInversion(ScanParams.MicrostepDelayBW);
      DiscrNumInMicroStep:=ByteInversion(ScanParams.DiscrNumInMicroStep shl 16);  //170505
      XMicrostepNmb:=ByteInversion(ScanParams.XMicrostepNmb shl 16);
      YMicrostepNmb:=0;//ByteInversion(ScanParams.YMicrostepNmb shl 16);    !!! 
 end;
end;

function  TScanCalibrate.CreateAlgorithmParamsFile:integer;
var HNDL:integer;
    icod:integer;
    LRec:integer;
//    StreamFile:TFileStream;
    filename:widestring;
 begin
  result:=0;
  LRec:=Sizeof(AlgScanParams);
  filename:=InitParamFileJavaPath+InitParamFileJava;
 if FileExists(FileName) then DeleteFile(FileName);
  try
  HNDL:=FileCreate(FileName);
   icod:=FileWrite(HNDL,AlgScanParams,LRec);
    if (icod<>LRec)    then
    begin
      NoFormUnitLoc.siLang1.MessageDlg('File write error. Maybe you have not rights to create files. Ask administrator',mtWarning,[mbOk],0);
      result:=1;
      exit;
    end;
  finally
      FileClose(HNDL);
  end;
end;
function TScanCalibrate.InitBuffers;
begin
(*           ScanParams.sz:=1;
           Scanparams.flgAquiAdd:=false;
      case  ScanParams.ScanMethod of
 Phase,UAM,CurrentSTM,
 FastScan,
 FastScanPhase:
           begin
             ScanParams.sz:=2;
             Scanparams.flgAquiAdd:=true;
           end;
             end;
             *)
 (* PathLength:=(2*ScanParams.ScanPoints)*2;
  Data_In_BufferLength:=2*ScanParams.ScanPoints+1;
  Data_Out_BufferLength:=(2*ScanParams.Scanpoints)*ScanParams.sz;
  GetMem(data_path,PathLength*sizeof(word));
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
 *) 
end;


procedure TScanCalibrate.SetDataIn;
var
   ns,i,nm:integer;
   s:apitype;
   step:single;
   ss:single;
   sx,sy:apitype;
   dZdclnN,dZdclnM:single;
   MStepsN,MstepsM:integer;
begin
(*                      case  ScanParams.ScanPath of
              OneX:begin
                    MStepsN:=MStepsX;
                    MStepsM:=MStepsY;
                 //   dZdclnN:=ScannerCorrect.dZdclnX;
                 //   dZdclnM:=ScannerCorrect.dZdclnY;
                   end;
              OneY:begin
                    MStepsN:=MStepsY;
                    MStepsM:=MStepsX;
                 //   dZdclnN:=ScannerCorrect.dZdclnY;
                 //   dZdclnM:=ScannerCorrect.dZdclnX;
                   end;
             Multi:begin
                    MStepsN:=MStepsX;
                    MStepsM:=MStepsY;
                    dZdclnN:=0;
                    dZdclnM:=0;
                   end;
            MultiY:begin
                    MStepsN:=MStepsY;
                    MStepsM:=MStepsX;
                    dZdclnN:=0;
                    dZdclnM:=0;
                   end;
                       end;
                 ns:=0;
              ss:=apitype(API.DACZ);;
              if ScannerCorrect.FlgPlnDelHW then
                begin
                 sx:=0;
                 for i:=0 to ScanParams.ScanPoints-1 do      ///!!!
                  begin
                   if ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') then
                      case  ScanParams.ScanPath of
             Multi,OneX:begin
                         MStepsN:=JMPX[i];
                        end ;
            MultiY,OneY:begin
                         MStepsN:=JMPY[i];
                        end;
                           end;
                  if flgFirstPass then step:=(i+1)*MStepsN*dZdclnN-i*MStepsN*dZdclnN
                                  else step:=ScanError[i];

                   if (ss+step)>(Maxapitype-2) then step:=Maxapitype-2-ss;
                   if (ss+step)<(Minapitype+1) then step:=Minapitype+1-ss;
                   s:=trunc(step);
                   ss:=ss+s;
                   PWordArray(data_in)[ns]:= word(s);
                   sx:=sx+s;
                   inc(ns)
                  end;
                 for i:=ScanParams.ScanPoints-1 downto 0 do      ///!!!   1     { TODO : 060406 }
                  begin
                   if ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') then
                      case  ScanParams.ScanPath of
             Multi,OneX:begin
                         MStepsN:=JMPX[i];
                        end ;
            MultiY,OneY:begin
                         MStepsN:=JMPY[i];
                        end;
                            end;
                  if flgFirstPass then step:=i*MStepsN*dZdclnN-(i+1)*MStepsN*dZdclnN
                                  else step:=-ScanError[i];
                   if (ss+step)>(Maxapitype-2) then step:=Maxapitype-2-ss;
                   if (ss+step)<(Minapitype+1) then step:=Minapitype+1-ss;
                   s:=trunc(step);
                   ss:=ss+s;
                   PWordArray(data_in)[ns]:= word(s);
                   sx:=sx+s;
                   inc(ns)
                  end;
               end   //delplane
               else
               begin
                 for i:=0 to (2*ScanParams.ScanPoints)-1 do  { TODO : 061007 }
                  begin
                   PWordArray(data_in)[ns]:=0;
                   inc(ns);
                  end;
                end;
                   PWordArray(data_in)[ns]:=0;
   *)                
end;  {TScanCalibrate.SetaIn}

function TScanCalibrate.InitBuffersFirstPass;
begin
   (*        ScanParams.sz:=1;
      case  ScanParams.ScanMethod of
 Phase,UAM,CurrentSTM,
 FastScan,
 FastScanPhase:
           begin
             ScanParams.sz:=2;
           end;
             end;
             *)
  PathLength:=(2*ScanParams.ScanPoints{-1})*2;{ TODO : 060406 } //??????-1
  Data_In_BufferLength:=2*ScanParams.ScanPoints+1;//3;    { TODO : 060406 }
  Data_Out_BufferLength:=(2*ScanParams.Scanpoints{-1})*ScanParams.sz;//-1????
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;

procedure TScanCalibrate.LinearPathFirstPass;
var
 j,k,N:integer;
 JMP:integer;
 Shift:integer;
begin
(* Shift:=0;
    //Only one Scan line and back
         //    f.path_count:=PathLength;
             j:=0;
             k:=0;
             N:=ScanParams.ScanPoints;
        while j<N do
         begin
              case  ScanParams.ScanPath of
     Multi,OneX:begin
            JMP:=JMPX[j];
            PWordArray(data_path)[k]  := word($4000 or 1) ;     //  x
          end;
     MultiY,OneY:begin
      	    JMP:=JMPY[j];
            PWordArray(data_path)[k]  := word($C000 or 1) ;     //  y
          end;
                 end;
            PWordArray(data_path)[k+1]:= word(JMP);
            inc(j);
            k:=k+2;
        end;     //N
          J:=N-1;
       while j>=0 do //>=1   { TODO : 060406 }
       begin
                case  ScanParams.ScanPath of
Multi,OneX: begin
             PWordArray(data_path)[k]:= word($4000 or 1) ;     // back x
             JMP:=-JMPX[j];
            end;
MultiY,OneY:begin
      	     PWordArray(data_path)[k]:= word($C000 or 1) ;     // back Y
             JMP:=-JMPY[j];
            end;
                    end;
            PWordArray(data_path)[k+1]:=word(JMP);
            dec(j);
            k:=k+2;
         end;
 *)
end;  {LinearPath}

procedure TScanCalibrate.NonLinearPathFirstPass;
var j,k,N,MStepsN,MStepsM:integer;
  JMP:integer;
begin
 (* case  ScanParams.ScanPath of
  Multi,OneX:begin
        MStepsN:=MStepsX;
        MStepsM:=MStepsY;
       end;
 MultiY,OneY:begin
        MStepsN:=MStepsY;
        MStepsM:=MStepsX;
       end;
         end;
       //     f.path_count:=PathLength;
             j:=0;
             k:=0;
             N:=ScanParams.ScanPoints;
        while j<N do
         begin
              case  ScanParams.ScanPath of
     Multi,OneX:begin
            JMP:=MStepsN;
            PWordArray(data_path)[k]  := word($4000 or 1) ;     //  x
           end;
     MultiY,OneY:begin
      	    JMP:=MStepsN;
            PWordArray(data_path)[k]  := word($C000 or 1) ;     //  y
           end;
                 end;
            PWordArray(data_path)[k+1]:= word(JMP);
            inc(j);
            k:=k+2;
        end;     //N
          J:=N-1;
       while j>=0 do
           begin
                case  ScanParams.ScanPath of
      Multi,OneX:begin
             PWordArray(data_path)[k]:= word($4000 or 1) ;     // back x
             JMP:=-MStepsN;
           end;
      MultiY,OneY:begin
        	   PWordArray(data_path)[k]:= word($C000 or 1) ;     // back Y
             JMP:=-MStepsN;
           end;
              end;
            PWordArray(data_path)[k+1]:=word(JMP);
            dec(j);
            k:=k+2;
         end;
      *)
end; {NonLinearPath}


Procedure TScanCalibrate.SetPathFirstPass;
begin
 if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') and (not FlgReniShawUnit)
        then  LinearPathFirstPass
        else  NonLinearPathFirstPass ;//no linealization
end;


procedure TScanCalibrate.SetDataInFirstPass;
var
   ns,i,nm:integer;
   s:apitype;
   step:single;
   ss:single;
   sx,sy:apitype;
   dZdclnN,dZdclnM:single;
   MStepsN,MstepsM:integer;
begin
(*              case  ScanParams.ScanPath of
              OneX:begin
                    MStepsN:=MStepsX;
                    MStepsM:=MStepsY;
               //     dZdclnN:=ScannerCorrect.dZdclnX;
               //     dZdclnM:=ScannerCorrect.dZdclnY;
                   end;
              OneY:begin
                    MStepsN:=MStepsY;
                    MStepsM:=MStepsX;
               //     dZdclnN:=ScannerCorrect.dZdclnY;
               //     dZdclnM:=ScannerCorrect.dZdclnX;
                   end;
             Multi:begin
                    MStepsN:=MStepsX;
                    MStepsM:=MStepsY;
                    dZdclnN:=0;
                    dZdclnM:=0;
                   end;
            MultiY:begin
                    MStepsN:=MStepsY;
                    MStepsM:=MStepsX;
                    dZdclnN:=0;
                    dZdclnM:=0;
                   end;
                       end;
                 ns:=0;
              ss:=apitype(API.DACZ);;
              if ScannerCorrect.FlgPlnDelHW then
                begin
                 sx:=0;
                 for i:=0 to ScanParams.ScanPoints-1 do      ///!!!
                  begin
                   if ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') then
                      case  ScanParams.ScanPath of
             Multi,OneX:begin
                         MStepsN:=JMPX[i];
                        end ;
            MultiY,OneY:begin
                         MStepsN:=JMPY[i];
                        end;
                           end;
                  if flgFirstPass then step:=(i+1)*MStepsN*dZdclnN-i*MStepsN*dZdclnN
                                  else step:=ScanError[i];

                   if (ss+step)>(Maxapitype-2) then step:=Maxapitype-2-ss;
                   if (ss+step)<(Minapitype+1) then step:=Minapitype+1-ss;
                   s:=trunc(step);
                   ss:=ss+s;
                   PWordArray(data_in)[ns]:= word(s);
                   sx:=sx+s;
                   inc(ns)
                  end;
                 for i:=ScanParams.ScanPoints-1 downto 0 do      ///!!!   1     { TODO : 060406 }
                  begin
                   if ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') then
                      case  ScanParams.ScanPath of
             Multi,OneX:begin
                         MStepsN:=JMPX[i];
                        end ;
            MultiY,OneY:begin
                         MStepsN:=JMPY[i];
                        end;
                            end;
                  if flgFirstPass then step:=i*MStepsN*dZdclnN-(i+1)*MStepsN*dZdclnN
                                  else step:=-ScanError[i];
                   if (ss+step)>(Maxapitype-2) then step:=Maxapitype-2-ss;
                   if (ss+step)<(Minapitype+1) then step:=Minapitype+1-ss;
                   s:=trunc(step);
                   ss:=ss+s;
                   PWordArray(data_in)[ns]:= word(s);
                   sx:=sx+s;
                   inc(ns)
                  end;
               end   //delplane
               else
               begin
                 for i:=0 to (2*ScanParams.ScanPoints)-1 do  { TODO : 061007 }
                  begin
                   PWordArray(data_in)[ns]:=0;
                   inc(ns);
                  end;
                end;
                   PWordArray(data_in)[ns]:=0;
  *)                 
end;  {TScanCalibrate.Set}

procedure TScanCalibrate.GetData;
var i,j,step:integer;
    value,st:apitype;
    Adatmin,Adatmax,datmean,datdelta,DPh,Dz:single;
    TempScanNormData:TScanNormData;
begin
     Adatmin := MaxDATATYPE;
     Adatmax := MinDATATYPE;
     SetScanNormData( TempScanNormData);
     i := 0; j:=0;
     step:=ScanParams.sz;
   repeat
    value:=datatype(PIntegerArray(DataBuf)[j]);
    if  value>0 then value:=0 else   value:=abs(value+1);
    if  ((ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY)) and flgFirstPass then ScanError[i]:=value;
    TempScanNormData.PrevLine[i]:= value;
    if value < Adatmin then Adatmin :=value;
    if value > Adatmax then Adatmax :=value;
     inc(j,step);
     inc(i);
   until i>(ScanParams.ScanPoints-1);
    if ScannerCorrect.flgPlnDel then  LinDelFiltPlaneParm(ScanParams.ScanPoints,TempScanNormData.PrevLine,TempScanNormData.sfA,TempScanNormData.sfB)
                                else  begin TempScanNormData.sfA:=0.0; TempScanNormData.sfB:=0.0;end;
     for i := 0 to ScanParams.ScanPoints- 1 do
          begin
              TempScanNormData.PrevLine[i]:=TempScanNormData.PrevLine[i]-(TempScanNormData.sfA+TempScanNormData.sfB*i);
              if TempScanNormData.PrevLine[i] < TempScanNormData.datmin then TempScanNormData.datmin :=TempScanNormData.PrevLine[i];
              if TempScanNormData.PrevLine[i] > TempScanNormData.datmax then TempScanNormData.datmax :=TempScanNormData.PrevLine[i];
          end;
     dZ := TempScanNormData.datmax - TempScanNormData.datmin;
     if dZ=0 then dZ:=1;
     TempScanNormData.ScaleZ0:=dZ;
  if Scanparams.flgAquiAdd  then
  begin
    i:=0; j:=1;
    repeat
     begin
        value:=datatype(PIntegerArray(DataBuf)[j]);
             case ScanParams.ScanMethod of
      UAM:  begin
              if value<0 then  value:=0;
            end;
                 end;
      if value < TempScanNormData.datminPh then TempScanNormData.datminPh :=value;
      if value > TempScanNormData.datmaxPh then TempScanNormData.datmaxPh :=value;
      inc(j,step);
      inc(i);
     end;
    until i>(ScanParams.ScanPoints-1);
    datmean:= (TempScanNormData.datmaxPh+TempScanNormData.datminPh)*0.5;
    datdelta:=(TempScanNormData.datmaxPh-TempScanNormData.datminPh)*0.5;
    TempScanNormData.datmaxPh:=(datmean+datdelta*1.3);
 if TempScanNormData.datmaxPh>MaxApiType then TempScanNormData.datMaxPh:=MaxApiType;
    TempScanNormData.datminPh:=(datmean-datdelta*1.3);
              case ScanParams.ScanMethod of
     Phase: begin
              if TempScanNormData.datminPh<MinApiType then TempScanNormData.datMinPh:=MinApiType;
            end;
      UAM:  begin
              if TempScanNormData.datminPh<0 then TempScanNormData.datMinPh:=0;
            end;
  Current:begin
            end;
                  end;
   dPh :=abs( TempScanNormData.datmaxPh - TempScanNormData.datminPh);

   if dPh=0 then dPh:=1;
    TempScanNormData.ScaleAdd:=dPh;
  end;
     if FlgFirstPass then
     begin
      ScanNormData:=TempScanNormData;          { TODO : 240306 }
      if(ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY) then ScanError[length(ScanError)-1]:=ScanError[length(ScanError)-2];
     end
     else ScanNormData_2_Pass:=TempScanNormData;
end;

procedure TScanCalibrate.StartDraw;
begin
 Progress:=TProgress.Create(Application);
 Progress.Show;
 Progress.StartCalibrateDraw;
end;

procedure TScanCalibrate.StopDraw;
begin
   ProgressCal.close;
   FreeAndNil(ProgressCal);
end;

// Trainning

Constructor TScannerTrainnig.Create;
begin
 inherited create;
end;


function  TScannerTrainnig.InitRegimeVars:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(TrainScrpt); //wide
  InitBuffers;
  GETCOUNT_DELAY:=3000; // ms
  SetSpeed;
end;

function  TScannerTrainnig.InitAlgorithmParamsFile:integer;
begin
 with  AlgParams do
 begin
   NChannels:=3;
   NElements:=ScanParams.CycleCount;  //dataout    channel
   SizeElements:=1;  //dataout channel
   NGetCountEvent:=1;
   params[0]:=ByteInversion(ScanParams.CycleCount);
   params[1]:=ByteInversion(ApproachParams.IntegratorDelay);
   params[2]:=ByteInversion(ApproachParams.ScannerDecay);
   params[3]:=ByteInversion(integer(STMFLG));
   params[4]:=ByteInversion(ScanParams.MicrostepDelay);
   params[5]:=ByteInversion(ScanParams.DiscrNumInMicroStep shl 16 );
 end;
end;

function  TScannerTrainnig.InitBuffers:integer;
begin
  Data_out_BufferLength:=ScanParams.CycleCount;
  GetMem(StopBuf,sizeof(data_out_type));
  GetMem(DoneBuf,sizeof(data_out_type));
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;

procedure TScannerTrainnig.StartDraw;
begin
  if (DrawTrainThread = nil) or (TrainDrawThreadActive = false) then
     begin
           DrawTrainThread:= TTrainThreadDraw.Create;
           TrainDrawThreadActive := True;
      end ;
end;

//Topography

Constructor TTopography.Create;
var   valDiscr:apitype;
begin
 inherited create;
     case   ScanParams.ScanMethod of
  Current:begin
              valDiscr:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);    //220113
              API.DacVt:=apitype(valDiscr);// SetCommonVar(DAC_VT,apitype(valDiscr));
            end;
FastScan,
FastScanPhase:begin
               if STMflg then
                begin
                 valDiscr:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
                 API.DACVT:=apitype(valDiscr);// SetCommonVar(DAC_VT,apitype(valDiscr));
                end
                else  //SFM   FastPhase
                begin
                end;
             end;
        end;    //case
     dout:=0; dout_ph:=0;
     dout_2:=0; dout_ph_2:=0;
end;

function TTopography.Launch:integer;
 var scr:string;
  const  ReniShowScrpt:string='rstopoxyt2.bin';
begin
 result:=0;
 InitRegimeVars;
 FlgFirstPass:=true;
 if StartWork(AlgorithmJava)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
 StartDraw;
end;


function  TTopography.SetUsersParams:boolean;
var ID:integer;
    hr:Hresult;
    n:integer;
    dataparam:Pinteger;
begin
 Javacontrol.IsRunning(flgJavaRunning);
 if flgJavaRunning then
 begin
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start sending topo user param ');
    {$ENDIF}
   arPCChannel[ch_UserParams].Main.Get_Id(ID);  //data out channel
   if ID=ch_UserParams then
   begin
    try
        n:=2;
        if  flgUnit=Terra then  n:=3;

     GetMem(dataparam, n*sizeof(integer));

     PIntegerArray(dataparam)[0]:=integer(ScanParams.MicrostepDelay);
     PIntegerArray(dataparam)[1]:=integer(ScanParams.MicrostepDelayBW);
     if flgUnit=Terra then   PIntegerArray(dataparam)[2]:=integer(ScanParams.TerraTDelay);

     hr:=arPCChannel[ch_UserParams].ChannelWrite.Write(dataparam,n);
     if Failed(hr) then  showmessage('error write  userparam='+inttostr(n));
     finally
      FreeMem(dataparam);
    end;
      {$IFDEF DEBUG}
          Formlog.memolog.Lines.add('Done sending topo user param');
    {$ENDIF}
     end;
  end;
end;

function  TTopography.InitRegimeVars:integer;
var I,J:INTEGER;
begin
// GETCOUNT_DELAY:=300; // // 09/09/2013 интервал (мс), через который вызывается
 GETCOUNT_DELAY:= ScanParams.ScanDrawDelay;                      //            ф-ция GetCount
 ScanParams.sz:=1+byte(flgRenishawUnit);
 ScanData.WorkFileName:=WorkNameFile;
      case  ScanParams.ScanMethod of
 Phase,UAM,Current:
           begin
             ScanParams.sz:=2+byte(flgRenishawUnit);
           end;
             end;
     ScanData.AquiAdd.Data:=nil;
     ScanData.AquiTopo.Data:=nil;
     ScanData.AquiTopo.Nx   := ScanParams.Nx;
     ScanData.AquiTopo.Ny   := ScanParams.Ny;
     ScanData.AquiTopo.XStep:= ScanParams.X/ScanParams.Nx;  ;
     try
       SetLength(ScanData.AquiTopo.Data,ScanParams.Nx,ScanParams.Ny);   //23.11.01   x->y
      for i:=0 to ScanParams.Nx-1 do
        for j:=0 to  ScanParams.Ny-1 do ScanData.AquiTopo.Data[i,j]:=0;
           except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
           end;
    if Scanparams.flgAquiAdd  then
      begin
        ScanData.AquiAdd.Nx:=ScanData.AquiTopo.Nx;
        ScanData.AquiAdd.Ny:=ScanData.AquiTopo.Ny;
        ScanData.AquiAdd.XStep:=ScanData.AquiTopo.XStep;
       try
        SetLength(ScanData.AquiAdd.Data,ScanParams.Nx,ScanParams.Ny);   //23.11.01   x->y
       for i:=0 to ScanParams.Nx-1 do
        for j:=0 to  ScanParams.Ny-1  do ScanData.AquiAdd.Data[i,j]:=0;
       except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
       end;
      end;
      if flgRenishawUnit then
      begin
          ScanData.AquiRenishaw.Nx:=ScanData.AquiTopo.Nx;
          ScanData.AquiRenishaw.NY:=ScanData.AquiTopo.Ny;
          if ScanParams.ScanPath=OneX then inc(ScanData.AquiRenishaw.Nx)
                                      else inc(ScanData.AquiRenishaw.Ny);
       try
        with  ScanData.AquiRenishaw do
        begin
          SetLength(Data,Nx,Ny);
          for i:=0 to Nx-1 do
          for j:=0 to  Ny-1  do Data[i,j]:=0;
        end;
       except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
       end;
      end;  //reni
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  SetDataIn;
  if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit)
     then
     begin
      if flgUnit<>Terra  then AlgorithmJava:=WideString(ScanLinMScrpt)
                         else AlgorithmJava:=WideString(ScanLinMScrptTerra);
     end
     else
     begin
      if flgUnit<>Terra then AlgorithmJava:=WideString(ScanMScrpt)
                        else AlgorithmJava:=WideString(ScanMScrptTerra);
     end;
  InitBuffers;
  SetSpeed;
  SetPath;
end;


 function   TTopography.InitAlgorithmParamsFile:integer;
 var cnt, DataLen,shift:integer;
 begin
  with  AlgParams do
 begin
  NChannels:=4;
  if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit) then
                                                                                    NChannels:=5;
   NElements:=ScanParams.NX*ScanParams.NY*ScanParams.sz;  //dataout    channel
   SizeElements:=ScanParams.sz;  //dataout channel
   NGetCountEvent:=ScanParams.ScanPoints ;
   params[0]:=ByteInversion(ScanParams.NX);
   params[1]:=ByteInversion(ScanParams.NY);
   params[2]:=ByteInversion(ScanParams.ScanPath); {X+:0,Y+:1,multi -2}
   params[3]:=ByteInversion(ScanParams.sz);
   params[4]:=ByteInversion(ScanParams.ScanMethod);
   params[5]:=ByteInversion(ScanParams.MicrostepDelay);
   params[6]:=ByteInversion(ScanParams.MicrostepDelayBW);
   params[7]:=ByteInversion(ScanParams.DiscrNumInMicroStep );
   params[8]:=ByteInversion(ScanParams.XMicrostepNmb);
   params[9]:=ByteInversion(ScanParams.YMicrostepNmb);
   params[10]:=ByteInversion(ScanParams.ScanShift);
   if flgUnit=Terra then params[11]:=ByteInversion(ScanParams.TerraTDelay);
   params[12]:=ByteInversion(integer(ScanParams.ScanLineTime));
 end;
   shift:=17;//Sizeof(AlgParams) div sizeof(Data_dig);
   if flgUnit=Terra then  shift:=shift+1;
    Finalize(DataArray);
     DataLen:=shift;
     SetLength(DataArray,DataLen);
     DataArray[0]:= AlgParams.NChannels;
     DataArray[1]:= AlgParams.NElements;
     DataArray[2]:= AlgParams.SizeElements;
     DataArray[3]:= AlgParams.NGetCountEvent;
     DataArray[4]:= AlgParams.params[0];
     DataArray[5]:= AlgParams.params[1];
     DataArray[6]:= AlgParams.params[2];
     DataArray[7]:= AlgParams.params[3];
     DataArray[8]:= AlgParams.params[4];
     DataArray[9]:= AlgParams.params[5];
     DataArray[10]:= AlgParams.params[6];
     DataArray[11]:= AlgParams.params[7];
     DataArray[12]:= AlgParams.params[8];
     DataArray[13]:= AlgParams.params[9];
     DataArray[14]:= AlgParams.params[10];
     if flgUnit=Terra then  DataArray[15]:= AlgParams.params[11];
     DataArray[16]:= AlgParams.params[12];
 end;
procedure TTopography.SetDataIn;
var cnt:integer;
begin
  if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit) then
      begin
           GetMem(LINEARSTEPSAct, (1+ScanParams.NX + ScanParams.NY)*sizeof(integer));
              for cnt := 0 to ScanParams.NX - 1 do
               PIntegerArray(LINEARSTEPSAct)[cnt]:=JMPX[cnt];// shl 16;
              for cnt := 0 to ScanParams.NY - 1 do
               PIntegerArray(LINEARSTEPSAct)[cnt+ScanParams.NX]:=JMPY[cnt];// shl 16;

      end ;
end;

function  TTopography.FreeBuffers:integer;
begin
inherited FreeBuffers;
 if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit) then
                     FreeMem(LINEARSTEPSAct);
end;

function  TTopography.CreateAlgorithmParamsFile:integer;
var HNDL:integer;
    icod:integer;
    L,i:integer;
    filename:widestring;
    DatBuf:PInt;
 begin
  result:=0;
  L:= length(DataArray);
  filename:=InitParamFileJavaPath+InitParamFileJava;
 if FileExists(FileName) then DeleteFile(FileName);
  try
  HNDL:=FileCreate(FileName);
      try
      GetMem(DatBuf,L*sizeof(integer));
    except
              on EOutOfMemory        do
              NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 2',mtWarning,[mbOk],0);
    end;

    for i:=0 to L-1  do
      PintegerArray(DatBuf)[i]:=DataArray[i];
      icod:=FileWrite(HNDL,DatBuf^,L*sizeof(integer));
    if (icod<>L*sizeof(integer)) then
     raise Exception.Create('File Write ERROR (Datas)');
       FreeMem(DatBuf);
  finally
      FileClose(HNDL);
  end;
   Finalize(DataArray);
end;

function  TTopography.InitBuffers:integer;
begin
if  ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')
      then PathLength:=ScanParams.ScanLines*(ScanParams.ScanPoints+2)*2
      else PathLength:=ScanParams.ScanLines*6;

  Data_out_BufferLength:=ScanParams.ScanPoints*ScanParams.ScanLines*ScanParams.sz;
 // 200209 ola
   if (FlgRenishawUnit) then
    begin
      PathLength:=6;
      Data_in_BufferLength:=1;
      Data_out_BufferLength:=Data_out_BufferLength+ScanParams.ScanLines*ScanParams.sz;  // Nesessary to correct
    end;
  GetMem(StopBuf,sizeof(Integer));   //3 need for demo
  GetMem(DoneBuf,sizeof(Integer));   //3 need for demo
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;

procedure TTopography.LinearPath;
var
 i,j,k,M,N:integer;
 JMP:integer;
 Shift:integer;
begin
end;  {LinearPath}

procedure TTopography.NonLinearPath;
var i,M,N,MStepsN,MStepsM:integer;
    SlowAxisDelaymk:integer;
    SlowAxisStep_discr:integer;
begin
end; {NonLinearPath}

Procedure TTopography.SetPath;
begin
end;


procedure TTopography.StartDraw;
begin
 if not assigned(ScDrawThread) or (not ScDrawThreadActive) then // make sure its not already running
       begin
           ScDrawThread:= TScanDrawThread.Create;
           ScDrawThreadActive := True;
       end ;
end;

procedure TTopography.StopDraw;
begin

end;
/// Profiler

function  TProfile.InitRegimeVars:integer;
var I,J:INTEGER;
begin
 GETCOUNT_DELAY:=300; // // 09/09/2013 интервал (мс), через который вызывается
                      //            ф-ция GetCount
 ScanParams.sz:=1+byte(flgRenishawUnit);
 ScanData.WorkFileName:=WorkNameFile;
      case  ScanParams.ScanMethod of
 Phase,UAM,Current:
           begin
             ScanParams.sz:=2+byte(flgRenishawUnit);
           end;
             end;
     ScanData.AquiAdd.Data:=nil;
     ScanData.AquiTopo.Data:=nil;
     ScanData.AquiTopo.Nx   := ScanParams.Nx;
     ScanData.AquiTopo.Ny   := ScanParams.Ny;
     ScanData.AquiTopo.XStep:= ScanParams.X/ScanParams.Nx;  ;
     try
       SetLength(ScanData.AquiTopo.Data,ScanParams.Nx,ScanParams.Ny);   //23.11.01   x->y
      for i:=0 to ScanParams.Nx-1 do
        for j:=0 to  ScanParams.Ny-1 do ScanData.AquiTopo.Data[i,j]:=0;
           except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
           end;
    if Scanparams.flgAquiAdd  then
      begin
        ScanData.AquiAdd.Nx:=ScanData.AquiTopo.Nx;
        ScanData.AquiAdd.Ny:=ScanData.AquiTopo.Ny;
        ScanData.AquiAdd.XStep:=ScanData.AquiTopo.XStep;
       try
        SetLength(ScanData.AquiAdd.Data,ScanParams.Nx,ScanParams.Ny);   //23.11.01   x->y
       for i:=0 to ScanParams.Nx-1 do
        for j:=0 to  ScanParams.Ny-1  do ScanData.AquiAdd.Data[i,j]:=0;
       except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
       end;
      end;
      if flgRenishawUnit then
      begin
          ScanData.AquiRenishaw.Nx:=ScanData.AquiTopo.Nx;
          ScanData.AquiRenishaw.NY:=ScanData.AquiTopo.Ny;
          if ScanParams.ScanPath=OneX then inc(ScanData.AquiRenishaw.Nx)
                                      else inc(ScanData.AquiRenishaw.Ny);
       try
        with  ScanData.AquiRenishaw do
        begin
          SetLength(Data,Nx,Ny);
          for i:=0 to Nx-1 do
          for j:=0 to  Ny-1  do Data[i,j]:=0;
        end;
       except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
       end;
      end;  //reni
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  SetDataIn;
  if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit)
     then
     begin
      if flgUnit<>Terra  then AlgorithmJava:=WideString(ProfileLinMScrpt)
                         else AlgorithmJava:=WideString(ScanLinMScrptTerra);
     end
     else
     begin
      if flgUnit<>Terra then AlgorithmJava:=WideString(ProfileMScrpt)
                        else AlgorithmJava:=WideString(ScanMScrptTerra);
     end;
  InitBuffers;
  SetSpeed;
  SetPath;
end;

 function   TProfile.InitAlgorithmParamsFile:integer;
 var cnt, DataLen,shift:integer;
 begin
  with  AlgParams do
 begin
  // NChannels:=ScanParams.nchannels;
  NChannels:=4;
  if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit) then
  NChannels:=5;
   NElements:=ScanParams.NX*ScanParams.NY*ScanParams.sz;  //dataout    channel
   SizeElements:=ScanParams.sz;  //dataout channel
   NGetCountEvent:=ScanParams.ScanPoints ;
   params[0]:=ByteInversion(ScanParams.NX);
   params[1]:=ByteInversion(ScanParams.NY);
   params[2]:=ByteInversion(ScanParams.ScanPath); {X+:0,Y+:1,multi -2}
   params[3]:=ByteInversion(ScanParams.sz);
   params[4]:=ByteInversion(ScanParams.ScanMethod);
   params[5]:=ByteInversion(ScanParams.MicrostepDelay);
   params[6]:=ByteInversion(ScanParams.MicrostepDelayBW);
   params[7]:=ByteInversion(ScanParams.DiscrNumInMicroStep );
   params[8]:=ByteInversion(ScanParams.XMicrostepNmb);
   params[9]:=ByteInversion(ScanParams.YMicrostepNmb);
   params[10]:=ByteInversion(ScanParams.ScanShift);
 //  if flgUnit=Terra then params[11]:=ByteInversion(ScanParams.TerraTDelay);
 //  params[12]:=ByteInversion(ScanParams.Speed);
 //  params[13]:=ByteInversion(ScanParams.PiezoMoverNSteps);
 end;
   shift:=22;//15;//Sizeof(AlgParams) div sizeof(Data_dig);
   if flgUnit=Terra then  shift:=shift+1;
     Finalize(DataArray);
     DataLen:=shift;
     SetLength(DataArray,DataLen);
     DataArray[0]:=  AlgParams.NChannels;
     DataArray[1]:=  AlgParams.NElements;
     DataArray[2]:=  AlgParams.SizeElements;
     DataArray[3]:=  AlgParams.NGetCountEvent;
     DataArray[4]:=  AlgParams.params[0];
     DataArray[5]:=  AlgParams.params[1];
     DataArray[6]:=  AlgParams.params[2];
     DataArray[7]:=  AlgParams.params[3];
     DataArray[8]:=  AlgParams.params[4];
     DataArray[9]:=  AlgParams.params[5];
     DataArray[10]:= AlgParams.params[6];
     DataArray[11]:= AlgParams.params[7];
     DataArray[12]:= AlgParams.params[8];
     DataArray[13]:= AlgParams.params[9];
     DataArray[14]:= AlgParams.params[10];
     DataArray[15]:= ByteInversion(integer(STMFLG));
  //   if flgUnit=Terra then  DataArray[15]:= AlgParams.params[11];
 //    ApproachParams.Speed:=(ApproachParams.PMActiveTime shl 4) +(ApproachParams.PMPause);
     ScanParams.Speed:=ScannerMoveXYZParams.Speed;//(600 shl 4)+1;
     DataArray[16]:=ByteInversion(ScanParams.Speed shl 16);
     DataArray[17]:=ByteInversion(ScanParams.PiezoMoverNStepsXY shl 16);
     DataArray[18]:=ByteInversion(ApproachParams.IntegratorDelay);
     DataArray[19]:=ByteInversion(ApproachParams.ScannerDecay );
     DataArray[20]:=ByteInversion(round(ScanParams.PiezoMoverStepsZUp*TransformUnit.Znm_d) shl 16);
     DataArray[21]:=ByteInversion(round(ScanParams.PiezoMoverStepsZDown*TransformUnit.Znm_d)  shl 16);
 end;
  (*
Constructor TProfile.Create;
var   valDiscr:apitype;
begin
 inherited create;
     case   ScanParams.ScanMethod of
  Current:begin
              valDiscr:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);    //220113
              API.DacVt:=apitype(valDiscr);// SetCommonVar(DAC_VT,apitype(valDiscr));
            end;
        end;    //case
     dout:=0; dout_ph:=0;
     dout_2:=0; dout_ph_2:=0;
end;

function TProfile.Launch:integer;
 var scr:string;
begin
 result:=0;
 InitRegimeVars;
 FlgFirstPass:=true;
 if StartWork(AlgorithmJava)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
 StartDraw;
end;

function  TProfile.SetUsersParams:boolean;
var ID:integer;
    hr:Hresult;
    n:integer;
    dataparam:Pinteger;
begin
 Javacontrol.IsRunning(flgJavaRunning);
 if flgJavaRunning then
 begin
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start sending topo user param ');
    {$ENDIF}
   arPCChannel[ch_UserParams].Main.Get_Id(ID);  //data out channel
   if ID=ch_UserParams then
   begin
    try
        n:=2;
        if  flgUnit=Terra then  n:=3;

     GetMem(dataparam, n*sizeof(integer));

     PIntegerArray(dataparam)[0]:=integer(ScanParams.MicrostepDelay);
     PIntegerArray(dataparam)[1]:=integer(ScanParams.MicrostepDelayBW);
     if flgUnit=Terra then   PIntegerArray(dataparam)[2]:=integer(ScanParams.TerraTDelay);

     hr:=arPCChannel[ch_UserParams].ChannelWrite.Write(dataparam,n);
     if Failed(hr) then  showmessage('error write  userparam='+inttostr(n));
     finally
      FreeMem(dataparam);
    end;
      {$IFDEF DEBUG}
          Formlog.memolog.Lines.add('Done sending topo user param');
    {$ENDIF}
     end;
  end;
end;
  *)



(*procedure TProfile.SetDataIn;
var cnt:integer;
begin
  if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit) then
      begin
           GetMem(LINEARSTEPSAct, (1+ScanParams.NX + ScanParams.NY)*sizeof(integer));
              for cnt := 0 to ScanParams.NX - 1 do
               PIntegerArray(LINEARSTEPSAct)[cnt]:=JMPX[cnt];// shl 16;
              for cnt := 0 to ScanParams.NY - 1 do
               PIntegerArray(LINEARSTEPSAct)[cnt+ScanParams.NX]:=JMPY[cnt];// shl 16;

      end ;
end;

function  TProfile.FreeBuffers:integer;
begin
inherited FreeBuffers;
 if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit) then
  FreeMem(LINEARSTEPSAct);
end;

function  TProfile.CreateAlgorithmParamsFile:integer;
var HNDL:integer;
    icod:integer;
    L,i:integer;
    filename:widestring;
    DatBuf:PInt;
 begin
  result:=0;
  L:= length(DataArray);
  filename:=InitParamFileJavaPath+InitParamFileJava;
 if FileExists(FileName) then DeleteFile(FileName);
  try
  HNDL:=FileCreate(FileName);
      try
      GetMem(DatBuf,L*sizeof(integer));
    except
              on EOutOfMemory        do
              NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 2',mtWarning,[mbOk],0);
    end;

    for i:=0 to L-1  do PintegerArray(DatBuf)[i]:=DataArray[i];
      icod:=FileWrite(HNDL,DatBuf^,L*sizeof(integer));
    if (icod<>L*sizeof(integer)) then
     raise Exception.Create('File Write ERROR (Datas)');
       FreeMem(DatBuf);
  finally
      FileClose(HNDL);
  end;
   Finalize(DataArray);
end;
function  TProfile.InitBuffers:integer;
begin
if  ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')
      then PathLength:=ScanParams.ScanLines*(ScanParams.ScanPoints+2)*2
      else PathLength:=ScanParams.ScanLines*6;

  Data_out_BufferLength:=ScanParams.ScanPoints*ScanParams.ScanLines*ScanParams.sz;
 // 200209 ola
   if (FlgRenishawUnit) then
    begin
      PathLength:=6;
      Data_in_BufferLength:=1;
      Data_out_BufferLength:=Data_out_BufferLength+ScanParams.ScanLines*ScanParams.sz;  // Nesessary to correct
    end;
  GetMem(StopBuf,sizeof(Integer));   //3 need for demo
  GetMem(DoneBuf,sizeof(Integer));   //3 need for demo
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;


procedure TProfile.StartDraw;
begin
 if not assigned(ScDrawThread) or (not ScDrawThreadActive) then // make sure its not already running
       begin
           ScDrawThread:= TScanDrawThread.Create;
           ScDrawThreadActive := True;
       end ;
end;

procedure TProfile.StopDraw;
begin

end;
*)
/// Profile

//
///Resonance

Constructor TResonance.Create;
var val:int64;
begin
 inherited create;
// InitRegimeVars;
end;

destructor TResonance.Destroy;
begin
  inherited;
   FreeAndNil(ScanData);
end;

function  TResonance.InitRegimeVars:integer;
var i,j:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(ResonanceNScrpt); //wide
  InitBuffers;
  if assigned(ScanData) then FreeandNil(ScanData);
  ScanData:=TExperiment.Create;
  ScanData.AquiTopo.Nx:=2*ResonanceParams.Npoints;   //{frq,Ampl}
  ScanData.AquiTopo.Ny:=1;
     try
       SetLength(ScanData.AquiTopo.Data,ScanData.AquiTopo.Nx,ScanData.AquiTopo.Ny);   //23.11.01   x->y
      for i:=0 to ScanData.AquiTopo.Nx-1 do ScanData.AquiTopo.Data[i,0]:=0;
           except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
           end;
 GETCOUNT_DELAY:=1000;//40;
 SetSpeed;
end;



function  TResonance.InitAlgorithmParamsFile:integer;
var val:int64;
    v:integer;
begin
 with  AlgParams do
 begin
   NChannels:=ResonanceParams.NChannels;
   NElements:=ResonanceParams.NPoints;  //dataout    channel
   SizeElements:=2;  //dataout channel
   NGetCountEvent:=30;
   val:=round((int64(ResonanceParams.FreqStart) shl 32)/million);
   v:=integer(val);
   params[0]:=ByteInversion(v);
   val:=round((int64(ResonanceParams.Step) shl 32)/million);
   v:=integer(val);
   params[1]:=ByteInversion(v);
   params[2]:=ByteInversion(ResonanceParams.NPoints);
   params[3]:=ByteInversion(ResonanceParams.Delay);
 end;
end;

function  TResonance.InitBuffers:integer;
begin
  Data_out_BufferLength:=ResonanceParams.NPoints*2;
  GetMem(StopBuf,sizeof(data_out_type));
  GetMem(DoneBuf,sizeof(data_out_type));
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;


procedure TResonance.StartDraw;
begin
 if not assigned(ResThread) or (not ResThreadActive) then // make sure its not already running
       begin
           ResThread:= TResDrawThread.Create;
           ResThreadActive := True;
       end ;
end;

//   ScannermoverXYZ


Constructor TScannerMoveXYZ.Create;
var val:int64;
begin
 inherited create;
end;

destructor TScannerMoveXYZ.Destroy;
begin
  inherited;
   FreeAndNil(ScanData);
end;

 function  TScannerMoveXYZ.InitAlgorithmParamsFile:integer;
 begin
 with  AlgParams do
 begin
   NChannels:=ScannerMoveXYZParams.nchannels;
   NElements:=1;//1;  //dataout    channel
   SizeElements:=2;  //dataout channel
   NGetCountEvent:=1;
    ////0 step; 1 piezo mover Z ;2 piezo mover X; 3 piezo mover-y; 4- piezo mover Z ProBeam ,Terra ,MicProbe
   if (ScannerMoveXYZParams.TypeMover=4) then params[0]:=ByteInversion(-ScannerMoveXYZParams.StepsNumb shl 16) //sign z changed 200316
                                         else params[0]:=ByteInversion(ScannerMoveXYZParams.StepsNumb shl 16);
   params[1]:=ByteInversion(ScannerMoveXYZParams.TypeMover);
   params[2]:=ByteInversion(ScannerMoveXYZParams.Speed shl 16);
   if STMFLG then  params[3]:=ByteInversion(integer(ApiType(round(ApproachParams.SetPoint*TransformUnit.nA_d)))) //16/12/14 edited
             else  params[3]:=ByteInversion(integer(Round(ApproachParams.LandingSetpoint*dbltoint)));
   params[4]:=ByteInversion(integer(STMFLG));
 end;
 end;

 function  TScannerMoveXYZ.GetRelStep:Integer;
//var
// fNStep:PInteger;
//n:integer;
begin
// try
//  new(fNstep);
  result:=API.SMZSTATUS
//  arPCChannel[ch_Data_out].Read.read((fNStep),n);
//  result:=Integer(PInteger(fNStep)^);
//finally
//  Dispose(fNstep);
//end;
end;

function  TScannerMoveXYZ.InitBuffers:integer;
begin
  Data_out_BufferLength:=3;//*2;   //status ; z ; signal
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
  GetMem(StopBuf,sizeof(Integer));
  GetMem(DoneBuf,sizeof(Integer));
 end;

function  TScannerMoveXYZ.InitRegimeVars:integer;
var i,j:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(ScannerMoveXYZScrpt); //wide
  InitBuffers;
// SetSpeed;
// SetPath;
end;
function  TScannerMoveXYZ.SetUsersParams:boolean;
var ID:integer;
    hr:Hresult;
    n:integer;
    dataparam:Pinteger;
    flgerr:boolean;
    errcount:integer;
begin
 Javacontrol.IsRunning(flgJavaRunning);
 if flgJavaRunning then
 begin
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start sending moverXYZ params');
    {$ENDIF}
   arPCChannel[ch_MoverXYZUserParams].Main.Get_Id(ID);  //data out channel
   if ID=ch_MoverXYZUserParams then
   begin
    try
     GetMem(dataparam,sizeof(ScannerMoveXYZParams));
     PIntegerArray(dataparam)[1]:=ScannerMoveXYZParams.TypeMover;
     //add 160318
     if(ScannerMoveXYZParams.TypeMover=4)then PIntegerArray(dataparam)[0]:=-ScannerMoveXYZParams.StepsNumb shl 16 //sign  changed 200316 z
                                         else PIntegerArray(dataparam)[0]:=ScannerMoveXYZParams.StepsNumb  shl 16; //x,y

//Ячейка управления скоростью имеет 16 старших значащих разрядов:
//speed = ON[31..20],OFF[19..16],0000..000
//ON - длительность заряда (ON+1)мкс: от 1 до 4096 мкс,
// OFF - длительность разряда (OFF+1)мкс: от 1 до 16 мкс.
//   PMActiveTime:word;     //time piezo motor work in the cycle
//       PMPause
     PIntegerArray(dataparam)[2]:=ScannerMoveXYZParams.Speed shl 16;
 //
 result:=true;
 errcount:=0;
 repeat
  begin
     flgerr:=false;
     n:=1;
     hr:=arPCChannel[ch_MoverXYZUserParams].ChannelWrite.Write(dataparam,n);
     if Failed(hr) then
     begin
      {$IFDEF DEBUG}
       Formlog.memolog.Lines.add('error write  userparam='+inttostr(n));
       {$ENDIF}
       flgerr:=true;
       inc(errCount);
       if errcount>10 then break;
     end
     else
     begin
      {$IFDEF DEBUG}
          Formlog.memolog.Lines.add('Done sending moverXYZ param');
      {$ENDIF}
     end;
  end
  until not flgerr;
    finally
      FreeMem(dataparam);
    end;
   end;
  end;
end;
procedure TScannerMoveXYZ.StartDraw;
begin
   if not assigned(ScannerMoveXYZThread) or (not ScannerMoveXYZThreadActive) then // make sure its not already running
       begin
         ScannerMoveXYZThread:= TScannerMoveXYZDrawThread.Create;
        // ScannerMoveXYZThreadActive := True;
       end ;
end;

//APPROACH SFM-STM

Constructor TApproachSFM.Create;
begin
 inherited create;
end;

destructor TApproachSFM.Destroy;
begin
  inherited;
   FreeAndNil(ScanData);   ///???????      { TODO : 041012 }
end;

function  TApproachSFM.InitAlgorithmParamsFile:integer;
begin
  with  AlgParams do
  begin
   NChannels:=ApproachParams.nchannels;
   NElements:=10;     //dataout    channel
   SizeElements:=4;  //dataout channel
   NGetCountEvent:=1;
   params[0]:=ByteInversion(integer(Round(ApproachParams.LandingSetpoint*dbltoint)));
   params[1]:=ByteInversion(integer(round((1-2*ApproachParams.ZGateMax)*dbltoint))); // absolute  (-1,1)
   params[2]:=ByteInversion(integer(round((1-2*ApproachParams.ZGateMin)*dbltoint))); // absolute  (-1,1)
   params[3]:=ByteInversion(integer(round(ApproachParams.LevelUAM*ApproachParams.UAMMax) shl 16)); // absolute
   params[4]:=ByteInversion(ApproachParams.ZStepsNumb shl 16);
   params[5]:=ByteInversion(ApproachParams.IntegratorDelay);
   params[6]:=ByteInversion(ApproachParams.ScannerDecay);
   params[7]:=ByteInversion(integer(STMFLG));
   params[8]:=ByteInversion(ApproachParams.Speed shl 16);  //need for piezo
   params[9]:=ByteInversion(integer(ApproachParams.flgControlTopPosition));
  end;
end;
function  TApproachSTM.InitAlgorithmParamsFile:integer;
 begin
  with  AlgParams do
 begin
   NChannels:=ApproachParams.nchannels;
   NElements:=10;    //dataout    channel
   SizeElements:=4;  //dataout channel
   NGetCountEvent:=1;
   params[0]:=ByteInversion(integer(Round(ApproachParams.LandingSetPoint*TransformUnit.nA_d)) shl 16);
   params[1]:=ByteInversion(integer(round((1-2*ApproachParams.ZGateMax)*dbltoint))); // absolute  (-1,1)
   params[2]:=ByteInversion(integer(round((1-2*ApproachParams.ZGateMin)*dbltoint))); // absolute  (-1,1)
   params[3]:=ByteInversion(integer(round(ApproachParams.LevelIT*TransformUnit.nA_d)) shl 16); // absolute
   params[4]:=ByteInversion(ApproachParams.ZStepsNumb shl 16);
   params[5]:=ByteInversion(ApproachParams.IntegratorDelay);
   params[6]:=ByteInversion(ApproachParams.ScannerDecay);
   params[7]:=ByteInversion(integer(STMFLG));
   params[8]:=ByteInversion(ApproachParams.Speed shl 16);  //  need for piezo 
   params[9]:=ByteInversion(integer(ApproachParams.flgControlTopPosition));
 end;
 end;
function   TApproachSFM.GetRelStep:Integer;
begin
  result:=API.SMZSTATUS
end;

function  TApproachSFM.InitBuffers:integer;
begin
  ApproachParams.DataBufLength:=4;// status ; z ; signal ;steps
  GetMem(StopBuf,sizeof(Integer));
  GetMem(DoneBuf,sizeof(Integer));
  GetMem(DataBuf, ApproachParams.DataBufLength*sizeof(data_out_type));
end;
function  TApproachSFM.InitRegimeVars:integer;
var i,j:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(ApproachNScrpt); //wide
  InitBuffers;
(*  ScanData:=TExperiment.Create;
  ScanData.AquiTopo.Nx:=2*ResonanceParams.Npoints;   //{frq,Ampl}
  ScanData.AquiTopo.Ny:=1;
     try
       SetLength(ScanData.AquiTopo.Data,ScanData.AquiTopo.Nx,ScanData.AquiTopo.Ny);   //23.11.01   x->y
      for i:=0 to ScanData.AquiTopo.Nx-1 do ScanData.AquiTopo.Data[i,1]:=0;
           except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
           end;
  *)
// SetSpeed;
// SetPath;
GETCOUNT_DELAY:=100;
end;
function  TApproachSFM.SetUsersParams:boolean;
var ID:integer;
    hr:Hresult;
    n:integer;
    dataparam:Pinteger;
       flgerr:boolean;
    errcount:integer;
begin
 Javacontrol.IsRunning(flgJavaRunning);
 if flgJavaRunning then
 begin
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start sending approach param');
    {$ENDIF}

   arPCChannel[ch_UserParams].Main.Get_Id(ID);  //data out channel
   if ID=ch_UserParams then
   begin
    try
     GetMem(dataparam,sizeof(AlgApproachParams));
     n:=1;
     PIntegerArray(dataparam)[0]:=integer(Round(ApproachParams.LandingSetpoint*dbltoint));
     PIntegerArray(dataparam)[1]:=integer(round((1-2*ApproachParams.ZGateMax)*dbltoint));
     PIntegerArray(dataparam)[2]:=integer(round((1-2*ApproachParams.ZGateMin)*dbltoint));
     PIntegerArray(dataparam)[3]:=integer((round(ApproachParams.LevelUAM*ApproachParams.UAMMax) shl 16));
     PIntegerArray(dataparam)[4]:=ApproachParams.ZStepsNumb shl 16;
     PIntegerArray(dataparam)[5]:=ApproachParams.IntegratorDelay;
     PIntegerArray(dataparam)[6]:=ApproachParams.ScannerDecay;
     PIntegerArray(dataparam)[7]:=integer(STMFLG);
     PIntegerArray(dataparam)[8]:=ApproachParams.Speed shl 16;
     result:=true;
 errcount:=0;
 repeat
  begin
     flgerr:=false;
     n:=9;
     hr:=arPCChannel[ch_MoverXYZUserParams].ChannelWrite.Write(dataparam,n);
     if Failed(hr) then
     begin
     {$IFDEF DEBUG}
       Formlog.memolog.Lines.add('error write  userparam='+inttostr(n));
     {$ENDIF}
       flgerr:=true;
       inc(errCount);
       if errcount>10 then break;
     end
     else
     begin
      {$IFDEF DEBUG}
          Formlog.memolog.Lines.add('Done sending moverXYZ param');
      {$ENDIF}
     end;
  end
  until not flgerr;
    finally
      FreeMem(dataparam);
    end;
   end;
  end;
end;
//
function  TApproachSTM.SetUsersParams:boolean;
var ID:integer;
    hr:Hresult;
    n:integer;
    dataparam:Pinteger;
    flgerr:boolean;
    errcount:integer;
begin
 Javacontrol.IsRunning(flgJavaRunning);
 if flgJavaRunning then
 begin
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start sending approach param');
    {$ENDIF}
    arPCChannel[ch_UserParams].Main.Get_Id(ID);  //data out channel
   if ID=ch_UserParams then
   begin
    try
     GetMem(dataparam,sizeof(AlgApproachParams));
     n:=1;
     PIntegerArray(dataparam)[0]:=integer(Round(ApproachParams.LandingSetpoint*TransformUnit.nA_d) shl 16);
     PIntegerArray(dataparam)[1]:=integer(round((1-2*ApproachParams.ZGateMax)*dbltoint));
     PIntegerArray(dataparam)[2]:=integer(round((1-2*ApproachParams.ZGateMin)*dbltoint));
     PIntegerArray(dataparam)[3]:=integer(round(ApproachParams.LevelIT*TransformUnit.nA_d) shl 16);
     PIntegerArray(dataparam)[4]:=ApproachParams.ZStepsNumb shl 16;
     PIntegerArray(dataparam)[5]:=ApproachParams.IntegratorDelay;
     PIntegerArray(dataparam)[6]:=ApproachParams.ScannerDecay;
     PIntegerArray(dataparam)[7]:=integer(STMFLG);         //020212
     PIntegerArray(dataparam)[8]:=ApproachParams.Speed shl 16;
     result:=true;
     errcount:=0;
 repeat
  begin
     flgerr:=false;
     n:=9; //????
     hr:=arPCChannel[ch_MoverXYZUserParams].ChannelWrite.Write(dataparam,n);
     if Failed(hr) then
     begin
     {$IFDEF DEBUG}
       Formlog.memolog.Lines.add('error write  userparam='+inttostr(n));
       {$ENDIF}
       flgerr:=true;
       inc(errCount);
       if errcount>10 then break;
     end
     else
     begin
      {$IFDEF DEBUG}
          Formlog.memolog.Lines.add('Done sending moverXYZ param');
      {$ENDIF}
     end;
  end
  until not flgerr    finally
      FreeMem(dataparam);
    end;
   end;
  end;
end;

function  TApproachSTM.InitRegimeVars:integer;
var i,j:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(ApproachNScrpt); //wide
  InitBuffers;
  GETCOUNT_DELAY:=100;
(*  ScanData:=TExperiment.Create;
  ScanData.AquiTopo.Nx:=2*ResonanceParams.Npoints;   //{frq,Ampl}
  ScanData.AquiTopo.Ny:=1;
     try
       SetLength(ScanData.AquiTopo.Data,ScanData.AquiTopo.Nx,ScanData.AquiTopo.Ny);   //23.11.01   x->y
      for i:=0 to ScanData.AquiTopo.Nx-1 do ScanData.AquiTopo.Data[i,1]:=0;
           except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
           end;
  *)
// SetSpeed;
// SetPath;
end;

(*function  TApproachSTM.InitBuffers:integer;
begin
  ApproachParams.DataBufLength:=4;//   status ; z ; signal
  GetMem(StopBuf,sizeof(Integer));
  GetMem(DoneBuf,sizeof(Integer));
  GetMem(DataBuf, ApproachParams.DataBufLength*sizeof(data_out_type));
end;
 *)
Constructor TApproachSTM.Create;
begin
 inherited Create;
end;

procedure TApproachSFM.StartDraw;
begin
   if not assigned(ApproachThread) or (not ApproachThreadActive) then // make sure its not already running
       begin
           ApproachThread:= TApproachThread.Create;
           ApproachThreadActive := True;
       end ;
end;
//Rising
procedure TRising.StartDraw;
begin
end;

Constructor  TRising.Create(n:integer);
begin
 inherited create;
  fn:=n;
end;
function  TRising.InitBuffers:integer;
begin
  GetMem(StopBuf,sizeof(Integer));
  GetMem(DoneBuf,sizeof(Integer));
  GetMem(DataBuf, 1*sizeof(data_out_type));
end;

function  TRising.InitRegimeVars:integer;
var i,j:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(RisingScrpt); //wide
  InitBuffers;
end;

function  TRising.InitAlgorithmParamsFile:integer;
begin
  with  AlgParams do
  begin
   NChannels:=ApproachParams.nchannels;
   NElements:=1;     //dataout    channel
   SizeElements:=1;  //dataout channel
   NGetCountEvent:=1;
   params[0]:=ByteInversion(fn);
  end;
end;

//Test TI time integrator   PID

function TTestTI.Launch:integer;
 begin
 result:=0;
 InitRegimeVars;
 if StartWork(AlgorithmJava)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
 StartDraw;
end;

function  TTestTI.InitRegimeVars:integer;
var i,j:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(TestTIScrpt); //wide
  InitBuffers;
end;

 function   TTestTI.InitAlgorithmParamsFile:integer;
 begin
   AlgParams.NChannels:=3;   // !!!! need to set parameters before run java
 end;

 function  TTestTI.CreateAlgorithmParamsFile:integer;
var HNDL:integer;
    icod:integer;
    LRec:integer;
    filename:widestring;
    t:datatype;
 begin
  result:=0;
  LRec:=Sizeof(datatype);
  t:=2;
  filename:=InitParamFileJavaPath+InitParamFileJava;
 if FileExists(FileName) then DeleteFile(FileName);
  try
  HNDL:=FileCreate(FileName);
   icod:=FileWrite(HNDL,t,LRec);
    if (icod<>LRec)    then
    begin
      NoFormUnitLoc.siLang1.MessageDlg('File write error. Maybe you have not rights to create files. Ask administrator',mtWarning,[mbOk],0);
      result:=1;
      exit;
    end;
  finally
      FileClose(HNDL);
  end;
end;

function   TTestTI.InitBuffers:integer;
begin
  Data_out_BufferLength:=1;//*2;   //status ; z ; signal
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;

procedure   TTestTI.StartDraw;
begin
   if not assigned(ThreadTestTIDraw) or (not ThreadTestTIDrawActive) then // make sure its not already running
       begin
           ThreadTestTIDraw:= TThreadTestTI.Create;
           ThreadTestTIDrawActive := True;
       end ;
end;
//MultiTopography

Constructor TMultiTopography.Create;
var  z0,valDiscr:apitype;
begin
 inherited create;
     case   ScanParams.ScanMethod of
(* Topography:
            begin
             if STMflg then API.ADCMCH_ENA:=8// SetCommonVar(ADC_MCH_ENA,8)
                       else API.ADCMCH_ENA:=32;// SetCommonVar(ADC_MCH_ENA,0);
            end;
      Phase:begin
             API.ADCMCH_ENA:=1;// SetCommonVar(ADC_MCH_ENA,1);
             API.SDGAIN_FM:=ApproachParams.Gain_FM;//128;// SetCommonVar(SD_GEN_M,128);
            end;
      UAM:   API.ADCMCH_ENA:=32;// SetCommonVar(ADC_MCH_ENA,32);
*)
  Current:begin
              valDiscr:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
              API.DacVt:=apitype(valDiscr);// SetCommonVar(DAC_VT,apitype(valDiscr));
            end;
FastScan,
FastScanPhase:begin
               if STMflg then
                begin
                 valDiscr:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
                 API.DACVT:=apitype(valDiscr);// SetCommonVar(DAC_VT,apitype(valDiscr));
                end
                else  //SFM   FastPhase
                begin
  //               API.ADCMCH_ENA:=1;// SetCommonVar(ADC_MCH_ENA,1);
  //               API.SDGAIN_FM:=ApproachParams.Gain_FM;//128; // SetCommonVar(SD_GEN_M,128);
                end;
             end;
        end;    //case
        FlgFirstPass:=false;
        ScanDataSecondPass:=TExperiment.Create;
        dout:=0; dout_ph:=0;
        dout_2:=0; dout_ph_2:=0;
        { TODO : 280306 }
        Z0:=0;//API.Z;     { TODO : 100108 }
        if  Z0>0 then Z0:=0 else   Z0:=-(Z0+1);
        ScanParams.DataInprev:=Z0;
        Scanparams.dataInNext:=ScanParams.dataInprev;
        Scanparams.dataInCur:=Scanparams.dataInNext;
 end;

Destructor TMultiTopography.Destroy;
begin
//  if assigned(ScanDataSecondPass) then FreeAndNil(ScanDataSecondPass);
 inherited;
end;
//Multi Pass Topography

function TMultiTopography.Launch:integer;
var z0,dacz0:smallint;
 ScanScript:string;
begin
(* result:=0;                { TODO : 060406 }
 flgFirstPass:=not flgFirstPass;
 if (ScanParams.CurrentScanCount=0) and flgFirstPass  then InitRegimeVars;
 SetSpeed;
 if (not flgStopMulti) and (ScanParams.CurrentScanCount<ScanParams.ScanLines) then
 begin
  if  flgFirstPass then
   begin //first pass
    InitBuffersFirstPass;
    SetPathFirstPass;
    SetDataInFirstPass;
    ScanScript:=ScanMScrpt;
   end
   else
   begin  //second pass
    SetCommonVar(adr92,ApproachParams.IntegratorDelay);//aIntegratorDlII=$92
    SetCommonVar(adr94,ScanParams.IntegrDecay); //aScannerDCII=$94;
    SetCommonVar(adr96,ScanParams.DACZTimeDelay); //aTimeDelayII=$96;
    InitBuffers;
    SetPath;
    SetDataIn;
    ScanScript:=ScanMIIScrpt;
   end;

   if StartWork(ScanScript)<>0 then
   begin
    FreeBuffer;
    result:=1;
    exit;
   end;
    StartDraw;
 end;
 *)
end;

function  TMultiTopography.InitRegimeVars:integer;
procedure InitScanData(var Data:Texperiment);
var i,j:integer;
begin
     Data.AquiAdd.Data:=nil;
     Data.AquiTopo.Data:=nil;
     Data.AquiTopo.Nx   := ScanParams.Nx;
     Data.AquiTopo.Ny   := ScanParams.Ny;
     Data.AquiTopo.XStep:= ScanParams.X/ScanParams.Nx;  ;
     try
       SetLength(Data.AquiTopo.Data,ScanParams.Nx,ScanParams.Ny);   //23.11.01   x->y
      for i:=0 to ScanParams.Nx-1 do
        for j:=0 to  ScanParams.Ny-1 do Data.AquiTopo.Data[i,j]:=0;
     except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
     end;
  if Scanparams.flgAquiAdd then
   begin
        Data.AquiAdd.Nx:= Data.AquiTopo.Nx;
        Data.AquiAdd.Ny:= Data.AquiTopo.Ny;
        Data.AquiAdd.XStep:=Data.AquiTopo.XStep;
     try
        SetLength(Data.AquiAdd.Data,ScanParams.Nx,ScanParams.Ny);   //23.11.01   x->y
       for i:=0 to ScanParams.Nx-1 do
        for j:=0 to  ScanParams.Ny-1  do Data.AquiAdd.Data[i,j]:=0;
     except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
     end;
   end;
end;
 begin
(*
  SetCommonVar(adr80,0);
  SetCommonVar(adr82,0);  //??
  SetCommonVar(adr8A,ScanParams.ScanMethod); //   aFlgViewType=$8A

 API.PMSPEED:=0;
 { TODO : 130306 }
/////////////???????????????????????????????
// SetCommonVar(aIntegratorDlII,ApproachParams.IntegratorDelay);
// SetCommonVar(aScannerDcII,ApproachParams.ScannerDecay);
//  SetCommonVar(aScannerDcII,ApproachParams.DacZtimedelay);
////***************************/////////////////////////
  ScanParams.sz:=1;
  Scanparams.flgAquiAdd:=false;
      case  ScanParams.ScanMethod of
 Phase,UAM,Current:
           begin
             ScanParams.sz:=2;
             Scanparams.flgAquiAdd:=true;
           end;
             end;
  { TODO : 170306 }
        InitScanData(ScanData);
        InitScanData(ScanDataSecondPass);
        ScanDataSecondPass.FileHeadRcd:= ScanData.FileHeadRcd;
        ScanDataSecondPass.MainRcd:=ScanData.MainRcd;
   //     inc(CountStart);
        WorkNameFile:=workdirectory+'\'+WorkNameFileMaskCur+ScandataWorkFileNameEm(CountStart)+'_1'+WorkExtFile;
        ScanData.WorkFileName:=WorkNameFile;
        ScanDataSecondPass.WorkFileName:=workdirectory+'\'+WorkNameFileMaskCur+ScandataWorkFileNameEm(CountStart)+'_2'+WorkExtFile;
        SetSpeed;
        *)
end;

function  TMultiTopography.InitBuffers:integer;
begin
 if  ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')
      then PathLength:=(ScanParams.ScanPoints+2+2)*2    { TODO : 290108 }
      else PathLength:=6;
(*
  path
  Z+; x+; x-; Z-; y+;
*)
  Data_in_BufferLength:=(ScanParams.ScanPoints+2+2+1);    { TODO : 290108 }
  Data_out_BufferLength:=ScanParams.ScanPoints*ScanParams.sz;
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
//  GetMem(data_in,Data_in_BufferLength*sizeof(word));
end;
(*
 function  TMultiTopography.InitBuffers:integer;
begin
 if  ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')
      then PathLength:=(ScanParams.ScanPoints+2+2)*2
      else PathLength:=6;
  GetMem(data_path,PathLength*sizeof(word));
  Data_in_BufferLength:=((ScanParams.ScanPoints+2+2)+1);
  Data_out_BufferLength:=ScanParams.ScanPoints*ScanParams.sz;
  GetMem(data_out,Data_out_BufferLength*sizeof(data_out_type));
  GetMem(data_in,Data_in_BufferLength*sizeof(word));
end;
*)
function  TMultiTopography.InitBuffersFirstPass:integer;
begin
 if  ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')
      then PathLength:=(ScanParams.ScanPoints+3)*2
      else PathLength:=4;
(*
  path
   x+;x-;y+;y-;
*)
  Data_in_BufferLength:=(ScanParams.ScanPoints+3+1);
  Data_out_BufferLength:=(ScanParams.ScanPoints+1)*ScanParams.sz;
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
//  GetMem(data_in,Data_in_BufferLength*sizeof(word));
end;
(*
procedure TMultiTopography.LinearPath;
 {   PathType<>0 Scanning of the field N x M;
     PathType=0  and M =0  Only one Scan and back
     PathType=0  and M >0  One Scan,  go back and shift JMPY[NY] for next scan
    flgPathMode=One        X+
    flgPathMode=OneY       Y+
 }
var
 i,j,k,M,N:integer;
 JMP:integer;
 Shift:integer;
begin
Shift:=0;
if ScanParams.ScanMethod=OneLineScan then Shift:=ScanParams.ScanShift;      // shift - compensation shift
  f.path_count:=PathLength;
  i:=ScanParams.CurrentScanCount;
  k:=0;
  M:=1;
  N:=ScanParams.ScanPoints;

      j:=0;
         PWordArray(data_path)[k]:= word($4000);   //up z datain0  stay in point
         PWordArray(data_path)[k+1]:= word(0);
         k:=k+2;
      while j<N do
        begin
         case  ScanParams.ScanPath of
    Multi:begin
            JMP:=JMPX[j];
            PWordArray(data_path)[k]:= word($4000 or 1); //x, main
          end;
    MultiY:begin
      	    JMP:=JMPY[j];
            PWordArray(data_path)[k]:= word($C000 or 1); //x, main
          end;
             end;
         PWordArray(data_path)[k+1]:= word(JMP);
         inc(j);
         k:=k+2;
        end;     //N
//        back
       case  ScanParams.ScanPath of
    Multi:begin
            if ScanParams.ScanMethod=OneLineScan then JMP:=0 else JMP:=JMPY[ScanParams.CurrentScanCount];
            PWordArray(data_path)[k]  := word($4000) ;     // back x
            PWordArray(data_path)[k+1]:= word(-JMPX[N]-shift);// word(-(ScanSum-ScanShift));
            PWordArray(data_path)[k+2]:= word($4000) ;     // down datain0 stay in point
            PWordArray(data_path)[k+3]:= word(0);//
            PWordArray(data_path)[k+4]:= word($C000);    //y
          end;
   MultiY:begin
     	      if ScanParams.ScanMethod=OneLineScan then JMP:=0 else JMP:=JMPX[ScanParams.CurrentScanCount];
            PWordArray(data_path)[k]  := word($C000) ;     // back y
            PWordArray(data_path)[k+1]:= word(-JMPY[N]-shift);// word(-(ScanSum-ScanShift));
            PWordArray(data_path)[k+2]:= word($4000) ;  // stop and down
            PWordArray(data_path)[k+3]:= word(0);   // stop and down datain Z0
            PWordArray(data_path)[k+4]:= word($4000);      //x
          end;
             end;
     PWordArray(data_path)[k+5]:= word(JMP);
     k:=k+6;
     inc(i);
end;  {LinearPath}
*)
procedure TMultiTopography.LinearPath;
var
 i,j,k,M,N:integer;
 JMP:integer;
 Shift:integer;
begin
(*Shift:=0;
if ScanParams.ScanMethod=OneLineScan then Shift:=ScanParams.ScanShift;      // shift - compensation shift
//  f.path_count:=PathLength;
  i:=ScanParams.CurrentScanCount;
  k:=0;
  M:=1;
  N:=ScanParams.ScanPoints;
         j:=0;
         PWordArray(data_path)[k]:= word($4000);   //up z datain0  stay in point
         PWordArray(data_path)[k+1]:= word(0);
         k:=k+2;
 //AHEAD
      while j<N do
        begin
         case  ScanParams.ScanPath of
    Multi:begin
            JMP:=JMPX[j];
            PWordArray(data_path)[k]:= word($4000 or 1); //x, main
          end;
    MultiY:begin
      	    JMP:=JMPY[j];
            PWordArray(data_path)[k]:= word($C000 or 1); //x, main
          end;
             end;
         PWordArray(data_path)[k+1]:= word(JMP);
         inc(j);
         k:=k+2;
        end;     //N
         { TODO : 290108 }
     //  stop wait dacz->0 ;itres=0
            PWordArray(data_path)[k]  := word($4000) ;
            PWordArray(data_path)[k+1]:= word(-1);//;
            k:=k+2;
     //        back


       case  ScanParams.ScanPath of
    Multi:begin
            if ScanParams.ScanMethod=OneLineScan then JMP:=0 else JMP:=JMPY[ScanParams.CurrentScanCount];
            PWordArray(data_path)[k]  := word($4000) ;     // back x
            PWordArray(data_path)[k+1]:= word(-JMPX[N]+1-shift);// word(-(ScanSum-ScanShift));
            PWordArray(data_path)[k+2]:= word($C000);    //y
            PWordArray(data_path)[k+3]:= word(JMP);
       //     PWordArray(data_path)[k+2]:= word($4000) ;     // down datain0 stay in point
       //     PWordArray(data_path)[k+3]:= word(0);//
            end;
   MultiY:begin
     	      if ScanParams.ScanMethod=OneLineScan then JMP:=0 else JMP:=JMPX[ScanParams.CurrentScanCount];
            PWordArray(data_path)[k]  := word($C000) ;     // back y
            PWordArray(data_path)[k+1]:= word(-JMPY[N]-shift);// word(-(ScanSum-ScanShift));
            PWordArray(data_path)[k+2]:= word($4000);      //x
            PWordArray(data_path)[k+3]:= word(JMP);
       //     PWordArray(data_path)[k+2]:= word($4000) ;  // stop and down
       //     PWordArray(data_path)[k+3]:= word(0);   // stop and down datain Z0
          end;
             end;
     k:=k+4;
//     inc(i);
*)
end;  {LinearPath}

 Procedure TMultiTopography.SetDataIn;
var
   ns,i,j,nm:integer;
   s:apitype;
   step:single;
   ss:single;
   sx,sy:apitype;
   MStepsN,MstepsM:integer;
begin
 (*             case  ScanParams.ScanPath of
             Multi:begin
                    MStepsN:=MStepsX;
                    MStepsM:=MStepsY;
                      end;
            MultiY:begin
                    MStepsN:=MStepsY;
                    MStepsM:=MStepsX;
                   end;
                     end;
           j:=ScanParams.CurrentScanCount;
           ns:=0;
           ss:=apitype(API.DACZ);
               if ScannerCorrect.FlgPlnDelHW then
                begin
                 sx:=0;     { TODO : 240306 }
                  //stay and up
                   step:=ScanParams.dataInCur-ScanParams.DataInPrev+ScanParams.PassIIDz*TransformUnit.Znm_d;
                   if (ss+step)>(Maxapitype-2) then step:=Maxapitype-2-ss;
                   if (ss+step)<(Minapitype+1) then step:=Minapitype+1-ss;
                   s:=trunc(step);
                   ss:=ss+s;
                   sx:=sx+s;
                   PWordArray(data_in)[ns]:= word(s);      //stop and up datain0
                   inc(ns);

                 for i:=0 to ScanParams.ScanPoints-1 do
                  begin
                   if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') then
                      case  ScanParams.ScanPath of
                  Multi:begin
                         MStepsN:=JMPX[i];
                        end ;
                 MultiY:begin
                         MStepsN:=JMPY[i];
                        end;
                           end;
                   step:=ScanError[i];  { TODO : 270306         =0 }
                   if (ss+step)>(Maxapitype-2) then step:=Maxapitype-2-ss;
                   if (ss+step)<(Minapitype+1) then step:=Minapitype+1-ss;
                   s:=trunc(step);
                   ss:=ss+s;
                   PWordArray(data_in)[ns]:= word(s);
                   sx:=sx+s;
                   inc(ns)
                  end;
                 // stop and down DACZ_>0 ;ITRES=0
                  PWordArray(data_in)[ns]:=word(0);
                  inc(ns);
                 { TODO : 170108 }
                  sx:=0;
                 // Back

                  PWordArray(data_in)[ns]:=word(0);
                  ss:=ss-sx;
                  inc(ns);
                                 // OY Move
                   if ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') then
                     case  ScanParams.ScanPath of
                  Multi:begin
                         MStepsM:=JMPY[ScanParams.CurrentScanCount]; //i
                        end ;
                 MultiY:begin
                         MStepsM:=JMPX[ScanParams.CurrentScanCount];  //i
                        end;
                           end;
                   if ScanParams.ScanMethod=OneLineScan
                           then  step:=0                 { TODO : 240306 }
                           else  step:=-(ScanParams.DataInCur-ScanParams.DataInPrev);//ScanError[ScanParams.ScanPoints];//
                    if (ss+step)>(Maxapitype-2) then step:=Maxapitype-2-ss;
                    if (ss+step)<(Minapitype+1) then step:=Minapitype+1-ss;
                    s:=trunc(step);
                    ss:=ss+s;
                    PWordArray(data_in)[ns]:= word(s);
                    inc(ns);
                    //down       { TODO : 290108 }
           (*     TODO : 040506 }    step:=-ScanParams.PassIIDz*TransformUnit.Znm_d;
                   if (ss+step)>(Maxapitype-2) then step:=Maxapitype-2-ss;
                   if (ss+step)<(Minapitype+1) then step:=Minapitype+1-ss;
                   s:=trunc(step);
                   ss:=ss+s;
                   PWordArray(data_in)[ns]:= word(s);      //stop and up datain0
                    inc(ns);
            *)
  (*               end   //delplane
               else
                begin
                 for i:=0 to ScanParams.ScanPoints+1 do
                  begin
                   PWordArray(data_in)[ns]:=0;
                   inc(ns);
                  end;
                end;
                   PWordArray(data_in)[ns]:=0;
   *)
end;

procedure TMultiTopography.LinearPathFirstPass;
var
 j,k,N:integer;
 JMP:integer;
 Shift:integer;
begin
(*Shift:=0;
if ScanParams.ScanMethod=OneLineScan then Shift:=ScanParams.ScanShift;      // shift - compensation shift
//  f.path_count:=PathLength;
  k:=0;
  N:=ScanParams.ScanPoints;
     j:=0;
     //ahead
      while j<N do
        begin
         case  ScanParams.ScanPath of
    Multi:begin
            JMP:=JMPX[j];
            PWordArray(data_path)[k]:= word($4000 or 1); //x, main
          end;
   MultiY:begin
      	    JMP:=JMPY[j];
            PWordArray(data_path)[k]:= word($C000 or 1); //x, main
          end;
             end;
         PWordArray(data_path)[k+1]:= word(JMP);
         inc(j);
         k:=k+2;
        end;     //N
        //back
                   case  ScanParams.ScanPath of
    Multi:begin
            if ScanParams.ScanMethod=OneLineScan then JMP:=0 else JMP:=JMPY[Scanparams.CurrentScanCount];
            PWordArray(data_path)[k]  := word($4000) ;     // back x
            PWordArray(data_path)[k+1]:= word(-JMPX[N]-shift);// word(-(ScanSum-ScanShift));
            PWordArray(data_path)[k+2]:= word($C000 or 1);    //y
            PWordArray(data_path)[k+3]:= word(JMP);
            PWordArray(data_path)[k+4]:= word($C000);    //-y
            PWordArray(data_path)[k+5]:= word(-JMP);
          end;
   MultiY:begin
            if ScanParams.ScanMethod=OneLineScan then JMP:=0 else JMP:=JMPX[Scanparams.CurrentScanCount];
            PWordArray(data_path)[k]  := word($C000) ;     // back y
            PWordArray(data_path)[k+1]:= word(-JMPY[N]-shift);// word(-(ScanSum-ScanShift));
            PWordArray(data_path)[k+2]:= word($4000 or 1);    //y
            PWordArray(data_path)[k+3]:= word(JMP);
            PWordArray(data_path)[k+4]:= word($4000);    //-X
            PWordArray(data_path)[k+5]:= word(-JMP);
          end;
             end;
     k:=k+6; /////error!!!!!!!!!!!!!!!!
   *)
end;  {LinearPath}

procedure TMultiTopography.NonLinearPath;
var i,M,N,MStepsN,MStepsM:integer;
begin
(*  case  ScanParams.ScanPath of
Multi:begin
        MStepsN:=MStepsX;
        MStepsM:=MStepsY;
      end;
MultiY:begin
       MStepsN:=MStepsY;
       MStepsM:=MStepsX;
      end;
         end;
  {Standart Scanning of the field}
         i:=0;
         M:=1;//ScanParams.ScanLines;
         N:=ScanParams.ScanPoints;

        if ScanParams.ScanMethod=OneLineScan then MStepsM:=0;
          while  (i<M*6 )
           do
            begin
                  case   ScanParams.ScanPath of
             Multi:begin
	                	PWordArray(data_path)[i+0]:= word($4000 or N);
           		      PWordArray(data_path)[i+1]:= word(MStepsN);
                		PWordArray(data_path)[i+2]:= word($4000 or 0) ;
                		PWordArray(data_path)[i+3]:= word(-N*MStepsN);
                 		PWordArray(data_path)[i+4]:= word($C000 or 0);
                		PWordArray(data_path)[i+5]:= word(MStepsM);
                   end;
              MultiY:begin
                    PWordArray(data_path)[i+0]:= word($C000 or N);
                		PWordArray(data_path)[i+1]:= word(MStepsN);
                		PWordArray(data_path)[i+2]:= word($C000 or 0) ;
                		PWordArray(data_path)[i+3]:= word(-N*MStepsN);
                		PWordArray(data_path)[i+4]:= word($4000 or 0);
                		PWordArray(data_path)[i+5]:= word(MStepsM);
                   end;
                                 end;
                      i:=i+6;
	       end;
    *)
end; {NonLinearPath}

procedure TMultiTopography.NonLinearPathFirstPass;
var i,M,N,MStepsN,MStepsM:integer;
begin
(*  case  ScanParams.ScanPath of
Multi:begin
        MStepsN:=MStepsX;
        MStepsM:=MStepsY;
      end;
MultiY:begin
       MStepsN:=MStepsY;
       MStepsM:=MStepsX;
      end;
         end;
  {Standart Scanning of the field}
         i:=0;
         M:=1;
         N:=ScanParams.ScanPoints;

        if ScanParams.ScanMethod=OneLineScan then MStepsM:=0;
          while  (i<M*4 )
           do
            begin
                  case   ScanParams.ScanPath of
             Multi:begin
	                	PWordArray(data_path)[i+0]:= word($4000 or N);
           		      PWordArray(data_path)[i+1]:= word(MStepsN);
                		PWordArray(data_path)[i+2]:= word($4000 or 0) ;
                		PWordArray(data_path)[i+3]:= word(-N*MStepsN);
                   end;
              MultiY:begin
                    PWordArray(data_path)[i+0]:= word($C000 or N);
                		PWordArray(data_path)[i+1]:= word(MStepsN);
                		PWordArray(data_path)[i+2]:= word($C000 or 0) ;
                		PWordArray(data_path)[i+3]:= word(-N*MStepsN);
                   end;
                                 end;
                      i:=i+4;
	       end;
      *)
end; {NonLinearPath}

Procedure TMultiTopography.SetPath;
begin
 if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') and (not FlgReniShawUnit)
  then  LinearPath   else  NonLinearPath ;//no linealization
end;

Procedure TMultiTopography.SetPathFirstPass;
begin
 if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') and (not FlgReniShawUnit)
  then  LinearPathFirstPass   else  NonLinearPathFirstPass ;//no linealization
end;


Procedure   TMultiTopography.SetDataInFirstPass;
var
   ns,i,j,nm:integer;
   s:apitype;
   step:apitype;
   ss:single;
   sx:apitype;
   MStepsN,MstepsM:integer;
begin
(*              case  ScanParams.ScanPath of
             Multi:begin
                    MStepsN:=MStepsX;
                    MStepsM:=MStepsY;
                    end;
            MultiY:begin
                    MStepsN:=MStepsY;
                    MStepsM:=MStepsX;
                     end;
                     end;
           ns:=0;
           ss:=apitype(API.DACZ);
               if ScannerCorrect.FlgPlnDelHW then
                begin
                 sx:=0;
                 for i:=0 to ScanParams.ScanPoints-1 do
                  begin
                   if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') then
                      case  ScanParams.ScanPath of
                  Multi:begin
                         MStepsN:=JMPX[i];
                        end ;
                 MultiY:begin
                         MStepsN:=JMPY[i];
                        end;
                           end;
                   step:=0;
                   PWordArray(data_in)[ns]:= word(0);
                   inc(ns)
                  end;  //i
                 // Back
                  step:=0;
                  PWordArray(data_in)[ns]:=word(step);  //-x
                  inc(ns);
                  PWordArray(data_in)[ns]:=word(step);  //y
                  inc(ns);
                  PWordArray(data_in)[ns]:=word(step); //Y-
                  inc(ns);
               end   //delplane
               else
                begin
                 for i:=0 to ScanParams.ScanPoints+1 do
                  begin
                   PWordArray(data_in)[ns]:=0;
                   inc(ns);
                  end;
                    step:=0;
                  PWordArray(data_in)[ns]:=word(-step);  //-x
                  inc(ns);
                  PWordArray(data_in)[ns]:=word(-step);  //y
                  inc(ns);
                  PWordArray(data_in)[ns]:=word(-step); //Y-
                  inc(ns);
                end;
                 PWordArray(data_in)[ns]:=0;
     *)
end;

procedure TMultiTopography.StartDraw;
begin
 if not assigned(ScDrawThread) or (not ScDrawThreadActive) then // make sure its not already running
       begin
           ScDrawThread:=TScanDrawThread.Create;
           ScDrawThreadActive := True;
       end ;
end;

procedure TMultiTopography.StopDraw;
begin

end;
//Fast Topo

function TMultiTurnONFB.Launch:integer;
 const ScanScript:string='turnonfb2.bin' ;
begin
    InitRegimeVars;
    InitBuffers;
    ScanScript:='turnonfb2.bin' ;
   if StartWork(ScanScript)<>0 then
   begin
    FreeBuffers;
    result:=1;
    exit;
   end;
 WaitStopWork;
 ScanWorkDone;
 FreeBuffers;
end;

function TMultiTurnONFB.InitRegimeVars:integer;
begin
(*     SetCommonVar(adr92,ScanParams.IntegrDecay); //aIntegratorDlII=$92
     SetCommonVar(adr96,ScanParams.DacZTimeDelay); //aTimeDelayII=$96;
  *)
end;

Constructor  TMultiTurnONFB.Create;
begin
 inherited create;
end;

function TMultiTurnONFB.InitBuffers;
begin
  PathLength:=1;
  data_in_BufferLength:=1;
  data_out_BufferLength:=1;
  GetMem(DataBuf,data_out_BufferLength*sizeof(data_out_type));
//  GetMem(data_in,data_in_Bufferlength*sizeof(word));
end;


(*
function  TFastTopo.FreeBuffers:integer;
begin

end;
 *)
function  TFastTopo.InitBuffers:integer;
begin
  Data_out_BufferLength:=ScanParams.ScanPoints*ScanParams.ScanLines*ScanParams.sz+1;   //edited 210616
  GetMem(StopBuf,sizeof(Integer));   //3 need for demo
  GetMem(DoneBuf,sizeof(Integer));   //3 need for demo
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;

function  TFastTopo.FreeBuffers:integer;
begin
 FreeMem(StopBuf);
 FreeMem(DoneBuf);
 FreeMem(DataBuf);
//  inherited TScanMethod.FreeBuffers;
end;

 function  TFastTopo.InitRegimeVars:integer;
var I,J:INTEGER;
begin
 GETCOUNT_DELAY:=300; // // 09/09/2013 интервал (мс), через который вызывается
                      //       ф-ция GetCount
 ScanParams.sz:=1;
 ScanData.WorkFileName:=WorkNameFile;
//
    ScanData.AquiAdd.Data:=nil;
     ScanData.AquiTopo.Data:=nil;
     ScanData.AquiTopo.Nx   := ScanParams.Nx;
     ScanData.AquiTopo.Ny   := ScanParams.Ny;
     ScanData.AquiTopo.XStep:= ScanParams.X/ScanParams.Nx;  ;
     try
       SetLength(ScanData.AquiTopo.Data,ScanParams.Nx,ScanParams.Ny);   //23.11.01   x->y
      for i:=0 to ScanParams.Nx-1 do
        for j:=0 to  ScanParams.Ny-1 do ScanData.AquiTopo.Data[i,j]:=0;
           except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
           end;
        ScanData.AquiAdd.Nx:= ScanParams.Nx;
        ScanData.AquiAdd.Ny:= ScanParams.Ny;
        ScanData.AquiAdd.XStep:= ScanParams.X/ScanParams.Nx;  ;
       try
        SetLength(ScanData.AquiAdd.Data,ScanParams.Nx,ScanParams.Ny);   //23.11.01   x->y
       for i:=0 to ScanParams.Nx-1 do
        for j:=0 to  ScanParams.Ny-1  do ScanData.AquiAdd.Data[i,j]:=0;
       except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
       end;
//
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(ScanFastScrpt);
  InitBuffers;
  SetSpeed;
  SetPath;
end;

 function   TFastTopo.InitAlgorithmParamsFile:integer;
var cnt, DataLen,shift:integer;
 begin
  with  AlgParams do
 begin
   NChannels:=4;
   NElements:=ScanParams.NX*ScanParams.NY*ScanParams.sz;  //dataout    channel
   SizeElements:=ScanParams.sz;  //dataout channel
   NGetCountEvent:=ScanParams.ScanPoints ;
   params[0]:=ByteInversion(ScanParams.NX);
   params[1]:=ByteInversion(ScanParams.NY);
   params[2]:=ByteInversion(ScanParams.ScanPath); {X+:0,Y+:1,multi -2}
   params[3]:=ByteInversion(ScanParams.sz);
   params[4]:=ByteInversion(ScanParams.ScanMethod);
   params[5]:=ByteInversion(ScanParams.MicrostepDelay);
   params[6]:=ByteInversion(ScanParams.MicrostepDelayBW);
   params[7]:=ByteInversion(ScanParams.DiscrNumInMicroStep );
   params[8]:=ByteInversion(ScanParams.XMicrostepNmb);
   params[9]:=ByteInversion(ScanParams.YMicrostepNmb);
   params[10]:=ByteInversion(ScanParams.ScanShift);
   params[11]:=ByteInversion(integer(ScanParams.flgOneFrame));
   params[12]:=ByteInversion(integer(ScanParams.ScanLineTime));
 end;
   shift:=17;//16;//Sizeof(AlgParams) div sizeof(Data_dig);
   if flgUnit=Terra then  shift:=shift+1;
    Finalize(DataArray);

     DataLen:=shift;
     SetLength(DataArray,DataLen);
     DataArray[0]:= AlgParams.NChannels;
     DataArray[1]:= AlgParams.NElements;
     DataArray[2]:= AlgParams.SizeElements;
     DataArray[3]:= AlgParams.NGetCountEvent;
     DataArray[4]:= AlgParams.params[0];
     DataArray[5]:= AlgParams.params[1];
     DataArray[6]:= AlgParams.params[2];
     DataArray[7]:= AlgParams.params[3];
     DataArray[8]:= AlgParams.params[4];
     DataArray[9]:= AlgParams.params[5];
     DataArray[10]:= AlgParams.params[6];
     DataArray[11]:= AlgParams.params[7];
     DataArray[12]:= AlgParams.params[8];
     DataArray[13]:= AlgParams.params[9];
     DataArray[14]:= AlgParams.params[10];
     DataArray[15]:= AlgParams.params[11];
     DataArray[16]:= AlgParams.params[12]
 end;

procedure TFastTopo.StartDraw;
begin
  if (ScFastDrawThread = nil) or (ScFastDrawThreadActive = false) then
       begin
           ScFastDrawThread:= TScanFastDrawThread.Create;
           ScFastDrawThreadActive := True;
       end ;
end;

function TFastTopo.Launch:integer;
begin
 result:=0;
 InitRegimeVars;
 FlgFirstPass:=true;
 if StartWork(AlgorithmJava)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
 StartDraw;
end;

Constructor TLithoSFM.Create;
begin
 inherited create;
           case  Scanparams.ScanMethod of
  litho:     begin
               API.DACVT:=0;// SetCommonVar(DAC_VT,apitype(valDiscr));
             end;
LithoCurrent: begin
               API.DACVT:=0;// SetCommonVar(DAC_VT,apitype(valDiscr));
              end;
                  end;
//   InitAlgorithmParamsFile;
//   InitRegimeVars;
end;

Procedure TLithoSFM.SetDataIn;
var
    i,j:integer;
    cut:integer;
    HNDL:integer;
    icod:integer;
    LRec:integer;
    filename:widestring;
    MaskFilename:string;
    HR:hRESULT;
    cnt:integer;
begin

           GetMem(MatrixLithoAct, (1+ScanParams.ScanLines * ScanParams.ScanPoints)*sizeof(integer));
           for j:=0 to (ScanParams.ScanLines-1) do
            begin
                 for i:=0 to (ScanParams.ScanPoints-1) do
                 begin
                        case  ScanParams.ScanPath of
                   OneX:begin
                             case   Scanparams.ScanMethod of
                    Litho:  PIntegerArray(MatrixLithoAct)[j*ScanParams.ScanPoints + i]:=(integer(round(LithoParams.ScaleAct*MatrixLitho[j,i])) shl 16);
             LithoCurrent:begin
                           cut:=byte(MatrixLitho[j,i]<>0);
                           PIntegerArray(MatrixLithoAct)[j*ScanParams.ScanPoints + i]:=(integer(cut*(LithoParams.V+round(LithoParams.ScaleAct*MatrixLitho[j,i]))) shl 16);
                          end;
                             end;               //case
                        end ;
                   OneY:begin
                               case   Scanparams.ScanMethod of
                   Litho:  PIntegerArray(MatrixLithoAct)[j*ScanParams.ScanPoints + i]:=(integer(round(LithoParams.ScaleAct*MatrixLitho[i,j])) shl 16);
             LithoCurrent: begin
                             cut:=byte(MatrixLitho[i,j]<>0);
                             PIntegerArray(MatrixLithoAct)[j*ScanParams.ScanPoints + i]:=(integer(cut*(LithoParams.V+round(LithoParams.ScaleAct*MatrixLitho[i,j]))) shl 16);
                           end;
                                end;      //case
                         end;
                                     end;                           //case path
                end;
           end;
      if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit) then
      begin
              GetMem(LINEARSTEPSAct, (1+ScanParams.NX + ScanParams.NY)*sizeof(integer));
              for cnt := 0 to ScanParams.NX - 1 do PIntegerArray(LINEARSTEPSAct)[cnt]:=JMPX[cnt];// shl 16;
              for cnt := 0 to ScanParams.NY - 1 do PIntegerArray(LINEARSTEPSAct)[cnt+ScanParams.NX]:=JMPY[cnt];// shl 16;
      end ;
(* filename:=MaskLithoFileJavaPath+MaskLithoFileJava;
 LRec:=Sizeof(integer);
 if FileExists(FileName) then DeleteFile(FileName);
  try
  HNDL:=FileCreate(FileName);
   for j:=0 to (ScanParams.ScanLines-1) do
     for i:=0 to (ScanParams.ScanPoints-1) do
       begin
            case  ScanParams.ScanPath of
                   OneX:begin
                             case   Scanparams.ScanMethod of
                 Litho,LithoCurrent:    icod:=FileWrite(HNDL,(MatrixLithoAct[j,i]),LRec);
                             end;     //case
                        end ;               //x
                   OneY:begin
                            case   Scanparams.ScanMethod of
                 Litho,LithoCurrent:  icod:=FileWrite(HNDL,(MatrixLithoAct[i,j]),LRec);
                                  end;   //case
                         end;   //oneY
                          end; //case
               if (icod<>LRec)    then
                begin
                    NoFormUnitLoc.siLang1.MessageDlg('File write error. Maybe you have not rights to create files. Ask administrator',mtWarning,[mbOk],0);
       //             result:=1;
                    exit;
                end;
     end;
   finally
      FileClose(HNDL);
  end;
     maskfilename:=MaskLithoFileJavaPath+MaskLithoFileJava;
   if FileExists(maskfilename) then
    begin
      JavaControl.Delete(Widestring(MaskLithoFileJava));
     repeat
       application.processmessages;
     until flgfilemaskdeleted;
  // if flgfilealgdel then
    hr:=JavaControl.UpLoad(Widestring(maskfilename),MaskLithoFileJava);
    if not Failed(Hr) then
    {$IFDEF DEBUG}
        Formlog.memolog.Lines.add('litho mask has uploaded');
    {$ENDIF};
   if FlgCurrentUserLevel<>Demo then
     begin
      repeat
       sleep(200);
       application.processmessages;
      until flgfilemaskuploaded;
    // result:=0;      //OK
     end;
 end;
 *)
end;

function  TLithoSFM.FreeBuffers:integer;
begin
inherited FreeBuffers;
Freemem(MatrixLithoAct);
if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit) then
  FreeMem(LINEARSTEPSAct);
end;

function  TLithoSFM.InitRegimeVars:integer;
VAR I,J:INTEGER;
begin
     ScanParams.sz:=1+byte(flgRenishawUnit);
     ScanData.AquiTopo.Data:=nil;
     ScanData.AquiTopo.Nx   := ScanParams.Nx;
     ScanData.AquiTopo.Ny   := ScanParams.Ny;
     ScanData.AquiTopo.XStep:= ScanParams.X/ScanParams.Nx;  ;
     try
       SetLength(ScanData.AquiTopo.Data,ScanParams.Nx,ScanParams.Ny);   //23.11.01   x->y
      for i:=0 to ScanParams.Nx-1 do
        for j:=0 to  ScanParams.Ny-1 do ScanData.AquiTopo.Data[i,j]:=0;
           except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg('OUT memory TopoSPM',mtWarning,[mbOk],0);
           end;
     if flgRenishawUnit then
       begin
          ScanData.AquiRenishaw.Nx:=ScanData.AquiTopo.Nx;
          ScanData.AquiRenishaw.NY:=ScanData.AquiTopo.Ny;
          if ScanParams.ScanPath=OneX then  inc(ScanData.AquiRenishaw.Nx)
              else inc(ScanData.AquiRenishaw.Ny);
         try
         with  ScanData.AquiRenishaw do
          begin
            SetLength(Data,Nx,Ny);
            for i:=0 to Nx-1 do
            for j:=0 to  Ny-1  do Data[i,j]:=0;
          end;
          except
              on EOutOfMemory        do
               NoFormUnitLoc.silang1.MessageDlg(strus0{'OUT memory TopoSPM'},mtWarning,[mbOk],0);
           end;
        end;
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  SetDataIn;
 if   ScannerCorrect.FlgXYLinear then AlgorithmJava:=WideString(LithoLinScript)
                                 else AlgorithmJava:=WideString(LithoScript);
 if ScanParams.ScanMethod=LithoCurrent then
                 begin
                     if   ScannerCorrect.FlgXYLinear then AlgorithmJava:=WideString(AnodeLinLithoScript)
                                                     else AlgorithmJava:=WideString(AnodeLithoScript);
                 end;
  InitBuffers;
  SetSpeed;
  GETCOUNT_DELAY:= ScanParams.LithoDrawDelay;//400; //changed 300->400 13.05.16
 end;

Procedure TLithoSFM.SetPath;
begin
(*  if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough') and (not FlgReniShawUnit)
          then LinearPath        else NonLinearPath;//non linear
*)
end;
 function   TLithoSFM.InitAlgorithmParamsFile:integer;
 var cnt, DataLen,shift:integer;
 begin
   // shift <<16 ??? if need
  with  AlgParams do
  begin
   NChannels:=5;     //190213   add datain channel
   if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit) then
   NChannels:=6;
   NElements:=2*ScanParams.NX*ScanParams.NY*ScanParams.sz;  //dataout    channel
   SizeElements:=ScanParams.sz;  //dataout channel
   NGetCountEvent:=ScanParams.ScanPoints;
   params[0]:=ByteInversion(ScanParams.NX);
   params[1]:=ByteInversion(ScanParams.NY);
   params[2]:=ByteInversion(ScanParams.ScanPath); {X+:0,Y+:1,multi -2}
   params[3]:=ByteInversion(ScanParams.sz);
   params[4]:=ByteInversion(ScanParams.ScanMethod);
   params[5]:=ByteInversion(ScanParams.MicrostepDelay);
   params[6]:=ByteInversion(ScanParams.MicrostepDelayBW);
   params[7]:=ByteInversion(ScanParams.DiscrNumInMicroStep );
   params[8]:=ByteInversion(ScanParams.XMicrostepNmb);
   params[9]:=ByteInversion(ScanParams.YMicrostepNmb);
   params[10]:=ByteInversion(round(LithoParams.Amplifier));
   params[11]:=ByteInversion(LithoParams.TimeAct);
   if Scanparams.ScanMethod =lithocurrent then  params[11]:=ByteInversion(LithoParams.TimeAct*1000);
  end;

  shift:=16;//Sizeof(AlgParams) div sizeof(Data_dig);

    Finalize(DataArray);
 (*  if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit) then
   begin
     DataLen:=Shift+ScanParams.NX+ScanParams.NY;
     SetLength(DataArray,DataLen);
     for cnt := 0 to ScanParams.NX - 1 do
        DataArray[shift+cnt]:=byteinversion(JMPX[cnt]);
     for cnt := 0 to ScanParams.NY - 1 do
        DataArray[shift+ScanParams.NX+cnt]:=byteinversion(JMPY[cnt]);
   end
   else   *)
   begin
      DataLen:=shift;
      SetLength(DataArray,DataLen);
   end;
     DataArray[0]:= AlgParams.NChannels;
     DataArray[1]:= AlgParams.NElements;
     DataArray[2]:= AlgParams.SizeElements;
     DataArray[3]:= AlgParams.NGetCountEvent;
     DataArray[4]:= AlgParams.params[0];
     DataArray[5]:= AlgParams.params[1];
     DataArray[6]:= AlgParams.params[2];
     DataArray[7]:= AlgParams.params[3];
     DataArray[8]:= AlgParams.params[4];
     DataArray[9]:= AlgParams.params[5];
     DataArray[10]:= AlgParams.params[6];
     DataArray[11]:= AlgParams.params[7];
     DataArray[12]:= AlgParams.params[8];
     DataArray[13]:= AlgParams.params[9];
     DataArray[14]:= AlgParams.params[10];
     DataArray[15]:= AlgParams.params[11];
 end;

function  TLithoSFM.CreateAlgorithmParamsFile:integer;
var HNDL:integer;
    icod:integer;
    L,i:integer;
//    StreamFile:TFileStream;
    filename:widestring;
    DatBuf:PInt;
 begin
  result:=0;
  L:= length(DataArray);
  filename:=InitParamFileJavaPath+InitParamFileJava;
 if FileExists(FileName) then DeleteFile(FileName);
  try
  HNDL:=FileCreate(FileName);
      try
      GetMem(DatBuf,L*sizeof(integer));
    except
              on EOutOfMemory        do
              NoFormUnitLoc.siLang1.MessageDlg(strcom2{'OUT memory TopoSPM'}+' 2',mtWarning,[mbOk],0);
    end;

    for i:=0 to L-1  do      PintegerArray(DatBuf)[i]:=DataArray[i];
    icod:=FileWrite(HNDL,DatBuf^,L*sizeof(integer));
    if (icod<>L*sizeof(integer)) then
     raise Exception.Create('File Write ERROR (Datas)');
       FreeMem(DatBuf);
  finally
      FileClose(HNDL);
  end;
   Finalize(DataArray);

end;

function   TLithoSFM.InitBuffers:integer;
begin
(* if  ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')
      then PathLength:=ScanParams.ScanLines*4*(ScanParams.ScanPoints+1)   //  M*(2*N+1)*2
      else PathLength:=ScanParams.ScanLines*6;
 *)
  Data_out_BufferLength:=2*ScanParams.ScanPoints*ScanParams.ScanLines;
   if flgReniShawUnit then
            begin
              PathLength:=6;
              Data_in_BufferLength:=ScanParams.ScanLines*ScanParams.ScanPoints+1;
              // if ScanParams.stepXY<=240 then
              Data_out_BufferLength:=2*Data_out_BufferLength+ScanParams.ScanLines*2;
            end;
  GetMem(StopBuf,sizeof(Integer)); //3 need for demo
  GetMem(DoneBuf,sizeof(Integer));   //3 need for demo
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;

function  TLithoSFM.SetUsersParams:boolean;
var ID:integer;
    hr:Hresult;
    n:integer;
    dataparam:Pinteger;
begin
 Javacontrol.IsRunning(flgJavaRunning);
 if flgJavaRunning then
 begin
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start sending litho param');
    {$ENDIF}
   arPCChannel[ch_UserParams].Main.Get_Id(ID);  //data out channel
   if ID=ch_UserParams then
   begin
    try
     GetMem(dataparam,sizeof(RAlgLitho_ingParams));
     n:=4;
      PIntegerArray(dataparam)[0]:=integer(ScanParams.MicrostepDelay);
      PIntegerArray(dataparam)[1]:=integer(ScanParams.MicrostepDelayBW);
      PIntegerArray(dataparam)[2]:=integer(LithoParams.Amplifier);
  if Scanparams.ScanMethod =lithocurrent then  PIntegerArray(dataparam)[3]:=integer(LithoParams.TimeAct*1000)
                                         else  PIntegerArray(dataparam)[3]:=integer(LithoParams.TimeAct);
(*
       hr:=arPCChannel[ch_UserParams].ChannelWrite.Write(dataparam,n);   //as  IMLPCChannelWrite2 writewait;
     if Failed(hr) then  showmessage('error write litho userparam='+inttostr(n));
    {$IFDEF DEBUG}
          Formlog.memolog.Lines.add('Done sending litho param');
    {$ENDIF}
*)
    WriteToChannel(ch_UserParams,dataparam,n);
    finally
      FreeMem(dataparam);
    end;
   end;
  end;
end;

procedure TLithoSFM.LinearPath;
var
 i,j,k,M,N:integer;
 JMP:integer;
 Shift:integer;
begin
(*  Shift:=0;
  i:=0;
  k:=0;
  M:=ScanParams.ScanLines;
  N:=ScanParams.ScanPoints;
  while i<M do
    begin
      j:=0;
      while j<N do
        begin
         case  ScanParams.ScanPath of
     OneX:begin
            JMP:=JMPX[j];
            PWordArray(data_path)[k]:= word($4000 or 1); //x, main
          end;
     OneY:begin
      	    JMP:=JMPY[j];
            PWordArray(data_path)[k]:= word($C000 or 1); //x, main
          end;
             end;
         PWordArray(data_path)[k+1]:= word(JMP);
         inc(j);
         k:=k+2;
        end;     //N
        //end point make main
       case  ScanParams.ScanPath  of
     OneX:begin
            PWordArray(data_path)[k]  := word($4000 or 1) ;
          end;
     OneY:begin
            PWordArray(data_path)[k]  := word($C000 or 1) ;
          end;
             end;
           PWordArray(data_path)[k+1]:= word(0);
       k:=k+2;
//backward
       dec(j);
       while j>=1 do
        begin
         case  ScanParams.ScanPath  of
     OneX:begin
            JMP:=JMPX[j];
            PWordArray(data_path)[k]:= word($4000 or 1); //x, main
          end;
     OneY:begin
      	    JMP:=JMPY[j];
            PWordArray(data_path)[k]:= word($C000 or 1); //x, main
          end;
             end;
         PWordArray(data_path)[k+1]:= word(-JMP);
         dec(j);
         k:=k+2;
      end;     //j           //to start point without main
         case  ScanParams.ScanPath  of
     OneX:begin
            PWordArray(data_path)[k]  := word($4000) ;
            JMP:=JMPX[0];
          end;
     OneY:begin
            PWordArray(data_path)[k]  := word($C000) ;
            JMP:=JMPY[0];
          end;
             end;
       PWordArray(data_path)[k+1]:= word(-JMP);
       k:=k+2;
        //move next line and shift
       case ScanParams.ScanPath  of
     OneX:begin
            JMP:=JMPY[i];
            PWordArray(data_path)[k]:= word($C000);    //y
          end;
     OneY:begin
     	      JMP:=JMPX[i];
            PWordArray(data_path)[k]:= word($4000);      //x
          end;
             end;
     PWordArray(data_path)[k+1]:= word(JMP);
     k:=k+2;
     inc(i);
    end;     //M
   *)
end;  {LinearPath}

procedure TLithoSFM.NonLinearPath;
var i,M,N,MStepsN,MStepsM:integer;
begin
(*if ( not FlgReniShawUnit) then
 begin
  case   ScanParams.ScanPath of
  OneX:begin
        MStepsN:=MStepsX;
        MStepsM:=MStepsY;
      end;
 OneY:begin
       MStepsN:=MStepsY;
       MStepsM:=MStepsX;
      end;
         end;
     M:=ScanParams.ScanLines;
     N:=ScanParams.ScanPoints;
        i:=0;
          while  (i<M*6 )
           do
            begin
                 case  ScanParams.ScanPath of
              OneX:begin
	                	PWordArray(data_path)[i+0]:= word($4000 or N);
           		      PWordArray(data_path)[i+1]:= word(MStepsN);
                		PWordArray(data_path)[i+2]:= word($4000 or 0) ;
                		PWordArray(data_path)[i+3]:= word(-N*MStepsN);
                 		PWordArray(data_path)[i+4]:= word($C000 or 0);
                		PWordArray(data_path)[i+5]:= word(MStepsM);
                   end;
              OneY:begin
                    PWordArray(data_path)[i+0]:= word($C000 or N);
                		PWordArray(data_path)[i+1]:= word(MStepsN);
                		PWordArray(data_path)[i+2]:= word($C000 or 0) ;
                		PWordArray(data_path)[i+3]:= word(-N*MStepsN);
                		PWordArray(data_path)[i+4]:= word($4000 or 0);
                		PWordArray(data_path)[i+5]:= word(MStepsM);
                   end;
                                 end;
                      i:=i+6;
	       end;
  end
  else // With Renishaw
    begin
       	 PWordArray(data_path)[0]:= word(ReniShawParams.NParts_inStep*ScanParams.NX div ReniShawParams.stepScale);
         PWordArray(data_path)[1]:= word(ReniShawParams.NParts_inStep*ScanParams.NY div ReniShawParams.stepScale);
         ReniShawParams.noiseW_discr:=20;
         PWordArray(data_path)[2]:= word(ReniShawParams.noiseW_discr);
         PWordArray(data_path)[3]:= word(ReniShawParams.stepScale);  //in Litho StepScale=1
         PWordArray(data_path)[4]:= word(ReniShawParams.NParts_inStep);
    end;
   *) 
end; {NonLinearPath}

procedure TLithoSFM.StartDraw;
begin
if (ScDrawLithoThread = nil) or (ScDrawLithoThreadActive=False) then // make sure its not already running
    begin
     ScDrawLithoThread:= TScanDrawLithoThread.Create;
     ScDrawLithoThreadActive := true;
    end;
end;


(*function TLithoSFM.Launch:integer;
 var scr:string;
 const ReniShawLithoScrpt:string='rslithoxyt.bin';
begin
 result:=0;
 InitRegimeVars;   *)
(*
 case scanParams.ScanPath of
  OneX: begin
           case Renishawparams.flgscriptname of
     1:        ReniShawLithoScrpt:= 'rslithoxyt5.bin';        //4
     2:
             case ScanParams.ScanMethod of
               Litho,LithoCurrent:  ReniShawLithoScrpt:= 'rslithoxysst5.bin';
                      end;
                           end;

          end;
   OneY:begin
                 case Renishawparams.flgscriptname of
     4:        ReniShawLithoScrpt:= 'rslithoyxt5.bin';     //4
     5:
             case ScanParams.ScanMethod of
               Litho,LithoCurrent:  ReniShawLithoScrpt:= 'rslithoyxsst5.bin';//'rslithofysst2.bin';
                       end;
                           end;

          end;
                    end; //ScanPath
*)
 (*if (FlgReniShawUnit) then Scr:=ReniShawLithoScrpt
                      else
                      begin
                      if ScanParams.ScanMethod=Litho        then Scr:=LithoScript;
                      if ScanParams.ScanMethod=LithoCurrent then Scr:=AnodeLithoScript;
                      end;

 if StartWork(Scr)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
 StartDraw;
end;     *)
/////////////
destructor TSpectroscopySTM.Destroy();
begin
    inherited ;
end;

Constructor TSpectroscopySTM.Create;
var  valDiscr:apitype;
begin
 inherited create;
end;

function  TSpectroscopySTM.InitRegimeVars:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(SpectrScrptSTM);
  InitBuffers;
end;

procedure TSpectroscopySTM.StartDraw;
begin
if not assigned(SpectrSTMThread)  then
       begin
           SpectrSTMThread:=  TSpectrSTMDrawThread.Create;
           SpectrSTMThreadActive := True;
       end ;
end;

function  TSpectroscopySTM.InitBuffers:integer;
begin
   GetMem(StopBuf,sizeof(Integer));
   GetMem(DoneBuf,sizeof(Integer));
   Data_out_BufferLength:=SpectrParams.NCurves*SpectrParams.Npoints*2;
   GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;

function   TSpectroscopySTM.InitAlgorithmParamsFile:integer;
begin
  with  AlgParams do
 begin
   NChannels:=SpectrParams.nchannels;
   NElements:=SpectrParams.Npoints*SpectrParams.NCurves;  //dataout    channel
   SizeElements:=2;  //dataout channel
   NGetCountEvent:=SpectrParams.Npoints;
   params[0]:=ByteInversion(SpectrParams.Npoints);
   params[1]:=ByteInversion(SpectrParams.NCurves);
   params[2]:=ByteInversion(round(SpectrParams.StartV*0.001*TransformUnit.BiasV_d) shl 16 );   //SFM 220113
   params[3]:=ByteInversion(round(SpectrParams.Step*0.001*TransformUnit.BiasV_d) shl 16);      //220113
   params[4]:=ByteInversion(SpectrParams.T);
   params[5]:=ByteInversion(integer(STMFLG)); //
 end
end;
procedure TSpectroscopySTM.LinearPath;
begin
end;  {LinearPath}


Procedure TSpectroscopySTM.SetPath;
begin
end;

Procedure TSpectroscopySTM.SetDataIn;
begin

end;

(*procedure TSpectroscopySTM.GetData;
var       i,k:word;
   V,IT:apitype;
   a1,a2,a3:apitype;
begin
        IT:=0;
         i:=0;
         k:=0;
//   for k:=0 to SpectrParams.NPoints-1  do
   while (k< 2*SpectrParams.NPoints)do
    begin
      V:=datatype(PIntegerArray(DataBuf)[i]);
     a1:=datatype(PIntegerArray(DataBuf)[i+1]);
     a2:=datatype(PIntegerArray(DataBuf)[i+2]);
     a3:=datatype(PIntegerArray(DataBuf)[i+3]);
   {  median filtr}
     IT:=a1;
     if IT>a2 then begin a1:=a2; a2:=IT; IT:=a2; end  else begin IT:=a2 end;
     if IT>a3 then begin a2:=a3; a3:=IT; IT:=a1; end;
     if IT>a2 then begin a1:=a2; a2:=IT;         end;
     IT:=a2;
  // Uc:=round(a1/3+a2/3+a3/3); // average   filtr
     U[k]:=V;
     U[k+1]:=IT;
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,k]:=V;               //discrets
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,k+1]:=IT;              //discrets
     inc(i,4);
     inc(k,2);
    end;
end;
*)
Constructor TSpectroscopySFM.Create;
var  valDiscr:apitype;
begin
 inherited create;
 flgLimitSpectr:=false;
 if  SpectrParams.flgIZ then
     begin
       valDiscr:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
       API.DACVT:=apitype(valDiscr);
     end;
end;

destructor TSpectroscopySFM.Destroy();
begin
    inherited ;
end;

function  TSpectroscopySFM.InitRegimeVars:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  if flgUnit=Terra then    SpectrNScrpt:=SpectrNScrptTerra;
  AlgorithmJava:=WideString(SpectrNScrpt);
  InitBuffers;
end;

Procedure TSpectroscopySFM.SetPath;
begin
 LinearPath;
end;

Procedure TSpectroscopySFM.SetDataIn;
begin

end;
 function   TSpectroscopySFM.InitAlgorithmParamsFile:integer;
 var mstepdelay:integer; // количество повторений чтения ячейки
                        // для имитации задержки
 begin
  with  AlgParams do
 begin
   NChannels:=SpectrParams.nchannels;
   NElements:=SpectrParams.NCurves*SpectrParams.Npoints*2;  //dataout    channel
   SizeElements:=3;  //dataout channel  //uam,z,dir
   NGetCountEvent:=15;   //1 5
   params[0]:=ByteInversion(SpectrParams.Npoints);
   params[1]:=ByteInversion(round(SpectrParams.StartP*TransformUnit.Znm_d) shl 16 );   //SFM
   params[2]:=ByteInversion(round(SpectrParams.Step*TransformUnit.Znm_d) shl 16);
   if SpectrParams.flgIZ then params[3]:=
    ByteInversion(round((SpectrParams.LevelIZ)*0.01*round(abs(ApproachParams.SetPoint*TransformUnit.nA_d))) shl 16)
   else params[3]:=ByteInversion(round((100-SpectrParams.LevelSFM)*0.01*ApproachParams.UAMMax) shl 16) ;  //stop approach SFM
   mstepdelay:= round(1000*SpectrParams.T/(150*SpectrParams.Step*TransformUnit.Znm_d))-1;
   if mstepdelay < 0  then  mstepdelay:=0;

   params[4]:=ByteInversion(mstepdelay);
   params[5]:=ByteInversion(integer(STMFLG)); //
 end
end;
function  TSpectroscopySFM.InitBuffers:integer;
var i:integer;
begin
//   Data_in_BufferLength:=SpectrParams.NCurves*SpectrParams.Npoints*2+1;
  Data_out_BufferLength:=SpectrParams.NCurves*SpectrParams.Npoints*2*3;//*4; // (UAM,Z,dir ) ??????
  GetMem(StopBuf,sizeof(Integer)); //3 need for demo
  GetMem(DoneBuf,sizeof(Integer));   //3 need for demo
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;
procedure TSpectroscopySFM.LinearPath;
begin
end;  {LinearPath}


procedure TSpectroscopySFM.StartDraw;
begin
  if not assigned(SpectrThread)  then
       begin
           SpectrThread:=  TSpectrDrawThread.Create;
           SpectrThreadActive := True;
       end ;
end;

(*
procedure TSpectroscopySFM.GetData;
var
   i,k,iend:word;
   Uc:apitype;
   n,a1,a2,a3:apitype;
   iend1,iend2:integer;
begin
         Uc:=0;
         i:=0;
         k:=0;
  iend:=SpectrParams.NCurves*SpectrParams.NPoints*2*2;
 while (i<iend)
 do
   begin
     a1:=datatype(PIntegerArray(DataBuf)[i]);
     a2:=datatype(PIntegerArray(DataBuf)[i+1]);
     a3:=datatype(PIntegerArray(DataBuf)[i+2]);
   {  median filtr}
     Uc:=a1;
     if Uc>a2 then begin a1:=a2; a2:=Uc; Uc:=a2; end  else  Uc:=a2;
     if Uc>a3 then begin a2:=a3; a3:=Uc; Uc:=a1; end;
     if Uc>a2 then begin a1:=a2; a2:=Uc;         end;
     Uc:=a2;
     // Uc:=round(a1/3+a2/3+a3/3); // average   filtr
     U[k]:=UC;
     U[k+1]:=datatype(PIntegerArray(DataBuf)[i+3]);
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,k]:=UC;              //discrets
     ScanData.AquiSpectr.Data[SpectrParams.CurrentLine,k+1]:=datatype(PIntegerArray(DataBuf)[i+3]);
     k:=k+2;
     i:=i+4;
   end;
end;

*)
function  TSpectroscopySFM.getnpoints:apitype;
 begin
     Result:=GetCommonUserVar(ch_Npoints_Terra );     //ch_Npoints_Terra
 end;

function TSpectroscopySFM.Launch:integer;
begin
 result:=0;
 InitRegimeVars;
if StartWork(AlgorithmJava)<>0 then
 begin
  FreeBuffers;
  result:=1;
  exit;
 end;
 StartDraw;
end;

/// SpectrTerra
Constructor TSpectroscopySFMTerra.Create;
//var  valDiscr:apitype;
begin
 inherited create;
 flgLimitSpectr:=false;
(* if  SpectrParams.flgIZ then
     begin
       valDiscr:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
       API.DACVT:=apitype(valDiscr);
     end;
*)
end;

 function   TSpectroscopySFMTerra.InitAlgorithmParamsFile:integer;
 begin
  with  AlgParams do
 begin
   NChannels:=SpectrParams.nchannels+1;
   NElements:=SpectrParams.NCurves*SpectrParams.Npoints*2;  //NCurves=1
   SizeElements:=4;  //dataout channel  //i,uam,z,dir
   NGetCountEvent:=15;   //1 5
   params[0]:=ByteInversion(SpectrParams.Npoints);
   params[1]:=ByteInversion(round(SpectrParams.StartP*TransformUnit.Znm_d) shl 16 );   //SFM
   params[2]:=ByteInversion(round(SpectrParams.Step*TransformUnit.Znm_d) shl 16);
   params[3]:=ByteInversion(round((100-SpectrParams.LevelSFM)*0.01*ApproachParams.UAMMax) shl 16) ;  //stop approach SFM
   params[4]:=ByteInversion(SpectrParams.T);
   params[5]:=ByteInversion(integer(STMFLG)); //
 end
end;
(*function  TSpectroscopySFMTerra.InitRegimeVars:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(SpectrNScrpt);
  InitBuffers;
end;
*)
function  TSpectroscopySFMTerra.InitBuffers:integer;
var i:integer;
begin
  Data_out_BufferLength:=SpectrParams.NCurves*SpectrParams.Npoints*2*4;//*4; // (I,UAM,Z,dir ) ??????
  GetMem(StopBuf,sizeof(Integer)); //3 need for demo
  GetMem(DoneBuf,sizeof(Integer));   //3 need for demo
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;

procedure TSpectroscopySFMTerra.StartDraw;
begin
   if not assigned(SpectrTerraThread)  then
       begin
           SpectrTerraThread:=  TSpectrTerraDrawThread.Create;
           SpectrTerraThreadActive := True;
       end ;
end;
function TSpectroscopySFMTerra.SetUsersParams:boolean;
var ID:integer;
    hr:Hresult;
    n:integer;
    dataparam:Pinteger;
begin
 Javacontrol.IsRunning(flgJavaRunning);
 if flgJavaRunning then
 begin
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start sending spectr terra param');
    {$ENDIF}
   arPCChannel[ch_UserParams].Main.Get_Id(ID);  //data out channel
   if ID=ch_UserParams then
   begin
    try
     GetMem(dataparam,sizeof(integer));
     n:=1;
     PIntegerArray(dataparam)[0]:=integer(SpectrParams.T);
    WriteToChannel(ch_UserParams,dataparam,n);
    finally
      FreeMem(dataparam);
    end;
   end;
  end;
end;
//spectrterra
(*function  TSpectroscopySFMTerra.getnpoints:apitype;
 begin
//     Result:=GetCommonUserVar(ch_Npoints_Terra );     //ch_Npoints_Terra
 end;
 *)
function  TSpectroscopySPTSFM.CreateAlgorithmParamsFile:integer;

var HNDL:integer;
    icod:integer;
    LRec:integer;
//    StreamFile:TFileStream;
    filename:widestring;
 begin
  result:=0;
  LRec:=Sizeof(AlgSpectrSFMParams);
  filename:=InitParamFileJavaPath+InitParamFileJava;
 if FileExists(FileName) then DeleteFile(FileName);
  try
  HNDL:=FileCreate(FileName);
   icod:=FileWrite(HNDL,AlgSpectrSFMParams,LRec);
    if (icod<>LRec)    then
    begin
      NoFormUnitLoc.siLang1.MessageDlg('File write error. Maybe you have not rights to create files. Ask administrator',mtWarning,[mbOk],0);
      result:=1;
      exit;
    end;
  finally
      FileClose(HNDL);
  end;
end;

function  TSpectroscopySPTSFM.InitRegimeVars:integer;
var tStepV:single;
begin
(*  SetCommonVar(adr84,SpectrParams.T);  //aTDelaySPT=$84;
    SetCommonVar(adr86,word(SpectrParams.StartSPT));//asptmax=$86;
    SetCommonVar(adr8A,SpectrParams.NPoints);   //anpointsspt=$8A;
    SetCommonVar(adr8C,word(round(SpectrParams.Step))); //asptstep=$8C;
    SetCommonVar(adr8E,SpectrParams.TC); //atdelaycspt=$8E;
 if not SpectrParams.flgIZ  then
     begin
       SetCommonVar(adr88,word(SpectrParams.EndSPT));//asptmin=$88;
   //    SetCommonVar(adr84,SpectrParams.T);//aTDelaySPT=$84;
      end
     else
     begin                       //STM
       SetCommonVar(adr88,word(SpectrParams.EndSPT));//asptmin=$88;
   //    SetCommonVar(adr84,SpectrParams.T); //aTDelaySPT=$84;
     end;
    SetCommonVar(adr90,word(SpectrParams.flgIZ)); //aflgIZspt=$90;
    InitBuffers;
    SetPath;
    SetDataIn;
    *)
end;

 function    TSteptest.InitAlgorithmParamsFile:integer;    
 begin
     with  AlgParams do
  begin
   NChannels:=ApproachParams.nchannels;
   NElements:=10;     //dataout    channel
   SizeElements:=2;  //dataout channel
   NGetCountEvent:=1;
   params[0]:=ByteInversion(integer(round((1-2*ApproachParams.ZGateMax)*dbltoint))); // absolute  (-1,1)
   params[1]:=ByteInversion(integer(round((1-2*ApproachParams.ZGateMin)*dbltoint))); // absolute  (-1,1)
   params[2]:=ByteInversion(ApproachParams.ZStepsNumb shl 16);
   params[3]:=ByteInversion(ApproachParams.IntegratorDelay);
   params[4]:=ByteInversion(ApproachParams.ScannerDecay);
   params[5]:=ByteInversion(ApproachParams.Speed shl 16);  //need for piezo
   params[6]:=ByteInversion(Approachparams.NCycles );
   params[7]:=ByteInversion(integer(STMFLG));
  end;
end;

function  TStepTest.InitBuffers:integer;
var DataBufLength:integer;
begin
  DataBufLength:=2;//
  GetMem(StopBuf,sizeof(Integer));
  GetMem(DoneBuf,sizeof(Integer));
  GetMem(DataBuf, DataBufLength*sizeof(Integer));
end;

function  TStepTest.InitRegimeVars:integer;
begin
  InitAlgorithmParamsFile;
  CreateAlgorithmParamsFile;
  AlgorithmJava:=WideString(SMTestScrpt); //wide
  InitBuffers;
end;

procedure TStepTest.StartDraw;
begin
 if not assigned(StepTestDrawThread) or (not StepTestDrawThreadActive) then
       begin
           StepTestDrawThread:= TStepTestDraw.Create;
           StepTestDrawThreadActive := True;
       end ;
end;


Constructor TReniShawOsc.Create;
var  valDiscr:apitype;
begin
 inherited create;
(*   API.ADCMCH_ENA:=8; // FOR Z (ADC CURRENT)

        if (RenishawOscParams.AxisName = XFast) or (RenishawOscParams.AxisName = YFast)  then
            n_Points:=round(ReniShawOscParams.LengthFast_discr/ReniShawOscParams.delt_discr)
        else   n_Points:=round(ReniShawOscParams.LengthZ_discr/ReniShawOscParams.delt_discr);

   SetLength(reniShowSignal,n_Points);

   SetLength(signal_scrdetected,n_Points);
*)
end;

destructor TReniShawOsc.Destroy();
begin
    Finalize(reniShowSignal);
  //  Finalize(reniShowSignal_sl);
    Finalize(signal_scrdetected);
   // Finalize(LinearArrayX);
    inherited ;
end;

function  TReniShawOsc.InitBuffers:integer;
begin
  Data_out_BufferLength:=2*n_Points;
  GetMem(DataBuf,Data_out_BufferLength*sizeof(data_out_type));
end;

function  TReniShawOsc.Launch:integer;
 var scr:string;
const  ReniShawScrpt:string='renishowzlin.bin';
begin
    if          RenishawOscParams.AxisName = XFast then   ReniShawScrpt:='rsoscx.bin'
     else if     RenishawOscParams.AxisName = YFast then   ReniShawScrpt:='rsoscy.bin'
      else if     RenishawOscParams.AxisName = Z     then   ReniShawScrpt:='renishowz.bin';;//'renishowzlin.bin';
 result:=0;
 InitRegimeVars;
 scr:= ReniShawScrpt;
 if StartWork(Scr)<>0 then
  begin
  FreeBuffers;
  result:=1;
  exit;
 end;
 StartDraw;
end;

function  TReniShawOsc.InitRegimeVars:integer;
var   tStepV:single;
      ss:string;
      val:integer;
begin
(*  SetCommonVar(adr80,0);
  SetCommonVar(adr82,0);
  SetCommonVar(adr84,word(-ReniShawOscParams.delt_discr));// aPRIM_STEP_X  // important !!! PRIM_STEP_X=-1;
  SetCommonVar(adr86,word(-ReniShawOscParams.delt_discr));// aPRIM_STEP_Y
  if ReniShawOscParams.MovingDirection =1 then
   if ReniShawOscParams.AxisName=xFast then
       SetCommonVar(adr84,unapitype(ReniShawOscParams.delt_discr)) //aPRIM_STEP_X
   else
     if ReniShawOscParams.AxisName=YFast then
       SetCommonVar(adr86,unapitype(ReniShawOscParams.delt_discr));//aPRIM_STEP_Y

 //API.ITRRES:=1;
  SetCommonVar(adr92,ReniShawOscParams.noiseW_discr);   //aNoise_W=$92;
  SetCommonVar(adr96, ReniShawOscParams.NX); // aX_POINTS = $96
  SetCommonVar(adr98, ReniShawOscParams.NY);  // aY_POINTS = $98;
 InitBuffers;
 //SetSpeed;
 SetCommonVar(adr88,0);
 SetCommonVar(adr8C,word(1));  //aPRIM_STEP_ZX=$8C;word(ReniShowParams.delt_discr));
  API.PMSPEED:=0;

//aJUMP
 SetCommonVar(adr9C, ApproachParams.ScannerDecay);  //aScannerDecay = $9C;
 API.PATHSPD:= ReniShawOscParams.microstep_Delay;
 SetCommonVar(adr90, word(ReniShawOscParams.microstep_Delay div 2));//aPath_SPD_BW=$90
 *)
end;

procedure TReniShawOsc.StartDraw;
begin
  if (ReniShawThr = nil) or (ReniShawThreadActive = false) then
     begin
           ReniShawThr:= TReniShawOscThread.Create;
           ReniShawThreadActive := True;
     end ;
end;
(*procedure TReniShawOsc.SetPrimSteps;
begin
SetCommonVar(aPRIM_STEP_X,unapitype(-ScanParams.DiscrNumInMicroStep));
 SetCommonVar(aPRIM_STEP_Y,unapitype(-ScanParams.DiscrNumInMicroStep));
 SetCommonVar(aPRIM_STEP_ZX,unapitype(1));
 SetCommonVar(aPRIM_STEP_ZY,unapitype(1));

if ReniShawOscParams.MovingDirection =1 then
  if ReniShawOscParams.AxisName=xFast then
        SetCommonVar(aPRIM_STEP_X,unapitype(ScanParams.DiscrNumInMicroStep))
  else if ReniShawOscParams.AxisName=YFast then
       SetCommonVar(aPRIM_STEP_Y,unapitype(ScanParams.DiscrNumInMicroStep));

end;
 *)
end.
