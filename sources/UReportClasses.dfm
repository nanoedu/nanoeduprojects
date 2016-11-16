object ReportForm: TReportForm
  Left = 236
  Top = 166
  Width = 768
  Height = 563
  Caption = 'Report Generator'
  Color = clBtnFace
  DockSite = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 16
  object PanelReport: TPanel
    Left = 0
    Top = 209
    Width = 760
    Height = 314
    Hint = 'To Dragdrop Picture   Press Alt and  Drag and Drop  Picture '
    Align = alClient
    Color = clSilver
    TabOrder = 0
    OnResize = PanelReportResize
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 760
    Height = 209
    Align = alTop
    TabOrder = 1
    object PanelBottom: TPanel
      Left = 1
      Top = 105
      Width = 758
      Height = 103
      Align = alBottom
      Color = clSilver
      TabOrder = 0
      object Label1: TLabel
        Left = 4
        Top = 44
        Width = 103
        Height = 16
        Caption = 'Work Identificator'
      end
      object LabelWorkId: TLabel
        Left = 10
        Top = 69
        Width = 7
        Height = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBox2: TGroupBox
        Left = 153
        Top = 9
        Width = 528
        Height = 89
        Caption = 'Personal Data'
        TabOrder = 0
        object Label2: TLabel
          Left = 23
          Top = 25
          Width = 37
          Height = 16
          Caption = 'Name'
        end
        object Label3: TLabel
          Left = 329
          Top = 25
          Width = 37
          Height = 16
          Caption = 'Group'
        end
        object EdName2: TEdit
          Left = 95
          Top = 57
          Width = 149
          Height = 24
          TabOrder = 0
        end
        object EdName1: TEdit
          Left = 94
          Top = 25
          Width = 187
          Height = 24
          TabOrder = 1
        end
        object EdGroup: TEdit
          Left = 404
          Top = 25
          Width = 42
          Height = 24
          TabOrder = 2
        end
      end
      object BitBtn2: TBitBtn
        Left = 10
        Top = 10
        Width = 129
        Height = 31
        Caption = 'Load Template'
        TabOrder = 1
        OnClick = BitBtn2Click
      end
    end
    object PanelUp: TPanel
      Left = 1
      Top = 1
      Width = 758
      Height = 104
      Align = alClient
      Color = clSilver
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 149
        Top = 0
        Width = 228
        Height = 90
        Caption = 'Report'
        TabOrder = 0
        object BitBtnOpenDoc: TBitBtn
          Left = 10
          Top = 53
          Width = 208
          Height = 27
          Caption = 'Open in MS Office Window'
          TabOrder = 0
          OnClick = BitBtnOpenDocClick
        end
        object BitBtnPrint: TBitBtn
          Left = 10
          Top = 20
          Width = 92
          Height = 28
          Caption = 'Print'
          TabOrder = 1
          OnClick = BitBtnPrintClick
        end
        object BitBtnSave: TBitBtn
          Left = 108
          Top = 20
          Width = 110
          Height = 28
          Caption = 'Save to File'
          TabOrder = 2
          OnClick = BitBtnSaveClick
        end
      end
      object BitBtnH: TBitBtn
        Left = 580
        Top = 63
        Width = 93
        Height = 31
        TabOrder = 1
        Kind = bkHelp
      end
      object RadioGroup1: TRadioGroup
        Left = 9
        Top = 0
        Width = 125
        Height = 90
        Caption = 'Type'
        ItemIndex = 0
        Items.Strings = (
          'Word'
          'Power Point')
        TabOrder = 2
      end
      object GroupBoxAct: TGroupBox
        Left = 384
        Top = 2
        Width = 185
        Height = 87
        Caption = 'Action'
        TabOrder = 3
        object BitBtnDelAct: TBitBtn
          Left = 89
          Top = 32
          Width = 89
          Height = 26
          Caption = 'Delete Active'
          TabOrder = 0
          OnClick = BitBtnDelActClick
        end
        object BitBtnAdd: TBitBtn
          Left = 9
          Top = 32
          Width = 73
          Height = 25
          Caption = 'Add'
          PopupMenu = PopupMenuAdd
          TabOrder = 1
          OnMouseDown = BitBtnAddMouseDown
        end
      end
      object BitBtn1: TBitBtn
        Left = 581
        Top = 10
        Width = 129
        Height = 31
        Caption = 'Save as Template'
        TabOrder = 4
        OnClick = BitBtn1Click
      end
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 272
    Top = 274
  end
  object SaveDialog: TSaveDialog
    Filter = '*.doc|*.doc|*.*|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 32
    Top = 265
  end
  object PopupMenuAdd: TPopupMenu
    TrackButton = tbLeftButton
    Left = 136
    Top = 369
    object Title: TMenuItem
      Caption = 'Title'
    end
    object TextContainer: TMenuItem
      Caption = 'Text Container'
      OnClick = TextContainerClick
    end
    object PictureContainer: TMenuItem
      Caption = 'Picture Container'
      OnClick = PictureContainerClick
    end
  end
end
