unit frWelCome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ActnList, jpeg, siComp, siLngLnk,
  ComCtrls, ToolWin, ImgList;

type
  TWellCome = class(TForm)
    Image1: TImage;
    LabelBox: TLabel;
    CheckBoxView: TCheckBox;
    siLangLinked1: TsiLangLinked;
    ImageList: TImageList;
    ToolBar: TToolBar;
    ToolButtonshow: TToolButton;
    ToolBarTurnOn: TToolBar;
    ToolBtnTurnOn: TToolButton;
    bitbtnstartsfm: TToolBar;
    ToolButton2: TToolButton;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    Image2: TImage;
    bitbtnstartstm: TToolBar;
    ToolButton4: TToolButton;
    procedure ToolButtonShowClick(Sender: TObject);
    procedure CheckBoxViewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnStartClick(Sender: TObject);
    procedure BitBtnStartSFMClick(Sender: TObject);
    procedure BitBtnStartSTMClick(Sender: TObject);
    procedure ToolBtnTurnOnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WellCome: TWellCome;

implementation
uses nanoeduhelp,globalvar,mMain,ShellApi;
{$R *.dfm}

procedure TWellCome.CheckBoxViewClick(Sender: TObject);
begin
 // flgShowWellComeWindow:=not flgShowWellComeWindow;
 //  main.itemShowwellcomewindow.Checked:=flgShowWellComeWindow;
end;

procedure TWellCome.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 flgShowWellComeWindow:=CheckBoxView.Checked;
 Main.itemShowWellcomeWindow.Checked:=flgShowWellComeWindow;
 action:=caFree;
 WellCome:=nil;
end;

procedure TWellCome.FormCreate(Sender: TObject);
begin
   if Screen.height<=800 then Constraints.Maxheight:=500
                         else Constraints.Maxheight:=600;
   if Screen.Height<=800 then Constraints.Minheight:=500
                         else Constraints.Minheight:=600;
   siLangLinked1.ActiveLanguage:=Lang;
//   bitbtnstartsfm.Left:=clientwidth-bitbtnstartsfm.width-toolbarturnon.left;//}10;
//   bitbtnstartstm.Left:=bitbtnstartsfm.Left;
   checkboxview.Top:=clientheight-checkboxview.height-30;
   CheckBoxView.Checked:=flgShowWellComeWindow;
   Toolbar.Top:= checkboxview.Top-35;
   Toolbar.left:=bitbtnstartstm.Left+20;
   LabelBox.Top:=checkboxview.Top;
   Main.itemShowwellcomewindow.Checked:=flgShowWellComeWindow;
end;

procedure TWellCome.ToolBtnTurnOnClick(Sender: TObject);
begin
     HlpContext:=IDH_Turn_On;
     Application.HelpContext(HlpContext);
end;

procedure TWellCome.ToolButtonshowClick(Sender: TObject);
  var
    res:Thandle;
  filename:string;
begin
 filename:='GalleryShow.ppsx';
if  siLangLinked1.ActiveLanguage=2 then  filename:='GalleryShow_R.ppsx';
if not directoryexists(ScanGalleryDir) then
  begin MessageDlgCtr(strm34{'Gallery directory do not exists!!'},mtwarning,[mbOk],0);   exit; end;
     res:= ShellExecute(handle,nil,Pchar(ScanGalleryDir+'\'+filename),nil,nil,SW_RESTORE);
end;



procedure TWellCome.BitBtnStartClick(Sender: TObject);
begin
       HlpContext:=IDH_Start_NanoEdu;
     Application.HelpContext(HlpContext);
end;

procedure TWellCome.BitBtnStartSFMClick(Sender: TObject);
begin
       HlpContext:=IDH_Start_SFM;
     Application.HelpContext(HlpContext);
end;

procedure TWellCome.BitBtnStartSTMClick(Sender: TObject);
begin
        HlpContext:=IDH_Start_STM;
     Application.HelpContext(HlpContext);
end;

end.
