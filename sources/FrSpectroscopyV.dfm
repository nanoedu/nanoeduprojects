object SpectroScopyV: TSpectroScopyV
  Left = 88
  Top = 140
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'SpectroScopy  I-V '
  ClientHeight = 480
  ClientWidth = 980
  Color = clGray
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Default'
  Font.Style = [fsBold]
  FormStyle = fsMDIChild
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 16
  object StatusBar: TStatusBar
    Left = 0
    Top = 461
    Width = 980
    Height = 19
    Panels = <
      item
        Text = 
          'Click Right Button- Popup Menu;Labels ( Click  Left Button - Add' +
          ' ; Del -Delete;Up,Down-Next,Previous); '
        Width = 640
      end
      item
        Text = 'Curves ( CtrlA -Average; CtrlDel-Delete; PgUp,PgDown-Next;Prev.)'
        Width = 50
      end>
    SimpleText = 
      'Click Left Button - PopUp Menu; Curves( Ctrl A -Average; Ctrl De' +
      'l- Delete ; Pg Up,Pg Down- Next;Previous)'
    ExplicitTop = 451
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 980
    Height = 461
    Align = alClient
    ParentBackground = False
    TabOrder = 1
    ExplicitHeight = 451
    object Panel3: TPanel
      Left = 212
      Top = 1
      Width = 767
      Height = 459
      Align = alClient
      Caption = 'Panel3'
      Color = 14474715
      TabOrder = 0
      ExplicitHeight = 449
      object PanelMain: TPanel
        Left = 1
        Top = 1
        Width = 765
        Height = 394
        Align = alTop
        TabOrder = 0
        object PageControl: TPageControl
          Left = 1
          Top = 1
          Width = 763
          Height = 392
          Align = alClient
          TabOrder = 0
          OnChange = PageControlChange
        end
      end
      object Panel5: TPanel
        Left = 1
        Top = 395
        Width = 765
        Height = 63
        Align = alClient
        Color = 14474715
        TabOrder = 1
        ExplicitHeight = 53
        object BitBtnSave: TBitBtn
          Left = 120
          Top = 6
          Width = 99
          Height = 28
          Caption = 'Save '
          TabOrder = 0
          Visible = False
          OnClick = BitBtnSaveClick
        end
        object BitBtnExit: TBitBtn
          Left = 454
          Top = 7
          Width = 75
          Height = 27
          Caption = '&Exit'
          ModalResult = 3
          TabOrder = 1
          Visible = False
          OnClick = BitBtnExitClick
          NumGlyphs = 2
        end
        object ToolBar2: TToolBar
          Left = 630
          Top = 1
          Width = 134
          Height = 61
          Align = alRight
          ButtonHeight = 55
          ButtonWidth = 58
          Caption = 'ToolBar2'
          Images = Main.ImageListScanTool
          ShowCaptions = True
          TabOrder = 2
          Transparent = True
          OnClick = BitBtnHelpClick
          ExplicitHeight = 51
          object PrintBtn: TToolButton
            Left = 0
            Top = 0
            Caption = '   &Print  '
            ImageIndex = 18
            OnClick = BitBtnPrintClick
          end
          object ToolButton1: TToolButton
            Left = 58
            Top = 0
            Caption = '&Help'
            ImageIndex = 19
          end
        end
      end
    end
    object ControlPanel: TPanel
      Left = 1
      Top = 1
      Width = 211
      Height = 459
      Align = alLeft
      Color = 14474715
      TabOrder = 1
      ExplicitHeight = 449
      object Panel6: TPanel
        Left = 1
        Top = 66
        Width = 209
        Height = 392
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BevelWidth = 2
        Color = 14474715
        TabOrder = 0
        ExplicitHeight = 382
        inline FrT: TFrameParInput
          Left = 4
          Top = 322
          Width = 191
          Height = 75
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Default'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 3
          TabStop = True
          ExplicitLeft = 4
          ExplicitTop = 322
          ExplicitWidth = 191
          ExplicitHeight = 75
          inherited frPanel: TPanel
            Left = 8
            Top = 9
            Width = 184
            Height = 65
            Hint = 'Time delay in the point'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 8
            ExplicitTop = 9
            ExplicitWidth = 184
            ExplicitHeight = 65
            inherited LabelFrm: TLabel
              Left = 153
              Top = 32
              Width = 3
              Caption = ''
              ExplicitLeft = 153
              ExplicitTop = 32
              ExplicitWidth = 3
            end
            inherited LabelUnit: TLabel
              Left = 150
              Top = 9
              ExplicitLeft = 150
              ExplicitTop = 9
            end
            inherited BitBtnFrm: TBitBtn
              Left = 10
              Top = 6
              Width = 71
              Height = 23
              Caption = 'Delay'
              ExplicitLeft = 10
              ExplicitTop = 6
              ExplicitWidth = 71
              ExplicitHeight = 23
            end
            inherited EditFrm: TEdit
              Left = 95
              Top = 6
              Width = 50
              ParentShowHint = False
              ShowHint = True
              OnChange = FrTEditFrmChange
              OnKeyPress = FrTEditFrmKeyPress
              ExplicitLeft = 95
              ExplicitTop = 6
              ExplicitWidth = 50
            end
            inherited ScrollBarFrm: TScrollBar
              Left = 13
              Top = 37
              Width = 106
              Height = 15
              Max = 5000
              ExplicitLeft = 13
              ExplicitTop = 37
              ExplicitWidth = 106
              ExplicitHeight = 15
            end
          end
          inherited siLangLinked1: TsiLangLinked
            TranslationData = {
              737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E69740101010D0A42697442746E46726D0144656C
              617901C7E0E4E5F0E6EAE0010D0A737448696E74730D0A544672616D65506172
              496E70757401010D0A667250616E656C0154696D652064656C617920696E2074
              686520706F696E7401010D0A4C6162656C46726D0101010D0A4C6162656C556E
              69740101010D0A42697442746E46726D0101010D0A4564697446726D0101010D
              0A5363726F6C6C42617246726D0101010D0A7374446973706C61794C6162656C
              730D0A7374466F6E74730D0A544672616D65506172496E707574015461686F6D
              6101417269616C010D0A42697442746E46726D014D532053616E732053657269
              6601417269616C010D0A73744D756C74694C696E65730D0A7374537472696E67
              730D0A73744F74686572537472696E67730D0A4564697446726D2E5465787401
              01010D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A54
              4672616D65506172496E7075740144454641554C545F43484152534554015255
              535349414E5F43484152534554010D0A42697442746E46726D0144454641554C
              545F43484152534554015255535349414E5F43484152534554010D0A}
          end
        end
        inline FrNPoints: TFrameParInput
          Left = 4
          Top = 144
          Width = 193
          Height = 77
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Default'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          TabStop = True
          ExplicitLeft = 4
          ExplicitTop = 144
          ExplicitWidth = 193
          ExplicitHeight = 77
          inherited frPanel: TPanel
            Left = 6
            Top = 8
            Width = 186
            Height = 67
            ExplicitLeft = 6
            ExplicitTop = 8
            ExplicitWidth = 186
            ExplicitHeight = 67
            inherited LabelFrm: TLabel
              Left = 161
              Top = 28
              Width = 3
              Caption = ''
              ExplicitLeft = 161
              ExplicitTop = 28
              ExplicitWidth = 3
            end
            inherited LabelUnit: TLabel
              Left = 152
              Top = 26
              ExplicitLeft = 152
              ExplicitTop = 26
            end
            inherited BitBtnFrm: TBitBtn
              Left = 13
              Top = 6
              Width = 76
              Height = 26
              Hint = 'Number  of points in I(V)'
              Caption = 'Points'
              ParentShowHint = False
              ShowHint = True
              ExplicitLeft = 13
              ExplicitTop = 6
              ExplicitWidth = 76
              ExplicitHeight = 26
            end
            inherited EditFrm: TEdit
              Left = 99
              Top = 6
              Width = 48
              OnChange = FrNPointsEditFrmChange
              OnExit = FrFrmExit
              OnKeyPress = FrNPointsEditFrmKeyPress
              ExplicitLeft = 99
              ExplicitTop = 6
              ExplicitWidth = 48
            end
            inherited ScrollBarFrm: TScrollBar
              Left = 17
              Top = 41
              Width = 106
              Height = 16
              SmallChange = 10
              ExplicitLeft = 17
              ExplicitTop = 41
              ExplicitWidth = 106
              ExplicitHeight = 16
            end
          end
          inherited siLangLinked1: TsiLangLinked
            TranslationData = {
              737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E6974016C6162656C756E697401010D0A42697442
              746E46726D01506F696E747301D2EEF7E5EA010D0A737448696E74730D0A5446
              72616D65506172496E7075740101010D0A667250616E656C0101010D0A4C6162
              656C46726D0101010D0A4C6162656C556E69740101010D0A42697442746E4672
              6D014E756D62657220206F6620706F696E747320696E204928562901D7E8F1EB
              EE20F2EEF7E5EA20EDE020EAF0E8E2EEE92049285629010D0A4564697446726D
              0101010D0A5363726F6C6C42617246726D0101010D0A7374446973706C61794C
              6162656C730D0A7374466F6E74730D0A544672616D65506172496E7075740144
              656661756C7401417269616C010D0A42697442746E46726D0144656661756C74
              01417269616C010D0A73744D756C74694C696E65730D0A7374537472696E6773
              0D0A73744F74686572537472696E67730D0A4564697446726D2E546578740101
              010D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A5446
              72616D65506172496E7075740144454641554C545F4348415253455401525553
              5349414E5F43484152534554010D0A42697442746E46726D0144454641554C54
              5F43484152534554015255535349414E5F43484152534554010D0A}
          end
        end
        inline FrStopV: TFrameParInput
          Left = 7
          Top = 78
          Width = 191
          Height = 71
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Default'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 2
          TabStop = True
          ExplicitLeft = 7
          ExplicitTop = 78
          ExplicitWidth = 191
          ExplicitHeight = 71
          inherited frPanel: TPanel
            Left = 3
            Top = 1
            Width = 186
            Height = 67
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 3
            ExplicitTop = 1
            ExplicitWidth = 186
            ExplicitHeight = 67
            inherited LabelFrm: TLabel
              Left = 153
              Top = 25
              Width = 3
              Caption = ''
              ExplicitLeft = 153
              ExplicitTop = 25
              ExplicitWidth = 3
            end
            inherited LabelUnit: TLabel
              Left = 165
              Top = 10
              Width = 14
              Caption = 'mV'
              ExplicitLeft = 165
              ExplicitTop = 10
              ExplicitWidth = 14
            end
            inherited BitBtnFrm: TBitBtn
              Left = 15
              Top = 6
              Height = 26
              Hint = 'Final point >=0'
              Caption = 'Final  V'
              OnClick = FrStopVBitBtnFrmClick
              ExplicitLeft = 15
              ExplicitTop = 6
              ExplicitHeight = 26
            end
            inherited EditFrm: TEdit
              Left = 97
              Top = 7
              Width = 48
              Hint = 'Final point >=0'
              ParentShowHint = False
              ShowHint = True
              OnChange = FrStopVEditFrmChange
              OnExit = FrStopVEditFrmChange
              OnKeyPress = FrStopVEditFrmKeyPress
              ExplicitLeft = 97
              ExplicitTop = 7
              ExplicitWidth = 48
            end
            inherited ScrollBarFrm: TScrollBar
              Left = 17
              Top = 41
              Width = 120
              Height = 16
              ExplicitLeft = 17
              ExplicitTop = 41
              ExplicitWidth = 120
              ExplicitHeight = 16
            end
          end
          inherited siLangLinked1: TsiLangLinked
            TranslationData = {
              737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E6974016D5601ECC2010D0A42697442746E46726D
              0146696E616C20205601E4EE20010D0A737448696E74730D0A544672616D6550
              6172496E7075740101010D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E69740101010D0A42697442746E46726D0146696E
              616C20706F696E74203E3D3001CAEEEDE5F7EDE0FF20F2EEF7EAE0203E3D3001
              0D0A4564697446726D0146696E616C20706F696E74203E3D3001CAEEEDE5F7ED
              E0FF20F2EEF7EAE0203E3D30010D0A5363726F6C6C42617246726D0101010D0A
              7374446973706C61794C6162656C730D0A7374466F6E74730D0A544672616D65
              506172496E7075740144656661756C7401417269616C010D0A42697442746E46
              726D0144656661756C7401417269616C010D0A73744D756C74694C696E65730D
              0A7374537472696E67730D0A73744F74686572537472696E67730D0A45646974
              46726D2E546578740101010D0A7374436F6C6C656374696F6E730D0A73744368
              6172536574730D0A544672616D65506172496E7075740144454641554C545F43
              484152534554015255535349414E5F43484152534554010D0A42697442746E46
              726D0144454641554C545F43484152534554015255535349414E5F4348415253
              4554010D0A}
          end
        end
        inline FrStartV: TFrameParInput
          Left = 4
          Top = 8
          Width = 194
          Height = 70
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Default'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 1
          TabStop = True
          ExplicitLeft = 4
          ExplicitTop = 8
          ExplicitWidth = 194
          ExplicitHeight = 70
          inherited frPanel: TPanel
            Left = 6
            Top = 4
            Width = 186
            Height = 62
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 6
            ExplicitTop = 4
            ExplicitWidth = 186
            ExplicitHeight = 62
            inherited LabelFrm: TLabel
              Left = 153
              Top = 24
              Width = 3
              Caption = ''
              ExplicitLeft = 153
              ExplicitTop = 24
              ExplicitWidth = 3
            end
            inherited LabelUnit: TLabel
              Left = 165
              Top = 10
              Width = 14
              Caption = 'mV'
              ExplicitLeft = 165
              ExplicitTop = 10
              ExplicitWidth = 14
            end
            inherited BitBtnFrm: TBitBtn
              Left = 13
              Top = 5
              Width = 75
              Hint = 'Start point <=0'
              Caption = 'Start V'
              ParentShowHint = False
              ShowHint = True
              ExplicitLeft = 13
              ExplicitTop = 5
              ExplicitWidth = 75
            end
            inherited EditFrm: TEdit
              Left = 97
              Top = 6
              Width = 48
              Hint = 'Start point <=0'
              ParentShowHint = False
              ShowHint = True
              OnChange = FrStartVEditFrmChange
              OnExit = FrFrmExit
              OnKeyPress = FrStartVEditFrmKeyPress
              ExplicitLeft = 97
              ExplicitTop = 6
              ExplicitWidth = 48
            end
            inherited ScrollBarFrm: TScrollBar
              Left = 16
              Top = 37
              Width = 120
              Height = 16
              SmallChange = 10
              ExplicitLeft = 16
              ExplicitTop = 37
              ExplicitWidth = 120
              ExplicitHeight = 16
            end
          end
          inherited siLangLinked1: TsiLangLinked
            TranslationData = {
              737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E6974016D5601ECC2010D0A42697442746E46726D
              015374617274205601EEF220010D0A737448696E74730D0A544672616D655061
              72496E7075740101010D0A667250616E656C0101010D0A4C6162656C46726D01
              01010D0A4C6162656C556E69740101010D0A42697442746E46726D0153746172
              7420706F696E74203C3D3001CDE0F7E0EBFCEDE0FF20F2EEF7EAE0203C3D3001
              0D0A4564697446726D01537461727420706F696E74203C3D3001CDE0F7E0EBFC
              EDE0FF20F2EEF7EAE0203C3D30010D0A5363726F6C6C42617246726D0101010D
              0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A544672616D
              65506172496E7075740144656661756C740144656661756C74010D0A42697442
              746E46726D0144656661756C740144656661756C74010D0A73744D756C74694C
              696E65730D0A7374537472696E67730D0A73744F74686572537472696E67730D
              0A4564697446726D2E546578740101010D0A7374436F6C6C656374696F6E730D
              0A737443686172536574730D0A544672616D65506172496E7075740144454641
              554C545F43484152534554015255535349414E5F43484152534554010D0A4269
              7442746E46726D0144454641554C545F43484152534554015255535349414E5F
              43484152534554010D0A}
          end
        end
        inline frNGraph: TFrameParInput
          Left = 10
          Top = 256
          Width = 186
          Height = 73
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Default'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 4
          TabStop = True
          ExplicitLeft = 10
          ExplicitTop = 256
          ExplicitWidth = 186
          ExplicitHeight = 73
          inherited frPanel: TPanel
            Left = 1
            Top = 9
            Width = 185
            Height = 62
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 1
            ExplicitTop = 9
            ExplicitWidth = 185
            ExplicitHeight = 62
            inherited LabelFrm: TLabel
              Left = 153
              Top = 24
              Width = 3
              Caption = ''
              ExplicitLeft = 153
              ExplicitTop = 24
              ExplicitWidth = 3
            end
            inherited LabelUnit: TLabel
              Top = 10
              ExplicitTop = 10
            end
            inherited BitBtnFrm: TBitBtn
              Left = 14
              Top = 6
              Width = 77
              Height = 23
              Hint = 'Number of I(v) curves'
              Caption = 'Graphics'
              ParentShowHint = False
              ShowHint = True
              ExplicitLeft = 14
              ExplicitTop = 6
              ExplicitWidth = 77
              ExplicitHeight = 23
            end
            inherited EditFrm: TEdit
              Left = 97
              Top = 6
              Width = 48
              Hint = 'Start point <=0'
              ParentShowHint = False
              ShowHint = True
              OnChange = frNGraphEditFrmChange
              OnKeyPress = frNGraphEditFrmKeyPress
              ExplicitLeft = 97
              ExplicitTop = 6
              ExplicitWidth = 48
            end
            inherited ScrollBarFrm: TScrollBar
              Left = 15
              Top = 36
              Width = 120
              Height = 16
              SmallChange = 10
              ExplicitLeft = 15
              ExplicitTop = 36
              ExplicitWidth = 120
              ExplicitHeight = 16
            end
          end
          inherited siLangLinked1: TsiLangLinked
            TranslationData = {
              737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E69740101010D0A42697442746E46726D01477261
              706869637301CAF0E8E2FBF5010D0A737448696E74730D0A544672616D655061
              72496E70757401010D0A667250616E656C0101010D0A4C6162656C46726D0101
              010D0A4C6162656C556E69740101010D0A42697442746E46726D014E756D6265
              72206F6620492876292063757276657301010D0A4564697446726D0153746172
              7420706F696E74203C3D3001010D0A5363726F6C6C42617246726D0101010D0A
              7374446973706C61794C6162656C730D0A7374466F6E74730D0A544672616D65
              506172496E707574015461686F6D6101417269616C010D0A42697442746E4672
              6D014D532053616E7320536572696601417269616C010D0A73744D756C74694C
              696E65730D0A7374537472696E67730D0A73744F74686572537472696E67730D
              0A4564697446726D2E546578740101010D0A7374436F6C6C656374696F6E730D
              0A737443686172536574730D0A544672616D65506172496E7075740144454641
              554C545F43484152534554015255535349414E5F43484152534554010D0A4269
              7442746E46726D0144454641554C545F43484152534554015255535349414E5F
              43484152534554010D0A}
          end
        end
        object Panel2: TPanel
          Left = 10
          Top = 222
          Width = 186
          Height = 41
          Color = 14474715
          TabOrder = 5
          object LabelStep: TLabel
            Left = 50
            Top = 2
            Width = 41
            Height = 16
            Caption = 'Step='
          end
          object LabelStepMin: TLabel
            Left = 47
            Top = 20
            Width = 56
            Height = 16
            Caption = 'Step Min'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clRed
            Font.Height = -13
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      object PanelLeftUp: TPanel
        Left = 1
        Top = 1
        Width = 209
        Height = 65
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BevelWidth = 2
        Color = 14474715
        TabOrder = 1
        object ToolBar1: TToolBar
          Left = 4
          Top = 4
          Width = 201
          Height = 57
          Align = alClient
          ButtonHeight = 47
          ButtonWidth = 89
          Caption = 'ToolBar1'
          Images = Main.ImageList24
          ShowCaptions = True
          TabOrder = 0
          Transparent = True
          object StartBtn: TToolButton
            Left = 0
            Top = 0
            Caption = '      &Start      '
            ImageIndex = 8
            Style = tbsCheck
            OnClick = StartBtnClick
          end
        end
      end
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 527
    Top = 122
  end
  object siLangLinked: TsiLangLinked
    Version = '6.5'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 2
    LangDispatcher = Main.siLangDispatcher1
    OnChangeLanguage = siLangLinkedChangeLanguage
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
    Left = 456
    Top = 248
    TranslationData = {
      737443617074696F6E730D0A545370656374726F53636F707956015370656374
      726F53636F70792020492D562001D1EFE5EAF2F0EEF1EAEEEFE8FF20492D5601
      0D0A50616E656C310101010D0A50616E656C330150616E656C3301010D0A5061
      6E656C4D61696E0150616E656C3401010D0A50616E656C350101010D0A426974
      42746E5361766501536176652001D126EEF5F0E0EDE8F2FC010D0A4269744274
      6E457869740126457869740126C2FBF5EEE4010D0A436F6E74726F6C50616E65
      6C0101010D0A50616E656C360101010D0A50616E656C320101010D0A4C616265
      6C5374657001537465703D01D8E0E33D010D0A4C6162656C537465704D696E01
      53746570204D696E01CCE8ED2E20F8E0E3010D0A50616E656C4C656674557001
      01010D0A4564697431014564697401D0E5E4E0EAF2E8F0EEE2E0F2FC010D0A43
      6F7079746F636C6970626F6172643101436F707920746F20636C6970626F6172
      6401CAEEEFE8F0EEE2E0F2FC20E220E1F3F4E5F020EEE1ECE5EDE0010D0A546F
      6F6C4261723201546F6F6C4261723201010D0A5072696E7442746E0120202026
      5072696E7420200126CFE5F7E0F2FC010D0A546F6F6C4261723101546F6F6C42
      61723101010D0A537461727442746E0120202020202026537461727420202020
      20200120202020202026D1F2E0F0F22020202020010D0A546F6F6C427574746F
      6E31012648656C70014326EFF0E0E2EAE0010D0A737448696E74730D0A545370
      656374726F53636F70795601010D0A5374617475734261720101010D0A50616E
      656C310101010D0A50616E656C330101010D0A50616E656C4D61696E0101010D
      0A50616765436F6E74726F6C0101010D0A50616E656C350101010D0A42697442
      746E536176650101010D0A42697442746E457869740101010D0A436F6E74726F
      6C50616E656C0101010D0A50616E656C360101010D0A4672540101010D0A4672
      4E506F696E74730101010D0A467253746F70560101010D0A4672537461727456
      0101010D0A66724E47726170680101010D0A50616E656C320101010D0A4C6162
      656C537465700101010D0A4C6162656C537465704D696E0101010D0A50616E65
      6C4C65667455700101010D0A45646974310101010D0A436F7079746F636C6970
      626F617264310101010D0A546F6F6C426172320101010D0A5072696E7442746E
      0101010D0A546F6F6C426172310101010D0A537461727442746E0101010D0A54
      6F6F6C427574746F6E310101010D0A7374446973706C61794C6162656C730D0A
      7374466F6E74730D0A545370656374726F53636F7079560144656661756C7401
      44656661756C74010D0A537461747573426172015461686F6D61014465666175
      6C74010D0A4672540144656661756C740144656661756C74010D0A46724E506F
      696E74730144656661756C740144656661756C74010D0A467253746F70560144
      656661756C740144656661756C74010D0A46725374617274560144656661756C
      740144656661756C74010D0A66724E47726170680144656661756C7401446566
      61756C74010D0A4C6162656C537465704D696E0144656661756C740144656661
      756C74010D0A73744D756C74694C696E65730D0A7374537472696E67730D0A73
      7472737472737630015374657020746F6F20736D616C6C2101D8E0E320F1EBE8
      F8EAEEEC20ECE0EB010D0A737472737472737632014368616E67652050617261
      6D65746572732E01C8E7ECE5EDE8F2E520EFE0F0E0ECE5F2F0FB2E010D0A7374
      727374727376330157726F6E6720706172616D65746572732101CDE5EFF0E0E2
      E8EBFCEDFBE920EFE0F0E0ECE5F2E5F0010D0A73747273747273763401457272
      6F7220696E70757401CEF8E8E1EAE020E2E2EEE4E0010D0A7374727374727376
      35012046696C65206E6F7420657869737401D4E0E9EB20EDE520F1F3F9E5F1F2
      E2F3E5F2010D0A73747273747273763601546865207374657020746F6F20736D
      616C6C214368616E676520706172616D657465727320746F20696E6372656173
      652074686520737465702E01D8E0E320F1EBE8F8EAEEEC20ECE0EB2E20C8E7EC
      E5EDE8F2E520EFE0F0E0ECE5F2F0FB2C20F7F2EEE1FB20F3E2E5EBE8E8F2FC20
      F8E0E3010D0A4944535F3001537465703D01D8E0E33D010D0A4944535F313001
      466F72636520496D61676501D1E8EBE0010D0A4944535F31310143757272656E
      7420496D61676501D2EEEA010D0A4944535F3133015370656374726F73636F70
      7920492D5601D1EFE5EAF2F0EEF1EAEEEFE8FF20492D56010D0A4944535F3101
      53746570204D696E3D01CCE8ED2E20F8E0E33D010D0A4944535F323001506F69
      6E743D2001D2EEF7EAE03D010D0A4944535F3231016E4101EDC0010D0A494453
      5F323301436C69636B204C65667420427574746F6E20746F20736574206C6162
      656C3B20436C69636B20526967687420427574746F6E20746F2073686F772070
      6F707570206D656E7501CAEBE8EA20EBE5E2EEE920EAEDEEEFEAEEE9202D20E4
      EEE1E0E2E8F2FC20ECE5F2EAF33B20CAEBE8EA20EFF0E0E2EEE92D20E2F1EFEB
      FBE2E0FEF9E5E520ECE5EDFE010D0A4944535F3234015370656374726F73636F
      70792043757276652053544D01D1EFE5EAF2F0EEF1EAEEEFE8FF20010D0A4944
      535F32015370656374726F73636F707901D1EFE5EAF2F0EEF1EAEEEFE8FF2001
      0D0A4944535F333501206D5601ECC2010D0A4944535F33016DF17301ECEAF101
      0D0A4944535F34016D5601ECC2010D0A4944535F3801546F706F677261706879
      2F546F70205669657701D0E5EBFCE5F42FC2E8E420F1E2E5F0F5F3010D0A4944
      535F3901506861736520536869667401D4E0E7E0010D0A4944535F3330015072
      696E746572206973206E6F7420636F6E6E65637465642E202001CFF0E8EDF2E5
      F020EDE520EFEEE4F1EEE5E4E8EDE5ED010D0A73744F74686572537472696E67
      730D0A545370656374726F53636F7079562E48656C7046696C650101010D0A53
      74617475734261722E53696D706C655465787401436C69636B204C6566742042
      7574746F6E202D20506F705570204D656E753B2043757276657328204374726C
      2041202D417665726167653B204374726C2044656C2D2044656C657465203B20
      50672055702C506720446F776E2D204E6578743B50726576696F75732901CAEB
      E8EA20EFF0E0E2EEE920EAEDEEEFEAEEE92D20E2F1EFEBFBE22E20ECE5EDFE3B
      20CAF0E8E2FBE528204374726C2041202DF3F1F0E5E42E3B204374726C204465
      6C2D20F3E4E0EB2E203B2050672055702C506720446F776E2D20F1EBE5E42E3B
      EFF0E5E42E29010D0A7374436F6C6C656374696F6E730D0A5374617475734261
      722E50616E656C735B305D2E5465787401436C69636B20526967687420427574
      746F6E2D20506F707570204D656E753B4C6162656C73202820436C69636B2020
      4C65667420427574746F6E202D20416464203B2044656C202D44656C6574653B
      55702C446F776E2D4E6578742C50726576696F7573293B2001CAEBE8EA20EFF0
      E0E2EEE920EAEDEEEFEAEEE92D20E2F1EFEBFBE22E20ECE5EDFE3B20CCE5F2EA
      E828CAEBE8EA20EBE5E2EEE92DE4EEE1E0E22E2C2064656C2DF3E4E0EB2E2C55
      702C446F776E202DF1EBE5E42E2CEFF0E5E42E2920010D0A5374617475734261
      722E50616E656C735B315D2E54657874014375727665732028204374726C4120
      2D417665726167653B204374726C44656C2D44656C6574653B20506755702C50
      67446F776E2D4E6578743B507265762E290120CAF0E8E2FBE520284374726C41
      202DF3F1F0E5E42E3B204374726C44656C2D20F3E4E0EB2E203B20506755702C
      5067446F776E2D20F1EBE5E42E3BEFF0E5E42E29010D0A737443686172536574
      730D0A545370656374726F53636F707956015255535349414E5F434841525345
      54015255535349414E5F43484152534554010D0A537461747573426172014445
      4641554C545F43484152534554015255535349414E5F43484152534554010D0A
      4672540144454641554C545F43484152534554015255535349414E5F43484152
      534554010D0A46724E506F696E74730144454641554C545F4348415253455401
      5255535349414E5F43484152534554010D0A467253746F70560144454641554C
      545F43484152534554015255535349414E5F43484152534554010D0A46725374
      617274560144454641554C545F43484152534554015255535349414E5F434841
      52534554010D0A66724E47726170680144454641554C545F4348415253455401
      5255535349414E5F43484152534554010D0A4C6162656C537465704D696E0152
      55535349414E5F43484152534554015255535349414E5F43484152534554010D
      0A}
  end
  object MainMenu1: TMainMenu
    Left = 160
    Top = 144
  end
  object MainMenu2: TMainMenu
    Left = 312
    Top = 200
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Copytoclipboard1: TMenuItem
        Caption = 'Copy to clipboard'
        OnClick = Copytoclipboard1Click
      end
    end
  end
end
