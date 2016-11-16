unit frAmbulanceHint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TAmbulanceHint = class(TForm)
    Memo1: TMemo;
    BitBtnClose: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Memo1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Memo1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Memo1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    xwait,ywait:integer;
    flgmove:boolean;
    x0,y0,top0,left0:integer;

      procedure CreateOddWindow(AHandle:THandle; ShowTitleBar:boolean);
      procedure WMMove(var Mes:TWMMove); message WM_Move;
      procedure WMNCHitTest(var M: TWMNCHitTest); message wm_NCHitTest;
  public
    { Public declarations }
      xcurrent,ycurrent:integer;
      procedure movetoshowpoint;
      procedure movetowaitpoint;
  end;

var
  AmbulanceHint: TAmbulanceHint;

implementation

uses frAmbulance;

{$R *.dfm}
procedure TAmbulanceHint.WMNCHitTest(var M: TWMNCHitTest);
begin
  inherited;            //вызываем стандартный обработчик
  if M.Result = htClient then   M.Result := htCaption;
end;
  procedure TAmbulanceHint.WMMOve(var Mes:TWMMove);
begin
//    if Mes.YPos<Main.ToolBar1.Height+5 then Top:=Main.ToolBar1.Height+5;
end;
 procedure   TAmbulanceHint.CreateOddWindow(AHandle:THandle; ShowTitleBar:boolean);
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
  R1, R2,R3 : hRgn;
  dx : integer;
  dy : integer;
  Points : array [0..28] of TPoint;
begin
  dx := GetSystemMetrics(SM_CXFRAME);
  dy := GetSystemMetrics(SM_CYCAPTION)+GetSystemMetrics(SM_CYFRAME);

  if ShowTitleBar then
    R1 := CreateRectRgn(0, 0, 400 + dx*2 , dy )  //Obs! The client area of the form should be of the same width as the image you used to generate the source
  else
    R1 := CreateRectRgn(0,0,0,0);

  R3:= CreateRectRgn(dx+BitBtnClose.left,dy+BitBtnClose.top,dx+BitBtnClose.left+BitBtnClose.width,dy+BitBtnClose.top+BitBtnClose.height);


  Points[0]:=Point(46 + dx,58 + dy);
  Points[1]:=Point(46 + dx,56 + dy);
  Points[2]:=Point(49 + dx,53 + dy);
  Points[3]:=Point(51 + dx,53 + dy);
  Points[4]:=Point(51 + dx,52 + dy);
  Points[5]:=Point(53 + dx,52 + dy);
  Points[6]:=Point(295 + dx,52 + dy);
  Points[7]:=Point(296 + dx,53 + dy);
  Points[8]:=Point(297 + dx,53 + dy);
  Points[9]:=Point(300 + dx,56 + dy);
  Points[10]:=Point(300 + dx,57 + dy);
  Points[11]:=Point(301 + dx,58 + dy);
  Points[12]:=Point(301 + dx,222 + dy);
  Points[13]:=Point(299 + dx,224 + dy);
  Points[14]:=Point(300 + dx,224 + dy);
  Points[15]:=Point(298 + dx,226 + dy);
  Points[16]:=Point(296 + dx,228 + dy);
  Points[17]:=Point(295 + dx,228 + dy);
  Points[18]:=Point(294 + dx,229 + dy);
  Points[19]:=Point(51 + dx,229 + dy);
  Points[20]:=Point(50 + dx,227 + dy);
  Points[21]:=Point(49 + dx,228 + dy);
  Points[22]:=Point(48 + dx,226 + dy);
  Points[23]:=Point(46 + dx,224 + dy);
  Points[24]:=Point(46 + dx,223 + dy);
  Points[25]:=Point(45 + dx,222 + dy);
  Points[26]:=Point(45 + dx,58 + dy);
  Points[27]:=Point(46 + dx,58 + dy);
  R2:=CreatePolygonRgn(Points[0],28,Winding);
  CombineRgn(R1,R1,R2,Rgn_XOR);
  CombineRgn(R2,R2,R3,Rgn_XOR);
  SetWindowRgn(AHandle,R2,True);
end;
procedure TAmbulanceHint.FormCreate(Sender: TObject);
begin
        CreateOddWindow(Handle,false);
        xwait:=Screen.width+100;
        ywait:=0;
        left:=100;//xwait;
        top:=100;//ywait;
        xcurrent:=xwait;
        ycurrent:=ywait;
end;

procedure TAmbulanceHint.BitBtnCloseClick(Sender: TObject);
begin
   close;
end;

procedure TAmbulanceHint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      action:=cafree;
     AmbulanceHint:=nil;
end;

procedure TAmbulanceHint.Memo1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   x0:=x;
   y0:=Y;
   top0:=top;
   left0:=left;
   flgmove:=true;
end;

procedure TAmbulanceHint.Memo1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if flgmove then
  begin
    top:=top+(y-y0);
    left:=left+(x-x0);
    xcurrent:=left;
    ycurrent:=top;
  end;
end;

procedure TAmbulanceHint.Memo1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    flgmove:=false;
end;

procedure TAmbulanceHint.movetoshowpoint;
 var x,y,i:integer;
begin
 if assigned(Ambulance) then
            begin
              x := Ambulance.Left+30;
              y := Ambulance.Top;
            end;
  for  i:=0 to 100 do
  begin
    left:=x-round((x-xcurrent)*(100-i)/100);
     top:=y-round((y-ycurrent)*(100-i)/100);
    SLEEP(10) ;
  end
end;


procedure TAmbulanceHint.movetowaitpoint;
var i:integer;
begin
  for  i:=0 to 100 do
  begin
    left:=xwait-round((xwait-xcurrent)*(100-i)/100);
    top :=ywait-round((ywait-ycurrent)*(100-i)/100);
  end;
end;


end.
