unit frProgress;

interface

uses
  Windows, messages,Forms, siComp, siLngLnk, Classes, Controls, ComCtrls,   SysUtils,
  Graphics,  GlobalType,CSpmVar,mMain,
  {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
   ExtCtrls;

type
  TProgress = class(TForm)
    ProgressBar: TProgressBar;
    siLangLinked1: TsiLangLinked;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
   value:apitype;
   dt:word;
   PositionCur:word;
   v:single;
   Present: TDateTime;
   timemove:single;
   timestart,timecur,timeprev:word;
    Hour, Minut, Sec, MSec: Word;
    procedure ThreadDone(var AMessage: TMessage);  message WM_ThreadDoneMsg; // keep track of when and which thread is done executing
  public
    { Public declarations }
  procedure  StartCalibrateDraw;
//  procedure  StartMoveDraw(x0,y0,xend,yend:integer);
end;

var
 Progress: TProgress;
 flgProgressError:boolean;
implementation

{$R *.DFM}
uses GlobalVar,GlobalDCL,SioCSPM,surfacetools,frScanWnd,UNanoEduBaseClasses,ScanWorkThread,ProgressDrawThread ;


procedure TProgress.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
   Progress:=nil;
end;

procedure TProgress.FormCreate(Sender: TObject);
begin
  dt:=500;//msec
 siLangLinked1.ActiveLanguage:=Lang;
 PostMessage(ProgressBar.Handle, $0409, 0, clGreen);
end;

procedure TProgress.ThreadDone(var AMessage: TMessage);
 var hr:Hresult;
procedure GetData;
var i,j,step:integer;
    value,st:apitype;
    Adatmin,Adatmax,datmean,datdelta,DPh,Dz:single;
    TempScanNormData:TScanNormData;
begin
     Adatmin := MaxDATATYPE;
     Adatmax := MinDATATYPE;
     SetScanNormData( TempScanNormData);
     i := 0; j:=0;
     step:=ScanParams.sz;
   repeat
    value:=datatype(PIntegerArray(DataBuf)[j]);
    if  value>0 then value:=0 else   value:=abs(value+1);
    if  ((ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY)) and flgFirstPass then ScanError[i]:=value;
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
        value:=datatype(PIntegerArray(DataBuf)[j]);
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
  Current:begin
            end;
                  end;
   dPh :=abs( TempScanNormData.datmaxPh - TempScanNormData.datminPh);

   if dPh=0 then dPh:=1;
    TempScanNormData.ScaleAdd:=dPh;
  end;
     if FlgFirstPass then
     begin
      ScanNormData:=TempScanNormData;          { TODO : 240306 }
      if(ScanParams.ScanPath=Multi) or (ScanParams.ScanPath=MultiY) then ScanError[length(ScanError)-1]:=ScanError[length(ScanError)-2];
     end
     else ScanNormData_2_Pass:=TempScanNormData;
end;

begin
  if  (mDrawing=AMessage.WParam) then
  begin
    if assigned(ThreadProgress) then
    begin
     ThreadProgress:=nil;
     ThreadProgressActive:=false;
   //  GetData;
     while assigned( NanoEdu.Method) do    Application.processmessages;

 (*   repeat
    hr:=JavaControl.IsRunning(flgJavaRunning);
   if failed(Hr) then
   begin
     {$IFDEF DEBUG}
      Formlog.memolog.Lines.add('error! java is running');
    {$ENDIF};
    flgJavaRunning:=false;
   end;
//   sleep(400);
      Application.ProcessMessages;
    until not flgJavaRunning;
 *)
  WaitforJavaNotActive;

  {$IFDEF DEBUG}
       if not flgJavaRunning then    Formlog.memolog.Lines.add('Stop Java');
  {$ENDIF}
     close;
    end;
  end;
   if mScanning=AMessage.WParam then
    begin
      NanoEdu.Method.ScanWorkDone;
      if Assigned(scWorkThread) then FreeAndNil(scWorkThread);
      GetData;
      NanoEdu.Method.FreeBuffers;
      Freeandnil( NanoEdu.Method);
    end;
end;

procedure TProgress.Timer1Timer(Sender: TObject);
begin
 timer1.Enabled:=false;
       Present:= Now;
       DecodeTime(Present, Hour, Minut, Sec, MSec);
       timecur:=Hour*3600+Minut*60+Sec;//+Msec;
  v:=Scanparams.ScanRate*TransformUnit.XPnm_d;
     if (ProgressBar.Position<ProgressBar.Max) then
        begin
              PositionCur:=PositionCur+round({0.001*}(timecur-timeprev)*v);
              if  PositionCur>ProgressBar.Max then  PositionCur:=ProgressBar.Max;
              ProgressBar.Position :=PositionCur;
              timeprev:=timecur;
              timer1.Enabled:=true;
        end;
end;

procedure   TProgress.StartCalibrateDraw;
var     nz:integer;
        i:longint;
        CurrentP,PointsNmb:longint;
        NewPCount,NPC:longint;
     //   fs:fifo_desc;
  begin
   if flgFirstPass then   caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Calibration Line' *) )
                   else   caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* 'Calibration Line; II Pass' *) );
    ProgressBar.Max:=ScanParams.ScanPoints*ScanParams.sz;//f.out_count;
    ProgressBar.Min:=0;
    if not assigned(ThreadProgress) or (not ThreadProgressActive) then // make sure its not already running
       begin
           ThreadProgress:= TThreadProgress.Create;
           ThreadProgressActive := True;
       end ;
end;

(*procedure   TProgress.StartMoveDraw(x0,y0,xend,yend:integer);
   var

   PositionCur:word;
   z:smallint;
   zs,zx:single;

begin
           timemove:=0;
           v:=Scanparams.ScanRate*TransformUnit.XPnm_d;
       if V>0 then
           timemove:=(abs(x0-xend)+abs(y0-yend))/v ;
          if timemove=0 then timemove:=1;
           Present:= Now;
           DecodeTime(Present, Hour, Minut, Sec, MSec);
           timestart:=Hour*3600+Minut*60+sec;
           timeprev:=timestart;
            caption:=siLangLinked1.GetTextOrDefault('IDS_2' { 'Please, wait while scanner moves to the start point' } );
             ProgressBar.Max:=abs(x0-XEnd)+abs(y0-yend);
          if ProgressBar.Max=0 then ProgressBar.Max:=1;
             ProgressBar.Min:=0;
             ProgressBar.Position:=0;
             PositionCur:=0;
       Timer1.Interval:=dt;
      Timer1.enabled:=true;
        while (ProgressBar.Position<ProgressBar.Max) do application.processmessages;

 end;
 *)
 end.
