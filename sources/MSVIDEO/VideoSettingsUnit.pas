unit VideoSettingsUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, VFW,IniFiles, siComp, siLngLnk;

type

  TOnDriverChange = procedure of object;

  TVideoSettings = class(TForm)
    SrcDlgBtn: TSpeedButton;
    FormatDlgBtn: TSpeedButton;
    DisplayDlgBtn: TSpeedButton;
    CompressBtn: TSpeedButton;
    OverlayBtn: TSpeedButton;
    FrameRateCB: TComboBox;
    FrameRateLbl: TLabel;
    siLangLinked1: TsiLangLinked;
    GroupBox1: TGroupBox;
    DriverCB: TComboBox;
    BitBtnSave: TBitBtn;
    BitBtnDef: TBitBtn;
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SrcDlgBtnClick(Sender: TObject);
    procedure FormatDlgBtnClick(Sender: TObject);
    procedure DisplayDlgBtnClick(Sender: TObject);
    procedure DriverCBChange(Sender: TObject);
    procedure CompressBtnClick(Sender: TObject);
    procedure OverlayBtnClick(Sender: TObject);
    procedure FrameRateCBChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure BitBtnDefClick(Sender: TObject);
  private
    FWndC: THandle;
//    UserIniFilesPath:string;
    UserdrvNametmp:string;
    UserdrvNamedef:string;
    FOnDriverChange: TOnDriverChange;
    FOnOverlayChange: TOnDriverChange;
    function  GetUserAplDataPath:string;
    procedure SaveDrvName(name:string);
  public
    UserVideoIniFile:string;
    UserIniFilesPath:string;
    function  ReadDrvName:string;
    property WndC: THandle write FWndC;
    property OnDriverChange:  TOnDriverChange write FOnDriverChange;
    property OnOverlayChange: TOnDriverChange write FOnOverlayChange;
    Constructor Create(AOwner:TComponent; configpath:string);
  end;

var flgresult:integer;

implementation

{$R *.DFM}
uses  MSVideo,ShlObj;
const
	str1: string = ''; (* The Video Camera is not connected! Connect the Video Camera and restart! *)

  function GetSpecialPath(CSIDL: word): string;

var s:  string;
begin
  SetLength(s, MAX_PATH);
  if not SHGetSpecialFolderPath(0, PChar(s), CSIDL, true)
  then s := '';
  result := PChar(s);
end;
function TVideoSettings.GetUserAplDataPath:string;
var UserApplDataPath,ProgramName,UserNanoeduApplDataPath:string;
begin
   ProgramName:='Nanotutor';
   UserApplDataPath:= GetSpecialPath(CSIDL_APPDATA);
   UserNanoeduApplDataPath:=UserApplDataPath+'\'+ProgramName+'\';
   result:=UserNanoeduApplDataPath;
end;
procedure TVideoSettings.SrcDlgBtnClick(Sender: TObject);
begin
  capDlgVideoSource(FWndC);
end;

procedure TVideoSettings.UpdateStrings;
begin
  str1 := siLangLinked1.GetTextOrDefault('strstr1');

end;

procedure TVideoSettings.FormatDlgBtnClick(Sender: TObject);
var
  Status: TCapStatus;
begin
  capDlgVideoFormat(FWndC);
  capGetStatus(FWndC, @Status, sizeof(Status));
  if not (Status.fLiveWindow or Status.fOverlayWindow) then
  begin
    capGrabFrame(FWndC);
    capGrabFrame(FWndC);
  end;
end;

procedure TVideoSettings.FormCreate(Sender: TObject);
begin
(*    if sLanguage='RUS' then
      begin
       siLangLinked1.ActiveLanguage:=2;
       end
   else
    begin
       siLangLinked1.ActiveLanguage:=1;
    end;
    *)

end;

constructor TVideoSettings.Create(AOwner:TComponent; configpath:string) ;
begin
 inherited Create(AOwner);
   siLangLinked1.ActiveLanguage:=Lang;
  UpdateStrings;
  userdrvnamedef:='Microsoft WDM Image Capture';
  //UserIniFilesPath:=GetUserAplDataPath;
  UserVideoIniFile:=configpath{UserIniFilesPath}+'spmvideo.ini' ;
  if FileExists(UserVideoIniFile) then
  begin
   userdrvname:=ReadDrvName;
  end
  else userdrvname:='Microsoft WDM Image Capture';
end;
procedure TVideoSettings.FormDestroy(Sender: TObject);
begin
 capDriverDisconnect(FWndC);
end;

procedure TVideoSettings.DisplayDlgBtnClick(Sender: TObject);
begin
  capDlgVideoDisplay(FWndC);
end;

procedure TVideoSettings.DriverCBChange(Sender: TObject);
begin
  flgresult:=0;
  capDriverDisconnect(FWndC);
  if not capDriverConnect(FWndC, DriverCB.ItemIndex) then
  begin
    DriverCB.Items[DriverCB.ItemIndex] := '';
    userdrvNametmp:=DriverCB.Items[DriverCB.ItemIndex];
    if siLangLinked1.MessageDlg(str1{'The Video Camera is not connected! Connect the Video Camera and restart!'},mtConfirmation,[mbYes, mbNo],0)<>mrYes
    then  flgresult:=2;
    exit ;
//    flgresult:=1;
  end;
   userdrvName:=DriverCB.Items[DriverCB.ItemIndex];
  if Assigned(FOnDriverChange) then    FOnDriverChange;
  FrameRateCB.Enabled := not OverlayBtn.Down;
end;

procedure TVideoSettings.BitBtnSaveClick(Sender: TObject);
begin
userdrvName:=DriverCB.Items[DriverCB.ItemIndex];
if userdrvName<>'' then  SaveDrvName(userdrvName);
end;

procedure TVideoSettings.BitBtnDefClick(Sender: TObject);
var i:integer;
begin
 userdrvname:='Microsoft WDM Image Capture';
  for  i:=0 to DriverCB.items.Count-1 do
  begin
   if Pos(userdrvname,DriverCB.Items[i])>0
        then
        begin
           DriverCB.ItemIndex:=i;
        end;
  end;
 end;

procedure TVideoSettings.CompressBtnClick(Sender: TObject);
begin
  capDlgVideoCompression(FWndC);
end;

procedure TVideoSettings.OverlayBtnClick(Sender: TObject);
begin
  if Assigned(FOnOverlayChange) then     FOnOverlayChange;
  FrameRateCB.Enabled := not OverlayBtn.Down;
  if FrameRateCB.Enabled then  FrameRateCBChange(Self);
end;

procedure TVideoSettings.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TVideoSettings.FrameRateCBChange(Sender: TObject);
begin
  capPreviewRate(FWndC, trunc(1000/StrToInt(FrameRateCB.Text)));
end;
 function  TVideoSettings.ReadDrvName:string;
var flini:TiniFile;
 begin
 result:='';
if fileexists(UserVideoIniFile) then
 begin
     flini:=TIniFile.Create(UserVideoIniFile);
 try
    with flini do
          result:=(ReadString('Video','Video driver', userdrvnamedef));
  finally
     flini.Free;
   end;
 end
 else userdrvnamedef:='';
end;
procedure TVideoSettings.SaveDrvName(name:string);
var flini:TiniFile;
 begin
     flini:=TIniFile.Create(UserVideoIniFile);
 try
    with flini do
         WriteString('Video','Video driver', userdrvname);
  finally
     flini.Free;
   end;
end;
end.

