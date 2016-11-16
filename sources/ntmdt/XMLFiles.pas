unit XMLFiles;

interface

uses
  Windows, Classes, SysUtils, Graphics, XMLDoc, XMLIntf,
  BaseUtils, IniFilesEx;

//-----------------------------------------------------------------------------

type

//-------<c l a s s   T M e m X M L I n i F i l e>-----------------------------

  TMemXMLIniFile = class(TIniFileEx)
  protected
//------- Work fields -------
    FXMLModified  : Boolean;
//    FXMLTemporary : Boolean;
    FXMLDoc       : IXMLDocument;
    FXMLRoot      : IXMLNode;

//------- Work procedures -------
    function KeyNode(const ASection, AKey: string; ACreateNeeded: Boolean = False): IXMLNode;

//------- Virtual methods -------
    procedure VirtCreateXML; virtual;
    procedure VirtDestroyXML; virtual;

  public
    constructor Create(const AFileName: string);
    destructor Destroy; override;

//------- Interface -------
    function ReadString(const ASection, AKey, ADefault: string): string; override;
    procedure WriteString(const ASection, AKey, AValue: String); override;
    function ReadInteger(const ASection, AKey: string; ADefault: Longint): Longint; override;
    procedure WriteInteger(const ASection, AKey: string; AValue: Longint); override;
    function ReadFloat(const ASection, AKey: string; ADefault: Double): Double; override;
    procedure WriteFloat(const ASection, AKey: string; AValue: Double); override;
    function ReadBool(const ASection, AKey: string; ADefault: Boolean): Boolean; override;
    procedure WriteBool(const ASection, AKey: string; AValue: Boolean); override;
    function ReadColor(const ASection, AKey: string; ADefault: TColor): TColor; reintroduce;
    procedure WriteColor(const ASection, AKey: string; AValue: TColor); reintroduce;

    procedure ReadSection(const ASection: string; AStrings: TStrings); override;
    procedure ReadSections(AStrings: TStrings); override;
    procedure ReadSectionValues(const ASection: string; AStrings: TStrings); override;
    procedure EraseSection(const ASection: string); override;
    procedure DeleteKey(const ASection, AKey: String); override;
    procedure UpdateFile; override;
    function ValueExists(const Section, Ident: string): Boolean; override;
  end;

//-------<c l a s s   T X M L I n i F i l e>-----------------------------------

  TXMLIniFile = class(TMemXMLIniFile)
  protected
//------- Work fields -------
    FXMLTemporary : Boolean;

//------- Virtual methods -------
    procedure VirtCreateXML; override;
    procedure VirtDestroyXML; override;

  public
    constructor Create(const AFileName: string);
  end;

implementation

function SectionNodeByName(AXMLRoot: IXMLNode; const ASection: string; ACreateNeeded: Boolean = False): IXMLNode; forward;

//-------<C l a s s   T X M L I n i F i l e>-----------------------------------

constructor TMemXMLIniFile.Create(const AFileName: string);
begin
  inherited Create(AFileName);
  FXMLModified := False;
  VirtCreateXML;
  if FXMLDoc <> nil then
  begin
    FXMLDoc.Options := FXMLDoc.Options - [doNodeAutoCreate];
    if FXMLDoc.DocumentElement = nil then
      FXMLDoc.DocumentElement := FXMLDoc.CreateElement(ExtractFileNameOnly(AFileName), '');
    FXMLRoot := FXMLDoc.DocumentElement;
  end;
end;
destructor TMemXMLIniFile.Destroy;
begin
  if FXMLDoc <> nil then
  begin
    FXMLRoot := nil;
    VirtDestroyXML;
    FXMLDoc := nil;
  end;
  inherited Destroy;
end;

//-------<W o r k   p r o c e d u r e s>---------------------------------------

function TMemXMLIniFile.KeyNode(const ASection, AKey: string; ACreateNeeded: Boolean = False): IXMLNode;
begin
  Result := SectionNodeByName(FXMLRoot, ConcatNames(ASection, AKey), ACreateNeeded);
end;

//-------<V i r t u a l   m e t h o d s>---------------------------------------

procedure TMemXMLIniFile.VirtCreateXML;
begin
  FXMLDoc := NewXMLDocument('1.0');
end;
procedure TMemXMLIniFile.VirtDestroyXML;
begin
  DeleteFile(FileName);
end;

//-------<I n t e r f a c e>---------------------------------------------------

function TMemXMLIniFile.ReadString(const ASection, AKey, ADefault: string): string;
var
  LKeyNode: IXMLNode;
begin
  Result := ADefault;
  LKeyNode := KeyNode(ASection, AKey);
  if LKeyNode <> nil then Result := LKeyNode.Text;
end;
procedure TMemXMLIniFile.WriteString(const ASection, AKey, AValue: String);
var
  LKeyNode: IXMLNode;
begin
  LKeyNode := KeyNode(ASection, AKey, True);
  if LKeyNode <> nil then
  begin
    LKeyNode.Text := AValue;
    FXMLModified := True;
  end;
end;
function TMemXMLIniFile.ReadInteger(const ASection, AKey: string; ADefault: LongInt): LongInt;
var
  LKeyNode: IXMLNode;
begin
  Result := ADefault;
  LKeyNode := KeyNode(ASection, AKey);
  if LKeyNode <> nil then Result := StrToIntDef(LKeyNode.Text, ADefault);
end;
procedure TMemXMLIniFile.WriteInteger(const ASection, AKey: string; AValue: LongInt);
var
  LKeyNode: IXMLNode;
begin
  LKeyNode := KeyNode(ASection, AKey, True);
  if LKeyNode <> nil then
  begin
    LKeyNode.Text := IntToStr(AValue);
    FXMLModified := True;
  end;
end;
function TMemXMLIniFile.ReadFloat(const ASection, AKey: string; ADefault: Double): Double;
var
  LKeyNode: IXMLNode;
  LFloatText: string;
begin
  Result := ADefault;
  LKeyNode := KeyNode(ASection, AKey);
  if LKeyNode <> nil then
  begin
    LFloatText := LKeyNode.Text;
    CheckDecimalPoint(LFloatText);
    Result := StrToFloatEx(LFloatText, ADefault);
  end;
end;
procedure TMemXMLIniFile.WriteFloat(const ASection, AKey: string; AValue: Double);
var
  LKeyNode: IXMLNode;
begin
  LKeyNode := KeyNode(ASection, AKey, True);
  if LKeyNode <> nil then
  begin
    LKeyNode.Text := FloatToStr(AValue);
    FXMLModified := True;
  end;
end;
function TMemXMLIniFile.ReadBool(const ASection, AKey: string; ADefault: Boolean): Boolean;
var
  LKeyNode: IXMLNode;
begin
  Result := ADefault;
  LKeyNode := KeyNode(ASection, AKey);
  if LKeyNode <> nil then Result := (StrToIntDef(LKeyNode.Text, Integer(ADefault)) <> 0);
end;
procedure TMemXMLIniFile.WriteBool(const ASection, AKey: string; AValue: Boolean);
var
  LKeyNode: IXMLNode;
begin
  LKeyNode := KeyNode(ASection, AKey, True);
  if LKeyNode <> nil then
  begin
    LKeyNode.Text := IntToStr(Integer(AValue));
    FXMLModified := True;
  end;
end;
function TMemXMLIniFile.ReadColor(const ASection, AKey: string; ADefault: TColor): TColor;
var
  LKeyNode: IXMLNode;
begin
  Result := ADefault;
  LKeyNode := KeyNode(ASection, AKey);
  if LKeyNode <> nil then Result := StringToColor(LKeyNode.Text);
end;
procedure TMemXMLIniFile.WriteColor(const ASection, AKey: string; AValue: TColor);
var
  LKeyNode: IXMLNode;
begin
  LKeyNode := KeyNode(ASection, AKey, True);
  if LKeyNode <> nil then
  begin
    LKeyNode.Text := ColorToString(AValue);
    FXMLModified := True;
  end;
end;

procedure AddChildNames(ANode: IXMLNode; const AParentName: string; AStrings: TStrings);
var
  i: Integer;
  vNodeName: string;
begin
  if ANode <> nil then
  begin
    vNodeName := ConcatNames(AParentName, ANode.NodeName);
    if ANode.ChildNodes.Count > 0 then
    begin
      for i := 0 to ANode.ChildNodes.Count - 1 do
        AddChildNames(ANode.ChildNodes.Nodes[i], vNodeName, AStrings);
    end
    else
      AStrings.Add(vNodeName);
  end;
end;

procedure TMemXMLIniFile.ReadSection(const ASection: string; AStrings: TStrings);
var
  i: Integer;
  vKeyNode: IXMLNode;
begin
  if AStrings <> nil then
  begin
    AStrings.Clear;
    vKeyNode := KeyNode(ASection, '');
    if vKeyNode <> nil then
    begin
      for i := 0 to vKeyNode.ChildNodes.Count - 1 do
        AddChildNames(vKeyNode.ChildNodes.Nodes[i], '', AStrings);
    end;
  end;
end;

procedure TMemXMLIniFile.ReadSections(AStrings: TStrings);
begin
end;

procedure TMemXMLIniFile.ReadSectionValues(const ASection: string; AStrings: TStrings);
begin
end;

procedure TMemXMLIniFile.EraseSection(const ASection: string);
begin
end;

procedure TMemXMLIniFile.DeleteKey(const ASection, AKey: String);
begin
end;

procedure TMemXMLIniFile.UpdateFile;
begin
end;

function TMemXMLIniFile.ValueExists(const Section, Ident: string): Boolean;
var
  vKeyNode: IXMLNode;
begin
  vKeyNode := KeyNode(Section, Ident);
  Result := (vKeyNode <> nil);
end;




//-------<C l a s s   T X M L I n i F i l e>-----------------------------------

constructor TXMLIniFile.Create(const AFileName: string);
begin
  inherited Create(AFileName);
end;

//-------<V i r t u a l   m e t h o d s>---------------------------------------

procedure TXMLIniFile.VirtCreateXML;
begin
  FXMLTemporary := not FileExists(FileName);
  if FXMLTemporary then
    inherited VirtCreateXML
  else
    FXMLDoc := LoadXMLDocument(FileName);
end;
procedure TXMLIniFile.VirtDestroyXML;
begin
  if FXMLModified then FXMLDoc.SaveToFile(FileName)
  else if FXMLTemporary then inherited VirtDestroyXML;
end;





//-------<T o o l s>-----------------------------------------------------------

function SectionNodeByName(AXMLRoot: IXMLNode; const ASection: string; ACreateNeeded: Boolean = False): IXMLNode;
var
  LParent, LChild: string;
  LChildNode: IXMLNode;
begin
  Result := nil;;
  LChild := TrimName(ASection);
  if LChild <> '' then Result := AXMLRoot;
  while (Result <> nil) and (LChild <> '') do
  begin
    BackParseName(LChild, LParent, LChild);
    LChildNode := Result.ChildNodes.FindNode(LParent);
    if (LChildNode = nil) and ACreateNeeded then LChildNode := Result.AddChild(LParent);
    Result := LChildNode;
  end;
end;


end.
