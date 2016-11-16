object Inform: TInform
  Left = 217
  Top = 283
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Warning!!'
  ClientHeight = 64
  ClientWidth = 424
  Color = clBtnFace
  Enabled = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Labelinf: TLabel
    Left = 0
    Top = 0
    Width = 424
    Height = 64
    Align = alClient
    Alignment = taCenter
    Caption = 'Please, wait while the probe is rising to the start position!!!'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    ExplicitWidth = 270
    ExplicitHeight = 13
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
    Left = 184
    Top = 16
    TranslationData = {
      737443617074696F6E730D0A54496E666F726D015761726E696E67212101CFF0
      E5E4F3EFF0E5E6E4E5EDE8E521010D0A4C6162656C696E6601506C656173652C
      2077616974207768696C65207468652070726F626520697320726973696E6720
      746F2074686520737461727420706F736974696F6E21212101CFEEE6E0EBF3E9
      F1F2E02C20EFEEE4EEE6E4E8F2E520EFEEEAE020E7EEEDE420EFEEE4EDE8ECE8
      F2F1FF20E220F1F2E0F0F2EEE2F3FE20EFEEE7E8F6E8FE2E010D0A737448696E
      74730D0A54496E666F726D01010D0A4C6162656C696E660101010D0A73744469
      73706C61794C6162656C730D0A7374466F6E74730D0A54496E666F726D014D53
      2053616E7320536572696601417269616C010D0A4C6162656C696E66014D5320
      53616E7320536572696601417269616C010D0A73744D756C74694C696E65730D
      0A7374537472696E67730D0A73744F74686572537472696E67730D0A54496E66
      6F726D2E48656C7046696C650101010D0A7374436F6C6C656374696F6E730D0A
      737443686172536574730D0A54496E666F726D0144454641554C545F43484152
      534554015255535349414E5F43484152534554010D0A4C6162656C696E660144
      454641554C545F43484152534554015255535349414E5F43484152534554010D
      0A}
  end
end
