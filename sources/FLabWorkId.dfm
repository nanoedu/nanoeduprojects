object FormLabWorkId: TFormLabWorkId
  Left = 546
  Top = 218
  Width = 300
  Height = 200
  Caption = 'Lab Work Id'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 34
    Top = 20
    Width = 220
    Height = 19
    Caption = 'Input Lab Work Identificator'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 15
    Top = 59
    Width = 257
    Height = 21
    TabOrder = 0
  end
  object OKBitBtn: TBitBtn
    Left = 29
    Top = 104
    Width = 80
    Height = 24
    TabOrder = 1
    OnClick = OKBitBtnClick
    Kind = bkOK
  end
  object CancelBitBtn: TBitBtn
    Left = 171
    Top = 103
    Width = 80
    Height = 24
    TabOrder = 2
    OnClick = CancelBitBtnClick
    Kind = bkCancel
  end
end
