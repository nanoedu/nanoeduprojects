object CurrentLineWnd: TCurrentLineWnd
  Left = 326
  Top = 189
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Current  line'
  ClientHeight = 374
  ClientWidth = 692
  Color = clBtnFace
  Constraints.MaxHeight = 408
  Constraints.MinHeight = 163
  Constraints.MinWidth = 203
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 340
    Align = alClient
    TabOrder = 0
    object ChartCurrentLine: TChart
      Left = 1
      Top = 1
      Width = 690
      Height = 338
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      Title.Text.Strings = (
        '')
      BottomAxis.GridCentered = True
      LeftAxis.LabelsSize = 46
      LeftAxis.Title.Caption = 'Height, nm'
      LeftAxis.TitleSize = 13
      RightAxis.Grid.Visible = False
      RightAxis.LabelsSize = 46
      RightAxis.Title.Caption = 'Phase, a.u.'
      View3D = False
      Align = alClient
      Color = clWhite
      TabOrder = 0
      object SeriesLine: TFastLineSeries
        Marks.Callout.Brush.Color = clBlack
        Marks.Visible = False
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object SeriesAddLine: TFastLineSeries
        Marks.Callout.Brush.Color = clBlack
        Marks.Visible = False
        SeriesColor = 4227072
        VertAxis = aRightAxis
        LinePen.Color = 4227072
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 340
    Width = 692
    Height = 34
    Align = alBottom
    TabOrder = 1
    Visible = False
    DesignSize = (
      692
      34)
    object BitBtnHideH: TBitBtn
      Left = 8
      Top = 4
      Width = 98
      Height = 21
      Caption = 'Hide Height'
      TabOrder = 0
      OnClick = BitBtnHideHClick
    end
    object BitBtnHideAdd: TBitBtn
      Left = 444
      Top = 5
      Width = 112
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'Hide Add Signal'
      TabOrder = 1
      OnClick = BitBtnHideAddClick
    end
    object BitBtnShowH: TBitBtn
      Left = 111
      Top = 4
      Width = 91
      Height = 21
      Caption = 'Show Height'
      TabOrder = 2
      OnClick = BitBtnShowHClick
    end
    object BitBtnShowAdd: TBitBtn
      Left = 561
      Top = 5
      Width = 126
      Height = 21
      Anchors = [akTop, akRight]
      Caption = 'Show Add Signal'
      TabOrder = 3
      OnClick = BitBtnShowAddClick
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
    ExtendedTranslations = <
      item
        Identifier = 'ChartCurrentLine.Title.Text'
        PropertyType = tkClass
        ValuesEx = {22220101}
      end
      item
        Identifier = 'ChartCurrentLine.LeftAxis.Title.Caption'
        PropertyType = tkLString
        ValuesEx = {4865696768742C206E6D01C2FBF1EEF2E02C20EDEC01}
      end>
    Left = 256
    Top = 104
    TranslationData = {
      737443617074696F6E730D0A5443757272656E744C696E65576E640143757272
      656E7420206C696E6501D2E5EAF3F8E0FF20EBE8EDE8FF010D0A50616E656C31
      0101010D0A50616E656C426F74746F6D0101010D0A42697442746E4869646548
      01486964652048656967687401D1EFF0FFF2E0F2FC20C2FBF1EEF2F3010D0A42
      697442746E48696465416464014869646520416464205369676E616C01D1EFF0
      FFF2E0F2FC20E4EEEF2E20F1E8E3EDE0EB010D0A42697442746E53686F774801
      53686F772048656967687401CFEEEAE0E7E0F2FC20E2FBF1EEF2F3010D0A4269
      7442746E53686F774164640153686F7720416464205369676E616C01CFEEEAE0
      E7E0F2FC20E4EEEF2E20F1E8E3EDE0EB010D0A737448696E74730D0A54437572
      72656E744C696E65576E640101010D0A50616E656C310101010D0A50616E656C
      426F74746F6D0101010D0A436861727443757272656E744C696E650101010D0A
      42697442746E48696465480101010D0A42697442746E48696465416464010101
      0D0A42697442746E53686F77480101010D0A42697442746E53686F7741646401
      01010D0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A5443
      757272656E744C696E65576E64014D532053616E73205365726966015461686F
      6D61010D0A73744D756C74694C696E65730D0A7374537472696E67730D0A4944
      535F300143757272656E74204C696E652001D2E5EAF3F9E0FF20EBE8EDE8FF20
      20010D0A73744F74686572537472696E67730D0A5443757272656E744C696E65
      576E642E48656C7046696C650101010D0A5365726965734C696E652E50657263
      656E74466F726D6174012323302E2323202501010D0A5365726965734C696E65
      2E5469746C650101010D0A5365726965734C696E652E56616C7565466F726D61
      7401232C2323302E23232301010D0A5365726965734C696E652E584C6162656C
      73536F757263650101010D0A5365726965734164644C696E652E50657263656E
      74466F726D6174012323302E2323202501010D0A5365726965734164644C696E
      652E5469746C650101010D0A5365726965734164644C696E652E56616C756546
      6F726D617401232C2323302E23232301010D0A5365726965734164644C696E65
      2E584C6162656C73536F757263650101010D0A7374436F6C6C656374696F6E73
      0D0A737443686172536574730D0A5443757272656E744C696E65576E64014445
      4641554C545F43484152534554015255535349414E5F43484152534554010D0A}
  end
end
