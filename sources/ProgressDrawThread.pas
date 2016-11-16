unit ProgressDrawThread;

interface

uses
  Classes, Messages,Windows,Forms,SysUtils,GlobalType,MLPC_APILib_TLB,
    {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
    GlobalDCl;

type
  TThreadProgress = class(TThread)
  private
    { Private declarations }
    ElementSize:integer;
    nElements,CurChElements:Integer;
    nz:integer;
    lsz:longint;
    value:apitype;
    CurrentP:longint;
    CurrentLine:array of TsinglePoint;  //   { TODO : 300506 }
    CurrentLineAdd:array of TSinglePoint;

  protected
   procedure Execute; override;
   procedure GetData;
   procedure drawZIndicator;
   procedure drawProgress;
   procedure drawCurrentLine;
 public
      constructor Create;
      destructor Destroy; override;
  end;

 var ThreadProgress:TThreadProgress;
     ThreadProgressActive:boolean;
     
implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure threadprogress.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ threadprogress }
uses   GlobalVar,CSPMVar,SioCSPM,frScanWnd,frProgress ;


procedure TThreadProgress.Execute;
 var    flgEnd:boolean;
        NChElements,CurChElements,nRead:integer;
        n,ID,count:integer;
        i:longint;
        PointsNmb:longint;
        NewPCount,NPC:longint;
    //    pStopVal:pInteger;
 begin
                PointsNmb:=(2*ScanParams.ScanPoints)*ScanParams.sz;
                CurChElements:=0;
                NewPCount:=0;
 try
//   new(pStopVal);

 if CreateChannels(AlgParams.NChannels) then
  begin
    arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
   if ID=ch_Data_OUT then
   begin
    flgEnd:=false;
    arPCChannel[ch_Data_out].Main.get_Geometry(NChElements,ElementSize);
     {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Channel data; Elements='+inttostr(NChElements)+'size='+inttostr(ElementSize));
    {$ENDIF}

    CurChElements:=0;   // current of elements
    nread:=0;
    count:=0;
      while (not Terminated) do
       begin
        arPCChannel[ch_stop].ChannelRead.Read(StopBuf,nread);
(*        if flgCurrentUserLevel=Demo then
        if   count=5 then
        begin
          flgEnd:=true;
        end;
         inc(count);
  *)
        if StopBuf^=done then   flgEnd:=true;
        arPCChannel[ch_Data_out].ChannelRead.Get_Count(nread);
        arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,nread);    /// nread is not number of elements ????
      {$IFDEF DEBUG}
              Formlog.memolog.Lines.add('caribrate '+inttostr(nread));
       {$ENDIF}
         if (nread+CurChElements)>NChElements
             then  nread:=NChElements-CurChElements;
        if nread<0 then nread:=0;

        NewPCount:=nread;

        while    (NewPCount>0) do
        begin
                  nElements:=nread;
                  getdata;
                  synchronize(drawZIndicator);
                  synchronize(drawProgress);
                  CurChElements:=CurChElements+nElements;;
        end;
                   Application.ProcessMessages;
        if flgEnd then
                begin
                 flgProgressError:=not (CurChElements=NChElements);
                 PostMessage(Progress.Handle,wm_ThreadDoneMsg,mScanning,0);
                 ScanDone;
                 FreeChannels;
                 break;
                end;
       end;  //not terminated
   end;  //id true;
  end;// chanels create
  finally
  //   dispose(pStopVal);
 end;
    {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('End caribrating');
    {$ENDIF}
end;

(* procedure TThreadProgress.Execute;
var
 ScanFlg:Boolean;
 ds,icountPL,icountS,NLines:integer;
 NewPCount:longint;
 i:dword;
 PointsNmb:integer;
 value:apitype;
 fs:fifo_desc;
 label  100;
begin
   PointsNmb:=2*ScanParams.ScanPoints*ScanParams.sz;
   CurrentPoint:=0;
   XPos:=0;
   CurrentP:=0;
   dout:=0;
   dout_ph:=0;
   ds:=1;
   MoveMemory(@fs,@f,sizeof(fifo_desc));
   fs.out_count:=REPORT_NO_WAIT;
  while (not Terminated) do
   begin
     i:=ScanReport(@fs);
       if fs.out_count<=0 then fs.out_count:=0;
       NewPCount:=PointsNmb-fs.out_count-CurrentP;
    if odd(NewPCount) then dec(NewPCount);
     while  (NewPCount>0) do
      begin
       if (XPos=0) and ((i<>0))then
       begin
        synchronize(ClearSeries);
       end;
        if (XPos*ScanParams.sz+NewPCount>=ScanParams.ScanPoints*ScanParams.sz) then
          begin
              NPC:=ScanParams.sz*(ScanParams.ScanPoints-XPos);
              NewPCount:=NewPCount-NPC;
          end
        else
          begin
              NPC:=NewPCount;
              NewPCount:=0;
          end;
        try
              lsz:=NPC div  ScanParams.sz;
              SetLength(TempAquiData,lsz);
              SetLength(CurrentLine,lsz);
         if  ScanParams.sz=2 then
           begin
            SetLength(TempAquiAddData,lsz);
            SetLength(CurrentLineAdd,lsz);
           end;
         GetScanData(Dout_PH,ScanData);
//                             else   GetScanData(Dout_PH_2,ScanDataSecondPass);
            Synchronize(DrawCurrentLine);
        finally
              line:=nil;
              CurrentLine:=nil;
              if  ScanParams.sz=2 then CurrentLineAdd:=nil;
        end;
          CurrentP:=CurrentP+NPC;
          XPos:=XPos+lsz;  //NPC
              XPos:=0;
              PointInd:=0;
              ScanFlg:=False;
      end;// NewPpoint>0
    if i=0 then
      begin
         PostMessage(ScanWnd.Handle,wm_ThreadDoneMsg,mScanning,0);
         break;
      end;
      fs.in_count:=REPORT_WAIT;       {‘ормирование условий работы функции ScanReport()}
      fs.path_count:=REPORT_WAIT;     {ѕо потокам IN, PATH мы ожидаем окончани€ сканировани€}
   if fs.out_count>ds then  fs.out_count:=fs.out_count-ds          {”становка следующей метки в потоке OUT дл€ остановки}
                      else  fs.out_count:=REPORT_WAIT;  {...либо ожидание конца сканировани€, если данных осталось мало}
 end; {while ScanCount}
{ Prepare Scan Data delete max and invert }
finally
   fs.Pin:=nil;
   fs.Pout:=nil;
   fs.PPath:=nil;
   TempAquiData:=nil;
 if (ScanParams.Sz=2) then  TempAquiAddData:=nil;
  if (not Terminated) then  Self.Terminate;
end;{finally}
end;
*)
(*
procedure TThreadProgress.GetScanData(var n:longint; var Data:TExperiment);
var i,CurrentPoint,CurScan:integer;
    j:longint;
    value:apitype;
begin
  j:=n;
 if (ScanParams.ScanMode<>Multi) and (ScanParams.ScanMode<>MultiY) then CurScan:=ScanParams.CurrentScanCount
                                                                   else CurScan:=0;
 for i:=0 to lsz-1 do
  begin
   CurrentPoint:=(CurrentP div  ScanParams.sz)+i-CurScan*ScanParams.ScanPoints;
   value :=datatype(PWordArray(data_out)[j]);
  if flgFirstPass then  begin if value>0 then value:=0 else   value:=abs(value+1);  end;
      TempAquiData[i]:=value;
  if ((ScanParams.ScanMode=Multi) or (ScanParams.ScanMode=MultiY)) and flgFirstPass then ScanError[CurrentPoint]:=value;
     { TODO : 240306 }
  if  CurrentPoint<ScanParams.ScanPoints then
    begin

  //Additional View
    if    ScanParams.ScanMethod  in ScanModesSetAdd then
     //Additional View
    begin
         inc(j);
         value :=datatype(PWordArray(data_out)[j]);
      case ScanParams.ScanMethod of
     UAM:  begin
            if value<0 then value:=0 ;
           end;
             end;
           TempAquiAddData[i]:=value;
         dec(j);
    end;
      inc(j, ScanParams.sz);
  end;
 end; //i
  n:=j;
end;
*)
PROCEDURE TThreadProgress.getdata;
var z:integer;
begin
       z     :=datatype(PIntegerArray(DataBuf)[nElements-1] shr 16);//[nz]);
       value :=round((MinAPITYPE+1)*(Z-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));
(*           x:=nz*ScanParams.Stepxy;
           y:=Currentline[i].y;
    if not assigned(CurrentLineWnd) then  ScanWnd.SeriesLine.AddXY(x,y)
                                    else  CurrentLineWnd.SeriesLine.AddXY(x,y);
  if  ScanParams.sz=2 then
    begin
             y:=CurrentlineAdd[i].y;
        if not assigned(CurrentLineWnd) then  ScanWnd.SeriesAddLine.AddXY(x,y)
                                        else  CurrentLineWnd.SeriesAddLine.AddXY(x,y);
           end;
 *)
(*procedure GetData;
var i,j,step:integer;
    value,st:apitype;
    Adatmin,Adatmax,datmean,datdelta,DPh,Dz:single;
    TempScanNormData:TScanNormData;
begin
     Adatmin := 32767;
     Adatmax :=-32768;
     SetScanNormData( TempScanNormData);
     i := 0; j:=0;
     step:=ScanParams.sz;
   repeat
    value:=datatype(PWordArray(data_out)[j]);
    if  value>0 then value:=0 else   value:=abs(value+1);
    if  ((ScanParams.ScanMode=Multi) or (ScanParams.ScanMode=MultiY)) and flgFirstPass then ScanError[i]:=value;
    TempScanNormData.PrevLine[i]:= value;
    if value < Adatmin then Adatmin :=value;
    if value > Adatmax then Adatmax :=value;
     inc(j,step);
     inc(i);
   until i>(ScanParams.ScanPoints-1);
    if ScannerCorrect.flgPlnDel then  LinDelFiltPlaneParm(ScanParams.ScanPoints,TempScanNormData.PrevLine,TempScanNormData.sfA,TempScanNormData.sfB)
                                else  begin TempScanNormData.sfA:=0.0; TempScanNormData.sfB:=0.0;end;
     for i := 0 to ScanParams.ScanPoints- 1 do
          begin
              TempScanNormData.PrevLine[i]:=TempScanNormData.PrevLine[i]-(TempScanNormData.sfA+TempScanNormData.sfB*i);
              if TempScanNormData.PrevLine[i] < TempScanNormData.datmin then TempScanNormData.datmin :=TempScanNormData.PrevLine[i];
              if TempScanNormData.PrevLine[i] > TempScanNormData.datmax then TempScanNormData.datmax :=TempScanNormData.PrevLine[i];
          end;
     dZ := TempScanNormData.datmax - TempScanNormData.datmin;
     if dZ=0 then dZ:=1;
     TempScanNormData.ScaleZ0:=dZ;
  if ScanParams.flgAquiAdd  then
  begin
    i:=0; j:=1;
    repeat
     begin
        value:=datatype(PWordArray(data_out)[j]);
             case ScanParams.ScanMethod of
      UAM:  begin
              if value<0 then  value:=0;
            end;
                 end;
      if value < TempScanNormData.datminPh then TempScanNormData.datminPh :=value;
      if value > TempScanNormData.datmaxPh then TempScanNormData.datmaxPh :=value;
      inc(j,step);
      inc(i);
     end;
    until i>(ScanParams.ScanPoints-1);
    if True then

//    datmean:= (TempScanNormData.datmaxPh+TempScanNormData.datminPh)*0.5;
//    datdelta:=(TempScanNormData.datmaxPh-TempScanNormData.datminPh)*0.5;
//    TempScanNormData.datmaxPh:=(datmean+datdelta*1.3);
// if TempScanNormData.datmaxPh>MaxApiType then TempScanNormData.datMaxPh:=MaxApiType;
//    TempScanNormData.datminPh:=(datmean-datdelta*1.3);
              case ScanParams.ScanMethod of
     Phase: begin
              if TempScanNormData.datminPh<MinApiType then TempScanNormData.datMinPh:=MinApiType;
            end;
      UAM:  begin
              if TempScanNormData.datminPh<0 then TempScanNormData.datMinPh:=0;
            end;
 CurrentSTM:begin
            end;
                  end;
   dPh :=abs( TempScanNormData.datmaxPh - TempScanNormData.datminPh);

   if dPh=0 then dPh:=1;
    TempScanNormData.ScaleAdd:=dPh;
  end;
     if FlgFirstPass then
     begin
      ScanNormData:=TempScanNormData;          { TODO : 240306 }
      if(ScanParams.ScanMode=Multi) or (ScanParams.ScanMode=MultiY) then ScanError[length(ScanError)-1]:=ScanError[length(ScanError)-2];
     end
     else ScanNormData_2_Pass:=TempScanNormData;
end;
*)
end;
procedure TThreadProgress.drawZIndicator;
begin
     ScanWnd.ZIndicatorDraw(value);
end;
procedure TThreadProgress.drawCurrentLine;
 var flgchange,flgchangeph:boolean;
    i:integer;
    x,y:double;
begin
(* flgchange:=false;  flgchangeph:=false;
for i:=0 to lsz-1 do
begin
   y:=Currentline[i].y;
   if y>tmax then begin tmax:=y;flgchange:=true;  end;
   if y<tmin then begin tmin:=y;flgchange:=true;  end;
   if  ScanParams.sz=2 then
    begin
     y:= CurrentlineAdd[i].y;
     if y>tmaxph then begin tmaxph:=y;flgchangeph:=true;  end;
     if y<tminph then begin tminph:=y;flgchangeph:=true;  end;
   end;
end;
 if not assigned(CurrentLineWnd) then
 begin
  if flgchangeph and ScanWnd.SeriesAddLine.Active  then ScanWnd.ChartCurrentLine.LeftAxis.SetMinMax(tminph,tmaxph);
  if flgchange   and ScanWnd.SeriesLine.Active     then ScanWnd.ChartCurrentLine.LeftAxis.SetMinMax(tmin,tmax);
 end
 else
 begin
  if flgchangeph and CurrentLineWnd.SeriesAddLine.Active  then CurrentLineWnd.ChartCurrentLine.LeftAxis.SetMinMax(tminph,tmaxph);
  if flgchange   and CurrentLineWnd.SeriesLine.Active     then CurrentLineWnd.ChartCurrentLine.LeftAxis.SetMinMax(tmin,tmax);
 end;
for i:=0 to lsz-1 do
 begin
           x:=Currentline[i].x*ScanParams.Stepxy;
           y:=Currentline[i].y;
    if not assigned(CurrentLineWnd) then  ScanWnd.SeriesLine.AddXY(x,y)
                                    else  CurrentLineWnd.SeriesLine.AddXY(x,y);
  if  ScanParams.sz=2 then
    begin
             y:=CurrentlineAdd[i].y;
        if not assigned(CurrentLineWnd) then  ScanWnd.SeriesAddLine.AddXY(x,y)
                                        else  CurrentLineWnd.SeriesAddLine.AddXY(x,y);
           end;
 end;//i
 *)
end;

procedure TThreadProgress.drawProgress;
begin
 if CurChElements<=ScanParams.ScanPoints*ScanParams.sz
   then  Progress.ProgressBar.Position :=CurChElements
   else  Progress.ProgressBar.Position :=2*Progress.ProgressBar.Max-CurChElements;
end;

constructor TThreadProgress.Create;
begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;// Resume;
 end;

destructor TThreadProgress.Destroy;
begin
   ThreadFlg:=mDrawing;
   PostMessage(Progress.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;

end.
