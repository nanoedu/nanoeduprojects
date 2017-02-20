unit mSetGridApr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,math, siComp, siLngLnk;

type
  TSetGridParam = class(TForm)
    ScrollBar: TScrollBar;
    LabelValue: TLabel;
    siLangLinked1: TsiLangLinked;
    procedure FormShow(Sender: TObject);
    procedure ScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ScrollBarChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      NRow:integer;
  end;

var
  SetGridParam: TSetGridParam;

implementation

uses Globalvar,CSPMVar,mMain;

{$R *.DFM}

procedure TSetGridParam.FormShow(Sender: TObject);
begin
 SiLanglinked1.ActiveLanguage:=Lang;

 with ScrollBar   do
 begin
  case  NRow of
  0: begin               //LevelIT ;UAM
     if STMFlg then
      begin
       Min:=0;
       Max:=floor(ApproachParamsEdited.SetPoint*TransformUnit.nA_d);//{10});32767;//1000;
       Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'LevelIT, nA' *) ) ;
       LargeChange:=10;
       SmallChange:=10;
       Position:=round(ApproachParamsEdited.LevelIT*TransformUnit.nA_d{10});
       LabelValue.Caption:=FloattoStrF(ApproachParamsEdited.LevelIT*ITCor,fffixed,5,2);   //101210
      end
      else
      begin
       Min:=0;
       Max:=100;
       Caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* 'Probe Amplitude Level' *) ); largeChange:=1;
       Position:=Round(ApproachParamsEdited.LevelUAM*Max);
       LabelValue.Caption:=FloattoStrF(Position/Max,fffixed,4,2);
      end;
     end ;
  1: begin    //ZGATE Max
      Min:=0;
      Max:=100;
      LargeChange:=1;
      Position:=round(ApproachParamsEdited.ZGateMax*Max);
      LabelValue.Caption:=FloattoStrF(ScrollBar.Position/Max,fffixed,6,2);
      caption:=siLangLinked1.GetTextOrDefault('IDS_2' (* 'ZGate max' *) );
     end;
  2: begin        //'ZGate min'
      Min:=0;
      Max:=100;
      LargeChange:=1;
      Position:=round(ApproachParamsEdited.ZGateMin*Max);
      LabelValue.Caption:=FloattoStrF(ScrollBar.Position/Max,fffixed,6,2);
      caption:=siLangLinked1.GetTextOrDefault('IDS_3' (* 'ZGate min' *) );
      end;
   3: begin      //Scanner Decay
       Min:=0;
       Max:=500;
       SmallChange:=10;
       LargeChange:=100;
       Position:=round(ApproachParamsEdited.ScannerDecay);
       LabelValue.Caption:=InttoStr(ScrollBar.Position);
       caption:=siLangLinked1.GetTextOrDefault('IDS_4' (* 'Scanner Decay , ms' *) );
      end;
    4: begin      //Integrator Delay
       Min:=0;
       Max:=3000;
       SmallChange:=10;
       LargeChange:=100;
       Position:=round(ApproachParamsEdited.IntegratorDelay);
       LabelValue.Caption:=InttoStr(ScrollBar.Position);
       caption:=siLangLinked1.GetTextOrDefault('IDS_5' (* 'Integrator Delay , ms' *) );
      end;
    5: begin      //Z Step rising
       Min:=1;
       Max:=100;
       largeChange:=10;
       Position:=round(ApproachParamsEdited.ZUpStepsNumb);
       LabelValue.Caption:=InttoStr(ScrollBar.Position);
       caption:=siLangLinked1.GetTextOrDefault('IDS_8' (* 'Rising Steps Number' *) );
      end;
    6: begin      //Z Step Fast Rising
       Min:=2;
       Max:=100;
       largeChange:=10;
       Position:=round(ApproachParamsEdited.ZFastStepsNumb);
       LabelValue.Caption:=InttoStr(ScrollBar.Position);
       caption:=siLangLinked1.GetTextOrDefault('IDS_9' (* 'Fast Landing Steps Number' *) );
      end;
    7: begin      //ScaleMaxIT; Max Amplitude
       if STMFlg
       then
       begin
      (* if flgunit<>pipette then
        begin
         Min:=1;
         Max:=100;
         largeChange:=10;
         Position:=round(ApproachParamsEdited.ScaleMaxIT*10);
         LabelValue.Caption:=FloattoStrF(ScrollBar.Position/Max*10,fffixed,6,2);
         caption:=siLangLinked1.GetTextOrDefault('IDS_10' {* 'Scale Maximum IT' *} );
        end
        else  *)
        begin
         Min:=1;
         Max:=100;
         largeChange:=1;
         Position:=round(ApproachParamsEdited.MaxITIndicator);
         LabelValue.Caption:=FloattoStrF(ScrollBar.Position,fffixed,6,2);
         caption:=siLangLinked1.GetTextOrDefault('Max I indicator ');
        end
       end
       else    //sfm
       begin
        Min:=1;
        Max:=1000;
       // largeChange:=10;
        Position:=round(ApproachParamsEdited.ExtremAmplitude);
        LabelValue.Caption:=FloattoStrF(ScrollBar.Position,fffixed,6,2);
        caption:=siLangLinked1.GetTextOrDefault('IDS_11' (* 'Extremal Amplitude, arb.units' *) );
       end ;
      end;
   8: begin
      if STMFlg then
      begin
       Max:=$7FFF;
       Min:=floor(ApproachParamsEdited.LevelIT*TransformUnit.nA_d);
       Caption:=siLangLinked1.GetTextOrDefault('IDS_12' (* 'Landing SetPoint, nA' *) ) ;
       LargeChange:=10;
       SmallChange:=10;
       Position:=round(ApproachParamsEdited.LandingSetPoint*TransformUnit.nA_d);
       LabelValue.Caption:=FloattoStrF(ApproachParamsEdited.LandingSetPoint*ITCor,fffixed,5,2);   //101210
      end
      else
      begin
       Min:=floor(100*(1-ApproachParamsEdited.LevelUAM));
       Max:=100;
       Caption:=siLangLinked1.GetTextOrDefault('IDS_13' (* 'Landing Suppression' *) );
       largeChange:=1;
       Position:=Round((1-ApproachParamsEdited.LandingSetPoint)*Max);
       LabelValue.Caption:=FloattoStrF(Position/Max,fffixed,4,2);
      end;
     end;
   10:begin
       Max:=7;
       Min:=0;
       Caption:=siLangLinked1.GetTextOrDefault('IDS_7' (* 'Feed Back Loop Gain' *) ) ;
       LargeChange:=1;
       SmallChange:=1;
       Position:=ApproachParamsEdited.FreqBandF;;
       LabelValue.Caption:=inttostr(ApproachParamsEdited.FreqBandF);
      end;
                    end;    //of
 end;
end;

procedure TSetGridParam.ScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
var val:single;
    tmpval:integer;
begin
              case ScrollCode of
 scTrack,
 scLineUp,
 scLineDown: case NRow of
         0:  begin             // LevelIT, UAM
                if STMflg then
                begin
                 val:=ScrollPos/TransformUnit.nA_d;
                 LabelValue.Caption:=FloattoStrF(val*ITCor,fffixed,5,2);    //101210
                 if (val>ApproachParamsEdited.SetPoint ) then
                   begin
                 //   MessageDlg('Error!! LevelIT > SetPoint !! ',mtWarning ,[mbOK],0);
                    LabelValue.Caption:=FloattoStrF(Floor(ApproachParamsEdited.SetPoint*ITCor*100)/100,fffixed,6,2);//101210
                    ScrollBar.Position{SrollPOs}:=round(Floor(ApproachParamsEdited.SetPoint*100)/100*TransformUnit.nA_d);
                   end;
                //    ApproachParamsEdited.LevelUAM:=ScrollPos/TransformUnit.nA_d;    /141210 ????????
                end
                else
                begin
                  val:= ScrollPos/ScrollBar.Max;
                  LabelValue.Caption:=FloattoStrF(val,fffixed,5,2);
                  ApproachParamsEdited.LevelUAM:=ScrollPos/ScrollBar.Max;
                  if (val<ApproachParamsEdited.SetPoint ) then
                   begin
                 //   LabelValue.Caption:=FloattoStrF(Floor(ApproachParams.SetPoint*100)/100,fffixed,6,2);
                    ScrollBar.Position:=ceil(ApproachParamsEdited.SetPoint*100);
                   end;
                 end;
             end;
         1:  begin            // ZgateMax
               LabelValue.Caption:=FloattoStrF(ScrollPos/ScrollBar.Max,fffixed,6,2);
               ApproachParamsEdited.ZGateMax:=ScrollPos/ScrollBar.Max;
             end;
         2:  begin       //Z Gate Min
               LabelValue.Caption:=FloattoStrF(ScrollPos/ScrollBar.Max,fffixed,6,2);
                ApproachParamsEdited.ZGateMin:=ScrollPos/ScrollBar.Max;
             end;
         3:  begin      //Scanner Decay
                LabelValue.Caption:=InttoStr(ScrollPos);
                ApproachParamsEdited.ScannerDecay:=ScrollPos;
             end;
         4:  begin      //Integrator Delay
              LabelValue.Caption:=InttoStr(ScrollPos);
              ApproachParamsEdited.IntegratorDelay:=ScrollPos;
             end;
         5:  begin      //rising  steps
              LabelValue.Caption:=InttoStr(ScrollPos);
              ApproachParamsEdited.ZUpStepsNumb:=ScrollPos;
             end;
         6:  begin      //FastLanding steps
              LabelValue.Caption:=InttoStr(ScrollPos);
              ApproachParamsEdited.ZFastStepsNumb:=ScrollPos;
             end;
         7:  begin      //ScaleMaxIT
             if not STMFlg  then
             begin
             (* if flgUnit<>Pipette then
              begin
               LabelValue.Caption:=FloattoStrF(ScrollPos/10,fffixed,6,2);
               ApproachParamsEdited.ScaleMaxIT:=ScrollPos/10;
               tmpval:=round(ApproachParamsEdited.LandingSetPoint*TransformUnit.nA_d*ApproachParamsEdited.ScaleMaxIT);
               if tmpval>MaxApitype then
               begin
                ApproachParamsEdited.ScaleMaxIT:=1;//101210
                ScrollBar.position:=ScrollBar.Min;
                LabelValue.Caption:=FloattoStrF(ScrollBar.position,fffixed,6,2);
               end;
               *)
                ApproachParamsEdited.ExtremAmplitude:=ScrollPos;
                LabelValue.Caption:=FloattoStrF(ScrollPos,fffixed,6,2);
              end
              else
              begin
               LabelValue.Caption:=FloattoStrF(ScrollPos,fffixed,6,2);
               ApproachParamsEdited.MaxITIndicator:=ScrollPos;
              end;
             end;
         8:  begin      //Landing setpoint
                   case STMflg of
             false:begin   //suppression
                    LabelValue.Caption:=FloattoStrF(ScrollPos/100,fffixed,6,2);
                    ApproachParamsEdited.LandingSetPoint:=1-ScrollPos/100;
                   end;
             true: begin
                      LabelValue.Caption:=FloattoStrF(ScrollPos*ITCor/TransformUnit.nA_d,fffixed,6,2);//101210
                      ApproachParamsEdited.LandingSetPoint:=ScrollPos/TransformUnit.nA_d;
                     end;
                       end;
            end;
        10: begin
              ApproachParamsEdited.FreqBandF:=ScrollPos;
              LabelValue.Caption:=inttostr(ApproachParamsEdited.FreqBandF);
            end;
                     end;//case
     end;
     
   end;

procedure TSetGridParam.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Release;
   Action := caFree;
end;

procedure TSetGridParam.ScrollBarChange(Sender: TObject);
begin
 if NRow=0 then
    if STMFlg then
     begin
     end
     else
     begin
      ApproachParamsEdited.LevelUAM:=ScrollBar.Position/ScrollBar.Max;
       if (ApproachParamsEdited.LevelUAM<ApproachParamsEdited.SetPoint ) then
                   begin
                      ScrollBar.Position:=Floor(ApproachParamsEdited.SetPoint*100);
                      LabelValue.Caption:=FloattoStrF(ceil(ApproachParamsEdited.SetPoint*100)/100,fffixed,6,2);
                      ApproachParamsEdited.LevelUAM:=ceil(ApproachParamsEdited.SetPoint*100)/100;
                   end;
     end;
end;

end.
