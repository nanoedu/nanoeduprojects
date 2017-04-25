
unit MSVideoDEMO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls,  siComp, ComCtrls,
  ImgList, ToolWin,
  Opencv_core,
  opencv_highgui,
  opencv_imgproc,
  opencv_types,
  opencv_utils,
  opencv_video;

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
    Image1: TImage;
    procedure UpdateStrings;
    procedure siLang1ChangeLanguage(Sender: TObject);
    procedure PlayBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SettingBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    flgrun:boolean;
    flgrotate:boolean;
    hWndC:HWND;
    videofile:string;
    curframenmb:integer;
    framenmb:integer;
    AviFileName, BMPFileName : string;
    scalar:cvScalar;
    capture: pCVCapture;
    map_matrix:pCvMat;
    frame: pIplImage;
    framerot:pIplImage;
    key: integer;
    image:Tbitmap;
    count :integer;
    dst: pIplImage;
    pc:CvPoint2d32f;
    r:pCvMat;//pIplImage;

    function  MSVideoInit:byte;
    procedure InitParams;
  protected
  public
    FormHandle: THandle;
    MsgBack: Integer;
  Constructor Create(AOwner:TComponent; configpath:string);
  end;

var
  MSVideoForm: TMSVideoForm;
 // userdrvname:string;
 // lang:integer;// slanguage:string;

implementation


{$R *.DFM}
uses globalvar;
const
  DefApproachAviFileName = 'sem_spm.avi';
  DefRisingAviFileName   = 'Rising.avi';
	strm1: string = ''; (* stop before exit *)
	strm2: string = ''; (* approach file not exist   *)
	strm3: string = ''; (* Try to choose uncompressed format *)
	strm4: string = ''; (* Can not change mode - probably record running *)
var
  BMPFileExt:string='bmp';
  AVIFileExt:string='avi';

var
  CapBitmap: TBitmap;

//************************************************************************************************
//************************************************************************************************
procedure IplImage2Bitmap(iplImg: PIplImage; var bitmap:TBitmap);
VAR
  i, j: Integer;
  offset: longint;
  dataByte, RowIn: PByteArray;
  // channelsCount: Integer;
BEGIN
  TRY
    // assert((iplImg.Depth = 8) and (iplImg.NChannels = 3),
    // 'IplImage2Bitmap: Not a 24 bit color iplImage!');
    bitmap.Height := iplImg.Height;
    bitmap.Width := iplImg.Width;
    FOR j := 0 TO bitmap.Height - 1 DO
    BEGIN
      // origin BL = Bottom-Left
      if (iplImg.Origin = IPL_ORIGIN_BL) then
        RowIn := bitmap.Scanline[bitmap.Height - 1 - j]
      else
        RowIn := bitmap.Scanline[j];

      offset := longint(iplImg.ImageData) + iplImg.WidthStep * j;
      dataByte := PByteArray(offset);

      if (iplImg.ChannelSeq = 'BGR') then
      begin
        { direct copy of the iplImage row bytes to bitmap row }
        CopyMemory(RowIn, dataByte, iplImg.WidthStep);
      End
      else if (iplImg.ChannelSeq = 'GRAY') then
        FOR i := 0 TO bitmap.Width - 1 DO
        begin
          RowIn[3 * i] := dataByte[i];
          RowIn[3 * i + 1] := dataByte[i];
          RowIn[3 * i + 2] := dataByte[i];
        End
      else
        FOR i := 0 TO 3 * bitmap.Width - 1 DO
        begin
          RowIn[i] := dataByte[i + 2];
          RowIn[i + 1] := dataByte[i + 1];
          RowIn[i + 2] := dataByte[i];
        End;
    End;
  Except
  End
END; { IplImage2Bitmap }

procedure TMSVideoForm.PlayBtnClick(Sender: TObject);
begin
 stopbtn.down:=false;
 try
//    capture := cvCreateFileCapture(PAnsiChar(Videofile));
    flgrun:=true;
     count:=0;
//     Scalar:=cvScalarAll_(0);
 //    map_matrix:=cvCreateMat(2, 3, CV_32FC1);
    if Assigned(capture) then
    begin
      while flgrun do
      begin
        frame := cvQueryFrame(capture);
        if Assigned(frame) then
         begin
      (*    if count=0 then
          begin
           image:=Tbitmap.create;
           image.PixelFormat := pf24bit;
           count:=1;
           framerot:=cvCloneImage(frame);
          end;
          *)
          if flgrotate then
           begin
              pc.X:=round(frame.width/2.0);
              pc.Y:=round(frame.height/2.0);
             r:=cv2DRotationMatrix(pc, 90, 1.0,map_matrix);
             cvWarpAffine(frame, framerot, map_matrix,CV_INTER_LINEAR+CV_WARP_FILL_OUTLIERS,Scalar);//, src.size()); // what size I should use?
             IplImage2Bitmap(framerot,image);
            end
            else IplImage2Bitmap(frame,image);
           image1.Picture.Assign(image);
           application.ProcessMessages;
           Sleep(10);
           end
           else break;
         end;
    end
    else
    begin
     silang1.MessageDlg(strm2,mtWarning,[mbOk],0);
     flgrun:=false;
    end;
      flgrun:=false;
   stopbtn.down:=true;
   Playbtn.down:=false;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end;
procedure TMSVideoForm.SettingBtnClick(Sender: TObject);
begin

end;

//************************************************************************************************
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
end;begin
  inherited Create(AOwner);
  siLang1.ActiveLanguage:=Lang;
  UpdateStrings;
  Videofile :=configpath+DefApproachAVIFileName;
  PlayBtn.down:=false;
  flgrun:=false;
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
end;
procedure TMSVideoForm.HelpBtnClick(Sender: TObject);
begin

end;

//************************************************************************************************
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
end;
//************************************************************************************************
//************************************************************************************************
procedure TMSVideoForm.InitParams;
begin
end;
//************************************************************************************************
function TMSVideoForm.MSVideoInit:byte;
begin
  curframenmb:=0;
  capture := cvCreateFileCapture(PAnsiChar(Videofile));
  map_matrix:=cvCreateMat(2, 3, CV_32FC1);
  Scalar:=cvScalarAll_(0);
 if Assigned(capture) then
    begin
        frame := cvQueryFrame(capture);
        if Assigned(frame) then
         begin
           image:=Tbitmap.create;
           image.PixelFormat := pf24bit;
           count:=1;
           framerot:=cvCloneImage(frame);
          if flgrotate then
           begin
              pc.X:=round(frame.width/2.0);
              pc.Y:=round(frame.height/2.0);
             r:=cv2DRotationMatrix(pc, 90, 1.0,map_matrix);
             cvWarpAffine(frame, framerot, map_matrix,CV_INTER_LINEAR+CV_WARP_FILL_OUTLIERS,Scalar);//, src.size()); // what size I should use?
             IplImage2Bitmap(framerot,image);
            end
            else IplImage2Bitmap(frame,image);
           image1.Picture.Assign(image);
           application.ProcessMessages;
           Sleep(10);
         end
    end;
     result:=0;
end;
//************************************************************************************************
procedure TMSVideoForm.StopBtnClick(Sender: TObject);
begin
 flgrun:=not flgrun;
 if PlayBtn.Down then
  begin
    PlayBtn.Down := false;
   // PlayBtn.OnClick(Self);
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
procedure TMSVideoForm.FormDestroy(Sender: TObject);
begin
//  CapBitmap.Free;
  Application.Handle:=0;
  PostMessage (FormHandle, MsgBack, 0, 0);
   MSVideoForm:=nil;
end;
//************************************************************************************************
procedure TMSVideoForm.FormClose(Sender: TObject; var Action: TCloseAction);
var p2pcapture: P2PCvCapture;
begin
    flgrun:=false;
    sleep(1000);
//     p2pcapture:= ^capture;
 //  cvReleaseCapture(P2PCvCapture(capture));
//   FreeAndNil(CapBitmap);
   FreeAndNil(image);
   Action:=caFree;
   MSVideoForm:=nil;
end;



procedure TMSVideoForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if flgrun  then
 begin
   silang1.MessageDlg(strm1,mtWarning,[mbOk],0);
   canclose:=false;
 end
 else canclose:=true;
end;

end.

