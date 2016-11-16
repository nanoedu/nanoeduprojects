unit FrControllerTurnOn;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, siComp;

type
  TFormControllerTurnOn = class(TForm)
    BitBtnDrivers: TBitBtn;
    BitBtnCancel: TBitBtn;
    Timer: TTimer;
    Panelmain: TPanel;
    GroupBox: TGroupBox;
    Label2: TLabel;
    BitBtnNext: TBitBtn;
    Bevel: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    siLang1: TsiLang;
    siLangDispatcher1: TsiLangDispatcher;
    procedure UpdateStrings;
    procedure siLang1ChangeLanguage(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnDriversClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnNextClick(Sender: TObject);
  private
    NextPressCnt:integer;
    function ExecAndWaitDrivers(const FileName, Params: ShortString;
                                               const winname:string; const WinState: Word): boolean;
  public
    { Public declarations }
  end;
var
  FormControllerTurnOn: TFormControllerTurnOn;

implementation

{$R *.dfm}

uses CSPMVar, SIOCSPM, GlobalVar,MLPC_API2Lib_TLB;
const
	strLabel1Step0: string = ''; (* 1. Turn On Controller and wait several seconds *)
       strLabel3Step0='';
	strlabel1step1: string = ''; (* 2. Check USB connection! *)
	strlabel3step1: string = ''; (* Change USB port, if nessesary. *)
	strlabel1step2: string = ''; (* 3. Drivers Installation! Wait ! *)
	strlabel1step2noadmin: string = ''; (* Probably drivers are not installed. Ask the administrator to install drivers *)
  strlabel1step21=' ';
	strlabel1step3: string = ''; (* Probably, Controller is Failed. *)

procedure TFormControllerTurnOn.TimerTimer(Sender: TObject);
var HR:HResult;
begin
      Timer.Enabled:=False;
    if flgDetectDev then         //not
     begin
//           NanoeduDevice:=CoMLabDevice.Create;
           HR:=NanoeduDevice.Connect('');
          if not FAILED(HR)  then
          begin
             flgDetectDev:=true;
             ModalResult:=mrOK;
             exit;
          end
     end;
   Timer.Enabled:=True;
end;

procedure TFormControllerTurnOn.UpdateStrings;
begin
  strlabel1step2noadmin := siLang1.GetTextOrDefault('strstrlabel1step2noadmin');
  strlabel1step3        := siLang1.GetTextOrDefault('strstrlabel1step3');
  strlabel1step2        := siLang1.GetTextOrDefault('strstrlabel1step2');
  strlabel3step1        := siLang1.GetTextOrDefault('strstrlabel3step1');
  strlabel1step1        := siLang1.GetTextOrDefault('strstrlabel1step1');
  strLabel1Step0        := siLang1.GetTextOrDefault('strstrLabel1Step0');

end;

procedure TFormControllerTurnOn.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Timer.Enabled:=False;
    action:=caFree;
    FormControllerTurnOn:=nil;
end;

procedure TFormControllerTurnOn.BitBtnCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

procedure TFormControllerTurnOn.BitBtnDriversClick(Sender: TObject);
begin
 //    MessageDlg('Turn on Controller!!', mtInformation,[mbOk],0);
     ExecAndWaitDrivers(Pchar(ExeFilePath)+'\DriverSetUp\dsetup.exe','','',SW_showNORMAL)
end;


(*function TFormControllerTurnOn.ExecAndWaitDrivers(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
var StartInfo: TStartupInfo;
     ProcInfo: TProcessInformation;
      CmdLine: ShortString;
            H: hWnd;
            R:TRECT;
begin { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
   CmdLine := '"' + Filename + '" ' + Params;
   FillChar(StartInfo, SizeOf(StartInfo), #0);
   with StartInfo do
    begin //cb := SizeOf(SUInfo);
     dwFlags := STARTF_USESHOWWINDOW;
     wShowWindow := WinState;
    end;
   Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
     { Ожидаем завершения приложения }
end;
*)

procedure TFormControllerTurnOn.FormCreate(Sender: TObject);
begin
  UpdateStrings;
   if  sLanguage='ENG' then  siLang1.ActiveLanguage:=1
                       else  siLang1.ActiveLanguage:=2;
   Updatestrings;
   NextPressCnt:=0;
   width:=500;
   height:=150;
   Label3.Visible:=False;
   Bevel.Width:=GroupBox.ClientWidth-8;
   timer.enabled:=true;
//   label1.Caption:=strLabel1Step0;//='1. Turn On Controller and wait several seconds';
//   label3.Caption:=strLabel3Step0;
//   Bevel.Height:=25;
end;

procedure TFormControllerTurnOn.siLang1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TFormControllerTurnOn.BitBtnNextClick(Sender: TObject);
begin
   inc(NextPressCnt);
   Label3.Visible:=False;
      CASE  NextPressCnt OF
 1:   begin
       label1.Caption:= strlabel1step1;//'2. Check USB connection!';
       Label3.Visible:=True;
       Label3.Caption:=strlabel3step1;//'Change USB port, if nessesary.';
      end;
 2:  begin
      if flgAdmin then
      begin
       label1.Caption:=strlabel1step2;//'3. Drivers Installation! Wait !';
       label2.Visible:=False;
       BitBtnNext.Visible:=False;
       Application.ProcessMessages;
       ExecAndWaitDrivers(Pchar(ExeFilePath)+'\DriverSetUp\dsetup.exe','','',SW_showNORMAL);
       label1.Caption:=strlabel1step21;//' ';
       label2.Visible:=True;
       BitBtnNext.Visible:=True;
      end
      else
      begin
       label1.Caption:=strlabel1step2noadmin;
      end;
     end;
 3:  begin
       label1.Caption:=strlabel1step3;//'Probably, Controller is Failed.';
       label2.Visible:=False;
       BitBtnNext.Visible:=False;
     end;
             end; //case
end;

function TFormControllerTurnOn.ExecAndWaitDrivers(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
var StartInfo: TStartupInfo;
     ProcInfo: TProcessInformation;
      CmdLine: ShortString;
            H: hWnd;
            R:TRECT;
begin { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
   CmdLine := '"' + Filename + '" ' + Params;
   FillChar(StartInfo, SizeOf(StartInfo), #0);
   with StartInfo do
    begin //cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
    end;
     Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
     { Ожидаем завершения приложения }
    if Result then
     begin
      WaitForSingleObject(ProcInfo.hProcess, INFINITE); { Free the Handles }
      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);
     end;
end;
end.


