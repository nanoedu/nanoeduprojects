object ScaleGL: TScaleGL
  Left = 705
  Top = 206
  BorderIcons = [biSystemMenu]
  Caption = 'Z Scale'
  ClientHeight = 336
  ClientWidth = 140
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 23
    Top = 380
    Width = 52
    Height = 13
    Caption = 'Real Scale'
  end
  object Label2: TLabel
    Left = 16
    Top = 8
    Width = 44
    Height = 13
    Caption = 'Maximum'
  end
  object TrackBarSc: TTrackBar
    Left = 97
    Top = 0
    Width = 30
    Height = 393
    Max = 100
    Orientation = trVertical
    TabOrder = 0
    ThumbLength = 15
    TickStyle = tsNone
    OnChange = TrackBarScChange
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
    Left = 24
    Top = 192
    TranslationData = {
      737443617074696F6E730D0A545363616C65474C015A205363616C65015A20EC
      E0F1F8F2E0E1010D0A4C6162656C31015265616C205363616C6501D0E5E0EBFC
      EDFBE9010D0A4C6162656C32014D6178696D756D01CCE0EAF1E8ECF3EC010D0A
      737448696E74730D0A545363616C65474C01010D0A4C6162656C310101010D0A
      4C6162656C320101010D0A547261636B42617253630101010D0A737444697370
      6C61794C6162656C730D0A7374466F6E74730D0A545363616C65474C014D5320
      53616E73205365726966015461686F6D61010D0A73744D756C74694C696E6573
      0D0A7374537472696E67730D0A4944535F30014D696E696D756D01CCE8EDE8EC
      F3EC010D0A4944535F31015265616C205363616C6501D0E5E0EBFCEDFBE9010D
      0A73744F74686572537472696E67730D0A545363616C65474C2E48656C704669
      6C650101010D0A7374436F6C6C656374696F6E730D0A73744368617253657473
      0D0A545363616C65474C0144454641554C545F43484152534554015255535349
      414E5F43484152534554010D0A}
  end
end
