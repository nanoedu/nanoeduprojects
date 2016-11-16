object FormDeviceReady: TFormDeviceReady
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Warning'
  ClientHeight = 112
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 363
    Height = 112
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 120
    ExplicitTop = 16
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Image1: TImage
      Left = 1
      Top = 41
      Width = 361
      Height = 31
      Align = alClient
      ExplicitLeft = 80
      ExplicitTop = 8
      ExplicitWidth = 105
      ExplicitHeight = 105
    end
    object Image2: TImage
      Left = 1
      Top = 41
      Width = 361
      Height = 31
      Align = alClient
      ExplicitLeft = 0
      ExplicitTop = 47
    end
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 361
      Height = 40
      Align = alTop
      Caption = '            Device is ready  for experiments!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 33023
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 1
      Top = 72
      Width = 361
      Height = 39
      Align = alBottom
      Caption = '              Welcome into the nanoworld!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4227327
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 296
    Top = 24
  end
end
