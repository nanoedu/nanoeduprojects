object FormRenishNomogram: TFormRenishNomogram
  Left = 0
  Top = 0
  Caption = 'FormRenishNomogram'
  ClientHeight = 449
  ClientWidth = 676
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 676
    Height = 43
    TabOrder = 0
    object Label1: TLabel
      Left = 30
      Top = 12
      Width = 28
      Height = 12
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 30
      Top = 26
      Width = 28
      Height = 12
      Caption = 'Label2'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 43
    Width = 676
    Height = 402
    Caption = 'Panel2'
    TabOrder = 1
    object Chart1: TChart
      Left = 6
      Top = -75
      Width = 565
      Height = 478
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      Title.Text.Strings = (
        '')
      View3D = False
      TabOrder = 0
      object Series1: TLineSeries
        Marks.Callout.Brush.Color = clBlack
        Marks.Visible = False
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 296
    Top = 168
  end
end
