object MemoScanner: TMemoScanner
  Left = 417
  Top = 163
  Caption = 'Scanner'
  ClientHeight = 537
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScannerMemo: TMemo
    Left = 0
    Top = 0
    Width = 610
    Height = 504
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object PanelBtn: TPanel
    Left = 0
    Top = 504
    Width = 610
    Height = 33
    Align = alBottom
    TabOrder = 1
    object BitBtnOK: TBitBtn
      Left = 24
      Top = 6
      Width = 61
      Height = 22
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      Visible = False
      OnClick = BitBtnOKClick
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 100
      Top = 6
      Width = 61
      Height = 22
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
      Visible = False
      OnClick = BitBtn2Click
      NumGlyphs = 2
    end
    object BitBtnPrint: TBitBtn
      Left = 175
      Top = 6
      Width = 61
      Height = 22
      Caption = '&Print'
      TabOrder = 2
      OnClick = BitBtnPrintClick
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
    Left = 184
    Top = 312
    TranslationData = {
      737443617074696F6E730D0A544D656D6F5363616E6E6572015363616E6E6572
      01D1EAE0EDE5F0010D0A50616E656C42746E0101010D0A42697442746E4F4B01
      264F4B0126CECA010D0A42697442746E32012643616E63656C01CE26F2ECE5ED
      E0010D0A42697442746E5072696E7401265072696E740126CFE5F7E0F2FC010D
      0A737448696E74730D0A544D656D6F5363616E6E65720101010D0A5363616E6E
      65724D656D6F0101010D0A50616E656C42746E0101010D0A42697442746E4F4B
      0101010D0A42697442746E320101010D0A42697442746E5072696E740101010D
      0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A544D656D6F
      5363616E6E6572014D532053616E7320536572696601417269616C010D0A7374
      4D756C74694C696E65730D0A5363616E6E65724D656D6F2E4C696E6573010101
      0D0A7374537472696E67730D0A7374727374726D31015072696E746572206973
      206E6F7420636F6E6E65637465642E202001CFF0E8EDF2E5F020EDE520EFEEE4
      F1EEE5E4E8EDE5ED2E010D0A7374727374726D32014E6F205363616E6E657220
      496E692046696C6501CDE5F2207363616E6E65722E696E6920F4E0E9EBE02001
      0D0A7374727374726D33012E2044656661756C7420496E692046696C65205573
      65642121012E20C8F1EFEEEBFCE7F3E5F2F1FF20F4E0E9EB2020EFEE20F3ECEE
      EBF7E0EDE8FE2E010D0A7374727374726D34014E6F2044656661756C74205363
      616E6E657220496E692046696C6501CDE5F2207363616E6E65722E696E6920F4
      E0E9EBE020EFEE20F3ECEEEBF7E0EDE8FE2E010D0A7374727374726D35012E20
      50726F6772616D205465726D696E617465642121012E20CFF0EEE3F0E0ECECE0
      20EEF1F2E0EDEEE2EBE5EDE021010D0A73744F74686572537472696E67730D0A
      544D656D6F5363616E6E65722E48656C7046696C650101010D0A7374436F6C6C
      656374696F6E730D0A737443686172536574730D0A544D656D6F5363616E6E65
      720144454641554C545F43484152534554015255535349414E5F434841525345
      54010D0A}
  end
end
