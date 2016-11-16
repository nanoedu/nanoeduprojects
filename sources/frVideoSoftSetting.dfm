object VideoSoftSetting: TVideoSoftSetting
  Left = 0
  Top = 0
  Caption = 'Video Setting'
  ClientHeight = 411
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PanelPath: TPanel
    Left = 0
    Top = 57
    Width = 419
    Height = 319
    Align = alBottom
    TabOrder = 0
    Visible = False
    object LblPATH: TLabel
      Left = 30
      Top = 258
      Width = 39
      Height = 12
      Caption = 'LblPATH'
    end
    object Label1: TLabel
      Left = 30
      Top = 228
      Width = 173
      Height = 12
      Caption = 'Path to the firm videocamera software '
    end
    object NTShellTreeView: TNTShellTreeView
      Left = 0
      Top = 34
      Width = 281
      Height = 164
      ObjectTypes = [otFolders, otNonFolders]
      Root = 'rfDesktop'
      ShellComboBox = NTShellComboBox
      UseShellImages = True
      AutoRefresh = False
      Indent = 19
      RightClickSelect = True
      TabOrder = 0
      OnClick = NTShellTreeViewClick
      FileMask = '*.*'
    end
    object NTShellComboBox: TNTShellComboBox
      Left = 20
      Top = 6
      Width = 179
      Height = 22
      Root = 'rfDesktop'
      ShellTreeView = NTShellTreeView
      UseShellImages = True
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 376
    Width = 419
    Height = 35
    Align = alBottom
    TabOrder = 1
    object BitBtn2: TBitBtn
      Left = 258
      Top = 6
      Width = 56
      Height = 18
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = BitBtn2Click
    end
    object BitBtnOk: TBitBtn
      Left = 143
      Top = 6
      Width = 56
      Height = 18
      Caption = 'OK'
      TabOrder = 1
      OnClick = BitBtnOkClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 419
    Height = 57
    Align = alClient
    TabOrder = 2
    object CheckBox: TCheckBox
      Left = 60
      Top = 23
      Width = 301
      Height = 13
      Caption = 'Use firm videocamera software'
      TabOrder = 0
      OnClick = CheckBoxClick
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
    Left = 312
    Top = 304
    TranslationData = {
      737443617074696F6E730D0A54566964656F536F667453657474696E67015669
      64656F2053657474696E6701CDE0F1F2F0EEE9EAE820EFF0EEE3F0E0ECECFB20
      E4EBFF20E2E8E4E5EEEAE0ECE5F0FB010D0A4C626C50415448014C626C504154
      4801010D0A4C6162656C31015061746820746F20746865206669726D20766964
      656F63616D65726120736F6674776172652001CFF3F2FC20EA20F4E8F0ECE5ED
      EDEEE920EFF0EEE3F0E0ECECFB20E4EBFF20E2E8E4E5EEEAE0ECE5F0FB20010D
      0A42697442746E320143616E63656C01010D0A42697442746E4F6B014F4B0101
      0D0A436865636B426F7801557365206669726D20766964656F63616D65726120
      736F66747761726501C8F1EFEEEBFCE7EEE2E0F2FC20F4E8F0ECE5EDEDF3FE20
      EFF0EEE3F0E0ECECF320E4EBFF20E2E8E4E5EEEAE0ECE5F0FB20010D0A50616E
      656C506174680101010D0A50616E656C320101010D0A50616E656C330101010D
      0A737448696E74730D0A54566964656F536F667453657474696E6701010D0A50
      616E656C506174680101010D0A4C626C504154480101010D0A4C6162656C3101
      01010D0A4E545368656C6C54726565566965770101010D0A4E545368656C6C43
      6F6D626F426F780101010D0A50616E656C320101010D0A42697442746E320101
      010D0A42697442746E4F6B0101010D0A50616E656C330101010D0A436865636B
      426F780101010D0A7374446973706C61794C6162656C730D0A7374466F6E7473
      0D0A54566964656F536F667453657474696E67015461686F6D61015461686F6D
      61010D0A73744D756C74694C696E65730D0A7374537472696E67730D0A73744F
      74686572537472696E67730D0A4E545368656C6C54726565566965772E46696C
      654D61736B012A2E2A01010D0A4E545368656C6C54726565566965772E526F6F
      740172664465736B746F7001010D0A4E545368656C6C436F6D626F426F782E52
      6F6F740172664465736B746F7001010D0A54566964656F536F66745365747469
      6E672E48656C7046696C650101010D0A7374436F6C6C656374696F6E730D0A73
      7443686172536574730D0A54566964656F536F667453657474696E6701444546
      41554C545F43484152534554015255535349414E5F43484152534554010D0A}
  end
end
