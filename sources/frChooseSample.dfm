object ChooseSample: TChooseSample
  Left = 649
  Top = 190
  Caption = 'Choose a Sample'
  ClientHeight = 285
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 390
    Height = 285
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 40
      Width = 200
      Height = 16
      Caption = '     Choose a sample to study'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ComboBoxSample: TComboBox
      Left = 59
      Top = 104
      Width = 145
      Height = 21
      AutoDropDown = True
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        'cd_pits'
        'erythrocites'
        'latex'
        'grids'
        '')
    end
    object BitBtnOK: TBitBtn
      Left = 27
      Top = 224
      Width = 75
      Height = 25
      Caption = '&OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtnOKClick
    end
    object BitBtnCancel: TBitBtn
      Left = 141
      Top = 223
      Width = 81
      Height = 25
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtnCancelClick
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
    Left = 72
    Top = 176
    TranslationData = {
      737443617074696F6E730D0A5443686F6F736553616D706C650143686F6F7365
      20612053616D706C6501C2FBE1EEF020EEE1F0E0E7F6E0010D0A4C6162656C31
      01202020202043686F6F736520612073616D706C6520746F20737475647901C2
      FBE1E5F0E8F2E520EEE1F0E0E7E5F620E4EBFF20E8E7F3F7E5EDE8FF010D0A42
      697442746E4F4B01264F4B01264F4B010D0A42697442746E43616E63656C0143
      616E63656C01CEF2ECE5EDE0010D0A737448696E74730D0A5443686F6F736553
      616D706C6501010D0A7374446973706C61794C6162656C730D0A7374466F6E74
      730D0A5443686F6F736553616D706C65014D532053616E732053657269660154
      61686F6D61010D0A4C6162656C31014D532053616E7320536572696601546168
      6F6D61010D0A42697442746E4F4B014D532053616E7320536572696601546168
      6F6D61010D0A42697442746E43616E63656C014D532053616E73205365726966
      015461686F6D61010D0A73744D756C74694C696E65730D0A436F6D626F426F78
      53616D706C652E4974656D730163645F706974732C6572797468726F63697465
      732C6C617465782C67726964732C01010D0A7374537472696E67730D0A73744F
      74686572537472696E67730D0A7374436F6C6C656374696F6E730D0A73744368
      6172536574730D0A5443686F6F736553616D706C650144454641554C545F4348
      4152534554015255535349414E5F43484152534554010D0A4C6162656C310144
      454641554C545F43484152534554015255535349414E5F43484152534554010D
      0A42697442746E4F4B0144454641554C545F4348415253455401525553534941
      4E5F43484152534554010D0A42697442746E43616E63656C0144454641554C54
      5F43484152534554015255535349414E5F43484152534554010D0A}
  end
end
