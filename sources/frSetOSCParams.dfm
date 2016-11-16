object OSCParams: TOSCParams
  Left = 0
  Top = 0
  Caption = 'Set OSC  Parameters'
  ClientHeight = 591
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 455
    Height = 591
    Align = alClient
    TabOrder = 0
    object Panel2: TPanel
      Left = 2
      Top = 105
      Width = 453
      Height = 224
      TabOrder = 0
      object IndValue: TLabeledEdit
        Left = 80
        Top = 24
        Width = 121
        Height = 21
        EditLabel.Width = 42
        EditLabel.Height = 13
        EditLabel.Caption = 'IndValue'
        LabelPosition = lpLeft
        TabOrder = 0
      end
      object LabeledEdit2: TLabeledEdit
        Left = 80
        Top = 75
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'LabeledEdit1'
        LabelPosition = lpLeft
        TabOrder = 1
      end
      object LabeledEdit3: TLabeledEdit
        Left = 80
        Top = 203
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'LabeledEdit1'
        LabelPosition = lpLeft
        TabOrder = 2
      end
      object LabeledEdit4: TLabeledEdit
        Left = 80
        Top = 117
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'LabeledEdit1'
        LabelPosition = lpLeft
        TabOrder = 3
      end
      object LabeledEdit5: TLabeledEdit
        Left = 80
        Top = 160
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'LabeledEdit1'
        LabelPosition = lpLeft
        TabOrder = 4
      end
      object LabeledEdit6: TLabeledEdit
        Left = 280
        Top = 24
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'LabeledEdit1'
        LabelPosition = lpLeft
        TabOrder = 5
      end
      object LabeledEdit7: TLabeledEdit
        Left = 280
        Top = 75
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'LabeledEdit1'
        LabelPosition = lpLeft
        TabOrder = 6
      end
      object LabeledEdit8: TLabeledEdit
        Left = 280
        Top = 117
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'LabeledEdit1'
        LabelPosition = lpLeft
        TabOrder = 7
      end
      object LabeledEdit9: TLabeledEdit
        Left = 280
        Top = 160
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'LabeledEdit1'
        LabelPosition = lpLeft
        TabOrder = 8
      end
      object LabeledEdit10: TLabeledEdit
        Left = 280
        Top = 208
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'LabeledEdit1'
        LabelPosition = lpLeft
        TabOrder = 9
      end
      object LabeledEdit11: TLabeledEdit
        Left = 80
        Top = 237
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'LabeledEdit1'
        LabelPosition = lpLeft
        TabOrder = 10
      end
    end
    object MainPanel: TPanel
      Left = 0
      Top = -3
      Width = 453
      Height = 289
      TabOrder = 1
      object Label9: TLabel
        Left = 80
        Top = 8
        Width = 63
        Height = 13
        Caption = 'First Channel'
      end
      object Label10: TLabel
        Left = 307
        Top = 8
        Width = 77
        Height = 13
        Caption = 'Second Channel'
      end
      object bitbtnOK: TBitBtn
        Left = 176
        Top = 73
        Width = 75
        Height = 25
        Caption = 'Apply'
        TabOrder = 0
        OnClick = bitbtnOKClick
      end
      object ComboBox1: TComboBox
        Left = 40
        Top = 27
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Text = 'None'
        OnChange = ComboBox1Change
        Items.Strings = (
          'None')
      end
      object ComboBox2: TComboBox
        Left = 256
        Top = 27
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        Text = 'None'
        OnChange = ComboBox2Change
        Items.Strings = (
          'None')
      end
      object StringGridChannels: TStringGrid
        Left = 9
        Top = 111
        Width = 432
        Height = 255
        ColCount = 2
        TabOrder = 3
        ColWidths = (
          64
          363)
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
    Left = 312
    Top = 80
    TranslationData = {
      737443617074696F6E730D0A544F5343506172616D7301536574204F53432020
      506172616D657465727301CDE0F1F2F0EEE9EAE020EEF1F6E8EBEBEEE3F0E0F4
      E0010D0A4C6162656C39014669727374204368616E6E656C01CFE5F0E2FBE920
      EAE0EDE0EB010D0A4C6162656C3130015365636F6E64204368616E6E656C01C2
      F2EEF0EEE920EAE0EDE0EB010D0A62697462746E4F4B014170706C7901CFF0E8
      ECE5EDE8F2FC010D0A737448696E74730D0A7374446973706C61794C6162656C
      730D0A7374466F6E74730D0A544F5343506172616D73015461686F6D61015461
      686F6D61010D0A73744D756C74694C696E65730D0A436F6D626F426F78312E49
      74656D73014E6F6E6501010D0A436F6D626F426F78322E4974656D73014E6F6E
      6501010D0A7374537472696E67730D0A7374727374724368616E6E656C6E616D
      65014368616E6E656C01CAE0EDE0EB010D0A7374727374724465736372697074
      696F6E014465736372697074696F6E01CEEFE8F1E0EDE8E5010D0A7374727374
      724368616E6E656C5F4C52580141444320466F72636501D1E8EBE020F0E0F1EA
      E0F7EAE820E7EEEDE4E020010D0A7374727374724368616E6E656C5F4101566F
      6C74616765204D6F64756C6174696F6E01C0ECEFEBE8F2F3E4E020F0E0F1EAE0
      F7EAE820E7EEEDE4E0010D0A7374727374724368616E6E656C5F506801202050
      6861736501D4E0E7E020010D0A7374727374724368616E6E656C5F5A01536361
      6E6E696E67207369676E616C205A01CAEEEEF0E4E8EDE0F2E020F1EAE0EDE5F0
      E0205A010D0A7374727374724368616E6E656C5F5501566F6C7461676501CDE0
      EFF0FFE6E5EDE8E5010D0A7374727374724368616E6E656C5F58015363616E6E
      696E67207369676E616C205801CAEEEEF0E4E8EDE0F2E020F1EAE0EDE5F0E020
      58010D0A7374727374724368616E6E656C5F59015363616E6E696E6720736967
      6E616C205901CAEEEEF0E4E8EDE0F2E020F1EAE0EDE5F0E02059010D0A737472
      7374724368616E6E656C5F49014144432043757272656E7401D2EEEA20ECE5E6
      E4F320E7EEEDE4EEEC20E820EEE1F0E0E7F6EEEC010D0A737472737472436861
      6E6E656C5F4801504944204F757470757401C2FBF1EEF2E020F0E5EBFCE5F4E0
      20EEE1F0E0E7F6E0010D0A7374727374724368616E6E656C5F65727201466F72
      636520496D61676501D1E8EBE020E2E7E0E8ECEEE4E5E9F1F2E2E8FF010D0A73
      74727374724368616E6E656C5F645A015A204269617301CFEEE4F1F2E0E2EAE0
      205A010D0A73744F74686572537472696E67730D0A436F6D626F426F78312E54
      657874014E6F6E6501010D0A436F6D626F426F78322E54657874014E6F6E6501
      010D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A544F
      5343506172616D730144454641554C545F43484152534554015255535349414E
      5F43484152534554010D0A}
  end
end
