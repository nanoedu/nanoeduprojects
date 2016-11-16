
{************************************************************************************************}
{                                                                                                }
{                                        XML Data Binding                                        }
{                                                                                                }
{         Generated on: 10.03.2016 23:41:14                                                      }
{       Generated from: E:\ntspbprojects\nanoeducatorle\delphi2007\Current\SEM\user.config.xml   }
{   Settings stored in: E:\ntspbprojects\nanoeducatorle\delphi2007\Current\SEM\user.config.xdb   }
{                                                                                                }
{************************************************************************************************}

unit userconfig;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLConfigurationType = interface;
  IXMLConfigSectionsType = interface;
  IXMLSectionGroupType = interface;
  IXMLSectionType = interface;
  IXMLUserSettingsType = interface;
  IXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType = interface;
  IXMLSettingType = interface;

{ IXMLConfigurationType }

  IXMLConfigurationType = interface(IXMLNode)
    ['{1675D1D8-F787-4E7B-A039-090E021633A1}']
    { Property Accessors }
    function Get_ConfigSections: IXMLConfigSectionsType;
    function Get_UserSettings: IXMLUserSettingsType;
    { Methods & Properties }
    property ConfigSections: IXMLConfigSectionsType read Get_ConfigSections;
    property UserSettings: IXMLUserSettingsType read Get_UserSettings;
  end;

{ IXMLConfigSectionsType }

  IXMLConfigSectionsType = interface(IXMLNode)
    ['{2B772D1A-DA69-4793-BF68-72FCEDDAF4BD}']
    { Property Accessors }
    function Get_SectionGroup: IXMLSectionGroupType;
    { Methods & Properties }
    property SectionGroup: IXMLSectionGroupType read Get_SectionGroup;
  end;

{ IXMLSectionGroupType }

  IXMLSectionGroupType = interface(IXMLNode)
    ['{6E891444-20C5-45E7-A09F-D2E5DBEF9386}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Type_: WideString;
    function Get_Section: IXMLSectionType;
    procedure Set_Name(Value: WideString);
    procedure Set_Type_(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Type_: WideString read Get_Type_ write Set_Type_;
    property Section: IXMLSectionType read Get_Section;
  end;

{ IXMLSectionType }

  IXMLSectionType = interface(IXMLNode)
    ['{4AF6AC2C-6C49-42AE-AE0E-A61083BB6E96}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Type_: WideString;
    function Get_AllowExeDefinition: WideString;
    function Get_RequirePermission: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_AllowExeDefinition(Value: WideString);
    procedure Set_RequirePermission(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Type_: WideString read Get_Type_ write Set_Type_;
    property AllowExeDefinition: WideString read Get_AllowExeDefinition write Set_AllowExeDefinition;
    property RequirePermission: WideString read Get_RequirePermission write Set_RequirePermission;
  end;

{ IXMLUserSettingsType }

  IXMLUserSettingsType = interface(IXMLNode)
    ['{171E9CAF-D24C-4A4C-BDB1-056AB755FBB9}']
    { Property Accessors }
    function Get_SECNanoeyeNanoeyeSEMPropertiesSettings: IXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType;
    { Methods & Properties }
    property SECNanoeyeNanoeyeSEMPropertiesSettings: IXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType read Get_SECNanoeyeNanoeyeSEMPropertiesSettings;
  end;

{ IXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType }

  IXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType = interface(IXMLNodeCollection)
    ['{63F7BD29-05C7-4DE8-AD8D-87491001959B}']
    { Property Accessors }
    function Get_Setting(Index: Integer): IXMLSettingType;
    { Methods & Properties }
    function Add: IXMLSettingType;
    function Insert(const Index: Integer): IXMLSettingType;
    property Setting[Index: Integer]: IXMLSettingType read Get_Setting; default;
  end;

{ IXMLSettingType }

  IXMLSettingType = interface(IXMLNode)
    ['{2B9420DB-ECB5-4AD3-8860-37851C7278BE}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_SerializeAs: WideString;
    function Get_Value: variant;
    procedure Set_Name(Value: WideString);
    procedure Set_SerializeAs(Value: WideString);
    procedure Set_Value(Value: variant);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property SerializeAs: WideString read Get_SerializeAs write Set_SerializeAs;
    property Value: variant read Get_Value write Set_Value;
  end;

{ Forward Decls }

  TXMLConfigurationType = class;
  TXMLConfigSectionsType = class;
  TXMLSectionGroupType = class;
  TXMLSectionType = class;
  TXMLUserSettingsType = class;
  TXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType = class;
  TXMLSettingType = class;

{ TXMLConfigurationType }

  TXMLConfigurationType = class(TXMLNode, IXMLConfigurationType)
  protected
    { IXMLConfigurationType }
    function Get_ConfigSections: IXMLConfigSectionsType;
    function Get_UserSettings: IXMLUserSettingsType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLConfigSectionsType }

  TXMLConfigSectionsType = class(TXMLNode, IXMLConfigSectionsType)
  protected
    { IXMLConfigSectionsType }
    function Get_SectionGroup: IXMLSectionGroupType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSectionGroupType }

  TXMLSectionGroupType = class(TXMLNode, IXMLSectionGroupType)
  protected
    { IXMLSectionGroupType }
    function Get_Name: WideString;
    function Get_Type_: WideString;
    function Get_Section: IXMLSectionType;
    procedure Set_Name(Value: WideString);
    procedure Set_Type_(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSectionType }

  TXMLSectionType = class(TXMLNode, IXMLSectionType)
  protected
    { IXMLSectionType }
    function Get_Name: WideString;
    function Get_Type_: WideString;
    function Get_AllowExeDefinition: WideString;
    function Get_RequirePermission: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_AllowExeDefinition(Value: WideString);
    procedure Set_RequirePermission(Value: WideString);
  end;

{ TXMLUserSettingsType }

  TXMLUserSettingsType = class(TXMLNode, IXMLUserSettingsType)
  protected
    { IXMLUserSettingsType }
    function Get_SECNanoeyeNanoeyeSEMPropertiesSettings: IXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType }

  TXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType = class(TXMLNodeCollection, IXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType)
  protected
    { IXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType }
    function Get_Setting(Index: Integer): IXMLSettingType;
    function Add: IXMLSettingType;
    function Insert(const Index: Integer): IXMLSettingType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSettingType }

  TXMLSettingType = class(TXMLNode, IXMLSettingType)
  protected
    { IXMLSettingType }
    function Get_Name: WideString;
    function Get_SerializeAs: WideString;
    function Get_Value: variant;//Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_SerializeAs(Value: WideString);
    procedure Set_Value(Value:variant{Integer});
  end;

{ Global Functions }

function Getconfiguration(Doc: IXMLDocument): IXMLConfigurationType;
function Loadconfiguration(const FileName: WideString): IXMLConfigurationType;
function Newconfiguration: IXMLConfigurationType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Getconfiguration(Doc: IXMLDocument): IXMLConfigurationType;
begin
  Result := Doc.GetDocBinding('configuration', TXMLConfigurationType, TargetNamespace) as IXMLConfigurationType;
end;

function Loadconfiguration(const FileName: WideString): IXMLConfigurationType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('configuration', TXMLConfigurationType, TargetNamespace) as IXMLConfigurationType;
end;

function Newconfiguration: IXMLConfigurationType;
begin
  Result := NewXMLDocument.GetDocBinding('configuration', TXMLConfigurationType, TargetNamespace) as IXMLConfigurationType;
end;

{ TXMLConfigurationType }

procedure TXMLConfigurationType.AfterConstruction;
begin
  RegisterChildNode('configSections', TXMLConfigSectionsType);
  RegisterChildNode('userSettings', TXMLUserSettingsType);
  inherited;
end;

function TXMLConfigurationType.Get_ConfigSections: IXMLConfigSectionsType;
begin
  Result := ChildNodes['configSections'] as IXMLConfigSectionsType;
end;

function TXMLConfigurationType.Get_UserSettings: IXMLUserSettingsType;
begin
  Result := ChildNodes['userSettings'] as IXMLUserSettingsType;
end;

{ TXMLConfigSectionsType }

procedure TXMLConfigSectionsType.AfterConstruction;
begin
  RegisterChildNode('sectionGroup', TXMLSectionGroupType);
  inherited;
end;

function TXMLConfigSectionsType.Get_SectionGroup: IXMLSectionGroupType;
begin
  Result := ChildNodes['sectionGroup'] as IXMLSectionGroupType;
end;

{ TXMLSectionGroupType }

procedure TXMLSectionGroupType.AfterConstruction;
begin
  RegisterChildNode('section', TXMLSectionType);
  inherited;
end;

function TXMLSectionGroupType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLSectionGroupType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLSectionGroupType.Get_Type_: WideString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLSectionGroupType.Set_Type_(Value: WideString);
begin
  SetAttribute('type', Value);
end;

function TXMLSectionGroupType.Get_Section: IXMLSectionType;
begin
  Result := ChildNodes['section'] as IXMLSectionType;
end;

{ TXMLSectionType }

function TXMLSectionType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLSectionType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLSectionType.Get_Type_: WideString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLSectionType.Set_Type_(Value: WideString);
begin
  SetAttribute('type', Value);
end;

function TXMLSectionType.Get_AllowExeDefinition: WideString;
begin
  Result := AttributeNodes['allowExeDefinition'].Text;
end;

procedure TXMLSectionType.Set_AllowExeDefinition(Value: WideString);
begin
  SetAttribute('allowExeDefinition', Value);
end;

function TXMLSectionType.Get_RequirePermission: WideString;
begin
  Result := AttributeNodes['requirePermission'].Text;
end;

procedure TXMLSectionType.Set_RequirePermission(Value: WideString);
begin
  SetAttribute('requirePermission', Value);
end;

{ TXMLUserSettingsType }

procedure TXMLUserSettingsType.AfterConstruction;
begin
  RegisterChildNode('SEC.Nanoeye.NanoeyeSEM.Properties.Settings', TXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType);
  inherited;
end;

function TXMLUserSettingsType.Get_SECNanoeyeNanoeyeSEMPropertiesSettings: IXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType;
begin
  Result := ChildNodes['SEC.Nanoeye.NanoeyeSEM.Properties.Settings'] as IXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType;
end;

{ TXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType }

procedure TXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType.AfterConstruction;
begin
  RegisterChildNode('setting', TXMLSettingType);
  ItemTag := 'setting';
  ItemInterface := IXMLSettingType;
  inherited;
end;

function TXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType.Get_Setting(Index: Integer): IXMLSettingType;
begin
  Result := List[Index] as IXMLSettingType;
end;

function TXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType.Add: IXMLSettingType;
begin
  Result := AddItem(-1) as IXMLSettingType;
end;

function TXMLSECNanoeyeNanoeyeSEMPropertiesSettingsType.Insert(const Index: Integer): IXMLSettingType;
begin
  Result := AddItem(Index) as IXMLSettingType;
end;

{ TXMLSettingType }

function TXMLSettingType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLSettingType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLSettingType.Get_SerializeAs: WideString;
begin
  Result := AttributeNodes['serializeAs'].Text;
end;

procedure TXMLSettingType.Set_SerializeAs(Value: WideString);
begin
  SetAttribute('serializeAs', Value);
end;

function TXMLSettingType.Get_Value: variant;//Integer;
begin
  Result := ChildNodes['value'].NodeValue;
end;

procedure TXMLSettingType.Set_Value(Value: variant);
begin
  ChildNodes['value'].NodeValue := Value;
end;

end.