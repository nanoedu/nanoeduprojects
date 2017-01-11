unit frProgramSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, siComp, siLngLnk, ComCtrls;

type
  TFormProgramSettings = class(TForm)
    siLangLinked1: TsiLangLinked;
    PageControl: TPageControl;
    TabSheetScheme: TTabSheet;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Select: TLabel;
    TabSheetChangeLevel: TTabSheet;
    ComboBoxProgram: TComboBox;
    Label1: TLabel;
    RadioGroupchangeUserLevel: TRadioGroup;
    Label2: TLabel;
    Label3: TLabel;
    TabSheet1: TTabSheet;
    CheckBox: TCheckBox;
    Panel2: TPanel;
    BitBtnCancel: TBitBtn;
    BitBtnOK: TBitBtn;
    TabSheetSimulator: TTabSheet;
    CheckBoxFastSimulation: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure ComboBoxProgramChange(Sender: TObject);
    procedure RadioGroupchangeUserLevelClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);

  private
   SchemeList:TstringList;
   newSchemeInd:integer;
  procedure   ScanSubDirectories(parentdir:string; var subdirlist:TStringList);
  public
    { Public declarations }
  end;

var
  FormProgramSettings: TFormProgramSettings;
// Способ выделить имя файла без расширения
// ChangeFileExt( ExtractFileName(Путь\Имя файла.txt), '' );
implementation

{$R *.dfm}
uses GlobalVar,CSPMVar, Globalfunction,mMain;

 procedure TFormProgramSettings.BitBtnCancelClick(Sender: TObject);
begin
  modalresult:=mrCancel;
//  close;
end;

procedure TFormProgramSettings.BitBtnOKClick(Sender: TObject);
begin
     SetSchemeName(Combobox1.Text);
     ScanParams.flgFastSimulator:=CheckBoxFastSimulation.checked;
     SetFlgFastSimulation;
     modalResult:=mrOK;
end;

procedure TFormProgramSettings.CheckBoxClick(Sender: TObject);
begin
   flgOnlineService:=integer(CheckBox.checked);
   Main.AskOnline.Visible:=boolean(flgOnLineService);
end;

procedure TFormProgramSettings.ComboBoxProgramChange(Sender: TObject);
begin
   main.ComboBoxLevel.ItemIndex:= ComboBoxProgram.ItemIndex;
   main.procComboboxLevelSelect(Sender);
end;

procedure TFormProgramSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FreeandNil(SchemeList);
   flgchangeUserLevel:=RadioGroupchangeUserLevel.ItemIndex;
   action:=caFree;
end;



procedure     TFormProgramSettings.ScanSubDirectories(parentdir:string; var subdirlist:TStringList);
var ires:integer;
    sSr:TsearchRec;
begin
   if assigned(subdirlist) then subdirlist.clear
                           else subdirlist:=TstringLIst.Create;
  if DirectoryExists(ParentDir) then
  begin
   ires:=FindFirst(ParentDir+'*.bin',faDirectory,sSR);
     while ires = 0 do
        begin
        if  (sSR.Name <> '.') and  (sSR.Name <> '..') then subdirList.add(sSR.Name);
          ires:=FindNext(sSR);
        end;
    FindClose(sSR);
  end;
end;

procedure TFormProgramSettings.FormCreate(Sender: TObject);
var i:integer;
    ss:string;
begin
    siLangLinked1.ActiveLanguage:=Lang;
   // UpdateStrings;
   PageControl.ActivePage:=TabSheetScheme;
//   BitBtnOk.Enabled:=Main.ToolBtnNew.Enabled;
    GetScriptsName;
    newSchemeInd:=0;
    Application.processmessages;
    SchemeList:=TstringList.Create;
    ScanSubDirectories(SchemePath, SchemeList );
    ss:=ExtractFileName(Scheme) ;
    for  i:=0 to  SchemeList.Count do
        begin
          if SchemeList[i] = ss then
               begin
                 newSchemeInd:=i;
                 break;
               end;
        end;
    if newSchemeInd < SchemeList.Count then
         begin
            Combobox1.Items.Assign(SchemeList);
            Combobox1.ItemIndex:=newSchemeInd;
         end;
    ComboboxProgram.ItemIndex:=Main.ComboBoxLevel.ItemIndex;
    RadioGroupchangeUserLevel.ItemIndex:=flgchangeUserLevel;
    CheckBoxFastSimulation.Checked:=ScanParams.flgFastSimulator;
    checkbox.Checked:=boolean(flgOnlineService);
end;



procedure TFormProgramSettings.RadioGroupchangeUserLevelClick(Sender: TObject);
begin
   flgchangeUserLevel:=RadioGroupchangeUserLevel.ItemIndex;
   main.ComboBoxLevel.Enabled:=boolean(flgchangeUserLevel);
end;

end.
