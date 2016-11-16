object farplugin: Tfarplugin
  Left = 458
  Top = 221
  Width = 432
  Height = 276
  Caption = 'Setup Plug In'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 424
    Height = 242
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 58
      Top = 56
      Width = 320
      Height = 16
      Caption = 'Copy files for controller NanoEducator support'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object ProgressBar: TProgressBar
      Left = 64
      Top = 112
      Width = 305
      Height = 33
      Max = 3
      Step = 1
      TabOrder = 0
    end
  end
  object Timer: TTimer
    Interval = 0
    OnTimer = TimerTimer
    Left = 128
    Top = 200
  end
end
