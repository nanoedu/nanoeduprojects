unit frRenishawSlowFronts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TFormSlowFronts = class(TForm)
    Chart1: TChart;
    Series1: TLineSeries;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSlowFronts: TFormSlowFronts;

implementation
 uses frOpenGLDraw;
{$R *.dfm}

procedure TFormSlowFronts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action:=caFree;
end;

procedure TFormSlowFronts.FormCreate(Sender: TObject);
var i,P0:integer;
    mode: integer;
     Buf:array of integer;
     ss:string;
     N:integer;
begin
    mode:=ActiveGLW.TopoSPM.FileHeadRcd.HPathMode;
      if Mode=0 then
     begin
       N:=ActiveGLW.TopoSPM.AquiRenishaw.Ny;
       SetLength(Buf,N);
        for i := 0 to N - 1 do
         Buf[i]:=abs(ActiveGLW.TopoSPM.AquiRenishaw.data[ActiveGLW.TopoSPM.AquiRenishaw.Nx-1,i]);
     end
     else
     begin
       N:=ActiveGLW.TopoSPM.AquiRenishaw.Nx;
       SetLength(Buf,N);
        for i := 0 to N - 1 do
         Buf[i]:=abs(ActiveGLW.TopoSPM.AquiRenishaw.data[i,ActiveGLW.TopoSPM.AquiRenishaw.Ny-1]);
     end;
     // For Slow Axis
     if mode=1 then ss:='X'    // slow axis name
     else ss:='Y';
     if mode=1 then mode:=0
     else mode:=1;
     for i:=0 to N-2 do
         Series1.AddXY(i,Buf[i+1]-Buf[i]);

     Buf:=nil;
end;

end.
