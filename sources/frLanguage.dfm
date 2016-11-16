object frLang: TfrLang
  Left = 701
  Top = 211
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Set Language'
  ClientHeight = 243
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 270
    Height = 243
    Align = alClient
    TabOrder = 0
    object RGroupLang: TRadioGroup
      Left = 33
      Top = 33
      Width = 156
      Height = 130
      Caption = 'Language'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Russian'
        'English')
      ParentFont = False
      TabOrder = 0
    end
    object BitBtnOk: TBitBtn
      Left = 24
      Top = 200
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = BitBtnOkClick
    end
    object BitBtnCancel: TBitBtn
      Left = 184
      Top = 200
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
      OnClick = BitBtnCancelClick
    end
  end
end
