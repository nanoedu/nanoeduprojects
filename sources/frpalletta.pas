unit frpalletta;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OpenGL,globalvar, StdCtrls, ExtCtrls;
type

 TfrmPalletta = class(TForm)
    Panel1: TPanel;
    material: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure materialSelect(Sender: TObject);
  private
    DC : HDC;
    hrc: HGLRC;
    ClientX0,ClientY0:integer;
    position0           : array[0..3] of GLfloat ;
    position1           : array[0..3] of GLfloat ;
    front_mat_shininess : array[0..0] of GLfloat;
    front_mat_specular  : array[0..3] of GLfloat;
    front_mat_diffuse   : array[0..3] of GLfloat;
    front_mat_ambient   : array[0..3] of GLfloat;
    procedure   InitMaterials;
  end;
var
  frmPalletta: TfrmPalletta;
  quadObj : GLUquadricObj;
implementation

{$R *.DFM}
 uses  OpenGlDraw;
procedure glutSolidSphere(Radius : GLdouble; Slices : GLint; Stacks : GLint);
begin { glutSolidSphere }
  if quadObj = nil then    quadObj := gluNewQuadric;
  gluQuadricDrawStyle(quadObj, GLU_FILL);
  gluQuadricNormals(quadObj, GLU_SMOOTH);
  gluSphere(quadObj, Radius, Slices, Stacks);
end; { glutSolidSphere }

procedure   TfrmPalletta.InitMaterials;
const
      Lambient : Array [0..3] of GLfloat = (0.0, 0.0, 0.0, 1.0);
      Ldiffuse : Array [0..3] of GLfloat = (1.0, 1.0, 1.0, 1.0);
 lmodel_ambient: Array [0..3] of GLfloat = ( 1.0, 1.0, 1.0, 1.0 );
var i:integer;
 begin
  for i:=0 to 3 do
   begin
    front_mat_specular[i]:=specular[i];
    front_mat_diffuse[i]:=diffuse[i];
    front_mat_ambient[i]:=ambient[i];
   end;
 front_mat_shininess[0]:=128*shininess[0] ;
 position0[0]:=-20.0;
 position0[0]:=-20.0;
 position0[2]:=20.0;
 position0[3]:=0.0;
 position1[0]:=-20.0;
 position1[1]:=-20.0;
 position1[2]:=-20.0;
 position1[3]:=0.0;
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
 glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, @front_mat_shininess);
 glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, @front_mat_specular);
 glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, @front_mat_diffuse);
 glMaterialfv(GL_FRONT_AND_BACK, GL_ambient, @front_mat_ambient);
end;

procedure TfrmPalletta.FormPaint(Sender: TObject);
var ps:PAINTSTRUCT;
begin
 DC:=GetDC(Handle);
 wglMakeCurrent(DC, hrc);
  BeginPaint(Handle, ps);
   InitMaterials;
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glPushMatrix;
     glutSolidSphere(0.6, 100,100);
    glPopMatrix;
    SwapBuffers(DC);
  EndPaint (Handle,ps);
  wglMakeCurrent(0, 0);
 ReleaseDC(handle,DC);
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

procedure TfrmPalletta.FormCreate(Sender: TObject);
begin
 width:=height;
 DC := GetDC (Handle);
 SetDCPixelFormat(DC);
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
 Material.ItemIndex:= ColorMaterial;
 case ColorMaterial of
   0: renderTeapot (0.0215, 0.1745, 0.0215,0.07568, 0.61424, 0.07568, 0.633, 0.727811, 0.633, 0.6);
   1: renderTeapot (0.329412, 0.223529, 0.027451, 0.780392, 0.568627, 0.113725, 0.992157, 0.941176, 0.807843,0.21794872);
   2: renderTeapot (0.2125, 0.1275, 0.054,0.714, 0.4284, 0.18144, 0.393548, 0.271906, 0.166721, 0.2);
   3: renderTeapot (0.25, 0.25, 0.25,0.4, 0.4, 0.4, 0.774597, 0.774597, 0.774597, 0.6);
   4: renderTeapot (0.19125, 0.0735, 0.0225,0.7038, 0.27048, 0.0828, 0.256777, 0.137622, 0.086014, 0.1);
   5: renderTeapot (0.24725, 0.1995, 0.0745,0.75164, 0.60648, 0.22648, 0.628281, 0.555802, 0.366065, 0.4);
   6: renderTeapot (0.19225, 0.19225, 0.19225,0.50754, 0.50754, 0.50754, 0.508273, 0.508273, 0.508273, 0.4);
   7: renderTeapot (0.135, 0.2225, 0.1575, 0.54, 0.89, 0.63, 0.316228, 0.316228, 0.316228, 0.1);
   8: renderTeapot (0.05375, 0.05, 0.06625,0.18275, 0.17, 0.22525, 0.332741, 0.328634, 0.346435, 0.3);
   9: renderTeapot (0.25, 0.20725, 0.20725,1, 0.829, 0.829, 0.296648, 0.296648, 0.296648, 0.088);
   10:renderTeapot (0.1745, 0.01175, 0.01175,0.61424, 0.04136, 0.04136, 0.727811, 0.626959, 0.626959, 0.6);
   11:renderTeapot (0.1, 0.18725, 0.1745, 0.396, 0.74151, 0.69102, 0.297254, 0.30829, 0.306678, 0.1);
   12:renderTeapot (0.24725, 0.1995, 0.0745,0.75164, 0.60648, 0.22648, 0.628281, 0.555802, 0.366065, 0.4);
   13:renderTeapot (0.19225, 0.19225, 0.19225,0.50754, 0.50754, 0.50754, 0.508273, 0.508273, 0.508273, 0.4);
   14:renderTeapot (0.0, 0.0, 0.0, 0.01, 0.01, 0.01, 0.50, 0.50, 0.50, 0.25);
   15:renderTeapot (0.0, 0.1, 0.06, 0.0, 0.50980392, 0.50980392, 0.50196078, 0.50196078, 0.50196078, 0.25);
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
            end;
 //InitMaterials;
  wglMakeCurrent(0, 0);
 ReleaseDC(handle,DC);
end;

procedure TfrmPalletta.FormDestroy(Sender: TObject);
begin
// wglMakeCurrent(0, 0);
// wglDeleteContext(hrc);
// ReleaseDC (Handle, DC);
 DeleteDC (DC);
end;
procedure TfrmPalletta.FormResize(Sender: TObject);
 var H,W,ClientHW:Integer;
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
 glViewport(ClientX0, Panel1.Height+ClientY0, ClientHW, ClientHW);
 glMatrixMode(GL_PROJECTION);
 glLoadIdentity;
 glMatrixMode(GL_MODELVIEW);
 InvalidateRect(Handle, nil, False);
end;

procedure TfrmPalletta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=cafree;
end;

procedure TfrmPalletta.materialSelect(Sender: TObject);
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
   7: renderTeapot (0.135, 0.2225, 0.1575, 0.54, 0.89, 0.63, 0.316228, 0.316228, 0.316228, 0.1);
   8: renderTeapot (0.05375, 0.05, 0.06625,0.18275, 0.17, 0.22525, 0.332741, 0.328634, 0.346435, 0.3);
   9: renderTeapot (0.25, 0.20725, 0.20725,1, 0.829, 0.829, 0.296648, 0.296648, 0.296648, 0.088);
   10:renderTeapot (0.1745, 0.01175, 0.01175,0.61424, 0.04136, 0.04136, 0.727811, 0.626959, 0.626959, 0.6);
   11:renderTeapot (0.1, 0.18725, 0.1745, 0.396, 0.74151, 0.69102, 0.297254, 0.30829, 0.306678, 0.1);
   12:renderTeapot (0.24725, 0.1995, 0.0745,0.75164, 0.60648, 0.22648, 0.628281, 0.555802, 0.366065, 0.4);
   13:renderTeapot (0.19225, 0.19225, 0.19225,0.50754, 0.50754, 0.50754, 0.508273, 0.508273, 0.508273, 0.4);
   14:renderTeapot (0.0, 0.0, 0.0, 0.01, 0.01, 0.01, 0.50, 0.50, 0.50, 0.25);
   15:renderTeapot (0.0, 0.1, 0.06, 0.0, 0.50980392, 0.50980392, 0.50196078, 0.50196078, 0.50196078, 0.25);
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
            end;
          ColorMaterial:=ItemIndex;
       end;
   InitMaterials;
   InvalidateRect(Handle, nil, False);
   ActiveGLW.Palletta(Sender);
end;

end.










