object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 267
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 414
    Height = 267
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 633
    ExplicitHeight = 553
    object StringGrid1: TStringGrid
      Left = 0
      Top = 16
      Width = 313
      Height = 129
      ColCount = 2
      TabOrder = 0
      ColWidths = (
        64
        227)
    end
    object BitBtnWrite: TBitBtn
      Left = 16
      Top = 176
      Width = 121
      Height = 25
      Caption = 'Write'
      TabOrder = 1
    end
    object BitBtnRead: TBitBtn
      Left = 168
      Top = 176
      Width = 129
      Height = 25
      Caption = 'Read'
      TabOrder = 2
    end
  end
end
