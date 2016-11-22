object ImgAnalysWnd: TImgAnalysWnd
  Left = 504
  Top = 384
  Caption = 'Image Analysis  '
  ClientHeight = 718
  ClientWidth = 1119
  Color = clBtnFace
  Constraints.MinHeight = 675
  Constraints.MinWidth = 1050
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  OnShortCut = FormShortCut
  PixelsPerInch = 96
  TextHeight = 12
  object PanelRight: TPanel
    Left = 636
    Top = 0
    Width = 483
    Height = 718
    Align = alRight
    Caption = 'PanelRight'
    TabOrder = 0
    ExplicitLeft = 628
    ExplicitHeight = 710
    object PageControlResults: TPageControl
      Left = 1
      Top = 1
      Width = 481
      Height = 716
      ActivePage = TabSheetAutoLin
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnChange = PageControlResultsChange
      ExplicitHeight = 708
      object TabSheetRoughness: TTabSheet
        Caption = 'Roughness '
        ExplicitHeight = 680
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 473
          Height = 267
          Align = alTop
          TabOrder = 0
          object HistChart: TChart
            Left = 1
            Top = 1
            Width = 471
            Height = 265
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Legend.Visible = False
            Title.Text.Strings = (
              'TChart')
            BottomAxis.LabelsSeparation = 20
            LeftAxis.GridCentered = True
            LeftAxis.LabelsSeparation = 20
            LeftAxis.TickOnLabelsOnly = False
            LeftAxis.Title.Caption = 'Counts'
            View3D = False
            Align = alClient
            TabOrder = 0
            object Series2: TBarSeries
              Marks.Callout.Brush.Color = clBlack
              Marks.Visible = False
              SeriesColor = 10485760
              Gradient.Direction = gdTopBottom
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Bar'
              YValues.Order = loNone
            end
            object Series7: TAreaSeries
              Marks.Callout.Brush.Color = clBlack
              Marks.Visible = False
              SeriesColor = 10485760
              DrawArea = True
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
        object Panel5: TPanel
          Left = 0
          Top = 267
          Width = 393
          Height = 188
          TabOrder = 1
          object RichEdit1: TRichEdit
            Left = 19
            Top = 28
            Width = 282
            Height = 136
            Lines.Strings = (
              '')
            TabOrder = 0
          end
        end
      end
      object tabSheetSpectr: TTabSheet
        Caption = 'Fourier Spectrum'
        ImageIndex = 1
        ExplicitHeight = 680
        object PanelFourier: TPanel
          Left = 0
          Top = 47
          Width = 473
          Height = 494
          Hint = 'Draw  selected area by mouse'
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          ExplicitHeight = 486
          object SpectrumChart: TChart
            Left = 0
            Top = 0
            Width = 467
            Height = 404
            Hint = 'Draw  selected area by mouse'
            BackImage.Inside = True
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Legend.Visible = False
            Title.Text.Strings = (
              '')
            BottomAxis.Automatic = False
            BottomAxis.AutomaticMaximum = False
            BottomAxis.AutomaticMinimum = False
            BottomAxis.Maximum = 25.000000000000000000
            LeftAxis.AxisValuesFormat = '#,##0.####'
            View3D = False
            Zoom.Allow = False
            OnAfterDraw = SpectrumChartAfterDraw
            BevelOuter = bvNone
            TabOrder = 0
            OnMouseDown = SpectrumChartMouseDown
            OnMouseMove = SpectrumChartMouseMove
            OnMouseUp = SpectrumChartMouseUp
            PrintMargins = (
              15
              7
              15
              7)
            object Series3: TLineSeries
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
        object PanelSpecTools: TPanel
          Left = 0
          Top = 0
          Width = 473
          Height = 47
          Align = alTop
          Color = clSilver
          ParentBackground = False
          TabOrder = 1
          object SpeedBtnFreq: TSpeedButton
            Left = 7
            Top = 5
            Width = 64
            Height = 30
            Hint = 'Frequence '
            GroupIndex = 1
            Down = True
            Caption = 'Freq'
            OnClick = SpeedBtnFreqClick
          end
          object SpeedBtnAngle: TSpeedButton
            Left = 75
            Top = 5
            Width = 42
            Height = 30
            Hint = 'Angle'
            GroupIndex = 1
            Glyph.Data = {
              76060000424D7606000000000000360000002800000014000000140000000100
              20000000000040060000120B0000120B00000000000000000000E6E6E619DCDC
              DC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDC
              DC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDC
              DC23E5E5E51AF6F6F609507787FF3E677AFF3E677AFF3E677AFF3E677AFF3E67
              7AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFF3E67
              7AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFFE5E5E51AF1F1F10E749B
              A7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFF89ABB7FFCDE8EFFFCDE8EFFF9CC0
              CCFFCDE8EFFFCDE8EFFF89ABB7FFCDE8EFFFCDE8EFFF9CC0CCFFCDE8EFFFCDE8
              EFFF3E677AFFDCDCDC23FDFDFD02EFEFEF10749BA7FFDEF2F7FF89ABB7FFCDE8
              EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8
              EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FDFD
              FD02ECECEC13749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8
              EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF89AB
              B7FF3E677AFFDCDCDC23FFFFFF00FFFFFF00FDFDFD02EDEDED12749BA7FFDEF2
              F7FF9CC0CCFFCDE8EFFFCDE8EFFF2E596EFF6A8F9FFF6A8F9FFF6A8F9FFF6A8F
              9FFF6A8F9FFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FDFDFD02ECECEC13749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8
              EFFF2E596EFFB9B9B946E6E6E619F3F3F30C6A8F9FFFCDE8EFFFCDE8EFFFCDE8
              EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EDED
              ED12749BA7FFDEF2F7FF89ABB7FFCDE8EFFFCDE8EFFF2E596EFFD6D6D629E1E1
              E11E6A8F9FFFCDE8EFFFCDE8EFFF9CC0CCFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EDEDED12749BA7FFDEF2F7FFCDE8
              EFFFCDE8EFFFCDE8EFFF2E596EFFB4B4B44B6A8F9FFFCDE8EFFFCDE8EFFFCDE8
              EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FDFDFD02EFEFEF10749BA7FFDEF2F7FF9CC0CCFFCDE8EFFFCDE8EFFF2E59
              6EFF6A8F9FFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F1F1F10E749B
              A7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFCDE8EFFFCDE8EFFF89AB
              B7FF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FEFEFE01F1F1F10E749BA7FFDEF2F7FF89ABB7FFCDE8
              EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
              FE01F1F1F10E749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8
              EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EFEFEF10749BA7FFDEF2
              F7FF9CC0CCFFCDE8EFFFCDE8EFFF9CC0CCFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FDFDFD02EEEEEE11749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8
              EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EBEB
              EB14749BA7FFDEF2F7FF89ABB7FFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02E8E8E817749BA7FFDEF2F7FFCDE8
              EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FDFDFD02E7E7E718749BA7FFDEF2F7FF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02E8E8E817749B
              A7FF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FDFDFD02E8E8E817507787FFE6E6E619}
            OnClick = SpeedBtnAngleClick
          end
          object LabelInfoSpectr: TLabel
            Left = 309
            Top = 11
            Width = 3
            Height = 13
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object SpeedButton1: TSpeedButton
            Left = 120
            Top = 5
            Width = 93
            Height = 30
            Hint = 'Fourier Filtration'
            GroupIndex = 1
            Caption = 'Filtration'
            OnClick = SpeedButton1Click
          end
          object SpeedButton3: TSpeedButton
            Left = 275
            Top = 5
            Width = 27
            Height = 30
            Hint = 'Grid Visible'
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFF00FFF00F
              FF00FFFF0000FFFF00FFF00FFF00FFFF0000FFFF00FFF00FFF00FFFF0000FFFF
              00FFF00FFF00FFFF0000FFFF00FFF00FFF00FFFF000000000000000000000000
              0000000000000000000000000000FFFF00FFF00FFF00FFFF0000FFFF00FFF00F
              FF00FFFF0000FFFF00FFF00FFF00FFFF00000000000000000000000000000000
              00000000000000000000FFFF00FFF00FFF00FFFF0000FFFF00FFF00FFF00FFFF
              0000FFFF00FFF00FFF00FFFF0000000000000000000000000000000000000000
              000000000000FFFF00FFF00FFF00FFFF0000FFFF00FFF00FFF00FFFF0000FFFF
              00FFF00FFF00FFFF0000}
            OnClick = SpeedButton3Click
          end
          object BitBtnZoomIn: TBitBtn
            Left = 216
            Top = 5
            Width = 29
            Height = 30
            Hint = 'Zoom In'
            TabOrder = 0
            OnClick = BitBtnZoomInClick
            Glyph.Data = {
              72010000424D7201000000000000760000002800000015000000150000000100
              040000000000FC00000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777000007777777777777777770000007777777777777777700070007777
              7777777777770007700077777788888777700077700077778000000087000777
              7000777008777778000077777000770877799977780777777000780777799977
              7708777770007087777999777780777770008077777999777770877770008079
              9999999999708777700080799999999999708777700080799999999999708777
              7000807777799977777087777000708777799977778077777000780777799977
              7708777770007708777999777807777770007770087777780077777770007777
              80008000877777777000777777888887777777777000}
          end
          object BitBtnZoomOut: TBitBtn
            Left = 245
            Top = 5
            Width = 30
            Height = 30
            Hint = 'Zoom out'
            TabOrder = 1
            OnClick = BitBtnZoomOutClick
            Glyph.Data = {
              72010000424D7201000000000000760000002800000015000000150000000100
              040000000000FC00000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777000007777777777777777770000007777777777777777700070007777
              7777777777770007700077777788888777700077700077778000000087000777
              7000777008777778000077777000770877777777780777777000780777777777
              7708777770007087777777777780777770008077777777777770877770008079
              9999999999708777700080799999999999708777700080799999999999708777
              7000807777777777777087777000708777777777778077777000780777777777
              7708777770007708777777777807777770007770087777780077777770007777
              80008000877777777000777777888887777777777000}
          end
        end
        object PanelindFrq: TPanel
          Left = 0
          Top = 541
          Width = 473
          Height = 147
          Align = alBottom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          ExplicitTop = 533
          object GroupBoxFiltration: TGroupBox
            Left = 9
            Top = 13
            Width = 420
            Height = 127
            Hint = 'Draw  filter area by mouse'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object AddBitBtn: TBitBtn
              Left = 4
              Top = 98
              Width = 84
              Height = 22
              Hint = 'Add Selected Area to the Filter'
              Caption = 'Add'
              TabOrder = 0
              OnClick = AddBitBtnClick
            end
            object GbFiltKoefs: TGroupBox
              Left = 21
              Top = 31
              Width = 318
              Height = 60
              Hint = 'Draw  selected area by mouse'
              TabOrder = 1
              object Label12: TLabel
                Left = 4
                Top = 25
                Width = 49
                Height = 13
                Caption = 'Selected'
              end
              object Label13: TLabel
                Left = 147
                Top = 26
                Width = 63
                Height = 13
                Caption = 'Unselected'
              end
              object Label16: TLabel
                Left = 91
                Top = 7
                Width = 127
                Height = 13
                Caption = 'Frequency Weights for'
              end
              object Label18: TLabel
                Left = 7
                Top = 40
                Width = 27
                Height = 13
                Caption = 'Area'
              end
              object Label19: TLabel
                Left = 149
                Top = 41
                Width = 27
                Height = 13
                Caption = 'Area'
              end
              object EdSelected: TEdit
                Left = 85
                Top = 26
                Width = 38
                Height = 21
                TabOrder = 0
                Text = '1'
                OnKeyPress = EdSelectedKeyPress
              end
              object CbUnselected: TComboBox
                Left = 247
                Top = 26
                Width = 54
                Height = 21
                ItemHeight = 13
                TabOrder = 1
                Text = '0'
                OnKeyPress = CbUnselectedKeyPress
                Items.Strings = (
                  '0'
                  '1')
              end
            end
            object BitBtnExecute: TBitBtn
              Left = 91
              Top = 98
              Width = 96
              Height = 22
              Hint = 'Execute Fourier Filtration'
              Caption = 'Execute'
              TabOrder = 2
              OnClick = BitBtnExecuteClick
            end
            object BitBtnApplyFilt: TBitBtn
              Left = 194
              Top = 97
              Width = 223
              Height = 22
              Hint = 'Apply Filtration to the Source Image'
              Caption = 'Apply to Source Image'
              TabOrder = 3
              OnClick = BitBtnApplyFiltClick
            end
            object BitBtnNewFilt: TBitBtn
              Left = 11
              Top = 11
              Width = 72
              Height = 22
              Hint = 'Build New Selective  Filter'
              Caption = 'Clear'
              TabOrder = 4
              OnClick = BitBtnNewFiltClick
            end
            object BitBtnSaveFltr: TBitBtn
              Left = 269
              Top = 11
              Width = 141
              Height = 22
              Caption = 'Save Filter'
              TabOrder = 5
              OnClick = BitBtnSaveFltrClick
            end
          end
        end
      end
      object TabSheetCalibration: TTabSheet
        Caption = 'Calibration'
        ImageIndex = 2
        ExplicitHeight = 680
        object PanelCalibrTools: TPanel
          Left = 0
          Top = 0
          Width = 473
          Height = 38
          Align = alTop
          Color = clSilver
          ParentBackground = False
          TabOrder = 0
          object SpeedBtnCalibrDist: TSpeedButton
            Left = 9
            Top = 5
            Width = 35
            Height = 30
            Hint = 'Rule'
            AllowAllUp = True
            GroupIndex = 3
            Glyph.Data = {
              76060000424D7606000000000000360000002800000014000000140000000100
              20000000000040060000120B0000120B00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00F6F6F609EDEDED12F6F6F609FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F6F609D3D3D32C2E596EFFD3D3
              D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7
              F708D5D5D52A2E596EFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00F9F9F906DADADA252E596EFFCDE8EFFFCDE8EFFFCDE8
              EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F8F8F8075077
              87FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6
              F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FDFDFD02EFEFEF10749BA7FFDEF2F7FF749BA7FFCDE8
              EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
              FE01F0F0F00F749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E59
              6EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F1F1F10E749BA7FFDEF2
              F7FF89ABB7FFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FEFEFE01F3F3F30C749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8
              EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01F4F4
              F40B749BA7FFDEF2F7FF749BA7FFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3
              D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01F3F3F30C749BA7FFDEF2F7FFCDE8
              EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FEFEFE01F2F2F20D749BA7FFDEF2F7FF89ABB7FFCDE8EFFFCDE8EFFFCDE8
              EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F0F0F00F749B
              A7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6
              F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FDFDFD02EFEFEF10749BA7FFDEF2F7FF749BA7FFCDE8
              EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
              FD02EFEFEF10749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E59
              6EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F1F1F10E749BA7FFDEF2
              F7FF89ABB7FFCDE8EFFFCDE8EFFFCDE8EFFF507787FFEDEDED12FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FDFDFD02F3F3F30C749BA7FFDEF2F7FFCDE8EFFFCDE8EFFF5077
              87FFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01F3F3
              F30C749BA7FFDEF2F7FF507787FFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F3F3F30C749BA7FFD9D9D926F6F6
              F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FDFDFD02FAFAFA05FAFAFA05FFFFFF00FFFFFF00FFFFFF00}
            OnClick = SpeedBtnCalibrDistClick
          end
          object Labeldist: TLabel
            Left = 74
            Top = 9
            Width = 4
            Height = 18
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelScannerNmb: TLabel
            Left = 236
            Top = 9
            Width = 101
            Height = 13
            Caption = 'LabelScannerNmb'
          end
        end
        object Panel1: TPanel
          Left = 0
          Top = 38
          Width = 473
          Height = 374
          Align = alClient
          TabOrder = 1
          ExplicitHeight = 366
          object PanelRightChart: TPanel
            Left = 1
            Top = 1
            Width = 471
            Height = 372
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 364
            object ImgCalibrateChart: TChart
              Left = -4
              Top = 1
              Width = 465
              Height = 358
              Legend.Visible = False
              Title.Text.Strings = (
                '')
              View3D = False
              Zoom.Allow = False
              OnAfterDraw = ImgCalibrateChartAfterDraw
              TabOrder = 0
              OnMouseDown = ImgCalibrateChartMouseDown
              OnMouseMove = ImgCalibrateChartMouseMove
              OnMouseUp = ImgCalibrateChartMouseUp
              PrintMargins = (
                15
                11
                15
                11)
              object Series4: TLineSeries
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
        end
        object PanelCalibration: TPanel
          Left = 0
          Top = 412
          Width = 473
          Height = 276
          Align = alBottom
          TabOrder = 2
          ExplicitTop = 404
          object PanelSensitiv: TPanel
            Left = 1
            Top = 1
            Width = 246
            Height = 274
            Align = alClient
            TabOrder = 0
            object GrBoxSensitivity: TGroupBox
              Left = 1
              Top = 1
              Width = 244
              Height = 272
              Align = alClient
              Caption = 'Sensitivity'
              ParentBackground = False
              TabOrder = 0
              object Label4: TLabel
                Left = 9
                Top = 28
                Width = 13
                Height = 13
                Caption = 'X: '
              end
              object Label5: TLabel
                Left = 9
                Top = 64
                Width = 10
                Height = 13
                Caption = 'Y:'
              end
              object Label7: TLabel
                Left = 88
                Top = 28
                Width = 31
                Height = 13
                Caption = 'nm/V'
              end
              object Label8: TLabel
                Left = 89
                Top = 55
                Width = 31
                Height = 13
                Caption = 'nm/V'
              end
              object EdSensX: TEdit
                Left = 28
                Top = 19
                Width = 55
                Height = 21
                TabOrder = 0
                OnChange = EdSensXChange
                OnKeyPress = EdSensXKeyPress
              end
              object EdSensY: TEdit
                Left = 28
                Top = 55
                Width = 55
                Height = 21
                TabOrder = 1
                OnChange = EdSensYChange
                OnKeyPress = EdSensYKeyPress
              end
              object BitBtnApply: TBitBtn
                Left = 127
                Top = 19
                Width = 94
                Height = 24
                Caption = 'Preview'
                TabOrder = 2
                OnClick = BitBtnApplyClick
              end
              object BitBtnSaveSens: TBitBtn
                Left = 126
                Top = 54
                Width = 95
                Height = 23
                Hint = 'Save Sensitivity  to Ini Files'
                Caption = '&Save'
                TabOrder = 3
                OnClick = BitBtnSaveSensClick
                NumGlyphs = 2
              end
              object BitBtnSetDef: TBitBtn
                Left = 19
                Top = 83
                Width = 182
                Height = 21
                Hint = 'Set Default Sensitivity'
                Caption = 'Load Default'
                TabOrder = 4
                OnClick = BitBtnSetDefClick
              end
            end
          end
          object PanelNonLinCorr: TPanel
            Left = 247
            Top = 1
            Width = 225
            Height = 274
            Align = alRight
            TabOrder = 1
            object GrBoxNonLinCorr: TGroupBox
              Left = 1
              Top = 1
              Width = 223
              Height = 272
              Align = alClient
              Caption = 'Non Linear Correction'
              ParentBackground = False
              TabOrder = 0
              OnClick = GrBoxNonLinCorrClick
              object BitBtnNonLinCorr: TBitBtn
                Left = 128
                Top = 20
                Width = 89
                Height = 24
                Hint = 'Preview Result of Scanner Linearization'
                Caption = 'Preview'
                TabOrder = 0
                OnClick = BitBtnNonLinCorrClick
              end
              object GroupBox2: TGroupBox
                Left = 7
                Top = 20
                Width = 120
                Height = 83
                Caption = 'Non Linear Field'
                TabOrder = 1
                object Label6: TLabel
                  Left = 9
                  Top = 19
                  Width = 10
                  Height = 13
                  Caption = 'X:'
                end
                object Label9: TLabel
                  Left = 9
                  Top = 45
                  Width = 10
                  Height = 13
                  Caption = 'Y:'
                end
                object Label10: TLabel
                  Left = 91
                  Top = 19
                  Width = 18
                  Height = 13
                  Caption = 'nm'
                end
                object Label11: TLabel
                  Left = 91
                  Top = 45
                  Width = 18
                  Height = 13
                  Caption = 'nm'
                end
                object EdNonLinFieldX: TEdit
                  Left = 28
                  Top = 19
                  Width = 55
                  Height = 21
                  TabOrder = 0
                  Text = '25000'
                  OnKeyPress = EdNonLinFieldXKeyPress
                end
                object EdNonLinFieldY: TEdit
                  Left = 28
                  Top = 45
                  Width = 55
                  Height = 21
                  TabOrder = 1
                  Text = 'EdNonLinFieldY'
                  OnKeyPress = EdNonLinFieldYKeyPress
                end
              end
              object BitBtnSave: TBitBtn
                Left = 128
                Top = 53
                Width = 90
                Height = 24
                Hint = 'Save Linearization Curves'
                Caption = 'S&ave'
                Default = True
                ModalResult = 1
                TabOrder = 2
                OnClick = BitBtnSaveClick
                NumGlyphs = 2
              end
            end
          end
        end
      end
      object TabSheetAutoLin: TTabSheet
        Caption = 'Auto Linearization'
        ImageIndex = 3
        ExplicitHeight = 680
        object PanelAutoLinChart: TPanel
          Left = 0
          Top = 0
          Width = 473
          Height = 485
          Align = alClient
          TabOrder = 0
          ExplicitHeight = 477
          object AutoLinChart: TChart
            Left = 1
            Top = 1
            Width = 471
            Height = 483
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Legend.Alignment = laTop
            Legend.Shadow.HorizSize = 0
            Legend.Shadow.VertSize = 0
            Title.Text.Strings = (
              'TChart')
            View3D = False
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 475
            object Series6: TLineSeries
              Marks.Callout.Brush.Color = clBlack
              Marks.Visible = False
              Title = 'NonLinearLine'
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object Series8: TPointSeries
              Marks.Callout.Brush.Color = clBlack
              Marks.Visible = False
              SeriesColor = clYellow
              Title = 'Max Points'
              ClickableLine = False
              Pointer.HorizSize = 2
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.VertSize = 2
              Pointer.Visible = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
          end
        end
        object PanelAutoLin: TPanel
          Left = 0
          Top = 485
          Width = 473
          Height = 203
          Align = alBottom
          TabOrder = 1
          ExplicitTop = 477
          object Bevel1: TBevel
            Left = 2
            Top = 5
            Width = 240
            Height = 183
          end
          object LabelScanMode: TLabel
            Left = 19
            Top = 19
            Width = 58
            Height = 13
            Caption = 'ScanMode'
          end
          object Bevel2: TBevel
            Left = 243
            Top = 5
            Width = 221
            Height = 93
          end
          object LabelSens: TLabel
            Left = 245
            Top = 24
            Width = 60
            Height = 13
            Caption = 'Sensitivity'
          end
          object LabelInitSens: TLabel
            Left = 247
            Top = 45
            Width = 33
            Height = 13
            Caption = 'Initial'
          end
          object LabelCorrSens: TLabel
            Left = 247
            Top = 73
            Width = 56
            Height = 13
            Caption = 'Corrected'
          end
          object Label3: TLabel
            Left = 13
            Top = 36
            Width = 86
            Height = 13
            Caption = 'Grid Period, nm'
          end
          object Label14: TLabel
            Left = 28
            Top = 64
            Width = 91
            Height = 13
            Caption = 'Non Linear Field '
          end
          object Label15: TLabel
            Left = 124
            Top = 83
            Width = 18
            Height = 13
            Caption = 'nm'
          end
          object RadioGrLinDir: TRadioGroup
            Left = 19
            Top = 109
            Width = 118
            Height = 47
            Caption = 'Linearization'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'X'
              'Y')
            TabOrder = 0
            OnClick = RadioGrLinDirClick
          end
          object EdInitSens: TEdit
            Left = 351
            Top = 39
            Width = 59
            Height = 21
            TabOrder = 1
          end
          object EdCorrSens: TEdit
            Left = 350
            Top = 71
            Width = 60
            Height = 21
            TabOrder = 2
          end
          object CheckBoxScanMode: TCheckBox
            Left = 11
            Top = 164
            Width = 234
            Height = 19
            Caption = 'Use for both modes'
            TabOrder = 3
          end
          object BitBtnSaveAutoLin: TBitBtn
            Left = 285
            Top = 128
            Width = 106
            Height = 28
            Caption = 'save'
            TabOrder = 4
            OnClick = BitBtnSaveAutoLinClick
          end
          object EdGridPeriod: TEdit
            Left = 173
            Top = 36
            Width = 48
            Height = 21
            TabOrder = 5
          end
          object EdNonLinField: TEdit
            Left = 36
            Top = 83
            Width = 76
            Height = 21
            TabOrder = 6
          end
        end
      end
    end
  end
  object PanelLeftBot: TPanel
    Left = 0
    Top = 0
    Width = 636
    Height = 718
    Align = alClient
    Caption = 'PanelLeftBot'
    TabOrder = 1
    ExplicitWidth = 628
    ExplicitHeight = 710
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 634
      Height = 709
      ActivePage = TabSheetBackFFT
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnChange = PageControl1Change
      ExplicitWidth = 626
      object TabSheetImage: TTabSheet
        Caption = 'Image'
        ExplicitWidth = 618
        object PanelLeft: TPanel
          Left = 0
          Top = 0
          Width = 626
          Height = 681
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 618
          object PanelImgTools: TPanel
            Left = -2
            Top = -2
            Width = 459
            Height = 43
            Color = clSilver
            ParentBackground = False
            TabOrder = 0
            object SpeedBtnDist: TSpeedButton
              Left = 245
              Top = 8
              Width = 30
              Height = 30
              Hint = 'Rule'
              AllowAllUp = True
              GroupIndex = 2
              Glyph.Data = {
                76060000424D7606000000000000360000002800000014000000140000000100
                20000000000040060000120B0000120B00000000000000000000FFFFFF00FFFF
                FF00FFFFFF00F6F6F609EDEDED12F6F6F609FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F6F609D3D3D32C2E596EFFD3D3
                D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7
                F708D5D5D52A2E596EFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00F9F9F906DADADA252E596EFFCDE8EFFFCDE8EFFFCDE8
                EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F8F8F8075077
                87FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6
                F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FDFDFD02EFEFEF10749BA7FFDEF2F7FF749BA7FFCDE8
                EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
                FE01F0F0F00F749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E59
                6EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F1F1F10E749BA7FFDEF2
                F7FF89ABB7FFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FEFEFE01F3F3F30C749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8
                EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01F4F4
                F40B749BA7FFDEF2F7FF749BA7FFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3
                D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01F3F3F30C749BA7FFDEF2F7FFCDE8
                EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FEFEFE01F2F2F20D749BA7FFDEF2F7FF89ABB7FFCDE8EFFFCDE8EFFFCDE8
                EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F0F0F00F749B
                A7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6
                F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FDFDFD02EFEFEF10749BA7FFDEF2F7FF749BA7FFCDE8
                EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
                FD02EFEFEF10749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E59
                6EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F1F1F10E749BA7FFDEF2
                F7FF89ABB7FFCDE8EFFFCDE8EFFFCDE8EFFF507787FFEDEDED12FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FDFDFD02F3F3F30C749BA7FFDEF2F7FFCDE8EFFFCDE8EFFF5077
                87FFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01F3F3
                F30C749BA7FFDEF2F7FF507787FFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F3F3F30C749BA7FFD9D9D926F6F6
                F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FDFDFD02FAFAFA05FAFAFA05FFFFFF00FFFFFF00FFFFFF00}
              OnClick = SpeedBtnDistClick
            end
            object SpeedBtnAngleImg: TSpeedButton
              Left = 275
              Top = 8
              Width = 30
              Height = 30
              Hint = 'Angle'
              AllowAllUp = True
              GroupIndex = 2
              Glyph.Data = {
                76060000424D7606000000000000360000002800000014000000140000000100
                20000000000040060000120B0000120B00000000000000000000E6E6E619DCDC
                DC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDC
                DC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDC
                DC23E5E5E51AF6F6F609507787FF3E677AFF3E677AFF3E677AFF3E677AFF3E67
                7AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFF3E67
                7AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFFE5E5E51AF1F1F10E749B
                A7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFF89ABB7FFCDE8EFFFCDE8EFFF9CC0
                CCFFCDE8EFFFCDE8EFFF89ABB7FFCDE8EFFFCDE8EFFF9CC0CCFFCDE8EFFFCDE8
                EFFF3E677AFFDCDCDC23FDFDFD02EFEFEF10749BA7FFDEF2F7FF89ABB7FFCDE8
                EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8
                EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FDFD
                FD02ECECEC13749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8
                EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF89AB
                B7FF3E677AFFDCDCDC23FFFFFF00FFFFFF00FDFDFD02EDEDED12749BA7FFDEF2
                F7FF9CC0CCFFCDE8EFFFCDE8EFFF2E596EFF6A8F9FFF6A8F9FFF6A8F9FFF6A8F
                9FFF6A8F9FFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
                FF00FFFFFF00FDFDFD02ECECEC13749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8
                EFFF2E596EFFB9B9B946E6E6E619F3F3F30C6A8F9FFFCDE8EFFFCDE8EFFFCDE8
                EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EDED
                ED12749BA7FFDEF2F7FF89ABB7FFCDE8EFFFCDE8EFFF2E596EFFD6D6D629E1E1
                E11E6A8F9FFFCDE8EFFFCDE8EFFF9CC0CCFF3E677AFFDCDCDC23FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EDEDED12749BA7FFDEF2F7FFCDE8
                EFFFCDE8EFFFCDE8EFFF2E596EFFB4B4B44B6A8F9FFFCDE8EFFFCDE8EFFFCDE8
                EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FDFDFD02EFEFEF10749BA7FFDEF2F7FF9CC0CCFFCDE8EFFFCDE8EFFF2E59
                6EFF6A8F9FFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F1F1F10E749B
                A7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFCDE8EFFFCDE8EFFF89AB
                B7FF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FEFEFE01F1F1F10E749BA7FFDEF2F7FF89ABB7FFCDE8
                EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
                FE01F1F1F10E749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8
                EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EFEFEF10749BA7FFDEF2
                F7FF9CC0CCFFCDE8EFFFCDE8EFFF9CC0CCFF3E677AFFDCDCDC23FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FDFDFD02EEEEEE11749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8
                EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EBEB
                EB14749BA7FFDEF2F7FF89ABB7FFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02E8E8E817749BA7FFDEF2F7FFCDE8
                EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FDFDFD02E7E7E718749BA7FFDEF2F7FF3E677AFFDCDCDC23FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02E8E8E817749B
                A7FF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FDFDFD02E8E8E817507787FFE6E6E619}
            end
            object Labeldistleft: TLabel
              Left = 366
              Top = 17
              Width = 7
              Height = 13
              Caption = 'd'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object SpeedButton5: TSpeedButton
              Left = 157
              Top = 8
              Width = 30
              Height = 30
              Hint = 'Plate Delete'
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFF0000000000000000000000000000000000FFFFFFFFFFFFFF000FFFFFFFFF
                9FFFF000FFFFFFF999FFFF000FFFFF9F9F9FFFF000FFFFFF9FFFFFFF000FFFFF
                9FFFFFFFF000FFFF9FFFFFFFFF000FFF9FFFFFFFFFF000FF9FFFFFFFFFFF000F
                9FFFFFFFFFFFF0009FFFFFFFFFFFFF000FFFFFFFFFFFFFF000FF}
              OnClick = SpeedButton5Click
            end
            object SpeedButton6: TSpeedButton
              Left = 185
              Top = 8
              Width = 31
              Height = 30
              Hint = 'Steps Delete along axies X'
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
                7777000000000000000000000000000000007777777797777777777777799977
                7777777777979797777777777777977777777777777797777777777777779777
                7777777777779777777700000000077777770000000007777777777777700777
                7777777777700777777777777770000000007777777000000000}
              OnClick = SpeedButton6Click
            end
            object SpeedBtnSave: TSpeedButton
              Left = 305
              Top = 8
              Width = 27
              Height = 30
              Hint = 'Save window as graphic file'
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00E5D8CB00A16E3B00808080008C8C8C0099999900A2A2A200A2A2A2009999
                99008C8C8C0080808000A16E3B009C693600B28C6600FF00FF00FF00FF00E5D9
                CC009B683500A16E3B00CCCCCC00CC996600CC996600CCCCCC00CCCCCC00CCCC
                CC00CCCCCC00CCCCCC00A16E3B00CC9966009B683500FF00FF00FF00FF009F6C
                3900CF9C6900AD7A4700D3D3D300BD8A5700BD8A5700D3D3D300D3D3D300D3D3
                D300D3D3D300D3D3D300AD7A4700CF9C69009F6C3900FF00FF00FF00FF00A26F
                3C00D3A06D00BD8A5700DDDDDD00A8754200A8754200DDDDDD00DDDDDD00DDDD
                DD00DDDDDD00DDDDDD00BD8A5700D3A06D00A26F3C00FF00FF00FF00FF00A774
                4100D8A57200CE9B6800E7E7E7009966330099663300E7E7E700E7E7E700E7E7
                E700E7E7E700E7E7E700CE9B6800D8A57200A7744100FF00FF00FF00FF00AB78
                4500DDAA7700DDAA7700EADDD000EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
                EE00EEEEEE00EADDD000DDAA7700DDAA7700AB784500FF00FF00FF00FF00B07D
                4A00E3B07D00E3B07D00E3B07D00E3B07D00E3B07D00E3B07D00E3B07D00E3B0
                7D00E3B07D00E3B07D00E3B07D00E3B07D00B07D4A00FF00FF00FF00FF00B582
                4F00E8B58200D3A06D00CC996600CC996600CC996600CC996600CC996600CC99
                6600CC996600CC996600D3A06D00E8B58200B5824F00FF00FF00FF00FF00BA87
                5400EEBB8800F2D9BF00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEE
                DD00FFEEDD00FFEEDD00F2D9BF00EEBB8800BA875400FF00FF00FF00FF00BE8B
                5800F3C08D00FFF1E400FFF1E400FFF1E400FFF1E400FFF1E400FFF1E400FFF1
                E400FFF1E400FFF1E400FFF1E400F3C08D00BE8B5800FF00FF00FF00FF00C390
                5D00F8C59200FFF6EE00FFF6EE00FFF6EE00FFF6EE00FFF6EE00FFF6EE00FFF6
                EE00FFF6EE00FFF6EE00FFF6EE00F8C59200C3905D00FF00FF00FF00FF00C693
                6000FCC99600FFFCF800FFFCF800FFFCF800FFFCF800FFFCF800FFFCF800FFFC
                F800FFFCF800FFFCF800FFFCF800FCC99600C6936000FF00FF00FF00FF00CA97
                6400FFCC9900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FFCC9900CA976400FF00FF00FF00FF00D8B2
                8C00CF9C6900FFD0A100FFD6AC00FFDCB900FFE2C400FFE6CC00FFE6CC00FFE2
                C400FFDCB900FFD6AC00FFD0A100CF9C6900D8B28C00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
              OnClick = SpeedBtnSaveClick
            end
            object SpeedButton7: TSpeedButton
              Left = 215
              Top = 8
              Width = 30
              Height = 30
              Hint = 'Steps Delete along axies Y'
              Glyph.Data = {
                36050000424D3605000000000000360400002800000010000000100000000100
                08000000000000010000C40E0000C40E00000001000000010000000000000000
                FF00C0C0C0000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000020000020202
                0202020202020202000002000002020202020202020202020000020000020202
                0202020202020202000002000002020202020202020202020000020000020202
                0202020202020202000002000002020102020202020202020000020000020102
                0202020202020202000002000001010101010101000000000000020000020102
                0202020200000000000002000002020102020202000002020202020000020202
                0202020200000202020202000002020202020202000002020202020000020202
                0202020200000202020202000002020202020202000002020202020000020202
                0202020200000202020202000002020202020202000002020202}
              OnClick = SpeedButton7Click
            end
            object Panel3: TPanel
              Left = 1
              Top = 1
              Width = 154
              Height = 41
              Align = alLeft
              BevelInner = bvLowered
              BevelOuter = bvNone
              Color = clSilver
              ParentBackground = False
              TabOrder = 0
              object SpeedButton2: TSpeedButton
                Left = 5
                Top = 16
                Width = 75
                Height = 23
                Hint = 'Average 3x3 Filtration'
                Caption = 'Av 3x3'
                OnClick = SpeedButton2Click
              end
              object SpeedButton4: TSpeedButton
                Left = 85
                Top = 16
                Width = 64
                Height = 23
                Hint = 'Median 3x3 Filtration'
                Caption = 'Median'
                OnClick = SpeedButton4Click
              end
              object Label17: TLabel
                Left = 55
                Top = 1
                Width = 35
                Height = 13
                Caption = 'Filters'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ParentFont = False
              end
            end
            object BitBtnHelp: TBitBtn
              Left = 333
              Top = 8
              Width = 28
              Height = 30
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clGreen
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ModalResult = 5
              ParentFont = False
              TabOrder = 1
              OnClick = BitBtnHelpClick
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000FF00FF001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F00FF00FF0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F00FF00FF00FF00FF001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F00FF00FF00FF00FF001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F00FF00FF00FF00FF001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F00FF00FF00FF00FF00FF00
                FF0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F00FF00FF00FF00
                FF00FF00FF0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F00FF00FF00FF00FF0010945F0010945F00FF00
                FF00FF00FF0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F00FF00FF00FF00FF00FF00FF00FF00
                FF0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F00FF00FF001094
                5F0010945F0010945F0010945F0010945F0010945F0010945F0010945F001094
                5F0010945F0010945F0010945F0010945F0010945F00FF00FF00}
            end
          end
          object PanelLeftChart: TPanel
            Left = 11
            Top = 83
            Width = 390
            Height = 309
            TabOrder = 1
            object PanelZ: TPanel
              Left = 304
              Top = 19
              Width = 70
              Height = 273
              BevelOuter = bvNone
              TabOrder = 0
              object ImageZGrad: TImage
                Left = 13
                Top = 9
                Width = 28
                Height = 228
              end
              object Label1: TLabel
                Left = 0
                Top = 19
                Width = 3
                Height = 13
              end
              object Label2: TLabel
                Left = 0
                Top = 400
                Width = 3
                Height = 13
              end
            end
            object ImgChart: TChart
              Left = 12
              Top = 19
              Width = 300
              Height = 241
              Legend.Visible = False
              MarginRight = 10
              Title.Text.Strings = (
                'TChart')
              View3D = False
              Zoom.Allow = False
              TabOrder = 1
              OnMouseDown = ImgChartMouseDown
              OnMouseMove = ImgChartMouseMove
              OnMouseUp = ImgChartMouseUp
              PrintMargins = (
                15
                10
                15
                10)
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
          object PanelIndPeriod: TPanel
            Left = 33
            Top = 364
            Width = 315
            Height = 47
            TabOrder = 2
          end
        end
      end
      object TabSheetCurves: TTabSheet
        Caption = 'Linearization Curves'
        ImageIndex = 1
        TabVisible = False
        ExplicitWidth = 618
        object PanelChart1: TPanel
          Left = 0
          Top = 0
          Width = 626
          Height = 681
          Align = alClient
          Caption = 'PanelChart1'
          TabOrder = 0
          ExplicitWidth = 618
          object Chart1: TChart
            Left = 1
            Top = 1
            Width = 624
            Height = 679
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Legend.Alignment = laTop
            Legend.ColorWidth = 100
            Legend.Font.Style = [fsBold]
            Legend.Shadow.HorizSize = 0
            Legend.Shadow.VertSize = 0
            Legend.Symbol.Width = 100
            Title.Text.Strings = (
              '')
            View3D = False
            Zoom.Allow = False
            Align = alClient
            TabOrder = 0
            OnMouseDown = Chart1MouseDown
            OnMouseMove = Chart1MouseMove
            OnMouseUp = Chart1MouseUp
            ExplicitWidth = 616
            object SeriesLinX: TLineSeries
              Marks.Callout.Brush.Color = clBlack
              Marks.Visible = False
              Title = '  X     '
              OnClick = SeriesLinXClick
              Pointer.HorizSize = 3
              Pointer.InflateMargins = True
              Pointer.Style = psCircle
              Pointer.VertSize = 3
              Pointer.Visible = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object SeriesLinY: TLineSeries
              Marks.Callout.Brush.Color = clBlack
              Marks.Visible = False
              Title = 'Y'
              OnClick = SeriesLinYClick
              Pointer.HorizSize = 3
              Pointer.InflateMargins = True
              Pointer.Style = psCircle
              Pointer.VertSize = 3
              Pointer.Visible = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
          end
        end
      end
      object TabSheetBackFFT: TTabSheet
        Caption = 'Back Fourier Transform'
        ImageIndex = 2
        ExplicitWidth = 618
        object PanelBackFFT: TPanel
          Left = 19
          Top = 55
          Width = 364
          Height = 337
          TabOrder = 0
          object BackFFTChart: TChart
            Left = 26
            Top = 38
            Width = 313
            Height = 237
            Legend.Visible = False
            MarginRight = 10
            Title.Text.Strings = (
              'TChart')
            View3D = False
            Zoom.Allow = False
            TabOrder = 0
            OnMouseDown = BackFFTChartMouseDown
            OnMouseMove = BackFFTChartMouseMove
            OnMouseUp = BackFFTChartMouseUp
            PrintMargins = (
              15
              19
              15
              19)
            object Series5: TLineSeries
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
        object PanelBackFFTTools: TPanel
          Left = 0
          Top = 0
          Width = 392
          Height = 38
          Color = clSilver
          TabOrder = 1
          object SpeedBtnDistBackFFT: TSpeedButton
            Left = 8
            Top = 5
            Width = 36
            Height = 30
            Hint = 'Rule'
            GroupIndex = 3
            Glyph.Data = {
              76060000424D7606000000000000360000002800000014000000140000000100
              20000000000040060000120B0000120B00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00F6F6F609EDEDED12F6F6F609FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F6F609D3D3D32C2E596EFFD3D3
              D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7
              F708D5D5D52A2E596EFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00F9F9F906DADADA252E596EFFCDE8EFFFCDE8EFFFCDE8
              EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F8F8F8075077
              87FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6
              F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FDFDFD02EFEFEF10749BA7FFDEF2F7FF749BA7FFCDE8
              EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
              FE01F0F0F00F749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E59
              6EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F1F1F10E749BA7FFDEF2
              F7FF89ABB7FFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FEFEFE01F3F3F30C749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8
              EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01F4F4
              F40B749BA7FFDEF2F7FF749BA7FFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3
              D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01F3F3F30C749BA7FFDEF2F7FFCDE8
              EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FEFEFE01F2F2F20D749BA7FFDEF2F7FF89ABB7FFCDE8EFFFCDE8EFFFCDE8
              EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F0F0F00F749B
              A7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6
              F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FDFDFD02EFEFEF10749BA7FFDEF2F7FF749BA7FFCDE8
              EFFFCDE8EFFFCDE8EFFF2E596EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
              FD02EFEFEF10749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF2E59
              6EFFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F1F1F10E749BA7FFDEF2
              F7FF89ABB7FFCDE8EFFFCDE8EFFFCDE8EFFF507787FFEDEDED12FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FDFDFD02F3F3F30C749BA7FFDEF2F7FFCDE8EFFFCDE8EFFF5077
              87FFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01F3F3
              F30C749BA7FFDEF2F7FF507787FFD3D3D32CF6F6F609FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F3F3F30C749BA7FFD9D9D926F6F6
              F609FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FDFDFD02FAFAFA05FAFAFA05FFFFFF00FFFFFF00FFFFFF00}
          end
          object SpeedBtnAngleBackFFT: TSpeedButton
            Left = 44
            Top = 5
            Width = 36
            Height = 30
            Hint = 'Angle'
            GroupIndex = 3
            Glyph.Data = {
              76060000424D7606000000000000360000002800000014000000140000000100
              20000000000040060000120B0000120B00000000000000000000E6E6E619DCDC
              DC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDC
              DC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDCDC23DCDC
              DC23E5E5E51AF6F6F609507787FF3E677AFF3E677AFF3E677AFF3E677AFF3E67
              7AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFF3E67
              7AFF3E677AFF3E677AFF3E677AFF3E677AFF3E677AFFE5E5E51AF1F1F10E749B
              A7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFF89ABB7FFCDE8EFFFCDE8EFFF9CC0
              CCFFCDE8EFFFCDE8EFFF89ABB7FFCDE8EFFFCDE8EFFF9CC0CCFFCDE8EFFFCDE8
              EFFF3E677AFFDCDCDC23FDFDFD02EFEFEF10749BA7FFDEF2F7FF89ABB7FFCDE8
              EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8
              EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FDFD
              FD02ECECEC13749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8
              EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF89AB
              B7FF3E677AFFDCDCDC23FFFFFF00FFFFFF00FDFDFD02EDEDED12749BA7FFDEF2
              F7FF9CC0CCFFCDE8EFFFCDE8EFFF2E596EFF6A8F9FFF6A8F9FFF6A8F9FFF6A8F
              9FFF6A8F9FFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FDFDFD02ECECEC13749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8
              EFFF2E596EFFB9B9B946E6E6E619F3F3F30C6A8F9FFFCDE8EFFFCDE8EFFFCDE8
              EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EDED
              ED12749BA7FFDEF2F7FF89ABB7FFCDE8EFFFCDE8EFFF2E596EFFD6D6D629E1E1
              E11E6A8F9FFFCDE8EFFFCDE8EFFF9CC0CCFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EDEDED12749BA7FFDEF2F7FFCDE8
              EFFFCDE8EFFFCDE8EFFF2E596EFFB4B4B44B6A8F9FFFCDE8EFFFCDE8EFFFCDE8
              EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FDFDFD02EFEFEF10749BA7FFDEF2F7FF9CC0CCFFCDE8EFFFCDE8EFFF2E59
              6EFF6A8F9FFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02F1F1F10E749B
              A7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFF2E596EFFCDE8EFFFCDE8EFFF89AB
              B7FF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FEFEFE01F1F1F10E749BA7FFDEF2F7FF89ABB7FFCDE8
              EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
              FE01F1F1F10E749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8EFFFCDE8EFFFCDE8
              EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EFEFEF10749BA7FFDEF2
              F7FF9CC0CCFFCDE8EFFFCDE8EFFF9CC0CCFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FDFDFD02EEEEEE11749BA7FFDEF2F7FFCDE8EFFFCDE8EFFFCDE8
              EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02EBEB
              EB14749BA7FFDEF2F7FF89ABB7FFCDE8EFFF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02E8E8E817749BA7FFDEF2F7FFCDE8
              EFFF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FDFDFD02E7E7E718749BA7FFDEF2F7FF3E677AFFDCDCDC23FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD02E8E8E817749B
              A7FF3E677AFFDCDCDC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FDFDFD02E8E8E817507787FFE6E6E619}
          end
          object LabelInfoBackFFT: TLabel
            Left = 217
            Top = 15
            Width = 4
            Height = 18
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object SpeedBtnSave2: TSpeedButton
            Left = 80
            Top = 5
            Width = 35
            Height = 30
            Hint = 'Save window as graphic file'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00E5D8CB00A16E3B00808080008C8C8C0099999900A2A2A200A2A2A2009999
              99008C8C8C0080808000A16E3B009C693600B28C6600FF00FF00FF00FF00E5D9
              CC009B683500A16E3B00CCCCCC00CC996600CC996600CCCCCC00CCCCCC00CCCC
              CC00CCCCCC00CCCCCC00A16E3B00CC9966009B683500FF00FF00FF00FF009F6C
              3900CF9C6900AD7A4700D3D3D300BD8A5700BD8A5700D3D3D300D3D3D300D3D3
              D300D3D3D300D3D3D300AD7A4700CF9C69009F6C3900FF00FF00FF00FF00A26F
              3C00D3A06D00BD8A5700DDDDDD00A8754200A8754200DDDDDD00DDDDDD00DDDD
              DD00DDDDDD00DDDDDD00BD8A5700D3A06D00A26F3C00FF00FF00FF00FF00A774
              4100D8A57200CE9B6800E7E7E7009966330099663300E7E7E700E7E7E700E7E7
              E700E7E7E700E7E7E700CE9B6800D8A57200A7744100FF00FF00FF00FF00AB78
              4500DDAA7700DDAA7700EADDD000EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
              EE00EEEEEE00EADDD000DDAA7700DDAA7700AB784500FF00FF00FF00FF00B07D
              4A00E3B07D00E3B07D00E3B07D00E3B07D00E3B07D00E3B07D00E3B07D00E3B0
              7D00E3B07D00E3B07D00E3B07D00E3B07D00B07D4A00FF00FF00FF00FF00B582
              4F00E8B58200D3A06D00CC996600CC996600CC996600CC996600CC996600CC99
              6600CC996600CC996600D3A06D00E8B58200B5824F00FF00FF00FF00FF00BA87
              5400EEBB8800F2D9BF00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEE
              DD00FFEEDD00FFEEDD00F2D9BF00EEBB8800BA875400FF00FF00FF00FF00BE8B
              5800F3C08D00FFF1E400FFF1E400FFF1E400FFF1E400FFF1E400FFF1E400FFF1
              E400FFF1E400FFF1E400FFF1E400F3C08D00BE8B5800FF00FF00FF00FF00C390
              5D00F8C59200FFF6EE00FFF6EE00FFF6EE00FFF6EE00FFF6EE00FFF6EE00FFF6
              EE00FFF6EE00FFF6EE00FFF6EE00F8C59200C3905D00FF00FF00FF00FF00C693
              6000FCC99600FFFCF800FFFCF800FFFCF800FFFCF800FFFCF800FFFCF800FFFC
              F800FFFCF800FFFCF800FFFCF800FCC99600C6936000FF00FF00FF00FF00CA97
              6400FFCC9900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FFCC9900CA976400FF00FF00FF00FF00D8B2
              8C00CF9C6900FFD0A100FFD6AC00FFDCB900FFE2C400FFE6CC00FFE6CC00FFE2
              C400FFDCB900FFD6AC00FFD0A100CF9C6900D8B28C00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            OnClick = SpeedBtnSaveClick
          end
        end
      end
      object TabSheetAutoLinCurve: TTabSheet
        Caption = 'Autolinearization  Curve'
        ImageIndex = 3
        TabVisible = False
        ExplicitWidth = 618
        object ChartCorrLine: TChart
          Left = 0
          Top = 0
          Width = 626
          Height = 347
          BackWall.Brush.Color = clWhite
          BackWall.Brush.Style = bsClear
          Legend.Visible = False
          MarginRight = 10
          Title.Text.Strings = (
            'TChart')
          View3D = False
          Zoom.Allow = False
          Align = alTop
          TabOrder = 0
          ExplicitWidth = 618
          object Series9: TLineSeries
            Marks.Callout.Brush.Color = clBlack
            Marks.Visible = False
            Pointer.HorizSize = 3
            Pointer.InflateMargins = True
            Pointer.Style = psCircle
            Pointer.VertSize = 3
            Pointer.Visible = True
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
        end
        object PanelStatistics: TPanel
          Left = 0
          Top = 347
          Width = 626
          Height = 334
          Align = alClient
          TabOrder = 1
          ExplicitWidth = 618
          object LabelDistStat: TLabel
            Left = 19
            Top = 9
            Width = 76
            Height = 13
            Caption = 'LabelDistStat'
          end
          object LabelNDistStat: TLabel
            Left = 19
            Top = 45
            Width = 83
            Height = 13
            Caption = 'LabelNDistStat'
          end
        end
      end
    end
  end
  object ImAnalSaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 361
    Top = 70
  end
  object siLang1: TsiLang
    Version = '6.5'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 2
    OnChangeLanguage = siLang1ChangeLanguage
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Russian')
    Language = 'English'
    ExcludedProperties.Strings = (
      'Category'
      'SecondaryShortCuts'
      'HelpKeyword'
      'InitialDir'
      'HelpKeyword'
      'ActivePage'
      'ImeName'
      'DefaultExt'
      'FileName'
      'FieldName'
      'PickList'
      'DisplayFormat'
      'EditMask'
      'KeyList'
      'LookupDisplayFields'
      'DropDownSpecRow'
      'TableName'
      'DatabaseName'
      'IndexName'
      'MasterFields')
    Left = 216
    Top = 520
    TranslationData = {
      737443617074696F6E730D0A54496D67416E616C7973576E6401496D61676520
      416E616C79736973202001C0EDE0EBE8E720F1EAE0EDEEE220010D0A50616E65
      6C52696768740150616E656C526967687401010D0A5461625368656574526F75
      67686E65737301526F7567686E6573732001D8E5F0EEF5EEE2E0F2EEF1F2FC20
      010D0A746162536865657453706563747201466F757269657220537065637472
      756D01D4F3F0FCE520F1EFE5EAF2F0010D0A537065656442746E467265710146
      72657101D7E0F1F2EEF2E0010D0A5370656564427574746F6E310146696C7472
      6174696F6E01D4E8EBFCF2F0E0F6E8FF010D0A41646442697442746E01416464
      01C4EEE1E0E2E8F2FC010D0A4C6162656C31320153656C656374656401C2FBE1
      F0E0EDEDE0FF010D0A4C6162656C313301556E73656C656374656401CDE5E2FB
      E1F0E0EDEDE0FF010D0A42697442746E45786563757465014578656375746501
      C2FBEFEEEBEDE8F2FC010D0A42697442746E4170706C7946696C74014170706C
      7920746F20536F7572636520496D61676501CFF0E8ECE5EDE8F2FC20EA20E8F1
      F5EEE4EDEEECF320F1EAE0EDF3010D0A42697442746E4E657746696C7401436C
      65617201CEF7E8F1F2E8F2FC010D0A42697442746E53617665466C7472015361
      76652046696C74657201D1EEF5F0E0EDE8F2FC20F4E8EBFCF2F0010D0A546162
      536865657443616C6962726174696F6E0143616C6962726174696F6E01CAE0EB
      E8E1F0EEE2EAE0010D0A4C6162656C5363616E6E65724E6D62014C6162656C53
      63616E6E65724E6D6201010D0A4772426F7853656E7369746976697479015365
      6E736974697669747901D7F3E2F1F2E2E8F2E5EBFCEDEEF1F2FC010D0A4C6162
      656C3401583A2001010D0A4C6162656C3501593A01010D0A4C6162656C37016E
      6D2F5601EDEC2FC2010D0A4C6162656C38016E6D2F5601EDEC2FC2010D0A4269
      7442746E4170706C79015072657669657701CFF0EEF1ECEEF2F0010D0A426974
      42746E5361766553656E7301265361766501D1EEF5F0E0EDE8F2FC010D0A4269
      7442746E536574446566014C6F61642044656661756C7401C7E0E3F0F3E7E8F2
      FC20EFEE20F3ECEEEBF7E0EDE8FE010D0A4772426F784E6F6E4C696E436F7272
      014E6F6E204C696E65617220436F7272656374696F6E01CAEEF0F0E5EAF6E8FF
      20EDE5EBE8EDE5E9EDEEF1F2E8010D0A42697442746E4E6F6E4C696E436F7272
      015072657669657701CFF0EEF1ECEEF2F0010D0A47726F7570426F7832014E6F
      6E204C696E656172204669656C6401CEE1EBE0F1F2FC20EDE5EBE8EDE5E9EDEE
      F1F2E8010D0A4C6162656C3601583A01010D0A4C6162656C3901593A01010D0A
      4C6162656C3130016E6D01EDEC010D0A4C6162656C3131016E6D01EDEC010D0A
      42697442746E5361766501532661766501D1EEF5F0E0EDE8F2FC010D0A546162
      53686565744175746F4C696E014175746F204C696E656172697A6174696F6E01
      C0E2F2EEEBE8EDE5E0F0E8E7E0F6E8FF010D0A4C6162656C5363616E4D6F6465
      015363616E4D6F646501D1EAE0ED20ECEEE4E0010D0A4C6162656C53656E7301
      53656E736974697669747901D7F3E2F1F2E2E8F2E5EBFCEDEEF1F2FC010D0A4C
      6162656C496E697453656E7301496E697469616C01CFE5F0E2EEEDE0F7E0EBFC
      EDE0FF010D0A4C6162656C436F727253656E7301436F7272656374656401C8F1
      EFF0E0E2EBE5EDEDE0FF010D0A4C6162656C33014772696420506572696F642C
      206E6D01CFE5F0E8EEE420F0E5F8E5F2EAE82C20EDEC010D0A4C6162656C3134
      014E6F6E204C696E656172204669656C642001CEE1EBE0F1F2FC20EDE5EBE8ED
      E5E9EDEEF1F2E8010D0A4C6162656C3135016E6D01EDEC010D0A526164696F47
      724C696E446972014C696E656172697A6174696F6E01CBE8EDE5E0F0E8E7E0F6
      E8FF010D0A436865636B426F785363616E4D6F64650155736520666F7220626F
      7468206D6F64657301C8F1EFEEEBFCE7EEE2E0F2FC20E220EEE1E5E8F520ECEE
      E4E0F5010D0A42697442746E536176654175746F4C696E01646501D1EEF5F0E0
      EDE8F2FC010D0A50616E656C4C656674426F740150616E656C4C656674426F74
      01010D0A5461625368656574496D61676501496D61676501D1EAE0ED010D0A4C
      6162656C646973746C656674016401010D0A5461625368656574437572766573
      014C696E656172697A6174696F6E2043757276657301CAF0E8E2FBE520EBE8ED
      E5E0F0E8E7E0F6E8E8010D0A50616E656C4368617274310150616E656C436861
      72743101010D0A54616253686565744261636B464654014261636B20466F7572
      696572205472616E73666F726D01CEE1F0E0F2EDEEE520EFF0E5EEE1F0E0E7EE
      E2E0EDE8E520D4F3F0FCE5010D0A54616253686565744175746F4C696E437572
      7665014175746F6C696E656172697A6174696F6E2020437572766501CAF0E8E2
      E0FF20E0E2F2EEEBE8EDE5E0F0E8E7E0F6E8E8010D0A4C6162656C4469737453
      746174014C6162656C446973745374617401010D0A4C6162656C4E4469737453
      746174014C6162656C4E446973745374617401010D0A4C6162656C3136014672
      657175656E6379205765696768747320666F7201C2E5F1EEE2FBE520EAEEFDF4
      F4E8F6E8E5EDF2FB010D0A5370656564427574746F6E320141762033783301CE
      E4EDEEF0EEE42E010D0A5370656564427574746F6E34014D656469616E01CCE5
      E4E8E0ED2E010D0A4C6162656C31370146696C7465727301D4E8EBFCF2F0FB01
      0D0A4C6162656C3138014172656101EEE1EBE0F1F2FC010D0A4C6162656C3139
      014172656101EEE1EBE0F1F2FC010D0A737448696E74730D0A50616E656C466F
      75726965720144726177202073656C65637465642061726561206279206D6F75
      736501CDE0F0E8F1F3E9F2E520E2FBE4E5EBE5EDEDF3FE20EEE1EBE0F1F2FC20
      F120EFEEECEEF9FCFE20ECFBF8EAE8010D0A537065637472756D436861727401
      44726177202073656C65637465642061726561206279206D6F75736501CDE0F0
      E8F1F3E9F2E520E2FBE4E5EBE5EDEDF3FE20EEE1EBE0F1F2FC20F120EFEEECEE
      F9FCFE20ECFBF8EAE8010D0A537065656442746E46726571014672657175656E
      63652001D7E0F1F2EEF2E0010D0A537065656442746E416E676C6501416E676C
      6501D3E3EEEB010D0A5370656564427574746F6E3101466F7572696572204669
      6C74726174696F6E01D4F3F0FCE520F4E8EBFCF2F0E0F6E8FF010D0A53706565
      64427574746F6E3301477269642056697369626C6501CEF2EEE1F0E0E6E0F2FC
      20F1E5F2EAF3010D0A42697442746E5A6F6F6D496E015A6F6F6D20496E01C7F3
      EC202B010D0A42697442746E5A6F6F6D4F7574015A6F6F6D206F757401C7F3EC
      202D010D0A47726F7570426F7846696C74726174696F6E014472617720206669
      6C7465722061726561206279206D6F75736501010D0A41646442697442746E01
      4164642053656C6563746564204172656120746F207468652046696C74657201
      C4EEE1E0E2E8F2FC20E2FBE1F0E0EDEDF3FE20EEFEEBE0F1F2FC20EA20F4E8EB
      FCF2F0F3010D0A476246696C744B6F6566730144726177202073656C65637465
      642061726561206279206D6F75736501CDE0F0E8F1F3E9F2E520E2FBE4E5EBE5
      EDEDF3FE20EEE1EBE0F1F2FC20F120EFEEECEEF9FCFE20ECFBF8EAE8010D0A42
      697442746E45786563757465014578656375746520466F75726965722046696C
      74726174696F6E01C2FBEFEEEBEDE8F2FC20D4F3F0FCE520F4E8EBFCF2F0E0F6
      E8FE010D0A42697442746E4170706C7946696C74014170706C792046696C7472
      6174696F6E20746F2074686520536F7572636520496D61676501CFF0E8ECE5ED
      E8F2FC20F4E8EBFCF2F020EA20EFE5F0E2EEEDE0F7E0EBFCEDEEECF3F320F1EA
      E0EDF3010D0A42697442746E4E657746696C74014275696C64204E6577205365
      6C656374697665202046696C74657201CFEEF1F2F0EEE8F2FC20EDEEE2FBE920
      F1E5EBE5EAF2E8E2EDFBE920F4E8EBFCF2F0010D0A537065656442746E43616C
      696272446973740152756C6501CBE8EDE5E9EAE0010D0A42697442746E536176
      6553656E7301536176652053656E73697469766974792020746F20496E692046
      696C657301D1EEF5F0E0EDE8F2FC20F7F3E2F1F2E2E8F2E5EBFCEDEEF1F2FC20
      E220E8EDE820F4E0E9EB010D0A42697442746E53657444656601536574204465
      6661756C742053656E736974697669747901D3F1F2E0EDEEE2E8F2FC20F7F3E2
      F1F2E2E8F2E5EBFCEDEEF1F2FC20EFEE20F3ECEEEBF7E0EDE8FE010D0A426974
      42746E4E6F6E4C696E436F7272015072657669657720526573756C74206F6620
      5363616E6E6572204C696E656172697A6174696F6E01CFF0EEF1ECEEF2F020F0
      E5E7F3EBFCF2E0F2EEE220EBE8EDE5E0F0E8E7E0F6E8E820F1EAE0EDE5F0E001
      0D0A42697442746E536176650153617665204C696E656172697A6174696F6E20
      43757276657301D1EEF5F0E0EDE8F2FC20EAF0E8E2FBE520EBE8EDE5E0F0E8E7
      E0F6E8E8010D0A537065656442746E446973740152756C6501CBE8EDE5E9EAE0
      010D0A537065656442746E416E676C65496D6701416E676C6501D3E3EEEB010D
      0A5370656564427574746F6E3501506C6174652044656C65746501D3E4E0EBE8
      F2FC20EFEBEEF1EAEEF1F2FC010D0A5370656564427574746F6E360153746570
      732044656C65746520616C6F6E67206178696573205801D3E4E0EBE8F2FC20F1
      F2F3EFE5EDFCEAE820E2E4EEEBFC20EEF1E820D5010D0A537065656442746E53
      61766501536176652077696E646F7720617320677261706869632066696C6501
      D1EEF5F0E0EDE8F2FC20EEEAEDEE20EAE0EA20EAE0F0F2E8EDEAF3010D0A5370
      65656442746E446973744261636B4646540152756C6501CBE8EDE5E9EAE0010D
      0A537065656442746E416E676C654261636B46465401416E676C6501D3E3EEEB
      010D0A537065656442746E536176653201536176652077696E646F7720617320
      677261706869632066696C6501D1EEF5F0E0EDE8F2FC20EEEAEDEE20EAE0EA20
      626D7020F4E0E9EB010D0A5370656564427574746F6E32014176657261676520
      3378332046696C74726174696F6E01CEE4EDEEF0EEE4EDFBE920F4E8EBFCF2F0
      2033F533010D0A5370656564427574746F6E34014D656469616E203378332046
      696C74726174696F6E01CCE5E4E8E0EDEDFBE920F4E8EBFCF2F02033F533010D
      0A5370656564427574746F6E370153746570732044656C65746520616C6F6E67
      206178696573205901D3E4E0EBE8F2FC20F1F2F3EFE5EDFCEAE820E2E4EEEBFC
      20EEF1E82059010D0A7374446973706C61794C6162656C730D0A7374466F6E74
      730D0A54496D67416E616C7973576E640144656661756C740144656661756C74
      010D0A50616765436F6E74726F6C526573756C74730144656661756C74014465
      6661756C74010D0A4C6162656C496E666F5370656374720144656661756C7401
      44656661756C74010D0A50616E656C696E644672710144656661756C74014465
      6661756C74010D0A4C6162656C646973740144656661756C740144656661756C
      74010D0A50616765436F6E74726F6C310144656661756C740144656661756C74
      010D0A4C6162656C646973746C6566740144656661756C740144656661756C74
      010D0A4C6162656C496E666F4261636B4646540144656661756C740144656661
      756C74010D0A4C6162656C31370144656661756C740144656661756C74010D0A
      50616E656C466F75726965720144656661756C740144656661756C74010D0A47
      726F7570426F7846696C74726174696F6E0144656661756C740144656661756C
      74010D0A73744D756C74694C696E65730D0A5269636845646974312E4C696E65
      7301222201010D0A4362556E73656C65637465642E4974656D7301302C310101
      0D0A526164696F47724C696E4469722E4974656D7301582C5901010D0A737444
      6C677343617074696F6E730D0A5761726E696E67015761726E696E6701CFF0E5
      E4F3EFF0E5E6E4E5EDE8E5010D0A4572726F72014572726F7201CEF8E8E1EAE0
      010D0A496E666F726D6174696F6E01496E666F726D6174696F6E01C8EDF4EEF0
      ECE0F6E8FF010D0A436F6E6669726D01436F6E6669726D01CFEEF2E2E5F0E6E4
      E5EDE8E5010D0A59657301265965730126C4E0010D0A4E6F01264E6F0126CDE5
      F2010D0A4F4B014F4B0126CECA010D0A43616E63656C0143616E63656C01CE26
      F2ECE5EDE0010D0A41626F7274012641626F727401010D0A5265747279012652
      6574727901010D0A49676E6F7265012649676E6F726501010D0A416C6C012641
      6C6C01010D0A4E6F20546F20416C6C014E266F20746F20416C6C01010D0A5965
      7320546F20416C6C0159657320746F2026416C6C01010D0A48656C7001264865
      6C7001D126EFF0E0E2EAE0010D0A7374537472696E67730D0A4944535F313201
      44697374616E63653D2001D0E0F1F1F2EEFFEDE8E53D010D0A4944535F313301
      416E676C653D2001D3E3EEEB3D010D0A4944535F313801467265713D2001D7E0
      F1F2EEF2E03D010D0A4944535F323001506572696F643D2001CFE5F0E8EEE43D
      010D0A4944535F32310144697374616E63653D20202001D0E0F1F1F2EEFFEDE8
      E53D010D0A4944535F3338014772696420506572696F643D2001CFE5F0E8EEE4
      20F0E5F8E5F2EAE83D010D0A4944535F333901206E6D01EDEC010D0A4944535F
      3431015363616E6E6572202001D1EAE0EDE5F020010D0A4944535F3432012020
      4C696E656172697A6174696F6E202001CBE8EDE5E0F0E8E7E0F6E8FF010D0A49
      44535F34016E6D01EDEC010D0A4944535F350120466F75726965722053706563
      7472756D01D4F3F0FCE520F1EFE5EAF2F0010D0A4944535F3532015265777269
      7465204C696E656172697A6174696F6E2044617461203F01CFE5F0E5EFE8F1E0
      F2FC20E4E0EDEDFBE520EBE8EDE5E0F0E8E7E0F6E8E83F010D0A4944535F3534
      0153656E7369746976697479205801D7F3E2F1F2E2E8F2E5EBFCEDEEF1F2FC20
      D5010D0A4944535F35350153656E7369746976697479205901D7F3E2F1F2E2E8
      F2E5EBFCEDEEF1F2FC2059010D0A4944535F353801526F7567686E6573732041
      76657261676520202001D1F0E5E4EDFFFF20F8E5F0EEF5EEE2E0F2EEF1F2FC20
      010D0A4944535F353901526F6F74204D65616E205371756172652020202001CA
      EEF0E5EDFC20E8E720F1F0E5E4EDE5E3EE20EAE2E0E4F0E0F2E8F7EDEEE3EE20
      010D0A4944535F3601205363616E6E6572202001D1EAE0EDE5F020010D0A4944
      535F3631015363616E4D6F6465205801D1EAE0ED20ECEEE4E020D5010D0A4944
      535F3633015363616E4D6F6465205901D1EAE0ED20ECEEE4E02059010D0A4944
      535F37320146696C653A2001D4E0E9EB3A010D0A4944535F3901496D61676520
      416E616C79736973202001D1EAE0ED20E0EDE0EBE8E72020010D0A7374727374
      7231014572726F7220777269746520666C61736801CEF8E8E1EAE020E7E0EFE8
      F1E820EDE020F4EBE5F8010D0A7374727374723301204E6F2046696C74657220
      54656D706C61746501CDE5F220EEE1F0E0E7F6E020F4E8EBFCF2F0E0010D0A73
      747273747234012046696C65206E6F7420657869737401D4E0E9EB20EDE520F1
      F3F9E5F1F2E2F3E5F2010D0A7374727374723501204F70656E204552524F5221
      01CEF8E8E1EAE020EEF2EAF0FBF2E8FF20F4E0E9EBE0010D0A73747273747236
      0146696C65206973206E6F742046696C7465722054656D706C6174652101D4E0
      E9EB20EDE520FFE2EBFFE5F2F1FF20F4E8EBFCF2F0EEEC010D0A4944535F3201
      496D61676520486973746F6772616D01C3E8F1F2EEE3F0E0ECECE0010D0A7374
      7273747264726177617265610144726177202073656C65637465642061726561
      206279206D6F75736501CDE0F0E8F1F3E9F2E520E2FBE4E5EBE5EDEDF3FE20EE
      E1EBE0F1F2FC20F120EFEEECEEF9FCFE20ECFBF8EAE8010D0A73747273747243
      6F756E747301436F756E747301CEF2F1F7E5F2FB010D0A73744F746865725374
      72696E67730D0A536572696573322E50657263656E74466F726D617401232330
      2E2323202501010D0A536572696573322E56616C7565466F726D617401232C23
      23302E23232301010D0A536572696573372E50657263656E74466F726D617401
      2323302E2323202501010D0A536572696573372E56616C7565466F726D617401
      232C2323302E23232301010D0A536572696573332E50657263656E74466F726D
      6174012323302E2323202501010D0A536572696573332E56616C7565466F726D
      617401232C2323302E23232301010D0A456453656C65637465642E5465787401
      3101010D0A4362556E73656C65637465642E54657874013001010D0A45644E6F
      6E4C696E4669656C64582E5465787401323530303001010D0A45644E6F6E4C69
      6E4669656C64592E546578740145644E6F6E4C696E4669656C645901010D0A53
      6572696573362E50657263656E74466F726D6174012323302E2323202501010D
      0A536572696573362E5469746C65014E6F6E4C696E6561724C696E6501010D0A
      536572696573362E56616C7565466F726D617401232C2323302E23232301010D
      0A536572696573382E50657263656E74466F726D6174012323302E2323202501
      010D0A536572696573382E5469746C65014D617820506F696E747301010D0A53
      6572696573382E56616C7565466F726D617401232C2323302E23232301010D0A
      5365726965734C696E582E50657263656E74466F726D6174012323302E232320
      2501010D0A5365726965734C696E582E5469746C650120205820202020200101
      0D0A5365726965734C696E582E56616C7565466F726D617401232C2323302E23
      232301010D0A5365726965734C696E592E50657263656E74466F726D61740123
      23302E2323202501010D0A5365726965734C696E592E5469746C65015901010D
      0A5365726965734C696E592E56616C7565466F726D617401232C2323302E2323
      2301010D0A536572696573392E50657263656E74466F726D6174012323302E23
      23202501010D0A536572696573392E56616C7565466F726D617401232C232330
      2E23232301010D0A536572696573342E50657263656E74466F726D6174012323
      302E2323202501010D0A536572696573342E56616C7565466F726D617401232C
      2323302E23232301010D0A536572696573312E50657263656E74466F726D6174
      012323302E2323202501010D0A536572696573312E56616C7565466F726D6174
      01232C2323302E23232301010D0A536572696573352E50657263656E74466F72
      6D6174012323302E2323202501010D0A536572696573352E56616C7565466F72
      6D617401232C2323302E23232301010D0A73744C6F63616C65730D0A7374436F
      6C6C656374696F6E730D0A737443686172536574730D0A54496D67416E616C79
      73576E640144454641554C545F43484152534554015255535349414E5F434841
      52534554010D0A50616765436F6E74726F6C526573756C74730144454641554C
      545F43484152534554015255535349414E5F43484152534554010D0A4C616265
      6C496E666F537065637472015255535349414E5F434841525345540152555353
      49414E5F43484152534554010D0A50616E656C696E644672710144454641554C
      545F43484152534554015255535349414E5F43484152534554010D0A4C616265
      6C646973740144454641554C545F43484152534554015255535349414E5F4348
      4152534554010D0A50616765436F6E74726F6C310144454641554C545F434841
      52534554015255535349414E5F43484152534554010D0A4C6162656C64697374
      6C6566740144454641554C545F43484152534554015255535349414E5F434841
      52534554010D0A4C6162656C496E666F4261636B4646540144454641554C545F
      43484152534554015255535349414E5F43484152534554010D0A4C6162656C31
      370144454641554C545F43484152534554015255535349414E5F434841525345
      54010D0A50616E656C466F75726965720144454641554C545F43484152534554
      015255535349414E5F43484152534554010D0A47726F7570426F7846696C7472
      6174696F6E0144454641554C545F43484152534554015255535349414E5F4348
      4152534554010D0A}
  end
  object siLangDispatcher1: TsiLangDispatcher
    ActiveLanguage = 1
    NumOfLanguages = 1
    LangNames.Strings = (
      'Language N1')
    Left = 216
    Top = 464
  end
end
