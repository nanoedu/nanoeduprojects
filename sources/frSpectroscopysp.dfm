object Spectroscopysp: TSpectroscopysp
  Left = 0
  Top = 0
  Caption = 'Spectroscopysp'
  ClientHeight = 507
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 488
    Width = 731
    Height = 19
    Panels = <>
    ExplicitLeft = 384
    ExplicitTop = 496
    ExplicitWidth = 0
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 731
    Height = 488
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = -506
    ExplicitTop = -287
    ExplicitWidth = 932
    ExplicitHeight = 503
    object Panel6: TPanel
      Left = 216
      Top = 0
      Width = 515
      Height = 488
      Align = alClient
      Caption = 'Panel6'
      Color = 14474715
      ParentBackground = False
      TabOrder = 0
      ExplicitWidth = 513
      ExplicitHeight = 507
      object PageControl: TPageControl
        Left = 1
        Top = 1
        Width = 513
        Height = 415
        Align = alTop
        TabOrder = 0
      end
      object Panel7: TPanel
        Left = 1
        Top = 416
        Width = 513
        Height = 52
        Align = alClient
        Color = 14474715
        ParentBackground = False
        TabOrder = 1
        ExplicitTop = 425
        ExplicitHeight = 43
        object BitBtnApply: TBitBtn
          Left = 400
          Top = 6
          Width = 75
          Height = 25
          Caption = 'OK'
          Default = True
          ModalResult = 1
          TabOrder = 0
          Visible = False
          NumGlyphs = 2
        end
        object BitBtnSave: TBitBtn
          Left = 295
          Top = 6
          Width = 99
          Height = 27
          Caption = 'Save'
          Enabled = False
          TabOrder = 1
          Visible = False
        end
        object BitBtnExit: TBitBtn
          Left = 481
          Top = 6
          Width = 75
          Height = 25
          Caption = '&Exit'
          ModalResult = 3
          TabOrder = 2
          Visible = False
          NumGlyphs = 2
        end
        object ToolBar2: TToolBar
          Left = 371
          Top = 1
          Width = 141
          Height = 50
          Align = alRight
          ButtonHeight = 52
          ButtonWidth = 51
          Images = Main.ImageListScanTool
          ShowCaptions = True
          TabOrder = 3
          Transparent = True
          ExplicitLeft = 369
          ExplicitHeight = 60
          object PrintBtn: TToolButton
            Left = 0
            Top = 0
            Caption = '   &Print  '
            ImageIndex = 18
          end
          object ToolButton1: TToolButton
            Left = 51
            Top = 0
            Caption = '&Help'
            ImageIndex = 19
          end
        end
        object PanelEditBtns: TPanel
          Left = 1
          Top = 1
          Width = 370
          Height = 50
          Align = alClient
          TabOrder = 4
          ExplicitWidth = 368
          ExplicitHeight = 60
          object PanelLabels: TPanel
            Left = 1
            Top = 1
            Width = 432
            Height = 48
            Align = alLeft
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            ExplicitHeight = 39
          end
          object PanelCurves: TPanel
            Left = 433
            Top = 1
            Width = 137
            Height = 48
            Align = alClient
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 1
            ExplicitHeight = 58
          end
        end
      end
      object Lblwarning: TStatusBar
        Left = 1
        Top = 468
        Width = 513
        Height = 19
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Default'
        Font.Style = [fsBold]
        Panels = <
          item
            Style = psOwnerDraw
            Text = 
              'Warning! The level of suppression of amplitude oscillation is ac' +
              'hieved! '
            Width = 530
          end
          item
            Style = psOwnerDraw
            Text = ' Change Final Point'
            Width = 30
          end>
        UseSystemFont = False
        ExplicitTop = 487
        ExplicitWidth = 511
      end
    end
    object ControlPanel: TPanel
      Left = 0
      Top = 0
      Width = 216
      Height = 488
      Align = alLeft
      Color = 14474715
      TabOrder = 1
      ExplicitHeight = 507
      object Panel2: TPanel
        Left = 1
        Top = 1
        Width = 214
        Height = 61
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BevelWidth = 2
        Color = 14474715
        ParentBackground = False
        TabOrder = 0
        object ToolBar1: TToolBar
          Left = 4
          Top = 4
          Width = 206
          Height = 52
          ButtonHeight = 44
          ButtonWidth = 74
          Caption = 'ToolBar1'
          Images = Main.ImageList24
          ShowCaptions = True
          TabOrder = 0
          Transparent = True
          object StartBtn: TToolButton
            Left = 0
            Top = 0
            Caption = '      &Start      '
            ImageIndex = 8
            Style = tbsCheck
            OnClick = StartBtnClick
          end
        end
      end
      object Panel3: TPanel
        Left = 1
        Top = 62
        Width = 214
        Height = 425
        Align = alClient
        Color = 14474715
        TabOrder = 1
        ExplicitHeight = 444
        object Panel4: TPanel
          Left = 1
          Top = 1
          Width = 212
          Height = 423
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          BevelWidth = 2
          Color = 14474715
          ParentBackground = False
          TabOrder = 0
          ExplicitHeight = 442
          inline FrT: TFrameParInput
            Left = 5
            Top = 286
            Width = 197
            Height = 70
            Color = 14474715
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 3
            TabStop = True
            ExplicitLeft = 5
            ExplicitTop = 286
            ExplicitWidth = 197
            ExplicitHeight = 70
            inherited frPanel: TPanel
              Left = 3
              Top = 3
              Height = 64
              Hint = 'Time delay in the point'
              ParentBackground = False
              ParentShowHint = False
              ShowHint = True
              ExplicitLeft = 3
              ExplicitTop = 3
              ExplicitHeight = 64
              inherited LabelFrm: TLabel
                Left = 153
                Top = 32
                Width = 4
                Height = 16
                Caption = ''
                ExplicitLeft = 153
                ExplicitTop = 32
                ExplicitWidth = 4
                ExplicitHeight = 16
              end
              inherited LabelUnit: TLabel
                Left = 156
                Top = 10
                Width = 25
                Height = 16
                Caption = 'mcs'
                ExplicitLeft = 156
                ExplicitTop = 10
                ExplicitWidth = 25
                ExplicitHeight = 16
              end
              inherited BitBtnFrm: TBitBtn
                Left = 14
                Top = 6
                Width = 74
                Height = 23
                Caption = 'Delay'
                ExplicitLeft = 14
                ExplicitTop = 6
                ExplicitWidth = 74
                ExplicitHeight = 23
              end
              inherited EditFrm: TEdit
                Left = 97
                Top = 7
                Width = 53
                Height = 24
                ParentShowHint = False
                ShowHint = True
                OnChange = FrTEditFrmChange
                OnKeyPress = FrTEditFrmKeyPress
                ExplicitLeft = 97
                ExplicitTop = 7
                ExplicitWidth = 53
                ExplicitHeight = 24
              end
              inherited ScrollBarFrm: TScrollBar
                Left = 13
                Top = 37
                Width = 106
                Height = 15
                ExplicitLeft = 13
                ExplicitTop = 37
                ExplicitWidth = 106
                ExplicitHeight = 15
              end
            end
            inherited siLangLinked1: TsiLangLinked
              Top = 32
              TranslationData = {
                737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
                0101010D0A4C6162656C556E69740101010D0A42697442746E46726D0144656C
                617901C7E0E4E5F0E6EAE0010D0A737448696E74730D0A544672616D65506172
                496E70757401010D0A667250616E656C0154696D652064656C617920696E2074
                686520706F696E7401010D0A4C6162656C46726D0101010D0A4C6162656C556E
                69740101010D0A42697442746E46726D0101010D0A4564697446726D0101010D
                0A5363726F6C6C42617246726D0101010D0A7374446973706C61794C6162656C
                730D0A7374466F6E74730D0A544672616D65506172496E70757401417269616C
                01417269616C010D0A42697442746E46726D014D532053616E73205365726966
                01417269616C010D0A73744D756C74694C696E65730D0A7374537472696E6773
                0D0A73744F74686572537472696E67730D0A4564697446726D2E546578740101
                010D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A5446
                72616D65506172496E7075740144454641554C545F4348415253455401525553
                5349414E5F43484152534554010D0A42697442746E46726D0144454641554C54
                5F43484152534554015255535349414E5F43484152534554010D0A}
            end
          end
          inline FrNPoints: TFrameParInput
            Left = 9
            Top = 160
            Width = 193
            Height = 71
            Color = 14474715
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 0
            TabStop = True
            ExplicitLeft = 9
            ExplicitTop = 160
            ExplicitWidth = 193
            ExplicitHeight = 71
            inherited frPanel: TPanel
              Top = 1
              Width = 192
              Height = 64
              ExplicitTop = 1
              ExplicitWidth = 192
              ExplicitHeight = 64
              inherited LabelFrm: TLabel
                Left = 161
                Top = 28
                Width = 4
                Height = 16
                Caption = ''
                ExplicitLeft = 161
                ExplicitTop = 28
                ExplicitWidth = 4
                ExplicitHeight = 16
              end
              inherited LabelUnit: TLabel
                Left = 152
                Top = 12
                Width = 55
                Height = 16
                ExplicitLeft = 152
                ExplicitTop = 12
                ExplicitWidth = 55
                ExplicitHeight = 16
              end
              inherited BitBtnFrm: TBitBtn
                Left = 18
                Top = 8
                Width = 75
                Height = 24
                Hint = 'Number  of points '
                Caption = 'Points'
                ExplicitLeft = 18
                ExplicitTop = 8
                ExplicitWidth = 75
                ExplicitHeight = 24
              end
              inherited EditFrm: TEdit
                Left = 119
                Top = 11
                Width = 48
                Height = 24
                OnChange = FrNPointsEditFrmChange
                OnExit = FrNPointsEditFrmExit
                OnKeyPress = FrNPointsEditFrmKeyPress
                ExplicitLeft = 119
                ExplicitTop = 11
                ExplicitWidth = 48
                ExplicitHeight = 24
              end
              inherited ScrollBarFrm: TScrollBar
                Left = 9
                Top = 41
                Width = 106
                Height = 16
                SmallChange = 10
                ExplicitLeft = 9
                ExplicitTop = 41
                ExplicitWidth = 106
                ExplicitHeight = 16
              end
            end
            inherited siLangLinked1: TsiLangLinked
              Left = 136
              Top = 24
              TranslationData = {
                737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
                0101010D0A4C6162656C556E69740101010D0A42697442746E46726D01506F69
                6E747301D2EEF7E5EA010D0A737448696E74730D0A544672616D65506172496E
                70757401010D0A667250616E656C0101010D0A4C6162656C46726D0101010D0A
                4C6162656C556E69740101010D0A42697442746E46726D014E756D6265722020
                6F6620706F696E74732001010D0A4564697446726D0101010D0A5363726F6C6C
                42617246726D0101010D0A7374446973706C61794C6162656C730D0A7374466F
                6E74730D0A544672616D65506172496E70757401417269616C01417269616C01
                0D0A42697442746E46726D014D532053616E7320536572696601417269616C01
                0D0A73744D756C74694C696E65730D0A7374537472696E67730D0A73744F7468
                6572537472696E67730D0A4564697446726D2E546578740101010D0A7374436F
                6C6C656374696F6E730D0A737443686172536574730D0A544672616D65506172
                496E7075740144454641554C545F43484152534554015255535349414E5F4348
                4152534554010D0A42697442746E46726D0144454641554C545F434841525345
                54015255535349414E5F43484152534554010D0A}
            end
          end
          inline FrEndPoint: TFrameParInput
            Left = 5
            Top = 87
            Width = 201
            Height = 74
            Color = 14474715
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 2
            TabStop = True
            ExplicitLeft = 5
            ExplicitTop = 87
            ExplicitWidth = 201
            ExplicitHeight = 74
            inherited frPanel: TPanel
              Left = 1
              Top = 4
              Width = 200
              Height = 64
              ParentShowHint = False
              ShowHint = True
              ExplicitLeft = 1
              ExplicitTop = 4
              ExplicitWidth = 200
              ExplicitHeight = 64
              inherited LabelFrm: TLabel
                Left = 153
                Top = 25
                Width = 4
                Height = 16
                Caption = ''
                ExplicitLeft = 153
                ExplicitTop = 25
                ExplicitWidth = 4
                ExplicitHeight = 16
              end
              inherited LabelUnit: TLabel
                Left = 178
                Top = 11
                Width = 4
                Height = 16
                Caption = ''
                ExplicitLeft = 178
                ExplicitTop = 11
                ExplicitWidth = 4
                ExplicitHeight = 16
              end
              inherited BitBtnFrm: TBitBtn
                Left = 4
                Top = 7
                Width = 127
                Height = 24
                Hint = 'Step >=0'
                Caption = 'Final spr'
                ExplicitLeft = 4
                ExplicitTop = 7
                ExplicitWidth = 127
                ExplicitHeight = 24
              end
              inherited EditFrm: TEdit
                Left = 133
                Top = 7
                Width = 40
                Height = 24
                Hint = 'Step >=0'
                ParentShowHint = False
                ShowHint = True
                OnChange = FrEndPointEditFrmChange
                OnKeyPress = FrEndPointEditFrmKeyPress
                ExplicitLeft = 133
                ExplicitTop = 7
                ExplicitWidth = 40
                ExplicitHeight = 24
              end
              inherited ScrollBarFrm: TScrollBar
                Left = 9
                Top = 41
                Width = 120
                Height = 16
                ExplicitLeft = 9
                ExplicitTop = 41
                ExplicitWidth = 120
                ExplicitHeight = 16
              end
            end
            inherited siLangLinked1: TsiLangLinked
              Left = 144
              Top = 32
              TranslationData = {
                737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
                0101010D0A4C6162656C556E6974016E6D01EDEC010D0A42697442746E46726D
                0146696E616C20506F696E743E3001CAEEEDE5F7EDE0FF20F2EEF7EAE03E3001
                0D0A737448696E74730D0A544672616D65506172496E70757401010D0A667250
                616E656C0101010D0A4C6162656C46726D0101010D0A4C6162656C556E697401
                01010D0A42697442746E46726D0153746570203E3D3001010D0A456469744672
                6D0153746570203E3D3001010D0A5363726F6C6C42617246726D0101010D0A73
                74446973706C61794C6162656C730D0A7374466F6E74730D0A544672616D6550
                6172496E70757401417269616C01417269616C010D0A42697442746E46726D01
                4D532053616E7320536572696601417269616C010D0A73744D756C74694C696E
                65730D0A7374537472696E67730D0A73744F74686572537472696E67730D0A45
                64697446726D2E546578740101010D0A7374436F6C6C656374696F6E730D0A73
                7443686172536574730D0A544672616D65506172496E7075740144454641554C
                545F43484152534554015255535349414E5F43484152534554010D0A42697442
                746E46726D0144454641554C545F43484152534554015255535349414E5F4348
                4152534554010D0A}
            end
          end
          inline FrStartP: TFrameParInput
            Left = 6
            Top = 4
            Width = 200
            Height = 80
            Color = 14474715
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 1
            TabStop = True
            ExplicitLeft = 6
            ExplicitTop = 4
            ExplicitHeight = 80
            inherited frPanel: TPanel
              Left = -1
              Top = 8
              Width = 200
              Height = 64
              ParentBackground = False
              ParentShowHint = False
              ShowHint = True
              ExplicitLeft = -1
              ExplicitTop = 8
              ExplicitWidth = 200
              ExplicitHeight = 64
              inherited LabelFrm: TLabel
                Left = 153
                Top = 24
                Width = 4
                Height = 16
                Caption = ''
                ExplicitLeft = 153
                ExplicitTop = 24
                ExplicitWidth = 4
                ExplicitHeight = 16
              end
              inherited LabelUnit: TLabel
                Left = 177
                Top = 15
                Width = 4
                Height = 16
                Caption = ''
                ExplicitLeft = 177
                ExplicitTop = 15
                ExplicitWidth = 4
                ExplicitHeight = 16
              end
              inherited BitBtnFrm: TBitBtn
                Left = 3
                Top = 12
                Width = 133
                Height = 23
                Hint = 'Start point <=0'
                Caption = 'Start supr'
                ParentShowHint = False
                ShowHint = True
                ExplicitLeft = 3
                ExplicitTop = 12
                ExplicitWidth = 133
                ExplicitHeight = 23
              end
              inherited EditFrm: TEdit
                Left = 134
                Top = 9
                Width = 40
                Height = 24
                Hint = 'Start point <=0'
                ParentShowHint = False
                ShowHint = True
                OnChange = FrStartPEditFrmChange
                OnExit = FrStartPEditFrmExit
                OnKeyPress = FrStartPEditFrmKeyPress
                ExplicitLeft = 134
                ExplicitTop = 9
                ExplicitWidth = 40
                ExplicitHeight = 24
              end
              inherited ScrollBarFrm: TScrollBar
                Left = 9
                Top = 41
                Width = 120
                Height = 16
                SmallChange = 10
                ExplicitLeft = 9
                ExplicitTop = 41
                ExplicitWidth = 120
                ExplicitHeight = 16
              end
            end
            inherited siLangLinked1: TsiLangLinked
              Left = 168
              TranslationData = {
                737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
                0101010D0A4C6162656C556E6974016E6D01EDEC010D0A42697442746E46726D
                01537461727420506F696E743C3001CDE0F7E0EBFCEDE0FF20F2EEF7EAE03C30
                010D0A737448696E74730D0A544672616D65506172496E70757401010D0A6672
                50616E656C0101010D0A4C6162656C46726D0101010D0A4C6162656C556E6974
                0101010D0A42697442746E46726D01537461727420706F696E74203C3D300101
                0D0A4564697446726D01537461727420706F696E74203C3D3001010D0A536372
                6F6C6C42617246726D0101010D0A7374446973706C61794C6162656C730D0A73
                74466F6E74730D0A544672616D65506172496E70757401417269616C01417269
                616C010D0A42697442746E46726D014D532053616E7320536572696601417269
                616C010D0A73744D756C74694C696E65730D0A7374537472696E67730D0A7374
                4F74686572537472696E67730D0A4564697446726D2E546578740101010D0A73
                74436F6C6C656374696F6E730D0A737443686172536574730D0A544672616D65
                506172496E7075740144454641554C545F43484152534554015255535349414E
                5F43484152534554010D0A42697442746E46726D0144454641554C545F434841
                52534554015255535349414E5F43484152534554010D0A}
            end
          end
          object Panel5: TPanel
            Left = 8
            Top = 236
            Width = 193
            Height = 43
            Color = 14474715
            ParentBackground = False
            TabOrder = 4
            object LabelStep: TLabel
              Left = 56
              Top = 5
              Width = 3
              Height = 13
            end
            object LabelStepMin: TLabel
              Left = 40
              Top = 22
              Width = 67
              Height = 16
              Caption = 'Step Min='
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
        end
      end
    end
  end
end
