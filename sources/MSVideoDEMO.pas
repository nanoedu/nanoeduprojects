
unit MSVideoDEMO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls,  siComp, ComCtrls,CSPMVar,
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

  TMSVideoFORMDemo = class(TForm)
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
    Timer1: TTimer;
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
    procedure Timer1Timer(Sender: TObject);
  private
    key: integer;

    lflgautoclose:boolean;
    lflgautostart:boolean;
    hWndC:HWND;
    scalar:cvScalar;
    capture: pCVCapture;
    map_matrix:pCvMat;
    frame: pIplImage;
    framerot:pIplImage;
    image:Tbitmap;
    dst: pIplImage;
    pc:CvPoint2d32f;
    r:pCvMat;//pIplImage;
   procedure InitParams;
 protected
 public
    lflgrotation:boolean;
    restartvideo:boolean;
    flgappr:boolean;
    flgclose:boolean;
    delayapr:integer;
    delayris:integer;
    nstep:integer;   // ����� ������� ������ ����������
    nstart:integer;
    nstop:integer;
    nstartapr:integer;
    nstopapr:integer;
    nstartris:integer;
    nstoprise:integer;
    nframe:integer;
    FormHandle: THandle;
   Constructor Create(AOwner:TComponent; filename:string; delay:integer; flgautostart:boolean;flgautoclose:boolean;flgrotation:boolean);
   procedure  StartVideoStream(filename:string;istart:integer; instep:integer);
   procedure  StartVideo;
   procedure  StopVideoStream;
   procedure  ThreadDone(var AMessage : TMessage); message WM_ThreadDoneMsg;
   function   MSVideoInit:byte;
  end;

var
  MSVideoFORMDemo: TMSVideoFORMDemo;
 // userdrvname:string;
 // lang:integer;// slanguage:string;

implementation


{$R *.DFM}
uses globalvar,ThreadVideoStream,frapproachnew;
const
  DefApproachAviFileName = 'sem_spm.avi';
  DefRisingAviFileName   = 'Rising.avi';
	strm1: string = ''; (* stop video before exit *)
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

procedure TMSVideoFORMDemo.ThreadDone(var AMessage: TMessage);
  begin
  if  (mDrawing=AMessage.WParam)then
  begin
    stopbtn.down:=true;
    Playbtn.down:=false;
    flgStopVideoStream:=true;
    if flgappr then
    begin
      nstartapr:=nstop;
      nstartris:=nframe-nstop+1;
    end
    else
    begin
     nstartris:=nstop;
     nstartapr:=nframe-nstop+1;
    end;
   if  restartvideo then
   begin
    if (flgCurrentUserLevel=DEMO) then
    begin
     if (ApproachParams.ZStepsNumb>0) then
     begin
      ApproachSimulationVideo:=ExeFilePath+'Data\VideoCameraSimulation\landing.avi';
      VideoFile:=ApproachSimulationVideo ;
      flgappr:=true;
      StartVideoStream(VideoFile,nstartapr,20);
     end
     else
     begin
       ApproachSimulationVideo:=ExeFilePath+'Data\VideoCameraSimulation\rising.avi';
       VideoFile:=ApproachSimulationVideo ;
       flgappr:=false;
       StartVideoStream(VideoFile,nstartris,20);
     end;
    end;
   end;
   if    lflgautoclose  or flgclose then
   begin
    close;
   end;
  end;//THREAD DRAW
 if mScanning=AMessage.WParam then
 begin
 end;

end;
procedure TMSVideoFORMDemo.Timer1Timer(Sender: TObject);
begin
 timer1.enabled:=false;
 if lflgautostart then StartVideo;//PlayBtnClick(self);
end;

procedure  TMSVideoFORMDemo.StartVideo;//(filename:string);
begin
   if not assigned(VideoStreamThread) or (not VideoStreamThreadActive) then // make sure its not already running
       begin
         flgStopVideoStream:=false;
         stopbtn.down:=false;
         PlayBtn.Down := true;
         nstart:=1;
         nstep:=1;
         VideoStreamThread:= TThreadVideoStream.Create;
       end ;
end;
procedure  TMSVideoFORMDemo.StartVideoStream(filename:string;istart:integer; instep:integer);
begin
      if not assigned(VideoStreamThread) or (not VideoStreamThreadActive) then // make sure its not already running
       begin
         flgStopVideoStream:=false;
         stopbtn.down:=false;
         PlayBtn.Down := true;
         nstart:=istart; //1
         nstep:=instep;
         nframe:=479;
         VideoStreamThread:= TThreadVideoStream.Create;
       end ;
end;
procedure  TMSVideoFORMDemo.StopVideoStream;
begin
 flgStopVideoStream:=true;
 if PlayBtn.Down then
  begin
    PlayBtn.Down := false;
   // PlayBtn.OnClick(Self);
  end;
   stopbtn.down:=true;
end;
procedure TMSVideoFORMDemo.PlayBtnClick(Sender: TObject);
begin
 (*     if not assigned(VideoStreamThread) or (not VideoStreamThreadActive) then // make sure its not already running
       begin
         flgStopVideoStream:=false;
         stopbtn.down:=false;
         PlayBtn.Down := true;
         nstart:=1;
         VideoStreamThread:= TThreadVideoStream.Create;
       end ;
       *)
end;

procedure TMSVideoFORMDemo.SettingBtnClick(Sender: TObject);
begin

end;

//************************************************************************************************
constructor TMSVideoFORMDemo.Create(AOwner:TComponent; filename:string;delay:integer;flgautostart:boolean;flgautoclose:boolean;flgrotation:boolean);
begin
  inherited Create(AOwner);
  siLang1.ActiveLanguage:=Lang;
  UpdateStrings;
  delayapr:=delay;
  Videofile :=filename;
  PlayBtn.down:=false;
  lflgautoclose:=flgautoclose;
  lflgautostart:= flgautostart;
  lflgrotation:=flgrotation;
  MSVideoInit;
  flgclose:=false;
  if flgautostart then
  begin
   Timer1.Interval:=1000;
   Timer1.Enabled:=true;
  end;
 end;
//************************************************************************************************
procedure TMSVideoFORMDemo.FormResize(Sender: TObject);
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
procedure TMSVideoFORMDemo.HelpBtnClick(Sender: TObject);
begin

end;

//************************************************************************************************
procedure TMSVideoFORMDemo.siLang1ChangeLanguage(Sender: TObject);
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
procedure TMSVideoFORMDemo.InitParams;
begin
end;
//************************************************************************************************
function TMSVideoFORMDemo.MSVideoInit:byte;
begin
  nstart:=1;
  nstartapr:=1;
  nstartris:=nframe;//??????? =1
  nstop:=1;
  flgStopVideoStream:=true;
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
           framerot:=cvCloneImage(frame);
          if lflgrotation then
           begin
              pc.X:=round(frame.width/2.0);
              pc.Y:=round(frame.height/2.0);
             r:=cv2DRotationMatrix(pc, 180, 1.0,map_matrix);
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
procedure TMSVideoFORMDemo.StopBtnClick(Sender: TObject);
begin
 StopVideoStream;
end;
procedure TMSVideoFORMDemo.UpdateStrings;
begin
  strm4 := siLang1.GetTextOrDefault('strstrm4');
  strm3 := siLang1.GetTextOrDefault('strstrm3');
  strm2 := siLang1.GetTextOrDefault('strstrm2');
  strm1 := siLang1.GetTextOrDefault('strstrm1');
end;

//************************************************************************************************
procedure TMSVideoFORMDemo.FormDestroy(Sender: TObject);
begin
//  CapBitmap.Free;
  Application.Handle:=0;
//  PostMessage (FormHandle, MsgBack, 0, 0);
   MSVideoFormDemo:=nil;
end;
//************************************************************************************************
procedure TMSVideoFORMDemo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FreeAndNil(image);
   Action:=caFree;
   MSVideoFormDemo:=nil;
end;



procedure TMSVideoFORMDemo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if not flgStopVideoStream  then
 begin
   silang1.MessageDlg(strm1,mtWarning,[mbOk],0);
 //  flgStopVideoStream:=true;
 //  flgclose:=true;
 //  restartvideo :=false;
   canclose:=false;
 end
 else canclose:=true;
end;

end.

