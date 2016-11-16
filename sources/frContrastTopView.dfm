object frContrast: TfrContrast
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  ClientHeight = 524
  ClientWidth = 120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelContrust: TPanel
    Left = 0
    Top = 0
    Width = 120
    Height = 524
    Align = alClient
    Color = clAppWorkSpace
    TabOrder = 0
    ExplicitWidth = 115
    object BitBtnReSet: TBitBtn
      Left = 11
      Top = 480
      Width = 91
      Height = 25
      Caption = 'Reset'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtnReSetClick
    end
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 113
      Height = 473
      Align = alTop
      BevelInner = bvRaised
      TabOrder = 1
      object ImageGrad: TImage
        Left = 41
        Top = 55
        Width = 25
        Height = 404
      end
      object Label5: TLabel
        Left = 21
        Top = 3
        Width = 63
        Height = 16
        Caption = 'Z Contrast'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 25
        Top = 22
        Width = 50
        Height = 13
        Caption = 'Top View'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ZTrackBarLeft: TTrackBar
        Left = 10
        Top = 50
        Width = 25
        Height = 417
        Max = 255
        Orientation = trVertical
        TabOrder = 0
        ThumbLength = 10
        OnChange = ZTrackBarLeftChange
      end
      object ZTrackBarRight: TTrackBar
        Left = 76
        Top = 50
        Width = 25
        Height = 417
        Max = 255
        Orientation = trVertical
        Position = 255
        TabOrder = 1
        ThumbLength = 10
        OnChange = ZTrackBarRightChange
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
    Left = 40
    Top = 504
    TranslationData = {
      737443617074696F6E730D0A546672436F6E74726173740101010D0A50616E65
      6C436F6E74727573740101010D0A42697442746E526553657401526573657401
      26CEF2ECE5EDE0010D0A50616E656C360101010D0A4C6162656C35015A20436F
      6E7472617374015A20CAEEEDF2F0E0F1F2010D0A4C6162656C3101546F702056
      69657701E2E8E420F1E2E5F0F5F3010D0A737448696E74730D0A546672436F6E
      747261737401010D0A50616E656C436F6E747275737401010D0A42697442746E
      526553657401010D0A50616E656C3601010D0A496D6167654772616401010D0A
      4C6162656C3501010D0A4C6162656C3101010D0A5A547261636B4261724C6566
      7401010D0A5A547261636B426172526967687401010D0A7374446973706C6179
      4C6162656C730D0A7374466F6E74730D0A546672436F6E747261737401546168
      6F6D6101417269616C0D0A42697442746E526553657401417269616C01417269
      616C0D0A4C6162656C3501417269616C01417269616C0D0A4C6162656C310154
      61686F6D6101417269616C0D0A73744D756C74694C696E65730D0A7374537472
      696E67730D0A73744F74686572537472696E67730D0A546672436F6E74726173
      742E48656C7046696C6501010D0A7374436F6C6C656374696F6E730D0A737443
      686172536574730D0A546672436F6E74726173740144454641554C545F434841
      52534554015255535349414E5F434841525345540D0A42697442746E52655365
      74015255535349414E5F43484152534554015255535349414E5F434841525345
      540D0A4C6162656C35015255535349414E5F4348415253455401525553534941
      4E5F434841525345540D0A4C6162656C310144454641554C545F434841525345
      54015255535349414E5F434841525345540D0A}
  end
end
