unit frLightOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons,OpenGl, siComp, siLngLnk;

type
  TLightOption = class(TForm)
    PanelBottom: TPanel;
    BitBtnCancel: TBitBtn;
    BitBtnDef: TBitBtn;
    BitBtnOk: TBitBtn;
    PageControl1: TPageControl;
    TabSheetP: TTabSheet;
    TabSheetAm: TTabSheet;
    Panel3: TPanel;
    TabSheetD: TTabSheet;
    Panel4: TPanel;
    Panel7: TPanel;
    Panel6: TPanel;
    Panel9: TPanel;
    ImageA: TImage;
    Label1: TLabel;
    TrackBarRA: TTrackBar;
    Label3: TLabel;
    TrackBarGA: TTrackBar;
    Label4: TLabel;
    TrackBarBA: TTrackBar;
    Panel10: TPanel;
    ImageD: TImage;
    PanelLP: TPanel;
    PanelL: TPanel;
    Label2: TLabel;
    LabelX1: TLabel;
    LabelY1: TLabel;
    LabelZ1: TLabel;
    Label10: TLabel;
    TrackBarX1: TTrackBar;
    TrackBarZ1: TTrackBar;
    TrackBarY1: TTrackBar;
    PanelC: TPanel;
    Label6: TLabel;
    LabelX2: TLabel;
    LabelY2: TLabel;
    LabelZ2: TLabel;
    Label11: TLabel;
    TrackBarX2: TTrackBar;
    TrackBarY2: TTrackBar;
    TrackBarZ2: TTrackBar;
    Label7: TLabel;
    TrackBarRD: TTrackBar;
    Label8: TLabel;
    TrackBarGD: TTrackBar;
    Label9: TLabel;
    TrackBarBD: TTrackBar;
    siLangLinked1: TsiLangLinked;
    procedure FormCreate(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrackBarX1Change(Sender: TObject);
    procedure TrackBarY1Change(Sender: TObject);
    procedure TrackBarZ1Change(Sender: TObject);
    procedure TrackBarX2Change(Sender: TObject);
    procedure TrackBarY2Change(Sender: TObject);
    procedure TrackBarZ2Change(Sender: TObject);
    procedure BitBtnDefClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TrackBarRAChange(Sender: TObject);
    procedure TrackBarGAChange(Sender: TObject);
    procedure TrackBarBAChange(Sender: TObject);
    procedure TrackBarRDChange(Sender: TObject);
    procedure TrackBarGDChange(Sender: TObject);
    procedure TrackBarBDChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    lx1,ly1,lz1:string;
    lx2,ly2,lz2:string;
    DC : HDC;
    hrc: HGLRC;
    ClientX0,ClientY0:integer;
    vLeft, vRight, vBottom, vTop, vNear, vFar : GLFloat;
    { Private declarations }
  public
    { Public declarations }
     procedure UpdatePosition;
  end;

var
  LightOption: TLightOption;
   quadObj : GLUquadricObj;
implementation

{$R *.dfm}

uses GlobalVar,frOpenGlDraw,frSetMaterialOpt,mMain;

function RGBToColor(R, G, B: Byte): TColor;
begin
  Result := B shl 16 or G shl 8 or R;
end;

procedure SetDCPixelFormat (hdc : HDC);
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat := ChoosePixelFormat (hdc, @pfd);
 SetPixelFormat (hdc, nPixelFormat, @pfd);
end;

procedure TLightOption.FormCreate(Sender: TObject);
var clA,clD,clS:TColor;
vLeft, vRight, vBottom, vTop, vNear, vFar : GLFloat;
H,W,ClientHW:Integer;
begin
siLangLinked1.ActiveLanguage:=Lang;
 width:=460;
 height:=600;
 constraints.MaxHeight:=600;
 constraints.MaxWidth:=460;
 constraints.MinHeight:=600;
 constraints.MinWidth:=460;
 top:=Main.clientHeight-self.Height-15;
 left:=Main.ClientWidth-self.width-5;
 PageControl1.ControlStyle  :=  PageControl1.ControlStyle + [csOpaque];
 TabSheetP.ControlStyle  :=  TabSheetP.ControlStyle + [csOpaque];
 ControlStyle  :=  ControlStyle + [csOpaque];
  PageControl1.ActivePage:=TabSheetP;
 with   PageControl1 do
 begin
  top:=0;
  left:=0;
  height:=240;
  width:=self.ClientWidth;
 end;
 with  PanelBottom do
 begin
  top:=self.ClientHeight;
  left:=0;
  width:=self.ClientWidth;
  height:=70;
 end;
 with   Panel6 do
 begin
  top:=0;
  left:=0;
  height:=TabSheetAm.ClientHeight;
  width:=TabSheetAm.ClientWidth div 2;
 end;
 with   Panel7 do
 begin
  top:=0;
  left:=Panel6.width;
  height:=TabSheetAm.ClientHeight;
  width:=TabSheetAm.ClientWidth div 2;
 end;
 with   Panel10 do
 begin
  top:=0;
  left:=0;
  height:=TabSheetD.ClientHeight;
  width:=TabSheetD.ClientWidth div 2;
 end;
 with   Panel9 do
 begin
  top:=0;
  left:=Panel10.width;
  height:=TabSheetAm.ClientHeight;
  width:=TabSheetAm.ClientWidth div 2;
 end;
 lx1:='X ';
 ly1:='Y ';
 lz1:='Z ';
 lx2:='X ';
 ly2:='Y ';
 lz2:='Z ';

if assigned(ActiveGLW) then
begin
 TrackBarX1.position:=round(ActiveGLW.position0[0]);
 TrackBarY1.position:=round(ActiveGLW.position0[1]);
 TrackBarZ1.position:=round(ActiveGLW.position0[2]);
 TrackBarX2.position:=round(ActiveGLW.position1[0]);
 TrackBarY2.position:=round(ActiveGLW.position1[1]);
 TrackBarZ2.position:=round(ActiveGLW.position1[2]);
 TrackBarRD.Position:=round(ActiveGLW.gl1diffuse[0]*255);
 TrackBarGD.Position:=round(ActiveGLW.gl1diffuse[1]*255);
 TrackBarBD.Position:=round(ActiveGLW.gl1diffuse[2]*255);
 TrackBarRA.Position:=round(ActiveGLW.gl1ambient[0]*255);
 TrackBarGA.Position:=round(ActiveGLW.gl1ambient[1]*255);
 TrackBarBA.Position:=round(ActiveGLW.gl1ambient[2]*255);
end
else
 begin
  TrackBarX1.position:=round(ltposition0[0]);
  TrackBarY1.position:=round(ltposition0[1]);
  TrackBarZ1.position:=round(ltposition0[2]);
  TrackBarX2.position:=round(ltposition1[0]);
  TrackBarY2.position:=round(ltposition1[1]);
  TrackBarZ2.position:=round(ltposition1[2]);
  TrackBarRD.Position:=round(l1diffuse[0]*255);
  TrackBarGD.Position:=round(l1diffuse[1]*255);
  TrackBarBD.Position:=round(l1diffuse[2]*255);
  TrackBarRA.Position:=round(l1ambient[0]*255);
  TrackBarGA.Position:=round(l1ambient[1]*255);
  TrackBarBA.Position:=round(l1ambient[2]*255);
 end;
  LabelX1.Caption:=lx1+' '+inttostr(TrackBarX1.position);
  LabelY1.Caption:=ly1+' '+inttostr(TrackBarY1.position);
  LabelZ1.Caption:=lz1+' '+inttostr(TrackBarZ1.position);
  LabelX2.Caption:=lx2+' '+inttostr(TrackBarX2.position);
  LabelY2.Caption:=ly2+' '+inttostr(TrackBarY2.position);
  LabelZ2.Caption:=lz2+' '+inttostr(TrackBarZ2.position);
  clA:=RGBToColor(Byte(TrackBarRA.position),bYTE(TrackBarGA.position),BYTE(TrackBarBA.position));
 with ImageA do
        begin
         Canvas.Brush.Color:=clA;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;
  clD:=RGBToColor(Byte(TrackBarRD.position),bYTE(TrackBarGD.position),BYTE(TrackBarBD.position));
 with ImageD do
        begin
         Canvas.Brush.Color:=clD;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;
 DC := GetDC ({TabSheetP.}Handle);
 SetDCPixelFormat(DC);
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
 H:=ClientHeight-PageControl1.Height-PanelBottom.Height;
 W:=ClientWidth;
 if H < W then
  begin
   ClientX0:=round((W-H)*0.5);
   ClientY0:=PanelBottom.Height;
   ClientHW:=H;
  end
 else
  begin
    ClientX0:=0;
    ClientY0:=PanelBottom.Height+round((H-W)*0.5);
    ClientHW:=W;
  end;

 vLeft := -1;
 vRight := 1;
 vBottom := -1;
 vTop := 1;
 vNear := 4.5;
 vFar := 10.5;
//Near := -1;//4.5;
//Far := 1;
 glMatrixMode(GL_PROJECTION);
   glLoadIdentity;
   glViewport(ClientX0,ClientY0, ClientHW, ClientHW);
//   glScissor(ClientX0,ClientY0, ClientHW, ClientHW);

   glFrustum(vLeft,vRight,vBottom,vTop,vNear,vFar  );
   glMatrixMode(GL_MODELVIEW);
   glLoadIdentity;
   glTranslatef( 0.0, 0.0, -7.5 );
 (* glMatrixMode(GL_MODELVIEW);
   glLoadIdentity;
   glRotatef( 180, 0.0, 1.0, 0.0 );
   glRotatef(-120, 1.0, 0.0, 0.0 );
   glRotatef( 210, 0.0, 0.0, 1.0 );
 //  glTranslatef( 0.0, 0.0, -7.0 );
 *)
 wglMakeCurrent(0, 0);
 ReleaseDC(Handle,DC);
end;

procedure TLightOption.UpdatePosition;
begin
if assigned(ActiveGLW) then
 begin
  TrackBarX1.position:=round(ActiveGLW.position0[0]);
  TrackBarY1.position:=round(ActiveGLW.position0[1]);
  TrackBarZ1.position:=round(ActiveGLW.position0[2]);
  TrackBarX2.position:=round(ActiveGLW.position1[0]);
  TrackBarY2.position:=round(ActiveGLW.position1[1]);
  TrackBarZ2.position:=round(ActiveGLW.position1[2]);
  LabelX1.Caption:=lx1+' '+inttostr(TrackBarX1.position);
  LabelY1.Caption:=ly1+' '+inttostr(TrackBarY1.position);
  LabelZ1.Caption:=lz1+' '+inttostr(TrackBarZ1.position);
  LabelX2.Caption:=lx2+' '+inttostr(TrackBarX2.position);
  LabelY2.Caption:=ly2+' '+inttostr(TrackBarY2.position);
  LabelZ2.Caption:=lz2+' '+inttostr(TrackBarZ2.position);
 end;
end;

procedure TLightOption.TrackBarX1Change(Sender: TObject);
begin
 if assigned(ActiveGLW) then
 begin
  ActiveGLW.position0[0]:=TrackBarX1.position;
  ActiveGLW.OptionLight;
 end;
 if assigned(vSetMaterialOpt) then
 begin
  vSetMaterialOpt.position0[0]:=TrackBarX1.position;
  vSetMaterialOpt.InitMaterials;
  vSetMaterialOpt.FormPaint(sender);
 end;
  LabelX1.Caption:=lx1+' '+inttostr(TrackBarX1.position);
  InvalidateRect(Handle, nil, False);//RePaint;
end;

procedure TLightOption.TrackBarY1Change(Sender: TObject);
begin
if assigned(ActiveGLW) then
 begin
  ActiveGLW.position0[1]:=TrackBarY1.Position;
  ActiveGLW.OptionLight;
 end;
if assigned(vSetMaterialOpt) then
 begin
  vSetMaterialOpt.position0[1]:=TrackBarY1.position;
  vSetMaterialOpt.InitMaterials;
  vSetMaterialOpt.FormPaint(sender);
 end;
  LabelY1.Caption:=lY1+' '+inttostr(TrackBarY1.position);
  InvalidateRect(Handle, nil, False);//RePaint;
end;

procedure TLightOption.TrackBarZ1Change(Sender: TObject);
begin
  if assigned(ActiveGLW) then
   begin
    ActiveGLW.position0[2]:=TrackBarZ1.position;
    ActiveGLW.OptionLight;
  end;
if assigned(vSetMaterialOpt) then
 begin
  vSetMaterialOpt.position0[2]:=TrackBarZ1.position;
  vSetMaterialOpt.InitMaterials;
   vSetMaterialOpt.FormPaint(sender);
 end;
  LabelZ1.Caption:=lz1+' '+inttostr(TrackBarZ1.position);
 InvalidateRect(Handle, nil, False);// RePaint;
end;

procedure TLightOption.BitBtnOKClick(Sender: TObject);
begin
 if assigned(ActiveGLW) then
  begin
   ActiveGLW.position0[0]:=TrackBarX1.Position;
   ActiveGLW.position0[1]:=TrackBarY1.position;
   ActiveGLW.position0[2]:=TrackBarZ1.position;
   ActiveGLW.position1[0]:=TrackBarX2.position;
   ActiveGLW.position1[1]:=TrackBarY2.position;
   ActiveGLW.position1[2]:=TrackBarZ2.position;
   ActiveGLW.OptionLight;
 end;
  LabelX1.Caption:=lx1+' '+inttostr(TrackBarX1.position);
  LabelY1.Caption:=ly1+' '+inttostr(TrackBarY1.position);
  LabelZ1.Caption:=lz1+' '+inttostr(TrackBarZ1.position);
  LabelX2.Caption:=lx2+' '+inttostr(TrackBarX2.position);
  LabelY2.Caption:=ly2+' '+inttostr(TrackBarY2.position);
  LabelZ2.Caption:=lz2+' '+inttostr(TrackBarZ2.position);
  Close;
end;

procedure TLightOption.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
   Action:=caFree;
end;

procedure TLightOption.TrackBarX2Change(Sender: TObject);
begin
  if assigned(ActiveGLW) then
    begin
     ActiveGLW.position1[0]:=TrackBarX2.position;
     ActiveGLW.OptionLight
    end;
   LabelX2.Caption:=lx2+' '+inttostr(TrackBarX2.position);
 InvalidateRect(Handle, nil, False);;//  repaint;
end;

procedure TLightOption.TrackBarY2Change(Sender: TObject);
begin
   if assigned(ActiveGLW) then
    begin
     ActiveGLW.position1[1]:=TrackBarY2.position;
     ActiveGLW.OptionLight
    end;
    LabelY2.Caption:=ly2+' '+inttostr(TrackBarY2.position);
 InvalidateRect(Handle, nil, False);//     repaint;
end;

procedure TLightOption.TrackBarZ2Change(Sender: TObject);
begin
   if assigned(ActiveGLW) then
    begin
      ActiveGLW.position1[2]:=TrackBarZ2.position;
      ActiveGLW.OptionLight
    end;
  LabelZ2.Caption:=lz2+' '+inttostr(TrackBarZ2.position);
  InvalidateRect(Handle, nil, False);//  repaint;
end;

procedure TLightOption.BitBtnDefClick(Sender: TObject);
var r,r2:single;
begin
  TrackBarX1.position:=round(ltposition0[0]);
  TrackBarY1.position:=round(ltposition0[1]);
  TrackBarZ1.position:=round(ltposition0[2]);
  TrackBarX2.position:=round(ltposition1[0]);
  TrackBarY2.position:=round(ltposition1[1]);
  TrackBarZ2.position:=round(ltposition1[2]);
if assigned(ActiveGLW) then
  begin
   ActiveGLW.position0[0]:=TrackBarX1.Position;
   ActiveGLW.position0[1]:=TrackBarY1.position;
   ActiveGLW.position0[2]:=TrackBarZ1.position;
   ActiveGLW.position1[0]:=TrackBarX2.position;
   ActiveGLW.position1[1]:=TrackBarY2.position;
   ActiveGLW.position1[2]:=TrackBarZ2.position;
   ActiveGLW.OptionLight;
  end;
  LabelX1.Caption:=lx1+' '+inttostr(TrackBarX1.position);
  LabelY1.Caption:=ly1+' '+inttostr(TrackBarY1.position);
  LabelZ1.Caption:=lz1+' '+inttostr(TrackBarZ1.position);
  LabelX2.Caption:=lx2+' '+inttostr(TrackBarX2.position);
  LabelY2.Caption:=ly2+' '+inttostr(TrackBarY2.position);
  LabelZ2.Caption:=lz2+' '+inttostr(TrackBarZ2.position);
end;

procedure TLightOption.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TLightOption.FormDestroy(Sender: TObject);
begin
  LightOption:=nil;
end;

procedure TLightOption.TrackBarRAChange(Sender: TObject);
var clA:Tcolor;
begin
 clA:=RGBToColor(Byte(TrackBarRA.position),bYTE(TrackBarGA.position),BYTE(TrackBarBA.position));
  with ImageA do
        begin
         Canvas.Brush.Color:=clA;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;

if assigned(ActiveGLW) then
 begin
  ActiveGLW.gl1ambient[0]:=TrackBarRA.Position/255;
  ActiveGLW.OptionLight;
 end;
 if assigned(vSetMaterialOpt) then
 begin
  vSetMaterialOpt.lambient[0]:=TrackBarRA.position/255;
  vSetMaterialOpt.InitMaterials;
  vSetMaterialOpt.FormPaint(sender);
 end;
end;

procedure TLightOption.TrackBarGAChange(Sender: TObject);
var clA:Tcolor;
begin
 clA:=RGBToColor(Byte(TrackBarRA.position),bYTE(TrackBarGA.position),BYTE(TrackBarBA.position));
  with ImageA do
        begin
         Canvas.Brush.Color:=clA;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;

if assigned(ActiveGLW) then
 begin
  ActiveGLW.gl1ambient[1]:=TrackBarGA.Position/255 ;
  ActiveGLW.OptionLight;
 end;
if assigned(vSetMaterialOpt) then
 begin
  vSetMaterialOpt.lambient[1]:=TrackBarGA.position/255;
  vSetMaterialOpt.InitMaterials;
  vSetMaterialOpt.FormPaint(sender);
 end;
end;

procedure TLightOption.TrackBarBAChange(Sender: TObject);
var clA:Tcolor;
begin
 clA:=RGBToColor(Byte(TrackBarRA.position),bYTE(TrackBarGA.position),BYTE(TrackBarBA.position));
  with ImageA do
        begin
         Canvas.Brush.Color:=clA;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;

 if assigned(ActiveGLW) then
 begin
  ActiveGLW.gl1ambient[2]:=TrackBarBA.Position/255;
  ActiveGLW.OptionLight;
 end;
 if assigned(vSetMaterialOpt) then
 begin
  vSetMaterialOpt.lambient[2]:=TrackBarBA.position/255;
  vSetMaterialOpt.InitMaterials;
   vSetMaterialOpt.FormPaint(sender);
 end;
end;

procedure TLightOption.TrackBarRDChange(Sender: TObject);
var clD:Tcolor;
begin
 clD:=RGBToColor(Byte(TrackBarRD.position),bYTE(TrackBarGD.position),BYTE(TrackBarBD.position));
  with ImageD do
        begin
         Canvas.Brush.Color:=clD;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;

if assigned(ActiveGLW) then
 begin
  ActiveGLW.gl1diffuse[0]:=TrackBarRD.Position/255;
  ActiveGLW.OptionLight;
 end;
if assigned(vSetMaterialOpt) then
 begin
  vSetMaterialOpt.ldiffuse[0]:=TrackBarRD.position/255;
  vSetMaterialOpt.InitMaterials;
   vSetMaterialOpt.FormPaint(sender);
 end;
end;

procedure TLightOption.TrackBarGDChange(Sender: TObject);
var clD:Tcolor;
begin
 clD:=RGBToColor(Byte(TrackBarRD.position),bYTE(TrackBarGD.position),BYTE(TrackBarBD.position));
  with ImageD do
        begin
         Canvas.Brush.Color:=clD;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;
if assigned(ActiveGLW) then
 begin
  ActiveGLW.gl1diffuse[1]:=TrackBarGD.Position/255;
  ActiveGLW.OptionLight;
 end;
if assigned(vSetMaterialOpt) then
 begin
  vSetMaterialOpt.ldiffuse[1]:=TrackBarGD.position/255;
  vSetMaterialOpt.InitMaterials;
  vSetMaterialOpt.FormPaint(sender);
 end
end;

procedure TLightOption.TrackBarBDChange(Sender: TObject);
 var clD:Tcolor;
begin
 clD:=RGBToColor(Byte(TrackBarRD.position),bYTE(TrackBarGD.position),BYTE(TrackBarBD.position));
  with ImageD do
        begin
         Canvas.Brush.Color:=clD;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;
if assigned(ActiveGLW) then
 begin
  ActiveGLW.gl1diffuse[2]:=TrackBarBD.Position/255;
  ActiveGLW.OptionLight;
 end;
if assigned(vSetMaterialOpt) then
 begin
  vSetMaterialOpt.ldiffuse[2]:=TrackBarBD.position/255;
  vSetMaterialOpt.InitMaterials;
  vSetMaterialOpt.FormPaint(sender);
 end
end;



procedure glutSolidSphere(Radius : GLdouble; Slices : GLint; Stacks : GLint);
begin { glutSolidSphere }
  if quadObj = nil then    quadObj := gluNewQuadric;
  gluQuadricDrawStyle(quadObj, GLU_FILL);
  gluQuadricNormals(quadObj, GLU_SMOOTH);
  gluSphere(quadObj, Radius, Slices, Stacks);
end; { glutSolidSphere }

procedure TLightOption.FormPaint(Sender: TObject);
 var ps:PAINTSTRUCT;
   H,W,ClientHW:Integer;
   norma:single;
 begin
 norma:=1/100;
 DC := GetDC (Handle);
 wglMakeCurrent(DC, hrc);
  BeginPaint(Handle, ps);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
     glMatrixMode(GL_MODELVIEW);
      glPushMatrix;
       glScalef(0.9,0.9,0.9);
       glRotatef( 180, 0.0, 1.0, 0.0 );
       glRotatef(-120, 1.0, 0.0, 0.0 );
       glRotatef( 210, 0.0, 0.0, 1.0 );
      glColor3f(1.0,0.0,0.0);
      glutSolidSphere(0.05, 200,200);
      glColor3f(1.0,0.0,0.0);

    glBegin (GL_LINES);
      glVertex3f (0, -1,0);
      glVertex3f (0, 1,0);
      glVertex3f (-1, 0,0);
      glVertex3f (1, 0,0);
      glVertex3f (0, 0,-1);
      glVertex3f (0, 0,1);
    glEnd;
      glPushMatrix;
      glColor3f(1.0,1.0,0.0);
      glTranslatef(TrackBarX1.position*norma,TrackBarY1.position*norma,TrackBarZ1.position*norma );
      glutSolidSphere(0.05, 200,200);
      glBegin (GL_LINES);
      glVertex3f (-TrackBarX1.position*norma,-TrackBarY1.position*norma,-TrackBarZ1.position*norma);
      glVertex3f (0, 0,0);
      glend;
    glPopMatrix;
    glPushMatrix;
      glColor3f(1.0,0.0,1.0);
      glTranslatef(TrackBarX2.position*norma,TrackBarY2.position*norma,TrackBarZ2.position*norma);
      glutSolidSphere(0.05, 200,200);
      glBegin (GL_LINES);
      glVertex3f(-TrackBarX2.position*norma,-TrackBarY2.position*norma,-TrackBarZ2.position*norma);
      glVertex3f(0,0,0);
      glend;

    glPopMatrix;
  glPopMatrix;
    SwapBuffers(DC);
  EndPaint (Handle,ps);
  wglMakeCurrent(0, 0);
ReleaseDC(Handle,DC);
end;

procedure TLightOption.PageControl1Change(Sender: TObject);
begin
 InvalidateRect(Handle, nil, False);
end;

procedure TLightOption.FormResize(Sender: TObject);
var   ClientX0,ClientY0,ClientHW,h,w:integer;
begin
 H:=ClientHeight-PageControl1.Height;;
 W:=ClientWidth;
 if H < W then
  begin
   ClientX0:=round((W-H)*0.5);
   ClientY0:=0;
   ClientHW:=H;
  end
 else
  begin
    ClientX0:=0;
    ClientY0:=round((H-W)*0.5);
    ClientHW:=W;
  end;
 DC:=GetDC(handle);
  wglMakeCurrent(DC, hrc);
  glViewport(ClientX0,ClientY0, ClientHW, ClientHW);
 // glScissor(ClientX0,ClientY0, ClientHW, ClientHW);

  glFrustum(vLeft,vRight,vBottom,vTop,vNear,vFar  );
 wglMakeCurrent(0, 0);
  InvalidateRect(Handle, nil, False);
  ReleaseDC(handle,DC);
 end;

end.

