unit RuleMod4;
{Date: 110407  }
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Math;
type
  TRuleMod4 = class(TGraphicControl)
   private
    { Private declarations }
    flgSFM:Boolean;
    bChangeLimits:Boolean;
    bflgLevelLimit:Boolean;
    Count:integer;
    iMax     : integer;
    iBound1  : integer;
    iBound2  : integer;
    iValue   : integer;
    nSliding : integer;
    cursorsave:Tcursor;
    iIndicColor:TColor;
    FSetLevelsValue: TNotifyEvent;
    FSetPointValue: TNotifyEvent;
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
    procedure SetflgLevelLimit(Flag:Boolean);
    procedure SetflgSFM(Flag:Boolean);
  protected
    { Protected declarations }
    procedure DoSetLevelsValue;
    procedure DoSetPointValue;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X,Y : integer); override;
    procedure MouseMove(Shift : TShiftState; X,Y : integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X,Y : integer); override;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy ;
    procedure   Paint;  override;
  published
    { Published declarations }
    property ChangeLimits:Boolean  read bChangeLimits   write SetChangeLimits;
    property SFM:Boolean           read flgSFM          write SetflgSFM;
    property flgLevelLimit:Boolean read bflgLevelLimit  write SetflgLevelLimit;
    property OnSetLevelsValue: TNotifyEvent    read FSetLevelsValue write FSetLevelsValue;
    property OnSetPointValue:  TNotifyEvent    read FSetPointValue  write FSetPointValue;
    property NumbLim   : integer read count           write SetNumbLim;
    property Hit       : boolean read IsDone;
    property Maximum   : integer read iMax            write SetMax;
    property HighLimit : integer read GetHighLim      write SetHighLim;
    property LowLimit  : integer read GetLowLim       write SetLowLim;
    property Value     : integer read iValue          write SetValue;
    property IndicColor : TColor read IIndicColor     write iIndicColor;
   end;

procedure Register;

implementation

{ Registration }

procedure Register;
begin
  RegisterComponents('Alf', [TRuleMod4]);
end;

{ TRule }
destructor TRuleMod4.Destroy;
begin
  inherited;
end;

constructor TRuleMod4.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque];
//  bChangeLimits:=true;
  cursorsave:=Cursor;
  IMax:=$7FFF;
end;

procedure TRuleMod4.DoSetLevelsValue;
begin
  if Assigned(FSetLevelsValue) then    FSetLevelsValue(self);
end;

procedure TRuleMod4.DoSetpointValue;
begin
  if Assigned(FSetPointValue) then    FSetPointValue(self);
end;

procedure TRuleMod4.SetNumbLim(val: integer);
begin
  Count:=val;
end;

function TRuleMod4.GetHighLim: integer;
begin
  Result := LimToInt( iBound1);
end;

function TRuleMod4.GetLowLim: integer;
begin
  Result := LimToInt(iBound2);
end;

function TRuleMod4.IntToLim(const Value: integer): integer;
begin
  Result := Round(height*Value/iMax);
end;

function TRuleMod4.IsDone: boolean;
var
  t : integer;
begin
  t := IntToLim(Value);
  Result := (t >= Min(iBound1, iBound2)) and (t <= Max(iBound1, iBound2));
end;

function TRuleMod4.LimToInt(const Value: integer): integer;
begin
  Result := Round(iMax*Value/Height);
end;

procedure TRuleMod4.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: integer);
begin
  inherited;
 if bChangeLimits then
  begin
   if Button = mbLeft then
   begin
    nSliding := 0;
    if Abs(Y - (height-iBound1)) <= 3  then  nSliding := 1;
    if NumbLim=2 then if Abs(Y - (height- iBound2)) <= 3 then  nSliding := 2;
   end;
   if nSliding <> 0 then    Cursor := crHandPoint	;
  end;
end;

procedure TRuleMod4.MouseMove(Shift: TShiftState; X, Y: integer);
begin
 inherited;
 if bChangeLimits then
  begin
    Cursor := cursorsave;
    if Abs(Y - (height-iBound1))  <= 3 then  Cursor := crHandPoint	;
    if NumbLim=2 then if Abs(Y - (height- iBound2)) <= 3 then  Cursor := crHandPoint	;

           case nSliding of
    1: begin
            iBound1 :=height-y;
            if iBound1<=0       then iBound1:=1;
            if iBound1>height   then iBound1:=height;
            case  bflgLevelLimit of
       true:begin
              case flgSFM of
             true:begin
                   if iBound1<iBound2 then  iBound1:=iBound2+4;
                  end;
            false:begin
                    if iBound1>iBound2 then  iBound1:=iBound2-4;
                  end;
                 end; //case
            end;
      false:begin
              if iBound1<=iBound2 then iBound1:=IBound2+1;
            end;
                  end;//case
       end;
    2: begin
               iBound2 :=height-y;
               if iBound2<0        then iBound2:=1;
               if iBound2>height   then iBound2:=height;
               case bflgLevelLimit of
         true:begin
                  case flgSFM of
            true: begin
                    if iBound2>iBound1 then  iBound2:=iBound1-4;
                  end;
            false:begin
                    if iBound2<iBound1 then  iBound2:=iBound1+4;
                  end;
                    end;
              end;
        false:begin
               if iBound2>=iBound1 then iBound2:=iBound1-1;
              end;
                  end;
       end;
                    end;
   if (nSliding<>0) then  Repaint;
  end;
end;

procedure TRuleMod4.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited;
  if bChangeLimits then
  begin
     case bflgLevelLimit of
    true:begin
          case  nSliding of
      1:  begin
           DoSetLevelsValue;
           nSliding := 0;
          end;
      2:  begin
           DoSetPointValue;
           nSliding := 0;
          end;
            end;
         end;
   false:begin
         if nSliding <> 0 then
          begin
           DoSetLevelsValue;
           nSliding := 0;
          end;

         end;
            end;
  end;
  cursor:=cursorsave;
end;

procedure TRuleMod4.Paint;
var hy,hby,h:integer;
begin
  inherited;
  with Canvas do
    begin
      Brush.Color :=$00DCDDDB;// clBtnFace;
      FillRect(Rect(0,0,width, height));
      hby:=0;
      h:=Height;
      Brush.Color := clWhite;
      hy:=h-IntToLim(Value);
      if  hy<0 then hy:=0;
      FillRect(Rect(18,0, 29,hy ));
      Brush.Color := IndicColor;
      FillRect(Rect(18,hy, 29,h));
      Pen.Color:=clGreen;
      MoveTo( 0,h-iBound1);
      LineTo(width,h-iBound1);
   if NumbLim=2 then
    begin
      MoveTo( 0,h-iBound2);
      Pen.Color:=clRed;
      LineTo(width,h-iBound2);
     end;
    end;
end;

procedure TRuleMod4.SetHighLim(const Value: integer);
begin
  iBound1 := IntToLim(Value);
  RePaint;
end;

procedure TRuleMod4.SetLowLim(const Value: integer);
begin
  iBound2 := IntToLim(Value) ;
  RePaint;
end;

procedure TRuleMod4.SetMax(const Value: integer);
begin
  if Value <> iMax then
    begin
      iMax := Value;
      if IMax=0 then IMax:=$7FFF;
      RePaint;
    end;
end;

procedure TRuleMod4.SetValue(const Value: integer);
begin
  if Value <> iValue then
    begin
      iValue :=Value;
      Repaint;
    end;
end;

procedure TruleMod4.SetChangeLimits(flag:Boolean);
begin
   bChangeLimits:=flag;
end;
procedure TruleMod4.SetFlgLevelLimit(flag:Boolean);
begin
   bFlgLevelLimit:=flag;
end;
procedure TruleMod4.SetFlgSFM(flag:Boolean);
begin
   flgSFM:=flag;
end;

end.




