unit frViewConfigFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, siComp, siLngLnk;

type
  TViewConfigFile = class(TForm)
    Panel1: TPanel;
    MemoFileConfig: TMemo;
    siLangLinked1: TsiLangLinked;
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
 private
    { Private declarations }
  public
    { Public declarations }
    constructor    Create(AOwner: TComponent; Filename: string);
  end;

var
  ViewConfigFile: TViewConfigFile;

implementation

{$R *.dfm}
uses    inifiles,GlobalVar,mMain;
const
	strvc1: string = ''; (* No Config  Ini File  *)
	strvc2: string = ''; (* . Program will be terminated!! *)

procedure TViewConfigFile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
 ViewConfigFile:=nil;
end;


constructor TViewConfigFile.Create(AOwner:TComponent; filename:string);
 var
      i,j:integer;
  iniCSPM:TiniFile;
    sFile:string;
      str:string;
     ListBoxSections,ListBoxSection:TListBox;
begin
 inherited Create(AOwner);
  silanglinked1.activelanguage:=lang;
  caption:=filename;
  UpdateStrings;
  sFile:=Filename;//ConfigIniFilePath+ ConfigIniFile;
 if (not FileExists(sFile)) then
  begin
   silanglinked1.ShowMessage(strvc1{No Config  Ini File '}+SFile+strvc2{'. Program will be terminated!!'});
   Application.Terminate;
  end;
   with iniCSPM do
  begin
      MemoFileConfig.Lines.LoadFromFile(sFile);
  end;
end;

procedure TViewConfigFile.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TViewConfigFile.UpdateStrings;
begin
  strvc2 := siLangLinked1.GetTextOrDefault('strstrvc2');
  strvc1 := siLangLinked1.GetTextOrDefault('strstrvc1');
end;

end.

