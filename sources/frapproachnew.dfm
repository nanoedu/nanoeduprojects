object Approach: TApproach
  Left = 416
  Top = 182
  BorderIcons = [biSystemMenu]
  Caption = 'Landing'
  ClientHeight = 455
  ClientWidth = 572
  Color = clSilver
  Constraints.MaxHeight = 560
  Constraints.MaxWidth = 650
  Constraints.MinHeight = 410
  Constraints.MinWidth = 580
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Default'
  Font.Style = [fsBold]
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object SpeedButton6: TSpeedButton
    Tag = 5
    Left = 81
    Top = 12
    Width = 40
    Height = 22
    AllowAllUp = True
    GroupIndex = 10
    OnClick = StartbtndownClick
  end
  object SpeedButton5: TSpeedButton
    Tag = 4
    Left = 11
    Top = 12
    Width = 40
    Height = 22
    AllowAllUp = True
    GroupIndex = 10
    OnClick = StartbtndownClick
  end
  object SpeedButton7: TSpeedButton
    Tag = 6
    Left = 142
    Top = 12
    Width = 40
    Height = 22
    AllowAllUp = True
    GroupIndex = 10
    OnClick = StartbtndownClick
  end
  object PanelPM: TPanel
    Left = 0
    Top = 430
    Width = 572
    Height = 25
    Align = alBottom
    Color = 14013909
    TabOrder = 0
    object LblPMtime: TLabel
      Left = 2
      Top = 5
      Width = 47
      Height = 12
      Caption = 'PM Time '
    end
    object LabelTimeval: TLabel
      Left = 104
      Top = 5
      Width = 55
      Height = 12
      Caption = 'LabelTime '
    end
    object LabelPMPause: TLabel
      Left = 264
      Top = 5
      Width = 52
      Height = 12
      Caption = 'PM Pause '
    end
    object LabelPauseval: TLabel
      Left = 330
      Top = 5
      Width = 33
      Height = 12
      Caption = 'Pause '
    end
    object ScrollBarPMTime: TScrollBar
      Left = 153
      Top = 6
      Width = 105
      Height = 16
      Max = 600
      Min = 1
      PageSize = 0
      Position = 1
      TabOrder = 0
      OnScroll = ScrollBarPMTimeScroll
    end
    object ScrollBarPMPause: TScrollBar
      Left = 371
      Top = 4
      Width = 101
      Height = 17
      Max = 16
      Min = 1
      PageSize = 0
      Position = 1
      TabOrder = 1
      OnScroll = ScrollBarPMPauseScroll
    end
  end
  object PanelMain: TPanel
    Left = 0
    Top = 79
    Width = 572
    Height = 351
    Align = alClient
    BevelOuter = bvNone
    Color = clSilver
    TabOrder = 1
    inline SignalsMode: TSignalsMod
      Left = 18
      Top = 13
      Width = 222
      Height = 220
      Color = 14474715
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Default'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      TabStop = True
      ExplicitLeft = 18
      ExplicitTop = 13
      ExplicitWidth = 222
      ExplicitHeight = 220
      inherited Panel3: TPanel
        Left = 10
        Top = 123
        Width = 209
        Height = 94
        Hint = 'Feed Back Loop Gain Adjustment'
        ExplicitLeft = 10
        ExplicitTop = 123
        ExplicitWidth = 209
        ExplicitHeight = 94
        inherited Label3: TLabel
          Left = 36
          Top = 2
          Hint = 'Feed Back Loop Gain Adjustment'
          Caption = '         FB  gain'
          ExplicitLeft = 36
          ExplicitTop = 2
        end
        inherited Label5: TLabel
          Left = 5
          Top = 41
          ExplicitLeft = 5
          ExplicitTop = 41
        end
        inherited Label6: TLabel
          Left = 168
          Top = 40
          ExplicitLeft = 168
          ExplicitTop = 40
        end
        inherited sbTi: TScrollBar
          Left = 5
          Top = 62
          Max = 200
          ExplicitLeft = 5
          ExplicitTop = 62
        end
      end
      inherited PageControl1: TPageControl
        Left = 13
        Top = 3
        Width = 191
        Height = 116
        ActivePage = SignalsMode.tbSTM
        ExplicitLeft = 13
        ExplicitTop = 3
        ExplicitWidth = 191
        ExplicitHeight = 116
        inherited tbSFM: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 7
          ExplicitWidth = 193
          ExplicitHeight = 116
          inherited Panel1: TPanel
            Height = 53
            ExplicitHeight = 53
            inherited LbSuppress: TLabel
              Left = 63
              Top = 29
              ExplicitLeft = 63
              ExplicitTop = 29
            end
            inherited Button1: TButton
              Left = 17
              Top = 3
              Width = 130
              Height = 22
              Caption = 'S&et Interaction'
              OnClick = SignalsModeButton1Click
              ExplicitLeft = 17
              ExplicitTop = 3
              ExplicitWidth = 130
              ExplicitHeight = 22
            end
          end
          inherited PanelGain: TPanel
            Top = 53
            Height = 63
            Hint = 'Set Phase Shift Amplifier Gain'
            ExplicitTop = 53
            ExplicitHeight = 63
            inherited Label2: TLabel
              Left = 54
              Top = 2
              Hint = 'Set Phase Shift Amplifier Gain'
              ExplicitLeft = 54
              ExplicitTop = 2
            end
            inherited GainFMBtn: TButton
              Left = 15
              Top = 22
              Width = 130
              Height = 23
              Hint = 'Set Phase Shift Amplifier Gain'
              ExplicitLeft = 15
              ExplicitTop = 22
              ExplicitWidth = 130
              ExplicitHeight = 23
            end
          end
        end
        inherited tbSTM: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 7
          ExplicitWidth = 183
          ExplicitHeight = 105
          inherited Panel4: TPanel
            Width = 183
            Height = 51
            ExplicitWidth = 183
            ExplicitHeight = 51
            inherited Label1: TLabel
              Left = 8
              Top = 9
              Width = 133
              Caption = '    Set Point: current'
              ExplicitLeft = 8
              ExplicitTop = 9
              ExplicitWidth = 133
            end
            inherited btnSetPoint: TButton
              Left = 29
              Top = 25
              Width = 124
              Height = 23
              OnClick = SignalsModebtnSetPointClick
              ExplicitLeft = 29
              ExplicitTop = 25
              ExplicitWidth = 124
              ExplicitHeight = 23
            end
          end
          inherited PanelBias: TPanel
            Top = 51
            Width = 183
            Height = 54
            ExplicitTop = 51
            ExplicitWidth = 183
            ExplicitHeight = 54
            inherited Label4: TLabel
              Left = 50
              Top = 2
              ExplicitLeft = 50
              ExplicitTop = 2
            end
            inherited BtnBiasV: TBitBtn
              Left = 27
              Top = 22
              Width = 130
              Height = 23
              OnClick = SignalsModeBtnBiasVClick
              ExplicitLeft = 27
              ExplicitTop = 22
              ExplicitWidth = 130
              ExplicitHeight = 23
            end
          end
        end
        inherited tbSFMCUR: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 7
          ExplicitWidth = 193
          ExplicitHeight = 116
          inherited Panel6: TPanel
            Height = 55
            ExplicitHeight = 55
            inherited Button2: TButton
              Left = 33
              Top = 17
              Width = 115
              Height = 19
              Hint = 'Force  Interaction Adjustment'
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              OnClick = SignalsModeButton2Click
              ExplicitLeft = 33
              ExplicitTop = 17
              ExplicitWidth = 115
              ExplicitHeight = 19
            end
          end
          inherited Panel7: TPanel
            Top = 55
            Height = 61
            ExplicitTop = 55
            ExplicitHeight = 61
            inherited Label7: TLabel
              Left = 41
              Top = 6
              ExplicitLeft = 41
              ExplicitTop = 6
            end
            inherited BtnBiasSFM: TBitBtn
              Left = 43
              Top = 28
              Width = 88
              Height = 18
              ExplicitLeft = 43
              ExplicitTop = 28
              ExplicitWidth = 88
              ExplicitHeight = 18
            end
          end
        end
      end
      inherited siLangLinkedf1: TsiLangLinked
        CommonContainer = Main.siLang1
        Left = 176
        Top = 96
        TranslationData = {
          737443617074696F6E730D0A4C6162656C330120202020202020202046422020
          6761696E01202020D3F1E8EBE5EDE8E520CED1010D0A4C6162656C36016D6178
          01ECE0EAF12E010D0A746253464D0153464D01D1D1CC010D0A427574746F6E31
          015326657420496E746572616374696F6E01D1E8EBE0010D0A4C6162656C3201
          4741494E5F464D01D3F1E8EBE5EDE8E520D4CC010D0A746253544D0153544D01
          D1D2CC010D0A4C6162656C31012020202053657420506F696E743A2063757272
          656E740120202020202020D0E0E1EEF7E8E92020F2EEEA010D0A427574746F6E
          320153657420496E746572616374696F6E01D0E0E1EEF7E0FF2020F1E8EBE001
          0D0A4C6162656C37014269617320566F6C7461676501CDE0EFF0FFE6E5EDE8E5
          010D0A42746E4269617353464D0142746E4269617353464D01010D0A4C616265
          6C35016D696E01ECE8ED2E010D0A4C6162656C4642014C6162656C464201010D
          0A4C6162656C34014269617320566F6C7461676501CDE0EFF0FFE6E5EDE8E501
          0D0A526F7567683101526F75676801010D0A46696E65310146696E6501010D0A
          737448696E74730D0A4C6162656C330146656564204261636B204C6F6F702047
          61696E2041646A7573746D656E7401D3F1E8EBE5EDE8E520EFE5F2EBE820EEF2
          F0E8F6E0F2E5EBFCEDEEE920EEE1F0E0F2EDEEE920F1E2FFE7E8010D0A427574
          746F6E3101466F72636520496E746572616374696F6E2041646A7573746D656E
          7401D3F1F2E0EDEEE2EAE020F1E8EBFB20E2E7E0E8ECEEE4E5E9F1F2E2E8FF01
          0D0A50616E656C4761696E0153657420506861736520536869667420416D706C
          6966696572204761696E01D3F1E8EBE5EDE8E520D4E0E7FB010D0A4C6162656C
          320153657420506861736520536869667420416D706C6966696572204761696E
          01D3F1E8EBE5EDE8E520D4E0E7FB010D0A4761696E464D42746E015365742050
          6861736520536869667420416D706C6966696572204761696E01D3F1E8EBE5ED
          E8E520D4E0E7FB010D0A427574746F6E3201466F7263652020496E7465726163
          74696F6E2041646A7573746D656E7401D3F1F2E0EDEEE2EAE020F1E8EBFB20E2
          E7E0E8ECEEE4E5E9F1F2E2E8FF010D0A50616E656C330146656564204261636B
          204C6F6F70204761696E2041646A7573746D656E7401010D0A7374446973706C
          61794C6162656C730D0A7374466F6E74730D0A545369676E616C734D6F640144
          656661756C74015461686F6D61010D0A4C6162656C330144656661756C740154
          61686F6D61010D0A4C6162656C360144656661756C74015461686F6D61010D0A
          4C6253757070726573730144656661756C74015461686F6D61010D0A42757474
          6F6E310144656661756C74015461686F6D61010D0A4C6162656C320144656661
          756C74015461686F6D61010D0A4C6162656C310144656661756C74015461686F
          6D61010D0A42746E42696173560144656661756C74015461686F6D61010D0A42
          7574746F6E32014D532053616E73205365726966015461686F6D61010D0A4C61
          62656C370144656661756C74015461686F6D61010D0A42746E4269617353464D
          0144656661756C74015461686F6D61010D0A4C62537570707265737349014465
          6661756C7401417269616C010D0A4C6162656C350144656661756C7401546168
          6F6D61010D0A746253464D43555201417269616C014D532053616E7320536572
          6966010D0A4C6162656C4642015461686F6D61015461686F6D61010D0A4C6162
          656C340144656661756C74015461686F6D61010D0A73744D756C74694C696E65
          730D0A7374537472696E67730D0A6964735F3301496E63726561736520746865
          206D6178696D616C2076616C7565206F6E2074686520696E64696361746F7220
          6F66207468652063757272656E742101D3E2E5EBE8F7FCF2E520ECE0EAF1E8EC
          E0EBFCEDEEE520E7EDE0F7E5EDE8E520EDE020E8EDE4E8EAE0F2EEF0E020F2EE
          EAE0010D0A73744F74686572537472696E67730D0A7374436F6C6C656374696F
          6E730D0A737443686172536574730D0A545369676E616C734D6F640152555353
          49414E5F43484152534554015255535349414E5F434841525345540D0A4C6162
          656C33015255535349414E5F43484152534554015255535349414E5F43484152
          5345540D0A4C6162656C36015255535349414E5F434841525345540152555353
          49414E5F434841525345540D0A4C625375707072657373015255535349414E5F
          43484152534554015255535349414E5F434841525345540D0A427574746F6E31
          015255535349414E5F43484152534554015255535349414E5F43484152534554
          0D0A4C6162656C32015255535349414E5F43484152534554015255535349414E
          5F434841525345540D0A4C6162656C31015255535349414E5F43484152534554
          015255535349414E5F434841525345540D0A42746E4269617356015255535349
          414E5F43484152534554015255535349414E5F434841525345540D0A42757474
          6F6E32015255535349414E5F43484152534554015255535349414E5F43484152
          5345540D0A4C6162656C37015255535349414E5F434841525345540152555353
          49414E5F434841525345540D0A42746E4269617353464D015255535349414E5F
          43484152534554015255535349414E5F434841525345540D0A4C625375707072
          65737349015255535349414E5F43484152534554015255535349414E5F434841
          52534554010D0A4C6162656C35015255535349414E5F43484152534554015255
          535349414E5F43484152534554010D0A746253464D4355520144454641554C54
          5F43484152534554015255535349414E5F43484152534554010D0A4C6162656C
          4642015255535349414E5F43484152534554015255535349414E5F4348415253
          4554010D0A4C6162656C34015255535349414E5F434841525345540152555353
          49414E5F43484152534554010D0A}
      end
      inherited PopupMenu1: TPopupMenu
        Left = 152
        Top = 64
      end
    end
    object BitBtnStepTest: TBitBtn
      Left = 33
      Top = 318
      Width = 87
      Height = 25
      Caption = 'Test Mover'
      TabOrder = 1
      Visible = False
      OnClick = BitBtnStepTestClick
    end
    object Panel5: TPanel
      Left = 281
      Top = 1
      Width = 237
      Height = 288
      BevelOuter = bvNone
      BevelWidth = 2
      BorderWidth = 1
      BorderStyle = bsSingle
      Color = 14474715
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      object Label2: TLabel
        Left = 104
        Top = 7
        Width = 11
        Height = 13
        Caption = 'A '
      end
      object Label3: TLabel
        Left = 17
        Top = 6
        Width = 49
        Height = 13
        Caption = 'Scanner '
      end
      object Label1: TLabel
        Left = 187
        Top = 72
        Width = 26
        Height = 13
        Caption = 'I, nA'
      end
      object LabelCur: TLabel
        Left = 186
        Top = 102
        Width = 3
        Height = 13
      end
      object LabelZV: TLabel
        Left = 79
        Top = 102
        Width = 3
        Height = 13
      end
      object Label7: TLabel
        Left = 124
        Top = 22
        Width = 37
        Height = 13
        Caption = 'Label7'
      end
      object LabeLZMax: TLabel
        Left = 14
        Top = 41
        Width = 10
        Height = 13
        Caption = '1 '
      end
      object LabelSignalMax: TLabel
        Left = 130
        Top = 40
        Width = 3
        Height = 13
      end
      object LabelZ: TLabel
        Left = 72
        Top = 22
        Width = 7
        Height = 13
        Caption = 'Z'
      end
      object ZIndicator: TRuleMod4
        Left = 34
        Top = 58
        Width = 39
        Height = 139
        ChangeLimits = True
        SFM = False
        flgLevelLimit = False
        NumbLim = 2
        Maximum = 32767
        HighLimit = 0
        LowLimit = 0
        Value = 0
        IndicColor = clNavy
      end
      object SignalIndicator: TRuleMod4
        Left = 128
        Top = 58
        Width = 39
        Height = 139
        ChangeLimits = True
        SFM = False
        flgLevelLimit = True
        NumbLim = 2
        Maximum = 32767
        HighLimit = 0
        LowLimit = 0
        Value = 0
        IndicColor = clMaroon
      end
      object PanelCounter: TPanel
        Left = 129
        Top = 202
        Width = 59
        Height = 39
        TabOrder = 0
        object Label6: TLabel
          Left = 1
          Top = 1
          Width = 57
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'Steps '
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 35
        end
        object edstepscounter: TLabel
          Left = 23
          Top = 20
          Width = 7
          Height = 13
          Caption = 'e'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object NormBitBtn: TBitBtn
        Left = 19
        Top = 212
        Width = 85
        Height = 22
        Hint = 
          'Set Oscillation  Amplitude Without Interaction = 1 (Normalizatio' +
          'n)'
        Caption = '&Normalize'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Visible = False
        OnClick = NormBitBtnClick
      end
      object PanelTimeControl: TPanel
        Left = 1
        Top = 242
        Width = 231
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object Label4: TLabel
          Left = 25
          Top = 5
          Width = 70
          Height = 13
          Caption = 'Control time'
        end
        object LblTimeControl: TLabel
          Left = 130
          Top = 6
          Width = 47
          Height = 13
          Caption = 'LblTimel'
        end
        object LblMs: TLabel
          Left = 171
          Top = 5
          Width = 17
          Height = 13
          Caption = 'ms'
        end
        object ScrollBarTimeControl: TScrollBar
          Left = 25
          Top = 21
          Width = 148
          Height = 16
          Max = 2000
          Min = 100
          PageSize = 0
          Position = 100
          TabOrder = 0
          OnScroll = ScrollBarTimeControlScroll
        end
      end
    end
    object exitBtn: TBitBtn
      Left = 147
      Top = 316
      Width = 72
      Height = 27
      Cancel = True
      Caption = 'E&xit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnClick = ExitBtnClick
      NumGlyphs = 2
    end
    object CheckBoxCamera: TCheckBox
      Left = 53
      Top = 244
      Width = 163
      Height = 17
      Caption = 'Autorun Camera'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = CheckBoxCameraClick
    end
    object ToolBarOpt: TToolBar
      Left = 274
      Top = 295
      Width = 263
      Height = 53
      Align = alNone
      ButtonHeight = 52
      ButtonWidth = 82
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Default'
      Font.Style = [fsBold]
      Images = Main.ImageListScanTool
      ParentFont = False
      ShowCaptions = True
      TabOrder = 5
      object BitBtnOk: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = '     Scanning   '
        ImageIndex = 2
        OnClick = BitBtnOKClick
      end
      object Optionsbtn: TToolButton
        Left = 86
        Top = 0
        AutoSize = True
        Caption = '     Options    '
        ImageIndex = 4
        OnClick = OptionsBtnClick
      end
      object BitBtnHelp: TToolButton
        Left = 167
        Top = 0
        Caption = 'Help'
        ImageIndex = 19
        OnClick = BitBtnHelpClick
      end
    end
    object ToolBarOk: TToolBar
      Left = 258
      Top = 345
      Width = 55
      Height = 53
      Align = alNone
      AutoSize = True
      ButtonHeight = 51
      ButtonWidth = 51
      Flat = False
      ShowCaptions = True
      TabOrder = 6
    end
    object BitBtnLog: TBitBtn
      Left = 33
      Top = 280
      Width = 87
      Height = 25
      Caption = 'View log'
      TabOrder = 7
      Visible = False
      OnClick = BitBtnLogClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 572
    Height = 79
    Align = alTop
    BevelOuter = bvNone
    Color = clSilver
    TabOrder = 2
    object Panel3: TPanel
      Left = 0
      Top = 78
      Width = 572
      Height = 1
      Align = alBottom
      AutoSize = True
      BevelInner = bvRaised
      BevelKind = bkTile
      ParentBackground = False
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 572
      Height = 78
      Align = alClient
      BevelOuter = bvNone
      Color = clSilver
      ParentBackground = False
      TabOrder = 1
      object Panel6: TPanel
        Left = 0
        Top = 76
        Width = 572
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 572
        Height = 76
        Align = alClient
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
        object Panel8: TPanel
          Left = 571
          Top = 0
          Width = 1
          Height = 76
          Align = alRight
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
        end
        object Panel9: TPanel
          Left = 0
          Top = 0
          Width = 571
          Height = 76
          Align = alClient
          BevelOuter = bvNone
          Color = clSilver
          TabOrder = 1
          object ToolBarControl: TToolBar
            Left = 0
            Top = 24
            Width = 571
            Height = 52
            Align = alBottom
            ButtonHeight = 44
            ButtonWidth = 72
            Caption = '`'
            Color = clSilver
            DisabledImages = Main.ImageList24
            DrawingStyle = dsGradient
            EdgeOuter = esRaised
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Default'
            Font.Style = [fsBold]
            GradientEndColor = clSilver
            GradientStartColor = 14803425
            Images = Main.ImageList24
            ParentColor = False
            ParentFont = False
            ShowCaptions = True
            TabOrder = 0
            Transparent = True
            object Startbtndown: TToolButton
              Tag = 1
              Left = 0
              Top = 0
              AutoSize = True
              Caption = '     &Slow    '
              Grouped = True
              ImageIndex = 11
              Style = tbsCheck
              OnClick = StartbtndownClick
            end
            object StartBtnFastDown: TToolButton
              Tag = 2
              Left = 64
              Top = 0
              AutoSize = True
              Caption = '    &Fast  '
              Grouped = True
              ImageIndex = 15
              Style = tbsCheck
              OnClick = StartbtndownClick
            end
            object StartBtnOneStepdown: TToolButton
              Tag = 3
              Left = 117
              Top = 0
              AutoSize = True
              Caption = ' &One step  '
              Grouped = True
              ImageIndex = 12
              Style = tbsCheck
              OnClick = StartBtnOneStepdownClick
            end
            object ToolButton1: TToolButton
              Left = 187
              Top = 0
              Width = 31
              AllowAllUp = True
              AutoSize = True
              Caption = '            '
              Grouped = True
              Style = tbsSeparator
            end
            object StopBtn: TToolButton
              Tag = 7
              Left = 218
              Top = 0
              AutoSize = True
              Caption = '       &Stop      '
              Down = True
              Grouped = True
              ImageIndex = 9
              Style = tbsCheck
              OnClick = StopBtnClick
            end
            object ToolButton3: TToolButton
              Left = 294
              Top = 0
              Width = 31
              AllowAllUp = True
              AutoSize = True
              Caption = '             '
              Grouped = True
              Style = tbsSeparator
            end
            object StartOneBtnUp: TToolButton
              Tag = 6
              Left = 325
              Top = 0
              AutoSize = True
              Caption = '  O&ne step  '
              Grouped = True
              ImageIndex = 14
              Style = tbsCheck
              OnClick = StartBtnOneStepdownClick
            end
            object StartBtnFastUp: TToolButton
              Tag = 5
              Left = 398
              Top = 0
              AutoSize = True
              Caption = '   F&ast  '
              Grouped = True
              ImageIndex = 16
              Style = tbsCheck
              OnClick = StartbtndownClick
            end
            object StartBtnUp: TToolButton
              Tag = 4
              Left = 448
              Top = 0
              AutoSize = True
              Caption = '    S&low   '
              Grouped = True
              ImageIndex = 13
              Style = tbsCheck
              OnClick = StartbtndownClick
            end
          end
          object Panel10: TPanel
            Left = 0
            Top = 0
            Width = 571
            Height = 24
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object PanelLanding: TPanel
              Left = 0
              Top = 0
              Width = 164
              Height = 24
              Align = alLeft
              BevelOuter = bvNone
              Caption = 'Landing'
              Color = 14803425
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object Panel12: TPanel
              Left = 164
              Top = 0
              Width = 407
              Height = 24
              Align = alClient
              BevelOuter = bvNone
              Color = 14803425
              TabOrder = 1
              object PanelRising: TPanel
                Left = 241
                Top = 0
                Width = 166
                Height = 24
                Align = alRight
                BevelOuter = bvNone
                Caption = 'Rising'
                Color = 14803425
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
            end
          end
        end
      end
    end
  end
  object TimerUp: TTimer
    Enabled = False
    Interval = 300
    OnTimer = TimerWakeUp
    Left = 465
    Top = 183
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
    Left = 248
    Top = 320
    TranslationData = {
      737443617074696F6E730D0A54417070726F616368014C616E64696E6701CFEE
      E4E2EEE4010D0A4C626C504D74696D6501504D2054696D652001CFC420E2E5EB
      E8F7E8EDE020F8E0E3E0202020010D0A4C6162656C54696D6576616C014C6162
      656C54696D652001010D0A4C6162656C504D506175736501504D205061757365
      2001CFC420EFE0F3E7E020010D0A4C6162656C506175736576616C0150617573
      65200126CFE0F3E7E020010D0A42697442746E53746570546573740154657374
      204D6F76657201D2E5F1F220ECEEF2EEF0E0010D0A4C6162656C320141200101
      0D0A4C6162656C33015363616E6E65722001D1EAE0EDE5F0010D0A4C6162656C
      3101492C206E4101492C20EDC0010D0A4C6162656C37014C6162656C3701010D
      0A4C6162654C5A4D617801312001010D0A4C6162656C5A015A01010D0A4C6162
      656C360153746570732001D8E0E3E8010D0A65647374657073636F756E746572
      016501010D0A4E6F726D42697442746E01264E6F726D616C697A6501010D0A65
      78697442746E0145267869740126C2FBF5EEE4010D0A436865636B426F784361
      6D657261014175746F72756E2043616D65726101C0E2F2EEE7E0EFF3F1EA20EA
      E0ECE5F0FB010D0A537461727462746E646F776E01202020202026536C6F7720
      2020200126CCE5E4EBE5EDEDEE010D0A537461727442746E46617374446F776E
      0120202020264661737420200126C1FBF1F2F0EE010D0A537461727442746E4F
      6E6553746570646F776E0120264F6E65207374657020200126CEE4E8ED20F8E0
      E3010D0A546F6F6C427574746F6E310120202020202020202020202001010D0A
      53746F7042746E01202020202020202653746F70202020202020012020202020
      202020202026D1F2EEEF20202020202020202020010D0A546F6F6C427574746F
      6E33012020202020202020202020202001010D0A53746172744F6E6542746E55
      700120204F266E652073746570202001CE26E4E8ED20F8E0E3010D0A53746172
      7442746E466173745570012020204626617374202001C126FBF1F2F0EE010D0A
      537461727442746E5570012020202053266C6F7720202001CC26E5E4EBE5EDED
      EE010D0A50616E656C4C616E64696E67014C616E64696E6701CFEEE4E2EEE401
      0D0A50616E656C526973696E6701526973696E6701CEF2E2EEE4010D0A4F7074
      696F6E7362746E0120202020204F7074696F6E732020202001CFE0F0E0ECE5F2
      F0FB010D0A42697442746E4F6B0120202020205363616E6E696E6720202001D1
      EAE0EDE8F0EEE2E0EDE8E5010D0A42697442746E48656C700148656C7001D1EF
      F0E0E2EAE0010D0A42697442746E4C6F670156696577206C6F6701CBEEE320F4
      E0E9EB010D0A546F6F6C426172436F6E74726F6C016001010D0A4C6162656C34
      01436F6E74726F6C2074696D6501C2F0E5ECFF20EAEEEDF2F0EEEBFF010D0A4C
      626C54696D65436F6E74726F6C014C626C54696D656C01010D0A4C626C4D7301
      6D7301ECF1010D0A737448696E74730D0A54417070726F61636801010D0A4E6F
      726D42697442746E01536574204F7363696C6C6174696F6E2020416D706C6974
      75646520576974686F757420496E746572616374696F6E203D203120284E6F72
      6D616C697A6174696F6E2901010D0A7374446973706C61794C6162656C730D0A
      7374466F6E74730D0A54417070726F6163680144656661756C74014465666175
      6C74010D0A5369676E616C734D6F64650144656661756C740144656661756C74
      010D0A50616E656C350144656661756C740144656661756C74010D0A65647374
      657073636F756E7465720144656661756C740144656661756C74010D0A4E6F72
      6D42697442746E0144656661756C740144656661756C74010D0A657869744274
      6E0144656661756C740144656661756C74010D0A50616E656C4C616E64696E67
      0144656661756C740144656661756C74010D0A436865636B426F7843616D6572
      610144656661756C740144656661756C74010D0A546F6F6C4261724F70740144
      656661756C740144656661756C74010D0A546F6F6C426172436F6E74726F6C01
      44656661756C740144656661756C74010D0A50616E656C526973696E67014465
      6661756C740144656661756C74010D0A73744D756C74694C696E65730D0A7374
      537472696E67730D0A4944535F300120206E410120EDC0010D0A4944535F3130
      0126536C6F770126CCE5E4EBE5EDEDEE010D0A4944535F31310101010D0A4944
      535F31320143757272656E740120202020D2EEEA010D0A4944535F3134012020
      560120C2010D0A4944535F31350153544D01D1D2CC010D0A4944535F31360150
      726F6265204F7363696C6C6174696F6E2020012020202020202020C0ECEFEBE8
      F2F3E4E0010D0A4944535F31370120416D706C697475646501EAEEEBE5E1E0ED
      E8E920E7EEEDE4E0010D0A4944535F31380153464D01D1D1CC010D0A4944535F
      31390150616E656C206973206E6F7420656E61626C65642E5468652074697020
      697320746F6F20636C6F736520612073616D706C652E01CFE0EDE5EBFC20EDE5
      E4EEF1F2F3EFEDE02E20C7EEEDE420F1EBE8F8EAEEEC20E1EBE8E7EEEA20EA20
      EEE1F0E0E7F6F3010D0A4944535F31014D616B65204E6F726D616C697A652062
      65666F72652052756E2101010D0A4944535F3230014974206973207265636F6D
      6D656E64656420746F206D616B6520726973696E6701D0E5EAEEECE5E4F3E5F2
      F1FF20EEF2EEE9F2E8010D0A4944535F3233015363616E6E696E672053616D70
      6C65205375726661636501D1EAE0EDE8F0EEE2E0EDE8E520EEE1F0E0E7F6E001
      0D0A4944535F3234014C616E64696E6701CFEEE4E2EEE4010D0A4944535F3235
      01427574746F6E206973206E6F7420656E61626C65642E546865207469702069
      7320746F6F20636C6F736520612073616D706C652E01CAEDEEEFEAE020EDE5E4
      EEF1F2F3EFEDE02E2020C7EEEDE420F1EBE8F8EAEEEC20E1EBE8E7EEEA20EA20
      EEE1F0E0E7F6F3010D0A4944535F3237015265736F6E616E6365206672657175
      656E6365204D6561737572696E672020616E642053657474696E6701CEEFF0E5
      E4E5EBE5EDE8E5E820F3F1F2E0EDEEE2EAE020F0E5E7EEEDE0EDF1EDEEE920F7
      E0F1F2EEF2FB010D0A4944535F3238015761726E696E672101CFF0E5E4F3EFF0
      E5E6E4E5EDE8E521010D0A4944535F3239015468652073746570206D6F746F72
      2068617320616368696576656420746F7020706F736974696F6E2101D8E0E3EE
      E2FBE920E4E2E8E3E0F2E5EBFC20E4EEF1F2E8E320EAF0E0E9EDE5E3EE20E2E5
      F0F5EDE5E3EE20EFEEEBEEE6E5EDE8FF010D0A4944535F32014C616E64696E67
      20646F6E6501CFEEE4E2EEE42020E2FBEFEEEBEDE5ED010D0A4944535F333001
      5475726E20736372657720636F756E7465722D636C6F636B7769736520627920
      68616E64212101CFEEE2E5F0EDE8F2E520E2E8EDF220EFF0EEF2E8E220F7E0F1
      EEE2EEE920F1F2F0E5EBEAE5010D0A4944535F3331014572726F7221212101CE
      F8E8E1EAE0212121010D0A4944535F33320146616C7365204F63637572656E63
      65206F66204C616E64696E6720646F6E65206D6573736167652E205265616420
      46415101CEF8E8E1EAE020EFEEE4E2EEE4E02C2020EFF0EEF7E8F2E0E9F2E520
      D7C0C2CE010D0A4944535F33330153746F7020617070726F616368206265666F
      7265206578697421212101CEF1F2E0EDEEE2E8F2E52C20EFF0E5E6E4E520F7E5
      EC20E2FBE9F2E8010D0A4944535F3335012020526973696E67012020CEF2E2EE
      E4010D0A4944535F33014572726F72212101CEF8E8E1EAE0212121010D0A4944
      535F343001204C616E64696E6701CFEEE4E2EEE4010D0A4944535F3431015374
      6F70204C616E64696E672101CEF1F2E0EDEEE2E8F2E520EFEEE4E2EEE421010D
      0A4944535F3432016E6F2044656D6F204461746121212101EDE5F220E4E5ECEE
      20E4E0EDEDFBF521010D0A4944535F3433014E6F20496E746572616374696F6E
      2101CDE5F220E2E7E0E8ECEEE4E5E9F1F2E2E8FF21010D0A4944535F34015469
      7020746F6F20636C6F736520746F20612073616D706C652101C7EEEDE420F1EB
      E8F8EAEEEC20E1EBE8E7EEEA20EA20EEE1F0E0E7F6F3010D0A4944535F353001
      2653544F500126D1F2EEEF010D0A4944535F35310174686520496E6469636174
      6F72205A01C8EDE4E8EAE0F2EEF0205A010D0A4944535F35370154686520696E
      64696361746F72206F6620612063757272656E7401C8EDE4E8EAE0F2EEF020F2
      EEEAE0010D0A4944535F353801526564206C696E65202D207468652053657470
      6F696E7401CAF0E0F1EDE0FF20EBE8EDE8FF202DF0E0E1EEF7E5E520E7EDE0F7
      E5EDE8E5010D0A4944535F353901477265656E204C696E652D2061206C657665
      6C206F662074686520626567696E6E696E67206F662074686520636F6E74726F
      6C284954204C6576656C2901C7E5EBE5EDE0FF20EBE8EDE8FF202D20EFEEF0EE
      E320EFF0E820E4EEF1F2E8E6E5EDE8E820EAEEF2EEF0EEE3EE20EDE0F7E8EDE0
      E5F2F1FF20EAEEEDF2F0EEEBFC20010D0A4944535F3501566572696679206C61
      6E64696E67206F7074696F6E206F7220706879736963616C20756E6974207374
      6174652E01CFF0EEE2E5F0FCF2E520EFE0F0E0ECE5F2F0FB20EFEEE4E2EEE4E0
      20E8EBE820F4E8E7E8F7E5F1EAE8E920F3E7E5EB010D0A4944535F3632017468
      6520696E64696361746F72206F6620612050726F6265204F7363696C6C617469
      6F6E20416D706C69747564652E01C8EDE4E8EAE0F2EEF020C0ECEFEBE8F2F3E4
      FB20EAEEEBE5E1E0EDE8FF20E7EEEDE4E02E010D0A4944535F36330152656420
      6C696E65202D20536574506F696E743B01CAF0E0F1EDE0FF20EBE8EDE8FF202D
      20F0E0E1EEF7E5E520E7EDE0F7E5EDE8E5010D0A4944535F363401477265656E
      206C696E652D2061206C6576656C206F662074686520626567696E6E696E6720
      6F662074686520636F6E74726F6C2850726F6265204F7363696C6C6174696F6E
      204C6576656C01C7E5EBE5EDE0FF20EBE8EDE8FF202D20EFEEF0EEE320EFF0E8
      20E4EEF1F2E8E6E5EDE8E820EAEEF2EEF0EEE3EE20EDE0F7E8EDE0E5F2F1FF20
      EAEEEDF2F0EEEBFC20010D0A4944535F36350153464D3B2001D1D1CC3B010D0A
      4944535F3638015468652070726F626520697320746F6F20636C6F736520746F
      20612073616D706C652E01C7EEEDE420F1EBE8F8EAEEEC20E1EBE8E7EEEA20EA
      20EEE1F0E0E7F6F3010D0A4944535F363901417474656E74696F6E21212101C2
      EDE8ECE0EDE8E52121010D0A4944535F3601446F20796F752077616E7420746F
      2072697365207468652070726F626520696E2061207361766520706C6163653F
      01C2FB20F5EEF2E8F2E520EEF2EEE9F2E820E220E1E5E7EEEFE0F1F2EDEEE520
      ECE5F1F2EE3F010D0A4944535F380120204C616E64696E67012020CFEEE4E2EE
      E4010D0A4944535F39014D616B65204C616E64696E67206265666F7265205363
      616E6E696E6720612053616D706C65205375726661636501CEF1F3F9E5F1F2E2
      E8F2E520EFEEE4E2EEE420EFE5F0E5E420F1EAE0EDE8F0EEE2E0EDE8E5EC20EE
      E1F0E0E7F6E0010D0A4944535F313301436C6F7365205370656374726F73636F
      70792077696E646F77212101C7E0EAF0EEE9F2E520EEEAEDEE20F1EFE5EAF2F0
      EEF1EAEEEFE8E82121010D0A4944535F3231016572726F722072656164206765
      6F6D6574727901EEF8E8E1EAE020F7F2E5EDE8FF20E3E5EEECE5F2F0E8E820EA
      E0EDE0EBE0010D0A4944535F3232014368616E6E656C20646174613B20456C65
      6D656E74733D01EAE0EDE0EB20E4E0EDEDFBF53B20FDEBE5ECE5EDF2EEE23D01
      0D0A4944535F32360173697A653D01F0E0E7ECE5F03D010D0A4944535F333401
      6572726F722077726974652073746F70206368616E6E656C01EEF8E8E1EAE020
      F7F2E5EDE8FF20EAE0EDE0EBE02053746F70010D0A4944535F33360168723D01
      010D0A4944535F33370177726974652073746F70206368616E6E656C203D01E7
      E0EFE8F1FC20E220EAE0EDE0EB2053746F70010D0A4944535F3338016572726F
      722072656164207374657073206368616E6E656C01EEF8E8E1EAE020F7F2E5ED
      E8FF20EAE0EDE0EBE0205374657073010D0A4944535F34340172656164207374
      6570206368616E6E656C203D01F7F2E5EDE8E520EAE0EDE0EBE0205374657073
      3D010D0A4944535F34350173746570203D646F6E6501010D0A4944535F343601
      6572726F722067657420636F756E7420646174612001EEF8E8E1EAE020F7F2E5
      EDE8FF20F0E0E7ECE5F0E020E4E0EDEDFBF5010D0A4944535F34380120646174
      6120746F20726561642001EFF0EEF7E8F2E0F2FC2020010D0A4944535F343901
      6572726F722072656164206368616E6E656C20646174612001EEF8E8E1EAE020
      F7F2E5EDE8FF20EAE0EDE0EBE020E4E0EDEDFBF5010D0A4944535F3533016461
      74612068617320726561642001EFF0EEF7E8F2E0EDEE010D0A4944535F353401
      53544F50203A204E4D42206F66204348414E4E454C204552524F5253203D2020
      2001010D0A4944535F3535017374657020646F6E6501F8E0E320F1E4E5EBE0ED
      010D0A4944535F353601456E642064726177696E6701EAEEEDE5F62020F0E8F1
      EEE2E0EDE8FF010D0A4944535F370153746172742064726177696E6701EDE0F7
      E0EBEE20F0E8F1EEE2E0EDE8FF010D0A4944535F343701417474656E74696F6E
      2101C2EDE8ECE0EDE8E52120010D0A4944535F353201596F75206C6561766520
      776F726B207A6F6E652101C2FB20E2FBF8EBE820E8E720F0E0E1EEF7E5E920E7
      EEEDFB21010D0A4944535F3636014D616B65205265736F6E616E636520626566
      6F7265204C616E64696E67210120C2FBEFEEEBEDE8F2E520EFEEE8F1EA20F0E5
      E7EEEDE0EDF1E020EFE5F0E5E420F1E1EBE8E6E5EDE8E5EC21010D0A73747273
      74727601566F6C7461676520426961733D302E2053657420566F6C7461676501
      CFF0E8EBEEE6E5EDEDEEE520EDE0EFF0FFE6E5EDE8E53D30202120D3F1F2E0ED
      EEE2E8F2E520EDE0EFF0FFE6E5EDE8E52E010D0A73744F74686572537472696E
      67730D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A54
      417070726F6163680144454641554C545F43484152534554015255535349414E
      5F43484152534554010D0A5369676E616C734D6F64650144454641554C545F43
      484152534554015255535349414E5F43484152534554010D0A50616E656C3501
      44454641554C545F43484152534554015255535349414E5F4348415253455401
      0D0A65647374657073636F756E7465720144454641554C545F43484152534554
      015255535349414E5F43484152534554010D0A4E6F726D42697442746E014445
      4641554C545F43484152534554015255535349414E5F43484152534554010D0A
      6578697442746E0144454641554C545F43484152534554015255535349414E5F
      43484152534554010D0A50616E656C4C616E64696E670144454641554C545F43
      484152534554015255535349414E5F43484152534554010D0A436865636B426F
      7843616D6572610144454641554C545F43484152534554015255535349414E5F
      43484152534554010D0A546F6F6C4261724F70740144454641554C545F434841
      52534554015255535349414E5F43484152534554010D0A546F6F6C426172436F
      6E74726F6C0144454641554C545F43484152534554015255535349414E5F4348
      4152534554010D0A50616E656C526973696E670144454641554C545F43484152
      534554015255535349414E5F43484152534554010D0A}
  end
end
