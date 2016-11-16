unit uFileOp;

interface
 uses classes,sysutils;
 procedure FileCopyStream(const src,target:string);

implementation

uses globalvar;

procedure FileCopyStream(const src,target:string);
 var streamscr,streamtrg,streamtemp:TFileStream;
     tempfile:string;
     targetpath:string;
begin
  tempfile:=TempDirectory+'stream.tmp';
if FileExists(src)  then
begin
try
  Streamscr:=TFileStream.Create(Src,fmOpenRead);
 try Streamtemp:=TFileStream.Create(tempfile,fmCreate);
   StreamTemp.CopyFrom(StreamScr,StreamScr.Size);
 finally
    FreeAndNil(Streamtemp);
 end;
 finally
    FreeAndNil(StreamScr);
 end;
// targetpath:=  ExtractFileDir(Target);
// if not DirectoryExists(targetpath) then   CreateDir(targetpath);
 try
   Streamtemp:=TFileStream.Create(tempfile,fmOpenRead);
  try
     StreamTrg:=TFileStream.Create(Target, fmCreate);
     StreamTrg.CopyFrom(Streamtemp,Streamtemp.Size);
   finally
     FreeAndNil(StreamTrg);
  end
  finally
   FreeAndNil(Streamtemp);
   deletefile(tempfile);
  end;
end;
end;
end.
