object SetInteraction: TSetInteraction
  Left = 582
  Top = 255
  BorderIcons = []
  Caption = 'Set Interaction Parameters'
  ClientHeight = 334
  ClientWidth = 400
  Color = 14474715
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 334
    Align = alClient
    BevelInner = bvLowered
    BorderStyle = bsSingle
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 229
      Top = 10
      Width = 70
      Height = 16
      Hint = 'Oscillation Amplitude Suppression Koefficient'
      Caption = 'Amplitude'
      ParentShowHint = False
      ShowHint = True
    end
    object Label2: TLabel
      Left = 226
      Top = 30
      Width = 88
      Height = 16
      Caption = 'Suppression'
    end
    object Label3: TLabel
      Left = 55
      Top = 225
      Width = 120
      Height = 16
      Caption = 'Interaction Power'
    end
    object Label5: TLabel
      Left = 134
      Top = 39
      Width = 29
      Height = 16
      Caption = 'Max'
      Visible = False
    end
    object Label6: TLabel
      Left = 136
      Top = 202
      Width = 25
      Height = 16
      Caption = 'Min'
      Visible = False
    end
    object lblSuppress: TLabel
      Left = 225
      Top = 89
      Width = 84
      Height = 16
      Caption = 'lblSuppress'
    end
    object AMLabel: TLabel
      Left = 30
      Top = 104
      Width = 62
      Height = 16
      Caption = 'AMLabel'
    end
    object Label4: TLabel
      Left = 23
      Top = 2
      Width = 43
      Height = 16
      Caption = 'Probe'
    end
    object Label7: TLabel
      Left = 23
      Top = 18
      Width = 135
      Height = 16
      Caption = 'Voltage Modulation'
    end
    object Label8: TLabel
      Left = 23
      Top = 36
      Width = 70
      Height = 16
      Caption = 'Amplitude'
    end
    object tbSuppress: TTrackBar
      Left = 181
      Top = 34
      Width = 30
      Height = 185
      BorderWidth = 2
      Orientation = trVertical
      TabOrder = 0
      ThumbLength = 15
      OnChange = tbSuppressChange
    end
    object OKBitBtn: TBitBtn
      Left = 50
      Top = 286
      Width = 76
      Height = 26
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
      OnClick = OKBitBtnClick
      Layout = blGlyphTop
    end
    object BtnSpectr: TButton
      Left = 250
      Top = 194
      Width = 130
      Height = 32
      Caption = '&Spectroscopy'
      Enabled = False
      TabOrder = 2
      OnClick = ButtonSpectrClick
    end
    object BitBtnCancel: TBitBtn
      Left = 158
      Top = 287
      Width = 76
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 3
      OnClick = BitBtnCancelClick
      NumGlyphs = 2
    end
    object BitBtnHelp: TBitBtn
      Left = 270
      Top = 287
      Width = 76
      Height = 24
      Caption = '&Help'
      TabOrder = 4
      OnClick = BitBtnHelpClick
      NumGlyphs = 2
    end
    object ProgressBar: TProgressBar
      Left = 50
      Top = 251
      Width = 150
      Height = 17
      BorderWidth = 2
      Smooth = True
      Step = 1
      TabOrder = 5
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
    Left = 240
    Top = 144
    TranslationData = {
      737443617074696F6E730D0A54536574496E746572616374696F6E0153657420
      496E746572616374696F6E20506172616D657465727301D3F1F2E0EDEEE2E8F2
      FC20EFE0F0E0ECE5F2F0FB20E2E7E0E8ECEEE4E5E9F1F2E2E8FF010D0A50616E
      656C320101010D0A4C6162656C3101416D706C697475646501CFEEE4E0E2EBE5
      EDE8E5010D0A4C6162656C32015375707072657373696F6E01C0ECEFEBE8F2F3
      E4FB010D0A4C6162656C3301496E746572616374696F6E20506F77657201C2E7
      E0E8ECEEE4E5E9F1F2E2E8E5010D0A4C6162656C35014D6178014DE0EAF12E01
      0D0A4C6162656C36014D696E014DE8ED2E010D0A6C626C537570707265737301
      6C626C537570707265737301010D0A414D4C6162656C01414D4C6162656C0101
      0D0A4F4B42697442746E01264F4B0126CECA010D0A42746E5370656374720126
      5370656374726F73636F707901D1EFE5EAF2F0EEF1EAEEEFE8FF010D0A426974
      42746E43616E63656C012643616E63656C01CE26F2ECE5EDE0010D0A42697442
      746E48656C70012648656C7001D126EFF0E0E2EAE0010D0A4C6162656C340150
      726F626501CDE0EFF0FFE6E5EDE8E5010D0A4C6162656C3701566F6C74616765
      204D6F64756C6174696F6E01F0E0F1EAE0F7EAE8010D0A4C6162656C3801416D
      706C697475646501E7EEEDE4E0010D0A737448696E74730D0A54536574496E74
      6572616374696F6E0101010D0A50616E656C320101010D0A4C6162656C31014F
      7363696C6C6174696F6E20416D706C6974756465205375707072657373696F6E
      204B6F656666696369656E7401CAEEFDF4F4E8F6E8E5EDF220EFEEE4E0E2EBE5
      EDE8FF20E0ECEFEBE8F2F3E4FB20EAEEEBE5E1E0EDE8E9010D0A4C6162656C32
      0101010D0A4C6162656C330101010D0A4C6162656C350101010D0A4C6162656C
      360101010D0A6C626C53757070726573730101010D0A414D4C6162656C010101
      0D0A746253757070726573730101010D0A4F4B42697442746E0101010D0A4274
      6E5370656374720101010D0A42697442746E43616E63656C0101010D0A426974
      42746E48656C700101010D0A4C6162656C340101010D0A4C6162656C37010101
      0D0A4C6162656C380101010D0A50726F67726573734261720101010D0A737444
      6973706C61794C6162656C730D0A7374466F6E74730D0A54536574496E746572
      616374696F6E014D532053616E7320536572696601417269616C010D0A50616E
      656C32014D532053616E7320536572696601417269616C010D0A73744D756C74
      694C696E65730D0A7374537472696E67730D0A737472737472310120206D5601
      20ECC2010D0A73744F74686572537472696E67730D0A54536574496E74657261
      6374696F6E2E48656C7046696C650101010D0A7374436F6C6C656374696F6E73
      0D0A737443686172536574730D0A54536574496E746572616374696F6E014445
      4641554C545F43484152534554015255535349414E5F43484152534554010D0A
      50616E656C320144454641554C545F43484152534554015255535349414E5F43
      484152534554010D0A}
  end
end
