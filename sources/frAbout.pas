unit frAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, siComp, siLngLnk;

type
  TFormAbout = class(TForm)
    Memo: TMemo;
    siLangLinked1: TsiLangLinked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses    GlobalVar,mMain;
{$R *.DFM}
type
  TLangInfoBuffer = array [1..4] of SmallInt;

procedure TFormAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := caFree;
end;

procedure TFormAbout.FormCreate(Sender: TObject);
var
  VInfoSize, DetSize: DWord;
  pVInfo, pDetail: Pointer;
begin

 siLangLinked1.ActiveLanguage:=Lang;
  if  Lang=1 then//eng
  begin
   Memo.Lines.Clear;
   if fileexists(ExeFilePath+'Data\Eng\AboutEng.txt') then Memo.Lines.LoadFromFile(ExeFilePath+'Data\Eng\AboutEng.txt');
  end
  else
   begin
   Memo.Lines.Clear;
  if fileexists(ExeFilePath+'Data\Rus\About.txt') then  Memo.Lines.LoadFromFile(ExeFilePath+'Data\Rus\About.txt');
  end;
  Caption:=ProgramName;
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
     {    Memo1.Lines.Add (
           'Signature (should be invariably 0xFEEFO4BD): ' +
           IntToHex (dwSignature, 8));
     }
         Memo.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_5' (* 'Program: Major version number: ' *) ) +
           IntToStr (HiWord (dwFileVersionMS))+siLangLinked1.GetTextOrDefault('IDS_6' (* '; Minor version number: ' *) ) +
           IntToStr (LoWord (dwFileVersionMS)));
        { Memo1.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_7' (* 'Minor version number: ' *) ) +
           IntToStr (LoWord (dwFileVersionMS)));
         }
         Memo.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_8' (* 'Release version number: ' *) ) +
           IntToStr (HiWord (dwFileVersionLS))+siLangLinked1.GetTextOrDefault('IDS_9' (* '; Build version number: ' *) ) +
           IntToStr (LoWord (dwFileVersionLS)));
       {  Memo1.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_10' (* 'Build version number: ' *) ) +
           IntToStr (LoWord (dwFileVersionLS)));
       }
        //   Memo1.Lines.Add ('Release version number: ' +


         if (dwFileFlagsMask and dwFileFlags
             and VS_FF_DEBUG) <> 0 then
           Memo.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_11' (* 'Debug info included' *) ));
         if (dwFileFlagsMask and dwFileFlags and
             VS_FF_PRERELEASE) <> 0 then
           Memo.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_12' (* 'Pre-release (beta) version' *) ));
         if (dwFileFlagsMask and dwFileFlags and
             VS_FF_PRIVATEBUILD) <> 0 then
           Memo.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_13' (* 'Private Build' *) ));
         if (dwFileFlagsMask and dwFileFlags and
             VS_FF_SPECIALBUILD) <> 0 then
           Memo.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_14' (* 'Special Build' *) ));
       end;
  (*
       // get the first language
       VerQueryValue(pVInfo,
         siLangLinked1.GetTextOrDefault('IDS_15' (* '\VarFileInfo\Translation' Ú ),
         Pointer(pLangInfo), DetSize);
       strLangId := IntToHex (SmallInt (pLangInfo^ [1]), 4) +
           IntToHex (SmallInt (pLangInfo^ [2]), 4);
       Memo1.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_16' (* 'Language: ' *} ) + strLangId);

       // show some of the strings
       strLangId := siLangLinked1.GetTextOrDefault('IDS_17' (* '\StringFileInfo\' } ) + strLangId;
       VerQueryValue(pVInfo, PChar(strLangId + siLangLinked1.GetTextOrDefault('IDS_18' (* '\FileDescription' } )),
         pDetail, DetSize);
       Memo1.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_19' (* 'File Description: ' } ) +
         PChar (pDetail));
       VerQueryValue(pVInfo, PChar(strLangId + siLangLinked1.GetTextOrDefault('IDS_20' (* '\FileVersion' } )),
         pDetail, DetSize);
       Memo1.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_21' (* 'File Version: ' } ) + PChar (pDetail));
       VerQueryValue(pVInfo, PChar(strLangId + siLangLinked1.GetTextOrDefault('IDS_22' (* '\InternalName' } )),
         pDetail, DetSize);
       Memo1.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_23' (* 'Internal Name: ' } ) + PChar (pDetail));
       VerQueryValue(pVInfo, PChar(strLangId + siLangLinked1.GetTextOrDefault('IDS_24' (* '\LegalCopyright' } )),
         pDetail, DetSize);
       Memo1.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_25' (* 'Legal Copyright: '}) ) + PChar (pDetail));
       VerQueryValue(pVInfo, PChar(strLangId + siLangLinked1.GetTextOrDefault('IDS_26' (* '\ProductDescription' } )),
         pDetail, DetSize);
       Memo1.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_27' { 'Product Name: ' } ) + PChar (pDetail));
       VerQueryValue(pVInfo, PChar(strLangId + siLangLinked1.GetTextOrDefault('IDS_28' { '\ProductVersion' } )),
         pDetail, DetSize);
       Memo1.Lines.Add (siLangLinked1.GetTextOrDefault('IDS_29' { 'Product Version: ' } ) + PChar (pDetail));
  *)
    finally
      FreeMem (pVInfo);
    end;
  end;
 end;

end.
