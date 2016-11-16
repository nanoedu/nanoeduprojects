unit SignalDrawThread;

interface

uses
  Classes,sysutils,Graphics, GlobalVar,SystemConfig;

type
  TSignalDrawThread = class(TThread)
  private
    { Private declarations }
    cl:longword;
    z:smallint;
  protected
    procedure Execute; override;
    procedure DrawIndicators;
    procedure NormalizeDraw;
    procedure SignalDraw;
    procedure ZIndicatorDraw;
  public
      constructor Create;
      destructor Destroy; override;
  end;

implementation

uses fApproach,mHardWareOpt;

constructor TSignalDrawThread.Create;
begin
  inherited Create(True);
   FreeOnTerminate:=true;
   Priority := TThreadPriority(tpNormal);
   Suspended := True;// Resume;
end;

destructor TSignalDrawThread.Destroy;
begin
    inherited destroy;
    SignalThread:=nil;
    Approach.close;
end;

procedure TSignalDrawThread.Execute;
begin
   while (not Terminated) do
    begin
      DrawIndicators;
    end;
end;
procedure TSignalDrawThread.NormalizeDraw;
begin
  with Approach do
  begin
     if not FlgApproachOK then
        begin
         if flgBlickNorm then
          begin
            if cl=$000000FF then cl:=$0000000 else cl:=$000000FF;
            NormBitBtn.Font.Color:=TColor(cl);
          end;
        end
        else
        begin
            NormBitBtn.Font.Color:=clBlack;
            NormBitBtn.Enabled:=False;
        end;
  end;
end;
procedure TSignalDrawThread.SignalDraw;
var UAM,ITC:smallint;
begin
  with Approach do
  begin
       case STMFlg of
False:begin
      // Critical.Enter;
        UAM:=abs(smallint(GetCommonVar(ADC_SD_OUT)));
      // Critical.Leave;
        if (UAM>UAMMax ) then UAM:=UAMMax;
        SignalIndicator.Value:=UAM;
      end;
TRUE: begin
        //Critical.Enter;
        ITC:=smallint(GetCommonVar(ADC_IT));
        //Critical.Leave;
        SignalIndicator.Value:=abs(ITC);
        LabelCur.Caption:=FloatToStrF(ITCor*ITC/TransformUnit.nA_d,ffFixed ,8,3)
      end;
           end;  //case
  end;
end;

procedure TSignalDrawThread.ZIndicatorDraw;
begin
  with Approach do
  begin
       LabelZV.Font.color:=clGreen;
       ZIndicator.IndicColor:=clGreen;
       ZIndicator.Value:=Z;
   if  (ZIndicator.Value < ZIndicator.LowLimit) then
    begin
      ZIndicator.IndicColor:=clRed;
      LabelZV.Font.color:=clRed;
      Beep;
    end
    else
     begin
      if (ZIndicator.Value >ZIndicator.HighLimit) then
      begin
        ZIndicator.IndicColor:=clNavy;
        LabelZV.Font.color:=clNavy ;
      end ;
     end;
       LabelZV.Caption:=FloattoStrF(ZIndicator.Value/MaxSmallInt,fffixed,3,2);
       Zindicator.Repaint;
   end;
end;

procedure TSignalDrawThread.DrawIndicators;
var   val:word;
begin
  //    Critical.Enter;
   z:=smallint(getCommonVar(ADC_Z));
  //    Critical.Leave;
   if z>0 then z:=0 else   z:=abs(z+1);
      synchronize(ZIndicatorDraw);
   //   Critical.Enter;
      val:=GetCommonVar(CMP_VAL);
   //   Critical.Leave;
   if val<2 then
     begin
        Beep;
     end;
      synchronize(NormalizeDraw);
      synchronize(SignalDraw);
end;
end.
