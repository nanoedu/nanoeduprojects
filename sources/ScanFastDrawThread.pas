// 10.04.15 error when fast scanning- correction add (ScanParams.CurrentScanCount<>ScanParams.ScanLines)

//210616 limit only 5 frame       drawing
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O-,P+,Q+,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
unit ScanFastDrawThread;

interface

uses
  Classes,  Windows,Forms, Messages,SysUtils, Dialogs,  Graphics, Controls,
  extctrls,Math, GlobalType,GlobalScanDataType,MLPC_APILib_TLB,MLPC_APILib_Demo,Activex,
  {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
      GlobalDCl;
 type
  TScanFastDrawThread = class(TThread)
  private
    ErrorController:boolean;
    GreyEntr:byte;
    ZIndicatorVal:integer;
    ZIndicatorNormVal:single;
    ElementSize:Integer;
    nElements,CurChElements:Integer;
    mod512corr:integer;   // дополнительный элемент, чтобы исключить  передачу кол-ва
                          // данных, кратных 512
    XPos:integer;
    procedure  SpeedBtnView;
  private
    BitMap:TBitMap;
    OldPal:HPalette;
    OldPixelFormat: TPixelFormat;
    CurrentScanFrame:Integer;
    procedure MakePalette(BitMap: TBitMap);
  protected
    procedure sZIndicator;
    procedure Execute; override;
    procedure RenderImg;
    procedure CountUpd;
    procedure UpdButtons;
    function  Sign(a:single):integer;
  public
      constructor Create;
      destructor Destroy; override;
end;

var // FlgStopMulti:Boolean; //Multi pass
     ScFastDrawThread:TScanFastDrawThread;
     ScFastDrawThreadActive : boolean;

implementation

uses Chart,GlobalVar, GlobalFunction, SioCSPM,frScanWnd,frCurrentLine,mMain,
     frContrastTopView,SurfaceTools,CSPMVar, RenishawVars;

procedure TScanFastDrawThread.MakePalette(BitMap: TBitMap);
var i : Integer;
    pal : PLogPalette;
    hpal:HPALETTE;
begin
  pal := nil;
  GetMem(pal, sizeof(TLogPalette) + sizeof(TPaletteEntry) * 255);
  try
  begin
    pal.palVersion := $300;
    pal.palNumEntries := 256;
    for i := 0 to 255 do
    begin
      pal.palPalEntry[i].peRed := i;
      pal.palPalEntry[i].peGreen := i;
      pal.palPalEntry[i].peBlue := i;
      pal^.palPalEntry[i].peFlags := pc_nocollapse;
    end;
    if hPal<>0 then     DeleteObject(hPal);
    hpal := CreatePalette(pal^);
    if hpal <> 0 then  BitMap.Palette := hpal; // Ёто место где созданна€ палитра присваиваетьс€ Bitmap.
                             // ≈сли писать без классов то надо писать так Bitmap.Palette:=hpal

  end
  finally
    FreeMem(pal);
    DeleteObject(hPal);
  end;
end; {MakePalette}


constructor TScanFastDrawThread.Create;
begin
  inherited Create(True);
   CoInitializeEx(nil,COINIT_MULTITHREADED);
   ErrorController:=false;
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;// Resume;
   OldPal:=ScanWnd.ImgRChart.BackImage.Bitmap.Palette;
   BiTmap:=TBitmap.Create;
   BiTmap.PixelFormat:=OldPixelFormat;
   BitMap.PixelFormat:=pf8bit ;
   BitMap.Height:=ScanParams.NY;
   BitMap.Width:=ScanParams.NX;
   MakePalette(BitMap);
 end;

destructor TScanFastDrawThread.Destroy;
begin
    CoUnInitialize;
   FreeAndNil(BiTmap);
   ThreadFlg:=mFastDrawing;
  if (ErrorController) then  PostMessage(ScanWnd.Handle,wm_ThreadDoneMsg,ThreadFlg,lError)
                       else  PostMessage(ScanWnd.Handle,wm_ThreadDoneMsg,ThreadFlg,lOK);
   inherited destroy;
end;



procedure  TScanFastDrawThread.SpeedBtnView;
begin
      if CurrentScanFrame>0 then
        begin
       //  ScanWnd.SpeedBTnCapture.Visible :=true;
        end;
end;
procedure TScanFastDrawThread.Execute;
var
 ScanFlg:Boolean;
 NewPCount:longint;
 i:dword;
 errScan:word;
 PointsNmb:integer;
 value:apitype;
 OneLinePointsNmb:integer;
 ntoread,nhasread:integer;
 hr:HResult;
 flgEnd:boolean;
 NChElements,CurChElements,nRead:integer;
 n,ID,nwrite,errorcountstop,count:integer;
 data:integer;
 errcnt:integer;
 nrepeat,nInLine:integer;
 nc:integer;
   label  100;
begin
   ErrorController:=false;
   mod512corr:=1;
   TopViewFromRGB:=$00000000;;
   TopViewToRGB:= $00FFFFFF;
   GreyEntr:=255;
   n:=0;
   ScanFlg:=False;
   errcnt:=0;
   {$IFDEF DEBUG}
      Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_0' (* 'Start drawing' *) ));
   {$ENDIF}
if CreateChannels(AlgParams.NChannels) then
 begin
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
    nread:=0;
    nc:=0;
 while (not Terminated)  and (not flgEnd) and (not ErrorController) do
 begin
      nread:=1;
      if FlgStopJava then        //28/11/16          if   not video stream
      begin
      //     sleep(500);
           PintegerArray(StopBuf)[0]:=StopJava;
           repeat
           begin
            nwrite:=1;
            hr:=arPCChannel[ch_stop].ChannelWrite.Write(StopBuf,nwrite);     //read stop channel  if stopbutton pressed  pStopval^=done
            if Failed(hr) then
                {$IFDEF DEBUG}
                  Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_14' { 'error write stop channel' } )+inttostr(nwrite)+ScanWnd.siLangLinked1.GetTextOrDefault('IDS_5' {* 'hr=' } )+inttostr(hr))
               {$ENDIF}
                else
               {$IFDEF DEBUG}
                    Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_16' { 'write stop channel =' } )+inttostr(PIntegerArray(StopBuf)[0])+' '+inttostr(nwrite));
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
                  Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_27' { 'error read stop channel' } )+inttostr(nread)+ScanWnd.siLangLinked1.GetTextOrDefault('IDS_5' { 'hr=' } )+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_29' { 'read stop channel =' } )+inttostr(PIntegerArray(DoneBuf)[0])+' '+inttostr(nread));
            {$ENDIF}
            inc(count);
            sleep(100);
          until  (PIntegerArray(DoneBuf)[0]=done) or (count=20);
          if PIntegerArray(DoneBuf)[0]=done then
           begin
            flgEnd:=true; //stop button press       stop scanning
            break;
           end;
      end;    //stop java

        sleep(4000); //
        hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(ntoread);     //get new data count
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_31' (* 'error get count data ' *) )+inttostr(ntoread)+ScanWnd.siLangLinked1.GetTextOrDefault('IDS_5' (* 'hr=' *) )+inttostr(hr))
                      else Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_33' (* 'scandraw data to read ' *) )+inttostr(ntoread));
       {$ENDIF}
      // ƒалее +1 - лишн€€ точка, чтобы исключить передачу данных длиной,
      //  кратной 512 байт
//    if ntoread >= ScanParams.ScanPoints +mod512corr then     nhasread:=0;             //????
      nInLine:= ScanParams.ScanLines*ScanParams.ScanPoints+mod512corr;
      hr:=(arPCChannel[ch_Data_out].ChannelRead).Read(DataBuf,ntoread);
      {$IFDEF DEBUG}
       if Failed(hr) then Formlog.memolog.Lines.add(ScanWnd.siLangLinked1.GetTextOrDefault('IDS_36' (* 'error read channel data ' *) )+inttostr(ntoread)+ScanWnd.siLangLinked1.GetTextOrDefault('IDS_5' (* 'hr=' *) )+inttostr(hr))
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

//!!!!!!!!    10.04.15
      nrepeat:=(ntoread div nInLine);
      XPos:=0;
  if (nrepeat>0) and (not flgEnd)then
   begin
    for i:=0 to nrepeat-1
    do
    begin
   //    nread:=ScanParams.ScanLines*ScanParams.ScanPoints+mod512corr;
       Synchronize(RenderImg);
       Synchronize(SpeedBtnView);
       Synchronize(CountUpd);
       inc(CurrentScanFrame );
       if  flgRecord then
             begin
              ScanData.WorkFileName:=workdirectory+'\'+WorkNameFileMaskCur+getletime+WorkExtFile;
              ScanData.HeaderPrepare;
              ScanData.PrepareSaveData;
              ScanData.SaveExperiment;
              if assigned(WorkView) then
                  PostMessage(WorkView.Handle,WM_UserUpdateWorkView,0,0)  ;
             end;
    end; // i
   // flgEnd:=true;     //   28/11/16 if not video stream
   end;
  // if nc=4 then
 end; {while NOT TERMINATE}
end;  //ID not data channel
     FlgScanError:=False;
     ScanDone;
     FreeChannels;
     PostMessage(ScanWnd.Handle,wm_ThreadDoneMsg,mScanning,0);
     FlgScanError:=CurrentScanFrame=0;
     if FlgScanError then
      begin
         ScanData.AquiTopo.Ny:=0;
         ScanData.AquiAdd.Ny :=0;
         ScanData.AquiTopo.Nx:=0;
         ScanData.AquiAdd.Nx :=0;
      end;
     if (not FlgScanError) then
     begin
      ScanData.WorkFileName:=WorkNameFile;
     end;
end; // create channel =true
100:  ;
//  if (not Terminated) then  Self.Terminate;
  {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('End drawing');
         if ErrorController then   Formlog.memolog.Lines.add('The Controller Error');
   {$ENDIF}end;  //execute

procedure TScanFastDrawThread.sZIndicator;
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
    ScanWND.LabelZV.Caption:=FloattoStrF( ZindicatorNormVal,fffixed,3,2); // 30/07/2013
    ScanWND.ZIndicatorScan.Repaint;
end;

procedure TScanFastDrawThread.RenderImg();
var i,j,k:integer;
    ZScale,ZScalePh:single;
    mini,maxi:datatype;
    GreyEntr,n,m:integer;
    PointColor:integer;
    RGBCol:TColor;
    P:PByteArray;
    value:apitype;
    counterr:integer;
begin
        counterr:=0;
        n:=ScanParams.Nx;
        m:=ScanParams.Ny;
        GreyEntr:=255;
        k:=XPos;
 for j:=0 to m-1 do
   for i:=0 to n-1 do
    begin
     value :=datatype(PIntegerArray(DataBuf)[k] shr 16);
     if value=9999 then        inc(counterr);
     ScanData.AquiADD.Data[i,j]:=value;
     inc(k);
    end;
    XPos:=k+1;
  ZIndicatorNormVal:=(1- (value-MinAPITYPE)/(MaxAPITYPE-MinAPITYPE));  //(0 .. 1)
  ZIndicatorVal:=round(ZIndicatorNormVal*MaxAPITYPE);   // (0.. 32767)
  Synchronize(sZIndicator);
     MinI:=ScanData.AquiADD.DataMin;
     MaxI:=ScanData.AquiADD.DataMax;
     ScanNormData.ScaleAdd:=maxI-minI;
     ZScalePh:=GreyEntr/ScanNormData.ScaleAdd;
  for j:=0 to m-1 do
  begin
   P:=BitMap.ScanLine[m-j-1];
   for i:=0 to n-1 do
    begin
     PointColor:=round((ZScalePH*( ScanData.AquiADD.Data[i,j]-MinI)));
     if (PointColor >255) then  PointColor:=255;
     if (PointColor<0)    then  PointColor:=0;
     P[i]:=PointColor;
    end;
  end;
  ScanWnd.ImgRChart.BackImage.Assign(BitMap);
  ScanWnd.ImgRBitMapTemp.Assign(BitMap);
  ScanWnd.ImgRChart.Repaint;
  if counterr>10 then ErrorController:=true;
end;

procedure TScanFastDrawThread.CountUpd;
begin
 ScanWnd.edScanNmb.Text:=IntToStr(CurrentScanFrame);
    if CurrentScanFrame>1 then
        begin
         // ScanWnd.SpeedBTnCapture.Visible :=true;
        end;
// Main.MainStatusBarFill;
end;

procedure TScanFastDrawThread.UpdButtons;
begin
 with ScanWnd do
  begin
   ToolBarScanWnd.Font.Color:=clBlack;
   StartBtn.Caption:=ScanWnd.siLangLinked1.GetTextOrDefault('IDS_17' (* '&START' *) );
  end;
end;



function TScanFastDrawThread.Sign(a:single):integer;
begin
 { TODO : 101202 }
 Sign:=1;
  if a<0 then Sign:=-1
         else if a=0 then Sign:=0;       ///!!!!!
end;

end.
