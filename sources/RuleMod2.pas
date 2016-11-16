unit RuleMod2;
{Date: 09.01.2007  }
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Math;
type
  TRuleMod2 = class(TGraphicControl)
   private
    { Private declarations }
    Count:integer;
    iMax     : integer;
    iBound1  : integer;
    iBound2  : integer;
    iValue   : integer;
    nSliding : integer;
    cursorsave:Tcursor;
    iIndicColor:TColor;
    FSetLevelsValue: TNotifyEvent;
    procedure SetValue(const Value: integer);
    property  Height;
    property  Width;
    function  IntToLim(const Value: integer): integer;
    function  GetHighLim: integer;
    function  GetLowLim: integer;
    procedure SetNumbLim(val: integer);
    function  LimToInt(const Value: integer): integer;
    procedure SetHighLim(const Value: integer);
    procedure SetLowLim(const Value: integer);
    function  IsDone: boolean;
    procedure SetMax(const Value: integer);
    procedure SetChangeLimits(Flag:Boolean);
  protected
    { Protected declarations }
    procedure DoSetLevelsValue;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X,Y : integer); override;
    procedure MouseMove(Shift : TShiftState; X,Y : integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X,Y : integer); override;
  public
    { Public declarations }
    iChangeLimits:Boolean;
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy ;
    procedure   Paint;  override;
  published
    { Published declarations }
    property ChangeLimits:Boolean read iChangeLimits  write SetChangeLimits;
    property OnSetLevelsValue: TNotifyEvent read FSetLevelsValue write FSetLevelsValue;
    property NumbLim   :integer  read count        write SetNumbLim;
    property Hit       : boolean read IsDone;
    property Maximum   : integer read iMax         write SetMax;
    property HighLimit : integer read GetHighLim   write SetHighLim;
    property LowLimit  : integer read GetLowLim    write SetLowLim;
    property Value     : integer read iValue       write SetValue;
    property IndicColor : TColor read IIndicColor  write iIndicColor;
  end;

procedure Register;

implementation

{ Registration }

procedure Register;
begin
  RegisterComponents('Alf', [TRuleMod2]);
end;

{ TRule }
destructor TRuleMod2.Destroy;
begin
  inherited;
end;

constructor TRuleMod2.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque];
  iChangeLimits:=true;
  if count=1 then iBound2:=0;
  cursorsave:=Cursor;
  IMax:=$7FFF;
end;

procedure TRuleMod2.DoSetLevelsValue;
begin
  if Assigned(FSetLevelsValue) then    FSetLevelsValue(self);
end;
procedure TRuleMod2.SetNumbLim(val: integer);
begin
  Count:=val;
end;

function TRuleMod2.GetHighLim: integer;
begin
  Result := LimToInt( iBound1);
end;
function TRuleMod2.GetLowLim: integer;
begin
  Result := LimToInt(iBound2);
end;

function TRuleMod2.IntToLim(const Value: integer): integer;
begin
  Result := Round(height*Value/iMax);
end;

function TRuleMod2.IsDone: boolean;
var
  t : integer;
begin
  t := IntToLim(Value);
  Result := (t >= Min(iBound1, iBound2)) and (t <= Max(iBound1, iBound2));
end;

function TRuleMod2.LimToInt(const Value: integer): integer;
begin
  Result := Round(iMax*Value/Height);
end;

procedure TRuleMod2.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: integer);
begin
  inherited;
//  cursorsave:=cursor;
  if iChangeLimits then begin
  if Button = mbLeft then
    if Abs(Y - (height-iBound1)) <= 3 then
      nSliding := 1
    else
    if count>1 then
     begin if Abs(Y - (height- iBound2)) <= 3 then        nSliding := 2  else  nSliding := 0;end
      else
        nSliding := 0;
  if nSliding <> 0 then
  //  Screen.
    Cursor := crHandPoint	;//crSizeNS;
  end;
end;

procedure TRuleMod2.MouseMove(Shift: TShiftState; X, Y: integer);
begin
  inherited;
  if iChangeLimits then begin
 //  Screen.
   Cursor := cursorsave;
    if Abs(Y - (height-iBound1)) <= 3  then  Cursor := crHandPoint	;
    if count>1 then
    if Abs(Y - (height- iBound2)) <= 3 then  Cursor := crHandPoint	;

  case nSliding of
    1: begin
            iBound1 :=height-y;
            if iBound1<=iBound2 then iBound1:=IBound2+1;
            if iBound1<=0 then iBound1:=1;
            if iBound1>height then iBound1:=height;

       end;// Min(Max(Y, 20), 209);
    2: begin
            iBound2 :=height-y;
            if iBound2>=IBound1 then IBound2:=IBound1-1;
            if iBound2<0 then iBound2:=1;
            if iBound2>height then iBound2:=height;
       end;// Min(Max(Y, 20), 209);
  end;
  if (nSliding<>0) then
  Repaint;
  end;
end;

procedure TRuleMod2.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: integer);
begin
  inherited;
  if iChangeLimits then begin
  if nSliding <> 0 then
    begin
      DoSetLevelsValue;
 //     Cursor   := crArrow;
      nSliding := 0;
    end;
  end;
//  Screen.
  cursor:=cursorsave;
end;

procedure TRuleMod2.Paint;
var hy,hby,h:integer;
begin
  inherited;
  with Canvas do
    begin
      Brush.Color :=$00DCDDDB;// clBtnFace;
      FillRect(Rect(0,0,width, height));
      hby:=0;
      h:=Height;
      Pen.Color:=clGreen;
      MoveTo( 0,h-iBound1);
      LineTo(width,h-iBound1);
   if count>1
   then
    begin
      MoveTo( 0,h-iBound2);
      Pen.Color:=clRed;
      LineTo(width,h-iBound2);
    end;
      Brush.Color := clWhite;
      hy:=h-IntToLim(Value);
      if  hy<0 then hy:=0;
      FillRect(Rect(18,0, 29,hy ));
      Brush.Color := IndicColor;
      FillRect(Rect(18,hy, 29,h));
    end;
end;

procedure TRuleMod2.SetHighLim(const Value: integer);
begin
 iBound1 := IntToLim(Value);
  RePaint;
end;

procedure TRuleMod2.SetLowLim(const Value: integer);
begin
  IF COUNT>1 THEN iBound2 := IntToLim(Value) ;
 RePaint;
end;

procedure TRuleMod2.SetMax(const Value: integer);
begin
  if Value <> iMax then
    begin
      iMax := Value;
      if IMax=0 then IMax:=$7FFF;
      RePaint;
    end;
end;

procedure TRuleMod2.SetValue(const Value: integer);
begin
  if Value <> iValue then
    begin
      iValue :=Value;
      Repaint;
    end;
end;

procedure TruleMod2.SetChangeLimits(flag:Boolean);
begin
   iChangeLimits:=flag;
end;

end.
