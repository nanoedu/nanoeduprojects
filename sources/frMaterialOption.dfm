object frmPalletta: TfrmPalletta
  Left = 298
  Top = 312
  Width = 466
  Height = 380
  Caption = 'Color Material'
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 458
    Height = 33
    Align = alTop
    TabOrder = 0
    object material: TComboBox
      Left = 104
      Top = 7
      Width = 118
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'izumrud'
      OnSelect = materialSelect
      Items.Strings = (
        'izumrud'
        'brass'
        'bronze'
        'chrom'
        'cuprum'
        'gold'
        'silver')
    end
  end
end
