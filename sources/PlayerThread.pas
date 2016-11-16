unit PlayerThread;

interface

uses
  Classes,GlobalVar;

type
  TPlayer = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
     constructor Create;
     destructor Destroy; override;
end;

implementation
uses  fApproach;
{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure Player.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ Player }
constructor TPlayer.Create;
var i,j:integer;
 begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpHigher{Normal});
   Suspended := True;// Resume;
   with approach.MediaPlayer do
    begin
                Visible:=False;
                AutoRewind:=true;
                wait:=true;
                FileName:=ExeFilePath+'sound\snoring.wav';
                open;
    end;
end;

destructor TPlayer.Destroy;
begin
   inherited destroy;
end;

procedure TPlayer.Execute;
begin
  { Place thread code here }
   while (not Terminated) do
     begin
      Approach.MediaPlayer.play;
     end;
end;

end.
