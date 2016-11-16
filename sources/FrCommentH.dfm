object frComment: TfrComment
  Left = 370
  Top = 431
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Comments Header'
  ClientHeight = 257
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 95
    Height = 16
    Caption = 'SampleMaterial'
  end
  object Label2: TLabel
    Left = 20
    Top = 49
    Width = 67
    Height = 16
    Caption = 'Comments:'
  end
  object OKBtn: TButton
    Left = 252
    Top = 199
    Width = 74
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object edMaterial: TEdit
    Left = 138
    Top = 10
    Width = 149
    Height = 24
    TabOrder = 1
  end
  object CommentMemo: TMemo
    Left = 138
    Top = 57
    Width = 207
    Height = 129
    Lines.Strings = (
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    TabOrder = 2
  end
end
