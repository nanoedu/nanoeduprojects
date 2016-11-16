object FieldZoom: TFieldZoom
  Left = 439
  Top = 206
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Zoom Scan Area '
  ClientHeight = 614
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ChartFieldZoom: TChart
    Left = 0
    Top = 0
    Width = 640
    Height = 614
    AllowPanning = pmNone
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Legend.Visible = False
    Title.Text.Strings = (
      '')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.ExactDateTime = False
    BottomAxis.Maximum = 25.000000000000000000
    LeftAxis.ExactDateTime = False
    View3D = False
    OnAfterDraw = ChartFieldZoomAfterDraw
    Align = alClient
    Color = 14474715
    TabOrder = 0
    OnMouseDown = ChartFieldZoomMouseDown
    OnMouseMove = ChartFieldZoomMouseMove
    OnMouseUp = ChartFieldZoomMouseUp
    object Series1: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      SeriesColor = clGreen
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      SeriesColor = clGreen
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
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
    Left = 392
    Top = 280
    TranslationData = {
      737443617074696F6E730D0A544669656C645A6F6F6D015A6F6F6D205363616E
      20417265612001D3E2E5EBE8F7E5EDEDE0FF2020EEE1EBE0F1F2FC20F1EAE0ED
      E8F0EEE2E0EDE8FF010D0A737448696E74730D0A544669656C645A6F6F6D0101
      010D0A43686172744669656C645A6F6F6D0101010D0A7374446973706C61794C
      6162656C730D0A7374466F6E74730D0A544669656C645A6F6F6D014D53205361
      6E7320536572696601417269616C010D0A73744D756C74694C696E65730D0A73
      74537472696E67730D0A4944535F30015A6F6F6D205363616E20417265612E20
      5363616E20417265613D01D3E2E5EBE8F7E5EDEDE0FF20EEE1EBE0F1F2FC20D1
      EAE0EDE02E2020D0E0E7ECE5F020D1EAE0EDE03D010D0A4944535F3101207820
      01010D0A4944535F32012C206E6D012C20EDEC010D0A73744F74686572537472
      696E67730D0A544669656C645A6F6F6D2E48656C7046696C650101010D0A5365
      72696573312E436F6C6F72536F757263650101010D0A536572696573312E5065
      7263656E74466F726D6174012323302E2323202501010D0A536572696573312E
      5469746C650101010D0A536572696573312E56616C7565466F726D617401232C
      2323302E23232301010D0A536572696573312E584C6162656C73536F75726365
      0101010D0A536572696573322E436F6C6F72536F757263650101010D0A536572
      696573322E50657263656E74466F726D6174012323302E2323202501010D0A53
      6572696573322E5469746C650101010D0A536572696573322E56616C7565466F
      726D617401232C2323302E23232301010D0A536572696573322E584C6162656C
      73536F757263650101010D0A7374436F6C6C656374696F6E730D0A7374436861
      72536574730D0A544669656C645A6F6F6D0144454641554C545F434841525345
      54015255535349414E5F43484152534554010D0A}
  end
end
