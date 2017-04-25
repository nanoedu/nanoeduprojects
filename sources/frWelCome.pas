unit frWelCome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ActnList, jpeg, siComp, siLngLnk,
  ComCtrls, ToolWin, ImgList;

type
  TWellCome = class(TForm)
    siLangLinked1: TsiLangLinked;
    ImageList: TImageList;
    Panel1: TPanel;
    PageControl: TPageControl;
    TabSheetAbout: TTabSheet;
    Image3: TImage;
    lbl: TLabel;
    ToolBar: TToolBar;
    ToolButtonshow: TToolButton;
    CheckBoxView: TCheckBox;
    ToolBar2: TToolBar;
    ToolBtnAbout: TToolButton;
    TabSheetProbe: TTabSheet;
    Image4: TImage;
    ToolBarTurnOn: TToolBar;
    ToolBtnTurnOn: TToolButton;
    TabSheetExp: TTabSheet;
    Image5: TImage;
    bitbtnstartsfm: TToolBar;
    ToolButton2: TToolButton;
    bitbtnstartstm: TToolBar;
    ToolButton4: TToolButton;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure ToolButtonShowClick(Sender: TObject);
    procedure CheckBoxViewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnStartClick(Sender: TObject);
    procedure BitBtnStartSFMClick(Sender: TObject);
    procedure BitBtnStartSTMClick(Sender: TObject);
    procedure ToolBtnTurnOnClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    function ExecAndWaitMainVideo(const FileName, Params: String;const winname:string; const WinState: Word): boolean;
  public
    { Public declarations }
  end;

var
  WellCome: TWellCome;

implementation
uses nanoeduhelp,globalvar,mMain,ShellApi,frMedia;
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
 //  checkboxview.Top:=clientheight-checkboxview.height-30;
   CheckBoxView.Checked:=flgShowWellComeWindow;
   PageControl.ActivePage:=TabsheetAbout;  
 //  Toolbar.Top:= checkboxview.Top-35;
 //  Toolbar.left:=bitbtnstartstm.Left+20;
 //  LabelBox.Top:=checkboxview.Top;
   Main.itemShowwellcomewindow.Checked:=flgShowWellComeWindow;
end;

procedure TWellCome.ToolBtnTurnOnClick(Sender: TObject);
begin
     HlpContext:=IDH_Tip;
     Application.HelpContext(HlpContext);
end;

procedure TWellCome.ToolButton1Click(Sender: TObject);
begin
  HlpContext:=IDH_Probe_install;
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
//       HlpContext:=IDH_Start_NanoEdu;
//     Application.HelpContext(HlpContext);
var locdir:string;
    InitialDir,filename:string;
begin
   ToolBtnAbout.enabled:=False;
//   OpenDialog.Filter:='movie files (*.wmv;*.avi;*.mp4)|*.wmv;*.avi;*.mp4;|all files (*.*)|*.*' ;
(*   if lang = 2 then locdir:='rus'
   else  locdir:='eng';

   OpenDialog.InitialDir:=CommonNanoeduDocumentsPath+'video' +'\'+locdir;
   OpenDialog.FileName:='';
  if Opendialog.execute then
   begin
     ExecAndWaitMainVideo(Opendialog.Filename,'','',SW_showNORMAL);
   end;
   *)
  if lang = 2 then
  begin
   locdir:='rus';
   InitialDir:=CommonNanoeduDocumentsPath+'video' +'\'+locdir;
   fileName:=InitialDir+'\'+tutvideorus;//'\3D_Модель_NanoEducator_LE.mp4'
  end
  else
  begin
   locdir:='eng';
   InitialDir:=CommonNanoeduDocumentsPath+'video' +'\'+locdir;
   fileName:=InitialDir+'\'+tutvideoeng;//'\3D_Model_NanoEducator_LE.mp4'
  end;
 if Fileexists(Filename) then   ExecAndWaitMainVideo(Filename,'','',SW_showNORMAL)
                         else   silanglinked1.MessageDlg(Filename+strfilenotexists,mtWarning ,[mbOK],0);
   ToolBtnAbout.enabled:=True;
end;
function TWellCome.ExecAndWaitMainVideo(const FileName, Params: String;const winname:string; const WinState: Word): boolean;
 var      H: hWnd;
     fVideo:TMedia;
     res:Thandle;
begin { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
     res:= ShellExecute(handle,nil,Pchar(fileName),nil,nil,SW_RESTORE or SW_MAXIMIZE	);
    if  Res<32 then
     begin
      fVideo:=TMedia.Create(Application);
      //  two monitirs
      fVideo.Show;
      fVideo.MediaPlayer.filename:=FileName;
      fVideo.MediaPlayer.open;
     // fVideo.MediaPlayer.play;
    end;
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
