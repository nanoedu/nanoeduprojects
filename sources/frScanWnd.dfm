object ScanWnd: TScanWnd
  Left = 88
  Top = 253
  BorderIcons = [biSystemMenu, biHelp]
  Caption = ' Sample surface scanning'
  ClientHeight = 696
  ClientWidth = 1003
  Color = 14474715
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Default'
  Font.Style = [fsBold]
  FormStyle = fsMDIChild
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  ShowHint = True
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 16
  object SpeedButton4: TSpeedButton
    Left = 932
    Top = 312
    Width = 27
    Height = 26
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 1003
    Height = 259
    Align = alTop
    BevelOuter = bvNone
    Color = 14474715
    ParentBackground = False
    TabOrder = 0
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 296
      Height = 259
      Align = alLeft
      BevelOuter = bvNone
      Color = 14474715
      Constraints.MinWidth = 270
      TabOrder = 0
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 296
        Height = 128
        Align = alTop
        BevelOuter = bvLowered
        BorderWidth = 2
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object ToolBarScanWnd: TToolBar
          Left = 3
          Top = 3
          Width = 290
          Height = 122
          Align = alClient
          ButtonHeight = 45
          ButtonWidth = 79
          Caption = 'ToolBarScanWnd'
          Color = clSilver
          Constraints.MaxWidth = 290
          Constraints.MinWidth = 270
          DrawingStyle = dsGradient
          EdgeInner = esNone
          EdgeOuter = esNone
          GradientEndColor = clSilver
          GradientStartColor = 14803425
          Images = Main.ImageList24
          ParentColor = False
          ShowCaptions = True
          TabOrder = 0
          object StartBtn: TToolButton
            Left = 0
            Top = 0
            Caption = '&Start'
            ImageIndex = 8
            Style = tbsCheck
            OnClick = StartBtnClick
          end
          object StopBtn: TToolButton
            Left = 79
            Top = 0
            Caption = 'S&top'
            ImageIndex = 9
            Style = tbsCheck
            OnClick = StopBtnClick
          end
          object RStartBtn: TToolButton
            Left = 158
            Top = 0
            Caption = '&ReStart'
            ImageIndex = 10
            Wrap = True
            OnClick = RStartBtnClick
          end
          object LandingBtn: TToolButton
            Left = 0
            Top = 45
            Caption = ' Landing '
            ImageIndex = 1
            OnClick = LandingBtnClick
          end
          object OptionsBtn: TToolButton
            Left = 79
            Top = 45
            Caption = '   Options   '
            ImageIndex = 4
            OnClick = OptionsBtnClick
          end
          object SaveExpBtn: TToolButton
            Left = 158
            Top = 45
            Caption = 'Save as'
            ImageIndex = 7
            OnClick = ButtonSaveFileClick
          end
        end
      end
      object Panel12: TPanel
        Left = 0
        Top = 128
        Width = 296
        Height = 131
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvNone
        Color = 14474715
        ParentBackground = False
        TabOrder = 1
        object Panel7: TPanel
          Left = 209
          Top = 1
          Width = 86
          Height = 129
          Align = alRight
          BevelOuter = bvNone
          BorderWidth = 3
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMenuText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          object LabelZ: TLabel
            Left = 55
            Top = 3
            Width = 7
            Height = 16
            Caption = 'Z'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object ZIndicatorScan: TRuleMod4
            Left = 16
            Top = 8
            Width = 39
            Height = 70
            ChangeLimits = False
            SFM = False
            flgLevelLimit = False
            NumbLim = 2
            Maximum = 32767
            HighLimit = 0
            LowLimit = 0
            Value = 0
            IndicColor = clNavy
          end
          object Label13: TLabel
            Left = 17
            Top = 3
            Width = 8
            Height = 16
            Caption = '1'
          end
          object LabelZV: TLabel
            Left = 52
            Top = 40
            Width = 4
            Height = 16
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object CheckBoxDrift: TCheckBox
          Left = 4
          Top = 63
          Width = 97
          Height = 17
          Caption = 'follow  drift'
          TabOrder = 1
          Visible = False
          OnClick = CheckBoxDriftClick
        end
        object CheckBoxRS: TCheckBox
          Left = 3
          Top = 83
          Width = 97
          Height = 17
          Caption = 'RS'
          TabOrder = 2
          Visible = False
          OnClick = CheckBoxRSClick
        end
        object ToolBarHelp: TToolBar
          Left = 2
          Top = 2
          Width = 149
          Height = 60
          Align = alNone
          ButtonHeight = 55
          ButtonWidth = 72
          Caption = 'ToolBarHelp'
          Images = Main.ImageListScanTool
          ShowCaptions = True
          TabOrder = 3
          object AnimationBtn: TToolButton
            Left = 0
            Top = 0
            Caption = 'Animation'
            ImageIndex = 20
            OnClick = BitBtnTutorClick
          end
          object HelpBtn: TToolButton
            Left = 72
            Top = 0
            Caption = 'Help'
            ImageIndex = 19
            OnClick = BitBtnHelpClick
          end
        end
      end
    end
    object PanelTopRight: TPanel
      Left = 296
      Top = 0
      Width = 707
      Height = 259
      Align = alClient
      BevelOuter = bvNone
      Caption = 'PanelTopRight'
      Color = 14474715
      ParentBackground = False
      TabOrder = 1
      object ScanParamsWND: TPanel
        Left = 214
        Top = 0
        Width = 493
        Height = 259
        Align = alRight
        BevelOuter = bvNone
        Constraints.MaxWidth = 496
        Constraints.MinWidth = 493
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object PageCtrlScan: TPageControl
          Left = 255
          Top = 0
          Width = 238
          Height = 259
          ActivePage = TabSheetScanArea
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMenu
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TabWidth = 105
          OnChange = PageCtrlScanChange
          object TabSheetScanArea: TTabSheet
            Caption = 'Area'
            object PanelScanM: TPanel
              Left = 0
              Top = 0
              Width = 230
              Height = 41
              Align = alTop
              BevelOuter = bvNone
              Color = 14474715
              TabOrder = 0
              object LblYmax: TLabel
                Left = 1
                Top = 1
                Width = 48
                Height = 13
                Caption = 'LblYmax'
                Color = 14474715
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
              end
              object BitBtnMgIn: TSpeedButton
                Left = 199
                Top = 0
                Width = 25
                Height = 25
                Hint = 'Set Fine Regime'
                Caption = 'F'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -13
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ParentFont = False
                Visible = False
                OnClick = BitBtnMClick
              end
              object BitBtnMgOut: TSpeedButton
                Left = 199
                Top = 0
                Width = 25
                Height = 25
                Hint = 'Set Rough Regime'
                Caption = 'R'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -13
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ParentFont = False
                Visible = False
                OnClick = BitBtnMClick
              end
              object BtnClear: TSpeedButton
                Left = 53
                Top = 0
                Width = 73
                Height = 25
                Caption = 'Clear'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -13
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ParentFont = False
                OnClick = BtnClearClick
              end
              object BitBtnSq: TBitBtn
                Left = 176
                Top = 0
                Width = 25
                Height = 25
                Hint = 'Click to Draw Square Scan'
                TabOrder = 0
                OnClick = BitBtnSqClick
                Glyph.Data = {
                  4E010000424D4E01000000000000760000002800000012000000120000000100
                  040000000000D800000000000000000000001000000000000000000000000000
                  80000080000000808000800000008000800080800000C0C0C000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFF9
                  99999999999FFF000000FFF999999999999FFF000000FFF99FFFFFFFF99FFF00
                  0000FFF99FFFFFFFF99FFF000000FFF99FFFFFFFF99FFF000000FFF99FFFFFFF
                  F99FFF000000FFF99FFFFFFFF99FFF000000FFF99FFFFFFFF99FFF000000FFF9
                  9FFFFFFFF99FFF000000FFF99FFFFFFFF99FFF000000FFF999999999999FFF00
                  0000FFF999999999999FFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                  FFFFFF000000FFFFFFFFFFFFFFFFFF000000}
              end
              object BitBtnRect: TBitBtn
                Left = 175
                Top = 0
                Width = 25
                Height = 25
                Hint = 'Click to Draw Rectangle Scan'
                TabOrder = 1
                OnClick = BitBtnRectClick
                Glyph.Data = {
                  4E010000424D4E01000000000000760000002800000012000000120000000100
                  040000000000D800000000000000000000001000000000000000000000000000
                  80000080000000808000800000008000800080800000C0C0C000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FF99
                  999999999999FF000000FF99999999999999FF000000FF99FFFFFFFFFF99FF00
                  0000FF99FFFFFFFFFF99FF000000FF99FFFFFFFFFF99FF000000FF9999999999
                  9999FF000000FF99999999999999FF000000FFFFFFFFFFFFFFFFFF000000FFFF
                  FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF00
                  0000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                  FFFFFF000000FFFFFFFFFFFFFFFFFF000000}
              end
              object BitBtnX0Y0: TBitBtn
                Left = 150
                Top = 0
                Width = 25
                Height = 25
                Hint = 'Set X0;Y0 Point '
                TabOrder = 2
                OnClick = BitBtnX0Y0Click
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FF999999FFFFFFFFFFFF0000FF999999FFFFFFFFFFFF
                  0000FF999999FFFFFFFFFFFF0000FF99999900000000000F0000FF9999990000
                  0000000F0000FF99999900000000000F0000FFFFFF000FFFFFFF000F0000FFFF
                  FF000FFFFFFF000F0000FFFFFF000FFFFFFF000F0000FFFFFF000FFFFFFF000F
                  0000FFFFFF000FFFFFFF000F0000FFFFFF000FFFFFFF000F0000FFFFFF000000
                  0000000F0000FFFFFF0000000000000F0000FFFFFF0000000000000F0000FFFF
                  FFFFFFFFFFFFFFFF0000}
              end
              object BtnZoom: TBitBtn
                Left = 126
                Top = 0
                Width = 25
                Height = 25
                Hint = 'Zoom Scan Area'
                TabOrder = 3
                OnClick = BtnZoomClick
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                  8888880000008888888888888888800000008888888888888888000800008888
                  8877777888800088000088887000000078000888000088800788888700008888
                  0000880788899988870888880000870888899988880788880000807888899988
                  8870888800007088888999888880788800007089999999999980788800007089
                  9999999999807888000070899999999999807888000070888889998888807888
                  0000807888899988887088880000870888899988880788880000880788899988
                  8708888800008880078888870088888800008888700070007888888800008888
                  88777778888888880000}
              end
            end
            object PanelScanImage: TPanel
              Left = 0
              Top = 41
              Width = 230
              Height = 187
              Align = alClient
              BevelOuter = bvNone
              Color = 14474715
              TabOrder = 1
              DesignSize = (
                230
                187)
              object ImageScanArea: TImage
                Left = 32
                Top = 40
                Width = 105
                Height = 105
                Hint = 
                  'Draw Frame by Mouse( down left button) or Move Frame (down right' +
                  ' buton)'
                OnMouseDown = ImageScanAreaMouseDown
                OnMouseMove = ImageScanAreaMouseMove
                OnMouseUp = ImageScanAreaMouseUp
              end
              object LblXmax: TLabel
                Left = 182
                Top = 172
                Width = 48
                Height = 13
                Anchors = [akRight, akBottom]
                Caption = 'LblXmax'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ParentFont = False
                ExplicitTop = 146
              end
            end
          end
          object TabSheetCurLine: TTabSheet
            Hint = 'Topography Line'
            Caption = 'Current line'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object PageCtrlAdd: TPageControl
              Left = 0
              Top = 0
              Width = 230
              Height = 54
              ActivePage = TabSheetCurScan
              Align = alTop
              TabHeight = 20
              TabOrder = 0
              OnChange = PageCtrlAddChange
              object TabSheetCurScan: TTabSheet
                Caption = 'Height, nm'
                OnShow = TabSheetCurScanShow
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object Panel1: TPanel
                  Left = 0
                  Top = 0
                  Width = 222
                  Height = 28
                  Align = alTop
                  BevelOuter = bvNone
                  Color = 14474715
                  TabOrder = 0
                  object SpeedBtnPlDel: TSpeedButton
                    Left = 197
                    Top = 3
                    Width = 21
                    Height = 21
                    Hint = 'Plane Delete'
                    AllowAllUp = True
                    GroupIndex = 1
                    Down = True
                    Glyph.Data = {
                      F6000000424DF600000000000000760000002800000010000000100000000100
                      0400000000008000000000000000000000001000000000000000000000000000
                      80000080000000808000800000008000800080800000C0C0C000808080000000
                      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                      FFFF0000000000000000000000000000000000FFFFFFFFFFFFFF000FFFFFFFFF
                      9FFFF000FFFFFFF999FFFF000FFFFF9F9F9FFFF000FFFFFF9FFFFFFF000FFFFF
                      9FFFFFFFF000FFFF9FFFFFFFFF000FFF9FFFFFFFFFF000FF9FFFFFFFFFFF000F
                      9FFFFFFFFFFFF0009FFFFFFFFFFFFF000FFFFFFFFFFFFFF000FF}
                    OnClick = SpeedBtnPlDelClick
                  end
                  object BitBtnZoomCurLine: TBitBtn
                    Left = 169
                    Top = 1
                    Width = 25
                    Height = 25
                    Hint = 'Zoom Current Line'
                    TabOrder = 0
                    OnClick = BitBtnZoomCurLineClick
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
                end
              end
              object TabSheetCurLineAdd: TTabSheet
                ImageIndex = 1
                TabVisible = False
                OnShow = TabSheetCurLineAddShow
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object BitBtn1: TBitBtn
                  Left = 196
                  Top = -1
                  Width = 25
                  Height = 25
                  Hint = 'Zoom Current Line'
                  TabOrder = 0
                  OnClick = BitBtnZoomCurLineClick
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
              end
            end
            object ChartCurrentLine: TChart
              Left = 0
              Top = 54
              Width = 230
              Height = 174
              BackWall.Brush.Color = clWhite
              BackWall.Brush.Style = bsClear
              Legend.Visible = False
              MarginLeft = 6
              MarginRight = 6
              Title.Text.Strings = (
                '')
              BottomAxis.Automatic = False
              BottomAxis.AutomaticMaximum = False
              BottomAxis.AutomaticMinimum = False
              BottomAxis.Grid.Visible = False
              BottomAxis.Maximum = 25.000000000000000000
              LeftAxis.Automatic = False
              LeftAxis.AutomaticMaximum = False
              LeftAxis.AutomaticMinimum = False
              LeftAxis.Grid.Visible = False
              LeftAxis.Maximum = 495.000000000000000000
              LeftAxis.Minimum = 98.000000000000000000
              RightAxis.Automatic = False
              RightAxis.AutomaticMaximum = False
              RightAxis.AutomaticMinimum = False
              RightAxis.Grid.Visible = False
              View3D = False
              View3DWalls = False
              Zoom.Allow = False
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 1
              OnDblClick = ChartCurrentLineDblClick
              object SeriesLine: TFastLineSeries
                Marks.Callout.Brush.Color = clBlack
                Marks.Visible = False
                LinePen.Color = clRed
                XValues.Name = 'X'
                XValues.Order = loAscending
                YValues.Name = 'Y'
                YValues.Order = loNone
              end
              object SeriesAddLine: TFastLineSeries
                Marks.Callout.Brush.Color = clBlack
                Marks.Visible = False
                LinePen.Color = clGreen
                XValues.Name = 'X'
                XValues.Order = loAscending
                YValues.Name = 'Y'
                YValues.Order = loNone
              end
            end
          end
        end
        object Panel8: TPanel
          Left = 0
          Top = 0
          Width = 255
          Height = 259
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel8'
          Color = 14474715
          ParentBackground = False
          TabOrder = 2
          object PanelScanParam: TPanel
            Left = 0
            Top = 0
            Width = 255
            Height = 202
            Align = alTop
            BevelOuter = bvNone
            Caption = 'PanelScanParam'
            Color = 14474715
            TabOrder = 0
            object Label2: TLabel
              Left = 54
              Top = -3
              Width = 153
              Height = 14
              Caption = '      Scanning Parameters'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object PanelParam: TPanel
              Left = 4
              Top = 12
              Width = 230
              Height = 193
              BevelInner = bvLowered
              Color = clSilver
              ParentBackground = False
              TabOrder = 0
              object Label3: TLabel
                Left = 71
                Top = 55
                Width = 17
                Height = 16
                Hint = 'Points number in scan'
                Caption = 'NX'
              end
              object Label4: TLabel
                Left = 154
                Top = 55
                Width = 17
                Height = 16
                Hint = 'Line number'
                Caption = 'NY'
              end
              object Label8: TLabel
                Left = 7
                Top = 86
                Width = 56
                Height = 16
                Caption = 'Velocity '
              end
              object Label9: TLabel
                Left = 13
                Top = 126
                Width = 105
                Height = 16
                Caption = 'Scanning time, s'
              end
              object FrameTime: TLabel
                Left = 137
                Top = 126
                Width = 68
                Height = 16
                Caption = 'FrameTime'
              end
              object Label10: TLabel
                Left = 7
                Top = 6
                Width = 67
                Height = 16
                Hint = 'Frame area:  x -scan length;  y- scan width in nm'
                Caption = 'Scan Area'
              end
              object Label11: TLabel
                Left = 157
                Top = 12
                Width = 10
                Height = 18
                Caption = '*'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label12: TLabel
                Left = 10
                Top = 21
                Width = 76
                Height = 16
                Caption = '(Xnm*Ynm)'
              end
              object Label5: TLabel
                Left = 208
                Top = 143
                Width = 19
                Height = 16
                Caption = 'nm'
              end
              object Label1: TLabel
                Left = 9
                Top = 37
                Width = 58
                Height = 16
                Caption = 'Direction'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGreen
                Font.Height = -13
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label16: TLabel
                Left = 16
                Top = 104
                Width = 34
                Height = 16
                Caption = 'nm/s'
              end
              object edNX: TEdit
                Left = 94
                Top = 52
                Width = 39
                Height = 24
                TabOrder = 0
                Text = '1'
                OnChange = edNXChange
                OnEnter = edNXEnter
                OnExit = edNXExit
                OnKeyDown = edNXKeyDown
                OnKeyPress = edNXKeyPress
              end
              object EdNY: TEdit
                Left = 170
                Top = 52
                Width = 39
                Height = 24
                Enabled = False
                TabOrder = 1
                Text = '1'
                OnChange = EdNYChange
                OnEnter = EdNYEnter
                OnExit = EdNYExit
                OnKeyDown = EdNYKeyDown
                OnKeyPress = EdNYKeyPress
              end
              object EdScanRate: TEdit
                Left = 131
                Top = 81
                Width = 75
                Height = 24
                Hint = 'Forward Velocity'
                TabOrder = 2
                Text = '0'
                OnChange = edScanRateChange
                OnKeyPress = EdScanRateKeyPress
              end
              object EdX: TEdit
                Left = 94
                Top = 7
                Width = 61
                Height = 24
                TabOrder = 3
                Text = '5000'
                OnChange = edXChange
                OnKeyDown = EdXKeyDown
                OnKeyPress = EdXKeyPress
              end
              object EdY: TEdit
                Left = 165
                Top = 7
                Width = 62
                Height = 24
                TabOrder = 4
                Text = '5000'
                OnChange = edYChange
                OnKeyDown = EdYKeyDown
                OnKeyPress = EdYKeyPress
              end
              object UpDownNx: TUpDown
                Left = 132
                Top = 52
                Width = 21
                Height = 24
                Min = -1000
                Max = 1000
                Increment = 10
                Position = 1
                TabOrder = 5
                OnClick = UpDownNxClick
              end
              object EdStepXY: TEdit
                Left = 131
                Top = 145
                Width = 56
                Height = 15
                BorderStyle = bsNone
                Color = clMenu
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGreen
                Font.Height = -13
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 6
                OnChange = EdStepXYChange
                OnKeyPress = EdStepXYKeyPress
              end
              object UpDownNy: TUpDown
                Left = 209
                Top = 52
                Width = 21
                Height = 24
                Min = -1000
                Max = 1000
                Increment = 10
                Position = 1
                TabOrder = 7
                Visible = False
                OnClick = UpDownNyClick
              end
              object CheckBoxStep: TCheckBox
                Left = 8
                Top = 146
                Width = 117
                Height = 17
                Hint = 'Choose Area  with Constant Step'
                Alignment = taLeftJustify
                Caption = 'Fix step X,Y'
                TabOrder = 8
                OnClick = CheckBoxStepClick
              end
              object ComboBoxPath: TComboBox
                Left = 6
                Top = 53
                Width = 62
                Height = 22
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGreen
                Font.Height = -12
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ItemHeight = 14
                ParentFont = False
                TabOrder = 9
                Text = 'X+'
                OnChange = ComboBoxPathChange
                Items.Strings = (
                  'X+'
                  'Y+')
              end
              object UpDownSpeed: TUpDown
                Left = 207
                Top = 81
                Width = 21
                Height = 24
                Min = 1
                Position = 50
                TabOrder = 10
                OnClick = UpDownSpeedClick
              end
              object EdScanRateBW: TEdit
                Left = 131
                Top = 103
                Width = 75
                Height = 24
                Hint = 'Backward Velocity'
                TabOrder = 11
                OnChange = EdScanRateBWChange
                OnKeyPress = EdScanRateBWKeyPress
              end
              object UpDownSpeedBW: TUpDown
                Left = 207
                Top = 105
                Width = 21
                Height = 24
                Min = 1
                Position = 50
                TabOrder = 12
                OnClick = UpDownSpeedBWClick
              end
              object BitBtnLock: TBitBtn
                Left = 72
                Top = 93
                Width = 28
                Height = 23
                Hint = 'Constrain Proportions'
                TabOrder = 13
                OnClick = BitBtnLockClick
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF4099BF007CAF0084B7008CBF0095C8009CCF00
                  A2D500A2D5009CCF0095C8008CBF0084B7007CAF4099BFFFFFFFFFFFFF007BAE
                  00CCFF00CCFF00CCFF00CCFF00CCFF00CCFF00CCFF00CCFF00CCFF00CCFF00CC
                  FF00CCFF007BAEFFFFFFFFFFFF0077AA0081B40091C300A0D300AADD16D1FF16
                  D1FF16D1FF16D1FF00AADD00A0D30091C30081B40077AAFFFFFFFFFFFF0086B9
                  35D8FF35D8FF35D8FF35D8FF35D8FF35D8FF35D8FF35D8FF35D8FF35D8FF35D8
                  FF35D8FF0086B9FFFFFFFFFFFF0077AA0081B40091C300A0D300AADD5BE1FF5B
                  E1FF5BE1FF5BE1FF00AADD00A0D30091C30081B40077AAFFFFFFFFFFFF0094C7
                  82EAFF82EAFF82EAFF82EAFF82EAFF82EAFF82EAFF82EAFF82EAFF82EAFF82EA
                  FF82EAFF0094C7FFFFFFFFFFFF0077AA0081B40091C300A0D300AADDA8F3FFA8
                  F3FFA8F3FFA8F3FF00AADD00A0D30091C30081B40077AAFFFFFFFFFFFF00A1D4
                  C7FAFFC7FAFF95E6F663D2EE95E6F6C7FAFFC7FAFF95E6F663D2EE95E6F6C7FA
                  FFC7FAFF00A1D4FFFFFFFFFFFF40BCE26FD3EC00AADD3388A16666663388A100
                  AADD00AADD3388A16666663388A100AADD6FD3EC40BCE2FFFFFFFFFFFFFFFFFF
                  45C1E621B7E26E6E6EAAAAAA6666666FD5EE6FD5EE666666AAAAAA6E6E6E21B7
                  E245C1E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF797979B9B9B9666666FF
                  FFFFFFFFFF666666B9B9B9797979FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFA4A4A4CECECEB4B4B4666666666666B4B4B4CECECEA4A4A4FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7C7C7919191DDDDDDDD
                  DDDDDDDDDDDDDDDD919191C7C7C7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFCBCBCBB2B2B2999999999999B2B2B2CBCBCBFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              end
              object Panel15: TPanel
                Left = 114
                Top = 82
                Width = 17
                Height = 37
                BevelOuter = bvNone
                Color = clSilver
                ParentBackground = False
                TabOrder = 14
                object Panel16: TPanel
                  Left = 0
                  Top = 0
                  Width = 17
                  Height = 21
                  Align = alTop
                  BevelOuter = bvNone
                  Color = clSilver
                  TabOrder = 0
                end
                object Panel17: TPanel
                  Left = 0
                  Top = 21
                  Width = 17
                  Height = 16
                  Align = alClient
                  BevelOuter = bvNone
                  Color = clSilver
                  TabOrder = 1
                end
              end
              object Panel18: TPanel
                Left = 112
                Top = 82
                Width = 16
                Height = 45
                BevelOuter = bvNone
                Color = clSilver
                ParentBackground = False
                TabOrder = 15
                object Panel19: TPanel
                  Left = 0
                  Top = 0
                  Width = 16
                  Height = 16
                  Align = alTop
                  BevelOuter = bvNone
                  Color = clSilver
                  ParentBackground = False
                  TabOrder = 0
                  object Image1: TImage
                    Left = 0
                    Top = 0
                    Width = 16
                    Height = 16
                    Align = alClient
                    Picture.Data = {
                      07544269746D617036030000424D360300000000000036000000280000001000
                      0000100000000100180000000000000300000000000000000000000000000000
                      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4E9E9E9F4F4F4
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFD7B679D79E37CCAA6EF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFF4F4F4DDDDDDD2D2D2D2D2D2D2D2D2D2D2D2D79E37FFE3B0D79E37
                      CCAA6EF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7B679D79E37D79E37D79E
                      37D79E37D79E37D79E37FACB80FCD28CD79E37CCAA6EF4F4F4FFFFFFFFFFFFFF
                      FFFFFFFFFFD79E37FFE4ACFFD187FFD187FFD187FFD187FCCB7AF7BE61F7BE61
                      FFD794D79E37CCAA6EF4F4F4FFFFFFFFFFFFFFFFFFD79E37FFD990FCC261FCC2
                      61FCC261FCC261FCC261FCC261FCC261FFC86CFFDF9DD79E37DDBC7FFFFFFFFF
                      FFFFFFFFFFD79E37FFE099FFCC6CFFCC6CFFCC6CFFCC6CFFCC6CFFCC6CFFCC6C
                      FFCC6CFFD683FFF5C6D79E37FFFFFFFFFFFFFFFFFFD79E37FFE8A3FFD679FFD6
                      79FFD679FFD679FFD679FFD679FFD679FFDB83FFEDADD79E37E7C589FFFFFFFF
                      FFFFFFFFFFD79E37FFFBC7FFF0ABFFF0ABFFF0ABFFF0ABFFEBA1FFE38EFFE38E
                      FFF4B4D79E37E7C589FFFFFFFFFFFFFFFFFFFFFFFFE7C589D79E37D79E37D79E
                      37D79E37D79E37D79E37FFF5B1FFF9BAD79E37E7C589FFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD79E37FFFFD9D79E37
                      E7C589FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFE7C589D79E37E7C589FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFF}
                    Stretch = True
                    Transparent = True
                    ExplicitHeight = 15
                  end
                end
                object Panel20: TPanel
                  Left = 0
                  Top = 16
                  Width = 16
                  Height = 29
                  Align = alClient
                  BevelOuter = bvNone
                  Color = clSilver
                  TabOrder = 1
                  object Panel21: TPanel
                    Left = 0
                    Top = 13
                    Width = 16
                    Height = 16
                    Align = alBottom
                    BevelOuter = bvNone
                    Color = clSilver
                    ParentBackground = False
                    TabOrder = 0
                    object Image2: TImage
                      Left = 0
                      Top = 0
                      Width = 16
                      Height = 16
                      Align = alClient
                      Picture.Data = {
                        07544269746D617036030000424D360300000000000036000000280000001000
                        0000100000000100180000000000000300000000000000000000000000000000
                        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4E9E9E9F4F4F4FFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4
                        F4CCAA6ED79E37D7B679FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFF4F4F4CCAA6ED79E37FFE3B0D79E37D2D2D2D2D2D2
                        D2D2D2D2D2D2DDDDDDF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFF4F4F4CCAA6ED79E
                        37FCD28CFACB80D79E37D79E37D79E37D79E37D79E37D79E37D7B679FFFFFFFF
                        FFFFFFFFFFF4F4F4CCAA6ED79E37FFD794F7BE61F7BE61FCCB7AFFD187FFD187
                        FFD187FFD187FFE4ACD79E37FFFFFFFFFFFFFFFFFFDDBC7FD79E37FFDF9DFFC8
                        6CFCC261FCC261FCC261FCC261FCC261FCC261FCC261FFD990D79E37FFFFFFFF
                        FFFFFFFFFFD79E37FFF5C6FFD683FFCC6CFFCC6CFFCC6CFFCC6CFFCC6CFFCC6C
                        FFCC6CFFCC6CFFE099D79E37FFFFFFFFFFFFFFFFFFE7C589D79E37FFEDADFFDB
                        83FFD679FFD679FFD679FFD679FFD679FFD679FFD679FFE8A3D79E37FFFFFFFF
                        FFFFFFFFFFFFFFFFE7C589D79E37FFF4B4FFE38EFFE38EFFEBA1FFF0ABFFF0AB
                        FFF0ABFFF0ABFFFBC7D79E37FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7C589D79E
                        37FFF9BAFFF5B1D79E37D79E37D79E37D79E37D79E37D79E37E7C589FFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFE7C589D79E37FFFFD9D79E37FFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFE7C589D79E37E7C589FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFF}
                      Stretch = True
                      Transparent = True
                      ExplicitWidth = 14
                      ExplicitHeight = 11
                    end
                  end
                end
              end
              object CheckBoxOnNets: TCheckBox
                Left = 16
                Top = 165
                Width = 119
                Height = 17
                Caption = 'on RS nets'
                TabOrder = 16
                OnClick = CheckBoxOnNetsClick
              end
              object UpDownRS: TUpDown
                Left = 190
                Top = 141
                Width = 17
                Height = 24
                Max = 1
                TabOrder = 17
                Visible = False
                OnClick = UpDownRSClick
              end
            end
            object ApplyBitBtn: TBitBtn
              Left = 145
              Top = 177
              Width = 77
              Height = 19
              Hint = 'Apply scan area parameters'
              Caption = '&Apply'
              TabOrder = 1
              OnClick = ApplyBtnClick
            end
          end
          object BoxFast: TGroupBox
            Left = 0
            Top = 202
            Width = 255
            Height = 57
            Align = alClient
            Caption = 'Previous  line'
            TabOrder = 1
            object LabelLineNum: TLabel
              Left = 4
              Top = 18
              Width = 53
              Height = 16
              Hint = 'Current line number'
              Caption = ' Number'
            end
            object LabelHeight: TLabel
              Left = 100
              Top = 17
              Width = 65
              Height = 16
              Hint = 'Previos line height'
              Caption = 'Height nm'
            end
            object EdScanNMb: TEdit
              Left = 64
              Top = 18
              Width = 33
              Height = 16
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clTeal
              Font.Height = -14
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentColor = True
              ParentFont = False
              TabOrder = 0
            end
            object EdDz: TEdit
              Left = 178
              Top = 18
              Width = 45
              Height = 16
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clTeal
              Font.Height = -14
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentColor = True
              ParentFont = False
              TabOrder = 1
            end
          end
        end
        object BitBtnOpenLock: TBitBtn
          Left = 76
          Top = 105
          Width = 28
          Height = 23
          Hint = 'Constrain Proportions'
          TabOrder = 1
          Visible = False
          OnClick = BitBtnLockClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4099BF007CAF0084B7008CBF0095C800
            9CCF00A2D500A2D5009CCF0095C8008CBF0084B7007CAF4099BFFFFFFFFFFFFF
            007BAE00CCFF00CCFF00CCFF00CCFF00CCFF00CCFF00CCFF00CCFF00CCFF00CC
            FF00CCFF00CCFF007BAEFFFFFFFFFFFF0077AA0081B40091C300A0D300AADD16
            D1FF16D1FF16D1FF16D1FF00AADD00A0D30091C30081B40077AAFFFFFFFFFFFF
            0086B935D8FF35D8FF35D8FF35D8FF35D8FF35D8FF35D8FF35D8FF35D8FF35D8
            FF35D8FF35D8FF0086B9FFFFFFFFFFFF0077AA0081B40091C300A0D300AADD5B
            E1FF5BE1FF5BE1FF5BE1FF00AADD00A0D30091C30081B40077AAFFFFFFFFFFFF
            0094C782EAFF82EAFF82EAFF82EAFF82EAFF82EAFF82EAFF82EAFF82EAFF82EA
            FF82EAFF82EAFF0094C7FFFFFFFFFFFF0077AA0081B40091C300A0D300AADDA8
            F3FFA8F3FFA8F3FFA8F3FF00AADD00A0D30091C30081B40077AAFFFFFFFFFFFF
            00A1D4C7FAFFC7FAFF95E6F663D2EE95E6F6C7FAFFC7FAFF95E6F663D2EE95E6
            F6C7FAFFC7FAFF00A1D4B2B2B26666665290A46FD3EC00AADD3388A166666633
            88A100AADD00AADD0091C40077AA0091C400AADD6FD3EC40BCE26E6E6EAAAAAA
            66666645C1E621B7E2666666AAAAAA6E6E6E6FD5EE6FD5EE61CFEC4EC8E937BF
            E621B7E245C1E6FFFFFF797979B9B9B9666666FFFFFFFFFFFF666666B9B9B979
            7979FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A4A4CECECE
            B4B4B4666666666666B4B4B4CECECEA4A4A4FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFC7C7C7919191DDDDDDDDDDDDDDDDDDDDDDDD919191C7
            C7C7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCBCBCB
            B2B2B2999999999999B2B2B2CBCBCBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        end
      end
      inline SignalsMode: TSignalsMod
        Left = 0
        Top = 0
        Width = 214
        Height = 259
        Align = alClient
        Color = 14474715
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Default'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        TabStop = True
        ExplicitWidth = 214
        ExplicitHeight = 259
        inherited Panel3: TPanel
          Left = 2
          Top = 162
          Width = 200
          Height = 83
          Hint = 'Feed Back Loop Gain Adjustment'
          ExplicitLeft = 2
          ExplicitTop = 162
          ExplicitWidth = 200
          ExplicitHeight = 83
          inherited Label3: TLabel
            Left = 29
            Hint = 'Feed Back Loop Gain Adjustment'
            ExplicitLeft = 29
          end
          inherited Label6: TLabel
            Left = 133
            Top = 28
            ExplicitLeft = 133
            ExplicitTop = 28
          end
          inherited LabelFB: TLabel
            Left = 64
            Top = 26
            Font.Name = 'Default'
            ExplicitLeft = 64
            ExplicitTop = 26
          end
          inherited sbTi: TScrollBar
            Left = 4
            Top = 50
            Width = 139
            ExplicitLeft = 4
            ExplicitTop = 50
            ExplicitWidth = 139
          end
        end
        inherited PageControl1: TPageControl
          Left = -1
          Top = 4
          Width = 208
          Height = 134
          ExplicitLeft = -1
          ExplicitTop = 4
          ExplicitWidth = 208
          ExplicitHeight = 134
          inherited tbSFM: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 7
            ExplicitWidth = 200
            ExplicitHeight = 123
            inherited Panel1: TPanel
              Width = 200
              Height = 65
              ExplicitWidth = 200
              ExplicitHeight = 65
              inherited LbSuppress: TLabel
                Left = 72
                Top = 33
                ExplicitLeft = 72
                ExplicitTop = 33
              end
              inherited Button1: TButton
                Left = 24
                Top = 6
                Height = 22
                Caption = 'Set &Interaction '
                ExplicitLeft = 24
                ExplicitTop = 6
                ExplicitHeight = 22
              end
            end
            inherited PanelGain: TPanel
              Top = 65
              Width = 200
              Height = 58
              Hint = 'Set Phase Shift Amplifier Gain'
              ExplicitTop = 65
              ExplicitWidth = 200
              ExplicitHeight = 58
              inherited Label2: TLabel
                Left = 49
                Top = 6
                Hint = 'Set Phase Shift Amplifier Gain'
                ExplicitLeft = 49
                ExplicitTop = 6
              end
              inherited GainFMBtn: TButton
                Top = 28
                Height = 20
                Hint = 'Set Phase Shift Amplifier Gain'
                ExplicitTop = 28
                ExplicitHeight = 20
              end
            end
          end
          inherited tbSTM: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 7
            ExplicitWidth = 193
            ExplicitHeight = 116
            inherited Panel4: TPanel
              Height = 58
              ParentBackground = False
              ExplicitHeight = 58
              inherited Label1: TLabel
                Left = 26
                Top = 6
                Width = 118
                Caption = 'Set Point: Current'
                ExplicitLeft = 26
                ExplicitTop = 6
                ExplicitWidth = 118
              end
              inherited btnSetPoint: TButton
                Left = 23
                Top = 28
                Height = 21
                ExplicitLeft = 23
                ExplicitTop = 28
                ExplicitHeight = 21
              end
            end
            inherited PanelBias: TPanel
              Top = 58
              Height = 58
              ParentBackground = False
              ExplicitTop = 58
              ExplicitHeight = 58
              inherited Label4: TLabel
                Left = 51
                Top = 2
                ExplicitLeft = 51
                ExplicitTop = 2
              end
              inherited BtnBiasV: TBitBtn
                Left = 35
                Top = 22
                Height = 22
                ExplicitLeft = 35
                ExplicitTop = 22
                ExplicitHeight = 22
              end
            end
          end
          inherited tbSFMCUR: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 7
            ExplicitWidth = 193
            ExplicitHeight = 116
            inherited Panel6: TPanel
              inherited Button2: TButton
                Hint = 'Adjust Force interaction'
              end
            end
            inherited Panel7: TPanel
              inherited Label7: TLabel
                Top = 5
                ExplicitTop = 5
              end
              inherited BtnBiasSFM: TBitBtn
                Top = 25
                Font.Color = clRed
                OnClick = SignalsModeBtnBiasSFMClick
                ExplicitTop = 25
              end
            end
          end
        end
        inherited siLangLinkedf1: TsiLangLinked
          TranslationData = {
            737443617074696F6E730D0A50616E656C330101010D0A4C6162656C46420101
            010D0A746253464D0153464D01D1D1CC010D0A4C625375707072657373010101
            0D0A427574746F6E31015365742026496E746572616374696F6E2001D1E8EBE0
            010D0A50616E656C4761696E0101010D0A4761696E464D42746E0101010D0A74
            6253544D0153544D01D1D2CC010D0A50616E656C340101010D0A62746E536574
            506F696E740101010D0A42746E42696173560101010D0A746253464D43555201
            01010D0A50616E656C360101010D0A427574746F6E320153657420496E746572
            616374696F6E01D1E8EBE0010D0A50616E656C370101010D0A4C6162656C3701
            4269617320566F6C7461676501CDE0EFF0FFE6E5EDE8E5010D0A42746E426961
            7353464D0142746E4269617353464D01010D0A50616E656C426961730101010D
            0A4C625375707072657373490101010D0A4C6162656C36016D617801ECE0EAF1
            010D0A4C6162656C330146656564204261636B204C6F6F70204761696E012020
            2020D3F1E8EBE5EDE8E520CED1010D0A4C6162656C35016D696E01ECE8ED010D
            0A50616E656C310101010D0A4C6162656C32014741494E5F464D01D3F1E8EBE5
            EDE8E520D4CC010D0A4C6162656C310153657420506F696E743A204375727265
            6E740120202020D0E0E1EEF7E8E920F2EEEA010D0A4C6162656C340142696173
            20566F6C7461676501CDE0EFF0FFE6E5EDE8E5010D0A737448696E74730D0A54
            5369676E616C734D6F640101010D0A50616E656C330146656564204261636B20
            4C6F6F70204761696E2041646A7573746D656E7401D3F1E8EBE5EDE8E520EFE5
            F2EBE820EEF2F0E8F6E0F2E5EBFCEDEEE920EEE1F0E0F2EDEEE920F1E2FFE7E8
            010D0A4C6162656C46420101010D0A4672657175656E6379547261636B014665
            6564204261636B204C6F6F70204761696E2041646A7573746D656E7401D3F1E8
            EBE5EDE8E520EFE5F2EBE820EEF2F0E8F6E0F2E5EBFCEDEEE920EEE1F0E0F2ED
            EEE920F1E2FFE7E8010D0A50616765436F6E74726F6C310101010D0A74625346
            4D0101010D0A4C6253757070726573730101010D0A427574746F6E3101466F72
            636520496E746572616374696F6E2041646A7573746D656E7401D3F1F2E0EDEE
            E2EAE020F1E8EBFB20E2E7E0E8ECEEE4E5E9F1F2E2E8FF010D0A50616E656C47
            61696E0153657420506861736520536869667420416D706C6966696572204761
            696E01D3F1E8EBE5EDE8E520F4E0E7FB010D0A4761696E464D42746E01536574
            20506861736520536869667420416D706C6966696572204761696E01D3F1E8EB
            E5EDE8E520F4E0E7FB010D0A746253544D0101010D0A50616E656C340101010D
            0A62746E536574506F696E740101010D0A42746E42696173560101010D0A7462
            53464D4355520101010D0A50616E656C360101010D0A427574746F6E32014164
            6A75737420466F72636520696E746572616374696F6E01D3F1F2E0EDEEE2EAE0
            20F1E8EBFB20E2E7E0E8ECEEE4E5E9F1F2E2E8FF010D0A50616E656C37010101
            0D0A4C6162656C370101010D0A42746E4269617353464D0101010D0A50616E65
            6C426961730101010D0A4C625375707072657373490101010D0A4C6162656C36
            0101010D0A4C6162656C330146656564204261636B204C6F6F70204761696E20
            41646A7573746D656E7401010D0A4C6162656C350101010D0A50616E656C3101
            01010D0A4C6162656C320153657420506861736520536869667420416D706C69
            66696572204761696E01010D0A4C6162656C310101010D0A4C6162656C340101
            010D0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A545369
            676E616C734D6F640144656661756C74015461686F6D610D0A4C625375707072
            6573730144656661756C74015461686F6D610D0A427574746F6E310144656661
            756C74015461686F6D610D0A42746E42696173560144656661756C7401546168
            6F6D610D0A427574746F6E320144656661756C74015461686F6D610D0A4C6162
            656C370144656661756C74015461686F6D610D0A42746E4269617353464D0144
            656661756C74015461686F6D610D0A4C62537570707265737349014465666175
            6C7401417269616C010D0A4C6162656C360144656661756C7401417269616C01
            0D0A746253464D43555201417269616C0144656661756C74010D0A4C6162656C
            330144656661756C740144656661756C74010D0A4C6162656C35014465666175
            6C740144656661756C74010D0A4C6162656C320144656661756C740144656661
            756C74010D0A4C6162656C310144656661756C740144656661756C74010D0A4C
            6162656C340144656661756C740144656661756C74010D0A73744D756C74694C
            696E65730D0A7374537472696E67730D0A6964735F3301496E63726561736520
            746865206D6178696D616C2076616C7565206F6E2074686520696E6469636174
            6F72206F66207468652063757272656E742101D3E2E5EBE8F7FCF2E520ECE0EA
            F1E8ECE0EBFCEDEEE520E7EDE0F7E5EDE8E520EDE020E8EDE4E8EAE0F2EEF0E0
            20F2EEEAE021010D0A73744F74686572537472696E67730D0A7374436F6C6C65
            6374696F6E730D0A737443686172536574730D0A545369676E616C734D6F6401
            5255535349414E5F43484152534554015255535349414E5F434841525345540D
            0A4C625375707072657373015255535349414E5F434841525345540152555353
            49414E5F434841525345540D0A427574746F6E31015255535349414E5F434841
            52534554015255535349414E5F434841525345540D0A42746E42696173560152
            55535349414E5F43484152534554015255535349414E5F434841525345540D0A
            427574746F6E32015255535349414E5F43484152534554015255535349414E5F
            434841525345540D0A4C6162656C37015255535349414E5F4348415253455401
            5255535349414E5F434841525345540D0A42746E4269617353464D0152555353
            49414E5F43484152534554015255535349414E5F434841525345540D0A4C6253
            7570707265737349015255535349414E5F43484152534554015255535349414E
            5F43484152534554010D0A4C6162656C36015255535349414E5F434841525345
            54015255535349414E5F43484152534554010D0A746253464D43555201444546
            41554C545F43484152534554015255535349414E5F43484152534554010D0A4C
            6162656C33015255535349414E5F43484152534554015255535349414E5F4348
            4152534554010D0A4C6162656C35015255535349414E5F434841525345540152
            55535349414E5F43484152534554010D0A4C6162656C32015255535349414E5F
            43484152534554015255535349414E5F43484152534554010D0A4C6162656C31
            015255535349414E5F43484152534554015255535349414E5F43484152534554
            010D0A4C6162656C34015255535349414E5F4348415253455401525553534941
            4E5F43484152534554010D0A}
        end
      end
    end
  end
  object PanelDown: TPanel
    Left = 0
    Top = 259
    Width = 1003
    Height = 437
    Align = alClient
    Color = 14474715
    ParentBackground = False
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 488
      Height = 432
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = 14474715
      ParentBackground = False
      TabOrder = 0
      object PageCtlLeft: TPageControl
        Left = 0
        Top = 0
        Width = 484
        Height = 428
        ActivePage = TabSheetMatrix
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Default'
        Font.Style = [fsBold]
        MultiLine = True
        ParentFont = False
        TabOrder = 0
        TabWidth = 190
        OnChange = PageCtlLeftChange
        object TabSheetSideL: TTabSheet
          Caption = 'Topography/ Side View'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object ImageSideL: TImage
            Left = 16
            Top = 0
            Width = 476
            Height = 327
            Hint = 'Topography : side view '
            Enabled = False
          end
        end
        object TabSheetTopoL: TTabSheet
          Caption = 'Topography/ Top View'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object PanelLChart: TPanel
            Left = 0
            Top = 0
            Width = 476
            Height = 382
            Align = alClient
            BevelOuter = bvNone
            Color = 14474715
            TabOrder = 0
            object PanelChartL: TPanel
              Left = 0
              Top = 55
              Width = 476
              Height = 327
              Align = alClient
              BevelOuter = bvNone
              Color = 14474715
              ParentBackground = False
              TabOrder = 0
              object ImgLPanel: TPanel
                Left = 6
                Top = 6
                Width = 449
                Height = 306
                BevelOuter = bvNone
                Color = 14474715
                ParentBackground = False
                TabOrder = 0
                object ImgLChart: TChart
                  Left = 17
                  Top = -1
                  Width = 400
                  Height = 250
                  AllowPanning = pmNone
                  BackWall.Brush.Color = clWhite
                  BackWall.Brush.Style = bsClear
                  Legend.Visible = False
                  MarginRight = 6
                  Title.Alignment = taLeftJustify
                  Title.Font.Color = clBlack
                  Title.Text.Strings = (
                    'TChart')
                  View3D = False
                  Zoom.Allow = False
                  OnAfterDraw = ImgLChartAfterDraw
                  BevelOuter = bvNone
                  Color = 14474715
                  TabOrder = 0
                  PrintMargins = (
                    15
                    19
                    15
                    19)
                  object Series2: TLineSeries
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
            object Panel2: TPanel
              Left = 0
              Top = 0
              Width = 476
              Height = 55
              Align = alTop
              TabOrder = 1
              object SpeedBtnSDelTopL: TSpeedButton
                Left = 420
                Top = 8
                Width = 23
                Height = 22
                Hint = 'Surface Delete'
                AllowAllUp = True
                GroupIndex = 20
                Glyph.Data = {
                  F6000000424DF600000000000000760000002800000010000000100000000100
                  0400000000008000000000000000000000001000000000000000000000000000
                  80000080000000808000800000008000800080800000C0C0C000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
                  7777000000000000000000000000000000000077777797777770007777799977
                  7770700777979797770077077777977770077700777797777077777007779777
                  0077777700779770077777777007970077777777770090077777777777700077
                  7777777777777777777777777777777777777777777777777777}
                OnClick = SpeedBtnSDelTopLClick
              end
              object SpeedBtnDelTopL: TSpeedButton
                Left = 391
                Top = 8
                Width = 23
                Height = 22
                Hint = 'Plane Delete'
                AllowAllUp = True
                GroupIndex = 20
                Down = True
                Glyph.Data = {
                  F6000000424DF600000000000000760000002800000010000000100000000100
                  0400000000008000000000000000000000001000000000000000000000000000
                  80000080000000808000800000008000800080800000C0C0C000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFF0000000000000000000000000000000000FFFFFFFFFFFFFF000FFFFFFFFF
                  9FFFF000FFFFFFF999FFFF000FFFFF9F9F9FFFF000FFFFFF9FFFFFFF000FFFFF
                  9FFFFFFFF000FFFF9FFFFFFFFF000FFF9FFFFFFFFFF000FF9FFFFFFFFFFF000F
                  9FFFFFFFFFFFF0009FFFFFFFFFFFFF000FFFFFFFFFFFFFF000FF}
                OnClick = SpeedBtnDelTopLClick
              end
              object SpeedBtnCaptureL: TSpeedButton
                Left = 323
                Top = 5
                Width = 27
                Height = 25
                Hint = 'Capture of Current Scan'
                Glyph.Data = {
                  6E020000424D6E0200000000000076000000280000002A000000150000000100
                  040000000000F801000000000000000000001000000000000000000000000000
                  80000080000000808000800000008000800080800000C0C0C000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00700000000000
                  00000000777777777777777777777700000073BBBBBBBBBBBBBBBBB077777777
                  7777777777777700000073B033333333333333B0777777777777777777777700
                  000073B0CCCCCCCCCCCCC3B0777777777777777777777700000073B0CCCCCCCC
                  666663B0777777777777777777777700000073B0EEEEEE66666663B077777777
                  7777777777777700000073B0EEEEEEE6666663B0777777777777777777777700
                  000073B0EEEEEEEEEE6663B0777777777777777777777700000073B0EEBBBEEE
                  EEEEE3B0777777777777777777777700000073B0EBBBBBEEEEEEE3B077777777
                  7777777777777700000073B0EBBBBBEEEEEEE3B0777777777777777777777700
                  000073B0EBBBBBEEEEEEE3B0777777777777777777777700000073B0EEBBBEEE
                  EEEEE3B0777777777777777777777700000073B0EEEEEEEEEEEEE3B077777777
                  7777777777777700000073B000000000000000B0777777777777777777777700
                  000073BBBBBBBBBBBBBBBBB07777777777777777777777000000733333333333
                  3333333077777777777777777777770000007777887777777778877777777777
                  7777777777777700000077777788777778877777777777777777777777777700
                  0000777777778878877777777777777777777777777777000000777777777707
                  777777777777777777777777777777000000}
                NumGlyphs = 2
                Visible = False
                OnClick = SpeedBtnCaptureClick
              end
              object SpeedBtnContrL: TSpeedButton
                Left = 354
                Top = 8
                Width = 23
                Height = 22
                Glyph.Data = {
                  F6000000424DF600000000000000760000002800000010000000100000000100
                  0400000000008000000000000000000000001000000000000000000000000000
                  80000080000000808000800000008000800080800000C0C0C000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777700000000
                  7777777000000FF00777770000000FFFF077700000000FFFFF07700000000FFF
                  FFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFF
                  FFF0000000000FFFFFF0000000000FFFFF00700000000FFFFF07700000000FFF
                  F007770000000FFF007777700000000007777777700000077777}
                OnClick = SpeedBtnContrLClick
              end
              object PanelTerra: TPanel
                Left = 16
                Top = 1
                Width = 289
                Height = 48
                TabOrder = 0
                Visible = False
                object Label20: TLabel
                  Left = 159
                  Top = 10
                  Width = 17
                  Height = 13
                  Caption = 'ms'
                end
                object Label21: TLabel
                  Left = 16
                  Top = 11
                  Width = 63
                  Height = 13
                  Caption = 'Time Delay'
                end
                object lbleditTterra: TEdit
                  Left = 85
                  Top = 3
                  Width = 50
                  Height = 21
                  Enabled = False
                  TabOrder = 0
                  Text = 'lbleditTterra'
                  OnEnter = lbleditTterraEnter
                  OnExit = LblEditTTerraExit
                  OnKeyPress = lbleditTterraKeyPress
                end
                object ScrollBarTTErra: TScrollBar
                  Left = 61
                  Top = 30
                  Width = 114
                  Height = 13
                  Max = 1000
                  Min = 1
                  PageSize = 0
                  Position = 1
                  TabOrder = 1
                  OnScroll = ScrollBarTTErraScroll
                end
              end
            end
          end
        end
        object TabSheetMatrix: TTabSheet
          Caption = 'Matrix for lithography'
          ImageIndex = 2
          object PanelMatrix: TPanel
            Left = 0
            Top = 0
            Width = 346
            Height = 382
            Hint = 'Load Image for Lithography'
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 1
            Color = 14474715
            TabOrder = 0
            object Panel13: TPanel
              Left = 1
              Top = 355
              Width = 344
              Height = 26
              Align = alBottom
              BevelOuter = bvNone
              Color = clSilver
              ParentBackground = False
              TabOrder = 0
              object RadioGroupBW: TRadioGroup
                Left = 1
                Top = -6
                Width = 338
                Height = 31
                Columns = 2
                ItemIndex = 0
                Items.Strings = (
                  'Black-white'
                  'Gray(8)')
                ParentBackground = False
                TabOrder = 0
                OnClick = RadioGroupBWClick
              end
            end
            object Panel14: TPanel
              Left = 1
              Top = 1
              Width = 344
              Height = 354
              Align = alClient
              BevelOuter = bvNone
              ParentBackground = False
              TabOrder = 1
              object ImageMatrix: TImage
                Left = 80
                Top = 72
                Width = 105
                Height = 105
                Stretch = True
              end
            end
          end
          object PanelMatParam: TPanel
            Left = 346
            Top = 0
            Width = 130
            Height = 382
            Align = alRight
            BevelInner = bvRaised
            BevelOuter = bvNone
            BevelWidth = 2
            BorderWidth = 1
            Color = clSilver
            Locked = True
            ParentBackground = False
            TabOrder = 1
            object Label7: TLabel
              Left = 8
              Top = 62
              Width = 14
              Height = 13
              Caption = 'Nx'
            end
            object Label14: TLabel
              Left = 8
              Top = 88
              Width = 14
              Height = 13
              Caption = 'Ny'
            end
            object Label15: TLabel
              Left = 73
              Top = 113
              Width = 65
              Height = 18
              Hint = 'step X,Y for the projection'
              Caption = 'Step, nm'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
              Visible = False
            end
            object LabelAction: TLabel
              Left = 7
              Top = 143
              Width = 83
              Height = 18
              Hint = 'deep action '
              Caption = '  Depth, nm'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label17: TLabel
              Left = 20
              Top = 202
              Width = 49
              Height = 18
              Hint = 'Time Action in the point'
              Caption = 'Time,  '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label18: TLabel
              Left = 71
              Top = 202
              Width = 33
              Height = 18
              Caption = ' mcs'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label6: TLabel
              Left = 17
              Top = 119
              Width = 63
              Height = 18
              Caption = '    Action'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object BitBtnLoadIm: TBitBtn
              Left = 20
              Top = 6
              Width = 90
              Height = 21
              Hint = 'Load Image for Lithography'
              Caption = '&Load image'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              OnClick = BitBtnLoadImClick
            end
            object edNxM: TEdit
              Left = 40
              Top = 59
              Width = 45
              Height = 21
              Enabled = False
              TabOrder = 1
              Text = '0'
            end
            object UpDown1: TUpDown
              Left = 85
              Top = 59
              Width = 19
              Height = 21
              Associate = edNxM
              TabOrder = 16
              Visible = False
            end
            object EdNyM: TEdit
              Left = 40
              Top = 85
              Width = 45
              Height = 21
              Enabled = False
              TabOrder = 3
              Text = '0'
            end
            object UpDown2: TUpDown
              Left = 85
              Top = 85
              Width = 20
              Height = 21
              Associate = EdNyM
              TabOrder = 4
              Visible = False
            end
            object EdStepXYM: TEdit
              Left = 5
              Top = 108
              Width = 45
              Height = 21
              TabOrder = 5
              Visible = False
              OnChange = EdStepXYMChange
            end
            object ScrollBarLitho: TScrollBar
              Left = 6
              Top = 189
              Width = 104
              Height = 10
              LargeChange = 5
              PageSize = 5
              SmallChange = 5
              TabOrder = 6
              OnChange = ScrollBarLithoChange
              OnScroll = ScrollBarLithoScroll
            end
            object BitBtnProject: TBitBtn
              Left = 5
              Top = 33
              Width = 115
              Height = 21
              Hint = 'Project Image Matrix on the Scan Area'
              Caption = '&Projection'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 7
              OnClick = BitBtnProjectClick
            end
            object BitBTnActLitho: TEdit
              Left = 41
              Top = 162
              Width = 47
              Height = 21
              TabOrder = 8
              OnChange = BitBTnActLithoChange
              OnKeyDown = BitBTnActLithoKeyDown
              OnKeyPress = BitBTnActLithoKeyPress
            end
            object BitBtnTimeAct: TEdit
              Left = 41
              Top = 219
              Width = 46
              Height = 21
              Hint = 'Time Action in the point'
              TabOrder = 9
              OnChange = BitBtnTimeActChange
              OnKeyDown = BitBtnTimeActKeyDown
              OnKeyPress = BitBtnTimeActKeyPress
            end
            object ScrollBarTime: TScrollBar
              Left = 7
              Top = 243
              Width = 116
              Height = 10
              LargeChange = 100
              Max = 4000
              Min = 1
              PageSize = 0
              Position = 1
              SmallChange = 100
              TabOrder = 2
              OnScroll = ScrollBarTimeScroll
            end
            object RadioTypeLitho: TRadioGroup
              Left = 9
              Top = 262
              Width = 105
              Height = 59
              Caption = 'Lithography'
              Color = clSilver
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ItemIndex = 0
              Items.Strings = (
                'Force'
                'Current')
              ParentColor = False
              ParentFont = False
              TabOrder = 10
              OnClick = RadioTypeLithoClick
              OnExit = RadioTypeLithoClick
            end
            object UpDownAct: TUpDown
              Left = 12
              Top = 159
              Width = 17
              Height = 25
              Hint = 'Dynamic Amplifier  of Action'
              Min = 1
              Max = 3
              Position = 1
              TabOrder = 11
              Visible = False
              OnClick = UpDownActClick
            end
            object UpAct: TBitBtn
              Left = 96
              Top = 156
              Width = 18
              Height = 18
              Hint = 'Increase depth  (x2)'
              Caption = 'x2'
              TabOrder = 12
              Visible = False
              OnClick = UpActClick
            end
            object DownAct: TBitBtn
              Left = 95
              Top = 173
              Width = 18
              Height = 15
              Hint = 'Decrease depth (/2)'
              Caption = '/2'
              TabOrder = 13
              Visible = False
              OnClick = DownActClick
            end
            object UpDownLithostep: TUpDown
              Left = 115
              Top = 127
              Width = 16
              Height = 24
              Max = 5
              TabOrder = 14
              Visible = False
              OnClick = UpDownLithostepClick
            end
            object ToolBar1: TToolBar
              Left = 29
              Top = 325
              Width = 67
              Height = 52
              Align = alNone
              ButtonHeight = 52
              ButtonWidth = 65
              Caption = 'ToolBar1'
              Images = Main.ImageListScanTool
              ShowCaptions = True
              TabOrder = 15
              object ToolButton1: TToolButton
                Left = 0
                Top = 0
                Caption = 'Animation'
                ImageIndex = 20
                OnClick = BitBtnTutorClick
              end
            end
          end
        end
        object TabSheetTopoError: TTabSheet
          Caption = 'Topography/Top View II Pass'
          ImageIndex = 3
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object PanelChartError: TPanel
            Left = 0
            Top = 0
            Width = 476
            Height = 382
            Align = alClient
            Color = 14474715
            TabOrder = 0
            object SpeedBtnPldelL: TSpeedButton
              Left = 388
              Top = 5
              Width = 23
              Height = 22
              Hint = 'Plane Delete'
              AllowAllUp = True
              GroupIndex = 20
              Down = True
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFF0000000000000000000000000000000000FFFFFFFFFFFFFF000FFFFFFFFF
                9FFFF000FFFFFFF999FFFF000FFFFF9F9F9FFFF000FFFFFF9FFFFFFF000FFFFF
                9FFFFFFFF000FFFF9FFFFFFFFF000FFF9FFFFFFFFFF000FF9FFFFFFFFFFF000F
                9FFFFFFFFFFFF0009FFFFFFFFFFFFF000FFFFFFFFFFFFFF000FF}
              OnClick = SpeedBtnDelTopLClick
            end
            object SpeedBtnSurDelL: TSpeedButton
              Left = 420
              Top = 5
              Width = 23
              Height = 22
              Hint = 'Surface Delete'
              AllowAllUp = True
              GroupIndex = 20
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
                7777000000000000000000000000000000000077777797777770007777799977
                7770700777979797770077077777977770077700777797777077777007779777
                0077777700779770077777777007970077777777770090077777777777700077
                7777777777777777777777777777777777777777777777777777}
              OnClick = SpeedBtnSDelTopLClick
            end
            object SpeedBtnCapL: TSpeedButton
              Left = 359
              Top = 2
              Width = 23
              Height = 25
              Hint = 'Capture of Current Scan'
              Glyph.Data = {
                6E020000424D6E0200000000000076000000280000002A000000150000000100
                040000000000F801000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00700000000000
                00000000777777777777777777777700000073BBBBBBBBBBBBBBBBB077777777
                7777777777777700000073B033333333333333B0777777777777777777777700
                000073B0CCCCCCCCCCCCC3B0777777777777777777777700000073B0CCCCCCCC
                666663B0777777777777777777777700000073B0EEEEEE66666663B077777777
                7777777777777700000073B0EEEEEEE6666663B0777777777777777777777700
                000073B0EEEEEEEEEE6663B0777777777777777777777700000073B0EEBBBEEE
                EEEEE3B0777777777777777777777700000073B0EBBBBBEEEEEEE3B077777777
                7777777777777700000073B0EBBBBBEEEEEEE3B0777777777777777777777700
                000073B0EBBBBBEEEEEEE3B0777777777777777777777700000073B0EEBBBEEE
                EEEEE3B0777777777777777777777700000073B0EEEEEEEEEEEEE3B077777777
                7777777777777700000073B000000000000000B0777777777777777777777700
                000073BBBBBBBBBBBBBBBBB07777777777777777777777000000733333333333
                3333333077777777777777777777770000007777887777777778877777777777
                7777777777777700000077777788777778877777777777777777777777777700
                0000777777778878877777777777777777777777777777000000777777777707
                777777777777777777777777777777000000}
              NumGlyphs = 2
              Visible = False
              OnClick = SpeedBtnCaptureClick
            end
            object Label19: TLabel
              Left = 154
              Top = 7
              Width = 93
              Height = 13
              Caption = 'DACZ delay, mcs'
            end
            object LabelDecayII: TLabel
              Left = 1
              Top = 6
              Width = 58
              Height = 13
              Caption = 'Decay, ms'
            end
            object PanelChartLEr: TPanel
              Left = 0
              Top = 56
              Width = 481
              Height = 321
              Color = 14474715
              TabOrder = 0
              object ImgLPanelEr: TPanel
                Left = 8
                Top = 15
                Width = 449
                Height = 306
                BevelInner = bvRaised
                BevelOuter = bvNone
                Color = 14474715
                TabOrder = 0
                object ImgLChartEr: TChart
                  Left = 0
                  Top = 8
                  Width = 400
                  Height = 250
                  BackWall.Brush.Color = clWhite
                  BackWall.Brush.Style = bsClear
                  Legend.Visible = False
                  MarginRight = 6
                  Title.Alignment = taLeftJustify
                  Title.Font.Color = clBlack
                  Title.Text.Strings = (
                    'TChart')
                  View3D = False
                  OnAfterDraw = ImgLChartAfterDraw
                  BevelOuter = bvNone
                  Color = 14474715
                  TabOrder = 0
                  object LineSeries1: TLineSeries
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
            object EditDacZSpeed: TEdit
              Left = 274
              Top = 2
              Width = 95
              Height = 21
              TabOrder = 1
              Text = 'EditDacZSpeed'
              OnChange = EditDacZSpeedChange
              OnKeyPress = EditDacZSpeedKeyPress
            end
            object LblEditDecay: TLabeledEdit
              Left = 90
              Top = 2
              Width = 58
              Height = 21
              EditLabel.Width = 72
              EditLabel.Height = 13
              EditLabel.Caption = 'LblEditDecay'
              LabelPosition = lpLeft
              TabOrder = 2
              OnChange = LblEditDecayChange
              OnKeyPress = LblEditDecayKeyPress
            end
          end
        end
      end
    end
    object Panel4: TPanel
      Left = 488
      Top = 1
      Width = 481
      Height = 425
      BevelOuter = bvNone
      BorderStyle = bsSingle
      TabOrder = 1
      object PageCtlRight: TPageControl
        Left = 0
        Top = 0
        Width = 477
        Height = 65
        ActivePage = TabSheetFastTopo
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Default'
        Font.Style = [fsBold]
        HotTrack = True
        MultiLine = True
        ParentFont = False
        TabOrder = 0
        OnChange = PageCtlRightChange
        OnChanging = PageCtlRightChanging
        object TabSheetTopoR: TTabSheet
          Caption = 'Topography/ Top View'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ImageIndex = 1
          ParentFont = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheetPhaseR: TTabSheet
          Caption = 'Phase shift'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheetUAMR: TTabSheet
          Caption = 'Force image'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ImageIndex = 2
          ParentFont = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheetSpectrR: TTabSheet
          BorderWidth = 2
          Caption = 'Spectroscopy'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object PanelSpectr: TPanel
            Left = 8
            Top = 40
            Width = 457
            Height = 273
            TabOrder = 0
          end
        end
        object TabSheetCurR: TTabSheet
          BorderWidth = 2
          Caption = 'Current image'
          ImageIndex = 4
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheetFastTopo: TTabSheet
          Hint = 'Current Image'
          Caption = 'Fast Scan/Phase shift'
          ImageIndex = 5
          object ImageFastTopo: TImage
            Left = 96
            Top = 64
            Width = 105
            Height = 105
          end
        end
        object TabSheetLitho: TTabSheet
          Hint = 'Litography'
          Caption = 'Lithography'
          ImageIndex = 6
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheetScanTran: TTabSheet
          Hint = 'Multi times scanning along X-axes'
          Caption = 'One line scanning'
          ImageIndex = 7
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheetSens: TTabSheet
          Caption = 'Sensivity correction'
          ImageIndex = 8
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheetProfiler: TTabSheet
          Caption = 'Profiler'
          ImageIndex = 9
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
      end
      object PanelRight: TPanel
        Left = 0
        Top = 65
        Width = 477
        Height = 356
        Align = alClient
        Color = 14474715
        TabOrder = 1
        object PanelChart: TPanel
          Left = 3
          Top = 44
          Width = 475
          Height = 316
          BevelOuter = bvNone
          Color = 14474715
          TabOrder = 0
          object ImgRPanel: TPanel
            Left = 0
            Top = -3
            Width = 475
            Height = 316
            BevelOuter = bvNone
            Color = 14474715
            TabOrder = 0
            object ImgRChart: TChart
              Left = 0
              Top = 0
              Width = 400
              Height = 250
              AllowPanning = pmNone
              Legend.Visible = False
              Title.Text.Strings = (
                'TChart')
              OnUndoZoom = ImgRChartUndoZoom
              OnZoom = ImgRChartZoom
              View3D = False
              Zoom.Allow = False
              OnAfterDraw = ImgRChartAfterDraw
              BevelOuter = bvNone
              Color = 14474715
              TabOrder = 0
              OnMouseDown = ImgRChartMouseDown
              OnMouseMove = ImgRChartMouseMove
              OnMouseUp = ImgRChartMouseUp
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
        end
        object Panel11: TPanel
          Left = 1
          Top = 1
          Width = 475
          Height = 30
          Align = alTop
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 1
          object PanelFltr: TPanel
            Left = 6
            Top = 6
            Width = 330
            Height = 23
            BevelOuter = bvNone
            TabOrder = 0
            Visible = False
            object LabelFltr: TLabel
              Left = -1
              Top = 1
              Width = 32
              Height = 16
              Caption = 'Filter'
            end
            object LabelNm: TLabel
              Left = 197
              Top = 0
              Width = 19
              Height = 16
              Caption = 'nm'
            end
            object ComboBoxFilter: TComboBox
              Left = 48
              Top = -4
              Width = 75
              Height = 24
              ItemHeight = 16
              TabOrder = 0
              Text = 'None'
              OnChange = ComboBoxFilterChange
              Items.Strings = (
                'None'
                'Av 3x3'
                'Av 5x5')
            end
            object LEditDz: TLabeledEdit
              Left = 146
              Top = -2
              Width = 44
              Height = 24
              EditLabel.Width = 16
              EditLabel.Height = 16
              EditLabel.Caption = 'Dz'
              LabelPosition = lpLeft
              TabOrder = 1
              OnChange = LEditDzChange
              OnKeyPress = LEditDzKeyPress
            end
          end
          object PanelSpectrF: TPanel
            Left = 234
            Top = 2
            Width = 203
            Height = 32
            BevelOuter = bvNone
            TabOrder = 1
            object BitBtnClChart: TBitBtn
              Left = 74
              Top = 0
              Width = 64
              Height = 18
              Hint = 'Clear Spectroscopy Area'
              Caption = 'Clear'
              TabOrder = 0
              OnClick = BitBtnPointClearClick
            end
            object ComboBoxIZ: TComboBox
              Left = 144
              Top = 2
              Width = 52
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ItemHeight = 13
              ItemIndex = 1
              ParentFont = False
              TabOrder = 1
              Text = 'I-Z'
              OnSelect = ComboBoxIZSelect
              Items.Strings = (
                'I-V'
                'I-Z')
            end
          end
          object PanelScanF: TPanel
            Left = 277
            Top = 1
            Width = 193
            Height = 36
            BevelOuter = bvNone
            TabOrder = 2
            object SpdBtnRecord: TSpeedButton
              Left = 38
              Top = -2
              Width = 31
              Height = 27
              Hint = 'Save Current Frames to the Temp Directory'
              AllowAllUp = True
              GroupIndex = 11
              Down = True
              Glyph.Data = {
                F6060000424DF606000000000000360000002800000018000000180000000100
                180000000000C0060000415C0000415C00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFF7E9DAEBCAA5E2B581E2B47FE2B47FE2B47FE2B47FE2B47FE2B4
                7FE2B47FE2B47FE2B47FE2B47FE2B581EBCAA5F7E9DAFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFAF1E7D7984EC56A00C56A00C86D04CC730BCC730BCC730B
                CC730BCC730BCC730BCC730BCC730BCC730BCC730BC86D04C56A00C56A00D798
                4EFAF1E7FFFFFFFFFFFFFFFFFFF9F0E6CA7717C66B01E08F2FF6AD55FFB661FF
                B45EFFB45EFFB55EFFB55FFFB55FFFB55FFFB55FFFB55FFFB55FFFB55FFFB761
                F6AD55E08F2FC66B01CA7717F9F0E6FFFFFFFFFFFFD6964CC76C02F3A54AFB9A
                3CF98B26F9851DF8861EF8861FF88821F88A23F98B24F98B25F98D26F98F28FA
                9029FA902AFB922CFB9835FDA547F3A64BC76C02D6964CFFFFFFF6E9D9C56A00
                E79232F88621F7831CF8851DF8861EF8861FF88821F88A23F98B24F98B25F98D
                26F98F28FA9029FA902AFA922CFA932DFA942EFA952FFC9A36E79535C56A00F6
                E9D9EBCBA6C66B01F98B27F7831CF8851DF8861EF8861FF88821F88A23F98B24
                F98B25F98D26F98F28FA9029FA902AFA922CFA932DFA942EFA952FFB9731FB98
                33FC9E3CC66B01EBCBA6E2B581D67912F7831CF8851DF8861EF8861FF88821F8
                8A23F98B24F98B25F98D26F98F28FA9029FA902AFA922CFA932DFA942EFA952F
                FB9731FB9833FB9934FB9A35D77E17E2B581E2B47FE1801AF8851DF8861EF886
                1FF88821F88A23F98B24F98B25F98D26F98F28FA9029FA902AFA922CFA932DFA
                942EFA952FFB9731FB9833FB9934FB9A35FC9C36E28924E2B580E2B47FE2801A
                F8861EF8861EF88720F88922F98B24F98B24FBA453443EF00505FC0505FC0505
                FC0505FC3E38F2FCAA59FB9630FB9832FB9934FB9934FC9B36FC9D37E38A24E2
                B580E2B47FE2811AF8861EF88720F88922F98B24F98B24F98C267B6BDD0505FC
                0505FC0505FC0505FC0505FC0505FC7668DFFB9832FB9934FB9934FC9B36FC9D
                37FC9E39E38A24E2B580E2B47FE2811AF88720F88922F98B24F98B24F98C26F9
                8E274A43EF0505FC0505FC0505FC0505FC0505FC0505FC453FF0FB9934FB9934
                FC9B36FC9D37FC9E39FC9E39E38A25E2B580E2B47FE2811BF88922F98B24F98B
                24F98C26F98E27FA90294A43EF0505FC0505FC0505FC0505FC0505FC0505FC3E
                38F2FB9934FC9B36FC9D37FC9E39FC9E39FCA03BE38B26E2B580E2B47FE2821C
                F98B24F98B24F98C26F98E27FA9029FA9029443EF00505FC0505FC0505FC0505
                FC0505FC0505FC3E38F2FC9B36FC9D37FC9E39FC9E39FCA03BFDA23DE38C27E2
                B580E2B47FE2831DF98B24F98C26F98E27FA9029FA9029FA912B443EF00505FC
                0505FC0505FC0505FC0505FC0505FC3E38F2FC9D37FC9E39FC9E39FCA03BFDA2
                3DFDA33FE38C27E2B580E2B47FE2831DF98B25F98D26F98F28FA9029FA902AFA
                922CA88DC50505FC0505FC0505FC0505FC0505FC0505FCA58CC9FC9D38FC9E39
                FC9F3AFCA13CFDA23EFDA33FE38C27E2B580E2B47FE2831DF98D26F98F28FA90
                29FA902AFA922CFA932DFB9C3CDBAC9EAE91C3A98DC5A98DC5A98EC6D5AAA4FD
                A446FC9E39FC9F3AFCA13CFDA23EFDA33FFDA43FE38D27E2B580E2B47FDF821C
                F98F28FA9029FA902AFA922CFA932DFA942EFA952FFB9731FB9833FB9934FB9A
                35FC9C36FC9D38FC9E39FC9F3AFCA13CFDA23EFDA33FFDA43FFDA641E18A25E2
                B580E2B581D27A12FB9029FA902AFA922CFA932DFA942EFA952FFB9731FB9833
                FB9934FB9A35FC9C36FC9D38FC9E39FC9F3AFCA13CFDA23EFDA33FFDA43FFDA6
                41FFA742D37B14E2B581EBCBA6C66B01FCA142FA922CFA932DFA942EFA952FFB
                9731FB9833FB9934FB9A35FC9C36FC9D38FC9E39FC9F3AFCA13CFDA23EFDA33F
                FDA43FFDA641FEA742FEAE4FC66B01EBCBA6F6E9D9C56A00E59435FDA444FB95
                2FFA952FFB9731FB9833FB9934FB9A35FC9C36FC9D38FC9E39FC9F3AFCA13CFD
                A23EFDA33FFDA43FFDA641FFA742FFAF51E59435C56A00F6E9D9FFFFFFD6964C
                C76C02F2A74CFFB35AFEAA4CFDA545FDA443FDA443FDA545FDA645FDA747FDA7
                47FDA848FEAA49FEAA4BFEAA4BFEAD4DFFB154FFB65EF2A74CC76C02D6964CFF
                FFFFFFFFFFF9F0E6CA7717C66B01E08F2EF6AD53FFB862FFB963FFB963FFB963
                FFB963FFB963FFB963FFB963FFB963FFB963FFB963FFB862F6AD53E08F2EC66B
                01CA7717F9F0E6FFFFFFFFFFFFFFFFFFFAF1E7D7984EC56A00C56A00C86D04CC
                730ACC730ACC730ACC730ACC730ACC730ACC730ACC730ACC730ACC730AC86D04
                C56A00C56A00D7984EFAF1E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7E9
                DAEBCAA5E2B581E2B47FE2B47FE2B47FE2B47FE2B47FE2B47FE2B47FE2B47FE2
                B47FE2B47FE2B581EBCAA5F7E9DAFFFFFFFFFFFFFFFFFFFFFFFF}
              Layout = blGlyphBottom
              Visible = False
              OnClick = SpdBtnRecordClick
            end
            object SpdBtnFB: TSpeedButton
              Left = 7
              Top = 0
              Width = 31
              Height = 20
              Hint = ' FeedBack  Loop Turn On/Off'
              AllowAllUp = True
              GroupIndex = 12
              Down = True
              Caption = 'FB'
              Visible = False
              OnClick = SpdBtnFBClick
            end
            object SpeedBtnDelTop: TSpeedButton
              Left = 141
              Top = 1
              Width = 21
              Height = 21
              Hint = 'Plane Delete'
              AllowAllUp = True
              GroupIndex = 10
              Down = True
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFF0000000000000000000000000000000000FFFFFFFFFFFFFF000FFFFFFFFF
                9FFFF000FFFFFFF999FFFF000FFFFF9F9F9FFFF000FFFFFF9FFFFFFF000FFFFF
                9FFFFFFFF000FFFF9FFFFFFFFF000FFF9FFFFFFFFFF000FF9FFFFFFFFFFF000F
                9FFFFFFFFFFFF0009FFFFFFFFFFFFF000FFFFFFFFFFFFFF000FF}
              OnClick = SpeedBtnDelTopClick
            end
            object SpeedBtnSDelTop: TSpeedButton
              Left = 121
              Top = 2
              Width = 21
              Height = 21
              Hint = 'Surface Delete'
              AllowAllUp = True
              GroupIndex = 10
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
                7777000000000000000000000000000000000077777797777770007777799977
                7770700777979797770077077777977770077700777797777077777007779777
                0077777700779770077777777007970077777777770090077777777777700077
                7777777777777777777777777777777777777777777777777777}
              OnClick = SpeedBtnSDelTopClick
            end
            object SpeedBtnCapture: TSpeedButton
              Left = 71
              Top = -6
              Width = 26
              Height = 28
              Hint = 'Capture of Current Scan'
              Glyph.Data = {
                6E020000424D6E0200000000000076000000280000002A000000150000000100
                040000000000F801000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00700000000000
                00000000777777777777777777777700000073BBBBBBBBBBBBBBBBB077777777
                7777777777777700000073B033333333333333B0777777777777777777777700
                000073B0CCCCCCCCCCCCC3B0777777777777777777777700000073B0CCCCCCCC
                666663B0777777777777777777777700000073B0EEEEEE66666663B077777777
                7777777777777700000073B0EEEEEEE6666663B0777777777777777777777700
                000073B0EEEEEEEEEE6663B0777777777777777777777700000073B0EEBBBEEE
                EEEEE3B0777777777777777777777700000073B0EBBBBBEEEEEEE3B077777777
                7777777777777700000073B0EBBBBBEEEEEEE3B0777777777777777777777700
                000073B0EBBBBBEEEEEEE3B0777777777777777777777700000073B0EEBBBEEE
                EEEEE3B0777777777777777777777700000073B0EEEEEEEEEEEEE3B077777777
                7777777777777700000073B000000000000000B0777777777777777777777700
                000073BBBBBBBBBBBBBBBBB07777777777777777777777000000733333333333
                3333333077777777777777777777770000007777887777777778877777777777
                7777777777777700000077777788777778877777777777777777777777777700
                0000777777778878877777777777777777777777777777000000777777777707
                777777777777777777777777777777000000}
              NumGlyphs = 2
              Visible = False
              OnClick = SpeedBtnCaptureClick
            end
            object SpeedBtnPal: TSpeedButton
              Left = 163
              Top = 1
              Width = 21
              Height = 21
              Hint = 'Pallete'
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                1800000000000003000000000000000000000000000000000000FEFEFEFCFCFC
                FDFDFD969797929191ECE2E28276764E4242574E4E574E4E4E40408D8686EEE3
                E3FFFFFFFFFFFFFDFDFDFFFFFFFBFBFBFFFFFFC0BEBE1C1E1E476060307F7F19
                88881882821683831B90902B6E6E3652528B8E8EF0EFEFFEFFFFFCFCFCFFFFFF
                EBE9E88785863F9D9F56D2D25BECEE6BA1A1A43C3CA13E3E73959563D0D142BF
                BF175D5C6C7777FBF8F8FDFEFEEEEAEA88878768C8C768F2EC65DBD45DF6ECC2
                3B3AFF0000FF0000EB00007E737365F7F64FCECF0A4E4EC2BEBEFCFAFA8E9293
                50AEAE6FEFE8334FB41C29B83998CC67B9BAD44343F70B0BB8555554C5C45FDF
                DE60EAEB0E7A7B8E8D8DE9D9D9426F7259EBDD3F7CD00000EC0000FD0014C53F
                D0DB69E0DE79C4C451D6D657DCDC5EE0DF69ECEB177C7B9191919D8F8F699496
                63F0E450A2E80C07FF0000E8398AC265E7DE5CE4E60F9A9A2935356A82825CCE
                CC64EEEE1875759192925D4E4D97C4C564E5E95CDAC54B8CD63A74EE63D6D766
                E6E537C0C11733338B28287758586A87887AC9C9294B4BD7D3D366585791BBBE
                35B25B03A30A16A81A5BCA9860E2E55FDFDF61C7C74366663E39395C02026442
                42596E6E94999AFDFBFB63535092BEC516CB5B00BC0000B70010A22A5FDEE05A
                E7E371E1E163BDBC2EB0B0567171522424747676FFFEFEFFFFFF6E636097B6BD
                69E7C318C2242ACE4A40E6C160CED35BBBC753DDDC66EDEB5AB7B9557777AAAF
                AF6565658B8A8AE8E8E8C0BFBF82818180EAEF5ADAD55EE4E16992CBBD24C2BF
                0AC06D68B450EBE3175657D1C6C6FFFFFF9594940D0B0B5B5D5DD1D3D37D7776
                A2DCDE52E6DF71A4E6E400E7FF00FFF900EB8E7ABD31AFA55C6D70FEFDFDFBFB
                FBF0EFEF777474515050FBFCFC9692928CA2A56DFDF275A5E7D72DF7CF2FF5A6
                77DF46E8E2165B5CCFC5C6FEFFFFF9F9F9FFFFFFB7B8B8434444FEFEFEEAEBEB
                8C88888AA5A4A4DDDC80E4E583E8EA82D3CB226A6A92A0A0FFFEFEFCFCFCFDFD
                FDFEFEFEE3E3E3C8C8C8FCFCFCFFFFFFEAEBEB9E9999817C7C80838284848378
                7375ADA6A7FFFFFFFDFDFDFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF}
              OnClick = SpeedBtnPalClick
            end
            object SpeedBtnContrast: TSpeedButton
              Left = 98
              Top = 1
              Width = 21
              Height = 21
              Hint = 'Contrast'
              AllowAllUp = True
              GroupIndex = 1
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000120B0000120B00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFEEEEEEB3B3B38383836F6F6F6F6F6F828282AFAFAFEBEBEBFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB2B2B27C7C7CAFAFAFD3D3D3FF
                FFFF040404121212353535656565B0B0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                ADADAD9D9D9DDFDFDFE3E3E3E3E3E3FFFFFF0909090909090909090D0D0D4A4A
                4AADADADFFFFFFFFFFFFFFFFFFB5B5B5A1A1A1E6E6E6E5E5E5E5E5E5E5E5E5FF
                FFFF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F505050B2B2B2FFFFFFF1F1F1888888
                E6E6E6E8E8E8E8E8E8E8E8E8E8E8E8FFFFFF1616161616161616161616161616
                16181818777777E9E9E9BDBDBDBBBBBBEBEBEBEAEAEAEAEAEAEAEAEAEAEAEAFF
                FFFF1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E525252B5B5B59A9A9ADDDDDD
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDFFFFFF2626262626262626262626262626
                262626263636369595958D8D8DEFEFEFF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0FF
                FFFF2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E3333338A8A8A8E8E8EF4F4F4
                F3F3F3F2F2F2F2F2F2F2F2F2F2F2F2FFFFFF3636363636363636363636363636
                363636364C4C4C8E8E8EA4A4A4E6E6E6F6F6F6F5F5F5F5F5F5F5F5F5F5F5F5FF
                FFFF3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E7A7A7AA1A1A1C7C7C7CACACA
                FAFAFAF8F8F8F8F8F8F8F8F8F8F8F8FFFFFF4646464646464646464646464646
                464B4B4B9E9E9EC7C7C7F4F4F49D9D9DF6F6F6FBFBFBFAFAFAFAFAFAFAFAFAFF
                FFFF4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D9494949A9A9AF4F4F4FFFFFFCACACA
                B8B8B8FDFDFDFDFDFDFCFCFCFCFCFCFFFFFF5353535353535353535858589898
                98A4A4A4C8C8C8FFFFFFFFFFFFFFFFFFC6C6C6B8B8B8F9F9F9FFFFFFFEFEFEFF
                FFFF6262627777778A8A8AB3B3B3A7A7A7C5C5C5FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFCCCCCCA6A6A6CCCCCCE1E1E1FFFFFFBBBBBBB5B5B5AEAEAEA2A2A2CBCB
                CBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8D3D3D3BFBFBFA7
                A7A7A6A6A6BEBEBED1D1D1F7F7F7FFFFFFFFFFFFFFFFFFFFFFFF}
              Visible = False
              OnClick = SpeedBtnContrastClick
            end
          end
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 257
    Top = 219
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Copytoclipboard1: TMenuItem
        Caption = 'Copy to clipboard'
        Hint = 'Copy  to Clipboard'
        OnClick = CopytoClipboard1Click
      end
    end
  end
  object Timer: TTimer
    OnTimer = TimerUp
    Left = 174
    Top = 219
  end
  object ApplicationEvents: TApplicationEvents
    OnActionExecute = ApplicationEventsActionExecute
    OnException = ApplicationEventsException
    OnMessage = ApplicationEventsMessage
    Left = 174
    Top = 178
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 219
  end
  object siLangLinked1: TsiLangLinked
    Version = '6.5'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 2
    LangDispatcher = Main.siLangDispatcher1
    OnChangeLanguage = siLangLinked1ChangeLanguage
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Russian')
    Language = 'English'
    CommonContainer = Main.siLang1
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
    Left = 200
    Top = 96
    TranslationData = {
      737443617074696F6E730D0A545363616E576E64012053616D706C6520737572
      66616365207363616E6E696E6701D1EAE0EDE8F0EEE2E0EDE8E520EFEEE2E5F0
      F5EDEEF1F2E820EEE1F0E0E7F6E0010D0A4C6162656C5A015A01010D0A4C6162
      656C3133013101010D0A5461625368656574536964654C01546F706F67726170
      68792F2053696465205669657701D0E5EBFCE5F42F2020E8E7EEECE5F2F0E8FF
      010D0A5461625368656574546F706F4C01546F706F6772617068792F20546F70
      205669657701D0E5EBFCE5F42F20E2E8E420F1E2E5F0F5F3010D0A5461625368
      6565744D6174726978014D617472697820666F72206C6974686F677261706879
      01CCE0F2F0E8F6E020E4EBFF20EBE8F2EEE3F0E0F4E8E8010D0A4C6162656C37
      014E7801010D0A4C6162656C3134014E7901010D0A4C6162656C313501537465
      702C206E6D01D8E0E32C20EDEC010D0A4C6162656C416374696F6E0120204465
      7074682C206E6D01C3EBF3E1E8EDE02C20EDEC010D0A4C6162656C3137015469
      6D652C202001C2F0E5ECFF2C202020010D0A4C6162656C313801206D63730120
      ECEAF1010D0A42697442746E4C6F6164496D01264C6F616420696D61676501C7
      E0E3F0F3E7E8F2FC20010D0A42697442746E50726F6A656374012650726F6A65
      6374696F6E01D1EFF0EEE5EAF2E8F0EEE2E0F2FC010D0A526164696F54797065
      4C6974686F014C6974686F67726170687901CBE8F2EEE3F0E0F4E8FF010D0A55
      7041637401783201010D0A446F776E416374012F3201010D0A54616253686565
      74546F706F4572726F7201546F706F6772617068792F546F7020566965772049
      49205061737301D0E5EBFCE5F42F20E2E8E420F1E2E5F0F5F320494920CFF0EE
      F5EEE4010D0A5461625368656574546F706F5201546F706F6772617068792F20
      546F70205669657701D0E5EBFCE5F42F20E2E8E420F1E2E5F0F5F3010D0A5461
      62536865657450686173655201506861736520736869667401D4E0E7E0010D0A
      546162536865657455414D5201466F72636520696D61676501D1E8EBE0010D0A
      546162536865657453706563747252015370656374726F73636F707901D1EFE5
      EAF2F0EEF1EAEEEFE8FF010D0A5461625368656574437572520143757272656E
      7420696D61676501D2EEEA010D0A546162536865657446617374546F706F0146
      617374205363616E2F506861736520736869667401C1FBF1F2F0EEE520F1EAE0
      EDE8F0EEE2E0EDE8E52FF4E0E7E0010D0A54616253686565744C6974686F014C
      6974686F67726170687901CBE8F2EEE3F0E0F4E8FF010D0A5461625368656574
      5363616E5472616E014F6E65206C696E65207363616E6E696E6701D1EAE0EDE8
      F0EEE2E0EDE8E520EFEE20EEE4EDEEE920EBE8EDE8E8010D0A54616253686565
      7453656E730153656E73697669747920636F7272656374696F6E01010D0A5370
      6442746E464201464201CECED1010D0A4C6162656C466C74720146696C746572
      01D4E8EBFCF2F0010D0A4C6162656C4E6D016E6D01EDEC010D0A42697442746E
      436C436861727401436C6561720126CEF7E8F1F2E8F2FC010D0A436865636B42
      6F78447269667401666F6C6C6F77202064726966740120E4F0E5E9F4010D0A4C
      6162656C360120202020416374696F6E01C2EEE7E4E5E9F1F2E2E8E5010D0A43
      6F7079746F636C6970626F6172643101436F707920746F20636C6970626F6172
      6401CAEEEFE8F0EEE2E0F2FC20E220E1F3F4E5F020EEE1ECE5EDE0010D0A4564
      697431014564697401D0E5E4E0EAF2E8F0EEE2E0F2FC010D0A436865636B426F
      785253015253015253010D0A546F6F6C4261725363616E576E6401546F6F6C42
      61725363616E576E6401010D0A537461727442746E012653746172740126D1F2
      E0F0F2010D0A52537461727442746E0126526553746172740126CFEEE2F2EEF0
      E8F2FC010D0A4C616E64696E6742746E01204C616E64696E672001CFEEE4E2EE
      E4010D0A4F7074696F6E7342746E012020204F7074696F6E7320202001CFE0F0
      E0ECE5F2F0FB010D0A5361766545787042746E015361766520617301D1EEF5F0
      E0EDE8F2FC20EAE0EA010D0A53746F7042746E015326746F7001D126F2EEEF01
      0D0A546F6F6C42617248656C7001546F6F6C42617248656C7001010D0A416E69
      6D6174696F6E42746E01416E696D6174696F6E01C0EDE8ECE0F6E8FF010D0A48
      656C7042746E0148656C7001D1EFF0E0E2EAE0010D0A4C6162656C3139014441
      435A2064656C61792C206D6373014441435A20C7E0E4E5F0E6EAE02C20ECEAF1
      010D0A4C6162656C446563617949490144656361792C206D7301C7E0E4E5F0E6
      EAE02C20ECF1010D0A50616E656C546F7052696768740150616E656C546F7052
      6967687401010D0A54616253686565745363616E41726561014172656101CEE1
      EBE0F1F2FC010D0A4C626C596D6178014C626C596D617801010D0A4269744274
      6E4D67496E014601010D0A42697442746E4D674F7574015201010D0A42746E43
      6C65617201436C65617201CEF7E8F1F2E8F2FC010D0A4C626C586D6178014C62
      6C586D617801010D0A54616253686565744375724C696E650143757272656E74
      206C696E6501D2E5EAF3F9E0FF20EBE8EDE8FF010D0A54616253686565744375
      725363616E014865696768742C206E6D01C2FBF1EEF2E02C20EDEC010D0A5061
      6E656C380150616E656C3801010D0A50616E656C5363616E506172616D015061
      6E656C5363616E506172616D01010D0A4C6162656C3201202020202020536361
      6E6E696E6720506172616D657465727301CFE0F0E0ECE5F2F0FB20F1EAE0EDE8
      F0EEE2E0EDE8FF010D0A4C6162656C33014E5801010D0A4C6162656C34014E59
      01010D0A4C6162656C380156656C6F636974792001D1EAEEF0EEF1F2FC010D0A
      4C6162656C39015363616E6E696E672074696D652C207301C2F0E5ECFF2C20F1
      010D0A4672616D6554696D65014672616D6554696D6501010D0A4C6162656C31
      30015363616E204172656101D0E0E7ECE5F0010D0A4C6162656C3131012A0101
      0D0A4C6162656C31320128586E6D2A596E6D29012858EDEC2A59EDEC29010D0A
      4C6162656C35016E6D01EDEC010D0A4C6162656C3101446972656374696F6E01
      CDE0EFF0E0E2EBE5EDE8E5010D0A4C6162656C3136016E6D2F7301EDEC2F6301
      0D0A436865636B426F785374657001466978207374657020582C5901D4E8EAF1
      2E20F8E0E320582C59010D0A436865636B426F784F6E4E657473016F6E205253
      206E65747301EFEE20F3E7EBE0EC205253010D0A4170706C7942697442746E01
      264170706C7901CFF0E8ECE5EDE8F2FC010D0A426F7846617374015072657669
      6F757320206C696E6501CFF0E5E4FBE4F3F9E0FF20EBE8EDE8FF010D0A4C6162
      656C4C696E654E756D01204E756D62657201CDEEECE5F0010D0A4C6162656C48
      656967687401486569676874206E6D01C2FBF1EEF2E02C20EDEC010D0A546F6F
      6C4261723101546F6F6C4261723101010D0A546F6F6C427574746F6E3101416E
      696D6174696F6E01C0EDE8ECE0F6E8FF010D0A4C6162656C3230016D7301ECF1
      010D0A4C6162656C32310154696D652044656C617901C7E0E4E5F0E6EAE0010D
      0A546162536865657450726F66696C65720150726F66696C657201010D0A7374
      48696E74730D0A496D616765536964654C01546F706F677261706879203A2073
      69646520766965772001D0E5EBFCF43A20E2E8E420F1E1EEEAF3010D0A537065
      656442746E5344656C546F704C01537572666163652044656C65746501D3E4E0
      EBE8F2FC20EFEEE2E5F0F5EDEEF1F2FC010D0A537065656442746E44656C546F
      704C01506C616E652044656C65746501D3E4E0EBE8F2FC20EFEBEEF1EAEEF1F2
      FC010D0A537065656442746E436170747572654C0143617074757265206F6620
      43757272656E74205363616E01CFE5F0E5F5E2E0F2E8F2FC20F2E5EAF3F9E8E9
      20D1EAE0ED010D0A50616E656C4D6174726978014C6F616420496D6167652066
      6F72204C6974686F67726170687901C7E0E3F0F3E7E8F2FC20ECE0F1EAF320E4
      EBFF20EBE8F2EEE3F0E0F4E8E8010D0A4C6162656C3135017374657020582C59
      20666F72207468652070726F6A656374696F6E01F8E0E320D52CD320E4EBFF20
      EFF0EEE5EAF6E8E8010D0A4C6162656C416374696F6E01646565702061637469
      6F6E2001E3EBF3E1E8EDE020E2EEE7E4E5E9F2F1E2E8FF010D0A4C6162656C31
      370154696D6520416374696F6E20696E2074686520706F696E7401C2F0E5ECFF
      20E2EEE7E4E5E9F1F2E2E8FF20E220F2EEF7EAE5010D0A42697442746E4C6F61
      64496D014C6F616420496D61676520666F72204C6974686F67726170687901C7
      E0E3F0F3E7E8F2FC20ECE0F1EAF320E4EBFF20EBE8F2EEE3F0E0F4E8E8010D0A
      42697442746E50726F6A6563740150726F6A65637420496D616765204D617472
      6978206F6E20746865205363616E204172656101D1EFF0EEE5EAF2E8F0EEE2E0
      F2FC20ECE0F1EAF320EDE020EFEEEBE520F1EAE0EDE8F0EEE2E0EDE8FF010D0A
      42697442746E54696D654163740154696D6520416374696F6E20696E20746865
      20706F696E7401C2F0E5ECFF20E2EEE7E4E5E9F1F2E2E8FF20E220F2EEF7EAE5
      010D0A5570446F776E4163740144796E616D696320416D706C69666965722020
      6F6620416374696F6E01C4E8EDE0ECE8F7E5F1EAEEE520E8E7ECE5EDE5EDE8E5
      20E2EEE7E4E5E9F1F2E2E8FF010D0A557041637401496E637265617365206465
      70746820202878322901F3E2E5EBE8F7E8F2FC20E3EBF3E1E8EDF32028F53229
      010D0A446F776E41637401446563726561736520646570746820282F322901F3
      ECE5EDFCF8E8F2FC20E3EBF3E1E8EDF320282F3229010D0A537065656442746E
      506C64656C4C01506C616E652044656C65746501D3E4E0EBE8F2FC20EFEBEEF1
      EAEEF1F2FC010D0A537065656442746E53757244656C4C015375726661636520
      44656C65746501D3E4E0EBE8F2FC20EFEEE2E5F0F5EDEEF1F2FC010D0A537065
      656442746E4361704C0143617074757265206F662043757272656E7420536361
      6E01CFE5F0E5F5E2E0F2E8F2FC20F2E5EAF3F9E8E920D1EAE0ED010D0A546162
      536865657446617374546F706F0143757272656E7420496D61676501D2EEEA01
      0D0A54616253686565744C6974686F014C69746F67726170687901CBE8F2EEE3
      F0E0F4E8FF010D0A54616253686565745363616E5472616E014D756C74692074
      696D6573207363616E6E696E6720616C6F6E6720582D6178657301C4E2F3EFF0
      EEF5EEE4EDEEE520F1EAE0EDE8F0EEE2E0EDE8E520E2E4EEEBFC20EEF1E820D5
      010D0A53706442746E5265636F726401536176652043757272656E7420467261
      6D657320746F207468652054656D70204469726563746F727901D1EEF5F0E0ED
      E8F2FC20F2E5EAF3F9E8E920F1EAE0ED20E2EE20E2F0E5ECE5EDEDFBE920E4E8
      F0E5EAF2EEF0E8E9010D0A53706442746E46420120466565644261636B20204C
      6F6F70205475726E204F6E2F4F666601C2EAEB2FC2FBEAEB2020EFE5F2EBFE20
      EEE1F0E0F2EDEEE920F1E2FFE7E8010D0A42697442746E436C43686172740143
      6C656172205370656374726F73636F7079204172656101CEF7E8F1F2E8F2FC20
      EFEEEBE520F1EFE5EAF2F0EEF1EAEEEFE8E820010D0A537065656442746E4465
      6C546F7001506C616E652044656C65746501D3E4E0EBE8F2FC20EFEBEEF1EAEE
      F1F2FC010D0A537065656442746E5344656C546F700153757266616365204465
      6C65746501D3E4E0EBE8F2FC20EFEEE2E5F0F5EDEEF1F2FC010D0A5370656564
      42746E436170747572650143617074757265206F662043757272656E74205363
      616E01CFE5F0E5F5E2E0F2E8F2FC20F2E5EAF3F9E8E920D1EAE0ED010D0A5370
      65656442746E50616C0150616C6C65746501CFE0EBE8F2F0E0010D0A53706565
      6442746E436F6E747261737401436F6E747261737401CAEEEDF2F0E0F1F2010D
      0A436F7079746F636C6970626F6172643101436F70792020746F20436C697062
      6F61726401D1EAEEEFE8F0EEE2E0F2FC20E220E1F3F4E5F020EEE1ECE5EDE001
      0D0A42697442746E4D67496E015365742046696E6520526567696D6501D3F1F2
      E0EDEEE2E8F2FC2046696E6520F0E5E6E8EC010D0A42697442746E4D674F7574
      0153657420526F75676820526567696D6501D3F1F2E0EDEEE2E8F2FC20526F75
      676820F0E5E6E8EC010D0A42697442746E537101436C69636B20746F20447261
      7720537175617265205363616E01CEE1EBE0F1F2FC20F1EAE0EDE8F0EEE2E0ED
      E8FF20EAE2E0E4F0E0F2010D0A42697442746E5265637401436C69636B20746F
      20447261772052656374616E676C65205363616E01CEE1EBE0F1F2FC20F1EAE0
      EDE8F0EEE2E0EDE8FF20EFF0FFECEEF3E3EEEBFCEDE8EA010D0A42697442746E
      58305930015365742058303B593020506F696E742001C2FBE1F0E0F2FC20F2EE
      F7EAF320D5302ED330010D0A42746E5A6F6F6D015A6F6F6D205363616E204172
      656101D3E2E5EBE8F7E8F2FC20EEEAEDEE20EEF2EEE1F0E0E6E5EDE8FF20EEE1
      EBE0F1F2E820F1EAE0EDE8F0EEE2E0EDE8FF010D0A496D6167655363616E4172
      65610144726177204672616D65206279204D6F7573652820646F776E206C6566
      7420627574746F6E29206F72204D6F7665204672616D652028646F776E207269
      676874206275746F6E2901CDE0F0E8F1EEE2E0F2FC20EDEEE2F3FE20EEE1EBE0
      F1F2FC20F1EAE0EDE8F0EEE2E0EDE8FF20F120EFEEECEEF9FCFE20ECFBF8E820
      28EBE5E2E0FF20EAEDEEEFEAE02920EFE5F0E5F2E0F1EAE8E2E0F2FC20EEE1EB
      E0F1F2FC202820EFF0E0E2E0FF20EAEDEEEFEAE029010D0A5461625368656574
      4375724C696E6501546F706F677261706879204C696E6501D2E5EAF3F9E0FF20
      EBE8EDE8FF20F1EAE0EDE0010D0A537065656442746E506C44656C01506C616E
      652044656C65746501D3E4E0EBE8F2FC20EFEBEEF1EAEEF1F2FC010D0A426974
      42746E5A6F6F6D4375724C696E65015A6F6F6D2043757272656E74204C696E65
      01D3E2E5EBE8F7E8F2FC20EEEAEDEE20EEF2EEE1F0E0E6E5EDE8FF20F2E5EAF3
      F9E5E920EBE8EDE8E8010D0A42697442746E31015A6F6F6D2043757272656E74
      204C696E6501D3E2E5EBE8F7E8F2FC20EEEAEDEE20EEF2EEE1F0E0E6E5EDE8FF
      20F2E5EAF3F9E5E920EBE8EDE8E8010D0A42697442746E4F70656E4C6F636B01
      436F6E73747261696E2050726F706F7274696F6E7301C8E7ECE5EDE5EDE8E520
      F1EAEEF0EEF1F2E820EFF0FFECEEE3EE20E820EEE1F0E0F2EDEE20F5EEE4E020
      EDE5E7E0E2E8F1E8ECFB010D0A4C6162656C3301506F696E7473206E756D6265
      7220696E207363616E01D7E8F1EBEE20F2EEF7E5EA20E220F1EAE0EDE5010D0A
      4C6162656C34014C696E65206E756D62657201CDEEECE5F020EBE8EDE8E8010D
      0A4C6162656C3130014672616D6520617265613A202078202D7363616E206C65
      6E6774683B2020792D207363616E20776964746820696E206E6D01CEE1EBE0F1
      F2FC20F1EAE0EDE8F0EEE2E0EDE8FF3A20F52D20E4EBE8EDE020F1EAE0EDE03B
      20F32D20F8E8F0E8EDE020F1EAE0EDE020E220EDEC010D0A45645363616E5261
      746501466F72776172642056656C6F6369747901D1EAEEF0EEF1F2FC20EFF0E8
      20E4E2E8E6E5EDE8E820E2EFE5F0E5E4010D0A436865636B426F785374657001
      43686F6F7365204172656120207769746820436F6E7374616E74205374657001
      C2FBE1F0E0F2FC20EEE1EBE0F1F2FC20F1EAE0EDE8F0EEE2E0EDE8FF20F120F4
      E8EAF1E8F0EEE2E0EDEDFBEC20F8E0E3EEEC010D0A45645363616E5261746542
      57014261636B776172642056656C6F6369747901D1EAEEF0EEF1F2FC20EFF0E8
      20EEE1F0E0F2EDEEEC20E4E2E8E6E5EDE8E8010D0A42697442746E4C6F636B01
      436F6E73747261696E2050726F706F7274696F6E7301C8E7ECE5EDE5EDE8E520
      F1EAEEF0EEF1F2E820EFF0FFECEEE3EE20E820EEE1F0E0F2EDEE20F5EEE4E020
      EFF0EEEFEEF0F6E8EEEDE0EBFCEDFB010D0A4170706C7942697442746E014170
      706C79207363616E206172656120706172616D657465727301CFF0E8ECE5EDE8
      F2FC20EFE0F0E0ECE5F2F0FB20F1EAE0EDE8F0EEE2E0EDE8FF010D0A4C616265
      6C4C696E654E756D0143757272656E74206C696E65206E756D62657201CDEEEC
      E5F020F2E5EAF3F9E5E920EBE8EDE8E8010D0A4C6162656C4865696768740150
      726576696F73206C696E652068656967687401C2FBF1EEF2E020F0E5EBFCE5F4
      E020EFF0E5E4FBE4F3F9E5E920EBE8EDE8E8010D0A7374446973706C61794C61
      62656C730D0A7374466F6E74730D0A545363616E576E640144656661756C7401
      44656661756C74010D0A50616E656C370144656661756C740144656661756C74
      010D0A4C6162656C5A0144656661756C740144656661756C74010D0A4C616265
      6C5A560144656661756C740144656661756C74010D0A4C6162656C3135014465
      6661756C740144656661756C74010D0A4C6162656C416374696F6E0144656661
      756C740144656661756C74010D0A4C6162656C31370144656661756C74014465
      6661756C74010D0A4C6162656C31380144656661756C740144656661756C7401
      0D0A42697442746E4C6F6164496D0144656661756C740144656661756C74010D
      0A526164696F547970654C6974686F0144656661756C740144656661756C7401
      0D0A5461625368656574546F706F520144656661756C740144656661756C7401
      0D0A546162536865657455414D520144656661756C740144656661756C74010D
      0A5061676543746C4C6566740144656661756C740144656661756C74010D0A50
      61676543746C52696768740144656661756C740144656661756C74010D0A436F
      6D626F426F78495A0144656661756C740144656661756C74010D0A4C6162656C
      360144656661756C740144656661756C74010D0A42697442746E50726F6A6563
      740144656661756C74015461686F6D61010D0A50616E656C360144656661756C
      74015461686F6D61010D0A506167654374726C5363616E0144656661756C7401
      44656661756C74010D0A4C626C596D61780144656661756C740144656661756C
      74010D0A42697442746E4D67496E0144656661756C740144656661756C74010D
      0A42697442746E4D674F75740144656661756C740144656661756C74010D0A42
      746E436C6561720144656661756C740144656661756C74010D0A4C626C586D61
      780144656661756C740144656661756C74010D0A4C6162656C32014465666175
      6C740144656661756C74010D0A4C6162656C31310144656661756C7401446566
      61756C74010D0A4C6162656C310144656661756C740144656661756C74010D0A
      45645374657058590144656661756C740144656661756C74010D0A436F6D626F
      426F78506174680144656661756C740144656661756C74010D0A45645363616E
      4E4D620144656661756C740144656661756C74010D0A4564447A014465666175
      6C740144656661756C74010D0A5369676E616C734D6F64650144656661756C74
      0144656661756C74010D0A73744D756C74694C696E65730D0A526164696F5479
      70654C6974686F2E4974656D7301466F7263652C43757272656E7401D1E8EBE0
      2CD2EEEA010D0A436F6D626F426F7846696C7465722E4974656D73014E6F6E65
      2C22417620337833222C2241762035783522014E6F6E652C2241762033783322
      2C2241762035783522010D0A436F6D626F426F78495A2E4974656D7301492D56
      2C492D5A01492D562C492D5A010D0A526164696F47726F757042572E4974656D
      7301426C61636B2D77686974652C4772617928382901D7E5F0EDEE2DE1E5EBE0
      FF2C22C3F0E0E4E0F6E8E820F1E5F0EEE3EE28382922010D0A436F6D626F426F
      78506174682E4974656D7301582B2C592B01010D0A7374537472696E67730D0A
      4944535F31303001546F706F6772617068792F20546F70205669657701D0E5EB
      FCE5F42FE2E8E420F1E2E5F0F5F3010D0A4944535F31303501546F706F677261
      7068792F546F702056696577204949205061737301D0E5EBFCE5F42FE2E8E420
      F1E2E5F0F5F320494920EFF0EEF5EEE4010D0A4944535F313036015068617365
      20536869667401D4E0E7E0010D0A4944535F3130370150686173652049492050
      61737301D4E0E7E020EFF0EEF5EEE4204949010D0A4944535F31303801506861
      73652C20612E7501D4E0E7E02C20EFF02EE5E42E010D0A4944535F3130390146
      6F726365496D616765204949205061737301D1E8EBE020494920EFF0EEF5EEE4
      010D0A4944535F31313001466F7263652C206D5601D1E8EBE02C20ECC2010D0A
      4944535F31313101466F72636520496D61676501D1E8EBE0010D0A4944535F31
      3132014E6F7420617661696C61626C6520696E205370656374726F73636F7079
      206D6F646501CDE520E4EEF1F2F3EFEDEE20E220ECEEE4E520F1EFE5EAF2F0EE
      F1EAEEEFE8FF010D0A4944535F313133014D616B65205363616E6E696E672062
      65666F7265205370656374726F73636F7079212101C2FBEFEEEBEDE8F2E520F1
      EAE0EDE8F0EEE2E0EDE8E52020EFF0E5E6E4E52C20F7E5EC20F1E4E5EBE0F2FC
      20F1EFE5EAF2F0EEF1EAEEEFE8FE2E010D0A4944535F31313401537065637472
      6F73636F707901D1EFE5EAF2F0EEF1EAEEEFE8FF010D0A4944535F3131370153
      70656374726F73636F70792F2043757272656E742D566F6C7461676520636861
      726163746572697374696373202001D1EFE5EAF2F0EEF1EAEEEFE8FF2F20492D
      5620F5E0F0E0EAF2E5F0E8F1F2E8EAE0010D0A4944535F31313801466F726365
      205370656374726F73636F70792F4F7363696C6C6174696F6E2041706D6C6974
      7564652D73616D706C652064697374616E636501D1E8EBEEE2E0FF20F1EFE5EA
      F2F0EEF1EAEEEFE8FF2F20E0ECEFEBE8F2F3E4E02D20F0E0F1F1F2EEFFEDE8E5
      20E4EE20EEE1F0E0E7F6E0010D0A4944535F3131390143757272656E742C206E
      4101D2EEEA2C20EDC0010D0A4944535F3132300143757272656E742049492050
      61737301D2EEEA20494920EFF0EEF5EEE4010D0A4944535F3132320143757272
      656E7401D2EEEA010D0A4944535F313233014672616D657301D4F0E5E9ECEEE2
      010D0A4944535F3132350146617374205363616E6E696E672F43757272656E74
      2056697369616C697A6174696F6E3B202001C1FBF1F2F0EEE520D1EAE0EDE8F0
      EEE2E0EDE8E5202FD2EEEA010D0A4944535F3132360146617374205363616E6E
      696E672F50686173652053686966742056697369616C697A6174696F6E3B2020
      01C1FBF1F2F0EEE520D1EAE0EDE8F0EEE2E0EDE8E5202FD1E4E2E8E320F4E0E7
      FB010D0A4944535F313237014C6974686F67726170687901CBE8F2EEE3F0E0F4
      E8FF010D0A4944535F313239014F6E65204C696E65204949205061737301CEE4
      EDE020EBE8EDE8FF20494920CFF0EEF5EEE4010D0A4944535F313331014D756C
      74692074696D6573207363616E6E696E6720616C6F6E6720582D61786965733A
      204E782D20706F696E74733B204E792D2074696D657301CCEDEEE3EEEAF0E0F2
      EDEEE52020F1EAE0EDE8F0EEE2E0EDE8E520E2E4EEEBFC20EEF1E820D53A4E78
      2D20F2EEF7E5EA3B204E792DF0E0E72E20010D0A4944535F313332014D756C74
      692074696D6573207363616E6E696E6720616C6F6E6720592D61786965733A20
      4E792D20706F696E74733B204E782D2074696D657301CCEDEEE3EEEAF0E0F2ED
      EEE520F1EAE0EDE8F0EEE2E0EDE8E520E2E4EEEBFC20EEF1E820D33A4E792D20
      F2EEF7E5EA3B204E782DF0E0E72E20010D0A4944535F313333014D756C746920
      74696D65732074776F2070617373207363616E6E696E6720616C6F6E6720582D
      61786965733A204E782D20706F696E74733B204E792D2074696D657301C4E2F3
      EFF0EEF5EEE4EDEEE520F1EAE0EDE8F0EEE2E0EDE8E520E2E4EEEBFC20EEF1E8
      20D53A4E782D20F2EEF7E5EA3B204E792DF0E0E72E20010D0A4944535F313334
      014D756C74692074696D65732074776F2070617373207363616E6E696E672061
      6C6F6E6720592D61786965733A204E592D20706F696E74733B204E782D207469
      6D657301C4E2F3EFF0EEF5EEE4EDEEE520F1EAE0EDE8F0EEE2E0EDE8E520E2E4
      EEEBFC20EEF1E820D33A4E792D20F2EEF7E5EA3B204E782DF0E0E72E20010D0A
      4944535F31353001496E707574205920706172616D65746572212101C2E2E5E4
      E8F2E52059010D0A4944535F313532015A65726F20696E70757401C2E2E5E4E5
      EDEE20EDF3EBE5E2EEE520E7EDE0F7E5EDE8E5010D0A4944535F313732016572
      726F7220696E70757401CEF8E8E1EAE020E2E2EEE4E0010D0A4944535F313835
      0146617374205363616E2F43757272656E7401C1FBF1F2F0EEE520F1EAE0EDE8
      F0EEE2E0EDE8E5202FD2EEEA010D0A4944535F3138360146617374205363616E
      2F506861736501C1FBF1F2F0EEE520F1EAE0EDE8F0EEE2E0EDE8E52FF4E0E7E0
      010D0A4944535F313935016572726F7220696E707574204E7801CEF8E8E1EAE0
      20E2E2EEE4E0204E78010D0A4944535F3139014F5554206D656D6F727920546F
      706F53504D01CDE520F5E2E0F2E0E5F220EEEFE5F0E0F2E8E2EDEEE92020EFE0
      ECFFF2E820E4EBFF20F1EAE0EDE0010D0A4944535F31015363616E204669656C
      64204572726F7201D0E0E7ECE5F020D1EAE0EDE020E7E0E4E0ED20EDE5E2E5F0
      EDEE010D0A4944535F32303301596F752068617665206368616E676564205363
      616E506172616D65746572732E205072657373204170706C7920627574746F6E
      2C206265666F7265206368616E676520646972656374696F6E2101C2FB20E8E7
      ECE5EDE8EBE820EFE0F0E0ECE5F2F0FB20F1EAE0EDE8F0EEE2E0EDE8FF2E20CD
      E0E6ECE8F2E520EAEDEEEFEAF32022CFF0E8ECE5EDE8F2FC222C20EFF0E5E6E4
      E520F7E5EC20E8E7ECE5EDE8F2FC20EDE0EFF0E0E2EBE5EDE8E521010D0A4944
      535F323035015363616E6E696E6720616C6F6E672061786973205801D1EAE0ED
      E8F0EEE2E0EDE8E520E2E4EEEBFC20EEF1E820D521010D0A4944535F32303601
      5363616E6E696E6720616C6F6E672061786973205901D1EAE0EDE8F0EEE2E0ED
      E8E520E2E4EEEBFC20EEF1E8205921010D0A4944535F3230370154776F205061
      7373205363616E6E696E6720616C6F6E672061786973205801C4E2E020EFF0EE
      F5EEE4E020EFF0E820F1EAE0EDE8F0EEE2E0EDE8E520E2E4EEEBFC20EEF1E820
      582E010D0A4944535F3230380154776F2050617373205363616E6E696E672061
      6C6F6E672061786973205901C4E2E020EFF0EEF5EEE4E020EFF0E820F1EAE0ED
      E8F0EEE2E0EDE8E520E2E4EEEBFC20EEF1E820592E010D0A4944535F32313201
      44656D6F204C6974686F6772617068792066696C65206E6F7420657869737473
      21212101C4E5ECEE20F4E0E9EB20E4EBFF20EBE8F2EEE3F0E0F4E8E820EDE520
      F1F3F9E5F1F2E2F3E5F221010D0A4944535F3231014572726F72212101CEF8E8
      E1EAE021010D0A4944535F323237015363616E6E65722044657369676E01C4E8
      E7E0E9ED20F1EAE0EDE5F0E02E010D0A4944535F3232014D6178696D616C2076
      616C756520582069732065786365656465642E20526564756365206120666965
      6C64206F66207363616E6E696E672E01CFF0E5E2FBF8E5EDEE20ECE0EAF12E20
      E7EDE0F7E5EDE8E520D52E20D3ECE5EDFCF8E8F2E520EFEEEBE520F1EAE0EDE8
      F0EEE2E0EDE8FF2E010D0A4944535F3233370150726F6A656374696F6E206578
      65656473205363616E204669656C64204C696D6974732E2001CFF0EEE5EAF6E8
      FF20EFF0E5E2FBF8E0E5F220ECE0EAF12E20EFEEEBE520F1EAE0EDE5E8F0EEE2
      E0EDE8FF010D0A4944535F323338015368696674205363616E204669656C6420
      6F722064656372656173652053746570205859202001D1E4E2E8EDFCF2E520EF
      EEEBE520F1EAE0EDE8F0EEE2E0EDE8FF20E8EBE820F3ECE5EDFCF8E8F2E520F8
      E0E320D5D320202020010D0A4944535F323339012020746F20200120E4EE2001
      0D0A4944535F3234300120206E6D012020EDEC010D0A4944535F323431016572
      726F7220696E707574204E7901CEF8E8E1EAE02020E2E2EEE4E0204E79010D0A
      4944535F32343701596F752068617665206368616E676564205363616E506172
      616D65746572732E205072657373204170706C7920627574746F6E2C20626566
      6F726520746F2063686F6F7365206E657720726567696D652001C2FB20E8E7EC
      E5EDE8EBE820EFE0F0E0ECE5F2F0FB2E20CDE0E6ECE8F2E520EAEDEEEFEAF320
      CFF0E8ECE5EDE8F2FC2C20EFF0E5E6E4E520F7E5EC20F1ECE5EDE8F2FC20F0E5
      E6E8EC2E010D0A4944535F3234390143757272656E74204C696E652001D2E5EA
      F3F9E0FF20EBE8EDE8FF2E010D0A4944535F3234014D6178696D616C2076616C
      756520592069732065786365656465642E205265647563652061206669656C64
      206F66207363616E6E696E672E01CFF0E5E2FBF8E5EDEE20ECE0F520E7EDE0F7
      E5EDE8E520592E20D3ECE5EDFCF8E8F2E520EFEEEBE520F1EAE0EDE8F0EEE2E0
      EDE8FF2E010D0A4944535F323537016E6F2044656D6F204461746121212101ED
      E5F220E4E5ECEE20E4E0EDEDFBF521010D0A4944535F323636016572726F7220
      696E707574204E5801CEF8E8E1EAE02020E2E2EEE4E0204EF52E010D0A494453
      5F320146696E650146696E65010D0A4944535F33300144656D6F01C4E5ECEE01
      0D0A4944535F33340144656D6F2121202001C4E5ECEE212121010D0A4944535F
      3338014E6F20496E746572616374696F6E2121212101CDE5F220E2E7E0E8ECEE
      E4E5E9F1F2E2E8FF010D0A4944535F343001202020202044657074682C206E6D
      012020C3EBF3E1E8EDE02C20EDEC010D0A4944535F3431012020202020202042
      6961732C205601CDE0EFF0FFE6E5EDE8E52C20C2010D0A4944535F3433017468
      6520496E64696361746F72205A01C8EDE4E8EAE0F2EEF0205A010D0A4944535F
      3434014865696768742C206E6D01C2FBF1EEF2E02C20EDEC010D0A4944535F34
      370153616D706C652053757266616365205363616E6E696E673B2053544D2046
      696E6520526567696D650120D1D2CC3B202246696E652220F0E5E6E8EC010D0A
      4944535F34380153616D706C652053757266616365205363616E6E696E673B20
      53544D20526F75676820526567696D650120D1D2CC3B20010D0A4944535F3439
      0120206E410120EDC0010D0A4944535F35300120560120C2010D0A4944535F35
      320153616D706C652053757266616365205363616E6E696E673B2053464D2046
      696E6520526567696D6501D1D1CC3B202246696E652220F0E5E6E8EC010D0A49
      44535F35330153616D706C652053757266616365205363616E6E696E673B2053
      464D20526F75676820526567696D6501D1D1CC3B20010D0A4944535F35380154
      6F706F67726170687901D0E5EBFCE5F4010D0A4944535F3539015363616E6E69
      6E6720616C6F6E67206178696573205801D1EAE0EDE8F0EEE2E0EDE8E520E2E4
      EEEBFC20EEF1E82058010D0A4944535F36300154776F2050617373205363616E
      6E696E6720616C6F6E67206178696573205801D1EAE0EDE8F0EEE2E0EDE8E520
      E2E4EEEBFC20EEF1E820D520494920EFF0EEF5EEE4010D0A4944535F36310153
      63616E6E696E6720616C6F6E67206178696573205901D1EAE0EDE8F0EEE2E0ED
      E8E520E2E4EEEBFC20EEF1E82059010D0A4944535F36320154776F2050617373
      205363616E6E696E6720616C6F6E67206178696573205901D1EAE0EDE8F0EEE2
      E0EDE8E520E2E4EEEBFC20EEF1E8205920494920EFF0EEF5EEE4010D0A494453
      5F3731012652554E0126D1F2E0F0F2010D0A4944535F373201596F7520686176
      65206368616E676564205363616E506172616D65746572732E20507265737320
      4170706C7920627574746F6E2C206265666F7265207374617274205363616E20
      01C2FB20E8E7ECE5EDE8EBE820EFE0F0E0ECE5F2F0FB2E20CDE0E6ECE8F2E520
      EAEDEEEFEAF32022CFF0E8ECE5EDE8F2FC22202C20EFF0E5E6E4E520F7E5EC20
      EDE0F7E0F2FC20F1EAE0EDE8F0EEE2E0F2FC2E010D0A4944535F3733014D616B
      65207363616E6E6572206C696E656172697A6174696F6E2101C2FBEFEEEBEDE8
      F2E520EBE8EDE5E0F0E8E7E0F6E8FE20F1EAE0EDE5F0E0010D0A4944535F3734
      01596F75207363616E20776974686F7574206C696E65616C697A6174696F6E21
      20436F6E74696E7565207363616E3F01C2FB20F1EAE0EDE8F0F3E5F2E520E1E5
      E720EBE8EDE5E0F0E8E7E0F6E8E8010D0A4944535F3735012653544F5001D126
      F2EEEF010D0A4944535F3737014C6F616420496D61676520666F72204C697468
      6F67726170687921212101C7E0E3F0F3E7E8F2E520ECE0F1EAF320E4EBFF20EB
      E8F2EEE3F0E0F4E8E8010D0A4944535F37380150726F6A656374204D61747269
      78206F6E20746865204172656121212101D1EFF0EEE5EAF2E8F0F3E9F2E520EC
      E0F2F0E8F6F320EDE020EEE1EBE0F1F2FC20EBE8F2EEE3F0E0F4E8E8010D0A49
      44535F383701496E70757420706F696E747320666F72205370656374726F7363
      6F7079212101C2E2E5E4E8F2E520F2EEF7EAE820E4EBFF20F1EFE5EAF2F0EEF1
      EAEEEFE8E8010D0A4944535F380153746F70205363616E206265666F72652063
      68616E676520706172616D657465727320616E64207468656E20726570656174
      207361766501CEF1F2E0EDEEE2E8F2E520F1EAE0EDE8F0EEE2E0EDE8E52020EF
      F0E5E6E4E52C20F7E5EC20ECE5EDFFF2FC20EFE0F0E0ECE5F2F0FB20E820EFEE
      E2F2EEF0E8F2E520F1EEF5F0E0EDE5EDE8E52E010D0A4944535F39300166696C
      65202701F4E0E9EB27010D0A4944535F3931016E6F742066696E6401EDE520ED
      E0E9E4E5ED010D0A4944535F3932016572726F722066696C65206E616D652027
      01EEF8E8E1EAE020E8ECE5EDE820F4E0E9EBE027010D0A4944535F3934012061
      63636570742064656E6965642001C220E4EEF1F2F3EFE520EEF2EAE0E7E0EDEE
      2E010D0A4944535F3935016469736B2069732066756C6C01E4E8F1EA20EFE5F0
      E5EFEEEBEDE5ED21010D0A4944535F393601696E707574206572726F722001CE
      F8E8E1EAE020E2E2EEE4E0010D0A4944535F3937012074727920616761696E21
      01CFEEEFFBF2E0E9F2E5F1FC20E5F9E520F0E0E721010D0A4944535F3901206E
      6D0120EDEC010D0A73747273747252756E0152554E0126D1F2E0F0F2010D0A73
      7472737472526552756E01526553544152540126CFEEE2F2EEF0E8F2FC010D0A
      73747273747253746F700153544F5001D126F2EEEF010D0A4944535F33014572
      726F7220647572696E67205363616E576F726B282920657865637574696F6E01
      CEF8E8E1EAE020E2EE20E2F0E5ECFF20E2FBEFEEEBEDE5EDE8FF205363616E57
      6F726B010D0A4944535F3130014865696768742C206E6D3B20494901C2FBF1EE
      F2E02C20EDEC3B204949010D0A4944535F31310150686173652C20612E753B20
      494901D4E0E7E02C20EFF02EE5E42E3B4949010D0A4944535F313201466F7263
      652C206D763B20494901D1E8EBE02C20ECC23B204949010D0A4944535F313301
      43757272656E742C206E413B20494901D2EEEA2C20EDC03B204949010D0A4944
      535F3137012653544152540126D1F2E0F0F2010D0A7374727363616E31014D61
      782056616C696420506F696E7473204E756D62657220666F7220746869732053
      63616E206C656E6774682069733A2025642001CCE0EAF1E8ECE0EBFCEDEEE520
      EAEEEBE8F7E5F1F2E2EE20F2EEF7E5EA20EDE020EBE8EDE8E83A20256420010D
      0A7374727363616E32013B20205363616E204669656C64204572726F72212121
      013B20CEF8E8E1EAE020E7E0E4E0EDE8FF20EFEEEBFF20F1EAE0EDE8F0EEE2E0
      EDE8FF010D0A7374727363616E33014E6F20496E746572616374696F6E212121
      2101D1EAE0EDE8F0EEE2E0EDE8E520E1E5E720E2E7E0E8ECEEE4E5E9F1F2E2E8
      FF2121010D0A7374727363616E3401596F752068617665206368616E67656420
      5363616E506172616D65746572732E205072657373204170706C792062757474
      6F6E2C206265666F7265207374617274205363616E2001C2FB20E8E7ECE5EDE8
      EBE820EFE0F0E0ECE5F2F0FB20F1EAE0EDE8F0EEE2E0EDE8FF2E20CDE0E6ECE8
      F2E520EAEEEDEFEAF32022CFF0E8ECE5EDE8F2FC2220EFE5F0E5E420EDE0F7E0
      EBEEEC2020F1EAE0EDE8F0EEE2E0EDE8FF2E010D0A7374727363616E35014D61
      6B65207363616E6E6572206C696E656172697A6174696F6E2101CBE8EDE5E0F0
      E8E7F3E9F2E520F1EAE0EDE5F02121010D0A7374727363616E3601596F752073
      63616E20776974686F7574206C696E65616C697A6174696F6E2120436F6E7469
      6E7565207363616E3F01C2FB20F1EAE0EDE8F0F3E5F2E520E1E5E720EBE8EDE5
      E0F0E8E7E0F6E8E82120CFF0EEE4EEEBE6E8F2FC20F1EAE0EDE8F0EEE2E0EDE8
      E53F010D0A7374727363616E37014C6F616420496D61676520666F72204C6974
      686F67726170687921212101C7E0E3F0F3E7E8F2E520EAE0F0F2E8EDEAF320E4
      EBFF20EBE8F2EEE3F0E0F4E8E82121010D0A7374727363616E380150726F6A65
      6374204D6174726978206F6E20746865204172656121212101D1EFF0EEE5EAF2
      E8F0F3E9F2E520EAE0F0F2E8EDEAF320EDE020EEE1EBE0F1F2FC20EBE8F2EEE3
      F0E0F4E8E821010D0A7374727363616E3901496E70757420706F696E74732066
      6F72205370656374726F73636F7079212101C2E2E5E4E8F2E520F2EEF7EAE820
      E4EBFF20F1EFE5EAF2F0EEF1EAEEEFE8E821010D0A7374727363616E31300154
      727920616761696E2101CFEEEFFBF2E0E9F2E5F1FC20E5F9E520F0E0E721010D
      0A7374727363616E3131014D616B65205363616E6E696E67206265666F726520
      5370656374726F73636F7079212101C2FBEFEEEBEDE8F2E520F1EAE0EDE8F0EE
      E2E0EDE8E52C2020EFF0E5E6E4E520F7E5EC20F1E4E5EBE0F2FC20D1EFE5EAF2
      F0EEF1EAEEEFE8FE010D0A7374727363616E31320153746F70205363616E6E69
      6E67206265666F7265206578697421212101CFF0E5E6E4E52C20F7E5EC20E2FB
      E9F2E8202C20EEF1F2E0EDEEE2E8F2E520F1EAE0EDE8F0EEE2E0EDE8E521010D
      0A7374727363616E3133014572726F72212101CEF8E8E1EAE021010D0A737472
      7363616E3134014D6178696D616C2076616C7565205820697320657863656564
      65642E205265647563652061206669656C64206F66207363616E6E696E672E01
      CCE0EAF1E8ECE0EBFCEDEEE520E7EDE0F7E5EDE8E520D520EFF0E5E2FBF8E5ED
      EE2E20D3ECE5EDFCF8E8F2E520EEE1EBE0F1F2FC20F1EAE0EDE8F0EEE2E0EDE8
      FF2E010D0A7374727363616E3135014D6178696D616C2076616C756520592069
      732065786365656465642E205265647563652061206669656C64206F66207363
      616E6E696E672E01CCE0EAF1E8ECE0EBFCEDEEE520E7EDE0F7E5EDE8E5205920
      EFF0E5E2FBF8E5EDEE2ED3ECE5EDFCF8E8F2E520EEE1EBE0F1F2FC20F1EAE0ED
      E8F0EEE2E0EDE8FF2E010D0A7374727363616E3136014572726F722120596F75
      206861766520746F20696E6372656173652058206F7220646563726561736520
      4E7801CEF8E8E1EAE02120D3E2E5EBE8F7FCF2E520D520E8EBE820F3ECE5EDFC
      F8E8F2E5204E78010D0A7374727363616E3137014469736B2069732066756C6C
      2E20436C65616E207570206469736B20206F72206368616E676520776F726B20
      6469736B212101C4E8F1EA20EFE5F0E5EFEEEBEDE5ED2E20CFEEF7E8F1F2E8F2
      E520E4E8F1EA20E8EBE820F1ECE5EDE8F2E520F0E0E1EEF7E8E920E4E8F0E5EA
      F2EEF0E8E92E010D0A7374727363616E313801496E7075742053746570585920
      706172616D65746572212101C2E2E5E4E8F2E52053746570585920EFE0F0E0EC
      E5F2F0010D0A7374727363616E313901496E707574204E7820706172616D6574
      6572212101C2E2E5E4E8F2E5204E7820010D0A7374727363616E323001496E70
      7574204E7920706172616D65746572212101C2E2E5E4E8F2E5204E79010D0A73
      74727363616E3231015A65726F20696E70757401C2E2E5E4E5EDEE20EDF3EBE5
      E2EEE520E7EDE0F7E5EDE8E520010D0A7374727363616E323201496E70757420
      5820706172616D65746572212101C2E2E5E4E8F2E520E7EDE0F7E5EDE8E520D5
      010D0A7374727363616E323301496E707574205920706172616D657465722121
      01C2E2E5E4E8F2E520E7EDE0F7E5EDE8E52059010D0A7374727363616E323401
      496E707574204E7820706172616D65746572212101C2E2E5E4E8F2E520E7EDE0
      F7E5EDE8E5204E78010D0A7374727363616E323501596F752068617665206368
      616E676564205363616E506172616D65746572732E205072657373204170706C
      7920627574746F6E2C206265666F726520746F2063686F6F7365206E65772072
      6567696D652001C2FB20E8E7ECE5EDE8EBE820EFE0F0E0ECE5F2F0FB20F1EAE0
      EDE8F0EEE2E0EDE8FF2E20CDE0E6ECE8F2E520EAEDEEEFEAF32022CFF0E8ECE5
      EDE8F2FC222C20EFF0E5E6E4E520F7E5EC20EDE0F7E0F2FC20F1EAE0EDE8F0EE
      E2E0EDE8E52E010D0A7374727363616E323601496E707574204E792070617261
      6D65746572212101C2E2E5E4E8F2E520E7EDE0F7E5EDE8E5204E79010D0A7374
      727363616E3237014F5554206D656D6F727920546F706F53504D01CDE520F5E2
      E0F2E0E5F220EEEFE5F0E0F2E8E2EDEEE920EFE0ECFFF2E821010D0A73747273
      63616E3238016E6F2044656D6F204461746121212101CDE5F220C4E5ECEE20E4
      E0EDEDFBF521010D0A7374727363616E32390150726F6A656374696F6E206578
      65656473205363616E204669656C64204C696D6974732E2001CFF0EEE5EAF6E8
      FF20EFF0E5E2FBF8E0E5F220EFEEEBE520F1EAE0EDE8F0EEE2E0EDE8FF2E010D
      0A7374727363616E33300144656D6F204C6974686F6772617068792066696C65
      206E6F742065786973747321212101C4E5ECEE20F4E0E9EB20E4EBFF20EBE8F2
      EEE3F0E0F4E8E820EDE520F1F3F9E5F1F2E2F3E5F221010D0A7374727363616E
      333101596F752068617665206368616E676564205363616E506172616D657465
      72732E205072657373204170706C7920627574746F6E2C206265666F72652063
      68616E676520646972656374696F6E2101C2FB20E8E7ECE5EDE8EBE820EFE0F0
      E0ECE5F2F0FB20F1EAE0EDE8F0EEE2E0EDE8FF2E20CDE0E6ECE8F2E520EAEDEE
      EFEAF32022CFF0E8ECE5EDE8F2FC222C20EFF0E5E6E4E520F7E5EC20F1ECE5ED
      E8F2FC20EDE0EFF0E0E2EBE5EDE8E52020F1EAE0EDE8F0EEE2E0EDE8FF2E010D
      0A7374727363616E3332014572726F7220696E7075742101CEF8E8E1EAE020E2
      E2EEE4E021010D0A7374727363616E3333014D6178696D616C2076616C756520
      592069732065786365656465642E205265647563652061206669656C64206F66
      207363616E6E696E672E01CCE0EAF1E8ECE0EBFCEDEEE520E7EDE0F7E5EDE8E5
      205920EFF0E5E2FBF8E5EDEE2E20D3ECE5EDFCF8E8F2E520EEE1EBE0F1F2FC20
      F1EAE0EDE8F0EEE2E0EDE8FF2E010D0A7374727363616E3334014D6178696D61
      6C2076616C756520582069732065786365656465642E20526564756365206120
      6669656C64206F66207363616E6E696E672E01CCE0EAF1E8ECE0EBFCEDEEE520
      E7EDE0F7E5EDE8E520D520EFF0E5E2FBF8E5EDEE2E20D3ECE5EDFCF8E8F2E520
      EEE1EBE0F1F2FC20F1EAE0EDE8F0EEE2E0EDE8FF2E010D0A7374727363616E33
      350153746F70205363616E206265666F7265206368616E676520706172616D65
      7465727320616E64207468656E20726570656174207361766501CEF1F2E0EDEE
      E2E8F2E520F1EAE0EDE8F0EEE2E0EDE8E520EFF0E5E6E4E52C20F7E5EC20EFEE
      ECE5EDFFF2FC20EFE0F0E0ECE5F2F0FB20EFEEE2F2EEE8F2E520F1EEF5F0E0ED
      E5EDE8E52E010D0A7374727363616E3336014572726F7220696E707574204E78
      01CEF8E8E1EAE020E2E2EEE4E020E7EDE0F7E5EDE8FF204E78010D0A73747273
      63616E3337014572726F7220696E707574204E7901CEF8E8E1EAE020E2E2EEE4
      E020E7EDE0F7E5EDE8FF204E78010D0A7374727363616E3338014F5554206D65
      6D6F727920546F706F53504D01CDE520F5E2E0F2E0E5F220EEEFE5F0E0F2E8E2
      EDEEE920EFE0ECFFF2E821010D0A4944535F353101206D63730120ECEAF1010D
      0A4944535F353401206D730120ECF1010D0A7374727374727364727701546F70
      6F202C6E6D01C2FBF1EEF2E02C20EDEC010D0A73747273747273647277320150
      686173652C612E7501D4E0E7E02C20EFF02EE5E42E010D0A7374727374727364
      72773301466F7263652C6D7601D1E8EBE02C20ECC2010D0A7374727374727364
      7277340143757272656E742C6E4101D2EEEA2C20EDC0010D0A4944535F313801
      202052656E69736861770120D0E5EDE8F8EEF3010D0A4944535F323001536361
      6E6E696E67202069732046696E69736865642E205269676874206C696D697420
      7363616E206172656120697320726561636865642001D1EAE0EDE8F0EEE2E0ED
      E8E520E7E0EAEEEDF7E5EDEE2E20C4EEF1F2E8E3EDF3F220EFF0E0E2FBE920EA
      F0E0E920EFEEEBFF20F1EAE0EDE8F0EEE2E0EDE8FF2E010D0A4944535F323301
      5363616E6E696E67202069732046696E69736865642E204C656674206C696D69
      74207363616E206172656120697320726561636865642001D1EAE0EDE8F0EEE2
      E0EDE8E520E7E0EAEEEDF7E5EDEE2E20C4EEF1F2E8E3EDF3F220EBE5E2FBE920
      EAF0E0E920EFEEEBFF20F1EAE0EDE8F0EEE2E0EDE8FF2E010D0A4944535F3235
      015363616E6E696E67202069732046696E69736865642E20546F70206C696D69
      74207363616E206172656120697320726561636865642001D1EAE0EDE8F0EEE2
      E0EDE8E520E7E0EAEEEDF7E5EDEE2E20C4EEF1F2E8E3EDF3F2E2E5F0F5EDE8E9
      20EAF0E0E920EFEEEBFF20F1EAE0EDE8F0EEE2E0EDE8FF2E010D0A4944535F32
      36015363616E6E696E67202069732046696E69736865642E20426F74746F6D20
      6C696D6974207363616E206172656120697320726561636865642001D1EAE0ED
      E8F0EEE2E0EDE8E520E7E0EAEEEDF7E5EDEE2E20C4EEF1F2E8E3EDF3F220EDE8
      E6EDE8E920EAF0E0E920EFEEEBFF20F1EAE0EDE8F0EEE2E0EDE8FF2E010D0A49
      44535F3335014C6974686F67726170682063616E206265206578656375746564
      206F6E6C79206F6E2052656E6973686177206E657473212E2043686F6F736520
      6D6F64652052656E6973686177206E6574732001CBE8F2EEE3F0E0F4E8FF20EC
      EEE6E5F220E2FBEFEEEBEDFFF2F1FF20F2EEEBFCEAEE20EFEE20F3E7EBE0EC20
      D0E5EDE8F8EEF32E010D0A4944535F3635015253206F6E01D0D820E2EAEB2E01
      0D0A4944535F3636015253206F666601D0D820E2FBEAEB2E010D0A7374727363
      616E3339014572726F7221205363616E6E696E6720737065656420763D3001CE
      F8E8E1EAE02120D1EAEEF0EEF1F2FC20F1EAE0EDE8F0EEE2E0EDE8FF20763D30
      010D0A4944535F313437015468652063757272656E742073746570206D6F7265
      207468656E20746865206D6178696D756D20737465703D2001D8E0E320EFF0E5
      E2FBF8E0E5F220ECE0EAF1E8ECE0EBFCEDEE20E4EEEFF3F1F2E8ECFBE9203D01
      0D0A7374727363616E343001546865204D756C746970617373207363616E6E69
      6E6720646F6E277420776F726B20776974682052656E69736861772101C4E2F3
      F5EFF0EEF5EEE4EDE0FF20ECE5F2EEE4E8EAE020EDE520F0E0E1EEF2E0E5F220
      F120D0E5EDE8F8EEF320FDEDEAEEE4E5F0E0ECE8010D0A4944535F363901566F
      6C7461676520426961733D302E202053657420566F6C7461676520426961732E
      01CFF0E8EBEEE6E5EDEEE520EDE0EFF0FFE6E5EDE8E53D302E20C7E0E4E0E9F2
      E520EDE0F0FFE6E5EDE8E52E010D0A4944535F30015374617274206472617769
      6E6701EDE0F7E0EBEE20F0E8F1EEE2E0EDE8FF010D0A4944535F313401657272
      6F722077726974652073746F70206368616E6E656C01EEF8E8E1EAE020E7E0EF
      E8F1E820E220EAE0EDE0EB2053746F70010D0A4944535F313601777269746520
      73746F70206368616E6E656C203D01E7E0EFE8F1FC20E22053746F7020EAE0ED
      E0EB010D0A4944535F3237016572726F7220726561642073746F70206368616E
      6E656C01EEF8E8E1EAE020F7F2E5EDE8FF2053746F7020EAE0EDE0EBE0010D0A
      4944535F323901726561642073746F70206368616E6E656C203D01F7F2E5EDE8
      FF2053746F7020EAE0EDE0EBE03D010D0A4944535F3331016572726F72206765
      7420636F756E7420646174612001EEF8E8E1EAE020EFEEEBF3F7E5EDE8FF2020
      F0E0E7ECE5F0E020E2F5EEE4EDFBF520E4E0EDEDFBF5010D0A4944535F333301
      7363616E64726177206461746120746F20726561642001EFF0EEF7E8F2E0F2FC
      20010D0A4944535F3336016572726F722072656164206368616E6E656C206461
      74612001EEF8E8E1EAE020F7F2E5EDE8FF20010D0A4944535F3339017363616E
      6472617720646174612068617320726561642001EFF0EEF7E8F2E0EDEE20010D
      0A4944535F34320153544F50203A204E4D42206F66204348414E4E454C204552
      524F5253203D20202001010D0A4944535F3435016C696E652001EBE8EDE8FF01
      0D0A4944535F343601456E642064726177696E6701EAEEEDE5F620F0E8F1EEE2
      E0EDE8FF010D0A4944535F34016572726F7220726561642067656F6D65747279
      01010D0A4944535F36014368616E6E656C20646174613B20456C656D656E7473
      3D01EAE0EDE0EB20E4E0EDEDFBF53B20FDEBE5ECE5EDF2EEE23D010D0A737472
      73747274696D6501730163010D0A73744F74686572537472696E67730D0A5365
      72696573322E50657263656E74466F726D6174012323302E2323202501010D0A
      536572696573322E56616C7565466F726D617401232C2323302E23232301010D
      0A65644E784D2E54657874013001010D0A45644E794D2E54657874013001010D
      0A4C696E65536572696573312E50657263656E74466F726D6174012323302E23
      23202501010D0A4C696E65536572696573312E56616C7565466F726D61740123
      2C2323302E23232301010D0A436F6D626F426F7846696C7465722E5465787401
      4E6F6E6501010D0A436F6D626F426F78495A2E5465787401492D5A01010D0A45
      6469744461635A53706565642E5465787401456469744461635A537065656401
      010D0A5365726965734C696E652E50657263656E74466F726D6174012323302E
      2323202501010D0A5365726965734C696E652E56616C7565466F726D61740123
      2C2323302E23232301010D0A5365726965734164644C696E652E50657263656E
      74466F726D6174012323302E2323202501010D0A5365726965734164644C696E
      652E56616C7565466F726D617401232C2323302E23232301010D0A65644E582E
      54657874013101010D0A45644E592E54657874013101010D0A45645363616E52
      6174652E54657874013001010D0A4564582E54657874013530303001010D0A45
      64592E54657874013530303001010D0A436F6D626F426F78506174682E546578
      7401582B01010D0A536572696573312E50657263656E74466F726D6174012323
      302E2323202501010D0A536572696573312E56616C7565466F726D617401232C
      2323302E23232301010D0A6C626C656469745474657272612E54657874016C62
      6C6564697454746572726101010D0A7374436F6C6C656374696F6E730D0A7374
      43686172536574730D0A545363616E576E640144454641554C545F4348415253
      4554015255535349414E5F43484152534554010D0A50616E656C370144454641
      554C545F43484152534554015255535349414E5F43484152534554010D0A4C61
      62656C5A0144454641554C545F43484152534554015255535349414E5F434841
      52534554010D0A4C6162656C5A560144454641554C545F434841525345540152
      55535349414E5F43484152534554010D0A4C6162656C31350144454641554C54
      5F43484152534554015255535349414E5F43484152534554010D0A4C6162656C
      416374696F6E0144454641554C545F43484152534554015255535349414E5F43
      484152534554010D0A4C6162656C31370144454641554C545F43484152534554
      015255535349414E5F43484152534554010D0A4C6162656C3138014445464155
      4C545F43484152534554015255535349414E5F43484152534554010D0A426974
      42746E4C6F6164496D0144454641554C545F4348415253455401525553534941
      4E5F43484152534554010D0A526164696F547970654C6974686F014445464155
      4C545F43484152534554015255535349414E5F43484152534554010D0A546162
      5368656574546F706F520144454641554C545F43484152534554015255535349
      414E5F43484152534554010D0A546162536865657455414D520144454641554C
      545F43484152534554015255535349414E5F43484152534554010D0A50616765
      43746C4C6566740144454641554C545F43484152534554015255535349414E5F
      43484152534554010D0A5061676543746C52696768740144454641554C545F43
      484152534554015255535349414E5F43484152534554010D0A436F6D626F426F
      78495A0144454641554C545F43484152534554015255535349414E5F43484152
      534554010D0A4C6162656C360144454641554C545F4348415253455401525553
      5349414E5F43484152534554010D0A42697442746E50726F6A65637401444546
      41554C545F43484152534554015255535349414E5F43484152534554010D0A50
      616E656C360144454641554C545F43484152534554015255535349414E5F4348
      4152534554010D0A506167654374726C5363616E0144454641554C545F434841
      52534554015255535349414E5F43484152534554010D0A4C626C596D61780144
      454641554C545F43484152534554015255535349414E5F43484152534554010D
      0A42697442746E4D67496E0144454641554C545F434841525345540152555353
      49414E5F43484152534554010D0A42697442746E4D674F75740144454641554C
      545F43484152534554015255535349414E5F43484152534554010D0A42746E43
      6C6561720144454641554C545F43484152534554015255535349414E5F434841
      52534554010D0A4C626C586D61780144454641554C545F434841525345540152
      55535349414E5F43484152534554010D0A4C6162656C320144454641554C545F
      43484152534554015255535349414E5F43484152534554010D0A4C6162656C31
      310144454641554C545F43484152534554015255535349414E5F434841525345
      54010D0A4C6162656C310144454641554C545F43484152534554015255535349
      414E5F43484152534554010D0A45645374657058590144454641554C545F4348
      4152534554015255535349414E5F43484152534554010D0A436F6D626F426F78
      506174680144454641554C545F43484152534554015255535349414E5F434841
      52534554010D0A45645363616E4E4D620144454641554C545F43484152534554
      015255535349414E5F43484152534554010D0A4564447A0144454641554C545F
      43484152534554015255535349414E5F43484152534554010D0A5369676E616C
      734D6F6465015255535349414E5F43484152534554015255535349414E5F4348
      4152534554010D0A}
  end
  object ImageList2: TImageList
    Height = 32
    Width = 32
    Left = 248
    Top = 96
    Bitmap = {
      494C010108000900280220002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000008000000060000000010020000000000000C0
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE00F9F9
      F900ECEBEC00DBD8DB00D1CDD100CECACE00CECACE00CECACE00CECACE00CECA
      CE00CECACE00CECACE00CECACE00CECACE00CECACE00CECACE00CECACE00CECA
      CE00CECACE00CECACE00CECACE00CECACE00CECACE00CECACE00CECACE00D1CD
      D100DBD8DB00EDEBED00FAF9FA00FEFEFE0000000000F7F6F600F8F6F600F9F8
      F800F9F8F800FAF9F900F9F8F800F9F8F800F9F8F800F9F8F800F9F8F800F9F8
      F800F9F8F800F9F8F800F9F8F800F9F8F800F9F8F800F9F8F800F9F8F800F9F8
      F800F9F8F800F9F8F800F9F8F800F9F8F800F9F8F800F9F8F800F9F8F800FAF9
      F900F9F8F800F9F8F800F7F6F600F9F8F8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFD00F9F9
      F900F4F4F400F1F1F100EEEEEE00ECECEC00ECECEC00EEEEEE00F1F1F100F4F4
      F400F9F9F900FDFDFD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFAFA00D0D0D000B6B6B600AAAAAA00A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900AAAAAA00B6B6B600D0D0D000FAFAFA000000
      00000000000000000000000000000000000000000000FEFEFE00FBFBFB00EEED
      EE00D6D3D600BCB8BC00AFAAAF00ACA7AC00ACA7AC00ACA7AC00ACA7AC00ACA7
      AC00ACA7AC00ACA7AC00ACA7AC00ACA7AC00ACA7AC00ACA7AC00ACA7AC00ACA7
      AC00ACA7AC00ACA7AC00ACA7AC00ACA7AC00ACA7AC00ACA7AC00ADA7AD00B0AA
      B000BEB8BE00D7D3D700EEECEE00FAF9FA0000000000F7F6F600F0EDED00EEEB
      EB00EFEBEB00F0EDED00F1EEEE00F2EFEF00F2EFEF00F2F0F000F2F0F000F2F0
      F000F2EFEF00F2EFEF00F2EFEF00F2EFEF00F2EFEF00F2EFEF00F2EFEF00F2EF
      EF00F2EFEF00F2F0F000F2F0F000F2EFEF00F2EFEF00F2EFEF00F1EEEE00F0EC
      EC00EFEBEB00EEEBEB00F1EFEF00FAF9F9000000000000000000000000000000
      000000000000000000000000000000000000FCFCFC00F5F5F500ECECEC00E1E1
      E100D7D7D700D0D0D000CACACA00C7C7C700C7C7C700CACACA00D0D0D000D7D7
      D700E1E1E100ECECEC00F5F5F500FCFCFC000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F9F9
      F900AAAAAA005F5F5F0054545400545454005454540054545400545454005454
      5400545454005454540054545400545454005454540054545400545454005454
      54005454540054545400545454005454540054545400545454005F5F5F00AAAA
      AA00F9F9F90000000000000000000000000000000000FDFDFD00F2F1F200D8D6
      D800A7471C00A9491B00AA4A1B00AB4A1A00AB4A1A00AC4B1A00AC4B1A00AC4B
      1A00AC4B1A00AC4B1A00AC4B1A00AC4B1A00AC4B1A00AC4B1A00AC4B1A00AC4B
      1A00AC4B1A00AC4B1A00AC4B1A00AB4A1A00AA4A1B00A9491B00A6471C00A244
      1E00A29BA200BAB4BA00D7D3D700ECEAEC0000000000FEFEFE00F8F8F800E9E8
      E800D8D6D600CDCBCB00C6C4C400C3C1C100C1BFBF00C1BFBF00C2C0C000C3C1
      C100C3C1C100C3C1C100C4C2C200C4C2C200C4C2C200C4C2C200C4C2C200C3C1
      C100C3C1C100C3C1C100C1BFBF00C0BEBE00C1BFBF00C3C1C100C8C6C600D0CE
      CE00DDDBDB00EFEEEE00FBFBFB00FEFEFE000000000000000000000000000000
      00000000000000000000FDFDFD00F7F7F700EAEAEA00D9D9D900C8A99900C18C
      6D00C17A5100C3704000CB6C3500CD6E3600C7724000C77E5200C38D6B00C1A2
      9000C0C0C000CACACA00D9D9D900EAEAEA00F7F7F700FDFDFD00000000000000
      0000000000000000000000000000000000000000000000000000EEEEEE007777
      770054545400545454005E5E5E0078787800848484008A8A8A008A8A8A008A8A
      8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A
      8A008A8A8A008A8A8A008A8A8A0084848400787878005E5E5E00545454005454
      540077777700EEEEEE00000000000000000000000000F9F9F900E5E4E500AB4A
      1B00D27C3E00D6803F00D8824000D8834000D9844000B35018009E969E009E96
      9E00A49DA400B0A8B000BFB7BF00CEC6CE00DCD4DC00E2DAE200E5DEE500E8E1
      E800E8E1E800E8E1E800B3501800D8834000D7814000D47F4000D07B3F00CA75
      3E00A3451D00A29BA200BEB8BE00DBD8DB000000000000000000FAF9F900E2DA
      DA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DA
      DA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DA
      DA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DA
      DA00E2DADA00FAF9F90000000000000000000000000000000000000000000000
      000000000000FCFCFC00F1F1F100DCD6D300C3957B00C1673500CA652D00D36C
      3300DA723C00DD7A4300E0814800E2884E00E4915800E5986000E3955C00DD89
      4D00D2783F00C5947400BEB7B300CACACA00DEDEDE00F1F1F100FCFCFC000000
      00000000000000000000000000000000000000000000F8F8F800777777005454
      54005858580087878700A6A6A600A7A7A7009E9E9E009A9A9A009A9A9A009B9B
      9B009B9B9B009B9B9B009B9B9B009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009D9D9D009D9D9D00A1A1A100A7A7A700A6A6A600878787005858
      58005454540077777700F8F8F8000000000000000000F8F8F800AD4C1A00D780
      3D00DC843D00DE883E00E1893F00E18A4000E18B4000B9541600A39EA3004F4B
      4F004E4A4E004F4B4F00C5C1C500D5D1D500E4DFE400EBE6EB00EEEAEE00F1ED
      F100F1EDF100F1EDF100B9541600E18A4000E0894000DD863F00D8823E00D27C
      3E00CB763D00A2441E00B0AAB000D1CDD10000000000F1EEEE00E2DADA00FEF9
      F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9
      F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9
      F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9F900FEF9
      F900FEF9F900E1D8D800F1EEEE00000000000000000000000000000000000000
      0000FCFCFC00EEEEEE00CEB1A100BE653400CA612800D5672900D76B2D00D96F
      3100DC743200DE783600E07D3900E3823D00E5874100E88C4400EB985400EDA5
      6500F0B27700E79F6300D77D4100C1A28D00C1C1C100D7D7D700EEEEEE00FCFC
      FC000000000000000000000000000000000000000000AAAAAA00545454005959
      590099999900959595007C7C7C00737373007272720073737300747474007575
      75007575750076767600777777007878780078787800797979007A7A7A007B7B
      7B007C7C7C007D7D7D007E7E7E007F7F7F0080808000888888009B9B9B009999
      99005959590054545400AAAAAA000000000000000000F7F7F700B3501800DE86
      3C00E38A3D00E58D3E00E78F3F00E78F4000E7904000BE571400A7A4A700403D
      4000403D4000403D4000CAC8CA00DBD9DB00EAE8EA00F1EFF100F5F3F500F8F6
      F800F8F6F800F8F6F800BE571400E78F3F00E68E3F00E38C3E00DF873D00D882
      3D00D07A3C00A6471C00ADA7AD00CECACE0000000000E2DADA00FEF9F900FEF8
      F800FEF9F900E2DADA00E2DADA00EFE8E800FFFAFA00FEF9F900EDE8E800E2DA
      DA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DA
      DA00E2DADA00EDE8E800FEF9F900FEF9F900FEF9F900E2DADA00E2DADA00FEF9
      F900FEF8F800FEF9F900E2DADA0000000000000000000000000000000000FCFC
      FC00EEEEEE00C2886B00C15C2A00D05F2700D3632600D5672900D76C2C00DA70
      3000DC753300DE793700E17E3A00E3833E00E6884200E98E4500EB934900EE99
      4D00F1A05400F4B16C00F4BF8300E6955600CC8E6500BEBEBE00D5D5D500EEEE
      EE00FCFCFC00000000000000000000000000F9F9F9005E5E5E00545454008C8C
      8C007E7E7E007171710072727200727272007373730074747400757575007575
      750076767600777777007878780078787800797979007A7A7A007B7B7B007C7C
      7C007D7D7D007E7E7E007F7F7F007F7F7F008080800082828200838383008C8C
      8C008E8E8E00545454005E5E5E00F9F9F90000000000F7F7F700B7531600E48A
      3B00E78D3C00E9903D00EB913E00EB923F00EB923F00C0591300A9A8A9004241
      42004342430042414200CDCCCD00DEDDDE00EEEDEE00F5F4F500F9F8F900FCFB
      FC00FCFBFC00FCFBFC00C0591300EB923F00EA913E00E78E3D00E38A3C00DC84
      3C00D47D3B00A9491B00ACA7AC00CECACE0000000000E2DADA00FDF7F700F9F3
      F300E2DADA00F3E9E900F1E7E700E2DADA00FFFAFA00F6F1F100E2DADA00FAF5
      F500FAF5F500FAF5F500F9F2F200A29B9B00CFC9C900FAF5F500FAF5F500FAF5
      F500FAF5F500E2DADA00F6F1F100FFFAFA00E2DADA00F1E7E700F3E9E900E2DA
      DA00F9F3F300FDF7F700E2DADA00000000000000000000000000FDFDFD00F1F1
      F100C2886B00C35B2B00D05C2800D1602400D3642600D6682900D86C2D00DA70
      3000DC733200DA692C00E0855A00E1825200E1763600E98D4500EC944A00EF9A
      4E00F19F5300F5A55700F8B16400FBCA8A00EFAB6A00CE8F6600BEBEBE00D7D7
      D700F1F1F100FDFDFD000000000000000000CFCFCF0054545400696969008080
      8000717171007272720072727200737373007474740075757500757575007676
      7600777777007878780078787800797979007A7A7A007B7B7B007C7C7C007D7D
      7D007E7E7E007F7F7F007F7F7F00808080008282820083838300838383008383
      83008F8F8F006969690054545400CFCFCF0000000000F7F7F700B9541600E68C
      3A00EA903B00EB913C00EC923D00ED933E00ED943F00C25A1300AAAAAA00403F
      4000403F4000403F4000CFCFCF00E0E0E000F0F0F000F7F7F700FBFBFB00FEFE
      FE00FEFEFE00FEFEFE00C25A1300ED933E00EB923D00E9903C00E68C3B00DE86
      3B00D67F3A00AA4A1B00ACA7AC00CECACE0000000000E2DADA00FFF9F900F9F3
      F300E2DADA00F0E6E600EDE4E400E2DADA00FFF9F900F7F2F200E2DADA00F6EF
      EF00F6EFEF00F6EFEF00F4EBEB00D0C1C100D1C9C900F6EFEF00F6EFEF00F6EF
      EF00F6EFEF00E2DADA00F7F2F200FFF9F900E2DADA00EDE4E400F0E6E600E2DA
      DA00F9F3F300FFF9F900E2DADA00000000000000000000000000F7F7F700C38A
      6E00C25B2D00CE5B2A00D05C2100D1602400D3642600D6682900D86C2D00DA70
      3000D6612800EBCEC400F1EAEA00F3EDED00EEC6B300E47B3900EC944A00EF9A
      4E00F19F5300F5A55700F8AB5B00FAB36200FDCD8B00EEA96A00CC8D6500C1C1
      C100DEDEDE00F7F7F7000000000000000000B6B6B600545454007C7C7C007171
      7100727272007272720073737300747474007575750075757500767676007777
      77007878780078787800797979007A7A7A007B7B7B007C7C7C007D7D7D007E7E
      7E007F7F7F007F7F7F0080808000828282008383830083838300838383008585
      8500868686008686860054545400B6B6B60000000000F7F7F700BB551500E78D
      3900EA8F3A00EB913B00EE933C00EE943C00EE943D00C35B1300ABABAB005151
      51005050500051515100D0D0D000E1E1E100F1F1F100F8F8F800FCFCFC000000
      00000000000000000000C35B1300EE943D00EC923C00EA903B00E68D3A00E087
      3A00D7803900AB4A1A00ACA7AC00CECACE0000000000E2DADA00FEF9F900FEF9
      F900FEF9F900E2DADA00E2DADA00FEF9F900FEF9F900FEF9F900F2ECEC00E2DA
      DA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DA
      DA00E2DADA00F2ECEC00FEF9F900FEF9F900FEF9F900E2DADA00E2DADA00FEF9
      F900FEF9F900FEF9F900E2DADA000000000000000000FCFCFC00D9BCAE00BB5B
      2E00CC5D2D00CE581F00CF5C2100D15F2300D3632600D5672900D76C2C00D96D
      2E00DD866100F0E8E800F0E8E800F0E8E800F2EAEA00E58E6000EB934900EE99
      4D00F19E5100F4A35500F6A95900F9AD5D00FAB26200FAC88800E5945500C1A1
      8D00CACACA00EAEAEA00FCFCFC0000000000A9A9A90054545400787878007272
      7200727272007373730074747400757575007575750076767600777777007878
      780078787800797979007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F
      7F007F7F7F008080800082828200838383008383830083838300858585008686
      8600868686008A8A8A0054545400A9A9A90000000000F7F7F700BB561500E88D
      3800EA903900EC913900ED933A00EE933B00EE933C00C35B1300ABABAB00ABAB
      AB00B2B2B200BFBFBF00D0D0D000E1E1E100F1F1F100F8F8F800FCFCFC000000
      00000000000000000000C35B1300EE933B00ED923A00EA8F3A00E68C3900E087
      3800D87F3800AC4B1A00ACA7AC00CECACE0000000000E2DADA00FDF8F800FDF8
      F800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDF8F800FDF8F800E2DADA000000000000000000F1EBE900B65F3800C962
      3600CC572000CD581E00CF5B2000D15F2300D3632600D5672900D76B2C00D86B
      2C00E0987900F0E8E800F0E8E800F0E8E800F0E8E800E48C5E00EB914800ED97
      4C00F09C5000F2A05300F4A55700F6A85900F7AA5A00F7AF6300F3BE8100D67C
      4100BDB7B300D9D9D900F5F5F50000000000A9A9A90054545400747474007272
      7200737373007474740075757500757575007676760077777700787878007878
      7800797979007A7A7A007B7B7B007B7B7B007D7D7D007E7E7E007F7F7F007F7F
      7F00808080008181810083838300838383008383830084848400868686008686
      8600878787008989890054545400A9A9A90000000000F7F7F700BB561500E88C
      3700EA8F3700EC903800ED923900ED923900ED923A00C35B1300C35B1300C35B
      1300C35B1300C35B1300C35B1300C35B1300C35B1300C35B1300C35B1300C35B
      1300C35B1300C35B1300C35B1300ED923900EC903900EA8E3800E68B3700E086
      3700D87F3800AC4B1A00ACA7AC00CECACE0000000000E2DADA00FDF7F7000000
      0000B9580800B24F0600B24F0600B24F0600B24F0600B24F0600B24F0600B24F
      0600B24F0600B24F0600B24F0600B24F0600B24F0600B24F0600B24F0600B24F
      0600B24F0600B24F0600B24F0600B24F0600B24F0600B24F0600B24F0600B958
      080000000000FDF7F700E2DADA0000000000FDFDFD00CDA08A00BF613600CA5B
      2900CC541B00CD571D00CF5A2000D15E2200D3622500D5662800D76A2B00D96E
      2E00D76C3D00EEE0DC00F0E8E800F0E8E800EFE0DC00E1773D00E98F4600EC94
      4A00EE984D00F09C5000F2A05300F3A35500F4A45600F4A35600F3AF6B00E79E
      6200C5937400CACACA00ECECEC00FDFDFD00A9A9A90054545400737373007373
      7300747474007575750075757500767676007777770078787800787878007979
      79008F8F8F009D9D9D009D9D9D009E9E9E009F9F9F009F9F9F009F9F9F009393
      9300818181008383830083838300838383008484840086868600868686008787
      8700888888008A8A8A0054545400A9A9A90000000000F7F7F700BB561500E88C
      3500EA8E3500EC8F3600ED913700ED913800ED913800ED8E3200ED8F3400ED8F
      3400ED903500ED903500ED903600ED903600ED913700ED913700ED913700ED91
      3700ED8F3400ED8F3400ED8E3200ED903700EC8F3700EA8D3600E68A3600E085
      3500D87F3600AC4B1A00ACA7AC00CECACE0000000000E2DADA00FCF6F6000000
      0000B5530900A9450700A9450700A9450700A9450700A9450700A9450700A945
      0700A9450700A9450700A9450700A9450700A9450700A9450700A9450700A945
      0700A9450700A9450700A9450700A9450700A9450700A9450700A9450700B553
      090000000000FCF6F600E2DADA0000000000F9F9F900B45F3800C9683E00CA52
      1B00CB531A00CD561D00CE5A1F00D05D2200D2612500D4652700D6692A00D86D
      2D00D6632900DA764900E3A48800E4A58900DE764300E37C3A00E88C4400EA90
      4700EC944A00EE984D00EF9B4F00F09D5100F19E5100F19E5100F09E5300EFB0
      7500D2783F00C0C0C000E1E1E100F9F9F900A9A9A90054545400737373007474
      740075757500757575007676760077777700787878007878780079797900C1C1
      C100000000000000000000000000000000000000000000000000000000000000
      0000C5C5C5008383830083838300848484008686860086868600878787008888
      8800898989008A8A8A0054545400A9A9A90000000000F7F7F700BB561500E88A
      3300EA8D3400EC8E3400ED8F3500ED903500ED903600ED8E3200ED8F3400ED8F
      3400ED903500ED903500ED903600ED903600ED913700ED913700ED913700ED91
      3700ED8F3400ED8F3400ED8E3200ED8F3500EC8E3500EA8C3400E6883300E083
      3300D87D3400AC4B1A00ACA7AC00CECACE0000000000E2DADA00FCF5F5000000
      0000B7570D00AF4F1000AF4F1000AF4F1000AF4F1000AF4F1000AF4F1000AF4F
      1000AF4F1000AF4F1000AF4F1000AF4F1000AF4F1000AF4F1000AF4F1000AF4F
      1000AF4F1000AF4F1000AF4F1000AF4F1000AF4F1000AF4F1000AF4F1000B757
      0D0000000000FCF5F500E2DADA0000000000DDC1B300BA603700C8613300C950
      1800CB531A00CC561C00CE591F00D05C2100D1602400D3632600D5672900D76B
      2C00D5693A00E2A28700E3A38700E5A58900E5A78A00DE6F3100E6894200E88C
      4500EA904700EB934900ED964B00EE974D00EE984D00EE984D00ED974C00ECA3
      6300DC874D00C1A29000D7D7D700F4F4F400A9A9A90054545400757575007575
      75007575750076767600777777007878780078787800797979007E7E7E00FCFC
      FC00000000000000000000000000000000000000000000000000000000000000
      0000FCFCFC008787870084848400868686008686860087878700888888008989
      8900898989008B8B8B0054545400A9A9A90000000000F7F7F700BB561500E889
      3100EA8C3200EC8D3300ED8E3300ED8F3300ED8F3400ED8E3200ED8F3400ED8F
      3400ED903500ED903500ED903600ED903600ED913700ED913700ED913700ED91
      3700ED8F3400ED8F3400ED8E3200ED8E3300EC8D3300EA8B3200E6883200E083
      3200D87D3300AC4B1A00ACA7AC00CECACE0000000000E2DADA00FBF5F5000000
      0000BA5C1100B5591900B5591900B5591900B5591900B5591900B5591900B559
      1900B5591900B5591900B5591900B5591900B5591900B5591900B5591900B559
      1900B5591900B5591900B5591900B5591900B5591900B5591900B5591900BA5C
      110000000000FBF5F500E2DADA0000000000CA988000C8775100CB5F2E00C94F
      1700CA521900CC551B00CD581E00CF5B2000D15E2300D3622500D4662800D667
      2900D97A5300F1EAEA00F1EAEA00F1E9E900F1E9E900DC6C2F00E4853F00E688
      4200E88C4400E98E4600EA904700EB924800EB924900EB924900EB914800EA96
      5200E2935A00C38C6B00D0D0D000F1F1F100A9A9A90054545400767676007575
      750076767600777777007878780078787800797979007A7A7A00858585000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008D8D8D0086868600868686008787870088888800898989008989
      89008A8A8A008C8C8C0054545400A9A9A90000000000F7F7F700BB561500E889
      3000EA8C3100EC8D3200ED8E3200ED8E3200ED8E3200ED8E3200ED8F3400ED8F
      3400ED903500ED903500ED903600ED903600ED913700ED913700ED913700ED91
      3700ED8F3400ED8F3400ED8E3200ED8E3200EC8D3200EA8A3100E6883100E083
      3200D87C3200AC4B1A00ACA7AC00CECACE0000000000E2DADA00FAF4F400FEFD
      FE00BD611600BB622100BB622100BB622100BB622100BB622100BB622100BB62
      2100BB622100BB622100BB622100BB622100BB622100BB622100BB622100BB62
      2100BB622100BB622100BB622100BB622100BB622100BB622100BB622100BD61
      1600FDFDFE00FAF4F400E2DADA0000000000BC785900D3866200D0673400CB56
      2000CA511900CB541B00CD571D00CE5A1F00D05D2200D2602400D4642700D566
      2800D8795200F2EBEB00F2EAEA00F1EAEA00F1EAEA00DB6E3700E2813C00E484
      3F00E5874100E7894200E78B4400E88C4500E88D4500E88D4500E88C4400E78A
      4300E4965E00C67D5200CACACA00EEEEEE00A9A9A90054545400767676007676
      7600777777007878780078787800797979007A7A7A007B7B7B00858585000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008E8E8E0086868600878787008888880089898900898989008A8A
      8A008B8B8B008D8D8D0054545400A9A9A90000000000F7F7F700BB561500E88A
      3200EA8B3100EC8C3100ED8D3100ED8D3100ED8D3100ED8E3200ED8F3400ED8F
      3400ED903500ED903500ED903600ED903600ED913700ED913700ED913700ED91
      3700ED8F3400ED8F3400ED8E3200ED8D3100EC8C3100EA8A3000E6883200E083
      3200D87D3300AC4B1A00ACA7AC00CECACE0000000000E2DADA00FAF4F400FCFB
      FC00C0661A00C06C2900C06C2900C06C2900C06C2900C06C2900C06C2900C06C
      2900C06C2900C06C2900C06C2900C06C2900C06C2900C06C2900C06C2900C06C
      2900C06C2900C06C2900C06C2900C06C2900C06C2900C06C2900C06C2900C066
      1A00FCFBFB00FAF3F300E2DADA0000000000B2644000D4856100D0663400D167
      3500CC592300CB531A00CC551C00CE581E00CF5B2100D15F2300D3622500D465
      2800D15E2C00F2ECEC00F2EBEB00F2EBEB00F2EAEA00E4A58900DD733300E280
      3B00E3833D00E4843F00E5864000E5874100E6884100E6884100E5874000E585
      3F00E48F5700C6724000C7C7C700ECECEC00A9A9A90054545400767676007676
      7600777777007878780078787800797979007A7A7A007B7B7B00858585000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008E8E8E0086868600878787008888880089898900898989008A8A
      8A008C8C8C008D8D8D0054545400A9A9A90000000000F7F7F700BB561500E88C
      3600EA8E3600EC8F360000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00FCFBFC00E6883300E083
      3300D87D3400AC4B1A00ACA7AC00CECACE0000000000E2DADA00FAF4F400FAF9
      F800C36B1E00C6753200C6753200C6753200C6753200C6753200C6753200C675
      3200C6753200C6753200C6753200C6753200C6753200C6753200C6753200C675
      3200C6753200C6753200C6753200C6753200C6753200C6753200C6753200C36B
      1E00FAF9F800F9F2F200E2DADA0000000000B25C3500D5845E00D0663400D167
      3400D1673500CF5E2900CC541B00CD571D00CE5A1F00D05D2100D2602400D363
      2600D25E2400E09F8500F3ECEC00F2ECEC00F2EBEB00F0E2DF00DC7A4C00DE76
      3500E17E3A00E2803B00E2813C00E3823D00E3833D00E3823D00E3823D00E280
      3C00E1864C00CD6E3600C7C7C700ECECEC00A9A9A90054545400777777007777
      77007878780078787800797979007A7A7A007B7B7B007C7C7C00868686000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F8F8F00878787008888880089898900898989008A8A8A008C8C
      8C008D8D8D008D8D8D0054545400A9A9A90000000000F7F7F700BB561500E88D
      3B00EA903B00EC913B0000000000D4D4D400D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D3D3D300FCFBFC00E68A3700E085
      3700D87F3800AC4B1A00ACA7AC00CECACE0000000000E2DADA00FAF4F400F8F5
      F600C66F2200CC7F3A00CC7F3A00CC7F3A00CC7F3A00CC7F3A00CC7F3A00CC7F
      3A00CC7F3A00CC7F3A00CC7F3A00CC7F3A00CC7F3A00CC7F3A00CC7F3A00CC7F
      3A00CC7F3A00CC7F3A00CC7F3A00CC7F3A00CC7F3A00CC7F3A00CC7F3A00C66F
      2200F7F6F500F9F1F100E2DADA0000000000B15C3500D7866200D0663500D066
      3400D1673500D2683500D1653000CD592100CD581E00CF5B2000D05E2200D261
      2400D4642700CF562000EAC6B900F3EDED00F3ECEC00F2ECEC00F0E2DF00D970
      3F00DE783500DF7B3800E07C3900E07D3900E17E3A00E07D3A00E07D3900E07C
      3800DF7F4600CB6B3400CACACA00EEEEEE00A9A9A90054545400787878007878
      780078787800797979007A7A7A007B7B7B007C7C7C007D7D7D00878787000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000909090008888880089898900898989008A8A8A008C8C8C008D8D
      8D008D8D8D008E8E8E0054545400A9A9A90000000000F7F7F700BB561500E991
      4100EB944100ED954100FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FDFDFD00FBFAFB00E68C3B00E087
      3B00D8803B00AC4B1A00ACA7AC00CECACE0000000000E2DADA00FAF4F400F4F3
      F300C9742600D1884300D1884300D1884300D1884300D1884300D1884300D188
      4300D1884300D1884300D1884300D1884300D1884300D1884300D1884300D188
      4300D1884300D1884300D1884300D1884300D1884300D1884300D1884300C974
      2600F5F2F300F8F0F000E2DADA0000000000B0624000DA8F6D00D0663500D066
      3400D1673400D1673500D2683500D3693500D1632C00CF5B2200CF5B2100D15E
      2300D2612500D3622600D15E2C00EDD0C600F3EDED00F3EDED00F3ECEC00EDD0
      C600D6612800DD763400DD773500DE783600DE783600DE783600DE783500DD77
      3500DD784100C36F4000D0D0D000F1F1F100A9A9A90054545400797979007878
      7800797979007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E00878787000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009090900089898900898989008A8A8A008C8C8C008D8D8D008D8D
      8D008E8E8E008F8F8F0054545400A9A9A90000000000F7F7F700BB561500E994
      4600EB974600ED984600FEFEFE00D4D4D400D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D3D3D300FBFAFB00E7904100E18B
      4100D9844100AC4B1A00ACA7AC00CECACE0000000000E2DADA00FAF4F400F2EF
      EF00CC792B00D7924B00D7924B00D7924B00D7924B00D7924B00D7924B00D792
      4B00D7924B00D7924B00D7924B00D7924B00D7924B00D7924B00D7924B00D792
      4B00D7924B00D7924B00D7924B00D7924B00D7924B00D7924B00D7924B00CC79
      2B00F2EFEF00F8F0F000E2DADA0000000000B9785900DD997A00D0663500D066
      3500D0663400D1673500D1673500D2693500D36A3500D46B3600D2652E00D162
      2800D15E2300D2612500D3622600D05A2A00F2E4E100F4EEEE00F3EDED00F3ED
      ED00DE8F6E00D96C2D00DB733200DB733200DC743300DC743300DB733200DB72
      3100D9703B00C17A5100D7D7D700F4F4F400A9A9A90054545400797979007979
      79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F0080808000F1F1
      F100000000000000000000000000000000000000000000000000000000000000
      0000F1F1F1008A8A8A00898989008A8A8A008C8C8C008D8D8D008D8D8D008E8E
      8E008F8F8F009090900054545400A9A9A90000000000F7F7F700BB561500EA97
      4B00EC9A4B00EE9B4B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00FCFBFC00E7934600E18E
      4600D9874600AC4B1A00ACA7AC00CECACE0000000000E2DADA00FAF5F500EFEC
      EC00CE7D2F00DD9B5300DD9B5300DD9B5300DD9B5300DD9B5300DD9B5300DD9B
      5300DD9B5300DD9B5300DD9B5300DD9B5300DD9B5300DD9B5300DD9B5300DD9B
      5300DD9B5300DD9B5300DD9B5300DD9B5300DD9B5300DD9B5300DD9B5300CE7D
      2F00EFEBEB00F7EFEF00E2DADA0000000000CA988200D1896900D4764B00D066
      3500D0663500D0673400D1673500D2683500D2693500D36A3500D46B3600D263
      3000D56D3600D4693000D4672C00D25F2600DC8A6B00F5EFEF00F4EEEE00F4EE
      EE00EDD0C700D35E2500D96E2E00D96F2F00D96F2F00D96F2F00D96F2F00D96E
      3000D26A3200C08B6D00E1E1E100F9F9F900A9A9A900545454007A7A7A007A7A
      7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F007F7F7F00808080009C9C
      9C00DDDDDD00E9E9E900E9E9E900EAEAEA00EAEAEA00EAEAEA00EAEAEA00DFDF
      DF00A2A2A200898989008A8A8A008C8C8C008D8D8D008D8D8D008E8E8E008F8F
      8F00909090009090900054545400A9A9A90000000000F7F7F700BB561500EA9A
      5000EC9D5000EE9E500000000000D4D4D400D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D3D3D300FCFBFC00E8974D00E291
      4D00DA8A4C00AC4B1A00ACA7AC00CECACE0000000000E2DADA00FAF5F500ECE8
      E800D1823300E2A45C00E2A45C00E2A45C00E2A45C00E2A45C00E2A45C00E2A4
      5C00E2A45C00E2A45C00E2A45C00E2A45C00E2A45C00E2A45C00E2A45C00E2A4
      5C00E2A45C00E2A45C00E2A45C00E2A45C00E2A45C00E2A45C00E2A45C00D182
      3300ECE8E800F6EEEE00E2DADA0000000000E2C6BA00C0724F00D9886300D066
      3500D0663500D0663400D1673400D1673500D2683500D3693500CF5F2D00D87C
      5A00D05D2C00D56D3700D66F3800D66E3700DB886600F5F0F000F5F0F000F4EF
      EF00F4EEEE00D25E2800D9713400D9713400D9713400D9713400DA733700D973
      3800CA693200C7A99900ECECEC00FDFDFD00A9A9A900545454007B7B7B007B7B
      7B007B7B7B007D7D7D007E7E7E007F7F7F007F7F7F0080808000818181008383
      8300838383008383830084848400868686008686860087878700888888008989
      8900898989008A8A8A008B8B8B008D8D8D008D8D8D008E8E8E008F8F8F009090
      9000909090009191910054545400A9A9A90000000000F7F7F700BB561500EA9D
      5500ECA05500EEA1550000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00FCFBFC00E89A5300E294
      5200DA8D5100AC4B1A00ACA7AC00CECACE0000000000E2DADA00FAF6F600EAE5
      E500D4873700E8AE6400E8AE6400E8AE6400E8AE6400E8AE6400E8AE6400E8AE
      6400E8AE6400E8AE6400E8AE6400E8AE6400E8AE6400E8AE6400E8AE6400E8AE
      6400E8AE6400E8AE6400E8AE6400E8AE6400E8AE6400E8AE6400E8AE6400D487
      3700EAE5E500F6EDED00E2DADA000000000000000000B1623E00E09D7E00D169
      3A00D0663500D0663500D0663400D1673400D1673500D0613000DD907400FAF7
      F700E9B9A800D2643700D1612F00D2643700EFD5CC00F6F2F200F6F1F100F5F0
      F000F5EFEF00D3602D00D9743A00D9753A00D9753A00D9753A00D9743A00D974
      3900BF673700D9D9D900F5F5F50000000000A9A9A900545454007F7F7F007B7B
      7B007D7D7D007E7E7E007F7F7F007F7F7F008080800081818100838383008383
      8300838383008484840086868600868686008787870088888800898989008989
      89008A8A8A008B8B8B008D8D8D008D8D8D008E8E8E008F8F8F00909090009090
      9000919191009393930054545400A9A9A90000000000F7F7F700BB561500EBA2
      5F00EDA55F00EFA65F0000000000D4D4D400D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D3D3D300FCFBFC00E9A15E00E39B
      5D00DB935C00AC4B1A00ACA7AC00CECACE0000000000E2DADA00FAF6F600E6E2
      E100D78C3B00EEB76C00EEB76C00EEB76C00EEB76C00EEB76C00EEB76C00EEB7
      6C00EEB76C00EEB76C00EEB76C00EEB76C00EEB76C00EEB76C00EEB76C00EEB7
      6C00EEB76C00EEB76C00EEB76C00EEB76C00EEB76C00EEB76C00EEB76C00D78C
      3B00E7E1E100F5ECEC00E2DADA000000000000000000D0A49100CB826200D883
      5D00D0663600D0663500D0663500D0663400D0643300D4724E00F9F0ED00FBF9
      F900FBF8F800F4E3DD00EECEC200F6EBE800F8F4F400F7F3F300F7F2F200F6F2
      F200EED4CB00D2612E00D8713900D8723800D8723800D8723800D8713800CD6A
      3400C3947B00EAEAEA00FCFCFC0000000000A9A9A90054545400848484007D7D
      7D007E7E7E007F7F7F007F7F7F00808080008181810083838300838383008383
      8300848484008686860086868600878787008888880089898900898989008A8A
      8A008B8B8B008D8D8D008D8D8D008E8E8E008F8F8F0090909000909090009191
      9100929292009393930054545400A9A9A90000000000F7F7F700BB561500ECA9
      6B00EEAB6C00F0AD6C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00FCFBFC00EAA76B00E3A1
      6900DB986700AB4A1A00ACA7AC00CECACE0000000000E2DADA00FBF7F700E4DF
      DF00DA904000F3C17500F3C17500F3C17500F3C17500F3C17500F3C17500F3C1
      7500F3C17500F3C17500F3C17500F3C17500F3C17500F3C17500F3C17500F3C1
      7500F3C17500F3C17500F3C17500F3C17500F3C17500F3C17500F3C17500DA90
      4000E4DFDE00F5ECEC00E2DADA000000000000000000F9F4F100B0613E00DE9D
      7F00D3714500D0663600D0663500D0663500CC582A00E7B19E00FDFCFC00FDFB
      FB00FCFAFA00FBF9F900FAF8F800FAF7F700F9F6F600F9F5F500F8F4F400F7F3
      F300DD907300D4693300D66F3800D6703800D6703800D6703800D46E3700BC65
      3500DCD6D300F7F7F7000000000000000000B6B6B60054545400848484008181
      81007F7F7F007F7F7F0080808000818181008383830083838300838383008484
      84008686860086868600878787008888880089898900898989008A8A8A008B8B
      8B008D8D8D008D8D8D008E8E8E008F8F8F009090900090909000919191009292
      9200959595008787870054545400B6B6B60000000000F8F8F800BB551500EDB2
      7D00F0B57E00F1B67E00FEFEFE00D4D4D400D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D2D2D200FBFAFB00EBB07C00E4A9
      7A00DCA07700AA4A1B00AFAAAF00D1CDD10000000000E2DADA00FBF8F800E2DC
      DC00DD954400F9CB7E00F9CB7E00F9CB7E00F9CB7E00F9CB7E00F9CB7E00F9CB
      7E00F9CB7E00F9CB7E00F9CB7E00F9CB7E00F9CB7E00F9CB7E00F9CB7E00F9CB
      7E00F9CB7E00F9CB7E00F9CB7E00F9CB7E00F9CB7E00F9CB7E00F9CB7E00DD95
      4400E2DCDC00F4EBEB00E2DADA00000000000000000000000000E1C6BA00BB6C
      4900DF977700D16A3B00D0663600D0663500D0643400CB562900E4A79100FEFD
      FD00FDFCFC00FDFBFB00FCFAFA00FBF9F900FAF8F800FAF7F700F9F6F600E8B8
      A700D05D2C00D56C3600D56D3700D56D3700D56D3700D56D3700C2612F00CEB1
      A100F1F1F100FDFDFD000000000000000000CFCFCF0054545400696969009C9C
      9C00808080008080800081818100838383008383830083838300848484008686
      860086868600878787008888880089898900898989008A8A8A008B8B8B008D8D
      8D008D8D8D008E8E8E008F8F8F00909090009090900091919100929292009494
      9400A2A2A2006969690054545400CFCFCF0000000000F9F9F900B9541600ECB8
      8900F0BB8A00F1BD8B00FCFCFC00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FCFCFC00FBFBFB00F9F8F900EBB68800E4AE
      8500DBA58100A9491B00BCB8BC00DBD8DB0000000000E2DADA00FCF9F900E0DA
      DA00DF994800DF994800DF994800DF994800DF994800DF994800DF994800DF99
      4800DF994800DF994800DF994800DF994800DF994800DF994800DF994800DF99
      4800DF994800DF994800DF994800DF994800DF994800DF994800DF994800DF99
      4800E1DADA00F4EAEA00E2DADA0000000000000000000000000000000000C58D
      7600C77D5C00DF977700D16A3B00D0663600D0663500D0663500CD5C2E00D067
      4000EBBDAC00F7E8E200FDFCFC00FCFBFB00F9EFED00ECC4B600D77C5900CF5D
      2C00D46B3500D46B3600D46B3600D46B3600D46C3A00C7643400C2886B00EEEE
      EE00FCFCFC00000000000000000000000000F9F9F9005E5E5E00545454008E8E
      8E00A0A0A0008A8A8A0083838300838383008383830084848400868686008686
      8600878787008888880089898900898989008A8A8A008B8B8B008D8D8D008D8D
      8D008E8E8E008F8F8F009090900090909000919191009292920098989800A3A3
      A3008E8E8E00545454005E5E5E00F9F9F90000000000FDFDFD00B7531600EBBA
      9200EEBE9300F0C09400FBFAFB00D2D1D200D2D1D200D2D1D200D2D1D200D2D1
      D200D2D1D200D2D1D200D2D1D200D2D1D200D2D1D200D2D1D200D2D1D200D2D1
      D200D2D1D200D2D1D200D2D1D200D1D0D100D0CFD000F7F5F700E9B89100E1B0
      8D00D8A68900A7471C00D6D3D600ECEAEC0000000000E2DADA00FCFAFA00DFD8
      D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8
      D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8
      D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8
      D800DFD8D800F3E9E900E2DADA00000000000000000000000000000000000000
      0000C58D7600C77D5C00DF977700D3714500D0663600D0663500D0663500D065
      3400CE5E2E00CC582A00CC562900CC562900CC582A00CF5E2E00D1663300D269
      3500D2693500D3693500D36A3700D36C4000C5633600C1886B00EEEEEE00FCFC
      FC000000000000000000000000000000000000000000AAAAAA00545454005959
      590098989800A7A7A7009F9F9F0097979700929292008F8F8F00909090009191
      9100919191009292920092929200929292009393930094949400959595009595
      9500969696009696960097979700999999009E9E9E00A2A2A200A7A7A7009898
      98005959590054545400AAAAAA000000000000000000FEFEFE00FBFBFB00B853
      1600ECBC9500EEBF9600F9F7F900F9F7F900F9F8F900F9F8F900F9F8F900F9F8
      F900F9F8F900F9F8F900F9F8F900F9F8F900F9F8F900F9F8F900F9F8F900F9F8
      F900F9F8F900F9F8F900F9F7F900F9F7F900F7F5F700F3F0F300E6B59200DEAD
      8E00AB4A1B00D8D6D800EEEDEE00F9F9F90000000000E2DADA00FEFCFC00FDFB
      FB00FDFBFB00FDFBFB00FDFBFB00FDFBFB00FDFBFB00FDFBFB00FDFBFB00FDFB
      FB00FDFBFB00FDFBFB00FDFBFB00FBF8F800F4EBEB00F2E8E800F2E8E800F2E8
      E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8
      E800F2E8E800F3E9E900E2DADA00000000000000000000000000000000000000
      000000000000C58D7600BB6C4900DE9D7F00D8845D00D16A3A00D0663500D066
      3500D0663500D0663500D0663400D1673400D1673500D1673500D1673500D168
      3500D2693600D26E4000D0704700BE5F3300C38A6D00F1F1F100FCFCFC000000
      00000000000000000000000000000000000000000000F8F8F800777777005454
      54005858580086868600A6A6A600A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A6A6A600868686005858
      58005454540077777700F8F8F80000000000000000000000000000000000FBFB
      FB00B7531600B9541600BB551500BB561500BB561500BB561500BB561500BB56
      1500BB561500BB561500BB561500BB561500BB561500BB561500BB561500BB56
      1500BB561500BB561500BB561500BB551500BA541600B7531600B3501800AD4C
      1A00E5E4E500F2F1F200FBFBFB00FEFEFE0000000000E5DEDE00F2E8E800F2E8
      E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8
      E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8
      E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8E800F2E8
      E800F3E9E900EFE6E600E4DDDD00000000000000000000000000000000000000
      00000000000000000000E1C6BA00B0613E00CB826200E09D7F00D9886400D476
      4B00D0663500D0663500D0663500D0663500D0663400D0663400D16F4000D174
      4A00D1795200C46A4200B55F3700D9BCAE00F7F7F700FDFDFD00000000000000
      0000000000000000000000000000000000000000000000000000EEEEEE007777
      770054545400545454005E5E5E00787878008484840089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      890089898900898989008989890084848400787878005E5E5E00545454005454
      540077777700EEEEEE0000000000000000000000000000000000000000000000
      0000FDFDFD00FAFAFA00F8F8F800F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F8F8
      F800FAFAFA00FDFDFD00FEFEFE000000000000000000F8F6F600E2DADA00E2DA
      DA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DA
      DA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DA
      DA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DADA00E2DA
      DA00E2DADA00E2DADA00F8F6F600000000000000000000000000000000000000
      0000000000000000000000000000F9F4F100D0A49100B1623E00C0724F00D18A
      6900DA957600DA906E00D7876200D5845F00D5866200D1846100C8775200BC67
      3F00B25E3700CDA08A00F1EBE900FCFCFC000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F9F9
      F900AAAAAA005F5F5F0054545400545454005454540054545400545454005454
      5400545454005454540054545400545454005454540054545400545454005454
      54005454540054545400545454005454540054545400545454005F5F5F00AAAA
      AA00F9F9F9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E2C6BA00CA98
      8200B9785900B0624000B15C3500B25C3500B2644000BC785900CA988000DDC1
      B300F9F9F900FDFDFD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFAFA00D0D0D000B6B6B600AAAAAA00A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900AAAAAA00B6B6B600D0D0D000FAFAFA000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFAFA00CFCFCF00B6B6B600AAAAAA00A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900AAAAAA00B6B6B600CFCFCF00FAFAFA000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FBFBFB00D1D1D100B6B6B600ABABAB00A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900ABABAB00B6B6B600D1D1D100FBFBFB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000706F6700706F6700716F
      6700716F6700716F670071706800717068007170680071706800717068007170
      6800717068007271690072716900727169007271690072716900727169007271
      6900727169007271690072726A0073726A0073726A0073726A0073726A007372
      6A0073726A0073726A0073736B007C7C7400000000000000000000000000F9F9
      F900ABABAB005E5E5E0054545400545454005454540054545400545454005454
      5400545454005454540054545400545454005454540054545400545454005454
      54005454540054545400545454005454540054545400545454005E5E5E00ABAB
      AB00F9F9F900000000000000000000000000000000000000000000000000FAFA
      FA00ABABAB005F5F5F0054545400545454005454540054545400545454005454
      5400545454005454540054545400545454005454540054545400545454005454
      54005454540054545400545454005454540054545400545454005F5F5F00ABAB
      AB00FAFAFA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000483631000000000000000000000000000000
      00000000000000000000000000000000000094928A00A19E9300A29F9400A3A1
      9600A3A19600A4A19700A5A39800A5A39800A6A49900A8A59A00A9A69B00A9A6
      9B00AAA79C00ABA99E00ABA99E00ACAA9F00ADABA000AEABA000AEACA100B0AD
      A200B0AEA300B1AFA400B1AFA400B2B0A500B3B1A600B3B1A600B5B2A700B5B2
      A700B5B3A800B6B4A900B6B4A900888880000000000000000000EFEFEF007777
      770054545400545454006969690084848400848484007F7F7F007B7B7B007A7A
      7A00797979007979790078787800777777007575750075757500757575007474
      7400737373007272720074747400787878007C7C7C0069696900545454005454
      540077777700EFEFEF0000000000000000000000000000000000EFEFEF007777
      770054545400545454005E5E5E0078787800858585008A8A8A008A8A8A008A8A
      8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A
      8A008A8A8A008A8A8A008A8A8A0085858500787878005E5E5E00545454005454
      540077777700EFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004735300000000000A9A9A900000000000000
      00000000000000000000000000000000000094928A009F9C9100A09D9200A09D
      9200A19E9300A39F9500A3A19600A4A19600A5A29700A6A39800A6A39800A7A4
      9900A8A59A00A9A79C00A9A79C00AAA79C00ACA99E00ACA99E00ADAA9F00AEAB
      A000AEABA000AFACA100AFADA200B0AEA300B1AEA300B1AFA400B2AFA400B3B0
      A500B3B0A500B4B2A700B4B2A7008888800000000000FAFAFA00777777005454
      5400595959008E8E8E009C9C9C00818181007D7D7D007B7B7B007B7B7B007A7A
      7A00797979007878780078787800777777007676760075757500747474007474
      74007474740072727200727272007272720070707000808080008C8C8C005959
      59005454540077777700FAFAFA000000000000000000F9F9F900777777005454
      54005858580087878700A6A6A600A7A7A7009F9F9F009A9A9A009A9A9A009B9B
      9B009B9B9B009B9B9B009B9B9B009C9C9C009C9C9C009C9C9C009C9C9C009D9D
      9D009D9D9D009D9D9D009D9D9D00A1A1A100A7A7A700A6A6A600878787005858
      58005454540077777700F9F9F900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000503D39004C37310047332E000000000000000000000000000000
      00000000000000000000000000000000000094928A009E9A8F009E9B9000CECC
      C600CFCDC700A19D9200A19D9300A29E9300A3A09500D0CFC900D1CFC900A5A2
      9700A6A39800A6A39800A7A49900D3D1CC00D3D2CC00AAA79C00ABA89D00ABA8
      9D00ACA99E00D5D4CE00D5D4CE00AFACA100AFACA100B0ADA200B0ADA200D7D6
      D000D7D6D000B1AFA400B2B0A5008888800000000000ABABAB00545454005858
      580098989800A0A0A000808080007F7F7F007E7E7E007D7D7D007B7B7B007B7B
      7B007A7A7A007979790078787800787878007777770077777700757575007474
      74007474740074747400727272007272720072727200707070007E7E7E009999
      99005858580054545400ABABAB000000000000000000ABABAB00545454005959
      590099999900969696007B7B7B00737373007272720073737300747474007474
      74007474740076767600777777007878780078787800797979007A7A7A007B7B
      7B007C7C7C007D7D7D007E7E7E007F7F7F0080808000888888009C9C9C009999
      99005959590054545400ABABAB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000352927003D322F005D524E000000000000000000000000000000
      00000000000000000000000000000000000094928A009C988D009C998E00504E
      4800CECCC6009E9A8F009F9B9100A09C9100A19E930052514B00D0CEC800A3A0
      9500A4A09500A4A19600A6A2970055534D00D2D0CA00A8A49900A9A69B00A9A6
      9B00AAA79C0057555000D5D3CD00ADA99E00ADA99E00AEAA9F00AEABA0005958
      5200D6D5CF00AFACA100B0ADA20088888000FBFBFB005F5F5F00545454008686
      8600A7A7A7008A8A8A00808080007F7F7F007F7F7F007E7E7E007D7D7D007C7C
      7C007B7B7B007A7A7A0079797900787878007878780078787800777777007575
      7500747474007474740074747400737373007272720072727200707070009696
      960087878700545454005F5F5F00FBFBFB00FAFAFA005E5E5E00545454008C8C
      8C007E7E7E007070700072727200727272007373730074747400747474007474
      740076767600777777007878780078787800797979007A7A7A007B7B7B007C7C
      7C007D7D7D007E7E7E007F7F7F007F7F7F008080800082828200838383008C8C
      8C008E8E8E00545454005E5E5E00FAFAFA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7E7E00716E6E006E6868007D737200776E6D00746A690068605F005953
      52005049480035292700383130005D524E000000000000000000000000000000
      00000000000000000000000000000000000094928A009A958B009B978B00504D
      4700CDCAC5009D998D009E9A8E009E9A8F009F9B8F0052504A00CFCDC700A29E
      9200A29F9300A29F9400A4A0950054524C00D1CFC900A6A29700A7A39700A7A4
      9900A8A4990056544F00D4D2CC00ABA79B00ABA79C00A8A49800A09C9200504E
      4800C1C0BB00A19E9400ABA79C0088888000D1D1D100545454005E5E5E00A6A6
      A6009F9F9F008383830081818100808080007F7F7F007F7F7F007E7E7E007D7D
      7D007C7C7C007B7B7B007A7A7A00797979007878780078787800787878007777
      7700757575007474740074747400747474007373730072727200727272007B7B
      7B00A6A6A6005E5E5E0054545400D1D1D100CFCFCF0054545400696969008080
      8000707070007272720072727200737373007474740074747400747474007676
      7600777777007878780078787800797979007A7A7A007B7B7B007C7C7C007D7D
      7D007E7E7E007F7F7F007F7F7F00808080008282820083838300838383008383
      83008F8F8F006969690054545400CFCFCF000000000000000000000000000000
      00000000000000000000000000000000000073717700847E7E008C8684007D73
      72007D7372006E686800000000000000000000000000000000006E5C57005D4E
      4800655D5D0039302F0000000000423B39000000000000000000000000000000
      00000000000000000000000000000000000094928A0098938900999489004E4C
      4600CCC9C4009B978C009C978C009C988D009D998E00504E4800CECCC600A09B
      9000A09B90009D998F00979389004B494400BCBBB50098958A00A09C9100A5A1
      9600A6A2970055534D00D3D1CB00A8A49900A9A59A009D998F00858279003E3C
      38009695920086837B00A19D930088888000B6B6B6005454540078787800A7A7
      A70097979700838383008383830081818100808080007F7F7F007F7F7F007E7E
      7E007D7D7D007C7C7C007B7B7B007A7A7A007979790079797900787878007878
      7800777777007575750074747400747474007474740073737300727272007373
      7300A7A7A7007878780054545400B6B6B600B6B6B600545454007C7C7C007070
      7000727272007272720073737300747474007474740074747400767676007777
      77007878780078787800797979007A7A7A007B7B7B007C7C7C007D7D7D007E7E
      7E007F7F7F007F7F7F0080808000828282008383830083838300838383008585
      8500868686008686860054545400B6B6B6000000000000000000000000000000
      0000000000000000000000000000636270002C217A0021197C00302985000000
      000000000000000000000000000000000000000000006B605C00000000000000
      000000000000301E1C0000000000443F3F000000000000000000000000000000
      00000000000000000000000000000000000094928A0097918700979287004D4B
      4500CAC8C3009A948A009A948A009A968B009C978C00504D4700CDCAC5009E99
      8E009E998E00948F85007D7A71003A39350093928D007F7B730097938900A39F
      9400A39F940054524C00D2CFC900A6A19600A7A3980097948A00292B2B002324
      240023242400242626009A958C0088888000ABABAB005454540084848400A7A7
      A7009292920083838300838383008383830081818100808080007F7F7F007F7F
      7F007E7E7E007D7D7D007C7C7C007B7B7B007A7A7A007A7A7A00797979007878
      7800787878007777770075757500747474007474740074747400737373007272
      72009F9F9F008585850054545400ABABAB00AAAAAA0054545400787878007272
      7200727272007373730074747400747474007474740076767600777777007878
      780078787800797979007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F
      7F007F7F7F008080800082828200838383008383830083838300858585008686
      8600868686008A8A8A0054545400AAAAAA000000000000000000000000000000
      000000000000A3A3A3006F6A7500473F7A001A117F00180E81001D1685008C85
      840000000000000000000000000000000000705F5C0079727000000000000000
      0000000000005E56560000000000443F3F000000000000000000000000000000
      00000000000000000000000000000000000094928A0095908400959085004C4A
      4400CAC7C2009892870098938800989388009A9589004F4C4600CCC9C4009C97
      8B009D988C008E8A8000292B2B00232424002324240024262600928D8300A19D
      9200A39D920053514B00D1CEC800A49F9400A5A0950099958A007B828000878E
      8C00868D8B00757B7A009C978D0088888000A9A9A9005454540089898900A7A7
      A7008F8F8F008484840083838300838383008383830086868600DDDDDD009C9C
      9C007F7F7F007E7E7E007D7D7D007C7C7C007B7B7B007B7B7B007A7A7A007979
      7900787878007878780077777700767676007474740074747400747474007373
      73009A9A9A008A8A8A0054545400A9A9A900A9A9A90054545400747474007272
      7200727272007474740074747400747474007575750077777700787878007878
      7800797979007A7A7A007B7B7B007B7B7B007D7D7D00AFAFAF00B2B2B2008686
      8600808080008181810083838300838383008383830084848400868686008686
      8600878787008989890054545400AAAAAA000000000000000000000000000000
      0000000000007D7A7900483F83002D258900180E8900160E8800191186008F88
      8700000000000000000000000000705F5C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094928A00938E8300948E83004C49
      4300C9C6C000969085009691860097918600989388004D4B4500CBC8C3009A95
      8A009A958A00908B81007B828000878E8C00868D8B00757B7A00948E84009F9A
      8F00A09B9000524F4900D0CDC700A29D9200A39E9300A09A9000BABEBD00D5D7
      D600D3D6D500B6BAB900A29D920088888000A9A9A9005454540089898900A7A7
      A700909090008686860084848400838383008383830086868600000000000000
      0000DBDBDB009A9A9A007E7E7E007D7D7D007C7C7C007B7B7B007B7B7B007A7A
      7A00797979007878780078787800777777007676760074747400747474007474
      74009A9A9A008A8A8A0054545400A9A9A900A9A9A90054545400727272007272
      7200747474007474740074747400757575007777770078787800787878007979
      79007A7A7A007B7B7B007B7B7B007D7D7D007E7E7E00C7C7C70000000000FBFB
      FB00CDCDCD008B8B8B0083838300838383008484840086868600868686008787
      8700888888008A8A8A0054545400AAAAAA000000000000000000000000000000
      0000000000007C76D1002F2AAB00211AA000180F9800181093001A148E005B58
      A3008987810080808000705F5C00000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      00000000000000000000000000000000000094928A00928C8000938D81004B48
      4200C8C5BF00948E8300958F840096908400969085004D4A4400CAC7C2009992
      87009993880095918600BABEBD00D5D7D600D3D6D500B6BAB900999389009E98
      8D009F998E00514E4800CFCCC600A09A8F00A19C9100A29C9100A29C91005350
      4A00D0CDC700A49E9300A49E930088888000A9A9A9005454540089898900A7A7
      A700919191008686860086868600848484008383830084848400000000000000
      00000000000000000000D9D9D900989898007D7D7D007D7D7D007B7B7B007B7B
      7B007A7A7A007979790078787800787878007777770076767600747474007474
      74009B9B9B008A8A8A0054545400A9A9A900A9A9A90054545400737373007474
      740074747400747474007575750077777700787878007878780083838300C4C4
      C4007B7B7B007B7B7B007D7D7D007E7E7E007F7F7F00C7C7C700000000000000
      000000000000F2F2F200A7A7A700848484008686860086868600878787008888
      8800898989008A8A8A0054545400AAAAAA000000000000000000000000000000
      000000000000413EB5002621B3001E17B3001912AC001A16A6001C16A1003D3C
      AC00808080008080800000000000000000000000000000000000000000000000
      00000000000000000000807F7E00000000000000000000000000000000000000
      00000000000000000000000000000000000094928A00908A7F00918B80004A47
      4100C7C4BF00938C8100938D8200938D8200948E83004C494400C9C6C1009790
      85009790850097928700999388004E4B4500CCC8C2009B958A009B958A009C96
      8B009C968B00504D4700CDCAC4009E988D009F988D00A09A8F00A09A8F00524F
      4900CFCCC600A29C9100A29C910088888000A9A9A9005454540089898900A7A7
      A700919191008787870086868600868686008484840083838300FDFDFD000000
      000000000000000000000000000000000000D7D7D700979797007D7D7D007B7B
      7B007B7B7B007A7A7A0079797900787878007878780077777700767676007474
      74009B9B9B008A8A8A0054545400A9A9A900A9A9A90054545400747474007474
      7400747474007575750077777700787878007878780079797900CFCFCF000000
      0000A1A1A1007D7D7D007E7E7E007F7F7F007F7F7F009B9B9B00DADADA00FEFE
      FE00000000000000000000000000ADADAD008686860087878700888888008989
      8900898989008B8B8B0054545400AAAAAA000000000000000000000000000000
      0000000000004641D0002824CA002320C6001F1BC000201CBA002220B5003F40
      C300CCCCC7000000000000000000000000000000000000000000000000000000
      00000000000000000000807F7E00000000000000000000000000000000000000
      00000000000000000000000000000000000094928A008E887D008E897D004946
      4000C6C3BD00908A7F00918B8000918B8000928C80004B484200C8C5BF00948E
      8300958E8300968F8400979186004D4A4400CAC7C100989186009A9388009691
      86008F8A7F0048443F00B9B6B100928B8100999288009E978C009E978C00514D
      4800CECAC500A09A8F00A09A8F0088888000A9A9A9005454540089898900A7A7
      A700929292008888880087878700868686008686860084848400FBFBFB000000
      0000000000000000000000000000000000000000000000000000D6D6D6009494
      94007B7B7B007B7B7B007A7A7A00797979007878780078787800777777007676
      76009B9B9B008A8A8A0054545400A9A9A900A9A9A90054545400757575007474
      74007575750077777700787878007878780079797900A2A2A200000000000000
      0000F0F0F000848484007F7F7F007F7F7F008080800081818100838383009B9B
      9B00EBEBEB000000000000000000F7F7F7009090900088888800898989008989
      89008A8A8A008C8C8C0054545400AAAAAA000000000000000000000000000000
      000000000000504ED9003331D9002C2BD7002A29D2002928CB002A2AC8004547
      C600B3B4C9000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094928A008D857B008D867B004844
      3F00C5C2BC008E887D0090887E0090897E00908A7E004A464100C7C4BE00938C
      8100948C8100948D8100948E83004C494300C9C6C000978F8400979185008D87
      7D007772690037353100918E8A0079736B00908A7F009C958A009C958A00504C
      4700CDC9C4009E978C009E988D0088888000A9A9A9005454540089898900A7A7
      A700939393008989890088888800878787008686860086868600F9F9F9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D4D4D400919191007B7B7B007A7A7A007979790078787800787878007777
      77009B9B9B008A8A8A0054545400A9A9A900A9A9A90054545400757575007575
      75007777770078787800787878007979790082828200F1F1F100000000000000
      000000000000C7C7C7007F7F7F00808080008181810083838300838383008383
      83008F8F8F00F4F4F4000000000000000000BCBCBC0089898900898989008A8A
      8A008B8B8B008D8D8D0054545400AAAAAA000000000000000000000000000000
      0000000000005F5EE5003F3FE4003637E5003233DF003233DA003234D6004D50
      CE007E84DB000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000006E6A680000000000000000000000
      00000000000000000000000000000000000094928A008A8378008B8379004743
      3E00C4C0BA008C867A008D867B008D867B008E877C0049454000C6C3BD00908A
      7F00918A7F00928A7F00928C81004B474200C8C5BF00948D8200958E83008782
      7800292B2B002324240023242400242626008B847A00999387009B9388004F4B
      4600CCC8C3009B9489009C958A0088888000A9A9A9005454540089898900A7A7
      A700939393008989890089898900888888008787870086868600F7F7F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFCFC009E9E9E007B7B7B007A7A7A0079797900787878007878
      78009C9C9C008A8A8A0054545400A9A9A900A9A9A90054545400757575007676
      760077777700787878007878780079797900CCCCCC0000000000000000000000
      000000000000FEFEFE009A9A9A00808080008282820083838300838383008383
      830085858500C1C1C1000000000000000000D8D8D80089898900898989008A8A
      8A008C8C8C008D8D8D0054545400AAAAAA000000000000000000000000000000
      0000000000006464EB00484CED003F43ED00383BE700393BE300393CDE004F54
      D9007278DE00DFE0DB0000000000000000000000000000000000000000000000
      0000000000006963620000000000000000006F6B690000000000000000000000
      00000000000000000000000000000000000094928A00857D72007F786E003F3C
      3700B1ADA80080797000888076008C8479008C847A0048443F00C5C1BB008D87
      7C008E887D0090887D0090897E004A464100C7C3BD00928B8000938C81008A82
      78007B828000878E8C00868D8B00757B7A008C857B0098908500989186004E4A
      4400CBC7C2009A9287009A93880088888000A9A9A9005454540089898900A7A7
      A700939393008A8A8A0089898900898989008888880087878700F4F4F4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D7D7D700919191007D7D7D007C7C7C007B7B7B007A7A7A00797979007878
      78009C9C9C008A8A8A0054545400A9A9A900A9A9A90054545400777777007777
      77007878780078787800797979009E9E9E000000000000000000000000000000
      00000000000000000000E9E9E900848484008383830083838300838383008585
      850086868600B4B4B4000000000000000000E1E1E100898989008A8A8A008C8C
      8C008D8D8D008D8D8D0054545400AAAAAA000000000000000000000000000000
      0000000000007078F600545BF6004A50F5004246ED003F44E9003E44E4004E54
      E0006A71E000DCDCDA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F6B690000000000000000000000
      00000000000000000000000000000000000094928A007C746A0069625B00302D
      2A008A8683006A645B007E776D00898177008982770046423D00C4C0BA008C83
      79008C857A008C867B008D877C0048453F00C6C2BC0090887D00908A7F008E87
      7C00BABEBD00D5D7D600D3D6D500B6BAB900918A7F00958D8300968E83004D49
      4300CAC6C100989085009890850088888000A9A9A9005454540089898900A7A7
      A700949494008B8B8B008A8A8A00898989008989890088888800F2F2F2000000
      0000000000000000000000000000000000000000000000000000E5E5E5009E9E
      9E007F7F7F007F7F7F007E7E7E007D7D7D007C7C7C007B7B7B007A7A7A007979
      79009C9C9C008A8A8A0054545400A9A9A900A9A9A90054545400787878007878
      780078787800797979007A7A7A00919191009D9D9D009E9E9E00F8F8F8000000
      000000000000C4C4C400A9A9A9008B8B8B008383830083838300858585008686
      860086868600CFCFCF000000000000000000D0D0D0008A8A8A008C8C8C008D8D
      8D008D8D8D008E8E8E0054545400AAAAAA000000000000000000000000000000
      000000000000757CF7006067FB00565EFB004C52F300484DEE00464CEA004D55
      E4005E64E400C0C2DD0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006F6B6900000000000000
      00000000000000000000000000000000000094928A00756F6500292B2B002324
      2400232424002426260079726900867F7500877F750045413C00C2BEB9008882
      7800898278008B8378008B83790047433E00C5C1BB008D867B008E877C008F88
      7D0090887D004A454000C7C3BD00928A8000928B8000948B8000958C81004C47
      4200C9C5C000968E8300968E830088888000A9A9A9005454540089898900A7A7
      A700959595008D8D8D008B8B8B008A8A8A008989890089898900F0F0F0000000
      000000000000000000000000000000000000F1F1F100AFAFAF00848484008181
      8100808080007F7F7F007F7F7F007E7E7E007D7D7D007C7C7C007B7B7B007A7A
      7A009C9C9C008A8A8A0054545400A9A9A900A9A9A90054545400797979007878
      7800797979007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E00D5D5D5000000
      000000000000DFDFDF0084848400838383008383830085858500868686008686
      860097979700FAFAFA000000000000000000B8B8B8008C8C8C008D8D8D008D8D
      8D008E8E8E008F8F8F0054545400AAAAAA000000000000000000000000000000
      0000000000009B9EF200717AFB00646DFC00565EF6005258F2004F55EE005258
      E9005C62E7009A9EE60000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006F6B6A00000000000000
      00000000000000000000000000000000000094928A00767067007B828000878E
      8C00868D8B00757B7A0079726900847B7100847C720044403B00C1BDB800867F
      7400877F7500878076008981770046423D00C3C0BA008B8479008C8479008D84
      7A008D867C0048453F00C6C2BC0090887D0091897E0091897E00928A7F004B47
      4100C8C4BF00958C8100958C810088888000A9A9A9005454540089898900A7A7
      A700959595008D8D8D008D8D8D008B8B8B008A8A8A0089898900EEEEEE000000
      00000000000000000000F9F9F900BEBEBE008787870083838300838383008383
      830081818100808080007F7F7F007F7F7F007E7E7E007D7D7D007C7C7C007B7B
      7B009D9D9D008A8A8A0054545400A9A9A900A9A9A90054545400797979007979
      79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00A3A3A3000000
      00000000000000000000D0D0D000878787008585850086868600868686008E8E
      8E00EAEAEA000000000000000000F6F6F600909090008D8D8D008D8D8D008E8E
      8E008F8F8F009090900054545400AAAAAA000000000000000000000000000000
      000000000000BFBFEB008490FC00757FFE00626BF8005D64F5005960F2005960
      ED00646BEA008085E90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000706C6B000000
      00000000000000000000000000000000000094928A007E766D00BABEBD00D5D7
      D600D3D6D500B6BAB9007C756B0081786F0082796F00433E3900C0BBB600847C
      7300857D7300867D7400867E740045413C00C3BDB800898076008A8278008B83
      78008C83790047433E00C5C1BB008E867B008F877C0090877D0090887D004B46
      4100CCC8C300A29C9200AAA69B0088888000A9A9A9005454540089898900A7A7
      A700969696008E8E8E008D8D8D008D8D8D008B8B8B008A8A8A00ECECEC000000
      0000FEFEFE00CDCDCD0090909000868686008585850084848400838383008383
      83008383830081818100808080007F7F7F007F7F7F007E7E7E007D7D7D007C7C
      7C009D9D9D008A8A8A0054545400A9A9A900A9A9A900545454007A7A7A007A7A
      7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F007F7F7F0080808000DEDE
      DE00000000000000000000000000F0F0F000C9C9C900BDBDBD00D5D5D500FCFC
      FC00000000000000000000000000BBBBBB008D8D8D008D8D8D008E8E8E008F8F
      8F00909090009090900054545400AAAAAA000000000000000000000000000000
      000000000000E2DAD600929EFA008790FD006F7BFA006973F800646EF5006169
      F100676FEE00747EEA008E8E8E00000000000000000000000000000000000000
      00000000000076686400736765006B62620073605D00686262006E6968000000
      00000000000000000000000000000000000094928A00D1C8C000C6BDB6005F5C
      5800D7D4CF00A8A198009F998F0098928800918A810048443F00C3BFB900877F
      7500857C7200847B7100847C7200443F3A00C2BDB800898278008E867B008F89
      7E00938E83004D4A4500CDCAC500A19E9300A7A49900ADABA000B3B2A8005F5F
      5A00DEDFD900C0C1B600C1C2B70088888000A9A9A9005454540089898900A7A7
      A700979797008F8F8F008E8E8E008D8D8D008D8D8D008B8B8B00EAEAEA00DBDB
      DB009C9C9C008888880087878700868686008686860086868600848484008383
      8300838383008383830081818100808080007F7F7F007F7F7F007E7E7E007D7D
      7D009D9D9D008A8A8A0054545400A9A9A900A9A9A900545454007B7B7B007B7B
      7B007B7B7B007D7D7D007E7E7E007F7F7F007F7F7F0080808000818181008C8C
      8C00EAEAEA000000000000000000000000000000000000000000000000000000
      00000000000000000000CBCBCB008D8D8D008D8D8D008E8E8E008F8F8F009090
      9000909090009191910054545400AAAAAA000000000000000000000000000000
      00000000000000000000A5B0F50096A1F9007E8AFA007782FA006F7AF8006A74
      F4006C76F100767FEF00CDCCCF008C8C8C00909090008E8D8D00797777006F6A
      6A006B64640070656500726565006C5F5F00695C5C00655A5900665A58000000
      00000000000000000000000000000000000094928A00D8CEC700D6CCC5006C67
      6300E7E3DF00CEC6BE00CBC4BC00C4BDB700B8B3AC005B595400CBC9C500B2B0
      A700BAB8B000BDBBB200BBBAB2005F5E5A00DCDBD700B9B8B000B8B8AF00B8B8
      AF00B7B9AF005D5E5900DBDCD700BABBB100BBBCB200BCBDB200BDBEB3006061
      5C00DEDFD900BFC0B600C0C1B70088888000A9A9A9005454540089898900A7A7
      A70097979700909090008F8F8F008E8E8E008D8D8D008D8D8D009D9D9D008A8A
      8A00898989008989890088888800878787008686860086868600868686008484
      840083838300838383008383830082828200808080007F7F7F007F7F7F007E7E
      7E009D9D9D008A8A8A0054545400A9A9A900A9A9A900545454007F7F7F007B7B
      7B007D7D7D007E7E7E007F7F7F007F7F7F008080800081818100838383008383
      83008C8C8C00CDCDCD00FEFEFE00000000000000000000000000000000000000
      0000F8F8F800BABABA008E8E8E008D8D8D008E8E8E008F8F8F00909090009090
      9000919191009393930054545400AAAAAA000000000000000000000000000000
      00000000000000000000D6D0CC00B1B7E100909DF900838EFA007B86FA00727D
      F700727BF500797FF200BABADF00807A8200746666006E6563006C6161006D61
      61006D605F006B5D5D006A5D5D0069595B006352540060565600685B5A000000
      00000000000000000000000000000000000094928A00D9CFC800D6CDC6006C67
      6300E8E3DF00CEC7BF00CCC5BD00BBB5AE009B979000474543009F9E9B009693
      8D00B2AFA600BDBBB200BCBAB1005F5E5A00DBDBD600B8B8AF00B8B9AE00B7B8
      AF00B7B8AF005D5E5900DADBD600B9BAB000BABBB100BBBCB200BCBDB3006061
      5C00DEDED900BFC0B500C0C1B60088888000ABABAB005454540084848400A7A7
      A7009A9A9A0090909000909090008F8F8F008E8E8E008D8D8D008D8D8D008C8C
      8C008A8A8A008989890089898900888888008787870087878700868686008686
      86008484840083838300838383008383830082828200808080007F7F7F007F7F
      7F00A1A1A1008585850054545400ABABAB00AAAAAA0054545400848484007D7D
      7D007E7E7E007F7F7F007F7F7F00808080008181810083838300838383008383
      8300848484008686860095959500C1C1C100DDDDDD00ECECEC00E4E4E400C5C5
      C500969696008D8D8D008D8D8D008E8E8E008F8F8F0090909000909090009191
      9100929292009393930054545400AAAAAA000000000000000000000000000000
      000000000000000000000000000000000000A2ABF1008E9AFA00838FF9007B84
      F9007B82F8007B84F400A8A9E300D6D3D7007061650068595900685858006959
      59006957580065565600655556005E50500055464800594E4E006D6160000000
      00000000000000000000000000000000000094928A00DAD0C900D8CEC7006D67
      6400E8E4E000D0C8C000CDC5BE00B7B2AA00292B2B0023242400232424002426
      2600AEAAA300BEBBB200BCBAB1005F5E5A00DBDBD700B9B8AF00B8B8AF00B7B8
      AE00B7B8AE005D5E5900DADBD600B8B9AF00B9BAB000BABCB100BBBDB2006061
      5B00DDDED900BEBFB500BFC0B60088888000B6B6B6005454540078787800A7A7
      A7009E9E9E009191910090909000909090008F8F8F008E8E8E008D8D8D008D8D
      8D008C8C8C008A8A8A0089898900898989008888880088888800878787008686
      8600868686008484840083838300838383008383830082828200808080008080
      8000A7A7A7007878780054545400B6B6B600B6B6B60054545400848484008181
      81007F7F7F007F7F7F0080808000818181008383830083838300838383008484
      84008686860086868600878787008888880089898900898989008A8A8A008B8B
      8B008D8D8D008D8D8D008E8E8E008F8F8F009090900090909000919191009292
      9200959595008787870054545400B6B6B6000000000000000000000000000000
      000000000000000000000000000000000000B0B2DB009BA5F5008E99F5008791
      FB00838CFA00808BF800868CED00ACAEE0008A869700695B580063505000624E
      4F00614E4E005F4E4D005C4C4C00584A4A004F4546006B636300797675000000
      00000000000000000000000000000000000094928A00DCD1CA00D9CFC8006D68
      6400E9E4E000D1C8C100CEC6BF00BDB6B0007B828000878E8C00868D8B00757B
      7A00B2AFA700BEBBB200BCBAB1005F5E5A00DCDBD700B9B8AF00B8B8AF00B7B8
      AE00B7B8AE005D5D5900DADBD600B7B9AF00B9BAB000BABBB100BBBCB2006060
      5B00DDDED900BEBFB400BFC0B50088888000D1D1D100545454005E5E5E00A6A6
      A600A2A2A200929292009191910090909000909090008F8F8F008E8E8E008D8D
      8D008D8D8D008C8C8C008A8A8A00898989008989890089898900888888008787
      8700868686008686860084848400838383008383830083838300828282008888
      8800A6A6A6005E5E5E0054545400D1D1D100CFCFCF0054545400696969009C9C
      9C00808080008080800081818100838383008383830083838300848484008686
      860086868600878787008888880089898900898989008A8A8A008B8B8B008D8D
      8D008D8D8D008E8E8E008F8F8F00909090009090900091919100929292009494
      9400A2A2A2006969690054545400CFCFCF000000000000000000000000000000
      00000000000000000000000000000000000000000000ADB2DB00A0A8EB008E9A
      FA008E9AFC008A94F8008E94F4008F97E900D6D2D800766C70005D4947005B46
      47005A4646005845450055454400514444005953530069656300000000000000
      00000000000000000000000000000000000094928A00DDD2CB00DAD0C9006E69
      6500E9E4E100D1C9C200CFC7C000C7C0BA00BABEBD00D5D7D600D3D6D500B6BA
      B900BBB8B000BFBBB300BDBBB2005F5E5A00DCDBD700B9B8AF00B8B8AE00B8B8
      AE00B7B7AE005D5E5900DADBD600B7B8AE00B8B9AF00B9BAB000BABCB1005F60
      5B00DDDED800BEBFB400BFC0B50088888000FBFBFB005F5F5F00545454008686
      8600A7A7A70098989800929292009191910090909000909090008F8F8F008E8E
      8E008D8D8D008D8D8D008C8C8C008A8A8A008989890089898900898989008888
      8800878787008686860086868600858585008383830083838300838383009C9C
      9C0087878700545454005F5F5F00FBFBFB00FAFAFA005E5E5E00545454008E8E
      8E00A0A0A0008A8A8A0083838300838383008383830084848400868686008686
      8600878787008888880089898900898989008A8A8A008B8B8B008D8D8D008D8D
      8D008E8E8E008F8F8F009090900090909000919191009292920098989800A3A3
      A3008E8E8E00545454005E5E5E00FAFAFA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AEB2D9009AA4
      F3009BA3FC0095A1FC0098A3FA00979DF1009CA3E500D7D4D9005A444600543F
      3F0055403F0052403F004E3F3E004D4342004642400000000000000000000000
      00000000000000000000000000000000000094928A00DFD3CC00DBD1CA006E69
      6600EAE5E200D3CAC300D0C8C100CDC6BE00CBC4BC0066635F00E2DFDB00C3BF
      B700C2BDB500C0BCB400BEBBB300605F5A00DCDBD700BAB9B000B8B8AF00B8B8
      AF00B7B8AE005D5E5900DADBD600B7B9AF00B7B9AF00B9BAB000BABBB1005F60
      5B00DDDDD800BDBEB400BEBFB5008888800000000000ABABAB00545454005858
      580098989800A3A3A30094949400929292009191910090909000909090008F8F
      8F008E8E8E008D8D8D008D8D8D008C8C8C008A8A8A008A8A8A00898989008989
      89008888880087878700868686008686860085858500838383008C8C8C009999
      99005858580054545400ABABAB000000000000000000ABABAB00545454005959
      590098989800A7A7A7009F9F9F0097979700929292008F8F8F00909090009191
      9100919191009292920093939300939393009393930094949400959595009595
      95009696960097979700979797009A9A9A009E9E9E00A2A2A200A7A7A7009898
      98005959590054545400ABABAB00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADB5
      E400A7AFF1009EA9FA00A1ACF900A5ACF900A6ABF700AAB1ED005C494C00473E
      3D004D403F004B3F4000483E3E003E3A39000000000000000000000000000000
      00000000000000000000000000000000000094928A00DFD4CD00DDD1CB006F6A
      6600EBE6E200D4CBC400D1C9C200CEC7BF00CBC5BD0066635F00E2DFDC00C4C0
      B800C2BEB600C0BDB500BEBBB300605F5B00DCDBD700BAB9B000B9B8AF00B8B8
      AE00B7B8AE005D5D5900DADBD600B6B8AE00B7B8AE00B8B9AF00B9BBB0005F60
      5A00DCDDD800BDBEB300BEBFB4008888800000000000FAFAFA00777777005454
      5400595959008E8E8E00A2A2A200959595009292920091919100909090009090
      90008F8F8F008E8E8E008D8D8D008D8D8D008C8C8C008B8B8B008A8A8A008989
      890089898900888888008787870086868600868686008F8F8F008E8E8E005959
      59005454540077777700FAFAFA000000000000000000F9F9F900777777005454
      54005858580086868600A6A6A600A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A6A6A600868686005858
      58005454540077777700F9F9F900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B3BBDB00B3BBEB00AAB6F900ABB5F900B2B8F500BEC4EF00C8CBDD008080
      8000554C4B008080800000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094928A00E1D5CF00DED3CC00706A
      67006E696600D5CCC500D2CAC300D0C8C100CDC6BF006764600066625F00C5C0
      B800C3BFB700C1BDB600BFBBB400605F5B00605F5A00BAB9B000BAB9B000B8B8
      AF00B7B7AF005D5E59005D5E5900B6B8AF00B7B9AF00B7B9AF00B8BAB0005F5F
      5A005F605B00BCBDB300BDBEB400888880000000000000000000EFEFEF007777
      7700545454005454540069696900878787009393930093939300919191009090
      9000909090008F8F8F008E8E8E008D8D8D008D8D8D008D8D8D008C8C8C008B8B
      8B008A8A8A008A8A8A00898989008A8A8A008686860069696900545454005454
      540077777700EFEFEF0000000000000000000000000000000000EFEFEF007777
      770054545400545454005E5E5E00787878008484840089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      890089898900898989008989890084848400787878005E5E5E00545454005454
      540077777700EFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CFD4E800CED2EB00D1D4E700D1D5EB00D2D6E8000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094928A00E2D6D000E0D4CD00DDD2
      CB00DACFC900D7CDC600D4CBC400D1C9C200CFC7C000CCC5BD00C9C3BB00C7C1
      B900C5BFB700C2BEB600C0BDB500BEBBB300BDBBB200BCBAB100BAB9B000B9B9
      AF00B8B8AE00B7B8AE00B8B7AF00B7B8AE00B7B8AE00B7B8AE00B8BAAF00B9BB
      B000BABCB200BCBDB300BDBEB40088888000000000000000000000000000F9F9
      F900ABABAB005E5E5E0054545400545454005454540054545400545454005454
      5400545454005454540054545400545454005454540054545400545454005454
      54005454540054545400545454005454540054545400545454005E5E5E00ABAB
      AB00F9F9F900000000000000000000000000000000000000000000000000FAFA
      FA00ABABAB005F5F5F0054545400545454005454540054545400545454005454
      5400545454005454540054545400545454005454540054545400545454005454
      54005454540054545400545454005454540054545400545454005F5F5F00ABAB
      AB00FAFAFA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094928A00E4D7D100E1D5CE00DED2
      CC00DBD0CA00D8CEC800D5CCC500D3CAC300D0C7C100CDC6BF00CAC4BD00C8C2
      BB00C5C0B900C3BEB700C1BDB500BFBCB400BDBBB300BCBAB100BAB9B000BAB9
      B000B8B8AF00B8B7AF00B7B8AE00B7B8AF00B7B8AF00B7B9AF00B7B9AF00B9BA
      B000BABBB100BBBDB200BCBEB300888880000000000000000000000000000000
      000000000000FAFAFA00CFCFCF00B6B6B600AAAAAA00AAAAAA00AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00B6B6B600CFCFCF00FAFAFA000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FBFBFB00D1D1D100B6B6B600ABABAB00A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900ABABAB00B6B6B600D1D1D100FBFBFB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CDC3BE00EFE2DD00EEE1DC00EEE1
      DC00EDE1DC00ECE0DC00EBE0DC00EAE0DC00E9DFDC00E8DFDC00E7DFDC00E6DE
      DB00E5DEDB00E4DEDB00E3DDDB00E2DDDB00E1DDDB00E0DCDB00DFDCDB00DFDC
      DB00DEDBDA00DDDBDA00DCDBDA00DCDBDA00DBDADA00DBDADA00DADADA00DADA
      DA00DADADA00DADADA00DADADA00BEBEBB00424D3E000000000000003E000000
      2800000080000000600000000100010000000000000600000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
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
      00000000000000000000000000000000C000000080000000FFC003FFF800001F
      8000000080000000FF0000FFE00000078000000080000000FC00003FC0000003
      80000000C0000003F800001F800000018000000080000001F000000F80000001
      8000000080000001E0000007000000008000000080000001C000000300000000
      8000000080000001C00000030000000080001C00800000018000000100000000
      80001C008FFFFFF1800000010000000080000000900000090000000000000000
      800000009000000900000000000FF000800000009000000900000000000FF000
      800000009000000900000000001FF800800000008000000100000000001FF800
      800000008000000100000000001FF80083FFFF008000000100000000001FF800
      820000008000000100000000001FF800800000008000000100000000001FF800
      800000008000000100000000000FF00083FFFF00800000010000000000000000
      8200000080000001000000000000000083FFFF00800000018000000100000000
      8200000080000001800000010000000083FFFF00800000018000000300000000
      8000000080000001C0000003000000008000000080000001E000000700000000
      8000000080000001F000000F800000018000000080000001F800001F80000001
      E000000080000001FC00003FC0000003F000000180000001FE0000FFE0000007
      FFFFFFFFFFFFFFFFFFC003FFF800001FF800001FF800001FFFFFFFFF80000000
      E0000007E0000007FFFFFEFF00000000C0000003C0000003FFFFFEBF00000000
      8000000180000001FFFFF8FF000000008000000180000001FFFFF8FF00000000
      0000000000000000FFF000FF000000000000000000000000FF03C0FF00000000
      0000000000000000FE1FBAFF000000000000000000000000F80F3AFF00000000
      0000000000000000F80EFEFF000000000030000000002000F801FCFF00000000
      003C000000003800F803FDFF00000000001F000000100E00F807FDFF00000000
      001FC00000300600F807FBFF00000000001FF00000380300F807FB7F00000000
      001FF80000780300F803FB7F00000000001FF00000FC0300F803FF7F00000000
      001FC00000180300F803FFBF00000000001F000000180300F803FFBF00000000
      001C0000001C0600F803FFDF0000000000100000000E0E00F801F81F00000000
      000000000007FC00FC00001F00000000000000000001F000FC00001F00000000
      0000000000000000FF00001F000000000000000000000000FF00001F00000000
      0000000000000000FF80003F000000000000000000000000FFC0007F00000000
      8000000180000001FFE000FF000000008000000180000001FFF003FF00000000
      C0000003C0000003FFFC1FFF00000000E0000007E0000007FFFFFFFF00000000
      F800001FF800001FFFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
