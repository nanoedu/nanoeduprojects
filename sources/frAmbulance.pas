unit frAmbulance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TAmbulance = class(TForm)
    Image1: TImage;
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1DblClick(Sender: TObject);
  private
    { Private declarations }
    xcurrent,ycurrent,xwait,ywait:integer;
    flgmove:boolean;
    x0,y0,top0,left0:integer;
    procedure GetMinMaxInfo(var Msg:TWMGETMINMAXINFO); message WM_GETMINMAXINFO;
  public
    { Public declarations }
    procedure movetoshowpoint;
    procedure movetowaitpoint;
  end;

var
  Ambulance: TAmbulance;

implementation

{$R *.dfm}
 uses   globalvar,CSPMHelp, frAmbulanceHint;
   var  FormWidth, FormHeight: integer;
procedure FindWidthHeight(Const Points : array of TPoint; Const Len: integer);
var
  i: integer;
begin
  for i:= 0 to Len do
  begin
    if (FormWidth<Points[i].x)  then     FormWidth:= Points[i].x;
    if (FormHeight<Points[i].y) then     FormHeight:= Points[i].y;
  end;
end;//function FindWidthHeight
procedure TAmbulance.GetMinMaxInfo(var Msg:TWMGETMINMAXINFO);
begin
  //     Constraints.Maxheight:=48;
 //      Constraints.Maxwidth:=48;
 //      Constraints.Minheight:=48;
 //      Constraints.Minwidth:=48;
end;
procedure TAmbulance.movetoshowpoint;
 var x,y,i:integer;
begin
 if assigned(Screen.ActiveForm) then
            begin
              x := Screen.ActiveForm.Left + (Screen.ActiveForm.Width div 2) - (Width div 2);
              y := Screen.ActiveForm.Top + (Screen.ActiveForm.Height div 2) - (Height div 2);
            end;
  for  i:=0 to 100 do
  begin
    left:=x-round((x-xcurrent)*(100-i)/100);
    top:=y-round((y-ycurrent)*(100-i)/100);
    SLEEP(10) ;
  end
end;


procedure TAmbulance.movetowaitpoint;
var i:integer;
begin
  for  i:=0 to 100 do
  begin
    left:=xwait-round((xwait-xcurrent)*(100-i)/100);
    top :=ywait-round((ywait-ycurrent)*(100-i)/100);
  end;
end;


procedure TAmbulance.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 if flgmove then
  begin
    top:=top+(y-y0);
   left:=left+(x-x0);
   xcurrent:=left;
   ycurrent:=top;
   AmbulanceHint.Top:=AmbulanceHint.Top+(y-y0);
   AmbulanceHint.left:=AmbulanceHint.left+(x-x0);
   AmbulanceHint.xcurrent:=AmbulanceHint.left;
   AmbulanceHint.ycurrent:=AmbulanceHint.top;
  end;
end;

procedure TAmbulance.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
x0:=x;
y0:=Y;
top0:=top;
left0:=left;
flgmove:=true;
end;

procedure TAmbulance.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   flgmove:=false;
end;

function CreateOddWindow(AHandle:THandle; ShowTitleBar:boolean):Tpoint;
//-----------------------------------------------------------------------------//
//   Automatic created procedure by Gabe's Odd Form Assistant                  //
//                                                                             //
//   Add this unit to the uses clause of the form you would like to transform. //
//   Call this procedure from the form's OnCreate event like this:             //
//                                                                             //
//   procedure TMyForm.FormCreate(Sender: TObject);                            //
//   begin                                                                     //
//     CreateOddWindow(Handle, False);                                         //
//   end;                                                                      //
//                                                                             //
//   Parameters:                                                               //
//     AHandle:  The Handle of the form you want to transform to this shape.   //
//     ShowTitleBar: Decide whether the titlebar of the form is visible or not.//
//                                                                             //
//   Obs! The client area of the form should be of the same width as the       //
//   image you used to generate the source.                                    //
//                                                                             //
//   Informatics 1998-2000, http://www.informatics.no                          //
//   Made by Gabe: gabrielsen@informatics.no                                   //
//-----------------------------------------------------------------------------//
var
  R1, R2 : hRgn;
  dx : integer;
  dy : integer;
  Points : array [0..62] of TPoint;
begin
  dx := GetSystemMetrics(SM_CXFRAME);
  dy := GetSystemMetrics(SM_CYCAPTION)+GetSystemMetrics(SM_CYFRAME);

  if ShowTitleBar then
    R1 := CreateRectRgn(0, 0, 48 + dx*2 , dy )  //Obs! The client area of the form should be of the same width as the image you used to generate the source
  else
    R1 := CreateRectRgn(0,0,0,0);

   Points[0]:=Point(1 + dx,26 + dy);
  Points[1]:=Point(1 + dx,24 + dy);
  Points[2]:=Point(3 + dx,22 + dy);
  Points[3]:=Point(3 + dx,21 + dy);
  Points[4]:=Point(6 + dx,18 + dy);
  Points[5]:=Point(6 + dx,17 + dy);
  Points[6]:=Point(7 + dx,16 + dy);
  Points[7]:=Point(7 + dx,15 + dy);
  Points[8]:=Point(9 + dx,13 + dy);
  Points[9]:=Point(9 + dx,12 + dy);
  Points[10]:=Point(11 + dx,10 + dy);
  Points[11]:=Point(13 + dx,10 + dy);
  Points[12]:=Point(15 + dx,10 + dy);
  Points[13]:=Point(15 + dx,9 + dy);
  Points[14]:=Point(18 + dx,6 + dy);
  Points[15]:=Point(18 + dx,3 + dy);
  Points[16]:=Point(20 + dx,3 + dy);
  Points[17]:=Point(40 + dx,3 + dy);
  Points[18]:=Point(41 + dx,4 + dy);
  Points[19]:=Point(44 + dx,4 + dy);
  Points[20]:=Point(45 + dx,5 + dy);
  Points[21]:=Point(46 + dx,5 + dy);
  Points[22]:=Point(48 + dx,7 + dy);
  Points[23]:=Point(48 + dx,33 + dy);
  Points[24]:=Point(46 + dx,35 + dy);
  Points[25]:=Point(43 + dx,35 + dy);
  Points[26]:=Point(42 + dx,36 + dy);
  Points[27]:=Point(41 + dx,36 + dy);
  Points[28]:=Point(39 + dx,38 + dy);
  Points[29]:=Point(37 + dx,38 + dy);
  Points[30]:=Point(36 + dx,39 + dy);
  Points[31]:=Point(37 + dx,39 + dy);
  Points[32]:=Point(35 + dx,41 + dy);
  Points[33]:=Point(36 + dx,41 + dy);
  Points[34]:=Point(36 + dx,42 + dy);
  Points[35]:=Point(34 + dx,43 + dy);
  Points[36]:=Point(8 + dx,43 + dy);
  Points[37]:=Point(7 + dx,41 + dy);
  Points[38]:=Point(6 + dx,42 + dy);
  Points[39]:=Point(5 + dx,42 + dy);
  Points[40]:=Point(4 + dx,40 + dy);
  Points[41]:=Point(3 + dx,41 + dy);
  Points[42]:=Point(2 + dx,39 + dy);
  Points[43]:=Point(1 + dx,40 + dy);
  Points[44]:=Point(0 + dx,38 + dy);
  Points[45]:=Point(0 + dx,26 + dy);
  Points[46]:=Point(1 + dx,26 + dy);
  R2:=CreatePolygonRgn(Points[0],47,Winding); 
  CombineRgn(R1,R1,R2,Rgn_XOR);
  SetWindowRgn(AHandle,R1,True);
  FindWidthHeight(Points,265);
  DeleteObject(r1);
  DeleteObject(r2);
  CreateOddWindow:= Point(FormWidth,FormHeight);
end;
procedure TAmbulance.FormCreate(Sender: TObject);
var FormCoord: TPoint;
 begin
       FormCoord:= CreateOddWindow(Handle,false);
//       Constraints.Maxheight:=48;
//       Constraints.Maxwidth:=48;
//       Constraints.Minheight:=48;
//       Constraints.Minwidth:=48;
        xwait:=Screen.width+100;
        ywait:=0;
        left:=xwait;
        top:=ywait;
        xcurrent:=xwait;
        ycurrent:=ywait;
end;

procedure TAmbulance.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=cafree;
 Ambulance:=nil;
end;

procedure TAmbulance.Image1DblClick(Sender: TObject);
begin
      HlpContext:=IDH_Turn_On;
     Application.HelpContext(HlpContext);
end;

end.
