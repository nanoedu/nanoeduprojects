 //150202
unit SioCSPM;

//{$DEFINE DYNAMIC}
//{$DEFINE HOME}

interface

uses Windows,Forms,Dialogs,Sysutils,
     {$IFDEF DEBUG}
           frDebug,
       {$ENDIF}
       GlobalType,setupAPI,shlobj,shellapi,comobj,Activex,uShellFunction;

 //nanoducatorII
procedure RegisterOCX(dllname:string);
procedure UnRegisterOCX(dllname:string);
function  ExecAndWaitReg(const ExecuteFile, ParamString : string): boolean;
function  ScanStart:DWORD;
function  ScanInit:DWORD;    // write java algorithm file parameters
function  ScanWork:DWORD;    // run java algorithm
function  ScanStop:boolean;    // stop java algorithm
function  ConnectController:boolean;
function  ReloadScheme:boolean;
function  FindControler:boolean;
function  FindNanoeduAtMyPC:boolean;
function  DisconnectController:boolean;
function  GetCurProc:dword;
function  ScanDone:DWORD;
function  GetSerialNumber(str : PWideChar; len: pDWORD):DWORD;
function  LoadScript(const ScriptName:string):byte;
function  GetCommonVar(CommonVarName:widestring):apitype; //word;
procedure SetCommonVar(CommonVarName:widestring;CommonVarValue:integer);
function  GetCommonUserVar(UserVarName:integer):apitype; //word;
function  SetCommonUserVar(UserVarName:integer;CommonVarValue:apitype):boolean;
function  WaitforJavaNotActive:boolean;
function  WaitforJavaIsActive:boolean;
//MLPCLIb_TLB
function  EnumChannels:boolean;
function  CreateChannelManager:boolean;
function  CreateChannels(const fNchannels:integer):boolean;
function  FreeChannelManager:boolean;
function  FreeChannels:boolean;

 implementation

 uses GlobalVar,CSPMVar,nanoeduhelp,UNanoEduInterface, PortableDeviceApiLib_TLB,UDeviceEvents,
      MLPC_APILib_TLB,MLPC_API2Lib_TLB,MLPC_API2DEMOLIB,MLPC_APILib_DEMO,
      NL3LFBLib_TLB, NL3LFBLib_TLBDemo,frUnitInitEtap;

procedure RegisterOCX(dllname:string);
type
  TRegFunc = function : HResult; stdcall;
var
  ARegFunc : TRegFunc;
  aHandle  : THandle;
  ocxPath  : string;
begin
 try
  ocxPath := ExtractFilePath(Application.ExeName) + dllname;
  aHandle := LoadLibrary(PChar(ocxPath));
  if aHandle <> 0 then
  begin
    ARegFunc := GetProcAddress(aHandle,'DllRegisterServer');
    if Assigned(ARegFunc) then
    begin
      ExecAndWaitReg('regsvr32',' '+ocxPath);
    end;
    FreeLibrary(aHandle);
  end;
 except
  ShowMessage(Format(FormLog.siLangLinked1.GetTextOrDefault('IDS_3' (* 'Unable to register %s' *) ), [ocxPath]));
 end;
end;
procedure UNRegisterOCX(dllname:string);
type
  TRegFunc = function : HResult; stdcall;
var
  ARegFunc : TRegFunc;
  aHandle  : THandle;
  ocxPath  : string;
begin
 try
  ocxPath := ExtractFilePath(Application.ExeName) + dllname;
  aHandle := LoadLibrary(PChar(ocxPath));
  if aHandle <> 0 then
  begin
    ARegFunc := GetProcAddress(aHandle,'DllUnRegisterServer');
    if Assigned(ARegFunc) then
    begin
      ExecAndWaitReg('regsvr32/u', ocxPath);
    end;
    FreeLibrary(aHandle);
  end;
 except
  ShowMessage(Format(FormLog.siLangLinked1.GetTextOrDefault('IDS_6' (* 'Unable to unregister %s' *) ), [ocxPath]));
 end;
end;

function ExecAndWaitReg(const ExecuteFile, ParamString : string): boolean;
var
  SEInfo: TShellExecuteInfo;
  ExitCode: DWORD;
begin
  FillChar(SEInfo, SizeOf(SEInfo), 0);
  SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  with SEInfo do begin
    fMask := SEE_MASK_NOCLOSEPROCESS;
    Wnd := Application.Handle;
    lpFile := PChar(ExecuteFile);
    lpParameters := PChar(ParamString);
    nShow := SW_HIDE;
  end;
  if ShellExecuteEx(@SEInfo) then
  begin
    repeat
      Application.ProcessMessages;
      GetExitCodeProcess(SEInfo.hProcess, ExitCode);
    until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
    Result:=True;
  end
  else Result:=False;
end;
function  FreeChannelManager:boolean;
begin
if FlgCurrentUserLevel<>demo then
 begin
   if assigned(PCChannelManager2) then
 begin
   PCChannelManager2.Disconnect;
   PCChannelManager2:=nil;
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_7' (* 'disconnect Channel manager' *) ));
    {$ENDIF}
 end;
 if assigned(PCChannelManager) then
 begin
  PCChannelManager:=nil;
 end;
 end;
end;

function  EnumChannels:boolean;
var hr:Hresult;
    ncount:LongWord;
     IU:IUNknown;
    IEU:IEnumUnknown;
    IU2:IUNknown;
    ic:IMLPCChannel;
   s,n,i:integer;
begin
 if not  CreateChannelManager then
 begin
  showmessage(FormLog.siLangLinked1.GetTextOrDefault('IDS_8' (* 'error create manager' *) ));
  exit;
 end;
  result:=false;
   hr:=PCChannelManager2.EnumChannels(IU);
   if assigned(IU) then
   if not  FAILED(HR)  then
   begin
      IEU:=IU as  IEnumUnknown;
      i:=0;
    repeat
    begin
       IEU.RemoteNext(1,IU2,ncount);
      if ncount>0 then
      begin
       ic:=iu2 as IMLPCChannel;
       ic.get_Geometry(s,n);
       {$IFDEF DEBUG}
           Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_9' (* 'channel=' *) )+inttostr(i)+FormLog.siLangLinked1.GetTextOrDefault('IDS_10' (* 'geometry=' *) )+inttostr(s)+','+inttostr(n));
       {$ENDIF}
       inc(i);
       ic.disconnect;  //???
      end;
    end;
    until ncount=0;
   end;
 FreeChannelManager;
result:=true;
end;

function CreateChannelManager:boolean;
var hr:HResult;
begin
  result:=false;
if FlgCurrentUserLevel<>demo then
  begin
   PCChannelManager:=CoMLPCChannelManager.Create;
   PCChannelManager.QueryInterface( IID_IMLPCChannelManager2,PCChannelManager2);
  end
  else
  begin
   PCChannelManager:=CoMLPCChannelManagerDemo.Create;
//   PCChannelManager.QueryInterface( IID_IMLPCChannelManager2Demo,PCChannelManager2);
   PCChannelManager2:=TMLPCChannelManager2Demo.Create as   IMLPCChannelManager2Demo;
  end;
//  PCChannelManager2:=PCChannelManager as IMLPCChannelManager2;
  if assigned(PCChannelManager2) then
  begin
   hr:=PCChannelManager2.Connect(nil);
   if  (FAILED(hr)) then
   begin
//     sleep(1000);
   ShowMessage(FormLog.siLangLinked1.GetTextOrDefault('IDS_11' (* 'Error create channels manager' *) ));  // error
    {$IFDEF DEBUG}
        Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_12' (* 'error channels manager create' *) ));
    {$ENDIF}
  (*   hr:=PCChannelManager2.Connect(nil);
      ShowMessage(FormLog.siLangLinked1.GetTextOrDefault('IDS_11' {* 'Error create channels manager' *} ));  // error
    {$IFDEF DEBUG}
        Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_12' {* 'error channels manager create' *} ));
    {$ENDIF}
    *)
   end
   else
   begin
   {$IFDEF DEBUG}
        Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_13' (* 'channels manager create' *) ));
    {$ENDIF}
    result:=true;
   end;
  end
  else
     {$IFDEF DEBUG}
        Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_14' (* 'error get interface channels manager2' *) ));
    {$ENDIF};
 // end
end;

function  FreeChannels:boolean;
var i,s,n :integer;
   ncount:LongWord;
     hr:HResult;
     IU:IUNknown;
    IEU:IEnumUnknown;
    IU2:IUNknown;
    ic:IMLPCChannel;
begin
 result:=true;
  if assigned(arPCChannel) then
 begin
  for I := 0 to AlgParams.NChannels - 1 do
  begin
    arPCChannel[i].Main.Disconnect;
    arPCChannel[i].Main := nil;
    {$IFDEF DEBUG}
      if assigned(Formlog) then
          Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_15' (* 'disconnect channels=' *) )+inttostr(i));
    {$ENDIF}
  end;

  FreeChannelManager;

  JavaControl.Delete(InitParamFileJava);
   application.processmessages;
  JavaControl.Delete(AlgorithmJava);
  application.processmessages;
  {$IFDEF DEBUG}
        if assigned(Formlog) then
          Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_16' (* 'free channels' *) ));
  {$ENDIF}
 end;
end;

function CreateChannels(const fNchannels:integer):boolean;
var
    IU:IUNknown;
    ncount:LongWord;
    i,res:integer;
    fID:Integer;
    hr:HResult;
begin
if not  CreateChannelManager then
begin
 exit;
end;
  result:=false;
  JavaControl.IsRunning(flgJavaRunning);
if flgJavaRunning then
begin
  i:=0;
  repeat
  begin
    with  arPCChannel[i] do
    begin
     repeat
      hr:=PCChannelManager2.WaitChannel(i,200,IU);
     if failed(hr)  then
     {$IFDEF DEBUG}
       Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_17' (* 'error wait channel=' *) )+inttostr(i)+' '+inttostr(hr));
    {$ENDIF};
    until not failed(hr);
    if flgCurrentUserLevel<>Demo then begin
                                       Main := IU as IMLPCChannel;
                                       ChannelRead := Main as IMLPCChannelRead;
                                       ChannelRead2:= Main as IMLPCChannelRead2;
                                       ChannelWrite:= Main as IMLPCChannelWrite;
                                      end
                                 else begin
                                       Main := IU as IMLPCChannelDemo;
                                       ChannelRead := TMLPCChannelReadDemo.Create(ArDemoChannelParams[i].PBuffer,ArDemoChannelParams[i].SizeElement,ArDemoChannelParams[i].NElements)  as IMLPCChannelReadDemo;
                                       ChannelRead2:= TMLPCChannelRead2Demo.Create(ArDemoChannelParams[i].PBuffer,ArDemoChannelParams[i].SizeElement,ArDemoChannelParams[i].NElements)  as IMLPCChannelRead2Demo;
                                       ChannelWrite:= TMLPCChannelWriteDemo.Create as IMLPCChannelWriteDemo;
                                      end;
//     Read := IU as IMLPCChannelRead;
//     Write:= IU as IMLPCChannelWrite;
     if assigned(Main)  then
     begin
       Main.get_ID(fID);       //???       create only in channel
      if flgCurrentUserLevel<>Demo then  ID:=fID
                                   else  ID:=i ;
    {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_18' (* 'channel create' *) )+inttostr(i));
    {$ENDIF}
     end;
    end;
   inc(i);
  end
  until i=fNchannels;
   result:=true;
   {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_19' (* 'channels create end' *) ));
    {$ENDIF}
end
else
begin
 showmessage(FormLog.siLangLinked1.GetTextOrDefault('IDS_20' (* 'java error create channels' *) ));
   {$IFDEF DEBUG}
        Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_21' (* 'java not running' *) ));
    {$ENDIF}
end;
end;

function  FreeCSPMLib( hLibModule:HMODULE):boolean; // Все функции из DLL
begin

end;

function  LoadCSPMlib(const LibName:string):THandle; // procedure LoadCSPMLib;   GetMem(P,20);
begin

end;

function  ScanDone:DWORD;
var n:integer;
    hr:Hresult;
begin
 if FlgCurrentUserLevel<>demo then
  begin
        try
          PIntegerArray(StopBuf)[0]:= Stop;
          n:=1;
          hr:=(arPCChannel[ch_stop].Main as IMLPCChannelWrite).Write(StopBuf,n); //drawdone
          if failed(hr)  then
          {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_22' (* 'error write done channel' *) ))
            else
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_23' (* 'write done n=' *) )+ inttostr(n));
          {$ENDIF};
        finally
        end;
  end;
end;


function  GetCurProc:DWORD;
begin

end;
function  GetSerialNumber(str : PWideChar; len: pDWORD):DWORD;
begin

end;


function  ScanStart:DWORD;
begin
//
end;

function  ScanInit:DWORD;
var
  MaskFilename:string;
  hr:HResult;
begin
 result:=1;
  if assigned(JavaControl) then
  begin
  if FileExists(UserNanoeduApplDataPath+InitParamFileJava) then
   begin
      JavaControl.Delete(InitParamFileJava);
     repeat
       application.processmessages;
     until flgfileparamdeleted;
    hr:=JavaControl.Upload(UserNanoeduApplDataPath+InitParamFileJava,InitParamFileJava);
     result:=0;
   end
   else
   begin
     {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_24' (* 'File ' *) )+UserNanoeduApplDataPath+InitParamFileJava+FormLog.siLangLinked1.GetTextOrDefault('IDS_25' (* ' not exist!' *) ));
    {$ENDIF};
    showmessage(FormLog.siLangLinked1.GetTextOrDefault('IDS_24' (* 'File ' *) )+UserNanoeduApplDataPath+InitParamFileJava+FormLog.siLangLinked1.GetTextOrDefault('IDS_25' (* ' not exist!' *) ));
   end;
  end;
end;

function  ScanStop:boolean;
begin
 {$IFDEF DEBUG}
     Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_28' (* 'start stop' *) ));
 {$ENDIF}
 result:=SetCommonUserVar(ch_Stop,StopJava);   // set param java to stop scanning;
end;

function  ScanWork:DWORD;
var hr:Hresult;
begin
 result:=0;
  if assigned(JavaControl) then
  begin
    {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_29' (* 'test Is Java running?' *) ));
    {$ENDIF}
  hr:=JavaControl.Run(AlgorithmJava);
    if failed(Hr) then
    begin
     {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_30' (* 'error java run' *) ));
    {$ENDIF};
      result:=4;
      exit;
    end;
    {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_31' (* 'run java' *) ));
    {$ENDIF}
   Sleep(200); // wait for read iniparam file and create channels
if not  WaitforJavaIsActive then
begin
  result:=3;
  exit;
end;
  {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_32' (* 'java is running' *) ));
  {$ENDIF}
    result:=1;
 end;
end;

function  ConnectController:boolean;
  var
    i:integer;
    count:dword;
    name:widestring;
    CZTune:word;
    IU:IUnknown;
    IOSC:IDeviceChannelsInfo;
    hr:Hresult;
    vbool:WordBool;
begin
    result:=false;
 if FlgCurrentUserLevel<>Demo then
 begin
     hr:=NanoeduDevice.get_Device(IU);
      if Failed(Hr) then
        begin
         {$IFDEF DEBUG}
           Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_33' (* 'error get device interface' *) ));
         {$ENDIF};
          formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_33' (* 'error get device interface' *) ));
         exit;
        end;
//   Starting to Listen Device events
    NanoeduPortDev:=IU as  IPortableDevice;
    DeviceEventsCallback:=CPortableDeviceEventsCallback.Create;
    hr:=DeviceEventsCallback.Register(NanoeduPortDev);
    if Failed(Hr) then   showmessage(FormLog.siLangLinked1.GetTextOrDefault('IDS_35' (* 'error reg event' *) ));
 end;
//
   NanoeduDevice.QuerySchematic(IU);

  if FlgCurrentUserLevel<>Demo then SchematicControl:= IU as ISchematicControl
                               else SchematicControl:= IU as ISchematicControlDemo;
  if assigned(SchematicControl) then
  begin
    hr:=SchematicControl.IsRunning(vbool);
     if Failed(Hr) then
        begin
         {$IFDEF DEBUG}
           Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_36' (* 'error test. Is scheme running' *) ));
         {$ENDIF};
         formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_36' (* 'error test. Is scheme running' *) ));
         exit;
        end;
    if vbool then
    begin
       {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_38' (* 'scheme is running. Stop scheme.' *) ));
       {$ENDIF}
       formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_38' (* 'scheme is running. Stop scheme.' *) ));
       hr:=SchematicControl.Stop();
       if Failed(Hr) then
        begin
         {$IFDEF DEBUG}
               Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_40' (* 'error stop scheme' *) ));
         {$ENDIF};
         formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_40' (* 'error stop scheme' *) ));
         exit;
        end;
    end;
    hr:=SchematicControl.IsLoaded(vbool);
   if FileExists(Scheme)  then
    begin
     if  not (vbool) then  SchematicControl.Load(Scheme)
     else
     begin //not loaded
      {$IFDEF DEBUG}
          Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_42' (* 'scheme ' *) )+ExtractFileName(Scheme)+ FormLog.siLangLinked1.GetTextOrDefault('IDS_43' (* ' was loaded ' *) ));
      {$ENDIF};
      formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_42' (* 'scheme ' *) )+ExtractFileName(Scheme)+ FormLog.siLangLinked1.GetTextOrDefault('IDS_43' (* ' was loaded ' *) ));
      hr:=SchematicControl.UnLoad;
      if Failed(Hr) then
      begin
     {$IFDEF DEBUG}
          Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_46' (* 'error unload scheme' *) ));
       {$ENDIF};
       formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_46' (* 'error unload scheme' *) ));
       exit;
      end
      else
      begin
        {$IFDEF DEBUG}
          Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_48' (* 'scheme is unloaded' *) ));
       {$ENDIF};
        formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_48' (* 'scheme is unloaded' *) ));
      end;
     sleep(1000);        //need to work when unloaded made 11/10/12  !!!!
     hr:=SchematicControl.Load(Scheme);

     if Failed(Hr) then
      begin
     {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_50' (* 'error load scheme' *) ));
     {$ENDIF};
      formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_50' (* 'error load scheme' *) ));
       exit;
      end
      else
      begin
      {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_52' (* 'load scheme' *) ));
       {$ENDIF};
        formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_52' (* 'load scheme' *) ));
         formInitUnitEtape.CheckListBox.Checked[idloadscheme]:=true;
      end;
     end
    end
    else //sheme not exist;
    begin
       {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_54' (* 'scheme not exist' *) ));
      {$ENDIF};
       formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_54' (* 'scheme not exist' *) ));
      messagedlg(FormLog.siLangLinked1.GetTextOrDefault('IDS_56' (* 'Scheme ' *) )+ExtractFileName(Scheme)+FormLog.siLangLinked1.GetTextOrDefault('IDS_57' (* '  not exist!!' *) ),mterror,[mbOK],0);
      result:=false;
      exit;
    end;

    repeat
       hr:=SchematicControl.IsLoaded(vbool);
     if Failed(Hr) then
     begin
     {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_58' (* 'error test. Is scheme loaded' *) ));
       {$ENDIF};
        formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_58' (* 'error test. Is scheme loaded' *) ));
       exit;
     end;
    until vbool;
   if (vbool) then
    begin
        {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_60' (* 'scheme loaded ' *) ));
       {$ENDIF}
       formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_60' (* 'scheme loaded ' *) ));
        formInitUnitEtape.CheckListBox.Checked[idloadscheme]:=true;
       hr:=SchematicControl.Run;
     if Failed(Hr) then
     begin
      {$IFDEF DEBUG}
          Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_62' (* 'error run scheme' *) ));
      {$ENDIF};
      formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_62' (* 'error run scheme' *) ));
      exit;
     end
     else
     begin
       {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_64' (* 'scheme is running ' *) ));
      {$ENDIF};
       formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_64' (* 'scheme is running ' *) ));
        formInitUnitEtape.CheckListBox.Checked[idruntopo]:=true;
     end;                                                
  //  SetPIDParameters;
    hr:=NanoeduDevice.QueryJava(IU);
   if failed(Hr) then
    begin
     {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_66' (* 'error! query java' *) ));
    {$ENDIF};
    formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_66' (* 'error! query java' *) ));
    end;
  if assigned(IU) then
   begin
   if FlgCurrentUserLevel<>Demo then JavaControl:=IU as IJavaControl
                                else JavaControl:=IU as IJavaControlDemo;
   end
    else
    begin
   {$IFDEF DEBUG}
            Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_68' (* 'error getting javacontrol interface ' *) ));
   {$ENDIF};
   formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_68' (* 'error getting javacontrol interface ' *) ));
    end;
     result:=true;
   end;
  end
  else
  begin
   {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_70' (* 'error getting schematic interface ' *) ));
   {$ENDIF};
   formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_70' (* 'error getting schematic interface ' *) ));
  end;
  //init OSC Channels
   if FlgCurrentUserLevel<>Demo then
   begin
    SchematicControl.QueryLFB(WideString('OSC1'),IU);
    IOSC:=IU as IDeviceChannelsInfo;
    IOSC.GetCount(count);
    Setlength(aOSCParamVal,count);
    Setlength(aOSCParamName,count);
    OSCParams.NChannels:=count;
    for I := 0 to OSCParams.NChannels-1 do
    begin
     IOSC.GetChannelName(i,name);
     aOSCParamName[i]:=name;
    end;
   end;
end;
function FindControler:boolean;
var
  Guid : TGUID;
  PnPHandle: HDevInfo;
  DeviceInfoData : SP_DEVINFO_DATA;
  DeviceInterfaceData: SP_DEVICE_INTERFACE_DATA;
  i : Cardinal;
  BytesReturned: PDWORD;
  Success: LongBool;
  DataT:pdword;
  buffersize:dword;
  Buffer: array [0..256] of AnsiCHAR;// buffer : PByte;
  st:ansistring;
begin
  result:=false;
  PnPHandle:= SetupDiGetClassDevs(nil, nil, 0, DIGCF_PRESENT or DIGCF_ALLCLASSES);
 Try
  i:= 0;
  DeviceInfoData.cbSize:= SizeOf(SP_DEVINFO_DATA);
  DeviceInterfaceData.cbSize := SizeOf(SP_DEVICE_INTERFACE_DATA);
  Repeat
   Success:= SetupDiEnumDeviceInfo(PnPHandle, i, DeviceInfoData);
   if Success then
    begin
     buffersize:= 0;
     BytesReturned := 0;
     DataT := 0;
     Buffer[0] := #0;
     while not
      SetupDiGetDeviceRegistryProperty(PnPHandle, DeviceInfoData, SPDRP_DEVICEDESC,
                           DataT, PByte(@Buffer[0]), SizeOf(Buffer), BytesReturned)

     do
     begin
      if (GetLastError() = ERROR_INSUFFICIENT_BUFFER) then
      begin
      end
      else
      begin
       break;
      end;
    end;  //while
    st:=buffer;
    if (LowerCase(st)=lowercase(DigNanoeduDevName))  or (LowerCase(st)=lowercase(DigNanoeduDevOldName))
      or (LowerCase(st)=lowercase(DigNanoeduDevBaseName))  then
    begin
      result:=true;
      break;
    end;
   end; //success
   Inc(i);
   Application.ProcessMessages;
  until not Success; //repeat
 finally
  SetupDiDestroyDeviceInfoList(PnPHandle);
 end;
(* if result then
  {$IFDEF DEBUG}
      if assigned(FormLog) then   Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_73' { 'MLPC Controler is turned on!' }) ));
    {$ENDIF};
 *)
end;
function  ReloadScheme:boolean;
var hr:Hresult;
  vbool:WordBool;
  begin
(*   iderrstopscheme=0;
 iderrunloadscheme=1;
 iderrloadscheme=2;
 iderrruntopo=3;
 iderrgetadapterid=4;
*)
   result:=false;
 if assigned(SchematicControl) then
  begin
    hr:=SchematicControl.IsRunning(vbool);
     if Failed(Hr) then
        begin
         {$IFDEF DEBUG}
           Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_36' (* 'error test. Is scheme running' *) ));
         {$ENDIF};
         formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_36' (* 'error test. Is scheme running' *) ));
         exit;
        end;
    if vbool then
    begin
       {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_38' (* 'scheme is running. Stop scheme.' *) ));
       {$ENDIF}
       formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_38' (* 'scheme is running. Stop scheme.' *) ));
       hr:=SchematicControl.Stop();
       if Failed(Hr) then
        begin
         {$IFDEF DEBUG}
               Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_40' (* 'error stop scheme' *) ));
         {$ENDIF};
         formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_40' (* 'error stop scheme' *) ));
         exit;
        end;
            formInitUnitEtape.CheckListBoxErr.Checked[iderrstopscheme]:=true;

    end;

    hr:=SchematicControl.IsLoaded(vbool);
    if  (vbool) then
    begin
      hr:=SchematicControl.UnLoad;
     if Failed(Hr) then
     {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_75' (* 'error scheme unload ' *) ));
       {$ENDIF};
            formInitUnitEtape.CheckListBoxErr.Checked[iderrunloadscheme]:=true;
    end;
    sleep(1000);        //need to work when unloaded made 11/10/12  !!!!
     hr:=SchematicControl.Load(Scheme);

     if Failed(Hr) then
      begin
     {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_50' (* 'error load scheme' *) ));
     {$ENDIF};
      formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_50' (* 'error load scheme' *) ));
       exit;
      end
      else
      begin
      {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_52' (* 'load scheme' *) ));
       {$ENDIF};
        formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_52' (* 'load scheme' *) ));
        formInitUnitEtape.CheckListBoxErr.Checked[iderrloadscheme]:=true;
        hr:=SchematicControl.Run;
        if Failed(Hr) then
        begin
        {$IFDEF DEBUG}
          Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_62' (* 'error run scheme' *) ));
        {$ENDIF};
         formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_62' (* 'error run scheme' *) ));
         exit;
        end
        else
        begin
        {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_64' (* 'scheme is running ' *) ));
        {$ENDIF};
        formInitUnitEtape.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_64' (* 'scheme is running ' *) ));
        formInitUnitEtape.CheckListBoxErr.Checked[iderrruntopo]:=true;
     end;
          result:=true;
      end;
  end;
end;
function  DisconnectController:boolean;
var hr:Hresult;
  vbool:WordBool;
  begin
if FlgCurrentUserLevel<>demo then
begin
   DeviceEventsCallback.UnRegister(NanoeduPortDev);
   DeviceEventsCallback.Release;
end;
     hr:=SchematicControl.IsRunning(vbool);
   if vbool then
   begin
    hr:=SchematicControl.Stop;
     if Failed(Hr) then
     {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_40' (* 'error stop scheme' *) ));
       {$ENDIF};
   end;
    hr:=SchematicControl.IsLoaded(vbool);
    if  (vbool) then
    begin
      hr:=SchematicControl.UnLoad;
     if Failed(Hr) then
     {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_75' (* 'error scheme unload ' *) ));
       {$ENDIF};
    end;
    hr:=NanoeduDevice.Disconnect;
     if Failed(Hr) then
     {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_76' (* 'error device disconnection' *) ));
       {$ENDIF};
     NanoeduDevice:=nil;
end;

function  FindNanoeduAtMyPC:boolean;
 var i,j:integer;
 Desktop,PCFolder:IshellFolder;
 pc:PItemIDList;
 s,name:string;
 PCPIDL:PItemIDList;
 ItemPCList:TItemListArray;
 Handle:HWND;
begin
  result:=false;
  OleCheck(SHGetSpecialFolderLocation(Handle, CSIDL_DRIVES, PCPIDL));
  OleCheck(SHGetDesktopFolder(DeskTop));
  OleCheck(DeskTop.BindToObject(pcPidl, nil, IID_IShellFolder,PCFolder));
  ItemPCList:=GetShellItems(PCFolder);
   for j := 0 to length(ItemPCList) - 1 do
   begin
     name:=GetShellObjectName(PCFolder, ItemPCList[j]);
     if AnsiPos(FormLog.siLangLinked1.GetTextOrDefault('IDS_77' (* 'NanoeducatorLE' *) ),name)<>0 then result:=true;
  end;
end;

function GetCommonVar(CommonVarName:widestring):apitype;
var   val:int64;
       IU:IUnknown;
     pVal: OleVariant;
     label 100;
function ReadCell:boolean;
begin
  try
   result:=true;
   NanoeduPC_Cell_CELL.Read(pVal);
    except
     on Exception do
      begin
       result:=false;
      // showmessage('block resource');
      end;
   end;
end;

begin
if FlgCurrentUserLevel<>Demo then
begin
 if  flgControlerTurnON then
 begin
 if assigned(SchematicControl) then
 begin
   SchematicControl.QueryLFB(CommonVarName,IU);
   if flgCurrentUserLevel<>demo then
   begin
    if assigned(IU) then
    begin
     NanoeduPC_Cell:=IU as ILFB;
     NanoeduPC_Cell_CELL:=NanoeduPC_Cell as ILFB_CELL;
    end;
   end
   else
   begin
   if assigned(IU) then
    begin
     NanoeduPC_Cell:=IU as ILFBDemo;
     NanoeduPC_Cell_CELL:=NanoeduPC_Cell as ILFB_CELLDemo;
    end;
   end;
   end;
 end;

 while (not   ReadCell) do sleep(200);

 if (CommonVarName<>SD_GENF) then Result:=pval shr 16
                             else
                             begin
                              val:=integer(PVal);
                              val:=Integer(int64(Val*million) shr 32);
                              Result:=val;    //freq  internal   -> Hrz
                             end;
end;
end;


procedure SetCommonVar(CommonVarName:widestring;CommonVarValue:Integer);
var
  IU:IUnknown;
  val:Integer;
  state:Integer;
  val64:int64;
  pVal:OleVariant;
  res:boolean;
function WriteCell:boolean;
var flgerr:boolean;
begin
   //flg:=true;
  result:=true;
 repeat
  begin
   try
   flgerr:=false;
    NanoeduPC_Cell_CELL.Write(pVal);
  except
     on Exception do
      begin
     //  result:=false;
       {$IFDEF DEBUG}
       Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_78' (* 'exception write commonvar= ' *) )+CommonVarName);
     {$ENDIF}
     sleep(100);
       flgerr:=true;
      end;
  end;
  end  until not flgerr;
end;
begin
if FlgCurrentUserLevel<>Demo then
begin
 if flgControlerTurnON then
 begin
  if assigned(SchematicControl) then
   begin
    SchematicControl.QueryLFB(CommonVarName,IU);
     if assigned(IU) then
     begin
        NanoeduPC_Cell:=IU as ILFB;
        NanoeduPC_Cell_CELL:=NanoeduPC_Cell as ILFB_CELL;
      end;
     if (CommonVarName<>SD_GENF)
                   then
                   begin
                    if (CommonVarName<>DAC_IREF_AM) then
                                                     begin
                                                       if CommonVarName=U_VECTOR then  val:=CommonVarValue    //271011
                                                       else
                                                       if CommonVarName=USER_err then
                                                       begin
                                                        if CommonVarValue=1 then  val:=$7FFFFFFF
                                                                            else  val:=$80000000;//CommonVarValue;
                                                       end
                                                       else
                                                       if CommonVarName=SelBRamU then
                                                       begin
                                                         if CommonVarValue=1 then  val:=$80000000   //use dchange
                                                                             else  val:=0//use bram U;
                                                       end
                                                       else
                                                       if CommonVarName=ITR_RES then
                                                       begin
                                                            case flgRetract of
                                                          true: val:=0;
                                                         false:begin
                                                                if STMflg  then  val:=$40000000
                                                                           else  val:=$80000000;
                                                               end;
                                                                     end;
                                                       end
                                                       else  //101212
                                                       if CommonVarName=SMZ_STEP then
                                                       begin
                                                         if CommonVarValue<>0 then
                                                         begin
                                                          val:=CommonVarValue shl 16;
                                                          val:=val or $00008000;//+32768   maskMotorOn
                                                         end
                                                         else
                                                         begin
                                                           state:= MotorCurrentStatus shl 16;  //290113
                                                           val:=state and $FFFF7FFF;    //maskMotorOff
                                                         end
                                                       end
                                                       else
                                                       if CommonVarName=IMaxCut     then val:=CommonVarValue
                                                       else val:=CommonVarValue shl 16
                                                     end
                                                     else
                                                     begin
                                                      if CommonVarName=DAC_IREF_AM then val:=round((CommonVarValue/100)*dbltoint); //DAC_IREF_AM

                                                     end;
                   end
                   else
                   begin  //SD_GENF
                    val64:=int64(word(CommonVarValue)) shl 32;
                    val:=integer(round(val64/million)); //freq
                   end;
                   PVal:=OleVariant(val);
                   res:= false;
                   res:= WriteCell;
                   {$IFDEF DEBUG}
                          if not res then Formlog.memolog.Lines.add('Set '+CommonVarName+'>>> ERROR')
                        else
                      Formlog.memolog.Lines.add('Set '+CommonVarName+'=' + inttostr(val)+'; $'+Format('%x',[val])+'  === OK');
               {$ENDIF}
        //   while( not WriteCell)  do sleep(200);
    end;
   end;
 end;
end;


function LoadScript(const ScriptName:string):byte;
var fAlgorithmFile:string;
     hr:Hresult;
begin
  result:=1;
  if assigned(JavaControl) then
  begin
   WaitforJavaNotActive;
   fAlgorithmFile:=AlgorithmPath+ScriptName;
   if FileExists(fAlgorithmFile) then
   begin
     AlgorithmJava:=WideString(ScriptName);
     JavaControl.Delete(AlgorithmJava);
     repeat
       application.processmessages;
     until flgfilealgdeleted;
  // if flgfilealgdel then
    hr:=JavaControl.UpLoad(Widestring(fAlgorithmFile),AlgorithmJava);
    if not Failed(Hr) then
    {$IFDEF DEBUG}
        Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_84' (* 'java algorithm upload' *) ));
    {$ENDIF};
   if FlgCurrentUserLevel<>Demo then
    begin
     repeat
      sleep(200);
      application.processmessages;
     until flgfilealguploaded;
     result:=0;      //OK
    end
    else
     begin flgfilealguploaded:=true; result:=0; end;
   end;
  end;
end;

function  GetCommonUserVar(UserVarName:integer):apitype; //word;
var hr:HResult;
    IU:IUNknown;
    IEU:IEnumUnknown;
    IU2: IUNknown;
    ncount:LongWord;
    res:Pinteger;
    n,ID:Integer;
    fPCChannel:IMLPCChannel;
    fPCChannelRead2:IMLPCChannelRead2;
    fPCChannelManager2:IMLPCChannelManager2;
    fPCChannelManager:IMLPCChannelManager;
begin
if FlgCurrentUserLevel<>Demo then
begin
  hr:=Javacontrol.IsRunning(flgJavaRunning);
   if failed(Hr) then
   begin
     {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_85' (* 'error ask! java is running' *) ));
    {$ENDIF};
    flgJavaRunning:=false;
   end;
 if flgJavaRunning then
 begin
     fPCChannelManager:=CoMLPCChannelManager.Create;
     hr:=fPCChannelManager.QueryInterface( IID_IMLPCChannelManager2,fPCChannelManager2);
     if  (FAILED(hr)) then
     begin
       ShowMessage(FormLog.siLangLinked1.GetTextOrDefault('IDS_86' (* 'Error create Channel manager' *) ));  // error
       fPCChannelManager2.Disconnect;
       fPCChannelManager2:=nil;
       exit;
     end;
     repeat
      hr:=fPCChannelManager2.WaitChannel(UserVarName,200{INFINITE_TIME},IU);
     if failed(hr)  then
      {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_17' (* 'error wait channel=' *) )+inttostr(UserVarName)+' '+inttostr(hr))
      else
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_88' (* 'create user channel=' *) )+inttostr(UserVarName));
      {$ENDIF};
     until not failed(hr);
      if assigned(IU) then
      begin
        if flgCurrentUserLevel<>Demo then fPCChannel:=IU as IMLPCChannel
                                     else fPCChannel:=IU as IMLPCChannelDemo;
       hr:=fPCChannel.get_ID(ID);
        if (ID=UserVarName) then
         begin
          try
            new(res);
            n:=1;
           if flgCurrentUserLevel<>Demo then fPCChannelRead2:=fPCChannel as  IMLPCChannelRead2
                                        else fPCChannelRead2:=fPCChannel as  IMLPCChannelRead2Demo;
            hr:=fPCChannelRead2.ReadWait(res,n,1000{INFINITE_TIME});       //???
            if Failed(Hr)  then showmessage(FormLog.siLangLinked1.GetTextOrDefault('IDS_89' (* 'error  channel read' *) ))
                           else  result:=apitype(res^);
            hr:=fPCChannel.Disconnect;
            fPCChannel:=nil;
            if Failed(Hr)  then showmessage(FormLog.siLangLinked1.GetTextOrDefault('IDS_90' (* 'error channel disconnect' *) ));
          finally
            dispose(res);
          end;
         end;
      end;
       hr:=fPCChannelManager2.Disconnect;
       fPCChannelManager2:=nil;
 end;
end;
end;

function SetCommonUserVar(UserVarName:Integer;CommonVarValue:apitype):boolean;
var
    hr:HResult;
    IU:IUNknown;
    IEU:IEnumUnknown;
    IU2: IUNknown;
    ncount:LongWord;
    n,ID:integer;
    val:Pinteger;
    fPCChannel:IMLPCChannel;
    fPCChannelWrite2:IMLPCChannelWrite2;
    fPCChannelManager2:IMLPCChannelManager2;
    fPCChannelManager:IMLPCChannelManager;
begin
   result:=false;
if FlgCurrentUserLevel<>Demo then
begin
   hr:=Javacontrol.IsRunning(flgJavaRunning);
   if failed(Hr) then
   begin
     {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_85' (* 'error ask! java is running' *) ));
    {$ENDIF};
    flgJavaRunning:=false;
   end;
 if flgJavaRunning then
 begin
     fPCChannelManager:=CoMLPCChannelManager.Create;
     fPCChannelManager.QueryInterface( IID_IMLPCChannelManager2,fPCChannelManager2);
     hr:=fPCChannelManager2.Connect(nil);
     if  (FAILED(hr)) then
     begin
       ShowMessage(FormLog.siLangLinked1.GetTextOrDefault('IDS_86' (* 'Error create Channel manager' *) ));  // error
        fPCChannelManager2.Disconnect;
        fPCChannelManager2:=nil;
       exit
     end;
     repeat
      hr:=fPCChannelManager2.WaitChannel(UserVarName,200{INFINITE_TIME},IU);
      if failed(hr)  then
      {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_93' (* 'error wait channel =' *) )+inttostr(UserVarName)+' '+inttostr(hr))
      else
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_94' (* 'create user channel = ' *) )+inttostr(UserVarName));
      {$ENDIF};
     until not failed(hr);
     if assigned(IU) then
     begin
       if flgCurrentUserLevel<>Demo then   fPCChannel:=IU as IMLPCChannel
                                    else   fPCChannel:=IU as IMLPCChannelDemo;
      fPCChannel.get_ID(ID);
      if ID=UserVarName then
      begin
      try
       new(val);
       val^:= CommonVarValue;// shl 16;     //???
       n:=1;
       if flgCurrentUserLevel<>Demo then fPCChannelWrite2:=fPCChannel as  IMLPCChannelWrite2
                                    else fPCChannelWrite2:=fPCChannel as  IMLPCChannelWrite2Demo;
       hr:=fPCChannelWrite2.WriteWait(val,n,1000{{INFINITE_TIME}); //???
       if Failed(Hr)  then
       begin
           {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_95' (* 'error  channel writing ' *) )+inttostr(UserVarName)+' '+inttostr(hr))
           {$ENDIF};
       end
       else
       {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_96' (* 'write to channel ' *) )+inttostr(UserVarName))
       {$ENDIF};
       {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_97' (* 'start disconnect channel  ' *) ))
       {$ENDIF};
//       application.processmessages;
         hr:=fPCChannel.Disconnect;
         fPCChannel:=nil;
          if Failed(Hr)  then
            {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_98' (* 'error disconnect channel stop' *) ))
            {$ENDIF}
          else
           {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_99' (* 'disconnect channel stop' *) ))
           {$ENDIF};
//         showmessage('error channel disconnect');
      finally
       dispose(val);
      end;
     end; //id
  end; //assign IU
     {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_100' (* 'start disconnect channel manager2 ' *) ))
       {$ENDIF};
  application.processmessages;
    hr:=fPCChannelManager2.Disconnect;
     if Failed(Hr)  then
     {$IFDEF DEBUG}
       Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_101' (* 'error disconnect channel manager2' *) ))
     {$ENDIF}
     else
       {$IFDEF DEBUG}
              Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_102' (* 'disconnect manager2' *) ))
       {$ENDIF};
     fPCChannelManager2:=nil;
     result:=true;
 end;  // java false running
 end;
end;

function  WaitforJavaNotActive:boolean;
var
   hr:Hresult;
   count:integer;
begin
 result:=false;
      {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_103' (* 'wait for java is not active' *) ));
    {$ENDIF};
if flgCurrentUserLevel<>Demo then
begin
 Count:=0;
 repeat
   hr:=JavaControl.IsRunning(flgJavaRunning);
  if failed(Hr) then
   begin
     {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_85' (* 'error ask! java is running' *) ));
    {$ENDIF};
  // end;
    if count>40 then
    begin
     {$IFDEF DEBUG}
       Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_105' (* 'error wait for java is not active' *) ));
     {$ENDIF};
     exit;
    end;
    inc(count);
   end;
   application.processmessages;//sleep(200);
  until not flgJavaRunning;
  result:=not flgJavaRunning;
    {$IFDEF DEBUG}
  if result then   Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_106' (* 'java is not active' *) ));
    {$ENDIF};
end
else  result:=true;
end;

function  WaitforJavaIsActive:boolean;
var
   hr:Hresult;
   count:integer;
begin
 result:=false;
    {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_107' (* 'wait for java is  active' *) ));
    {$ENDIF};
if flgCurrentUserLevel<>Demo then
begin
  count:=0;
 repeat
   hr:=JavaControl.IsRunning(flgJavaRunning);
   if failed(Hr) then
   begin
     {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_108' (* 'error ask! java is active' *) ));
    {$ENDIF};
//    exit;
//   end;
    sleep(200);
    if count>40 then
    begin
     {$IFDEF DEBUG}
       Formlog.memolog.Lines.add(FormLog.siLangLinked1.GetTextOrDefault('IDS_109' (* 'error ask! java is not running' *) ));
     {$ENDIF};
     exit;
    end;
    inc(count);
   end;
   application.processmessages;
  until  flgJavaRunning ;
end
else   flgJavaRunning:=true;
  result:=flgJavaRunning;
end;
end.





