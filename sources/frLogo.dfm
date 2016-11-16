object Logo: TLogo
  Left = 421
  Top = 194
  BorderStyle = bsNone
  ClientHeight = 330
  ClientWidth = 351
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object ImageLogo: TImage
    Left = 0
    Top = 0
    Width = 351
    Height = 330
    Align = alClient
    Stretch = True
  end
  object Timer1: TTimer
    Interval = 0
    OnTimer = Timer1Timer
    Left = 112
    Top = 112
  end
end
