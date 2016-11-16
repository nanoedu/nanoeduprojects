unit frScannerMemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,IniFiles, Buttons, ExtCtrls, QuickRpt,
  QRCtrls, siComp, siLngLnk;

type
  TMemoScanner = class(TForm)
    ScannerMemo: TMemo;
    PanelBtn: TPanel;
    BitBtnOK: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtnPrint: TBitBtn;
    siLangLinked1: TsiLangLinked;
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormCreate(Sender: TObject);
 
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
       { Private declarations }
 private
     direction:byte;
     ScannerData:TStrings;
     ScannerNm:string;
    QuickRep: TQuickRep;
    QRBand: TQRBand;
    QRLabel: TQRLabel;
    QRLabel1:TQRLabel;
    DetailBand: TQRBand;
    QRMemo: TQRMemo;
    function CreateQuickReportComponent:boolean;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent;const ScannerName:string;Direct:byte);
  end;

var
  MemoScanner: TMemoScanner;

implementation

{$R *.dfm}

uses Globalvar,CSPMVar,mMain;
const
	strm1: string = ''; (* Printer is not connected.   *)
	strm2: string = ''; (* No Scanner Ini File *)
	strm3: string = ''; (* . Default Ini File Used!! *)
	strm4: string = ''; (* No Default Scanner Ini File *)
	strm5: string = ''; (* . Program Terminated!! *)

function  TMemoScanner.CreateQuickReportComponent:boolean;
begin
   result:=true;
  if not Assigned(QuickRep) then
  begin
    result:=true;
    try
     QuickRep:=TQuickRep.Create(self);
    except
     begin
     silanglinked1.MessageDlg(strm1{'Printer is not connected.  '},mtwarning,[mbYes],0);
      result:=false;
      exit;
     end;
    end
  end
  else
  begin
     FreeandNil(QuickRep);
    try
     QuickRep:=TQuickRep.Create(self);
    except
     begin
      silanglinked1.MessageDlg(strm1{'Printer is not connected.  '},mtwarning,[mbYes],0);
      result:=false;
      exit;
     end;
    end
  end;
    QuickRep.Parent:=self;
    QuickRep.visible:=false;
    DetailBand:=TQRBand.Create(QuickRep);;
    DetailBand.parent:=QuickRep;
    QRLabel:=TQRLabel.Create(DetailBand);
    QRLabel.parent:=DetailBand;
    QRMemo:=TQRMEmo.Create(DetailBand);
    QRMemo.parent:=DetailBand;
    QRLabel1:=TQRLabel.Create(DetailBand);
    QRLabel1.parent:=DetailBand;
    Application.Processmessages;
end;

Constructor TMemoScanner.Create(AOwner:TComponent;const ScannerName:string;Direct:byte);
var SFile:string;
   iniCSPM:TiniFile;
begin
     inherited Create(AOwner);
     ScannerNm:=ScannerName;
     direction:=direct;
//     QuickRep1.Visible:= False;
     Caption:='Scanner  =  '+ScannerName;
     sFile:=ScannerIniFilesPath+ ScannerIniFile;
if (not FileExists(sFile)) then
  begin
   silanglinked1.ShowMessage(strm2{'No Scanner Ini File'}+SFile+strm3{'. Default Ini File Used!!'});
     sFile:=ScannerDefIniFilesPath+ ScannerDefIniFile;
     if (not FileExists(sFile)) then
      begin
       silanglinked1.ShowMessage(strm4{'No Default Scanner Ini File'}+sfile+strm5{'. Program Terminated!!'});
       Application.Terminate;//exit;
      end
    else Application.Terminate;//exit;
  end;
//      SetFileAttribute_ReadOnly(sfile,false);
      iniCSPM:=TIniFile.Create(sFile);

try
      ScannerData:=TStringlist.Create;
      ScannerData.Capacity:=100;
    //  ScannerData.NameValueSeparator:='=';
    //  ScannerMemo.lines.NameValueSeparator:='=';
  if  iniCSPM.SectionExists(ScannerName) then  iniCSPM.ReadSectionValues(ScannerName,ScannerData);
      // ScannerMemo.MaxLines:=ScannerData.Count;
       ScannerMemo.lines.AddStrings(ScannerData);
       width:=300;
finally
       iniCSPM.Free;
end;
end;

procedure TMemoScanner.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   ScannerData.Free;
   ScannerMemo.Clear;
   ScannerMemo.free;
   Action:=caFree;
end;

procedure TMemoScanner.FormCreate(Sender: TObject);
begin
  UpdateStrings;

end;

procedure TMemoScanner.siLangLinked1ChangeLanguage(Sender: TObject);
begin

  UpdateStrings;
end;

procedure TMemoScanner.UpdateStrings;
begin
  strm5 := siLangLinked1.GetTextOrDefault('strstrm5');
  strm4 := siLangLinked1.GetTextOrDefault('strstrm4');
  strm3 := siLangLinked1.GetTextOrDefault('strstrm3');
  strm2 := siLangLinked1.GetTextOrDefault('strstrm2');
  strm1 := siLangLinked1.GetTextOrDefault('strstrm1');

end;

procedure TMemoScanner.BitBtnOKClick(Sender: TObject);
var i:integer;
sfile,str,strv:string;
 iniCSPM:TiniFile;
begin
   sFile:=ScannerIniFilesPath+ ScannerIniFile;
//  SetFileAttribute_ReadOnly(sfile,false);

   iniCSPM:=TIniFile.Create(sFile);
try
 for i:=0 to ScannerMemo.lines.Count-1 do
 begin
   str:=ScannerMemo.lines.Names[i];
   strv:=ScannerMemo.lines.Values[str];
  try
    if str<>'' then  iniCSPM.writestring(ScannerNm,str,strv);
  except
     on IO: EInOutError do
        begin
            case IO.Errorcode  of
       104:  MessageDlg('error write flash',mtWarning,[mbOk],0);
               end;
        end;
     else
       begin
         flgSaveProcess:=false;
         MessageDlg('error write flash',mtWarning,[mbOk],0);
         iniCSPM.free;
         Close;
         Exit;
       end;
   end;
  end;
 finally
   iniCSPM.free;
 end;
//   SetFileAttribute_ReadOnly(sfile,true);
   modalresult:=mrOK;
   Close;

end;

procedure TMemoScanner.BitBtnPrintClick(Sender: TObject);
var  Present: TDateTime;
 Year, Month, Day, Hour, Minute, Sec, MSec: Word;
  begin
  if not  CreateQuickReportComponent then  exit;
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minute, Sec, MSec);
   case direction of
   0:  QRlabel.Caption:=Caption+' X+' ;
   1:  QRlabel.Caption:=Caption+' Y+' ;
     end;

  QRlabel.Caption:='Print Date '+inttostr(Day)+'.'+inttostr(Month)+'.'+inttostr(Year);
  QRMemo.Lines:= ScannerMemo.lines;
  QuickRep.PreviewModal;
end;

procedure TMemoScanner.BitBtn2Click(Sender: TObject);
begin
  modalresult:=mrCancel;
  Close;
end;

end.

