object FormScannerTraining: TFormScannerTraining
  Left = 291
  Top = 271
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Scanner Training'
  ClientHeight = 273
  ClientWidth = 312
  Color = 14474715
  Constraints.MaxHeight = 313
  Constraints.MaxWidth = 328
  Constraints.MinHeight = 300
  Constraints.MinWidth = 320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
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
    Width = 312
    Height = 60
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BevelWidth = 2
    Color = 14474715
    TabOrder = 0
    object Label3: TLabel
      Left = 33
      Top = 111
      Width = 3
      Height = 11
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ToolBar: TToolBar
      Left = 4
      Top = 4
      Width = 304
      Height = 52
      Align = alClient
      ButtonHeight = 44
      ButtonWidth = 94
      Caption = 'ToolBar'
      DrawingStyle = dsGradient
      GradientEndColor = clSilver
      GradientStartColor = 14803425
      Images = Main.ImageList24
      ShowCaptions = True
      TabOrder = 0
      Transparent = True
      object StartBtn: TToolButton
        Left = 0
        Top = 0
        Caption = '           &Start          '
        ImageIndex = 8
        Style = tbsCheck
        OnClick = StartBtnClick
      end
      object StopBtn: TToolButton
        Left = 94
        Top = 0
        Caption = 'S&top'
        Down = True
        ImageIndex = 9
        Style = tbsCheck
        OnClick = StopBtnClick
      end
      object HelpBtn: TToolButton
        Left = 188
        Top = 0
        Caption = '&Help'
        ImageIndex = 17
        OnClick = BitBtn1Click
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 60
    Width = 312
    Height = 213
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BevelWidth = 2
    Color = 14474715
    TabOrder = 1
    object Panel3: TPanel
      Left = 4
      Top = 183
      Width = 304
      Height = 26
      Align = alBottom
      Color = 14474715
      TabOrder = 0
      object ProgressBar: TProgressBar
        Left = 1
        Top = 1
        Width = 302
        Height = 24
        Align = alClient
        TabOrder = 0
      end
    end
    object GroupBox: TGroupBox
      Left = 4
      Top = 4
      Width = 304
      Height = 179
      Align = alClient
      Caption = 'Parameters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        Left = 11
        Top = 24
        Width = 138
        Height = 14
        Caption = 'Scanning rate, nm/sec'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 12
        Top = 56
        Width = 88
        Height = 14
        Caption = 'Cycles Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LabelT: TLabel
        Left = 12
        Top = 85
        Width = 115
        Height = 14
        Caption = 'Time Training , min'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object EdCycleNmb: TLabel
        Left = 144
        Top = 56
        Width = 3
        Height = 13
      end
      object EdScanRate: TLabel
        Left = 222
        Top = 23
        Width = 3
        Height = 13
      end
      object lbltime: TEdit
        Left = 208
        Top = 77
        Width = 53
        Height = 21
        TabOrder = 0
        OnChange = lbltimeChange
        OnKeyPress = lbltimeKeyPress
      end
      object ApplyBitBtn: TBitBtn
        Left = 200
        Top = 121
        Width = 89
        Height = 24
        Caption = '&Apply'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = ApplyBitBtnClick
      end
      object CbTrainingRate: TComboBox
        Left = 213
        Top = 20
        Width = 69
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        Text = 'Middle'
        OnSelect = CbTrainingRateSelect
        Items.Strings = (
          'Fast'
          'Middle'
          'Slow')
      end
    end
  end
  object TimerUpT: TTimer
    OnTimer = TimerUpTTimer
    Left = 280
    Top = 192
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
    Left = 112
    Top = 184
    TranslationData = {
      737443617074696F6E730D0A54466F726D5363616E6E6572547261696E696E67
      015363616E6E657220547261696E696E6701D2F0E5EDE8F0EEE2EAE020F1EAE0
      EDE5F0E0010D0A50616E656C310101010D0A4C6162656C330101010D0A50616E
      656C320101010D0A50616E656C330101010D0A47726F7570426F780150617261
      6D657465727301CFE0F0E0ECE5F2F0FB010D0A4C6162656C31015363616E6E69
      6E6720726174652C206E6D2F73656301D1EAEEF0EEF1F2FC20F1EAE0EDE8F0EE
      E2E0EDE8FF2C20EDEC2FF1010D0A4C6162656C32014379636C6573204E756D62
      657201CAEEEBE8F7E5F1F2E2EE20F6E8EAEBEEE2010D0A4C6162656C54015469
      6D6520547261696E696E67202C206D696E01C2F0E5ECFF20F2F0E5EDE8F0EEE2
      EAE82C20ECE8ED010D0A45644379636C654E6D620101010D0A45645363616E52
      6174650101010D0A4170706C7942697442746E01264170706C7901CF26F0E8EC
      E5EDE8F2FC010D0A546F6F6C42617201546F6F6C42617201010D0A5374617274
      42746E0120202020202020202020202653746172742020202020202020202001
      202020202020202020202026D1F2E0F0F220202020202020202020010D0A4865
      6C7042746E012648656C700126D1EFF0E0E2EAE0010D0A53746F7042746E0153
      26746F7001D126F2EEEF010D0A737448696E74730D0A54466F726D5363616E6E
      6572547261696E696E670101010D0A50616E656C310101010D0A4C6162656C33
      0101010D0A50616E656C320101010D0A50616E656C330101010D0A50726F6772
      6573734261720101010D0A47726F7570426F780101010D0A4C6162656C310101
      010D0A4C6162656C320101010D0A4C6162656C540101010D0A45644379636C65
      4E6D620101010D0A45645363616E526174650101010D0A6C626C74696D650101
      010D0A4170706C7942697442746E0101010D0A4362547261696E696E67526174
      650101010D0A546F6F6C4261720101010D0A537461727442746E0101010D0A48
      656C7042746E0101010D0A53746F7042746E0101010D0A7374446973706C6179
      4C6162656C730D0A7374466F6E74730D0A54466F726D5363616E6E6572547261
      696E696E670144656661756C740144656661756C74010D0A4C6162656C330144
      656661756C740144656661756C74010D0A47726F7570426F780144656661756C
      740144656661756C74010D0A4C6162656C310144656661756C74014465666175
      6C74010D0A4C6162656C320144656661756C740144656661756C74010D0A4C61
      62656C540144656661756C740144656661756C74010D0A4170706C7942697442
      746E0144656661756C740144656661756C74010D0A73744D756C74694C696E65
      730D0A4362547261696E696E67526174652E4974656D7301466173742C4D6964
      646C652C536C6F7701C1FBF1F2F0EE2CD1F0E5E4EDE52CCCE5E4EBE5EDEDEE01
      0D0A7374537472696E67730D0A737472737472743001596F7520686176652063
      68616E67656420506172616D65746572732E205072657373204170706C792062
      7574746F6E2C206265666F726520737461727420547261696E6E696E6701CFE0
      F0E0ECE5F2F0FB20E8E7ECE5EDE5EDFB2E20CDE0E6ECE8F2E520EAEDEEEFEAF3
      2022CFD0C8CCC5CDC8D2DC222C20EFF0E5E6E4E520F7E5EC20EDE0F7E0F2FC20
      F2F0E5EDE8F0EEE2EAF3010D0A73747273747274310153746F7020747261696E
      696E672101CEF1F2E0EDEEE2E8F2E520F2F0E5EDE8F0EEE2EAF321010D0A4944
      535F30012652554E0126D1F2E0F0F2010D0A4944535F32012653544F5001D126
      F2EEEF010D0A73744F74686572537472696E67730D0A54466F726D5363616E6E
      6572547261696E696E672E48656C7046696C650101010D0A6C626C74696D652E
      546578740101010D0A4362547261696E696E67526174652E54657874014D6964
      646C6501010D0A7374436F6C6C656374696F6E730D0A73744368617253657473
      0D0A54466F726D5363616E6E6572547261696E696E670144454641554C545F43
      484152534554015255535349414E5F43484152534554010D0A4C6162656C3301
      44454641554C545F43484152534554015255535349414E5F4348415253455401
      0D0A47726F7570426F780144454641554C545F43484152534554015255535349
      414E5F43484152534554010D0A4C6162656C310144454641554C545F43484152
      534554015255535349414E5F43484152534554010D0A4C6162656C3201444546
      41554C545F43484152534554015255535349414E5F43484152534554010D0A4C
      6162656C540144454641554C545F43484152534554015255535349414E5F4348
      4152534554010D0A4170706C7942697442746E0144454641554C545F43484152
      534554015255535349414E5F43484152534554010D0A}
  end
end
