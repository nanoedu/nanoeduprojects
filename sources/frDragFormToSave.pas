unit frDragFormToSave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, clipbrd,  Controls, Forms,
  Dialogs, ExtCtrls;

type
  TDragFormToSave = class(TForm)
    PanelDrag: TPanel;
    ImageDrag: TImage;
    procedure FormCreate(Sender: TObject);
    procedure ImageDragProgress(Sender: TObject; Stage: TProgressStage;
      PercentDone: Byte; RedrawNow: Boolean; const R: TRect; const Msg: string);
    procedure ImageDragMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DragFormToSave: TDragFormToSave;

implementation

{$R *.dfm}

procedure TDragFormToSave.FormCreate(Sender: TObject);
begin
   ImageDrag.Picture.Bitmap.Assign(Clipboard);
end;

procedure TDragFormToSave.ImageDragMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   PanelDrag.BeginDrag(False);
end;

procedure TDragFormToSave.ImageDragProgress(Sender: TObject;
  Stage: TProgressStage; PercentDone: Byte; RedrawNow: Boolean; const R: TRect;
  const Msg: string);
begin
    PanelDrag.EndDrag(False);
end;

end.
