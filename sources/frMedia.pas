unit frMedia;

interface

uses
  Windows, Messages, SysUtils, {Variants,} Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, MPlayer, Menus;

type
  TMedia = class(TForm)
    PanelTop: TPanel;
    PanelDown: TPanel;
    MediaPlayer: TMediaPlayer;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open: TMenuItem;
    OpenDialog: TOpenDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OpenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Media: TMedia;

implementation
uses   GlobalVar;
{$R *.dfm}

procedure TMedia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
end;

procedure TMedia.FormCreate(Sender: TObject);
begin
     with MediaPlayer do
   begin
  //  Display:=PanelTop;
  
  //  DisplayRecT:=PanelTop.ClientRect;
    DeviceType := dtAutoSelect;//dtAVIVideo; //set Device compatibility to AVI
   end;
   OpenDialog.InitialDir:=ExeFilePath+'animation';
   OpenDialog. filter:='Movie files (*.wmv)|*.wmv'
end;

procedure TMedia.OpenClick(Sender: TObject);
begin

     if OpenDialog.execute then
     begin
          with MediaPlayer do
       begin
        FileName:=OpenDialog.FileName;
        open;
      {   self.Width:=width;
         self.height:=height;
      }   
       end;
     end;
end;

end.
