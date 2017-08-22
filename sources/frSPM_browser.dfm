object frSPMView: TfrSPMView
  Left = 573
  Top = 340
  BorderIcons = [biSystemMenu]
  Caption = 'Work Directory'
  ClientHeight = 527
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'default'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter_View: TSplitter
    Left = 238
    Top = 0
    Height = 527
  end
  object Panel_find: TPanel
    Left = 0
    Top = 0
    Width = 238
    Height = 527
    Align = alLeft
    BevelOuter = bvNone
    Color = 14474715
    ParentBackground = False
    TabOrder = 0
    object Splitter_file: TSplitter
      Left = 0
      Top = 524
      Width = 238
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
  end
  object Panel_file: TPanel
    Left = 241
    Top = 0
    Width = 509
    Height = 527
    Align = alClient
    Caption = 'Panel_file'
    Color = 14474715
    TabOrder = 1
    OnResize = Panel_FileResize
    object lb_preview_active: TListBox
      Left = 72
      Top = 319
      Width = 228
      Height = 143
      ItemHeight = 13
      TabOrder = 0
      OnEnter = lb_preview_activeEnter
      OnExit = lb_preview_activeExit
      OnKeyDown = lb_preview_activeKeyDown
    end
    object NTShellListView: TNTShellListView
      Left = 81
      Top = 115
      Width = 185
      Height = 185
      ObjectTypes = [otNonFolders]
      Root = 'rfDesktop'
      Sorted = True
      ReadOnly = False
      HideSelection = False
      OnChange = NTShellListViewChange
      TabOrder = 1
      Visible = False
      FileMasks.Strings = (
        '*.spm'
        '*.mspm')
      ExecutableFiles = False
    end
    object ToolBarBrowser: TToolBar
      Left = 1
      Top = 1
      Width = 507
      Height = 40
      ButtonHeight = 34
      ButtonWidth = 41
      DrawingStyle = dsGradient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'default'
      Font.Style = []
      Images = Main.ImageListMainTools
      ParentFont = False
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 2
      object ToolBtnSaveAs: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = 'Save as'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolBtnSaveAsClick
      end
      object ToolBtnDel: TToolButton
        Left = 45
        Top = 0
        Hint = 'Delete Active'
        AutoSize = True
        Caption = 'Delete'
        ImageIndex = 17
        OnClick = ToolBtnDelClick
      end
    end
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
    ExtendedTranslations = <
      item
        Identifier = 'ToolBarBrowser.Font.Height'
        PropertyType = tkInteger
        ValuesEx = {2D390101}
      end>
    Left = 184
    Top = 240
    TranslationData = {
      737443617074696F6E730D0A54667253504D5669657701576F726B2044697265
      63746F727901D1EAE0ED20E1F0E0F3E7E5F0010D0A50616E656C5F66696C6501
      50616E656C5F66696C6501010D0A546F6F6C42746E5361766541730153617665
      20617301D1EEF5F0E0EDE8F2FC20EAE0EA010D0A546F6F6C42746E44656C0144
      656C65746501D3E4E0EBE8F2FC010D0A737448696E74730D0A546F6F6C42746E
      44656C0144656C6574652041637469766501D3E4E0EBE8F2FC20E0EAF2E8E2ED
      FBE920F1EAE0ED010D0A7374446973706C61794C6162656C730D0A7374466F6E
      74730D0A54667253504D566965770164656661756C740164656661756C74010D
      0A546F6F6C42617242726F777365720164656661756C740164656661756C7401
      0D0A73744D756C74694C696E65730D0A4E545368656C6C4C697374566965772E
      46696C654D61736B73012A2E73706D2C2A2E6D73706D01010D0A737453747269
      6E67730D0A4944535F30015363616E732062726F7773657201C1F0E0F3E7E5F0
      20D1EAE0EDEEE2010D0A4944535F3101576F726B206469726563746F727901D0
      E0E1EEF7E0FF20EFE0EFEAE0010D0A4944535F3401446F20796F75207265616C
      6C792077616E7420746F2064656C65746520207363616E2001C2FB20E4E5E9F1
      F2E2E8F2E5EBFCEDEE20F5EEF2E8F2E520F3E4E0EBE8F2FC20F1EAE0ED20010D
      0A73744F74686572537472696E67730D0A4E545368656C6C4C69737456696577
      2E526F6F740172664465736B746F7001010D0A7374436F6C6C656374696F6E73
      0D0A737443686172536574730D0A54667253504D566965770144454641554C54
      5F43484152534554015255535349414E5F43484152534554010D0A546F6F6C42
      617242726F777365720144454641554C545F4348415253455401525553534941
      4E5F43484152534554010D0A}
  end
  object siSaveDialog: TSaveDialog
    Left = 104
    Top = 184
  end
end
