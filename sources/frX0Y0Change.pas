//010205
unit frX0Y0Change;

interface

uses
  Windows, SysUtils, Variants, Classes,Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,GlobalType, siComp, siLngLnk;

type
  TfX0Y0Change = class(TForm)
    ScrollBarX0: TScrollBar;
    ScrollBarY0: TScrollBar;
    Label1: TLabel;
    Label2: TLabel;
    LabelX0: TLabel;
    LabelY0: TLabel;
    LabelX0A: TLabel;
    LabelY0A: TLabel;
    Label3: TLabel;
    EdX0A: TEdit;
    EdY0A: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    BitBtnOK: TBitBtn;
    BitBtn2: TBitBtn;
    siLangLinked1: TsiLangLinked;
    procedure ScrollBarX0Scroll(Sender: TObject; ScrollCode: TScrollCode;var ScrollPos: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ScrollBarY0Scroll(Sender: TObject; ScrollCode: TScrollCode;var ScrollPos: Integer);
    procedure EdX0AKeyPress(Sender: TObject; var Key: Char);
    procedure EdY0AKeyPress(Sender: TObject; var Key: Char);
    procedure EdY0AChange(Sender: TObject);
    procedure EdX0AChange(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    MaxShiftX0Y0:apitype;
    MinShiftX0Y0:apitype;
    procedure SetScrollBounds;
  public
    { Public declarations }
  end;

var
  fX0Y0Change: TfX0Y0Change;

implementation

uses mMain,frScanWnd,CSPMVar,Globalvar;

{$R *.dfm}

procedure TfX0Y0Change.FormCreate(Sender: TObject);
begin
 siLanglinked1.ActiveLanguage:=Lang;
 MaxShiftX0Y0:=maxapitype;//3000;
 MinShiftX0Y0:=minapitype;

 SetScrollBounds;
end;


procedure TfX0Y0Change.ScrollBarX0Scroll(Sender: TObject;ScrollCode: TScrollCode; var ScrollPos: Integer);
var
    XA0:integer;
begin
     with ScrollBarX0 do
      begin
      case ScrollCode of
(*   scLineUp,scLinedown :
               begin
                 LabelX0.Caption:=IntToStr(round(ScrollPos/TransformUnit.XPnm_d))+siLangLinked1.GetTextOrDefault('IDS_0' { '  nm' }) );
                 edX0A.Text:=IntToStr(round(ScanParams.XBegin+ScrollPos/TransformUnit.XPnm_d));
                 xa0:=round(ScanParams.XBegin+ScrollPos/TransformUnit.XPnm_d);
                 if XA0<0 then XA0:=0;
                 edx0A.Text:=IntToStr(XA0);

 end;              *)
   scTrack:    begin
                 xa0:=round(((ScrollPos)/TransformUnit.XPnm_d));
                 if Xa0<0 then  xA0:=0;
                 LabelX0.Caption:=IntToStr(xa0)+siLangLinked1.GetTextOrDefault('IDS_0' {* '  nm' } );
                 edX0A.Text:=IntToStr(Xa0);
               end;
  scEndScroll: begin
               //   val:=Position-ScanParams.XBegin;
               //   LabelX0.Caption:=FloatToStrF(round(val/ScrollBarX0.LargeChange)*ScrollBarX0.LargeChange,fffixed,5,0)+'  nm';
               end;
           end;
        end;
end;


procedure TfX0Y0Change.SetScrollBounds;
var  xdiscr,ydiscr,xrdiscr,yrdiscr,xmaxdiscr,ymaxdiscr:integer;
begin
   //Xdiscr:=-round((ScanParams.XBegin+Scanparams.xshift)*TransformUnit.XPnm_d)+CSPMSignals[8].MaxDiscr;       //discrets   add P
  // Ydiscr:=-round((ScanParams.YBegin+Scanparams.yshift)*TransformUnit.YPnm_d)+CSPMSignals[9].MaxDiscr;
   Xdiscr:=round((ScanParams.XBegin+Scanparams.xshift)*TransformUnit.XPnm_d);       //discrets
   Ydiscr:=round((ScanParams.YBegin+Scanparams.yshift)*TransformUnit.YPnm_d);      //discrets
   //xrdiscr:=round(ScanParams.X*TransformUnit.XPnm_d)+1;
   //yrdiscr:=round(ScanParams.Y*TransformUnit.YPnm_d)+1;
   xmaxdiscr:=round((ScanParams.XMax-ScanParams.X+Scanparams.xshift)*TransformUnit.XPnm_d);
   ymaxdiscr:=round((ScanParams.YMax-ScanParams.Y+Scanparams.xshift)*TransformUnit.YPnm_d);

 with ScrollBarX0 do
 begin
  min:=0;
  //max:=xdiscr+xmaxdiscr-MaxAPIType;
  max:=xmaxdiscr;
 end;
 with ScrollBarY0 do
 begin
  min:=0;
  //max:=ydiscr+ymaxdiscr-MaxAPIType;
  max:=ymaxdiscr;
 end;
  //ScrollBarX0.Position:=-Xdiscr+MaxAPIType;
 // ScrollBarY0.Position:=-Ydiscr+MaxAPIType;
 ScrollBarX0.Position:=Xdiscr;
  ScrollBarY0.Position:=Ydiscr;
  LabelY0.Caption:=floatToStr(round(ScanParams.YBegin))+siLangLinked1.GetTextOrDefault('IDS_0' {* '  nm' *} );
  edY0A.Text:=intToStr(round(ScanParams.YBegin));
  LabelX0.Caption:=intToStr(round(ScanParams.XBegin))+siLangLinked1.GetTextOrDefault('IDS_0' {* '  nm' } );
  edX0A.Text:=intToStr(round(ScanParams.XBegin));
end;

procedure TfX0Y0Change.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ScanWnd.BitBtnX0Y0.Enabled:=True;
  action:=cafree;
  fX0Y0Change:=nil;
end;

procedure TfX0Y0Change.ScrollBarY0Scroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
var YA0:integer;
begin
     with ScrollBarY0 do
      begin
      case ScrollCode of
(*   scLineUp,scLinedown :
               begin
                LabelY0.Caption:=IntToStr(-round((ScrollPos-CSPMSignals[8].MaxDiscr)/TransformUnit.YPnm_d))+siLangLinked1.GetTextOrDefault('IDS_0' {* '  nm' }) );
                 ya0:=round(ScanParams.YBegin-((ScrollPos-CSPMSignals[8].MaxDiscr)/TransformUnit.YPnm_d);
                 if Ya0<0 then  YA0:=0;
                 edY0A.Text:=IntToStr(Ya0);
               end;
               *)
   scTrack:    begin
//    X0:=-round((X0nm+Scanparams.xshift)*TransformUnit.XPnm_d)+CSPMSignals[8].MaxDiscr;       //discrets   add P
                 ya0:=round(((ScrollPos)/TransformUnit.YPnm_d));
                 if Ya0<0 then  YA0:=0;
                 LabelY0.Caption:=IntToStr(ya0)+siLangLinked1.GetTextOrDefault('IDS_0' {* '  nm' } );
                 edY0A.Text:=IntToStr(Ya0);
                end;
  scEndScroll: begin
               end;
           end;
        end;
end;


procedure TfX0Y0Change.EdX0AKeyPress(Sender: TObject; var Key: Char);
begin
    if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TfX0Y0Change.EdY0AKeyPress(Sender: TObject; var Key: Char);
begin
    if not(Key in ['0'..'9',#8]) then Key :=#0;
end;

procedure TfX0Y0Change.EdY0AChange(Sender: TObject);
begin
  if edY0A.text='' then  exit
  else
  begin
  try
   if StrToFloat(edY0A.text)>(ScanParams.Ymax-ScanParams.Y) then  edY0A.text:=FloatToStrF((ScanParams.Ymax-ScanParams.Y),fffixed,8,0);
  except
    on EConvertError do
   begin silanglinked1.MessageDlg(siLangLinked1.GetTextOrDefault('IDS_6' (* 'error input' *) ),mtWarning,[mbOk],0);edY0A.text:='0';end;
  end;
  end;
end;

procedure TfX0Y0Change.EdX0AChange(Sender: TObject);
begin
  if edX0A.text='' then  exit
  else
  begin
  try
   if StrToFloat(edX0A.text)>(ScanParams.Xmax-Scanparams.X) then  edX0A.text:=FloatToStrF((ScanParams.Xmax-Scanparams.X),fffixed,8,0);
  except
    on EConvertError do
     begin silanglinked1.MessageDlg(siLangLinked1.GetTextOrDefault('IDS_6' (* 'error input' *) ),mtWarning,[mbOk],0);edX0A.text:='0';end;
  end;
  end;
end;

procedure TfX0Y0Change.BitBtnOKClick(Sender: TObject);
begin
  ScanParams.XBegin:=strtofloat(edX0A.text);
  ScanParams.YBegin:=strtofloat(edY0A.text);
  ScanWnd.ScanAreaUpdate;
  ScanWnd.ApplyBitBtn.Font.Color:=clRed;
  ScanWnd.FlgBlickApply:=true;
  flgNew_XYBegin:=true;
  Close;
end;

procedure TfX0Y0Change.BitBtn2Click(Sender: TObject);
begin
 ScanWnd.BitBtnX0Y0.Enabled:=True;
 close
end;

end.
