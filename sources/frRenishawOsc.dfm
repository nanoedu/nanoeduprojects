object FormRenishawOsc: TFormRenishawOsc
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Renishaw Oscilloscope'
  ClientHeight = 502
  ClientWidth = 797
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 797
    Height = 73
    Align = alTop
    Color = clSilver
    TabOrder = 0
    object ControlPanel: TPanel
      Left = 135
      Top = 1
      Width = 661
      Height = 71
      Align = alRight
      Color = clSilver
      ParentBackground = False
      TabOrder = 0
      ExplicitLeft = 136
      object Label1: TLabel
        Left = 231
        Top = 12
        Width = 47
        Height = 12
        Caption = 'Rate, nm/s'
      end
      object LabelOldSens: TLabel
        Left = 231
        Top = 35
        Width = 45
        Height = 12
        Caption = 'Sensitivity'
      end
      object LabelNewsens: TLabel
        Left = 231
        Top = 53
        Width = 90
        Height = 12
        Caption = 'Current Sensitivity='
      end
      object Labeldist: TLabel
        Left = 422
        Top = 35
        Width = 79
        Height = 12
        Caption = 'The passed way='
      end
      object RadioGroupAxis: TRadioGroup
        Left = 22
        Top = 6
        Width = 92
        Height = 43
        Caption = 'Axis'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'X    '
          'Y   ')
        TabOrder = 0
      end
      object RadioGroupDir: TRadioGroup
        Left = 120
        Top = 5
        Width = 102
        Height = 61
        Caption = 'Direction'
        ItemIndex = 0
        Items.Strings = (
          'Forward'
          'Back')
        TabOrder = 1
      end
      object EdScanRate: TEdit
        Left = 344
        Top = 7
        Width = 93
        Height = 24
        TabOrder = 2
        Text = 'EdScanRate'
        OnChange = EdScanRateChange
        OnKeyPress = EdScanRateKeyPress
      end
      object UpDown: TUpDown
        Left = 437
        Top = 5
        Width = 16
        Height = 24
        Position = 50
        TabOrder = 3
        OnClick = UpDownClick
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 134
      Height = 71
      Align = alClient
      Color = clSilver
      ParentBackground = False
      TabOrder = 1
      ExplicitWidth = 135
      object ToolBarScanWnd: TToolBar
        Left = 6
        Top = 10
        Width = 116
        Height = 44
        Align = alNone
        ButtonHeight = 47
        ButtonWidth = 59
        Caption = 'ToolBarScanWnd'
        Color = clSilver
        EdgeInner = esNone
        EdgeOuter = esNone
        Images = Main.ImageList24
        ParentColor = False
        ShowCaptions = True
        TabOrder = 0
        object StartBtn: TToolButton
          Left = 0
          Top = 0
          Caption = '   &Start   '
          Grouped = True
          ImageIndex = 8
          Style = tbsCheck
          OnClick = StartBtnClick
        end
        object StopBtn: TToolButton
          Left = 59
          Top = 0
          Caption = 'S&top'
          Down = True
          Grouped = True
          ImageIndex = 9
          Style = tbsCheck
          OnClick = StopBtnClick
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 73
    Width = 797
    Height = 429
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 796
      Height = 136
      Align = alTop
      Caption = 'Panel3'
      TabOrder = 0
      object ChartCurrentSignal: TChart
        Left = 1
        Top = 1
        Width = 794
        Height = 119
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Legend.Visible = False
        Title.Font.Color = clBlack
        Title.Text.Strings = (
          'Original Renishaw signal and detected fronts')
        BottomAxis.Title.Caption = 'discrets'
        View3D = False
        Align = alClient
        TabOrder = 0
        object SerCurrentRSSignal: TLineSeries
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
        object SerRSSignalHist: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          SeriesColor = clRed
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object SercurrentRSPulses: TBarSeries
          BarPen.Width = 3
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Gradient.Direction = gdTopBottom
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object SerRSPulsesHist: TBarSeries
          BarPen.Width = 3
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          SeriesColor = clGreen
          Gradient.Direction = gdTopBottom
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
      end
      object sbHistory: TScrollBar
        Left = 1
        Top = 120
        Width = 794
        Height = 16
        Align = alBottom
        PageSize = 0
        TabOrder = 1
        OnScroll = sbHistoryScroll
      end
    end
    object ChartSens: TChart
      Left = 1
      Top = 137
      Width = 359
      Height = 291
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      Title.Font.Color = clBlack
      Title.Text.Strings = (
        'Scanner Sensitivity as a function of Voltage')
      BottomAxis.Title.Caption = 'V'
      LeftAxis.Title.Caption = 'Sensitivity, nm/v'
      RightAxis.Title.Caption = #1
      View3D = False
      Align = alLeft
      TabOrder = 1
      object SerPulsesIntervalsnm: TLineSeries
        Marks.Callout.Brush.Color = clBlack
        Marks.Visible = False
        SeriesColor = clBlack
        LinePen.Width = 3
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object Chartnmv: TChart
      Left = 360
      Top = 137
      Width = 437
      Height = 291
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      Title.Font.Color = clBlack
      Title.Text.Strings = (
        '')
      BottomAxis.LabelsFont.Height = -16
      BottomAxis.LabelsFont.Style = [fsBold]
      BottomAxis.Title.Caption = 'Scanner Voltage,  V'
      LeftAxis.LabelsFont.Height = -16
      LeftAxis.LabelsFont.Style = [fsBold]
      LeftAxis.Title.Caption = 'Scanner Moving,  nm'
      View3D = False
      Align = alClient
      TabOrder = 2
      object SerScannerMoving: TLineSeries
        Marks.Callout.Brush.Color = clBlack
        Marks.Visible = False
        SeriesColor = clBlack
        LinePen.Width = 3
        Pointer.HorizSize = 2
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.VertSize = 2
        Pointer.Visible = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  object siLangLinked1: TsiLangLinked
    Version = '6.5'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 2
    LangDispatcher = Main.siLangDispatcher1
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
    Left = 696
    Top = 56
    TranslationData = {
      737443617074696F6E730D0A54466F726D52656E69736861774F73630152656E
      6973686177204F7363696C6C6F73636F706501D0E5EDE8F8EEF320EEF1F6E8EB
      EEE3F0E0F4010D0A50616E656C310101010D0A50616E656C320150616E656C32
      01010D0A50616E656C330150616E656C3301010D0A526164696F47726F757041
      786973014178697301CEF1E8010D0A526164696F47726F757044697201446972
      656374696F6E01CDE0EFF0E0E2EBE5EDE8E5010D0A4C6162656C310152617465
      2C206E6D2F7301D1EAEEF0EEF1F2FC2C20EDEC2F63010D0A4C6162656C4F6C64
      53656E730153656E736974697669747901D7F3E2F1F2E2E8F2E5EBFCEDEEF1F2
      FC010D0A4C6162656C4E657773656E730143757272656E742053656E73697469
      766974793D01D2E5EAF3F9E0FF20F7F3E2F1F2E2E8F2E5EBFCEDEEF1F2FC010D
      0A4C6162656C646973740154686520706173736564207761793D01CFF0EEE9E4
      E5EDEDFBE920EFF3F2FC3D010D0A50616E656C350101010D0A546F6F6C426172
      5363616E576E6401546F6F6C4261725363616E576E6401010D0A537461727442
      746E012020202653746172742020200120202026D1F2E0F0F2010D0A53746F70
      42746E015326746F7001D126F2EEEF010D0A436F6E74726F6C50616E656C0101
      010D0A737448696E74730D0A54466F726D52656E69736861774F73630101010D
      0A50616E656C310101010D0A50616E656C320101010D0A50616E656C33010101
      0D0A436861727443757272656E745369676E616C0101010D0A43686172745365
      6E730101010D0A43686172746E6D760101010D0A7362486973746F7279010101
      0D0A526164696F47726F7570417869730101010D0A526164696F47726F757044
      69720101010D0A4C6162656C310101010D0A4C6162656C4F6C6453656E730101
      010D0A4C6162656C4E657773656E730101010D0A45645363616E526174650101
      010D0A4C6162656C646973740101010D0A5570446F776E0101010D0A50616E65
      6C350101010D0A546F6F6C4261725363616E576E640101010D0A537461727442
      746E0101010D0A53746F7042746E0101010D0A436F6E74726F6C50616E656C01
      01010D0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A5446
      6F726D52656E69736861774F7363015461686F6D61014D532053616E73205365
      726966010D0A73744D756C74694C696E65730D0A526164696F47726F75704178
      69732E4974656D7301225820202020222C22592020202201010D0A526164696F
      47726F75704469722E4974656D7301466F72776172642C4261636B01C2EFE5F0
      E5E42CCDE0E7E0E4010D0A7374537472696E67730D0A4944535F300153656E73
      6976697479202058203D2001D7F3E2F1F2E2E8F2E5EBFCEDEEF1F2FC20D53D01
      0D0A4944535F3101206E6D2F560120EDEC2FC2010D0A4944535F313001437572
      72656E742053656E736976697479205A203D2001D2E5EAF3F9E0FF20F7F3E2F1
      F2E2E8F2E5EBFCEDEEF1F2FC205A3D010D0A4944535F3131014E6F2052532050
      756C7365732101CDE5F220E8ECEFF3EBFCF1EEE220D0E5EDE8F8EEF321010D0A
      4944535F320153656E7369766974792059203D2001D7F3E2F1F2E2E8F2E5EBFC
      EDEEF1F2FC20593D010D0A4944535F340153656E736976697479205A203D2001
      D7F3E2F1F2E2E8F2E5EBFCEDEEF1F2FC205A3D010D0A4944535F360144414320
      6163686965766564204D61782056616C756501D6C0CF20E4EEF1F2E8E320ECE0
      EAF1E8ECF3ECE0010D0A4944535F37014E6F2052532050756C7365732101CDE5
      F220E8ECEFF3EBFCF1EEE220D0E5EDE8F8EEF321010D0A4944535F3801437572
      72656E742053656E7369766974792058203D2001D2E5EAF3F9E0FF20F7F3E2F1
      F2E2E8F2E5EBFCEDEEF1F2FC20D53D010D0A4944535F390143757272656E7420
      53656E7369766974792059203D2001D2E5EAF3F9E0FF20F7F3E2F1F2E2E8F2E5
      EBFCEDEEF1F2FC20593D010D0A4944535F3132015363616E6E65722053656E73
      6974697669747920617320612066756E6374696F6E206F6620566F6C74616765
      01D7F3E2F1F2E2E8F2E5EBFCEDEEF1F2FC20F1EAE0EDE5F0E020EAE0EA20F4F3
      EDEAF6E8FF20EDE0EFF0FFE6E5EDE8FF010D0A4944535F31330153656E736974
      69766974792C206E6D2F7601D7F3E2F1F2E2E8F2E5EBFCEDEEF1F2FC2C20EDEC
      2FC2010D0A4944535F3134015363616E6E6572206D6F76696E6701D1ECE5F9E5
      EDE8E520F1EAE0EDE5F0E0010D0A4944535F3135015363616E6E657220566F6C
      746167652C205601CDE0EFF0FFE6E5EDE8E520EDE020F1EAE0EDE5F0E52C20C2
      010D0A4944535F3136015363616E6E657220646973706C6163656D656E742C20
      6E6D01D1ECE5F9E5EDE8E520F1EAE0EDE5F0E02C20EDEC010D0A4944535F3301
      4F726967696E616C2052656E6973686177207369676E616C20616E6420646574
      65637465642066726F6E747301D0E5EDE8F8EEF320F1E8E3EDE0EB2020E820E4
      E5F2E5EAF2E8F0F3E5ECFBE520F4F0EEEDF2FB010D0A4944535F350144697363
      726574657301C4E8F1EAF0E5F2FB010D0A4944535F3137015363616E6E657220
      566F6C746167652C20205601CDE0EFF0FFE6E5EDE8E520EDE020F1EAE0EDE5F0
      E52C20C2010D0A4944535F3231014572726F7220696E70757401CEF8E8E1EAE0
      20E2E2EEE4E0010D0A4944535F32300153746F70207363616E6E696E672101CE
      F1F2E0EDEEE2E8F2E520F1EAE0EDE8F0EEE2E0EDE8E521010D0A4944535F3233
      0154686520706173736564207761793D2001CFF0EEE9E4E5EDEDFBE920EFF3F2
      FC203D010D0A4944535F323401206E6D0120EDEC010D0A4944535F3235014441
      43206163686965766564204C696D697401C4EEF1F2E8E3EDF3F2EE20EFF0E5E4
      E5EBFCEDEEE520E7EDE0F7E5EDE8E520D6C0CF010D0A73744F74686572537472
      696E67730D0A54466F726D52656E69736861774F73632E48656C7046696C6501
      01010D0A53657243757272656E7452535369676E616C2E436F6C6F72536F7572
      63650101010D0A53657243757272656E7452535369676E616C2E50657263656E
      74466F726D6174012323302E2323202501010D0A53657243757272656E745253
      5369676E616C2E5469746C650101010D0A53657243757272656E745253536967
      6E616C2E56616C7565466F726D617401232C2323302E23232301010D0A536572
      43757272656E7452535369676E616C2E584C6162656C73536F75726365010101
      0D0A53657252535369676E616C486973742E436F6C6F72536F75726365010101
      0D0A53657252535369676E616C486973742E50657263656E74466F726D617401
      2323302E2323202501010D0A53657252535369676E616C486973742E5469746C
      650101010D0A53657252535369676E616C486973742E56616C7565466F726D61
      7401232C2323302E23232301010D0A53657252535369676E616C486973742E58
      4C6162656C73536F757263650101010D0A53657263757272656E74525350756C
      7365732E436F6C6F72536F757263650101010D0A53657263757272656E745253
      50756C7365732E50657263656E74466F726D6174012323302E2323202501010D
      0A53657263757272656E74525350756C7365732E5469746C650101010D0A5365
      7263757272656E74525350756C7365732E56616C7565466F726D617401232C23
      23302E23232301010D0A53657263757272656E74525350756C7365732E584C61
      62656C73536F757263650101010D0A536572525350756C736573486973742E43
      6F6C6F72536F757263650101010D0A536572525350756C736573486973742E50
      657263656E74466F726D6174012323302E2323202501010D0A53657252535075
      6C736573486973742E5469746C650101010D0A536572525350756C7365734869
      73742E56616C7565466F726D617401232C2323302E23232301010D0A53657252
      5350756C736573486973742E584C6162656C73536F757263650101010D0A5365
      7250756C736573496E74657276616C736E6D2E436F6C6F72536F757263650101
      010D0A53657250756C736573496E74657276616C736E6D2E50657263656E7446
      6F726D6174012323302E2323202501010D0A53657250756C736573496E746572
      76616C736E6D2E5469746C650101010D0A53657250756C736573496E74657276
      616C736E6D2E56616C7565466F726D617401232C2323302E23232301010D0A53
      657250756C736573496E74657276616C736E6D2E584C6162656C73536F757263
      650101010D0A5365725363616E6E65724D6F76696E672E436F6C6F72536F7572
      63650101010D0A5365725363616E6E65724D6F76696E672E50657263656E7446
      6F726D6174012323302E2323202501010D0A5365725363616E6E65724D6F7669
      6E672E5469746C650101010D0A5365725363616E6E65724D6F76696E672E5661
      6C7565466F726D617401232C2323302E23232301010D0A5365725363616E6E65
      724D6F76696E672E584C6162656C73536F757263650101010D0A45645363616E
      526174652E546578740145645363616E5261746501010D0A7374436F6C6C6563
      74696F6E730D0A737443686172536574730D0A54466F726D52656E6973686177
      4F73630144454641554C545F43484152534554015255535349414E5F43484152
      534554010D0A}
  end
end
