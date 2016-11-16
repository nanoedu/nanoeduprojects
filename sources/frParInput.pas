unit frParInput;

interface

uses 
  Windows,  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, siComp, siLngLnk;

type
  TFrameParInput = class(TFrame)
    frPanel: TPanel;
    LabelFrm: TLabel;
    BitBtnFrm: TBitBtn;
    EditFrm: TEdit;
    ScrollBarFrm: TScrollBar;
    LabelUnit: TLabel;
    siLangLinked1: TsiLangLinked;
    procedure BitBtnFrmClick(Sender: TObject);
    procedure ScrollBarFrmScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure EditFrmChange(Sender: TObject);
    procedure EditFrmKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
      ValueMax,ValueMin,ValueStart,Value:integer;
  constructor Create(AOwner: TComponent); override;
end;

implementation

{$R *.DFM}
uses mMain;

constructor TFrameParInput.Create(AOwner: TComponent);
begin
 inherited;
   ScrollBarFrm.Max:=100;
   ScrollBarFrm.Min:=0;
   ScrollBarFrm.Position:=50;
   ScrollBarFrm.Visible:=true;//False;
   EditFrm.Font.Color:=clBlack;
   EditFrm.Text:='';
end;

procedure TFrameParInput.BitBtnFrmClick(Sender: TObject);
begin
   ScrollBarFrm.Visible:=True;
 if  (EditFrm.Text<>'')  and (EditFrm.Text<>'-') then ScrollBarFrm.Position:=StrtoInt(EditFrm.Text);
end;



procedure TFrameParInput.ScrollBarFrmScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   with ScrollBarFRm do
    begin
      case ScrollCode of
   scLineUp,scLinedown :
                begin
                 Value:=ScrollPos{*(ValueMax-ValueMin)/(Max-Min)};
                 EditFrm.Text:=IntToStr(Value);
               end;
   scTrack:    begin
                 Value:=ScrollPos{*(ValueMax-ValueMin)/(Max-Min)};
                 EditFrm.Text:=IntToStr(Value);
               end;
  scEndScroll: begin
                 Value:=ScrollPos{*(ValueMax-ValueMin)/(Max-Min)};
                 EditFrm.Text:=IntToStr(value);
            //     ScrollBarFrm.Visible:=False
               end;
           end;
        end;
end;

procedure TFrameParInput.EditFrmChange(Sender: TObject);
var Np:integer;
    val:integer;
begin
  try
  if (EditFrm.text='') and (EditFrm.Text='-') then exit;
    val:=strtoint(EditFrm.Text);
   if  val<ScrollBarFrm.Min then
   begin
     EditFrm.Text:=inttostr(ScrollBarFrm.Min);
   end;
   if  val>ScrollBarFrm.Max then
   begin
      EditFrm.Text:=inttostr(ScrollBarFrm.Max);
   end;
   if (EditFrm.Text<>'') or (EditFrm.Text<>'-')  then NP:=StrToInt(EditFrm.Text);
  except
   on EConvertError do
    begin EditFrm.text:='1'end;
  end;
    ScrollBarFrm.Position:=StrtoInt(EditFrm.Text);
end;

procedure TFrameParInput.EditFrmKeyPress(Sender: TObject; var Key: Char);
begin
   if not(Key in ['-','0'..'9',#8]) then Key :=#0;
end;

end.
