object PaletteForm: TPaletteForm
  Left = 560
  Top = 169
  BorderIcons = [biSystemMenu]
  Caption = 'Geo Palette '
  ClientHeight = 523
  ClientWidth = 198
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 198
    Height = 523
    Align = alClient
    TabOrder = 0
    object PaletteFieldImg: TImage
      Left = 0
      Top = 0
      Width = 129
      Height = 225
      OnMouseDown = PaletteFieldImgMouseDown
      OnMouseMove = PaletteFieldImgMouseMove
      OnMouseUp = PaletteFieldImgMouseUp
    end
    object PanelImg: TPanel
      Left = 130
      Top = 2
      Width = 31
      Height = 221
      BevelInner = bvRaised
      TabOrder = 0
      object PaletteScaleImg: TImage
        Left = 2
        Top = 2
        Width = 27
        Height = 217
        Align = alClient
        ParentShowHint = False
        ShowHint = False
      end
    end
    object PanelB: TPanel
      Left = 0
      Top = 229
      Width = 195
      Height = 193
      TabOrder = 1
      object Label1: TLabel
        Left = 0
        Top = 1
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LblMax: TLabel
        Left = 123
        Top = 0
        Width = 8
        Height = 13
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ComboBoxPal: TComboBox
        Left = 24
        Top = 19
        Width = 117
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        Text = 'Brown'
        OnSelect = ComboBoxPalSelect
        Items.Strings = (
          'Grey'
          'Brown'
          'BlueToRed'
          'Zebra'
          'Color Zebra')
      end
      object BitBtnDef: TBitBtn
        Left = 2
        Top = 110
        Width = 191
        Height = 28
        Caption = 'Set  Current as Default'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = BitBtnDefClick
      end
      object BitBtnSave: TBitBtn
        Left = 3
        Top = 66
        Width = 185
        Height = 28
        Caption = 'Save Current Palette'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = BitBtnSaveClick
      end
      object BitBtnHelp: TBitBtn
        Left = 58
        Top = 154
        Width = 61
        Height = 24
        Caption = '&Help'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = BitBtnHelpClick
        NumGlyphs = 2
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
    Left = 96
    Top = 448
    TranslationData = {
      737443617074696F6E730D0A5450616C65747465466F726D0147656F2050616C
      657474652001C3C5CE20EFE0EBE8F2F0E0010D0A50616E656C310101010D0A50
      616E656C496D670101010D0A50616E656C420101010D0A4C6162656C31013001
      010D0A4C626C4D6178013101010D0A42697442746E4465660153657420204375
      7272656E742061732044656661756C7401D1E4E5EBE0F2FC20F2E5EAF3F9F3FE
      20EFEE20F3ECEEEBF7E0EDE8FE010D0A42697442746E53617665015361766520
      43757272656E742050616C6574746501D1EEF5F0E0EDE8F2FC20F2E5EAF3F9F3
      FE20EFE0EBE8F2F0F3010D0A42697442746E48656C70012648656C7001D126EF
      F0E0E2EAE0010D0A737448696E74730D0A5450616C65747465466F726D010101
      0D0A50616E656C310101010D0A50616C657474654669656C64496D670101010D
      0A50616E656C496D670101010D0A50616C657474655363616C65496D67010101
      0D0A50616E656C420101010D0A4C6162656C310101010D0A4C626C4D61780101
      010D0A436F6D626F426F7850616C0101010D0A42697442746E4465660101010D
      0A42697442746E536176650101010D0A42697442746E48656C700101010D0A73
      74446973706C61794C6162656C730D0A7374466F6E74730D0A5450616C657474
      65466F726D014D532053616E7320536572696601417269616C010D0A4C616265
      6C31014D532053616E7320536572696601417269616C010D0A4C626C4D617801
      4D532053616E7320536572696601417269616C010D0A436F6D626F426F785061
      6C014D532053616E7320536572696601417269616C010D0A42697442746E4465
      66014D532053616E7320536572696601417269616C010D0A42697442746E5361
      7665014D532053616E7320536572696601417269616C010D0A42697442746E48
      656C70014D532053616E7320536572696601417269616C010D0A73744D756C74
      694C696E65730D0A436F6D626F426F7850616C2E4974656D7301477265792C42
      726F776E2C426C7565546F5265642C5A656272612C22436F6C6F72205A656272
      612201010D0A7374537472696E67730D0A73747273747270310152656E616D65
      20616E642073617665206E65772050616C6574746501CFE5F0E5E8ECE5EDF3E9
      F2E520E820F1EEF5F0E0EDE8F2E520EDEEE2F3FE20EFE0EBE8F2F0F3010D0A73
      744F74686572537472696E67730D0A5450616C65747465466F726D2E48656C70
      46696C650101010D0A436F6D626F426F7850616C2E546578740142726F776E01
      010D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A5450
      616C65747465466F726D0144454641554C545F43484152534554015255535349
      414E5F43484152534554010D0A4C6162656C310144454641554C545F43484152
      534554015255535349414E5F43484152534554010D0A4C626C4D617801444546
      41554C545F43484152534554015255535349414E5F43484152534554010D0A43
      6F6D626F426F7850616C0144454641554C545F43484152534554015255535349
      414E5F43484152534554010D0A42697442746E4465660144454641554C545F43
      484152534554015255535349414E5F43484152534554010D0A42697442746E53
      6176650144454641554C545F43484152534554015255535349414E5F43484152
      534554010D0A42697442746E48656C700144454641554C545F43484152534554
      015255535349414E5F43484152534554010D0A}
  end
end
