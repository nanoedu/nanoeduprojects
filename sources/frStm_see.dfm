object frSPMView: TfrSPMView
  Left = 573
  Top = 340
  BorderIcons = [biSystemMenu]
  Caption = 'Scan browser'
  ClientHeight = 382
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter_view: TSplitter
    Left = 238
    Top = 0
    Width = 2
    Height = 382
    OnMoved = Splitter_viewMoved
  end
  object Panel_find: TPanel
    Left = 0
    Top = 0
    Width = 238
    Height = 382
    Align = alLeft
    BevelOuter = bvNone
    Color = 14474715
    TabOrder = 0
    object Splitter_file: TSplitter
      Left = 0
      Top = 381
      Width = 238
      Height = 1
      Cursor = crVSplit
      Align = alBottom
      OnMoved = Splitter_fileMoved
    end
    object stm_DirectoryListBox: TDirectoryListBox
      Left = 8
      Top = 43
      Width = 172
      Height = 113
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Color = clWhite
      FileList = stm_ListBox
      ItemHeight = 16
      TabOrder = 0
      OnChange = stm_DirectoryListBoxChange
      OnClick = stm_DirectoryListBoxClick
    end
    object stm_ListBox: TFileListBox
      Left = 16
      Top = 392
      Width = 145
      Height = 17
      ItemHeight = 13
      Mask = '*.mspm;*.spm'
      TabOrder = 1
      Visible = False
      OnChange = stm_ListBoxChange
    end
    object stm_filter: TFilterComboBox
      Left = 0
      Top = 200
      Width = 145
      Height = 21
      FileList = stm_ListBox
      Filter = 'Stm(*.stm)|*.stm;*.spm|Spm(*.spm)|*.spm|All files (*.*)|*.*'
      TabOrder = 2
      Visible = False
    end
    object stm_DriveComboBox: TDriveComboBox
      Left = 12
      Top = 16
      Width = 145
      Height = 19
      DirList = stm_DirectoryListBox
      TabOrder = 3
    end
  end
  object Panel_file: TPanel
    Left = 240
    Top = 0
    Width = 320
    Height = 382
    Align = alClient
    Caption = 'Panel_file'
    TabOrder = 1
    OnResize = Panel_FileResize
    object lb_preview_active: TListBox
      Left = 9
      Top = 16
      Width = 40
      Height = 81
      ItemHeight = 13
      TabOrder = 0
      OnEnter = lb_preview_activeEnter
      OnExit = lb_preview_activeExit
      OnKeyDown = lb_preview_activeKeyDown
    end
  end
  object siLangLinked1: TsiLangLinked
    Version = '6.1.0.1'
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
    Left = 112
    Top = 248
    TranslationData = {
      737443617074696F6E730D0A54667253504D56696577015363616E2062726F77
      73657201D1EAE0ED20E1F0E0F3E7E5F0010D0A50616E656C5F66696E64010101
      0D0A50616E656C5F66696C650150616E656C5F66696C6501010D0A737448696E
      74730D0A54667253504D566965770101010D0A53706C69747465725F76696577
      0101010D0A50616E656C5F66696E640101010D0A53706C69747465725F66696C
      650101010D0A73746D5F4469726563746F72794C697374426F780101010D0A73
      746D5F4C697374426F780101010D0A73746D5F66696C7465720101010D0A7374
      6D5F4472697665436F6D626F426F780101010D0A50616E656C5F66696C650101
      010D0A6C625F707265766965775F6163746976650101010D0A7374446973706C
      61794C6162656C730D0A7374466F6E74730D0A54667253504D56696577014D53
      2053616E7320536572696601417269616C010D0A73744D756C74694C696E6573
      0D0A6C625F707265766965775F6163746976652E4974656D730101010D0A7374
      537472696E67730D0A4944535F30015363616E732062726F7773657201C1F0E0
      F3E7E5F020D1EAE0EDEEE2010D0A4944535F3101576F726B206469726563746F
      727901D0E0E1EEF7E0FF20EFE0EFEAE0010D0A4944535F3401446F20796F7520
      7265616C6C792077616E7420746F2064656C65746520207363616E3F01C2FB20
      E4E5E9F1F2E2E8F2E5EBFCEDEE20F5EEF2E8F2E520F3E4E0EBE8F2FC20F1EAE0
      ED3F010D0A73744F74686572537472696E67730D0A54667253504D566965772E
      48656C7046696C650101010D0A73746D5F4C697374426F782E4D61736B012A2E
      6D73706D3B2A2E73706D01010D0A73746D5F66696C7465722E46696C74657201
      53746D282A2E73746D297C2A2E73746D3B2A2E73706D7C53706D282A2E73706D
      297C2A2E73706D7C416C6C2066696C657320282A2E2A297C2A2E2A01010D0A73
      74436F6C6C656374696F6E730D0A737443686172536574730D0A54667253504D
      566965770144454641554C545F43484152534554015255535349414E5F434841
      52534554010D0A}
  end
end
