object Spectroscopy: TSpectroscopy
  Left = 353
  Top = -4
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Spectroscopy'
  ClientHeight = 541
  ClientWidth = 934
  Color = clGray
  Constraints.MaxHeight = 604
  Constraints.MaxWidth = 980
  Constraints.MinHeight = 566
  Constraints.MinWidth = 840
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Default'
  Font.Style = [fsBold]
  FormStyle = fsMDIChild
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 16
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 934
    Height = 522
    Align = alClient
    TabOrder = 0
    object Panel: TPanel
      Left = 1
      Top = 1
      Width = 932
      Height = 520
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      OnMouseDown = PanelMouseDown
      object Panel6: TPanel
        Left = 216
        Top = 0
        Width = 716
        Height = 520
        Align = alClient
        Caption = 'Panel6'
        Color = 14474715
        ParentBackground = False
        TabOrder = 0
        object PageControl: TPageControl
          Left = 1
          Top = 1
          Width = 714
          Height = 423
          Align = alTop
          TabOrder = 0
          OnChange = PageControlChange
        end
        object Panel7: TPanel
          Left = 1
          Top = 424
          Width = 714
          Height = 76
          Align = alClient
          Color = 14474715
          ParentBackground = False
          TabOrder = 1
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
            OnClick = BitBtnApplyClick
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
            OnClick = BitBtnSaveClick
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
            OnClick = BitBtnExitClick
            NumGlyphs = 2
          end
          object ToolBar2: TToolBar
            Left = 572
            Top = 1
            Width = 141
            Height = 74
            Align = alRight
            ButtonHeight = 55
            ButtonWidth = 58
            Images = Main.ImageListScanTool
            ShowCaptions = True
            TabOrder = 3
            Transparent = True
            object PrintBtn: TToolButton
              Left = 0
              Top = 0
              Caption = '   &Print  '
              ImageIndex = 18
              OnClick = BitBtnPrintClick
            end
            object ToolButton1: TToolButton
              Left = 58
              Top = 0
              Caption = '&Help'
              ImageIndex = 19
              OnClick = BitBtnHelpClick
            end
          end
          object PanelEditBtns: TPanel
            Left = 1
            Top = 1
            Width = 571
            Height = 74
            Align = alClient
            TabOrder = 4
            object PanelLabels: TPanel
              Left = 1
              Top = 1
              Width = 432
              Height = 72
              Align = alLeft
              BevelOuter = bvNone
              ParentBackground = False
              TabOrder = 0
            end
            object PanelCurves: TPanel
              Left = 433
              Top = 1
              Width = 137
              Height = 72
              Align = alClient
              BevelOuter = bvNone
              ParentBackground = False
              TabOrder = 1
            end
          end
        end
        object Lblwarning: TStatusBar
          Left = 1
          Top = 500
          Width = 714
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
          OnDrawPanel = LblwarningDrawPanel
        end
      end
      object ControlPanel: TPanel
        Left = 0
        Top = 0
        Width = 216
        Height = 520
        Align = alLeft
        Color = 14474715
        TabOrder = 1
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
            ButtonHeight = 47
            ButtonWidth = 89
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
          Height = 457
          Align = alClient
          Color = 14474715
          TabOrder = 1
          object Panel4: TPanel
            Left = 1
            Top = 1
            Width = 212
            Height = 455
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            BevelWidth = 2
            Color = 14474715
            ParentBackground = False
            TabOrder = 0
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
                  OnClick = FrTBitBtnFrmClick
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
                  OnKeyPress = FrEndPointEditFrmKeyPress
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
                  737443617074696F6E730D0A4C6162656C556E6974016D637301ECEAF1010D0A
                  42697442746E46726D0144656C617901C7E0E4E5F0E6EAE0010D0A737448696E
                  74730D0A667250616E656C0154696D652064656C617920696E2074686520706F
                  696E7401C2F0E5ECFF20E7E0E4E5F0E6EAE820E220F2EEF7EAE520E220ECEAF1
                  010D0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A544672
                  616D65506172496E7075740144656661756C7401417269616C010D0A42697442
                  746E46726D0144656661756C7401417269616C010D0A73744D756C74694C696E
                  65730D0A7374537472696E67730D0A73744F74686572537472696E67730D0A73
                  74436F6C6C656374696F6E730D0A737443686172536574730D0A544672616D65
                  506172496E7075740144454641554C545F43484152534554015255535349414E
                  5F43484152534554010D0A42697442746E46726D0144454641554C545F434841
                  52534554015255535349414E5F43484152534554010D0A}
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
                Left = -2
                Top = 1
                Width = 192
                Height = 64
                ExplicitLeft = -2
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
                  Left = 121
                  Top = 11
                  Width = 48
                  Height = 24
                  OnChange = FrNPointsEditFrmChange
                  OnExit = FrFrmExit
                  OnKeyPress = FrNPointsEditFrmKeyPress
                  ExplicitLeft = 121
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
                  0101010D0A4C6162656C556E6974016C6162656C756E697401010D0A42697442
                  746E46726D01506F696E747301D2EEF7E5EA010D0A737448696E74730D0A5446
                  72616D65506172496E7075740101010D0A667250616E656C0101010D0A4C6162
                  656C46726D0101010D0A4C6162656C556E69740101010D0A42697442746E4672
                  6D014E756D62657220206F6620706F696E74732001D7E8F1EBEE20F2EEF7E5EA
                  2020F1EFE5EAF2F0EEF1EAEEEFE8E8010D0A4564697446726D0101010D0A5363
                  726F6C6C42617246726D0101010D0A7374446973706C61794C6162656C730D0A
                  7374466F6E74730D0A544672616D65506172496E7075740144656661756C7401
                  417269616C010D0A42697442746E46726D0144656661756C7401417269616C01
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
                  Width = 19
                  Height = 16
                  Caption = 'nm'
                  ExplicitLeft = 178
                  ExplicitTop = 11
                  ExplicitWidth = 19
                  ExplicitHeight = 16
                end
                inherited BitBtnFrm: TBitBtn
                  Left = 4
                  Top = 7
                  Width = 127
                  Height = 24
                  Hint = 'Final point >=0'
                  Caption = 'Final Point>0'
                  ExplicitLeft = 4
                  ExplicitTop = 7
                  ExplicitWidth = 127
                  ExplicitHeight = 24
                end
                inherited EditFrm: TEdit
                  Left = 132
                  Top = 11
                  Width = 40
                  Height = 24
                  Hint = 'Final point >=0'
                  ParentShowHint = False
                  ShowHint = True
                  OnChange = FrEndPointEditFrmChange
                  OnExit = FrFrmExit
                  OnKeyPress = FrEndPointEditFrmKeyPress
                  ExplicitLeft = 132
                  ExplicitTop = 11
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
                  0D0A737448696E74730D0A544672616D65506172496E7075740101010D0A6672
                  50616E656C0101010D0A4C6162656C46726D0101010D0A4C6162656C556E6974
                  0101010D0A42697442746E46726D0146696E616C20706F696E74203E3D3001CA
                  EEEDE5F7EDE0FF20F2EEF7EAE0203E3D30010D0A4564697446726D0146696E61
                  6C20706F696E74203E3D3001CAEEEDE5F7EDE0FF20F2EEF7EAE0203E3D30010D
                  0A5363726F6C6C42617246726D0101010D0A7374446973706C61794C6162656C
                  730D0A7374466F6E74730D0A544672616D65506172496E707574014465666175
                  6C7401417269616C010D0A42697442746E46726D0144656661756C7401417269
                  616C010D0A73744D756C74694C696E65730D0A7374537472696E67730D0A7374
                  4F74686572537472696E67730D0A4564697446726D2E546578740101010D0A73
                  74436F6C6C656374696F6E730D0A737443686172536574730D0A544672616D65
                  506172496E7075740144454641554C545F43484152534554015255535349414E
                  5F43484152534554010D0A42697442746E46726D0144454641554C545F434841
                  52534554015255535349414E5F43484152534554010D0A}
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
                  Width = 19
                  Height = 16
                  Caption = 'nm'
                  ExplicitLeft = 177
                  ExplicitTop = 15
                  ExplicitWidth = 19
                  ExplicitHeight = 16
                end
                inherited BitBtnFrm: TBitBtn
                  Left = 1
                  Top = 9
                  Width = 133
                  Height = 23
                  Hint = 'Start point <=0'
                  Caption = 'Start Point<0'
                  ParentShowHint = False
                  ShowHint = True
                  ExplicitLeft = 1
                  ExplicitTop = 9
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
                  OnExit = FrFrmExit
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
                  010D0A737448696E74730D0A544672616D65506172496E7075740101010D0A66
                  7250616E656C0101010D0A4C6162656C46726D0101010D0A4C6162656C556E69
                  740101010D0A42697442746E46726D01537461727420706F696E74203C3D3001
                  CDE0F7E0EBFCEDE0FF20F2EEF7EAE0203C3D30010D0A4564697446726D015374
                  61727420706F696E74203C3D3001CDE0F7E0EBFCEDE0FF20F2EEF7EAE0203C3D
                  30010D0A5363726F6C6C42617246726D0101010D0A7374446973706C61794C61
                  62656C730D0A7374466F6E74730D0A544672616D65506172496E707574014465
                  6661756C7401417269616C010D0A42697442746E46726D0144656661756C7401
                  417269616C010D0A73744D756C74694C696E65730D0A7374537472696E67730D
                  0A73744F74686572537472696E67730D0A4564697446726D2E54657874010101
                  0D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A544672
                  616D65506172496E7075740144454641554C545F434841525345540152555353
                  49414E5F43484152534554010D0A42697442746E46726D0144454641554C545F
                  43484152534554015255535349414E5F43484152534554010D0A}
              end
            end
            inline FrSupLevel: TFrameParInput
              Left = 6
              Top = 359
              Width = 197
              Height = 68
              Color = 14474715
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Default'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 4
              TabStop = True
              ExplicitLeft = 6
              ExplicitTop = 359
              ExplicitWidth = 197
              ExplicitHeight = 68
              inherited frPanel: TPanel
                Left = 2
                Top = 3
                Height = 64
                Hint = 'Max Amplitude Suppresssion'
                ParentBackground = False
                ParentShowHint = False
                ShowHint = True
                ExplicitLeft = 2
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
                  Left = 172
                  Top = 9
                  Width = 11
                  Height = 16
                  Caption = 'lb'
                  ExplicitLeft = 172
                  ExplicitTop = 9
                  ExplicitWidth = 11
                  ExplicitHeight = 16
                end
                inherited BitBtnFrm: TBitBtn
                  Left = 6
                  Top = 6
                  Width = 98
                  Caption = ' Suppresion'
                  ExplicitLeft = 6
                  ExplicitTop = 6
                  ExplicitWidth = 98
                end
                inherited EditFrm: TEdit
                  Left = 114
                  Top = 8
                  Width = 52
                  Height = 24
                  ParentShowHint = False
                  ShowHint = True
                  OnChange = FrSupLevelEditFrmChange
                  OnKeyPress = FrSupLevelEditFrmKeyPress
                  ExplicitLeft = 114
                  ExplicitTop = 8
                  ExplicitWidth = 52
                  ExplicitHeight = 24
                end
                inherited ScrollBarFrm: TScrollBar
                  Left = 13
                  Top = 38
                  Width = 106
                  Height = 15
                  ExplicitLeft = 13
                  ExplicitTop = 38
                  ExplicitWidth = 106
                  ExplicitHeight = 15
                end
              end
              inherited siLangLinked1: TsiLangLinked
                Left = 152
                Top = 32
                TranslationData = {
                  737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
                  0101010D0A4C6162656C556E6974016C6201010D0A42697442746E46726D0120
                  53757070726573696F6E01CFEEE4E0E2EBE5EDE8E5010D0A737448696E74730D
                  0A544672616D65506172496E7075740101010D0A667250616E656C014D617820
                  416D706C697475646520537570707265737373696F6E01CCE0EAF12E20C0ECEF
                  EBE8F2F3E4E020EFEEE4E0E2EBE5EDE8FF010D0A4C6162656C46726D0101010D
                  0A4C6162656C556E69740101010D0A42697442746E46726D0101010D0A456469
                  7446726D0101010D0A5363726F6C6C42617246726D0101010D0A737444697370
                  6C61794C6162656C730D0A7374466F6E74730D0A544672616D65506172496E70
                  75740144656661756C7401417269616C010D0A42697442746E46726D01446566
                  61756C7401417269616C010D0A73744D756C74694C696E65730D0A7374537472
                  696E67730D0A73744F74686572537472696E67730D0A4564697446726D2E5465
                  78740101010D0A7374436F6C6C656374696F6E730D0A73744368617253657473
                  0D0A544672616D65506172496E7075740144454641554C545F43484152534554
                  015255535349414E5F43484152534554010D0A42697442746E46726D01444546
                  41554C545F43484152534554015255535349414E5F43484152534554010D0A}
              end
            end
            object Panel5: TPanel
              Left = 8
              Top = 236
              Width = 193
              Height = 43
              Color = 14474715
              ParentBackground = False
              TabOrder = 5
              object LabelStep: TLabel
                Left = 56
                Top = 5
                Width = 4
                Height = 16
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 522
    Width = 934
    Height = 19
    BorderWidth = 1
    Panels = <
      item
        Style = psOwnerDraw
        Text = 
          'Click Right Button- Popup Menu;Labels ( Click  Left Button - Add' +
          ' ;  Del - Delete;Up,Down-Next,Previous ); '
        Width = 620
      end
      item
        Style = psOwnerDraw
        Text = 'Curves (Pg up,Pg down- next, previous)'
        Width = 50
      end>
    SimpleText = 
      'Click Right Button- Popup Menu;Labels ( Click  Left Button - Add' +
      ' ;  Del - Delete;Up,Down-Next,Previous ); '
    OnDrawPanel = StatusBar1DrawPanel
  end
  object ApplicationEvents: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 472
    Top = 136
  end
  object siLangLinked: TsiLangLinked
    Version = '6.5'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 2
    LangDispatcher = Main.siLangDispatcher1
    OnChangeLanguage = siLangLinkedChangeLanguage
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
    Left = 376
    Top = 304
    TranslationData = {
      737443617074696F6E730D0A545370656374726F73636F707901537065637472
      6F73636F707901D1EFE5EAF2F0EEF1EAEEEFE8FF010D0A50616E656C4D61696E
      0101010D0A50616E656C0101010D0A50616E656C360150616E656C3601010D0A
      50616E656C370101010D0A42697442746E4170706C79014F4B014F4B010D0A42
      697442746E5361766501536176650126D1EEF5F0E0EDE8F2FC010D0A42697442
      746E457869740126457869740126C2FBF5EEE4010D0A436F6E74726F6C50616E
      656C0101010D0A50616E656C320101010D0A50616E656C330101010D0A50616E
      656C340101010D0A50616E656C350101010D0A4C6162656C537465700101010D
      0A4C6162656C537465704D696E0153746570204D696E3D01CCE8ED2E20F8E0E3
      3D010D0A4564697431014564697401D0E5E4E0EAF2E8F0EEE2E0F2FC010D0A43
      6F7079746F636C6970626F6172643101436F707920746F20636C6970626F6172
      6401CAEEEFE8F0EEE2E0F2FC20E220E1F3F4E5F020EEE1ECE5EDE0010D0A546F
      6F6C4261723101546F6F6C4261723101010D0A537461727442746E0120202020
      20202653746172742020202020200120202020202026D1F2E0F0F22020202020
      010D0A546F6F6C426172320101010D0A5072696E7442746E0120202026507269
      6E7420200126CFE5F7E0F2FC010D0A546F6F6C427574746F6E31012648656C70
      01D126EFF0E0E2EAE0010D0A50616E656C4564697442746E730101010D0A5061
      6E656C4C6162656C730101010D0A50616E656C4375727665730101010D0A7374
      48696E74730D0A545370656374726F73636F70790101010D0A50616E656C4D61
      696E0101010D0A50616E656C0101010D0A50616E656C360101010D0A50616765
      436F6E74726F6C0101010D0A50616E656C370101010D0A42697442746E417070
      6C790101010D0A42697442746E536176650101010D0A42697442746E45786974
      0101010D0A436F6E74726F6C50616E656C0101010D0A50616E656C320101010D
      0A50616E656C330101010D0A50616E656C340101010D0A4672540101010D0A46
      724E506F696E74730101010D0A4672456E64506F696E740101010D0A46725374
      617274500101010D0A46725375704C6576656C0101010D0A50616E656C350101
      010D0A4C6162656C537465700101010D0A4C6162656C537465704D696E010101
      0D0A537461747573426172310101010D0A45646974310101010D0A436F707974
      6F636C6970626F617264310101010D0A546F6F6C426172310101010D0A537461
      727442746E0101010D0A546F6F6C426172320101010D0A5072696E7442746E01
      01010D0A4C626C7761726E696E670101010D0A546F6F6C427574746F6E310101
      010D0A50616E656C4564697442746E730101010D0A50616E656C4C6162656C73
      0101010D0A50616E656C4375727665730101010D0A7374446973706C61794C61
      62656C730D0A7374466F6E74730D0A545370656374726F73636F707901446566
      61756C740144656661756C74010D0A4C6162656C537465704D696E0144656661
      756C740144656661756C74010D0A53746174757342617231015461686F6D6101
      44656661756C74010D0A4672540144656661756C740144656661756C74010D0A
      46724E506F696E74730144656661756C740144656661756C74010D0A4672456E
      64506F696E740144656661756C740144656661756C74010D0A46725374617274
      500144656661756C740144656661756C74010D0A46725375704C6576656C0144
      656661756C740144656661756C74010D0A4C626C7761726E696E670144656661
      756C74015461686F6D61010D0A73744D756C74694C696E65730D0A7374537472
      696E67730D0A7374727374727331016E6F2044656D6F204461746121212101ED
      E5F220C4E5ECEE20E4E0EDEDFBF521010D0A7374727374727332015468652073
      74657020746F6F20736D616C6C2101D8E0E320F1EBE8F8EAEEEC20ECE0EB2101
      0D0A7374727374727333014368616E676520506172616D65746572732E01C8E7
      ECE5EDE8F2E520EFE0F0E0ECE5F2F0FB2E010D0A737472737472733401546865
      207374657020746F6F20736D616C6C214368616E676520506172616D65746572
      732E01D8E0E320F1EBE8F8EAEEEC20ECE0EB2120C8E7ECE5EDE8F2E520EFE0F0
      E0ECE5F2F0FB2E010D0A7374727374727335014572726F7220696E7075742E20
      537461727420706F696E74206D757374206265203C3D302101CEF8E8E1EAE020
      E2E2EEE4E02E20CDE0F7E0EBFCEDE0FF20F2EEF7EAE0203C3D3021010D0A7374
      727374727336014572726F7220696E70757401CEF8E8E1EAE020E2E2EEE4E02E
      010D0A7374727374727337015072696E746572206973206E6F7420636F6E6E65
      637465642E202001CFF0E8EDF2E5F020EDE520EFEEE4F1EEE5E4E8EDE5ED2E01
      0D0A7374727374727338012046696C65206E6F7420657869737401D4E0E9EB20
      EDE520F1F3F9E5F1F2E2F3E5F22E010D0A4944535F3001537465703D01D8E0E3
      203D010D0A4944535F313201546F706F6772617068792F546F70205669657701
      D0E5EBFCE5F42FC2E8E420F1E2E5F0F5F3010D0A4944535F3133015068617365
      20536869667401D4E0E7E0010D0A4944535F313401466F72636520496D616765
      01D1E8EBE0010D0A4944535F31350143757272656E7420496D61676501D2EEEA
      010D0A4944535F310153746570204D696E3D01CCE8ED2E20F8E0E33D010D0A49
      44535F32015370656374726F73636F707901D1EFE5EAF2F0EEF1EAEEEFE8FF01
      0D0A4944535F333601506F696E743D2001D2EEF7EAE03D010D0A4944535F3337
      01436C69636B204C65667420427574746F6E20746F20736574206C6162656C3B
      20436C69636B20526967687420427574746F6E20746F2073686F7720706F7075
      70206D656E7501CAEBE8EA20EBE5E2EEE920EAEDEEEFEAEEE9202D20EFEEF1F2
      E0E2E8F2FC20ECE5F2EAF33B20CAEBE8EA20EFF0E0E2EEE92DEFEEEAE0E7E0F2
      FC20ECE5EDFE2E010D0A4944535F3338016162732849292C206E410161627328
      49292C20EDC0010D0A4944535F333901722E752E20412F416D617801EEF2ED2E
      20E5E42E20412F416D6178010D0A4944535F3301206D730120ECF1010D0A4944
      535F3430015A2C206E6D015A2C20EDEC010D0A4944535F343101537065637472
      6F73636F707920437572766501CAF0E8E2E0FF20D1EFE5EAF2F0EEF1EAEEEFE8
      E8010D0A4944535F34320120726973696E6701EEF2E2EEE4010D0A4944535F34
      3301206C616E64696E6701EFEEE4E2EEE4010D0A4944535F3401206E6D0120ED
      EC010D0A4944535F36014C696D6974204954202501CCE0EAF12E20F2EEEA2520
      3D010D0A4944535F37015375707072657373696F6E01CFEEE4E0E2EBE5EDE8E5
      010D0A4944535F38015761726E696E67212054686520736574206C696D697420
      6F662063757272656E742069732061636869657665642121212001CFF0E5E4F3
      EFF0E5E6E4E5EDE8E5202120D3F1F2E0EDEEE2EBE5EDEDFBE920EFF0E5E4E5EB
      20F2EEEAE020E4EEF1F2E8E3EDF3F221010D0A4944535F39015761726E696E67
      212054686520736574206C696D6974206F66207375707072657373696F6E206F
      66206120616D706C6974756465206F7363696C6C6174696F6E20697320616368
      69657665642121212001CFF0E5E4F3EFF0E5E6E4E5EDE8E5202120D3F1F2E0ED
      EEE2EBE5EDEDFBE920EFF0E5E4E5EB20EFEEE4E0E2EBE5EDE8FF20E0ECEFEBE8
      F2F3E4FB20E4EEF1F2E8E3EDF3F221010D0A4944535F35014368616E67652066
      696E616C20706F696E742E01C8E7ECE5EDE8F2E520EAEEEDE5F7EDF3FE20F2EE
      F7EAF32E010D0A737472737472733901436C69636B2052696768742042757474
      6F6E2D20506F707570204D656E753B4C6162656C73202820436C69636B20204C
      65667420427574746F6E202D20416464203B202044656C202D2044656C657465
      3B55702C446F776E2D4E6578742C50726576696F757320293B01CAEBE8EA20EF
      F0E0E2EEE920EAEDEEEFEAEEE92D2020E2F1EFEBFBE22E20ECE5EDFE3B20CCE5
      F2EAE828EAEBE8EA20EBE5E2EEE920EAEDEEEFEAEEE9202D20E4EEE1E0E22E2C
      2064656C2D20F3E4E0EB2E2C55702C446F776E202DF1EBE5E42E2C20EFF0E5E4
      2E2920010D0A73747273747273313001437572766573202850672075702C5067
      20646F776E2D206E6578742C2070726576696F75732901CAF0E8E2FBE5202850
      672075702C506720646F776E2D20F1EBE5E42E202CEFF0E5E42E29010D0A4944
      535F313001466173742043757272656E7420496D61676501C1FBF1F2F0EE20D2
      EEEA010D0A4944535F3131014661737420506861736520496D61676501C1FBF1
      F2F0EE20D4E0E7E0010D0A73744F74686572537472696E67730D0A5453706563
      74726F73636F70792E48656C7046696C650101010D0A53746174757342617231
      2E53696D706C655465787401436C69636B20526967687420427574746F6E2D20
      506F707570204D656E753B4C6162656C73202820436C69636B20204C65667420
      427574746F6E202D20416464203B202044656C202D2044656C6574653B55702C
      446F776E2D4E6578742C50726576696F757320293B2001CAEBE8EA20EFF0E0E2
      EEE920EAEDEEEFEAEEE92D2020E2F1EFEBFBE22E20ECE5EDFE3B20CCE5F2EAE8
      28EAEBE8EA20EBE5E2EEE920EAEDEEEFEAEEE9202D20E4EEE1E0E2E8F2FC2C20
      64656C2D20F3E4E0EBE8F2FC2C55702C446F776E202DF1EBE5E42E2C20EFF0E5
      E42E2920010D0A4C626C7761726E696E672E53696D706C65546578740101010D
      0A7374436F6C6C656374696F6E730D0A537461747573426172312E50616E656C
      735B305D2E5465787401436C69636B20526967687420427574746F6E2D20506F
      707570204D656E753B4C6162656C73202820436C69636B20204C656674204275
      74746F6E202D20416464203B202044656C202D2044656C6574653B55702C446F
      776E2D4E6578742C50726576696F757320293B2001CAEBE8EA20EFF0E0E2EEE9
      20EAEDEEEFEAEEE92D2020E2F1EFEBFBE22E20ECE5EDFE3B20CCE5F2EAE828EA
      EBE8EA20EBE5E2EEE920EAEDEEEFEAEEE9202D20E4EEE1E0E22E2C2064656C2D
      20F3E4E0EB2E2C55702C446F776E202DF1EBE5E42E2C20EFF0E5E42E2920010D
      0A537461747573426172312E50616E656C735B315D2E54657874014375727665
      73202850672075702C506720646F776E2D206E6578742C2070726576696F7573
      2901CAF0E8E2FBE5202850672075702C506720646F776E2D20F1EBE5E42E202C
      EFF0E5E42E29010D0A4C626C7761726E696E672E50616E656C735B305D2E5465
      7874015761726E696E672120546865206C6576656C206F662073757070726573
      73696F6E206F6620616D706C6974756465206F7363696C6C6174696F6E206973
      206163686965766564212001CFF0E5E4F3EFF0E5E6E4E5EDE8E5212020C4EEF1
      F2E8E3EDF3F220EFF0E5E4E5EBFCEDFBE920F3F0EEE2E5EDFC20EFEEE4E0E2EB
      E5EDE8FF20E0ECEFEBE8F2F3E4FB20EAEEEBE5E1E0EDE8E92E20010D0A4C626C
      7761726E696E672E50616E656C735B315D2E5465787401204368616E67652046
      696E616C20506F696E7401C8E7ECE5EDE8F2E520EAEEEDE5F7EDF3FE20F2EEF7
      EAF32E010D0A737443686172536574730D0A545370656374726F73636F707901
      5255535349414E5F43484152534554015255535349414E5F4348415253455401
      0D0A4C6162656C537465704D696E015255535349414E5F434841525345540152
      55535349414E5F43484152534554010D0A537461747573426172310144454641
      554C545F43484152534554015255535349414E5F43484152534554010D0A4672
      540144454641554C545F43484152534554015255535349414E5F434841525345
      54010D0A46724E506F696E74730144454641554C545F43484152534554015255
      535349414E5F43484152534554010D0A4672456E64506F696E74014445464155
      4C545F43484152534554015255535349414E5F43484152534554010D0A467253
      74617274500144454641554C545F43484152534554015255535349414E5F4348
      4152534554010D0A46725375704C6576656C0144454641554C545F4348415253
      4554015255535349414E5F43484152534554010D0A4C626C7761726E696E6701
      5255535349414E5F43484152534554015255535349414E5F4348415253455401
      0D0A}
  end
  object MainMenu1: TMainMenu
    Left = 320
    Top = 104
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Copytoclipboard1: TMenuItem
        Caption = 'Copy to clipboard'
        OnClick = Copytoclipboard1Click
      end
    end
  end
end
