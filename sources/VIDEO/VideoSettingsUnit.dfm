object VideoSettings: TVideoSettings
  Left = 501
  Top = 227
  Width = 393
  Height = 173
  Caption = 'Settings'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object SrcDlgBtn: TSpeedButton
    Left = 10
    Top = 6
    Width = 61
    Height = 31
    Hint = 'Source Dialog'
    Caption = 'Source'
    Enabled = False
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = SrcDlgBtnClick
  end
  object FormatDlgBtn: TSpeedButton
    Left = 78
    Top = 6
    Width = 61
    Height = 31
    Hint = 'Format Dialog'
    Caption = 'Format'
    Enabled = False
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = FormatDlgBtnClick
  end
  object DisplayDlgBtn: TSpeedButton
    Left = 145
    Top = 6
    Width = 62
    Height = 31
    Hint = 'Display Dialog'
    Caption = 'Display'
    Enabled = False
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = DisplayDlgBtnClick
  end
  object CompressBtn: TSpeedButton
    Left = 214
    Top = 6
    Width = 102
    Height = 31
    Hint = 'Compression Dialog'
    Caption = 'Compression'
    Enabled = False
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = CompressBtnClick
  end
  object OverlayBtn: TSpeedButton
    Left = 10
    Top = 46
    Width = 61
    Height = 30
    Hint = 'Toggle Overlay'
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Overlay'
    Enabled = False
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = OverlayBtnClick
  end
  object FrameRateLbl: TLabel
    Left = 79
    Top = 54
    Width = 82
    Height = 16
    Caption = 'Frame Rate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DriverCB: TComboBox
    Left = 5
    Top = 89
    Width = 311
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    TabOrder = 0
    OnChange = DriverCBChange
  end
  object FrameRateCB: TComboBox
    Left = 167
    Top = 49
    Width = 43
    Height = 24
    Hint = 'Set Expected Frame Rate'
    Style = csDropDownList
    ItemHeight = 16
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnChange = FrameRateCBChange
    Items.Strings = (
      '30'
      '25'
      '20'
      '15'
      '10'
      '5')
  end
end
