unit frSetMaterialOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,OpenGl, ComCtrls,
  Buttons, siComp, siLngLnk;

type
  TSetMaterialOption = class(TForm)
    Panel1: TPanel;
    material: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    TabSheet3: TTabSheet;
    PanelImS: TPanel;
    Panel3: TPanel;
    TrackBarRS: TTrackBar;
    TrackBarGS: TTrackBar;
    TrackBarBS: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ImageSp: TImage;
    BitBtnD: TBitBtn;
    TabSheet4: TTabSheet;
    TrackBarSH: TTrackBar;
    Panel2: TPanel;
    Panel4: TPanel;
    Label5: TLabel;
    TrackBarRE: TTrackBar;
    Label6: TLabel;
    TrackBarGE: TTrackBar;
    Label7: TLabel;
    TrackBarBE: TTrackBar;
    ImageEm: TImage;
    Panel5: TPanel;
    Panel6: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    TrackBarRD: TTrackBar;
    TrackBarGD: TTrackBar;
    Label10: TLabel;
    TrackBarBD: TTrackBar;
    ImageD: TImage;
    LabelSH: TLabel;
    siLangLinked1: TsiLangLinked;
    procedure MaterialSelect(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure TrackBarRSChange(Sender: TObject);
    procedure TrackBarBSChange(Sender: TObject);
    procedure TrackBarGSChange(Sender: TObject);
    procedure TrackBarREChange(Sender: TObject);
    procedure TrackBarGEChange(Sender: TObject);
    procedure TrackBarBEChange(Sender: TObject);
    procedure BitBtnDClick(Sender: TObject);
    procedure TrackBarSHChange(Sender: TObject);
    procedure TrackBarRDChange(Sender: TObject);
    procedure TrackBarGDChange(Sender: TObject);
    procedure TrackBarBDChange(Sender: TObject);
  private
    { Private declarations }
    DC : HDC;
    hrc: HGLRC;
    ClientX0,ClientY0:integer;
    vLeft, vRight, vBottom, vTop, vNear, vFar : GLFloat;
    front_mat_shininess : array[0..0] of GLfloat;
    front_mat_emission  : array[0..3] of GLfloat;
    front_mat_specular  : array[0..3] of GLfloat;
    front_mat_diffuse   : array[0..3] of GLfloat;
    front_mat_ambient   : array[0..3] of GLfloat;

  public
    Lambient : Array [0..3] of GLfloat;// = (0.0, 0.0, 0.0, 1.0);
    Ldiffuse : Array [0..3] of GLfloat;// = (1.0, 1.0, 1.0, 1.0);
    lmodel_ambient: Array [0..3] of GLfloat;// = ( 1.0, 1.0, 1.0, 1.0 );
    position0           : array[0..3] of GLfloat ;
    position1           : array[0..3] of GLfloat ;
    procedure   InitMaterials;
   procedure    UpdateMaterials;
    { Public declarations }
  end;

var
   vSetMaterialOpt: TSetMaterialOption;
   quadObj : GLUquadricObj;
implementation

uses GlobalVar,mMain,frOpenGlDraw,GlobalFunction;

{$R *.dfm}
function RGBToColor(R, G, B: Byte): TColor;
begin
  Result := B shl 16 or G shl 8 or R;
end;
(*// RGB to TColor Values
procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Color := RGB(58, 110, 165);
end;

// TColor to RGB values
procedure TForm1.Button2Click(Sender: TObject);
var
  Color: Longint;
  r, g, b: Byte;
begin
  Color := ColorToRGB(Edit1.Color);
  r     := Color;
  g     := Color shr 8;
  b     := Color shr 16;
  label1.Caption := ' Red  : ' + IntToStr(r) +
    ' Green: ' + IntToStr(g) +
    ' Blue : ' + IntToStr(b);
end;

*)

procedure glutSolidSphere(Radius : GLdouble; Slices : GLint; Stacks : GLint);
begin { glutSolidSphere }
  if quadObj = nil then    quadObj := gluNewQuadric;
  gluQuadricDrawStyle(quadObj, GLU_FILL);
  gluQuadricNormals(quadObj, GLU_SMOOTH);
  gluSphere(quadObj, Radius, Slices, Stacks);
end; { glutSolidSphere }

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

procedure   TSetMaterialOption.InitMaterials;
begin
 glLightfv(GL_LIGHT0, GL_AMBIENT, @Lambient);
 glLightfv(GL_LIGHT0, GL_DIFFUSE, @Ldiffuse);
 glLightfv(GL_LIGHT0, GL_POSITION, @position0);
 glEnable(GL_LIGHT0);
 glLightfv(GL_LIGHT1, GL_AMBIENT, @Lambient);
 glLightfv(GL_LIGHT1, GL_DIFFUSE, @Ldiffuse);
 glLightfv(GL_LIGHT1, GL_POSITION, @position1);
 glEnable(GL_LIGHT1);
 glLightModelfv(GL_LIGHT_MODEL_AMBIENT, @lmodel_ambient);
 glEnable(GL_LIGHTING);
 glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, @front_mat_emission);
 glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, @front_mat_shininess);
 glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, @front_mat_specular);
 glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, @front_mat_diffuse);
 glMaterialfv(GL_FRONT_AND_BACK, GL_ambient, @front_mat_ambient);
end;

procedure   TSetMaterialOption.UpdateMaterials;
var i:integer;
begin
 if assigned(ActiveGLW) then
 begin
  for i:=0 to 3 do
   begin
    front_mat_emission[i]:=emission[i];
    front_mat_specular[i]:=specular[i];
    front_mat_diffuse[i]:=diffuse[i];
    front_mat_ambient[i]:=ambient[i];
   end;
 front_mat_shininess[0]:=shininess[0] ;
 InitMaterials;
 TrackBarSH.position:= round(front_mat_shininess[0]);
 TrackBarRS.position:= round(front_mat_specular[0]*255);
 TrackBarGS.position:= round(front_mat_specular[1]*255);
 TrackBarBS.position:= round(front_mat_specular[2]*255);
 TrackBarRD.position:= round(front_mat_diffuse[0]*255);
 TrackBarGD.position:= round(front_mat_diffuse[1]*255);
 TrackBarBD.position:= round(front_mat_diffuse[2]*255);
 Material.Text:=Material.items[ActiveGLW.ColorMaterialGLW];
 InvalidateRect(Handle, nil, False);
 end;
end;

procedure TSetMaterialOption.materialSelect(Sender: TObject);
var i:integer;
begin
  with Material do
  begin
  case  ItemIndex of
   0: renderTeapot (0.0215, 0.1745, 0.0215,0.07568, 0.61424, 0.07568, 0.633, 0.727811, 0.633, 0.6);
   1: renderTeapot (0.329412, 0.223529, 0.027451, 0.780392, 0.568627, 0.113725, 0.992157, 0.941176, 0.807843,0.21794872);
   2: renderTeapot (0.2125, 0.1275, 0.054,0.714, 0.4284, 0.18144, 0.393548, 0.271906, 0.166721, 0.2);
   3: renderTeapot (0.25, 0.25, 0.25,0.4, 0.4, 0.4, 0.774597, 0.774597, 0.774597, 0.6);
   4: renderTeapot (0.19125, 0.0735, 0.0225,0.7038, 0.27048, 0.0828, 0.256777, 0.137622, 0.086014, 0.1);
   5: renderTeapot (0.24725, 0.1995, 0.0745,0.75164, 0.60648, 0.22648, 0.628281, 0.555802, 0.366065, 0.4);
   6: renderTeapot (0.19225, 0.19225, 0.19225,0.50754, 0.50754, 0.50754, 0.508273, 0.508273, 0.508273, 0.4);
(* //  7: renderTeapot (0.135, 0.2225, 0.1575, 0.54, 0.89, 0.63, 0.316228, 0.316228, 0.316228, 0.1);
 //  8: renderTeapot (0.05375, 0.05, 0.06625,0.18275, 0.17, 0.22525, 0.332741, 0.328634, 0.346435, 0.3);
 //  9: renderTeapot (0.25, 0.20725, 0.20725,1, 0.829, 0.829, 0.296648, 0.296648, 0.296648, 0.088);
   7:renderTeapot (0.1745, 0.01175, 0.01175,0.61424, 0.04136, 0.04136, 0.727811, 0.626959, 0.626959, 0.6);
   8:renderTeapot (0.1, 0.18725, 0.1745, 0.396, 0.74151, 0.69102, 0.297254, 0.30829, 0.306678, 0.1);
//   9:renderTeapot (0.24725, 0.1995, 0.0745,0.75164, 0.60648, 0.22648, 0.628281, 0.555802, 0.366065, 0.4);
//   9:renderTeapot (0.19225, 0.19225, 0.19225,0.50754, 0.50754, 0.50754, 0.508273, 0.508273, 0.508273, 0.4);
   9:renderTeapot (0.0, 0.0, 0.0, 0.01, 0.01, 0.01, 0.50, 0.50, 0.50, 0.25);
 //  11:renderTeapot (0.0, 0.1, 0.06, 0.0, 0.50980392, 0.50980392, 0.50196078, 0.50196078, 0.50196078, 0.25);
   10:renderTeapot (0.0, 0.0, 0.0, 0.1, 0.35, 0.1, 0.45, 0.55, 0.45, 0.25);
   11:renderTeapot (0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.7, 0.6, 0.6, 0.25);
 //  14:renderTeapot (0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 0.70, 0.70, 0.70, 0.25);
//   19:renderTeapot (0.0, 0.0, 0.0, 0.5, 0.5, 0.0,0.60, 0.60, 0.50, 0.25);
   12:renderTeapot (0.02, 0.02, 0.02, 0.01, 0.01,0.01,0.4, 0.4, 0.4, 0.078125);
   13:renderTeapot (0.0, 0.05, 0.05, 0.4, 0.5, 0.5,0.04, 0.7, 0.7, 0.078125);
   14:renderTeapot (0.0, 0.05, 0.0, 0.4, 0.5, 0.4,0.04, 0.7, 0.04, 0.078125);
   15:renderTeapot (0.05, 0.0, 0.0, 0.5, 0.4, 0.4,0.7, 0.04, 0.04, 0.078125);
   16:renderTeapot (0.05, 0.05, 0.05, 0.5, 0.5, 0.5,0.7, 0.7, 0.7, 0.078125);
   17:renderTeapot (0.05, 0.05, 0.0, 0.5, 0.5, 0.4,0.7, 0.7, 0.04, 0.078125);
*)
            end;
   ColorMaterial:=ItemIndex;
 if assigned(ActiveGLW) then ActiveGLW.ColorMaterialGLW:=ColorMaterial;
       end;
   for i:=0 to 3 do
   begin
    front_mat_specular[i]:=specular[i];
    front_mat_diffuse[i]:=diffuse[i];
    front_mat_ambient[i]:=ambient[i];
   end;
   front_mat_shininess[0]:={128*}shininess[0] ;
 TrackBarSH.position:= round(front_mat_shininess[0]);
 TrackBarRS.position:= round(front_mat_specular[0]*255);
 TrackBarGS.position:= round(front_mat_specular[1]*255);
 TrackBarBS.position:= round(front_mat_specular[2]*255);
 TrackBarRD.position:= round(front_mat_diffuse[0]*255);
 TrackBarGD.position:= round(front_mat_diffuse[1]*255);
 TrackBarBD.position:= round(front_mat_diffuse[2]*255);

   InitMaterials;
   InvalidateRect(Handle, nil, False);
 if assigned(ActiveGLW) then  ActiveGLW.Material(Sender);
end;

procedure TSetMaterialOption.FormResize(Sender: TObject); var H,W,ClientHW:Integer;
begin
 H:=ClientHeight-Panel1.Height;;
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
//  glScissor(ClientX0,ClientY0, ClientHW, ClientHW);

  wglMakeCurrent(0, 0);
  InvalidateRect(Handle, nil, False);
  ReleaseDC(handle,DC);
end;

procedure TSetMaterialOption.FormCreate(Sender: TObject);
var i,H,W,ClientHW:Integer;
  clSp,clEm,clD:Tcolor;
begin
siLangLinked1.ActiveLanguage:=Lang;
 width:=height;
 DC := GetDC (Handle);
 SetDCPixelFormat(DC);
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
 case Material.ItemIndex of
   0: renderTeapot (0.0215, 0.1745, 0.0215,0.07568, 0.61424, 0.07568, 0.633, 0.727811, 0.633, 0.6);
   1: renderTeapot (0.329412, 0.223529, 0.027451, 0.780392, 0.568627, 0.113725, 0.992157, 0.941176, 0.807843,0.21794872);
   2: renderTeapot (0.2125, 0.1275, 0.054,0.714, 0.4284, 0.18144, 0.393548, 0.271906, 0.166721, 0.2);
   3: renderTeapot (0.25, 0.25, 0.25,0.4, 0.4, 0.4, 0.774597, 0.774597, 0.774597, 0.6);
   4: renderTeapot (0.19125, 0.0735, 0.0225,0.7038, 0.27048, 0.0828, 0.256777, 0.137622, 0.086014, 0.1);
   5: renderTeapot (0.24725, 0.1995, 0.0745,0.75164, 0.60648, 0.22648, 0.628281, 0.555802, 0.366065, 0.4);
   6: renderTeapot (0.19225, 0.19225, 0.19225,0.50754, 0.50754, 0.50754, 0.508273, 0.508273, 0.508273, 0.4);
//   7:renderTeapot (0.1745, 0.01175, 0.01175,0.61424, 0.04136, 0.04136, 0.727811, 0.626959, 0.626959, 0.6);
//   8:renderTeapot (0.19225, 0.19225, 0.19225,0.50754, 0.50754, 0.50754, 0.508273, 0.508273, 0.508273, 0.4);
(*   7:renderTeapot (0.0, 0.1, 0.06, 0.0, 0.50980392, 0.50980392, 0.50196078, 0.50196078, 0.50196078, 0.25);
   16:renderTeapot (0.0, 0.0, 0.0, 0.1, 0.35, 0.1, 0.45, 0.55, 0.45, 0.25);
   17:renderTeapot (0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.7, 0.6, 0.6, 0.25);
   18:renderTeapot (0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 0.70, 0.70, 0.70, 0.25);
   19:renderTeapot (0.0, 0.0, 0.0, 0.5, 0.5, 0.0,0.60, 0.60, 0.50, 0.25);
   20:renderTeapot (0.02, 0.02, 0.02, 0.01, 0.01,0.01,0.4, 0.4, 0.4, 0.078125);
   21:renderTeapot (0.0, 0.05, 0.05, 0.4, 0.5, 0.5,0.04, 0.7, 0.7, 0.078125);
   22:renderTeapot (0.0, 0.05, 0.0, 0.4, 0.5, 0.4,0.04, 0.7, 0.04, 0.078125);
   23:renderTeapot (0.05, 0.0, 0.0, 0.5, 0.4, 0.4,0.7, 0.04, 0.04, 0.078125);
   24:renderTeapot (0.05, 0.05, 0.05, 0.5, 0.5, 0.5,0.7, 0.7, 0.7, 0.078125);
   25:renderTeapot (0.05, 0.05, 0.0, 0.5, 0.5, 0.4,0.7, 0.7, 0.04, 0.078125);
*)            end;
  for i:=0 to 3 do
   begin
    front_mat_emission[i]:=emission[i];
    front_mat_specular[i]:=specular[i];
    front_mat_diffuse[i]:=diffuse[i];
    front_mat_ambient[i]:=ambient[i];
   end;
 front_mat_shininess[0]:={128*}shininess[0] ;
 Lambient[0]:=0;     Lambient[1]:=0;     Lambient[2]:=0;      Lambient[3]:=1.0;
 Lmodel_ambient[0]:=1.0;  lmodel_ambient[1]:=1.0;   lmodel_ambient[2]:=1.0;   lmodel_ambient[3]:=1.0;
 Ldiffuse[0]:=1.0;     Ldiffuse[1]:=1.0;    Ldiffuse[2]:=1.0;      Ldiffuse[3]:=1.0;
 position0[0]:=-20.0;
 position0[0]:=-20.0;
 position0[2]:=20.0;
 position0[3]:=0.0;
 position1[0]:=-20.0;
 position1[1]:=-20.0;
 position1[2]:=-20.0;
 position1[3]:=0.0;
 InitMaterials;
 TrackBarSH.position:= round(front_mat_shininess[0]);
 TrackBarRS.position:= round(front_mat_specular[0]*255);
 TrackBarGS.position:= round(front_mat_specular[1]*255);
 TrackBarBS.position:= round(front_mat_specular[2]*255);
 TrackBarRD.position:= round(front_mat_diffuse[0]*255);
 TrackBarGD.position:= round(front_mat_diffuse[1]*255);
 TrackBarBD.position:= round(front_mat_diffuse[2]*255);
 Material.text:=Material.Items[ColorMaterial];

 if assigned(ActiveGLW) then ActiveGLW.ColorMaterialGLW:=ColorMaterial;

 top:=Main.clientHeight-self.Height-15;
 left:=Main.ClientWidth-self.width-5;

 H:=ClientHeight-Panel1.Height;;
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
  glMatrixMode(GL_PROJECTION);
   glLoadIdentity;
   glViewport(ClientX0,ClientY0, ClientHW, ClientHW);
 //  glScissor(ClientX0,ClientY0, ClientHW, ClientHW);
   glMatrixMode(GL_MODELVIEW);
   glLoadIdentity;
   glRotatef( 180, 0.0, 1.0, 0.0 );
   glRotatef( -120, 1.0, 0.0, 0.0 );
   glRotatef( 210, 0.0, 0.0, 1.0 );
 wglMakeCurrent(0, 0);
 ReleaseDC(Handle,DC);
 clSp:=RGBToColor(Byte(TrackBarRS.position),bYTE(TrackBarGS.position),BYTE(TrackBarBS.position));
 clEm:=RGBToColor(Byte(TrackBarRE.position),bYTE(TrackBarGE.position),BYTE(TrackBarBE.position));
 clD :=RGBToColor(Byte(TrackBarRD.position),bYTE(TrackBarGD.position),BYTE(TrackBarBD.position));
 with ImageSp do
        begin
         Canvas.Brush.Color:=clSp;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,ImageSp.Width,ImageSp.Height));
        end;
 //        ImageSp.repaint;
 with ImageEm do
        begin
         Canvas.Brush.Color:=clEm;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,ImageEm.Width,ImageEm.Height));
        end;
 with ImageD do
        begin
         Canvas.Brush.Color:=clD;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,ImageD.Width,ImageD.Height));
        end;
end;

procedure TSetMaterialOption.FormDestroy(Sender: TObject);
begin
       DeleteDC (DC);
       vSetMaterialOpt:=nil;
end;

procedure TSetMaterialOption.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TSetMaterialOption.FormPaint(Sender: TObject);
var ps:PAINTSTRUCT;
begin
  with ImageSp.Canvas do
        begin
         Canvas.Brush.Color:=clRed{Sp};     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,ImageSp.Width,ImageSp.Height));
        end;
 DC:=GetDC(Handle);
 wglMakeCurrent(DC, hrc);
  BeginPaint(Handle, ps);
   InitMaterials;
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glPushMatrix;
      glutSolidSphere(0.8, 100,100);
    glPopMatrix;
    SwapBuffers(DC);
  EndPaint (Handle,ps);
  wglMakeCurrent(0, 0);
 ReleaseDC(Handle,DC);
end;

procedure TSetMaterialOption.TrackBarRSChange(Sender: TObject);
var clSP:TColor;
begin
(* if Material.Text<>'Custom' then
 begin
  Material.Text:='Custom';
 // Material.Items.add(Material.Text);
 ActiveGLW.ColorMaterialGLW:= Material.Items.indexof(Material.Text);
 end;
*)
  front_mat_specular[0]:=TrackBarRS.position/255;
  clSp:=RGBToColor(Byte(TrackBarRS.position),bYTE(TrackBarGS.position),BYTE(TrackBarBS.position));
  with ImageSp do
        begin
         Canvas.Brush.Color:=clSp;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,ImageSp.Width,ImageSp.Height));
        end;
  ImageSp.RePaint;
 if assigned(ActiveGLW) then
  begin
    ActiveGLW.front_mat_specular[0]:=TrackBarRS.position/255;
    ActiveGLW.Optionlight;
  end;
    InitMaterials;
    InvalidateRect(Handle, nil, False);
end;

procedure TSetMaterialOption.TrackBarBSChange(Sender: TObject);
var clSp:Tcolor;
begin
(*
 if Material.Text<>'Custom' then
 begin
  Material.Text:='Custom';
 // Material.Items.add(Material.Text);
 // ActiveGLW.ColorMaterialGLW:= Material.Items.Count-1;
  ActiveGLW.ColorMaterialGLW:= Material.Items.indexof(Material.Text);
 end;
*)
  front_mat_specular[2]:=TrackBarBS.position/255;
  clSp:=RGBToColor(Byte(TrackBarRS.position),bYTE(TrackBarGS.position),BYTE(TrackBarBS.position));
  with ImageSp do
        begin
         Canvas.Brush.Color:=clSp;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,ImageSp.Width,ImageSp.Height));
        end;
 if assigned(ActiveGLW) then
 begin
  ActiveGLW.front_mat_specular[2]:=TrackBarBS.position/255;
  ActiveGLW.OptionLight;
 end;
    InitMaterials;
    InvalidateRect(Handle, nil, False);
end;

procedure TSetMaterialOption.TrackBarGSChange(Sender: TObject);
var clSp:Tcolor;
begin
(*
if Material.Text<>'Custom' then
 begin
  Material.Text:='Custom';
//  Material.Items.add(Material.Text);
 // ActiveGLW.ColorMaterialGLW:= Material.Items.Count-1;
  ActiveGLW.ColorMaterialGLW:= Material.Items.indexof(Material.Text);
end;
*)
  front_mat_specular[1]:=TrackBarGS.position/255;
  clSp:=RGBToColor(Byte(TrackBarRS.position),bYTE(TrackBarGS.position),BYTE(TrackBarBS.position));
     with ImageSp do
        begin
         Canvas.Brush.Color:=clSp;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,ImageSp.Width,ImageSp.Height));
        end;
 if assigned(ActiveGLW) then
  begin
   ActiveGLW.front_mat_specular[1]:=TrackBarGS.position/255;
   ActiveGLW.OptionLight;
  end;
   InitMaterials;
   InvalidateRect(Handle, nil, False);
end;

procedure TSetMaterialOption.TrackBarREChange(Sender: TObject);
var clEm:Tcolor;
begin
(*  if Material.Text<>'Custom' then
 begin
  Material.Text:='Custom';
 // Material.Items.add(Material.Text);
 // ActiveGLW.ColorMaterialGLW:= Material.Items.Count-1;
  ActiveGLW.ColorMaterialGLW:= Material.Items.indexof(Material.Text);
end;
 *)
  front_mat_emission[0]:=TrackBarRE.position/255;
  clEm:=RGBToColor(Byte(TrackBarRE.position),bYTE(TrackBarGE.position),BYTE(TrackBarBE.position));
      with ImageEm do
        begin
         Canvas.Brush.Color:=clEm;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;

 if assigned(ActiveGLW) then
  begin
   ActiveGLW.front_mat_emission[0]:=TrackBarRE.position/255;
   ActiveGLW.OptionLight;
  end;
   InitMaterials;
   InvalidateRect(Handle, nil, False);
end;

procedure TSetMaterialOption.TrackBarGEChange(Sender: TObject);
var clEm:Tcolor;
begin
(*   if Material.Text<>'Custom' then
 begin
  Material.Text:='Custom';
 // Material.Items.add(Material.Text);
 // ActiveGLW.ColorMaterialGLW:= Material.Items.Count-1;
 ActiveGLW.ColorMaterialGLW:= Material.Items.indexof(Material.Text);
 end;
 *)
   front_mat_emission[0]:=TrackBarGE.position/255;
  clEm:=RGBToColor(Byte(TrackBarRE.position),bYTE(TrackBarGE.position),BYTE(TrackBarBE.position));
  with ImageEm do
        begin
         Canvas.Brush.Color:=clEm;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;

 if assigned(ActiveGLW) then
 begin
   ActiveGLW.front_mat_emission[1]:=TrackBarGE.position/255;
   ActiveGLW.OptionLight;
 end;
   InitMaterials;
   InvalidateRect(Handle, nil, False);
end;

procedure TSetMaterialOption.TrackBarBEChange(Sender: TObject);
var clEm:Tcolor;
begin
(*  if Material.Text<>'Custom' then
 begin
  Material.Text:='Custom';
 // Material.Items.add(Material.Text);
 // ActiveGLW.ColorMaterialGLW:= Material.Items.Count-1;
 ActiveGLW.ColorMaterialGLW:= Material.Items.indexof(Material.Text);
 end;
*)
  front_mat_emission[0]:=TrackBarBE.position/255;
  clEm:=RGBToColor(Byte(TrackBarRE.position),bYTE(TrackBarGE.position),BYTE(TrackBarBE.position));
     with ImageEm do
        begin
         Canvas.Brush.Color:=clEm;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;

 if assigned(ActiveGLW) then
 begin
   ActiveGLW.front_mat_emission[2]:=TrackBarBE.position/255;
   ActiveGLW.OptionLight;
 end;
   InitMaterials;
   InvalidateRect(Handle, nil, False);
end;

procedure TSetMaterialOption.BitBtnDClick(Sender: TObject);
begin
    case PageControl1.ActivePageIndex of
 0:begin
      front_mat_specular[0]  :=0.366065;// 0.633;
      front_mat_specular[1]  :=0.555802;//0.727811;
      front_mat_specular[2]  :=0.628281;// 0.633;
      front_mat_specular[3]  :=1.0;
      trackBarRS.Position:=round(front_mat_specular[0]*255);
      trackBarBS.Position:=round(front_mat_specular[1]*255);
      trackBarGS.Position:=round(front_mat_specular[2]*255);
   end;
 1:begin
      front_mat_emission[0]:=0.0;
      front_mat_emission[1]:=0.0;
      front_mat_emission[2]:=0.0;
      front_mat_emission[3]:=0.0;
      trackBarRE.Position:=round(front_mat_emission[0]*255);
      trackBarBE.Position:=round(front_mat_emission[1]*255);
      trackBarGE.Position:=round(front_mat_emission[2]*255);
   end;
 2:begin
      front_mat_shininess[0] :=128*0.4;//.6;
      trackBarSH.Position:=round(front_mat_shininess[0]);
   end;
 3:begin
      front_mat_diffuse[0]:=0.07568;
      front_mat_diffuse[1]:=0.61424;
      front_mat_diffuse[2]:=0.07568;
      front_mat_diffuse[3]:=1.0;
      trackBarRD.Position:=round(front_mat_diffuse[0]*255);
      trackBarBD.Position:=round(front_mat_diffuse[1]*255);
      trackBarGD.Position:=round(front_mat_diffuse[2]*255);
   end;
       end;
      ColorMaterial:=0;
      materialSelect(Sender);
      InitMaterials;
if assigned(ActiveGLW) then
begin
    with ActiveGLW do
    begin
     Material(sender);
(*(      front_mat_specular[0]  :=0.366065;// 0.633;
      front_mat_specular[1]  :=0.555802;//0.727811;
      front_mat_specular[2]  :=0.628281;// 0.633;
      front_mat_specular[3]  :=1.0;
      front_mat_emission[0]:=0.0;
      front_mat_emission[1]:=0.0;
      front_mat_emission[2]:=0.0;
      front_mat_emission[3]:=0.0;
      front_mat_shininess[0] :=128*0.4;//.6;
      front_mat_diffuse[0]:=0.07568;
      front_mat_diffuse[1]:=0.61424;
      front_mat_diffuse[2]:=0.07568;
      front_mat_diffuse[3]:=1.0;
*)
    end;
    ActiveGLW.OptionLight;
 end;
   InvalidateRect(Handle, nil, False);
 (*
             ambient[0]:=0.0745;//0.0215;
             ambient[1]:=0.1995;//0.1745;
             ambient[2]:=0.24725;//0.0215;
             ambient[3]:=1.0;
             shininess[0] :=0.6;
             specular[0]  :=0.633;
             specular[1]  :=0.727811;
             specular[2]  :=0.633;
             specular[3]  :=1.0;

             ambient[0]:=0.0215;
             ambient[1]:=0.1745;
             ambient[2]:=0.0215;
             ambient[3]:=1.0;
  *)
end;

procedure TSetMaterialOption.TrackBarSHChange(Sender: TObject);
begin
(*  if Material.Text<>'Custom' then
 begin
  Material.Text:='Custom';
 // Material.Items.add(Material.Text);
 // ActiveGLW.ColorMaterialGLW:= Material.Items.Count-1;
 ActiveGLW.ColorMaterialGLW:= Material.Items.indexof(Material.Text);

 end;
*)
   front_mat_shininess[0]:=TrackBarSH.position;
if assigned(ActiveGLW) then
 begin
   ActiveGLW.front_mat_shininess[0]:=TrackBarSH.position;
   ActiveGLW.OptionLight;
 end;
   InitMaterials;
   InvalidateRect(Handle, nil, False);
   labelSH.Caption:=inttostr(TrackBarSH.position);
end;

procedure TSetMaterialOption.TrackBarRDChange(Sender: TObject);
var clD:Tcolor;
begin
(* if Material.Text<>'Custom' then
 begin
  Material.Text:='Custom';
 // Material.Items.add(Material.Text);
 // ActiveGLW.ColorMaterialGLW:= Material.Items.Count-1;
   ActiveGLW.ColorMaterialGLW:= Material.Items.indexof(Material.Text);

 end;
*)
   clD:=RGBToColor(Byte(TrackBarRD.position),bYTE(TrackBarGD.position),BYTE(TrackBarBD.position));
  with ImageD do
        begin
         Canvas.Brush.Color:=clD;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;
   front_mat_diffuse[0]:=TrackBarRD.position/255;
 if assigned(ActiveGLW) then
 begin
   ActiveGLW.front_mat_diffuse[0]:=TrackBarRD.position/255;
   ActiveGLW.OptionLight;
 end;
   InitMaterials;
   InvalidateRect(Handle, nil, False);
end;

procedure TSetMaterialOption.TrackBarGDChange(Sender: TObject);
var clD:Tcolor;
begin
(* if Material.Text<>'Custom' then
 begin
  Material.Text:='Custom';
 // Material.Items.add(Material.Text);
 // ActiveGLW.ColorMaterialGLW:= Material.Items.Count-1;
  ActiveGLW.ColorMaterialGLW:= Material.Items.indexof(Material.Text);
 end;
*)
   clD:=RGBToColor(Byte(TrackBarRD.position),bYTE(TrackBarGD.position),BYTE(TrackBarBD.position));
  with ImageD do
        begin
         Canvas.Brush.Color:=clD;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;
   front_mat_diffuse[1]:=TrackBarGD.position/255;
 if assigned(ActiveGLW) then
  begin
   ActiveGLW.front_mat_diffuse[1]:=TrackBarGD.position/255;
   ActiveGLW.OptionLight;
  end;
   InitMaterials;
   InvalidateRect(Handle, nil, False);
end;

procedure TSetMaterialOption.TrackBarBDChange(Sender: TObject);
 var clD:Tcolor;
begin
(* if Material.Text<>'Custom' then
 begin
  Material.Text:='Custom';
 // Material.Items.add(Material.Text);
 // ActiveGLW.ColorMaterialGLW:= Material.Items.Count-1;
  ActiveGLW.ColorMaterialGLW:= Material.Items.indexof(Material.Text);
 end;
*)
   clD:=RGBToColor(Byte(TrackBarRD.position),bYTE(TrackBarGD.position),BYTE(TrackBarBD.position));
  with ImageD do
        begin
         Canvas.Brush.Color:=clD;     {Очистка картины}
         Canvas.Brush.Style:=bsSolid;
         Canvas.FillRect(Rect(0,0,Width,Height));
        end;
  front_mat_diffuse[2]:=TrackBarBD.position/255;
 if assigned(ActiveGLW) then
  begin
   ActiveGLW.front_mat_diffuse[2]:=TrackBarBD.position/255;
   ActiveGLW.OptionLight;
  end;
   InitMaterials;
   InvalidateRect(Handle, nil, False);
end;
end.
