unit SpmEdit;

interface

uses
  Windows, SysUtils, Classes, StdCtrls;

type
  p_OnSendEditText = procedure;

  TSpmEdit = class(TEdit)
    constructor Create(AOwner: TComponent);
    destructor Destroy;
  public
    Value: single;
    OnSendEditText: p_OnSendEditText;
    procedure SetEditText(Const X: single);
  protected
    OldText: String;
    procedure EditChange(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  end;//TSpmEdit

implementation

procedure proc_OnSendEditText;
begin
end;//procedure proc_OnSendEditText;

{-------------------------- TSpmEdit ------------------------------------------}
constructor TSpmEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OldText:= '0';
  OnSendEditText:= proc_OnSendEditText;
  OnChange:= EditChange;
  OnKeyDown:= EditKeyDown;
end;//constructor TSpmEdit.Create(AOwner: TComponent);

destructor TSpmEdit.Destroy;
begin
  OnSendEditText:= nil;
  inherited Destroy;
end;//destructor TSpmEdit.Destroy;

procedure TSpmEdit.SetEditText(Const X: single);
begin
  if (Round(X)=X) then
    Text:= IntToStr(Round(X))
  else  
    Text:= FloatToStrF(X,fffixed,8,2);
end;//procedure TSpmEdit.SetEditText(Const X: single);

procedure TSpmEdit.EditChange(Sender: TObject);
begin
  if (Text<>'') and (Text[Length(Text)]<>' ') then
    try
      Value:= StrToFloat(Text);
      if (Round(Value)=Value) then
        OldText:= IntToStr(Round(Value))
      else //if Value is real float
        OldText:= FloatToStrF(Value,fffixed,8,2);
    except
      if (Text[Length(Text)-1]=DecimalSeparator) then
        OldText:= OldText+DecimalSeparator;
      Text:= OldText;
      SelStart:= Length(Text);
      SelText:='';
    end
  else begin //if Text=''
    Value:= 0;
  end;
end;//procedure TSpmEdit.EditChange(Sender: TObject);

procedure TSpmEdit.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Round(Key) of
    vk_Return: OnSendEditText;
  end;
end;//procedure TSpmEdit.EditKeyDown
{-------------------------- TSpmEdit ------------------------------------------}
end.
