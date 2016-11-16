unit frCopyScripts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;
   type TFFSHANDLE=pointer;
       PTFFSHANDLE=^TFFSHANDLE ;
// TFFS
   const   TFFS_DLL_Name = 'tffs.dll';

type
  TCopyScripts = class(TForm)
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
function tffs_open(HANDLE:PTFFSHANDLE):LONGword ;
         cdecl; External  TFFS_DLL_Name name 'tffs_open';

function tffs_close(HANDLE:TFFSHANDLE):LONGword ;
         cdecl; External  TFFS_DLL_Name name 'tffs_close';
(*
function tffs_findfirst(HANDLE:TFFSHANDLE; name:PChar; len:PLongword):LONGword ;
         cdecl; External  TFFS_DLL_Name name 'tffs_findfirst';

function tffs_findnext(HANDLE:TFFSHANDLE; name:PChar; len:PLongword):LONGword ;
         cdecl; External  TFFS_DLL_Name name 'tffs_findnext';
*)
function tffs_format(HANDLE:TFFSHANDLE):LONGINT ;
         cdecl; External  TFFS_DLL_Name name 'tffs_format';
(*
function tffs_read(HANDLE:TFFSHANDLE; name:PChar;buffer:Pbyte;len:PLongword):LONGword ;
         cdecl; External  TFFS_DLL_Name name 'tffs_read';
*)
function tffs_write(HANDLE:TFFSHANDLE; name:PChar;buffer:Pbyte;len:Longword):LONGword ;
         cdecl; External  TFFS_DLL_Name name 'tffs_write';
(*
function tffs_delete(HANDLE:TFFSHANDLE; name:PChar):LONGword ;
         cdecl; External  TFFS_DLL_Name name 'tffs_delete';
*)
var
  CopyScripts: TCopyScripts;

implementation

{$R *.dfm}

procedure tffs_example;
  var tffs:TFFSHANDLE;
       buf:string;
  begin
      if tffs_open(@tffs)=0 then
      begin
          buf:='the test';
          tffs_write(tffs,'test.txt',@buf[1],length(buf));
          tffs_format(tffs); // erase all data
          tffs_close(tffs);
      end;

  end;

procedure TCopyScripts.BitBtn1Click(Sender: TObject);
begin
        tffs_example;
end;

end.
