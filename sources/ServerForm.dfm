object MDTServiceForm: TMDTServiceForm
  Left = 614
  Top = 160
  BorderStyle = bsToolWindow
  Caption = 'Network scan exchange'
  ClientHeight = 123
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 3
    Width = 64
    Height = 13
    Caption = 'Service name'
  end
  object Label2: TLabel
    Left = 280
    Top = 8
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object ServiceNameEdit: TEdit
    Left = 8
    Top = 32
    Width = 265
    Height = 21
    TabOrder = 0
    Text = 'Image analysis'
  end
  object cbLocalOnly: TCheckBox
    Left = 8
    Top = 72
    Width = 97
    Height = 17
    Caption = 'Localhost only'
    TabOrder = 1
  end
  object StartButton: TButton
    Left = 160
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 2
    OnClick = StartButtonClick
  end
  object StopButton: TButton
    Left = 272
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Stop'
    Enabled = False
    TabOrder = 3
    OnClick = StopButtonClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 104
    Width = 358
    Height = 19
    Panels = <
      item
        Width = 500
      end>
  end
  object Edit1: TEdit
    Left = 280
    Top = 32
    Width = 70
    Height = 21
    TabOrder = 5
    Text = 'Edit1'
    OnExit = Edit1Change
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 51057
    ServerType = stNonBlocking
    OnClientConnect = ServerSocket1ClientConnect
    OnClientDisconnect = ServerSocket1ClientDisconnect
    OnClientRead = ServerSocket1ClientRead
    OnClientError = ServerSocket1ClientError
    Left = 8
    Top = 304
  end
  object FrameSendSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnecting = FrameSendSocketConnecting
    OnConnect = FrameSendSocketConnect
    OnDisconnect = FrameSendSocketDisconnect
    OnWrite = FrameSendSocketWrite
    OnError = FrameSendSocketError
    Left = 48
    Top = 304
  end
end
