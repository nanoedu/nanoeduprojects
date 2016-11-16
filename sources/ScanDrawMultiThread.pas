{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O-,P+,Q+,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
  //optimization
//250603
unit ScanDrawMultiThread;

interface

uses
  Classes,  Windows,Forms, Messages, SysUtils, Dialogs,  Graphics, Controls,
  extctrls,Math, SioCSPM,
  CSPMVar,GlobalType,GlobalVar,GlobalDCl,DlgComment;

  type
  TScanDrawMultiThread = class(TThread)
  private
    CurrentP,PointsNmb:longint;
    XPos,NewPCount,NPC,lsz:longint;
    line, CurrentLine: array of TPoint;
    Pend,Pbegin,PCurrentBegin,PCurrentEnd:TPoint;
    currentMinEr,currentMaxEr,previousMaxEr,previousMinEr,previousDZEr:single;
    currentMin,currentMax,previousMax,previousMin,previousDZ:single;
//    CurrentScan:Integer;
    ZIndicatorVal:integer;
  protected
    procedure Execute; override;
    procedure Render3D();
    procedure RenderImg();
    procedure sRender3D;
    procedure CountUpd;
    procedure UpdButtons;
    procedure BoundProc(x,y: integer; var XBound,YBound:integer);
    function  VisiblePoint(x,y:integer):integer;
    procedure SetHorizont(X1,Y1,X2,Y2:integer);//var Tophoriz,BottHoriz:ArraySing);
    procedure FindCross(X1,Y1,X2,Y2:integer; Horizont:ArrayInt; var Xi,Yi:integer);
    procedure DrawSurface(X,Y:integer);
    function  Sign(a:single):integer;
    procedure DrawL;//(X1,Y1,X2,Y2:integer);
    procedure CheckImgBounds;
    procedure sZIndicator;
  public
    dout,dout_ph:longint;
      constructor Create;//(ScanData:TExperiment);
      destructor Destroy; override;
end;

var //   FlgStopMulti,flgFirstPass:Boolean; //Multi pass
       ScDrawMultiThread:TScanDrawMultiThread;
       ScDrawMultiThreadActive:boolean;
        
implementation

uses fScanSFM,mMain,SurfaceTools,FrCommentH,mHardWareOpt;
var
    XPrev,YPrev:integer;
    DrawX1, DrawY1,
    DrawX2, DrawY2:integer;
    CFlag,PFlag:integer; // Flags of Visible for Current and
    PointInd:integer;
    SideViewLine: array of TPoint;

constructor TScanDrawMultiThread.Create;//(ScanData:TExperiment);
begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpHigher{Normal});
   Suspended := false;
end;

destructor TScanDrawMultiThread.Destroy;
begin
 //  ThreadFlg:=Drawing;
 //  PostMessage(ScanWND.Handle,wm_ThreadMultiDoneMsg,ThreadFlg{self.ThreadID},0);
   {
     This posts a message to the main form, tells us when and which thread
     is done executing.
   }
   SideViewLine:=nil;
   inherited destroy;
end;

procedure TScanDrawMultiThread.Execute;
var
 j,ds:integer;
 i:dword;
 ScanFl:Boolean;
 Nx,Ny:integer;
 fs:fifo_desc;
 label  100;
begin
   Nx:=ScanParams.Nx;
   Ny:=1;
   PointsNmb:=Nx*Ny*ScanParams.sz;
   XPos:=0;
   CurrentP:=0;
   dout:=0;
   dout_ph:=0;
   ds:=1;
   ScanFl:=False;
   currentMinEr:=$7FFF; //datmin;
   currentMaxEr:=-32768;//datmin;
   previousMinEr:=datminEr;
   previousMaxEr:=datmaxEr;
   currentMin:=$7FFF; //datmin;
   currentMax:=-32768;//datmin;
   previousMin:=datmin;
   previousMax:=datmax;
   previousDZEr:=ScaleZ0Er;
   previousDZ:=ScaleZ0;
   MoveMemory(@fs,@f,sizeof(fifo_desc));
   fs.out_count:=REPORT_NO_WAIT;
   PointInd:=0;
  try
   SetLength(SideViewLine,SideLinePointsNmb+2);
  while (not Terminated) and (ScanParams.CurrentScanCount<Ny) do
   begin
       i:=ScanReport(@fs);
       NewPCount:= PointsNmb-fs.out_count-CurrentP;
    if odd(NewPCount) then dec(NewPCount);
     while  (NewPCount>1) do
       begin
        if (XPos* ScanParams.sz+NewPCount>=Nx* ScanParams.sz) then
          begin
              NPC:= ScanParams.sz*(Nx-XPos);
              NewPCount:=NewPCount-NPC;
              ScanFl:=True;
          end
        else
          begin
              NPC:=NewPCount;
              NewPCount:=0;
          end;
         try
              lsz:=NPC div  ScanParams.sz;
              SetLength(line,lsz);
              SetLength(CurrentLine,lsz);
              Render3D;
              Pbegin:=line[0];
              PCurrentBegin:=CurrentLine[0];
          if (flgLeftView and FlgFirstPass)then Synchronize(sRender3D);
              Pend:=line[length(line)-1];
              PCurrentEnd:=CurrentLine[length(line)-1];
          finally
              line:=nil;
              CurrentLine:=nil;
          end;
          if flgRightView then  Synchronize(RenderImg);
          CurrentP:=CurrentP+NPC;
          XPos:=XPos+lsz;  //NPC
      if ScanFl then
       begin
        case FlgFirstPass of
True: begin   //first pass
            for j:=0 to Nx-1 do
             PrevLine[j]:=ScanData.AquiTopo.Data[j,ScanParams.CurrentScanCount];
             Adatmin := $7FFF;
             Adatmax :=-32768;
             for j := 0 to Nx- 1 do
             begin
                 if PrevLine[j] < Adatmin then Adatmin :=PrevLine[j];
                 if PrevLine[j] > Adatmax then Adatmax :=PrevLine[j];
             end;
             if ScannerCorrect.flgPlnDel then  LinDelFiltPlaneParm(Nx,PrevLine,sfA,sfB)
                                         else begin sfA:=0.0; sfB:=0.0;end;
              previousMin:=$7FFF;
              previousMax:=-32768;
              for j := 0 to Nx-1 do
               begin
                PrevLine[j]:=PrevLine[j]-round(sfA+sfB*j) ;
                if PrevLine[j] < previousMin then previousMin :=PrevLine[j];
                if PrevLine[j] > previousMax then previousMax :=PrevLine[j];
               end;
           if flgLeftView  then
            if  ScannerCorrect.flgHideLine then
              if ((ScanParams.CurrentScanCount mod ScanSelectKoef)=0) then
               begin
                 XPrev:=SideViewLine[0].X;
                 YPrev:=SideViewLine[0].Y;
                 BoundProc(XPrev,YPrev,XLeft,YLeft);
                 Pflag:=VisiblePoint(XPrev,YPrev);
                 for j:=0 to SideLinePointsNmb-1 do
                  begin
                    DrawSurface(SideViewLine[j].X,SideViewLine[j].Y);
                  end;
                 BoundProc(SideViewLine[SideLinePointsNmb-1].X,SideViewLine[SideLinePointsNmb-1].Y,XRight,YRight);
               end;
        end;  //first pass
False:  begin    //second Pass
          for j:=0 to Nx-1 do
          //// save error scan
          {   PrevLineError[j]:=ScanError[j];  //???
             if ScannerCorrect.flgPlnDel then  LinDelFiltPlaneParm(Nx,PrevLineError,sfAEr,sfBEr)
                                         else begin sfAEr:=0.0; sfBEr:=0.0;end;
              previousMinEr:=$7FFF;
              previousMaxEr:=-32768;
              for j := 0 to Nx- 1 do
               begin
                PrevLineError[j]:=PrevLineError[j]-round(sfAEr+sfBEr*j) ;
                if PrevLineError[j] < previousMinEr then previousMinEr :=PrevLineError[j]
                 else  if PrevLineError[j] > previousMaxEr then previousMaxEr :=PrevLineError[j];
               end;
               }
        end;
                   end;    //case
              inc(ScanParams.CurrentScanCount);
              XPos:=0;
              PointInd:=0;
              ScanFl:=False;
              previousDZEr:=previousMaxEr-previousMinEr;
              if  previousDZEr=0 then   previousDZEr:=1;
              currentMinEr:=$7FFF;
              currentMaxEr:=-32768;
              previousDZ:=previousMax-previousMin;
              if  previousDZ=0 then   previousDZ:=1;
              currentMin:=$7FFF;
              currentMax:=-32768;
              Synchronize(CountUpd);
          end;
      end;// NewPpoint>0

    if i=0 then
      begin
          if  CurrentP=0 then
          begin
              FlgScanError:=True;
              ShowMessage('ScDraw fail');
              goto 100;
          end;
          FlgScanError:=False;
          break;

      end;
      fs.in_count:=REPORT_WAIT;                       {‘ормирование условий работы функции ScanReport()}
      fs.path_count:=REPORT_WAIT;                     {ѕо потокам IN, PATH мы ожидаем окончани€ сканировани€}
    if fs.out_count>ds then                         {”становка следующей метки в потоке OUT дл€ остановки}
          fs.out_count:=fs.out_count-ds
      else
          fs.out_count:=REPORT_WAIT;              {...либо ожидание конца сканировани€, если данных осталось мало}
   end; {while ScanCount}
100:

finally
   fs.Pin:=nil;
   fs.Pout:=nil;
   fs.PPath:=nil;
 if (not Terminated) then  Self.Terminate;
end;{finally}
end;

procedure TScanDrawMultiThread.RenderImg();
var i:integer;
    ZScale,ZScaleEr,ZScalePh:single;
    GreyEntr,n,m:integer;
    PointColor:integer;
    sclx,scly:single;
    value:apitype;
begin
           n:=ScanParams.Nx;
           m:=ScanParams.Ny;
         with ScanWnd do
          begin
           sclx:=(R.Right-R.left)/n;
           scly:=(R.Bottom-R.Top)/m;
          end;
           GreyEntr:=255;
           ZScale:=GreyEntr/ScanWNd.TopVScale/ previousDZ;
           ZScaleEr:=GreyEntr/ScanWNd.TopVScale/ previousDZEr;
 if (ScanParams.Sz{ScanMethod}>=1)  then    ZScalePh:=GreyEntr/ScanWNd.TopVScale/ScaleAdd;
for i:=0 to lsz-1 do
 begin
  //topview
    value :=datatype(PWordArray(data_out)[dout_ph]);
    if value>0 then value:=0 else   value:=abs(value+1);
  with ScanWnd do
  begin
        case FlgFirstPass of          //first pass
True: begin
        PointColor:=round(ZScale*(PreviousMax-(value-sfA-sfB*(XPos+i))));
        if (PointColor >255) then PointColor:=255
                         else if (PointColor <0)   then PointColor:=0   ;

//       ImageTopL.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
//                                            or ((round(PointColor/1.7{1.4})) shl 8) or ((round(PointColor/3.4{2.5})) shl 16) );
//        ImageTopL.Picture.Bitmap.Canvas.FillRect(Rect((dout mod n)*CELL,m-CurrentScanCount*CELL,
//                                                        ((dout mod n)+1)*CELL,m-(CurrentScanCount+1)*CELL));
        ImageScanArea.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                            or ((round(PointColor/1.7)) shl 8) or ((round(PointColor/3.4)) shl 16) );
        ImageScanArea.Picture.BitMap.Canvas.FillRect(Rect(round(R.left+(dout mod n)*CELL*sclx),round((m-ScanParams.CurrentScanCount*CELL)*scly+R.Top),
                                         round(R.left+((dout mod n)+1)*CELL*sclx),round(R.top+(m-(ScanParams.CurrentScanCount+1)*CELL*scly))));
      end;
False: begin       //second pass
        PointColor:=round(abs(ScaleZ0Er*(DatMaxEr-value)));
        if (PointColor >255) then PointColor:=255
                             else if (PointColor <0)   then PointColor:=0   ;
        if (ScanParams.Sz{ScanMethod}>=1)then
         begin
          ImageError.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                            or ((round(PointColor/1.7{1.4})) shl 8) or ((round(PointColor/3.4{2.5})) shl 16) );
          ImageError.Picture.Bitmap.Canvas.FillRect(Rect((dout mod n)*CELL,m-ScanParams.CurrentScanCount*CELL,
                                                        ((dout mod n)+1)*CELL,m-(ScanParams.CurrentScanCount+1)*CELL));
          inc(dout_ph);
           value :=datatype(PWordArray(data_out)[dout_ph]);
                    case ScanParams.ScanMethod of
          UAM: if value<0 then value:=0 ;
                    end;
             PointColor:=round(abs(ZScalePH*(value-DatMinPh)));
           if (PointColor >255) then   PointColor:=255
                               else  if (PointColor <0)   then   PointColor:=0 ;
              dec(dout_ph);
             case ScanParams.ScanMethod of
     Phase: begin
             (* ImagePhaseR.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                               or ((PointColor) shl 8) or ((PointColor div 2) shl 16) );
              ImagePhaseR.Picture.Bitmap.Canvas.FillRect(Rect((dout mod n)*CELL,m-CurrentScanCount*CELL,
                                         ((dout mod n)+1)*CELL,m-(CurrentScanCount+1)*CELL));
              *)
            end;
       UAM: begin
              (* ImageUAMR.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                             or ((PointColor) shl 8) or ((PointColor div 2) shl 16) );
               ImageUAMR.Picture.Bitmap.Canvas.FillRect(Rect((dout mod n)*CELL,m-CurrentScanCount*CELL,
                                             ((dout mod n)+1)*CELL,m-(CurrentScanCount+1)*CELL));
              *)
            end;
CurrentSTM: begin
             (*ImageCurSFM.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                             or ((PointColor) shl 8) or ((PointColor div 2) shl 16) );
             ImageCurSFM.Picture.Bitmap.Canvas.FillRect(Rect((dout mod n)*CELL,m-CurrentScanCount*CELL,
                                             ((dout mod n)+1)*CELL,m-(CurrentScanCount+1)*CELL));
             *)
            end;
                        end;  //case
         end
         else
         begin
          (*ImageTopR.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                            or ((round(PointColor/1.7{1.4})) shl 8) or ((round(PointColor/3.4{2.5})) shl 16) );
          ImageTopR.Picture.Bitmap.Canvas.FillRect(Rect((dout mod n)*CELL,m-CurrentScanCount*CELL,
                                                       ((dout mod n)+1)*CELL,m-(CurrentScanCount+1)*CELL));
           *)
         end; //not Topo
    end; //second pass
           end; //case
 end;   //with
    inc(dout_ph, ScanParams.sz);
    inc(dout);
 end;     //for
end;

procedure TScanDrawMultiThread.sZIndicator;
begin
     ScanWND.ZIndicatorScan.Value:=ZindicatorVal;
   if  (ScanWND.ZIndicatorScan.Value < 3200) then
    begin
        ScanWND.ZIndicatorScan.IndicColor:=clRed;
        SCanWND.LabelZV.Font.color:=clRed;
      //  if flgLeftView  then Beep;
    end
    else
     begin
     if  (ScanWND.ZIndicatorScan.Value > 29000) then
      begin
          ScanWND.ZIndicatorScan.IndicColor:=clNavy;
          SCanWND.LabelZV.Font.color:=clNavy ;
       //   if flgLeftView  then  Beep;
      end
     else
       begin
        SCanWND.LabelZV.Font.color:=clGreen;
        ScanWND.ZIndicatorScan.IndicColor:=clGreen;
       end;
    end;
    SCanWND.LabelZ.Font.Color:=SCanWND.LabelZV.Font.color;
    SCanWND.LabelZV.Caption:=FloattoStrF( ScanWND.ZIndicatorScan.Value/Maxapitype,fffixed,3,2);

end;
procedure TScanDrawMultiThread.Render3D();
var
  value:apitype;
  Nx,Ny:integer;
//  OLdBkMode:integer;
  i,j,k: integer;
  v,hV: single;
begin
    Nx:=ScanParams.Nx;
    Ny:=ScanParams.Ny;
    i:=ScanParams.CurrentScanCount;
    hV:=h/ScanWNd.SideVScale/PreviousDZ;
  //  ScanWND.LabelZmax.Caption:='Zmax '+FloatToStrF(previousMax*ZStep,ffFixed,5,0)+' nm';
  //  ScanWND.LabelZmin.Caption:='Zmin '+FloatToStrF(previousMin*ZStep,ffFixed,5,0)+' nm';
    j:=0;  k:=0;
 while (j<=(NPC-1)) do
  begin
    value :=datatype(PWordArray(data_out)[CurrentP+j]);
    if value>0 then value:=0 else   value:=abs(value+1);
            case flgFirstPass of
True:begin
      ScanData.AquiTopo.Data[CurrentP+k,ScanParams.CurrentScanCount]:=value;
      ScanError[CurrentP+k]:={apitype(round(5000*sin(3.14*0.03*(CurrentP+k))));//}value;
      ZIndicatorVal:=value;
      synchronize(sZIndicator);
(*       ScanWND.ZIndicatorScan.Value:=value;
      if  (ScanWND.ZIndicatorScan.Value < 3200) then
        begin
          ScanWND.ZIndicatorScan.IndicColor:=clRed;
          if odd(k) then    ScanWND.LabelZV.Font.color:=clRed
                    else    ScanWND.LabelZV.Font.color:=clBlack ;
          if flgLeftView  then Beep;
        end
        else
        begin
         if  (ScanWND.ZIndicatorScan.Value > 29000) then
          begin
           ScanWND.ZIndicatorScan.IndicColor:=clNavy;
           if odd(k) then ScanWND.LabelZV.Font.color:=clNavy
                     else ScanWND.LabelZV.Font.color:=clNavy ;
           if flgLeftView  then  Beep;
          end
        else
          begin
           SCanWND.LabelZV.Font.color:=clGreen;
           ScanWND.ZIndicatorScan.IndicColor:=clGreen;
          end;
        end;
            ScanWND.LabelZ.Font.Color:=ScanWND.LabelZV.Font.color;
            ScanWND.LabelZV.Caption:=FloattoStrF(Value/Maxapitype,fffixed,3,2);
*)
        if FlgLeftView then
          begin
            value:=value-round(sfA+sfB*(k+XPos));
            if (value < currentMin) then currentMin:=value
                            else
                            if (value > currentMax) then currentMax:=value;
           line[k].x := Trunc(kw*(sin1*ScanParams.CurrentScanCount + sin2*(k+XPos)));
           v :=hV*(previousMax-value);
           line[k].y := href - Trunc(kh*(cos1*ScanParams.CurrentScanCount + cos2*(k+XPos)) + v);
//           CurrentLine[k].x:=Trunc(CurrScanXScale*(k+XPos));
//           CurrentLine[k].y:=Round(imH*(CurScanWindowH*(0.5-(previousMax-value)/previousDZ)+0.5));
           if ScannerCorrect.flgHideLine then
             if ((ScanParams.CurrentScanCount mod ScanSelectKoef)=0) then
               if (((XPos+k) mod PointSelectKoef)= 0) then
                  if (PointInd<SideLinePointsNmb) then
          begin
            SideViewLine[PointInd].X:=line[k].x;
            SideViewLine[PointInd].Y:=h-line[k].y;
            Inc(PointInd);
          end;
        end; //ViewLeft
      end;   //first pass
False:begin   //second pass
     //   ScanError[j]:=value;
       if (ScanParams.Sz=2) then
        begin
          inc(j);
          value :=datatype(PWordArray(data_out)[CurrentP+j]);
            case ScanParams.ScanMethod of
   UAM:  begin
            if value<0 then value:=0 ;
         end;
              end;
          ScanData.AquiAdd.Data[(CurrentP div  ScanParams.sz)+k,ScanParams.CurrentScanCount]:=value;
         end;
       end
       else
        begin
         ScanWND.ZIndicatorScan.Value:=value;
         if  (ScanWND.ZIndicatorScan.Value < 3200) then
         begin
          ScanWND.ZIndicatorScan.IndicColor:=clRed;
          if odd(k) then    ScanWND.LabelZV.Font.color:=clRed
                    else    ScanWND.LabelZV.Font.color:=clBlack ;
        //  if flgLeftView  then Beep;
         end
         else
         begin
         if  (ScanWND.ZIndicatorScan.Value > 29000) then
          begin
           ScanWND.ZIndicatorScan.IndicColor:=clNavy;
           if odd(k) then ScanWND.LabelZV.Font.color:=clNavy
                     else ScanWND.LabelZV.Font.color:=clNavy ;
         //  if flgLeftView  then  Beep;
          end
        else
          begin
           SCanWND.LabelZV.Font.color:=clGreen;
           ScanWND.ZIndicatorScan.IndicColor:=clGreen;
          end;
        end;
            ScanWND.LabelZ.Font.Color:=ScanWND.LabelZV.Font.color;
            ScanWND.LabelZV.Caption:=FloattoStrF(Value/Maxapitype,fffixed,3,2);
        end;
             end; //case
           inc(j);
           inc(k);
  end;//while
end;

//240403
(* procedure TScanDrawMultiThread.RenderImg();
var i:integer;
    ZScale,ZScalePh:single;
    GreyEntr,n,m:integer;
    PointColor:integer;
    sclx,scly:single;
    value:apitype;
begin
           n:=ScanParams.Nx;
           m:=ScanParams.Ny;
         with ScanWnd do
          begin
           sclx:=(R.Right-R.left)/n;
           scly:=(R.Bottom-R.Top)/m;
          end;
           GreyEntr:=255;
           ZScale:=GreyEntr/ScanWNd.TopVScale/ previousDZ;
 if (ScanParams.ScanMethod>=1)  then    ZScalePh:=GreyEntr/ScanWNd.TopVScale/ScalePh;
for i:=0 to lsz-1 do
 begin
  //topview
    value :=datatype(PWordArray(data_out)[dout_ph]);
    if value>0 then value:=0 else   value:=abs(value+1);
  with ScanWnd do
  begin
        case FlgPass of          //first pass
True: begin
        PointColor:=round(ZScale*(PreviousMax-(value-sfA-sfB*(XPos+i))));
        if (PointColor >255) then PointColor:=255
                         else if (PointColor <0)   then PointColor:=0   ;

        ImageTopL.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                            or ((round(PointColor/1.7{1.4})) shl 8) or ((round(PointColor/3.4{2.5})) shl 16) );
        ImageTopL.Picture.Bitmap.Canvas.FillRect(Rect((dout mod n)*CELL,m-CurrentScanCount*CELL,
                                                        ((dout mod n)+1)*CELL,m-(CurrentScanCount+1)*CELL));
        ImageScanArea.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                            or ((round(PointColor/1.7)) shl 8) or ((round(PointColor/3.4)) shl 16) );
        ImageScanArea.Picture.BitMap.Canvas.FillRect(Rect(round(R.left+(dout mod n)*CELL*sclx),round((m-CurrentScanCount*CELL)*scly+R.Top),
                                         round(R.left+((dout mod n)+1)*CELL*sclx),round(R.top+(m-(CurrentScanCount+1)*CELL*scly))));
      end;
False: begin       //second pass  
        PointColor:=round(GreyEntr/ScanWNd.TopVScale*value/previousDZ);
        if (PointColor >255) then PointColor:=255
                         else if (PointColor <0)   then PointColor:=0   ;
        ImageTopR.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                            or ((round(PointColor/1.7{1.4})) shl 8) or ((round(PointColor/3.4{2.5})) shl 16) );
        ImageTopR.Picture.Bitmap.Canvas.FillRect(Rect((dout mod n)*CELL,m-CurrentScanCount*CELL,
                                                        ((dout mod n)+1)*CELL,m-(CurrentScanCount+1)*CELL));
        if (ScanParams.ScanMethod>=1)then
         begin
           inc(dout_ph);
           value :=datatype(PWordArray(data_out)[dout_ph]);
                    case ScanParams.ScanMethod of
          UAM: if value<0 then value:=0 ;
                    end;
             PointColor:=round(abs(ZScalePH*(value-DatMinPh)));
           if (PointColor >255) then   PointColor:=255
                               else  if (PointColor <0)   then   PointColor:=0 ;
              dec(dout_ph);
             case ScanParams.ScanMethod of
     Phase: begin
              ImagePhaseR.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                               or ((PointColor) shl 8) or ((PointColor div 2) shl 16) );
              ImagePhaseR.Picture.Bitmap.Canvas.FillRect(Rect((dout mod n)*CELL,m-CurrentScanCount*CELL,
                                            ((dout mod n)+1)*CELL,m-(CurrentScanCount+1)*CELL));
            end;
       UAM: begin
               ImageUAMR.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                             or ((PointColor) shl 8) or ((PointColor div 2) shl 16) );
               ImageUAMR.Picture.Bitmap.Canvas.FillRect(Rect((dout mod n)*CELL,m-CurrentScanCount*CELL,
                                             ((dout mod n)+1)*CELL,m-(CurrentScanCount+1)*CELL));
            end;
CurrentSFM: begin
             ImageCurSFM.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                             or ((PointColor) shl 8) or ((PointColor div 2) shl 16) );
             ImageCurSFM.Picture.Bitmap.Canvas.FillRect(Rect((dout mod n)*CELL,m-CurrentScanCount*CELL,
                                             ((dout mod n)+1)*CELL,m-(CurrentScanCount+1)*CELL));
            end;
                        end;  //case
         end; //not Topo
    end; //second pass
           end; //case
 end;   //with
    inc(dout_ph, ScanParams.sz);
    inc(dout);
 end;     //for
end;

procedure TScanDrawMultiThread.Render3D();
var
  value:apitype;
  Nx,Ny:integer;
  OLdBkMode:integer;
  i,j,k: integer;
  hgt, href: integer;
  v: double;
  desired: double;
  kh, kw,hV: double;
  cos1, cos2, sin1, sin2: double;
begin
    Nx:=ScanParams.Nx;
    Ny:=ScanParams.Ny;
    hgt := h div 10;
    cos1 := Cos(alpha1);
    cos2 := Cos(alpha2);
    desired := cos1*Ny - cos2*Nx + 0.001;
    kh := (h - hgt)/desired;
    href := Trunc(hgt + kh*cos1*Ny);
    sin1 := Sin(alpha1);
    sin2 := Sin(alpha2);
    desired := sin1*Ny + sin2*Nx;
    kw := w/desired;
    i:=CurrentScanCount;
    hV:=h/ScanWNd.SideVScale/PreviousDZ;
    ScanWND.LabelZmax.Caption:='Zmax '+FloatToStrF(previousMax*ZStep,ffFixed,5,0)+' nm';
    ScanWND.LabelZmin.Caption:='Zmin '+FloatToStrF(previousMin*ZStep,ffFixed,5,0)+' nm';
    j:=0;  k:=0;
 while (j<=(NPC-1)) do
  begin
    value :=datatype(PWordArray(data_out)[CurrentP+j]);
    if value>0 then value:=0 else   value:=abs(value+1);
            case flgPass of
True:begin
      ScanData.AquiTopo.Data[CurrentP+k,CurrentScanCount]:=value;
      ScanWND.ZIndicatorScan.Value:=value;
      if  (ScanWND.ZIndicatorScan.Value < 3200) then
        begin
          ScanWND.ZIndicatorScan.IndicColor:=clRed;
          if odd(k) then    SCanWND.LabelZV.Font.color:=clRed
                    else    SCanWND.LabelZV.Font.color:=clBlack ;
          if flgLeftView  then Beep;
        end
        else
        begin
         if  (ScanWND.ZIndicatorScan.Value > 29000) then
          begin
           ScanWND.ZIndicatorScan.IndicColor:=clNavy;
           if odd(k) then ScanWND.LabelZV.Font.color:=clNavy
                     else ScanWND.LabelZV.Font.color:=clNavy ;
           if flgLeftView  then  Beep;
          end
        else
          begin
           SCanWND.LabelZV.Font.color:=clGreen;
           ScanWND.ZIndicatorScan.IndicColor:=clGreen;
          end;
        end;
            ScanWND.LabelZ.Font.Color:=ScanWND.LabelZV.Font.color;
            ScanWND.LabelZV.Caption:=FloattoStrF(Value/Maxapitype,fffixed,3,2);
        if FlgLeftView then
          begin
            value:=value-round(sfA+sfB*(k+XPos));
            if (value < currentMin) then currentMin:=value
                            else
                            if (value > currentMax) then currentMax:=value;
           line[k].x := Trunc(kw*(sin1*CurrentScanCount + sin2*(k+XPos)));
            v :=hV*(previousMax-value);
           line[k].y := href - Trunc(kh*(cos1*CurrentScanCount + cos2*(k+XPos)) + v);
            CurrentLine[k].x:=Trunc(CurrScanXScale*(k+XPos));
            CurrentLine[k].y:=Round(imH*(CurScanWindowH*(0.5-(previousMax-value)/previousDZ)+0.5));
           if ScannerCorrect.flgHideLine then
             if ((CurrentScanCount mod ScanSelectKoef)=0) then
               if (((XPos+k) mod PointSelectKoef)= 0) then
                  if (PointInd<SideLinePointsNmb) then
           begin
            SideViewLine[PointInd].X:=line[k].x;
            SideViewLine[PointInd].Y:=h-line[k].y;
            Inc(PointInd);
          end;
        end; //ViewLeft
      end;   //first pass
False:begin   //second pass
       if (ScanParams.ScanMethod>=1) and (ScanParams.ScanMethod<>Litho)then
        begin
          inc(j);
          value :=datatype(PWordArray(data_out)[CurrentP+j]);
            case ScanParams.ScanMethod of
   UAM:  begin
            if value<0 then value:=0 ;
         end;
              end;
          ScanData.AquiAdd.Data[(CurrentP div  ScanParams.sz)+k,CurrentScanCount]:=value;
         end;
       end;
             end; //case
           inc(j);
           inc(k);
  end;//while
end;
 *)
procedure TScanDrawMultiThread.sRender3D;
begin
if  not ScannerCorrect.flgHideLine then
 with  ScanWND.ImageSideL.canvas do
  begin
   Pen.Color := clBlack;
   MoveTo(Pend.x,Pend.y);
   if (XPos<>0)then   LineTo(Pbegin.x,Pbegin.y);
   Polyline(line);
  end;
{ with  ScanWND.imCurrentScan.canvas do
  begin
   Pen.Color := clBlack;
   MoveTo(PCurrentend.x,PCurrentend.y);
   if (XPos<>0)then   LineTo(PCurrentbegin.x,PCurrentbegin.y);
   Polyline(Currentline);
  end;  }
end;

procedure TScanDrawMultiThread.CountUpd;
begin
 if flgFirstpass then
 begin
  ScanWnd.edScanNmb.Text:=IntToStr(ScanParams.CurrentScanCount);
  ScanWnd.edDZ.Text:= FloatToStrF(previousDZ*ZStep,ffFixed,5,0);
  (*with ScanWnd.imCurrentScan.Canvas do
    begin
     { TODO : 101202 }      //optimization
      Brush.Color:=clWhite;
      FillRect(Rect(0,0,imW,imH));
    end;
    *)
 end;
end;
procedure TScanDrawMultiThread.UpdButtons;
begin
  with ScanWnd do
 begin
  StartBtn.Font.Color:=clBlack;
  StartBtn.Caption:='&START';
  StartBtn.Glyph.Assign(BitMapStart);
 end;
end;

procedure TScanDrawMultiThread.BoundProc(x,y:integer; var XBound,YBound:integer);
begin
if (XBound<>-1) then  SetHorizont(XBound,YBound,x,y);
 XBound:=x;
 YBound:=y;
end;

function TScanDrawMultiThread.VisiblePoint(x,y:integer):integer;
// Result=0 : Point is unvisible;
//        1 : Point is Visible and higher of TopHoriz
//        -1 : point is visible and is lower of BottHoriz;
begin
if ((y>BottHoriz[x]) and (y<TopHoriz[x])  ) then  Result:=0
  else if (y<=BottHoriz[x]) then  Result:= -1
   else  Result:= 1;
end;

procedure TScanDrawMultiThread.SetHorizont(X1,Y1,X2,Y2:integer);
var K:single;
  yi,i:integer;
begin
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
procedure TScanDrawMultiThread.FindCross(X1,Y1,X2,Y2:integer; Horizont:ArrayInt; var Xi,Yi:integer);
var tYi,K:single;
    Ysign,Csign:integer;
begin
if ((X2-X1)<=0) then
  begin
    Xi:=X2;
    Yi:=Horizont[X2];
  end
 else
   begin
     K:=(Y2-Y1)/(X2-X1);
     Ysign:=Sign(y1-Horizont[X1]);
     Csign:=Ysign;
     tYi:=Y1;
     Xi:=X1;
         { TODO : 150103 }
     while ((Csign=Ysign) and (Xi<=X2)) do
       begin
         tYi:=tYi+K;
         inc(Xi);//:=Xi+1;
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

function TScanDrawMultiThread.Sign(a:single):integer;
begin
  if a<0 then Sign:=-1
    else if a=0 then Sign:=0       ///!!!!!
        else  Sign:=1;
end;

procedure TScanDrawMultiThread.DrawL;
begin
  with ScanWND.ImageSideL.Canvas do
   begin
    MoveTo(DrawX1,h-DrawY1);
    LineTo(DrawX2,h-DrawY2);
   end;
end;

procedure TScanDrawMultiThread.DrawSurface(X,Y:integer);
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
       Synchronize(DrawL);//(Xprev,yPrev,x,y);
       SetHorizont(XPrev,YPrev,X,Y);
      end
     else
      begin
      end
  else //1 Points Visible flags are different
    begin
     if (CFlag=0) then
      begin
       if (PFlag=1) then
         FindCross(xPrev,Yprev,X,Y,TopHoriz,Xi,Yi)
       else
         FindCross(xPrev,Yprev,X,Y,BottHoriz,Xi,Yi);
       {end if PFlag}
       Xi:=X;
       Yi:=Y;
       DrawX1:=XPrev;
       DrawY1:=YPrev;
       DrawX2:=Xi;
       DrawY2:=Yi;
       CheckImgBounds;
       Synchronize(DrawL);//(Xprev,yPrev,xi,Yi);
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
             Synchronize(DrawL);//(Xi,Yi,X,Y);
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
             Synchronize(DrawL);//(XPrev,YPrev,Xi,Yi);
             SetHorizont(Xprev,Yprev,Xi,Yi);
             FindCross(xPrev,Yprev,X,Y,TopHoriz,Xi,Yi);
             DrawX1:=Xi;
             DrawY1:=Yi;
             DrawX2:=X;
             DrawY2:=Y;
             CheckImgBounds;
             Synchronize(DrawL);//(Xi,Yi,X,Y);
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
             Synchronize(DrawL);//(Xi,Yi,X,Y);
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
             Synchronize(DrawL);//(XPrev,YPrev,Xi,Yi);
             SetHorizont(Xprev,Yprev,Xi,Yi);
             FindCross(xPrev,Yprev,X,Y,BottHoriz,Xi,Yi);
             DrawX1:=Xi;
             DrawY1:=Yi;
             DrawX2:=X;
             DrawY2:=Y;
             CheckImgBounds;
             Synchronize(DrawL);//(Xi,Yi,X,Y);
             SetHorizont(Xi,Yi,X,Y);
           end;
    end; {end else 1}
  PFlag:=CFlag;
  XPrev:=X;
  YPrev:=Y;
end;

procedure TScanDrawMultiThread.CheckImgBounds;
 begin
  if (DrawX1<0) or (DrawX1>w) then DrawX1:=XPrev;
  if (DrawX2<0) or (DrawX2>w) then DrawX2:=XPrev;
  if (DrawY1<0) or (DrawY1>h) then DrawY1:=YPrev;
  if (DrawY2<0) or (DrawY2>h) then DrawY2:=YPrev;
 end;
end.
