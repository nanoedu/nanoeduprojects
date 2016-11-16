object ChangeDir: TChangeDir
  Left = 605
  Top = 217
  Hint = 'Choose Work Directory'
  BorderIcons = []
  Caption = 'Choose Work Directory'
  ClientHeight = 500
  ClientWidth = 599
  Color = 14474715
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Panel1: TPanel
    Left = 0
    Top = 304
    Width = 599
    Height = 196
    Align = alBottom
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 120
      Width = 597
      Height = 75
      Align = alBottom
      TabOrder = 0
      object Label3: TLabel
        Left = 360
        Top = 9
        Width = 24
        Height = 21
        Caption = '+ i'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 10
        Top = 14
        Width = 164
        Height = 17
        Caption = 'Save Work File as Series'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object BitBtn1: TBitBtn
        Left = 454
        Top = 46
        Width = 75
        Height = 25
        Caption = '&Help'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -14
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = BitBtn1Click
        NumGlyphs = 2
      end
      object Edit: TEdit
        Left = 208
        Top = 8
        Width = 121
        Height = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Text = 'ScanData'
      end
      object BitBtnCancel: TBitBtn
        Left = 174
        Top = 46
        Width = 75
        Height = 25
        Cancel = True
        Caption = '&Cancel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ModalResult = 2
        ParentFont = False
        TabOrder = 2
        OnClick = BitBtnCancelClick
        NumGlyphs = 2
      end
      object BitBtnOK: TBitBtn
        Left = 33
        Top = 46
        Width = 75
        Height = 25
        Caption = '&OK'
        Default = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ModalResult = 1
        ParentFont = False
        TabOrder = 3
        OnClick = BitBtnOKClick
        NumGlyphs = 2
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 597
      Height = 119
      Align = alClient
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 1
        Top = 1
        Width = 595
        Height = 117
        Align = alClient
        Caption = 'Work directory'
        TabOrder = 0
        object EdWorkDir: TEdit
          Left = 3
          Top = 70
          Width = 570
          Height = 25
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -14
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object BitBtnNew: TBitBtn
          Left = 274
          Top = 41
          Width = 247
          Height = 26
          Caption = 'Add new directory'
          TabOrder = 1
          OnClick = BitBtnNewClick
        end
        object BitBtnDef: TBitBtn
          Left = 274
          Top = 11
          Width = 247
          Height = 25
          Caption = 'Default directory'
          TabOrder = 2
          OnClick = BitBtnDefClick
        end
        object BitBtn2: TBitBtn
          Left = 16
          Top = 24
          Width = 217
          Height = 25
          Caption = 'Last work directory'
          TabOrder = 3
          OnClick = BitBtn2Click
        end
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 599
    Height = 304
    Align = alClient
    TabOrder = 1
    object NTShellComboBox: TNTShellComboBox
      Left = 18
      Top = 8
      Width = 239
      Height = 26
      Root = 'rfDesktop'
      ShellTreeView = NTShellTreeView
      UseShellImages = True
      TabOrder = 0
    end
    object NTShellTreeView: TNTShellTreeView
      Left = 8
      Top = 56
      Width = 417
      Height = 218
      ObjectTypes = [otFolders]
      Root = 'rfDesktop'
      ShellComboBox = NTShellComboBox
      UseShellImages = True
      AutoRefresh = False
      Indent = 19
      RightClickSelect = True
      TabOrder = 1
      OnClick = NTShellTreeViewClick
      OnChange = NTShellTreeViewChange
      FileMask = '*.*'
      OnDeleteFile = NTShellTreeViewDeleteFile
      OnRenameFile = NTShellTreeViewRenameFile
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
    Left = 488
    Top = 208
    TranslationData = {
      737443617074696F6E730D0A544368616E67654469720143686F6F736520576F
      726B204469726563746F727901C2FBE1F0E0F2FC20F0E0E1EEF7F3FE20EFE0EF
      EAF3010D0A4C6162656C33012B206901010D0A4C6162656C3201536176652057
      6F726B2046696C652061732053657269657301D1EEF5F0E0EDFFF2FC20F4E0E9
      EBFB20EAE0EA20010D0A42697442746E31012648656C700126D1EFF0E0E2EAE0
      010D0A42697442746E43616E63656C012643616E63656C01CE26F2ECE5EDE001
      0D0A42697442746E4F4B01264F4B0126CE4B010D0A47726F7570426F78310157
      6F726B206469726563746F727901D0E0E1EEF7E0FF20EFE0EFEAE0010D0A4269
      7442746E4E657701416464206E6577206469726563746F727901C4EEE1E0E2E8
      F2FC20EDEEE2F3FE20EFE0EFEAF3010D0A42697442746E446566014465666175
      6C74206469726563746F727901CFE0EFEAE020EFEE20F3ECEEEBF7E0EDE8FE01
      0D0A42697442746E32014C61737420776F726B206469726563746F727901CFEE
      F1EBE5E4EDFFFF20F0E0E1EEF7E0FF20EFE0EFEAE020010D0A737448696E7473
      0D0A544368616E67654469720143686F6F736520576F726B204469726563746F
      727901010D0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A
      544368616E67654469720144656661756C740144656661756C74010D0A4C6162
      656C330144656661756C74015461686F6D61010D0A4C6162656C320144656661
      756C74015461686F6D61010D0A42697442746E310144656661756C7401546168
      6F6D61010D0A456469740144656661756C74015461686F6D61010D0A42697442
      746E43616E63656C0144656661756C74015461686F6D61010D0A42697442746E
      4F4B0144656661756C74015461686F6D61010D0A4564576F726B446972014465
      6661756C74015461686F6D61010D0A73744D756C74694C696E65730D0A737453
      7472696E67730D0A737472737472636864310143616E6E277420637265617465
      206469726563746F72792E2054727920416761696E2E01CDE5E2EEE7ECEEE6ED
      EE20F1EEE7E4E0F2FC20EFE0EFEAF32E20CFEEEFFBF2E0E9F2E5F1FC20E5F9E5
      20F0E0E72E010D0A73747273747263686432014E6577206469726563746F7279
      206372656174656401CDEEE2E0FF20EFE0EFEAE020F1EEE7E4E0EDE02E010D0A
      73747273747263686433015365726965732046696C65732077697468206E616D
      652001D1E5F0E8FF20F4E0E9EBEEE220F120E8ECE5EDE0ECE82020010D0A7374
      727374726368643401206578697374732120526577726974653F012063F3F9E5
      F1F2E2F3E5F2212020CFE5F0E5EFE8F1E0F2FC3F010D0A737472737472636864
      35014368616E676520666F6C646572212001C8E7ECE5EDE8F2E520F0E0E1EEF7
      F3FE20EFE0EFEAF321010D0A73747273747263686430015468652047616C6C65
      7279206469726563746F72792063616E206E6F74206265207573656420617320
      776F726B206469726563746F7279212043686F6F736520616E6F746865722064
      69726563746F727901CFE0EFEAE0202247616C6C6572792220EDE520ECEEE6E5
      F220E1FBF2FC20F0E0E1EEF7E5E920EFE0EFEAEEE92E20D1ECE5EDE8F2E520F0
      E0E1EEF7F3FE20EFE0EFEAF32E010D0A73744F74686572537472696E67730D0A
      4E545368656C6C4368616E67654E6F746966696572312E526F6F7401433A5C01
      010D0A456469742E54657874015363616E4461746101010D0A4E545368656C6C
      436F6D626F426F782E526F6F740172664465736B746F7001010D0A4E54536865
      6C6C54726565566965772E46696C654D61736B012A2E2A01010D0A4E54536865
      6C6C54726565566965772E526F6F740172664465736B746F7001010D0A737443
      6F6C6C656374696F6E730D0A737443686172536574730D0A544368616E676544
      69720144454641554C545F43484152534554015255535349414E5F4348415253
      4554010D0A4C6162656C330144454641554C545F434841525345540152555353
      49414E5F43484152534554010D0A4C6162656C320144454641554C545F434841
      52534554015255535349414E5F43484152534554010D0A42697442746E310144
      454641554C545F43484152534554015255535349414E5F43484152534554010D
      0A456469740144454641554C545F43484152534554015255535349414E5F4348
      4152534554010D0A42697442746E43616E63656C0144454641554C545F434841
      52534554015255535349414E5F43484152534554010D0A42697442746E4F4B01
      44454641554C545F43484152534554015255535349414E5F4348415253455401
      0D0A4564576F726B4469720144454641554C545F434841525345540152555353
      49414E5F43484152534554010D0A}
  end
  object NTShellChangeNotifier1: TNTShellChangeNotifier
    NotifyFilters = [nfFileNameChange, nfDirNameChange]
    Root = 'C:\'
    WatchSubTree = True
    Left = 496
    Top = 104
  end
end
