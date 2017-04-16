unit OpenCV_Utils;

interface
  uses Windows, Sysutils, Math, Graphics, Types,
       OpenCV_Types, OpenCV_ImgProc, OpenCV_Core;

  Function cvQueryHistValue_1D(hist: pcvHistogram; idx0: Integer): Float;
  Function cvQueryHistValue_2D(hist: pcvHistogram; idx0, idx1: Integer): Float;
  Function cvQueryHistValue_3D(hist: pcvHistogram; idx0, idx1, idx2: Integer): Float;
  Function cvQueryHistValue_nD(hist: pcvHistogram; idx: Integer): Float;

  function cvMat_(rows: Integer; cols: Integer; type_: Integer; data: Pointer): CvMat ;
  Procedure cvMatMul(A,B,D: PCvArr);

  function CV_MAT_TYPE(flags: integer): integer;
  function CV_MAT_DEPTH(flags: integer): integer;
  function CV_MAT_CN(flags: integer): integer;
  function CV_MAT_ELEM(const mat: CvMat; const elemtype: Integer; const row, col: Integer): Pointer;
  function CV_MAT_ELEM_PTR_FAST(const mat: CvMat; const row, col, pix_size: Integer): Pointer;

  Function CV_MAKETYPE(depth, cn: Integer): Integer;
  function CV_ELEM_SIZE(type_: integer): integer;

  procedure CV_NEXT_SEQ_ELEM(elem_size : Integer; var reader : CvSeqReader);
  procedure CV_PREV_SEQ_ELEM(elem_size : Integer; var reader : CvSeqReader);

  Function CV_8UC1: Integer;

  Function cvmGet(const mat: PCvMat; i, j: integer): Single;
//  added Procedure cvmSet(mat: PCvMat; i, j: integer; val: Single);
//  added Function cvPseudoInverse(const src: PCvArr; dst: PCvArr): double;
//  Function cvSize_(width, height: integer): TcvSize;
//  function CV_IS_HAAR_CLASSIFIER(haar: pointer): boolean;
  function cvRect_(x, y, width, height: longint): CvRect;
  function cvPoint_(x, y: longint): CvPoint;
  function cvPointTo32f_(point: CvPoint): CvPoint2D32f;
  function cvPointFrom32f_(point: CvPoint2D32f): CvPoint;
  function cvPoint2D32f_(x, y: single): cvPoint2D32f;
  procedure CV_SWAP(var a, b, t: pointer);

  function cvTermCriteria_(type_: longint; max_iter: longint; epsilon: double): CvTermCriteria;
  function cvFloor(value: double): longint;
  function cvRound(value: double): longint;
  function CvSlice_(start, end_: Integer): CvSlice;

  function CV_RGB(r,g,b: longint): CvScalar;

  function cvScalar_(val0, val1, val2, val3: double): CvScalar;
  function cvScalarAll_(val0123: double): CvScalar;

  procedure cvCalcHist(image:P2PIplImage; hist:PCvHistogram; accumulate:longint; mask:PCvArr);
  procedure cvCalcBackProject(image:P2PIplImage; dst:PCvArr; hist:PCvHistogram);
  procedure cvEllipseBox(img:PCvArr; box:CvBox2D; color:CvScalar; thickness:longint; line_type:longint; shift:longint);
  function hsv2rgb(hue: float) :CvScalar ;
  procedure CvZero_(Arr: Pointer);
  function CvFont_(scale: double=1.0; thickness: integer=1): Cvfont;
  Function cvRealScalar(val0: double): CvScalar;
  function cvGetRow(const arr: pCvArr; subMat: pCvMat; row: Integer): pCvMat;
  function cvGetCol(const arr: pCvArr; submat: pCvMat; col: Integer): pCvMat;
  Function CV_WHOLE_SEQ: cvSlice;
  Function cvContourPerimeter(const contour: Pointer): double;

  function cvImage2Bitmap(img: PIplImage): TBitmap;
  procedure IplImage2Bitmap(iplImg: PIplImage; var bitmap: TBitmap);

  Function cvResize_(Img_Src: pIplImage; NewSize: cvSize): pIplImage;

  Procedure cvCopyImage(Src, Dst: pIplImage);
  procedure cvCvtPixToPlane(const src: pIplImage; dst0: pIplImage; dst1: pIplImage; dst2: pIplImage; dst3: pIplImage);
  procedure cvCvtPlaneToPix(const src0: pCvArr; const src1: pCvArr; const src2: pCvArr; const src3: pCvArr; dst: pCvArr);
  function CV_FOURCC(const c1, c2, c3, c4: Char): Integer;
  function cvRandInt(Var rng: CvRNG): Cardinal;

Implementation

function CV_MAT_ELEM_PTR_FAST(const mat: TCvMat; const row, col, pix_size: Integer): Pointer;
begin
  Assert((Cardinal(row) < mat.rows) and (Cardinal(col) < mat.cols));
  Result := Pointer(Integer(mat.data) + mat.step * row + pix_size * col);
end;

function CV_MAT_ELEM(const mat: TCvMat; const elemtype: Integer; const row, col: Integer): Pointer;
begin
  Result := CV_MAT_ELEM_PTR_FAST(mat, row, col, CV_ELEM_SIZE(elemtype));
end;

function CV_FOURCC(const c1, c2, c3, c4: Char): Integer; 
begin
  Result := Integer(c1) + (Integer(c2) shl 8) + (Integer(c3) shl 16) + (Integer(c4) shl 24);
end;

function cvRandInt(Var rng: CvRNG): Cardinal;
begin
  rng:= CvRNG(rng * CV_RNG_COEFF + (rng shr 32));
  Result := Cardinal(rng);
end;

procedure cvCvtPlaneToPix(const src0: pCvArr; const src1: pCvArr; const src2: pCvArr; const src3: pCvArr; dst: pCvArr);
Begin
  cvMerge(src0, src1, src2, src3, dst);
End;

procedure cvCvtPixToPlane(const src: pIplImage; dst0: pIplImage; dst1: pIplImage; dst2: pIplImage; dst3: pIplImage);
Begin
  cvSplit(src, dst0, dst1, dst2, dst3);
End;

Procedure cvCopyImage(Src, Dst: pIplImage);
Begin
  cvCopy(Src, Dst, 0);
End;

procedure CV_NEXT_SEQ_ELEM(elem_size : Integer; var reader : CvSeqReader);
begin
  inc(reader.ptr, elem_size);
  if (Integer(reader.ptr) >= Integer(reader.block_max)) then
        cvChangeSeqBlock(@reader, 1);
end;

procedure CV_PREV_SEQ_ELEM(elem_size : Integer; var reader : CvSeqReader);
var p: Pointer;
begin
   dec(reader.ptr, elem_size);
   p:= @reader;
   if (Integer(reader.ptr) < Integer(reader.block_min)) then cvChangeSeqBlock(p, -1 );
end;

Function CV_8UC1: Integer;
Begin
    Result:= CV_MAKETYPE(CV_8U, 1);
End;

Function CV_MAKETYPE(depth, cn: Integer): Integer;
Begin
    Result:= (CV_MAT_DEPTH(depth) + (((cn)-1) shl CV_CN_SHIFT));
End;

Function CV_MAT_TYPE(flags: integer): integer;
Begin
    Result:=(flags and CV_MAT_TYPE_MASK);
End;

Function CV_MAT_DEPTH(flags: integer): integer;
Begin
    Result:=(flags and CV_MAT_DEPTH_MASK);
End;

Function CV_MAT_CN(flags: integer): integer;
Begin
    Result:=((flags and CV_MAT_CN_MASK) shr 3)+1;
End;

Function cvResize_(Img_Src: pIplImage; NewSize: cvSize): pIplImage;
  Var Cs, Cs2: cvSize; vRatio: Integer;
Begin
     Cs.Width:= Img_Src.Width; Cs.Height:= Img_Src.Height;
     if Cs.Width > NewSize.Width Then begin
         vRatio:= Cs.Width div NewSize.Width; //vMod:= Cs1.Width mod 320;
         //if vMod > 0 Then vRatio:= vRatio + vMod;
         Cs2.Width:= Cs.Width div vRatio;
   End Else Cs2.Width:= Cs.Width;
     if Cs.Height > NewSize.Height  Then begin
         vRatio:= Cs.Height div NewSize.Height; //vMod:= Cs1.Width mod 320;
         //if vMod > 0 Then vRatio:= vRatio + vMod;
         Cs2.Height:= Cs.Height div vRatio;
   End Else Cs2.Height:= Cs.Height;
     Result:= cvCreateImage(Cs2, Img_Src.Depth, Img_Src.NChannels);
     cvResize(Img_Src, Result);
End;

Function cvContourPerimeter(const contour: Pointer): double;
Begin
    Result:= cvArcLength(contour, CV_WHOLE_SEQ, 1);
End;

Function CV_WHOLE_SEQ: cvSlice;
Begin
    Result:= cvSlice_(0, CV_WHOLE_SEQ_END_INDEX);
End;

  //* Retrieves value of the particular bin of x-dimensional (x=1,2,3,...) histogram */
Function cvQueryHistValue_1D(hist: pcvHistogram; idx0: Integer): Float;
Begin
    Result:= cvGetReal1D(hist.bins, idx0);
End;

Function cvQueryHistValue_2D(hist: pcvHistogram; idx0, idx1: Integer): Float;
Begin
    Result:= cvGetReal2D(hist.bins, idx0, idx1);
End;

Function cvQueryHistValue_3D(hist: pcvHistogram; idx0, idx1, idx2: Integer): Float;
Begin
    Result:= cvGetReal3D(hist.bins, idx0, idx1, idx2);
End;

Function cvQueryHistValue_nD(hist: pcvHistogram; idx: Integer): Float;
Begin
    Result:= cvGetRealND(hist.bins, @idx);
End;

Function cvGetCol(const arr: pCvArr; submat: pCvMat; col: Integer): pCvMat;
Begin
    Result:= cvGetCols(arr, submat, col, col + 1);
End;
  
Function cvGetRow(const arr: pCvArr; subMat: pCvMat; row: Integer): pCvMat;
Begin
    Result:= cvGetRows(arr, submat, row, row + 1, 1);
End;

Function cvRealScalar(val0: double): CvScalar;
  Var scalar: CvScalar;
Begin
    scalar.val[0]:= val0;
    scalar.val[1]:= 0;
    scalar.val[2]:= 0;
    scalar.val[3]:= 0;
    Result:= scalar;
End;


Function CvFont_(scale: double=1.0; thickness: integer=1): Cvfont;
  var Font: CvFont;
Begin
    cvInitFont(@Font, CV_FONT_HERSHEY_PLAIN, scale, scale, 0, thickness, CV_AA);
    Result:= Font;
End;

  procedure CvZero_(Arr: Pointer);
Begin
    CvSet_(Arr, CvScalarAll_(0), 0);
End;

  Procedure cvMatMul(A,B,D: PCvArr);
Begin
    cvMatMulAdd(A,B,nil,D);
End;

Function CV_ELEM_SIZE(type_: integer): integer;
Begin
    Result:=(CV_MAT_CN(type_) shl (($e90 shr CV_MAT_DEPTH(type_)*2) and 3));
End;

Function cvMat_(rows: Integer; cols: Integer; type_: Integer; data: Pointer): CvMat ;
Begin
    assert(CV_MAT_DEPTH(Type_) <= CV_64F);
    type_:= CV_MAT_TYPE(type_);
    Result._type:= CV_MAT_MAGIC_VAL or CV_MAT_CONT_FLAG or type_;
    Result.cols:= cols;
    Result.rows:= rows;
    Result.step:= Result.cols*CV_ELEM_SIZE(type_);
    Result.data:= data;
    Result.refcount:= 0;
End;

Function cvmGet(const mat: PCvMat; i, j: integer): Single;
  var type_: integer; ptr: PUCHAR; pf: PSingle;
Begin
    type_:= CV_MAT_TYPE(mat._type);
    result:=1;
 //   assert( (nil) and
 //      ((pCvHaarClassifierCascade(haar).flags and CV_MAGIC_MASK) = CV_HAAR_MAGIC_VAL);
End;

Function  cvRect_(x, y, width, height: longint): CvRect;
  var r: CvRect;
Begin
    r.x:= x; r.y:= y;
    r.width:= width; r.height:= height;
    result:= r;
End;

Function  cvPointTo32f_(point: CvPoint): CvPoint2D32f;
  var ipt: CvPoint2D32f;
Begin
    ipt.x:= point.x; ipt.y:= point.y;
    result:= ipt;
End;

Function cvPointFrom32f_(point: CvPoint2D32f): CvPoint;
  var ipt: CvPoint;
Begin
    ipt.x:= cvRound(point.x);
    ipt.y:= cvRound(point.y);
    result:= ipt;
End;

  procedure CV_SWAP(var a, b, t: pointer);
Begin
    t:= a;
    a:= b;
    b:= t;
End;

Function cvPoint2D32f_(x, y: single): cvPoint2D32f;
Begin
    result.x:= x;
    result.y:= y;
End;

Function  cvTermCriteria_(type_: longint; max_iter: longint; epsilon: double): CvTermCriteria;
  var t: CvTermCriteria;
Begin
    t.type_:= type_;
    t.maxIter:= max_iter;
    t.epsilon:= epsilon;
    result:= t;
End;

Function cvFloor(value: double): longint;
Begin
    result:= floor(value);
End;

Function cvRound(value: double): longint;
  //var temp: double;
Begin
    result:= Round(value);
End;

Function CvSlice_(start, end_: Integer): CvSlice;
  Var slice: CvSlice;
Begin
    slice.start_index:= start;
    slice.end_index:= end_;
    result:= slice;
End;

Function cvPoint_(x, y: longint): CvPoint;
var p: CvPoint;
Begin
    p.x:= x;
    p.y:= y;
    result:= p;
End;

Function CV_RGB(r,g,b: longint): CvScalar;
Begin
    CV_RGB:= cvScalar_(b, g, r, 0);
End;

Function cvScalar_(val0, val1, val2, val3: double): CvScalar;
  var scalar: CvScalar ;
Begin
    scalar.val[0]:= val0; scalar.val[1]:= val1;
    scalar.val[2]:= val2; scalar.val[3]:= val3;
    result:= scalar;
End;

Function cvScalarAll_(val0123: double): CvScalar;
  var scalar: CvScalar;
Begin
    scalar.val[0]:= val0123; scalar.val[1]:= val0123;
    scalar.val[2]:= val0123; scalar.val[3]:= val0123;
    result:= scalar;
End;

{-----------------------------------}
procedure cvCalcHist(image:P2PIplImage; hist:PCvHistogram; accumulate:longint; mask:PCvArr);
Begin
  //      cvCalcArrHist((CvArr**)image, hist, accumulate, mask);
      cvCalcArrHist(p2pCvArr(image), hist, accumulate, mask);
End;

procedure cvCalcBackProject(image:P2PIplImage; dst:PCvArr; hist:PCvHistogram);
Begin
    cvCalcArrBackProject(P2PCvArr(image), dst, hist);
End;

procedure cvEllipseBox(img:PCvArr; box:CvBox2D; color:CvScalar; thickness:longint; line_type:longint; shift:longint);
var axes: CvSize;
Begin
  axes.width:= cvRound(box.size.height *0.5);
  axes.height:= cvRound(box.size.width *0.5);

  cvEllipse(img, cvPointFrom32f_(box.center), axes, (box.angle*180/pi), 0, 360, color, thickness, line_type, shift);
End;

Function hsv2rgb( hue: float) :CvScalar ;
var rgb: array [0..2] of integer;
    p,sector :integer;
    const sector_data: array [0..5,0..2] of integer=
        ((0,2,1), (1,2,0), (1,0,2), (2,0,1), (2,1,0), (0,1,2));
Begin
    hue:=hue *  0.033333333333333333333333333333333;
    sector:= cvFloor(hue);
    p:= cvRound(255*(hue - sector));
    if (sector and 1) = 1 then p:= 255
    else p:= 0;

    rgb[sector_data[sector][0]]:= 255;
    rgb[sector_data[sector][1]]:= 0;
    rgb[sector_data[sector][2]]:= p;

    result:=  cvScalar_(rgb[2], rgb[1], rgb[0],0);
End;

{-----------------------------------------------------------------------------
  Procedure:  IplImage2Bitmap
  Author:     De Sanctis
  Date:       23-set-2005
  Arguments:  iplImg: PIplImage; bitmap: TBitmap
  Description: convert a IplImage to a Windows bitmap
-----------------------------------------------------------------------------}
procedure IplImage2Bitmap(iplImg: PIplImage; var bitmap: TBitmap);
VAR i, j: Integer; offset: longint; dataByte, RowIn: PByteArray;
    channelsCount: integer;
BEGIN
  TRY
   // assert((iplImg.Depth = 8) and (iplImg.NChannels = 3),
    //            'IplImage2Bitmap: Not a 24 bit color iplImage!');

    bitmap.Height:= iplImg.Height;
    bitmap.Width:= iplImg.Width;
    FOR j:= 0 TO Bitmap.Height-1 DO BEGIN
      // origin BL = Bottom-Left
      if (iplimg.Origin = IPL_ORIGIN_BL) then
         RowIn:= Bitmap.Scanline[bitmap.height -1 -j]
      else
         RowIn:= Bitmap.Scanline[j];

      offset:= longint(iplimg.ImageData) + iplImg.WidthStep * j;
      dataByte:= pbytearray(offset);

      if (iplImg.ChannelSeq = 'BGR') then begin
        {direct copy of the iplImage row bytes to bitmap row}
        CopyMemory(rowin, dataByte, iplImg.WidthStep);
    End else if (iplImg.ChannelSeq = 'GRAY') then
          FOR i:= 0 TO Bitmap.Width-1 DO begin
             RowIn[3*i]:= databyte[i];
             RowIn[3*i+1]:= databyte[i];
             RowIn[3*i+2]:= databyte[i];
        End
      else
          FOR i:= 0 TO 3*Bitmap.Width-1 DO begin
             RowIn[i]:= databyte[i+2] ;
             RowIn[i+1]:= databyte[i+1] ;
             RowIn[i+2]:= databyte[i];
        End;
  End;

  Except

End
END; {IplImage2Bitmap}

function cvImage2Bitmap(img : PIplImage) : TBitmap;
var info : string; bmp : TBitmap; deep: Integer;
    I, J, K, wStep, Channels: Integer; data : PByteArray; pb : PByteArray;
begin
  Result := NIL;
  if (img <> NIL) then begin
    bmp:= TBitmap.Create;
    bmp.Width:= img^.Width; bmp.Height:= img^.Height;
    deep:= img^.nChannels * img^.depth;
    case deep of
      8: bmp.PixelFormat:= pf8bit;
     16: bmp.PixelFormat:= pf16bit;
     24: bmp.PixelFormat:= pf24bit;
     32: bmp.PixelFormat:= pf32bit;
    End;
    wStep:= img^.widthStep;
    Channels:= img^.nChannels;
    data:= Pointer(img^.imageData);
    for I:= 0 to img^.height - 1 do begin
      pb:= bmp.ScanLine[I];
      for J:= 0 to img^.width - 1 do begin
        for K:= 0 to Channels - 1 do pb[3 * J + K]:= data[i * wStep + j * Channels + K]
    End;
  End;
    Result:= bmp;
    //bmp.Free;
End;

end;

end.

