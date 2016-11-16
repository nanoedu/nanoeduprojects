object ReportForm: TReportForm
  Left = 462
  Top = 167
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
  OnKeyUp = FormKeyUp
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object PanelReport: TPanel
    Left = 0
    Top = 209
    Width = 760
    Height = 314
    Align = alClient
    Color = clCream
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
      Top = 104
      Width = 758
      Height = 104
      Align = alBottom
      TabOrder = 0
      object Label1: TLabel
        Left = 13
        Top = 24
        Width = 74
        Height = 16
        Caption = 'Lab Number'
      end
      object cbLabNmb: TComboBox
        Left = 21
        Top = 56
        Width = 69
        Height = 24
        ItemHeight = 16
        TabOrder = 0
        Text = 'None'
        OnChange = cbLabNmbChange
        Items.Strings = (
          'None'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7')
      end
      object GroupBox2: TGroupBox
        Left = 152
        Top = 8
        Width = 529
        Height = 91
        Caption = 'Personal Data'
        TabOrder = 1
        object Label2: TLabel
          Left = 23
          Top = 24
          Width = 37
          Height = 16
          Caption = 'Name'
        end
        object Label3: TLabel
          Left = 328
          Top = 24
          Width = 37
          Height = 16
          Caption = 'Group'
        end
        object EdName2: TEdit
          Left = 95
          Top = 56
          Width = 149
          Height = 24
          TabOrder = 0
        end
        object EdName1: TEdit
          Left = 94
          Top = 24
          Width = 186
          Height = 24
          TabOrder = 1
        end
        object EdGroup: TEdit
          Left = 404
          Top = 24
          Width = 42
          Height = 24
          TabOrder = 2
        end
      end
    end
    object PanelUp: TPanel
      Left = 1
      Top = 1
      Width = 758
      Height = 103
      Align = alClient
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
      object Button1: TButton
        Left = 586
        Top = 49
        Width = 90
        Height = 31
        Caption = 'Delete Picture'
        TabOrder = 1
        OnClick = Button1Click
      end
      object BitBtnH: TBitBtn
        Left = 580
        Top = 14
        Width = 93
        Height = 30
        TabOrder = 2
        Kind = bkHelp
      end
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 0
        Width = 126
        Height = 90
        Caption = 'Type'
        ItemIndex = 0
        Items.Strings = (
          'Word'
          'Power Point')
        TabOrder = 3
      end
      object GroupBox3: TGroupBox
        Left = 384
        Top = 2
        Width = 185
        Height = 86
        Caption = 'Action'
        TabOrder = 4
        object BitBtn1: TBitBtn
          Left = 6
          Top = 32
          Width = 75
          Height = 25
          Caption = 'Add'
          TabOrder = 0
        end
        object BitBtn2: TBitBtn
          Left = 89
          Top = 32
          Width = 90
          Height = 26
          Caption = 'Delete Active'
          TabOrder = 1
        end
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
    Left = 136
    Top = 369
    object Title: TMenuItem
      Caption = 'Title'
    end
    object TextContainer: TMenuItem
      Caption = 'Text Container'
    end
    object PictureContainer: TMenuItem
      Caption = 'Picture Container'
    end
  end
end
