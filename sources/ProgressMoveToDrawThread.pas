unit ProgressMoveToDrawThread;

interface

uses
  Classes, Messages,Windows,SysUtils,
  GlobalType,MLPC_APILib_TLB,
    {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
    GlobalDCl;
type
  TThreadProgressMoveTo = class(TThread)
  private
    { Private declarations }
          dwStart:dword;
  protected
   procedure Execute; override;
   procedure GetData;
   procedure DrawProgress;
 public
      constructor Create;
      destructor Destroy; override;
  end;

 var ThreadMoveToProgress:TThreadProgressMoveTo;
     ThreadMoveToProgressActive:boolean;


implementation


uses   GlobalVar,CSPMVar,SioCSPM,frScanWnd,frProgressMoveto ;


procedure TThreadProgressMoveTo.Execute;
 var    flgEnd:boolean;
        NChElements,CurChElements,nRead:integer;
        n,ID:integer;
        i,count:longint;
        NewPCount,NPC:longint;
        hr:Hresult;
 begin
       CurChElements:=0;
       NewPCount:=0;
 try
    {$IFDEF DEBUG}
       Formlog.memolog.Lines.add(ProgressMoveTo.siLangLinked1.GetTextOrDefault('IDS_0' (* 'Start progress drawing' *) ));
    {$ENDIF}
 if CreateChannels(AlgParams.nchannels) then
  begin
    dwStart:=GetTickCount();
    //set start time
    count:=0;
     while (not Terminated) do
       begin
           nread:=1;
           hr:=arPCChannel[ch_Draw_done].ChannelRead.Read(DoneBuf,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
       {$IFDEF DEBUG}
          if Failed(hr) then Formlog.memolog.Lines.add(ProgressMoveTo.siLangLinked1.GetTextOrDefault('IDS_1' (* 'error read done channel' *) )+ProgressMoveTo.siLangLinked1.GetTextOrDefault('IDS_2' (* 'hr=' *) )+inttostr(hr))
                     else Formlog.memolog.Lines.add(ProgressMoveTo.siLangLinked1.GetTextOrDefault('IDS_3' (* 'read done channel =' *) )+inttostr(PintegerArray(DoneBuf)[0]));
       {$ENDIF}
        if (PIntegerArray(DoneBuf)[0]=done)  then   flgEnd:=true;
       {$IFDEF DEBUG}
          Formlog.memolog.Lines.add(ProgressMoveTo.siLangLinked1.GetTextOrDefault('IDS_7' (* 'move to' *) ));
       {$ENDIF}
       sleep(500);
       synchronize(drawProgress);
      if flgEnd then
                begin
                 ScanDone;
                 FreeChannels;
                 PostMessage(ProgressMoveTo.Handle,wm_ThreadDoneMsg,mScanning,0);
                 break;
                end;
       end;  //not terminated
  end;// chanels create
  finally

 end;
    {$IFDEF DEBUG}
         Formlog.memolog.Lines.add(ProgressMoveTo.siLangLinked1.GetTextOrDefault('IDS_8' (* 'End Move to' *) ));
    {$ENDIF}
end;


PROCEDURE TThreadProgressMoveTo.getdata;
var z:integer;
begin
//       z     :=datatype(PIntegerArray(Data_Out)[nElements-1] shr 16);//[nz]);
//       value :=round((MinAPITYPE+1)*(Z-MaxAPITYPE)/(MaxAPITYPE-MinAPITYPE));

end;

procedure TThreadProgressMoveTo.DrawProgress;
var dwCurrent:Dword;
PositionCur:integer;
 v:single;
begin
 dwCurrent:=GetTickCount();
   v:=Scanparams.ScanRate*TransformUnit.XPnm_d;
     if (ProgressMoveTo.ProgressBar.Position<ProgressMoveTo.ProgressBar.Max) then
        begin
              PositionCur:=round(0.001*(dwCurrent-dwStart)*v);
              if  PositionCur>ProgressMoveTo.ProgressBar.Max then  PositionCur:= ProgressMoveTo.ProgressBar.Max;
              ProgressMoveTo.ProgressBar.Position :=PositionCur;
           end;
end;

constructor TThreadProgressMoveTo.Create;
begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;// Resume;
end;

destructor TThreadProgressMoveTo.Destroy;
begin
   ThreadFlg:=mDrawing;
   PostMessage(ProgressMoveTo.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
   inherited destroy;
end;

end.
