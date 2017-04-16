unit OpenCV_Types;

interface
  Uses Math, Types, Windows, Sysutils;

  CONST
    CV_HAAR_FEATURE_MAX=3;
    CV_MAX_NUM_GREY_LEVELS_8U=10;
    NUM_FACE_ELEMENTS=3;
    CV_LOAD_IMAGE_UNCHANGED = -1;
  (* 8bit= 1; gray *)
  CV_LOAD_IMAGE_GRAYSCALE = 0;
  (* ?= 2; color *)
  CV_LOAD_IMAGE_COLOR = 1;
  (* any depth= 3; ? *)
  CV_LOAD_IMAGE_ANYDEPTH = 2;
  (* ?= 4; any color *)
  CV_LOAD_IMAGE_ANYCOLOR = 4;

  (* Shape matching methods *)
  (* Shape orientation *)
  CV_CLOCKWISE         = 1;
  CV_COUNTER_CLOCKWISE = 2;


    ///
    CV_RAND_NORMAL = 1;
    CV_RAND_UNI = 0;

    CV_FOURCC_PROMPT = -1; (* Open Codec Selection Dialog (Windows only) *)

    CV_RNG_COEFF = Cardinal(4164903690);

    CV_HOUGH_STANDARD = 0;
    CV_HOUGH_PROBABILISTIC = 1;
    CV_HOUGH_MULTI_SCALE = 2;
    CV_HOUGH_GRADIENT = 3;

    CV_EVENT_MOUSEMOVE = 0;
    CV_EVENT_LBUTTONDOWN = 1;
    CV_EVENT_RBUTTONDOWN = 2;
    CV_EVENT_MBUTTONDOWN = 3;
    CV_EVENT_LBUTTONUP = 4;
    CV_EVENT_RBUTTONUP = 5;
    CV_EVENT_MBUTTONUP = 6;
    CV_EVENT_LBUTTONDBLCLK = 7;
    CV_EVENT_RBUTTONDBLCLK = 8;
    CV_EVENT_MBUTTONDBLCLK = 9;
    CV_EVENT_FLAG_LBUTTON = 1;
    CV_EVENT_FLAG_RBUTTON = 2;
    CV_EVENT_FLAG_MBUTTON = 4;
    CV_EVENT_FLAG_CTRLKEY = 8;
    CV_EVENT_FLAG_SHIFTKEY = 16;
    CV_EVENT_FLAG_ALTKEY = 32;

    CV_FLOODFILL_FIXED_RANGE = (1 shl 16);
    CV_FLOODFILL_MASK_ONLY = (1 shl 17);

    CV_COMP_CORREL = 0;
    CV_COMP_CHISQR = 1;
    CV_COMP_INTERSECT = 2;
    CV_COMP_BHATTACHARYYA = 3;

    CV_32FC1 =  5;  //CV_MAKETYPE(CV_32F,1)
    CV_32FC2 = 13; //CV_MAKETYPE(CV_32F,2)
    CV_32FC3 = 21; //CV_MAKETYPE(CV_32F,3)
    CV_32FC4 = 29; //CV_MAKETYPE(CV_32F,4)

    CV_CN_SHIFT = 3;

    CV_CONTOURS_MATCH_I1 = 1;
    CV_CONTOURS_MATCH_I2 = 2;
    CV_CONTOURS_MATCH_I3 = 3;

    CV_C = 1;
    CV_L1 = 2;
    CV_L2 = 4;
    CV_NORM_MASK = 7;
    CV_RELATIVE = 8;
    CV_DIFF = 16;
    CV_MINMAX = 32;

    CV_CAP_ANY      =0;    // autodetect
  	CV_CAP_MIL      =100;  // MIL proprietary drivers
  	CV_CAP_VFW      =200;  // platform native
	  CV_CAP_V4L      =200;
	  CV_CAP_V4L2     =200;

	  CV_CAP_FIREWARE =300;  // IEEE 1394 drivers
	  CV_CAP_FIREWIRE =300;
	  CV_CAP_IEEE1394 =300;
	  CV_CAP_DC1394   =300;
	  CV_CAP_CMU1394  =300;

	  CV_CAP_STEREO   =400;  // TYZX proprietary drivers
	  CV_CAP_TYZX     =400;
	  CV_TYZX_LEFT    =400;
	  CV_TYZX_RIGHT   =401;
	  CV_TYZX_COLOR   =402;
	  CV_TYZX_Z       =403;

	  CV_CAP_QT       =500;  // QuickTime

	  CV_CAP_UNICAP   =600;  // Unicap drivers

	  CV_CAP_DSHOW    =700;  // DirectShow (via videoInput)

	  CV_CAP_PVAPI    =800;   // PvAPI, Prosilica GigE SDK

    CV_CAP_PROP_POS_MSEC       =0;
  	CV_CAP_PROP_POS_FRAMES     =1;
  	CV_CAP_PROP_POS_AVI_RATIO  =2;
  	CV_CAP_PROP_FRAME_WIDTH    =3;
  	CV_CAP_PROP_FRAME_HEIGHT   =4;
  	CV_CAP_PROP_FPS            =5;
  	CV_CAP_PROP_FOURCC         =6;
  	CV_CAP_PROP_FRAME_COUNT    =7;
  	CV_CAP_PROP_FORMAT         =8;
  	CV_CAP_PROP_MODE           =9;
  	CV_CAP_PROP_BRIGHTNESS    =10;
  	CV_CAP_PROP_CONTRAST      =11;
  	CV_CAP_PROP_SATURATION    =12;
  	CV_CAP_PROP_HUE           =13;
  	CV_CAP_PROP_GAIN          =14;
  	CV_CAP_PROP_EXPOSURE      =15;
  	CV_CAP_PROP_CONVERT_RGB   =16;
  	CV_CAP_PROP_WHITE_BALANCE =17;
  	CV_CAP_PROP_RECTIFICATION =18;
	  CV_CAP_PROP_MONOCROME	  =19;

    //These 3 flags are used by cvSet/GetWindowProperty
	  CV_WND_PROP_FULLSCREEN = 0;//to change/get window's fullscreen property
	  CV_WND_PROP_AUTOSIZE   = 1;//to change/get window's autosize property
	  CV_WND_PROP_ASPECTRATIO= 2;//to change/get window's aspectratio property
	//
	//These 2 flags are used by cvNamedWindow and cvSet/GetWindowProperty
	  CV_WINDOW_NORMAL       = $00000000;//the user can resize the window (no constraint)  / also use to switch a fullscreen window to a normal size
	  CV_WINDOW_AUTOSIZE 	   = $00000001;//the user cannot resize the window, the size is constrainted by the image displayed
	//
	//Those flags are only for Qt
	  CV_GUI_EXPANDED 		= $00000000;//status bar and tool bar
	  CV_GUI_NORMAL 			= $00000010;//old fashious way
	//
	//These 3 flags are used by cvNamedWindow and cvSet/GetWindowProperty
	  CV_WINDOW_FULLSCREEN   = 1;//change the window to fullscreen
	  CV_WINDOW_FREERATIO	   = $00000100;//the image expends as much as it can (no ratio constraint)
  	CV_WINDOW_KEEPRATIO    = $00000000;//the ration image is respected.

    //* Shapes of a structuring element for morphological operations */
    CV_SHAPE_RECT      =0;
    CV_SHAPE_CROSS     =1;
    CV_SHAPE_ELLIPSE   =2;
    CV_SHAPE_CUSTOM    =100;

    //* Morphological operations */
    CV_MOP_ERODE        =0;
    CV_MOP_DILATE       =1;
    CV_MOP_OPEN         =2;
    CV_MOP_CLOSE        =3;
    CV_MOP_GRADIENT     =4;
    CV_MOP_TOPHAT       =5;
    CV_MOP_BLACKHAT     =6;

    CVCAM_PROP_ENABLE = 'enable';
    CVCAMTRUE = 1;
    CVCAMFALSE = 0;

    CVCAM_PROP_RENDER  = 'render';
    CVCAM_PROP_WINDOW  = 'window';
    CVCAM_PROP_CALLBACK  = 'callback';
    CVCAM_DESCRIPTION  = 'description';
    CVCAM_VIDEOFORMAT  = 'video_pp';
    CVCAM_CAMERAPROPS  = 'camera_pp';
    CVCAM_RNDWIDTH  = 'rendering_width';
    CVCAM_RNDHEIGHT  = 'rendering_height';
    CVCAM_SRCWIDTH  = 'source_width';
    CVCAM_SRCHEIGHT  = 'source_height';
    CVCAM_STEREO_CALLBACK  = 'stereo_callback';
    CVCAM_STEREO3_CALLBACK  = 'stereo3_callback';
    CVCAM_STEREO4_CALLBACK  = 'stereo4_callback';
    CVCAM_PROP_SETFORMAT  = 'set_video_format';
    CVCAM_PROP_RAW  = 'raw_image';
    CVCAM_PROP_TIME_FORMAT  = 'time_format';
    CVCAM_PROP_DURATION  = 'duration';
    CVCAM_PROP_POSITION  = 'current_position';

    //* Template matching methods */
    CV_TM_SQDIFF        = 0;
    CV_TM_SQDIFF_NORMED = 1;
    CV_TM_CCORR         = 2;
    CV_TM_CCORR_NORMED  = 3;
    CV_TM_CCOEFF        = 4;
    CV_TM_CCOEFF_NORMED = 5;

    CV_PI = PI;
    
    IPL_DEPTH_SIGN = $80000000 ;
    IPL_DEPTH_1U  =   1;
    IPL_DEPTH_8U  =   8;
    IPL_DEPTH_16U =  16;
    IPL_DEPTH_32F =  32;
    IPL_DEPTH_64F =  64;

    CV_VALUE = 1;
    CV_ARRAY = 2;

    IPL_DEPTH_8S = (IPL_DEPTH_SIGN or  8) ;
    IPL_DEPTH_16S= (IPL_DEPTH_SIGN or 16);
    IPL_DEPTH_32S =(IPL_DEPTH_SIGN or 32);

    IPL_DATA_ORDER_PIXEL=  0;
    IPL_DATA_ORDER_PLANE = 1;

    IPL_ORIGIN_TL= 0  ;
    IPL_ORIGIN_BL= 1  ;

    IPL_ALIGN_4BYTES=   4;
    IPL_ALIGN_8BYTES=   8 ;
    IPL_ALIGN_16BYTES= 16 ;
    IPL_ALIGN_32BYTES= 32 ;

    IPL_ALIGN_DWORD =  IPL_ALIGN_4BYTES;
    IPL_ALIGN_QWORD  = IPL_ALIGN_8BYTES;

    IPL_BORDER_CONSTANT=   0  ;
    IPL_BORDER_REPLICATE=  1 ;
    IPL_BORDER_REFLECT  =  2 ;
    IPL_BORDER_WRAP    =   3;

    CV_8U =  0;
    CV_8S  = 1;
    CV_16U = 2;
    CV_16S = 3;
    CV_32S = 4;
    CV_32F = 5;
    CV_64F = 6;
    CV_USRTYPE1= 7;

    CV_32SC2 = CV_32S +(2-1)*8;

    CV_MAT_TYPE_MASK = 31;
    CV_MAT_MAGIC_VAL = $42420000;
    CV_MAT_CONT_FLAG_SHIFT = 9;
    CV_MAT_CONT_FLAG = 1 shl CV_MAT_CONT_FLAG_SHIFT;

    CV_MAT_CN_MASK = 3 shl 3;
    CV_MAT_DEPTH_MASK = 7;

    CV_RODRIGUES_M2V = 0;
    CV_RODRIGUES_V2M = 1;
    CV_MAGIC_MASK    = $FFFF0000 ;

    CV_LU  = 0;
    CV_SVD = 1;

    //* Constants for color conversion */
    CV_BGR2BGRA    =0;
    CV_RGB2RGBA    =CV_BGR2BGRA;

    CV_BGRA2BGR    =1;
    CV_RGBA2RGB    =CV_BGRA2BGR;

    CV_BGR2RGBA    =2;
    CV_RGB2BGRA    =CV_BGR2RGBA;

    CV_RGBA2BGR    =3;
    CV_BGRA2RGB    =CV_RGBA2BGR;

    CV_BGR2RGB     =4;
    CV_RGB2BGR     =CV_BGR2RGB;

    CV_BGRA2RGBA   =5;
    CV_RGBA2BGRA   =CV_BGRA2RGBA;

    CV_BGR2GRAY    =6;
    CV_RGB2GRAY    =7;
    CV_GRAY2BGR    =8;
    CV_GRAY2RGB    =CV_GRAY2BGR;
    CV_GRAY2BGRA   =9;
    CV_GRAY2RGBA   =CV_GRAY2BGRA;
    CV_BGRA2GRAY   =10;
    CV_RGBA2GRAY   =11;

    CV_BGR2BGR565  =12;
    CV_RGB2BGR565  =13;
    CV_BGR5652BGR  =14;
    CV_BGR5652RGB  =15;
    CV_BGRA2BGR565 =16;
    CV_RGBA2BGR565 =17;
    CV_BGR5652BGRA =18;
    CV_BGR5652RGBA =19;

    CV_GRAY2BGR565 =20;
    CV_BGR5652GRAY =21;

    CV_BGR2BGR555  =22;
    CV_RGB2BGR555  =23;
    CV_BGR5552BGR  =24;
    CV_BGR5552RGB  =25;
    CV_BGRA2BGR555 =26;
    CV_RGBA2BGR555 =27;
    CV_BGR5552BGRA =28;
    CV_BGR5552RGBA =29;

    CV_GRAY2BGR555 =30;
    CV_BGR5552GRAY =31;

    CV_BGR2XYZ     =32;
    CV_RGB2XYZ     =33;
    CV_XYZ2BGR     =34;
    CV_XYZ2RGB     =35;

    CV_BGR2YCrCb   =36;
    CV_RGB2YCrCb   =37;
    CV_YCrCb2BGR   =38;
    CV_YCrCb2RGB   =39;

    CV_BGR2HSV     =40;
    CV_RGB2HSV     =41;

    CV_BGR2Lab     =44;
    CV_RGB2Lab     =45;

    CV_BayerBG2BGR =46;
    CV_BayerGB2BGR =47;
    CV_BayerRG2BGR =48;
    CV_BayerGR2BGR =49;

    CV_BayerBG2RGB =CV_BayerRG2BGR;
    CV_BayerGB2RGB =CV_BayerGR2BGR;
    CV_BayerRG2RGB =CV_BayerBG2BGR;
    CV_BayerGR2RGB =CV_BayerGB2BGR;

    CV_BGR2Luv     =50;
    CV_RGB2Luv     =51;
    CV_BGR2HLS     =52;
    CV_RGB2HLS     =53;

    CV_HSV2BGR     =54;
    CV_HSV2RGB     =55;

    CV_Lab2BGR     =56;
    CV_Lab2RGB     =57;
    CV_Luv2BGR     =58;
    CV_Luv2RGB     =59;
    CV_HLS2BGR     =60;
    CV_HLS2RGB     =61;

    CV_BayerBG2BGR_VNG =62;
    CV_BayerGB2BGR_VNG =63;
    CV_BayerRG2BGR_VNG =64;
    CV_BayerGR2BGR_VNG =65;
    
    CV_BayerBG2RGB_VNG =CV_BayerRG2BGR_VNG;
    CV_BayerGB2RGB_VNG =CV_BayerGR2BGR_VNG;
    CV_BayerRG2RGB_VNG =CV_BayerBG2BGR_VNG;
    CV_BayerGR2RGB_VNG =CV_BayerGB2BGR_VNG;
    
    CV_BGR2HSV_FULL = 66;
    CV_RGB2HSV_FULL = 67;
    CV_BGR2HLS_FULL = 68;
    CV_RGB2HLS_FULL = 69;
    
    CV_HSV2BGR_FULL = 70;
    CV_HSV2RGB_FULL = 71;
    CV_HLS2BGR_FULL = 72;
    CV_HLS2RGB_FULL = 73;
    
    CV_LBGR2Lab     = 74;
    CV_LRGB2Lab     = 75;
    CV_LBGR2Luv     = 76;
    CV_LRGB2Luv     = 77;
    
    CV_Lab2LBGR     = 78;
    CV_Lab2LRGB     = 79;
    CV_Luv2LBGR     = 80;
    CV_Luv2LRGB     = 81;
    
    CV_BGR2YUV      = 82;
    CV_RGB2YUV      = 83;
    CV_YUV2BGR      = 84;
    CV_YUV2RGB      = 85;
    
    CV_COLORCVT_MAX  =100;
    
    CV_FILLED = -(1);
    CV_AA = 16;

    CV_LKFLOW_PYR_A_READY =      1;
    CV_LKFLOW_PYR_B_READY =      2;
    CV_LKFLOW_INITIAL_GUESSES =  4;
    CV_POLY_APPROX_DP = 0;

    CV_WHOLE_SEQ_END_INDEX = $3fffffff;

    CV_ErrModeLeaf = 0;
    CV_ErrModeParent = 1;
    CV_ErrModeSilent = 2;

    CV_THRESH_BINARY = 0;  // value = value > threshold ? max_value : 0       */
    CV_THRESH_BINARY_INV = 1;  // value = value > threshold ? 0 : max_value       */
    CV_THRESH_TRUNC = 2 ; // value = value > threshold ? threshold : value   */
    CV_THRESH_TOZERO = 3 ; // value = value > threshold ? value : 0           */
    CV_THRESH_TOZERO_INV = 4 ; // value = value > threshold ? 0 : value           */
    CV_THRESH_MASK = 7 ;
    CV_THRESH_OTSU = 8 ; // use Otsu algorithm to choose the optimal threshold value;                                 combine the flag with one of the above CV_THRESH_* values */

    ///* Image smooth methods */
    CV_BLUR_NO_SCALE = 0;
    CV_BLUR = 1;
    CV_GAUSSIAN = 2;
    CV_MEDIAN = 3 ;
    CV_BILATERAL = 4;

    CV_GAUSSIAN_5x5 = 7; //* Filters used in pyramid decomposition */

    CV_SEQ_ELTYPE_POINT = CV_32SC2;

    ///* Inpainting algorithms */
    CV_INPAINT_NS = 0;
    CV_INPAINT_TELEA = 1;

    //* Special filters */
    CV_SCHARR = -1;
    CV_MAX_SOBEL_KSIZE = 7;

    // basic font types
    CV_FONT_HERSHEY_SIMPLEX      =   0   ;
    CV_FONT_HERSHEY_PLAIN  =         1  ;
    CV_FONT_HERSHEY_DUPLEX  =        2  ;
    CV_FONT_HERSHEY_COMPLEX  =       3 ;
    CV_FONT_HERSHEY_TRIPLEX   =      4 ;
    CV_FONT_HERSHEY_COMPLEX_SMALL =  5  ;
    CV_FONT_HERSHEY_SCRIPT_SIMPLEX = 6  ;
    CV_FONT_HERSHEY_SCRIPT_COMPLEX = 7 ;

    // font flags
    CV_FONT_ITALIC  =               16  ;
    CV_FONT_VECTOR0  =  CV_FONT_HERSHEY_SIMPLEX;

    ///* Sub-pixel interpolation methods */
    CV_INTER_NN  =      0;
    CV_INTER_LINEAR =   1;
    CV_INTER_CUBIC  =   2;
    CV_INTER_AREA   =   3;

    //* ... and other image warping flags */
    CV_WARP_FILL_OUTLIERS =8;
    CV_WARP_INVERSE_MAP  =16 ;

    CV_ADAPTIVE_THRESH_MEAN_C  =0;
    CV_ADAPTIVE_THRESH_GAUSSIAN_C  =1;

    CV_DIST_USER    =-1;  //* User defined distance */
    CV_DIST_L1      =1;   //* distance = |x1-x2| + |y1-y2| */
    CV_DIST_L2      =2;   //* the simple euclidean distance */
    CV_DIST_C       =3;   //* distance = max(|x1-x2|;|y1-y2|) */
    CV_DIST_L12     =4;   //* L1-L2 metric: distance = 2(sqrt(1+x*x/2) - 1)) */
    CV_DIST_FAIR    =5;   //* distance = c^2(|x|/c-log(1+|x|/c)), c = 1.3998 */
    CV_DIST_WELSCH  =6;   //* distance = c^2/2(1-exp(-(x/c)^2)), c = 2.9846 */
    CV_DIST_HUBER   =7;    //* distance = |x|type  }
    CV_HIST_UNIFORM = 1;
  { for uniform histograms  }
  { for non-uniform histograms  }
  { embedded matrix header for array histograms  }

   // Approximates a single polygonal curve (contour) or *}
    CV_DOMINANT_IPAN = 1;

    CV_AUTOSTEP = $7fffffff;

    // Initializes CvMat header *}
    //*************** matrix iterator: used for n-ary operations on dense arrays *********}
    CV_MAX_ARR = 10;
    CV_NO_DEPTH_CHECK = 1;
    CV_NO_CN_CHECK = 2;
    CV_NO_SIZE_CHECK = 4;

    CV_64FC1 = 6; //CV_MAKETYPE(CV_64F,1)
    CV_64FC2 = 14; //CV_MAKETYPE(CV_64F,2)
    CV_64FC3 = 22; //CV_MAKETYPE(CV_64F,3)
    CV_64FC4 = 30; //CV_MAKETYPE(CV_64F,4)
    //  CV_64FC(n) CV_MAKETYPE(CV_64F,(n))

    CV_LMEDS = 4;
    CV_RANSAC = 8;

    // Finds perspective transformation between the object plane and image (view) plane *}
    CV_CALIB_CB_ADAPTIVE_THRESH = 1;
    CV_CALIB_CB_NORMALIZE_IMAGE = 2;
    CV_CALIB_CB_FILTER_QUADS = 4;
    // Detects corners on a chessboard calibration pattern *}
    CV_CALIB_USE_INTRINSIC_GUESS = 1;
    CV_CALIB_FIX_ASPECT_RATIO = 2;
    CV_CALIB_FIX_PRINCIPAL_POINT = 4;
    CV_CALIB_ZERO_TANGENT_DIST = 8;
    CV_CALIB_FIX_FOCAL_LENGTH = 16;
    CV_CALIB_FIX_K1 = 32;
    CV_CALIB_FIX_K2 = 64;
    CV_CALIB_FIX_K3 = 128;
    //// Finds intrinsic and extrinsic camera parameters
    CV_CALIB_FIX_INTRINSIC = 256;
    CV_CALIB_SAME_FOCAL_LENGTH = 512;
    //// Computes the transformation from one camera coordinate system to another one
    CV_CALIB_ZERO_DISPARITY = 1024;
    //// Computes 3D rotations (+ optional shift) for each camera coordinate system to make both
    //// Calculates fundamental matrix given a set of corresponding points *}
    CV_FM_7POINT = 1;
    CV_FM_8POINT = 2;
    CV_FM_LMEDS_ONLY = CV_LMEDS;
    CV_FM_RANSAC_ONLY = CV_RANSAC;
    CV_FM_LMEDS = CV_LMEDS;
    CV_FM_RANSAC = CV_RANSAC;
    // stereo correspondence parameters and functions *}
    CV_STEREO_BM_NORMALIZED_RESPONSE = 0;
    // Block matching algorithm structure *}
    CV_STEREO_BM_BASIC = 0;
    CV_STEREO_BM_FISH_EYE = 1;
    CV_STEREO_BM_NARROW = 2;
    // Kolmogorov-Zabin stereo-correspondence algorithm (a.k.a. KZ1) *}

   //CV_STEREO_GC_OCCLUDED = SHRT_MAX;

//-----------------core. The Core Functionality ----------------------
//-------------------1.1 Basic Structures-------------------------
  TYPE
    pGPUDeviceInfo= Pointer;
    p2pCvBlobTrackGen = ^pCvBlobTrackGen;
    pCvBlobTrackGen = Pointer;
    p2pCvBlobDetector = ^pCvBlobDetector;
    pCvBlobDetector = Pointer;
    pCvBlobTrackSeq = Pointer;
    p2pCvFGDetector = ^pCvFGDetector;
    pCvFGDetector = Pointer;
    pCvBlobSeq = Pointer;
    PCvSVM = Pointer;
    PCvSVMKernel = Pointer;
    PCvSVMParams = Pointer;
    PCvHOGDescriptor = Pointer;
    PCvANN_MLP_TrainParams = Pointer;
    PCvANN_MLP = Pointer;
    PBackgroundSubtractorMOG2 = Pointer;
    PCvKNearest = Pointer;
    PCvNormalBayes = Pointer;
    PCvStatModel = Pointer;
    PCvFeatureTree = Pointer;
    PCvLSHOperations = Pointer;
    CvHistType = longint;

    UInt32 = Cardinal;

    Float  = Single;
    pFloat = ^Float;
    p2pFloat = ^PFloat;
    Short  = SmallInt;
    pShort = ^Short;
    pInteger = ^Integer;

    pDouble = ^Double;
    p2pDouble = ^PDouble;
    p3pDouble = ^p2pDouble;

    CvBool = UCHAR;

    pPointer = ^Pointer;
    p2pPointer = ^pPointer;
    P2pChar = ^pChar;
    pschar = pbyte;
    p2pSingle = ^pSingle;

    PArrayUChar = ^ArrayUChar;
    ArrayUChar = array[0..65536] of AnsiChar;
    PArraySmallInt = ^ArraySmallInt;
    ArraySmallInt = array[0..65536] of SmallInt;
    PArrayInteger = ^ArrayInteger;
    ArrayInteger = array[0..65536] of Integer;
    PArraySingle = ^ArraySingle;
    ArraySingle = array[0..65536] of Single;
    PArrayDouble = ^ArrayDouble;
    ArrayDouble = array[0..65536] of Double;

    pCvPBGMMGaussian = ^CvPBGMMGaussian;
    CvPBGMMGaussian = Record
	     sigma,
    	 muR,
    	 muG,
    	 muB,
    	 weight: float;
    End;

    p2pCvPixelBackgroundGMM = ^pCvPixelBackgroundGMM;
    pCvPixelBackgroundGMM = ^CvPixelBackgroundGMM;
    CvPixelBackgroundGMM = Record
	    fAlphaT: float;
	    fTb: float;
	    fTg: float;
	    fTB1: float;
	    fSigma: float;
	    fCT: float;//CT - complexity reduction prior
	    nM: Integer;//max number of modes - const - 4 is usually enough
	    bShadowDetection: Integer;//do shadow detection
	    fTau: float;
	    nNBands: Integer;//only RGB now ==3
	    nWidth,//image size
	    nHeight,
	    nSize: Integer;
	    rGMM: pCvPBGMMGaussian;
	    rnUsedModes: pByte;//number of Gaussian components per pixel
	    bRemoveForeground: Boolean;
    End;

    cvGPUVersion = Record
    	majorVersion,
      minorVersion: Integer;
    End;

    pCvBlob = ^CvBlob;
    CvBlob = Record
      x,y: float; //* blob position   */
      w,h: float; //* blob sizes      */
      ID: Integer;  //* blob ID         */
    End;

    pCvBlobTrack = ^CvBlobTrack;
    CvBlobTrack = Record
      TrackID, StartFrame: Integer;
      pBlobSeq: Pointer;
    End;

    PPcvLSH = ^PCvLSH;
    PCvLSH = ^CvLSH;
    CvLSH = record
      typeValue : Integer;
      u_union : Pointer;  //lsh_pstable_l2_32f or lsh_pstable_l2_64f;
    end;

    _uniondata = record
      case Integer of
        0 : (ptr : PArrayUChar);
        1 : (s : PArraySmallInt);
        2 : (i : PArrayInteger);
        3 : (fl : PArraySingle);
        4 : (db : PArrayDouble);
      end;

     pCv32Suf = ^Cv32Suf;
     Cv32Suf = Record
       i: integer;
       u: Cardinal;
       f: float;
     End;

    // -------------------------cvPoint------------------------
    CvPoint2D32f = record
       X: Single;
       Y: Single;
    end;
    TCvPoint2D32f = CvPoint2D32f;
    pCvPoint2D32f = ^TCvPoint2D32f;
    TCvPoint2D32fArr=array of TCvPoint2D32f;
    TCvPoint2D32fArr4=array [0..4] of TCvPoint2D32f;

    CvPoint3D32f = record
        X: Single;
        Y: Single;
        Z: Single;
    end;
    TCvPoint3D32f = CvPoint3D32f;
    PCvPoint3D32f = ^TCvPoint3D32f;
    TCvPoint3D32fArr=array of TCvPoint3D32f;

    pCvPoint = ^CvPoint;
    p2pCvPoint = ^pCvPoint;
    CvPoint = record
       X: longint;
       Y: longint;
    end;

  CONST CVPOINT0: CvPoint = (X: 0; Y: 0;);

  TYPE
    pCvPointArray = ^TCvPointArray;
    TCvPointArray = array[0..65535] of CvPoint;

    PCvPoint2D64f = ^CvPoint2D64f;
    CvPoint2D64f = record
       X: double;
       Y: double;
    end;

    PCvPoint3D64f = ^CvPoint3D64f;
    CvPoint3D64f = record
       X: double;
       Y: double;
       Z: double;
    end;

    // -------------------------cvSize------------------------
    CvSize = record
       Width: integer;
       Height: integer;
    end;
    TCvSize = CvSize;
    PCvSize = ^TCvSize;

    CvSize2D32f = record
       Width: Float;
       Height: Float;
    end;

    //------------------------CvBox2D----------------------
    pCvBox2D = ^CvBox2D;
    CvBox2D = Record
      center: CvPoint2D32f;  //* Center of the box.                          */
      size: CvSize2D32f;    //* Box width and length.                       */
      angle: float;          //* Angle between the horizontal axis and the first side (i.e. length) in degrees */
    End;

    // -------------------------cvRect------------------------
    p2pCvRect = ^pCvRect;
    pCvRect = ^cvRect;
    CvRect = record
       X: integer;
       Y: integer;
       Width: integer;
       Height: integer;
    end;

    // -------------------------cvScalar------------------------
    pCvScalar = ^CvScalar;
    CvScalar = record
       val: array[0..3] of double;
    end;

    // -------------------------CvTermCriteria------------------------
  CONST
    CV_TERMCRIT_ITER = 1;
    CV_TERMCRIT_NUMB = CV_TERMCRIT_ITER;
    CV_TERMCRIT_EPS  = 2;

  TYPE
    CvTermCriteria  = Record
      Type_: integer;  { may be combination of CV_TERMCRIT_ITER, CV_TERMCRIT_EPS }
      MaxIter: integer;
      Epsilon: double;
    end;
    PCvTermCriteria = ^CvTermCriteria;
    TCvTermCriteria = CvTermCriteria;

    // -------------------------CvMat------------------------
    {CvMat = record
      Type_: Integer;
      Step: Integer;
      Refcount: PInteger;
      Hdr_refcount: integer;
      Rows, Width: Integer;
      Cols, Height: Integer;
      Ptr: PUCHAR;
      S: PSmallInt ;
      I: pInteger;
      Fl: pFloat;
      Db: pDouble;
    end;
    }
    CvMat = record
      _type: Integer;
      step: Integer;
      refcount: pInteger; // for internal use only
      hdr_refcount: Integer;  // for internal use only
      data: Pointer;
      rows: Integer;
      cols: Integer;
    end;

    TCvMat = CvMat;
    pCvMat = ^TCvMat;
    p2pCvMat = ^pCvMat;
    p3pCvMat = ^p2pCvMat;
    
    PCvMatr32f = PSingle;
    TCvMatr32fArr=array of Single;

    CvDistanceFunction = function(const a: PSingle; const b: PSingle; user_param: Pointer): Single; CDECL;

    // -------------------------CvMatND------------------------
  CONST
    CV_MATND_MAGIC_VAL = $42430000;
    CV_TYPE_NAME_MATND = 'opencv-nd-matrix';
    CV_MAX_DIM = 32;
    CV_MAX_DIM_HEAP = 1 shl 16;

  TYPE
    pCvMatND = ^CvMatND;
    p2pCvMatND =^pCvMatND;
    CvMatND = record
      _type: longint;
      dims: longint;
      refcount: ^longint;
      data: record
      case longint of
         0: (ptr: ^uchar);
         1: (fl: ^double);
         2: (db: ^double);
         3: (i: ^longint);
         4: (s: ^smallint);
      end;
      dim: array[0..(CV_MAX_DIM)-1] of record
         size: longint;
         step: longint;
      end;
    end;

    PCvNArrayIterator = ^CvNArrayIterator;
    CvNArrayIterator = record
      count : Integer; // number of arrays */
      dims : Integer;  // number of dimensions to iterate */
      size : CvSize;   //* maximal common linear size: { width = size, height = 1 } */
      ptr : array[0..CV_MAX_ARR-1] of PByte;  //* pointers to the array slices */
      stack : array[0..CV_MAX_DIM-1] of Integer; //* for internal use */
      hdr : array[0..CV_MAX_ARR - 1] of PCvMatND; { pointers to the headers of the matrices that are processed }
    end;

    //------------------------------------CvSeq--------------------------
    PCvSeqBlock = ^CvSeqBlock;
    p2pCvSeqBlock = ^pCvSeqBlock;
    CvSeqBlock = record
      prev: PCvSeqBlock;
      next: PCvSeqBlock;
      start_index: longint;
      count: longint;
      data: Pchar;
    end;

    //------------------CvMemStorage------------------------
    PCvMemBlock = ^TCvMemBlock;
    CvMemBlock = Record
      prev: PCvMemBlock;
      next: PCvMemBlock;
    end;
    TCvMemBlock = CvMemBlock;

  CONST
    CV_STORAGE_MAGIC_VAL = $42890000;

  TYPE
    PCvMemStorage = ^TCvMemStorage;
    p2pCvMemStorage = ^pCvMemStorage;
    CvMemStorage = Record
      signature: integer;
      bottom: PCvMemBlock;   //* first allocated block */
      top: PCvMemBlock;   //* current memory block - top of the stack */
      parent: PCvMemStorage; //* borrows new blocks from */
      block_size: integer;       //* block size */
      free_space: integer;       //* free space in the current block */
    end;
    TCvMemStorage = CvMemStorage;

    pCvMemStoragePos = ^CvMemStoragePos;
    CvMemStoragePos = Record
      top: pCvMemBlock;
      free_space: Integer;
    End;
    TCvMemStoragePos= CvMemStoragePos;

    PCvSeq = ^CvSeq;
    P2pCvSeq = ^pCvSeq;
    PCvSeqArr = ^TCvSeqArr;
    TCvSeqArr = array[0..65535] of CvSeqBlock;

    CvSeq = record
      flags: longint;
      header_size: longint;
      h_prev: PCvSeq;
      h_next: PCvSeq;
      v_prev: PCvSeq;
      v_next: PCvSeq;
      total: longint;
      elem_size: longint;
      block_max: Pchar;
      ptr: Pchar;
      delta_elems: longint;
      storage: PCvMemStorage;
      free_blocks: PCvSeqBlock;
      first: PCvSeqBlock;
    end;

    //----------------------CvSet--------------------------
    pCvSetElem = ^CvSetElem;
    p2pCvSetElem = ^pCvSetElem;
    CvSetElem = Record
      flags: Integer; // it is negative if the node is free and zero or positive otherwise
      next_free: pCvSetElem; // if the node is free, the field is a pointer to next free node
    End;
    TCvSetElem = CvSetElem;

    pCvSet = ^CvSet;
    CvSet = Record
      flags: longint;
      header_size: longint;
      h_prev: PCvSeq;
      h_next: PCvSeq;
      v_prev: PCvSeq;
      v_next: PCvSeq;
      total: longint;
      elem_size: longint;
      block_max: Pchar;
      ptr: Pchar;
      delta_elems: longint;
      storage: PCvMemStorage;
      free_blocks: PCvSeqBlock;
      first: PCvSeqBlock;
      free_elems: pCvSetElem;
      active_count: Integer;
    End;
    TCvSet = CvSet;

    //-------------------------------cvSparseMat-------------------

    PPCvSparseMat = ^PCvSparseMat;
    PCvSparseMat = ^CvSparseMat;
    CvSparseMat = record
      typeOf : Integer;
      dims : Integer;
      refcount : PInteger;
      hdr_refcount : Integer;
      heap : PCvSet;
      hashtable: pPointer;
      hashsize, valoffset, idxoffset : Integer;
      size : array [0..CV_MAX_DIM-1] of Integer;
    end;

    PCvSparseNode = ^CvSparseNode;
    CvSparseNode = record
      hashval : UInt32;
      next : PCvSparseNode;
    end;

    PCvSparseMatIterator = ^CvSparseMatIterator;
    CvSparseMatIterator = record
      mat : PCvSparseMat;
      node: PCvSparseNode;
      curidx : Integer;
    end;

    // -------------------------IplImage------------------------
    PIplImage = ^TIplImage; // defined later
    P2PIplImage = ^PIplImage;

    TIplCallBack = procedure(const Img: PIplImage; XIndex, YIndex: Integer; Mode: Integer); stdcall;

    PIplTileInfo = ^TIplTileInfo;
    TIplTileInfo = record
      CallBack: TIplCallBack; // callback function
      Id: Pointer;      // additional identification field
      TileData: PByte;        // pointer on tile data
      Width: Integer;      // width of tile
      Height: Integer;      // height of tile
    end;

    PIplROI = ^TIplROI;
    TIplROI = record
      Coi: Integer;
      XOffset: Integer;
      YOffset: Integer;
      Width: Integer;
      Height: Integer;
    end;

    TIplImage = record
      NSize: Integer;                 // size of iplImage struct
      ID: Integer;                 // version
      NChannels: Integer;
      AlphaChannel: Integer;
      Depth: Integer;                 // pixel depth in bits
      ColorModel: array [0..3] of Char;
      ChannelSeq: array [0..3] of Char;
      DataOrder: Integer;
      Origin: Integer;
      Align: Integer;                 // 4 or 8 byte align
      Width: Integer;
      Height: Integer;
      Roi: PIplROI;
      MaskROI: PIplImage;               // poiner to maskROI if any
      ImageId: Pointer;                 // use of the application
      TileInfo: PIplTileInfo;            // contains information on tiling
      ImageSize: Integer;                 // useful size in bytes
      ImageData: PByte;                   // pointer to aligned image
      WidthStep: Integer;                 // size of aligned line in bytes
      BorderMode: array [0..3] of Integer;
      BorderConst: array [0..3] of Integer;
      ImageDataOrigin: PByte;                   // ptr to full, nonaligned image
    end;

    // -------------------------cvArr------------------------
    PCvArr = Pointer;
    P2PCvArr = ^PCvArr;

        //-----------------------------CvSlice-------------------------
    CvSlice = Record
      start_index, end_index: Integer;
    end;
    TCvSlice = CvSlice;

    //---------------------------CvGraph----------------------
  CONST
    CV_GRAPH_ALL_ITEMS = -1;

  TYPE
    pCvGraphEdge = ^CvGraphEdge;
    p2pCvGraphEdge = ^pCvGraphEdge;
    pCvGraphVtx = ^CvGraphVtx;
    p2pCvGraphVtx = ^pCvGraphVtx;
    
    CvGraphVtx = Record
      flags: Integer; //* vertex flags
      first: pCvGraphEdge; //* the first incident edge
    End;

    CvGraphEdge = Record
      flags: Integer; //* edge flags
      weight: float; //* edge weight
      next: array [0..2] of pCvGraphEdge; //* the next edges in the incidence lists for staring (0) */ /* and ending (1) vertices */ \
      vtx: Array [0..2] of pCvGraphVtx; //* the starting (0) and ending (1) vertices */
    End;

    p2pCvGraph = ^pCvGraph;
    pCvGraph = ^CvGraph;
    CvGraph = Record
      flags: longint;
      header_size: longint;
      h_prev: PCvSeq;
      h_next: PCvSeq;
      v_prev: PCvSeq;
      v_next: PCvSeq;
      total: longint;
      elem_size: longint;
      block_max: Pchar;
      ptr: Pchar;
      delta_elems: longint;
      storage: PCvMemStorage;
      free_blocks: PCvSeqBlock;
      first: PCvSeqBlock;
      free_elems: pCvSetElem;
      active_count: Integer;
      edges: pCvSet;
    End;
    TCvGraph = CvGraph;

    pCvGraphScanner = ^CvGraphScanner;
    p2pCvGraphScanner = ^pCvGraphScanner;
    CvGraphScanner = Record
      vtx: pCvGraphVtx; //* current graph vertex (or current edge origin) */
      dst: pCvGraphVtx; //* current graph edge destination vertex */
      edge: pCvGraphEdge; //* current edge */
      graph: pCvGraph; //* the graph */
      stack: pCvSeq; //* the graph vertex stack */
      index: Integer; //* the lower bound of certainly visited vertices */
      mask: Integer; //* event mask */
    End;

    PPCvLineIterator = ^PCvLineIterator;
    PCvLineIterator = ^CvLineIterator;
    CvLineIterator = record
      //* Pointer to the current point: */
      ptr : PUCHAR;
      //* Bresenham algorithm state: */
      err,
      plus_delta,
      minus_delta,
      plus_step,
      minus_step : Integer;
    end;

    //-------------------------CvTreeNodeIterator---------------------
    pCvTreeNodeIterator = ^CvTreeNodeIterator;
    CvTreeNodeIterator = Record
      node: Pointer;
      level, max_level: Integer;
    End;
    TCvTreeNodeIterator = CvTreeNodeIterator;

    {_BaseTreeNode = Record
       flags: Integer; //* micsellaneous flags */ \
       header_size: Integer; //* size of sequence header */ \
       struct node_type* h_prev; /* previous sequence */ \
       struct node_type* h_next; /* next sequence */ \
       struct node_type* v_prev; /* 2nd previous sequence */ \
       struct node_type* v_next; /* 2nd next sequence */
    End;}

    //------------------------CvSeqWrite--------------------------
    P2PCvSeqWriter = ^PCvSeqWriter;
    PCvSeqWriter = ^CvSeqWriter;
    CvSeqWriter = Record
      header_size: Integer;
      seq: pCvSeq;        //* the sequence written */            \
      block: pCvSeqBlock;      //* current block */
      ptr,        //* pointer to free space */
      block_min,  //* pointer to the beginning of block*
      block_max: pChar;  //* pointer to the end of block /
    End;

    //------------------------CvSeqRead--------------------------
    PCvSeqReader = ^CvSeqReader;
    CvSeqReader = Record
      header_size: Integer;
      seq: pCvSeq;        //* sequence, beign read */             \
      block: pCvSeqBlock;      //* current block */                    \
      ptr,        //* pointer to element be read next */  \
      block_min,  //* pointer to the beginning of block */\
      block_max: pChar;  //* pointer to the end of block */      \
      delta_index: integer; //* = seq->first->start_index   */      \
      prev_elem: pChar;  //* pointer to previous element */
    End;

    //-----------------------------cvString------------------------
    CvString = record
      len: integer;
      ptr: pChar;
    end;

    //--------------------CvFont-------------------------------
    pCvFont = ^CvFont;
    CvFont = Record
  	  nameFont: pChar;		//Qt:nameFont
	    color: CvScalar;				//Qt:ColorFont -> cvScalar(blue_component, green_component, red\_component[, alpha_component])
      font_face: Integer; 		//Qt: bool italic         /* =CV_FONT_* */
      ascii: pInteger; 			//* font data and metrics */
      greek: pInteger;
      cyrillic: pInteger;
      hscale, vscale: float;
      shear: float; 			//* slope coefficient: 0 - normal, >0 - italic */
      thickness: Integer; 		//Qt: weight               /* letters thickness */
      dx: float; 			//* horizontal interval between letters */
      line_type: Integer;		//Qt: PointSize
    End;

    //-----------------------------ErrorCallBack--------------
    CvErrorCallback = Procedure(status: integer; const func_name: pChar; const err_msg: pChar; const file_name: pChar; line: Integer);

    //-----------------------CvPluginFuncInfo------------------
    pCvPluginFuncInfo = ^CvPluginFuncInfo;
    CvPluginFuncInfo = record
      func_addr: pPointer;
      default_func_addr: Pointer;
      func_names: pChar;
      search_modules, loaded_from: Integer;
    End;

    pCvModuleInfo = ^CvModuleInfo;
    CvModuleInfo = record
      //struct CvModuleInfo* next;
      cname: pChar;
      version: pChar;
      func_tab: pCvPluginFuncInfo;
    End;

    //--------------------------CvHistogramme--------------------
    pCvHistogram = ^CvHistogram;
    p2pCvHistogram = ^pCvHistogram;
    CvHistogram = record
      type_: Integer;
      bins: pCvArr;
      thresh: array[0..CV_MAX_DIM, 0..2] of float; //* for uniform histograms */
      thresh2: p2pFloat; //* for non-uniform histograms */
      mat: CvMatND; //* embedded matrix header for array histograms */
    End;

    //------------ IplConvKernel------------------
    pIplConvKernel = ^IplConvKernel;
    p2pIplConvKernel = ^pIplConvKernel;
    IplConvKernel = record
      nCols, nRows,
      anchorX, anchorY: Integer;
      values: pInteger;
      nShiftR: Integer;
    end;

    pIplConvKernelFP = ^IplConvKernelFP;
    IplConvKernelFP = record
      nCols, nRows,
      anchorX, anchorY: Integer;
      values: pFloat;
    End;

    //------------------------- CvConnectedComp--------------
    pCvConnectedComp = ^CvConnectedComp;
    CvConnectedComp = Record
      area: double; //* area of the segmented component */
      value: CvScalar; //* average color of the connected component */
      rect: CvRect; //* ROI of the segmented component */
      contour: pCvSeq; //* optional component boundary (the contour might have child contours corresponding to the holes) */
    End;

    //----------------CvConvexityDefect--------------------
    CvConvexityDefect = Record
      start: pCvPoint; //* point of the contour where the defect begins */
      end_: pCvPoint; //* point of the contour where the defect ends */
      depth_point: pCvPoint; //* the farthest from the convex hull point within the defect */
      depth: float; //* distance between the farthest point and the convex hull */
    End;

    //---------------------CvContourTree------------------
    pCvContourTree = ^CvContourTree;
    CvContourTree = Record
      flags: longint;
      header_size: longint;
      h_prev: PCvSeq;
      h_next: PCvSeq;
      v_prev: PCvSeq;
      v_next: PCvSeq;
      total: longint;
      elem_size: longint;
      block_max: Pchar;
      ptr: Pchar;
      delta_elems: longint;
      storage: PCvMemStorage;
      free_blocks: PCvSeqBlock;
      first: PCvSeqBlock;
      p1, p2: CvPoint;            //* the first point of the binary tree root segment */
    End;

    //-------------------CvContour------------------------
    PCvContour = ^CvContour;
  CvContour = record
    //CV_TREE_NODE_FIELDS
    flags : Integer;  ///* Miscellaneous flags.     */
    header_size : Integer; //Size of sequence header. */      \
    h_prev : PCvContour; //* Previous Contouruence.       */      \
    h_next : PCvContour; //* Next Contouruence.           */      \
    v_prev : PCvContour; //* 2nd previous Contouruence.   */      \
    v_next : PCvContour; // /* 2nd next Contouruence.       */
    //CV_SEQUENCE_FIELDS
    total : Integer;          //* Total number of elements.            */  \
    elem_size : Integer;      //* Size of Contouruence element in bytes.   */  \
    block_max : pschar;      //* Maximal bound of the last block.     */  \
    ptr : pschar;            //* Current write pointer.               */  \
    delta_elems : Integer;    //* Grow seq this many at a time.        */  \
    storage : PCvMemStorage;    //* Where the seq is stored.             */  \
    free_blocks : PCvSeqBlock;  //* Free blocks list.                    */  \
    first : PCvSeqBlock;        //* Pointer to the first sequence block. */
    //----------------------
    rect : CvRect;
    color : Integer;
    reserved : array[0..2] of Integer;
  end;

    PCvContourInfo = ^_CvContourInfo;
    _CvContourInfo = record
      flags : Integer;
      next : PCvContourInfo;        //* next contour with the same mark value */
      parent : PCvContourInfo;      //* information about parent contour */
      contour : PCvSeq;             //* corresponding contour (may be 0, if rejected) */
      rect : CvRect;                //* bounding rectangle */
      origin : CvPoint;             //* origin point (where the contour was traced from) */
      is_hole : Integer;
    end;

    PCvContourScanner = ^_CvContourScanner;
    CvContourScanner = _CvContourInfo;
    _CvContourScanner = record
      storage1 : PCvMemStorage;     // contains fetched contours */
      storage2 : PCvMemStorage;     // contains approximated contours
                                 //  (!=storage1 if approx_method2 != approx_method1) */
      cinfo_storage : PCvMemStorage;        // contains _CvContourInfo nodes */
      cinfo_set : PCvSet;           // set of _CvContourInfo nodes */
      initial_pos : CvMemStoragePos;        // starting storage pos */
      backup_pos : CvMemStoragePos; // beginning of the latest approx. contour */
      backup_pos2 : CvMemStoragePos;        // ending of the latest approx. contour */
      img0 : PByte; //schar               // image origin */
      img : PByte;  //schar               // current image row */
      img_step : Integer;               // image step */
      img_size : CvSize;            // ROI size */
      offset : CvPoint;             // ROI offset: coordinates, added to each contour point */
      pt : CvPoint;                 // current scanner position */
      lnbd : CvPoint;               // position of the last met contour */
      nbd : Integer;                    // current mark val */
      l_cinfo : _CvContourInfo;    // information about latest approx. contour */
      cinfo_temp : _CvContourInfo;  // temporary var which is used in simple modes */
      frame_info : _CvContourInfo;  // information about frame */
      frame : CvSeq;                // frame itself */
      approx_method1 : Integer;         // approx method when tracing */
      approx_method2 : Integer;         // final approx method */
      mode : Integer;                   // contour scanning mode:
                                //   0 - external only
                                //   1 - all the contours w/o any hierarchy
                                //   2 - connected components (i.e. two-level structure -
                                //   external contours and holes) */
      subst_flag : Integer;
      seq_type1 : Integer;              // type of fetched contours */
      header_size1 : Integer;           // hdr size of fetched contours */
      elem_size1 : Integer;             // elem size of fetched contours */
      seq_type2 : Integer;              //                                       */
      header_size2 : Integer;           //        the same for approx. contours  */
      elem_size2 : Integer;             //                                       */
      cinfo_table : array[0..125] of PCvContourInfo;
    end;

    //--------------------------CvMoments------------------------
    pCvMoments = ^CvMoments;
    CvMoments = Record
      m00, m10, m01, m20, m11, m02, m30, m21, m12, m03: double; //* spatial moments */
      mu20, mu11, mu02, mu30, mu21, mu12, mu03: double; //* central moments */
      inv_sqrt_m00: double; //* m00 != 0 ? 1/sqrt(m00) : 0 */
    End;

    pCvHuMoments = ^CvHuMoments;
    CvHuMoments = Record //* Hu invariants */
      hu1, hu2, hu3, hu4, hu5, hu6, hu7: double; //* Hu invariants */
    End;
    
    //------------------------CvChain--------------------------
    pCvChain = ^CvChain;
    CvChain = Record
      flags: longint;
      header_size: longint;
      h_prev: PCvSeq;
      h_next: PCvSeq;
      v_prev: PCvSeq;
      v_next: PCvSeq;
      total: longint;
      elem_size: longint;
      block_max: Pchar;
      ptr: Pchar;
      delta_elems: longint;
      storage: PCvMemStorage;
      free_blocks: PCvSeqBlock;
      first: PCvSeqBlock;
      origin: CvPoint;
    End;

    PCvChainPtReader = ^CvChainPtReader;
    CvChainPtReader = record
      //CV_SEQ_READER_FIELDS()
      header_size : Integer;
      seq : PCvSeq;                  //* sequence, beign read
      block : PCvSeqBlock;            //    /* current block
      ptr      : pschar;            //* pointer to element be read next
      block_min : pschar;            //* pointer to the beginning of block
      block_max : pschar;            //* pointer to the end of block
      delta_index : Integer;         //* = seq->first->start_index
      prev_elem : pschar;            //* pointer to previous element
      //---------------
      code : char;
      pt : CvPoint;
      deltas : array[0..7] of array[0..1] of PByte;
    end;

    //---------------------CvSubdiv2------------------------
    p2pCvSubdiv2DEdge = ^pCvSubdiv2DEdge;
    pCvSubdiv2DEdge = ^CvSubdiv2DEdge;
    CVSubDiv2DEdge = UINT;  //typedef size_t CvSubdiv2DEdge ??????????????????/

    pCvSubdiv2D = ^CvSubdiv2D;
    CvSubdiv2D = Record
      flags: longint;
      header_size: longint;
      h_prev: PCvSeq;
      h_next: PCvSeq;
      v_prev: PCvSeq;
      v_next: PCvSeq;
      total: longint;
      elem_size: longint;
      block_max: Pchar;
      ptr: Pchar;
      delta_elems: longint;
      storage: PCvMemStorage;
      free_blocks: PCvSeqBlock;
      first: PCvSeqBlock;
      free_elems: pCvSetElem;
      active_count: Integer;
      edges: pCvSet;
      quad_edges: Integer;
      is_geometry_valid: Integer;
      //recent_edge: CvSubdiv2DEdge;
      topleft: CvPoint2D32f;
      bottomright: CvPoint2D32f;
    End;

    PPCvSubdiv2DPoint = ^PCvSubdiv2DPoint;
    PCvSubdiv2DPoint = ^CvSubdiv2DPoint;
    CvSubdiv2DPoint = record
      //CV_SUBDIV2D_POINT_FIELDS()
      flags: Integer;
      first: CvSubdiv2DEdge;
      pt: CvPoint2D32f;
    end;

    //enum
    CvSubdiv2DPointLocation = (CV_PTLOC_ERROR = -2,
                               CV_PTLOC_OUTSIDE_RECT = -1,
                               CV_PTLOC_INSIDE = 0,
                               CV_PTLOC_VERTEX = 1,
                               CV_PTLOC_ON_EDGE = 2);

    //---------------------CvSurPoint------------------------
    pCvSURFPoint = ^CvSURFPoint;
    CvSURFPoint = Record
      pt: CvPoint2D32f; // position of the feature within the image
      laplacian: integer; // -1, 0 or +1. sign of the laplacian at the point.
      // can be used to speedup feature comparison
      // (normally features with laplacians of different
      // signs can not match)
      size: integer; // size of the feature
      dir: float; // orientation of the feature: 0..360 degrees
      hessian: float; // value of the hessian (can be used to
      // approximately estimate the feature strengths;
      // see also params.hessianThreshold)
    end;

    PCvSURFParams = ^CvSURFParams;
    CvSURFParams = record
      extended: integer;
      hessianThreshold: double;
      nOctaves: integer;
      nOctaveLayers: integer;
    end;


    PCvMSERParams = ^CvMSERParams;

    CvMSERParams = record
      // delta, in the code, it compares (size_{i}-size_{i-delta})/size_{i-delta}
      delta : Integer;
      // prune the area which bigger/smaller than max_area/min_area
      maxArea : Integer;
      minArea : Integer;
      // prune the area have simliar size to its children
      maxVariation : single;
      // trace back to cut off mser with diversity < min_diversity
      minDiversity : single;
      //* the next few params for MSER of color image */
      // for color image, the evolution steps
      maxEvolution : Integer;
      // the area threshold to cause re-initialize
      areaThreshold : double;
      // ignore too small margin
      minMargin : double;
      // the aperture size for edge blur
      edgeBlurSize : Integer;
    end;

    //----------------------CvStarDetectorParams--------------
    CvStarDetectorParams = record
      maxSize: integer; // maximal size of the features detected. The following
      // values of the parameter are supported:
      // 4, 6, 8, 11, 12, 16, 22, 23, 32, 45, 46, 64, 90, 128
      responseThreshold: integer; // threshold for the approximatd laplacian,
      // used to eliminate weak features
      lineThresholdProjected: integer; // another threshold for laplacian to
      // eliminate edges
      lineThresholdBinarized: integer; // another threshold for the feature
      // scale to eliminate edges
      suppressNonmaxSize: integer; // linear size of a pixel neighborhood
      // for non-maxima suppression
    end;

    //-------------------------------Cascade Classification--------------
    CvHaarFeatureData = record
      r: cvRect;
      weight: float;
    end;

    pCvHaarFeature = ^CvHaarFeature;
    CvHaarFeature = record
      tilted: integer;
      rect: array [0..CV_HAAR_FEATURE_MAX-1] of CvHaarFeatureData;
    end;

    pCvHaarClassifier = ^CvHaarClassifier;
    CvHaarClassifier = record
      count: integer;
      haar_feature: pCvHaarFeature;
      threshold: pFloat;
      left: pInteger;
      right: pInteger;
      alpha: pFloat;
    end;

    CvHaarStageClassifier = record
      count: integer;
      threshold: float;
      classifier: pCvHaarClassifier;
      next, child, parent: integer;
    end;

    CvHidHaarClassifierCascade = record end;

    pCvHaarStageClassifier  = ^CvHaarStageClassifier;
    pCvHaarClassifierCascade = ^CvHaarClassifierCascade ;
    p2pCvHaarClassifierCascade = ^pCvHaarClassifierCascade;
    CvHaarClassifierCascade = record
      flags ,count: integer;
      orig_window_size: CvSize;
      real_window_size: CvSize;
      scale: double;
      stage_classifier: pCvHaarStageClassifier;
      hid_cascade: CvHidHaarClassifierCascade;
    end;

    CvAvgComp = record
      rect: cvRect;
      neighbors: integer;
    end;

    pCvAttrList = ^CvAttrList;
    CvAttrList = record
      attr: pChar; //* NULL-terminated array of (attribute_name,attribute_value) pairs */
      next: pCvAttrList; //* pointer to next chunk of the attributes list */
    end;

  CONST ZeroCvAttrList: CvAttrList = (attr: nil; next: nil);

  TYPE
    //---------------- CvConDensation-----------------------
    pCvRNG = ^CvRNG;
    CvRNG = Int64; //typedef uint64 CvRNG;

    pCvRandState = ^CvRandState;
    CvRandState = record
      state: CvRNG;    //* RNG state (the current seed and carry)*/
      disttype: integer; //* distribution type */
      param: array [0..2] of CvScalar; //* parameters of RNG */
    End;

    pCvConDensation = ^CvConDensation;
    p2pCvConDensation = ^pCvConDensation;
    CvConDensation = record
      MP: integer; //Dimension of measurement vector
      DP: integer; // Dimension of state vector
      DynamMatr: pFloat; // Matrix of the linear Dynamics system
      State: pFloat; // Vector of State
      SamplesNum: integer; // Number of the Samples
      flSamples: p2pFloat; // array of the Sample Vectors
      flNewSamples: p2pfloat; // temporary array of the Sample Vectors
      flConfidence: pfloat; // Confidence for each Sample
      flCumulative: pfloat; // Cumulative confidence
      Temp: pfloat; // Temporary vector
      RandomSample: pfloat; // RandomVector to update sample set
      RandS: pCvRandState; // Array of structures to generate random vectors
    End;

    //-------------------TrackBar----------------------------
    CvTrackbarCallback = procedure(pos: integer); cdecl;
    CvTrackbarCallback2 = procedure(pos : Integer; userdata : Pointer); cdecl;
    CvMouseCallback = procedure (event, x, y, flags: integer; param: pointer); cdecl;
    CvWin32WindowCallback = function(hwnd : THandle; msg : UInt32; wParam, lParam : Word; value : PInteger) : Integer; cdecl;
    CvButtonCallback = Procedure (state: Integer; userdata: Pointer); cdecl;
    CvOpenGLCallback = Procedure (userdata: Pointer); cdecl;
    //---------------------Capture Video & Photo----------------
    CvCapture = record
    end;
    PCvCapture = ^CvCapture;
    P2PCvCapture = ^PCvCapture;

    //----------------CvVideoWrite-------------------------
    CvVideoWriter = Record
    End;
    pCvVideoWriter = ^CvVideoWriter;
    p2pCvVideoWriter = ^pCvVideoWriter;

    //-------------------------------Kalman------------------------------
    p2pCvKalman = ^pCvKalman;
    pCvKalman = ^CvKalman;
    CvKalman = record
      MP: Integer;                     { number of measurement vector dimensions }
      DP: Integer;                     { number of state vector dimensions }
      CP: Integer;                     { number of control vector dimensions }
//    { backward compatibility fields }
//#if 1
//    float* PosterState;         { =state_pre->data.fl }
//    float* PriorState;          { =state_post->data.fl }
//    float* DynamMatr;           { =transition_matrix->data.fl }
//    float* MeasurementMatr;     { =measurement_matrix->data.fl }
//    float* MNCovariance;        { =measurement_noise_cov->data.fl }
//    float* PNCovariance;        { =process_noise_cov->data.fl }
//    float* KalmGainMatr;        { =gain->data.fl }
//    float* PriorErrorCovariance;{ =error_cov_pre->data.fl }
//    float* PosterErrorCovariance;{ =error_cov_post->data.fl }
//    float* Temp1;               { temp1->data.fl }
//    float* Temp2;               { temp2->data.fl }
//#endif

      state_pre: PCvMat;           { predicted state (x'(k)):
                                    x(k)=A*x(k-1)+B*u(k) }
      state_post: PCvMat;          { corrected state (x(k)):
                                    x(k)=x'(k)+K(k)*(z(k)-H*x'(k)) }
      transition_matrix: PCvMat;   { state transition matrix (A) }
      control_matrix: PCvMat;      { control matrix (B)
                                   (it is not used if there is no control)}
      measurement_matrix: PCvMat;  { measurement matrix (H) }
      process_noise_cov: PCvMat;   { process noise covariance matrix (Q) }
      measurement_noise_cov: PCvMat; { measurement noise covariance matrix (R) }
      error_cov_pre: PCvMat;       { priori error estimate covariance matrix (P'(k)):
                                    P'(k)=A*P(k-1)*At + Q)}
      gain: PCvMat;                { Kalman gain matrix (K(k)):
                                    K(k)=P'(k)*Ht*inv(H*P'(k)*Ht+R)}
      error_cov_post: PCvMat;      { posteriori error estimate covariance matrix (P(k)):
                                    P(k)=(I-K(k)*H)*P'(k) }
      temp1: PCvMat;               { temporary matrices }
      temp2: PCvMat;
      temp3: PCvMat;
      temp4: PCvMat;
      temp5: PCvMat;
  end;

  pCvVectors = ^CvVectors;
  CvVectors = Record
    _type, dims, count: Integer;
    next: pCvVectors;
    data: _UnionData
  End;

  PCvGenericHash = ^CvGenericHash;
  PCvStringHash = PCvGenericHash;
  CvGenericHash = record
    //CV_TREE_NODE_FIELDS
    flags : Integer;  ///* Miscellaneous flags.     */
    header_size : Integer; //Size of sequence header. */      \
    h_prev : PCvGenericHash; //* Previous sequence.       */      \
    h_next : PCvGenericHash; //* Next sequence.           */      \
    v_prev : PCvGenericHash; //* 2nd previous sequence.   */      \
    v_next : PCvGenericHash; // /* 2nd next sequence.       */
    //CV_SEQUENCE_FIELDS
    total : Integer;          //* Total number of elements.            */  \
    elem_size : Integer;      //* Size of sequence element in bytes.   */  \
    block_max : pschar;      //* Maximal bound of the last block.     */  \
    ptr : pschar;            //* Current write pointer.               */  \
    delta_elems : Integer;    //* Grow seq this many at a time.        */  \
    storage : PCvMemStorage;    //* Where the seq is stored.             */  \
    free_blocks : PCvSeqBlock;  //* Free blocks list.                    */  \
    first : PCvSeqBlock;        //* Pointer to the first sequence block. */
    //CV_SET_FIELDS
    free_elems : PCvSetElem;
    active_count : Integer;
    //GenericHash
    tab_size : Integer;
    table : P2pPointer;
  end;
  CvStringHash = CvGenericHash;

  gzFileType = Pointer;

  P2PCvFileStorage = ^PCvFileStorage;
  PCvFileStorage = ^CvFileStorage;

  PCvFileNode = ^CvFileNode;

  //typedef int (CV_CDECL *CvIsInstanceFunc)( const void* struct_ptr );
  CvIsInstanceFunc = function(const struct_ptr: Pointer): Integer; cdecl;
  //typedef void (CV_CDECL *CvReleaseFunc)( void** struct_dblptr );
  CvReleaseFunc = procedure(struct_dblptr: pPointer); cdecl;
  //typedef void* (CV_CDECL *CvReadFunc)( CvFileStorage* storage, CvFileNode* node );
  CvReadFunc = function(storage: PCvFileStorage; node: PCvFileNode): Pointer; cdecl;
  //typedef void (CV_CDECL *CvWriteFunc)( CvFileStorage* storage, const char* name,
  //                                    const void* struct_ptr, CvAttrList attributes );
  CvWriteFunc = procedure(storage: PCvFileStorage; const name: PAnsiChar; const struct_ptr: Pointer; attributes : CvAttrList); cdecl;
  //typedef void* (CV_CDECL *CvCloneFunc)( const void* struct_ptr );
  CvCloneFunc = function(const struct_ptr: Pointer): Pointer; cdecl;

  PCvTypeInfo = ^CvTypeInfo;
  CvTypeInfo = record
    flags,
    header_size : Integer;
    prev, next : PCvTypeInfo;
    type_name : Pschar;
    is_instance : CvIsInstanceFunc;
    release : CvReleaseFunc;
    read : CvReadFunc;
    write : CvWriteFunc;
    clone : CvCloneFunc;
  end;

  CvFileNode = record
    tag : Integer;
    info : PCvTypeInfo; //* type information
                        // (only for user-defined object, for others it is 0)
    data_union : array[0..7] of byte;
//    union
//        double f; /* scalar floating-point number */
//        int i;    /* scalar integer number */
//        CvString str; /* text string */
//        CvSeq* seq; /* sequence (ordered collection of file nodes) */
//        CvFileNodeHash* map; /* map (collection of named file nodes) */
//    data;
    end;

  //typedef void (*CvStartWriteStruct)( struct CvFileStorage* fs, const char* key,
  //                                    int struct_flags, const char* type_name );
  CvStartWriteStructA = procedure(fs: PCvFileStorage; const key : LPCSTR;
                               struct_flags : Integer; const type_name : LPCSTR);cdecl;
  //typedef void (*CvEndWriteStruct)( struct CvFileStorage* fs );
  CvEndWriteStructA = procedure(fs : PCvFileStorage); cdecl;
  //typedef void (*CvWriteInt)( struct CvFileStorage* fs, const char* key, int value );
  CvWriteIntA = procedure(fs : PCvFileStorage; const key : LPCSTR; value : Integer); cdecl;
  //typedef void (*CvWriteReal)( struct CvFileStorage* fs, const char* key, double value );
  CvWriteRealA = procedure(fs : PCvFileStorage; const key : LPCSTR; value : double); cdecl;
  //typedef void (*CvWriteString)( struct CvFileStorage* fs, const char* key,
  //                               const char* value, int quote );
  CvWriteStringA = procedure(fs : PCvFileStorage; const key : LPCSTR; const value : LPCSTR; quote : Integer); cdecl;
  //typedef void (*CvWriteComment)( struct CvFileStorage* fs, const char* comment, int eol_comment );
  CvWriteCommentA = procedure(fs : PCvFileStorage; const comment : LPCSTR; eol_comment : Integer); cdecl;
  //typedef void (*CvStartNextStream)( struct CvFileStorage* fs );
  CvStartNextStreamA = procedure(fs : PCvFileStorage); cdecl;

  CvFileStorage = record
      flags, is_xml, write_mode, is_first : Integer;
      memstorage, dststorage, strstorage : PCvMemStorage;
      str_hash : PCvStringHash;
      roots, write_stack : PCvSeq;
      struct_indent, struct_flags : Integer;
      struct_tag : CvString;
      space : Integer;
      filename : LPCSTR;
      fileP : PInteger;
      gzfile : gzFileType;
      buffer, buffer_start, buffer_end : LPCSTR;
      wrap_margin, lineno, dummy_eof : Integer;
      errmsg : array of char;
      errmsgbuf : array[0..127] of char;
      //过程参数
      start_write_struct : CvStartWriteStructA;
      end_write_struct : CvEndWriteStructA;
      write_int : CvWriteIntA;
      write_real : CvWriteRealA;
      write_string : CvWriteStringA;
      write_comment : CvWriteCommentA;
      start_next_stream : CvStartNextStreamA;
  end;

  {PcvRng = ^CvRng;
  CvRNG = UInt64;

  PCvRandState = ^CvRandState;
  CvRandState = record
    state : CvRNG;    //* RNG state (the current seed and carry)*/
    disttype : Integer; //* distribution type */
    param : array[0..1] of CvScalar; //* parameters of RNG */
  end;}

  //* a < b ? -1 : a > b ? 1 : 0 */
  //typedef int (CV_CDECL* CvCmpFunc)(const void* a, const void* b, void* userdata );
  CvCmpFunc = function(const a: Pointer; const b: Pointer; userdata: Pointer): Integer; cdecl;
  //typedef void* (CV_CDECL *CvAllocFunc)(size_t size, void* userdata);
  CvAllocFunc = function(size : UINT32; userdata : Pointer) : Pointer; cdecl;
  //typedef int (CV_CDECL *CvFreeFunc)(void* pptr, void* userdata);
  CvFreeFunc = function(pptr : Pointer; userdata : Pointer) : Integer; cdecl;
  Cv_iplCreateImageHeader = function(int1, int2, int3 : Integer;
                                     ch1, ch2 : PAnsichar;
                                     int4, int5, int6, int7, int8 : Integer;
                                     roi : PIplROI;
                                     img : PIplImage;
                                     ptr : Pointer;
                                     info : PIplTileInfo) : PIplImage; stdcall;
  //typedef void (CV_STDCALL* Cv_iplAllocateImageData)(IplImage*,int,int);
  Cv_iplAllocateImageData = procedure(img : PIplImage; value1, value2 : Integer); stdcall;
  //typedef void (CV_STDCALL* Cv_iplDeallocate)(IplImage*,int);
  Cv_iplDeallocate = procedure(image : PIplImage; value : Integer); stdcall;
  //typedef IplROI* (CV_STDCALL* Cv_iplCreateROI)(int,int,int,int,int);
  Cv_iplCreateROI = function(v1, v2, v3, v4, v5 : Integer) : PIplROI;
  //typedef IplImage* (CV_STDCALL* Cv_iplCloneImage)(const IplImage*);
  Cv_iplCloneImage = function(const image : PIplImage) : PIplImage; stdcall;

  PCvStringHashNode = ^CvStringHashNode;
  CvStringHashNode = record
    hashval : UInt32;
    str : CvString;
    next : PCvStringHashNode;
  end;

  //  typedef IplImage* (CV_CDECL * CvLoadImageFunc)( const char* filename, int colorness );
  CvLoadImageFunc = function(const filename : PAnsiChar; colorness : Integer) : PIplImage; cdecl;
//  typedef CvMat* (CV_CDECL * CvLoadImageMFunc)( const char* filename, int colorness );
  CvLoadImageMFunc = function(const filename : PAnsiChar; colorness : Integer) : PCvMat; cdecl;
//  typedef int (CV_CDECL * CvSaveImageFunc)( const char* filename, const CvArr* image,
//                                            const int* params );
  CvSaveImageFunc = function(const filename : PAnsiChar; const image : PCvArr;
                             const params : PInteger) : Integer; cdecl;
//  typedef void (CV_CDECL * CvShowImageFunc)( const char* windowname, const CvArr* image );
  CvShowImageFunc = procedure(const windowname : PAnsiChar; const image : PCvArr); cdecl;
  //typedef int (CV_CDECL *CvErrorCallback)( int status, const char* func_name,
  //                  const char* err_msg, const char* file_name, int line, void* userdata );

  P2PCvPOSITObject = ^PCvPOSITObject;
  PCvPOSITObject = ^CvPOSITObject;
  CvPOSITObject = record
    N : Integer;
    inv_matr,
    obj_vecs,
    img_vecs : PSingle;
  end;

  CvVect32f = PSingle;
  CvMatr32f = PSingle;
  CvVect64d = PDouble;
  CvMatr64d = PDouble;

  P2PCvStereoBMState = ^PCvStereoBMState;
  PCvStereoBMState = ^CvStereoBMState;
	CvStereoBMState = record
    //pre filters (normalize input images):
    preFilterType 			: Integer; // 0 for now
    preFilterSize 			: Integer; // ?5x5..21x21
    preFilterCap 				: Integer; // up to ?31
    //correspondence using Sum of Absolute Difference (SAD):
    SADWindowSize 			: Integer; // Could be 5x5..21x21
    minDisparity 				: Integer; // minimum disparity (=0)
    numberOfDisparities : Integer; // maximum disparity - minimum disparity
    //post filters (knock out bad matches):
    textureThreshold 		: Integer; // areas with no texture are ignored
    uniquenessRatio 		: Integer;// filter out pixels if there are other close matches
    // with different disparity
    speckleWindowSize 	: Integer;// Disparity variation window (not used)
    speckleRange 				: Integer; // Acceptable range of variation in window (not used)
    trySmallerWindows   : Integer; // if 1, the results may be more accurate,
                                   // at the expense of slower processing
    // internal buffers, do not modify (!)
    preFilteredImg0 		: PCvMat;
    preFilteredImg1 		: PCvMat;
    slidingSumBuf 			: PCvMat;
    dbmin,
    dbmax        : PCvMat;
  end;

  P2PCvStereoGCState = ^PCvStereoGCState;
  PCvStereoGCState = ^CvStereoGCState;
  CvStereoGCState = record
    Ithreshold,
    interactionRadius : Integer;
    K, lambda, lambda1, lambda2 : Single;
    occlusionCost,
    minDisparity,
    numberOfDisparities,
    maxIters : Integer;
    left,
    right,
    dispLeft,
    dispRight,
    ptrLeft,
    ptrRight,
    vtxBuf,
    edgeBuf : PCvMat;
  end;

  PPCvEHMM = ^PCvEHMM;
  PCvEHMM = ^CvEHMM;
	CvEHMM = record
    level : Integer;  //* 0 - lowest(i.e its states are real states), ..... */
    num_states : Integer;   //* number of HMM states */
    transP : PSingle;   //*transition probab. matrices for states */
    obsProb : P2PSingle;  { if level == 0 - array of brob matrices corresponding to hmm
                        if level == 1 - martix of matrices }
    u_union : Pointer; { CvEHMMState* state; /* if level == 0 points to real states array,
                               if not - points to embedded hmms */
        struct CvEHMM* ehmm; /* pointer to an embedded model or NULL, if it is a leaf }
  end;

  PPCvImgObsInfo = ^PCvImgObsInfo;
  PCvImgObsInfo = ^CvImgObsInfo;
  CvImgObsInfo = record
    obs_x,
    obs_y,
    obs_size : Integer;
    obs : PSingle;  //consequtive observations
    state : PInteger; //* arr of pairs superstate/state to which observation belong */
    mix : PInteger;   //* number of mixture to which observation belong */
  end;
  Cv1DObsInfo = CvImgObsInfo;
  PCv1DObsInfo = PCvImgObsInfo;
  PPCv1DObsInfo = PPCvImgObsInfo;

  PPInteger = ^PInteger;

  PPCvCliqueFinder = ^PCvCliqueFinder;
  PCvCliqueFinder = ^CvCliqueFinder;
  CvCliqueFinder = record
    graph : PCvGraph;
    adj_matr : PPInteger;
    N : Integer; //graph size

    // stacks, counters etc/
    k : Integer; //stack size
    current_comp : PInteger;
    All : PPInteger;
    ne,
    ce,
    fixp, //node with minimal disconnections
    nod,
    s    : PInteger; //for selected candidate
    status,
    best_score,
    weighted,
    weighted_edges : Integer;
    best_weight : Single;
    edge_weights,
    vertex_weights,
    cur_weight,
    cand_weight : PSingle;
  end;

  CvGraphWeightType = (
    CV_NOT_WEIGHTED,
    CV_WEIGHTED_VTX,
    CV_WEIGHTED_EDGE,
    CV_WEIGHTED_ALL
  );

  PCvStereoLineCoeff = ^CvStereoLineCoeff;
  CvStereoLineCoeff = record
    Xcoef : double;
    XcoefA : double;
    XcoefB : double;
    XcoefAB : double;

    Ycoef : double;
    YcoefA : double;
    YcoefB : double;
    YcoefAB : double;

    Zcoef : double;
    ZcoefA : double;
    ZcoefB : double;
    ZcoefAB : double;
  end;

  PCvCamera = ^CvCamera;
  CvCamera = record
    imgSize : array[0..1] of single; //* size of the camera view, used during calibration */
    matrix : array[0..8] of single; //* intinsic camera parameters:  [ fx 0 cx; 0 fy cy; 0 0 1 ] */
    distortion : array[0..3] of single;//* distortion coefficients - two coefficients for radial distortion
                                       //   and another two for tangential: [ k1 k2 p1 p2 ] */
    rotMatr : array[0..8] of single;
    transVect : array[0..2] of single; //* rotation matrix and transition vector relatively
                                       //to some reference point in the space. */
  end;

  PCvStereoCamera = ^CvStereoCamera;
  CvStereoCamera = record
    camera : array[0..1] of CvCamera; //* two individual camera parameters */
    fundMatr : array[0..8] of Single; //* fundamental matrix */
    //* New part for stereo */
    epipole : array[0..1] of CvPoint3D32f;
    quad : array[0..1] of array [0..3] of CvPoint2D32f ; //* coordinates of destination quadrangle after
                                              //epipolar geometry rectification */
    coeffs : array [0..1] of array [0..2] of array [0..2] of double; //* coefficients for transformation */
    border : array [0..1] of array [0..3] of CvPoint2D32f;
    warpSize : CvSize;
    lineCoeffs : PCvStereoLineCoeff;
    needSwapCameras : Integer; //* flag set to 1 if need to swap cameras for good reconstruction */
    rotMatrix : array [0..8] of single;
    transVector : array[0..2] of single;
  end;

  PPCvGLCM = ^PCvGLCM;
  PCvGLCM = ^CvGLCM;
  CvGLCM = record
    matrixSideLength,
    numMatrices : Integer;
    matrices : P3Pdouble;

    numLookupTableElements : Integer;
    forwardLookupTable : array[0..CV_MAX_NUM_GREY_LEVELS_8U - 1] of Integer;
    reverseLookupTable : array[0..CV_MAX_NUM_GREY_LEVELS_8U - 1] of Integer;

    descriptors : p3pdouble;
    numDescriptors,
    descriptorOptimizationType,
    optimizationType : Integer;
  end;

  //详细请看该结构的初始化过程
  PCvTrackingRect = ^CvTrackingRect;
  CvTrackingRect = record
    r : CvRect;
    ptCenter : CvPoint;
    iColor,
    iEnergy,
    nRectsInThis,
    nRectsOnLeft,
    nRectsOnRight,
    nRectsOnTop,
    nRectsOnBottom : Integer;
  end;

  //详细可查看其初始化过程
  PPCvFaceTracker = ^PCvFaceTracker;
  PCvFaceTracker = ^CvFaceTracker;
  CvFaceTracker = record
    face : array[0..NUM_FACE_ELEMENTS-1] of CvTrackingRect;
    iTrackingFaceType : Integer;
    dbRotateDelta : double;
    dbRotateAngle : double;
    ptRotate : CvPoint;

    ptTempl : array[0..NUM_FACE_ELEMENTS-1] of CvPoint;
    rTempl : array[0..NUM_FACE_ELEMENTS-1] of CvRect;

    imgGray, imgThresh : PIplImage;
    mstgContours : PCvMemStorage;
  end;

  PPCv3dTrackerCameraIntrinsics = ^PCv3dTrackerCameraIntrinsics;
  PCv3dTrackerCameraIntrinsics = ^Cv3dTrackerCameraIntrinsics;
  Cv3dTrackerCameraIntrinsics = record
    principal_point : CvPoint2D32f;
    focal_length : array[0..1] of single;
    distortion : array[0..3] of single;
  end;

  PCv3dTrackerCameraInfo = ^Cv3dTrackerCameraInfo;
  Cv3dTrackerCameraInfo = record
    valid : CvBool;
    mat : array[0..3] of array [0..3] of Single;              //* maps camera coordinates to world coordinates */
    principal_point : CvPoint2D32f; //* copied from intrinsics so this structure */
                                    //* has all the info we need */
  end;

  PCv3dTracker2dTrackedObject = ^Cv3dTracker2dTrackedObject;
  Cv3dTracker2dTrackedObject = record
    id : Integer;
    p  : CvPoint2D32f; // pgruebele: So we do not loose precision, this needs to be float
  end;

  PCv3dTrackerTrackedObject = ^Cv3dTrackerTrackedObject;
  Cv3dTrackerTrackedObject = record
    id : Integer;
    p  : CvPoint3D32f;             // location of the tracked object
  end;

  PPCvVoronoiDiagram2D = ^PCvVoronoiDiagram2D;
  PCvVoronoiDiagram2D = ^CvVoronoiDiagram2D;
  CvVoronoiDiagram2D = record
    //CV_TREE_NODE_FIELDS
    flags : Integer;  ///* Miscellaneous flags.     */
    header_size : Integer; //Size of sequence header. */      \
    h_prev : PCvVoronoiDiagram2D; //* Previous sequence.       */      \
    h_next : PCvVoronoiDiagram2D; //* Next sequence.           */      \
    v_prev : PCvVoronoiDiagram2D; //* 2nd previous sequence.   */      \
    v_next : PCvVoronoiDiagram2D; // /* 2nd next sequence.       */
    //CV_SEQUENCE_FIELDS
    total : Integer;          //* Total number of elements.            */  \
    elem_size : Integer;      //* Size of sequence element in bytes.   */  \
    block_max : pschar;      //* Maximal bound of the last block.     */  \
    ptr : pschar;            //* Current write pointer.               */  \
    delta_elems : Integer;    //* Grow seq this many at a time.        */  \
    storage : PCvMemStorage;    //* Where the seq is stored.             */  \
    free_blocks : PCvSeqBlock;  //* Free blocks list.                    */  \
    first : PCvSeqBlock;        //* Pointer to the first sequence block. */
    //CV_SET_FIELDS
    free_elems : PCvSetElem;
    active_count : Integer;
    //CV_GRAPH_FIELDS()
    edges : PCvSet;
    //----------
    sites : PCvSet;
  end;

  CvLeeParameters = (
      CV_LEE_INT = 0,
      CV_LEE_FLOAT = 1,
      CV_LEE_DOUBLE = 2,
      CV_LEE_AUTO = -1,
      CV_LEE_ERODE = 0,
      CV_LEE_ZOOM = 1,
      CV_LEE_NON = 2
  );

  P2PCvBGStatModel = ^PCvBGStatModel;
  PCvBGStatModel = ^CvBGStatModel;
//  typedef void (CV_CDECL * CvReleaseBGStatModel)( struct CvBGStatModel** bg_model );
  CvReleaseBGStatModel = procedure( bg_model : P2PCvBGStatModel); cdecl;
//OpenCV2.0
//  typedef int (CV_CDECL * CvUpdateBGStatModel)( IplImage* curr_frame, struct CvBGStatModel* bg_model );
//OpenCV2.1
  CvUpdateBGStatModel = function(curr_frame : PIplImage; bg_model : P2PCvBGStatModel; learningRate : double) : Integer; cdecl;

  CvBGStatModel = record
    typeValue : Integer; //type of BG model*/
    release : CvReleaseBGStatModel;
    update : CvUpdateBGStatModel;
    background,  //8UC3 reference background image*/
    foreground : PIplImage;   //8UC1 foreground image*/
    layers : P2PIplImage;       //8UC3 reference background image, can be null */
    layer_count : Integer;  // can be zero */
    storage : PCvMemStorage;      //storage for foreground_regions*/
    foreground_regions : PCvSeq; //foreground object contours*/
  end;

  PCvFGDStatModelParams = ^CvFGDStatModelParams ;
  CvFGDStatModelParams = record
    Lc : Integer;			// Quantized levels per 'color' component. Power of two, typically 32, 64 or 128.				*/
    N1c : Integer;			// Number of color vectors used to model normal background color variation at a given pixel.			*/
    N2c : Integer;			// Number of color vectors retained at given pixel.  Must be > N1c, typically ~ 5/3 of N1c.			*/
                        // Used to allow the first N1c vectors to adapt over time to changing background.				*/

    Lcc : Integer;			// Quantized levels per 'color co-occurrence' component.  Power of two, typically 16, 32 or 64.			*/
    N1cc : Integer;		// Number of color co-occurrence vectors used to model normal background color variation at a given pixel.	*/
    N2cc : Integer;		// Number of color co-occurrence vectors retained at given pixel.  Must be > N1cc, typically ~ 5/3 of N1cc.	*/
		         // Used to allow the first N1cc vectors to adapt over time to changing background.				*/

    is_obj_without_holes : Integer;// If TRUE we ignore holes within foreground blobs. Defaults to TRUE.						*/
    perform_morphing : Integer;	// Number of erode-dilate-erode foreground-blob cleanup iterations.						*/
                              // These erase one-pixel junk blobs and merge almost-touching blobs. Default value is 1.			*/

    alpha1 : Single;		// How quickly we forget old background pixel values seen.  Typically set to 0.1  				*/
    alpha2 : Single;		// "Controls speed of feature learning". Depends on T. Typical value circa 0.005. 				*/
    alpha3 : Single;		// Alternate to alpha2, used (e.g.) for quicker initial convergence. Typical value 0.1.				*/

    delta : Single;		  // Affects color and color co-occurrence quantization, typically set to 2.					*/
    T : Single;			    // "A percentage value which determines when new features can be recognized as new background." (Typically 0.9).*/
    minArea : Single;		// Discard foreground blobs whose bounding box is smaller than this threshold.					*/
  end;

  PCvGaussBGStatModelParams = ^CvGaussBGStatModelParams;
  CvGaussBGStatModelParams = record
    win_size : Integer;               //* = 1/alpha */
    n_gauss : Integer;
    bg_threshold, std_threshold, minArea : double;
    weight_init, variance_init : double;
  end;

  PPCvBGCodeBookElem = ^PCvBGCodeBookElem;
  PCvBGCodeBookElem = ^CvBGCodeBookElem;
  CvBGCodeBookElem = record
    next : PCvBGCodeBookElem;
    tLastUpdate,
    stale : Integer;
    boxMin,
    boxMax,
    learnMin,
    learnMax : array[0..2] of UCHAR;
  end;

  P2PCvBGCodeBookModel = ^PCvBGCodeBookModel;
  PCvBGCodeBookModel = ^CvBGCodeBookModel;
  CvBGCodeBookModel = record
    size : CvSize;
    t : Integer;
    cbBounds : array[0..2] of UCHAR;
    modMin : array[0..2] of UCHAR;
    modMax : array[0..2] of UCHAR;
    cbmap : PPCvBGCodeBookElem;
    storage : PCvMemStorage;
    freeList : PCvBGCodeBookElem;
  end;

  PCvMatrix3 = ^CvMatrix3;
  CvMatrix3 = record
    m : array[0..2] of array [0..2] of Single;
  end;

  CvLSVMFilterPosition = Record
     X, Y, L: Cardinal;
  End;

  p2pCvLSVMFilterObject = ^pCvLSVMFilterObject;
  pCvLSVMFilterObject = ^CvLSVMFilterObject;
  CvLSVMFilterObject = Record
    V: CvLSVMFilterPosition;
    fineFunction: Array [0..4] of float;
    sizeX, sizeY, p, xp: Cardinal;
    H: pfloat;
  End;

  p2pCvLatentSvmDetector = ^pCvLatentSvmDetector;
  pCvLatentSvmDetector = ^CvLatentSvmDetector;
  CvLatentSvmDetector = Record
	  num_filters, num_components: Integer;
	  num_part_filters: pInteger;
	  filters: p2pCvLSVMFilterObject;
	  b: pFloat;
	  score_threshold: float;
  End;

  CvObjectDetection = Record
	  rect: CvRect;
	  score: float;
  End;


implementation



end.





