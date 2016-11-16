object FormSchemeList: TFormSchemeList
  Left = 0
  Top = 0
  Caption = 'Choose Scheme'
  ClientHeight = 291
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 362
    Height = 291
    ActivePage = TabSheetScheme
    Align = alClient
    TabOrder = 0
    object TabSheetScheme: TTabSheet
      Caption = 'Scheme'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 354
        Height = 263
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 24
        ExplicitTop = 3
        object Select: TLabel
          Left = 32
          Top = 24
          Width = 69
          Height = 13
          Caption = 'Select Scheme'
        end
        object ComboBox1: TComboBox
          Left = 48
          Top = 56
          Width = 201
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Text = 'ComboBox1'
        end
        object BitBtnOK: TBitBtn
          Left = 160
          Top = 176
          Width = 59
          Height = 25
          Caption = 'OK'
          TabOrder = 1
          OnClick = BitBtnOKClick
        end
        object BitBtnCancel: TBitBtn
          Left = 280
          Top = 176
          Width = 59
          Height = 25
          Caption = 'Cancel'
          TabOrder = 2
          OnClick = BitBtnCancelClick
        end
      end
    end
    object TabSheetChangeLevel: TTabSheet
      Caption = ' Experiment/Simulator'
      ImageIndex = 1
      object Label1: TLabel
        Left = 24
        Top = 120
        Width = 110
        Height = 13
        Caption = 'Select current Program'
      end
      object Label2: TLabel
        Left = 16
        Top = 40
        Width = 224
        Height = 13
        Caption = 'Allow to change program Experiment/Simulator'
      end
      object ComboBoxProgram: TComboBox
        Left = 56
        Top = 160
        Width = 177
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Experiment'
        OnChange = ComboBoxProgramChange
        Items.Strings = (
          'Experiment'
          'Simulator')
      end
      object RadioGroupchangeUserLevel: TRadioGroup
        Left = 16
        Top = 56
        Width = 233
        Height = 41
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'No'
          'Yes')
        TabOrder = 1
        OnClick = RadioGroupchangeUserLevelClick
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
    Left = 280
    Top = 48
    TranslationData = {
      737443617074696F6E730D0A54466F726D536368656D654C6973740143686F6F
      736520536368656D6501C2FBE1EEF020EDEEE2EEE920F1F5E5ECFB010D0A5461
      625368656574536368656D6501536368656D650120D1F5E5ECE0010D0A53656C
      6563740153656C65637420536368656D6501C2FBE1E5F0E8F2E520F1F5E5ECF3
      010D0A42697442746E4F4B014F4B01CECA010D0A42697442746E43616E63656C
      0143616E63656C01CEF2ECE5EDE0010D0A54616253686565744368616E67654C
      6576656C01204578706572696D656E742F53696D756C61746F7201DDEAF1EFE5
      F0E8ECE5EDF22FD2F0E5EDE0E6E5F0010D0A4C6162656C310153656C65637420
      63757272656E742050726F6772616D01C2FBE1E5F0E8F2E520EFF0EEE3F0E0EC
      ECF320F0E0E1EEF2FB010D0A4C6162656C3201416C6C6F7720746F206368616E
      67652070726F6772616D204578706572696D656E742F53696D756C61746F7201
      D0E0E7F0E5F8E8F2FC20E2FBE1EEF020EFF0EEE3F0E0ECECFB20DDEAF1EFE5F0
      E8ECE5EDF22FD2F0E5EDE0E6E5F0010D0A737448696E74730D0A737444697370
      6C61794C6162656C730D0A7374466F6E74730D0A54466F726D536368656D654C
      697374015461686F6D61015461686F6D61010D0A73744D756C74694C696E6573
      0D0A436F6D626F426F7850726F6772616D2E4974656D73014578706572696D65
      6E742C53696D756C61746F7201DDEAF1EFE5F0E8ECE5EDF22CD2F0E5EDE0E6E5
      F0010D0A526164696F47726F75706368616E6765557365724C6576656C2E4974
      656D73014E6F2C59657301CDE5F22CC4E0010D0A7374537472696E67730D0A73
      744F74686572537472696E67730D0A436F6D626F426F78312E5465787401436F
      6D626F426F783101010D0A436F6D626F426F7850726F6772616D2E5465787401
      4578706572696D656E7401010D0A7374436F6C6C656374696F6E730D0A737443
      686172536574730D0A54466F726D536368656D654C6973740144454641554C54
      5F43484152534554015255535349414E5F43484152534554010D0A}
  end
end
