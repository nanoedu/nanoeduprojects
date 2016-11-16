object DockWorkView: TDockWorkView
  Left = 0
  Top = 0
  Caption = 'Work Dir'
  ClientHeight = 694
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 17
  object Panel1: TPanel
    Left = 43
    Top = 0
    Width = 188
    Height = 694
    Align = alLeft
    Caption = 'Panel1'
    DockSite = True
    TabOrder = 0
    Visible = False
  end
  object DockTabSet1: TDockTabSet
    Left = 0
    Top = 0
    Width = 43
    Height = 694
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ShrinkToFit = True
    Style = tsModernTabs
    Tabs.Strings = (
      'work directory')
    TabIndex = 0
    DockSite = False
    DestinationDockSite = Panel1
  end
end
