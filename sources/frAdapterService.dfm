object AdapterService: TAdapterService
  Left = 0
  Top = 0
  Caption = 'Scanner parameters'
  ClientHeight = 575
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 571
    Height = 575
    Align = alClient
    TabOrder = 0
    object PanelTop: TPanel
      Left = 1
      Top = 1
      Width = 569
      Height = 346
      Align = alClient
      Caption = 'PanelTop'
      TabOrder = 0
      object PanelApply: TPanel
        Left = 1
        Top = 312
        Width = 567
        Height = 33
        Align = alBottom
        Enabled = False
        TabOrder = 0
        object BitBtnApply: TBitBtn
          Left = 56
          Top = 5
          Width = 58
          Height = 18
          Caption = 'Apply'
          TabOrder = 0
          OnClick = BitBtnApplyClick
        end
        object BitBtnSaveToDBase: TBitBtn
          Left = 413
          Top = 3
          Width = 108
          Height = 25
          Caption = 'Save to Dbase'
          TabOrder = 1
          OnClick = BitBtnSaveToDBaseClick
        end
        object BitBtn5: TBitBtn
          Left = 204
          Top = 6
          Width = 125
          Height = 19
          Caption = 'Read from Dbase'
          TabOrder = 2
          OnClick = BitBtn5Click
        end
      end
      object Panel6: TPanel
        Left = 1
        Top = 1
        Width = 567
        Height = 311
        Align = alClient
        Caption = 'Panel6'
        TabOrder = 1
        object PageControl: TPageControl
          Left = 1
          Top = 1
          Width = 565
          Height = 309
          ActivePage = TabSheetScanner
          Align = alClient
          TabOrder = 0
          object TabSheetScanner: TTabSheet
            Caption = 'Scanner'
            ImageIndex = 7
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object GroupBox3: TGroupBox
              Left = 302
              Top = 18
              Width = 245
              Height = 247
              Caption = 'DBase ini files'
              TabOrder = 0
              object Label5: TLabel
                Left = 25
                Top = 128
                Width = 129
                Height = 12
                Caption = 'Path to DBase scannerini files'
              end
              object Label1: TLabel
                Left = 38
                Top = 30
                Width = 96
                Height = 12
                Caption = 'Scanner data base list'
              end
              object BitBtn2: TBitBtn
                Left = 26
                Top = 196
                Width = 117
                Height = 19
                Caption = 'Change path to DBase'
                TabOrder = 0
                OnClick = BitBtn2Click
              end
              object ComboBoxScannersList: TComboBox
                Left = 30
                Top = 60
                Width = 139
                Height = 18
                Style = csOwnerDrawFixed
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ItemHeight = 12
                ParentFont = False
                TabOrder = 1
                OnChange = ComboBoxScannersListChange
              end
              object lblPathDBase: TEdit
                Left = 18
                Top = 154
                Width = 199
                Height = 20
                TabOrder = 2
                Text = 'lblPathDBase'
              end
            end
            object GroupBox4: TGroupBox
              Left = 11
              Top = 30
              Width = 278
              Height = 197
              Caption = 'Scanner'
              TabOrder = 1
              object LblAdapterID: TLabel
                Left = 13
                Top = 111
                Width = 63
                Height = 13
                Caption = 'LblAdapterID'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 16744448
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label3: TLabel
                Left = 13
                Top = 92
                Width = 53
                Height = 13
                Caption = 'Adapter ID'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 16744448
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object LblCurrentScanner: TLabel
                Left = 13
                Top = 65
                Width = 89
                Height = 13
                Caption = 'LblCurrentScanner'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label2: TLabel
                Left = 150
                Top = 35
                Width = 88
                Height = 12
                Caption = 'New Scanner Name'
              end
              object Label6: TLabel
                Left = 13
                Top = 130
                Width = 100
                Height = 13
                Caption = 'Adapter Soft Version'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 16744448
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblAdapterVer: TLabel
                Left = 150
                Top = 130
                Width = 65
                Height = 13
                Caption = 'lblAdapterVer'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 16744448
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object BitBtnNewScanner: TBitBtn
                Left = 138
                Top = 152
                Width = 123
                Height = 25
                Caption = 'Create new scanner'
                TabOrder = 0
                OnClick = BitBtnNewScannerClick
              end
              object EdScannerName: TEdit
                Left = 138
                Top = 65
                Width = 121
                Height = 20
                MaxLength = 8
                TabOrder = 1
                OnKeyPress = EdScannerNameKeyPress
              end
            end
          end
          object TabSheetHeader: TTabSheet
            Caption = 'Header'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object StringGridHeader: TStringGrid
              Left = 0
              Top = 0
              Width = 557
              Height = 282
              Align = alClient
              ColCount = 2
              DefaultColWidth = 300
              RowCount = 12
              FixedRows = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
              TabOrder = 0
              OnKeyPress = StringGridHeaderKeyPress
              RowHeights = (
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24)
            end
            object ComboBoxUnit: TComboBox
              Left = 308
              Top = 53
              Width = 109
              Height = 20
              ItemHeight = 12
              TabOrder = 1
              Text = 'Edu'
              Visible = False
              OnSelect = ComboBoxUnitSelect
              Items.Strings = (
                'None'
                'Edu'
                'ProBeam'
                'Terra')
            end
          end
          object TabSheetParamsX: TTabSheet
            Caption = 'Parameters X+'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object StringGridParamsX: TStringGrid
              Left = 0
              Top = 0
              Width = 557
              Height = 282
              Align = alClient
              ColCount = 2
              DefaultColWidth = 300
              RowCount = 13
              FixedRows = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
              TabOrder = 0
              OnSetEditText = StringGridParamsXSetEditText
              RowHeights = (
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24)
            end
          end
          object TabSheetCurveXX: TTabSheet
            Caption = 'Curve  X+  ;X'
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object StringGridXX: TStringGrid
              Left = 0
              Top = 0
              Width = 557
              Height = 282
              Align = alClient
              ColCount = 2
              DefaultColWidth = 300
              RowCount = 100
              FixedRows = 0
              ScrollBars = ssVertical
              TabOrder = 0
              RowHeights = (
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24)
            end
          end
          object TabSheetCurveXY: TTabSheet
            Caption = 'Curve X+;  Y'
            ImageIndex = 3
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object StringGridXY: TStringGrid
              Left = 0
              Top = 0
              Width = 557
              Height = 282
              Align = alClient
              ColCount = 2
              DefaultColWidth = 300
              RowCount = 100
              FixedRows = 0
              ScrollBars = ssVertical
              TabOrder = 0
              RowHeights = (
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                23
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24)
            end
          end
          object TabSheetParamsY: TTabSheet
            Caption = 'Parametrs Y+'
            ImageIndex = 4
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object StringGridParamsY: TStringGrid
              Left = 0
              Top = 0
              Width = 557
              Height = 282
              Align = alClient
              ColCount = 2
              DefaultColWidth = 300
              RowCount = 13
              FixedRows = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
              TabOrder = 0
              OnSetEditText = StringGridParamsYSetEditText
              RowHeights = (
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24)
            end
          end
          object TabSheetCurveYX: TTabSheet
            Caption = 'Curve Y+; X'
            ImageIndex = 5
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object StringGridYX: TStringGrid
              Left = 0
              Top = 0
              Width = 557
              Height = 282
              Align = alClient
              ColCount = 2
              DefaultColWidth = 300
              RowCount = 100
              FixedRows = 0
              ScrollBars = ssVertical
              TabOrder = 0
            end
          end
          object TabSheetCurveYY: TTabSheet
            Caption = 'Curve Y+; Y'
            ImageIndex = 6
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object StringGridYY: TStringGrid
              Left = 0
              Top = 0
              Width = 557
              Height = 282
              Align = alClient
              ColCount = 2
              DefaultColWidth = 300
              RowCount = 100
              FixedRows = 0
              ScrollBars = ssVertical
              TabOrder = 0
            end
          end
        end
      end
    end
    object PanelBottom: TPanel
      Left = 1
      Top = 347
      Width = 569
      Height = 227
      Align = alBottom
      TabOrder = 1
      object Panel2: TPanel
        Left = 1
        Top = 198
        Width = 567
        Height = 28
        Align = alBottom
        TabOrder = 0
        object BitBtnOk: TBitBtn
          Left = 347
          Top = 3
          Width = 57
          Height = 19
          Caption = 'OK'
          TabOrder = 0
          Visible = False
          OnClick = BitBtnOkClick
        end
        object BitBtnCancel: TBitBtn
          Left = 443
          Top = 3
          Width = 57
          Height = 19
          Caption = 'Cancel'
          TabOrder = 1
          Visible = False
          OnClick = BitBtnCancelClick
        end
        object ProgressBar: TProgressBar
          Left = 5
          Top = 6
          Width = 270
          Height = 17
          TabOrder = 2
        end
      end
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 567
        Height = 197
        Align = alClient
        TabOrder = 1
        object PanelControl: TPanel
          Left = 1
          Top = 1
          Width = 565
          Height = 195
          Align = alClient
          Enabled = False
          TabOrder = 0
          object PanelSave: TPanel
            Left = 303
            Top = 1
            Width = 261
            Height = 193
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
            object GroupBox1: TGroupBox
              Left = 0
              Top = 0
              Width = 261
              Height = 193
              Align = alClient
              Caption = 'Write to adapter'
              TabOrder = 0
              object GroupBox5: TGroupBox
                Left = 12
                Top = 12
                Width = 247
                Height = 157
                TabOrder = 0
                object CheckListBoxWrite: TCheckListBox
                  Left = 88
                  Top = 14
                  Width = 136
                  Height = 94
                  OnClickCheck = CheckListBoxWriteClickCheck
                  BevelOuter = bvNone
                  Color = clBtnFace
                  ItemHeight = 12
                  Items.Strings = (
                    'Header'
                    'Parameters X+'
                    'Curve X+;   X'
                    'Curve X+;   Y'
                    'Parameters Y+'
                    'Curve Y+;   X'
                    'Curve Y+;   Y')
                  TabOrder = 0
                end
                object BitBtnWrite: TBitBtn
                  Left = 1
                  Top = 132
                  Width = 97
                  Height = 18
                  Caption = 'Write to adapter'
                  TabOrder = 1
                  OnClick = BitBtnWriteClick
                end
                object BitBtnCopy: TBitBtn
                  Left = 124
                  Top = 132
                  Width = 103
                  Height = 18
                  Caption = 'Copy to default pages'
                  TabOrder = 2
                  Visible = False
                end
                object BitBtnClear: TBitBtn
                  Left = 8
                  Top = 66
                  Width = 69
                  Height = 19
                  Caption = 'Clear all'
                  TabOrder = 3
                  OnClick = BitBtnClearClick
                end
                object BitBtnChooseAllW: TBitBtn
                  Left = 7
                  Top = 18
                  Width = 70
                  Height = 20
                  Caption = 'Choose all'
                  TabOrder = 4
                  OnClick = BitBtnChooseAllWClick
                end
              end
              object BitBtn4: TBitBtn
                Left = 62
                Top = 170
                Width = 125
                Height = 19
                Caption = 'Clear Adapter'
                TabOrder = 1
                Visible = False
                OnClick = BitBtn4Click
              end
            end
          end
          object Panel4: TPanel
            Left = 1
            Top = 1
            Width = 302
            Height = 193
            Align = alClient
            TabOrder = 1
            object GroupBox2: TGroupBox
              Left = 1
              Top = 1
              Width = 300
              Height = 191
              Align = alClient
              Caption = 'Read from adapter'
              TabOrder = 0
              object GroupBox6: TGroupBox
                Left = -2
                Top = 10
                Width = 297
                Height = 178
                TabOrder = 0
                object CheckListBoxRead: TCheckListBox
                  Left = 149
                  Top = 16
                  Width = 137
                  Height = 94
                  BevelOuter = bvNone
                  Color = clBtnFace
                  ItemHeight = 12
                  Items.Strings = (
                    'Header'
                    'Parameters X+'
                    'Curve X+;   X'
                    'Curve X+;   Y'
                    'Parameters Y+'
                    'Curve Y+;   X'
                    'Curve Y+;   Y')
                  TabOrder = 0
                end
                object BitBtnReadDef: TBitBtn
                  Left = 127
                  Top = 132
                  Width = 167
                  Height = 19
                  Caption = 'Read from adapter default pages'
                  TabOrder = 1
                  Visible = False
                  OnClick = BitBtnReadDefClick
                end
                object BitBtnRead: TBitBtn
                  Left = 7
                  Top = 132
                  Width = 107
                  Height = 19
                  Caption = 'Read from adapter'
                  TabOrder = 2
                  OnClick = BitBtnReadClick
                end
                object BitBtnClearR: TBitBtn
                  Left = 29
                  Top = 66
                  Width = 73
                  Height = 19
                  Caption = 'Clear all'
                  TabOrder = 3
                  OnClick = BitBtnClearRClick
                end
                object BitBtnChooseAllR: TBitBtn
                  Left = 29
                  Top = 25
                  Width = 75
                  Height = 19
                  Caption = 'Choose all'
                  TabOrder = 4
                  OnClick = BitBtnChooseAllRClick
                end
              end
            end
          end
        end
      end
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
    Left = 232
    Top = 248
    TranslationData = {
      737443617074696F6E730D0A544164617074657253657276696365015363616E
      6E657220706172616D657465727301CFE0F0E0ECE5F2F0FB20F1EAE0EDE5F0E0
      010D0A50616E656C546F700150616E656C546F7001010D0A42697442746E4170
      706C79014170706C7901CFF0E8ECE5EDE8F2FC010D0A42697442746E53617665
      546F4442617365015361766520746F20446261736501D1EEF5F0E0EDE8F2FC20
      E220E1E0E7E5010D0A42697442746E3501526561642066726F6D204462617365
      01D7E8F2E0F2FC20E8E720E1E0E7FB010D0A50616E656C360150616E656C3601
      010D0A54616253686565745363616E6E6572015363616E6E657201D1EAE0EDED
      E5F0010D0A47726F7570426F783301444261736520696E692066696C657301D4
      E0E9EBFB20E1E0E7FB010D0A4C6162656C35015061746820746F204442617365
      207363616E6E6572696E692066696C657301CFF3F2FC20EA20F4E0E9EBE0EC20
      E1E0E7FB010D0A4C6162656C31015363616E6E65722064617461206261736520
      6C69737401D1EFE8F1EEEA20E8ECE5ED20F1EAE0EDE5F0EEE220010D0A426974
      42746E32014368616E6765207061746820746F20444261736501C8E7ECE5EDE8
      F2FC20EFF3F2FC20EA20E1E0E7E5010D0A47726F7570426F7834015363616E6E
      657201D1EAE0EDEDE5F0010D0A4C626C416461707465724944014C626C416461
      70746572494401010D0A4C6162656C33014164617074657220494401C8C420E0
      E4E0EFF2E5F0E0010D0A4C626C43757272656E745363616E6E6572014C626C43
      757272656E745363616E6E657201010D0A4C6162656C32014E6577205363616E
      6E6572204E616D6501CDEEE2EEE520E8ECFF20F1EAE0EDEDE5F0E0010D0A4269
      7442746E4E65775363616E6E657201437265617465206E6577207363616E6E65
      7201D1EEE7E4E0F2FC20EDEEE2FBE920F1EAE0EDEDE5F0010D0A546162536865
      65744865616465720148656164657201C7E0E3EEEBEEE2EEEA010D0A54616253
      68656574506172616D735801506172616D657465727320582B01CFE0F0E0ECE5
      F2F0FB20D52B010D0A5461625368656574437572766558580143757276652020
      582B20203B5801CAF0E8E2E0FF2020D52B3B20D5010D0A546162536865657443
      75727665585901437572766520582B3B20205901CAF0E8E2E0FF2020D52B3B20
      59010D0A5461625368656574506172616D735901506172616D6574727320592B
      01CFE0F0E0ECE5F2F0FB20592B010D0A54616253686565744375727665595801
      437572766520592B3B205801CAF0E8E2E0FF20592B3A2058010D0A5461625368
      6565744375727665595901437572766520592B3B205901CAF0E8E2E0FF20592B
      3B2059010D0A42697442746E4F6B014F4B014F4B010D0A42697442746E43616E
      63656C0143616E63656C01CEF2ECE5EDE0010D0A47726F7570426F7831015772
      69746520746F206164617074657201C7E0EFE8F1FC20E220E0E4E0EFF2E5F001
      0D0A42697442746E577269746501577269746520746F206164617074657201C7
      E0EFE8F1FC20E220E0E4E0EFF2E5F0010D0A42697442746E436F707901436F70
      7920746F2064656661756C7420706167657301D1EEF5F0E0EDE8F2FC20EAEEEF
      E8FE20010D0A42697442746E436C65617201436C65617220616C6C01D1F2E5F0
      E5F2FC20E2F1E5010D0A42697442746E43686F6F7365416C6C570143686F6F73
      6520616C6C01C2FBE1F0E0F2FC20E2F1E5010D0A42697442746E3401436C6561
      72204164617074657201CEF7E8F1F2E8F2FC20E0E4E0EFF2E5F0010D0A47726F
      7570426F783201526561642066726F6D206164617074657201D7E8F2E0F2FC20
      E8E720E0E4E0EFF2E5F0E0010D0A42697442746E526561644465660152656164
      2066726F6D20616461707465722064656661756C7420706167657301D7E8F2E0
      F2FC20EAEEEFE8FE20E8E720E0E4E0EFF2E5F0E0010D0A42697442746E526561
      6401526561642066726F6D206164617074657201D7E8F2E0F2FC20E8E720E0E4
      E0EFF2E5F0E0010D0A42697442746E436C6561725201436C65617220616C6C01
      D1F2E5F0E5F2FC20E2F1E5010D0A42697442746E43686F6F7365416C6C520143
      686F6F736520616C6C01C2FBE1F0E0F2FC20E2F1E5010D0A4C6162656C360141
      64617074657220536F66742056657273696F6E01C2E5F0F1E8FF20CFCE20C0E4
      E0EFF265F0E0010D0A6C626C41646170746572566572016C626C416461707465
      7256657201010D0A737448696E74730D0A544164617074657253657276696365
      01010D0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A5441
      64617074657253657276696365015461686F6D61015461686F6D61010D0A4C62
      6C416461707465724944015461686F6D61015461686F6D61010D0A4C6162656C
      33015461686F6D61015461686F6D61010D0A4C626C43757272656E745363616E
      6E6572015461686F6D61015461686F6D61010D0A436F6D626F426F785363616E
      6E6572734C697374015461686F6D61015461686F6D61010D0A4C6162656C3601
      5461686F6D61015461686F6D61010D0A6C626C41646170746572566572015461
      686F6D61015461686F6D61010D0A73744D756C74694C696E65730D0A43686563
      6B4C697374426F7857726974652E4974656D73014865616465722C2250617261
      6D657465727320582B222C22437572766520582B3B20202058222C2243757276
      6520582B3B20202059222C22506172616D657465727320592B222C2243757276
      6520592B3B20202058222C22437572766520592B3B202020592201C7E0E3EEEB
      EEE2EEEA2C22CFE0F0E0ECE5F2F0FB20D52B222C22CAF0E8E2E0FF20D52B3B20
      58222C22CAF0E8E2E0FF20582B3B2059222C22CFE0F0E0ECE5F2F0FB20592B22
      2C22CAF0E8E2E0FF20592B3B2058222C22CAF0E8E2E0FF20592B3B205922010D
      0A436865636B4C697374426F78526561642E4974656D73014865616465722C22
      506172616D657465727320582B222C22437572766520582B3B20202058222C22
      437572766520582B3B20202059222C22506172616D657465727320592B222C22
      437572766520592B3B20202058222C22437572766520592B3B202020592201C7
      E0E3EEEBEEE2EEEA2C22CFE0F0E0ECE5F2F0FB20D52B222C22CAF0E8E2E0FF20
      D52B3B2058222C22CAF0E8E2E0FF20582B3B2059222C22CFE0F0E0ECE5F2F0FB
      20592B222C22CAF0E8E2E0FF20592B3B2058222C22CAF0E8E2E0FF20592B3B20
      5922010D0A7374537472696E67730D0A73744F74686572537472696E67730D0A
      6C626C5061746844426173652E54657874016C626C5061746844426173650101
      0D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A544164
      6170746572536572766963650144454641554C545F4348415253455401525553
      5349414E5F43484152534554010D0A4C626C4164617074657249440144454641
      554C545F43484152534554015255535349414E5F43484152534554010D0A4C61
      62656C330144454641554C545F43484152534554015255535349414E5F434841
      52534554010D0A4C626C43757272656E745363616E6E65720144454641554C54
      5F43484152534554015255535349414E5F43484152534554010D0A436F6D626F
      426F785363616E6E6572734C6973740144454641554C545F4348415253455401
      5255535349414E5F43484152534554010D0A4C6162656C360144454641554C54
      5F43484152534554015255535349414E5F43484152534554010D0A6C626C4164
      61707465725665720144454641554C545F43484152534554015255535349414E
      5F43484152534554010D0A}
  end
end
