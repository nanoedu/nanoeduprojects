object ChangePath: TChangePath
  Left = 0
  Top = 0
  Caption = 'ChangePath'
  ClientHeight = 425
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 643
    Height = 425
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object LblPATH: TLabel
      Left = 40
      Top = 344
      Width = 47
      Height = 16
      Caption = 'LblPATH'
    end
    object Label1: TLabel
      Left = 40
      Top = 304
      Width = 180
      Height = 16
      Caption = 'Path to scanner ini files  DBase '
    end
    object NTShellTreeView: TNTShellTreeView
      Left = 8
      Top = 56
      Width = 417
      Height = 219
      ObjectTypes = [otFolders]
      Root = 'rfDesktop'
      ShellComboBox = NTShellComboBox
      UseShellImages = True
      AutoRefresh = False
      Indent = 19
      RightClickSelect = True
      TabOrder = 0
      OnClick = NTShellTreeViewClick
      FileMask = '*.*'
    end
    object NTShellComboBox: TNTShellComboBox
      Left = 27
      Top = 8
      Width = 238
      Height = 25
      Root = 'rfDesktop'
      ShellTreeView = NTShellTreeView
      UseShellImages = True
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 368
      Top = 392
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 488
      Top = 392
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 3
      OnClick = BitBtn2Click
    end
  end
end
