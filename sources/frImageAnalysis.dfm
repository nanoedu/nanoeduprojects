object ImgAnalysWnd: TImgAnalysWnd
  Left = 43
  Top = 409
  Width = 929
  Height = 638
  Caption = 'Image Analysis'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelRight: TPanel
    Left = 384
    Top = 0
    Width = 361
    Height = 481
    Caption = 'PanelRight'
    TabOrder = 0
    object PageControlResults: TPageControl
      Left = 0
      Top = 0
      Width = 353
      Height = 465
      ActivePage = tabSheetSpectr
      TabOrder = 0
      OnChange = PageControlResultsChange
      object TabSheetRoughness: TTabSheet
        Caption = 'Roughness'
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 345
          Height = 235
          Align = alTop
          TabOrder = 0
          object HistChart: TChart
            Left = 1
            Top = 1
            Width = 344
            Height = 233
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Title.Text.Strings = (
              'TChart')
            BottomAxis.LabelsSeparation = 20
            LeftAxis.GridCentered = True
            LeftAxis.LabelsSeparation = 20
            LeftAxis.TickOnLabelsOnly = False
            LeftAxis.Title.Caption = 'Counts'
            Legend.Visible = False
            View3D = False
            TabOrder = 0
            object Series2: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = 10485760
              XValues.DateTime = False
              XValues.Name = 'X'
              XValues.Multiplier = 1.000000000000000000
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1.000000000000000000
              YValues.Order = loNone
            end
          end
        end
        object Panel5: TPanel
          Left = 0
          Top = 235
          Width = 346
          Height = 165
          TabOrder = 1
          object RichEdit1: TRichEdit
            Left = 16
            Top = 24
            Width = 249
            Height = 121
            Lines.Strings = (
              '')
            TabOrder = 0
          end
        end
      end
      object tabSheetSpectr: TTabSheet
        Caption = 'Fourier Spectrum'
        ImageIndex = 1
        object Panel6: TPanel
          Left = 0
          Top = 32
          Width = 321
          Height = 353
          Caption = 'Panel6'
          TabOrder = 0
          object SpectrumChart: TChart
            Left = 8
            Top = 104
            Width = 241
            Height = 257
            AllowZoom = False
            BackImageInside = True
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Title.Text.Strings = (
              '')
            BottomAxis.Automatic = False
            BottomAxis.AutomaticMaximum = False
            BottomAxis.AutomaticMinimum = False
            BottomAxis.Grid.Visible = False
            BottomAxis.Maximum = 25.000000000000000000
            LeftAxis.AxisValuesFormat = '#,##0.####'
            LeftAxis.Grid.Visible = False
            Legend.Visible = False
            View3D = False
            OnAfterDraw = SpectrumChartAfterDraw
            BevelOuter = bvNone
            TabOrder = 0
            OnMouseDown = SpectrumChartMouseDown
            OnMouseMove = SpectrumChartMouseMove
            OnMouseUp = SpectrumChartMouseUp
            object Series3: TLineSeries
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
        object PanelSpecTools: TPanel
          Left = 8
          Top = 0
          Width = 305
          Height = 33
          Color = clSilver
          TabOrder = 1
          object SpeedBtnFreq: TSpeedButton
            Left = 9
            Top = 7
            Width = 41
            Height = 20
            AllowAllUp = True
            GroupIndex = 1
            Caption = 'Freq'
            OnClick = SpeedBtnFreqClick
          end
          object SpeedBtnAngle: TSpeedButton
            Left = 73
            Top = 7
            Width = 42
            Height = 20
            AllowAllUp = True
            GroupIndex = 1
            Glyph.Data = {
              96010000424D9601000000000000760000002800000018000000180000000100
              0400000000002001000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777777777777777777777777777777777777777777777777777777777777
              7777777777777777777777777777777777777777777777777777777777777777
              7777777777777777777777777777700000000000000000000777700000000000
              0000000007777700777777777777997777777770077777777779997777777777
              0077777777799777777777777007777777997777777777777700777777997777
              7777777777700777799777777777777777770077997777777777777777777009
              9777777777777777777777007777777777777777777777700777777777777777
              7777777700777777777777777777777770077777777777777777777777007777
              7777777777777777777777777777777777777777777777777777}
            OnClick = SpeedBtnAngleClick
          end
          object ClearBitBtn: TBitBtn
            Left = 141
            Top = 6
            Width = 42
            Height = 20
            Caption = 'Clear'
            TabOrder = 0
            OnClick = ClearBitBtnClick
          end
        end
        object PanelindFrq: TPanel
          Left = 8
          Top = 396
          Width = 297
          Height = 41
          TabOrder = 2
          object IndicateLabel: TLabel
            Left = 8
            Top = 16
            Width = 5
            Height = 13
          end
        end
      end
    end
  end
  object PanelLeft: TPanel
    Left = 7
    Top = 0
    Width = 371
    Height = 482
    Caption = 'PanelLeft'
    TabOrder = 1
    object PanelImgTools: TPanel
      Left = 0
      Top = 3
      Width = 217
      Height = 33
      Color = clSilver
      TabOrder = 0
      object SpeedBtnDist: TSpeedButton
        Left = 13
        Top = 7
        Width = 38
        Height = 20
        AllowAllUp = True
        GroupIndex = 2
        Glyph.Data = {
          96010000424D9601000000000000760000002800000018000000180000000100
          0400000000002001000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777777777777777777777777777777777777777777777777
          7777777777777777777777777777777777777777777777777777777777777777
          7777777777777777777777777777777777777777777777777777777777777777
          7777777777777777777777777777777777770077777777700777777777000077
          7777777007777777770000777777777007777777770000707070707007070707
          0700007070707070070707070700007070707070070707070700000000000000
          0000000000000000000000000000000000007777777777777777777777777777
          7777777777777777777777777777777777777777777777777777777777777777
          7777777777777777777777777777777777777777777777777777}
      end
      object SpeedBtnAngleImg: TSpeedButton
        Left = 65
        Top = 7
        Width = 38
        Height = 20
        AllowAllUp = True
        GroupIndex = 2
        Glyph.Data = {
          96010000424D9601000000000000760000002800000018000000180000000100
          0400000000002001000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777777777777777777777777777777777777777777777777
          7777777777777777777777777777777777777777777777777777777777777777
          7777777777777777777777777777700000000000000000000777700000000000
          0000000007777700777777777777997777777770077777777779997777777777
          0077777777799777777777777007777777997777777777777700777777997777
          7777777777700777799777777777777777770077997777777777777777777009
          9777777777777777777777007777777777777777777777700777777777777777
          7777777700777777777777777777777770077777777777777777777777007777
          7777777777777777777777777777777777777777777777777777}
      end
      object ClearImgSpeedBtn: TSpeedButton
        Left = 116
        Top = 7
        Width = 38
        Height = 20
        Caption = 'Clear'
        OnClick = ClearImgSpeedBtnClick
      end
    end
    object PanelLeftChart: TPanel
      Left = 10
      Top = 37
      Width = 355
      Height = 392
      TabOrder = 1
      object ImgChart: TChart
        Left = 0
        Top = 112
        Width = 296
        Height = 234
        AllowZoom = False
        BackImageInside = True
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          'TChart')
        BottomAxis.Grid.Visible = False
        LeftAxis.Grid.Visible = False
        Legend.DividingLines.Style = psDash
        Legend.TopPos = 3
        Legend.Visible = False
        View3D = False
        View3DWalls = False
        OnAfterDraw = ImgChartAfterDraw
        BevelOuter = bvNone
        TabOrder = 0
        OnMouseDown = ImgChartMouseDown
        OnMouseMove = ImgChartMouseMove
        OnMouseUp = ImgChartMouseUp
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
      object PanelZ: TPanel
        Left = 306
        Top = 5
        Width = 44
        Height = 381
        BevelOuter = bvNone
        TabOrder = 1
        object ImageZGrad: TImage
          Left = 5
          Top = 52
          Width = 24
          Height = 326
        end
        object Label1: TLabel
          Left = 0
          Top = 16
          Width = 5
          Height = 13
        end
        object Label2: TLabel
          Left = 0
          Top = 400
          Width = 5
          Height = 13
        end
      end
    end
    object PanelIndPeriod: TPanel
      Left = 12
      Top = 434
      Width = 298
      Height = 41
      TabOrder = 2
      object Label3: TLabel
        Left = 32
        Top = 8
        Width = 5
        Height = 13
      end
    end
  end
end
