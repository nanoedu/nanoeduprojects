unit fShockwave;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, ShockwaveFlashObjects_TLB, Buttons, ExtCtrls, ComCtrls,
  StdCtrls;

type
  TShockWave = class(TForm)
    PanelFlash: TPanel;
    PanelBottom: TPanel;
    SpeedBtnPlay: TSpeedButton;
    SpeedBtnStop: TSpeedButton;
    TrackBar: TTrackBar;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedBtnPlayClick(Sender: TObject);
    procedure SpeedBtnStopClick(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);

  private
    { Private declarations }

  public
    ShockwaveFlash:TShockwaveFlash;
    constructor Create(Sender: TObject;const Filename:string);
  end;

var
  ShockWave: TShockWave;

implementation

{$R *.DFM}
constructor TShockWave.Create(Sender: TObject;const Filename:string);
begin
    inherited Create(application);
    ShockwaveFlash:= TShockwaveFlash.Create(self);
    ShockwaveFlash.parent:=panelflash;
    ShockwaveFlash.align:=alClient;
    Shockwaveflash.movie:=filename;
    trackbar.Max:=Shockwaveflash.TotalFrames;
end;
procedure TShockWave.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//    TBitBtn(Sender).enabled:=true;
    Action:=caFree;
    ShockWave:=nil;

end;

procedure TShockWave.SpeedBtnPlayClick(Sender: TObject);
begin
     ShockwaveFlash.play;
end;

procedure TShockWave.SpeedBtnStopClick(Sender: TObject);
begin
    if ShockwaveFlash.IsPlaying then ShockwaveFlash.Stop;
end;



procedure TShockWave.TrackBarChange(Sender: TObject);
begin
    if ShockwaveFlash.IsPlaying then ShockwaveFlash.Stop;
       Shockwaveflash.GotoFrame(trackbar.position);
end;



end.

