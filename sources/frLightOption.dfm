object LightOption: TLightOption
  Left = 528
  Top = 190
  Caption = 'Light Options'
  ClientHeight = 516
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBottom: TPanel
    Left = 0
    Top = 459
    Width = 449
    Height = 57
    Align = alBottom
    TabOrder = 0
    object BitBtnCancel: TBitBtn
      Left = 267
      Top = 16
      Width = 76
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtnCancelClick
      NumGlyphs = 2
    end
    object BitBtnDef: TBitBtn
      Left = 25
      Top = 17
      Width = 104
      Height = 24
      Caption = 'Default'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtnDefClick
    end
    object BitBtnOk: TBitBtn
      Left = 150
      Top = 16
      Width = 75
      Height = 25
      Caption = '&OK'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtnOKClick
      NumGlyphs = 2
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 463
    Height = 248
    ActivePage = TabSheetP
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheetP: TTabSheet
      Caption = ' Position'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object PanelLP: TPanel
        Left = 0
        Top = 0
        Width = 358
        Height = 223
        TabOrder = 0
        object PanelL: TPanel
          Left = 1
          Top = 1
          Width = 207
          Height = 221
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Label2: TLabel
            Left = 46
            Top = 27
            Width = 57
            Height = 16
            Caption = 'Position'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelX1: TLabel
            Left = 72
            Top = 50
            Width = 9
            Height = 13
            Caption = 'X'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelY1: TLabel
            Left = 72
            Top = 85
            Width = 9
            Height = 13
            Caption = 'Y'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelZ1: TLabel
            Left = 72
            Top = 121
            Width = 9
            Height = 13
            Caption = 'Z'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label10: TLabel
            Left = 54
            Top = 13
            Width = 46
            Height = 16
            Caption = 'Light 1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object TrackBarX1: TTrackBar
            Left = 15
            Top = 64
            Width = 128
            Height = 21
            Max = 100
            Min = -100
            Frequency = 2
            TabOrder = 0
            ThumbLength = 10
            OnChange = TrackBarX1Change
          end
          object TrackBarZ1: TTrackBar
            Left = 16
            Top = 137
            Width = 127
            Height = 26
            Max = 100
            Min = -100
            Frequency = 2
            TabOrder = 1
            ThumbLength = 10
            OnChange = TrackBarZ1Change
          end
          object TrackBarY1: TTrackBar
            Left = 15
            Top = 101
            Width = 130
            Height = 21
            Max = 100
            Min = -100
            Frequency = 2
            TabOrder = 2
            ThumbLength = 10
            OnChange = TrackBarY1Change
          end
        end
        object PanelC: TPanel
          Left = 208
          Top = 1
          Width = 150
          Height = 221
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object Label6: TLabel
            Left = 31
            Top = 33
            Width = 57
            Height = 16
            Caption = 'Position'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelX2: TLabel
            Left = 58
            Top = 54
            Width = 9
            Height = 13
            Caption = 'X'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelY2: TLabel
            Left = 59
            Top = 87
            Width = 9
            Height = 13
            Caption = 'Y'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelZ2: TLabel
            Left = 60
            Top = 125
            Width = 9
            Height = 13
            Caption = 'Z'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label11: TLabel
            Left = 36
            Top = 16
            Width = 46
            Height = 16
            Caption = 'Light 2'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object TrackBarX2: TTrackBar
            Left = 2
            Top = 65
            Width = 133
            Height = 23
            Max = 100
            Min = -100
            Frequency = 2
            TabOrder = 0
            ThumbLength = 10
            OnChange = TrackBarX2Change
          end
          object TrackBarY2: TTrackBar
            Left = 3
            Top = 105
            Width = 129
            Height = 22
            Max = 100
            Min = -100
            Frequency = 2
            TabOrder = 1
            ThumbLength = 10
            OnChange = TrackBarY2Change
          end
          object TrackBarZ2: TTrackBar
            Left = 3
            Top = 139
            Width = 130
            Height = 21
            Max = 100
            Min = -100
            Frequency = 2
            TabOrder = 2
            ThumbLength = 10
            OnChange = TrackBarZ2Change
          end
        end
      end
    end
    object TabSheetAm: TTabSheet
      Caption = 'Ambient Color'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 457
        Height = 223
        Align = alClient
        TabOrder = 0
        object Panel6: TPanel
          Left = 1
          Top = 1
          Width = 455
          Height = 221
          Align = alClient
          TabOrder = 0
          object Label1: TLabel
            Left = 91
            Top = 25
            Width = 10
            Height = 13
            Caption = 'R'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label3: TLabel
            Left = 91
            Top = 68
            Width = 10
            Height = 13
            Caption = 'G'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label4: TLabel
            Left = 91
            Top = 103
            Width = 9
            Height = 13
            Caption = 'B'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object TrackBarRA: TTrackBar
            Left = 14
            Top = 41
            Width = 150
            Height = 26
            Max = 255
            TabOrder = 0
            ThumbLength = 10
            OnChange = TrackBarRAChange
          end
          object TrackBarGA: TTrackBar
            Left = 15
            Top = 80
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 1
            ThumbLength = 10
            OnChange = TrackBarGAChange
          end
          object TrackBarBA: TTrackBar
            Left = 17
            Top = 121
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 2
            ThumbLength = 10
            OnChange = TrackBarBAChange
          end
        end
        object Panel9: TPanel
          Left = 202
          Top = 1
          Width = 215
          Height = 221
          TabOrder = 1
          object ImageA: TImage
            Left = 1
            Top = 1
            Width = 213
            Height = 219
            Align = alClient
          end
        end
      end
    end
    object TabSheetD: TTabSheet
      Caption = 'Diffuse Color'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 457
        Height = 223
        Align = alClient
        TabOrder = 0
        object Panel7: TPanel
          Left = 195
          Top = 1
          Width = 158
          Height = 221
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object ImageD: TImage
            Left = 2
            Top = 2
            Width = 154
            Height = 217
            Align = alClient
          end
        end
        object Panel10: TPanel
          Left = 1
          Top = 1
          Width = 192
          Height = 221
          TabOrder = 1
          object Label7: TLabel
            Left = 88
            Top = 18
            Width = 10
            Height = 13
            Caption = 'R'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label8: TLabel
            Left = 88
            Top = 67
            Width = 10
            Height = 13
            Caption = 'G'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label9: TLabel
            Left = 81
            Top = 110
            Width = 9
            Height = 13
            Caption = 'B'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object TrackBarRD: TTrackBar
            Left = 24
            Top = 41
            Width = 150
            Height = 26
            Max = 255
            TabOrder = 0
            ThumbLength = 10
            OnChange = TrackBarRDChange
          end
          object TrackBarGD: TTrackBar
            Left = 24
            Top = 83
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 1
            ThumbLength = 10
            OnChange = TrackBarGDChange
          end
          object TrackBarBD: TTrackBar
            Left = 24
            Top = 128
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 2
            ThumbLength = 10
            OnChange = TrackBarBDChange
          end
        end
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
    Left = 160
    Top = 360
    TranslationData = {
      737443617074696F6E730D0A544C696768744F7074696F6E014C69676874204F
      7074696F6E7301CFE0F0E0ECE5F2F0FB20EEF1E2E5F9E5EDE8FF010D0A50616E
      656C426F74746F6D0101010D0A42697442746E43616E63656C0143616E63656C
      01CE26F2ECE5EDE0010D0A42697442746E4465660144656661756C7401CFEE20
      F3ECEEEBF7E0EDE8FE010D0A42697442746E4F6B01264F4B0126CECA010D0A54
      61625368656574500120506F736974696F6E01CFEEEBEEE6E5EDE8E5010D0A50
      616E656C4C500101010D0A50616E656C4C0101010D0A4C6162656C3201506F73
      6974696F6E01CFEEEBEEE6E5EDE8E5010D0A4C6162656C5831015801010D0A4C
      6162656C5931015901010D0A4C6162656C5A31015A01010D0A4C6162656C3130
      014C69676874203101C8F1F2EEF7EDE8EA2031010D0A50616E656C430101010D
      0A4C6162656C3601506F736974696F6E01CFEEEBEEE6E5EDE8E5010D0A4C6162
      656C5832015801010D0A4C6162656C5932015901010D0A4C6162656C5A32015A
      01010D0A4C6162656C3131014C69676874203201C8F1F2EEF7EDE8EA2032010D
      0A5461625368656574416D01416D6269656E7420436F6C6F7201D0E0F1F1E5FF
      EDFBE920F6E2E5F2010D0A50616E656C330101010D0A50616E656C360101010D
      0A4C6162656C31015201010D0A4C6162656C33014701010D0A4C6162656C3401
      4201010D0A50616E656C390101010D0A54616253686565744401446966667573
      6520436F6C6F7201C4E8F4F4F3E7E8EEEDEDFBE920F6E2E5F2010D0A50616E65
      6C340101010D0A50616E656C370101010D0A50616E656C31300101010D0A4C61
      62656C37015201010D0A4C6162656C38014701010D0A4C6162656C3901420101
      0D0A737448696E74730D0A544C696768744F7074696F6E0101010D0A50616E65
      6C426F74746F6D0101010D0A42697442746E43616E63656C0101010D0A426974
      42746E4465660101010D0A42697442746E4F6B0101010D0A50616765436F6E74
      726F6C310101010D0A5461625368656574500101010D0A50616E656C4C500101
      010D0A50616E656C4C0101010D0A4C6162656C320101010D0A4C6162656C5831
      0101010D0A4C6162656C59310101010D0A4C6162656C5A310101010D0A4C6162
      656C31300101010D0A547261636B42617258310101010D0A547261636B426172
      5A310101010D0A547261636B42617259310101010D0A50616E656C430101010D
      0A4C6162656C360101010D0A4C6162656C58320101010D0A4C6162656C593201
      01010D0A4C6162656C5A320101010D0A4C6162656C31310101010D0A54726163
      6B42617258320101010D0A547261636B42617259320101010D0A547261636B42
      61725A320101010D0A5461625368656574416D0101010D0A50616E656C330101
      010D0A50616E656C360101010D0A4C6162656C310101010D0A4C6162656C3301
      01010D0A4C6162656C340101010D0A547261636B42617252410101010D0A5472
      61636B42617247410101010D0A547261636B42617242410101010D0A50616E65
      6C390101010D0A496D616765410101010D0A5461625368656574440101010D0A
      50616E656C340101010D0A50616E656C370101010D0A496D616765440101010D
      0A50616E656C31300101010D0A4C6162656C370101010D0A4C6162656C380101
      010D0A4C6162656C390101010D0A547261636B42617252440101010D0A547261
      636B42617247440101010D0A547261636B42617242440101010D0A7374446973
      706C61794C6162656C730D0A7374466F6E74730D0A544C696768744F7074696F
      6E014D532053616E7320536572696601417269616C010D0A42697442746E4361
      6E63656C014D532053616E7320536572696601417269616C010D0A4269744274
      6E446566014D532053616E7320536572696601417269616C010D0A4269744274
      6E4F6B014D532053616E7320536572696601417269616C010D0A4C6162656C32
      014D532053616E7320536572696601417269616C010D0A4C6162656C5831014D
      532053616E7320536572696601417269616C010D0A4C6162656C5931014D5320
      53616E7320536572696601417269616C010D0A4C6162656C5A31014D53205361
      6E7320536572696601417269616C010D0A4C6162656C3130014D532053616E73
      20536572696601417269616C010D0A4C6162656C36014D532053616E73205365
      72696601417269616C010D0A4C6162656C5832014D532053616E732053657269
      6601417269616C010D0A4C6162656C5932014D532053616E7320536572696601
      417269616C010D0A4C6162656C5A32014D532053616E73205365726966014172
      69616C010D0A4C6162656C3131014D532053616E732053657269660141726961
      6C010D0A4C6162656C31014D532053616E7320536572696601417269616C010D
      0A4C6162656C33014D532053616E7320536572696601417269616C010D0A4C61
      62656C34014D532053616E7320536572696601417269616C010D0A4C6162656C
      37014D532053616E7320536572696601417269616C010D0A4C6162656C38014D
      532053616E7320536572696601417269616C010D0A4C6162656C39014D532053
      616E7320536572696601417269616C010D0A73744D756C74694C696E65730D0A
      7374537472696E67730D0A73744F74686572537472696E67730D0A544C696768
      744F7074696F6E2E48656C7046696C650101010D0A7374436F6C6C656374696F
      6E730D0A737443686172536574730D0A544C696768744F7074696F6E01444546
      41554C545F43484152534554015255535349414E5F43484152534554010D0A42
      697442746E43616E63656C0144454641554C545F434841525345540152555353
      49414E5F43484152534554010D0A42697442746E4465660144454641554C545F
      43484152534554015255535349414E5F43484152534554010D0A42697442746E
      4F6B0144454641554C545F43484152534554015255535349414E5F4348415253
      4554010D0A4C6162656C320144454641554C545F434841525345540152555353
      49414E5F43484152534554010D0A4C6162656C58310144454641554C545F4348
      4152534554015255535349414E5F43484152534554010D0A4C6162656C593101
      44454641554C545F43484152534554015255535349414E5F4348415253455401
      0D0A4C6162656C5A310144454641554C545F4348415253455401525553534941
      4E5F43484152534554010D0A4C6162656C31300144454641554C545F43484152
      534554015255535349414E5F43484152534554010D0A4C6162656C3601444546
      41554C545F43484152534554015255535349414E5F43484152534554010D0A4C
      6162656C58320144454641554C545F43484152534554015255535349414E5F43
      484152534554010D0A4C6162656C59320144454641554C545F43484152534554
      015255535349414E5F43484152534554010D0A4C6162656C5A32014445464155
      4C545F43484152534554015255535349414E5F43484152534554010D0A4C6162
      656C31310144454641554C545F43484152534554015255535349414E5F434841
      52534554010D0A4C6162656C310144454641554C545F43484152534554015255
      535349414E5F43484152534554010D0A4C6162656C330144454641554C545F43
      484152534554015255535349414E5F43484152534554010D0A4C6162656C3401
      44454641554C545F43484152534554015255535349414E5F4348415253455401
      0D0A4C6162656C370144454641554C545F43484152534554015255535349414E
      5F43484152534554010D0A4C6162656C380144454641554C545F434841525345
      54015255535349414E5F43484152534554010D0A4C6162656C39014445464155
      4C545F43484152534554015255535349414E5F43484152534554010D0A}
  end
end
