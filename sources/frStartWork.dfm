object FormStartWork: TFormStartWork
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderIcons = [biSystemMenu]
  Caption = 'Warning'
  ClientHeight = 87
  ClientWidth = 471
  Color = clBtnFace
  TransparentColor = True
  TransparentColorValue = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 471
    Height = 87
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 171
    object Memo: TMemo
      Left = 1
      Top = 1
      Width = 469
      Height = 85
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        '     The controller is turn off!!'
        'If you want to start new experiment, turn on the controller '
        'and wait for ready the controller. ')
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 0
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
    Left = 384
    Top = 8
    TranslationData = {
      737443617074696F6E730D0A54466F726D5374617274576F726B015761726E69
      6E6701CFF0E5E4F3EFF0E5E6E4E5EDE8E5010D0A737448696E74730D0A54466F
      726D5374617274576F726B01010D0A7374446973706C61794C6162656C730D0A
      7374466F6E74730D0A54466F726D5374617274576F726B015461686F6D610154
      61686F6D61010D0A4D656D6F015461686F6D61015461686F6D61010D0A73744D
      756C74694C696E65730D0A4D656D6F2E4C696E65730122202020202054686520
      636F6E74726F6C6C6572206973207475726E206F66662121222C22496620796F
      752077616E7420746F207374617274206E6577206578706572696D656E742C20
      7475726E206F6E2074686520636F6E74726F6C6C657220222C22616E64207761
      697420666F722072656164792074686520636F6E74726F6C6C65722E20220122
      202020202020202020202020202020202020202020202020C2EDE8ECE0EDE8E5
      212020CAEEEDF2F0EEEBEBE5F020E2FBEAEBFEF7E5ED2121222C222020202020
      2020202020202020C5F1EBE820E2FB20F5EEF2E8F2E520EDE0F7E0F2FC20EDEE
      E2FBE920FDEAF1EFE5F0E8ECE5EDF22C20222C22202020202020202020202020
      20E2EAEBFEF7E8F2E520EAEEEDF2F0EEEBEBE5F020E820E4EEE6E4E8F2E5F1FC
      20E3EEF2EEE2EDEEF1F2E82E222C010D0A7374537472696E67730D0A73744F74
      686572537472696E67730D0A7374436F6C6C656374696F6E730D0A7374436861
      72536574730D0A54466F726D5374617274576F726B0144454641554C545F4348
      4152534554015255535349414E5F43484152534554010D0A4D656D6F01444546
      41554C545F43484152534554015255535349414E5F43484152534554010D0A}
  end
  object Timer: TTimer
    Interval = 100
    OnTimer = TimerTimer
    Left = 360
    Top = 48
  end
end
