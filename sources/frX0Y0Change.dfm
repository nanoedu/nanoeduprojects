object fX0Y0Change: TfX0Y0Change
  Left = 549
  Top = 166
  BorderIcons = [biSystemMenu]
  Caption = 'Set X0;Y0 Point for Scan Area'
  ClientHeight = 290
  ClientWidth = 432
  Color = 14474715
  Constraints.MinHeight = 317
  Constraints.MinWidth = 439
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 32
    Width = 44
    Height = 13
    Caption = 'X0 shift'
  end
  object Label2: TLabel
    Left = 24
    Top = 80
    Width = 44
    Height = 13
    Caption = 'Y0 shift'
  end
  object LabelX0: TLabel
    Left = 160
    Top = 8
    Width = 47
    Height = 13
    Caption = 'LabelX0'
  end
  object LabelY0: TLabel
    Left = 160
    Top = 64
    Width = 47
    Height = 13
    Caption = 'LabelY0'
  end
  object LabelX0A: TLabel
    Left = 37
    Top = 131
    Width = 23
    Height = 13
    Caption = 'X0='
  end
  object LabelY0A: TLabel
    Left = 180
    Top = 130
    Width = 23
    Height = 13
    Caption = 'Y0='
  end
  object Label3: TLabel
    Left = 52
    Top = 107
    Width = 243
    Height = 16
    Caption = ' Absolute Position of the Start Point'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 136
    Top = 129
    Width = 17
    Height = 13
    Caption = 'nm'
  end
  object Label5: TLabel
    Left = 285
    Top = 128
    Width = 17
    Height = 13
    Caption = 'nm'
  end
  object ScrollBarX0: TScrollBar
    Left = 88
    Top = 26
    Width = 185
    Height = 16
    LargeChange = 100
    Max = 65535
    PageSize = 0
    TabOrder = 0
    OnScroll = ScrollBarX0Scroll
  end
  object ScrollBarY0: TScrollBar
    Left = 88
    Top = 80
    Width = 185
    Height = 16
    LargeChange = 100
    Max = 65535
    PageSize = 0
    TabOrder = 1
    OnScroll = ScrollBarY0Scroll
  end
  object EdX0A: TEdit
    Left = 64
    Top = 127
    Width = 69
    Height = 21
    TabOrder = 2
    OnChange = EdX0AChange
    OnKeyPress = EdX0AKeyPress
  end
  object EdY0A: TEdit
    Left = 202
    Top = 126
    Width = 74
    Height = 21
    TabOrder = 3
    OnChange = EdY0AChange
    OnKeyPress = EdY0AKeyPress
  end
  object BitBtnOK: TBitBtn
    Left = 56
    Top = 168
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
    OnClick = BitBtnOKClick
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 200
    Top = 168
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 5
    OnClick = BitBtn2Click
    NumGlyphs = 2
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
    Left = 224
    Top = 216
    TranslationData = {
      737443617074696F6E730D0A5466583059304368616E6765015365742058303B
      593020506F696E7420666F72205363616E204172656101D3F1F2E0EDEEE2EAE0
      20EDE0F7E0EBFCEDEEE920F2EEF7EAE820D1EAE0EDE0010D0A4C6162656C3101
      583020736869667401D1E4E2E8E320D530010D0A4C6162656C32015930207368
      69667401D1E4E2E8E3205930010D0A4C6162656C5830014C6162656C58300101
      0D0A4C6162656C5930014C6162656C593001010D0A4C6162656C583041015830
      3D0158303D010D0A4C6162656C5930410159303D0159303D010D0A4C6162656C
      3301204162736F6C75746520506F736974696F6E206F66207468652053746172
      7420506F696E7401C0E1F1EEEBFEF2EDFBE520EAEEEEF0E4E8EDE0F2FB20EDE0
      F7E0EBFCEDEEE920F2EEF7EAE8010D0A4C6162656C34016E6D01EDEC010D0A4C
      6162656C35016E6D01EDEC010D0A42697442746E4F4B01264F4B0126CECA010D
      0A42697442746E32012643616E63656C01CE26F2ECE5EDE0010D0A737448696E
      74730D0A5466583059304368616E67650101010D0A4C6162656C310101010D0A
      4C6162656C320101010D0A4C6162656C58300101010D0A4C6162656C59300101
      010D0A4C6162656C5830410101010D0A4C6162656C5930410101010D0A4C6162
      656C330101010D0A4C6162656C340101010D0A4C6162656C350101010D0A5363
      726F6C6C42617258300101010D0A5363726F6C6C42617259300101010D0A4564
      5830410101010D0A45645930410101010D0A42697442746E4F4B0101010D0A42
      697442746E320101010D0A7374446973706C61794C6162656C730D0A7374466F
      6E74730D0A5466583059304368616E6765014D532053616E7320536572696601
      417269616C0D0A4C6162656C33014D532053616E732053657269660141726961
      6C0D0A73744D756C74694C696E65730D0A7374537472696E67730D0A4944535F
      300120206E6D0120EDEC010D0A4944535F36016572726F7220696E70757401EE
      F8E8E1EAE020E2E2EEE4E020E7EDE0F7E5EDE8E5010D0A73744F746865725374
      72696E67730D0A5466583059304368616E67652E48656C7046696C650101010D
      0A45645830412E546578740101010D0A45645930412E546578740101010D0A73
      74436F6C6C656374696F6E730D0A737443686172536574730D0A546658305930
      4368616E67650144454641554C545F43484152534554015255535349414E5F43
      484152534554010D0A4C6162656C330144454641554C545F4348415253455401
      5255535349414E5F43484152534554010D0A}
  end
end
