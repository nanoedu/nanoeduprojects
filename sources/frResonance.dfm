object AutoResonance: TAutoResonance
  Left = 333
  Top = 161
  BorderIcons = [biSystemMenu]
  Caption = 'Frequency Scanning'
  ClientHeight = 545
  ClientWidth = 845
  Color = clSilver
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  ShowHint = True
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnMouseDown = PanelManualMouseDown
  PixelsPerInch = 96
  TextHeight = 16
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 200
    Height = 545
    Align = alLeft
    BevelOuter = bvNone
    Color = 14474715
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 200
      Height = 121
      Align = alTop
      Color = 14474715
      TabOrder = 0
      object Regime: TRadioGroup
        Left = 20
        Top = 59
        Width = 168
        Height = 55
        Caption = 'Regime'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ItemIndex = 0
        Items.Strings = (
          'Automatic'
          'Manual')
        ParentFont = False
        TabOrder = 0
        OnClick = RegimeClick
      end
      object Panelstart: TPanel
        Left = 1
        Top = 1
        Width = 198
        Height = 52
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object ToolBarControl: TToolBar
          Left = 0
          Top = 0
          Width = 198
          Height = 49
          ButtonHeight = 47
          ButtonWidth = 69
          Caption = 'ToolBarControl'
          DrawingStyle = dsGradient
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          GradientEndColor = clSilver
          GradientStartColor = 14803425
          Images = Main.ImageList24
          ParentFont = False
          ShowCaptions = True
          TabOrder = 0
          Transparent = True
          object StartBtn: TToolButton
            Left = 0
            Top = 0
            Caption = '    &Start   '
            ImageIndex = 8
            Style = tbsCheck
            OnClick = StartBtnClick
          end
          object ToolButton2: TToolButton
            Left = 69
            Top = 0
            Caption = '  S&top'
            ImageIndex = 9
            OnClick = ToolButton2Click
          end
        end
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 121
      Width = 200
      Height = 424
      Align = alClient
      Color = 14474715
      TabOrder = 1
      object PanelManual: TPanel
        Left = 1
        Top = 1
        Width = 198
        Height = 424
        Align = alTop
        BevelOuter = bvNone
        Color = 14474715
        TabOrder = 0
        OnMouseDown = PanelManualMouseDown
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 198
          Height = 153
          Align = alTop
          Color = 14474715
          TabOrder = 1
          OnMouseDown = PanelManualMouseDown
          object Bevel2: TBevel
            Left = 12
            Top = 15
            Width = 178
            Height = 130
            Shape = bsFrame
          end
          object Label1: TLabel
            Left = 35
            Top = 91
            Width = 129
            Height = 16
            Hint = 'Probe Force Oscillation Amplitude'
            Caption = 'Voltage Modulation '
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object AMLabel: TLabel
            Left = 80
            Top = 135
            Width = 4
            Height = 16
          end
          object TLabel
            Left = 82
            Top = 185
            Width = 4
            Height = 16
          end
          object AMGainLabel: TLabel
            Left = 89
            Top = 189
            Width = 4
            Height = 16
          end
          object Label3: TLabel
            Left = 54
            Top = 81
            Width = 54
            Height = 16
            Caption = '    Probe'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object sbAmpMod: TScrollBar
            Left = 17
            Top = 113
            Width = 161
            Height = 16
            Min = 1
            PageSize = 0
            Position = 1
            TabOrder = 0
            OnChange = sbAmpModChange
            OnScroll = sbAmpModScroll
          end
          object rgManual: TRadioGroup
            Left = 39
            Top = 20
            Width = 121
            Height = 58
            Caption = 'Manual Regime'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ItemIndex = 0
            Items.Strings = (
              'Rough'
              'Fine')
            ParentFont = False
            TabOrder = 1
            OnClick = rgManualClick
          end
        end
        object Panel6: TPanel
          Left = 0
          Top = 153
          Width = 198
          Height = 271
          Align = alClient
          Color = 14474715
          TabOrder = 0
          OnMouseDown = PanelManualMouseDown
          object Bevel3: TBevel
            Left = 11
            Top = 12
            Width = 179
            Height = 55
            Shape = bsFrame
          end
          object Label4: TLabel
            Left = 15
            Top = 15
            Width = 159
            Height = 16
            Hint = 'Central Frequency Selection'
            Caption = '    Frequency Range, kHz'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object ComboBoxFQ_SEl: TComboBox
            Left = 52
            Top = 37
            Width = 96
            Height = 24
            ItemHeight = 16
            TabOrder = 0
            OnClick = ComboBoxFQ_SELClick
            Items.Strings = (
              '9')
          end
          object PanelT: TPanel
            Left = -2
            Top = 155
            Width = 195
            Height = 69
            BevelOuter = bvNone
            Color = 14474715
            TabOrder = 1
            Visible = False
            object Bevel5: TBevel
              Left = 8
              Top = 12
              Width = 179
              Height = 50
            end
            object Label5: TLabel
              Left = 21
              Top = 13
              Width = 62
              Height = 16
              Caption = 'Delay, ms'
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LabelT: TLabel
              Left = 146
              Top = 18
              Width = 8
              Height = 16
              Caption = 'T'
            end
            object ScrollBarT: TScrollBar
              Left = 21
              Top = 35
              Width = 158
              Height = 17
              Max = 10000
              Min = 1
              PageSize = 0
              Position = 1
              TabOrder = 0
              OnScroll = ScrollBarTScroll
            end
          end
          object PanelVpipette: TPanel
            Left = 1
            Top = 218
            Width = 196
            Height = 52
            Align = alBottom
            Color = 14474715
            TabOrder = 2
            Visible = False
            object PanelV: TPanel
              Left = 1
              Top = 1
              Width = 194
              Height = 50
              Align = alClient
              BevelOuter = bvLowered
              Color = clSilver
              ParentBackground = False
              TabOrder = 0
              object LabelV: TLabel
                Left = 70
                Top = 5
                Width = 38
                Height = 16
                Caption = 'LabelV'
              end
              object ScrollBarV: TScrollBar
                Left = 29
                Top = 24
                Width = 121
                Height = 17
                Max = 32767
                Min = -32768
                PageSize = 0
                TabOrder = 0
                OnScroll = ScrollBarVScroll
              end
            end
          end
          object PanelCustom: TPanel
            Left = 5
            Top = 68
            Width = 191
            Height = 88
            BevelOuter = bvNone
            TabOrder = 3
            Visible = False
            object Bevel1: TBevel
              Left = 7
              Top = 5
              Width = 178
              Height = 80
            end
            object Label2: TLabel
              Left = 40
              Top = 5
              Width = 30
              Height = 16
              Caption = 'From'
            end
            object Label6: TLabel
              Left = 40
              Top = 47
              Width = 15
              Height = 16
              Caption = 'To'
            end
            object LblFromVal: TLabel
              Left = 96
              Top = 5
              Width = 64
              Height = 16
              Caption = 'LblFromVal'
            end
            object LblToval: TLabel
              Left = 96
              Top = 47
              Width = 47
              Height = 16
              Caption = 'LblToval'
            end
            object ScrollBarFrom: TScrollBar
              Left = 30
              Top = 24
              Width = 121
              Height = 17
              Max = 64
              PageSize = 0
              Position = 1
              TabOrder = 0
              OnChange = ScrollBarFromChange
              OnScroll = ScrollBarFromScroll
            end
            object ScrollBarTo: TScrollBar
              Left = 30
              Top = 64
              Width = 121
              Height = 17
              Max = 64
              PageSize = 0
              Position = 1
              TabOrder = 1
              OnChange = ScrollBarToChange
              OnScroll = ScrollBarToScroll
            end
          end
        end
      end
    end
  end
  object Panel4: TPanel
    Left = 200
    Top = 0
    Width = 645
    Height = 545
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object PanelBottom: TPanel
      Left = 0
      Top = 479
      Width = 645
      Height = 66
      Align = alBottom
      BevelOuter = bvNone
      BevelWidth = 2
      Color = 14474715
      TabOrder = 0
      object ToolBarOpt: TToolBar
        Left = 0
        Top = 0
        Width = 645
        Height = 55
        AutoSize = True
        ButtonHeight = 55
        ButtonWidth = 64
        DisabledImages = Main.ImageListScanTool
        EdgeInner = esNone
        EdgeOuter = esNone
        Images = Main.ImageListScanTool
        ShowCaptions = True
        TabOrder = 0
        object BitBtnOk: TToolButton
          Left = 0
          Top = 0
          AutoSize = True
          Caption = 'Landing'
          ImageIndex = 1
          OnClick = OKBitBtnClick
        end
        object Optionsbtn: TToolButton
          Left = 55
          Top = 0
          AutoSize = True
          Caption = 'Options '
          ImageIndex = 4
          OnClick = OptionsbtnClick
        end
        object ToolButton3: TToolButton
          Left = 113
          Top = 0
          Caption = 'Animation'
          ImageIndex = 20
          OnClick = BitBtnTutorClick
        end
        object BitBtnprint: TToolButton
          Left = 177
          Top = 0
          Caption = 'Print'
          ImageIndex = 18
          OnClick = BitBtnPrintClick
        end
        object ToolButton1: TToolButton
          Left = 241
          Top = 0
          Caption = '&Help'
          ImageIndex = 19
          OnClick = BitBtnHelpClick
        end
      end
    end
    object PanelGr: TPanel
      Left = 0
      Top = 0
      Width = 645
      Height = 479
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 1
    end
  end
  object MainMenu: TMainMenu
    Left = 232
    Top = 40
    object Edit: TMenuItem
      Caption = 'Edit'
      GroupIndex = 1
      object CopytoClipboard: TMenuItem
        Caption = 'Copy to ClipBoard'
        OnClick = CopytoClipboardClick
      end
      object CopytoFile: TMenuItem
        Caption = 'Copy to File'
        OnClick = CopytoFileClick
      end
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 488
    Top = 112
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
    Left = 328
    Top = 224
    TranslationData = {
      737443617074696F6E730D0A544175746F5265736F6E616E6365014672657175
      656E6379205363616E6E696E6701CEEFF0E5E4E5EBE5EDE8E520F0E5E7EEEDE0
      EDF1EDEEE920F7E0F1F2EEF2FB010D0A526567696D6501526567696D6501D0E5
      E6E8EC010D0A4C6162656C3101566F6C74616765204D6F64756C6174696F6E20
      0120D0E0F1EAE0F7EAE820E7EEEDE4E0010D0A72674D616E75616C014D616E75
      616C20526567696D6501D0F3F7EDEEE920F0E5E6E8EC010D0A4C6162656C3401
      202020204672657175656E63792052616E67652C206B487A01D7E0F1F2EEF2ED
      FBE920E4E8E0EFE0E7EEED2C20EAC3F6010D0A45646974014564697401D0E5E4
      E0EAF2E8F0EEE2E0F2FC010D0A436F7079746F436C6970626F61726401436F70
      7920746F20436C6970426F61726401CAEEEFE8F0EEE2E0F2FC20E220E1F3F4E5
      F020EEE1ECE5EDE0010D0A436F7079746F46696C6501436F707920746F204669
      6C6501CAEEEFE8F0EEE2E0F2FC20E220F4E0E9EB010D0A4C6162656C33012020
      202050726F626501CDE0EFF0FFE6E5EDE8E5010D0A4C6162656C350144656C61
      792C206D7301C7E0E4E5F0E6EAE02C20ECF1010D0A42697442746E4F6B014C61
      6E64696E6701CFEEE4E2EEE4010D0A4F7074696F6E7362746E014F7074696F6E
      732001CFE0F0E0ECE5F2F0FB010D0A546F6F6C427574746F6E31012648656C70
      01D126EFF0E0E2EAE0010D0A42697442746E7072696E74015072696E7401CFE5
      F7E0F2FC010D0A546F6F6C427574746F6E3301416E696D6174696F6E01C0EDE8
      ECE0F6E8FF010D0A546F6F6C426172436F6E74726F6C01546F6F6C426172436F
      6E74726F6C01010D0A537461727442746E012020202026537461727420202001
      2020202026D1F2E0F0F2202020010D0A546F6F6C427574746F6E320120205326
      746F70012020D126F2EEEF010D0A4C6162656C56014C6162656C5601010D0A50
      616E656C4D61696E0101010D0A50616E656C310101010D0A50616E656C737461
      72740101010D0A50616E656C320101010D0A50616E656C4D616E75616C010101
      0D0A50616E656C330101010D0A414D4C6162656C0101010D0A414D4761696E4C
      6162656C0101010D0A50616E656C360101010D0A50616E656C540101010D0A4C
      6162656C54015401010D0A50616E656C56706970657474650101010D0A50616E
      656C560101010D0A50616E656C437573746F6D0101010D0A4C6162656C320146
      726F6D01010D0A4C6162656C3601546F01010D0A4C626C46726F6D56616C014C
      626C46726F6D56616C01010D0A4C626C546F76616C014C626C546F76616C0101
      0D0A50616E656C340101010D0A50616E656C426F74746F6D0101010D0A546F6F
      6C4261724F70740101010D0A50616E656C47720101010D0A737448696E74730D
      0A544175746F5265736F6E616E636501010D0A4C6162656C310150726F626520
      466F726365204F7363696C6C6174696F6E20416D706C697475646501C0ECEFEB
      E8F2F3E4E020E2FBEDF3E6E4E5EDEDFBF520EAEEEBE5E1E0EDE8E9010D0A4C61
      62656C340143656E7472616C204672657175656E63792053656C656374696F6E
      01C2FBE1EEF020F6E5EDF2F0E0EBFCEDEEE920F7E0F1F2EEF2FB010D0A50616E
      656C4D61696E0101010D0A50616E656C310101010D0A526567696D650101010D
      0A50616E656C73746172740101010D0A546F6F6C426172436F6E74726F6C0101
      010D0A537461727442746E0101010D0A546F6F6C427574746F6E320101010D0A
      50616E656C320101010D0A50616E656C4D616E75616C0101010D0A50616E656C
      330101010D0A426576656C320101010D0A414D4C6162656C0101010D0A414D47
      61696E4C6162656C0101010D0A4C6162656C330101010D0A7362416D704D6F64
      0101010D0A72674D616E75616C0101010D0A50616E656C360101010D0A426576
      656C330101010D0A436F6D626F426F7846515F53456C0101010D0A50616E656C
      540101010D0A426576656C350101010D0A4C6162656C350101010D0A4C616265
      6C540101010D0A5363726F6C6C426172540101010D0A50616E656C5670697065
      7474650101010D0A50616E656C560101010D0A4C6162656C560101010D0A5363
      726F6C6C426172560101010D0A50616E656C437573746F6D0101010D0A426576
      656C310101010D0A4C6162656C320101010D0A4C6162656C360101010D0A4C62
      6C46726F6D56616C0101010D0A4C626C546F76616C0101010D0A5363726F6C6C
      42617246726F6D0101010D0A5363726F6C6C426172546F0101010D0A50616E65
      6C340101010D0A50616E656C426F74746F6D0101010D0A546F6F6C4261724F70
      740101010D0A42697442746E4F6B0101010D0A4F7074696F6E7362746E010101
      0D0A546F6F6C427574746F6E330101010D0A42697442746E7072696E74010101
      0D0A546F6F6C427574746F6E310101010D0A50616E656C47720101010D0A4564
      69740101010D0A436F7079746F436C6970626F6172640101010D0A436F707974
      6F46696C650101010D0A7374446973706C61794C6162656C730D0A7374466F6E
      74730D0A544175746F5265736F6E616E63650144656661756C74014465666175
      6C74010D0A526567696D650144656661756C740144656661756C74010D0A4C61
      62656C310144656661756C740144656661756C74010D0A72674D616E75616C01
      44656661756C740144656661756C74010D0A4C6162656C340144656661756C74
      0144656661756C74010D0A4C6162656C330144656661756C740144656661756C
      74010D0A4C6162656C350144656661756C74015461686F6D61010D0A546F6F6C
      426172436F6E74726F6C0144656661756C740144656661756C74010D0A73744D
      756C74694C696E65730D0A526567696D652E4974656D73014175746F6D617469
      632C4D616E75616C01C0E2F2EE2CD0F3F7EDEEE9010D0A72674D616E75616C2E
      4974656D7301526F7567682C46696E6501C3F0F3E1EE2CD2EEF7EDEE010D0A43
      6F6D626F426F7846515F53456C2E4974656D73013901010D0A7374537472696E
      67730D0A4944535F3132015072696E746572206973206E6F7420636F6E6E6563
      7465642E202001CFF0E8EDF2E5F020EDE520EFEEE4F1EEE5E4E8EDE5ED010D0A
      4944535F31340152555301010D0A4944535F31350120487A01C3F6010D0A4944
      535F313601206D5601ECC2010D0A4944535F31370131206D5601312C20ECC201
      0D0A4944535F32310150726F6265204F7363696C6C6174696F6E20416D706C69
      747564653D2001C0ECEFEBE8F2F3E4E020EAEEEBE5E1E0EDE8E920E7EEEDE4E0
      3D010D0A4944535F32320120560120C2010D0A4944535F323301506C65617365
      202C666972737420206D616B6520726F756768212101D1EDE0F7E0EBEE20E2FB
      EFEEEBEDE8F2E520E3F0F3E1FBE920F0E5E6E8EC010D0A4944535F3234015072
      6F6265204F7363696C6C6174696F6E20416D706C697475646501C0ECEFEBE8F2
      F3E4EDEE2DF7E0F1F2EEF2EDE0FF20F5E0F0E0EAF2E5F0E8F1F2E8EAE020E7EE
      EDE4E0010D0A4944535F323901506C656173652C2077616974207768696C6520
      7468652066696E6520726567696D65206973206D616B696E67212101CFEEE4EE
      E6E4E8F2E520EFEEEAE020E2FBEFEEEBEDE8F2F1FF20F2EEF7EDFBE920F0E5E6
      E8EC010D0A4944535F3330014C616E64696E6701CFEEE4E2EEE4010D0A494453
      5F3331014C616E64696E67206265666F7265205363616E6E696E6701D1E4E5EB
      E0E9F2E520EFEEE4E2EEE42C20EFF0E5E6E4E520F7E5EC20F1EAE0EDE8F0EEE2
      E0F2FC010D0A4944535F3332015761697420746F2066696E697368206265666F
      7265206578697421212101CFEEE4EEE6E4E8F2E520EEEAEEEDF7E0EDE8E520EF
      F0E5E6E4E520F7E5EC20E2FBE9F2E8010D0A4944535F3337014672657175656E
      6379205363616E6E696E672E2041646A75737420205265736F6E616E636501CE
      EFF0E5E4E5EBE5EDE8E520E820F3F1F2E0EDEEE2EAE020F0E5E7EEEDE0EDF1ED
      EEE920F7E0F1F2EEF2FB010D0A4944535F3001546F6F6C7301C8EDF1F2F0F3EC
      E5EDF2FB010D0A4944535F31300141646401C4EEE1E0E2E8F2FC010D0A494453
      5F31310144656C65746501D3E4E0EBE8F2FC010D0A4944535F31330144656C65
      746520416C6C01D3E4E0EBE8F2FC20E2F1E5010D0A4944535F31380143757273
      6F7201CAF3F0F1EEF0010D0A4944535F31390153657420437572736F7201D3F1
      F2E0EDEEE2E8F2FC20EAF3F0F1EEF0010D0A4944535F31015361766520746F20
      626D702066696C6501D1EEF5F0E0EDE8F2FC20EAE0EA20626D7020F4E0E9EB01
      0D0A4944535F32300144656C65746520437572736F7201D3E4E0EBE8F2FC20EA
      F3F0F1EEF0010D0A4944535F323501526573756C7401D0E5E7F3EBFCF2E0F201
      0D0A4944535F32360153686F7720526573756C7401CFEEEAE0E7E0F2FC20F0E5
      E7F3EBFCF2E0F2010D0A4944535F3237014869646520526573756C7401D1EFF0
      FFF2E0F2FC20F0E5E7F3EBFCF2E0F2010D0A4944535F3201416E616C79736973
      01C0EDE0EBE8E7010D0A4944535F33014C696E656172697A6174696F6E205801
      010D0A4944535F3401416464204C6162656C01010D0A4944535F353301437572
      736F723A01010D0A4944535F353801506F696E7473204E756D62657201010D0A
      4944535F35015361766501010D0A4944535F3630014C696E656172697A617469
      6F6E204461746501010D0A4944535F3631016572726F7220777269746520666C
      61736801010D0A4944535F363301477269642043656C6C2053697A6501010D0A
      4944535F36350153656E736974697601010D0A4944535F36014C696E65617269
      7A6174696F6E205901010D0A4944535F37370146696E64204C696E6501010D0A
      4944535F373801416374697661746501010D0A4944535F373901446541637469
      7661746501010D0A4944535F3833014672657175656E6379203D01D7E0F1F2EE
      F2E03D010D0A4944535F38360150726F6265204F7363696C6C6174696F6E2041
      6D706C6974756465205601C0EFEBE8F2F3E4E020EAEEEBE5E1E0EDE8E920E7EE
      EDE4E028C22920203D010D0A4944535F39330120206176657261676501010D0A
      4944535F393401416D706C6974756465207375707072657373696F6E3D200101
      0D0A4944535F39350143757272656E74203D2001010D0A4944535F39014C6162
      656C7301010D0A7374727374727230015072696E746572206973206E6F742063
      6F6E6E65637465642E202001CFF0E8EDF2E5F020EDE520EFEEE4F1EEE5E4E8ED
      E5ED010D0A4944535F3238014368616E6E656C20646174613B20456C656D656E
      74733D01EAE0EDE0EB20446174613B20FDEBE5ECE5EDF2EEE23D010D0A494453
      5F33330173697A653D01F0E0E7ECE5F03D010D0A4944535F3334016572726F72
      206368616E6E656C20706172616D7301EEF8E8E1EAE020F1EEE7E4E0EDE8FF20
      EAE0EDE0EBE020506172616D73010D0A4944535F3335016572726F7220676574
      20636F756E742001EEF8E8E1EAE020EFEEEBF3F7E5EDE8FF20F0E0E7ECE5F0E0
      20EAE0EDE0EBE0010D0A4944535F3336016572726F722072656164206368616E
      6E656C2001EEF8E8E1EAE020F7F2E5EDE8FF20EAE0EDE0EBE0010D0A4944535F
      33380172657320647261772001EDE0F7E0EBEE20F0E8F1EEE2E0EDE8FF010D0A
      4944535F333901656E64207265736F6E616E63652064726177696E6701EAEEED
      E5F620F0E8F1EEE2E0EDE8FF010D0A4944535F37015374617274207265736F6E
      616E63652064726177696E6701EDE0F7E0EBEE20F0E8F1EEE2E0EDE8FF010D0A
      4944535F38016572726F7220726561642067656F6D6574727901EEF8E8E1EAE0
      20F7F2E5EDE8FF20E3E5EEECE5F2F0E8E820EAE0EDE0EBE0010D0A73744F7468
      6572537472696E67730D0A544175746F5265736F6E616E63652E48656C704669
      6C650101010D0A436F6D626F426F7846515F53456C2E546578740101010D0A43
      6F7079536176654469616C6F672E46696C7465720101010D0A436F7079536176
      654469616C6F672E5469746C650101010D0A7374436F6C6C656374696F6E730D
      0A737443686172536574730D0A544175746F5265736F6E616E63650152555353
      49414E5F43484152534554015255535349414E5F43484152534554010D0A5265
      67696D65015255535349414E5F43484152534554015255535349414E5F434841
      52534554010D0A4C6162656C31015255535349414E5F43484152534554015255
      535349414E5F43484152534554010D0A72674D616E75616C015255535349414E
      5F43484152534554015255535349414E5F43484152534554010D0A4C6162656C
      34015255535349414E5F43484152534554015255535349414E5F434841525345
      54010D0A4C6162656C33015255535349414E5F43484152534554015255535349
      414E5F43484152534554010D0A4C6162656C35015255535349414E5F43484152
      534554015255535349414E5F43484152534554010D0A546F6F6C426172436F6E
      74726F6C015255535349414E5F43484152534554015255535349414E5F434841
      52534554010D0A}
  end
  object ImageListdis: TImageList
    Height = 32
    Width = 32
    Left = 312
    Top = 264
  end
  object CopySaveDialog: TSaveDialog
    Left = 272
    Top = 216
  end
end
