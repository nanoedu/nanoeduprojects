unit ThreadReadFromAdapter;

interface

uses
  Classes,windows,SysUtils,Globaltype,MLPC_APILib_TLB,comobj,activex,
    {$IFDEF DEBUG}
       frDebug,
   {$ENDIF}
      CSPMVar,GlobalDCl;

type
  TReadFRomAdapterThread = class(TThread)
  private
    CurrentP,PointsNmb:integer;

    function  GetHeader(offs:integer; var pAdapterHead:PAdapterHeadRecord):boolean;
    function  GetParams(offs:integer; var ScannerOptRecord:RScannerOptMod;  var AdapterOptMod:PAdapterOptFloatRecord):boolean;
    function  GetCurve(offs:integer; var AdapterCurveRecord:PAdapterLinPointsRecord):boolean;
  protected
    procedure Execute; override;
    procedure Drawprogress;
    procedure DrawprogressEtape;
    procedure GetScanData(var n:longint );
  public
    constructor Create;
    destructor  Destroy; override;
  end;

  var
  ReadFromAdapterThread:TReadFRomAdapterThread;
  ReadFromAdapterThreadActive:boolean;

implementation

uses GlobalVar,SioCSPM,mMain,frAdapterService,frUnitInitEtap,UAdapterService;

constructor TReadFRomAdapterThread.Create;
begin
  inherited Create(True);
   CoInitializeEx(nil,COINIT_MULTITHREADED);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := false;
end;

destructor TReadFRomAdapterThread.Destroy;
begin
    CoUnInitialize;
    ThreadFlg:=mReadingMLPC;
   if assigned(AdapterService) then   PostMessage(AdapterService.Handle,wm_ThreadDoneMsg,ThreadFlg,0)
                               else   PostMessage(Main.Handle,wm_ThreadDoneMsg,ThreadFlg,0);
    inherited destroy;
end;
 procedure  TReadFRomAdapterThread.Drawprogress;
 begin
  AdapterService.ProgressBar.Position:=CurrentP;
 end;
 procedure  TReadFRomAdapterThread.DrawprogressEtape;
 begin
  formInitUnitEtape.ProgressBar.Position:=10+CurrentP;
 end;
 function TReadFromAdapterThread.GetHeader(offs:integer; var pAdapterHead:PAdapterHeadRecord):boolean;
var i:integer;
 begin
  with pAdapterHead^ do
   begin
       PageNmb:=PAdapterHeadRecord(integer(databuf)+offs)^.PageNmb;
       PageTypeId:=PAdapterHeadRecord(integer(databuf)+offs)^.PageTypeId;
       aflgUnit:=ord(PAdapterHeadRecord(integer(databuf)+offs)^.aflgUnit);
       flgUnit:=aflgUNit;
       NTSPBId:=PAdapterHeadRecord(integer(databuf)+offs)^.NTSPBId;
       ProtocolVers:=PAdapterHeadRecord(integer(databuf)+offs)^.ProtocolVers;
       ScannerNumber:=PAdapterHeadRecord(integer(databuf)+offs)^.ScannerNumber;
       flgAdapterNotFilled:=false;
      for I := 1 to 6 do
      begin
       pagewritten[i]:=PAdapterHeadRecord(integer(databuf)+offs)^.pagewritten[i];
       if pagewritten[i]=0 then  flgAdapterNotFilled:=true;
      end;
      //test scanner number!!!
   end;
   HardWareOPt.ScannerNumb:=pAdapterHead^.ScannerNumber;
end;
function TReadFRomAdapterThread.GetParams(offs:integer;var ScannerOptRecord:RScannerOptMod; var AdapterOptMod:PAdapterOptFloatRecord):boolean;
begin
   with AdapterOptMod^ do
   begin
       PageNmb:=PAdapterOptFloatRecord(integer(databuf)+offs)^.PageNmb;
       PageTypeId:=PAdapterOptFloatRecord(integer(databuf)+offs)^.PageTypeId;
       DataLengthInt:=PAdapterOptFloatRecord(integer(databuf)+offs)^.DataLengthInt;
       NonLinFieldX:=PAdapterOptFloatRecord(integer(databuf)+offs)^.NonLinFieldX;
       NonLinFieldY:=PAdapterOptFloatRecord(integer(databuf)+offs)^.NonLinFieldY;     //nm
       GridCellSize:=PAdapterOptFloatRecord(integer(databuf)+offs)^.GridCellSize; //nm
       YBiasTan:=PAdapterOptFloatRecord(integer(databuf)+offs)^.YBiasTan;//single;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=PAdapterOptFloatRecord(integer(databuf)+offs)^.SensitivZ;//single;
       SensitivX:=PAdapterOptFloatRecord(integer(databuf)+offs)^.SensitivX;//single;
       SensitivY:=PAdapterOptFloatRecord(integer(databuf)+offs)^.SensitivY;//single;
       I_VTransfKoef:=PAdapterOptFloatRecord(integer(databuf)+offs)^.I_VTransfKoef;//single;
   end;
   with ScannerOptRecord do
   begin
       NonLinFieldX:=AdapterOptMod^.NonLinFieldX;
       NonLinFieldY:=AdapterOptMod^.NonLinFieldY;     //nm
       GridCellSize:=AdapterOptMod^.GridCellSize; //nm
       YBiasTan:=AdapterOptMod^.YBiasTan;//single;   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=AdapterOptMod^.SensitivZ;//single;
       SensitivX:=AdapterOptMod^.SensitivX;//single;
       SensitivY:=AdapterOptMod^.SensitivY;//single;
       I_VTransfKoef:=AdapterOptMod^.I_VTransfKoef;//single;
   end;
end;
function TReadFRomAdapterThread.GetCurve(offs:integer;var AdapterCurveRecord:PAdapterLinPointsRecord):boolean;
var i:integer;
begin
     with AdapterCurveRecord^ do
   begin
       pageNmb:=PAdapterLinPointsRecord(integer(databuf)+offs)^.pageNmb;
       PageTypeId:=PAdapterLinPointsRecord(integer(databuf)+offs)^.PageTypeId; //Memorypagetype;
       DataLengthInt:=PAdapterLinPointsRecord(integer(databuf)+offs)^.DataLengthInt;
       LinearizationDate:=PAdapterLinPointsRecord(integer(databuf)+offs)^.LinearizationDate;
       NPoints:=PAdapterLinPointsRecord(integer(databuf)+offs)^.NPoints;
       for I:= 1 to NPoints do
       Points[i]:=PAdapterLinPointsRecord(integer(databuf)+offs)^.Points[i];     // array[1..64] of integer;
   end;
  //copy scannerparams?????
end;
procedure TReadFRomAdapterThread.Execute;
var
    ntoread:integer;
//NE II
    hr:HResult;
    flgEnd:boolean;
    NElements,nRead, nwrite:integer;
    n,ID:integer;
    data:integer;
    errcnt:integer;
    ElementSize:integer;
    //
begin
  flgEnd:=false;
  CurrentP:=0;
  {$IFDEF DEBUG}
         Formlog.memolog.Lines.add('Start drawing');
  {$ENDIF}
   sleep(1000);
   if assigned(AdapterService) then
   begin
    AdapterService.ProgressBar.Max:=AdapterService.taskreadcount;
    AdapterService.ProgressBar.Position:=0;
   end;


if CreateChannels(AlgParams.NChannels) then
 begin
   arPCChannel[ch_Data_out].Main.Get_Id(ID);  //data out channel
  if ID=ch_Data_OUT then
  begin
    hr:=arPCChannel[ch_Data_out].Main.get_Geometry(NElements,ElementSize);
      {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error read geometry'+inttostr(nread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('Channel data; Elements='+inttostr(NElements)+'size='+inttostr(ElementSize));
      {$ENDIF}

  while (not Terminated)  and (currentP<NElements) and (not flgEnd) do
  begin
(*      nread:=1;
      if FlgStopJava then
         begin
            hr:=arPCChannel[ch_Draw_done].ChannelRead.Read(pStopval,nread);     //read stop channel  if stopbutton pressed  pStopval^=done
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error read stop channel'+inttostr(nread)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('read stop channel ='+inttostr(pStopval^)+' '+inttostr(nread));
            {$ENDIF}

           if pStopval^=done then   flgEnd:=true; //stop button press       stop scanning
         end;
 *)
       sleep(300);
      hr:=arPCChannel[ch_Data_out].ChannelRead.Get_Count(ntoread);     //get new data count
       {$IFDEF DEBUG}
        if Failed(hr) then Formlog.memolog.Lines.add('error get count data '+inttostr(ntoread)+'hr='+inttostr(hr))
                      else Formlog.memolog.Lines.add('adapter data to read '+inttostr(ntoread));
       {$ENDIF}

       nread:=ntoread;
  //     repeat
       hr:=arPCChannel[ch_Data_out].ChannelRead.Read(DataBuf,nread);    /// read data //nread is not number of elements ????
      {$IFDEF DEBUG}
       if Failed(hr) then Formlog.memolog.Lines.add('error read channel data '+inttostr(nread)+'hr='+inttostr(hr))
                     else Formlog.memolog.Lines.add('adapter data has read '+inttostr(nread));
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
 //      until not Failed(hr) or (errcnt>100);
     if nread>0 then
      begin
        CurrentP:=CurrentP+nRead;
        if assigned(AdapterService)    then   synchronize(DrawProgress);
        if Assigned(formInitUnitEtape) then   synchronize(DrawProgressEtape);
        
         GetScanData(nread);
        PintegerArray(DoneBuf)[0]:=done;
        nwrite:=1;
        hr:=arPCChannel[ch_Draw_done].ChannelWrite.Write(DoneBuf,nwrite);     //WRITE TO READ NEXT PAGE
            {$IFDEF DEBUG}
             if Failed(hr) then
                  Formlog.memolog.Lines.add('error write done channel'+inttostr(nwrite)+'hr='+inttostr(hr))
                  else
                 Formlog.memolog.Lines.add('write done channel ='+inttostr(DoneBuf^)+' '+inttostr(nread));
           {$ENDIF}
      end;
    end;                 //while
  end;
   ScanDone;      // ???
   FreeChannels;
 end;
 self.Terminate;
end;

procedure TReadFRomAdapterThread.GetScanData(var n:longint );
var i,k:integer;
   NPAGES:INTEGER;
   pgofs:integer;
   res:integer;
   resbyte:byte;
begin
 NPAGES:=n;
 for k := 0 to npages - 1 do
 begin
     pgofs:= k*64;
     resbyte:=PByteArray(databuf)[pgofs+1];
     if resbyte=-1 then  res:=-1
                   else  res:=PIntegerArray(databuf)[pgofs+1];   // type of page
                  case res of
                   -1:  flgAdapterEmpty:=True;
   AdaptPgType_header:begin
                             flgAdapterEmpty:=false;
                             GetHeader(pgofs,PAdapterHead); //test adapterisnotfilled
                             flgUnit:=(PAdapterHead^.aflgUnit);
                             if flgUnit=Unknown then flgUnit:=nano;
                             flgGetHeader:=true;
                            end;
  AdaptPgType_params:begin
                                case PIntegerarray(databuf)[pgofs] of   //pagenumber
                             1:begin
                                GetParams(pgofs,ScannerOptModX,PAdapterOptModX);
                                flgGetScannerOptModeX:=true;
                               end;
                             4: begin
                                 GetParams(pgofs,ScannerOptModY,PAdapterOptModY);
                                 flgGetScannerOptModeY:=true;
                                end;
                              end;
                            end;
  AdaptPgType_curve:begin
                               case PIntegerarray(databuf)[pgofs] of  ////pagenumber
                             2:begin
                                GetCurve(pgofs,PadapterLinModXAxisX);
                                flgGetLinModXAxisX:=true;
                               end;
                             3:begin
                                GetCurve(pgofs,PadapterLinModXAxisY);
                                flgGetLinModXAxisY:=true;
                               end;
                             5:begin
                                GetCurve(pgofs,PadapterLinModYAxisX);
                                flgGetLinModYAxisX:=true;
                               end;
                             6:begin
                                GetCurve(pgofs,PadapterLinModYAxisY);
                                flgGetLinModYAxisY:=true;
                               end;
                                   end;
                          end;
        else      flgAdapterEmpty:=True;
     end;
 end;
   flgAllDataReadFromAdapter:=flgGetHeader and flgGetScannerOptModeX and flgGetScannerOptModeY and
                              flgGetLinModXAxisX and flgGetLinModXAxisY and flgGetLinModYAxisX
                              and flgGetLinModYAxisY;

end;
end.
