unit VideoSettingsUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, VFW;

type

  TOnDriverChange = procedure of object;

  TVideoSettings = class(TForm)
    SrcDlgBtn: TSpeedButton;
    FormatDlgBtn: TSpeedButton;
    DisplayDlgBtn: TSpeedButton;
    DriverCB: TComboBox;
    CompressBtn: TSpeedButton;
    OverlayBtn: TSpeedButton;
    FrameRateCB: TComboBox;
    FrameRateLbl: TLabel;
    procedure SrcDlgBtnClick(Sender: TObject);
    procedure FormatDlgBtnClick(Sender: TObject);
    procedure DisplayDlgBtnClick(Sender: TObject);
    procedure DriverCBChange(Sender: TObject);
    procedure CompressBtnClick(Sender: TObject);
    procedure OverlayBtnClick(Sender: TObject);
    procedure FrameRateCBChange(Sender: TObject);
  private
    FWndC: THandle;
    FOnDriverChange: TOnDriverChange;
    FOnOverlayChange: TOnDriverChange;
  public
    property WndC: THandle write FWndC;
    property OnDriverChange: TOnDriverChange write FOnDriverChange;
    property OnOverlayChange: TOnDriverChange write FOnOverlayChange;
  end;

implementation

{$R *.DFM}

procedure TVideoSettings.SrcDlgBtnClick(Sender: TObject);
begin
  capDlgVideoSource(FWndC);
end;

procedure TVideoSettings.FormatDlgBtnClick(Sender: TObject);
var
  Status: TCapStatus;
begin
  capDlgVideoFormat(FWndC);
  capGetStatus(FWndC, @Status, sizeof(Status));
  if not (Status.fLiveWindow or Status.fOverlayWindow) then
  begin
    capGrabFrame(FWndC);
    capGrabFrame(FWndC);
  end;
end;

procedure TVideoSettings.DisplayDlgBtnClick(Sender: TObject);
begin
  capDlgVideoDisplay(FWndC);
end;

procedure TVideoSettings.DriverCBChange(Sender: TObject);
begin
  capDriverDisconnect(FWndC);
  if not capDriverConnect(FWndC, DriverCB.ItemIndex) then
  begin
    DriverCB.Items[DriverCB.ItemIndex] := '';
    MessageDlg('Video Driver not connected! Click settings,choose video driver and click start!', mtInformation,[mbOk],0);
 //   ShowMessage('Video Driver not connected!');
  end;
  if Assigned(FOnDriverChange) then
    FOnDriverChange;
  FrameRateCB.Enabled := not OverlayBtn.Down;
end;

procedure TVideoSettings.CompressBtnClick(Sender: TObject);
begin
  capDlgVideoCompression(FWndC);
end;

procedure TVideoSettings.OverlayBtnClick(Sender: TObject);
begin
  if Assigned(FOnOverlayChange) then
    FOnOverlayChange;
  FrameRateCB.Enabled := not OverlayBtn.Down;
  if FrameRateCB.Enabled then
    FrameRateCBChange(Self);
end;

procedure TVideoSettings.FrameRateCBChange(Sender: TObject);
begin
  capPreviewRate(FWndC, trunc(1000/StrToInt(FrameRateCB.Text)));
end;

end.
