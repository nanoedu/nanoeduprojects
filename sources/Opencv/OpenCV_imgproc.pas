unit OpenCV_ImgProc;

interface

  uses Windows, Sysutils, Math, Graphics, Types,
       OpenCV_Types;

  Const
       File_dll = 'opencv_imgproc249.dll';

    //-----------------------------Motion Analysis and Object Tracking---------------
    //*********************** Background statistics accumulation *****************************/
    procedure cvAcc(const image: pCvArr; sum: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
    procedure cvMultiplyAcc(const image1: pCvArr; const image2: pCvArr; acc: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
    procedure cvRunningAvg(const image: pCvArr; acc: pCvArr; alpha: double; const mask: pCvArr=NIL); cdecl; external File_dll;
    procedure cvSquareAcc(const image: pCvArr; sqsum: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;

    //------------imgproc. Image Processing----------------------------------
    //-----------------------Histogram--------------------------------
    procedure cvCalcArrHist(arr:P2PCvArr; hist:PCvHistogram; accumulate:longint; mask:PCvArr); cdecl; external File_dll;
    procedure cvCalcArrBackProject(image:P2PCvArr; dst:PCvArr; hist:PCvHistogram); cdecl; external File_dll;
    procedure cvCalcBackProject(image: p2pIplImage; back_project: pCvArr; const hist: pCvHistogram); cdecl; external File_dll;
    procedure cvCalcBackProjectPatch(images: p2pIplImage; dst: pCvArr; patch_size: CvSize; hist: pCvHistogram; method: integer; factor: double); cdecl; external File_dll;
    //procedure cvCalcArrHist(image: p2pIplImage; hist: pCvHistogram; accumulate: integer=0; const mask: pCvArr=NIL); cdecl; external File_dll;
    procedure cvCalcProbDensity(const hist1: pCvHistogram; const hist2: pCvHistogram; dst_hist: pCvHistogram; scale: double=255); cdecl; external File_dll;
    procedure cvClearHist(hist: pCvHistogram); cdecl; external File_dll;
    function cvCompareHist(const hist1: pCvHistogram; const hist2: pCvHistogram; method: Integer): double; cdecl; external File_dll;
    procedure cvCopyHist(const src: pCvHistogram; dst: p2pCvHistogram); cdecl; external File_dll;
    function cvCreateHist(dims: integer; sizes: pInteger; type_: Integer; ranges: p2pFloat=NIL; uniform: Integer=1):  pCvHistogram; cdecl; external File_dll;
    function cvGetHistValue_1D(hist: CvHistogram; idx0: Integer): float; cdecl; external File_dll;
    function cvGetHistValue_2D(hist: CvHistogram; idx0, idx1: Integer): float; cdecl; external File_dll;
    function cvGetHistValue_3D(hist: CvHistogram; idx0, idx1, idx2: Integer): float; cdecl; external File_dll;
    function cvGetHistValue_ND(hist: CvHistogram; idx: pInteger): float; cdecl; external File_dll;
    procedure cvGetMinMaxHistValue(const hist: pCvHistogram; min_value, max_value: pfloat; min_idx: pInteger=NIL; max_idx: pInteger=NIL); cdecl; external File_dll;
    function cvMakeHistHeaderForArray(dims: integer; sizes: pInteger; hist: pCvHistogram; data: pfloat; ranges: p2pFloat=NIL; uniform: Integer=1): pCvHistogram; cdecl; external File_dll;
    procedure cvNormalizeHist(hist: pCvHistogram; factor: double); cdecl; external File_dll;
    function QueryHistValue_1D(hist: CvHistogram; idx0: Integer): float; cdecl; external File_dll;
    function QueryHistValue_2D(hist: CvHistogram; idx0, idx1: Integer): float; cdecl; external File_dll;
    function QueryHistValue_3D(hist: CvHistogram; idx0, idx1, idx2: Integer): float; cdecl; external File_dll;
    function QueryHistValue_ND(hist: CvHistogram; idx: pInteger): float; cdecl; external File_dll;
    procedure cvReleaseHist(hist: p2pCvHistogram); cdecl; external File_dll;
    procedure cvSetHistBinRanges(hist: pCvHistogram; ranges: p2pfloat; uniform:integer=1); cdecl; external File_dll;
    procedure cvThreshHist(hist: CvHistogram; threshold: double); cdecl; external File_dll;

     //--------------------Miscellaneous Image Transformations----------------------
    procedure cvAdaptiveThreshold(const src: pCvArr; dst: pCvArr; maxValue: double; adaptive_method: integer=CV_ADAPTIVE_THRESH_MEAN_C; thresholdType: integer=CV_THRESH_BINARY; blockSize: integer=3; param1: double=5); cdecl; external File_dll;
    procedure cvCvtColor(const src: pCvArr; dst: pCvArr; code: integer); cdecl; external File_dll;
    procedure cvDistTransform(const src: pCvArr; dst: pCvArr; distance_type: integer=CV_DIST_L2; mask_size: integer=3; const mask: pfloat=NIL; labels: pCvArr=NIL); cdecl; external File_dll;
    procedure cvFloodFill(image: pCvArr; seed_point: CvPoint; new_val: CvScalar; lo_diff: CvScalar; up_diff: CvScalar; comp: pCvConnectedComp=NIL; flags: Integer=4; mask: pCvArr=NIL) cdecl; external File_dll;
    procedure cvInpaint(const src: pCvArr; const mask: pCvArr; dst: pCvArr; inpaintRadius: double; flags: integer); cdecl; external File_dll;
    procedure cvIntegral(const image: pCvArr; sum: pCvArr; sqsum: pCvArr=NIL; tiltedSum: pCvArr=NIL); cdecl; external File_dll;
    function  cvThreshold(const src: pCvArr; dst: pCvArr; threshold, maxValue: double; thresholdType: integer): double; cdecl; external File_dll;

    //---------------------------Image Processing ----------------------------
    procedure cvSmooth(const src: pCvArr; dst: pCvArr; smoothtype: integer=CV_GAUSSIAN; param1: Integer=3; param2: Integer=0; param3: double=0; param4: double=0); cdecl; external File_dll;

    //---------------------------Image Filtering----------------------------
    procedure cvCopyMakeBorder(const src: pCvArr; dst: pCvArr; offset: CvPoint; bordertype: integer; value: CvScalar); cdecl; external File_dll;
    function cvCreateStructuringElementEx(cols, rows, anchorX, anchorY, shape: integer; values: pInteger=NIL): pIplConvKernel; cdecl; external File_dll;
    procedure cvDilate(const src: pCvArr; dst: pCvArr; element: pIplConvKernel=NIL; iterations: Integer=1); cdecl; external File_dll;
    procedure cvErode(const src: pCvArr; dst: pCvArr; element: pIplConvKernel=NIL; iterations: Integer=1); cdecl; external File_dll;
    procedure cvFilter2D(const src: pCvArr; dst: pCvArr; const kernel: pCvMat; anchor: CvPoint); cdecl; external File_dll;
    procedure cvLaplace(const src: pCvArr; dst: pCvArr; apertureSize: Integer=3); cdecl; external File_dll;
    procedure cvMorphologyEx(const src: pCvArr; dst: pCvArr; temp: pCvArr; element: pIplConvKernel; operation: Integer; iterations: Integer=1); cdecl; external File_dll;
    procedure cvPyrDown(const src: pCvArr; dst: pCvArr; filter: Integer=CV_GAUSSIAN_5x5); cdecl; external File_dll;
    procedure cvPyrUp(const src: pCvArr; dst: pCvArr; filter: Integer=CV_GAUSSIAN_5x5); cdecl; external File_dll;
    function  cvCreatePyramid(const img: PCvArr; extra_layers: Integer; rate: Double; const layer_sizes: PCvSize= 0; bufarr: PCvArr= 0; calc: Integer= 1; filter: Integer= CV_GAUSSIAN_5x5): P2PCvMat;  cdecl; external File_dll;
    procedure cvReleasePyramid(pyramid: P3PCvMat; extra_layers: Integer);  cdecl; external File_dll;

    procedure cvPyrSegmentation(src: pIplImage; dst: pIplImage; storage: pCvMemStorage; comp: p2pCvSeq; level: Integer; threshold1, threshold2: double); cdecl; external File_dll;
    procedure cvPyrMeanShiftFiltering(const src: pCvArr; dst: pCvArr; sp, sr: double; max_level: Integer; termcrit: CvTermCriteria); cdecl; external File_dll;


    procedure cvSobel(const src: pCvArr; dst: pCvArr; xorder, yorder: Integer; apertureSize: Integer=3); cdecl; external File_dll;
    procedure cvReleaseStructuringElement(element: p2pIplConvKernel); cdecl; external File_dll;

    //--------------------------Geometric Image Transformations------------------------
    function  cv2DRotationMatrix(center: CvPoint2D32f; angle, scale: double; mapMatrix: pCvMat): pCvMat; cdecl; external File_dll;
    function  cvGetAffineTransform(const src: pCvPoint2D32f; const dst: pCvPoint2D32f; mapMatrix: pCvMat): pCvMat; cdecl; external File_dll;
    function  cvGetPerspectiveTransform(const src: pCvPoint2D32f; const dst: pCvPoint2D32f; mapMatrix: pCvMat): pCvMat; cdecl; external File_dll;
    procedure cvGetQuadrangleSubPix(const src: pCvArr; dst: pCvArr; const mapMatrix: pCvMat); cdecl; external File_dll;
    procedure cvGetRectSubPix(const src: pCvArr; dst: pCvArr; center: CvPoint2D32f); cdecl; external File_dll;
    procedure cvLogPolar(const src: pCvArr; dst: pCvArr; center: CvPoint2D32f; M: double; flags: Integer=(CV_INTER_LINEAR + CV_WARP_FILL_OUTLIERS)); cdecl; external File_dll;
    procedure cvRemap(const src: pCvArr; dst: pCvArr; const mapx: pCvArr; const mapy: pCvArr; flags: Integer; fillval: CvScalar); cdecl; external File_dll;
    procedure cvResize(const src: pCvArr; dst: pCvArr; interpolation: Integer=CV_INTER_LINEAR); cdecl; external File_dll;
    procedure cvWarpAffine(const src: pCvArr; dst: pCvArr; const mapMatrix: pCvMat; flags: Integer; fillval: CvScalar); cdecl; external File_dll;
    procedure cvWarpPerspective(const src: pCvArr; dst: pCvArr; const mapMatrix: pCvMat; flags: integer; fillval: CvScalar); cdecl; external File_dll;

    //---------------------Structural Analysis and Shape Descriptors------------------
  // added  function cvApproxChains(src_seq: pCvSeq; storage: pCvMemStorage; method: integer=CV_CHAIN_APPROX_SIMPLE; parameter: double=0; minimal_perimeter: integer=0; recursive: integer=0): pCvSeq; cdecl; external File_dll;
    function cvApproxPoly(const src_seq: Pointer; header_size: Integer; storage: pCvMemStorage; method: Integer; parameter: double; parameter2: Integer=0): pCvSeq; cdecl; external File_dll;
    function cvArcLength(const curve: Pointer; slice: CvSlice; isClosed: Integer=-1): double; cdecl; external File_dll;
    function cvBoundingRect(points: pCvArr; update: Integer=0): CvRect; cdecl; external File_dll;
    procedure cvBoxPoints(box: CvBox2D; pt: TCvPoint2D32fArr4); cdecl; external File_dll;
    procedure cvCalcPGH(const contour: pCvSeq; hist: pCvHistogram); cdecl; external File_dll;
    function cvCalcEMD2(const signature1: PCvArr; const signature2: PCvArr; distance_type: Integer; distance_func: CvDistanceFunction {* NULL *} ; const cost_matrix: PCvArr = NIL; flow: PCvArr = NIL; lower_bound: pSingle = NIL; userdata: Pointer = NIL): Single;  cdecl; external File_dll;
    function cvCheckContourConvexity(const contour: pCvArr): Integer; cdecl; external File_dll;
    function cvContourArea(const contour: pCvArr; slice: CvSlice): double; cdecl; external File_dll;
    function cvContourFromContourTree(const tree: pCvContourTree; storage: pCvMemStorage; criteria: CvTermCriteria): pCvSeq; cdecl; external File_dll;
    function cvConvexHull2(const input: pCvArr; storage: Pointer=NIL; orientation: Integer=CV_CLOCKWISE; return_points: Integer=0): pCvSeq; cdecl; external File_dll;
    function cvConvexityDefects(const contour: pCvArr; const convexhull: pCvArr; storage: pCvMemStorage=NIL): pCvseq; cdecl; external File_dll;
    function cvCreateContourTree(const contour: pCvSeq; storage: pCvMemStorage; threshold: double): pCvContourTree; cdecl; external File_dll;

    function cvStartFindContours(image: PCvArr; storage: PCvMemStorage; header_size: Integer { = sizeof(CvContour)}; mode: Integer { = CV_RETR_LIST }; method: Integer { = CV_CHAIN_APPROX_SIMPLE }; offset: CvPoint {* cvPoint(0,0) *} ): CvContourScanner;  cdecl; external File_dll; 
    function cvEndFindContours(scanner: pCvContourScanner): pCvSeq; cdecl; external File_dll;
    function cvFindContours(image: pCvArr; storage: pCvMemStorage; first_contour: p2pCvSeq; header_size: integer; mode: Integer; method: integer; offset: CvPoint): integer; cdecl; external File_dll;
    function cvFindNextContour(scanner: CvContourScanner): pCvSeq; cdecl; external File_dll;
    procedure cvSubstituteContour(scanner: CvContourScanner; new_contour: PCvSeq);  cdecl; external File_dll;

    function cvFitEllipse2(const points: pCvArr): CvBox2D; cdecl; external File_dll;
    procedure cvFitLine(const points: pCvArr; dist_type: Integer; param, reps, aeps: double; line: pfloat); cdecl; external File_dll;

    function cvGetCentralMoment(moments: pCvMoments; x_order: integer; y_order: integer): double; cdecl; external File_dll;
    procedure cvGetHuMoments(const moments: pCvMoments; hu: pCvHuMoments); cdecl; external File_dll;
    function cvGetNormalizedCentralMoment(moments: pCvMoments; x_order, y_order: integer): double; cdecl; external File_dll;
    function cvGetSpatialMoment(moments: pCvMoments; x_order, y_order: Integer): double; cdecl; external File_dll;
    //procedure cvCalcMoments( arr: PCvArr; moments: PCvMoments; binary: longint = 0); cdecl; external File_dll

    function cvMatchContourTrees(const tree1: pCvContourTree; const tree2: pCvContourTree; method: Integer; threshold: double): double; cdecl; external File_dll;
    function cvMatchShapes(const object1: Pointer; const object2: Pointer; method: Integer; parameter: double=0): double; cdecl; external File_dll;
    function cvMinAreaRect2(const points: pCvArr; storage: pCvMemStorage=NIL): CvBox2D; cdecl; external File_dll;
    function cvMinEnclosingCircle(const points: pCvArr; center: pCvPoint2D32f; radius: pfloat): Integer; Cdecl; external File_dll;
    function cvPointPolygonTest(const contour: pCvArr; pt: CvPoint2D32f; measure_dist: Integer): double; cdecl; external File_dll;
    function cvPointSeqFromMat(seq_kind: Integer; const mat: pCvArr; contour_header: pCvContour; block: pCvSeqBlock): pCvSeq; cdecl; external File_dll;

    function cvReadChainPoint(reader: pCvChainPtReader): CvPoint; cdecl; external File_dll;
    procedure cvStartReadChainPoints(chain: pCvChain; reader: pCvChainPtReader); cdecl; external File_dll;

    function  cvFindDominantPoints(contour: PCvSeq; storage: PCvMemStorage; method: Integer = CV_DOMINANT_IPAN; parameter1 : Double = 0; parameter2 : Double = 0; parameter3 : Double = 0; parameter4 : Double = 0) : PCvSeq;  cdecl; external File_dll;

    //-----------------------------Motion Analysis and Object Tracking---------------

    //-------------------------Feature Detection------------------------
    procedure cvCanny(const image: pCvArr; edges: pCvArr; threshold1, threshold2: double; aperture_size: Integer=3); cdecl; external File_dll;
    procedure cvCornerEigenValsAndVecs(const image: pCvArr; eigenvv: pCvArr; blockSize: Integer; aperture_size: Integer=3); cdecl; external File_dll;
    procedure cvCornerHarris(const image: pCvArr; harris_dst: pCvArr; blockSize: integer; aperture_size: integer=3; k: double=0.04); cdecl; external File_dll;
    procedure cvCornerMinEigenVal(const image: pCvArr; eigenval: pCvArr; blockSize: Integer; aperture_size: integer=3); cdecl; external File_dll;
    procedure cvFindCornerSubPix(const image: pCvArr; corners: pCvPoint2D32f; count: integer; win: CvSize; zero_zone: CvSize; criteria: CvTermCriteria); cdecl; external File_dll;
    procedure cvGoodFeaturesToTrack(const image: pCvArr; eigImage: pCvArr; tempImage: pCvArr; corners: pCvPoint2D32f; cornerCount: pInteger; qualityLevel, minDistance: double; const mask: pCvArr=NIL; blockSize: Integer=3; useHarris: Integer=0; k: double=0.04); cdecl; external File_dll;
    function cvHoughLines2(image: pCvArr; storage: Pointer; method: integer; rho, theta: double; threshold: integer; param1: double=0; param2: double=0): pCvSeq; cdecl; external File_dll;
    procedure cvPreCornerDetect(const image: pCvArr; corners: pCvArr; apertureSize: Integer=3); cdecl; external File_dll;
    function cvSampleLine(const image: pCvArr; pt1, pt2: CvPoint; buffer: pointer; connectivity: integer=8): integer; cdecl; external File_dll;

    //-------------------------Object Detection---------------------
    procedure cvMatchTemplate(const image: pCvArr; const templ: pCvArr; result: pCvArr; method: integer); cdecl; External File_dll;

    function cvCreateConDensation(dynam_params, measure_params, sample_count: integer): pCvConDensation; cdecl; External File_dll;
    procedure cvConDensInitSampleSet(condens: pCvConDensation; lower_bound, upper_bound: pCvMat); cdecl; External File_dll;
    procedure cvReleaseConDensation(condens: p2pCvConDensation); cdecl; External File_dll;
    procedure cvConDensUpdateByTime(condens: PCvConDensation); cdecl; external File_dll;

    procedure cvInitSubdivDelaunay2D(subdiv : PCvSubdiv2D; rect : CvRect); cdecl; external File_dll;
    function  cvCreateSubdiv2D(subdiv_type : Integer; header_size : Integer; vtx_size : Integer; quadedge_size : Integer; storage : PCvMemStorage) : PCvSubdiv2D;  cdecl; external File_dll;
    function  cvSubdivDelaunay2DInsert(subdiv : PCvSubdiv2D; pt : CvPoint2D32f) : PCvSubdiv2DPoint;  cdecl; external File_dll;
    function  cvSubdiv2DLocate(subdiv : PCvSubdiv2D; pt : CvPoint2D32f; edge : PCvSubdiv2DEdge; vertex : PPCvSubdiv2DPoint = NIL) : CvSubdiv2DPointLocation;  cdecl; external File_dll;
    procedure cvCalcSubdivVoronoi2D(subdiv : PCvSubdiv2D); cdecl; external File_dll;
    procedure cvClearSubdivVoronoi2D(subdiv : PCvSubdiv2D); cdecl; external File_dll;
    function  cvFindNearestPoint2D(subdiv: PCvSubdiv2D; pt: CvPoint2D32f): PCvSubdiv2DPoint;  cdecl; external File_dll;

    //----------------------------Divers-------------------------
    Function  cvInvert(const A: PCvArr; B: PCvArr; method: integer): double; cdecl; External File_dll;
    Procedure cvMatMulAdd(const A, B, C: PCvArr; D: PCvArr); cdecl; External File_dll;

    procedure cvWatershed(const image: PCvArr; markers: PCvArr);  cdecl; external File_dll;
    procedure cvConvertMaps(const mapx: PCvArr; const mapy: PCvArr; mapxy : PCvArr; mapalpha : PCvArr);  cdecl; external File_dll;
    procedure cvLinearPolar(const src: PCvArr; dst: PCvArr; center : CvPoint2D32f; maxRadius : Double; flags : Integer = CV_INTER_LINEAR+CV_WARP_FILL_OUTLIERS); cdecl; external File_dll;
    procedure cvMomentsN(const arr: PCvArr; moments: PCvMoments; binary : Integer = 0);  cdecl; external File_dll;
    //procedure cvAcc(const image : PCvArr; sum : PCvArr; const mask : PCvArr = NIL);  cdecl; external File_dll;
    function  cvMaxRect(const rect1 : PCvRect; const rect2 : PCvRect) : CvRect;  cdecl; external File_dll;
    procedure cvCalcBayesianProb(src : P2PCvHistogram; number : Integer; dst : P2PCvHistogram);  cdecl; external File_dll;
    procedure cvCalcArrBackProjectPatch(image : P2PCvArr; dst : PCvArr; range : CvSize; hist : PCvHistogram; method : Integer; factor : Double);  cdecl; external File_dll;
    procedure cvEqualizeHist(const src : PCvArr; dst : PCvArr);  cdecl; external File_dll;
    procedure cvCalcImageHomography(line : PSingle; center : PCvPoint3D32f; intrinsic : PSingle; homography : PSingle);  cdecl; external File_dll;
    function  cvHoughCircles(image : PCvArr; circle_storage : Pointer; method : Integer; dp : Double; min_dist : Double; param1 : Double = 100; param2 : Double = 100; min_radius : Integer = 0; max_radius : Integer = 0) : PCvSeq;  cdecl; external File_dll;
    function  cvCreateKDTree(desc : PCvMat) : PCvFeatureTree;  cdecl; external File_dll;
    function  cvCreateSpillTree(const raw_data : PCvMat; const naive : Integer = 50; const rho : Double = 0.7; const tau : Double = 0.1) : PCvFeatureTree;  cdecl; external File_dll;
    procedure cvReleaseFeatureTree(tr : PCvFeatureTree);  cdecl; external File_dll;
    procedure cvFindFeatures(tr : PCvFeatureTree; const query_points : PCvMat; indices : PCvMat; dist : PCvMat; k : Integer; emax : Integer = 20);  cdecl; external File_dll;
    function  cvFindFeaturesBoxed(tr : PCvFeatureTree; bounds_min : PCvMat; bounds_max : PCvMat; out_indices : PCvMat) : Integer;  cdecl; external File_dll;
    function  cvCreateLSH(ops : PCvLSHOperations; d : Integer; L : Integer = 10; k : Integer = 10; typeValue : Integer = CV_64FC1; r : Double = 4; seed : int64 = -1 ) : PCvLSH;  cdecl; external File_dll;
    function  cvCreateMemoryLSH(d : Integer; n : Integer; L : Integer = 10; k : Integer = 10; typeValue : Integer = CV_64FC1; r : Double = 4; seed : int64 = -1 ) : PCvLSH;  cdecl; external File_dll;
    procedure cvReleaseLSH(lsh : PPCvLSH);  cdecl; external File_dll;
    function  LSHSize(lsh : PCvLSH) : Uint;  cdecl; external File_dll;
    procedure cvLSHAdd(lsh : PCvLSH; const data : PCvMat; indices : PCvMat = 0);  cdecl; external File_dll;
    procedure cvLSHRemove(lsh : PCvLSH; const indices : PCvMat);  cdecl; external File_dll;
    procedure cvLSHQuery(lsh : PCvLSH; const query_points : PCvMat; indices : PCvMat; dist : PCvMat; k : Integer; emax : Integer);  cdecl; external File_dll;


implementation

end.

