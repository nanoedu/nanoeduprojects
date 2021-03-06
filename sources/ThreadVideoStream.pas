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
    flgrotation:boolean;
    i:integer;
    curframenmb:integer;
    count :integer;
    key: integer;
    framenmb:integer;
    hWndC:HWND;
 //   videofile:string;
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
    procedure  VideoOutPut;
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
var i:integer;
  ifirst:integer;
begin
  i:=1;
  ifirst:=1;
  { Place thread code here }
  curframenmb:=MSVideoFormDemo.nstart;
  count:=1;
  while (not Terminated) and (not flgStopVideoStream)  do
   begin
    if ifirst=1 then
    begin
     capture := cvCreateFileCapture(PAnsiChar(Videofile));
     map_matrix:=cvCreateMat(2, 3, CV_32FC1);
     Scalar:=cvScalarAll_(0);
    end;
  //    capture := cvCreateFileCapture(PAnsiChar(Videofile));
 
    if Assigned(capture) then
    begin
        frame := cvQueryFrame(capture);
        if Assigned(frame) then
        begin
          if ifirst=1 then
          begin
           image:=Tbitmap.create;
           image.PixelFormat := pf24bit;
           ifirst:=2;
          end;
      //   inc(MSVideoForm.nframe);
         if(i<MSVideoFormDemo.nstart) then begin  inc(i); continue; end;
         if count=nstep then
         begin
           if flgrotation then
           begin
              pc.X:=round(frame.width/2.0);
              pc.Y:=round(frame.height/2.0);
             r:=cv2DRotationMatrix(pc, 180, 1.0,map_matrix);
             cvWarpAffine(frame, framerot, map_matrix,CV_INTER_LINEAR+CV_WARP_FILL_OUTLIERS,Scalar);//, src.size()); // what size I should use?
             IplImage2Bitmap(framerot,image);
           end
           else IplImage2Bitmap(frame,image);
           synchronize(VideoOutPut);
    //   MSVideoForm.image1.Picture.Assign(image);
          if flgrotation then  Sleep(MSVideoFormDemo.delayapr div 3)
          else Sleep(MSVideoFormDemo.delayapr);
           count:=1;
           inc(curframenmb);
         end
         else
         begin
          inc(count);
          inc(curframenmb);
         end;
        end  //assigned frame
        else break;
    end
    else break;
  end; {while execute}
   MSVideoFormDemo.nstop:=curframenmb;
   PostMessage(MsVideoFormDemo.Handle,wm_ThreadDoneMsg,mScanning,0);
   if (not Terminated) then  Self.Terminate;
end;
procedure  TThreadVideoStream.VideoOutPut;
begin
      MSVideoFormDemo.image1.Picture.Assign(image);
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
   flgrotation:=MSVIDEOFormDemo.lflgrotation;
    curframenmb:=0;
    nstep:=MSVideoFormDemo.nstep;//1;
//    MSVideoInit;
    FreeOnTerminate:=true;
    Priority := TThreadPriority(tpNormal);
    Suspended := false;// Resume;

 end;

destructor TThreadVideoStream.Destroy;
begin
   ThreadFlg:=mDrawing;
   FreeAndNil(image);
   PostMessage(MSvideoFormDEmo.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;

function TThreadVideoStream.MSVideoInit:byte;
begin
  curframenmb:=0;
  nstep:=1;
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
          if flgrotation then
           begin
              pc.X:=round(frame.width/2.0);
              pc.Y:=round(frame.height/2.0);
             r:=cv2DRotationMatrix(pc, 180, 1.0,map_matrix);
             cvWarpAffine(frame, framerot, map_matrix,CV_INTER_LINEAR+CV_WARP_FILL_OUTLIERS,Scalar);//, src.size()); // what size I should use?
             IplImage2Bitmap(framerot,image);
            end
            else IplImage2Bitmap(frame,image);
       //    MSVideoForm.image1.Picture.Assign(image);
         end
    end;
     result:=0;
end;
end.
