//060406
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O-,P+,Q+,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
unit ScanDrawThread;

interface

uses
  Classes,  Windows,Forms, Messages,SysUtils, Dialogs,  Graphics, Controls,
  extctrls,Math, GlobalType,GlobalScanDataType,MLPC_APILib_TLB,MLPC_APILib_Demo,Activex,
  {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
      GlobalDCl;
 type
  TScanDrawThread = class(TThread)
  private
    flgChangeMaxMinAdd:boolean;
    flgCurPlDelDraw:boolean;
    flgTopViewPlDelDraw:boolean;
    flgTopViewSDelDraw:boolean;
    ErrorController:boolean;
    GreyEntr:byte;
    PointInd:integer;
    PointDrawS:integer;
    PointDrawadd,PointDrawPl:integer;
    ZIndicatorVal:integer;
    ZIndicatorNormVal:single;
    CurrentPoint:Integer;
    CurrentP,NPC:longint;
    XPos,lsz:longint;
    Line: array of TPoint;
    CurrentLine:array of TsinglePoint;  //   { TODO : 300506 }
    CurrentLineAdd:array of TSinglePoint;
    TempAquiData,TempAquiAddData,TempAquiDataZ:TLine;
    SideViewLine: array of TPoint;
    Pend,Pbegin:TPoint;
    ClipRgn: HRGN ;
    TempScanNormData:TScanNormData;
    ReniShawP0discr:integer; // For  Z Model in scanning with Renishaw
    ZminGridModel,ZmaxGridModel:integer; //discr
    GridPerioddiscr:integer;
    //NE II
    ElementSize:Integer;
    nElements,CurChElements:Integer;
    flgDrawVirtualLineNow :boolean;
    mod512corr:integer;   // дополнительный элемент, чтобы исключить  передачу кол-ва
                          // данных, кратных 512
    GetCountDelays_cnt:integer;

    procedure  Init;
    procedure  SpeedBtnView;
    procedure  deInit;
    procedure  DeleteAnomalStep(Tmax,Tmin:datatype;DataDraw:TData;var ZB,ZW:datatype);
//    procedure Convolution(var Mas:TLineSingle;const Size,S:integer);
  protected
    procedure sZIndicator;
    procedure Execute; override;
    procedure Render3D;
    procedure GetScanData(var n:longint; var Data:TExperiment);
    procedure ClearSeries;
    procedure DrawCurrentLine;
    procedure DrawTopView;
    procedure DrawSideView;
    procedure DrawSideViewHide;
    procedure SetPrevLine(const Data:TExperiment);
    procedure CountUpd;
    procedure UpdButtons;
    procedure BoundProc(x,y: integer; var XBound,YBound:integer);
    function  VisiblePoint(x,y:integer):integer;
    procedure SetHorizont(X1,Y1,X2,Y2:integer);
    procedure FindCross(X1,Y1,X2,Y2:integer;const Horizont:ArrayInt; var Xi,Yi:integer);
    procedure DrawSurface(X,Y:integer);
    function  Sign(a:single):integer;
    procedure DrawL;
    procedure CheckImgBounds;
    procedure TopAddViewCorrect;
    procedure TopViewPlaneDelete;
    procedure TopViewSurfDelete;
    procedure MedianFilter;
 // procedure CopyData(var DataDraw:TData; DataIn:TData);
    procedure PrepareScanError(var aScan:Tlinesingle);
    function  ZGridModel(PDiscr:integer; lineShift:integer):integer;
    procedure DrawVirtualLine;

  public
    //  dout,dout_ph:longint;
      constructor Create;
      destructor Destroy; override;
end;

var // FlgStopMulti:Boolean; //Multi pass
     ScDrawThread:TScanDrawThread;
     ScDrawThreadActive : boolean;
     tmaxph,tminph,tmax,tmin:single;
     dout_2,dout_ph_2:longint;
     dout,dout_ph:longint;
     ZW,ZB:single;

implementation

uses Chart,GlobalVar, GlobalFunction, SioCSPM,frScanWnd,frCurrentLine,mMain,
     frContrastTopView,SurfaceTools,CSPMVar, RenishawVars, uScannerCorrect;

var
   XPrev,YPrev:integer;
   DrawX1, DrawY1,
   DrawX2, DrawY2:integer;
   CFlag,PFlag:integer; // Flags of Visible for Current and Previous points;

constructor TScanDrawThread.Create;
begin
  inherited Create(True);
   ErrorController:=false;
   CoInitializeEx(nil,COINIT_MULTITHREADED);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;// Resume;
end;

destructor TScanDrawThread.Destroy;
begin
    CoUnInitialize;
   ThreadFlg:=mDrawing;
//   if (ScanParams.ScanPath<>Multi) and (ScanParams.ScanPath<>MultiY) then PostMessage(ScanWND.Handle,wm_ThreadDoneMsg,ThreadFlg,0)
//                                                                     else PostMessage(ScanWND.Handle,wm_MultiThreadDoneMsg,ThreadFlg,0);
   if (ErrorController) then  PostMessage(ScanWnd.Handle,wm_ThreadDoneMsg,ThreadFlg,lError)
                        else  PostMessage(ScanWnd.Handle,wm_ThreadDoneMsg,ThreadFlg,lOK);
   SideViewLine:=nil;
   inherited destroy;
end;

(*procedure TScanDrawThread.Convolution(var Mas:TLineSingle;const Size,S:integer);
var
 i,r:integer;
 Q,Buf:single;
  Shift,L:integer;
 Temp:  TLineSingle;
begin
 L:=Size;//Length(Mas);
 Shift:=(S-1) div 2;
 SetLength(Temp,L);
 for i:=0 to L-1 do Temp[i]:=Mas[i];
 for i:=0 to Shift-1 do    // Set boundary elements
    begin                // for convolution;
     Temp[i]:=Mas[i];
     Temp[i+L-Shift]:=Mas[i+L-Shift];
    end ;
 for i:=Shift to L-Shift-1 do
   begin
     Q:=0;
    for r:=0 to S-1 do
     begin
      Buf:=Mas[i+r-Shift];
      Q:=Q+Buf;
     end;
     Q:=Q /S;{ TODO : 300305 }
     Temp[i]:=Q;
  end;
  for i:=0 to L-1 do Mas[i]:=Temp[i];
  Temp:=nil;
end;
*)
procedure TScanDrawThread.ClearSeries;
begin
   if  assigned(CurrentLineWnd) then
     begin
      if CurrentLineWnd.SeriesLine.Count<>0       then       CurrentLineWnd.SeriesLine.Clear;
      if CurrentLineWnd.SeriesAddLine.Count<>0    then       CurrentLineWnd.SeriesAddLine.Clear;
      if CurrentLineWnd.SeriesAddLine.Active      then CurrentLineWnd.ChartCurrentLine.LeftAxis.SetMinMax(tminph,tmaxph)
                                                  else CurrentLineWnd.ChartCurrentLine.LeftAxis.SetMinMax(tmin,tmax);
     end
  else
    begin
       if ScanWnd.SeriesLine.Count<>0       then        ScanWnd.SeriesLine.Clear;
       if ScanWnd.SeriesAddLine.Count<>0    then        ScanWnd.SeriesAddLine.Clear;
       if ScanWnd.SeriesAddLine.Active then ScanWnd.ChartCurrentLine.LeftAxis.SetMinMax(tminph,tmaxph)
                                       else ScanWnd.ChartCurrentLine.LeftAxis.SetMinMax(tmin,tmax);
    end;
end;

procedure TScanDrawThread.GetScanData(var n:longint; var Data:TExperiment);
var i,CurrentPoint,CurScan:integer;
    j:longint;
    value:apitype;
    LineSlowAxisPos:integer;
     Zval:integer;
     ZCorr1,ZCorr:integer;
     counterr:integer;
begin
 LineSlowAxisPos:=0;
 counterr:=0;
 j:=XPos;//was =0 for nanoeduII
// if flgCurrentUserLevel=Demo then  j:=n;
 if (ScanParams.ScanPath<>Multi) and (ScanParams.ScanPath<>MultiY) then CurScan:=ScanParams.CurrentScanCount
           else CurScan:=0;
 for i:=0 to lsz-1 do
 begin
  // CurrentPoint:=(CurrentP div  ScanParams.sz)+i-CurScan*(ScanParams.ScanPoints+byte(flgRenishawUnit));
   CurrentPoint:=i;//XPos+i;
   value := datatype(PIntegerArray(DataBuf)[j] shr 16);
 //  value :=round((MinAPITYPE+1)*(value-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));
 // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! для выяснения

   if flgFirstPass then
    begin
      if ((ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY)) then ScanError[CurrentPoint]:=value;
    end;

     TempAquiDataZ[i]:=value;
      if value=1 then  inc(counterr);
     if(ScannerCorrect.flgZLinear) then  // Вставлено 27/10/2016 , чтобы линеаризовать Z
     begin
        if (ScannerCorrect.FlgZLinAbs) then
           begin
             (*ZCorr1 :=  ZLinCorrect(round(TempScanNormData.PreviousMin - minDATATYPE));     // discr
             ZCorr2 :=  ZLinCorrect(round(valueCur - minDATATYPE));     // discr
             ZCorr := ZCorr2 - ZCorr1;*)
           //  ZCorr1 :=  ZLinCorrect(round(value - minDATATYPE));     // discr
             ZCorr1 :=  ZLinCorrect(round(maxDATATYPE-value ));     // discr
             ZCorr  := round(maxDATATYPE-ZCorr1);
           end
           else
           begin
             ZCorr1 := round( value-TempScanNormData.PreviousMin);  // discr
             ZCorr := ZLinCorrect(ZCorr1);     // discr
           end;
           if(ZCorr > MaxDATATYPE) then ZCorr := MaxDATATYPE;
           if(ZCorr < MinDATATYPE) then ZCorr := MinDATATYPE;
      value :=  ZCorr;
      end;
     TempAquiData[i]:=value;
  if  CurrentPoint<ScanParams.ScanPoints then
  begin  // (**)
     // Formlog.memolog.Lines.add('current scancount'+inttostr(ScanParams.CurrentScanCount));

       case ScanParams.ScanPath of
          Multi,OneX: Data.AquiTopo.Data[CurrentPoint,ScanParams.CurrentScanCount]:=value;
         MultiY,OneY: Data.AquiTopo.Data[ScanParams.CurrentScanCount,CurrentPoint]:=value;
         end;

     if  ScanParams.ScanMethod  in ScanmethodSetAdd then
     //Additional View
      begin
         inc(j);
         value :=datatype(PIntegerArray(DataBuf)[j] shr 16);
   (*    case ScanParams.ScanMethod of
       UAM:begin
          //  if value<0 then value:=0 ;
           end;
             end;
   *)

        TempAquiAddData[i]:=value;
        if value<TempScanNormData.datminph then
        begin
           TempScanNormData.datminph:=value;
           flgChangeMaxMinAdd:=true;
        end
        else
        if value>TempScanNormData.datmaxph then
        begin
         TempScanNormData.datmaxph:=value;
         flgChangeMaxMinAdd:=true;
        end;
          case ScanParams.ScanPath of
              Multi,OneX: Data.AquiAdd.Data[CurrentPoint,ScanParams.CurrentScanCount]:=value;
             MultiY,OneY: Data.AquiAdd.Data[ScanParams.CurrentScanCount,CurrentPoint]:=value;
                   end;
      end;//add
    if flgRenishawUnit then
     begin
         inc(j);
         value :=datatype(PIntegerArray(DataBuf)[j]);
         if CurrentPoint=0 then ReniShawP0discr:=abs(value);
          case ScanParams.ScanPath of
           Multi,OneX: Data.AquiRenishaw.Data[CurrentPoint,ScanParams.CurrentScanCount]:=value;
           MultiY,OneY:Data.AquiRenishaw.Data[ScanParams.CurrentScanCount,CurrentPoint]:=value;
          end; {case}
           // Change Z to Model Value
         {$IFDEF DEBUG}
           if flgReniShawUnit {and ( ReniShowParams.StepScale>1)} then
             begin
                if CurrentPoint=0 then TempAquiData[i]:=ZminGridModel
                else
                         case RenishawParams.flgscriptname of
                1,3,4,6,7,8:         // stepxy>= period_nm
                                  TempAquiData[i]:= ZGridModel(abs(value)-ReniShawP0discr,100*ScanParams.CurrentScanCount);
                        2,5:             // stepxy< period_nm
                                  TempAquiData[i]:= ZGridModel(abs(value)-ReniShawP0discr,abs(LineSlowAxisPos));
                         end;   // case

                case ScanParams.ScanPath of
                 Multi,OneX: Data.AquiTopo.Data[CurrentPoint,ScanParams.CurrentScanCount]:=TempAquiData[i];
                MultiY,OneY: Data.AquiTopo.Data[ScanParams.CurrentScanCount,CurrentPoint]:=TempAquiData[i];
                end;
             end;
            // model data   *)
       {$ENDIF}
         // dec(j);
     end;
      //inc(j, ScanParams.sz);
      inc(j);
  end   // (**)
  else
  begin
         if flgRenishawUnit then
         begin
            value :=datatype(PIntegerArray(DataBuf)[j]);
            LineSlowAxisPos:=value;  // For Z Model
           case ScanParams.ScanPath of
             Multi,OneX: Data.AquiRenishaw.Data[CurrentPoint,ScanParams.CurrentScanCount]:=value;
             MultiY,OneY:Data.AquiRenishaw.Data[ScanParams.CurrentScanCount,CurrentPoint]:=value;
           end;  {case}
           dout:=dout-1;
           value :=datatype(PIntegerArray(DataBuf)[j+1]);
           if ScanParams.sz>2 then  value :=datatype(PIntegerArray(DataBuf)[j+2]);
             inc(j,ScanParams.sz);
         end;
  end;
 end; //i
 // n:=j;//n+j;     //nanoeduII
   if counterr>10 then ErrorController:=true;
  XPos:=j+Scanparams.sz;
end;

procedure  TScanDrawThread.deInit;
begin
   SelectClipRgn(ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.Handle,ClipRgn);
   DeleteObject(ClipRgn);
end;

procedure  TScanDrawThread.SpeedBtnView;
begin
      if ScanParams.CurrentScanCount>4 then
        begin
         ScanWnd.SpeedBTnCaptureL.Visible:=true;
         ScanWnd.SpeedBTnCapture.Visible :=true;
         ScanWnd.SpeedBtnContrast.Visible:=not Scanparams.flgAquiAdd;//(Scanparams.sz-byte(flgRenishawUnit)=1);
         ScanWnd.SpeedBtnContrL.Visible:=Scanparams.flgAquiAdd;//not (Scanparams.sz-byte(flgRenishawUnit)=1);
        end;
end;
procedure  TScanDrawThread.DeleteAnomalStep(Tmax,Tmin:datatype;DataDraw:TData;var ZB,ZW:datatype);
var NY,NX,i,j:Integer;
    countW,CountB:integer;
    flg:boolean;
begin
   case ScanParams.ScanPath of
Multi,oneX: begin
      NX:=ScanParams.ScanPoints;  Ny:=ScanParams.CurrentScanCount;
     end;
MultiY,oneY:begin
      Nx:=ScanParams.CurrentScanCount;       Ny:=ScanParams.ScanPoints;
     end;
        end;
           flg:=false;
repeat
  countW:=0;  countB:=0;
 for i:=0 to  NY-1 do
  for j:=0 to  NX-1 do
  begin
   if   DataDraw.Data[j,i]<=ZW*Tmax      then inc(CountW)
    else if  DataDraw.Data[j,i]>=ZB*Tmin then inc(CountB);
  end;
 //  if (CountB/(CountB+CountW))>0.1 then
 if true then
   begin
    ZW:=Tmin+(TMax-Tmin) div 2;
  //  ZB:=Tmin+(TMax-Tmin) div 2;
    flg:=true;//false;
   end else flg:=true;
 until flg;
end;

procedure  TScanDrawThread.Init;
begin
   ClipRgn := CreateRectRgn(0,0,ScanParams.ScanPoints,ScanParams.ScanLines);
   SelectClipRgn(ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.Handle,ClipRgn);

 if  ScanWnd.SeriesAddLine.Active then ScanWnd.ChartCurrentLine.LeftAxis.SetMinMax(tMinph,tMaxph)
                                  else ScanWnd.ChartCurrentLine.LeftAxis.SetMinMax(tMin,tMax);
 if  FlgFirstPass then
                          begin
                              ScanWnd.TabSheetCurScan.caption:=strsdrw;//'Topo ,nm' ;
                                   case    ScanParams.ScanMethod    of
                                Phase:  ScanWnd.TabSheetCurLineAdd.caption:=strsdrw2;// 'Phase,a.u' ;
                                  UAM:  ScanWnd.TabSheetCurLineAdd.caption:=strsdrw3;// 'Force,mv'  ;
                              Current: ScanWnd.TabSheetCurLineAdd.caption:=strsdrw4;//'Current,nA'  ;
                                       end;

                          end
                          else
                          begin
                              ScanWnd.TabSheetCurScan.caption:=ScanWnd.siLangLinked1.GetTextOrDefault('IDS_10' (* 'Topo ,nm; II' *) ) ;
                                  case    ScanParams.ScanMethod    of
                                Phase:  ScanWnd.TabSheetCurLineAdd.caption:=ScanWnd.siLangLinked1.GetTextOrDefault('IDS_11' (* 'Phase,a.u; II' *) ) ;
                                  UAM:  ScanWnd.TabSheetCurLineAdd.caption:=ScanWnd.siLangLinked1.GetTextOrDefault('IDS_12' (* 'Force,mv; II' *) ) ;
                              Current: ScanWnd.TabSheetCurLineAdd.caption:=ScanWnd.siLangLinked1.GetTextOrDefault('IDS_13' (* 'Current,nA; II' *) ) ;
                                           end;
                          end;
            if assigned(CurrentLineWnd)  then
             if CurrentLineWnd.SeriesAddLine.Active then
              begin
               CurrentLineWnd.Caption:=ScanWnd.siLangLinked1.GetTextOrDefault('IDS_249' (* 'Current Line ' *) )+ScanWnd.TabSheetCurLineAdd.Caption ;
              end
              else
              begin
                CurrentLineWnd.Caption:=ScanWnd.siLangLinked1.GetTextOrDefault('IDS_249' (* 'Current Line ' *) )+ScanWnd.TabSheetCurScan.Caption;
              end;
end;

procedure  TScanDrawThread.DrawSideViewHide;
var k,j:integer;
 vv,hV: single;
begin
    if ((ScanParams.CurrentScanCount mod ScanSelectKoef)=0) then
          begin
           hV:=h/ScanWNd.SideVScale/TempScanNormData.previousDZ;
           for k:=1 to round(2*sqrt(PointSelectKoef)) do
           Convolution(TempScanNormData.PrevLine,ScanParams.ScanPoints,3);
           k:=0;
          for j:=0 to (ScanParams.ScanPoints-1) do
           begin
            if ((j mod PointSelectKoef)= 0) then
             begin
           //      vv :=hV*(TempScanNormData.previousMax-TempScanNormData.PrevLine[j]);
           vv :=hV*(TempScanNormData.PrevLine[j]- TempScanNormData.previousMin);              // изменено 01/08/2013
                 SideViewLine[k].X:=Trunc(kw*(sin1*ScanParams.CurrentScanCount + sin2*j));
                 SideViewLine[k].Y:=h-href + Trunc(kh*(cos1*ScanParams.CurrentScanCount + cos2*j) +vv);
                 inc(k);
             end;
           end;
           XPrev:=SideViewLine[0].X;
           YPrev:=SideViewLine[0].Y;
           BoundProc(XPrev,YPrev,XLeft,YLeft);
           Pflag:=VisiblePoint(XPrev,YPrev);
           for j:=0 to SideLinePointsNmb-1 do DrawSurface(SideViewLine[j].X,SideViewLine[j].Y);
           BoundProc(SideViewLine[SideLinePointsNmb-1].X,SideViewLine[SideLinePointsNmb-1].Y,XRight,YRight);
        end;
end;

procedure TScanDrawThread.SetPrevLine(const Data:TExperiment);
var j:integer;
begin
   for j:=0 to ScanParams.ScanPoints-1 do
            case ScanParams.ScanPath of
 Multi,OneX: TempScanNormData.PrevLine[j]:=Data.AquiTopo.Data[j,ScanParams.CurrentScanCount];
MultiY,OneY: TempScanNormData.PrevLine[j]:=Data.AquiTopo.Data[ScanParams.CurrentScanCount,j];
                   end;
             LinDelFiltPlaneParm(ScanParams.ScanPoints,TempScanNormData.PrevLine,TempScanNormData.sfA,TempScanNormData.sfB);
             TempScanNormData.previousMin:=MaxApiType;// PrevLine[0]-sfA;
             TempScanNormData.previousMax:=MinApiType;// previousMin;
           for j := 0 to ScanParams.ScanPoints- 1 do
               begin
                {if flgCurPlDelDraw then }
                TempScanNormData.PrevLine[j]:=TempScanNormData.PrevLine[j]-( TempScanNormData.sfA+ TempScanNormData.sfB*j) ;
                if TempScanNormData.PrevLine[j] < TempScanNormData.previousMin then TempScanNormData.previousMin :=TempScanNormData.PrevLine[j];
                if TempScanNormData.PrevLine[j] > TempScanNormData.previousMax then TempScanNormData.previousMax :=TempScanNormData.PrevLine[j];
               end;
      TempScanNormData.previousDZ:=TempScanNormData.previousMax-TempScanNormData.previousMin;
     if  TempScanNormData.previousDZ=0 then   TempScanNormData.previousDZ:=1;
end;

procedure TScanDrawThread.Execute;
var
 ScanFlg:Boolean;
 ds,icountPL,icountS,icountadd,NLines:integer;
 NewPCount:longint;
 i:dword;
 errScan:word;
 PointsNmb:integer;
 value:apitype;
// fs:fifo_desc;
 OneLinePointsNmb:integer;
 ntoread,nhasread:integer;
 //NE II
    hr:HResult;
    flgEnd:boolean;
    NChElements,CurChElements,nRead:integer;
    nInLine:integer;    //numbers points in line + correction
    nrepeat:integer;
    n,ID,nwrite,errorcountstop,count:integer;
    data:integer;
 ///   pstopval:Pinteger;
    errcnt:integer;
 /// Параметры для имитации в ДЕМО
    smooth0_nm:single;
    noise0_discr, noise_speed0_discr:datatype; depth0_nm:single;
    lithodepth0_nm:single;
    smooth_nm:single;
    noise_discr, noise_speed_discr:datatype; depth_nm:single;
    lithodepth_nm:single;
 ///
   hasRead_nmb, left_toRead:integer;
   label  100;
begin
 if currentUserLevel = 'Demo'  then
 calcDemoImitationParams(fsourceScanrate, fSourceFBGain, 0, smooth0_nm, noise0_discr, noise_speed0_discr, depth0_nm,
                                                    lithodepth0_nm);
// GetTimeNow(StartHour, startMin, StartSec, startMsec);
    //nanoeduII
    if flgCurrentUserLevel = demo then mod512corr:=0
    else mod512corr:=1;   //mod512corr:=1;
    flgDrawVirtualLineNow:=True;
   SetScanNormData(ScanNormData);
   if flgRenishawUnit then  OneLinePointsNmb:= ScanParams.ScanPoints+1
                      else  OneLinePointsNmb:= ScanParams.ScanPoints;
   if (ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY) then
                                 begin
                                    NLines:=1;
                                    PointsNmb:=OneLinePointsNmb*ScanParams.sz;
                                  end
                                 else
                                 begin
                                   NLines:=ScanParams.ScanLines;
                                   PointsNmb:=OneLinePointsNmb*ScanParams.ScanLines*ScanParams.sz;
                                 end;
   if FlgFirstPass then TempScanNormData:=ScanNormData
                   else TempScanNormData:=ScanNormData_2_Pass;
  //Zcontrast top view params
   TopViewFromRGB:=$00000000;;
   TopViewToRGB:= $00FFFFFF;
   GreyEntr:=255;
   ZW:=1;
   ZB:=0;
 //  new(PStopVal);
   flgChangeMaxMinAdd:=false;
   CurrentPoint:=0;
//  for model rs data
   ZminGridModel:=5000;
   ZmaxGridModel:=15000; //discr
   GridPerioddiscr:=4*140;
//
   n:=0;
   icountS:=-1;
   icountPl:=-1;
   icountadd:=0;
   XPos:=0;
   CurrentP:=0;
   dout:=0;
   dout_ph:=0;
   ds:=1;                //
   ScanFlg:=False;
   dout_2:=0;
   dout_ph_2:=0;   { TODO : 240306 }
   if ScanParams.CurrentScanCount=0 then
   begin
    TempScanNormData.previousMin:=TempScanNormData.datmin;
    TempScanNormData.previousMax:=TempScanNormData.datmax;
    TempScanNormData.previousDZ :=TempScanNormData.ScaleZ0;
   end;
   flgCurPlDelDraw:=ScanParams.flgTopoCurLinePlDel;//True;
   flgTopViewPlDelDraw:=ScanParams.flgTopoTopViewPlDel;
   SetLength(SideViewLine,SideLinePointsNmb+2);
   tMinph:=0;
   tMaxph:=0;
   tMin:=0;
   tMax:=0;
   PointDrawS:=ScanParams.ScanLines div 100;
   if PointDrawS<1 then PointDrawS:=1;
   PointDrawPl:=PointDrawS;
   PointDrawadd:=Pointdrawpl;
   Synchronize(Init);
   errcnt:=0;
////NE II
try
   {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_0' (* 'Start drawing' *) ));
   {$ENDIF}
if CreateChannels(AlgParams.NChannels) then
 begin
  if   ScannerCorrect.FlgXYLinear and (HardWareOpt.XYtune='Rough')and (not FlgReniShawUnit) then
   begin     // Создание канала для передачи данных шагов линеаризации
        hr:=arPCChannel[ch_LINEAR_STEPS].Main.get_Geometry(NChElements,ElementSize);
       {$IFDEF DEBUG}
        if Failed(hr)
         then Formlog.memolog.Lines.add('ERR read Linear Steps'+inttostr(nread)+'hr='+inttostr(hr))
         else Formlog.memolog.Lines.add('Linear Steps: Elements='+inttostr(NChElements)+'size='+inttostr(ElementSize));
      {$ENDIF}
      nwrite:=NChElements;

      hr:=arPCChannel[ ch_LINEAR_STEPS].ChannelWrite.Write(LINEARSTEPSAct,nwrite);     //WRITE
         {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error write Linear Steps'+inttostr(nwrite)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('ok write Linear Steps ' +' data size ='+inttostr(nwrite));
             {$ENDIF}
      end;

   arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
  if ID=ch_Data_OUT then
  begin
    flgEnd:=false;
    hr:=arPCChannel[ch_Data_out].Main.get_Geometry(NChElements,ElementSize);
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_4' (* 'error read geometry' *) )+inttostr(nread)+ScanWnd.siLangLinked1.GetTextOrDefault('IDS_5' (* 'hr=' *) )+inttostr(hr))
                      else Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_6' (* 'Channel data; Elements=' *) )+inttostr(NChElements)+ScanWnd.siLangLinked1.GetTextOrDefault('IDS_7' (* 'size=' *) )+inttostr(ElementSize));
      {$ENDIF}
    CurChElements:=0;   // current of elements
  //  dataoutcount:=0;
     nread:=0; XPos:=0;
    GetCountDelays_cnt:=0;
    GetTimeNow(StartHour, startMin, StartSec, startMsec);
 while (not Terminated) and (CurrentP<PointsNmb) and (not flgEnd) and (not ErrorController) do
 begin
       nread:=1;
        if FlgStopJava then
         begin
      //     sleep(500);
           PintegerArray(StopBuf)[0]:=StopJava;
           repeat
           begin
            nwrite:=1;
            hr:=arPCChannel[ch_stop].ChannelWrite.Write(StopBuf,nwrite);     //read stop channel  if stopbutton pressed  pStopval^=done
            if Failed(hr) then
                {$IFDEF DEBUG}
                  Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_14' (* 'error write stop channel' *) )+inttostr(nwrite)+ScanWnd.siLangLinked1.GetTextOrDefault('IDS_5' (* 'hr=' *) )+inttostr(hr))
               {$ENDIF}
                else
               {$IFDEF DEBUG}
                    Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_16' (* 'write stop channel =' *) )+inttostr(PIntegerArray(StopBuf)[0])+' '+inttostr(nwrite));
               {$ENDIF};
               inc(errorcountstop)
           end
           until not Failed(hr) and (errorcountstop<50);
           sleep(300);
          repeat
            nread:=1;
            hr:=arPCChannel[ch_Draw_done].ChannelRead.Read(DoneBuf,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_27' (* 'error read stop channel' *) )+inttostr(nread)+ScanWnd.siLangLinked1.GetTextOrDefault('IDS_5' (* 'hr=' *) )+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_29' (* 'read stop channel =' *) )+inttostr(PIntegerArray(DoneBuf)[0])+' '+inttostr(nread));
            {$ENDIF}
            inc(count);
      //      if flgCurrentUserLevel<>Demo then StopBuf^:=done;
            sleep(100);
          until  (PIntegerArray(DoneBuf)[0]=done) or (count=20);
          if PIntegerArray(DoneBuf)[0]=done then   flgEnd:=true; //stop button press       stop scanning
         end;//stopjava
        // sleep(300);
        sleep(GETCOUNT_DELAY);
        inc(GetCountDelays_cnt);
         hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(ntoread);     //get new data count
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_31' (* 'error get count data ' *) )+inttostr(ntoread)+ScanWnd.siLangLinked1.GetTextOrDefault('IDS_5' (* 'hr=' *) )+inttostr(hr))
                      else Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_33' (* 'scandraw data to read ' *) )+inttostr(ntoread));
       {$ENDIF}
    if GetCountDelays_cnt*GETCOUNT_DELAY > 1000 then  // мигать зеленой линией 1 раз/секунду
          begin
             synchronize(DrawVirtualline);
             GetCountDelays_cnt:=0;
          end;
     if ntoread >= ScanParams.ScanPoints +mod512corr then   nhasread:=0; // +1 - лишняя точка, чтобы исключить передачу данных длиной,
     nInLine:= (ScanParams.ScanPoints+mod512corr);
      hr:=(arPCChannel[ch_Data_out].ChannelRead).Read(DataBuf,ntoread);
     {$IFDEF DEBUG}
       if Failed(hr) then Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_36' (* 'error read channel data ' *) )+inttostr(nread)+ScanWnd.siLangLinked1.GetTextOrDefault('IDS_5' (* 'hr=' *) )+inttostr(hr))
                     else Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_39' (* 'scandraw data has read ' *) )+inttostr(ntoread));
      {$ENDIF}
        if Failed(hr) then
                    begin
                      nread:=0;
                      inc(errcnt); //
                   end;
       if errcnt> 100  then
                 begin
                    flgEnd:=true;
                      {$IFDEF DEBUG}
                            Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_42' (* 'STOP : NMB of CHANNEL ERRORS =   ' *) )+inttostr(errcnt));
                      {$ENDIF}
                 end;
      nrepeat:=(ntoread div nInLine);
      XPos:=0;;
  if (nrepeat>0) then
begin
   Formlog.memolog.Lines.add('nlines'+inttostr(nrepeat));
   for i:=0 to nrepeat-1
   do
   begin
       if (XPos=0){ and ((i<>0))}then
       begin
       // synchronize(ClearSeries);
            flgCurPlDelDraw:=ScanParams.flgTopoCurLinePlDel;
        flgTopViewPlDelDraw:=ScanParams.flgTopoTopViewPlDel;
        flgTopViewSDelDraw :=ScanParams.flgTopoTopViewSDel;
       end;
        nread:=ScanParams.ScanPoints;
        ScanFlg:=True;
    if ScanFlg then    //flag the end line     //
    begin
        try
             lsz:=nread;
             NPC:=nread*Scanparams.sz;
             SetLength(TempAquiData,lsz);
             SetLength(TempAquiDataZ,lsz);
             SetLength(CurrentLine,lsz);
         if  ScanParams.flgAquiAdd then
           begin
             SetLength(TempAquiAddData,lsz);
             SetLength(CurrentLineAdd,lsz);
           end;
         if flgFirstPass     then  begin
                                     GetScanData(Dout_PH,ScanData);             //get data from buffer
                                     if (flgCurrentUserLevel = Demo) and (flgApproachOK) then
                                                 begin
                                                    CalcDemoImitationParams(ScanParams.ScanRate, PidParams.Ti, 0, smooth_nm, noise_discr, noise_speed_discr, depth_nm,
                                                    lithodepth_nm);

                                                    FBGain_Speed_DemoImitation((smooth_nm-smooth0_nm), noise_discr-noise0_discr,
                                                                                       noise_speed_discr-noise_speed0_discr,
                                                                                      (depth_nm-depth0_nm), 0, ScanData.AquiTopo, TempAquiData);

                                                    if  Scanparams.Scanmethod in ScanmethodSetAdd then
                                                          begin
                                                                case ScanParams.ScanMethod of
                                                                   Phase: begin
                                                                                     FBGain_Speed_DemoImitation(0, noise_discr-noise0_discr,
                                                                                        noise_speed_discr-noise_speed0_discr,
                                                                                        0, 0, ScanData.AquiAdd, TempAquiAddData);
                                                                          end;

                                                                    UAM:   begin
                                                                                    FBGain_Speed_DemoImitation(-(smooth_nm-smooth0_nm), noise_discr-noise0_discr,
                                                                                       noise_speed_discr-noise_speed0_discr,
                                                                                      -(depth_nm-depth0_nm), 0, ScanData.AquiAdd, TempAquiAddData);
                                                                           end;
                                                                end;
                                                          end;

                                                 end;    //demo

                                   end
                             else  begin        // not flgFirstPass
                                     GetScanData(Dout_PH_2,ScanDataSecondPass);
                                     if flgCurrentUserLevel = Demo then
                                                   // FBGain_Speed_DemoImitation(ScanDataSecondPass.AquiTopo);
                                                    // if  Scanparams.Scanmethod in ScanmethodSetAdd then
                                                    //               FBGain_Speed_DemoImitation(ScanDataSecondPass.AquiAdd);
                                  end;


            synchronize(ClearSeries);
        // перенос 23.12.13
               if flgFirstPass then
                           begin
                             SetPrevLine(ScanData);
                             if (ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY) then
                             begin
                               value:=datatype(PIntegerArray(DataBuf)[ScanParams.ScanPoints*ScanParams.Sz]) shr 16;
                           //    if value>0 then value:=0 else   value:=abs(value+1);
                               ScanError[ScanParams.ScanPoints]:=value;
                                  case ScanParams.flgFilter of
                             1:  Convolution(ScanError,ScanParams.ScanPoints,3);
                             2:  Convolution(ScanError,ScanParams.ScanPoints,5);
                                    end;
                               PrepareScanError(ScanError);
                             end;

                           end

                           else SetPrevLine(ScanDataSecondPass);
       //
            Synchronize(DrawTopView);
        if not  FlgStopMulti then    Synchronize(DrawCurrentLine);
         if  not ScannerCorrect.flgHideLine then
                 begin
                  SetLength(line,lsz);
                  Render3D;
                  Synchronize(DrawSideView);
                 end;
        finally
              line:=nil;
              CurrentLine:=nil;
              if  ScanParams.flgAquiAdd then CurrentLineAdd:=nil;
        end;
       CurrentP:=CurrentP+NPC;
//     XPos:=XPos+nInLine;// +lsz; !!!!!!!  150616 //NPC
//     if ScanFlg then    //flag the end line
//     begin
        tminph:=0;
        tmaxph:=0;
        tmin:=0;
        tmax:=0;
        inc(icountS);
        inc(icountPl);
        inc(icountadd);

     if  ScannerCorrect.flgHideLine   and FlgFirstPass   then DrawSideViewHide;
     if ((ScanParams.ScanPath<>Multi) and (ScanParams.ScanPath<>MultiY)) or (not FlgFirstPass) then  inc(ScanParams.CurrentScanCount);
       {$IFDEF DEBUG}
         Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_45' (* 'line ' *) )+inttostr(ScanParams.CurrentScanCount));
       {$ENDIF}
     Synchronize(SpeedBtnView);
     if not FlgStopMulti then   //011209
     begin
      if flgTopViewSDelDraw and (ScanParams.ScanMethod<>OneLineScan) then
       if ((ScanParams.CurrentScanCount>4) and (icountS>PointDrawS))  then
        begin
         icountS:=0;
         Synchronize(TopViewSurfDelete);
        end;
      if flgTopViewPlDelDraw and (ScanParams.ScanMethod<>OneLineScan) then
       if ((ScanParams.CurrentScanCount>4) and (icountPl>PointDrawPl))then
        begin
          Synchronize(TopViewPlaneDelete);
          icountPL:=0;
        end;
      if Scanparams.Scanmethod in ScanmethodSetAdd then
       if flgChangeMaxMinAdd then
       begin
        Synchronize(TopAddViewCorrect);
        flgChangeMaxMinAdd:=false;
       end;
     end;
      // XPos:=0;
     //  PointInd:=0;
       ScanFlg:=False;
       Synchronize(CountUpd);
    end; //scanflg
   end;// i
   end;//repeat
 end; {while terminate ScanCount}
end;  //ID not data channel
   //  if flgEnd then
      begin
         FlgScanError:=False;
         ScanDone;
         FreeChannels;
       if (ScanParams.ScanPath<>Multi) and (ScanParams.ScanPath<>MultiY)
        then  PostMessage(ScanWnd.Handle,wm_ThreadDoneMsg,mScanning,0)
        else  PostMessage(ScanWnd.Handle,wm_MultiThreadDoneMsg,mScanning,0);
      end;
if not  FlgStopMulti then
   if ScanParams.CurrentScanCount=ScanParams.ScanLines then FlgStopMulti:=true;
if ((ScanParams.ScanPath<>Multi) and  (ScanParams.ScanPath<>MultiY)) or(FlgStopMulti )then
begin
  if  ScanParams.CurrentScanCount<=3 then   FlgScanError:=True;
//251110
 if FlgScanError then
  begin
        ScanData.AquiTopo.Ny:=0;
        ScanData.AquiAdd.Ny :=0;
        ScanData.AquiTopo.Nx:=0;
        ScanData.AquiAdd.Nx :=0;
    case ScanParams.ScanPath of
Multi,MultiY
   :begin
        ScanDataSecondPass.AquiTopo.Ny:=0;
        ScanDataSecondPass.AquiAdd.Ny :=0;
        ScanDataSecondPass.AquiTopo.Nx:=0;
        ScanDataSecondPass.AquiAdd.Nx :=0;
    end;
       end;
  end;

       case ScanParams.ScanPath of
Multi:begin
        ScanData.AquiTopo.Ny:=ScanParams.CurrentScanCount;
        ScanData.AquiAdd.Ny :=ScanParams.CurrentScanCount;
        ScanDataSecondPass.AquiTopo.Ny:=ScanParams.CurrentScanCount;
        ScanDataSecondPass.AquiAdd.Ny :=ScanParams.CurrentScanCount;
       end;
MultiY:begin
        ScanData.AquiTopo.Nx:=ScanParams.CurrentScanCount;
        ScanData.AquiAdd.Nx :=ScanParams.CurrentScanCount;
        ScanDataSecondPass.AquiTopo.Nx:=ScanParams.CurrentScanCount;
        ScanDataSecondPass.AquiAdd.Nx :=ScanParams.CurrentScanCount;
      end;
 OneX:begin
        ScanData.AquiTopo.Ny:=ScanParams.CurrentScanCount;
        ScanData.AquiAdd.Ny :=ScanParams.CurrentScanCount;
        ScanData.AquiRenishaw.Ny:=ScanParams.CurrentScanCount;
      end;
OneY: begin
        ScanData.AquiTopo.Nx:=ScanParams.CurrentScanCount;
        ScanData.AquiAdd.Nx :=ScanParams.CurrentScanCount;
        ScanData.AquiRenishaw.Nx:=ScanParams.CurrentScanCount;
      end;
             end;
if (not FlgScanError) and flgStopMulti then
  begin
  if (ScanParams.ScanMethod<>OneLineScan)then
   begin
//  Synchronize(MedianFilter);
   Synchronize(TopViewSurfDelete);
   if Scanparams.Scanmethod in ScanmethodSetAdd then
       Synchronize(TopAddViewCorrect);
   end;
{ Prepare Scan Data delete max and invert }
//  ScanData.PrepareSaveData;
// if (ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY) then  ScanDataSecondPass.PrepareSaveData;
//  ScanData.WorkFileName:=WorkNameFile;
  end; //not scan error
 end; //not Multiscan
end; // create channel =true
100:  ;
finally
//   dispose(pStopVal);
   synchronize(deInit);
   if FlgFirstPass then ScanNormData:=TempScanNormData
                   else ScanNormData_2_Pass:=TempScanNormData;
   ZW:=1; ZB:=0;
   if ((ScanParams.ScanPath<>Multi) and (ScanParams.ScanPath<>MultiY)) or FlgStopMulti then
   begin
    TopHoriz:=nil;
    BottHoriz:=nil;
   end;
   SideViewLine:=nil;
   TempAquiData:=nil;
   TempAquiDataZ:=nil;
  if ScanParams.flgAquiAdd then  TempAquiAddData:=nil;

  flgDrawVirtualLineNow :=false;
  synchronize(DrawVirtualline);
  if (not Terminated) then  Self.Terminate;
end;{finally}
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('End drawing');
         if ErrorController then   Formlog.memolog.Lines.add('The Controller Error');
    {$ENDIF}

end;  //execute

procedure TScanDrawThread.sZIndicator;
var i:integer;
begin           { TODO : 14/04/06 }
     ScanWND.ZIndicatorScan.Value:=ZIndicatorVal;

    if  (ZindicatorVal < 3200) then
    begin
        ScanWND.ZIndicatorScan.IndicColor:=clRed;
        SCanWND.LabelZV.Font.color:=clRed;
        i:=0;
      //  if flgLeftView  then repeat  Beep; inc(i); until (i<4);
    end
    else
    begin
      if  (ZindicatorVal > 29000) then
      begin
          ScanWND.ZIndicatorScan.IndicColor:=clNavy;
          SCanWND.LabelZV.Font.color:=clNavy ;
       //   if flgLeftView  then  Beep;
      end
      else
      begin
        ScanWND.LabelZV.Font.color:=clGreen;
        ScanWND.ZIndicatorScan.IndicColor:=clGreen;
      end;
    end;
    ScanWND.LabelZ.Font.Color:=ScanWND.LabelZV.Font.color;
 //   ScanWND.LabelZV.Caption:=FloattoStrF( ZindicatorVal/Maxapitype,fffixed,3,2);

    ScanWND.LabelZV.Caption:=FloattoStrF( ZindicatorNormVal,fffixed,3,2); // 30/07/2013
    ScanWND.ZIndicatorScan.Repaint;
end;

(*procedure  TScanDrawThread.CopyData(var DataDraw:TData; DataIn:TData);
var i,j:integer;
begin
        DataDraw.flg:=DataIn.flg;
        DataDraw.Nx:=DataIn.Nx;
        DataDraw.Ny:=DataIn.Ny;
        DataDraw.Xstep:=DataIn.Xstep;
        DataDraw.YStep:=DataIn.YStep;
        DataDraw.ZStep:=DataIn.ZStep;
        SetLength(DataDraw.Data,DataDraw.Nx,DataDraw.Ny);

       try
          for j:=0 to DataDraw.NY-1 do
          begin
  	       for i:=0 to DataDraw.NX-1 do
               begin
                DataDraw.Data[i,j]:= DataIn.Data[i,j];
               end;
          end;

//         copymemory(DataIn.Data,DataDraw.data,sizeof(DataIn.Data));
        except
              on EOutOfMemory        do
              ScanWnd.siLangLinked1.MessageDlg(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_19' { 'OUT memory TopoSPM'}  ),mtWarning,[mbOk],0);
        end;
end;
*)
procedure  TScanDrawThread.PrepareScanError(var aScan:Tlinesingle);
var i,asz:integer;
   atemp:Tlinesingle;
begin
   asz:=length(aScan);
   setlength(atemp,asz);
   for i:=1 to aSz-2   do  atemp[i]:=aScan[i]-aScan[i-1];

   atemp[asz-1]:=0;//aScan[asz-1];        { TODO : 100406 }
   atemp[0]:=0;//aScan[0]-scanparams.dataInCur{Prev};  // Cur  !!!!

   for i:=0 to asz-1   do  aScan[i]:=atemp[i];   // -07109

   scanparams.dataInNext:=0;//trunc(atemp[asz-1]);
   atemp:=nil;
end;

procedure TScanDrawThread.DrawTopView;
var i:integer;
    ZScale,ZScaleAdd:single;
    it,n,m,k,dmn,ddn:integer;
    PointColor:integer;
    currentMax,CurrentTopMax,sclx,scly:single;
    value,valueZ, valueCur,valueTop:single;//apitype;
    RGBCol,RGBColScanArrea:TColor;
    ChartTopo,ChartAdd:TChart;
    ZCorr,valueCur_int :integer;
    ZCorr1,ZCorr2 :integer;
begin
           n:=ScanParams.ScanPoints;
           m:=ScanParams.ScanLines;

           with ScanWnd do
     begin
          case ScanParams.ScanPath of
 Multi,OneX :begin
              sclx:=(R.Right-R.left)/n;
              scly:=(R.Bottom-R.Top)/m;
             end;
 MultiY,OneY:begin
              sclx:=(R.Right-R.left)/m;
              scly:=(R.Bottom-R.Top)/n;
             end;
               end;
     end;
//      GreyEntr:=255;
      ZScale:=GreyEntr/ScanWNd.TopVScale/TempScanNormData.previousDZ;
if  ScanParams.flgAquiAdd then    ZScaleAdd:=GreyEntr/TempScanNormData.ScaleAdd;
with ScanWnd do
 begin
   k:=0;
   if flgFirstPass then
   begin
                    it:=0;//=Xpos; changed 170616   //Dout;
         if  ScanParams.ScanMethod in ScanmethodSetnoAdd then
                 begin
                    ChartTopo:=ScanWnd.ImgRChart;
                  end
                  else
                  begin
                    ChartTopo:=ScanWnd.ImgLChart;
                    ChartAdd:=ScanWnd.ImgRChart;
                   end;
    end
    else
    begin
                  it:=Dout_2;
       if  ScanParams.ScanMethod in ScanmethodSetnoAdd then
                 begin
                    ChartTopo:=ScanWnd.ImgLChartEr;
                  end
                  else
                  begin
                    ChartAdd:=ScanWnd.ImgLChartEr;
                  end;
   end;
for i:=0 to lsz-1 do
begin
  //topview
  dmn:=it;// mod (ScanParams.ScanPoints);//+byte(flgRenishawUnit));//?
 if dmn<ScanParams.ScanPoints then   //?
 begin
  //  if ScanPrams.ScanPath<>Multi then ddn:=it div ScanParams.ScanPoints
//                               else ddn:=CurrentScanCount;//(it div ScanParams.ScanPoints);
//
  ddn:=ScanParams.CurrentScanCount;
  value:=TempAquiData[i];
  valueZ:=TempAquiDataZ[i];
  ZIndicatorNormVal:=(1- (valueZ-MinAPITYPE)/(MaxAPITYPE-MinAPITYPE));  //(0 .. 1)
//  ZIndicatorVal:=round(value);// corrected 081211 round((MinAPITYPE+1)*(TempAquiData[i]-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));
  ZIndicatorVal:=round(ZIndicatorNormVal*MaxAPITYPE);   // (0.. 32767)
  Synchronize(sZIndicator);

  valueCur:=value- TempScanNormData.sfA;
  ValueTop:=ValueCur;
  value:=valueCur- TempScanNormData.sfB*dmn;
  if flgCurPlDelDraw     then   valueCur:=value;   // Del Plane in Current Line
  CurrentLine[i].x:=dmn;
//  if flgCurPlDelDraw     then   CurrentMax:=TempScanNormData.PreviousMax
//                         else   CurrentMax:=TempScanNormData.datMax ;
    CurrentMax:=TempScanNormData.PreviousMax;
    CurrentTopMax:=TempScanNormData.PreviousMax;
    valueTop:=value;
//  CurrentLine[i].y:=((CurrentMax-valueCur)*Z_d_nm);    { TODO : 300506 }
     // Изменено 01/08/2013
     CurrentLine[i].y:=(valueCur-TempScanNormData.PreviousMin)*Z_d_nm;
 //*******************Red point
    PointColor:=255;
    RGBCol:= TColor($02000000 or (RPaletteKoef[PointColor]));

      if flgFirstPass or (not Scanparams.flgAquiAdd){ (Scanparams.sz-byte(flgRenishawUnit)=1)}then
      begin
          ChartTopo.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
               case ScanParams.ScanPath of
     Multi,OneX:   begin
                    ChartTopo.BackImage.Bitmap.Canvas.FillRect(Rect(dmn+1,m-ddn,dmn+2,m-ddn-1));
                   end;
    MultiY,OneY:   begin
                    ChartTopo.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn-1,ddn+1,n-dmn-2));
                   end;
                       end; //case
       end;
                case    ScanParams.ScanMethod    of
                Phase,
                UAM,
                  Current:begin
                           ChartAdd.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
                                      case ScanParams.ScanPath of
                            Multi,OneX:ChartAdd.BackImage.Bitmap.Canvas.FillRect(Rect(dmn+1,m-ddn,dmn+2,m-ddn-1));
                           MultiY,OneY:ChartAdd.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn-1,ddn+1,n-dmn-2));
                                         end;
                          end;
                                    end;  //case

    //***************** end red point

    //PointColor:=round(ZScale*(CurrentTopMax-valueTop))  ;
       // Изменено 01/08/2013
       PointColor:=round(ZScale*(valueTop-TempScanNormData.PreviousMin))  ;
     if (PointColor >255) then PointColor:=255
                          else if (PointColor <0)   then PointColor:=0   ;

               RGBCol:= TColor($02000000 or (RPaletteKoef[PointColor])
                                         or (GPaletteKoef[PointColor] shl 8)
                                         or (BPaletteKoef[PointColor] shl 16) );
     if flgFirstPass then
      begin
      if (ScanParams.ScanMethod<>OneLineScan) then
         begin
              ImageScanArea.Picture.Bitmap.Canvas.Brush.Color:=RGBCol;
             case ScanParams.ScanPath of
    Multi,OneX:begin
                ImageScanArea.Picture.BitMap.Canvas.FillRect(Rect(round(R.left+dmn*sclx),round((m-ddn)*scly+R.Top),
                                         round(R.left+(dmn+1)*sclx),round(R.top+(m-ddn-1)*scly)));
               end;
   MultiY,OneY:begin
                ImageScanArea.Picture.BitMap.Canvas.FillRect(Rect(round(R.left+ddn*sclx),round((n-dmn)*scly+R.Top),
                                         round(R.left+(ddn+1)*sclx),round(R.top+(n-dmn-1)*scly)));
               end;
                 end;  //case
         end;//not one line scanning
       end;

    if flgFirstPass or (not Scanparams.flgAquiAdd){(Scanparams.sz-byte(flgRenishawUnit)=1)}then
      begin
        ChartTopo.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
       ImgRBitMapTemp.Canvas.Brush.Color:=RGBCol;
          case ScanParams.ScanPath of
     Multi,OneX:begin
                 ChartTopo.BackImage.Bitmap.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                 ImgRBitMapTemp.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                end;
   MultiY,OneY:begin
                ChartTopo.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                ImgRBitMapTemp.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
               end;
                 end;  //case
      end;

 // if PageCtrlAdd.ActivePage=TabSheetCurScan then  CurrentLine[i].y:={round}((CurrentMax-valueCur)*Z_d_nm);  { TODO : 300506 }
 // Закомментировано, т.к. кажется, повторно преобразуется (см. строку выше по тексту)
 if  Scanparams.flgAquiAdd then
  begin
     value :=TempAquiAddData[i];
              case    ScanParams.ScanMethod of
     Phase:         CurrentLineAdd[i].y:=(360*(value-TempScanNormData.DatMinPh)/(MaxApiType-MinApiType));
     UAM:           CurrentLineAdd[i].y:=((value-TempScanNormData.DatMinPh)/Transformunit.BiasV_d);// 180114 ((value-TempScanNormData.DatMinPh)/Transformunit.AmplV_d); //
     Current:       CurrentLineAdd[i].y:=((value)/Transformunit.nA_d);
                  end;       //case
      PointColor:=round((ZScaleAdd*(value-TempScanNormData.DatMinPh)));
      if (PointColor >255) then PointColor:=255 ;
      if (PointColor <0)   then PointColor:=0 ;
      RGBCol:= TCOlor($02000000 or (RPaletteKoef[PointColor])
                                or (GPaletteKoef[PointColor] shl 8)
                                or (BPaletteKoef[PointColor] shl 16) );

       ChartAdd.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
                 case ScanParams.ScanPath of
        Multi,OneX:  ChartAdd.BackImage.Bitmap.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
        MultiY,OneY: ChartAdd.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                        end;
   end; //not Topo
    inc(it);
   end;
  end;     //for
 end;   //with
      if flgFirstPass then Dout:=it
                      else Dout_2:=it;
end;

(*procedure TScanDrawThread.Render3DHide();
var
  value:apitype;
  j: integer;
begin
 for j:=0 to lsz-1 do
  begin
    value:=TempAquiData[j];
    if ((CurrentScanCount mod ScanSelectKoef)=0) then
      if (((XPos+j) mod PointSelectKoef)= 0) then
       if (PointInd<SideLinePointsNmb) then
          begin
           TempAquiDataLine[PointInd]:=value;
           Inc(PointInd);
          end;
  end;
end;
*)
procedure TScanDrawThread.Render3D();
var
  value:apitype;
  i,j: integer;
  v,hV: single;
begin
   i:=ScanParams.CurrentScanCount;
   hV:=h/ScanWNd.SideVScale/TempScanNormData.previousDZ;
 for j:=0 to lsz-1 do
  begin
    value:=TempAquiData[j]-round(TempScanNormData.sfA+TempScanNormData.sfB*(j+XPos));
//    v :=hV*(TempScanNormData.previousMax-value);
    v :=hV*(value -TempScanNormData.PreviousMin );
    line[j].x := Trunc(kw*(sin1*i + sin2*(j+XPos)));
    line[j].y := href - Trunc(kh*(cos1*i + cos2*(j+XPos)) + v);
  end;
end;

procedure TScanDrawThread.DrawCurrentLine;
var flgchange,flgchangeph:boolean;
    i:integer;
    x,y:double;
    ltmax,ltmin, ltmaxph,ltminph:single;
begin
 flgchange:=false;  flgchangeph:=false;
 ltmax:=Currentline[0].y;
 ltmin:=Currentline[0].y;
 if  Scanparams.flgAquiAdd then
 begin
   ltmaxph:=CurrentlineAdd[0].y;
   ltminph:=CurrentlineAdd[0].y;
 end;
for i:=0 to lsz-1 do
begin
   y:=Currentline[i].y;
   if y>ltmax then begin ltmax:=y;  end;
   if y<ltmin then begin ltmin:=y; end;
   if  Scanparams.flgAquiAdd then
    begin
     y:= CurrentlineAdd[i].y;
     if y>ltmaxph then begin ltmaxph:=y;  end;
     if y<ltminph then begin ltminph:=y;  end;
   end;
end;
 if ((ltmax <> tmax) or (ltmin <> tmin))  then begin
                                                 tmin:=ltmin;
                                                 tmax:=ltmax;
                                                 flgchange:=true;
                                               end;
 if  Scanparams.flgAquiAdd then
     if ((ltmaxph <> tmaxph) or (ltminph <> tminph))  then begin
                                                       tminph:=ltminph;
                                                       tmaxph:=ltmaxph;
                                                       flgchangeph:=true;
                                                      end;

 if not assigned(CurrentLineWnd) then
 begin
  if flgchangeph and ScanWnd.SeriesAddLine.Active  then ScanWnd.ChartCurrentLine.LeftAxis.SetMinMax(tminph,tmaxph*1.01);
  if flgchange   and ScanWnd.SeriesLine.Active     then ScanWnd.ChartCurrentLine.LeftAxis.SetMinMax(tmin,tmax*1.01);
 end
 else
 begin
  if Scanparams.flgAquiAdd and flgchangeph  then CurrentLineWnd.ChartCurrentLine.RightAxis.SetMinMax(tminph,tmaxph*1.01);
  if flgchange                              then CurrentLineWnd.ChartCurrentLine.LeftAxis.SetMinMax(tmin,tmax*1.01);
 end;

  // Pbegin:=line[0];
// Pend:=line[length(line)-1];
for i:=0 to lsz-1 do
 begin
           x:=Currentline[i].x*ScanParams.Stepxy;
           y:=Currentline[i].y;
  if not assigned(CurrentLineWnd) then  ScanWnd.SeriesLine.AddXY(x,y)
                                  else  CurrentLineWnd.SeriesLine.AddXY(x,y);
  if  Scanparams.flgAquiAdd then
    begin
           y:=CurrentlineAdd[i].y;
      if not assigned(CurrentLineWnd) then  ScanWnd.SeriesAddLine.AddXY(x,y)
                                      else  CurrentLineWnd.SeriesAddLine.AddXY(x,y);
   end;
 end;//i
end;

procedure TScanDrawThread.DrawSideView;
begin
 with  ScanWND.ImageSideL.canvas do
  begin
   Pen.Color := clBlack;
   MoveTo(Pend.x,Pend.y);
   if (XPos<>0)then   LineTo(Pbegin.x,Pbegin.y);
   Polyline(line);
  end;
end;

procedure TScanDrawThread.CountUpd;
begin
 ScanWnd.edScanNmb.Text:=IntToStr(ScanParams.CurrentScanCount);
 ScanWnd.edDZ.Text:= FloatToStrF(TempScanNormData.previousDZ*Z_d_nm{ZStep},ffFixed,5,0);
 Main.MainStatusBarFill;
end;

procedure TScanDrawThread.UpdButtons;
begin
 with ScanWnd do
  begin
   ToolBarScanWnd.Font.Color:=clBlack;
   StartBtn.Caption:=ScanWnd.siLangLinked1.GetTextOrDefault('IDS_17' (* '&START' *) );
 //  StartBtn.Glyph.Assign(BitMapStart);
  end;
end;

procedure TScanDrawThread.BoundProc(x,y:integer; var XBound,YBound:integer);
begin
if (XBound<>-1) then  SetHorizont(XBound,YBound,x,y);
 XBound:=x;
 YBound:=y;
end;

function TScanDrawThread.VisiblePoint(x,y:integer):integer;
// Result=0 : Point is unvisible;
//        1 : Point is Visible and higher of TopHoriz
//        -1 : point is visible and is lower of BottHoriz;
begin
 //indx:=x div XStep;
   { TODO : 101202 }
   Result:= 1;
 if ((y>BottHoriz[x]) and (y<TopHoriz[x])  ) then  Result:=0
                                             else if (y<=BottHoriz[x]) then  Result:= -1;
end;

procedure TScanDrawThread.SetHorizont(X1,Y1,X2,Y2:integer);
var K:single;
  yi,i:integer;
begin
//ind1:=X1 div Xstep;
//ind2:=X2 div Xstep;
if ((X2-X1)<=0) then
  begin
  TopHoriz[X2]:=Max(TopHoriz[X2],Y2);
  BottHoriz[X2]:=Min(BottHoriz[X2],Y2);
  end
 else
  begin
   K:=(Y2-Y1)/(X2-X1);
   for i:=X1 to X2 do
     begin
       yi:=round(K*(i-X1)+Y1);
       TopHoriz[i]:=Max(TopHoriz[i],yi);
       BottHoriz[i]:=Min(BottHoriz[i],yi);
     end;
  end;
end;

procedure TScanDrawThread.FindCross(X1,Y1,X2,Y2:integer;const Horizont:ArrayInt; var Xi,Yi:integer);
var tYi,K:single;
    Ysign,Csign:integer;
begin
//ind1:=X1 div Xstep;
//ind2:=X2 div Xstep;
if ((X2-X1)<=0) then
  begin
    Xi:=X2;
    Yi:=Horizont[X2];
  end
 else
   begin
     K:=(Y2-Y1)/(X2-X1);
   //   KHoriz:=(Horizont[ind2]-Horizont[ind1]) div (X2-X1);
   //  HInterp:=Horizont[ind1]+KHoriz;
     Ysign:=Sign(y1-Horizont[X1]);
     Csign:=Ysign;
     tYi:=Y1;
     Xi:=X1;
         { TODO : 150103 }
     while ((Csign=Ysign) and (xi<=x2)) do
       begin
         tYi:=tYi+K;
         inc(Xi);//:=Xi+1;
        // HInterp:=HInterp+KHoriz;
        // if  (round(Xi/XStep)<=nX) then
         Csign:=Sign(tYi-Horizont[Xi]);
       end;
     if (Abs(tYi-K-Horizont[(Xi-1)])<=Abs(tYi-Horizont[(Xi)]))then
       begin
         Yi:=round(tYi-K);
         Xi:=Xi;
       end
       else
       begin
         Yi:=round(tYi);
         Xi:=Xi;
       end;
   end;
end;

function TScanDrawThread.Sign(a:single):integer;
begin
 { TODO : 101202 }
 Sign:=1;
  if a<0 then Sign:=-1
         else if a=0 then Sign:=0;       ///!!!!!
end;

procedure TScanDrawThread.DrawL;
begin
//h:=ScanWND.ImageSideL.Height ;
  with ScanWND.ImageSideL.Canvas do
          begin
           MoveTo(DrawX1,h-DrawY1);
           LineTo(DrawX2,h-DrawY2);
          end;
end;

procedure TScanDrawThread.DrawSurface(X,Y:integer);
var
  Xi,Yi:integer;
begin
 Cflag:=VisiblePoint(X,Y);
  if (CFlag=PFlag) then
    if ((CFlag=1) or (CFlag=-1))then
      begin
       DrawX1:=XPrev;
       DrawY1:=YPrev;
       DrawX2:=X;
       DrawY2:=Y;
       CheckImgBounds;
       Synchronize(DrawL);
       SetHorizont(XPrev,YPrev,X,Y);
      end
     else
      begin
      end
  else //1 Points Visible flags are different
    begin
     if (CFlag=0) then
      begin
       if (PFlag=1) then FindCross(xPrev,Yprev,X,Y,TopHoriz,Xi,Yi)
                    else FindCross(xPrev,Yprev,X,Y,BottHoriz,Xi,Yi);
       {end if PFlag}
       Xi:=X;
       Yi:=Y;
       DrawX1:=XPrev;
       DrawY1:=YPrev;
       DrawX2:=Xi;
       DrawY2:=Yi;
       CheckImgBounds;
       Synchronize(DrawL);
       SetHorizont(XPrev,YPrev,Xi,Yi);
      end
     else
       if (Cflag=1) then
         if (PFlag=0) then
           begin
             FindCross(xPrev,Yprev,X,Y,TopHoriz,Xi,Yi);
             DrawX1:=Xi;
             DrawY1:=Yi;
             DrawX2:=X;
             DrawY2:=Y;
             CheckImgBounds;
             Synchronize(DrawL);
             SetHorizont(Xi,Yi,X,Y);
           end
         else
           begin
             FindCross(xPrev,Yprev,X,Y,BottHoriz,Xi,Yi);
             DrawX1:=XPrev;
             DrawY1:=YPrev;
             DrawX2:=Xi;
             DrawY2:=Yi;
             CheckImgBounds;
             Synchronize(DrawL);
             SetHorizont(Xprev,Yprev,Xi,Yi);
             FindCross(xPrev,Yprev,X,Y,TopHoriz,Xi,Yi);
             DrawX1:=Xi;
             DrawY1:=Yi;
             DrawX2:=X;
             DrawY2:=Y;
             CheckImgBounds;
             Synchronize(DrawL);
             SetHorizont(Xi,Yi,X,Y);
           end
       else {CFlag<>1}
         if (Pflag=0) then
           begin
             FindCross(xPrev,Yprev,X,Y,BottHoriz,Xi,Yi);
             DrawX1:=Xi;
             DrawY1:=Yi;
             DrawX2:=X;
             DrawY2:=Y;
             CheckImgBounds;
             Synchronize(DrawL);
             SetHorizont(Xi,Yi,X,Y);
           end
          else
           begin
             FindCross(xPrev,Yprev,X,Y,TopHoriz,Xi,Yi);
             DrawX1:=XPrev;
             DrawY1:=YPrev;
             DrawX2:=Xi;
             DrawY2:=Yi;
             CheckImgBounds;
             Synchronize(DrawL);
             SetHorizont(Xprev,Yprev,Xi,Yi);
             FindCross(xPrev,Yprev,X,Y,BottHoriz,Xi,Yi);
             DrawX1:=Xi;
             DrawY1:=Yi;
             DrawX2:=X;
             DrawY2:=Y;
             CheckImgBounds;
             Synchronize(DrawL);
             SetHorizont(Xi,Yi,X,Y);
           end;
    end; {end else 1}
  PFlag:=CFlag;
  XPrev:=X;
 // iXprev:=iX;
  YPrev:=Y;
end;

procedure TScanDrawThread.CheckImgBounds;
begin
  if (DrawX1<0) or (DrawX1>w) then DrawX1:=Xprev;
  if (DrawX2<0) or (DrawX2>w) then DrawX2:=Xprev;
  if (DrawY1<0) or (DrawY1>h) then DrawY1:=Yprev;
  if (DrawY2<0) or (DrawY2>h) then DrawY2:=Yprev;
end;

procedure TScanDrawThread.TopAddViewCorrect;
var n,m,nx,ny,i,j:integer;
    val:datatype;
    dz:single;
procedure ReDrawTopView;
  var i,j:integer;
    ZScale:single;
    GreyEntr,dmn,ddn:integer;
    PointColor:integer;
    value:single;
    RGBCol:TColor;
begin
   GreyEntr:=255;
   ZScale:= GreyEntr/TempScanNormData.ScaleAdd;
with ScanWnd do
begin
 for j:=0 to ny-1 do
  for i:=0 to nx-1 do
 begin
  //topview
  dmn:=i;
  ddn:=j;
  Pointcolor:= floor((ScanData.AquiAdd.Data[i,j]-TempScanNormData.DatminPh)* ZScale);
        case ScanParams.ScanPath of
  Multi,OneX:begin dmn:=i; ddn:=j; end;
 MultiY,OneY:begin dmn:=j; ddn:=i; end;
        end;

  if (PointColor >255) then PointColor:=255
                       else if (PointColor <0)   then PointColor:=0   ;

               RGBCol:= TCOlor($02000000 or (RPaletteKoef[PointColor])
                                         or (GPaletteKoef[PointColor] shl 8)
                                         or (BPaletteKoef[PointColor] shl 16) );
    ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
            case ScanParams.ScanPath of
       Multi,OneX:begin
                   ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                  end;
      MultiY,OneY:begin
                    ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                  end;
                                  end;
  end;//i,j
 end;   //with
end;
begin
 n:=ScanParams.ScanPoints;
 m:=ScanParams.ScanLines;

   case ScanParams.ScanPath of
Multi,
oneX:begin
      NX:=ScanParams.ScanPoints;        Ny:=ScanParams.CurrentScanCount;
     end;
MultiY,
oneY:begin
      Nx:=ScanParams.CurrentScanCount;  Ny:=ScanParams.ScanPoints;
     end;
        end;


   dz:=TempScanNormData.datmaxPh-TempScanNormData.datminPh;
   if dz=0 then dz:=1;
   TempScanNormData.ScaleAdd:=dZ;
   ReDrawTopView;
end;


procedure TScanDrawThread.TopViewPlaneDelete;
var   m,n:integer;
DataDraw:TData;
NX,NY,k,i,j:integer;
TempZMax,TempZMin,val:datatype;
dZ:single;
//////****************
procedure ReDrawTopView;
  var i,j:integer;
    ZScale:single;
    {GreyEntr,}dmn,ddn:integer;
    PointColor:integer;
    value:single;
    RGBCol:TColor;
begin
 //  GreyEntr:=255;
//   ZScale:=GreyEntr/dZ*();
   ZScale:=GreyEntr/((ZW-ZB)*dZ);
   k:=0;
with ScanWnd do
begin
 for j:=0 to ny-1 do
  for i:=0 to nx-1 do
 begin
  //topview
  dmn:=i;
  ddn:=j;
  value:= DataDraw.Data[i,j];
        case ScanParams.ScanPath of
  Multi,OneX:begin dmn:=i; ddn:=j; end;
 MultiY,OneY:begin dmn:=j; ddn:=i; end;
        end;
 //PointColor:=0;
 //if (Value<=TempZMax-ZW*dZ) then   PointColor:=255
 PointColor:=255;
 if (Value<=TempZMax-ZW*dZ) then   PointColor:=0     // заменено 01/08/2013
  else
   if (value>(TempZMax-ZW*dZ)) and ((TempZMax-ZB*dZ)>value)  then  
                                   begin
                                     PointColor:=255-floor(ZScale*(TempZMax-ZB*dZ-value)); // "255-" добавлено 01/08/2013
                                   end;


// PointColor:=round(ZScale*(TempZMax-value))  ;

  if (PointColor >255) then PointColor:=255
                       else if (PointColor <0)   then PointColor:=0   ;
               RGBCol:= TCOlor($02000000 or (RPaletteKoef[PointColor])
                                         or (GPaletteKoef[PointColor] shl 8)
                                         or (BPaletteKoef[PointColor] shl 16) );
//
 if  ScanParams.ScanMethod in ScanmethodSetnoAdd then
  begin
        ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
             ImgRBitMapTemp.Canvas.Brush.Color:=RGBCol;
            case ScanParams.ScanPath of
       Multi,OneX:begin
                   ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                   ImgRBitMapTemp.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                  end;
      MultiY,OneY:begin
                    ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                    ImgRBitMapTemp.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                  end;
                                  end;
       end
  else       //Additional View
  begin
   ImgLChart.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
    ImgRBitMapTemp.Canvas.Brush.Color:=RGBCol;
             case ScanParams.ScanPath of
    Multi,OneX: begin
                 ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                 ImgRBitMapTemp.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                end;
    MultiY,OneY:begin
                   ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                   ImgRBitMapTemp.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                 end;
                    end;
   end;
  end;//i,j
 end;   //with
end;
Begin
 n:=ScanParams.ScanPoints;
 m:=ScanParams.ScanLines;
   case ScanParams.ScanPath of
Multi,
oneX:begin
      NX:=ScanParams.ScanPoints;        Ny:=ScanParams.CurrentScanCount;
     end;
MultiY,
oneY:begin
      Nx:=ScanParams.CurrentScanCount;  Ny:=ScanParams.ScanPoints;
     end;
        end;
 DataDraw:=TData.Create;
try
 SetLength(DataDraw.Data,Nx,Ny);
for i:=0 to  NY-1 do
 for j:=0 to  NX-1 do
 begin
  DataDraw.Data[j,i]:=ScanData.AquiTopo.Data[j,i];
 end;
 DelFiltPlane(Nx, Ny,DataDraw.Data, FiltFileName);
  k:=0;
 TempZMax:=DataDraw.Data[0,0];
 TempZMin:=TempZMax;
 for i:=0 to  NY-1 do
  for j:=0 to  NX-1 do
  begin
   val:=DataDraw.Data[j,i];
   if val>TempZMax then TempZMax:=val
   else if val<TempZMin then TempZmin:=val;
  end;
 dZ:=(TempZMax-TempZMin);
 if  dZ=0 then dZ:=1;
 if flgContrastTopView then
 begin
//   DeleteAnomalStep(TempZMax,TempZMin,DataDraw,ZB,ZW);
 end;
 ReDrawTopView;
finally
 FreeAndNil(DataDraw);
end;
end;
////***********
procedure TScanDrawThread.MedianFilter;
var   m,n:integer;
DataDraw:TData;
NX,NY,k,i,j:integer;
TempZMax,TempZMin,val:datatype;
dZ:datatype;
procedure ReDrawTopView;
  var i,j:integer;
    ZScale:single;
    {GreyEntr,}dmn,ddn:integer;
    PointColor:integer;
    value:single;
    RGBCol:TColor;
begin
//   GreyEntr:=255;
   ZScale:=GreyEntr/dZ;
   k:=0;
with ScanWnd do
begin
 for j:=0 to ny-1 do
  for i:=0 to nx-1 do
 begin
  //topview
         case ScanParams.ScanPath of
 Multi,
 OneX  :begin dmn:=i; ddn:=j; end;
 OneY  :begin dmn:=j; ddn:=i; end;
          end;
  value:= DataDraw.Data[i,j];
  PointColor:=round(ZScale*(TempZMax-value))  ;

  if (PointColor >255) then PointColor:=255
                       else if (PointColor <0)   then PointColor:=0   ;
               RGBCol:= TCOlor($02000000 or (RPaletteKoef[PointColor])
                                         or (GPaletteKoef[PointColor] shl 8)
                                         or (BPaletteKoef[PointColor] shl 16) );
  if  ScanParams.ScanMethod in ScanmethodSetnoAdd then
  begin
            ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
            ImgRBitMapTemp.Canvas.Brush.Color:=RGBCol;
            case ScanParams.ScanPath of
       Multi,OneX:begin
                   ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                   ImgRBitMapTemp.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                  end;
      MultiY,OneY:begin
                    ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                    ImgRBitMapTemp.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                  end;
                                  end;
  end
  else       //Additional View
  begin
    ImgLChart.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
    ImgRBitMapTemp.Canvas.Brush.Color:=RGBCol;
             case ScanParams.ScanPath of
    Multi,OneX: begin
                 ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                 ImgRBitMapTemp.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                end;
    MultiY,OneY:begin
                   ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                   ImgRBitMapTemp.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                 end;
                    end;
   end;
  end;//i,j
 end;   //with
end;
//////******************* Redraw
begin
 n:=ScanParams.ScanPoints;
 m:=ScanParams.ScanLines;
   case ScanParams.ScanPath of
Multi,oneX: begin
      NX:=ScanParams.ScanPoints;  Ny:=ScanParams.CurrentScanCount;
     end;
MultiY,oneY:begin
      Nx:=ScanParams.CurrentScanCount;  Ny:=ScanParams.ScanPoints;
     end;
        end;
 DataDraw:=TData.Create;
try
 SetLength(DataDraw.Data,Nx,Ny);
for i:=0 to  NY-1 do
 for j:=0 to  NX-1 do
 begin
  DataDraw.Data[j,i]:=ScanData.AquiTopo.Data[j,i];
 end;
   MedianFilt3(Nx,Ny,DataDraw.Data, FiltFileName);
   k:=0;
 TempZMax:=DataDraw.Data[0,0];
 TempZMin:=TempZMax;
 for i:=0 to  NY-1 do
  for j:=0 to  NX-1 do
  begin
   val:=DataDraw.Data[j,i];
   if val>TempZMax then TempZMax:=val
     else if val<TempZMin then TempZmin:=val;
  end;
 dZ:=(TempZMax-TempZMin);
 if  dZ=0 then dZ:=1;
 ReDrawTopView;
finally
  FreeAndNil(DataDraw);
end;
end;

procedure TScanDrawThread.TopViewSurfDelete;
var   m,n:integer;
  a:PArrayofDouble0;
  DataOneD:PArrayOfSmallInt0;
  DataW: TDataRect;
  NX,NY,k,i,j:integer;
  TempZMax,TempZMin,val:datatype;
  dZ:single;
procedure ReDrawTopView;
  var i,j:integer;
    ZScale:single;
    {GreyEntr,}dmn,ddn:integer;
    PointColor:integer;
    value:single;
    RGBCol:TColor;
begin
  // GreyEntr:=255;
//   ZScale:=GreyEntr/dZ;
   ZScale:=GreyEntr/((ZW-ZB)*dZ);
   k:=0;
with ScanWnd do
begin
 for j:=0 to ny-1 do
  for i:=0 to nx-1 do
 begin
  //topview
  dmn:=i;
  ddn:=j;
  value:= DataOneD[k];
  inc(k);
 // PointColor:=0;
 //if (Value<=(TempZMax-ZW*dZ)) then   PointColor:=255
 PointColor:=255;
 if (Value<=TempZMax-ZW*dZ) then   PointColor:=0     // заменено 01/08/2013
  else
   if (value>(TempZMax-ZW*dZ)) and ((TempZMax-ZB*dZ)>value)
           then PointColor:=255-floor(ZScale*(TempZMax-ZB*dZ-value));         // "255-" добавлено 01/08/2013

//  PointColor:=round(ZScale*(TempZMax-value))  ;

  if (PointColor >255) then PointColor:=255
                       else if (PointColor <0)   then PointColor:=0   ;
               RGBCol:= TCOlor($02000000 or (RPaletteKoef[PointColor])
                                         or (GPaletteKoef[PointColor] shl 8)
                                         or (BPaletteKoef[PointColor] shl 16) );

  if  ScanParams.ScanMethod in ScanmethodSetnoAdd then
  begin
             ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
            ImgRBitMapTemp.Canvas.Brush.Color:=RGBCol;
            case ScanParams.ScanPath of
       Multi,OneX: begin
                    ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                    ImgRBitMapTemp.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                   end;
       MultiY,OneY:begin
                    ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                    ImgRBitMapTemp.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                   end;
                                end;
  end
  else       //Additional View
  begin
     ImgLChart.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
    ImgRBitMapTemp.Canvas.Brush.Color:=RGBCol;
             case ScanParams.ScanPath of
    Multi,OneX: begin
                 ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                 ImgRBitMapTemp.Canvas.FillRect(Rect(dmn,m-ddn,dmn+1,m-ddn-1));
                end;
    MultiY,OneY:begin
                  ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                  ImgRBitMapTemp.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
                end;
                    end;
   end;
  end;//i,j
 end;   //with
end;

begin
 n:=ScanParams.ScanPoints;
 m:=ScanParams.ScanLines;

 NX:=ScanParams.ScanPoints;
 Ny:=ScanParams.CurrentScanCount;
 with dataW do
 begin
   StartX:=0;
   EndX:=NX-1;
   StartY:=0;
   EndY:=NY-1;
 end;
 GetMem(a,9*sizeof(double));
 GetMem(DataOneD,NX*NY*sizeof(smallint));
try
 k:=0;
for i:=0 to  NY-1 do
 for j:=0 to  NX-1 do
 begin
        case ScanParams.ScanPath of
 Multi,OneX: DataOneD[k]:=ScanData.AquiTopo.Data[j,i];
 MultiY,OneY:DataOneD[k]:=ScanData.AquiTopo.Data[i,j];
        end;
// DataOneD[k]:=ScanData.AquiTopo.Data[j,i];
  inc(k);
 end;
  Get2xSurfaceVector(DataOneD,NX,NY, dataW, a);
  Subtract2xSurfaceByVector(DataOneD,DataOneD, nx, ny, dataW,a);
  k:=0;
 TempZMax:=DataOneD[0];
 TempZMin:=TempZMax;
 for i:=0 to  NY-1 do
  for j:=0 to  NX-1 do
  begin
   val:=DataOneD[k];
   if val>TempZMax then TempZMax:=val
     else if val<TempZMin then TempZmin:=val;
   inc(k);
  end;

 dZ:=(TempZMax-TempZMin);
 if  dZ=0 then dZ:=1;
 ReDrawTopView;
(* if (ScanParams.ScanPath=Multi) or  (ScanParams.ScanPath=MultiY) then
 begin

 end;
*)
finally
 FreeMem(a);
 FreeMem(DataOneD);
end;
end;

function  TScanDrawThread.ZGridModel(PDiscr:integer; lineShift:integer):integer;
var P,P2:single;
begin
  PDiscr:=abs(pDiscr)+lineShift;
  P2:= (GridPeriodDiscr div 2);
  P:= PDiscr-GridPeriodDiscr*(PDiscr div GridPeriodDiscr);
  if P<= P2 then
    Result:=round(ZminGridModel+P*(ZmaxGridModel-ZminGridModel)/P2)
  else
    Result:=round(ZminGridModel+(GridPeriodDiscr-P)*(ZmaxGridModel-ZminGridModel)/P2);
end;
(*procedure  TScanDrawThread.DrawVirtualline;
var
    ddn, dmn,m,n:integer;
    linerect:Trect;
    col:TColor;
begin
ddn:=ScanParams.CurrentScanCount;
   dmn:=1;
   m:=ScanParams.NY;
   n:= ScanParams.NX;

   if flgDrawVirtualLineNow then col:= clGreen else col:= clWhite;

              ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.Brush.Color:=col;
              case ScanParams.ScanPath of
     Multi,OneX:   begin
                    ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(0,m-ddn,n-1,m-ddn-1));
                   // ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(0,m,n,m-10));
                   end;
    MultiY,OneY:   begin
                    ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,0,ddn+1,n-1));
                   end;
                       end; //case

  flgDrawVirtualLineNow:= not flgDrawVirtualLineNow;
end;  *)

procedure  TScanDrawThread.DrawVirtualline;
var
    ddn, dmn,m,n:integer;
    linerect:Trect;
    col:TColor;
    linewidth:integer;
    ImgH,ImgW:integer;
begin

   ddn:=ScanParams.CurrentScanCount;
   dmn:=1;
   m:=ScanParams.NY;
   n:= ScanParams.NX;
   linewidth:=1;
   ImgH:= abs(ScanWnd.ImgRChart.chartrect.top-ScanWnd.ImgRChart.chartrect.Bottom);
   ImgW:= ScanWnd.ImgRChart.chartrect.Right-ScanWnd.ImgRChart.chartrect.Left;
   if  flgDrawVirtualLineNow then col:= clGreen else col:= clWhite;

              ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.Brush.Color:=col;
              ScanWnd.ImgLChart.BackImage.Bitmap.Canvas.Brush.Color:=col;
              case ScanParams.ScanPath of
     Multi,OneX:   begin
                    if ImgH <= m then  linewidth:=( m div ImgH) +3;
                    if ddn = 0  then  inc( linewidth);

                    if Scanparams.ScanMethod <> Litho then
                         ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(0,m-ddn,n,m-ddn-linewidth)) ;
                     // ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(0,m-5,n,m-5-linewidth)) ;
                   // else
                    ScanWnd.ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(0,m-ddn,n,m-ddn-linewidth)) ;
                   // ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(0,m,n,m-10));
                   end;
    MultiY,OneY:   begin
                     if ImgW <= n then  linewidth:=( n div ImgW) +3;
                      if ddn = 0  then  inc( linewidth);
                     if Scanparams.ScanMethod <> Litho then
                    ScanWnd.ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,0,ddn+linewidth,m));
                  //  else
                    ScanWnd.ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,0,ddn+linewidth,m));
                   end;
                       end; //case

    flgDrawVirtualLineNow:=not flgDrawVirtualLineNow;


end;



end.
