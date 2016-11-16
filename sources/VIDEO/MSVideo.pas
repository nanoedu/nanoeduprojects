//120803
unit MSVideo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, VFW, VideoSettingsUnit;

type
  TFormatInfo = record
    Format: Pointer;
    FormatSize: Integer;
  end;

  TMSVideoForm = class(TForm)
    PlayBtn: TSpeedButton;
    SettingsBtn: TSpeedButton;
    RecordBtn: TSpeedButton;
    BmpBtn: TSpeedButton;
    StopBtn: TSpeedButton;
    PanelFrameVideo: TPanel;
    procedure PlayBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    procedure MSVideoInit;
    procedure InitParams;
    procedure CapWindowProc(var Msg: TMessage);
    procedure OverlaySwitch;
    function  SetRGB24Format: TFormatInfo;
  protected
    procedure SetParent(AParent: TWinControl); override;
  end;

var
  MSVideoForm: TMSVideoForm;

implementation

uses frFastLand;

//uses frFastLand;

//uses frFastLand, mMain;

{$R *.DFM}
const
  DefAviFileName = 'Noname.avi';
  DefBmpFileName = 'Noname.bmp';
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
if Settings.DriverCB.Items[Settings.DriverCB.ItemIndex] <> '' then
 begin
  if not PreviewFunc(hWndC, PlayBtn.Down) then
   begin
    PlayBtn.Down := not PlayBtn.Down;
    ShowMessage('Can not change mode - probably record running');
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
procedure TMSVideoForm.FormCreate(Sender: TObject);
begin
  if  assigned(FastLand) then bordericons:= bordericons-[biSystemMenu]-[biMaximize]-[biMinimize];
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
        ShowMessage('        BMP not properly saved !' + chr(13) + 'Try to choose uncompressed ' +
          'format');
  capSetVideoFormat(hWndC, OldFormat.Format, OldFormat.FormatSize);
  FreeMem(OldFormat.Format);
end;
//************************************************************************************************
procedure TMSVideoForm.SetParent(AParent: TWinControl);
begin
  DestroyWindow(hWndC);
  inherited;
  if AParent <> nil then
    MSVideoInit;
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
procedure TMSVideoForm.MSVideoInit;
var
  DrvName, DrvVer: string;
  VideoDrivers: TStrings;
begin
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
  Settings.DriverCBChange(Self);
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
  CapBitmap.Free;
  WindowProc := FOldWindowProc;
  MSVIDEOForm:=nil;
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
      ShowMessage('Can not change mode - probably record running');
     end;
   end
  else begin PlayBtn.Down:=false; PlayBtnClick(Sender);end;
end;

procedure TMSVideoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
       Action:=caFree;
end;

end.
