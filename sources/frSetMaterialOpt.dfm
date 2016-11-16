object SetMaterialOption: TSetMaterialOption
  Left = 249
  Top = 125
  Caption = 'Material Options'
  ClientHeight = 506
  ClientWidth = 477
  Color = clBlack
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 477
    Height = 281
    Align = alTop
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 90
      Top = 232
      Width = 111
      Height = 13
      Caption = 'Base Color Material'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object material: TComboBox
      Left = 88
      Top = 255
      Width = 118
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
      Text = 'izumrud'
      OnSelect = materialSelect
      Items.Strings = (
        'izumrud'
        'brass'
        'bronze'
        'chrom'
        'cuprum'
        'gold'
        'silver'
        'custom')
    end
    object PageControl1: TPageControl
      Left = 8
      Top = 8
      Width = 337
      Height = 217
      ActivePage = TabSheet1
      TabOrder = 2
      object TabSheet4: TTabSheet
        Caption = 'Diffusion'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 178
          Height = 192
          Align = alClient
          ParentBackground = False
          TabOrder = 0
          object Label8: TLabel
            Left = 88
            Top = 16
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
          object Label9: TLabel
            Left = 88
            Top = 72
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
          object Label10: TLabel
            Left = 88
            Top = 120
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
            Left = 10
            Top = 40
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 0
            ThumbLength = 10
            OnChange = TrackBarRDChange
          end
          object TrackBarGD: TTrackBar
            Left = 10
            Top = 88
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 1
            ThumbLength = 10
            OnChange = TrackBarGDChange
          end
          object TrackBarBD: TTrackBar
            Left = 10
            Top = 136
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 2
            ThumbLength = 10
            OnChange = TrackBarBDChange
          end
        end
        object Panel6: TPanel
          Left = 178
          Top = 0
          Width = 153
          Height = 192
          Align = alRight
          TabOrder = 1
          object ImageD: TImage
            Left = 1
            Top = 1
            Width = 151
            Height = 190
            Align = alClient
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Emission'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel2: TPanel
          Left = 202
          Top = 0
          Width = 129
          Height = 192
          Align = alRight
          TabOrder = 0
          object ImageEm: TImage
            Left = 1
            Top = 1
            Width = 127
            Height = 190
            Align = alClient
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 202
          Height = 192
          Align = alClient
          ParentBackground = False
          TabOrder = 1
          object Label5: TLabel
            Left = 80
            Top = 8
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
          object Label6: TLabel
            Left = 80
            Top = 64
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
          object Label7: TLabel
            Left = 80
            Top = 120
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
          object TrackBarRE: TTrackBar
            Left = 16
            Top = 32
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 0
            ThumbLength = 10
            OnChange = TrackBarREChange
          end
          object TrackBarGE: TTrackBar
            Left = 16
            Top = 80
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 1
            ThumbLength = 10
            OnChange = TrackBarGEChange
          end
          object TrackBarBE: TTrackBar
            Left = 16
            Top = 136
            Width = 150
            Height = 17
            Max = 255
            TabOrder = 2
            ThumbLength = 10
            OnChange = TrackBarBEChange
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Shininess'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object LabelSH: TLabel
          Left = 112
          Top = 48
          Width = 3
          Height = 13
        end
        object TrackBarSH: TTrackBar
          Left = 56
          Top = 72
          Width = 150
          Height = 45
          Max = 128
          TabOrder = 0
          ThumbLength = 10
          OnChange = TrackBarSHChange
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Specular'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object PanelImS: TPanel
          Left = 184
          Top = 0
          Width = 147
          Height = 192
          Align = alRight
          TabOrder = 0
          object ImageSp: TImage
            Left = 1
            Top = 1
            Width = 144
            Height = 190
            Align = alClient
            Stretch = True
          end
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 184
          Height = 192
          Align = alClient
          ParentBackground = False
          TabOrder = 1
          object Label2: TLabel
            Left = 80
            Top = 16
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
            Left = 80
            Top = 72
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
            Left = 80
            Top = 120
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
          object TrackBarRS: TTrackBar
            Left = 16
            Top = 32
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 0
            ThumbLength = 10
            OnChange = TrackBarRSChange
          end
          object TrackBarGS: TTrackBar
            Left = 16
            Top = 88
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 1
            ThumbLength = 10
            OnChange = TrackBarGSChange
          end
          object TrackBarBS: TTrackBar
            Left = 16
            Top = 144
            Width = 150
            Height = 25
            Max = 255
            TabOrder = 2
            ThumbLength = 10
            OnChange = TrackBarBSChange
          end
        end
      end
    end
    object BitBtnD: TBitBtn
      Left = 352
      Top = 80
      Width = 113
      Height = 25
      Caption = '&Default'
      Default = True
      ModalResult = 1
      TabOrder = 1
      OnClick = BitBtnDClick
      NumGlyphs = 2
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
    Left = 184
    Top = 376
    TranslationData = {
      737443617074696F6E730D0A545365744D6174657269616C4F7074696F6E014D
      6174657269616C204F7074696F6E7301CFE0F0E0ECE5F2F0FB20ECE0F2E5F0E8
      E0EBE0010D0A50616E656C310101010D0A4C6162656C31014261736520436F6C
      6F72204D6174657269616C01C1E0E7EEE2FBE920F6E2E5F2010D0A5461625368
      6565743401446966667573696F6E01C4E8F4F4F3E7E8FF010D0A50616E656C35
      0101010D0A4C6162656C38015201010D0A4C6162656C39014701010D0A4C6162
      656C3130014201010D0A50616E656C360101010D0A5461625368656574320145
      6D697373696F6E01DDECE8F1F1E8FF010D0A50616E656C320101010D0A50616E
      656C340101010D0A4C6162656C35015201010D0A4C6162656C36014701010D0A
      4C6162656C37014201010D0A546162536865657433015368696E696E65737301
      CEF1E2E5F9E5EDEDEEF1F2FC010D0A4C6162656C53480101010D0A5461625368
      656574310153706563756C617201C7E5F0EAE0EBFCEDEEF1F2FC010D0A50616E
      656C496D530101010D0A50616E656C330101010D0A4C6162656C32015201010D
      0A4C6162656C33014701010D0A4C6162656C34014201010D0A42697442746E44
      012644656661756C7401CFEE20F3ECEEEBF7E0EDE8FE010D0A737448696E7473
      0D0A545365744D6174657269616C4F7074696F6E01010D0A50616E656C310101
      010D0A4C6162656C310101010D0A6D6174657269616C0101010D0A5061676543
      6F6E74726F6C310101010D0A5461625368656574340101010D0A50616E656C35
      0101010D0A4C6162656C380101010D0A4C6162656C390101010D0A4C6162656C
      31300101010D0A547261636B42617252440101010D0A547261636B4261724744
      0101010D0A547261636B42617242440101010D0A50616E656C360101010D0A49
      6D616765440101010D0A5461625368656574320101010D0A50616E656C320101
      010D0A496D616765456D0101010D0A50616E656C340101010D0A4C6162656C35
      0101010D0A4C6162656C360101010D0A4C6162656C370101010D0A547261636B
      42617252450101010D0A547261636B42617247450101010D0A547261636B4261
      7242450101010D0A5461625368656574330101010D0A4C6162656C5348010101
      0D0A547261636B42617253480101010D0A5461625368656574310101010D0A50
      616E656C496D530101010D0A496D61676553700101010D0A50616E656C330101
      010D0A4C6162656C320101010D0A4C6162656C330101010D0A4C6162656C3401
      01010D0A547261636B42617252530101010D0A547261636B4261724753010101
      0D0A547261636B42617242530101010D0A42697442746E440101010D0A737444
      6973706C61794C6162656C730D0A7374466F6E74730D0A545365744D61746572
      69616C4F7074696F6E014D532053616E7320536572696601417269616C010D0A
      4C6162656C31014D532053616E7320536572696601417269616C010D0A6D6174
      657269616C014D532053616E7320536572696601417269616C010D0A4C616265
      6C38014D532053616E7320536572696601417269616C010D0A4C6162656C3901
      4D532053616E7320536572696601417269616C010D0A4C6162656C3130014D53
      2053616E7320536572696601417269616C010D0A4C6162656C35014D53205361
      6E7320536572696601417269616C010D0A4C6162656C36014D532053616E7320
      536572696601417269616C010D0A4C6162656C37014D532053616E7320536572
      696601417269616C010D0A4C6162656C32014D532053616E7320536572696601
      417269616C010D0A4C6162656C33014D532053616E7320536572696601417269
      616C010D0A4C6162656C34014D532053616E7320536572696601417269616C01
      0D0A73744D756C74694C696E65730D0A6D6174657269616C2E4974656D730169
      7A756D7275642C62726173732C62726F6E7A652C6368726F6D2C63757072756D
      2C676F6C642C73696C7665722C637573746F6D01010D0A7374537472696E6773
      0D0A73744F74686572537472696E67730D0A545365744D6174657269616C4F70
      74696F6E2E48656C7046696C650101010D0A6D6174657269616C2E5465787401
      697A756D72756401010D0A7374436F6C6C656374696F6E730D0A737443686172
      536574730D0A545365744D6174657269616C4F7074696F6E0144454641554C54
      5F43484152534554015255535349414E5F43484152534554010D0A4C6162656C
      310144454641554C545F43484152534554015255535349414E5F434841525345
      54010D0A6D6174657269616C0144454641554C545F4348415253455401525553
      5349414E5F43484152534554010D0A4C6162656C380144454641554C545F4348
      4152534554015255535349414E5F43484152534554010D0A4C6162656C390144
      454641554C545F43484152534554015255535349414E5F43484152534554010D
      0A4C6162656C31300144454641554C545F43484152534554015255535349414E
      5F43484152534554010D0A4C6162656C350144454641554C545F434841525345
      54015255535349414E5F43484152534554010D0A4C6162656C36014445464155
      4C545F43484152534554015255535349414E5F43484152534554010D0A4C6162
      656C370144454641554C545F43484152534554015255535349414E5F43484152
      534554010D0A4C6162656C320144454641554C545F4348415253455401525553
      5349414E5F43484152534554010D0A4C6162656C330144454641554C545F4348
      4152534554015255535349414E5F43484152534554010D0A4C6162656C340144
      454641554C545F43484152534554015255535349414E5F43484152534554010D
      0A}
  end
end
