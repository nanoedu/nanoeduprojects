
unit MSVideo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, VFW, VideoSettingsUnit, siComp, ComCtrls,
  ImgList, ToolWin;

type
  TFormatInfo = record
    Format: Pointer;
    FormatSize: Integer;
  end;

  TMSVideoForm = class(TForm)
    siLang1: TsiLang;
    siLangDispatcher1: TsiLangDispatcher;
    ToolBar: TToolBar;
    ImageList: TImageList;
    PlayBtn: TToolButton;
    StopBtn: TToolButton;
    RecordBtn: TToolButton;
    CaptureBtn: TToolButton;
    SettingBtn: TToolButton;
    HelpBtn: TToolButton;
    Panel1: TPanel;
    PanelFrameVideo: TPanel;
    procedure UpdateStrings;
    procedure siLang1ChangeLanguage(Sender: TObject);
    procedure PlayBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SettingsBtnClick(Sender: TObject);
    procedure RecordBtnClick(Sender: TObject);
    procedure BmpBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    AviFileName, BMPFileName : string;
    hWndC:HWND;
    PreviewFunc : function(hwnd: HWND; f: BOOL): BOOL;
    FOldWindowProc: TWNDMethod;
    Settings: TVideoSettings;
    DrvCaps: TCapDriverCaps;

//    Drawing:Boolean;
    function  MSVideoInit:byte;
    procedure InitParams;
    procedure CapWindowProc(var Msg: TMessage);
    procedure OverlaySwitch;
    function  SetRGB24Format: TFormatInfo;
  protected
    procedure SetParent(AParent: TWinControl); override;
  public
    FormHandle: THandle;
    MsgBack: Integer;
  Constructor Create(AOwner:TComponent; configpath:string);
  end;

var
  MSVideoForm: TMSVideoForm;
  userdrvname:string;
  lang:integer;// slanguage:string;

implementation

//uses frFastLand;

//uses frFastLand;

//uses frFastLand, mMain;

{$R *.DFM}
const
  DefAviFileName = 'Noname.avi';
  DefBmpFileName = 'Noname.bmp';
	strm1: string = ''; (* Can not change mode - probably record running *)
	strm2: string = ''; (*         BMP not properly saved ! *)
	strm3: string = ''; (* Try to choose uncompressed format *)
	strm4: string = ''; (* Can not change mode - probably record running *)
var
  BMPFileExt:string='bmp';
  AVIFileExt:string='avi';

var
  Status: TCapStatus;
  CapBitmap: TBitmap;
//************************************************************************************************
function CallBackFrame(hWind: HWND; lpVHdr: PVideoHdr): DWORD; stdcall;
var
  Hdd:THandle;
  Info: BITMAPINFOHEADER;
begin
  Result := 0;
  ZeroMemory(@Info, sizeof(Info));
  with Info do
  begin
    biSize := sizeof(Info);
    biWidth := Status.uiImageWidth;
    biHeight := Status.uiImageHeight;
    biPlanes := 1;
    biBitCount := 24;
    biCompression := BI_RGB;
  end;
  with CapBitmap do
  begin
    Width := Info.biWidth;
    Height := Info.biHeight;
    hdd:= DrawDibOpen;
    DrawDibDraw(Hdd, Canvas.Handle, 0, 0, Width, Height, @Info, lpVHdr.lpData, 0, 0, Width, Height,
      0);
    DrawDibClose(hdd);
  end;
end;
//************************************************************************************************
procedure TMSVideoForm.CapWindowProc(var Msg: TMessage);
var
  DC: HDC;
begin
  FOldWindowProc(Msg);
  if (Msg.Msg = WM_PAINT) and not PlayBtn.Down then
  begin
    DC := GetDC(hWndC);
    with CapBitmap do
      StretchBlt(DC, 0, 0, panelframevideo.ClientWidth,panelframevideo.ClientHeight, Canvas.Handle, 0,
        0, Width, Height, SRCCOPY);
    ReleaseDC(hWndC, DC);
  end;
  if (Msg.Msg = WM_MOVE) and PlayBtn.Down then
    SendMessage(hWndC, WM_PAINT, 0, 0);
end;
//************************************************************************************************
procedure TMSVideoForm.PlayBtnClick(Sender: TObject);
var
  DC: HDC;
  OldFormat: TFormatInfo;
begin
stopbtn.down:=false;
if Settings.DriverCB.Items[Settings.DriverCB.ItemIndex] <> '' then
 begin
  if not PreviewFunc(hWndC, PlayBtn.Down) then
   begin
    PlayBtn.Down := not PlayBtn.Down;
    siLang1.ShowMessage(strm1{'Can not change mode - probably record running'});
   end;
  end;
  if not PlayBtn.Down then
   begin
    OldFormat := SetRGB24Format;
    capSetCallbackOnFrame(hWndC, CallBackFrame);
    capGrabFrame(hWndC);
    capSetCallbackOnFrame(hWndC, nil);
    capSetVideoFormat(hWndC, OldFormat.Format, OldFormat.FormatSize);
    FreeMem(OldFormat.Format);
    DC := GetDC(hWndC);
    with CapBitmap do
      StretchBlt(DC, 0, 0, panelframevideo.ClientWidth,panelframevideo.ClientHeight, Canvas.Handle, 0,
        0, Width, Height, SRCCOPY);
    ReleaseDC(hWndC, DC);
   end;
  //  Main.MainStatusBarFill;
end;
//************************************************************************************************
(*procedure TMSVideoForm.FormCreate(Sender: TObject);
begin
//  if  assigned(FastLand) then bordericons:= bordericons-[biSystemMenu]-[biMaximize]-[biMinimize];
  panelframevideo.top:=40;
  panelframevideo.left:=0;
  panelframevideo.width:=ClientWidth;
  panelframevideo.Height:=ClientHeight-40;
  AVIFileName := DefAVIFileName;
  BmpFileName := DefBMPFileName;
  FOldWindowProc := WindowProc;
  WindowProc := CapWindowProc;
  CapBitmap := TBitmap.Create;
  Settings := TVideoSettings.Create(Self);
  with Settings do
  begin
    OnDriverChange := InitParams;
    OnOverlayChange := OverlaySwitch;
    FrameRateCB.ItemIndex := 3;
    DriverCB.ItemIndex := 0;
  end;
 MSVideoInit;
end;
*)
constructor TMSVideoForm.Create(AOwner:TComponent; configpath:string);
var
deflang,str:string;
function WhichLanguage:string;
var
  ID: LangID;
  Language: array [0..100] of char;
begin
  ID := GetSystemDefaultLangID;
  VerLanguageName(ID, Language, 100);
  Result := string(Language);
end;
function ShowDllPath:string;
var
  TheFileName : array[0..MAX_PATH] of char;
  str:string;
begin
  FillChar(TheFileName, sizeof(TheFileName), #0);
  GetModuleFileName(hInstance, TheFileName, sizeof(TheFileName));
  result:=string( TheFileName);
  //  MessageBox(0, TheFileName, 'The DLL file name is:', mb_ok);
end;begin
  inherited Create(AOwner);
(*      deflang:=WhichLanguage;
 if  (deflang='Russian')  or (deflang='Русский') then   sLanguage:='RUS';
    if sLanguage='RUS' then
      begin
       siLang1.ActiveLanguage:=2;
       end
   else
    begin
       siLang1.ActiveLanguage:=1;
    end;
*)
     siLang1.ActiveLanguage:=Lang;
     UpdateStrings;
(*  panelframevideo.top:=0;
  panelframevideo.left:=0;
  panelframevideo.width:=ClientWidth;
  panelframevideo.Height:=ClientHeight-40;
 *)
  AVIFileName := DefAVIFileName;
  BmpFileName := DefBMPFileName;
  FOldWindowProc := WindowProc;
  WindowProc := CapWindowProc;
  CapBitmap := TBitmap.Create;
  Settings := TVideoSettings.Create(Self,configpath);
//  Settings.UserIniFilesPath:=configpath;
    with Settings do
  begin
    OnDriverChange := InitParams;
    OnOverlayChange := OverlaySwitch;
    FrameRateCB.ItemIndex := 3;
    DriverCB.ItemIndex := 0;
  end;
 PlayBtn.down:=true;
 MSVideoInit;
// if flgresult>0 then close;
end;
//************************************************************************************************
procedure TMSVideoForm.FormResize(Sender: TObject);
var
  DC: HDC;
begin
  panelframevideo.top:=40;
  panelframevideo.left:=0;
  panelframevideo.width:=ClientWidth;
  panelframevideo.Height:=ClientHeight-40;
  SetWindowPos(hWndC, HWND_TOPMOST	, 0, 0, panelframevideo.ClientWidth,panelframevideo.ClientHeight,
    SWP_NOZORDER + SWP_NOACTIVATE);
 (* if not PlayBtn.Down then
  begin
    DC := GetDC(hWndC);
    with CapBitmap do
      StretchBlt(DC, 0, 0, panelframevideo.ClientWidth,panelframevideo.ClientHeight, Canvas.Handle, 0,
        0, Width, Height, SRCCOPY);
    ReleaseDC(hWndC, DC);
  end;
  *)
end;
//************************************************************************************************
procedure TMSVideoForm.SettingsBtnClick(Sender: TObject);
begin
  Settings.Show;
end;
procedure TMSVideoForm.siLang1ChangeLanguage(Sender: TObject);
begin

end;

//************************************************************************************************
function SaveFileNameEx(var aFileName,aExtension:string;aFilter:string): boolean;overload;
var Dialog1:TSaveDialog;
begin
  Dialog1:=TSaveDialog.Create(Nil);
  Dialog1.Filter := aFilter;
  Dialog1.filename:=aFileName;
  Dialog1.DefaultExt:=aExtension;
  Result:=Dialog1.Execute;
  aFileName:=Dialog1.FileName;
  aExtension:=ExtractFileExt(aFileName);
  aExtension:=UpperCase(Copy(aExtension,2,Length(aExtension)-1));
  Dialog1.Free;
//  UpdateStrings;
end;
//************************************************************************************************
procedure TMSVideoForm.RecordBtnClick(Sender: TObject);
begin
 if RecordBtn.Down then
  begin
    if SaveFileNameEx(AVIFileName,AVIFileExt, '*.avi') then
    begin
      capFileSetCaptureFile(hWndC, PChar(AVIFileName));
      capCaptureSequence(hWndC)
    end;
  end
 else
  begin
    capCaptureStop(hWndC);
    repeat
      capGetStatus(hWndC, @Status, sizeof(Status));
    until Status.fCapturingNow = False;
    if PlayBtn.Down then
      PreviewFunc(hWndC, True);
  end;
end;
//************************************************************************************************
procedure TMSVideoForm.BmpBtnClick(Sender: TObject);
var
  OldFormat: TFormatInfo;
begin
  OldFormat := SetRGB24Format;
  if SaveFileNameEx(BMPFileName, BMPFileExt, 'Windows Bitmap File *.bmp|*.BMP') then
    if not PlayBtn.Down then
      CapBitmap.SaveToFile(BmpFileName)
    else
      if not capFileSaveDIB(hWndC,PChar(BmpFileName)) then
        siLang1.ShowMessage(strm2{'        BMP not properly saved !'} + chr(13) +strm3{ 'Try to choose uncompressed format'});
  capSetVideoFormat(hWndC, OldFormat.Format, OldFormat.FormatSize);
  FreeMem(OldFormat.Format);
end;
//************************************************************************************************
procedure TMSVideoForm.SetParent(AParent: TWinControl);
begin
  DestroyWindow(hWndC);
  inherited;
  if AParent <> nil then
 if   MSVideoInit=2 then ;
end;
//************************************************************************************************
{function MyError(hWnd: HWND; nID: int; lpsz: LPCSTR): DWORD; stdcall;
begin
  Result := 0;
  ShowMessage('Error!!!');
end;
}
//************************************************************************************************
procedure TMSVideoForm.InitParams;
var
  CapParams : TCaptureParms;
begin
  capCaptureGetSetup(hWndC, @CapParams, sizeof(CapParams));
  CapParams.fYield := True;
  CapParams.fCaptureAudio := False;
  CapParams.fAbortLeftMouse := False;
  CapParams.fAbortRightMouse := False;
  capCaptureSetSetup(hWndC, @CapParams, sizeof(CapParams));
  capDriverGetCaps(hWndC, @DrvCaps, sizeof(DrvCaps));
  with Settings do
  begin
    SrcDlgBtn.Enabled := DrvCaps.fHasDlgVideoSource;
    FormatDlgBtn.Enabled := DrvCaps.fHasDlgVideoFormat;
    DisplayDlgBtn.Enabled := DrvCaps.fHasDlgVideoDisplay;
    CompressBtn.Enabled := DriverCB.Items[DriverCB.ItemIndex] <> '';
    OverlayBtn.Enabled := DrvCaps.fHasOverlay;
    OverlayBtn.Down := DrvCaps.fHasOverlay;
  end;
//  DrvCaps.fHasOverlay := False;
  if DrvCaps.fHasOverlay then
    PreviewFunc := capOverlay
  else
  begin
    capPreviewRate(hWndC, trunc(1000/StrToInt(Settings.FrameRateCB.Text)));
    PreviewFunc := capPreview;
  end;
  capPreviewScale(hWndC, True);
  capFileSetCaptureFile(hWndC, PChar(AVIFileName));
  capGetStatus(hWndC, @Status, sizeof(Status));
  capSetCallbackOnFrame(hWndC, CallBackFrame);
  capGrabFrame(hWndC);
  capSetCallbackOnFrame(hWndC, nil);
//  capSetCallbackOnError(hWndC, MyError);
end;
//************************************************************************************************
function TMSVideoForm.MSVideoInit:byte;
var
  i:integer;
  DrvName, DrvVer: string;
  VideoDrivers: TStrings;
begin
  result:=0;
  SetLength(DrvName, 80);
  SetLength(DrvVer, 80);
  VideoDrivers := TStringList.Create;
  while capGetDriverDescription(VideoDrivers.Count, PChar(DrvName), 80, PChar(DrvVer), 80) do
    VideoDrivers.Add(DrvName + ' ' + DrvVer);
  hWndC := capCreateCaptureWindow('My Own Capture Window',WS_CHILD+WS_VISIBLE,0,0,panelframevideo.ClientWidth, panelframevideo.ClientHeight,PanelFrameVideo.Handle,0);
  Settings.WndC := hWndC;
  if VideoDrivers.Count = 0 then exit;
  Settings.DriverCB.Items := VideoDrivers;
  Settings.DriverCB.ItemIndex := 0;
  { TODO : 140905 }
//
// if  VideoDrivers.Count>0 then Settings. DriverCB.Items[Settings.DriverCB.ItemIndex]:='Microsoft WDM Image Capture (Win32)';
// if Settings.DriverCB.Items[0]=' ' then
  for  i:=0 to VideoDrivers.Count-1 do
  begin
   if Pos(userdrvname,Settings.DriverCB.Items[i])>0
        then
        begin
            Settings.DriverCB.ItemIndex:=i;
        end;
  end;
//
 Settings.DriverCBChange(Self);
 VideoDrivers.Clear;
 FreeAndNil(VideoDrivers);
 SetLength(DrvName, 0);
 SetLength(DrvVer, 0);
 result:=flgresult;
end;
//************************************************************************************************
procedure TMSVideoForm.StopBtnClick(Sender: TObject);
begin

  if RecordBtn.Down then
  begin
    RecordBtn.Down := false;
    RecordBtn.OnClick(Self);
  end;
  if PlayBtn.Down then
  begin
    PlayBtn.Down := false;
    PlayBtn.OnClick(Self);
  end;
   stopbtn.down:=true;
end;
procedure TMSVideoForm.UpdateStrings;
begin
  strm4 := siLang1.GetTextOrDefault('strstrm4');
  strm3 := siLang1.GetTextOrDefault('strstrm3');
  strm2 := siLang1.GetTextOrDefault('strstrm2');
  strm1 := siLang1.GetTextOrDefault('strstrm1');
end;

//************************************************************************************************
procedure TMSVideoForm.OverlaySwitch;
begin
  if Settings.OverlayBtn.Down then
    PreviewFunc := capOverlay
  else
  begin
    capPreviewRate(hWndC, 66);
    PreviewFunc := capPreview;
  end;
  if PlayBtn.Down then
    PreviewFunc(hWndC, True);
end;
//************************************************************************************************
procedure TMSVideoForm.FormDestroy(Sender: TObject);
begin
//  CapBitmap.Free;
  WindowProc := FOldWindowProc;
  Application.Handle:=0;
  PostMessage (FormHandle, MsgBack, 0, 0);
   MSVideoForm:=nil;
end;
//************************************************************************************************
function TMSVideoForm.SetRGB24Format: TFormatInfo;
var
  RGB24Format: BITMAPINFO;
begin
  capGetStatus(hWndC, @Status,sizeof(Status));
  ZeroMemory(@RGB24Format, sizeof(RGB24Format));
  with RGB24Format.bmiHeader do
  begin
    biSize := sizeof(RGB24Format.bmiHeader);
    biWidth := Status.uiImageWidth;
    biHeight := Status.uiImageHeight;
    biPlanes := 1;
    biBitCount := 24;
    biCompression := BI_RGB;
  end;
  Result.FormatSize := capGetVideoFormatSize(hWndC);
  GetMem(Result.Format, Result.FormatSize);
  capGetVideoFormat(hWndC, Result.Format, Result.FormatSize);
  capSetVideoFormat(hWndC, @RGB24Format, sizeof(RGB24Format));
end;
//************************************************************************************************
procedure TMSVideoForm.FormShow(Sender: TObject);
begin
if Settings.DriverCB.Items[Settings.DriverCB.ItemIndex] <> '' then
   begin
    if not PreviewFunc(hWndC, PlayBtn.Down) then
     begin
      siLang1.ShowMessage(strm4{'Can not change mode - probably record running'});
     end;
   end
  else begin PlayBtn.Down:=false; PlayBtnClick(Sender);end;
end;

procedure TMSVideoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FreeAndNil(CapBitmap);
   FreeAndNil(Settings);
   Action:=caFree;
end;



end.

