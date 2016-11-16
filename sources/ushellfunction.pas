unit uShellFunction;      //

interface
uses classes,shlobj,comobj,activex;
type
  TItemListArray = array of PItemIDList;
  
  function  GetShellItems(Folder: IShellFolder): TItemListArray;
  function  GetShellObjectName(Folder: IShellFolder; ItemList: PItemIDList): string;
  procedure EnumShellNamespace(Strings: TStrings; Depth: Integer;  Folder: IShellFolder = nil);

implementation

function GetShellItems(Folder: IShellFolder): TItemListArray;
const
  SHCONTF_ALL = SHCONTF_FOLDERS or SHCONTF_NONFOLDERS or SHCONTF_INCLUDEHIDDEN;
var
  EnumList: IEnumIDList;
  NewItem: PItemIDList;
  Dummy: Cardinal;
  I: Integer;
begin
  Result := nil;
  I := 0;
  if Folder.EnumObjects(0, SHCONTF_ALL, EnumList) = S_OK then
    while EnumList.Next(1, NewItem, Dummy) = S_OK do

    begin
      Inc(I);
      SetLength(Result, I);
      Result[I - 1] := NewItem;
    end;
end;
 (*
The GetShellFolders function above returns an array of item lists relative to a parent folder.
 The EnumObjects method retrieves an item list enumerator interface.
 With this function, you are responsible for eventually freeing all the items contained in the result.
 *)
function GetShellObjectName(Folder: IShellFolder; ItemList: PItemIDList): string;
var
  StrRet: TStrRet;
begin
  Folder.GetDisplayNameOf(ItemList, SHGDN_INFOLDER, StrRet);
  case StrRet.uType of
    STRRET_WSTR:
      begin
        Result := WideCharToString(StrRet.pOleStr);
        CoTaskMemFree(StrRet.pOleStr);
      end;
    STRRET_OFFSET: Result := PChar(Cardinal(ItemList) + StrRet.uOffset);
    STRRET_CSTR: Result := StrRet.cStr;
  end;
end;
(*
The GetShellObjectName function returns a string representation of an item list relative to a parent folder.

Putting together the information we have so far, we can write a procedure that outputs the hierarchy of the
 shell namespace to any given number of levels.
*)
procedure EnumShellNamespace(Strings: TStrings; Depth: Integer;  Folder: IShellFolder = nil);
  procedure AddObjectName(Folder: IShellFolder; ItemList: PItemIDList;
    Level: Integer);
  var

    S: string;
  begin
    SetLength(S, Level * 2);
    FillChar(PChar(S)^, Length(S), ' ');
    Strings.Add(S + GetShellObjectName(Folder, ItemList));
  end;

  procedure EnumItems(Folder: IShellFolder; Level: Integer);
  var
    Items: TItemListArray;
    ItemList: PItemIDList;
    Flags: Cardinal;
    SubFolder: IShellFolder;
    I: Integer;
  begin
    Inc(Level);
    Items := GetShellItems(Folder);
    try
      for I := 0 to Length(Items) - 1 do
      begin
        ItemList := Items[I];
        AddObjectName(Folder, ItemList, Level);
        if Level < Depth then
        begin
          Flags := SFGAO_HASSUBFOLDER;
          OleCheck(Folder.GetAttributesOf(1, ItemList, Flags));
          if Flags and SFGAO_HASSUBFOLDER = SFGAO_HASSUBFOLDER then
          begin
            OleCheck(Folder.BindToObject(ItemList, nil, IID_IShellFolder,
              SubFolder));
            EnumItems(SubFolder, Level);
          end;
        end;
      end;
    finally
      for I := 0 to Length(Items) - 1 do

     //   ILFree(Items[I]);
    end;
  end;
 
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    if Folder = nil then

    begin
      OleCheck(SHGetDesktopFolder(Folder));
      AddObjectName(Folder, nil, 0);
    end;
    if Depth > 0 then
      EnumItems(Folder, 0);
  finally

    Strings.EndUpdate;
  end;
end;
end.
