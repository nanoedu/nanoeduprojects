object SetNewWorkDir: TSetNewWorkDir
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Set new work directory'
  ClientHeight = 86
  ClientWidth = 418
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
    Width = 418
    Height = 86
    Align = alClient
    TabOrder = 0
    object BitBtnOk: TBitBtn
      Left = 136
      Top = 53
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 0
      OnClick = BitBtnOkClick
    end
    object BitBtncancel: TBitBtn
      Left = 272
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = BitBtncancelClick
    end
    object LblEditDir: TLabeledEdit
      Left = 16
      Top = 29
      Width = 377
      Height = 21
      EditLabel.Width = 125
      EditLabel.Height = 13
      EditLabel.Caption = '                  Work directory'
      TabOrder = 2
    end
  end
end
