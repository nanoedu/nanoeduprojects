object frViewOption: TfrViewOption
  Left = 396
  Top = 249
  Width = 574
  Height = 451
  Caption = 'frViewOption'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 566
    Height = 344
    ActivePage = TabSheetL
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    TabWidth = 100
    object TabSheetG: TTabSheet
      Caption = 'General'
      ImageIndex = 2
      object Label1: TLabel
        Left = 96
        Top = 32
        Width = 39
        Height = 13
        Caption = 'Label1'
      end
      object TrackBar2: TTrackBar
        Left = 64
        Top = 88
        Width = 150
        Height = 45
        TabOrder = 0
      end
    end
    object TabSheetL: TTabSheet
      Caption = 'Light'
      ImageIndex = 2
      object Panel1: TPanel
        Left = 456
        Top = 0
        Width = 102
        Height = 316
        Align = alRight
        Caption = 'Panel1'
        TabOrder = 0
      end
      object PanelL: TPanel
        Left = -32
        Top = 0
        Width = 201
        Height = 316
        TabOrder = 1
        object Label2: TLabel
          Left = 72
          Top = 40
          Width = 57
          Height = 16
          Caption = 'Position'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -14
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 96
          Top = 72
          Width = 9
          Height = 13
          Caption = 'X'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 98
          Top = 144
          Width = 9
          Height = 13
          Caption = 'Y'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 97
          Top = 224
          Width = 9
          Height = 13
          Caption = 'Z'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 88
          Top = 16
          Width = 40
          Height = 13
          Caption = 'Light 1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object TrackBarX1: TTrackBar
          Left = 32
          Top = 96
          Width = 150
          Height = 45
          Max = 100
          Min = -100
          Frequency = 2
          TabOrder = 0
          ThumbLength = 10
          OnChange = TrackBarX1Change
        end
        object TrackBarZ1: TTrackBar
          Left = 32
          Top = 248
          Width = 150
          Height = 45
          Max = 100
          Min = -100
          Frequency = 2
          TabOrder = 1
          ThumbLength = 10
          OnChange = TrackBarZ1Change
        end
        object TrackBarY1: TTrackBar
          Left = 32
          Top = 168
          Width = 150
          Height = 45
          Max = 100
          Min = -100
          Frequency = 2
          TabOrder = 2
          ThumbLength = 10
          OnChange = TrackBarY1Change
        end
      end
      object PanelC: TPanel
        Left = 168
        Top = 0
        Width = 177
        Height = 313
        TabOrder = 2
        object Label6: TLabel
          Left = 64
          Top = 40
          Width = 57
          Height = 16
          Caption = 'Position'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -14
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 96
          Top = 72
          Width = 9
          Height = 13
          Caption = 'X'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 98
          Top = 144
          Width = 9
          Height = 13
          Caption = 'Y'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 97
          Top = 224
          Width = 9
          Height = 13
          Caption = 'Z'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 72
          Top = 16
          Width = 40
          Height = 13
          Caption = 'Light 2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object TrackBarX2: TTrackBar
          Left = 11
          Top = 96
          Width = 150
          Height = 45
          Max = 100
          Min = -100
          Frequency = 2
          TabOrder = 0
          ThumbLength = 10
          OnChange = TrackBarX2Change
        end
        object TrackBarY2: TTrackBar
          Left = 11
          Top = 168
          Width = 150
          Height = 45
          Max = 100
          Min = -100
          Frequency = 2
          TabOrder = 1
          ThumbLength = 10
          OnChange = TrackBarY2Change
        end
        object TrackBarZ2: TTrackBar
          Left = 11
          Top = 248
          Width = 150
          Height = 45
          Max = 100
          Min = -100
          Frequency = 2
          TabOrder = 2
          ThumbLength = 10
          OnChange = TrackBarZ2Change
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Material'
      ImageIndex = 3
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 558
        Height = 313
        ActivePage = TabSheet1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MultiLine = True
        ParentFont = False
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = 'Shiness'
          object TrackBar1: TTrackBar
            Left = 56
            Top = 88
            Width = 265
            Height = 25
            TabOrder = 0
            ThumbLength = 10
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'Color'
          ImageIndex = 1
        end
        object TabSheet5: TTabSheet
          Caption = 'Emission'
          ImageIndex = 2
        end
        object TabSheet6: TTabSheet
          Caption = 'Speculiar'
          ImageIndex = 3
        end
        object TabSheetM: TTabSheet
          Caption = 'Diffusion'
          ImageIndex = 4
          object Panel3: TPanel
            Left = 0
            Top = 0
            Width = 550
            Height = 285
            Align = alClient
            Caption = 'Panel3'
            TabOrder = 0
          end
        end
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 344
    Width = 566
    Height = 80
    Align = alBottom
    TabOrder = 1
    object BitBtn3: TBitBtn
      Left = 416
      Top = 16
      Width = 75
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn3Click
      Kind = bkCancel
    end
    object BitBtn1: TBitBtn
      Left = 48
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Default'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 232
      Top = 16
      Width = 75
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn2Click
      Kind = bkOK
    end
  end
end
