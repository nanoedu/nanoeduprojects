unit ThreadVideoStream;

interface

uses
   Classes,windows,SysUtils,Graphics,MSVideoDEMO,
  Opencv_core,
  opencv_highgui,
  opencv_imgproc,
  opencv_types,
  opencv_utils,
  opencv_video;
type
  TThreadVideoStream = class(TThread)
  private
    { Private declarations }
    flgrotate:boolean;
    curframenmb:integer;
    count :integer;
    key: integer;
    framenmb:integer;
    hWndC:HWND;
    videofile:string;
    scalar:cvScalar;
    capture: pCVCapture;
    map_matrix:pCvMat;
    frame: pIplImage;
    framerot:pIplImage;
    image:Tbitmap;
    dst: pIplImage;
    pc:CvPoint2d32f;
    r:pCvMat;//pIplImage;
    function MSVideoInit:byte;
  protected
    procedure Execute; override;
 public
      nstep:integer;
      constructor Create;
      destructor Destroy; override;
  end;
var  VideoStreamThread:TThreadVideoStream;
     VideoStreamTHreadActive:boolean;
implementation
 uses CSPMvar;


procedure TThreadVideoStream.Execute;
begin
  { Place thread code here }
  while (not Terminated) and (not flgStopVideoStream)  do
   begin
//    capture := cvCreateFileCapture(PAnsiChar(Videofile));
     count:=1;
//     Scalar:=cvScalarAll_(0);
 //    map_matrix:=cvCreateMat(2, 3, CV_32FC1);
    if Assigned(capture) then
    begin
        frame := cvQueryFrame(capture);
        if Assigned(frame) then
        begin
         if count=nstep then
         begin
           if flgrotate then
           begin
              pc.X:=round(frame.width/2.0);
              pc.Y:=round(frame.height/2.0);
             r:=cv2DRotationMatrix(pc, 90, 1.0,map_matrix);
             cvWarpAffine(frame, framerot, map_matrix,CV_INTER_LINEAR+CV_WARP_FILL_OUTLIERS,Scalar);//, src.size()); // what size I should use?
             IplImage2Bitmap(framerot,image);
           end
           else IplImage2Bitmap(frame,image);
           MSVideoForm.image1.Picture.Assign(image);
           Sleep(10);
           count:=1;
         end
         else inc(count)
       end
       else break;
    end
    else break;
  end; {while execute}
   PostMessage(MsVideoForm.Handle,wm_ThreadDoneMsg,mScanning,0);
   if (not Terminated) then  Self.Terminate;
end;

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
constructor TThreadVideoStream.Create;
begin
  inherited Create(True);
    MSVideoInit;
    FreeOnTerminate:=true;
    Priority := TThreadPriority(tpNormal);
    Suspended := false;// Resume;
 end;

destructor TThreadVideoStream.Destroy;
begin
   ThreadFlg:=mDrawing;
   FreeAndNil(image);
   PostMessage(MSvideoForm.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;
function TThreadVideoStream.MSVideoInit:byte;
begin
  curframenmb:=0;
  nstep:=1;
  capture := cvCreateFileCapture(PAnsiChar(MSVideoForm.Videofile));
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
           MSVideoForm.image1.Picture.Assign(image);
         end
    end;
     result:=0;
end;
end.
