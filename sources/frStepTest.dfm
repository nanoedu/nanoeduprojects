object StepsTest: TStepsTest
  Left = 120
  Top = 164
  Caption = 'Steps Test'
  ClientHeight = 708
  ClientWidth = 1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object PanelUp: TPanel
    Left = 229
    Top = 0
    Width = 852
    Height = 708
    Align = alClient
    TabOrder = 0
    object PanelBottom: TPanel
      Left = 1
      Top = 586
      Width = 850
      Height = 121
      Align = alClient
      TabOrder = 0
      object BitBtnApply: TBitBtn
        Left = 498
        Top = 20
        Width = 74
        Height = 30
        Caption = 'OK'
        Default = True
        TabOrder = 0
        Visible = False
        NumGlyphs = 2
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 850
      Height = 585
      Align = alTop
      TabOrder = 1
      object PageControl: TPageControl
        Left = 1
        Top = 1
        Width = 848
        Height = 583
        ActivePage = TabSheetZ_N
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object TabSheetZ_N: TTabSheet
          Caption = 'Z(N)'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object ChartZ_N: TChart
            Left = 0
            Top = 0
            Width = 840
            Height = 553
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Legend.Visible = False
            Title.Text.Strings = (
              'Z(N) ---  Blue - Rising;  Red- Landing')
            BottomAxis.Automatic = False
            BottomAxis.AutomaticMaximum = False
            BottomAxis.AutomaticMinimum = False
            BottomAxis.Maximum = 25.000000000000000000
            LeftAxis.Automatic = False
            LeftAxis.AutomaticMaximum = False
            LeftAxis.AutomaticMinimum = False
            LeftAxis.Maximum = 948.000000000000000000
            LeftAxis.Minimum = 209.000000000000000000
            View3D = False
            Align = alClient
            TabOrder = 0
            object SeriesZ_N: TLineSeries
              Marks.Callout.Brush.Color = clBlack
              Marks.Visible = False
              ShowInLegend = False
              Pointer.InflateMargins = True
              Pointer.Style = psCircle
              Pointer.Visible = True
              Stairs = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'Steps Histogram Landing'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object ChartHist: TChart
            Left = 0
            Top = 0
            Width = 840
            Height = 553
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Legend.Visible = False
            Title.Text.Strings = (
              'Steps Histogram Landing')
            View3D = False
            Align = alClient
            TabOrder = 0
            object SeriesH: TAreaSeries
              Marks.Callout.Brush.Color = clBlack
              Marks.Visible = False
              DrawArea = True
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object SeriesH1: TLineSeries
              Marks.Callout.Brush.Color = clBlack
              Marks.Visible = False
              SeriesColor = clRed
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
          end
        end
        object TabSheetHB: TTabSheet
          Caption = 'Steps Histogram Rising'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object ChartHB: TChart
            Left = 0
            Top = 0
            Width = 840
            Height = 553
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Legend.Visible = False
            Title.Text.Strings = (
              'Steps Histogram Rising')
            BottomAxis.Title.Caption = 'nm'
            LeftAxis.Title.Caption = 'N'
            View3D = False
            Align = alClient
            TabOrder = 0
            object SeriesHB: TAreaSeries
              Marks.Callout.Brush.Color = clBlack
              Marks.Visible = False
              SeriesColor = clBlue
              DrawArea = True
              Pointer.InflateMargins = True
              Pointer.Style = psCircle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object SeriesHB1: TLineSeries
              Marks.Callout.Brush.Color = clBlack
              Marks.Visible = False
              SeriesColor = clGreen
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 229
    Height = 708
    Align = alLeft
    TabOrder = 1
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 227
      Height = 59
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 2
      Color = 14474715
      TabOrder = 0
      object StartBitBtn: TBitBtn
        Left = 14
        Top = 14
        Width = 87
        Height = 30
        Caption = '&RUN'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = StartBitBtnClick
      end
      object BitBtnHelp: TBitBtn
        Left = 134
        Top = 14
        Width = 74
        Height = 29
        Caption = '&Help'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        NumGlyphs = 2
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 60
      Width = 227
      Height = 647
      Align = alClient
      TabOrder = 1
      object PanelLeft: TPanel
        Left = 1
        Top = 1
        Width = 225
        Height = 645
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BevelWidth = 2
        Color = 14474715
        TabOrder = 0
        inline FrActiveTime: TFrameParInput
          Left = 7
          Top = 538
          Width = 203
          Height = 93
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Default'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 3
          TabStop = True
          ExplicitLeft = 7
          ExplicitTop = 538
          ExplicitWidth = 203
          ExplicitHeight = 93
          inherited frPanel: TPanel
            Left = 6
            Top = 4
            Width = 201
            Height = 87
            Hint = 'Time delay in the point'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 6
            ExplicitTop = 4
            ExplicitWidth = 201
            ExplicitHeight = 87
            inherited LabelFrm: TLabel
              Left = 153
              Top = 32
              Width = 5
              Height = 18
              Caption = ''
              ExplicitLeft = 153
              ExplicitTop = 32
              ExplicitWidth = 5
              ExplicitHeight = 18
            end
            inherited LabelUnit: TLabel
              Left = 186
              Top = 14
              Width = 51
              Height = 18
              ExplicitLeft = 186
              ExplicitTop = 14
              ExplicitWidth = 51
              ExplicitHeight = 18
            end
            inherited BitBtnFrm: TBitBtn
              Left = -1
              Top = 5
              Width = 123
              Height = 31
              Caption = 'Step '
              Font.Height = -15
              ExplicitLeft = -1
              ExplicitTop = 5
              ExplicitWidth = 123
              ExplicitHeight = 31
            end
            inherited EditFrm: TEdit
              Left = 128
              Top = 10
              Width = 50
              Height = 26
              ParentShowHint = False
              ShowHint = True
              OnChange = FrActiveTimeEditFrmChange
              OnKeyPress = FrActiveTimeEditFrmKeyPress
              ExplicitLeft = 128
              ExplicitTop = 10
              ExplicitWidth = 50
              ExplicitHeight = 26
            end
            inherited ScrollBarFrm: TScrollBar
              Left = 11
              Top = 42
              Width = 105
              Height = 15
              ExplicitLeft = 11
              ExplicitTop = 42
              ExplicitWidth = 105
              ExplicitHeight = 15
            end
          end
          inherited siLangLinked1: TsiLangLinked
            Left = 136
            TranslationData = {
              737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E6974016C6162656C756E697401010D0A42697442
              746E46726D01537465702001D8E0E320F32EE52E010D0A737448696E74730D0A
              544672616D65506172496E70757401010D0A667250616E656C0154696D652064
              656C617920696E2074686520706F696E7401010D0A4C6162656C46726D010101
              0D0A4C6162656C556E69740101010D0A42697442746E46726D0101010D0A4564
              697446726D0101010D0A5363726F6C6C42617246726D0101010D0A7374446973
              706C61794C6162656C730D0A7374466F6E74730D0A544672616D65506172496E
              7075740144656661756C7401417269616C010D0A42697442746E46726D014465
              6661756C7401417269616C010D0A73744D756C74694C696E65730D0A73745374
              72696E67730D0A73744F74686572537472696E67730D0A4564697446726D2E54
              6578740101010D0A7374436F6C6C656374696F6E730D0A737443686172536574
              730D0A544672616D65506172496E7075740144454641554C545F434841525345
              54015255535349414E5F43484152534554010D0A42697442746E46726D014445
              4641554C545F43484152534554015255535349414E5F43484152534554010D0A}
          end
        end
        inline FrSteps: TFrameParInput
          Left = 11
          Top = 212
          Width = 208
          Height = 98
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Default'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          TabStop = True
          ExplicitLeft = 11
          ExplicitTop = 212
          ExplicitWidth = 208
          ExplicitHeight = 98
          inherited frPanel: TPanel
            Left = 5
            Top = 1
            Width = 196
            Height = 89
            ExplicitLeft = 5
            ExplicitTop = 1
            ExplicitWidth = 196
            ExplicitHeight = 89
            inherited LabelFrm: TLabel
              Left = 161
              Top = 28
              Width = 5
              Height = 18
              Caption = ''
              ExplicitLeft = 161
              ExplicitTop = 28
              ExplicitWidth = 5
              ExplicitHeight = 18
            end
            inherited LabelUnit: TLabel
              Top = 15
              Width = 51
              Height = 18
              ExplicitTop = 15
              ExplicitWidth = 51
              ExplicitHeight = 18
            end
            inherited BitBtnFrm: TBitBtn
              Left = 5
              Top = 9
              Width = 119
              Height = 34
              Hint = 'Number  of substeps  in the step'
              Caption = 'Steps Package'
              Font.Height = -15
              OnClick = FrStepsBitBtnFrmClick
              ExplicitLeft = 5
              ExplicitTop = 9
              ExplicitWidth = 119
              ExplicitHeight = 34
            end
            inherited EditFrm: TEdit
              Left = 126
              Top = 12
              Width = 48
              Height = 26
              OnChange = FrStepsEditFrmChange
              OnKeyPress = FrStepsEditFrmKeyPress
              ExplicitLeft = 126
              ExplicitTop = 12
              ExplicitWidth = 48
              ExplicitHeight = 26
            end
            inherited ScrollBarFrm: TScrollBar
              Left = 9
              Top = 49
              Width = 105
              Height = 16
              SmallChange = 10
              ExplicitLeft = 9
              ExplicitTop = 49
              ExplicitWidth = 105
              ExplicitHeight = 16
            end
          end
          inherited siLangLinked1: TsiLangLinked
            Left = 120
            TranslationData = {
              737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E6974016C6162656C756E697401010D0A42697442
              746E46726D015374657073205061636B61676501D8E0E3EEE220E220EFEEF0F6
              E8E8010D0A737448696E74730D0A544672616D65506172496E70757401010D0A
              667250616E656C0101010D0A4C6162656C46726D0101010D0A4C6162656C556E
              69740101010D0A42697442746E46726D014E756D62657220206F662073756273
              746570732020696E20746865207374657001010D0A4564697446726D0101010D
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
        inline FrZmin: TFrameParInput
          Left = 9
          Top = 114
          Width = 204
          Height = 88
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Default'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 2
          TabStop = True
          ExplicitLeft = 9
          ExplicitTop = 114
          ExplicitWidth = 204
          inherited frPanel: TPanel
            Left = 7
            Width = 191
            Height = 87
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 7
            ExplicitWidth = 191
            ExplicitHeight = 87
            inherited LabelFrm: TLabel
              Left = 153
              Top = 25
              Width = 5
              Height = 18
              Caption = ''
              ExplicitLeft = 153
              ExplicitTop = 25
              ExplicitWidth = 5
              ExplicitHeight = 18
            end
            inherited LabelUnit: TLabel
              Left = 154
              Top = 10
              Width = 21
              Height = 18
              Caption = 'nm'
              ExplicitLeft = 154
              ExplicitTop = 10
              ExplicitWidth = 21
              ExplicitHeight = 18
            end
            inherited BitBtnFrm: TBitBtn
              Left = 9
              Top = 7
              Width = 78
              Height = 31
              Hint = 'Gate - Z Min'
              Caption = 'Z Min'
              Font.Height = -15
              ExplicitLeft = 9
              ExplicitTop = 7
              ExplicitWidth = 78
              ExplicitHeight = 31
            end
            inherited EditFrm: TEdit
              Left = 100
              Top = 10
              Width = 48
              Height = 26
              Hint = 'Step >=0'
              ParentShowHint = False
              ShowHint = True
              OnChange = FrZminEditFrmChange
              OnKeyPress = FrZminEditFrmKeyPress
              ExplicitLeft = 100
              ExplicitTop = 10
              ExplicitWidth = 48
              ExplicitHeight = 26
            end
            inherited ScrollBarFrm: TScrollBar
              Left = 9
              Top = 46
              Width = 102
              Height = 16
              ExplicitLeft = 9
              ExplicitTop = 46
              ExplicitWidth = 102
              ExplicitHeight = 16
            end
          end
          inherited siLangLinked1: TsiLangLinked
            Left = 136
            TranslationData = {
              737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E6974016E6D01EDEC010D0A42697442746E46726D
              015A204D696E015A20ECE8ED2E010D0A737448696E74730D0A544672616D6550
              6172496E70757401010D0A667250616E656C0101010D0A4C6162656C46726D01
              01010D0A4C6162656C556E69740101010D0A42697442746E46726D0147617465
              202D205A204D696E01010D0A4564697446726D0153746570203E3D3001010D0A
              5363726F6C6C42617246726D0101010D0A7374446973706C61794C6162656C73
              0D0A7374466F6E74730D0A544672616D65506172496E7075740144656661756C
              7401417269616C010D0A42697442746E46726D0144656661756C740141726961
              6C010D0A73744D756C74694C696E65730D0A7374537472696E67730D0A73744F
              74686572537472696E67730D0A4564697446726D2E546578740101010D0A7374
              436F6C6C656374696F6E730D0A737443686172536574730D0A544672616D6550
              6172496E7075740144454641554C545F43484152534554015255535349414E5F
              43484152534554010D0A42697442746E46726D0144454641554C545F43484152
              534554015255535349414E5F43484152534554010D0A}
          end
        end
        inline FrZmax: TFrameParInput
          Left = 11
          Top = 14
          Width = 207
          Height = 98
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Default'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 1
          TabStop = True
          ExplicitLeft = 11
          ExplicitTop = 14
          ExplicitWidth = 207
          ExplicitHeight = 98
          inherited frPanel: TPanel
            Left = 5
            Top = 9
            Width = 191
            Height = 80
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 5
            ExplicitTop = 9
            ExplicitWidth = 191
            ExplicitHeight = 80
            inherited LabelFrm: TLabel
              Left = 153
              Top = 25
              Width = 5
              Height = 18
              Caption = ''
              ExplicitLeft = 153
              ExplicitTop = 25
              ExplicitWidth = 5
              ExplicitHeight = 18
            end
            inherited LabelUnit: TLabel
              Top = 16
              Width = 21
              Height = 18
              Caption = 'nm'
              ExplicitTop = 16
              ExplicitWidth = 21
              ExplicitHeight = 18
            end
            inherited BitBtnFrm: TBitBtn
              Left = 9
              Top = 10
              Width = 80
              Height = 33
              Hint = 'Gate - Z Max'
              Caption = 'Z Max'
              Font.Height = -15
              ParentShowHint = False
              ShowHint = True
              OnClick = FrZmaxBitBtnFrmClick
              ExplicitLeft = 9
              ExplicitTop = 10
              ExplicitWidth = 80
              ExplicitHeight = 33
            end
            inherited EditFrm: TEdit
              Left = 96
              Top = 14
              Width = 48
              Height = 26
              Hint = 'Start point <=0'
              ParentShowHint = False
              ShowHint = True
              OnChange = FrZmaxEditFrmChange
              OnKeyPress = FrZmaxEditFrmKeyPress
              ExplicitLeft = 96
              ExplicitTop = 14
              ExplicitWidth = 48
              ExplicitHeight = 26
            end
            inherited ScrollBarFrm: TScrollBar
              Left = 9
              Top = 49
              Width = 105
              Height = 16
              SmallChange = 10
              ExplicitLeft = 9
              ExplicitTop = 49
              ExplicitWidth = 105
              ExplicitHeight = 16
            end
          end
          inherited siLangLinked1: TsiLangLinked
            Left = 120
            TranslationData = {
              737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E6974016E6D01EDEC010D0A42697442746E46726D
              015A204D6178015A20ECE0EAF12E010D0A737448696E74730D0A544672616D65
              506172496E70757401010D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E69740101010D0A42697442746E46726D01476174
              65202D205A204D617801010D0A4564697446726D01537461727420706F696E74
              203C3D3001010D0A5363726F6C6C42617246726D0101010D0A7374446973706C
              61794C6162656C730D0A7374466F6E74730D0A544672616D65506172496E7075
              740144656661756C7401417269616C010D0A42697442746E46726D0144656661
              756C7401417269616C010D0A73744D756C74694C696E65730D0A737453747269
              6E67730D0A73744F74686572537472696E67730D0A4564697446726D2E546578
              740101010D0A7374436F6C6C656374696F6E730D0A737443686172536574730D
              0A544672616D65506172496E7075740144454641554C545F4348415253455401
              5255535349414E5F43484152534554010D0A42697442746E46726D0144454641
              554C545F43484152534554015255535349414E5F43484152534554010D0A}
          end
        end
        inline FrCycles: TFrameParInput
          Left = 9
          Top = 315
          Width = 205
          Height = 95
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Default'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 4
          TabStop = True
          ExplicitLeft = 9
          ExplicitTop = 315
          ExplicitWidth = 205
          ExplicitHeight = 95
          inherited frPanel: TPanel
            Left = 7
            Top = 4
            Width = 197
            Height = 86
            Hint = 'Time delay in the point'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 7
            ExplicitTop = 4
            ExplicitWidth = 197
            ExplicitHeight = 86
            inherited LabelFrm: TLabel
              Left = 153
              Top = 32
              Width = 5
              Height = 18
              Caption = ''
              ExplicitLeft = 153
              ExplicitTop = 32
              ExplicitWidth = 5
              ExplicitHeight = 18
            end
            inherited LabelUnit: TLabel
              Left = 158
              Top = 9
              Width = 51
              Height = 18
              ExplicitLeft = 158
              ExplicitTop = 9
              ExplicitWidth = 51
              ExplicitHeight = 18
            end
            inherited BitBtnFrm: TBitBtn
              Left = 9
              Top = 6
              Width = 80
              Height = 30
              Hint = 'Number of cycles Zmin -Zmax- Zmin'
              Caption = 'Cycles '
              Font.Height = -15
              OnClick = FrCyclesBitBtnFrmClick
              ExplicitLeft = 9
              ExplicitTop = 6
              ExplicitWidth = 80
              ExplicitHeight = 30
            end
            inherited EditFrm: TEdit
              Left = 100
              Top = 6
              Width = 50
              Height = 26
              ParentShowHint = False
              ShowHint = True
              OnChange = FrCyclesEditFrmChange
              OnKeyPress = FrCyclesEditFrmKeyPress
              ExplicitLeft = 100
              ExplicitTop = 6
              ExplicitWidth = 50
              ExplicitHeight = 26
            end
            inherited ScrollBarFrm: TScrollBar
              Left = 12
              Top = 43
              Width = 100
              Height = 15
              ExplicitLeft = 12
              ExplicitTop = 43
              ExplicitWidth = 100
              ExplicitHeight = 15
            end
          end
          inherited siLangLinked1: TsiLangLinked
            Left = 120
            TranslationData = {
              737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E69740101010D0A42697442746E46726D01437963
              6C65732001D6E8EAEBEEE2010D0A737448696E74730D0A544672616D65506172
              496E70757401010D0A667250616E656C0154696D652064656C617920696E2074
              686520706F696E7401010D0A4C6162656C46726D0101010D0A4C6162656C556E
              69740101010D0A42697442746E46726D014E756D626572206F66206379636C65
              73205A6D696E202D5A6D61782D205A6D696E01010D0A4564697446726D010101
              0D0A5363726F6C6C42617246726D0101010D0A7374446973706C61794C616265
              6C730D0A7374466F6E74730D0A544672616D65506172496E707574015461686F
              6D6101417269616C010D0A42697442746E46726D014D532053616E7320536572
              696601417269616C010D0A73744D756C74694C696E65730D0A7374537472696E
              67730D0A73744F74686572537472696E67730D0A4564697446726D2E54657874
              0101010D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A
              544672616D65506172496E7075740144454641554C545F434841525345540152
              55535349414E5F43484152534554010D0A42697442746E46726D014445464155
              4C545F43484152534554015255535349414E5F43484152534554010D0A}
          end
        end
        inline FrDelay: TFrameParInput
          Left = 10
          Top = 421
          Width = 203
          Height = 93
          Color = 14474715
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Default'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 5
          TabStop = True
          ExplicitLeft = 10
          ExplicitTop = 421
          ExplicitWidth = 203
          ExplicitHeight = 93
          inherited frPanel: TPanel
            Left = 4
            Top = 2
            Width = 200
            Height = 88
            Hint = 'Time delay in the point'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 4
            ExplicitTop = 2
            ExplicitWidth = 200
            ExplicitHeight = 88
            inherited LabelFrm: TLabel
              Left = 153
              Top = 32
              Width = 5
              Height = 18
              Caption = ''
              ExplicitLeft = 153
              ExplicitTop = 32
              ExplicitWidth = 5
              ExplicitHeight = 18
            end
            inherited LabelUnit: TLabel
              Left = 182
              Top = 14
              Width = 51
              Height = 18
              ExplicitLeft = 182
              ExplicitTop = 14
              ExplicitWidth = 51
              ExplicitHeight = 18
            end
            inherited BitBtnFrm: TBitBtn
              Left = 5
              Top = 7
              Width = 123
              Height = 31
              Caption = 'Delay'
              Font.Height = -15
              ExplicitLeft = 5
              ExplicitTop = 7
              ExplicitWidth = 123
              ExplicitHeight = 31
            end
            inherited EditFrm: TEdit
              Left = 129
              Top = 10
              Width = 51
              Height = 26
              ParentShowHint = False
              ShowHint = True
              OnChange = FrDelayEditFrmChange
              ExplicitLeft = 129
              ExplicitTop = 10
              ExplicitWidth = 51
              ExplicitHeight = 26
            end
            inherited ScrollBarFrm: TScrollBar
              Left = 11
              Top = 42
              Width = 105
              Height = 15
              ExplicitLeft = 11
              ExplicitTop = 42
              ExplicitWidth = 105
              ExplicitHeight = 15
            end
          end
          inherited siLangLinked1: TsiLangLinked
            Left = 136
            TranslationData = {
              737443617074696F6E730D0A667250616E656C0101010D0A4C6162656C46726D
              0101010D0A4C6162656C556E6974016C6162656C756E697401010D0A42697442
              746E46726D0144656C617901C7E0E4E5F0E6EAE0010D0A737448696E74730D0A
              544672616D65506172496E70757401010D0A667250616E656C0154696D652064
              656C617920696E2074686520706F696E7401010D0A4C6162656C46726D010101
              0D0A4C6162656C556E69740101010D0A42697442746E46726D0101010D0A4564
              697446726D0101010D0A5363726F6C6C42617246726D0101010D0A7374446973
              706C61794C6162656C730D0A7374466F6E74730D0A544672616D65506172496E
              7075740144656661756C7401417269616C010D0A42697442746E46726D014465
              6661756C7401417269616C010D0A73744D756C74694C696E65730D0A73745374
              72696E67730D0A73744F74686572537472696E67730D0A4564697446726D2E54
              6578740101010D0A7374436F6C6C656374696F6E730D0A737443686172536574
              730D0A544672616D65506172496E7075740144454641554C545F434841525345
              54015255535349414E5F43484152534554010D0A42697442746E46726D014445
              4641554C545F43484152534554015255535349414E5F43484152534554010D0A}
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
    Left = 344
    Top = 496
    TranslationData = {
      737443617074696F6E730D0A5453746570735465737401537465707320546573
      7401D2E5F1F2E8F0EEE2E0EDE8E520ECEEF2EEF0E0010D0A50616E656C557001
      01010D0A50616E656C426F74746F6D0101010D0A42697442746E4170706C7901
      4F4B01CECA010D0A50616E656C340101010D0A54616253686565745A5F4E015A
      284E2901010D0A54616253686565743201537465707320486973746F6772616D
      204C616E64696E6701C3E8F1F2EEE3F0E0ECECE020F8E0E3EEE220EFF0E820E7
      E0F5E2E0F2E5010D0A5461625368656574484201537465707320486973746F67
      72616D20526973696E6701C3E8F1F2EEE3F0E0ECECE020F8E0E3EEE220EFF0E8
      20EEF2E2EEE4E5010D0A50616E656C310101010D0A50616E656C320101010D0A
      537461727442697442746E012652554E0126D1F2E0F0F2010D0A42697442746E
      48656C70012648656C7001CFEEECEEF9FC010D0A50616E656C330101010D0A50
      616E656C4C6566740101010D0A737448696E74730D0A54537465707354657374
      0101010D0A50616E656C55700101010D0A50616E656C426F74746F6D0101010D
      0A42697442746E4170706C790101010D0A50616E656C340101010D0A50616765
      436F6E74726F6C0101010D0A54616253686565745A5F4E0101010D0A43686172
      745A5F4E0101010D0A5461625368656574320101010D0A436861727448697374
      0101010D0A546162536865657448420101010D0A436861727448420101010D0A
      50616E656C310101010D0A50616E656C320101010D0A53746172744269744274
      6E0101010D0A42697442746E48656C700101010D0A50616E656C330101010D0A
      50616E656C4C6566740101010D0A467241637469766554696D650101010D0A46
      7253746570730101010D0A46725A6D696E0101010D0A46725A6D61780101010D
      0A46724379636C65730101010D0A467244656C61790101010D0A737444697370
      6C61794C6162656C730D0A7374466F6E74730D0A545374657073546573740141
      7269616C0144656661756C74010D0A46725A6D696E0144656661756C74014465
      6661756C74010D0A467253746570730144656661756C740144656661756C7401
      0D0A46724379636C65730144656661756C740144656661756C74010D0A46725A
      6D61780144656661756C740144656661756C74010D0A53746172744269744274
      6E0144656661756C740144656661756C74010D0A50616765436F6E74726F6C01
      417269616C0144656661756C74010D0A467241637469766554696D6501446566
      61756C740144656661756C74010D0A42697442746E48656C700144656661756C
      740144656661756C74010D0A467244656C61790144656661756C7401010D0A73
      744D756C74694C696E65730D0A7374537472696E67730D0A4944535F30012653
      544F5001D126F2EEEF010D0A4944535F31012020206D65616E3D200120D1F0E5
      E4EDE8E9203D010D0A4944535F3201202020537464204465763D200120D1F2E0
      EDE4E0F0F2EDEEE520EEF2EAEBEEEDE5EDE8E53D010D0A4944535F3501265255
      4E0126D1F2E0F0F2010D0A4944535F390153746F702054657374206265666F72
      65206578697421212101CFF0E5E6E4E52C20F7E5EC20E2FBE9F2E820EEF1F2E0
      EDEEE2E8F2E520F2E5F1F2E8F0EEE2E0EDE8E52E20010D0A7374727374726368
      72743101537465707320486973746F6772616D204C616E64696E670122C3E8F1
      F2EEE3F0E0ECECE020F8E0E3EEE22E20D1E1EBE8E6E5EDE8E52E22010D0A7374
      72737472636872743201537465707320486973746F6772616D20526973696E67
      0122C3E8F1F2EEE3F0E0ECECE020F8E0E3EEE22E20D3E4E0EBE5EDE8E52E2201
      0D0A7374727374726368727433015A284E29202D2D2D2020426C7565202D2052
      6973696E673B20205265642D204C616E64696E67015A284E29202D2D20C3EEEB
      F3E1EEE92DD3E4E0EBE5EDE8E53B20CAF0E0F1EDFBE920F1E1EBE8E6E5EDE8E5
      2E010D0A73744F74686572537472696E67730D0A545374657073546573742E48
      656C7046696C650101010D0A5365726965735A5F4E2E436F6C6F72536F757263
      650101010D0A5365726965735A5F4E2E50657263656E74466F726D6174012323
      302E2323202501010D0A5365726965735A5F4E2E5469746C650101010D0A5365
      726965735A5F4E2E56616C7565466F726D617401232C2323302E23232301010D
      0A5365726965735A5F4E2E584C6162656C73536F757263650101010D0A536572
      696573482E436F6C6F72536F757263650101010D0A536572696573482E506572
      63656E74466F726D6174012323302E2323202501010D0A536572696573482E54
      69746C650101010D0A536572696573482E56616C7565466F726D617401232C23
      23302E23232301010D0A536572696573482E584C6162656C73536F7572636501
      01010D0A53657269657348312E436F6C6F72536F757263650101010D0A536572
      69657348312E50657263656E74466F726D6174012323302E2323202501010D0A
      53657269657348312E5469746C650101010D0A53657269657348312E56616C75
      65466F726D617401232C2323302E23232301010D0A53657269657348312E584C
      6162656C73536F757263650101010D0A53657269657348422E436F6C6F72536F
      757263650101010D0A53657269657348422E50657263656E74466F726D617401
      2323302E2323202501010D0A53657269657348422E5469746C650101010D0A53
      657269657348422E56616C7565466F726D617401232C2323302E23232301010D
      0A53657269657348422E584C6162656C73536F757263650101010D0A53657269
      65734842312E436F6C6F72536F757263650101010D0A5365726965734842312E
      50657263656E74466F726D6174012323302E2323202501010D0A536572696573
      4842312E5469746C650101010D0A5365726965734842312E56616C7565466F72
      6D617401232C2323302E23232301010D0A5365726965734842312E584C616265
      6C73536F757263650101010D0A7374436F6C6C656374696F6E730D0A73744368
      6172536574730D0A545374657073546573740144454641554C545F4348415253
      4554015255535349414E5F43484152534554010D0A50616765436F6E74726F6C
      0144454641554C545F43484152534554015255535349414E5F43484152534554
      010D0A537461727442697442746E015255535349414E5F434841525345540152
      55535349414E5F43484152534554010D0A42697442746E48656C700152555353
      49414E5F43484152534554015255535349414E5F43484152534554010D0A4672
      41637469766554696D650144454641554C545F43484152534554015255535349
      414E5F43484152534554010D0A467253746570730144454641554C545F434841
      52534554015255535349414E5F43484152534554010D0A46725A6D696E014445
      4641554C545F43484152534554015255535349414E5F43484152534554010D0A
      46725A6D61780144454641554C545F43484152534554015255535349414E5F43
      484152534554010D0A46724379636C65730144454641554C545F434841525345
      54015255535349414E5F43484152534554010D0A467244656C61790144454641
      554C545F4348415253455401010D0A}
  end
end
