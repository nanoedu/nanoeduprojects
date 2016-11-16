//271207
unit frHeader;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, GlobalDcl, Buttons, ExtCtrls, siComp, siLngLnk;
type
  TFileHeaderForm = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    HeaderGrid: TStringGrid;
    Memo: TMemo;
    siLangLinked1: TsiLangLinked;
    PanelBtns: TPanel;
    BitBtnEdit: TBitBtn;
    BitBtnOK: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure BitBtnEditClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure HeaderGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MemoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    tmpFileName:string;
    lhead: HeadParmType;
    lmainrc:MainFileRec;
    procedure CopyHeader;
//    procedure CopyToClipboard;
  public
    { Public declarations }
    procedure   ReadParam(const FileName: String);
    constructor Create(AOwner:TComponent;const FileName:string);
  end;

var
  FileHeaderForm: TFileHeaderForm;

implementation

uses globalvar,CSPMVar,mMain, clipbrd,RenishawVars;

const
	Cells00: string = ''; (* Device *)
	Cells01: string = ''; (* Data  *)
	Cells02: string = ''; (* Sample Material *)
	Cells03: string = ''; (* Scan Area, nm x nm *)
	Cells04: string = ''; (* Step X,Y nm  *)
	Cells05: string = ''; (* NX ,points *)
	Cells06: string = ''; (* NY ,points *)
	Cells07: string = ''; (* Scanning Velocity, nm/s *)
	Cells08: string = ''; (* X0,nm  *)
	Cells09: string = ''; (* Y0,nm  *)
	Cells010: string = ''; (* Sensitivity X,nm/V   *)
	Cells011: string = ''; (* Sensitivity Y,nm/V   *)
	Cells012: string = ''; (* Sensitivity Z,nm/V   *)
	Cells013: string = ''; (* Feed Back Loop Gain *)
	Cells20: string = ''; (* Tunnel Current, nA  *)
	Cells21: string = ''; (* Tunnel Voltage, V *)
	Cells22: string = ''; (* Path Type *)
	Cells23: string = ''; (* Z Gain *)
	Cells24: string = ''; (* X Gain *)
	Cells25: string = ''; (* Y Gain *)
	Cells26: string = ''; (* Oscillation Amplitude, mV *)
	Cells27: string = ''; (* Gain AM *)
	Cells28: string = ''; (* Gain FM *)
	Cells29: string = ''; (* Resonance Frequency, kHz *)
	Cells213F: string = ''; (*  Time Action ms *)
	Cells213C: string = ''; (*  Time Action mc *)
	Cells213Dz: string = ''; (* Dz, nm *)
	Cells214F: string = ''; (*  Deepth nm *)
	Cells214C: string = ''; (*  Bias  V *)

	Cells30:  string = ''; (* Amplitude Suppression *)
	Cells017: string = ''; (* Scanner Number *)
	Cells018: string = ''; (* Comment2 *)
	Cells019: string = ''; (* Comment3 *)
	Cells020: string = ''; (* Comment4 *)
	Cells021: string = ''; (* Comment5 *)
	CellsScanTime: string = ''; (* ScanningTime, min *) // TSI: Localized (Don't modify!)
  MsgNoData :string = 'No data';
{$R *.DFM}

procedure TFileHeaderForm.ReadParam(const FileName: String);
var
  flg,i:integer;
  ss: String;
  value: single;
  myRect: TGridRect;
begin
 tmpFileName:=FileName;
if  ReadHeader(FileName,flg,lHead,lMainRc)>0 then exit;
 with HeaderGrid do
  begin
    myRect.Left := 20;
    myRect.Top := 20;
    myRect.Right := 20;
    myRect.Bottom := 20;
    Selection := myRect;
    ColWidths[0]:=170;
    ColWidths[1]:=160;
    ColWidths[2]:=210;//192;
    ColWidths[3]:=90;
    RowCount:=14;
    HeaderGrid.width:= ColWidths[0]+ ColWidths[1]+
                                      ColWidths[2]+ ColWidths[3]+5*HeaderGrid.GridLineWidth;
    HeaderGrid.Height:=HeaderGrid.GridLineWidth;
   for i:=0 to RowCount-1 do
    HeaderGrid.Height:=HeaderGrid.Height+RowHeights[i]+HeaderGrid.GridLineWidth;
    HeaderGrid.Top:=0;
    HeaderGrid.Left:=5;
  if (lHead.HProbeType=0) then  ss:= siLangLinked1.GetTextOrDefault('IDS_0' (* 'SFM' *) )  else    ss:= siLangLinked1.GetTextOrDefault('IDS_1' (* 'STM' *) );
    Cells[0,0]:=Cells00;
    Cells[1,0]:=ss;
    Cells[0,1]:=Cells01;
    Cells[1,1]:= IntToStr(lhead.HDay)+' . '
                 + IntToStr(lhead.HMonth) +' . '
                 + IntToStr(lhead.HYear)+'; '+intToStr(lhead.HHour)+' . '
                 + IntToStr(lhead.HMinute) +' . '
                 + IntToStr(lhead.HSecond);
    Cells[0,2]:=Cells02;
    Cells[1,2]:=lhead.HMaterial;//Format('%d',[TopoSpm.FileHeadrcd.HNXTopo]);
    Cells[0,3]:=Cells22;
    case    lhead.HPathMode of
  0:  Cells[1,3]:='X+';
  1:  Cells[1,3]:='Y+';
  2:  Cells[1,3]:='X+X+';
  3:  Cells[1,3]:='Y+Y+';
              end;

    Cells[0,4]:=Cells03;
   if lhead.HAquiTopo
      then
       begin
          Cells[1,4]:=Format('%d',[round(lhead.HNXTopo*lhead.HstepXY)])+' x '+
                         Format('%d',[round(lhead.HNYTopo*lhead.HstepXY)]);
          Cells[1,5]:=Format('%f',[lhead.HstepXY]);
          Cells[1,6]:=Format('%d',[lhead.HNXTopo]);
          Cells[1,7]:=Format('%d',[lhead.HNYTopo ]);
       end
     else
      begin
          Cells[1,4]:=Format('%d',[round(lmainrc.nxadd*lhead.HstepXY)])+' x '+
                      Format('%d',[round(lmainrc.NyAdd*lhead.HstepXY)])  ;
          Cells[1,5]:=Format('%f',[lhead.HstepXY]);
          Cells[1,6]:=Format('%d',[lmainrc.nxadd]);
          Cells[1,7]:=Format('%d',[lmainrc.NyAdd]);
      end;
    Cells[0,5]:=Cells04;
    Cells[1,5]:=Format('%f',[lhead.HstepXY]);
    Cells[0,6]:=Cells05;
    Cells[0,7]:=Cells06;
    Cells[0,8]:=Cells07;
    Cells[1,8]:=Format('%f',[lhead.HScanRate]);
    Cells[0,9]:=CellsScanTime;
    Cells[1,9]:=Inttostr(lhead.HScanningTime_sec);

    Cells[0,10]:=Cells08;
    Cells[1,10]:=Format('%f',[lhead.HXBegin]);
    Cells[0,11]:=Cells09;
    Cells[1,11]:=Format('%f',[lhead.HYBegin]);


    Cells[0,12]:=Cells013;
 if lhead.HFBGain<>0 then
 begin
    Cells[1,12]:=Format('%d',[abs(lhead.HFBGain)]);
 end
 else Cells[1,12]:= MsgNoData;

    Cells[2,0]:=Cells010;
    Cells[3,0]:=Format('%f',[lhead.HSensX]);
    Cells[2,1]:=Cells011;
    Cells[3,1]:=Format('%f',[lhead.HSensY]);
    Cells[2,2]:=Cells012;
    Cells[3,2]:=Format('%f',[lhead.HSensZ]);

    Cells[2,3]:=Cells20;
    Cells[3,3]:=Format('%f',[lhead.HScanCurrent]);
    Cells[2,4]:=Cells21;
    Cells[3,4]:=Format('%f',[lhead.HScanVoltage]);

 (*   Cells[2,3]:=Cells23;
    value:= lHead.HAMP_GainZ;
    Cells[3,3]:=Format('%f',[lHead.HAMP_GainZ]);
    Cells[2,4]:=Cells24;
    Cells[3,4]:=Format('%f',[lHead.HGainX]);
    Cells[2,5]:=Cells25;
    Cells[3,5]:=Format('%f',[lHead.HGainY]);   *)
    Cells[2,5]:=Cells26;               // было [2,6]
    value:={3.9*}lHead.HAmpModulation;    // почему умножается 3.9  ?
    Cells[3,5]:=Format('%f',[value]);
//    Cells[2,7]:=Cells27;
 //   value:=lHead.HSDGainAM/($FF-lHead.HSDGainAM);
 //   Cells[3,7]:=Format('%f',[value]);
 //   Cells[2,8]:=Cells28;
 //   value:=lhead.HSDGainFM/($FF-lHead.HSDGainFM);
//    Cells[3,8]:=Format('%f',[value]);
    Cells[2,6]:=Cells29;               //  // было [2,7]
    with  lHead do
     value:=HResFreqR div 1000;  //HF0*(1+5.45*0.001*(HResFreqR-$80)+5.45*0.0001*(HResFreqF-$80));
    Cells[3,6]:=Format('%f',[value]);
    Cells[2,7]:=Cells30;
    Cells[3,7]:= FloatToStrF(lHead.HAmplSuppress,fffixed,4,2);
    Cells[2,8]:=Cells017;
    Cells[3,8]:=lHead.HScannerName;
    if lHead.HAquiRenishaw then
    begin
      Cells[2,9]:=siLangLinked1.GetTextOrDefault('IDS_26' (* 'Renishaw' *) );
      Cells[3,9]:='True'
    end
    else
    begin
      Cells[2,9]:=siLangLinked1.GetTextOrDefault('IDS_34' (* 'Flag Linearization' *) );
      if lHead.HFlagLinear    then Cells[3,9]:='True'
                              else Cells[3,9]:='False';
    end;

   if lhead.HAquiADD=litho then
   begin
     Cells[2,10]:=Cells213F;
     Cells[3,10]:=Format('%f',[lHead.HLithoAction]);
   end;
   if lhead.HAquiADD=lithocurrent then
   begin
     Cells[2,11]:=Cells213C;
     Cells[3,11]:=Format('%f',[lHead.HLithoAction]);
   end;
   if (LHead.HPathMode=Multi) or (LHead.HPathMode=MultiY) then
     begin
     Cells[2,12]:=Cells213Dz;
     Cells[3,12]:=Format('%d',[lHead.HDz]);
     end;
 end; //with Grid
  Memo.Clear;
  with Memo.Lines do
   begin
   for i:=0 to 7 do
    add(lHead.Comments[i]);
   end;
     Caption:= siLangLinked1.GetTextOrDefault('IDS_37' (* 'The File Header of  ' *) ) +FileName;
     width:=HeaderGrid.Width+20;
      Application.ProcessMessages;
end;

procedure TFileHeaderForm.siLangLinked1ChangeLanguage(Sender: TObject);
begin

  UpdateStrings;
end;

procedure TFileHeaderForm.UpdateStrings;
begin
  CellsScanTime := siLangLinked1.GetTextOrDefault('strCellsScanTime' (* 'ScanningTime, min' *) );
  Cells213Dz := siLangLinked1.GetTextOrDefault('strCells213Dz');
  Cells214C := siLangLinked1.GetTextOrDefault('strCells214C');
  Cells214F := siLangLinked1.GetTextOrDefault('strCells214F');
  Cells213C := siLangLinked1.GetTextOrDefault('strCells213C');
  Cells213F := siLangLinked1.GetTextOrDefault('strCells213F');
  Cells013 := siLangLinked1.GetTextOrDefault('strCells013');
  Cells021 := siLangLinked1.GetTextOrDefault('strCells021');
  Cells020 := siLangLinked1.GetTextOrDefault('strCells020');
  Cells019 := siLangLinked1.GetTextOrDefault('strCells019');
  Cells018 := siLangLinked1.GetTextOrDefault('strCells018');
  Cells017 := siLangLinked1.GetTextOrDefault('strCells017');
  Cells30 := siLangLinked1.GetTextOrDefault('strCells30');
  Cells29 := siLangLinked1.GetTextOrDefault('strCells29');
  Cells28 := siLangLinked1.GetTextOrDefault('strCells28');
  Cells27 := siLangLinked1.GetTextOrDefault('strCells27');
  Cells26 := siLangLinked1.GetTextOrDefault('strCells26');
  Cells25 := siLangLinked1.GetTextOrDefault('strCells25');
  Cells24 := siLangLinked1.GetTextOrDefault('strCells24');
  Cells23 := siLangLinked1.GetTextOrDefault('strCells23');
  Cells22 := siLangLinked1.GetTextOrDefault('strCells22');
  Cells21 := siLangLinked1.GetTextOrDefault('strCells21');
  Cells20 := siLangLinked1.GetTextOrDefault('strCells20');
  Cells012 := siLangLinked1.GetTextOrDefault('strCells012');
  Cells011 := siLangLinked1.GetTextOrDefault('strCells011');
  Cells010 := siLangLinked1.GetTextOrDefault('strCells010');
  Cells09 := siLangLinked1.GetTextOrDefault('strCells09');
  Cells08 := siLangLinked1.GetTextOrDefault('strCells08');
  Cells07 := siLangLinked1.GetTextOrDefault('strCells07');
  Cells06 := siLangLinked1.GetTextOrDefault('strCells06');
  Cells05 := siLangLinked1.GetTextOrDefault('strCells05');
  Cells04 := siLangLinked1.GetTextOrDefault('strCells04');
  Cells03 := siLangLinked1.GetTextOrDefault('strCells03');
  Cells02 := siLangLinked1.GetTextOrDefault('strCells02');
  Cells01 := siLangLinked1.GetTextOrDefault('strCells01');
  Cells00 := siLangLinked1.GetTextOrDefault('strCells00');

end;

constructor TFileHeaderForm.Create(AOwner:TComponent;const FileName:string);
begin
 inherited Create(AOwner);
  siLangLinked1.ActiveLanguage:=Lang;
  TmpFileName:=FileName;
  Width:=630;
  Height:=580;
  Top:= Main.Top+10;//Main.Height-Height;
  Left:= Main.Left+10;//Main.Width-Width;
  Memo.top:=HeaderGrid.Top+HeaderGrid.Height+10;
  Memo.left:=HeaderGrid.left+10;
  UpdateStrings;
//  ReadParam(FileName)
end;
procedure TFileHeaderForm.BitBtnEditClick(Sender: TObject);
begin
 HeaderGrid.Options:=[GoEditing];
end;

procedure TFileHeaderForm.FormClose(Sender: TObject;  var Action: TCloseAction);
var I:INTEGER;
begin
    for i:=0 to 7 do lHead.Comments[i]:=Memo.Lines.Strings[i];
    Action:=caFree;
    FileHeaderForm:=nil;
end;


procedure TFileHeaderForm.FormCreate(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TFileHeaderForm.FormShow(Sender: TObject);
begin
  ReadParam(TmpFileName);
  RePaint;
end;

procedure TFileHeaderForm.HeaderGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if Shift=[ssAlt, ssLeft] then
begin
 HeaderGrid.BeginDrag(false);
 Main.CopyToClipboardexecute(self);//;Header;
end;
end;

procedure TFileHeaderForm.CopyHeader;
var bitmap:Tbitmap;
    HeaderRect, DestRect:TRect;
begin
 try
  bitmap:=Tbitmap.Create;
  bitmap.Width:=HeaderGrid.Width;
  bitmap.Height:=HeaderGrid.Height;
  DestRect:= Rect(0,0,BitMap.Width,Bitmap.Height);
//  HeaderRect:=Rect(0,0,HeaderGrid.Width,HeaderGrid.Height);

 HeaderRect:=Rect(HeaderGrid.Left,HeaderGrid.Top,HeaderGrid.Left+HeaderGrid.Width,HeaderGrid.Top+HeaderGrid.Height);
 bitmap.Canvas.CopyRect(DestRect,Canvas,HeaderRect);
  ClipBoard.Assign(bitmap);
 finally
  FreeAndNil(bitmap)
 end;
end;
(*procedure TFileHeaderForm.CopyToClipboard;
var bitmap:Tbitmap;
    h:HWND;
begin
 try
   if (left< (screen.workarealeft+10))
                or ((Top+height)>(Screen.workareatop+Screen.workareaheight)) then
  SetWindowPos(handle,HWND_TOP,screen.workarealeft+40,screen.workareatop+200,Width,Height,SWP_SHOWWINDOW);
  RePaint;
  Application.Processmessages;
     { TODO : 101107 }
     Sleep(1000);
  bitmap:=Tbitmap.Create;
  bitmap.Width:=ClientWidth;
  bitmap.Height:=ClientHeight;
  with bitmap.Canvas do CopyRect(ClientRect,Canvas,ClientRect);
   ClipBoard.Assign(bitmap);
 finally
  FreeAndNil(bitmap)
 end;
end;
*)
procedure TFileHeaderForm.BitBtnOKClick(Sender: TObject);
var i:integer;
begin
for i := 0 to 7 do  lHead.Comments[i]:=Memo.Lines.Strings[i];
    SaveHeader(TmpFileName,lHead,lMainRc);
    Close;
end;

procedure TFileHeaderForm.BitBtn3Click(Sender: TObject);
begin
 Close;
end;

procedure TFileHeaderForm.Panel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if Shift=[ssAlt, ssLeft] then
   begin
     HeaderGrid.BeginDrag(false);
     Main.CopyToClipBoardExecute(self);
   end;
end;

procedure TFileHeaderForm.MemoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if Shift=[ssAlt, ssLeft] then
    begin
     HeaderGrid.BeginDrag(false);
     Main.CopyToClipBoardExecute(self);
    end;
end;

end.




