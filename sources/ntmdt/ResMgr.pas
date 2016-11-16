unit ResMgr;

{.$INCLUDE COMMON.INC}

interface

uses
  Windows, Controls, Classes, SysUtils, Math, Variants, Messages, XMLDoc, XMLIntf,
  BaseUtils, BaseClasses, IniFilesEx, XMLFiles;

//-----------------------------------------------------------------------------

const
  RESMGR_TYPESEPARATOR = '|';

//------- ResMgr file type names -------
  RESMGR_INI        = 'INI';
  RESMGR_XML        = 'XML';
  RESMGR_MEMXML     = 'MEM';
  RESMGR_RESOURCE   = 'RES';
  RESMGR_REGISTRY   = 'REG';

//------- ResMgr value type names -------
  RESKEY_STR   = 'Str';
  RESKEY_INT   = 'Int';
  RESKEY_FLOAT = 'Flo';
  RESKEY_BOOL  = 'Boo';
  RESKEY_COLOR = 'Col';

type
  TNTResMgrEvent = procedure(Sender: TObject; AFileID: Integer) of object;

  TNTResFileFabric = class;
  TNTResMgrFile = class;

//-------<c l a s s   T N T R e s M g r>---------------------------------------

  TNTResMgr = class(TComponent)
  private
//------- Event fields -------
    FOnFileOpen   : TNTResMgrEvent;
    FOnFileClose  : TNTResMgrEvent;
    FOnFileRead   : TNTResMgrEvent;
    FOnFileWrite  : TNTResMgrEvent;
    FOnFileAttach : TNTResMgrEvent;
    FOnFileDetach : TNTResMgrEvent;

  protected
//------- Work fields -------
    FFileList     : TStringList;
    FFileListLock : TMultiReadExclusiveWriteSynchronizer;
    FFileRdWrLock : TMultiReadExclusiveWriteSynchronizer;
    FFileRefsLock : TMultiReadExclusiveWriteSynchronizer;
    FFileFabric   : TNTResFileFabric;

    // Remember! The Busy flags must be used only after CriticalSection.Enter
    // or MultiReadExclusiveWriteSynchronizer.BeginWrite
    FFileOpenBusy   : Boolean;
    FFileCloseBusy  : Boolean;
    FFileReadBusy   : Boolean;
    FFileWriteBusy  : Boolean;
    FFileAttachBusy : Boolean;
    FFileDetachBusy : Boolean;

//------- Work procedures -------
    function InnerRead(AFile: TNTResMgrFile; const ASection, AKey, AType: string; ADefault: Variant): Variant;
    procedure InnerWrite(AFile: TNTResMgrFile; const ASection, AKey, AType: string; AValue: Variant);
    procedure InnerAttach(AFile: TNTResMgrFile);
    procedure InnerDetach(AFile: TNTResMgrFile);

    function CreateFile(AFileName, AFileType: string): TNTResMgrFile;
    procedure DestroyFile(AFile: TNTResMgrFile);
    procedure DeleteFile(Idx: Integer);
    procedure Clear;

    function FileByName(AFileName, AFileType: string): TNTResMgrFile;
    function FileByID(AFileID: Integer): TNTResMgrFile;
    function IDByFile(AFile: TNTResMgrFile): Integer;
    function CheckFileName(const AFileName, AFileType: string): string;

//------- Event procedures -------
    procedure DoFileOpen(AFile: TNTResMgrFile);
    procedure DoFileClose(AFile: TNTResMgrFile);
    procedure DoFileRead(AFile: TNTResMgrFile);
    procedure DoFileWrite(AFile: TNTResMgrFile);
    procedure DoFileAttach(AFile: TNTResMgrFile);
    procedure DoFileDetach(AFile: TNTResMgrFile);
    procedure VirtFileOpen(AFile: TNTResMgrFile); virtual;
    procedure VirtFileClose(AFile: TNTResMgrFile); virtual;
    procedure VirtFileRead(AFile: TNTResMgrFile); virtual;
    procedure VirtFileWrite(AFile: TNTResMgrFile); virtual;
    procedure VirtFileAttach(AFile: TNTResMgrFile); virtual;
    procedure VirtFileDetach(AFile: TNTResMgrFile); virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

//------- Interface -------
    function Open(const AFileName, AFileType: string): Integer; virtual;
    procedure Close(AFileID: Integer); virtual;
    procedure CloseByName(const AFileName, AFileType: string); virtual;
    function Read(AFileID: Integer; const ASection, AKey, AType: string; ADefault: Variant): Variant; virtual;
    procedure Write(AFileID: Integer; const ASection, AKey, AType: string; AValue: Variant); virtual;
    function SectionExists(AFileID: Integer; const ASection: string): Boolean; virtual;
    function KeyExists(AFileID: Integer; const ASection, AKey: string): Boolean; virtual;
    function FileIDByName(const AFileName, AFileType: string): Integer; virtual;
    procedure AddFileType(const ADLLName: string); virtual;
    function FileTypeExists(const AFileType: string): Boolean; virtual;

  published
//------- Events -------
    property OnFileOpen   : TNTResMgrEvent read FOnFileOpen   write FOnFileOpen;
    property OnFileClose  : TNTResMgrEvent read FOnFileClose  write FOnFileClose;
    property OnFileRead   : TNTResMgrEvent read FOnFileRead   write FOnFileRead;
    property OnFileWrite  : TNTResMgrEvent read FOnFileWrite  write FOnFileWrite;
    property OnFileAttach : TNTResMgrEvent read FOnFileAttach write FOnFileAttach;
    property OnFileDetach : TNTResMgrEvent read FOnFileDetach write FOnFileDetach;
  end;

//-------<c l a s s   T N T R e s M g r F i l e>-------------------------------

  TNTResFile = class;

  TNTResMgrFile = class
  protected
//------- Work fields -------
    FFileName : string;
    FFileType : string;
    FRefsCnt  : Integer;
    FResFile  : TNTResFile;

  public
    constructor Create(AFileName, AFileType: string; AFileFabric: TNTResFileFabric); virtual;
    destructor Destroy; override;

//------- Interface -------
    procedure Attach;
    procedure Detach;
    function Read(const ASection, AKey, AType: string; ADefault: Variant): Variant; virtual;
    procedure Write(const ASection, AKey, AType: string; AValue: Variant); virtual;
    function SectionExists(const ASection: string): Boolean; virtual;
    function KeyExists(const ASection, AKey: string): Boolean; virtual;
    function AllowClose: Boolean;

//------- Properties -------
    property FileName : string  read FFileName;
    property FileType : string  read FFileType;
    property RefsCnt  : Integer read FRefsCnt;
  end;

//-------<A b s t r a c t   C l a s s   T N T R e s F i l e>-------------------

  TNTResFile = class
  protected
//------- Work fields -------
    FFileName: string;

  public
    constructor Create(const AFileName: string); virtual;

//------- Interface -------
    function Read(const ASection, AKey, AType: string; ADefault: Variant): Variant; virtual; abstract;
    procedure Write(const ASection, AKey, AType: string; AValue: Variant); virtual; abstract;
    function SectionExists(const ASection: string): Boolean; virtual; abstract;
    function KeyExists(const ASection, AKey: string): Boolean; virtual; abstract;

//------- Properties -------
    property FileName: string read FFileName;
  end;

//-------<C l a s s   T N T R e s I n i F i l e>-------------------------------

  TNTResIniFile = class(TNTResFile)
  protected
//------- Work fields -------
    FIniFile: TIniFileEx;

  public
    constructor Create(const AFileName: string); override;
    destructor Destroy; override;

//------- Interface -------
    function Read(const ASection, AKey, AType: string; ADefault: Variant): Variant; override;
    procedure Write(const ASection, AKey, AType: string; AValue: Variant); override;
    function SectionExists(const ASection: string): Boolean; override;
    function KeyExists(const ASection, AKey: string): Boolean; override;
//    function GetDefaultExtension: string; static;
  end;

//-------<C l a s s   T N T R e s X M L F i l e>-------------------------------

  TNTResXMLFile = class(TNTResFile)
  protected
//------- Work fields -------
    FXMLFile: TXMLIniFile;

  public
    constructor Create(const AFileName: string); override;
    destructor Destroy; override;

//------- Interface -------
    function Read(const ASection, AKey, AType: string; ADefault: Variant): Variant; override;
    procedure Write(const ASection, AKey, AType: string; AValue: Variant); override;
    function SectionExists(const ASection: string): Boolean; override;
    function KeyExists(const ASection, AKey: string): Boolean; override;
//    function GetDefaultExtension: string; static;
  end;

//-------<C l a s s   T N T R e s M e m X M L F i l e>-------------------------

  TNTResMemXMLFile = class(TNTResFile)
  protected
//------- Work fields -------
    FMemXMLFile : TMemXMLIniFile;
//    FXMLDoc  : IXMLDocument;
//    FXMLRoot : IXMLNode;

  public
    constructor Create(const AFileName: string); override;
    destructor Destroy; override;

//------- Interface -------
    function Read(const ASection, AKey, AType: string; ADefault: Variant): Variant; override;
    procedure Write(const ASection, AKey, AType: string; AValue: Variant); override;
    function SectionExists(const ASection: string): Boolean; override;
    function KeyExists(const ASection, AKey: string): Boolean; override;
//    function GetDefaultExtension: string; static;
  end;

//-------<c l a s s   T N T R e s F i l e F a b r i c>-------------------------

  TNTResFileFabric = class
  protected
//------- Work fields -------
    FFileTypeList: TList;

  public
    constructor Create; virtual;
    destructor Destroy; override;

//------- Interface -------
    procedure AddFileType(const ADLLName: string); virtual;
    function FileTypeExists(const AFileType: string): Boolean; virtual;
    function CreateFile(const AFileName, AFileType: string): TNTResFile; virtual;
    function FileDefaultExtension(const AFileType: string): string; virtual;
  end;

//-------<T o o l s>-----------------------------------------------------------

var
  ResManager: TNTResMgr = nil;
  DefResFile,
  DefResType: string;

implementation

function IsEqualType(const AType1, AType2: string): Boolean; forward;

//-------<c l a s s   T N T R e s M g r>---------------------------------------

constructor TNTResMgr.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFileListLock  := TMultiReadExclusiveWriteSynchronizer.Create;
  FFileRdWrLock  := TMultiReadExclusiveWriteSynchronizer.Create;
  FFileRefsLock  := TMultiReadExclusiveWriteSynchronizer.Create;

  FFileList               := TStringList.Create;
  FFileList.CaseSensitive := False;
  FFileList.Sorted        := True;

  FFileFabric     := TNTResFileFabric.Create;

  FFileOpenBusy   := False;
  FFileCloseBusy  := False;
  FFileReadBusy   := False;
  FFileWriteBusy  := False;
  FFileAttachBusy := False;
  FFileDetachBusy := False;
end;
destructor TNTResMgr.Destroy;
begin
  if FFileFabric <> nil then FreeAndNil(FFileFabric);
  if FFileList <> nil then
  begin
    if (FFileListLock <> nil) and (FFileRdWrLock <> nil) and (FFileRefsLock <> nil) then Clear;
    FreeAndNil(FFileList);
  end;
  if FFileRefsLock <> nil then FreeAndNil(FFileRefsLock);
  if FFileRdWrLock <> nil then FreeAndNil(FFileRdWrLock);
  if FFileListLock <> nil then FreeAndNil(FFileListLock);
  inherited Destroy;
end;

//-------<W o r k   p r o c e d u r e s>---------------------------------------

function TNTResMgr.InnerRead(AFile: TNTResMgrFile; const ASection, AKey, AType: string; ADefault: Variant): Variant;
begin
  Result := Unassigned;
  if AFile <> nil then
  begin
    FFileRdWrLock.BeginWrite;
    try
      if not FFileReadBusy then
      begin
        FFileReadBusy := True;
        try
          Result := AFile.Read(ASection, AKey, AType, ADefault);
          DoFileRead(AFile);
        finally
          FFileReadBusy := False;
        end;
      end;
    finally
      FFileRdWrLock.EndWrite;
    end;
  end;
end;
procedure TNTResMgr.InnerWrite(AFile: TNTResMgrFile; const ASection, AKey, AType: string; AValue: Variant);
begin
  if AFile <> nil then
  begin
    FFileRdWrLock.BeginWrite;
    try
      if not FFileWriteBusy then
      begin
        FFileWriteBusy := True;
        try
          AFile.Write(ASection, AKey, AType, AValue);
          DoFileWrite(AFile);
        finally
          FFileWriteBusy := False;
        end;
      end;
    finally
      FFileRdWrLock.EndWrite;
    end;
  end;
end;
procedure TNTResMgr.InnerAttach(AFile: TNTResMgrFile);
begin
  if AFile <> nil then
  begin
    FFileRefsLock.BeginWrite;
    try
      AFile.Attach;
    finally
      FFileRefsLock.EndWrite;
    end;
    DoFileAttach(AFile);
  end;
end;
procedure TNTResMgr.InnerDetach(AFile: TNTResMgrFile);
begin
  if AFile <> nil then
  begin
    DoFileDetach(AFile);
    FFileRefsLock.BeginWrite;
    try
      AFile.Detach;
    finally
      FFileRefsLock.EndWrite;
    end;
  end;
end;
function TNTResMgr.CreateFile(AFileName, AFileType: string): TNTResMgrFile;
begin
  Result := nil;
  if (AFileName <> '') and FileTypeExists(AFileType)  then
  begin
    FFileListLock.BeginWrite;
    try
      if not FFileOpenBusy then
      begin
        FFileOpenBusy := True;
        try
          Result := TNTResMgrFile.Create(AFileName, AFileType, FFileFabric);
          FFileList.AddObject(ConcatNames(AFileName, AFileType, RESMGR_TYPESEPARATOR), Result);
          DoFileOpen(Result);
        finally
          FFileOpenBusy := False;
        end;
      end;
    finally
      FFileListLock.EndWrite;
    end;
  end;
end;
procedure TNTResMgr.DestroyFile(AFile: TNTResMgrFile);
var
  i: Integer;
begin
  if AFile <> nil then
  begin
    FFileListLock.BeginWrite;
    try
      i := FFileList.IndexOf(ConcatNames(AFile.FileName, AFile.FFileType, RESMGR_TYPESEPARATOR));
      if i > -1 then DeleteFile(i);
    finally
      FFileListLock.EndWrite;
    end;
  end;
end;
procedure TNTResMgr.DeleteFile(Idx: Integer);
var
  LFile: TNTResMgrFile;
begin
  FFileListLock.BeginWrite;
  try
    if not FFileCloseBusy then
    begin
      FFileCloseBusy := True;
      try
        if InRange(Idx, 0, FFileList.Count - 1) then
        begin
          LFile := TNTResMgrFile(FFileList.Objects[Idx]);
          DoFileClose(LFile);
          FreeAndNil(LFile);
          FFileList.Delete(Idx);
        end;
      finally
        FFileCloseBusy := False;
      end;
    end;
  finally
    FFileListLock.EndWrite;
  end;
end;
procedure TNTResMgr.Clear;
begin
  FFileListLock.BeginWrite;
  try
    while FFileList.Count > 0 do DeleteFile(FFileList.Count-1);
  finally
    FFileListLock.EndWrite;
  end;
end;
function TNTResMgr.FileByName(AFileName, AFileType: string): TNTResMgrFile;
var
  i: Integer;
begin
  Result := nil;
  if (AFileName <> '') and (AFileType <> '') then
  begin
    FFileListLock.BeginRead;
    try
      i := FFileList.IndexOf(ConcatNames(AFileName, AFileType, RESMGR_TYPESEPARATOR));
      if i > -1 then Result := TNTResMgrFile(FFileList.Objects[i]);
    finally
      FFileListLock.EndRead;
    end;
  end;
end;
function TNTResMgr.FileByID(AFileID: Integer): TNTResMgrFile;
begin
  Result := TNTResMgrFile(IDToObject(AFileID));
end;
function TNTResMgr.IDByFile(AFile: TNTResMgrFile): Integer;
begin
  Result := ObjectToID(AFile);
end;
function TNTResMgr.CheckFileName(const AFileName, AFileType: string): string;
begin
  Result := AFileName;
  if ExtractFileExt(AFileName) = '' then Result := Result + FFileFabric.FileDefaultExtension(AFileType);
end;

//-------<E v e n t   p r o c e d u r e s>-------------------------------------

procedure TNTResMgr.DoFileOpen(AFile: TNTResMgrFile);
begin
  VirtFileOpen(AFile);
  if Assigned(OnFileOpen) then OnFileOpen(Self, IDByFile(AFile));
end;
procedure TNTResMgr.DoFileClose(AFile: TNTResMgrFile);
begin
  VirtFileClose(AFile);
  if Assigned(OnFileClose) then OnFileClose(Self, IDByFile(AFile));
end;
procedure TNTResMgr.DoFileRead(AFile: TNTResMgrFile);
begin
  VirtFileRead(AFile);
  if Assigned(OnFileRead) then OnFileRead(Self, IDByFile(AFile));
end;
procedure TNTResMgr.DoFileWrite(AFile: TNTResMgrFile);
begin
  VirtFileWrite(AFile);
  if Assigned(OnFileWrite) then OnFileWrite(Self, IDByFile(AFile));
end;
procedure TNTResMgr.DoFileAttach(AFile: TNTResMgrFile);
begin
  VirtFileAttach(AFile);
  if Assigned(OnFileAttach) then OnFileAttach(Self, IDByFile(AFile));
end;
procedure TNTResMgr.DoFileDetach(AFile: TNTResMgrFile);
begin
  VirtFileDetach(AFile);
  if Assigned(OnFileDetach) then OnFileDetach(Self, IDByFile(AFile));
end;

procedure TNTResMgr.VirtFileOpen(AFile: TNTResMgrFile);
begin
end;
procedure TNTResMgr.VirtFileClose(AFile: TNTResMgrFile);
begin
end;
procedure TNTResMgr.VirtFileRead(AFile: TNTResMgrFile);
begin
end;
procedure TNTResMgr.VirtFileWrite(AFile: TNTResMgrFile);
begin
end;
procedure TNTResMgr.VirtFileAttach(AFile: TNTResMgrFile);
begin
end;
procedure TNTResMgr.VirtFileDetach(AFile: TNTResMgrFile);
begin
end;

//-------<I n t e r f a c e>---------------------------------------------------

function TNTResMgr.Open(const AFileName, AFileType: string): Integer;
var
  LFile: TNTResMgrFile;
  LFileName: string;
begin
  Result := NIL_ID;
  if (AFileName <> '') and (AFileType <> '') then
  begin
    FFileListLock.BeginWrite;
    try
      if not FFileAttachBusy then
      begin
        FFileAttachBusy := True;
        try
          LFileName := CheckFileName(AFileName, AFileType);
          LFile := FileByName(LFileName, AFileType);
          if LFile = nil then LFile := CreateFile(LFileName, AFileType);
          if LFile <> nil then
          begin
            InnerAttach(LFile);
            Result := IDByFile(LFile);
          end;
        finally
          FFileAttachBusy := False;
        end;
      end;
    finally
      FFileListLock.EndWrite;
    end;
  end;
end;

procedure TNTResMgr.Close(AFileID: Integer);
var
  LFile: TNTResMgrFile;
begin
  FFileListLock.BeginWrite;
  try
    if not FFileDetachBusy then
    begin
      FFileDetachBusy := True;
      try
        LFile := FileByID(AFileID);
        if LFile <> nil then
        begin
          InnerDetach(LFile);
          if LFile.AllowClose then DestroyFile(LFile);
        end;
      finally
        FFileDetachBusy := False;
      end;
    end;
  finally
    FFileListLock.EndWrite;
  end;
end;

procedure TNTResMgr.CloseByName(const AFileName, AFileType: string);
begin
  Close(FileIDByName(AFileName, AFileType));
end;

function TNTResMgr.Read(AFileID: Integer; const ASection, AKey, AType: string; ADefault: Variant): Variant;
begin
  Result := ADefault;
  FFileListLock.BeginRead;
  try
    Result := InnerRead(FileByID(AFileID), ASection, AKey, AType, ADefault);
  finally
    FFileListLock.EndRead;
  end;
end;

procedure TNTResMgr.Write(AFileID: Integer; const ASection, AKey, AType: string; AValue: Variant);
begin
  FFileListLock.BeginRead;
  try
    InnerWrite(FileByID(AFileID), ASection, AKey, AType, AValue);
  finally
    FFileListLock.EndRead;
  end;
end;

function TNTResMgr.SectionExists(AFileID: Integer; const ASection: string): Boolean;
var
  vFile: TNTResMgrFile;
begin
  vFile  := FileByID(AFileID);
  Result := (vFile <> nil);
  if Result then
  begin
    FFileRdWrLock.BeginWrite;
    try
      Result := vFile.SectionExists(ASection);
    finally
      FFileRdWrLock.EndWrite;
    end;
  end;
end;

function TNTResMgr.KeyExists(AFileID: Integer; const ASection, AKey: string): Boolean;
var
  vFile: TNTResMgrFile;
begin
  vFile  := FileByID(AFileID);
  Result := (vFile <> nil);
  if Result then
  begin
    FFileRdWrLock.BeginWrite;
    try
      Result := vFile.KeyExists(ASection, AKey);
    finally
      FFileRdWrLock.EndWrite;
    end;
  end;
end;

function TNTResMgr.FileIDByName(const AFileName, AFileType: string): Integer;
begin
  Result := NIL_ID;
  if AFileName <> '' then
  begin
    FFileListLock.BeginRead;
    try
      Result := IDByFile(FileByName(AFileName, AFileType));
    finally
      FFileListLock.EndRead;
    end;
  end;
end;

procedure TNTResMgr.AddFileType(const ADLLName: string);
begin
  FFileFabric.AddFileType(ADLLName);
end;

function TNTResMgr.FileTypeExists(const AFileType: string): Boolean;
begin
  Result := FFileFabric.FileTypeExists(AFileType);
end;

//-------<c l a s s   T N T R e s M g r F i l e>---------------------------------

constructor TNTResMgrFile.Create(AFileName, AFileType: string; AFileFabric: TNTResFileFabric);
begin
  inherited Create;
  FFileName := AFileName;
  FFileType := AFileType;
  FRefsCnt  := 0;
  if AFileFabric <> nil then FResFile := AFileFabric.CreateFile(AFileName, AFileType)
  else FResFile := nil;
end;
destructor TNTResMgrFile.Destroy;
begin
  if FResFile <> nil then FreeAndNil(FResFile);
  inherited Destroy;
end;

//-------<I n t e r f a c e>---------------------------------------------------

procedure TNTResMgrFile.Attach;
begin
  Inc(FRefsCnt);
end;

procedure TNTResMgrFile.Detach;
begin
  Dec(FRefsCnt);
  if FRefsCnt < 0 then FRefsCnt := 0;
end;

function TNTResMgrFile.Read(const ASection, AKey, AType: string; ADefault: Variant): Variant;
begin
  Result := ADefault;
  if FResFile <> nil then Result := FResFile.Read(ASection, AKey, AType, ADefault);
end;

procedure TNTResMgrFile.Write(const ASection, AKey, AType: string; AValue: Variant);
begin
  if FResFile <> nil then FResFile.Write(ASection, AKey, AType, AValue);
end;

function TNTResMgrFile.SectionExists(const ASection: string): Boolean;
begin
  Result := (FResFile <> nil);
  if Result then
    Result := FResFile.SectionExists(ASection);
end;

function TNTResMgrFile.KeyExists(const ASection, AKey: string): Boolean;
begin
  Result := (FResFile <> nil);
  if Result then
    Result := FResFile.KeyExists(ASection, AKey);
end;

function TNTResMgrFile.AllowClose: Boolean;
begin
  Result := (FRefsCnt <= 0);
end;


//-------<A b s t r a c t   C l a s s   T N T R e s F i l e>-------------------

constructor TNTResFile.Create(const AFileName: string);
begin
  inherited Create;
  FFileName := AFileName;
end;

//-------<C l a s s   T N T R e s I n i F i l e>-------------------------------

constructor TNTResIniFile.Create(const AFileName: string);
begin
  inherited Create(AFileName);
  FIniFile := TIniFileEx.Create(AFileName);
end;

destructor TNTResIniFile.Destroy;
begin
  if FIniFile <> nil then FreeAndNil(FIniFile);
  inherited Destroy;
end;

function TNTResIniFile.Read(const ASection, AKey, AType: string; ADefault: Variant): Variant;
begin
  Result := ADefault;
  if FIniFile <> nil then
  begin
    if IsEqualType(AType, RESKEY_STR) then
      Result := FIniFile.ReadString(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_INT) then
      Result := FIniFile.ReadInteger(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_FLOAT) then
      Result := FIniFile.ReadFloat(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_BOOL) then
      Result := FIniFile.ReadBool(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_COLOR) then
      Result := FIniFile.ReadColor(ASection, AKey, ADefault);
  end;
end;

procedure TNTResIniFile.Write(const ASection, AKey, AType: string; AValue: Variant);
begin
  if FIniFile <> nil then
  begin
    if IsEqualType(AType, RESKEY_STR) then
      FIniFile.WriteString(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_INT) then
      FIniFile.WriteInteger(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_FLOAT) then
      FIniFile.WriteFloat(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_BOOL) then
      FIniFile.WriteBool(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_COLOR) then
      FIniFile.WriteColor(ASection, AKey, AValue);
  end;
end;

function TNTResIniFile.SectionExists(const ASection: string): Boolean;
begin
  Result := (FIniFile <> nil);
  if Result then
    Result := FIniFile.SectionExists(ASection);
end;

function TNTResIniFile.KeyExists(const ASection, AKey: string): Boolean;
begin
  Result := (FIniFile <> nil);
  if Result then
    Result := FIniFile.ValueExists(ASection, AKey);
end;

{
function TNTResIniFile.GetDefaultExtension: string;
begin
  Result := '.ini';
end;
}

//-------<C l a s s   T N T R e s X M L F i l e>-------------------------------

constructor TNTResXMLFile.Create(const AFileName: string);
begin
  inherited Create(AFileName);
  FXMLFile := TXMLIniFile.Create(AFileName);
end;

destructor TNTResXMLFile.Destroy;
begin
  if FXMLFile <> nil then FreeAndNil(FXMLFile);
  inherited Destroy;
end;

function TNTResXMLFile.Read(const ASection, AKey, AType: string; ADefault: Variant): Variant;
begin
  Result := ADefault;
  if FXMLFile <> nil then
  begin
    if IsEqualType(AType, RESKEY_STR) then
      Result := FXMLFile.ReadString(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_INT) then
      Result := FXMLFile.ReadInteger(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_FLOAT) then
      Result := FXMLFile.ReadFloat(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_BOOL) then
      Result := FXMLFile.ReadBool(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_COLOR) then
      Result := FXMLFile.ReadColor(ASection, AKey, ADefault);
  end;
end;

procedure TNTResXMLFile.Write(const ASection, AKey, AType: string; AValue: Variant);
begin
  if FXMLFile <> nil then
  begin
    if IsEqualType(AType, RESKEY_STR) then
      FXMLFile.WriteString(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_INT) then
      FXMLFile.WriteInteger(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_FLOAT) then
      FXMLFile.WriteFloat(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_BOOL) then
      FXMLFile.WriteBool(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_COLOR) then
      FXMLFile.WriteColor(ASection, AKey, AValue);
  end;
end;

function TNTResXMLFile.SectionExists(const ASection: string): Boolean;
begin
  Result := (FXMLFile <> nil);
  if Result then
    Result := FXMLFile.SectionExists(ASection);
end;

function TNTResXMLFile.KeyExists(const ASection, AKey: string): Boolean;
begin
  Result := (FXMLFile <> nil);
  if Result then
    Result := FXMLFile.ValueExists(ASection, AKey);
end;
{
function TNTResXMLFile.GetDefaultExtension: string;
begin
  Result := '.xml';
end;
}

//-------<C l a s s   T N T R e s M e m X M L F i l e>-------------------------

constructor TNTResMemXMLFile.Create(const AFileName: string);
begin
  inherited Create(AFileName);
  FMemXMLFile := TMemXMLIniFile.Create(AFileName);
end;

destructor TNTResMemXMLFile.Destroy;
begin
  if FMemXMLFile <> nil then FreeAndNil(FMemXMLFile);
  inherited Destroy;
end;

function TNTResMemXMLFile.Read(const ASection, AKey, AType: string; ADefault: Variant): Variant;
begin
  Result := ADefault;
  if FMemXMLFile <> nil then
  begin
    if IsEqualType(AType, RESKEY_STR) then
      Result := FMemXMLFile.ReadString(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_INT) then
      Result := FMemXMLFile.ReadInteger(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_FLOAT) then
      Result := FMemXMLFile.ReadFloat(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_BOOL) then
      Result := FMemXMLFile.ReadBool(ASection, AKey, ADefault)
    else if IsEqualType(AType, RESKEY_COLOR) then
      Result := FMemXMLFile.ReadColor(ASection, AKey, ADefault);
  end;
end;

procedure TNTResMemXMLFile.Write(const ASection, AKey, AType: string; AValue: Variant);
begin
  if FMemXMLFile <> nil then
  begin
    if IsEqualType(AType, RESKEY_STR) then
      FMemXMLFile.WriteString(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_INT) then
      FMemXMLFile.WriteInteger(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_FLOAT) then
      FMemXMLFile.WriteFloat(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_BOOL) then
      FMemXMLFile.WriteBool(ASection, AKey, AValue)
    else if IsEqualType(AType, RESKEY_COLOR) then
      FMemXMLFile.WriteColor(ASection, AKey, AValue);
  end;
end;

function TNTResMemXMLFile.SectionExists(const ASection: string): Boolean;
begin
  Result := (FMemXMLFile <> nil);
  if Result then
    Result := FMemXMLFile.SectionExists(ASection);
end;

function TNTResMemXMLFile.KeyExists(const ASection, AKey: string): Boolean;
begin
  Result := (FMemXMLFile <> nil);
  if Result then
    Result := FMemXMLFile.ValueExists(ASection, AKey);
end;
{
function TNTResMemXMLFile.GetDefaultExtension: string;
begin
  Result := '';
end;
}

//-------<c l a s s   T N T R e s F i l e F a b r i c>-------------------------

constructor TNTResFileFabric.Create;
begin
  inherited Create;
  FFileTypeList := TList.Create;
end;
destructor TNTResFileFabric.Destroy;
begin
  if FFileTypeList <> nil then FreeAndNil(FFileTypeList);
  inherited Destroy;
end;
procedure TNTResFileFabric.AddFileType(const ADLLName: string);
begin
end;
function TNTResFileFabric.FileTypeExists(const AFileType: string): Boolean;
begin
  Result := IsEqualType(AFileType, RESMGR_INI) or IsEqualType(AFileType, RESMGR_XML) or
            IsEqualType(AFileType, RESMGR_MEMXML);
end;
function TNTResFileFabric.CreateFile(const AFileName, AFileType: string): TNTResFile;
begin
  Result := nil;
  if IsEqualType(AFileType, RESMGR_INI) then Result := TNTResIniFile.Create(AFileName)
  else if IsEqualType(AFileType, RESMGR_XML) then Result := TNTResXMLFile.Create(AFileName)
  else if IsEqualType(AFileType, RESMGR_MEMXML) then Result := TNTResMemXMLFile.Create(AFileName);
end;
function TNTResFileFabric.FileDefaultExtension(const AFileType: string): string;
begin
  Result := '';
  if IsEqualType(AFileType, RESMGR_INI) then Result := '.ini'{TNTResIniFile.GetDefaultExtension}
  else if IsEqualType(AFileType, RESMGR_XML) then Result := '.xml'{TNTResXMLFile.GetDefaultExtension};
end;





//-------<T o o l s>-----------------------------------------------------------

function IsEqualType(const AType1, AType2: string): Boolean;
begin
  Result := (CompareText(Copy(AType1, 1, Length(AType2)), AType2) = 0);
end;

end.
















