unit SPMFormat;
//270905
//spm data includes:
//Main record - structure of the file
//Header record  - parameters of the experiment
//and one Scan Data :Topo Data + Add Data( phase , current , and ...) if it need

interface

uses SysUtils,Dialogs, Windows,classes;

const Identif =    '(C) STM Data File System ';

//Type topo
Const  Topography=0;
//type add data
Const  WorkF=1;     //not used
Const  BackPass=2;  //not used
Const  Phase=3;
Const  UAM=4;   //Force Image
Const  Spectr=5;
Const  Litho=6;
Const  CurrentSTM=7;
Const  FastScan=8;     //current
Const  FastScanPhase=10;
Const  OneLineScan=11;
Const  SensivityCorrection=12; //ont used
Const  TopoError=9;     //not used
//Scan Path Type
Const  Multi=2;  //multi Path     //not used now
Const  OneY=1;  //Y+
Const  One=0;   //X+
Const  NMax=1024; //Max point number in Frame

 type datatype=smallint;

 type TScanData=array of array of datatype;

 type MainFileRec = record
               Ident : string[29];
               Version : word;
               Flags   : word;    //true -if SPM file have been  modified
               NumRec  : word;
               {--- Record for Header ---}
               bdata : byte; bhead : byte;
               headsize : word;
               HeadOfs  : longint;          //ofset header data
               {--- Record for Topo ---}
               NyTop : datatype;
               NxTop : datatype;
               TopoOfs : longint;       //ofset topo data
               {--- Record for ADDSURF ---}
               NyAdd  : datatype;
               NxAdd  : datatype;
               AddOfs : longint;        //ofset add data
//not used now
               {--- Record for Spec Points ---}
               NyPoint : datatype;         //NUmber POints Spectr
               NxPoint : datatype;        //=0
               PointOfs: longint;        // x,y for spectr word
               {--- Record for Spectr ---}
               NySpec  : datatype;       //=0
               NxSpec  : datatype; //number point for one graf
               SpecOfs : longint;
               {--- Record for CVC ---}
               NyCVC  : datatype;
               NxCVC  : datatype;
               CVCOfs : longint;
               {-----------------------}
                   end;

  type HeadParmType = record
       HYear, HMonth,  HDay,
       HHour, HMinute, HSecond : word;
       HMaterial    : string[20];
       HScannerName : string[20];  // scanner number
       HTemperature : byte;       // not filled
       HFlagLinear  : boolean;    // flag linearization
      {----------- Data types ------------------}
       HAquiTopo     : boolean;   //false for only AquiAdd Data  !!!
       HAquiADD      : byte;      //1-workF; 2-BackPass;3 -phase ; 4-UAM;  5-Spectr;
                                  //7-CurrentSTM; 8-FastScan; 10-FastScanPhase; 11-ScannerTraining;

       HAquiSpectr   : boolean;
       HAquiCVC      : boolean;
       HNxTopo,
       HNyTopo       : datatype;    {Rectangular Rastr}
       HNumSpLines   : datatype;    { Number of Spectra or CVC lines }
       HNumSpPoints  : datatype;    { Number of points in one line }
      {------------- Scan Parameters -------------}
       HStepXY       : single;    { X, Y  Step, Angstrom }
       HScanRate     : single;    {nm/s}           //HTimeScanPoint : single;
       HScanVoltage  : single;    {mV}
       HScanCurrent  : single;    { nA }
      {------------- Scaner regimes ---------}
       HProbeType    : byte;     {STM, SFM}
       HAMP_GainZ    : single;   {value AMP_GAINZ  =AMP_GainRZ or AMP_GainFZ depend on Z_Tune}
       HXBegin       : single;   {nm}        //HScanRange    : single;
       HYBegin       : single;   {nm}    //HstepXYmVolt  : single;
       HSetPoint     : datatype;       {percents}
       HPathMode     : byte;      {0 -X+; 1- Y+ ; 2-multi ..}
       IReservScan1  : byte;
       IReservScan3  : datatype;  //HIBiasY       : datatype;
       IReservScan2  : byte;
     {----------- HardWare Coefficients -------}
       HSensX, HSensY, HSensZ  : single  ;    { nm/volt} //Sensitivity, Angstrom/mVolt }
       HDiscrZmvolt  : single;         //  Mvolt/Discrete  Z.
       HGainX        : single;
       HGainY        : single;
       HnA_D         : single;     // koeff current nA to discr      : single  ;   151003
       HUv_d16       : single;     //koeff Volt to discr        151003

     {--------------- Work Function Parameters ----------}
       HAmpModulation  : integer;   { SD_GEN_M, discrets }
       HSDGainFM       : word;   { SD_GAIN_FM  }
       HSDGainAM       : word;    {SD_GAIN_AM  }
       HResFreqR       : word;
       HResFreqF       : word;
       HF0             : integer;  {F0, Hz}
       HAmplSuppress   : single; //Ampltude Suppression SFM
     {--------------- Spectroscopy  Parameters -----------}
       HNumberOfStepX  : datatype;    { Number of spectra in X direction }
       HNumberOfStepY  : datatype;    { Number of spectra in Y direction }
       HNumberOfAver   : datatype;    { Number of Averaging }
       HSpVoltageStart,
       HSpVoltageFinal : single;   { Voltage, mV }
       HTimeSpecPoint  : single;   { ms }
       HSpModulation   : single;   { Modulation magnitude, mV }
       HSpDetectorCoef : single;   { Sinhrodetector Coefficient   }
       HResistance     : single;   { Om }
       IReservSpec1,
       IReservSpec2    : datatype;
       ReservSpec3,
       ReservSpec4     : single;
       {---------- Spectroscopy regimes -----------------}
         HTypeCVC          : datatype;
         HTypeSpectr       : datatype;
         HTypeConstCurrent : boolean;
         TypeReserv1,
         TypeReserv2,
         Typereserv3      : boolean;
      {----------- Reserved -----------------------------}
        BReserv1, BReserv2   : boolean;
        IReserv5, IReserv6   : datatype;
        HTimeLine,  Reserv10 : single;
      {             Gain
      {----------- Comments ------------------------------}
        Comm1, Comm2, Comm3, Comm4,
        Comm5, Comm6, Comm7, Comm8 : string[60];
      {---------------------------------------------------}
            end;


    type TData=class(Tobject)
       private
       	function max :datatype;
      	function min :datatype;
      	function mean :single;
      public
        flg:byte;        //type data Topo,Phase or ...
        captionX:string; //axies unit
        captionY:string; //axies unit
        captionZ:string; //axies unit
      	Nx,Ny: integer;
        XStep,YStep,ZStep:single;
        data:TScanData;
        constructor Create;
        destructor Destroy; override;
        property DataMin:datatype read min;
        property DataMax:datatype read max;
        property DataMean:single
        read mean;
    end;{class}

    type TExperiment=class(TObject)
     private
     protected
     public
        Caption:string;
        ImFileName:string;
        WorkFileName:string;    //scan filename
        ArFileNameEdit:TList;        //array edit work files  for undo operation
       	FileHeadRcd:HeadParmType;
        MainRcd:MainFileRec;
        AquiTopo:TData;  //topography
        AquiAdd: TData;  //add data Phase,Uam, and ...
//        AquiSpectr:TData;  //spectroscopy
//        AquiSpectrPoint:TLine;   //points spectroscopy
     constructor Create;
     destructor Destroy; override;
     procedure ReadSurface(flgReadBlock:integer);  {read one data block:  topo or add data }
    end; {class}



procedure ReadHeader(FileName:string;var flg:integer;var head:HeadParmType; var main:MainFileRec);


 implementation



constructor TExperiment.Create;
var Year, Month, Day, Hour, Minut, Sec, MSec: Word;
       Present: TDateTime;
       LRec,LHeader:integer;
begin
  inherited;
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minut, Sec, MSec);
  LRec:=Sizeof(MainFileRec);
  LHeader:=Sizeof(HeadParmType);
 with MainRcd do
  begin
   Ident:=identif;
   Version:=12;   //ver 10 step z =0
   HeadOfs:=LRec;
   TopoOfs:=HeadOfs+LHeader;
               NyTop :=0;
               NxTop :=0;
               NyAdd :=0;// datatype;
               NxAdd :=0;// datatype;
               AddOfs :=0;// longint;
               {--- Record for Spec Points ---}
               NyPoint :=0;// datatype;
               NxPoint :=0;// datatype;
               PointOfs :=0;// longint;
               {--- Record for Spectr ---}
               NySpec :=0;// datatype;
               NxSpec :=0;// datatype;
               SpecOfs :=0;// longint;
               {--- Record for CVC ---}
               NyCVC :=0;// datatype;
               NxCVC :=0;// datatype;
               CVCOfs :=0;// longint;
  end;
  AquiTopo  :=TData.Create;
  AquiAdd   :=TData.Create;
end; {TExperiment.Create}

destructor TExperiment.Destroy;
begin
  AquiTopo.Free;
  AquiAdd.Free;
//  AquiSpectr.Free;
     inherited;
end; {TExperiment.Destroy}

{ TDataLine }

constructor TData.Create;
begin
  inherited;
  flg:=Topography;
  CaptionZ:='';
  NX:=0;
  NY:=0;
  XStep:=0;
  YStep:=0;
end; {TData.Create}

destructor TData.Destroy;
var i:integer;
begin
     NX:=0;
     NY:=0;
     XStep:=0;
     YStep:=0;
     Finalize(data);
     inherited;
end; {TData.Destroy}


procedure ReadHeader(FileName:string;var flg:integer;var head:HeadParmType; var Main:MainFileRec );
var HNDL,HNDL0:integer;
    iBytesRead:integer;
    LRec,LHeader:integer;
    DatBuf:Pword;
    FileHeadRcd:HeadParmType;
    MainRcd:MainFileRec;
 begin
   LRec:=SizeOf(MainFileRec);
 try
     if not FileExists(FileName) then
        begin
           ShowMessage(FileName+' File not exist');
        end;
       HNDL0 := FileOpen(FileName, fmOpenRead);
       FileSeek(HNDL0,0,0);
       iBytesRead := FileRead(HNDL0,MainRcd, LRec);
    if (MainRcd.Ident = Identif) then //icod:=160
      begin
           LHeader:=SizeOf(HeadParmType);
           HNDL:=FileSeek(HNDL0,MainRcd.HeadOfs,0);
           iBytesRead:=FileRead(HNDL0,FileHeadRcd,LHeader);
           case  FileHeadRcd.HAquiADD of
          0:    flg:=Topography;
          1:    flg:=WorkF;
          2:    flg:=BackPass;
          3:    flg:=Phase;
          4:    flg:=UAM;
          5:    flg:=Spectr;
          7:    flg:=CurrentSTM;
          8:    flg:=FastScan;
          10:   flg:=FastScanPhase;
          11:   flg:=OneLineScan;
                end;
       if FileHeadRcd.HAquiSpectr then
        begin
          flg:=Spectr;
        end;
      end;
      head:=FileHeadRCD;
      main:=MainRCD;
       finally
          FileClose(HNDL0);
      end;
 end;

function TData.max : datatype;
var i , j : integer;
    a : datatype;
begin
     if (NX > 0) and (NY > 0) then
     begin
          a:=data[0,0];
          for j:=0 to NY-1 do
          begin
  	       for i:=0 to NX-1 do
               begin
                    if data[i,j] > a then a:= data[i,j];
               end;
          end;
     end
     else a:=0;
     max:=a;
end; {TData.max}

function TData.min: datatype;
var  i, j : integer;
     a : datatype;
begin
     if (NX > 0) and (NY > 0) then
     begin
          a:=data[0,0];
         for j:=0 to NY-1 do
          begin
             for i:=0 to NX-1 do
               begin
                    if data[i,j] < a then a:=data[i,j];
               end;
          end;
     end
     else a:=0;
     min:=a;
end; {TData.min}

function TData.mean : single;
var i , j : integer;
    S : single;
begin
     S:=0.0;
     if (NX > 0) and (NY > 0) then
     begin
         for j:=0 to NY-1 do
          begin
             for i:=0 to NX-1 do
               begin
                    S:=S+data[i,j];
               end;
          end;
          S:=S/NX/NY;
     end;
     mean:=S;
end; {TData.mean}


procedure TExperiment.ReadSurface(flgReadBlock:integer);
 var HNDL,HNDL0:integer;
    iBytesRead:integer;
    i,j:integer;
    GainZ:integer;
    LRec,LHeader:integer;
    DatBuf:Pword;
    Ofs:longint;
    Nx,Ny:integer;
 begin
   LRec:=SizeOf(MainFileRec);
   if not FileExists(ImFileName) then
        begin
           ShowMessage(ImFileName+'SPM Data File not exist');
           exit;
        end;
   try
       HNDL0 := FileOpen(ImFileName, fmOpenRead);
       FileSeek(HNDL0,0,0);
       iBytesRead := FileRead(HNDL0,MainRcd, LRec);
 if (MainRcd.Ident = Identif) then
  begin
           LHeader:=SizeOf(HeadParmType);
           HNDL:=FileSeek(HNDL0,MainRcd.HeadOfs,0);
           iBytesRead:=FileRead(HNDL0,FileHeadRcd,LHeader);
                                case FlgReadBlock  of
             TopoGraphy,OneLineScan:  Ofs:=MainRcd.TopoOfs;    //ofset topo data
          Phase,BackPass,WorkF,UAM,
  CurrentSTM,FastScan,FastScanPhase:  Ofs:=MainRcd.Addofs;    //ofset add data
                                       end;

                       case FlgReadBlock  of
   TopoGraphy,
   OneLineScan,
   Litho          : begin
                    if (iBytesRead<>-1) then
                     begin
                           AquiTopo.Nx:=MainRcd.NxTop;
                           AquiTopo.Ny:=MainRcd.NyTop;
                           Nx:=AquiTopo.Nx;
                           Ny:=AquiTopo.Ny;
                           if (NX>1024) or (Ny>1024) then
                               begin   MessageDlg('OUT range >1024',mtWarning,[mbOk],0); exit end;
                           AquiTopo.XStep:=FileHeadRcd.HStepXY;
                           AquiTopo.YStep:=FileHeadRcd.HStepXY;
                           AquiTopo.CaptionZ:='nm';
                    if  FlgReadBlock=OneLineScan then
                      begin
                             case  FileHeadRcd.HPathMode of
                     One: begin
                            AquiTopo.YStep:=2*NX*AquiTopo.XStep/FileHeadRcd.HScanRate;
                            AquiTopo.CaptionX:='nm';
                            AquiTopo.CaptionY:='N';
                           end;
                    OneY: begin
                            AquiTopo.XStep:=2*NY*AquiTopo.YStep/FileHeadRcd.HScanRate;
                            AquiTopo.CaptionX:='N';
                            AquiTopo.CaptionY:='nm';
                          end;
                               end;
                      end;
                      if  MainRcd.Version>=11 then
                          begin
                             if MainRCD.Version>=12 then
                                                AquiTopo.ZStep:=0.001*
                                                FileHeadRcd.HSensZ*      //
                                                FileHeadRcd.HAMP_GainZ*  //
                                                FileHeadRcd.HDiscrZmvolt; //mvolt/discr0
                           end
                      else AquiTopo.ZStep:=1 ;
                        if AquiTopo.ZStep=0 then AquiTopo.ZStep:=1;
                            HNDL:=FileSeek(HNDL0,Ofs,0);
                           try
                              SetLength(AquiTopo.Data,Nx,Ny);
                           except
                              on EOutOfMemory        do
                                  MessageDlg('OUT memory TopoSPM',mtWarning,[mbOk],0);
                           end;
                           try
                               GetMem(DatBuf,Nx*Ny*sizeof(DataType));
                           except
                               on EOutOfMemory        do
                               MessageDlg('OUT memory ',mtWarning,[mbOk],0);
                           end;
                            iBytesRead:=FileRead(HNDL0,DatBuf^,sizeof(DataType)*Nx*Ny);
                           if (iBytesRead<>-1) then
                               begin
                                for j:=0 to Ny-1 do
                                  for i:=0 to Nx-1 do
                                   begin
                                       AquiTopo.Data[i,j]:=datatype(PWordArray(DatBuf)[j*Nx+i]);          //
                                   end;
                               end;
                     end;  //if
                end; //topo
  BackPass,Phase,
  WorkF,
  UAM,CurrentSTM,
  FastScan,
  FastScanPhase: begin
                    if (iBytesRead<>-1) then
                     begin
                            Nx:=MainRcd.NxAdd;
                            Ny:=MainRcd.NyAdd;
                            AquiAdd.Nx:=Nx;
                            AquiAdd.Ny:=Ny;
                            if (NX>1024) or (Ny>1024) then
                                begin   MessageDlg('OUT range >1024',mtWarning,[mbOk],0);exit end;
                            AquiAdd.XStep:=FileHeadRcd.HStepXY;
                            AquiAdd.YStep:=FileHeadRcd.HStepXY;
                              case  FlgReadBlock of       //1 -phase ; 2-UAM
          BackPass:     begin
                          if   MainRcd.Version>=11 then
                           begin
                              AquiAdd.ZStep:=0.001*FileHeadRcd.HSensZ*  //
                                               FileHeadRcd.HAMP_GainZ*   //
                                               FileHeadRcd.HDiscrZmvolt //mvolt/discr
                           end
                              else AquiAdd.ZStep:=1 ;
                             if AquiAdd.ZStep=0 then AquiAdd.ZStep:=1;
                        end;            //backpass
          Phase,
          FastScanPhase:begin
                         AquiAdd.ZStep:=1;
                         AquiAdd.CaptionZ:='a.u.';
                         AquiAdd.CaptionX:='nm';
                         AquiAdd.CaptionY:='nm';
                        end;
          UAM:          begin
                         AquiAdd.ZStep:=1/FileHeadRcd.HUv_d16;
                         AquiAdd.CaptionZ:='V';
                         AquiAdd.CaptionX:='nm';
                         AquiAdd.CaptionY:='nm';

                        end;
          WorkF:         ;
          CurrentSTM,
          FastScan:     begin
                          AquiAdd.ZStep:=1/FileHeadRcd.HnA_d;
                          AquiAdd.CaptionZ:='nA';
                          AquiAdd.CaptionX:='nm';
                          AquiAdd.CaptionY:='nm';
                        end;
                            end;  //case

                            HNDL:=FileSeek(HNDL0,Ofs,0);
                           try
                              SetLength(AquiAdd.Data,Nx,Ny);
                           except
                              on EOutOfMemory        do
                                  MessageDlg('OUT memory TopoSPM',mtWarning,[mbOk],0);
                           end;
                           try
                               GetMem(DatBuf,Nx*Ny*sizeof(DataType));
                           except
                               on EOutOfMemory        do
                               MessageDlg('OUT memory 1',mtWarning,[mbOk],0);
                           end;
                           iBytesRead:=FileRead(HNDL0,DatBuf^,sizeof(DataType)*Nx*Ny);
                           if (iBytesRead<>-1) then
                               begin
                                for j:=0 to Ny-1 do
                                   for i:=0 to Nx-1 do
                                     AquiAdd.Data[i,j]:=datatype(PWordArray(DatBuf)[j*Nx+i]);          //
                               end;
                   end;
                end;
   (*   Spectr:  begin
                   Setlength(AquiSpectr.Data,MainRcd.NyPoint,MainRcd.NxSpec );
                   SetLength(AquiSpectrPoint,2*MainRcd.NyPoint);
                   GetMem(datBuf,2*sizeof(word)*MainRcd.NyPoint);
                   HNDL:=FileSeek(HNDL0,MainRcd.Pointofs,0);
                   iBytesRead:=FileRead(HNDL0,DatBuf^,2*sizeof(word)*MainRcd.NyPoint);
                 for   i:=0 to  2*MainRcd.NyPoint-1 do
                  begin
                   AQuiSpectrPoint[i]:=PWordArray(DatBuf)[i];  //nm
                  end;
                    HNDL:=FileSeek(HNDL0,MainRcd.Specofs,0);
                    FreeMem(DatBuf);
                  try
                   GetMem(DatBuf,MainRcd.NxSpec*MainRcd.NyPoint*sizeof(word));
                  except
                      on EOutOfMemory  do
                         MessageDlg('OUT memory ',mtWarning,[mbOk],0);
                  end;
                  iBytesRead:=FileRead(HNDL0,DatBuf^,sizeof(word)*MainRcd.NyPoint*MainRcd.NxSpec);
                      if (iBytesRead<>-1) then
                         begin
                            for j:=0 to MainRcd.NyPoint-1 do
                              for i:=0 to MainRcd.NxSpec-1 do
                               AquiSpectr.Data[j,i]:=PWordArray(DatBuf)[j*MainRcd.NxSpec+i];
                         end;
                   end;//spectr
       *)
             end; //case
        end;    //if indentif
    finally
          FileClose(HNDL0);
          FreeMem(DatBuf);
    end;
 end;


end.
