unit RuleModv2;
{Date: 11.12.2002}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Math;
type
  TRuleMod = class(TGraphicControl)
   private
    { Private declarations }
    iMax     : integer;
    iBound1  : integer;
    iBound2  : integer;
    iValue   : integer;
    nSliding : integer;
    iChangeLimits:Boolean;
    iIndicColor:TColor;
    procedure SetValue(const Value: integer);
    property Height;
    property Width;
    function IntToLim(const Value: integer): integer;
    function GetHighLim: integer;
    function GetLowLim: integer;
    function LimToInt(const Value: integer): integer;
    procedure SetHighLim(const Value: integer);
    procedure SetLowLim(const Value: integer);
    function IsDone: boolean;
    procedure SetMax(const Value: integer);
    procedure SetChangeLimits(Flag:Boolean);
  protected
    { Protected declarations }
    procedure MouseDown(Button : TMouseButton;
                        Shift : TShiftState; X,Y : integer); override;
    procedure MouseMove(Shift : TShiftState; X,Y : integer); override;
    procedure MouseUp(Button : TMouseButton;
                        Shift : TShiftState; X,Y : integer); override;
  public
    { Public declarations }
    property ChangeLimits:Boolean read iChangeLimits
                                  write SetChangeLimits;
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy ;
    procedure Paint;  override;
  published
    { Published declarations }
    property Hit       : boolean read IsDone;
    property Maximum   : integer read iMax        write SetMax;
    property HighLimit : integer read GetHighLim  write SetHighLim;
    property LowLimit  : integer read GetLowLim   write SetLowLim;
    property Value     : integer read iValue      write SetValue;
    property IndicColor : TColor  read IIndicColor write iIndicColor;
  end;

procedure Register;

implementation

{ Registration }

procedure Register;
begin
  RegisterComponents('Alf', [TRuleMod]);
end;

{ TRule }
destructor TRuleMod.Destroy;
 begin
  inherited;
 end;
 constructor TRuleMod.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque];
  Height := 230;
  Width  := 50;
  iChangeLimits:=False;
  IMax:=$7FFF;
end;

function TRuleMod.GetHighLim: integer;
begin
  Result := LimToInt(Max(iBound1, iBound2));
end;

function TRuleMod.GetLowLim: integer;
begin
  Result := LimToInt(Min(iBound1, iBound2));
end;

function TRuleMod.IntToLim(const Value: integer): integer;
begin
  Result := Round(209-190*Value/iMax);
  if Result<19 then Result:=19;
end;

function TRuleMod.IsDone: boolean;
var
  t : integer;
begin
  t := IntToLim(Value);
  Result := (t >= Min(iBound1, iBound2)) and (t <= Max(iBound1, iBound2));
end;

function TRuleMod.LimToInt(const Value: integer): integer;
begin
  Result := Round(iMax*(209-Value)/190);
end;

procedure TRuleMod.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: integer);
begin
  inherited;
  if iChangeLimits then begin
  if Button = mbLeft then
    if Abs(Y - iBound1) <= 3 then
      nSliding := 1
    else
      if Abs(Y - iBound2) <= 3 then
        nSliding := 2
      else
        nSliding := 0;
  if nSliding <> 0 then
    Cursor := crSizeNS;
  end;
end;

procedure TRuleMod.MouseMove(Shift: TShiftState; X, Y: integer);
begin
  inherited;
  if iChangeLimits then begin
  case nSliding of
    1: iBound1 := Min(Max(Y, 20), 209);
    2: iBound2 := Min(Max(Y, 20), 209);
  end;
  if (nSliding<>0) then
  Repaint;
  end;
end;

procedure TRuleMod.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: integer);
begin
  inherited;
  if iChangeLimits then begin
  if nSliding <> 0 then
    begin
      Cursor   := crArrow;
      nSliding := 0;
    end;
  end;
end;

procedure TRuleMod.Paint;
var hy,hby:integer;
begin
  inherited;
  with Canvas do
    begin
      Brush.Color := clBtnFace;
//    TextOut(4, 0, Format('%d', [1]));
      Rectangle(17, 19, 30, 209);
      FillRect(Rect( 0, 19, 17, 209));
      FillRect(Rect(30, 19, 48, 209));
      hby:=0;
      MoveTo( 0, iBound1-hby);
      LineTo(17, iBound1-hby);
      MoveTo(30, iBound1-hby);
      LineTo(48, iBound1-hby);
      MoveTo( 0, iBound2-hby);
      LineTo(17, iBound2-hby);
      MoveTo(30, iBound2-hby);
      LineTo(48, iBound2-hby);
      Brush.Color := clWhite;//Yellow;
      hy:=IntToLim(Value);
  if  hy<20 then hy:=20;
      FillRect(Rect(18, 20, 29,hy ));
      Brush.Color := IndicColor; //clBlue;
      FillRect(Rect(18, IntToLim(Value), 29, 209));
    end;
end;

procedure TRuleMod.SetHighLim(const Value: integer);
begin
 { if iBound1 > iBound2 then
    iBound1 := IntToLim(Value)
  else
  }
  iBound2 := IntToLim(Value);
  Repaint;
end;

procedure TRuleMod.SetLowLim(const Value: integer);
begin
 { if iBound1 < iBound2 then
    iBound1 := IntToLim(Value)
  else
  }
 iBound1 := IntToLim(Value);
 Repaint;
end;

procedure TRuleMod.SetMax(const Value: integer);
begin
  if Value <> iMax then
    begin
      iMax := Value;
      if Imax=0 then Imax:=$7FFF;
      Repaint;
    end;
end;

procedure TRuleMod.SetValue(const Value: integer);
begin
  if Value <> iValue then
    begin
      iValue := Value;
      Repaint;
    end;
end;

procedure TruleMod.SetChangeLimits(flag:Boolean);
begin
   iChangeLimits:=flag;
end;

end.
