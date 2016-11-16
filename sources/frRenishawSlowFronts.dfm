object FormSlowFronts: TFormSlowFronts
  Left = 0
  Top = 0
  Caption = 'Renishaw  slow axis nomogramma '
  ClientHeight = 305
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 584
    Height = 305
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      
        'Distance between neighbouring fronts in Renishaw signal (Slow Ax' +
        'is)')
    BottomAxis.Title.Caption = 'Line number'
    LeftAxis.Title.Caption = 'Distance (discrets)'
    Legend.Visible = False
    View3D = False
    Align = alClient
    TabOrder = 0
    ExplicitTop = 6
    ExplicitWidth = 319
    ExplicitHeight = 211
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
end
