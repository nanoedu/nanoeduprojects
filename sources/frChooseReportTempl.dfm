object FormLabDlg: TFormLabDlg
  Left = 548
  Top = 137
  Caption = 'Choose Report Template'
  ClientHeight = 517
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 11
    Width = 108
    Height = 13
    Caption = 'Template Directory'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 328
    Top = 291
    Width = 102
    Height = 13
    Caption = 'Choosed template'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object FileListBox: TFileListBox
    Left = 280
    Top = 25
    Width = 201
    Height = 249
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentFont = False
    TabOrder = 0
    OnChange = FileListBoxChange
  end
  object CancelBitBtn: TBitBtn
    Left = 160
    Top = 361
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
    OnClick = CancelBitBtnClick
    NumGlyphs = 2
  end
  object OKBitBtn: TBitBtn
    Left = 14
    Top = 362
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = OKBitBtnClick
    NumGlyphs = 2
  end
  object EditFileName: TEdit
    Left = 268
    Top = 310
    Width = 250
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object DriveComboBox: TDriveComboBox
    Left = 26
    Top = 33
    Width = 118
    Height = 19
    DirList = DirListBox
    TabOrder = 4
  end
  object DirListBox: TDirectoryListBox
    Left = 26
    Top = 58
    Width = 131
    Height = 176
    FileList = FileListBox
    ItemHeight = 16
    TabOrder = 5
    OnChange = DirListBoxChange
  end
  object BitBtnDef: TBitBtn
    Left = 8
    Top = 257
    Width = 253
    Height = 31
    Caption = 'Set Default Directory'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = BitBtnDefClick
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
    Left = 320
    Top = 368
    TranslationData = {
      737443617074696F6E730D0A54466F726D4C6162446C670143686F6F73652052
      65706F72742054656D706C61746501C2FBE1F0E0F2FC20EEE1F0E0E7E5F620EE
      F2F7E5F2E0010D0A4C6162656C310154656D706C617465204469726563746F72
      7901C4E8F0E5EAF2EEF0E8E920EEE1F0E0E7F6EEE2010D0A43616E63656C4269
      7442746E0143616E63656C01CEF2ECE5EDE0010D0A4F4B42697442746E014F4B
      01C4E0010D0A42697442746E446566015365742044656661756C742044697265
      63746F727901D3F1F2E0EDEEE2E8F2FC20E4E8F0E5EAF2EEF0E8E920EFEE20F3
      ECEEEBF7E0EDE8FE010D0A4C6162656C320143686F6F7365642074656D706C61
      746501C2FBE1F0E0EDEDFBE920EEE1F0E0E7E5F6010D0A737448696E74730D0A
      54466F726D4C6162446C670101010D0A4C6162656C310101010D0A46696C654C
      697374426F780101010D0A43616E63656C42697442746E0101010D0A4F4B4269
      7442746E0101010D0A4564697446696C654E616D650101010D0A447269766543
      6F6D626F426F780101010D0A4469724C697374426F780101010D0A4269744274
      6E4465660101010D0A4C6162656C320101010D0A7374446973706C61794C6162
      656C730D0A7374466F6E74730D0A54466F726D4C6162446C67014D532053616E
      73205365726966015461686F6D61010D0A4C6162656C31014D532053616E7320
      5365726966015461686F6D61010D0A46696C654C697374426F78014D53205361
      6E73205365726966015461686F6D61010D0A43616E63656C42697442746E014D
      532053616E73205365726966015461686F6D61010D0A4F4B42697442746E014D
      532053616E73205365726966015461686F6D61010D0A4564697446696C654E61
      6D65014D532053616E73205365726966015461686F6D61010D0A42697442746E
      446566014D532053616E73205365726966015461686F6D61010D0A4C6162656C
      32014D532053616E73205365726966015461686F6D61010D0A73744D756C7469
      4C696E65730D0A7374537472696E67730D0A737472737472320143686F6F7365
      2074656D706C6174652066696C652E01C2FBE1E5F0E8F2E520EEE1F0E0E7E5F6
      20EEF2F7E5F2E02E010D0A73747273747231014469726563746F727920646F20
      6E6F742065786973747301CFE0EFEAE02020EDE520F1F3F9E5F1F2E2F3E5F22E
      010D0A73744F74686572537472696E67730D0A54466F726D4C6162446C672E48
      656C7046696C650101010D0A46696C654C697374426F782E4D61736B012A2E2A
      01010D0A4564697446696C654E616D652E546578740101010D0A7374436F6C6C
      656374696F6E730D0A737443686172536574730D0A54466F726D4C6162446C67
      0144454641554C545F43484152534554015255535349414E5F43484152534554
      010D0A4C6162656C310144454641554C545F4348415253455401525553534941
      4E5F43484152534554010D0A46696C654C697374426F780144454641554C545F
      43484152534554015255535349414E5F43484152534554010D0A43616E63656C
      42697442746E0144454641554C545F43484152534554015255535349414E5F43
      484152534554010D0A4F4B42697442746E0144454641554C545F434841525345
      54015255535349414E5F43484152534554010D0A4564697446696C654E616D65
      0144454641554C545F43484152534554015255535349414E5F43484152534554
      010D0A42697442746E4465660144454641554C545F4348415253455401525553
      5349414E5F43484152534554010D0A4C6162656C320144454641554C545F4348
      4152534554015255535349414E5F43484152534554010D0A}
  end
end
