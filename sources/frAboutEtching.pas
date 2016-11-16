unit frAboutEtching;

interface

uses
  Windows, SysUtils, Classes, Forms, Controls, StdCtrls;

type
  TFormAboutEtch = class(TForm)
    Memo: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAboutEtch: TFormAboutEtch;

implementation

{$R *.dfm}
uses  EtchingVar;

procedure TFormAboutEtch.FormCreate(Sender: TObject);
var
  VInfoSize, DetSize: DWord;
  pVInfo, pDetail: Pointer;
begin
  if  sLanguage<>'RUS' then
  begin
   Memo.Lines.Clear;
   if fileexists(EtchingIniFilePath+'Data\Eng\AboutEtchEng.txt') then Memo.Lines.LoadFromFile(EtchingIniFilePath+'Data\Eng\AboutEng.txt');
  end
  else
   begin
   Memo.Lines.Clear;
  if fileexists(EtchingIniFilePath+'Data\Rus\AboutEtch.txt') then  Memo.Lines.LoadFromFile(EtchingIniFilePath+'Data\Rus\About.txt');
  end;
  VInfoSize := GetFileVersionInfoSize (
    PChar (ParamStr (0)), DetSize);
  if VInfoSize > 0 then
  begin
    GetMem (pVInfo, VInfoSize);
    try
       GetFileVersionInfo (PChar (ParamStr (0)), 0,
         VInfoSize, pVInfo);
       // show the fixed information
       VerQueryValue (pVInfo, '\', pDetail, DetSize);
       with TVSFixedFileInfo (pDetail^) do
       begin
         Memo.Lines.Add ('Program: Major version number: ' +
           IntToStr (HiWord (dwFileVersionMS))+'; Minor version number: ' +
           IntToStr (LoWord (dwFileVersionMS)));
         Memo.Lines.Add ('Release version number: ' +
           IntToStr (HiWord (dwFileVersionLS))+'; Build version number: ' +
           IntToStr (LoWord (dwFileVersionLS)));
         if (dwFileFlagsMask and dwFileFlags
             and VS_FF_DEBUG) <> 0 then
           Memo.Lines.Add ('Debug info included');
         if (dwFileFlagsMask and dwFileFlags and
             VS_FF_PRERELEASE) <> 0 then
           Memo.Lines.Add ('Pre-release (beta) version');
         if (dwFileFlagsMask and dwFileFlags and
             VS_FF_PRIVATEBUILD) <> 0 then
           Memo.Lines.Add ('Private Build');
         if (dwFileFlagsMask and dwFileFlags and
             VS_FF_SPECIALBUILD) <> 0 then
           Memo.Lines.Add ('Special Build');
       end;
     finally
      FreeMem (pVInfo);
    end;
  end;
end;

end.
