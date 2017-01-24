unit frScale;

interface

uses
  Windows, Messages, SysUtils,{ Variants,} Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, siComp, siLngLnk;

type
  TScaleGL = class(TForm)
    TrackBarSc: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    siLangLinked1: TsiLangLinked;
    procedure TrackBarScChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScaleGL: TScaleGL;

implementation

{$R *.dfm}
uses globalvar,frOpenGlDraw,mMain;

procedure TScaleGL.TrackBarScChange(Sender: TObject);
begin
 if assigned(ActiveGLW) then
 begin
  with ActiveGLW do
  begin
//  if FlgView=0 then   //topography
   begin
    ZScaleP:= TrackBarSc.position;
    ScaleZ(Sender);
   end
//   else messageDlg('Real Scale',mtwarning,[mbOk],0);
  end;
 end;
end;

procedure TScaleGL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
 ScaleGl:=nil;
end;

procedure TScaleGL.FormCreate(Sender: TObject);
begin
siLangLinked1.ActiveLanguage:=Lang;
  height:=390;
  width:=40;
  top:=Main.clientHeight-self.Height-15;
  left:=Main.ClientWidth-self.width-5;
  label1.Top:=clientheight-label1.Font.Size-5;
  label1.left:=0;
  label2.Top:=label2.Font.Size+5;
  label2.left:=0;
  TrackBarSc.Height:=ClientHeight;
  TrackBarSc.width:=30;
  TrackBarSc.top:=0;
  TrackBarSc.left:=ClientWidth-TrackBarSc.width-2;
 if assigned(ActiveGLW) then
  begin
     if ActiveGLW.flgGlReadBlock<>0 then label1.Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Minimum' *) )  //topography
                                    else label1.Caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* 'Real Scale' *) );

    TrackBarSc.position:=round(ActiveGLW.ZScaleP);
    ActiveGLW.ZScaleP:= TrackBarSc.position;
    ActiveGLW.ScaleZ(Sender);
  end;
end;

end.
