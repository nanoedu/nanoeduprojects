object ScanWnd: TScanWnd
  Left = -125
  Top = 222
  Width = 812
  Height = 612
  Align = alClient
  Caption = 'ScanWnd'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel2: TPanel
    Left = 0
    Top = 231
    Width = 804
    Height = 354
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 0
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 384
      Height = 352
      Align = alLeft
      Caption = 'Panel3'
      TabOrder = 0
      object Image1: TImage
        Left = 1
        Top = 1
        Width = 382
        Height = 350
        Align = alClient
      end
    end
    object Panel4: TPanel
      Left = 385
      Top = 1
      Width = 418
      Height = 352
      Align = alClient
      Caption = 'Panel4'
      TabOrder = 1
      object Image2: TImage
        Left = 1
        Top = 1
        Width = 401
        Height = 362
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 804
    Height = 231
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
    inline Signals1: TSignals
      Left = 173
      Top = -2
      Width = 242
      Height = 240
      Font.Height = -13
      inherited Bevel1: TBevel
        Left = 6
        Top = 6
        Width = 219
        Height = 161
      end
      inherited Label6: TLabel
        Left = 19
        Top = 179
        Width = 128
        Height = 16
      end
      inherited Bevel4: TBevel
        Left = 6
        Top = 173
        Width = 219
        Height = 52
      end
      inherited Label3: TLabel
        Left = 13
        Top = 192
        Width = 21
        Height = 16
      end
      inherited Label5: TLabel
        Left = 173
        Top = 192
        Width = 25
        Height = 16
      end
      inherited ApplySignals: TButton
        Left = 19
        Top = 128
        Width = 78
        Height = 26
      end
      inherited FrequencyTrack: TTrackBar
        Left = 38
        Top = 192
        Width = 136
        Height = 26
      end
      inherited Cancel: TButton
        Left = 128
        Top = 128
        Width = 71
        Height = 26
      end
      inherited BiasVPanel: TPanel
        Left = 13
        Top = 70
        Width = 205
        Height = 52
        inherited Label4: TLabel
          Left = 6
          Top = 6
          Width = 77
          Height = 16
        end
        inherited VtBtn: TButton
          Left = 6
          Top = 26
          Width = 104
          Height = 20
        end
        inherited edBiasV: TEdit
          Left = 115
          Top = 26
          Width = 84
          Height = 24
        end
      end
      inherited Panel1: TPanel
        Left = 13
        Top = 13
        Width = 205
        Height = 52
        inherited Label1: TLabel
          Left = 6
          Top = 6
          Width = 56
          Height = 16
        end
        inherited Label2: TLabel
          Left = 70
          Top = 6
          Width = 125
          Height = 16
        end
        inherited SetPointBtn: TButton
          Left = 6
          Top = 26
          Width = 104
          Height = 20
        end
        inherited edSetPoint: TEdit
          Left = 115
          Top = 26
          Width = 84
          Height = 24
        end
      end
    end
    inline ScanParams1: TScanFieldParams
      Left = 390
      Top = 2
      Width = 400
      Height = 232
      Font.Height = -13
      TabOrder = 1
      inherited Panel3: TPanel
        Left = 166
        Top = 13
        Width = 231
        Height = 212
        inherited PageControl1: TPageControl
          Width = 229
          Height = 210
          ActivePage = ScanParams1.TabSheet1
          inherited TabSheet1: TTabSheet
            inherited Image1: TImage
              Width = 221
              Height = 199
            end
          end
          inherited TabSheet2: TTabSheet
            inherited imCurrentScan: TImage
              Width = 225
              Height = 215
            end
          end
        end
      end
      inherited Panel1: TPanel
        Top = 6
        Width = 167
        Height = 148
        inherited Panel2: TPanel
          Left = 7
          Width = 154
          Height = 116
          inherited Label1: TLabel
            Left = 6
            Top = 6
            Width = 37
            Height = 16
          end
          inherited Label2: TLabel
            Left = 6
            Top = 32
            Width = 38
            Height = 16
          end
          inherited Label3: TLabel
            Left = 13
            Top = 51
            Width = 18
            Height = 16
          end
          inherited Label4: TLabel
            Left = 13
            Top = 70
            Width = 19
            Height = 16
          end
          inherited Label5: TLabel
            Left = 6
            Top = 90
            Width = 81
            Height = 16
          end
          inherited edX: TEdit
            Left = 51
            Top = 6
            Width = 52
            Height = 24
          end
          inherited edY: TEdit
            Left = 51
            Top = 26
            Width = 52
            Height = 24
          end
          inherited edNX: TEdit
            Left = 51
            Top = 45
            Width = 52
            Height = 24
          end
          inherited edNY: TEdit
            Left = 51
            Top = 64
            Width = 52
            Height = 24
          end
          inherited edCadrTime: TEdit
            Left = 96
            Top = 90
            Width = 52
            Height = 24
          end
        end
        inherited ApplyBtn: TButton
          Left = 6
          Top = 122
          Width = 72
          Height = 20
        end
        inherited CancelBtn: TButton
          Left = 83
          Top = 122
          Width = 60
          Height = 20
        end
      end
      inherited GroupBox1: TGroupBox
        Top = 160
        Width = 161
        Height = 71
        inherited Label6: TLabel
          Left = 6
          Top = 19
          Width = 82
          Height = 16
        end
        inherited Label7: TLabel
          Left = 6
          Top = 38
          Width = 77
          Height = 16
        end
        inherited edScanNmb: TEdit
          Left = 102
          Top = 13
          Width = 52
          Height = 22
        end
        inherited edDZ: TEdit
          Left = 102
          Top = 32
          Width = 52
          Height = 22
        end
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 0
      Width = 166
      Height = 225
      TabOrder = 2
      object Panel6: TPanel
        Left = 6
        Top = 6
        Width = 155
        Height = 84
        BevelInner = bvLowered
        TabOrder = 0
        object StartBtn: TButton
          Left = 6
          Top = 6
          Width = 72
          Height = 27
          Caption = 'START'
          TabOrder = 0
          OnClick = StartBtnClick
        end
        object Button2: TButton
          Left = 6
          Top = 45
          Width = 129
          Height = 26
          Caption = 'Save Experiment'
          TabOrder = 1
        end
        object OptionsBtn: TButton
          Left = 83
          Top = 6
          Width = 60
          Height = 27
          Caption = 'Options'
          TabOrder = 2
          OnClick = OptionsBtnClick
        end
      end
      object Panel7: TPanel
        Left = 6
        Top = 96
        Width = 155
        Height = 122
        BevelInner = bvLowered
        TabOrder = 1
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 81
    Top = 176
  end
end
