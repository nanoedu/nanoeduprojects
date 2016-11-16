object Progress: TProgress
  Left = 282
  Top = 204
  BorderIcons = []
  ClientHeight = 25
  ClientWidth = 486
  Color = clWhite
  Enabled = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar: TProgressBar
    Left = 0
    Top = 0
    Width = 486
    Height = 25
    Align = alClient
    Smooth = True
    TabOrder = 0
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
    Left = 264
    TranslationData = {
      737443617074696F6E730D0A737448696E74730D0A5450726F67726573730101
      0D0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A5450726F
      6772657373014D532053616E73205365726966015461686F6D61010D0A73744D
      756C74694C696E65730D0A7374537472696E67730D0A4944535F300143616C69
      62726174696F6E204C696E6501CAE0EBE8E1F0EEE2EEF7EDE0FF20EBE8EDE8FF
      010D0A4944535F310143616C6962726174696F6E204C696E653B204949205061
      737301CAE0EBE8E1F0EEE2EEF7EDE0FF20EBE8EDE87A20494920EFF0EEF5EEE4
      010D0A4944535F3201506C656173652C2077616974207768696C65207363616E
      6E6572206D6F76657320746F2074686520737461727420706F696E7401CFEEE4
      EEE6E4E8F2E520EFEEEAE020F1EAE0EDE5F020EFE5F0E5ECE5F1F2E8F2F1FF20
      20E220EDE0F7E0EBFCEDF3FE20F2EEF7EAF32E010D0A73744F74686572537472
      696E67730D0A7374436F6C6C656374696F6E730D0A737443686172536574730D
      0A5450726F67726573730144454641554C545F43484152534554015255535349
      414E5F43484152534554010D0A}
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 344
  end
end
