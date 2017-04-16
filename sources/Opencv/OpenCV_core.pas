unit OpenCV_Core;

interface

  uses Windows, Sysutils, Math, Graphics, Types,
       OpenCV_Types;
       
  const
       File_dll = '..\exe\Opencv\opencv_core249.dll';

  //-------------------------Operations on Arrays--------------
  procedure cvAbsDiff(const src1, src2: pCvArr; dst: pCvArr); cdecl; external File_dll;
  procedure cvAbsDiffS(const src, dst: pCvArr; value: CvScalar); cdecl; external File_dll;
  procedure cvAdd(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
  procedure cvAddS(const src: pCvArr; value: CvScalar; dst: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
  procedure cvAddWeighted(const src1: pCvArr; alpha: double; const src2: pCvArr; beta: double; gamma: double; dst: pCvArr); cdecl; external File_dll;
  procedure cvAnd(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
  procedure cvAndS(const src: pCvArr; value: CvScalar; dst: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
  function  cvAvg(const arr: pCvArr; const mask: pCvArr=NIL): CvScalar; cdecl; external File_dll;
  procedure cvAvgSdv(const arr: pCvArr; mean, stdDev: pCvScalar; const mask: pCvArr=NIL); cdecl; external File_dll;
  procedure cvCalcCovarMatrix(const vects: P2PCvArr; count: integer; covMat, avg: pCvArr; flags: integer); cdecl; external File_dll;
  procedure cvCartToPolar(const X: pCvArr; const Y: pCvArr; magnitude: pCvArr; Angle: pCvArr=NIL; angleInDegrees: Integer=0); cdecl; external File_dll;
  function cvCbrt(value: float): float; cdecl; external File_dll;
  function cvCloneImage(const image: pIplImage): pIplImage; cdecl; external File_dll;

  procedure cvCmp(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; cmpOp: Integer); cdecl; external File_dll;
  procedure cvCmpS(const src: pCvArr; value: double; dst: pCvArr; cmpOp: Integer); cdecl; external File_dll;
  procedure cvConvertScale(const src: pCvArr; dst: pCvArr; scale: double=1; shift: double=0); cdecl; external File_dll;
  procedure cvConvertScaleAbs(const src: pCvArr; dst: pCvArr; scale: double=1; shift: double=0); cdecl; external File_dll;
  procedure cvCvtScaleAbs(const src: pCvArr; dst: pCvArr; scale: double=1; shift: double=0); cdecl; external File_dll;
  procedure cvCopy(const src: pCvArr; dst: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
  function cvCountNonZero(const arr: pCvArr): integer; cdecl; external File_dll;

  //--------------------Data--------------------------------
  procedure cvCreateData(arr: pCvArr); cdecl; external File_dll;
  procedure cvReleaseData(arr: pCvArr); cdecl; external File_dll;
  procedure cvSetData(arr: pCvArr; data: Pointer; step: Integer); cdecl; external File_dll;
  procedure cvGetRawData(const arr: PCvArr; data: PPAnsichar; step: Pint; roi_size: PCvSize);  cdecl; external File_dll; 

  //------------------------Matrix-----------------------------
  function cvInitMatHeader(mat: PCvMat; rows: Integer; cols: Integer; typeValue: Integer; data: Pointer; step: Integer = CV_AUTOSTEP): PCvMat;  cdecl; external File_dll;
  function cvCreateMat(Rows, Cols, theType: Integer): pCvMat; cdecl; external File_dll;
  function cvCreateMatHeader(Rows, Cols, theType: Integer): pCvMat; cdecl; external File_dll;

  function cvGetMat(const arr: pCvArr; header: pCvMat; coi: pInteger=NIL; allowND: Integer=0): pCvMat; cdecl; external File_dll;
  //function cvMat_(rows, cols, theType: Integer; data: Pointer=NIL): cvMat; cdecl; external File_dll;
  procedure cvReleaseMat(mat: p2pCvMat); cdecl; external File_dll;

  function cvCreateMatND(dims: Integer; const sizes: pInteger; theType: Integer): pCvMatND; cdecl; external File_dll;
  procedure cvReleaseMatND(mat: p2pCvMatND); cdecl; external File_dll;
  function cvCloneMat(const mat: pCvMat): pCvMat; cdecl; external File_dll;
  procedure cvClearND(arr: pCvArr; idx: pInteger); cdecl; external File_dll;

  function cvInitMatNDHeader(mat: PCvMatND; dims: Integer; const sizes: Pint; typeValue: Integer; data: Pointer): PCvMatND;  cdecl; external File_dll; 
  function cvCreateMatNDHeader(dims: Integer; const sizes: pInteger; theType: Integer): pCvMatND; cdecl; external File_dll;
  function cvCloneMatND(const mat: pCvMatND): pCvMatND; cdecl; external File_dll;


  //-----------------------ROI--------------------------------
  function cvGetImageCOI(const image: pIplImage): pIplImage; cdecl; external File_dll;
  function cvGetImageROI(const image: pIplImage): CvRect; cdecl; external File_dll;
  procedure cvSetImageCOI(image: pIplImage; coi: Integer); cdecl; external File_dll;
  procedure cvSetImageROI(image: pIplImage; coi: CvRect); cdecl; external File_dll;
  procedure cvResetImageROI(image: pIplImage); cdecl; external File_dll;

  function cvCreateImage(size: CvSize; depth, channels: Integer): pIplImage; cdecl; external File_dll;
  function cvCreateImageHeader(size: CvSize; depth, channels: Integer): pIplImage; cdecl; external File_dll;

  procedure cvCrossProduct(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl; external File_dll;
  procedure cvDCT(const src: pCvArr; dst: pCvArr; flags: Integer); cdecl; external File_dll;
  procedure cvDecRefData(arr: pCvArr); cdecl; external File_dll;
  function cvDet(const mat: pCvArr): double; cdecl; external File_dll;
  procedure cvDiv(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; scale: double=1); cdecl; external File_dll;
  procedure cvDotProduct(const src1: pCvArr; const src2: pCvArr); cdecl; external File_dll;
  procedure cvEigenVV(mat: pCvArr; evects: pCvArr; evals: pCvArr; eps: double=0; lowindex: integer=-1; highindex: integer = -1); cdecl; external File_dll;
  procedure cvExp(const src: pCvArr; dst: pCvArr); cdecl; external File_dll;
  function cvFastArctan(Y, X: float): float; cdecl; external File_dll;
  procedure cvFlip(const src: pCvArr; dst: pCvArr=NIL; flipMode: Integer=0); cdecl; external File_dll;
  procedure cvGEMM(const src1: pCvArr; const src2: pCvArr; alpha: double; const src3: pCvArr; beta: double; dst: pCvArr; tABC: Integer=0); cdecl; external File_dll;
  function cvGet1D(const arr: pCvArr; idx0: Integer): cvScalar; cdecl; external File_dll;
  function cvGet2D(const arr: pCvArr; idx0, idx1: Integer): CvScalar; cdecl; external File_dll;
  function cvGet3D(const arr: pCvArr; idx0, idx1, idx2: Integer): CvScalar; cdecl; external File_dll;
  function cvGetND(const arr: pCvArr; idx: Integer): cvScalar; cdecl; external File_dll;
  function cvGetCols(const arr: pCvArr; submat: pCvMat; startCol, endCol: Integer): pCvMat; cdecl; external File_dll;
  function cvGetDiag(const arr: pCvArr; submat: pCvMat; diag: integer=0): pCvMat; cdecl; external File_dll;
  function cvGetDims(const arr: pCvArr; sizes: pInteger=NIL): integer; cdecl; external File_dll;
  function cvGetDimSize(const arr: pCvArr; index: integer):integer; cdecl; external File_dll;
  function cvGetElemType(const arr: pCvArr): integer; cdecl; external File_dll;
  function cvGetImage(const arr: pCvArr; imageHeader: pIplImage): pIplImage; cdecl; external File_dll;

  //function cvGetNextSparseNodex(mat_iterator: pCvSparseMatIterator): pCvSparseNode; cdecl; external File_dll; external File_dll;
  function cvGetOptimalDFTSize(size0: Integer): integer; cdecl; external File_dll;
  function cvGetReal1D(const arr: pCvArr; idx0: Integer): double; cdecl; external File_dll;
  function cvGetReal2D(const arr: pCvArr; idx0, idx1: Integer): double; cdecl; external File_dll;
  function cvGetReal3D(const arr: pCvArr; idx0, idx1, idx2: Integer): double; cdecl; external File_dll;
  function cvGetRealND(const arr: PCvArr; const idx: Pint): Double;  cdecl; external File_dll; 
  
  function cvGetSize(const arr: pCvArr): CvSize; cdecl; external File_dll;
  function cvGetSubRect(const arr: pCvArr; submat: pCvMat; rect: CvRect): pCvMat; cdecl; external File_dll;
  procedure cvInRange(const src: pCvArr; const lower: pCvArr; const upper: pCvArr; dst: pCvArr); cdecl; external File_dll;
  procedure cvInRangeS(const src: pCvArr; lower, upper: CvScalar; dst: pCvArr); cdecl; external File_dll;
  function cvIncRefData(arr: pCvArr): Integer; cdecl; external File_dll;
  function cvInitImageHeader(image: pIplImage; size: CvSize; depth, channels: Integer; origin: Integer=0; align: Integer=4): pIplImage; cdecl; external File_dll;

  function  cvInitSparseMatIterator(const mat: PCvSparseMat; mat_iterator: PCvSparseMatIterator): PCvSparseNode;  cdecl; external File_dll;
  function cvInvSqrt(value: float): float; cdecl; external File_dll;
  function  cvInvert(const src: PCvArr; dst: PCvArr; method: Integer = CV_LU): Double; cdecl; external File_dll;
  function cvIsInf(value: double): Integer; cdecl; external File_dll;
  function cvIsNaN(value: double): integer; cdecl; external File_dll;
  procedure cvLUT(const src: pCvArr; dst: pCvArr; const lut: pCvArr); cdecl; external File_dll;
  procedure cvLog(const src: pCvArr; dst: pCvArr); cdecl; external File_dll;
  function cvMahalanobis(const vec1: pCvArr; const vec2: pCvArr; mat: pCvArr): double; cdecl; external File_dll;

  procedure cvMax(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl; external File_dll;
  procedure cvMaxS(const src: pCvArr; value: double; dst: pCvArr); cdecl; external File_dll;
  procedure cvMerge(const src0: pCvArr; const src1: pCvArr; const src2: pCvArr; const src3: pCvArr; dst: pCvArr); cdecl; external File_dll;
  procedure cvMin(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl; external File_dll;
  procedure cvMinMaxLoc(const arr: pCvArr; minVal, maxVal: pDouble; minLoc: pCvPoint=NIL; maxLoc: pCvPoint=NIL; const mask: pCvArr=NIL); cdecl; external File_dll;
  procedure cvMinS(const src: pCvArr; value: double; dst: pCvArr);cdecl; external File_dll;
  procedure cvMixChannels(const src: p2pCvArr; srcCount: integer; dst: p2pCvArr; dstCount: integer; const fromTo: pInteger; pairCount: Integer); cdecl; external File_dll;
  procedure cvMul(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; scale: double=1); cdecl; external File_dll;
  procedure cvMulSpectrums(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; flags: Integer); cdecl; external File_dll;
  procedure cvMulTransposed(const src: pCvArr; dst: pCvArr; order: Integer; const delta: pCvArr=NIL; scale: double=1.0); cdecl; external File_dll;
//  function cvNorm(const arr1: pCvArr; const arr2: pCvArr; normType: integer; const mask: pCvArr=NiL): double;
  procedure cvNot(const src: pCvArr; dst: pCvArr); cdecl; external File_dll;
  procedure cvOr(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
  procedure cvOrS(const src: pCvArr; value:  CvScalar; dst: pCvArr;  const mask: pCvArr=NIL); cdecl; external File_dll;
  procedure cvPerspectiveTransform(const src: pCvArr; dst: pCvArr; const mat: pCvMat); cdecl; external File_dll;
  procedure cvPolarToCart(const magnitude: pCvArr; const angle: pCvArr; X, Y: pCvArr; angleInDegrees: Integer=0); cdecl; external File_dll;
  procedure cvPow(const src: pCvArr; dst: pCvArr; power: double); cdecl; external File_dll;
  function  cvPtr1D(const arr: PCvArr; idx0: Integer; typeValue: Pint): Puchar; cdecl; external File_dll;
  function  cvPtr2D(const arr: PCvArr; idx0: Integer; idx1: Integer; typeValue: Pint): Puchar; cdecl; external File_dll;
  function  cvPtr3D(const arr: PCvArr; idx0: Integer; idx1: Integer; idx2: Integer; typeValue: Pint): Puchar; cdecl; external File_dll;
  function  cvPtrND(const arr: PCvArr; const idx: Pint; typeValue: Pint; create_node: Integer; precalc_hashval: PCardinal): Puchar; cdecl; external File_dll;

  procedure cvReleaseImage(image: p2pIplImage); cdecl; external File_dll;
  procedure cvReleaseImageHeader(image: p2pIplImage); cdecl; external File_dll;

  procedure cvRepeat(const src: pCvArr; dst: pCvArr); cdecl; external File_dll;

  function cvReshape(const arr: pCvArr; header: pCvMat;  newCn: integer; newRows: integer=0): pCvMat; cdecl; external File_dll;
  function cvReshapeMatND(const arr: pCvArr; sizeofHeader: Integer; header: pCvArr; newCn, newDims: Integer; newSizes: pInteger): pCvArr; cdecl; external File_dll;
  //function cvRound(value: double): Integer; cdecl; external File_dll;
  function cvFloor(value: double): Integer; cdecl; external File_dll;
  function cvCeil(value: double): Integer; cdecl; external File_dll;
  procedure cvScaleAdd(const src1: pCvArr; scale: CvScalar; const src2: pCvArr; dst: pCvArr); cdecl; external File_dll;
  procedure cvSet_(arr: pCvArr; value: CvScalar; const mask: pCvArr=NIL); cdecl; external File_dll Name 'cvSet';
  procedure cvSet1D(arr: pCvArr; idx0: Integer; value: CvScalar); cdecl; external File_dll;
  procedure cvSet2D(arr: pCvArr; idx0, Idx1: Integer; value: CvScalar); cdecl; external File_dll;
  procedure cvSet3D(arr: pCvArr; idx0, Idx1, idx2: Integer; value: CvScalar); cdecl; external File_dll;
  procedure cvSetND(arr: pCvArr; idx: pInteger; value: CvScalar); cdecl; external File_dll;

  procedure cvSetReal1D(arr: pCvArr; idx0: Integer; value: double); cdecl; external File_dll;
  procedure cvSetReal2D(arr: pCvArr; idx0, idx1: Integer; value: double); cdecl; external File_dll;
  procedure cvSetReal3D(arr: pCvArr; idx0, idx1, idx2: Integer; value: double); cdecl; external File_dll;
  procedure cvSetRealND(arr: pCvArr; idx: pInteger; value: double); cdecl; external File_dll;
  procedure cvSolve(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; method: Integer=CV_LU); cdecl; external File_dll;
  procedure cvSolveCubic(const coeffs: pCvArr; roots: pCvArr); cdecl; external File_dll;
  procedure cvSplit(const src: pCvArr; dst0: pCvArr; dst1: pCvArr; dst2: pCvArr; dst3: pCvArr); cdecl; external File_dll;
  function cvSqrt(value: float): float; cdecl; external File_dll;
  procedure cvSub(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
  procedure cvSubRS(const src: pCvArr; value: CvScalar; dst: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
  procedure cvSubS(const src: pCvArr; value: CvScalar; dst: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
  function cvSum(const arr: pCvArr): CvScalar; cdecl; external File_dll;
  procedure cvSVBkSb(const W: pCvArr; const U: pCvArr; const V: pCvArr; const B: pCvArr; X: pCvArr; flags: Integer); cdecl; external File_dll;
  procedure cvSVD(A: pCvArr; W: pCvArr; U: pCvArr=NIL; V: pCvArr=NIL; flags: Integer=0); cdecl; external File_dll;
  function cvTrace(const mat: pCvArr): CvScalar; cdecl; external File_dll;
  procedure cvTransform(const src: pCvArr; dst: pCvArr; const transmat: pCvMat; const shiftvec: pCvMat=NIL); cdecl; external File_dll;
  procedure cvTranspose(const src: pCvArr; dst: pCvArr); cdecl; external File_dll;
  procedure cvXor(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
  procedure cvXorS(const src: pCvArr; value: CvScalar; dst: pCvArr; const mask: pCvArr=NIL); cdecl; external File_dll;
  function cvmGet(const mat: pCvMat; row, col: integer): double; cdecl; external File_dll;
  procedure cvmSet(mat: pCvMat; row, col: Integer; value: double); cdecl; external File_dll;

  //-------------------------Dynamic Structur--------------
  procedure cvClearGraph(graph: pCvGraph); cdecl; external File_dll;
  procedure cvClearMemStorage(storage: pCvMemStorage); cdecl; external File_dll;
  procedure cvClearSeq(seq: pCvSeq); cdecl; external File_dll;
  procedure cvClearSet(setHeader: pCvSet); cdecl; external File_dll;
  function cvCloneGraph(const graph: pCvGraph; storage: pCvMemStorage): pCvGraph; cdecl; external File_dll;
  function cvCloneSeq(const seq: pCvSeq; storage: pCvMemStorage=NIL): pCvSeq; cdecl; external File_dll;
  function cvCreateChildMemStorage(parent: pCvMemStorage): pCvMemStorage; cdecl; external File_dll;
  function cvCreateGraph(graph_flags, header_size, vtx_size, edge_size: Integer; storage: pCvMemStorage): pCvGraph; cdecl; external File_dll;
  function cvCreateGraphScanner(graph: pCvGraph; vtx: pCvGraphVtx=NIL; mask: integer=CV_GRAPH_ALL_ITEMS): pCvGraphScanner; cdecl; external File_dll;
  function cvCreateMemStorage(blockSize: Integer=0): pCvMemStorage; cdecl; external File_dll;
  function cvCreateSeq(seqFlags, headerSize, elemSize: integer; storage: pCvMemStorage): pCvSeq; cdecl; external File_dll;
  function cvCreateSet(set_flags, header_size, elem_size: integer; storage: pCvMemStorage): pCvSet; cdecl; external File_dll;
  function cvCvtSeqToArray(const seq: pCvSeq; elements: Pointer; slice: CvSlice): Pointer; cdecl; external File_dll;
  function cvFindGraphEdge(const graph: pCvGraph; start_idx, end_idx: integer): pCvGraphEdge; cdecl; external File_dll;
  function cvFindGraphEdgeByPtr(const graph: pCvGraph; const startVtx: pCvGraphVtx; const endVtx: pCvGraphVtx): pCvGraphEdge; cdecl; external File_dll;
  function cvGetGraphVtx(graph: pCvGraph; vtx_idx: integer): pCvGraphVtx; cdecl; external File_dll;
  function cvGetSeqElem(const seq: pCvSeq; index: Integer): psChar; cdecl; external File_dll;
  function cvGetSetElem(const setHeader: pCvSet; index: integer): pCvSetElem; cdecl; external File_dll;
  function cvGraphAddEdge(graph: pCvGraph; start_idx: integer): Integer; cdecl; external File_dll;
  function cvGraphAddEdgeByPtr(graph: pCvGraph; start_vtx, end_vtx: pCvGraphVtx; const edge: pCvGraphEdge=NIL; inserted_edge: p2pCvGraphEdge=NIL): integer; cdecl; external File_dll;
  function cvGraphAddVtx(graph: pCvGraph; const vtx: pCvGraphVtx=NIL; inserted_vtx: p2pCvGraphVtx=NIL): integer; cdecl; external File_dll;
  function cvGraphEdgeIdx(graph: pCvGraph; edge: pCvGraphEdge): integer; cdecl; external File_dll;
  procedure cvGraphRemoveEdge(graph: pCvGraph; start_idx, end_idx: Integer); cdecl; external File_dll;
  procedure cvGraphRemoveEdgeByPtr(graph: pCvGraph; start_vtx, end_vtx: pCvGraphVtx); cdecl; external File_dll;
  function cvGraphRemoveVtx(graph: pCvGraph; index: integer): integer; cdecl; external File_dll;
  function cvGraphRemoveVtxByPtr(graph: pCvGraph; vtx: pCvGraphVtx): Integer; cdecl; external File_dll;
  function cvGraphVtxDegree(const graph: pCvGraph; vtxIdx: Integer): Integer; cdecl; external File_dll;
  function cvGraphVtxDegreeByPtr(const graph: pCvGraph; const vtx: pCvGraphVtx): integer; cdecl; external File_dll;
  function cvGraphVtxIdx(graph: pCvGraph; vtx: pCvGraphVtx): Integer; cdecl; external File_dll;
  procedure cvInitTreeNodeIterator(tree_iterator: pCvTreeNodeIterator; const first: Pointer; max_level: Integer); cdecl; external File_dll;
  procedure cvInsertNodeIntoTree(node, parent, frame:  pointer); cdecl; external File_dll;
  function cvMakeSeqHeaderForArray(seq_type, header_size, elem_size: Integer; elements: pointer; total: integer; seq: pCvSeq; block: pCvSeqBlock): pCvSeq; cdecl; external File_dll;
  function cvMemStorageAllocString(storage: pCvMemStorage; const ptr: pChar; len: Integer=-1): CvString; cdecl; external File_dll;
  function cvNextGraphItem(scanner: pCvGraphScanner): integer; cdecl; external File_dll;
  function cvNextTreeNode(tree_iterator: pCvTreeNodeIterator): pointer; cdecl; external File_dll;
  function cvPrevTreeNode(tree_iterator: pCvTreeNodeIterator): Pointer; cdecl; external File_dll;
  procedure cvReleaseGraphScanner(scanner: p2pCvGraphScanner); cdecl; external File_dll;
  procedure cvReleaseMemStorage(storage: p2pCvMemStorage); cdecl; external File_dll;
  procedure cvRestoreMemStoragePos(storage: pCvMemStorage; pos: pCvMemStoragePos); cdecl; external File_dll;
  procedure cvSaveMemStoragePos(const storage: pCvMemStorage; pos: pCvMemStoragePos); cdecl; external File_dll;
  function cvSeqElemIdx(const seq: pCvSeq; const element: pointer; block: p2pCvSeqBlock=NIL): integer; cdecl; external File_dll;
  function cvSeqInsert(seq: pCvSeq; beforeIndex: integer; element: Pointer=NIL): pChar; cdecl; external File_dll;
  procedure cvSeqInsertSlice(seq: pCvSeq; beforeIndex: integer; const fromArr: pCvArr); cdecl; external File_dll;
  procedure cvSeqInvert(seq: pCvSeq); cdecl; external File_dll;
  procedure cvSeqPop(seq: pCvSeq; element: Pointer=NIL); cdecl; external File_dll;
  procedure cvSeqPopFront(seq: pCvSeq; element: Pointer=NIL); cdecl; external File_dll;
  procedure cvSeqPopMulti(seq: pCvSeq; elements: pointer; count: Integer; in_front: Integer=0); cdecl; external File_dll;
  function cvSeqPush(seq: pCvSeq; element: pointer=NIL): pChar; cdecl; external File_dll;
  function cvSeqPushFront(seq: pCvSeq; element: Pointer=NIL): pChar; cdecl; external File_dll;
  procedure cvSeqPushMulti(seq: pCvSeq; elements: Pointer; count: Integer; in_front: Integer=0); cdecl; external File_dll;
  procedure cvSeqRemove(seq: pCvSeq; index: Integer); cdecl; external File_dll;
  procedure cvSeqRemoveSlice(seq: pCvSeq; slice: CvSlice); cdecl; external File_dll;
  function cvSeqSlice(const seq: pCvSeq; slice: CvSlice; storage: pCvMemStorage=NIL; copy_data: integer=0): pCvSeq; cdecl; external File_dll;
  function cvSetAdd(setHeader: pCvSet; elem: pCvSetElem=NIL; inserted_elem: p2pCvSetElem=NIL): integer; cdecl; external File_dll;
  function cvSetNew(setHeader: pCvSet): pCvSetElem; cdecl; external File_dll;
  procedure cvSetRemove(setHeader: pCvSet; index: Integer); cdecl; external File_dll;
  procedure cvSetRemoveByPtr(setHeader: pCvSet; elem: Pointer); cdecl; external File_dll;
  procedure cvSetSeqBlockSize(seq: pCvSeq; deltaElems: Integer); cdecl; external File_dll;
  function cvTreeToNodeSeq(const first: Pointer; header_size: Integer; storage: pCvMemStorage): pCvSeq; cdecl; external File_dll;

  //-------------------------drawing Function--------------
  procedure cvCircle(img: PCvArr; center: CvPoint; radius: longint; color: CvScalar; thickness: longint = 1; line_type: longint=8; shift: longint=0); cdecl; external File_dll;
  function cvClipLine(imgSize: CvSize; pt1, pt2: pCvPoint): Integer; cdecl; external File_dll;
  procedure cvDrawContours(img: pCvArr; contour: pCvSeq; external_color, hole_color: CvScalar; max_level: Integer; thickness: Integer=1; lineType: Integer=8); cdecl; external File_dll;
  procedure cvEllipse(img: pCvArr; center: CvPoint; axes: CvSize; angle: double; start_angle, end_angle: double; color: CvScalar; thickness: Integer=1; lineType: Integer=8; shift: Integer=0); cdecl; external File_dll;
  procedure cvEllipseBox(img: pCvArr; box: CvBox2D; color: CvScalar; thickness: integer=1; lineType: integer=8; shift: integer=0); cdecl; external File_dll;
  procedure cvFillConvexPoly(img: pCvArr; pts: pCvPoint; npts: integer; color: CvScalar; lineType: integer=8; shift: integer=0); cdecl; external File_dll;
  procedure cvFillPoly(img: pCvArr; pts: p2pCvPoint; npts: pInteger; contours: Integer; color: CvScalar; lineType: Integer=8; shift: Integer=0); cdecl; external File_dll;
  procedure cvGetTextSize(const textString: pChar; const font: pCvFont; textSize: pCvSize; baseline: pInteger); cdecl; external File_dll;
  procedure cvInitFont(font: pCvFont; fontFace: integer; hscale, vscale: double; shear: double=0; thickness: Integer=1; lineType: Integer=8); cdecl; external File_dll;
  procedure cvPolyLine(img: pCvArr; pts: p2pCvPoint; npts: pInteger; contours, is_closed: Integer; color: CvScalar; thickness: Integer=1; lineType: Integer=8; shift: Integer=0); cdecl; external File_dll;
  procedure cvPutText(img: pCvArr; const text: pChar; org: CvPoint; const font: pCvFont; color: CvScalar); cdecl; external File_dll;
  procedure cvRectangle(img: pCvArr; pt1, pt2: CvPoint; color: CvScalar; thickness: Integer=1; lineType: Integer=8; shift: Integer=0); cdecl; external File_dll;
  procedure cvLine(img: pCvArr; pt1, pt2: CvPoint; color: CvScalar; thickness: Integer=1; lineType: integer=8; shift: integer=0); cdecl; external File_dll;

  //--------------Utility and System Functions and Macros-------------------------
  function cvGetErrStatus: Integer; cdecl; external File_dll;
  procedure cvSetErrStatus(status: Integer); cdecl; external File_dll;
  function cvGetErrMode: integer; cdecl; external File_dll;
  function cvSetErrMode(mode: Integer): Integer; cdecl; external File_dll;
  function cvError(status: Integer; const func_name: pChar; const err_msg: pChar; const filename: pChar; line: Integer): Integer; cdecl; external File_dll;
  function cvErrorStr(status: Integer): pChar; cdecl; external File_dll;
  function cvRedirectError(error_handler: CvErrorCallback; userdata: Pointer=NIL;  prevUserdata: pPointer=NIL): CvErrorCallback; cdecl; external File_dll;
  function cvNulDevReport(status: integer; const func_name: pChar; const err_msg: pChar; const file_name: pChar; line: Integer; userdata: Pointer): Integer; cdecl; external File_dll;
  function cvStdErrReport(status: integer; const func_name: pChar; const err_msg: pChar; const file_name: pChar; line: Integer; userdata: Pointer): Integer; cdecl; external File_dll;
  function cvGuiBoxReport(status: integer; const func_name: pChar; const err_msg: pChar; const file_name: pChar; line: Integer; userdata: Pointer): Integer; cdecl; external File_dll;
  Function cvAlloc(size: Uint): Pointer; cdecl; external File_dll;
  procedure cvFree(ptr: pPointer); cdecl; external File_dll;
  function cvGetTickCount: Int64; cdecl; external File_dll;
  function cvGetTickFrequency: double; cdecl; external File_dll;
  procedure cvGetModuleInfo(const moduleName: pChar; const version: PpChar; const loadedAddonPlugins: PpChar); cdecl; external File_dll;
  function cvUseOptimized(OnOff: Integer): Integer; cdecl; external File_dll;

  //------------------------------Divers----------------------
  //procedure cvZero(arr: PCvArr); cdecl;
  function cvLoad(const fileName: pChar; memstorage: pCvMemStorage=Nil; name: pChar=nil; real_name: p2pChar=nil): pointer; cdecl; external File_dll;
  procedure cvSave(const fileName: pChar; const struct_ptr: pointer; const name: pChar; const comment: pChar; attributes: CvAttrList); cdecl; external File_dll;

  //---------------------------------------------------------------------------

  function  cvGetRows(const arr: PCvArr; submat: PCvMat; start_row: Integer; end_row: Integer; delta_row: Integer = 1): PCvMat;  cdecl; external File_dll;
  procedure cvScalarToRawData(const scalar: PCvScalar; data: Pointer; typeValue: Integer; extend_to_12: Integer);  cdecl; external File_dll;
  procedure cvRawDataToScalar(const data: Pointer; typeValue: Integer; scalar: PCvScalar);  cdecl; external File_dll;
  function  cvCreateSparseMat(dims: Integer; const sizes: Pint; typeValue: Integer): PCvSparseMat;  cdecl; external File_dll;
  procedure cvReleaseSparseMat(mat: PPCvSparseMat);  cdecl; external File_dll;
  function  cvCloneSparseMat(const mat: PCvSparseMat): PCvSparseMat;  cdecl; external File_dll;
  function  cvInitNArrayIterator(count: Integer; arrs: P2PCvArr; const mask: PCvArr; stubs: PCvMatND; array_iterator: PCvNArrayIterator; flags: Integer): Integer;  cdecl; external File_dll;
  function  cvNextNArraySlice(array_iterator: PCvNArrayIterator): Integer;  cdecl; external File_dll;
  procedure cvSetN(arr: PCvArr; value: CvScalar; const mask: PCvArr = NIL);  cdecl; external File_dll name 'cvSet';
  procedure cvSetZero(arr: PCvArr);  cdecl; external File_dll;
  procedure cvZero(arr: PCvArr); cdecl; external File_dll name 'cvSetZero';
  function  cvCheckTermCriteria(criteria: CvTermCriteria; default_eps: Double; default_max_iters: Integer): CvTermCriteria;  cdecl; external File_dll;
  function  cvCheckArr(const arr: PCvArr; flags: Integer; min_val: Double = 0.0; max_val: Double = 0.0): Integer;  cdecl; external File_dll;
  procedure cvRandArr(rng: pCvRNG; arr: PCvArr; dist_typeValue: Integer; param1: CvScalar; param2: CvScalar);  cdecl; external File_dll;
  //procedure cvRandShuffle(mat: PCvArr; rng: PCvRNG; iter_factor: Double);  cdecl; external File_dll;
  procedure cvSort(const src: PCvArr; dst: PCvArr; idxmat: PCvArr; flags: Integer);  cdecl; external File_dll;
  procedure cvSolvePoly(const coeffs: PCvMat; roots2: PCvMat; maxiter: Integer; fig: Integer);  cdecl; external File_dll;
  procedure cvCompleteSymm(matrix: PCvMat; LtoR: Integer);  cdecl; external File_dll;
  //procedure cvSelectedEigenVV(mat: PCvArr; evects: PCvArr; evals: PCvArr; /: /; highindex: Integer);  cdecl; external File_dll;
  procedure cvSetIdentity(mat: PCvArr; value: CvScalar);  cdecl; external File_dll;
  function  cvRange(mat: PCvArr; startR: Double; endR: Double): PCvArr;  cdecl; external File_dll;
  procedure cvCalcPCA(const data: PCvArr; mean: PCvArr; eigenvals: PCvArr; eigenvects: PCvArr; flags: Integer);  cdecl; external File_dll;
  procedure cvProjectPCA(const data: PCvArr; const mean: PCvArr; const eigenvects: PCvArr; result: PCvArr);  cdecl; external File_dll;
  procedure cvBackProjectPCA(const proj: PCvArr; const mean: PCvArr; const eigenvects: PCvArr; result: PCvArr);  cdecl; external File_dll;
  procedure cvNormalize(const src: PCvArr; dst: PCvArr; a: Double; b: Double; norm_typeValue: Integer; const mask: PCvArr = NIL);  cdecl; external File_dll;
  procedure cvReduce(const src: PCvArr; dst: PCvArr; dim: Integer; op: Integer);  cdecl; external File_dll;
  procedure cvDFT(const src: PCvArr; dst: PCvArr; flags: Integer; nonzero_rows: Integer);  cdecl; external File_dll;
  function  cvSliceLength(slice: CvSlice; const seq: PCvSeq): Integer;  cdecl; external File_dll;
  function  cvMemStorageAlloc(storage: PCvMemStorage; size: Uint): Pointer;  cdecl; external File_dll;
  procedure cvStartAppendToSeq(seq: PCvSeq; writer: PCvSeqWriter);  cdecl; external File_dll;
  procedure cvStartWriteSeq(seq_flags: Integer; header_size: Integer; elem_size: Integer; storage: PCvMemStorage; writer: PCvSeqWriter);  cdecl; external File_dll;
  function  cvEndWriteSeq(writer: PCvSeqWriter): PCvSeq;  cdecl; external File_dll;
  procedure cvFlushSeqWriter(writer: PCvSeqWriter);  cdecl; external File_dll;
  procedure cvStartReadSeq(const seq: PCvSeq; reader: PCvSeqReader; reverse: Integer = 0);  cdecl; external File_dll;
  function  cvGetSeqReaderPos(reader: PCvSeqReader): Integer;  cdecl; external File_dll;
  procedure cvSetSeqReaderPos(reader: PCvSeqReader; index: Integer; is_relative: Integer);  cdecl; external File_dll;
  procedure cvSeqSort(seq: PCvSeq; func: CvCmpFunc; userdata: Pointer);  cdecl; external File_dll;
  function  cvSeqSearch(seq: PCvSeq; const elem: Pointer; func: CvCmpFunc; is_sorted: Integer; elem_idx: Pint; userdata: Pointer): Pschar;  cdecl; external File_dll;
  function  cvSeqPartition(const seq: PCvSeq; storage: PCvMemStorage; labels: P2PCvSeq; is_equal: CvCmpFunc; userdata: Pointer): Integer;  cdecl; external File_dll;
  procedure cvChangeSeqBlock(_reader: Pointer; direction: Integer);  cdecl; external File_dll;
  procedure cvCreateSeqBlock(writer: PCvSeqWriter);  cdecl; external File_dll;
  function  cvInitLineIterator(const image: PCvArr; pt1: CvPoint; pt2: CvPoint; line_iterator: PCvLineIterator; connectivity: Integer; left_to_right: Integer): Integer;  cdecl; external File_dll;
  function  cvColorToScalar(packed_color: Double; arrtypeValue: Integer): CvScalar;  cdecl; external File_dll;
  function  cvEllipse2Poly(center: CvPoint; axes: CvSize; angle: Integer; arc_start: Integer; arc_end: Integer; pts: PCvPoint; delta: Integer): Integer;  cdecl; external File_dll;
  procedure cvRemoveNodeFromTree; cdecl; external File_dll;
  //function  cvKMeans2(const samples: PCvArr; cluster_count: Integer; labels: PCvArr; termcrit: CvTermCriteria; attempts: Integer; rng: PCvRNG; flags: Integer; _centers: PCvArr; compactness: Pdouble): Integer;  cdecl; external File_dll;
  function  cvRegisterModule(const module_info: PCvModuleInfo): Integer;  cdecl; external File_dll;
  function  cvGetErrInfo(const errcode_desc: PPChar; const description: PPChar; const filename: PPChar; line: Pint): Integer;  cdecl; external File_dll;
  function  cvErrorFromIppStatus(ipp_status: Integer): Integer;  cdecl; external File_dll;
  procedure cvSetMemoryManager(alloc_func: CvAllocFunc; free_func: CvFreeFunc; userdata: Pointer);  cdecl; external File_dll;
  procedure cvSetIPLAllocators(create_header: Cv_iplCreateImageHeader; allocate_data: Cv_iplAllocateImageData; deallocate: Cv_iplDeallocate; create_roi: Cv_iplCreateROI; clone_image: Cv_iplCloneImage);  cdecl; external File_dll;
  function  cvOpenFileStorage(const filename: PAnsiChar; memstorage: PCvMemStorage; flags: Integer): PCvFileStorage;  cdecl; external File_dll;
  procedure cvReleaseFileStorage(fs: P2PCvFileStorage);  cdecl; external File_dll;
  function  cvAttrValue(const attr: PCvAttrList; const attr_name: PAnsiChar): PAnsiChar;  cdecl; external File_dll;
  procedure cvStartWriteStruct(fs: PCvFileStorage; const name: PAnsiChar; struct_flags: Integer; const type_name: PAnsiChar; attributes: CvAttrList);  cdecl; external File_dll;
  procedure cvEndWriteStruct(fs: PCvFileStorage);  cdecl; external File_dll;
  procedure cvWriteInt(fs: PCvFileStorage; const name: PAnsiChar; value: Integer);  cdecl; external File_dll;
  procedure cvWriteReal(fs: PCvFileStorage; const name: PAnsiChar; value: Double);  cdecl; external File_dll;
  procedure cvWriteString(fs: PCvFileStorage; const name: PAnsiChar; const str: PAnsiChar; quote: Integer);  cdecl; external File_dll;
  procedure cvWriteComment(fs: PCvFileStorage; const comment: PAnsiChar; eol_comment: Integer);  cdecl; external File_dll;
  procedure cvWrite(fs: PCvFileStorage; const name: PAnsiChar; const ptr: Pointer; attributes: CvAttrList);  cdecl; external File_dll;
  procedure cvStartNextStream(fs: PCvFileStorage);  cdecl; external File_dll;
  procedure cvWriteRawData(fs: PCvFileStorage; const src: Pointer; len: Integer; const dt: PAnsiChar);  cdecl; external File_dll;
  function  cvGetHashedKey(fs: PCvFileStorage; const name: PAnsiChar; len: Integer; create_missing: Integer): PCvStringHashNode;  cdecl; external File_dll;
  function  cvGetRootFileNode(const fs: PCvFileStorage; stream_index: Integer): PCvFileNode;  cdecl; external File_dll;
  function  cvGetFileNode(fs: PCvFileStorage; map: PCvFileNode; const key: PCvStringHashNode; create_missing: Integer): PCvFileNode;  cdecl; external File_dll;
  function  cvGetFileNodeByName(const fs: PCvFileStorage; const map: PCvFileNode; const name: PAnsiChar): PCvFileNode;  cdecl; external File_dll;
  function  cvRead(fs: PCvFileStorage; node: PCvFileNode; attributes: PCvAttrList): Pointer;  cdecl; external File_dll;
  procedure cvStartReadRawData(const fs: PCvFileStorage; const src: PCvFileNode; reader: PCvSeqReader);  cdecl; external File_dll;
  procedure cvReadRawDataSlice(const fs: PCvFileStorage; reader: PCvSeqReader; count: Integer; dst: Pointer; const dt: PAnsiChar);  cdecl; external File_dll;
  procedure cvReadRawData(const fs: PCvFileStorage; const src: PCvFileNode; dst: Pointer; const dt: PAnsiChar);  cdecl; external File_dll;
  procedure cvWriteFileNode(fs: PCvFileStorage; const new_node_name: PAnsiChar; const node: PCvFileNode; embed: Integer);  cdecl; external File_dll;
  function  cvGetFileNodeName(const node: PCvFileNode): PAnsiChar;  cdecl; external File_dll;
  procedure cvRegisterType(const info: PCvTypeInfo);  cdecl; external File_dll;
  procedure cvUnregisterType(const type_name: PAnsiChar);  cdecl; external File_dll;
  function  cvFirsttypeValue: PCvTypeInfo;  cdecl; external File_dll;
  function  cvFindType(const type_name: PAnsiChar): PCvTypeInfo;  cdecl; external File_dll;
  function  cvTypeOf(const struct_ptr: Pointer): PCvTypeInfo;  cdecl; external File_dll;
  procedure cvRelease;  cdecl; external File_dll;
  function  cvClone(const struct_ptr: Pointer): Pointer;  cdecl; external File_dll;
  function  cvGetNumThreads: Integer;  cdecl; external File_dll;
  procedure cvSetNumThreads(threads: Integer);  cdecl; external File_dll;
  function  cvGetThreadNum: Integer;  cdecl; external File_dll;
  function  cvSetImageIOFunctions(_load_image: CvLoadImageFunc; _load_image_m: CvLoadImageMFunc; _save_image: CvSaveImageFunc; _show_image: CvShowImageFunc): Integer;  cdecl; external File_dll;
  
implementation

end.

