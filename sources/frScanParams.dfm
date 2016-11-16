object ScanFieldParams: TScanFieldParams
  Left = 0
  Top = 0
  Width = 551
  Height = 251
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Panel3: TPanel
    Left = 263
    Top = 1
    Width = 288
    Height = 247
    TabOrder = 0
    object PageCtrlScan: TPageControl
      Left = 1
      Top = 1
      Width = 286
      Height = 245
      ActivePage = TabSheet1
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabHeight = 1
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'TabSheet1'
        object PanelScanImage: TPanel
          Left = 0
          Top = 20
          Width = 278
          Height = 214
          Align = alClient
          Color = clWhite
          TabOrder = 0
          object ImageScanArea: TImage
            Left = 1
            Top = 1
            Width = 276
            Height = 212
            Align = alClient
            OnMouseDown = ImageScanAreaMouseDown
            OnMouseMove = ImageScanAreaMouseMove
            OnMouseUp = ImageScanAreaMouseUp
          end
        end
        object PanelM: TPanel
          Left = 0
          Top = 0
          Width = 278
          Height = 20
          Align = alTop
          TabOrder = 1
          object BitBtnMg: TBitBtn
            Left = 247
            Top = 3
            Width = 22
            Height = 15
            Caption = '+'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = BitBtnMClick
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'TabSheet2'
        ImageIndex = 1
        object CurScanPanel: TPanel
          Left = 0
          Top = 0
          Width = 278
          Height = 234
          Align = alClient
          TabOrder = 0
          object ImCurrentScan: TImage
            Left = 48
            Top = 1
            Width = 229
            Height = 232
            Align = alRight
          end
          object LabelZmax: TLabel
            Left = 8
            Top = 8
            Width = 33
            Height = 16
            Caption = 'Zmax'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object LabelZmin: TLabel
            Left = 8
            Top = 160
            Width = 29
            Height = 16
            Caption = 'Zmin'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
        end
      end
    end
  end
  object PanelScanParam: TPanel
    Left = 9
    Top = 7
    Width = 250
    Height = 163
    BevelInner = bvLowered
    Caption = 'PanelScanParam'
    Color = clBackground
    TabOrder = 1
    object Panel2: TPanel
      Left = 7
      Top = 6
      Width = 236
      Height = 121
      BevelInner = bvLowered
      Color = clGray
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 7
        Top = 8
        Width = 50
        Height = 19
        Caption = 'X (nm)'
      end
      object Label2: TLabel
        Left = 8
        Top = 29
        Width = 50
        Height = 19
        Caption = 'Y (nm)'
      end
      object Label3: TLabel
        Left = 132
        Top = 12
        Width = 22
        Height = 19
        Caption = 'NX'
      end
      object Label4: TLabel
        Left = 131
        Top = 37
        Width = 22
        Height = 19
        Caption = 'NY'
      end
      object Label5: TLabel
        Left = 44
        Top = 64
        Width = 81
        Height = 19
        Caption = 'Scan Rate '
      end
      object Label8: TLabel
        Left = 16
        Top = 95
        Width = 109
        Height = 20
        Caption = 'Time Frame ='
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object FrameTime: TLabel
        Left = 131
        Top = 94
        Width = 25
        Height = 19
        Caption = 'test'
      end
      object edX: TEdit
        Left = 61
        Top = 8
        Width = 62
        Height = 27
        TabOrder = 0
        Text = 'edX'
        OnChange = edXChange
      end
      object edY: TEdit
        Left = 62
        Top = 33
        Width = 62
        Height = 27
        TabOrder = 1
        Text = 'edY'
        OnChange = edYChange
      end
      object edNX: TEdit
        Left = 162
        Top = 8
        Width = 62
        Height = 27
        TabOrder = 2
        Text = 'edNX'
        OnChange = edNXChange
      end
      object edNY: TEdit
        Left = 162
        Top = 33
        Width = 62
        Height = 27
        ReadOnly = True
        TabOrder = 3
        Text = 'edNY'
      end
      object edScanRate: TEdit
        Left = 160
        Top = 66
        Width = 63
        Height = 27
        TabOrder = 4
        OnChange = edScanRateChange
      end
    end
    object ClearlBtn: TButton
      Left = 148
      Top = 133
      Width = 69
      Height = 21
      Caption = 'Clear'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ClearlBtnClick
    end
    object ApplyBitBtn: TBitBtn
      Left = 26
      Top = 133
      Width = 69
      Height = 21
      Caption = 'Apply'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = ApplyBtnClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 36
    Top = 171
    Width = 201
    Height = 73
    Caption = 'Previous Scan'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label6: TLabel
      Left = 8
      Top = 24
      Width = 100
      Height = 19
      Caption = 'Scan Number'
    end
    object Label7: TLabel
      Left = 8
      Top = 48
      Width = 92
      Height = 19
      Caption = 'Z Diapazone'
    end
    object edScanNmb: TEdit
      Left = 128
      Top = 25
      Width = 65
      Height = 22
      BorderStyle = bsNone
      Color = clActiveBorder
      TabOrder = 0
      Text = 'edScanNmb'
    end
    object edDZ: TEdit
      Left = 128
      Top = 49
      Width = 65
      Height = 22
      BorderStyle = bsNone
      Color = clActiveBorder
      TabOrder = 1
      Text = 'edDZ'
    end
  end
end
