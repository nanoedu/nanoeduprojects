{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1995,2001 Inprise Corporation     }
{                                                       }
{*******************************************************}

unit NTShellConsts;

interface

resourcestring
  SShellDefaultNameStr = 'Name';
  SShellDefaultSizeStr = 'Size';
  SShellDefaultTypeStr = 'Type';
  SShellDefaultModifiedStr = 'Modified';
  SShellNoDetails = 'Unable to retrieve folder details for "%s". Error code $%x';
  SCallLoadDetails = '%s: Missing call to LoadColumnDetails';
  SPalletePage = 'NT-MDT Shell';
  SPropertyName = 'Root';
  SRenamedFailedError = 'Rename to %s failed';
  SFeleteFileConfirm = 'Delete file %s?';

const
  SRFDesktop = 'rfDesktop'; { Do not localize }
  SCmdVerbOpen = 'open'; { Do not localize }
  SCmdVerbRename = 'rename'; { Do not localize }
  SCmdVerbDelete = 'delete'; { Do not localize }
  SCmdVerbCut = 'cut'; { Do not localize }
  SCmdVerbCopy = 'copy'; { Do not localize }
  SCmdVerbPaste = 'paste'; { Do not localize }


implementation

end.
