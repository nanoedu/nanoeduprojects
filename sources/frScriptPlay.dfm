object ScriptPlay: TScriptPlay
  Left = 742
  Top = 173
  Caption = 'Script Generator'
  ClientHeight = 549
  ClientWidth = 384
  Color = clBtnFace
  Constraints.MaxWidth = 400
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 384
    Height = 209
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object PanelUp: TPanel
      Left = 1
      Top = 1
      Width = 382
      Height = 207
      Align = alClient
      Color = clSilver
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      ExplicitWidth = 304
      ExplicitHeight = 143
      object GroupBoxAct: TGroupBox
        Left = 138
        Top = 9
        Width = 223
        Height = 186
        Caption = 'Edit Script'
        TabOrder = 0
        object ToolBar1: TToolBar
          Left = 10
          Top = 16
          Width = 151
          Height = 167
          Align = alNone
          ButtonHeight = 38
          ButtonWidth = 106
          Caption = 'ToolBar1'
          Flat = False
          Images = Main.ImageListMainTools
          ShowCaptions = True
          TabOrder = 0
          Transparent = True
          object BitBtnAdd: TToolButton
            Left = 0
            Top = 0
            Caption = '        &Add Action     '
            DropdownMenu = PopupMenuAdd
            ImageIndex = 25
            Wrap = True
            Style = tbsDropDown
            OnClick = BitBtnAddClick
          end
          object BitBtnDelAct: TToolButton
            Left = 0
            Top = 38
            Caption = '&Delete Active'
            ImageIndex = 26
            Wrap = True
            OnClick = BitBtnDelActClick
          end
          object BitBTnClear: TToolButton
            Left = 0
            Top = 76
            Caption = '&Clear Script'
            ImageIndex = 2
            Wrap = True
            OnClick = BitBtnClearClick
          end
        end
      end
      object ToolBar: TToolBar
        Left = 5
        Top = 16
        Width = 127
        Height = 112
        Align = alNone
        ButtonHeight = 52
        ButtonWidth = 119
        Caption = 'ToolBar'
        Images = Main.ImageListScanTool
        ShowCaptions = True
        TabOrder = 1
        Transparent = True
        object StartBtn: TToolButton
          Left = 0
          Top = 0
          AllowAllUp = True
          Caption = '           &Start          '
          Grouped = True
          ImageIndex = 8
          Wrap = True
          Style = tbsCheck
          OnClick = BitBtnRunClick
        end
        object HelpBtn: TToolButton
          Left = 0
          Top = 52
          Caption = '&Help'
          ImageIndex = 19
          OnClick = BitBtnHClick
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 209
    Width = 384
    Height = 340
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 1
    ExplicitTop = 175
    ExplicitWidth = 306
    ExplicitHeight = 326
    object FilterListBox: TListBox
      Left = 22
      Top = 6
      Width = 219
      Height = 216
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 40
    Top = 232
  end
  object OpenDialog1: TOpenDialog
    Left = 112
    Top = 232
  end
  object PopupMenuAdd: TPopupMenu
    Left = 184
    Top = 232
    object Median3: TMenuItem
      Caption = 'Median3x3'
      OnClick = Median3Click
    end
    object Average3x31: TMenuItem
      Caption = 'Average3x3'
      OnClick = Average3x31Click
    end
    object Planedelete1: TMenuItem
      Caption = 'Plane delete'
      OnClick = Planedelete1Click
    end
    object Surfacedelete1: TMenuItem
      Caption = 'Surface delete'
      OnClick = Surfacedelete1Click
    end
    object StepDelete1: TMenuItem
      Caption = 'Step delete'
      OnClick = StepDelete1Click
    end
    object LevelDelete1: TMenuItem
      Caption = 'Level Delete'
      OnClick = LevelDelete1Click
    end
    object FourierFiltration1: TMenuItem
      Caption = 'Fourier Filtration'
      OnClick = FourierFiltration1Click
    end
    object mSaveAsBMP: TMenuItem
      Caption = 'Save as bmp file'
      OnClick = mSaveAsBMPClick
    end
    object mSaveAsJPG: TMenuItem
      Caption = 'Save as jpg file'
      OnClick = mSaveAsJPGClick
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
    Left = 136
    Top = 376
    TranslationData = {
      737443617074696F6E730D0A54536372697074506C6179015363726970742047
      656E657261746F7201C3E5EDE5F0E0F2EEF020F1EAF0E8EFF2EEE2010D0A5061
      6E656C546F700101010D0A50616E656C55700101010D0A47726F7570426F7841
      637401456469742053637269707401D0E5E4E0EAF2E8F0EEE2E0F2FC20F1EAF0
      E8EFF2010D0A50616E656C310101010D0A4D656469616E33014D656469616E33
      783301CCE5E4E8E0ED2E2033F533010D0A417665726167653378333101417665
      7261676533783301CEE4EDEEF02E2033F533010D0A506C616E6564656C657465
      3101506C616E652064656C65746501D3E4E0EBE8F2FC20EFEBEEF1EAEEF1F2FC
      010D0A5375726661636564656C6574653101537572666163652064656C657465
      01D3E4E0EBE8F2FC20EFEEE2E5F0F5EDEEF1F2FC010D0A5374657044656C6574
      653101537465702064656C65746501D3E4E0EBE8F2FC20F1F2F3EFE5EDFCEAF3
      010D0A4C6576656C44656C65746531014C6576656C2044656C65746501D3E4E0
      EBE8F2FC20EFEEE4F1F2E0E2EAF3010D0A466F757269657246696C7472617469
      6F6E3101466F75726965722046696C74726174696F6E01D4F3F0FCE520F4E8EB
      FCF2F0010D0A6D536176654173424D50015361766520617320626D702066696C
      6501D1EEF5F0E0EDE8F2FC20EAE0EA20626D7020F4E0E9EB010D0A6D53617665
      41734A50470153617665206173206A70672066696C6501D1EEF5F0E0EDE8F2FC
      20EAE0EA206A706720F4E0E9EB010D0A546F6F6C4261723101546F6F6C426172
      3101010D0A42697442746E416464012020202020202020264164642041637469
      6F6E202020202001C4EEE1E0E2E8F2FC20E4E5E9F1F2E2E8E5010D0A42697442
      746E44656C416374012644656C6574652041637469766501D3E4E0EBE8F2FC20
      E0EAF2E8E2EDEEE5010D0A42697442546E436C6561720126436C656172205363
      7269707401CEF7E8F1F2E8F2FC20F1EAF0E8EFF2010D0A546F6F6C4261720154
      6F6F6C42617201010D0A537461727442746E0120202020202020202020202653
      746172742020202020202020202001202020202020202020202026D1F2E0F0F2
      20202020202020202020010D0A48656C7042746E012648656C70014326EFF0E0
      E2EAE0010D0A737448696E74730D0A54536372697074506C61790101010D0A50
      616E656C546F700101010D0A50616E656C55700101010D0A47726F7570426F78
      4163740101010D0A50616E656C310101010D0A46696C7465724C697374426F78
      0101010D0A4D656469616E330101010D0A41766572616765337833310101010D
      0A506C616E6564656C657465310101010D0A5375726661636564656C65746531
      0101010D0A5374657044656C657465310101010D0A4C6576656C44656C657465
      310101010D0A466F757269657246696C74726174696F6E310101010D0A6D5361
      76654173424D500101010D0A6D5361766541734A50470101010D0A546F6F6C42
      6172310101010D0A42697442746E4164640101010D0A42697442746E44656C41
      63740101010D0A42697442546E436C6561720101010D0A546F6F6C4261720101
      010D0A537461727442746E0101010D0A48656C7042746E0101010D0A73744469
      73706C61794C6162656C730D0A7374466F6E74730D0A54536372697074506C61
      79014D532053616E73205365726966015461686F6D610D0A50616E656C546F70
      014D532053616E73205365726966015461686F6D610D0A73744D756C74694C69
      6E65730D0A46696C7465724C697374426F782E4974656D7301010D0A73745374
      72696E67730D0A73744F74686572537472696E67730D0A54536372697074506C
      61792E48656C7046696C6501010D0A536176654469616C6F67312E46696C7465
      7201010D0A536176654469616C6F67312E5469746C6501010D0A4F70656E4469
      616C6F67312E46696C74657201010D0A4F70656E4469616C6F67312E5469746C
      6501010D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A
      54536372697074506C61790144454641554C545F434841525345540152555353
      49414E5F434841525345540D0A50616E656C546F700144454641554C545F4348
      4152534554015255535349414E5F434841525345540D0A}
  end
end
