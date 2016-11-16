object VideoSettings: TVideoSettings
  Left = 501
  Top = 227
  Caption = 'Settings'
  ClientHeight = 141
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object SrcDlgBtn: TSpeedButton
    Left = 16
    Top = 6
    Width = 70
    Height = 25
    Hint = 'Source Dialog'
    Caption = 'Source'
    Enabled = False
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = SrcDlgBtnClick
  end
  object FormatDlgBtn: TSpeedButton
    Left = 95
    Top = 6
    Width = 57
    Height = 25
    Hint = 'Format Dialog'
    Caption = 'Format'
    Enabled = False
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = FormatDlgBtnClick
  end
  object DisplayDlgBtn: TSpeedButton
    Left = 166
    Top = 6
    Width = 57
    Height = 25
    Hint = 'Display Dialog'
    Caption = 'Display'
    Enabled = False
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = DisplayDlgBtnClick
  end
  object CompressBtn: TSpeedButton
    Left = 238
    Top = 6
    Width = 94
    Height = 25
    Hint = 'Compression Dialog'
    Caption = 'Compression'
    Enabled = False
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = CompressBtnClick
  end
  object OverlayBtn: TSpeedButton
    Left = 20
    Top = 36
    Width = 60
    Height = 24
    Hint = 'Toggle Overlay'
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Overlay'
    Enabled = False
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = OverlayBtnClick
  end
  object FrameRateLbl: TLabel
    Left = 112
    Top = 41
    Width = 66
    Height = 13
    Caption = 'Frame Rate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object FrameRateCB: TComboBox
    Left = 277
    Top = 36
    Width = 35
    Height = 21
    Hint = 'Set Expected Frame Rate'
    Style = csDropDownList
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = FrameRateCBChange
    Items.Strings = (
      '30'
      '25'
      '20'
      '15'
      '10'
      '5')
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 67
    Width = 336
    Height = 74
    Align = alBottom
    Caption = 'Video driver'
    TabOrder = 1
    ExplicitTop = 65
    ExplicitWidth = 385
    object DriverCB: TComboBox
      Left = 20
      Top = 15
      Width = 253
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = DriverCBChange
    end
    object BitBtnSave: TBitBtn
      Left = 241
      Top = 42
      Width = 91
      Height = 21
      Caption = 'Save '
      TabOrder = 1
      OnClick = BitBtnSaveClick
    end
    object BitBtnDef: TBitBtn
      Left = 20
      Top = 42
      Width = 92
      Height = 21
      Caption = 'Default'
      TabOrder = 2
      OnClick = BitBtnDefClick
    end
  end
  object siLangLinked1: TsiLangLinked
    Version = '6.5'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 2
    LangDispatcher = MSVideoForm.siLangDispatcher1
    OnChangeLanguage = siLangLinked1ChangeLanguage
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Russian')
    Language = 'English'
    CommonContainer = MSVideoForm.siLang1
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
    Left = 184
    Top = 32
    TranslationData = {
      737443617074696F6E730D0A54566964656F53657474696E6773015365747469
      6E677301CFE0F0E0ECE5F2F0FB010D0A537263446C6742746E01536F75726365
      01C8F1F2EEF7EDE8EA010D0A466F726D6174446C6742746E01466F726D617401
      D4EEF0ECE0F2010D0A446973706C6179446C6742746E01446973706C617901C4
      E8F1EFEBE5E9010D0A436F6D707265737342746E01436F6D7072657373696F6E
      01CAEEECEFF0E5F1F1E8FF010D0A4F7665726C617942746E014F7665726C6179
      01CEE2E5F0EBE5E9010D0A4672616D65526174654C626C014672616D65205261
      746501D1EAEEF0EEF1F2FC20EFEE20EAE0E4F0E0EC010D0A47726F7570426F78
      3101566964656F2064726976657201C2E8E4E5EE20E4F0E0E9E2E5F0010D0A42
      697442746E5361766501536176652001D1EEF5F0E0EDE8F2FC010D0A42697442
      746E4465660144656661756C7401D1F2E0EDE4E0F0F2EDFBE9010D0A73744869
      6E74730D0A54566964656F53657474696E67730101010D0A537263446C674274
      6E01536F75726365204469616C6F6701C2FBE1EEF020E8F1F2EEF7EDE8EAE020
      E8E7EEE1F0E0E6E5EDE8FF010D0A466F726D6174446C6742746E01466F726D61
      74204469616C6F6701C4E8E0EBEEE320E2FBE1EEF0E020F4EEF0ECE0F2E0010D
      0A446973706C6179446C6742746E01446973706C6179204469616C6F6701C4E8
      E0EBEEE320EFE0F0E0ECE5F2F0EEE220EEF2EEE1F0E0E6E5EDE8FF010D0A436F
      6D707265737342746E01436F6D7072657373696F6E204469616C6F6701C4E8E0
      EBEEE320EFE0F0E0ECE5F2F0EEE220EAEEECEFF0E5F1F1E8E8010D0A4F766572
      6C617942746E01546F67676C65204F7665726C617901D4EBE0E320EEE2E5F0EB
      E5FF010D0A4672616D65526174654C626C0101010D0A4672616D655261746543
      4201536574204578706563746564204672616D65205261746501D3F1F2E0EDEE
      E2EAE020EEE6E8E4E0E5ECEEE920F1EAEEF0EEF1F2E820E2FBE2EEE4E020EFEE
      20EAE0E4F0E0EC010D0A47726F7570426F78310101010D0A4472697665724342
      0101010D0A42697442746E536176650101010D0A42697442746E446566010101
      0D0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A54566964
      656F53657474696E6773014D532053616E73205365726966015461686F6D6101
      0D0A537263446C6742746E014D532053616E73205365726966015461686F6D61
      010D0A466F726D6174446C6742746E014D532053616E73205365726966015461
      686F6D61010D0A446973706C6179446C6742746E014D532053616E7320536572
      6966015461686F6D61010D0A436F6D707265737342746E014D532053616E7320
      5365726966015461686F6D61010D0A4F7665726C617942746E014D532053616E
      73205365726966015461686F6D61010D0A4672616D65526174654C626C014D53
      2053616E73205365726966015461686F6D61010D0A73744D756C74694C696E65
      730D0A4672616D655261746543422E4974656D730133302C32352C32302C3135
      2C31302C3501010D0A44726976657243422E4974656D730101010D0A73745374
      72696E67730D0A737472737472310154686520566964656F2043616D65726120
      6973206E6F7420636F6E6E65637465642120436F6E6E65637420746865205669
      64656F2043616D65726120616E6420726573746172742101C2E8E4E5EE20EAE0
      ECE5F0E020EDE520EFEEE4F1EEE5E4E8EDE5EDE02120CFEEE4F1EEE5E4E8EDE8
      F2E520EAE0ECE5F0F320E820EDE0E6ECE8F2E520EAEDEEEFEAF320D1F2E0F0F2
      2E20010D0A73744F74686572537472696E67730D0A54566964656F5365747469
      6E67732E48656C7046696C650101010D0A4672616D655261746543422E546578
      740101010D0A44726976657243422E546578740101010D0A7374436F6C6C6563
      74696F6E730D0A737443686172536574730D0A54566964656F53657474696E67
      730144454641554C545F43484152534554015255535349414E5F434841525345
      54010D0A537263446C6742746E0144454641554C545F43484152534554015255
      535349414E5F43484152534554010D0A466F726D6174446C6742746E01444546
      41554C545F43484152534554015255535349414E5F43484152534554010D0A44
      6973706C6179446C6742746E0144454641554C545F4348415253455401525553
      5349414E5F43484152534554010D0A436F6D707265737342746E014445464155
      4C545F43484152534554015255535349414E5F43484152534554010D0A4F7665
      726C617942746E0144454641554C545F43484152534554015255535349414E5F
      43484152534554010D0A4672616D65526174654C626C0144454641554C545F43
      484152534554015255535349414E5F43484152534554010D0A}
  end
end
