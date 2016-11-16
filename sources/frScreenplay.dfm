object Scriptplay: TScriptplay
  Left = 742
  Top = 173
  Width = 363
  Height = 500
  Caption = 'Script Generator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 355
    Height = 170
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object PanelBottom: TPanel
      Left = 1
      Top = 85
      Width = 353
      Height = 84
      Align = alBottom
      Color = clSilver
      TabOrder = 0
      object BitBtnLoad: TBitBtn
        Left = 8
        Top = 8
        Width = 105
        Height = 25
        Caption = '&Load Script'
        TabOrder = 0
      end
      object BitBtnSaveTmpl: TBitBtn
        Left = 4
        Top = 46
        Width = 111
        Height = 24
        Caption = 'Save as &Template'
        TabOrder = 1
      end
      object BitBtnClear: TBitBtn
        Left = 144
        Top = 24
        Width = 153
        Height = 25
        Caption = 'Clear Script'
        TabOrder = 2
        OnClick = BitBtnClearClick
      end
    end
    object PanelUp: TPanel
      Left = 1
      Top = 1
      Width = 353
      Height = 84
      Align = alClient
      Color = clSilver
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 4
        Top = 8
        Width = 113
        Height = 73
        TabOrder = 0
        object BitBtnOpenDoc: TBitBtn
          Left = 8
          Top = 24
          Width = 99
          Height = 19
          Caption = '&Execute Script'
          TabOrder = 0
          OnClick = BitBtnOpenDocClick
        end
      end
      object BitBtnH: TBitBtn
        Left = 290
        Top = 27
        Width = 57
        Height = 23
        TabOrder = 1
        Kind = bkHelp
      end
      object GroupBoxAct: TGroupBox
        Left = 120
        Top = 8
        Width = 163
        Height = 73
        Caption = 'New Script'
        TabOrder = 2
        object BitBtnDelAct: TBitBtn
          Left = 79
          Top = 26
          Width = 81
          Height = 21
          Hint = 'Delete Active Container'
          Caption = '&Delete Active'
          TabOrder = 0
          OnClick = BitBtnDelActClick
        end
        object BitBtnAdd: TBitBtn
          Left = 8
          Top = 26
          Width = 60
          Height = 20
          Hint = 'Add New Container'
          Caption = '&Add Action'
          PopupMenu = PopupMenuAdd
          TabOrder = 1
          OnMouseDown = BitBtnAddMouseDown
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 170
    Width = 355
    Height = 290
    Align = alClient
    TabOrder = 1
    object FilterListBox: TListBox
      Left = 40
      Top = 24
      Width = 201
      Height = 233
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 40
    Top = 232
  end
  object OpenDialog1: TOpenDialog
    Left = 112
    Top = 232
  end
  object PopupMenuAdd: TPopupMenu
    Left = 208
    Top = 232
    object Median3: TMenuItem
      Caption = 'Median3'
      OnClick = Median3Click
    end
    object Average3x31: TMenuItem
      Caption = 'Average3x3'
      OnClick = Average3x31Click
    end
    object Planedelete1: TMenuItem
      Caption = 'Plane delete'
      OnClick = Planedelete1Click
    end
    object Surfacedelete1: TMenuItem
      Caption = 'Surface delete'
      OnClick = Surfacedelete1Click
    end
    object Bmpfilecreate1: TMenuItem
      Caption = 'Bmp file create'
    end
  end
end
