{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1995,2001 Inprise Corporation     }
{                                                       }
{*******************************************************}
unit NTShellReg platform;

interface

procedure Register;

{$R 'NTShPack.dcr'}

implementation

uses
  Classes, TypInfo, Controls,
  NTShellCtrls, NTShellConsts;

procedure Register;
begin
  GroupDescendentsWith(TNTShellChangeNotifier, Controls.TControl);
  RegisterComponents(SPalletePage,
    [TNTShellTreeView, TNTShellComboBox, TNTShellListView, TNTShellChangeNotifier]);
end;

end.
