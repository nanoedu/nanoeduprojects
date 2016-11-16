object ScannerCorrVisual: TScannerCorrVisual
  Left = 152
  Top = 256
  Caption = 'ScannerCorrVisual'
  ClientHeight = 512
  ClientWidth = 989
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 8
    Top = 8
    Width = 306
    Height = 393
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      '')
    BottomAxis.Title.Caption = 'Cell Number X Cell Size'
    LeftAxis.Title.Caption = 'Distance measured in nonlinear picture'
    RightAxis.Title.Caption = #1
    View3D = False
    TabOrder = 0
    object Series1: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      Title = 'X section'
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      Title = 'Y Section'
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Pen.Width = 2
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series5: TLineSeries
      Active = False
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      SeriesColor = 16711808
      Brush.Style = bsFDiagonal
      LineBrush = bsFDiagonal
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series6: TLineSeries
      Active = False
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      SeriesColor = clBlue
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Chart2: TChart
    Left = 347
    Top = 9
    Width = 422
    Height = 391
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Grid Cell Size in Nonlinear Picture')
    BottomAxis.Title.Caption = 'Distance, nm'
    LeftAxis.Title.Caption = 'Grid cell size, nm'
    View3D = False
    TabOrder = 1
    object Series3: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      Title = 'X Section'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series4: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      Title = 'Y Section'
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
    ExtendedTranslations = <
      item
        Identifier = 'Chart1.LeftAxis.Title.Caption'
        PropertyType = tkLString
        ValuesEx = {
          44697374616E6365206D6561737572656420696E206E6F6E6C696E6561722070
          69637475726501D0E0F1F1F2EEFFEDE8E52C20E8E7ECE5F0E5EDEDEEE520EDE0
          20EDE5EBE8EDE5E9EDEEE920EAE0F0F2E8EDEAE501}
      end
      item
        Identifier = 'Chart1.RightAxis.Title.Caption'
        PropertyType = tkLString
        ValuesEx = {0101}
      end
      item
        Identifier = 'Series1.HorizAxis'
        PropertyType = tkEnumeration
        ValuesEx = {61426F74746F6D417869730101}
      end
      item
        Identifier = 'Series1.XValues.Name'
        PropertyType = tkLString
        ValuesEx = {580101}
      end
      item
        Identifier = 'Chart2.BottomAxis.Title.Caption'
        PropertyType = tkLString
        ValuesEx = {44697374616E63652C206E6D01D0E0F1F1F2EEFFEDE8E52C20EDEC01}
      end
      item
        Identifier = 'Chart1.BottomAxis.Title.Caption'
        PropertyType = tkLString
        ValuesEx = {43656C6C204E756D62657220582043656C6C2053697A650101}
      end>
    Left = 336
    Top = 440
    TranslationData = {
      737443617074696F6E730D0A545363616E6E6572436F727256697375616C0153
      63616E6E6572436F727256697375616C01010D0A737448696E74730D0A737444
      6973706C61794C6162656C730D0A7374466F6E74730D0A545363616E6E657243
      6F727256697375616C014D532053616E73205365726966015461686F6D61010D
      0A73744D756C74694C696E65730D0A7374537472696E67730D0A73744F746865
      72537472696E67730D0A536572696573312E50657263656E74466F726D617401
      2323302E2323202501010D0A536572696573312E5469746C6501582073656374
      696F6E01010D0A536572696573312E56616C7565466F726D617401232C232330
      2E23232301010D0A536572696573322E50657263656E74466F726D6174012323
      302E2323202501010D0A536572696573322E5469746C6501592053656374696F
      6E01010D0A536572696573322E56616C7565466F726D617401232C2323302E23
      232301010D0A536572696573352E50657263656E74466F726D6174012323302E
      2323202501010D0A536572696573352E56616C7565466F726D617401232C2323
      302E23232301010D0A536572696573362E50657263656E74466F726D61740123
      23302E2323202501010D0A536572696573362E56616C7565466F726D61740123
      2C2323302E23232301010D0A536572696573332E50657263656E74466F726D61
      74012323302E2323202501010D0A536572696573332E5469746C650158205365
      6374696F6E01010D0A536572696573332E56616C7565466F726D617401232C23
      23302E23232301010D0A536572696573342E50657263656E74466F726D617401
      2323302E2323202501010D0A536572696573342E5469746C6501592053656374
      696F6E01010D0A536572696573342E56616C7565466F726D617401232C232330
      2E23232301010D0A7374436F6C6C656374696F6E730D0A737443686172536574
      730D0A545363616E6E6572436F727256697375616C0144454641554C545F4348
      4152534554015255535349414E5F43484152534554010D0A}
  end
end
