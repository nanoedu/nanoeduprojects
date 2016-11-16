
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O-,P+,Q+,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
//280206    forward lithography - backward topography
unit ScanDrawThreadLitho;

interface

uses
  Classes,  Windows,Forms, Messages, SysUtils, Dialogs,  Graphics, Controls,
  extctrls,Math,MLPC_APILib_TLB,Activex,
  {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
   GlobalType,GlobalScanDataType;
 type
  TScanDrawLithoThread = class(TThread)
  private
    flgCurPlDelDraw:boolean;
    flgTopViewPlDelDraw:boolean;
    flgTopViewSDelDraw:boolean;
    PointDrawS:integer;    PointDrawPl:integer;
    CurrentP:longint;
    XPos,NPC,lsz,i0:longint;
    ZIndicatorVal:apitype;
    ZIndicatorNormVal:single;   // 30/07/2013
    CurrentLine:array of TsinglePoint; //  TPoint  { TODO : 300506 }
    TempAquiData:TLine;
    ReniShawP0discr:integer; // For  Z Model in scanning with Renishaw
    ZminGridModel,ZmaxGridModel:integer; //discr
    GridPerioddiscr:integer;
       //NE II
    ElementSize:Integer;
    nElements,CurChElements:Integer;
    mod512corr:integer;
    ErrorController:boolean;
  protected
    procedure Execute; override;
    procedure ClearSeries;
    procedure GetScanData;
    procedure DrawMatrix;
    procedure DrawTopView;
    procedure DrawCurrentLine;
    procedure CountUpd;
    procedure UpdButtons;
    procedure sZIndicator;
    procedure MedianFilter;
    procedure TopViewSurfDelete;
    procedure TopViewPlaneDelete;
    procedure SetPrevLine;
    procedure SpeedBtnView;
    function  ZGridModel(PDiscr:integer; lineShift:integer):integer;
   public
       doutMatrix:longint;
       doutTopo:longint;
       dout:longint;
    constructor Create;
    destructor Destroy; override;
end;

var ScDrawLithoThread:TScanDrawLithoThread;
    ScDrawLithoThreadActive : boolean;
    tmax,tmin:single;

implementation

uses CSPMVar,GlobalDCl,GlobalVar,GlobalFunction,SioCSPM,frCurrentLine,SurfaceTools,frScanWnd,
{uConsts,}frNoFormUnitLoc, RenishawVars;



constructor TScanDrawLithoThread.Create;
 begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;
   ErrorController:=false;
 end;

destructor TScanDrawLithoThread.Destroy;
begin
   ThreadFlg:=mDrawing;
   PostMessage(ScanWND.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
  inherited Destroy;
end;

procedure TScanDrawLithoThread.SpeedBtnView;
begin
          if ScanParams.CurrentScanCount>4 then
              begin
                ScanWnd.SpeedBTnCaptureL.Visible:=true;
                ScanWnd.SpeedBTnCapture.Visible :=true;
                ScanWnd.SpeedBtnContrast.Visible:=Scanparams.flgAquiAdd;
                ScanWnd.SpeedBtnContrL.Visible:=not Scanparams.flgAquiAdd;
              end;
 end;

procedure TScanDrawLithoThread.ClearSeries;
begin
   if  assigned(CurrentLineWnd) then
     begin
      if CurrentLineWnd.SeriesLine.Count<>0       then       CurrentLineWnd.SeriesLine.Clear;
      CurrentLineWnd.ChartCurrentLine.LeftAxis.SetMinMax(tmin,tmax);
     end
  else
    begin
       if ScanWnd.SeriesLine.Count<>0       then        ScanWnd.SeriesLine.Clear;
       ScanWnd.ChartCurrentLine.LeftAxis.SetMinMax(tmin,tmax);
    end;
end;

procedure TScanDrawLithoThread.GetScanData;
var i,j,CurrentPoint:integer;
    value:apitype;
    P0:integer;
    LineSlowAxisPos:integer;
    counterr:integer;  //add
begin
 LineSlowAxisPos:=0;
  j:=Dout;
  counterr:=0;
   j:=0; //nanoeduII
// if flgCurrentUserLevel=Demo then  j:=Dout;
 for i:=0 to lsz-1 do
  begin
  // CurrentPoint:=CurrentP+i-2*ScanParams.CurrentScanCount*ScanParams.ScanPoints;
   CurrentPoint:=XPos+i;
   if  (CurrentPoint=2*ScanParams.ScanPoints) and flgRenishawUnit then
     begin    // (Last Point for Slow Axis DAC)
          value :=datatype(PWordArray(DataBuf)[j]);
          LineSlowAxisPos:=value;  // For Z Model
           case ScanParams.ScanPath of
             OneX: ScanData.AquiRenishaw.Data[ScanParams.ScanPoints,ScanParams.CurrentScanCount]:=value;
             OneY: ScanData.AquiRenishaw.Data[ScanParams.CurrentScanCount,ScanParams.ScanPoints]:=value;
                            end;  {case}
          // dout:=dout-1;
           value :=datatype(PWordArray(DataBuf)[j+1]);
//           if value=1 then inc(counterr);
           inc(j,2);
      end   // (Last Point for Slow Axis DAC)
    else
     begin  //(All  other Points )
      value :=datatype(PIntegerArray(DataBuf)[j] shr 16);
  //    value :=round((MinAPITYPE+1)*(value-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));
 // Commented 30/07/2013
  // FOR MODEL !!??//
     //  value:=CurrentPoint;
       TempAquiData[i]:=value;
       if value=1 then inc(counterr);

       if  CurrentPoint>=ScanParams.ScanPoints then
         begin
           P0:=CurrentPoint-ScanParams.ScanPoints;
           case ScanParams.ScanPath of
             OneX:  ScanData.AquiTopo.Data[ScanParams.ScanPoints-1-P0,ScanParams.CurrentScanCount]:=value;
             OneY:  ScanData.AquiTopo.Data[ScanParams.CurrentScanCount,ScanParams.ScanPoints-1-P0]:=value;
           end;
         end;
       if flgRenishawUnit then
         begin // (x)
           inc(j);
           value :=datatype(PWordArray(DataBuf)[j]);
            if CurrentPoint=ScanParams.ScanPoints then ReniShawP0discr:=abs(value);
           if  CurrentPoint>=ScanParams.ScanPoints then
             begin
                P0:=CurrentPoint-ScanParams.ScanPoints;
             //   value:= ScanParams.ScanPoints-1-P0; //  // FOR MODEL !!??//
 {$IFDEF DEBUG}
               // Change Z to Model Value
              if flgReniShawUnit {and ( ReniShowParams.StepScale>1)} then
              begin
                if CurrentPoint=ScanParams.ScanPoints then TempAquiData[i]:=ZminGridModel
                else
                   if round(ScanParams.StepXY)>=round(Renishawparams.Period_nm)
                         then   // ??? ?????? ????????? ?? ????????? ???
                         TempAquiData[i]:= ZGridModel(abs(value)-ReniShawP0discr,100*ScanParams.CurrentScanCount)
                         else
                         TempAquiData[i]:= ZGridModel(abs(value)-ReniShawP0discr,abs(LineSlowAxisPos));

                case ScanParams.ScanPath of
                 Multi,OneX: ScanData.AquiTopo.Data[ScanParams.ScanPoints-1-P0,ScanParams.CurrentScanCount]:=TempAquiData[i];
                MultiY,OneY: ScanData.AquiTopo.Data[ScanParams.CurrentScanCount,ScanParams.ScanPoints-1-P0]:=TempAquiData[i];
                end;
              end;
            // model data
 {$ENDIF}
                case ScanParams.ScanPath of
                  OneX: ScanData.AquiRenishaw.Data[ScanParams.ScanPoints-1-P0,ScanParams.CurrentScanCount]:=value;
                  OneY: ScanData.AquiRenishaw.Data[ScanParams.CurrentScanCount,ScanParams.ScanPoints-1-P0]:=value;
                end; {case}
             end;
          end; // (x)

         inc(j);

      end;   //(All other Points )
  end; //i
  if counterr>10 then ErrorController:=true;
  Dout:=j;
end;

procedure TScanDrawLithoThread.SetPrevLine;
var j:integer;
begin
   for j:=0 to ScanParams.ScanPoints-1 do
            case ScanParams.ScanPath of
 OneX: ScanNormData.PrevLine[j]:=ScanData.AquiTopo.Data[j,ScanParams.CurrentScanCount];
 OneY: ScanNormData.PrevLine[j]:=ScanData.AquiTopo.Data[ScanParams.CurrentScanCount,j];
                   end;
             LinDelFiltPlaneParm(ScanParams.ScanPoints,ScanNormData.PrevLine,ScanNormData.sfA,ScanNormData.sfB);
             ScanNormData.previousMin:=MaxApiType;// PrevLine[0]-sfA;
             ScanNormData.previousMax:=MinApiType;// previousMin;
           for j := 0 to ScanParams.ScanPoints- 1 do
               begin
                ScanNormData.PrevLine[j]:=ScanNormData.PrevLine[j]-(ScanNormData.sfA+ScanNormData.sfB*j) ;
                if ScanNormData.PrevLine[j] < ScanNormData.previousMin then ScanNormData.previousMin :=ScanNormData.PrevLine[j];
                if ScanNormData.PrevLine[j] > ScanNormData.previousMax then ScanNormData.previousMax :=ScanNormData.PrevLine[j];
               end;
      ScanNormData.previousDZ:=ScanNormData.previousMax-ScanNormData.previousMin;
     if  ScanNormData.previousDZ=0 then   ScanNormData.previousDZ:=1;

end;

procedure TScanDrawLithoThread.Execute;
var
 ScanFlg:Boolean;
 i:dword;
 Nx,Ny,PointsNmb:integer;
 icountS,icountPL:integer;
 ds:integer;
 NewPCount:longint;
// fs:fifo_desc;
 BackLinePointsNmb:integer;
 lsztmp:integer;
 //NE II
    hr:HResult;
    flgEnd:boolean;
    NChElements,CurChElements,nRead:integer;
    n,ID:integer;
    data:integer;
    errcnt:integer;
    dataCnt:integer;
    nwrite,errorcountstop,count:integer;
    // Параметры для имитации в ДЕМО
    smooth_nm:single; noise_discr, noise_speed_discr:datatype; depth_nm:single;
                                  lithodepth_nm:single;
   smooth0_nm:single; noise0_discr, noise_speed0_discr:datatype; depth0_nm:single;
                                  lithodepth0_nm:single;
    lithoAct_discr:single;
 label  100;
 begin
   GetTimeNow(StartHour, startMin, StartSec, startMsec);

   if currentUserLevel = 'Demo'  then
  calcDemoImitationParams(fsourceScanrate, fSourceFBGain, fSourceLithoAction, smooth0_nm, noise0_discr, noise_speed0_discr, depth0_nm,
                                                    lithodepth0_nm);
  if flgCurrentUserLevel = demo then mod512corr:=0
    else mod512corr:=1;
   SetScanNormData(ScanNormData);
   if flgRenishawUnit  then
          begin
            BackLinePointsNmb:= ScanParams.ScanPoints+1;
          end
          else BackLinePointsNmb:= ScanParams.ScanPoints;
   flgCurPlDelDraw:=ScanParams.flgTopoCurLinePlDel;
   flgTopViewPlDelDraw:=ScanParams.flgTopoTopViewPlDel;
   Nx:=ScanParams.ScanPoints;
   Ny:=ScanParams.ScanLines;
   //PointsNmb:=Nx*Ny*2;
   PointsNmb:=ScanParams.sz*(ScanParams.ScanPoints+BackLinePointsNmb)*ScanParams.ScanLines;
   icountS:=-1;
   icountPl:=-1;
   XPos:=0;
 //   new(PStopVal);
   ZminGridModel:=5000;
   ZmaxGridModel:=15000; //discr
   GridPerioddiscr:=4*140;
   CurrentP:=0;// current point  in out massive litho+topo
   doutMatrix:=0;
   doutTopo:=0;
   dout:=0;
   ds:=1;
   tMin:=0;
   tMax:=0;
   ScanNormData.previousMin:=ScanNormData.datmin;
   ScanNormData.previousMax:=ScanNormData.datmax;
   ScanNormData.previousDZ:=ScanNormData.ScaleZ0;
   ScanFlg:=False;
   PointDrawS:=ScanParams.ScanLines div 100;
   if PointDrawS<1 then PointDrawS:=1;
   PointDrawPl:=PointDrawS;
////NE II
try
   {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start drawing litho');
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
   hr:=arPCChannel[ch_Data_MATRIX].Main.get_Geometry(NChElements,ElementSize);
       {$IFDEF DEBUG}
        if Failed(hr)
         then Formlog.memolog.Lines.add('ERR read geometry Matrix'+inttostr(nread)+'hr='+inttostr(hr))
         else Formlog.memolog.Lines.add('Matrix Litho: Elements='+inttostr(NChElements)+'size='+inttostr(ElementSize));
      {$ENDIF}
    nwrite:=NChElements;  //1  20/02/13 error
    hr:=arPCChannel[ ch_Data_MATRIX].ChannelWrite.Write(MatrixLithoAct,nwrite);     //WRITE
         {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error write litho matrix'+inttostr(nwrite)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('ok write litho matrix ' +' data size ='+inttostr(nwrite));
             {$ENDIF}

   arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
  if ID=ch_Data_OUT then
  begin
    flgEnd:=false;
    hr:=arPCChannel[ch_Data_out].Main.get_Geometry(NChElements,ElementSize);
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read geometry'+inttostr(nread)+'hr='+inttostr(hr))
        else  Formlog.memolog.Lines.add('Channel data; Elements='+inttostr(NChElements)+'size='+inttostr(ElementSize));
      {$ENDIF}
    CurChElements:=0;   // current of elements
    nread:=0;

  while (not Terminated) and (CurrentP<PointsNmb) and (not flgEnd) and (not ErrorController) do
  begin
    nread:=1;
//       sleep(300);
    // nread:=ScanParams.ScanPoints;
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
                  Formlog.memolog.Lines.add('error write stop channel'+inttostr(nwrite)+'hr='+inttostr(hr))
               {$ENDIF}
                else
               {$IFDEF DEBUG}
                    Formlog.memolog.Lines.add('write stop channel ='+inttostr(PIntegerArray(StopBuf)[0])+' '+inttostr(nwrite));
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
                  Formlog.memolog.Lines.add('error read stop channel'+inttostr(nread)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('read stop channel ='+inttostr(PIntegerArray(DoneBuf)[0])+' '+inttostr(nread));
            {$ENDIF}
            inc(count);
            sleep(100);
          until  (PIntegerArray(DoneBuf)[0]=done) or (count=20);
          if PIntegerArray(DoneBuf)[0]=done then   flgEnd:=true; //stop button press       stop scanning
         end;    //StopJava
         sleep(GETCOUNT_DELAY);
         hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(nread);     //get new data count
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('scandraw data to read '+inttostr(nread));
       {$ENDIF}
   if nread >= ScanParams.ScanPoints +mod512corr then
   begin
         nread:=ScanParams.ScanPoints+mod512corr;     // читать по одной линии
         hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,nread);    /// read data //nread is not number of elements ????
     // hr:=(arPCChannel[ch_Data_out].Main as IMLPCChannelRead2).ReadWait(data_out,nread,1000);
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read channel data '+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('scandraw data has read '+inttostr(nread));
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
                            Formlog.memolog.Lines.add('STOP : NMB of CHANNEL ERRORS =   '+inttostr(errcnt));
                      {$ENDIF}
                    end;
      nread:=nread-mod512corr;
   //  nread:=ScanParams.ScanPoints*(nread div ScanParams.ScanPoints);
      NewPCount:=nread*ElementSize;
//     NewPCount:=(NewPCount div  ScanParams.sz)*ScanParams.sz;
    while  (NewPCount>0) do
    begin
       if (XPos=0) then
       begin
        synchronize(ClearSeries);
        flgCurPlDelDraw:=ScanParams.flgTopoCurLinePlDel;
        flgTopViewPlDelDraw:=ScanParams.flgTopoTopViewPlDel;
        flgTopViewSDelDraw :=ScanParams.flgTopoTopViewSDel;
       end;
       if (XPos*ScanParams.sz+NewPCount>=ScanParams.sz*(ScanParams.ScanPoints+BackLinePointsNmb)) then
          begin
              NPC:=ScanParams.sz*(ScanParams.ScanPoints+BackLinePointsNmb-XPos);
              NewPCount:=NewPCount-NPC;
              ScanFlg:=True;
          end
          else
          begin
              NPC:=NewPCount;
              NewPCount:=0;
          end;
          lsz:=NPC div ScanParams.sz;
          SetLength(TempAquiData,lsz);
          SetLength(CurrentLine,lsz);
          GetScanData;
           if flgCurrentUserLevel = Demo then
                    begin
                     if ScanParams.ScanMethod = litho then
                       lithoAct_discr:= LithoParams.ScaleAct*255/TransformUnit.Znm_d
                     else if  ScanParams.ScanMethod = lithoCurrent then
                        lithoAct_discr:= LithoParams.ScaleAct*255/TransformUnit.BiasV_d;

                     calcDemoImitationParams(ScanParams.ScanRate,PidParams.Ti, lithoAct_discr,
                     smooth_nm, noise_discr, noise_speed_discr, depth_nm, lithodepth_nm);
                     FBGain_Speed_DemoImitation((smooth_nm-smooth0_nm), noise_discr-noise0_discr, noise_speed_discr-noise_speed0_discr,
                               (depth_nm-depth0_nm),lithodepth_nm-lithodepth0_nm, ScanData.AquiTopo, TempAquiData);
                    end;
      try
          i0:=0;
          lsztmp:=lsz;
          if (XPos+lsz)<=ScanParams.ScanPoints then
    //   if not odd(CurrentP div ScanParams.ScanPoints)  then
                           begin
                              Synchronize(DrawMatrix);
                              Synchronize(ClearSeries);
                              Synchronize(DrawCurrentLine);
                            end
                            else
                            begin
                             if  XPos>=ScanParams.ScanPoints then
                             begin
                              Synchronize(DrawTopView);
                              Synchronize(ClearSeries);
                              Synchronize(DrawCurrentLine);
                             end
                             else
                             begin
                              lsz:=ScanParams.ScanPoints-XPos;
                              Synchronize(DrawMatrix);
                            //  Synchronize(DrawCurrentLine);
                              Synchronize(ClearSeries);
                              i0:=ScanParams.ScanPoints-XPos;
                              lsz:=lsztmp;//NPC div ScanParams.sz;;
                              Synchronize(DrawTopView);
                              Synchronize(ClearSeries);
                              Synchronize(DrawCurrentLine);
                             end;
                            end;
      finally
        CurrentLine:=nil;
      end;
        lsz:=lsztmp;
        CurrentP:=CurrentP+NPC;
        XPos:=XPos+lsz;
     if ScanFlg then
     begin
              XPos:=0;
              tmin:=0;
              tmax:=0;
              inc(icountS);
              inc(icountPl);
              ScanFlg:=False;
              Synchronize(CountUpd);
              SetPrevLine;
              inc(ScanParams.CurrentScanCount);
              synchronize(SpeedBtnView);
      if flgTopViewSDelDraw  and (ScanParams.CurrentScanCount>2) then
       if ((ScanParams.CurrentScanCount>4) and (icountS>PointDrawS)) or (ScanParams.CurrentScanCount=ScanParams.ScanLines) then
        begin
         icountS:=0;
         Synchronize(TopViewSurfDelete);
        end;
      if flgTopViewPlDelDraw and (ScanParams.CurrentScanCount>2) then
       if ((ScanParams.CurrentScanCount>4) and (icountPl>PointDrawPl)) or (ScanParams.CurrentScanCount=ScanParams.ScanLines) then
        begin
          Synchronize(TopViewPlaneDelete);
          icountPL:=0;
        end;
     end;//scanflg
    end;// while  newpoint>0
         nread:=0;
   end; // nread > 0
  end; {while ScanCount}
   //flgend
      PostMessage(ScanWnd.Handle,wm_ThreadDoneMsg,mScanning,integer(ErrorController));
          if  CurrentP=0 then
          begin
              FlgScanError:=True;
              ScanWnd.siLangLinked1.ShowMessage(strl{'ScDraw fail'});
              goto 100;
          end;
          FlgScanError:=False;
          ScanDone;
          FreeChannels;
          if  ScanParams.CurrentScanCount<=3 then   FlgScanError:=True;
          if FlgScanError then
          begin
           ScanData.AquiTopo.Ny:=0;
           ScanData.AquiAdd.Ny :=0;
           ScanData.AquiTopo.Nx:=0;
           ScanData.AquiAdd.Nx :=0;
          end;
          case ScanParams.ScanPath of
      Onex: begin
              ScanData.AquiTopo.Ny:=ScanParams.CurrentScanCount;
              ScanData.AquiRenishaw.Ny:=ScanParams.CurrentScanCount;
            end;
       OneY:begin
              ScanData.AquiTopo.Nx:=ScanParams.CurrentScanCount;
              ScanData.AquiRenishaw.Nx:=ScanParams.CurrentScanCount;
            end;
                 end;
           if (not FlgScanError) then
            begin
            // Synchronize(ScanWnd.MedianFilter);
              Synchronize(TopViewSurfDelete);
           //  HeaderPrepare;
             { Prepare Scan Data delete max and invert }
              ScanData.WorkFileName:=WorkNameFile;
            end;
 100:
  end; //id channel data out
 end; //create channels
finally
    TempAquiData:=nil;
//    dispose(pStopVal);
   if (not Terminated) then  Self.Terminate;
end;
  {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('End drawing');
         if ErrorController then   Formlog.memolog.Lines.add('The Controller Error');
   {$ENDIF}
end;

procedure TScanDrawLithoThread.sZIndicator;
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
 //   SCanWND.LabelZV.Caption:=FloattoStrF( ScanWND.ZIndicatorScan.Value/Maxapitype,fffixed,3,2);
    ScanWND.LabelZV.Caption:=FloattoStrF( ZindicatorNormVal,fffixed,3,2); // 30/07/2013
    ScanWND.ZIndicatorScan.Repaint;
end;
procedure  TScanDrawLithoThread.DrawTopView;
var i,it:integer;
    ZScale,ZScaleAdd:single;
    GreyEntr,n,m,k,dmn,ddn:integer;
    PointColor:integer;
    currentMax,CurrentTopMax,sclx,scly:single;
    value, valueCur,valueTop:single;
    RGBCol:TColor;
begin
  n:=ScanParams.ScanPoints;
  m:=ScanParams.ScanLines;
   with ScanWnd do
     begin
          case ScanParams.ScanPath of
  Onex:begin
           sclx:=(R.Right-R.left)/n;
           scly:=(R.Bottom-R.Top)/m;
      end;
 OneY:begin
           sclx:=(R.Right-R.left)/m;
           scly:=(R.Bottom-R.Top)/n;
       end;
               end;
     end;
      GreyEntr:=255;
      ZScale:=GreyEntr/ScanWNd.TopVScale/ScanNormData.previousDZ;
with ScanWnd do
 begin
   k:=0;
   if xpos<ScanParams.ScanPoints then it:=ScanParams.ScanPoints
                                 else it:=2*ScanParams.ScanPoints-xpos;
 for i:=i0 to lsz-1 do
 begin
  //topview
(*  dmn:=ScanParams.ScanPoints-(doutTopo mod ScanParams.ScanPoints);
  ddn:=doutTopo div ScanParams.ScanPoints;
  *)
 if it>0 then
  begin
  dmn:=it;//(doutTopo mod ScanParams.ScanPoints);
  ddn:=ScanParams.CurrentScanCount;// div ScanParams.ScanPoints;
  value:=TempAquiData[i];
   ZIndicatorNormVal:=1- (value-MinAPITYPE)/(MaxAPITYPE-MinAPITYPE);  //(0 .. 1)
//  ZIndicatorVal:=round(value);// corrected 081211 round((MinAPITYPE+1)*(TempAquiData[i]-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));
  ZIndicatorVal:=round(ZIndicatorNormVal*MaxAPITYPE);   // (0.. 32767)
//  ZIndicatorVal:=TempAquiData[i];
  Synchronize(sZIndicator);
  valueCur:=value-ScanNormData.sfA;
  ValueTop:=ValueCur;
  value:=valueCur-ScanNormData.sfB*dmn;
  if flgCurPlDelDraw     then   valueCur:=value;   // Del Plane in Current Line
  if flgCurPlDelDraw     then   CurrentMax:=ScanNormData.PreviousMax
                         else   CurrentMax:=ScanNormData.datMax ;
    CurrentTopMax:=ScanNormData.PreviousMax;
    valueTop:=value;
    //CurrentLine[i].y:={round}((CurrentMax-valueCur)*Z_d_nm);  { TODO : 300506 }
      // Изменено 01/08/2013
    CurrentLine[i].y:=((valueCur-ScanNormData.PreviousMin)*Z_d_nm);
    CurrentLine[i].x:=dmn;
   // PointColor:=round(ZScale*(CurrentTopMax-valueTop))  ;

       // Изменено 01/08/2013
       PointColor:=round(ZScale*(valueTop-ScanNormData.PreviousMin))  ;
     if (PointColor >255) then PointColor:=255
                          else if (PointColor <0)   then PointColor:=0   ;
     RGBCol:= TCOlor($02000000 or (RPaletteKoef[PointColor])
                               or (GPaletteKoef[PointColor] shl 8)
                               or (BPaletteKoef[PointColor] shl 16) );
      ImgLChart.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
      ImageScanArea.Picture.Bitmap.Canvas.Brush.Color:=RGBCol;
      ScanAreaBitMapTemp.Canvas.Brush.Color:=RGBCol;
             case ScanParams.ScanPath of
    OneX:begin
          ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(dmn,m-ddn,dmn-1,m-ddn-1));
          ImageScanArea.Picture.BitMap.Canvas.FillRect(Rect(round(R.left+dmn*CELL*sclx),round((m-ddn*CELL)*scly+R.Top),
                                         round(R.left+(dmn+1)*CELL*sclx),round(R.top+(m-ddn+1)*CELL*scly)));
          ScanAreaBitMapTemp.Canvas.FillRect(Rect(round(R.left+dmn*CELL*sclx),round((m-ddn*CELL)*scly+R.Top),
                                         round(R.left+(dmn+1)*CELL*sclx),round(R.top+(m-ddn+1)*CELL*scly)));
         end;
    OneY:begin
          ImgLChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn,n-dmn,ddn+1,n-dmn-1));
          ImageScanArea.Picture.BitMap.Canvas.FillRect(Rect(round(R.left+ddn*CELL*sclx),round((n-dmn*CELL)*scly+R.Top),
                                         round(R.left+(ddn+1)*CELL*sclx),round(R.top+(n-dmn+1)*CELL*scly)));
          ScanAreaBitMapTemp.Canvas.FillRect(Rect(round(R.left+ddn*CELL*sclx),round((n-dmn*CELL)*scly+R.Top),
                                     round(R.left+(ddn+1)*CELL*sclx),round(R.top+(n-dmn+1)*CELL*scly)));
         end;
                    end;
  //  if PageCtrlAdd.ActivePage=TabSheetCurScan then  CurrentLine[i].y:=round((CurrentMax-valueCur)*ZStep);
    inc(doutTopo); dec(it);
   end;
  end;     //for
 end;   //with
end;

procedure TScanDrawLithoThread.DrawMatrix;
var i:integer;
    ZScale:single;
    GreyEntr,n,m,dmn,ddn:integer;
    PointColor:integer;
    currentMax,CurrentTopMax,
    value,sclx,scly,valueCur,valueTop:single;
begin
           n:=ScanParams.ScanPoints;//ScanParams.Nx;
           m:=ScanParams.ScanLines;//Params.Ny;
          with ScanWnd do
        begin
           case ScanParams.ScanPath of
     OneX:begin
           sclx:=(R.Right-R.left)/n;
           scly:=(R.Bottom-R.Top)/m;
         end;
    OneY:begin
           sclx:=(R.Right-R.left)/m;
           scly:=(R.Bottom-R.Top)/n;
         end;
               end;
         end;
           GreyEntr:=255;
           ZScale:=1;//GreyEntr/previousDZ;
for i:=0 to lsz-1 do
 begin
          case ScanParams.ScanPath of
     OneX:begin
            value:=MatrixLitho[ScanParams.CurrentScanCount,XPos+i];   //xpos
         end;
    OneY:begin
            value:=MatrixLitho[(XPos+i),ScanParams.CurrentScanCount];
          end;
               end;
     dmn:=doutMatrix mod ScanParams.ScanPoints;
     ddn:=doutMatrix div ScanParams.ScanPoints;

    PointColor:=round(255-value{/LithoParams.ScaleAct});
    if (PointColor >255) then PointColor:=255
                         else if (PointColor <0)   then PointColor:=0   ;

    value :=TempAquiData[i];
    //изменено 30/07/2013
    ZIndicatorNormVal:=1- (value-MinAPITYPE)/(MaxAPITYPE-MinAPITYPE);  //(0 .. 1)
    ZIndicatorVal:=round(ZIndicatorNormVal*MaxAPITYPE);   // (0.. 32767)
 //   ZIndicatorVal:=TempAquiData[i];
    synchronize(sZIndicator);   //synchronize????
//
  valueCur:=value- ScanNormData.sfA;
  ValueTop:=ValueCur;
  value:=valueCur- ScanNormData.sfB*dmn;
  if flgCurPlDelDraw     then   valueCur:=value;   // Del Plane in Current Line
  if flgCurPlDelDraw     then   CurrentMax:=ScanNormData.PreviousMax
                         else   CurrentMax:=ScanNormData.datMax ;
    CurrentTopMax:=ScanNormData.PreviousMax;
    valueTop:=value;
  // CurrentLine[i].y:={round}((CurrentMax-valueCur)*Z_d_nm);  { TODO : 300506 }
   CurrentLine[i].x:=dmn;

   CurrentLine[i].y:=(valueCur-ScanNormData.PreviousMin)*Z_d_nm;
    // ************************
        with ScanWnd do
   begin
//    case    ScanParams.ScanMethod    of
//Litho,LithoCurrent:begin
       ImgRChart.BackImage.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                            or ((round(PointColor/1.7{1.4})) shl 8) or ((round(PointColor/3.4{2.5})) shl 16) );
(*       ImageScanArea.Picture.Bitmap.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                            or ((round(PointColor)) shl 8) or ((round(PointColor)) shl 16) );
       ScanAreaBitMapTemp.Canvas.Brush.Color:=TCOlor($02000000 or (PointColor)
                                           or ((round(PointColor)) shl 8) or ((round(PointColor)) shl 16) );
  *) 
                    case ScanParams.ScanPath of
       OneX:    begin
                 ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(dmn*CELL,m-ddn*CELL,(dmn+1)*CELL,m-(ddn+1)*CELL));
   (*              ImageScanArea.Picture.BitMap.Canvas.FillRect(Rect(round(R.left+dmn*CELL*sclx),round((m-ddn*CELL)*scly+R.Top),
                                         round(R.left+(dmn+1)*CELL*sclx),round(R.top+(m-ddn+1)*CELL*scly)));
                 ScanAreaBitMapTemp.Canvas.FillRect(Rect(round(R.left+dmn*CELL*sclx),round((m-ddn*CELL)*scly+R.Top),
                                         round(R.left+(dmn+1)*CELL*sclx),round(R.top+(m-ddn+1)*CELL*scly)));
     *)
               end;
       OneY:   begin
                ImgRChart.BackImage.Bitmap.Canvas.FillRect(Rect(ddn*CELL,n-dmn*CELL,
                                                                        (ddn+1)*CELL,n-(dmn+1)*CELL));
       (*       ImageScanArea.Picture.BitMap.Canvas.FillRect(Rect(round(R.left+ddn*CELL*sclx),round((n-dmn*CELL)*scly+R.Top),
                                         round(R.left+(ddn+1)*CELL*sclx),round(R.top+(n-dmn+1)*CELL*scly)));
                ScanAreaBitMapTemp.Canvas.FillRect(Rect(round(R.left+ddn*CELL*sclx),round((n-dmn*CELL)*scly+R.Top),
                                         round(R.left+(ddn+1)*CELL*sclx),round(R.top+(n-dmn+1)*CELL*scly)));
       *)
               end;       //mode
                 end;
//           end;
//                 end; //case

   end;   //with
    inc(doutMatrix);
 end;   //for
end;

procedure TScanDrawLithoThread.DrawCurrentLine;
var flgchange:boolean;
    i:integer;
    x,y:double;
     ltmax,ltmin:single;
begin
 flgchange:=false;
 ltmax:=Currentline[0].y;
 ltmin:=Currentline[0].y;
for i:=0 to lsz-1 do
begin
   y:=Currentline[i].y;
   if y>ltmax then begin ltmax:=y;  end;
   if y<ltmin then begin ltmin:=y; end;
end;

 if ((ltmax <> tmax) or (ltmin <> tmin))  then begin
                                                 tmin:=ltmin;
                                                 tmax:=ltmax;
                                                 flgchange:=true;
                                               end;
 if not assigned(CurrentLineWnd) then
 begin
   if flgchange   and ScanWnd.SeriesLine.Active        then ScanWnd.ChartCurrentLine.LeftAxis.SetMinMax(tmin,tmax);
 end
 else
 begin
   if flgchange   and CurrentLineWnd.SeriesLine.Active then CurrentLineWnd.ChartCurrentLine.LeftAxis.SetMinMax(tmin,tmax);
 end;
for i:=0 to lsz-1 do
 begin
           x:=Currentline[i].x*ScanParams.Stepxy;
           y:=Currentline[i].y;
    if not assigned(CurrentLineWnd) then  ScanWnd.SeriesLine.AddXY(x,y)
                                    else  CurrentLineWnd.SeriesLine.AddXY(x,y);
    end;//i
end;

procedure TScanDrawLithoThread.CountUpd;
begin
 ScanWnd.edScanNmb.Text:=IntToStr(ScanParams.CurrentScanCount+1);
 ScanWnd.edDZ.Text:= FloatToStrF(ScanNormData.previousDZ*Z_d_nm,ffFixed,5,0);
end;
procedure TScanDrawLithoThread.UpdButtons;
begin
 with ScanWnd do
 begin
  ToolBarScanwnd.Font.Color:=clBlack;
  StartBtn.Caption:='&START';
//  StartBtn.Glyph.Assign(BitMapStart);
 end;
end;

procedure TScanDrawLithoThread.TopViewPlaneDelete;
var   m,n:integer;
DataDraw:TData;
NX,NY,k,i,j:integer;
TempZMax,TempZMin,val:datatype;
dZ:single;
//////****************
procedure ReDrawTopView;
  var i,j:integer;
    ZScale:single;
    GreyEntr,dmn,ddn:integer;
    PointColor:integer;
    value:single;
    RGBCol:TColor;
begin
   GreyEntr:=255;
   ZScale:=GreyEntr/dZ;
 //  ZScale:=GreyEntr/((ZW-ZB)*dZ);
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
 PointColor:=0;
(*
 if (Value<=TempZMax-ZW*dZ) then   PointColor:=255
  else
   if (value>(TempZMax-ZW*dZ)) and ((TempZMax-ZB*dZ)>value)
   then PointColor:=floor(ZScale*(TempZMax-ZB*dZ-value));
*)
  PointColor:=255- round(ZScale*(TempZMax-value))  ;     // "255-" добавлено 01/08/2013
  if (PointColor >255) then PointColor:=255
                       else if (PointColor <0)   then PointColor:=0   ;
               RGBCol:= TCOlor($02000000 or (RPaletteKoef[PointColor])
                                         or (GPaletteKoef[PointColor] shl 8)
                                         or (BPaletteKoef[PointColor] shl 16) );
//

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
procedure TScanDrawLithoThread.MedianFilter;
var   m,n:integer;
DataDraw:TData;
NX,NY,k,i,j:integer;
TempZMax,TempZMin,val:datatype;
dZ:datatype;
procedure ReDrawTopView;
  var i,j:integer;
    ZScale:single;
    GreyEntr,dmn,ddn:integer;
    PointColor:integer;
    value:single;
    RGBCol:TColor;
begin
   GreyEntr:=255;
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


procedure TScanDrawLithoThread.TopViewSurfDelete;
var   m,n:integer;
  a:PArrayofDouble0;
DataOneD:PArrayOfSmallInt0;
DataW: TDataRect;
NX,NY,k,i,j:integer;
TempZMax,TempZMin,val:datatype;
dZ:datatype;

procedure ReDrawTopView;
  var i,j:integer;
    ZScale:single;
    GreyEntr,dmn,ddn:integer;
    PointColor:integer;
    value:single;
    RGBCol:TColor;
begin
   GreyEntr:=255;
   ZScale:=GreyEntr/dZ;
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
  PointColor:=255- round(ZScale*(TempZMax-value))  ;     // "255-" добавлено 01/08/2013

  if (PointColor >255) then PointColor:=255
                       else if (PointColor <0)   then PointColor:=0   ;
               RGBCol:= TCOlor($02000000 or (RPaletteKoef[PointColor])
                                         or (GPaletteKoef[PointColor] shl 8)
                                         or (BPaletteKoef[PointColor] shl 16) );

      ImgLChart.BackImage.Bitmap.Canvas.Brush.Color:=RGBCol;
      ImgRBitMapTemp.Canvas.Brush.Color:=RGBCol;
             case ScanParams.ScanPath of
        OneX:  begin
                ImgLChart.BackImage.Bitmap.Canvas.Pixels[dmn,m-ddn-1]:=RGBCol;
                ImgRBitMapTemp.Canvas.Pixels[dmn,m-ddn-1]:=RGBCol;
               end;
        OneY:  begin
                ImgLChart.BackImage.Bitmap.Canvas.Pixels[ddn,n-dmn-1]:=RGBCol;
                ImgRBitMapTemp.Canvas.Pixels[ddn,n-dmn-1]:=RGBCol;
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
 k:=0;
for i:=0 to  NY-1 do
 for j:=0 to  NX-1 do
 begin
        case ScanParams.ScanPath of
 OneX: DataOneD[k]:=ScanData.AquiTopo.Data[j,i];
 OneY:DataOneD[k]:=ScanData.AquiTopo.Data[i,j];
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
 FreeMem(a);
 FreeMem(DataOneD);
end;

function  TScanDrawLithoThread.ZGridModel(PDiscr:integer; lineShift:integer):integer;
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

end.
