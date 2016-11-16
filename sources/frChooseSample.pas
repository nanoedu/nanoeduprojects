unit frChooseSample;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, strUtils, Buttons, siComp, siLngLnk;

type
  TChooseSample = class(TForm)
    Panel1: TPanel;
    ComboBoxSample: TComboBox;
    Label1: TLabel;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    siLangLinked1: TsiLangLinked;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    startindex:integer;
     procedure GetTreeDirs(Root: string; OutPaper: TStringList);
  public
    { Public declarations }
  end;

var
  ChooseSample: TChooseSample;

implementation

{$R *.dfm}

uses   globalvar,cspmvar,mMain;

procedure  TChooseSample.GetTreeDirs(Root: string; OutPaper: TStringList);
var
  i: Integer;
  s: string;

  procedure InsDirs(s: string; ind: Integer; Path: string; OPaper: TStringList);
  var {¬ставл€ет в Memo список вложенных директорий}
    sr: TSearchRec;
    attr,k: Integer;
  begin
    attr := 0;
    attr := faAnyFile;
    if DirectoryExists(Path) then
    k:=0;
      if FindFirst(IncludeTrailingBackslash(Path) + '*.*', attr, SR) = 0 then
      begin
        repeat
          if (sr.Attr = faDirectory) and (sr.Name[Length(sr.Name)] <> '.') then
            OPaper.Insert(ind, {s +} sr.Name);
            if sr.Name='cd_pits' then
            startindex:=k;
         inc(k);
        until (FindNext(sr) <> 0);
        FindClose(SR);
      end
  end;

begin
  {ѕровер€ем существуетли начальный каталог}
  if not DirectoryExists(Root) then      exit;
  {—оздаем список каталогов первой вложенности}
  if root[Length(Root)] <> '\' then
    InsDirs(root + '\', OutPaper.Count, Root, OutPaper)
  else
    InsDirs(root, OutPaper.Count, Root, OutPaper);
end;


procedure TChooseSample.BitBtnCancelClick(Sender: TObject);
begin
 ModalResult := mrCancel
end;

procedure TChooseSample.BitBtnOKClick(Sender: TObject);
begin
  CASE STMFLG OF
  true:DemoSample:='stm\samples\'+ComboBoxSample.text;
 false:DemoSample:='sfm\samples\'+ComboBoxSample.text;
      end;
  ModalResult := mrOK;
end;

procedure TChooseSample.FormCreate(Sender: TObject);
var
  Strs: TStringList;
  path:string;
  i:integer;
  ss, samp_onlyName:string;
  len,k:integer;
begin
 siLangLinked1.ActiveLanguage:=Lang;
  Strs := TStringList.Create;
  try
        CASE STMFLG OF
  true:path:=DemoDataDirectory+'stm\samples\';
 false:path:=DemoDataDirectory+'sfm\samples\';
      end;
       comboboxsample.clear;
       GetTreeDirs(path,strs);
       comboboxsample.items.AddStrings(strs);

  CASE STMFLG OF
  true: ss:='stm\samples\';
 false: ss:='sfm\samples\';
  END;
  len:=length(ss);
  k:=pos(ss, 'm');
  samp_onlyName:= DemoSample;
  delete( samp_onlyName,1,len); // delete(DemoSample,1,len);

 (*         CASE STMFLG OF
  true:begin DemoSample:='stm\samples\'+ComboBoxSample.text;  end;
 false:DemoSample:='sfm\samples\'+ComboBoxSample.text;
      end; *) // закомментировано, т.к. здесь ComboBoxSample.text = '',
              // и затираетс€ старое значение DemoSample
     comboboxsample.itemindex:=0;
     for i:=0 to  comboboxsample.Items.count-1 do
      if  comboboxsample.Items.Strings[i]=samp_onlyName then
        begin comboboxsample.itemindex:=i ; break end;
         comboboxsample.droppeddown:=true;
  finally
    Strs.Free;
  end;
end;

procedure TChooseSample.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     ComboBoxSample.Clear;
     action:=caFree;
     ChooseSample:=nil;
end;

end.
