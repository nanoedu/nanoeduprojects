object SetSignal: TSetSignal
  Left = 371
  Top = 204
  BorderStyle = bsDialog
  ClientHeight = 61
  ClientWidth = 254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBar1: TScrollBar
    Left = 19
    Top = 13
    Width = 215
    Height = 13
    Min = -100
    PageSize = 0
    TabOrder = 0
    OnScroll = ScrollBar1Scroll
  end
  object IndValue: TLabeledEdit
    Left = 93
    Top = 34
    Width = 61
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = 'IndValue'
    LabelPosition = lpRight
    TabOrder = 1
    OnChange = IndValueChange
    OnEnter = IndValueEnter
    OnExit = IndValueExit
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
    Left = 8
    Top = 32
    TranslationData = {
      737443617074696F6E730D0A737448696E74730D0A7374446973706C61794C61
      62656C730D0A7374466F6E74730D0A545365745369676E616C014D532053616E
      73205365726966015461686F6D610D0A73744D756C74694C696E65730D0A7374
      537472696E67730D0A4944535F30014761696E5F464D01D3F1E8EBE5EDE8E520
      D4CC010D0A4944535F3101206E410120EDC0010D0A4944535F34015365742050
      6F696E7401D0E0E1EEF7E5E520E7EDE0F7E5EDE8E5010D0A4944535F35012020
      56012020C2010D0A4944535F36014269617320566F6C7461676501CDE0EFF0FF
      E6E5EDE8E5010D0A4944535F37014572726F722121204C6576656C4954203D01
      CEF8E8E1EAE02120CFEEF0EEE320F2EEEAE03D010D0A4944535F38013E205365
      74506F696E74202121013E20D0E0E1EEF7E5E3EE20F2EEEAE021010D0A494453
      5F3901204F70656E20746865204F7074696F6E732057696E646F7720616E6420
      6368616E6765204C6576656C495420696620596F75206E6565642E01CEF2EAF0
      EEE9F2E520EEEAEDEE20CFE0F0E0ECE5F2F0FB20E820E8E7ECE5EDE8F2E520EF
      EEF0EEE320F2EEEAE02C20E5F1EBE820EDE5EEE1F5EEE4E8ECEE2E010D0A7374
      4F74686572537472696E67730D0A7374436F6C6C656374696F6E730D0A737443
      686172536574730D0A545365745369676E616C0144454641554C545F43484152
      534554015255535349414E5F434841525345540D0A}
  end
end
