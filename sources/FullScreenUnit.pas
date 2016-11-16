
unit FullScreenUnit;

interface
uses
Windows, Controls;

type
TFullScreenHandler = class
private
  FRestoreRect : TRect;
  function GetInFullScreenMode : Boolean;
  function GetMaxSize : SIZE;
public
  { Развернуть клиентскую область окна во весь экран }
  procedure Maximize (AWinControl : TWinControl);
  { Восстановить клиентскую область окна }
  procedure Restore (AWinControl : TWinControl);
  { Развернута ли клиентская область окна во весь экран }
  property InFullScreenMode : Boolean read GetInFullScreenMode;
  { Максимально возможный размер окна, такой, чтобы клиентская область
    уместилась во весь экран. }
  property MaxSize : SIZE read GetMaxSize;
end;

var
FullScreenHandler : TFullScreenHandler;

implementation
uses  Forms; { Для Screen }

function TFullScreenHandler.GetInFullScreenMode : Boolean;
begin
Result := not IsRectEmpty(FRestoreRect);
end;

function TFullScreenHandler.GetMaxSize : SIZE;
var
ARect : TRect;
begin
{
При большом желании обращение к свойствам переменной Screen можно заменить
на вызовы функции GetSystemMetrics(SM_CXSCREEN) и
GetSystemMetrics(SM_CYSCREEN).
}
SetRect(ARect, 0, 0, Screen.Width, Screen.Height);
InflateRect(ARect, 10, 50); //Любые числа, лишь бы превышали размер
                            //неклиентской области окон
Result.cx := ARect.Right - ARect.Left;
Result.cy := ARect.Bottom - ARect.Top;
end;

procedure TFullScreenHandler.Maximize (AWinControl : TWinControl);
var
RcClient, RcNewWindow : TRect;
begin
RcClient := AWinControl.ClientRect;
{ Перевод координат клиентской области окна в экранные }
MapWindowPoints(AWinControl.Handle, HWND_DESKTOP, RcClient, 2);
{ Сохраним размеры окна для восстановления }
GetWindowRect(AWinControl.Handle, FRestoreRect);
{
При большом желании обращение к свойствам переменной Screen можно заменить
на вызовы функции GetSystemMetrics(SM_CXSCREEN) и
GetSystemMetrics(SM_CYSCREEN).
}
SetRect(RcNewWindow, 0, 0, Screen.Width, Screen.Height);
with RcNewWindow do begin
  Inc(Left, FRestoreRect.Left - RcClient.Left);
  Inc(Top, FRestoreRect.Top - RcClient.Top);
  Inc(Right, FRestoreRect.Right - RcClient.Right);
  Inc(Bottom, FRestoreRect.Bottom - RcClient.Bottom);
  SetWindowPos (AWinControl.Handle, 0, Left, Top, Right - Left, Bottom - Top,
                SWP_NOZORDER);
end;
end;

procedure TFullScreenHandler.Restore (AWinControl : TWinControl);
begin
with FRestoreRect do
  SetWindowPos (AWinControl.Handle, 0, Left, Top, Right - Left, Bottom - Top,
                SWP_NOZORDER);
SetRectEmpty(FRestoreRect);
end;

initialization
FullScreenHandler := TFullScreenHandler.Create();
finalization
FullScreenHandler.Free();
end.

unit main;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
Dialogs, Menus, ExtCtrls;

type
TfMain = class(TForm)
  MainMenu: TMainMenu;
  View1: TMenuItem;
  miFullScreen: TMenuItem;
  Image: TImage;
  miHelp: TMenuItem;
  About: TMenuItem;
  procedure miFullScreenClick(Sender: TObject);
  procedure ImageDblClick(Sender: TObject);
  procedure AboutClick(Sender: TObject);
private
  procedure WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo);
                                                   message WM_GETMINMAXINFO;
end;

var
fMain: TfMain;

implementation
uses
FullScreenUnit, About;

{$R *.dfm}

procedure TfMain.miFullScreenClick(Sender: TObject);
begin
if NOT FullScreenHandler.InFullScreenMode then
  FullScreenHandler.Maximize(Self)
else
  FullScreenHandler.Restore(Self);
miFullScreen.Checked := FullScreenHandler.InFullScreenMode;
end;

procedure TfMain.WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo);
var
Sz : SIZE;
begin
Sz := FullScreenHandler.MaxSize;
with Message.MinMaxInfo^ do begin
  ptMaxSize := TPoint(Sz);
  ptMaxTrackSize := TPoint(Sz);
end;
end;

procedure TfMain.ImageDblClick(Sender: TObject);
begin
miFullScreenClick(miFullScreen);
end;

procedure TfMain.AboutClick(Sender: TObject);
begin
with TfAbout.Create(Application) do
  try
    ShowModal();
  finally
    Free();
  end;
end;

end.
interface

implementation

end.
