{* DelLoc. LcUnit.pas. Serge Gavrilov ( C ) 2005-2006 *********************** *}

unit LcUnit;

{
  DelLoc (Delphi localization compiler). Interface unit.

  All right reserved. Serge Gavrilov (C) 2005-2006.

  e-mail: sergegavrilov@mail.ru
  icq: 777807
  odigo: 471530
  http://delloc.narod.ru/en.html


  To localize your delphi program You have to make next simple things:
  1. Create with DelLoc the localization file that will
     include translations of the resourcestrings and translations of the form's
     and component's string properties.
  2. Include unit LcUnit.pas in your project or make it available in search
     pathes.
  3. In project source: after loading application call function LoadLcf() where
     pass as parameters localization file name and locale identificator (LCID)
     that will be used to translate. You may place the call of LoadLcf() in
     project source file after "begin" keyword or in the initialization section
     of the any project unit.
  4. After creating form which interface and components need to be translatad
     call function TranslateComponent() and pass as parameter the created form.
     You may place call at the body of the overrided constructor after
     "inherited" keyword or in the OnCreate event handler. If you inherites
     all project forms from one base form class you may provide call of the
     TranslateComponent() only for the base form class.

  Unit LcUnit.pas includes declaration of the two functions: LoadLcf() and
  TranslateComponent(), and declare one type: TLcCallBack.

  Function LoadLcf() loads localization file and activates translation for
  the passed locale identificator.

    function LoadLcf(
        const sFileName : string;
        iLCID : LCID;
        pCallBack : TLcCallBack;
        pUd : pointer
      ) : integer;

  Parameters:
    sFileName - localization file name;
    iLCID - locale identificator to activate. Use Delphi's class TLanguages
            to inspect all available locale identificators and its string
            descriptions.
    pCallBack - pointer to callback function of type TLcCallBack. If this
                parameter is not null then the callback function will be called
                for each locale identificator supported by the localization
                file.
    pUd - used difened pointer. Will be passed as parameter to the callback
          function pCallBack.

  Result:
    1 - localization file was loaded and translation for requeted locale
        was activated;
    0 - localization file was loaded but translation for requeted locale is
        not present in the localization file. Translation will not be make.
    <0 - localization file error loading. Translation will not be make.

  Function TranslateComponent() translate the interface and form's
  components string propertied.

    function TranslateComponent(
        oComponent : TComponent
      ) : boolean;

  Parameters:
    oComponent - Form which interface and components will be localized.
  Result:
    true - localization success;
    false - localization error.

  The type TLcCallBack is a prototype of the callback function which pointer is
  passed into LoadLcf() as parameter. The callback function will be called
  for each locale identificator supported by the localization file.

    type
      TLcCallBack = function(
                        iLCID : integer;
                        pUd : pointer
                      ) : integer; stdcall;

  Parameters:
    iLCID - locale identificator supported in localization file;
    pUd - user defined pointer passed into LoadLcf() as parameter.
  Result:
    0 - stop calling callback for the next locale ids;
    <>0 - continue the callback calls for the next locale ids.

  To switch the langauges at runtime You may use next code:

    var
      i : integer;
    begin
      for i := Screen.FormCount - 1 do TranslateComponent( Screen.Forms[ i ] );
    end;


  THIS UNIT IS DISTRIBUTED "AS IS". NO WARRANTY OF ANY KIND IS EXPRESSED
  OR IMPLIED. YOU USE AT YOUR OWN RISK. THE AUTHOR WILL NOT BE LIABLE
  FOR DATA LOSS, DAMAGES, LOSS OF PROFITS OR ANY OTHER KIND OF LOSS
  WHILE USING OR MISUSING THIS SOFTWARE.

}

{$ifdef VER130}
  {$define D_5}
{$else}
  {$define D_6plus}
{$endif}

interface

uses
  SysUtils, Windows, Classes,
  {$ifdef D_6plus}StrUtils,{$endif}
  TypInfo;

type

  TLcCallBack = function( iLCID : integer; pUd : pointer ) : integer; stdcall;

function LoadLcf(
    const sFileName : string;
    iLCID : LCID;
    pCallBack : TLcCallBack;
    pUd : pointer
  ) : integer;

function TranslateComponent( oComponent : TComponent ) : boolean;

implementation

{* ************************************************************************** *}

const
  LC_OPT_PROJINFO = 1;
  LC_SIGNATURE = 'LCHEADER';
  LC_HEADER_RESID = 'LCHEADER';
  LC_HEADE2_RESID = 'LCHEADE2';

type

{* ************************************************************************** *}

  TLcHeaderRec = packed record
    aSign : packed array[ 0..Length( LC_SIGNATURE ) - 1 ] of char;
    iOpts : integer;
    iLCIDCount : integer;
  end;
  TPLcHeaderRec = ^TLcHeaderRec;

{* ************************************************************************** *}

  TLcHeaderResRec = packed record
    rHeader : TLcHeaderRec;
    aLCID : packed array[ 0..0 ] of LCID;
  end;
  TPLcHeaderResRec = ^TLcHeaderResRec;

{* ************************************************************************** *}

  TLcCPages = packed array[ 0..0 ] of UINT;
  TPLcCPages = ^TLcCPages;

{* ************************************************************************** *}

  TLcResItemStr = packed record
    iOffset : integer;
    iLength : integer;
  end;
  TLcResItemRec = packed array[ 0..0 ] of TLcResItemStr;
  TPLcResItemRec = ^TLcResItemRec;

{* ************************************************************************** *}

type

  TProc = class
  private
    aOriginal : packed array[ 0..4 ] of byte;
    pOldProc, pNewProc : pointer;
    pPosition : PByteArray;
  public
    constructor Create( pOldProc, pNewProc : pointer );
    destructor Destroy; override;
  end;

{* ************************************************************************** *}

  TLcf = class
  private
    iLangIndex : integer;
    iPropLangIndex : integer;
    iLibHandle : THANDLE;
    iCPage : UINT;
    aProc : array[ 0..0 ] of TProc;
  public
    constructor Create;
    destructor Destroy; override;
    function LoadLib( szFileName : PChar; iLCID : LCID;
      pCallBack : TLcCallBack; pUd : pointer ) : integer;
    function GetResStringParams( iId : integer; var p : pointer ) : integer;
    function TranslateComponent( oComponent : TComponent ) : boolean;
    procedure RegProcs( pN1, pO1 : pointer );
  end;

{* ************************************************************************** *}

var

  _oLcf : TLcf = nil;

{* ************************************************************************** *}

{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
constructor TProc.Create;
var
  iOffset : integer;
  iMemProtect : cardinal;
  i : integer;
begin
  Self.pOldProc := pOldProc;
  Self.pNewProc := pNewProc;

  pPosition := pOldProc;
  iOffset := integer( pNewProc ) - integer( pointer( pPosition ) ) - 5;

  for i := 0 to 4 do aOriginal[ i ] := pPosition^[ i ];

  VirtualProtect( pointer( pPosition ), 5, PAGE_EXECUTE_READWRITE,
    @iMemProtect );

  pPosition^[ 0 ] := $E9;
  pPosition^[ 1 ] := byte( iOffset );
  pPosition^[ 2 ] := byte( iOffset shr 8 );
  pPosition^[ 3 ] := byte( iOffset shr 16 );
  pPosition^[ 4 ] := byte( iOffset shr 24 );

end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
destructor TProc.Destroy;
var
  i : integer;
begin
  for i := 0 to 4 do pPosition^[ i ] := aOriginal[ i ];
  inherited;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}

{* ************************************************************************** *}

{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
constructor TLcf.Create;
begin
  _oLcf := Self;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
destructor TLcf.Destroy;
var
  i : integer;
begin
  _oLcf := nil;
  for i := Low( aProc ) to High( aProc ) do aProc[ i ].Free;
  if iLibHandle <> 0 then FreeLibrary( iLibHandle );
  inherited;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
function LCIDToCodePage( iLCID : LCID ) : UINT;
var
  iResultCode : integer;
  p : array[ 0..6 ] of char;
begin
  GetLocaleInfo( iLCID, LOCALE_IDEFAULTANSICODEPAGE, p, sizeof( p ) );
  Val( p, result, iResultCode );
  if iResultCode <> 0 then result := CP_ACP;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
function TLcf.LoadLib;
var
  iRes : HRSRC;
  iGlobal : HGLOBAL;
  pHeader : TPLcHeaderResRec;
  i : integer;
  isOldFormat : boolean;
  pPages : TPLcCPages;
begin
  result := -1;
  iLibHandle := LoadLibraryEx( szFileName, 0,
    LOAD_LIBRARY_AS_DATAFILE or DONT_RESOLVE_DLL_REFERENCES );
  if iLibHandle = 0 then exit;
  isOldFormat := true;
  iRes := FindResource( iLibHandle, LC_HEADER_RESID, RT_RCDATA );
  if iRes = 0
  then  begin
        isOldFormat := false;
        iRes := FindResource( iLibHandle, LC_HEADE2_RESID, RT_RCDATA );
        if iRes = 0 then exit;
        end;

  iGlobal := LoadResource( iLibHandle, iRes );
  if iGlobal = 0 then exit;
  if SizeOfResource( iLibHandle, iRes ) < sizeof( TLcHeaderRec ) then exit;
  pHeader := pointer( iGlobal );
  if not CompareMem( @pHeader^.rHeader.aSign[ 0 ], @LC_SIGNATURE[ 1 ],
    Length( LC_SIGNATURE ) ) then exit;
  result := 0;
  iLangIndex := -1;
  if Assigned( pCallBack )
  then  for i := 0 to pHeader^.rHeader.iLCIDCount - 1
        do  if pCallBack( pHeader^.aLCID[ i ], pUd ) = 0 then break;
  for i := 0 to pHeader^.rHeader.iLCIDCount - 1
  do  if pHeader^.aLCID[ i ] = iLCID
      then  begin
            iLangIndex := i;
            iPropLangIndex := i;
            if not isOldFormat
            then  begin
                  pPages := pointer( integer( pHeader ) +
                    sizeof( TLcHeaderRec ) +
                      pHeader^.rHeader.iLCIDCount * sizeof( LCID ) );
                  iCPage := pPages^[ i ];
                  end
            else  iCPage := LCIDToCodePage( iLCID );
            break;
            end;
  if iLangIndex < 0 then exit;
  if ( pHeader^.rHeader.iOpts and LC_OPT_PROJINFO ) <> 0
  then  Inc( iLangIndex );
  result := 1;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
function TLcf.GetResStringParams;
var
  iRes : HRSRC;
  iGlobal : HGLOBAL;
  pResItem : TPLcResItemRec;
begin
  result := 0;
  p := nil;
  iRes := FindResource( iLibHandle,
    MAKEINTRESOURCE( IntToStr( iId ) ), RT_RCDATA );
  if iRes = 0 then exit;
  iGlobal := LoadResource( iLibHandle, iRes );
  if iGlobal = 0 then exit;
  pResItem := pointer( iGlobal );
  result := pResItem^[ iLangIndex ].iLength;
  if result < 0 then exit;
  p := @( PByteArray( pResItem )^[ pResItem^[ iLangIndex ].iOffset ] );
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
procedure TLcf.RegProcs;
begin
  if Assigned( pO1 ) and Assigned( pN1 )
  then aProc[ 0 ] := TProc.Create( pO1, pN1 );
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}

{* ************************************************************************** *}

{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
function WideStringToString( const s : WideString; iCPage : UINT ) : string;
begin
  if s = ''
  then  result := ''
  else  begin
        SetLength( result, Length( s ) );
        WideCharToMultiByte( iCPage, 0, PWideChar( s ), Length( s ),
          PChar( result ), Length( result ), nil, nil );
        end;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
function NewLoadResString( ResStringRec : PResStringRec ) : AnsiString;
const
  MAX_ID = 64 * 1024;
var
  iLen : integer;
  pBuf : pointer;
  sBuffer : array [ 0..1023 ] of char;
  wString : WideString;
begin
  if ResStringRec = nil then exit;
  if ResStringRec.Identifier >= MAX_ID
  then  begin
        Result := PChar( ResStringRec.Identifier );
        end
  else  begin
        iLen := _oLcf.GetResStringParams( ResStringRec.Identifier, pBuf );
        if ( pBuf <> nil )
        then  begin
              SetLength( wString, iLen shr 1 );
              Move( pBuf^, pointer( wString )^, iLen );
              result := WideStringToString( wString, _oLcf.iCPage );
              end
        else  begin
              SetString( Result, sBuffer,
                LoadString( FindResourceHInstance( ResStringRec.Module^ ),
                  ResStringRec.Identifier, sBuffer, SizeOf( sBuffer ) ) )
              end;
        end;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
function LoadLcf;
begin
  _oLcf.Free;
  _oLcf := TLcf.Create;
  result := _oLcf.LoadLib( PChar( sFileName ), iLCID, pCallBack, pUd );
  if result < 1
  then  begin
        _oLcf.Free; _oLcf := nil;
        exit;
        end;
  _oLcf.RegProcs( @NewLoadResString, @System.LoadResString );
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
function TranslateComponent;
begin
  result := false;
  if _oLcf = nil then exit;
  result := _oLcf.TranslateComponent( oComponent );
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}

{* ************************************************************************** *}

type

  TProp = class
  private
    oLcf : TLcf;
    sCompName : string;
    sPropName : string;
    wTranslation : WideString;
    isTranslated : boolean;
  public
    function LoadFromResource( pRes : PByteArray ) : boolean;
    procedure Translate( oComponent : TComponent );
  end;

{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}

  TProps = class
  private
    oLcf : TLcf;
    oComponent : TComponent;
    oItems : TList;
  public
    constructor Create;
    destructor Destroy; override;
    function LoadFromResource : boolean; overload;
    function LoadFromResource( oClassType : TClass ) : boolean; overload;
  end;

{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
{$ifdef D_5}
{Copy from Delphi7 source StrUtils.pas}
function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;
{$endif}
function TextToChar( const s : string; c : char;
  var iPos : integer ) : string;
var
  iNextPos : integer;
begin
  iNextPos := PosEx( c, s, iPos );
  if iNextPos = 0
  then  result := Copy( s, iPos, Length( s ) - iPos + 1 )
  else  begin
        result := Copy( s, iPos, iNextPos - iPos );
        Inc( iNextPos );
        if iNextPos > Length( s ) then iNextPos := 0;
        end;
  iPos := iNextPos;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
function TProp.LoadFromResource;
var
  sFullName : string;
  pBytes : PByteArray;
  iPos : integer;
  iLength : integer;
  iOffset : integer;
begin
  SetLength( sFullName, TPLcResItemRec( pRes )^[ 0 ].iLength );
  pBytes := pRes;
  Move( pBytes^[ TPLcResItemRec( pRes )^[ 0 ].iOffset ], sFullName[ 1 ],
    TPLcResItemRec( pRes )^[ 0 ].iLength );
    iPos := 1;
  sCompName := TextToChar( sFullName, '-', iPos );
  sPropName := TextToChar( sFullName, '-', iPos );
  iLength := TPLcResItemRec( pRes )^[ oLcf.iPropLangIndex + 1 ].iLength;
  iOffset := TPLcResItemRec( pRes )^[ oLcf.iPropLangIndex + 1 ].iOffset;
  isTranslated := iLength >= 0;
  if isTranslated
  then  begin
        SetLength( wTranslation, iLength shr 1 );
        Move( pBytes^[ iOffset ], pointer( wTranslation )^, iLength );
        end;
  result := true;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
procedure TProp.Translate;

  function FindObject( const sName : string ) : TObject;
  begin
    if SameText( sName, oComponent.Name )
    then  begin
          result := oComponent;
          exit;
          end;
    result := oComponent.FindComponent( sName );
  end;

type
  TPropTypeFromName = ( ptfnGeneral, ptfnList, ptfnCollection );

const
  AS_ENDS : array[ TPropTypeFromName ] of char = ( ' ', ')', '>' );

  function ExtractPropName(
    const sPropName : string;
    var iType : TPropTypeFromName;
    var iCollListIndex : integer ) : string;
  var
    iPos : integer;
  begin
    iType := ptfnGeneral;
    iCollListIndex := 0;
    iPos := Pos( '<', sPropName );
    if iPos >= 1
    then  begin
          iType := ptfnCollection;
          end
    else  begin
          iPos := Pos( '(', sPropName );
          if iPos >= 1
          then  begin
                iType := ptfnList;
                end
          else  begin
                result := sPropName;
                exit;
                end;
          end;
    result := Copy( sPropName, 1, iPos - 1 );
    Inc( iPos );
    iCollListIndex := StrToInt( TextToChar( sPropName, AS_ENDS[ iType ],
      iPos ) );
  end;

  function FindPropInfo(
      var oObject : TObject;
      oPropNames : TStrings;
      iIndex : integer;
      var iTypeFromName : TPropTypeFromName;
      var iCollListIndex : integer
    ) : PPropInfo;
  var
    sPropName : string;
  begin
    sPropName := ExtractPropName( oPropNames[ iIndex ],
      iTypeFromName,
        iCollListIndex );

    result := GetPropInfo( oObject.ClassInfo, sPropName );

    if ( result <> nil )
      and ( iIndex < oPropNames.Count - 1 )
    then  begin
          if ( result^.PropType^.Kind = tkClass )
          then  begin
                oObject := GetObjectProp( oObject, sPropName );
                case iTypeFromName of
                  ptfnList :
                    begin
                    result := nil;
                    end;
                  ptfnCollection :
                    begin
                    oObject := ( oObject as TCollection ).Items
                      [ iCollListIndex ];
                    if oObject <> nil
                    then  result := FindPropInfo( oObject,
                            oPropNames,
                              iIndex + 1,
                                iTypeFromName,
                                  iCollListIndex );
                    end;
                else
                  if oObject <> nil
                  then  result := FindPropInfo( oObject,
                    oPropNames,
                      iIndex + 1,
                        iTypeFromName,
                          iCollListIndex )
                  else  result := nil;
                end;
                end
          else  result := nil;
          end;
  end;

var
  oObject : TObject;
  iPos : integer;
  oPropNames : TStrings;
  pProp : PPropInfo;
  wOldTranslation : WideString;
  sOldTranslation, sTranslation : string;
  iTypeFromName : TPropTypeFromName;
  iCollListIndex : integer;
begin
  oObject := FindObject( sCompName );
  if oObject = nil then exit;
  iPos := 1;
  oPropNames := TStringList.Create;
  try
    while iPos > 0
    do  begin
        oPropNames.Add( TextToChar( sPropName, '.', iPos ) );
        end;
    pProp := FindPropInfo( oObject, oPropNames, 0,
      iTypeFromName,
        iCollListIndex );
    if ( pProp <> nil )
    then  begin
          if pProp^.PropType^.Kind in [ tkString, tkLString, tkWString ]
          then  begin
{$ifdef D_5}
                wOldTranslation := GetStrProp( oObject, pProp^.Name );
{$else}
                wOldTranslation := GetWideStrProp( oObject, pProp^.Name );
{$endif}
                if ( pProp^.SetProc <> nil )
                  and ( wOldTranslation <> wTranslation )
                then  begin
{$ifdef D_5}
                      SetStrProp( oObject, pProp^.Name, wTranslation );
{$else}
                      SetWideStrProp( oObject, pProp^.Name, wTranslation );
{$endif}
                      end;
                end;
          end
    else  begin
          if oObject = nil then exit;
          if ( oObject is TStrings ) and ( iTypeFromName = ptfnList )
          then  begin
                if ( iCollListIndex < ( oObject as TStrings ).Count )
                then  begin
                      sOldTranslation := ( oObject as TStrings )
                        [ iCollListIndex ];
                      sTranslation :=
                        WideStringToString( wTranslation, _oLcf.iCPage );
                      if sOldTranslation <> sTranslation
                      then  begin
                            ( oObject as TStrings )[ iCollListIndex ] :=
                              sTranslation;
                            end;
                      end;
                exit;
                end;
          if oObject is TCollection
          then  begin
                exit;
                end;
          end;
  finally
    oPropNames.Free;
  end;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
constructor TProps.Create;
begin
  oItems := TList.Create;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
destructor TProps.Destroy;
var
  i : integer;
begin
  for i := 0 to oItems.Count - 1 do TObject( oItems[ i ] ).Free;
  oItems.Free;
  inherited;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
function TProps.LoadFromResource : boolean;
begin
  result := LoadFromResource( oComponent.ClassType );
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
function TProps.LoadFromResource( oClassType: TClass ) : boolean;
var
  iRes : HRSRC;
  iGlobal : HGLOBAL;
  iPropCount : integer;
  oProp : TProp;
  sClassName : string;
  oClassParent : TClass;
begin             
  result := false;
  oClassParent := oClassType.ClassParent;
  if Assigned( oClassParent ) and oClassParent.InheritsFrom( TComponent )
  then  LoadFromResource( oClassParent );
  iRes := FindResource(
    oLcf.iLibHandle,
      PAnsiChar( AnsiUpperCase( oClassType.ClassName ) ), RT_RCDATA );
  if iRes = 0 then exit;
  iGlobal := LoadResource( oLcf.iLibHandle, iRes );
  if iGlobal = 0 then exit;
  SetLength( sClassName, integer( pointer( iGlobal )^ ) );
  Inc( iGlobal, sizeof( integer ) );
  Move( pointer( iGlobal )^, sClassName[ 1 ], Length( sClassName ) );
  Inc( iGlobal, Length( sClassName ) );
  iPropCount := integer( pointer( iGlobal )^ );
  Inc( iGlobal, sizeof( integer ) );
  while iPropCount > 0
  do  begin
      Dec( iPropCount );
      oProp := TProp.Create;
      oProp.oLcf := oLcf;
      if not oProp.LoadFromResource( pointer( iGlobal +
        Cardinal( TPLcResItemRec( pointer( iGlobal ) )^[ iPropCount ].
          iOffset ) ) )
      then  oProp.Free
      else  oItems.Add( oProp );
  end;
  result := true;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}
function TLcf.TranslateComponent;
var
  oProps : TProps;
  oProp : TProp;
  i : integer;
begin
  oProps := TProps.Create;
  oProps.oLcf := Self;
  oProps.oComponent := oComponent;
  try
    result := oProps.LoadFromResource;
    if not result then exit;
    for i := 0 to oProps.oItems.Count - 1
    do  begin
        oProp := oProps.oItems[ i ];
        if oProp.isTranslated then oProp.Translate( oComponent );
        end;
  finally
    oProps.Free;
  end;
end;
{* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *}

{* ************************************************************************** *}

initialization

finalization

  _oLcf.Free;

end.
