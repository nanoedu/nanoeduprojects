unit frViewLogFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, Buttons, siComp, siLngLnk,globaltype;

type
  TViewLogFile = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    HeaderGrid: TStringGrid;
    BitBtnSave: TBitBtn;
    siLangLinked1: TsiLangLinked;
    Panel5: TPanel;
    Memo: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure UpdateStrings;
  private
    { Private declarations }
    FlgRes:integer;
    Signal,
    Z, Level,
    GateZmax,
    GateZMin,
    Setpoint:apitype;
    report: array[0..5] of string;
    procedure MemoReport;
    procedure Analize;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent;const flg:integer);
  end;

var
  ViewLogFile: TViewLogFile;

implementation

{$R *.dfm}
uses globalvar,CSPMVar,UNanoEduBaseClasses,mMain;
const
	Cells001: string = ''; (* Parameters *)
	Cells002: string = ''; (* Value *)
	Cells011: string = ''; (* Resonant Amplitude *)
	Cells012: string = ''; (* Max IT *)
	Cells021: string = ''; (* Current Amplitude *)
	Cells022: string = ''; (* IT *)
	Cells031: string = ''; (* Probe Amplitude Level *)
	Cells032: string = ''; (* IT Level *)
	Cells04: string = ''; (* Landing Setpoint *)
	Cells042: string = ''; (* Landing setpoint *)
	Cells05: string = 'Z';
	Cells06: string = ''; (* Z Gate Max *)
	Cells07: string = ''; (* Z Gate Min *)
	Cells08: string = ''; (* Integrator delay *)
	Cells09: string = ''; (* FB Loop Gain *)
	Cells010: string = ''; (* FB gain *)

procedure TViewLogFile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  ViewLogFile:=nil;
end;

constructor TViewLogFile.Create(AOwner:TComponent;const flg:integer);
var i:integer;
begin
 inherited Create(AOwner);
  siLangLinked1.ActiveLanguage:=Lang;
  UpdateStrings;
  FlgRes:=flg;
   Memo.Clear;
  for I := 0 to 5 do  report[i]:='';
 with HeaderGrid do
  begin
    ColWidths[0]:=400;
    ColWidths[1]:=260;
    Cells[0,0]:=Cells001;
    Cells[1,0]:=Cells002;
   if not STMFlg then
   begin
    Cells[0,1]:=Cells011;
    Cells[1,1]:=inttostr(Approachparams.UAMMax);
   end
   else
   begin
    Cells[0,1]:=Cells012;
    Cells[1,1]:=floattostr(Approachparams.ScaleMaxIT);
   end;
  if not STMFlg then Cells[0,2]:=Cells021 else    Cells[0,2]:=Cells022;
//  if assigned(NanoEdu.ScannerApproach) then
  begin
  //    Signal:=NanoEdu.ScannerApproach.SignalValueApr;
      Cells[1,2]:=inttostr(Signal);
  end;
  if not STMFlg then
   begin
    Cells[0,3]:=Cells031;
    Level:=round(Approachparams.LevelUAM*Approachparams.UAMMax);
    Cells[1,3]:=inttostr(Level);
   end
   else
   begin
    Cells[0,3]:=Cells032;
    Level:=round(Approachparams.LevelIT*TransformUnit.nA_d);
    Cells[1,3]:=inttostr(Level);
   end;
   if not STMFlg then
   begin
    Cells[0,4]:=Cells04;
    SetPoint:=round(Approachparams.LandingSetpoint*Approachparams.UAMMax);
    Cells[1,4]:=inttostr(SetPoint);
   end
   else
   begin
    Cells[0,4]:=Cells042;
    SetPoint:=round(ApproachParams.LandingSetPoint*TransformUnit.nA_d);
    Cells[1,4]:=inttostr(SetPoint);
   end;
    Cells[0,5]:=Cells05;
// if assigned(NanoEdu.ScannerApproach) then  Cells[1,5]:=inttostr(NanoEdu.ScannerApproach.ZValue);
    Cells[0,6]:=Cells06;
    Cells[1,6]:=inttostr(round(Approachparams.ZGateMax*MaxApitype));
    Cells[0,7]:=Cells07;
    Cells[1,7]:=inttostr(round(Approachparams.ZGateMin*MaxApitype));
    Cells[0,8]:=Cells08;
    Cells[1,8]:=inttostr(Approachparams.IntegratorDelay);
    Cells[0,9]:=Cells09;
    Cells[1,9]:=inttostr(ApproachParams.FreqBandF);
 end;
end;

procedure TViewLogFile.Analize;
begin
  case FlgRes of
2: begin
    if  STMFlg then
    begin

    end
    else
    begin
     if (Signal<Setpoint) and (Z=0) then
     begin
      report[0]:='The resonance frequency is changed.';
      report[1]:='Find the resonance frequency again.';
      report[2]:='If a situation repeat again, check the probe.';
     end;
    end;
   end;
     end;
end;

procedure TViewLogFile.MemoReport;
var i:integer;
begin
  Analize;
  Memo.Clear;
  with Memo.Lines do
   begin
   for i:=0 to 5 do
    add(report[i]);
   end;
end;

procedure TViewLogFile.siLangLinked1ChangeLanguage(Sender: TObject);
begin

  UpdateStrings;
end;

procedure TViewLogFile.UpdateStrings;
begin
  Cells042 := siLangLinked1.GetTextOrDefault('strCells042');
  Cells010 := siLangLinked1.GetTextOrDefault('strCells010');
  Cells09 := siLangLinked1.GetTextOrDefault('strCells09');
  Cells08 := siLangLinked1.GetTextOrDefault('strCells08');
  Cells07 := siLangLinked1.GetTextOrDefault('strCells07');
  Cells06 := siLangLinked1.GetTextOrDefault('strCells06');
  Cells04 := siLangLinked1.GetTextOrDefault('strCells04');
  Cells032 := siLangLinked1.GetTextOrDefault('strCells032');
  Cells031 := siLangLinked1.GetTextOrDefault('strCells031');
  Cells022 := siLangLinked1.GetTextOrDefault('strCells022');
  Cells021 := siLangLinked1.GetTextOrDefault('strCells021');
  Cells012 := siLangLinked1.GetTextOrDefault('strCells012');
  Cells011 := siLangLinked1.GetTextOrDefault('strCells011');
  Cells002 := siLangLinked1.GetTextOrDefault('strCells002');
  Cells001 := siLangLinked1.GetTextOrDefault('strCells001');

end;

end.


