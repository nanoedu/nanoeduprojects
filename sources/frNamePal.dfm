object NamePal: TNamePal
  Left = 366
  Top = 372
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'New Palette Name'
  ClientHeight = 103
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 352
    Height = 103
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 96
    object Label1: TLabel
      Left = 45
      Top = 15
      Width = 66
      Height = 13
      Caption = 'Input Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EditPal: TEdit
      Left = 141
      Top = 13
      Width = 99
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Text = 'Custom'
    end
    object BitBtn1: TBitBtn
      Left = 46
      Top = 46
      Width = 60
      Height = 20
      Caption = 'OK'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn1Click
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 163
      Top = 46
      Width = 60
      Height = 20
      Cancel = True
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn2Click
      NumGlyphs = 2
    end
  end
end
