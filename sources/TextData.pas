
{**************************************************************************************************}
{                                                                                                  }
{                                         XML Data Binding                                         }
{                                                                                                  }
{         Generated on: 10.03.2016 18:48:20                                                        }
{       Generated from: D:\ntspbprojects\NanoEducatorLE\delphi2007\Current\exe\Data\TextData.xml   }
{   Settings stored in: D:\ntspbprojects\NanoEducatorLE\delphi2007\Current\exe\Data\TextData.xdb   }
{                                                                                                  }
{**************************************************************************************************}

unit TextData;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLTextDataType = interface;
  IXMLFontsType = interface;
  IXMLFontType = interface;
  IXMLLanguagesType = interface;
  IXMLLanguageType = interface;
  IXMLItemsType = interface;
  IXMLItemType = interface;
  IXMLStringType = interface;

{ IXMLTextDataType }

  IXMLTextDataType = interface(IXMLNode)
    ['{E577C4FB-9884-4FCF-AB92-0C1382467A91}']
    { Property Accessors }
    function Get_Xmlns: WideString;
    function Get_Target: WideString;
    function Get_Version: WideString;
    function Get_Fonts: IXMLFontsType;
    function Get_Languages: IXMLLanguagesType;
    function Get_Items: IXMLItemsType;
    procedure Set_Xmlns(Value: WideString);
    procedure Set_Target(Value: WideString);
    procedure Set_Version(Value: WideString);
    { Methods & Properties }
    property Xmlns: WideString read Get_Xmlns write Set_Xmlns;
    property Target: WideString read Get_Target write Set_Target;
    property Version: WideString read Get_Version write Set_Version;
    property Fonts: IXMLFontsType read Get_Fonts;
    property Languages: IXMLLanguagesType read Get_Languages;
    property Items: IXMLItemsType read Get_Items;
  end;

{ IXMLFontsType }

  IXMLFontsType = interface(IXMLNodeCollection)
    ['{CD290BBC-3970-4D8F-A010-5112E46D2623}']
    { Property Accessors }
    function Get_Font(Index: Integer): IXMLFontType;
    { Methods & Properties }
    function Add: IXMLFontType;
    function Insert(const Index: Integer): IXMLFontType;
    property Font[Index: Integer]: IXMLFontType read Get_Font; default;
  end;

{ IXMLFontType }

  IXMLFontType = interface(IXMLNode)
    ['{10D4BF50-3284-49AE-A1CB-FF4E19F30A75}']
    { Property Accessors }
    function Get_Key: WideString;
    function Get_Font: WideString;
    function Get_Size: Integer;
    function Get_Bold: WideString;
    function Get_Italic: WideString;
    procedure Set_Key(Value: WideString);
    procedure Set_Font(Value: WideString);
    procedure Set_Size(Value: Integer);
    procedure Set_Bold(Value: WideString);
    procedure Set_Italic(Value: WideString);
    { Methods & Properties }
    property Key: WideString read Get_Key write Set_Key;
    property Font: WideString read Get_Font write Set_Font;
    property Size: Integer read Get_Size write Set_Size;
    property Bold: WideString read Get_Bold write Set_Bold;
    property Italic: WideString read Get_Italic write Set_Italic;
  end;

{ IXMLLanguagesType }

  IXMLLanguagesType = interface(IXMLNodeCollection)
    ['{35D6ECF3-3BBA-4324-B0AC-4221245EDA8D}']
    { Property Accessors }
    function Get_Language(Index: Integer): IXMLLanguageType;
    { Methods & Properties }
    function Add: IXMLLanguageType;
    function Insert(const Index: Integer): IXMLLanguageType;
    property Language[Index: Integer]: IXMLLanguageType read Get_Language; default;
  end;

{ IXMLLanguageType }

  IXMLLanguageType = interface(IXMLNode)
    ['{9F636A94-402B-45E8-9ADB-0F91D1A0D6E7}']
    { Property Accessors }
    function Get_Display: WideString;
    function Get_Code: WideString;
    procedure Set_Display(Value: WideString);
    procedure Set_Code(Value: WideString);
    { Methods & Properties }
    property Display: WideString read Get_Display write Set_Display;
    property Code: WideString read Get_Code write Set_Code;
  end;

{ IXMLItemsType }

  IXMLItemsType = interface(IXMLNodeCollection)
    ['{FB3BA5FF-0B90-4A05-9E07-0C1F54403C0C}']
    { Property Accessors }
    function Get_DefaultLanguage: WideString;
    function Get_Item(Index: Integer): IXMLItemType;
    procedure Set_DefaultLanguage(Value: WideString);
    { Methods & Properties }
    function Add: IXMLItemType;
    function Insert(const Index: Integer): IXMLItemType;
    property DefaultLanguage: WideString read Get_DefaultLanguage write Set_DefaultLanguage;
    property Item[Index: Integer]: IXMLItemType read Get_Item; default;
  end;

{ IXMLItemType }

  IXMLItemType = interface(IXMLNodeCollection)
    ['{FDD5DEB6-DC4D-422E-8F42-B6BC615883D8}']
    { Property Accessors }
    function Get_Key: WideString;
    function Get_String_(Index: Integer): IXMLStringType;
    procedure Set_Key(Value: WideString);
    { Methods & Properties }
    function Add: IXMLStringType;
    function Insert(const Index: Integer): IXMLStringType;
    property Key: WideString read Get_Key write Set_Key;
    property String_[Index: Integer]: IXMLStringType read Get_String_; default;
  end;

{ IXMLStringType }

  IXMLStringType = interface(IXMLNode)
    ['{7BEEA0D7-9246-45DD-8B95-F1D4E926C212}']
    { Property Accessors }
    function Get_Font: WideString;
    function Get_Language: WideString;
    procedure Set_Font(Value: WideString);
    procedure Set_Language(Value: WideString);
    { Methods & Properties }
    property Font: WideString read Get_Font write Set_Font;
    property Language: WideString read Get_Language write Set_Language;
  end;

{ Forward Decls }

  TXMLTextDataType = class;
  TXMLFontsType = class;
  TXMLFontType = class;
  TXMLLanguagesType = class;
  TXMLLanguageType = class;
  TXMLItemsType = class;
  TXMLItemType = class;
  TXMLStringType = class;

{ TXMLTextDataType }

  TXMLTextDataType = class(TXMLNode, IXMLTextDataType)
  protected
    { IXMLTextDataType }
    function Get_Xmlns: WideString;
    function Get_Target: WideString;
    function Get_Version: WideString;
    function Get_Fonts: IXMLFontsType;
    function Get_Languages: IXMLLanguagesType;
    function Get_Items: IXMLItemsType;
    procedure Set_Xmlns(Value: WideString);
    procedure Set_Target(Value: WideString);
    procedure Set_Version(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFontsType }

  TXMLFontsType = class(TXMLNodeCollection, IXMLFontsType)
  protected
    { IXMLFontsType }
    function Get_Font(Index: Integer): IXMLFontType;
    function Add: IXMLFontType;
    function Insert(const Index: Integer): IXMLFontType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFontType }

  TXMLFontType = class(TXMLNode, IXMLFontType)
  protected
    { IXMLFontType }
    function Get_Key: WideString;
    function Get_Font: WideString;
    function Get_Size: Integer;
    function Get_Bold: WideString;
    function Get_Italic: WideString;
    procedure Set_Key(Value: WideString);
    procedure Set_Font(Value: WideString);
    procedure Set_Size(Value: Integer);
    procedure Set_Bold(Value: WideString);
    procedure Set_Italic(Value: WideString);
  end;

{ TXMLLanguagesType }

  TXMLLanguagesType = class(TXMLNodeCollection, IXMLLanguagesType)
  protected
    { IXMLLanguagesType }
    function Get_Language(Index: Integer): IXMLLanguageType;
    function Add: IXMLLanguageType;
    function Insert(const Index: Integer): IXMLLanguageType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLanguageType }

  TXMLLanguageType = class(TXMLNode, IXMLLanguageType)
  protected
    { IXMLLanguageType }
    function Get_Display: WideString;
    function Get_Code: WideString;
    procedure Set_Display(Value: WideString);
    procedure Set_Code(Value: WideString);
  end;

{ TXMLItemsType }

  TXMLItemsType = class(TXMLNodeCollection, IXMLItemsType)
  protected
    { IXMLItemsType }
    function Get_DefaultLanguage: WideString;
    function Get_Item(Index: Integer): IXMLItemType;
    procedure Set_DefaultLanguage(Value: WideString);
    function Add: IXMLItemType;
    function Insert(const Index: Integer): IXMLItemType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLItemType }

  TXMLItemType = class(TXMLNodeCollection, IXMLItemType)
  protected
    { IXMLItemType }
    function Get_Key: WideString;
    function Get_String_(Index: Integer): IXMLStringType;
    procedure Set_Key(Value: WideString);
    function Add: IXMLStringType;
    function Insert(const Index: Integer): IXMLStringType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLStringType }

  TXMLStringType = class(TXMLNode, IXMLStringType)
  protected
    { IXMLStringType }
    function Get_Font: WideString;
    function Get_Language: WideString;
    procedure Set_Font(Value: WideString);
    procedure Set_Language(Value: WideString);
  end;

{ Global Functions }

function GettextData(Doc: IXMLDocument): IXMLTextDataType;
function LoadtextData(const FileName: WideString): IXMLTextDataType;
function NewtextData: IXMLTextDataType;

const
  TargetNamespace = 'http://www.seceng.co.kr/Nanoeye/TextSchema.xsd';

implementation

{ Global Functions }

function GettextData(Doc: IXMLDocument): IXMLTextDataType;
begin
  Result := Doc.GetDocBinding('textData', TXMLTextDataType, TargetNamespace) as IXMLTextDataType;
end;

function LoadtextData(const FileName: WideString): IXMLTextDataType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('textData', TXMLTextDataType, TargetNamespace) as IXMLTextDataType;
end;

function NewtextData: IXMLTextDataType;
begin
  Result := NewXMLDocument.GetDocBinding('textData', TXMLTextDataType, TargetNamespace) as IXMLTextDataType;
end;

{ TXMLTextDataType }

procedure TXMLTextDataType.AfterConstruction;
begin
  RegisterChildNode('fonts', TXMLFontsType);
  RegisterChildNode('languages', TXMLLanguagesType);
  RegisterChildNode('items', TXMLItemsType);
  inherited;
end;

function TXMLTextDataType.Get_Xmlns: WideString;
begin
  Result := AttributeNodes['xmlns'].Text;
end;

procedure TXMLTextDataType.Set_Xmlns(Value: WideString);
begin
  SetAttribute('xmlns', Value);
end;

function TXMLTextDataType.Get_Target: WideString;
begin
  Result := AttributeNodes['Target'].Text;
end;

procedure TXMLTextDataType.Set_Target(Value: WideString);
begin
  SetAttribute('Target', Value);
end;

function TXMLTextDataType.Get_Version: WideString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TXMLTextDataType.Set_Version(Value: WideString);
begin
  SetAttribute('Version', Value);
end;

function TXMLTextDataType.Get_Fonts: IXMLFontsType;
begin
  Result := ChildNodes['fonts'] as IXMLFontsType;
end;

function TXMLTextDataType.Get_Languages: IXMLLanguagesType;
begin
  Result := ChildNodes['languages'] as IXMLLanguagesType;
end;

function TXMLTextDataType.Get_Items: IXMLItemsType;
begin
  Result := ChildNodes['items'] as IXMLItemsType;
end;

{ TXMLFontsType }

procedure TXMLFontsType.AfterConstruction;
begin
  RegisterChildNode('font', TXMLFontType);
  ItemTag := 'font';
  ItemInterface := IXMLFontType;
  inherited;
end;

function TXMLFontsType.Get_Font(Index: Integer): IXMLFontType;
begin
  Result := List[Index] as IXMLFontType;
end;

function TXMLFontsType.Add: IXMLFontType;
begin
  Result := AddItem(-1) as IXMLFontType;
end;

function TXMLFontsType.Insert(const Index: Integer): IXMLFontType;
begin
  Result := AddItem(Index) as IXMLFontType;
end;

{ TXMLFontType }

function TXMLFontType.Get_Key: WideString;
begin
  Result := ChildNodes['key'].Text;
end;

procedure TXMLFontType.Set_Key(Value: WideString);
begin
  ChildNodes['key'].NodeValue := Value;
end;

function TXMLFontType.Get_Font: WideString;
begin
  Result := ChildNodes['font'].Text;
end;

procedure TXMLFontType.Set_Font(Value: WideString);
begin
  ChildNodes['font'].NodeValue := Value;
end;

function TXMLFontType.Get_Size: Integer;
begin
  Result := ChildNodes['size'].NodeValue;
end;

procedure TXMLFontType.Set_Size(Value: Integer);
begin
  ChildNodes['size'].NodeValue := Value;
end;

function TXMLFontType.Get_Bold: WideString;
begin
  Result := ChildNodes['bold'].Text;
end;

procedure TXMLFontType.Set_Bold(Value: WideString);
begin
  ChildNodes['bold'].NodeValue := Value;
end;

function TXMLFontType.Get_Italic: WideString;
begin
  Result := ChildNodes['italic'].Text;
end;

procedure TXMLFontType.Set_Italic(Value: WideString);
begin
  ChildNodes['italic'].NodeValue := Value;
end;

{ TXMLLanguagesType }

procedure TXMLLanguagesType.AfterConstruction;
begin
  RegisterChildNode('language', TXMLLanguageType);
  ItemTag := 'language';
  ItemInterface := IXMLLanguageType;
  inherited;
end;

function TXMLLanguagesType.Get_Language(Index: Integer): IXMLLanguageType;
begin
  Result := List[Index] as IXMLLanguageType;
end;

function TXMLLanguagesType.Add: IXMLLanguageType;
begin
  Result := AddItem(-1) as IXMLLanguageType;
end;

function TXMLLanguagesType.Insert(const Index: Integer): IXMLLanguageType;
begin
  Result := AddItem(Index) as IXMLLanguageType;
end;

{ TXMLLanguageType }

function TXMLLanguageType.Get_Display: WideString;
begin
  Result := ChildNodes['display'].Text;
end;

procedure TXMLLanguageType.Set_Display(Value: WideString);
begin
  ChildNodes['display'].NodeValue := Value;
end;

function TXMLLanguageType.Get_Code: WideString;
begin
  Result := ChildNodes['code'].Text;
end;

procedure TXMLLanguageType.Set_Code(Value: WideString);
begin
  ChildNodes['code'].NodeValue := Value;
end;

{ TXMLItemsType }

procedure TXMLItemsType.AfterConstruction;
begin
  RegisterChildNode('item', TXMLItemType);
  ItemTag := 'item';
  ItemInterface := IXMLItemType;
  inherited;
end;

function TXMLItemsType.Get_DefaultLanguage: WideString;
begin
  Result := AttributeNodes['defaultLanguage'].Text;
end;

procedure TXMLItemsType.Set_DefaultLanguage(Value: WideString);
begin
  SetAttribute('defaultLanguage', Value);
end;

function TXMLItemsType.Get_Item(Index: Integer): IXMLItemType;
begin
  Result := List[Index] as IXMLItemType;
end;

function TXMLItemsType.Add: IXMLItemType;
begin
  Result := AddItem(-1) as IXMLItemType;
end;

function TXMLItemsType.Insert(const Index: Integer): IXMLItemType;
begin
  Result := AddItem(Index) as IXMLItemType;
end;

{ TXMLItemType }

procedure TXMLItemType.AfterConstruction;
begin
  RegisterChildNode('string', TXMLStringType);
  ItemTag := 'string';
  ItemInterface := IXMLStringType;
  inherited;
end;

function TXMLItemType.Get_Key: WideString;
begin
  Result := AttributeNodes['key'].Text;
end;

procedure TXMLItemType.Set_Key(Value: WideString);
begin
  SetAttribute('key', Value);
end;

function TXMLItemType.Get_String_(Index: Integer): IXMLStringType;
begin
  Result := List[Index] as IXMLStringType;
end;

function TXMLItemType.Add: IXMLStringType;
begin
  Result := AddItem(-1) as IXMLStringType;
end;

function TXMLItemType.Insert(const Index: Integer): IXMLStringType;
begin
  Result := AddItem(Index) as IXMLStringType;
end;

{ TXMLStringType }

function TXMLStringType.Get_Font: WideString;
begin
  Result := AttributeNodes['font'].Text;
end;

procedure TXMLStringType.Set_Font(Value: WideString);
begin
  SetAttribute('font', Value);
end;

function TXMLStringType.Get_Language: WideString;
begin
  Result := AttributeNodes['language'].Text;
end;

procedure TXMLStringType.Set_Language(Value: WideString);
begin
  SetAttribute('language', Value);
end;

end.