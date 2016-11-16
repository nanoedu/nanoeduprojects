unit frChooseUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, siComp, siLngLnk, jpeg;

type
  TFChooseUnit = class(TForm)
    siLang1: TsiLang;
    siLangDispatcher1: TsiLangDispatcher;
    Panetop: TPanel;
    Panelbottom: TPanel;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    ImageNanoEdu: TImage;
    Panel6: TPanel;
    ImageBaby: TImage;
    Panel3: TPanel;
    Panel7: TPanel;
    ImageTerra: TImage;
    Panel8: TPanel;
    ImageSEM: TImage;
    ImagePipette: TImage;
    procedure ImageSEMClick(Sender: TObject);
    procedure ImagePipetteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImageNanoEduClick(Sender: TObject);
    procedure ImageBabyClick(Sender: TObject);
    procedure ImageTerraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FChooseUnit: TFChooseUnit;

implementation

{$R *.dfm}
 uses strUtils,CSPMVAR;//,globalvar,Mmain;

procedure TFChooseUnit.FormCreate(Sender: TObject);
function WhichLanguage:string;
var
  ID: LangID;
  Language: array [0..100] of char;
begin
  ID := GetSystemDefaultLangID;
  VerLanguageName(ID, Language, 100);
  Result := string(Language);
end;
var  sLanguage,deflang:string;
begin
    deflang:=WhichLanguage;
 if  ( AnsiContainsStr(deflang,'Russian'))  or ( AnsiContainsStr(deflang,'Русский')) then   sLanguage:='RUS';
   if  sLanguage='RUS' then  siLang1.ActiveLanguage:=2
                       else  siLang1.ActiveLanguage:=1;
//    flgTerra:=false;
    panel3.Color:=clSilver;
    panel2.Color:=clSilver;
    panel5.Color:=clBlue;
    panel6.Color:=clsilver;
    panel3.Color:=clSilver;
end;
procedure TFChooseUnit.ImageNanoEduClick(Sender: TObject);
begin
     flgUnit:=nano;
     panel5.Color:=clBlue;
     panel3.Color:=clsilver;
     panel6.Color:=clsilver;
     Application.ProcessMessages;
     modalresult:=idCancel;
end;

procedure TFChooseUnit.ImagePipetteClick(Sender: TObject);
begin
    flgUnit:=pipette;
    panel3.Color:=clBlue;
    panel2.Color:=clSilver;
    panel5.Color:=clsilver;
    panel6.Color:=clsilver;
    panel7.Color:=clSilver;
    application.ProcessMessages;
    sleep(1000);
    modalresult:=idOK;
end;

procedure TFChooseUnit.ImageSEMClick(Sender: TObject);
begin
    flgUnit:=ProBeam;
    panel3.Color:=clSilver;
    panel3.Color:=clBlue;
    panel2.Color:=clSilver;
    panel5.Color:=clsilver;
    panel6.Color:=clsilver;
    application.ProcessMessages;
    sleep(1000);
    modalresult:=idOK;
end;

procedure TFChooseUnit.ImageTerraClick(Sender: TObject);
begin
    flgUnit:=Terra;
    panel3.Color:=clSilver;
    panel6.Color:=clSilver;
    panel7.Color:=clBlue;
    panel2.Color:=clSilver;
    panel5.Color:=clSilver;
    application.ProcessMessages;
    sleep(1000);
    modalresult:=idOK;
end;

procedure TFChooseUnit.ImageBabyClick(Sender: TObject);
begin
    flgUnit:=baby;
    panel3.Color:=clSilver;
    panel7.Color:=clSilver;
    panel6.Color:=clBlue;
    panel2.Color:=clSilver;
    panel5.Color:=clSilver;
    application.ProcessMessages;
    sleep(1000);
    modalresult:=idOK;
end;

end.
