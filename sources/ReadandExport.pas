unit ReadandExport;

interface
uses  GlobalType,Globalvar,CSpmvar,GlobalDCl,MDTFileExport,Classes,sysutils,basetypes;

 type
  smar=array[0..16383] of smallint;
  Psmallarray=^smar;

  Procedure  SaveAsMDT(const inFileName, FileName:string);

implementation

 Procedure  SaveAsMDT(const inFileName,FileName:string);
var
  i,j,n,k,flgGlReadBlock:integer;
  dt : Pointer;
  FP, BP :PData;
  bFp,bBp:PData;
  MDTFile:MDFileExport;
  srt : TFileStream;
  DemoExperiment:TExperiment;
  bPoint : Pint16;
  mainrc:MainFileRec ;
  head:HeadParmType ;
begin
  DemoExperiment:=TExperiment.Create;
try
  DemoExperiment.imFileName:=inFileName;
 if ReadHeader(inFileName,flgGlReadBlock,head,mainrc)>0 then exit;
  MDTFile := MDFileExport.Create;
 if Head.HNxTopo>0 then
 begin
   DemoExperiment.Readsurface(Topography);
   GetMem(dt,DemoExperiment.AquiTopo.NX*DemoExperiment.AquiTopo.Ny*sizeof(Apitype));
   bPoint := dt;
   try
    with MDTFile do
    begin
      DemoExperiment.Readsurface(Topography);
      x0 :=DemoExperiment.FileHeadRcd.HXBegin;
      xr :=DemoExperiment.FileHeadRcd.HStepXY ;
      y0 :=DemoExperiment.FileHeadRcd.HYBegin;
      yr :=DemoExperiment.FileHeadRcd.HStepXY;
      z0 := 0;
      zr :=DemoExperiment.AquiTopo.ZStep;
      Name:=DemoExperiment.AquiTopo.Caption;
      XUnit:=-1;    YUnit:=-1;       ZUnit:=-1;
     for I := 0 to DemoExperiment.AquiTopo.NY - 1 do
      for j := 0 to DemoExperiment.AquiTopo.NX - 1 do
      begin
          bPoint^ :=  DemoExperiment.AquiTopo.data[j][i];
          Inc(bPoint);
      end;
      AddScan(DemoExperiment.AquiTopo.NX,DemoExperiment.AquiTopo.NY,dt);
    end;
   finally
    FreeMem(dt);
    dt:=nil;
   end;
  end;
  if Head.HAquiADD <>0 then
  begin
     DemoExperiment.Readsurface(Head.HAquiADD);
     GetMem(dt,DemoExperiment.AquiAdd.NX*DemoExperiment.AquiAdd.Ny*sizeof(Apitype));
     bPoint := dt;
   try
    with MDTFile do
    begin
      x0 :=DemoExperiment.FileHeadRcd.HXBegin;
      xr :=DemoExperiment.FileHeadRcd.HStepXY;
      y0 :=DemoExperiment.FileHeadRcd.HYBegin;
      yr :=DemoExperiment.FileHeadRcd.HStepXY;
      z0 := 0;
      zr:=DemoExperiment.AquiAdd.ZStep;
      Name:=DemoExperiment.AquiAdd.Caption;
     for I := 0 to DemoExperiment.AquiAdd.NY - 1 do
      for j := 0 to DemoExperiment.AquiAdd.NX - 1 do
      begin
          bPoint^ :=  DemoExperiment.AquiAdd.data[j][i];
          Inc(bPoint);
      end;
       AddScan(DemoExperiment.AquiAdd.NX,DemoExperiment.AquiAdd.NY,dt);
    end;
   finally
      FreeMem(dt);
      dt:=nil;
   end;
  end;
 if Head.HAquiSpectr then
 begin
   DemoExperiment.Readsurface(spectr);
 for i:=0 to DemoExperiment.MainRcd.NyPoint-1 do
 begin
       if DemoExperiment.FileHeadRcd.HTypeSpectr=1 then
                                          begin
                                            MDTFile.yr:=1/DemoExperiment.FileHeadRcd.HnA_d;
                                            MDTFile.YUnit:=23;
                                          end
                                          else
                                          begin
                                           MDTFile.yr:=1/DemoExperiment.FileHeadRcd.HUAMMax;
                                           MDTFile.YUnit:=3;
                                          end;

   MDTFile.XUnit:=-1;         MDTFile.ZUnit:=-1;

   MDTFile.x0:=0.001* DemoExperiment.FileHeadRcd.HSensZ*
                      DemoExperiment.FileHeadRcd.HAMP_GainZ*
                      DemoExperiment.FileHeadRcd.HDiscrZmvolt
                      *DemoExperiment.AquiSpectr.Data[i,1];
   MDTFile.xr:=0.001* DemoExperiment.FileHeadRcd.HSensZ*
                      DemoExperiment.FileHeadRcd.HAMP_GainZ*
                      DemoExperiment.FileHeadRcd.HDiscrZmvolt*
                      (DemoExperiment.AquiSpectr.Data[i,3]-DemoExperiment.AquiSpectr.Data[i,1]);

   MDTFile.y0:=0;
   MDTFile.z0:=100;
   MDTFile.zr:=1;
   MDTFile.Name:= DemoExperiment.Caption;
   MDTFile.AddSpectroscopy;
   fp:=nil;
   bp:=nil;
    with MDTFile do
    begin
      x0 :=DemoExperiment.AquiSpectrPoint[i]/DemoExperiment.FileHeadRcd.HXnm_d;
      y0 :=DemoExperiment.AquiSpectrPoint[i+1]/DemoExperiment.FileHeadRcd.HXnm_d;
      z0 := 0;
    end;
   n:=DemoExperiment.MainRcd.NxSpec div 4;
   GetMem(FP,n*sizeof(smallint));
   GetMem(BP,n*sizeof(smallint));
 try
   bFp:=FP;
   bBp:=BP;
   j:=0;
    for k:=0 to n-1 do
       begin
          bFP^:=DemoExperiment.AquiSpectr.Data[i,j];
          inc(bFP);
          j:=j+2;
        end;
        j:=4*n-2;
    for k:=0 to n-1 do
        begin
         bBP^:=DemoExperiment.AquiSpectr.Data[i,j];
         inc(bBP);
          j:=j-2;
        end;
   MDTFile.AddSpectroPoint( MDTFile.x0,MDTFile.y0,n,n,FP,BP);
 finally
    Freemem(BP);
    Freemem(FP);
 end;
end; //i
    Bp:=nil;
    FP:=nil;
 end;    //spectr

  srt:= TFileStream.Create(FileName,fmCreate);
  MDTFile.WriteToStream(srt);
  srt.Free;
  FreeAndNil(MDTFile);
finally
  FreeAndNil(DemoExperiment);
end;
end;


end.
