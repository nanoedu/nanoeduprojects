object formInitUnitEtape: TformInitUnitEtape
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Step by Step initialization'
  ClientHeight = 538
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 378
    Height = 538
    Align = alClient
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 218
      Width = 376
      Height = 319
      Align = alBottom
      TabOrder = 0
      object Memolog: TMemo
        Left = 1
        Top = 1
        Width = 374
        Height = 317
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 376
      Height = 217
      Align = alClient
      TabOrder = 1
      object PageControl1: TPageControl
        Left = 1
        Top = 1
        Width = 374
        Height = 215
        ActivePage = TabSheetStatus
        Align = alClient
        TabOrder = 0
        object TabSheetStatus: TTabSheet
          Caption = 'Step status'
          object GroupBox1: TGroupBox
            Left = 0
            Top = 0
            Width = 366
            Height = 187
            Align = alClient
            Caption = 'Step by step'
            Enabled = False
            TabOrder = 0
            object CheckListBox: TCheckListBox
              Left = 12
              Top = 24
              Width = 339
              Height = 145
              Enabled = False
              ItemHeight = 13
              Items.Strings = (
                'COM server creation'
                'COM server connection'
                'Controller topology loading'
                'Controller start'
                'Adapter ID reading'
                'Scanner parameters reading'
                'Experiment parameters installation'
                'Choose work directory'
                'Device  is ready')
              TabOrder = 0
            end
            object ProgressBar: TProgressBar
              Left = 2
              Top = 167
              Width = 362
              Height = 18
              Align = alBottom
              Max = 16
              TabOrder = 1
            end
          end
        end
        object TabSheetErr: TTabSheet
          Caption = 'Connection error'
          ImageIndex = 1
          TabVisible = False
          object GroupBox2: TGroupBox
            Left = 0
            Top = 0
            Width = 366
            Height = 187
            Align = alClient
            Caption = 'Reload topology'
            TabOrder = 0
            object CheckListBoxErr: TCheckListBox
              Left = 12
              Top = 24
              Width = 339
              Height = 145
              ItemHeight = 13
              Items.Strings = (
                'Stop topology'
                'Unload topology'
                'Load topology'
                'Run topology'
                'Get Adapter ID')
              TabOrder = 0
            end
            object ProgressBar1: TProgressBar
              Left = 2
              Top = 167
              Width = 362
              Height = 18
              Align = alBottom
              Max = 16
              TabOrder = 1
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
    Left = 152
    Top = 400
    TranslationData = {
      737443617074696F6E730D0A54666F726D496E6974556E697445746170650153
      746570206279205374657020696E697469616C697A6174696F6E01CFEEF8E0E3
      EEE2E0FF20EFEEE4E3EEF2EEE2EAE020EA20F0E0E1EEF2E5010D0A5461625368
      65657453746174757301537465702073746174757301D1F2E0F2F3F120F8E0E3
      EEE2010D0A47726F7570426F78310153746570206279207374657001CFEEF1EB
      E5E4EEE2E0F2E5EBFCEDEEF1F2FC20F8E0E3EEE2010D0A546162536865657445
      727201436F6E6E656374696F6E206572726F7201CEF8E8E1EAE020F1E2FFE7E8
      010D0A47726F7570426F78320152656C6F616420746F706F6C6F677901CFE5F0
      E5E7E0E3F0F3E7EAE020F2EEEFEEEBEEE3E8E8010D0A737448696E74730D0A54
      666F726D496E6974556E6974457461706501010D0A7374446973706C61794C61
      62656C730D0A7374466F6E74730D0A54666F726D496E6974556E697445746170
      65015461686F6D61015461686F6D610D0A73744D756C74694C696E65730D0A43
      6865636B4C697374426F782E4974656D730122434F4D20736572766572206372
      656174696F6E222C22434F4D2073657276657220636F6E6E656374696F6E222C
      22436F6E74726F6C6C657220746F706F6C6F6779206C6F6164696E67222C2243
      6F6E74726F6C6C6572207374617274222C224164617074657220494420726561
      64696E67222C225363616E6E657220706172616D65746572732072656164696E
      67222C224578706572696D656E7420706172616D657465727320696E7374616C
      6C6174696F6E222C2243686F6F736520776F726B206469726563746F7279222C
      2244657669636520206973207265616479220122D1EEE7E4E0EDE8E520434F4D
      20F1E5F0E2E5F0E0222C22D3F1F2E0EDEEE2EBE5EDE8E520F1E2FFE7E820F120
      434F4D20F1E5F0E2E5F0EEEC222C22C7E0E3F0F3E7EAE020F2EEEFEEEBEEE3E8
      E820EAEEEDF2F0EEEBEBE5F0E0222C22C7E0EFF3F1EA20EAEEEDF2F0EEEBEBE5
      F0E0222C22CFEEEBF3F7E5EDE8E520E8E4E5EDF2E8F4E8EAE0F2EEF0E020E0E4
      E0EFF2E5F0E0222C22D7F2E5EDE8E520EFE0F0E0ECE5F2F0EEE220F1EAE0EDE5
      F0E0222C22D3F1F2E0EDEEE2EAE020EFE0F0E0ECE5F2F0EEE220FDEAF1EFE5F0
      E8ECE5EDF2E0222C22C2FBE1EEF020F0E0E1EEF7E5E920EFE0EFEAE8222C22CF
      F0E8E1EEF020E3EEF2EEE220EA20F0E0E1EEF2E522010D0A436865636B4C6973
      74426F784572722E4974656D73012253746F7020746F706F6C6F6779222C2255
      6E6C6F616420746F706F6C6F6779222C224C6F616420746F706F6C6F6779222C
      2252756E20746F706F6C6F6779222C2247657420416461707465722049442201
      22CEF1F2E0EDEEE2EAE020F2EEEFEEEBEEE3E8E8222C22C2FBE3F0F3E7EAE020
      F2EEEFEEEBEEE3E8E8222C22C7E0E3F0F3E7EAE020F2EEEFEEEBEEE3E8E8222C
      22C7E0EFF3F1EA20F2EEEFEEEBEEE3E8E8222C22CFEEEBF3F7E5EDE8E520E8E4
      E5EDF2E8F4E8EAE0F2EEF0E020E0E4E0EFF2E5F0E022010D0A7374537472696E
      67730D0A73744F74686572537472696E67730D0A54666F726D496E6974556E69
      7445746170652E48656C7046696C6501010D0A7374436F6C6C656374696F6E73
      0D0A737443686172536574730D0A54666F726D496E6974556E69744574617065
      0144454641554C545F43484152534554015255535349414E5F43484152534554
      0D0A}
  end
end
