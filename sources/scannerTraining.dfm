object FormScannerTraining: TFormScannerTraining
  Left = 651
  Top = 322
  Width = 370
  Height = 359
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'ScannerTraining'
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 362
    Height = 48
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BevelWidth = 2
    TabOrder = 0
    object Label3: TLabel
      Left = 33
      Top = 111
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object StartBtn: TBitBtn
      Left = 18
      Top = 12
      Width = 67
      Height = 25
      Caption = '&RUN'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = StartBtnClick
    end
    object BitBtn1: TBitBtn
      Left = 220
      Top = 11
      Width = 63
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn1Click
      Kind = bkHelp
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 48
    Width = 362
    Height = 284
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BevelWidth = 2
    TabOrder = 1
    object Label1: TLabel
      Left = 11
      Top = 14
      Width = 126
      Height = 13
      Caption = 'Scanning rate nm/sec'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 12
      Top = 49
      Width = 85
      Height = 13
      Caption = 'Cycles Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelT: TLabel
      Left = 12
      Top = 92
      Width = 109
      Height = 13
      Caption = 'Time Training (min)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ApplyBitBtn: TBitBtn
      Left = 144
      Top = 137
      Width = 61
      Height = 20
      Caption = '&Apply'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = ApplyBitBtnClick
    end
    object lbltime: TEdit
      Left = 144
      Top = 88
      Width = 53
      Height = 21
      TabOrder = 1
      OnChange = lbltimeChange
      OnKeyPress = lbltimeKeyPress
    end
    object EdCycleNmb: TEdit
      Left = 143
      Top = 48
      Width = 72
      Height = 21
      Enabled = False
      TabOrder = 2
      OnChange = EdCycleNmbChange
      OnKeyPress = EdCycleNmbKeyPress
    end
    object CbTrainingRate: TComboBox
      Left = 144
      Top = 13
      Width = 62
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      Text = 'Middle'
      OnSelect = CbTrainingRateSelect
      Items.Strings = (
        'Fast'
        'Middle'
        'Slow')
    end
    object EdScanRate: TEdit
      Left = 218
      Top = 13
      Width = 66
      Height = 21
      Enabled = False
      TabOrder = 4
      OnChange = EdScanRateChange
      OnKeyPress = EdScanRateKeyPress
    end
    object Panel3: TPanel
      Left = 4
      Top = 254
      Width = 354
      Height = 26
      Align = alBottom
      TabOrder = 5
      object ProgressBar: TProgressBar
        Left = 1
        Top = 1
        Width = 352
        Height = 24
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object TimerUpT: TTimer
    OnTimer = TimerUpTTimer
    Left = 280
    Top = 192
  end
end
