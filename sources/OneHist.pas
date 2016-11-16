//test for one limit start program 190802
unit OneHist;


interface
uses   Messages,Classes;
 const
//  WM_USER    =   $4000;
  SM_OTHER_INSTANCE_EXECUTED = WM_USER + 634;

   var
       OpenParamList:TStringList;
       

implementation
uses
  //Windows;
   Forms, Windows, Dialogs, SysUtils;
var
  Mutex : THandle;
  MutexName : array[0..255] of Char;
  UniqueMessageID: Integer;
  WProc: TFNWndProc = nil;
  MutexHandle: THandle = 0;
  l,i:integer;

function NewWndProc(Handle: HWND; Msg: Integer; WParam, LParam: Longint): Longint; stdcall;
var
  AtomName: array[0..MAX_PATH] of AnsiChar;
begin
  if Msg = UniqueMessageID then
  begin
    Application.Restore;
    Application.BringToFront;
    GlobalGetAtomName(WParam, @AtomName, SizeOf(AtomName));
    if (Application<>nil) and (Application.MainForm<>nil) and (Application.MainForm.Handle<>0)  then
          PostMessage(Application.MainForm.Handle, SM_OTHER_INSTANCE_EXECUTED, Integer(StrNew(PAnsiChar(@AtomName))), 0)
        else
        begin
          OpenParamList.Add(AtomName);
        end;
    GlobalDeleteAtom(WParam);
    Result := 0;
  end
  else
    Result := CallWindowProc(WProc, Handle, Msg, wParam, lParam);
end;

procedure ShowErrMsg;
const
  PROGRAM_ALREADY_RUN = 'Program already run!';
begin
  MessageBox(0,PROGRAM_ALREADY_RUN,MutexName, MB_ICONSTOP or MB_OK);
end;

procedure BroadcastFocusMessage;
{ This is called when there is already an instance running. }
var
  BSMRecipients: DWORD;
  l,i:integer;
begin
  { Don't flash main form }
  Application.ShowMainForm := False;
  { Post message and inform other instance to focus itself }
  BSMRecipients := BSM_APPLICATIONS;
  i:=1;
  l:=paramcount;
  if Paramcount<>0 then
  begin
   for i:=1 to l do
   begin
    if ParamStr(i)<>'-m' then
    BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
      @BSMRecipients, UniqueMessageID, GlobalAddAtom(PChar(ParamStr(i))), 0);
   end
  end
  else BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
         @BSMRecipients, UniqueMessageID, 0, 0);
end;

function StopLoading : boolean;
var
  L,I : integer;
begin
    L:=  ParamCount;
    Result:=false;
    for I := 1 to L do if(ParamStr(i)='-m') then exit;
  // В качестве уникального имени мьютекса используем полный путь к исполняемому файлу приложения
  MutexName:= 'Nanoeducator Software Mutex';
{  L :=GetModuleFileName(MainInstance,MutexName,SizeOf(MutexName));
  // В имени мьютекса нельзя использовать обратные слэши, поэтому
  // заменяем их на прямые
  for I := 0 to L - 1 do
    if MutexName[I] = '\' then
    begin
      MutexName[I] := '/';
    end;   }

  UniqueMessageID := RegisterWindowMessage(MutexName);

  Mutex := CreateMutex(nil,false,MutexName);

  Result := (Mutex = 0) or // Если мьютекс не удалось создать
  (GetLastError = ERROR_ALREADY_EXISTS); // Если мьютекс уже существует
end;



initialization


  if StopLoading then
  begin
      BroadcastFocusMessage;
    // Так как никаких инициализаций еще не производилось, то
    // спокойно используем для завершения программы Halt -
    // finalization все равно выполнится
    halt;
  end
  else
  begin
   OpenParamList:=TStringList.Create;
   L:=  ParamCount;
   for I := 1 to L do
   begin
    if ParamStr(i)<>'-m' then   OpenParamList.add(ParamStr(i));
   end;
    WProc := TFNWndProc(SetWindowLong(Application.Handle, GWL_WNDPROC, Longint(@NewWndProc)));
  end;

 finalization

  if WProc<>nil then  SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(WProc));
  if Mutex <> 0 then  CloseHandle(Mutex);
end.

