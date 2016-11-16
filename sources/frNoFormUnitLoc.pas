unit frNoFormUnitLoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, siComp, siLngLnk;

type
  TNoFormUnitLoc = class(TForm)
    siLang1: TsiLang;
    siLangDispatcher1: TsiLangDispatcher;
    procedure siLang1ChangeLanguage(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
Const
//  common
	strcom: string = ''; (* File not exist *)
	strcom1: string = ''; (* out of range: > *)
	strcom2: string = ''; (* OUT memory TopoSPM *)
	strcom3: string = ''; (*  Error!  *)
	strcom5: string = ''; (* No Config Ini File  *)
	strcom6: string = ''; (* . Default Ini File Used!! *)
	strcom7: string = ''; (* No Default Config Ini File *)
	strcom8: string = ''; (* No Controller Ini File *)
	strcom9: string = ''; (* No Default Controller Ini File *)
	strcom10: string = ''; (* . Program Terminated!! *)
	strcom11: string = ''; (* New Electronic *)
	strcom12: string = ''; (* detected !!!. Default data used *)
	strcom13: string = ''; (* Error file! *)
	strcom14: string = ''; (*  More one scanner in the file  *)
	strcom15: string = ''; (* error write flash *)
	strcom16: string = ''; (* Scanner  *)
	strcom17: string = ''; (*  doesn't exist. Manual regime is set! *)
	strcom18: string = ''; (* Don't forget to choose scanner needed!! *)
  
  strglf0: string = ''; (* SPM Files Explorer *)
	s4: string = ''; (* No Config Ini File. Program Terminated!!  *)
	s5: string = ''; (* Flash Drive is not connected! Continue work without Flash Drive?  *)
	s6: string = ''; (* Work without Flash Drive. Scanner Autodetecting mode is set!  *)
	s7: string = ''; (* If number of the scanner and the controller do not coincide, do not forget to set a manual mode *)


//unit UNanoEduBaseClasses;
	strub0: string = ''; (* Unable to execute function start() *)
	strub1: string = ''; (* Unable to register buffers! Reload Controller. *)
	strub2: string = ''; (* Error in ScanInit() *)
	strub3: string = ''; (* Error during ScanWork() execution *)
	strubm4: string = ''; (* Error in ScanDone() *)
	strub4: string = ''; (* Error!! Load Script  *)
	strub5: string = ''; (* Script don't exists! *)
//axes
 (*sa1='nm';
 s   TopoUnitsmcnXY.text:=#181+'m';
    TopoUnitsmcnZ.text:=#181+'m';
    PhaseUnits.text:='a.u';
    ForceUnits.text:='mV';
    CurrentUnits.text:='nA';
 *)
//unit uNanoEduDemoClasses;
	strud3: string = ''; (* File is not Demo! *)
	strud2: string = ''; (* Open ERROR! *)
	strud1: string = ''; (* No demo data! *)
	strud0: string = ''; (* Adjust Phase  Zero Point *)
// unit uNanoEduScanClasses;
	strus0: string = ''; (* Out memory for Scan data *)
//drawlitho
	strl: string = ''; (* ScDraw fail *)
// uScannerCorrect;
  strusc1='Linearization is not full! Check None linear region in the Option!!!';
  strusc2='OUT memory 1';
  strusc3='New Electronic ';
  strusc4=' detected!!!!';
  strusc5='Controller.ini File Not Exists !';
  strusc6='New Scanner ';
  strusc7=' detected!';

var
  NoFormUnitLoc: TNoFormUnitLoc;

implementation

   uses GLOBALVAR;
{$R *.dfm}


procedure TNoFormUnitLoc.FormCreate(Sender: TObject);
begin
  UpdateStrings;
  if sLanguage='RUS' then
    begin
       siLang1.ActiveLanguage:=2;
    end
    else
    begin
      siLang1.ActiveLanguage:=1;
    end;
     UpdateStrings;
end;

procedure TNoFormUnitLoc.siLang1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TNoFormUnitLoc.siLangLinked1ChangeLanguage(Sender: TObject);
begin
    if sLanguage='RUS' then
    begin
       siLang1.ActiveLanguage:=2;
    end
    else
    begin
      siLang1.ActiveLanguage:=1;
    end;
 UpdateStrings;
 end;

procedure TNoFormUnitLoc.UpdateStrings;
begin
  strub5 := siLang1.GetTextOrDefault('strstrub5');
  strub4 := siLang1.GetTextOrDefault('strstrub4');
  strcom18 := siLang1.GetTextOrDefault('strstrcom18');
  strcom17 := siLang1.GetTextOrDefault('strstrcom17');
  strcom16 := siLang1.GetTextOrDefault('strstrcom16');
  strcom15 := siLang1.GetTextOrDefault('strstrcom15');
  strcom14 := siLang1.GetTextOrDefault('strstrcom14');
  strcom13 := siLang1.GetTextOrDefault('strstrcom13');
  strl := siLang1.GetTextOrDefault('strstrl');
  strus0 := siLang1.GetTextOrDefault('strstrus0');
  strud0 := siLang1.GetTextOrDefault('strstrud0');
  strud1 := siLang1.GetTextOrDefault('strstrud1');
  strud2 := siLang1.GetTextOrDefault('strstrud2');
  strud3 := siLang1.GetTextOrDefault('strstrud3');
  strubm4 := siLang1.GetTextOrDefault('strstrubm4');
  strub3 := siLang1.GetTextOrDefault('strstrub3');
  strub2 := siLang1.GetTextOrDefault('strstrub2');
  strub1 := siLang1.GetTextOrDefault('strstrub1');
  strub0 := siLang1.GetTextOrDefault('strstrub0');
  s7 := siLang1.GetTextOrDefault('strs7');
  s6 := siLang1.GetTextOrDefault('strs6');
  s5 := siLang1.GetTextOrDefault('strs5');
  s4 := siLang1.GetTextOrDefault('strs4');
  strglf0 := siLang1.GetTextOrDefault('strstrglf0');
  strcom12 := siLang1.GetTextOrDefault('strstrcom12');
  strcom11 := siLang1.GetTextOrDefault('strstrcom11');
  strcom10 := siLang1.GetTextOrDefault('strstrcom10');
  strcom9 := siLang1.GetTextOrDefault('strstrcom9');
  strcom8 := siLang1.GetTextOrDefault('strstrcom8');
  strcom7 := siLang1.GetTextOrDefault('strstrcom7');
  strcom6 := siLang1.GetTextOrDefault('strstrcom6');
  strcom5 := siLang1.GetTextOrDefault('strstrcom5');
  strcom3 := siLang1.GetTextOrDefault('strstrcom3');
  strcom2 := siLang1.GetTextOrDefault('strstrcom2');
  strcom1 := siLang1.GetTextOrDefault('strstrcom1');
  strcom := siLang1.GetTextOrDefault('strstrcom');
  strglf0 := siLang1.GetTextOrDefault('strstrglf0');
  strub0 := siLang1.GetTextOrDefault('strstrub0');
  strcom12 := siLang1.GetTextOrDefault('strstrcom12');
  strcom11 := siLang1.GetTextOrDefault('strstrcom11');
  strcom10 := siLang1.GetTextOrDefault('strstrcom10');
  strcom9 := siLang1.GetTextOrDefault('strstrcom9');
  strcom8 := siLang1.GetTextOrDefault('strstrcom8');
  strcom7 := siLang1.GetTextOrDefault('strstrcom7');
  strcom6 := siLang1.GetTextOrDefault('strstrcom6');
  strcom5 := siLang1.GetTextOrDefault('strstrcom5');
  strcom3 := siLang1.GetTextOrDefault('strstrcom3');
  strcom2 := siLang1.GetTextOrDefault('strstrcom2');
  strcom1 := siLang1.GetTextOrDefault('strstrcom1');
  strcom := siLang1.GetTextOrDefault('strstrcom');
  strl := siLang1.GetTextOrDefault('strstrl');
  strus0 := siLang1.GetTextOrDefault('strstrus0');
  strud0 := siLang1.GetTextOrDefault('strstrud0');
  strud1 := siLang1.GetTextOrDefault('strstrud1');
  strud2 := siLang1.GetTextOrDefault('strstrud2');
  strud3 := siLang1.GetTextOrDefault('strstrud3');
  strub2 := siLang1.GetTextOrDefault('strstrub2');
  strub3 := siLang1.GetTextOrDefault('strstrub3');
  strub1 := siLang1.GetTextOrDefault('strstrub1');
  strubm4 := siLang1.GetTextOrDefault('strstrubm4');
//  strubm3 := siLangLinked1.GetTextOrDefault('strstrubm3');
//  strubm2 := siLangLinked1.GetTextOrDefault('strstrubm2');
//  strubm1 := siLangLinked1.GetTextOrDefault('strstrubm1');
  s7 := siLang1.GetTextOrDefault('strs7');
  s6 := siLang1.GetTextOrDefault('strs6');
  s5 := siLang1.GetTextOrDefault('strs5');
  s4 := siLang1.GetTextOrDefault('strs4');
//  s3 := siLangLinked1.GetTextOrDefault('strs3');
 // s2 := siLangLinked1.GetTextOrDefault('strs2');
//  s1 := siLangLinked1.GetTextOrDefault('strs1');

end;

end.















