object FormProgramSettings: TFormProgramSettings
  Left = 0
  Top = 0
  Caption = 'Program Settings'
  ClientHeight = 280
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 362
    Height = 239
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheetScheme: TTabSheet
      Caption = 'Scheme'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 354
        Height = 211
        Align = alClient
        TabOrder = 0
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
      end
    end
    object TabSheetChangeLevel: TTabSheet
      Caption = ' Experiment/Simulator'
      ImageIndex = 1
      object Label1: TLabel
        Left = 16
        Top = 128
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
      object Label3: TLabel
        Left = 16
        Top = 56
        Width = 82
        Height = 13
        Caption = 'by user interface'
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
        Top = 73
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
    object TabSheet1: TTabSheet
      Caption = 'Online service'
      ImageIndex = 2
      TabVisible = False
      object CheckBox: TCheckBox
        Left = 96
        Top = 96
        Width = 97
        Height = 17
        Caption = 'Online service'
        TabOrder = 0
        OnClick = CheckBoxClick
      end
    end
    object TabSheetSimulator: TTabSheet
      Caption = 'Simulator settings'
      ImageIndex = 3
      object CheckBoxFastSimulation: TCheckBox
        Left = 24
        Top = 40
        Width = 313
        Height = 17
        Caption = 'fast demonstration '
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Sensor'
      ImageIndex = 4
      object CheckBoxChooseSensor: TCheckBox
        Left = 58
        Top = 56
        Width = 97
        Height = 17
        Caption = 'choose sensor'
        TabOrder = 0
        OnClick = CheckBoxChooseSensorClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 239
    Width = 362
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtnCancel: TBitBtn
      Left = 224
      Top = 6
      Width = 59
      Height = 25
      Caption = 'Cancel'
      TabOrder = 0
      Visible = False
      OnClick = BitBtnCancelClick
    end
    object BitBtnOK: TBitBtn
      Left = 100
      Top = 6
      Width = 59
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = BitBtnOKClick
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
      737443617074696F6E730D0A54466F726D50726F6772616D53657474696E6773
      0150726F6772616D2053657474696E677301CDE0F1F2F0EEE9EAE820EFF0EEE3
      F0E0ECECFB010D0A5461625368656574536368656D6501536368656D650120D1
      F5E5ECE0010D0A53656C6563740153656C65637420536368656D6501C2FBE1E5
      F0E8F2E520F1F5E5ECF3010D0A54616253686565744368616E67654C6576656C
      01204578706572696D656E742F53696D756C61746F7201DDEAF1EFE5F0E8ECE5
      EDF22FD2F0E5EDE0E6E5F0010D0A4C6162656C310153656C6563742063757272
      656E742050726F6772616D01C2FBE1F0E0F2FC20EFF0EEE3F0E0ECECF320010D
      0A4C6162656C3201416C6C6F7720746F206368616E67652070726F6772616D20
      4578706572696D656E742F53696D756C61746F7201D0E0E7F0E5F8E8F2FC20E2
      FBE1EEF020EFF0EEE3F0E0ECECFB20DDEAF1EFE5F0E8ECE5EDF22FD2F0E5EDE0
      E6E5F0010D0A4C6162656C33016279207573657220696E7465726661636501F7
      E5F0E5E720E8EDF2E5F0F4E5E9F120EFEEEBFCE7EEE2E0F2E5EBFF010D0A5461
      62536865657431014F6E6C696E65207365727669636501CEEDEBE0E9ED20F1E5
      F0E2E8F1010D0A436865636B426F78014F6E6C696E65207365727669636501CE
      EDEBE0E9ED20F1E5F0E2E8F1010D0A42697442746E43616E63656C0143616E63
      656C01010D0A42697442746E4F4B014F4B01010D0A546162536865657453696D
      756C61746F720153696D756C61746F722073657474696E677301CFE0F0E0ECE5
      F2F0FB20F2F0E5EDE0E6E5F0E0010D0A436865636B426F784661737453696D75
      6C6174696F6E01666173742064656D6F6E7374726174696F6E2001D3F1EAEEF0
      E5EDEDE0FF20E4E5ECEEEDF1F2F0E0F6E8FF20F1EAE0EDE8F0EEE2E0EDE8FF01
      0D0A5461625368656574320153656E736F7201D1E5EDF1EEF0010D0A43686563
      6B426F7843686F6F736553656E736F720163686F6F73652073656E736F7201E2
      FBE1EEF020F1E5EDF1EEF0E0010D0A737448696E74730D0A7374446973706C61
      794C6162656C730D0A7374466F6E74730D0A54466F726D50726F6772616D5365
      7474696E67730144656661756C740164656661756C74010D0A73744D756C7469
      4C696E65730D0A436F6D626F426F7850726F6772616D2E4974656D7301457870
      6572696D656E742C53696D756C61746F7201DDEAF1EFE5F0E8ECE5EDF22CD2F0
      E5EDE0E6E5F0010D0A526164696F47726F75706368616E6765557365724C6576
      656C2E4974656D73014E6F2C59657301CDE5F22CC4E0010D0A7374537472696E
      67730D0A73744F74686572537472696E67730D0A436F6D626F426F78312E5465
      787401436F6D626F426F783101010D0A436F6D626F426F7850726F6772616D2E
      54657874014578706572696D656E7401010D0A7374436F6C6C656374696F6E73
      0D0A737443686172536574730D0A54466F726D50726F6772616D53657474696E
      67730144454641554C545F43484152534554015255535349414E5F4348415253
      4554010D0A}
  end
end
