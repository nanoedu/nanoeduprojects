unit frTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ushellfunction,shlobj,comobj,Activex,StdCtrls, Buttons;

type
  TFormTest = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTest: TFormTest;

implementation

{$R *.dfm}

procedure TFormTest.BitBtn1Click(Sender: TObject);
 var i,j:integer;
 Desktop,PCFolder:IshellFolder;
 pc:PItemIDList;
 s,name:string;
 PCPIDL:PItemIDList;
 ItemPCList:TItemListArray;
begin
  OleCheck(SHGetSpecialFolderLocation(Handle, CSIDL_DRIVES, PCPIDL));
  OleCheck(SHGetDesktopFolder(DeskTop));
  OleCheck(DeskTop.BindToObject(pcPidl, nil, IID_IShellFolder,PCFolder));
  ItemPCList:=GetShellItems(PCFolder);
  for j := 0 to length(ItemPCList) - 1 do
   begin
     Memo1.lines.add(GetShellObjectName(PCFolder, ItemPCList[j]));
   end;

end;

end.
