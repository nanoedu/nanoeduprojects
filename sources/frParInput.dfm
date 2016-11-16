object FrameParInput: TFrameParInput
  Left = 0
  Top = 0
  Width = 200
  Height = 88
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
  object frPanel: TPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 81
    Color = 14474715
    TabOrder = 0
    object LabelFrm: TLabel
      Left = 72
      Top = 0
      Width = 43
      Height = 13
      Caption = 'LabelFrm'
    end
    object LabelUnit: TLabel
      Left = 153
      Top = 28
      Width = 40
      Height = 13
      Caption = 'labelunit'
    end
    object BitBtnFrm: TBitBtn
      Left = 8
      Top = 24
      Width = 73
      Height = 25
      Caption = 'BitBtnFrm'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtnFrmClick
    end
    object EditFrm: TEdit
      Left = 88
      Top = 24
      Width = 49
      Height = 21
      TabOrder = 1
      OnChange = EditFrmChange
      OnKeyPress = EditFrmKeyPress
    end
    object ScrollBarFrm: TScrollBar
      Left = 8
      Top = 56
      Width = 121
      Height = 17
      PageSize = 0
      TabOrder = 2
      OnScroll = ScrollBarFrmScroll
    end
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
    Left = 160
    Top = 40
    TranslationData = {
      737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
      014C6162656C46726D01EBE5E9E1E5EB010D0A4C6162656C556E6974016C6162
      656C756E697401010D0A42697442746E46726D0142697442746E46726D01010D
      0A737448696E74730D0A544672616D65506172496E70757401010D0A66725061
      6E656C0101010D0A4C6162656C46726D0101010D0A4C6162656C556E69740101
      010D0A42697442746E46726D0101010D0A4564697446726D0101010D0A536372
      6F6C6C42617246726D0101010D0A7374446973706C61794C6162656C730D0A73
      74466F6E74730D0A544672616D65506172496E7075740144656661756C740144
      656661756C74010D0A42697442746E46726D0144656661756C74014465666175
      6C74010D0A73744D756C74694C696E65730D0A7374537472696E67730D0A7374
      4F74686572537472696E67730D0A4564697446726D2E546578740101010D0A73
      74436F6C6C656374696F6E730D0A737443686172536574730D0A544672616D65
      506172496E7075740144454641554C545F43484152534554015255535349414E
      5F43484152534554010D0A42697442746E46726D0144454641554C545F434841
      52534554015255535349414E5F43484152534554010D0A}
  end
end
