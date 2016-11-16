{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1995,2001 Inprise Corporation     }
{                                                       }
{*******************************************************}
(*SHCONTF Enumerated Type

Determines the types of items included in an enumeration. These values are used with the IShellFolder::EnumObjects method.

Syntax
enum _SHCONTF {
    SHCONTF_CHECKING_FOR_CHILDREN = 0x00010,
    SHCONTF_FOLDERS = 0x00020,
    SHCONTF_NONFOLDERS = 0x00040,
    SHCONTF_INCLUDEHIDDEN = 0x00080,
    SHCONTF_INIT_ON_FIRST_NEXT = 0x00100,
    SHCONTF_NETPRINTERSRCH = 0x00200,
    SHCONTF_SHAREABLE = 0x00400,
    SHCONTF_STORAGE = 0x00800,
    SHCONTF_NAVIGATION_ENUM = 0x01000,
    SHCONTF_FASTITEMS = 0x02000,
    SHCONTF_FLATLIST = 0x04000,
    SHCONTF_ENABLE_ASYNC = 0x08000,
    SHCONTF_INCLUDESUPERHIDDEN = 0x10000
} ;
(*typedef DWORD SHCONTF;

Constants
SHCONTF_CHECKING_FOR_CHILDREN

0x00010. Windows 7 and later. The calling application is checking for the existence of child items in the folder.
SHCONTF_FOLDERS

0x00020. Include items that are folders in the enumeration.
SHCONTF_NONFOLDERS

0x00040. Include items that are not folders in the enumeration.
SHCONTF_INCLUDEHIDDEN

0x00080. Include hidden items in the enumeration. This does not include hidden system items. (To include hidden system items, use SHCONTF_INCLUDESUPERHIDDEN.)
SHCONTF_INIT_ON_FIRST_NEXT

0x00100. No longer used; always assumed. IShellFolder::EnumObjects can return without validating the enumeration object. Validation can be postponed until the first call to IEnumIDList::Next. Use this flag when a user interface might be displayed prior to the first IEnumIDList::Next call. For a user interface to be presented, hwnd must be set to a valid window handle.
SHCONTF_NETPRINTERSRCH

0x00200. The calling application is looking for printer objects.
SHCONTF_SHAREABLE

0x00400. The calling application is looking for resources that can be shared.
SHCONTF_STORAGE

0x00800. Include items with accessible storage and their ancestors, including hidden items.
SHCONTF_NAVIGATION_ENUM

0x01000. Windows 7 and later. Child folders should provide a navigation enumeration.
SHCONTF_FASTITEMS

0x02000. Windows Vista and later. The calling application is looking for resources that can be enumerated quickly.
SHCONTF_FLATLIST

0x04000. Windows Vista and later. Enumerate items as a simple list even if the folder itself is not structured in that way.
SHCONTF_ENABLE_ASYNC

0x08000. Windows Vista and later. The calling application is monitoring for change notifications. This means that the enumerator does not have to return all results. Items can be reported through change notifications.
SHCONTF_INCLUDESUPERHIDDEN  

0x10000. Windows 7 and later. Include hidden system items in the enumeration. This value does not include hidden non-system items. (To include hidden non-system items, use SHCONTF_INCLUDEHIDDEN.)

Remarks
Note  These values were defined in Shlobj.h through Windows Millennium Edition (Windows Me) and Windows 2000. They were moved to Shobjidl.h in Windows XP and Windows Server 2003.

By setting the SHCONTF_INIT_ON_FIRST_NEXT flag, the calling application suggests that the IShellFolder::EnumObjects method can expedite the enumeration process by returning an uninitialized enumeration object. Initialization can be deferred until the enumeration process starts. If initializing the enumeration object is a lengthy process, the method implementation should immediately return an uninitialized object. Defer initialization until the first time the IEnumIDList::Next method is called. If initialization requires user input, the method implementation should use hwnd as the parent window for the user interface. For an explanation of what to do when hwnd is set to NULL, see the IShellFolder::EnumObjects reference.
Note  The name of this enumeration was changed to SHCONTF in Windows Vista. Earlier, it was named SHCONTF. The name SHCONTF is still defined through a typedef statement, however, so it can continue to be used by legacy code.

Enumerated Type InformationHeader and IDL files	shobjidl.h, shobjidl.idl
Minimum operating systems	Windows NT 4.0, Windows 95

Tags
*)
unit NTShellCtrls platform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, CommCtrl, ShlObj, ActiveX, StdCtrls, ImgList;

const SM_REFRESHNODE = WM_USER + 11000;
const
    SHCONTF_CHECKING_FOR_CHILDREN = $00010;
    SHCONTF_INCLUDEHIDDEN = $00080;
    SHCONTF_INIT_ON_FIRST_NEXT = $00100;
    SHCONTF_NETPRINTERSRCH = $00200;
    SHCONTF_SHAREABLE = $00400;
    SHCONTF_STORAGE = $00800;
    SHCONTF_NAVIGATION_ENUM = $01000;
    SHCONTF_FASTITEMS = $02000;
    SHCONTF_FLATLIST = $04000;
    SHCONTF_ENABLE_ASYNC = $08000;
    SHCONTF_INCLUDESUPERHIDDEN = $10000;
type
  TNodeMessage = record
    Msg: Cardinal;
    Node: TTreeNode;
    rsrv1, rsrv2: Longint;
  end;

  TRoot = type string;

  TRootFolder = (rfDesktop, rfMyComputer, rfNetwork, rfRecycleBin, rfAppData,
    rfCommonDesktopDirectory, rfCommonPrograms, rfCommonStartMenu, rfCommonStartup,
    rfControlPanel, rfDesktopDirectory, rfFavorites, rfFonts, rfInternet, rfPersonal,
    rfPrinters, rfPrintHood, rfPrograms, rfRecent, rfSendTo, rfStartMenu, rfStartup,
    rfTemplates);

  TShellFolderCapability = (fcCanCopy, fcCanDelete, fcCanLink, fcCanMove, fcCanRename,
                   fcDropTarget, fcHasPropSheet);
  TShellFolderCapabilities = set of TShellFolderCapability;

  TShellFolderProperty = (fpCut, fpIsLink, fpReadOnly, fpShared, fpFileSystem,
                     fpFileSystemAncestor, fpRemovable, fpValidate);
  TShellFolderProperties = set of TShellFolderProperty;

  TShellObjectType = (otFolders, otNonFolders, otHidden,otINIT_ON_FIRST_NEXT,otNETPRINTERSRCH ,otSHAREABLE,otStorage,otNAVIGATION_ENUM,otFASTITEMS,otFLATLIST,otENABLE_ASYNC,otINCLUDESUPERHIDDEN);

  TShellObjectTypes = set of TShellObjectType;

  EInvalidPath = class(Exception);

  IShellCommandVerb = interface
    ['{7D2A7245-2376-4D33-8008-A130935A2E8B}']
    procedure ExecuteCommand(Verb: string; var Handled: boolean);
    procedure CommandCompleted(Verb: string; Succeeded: boolean);
  end;

  TShellFolder = class
  private
    FPIDL,
    FFullPIDL: PItemIDList;
    FParent: TShellFolder;
    FIShellFolder: IShellFolder;
    FIShellFolder2: IShellFolder2;
    FIShellDetails: IShellDetails;
    FDetailInterface: IInterface;
    FLevel: Integer;
    FViewHandle: THandle;
    FDetails: TStrings;
    function GetDetailInterface: IInterface;
    function GetShellDetails: IShellDetails;
    function GetShellFolder2: IShellFolder2;
    function GetDetails(Index: integer): string;
    procedure SetDetails(Index: integer; const Value: string);
    procedure LoadColumnDetails(RootFolder: TShellFolder; Handle: THandle; ColumnCount: integer);
    function GetIShellFolder: IShellFolder;
  public
    constructor Create(AParent: TShellFolder; ID: PItemIDList;SF: IShellFolder); virtual;
    destructor Destroy; override;
    function Capabilities: TShellFolderCapabilities;
    function DisplayName: string;
    function ExecuteDefault: Integer;
    function ImageIndex(LargeIcon: Boolean): Integer;
    function IsFolder: Boolean;
    function ParentShellFolder: IShellFolder;
    function PathName: string;
    function Properties: TShellFolderProperties;
    function Rename(const NewName: WideString): boolean;
    function SubFolders: Boolean;
    property AbsoluteID: PItemIDLIst read FFullPIDL;
    property Details[Index: integer] : string read GetDetails write SetDetails;
    property Level: Integer read FLevel;
    property Parent: TShellFolder read FParent;
    property RelativeID: PItemIDList read FPIDL;
    property ShellFolder: IShellFolder read GetIShellFolder;
    property ShellFolder2: IShellFolder2 read GetShellFolder2;
    property ShellDetails: IShellDetails read GetShellDetails;
    property ViewHandle: THandle read FViewHandle write FViewHandle;
  end;

  TNotifyFilter = (nfFileNameChange, nfDirNameChange, nfAttributeChange,
    nfSizeChange, nfWriteChange, nfSecurityChange);
  TNotifyFilters = set of TNotifyFilter;

  TShellChangeThread = class(TThread)
  private
    FMutex,
    FWaitHandle: Integer;
    FChangeEvent: TThreadMethod;
    FDirectory: string;
    FWatchSubTree: Boolean;
    FWaitChanged : Boolean;
    FNotifyOptionFlags: DWORD;
  protected
    procedure Execute; override;
  public
    constructor Create(ChangeEvent: TThreadMethod); virtual;
    destructor Destroy; override;
    procedure SetDirectoryOptions( Directory : String; WatchSubTree : Boolean;
      NotifyOptionFlags : DWORD);
    property ChangeEvent : TThreadMethod read FChangeEvent write FChangeEvent;
  end;

  TNTCustomShellChangeNotifier = class(TComponent)
  private
    FFilters: TNotifyFilters;
    FWatchSubTree: Boolean;
    FRoot : TRoot;
    FThread: TShellChangeThread;
    FOnChange: TThreadMethod;
    procedure SetRoot(const Value: TRoot);
    procedure SetWatchSubTree(const Value: Boolean);
    procedure SetFilters(const Value: TNotifyFilters);
    procedure SetOnChange(const Value: TThreadMethod);
  protected
    procedure Change;
    procedure Start;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property NotifyFilters: TNotifyFilters read FFilters write SetFilters;
    property Root: TRoot read FRoot write SetRoot;
    property WatchSubTree: Boolean read FWatchSubTree write SetWatchSubTree;
    property OnChange: TThreadMethod read FOnChange write SetOnChange;
  end;

  TNTShellChangeNotifier = class(TNTCustomShellChangeNotifier)
  published
    property NotifyFilters;
    property Root;
    property WatchSubTree;
    property OnChange;
  end;

  TNTCustomShellComboBox = class;
  TNTCustomShellListView = class;

  TAddFolderEvent = procedure(Sender: TObject; AFolder: TShellFolder;
    var CanAdd: Boolean) of object;
  TGetImageIndexEvent = procedure(Sender: TObject; Index: Integer;
     var ImageIndex: Integer) of object;

{ TCustomShellTreeView }

  TNTCustomShellTreeView = class(TCustomTreeView, IShellCommandVerb)
  private
    FRoot,
    FOldRoot : TRoot;
    FRootFolder: TShellFolder;
    FObjectTypes: TShellObjectTypes;
    FImages: Integer;
    FLoadingRoot,
    FAutoContext,
    FUpdating: Boolean;
    FComboBox: TNTCustomShellComboBox;
    FListView: TNTCustomShellListView;
    FAutoRefresh,
    FImageListChanging,
    FUseShellImages: Boolean;
    FNotifier: TNTShellChangeNotifier;
    FOnAddFolder: TAddFolderEvent;
    FSavePath: string;
    FNodeToMonitor: TTreeNode;
// Extension
    FFileMask: string;
    FLastPath: string;
    FNextNode: TTreeNode;
    FDragFolder: TShellFolder;
    FDisableChanging: boolean;
    FOnDeleteFile: TTVExpandedEvent;
    FOnCanDeleteFile: TTVExpandingEvent;
    FOnRenameFile: TTVExpandedEvent;

    function  FolderExists(FindID: PItemIDList; InNode: TTreeNode): TTreeNode;
    function  GetFolder(Index: Integer): TShellFolder;
    function  GetPath: string;
    procedure SetComboBox(Value: TNTCustomShellComboBox);
    procedure SetListView(const Value: TNTCustomShellListView);
    procedure SetPath(const Value: string);
    procedure SetPathFromID(ID: PItemIDList);
    procedure SetRoot(const Value: TRoot);
    procedure SetUseShellImages(const Value: Boolean);
    procedure SetAutoRefresh(const Value: boolean);
// Extension
    procedure SetFileMask(const Value: string);
    procedure WM_DropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure SM_RefreshNode(var Msg: TNodeMessage); message SM_REFRESHNODE;
    procedure CutOff;
  protected
    function  CanChange(Node: TTreeNode): Boolean; override;
    function  CanExpand(Node: TTreeNode): Boolean; override;
    procedure CreateRoot;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    procedure Edit(const Item: TTVItem); override;
    procedure GetImageIndex(Node: TTreeNode); override;
    procedure GetSelectedIndex(Node: TTreeNode); override;
    function  InitNode(NewNode: TTreeNode; ID: PItemIDList; ParentNode: TTreeNode): boolean;
    procedure Loaded; override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Delete(Node: TTreeNode); override;
    //! procedure NodeDeleted(Sender: TObject; Node: TTreeNode);
    function  NodeFromAbsoluteID(StartNode: TTreeNode; ID: PItemIDList): TTreeNode;
    function  NodeFromRelativeID(ParentNode: TTreeNode; ID: PItemIDList): TTreeNode;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PopulateNode(Node: TTreeNode);
    procedure RootChanged;
    procedure SetObjectTypes(Value: TShellObjectTypes); virtual;
    procedure WMDestroy(var Message: TWMDestroy); virtual;
    procedure WndProc(var Message: TMessage); override;
    procedure ClearItems;
    procedure RefreshEvent;
    // Extension
    procedure PostRefresh(Node: TTreeNode);
    function  NodeByFolder(Folder: TShellFolder): TTreeNode; //
    procedure DoDeleteFile(Node: TTreeNode); virtual;
    procedure DoCanDeleteFile(Node: TTreeNode; var CanDelete: boolean); virtual;
    procedure DoRenameFile(Node: TTreeNode); virtual;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure DoEndDrag(Target:TObject; X, Y: Integer); override;
    procedure CommandCompleted(Verb: String; Succeeded: Boolean);
    procedure ExecuteCommand(Verb: String; var Handled: Boolean); overload;
  public
  constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
    procedure MyRefreshListView;      //////my
     function Refresh(Node: TTreeNode): TTreeNode;
     function SelectedFolder: TShellFolder;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
     property AutoRefresh: boolean read FAutoRefresh write SetAutoRefresh;
     property Folders[Index: Integer]: TShellFolder read GetFolder; default;
     property Items;
     property Path: string read GetPath write SetPath;
     property AutoContextMenus: Boolean read FAutoContext write FAutoContext default True;
     property ObjectTypes: TShellObjectTypes read FObjectTypes write SetObjectTypes;
     property Root: TRoot read FRoot write SetRoot;
     property ShellComboBox: TNTCustomShellComboBox read FComboBox write SetComboBox;
     property ShellListView: TNTCustomShellListView read FListView write SetListView;
     property UseShellImages: Boolean read FUseShellImages write SetUseShellImages;
     property OnAddFolder: TAddFolderEvent read FOnAddFolder write FOnAddFolder;

// Extension
    procedure Reset;
    procedure NewFolder(FolderName: string = ''; EditName: boolean = True; ParentNode: TTreeNode = nil);
    procedure ExecuteCommand(Verb: string); overload;
    procedure RenameFileItem;
    property FileMask: string read FFileMask write SetFileMask;
    property ShowRoot default False;
    property OnDeleteFile: TTVExpandedEvent read FOnDeleteFile write FOnDeleteFile;
    property OnCanDeleteFile: TTVExpandingEvent read FOnCanDeleteFile write FOnCanDeleteFile;
    property OnRenameFile: TTVExpandedEvent read FOnRenameFile write FOnRenameFile;
  end;

{ TShellTreeView }

  TNTShellTreeView = class(TNTCustomShellTreeView)
  published
    property AutoContextMenus;
    property ObjectTypes;
    property Root;
    property ShellComboBox;
    property ShellListView;
    property UseShellImages;
    property OnAddFolder;
    property Align;
    property Anchors;
    property AutoRefresh;
    property BorderStyle;
    property ChangeDelay;
    property Color;
    property Ctl3D;
    property Cursor;
    property DragCursor;
//    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property Images;
    property Indent;
    property MultiSelect;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RightClickSelect;
    property ShowButtons;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnChanging;
    property OnChange;
    property OnDeletion;
    property OnExpanding;
    property OnCollapsing;
    property OnCollapsed;
    property OnExpanded;
    property OnEditing;
    property OnEdited;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
// Extension
    property FileMask;
    property OnDeleteFile;
    property OnCanDeleteFile;
    property OnRenameFile;
  end;

{ TNTCustomShellComboBox }

  TNTCustomShellComboBox = class(TCustomComboBoxEx)
  private
    FImages,
    FImageHeight,
    FImageWidth: Integer;
    FImageList: TCustomImageList;
    FOldRoot : TRoot;
    FRoot: TRoot;
    FRootFolder: TShellFolder;
    FTreeView: TNTCustomShellTreeView;
    FListView: TNTCustomShellListView;
    FObjectTypes: TShellObjectTypes;
    FUseShellImages,
    FUpdating: Boolean;
    FOnGetImageIndex: TGetImageIndexEvent;
    procedure ClearItems;
    function  GetFolder(Index: Integer): TShellFolder;
    function  GetPath: string;
    procedure SetPath(const Value: string);
    procedure SetPathFromID(ID: PItemIDList);
    procedure SetRoot(const Value: TRoot);
    procedure SetTreeView(Value: TNTCustomShellTreeView);
    procedure SetListView(Value: TNTCustomShellListView);
    procedure SetUseShellImages(const Value: Boolean);
    function GetShellImageIndex(AFolder: TShellFolder): integer;
  protected
    procedure AddItems(Index: Integer; ParentFolder: TShellFolder);
    procedure Change; override;
    procedure Click; override;
    procedure CreateRoot;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    function IndexFromID(AbsoluteID: PItemIDList): Integer;
    procedure Init; virtual;
    function  InitItem(ParentFolder: TShellFolder; ID: PItemIDList): TShellFolder;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RootChanged;
    procedure TreeUpdate(NewPath: PItemIDList);
    procedure SetObjectTypes(Value: TShellObjectTypes); virtual;
    //!procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Items;
    property Path: string read GetPath write SetPath;
    property Folders[Index: Integer]: TShellFolder read GetFolder;
    property Root: TRoot read FRoot write SetRoot;
    property ObjectTypes: TShellObjectTypes read FObjectTypes write SetObjectTypes;
    property ShellTreeView: TNTCustomShellTreeView read FTreeView write SetTreeView;
    property ShellListView: TNTCustomShellListView read FListView write SetListView;
    property UseShellImages: Boolean read FUseShellImages write SetUseShellImages;
    property OnGetImageIndex: TGetImageIndexEvent read FOnGetImageIndex write FOnGetImageIndex;
  end;

{ TShellComboBox }

  TNTShellComboBox = class(TNTCustomShellComboBox)
  published
    property Images;
    property Root;
    property ShellTreeView;
    property ShellListView;
    property UseShellImages;
    property OnGetImageIndex;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TNTCustomShellListView }

  TNTCustomShellListView = class(TCustomListView, IShellCommandVerb)
  private
    FOldRoot: TRoot;
    FRoot: TRoot;
    FRootFolder: TShellFolder;
    FAutoContext,
    FAutoRefresh,
    FAutoNavigate,
    FSorted,
    FUpdating: Boolean;
    FObjectTypes: TShellObjectTypes;
    FLargeImages,
    FSmallImages: Integer;
    FOnAddFolder: TAddFolderEvent;
    FFolders: TList;
    FTreeView: TNTCustomShellTreeView;
    FComboBox: TNTCustomShellComboBox;
    FNotifier: TNTShellChangeNotifier;
    FOnEditing: TLVEditingEvent;
    FSettingRoot: boolean;
    FSavePath: string;
    // Extension
    FFileMasks: TStrings;
    FExecutableFiles: Boolean;

    procedure EnumColumns;
    function  GetFolder(Index: Integer): TShellFolder;
    procedure SetAutoRefresh(const Value: Boolean);
    procedure SetSorted(const Value: Boolean);
    procedure SetTreeView(Value: TNTCustomShellTreeView);
    procedure SetComboBox(Value: TNTCustomShellComboBox);
    procedure TreeUpdate(NewRoot: PItemIDList);
    procedure SetPathFromID(ID: PItemIDList);
    procedure SynchPaths;
    // Extension
    procedure SetFileMasks(const Value: TStrings);

  protected
    procedure ClearItems;
    procedure CreateRoot;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DblClick; override;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    procedure EditText;
    procedure Edit(const Item: TLVItem); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function  OwnerDataFetch(Item: TListItem; Request: TItemRequest): Boolean; override;
    function  OwnerDataFind(Find: TItemFind; const FindString: string;
                const FindPosition: TPoint; FindData: Pointer; StartIndex: Integer;
                Direction: TSearchDirection; Wrap: Boolean): Integer; override;
    procedure Populate; virtual;
    procedure RootChanged;
    procedure SetObjectTypes(Value: TShellObjectTypes);
    procedure SetRoot(const Value: TRoot);
    procedure SetViewStyle(Value: TViewStyle); override;
    procedure WndProc(var Message: TMessage); override;
  public
  constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
    procedure Back;
    procedure Refresh;
    function  SelectedFolder: TShellFolder;
    property  Folders[Index: Integer]: TShellFolder read GetFolder;
    property  RootFolder: TShellFolder read FRootFolder;
    property  Items;
    property  Columns;
    property  AutoContextMenus: Boolean read FAutoContext write FAutoContext default True;
    property  AutoRefresh: Boolean read FAutoRefresh write SetAutoRefresh default False;
    property  AutoNavigate: Boolean read FAutoNavigate write FAutoNavigate default True;
    property  ObjectTypes: TShellObjectTypes read FObjectTypes write SetObjectTypes;
    property  Root: TRoot read FRoot write SetRoot;
    property  ShellTreeView: TNTCustomShellTreeView read FTreeView write SetTreeView;
    property  ShellComboBox: TNTCustomShellComboBox read FComboBox write SetComboBox;
    property  Sorted: Boolean read FSorted write SetSorted;
    property  OnAddFolder: TAddFolderEvent read FOnAddFolder write FOnAddFolder;
    property  OnEditing: TLVEditingEvent read FOnEditing write FOnEditing;
    procedure CommandCompleted(Verb: String; Succeeded: Boolean);
    procedure ExecuteCommand(Verb: String; var Handled: Boolean);
    // Extension
//    property FileMask: TStrings read FFileMask write SetFileMask;
    property  FileMasks: TStrings read FFileMasks write SetFileMasks;
    property  ExecutableFiles: Boolean read FExecutableFiles write FExecutableFiles;
  end;

{ TShellListView }

  TNTShellListView = class(TNTCustomShellListView)
  published
    property AutoContextMenus;
    property AutoRefresh;
    property AutoNavigate;
    property ObjectTypes;
    property Root;
    property ShellTreeView;
    property ShellComboBox;
    property Sorted;
    property OnAddFolder;
    property Align;
    property Anchors;
    property BorderStyle;
    property Color;
    property ColumnClick;
    property OnClick;
    property OnDblClick ;
    property Ctl3D;
    property DragMode;
    property ReadOnly default True;
    property Enabled;
    property Font;
    property GridLines;
    property HideSelection;
    property HotTrack;
    property IconOptions;
    property AllocBy;
    property MultiSelect;
    property RowSelect;
    property OnChange;
    property OnChanging;
    property OnColumnClick;
    property OnContextPopup;
    property OnEnter;
    property OnExit;
    property OnInsert;
    property OnDragDrop;
    property OnDragOver;
    property DragCursor;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property ViewStyle;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnEditing;
    // Extension
    property FileMasks;
    property ExecutableFiles;
  end;
procedure Register;

procedure InvokeContextMenu(Owner: TWinControl; AFolder: TShellFolder; X, Y: Integer);

implementation

uses
  NTShellConsts, ShellAPI, ComObj, TypInfo, Menus, Consts, Math, Masks;

const
  nFolder: array[TRootFolder] of Integer =
    (CSIDL_DESKTOP, CSIDL_DRIVES, CSIDL_NETWORK, CSIDL_BITBUCKET, CSIDL_APPDATA,
    CSIDL_COMMON_DESKTOPDIRECTORY, CSIDL_COMMON_PROGRAMS, CSIDL_COMMON_STARTMENU,
    CSIDL_COMMON_STARTUP, CSIDL_CONTROLS, CSIDL_DESKTOPDIRECTORY, CSIDL_FAVORITES,
    CSIDL_FONTS, CSIDL_INTERNET, CSIDL_PERSONAL, CSIDL_PRINTERS, CSIDL_PRINTHOOD,
    CSIDL_PROGRAMS, CSIDL_RECENT, CSIDL_SENDTO, CSIDL_STARTMENU, CSIDL_STARTUP,
    CSIDL_TEMPLATES);


var
  cmvProperties: PAnsiChar = 'properties';  { Do not localize }
  ICM: IContextMenu = nil;
  ICM2: IContextMenu2 = nil;
  DesktopFolder: TShellFolder = nil;
  CS : TRTLCriticalSection;

{ PIDL manipulation }

procedure Register;
begin
  GroupDescendentsWith(TNTShellChangeNotifier, Controls.TControl);
  RegisterComponents(SPalletePage,
    [TNTShellTreeView, TNTShellComboBox, TNTShellListView, TNTShellChangeNotifier]);
end;
procedure debug(Comp:TComponent; msg:string);
begin
  ShowMessage(Comp.Name + ':' + msg);
end;

function CreatePIDL(Size: Integer): PItemIDList;
var
  Malloc: IMalloc;
begin
  OleCheck(SHGetMalloc(Malloc));
  Result := Malloc.Alloc(Size);
  if Assigned(Result) then
    FillChar(Result^, Size, 0);
end;

function NextPIDL(IDList: PItemIDList): PItemIDList;
begin
  Result := IDList;
  Inc(PByte(Result), IDList^.mkid.cb);
end;

procedure StripLastID(IDList: PItemIDList);
var
  MarkerID: PItemIDList;
begin
  MarkerID := IDList;
  if Assigned(IDList) then
  begin
    while IDList.mkid.cb <> 0 do
    begin
      MarkerID := IDList;
      IDList := NextPIDL(IDList);
    end;
    MarkerID.mkid.cb := 0;
  end;
end;

function GetItemCount(IDList: PItemIDList): Integer;
begin
  Result := 0;
  while IDList^.mkid.cb <> 0 do
  begin
    Inc(Result);
    IDList := NextPIDL(IDList);
  end;
end;

function GetPIDLSize(IDList: PItemIDList): Integer;
begin
  Result := 0;
  if Assigned(IDList) then
  begin
    Result := SizeOf(IDList^.mkid.cb);
    while IDList^.mkid.cb <> 0 do
    begin
      Result := Result + IDList^.mkid.cb;
      IDList := NextPIDL(IDList);
    end;
  end;
end;

function CopyPIDL(IDList: PItemIDList): PItemIDList;
var
  Size: Integer;
begin
  Size := GetPIDLSize(IDList);
  Result := CreatePIDL(Size);
  if Assigned(Result) then
    CopyMemory(Result, IDList, Size);
end;

function ConcatPIDLs(IDList1, IDList2: PItemIDList): PItemIDList;
var
  cb1, cb2: Integer;
begin
  if Assigned(IDList1) then
    cb1 := GetPIDLSize(IDList1) - SizeOf(IDList1^.mkid.cb)
  else
    cb1 := 0;

  cb2 := GetPIDLSize(IDList2);

  Result := CreatePIDL(cb1 + cb2);
  if Assigned(Result) then
  begin
    if Assigned(IDList1) then
      CopyMemory(Result, IDList1, cb1);
    CopyMemory(PAnsiChar(Result) + cb1, IDList2, cb2);
  end;
end;

procedure DisposePIDL(PIDL: PItemIDList);
var
  MAlloc: IMAlloc;
begin
  OLECheck(SHGetMAlloc(MAlloc));
  MAlloc.Free(PIDL);
end;

function RelativeFromAbsolute(AbsoluteID: PItemIDList): PItemIDList;
begin
  Result := AbsoluteID;
  while GetItemCount(Result) > 1 do
     Result := NextPIDL(Result);
  Result := CopyPIDL(Result);
end;

function CreatePIDLList(ID: PItemIDList): TList;
var
  TempID: PItemIDList;
begin
  Result := TList.Create;
  TempID := ID;
  while TempID.mkid.cb <> 0 do
  begin
    TempID := CopyPIDL(TempID);
    Result.Insert(0, TempID); //0 = lowest level PIDL.
    StripLastID(TempID);
  end;
end;

procedure DestroyPIDLList(List: TList);
var
  I: Integer;
begin
  If List = nil then Exit;
  for I := 0 to List.Count-1 do
    DisposePIDL(List[I]);
  List.Free;
end;

{ Miscellaneous }

procedure NoFolderDetails(AFolder: TShellFolder; HR: HResult);
begin
  Raise EInvalidPath.CreateFmt(SShellNoDetails, [AFolder.DisplayName, HR]);
end;

function DesktopShellFolder: IShellFolder;
begin
  OleCheck(SHGetDesktopFolder(Result));
end;

procedure CreateDesktopFolder;
var
  DesktopPIDL: PItemIDList;
begin
  SHGetSpecialFolderLocation(0, nFolder[rfDesktop], DesktopPIDL);
  if DesktopPIDL <> nil then
  begin
    DesktopFolder := TShellFolder.Create(nil, DesktopPIDL, DesktopShellFolder);
    DisposePIDL(DesktopPIDL);
  end;
end;

function SamePIDL(ID1, ID2: PItemIDList): boolean;
begin
  Result := DesktopShellFolder.CompareIDs(0, ID1, ID2) = 0;
end;

function DesktopPIDL: PItemIDList;
begin
  OleCheck(SHGetSpecialFolderLocation(0, nFolder[rfDesktop], Result));
end;

function GetCSIDLType(const Value: string): TRootFolder;
begin
{$R+}
  Result := TRootFolder(GetEnumValue(TypeInfo(TRootFolder), Value))
{$R-}
end;

function IsElement(Element, Flag: Integer): Boolean;
begin
  Result := Element and Flag <> 0;
end;

function GetShellImage(PIDL: PItemIDList; Large, Open: Boolean): Integer;
var
  FileInfo: TSHFileInfo;
  Flags: Integer;
begin
  Flags := SHGFI_PIDL or SHGFI_SYSICONINDEX;
  if Open then Flags := Flags or SHGFI_OPENICON;
  if Large then Flags := Flags or SHGFI_LARGEICON
  else Flags := Flags or SHGFI_SMALLICON;
  SHGetFileInfo(PChar(PIDL),
                0,
                FileInfo,
                SizeOf(FileInfo),
                Flags);
  Result := FileInfo.iIcon;
end;

function GetCaps(ParentFolder: IShellFolder; PIDL: PItemIDList): TShellFolderCapabilities;
var
  Flags: LongWord;
begin
  Result := [];
  Flags := SFGAO_CAPABILITYMASK;
  ParentFolder.GetAttributesOf(1, PIDL, Flags);
  if IsElement(SFGAO_CANCOPY, Flags) then Include(Result, fcCanCopy);
  if IsElement(SFGAO_CANDELETE, Flags) then Include(Result, fcCanDelete);
  if IsElement(SFGAO_CANLINK, Flags) then Include(Result, fcCanLink);
  if IsElement(SFGAO_CANMOVE, Flags) then Include(Result, fcCanMove);
  if IsElement(SFGAO_CANRENAME, Flags) then Include(Result, fcCanRename);
  if IsElement(SFGAO_DROPTARGET, Flags) then Include(Result, fcDropTarget);
  if IsElement(SFGAO_HASPROPSHEET, Flags) then Include(Result, fcHasPropSheet);
end;

function GetProperties(ParentFolder: IShellFolder; PIDL: PItemIDList): TShellFolderProperties;
var
  Flags: LongWord;
begin
  Result := [];
  if ParentFolder = nil then Exit;
  Flags := SFGAO_DISPLAYATTRMASK;
  ParentFolder.GetAttributesOf(1, PIDL, Flags);
  if IsElement(SFGAO_GHOSTED, Flags) then Include(Result, fpCut);
  if IsElement(SFGAO_LINK, Flags) then Include(Result, fpIsLink);
  if IsElement(SFGAO_READONLY, Flags) then Include(Result, fpReadOnly);
  if IsElement(SFGAO_SHARE, Flags) then Include(Result, fpShared);

  Flags := 0;
  ParentFolder.GetAttributesOf(1, PIDL, Flags);
  if IsElement(SFGAO_FILESYSTEM, Flags) then Include(Result, fpFileSystem);
  if IsElement(SFGAO_FILESYSANCESTOR, Flags) then Include(Result, fpFileSystemAncestor);
  if IsElement(SFGAO_REMOVABLE, Flags) then Include(Result, fpRemovable);
  if IsElement(SFGAO_VALIDATE, Flags) then Include(Result, fpValidate);
end;

function GetIsFolder(Parentfolder: IShellFolder; PIDL: PItemIDList): Boolean;
var
  Flags: LongWord;
begin
  Flags := SFGAO_FOLDER;
  ParentFolder.GetAttributesOf(1, PIDL, Flags);
  Result := SFGAO_FOLDER and Flags <> 0;
end;

function GetHasSubFolders(Parentfolder: IShellFolder; PIDL: PItemIDList): Boolean;
var
  Flags: LongWord;
begin
  Flags := SFGAO_CONTENTSMASK;
  ParentFolder.GetAttributesOf(1, PIDL, Flags);
  Result := SFGAO_HASSUBFOLDER and Flags <> 0;
end;

function GetHasSubItems(ShellFolder: IShellFolder; Flags: Integer): Boolean;
var
//  ID: PItemIDList;
  EnumList: IEnumIDList;
//  NumIDs: LongWord;
  HR: HResult;
  ErrMode: Integer;
begin
  Result := False;
  if ShellFolder = nil then Exit;
  ErrMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
    HR := ShellFolder.EnumObjects(0,
                                Flags,
                                EnumList);
    if HR <> S_OK then Exit;
// Kostas: this causes subfolders enumeration that lasts long
// Let ShellFolder has subitems in any case
//    Result := EnumList.Next(1, ID, NumIDs) = S_OK;
    Result := True;
  finally
    SetErrorMode(ErrMode);
  end;
end;

function StrRetToString(PIDL: PItemIDList; StrRet: TStrRet; Flag:string=''): string;
var
  P: PAnsiChar;
begin
  case StrRet.uType of
    STRRET_CSTR:
      SetString(Result, StrRet.cStr, lStrLenA(StrRet.cStr));
    STRRET_OFFSET:
      begin
        P := @PIDL.mkid.abID[StrRet.uOffset - SizeOf(PIDL.mkid.cb)];
        SetString(Result, P, PIDL.mkid.cb - StrRet.uOffset);
      end;
    STRRET_WSTR:
      if Assigned(StrRet.pOleStr) then
        Result := StrRet.pOleStr
      else
        Result := '';  
  end;
  { This is a hack bug fix to get around Windows Shell Controls returning
    spurious "?"s in date/time detail fields } 
  if (Length(Result) > 1) and (Result[1] = '?') and (Result[2] in ['0'..'9']) then
    Result := StringReplace(Result,'?','',[rfReplaceAll]);
end;

function GetDisplayName(Parentfolder: IShellFolder; PIDL: PItemIDList;
                        Flags: DWORD): string;
var
  StrRet: TStrRet;
begin
  Result := '';
  if ParentFolder = nil then
  begin
    Result := 'parentfolder = nil';  { Do not localize }
    exit;
  end;
  FillChar(StrRet, SizeOf(StrRet), 0);
  ParentFolder.GetDisplayNameOf(PIDL, Flags, StrRet);
  Result := StrRetToString(PIDL, StrRet);
  { TODO 2 -oMGD -cShell Controls : Remove this hack (on Win2k, GUIDs are returned for the
PathName of standard folders)}
  if (Pos('::{', Result) = 1) then
    Result := GetDisplayName(ParentFolder, PIDL, SHGDN_NORMAL);
end;

function ObjectFlags(ObjectTypes: TShellObjectTypes): Integer;
begin
  Result := 0;
  if otFolders in ObjectTypes then Inc(Result, SHCONTF_FOLDERS);
  if otNonFolders in ObjectTypes then Inc(Result, SHCONTF_NONFOLDERS);
  if otHidden in ObjectTypes then Inc(Result, SHCONTF_INCLUDEHIDDEN);
  if otINIT_ON_FIRST_NEXT in ObjectTypes then Inc(Result,SHCONTF_INIT_ON_FIRST_NEXT);
  if otNETPRINTERSRCH in ObjectTypes then Inc(Result,SHCONTF_NETPRINTERSRCH);
  if otSHAREABLE in ObjectTypes then Inc(Result,SHCONTF_SHAREABLE);
  if otSHAREABLE in ObjectTypes then Inc(Result,SHCONTF_SHAREABLE);
  if otstorage in ObjectTypes then Inc(Result, SHCONTF_STORAGE);
  if otNAVIGATION_ENUM in ObjectTypes then Inc(Result,SHCONTF_NAVIGATION_ENUM);
  if otFASTITEMS in ObjectTypes then Inc(Result,SHCONTF_FASTITEMS);
  if otFLATLIST in ObjectTypes then Inc(Result,SHCONTF_FLATLIST);
  if otENABLE_ASYNC in ObjectTypes then Inc(Result,SHCONTF_ENABLE_ASYNC);
  if otINCLUDESUPERHIDDEN in ObjectTypes then Inc(Result,SHCONTF_INCLUDESUPERHIDDEN);
end;

procedure InvokeContextMenu(Owner: TWinControl; AFolder: TShellFolder; X, Y: Integer);
var
  PIDL: PItemIDList;
  CM: IContextMenu;
  Menu: HMenu;
  ICI: TCMInvokeCommandInfo;
  P: TPoint;
  Command: LongBool;
  ICmd: integer;
  ZVerb: array[0..255] of AnsiChar;
  Verb: string;
  Handled: boolean;
  SCV: IShellCommandVerb;
  HR: HResult;
begin
  if AFolder = nil then Exit;
  PIDL := AFolder.RelativeID;
  AFolder.ParentShellFolder.GetUIObjectOf(Owner.Handle, 1, PIDL, IID_IContextMenu, nil, CM);
  if CM = nil then Exit;
  P.X := X;
  P.Y := Y;

  Windows.ClientToScreen(Owner.Handle, P);
  Menu := CreatePopupMenu;
  if Owner is TNTCustomShellTreeView then
    (Owner as TNTCustomShellTreeView).FDisableChanging := True; 
  try
    CM.QueryContextMenu(Menu, 0, 1, $7FFF, CMF_EXPLORE or CMF_CANRENAME);
    CM.QueryInterface(IID_IContextMenu2, ICM2); //To handle submenus.
    try
      Command := TrackPopupMenu(Menu, TPM_LEFTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON or
        TPM_RETURNCMD, P.X, P.Y, 0, Owner.Handle, nil);
    finally
      ICM2 := nil;
      DestroyMenu(Menu);
    end;

    if Command then
    begin
      ICmd := LongInt(Command) - 1;
      HR := CM.GetCommandString(ICmd, GCS_VERBA, nil, ZVerb, SizeOf(ZVerb));
      Verb := StrPas(ZVerb);
      Handled := False;
      if Supports(Owner, IShellCommandVerb, SCV) then
      begin
        HR := 0;
        SCV.ExecuteCommand(Verb, Handled);
      end;

      if not Handled then
      begin
        TNTShellTreeView(Owner).Selected := nil;
        FillChar(ICI, SizeOf(ICI), #0);
        with ICI do
        begin
          cbSize := SizeOf(ICI);
          hWND := Owner.Handle;
          lpVerb := MakeIntResourceA(ICmd);
          nShow := SW_SHOWNORMAL;
        end;
        HR := CM.InvokeCommand(ICI);
      end;

      if Assigned(SCV) then
        SCV.CommandCompleted(Verb, HR = S_OK);
    end;
  finally
    if Owner is TNTCustomShellTreeView then with (Owner as TNTCustomShellTreeView) do
    begin
      FDisableChanging := False;
      if Assigned(FNextNode) then
      begin
        FNextNode.Selected := True;
        FNextNode := nil;
      end;
    end;
  end;
end;

procedure DoContextMenuVerb(AFolder: TShellFolder; Verb: PAnsiChar);
var
  ICI: TCMInvokeCommandInfo;
  CM: IContextMenu;
  PIDL: PItemIDList;
begin
  if AFolder = nil then Exit;
  FillChar(ICI, SizeOf(ICI), #0);
  with ICI do
  begin
    cbSize := SizeOf(ICI);
    fMask := CMIC_MASK_ASYNCOK;
    hWND := 0;
    lpVerb := Verb;
    nShow := SW_SHOWNORMAL;
  end;
  PIDL := AFolder.RelativeID;
  AFolder.ParentShellFolder.GetUIObjectOf(0, 1, PIDL, IID_IContextMenu, nil, CM);
  CM.InvokeCommand(ICI);
end;

function GetIShellFolder(IFolder: IShellFolder; PIDL: PItemIDList;
  Handle: THandle = 0): IShellFolder;
var
  HR : HResult;
begin
  if Assigned(IFolder) then
  begin
    HR := IFolder.BindToObject(PIDL, nil, IID_IShellFolder, Pointer(Result));
    if HR <> S_OK then
      IFolder.GetUIObjectOf(Handle, 1, PIDL, IID_IShellFolder, nil, Pointer(Result));
    if HR <> S_OK then
      IFolder.CreateViewObject(Handle, IID_IShellFolder, Pointer(Result));
  end;
  if not Assigned(Result) then
    DesktopShellFolder.BindToObject(PIDL, nil, IID_IShellFolder, Pointer(Result));
end;

function GetIShellDetails(IFolder: IShellFolder; PIDL: PItemIDList;
  Handle: THandle = 0): IShellDetails;
var
  HR : HResult;
begin
  if Assigned(IFolder) and Assigned(Result) then
  begin
    HR := IFolder.BindToObject(PIDL, nil, IID_IShellDetails, Pointer(Result));
    if HR <> S_OK then
      IFolder.GetUIObjectOf(Handle, 1, PIDL, IID_IShellDetails, nil, Pointer(Result));
    if HR <> S_OK then
      IFolder.CreateViewObject(Handle, IID_IShellDetails, Pointer(Result));
  end;
  if not Assigned(Result) then
    DesktopShellFolder.BindToObject(PIDL, nil, IID_IShellDetails, Pointer(Result));
end;

function GetIShellFolder2(IFolder: IShellFolder; PIDL: PItemIDList;
  Handle: THandle = 0): IShellFolder2;
var
  HR : HResult;
begin
  if (Win32MajorVersion >= 5) then
  begin
    HR := DesktopShellFolder.BindToObject(PIDL, nil, IID_IShellFolder2, Pointer(Result));
    if HR <> S_OK then
      IFolder.GetUIObjectOf(Handle, 1, PIDL, IID_IShellFolder2, nil, Pointer(Result));
    if (HR <> S_OK) and (IFolder <> nil) then
      IFolder.BindToObject(PIDL, nil, IID_IShellFolder2, Pointer(Result));
  end
  else
    Result := nil;
end;

function CreateRootFromPIDL(Value: PItemIDList): TShellFolder;
var
  SF: IShellFolder;
begin
  SF := GetIShellFolder(DesktopShellFolder, Value);
  if SF = NIL then SF := DesktopShellFolder;
  //special case - Desktop folder can't bind to itself.
  Result := TShellFolder.Create(DesktopFolder, Value, SF);
end;

function CreateRootFolder(RootFolder: TShellFolder; OldRoot : TRoot;
  var NewRoot: TRoot): TShellFolder;
var
  P: PWideChar;
  NewPIDL: PItemIDList;
  NumChars,
  Flags,
  HR: LongWord;
  ErrorMsg : string;
begin
  HR := S_FALSE;
  if GetEnumValue(TypeInfo(TRootFolder), NewRoot) >= 0 then
  begin
    HR := SHGetSpecialFolderLocation(
            0,
            nFolder[GetCSIDLType(NewRoot)],
            NewPIDL);
  end
  else if Length(NewRoot) > 0 then
  begin
    if NewRoot[Length(NewRoot)] = ':' then NewRoot := NewRoot + '\';
    NumChars := Length(NewRoot);
    Flags := 0;
    P := StringToOleStr(NewRoot);
    HR := DesktopShellFolder.ParseDisplayName(0, nil, P, NumChars, NewPIDL, Flags);
  end;

  if HR <> S_OK then
  begin
    { TODO : Remove the next line? }
    // Result := RootFolder;
    ErrorMsg := Format( SErrorSettingPath, [ NewRoot ] );
    NewRoot := OldRoot;
    raise Exception.Create( ErrorMsg );
  end;

  Result := CreateRootFromPIDL(NewPIDL);
  if Assigned(RootFolder) then RootFolder.Free;
end;

{ TShellFolder }

constructor TShellFolder.Create(AParent: TShellFolder; ID: PItemIDList; SF: IShellFolder);
var
  DesktopID: PItemIDList;
begin
  inherited Create;
  FLevel := 0;
  FDetails := TStringList.Create;
  FIShellFolder := SF;
  FIShellFolder2 := nil;
  FIShellDetails := nil;
  FParent := AParent;
  FPIDL := CopyPIDL(ID);
  if FParent <> nil then
    FFullPIDL := ConcatPIDLs(AParent.FFullPIDL, ID)
  else
  begin
    DesktopID := DesktopPIDL;
    try
      FFullPIDL := ConcatPIDLs(DesktopID, ID);
    finally
      DisposePIDL(DesktopID);
    end;
  end;
  if FParent = nil then
    FParent := DesktopFolder;
  while AParent <> nil do
  begin
    AParent := AParent.Parent;
    if AParent <> nil then Inc(FLevel);
  end;
end;

destructor TShellFolder.Destroy;
begin
  if Assigned(FDetails) then
    FDetails.Free;
  FDetails := nil;  
  if Assigned(FPIDL) then
    DisposePIDL(FPIDL);
  if Assigned(FFullPIDL) then
    DisposePIDL(FFullPIDL);
  inherited Destroy;
end;

function TShellFolder.GetDetailInterface: IInterface;
begin
  if (not Assigned(FDetailInterface)) and Assigned(FIShellFolder) then
  begin
    FIShellDetails := GetIShellDetails(FIShellFolder, FFullPIDL, FViewHandle);
    if (not Assigned(FIShellDetails)) and (Win32MajorVersion >= 5) then
    begin
      FIShellFolder2 := GetIShellFolder2(FIShellFolder, FFullPIDL, FViewHandle);
      if not Assigned(FIShellFolder2) then // Hack!
       { Note: Although QueryInterface will not work in this instance,
         IShellFolder2 is indeed supported for this Folder if IShellDetails
         is not. In all tested cases, hard-casting the interface to
         IShellFolder2 has worked. Hopefully, Microsoft will fix this bug in
         a future release of ShellControls }
        FIShellFolder2 := IShellFolder2(FIShellFolder);
    end;
    if Assigned(FIShellFolder2) then
      Result := FIShellFolder2
    else
      Result := FIShellDetails;
    FDetailInterface := Result;
  end
  else
    Result := FDetailInterface;
end;

function TShellFolder.GetShellDetails: IShellDetails;
begin
  if not Assigned(FDetailInterface) then
    GetDetailInterface;
  Result := FIShellDetails;
end;

function TShellFolder.GetShellFolder2: IShellFolder2;
begin
  if not Assigned(FDetailInterface) then
    GetDetailInterface;
  Result := FIShellFolder2;
end;

procedure TShellFolder.LoadColumnDetails(RootFolder: TShellFolder;
  Handle: THandle; ColumnCount: integer);

  procedure GetDetailsOf(AFolder: TShellFolder; var Details: TWin32FindData);
  var
    szPath: array[ 0 .. MAX_PATH] of char;
    Path: string;
    Handle: THandle;
  begin
    FillChar(Details, SizeOf(Details), 0);
    FillChar(szPath,MAX_PATH,0);
    Path := AFolder.PathName;
    Handle := Windows.FindFirstFile(PChar(Path), Details);
    try
      if Handle = INVALID_HANDLE_VALUE then
        NoFolderDetails(AFolder, Windows.GetLastError);
    finally
      Windows.FindClose(Handle);
    end;
  end;

  function CalcFileSize(FindData: TWin32FindData): int64;
  begin
    if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
      Result := FindData.nFileSizeHigh * MAXDWORD + FindData.nFileSizeLow
    else
      Result := -1;
  end;

  function CalcModifiedDate(FindData: TWin32FindData): TDateTime;
  var
    LocalFileTime: TFileTime;
    Age : integer;
  begin
    if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
      FileTimeToLocalFileTime(FindData.ftLastWriteTime, LocalFileTime);
      if FileTimeToDosDateTime(LocalFileTime, LongRec(Age).Hi,
        LongRec(Age).Lo) then
      begin
        Result := FileDateToDateTime(Age);
        Exit;
      end;
    end;
    Result := -1;
  end;

  function DefaultDetailColumn(FindData: TWin32FindData; Col: integer): string;
  begin
    case Col of
    //1 : Result := FindData.cFileName; // Name
    1 : Result := IntToStr(CalcFileSize(FindData)); // Size
    2 : Result := ExtractFileExt(FindData.cFileName); // Type
    3 : Result := DateTimeToStr(CalcModifiedDate(FindData)); // Modified
    4 : Result := IntToStr(FindData.dwFileAttributes);
    end;
  end;

  procedure AddDetail(HR: HResult; PIDL: PItemIDList; SD: TShellDetails);
  begin
    if HR = S_OK then
      FDetails.Add(StrRetToString(PIDL, SD.str))
    else
      FDetails.Add('');
  end;
  
var
  SF2: IShellFolder2;
  ISD: IShellDetails;
  J: Integer;
  SD: TShellDetails;
  HR: HResult;
  //AFolder: TShellFolder;
  FindData: TWin32FindData;

begin
  if not Assigned(FDetails) or (FDetails.Count >= ColumnCount) then Exit; // Details are loaded
  FDetails.Clear;
  FViewHandle := Handle;
  SF2 := RootFolder.ShellFolder2;
  {//!
  if fpFileSystem in Properties then
    ColumnCount := 4;
  }
  if Assigned(SF2) then
  begin
    // Already have name and icon, so see if we can provide details
    for J := 1 to ColumnCount do
    begin
      HR := SF2.GetDetailsOf(FPIDL, J, SD);
      AddDetail(HR, FPIDL, SD);
    end;
  end
  else
  begin
    ISD := RootFolder.ShellDetails;
    if Assigned(ISD) then
    begin
      for J := 1 to ColumnCount do
      begin
        HR := ISD.GetDetailsOf(FPIDL, J, SD);
        AddDetail(HR, FPIDL, SD);
      end;
    end
    else if (fpFileSystem in RootFolder.Properties) then
    begin
      GetDetailsOf(Self, FindData);
      for J := 1 to ColumnCount do
        FDetails.Add(DefaultDetailColumn(FindData, J));
    end;
  end;
end;

function TShellFolder.GetDetails(Index: integer): string;
begin
  if FDetails.Count > 0 then
    Result := FDetails[Index-1] // Index is 1-based
  else
    Raise Exception.CreateFmt(SCallLoadDetails, [ Self.DisplayName ] );
end;

procedure TShellFolder.SetDetails(Index: integer; const Value: string);
begin
  if Index < FDetails.Count then
    FDetails[Index - 1] := Value // Index is 1-based
  else
    FDetails.Insert(Index - 1, Value); // Index is 1-based
end;

function TShellFolder.ParentShellFolder: IShellFolder;
begin
  if FParent <> nil then
    Result := FParent.ShellFolder
  else
    OLECheck(SHGetDesktopFolder(Result));
end;

function TShellFolder.Properties: TShellFolderProperties;
begin
  Result := GetProperties(ParentShellFolder, FPIDL);
end;

function TShellFolder.Capabilities: TShellFolderCapabilities;
begin
  Result := GetCaps(ParentShellFolder, FPIDL);
end;

function TShellFolder.SubFolders: Boolean;
begin
  Result := GetHasSubFolders(ParentShellFolder, FPIDL);
end;

function TShellFolder.IsFolder: Boolean;
begin
  Result := GetIsFolder(ParentShellFolder, FPIDL);
end;

function TShellFolder.PathName: string;
begin
//####Kostas
//  Result := GetDisplayName(DesktopShellFolder, FFullPIDL, SHGDN_FORPARSING);
  if ParentShellFolder <> nil then
    Result := GetDisplayName(ParentShellFolder, FPIDL, SHGDN_FORPARSING)
  else
    Result := GetDisplayName(DesktopShellFolder, FFullPIDL, SHGDN_FORPARSING);
//
end;

function TShellFolder.DisplayName: string;
var
  ParentFolder: IShellFolder;
begin
  if Parent <> nil then
    ParentFolder := ParentShellFolder
  else
    ParentFolder := DesktopShellFolder;
  Result := GetDisplayName(ParentFolder, FPIDL, SHGDN_INFOLDER)
end;

function TShellFolder.Rename(const NewName: Widestring): boolean;
var
  NewPIDL: PItemIDList;
  R: HRESULT;
begin
  Result := False;
  if not (fcCanRename in Capabilities) then Exit;

  R := ParentShellFolder.SetNameOf(
       0,
       FPIDL,
       PWideChar(NewName),
//####Kostas       SHGDN_NORMAL,
       SHGDN_INFOLDER,            
       NewPIDL);
  Result := R = S_OK;
  if Result then
  begin
    DisposePIDL(FPIDL);
    DisposePIDL(FFullPIDL);
    FPIDL := NewPIDL;
    if (FParent <> nil) then
      FFullPIDL := ConcatPIDLs(FParent.FPIDL, NewPIDL)
    else
      FFullPIDL := CopyPIDL(NewPIDL);
  end
  else
    Raise Exception.Create(Format(SRenamedFailedError,[NewName]));
end;

function TShellFolder.ImageIndex(LargeIcon: Boolean): Integer;
begin
  Result := GetShellImage(AbsoluteID, LargeIcon, False);
end;

function TShellFolder.ExecuteDefault: Integer;
var
  SEI: TShellExecuteInfo;
begin
  FillChar(SEI, SizeOf(SEI), 0);
  with SEI do
  begin
    cbSize := SizeOf(SEI);
    wnd := Application.Handle;
    fMask := SEE_MASK_INVOKEIDLIST;
    lpIDList := AbsoluteID;
    nShow := SW_SHOW;
  end;
  Result := Integer(ShellExecuteEx(@SEI));
end;

{ TCustomShellChangeNotifier }

procedure TNTCustomShellChangeNotifier.Change;

  function NotifyOptionFlags: DWORD;
  begin
    Result := 0;
    if nfFileNameChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_FILE_NAME;
    if nfDirNameChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_DIR_NAME;
    if nfSizeChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_SIZE;
    if nfAttributeChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_ATTRIBUTES;
    if nfWriteChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_LAST_WRITE;
    if nfSecurityChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_SECURITY;
  end;

begin
  if Assigned(FThread) then
  begin
    FThread.SetDirectoryOptions(Root, LongBool(FWatchSubTree),
      NotifyOptionFlags);
  end;
end;

constructor TNTCustomShellChangeNotifier.Create(AOwner : TComponent);
begin
  inherited;
  FRoot := 'C:\';      { Do not localize }
  FWatchSubTree := True;
  FFilters := [nfFilenameChange, nfDirNameChange];
  Start;
end;

destructor TNTCustomShellChangeNotifier.Destroy;
var
  Temp : TShellChangeThread;
begin
  if Assigned(FThread) then
  begin
    Temp := FThread;
    FThread := nil;
    Temp.Terminate;
    ReleaseMutex(Temp.FMutex);
  end;
  inherited;
end;

procedure TNTCustomShellChangeNotifier.SetRoot(const Value: TRoot);
begin
  if not SameText(FRoot, Value) then
  begin
    FRoot := Value;
    Change;
  end;
end;

procedure TNTCustomShellChangeNotifier.SetFilters(const Value: TNotifyFilters);
begin
  FFilters := Value;
  Change;
end;

procedure TNTCustomShellChangeNotifier.SetOnChange(const Value: TThreadMethod);
begin
  FOnChange := Value;
  if Assigned(FThread) then
    FThread.ChangeEvent := FOnChange
  else
    Start;
end;

procedure TNTCustomShellChangeNotifier.SetWatchSubTree(const Value: Boolean);
begin
  FWatchSubTree := Value;
  Change;
end;

procedure TNTCustomShellChangeNotifier.Start;

  function NotifyOptionFlags: DWORD;
  begin
    Result := 0;
    if nfFileNameChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_FILE_NAME;
    if nfDirNameChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_DIR_NAME;
    if nfSizeChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_SIZE;
    if nfAttributeChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_ATTRIBUTES;
    if nfWriteChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_LAST_WRITE;
    if nfSecurityChange in FFilters then
      Result := Result or FILE_NOTIFY_CHANGE_SECURITY;
  end;

begin
  if Assigned(FOnChange) then
  begin
    FThread := TShellChangeThread.Create(FOnChange);
    FThread.SetDirectoryOptions(FRoot,
      LongBool(FWatchSubTree), NotifyOptionFlags);
    FThread.Resume;
  end;
end;

function TShellFolder.GetIShellFolder: IShellFolder;
begin
  Result := FIShellFolder;
end;

{ TShellChangeThread }

constructor TShellChangeThread.Create(ChangeEvent: TThreadMethod);
begin
  FreeOnTerminate := True;
  FChangeEvent := ChangeEvent;
  FMutex := CreateMutex(nil, True, nil);
  //Mutex is used to wake up the thread as it waits for any change notifications.
  WaitForSingleObject(FMutex, INFINITE); //Grab the mutex.
  FWaitChanged := false;
  inherited Create(True);
end;

destructor TShellChangeThread.Destroy;
begin
  if FWaitHandle <> ERROR_INVALID_HANDLE then
    FindCloseChangeNotification(FWaitHandle);
  CloseHandle(FMutex);
  inherited Destroy;
end;

procedure TShellChangeThread.Execute;
var
  Obj: DWORD;
  Handles: array[0..1] of DWORD;
begin
  EnterCriticalSection(CS);
  FWaitHandle := FindFirstChangeNotification(PChar(FDirectory),
     LongBool(FWatchSubTree), FNotifyOptionFlags);
  LeaveCriticalSection(CS);
  if FWaitHandle = ERROR_INVALID_HANDLE then Exit;
  while not Terminated do
  begin
    Handles[0] := FWaitHandle;
    Handles[1] := FMutex;
    Obj := WaitForMultipleObjects(2, @Handles, False, INFINITE);
    case Obj of
      WAIT_OBJECT_0:
        begin
          Synchronize(FChangeEvent);
          FindNextChangeNotification(FWaitHandle);
        end;
      WAIT_OBJECT_0 + 1:
        ReleaseMutex(FMutex);
      WAIT_FAILED:
        Exit;
    end;
    EnterCriticalSection(CS);
    if FWaitChanged then
    begin
      FWaitHandle := FindFirstChangeNotification(PChar(FDirectory),
         LongBool(FWatchSubTree), FNotifyOptionFlags);
      FWaitChanged := false;
    end;
    LeaveCriticalSection(CS);
  end;
end;

procedure TShellChangeThread.SetDirectoryOptions(Directory: String;
  WatchSubTree: Boolean; NotifyOptionFlags: DWORD);
begin
  EnterCriticalSection(CS);
  FDirectory := Directory;
  FWatchSubTree := WatchSubTree;
  FNotifyOptionFlags := NotifyOptionFlags;

  // Release the current notification handle
  FindCloseChangeNotification(FWaitHandle);

  CloseHandle(FMutex);			
  FMutex := CreateMutex(nil, True, nil);
  
  FWaitChanged := true;
  LeaveCriticalSection(CS);
end;

{ TNTCustomShellTreeView }

constructor TNTCustomShellTreeView.Create(AOwner: TComponent);
var
  FileInfo: TSHFileInfo;
begin
  inherited Create(AOwner);
//  FFileMask := TStrings.Create;
//  FFileMask.Add('*.*');
  FFileMask := '*.*';
  FDisableChanging := False;
  FNextNode := nil;
  FRootFolder := nil;
  ShowRoot := False;
  FObjectTypes := [otFolders];
  RightClickSelect := True;
  FAutoContext := True;
  //! OnDeletion := NodeDeleted;
  FUpdating := False;
  FComboBox := nil;
  FListView := nil;
  FImageListChanging := False;
  FUseShellImages := True;
  FImages := SHGetFileInfo('C:\',     { Do not localize }
    0, FileInfo, SizeOf(FileInfo), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);

  FNotifier := TNTShellChangeNotifier.Create(Self);
  FNotifier.FComponentStyle := FNotifier.FComponentStyle + [ csSubComponent ];
  FRoot := SRFDesktop;
  FLoadingRoot := False;
  FLastPath := '';
  FDragFolder := nil;
  FOnDeleteFile := nil;
  FOnCanDeleteFile := nil;
  DragKind := dkDrag;
  DragMode := dmAutomatic;
end;

destructor TNTCustomShellTreeView.Destroy;
begin
  if FRootFolder <> nil then
    FRootFolder.Free;
  inherited;
end;

procedure TNTCustomShellTreeView.ClearItems;
var
  I: Integer;
begin
  Items.BeginUpdate;
  try
    for I := 0 to Items.Count-1 do
    begin
      if Assigned(Folders[i]) then
        Folders[I].Free;
      Items[I].Data := nil;
    end;
    Items.Clear;
  finally
    Items.EndUpdate;
  end;
end;

procedure TNTCustomShellTreeView.CreateWnd;
begin
  inherited CreateWnd;
  if (Items.Count > 0) then
    ClearItems;
  if not Assigned(Images) then SetUseShellImages(FUseShellImages);
  { TODO : What is the Items.Count test for here? }
  if (not FLoadingRoot) {and (Items.Count = 0)} then
    CreateRoot;
// Kostas:
  try
    if FLastPath <> '' then
      SetPath(FLastPath);
  except
  end;
  DragAcceptFiles(Handle, True);
end;

procedure TNTCustomShellTreeView.DestroyWnd;
begin
  DragAcceptFiles(Handle, False);
  if HandleAllocated then FLastPath := GetPath;
  ClearItems;
  inherited DestroyWnd;
end;

procedure TNTCustomShellTreeView.CommandCompleted(Verb: String;
  Succeeded: Boolean);
var
  Fldr : TShellFolder;
begin
  if not Succeeded then Exit;
  if Assigned(Selected) then
  begin
    if SameText(Verb, SCmdVerbDelete) then
    begin
      Fldr := TShellFolder(Selected.Data);
      if not FileExists(Fldr.PathName) then
      begin
        DoDeleteFile(Selected);
        Selected.Data := nil;
        FNextNode := Selected.GetNext;
        if not Assigned(FNextNode) then FNextNode := Selected.GetPrev;
        if not Assigned(FNextNode) then
          if Items.Count > 0 then FNextNode := Items[0] else FNextNode := nil;
        Selected.Delete;
        FreeAndNil(Fldr);
      end;
    end
    else if SameText(Verb, SCmdVerbPaste) then
//      Refresh(Selected)
      if Assigned(Selected) and Assigned(Selected.Parent) then
        PostRefresh(Selected.Parent)
      else
        PostRefresh(Selected)
    else if SameText(Verb, SCmdVerbOpen) then
      SetCurrentDirectory(PChar(FSavePath));
  end;
end;

procedure TNTCustomShellTreeView.ExecuteCommand(Verb: String;
  var Handled: Boolean);
var
  szPath: array[0..MAX_PATH] of char;
  CanDel: boolean;
begin
  if (SameText(Verb, SCmdVerbCut) or SameText(Verb, SCmdVerbDelete))and Assigned(Selected) then
  begin
    CanDel := True;
    DoCanDeleteFile(Selected, CanDel);
    if not CanDel then
    begin
      Handled := True;
      Exit;
    end;
  end;
  if SameText(Verb, SCmdVerbRename) and Assigned(Selected) then
  begin
    Selected.EditText;
    Handled := True;
  end
  else if SameText(Verb, SCmdVerbOpen) and Assigned(Selected) then
  begin
    GetCurrentDirectory(MAX_PATH, szPath);
    FSavePath := StrPas(szPath);
    StrPCopy(szPath, ExtractFilePath(TShellFolder(Selected.Data).PathName));
    SetCurrentDirectory(szPath);
  end
  else if SameText(Verb, SCmdVerbCut) and Assigned(Selected) then
  begin
    CutOff;
    Selected.Cut := True;
  end
  else if SameText(Verb, SCmdVerbCopy) or SameText(Verb, SCmdVerbPaste) then
    CutOff;
end;

function TreeSortFunc(Node1, Node2: TTreeNode; lParam: Integer): Integer; stdcall;
begin
  Result := SmallInt(TShellFolder(Node1.Data).ParentShellFolder.CompareIDs(
       0, TShellFolder(Node1.Data).RelativeID, TShellFolder(Node2.Data).RelativeID));
end;

function TNTCustomShellTreeView.InitNode(NewNode: TTreeNode; ID: PItemIDList; ParentNode: TTreeNode): boolean;
var
  CanAdd: Boolean;
  NewFolder: IShellFolder;
  AFolder: TShellFolder;
//  Matches: Boolean;
//  i: Integer;
begin
  AFolder := TShellFolder(ParentNode.Data);
  NewFolder := GetIShellFolder(AFolder.ShellFolder, ID);
  NewNode.Data := TShellFolder.Create(AFolder, ID, NewFolder);
  with TShellFolder(NewNode.Data) do
  begin
    NewNode.Text := DisplayName;
    if FUseShellImages and not Assigned(Images) then
    begin
      NewNode.ImageIndex := GetShellImage(AbsoluteID, False, False);
      NewNode.SelectedIndex := GetShellImage(AbsoluteID, False, True);
    end;
    if NewNode.SelectedIndex = 0 then NewNode.SelectedIndex := NewNode.ImageIndex;
    NewNode.HasChildren := SubFolders;
// Kostas: this causes queries to drives (floppy, cd etc.) that lasts long
//    if fpShared in Properties then NewNode.OverlayIndex := 0;
    if not NewNode.HasChildren and (otNonFolders in ObjectTypes) and (ShellFolder <> nil) then
      NewNode.HasChildren := GetHasSubItems(ShellFolder, ObjectFlags(FObjectTypes));
  end;
//  Matches := false;
//  for i := 0 to FFileMask.Count - 1 do
//  begin
//    if MatchesMask(TShellFolder(NewNode.Data).PathName, FFileMask.Strings[i]) then
//      Matches := true;
//  end;
  CanAdd := TShellFolder(NewNode.Data).IsFolder or
      MatchesMask(TShellFolder(NewNode.Data).PathName, FFileMask);//Matches;
  if Assigned(FOnAddFolder) then FOnAddFolder(Self, TShellFolder(NewNode.Data), CanAdd);
  if not CanAdd then
    NewNode.Delete;
  Result := CanAdd;
end;

procedure TNTCustomShellTreeView.PopulateNode(Node: TTreeNode);
var
  ID: PItemIDList;
  EnumList: IEnumIDList;
  NewNode: TTreeNode;
  NumIDs: LongWord;
  SaveCursor: TCursor;
  HR: HResult;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  Items.BeginUpdate;
  try
    try
      HR := TShellFolder(Node.Data).ShellFolder.EnumObjects(Application.Handle,
                     ObjectFlags(FObjectTypes),
                     EnumList);
      if HR <> 0 then Exit;
    except on E:Exception do end;        

    while EnumList.Next(1, ID, NumIDs) = S_OK do
    begin
      NewNode := Items.AddChild(Node, '');
      InitNode(NewNode, ID, Node);
    end;

    Node.CustomSort(@TreeSortFunc, 0);
  finally
    Items.EndUpdate;
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TNTCustomShellTreeView.SetObjectTypes(Value: TShellObjectTypes);
begin
  FObjectTypes := Value;
  RootChanged;
end;

procedure TNTCustomShellTreeView.CreateRoot;
var
  RootNode: TTreeNode;
  ErrorMsg: string;
begin
  if (csLoading in ComponentState) then Exit;
  try
    FRootFolder := CreateRootFolder(FRootFolder, FOldRoot, FRoot);
    ErrorMsg := '';
  except
    on E : Exception do ErrorMsg := E.Message;
  end;

  if Assigned(FRootFolder) then
  begin
    FLoadingRoot := true;
    try
      if Items.Count > 0 then
        ClearItems;
      RootNode := Items.Add(nil, '');
      with RootNode do
      begin
        Data := TShellFolder.Create(nil, FRootFolder.AbsoluteID, FRootFolder.ShellFolder);

        Text := GetDisplayName(DesktopShellFolder,
                               TShellFolder(Data).AbsoluteID,
                               SHGDN_NORMAL);

        if FUseShellImages and not Assigned(Images) then
        begin
          RootNode.ImageIndex := GetShellImage(TShellFolder(RootNode.Data).AbsoluteID, False, False);
          RootNode.SelectedIndex := GetShellImage(TShellFolder(RootNode.Data).AbsoluteID, False, True);
        end;
        RootNode.HasChildren := TShellFolder(RootNode.Data).SubFolders;
      end;
      RootNode.Expand(False);
//      Selected := RootNode;
    finally
      FLoadingRoot := False;
    end;
  end;
  if ErrorMsg <> '' then
    Raise Exception.Create( ErrorMsg );
end;

function TNTCustomShellTreeView.CanExpand(Node: TTreeNode): Boolean;
var
  Fldr: TShellFolder;
begin
  Result := True;
  Fldr := TShellFolder(Node.Data);
  if (csDesigning in ComponentState) and (Node.Level > 0) then Exit;
  if Assigned(OnExpanding) then OnExpanding(Self, Node, Result);
  if Result then
    if Fldr.IsFolder and (Node.HasChildren) and (Node.Count = 0) then
      PopulateNode(Node)
    else if not Fldr.IsFolder then
    begin
      ShellExecute(Handle, nil, PChar(Fldr.PathName), nil,
        PChar(ExtractFilePath(Fldr.PathName)), 0);
    end;
  Node.HasChildren := Node.Count > 0;
end;

procedure TNTCustomShellTreeView.Edit(const Item: TTVItem);
var
  S: string;
  Node: TTreeNode;
begin
  with Item do
    if pszText <> nil then
    begin
      S := pszText;
      Node := Items.GetNode(Item.hItem);
      if Assigned(OnEdited) then OnEdited(Self, Node, S);
      if ( Node <> nil ) and TShellFolder(Node.Data).Rename(S) then
      begin
        Node.Text := S;
        DoRenameFile(Node);
      end;
    end;
end;

procedure TNTCustomShellTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //! Commenting this out fixes #107480, #109250
  (*
  if (Button = mbRight) and FAutoContext and (Selected <> nil) and (Selected.Data <> nil) then
    InvokeContextMenu(Self, SelectedFolder, X, Y)
  else
  (**)  
    inherited MouseUp(Button, Shift, X, Y);
end;

function TNTCustomShellTreeView.NodeFromRelativeID(ParentNode: TTreeNode; ID: PItemIDList): TTreeNode;
var
  HR: HResult;
begin
  Result := ParentNode.GetFirstChild;
  while (Result <> nil) do
  begin
    HR := TShellFolder(ParentNode.Data).ShellFolder.CompareIDs(0, ID, TShellFolder(Result.Data).RelativeID);
    if HR = 0 then Exit;
    Result := ParentNode.GetNextChild(Result);
  end;
end;

function TNTCustomShellTreeView.NodeFromAbsoluteID(StartNode: TTreeNode; ID: PItemIDList): TTreeNode;
var
  HR: HResult;
begin
  Result := StartNode;
  while Result <> nil do
  begin
    HR := DesktopShellFolder.CompareIDs(0, ID, TShellFolder(Result.Data).AbsoluteID);
    if HR = 0 then Exit;
    Result := Result.GetNext;
  end;
end;

procedure TNTCustomShellTreeView.Delete(Node: TTreeNode);
begin
  if Assigned(Node.Data) then
  begin
    TShellFolder(Node.Data).Free;
    Node.Data := nil;
  end;
  inherited Delete(Node);
end;

(*
procedure TNTCustomShellTreeView.NodeDeleted(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(Node.Data) then
  begin
    TShellFolder(Node.Data).Free;
    Node.Data := nil;
  end;
end;
(**)

procedure TNTCustomShellTreeView.RootChanged;
begin
  if FUpdating then Exit;
  FUpdating := True;
  try
    CreateRoot;
    if Assigned(FComboBox) then
      FComboBox.SetRoot(FRoot);
    if Assigned(FListView) then
      FListView.SetRoot(FRoot);
  finally
    FUpdating := False;
  end;
end;

function TNTCustomShellTreeView.FolderExists(FindID: PItemIDList; InNode: TTreeNode): TTreeNode;
var
  ALevel: Integer;
begin
  Result := nil;
  ALevel := InNode.Level;
  repeat
    if DesktopShellFolder.CompareIDs(
      0,
      FindID,
      TShellFolder(InNode.Data).AbsoluteID) = 0 then
    begin
      Result := InNode;
      Exit;
    end else
      InNode := InNode.GetNext;
  until (InNode = nil) or (InNode.Level <= ALevel);
end;

procedure TNTCustomShellTreeView.RefreshEvent;
begin
  if Assigned(Selected) then
    Refresh(Selected);
end;
 procedure TNTCustomShellTreeView.MyRefreshListView;
 var Node:TTreeNode;
 begin
       Node:=Selected;
      if Assigned(Node) then
      begin
        if Assigned(FListView) then
          FListView.TreeUpdate(TShellFolder(Node.Data).AbsoluteID);
        if Assigned(FComboBox) then
          FComboBox.TreeUpdate(TShellFolder(Node.Data).AbsoluteID);
      end;

 end;
function TNTCustomShellTreeView.Refresh(Node: TTreeNode): TTreeNode;
var
  NewNode, OldNode, Temp: TTreeNode;
  OldFolder, NewFolder: TShellFolder;
  ThisLevel: Integer;
  SaveCursor: TCursor;
  TopID, SelID: PItemIDList;
  ParentFolder: TShellFolder;
  SavePath: string;
begin
  Result := nil;
  if Node = nil then Exit;
  if Node.Data = nil then Exit;
  if TShellFolder(Node.Data).ShellFolder = nil then Exit;
  SavePath := Path;
  SaveCursor := Screen.Cursor;
  ParentFolder := nil;
  //Need absolute PIDL to search for top item once tree is rebuilt.
  TopID := CopyPIDL(TShellFolder(TopItem.Data).RelativeID);
  if TShellFolder(TopItem.Data).Parent <> nil then
    TopID := ConcatPIDLs(TShellFolder(TopItem.Data).Parent.AbsoluteID, TopID);
  //Same thing for SelID
  SelID := nil;
  if (Selected <> nil) and (Selected.Data <> nil) then
  begin
    SelID := CopyPIDL(TShellFolder(Selected.Data).RelativeID);
    if TShellFolder(Selected.Data).Parent <> nil then
      SelID := ConcatPIDLs(TShellFolder(Selected.Data).Parent.AbsoluteID, SelID);
  end;

  Items.BeginUpdate;
  try
    Screen.Cursor := crHourglass;
    OldFolder := Node.Data;
    NewNode := Items.Insert(Node, '');
    if Node.Parent <> nil then
      ParentFolder := TShellFolder(Node.Parent.Data);
    NewNode.Data := TShellFolder.Create(ParentFolder,
                                   OldFolder.RelativeID,
                                   OldFolder.ShellFolder);
    PopulateNode(NewNode);
    with NewNode do
    begin
      NewFolder := Data;
      ImageIndex := GetShellImage(NewFolder.AbsoluteID, False, False);
      SelectedIndex := GetShellImage(NewFolder.AbsoluteID, False, True);
      HasChildren := NewFolder.SubFolders;
      Text := NewFolder.DisplayName;
    end;

    ThisLevel := Node.Level;
    OldNode := Node;
    repeat
      Temp := FolderExists(TShellFolder(OldNode.Data).AbsoluteID, NewNode);
      if (Temp <> nil) and OldNode.Expanded then
        Temp.Expand(False);
      OldNode := OldNode.GetNext;
    until (OldNode = nil) or (OldNode.Level = ThisLevel);

    if Assigned(Node.Data) then
    begin
      TShellFolder(Node.Data).Free;
      Node.Data := nil;
    end;
    Node.Delete;
    if SelID <> nil then
    begin
      Temp := FolderExists(SelID, Items[0]);
      Selected := Temp;
      if Assigned(Temp) then
        Temp.MakeVisible;
    end;
    Temp := FolderExists(TopID, Items[0]);
    TopItem := Temp;
    Result := NewNode;
  finally
    Items.EndUpdate;
    DisposePIDL(TopID);
    if SelID <> nil then DisposePIDL(SelID);
    Screen.Cursor := SaveCursor;
    try
      Path := SavePath;
    finally
      if not SameText(Path, SavePath) then
        Path := ExtractFilePath(SavePath);
    end;
  end;
end;

procedure TNTCustomShellTreeView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FComboBox) then
      FComboBox := nil
    else if (AComponent = FListView) then
      FListView := nil;
  end;
end;

function TNTCustomShellTreeView.CanChange(Node: TTreeNode): Boolean;
var
  Fldr: TShellFolder;
  StayFresh: boolean;
begin
  if FDisableChanging then begin Result := False; Exit; end;
  Result := inherited CanChange(Node);
  if Result and (not FUpdating) and Assigned(Node) then
  begin
    Fldr := TShellFolder(Node.Data);
    StayFresh := FAutoRefresh;
    AutoRefresh := False;
    if not Fldr.IsFolder then
      Fldr := Fldr.Parent;
    FUpdating := True;
    try
      if Assigned(FComboBox) then
        FComboBox.TreeUpdate(Fldr.AbsoluteID);
      if Assigned(FListView) then
        FListView.TreeUpdate(Fldr.AbsoluteID);
    finally
      FUpdating := False;
    end;
    FNodeToMonitor := Node;
    try
      AutoRefresh := StayFresh;
    finally
      FNodeToMonitor := nil;
    end;
  end;
end;

function TNTCustomShellTreeView.GetFolder(Index: Integer): TShellFolder;
begin
  Result := TShellFolder(Items[Index].Data);
end;

function TNTCustomShellTreeView.SelectedFolder: TShellFolder;
begin
  Result := nil;
  if Selected <> nil then Result := TShellFolder(Selected.Data);
end;

function TNTCustomShellTreeView.GetPath: String;
begin
  if SelectedFolder <> nil then
    Result := SelectedFolder.PathName
  else
    Result := '';
end;

procedure TNTCustomShellTreeView.SetPath(const Value: string);
var
  P: PWideChar;
  NewPIDL: PItemIDList;
  Flags,
  NumChars: LongWord;
begin
  NumChars := Length(Value);
  if NumChars = 0 then Exit;
  Flags := 0;
  P := StringToOleStr(Value);
  if DesktopShellFolder.ParseDisplayName(0, nil, P, NumChars, NewPIDL, Flags) = S_OK then
  begin
// Kostas: this line causes bug (not setting path)
//    FUpdating := True;
    SetPathFromID(NewPIDL);
// Kostas: this line causes bug (not setting path)
//  FUpdating := False;
  end;
end;

procedure TNTCustomShellTreeView.SetPathFromID(ID: PItemIDList);
var
  I: Integer;
  Pidls: TList;
  Temp, Node: TTreeNode;
begin
  if FUpdating or (csLoading in ComponentState)
    or ((SelectedFolder <> nil) and SamePIDL(SelectedFolder.AbsoluteID, ID)) then Exit;
  FUpdating := True;
  Items.BeginUpdate;
  try
    Pidls := CreatePIDLList(ID);
    try
      Node := Items[0];
      for I := 0 to Pidls.Count-1 do
      begin
        Temp := FolderExists(Pidls[I], Node);
        if Temp <> nil then
        begin
          Node := Temp;
          Node.Expand(False);
        end;
      end;
      Node := FolderExists(ID, Node);
      Selected := Node;
      if Assigned(Node) then
      begin
        if Assigned(FListView) then
          FListView.TreeUpdate(TShellFolder(Node.Data).AbsoluteID);
        if Assigned(FComboBox) then
          FComboBox.TreeUpdate(TShellFolder(Node.Data).AbsoluteID);
      end;
    finally
      DestroyPIDLList(Pidls);
    end;
  finally
    Items.EndUpdate;
    FUpdating := False;
  end;
end;

procedure TNTCustomShellTreeView.SetRoot(const Value: TRoot);
begin
  if not SameText(FRoot, Value) then
  begin
    FOldRoot := FRoot;
    FRoot := Value;
    RootChanged;
  end;
end;

procedure TNTCustomShellTreeView.GetImageIndex(Node: TTreeNode);
begin
  if Assigned(Images) then
    inherited GetImageIndex(Node);
end;

procedure TNTCustomShellTreeView.GetSelectedIndex(Node: TTreeNode);
begin
  if Assigned(Images) then
    inherited GetSelectedIndex(Node);
end;

procedure TNTCustomShellTreeView.WndProc(var Message: TMessage);
var
  ImageListHandle: THandle;
begin
  case Message.Msg of
    WM_INITMENUPOPUP,
    WM_DRAWITEM,
    WM_MENUCHAR,
    WM_MEASUREITEM:
      if Assigned(ICM2) then
      begin
        ICM2.HandleMenuMsg(Message.Msg, Message.wParam, Message.lParam);
        Message.Result := 0;
      end;

    TVM_SETIMAGELIST:
      if not FImageListChanging then
      begin
        FImageListChanging := True;
        try
         if not Assigned(Images) then
           if FUseShellImages then
             ImageListHandle := FImages
           else
             ImageListHandle := 0
         else
           ImageListHandle := Images.Handle;

           SendMessage(Self.Handle, TVM_SETIMAGELIST, TVSIL_NORMAL, ImageListHandle);
           //RootChanged;
        finally
          FImageListChanging := False;
        end;
      end
      else inherited;
  else
    inherited WndProc(Message);
  end;
end;

procedure TNTCustomShellTreeView.SetUseShellImages(const Value: Boolean);
var
  ImageListHandle: THandle;
begin
  FUseShellImages := Value;
  if not Assigned(Images) then
    if FUseShellImages then
      ImageListHandle := FImages
    else
      ImageListHandle := 0
  else
    ImageListHandle := Images.Handle;
  SendMessage(Handle, TVM_SETIMAGELIST, TVSIL_NORMAL, ImageListHandle);
end;

procedure TNTCustomShellTreeView.WMDestroy(var Message: TWMDestroy);
begin
  ClearItems;
  inherited;
end;

procedure TNTCustomShellTreeView.Loaded;
begin
  inherited Loaded;
  CreateRoot;
end;

procedure TNTCustomShellTreeView.DoContextPopup(MousePos: TPoint;
  var Handled: Boolean);
begin
  if AutoContextMenus and not (Assigned(PopupMenu) and PopupMenu.AutoPopup) then
    InvokeContextMenu(Self, SelectedFolder, MousePos.X, MousePos.Y)
  else
    inherited;
end;

procedure TNTCustomShellTreeView.SetComboBox(Value: TNTCustomShellComboBox);
begin
  if Value = FComboBox then Exit;
  if Value <> nil then
  begin
    Value.Root := Root;
    Value.FTreeView := Self;
  end else
    if FComboBox <> nil then
      FComboBox.FTreeView := nil;

  if FComboBox <> nil then
    FComboBox.FreeNotification(Self);
  FComboBox := Value;
end;

procedure TNTCustomShellTreeView.SetListView(const Value: TNTCustomShellListView);
begin
  if Value = FListView then Exit;
  if Value <> nil then
  begin
    Value.Root := Root;
    Value.FTreeView := Self;
  end else
    if FListView <> nil then
      FListView.FTreeView := nil;

  if FListView <> nil then
    FListView.FreeNotification(Self);
  FListView := Value;
end;

procedure TNTCustomShellTreeView.SetAutoRefresh(const Value: boolean);
begin
  FAutoRefresh := Value;
  if not (csLoading in ComponentState) then
  begin
    if FAutoRefresh then
    begin
      if Assigned(FNotifier) then
        FreeAndNil(FNotifier);
      FNotifier := TNTShellChangeNotifier.Create(Self);
      FNotifier.FComponentStyle := FNotifier.FComponentStyle + [ csSubComponent ];
      FNotifier.WatchSubTree := False;
      if Assigned(FNodeToMonitor) then
        FNotifier.Root := TShellFolder(FNodeToMonitor.Data).PathName
      else
        FNotifier.Root := FRootFolder.PathName;
      FNotifier.OnChange := Self.RefreshEvent;
    end
    else if Assigned(FNotifier) then
      FreeAndNil(FNotifier);
  end;
end;

procedure TNTCustomShellTreeView.SetFileMask(const Value: string);
begin
//  if FileMask = '' then FileMask := '';
  if FFileMask <> Value then
  begin
    FFileMask := Value;
    Reset;
  end;
end;

procedure TNTCustomShellTreeView.Reset;
begin
  if Items.Count > 0 then Refresh(Items[0]);
end;

procedure TNTCustomShellTreeView.DoDeleteFile(Node: TTreeNode);
begin
  if Assigned(FOnDeleteFile) then FOnDeleteFile(Self, Node);
end;

procedure TNTCustomShellTreeView.DoCanDeleteFile(Node: TTreeNode; var CanDelete: boolean);
begin
  if Assigned(FOnCanDeleteFile) then FOnCanDeleteFile(Self, Node, CanDelete);
end;

procedure TNTCustomShellTreeView.DoStartDrag(var DragObject: TDragObject);
begin
  inherited;
  if Assigned(Selected) then FDragFolder := Selected.Data;
end;

procedure TNTCustomShellTreeView.DragDrop(Source: TObject; X, Y: Integer);
var
  Node : TTreeNode;
  Fldr, DragFldr : TShellFolder;
  NewName : string;
  CanCopy : boolean;
begin
  inherited;
  if Assigned(Source) then if Source is TNTCustomShellTreeView then
  begin
    DragFldr := (Source as TNTCustomShellTreeView).FDragFolder;
    Node := GetNodeAt(X, Y);
    if Assigned(Node) then Fldr := TShellFolder(Node.Data)
    else Fldr := nil;
    if Assigned(Fldr) and Assigned(DragFldr) then if Assigned(DragFldr.Parent) then
    begin
      if not Fldr.IsFolder and Assigned(Fldr.Parent) then if Fldr.Parent.IsFolder then Fldr := Fldr.Parent;
      if (fpFileSystem in DragFldr.Properties) and not(fpFileSystemAncestor in DragFldr.Properties) then
      begin
        NewName := Fldr.PathName + '\' + ExtractFileName(DragFldr.PathName);
        CanCopy := True;
        if FileExists(NewName) then
          if MessageDlg('File ' + NewName + ' already exists. Ovewrite?', mtWarning, mbOKCancel, 0) <> mrOK then
            CanCopy := False;
        if CanCopy then
          if CopyFile(PChar(DragFldr.PathName), PChar(NewName), False) then
            Refresh(NodeByFolder(Fldr.Parent));
      end;
    end;
  end;
end;

procedure TNTCustomShellTreeView.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  Node : TTreeNode;
  Fldr, DragFldr : TShellFolder;
begin
  inherited;
  Accept := False;
  if Assigned(Source) then if Source is TNTCustomShellTreeView then
  begin
    DragFldr := (Source as TNTCustomShellTreeView).FDragFolder;
    Node := GetNodeAt(X, Y); Fldr := nil;
    if Assigned(Node) then Fldr := TShellFolder(Node.Data);
    if Assigned(Fldr) and Assigned(DragFldr) then if Assigned(DragFldr.Parent) then
    begin
      if not Fldr.IsFolder and Assigned(Fldr.Parent) then if Fldr.Parent.IsFolder then Fldr := Fldr.Parent;
      Accept := Fldr.IsFolder and (Fldr.AbsoluteID <> DragFldr.Parent.AbsoluteID)
        and (fpFileSystem in DragFldr.Properties) and not(fpFileSystemAncestor in DragFldr.Properties);
    end;
  end;
end;

procedure TNTCustomShellTreeView.DoEndDrag(Target:TObject; X, Y: Integer);
begin
  inherited;
  FDragFolder := nil;
end;

function TNTCustomShellTreeView.NodeByFolder(
  Folder: TShellFolder): TTreeNode;
var
  i : integer;
begin
  Result := nil;
  for i := 0 to Items.Count - 1 do
    if Items[i].Data = Folder then
    begin
      Result := Items[i];
      Break;
    end;
end;

procedure TNTCustomShellTreeView.WM_DropFiles(var Msg: TWMDropFiles);
var
  Count, Size, i : integer;
  FileName, NewName : string;
  P : TPoint;
  Node : TTreeNode;
  CanCopy, Copied, YesAll, NoAll, Cancel : boolean;
  Fldr : TShellFolder;
begin
  inherited;
  try
    Copied := False;
    DragQueryPoint(Msg.Drop, P);
    Node := GetNodeAt(P.X, P.Y);
    Count := DragQueryFile(Msg.Drop, $FFFFFFFF, nil, 0);
    if Assigned(Node) then Fldr := Node.Data
    else Fldr := nil;
    if Assigned(Fldr) then
    begin
      if not Fldr.IsFolder and Assigned(Fldr.Parent) then if Fldr.Parent.IsFolder then Fldr := Fldr.Parent;
      Copied := False;
      Cancel := False;
      YesAll := False; NoAll := False;
      for i := 0 to Count - 1 do
      begin
        if Cancel then Break;
        Size := DragQueryFile(Msg.Drop, i, nil, 0);
        SetLength(FileName, Size);
        DragQueryFile(Msg.Drop, i, PChar(FileName), Size + 1);
        NewName := Fldr.PathName + '\' + ExtractFileName(FileName);
        begin
          CanCopy := True;
          if FileExists(NewName) then
          begin
            if not(YesAll or NoAll) then
            case MessageDlg('File ' + NewName + ' already exists. Ovewrite?', mtWarning, mbYesAllNoAllCancel, 0) of
              mrNo: CanCopy := False;
              mrYesToAll: YesAll := True;
              mrNoToAll: NoAll := True;
              mrCancel: begin CanCopy := False; Cancel := True; end;
            end;
            if NoAll then CanCopy := False;
          end;
          if CanCopy then
            if CopyFile(PChar(FileName), PChar(NewName), False) then
              Copied := True;
        end;
      end;
    end;
    if Copied then Refresh(NodeByFolder(Fldr.Parent));
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TNTCustomShellTreeView.SM_RefreshNode(var Msg: TNodeMessage);
begin
  if Assigned(Msg.Node) then Refresh(Msg.Node)
  else Reset;
end;

procedure TNTCustomShellTreeView.PostRefresh(Node: TTreeNode);
begin
  PostMessage(Handle, NTShellCtrls.SM_REFRESHNODE, integer(Node), 0);
end;

procedure TNTCustomShellTreeView.NewFolder(FolderName: string = ''; EditName: boolean = True; ParentNode: TTreeNode = nil);
var
  Fldr : TShellFolder;
  ParentPathName, NewPathName : string;
  i : integer;
begin
  if not Assigned(ParentNode) then if Assigned(Selected.Parent) then ParentNode := Selected.Parent;
  if Assigned(ParentNode) then
  begin
    Fldr := ParentNode.Data;
    if Assigned(Fldr) then if not Fldr.IsFolder then
    begin Fldr := Fldr.Parent; ParentNode := ParentNode.Parent; end;
    if Assigned(ParentNode) and Assigned(Fldr) then if Fldr.IsFolder then
    try
      if FolderName = '' then FolderName := 'New Folder';
      ParentPathName := Fldr.PathName;
      if ParentPathName[Length(ParentPathName)] = '\' then SetLength(ParentPathName, Length(ParentPathName) - 1);
      NewPathName := ParentPathName + '\' + FolderName;
      if DirectoryExists(NewPathName) then
      for i := 2 to 32000 do
      begin
        NewPathName := ParentPathName + '\' + FolderName + ' (' + IntToStr(i) + ')';
        if not DirectoryExists(NewPathName) then Break;
      end;
      CreateDir(NewPathName);
    finally
      ParentNode := Refresh(ParentNode);
      if EditName then
        for i := 0 to ParentNode.Count - 1 do
          if TShellFolder(ParentNode.Item[i].Data).PathName = NewPathName then
          begin
            ParentNode.Item[i].EditText;
            Break;
          end;
    end;
  end;
end;

procedure TNTCustomShellTreeView.DoRenameFile(Node: TTreeNode);
begin
  if Assigned(FOnRenameFile) then FOnRenameFile(Self, Node);
end;

procedure TNTCustomShellTreeView.RenameFileItem;
begin
  if Assigned(Selected) then Selected.EditText;
end;

procedure TNTCustomShellTreeView.ExecuteCommand(Verb: string);
var
  SEI : TShellExecuteInfo;
  Del : boolean;
  Cut : boolean;
  CanDel : boolean;
  Fldr : TShellFolder;
begin
  if Assigned(Selected) then if Assigned(Selected.Data) then
  begin
    Fldr := Selected.Data;
    Del := AnsiSameText(Verb, SCmdVerbDelete);
    Cut := AnsiSameText(Verb, SCmdVerbCut);
    if Del or Cut then
    begin
      CanDel := True;
      DoCanDeleteFile(Selected, CanDel);
      if not CanDel then
        Exit;
    end;
    if Del then
    begin
      if MessageDlg(Format(SFeleteFileConfirm, [TShellFolder(Selected.Data).PathName]), mtWarning, mbOKCancel, 0) <> mrOK then
        Exit;
      FDisableChanging := True;
      FNextNode := Selected.GetNext;
      if not Assigned(FNextNode) then FNextNode := Selected.GetPrev;
      if not Assigned(FNextNode) and (Items.Count > 0) then FNextNode := Items[0];
    end
    else if Cut or AnsiSameText(Verb, SCmdVerbCopy) or AnsiSameText(Verb, SCmdVerbPaste) then
      CutOff;
    if AnsiSameText(Verb, SCmdVerbPaste) and not Fldr.IsFolder then 
      if Assigned(Selected.Parent) then if Assigned(Selected.Parent.Data) then
        Fldr := TShellFolder(Selected.Parent.Data);
    try
      FillChar(SEI, SizeOf(SEI), 0);
      with SEI, Fldr do
      begin
        cbSize := SizeOf(SEI);
        wnd := Application.Handle;
        fMask := SEE_MASK_INVOKEIDLIST;
        lpIDList := AbsoluteID;
        lpVerb := PChar(Verb);
      end;
      ShellExecuteEx(@SEI);
    finally
      if Del then
      begin
        TShellFolder(Selected.Data).Free; Selected.Data := nil;
        Selected.Delete;
        FDisableChanging := False;
        if Assigned(FNextNode) then
        begin
          FNextNode.Selected := True;
          FNextNode := nil;
        end;
      end
      else if Cut then Selected.Cut := True
      else if AnsiSameText(Verb, SCmdVerbPaste) then
      begin
        if Assigned(Selected) and Assigned(Selected.Parent) then
          PostRefresh(Selected.Parent)
        else
          PostRefresh(Selected)
      end;
    end;
  end;
end;

procedure TNTCustomShellTreeView.CutOff;
var
  Node : TTreeNode;
begin
  if Items.Count > 0 then
  begin
    Node := Items[0];
    while Assigned(Node) do
    begin
      if Node.Cut then
      begin
        Node.Cut := False;
      end;
      Node := Node.GetNext;
    end;
  end;
end;

{ TNTCustomShellComboBox }

constructor TNTCustomShellComboBox.Create(AOwner: TComponent);
var
  FileInfo: TSHFileInfo;
begin
  inherited Create(AOwner);
  FRootFolder := nil;
  FImages := SHGetFileInfo('C:\',    { Do not localize }
    0, FileInfo, SizeOf(FileInfo), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  ImageList_GetIconSize(FImages, FImageWidth, FImageHeight);
  FUpdating := False;
  Style := csExDropDown;
  FObjectTypes := [otFolders];
  FRoot := SRFDesktop;
  FUseShellImages := True;
end;
procedure TNTCustomShellComboBox.ClearItems;
var
  I: Integer;
begin
  ItemsEx.BeginUpdate;
  try
    for I := 0 to ItemsEx.Count-1 do
    begin
      if Assigned(Folders[i]) then
        Folders[I].Free;
      if not (csDestroying in ComponentState) then
        ItemsEx[I].Data := nil;
    end;
    ItemsEx.Clear;
  finally
    ItemsEx.EndUpdate;
  end;    
end;

procedure TNTCustomShellComboBox.CreateRoot;
var
  AFolder: TShellFolder;
  Text: string;
  ImageIndex: integer;
begin
  if (csLoading in ComponentState) then Exit;
  ItemsEx.BeginUpdate;
  try
    ClearItems;
    FRootFolder := CreateRootFolder(FRootFolder, FOldRoot, FRoot);
    AFolder := TShellFolder.Create(nil,
                              FRootFolder.AbsoluteID,
                              FRootFolder.ShellFolder);
    Text := AFolder.DisplayName; //! PathName;

    ImageIndex := GetShellImageIndex(AFolder);
    ItemsEx.AddItem(Text, ImageIndex, ImageIndex,
      -1, 0, AFolder);
    Init;
    ItemIndex := 0;
    if FUseShellImages then // Force image update
    begin
      SetUseShellImages(False);
      SetUseShellImages(True);
    end;
  finally
    ItemsEx.EndUpdate;
  end;    
end;

procedure TNTCustomShellComboBox.CreateWnd;
begin
  inherited CreateWnd;
  if FImages <> 0 then
    SendMessage(Handle, CBEM_SETIMAGELIST, 0, FImages);
  SetUseShellImages(FUseShellImages);
  if ItemsEx.Count = 0 then
    CreateRoot;
end;

procedure TNTCustomShellComboBox.DestroyWnd;
begin
  ClearItems;
  inherited DestroyWnd;
end;

procedure TNTCustomShellComboBox.SetObjectTypes(Value: TShellObjectTypes);
begin
  FObjectTypes := Value;
  RootChanged;
end;

procedure TNTCustomShellComboBox.TreeUpdate(NewPath: PItemIDList);
begin
  if FUpdating or ((ItemIndex > -1)
    and SamePIDL(Folders[ItemIndex].AbsoluteID, NewPath)) then Exit;
  FUpdating := True;
  try
    SetPathFromID(NewPath);
  finally
    FUpdating := False;
  end;
end;

procedure TNTCustomShellComboBox.SetTreeView(Value: TNTCustomShellTreeView);
begin
  if Value = FTreeView then Exit;
  if Value <> nil then
  begin
    Value.Root := Root;
    Value.FComboBox := Self;
  end else
    if FTreeView <> nil then
      FTreeView.FComboBox := nil;

  if FTreeView <> nil then
    FTreeView.FreeNotification(Self);
  FTreeView := Value;
end;

procedure TNTCustomShellComboBox.SetListView(Value: TNTCustomShellListView);
begin
  if Value = FListView then Exit;
  if Value <> nil then
  begin
    Value.Root := Root;
    Value.FComboBox := Self;
  end else
    if FListView <> nil then
      FListView.FComboBox := nil;

  if FListView <> nil then
    FListView.FreeNotification(Self);
  FListView := Value;
end;

procedure TNTCustomShellComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FTreeView) then
      FTreeView := nil
    else if (AComponent = FListView) then
      FListView := nil
    else if (AComponent = FImageList) then
      FImageList := nil;
  end;    
end;

function TNTCustomShellComboBox.GetFolder(Index: Integer): TShellFolder;
begin
  if Index > ItemsEx.Count - 1 then
    Index := ItemsEx.Count - 1;
  Result := TShellFolder(ItemsEx[Index].Data);
end;

function TNTCustomShellComboBox.InitItem(ParentFolder: TShellFolder; ID: PItemIDList): TShellFolder;
var
  SF: IShellFolder;
begin
  SF := GetIShellFolder(ParentFolder.ShellFolder, ID);
  Result := TShellFolder.Create(ParentFolder, ID, SF);
end;

var
  CompareFolder: TShellFolder = nil;

function ListSortFunc(Item1, Item2: Pointer): Integer;
const
  R: array[Boolean] of Byte = (0, 1);
begin
  Result := 0;
  if (Item1 = nil) or (Item2 = nil) then Exit;

  Result := R[TShellFolder(Item2).IsFolder] - R[TShellFolder(Item1).IsFolder];
  if (Result = 0) and (TShellFolder(Item1).ParentShellFolder <> nil) then
    Result := Smallint(
                  TShellFolder(Item1).ParentShellFolder.CompareIDs(
                  0,
                  TShellFolder(Item1).RelativeID,
                  TShellFolder(Item2).RelativeID)
              );
end;

function ComboSortFunc(Item1, Item2: Pointer): Integer;
begin
  Result := 0;
  if CompareFolder = nil then Exit;
  Result := SmallInt(CompareFolder.ShellFolder.CompareIDs(0,
    PItemIDList(Item1), PItemIDList(Item2)));
end;

procedure TNTCustomShellComboBox.AddItems(Index: Integer; ParentFolder: TShellFolder);
var
  EnumList: IEnumIDList;
  ID: PItemIDList;
  ImageIndex: integer;
  Item: TComboExItem;
  NumIDs: integer;
  List: TList;
  ItemText: string;
  AFolder: TShellFolder;
begin
  OLECheck(ParentFolder.ShellFolder.EnumObjects(0, ObjectFlags(FObjectTypes), EnumList));
  CompareFolder := ParentFolder;
  List := nil;
  ItemsEx.BeginUpdate;
  try
    List := TList.Create;
    while EnumList.Next(1, ID, LongWord(NumIDs)) = S_OK do
      List.Add(ID);
    List.Sort(ComboSortFunc);

    for NumIDs := 0 to List.Count-1 do
    begin
      AFolder := InitItem(ParentFolder, List[NumIDs]);
      ItemText := AFolder.DisplayName;
      Item := ItemsEx.Insert(NumIDs+1);
      Item.Caption := ItemText;
      Item.Data := AFolder;
      Item.Indent := AFolder.Level;
      Item.ImageIndex := GetShellImageIndex(AFolder);
      Item.SelectedImageIndex := Item.ImageIndex;

      if Assigned(FOnGetImageIndex) and (Assigned(FImageList) or FUseShellImages) then
      begin
        ImageIndex := ItemsEx[NumIDs+1].ImageIndex;
        FOnGetImageIndex(Self, NumIDs+1, ImageIndex);
        ItemsEx[NumIDs+1].ImageIndex := ImageIndex;
      end;
    end;

  finally
    CompareFolder := nil;
    List.Free;
    ItemsEx.EndUpdate;
  end;
end;

procedure TNTCustomShellComboBox.Init;
var
  MyComputer: PItemIDList;
  Index: Integer;
begin
  //show desktop contents, expand My Computer if at desktop.
  //!!!otherwise expand the root.
  ItemsEx.BeginUpdate;
  try
    AddItems(0, FRootFolder);

    if Root = SRFDesktop then
    begin
      SHGetSpecialFolderLocation(0, CSIDL_DRIVES, MyComputer);
      Index := IndexFromID(MyComputer);
      if Index <> -1 then
        AddItems(Index, Folders[Index]);
    end;
  finally
    ItemsEx.EndUpdate;
  end;    
end;

function TNTCustomShellComboBox.IndexFromID(AbsoluteID: PItemIDList): Integer;
begin
  Result := ItemsEx.Count-1;
  while Result >= 0 do
  begin
    if DesktopShellFolder.CompareIDs(
      0,
      AbsoluteID,
      Folders[Result].AbsoluteID) = 0 then Exit;
    Dec(Result);
  end;
end;

procedure TNTCustomShellComboBox.SetRoot(const Value: TRoot);
begin
  if not SameText(FRoot, Value) then
  begin
    FOldRoot := FRoot;
    FRoot := Value;
    RootChanged;
  end;
end;

procedure TNTCustomShellComboBox.RootChanged;
begin
  FUpdating := True;
  try
    ClearItems;
    CreateRoot;
    if Assigned(FTreeView) then
      FTreeView.SetRoot(FRoot);
    if Assigned(FListView) then
      FListView.SetRoot(FRoot);
  finally
    FUpdating := False;
  end;
end;

function TNTCustomShellComboBox.GetPath: string;
var
  Folder : TShellFolder;
begin
  Result := '';
  if ItemIndex > -1 then
  begin
    Folder := Folders[ItemIndex];
    if Assigned(Folder) then
      Result := Folder.PathName
    else
      Result := '';  
  end;
end;

procedure TNTCustomShellComboBox.SetPath(const Value: string);
var
  P: PWideChar;
  NewPIDL: PItemIDList;
  Flags,
  NumChars: LongWord;
begin
  NumChars := Length(Value);
  Flags := 0;
  P := StringToOleStr(Value);
  try
    OLECheck(DesktopShellFolder.ParseDisplayName(0, nil, P, NumChars,
      NewPIDL, Flags));
    SetPathFromID(NewPIDL);
  except
    on EOleSysError do
      raise EInvalidPath.CreateFmt(SErrorSettingPath, [Value]);
  end;
end;

procedure TNTCustomShellComboBox.SetPathFromID(ID: PItemIDList);
var
  Pidls: TList;
  I, Item, Temp: Integer;
  AFolder: TShellFolder;
  RelID: PItemIDList;

  procedure InsertItemObject(Position: integer; Text: string; AFolder: TShellFolder);

  var
    Item : TComboExItem;
  begin
    Item := ItemsEx.Insert(Position);
    Item.Caption := Text;
    Item.Indent := AFolder.Level;
    Item.Data := AFolder;
    if AFolder = nil then
      Item.Data := AFolder;
    Item.ImageIndex := GetShellImageIndex(AFolder);
  end;

begin
  Item := -1;
  ItemsEx.BeginUpdate;
  try
    CreateRoot;
    Pidls := CreatePIDLList(ID);
    try
      I := Pidls.Count-1;
      while I >= 0 do
      begin
        Item := IndexFromID(Pidls[I]);
        if Item <> -1 then Break;
        Dec(I);
      end;

      if I < 0 then Exit;

      while I < Pidls.Count-1 do
      begin
        Inc(I);
        RelID := RelativeFromAbsolute(Pidls[I]);
        AFolder := InitItem(Folders[Item], RelID);
        InsertItemObject(Item+1, AFolder.DisplayName, AFolder);
        Inc(Item);
      end;

      Temp := IndexFromID(ID);
      if Temp < 0 then
      begin
        RelID := RelativeFromAbsolute(ID);
        AFolder := InitItem(Folders[Item], RelID);
        Temp := Item + 1;
        InsertItemObject(Item+1, AFolder.DisplayName, AFolder);
      end;
      ItemIndex := Temp;
    finally
      DestroyPIDLList(Pidls);
    end;
  finally
    ItemsEx.EndUpdate;
  end;
end;

function TNTCustomShellComboBox.GetShellImageIndex(
  AFolder: TShellFolder): integer;
begin
  if FUseShellImages then
    Result := GetShellImage(AFolder.AbsoluteID, False, False)
  else
    Result := -1;
end;

procedure TNTCustomShellComboBox.SetUseShellImages(const Value: Boolean);
var
  ImageListHandle: THandle;
begin
  FUseShellImages := Value;
  if not Assigned(Images) then
    if FUseShellImages then
      ImageListHandle := FImages
    else
      ImageListHandle := 0
  else
    ImageListHandle := Images.Handle;
  SendMessage(Handle, CBEM_SETIMAGELIST, 0, ImageListHandle);
  
  if FUseShellImages and not Assigned(FImageList) then
    ImageList_GetIconSize(FImages, FImageWidth, FImageHeight)
  else
    if not Assigned(FImageList) then
    begin
      FImageWidth := 16;
      FImageHeight := 16;
    end
    else
    begin
      FImageWidth := FImageList.Width;
      FImageHeight := FImageList.Height;
    end;
end;

destructor TNTCustomShellComboBox.Destroy;
begin
  if FRootFolder <> nil then
    FRootFolder.Free;
  ClearItems;
  inherited Destroy;
  if Assigned(FImageList) then FImageList.Free;
end;

procedure TNTCustomShellComboBox.Loaded;
begin
  inherited Loaded;
  CreateRoot;
end;

type
  TAccessItemUpdateCount = class(TComboExItems);

procedure TNTCustomShellComboBox.Change;
var
  Node : TShellFolder;
begin
  if TAccessItemUpdateCount(ItemsEx).UpdateCount > 0 then Exit;

  inherited Change;
  if (ItemIndex > -1) and (not FUpdating) and (not DroppedDown) then
  begin
    FUpdating := True;
    try
      Node := Folders[ItemIndex];
      if Assigned(Node) then
      begin
        if Assigned(FTreeView) then
          FTreeView.SetPathFromID(Node.AbsoluteID);
        if Assigned(FListView) then
          FListView.TreeUpdate(Node.AbsoluteID);
      end;
    finally
      FUpdating := False;
    end;
  end;
end;

procedure TNTCustomShellComboBox.Click;
var
  Temp: PItemIDList;
begin
  FUpdating := True;
  try
    Temp := CopyPIDL(Folders[ItemIndex].AbsoluteID);
    //Folder will be destroyed when removing the lower level ShellFolders.
    try
      SetPathFromID(Temp);
      inherited;
    finally
     DisposePIDL(Temp);
    end;
  finally
    FUpdating := False;
  end;    
end;

{ TNTCustomShellListView }

constructor TNTCustomShellListView.Create(AOwner: TComponent);
var
  FileInfo: TSHFileInfo;
begin
  inherited Create(AOwner);

  FFileMasks := TStringList.Create;
  FFileMasks.Add('*.mdt');
  FExecutableFiles := true;
  FRootFolder := nil;
  OwnerData := True;
  FSorted := True;
//  FObjectTypes := [otFolders, otNonFolders,otStorage];  //!!!
 FObjectTypes :=  [otFolders, otNonFolders, otHidden,otINIT_ON_FIRST_NEXT,otNETPRINTERSRCH ,otSHAREABLE,otStorage,otNAVIGATION_ENUM,otFASTITEMS,otFLATLIST,otENABLE_ASYNC,otINCLUDESUPERHIDDEN];
  FAutoContext := True;
  FAutoNavigate := True;
  FAutoRefresh := False;
  FFolders := TList.Create;
  FTreeView := nil;
  FUpdating := False;
  FSettingRoot :=False;
  FSmallImages := SHGetFileInfo('C:\', { Do not localize }
    0, FileInfo, SizeOf(FileInfo), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  FLargeImages := SHGetFileInfo('C:\', { Do not localize }
    0, FileInfo, SizeOf(FileInfo), SHGFI_SYSICONINDEX or SHGFI_LARGEICON);
  FRoot := SRFDesktop;
  HideSelection := False;
end;

destructor TNTCustomShellListView.Destroy;
begin
  if FRootFolder <> nil then
    FRootFolder.Free;
  ClearItems;
  FFolders.Free;
  FFileMasks.Free;
  inherited;
end;

procedure TNTCustomShellListView.ClearItems;
var
  I: Integer;
begin
  if not (csDestroying in ComponentState) then
    Items.Count := 0;
  for I := 0 to FFolders.Count-1 do
    if Assigned(Folders[i]) then
      Folders[I].Free;

  FFolders.Clear;
end;

procedure TNTCustomShellListView.CommandCompleted(Verb: String;
  Succeeded: Boolean);
begin
  if not Succeeded then Exit;
  if SameText(Verb, SCmdVerbDelete) or SameText(Verb, SCmdVerbPaste) then
    Refresh
  else if SameText(Verb, SCmdVerbOpen) then
    SetCurrentDirectory(PChar(FSavePath));
end;

procedure TNTCustomShellListView.ExecuteCommand(Verb: String;
  var Handled: Boolean);
var
  szPath: array[0..MAX_PATH] of char;
begin
  if SameText(Verb, SCmdVerbRename) then
  begin
    EditText;
    Handled := True;
  end
  else if SameText(Verb, SCmdVerbOpen) then
  begin
    GetCurrentDirectory(MAX_PATH, szPath);
    FSavePath := StrPas(szPath);
    StrPCopy(szPath, ExtractFilePath(Folders[Selected.Index].PathName));
    SetCurrentDirectory(szPath);
  end;
end;

procedure TNTCustomShellListView.CreateWnd;
begin
  inherited CreateWnd;
  if HandleAllocated then
  begin
    if FSmallImages <> 0 then
      SendMessage(Handle, LVM_SETIMAGELIST, LVSIL_SMALL, FSmallImages);
    if FLargeImages <> 0 then
      SendMessage(Handle, LVM_SETIMAGELIST, LVSIL_NORMAL, FLargeImages);
  end;
  CreateRoot;
  RootChanged;
end;

procedure TNTCustomShellListView.DestroyWnd;
begin
  ClearItems;
  inherited DestroyWnd;
end;

procedure TNTCustomShellListView.SetObjectTypes(Value: TShellObjectTypes);
begin
  FObjectTypes := Value;
  if not (csLoading in ComponentState) then
    RootChanged;
end;

procedure TNTCustomShellListView.RootChanged;
var
  StayFresh: boolean;
begin
  if FUpdating then Exit;

  FUpdating := True;
  try
    StayFresh := FAutoRefresh;
    AutoRefresh := False;
    SynchPaths;
    Populate;
    if ViewStyle = vsReport then EnumColumns;
    AutoRefresh := StayFresh;
  finally
    FUpdating := False;
  end;
end;

procedure TNTCustomShellListView.Populate;
var
  ID: PItemIDList;
  EnumList: IEnumIDList;
  NumIDs: LongWord;
  SaveCursor: TCursor;
  HR: HResult;
  CanAdd: Boolean;
  NewFolder: IShellFolder;
  Count: Integer;
  AFolder: TShellFolder;
  Matches: Boolean;
  i: Integer;
  str:string;
begin
// FObjectTypes :=  [otFolders, otNonFolders,{ otHidden,}otINIT_ON_FIRST_NEXT,{otNETPRINTERSRCH ,}otSHAREABLE,otStorage,otNAVIGATION_ENUM,otFASTITEMS,otFLATLIST,otENABLE_ASYNC,otINCLUDESUPERHIDDEN];
// FObjectTypes :=  [otFolders, otNonFolders,otStorage];

  if (csLoading in ComponentState) and not HandleAllocated then Exit;
  Items.BeginUpdate;
  try
    ClearItems;
    Count := 0;
    SaveCursor := Screen.Cursor;
    try
      Screen.Cursor := crHourglass;
      HR := FRootFolder.ShellFolder.EnumObjects(Application.Handle,
         ObjectFlags(FObjectTypes), EnumList);

      if HR <> 0 then Exit;

      while EnumList.Next(1, ID, NumIDs) = S_OK do
      begin
        NewFolder := GetIShellFolder(FRootFolder.ShellFolder, ID);
        AFolder := TShellFolder.Create(FRootFolder, ID, NewFolder);

        Matches := false;
        for i := 0 to FFileMasks.Count - 1 do
        begin
        str:=AFolder.PathName;
   /// test   010310
        if FFileMasks.Strings[0]<>'*.*' then    
         begin
          if MatchesMask(str, FFileMasks.Strings[i]) then   Matches := true;
         end
         else  Matches := true;
  // test
  // original            if MatchesMask(str, FFileMasks.Strings[i]) then   Matches := true;

        end;
        CanAdd := AFolder.IsFolder or Matches;
        if Assigned(FOnAddFolder) then FOnAddFolder(Self, AFolder, CanAdd);

        if CanAdd then
        begin
          Inc(Count);
          FFolders.Add(AFolder);
        end else
          AFolder.Free;
      end;
      Items.Count := Count;
      if FSorted then
      begin
        CompareFolder := FRootFolder;
        try
          FFolders.Sort(@ListSortFunc);
        finally
          CompareFolder := nil;
        end;
      end;
    finally
      Screen.Cursor := SaveCursor;
    end;
  finally
    Items.EndUpdate;
  end;
end;

procedure TNTCustomShellListView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FTreeView) then
      FTreeView := nil
    else if (AComponent = FComboBox) then
      FComboBox := nil;
  end;
end;

procedure TNTCustomShellListView.DblClick;
begin
  if FAutoNavigate and (Selected <> nil) then
    with Folders[Selected.Index] do
      if IsFolder then
        SetPathFromID(AbsoluteID)
      else
        if FExecutableFiles then
          ShellExecute(Handle, nil, PChar(PathName), nil, PChar(ExtractFilePath(PathName)), 0);
  inherited DblClick;
end;

procedure TNTCustomShellListView.EditText;
begin
  if Selected <> nil then
    ListView_EditLabel(Handle, Selected.Index);
end;

procedure TNTCustomShellListView.Edit(const Item: TLVItem);
var
  S: string;
begin
  with Item do
  begin
    if iItem >= FFolders.Count then Exit;
    if pszText <> nil then
    begin
      S := pszText;
      TShellFolder(FFolders[iItem]).Rename(S);
      ListView_RedrawItems(Handle, iItem, iItem);
    end;
  end;
end;

procedure TNTCustomShellListView.SetAutoRefresh(const Value: Boolean);
begin
  FAutoRefresh := Value;
  if not (csLoading in ComponentState) then
  begin
    if FAutoRefresh then
    begin
      if Assigned(FNotifier) then
        FreeAndNil(FNotifier);
      FNotifier := TNTShellChangeNotifier.Create(Self);
      FNotifier.FComponentStyle := FNotifier.FComponentStyle + [ csSubComponent ];
      FNotifier.WatchSubTree := False;
      FNotifier.Root := FRootFolder.PathName;
      FNotifier.OnChange := Self.Refresh;
    end
    else if Assigned(FNotifier) then
      FreeAndNil(FNotifier);
  end;
end;

procedure TNTCustomShellListView.SetRoot(const Value: TRoot);
begin
  if not SameText(Value, FRoot) then
  begin
    FOldRoot := FRoot;
    FRoot := Value;
    CreateRoot;
    FSettingRoot := True;
    RootChanged;
  end;
end;

function TNTCustomShellListView.SelectedFolder: TShellFolder;
begin
  Result := nil;
  if Selected <> nil then Result := Folders[Selected.Index];
end;

function TNTCustomShellListView.OwnerDataFetch(Item: TListItem;
  Request: TItemRequest): Boolean;

var
  AFolder: TShellFolder;
  J: integer;
begin
  Result := True;
  AFolder := Folders[Item.Index];
  if not Assigned(AFolder) then exit;

  if (Item.Index > FFolders.Count - 1) or (Item.Index < 0) then Exit;
  if irText in Request then
    Item.Caption := AFolder.DisplayName;
  if irImage in Request then
    Item.ImageIndex := AFolder.ImageIndex(ViewStyle = vsIcon);
    
  if ViewStyle <> vsReport then Exit;

  //PIDL := AFolder.FPIDL;

  AFolder.LoadColumnDetails(FRootFolder, Self.Handle, Columns.Count);
  for J := 1 to Columns.Count - 1 do
    Item.SubItems.Add(AFolder.Details[J]);

  (*
  FRootFolder.ViewHandle := Self.Handle;
  SF2 := FRootFolder.ShellFolder2;
  if Assigned(SF2) then
  begin
    // Already have name and icon, so see if we can provide details
    for J := 1 to Columns.Count - 1 do
    begin
      HR := SF2.GetDetailsOf(PIDL, J, SD);
      Item.SubItems.Add(StrRetToString(PIDL, SD.str, Format('**%x**', [HR])));
    end;
  end
  else
  begin
    ISD := FRootFolder.ShellDetails;
    if Assigned(ISD) then
    begin
      PIDL := TShellFolder(FFolders[Item.Index]).FPIDL;
      for J := 1 to Columns.Count - 1 do
      begin
        ISD.GetDetailsOf(PIDL, J, SD);
        Item.SubItems.Add(StrRetToString(PIDL, SD.str));
      end;
    end
    else if (fpFileSystem in FRootFolder.Properties) then
    begin
      GetDetailsOf(TShellFolder(FFolders[Item.Index]), FindData);
      for J := 1 to Columns.Count - 1 do
        Item.SubItems.Add(DefaultDetailColumn(FindData, J));
    end;
  end;
  (**)
end;

function TNTCustomShellListView.GetFolder(Index: Integer): TShellFolder;
begin
 if InRange(Index, 0, FFolders.Count - 1) then
   Result := TShellFolder(FFolders[Index])
  else
   Result := nil;
end;

function TNTCustomShellListView.OwnerDataFind(Find: TItemFind;
  const FindString: string; const FindPosition: TPoint; FindData: Pointer;
  StartIndex: Integer; Direction: TSearchDirection;
  Wrap: Boolean): Integer;
var
  I: Integer;
  Found: Boolean;
//OnDataFind gets called in response to calls to FindCaption, FindData,
//GetNearestItem, etc. It also gets called for each keystroke sent to the
//ListView (for incremental searching)
begin
  Result := -1;
  I := StartIndex;
  if (Find = ifExactString) or (Find = ifPartialString) then
  begin
    repeat
      if (I = FFolders.Count-1) then
        if Wrap then I := 0 else Exit;
      Found := Pos(AnsiUpperCase(FindString), AnsiUpperCase(Folders[I].DisplayName)) = 1;
      Inc(I);
    until Found or (I = StartIndex);
    if Found then Result := I-1;
  end;
end;

procedure TNTCustomShellListView.SetSorted(const Value: Boolean);
begin
  if FSorted <> Value then
  begin
    FSorted := Value;
    Populate;
  end;
end;

procedure TNTCustomShellListView.Loaded;
begin
  inherited Loaded;
  Populate;
  if csLoading in ComponentState then
    inherited Loaded;
  SetAutoRefresh(FAutoRefresh);

end;

procedure TNTCustomShellListView.DoContextPopup(MousePos: TPoint;
  var Handled: Boolean);
begin
  if FAutoContext and (SelectedFolder <> nil) then
  begin
    InvokeContextMenu(Self, SelectedFolder, MousePos.X, MousePos.Y);
    Handled := True;
  end else
    inherited;
end;

procedure TNTCustomShellListView.Back;
var
  RootPIDL: PItemIDList;
begin
  RootPIDL := CopyPIDL(FRootFolder.AbsoluteID);
  try
    StripLastID(RootPIDL);
    SetPathFromID(RootPIDL);
  finally
    DisposePIDL(RootPIDL);
  end;
end;

(*

The method I outlined previously works for me (just tested for Printers):

 - Start with the required IShellFolder interface
 - See if it supports IShellDetails
 - If not, use FShellFolder.CreateViewObject to get IShellDetails
 - If it is a normal file folder (SFGAO_FILESYSTEM) you know what to do
 - If not, call IShellDetails.GetDetailsOf on the virtual folder until
   it returns the same column name twice (gives you the column types,
   names, and count).  Use nil for the first parameter.
 - For each virtual file, call IShellDetails.GetDetailsOf the number of
   columns times passing in the PItemIDList this time to get details.

> Furthermore, I have not yet found a way to determine that a PIDL I
> happen to have is a virtual folder, or a specific virtual folder. Still
> looking for suggestions there as well.

  You can tell a normal folder using IShellFolder.GetAttributesOf and
checking for SFGAO_FILESYSTEM.  This returns false for printers, scheduled
tasks, etc.

(**)
procedure TNTCustomShellListView.EnumColumns;

var
  ColNames: TStringList;

  function AddColumn(SD: TShellDetails) : boolean;
  var
    PIDL: PItemIDList;
    ColName: string;

    function ColumnIsUnique(const Name: string): boolean;
    var
      i : integer;
    begin
      for i := 0 to ColNames.Count - 1 do
        if SameText(ColNames[i], Name) then
        begin
          Result := False;
          exit;
        end;
      Result := True;
    end;

  begin
    PIDL := nil;
    ColName := StrRetToString(PIDL, SD.Str);
    if ColName <> '' then
    begin
      Result := ColumnIsUnique(ColName);
      if Result then
        with Columns.Add do
        begin
          Caption := ColName;
          case SD.fmt of
            LVCFMT_CENTER: Alignment := taCenter;
            LVCFMT_LEFT: Alignment := taLeftJustify;
            LVCFMT_RIGHT: Alignment := taRightJustify;
          end;
          Width := SD.cxChar * Canvas.TextWidth('X');
          ColNames.Add(ColName);
        end;
    end
    else
      Result := True;
  end;

  procedure AddDefaultColumn(const ACaption: string; const AAlignment: TAlignment;
    AWidth: integer);
  begin
    with Columns.Add do
    begin
      Caption := ACaption;
      Alignment := AAlignment;
      Width := AWidth * Canvas.TextWidth('X');
    end;
  end;

  procedure AddDefaultColumns(const ColCount: integer = 1);
  begin
    if ColCount > 0 then
      AddDefaultColumn(SShellDefaultNameStr, taLeftJustify, 25);
    if ColCount > 1 then
      AddDefaultColumn(SShellDefaultSizeStr, taRightJustify, 10);
    if ColCount > 2 then
      AddDefaultColumn(SShellDefaultTypeStr, taLeftJustify, 10);
    if ColCount > 3 then
      AddDefaultColumn(SShellDefaultModifiedStr, taLeftJustify, 14);
  end;

var
  Col: Integer;
  SD: TShellDetails;
  PIDL: PItemIDList;
  SF2: IShellFolder2;
  ISD: IShellDetails;
  ColFlags: LongWord;
  Default: Boolean;
begin
  if (not Assigned(FRootFolder)) or (not Assigned(FRootFolder.ShellFolder)) then Exit;
  ColNames := TStringList.Create;
  try
    Columns.BeginUpdate;
    try
      Columns.Clear;
      Col := 0;
      PIDL := nil;
      Default := False;
      FillChar(SD, SizeOf(SD), 0);

      FRootFolder.ViewHandle := Self.Handle;
      SF2 := FRootFolder.ShellFolder2;
      if Assigned(SF2) then // Have IShellFolder2 interface
      begin
        while SF2.GetDetailsOf(PIDL, Col, SD) = S_OK do
        begin
          SF2.GetDefaultColumnState(Col, ColFlags);
          Default := Default or Boolean(ColFlags and SHCOLSTATE_ONBYDEFAULT);
          if Default and not Boolean(ColFlags and SHCOLSTATE_ONBYDEFAULT) then Exit;
          AddColumn(SD);
          Inc(Col);
        end;
      end
      else
      begin
        ISD := FRootFolder.ShellDetails;
        if Assigned(ISD) then
        begin
          while (ISD.GetDetailsOf(nil, Col, SD) = S_OK) do
          begin
            if (AddColumn(SD)) then
              Inc(Col)
            else
              Break;
          end;
        end
        else
        begin
          if (fpFileSystem in FRootFolder.Properties) then
            AddDefaultColumns(4)
          else
            AddDefaultColumns(1);
        end;
      end;

    finally
      Columns.EndUpdate;
    end;
  finally
    ColNames.Free;
  end;
end;

procedure TNTCustomShellListView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if FAutoNavigate then
    case Key of
      VK_RETURN:
        if ssAlt in Shift then
        begin
          DoContextMenuVerb(SelectedFolder, cmvProperties);
          Key := 0;
        end
        else if (SelectedFolder <> nil) then
          if SelectedFolder.IsFolder then
          begin
            SetPathFromID(SelectedFolder.AbsoluteID);
          end
          else
            SelectedFolder.ExecuteDefault;
      VK_BACK: if not IsEditing then Back;
      VK_F5: Refresh;
    end;
end;

procedure TNTCustomShellListView.SetViewStyle(Value: TViewStyle);
begin
  inherited;
  if (Value = vsReport) and not (csLoading in ComponentState) then
    EnumColumns;
end;

procedure TNTCustomShellListView.SetTreeView(Value: TNTCustomShellTreeView);
begin
  if Value = FTreeView then Exit;
  if Value <> nil then
  begin
    Value.Root := Root;
    Value.FListView := Self;
  end else
    if FTreeView <> nil then
      FTreeView.FListView := nil;

  if FTreeView <> nil then
    FTreeView.FreeNotification(Self);
  FTreeView := Value;
end;

procedure TNTCustomShellListView.SetComboBox(Value: TNTCustomShellComboBox);
begin
  if Value = FComboBox then Exit;
  if Value <> nil then
  begin
    Value.Root := Root;
    Value.FListView := Self;
  end else
    if FComboBox <> nil then
      FComboBox.FListView := nil;

  if FComboBox <> nil then
    FComboBox.FreeNotification(Self);
  FComboBox := Value;
end;

procedure TNTCustomShellListView.SetFileMasks(const Value: TStrings);
begin
//  if FileMask = '' then FileMask := '';
//  if FFileMasks <> Value then
//  begin
    FFileMasks.Assign(Value);
    if Items.Count > 0 then Refresh;
//  end;
end;

procedure TNTCustomShellListView.TreeUpdate(NewRoot: PItemIDList);
begin
  if FUpdating or (Assigned(FRootFolder)
    and SamePIDL(FRootFolder.AbsoluteID, NewRoot)) then Exit;
  SetPathFromID(NewRoot);
end;

procedure TNTCustomShellListView.WndProc(var Message: TMessage);
begin
  //to handle submenus of context menus.
  with Message do
    if ((Msg = WM_INITMENUPOPUP) or (Msg = WM_DRAWITEM) or (Msg = WM_MENUCHAR)
    or (Msg = WM_MEASUREITEM)) and Assigned(ICM2) then
    begin
      ICM2.HandleMenuMsg(Msg, wParam, lParam);
      Result := 0;
    end;
  inherited;
end;

procedure TNTCustomShellListView.Refresh;
var
  SelectedIndex: Integer;
  RootPIDL: PItemIDList;
begin
  SelectedIndex := -1;
  if Selected <> nil then SelectedIndex := Selected.Index;
  Selected := nil;
  RootPIDL := CopyPIDL(FRootFolder.AbsoluteID);
  try
    FreeAndNil(FRootFolder);
    SetPathFromID(RootPIDL);
  finally
    DisposePIDL(RootPIDL);
  end;
  if (SelectedIndex > -1) and (SelectedIndex < Items.Count - 1) then
    Selected := Items[SelectedIndex];
end;

procedure TNTCustomShellListView.SetPathFromID(ID: PItemIDList);
begin
  if FUpdating then Exit;

  if Assigned(FRootFolder) then
    if SamePIDL(FRootFolder.AbsoluteID, ID) then
      Exit // Note! Exits routine
    else
      FRootFolder.Free;

  FSettingRoot := False;
  FRootFolder := CreateRootFromPIDL(ID);
  RootChanged;
end;

procedure TNTCustomShellListView.CreateRoot;
begin
  FRootFolder := CreateRootFolder(FRootFolder, FOldRoot, FRoot);
end;

procedure TNTCustomShellListView.SynchPaths;
begin
  try
    if FSettingRoot then
    begin
      if Assigned(FTreeView) then
        FTreeView.SetRoot(FRoot);
      if Assigned(FComboBox) then
        FComboBox.SetRoot(FRoot);
    end
    else
    begin
      if Assigned(FTreeView) then
        FTreeView.SetPathFromID(FRootFolder.AbsoluteID);
      if Assigned(FComboBox) then
        FComboBox.TreeUpdate(FRootFolder.AbsoluteID);
    end;
  finally
    FSettingRoot := False;
  end;
end;


initialization

  CreateDesktopFolder;
  InitializeCriticalSection(CS);
  OleInitialize(nil);
  
finalization

  if Assigned(DesktopFolder) then
    DesktopFolder.Free;
  DeleteCriticalSection(CS);
  OleUninitialize;

end.