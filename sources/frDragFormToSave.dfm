object DragFormToSave: TDragFormToSave
  Left = 0
  Top = 0
  Caption = 'Drag to save'
  ClientHeight = 213
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 17
  object PanelDrag: TPanel
    Left = 0
    Top = 0
    Width = 224
    Height = 213
    Align = alClient
    TabOrder = 0
    object ImageDrag: TImage
      Left = 1
      Top = 1
      Width = 221
      Height = 211
      Align = alClient
      Stretch = True
      OnMouseDown = ImageDragMouseDown
      OnProgress = ImageDragProgress
    end
  end
end
