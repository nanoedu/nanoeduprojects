object AmbulanceHint: TAmbulanceHint
  Left = 572
  Top = 209
  Width = 400
  Height = 300
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderIcons = []
  Color = clWindow
  TransparentColor = True
  TransparentColorValue = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 64
    Top = 40
    Width = 200
    Height = 161
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
    OnMouseDown = Memo1MouseDown
    OnMouseMove = Memo1MouseMove
    OnMouseUp = Memo1MouseUp
  end
  object BitBtnClose: TBitBtn
    Left = 304
    Top = 2
    Width = 25
    Height = 25
    Caption = 'X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtnCloseClick
  end
end
