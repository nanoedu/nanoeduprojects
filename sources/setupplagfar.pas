unit setupplagfar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Registry, StdCtrls, ComCtrls, ExtCtrls;

type
  Tfarplugin = class(TForm)
    Panel1: TPanel;
    ProgressBar: TProgressBar;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  farplugin: Tfarplugin;

implementation

{$R *.dfm}
procedure FileCopyStream(src,target:string);
 var stream1,stream2:TFileStream;
begin
 if FileExists(Src) then
 begin
 Stream1:=TFileStream.Create(Src,fmOpenRead);
 try Stream2:=TFileStream.Create(Target,fmOpenWrite or fmCreate);
  try Stream2.CopyFrom(Stream1,Stream1.Size);
  finally
   Stream2.Free;
  end
  finally
   Stream1.Free
  end;
 end
 else  messageDlg('Error!!No  File '+Src,mtwarning,[mbOk],0);;
end;

procedure Tfarplugin.FormCreate(Sender: TObject);
var reg:Tregistry;
    s,farpath,exepath,pluginpath:string;
procedure copyplugin(filefrom,fileto:string);
begin
        try
            FileCopyStream(filefrom,fileto);
        except
        on IO: EInOutError do
         begin
          Case IO.errorcode of
           2: s:='file '''+filefrom+'''not find';
           3: s:='error file name '''+fileto+'''';
           4: s:='file '''+fileto+''' accept denied ';
         101: s:='disk is full';
         106: s:='input error '+fileto+'''';
                    end;
              exit;
         end;
       end;
end;

begin
       ProgressBar.Position:=0;
       PostMessage(ProgressBar.Handle, $0409, 0, clBtnShadow);
       Reg:=TRegistry.Create;
 try      Reg.RootKey:=HKEY_LOCAL_MACHINE;
   if not Reg.KeyExists('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FAR manager') then
    begin
         Reg.OpenKey('HKEY_LOCAL_MACHINE',false);
           Reg.OpenKey('SOFTWARE',false);
             Reg.OpenKey('Microsoft',false);
              Reg.OpenKey('Windows',false);
                 Reg.OpenKey('CurrentVersion',false);
                   Reg.OpenKey('Uninstall',false);
                     Reg.OpenKey('FAR manager',false);
        s:=reg.ReadString('UninstallString');
        FarPath:=ExtractFilePath(s);
        ExePath:=ExtractFilePath(Application.ExeName);
        PluginPath:=ExePath+'nanoeducator\far\plugins';
       if DirectoryExists( FarPath+'plugins')then
        begin
         if not DirectoryExists( Farpath+'plugins\CSPM')then   CreateDir(Farpath+'plugins\CSPM');
           FarPath:=Farpath+'plugins\CSPM';
           ProgressBar.Position:=0;
           FileCopyStream( PluginPath+'\tffs.dll',FarPath+'\tffs.dll');
           ProgressBar.Position:=1;
           FileCopyStream( PluginPath+'\tffseng.lng',FarPath+'\tffseng.lng');
           ProgressBar.Position:=2;
           FileCopyStream( PluginPath+'\tffsrus.lng',FarPath+'\tffsrus.lng');
           ProgressBar.Position:=3;
        end;
       Reg.CloseKey;
     end
     else  messageDlg('Error!! Install Far manager and try again',mtwarning,[mbOk],0);;
     Close;
 finally
    Reg.Free;
 end;
end;
procedure Tfarplugin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
end;

end.
