unit IniFilesEx;

interface

uses
  IniFiles, SysUtils, Classes, {$IFNDEF FPC} Graphics, {$ENDIF}   
  BaseUtils;

type
//  TIniFileEx = class(TIniFile)
  TIniFileEx = class(TMemIniFile)
  private
    FDontSave: Boolean;
    FFileWasModified : Boolean;
    {$IFDEF FPC}
    FInDestroy : boolean;
    {$ENDIF}
  public
    constructor Create(const FileName: string; AReadOnly: boolean = false);
    destructor Destroy; override;  // for TMemIniFile only!
    procedure UpdateFile; override;
    function ReadFloat(const Section, Name: string; Default: Double): Double; override;
    {$IFNDEF FPC}
    function ReadColor(const Section, Name: string; Default: TColor): TColor; virtual;
    procedure WriteColor(const Section, Name: string; Value: TColor); virtual;
    {$ENDIF}
    property DontSave: Boolean read FDontSave write FDontSave;
    procedure WriteFloat(const Section, Name: string; Value: Double); override;
    procedure WriteDouble(const Section, Name: string; Value: Double); virtual;
    procedure WriteReadableDouble(const Section, Name: string; Value: Double;FilterDigits:integer=4); virtual;
    procedure WriteString(const Section: String; const Ident: String; const Value: String); override;
  end;

function GetOrdByString(NameArray: array of string; Name: string; Default: Integer): Integer;

implementation
uses
   Math;
function GetOrdByString(NameArray: array of string; Name: string; Default: Integer): Integer;
var
  i: Integer;
begin
  Result := Default;
  for i := Low(NameArray) to High(NameArray) do
    if SameText(NameArray[i], Name) then
    begin
      Result := i;
      Break;
    end;
end;

function TIniFileEx.ReadFloat(const Section, Name: string; Default: Double): Double;
begin
  Result := StrToFloatEx(ReadString(Section, Name, ''), Default);
end;

{$IFNDEF FPC}    
function TIniFileEx.ReadColor(const Section, Name: string; Default: TColor): TColor;
var
  ColorStr: string;
//  TmpInt: Integer;
begin
  ColorStr := ReadString(Section, Name, '');
  Result := Default;
  if ColorStr <> '' then
    Result := StringToColor(ColorStr);
end;

procedure TIniFileEx.WriteColor(const Section, Name: string; Value: TColor);
var
  ColorStr: string;
begin
//  ColorStr := IntToHex( Integer(Value), 8 );
  ColorStr := ColorToString(Value);
  WriteString(Section, Name, ColorStr);
end;
{$ENDIF}   
procedure TIniFileEx.WriteDouble(const Section, Name: string; Value: Double);
{$IFDEF DISABLE_INI_DOUBLE_FIX}
var
  StrValue : string;
begin
  StrValue := FloatToStrF(Value, ffGeneral, 8, 15 );
  WriteString(Section, Name, StrValue);
{$ELSE}
begin
  WriteReadableDouble(Section,Name,Value);
{$ENDIF}
end;

procedure TIniFileEx.WriteFloat(const Section, Name: string; Value: Double);
begin
  WriteDouble(Section,Name,Value);
end;

procedure TIniFileEx.WriteReadableDouble(const Section, Name: string; Value: Double;FilterDigits:integer=4);
const MaxDigits =  15 ;
      tenBase   = 10;
      readableDigits = 6;
var
  dcounter, i : integer;
  tval,stopDelta : double;
  StrValue : string;
begin
  if IsNan(Value) then StrValue := 'NaN'
  else  
	if Value=0 then StrValue := '0'
  else
  if (Abs(Value)>=power(10,readableDigits)) or
          (Abs(Value)<=power(10,-readableDigits)) then
       StrValue := FloatToStrF(Value, ffExponent, 1, MaxDigits )
  else
  begin
  // check for  0
  dcounter := MaxDigits;
  tval := value;
  stopDelta := Power(tenBase,-FilterDigits);
  for i:=0 to readableDigits do
  if abs(tval-round(tval))<stopDelta then
  begin
       Value := RoundTo(value,-i);
       dcounter :=  i;
       break;
  end
  else  tval:= tval * tenBase;

    StrValue := FloatToStrF(Value, ffGeneral, readableDigits, dcounter );
  end;
  WriteString(Section, Name, StrValue);
end;


{$IFNDEF FPC}
constructor TIniFileEx.Create(const FileName: string; AReadOnly: boolean = false);
begin
  inherited Create(FileName); 
  FDontSave := AReadOnly;
  FFileWasModified := false;
//  writeln(Filename,' open');
end;
{$ELSE}
constructor TIniFileEx.Create(const FileName: string; AReadOnly: boolean = false);
var
  lMemStream  : TMemoryStream;
  lBuf : PChar;
  lCreated : boolean;
begin
  lCreated := false;
  if FileExists(FileName) and not DirectoryExists(FileName) then
  begin
  lMemStream  := TMemoryStream.Create;
  lMemStream.LoadFromFile(FileName);
  lBuf := lMemStream.Memory;
  if (lBuf[0]=char($EF)) and (lBuf[1]=char($BB)) and (lBuf[2]=char($BF)) then
  begin
      lBuf[0] := ' ';
      lBuf[1] := ' ';
      lBuf[2] := ' ';
//          writeln(FileName);
      TIniFile(self).Create(lMemStream,false);
      Rename(FileName,false);
      lCreated := true;
      FFileWasModified := true;
  end;
  lMemStream.Free;
  end;
  if not lCreated then 
	  inherited Create(FileName);   
end;
{$ENDIF}

destructor TIniFileEx.Destroy;
begin
  if not FDontSave and FFileWasModified then
  begin
    {$IFDEF FPC}FInDestroy := true;   {$ENDIF}
    UpdateFile;         // flush changes to disk
    {$IFDEF FPC}FInDestroy := false;   {$ENDIF}	// do not update again
  end;
//  writeln(Filename,' closed');  
  inherited Destroy;
end;

{$IFNDEF FPC}
procedure TIniFileEx.UpdateFile;
var
  List: TStringList;
  Stream: TStream;
  vMode: Word;
begin
  List := TStringList.Create;
  try
    GetStrings(List);
    if FileExists(FileName) then
      vMode := fmOpenReadWrite or fmShareDenyWrite
    else
      vMode := fmCreate;
    Stream := TFileStream.Create(FileName, vMode);
    try
      Stream.Size := 0;
      List.SaveToStream(Stream);//,TEncoding.UTF8);
    finally
      Stream.Free;
    end;
  finally
    List.Free;
  end;
end;
{$ELSE}
procedure TIniFileEx.UpdateFile;
begin
    if FInDestroy then
           begin
                      inherited;
                      //writeln(Filename,' saved');
           end;
end;
{$ENDIF}

procedure TIniFileEx.WriteString(const Section: String; const Ident: String; const Value: String);
begin
  if not FFileWasModified and (ReadString(Section, Ident, Value+'!')=Value) then
    Exit;

  inherited;
  FFileWasModified := true;
end;
end.
