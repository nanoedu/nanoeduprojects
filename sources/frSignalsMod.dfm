object SignalsMod: TSignalsMod
  Left = 0
  Top = 0
  Width = 233
  Height = 212
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  TabStop = True
  object Panel3: TPanel
    Left = 19
    Top = 131
    Width = 211
    Height = 75
    BevelOuter = bvNone
    BorderWidth = 2
    BorderStyle = bsSingle
    Color = clSilver
    ParentBackground = False
    TabOrder = 1
    object Label3: TLabel
      Left = 52
      Top = 4
      Width = 85
      Height = 16
      Caption = '          FB Gain'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 28
      Width = 22
      Height = 16
      Caption = 'min'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 177
      Top = 27
      Width = 26
      Height = 16
      Caption = 'max'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelFB: TLabel
      Left = 80
      Top = 24
      Width = 48
      Height = 16
      Caption = 'LabelFB'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SpeedBtnFineTi: TSpeedButton
      Left = 7
      Top = 6
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 1
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
      OnClick = SpeedBtnFineTiClick
    end
    object sbTi: TScrollBar
      Left = 8
      Top = 46
      Width = 193
      Height = 17
      Max = 1000
      PageSize = 0
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnScroll = sbTiScroll
    end
  end
  object PageControl1: TPageControl
    Left = 16
    Top = 2
    Width = 201
    Height = 127
    ActivePage = tbSFM
    Style = tsFlatButtons
    TabHeight = 1
    TabOrder = 0
    TabWidth = 35
    object tbSFM: TTabSheet
      Caption = 'SFM'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 193
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 2
        BorderStyle = bsSingle
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        object LbSuppress: TLabel
          Left = 73
          Top = 30
          Width = 4
          Height = 16
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Button1: TButton
          Left = 21
          Top = 5
          Width = 131
          Height = 23
          Hint = 'Force Interaction Adjustment'
          Caption = 'Set Interaction '
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = BtnSetInterClick
        end
      end
      object PanelGain: TPanel
        Left = 0
        Top = 57
        Width = 193
        Height = 59
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 2
        BorderStyle = bsSingle
        Color = clSilver
        ParentBackground = False
        TabOrder = 1
        Visible = False
        object Label2: TLabel
          Left = 48
          Top = 8
          Width = 56
          Height = 16
          Caption = 'GAIN_FM'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object GainFMBtn: TButton
          Left = 16
          Top = 24
          Width = 145
          Height = 25
          TabOrder = 0
          Visible = False
          OnClick = GainFMBtnClick
        end
      end
    end
    object tbSTM: TTabSheet
      Caption = 'STM'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 193
        Height = 65
        Align = alTop
        BevelInner = bvLowered
        Color = clSilver
        TabOrder = 0
        object Label1: TLabel
          Left = 24
          Top = 8
          Width = 164
          Height = 16
          Caption = 'Set Point: Tunnel Current'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnSetPoint: TButton
          Left = 31
          Top = 24
          Width = 133
          Height = 25
          TabOrder = 0
          OnClick = btnSetPointClick
        end
      end
      object PanelBias: TPanel
        Left = 0
        Top = 65
        Width = 193
        Height = 51
        Align = alClient
        BevelInner = bvLowered
        Color = clSilver
        TabOrder = 1
        object Label4: TLabel
          Left = 54
          Top = 8
          Width = 80
          Height = 16
          Caption = 'Bias Voltage'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object BtnBiasV: TBitBtn
          Left = 38
          Top = 23
          Width = 110
          Height = 25
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnBiasVClick
        end
      end
    end
    object tbSFMCUR: TTabSheet
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImageIndex = 2
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 193
        Height = 57
        Align = alTop
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        object LbSuppressI: TLabel
          Left = 86
          Top = 39
          Width = 4
          Height = 16
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Button2: TButton
          Left = 37
          Top = 8
          Width = 121
          Height = 25
          Caption = 'Set Interaction'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = BtnSetInterClick
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 57
        Width = 193
        Height = 59
        Align = alClient
        Color = clSilver
        ParentBackground = False
        TabOrder = 1
        object Label7: TLabel
          Left = 51
          Top = 8
          Width = 80
          Height = 16
          Caption = 'Bias Voltage'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object BtnBiasSFM: TBitBtn
          Left = 37
          Top = 24
          Width = 109
          Height = 25
          Caption = 'BtnBiasSFM'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnBiasVClick
        end
      end
    end
  end
  object siLangLinkedf1: TsiLangLinked
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
    Left = 168
    Top = 88
    TranslationData = {
      737443617074696F6E730D0A4C6162656C330120202020202020202020464220
      4761696E0120504944205469010D0A4C6162656C35016D696E01010D0A4C6162
      656C36016D617801010D0A746253464D0153464D01010D0A427574746F6E3101
      53657420496E746572616374696F6E2001010D0A4C6162656C32014741494E5F
      464D01010D0A746253544D0153544D01010D0A4C6162656C310153657420506F
      696E743A2054756E6E656C2043757272656E7401010D0A4C6162656C34014269
      617320566F6C7461676501010D0A427574746F6E320153657420496E74657261
      6374696F6E01010D0A4C6162656C37014269617320566F6C7461676501010D0A
      42746E4269617353464D0142746E4269617353464D01010D0A4C6162656C4642
      014C6162656C464201010D0A526F7567683101526F75676801010D0A46696E65
      310146696E6501010D0A737448696E74730D0A545369676E616C734D6F640101
      0D0A50616E656C3301010D0A4C6162656C3301010D0A4C6162656C3501010D0A
      4C6162656C3601010D0A50616765436F6E74726F6C3101010D0A746253464D01
      010D0A50616E656C3101010D0A4C62537570707265737301010D0A427574746F
      6E3101466F72636520496E746572616374696F6E2041646A7573746D656E7401
      0D0A50616E656C4761696E01010D0A4C6162656C3201010D0A4761696E464D42
      746E01010D0A746253544D01010D0A50616E656C3401010D0A4C6162656C3101
      010D0A62746E536574506F696E7401010D0A50616E656C4269617301010D0A4C
      6162656C3401010D0A42746E426961735601010D0A746253464D43555201010D
      0A50616E656C3601010D0A427574746F6E3201010D0A50616E656C3701010D0A
      4C6162656C3701010D0A42746E4269617353464D01010D0A7374446973706C61
      794C6162656C730D0A7374466F6E74730D0A545369676E616C734D6F64015461
      686F6D610144656661756C74010D0A4C6162656C330144656661756C74014465
      6661756C74010D0A4C6162656C350144656661756C740144656661756C74010D
      0A4C6162656C360144656661756C740144656661756C74010D0A4C6253757070
      726573730144656661756C740144656661756C74010D0A427574746F6E310144
      656661756C740144656661756C74010D0A4C6162656C320144656661756C7401
      44656661756C74010D0A4C6162656C310144656661756C740144656661756C74
      010D0A4C6162656C340144656661756C740144656661756C74010D0A42746E42
      696173560144656661756C740144656661756C74010D0A427574746F6E320144
      656661756C740144656661756C74010D0A4C6162656C370144656661756C7401
      44656661756C74010D0A42746E4269617353464D0144656661756C7401446566
      61756C74010D0A4C625375707072657373490144656661756C74014465666175
      6C74010D0A746253464D43555201417269616C014D532053616E732053657269
      66010D0A4C6162656C4642015461686F6D61015461686F6D61010D0A73744D75
      6C74694C696E65730D0A7374537472696E67730D0A4944535F3301496E637265
      617365204D6178696D756D2076616C7565206F66207468652063757272656E74
      2020696E64696361746F722101D3E2E5EBE8F7FCF2E520CCE0EAF1202E20E7ED
      E0F7E5EDE8E520E8EDE4E8EAE0F2EEF0E020F2EEEAE0010D0A73744F74686572
      537472696E67730D0A7374436F6C6C656374696F6E730D0A7374436861725365
      74730D0A545369676E616C734D6F64015255535349414E5F4348415253455401
      5255535349414E5F434841525345540D0A4C6162656C33015255535349414E5F
      43484152534554015255535349414E5F434841525345540D0A4C6162656C3501
      5255535349414E5F43484152534554015255535349414E5F434841525345540D
      0A4C6162656C36015255535349414E5F43484152534554015255535349414E5F
      434841525345540D0A4C625375707072657373015255535349414E5F43484152
      534554015255535349414E5F434841525345540D0A427574746F6E3101525553
      5349414E5F43484152534554015255535349414E5F434841525345540D0A4C61
      62656C32015255535349414E5F43484152534554015255535349414E5F434841
      525345540D0A4C6162656C31015255535349414E5F4348415253455401525553
      5349414E5F434841525345540D0A4C6162656C34015255535349414E5F434841
      52534554015255535349414E5F434841525345540D0A42746E42696173560152
      55535349414E5F43484152534554015255535349414E5F434841525345540D0A
      427574746F6E32015255535349414E5F43484152534554015255535349414E5F
      434841525345540D0A4C6162656C37015255535349414E5F4348415253455401
      5255535349414E5F434841525345540D0A42746E4269617353464D0152555353
      49414E5F43484152534554015255535349414E5F434841525345540D0A4C6253
      7570707265737349015255535349414E5F43484152534554015255535349414E
      5F43484152534554010D0A746253464D4355520144454641554C545F43484152
      534554015255535349414E5F43484152534554010D0A4C6162656C4642015255
      535349414E5F43484152534554015255535349414E5F43484152534554010D0A}
  end
  object PopupMenu1: TPopupMenu
    Left = 144
    Top = 48
    object Rough1: TMenuItem
      Caption = 'Rough'
      OnClick = Rough1Click
    end
    object Fine1: TMenuItem
      Caption = 'Fine'
      OnClick = Fine1Click
    end
  end
  object ImageList1: TImageList
    Left = 24
    Top = 32
  end
end
