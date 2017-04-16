unit OpenCV_HighGui;

interface

  uses Windows, Sysutils, Math, Graphics, Types,
       OpenCV_Types;
       
  const
       File_dll = '..\exe\opencv\opencv_highgui249.dll';
       LibMpeg = '..\exe\opencv\opencv_ffmpeg249.dll';

  Function  cvFontQt(const nameFont: pchar; pointSize: Integer; color: CvScalar; weight,  style, spacing: Integer): cvFont; cdecl; external File_dll;
  Procedure cvAddText(const img: pCvArr; const text: pchar; org: CvPoint; arg2: pCvFont); cdecl; external File_dll;
  Procedure cvDisplayOverlay(const name: pchar; const text: pchar; delayms: Integer); cdecl; external File_dll;
  Procedure cvDisplayStatusBar(const name: pchar; const text: pchar; delayms: Integer); cdecl; external File_dll;
  Procedure cvCreateOpenGLCallback(const window_name: pchar; callbackOpenGL: CvOpenGLCallback; userdata: Pointer; angle, zmin, zmax: double); cdecl; external File_dll;
  Procedure cvSaveWindowParameters(const name: pChar); cdecl; external File_dll;
  Procedure cvLoadWindowParameters(const name: pChar); cdecl; external File_dll;
  //Function cvStartLoop(int (*pt2Func)(int argc, char *argv[]), int argc, char* argv[]): Integer; cdecl; external File_dll;
  Procedure cvStopLoop(); cdecl; external File_dll;

  Function cvCreateButton(button_name: pchar; on_change: CvButtonCallback; userdata: Pointer; button_type: Integer; initial_button_state: Integer): Integer; cdecl; external File_dll;

  function cvInitSystem(argc: integer; argv: p2pChar): integer; cdecl; external File_dll;
  function  cvStartWindowThread : Integer;  cdecl; external File_dll;

  function cvNamedWindow(const name: pChar; flags: integer): integer; cdecl; external File_dll;
  Procedure cvSetWindowProperty(const name: pChar; prop_id: Integer; prop_value: double); cdecl; external File_dll;
  Function cvGetWindowProperty(const name: pchar; prop_id: Integer): double; cdecl; external File_dll;

  procedure cvResizeWindow(const name: pchar; width, height: integer); cdecl; external File_dll;
  procedure cvShowImage(const name: pChar; const image: pCvArr); cdecl; external File_dll;
  procedure cvMoveWindow(const name: pChar; x, y: integer); cdecl; external File_dll;
  procedure cvDestroyWindow(const name: pchar); cdecl; external File_dll;
  procedure cvDestroyAllWindows; cdecl; external File_dll;
  function cvGetWindowHandle(const name: pchar): pointer; cdecl; external File_dll;
  function cvGetWindowName(windowHandle: pointer): pChar; cdecl; external File_dll;

  function  cvCreateTrackbar( const trackbar_name: PAnsiChar; const window_name: PAnsiChar; value: Pint; count: Integer; on_change: CvTrackbarCallback): Integer;  cdecl; external File_dll;
  function  cvCreateTrackbar2( const trackbar_name: PAnsiChar; const window_name: PAnsiChar; value: Pint; count: Integer; on_change: CvTrackbarCallback2; userdata: Pointer): Integer;  cdecl; external File_dll;
  procedure cvSetTrackbarPos(const trackbarName: pChar; const windowName: pChar; pos: integer); cdecl; external File_dll;
  function cvGetTrackbarPos(const trackbarName: pchar; const windowName: pchar): integer; cdecl; external File_dll;

  procedure cvSetMouseCallback(const windowName: pChar; onMouse: CvMouseCallback; param: Pointer=NIL); cdecl; external File_dll;

  //-----------------Reading and Writing Images and Video--------------
  function cvLoadImage(const filename: pchar; iscolor: integer=CV_LOAD_IMAGE_COLOR): pIplImage; cdecl; external File_dll;
  function cvLoadImageM(const filename: pChar; iscolor: Integer=CV_LOAD_IMAGE_COLOR): pCvMat; cdecl; external File_dll;
  function cvSaveImage(const filename: pchar; const image: pCvArr): Integer; cdecl; external File_dll;
  function cvDecodeImage(const buf: PCvMat; iscolor: Integer): PIplImage;  cdecl; external File_dll;
  function cvDecodeImageM(const buf: PCvMat; iscolor: Integer): PCvMat;  cdecl; external File_dll;
  function cvEncodeImage( const ext: PAnsiChar; const image: PCvArr; const params: Pint): PCvMat;  cdecl; external File_dll;
  procedure cvConvertImage( const src: PCvArr; dst: PCvArr; flags: Integer);  cdecl; external File_dll;

  function cvWaitKey(delay: Integer=0): integer; cdecl; external File_dll;

  //---------------------------Working with Video Files and Cameras----------------
  function cvCreateFileCapture(const filename: PAnsiChar): PCvCapture;  cdecl; external File_dll;
  function cvCreateCameraCapture(index: Integer): PCvCapture;  cdecl; external File_dll;
  function cvGrabFrame(capture: pCvCapture): integer; cdecl; external File_dll;
  function cvRetrieveFrame(capture: pCvCapture; streamIdx: Integer = 0): pIplImage; cdecl; external File_dll;
  function cvQueryFrame(capture: pCvCapture): pIplImage; cdecl; external File_dll;
  procedure cvReleaseCapture(capture: p2pCvCapture); cdecl; external File_dll;
  function cvGetCaptureProperty(capture: pCvCapture; property_id: integer): double; cdecl; external File_dll;
  function cvSetCaptureProperty(capture: pCvCapture; property_id: Integer; value: double): integer; cdecl; external File_dll;
  function cvGetCaptureDomain(capture: pCvCapture): Integer; cdecl; external File_dll;
  
  function cvCreateVideoWriter(const filename: pChar; fourcc: integer; fps: double; frame_size: CvSize; is_color: integer=1): pCvVideoWriter; cdecl; external File_dll;
  function cvWriteFrame(writer: pCvVideoWriter; const image: pIplImage): integer; cdecl; external File_dll;
  procedure cvReleaseVideoWriter(writer: p2pCvVideoWriter); cdecl; external File_dll;

  procedure cvSetPreprocessFuncWin32( on_preprocess: CvWin32WindowCallback);  cdecl; external File_dll;
  procedure cvSetPostprocessFuncWin32( on_postprocess: CvWin32WindowCallback);  cdecl; external File_dll;

  //-------------------------------------FFMPEG--------------------------------------
  function cvCreateFileCapture_FFMPEG(filename: pChar) : PCvCapture; cdecl; external libmpeg;
  function cvCreateVideoWriter_FFMPEG (filename : LPCSTR; fourcc : Integer; fps : double; frameSize : CvSize; is_color : Integer) : PCvVideoWriter; cdecl; external libmpeg;
  function cvGetCaptureProperty_FFMPEG(capture : PCvCapture; prop_id : Integer) : double; cdecl; external libmpeg;
  function cvGrabFrame_FFMPEG(capture : PCvCapture) : Integer; cdecl; external libmpeg;
  function cvRetrieveFrame_FFMPEG(capture : PCvCapture; streamIdx : Integer) : PIplImage; cdecl; external libmpeg;
  procedure cvReleaseVideoWriter_FFMPEG( writer : P2PCvVideoWriter); cdecl; external libmpeg;
  procedure cvReleaseCapture_FFMPEG(capture : P2PCvCapture); cdecl; external libmpeg;
  function cvSetCaptureProperty_FFMPEG(capture : PCvCapture; prop_id : Integer; value : double) : Integer; cdecl; external libmpeg;
  function cvWriteFrame_FFMPEG(writer : PCvVideoWriter; image : PIplImage) : Integer; cdecl; external libmpeg;

implementation

end.

