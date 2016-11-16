unit ViewOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons,GlobalVar;

type
  TfrViewOption = class(TForm)
    PageControl1: TPageControl;
    TabSheetL: TTabSheet;
    TabSheet4: TTabSheet;
    Panel1: TPanel;
    PanelL: TPanel;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheetM: TTabSheet;
    TrackBar1: TTrackBar;
    TabSheetG: TTabSheet;
    Panel3: TPanel;
    PanelBottom: TPanel;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    TrackBar2: TTrackBar;
    TrackBarX1: TTrackBar;
    TrackBarZ1: TTrackBar;
    TrackBarY1: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PanelC: TPanel;
    Label6: TLabel;
    TrackBarX2: TTrackBar;
    Label7: TLabel;
    Label8: TLabel;
    TrackBarY2: TTrackBar;
    Label9: TLabel;
    TrackBarZ2: TTrackBar;
    Label10: TLabel;
    Label11: TLabel;
    procedure TrackBarX1Change(Sender: TObject);
    procedure TrackBarY1Change(Sender: TObject);
    procedure TrackBarZ1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrackBarX2Change(Sender: TObject);
    procedure TrackBarY2Change(Sender: TObject);
    procedure TrackBarZ2Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure UpdatePosition;
  end;

var
  frViewOption: TfrViewOption;

implementation

{$R *.dfm}

uses OpenGlDraw;
procedure TfrViewOption.UpdatePosition;
begin
       TrackBarX1.position:=round(ActiveGLW.position0[0]);
       TrackBarY1.position:=round(ActiveGLW.position0[1]);
       TrackBarZ1.position:=round(ActiveGLW.position0[2]);
       TrackBarX2.position:=round(ActiveGLW.position1[0]);
       TrackBarY2.position:=round(ActiveGLW.position1[1]);
       TrackBarZ2.position:=round(ActiveGLW.position1[2]);

end;
procedure TfrViewOption.TrackBarX1Change(Sender: TObject);
begin
 ActiveGLW.position0[0]:=TrackBarX1.position;
 ActiveGLW.OptionLight
 //   positionL0[0]:=TrackBarX1.position;
end;

procedure TfrViewOption.TrackBarY1Change(Sender: TObject);
begin
 ActiveGLW.position0[1]:=TrackBarY1.position;
  ActiveGLW.OptionLight
  //  positionL0[1]:=TrackBarY1.position;
end;

procedure TfrViewOption.TrackBarZ1Change(Sender: TObject);
begin
    ActiveGLW.position0[2]:=TrackBarZ1.position;
    ActiveGLW.OptionLight
 // positionL0[2]:=TrackBarZ1.position
end;

procedure TfrViewOption.FormCreate(Sender: TObject);
begin
       TrackBarX1.position:=round(ActiveGLW.position0[0]);
       TrackBarY1.position:=round(ActiveGLW.position0[1]);
       TrackBarZ1.position:=round(ActiveGLW.position0[2]);
       TrackBarX2.position:=round(ActiveGLW.position1[0]);
       TrackBarY2.position:=round(ActiveGLW.position1[1]);
       TrackBarZ2.position:=round(ActiveGLW.position1[2]);
end;

procedure TfrViewOption.BitBtn2Click(Sender: TObject);
begin
      ActiveGLW.position0[0]:=TrackBarX1.position;
      ActiveGLW.position0[1]:=TrackBarY1.position;
      ActiveGLW.position0[2]:=TrackBarZ1.position;
      ActiveGLW.position1[0]:=TrackBarX2.position;
      ActiveGLW.position1[1]:=TrackBarY2.position;
      ActiveGLW.position1[2]:=TrackBarZ2.position;
      close;
end;

procedure TfrViewOption.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
   Action:=caFree;
end;

procedure TfrViewOption.TrackBarX2Change(Sender: TObject);
begin
   ActiveGLW.position1[0]:=TrackBarX2.position;
   ActiveGLW.OptionLight
end;

procedure TfrViewOption.TrackBarY2Change(Sender: TObject);
begin
     ActiveGLW.position1[1]:=TrackBarY2.position;
    ActiveGLW.OptionLight

end;

procedure TfrViewOption.TrackBarZ2Change(Sender: TObject);
begin
    ActiveGLW.position1[2]:=TrackBarZ2.position;
    ActiveGLW.OptionLight
end;

procedure TfrViewOption.BitBtn1Click(Sender: TObject);
begin
       TrackBarX1.position:=-20;
       TrackBarY1.position:=-20;
       TrackBarZ1.position:=20;
       TrackBarX2.position:=-20;
       TrackBarY2.position:=-20;
       TrackBarZ2.position:=-20;
       ActiveGLW.position0[0]:=TrackBarX1.position;
      ActiveGLW.position0[1]:=TrackBarY1.position;
      ActiveGLW.position0[2]:=TrackBarZ1.position;
      ActiveGLW.position1[0]:=TrackBarX2.position;
      ActiveGLW.position1[1]:=TrackBarY2.position;
      ActiveGLW.position1[2]:=TrackBarZ2.position;
      ActiveGLW.OptionLight
end;

procedure TfrViewOption.BitBtn3Click(Sender: TObject);
begin
   Close;
end;

end.
