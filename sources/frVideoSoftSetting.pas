unit frVideoSoftSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, NTShellCtrls, siComp, siLngLnk;

type
  TVideoSoftSetting = class(TForm)
    PanelPath: TPanel;
    LblPATH: TLabel;
    Label1: TLabel;
    NTShellTreeView: TNTShellTreeView;
    NTShellComboBox: TNTShellComboBox;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    BitBtnOk: TBitBtn;
    Panel3: TPanel;
    CheckBox: TCheckBox;
    siLangLinked1: TsiLangLinked;
    procedure FormCreate(Sender: TObject);
    procedure BitBtnOkClick(Sender: TObject);
    procedure NTShellTreeViewClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VideoSoftSetting: TVideoSoftSetting;

implementation

{$R *.dfm}
uses Globalvar,CSPMVar,SystemConfig,mMain;

procedure TVideoSoftSetting.BitBtn2Click(Sender: TObject);
begin
ModalREsult:=mrCancel;
end;

procedure TVideoSoftSetting.BitBtnOkClick(Sender: TObject);
begin
if CheckBox.Checked then
begin
FirmCameraSoftPath:=lblPath.Caption+'\';
// FirmCameraSoftPath:= extractfilepath(lblPath.Caption);
// FirmCameraWinName:=extractfilename(lblPath.Caption);
 SaveVideoParams;
end;
  ModalREsult:=mrOK;
end;

procedure TVideoSoftSetting.CheckBoxClick(Sender: TObject);
begin
 PanelPath.Visible:=CheckBox.Checked;
 flgRunFirmCamera:= integer(CheckBox.Checked);
end;

procedure TVideoSoftSetting.FormCreate(Sender: TObject);
begin
 siLanglinked1.ActiveLanguage:=Lang;
 CheckBox.Checked:=boolean(flgRunFirmCamera);
 PanelPath.Visible:=CheckBox.Checked;
 lblPath.Caption:=FirmCameraSoftPath;
end;


procedure TVideoSoftSetting.NTShellTreeViewClick(Sender: TObject);
begin
 lblPATH.Caption:=NTShellTreeView.Path;
end;

end.
