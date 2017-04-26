unit OpenCV_Video;

interface

  uses Windows, Sysutils, Math, Graphics, Types,
       OpenCV_Types;

  Const
       File_dll = 'opencv_video320.dll';
       File_dll_Interface = 'OpenCV_Class.dll';

  //--------------------Motion Analysis and Object Tracking----------------------
  procedure cvCalcOpticalFlowBM(const prev: pCvArr; const curr: pCvArr; blockSize, shiftSize, max_range: CvSize; usePrevious: integer; velx: pCvArr; vely: pCvArr); cdecl; External File_dll;
  procedure cvCalcOpticalFlowHS(const prev: pCvArr; const curr: pCvArr; usePrevious: integer; velx, vely: pCvArr; lambda: double; criteria: CvTermCriteria); cdecl; External File_dll;
  procedure cvCalcOpticalFlowLK(const prev: pCvArr; const curr: pCvArr; winSize: CvSize; velx, vely: pCvArr); cdecl; External File_dll;
  procedure cvCalcOpticalFlowPyrLK(const prev: pCvArr; const curr, prevPyr, currPyr: pCvArr; const prevFeatures: pCvPoint2D32f; currFeatures: pCvPoint2D32f; count: integer; winSize: CvSize; level: integer; status: pChar; track_error: pfloat; criteria: CvTermCriteria; flags: integer); cdecl; External File_dll;
  procedure cvCalcAffineFlowPyrLK( const prev : PCvArr; const curr : PCvArr; prev_pyr : PCvArr; curr_pyr : PCvArr; const prev_features : PCvPoint2D32f; curr_features : PCvPoint2D32f; matrices : PSingle; count : Integer; win_size : CvSize; level : Integer; status : PAnsiChar; track_error : PSingle; criteria : CvTermCriteria; flags : Integer);  cdecl; external File_dll;

  function  cvEstimateRigidTransform( const A : PCvArr; const B : PCvArr; M : PCvMat; full_affine : Integer) : Integer;  cdecl; external File_dll;
  Procedure cvCalcOpticalFlowFarneback( const prev: pCvArr; const next, flow: pCvArr; pyr_scale: double; levels, winsize, iterations, poly_n: Integer; poly_sigma: double; flags: integer); cdecl; external File_dll;

  //------------------------------motion templates ---------------------------------
  procedure cvUpdateMotionHistory(const silhouette: pCvArr; mhi: pCvArr; timestamp, duration: double); cdecl; External File_dll;
  procedure cvCalcMotionGradient(const mhi: pCvArr; mask: pCvArr; orientation: pCvArr; delta1, delta2: double; apertureSize: integer=3); cdecl; External File_dll;
  function cvCalcGlobalOrientation(const orientation: pCvArr; const mask: pCvArr; const mhi: pCvArr; timestamp, duration: double): double; cdecl; External File_dll;
  function cvSegmentMotion(const mhi: pCvArr; seg_mask: pCvArr; storage: pCvMemStorage; timestamp, seg_thresh: double): pCvSeq; cdecl; External File_dll;

  //----------------------------------Tracking ------------------------------------
  function cvCamShift(const prob_image: pCvArr; window: CvRect; criteria: CvTermCriteria; comp: pCvConnectedComp; box: pCvBox2D=NIL): integer; cdecl; External File_dll;
  function cvMeanShift(const prob_image: pCvArr; window: CvRect; criteria: CvTermCriteria; comp: pCvConnectedComp): integer; cdecl; External File_dll;

  function  cvCreateKalman(dynam_params: Integer; measure_params: Integer; control_params: Integer = 0): PCvKalman;  cdecl; external File_dll;
  procedure cvReleaseKalman(kalman: p2pCvKalman); cdecl; external File_dll;
  function  cvKalmanPredict(kalman: pCvKalman; const control: PCvMat = NIL): PCvMat; cdecl; external File_dll;
  function  cvKalmanCorrect(kalman: pCvKalman; const measurement: PCvMat): PCvMat; cdecl; external File_dll;

  //-----------------------------------Background/foreground segmentation-------------------
  Procedure cvReleaseBGStatModel(bg_model: p2pCvBGStatModel); cdecl; external File_dll;
  Function cvUpdateBGStatModel(current_frame: pIplImage; bg_model: pCvBGStatModel; learningRate: double = -1): Integer; cdecl; external File_dll;
  procedure cvRefineForegroundMaskBySegm(segments: pCvSeq; bg_model: pCvBGStatModel); cdecl; external File_dll;
  function cvChangeDetection(prev_frame, curr_frame, change_mask: pIplImage): integer; cdecl; external File_dll;

  Function cvCreateFGDStatModel(first_frame: pIplImage; parameters: pCvFGDStatModelParams = NIL): pCvBGStatModel; cdecl; external File_dll;
  Function cvCreateGaussianBGModel(first_frame: pIplImage; parameters: pCvGaussBGStatModelParams = NIL): pCvBGStatModel; cdecl; external File_dll;

  Function cvCreateBGCodeBookModel: pCvBGCodeBookModel; cdecl; external File_dll;
  Procedure cvReleaseBGCodeBookModel(model: p2pCvBGCodeBookModel); cdecl; external File_dll;
  Procedure cvBGCodeBookUpdate(model: pCvBGCodeBookModel; const image: pCvArr; roi: CvRect; const mask: pCvArr); cdecl; external File_dll;
  Function cvBGCodeBookDiff(const model: pCvBGCodeBookModel; const image: pCvArr; fgmask: pCvArr; roi: CvRect): integer; cdecl; external File_dll;
  Procedure cvBGCodeBookClearStale(model: pCvBGCodeBookModel; staleThresh: integer; roi: CvRect; const mask: pCvArr); cdecl; external File_dll;
  Function cvSegmentFGMask(fgmask: pCvArr; poly1Hull0: integer; perimScale: float; storage: pCvMemStorage; offset: CvPoint): pCvSeq; cdecl; external File_dll;
  {
  Function cvCreateBackgroundSubtractorMOG2: PBackgroundSubtractorMOG2; cdecl; external File_dll_Interface;
  Procedure cvInitBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; aWidth, aHeight: Integer; alphaT, sigma: double = 15; nmixtures: Integer =5; postFiltering: Boolean = false; minArea: double = 15; detectShadows: boolean =true; removeForeground: boolean = false; Tb: double = 16; Tg: double =9; TB: double =0.9; CT: double =0.05; shadowOutputValue: integer =127; tau: double =0.5); cdecl; external File_dll_Interface;
  Procedure cvProcessBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; const image0: pIplImage; fgmask0: pIplImage; learningRate: double); cdecl; external File_dll_Interface;
  Procedure cvReleaseBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2); cdecl; external File_Dll;
  }
  Function cvCreateBackgroundSubtractorMOG2(History: Integer; varThreshold: float; bShadowDetection: Boolean = True): PBackgroundSubtractorMOG2; cdecl; external File_dll_Interface;
  Procedure cvOperatorBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; const image0: pIplImage; fgmask0: pIplImage; learningRate: double = -1); cdecl; external File_dll_Interface;
  function cvGetBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2): pIplImage; cdecl; external File_dll_Interface;
  Procedure cvReleaseBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2); cdecl; external File_dll_Interface;

  function cvFrameSizeBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; frameSize: cvSize): cvSize; cdecl; external File_dll_Interface;
  function cvFrameTypeBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; frameType: Integer = 0): Integer;cdecl; external File_dll_Interface;
  function cvnFramesBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; nframes: Integer = 0): Integer;cdecl; external File_dll_Interface;
  function cvHistoryBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; History: Integer = 0): Integer;cdecl; external File_dll_Interface;
  function cvnMixturesBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; nMixtures: Integer = 0): Integer;cdecl; external File_dll_Interface;
  function cvvarThersholdBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; varThreshold: float = 0): float;cdecl; external File_dll_Interface;
  function cvbackgroundRatioBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; backgroundRatio: float = 0): float;cdecl; external File_dll_Interface;
  function cvvarThresholdGenBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; varThresholdGen: float = 0): float;cdecl; external File_dll_Interface;
  function cvfVarInitBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; fVarInit: float = 0): float;cdecl; external File_dll_Interface;
  function cvfVarMinBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; fVarMin: float = 0): float;cdecl; external File_dll_Interface;
  function cvfVarMaxBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; fVarMax: float = 0): float;cdecl; external File_dll_Interface;
  function cvfCTBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; fCT: float = 0): float;cdecl; external File_dll_Interface;

  //---------shadow-----------
  function cvbShadowDetectionBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; bShadowDetection: Boolean = False): Boolean; cdecl; external File_dll_Interface;
  function cvnShadowDetectionBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; nShadowDetection: Byte = 0): byte; cdecl; external File_dll_Interface;
  function cvfTauBackgroundSubtractorMOG2(model: PBackgroundSubtractorMOG2; fTau: float = 0): float;cdecl; external File_dll_Interface;

  function cvCreatePixelBackgroundGMM(width, height: Integer): pCvPixelBackgroundGMM; cdecl; external File_dll_Interface;
  procedure cvReleasePixelBackgroundGMM(ppGMM: p2pCvPixelBackgroundGMM);cdecl; external File_dll_Interface;
  Procedure cvSetPixelBackgroundGMM(pGMM: pCvPixelBackgroundGMM; data: pByte);cdecl; external File_dll_Interface;
  procedure cvUpdatePixelBackgroundGMMTiled(pGMM: pCvPixelBackgroundGMM; data: pByte; output: pByte);cdecl; external File_dll_Interface;
  procedure cvUpdatePixelBackgroundGMM(pGMM: pCvPixelBackgroundGMM; data: pByte; output: pByte);cdecl; external File_dll_Interface;
  procedure copyImageData(h_img: pIplImage; d_pinnedMem: pByte; channels: Integer);cdecl; external File_dll_Interface;
  function _cvRemoveShadowGMM(posPixel: LongInt; red, green, blue: Float; nModes: Byte; m_aGaussians: pCvPBGMMGaussian; m_nM: Integer; m_fTb, m_fTB1, m_fTg, m_fTau: float): Integer;cdecl; external File_dll_Interface;

implementation

end.

