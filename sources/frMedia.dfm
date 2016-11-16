object Media: TMedia
  Left = 218
  Top = 250
  Width = 455
  Height = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 447
    Height = 313
    Align = alTop
    BevelInner = bvRaised
    BevelWidth = 2
    TabOrder = 0
  end
  object PanelDown: TPanel
    Left = 0
    Top = 313
    Width = 447
    Height = 59
    Align = alClient
    Color = clSilver
    TabOrder = 1
    object MediaPlayer: TMediaPlayer
      Left = 128
      Top = 13
      Width = 197
      Height = 30
      ColoredButtons = [btPlay, btPause, btStop, btNext, btPrev, btStep, btBack]
      EnabledButtons = [btPlay, btPause, btStop, btNext, btPrev, btStep, btBack]
      VisibleButtons = [btPlay, btPause, btStop, btNext, btPrev, btStep, btBack]
      AutoRewind = False
      Display = PanelTop
      TabOrder = 0
    end
  end
  object MainMenu1: TMainMenu
    Left = 128
    Top = 64
    object File1: TMenuItem
      Caption = '&File'
      object Open: TMenuItem
        Caption = '&Open'
        OnClick = OpenClick
      end
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'wmv'
    Filter = 'movie (*.wmv)|(*.wmv)'
    Left = 216
    Top = 104
  end
end
