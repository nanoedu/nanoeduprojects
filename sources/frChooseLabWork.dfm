object Chooselabwork: TChooselabwork
  Left = 570
  Top = 138
  Caption = 'Choose  Lab'
  ClientHeight = 466
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 609
    Height = 466
    Align = alClient
    TabOrder = 0
    object LabelNAME: TLabel
      Left = 32
      Top = 32
      Width = 67
      Height = 13
      Caption = 'LabelNAME'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 128
      Top = 64
      Width = 80
      Height = 16
      Caption = 'Choose lab'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ListBoxLab: TListBox
      Left = 32
      Top = 96
      Width = 337
      Height = 345
      ItemHeight = 13
      Items.Strings = (
        'test'
        'test2'
        'test3')
      TabOrder = 0
      OnClick = ListBoxLabClick
    end
    object BitBtnOK: TBitBtn
      Left = 416
      Top = 424
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = BitBtnOKClick
    end
    object BitBtnCancel: TBitBtn
      Left = 515
      Top = 422
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
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
    Left = 432
    Top = 360
    TranslationData = {
      737443617074696F6E730D0A5443686F6F73656C6162776F726B0143686F6F73
      6520204C616201C2FBE1EEF020EBE0E1EEF0E0F2EEF0EDEEE920F0E0E1EEF2FB
      010D0A50616E656C310101010D0A4C6162656C4E414D45014C6162656C4E414D
      4501010D0A4C6162656C320143686F6F7365206C616201C2FBE1E5F0E8F2E520
      EBE0E12E20F0E0E1EEF2FB010D0A42697442746E4F4B014F4B01C4C0010D0A42
      697442746E43616E63656C0143616E63656C01CEF2ECE5EDE0010D0A73744869
      6E74730D0A5443686F6F73656C6162776F726B01010D0A50616E656C31010101
      0D0A4C6162656C4E414D450101010D0A4C6162656C320101010D0A4C69737442
      6F784C61620101010D0A42697442746E4F4B0101010D0A42697442746E43616E
      63656C0101010D0A7374446973706C61794C6162656C730D0A7374466F6E7473
      0D0A5443686F6F73656C6162776F726B014D532053616E732053657269660154
      61686F6D61010D0A4C6162656C4E414D45014D532053616E7320536572696601
      5461686F6D61010D0A4C6162656C32014D532053616E73205365726966015461
      686F6D61010D0A73744D756C74694C696E65730D0A4C697374426F784C61622E
      4974656D7301746573742C74657374322C746573743301010D0A737453747269
      6E67730D0A73744F74686572537472696E67730D0A5443686F6F73656C616277
      6F726B2E48656C7046696C650101010D0A7374436F6C6C656374696F6E730D0A
      737443686172536574730D0A5443686F6F73656C6162776F726B014445464155
      4C545F43484152534554015255535349414E5F43484152534554010D0A4C6162
      656C4E414D450144454641554C545F43484152534554015255535349414E5F43
      484152534554010D0A4C6162656C320144454641554C545F4348415253455401
      5255535349414E5F43484152534554010D0A}
  end
end
