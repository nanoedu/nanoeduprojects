object ViewConfigFile: TViewConfigFile
  Left = 303
  Top = 160
  Caption = 'View Nanoeducator Config File'
  ClientHeight = 613
  ClientWidth = 603
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 603
    Height = 613
    Align = alClient
    TabOrder = 0
    object MemoFileConfig: TMemo
      Left = 1
      Top = 1
      Width = 601
      Height = 611
      Align = alClient
      Lines.Strings = (
        'MemoFileConfig')
      ScrollBars = ssVertical
      TabOrder = 0
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
    Left = 264
    Top = 360
    TranslationData = {
      737443617074696F6E730D0A5456696577436F6E66696746696C650156696577
      204E616E6F6564756361746F7220436F6E6669672046696C6501CFF0EEF1ECEE
      F2F020F4E0E9EBE020EAEEEDF4E8E3F3F0E0F6E8E8010D0A50616E656C310101
      010D0A737448696E74730D0A5456696577436F6E66696746696C650101010D0A
      50616E656C310101010D0A4D656D6F46696C65436F6E6669670101010D0A7374
      446973706C61794C6162656C730D0A7374466F6E74730D0A5456696577436F6E
      66696746696C65014D532053616E7320536572696601417269616C010D0A7374
      4D756C74694C696E65730D0A4D656D6F46696C65436F6E6669672E4C696E6573
      014D656D6F46696C65436F6E66696701010D0A7374537472696E67730D0A7374
      72737472766331014E6F20436F6E6669672020496E692046696C652001CDE5F2
      20F4E0E9EBE020EAEEEDF4E8E3F3F0E0F6E8E8010D0A73747273747276633201
      2E2050726F6772616D2077696C6C206265207465726D696E617465642121012E
      20CFF0EEE3F0E0ECECE020E1F3E4E5F220EEF1F2E0EDEEE2EBE5EDE0010D0A73
      744F74686572537472696E67730D0A5456696577436F6E66696746696C652E48
      656C7046696C650101010D0A7374436F6C6C656374696F6E730D0A7374436861
      72536574730D0A5456696577436F6E66696746696C650144454641554C545F43
      484152534554015255535349414E5F43484152534554010D0A}
  end
end
