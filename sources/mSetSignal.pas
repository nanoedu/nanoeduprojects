//220502
unit mSetSignal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, siComp, siLngLnk, ExtCtrls;

type
  TSetSignal = class(TForm)
    ScrollBar1: TScrollBar;
    siLangLinked1: TsiLangLinked;
    IndValue: TLabeledEdit;
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;var ScrollPos: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IndValueEnter(Sender: TObject);
    procedure IndValueKeyPress(Sender: TObject; var Key: Char);
    procedure IndValueExit(Sender: TObject);
    procedure IndValueChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetSignal: TSetSignal;

implementation

uses GlobalType,frSignalsMod,globalFunction,
     frApproachnew,CSPMVar,GlobalVar,
     UNanoEduBaseClasses,UNanoEduClasses,frScanWnd,mMain;

{$R *.DFM}
{$O-}


procedure TSetSignal.FormCreate(Sender: TObject);
begin
  SiLanglinked1.ActiveLanguage:=Lang;

        with ScrollBar1   do
 begin
  case  BtnFlg of
  0: begin
      Min:=0;
      Max:=254;
      Position:=ApproachParams.Gain_FM;
      IndValue.Text:=FloattoStrF(ApproachParams.Gain_FM/($FF-POsition),fffixed,8,3);
      caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Gain_FM' *) );
     end ;
  1: begin       { TODO : 220405 }  //current
      Max:=round(ApproachParams.MaxITIndicator*MaxApitype/100);//32767;
      Min:=1;
      LargeChange:=10;
      Smallchange:=10;
      if assigned(ScanWnd)  then
      begin
       Position:=round(ApproachParams.SetPoint*TransformUnit.nA_d);
       IndValue.Text:=FloattoStrF(ApproachParams.SetPoint*ITCOR,fffixed,6,3);
       IndValue.EditLabel.Caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );//101210
      end;
      if assigned(Approach) then
      begin
       Position:=round(ApproachParams.LandingSetPoint*TransformUnit.nA_d);
       IndValue.Text:=FloattoStrF(ApproachParams.LandingSetPoint*ITCor,fffixed,6,3);
       IndValue.EditLabel.Caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );//101210
      end;
  //   IndValue.Text:=FloattoStrF(ApproachParams.SetPoint,fffixed,6,3)+siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) ); //101210
      caption:=siLangLinked1.GetTextOrDefault('IDS_4' (* 'Set Point' *) );
     end;
  2: begin        //vt
       case STMFlg of
true: begin
        min:=round(-VLimitSTM*TransformUnit.BiasV_d);
        max:=round(VLimitSTM*TransformUnit.BiasV_d);
      end;
false: begin
        min:=-32768;
        max:=32767;
       end;
          end;
      Position:=round(ApproachParams.BiasV*TransformUnit.BiasV_d);
      LargeChange:=10;
      Smallchange:=1;
      if Position<0 then   IndValue.Font.Color:=clBlue
                    else   IndValue.Font.Color:=clRed ;
      IndValue.Text:=FloattoStrF(ApproachParams.BiasV,fffixed,8,3);
      IndValue.EditLabel.Caption:=siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
      caption:=siLangLinked1.GetTextOrDefault('IDS_6' (* 'Bias Voltage' *) );
     end;
   end;
 end;
end;

procedure TSetSignal.IndValueChange(Sender: TObject);
var v:single;
    setpnt:single;
begin
  if (IndValue.Text<>'')  and (IndValue.Text<>'-') then
  case  BtnFlg of
  0: begin   //gain     FM
//       Scrollbar1.Position:=round(StrTofloat(IndValue.Text)/TransformUnit.nA_d);
     end;
  1: begin     //set point current
            Scrollbar1.Position:=round(StrTofloat(IndValue.Text)*TransformUnit.nA_d);
        //   NanoEdu.SetPoint:=apitype( Scrollbar1.Position);
            SetPnt:=abs( Scrollbar1.Position/TransformUnit.nA_d);
              if (ApproachParams.LevelIT>SetPnt ) and (not Assigned(ScanWnd)) then
                 begin
                    MessageDlg(siLangLinked1.GetTextOrDefault('IDS_7' { 'Error!! LevelIT =' } )+FloattoStrF(ApproachParams.LevelIT,fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_8' { '> SetPoint !!' } )+#13+siLangLinked1.GetTextOrDefault('IDS_9' { ' Open the Options Window and change LevelIT if You need.' } ),mtWarning ,[mbOK],0);
                    ScrollBar1.Position:=Round(ApproachParams.LevelIT*TransformUnit.nA_d)+5;
                    ApproachParams.LandingSetPoint:=ScrollBar1.Position;
                    ApproachParams.SetPoint:=ScrollBar1.Position;
           //       NanoEdu.SetPoint:=apitype({-signf(ApproachParams.BiasV)*}ScrollPos);            //250112
                    IndValue.Text:=FloattoStrF((Round(ApproachParams.LevelIT*TransformUnit.nA_d)+5)*ITCor/TransformUnit.nA_d,fffixed,5,3);//+siLangLinked1.GetTextOrDefault('IDS_1' { ' nA' } );//101210
                  end;
            ApproachParams.SetPoint:=abs( Scrollbar1.Position/TransformUnit.nA_d);
            ApproachParams.LandingSetPoint:=abs( Scrollbar1.Position/TransformUnit.nA_d);
           if not assigned(Nanoedu.Method) then  NanoEdu.SetPoint:=apitype( Scrollbar1.Position)
                                           else   NanoEdu.Method.SetUsersParams;

             if ScanOnProgr then
                   begin
                    ScanWnd.SignalsMode.BtnSetPoint.Caption:=
                       IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );//101210
                    end
                  else
                    begin
                     Approach.SignalsMode.BtnSetPoint.Caption:=
                         IndValue.Text +siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );  //101210
                    end;

     end;
 2: begin    //vt
       Scrollbar1.Position:=round(StrTofloat(IndValue.Text)*TransformUnit.BiasV_d);
            v:=StrTofloat(IndValue.Text);
             ApproachParams.BiasV:=V;
                 if (not assigned(Nanoedu.Method)) and (NanoEdu.BramUflg=0)then  NanoEdu.Bias:=apiType(Scrollbar1.Position);
(*                                                 else
                                                 begin
                                                   if  NanoEdu.BramUflg=0 then NanoEdu.Bias:=apiType(Scrollbar1.Position)
                                                                          else  Nanoedu.Method.SetUsersParams;
                                                 end;
  *)
          if ScanOnProgr then
                begin
                   if STMFlg then
                  begin
                     if V<0 then  ScanWnd.SignalsMode.btnBiasV.Font.Color:=clBlue
                            else  ScanWnd.SignalsMode.btnBiasV.Font.Color:=clRed ;
                     ScanWnd.SignalsMode.BtnBiasV.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) )
                   end
                   else
                   begin
                     if V<0 then  ScanWnd.SignalsMode.btnBiasSFM.Font.Color:=clBlue
                            else  ScanWnd.SignalsMode.btnBiasSFM.Font.Color:=clRed ;
                     ScanWnd.SignalsMode.BtnBiasSFM.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) )
                   end
                end
                else
                begin
                  if STMFlg then
                  begin
                    if V<0 then Approach.SignalsMode.BtnBiasV.Font.Color:=clBlue
                           else Approach.SignalsMode.BtnBiasV.Font.Color:=clRed ;
                    Approach.SignalsMode.BtnBiasV.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                  end
                  else
                  begin
                    if V<0 then Approach.SignalsMode.btnBiasSFM.Font.Color:=clBlue
                           else Approach.SignalsMode.btnBiasSFM.Font.Color:=clRed ;
                    Approach.SignalsMode.btnBiasSFM.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                  end;
                end;

     end;
 end;

end;

procedure TSetSignal.IndValueEnter(Sender: TObject);
var v:single;
       setpnt:single;
begin
 if (IndValue.Text<>'')  and (IndValue.Text<>'-') then
  case  BtnFlg of
  0: begin   //gain     FM
//       Scrollbar1.Position:=round(StrTofloat(IndValue.Text)/TransformUnit.nA_d);
     end;
  1: begin     //set point current
            setpnt:=round(StrTofloat(IndValue.Text)*TransformUnit.nA_d);
            Scrollbar1.Position:=round(setpnt);
(*           if (ApproachParams.LevelIT>SetPnt ) and (not Assigned(ScanWnd)) then
                 begin
                    MessageDlg(siLangLinked1.GetTextOrDefault('IDS_7' { 'Error!! LevelIT =' } )+FloattoStrF(ApproachParams.LevelIT,fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_8' { '> SetPoint !!' } )+#13+siLangLinked1.GetTextOrDefault('IDS_9' { ' Open the Options Window and change LevelIT if You need.' } ),mtWarning ,[mbOK],0);
                    ScrollBar1.Position:=Round(ApproachParams.LevelIT*TransformUnit.nA_d)+5;
                    ApproachParams.LandingSetPoint:=setpnt;
                    ApproachParams.SetPoint:=setpnt;
           //         NanoEdu.SetPoint:=apitype({-signf(ApproachParams.BiasV)*}ScrollPos);            //250112
           //         IndValue.Text:=FloattoStrF({-signf(ApproachParams.BiasV)*}ScrollPos*ITCor/TransformUnit.nA_d,fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_1' { ' nA' } );//101210
                  end;
  *)
            if not assigned(Nanoedu.Method) then  NanoEdu.SetPoint:=apitype( Scrollbar1.Position)
                                            else   NanoEdu.Method.SetUsersParams;
            ApproachParams.SetPoint:=abs( Scrollbar1.Position/TransformUnit.nA_d);
            ApproachParams.LandingSetPoint:=abs( Scrollbar1.Position/TransformUnit.nA_d);
              if ScanOnProgr then
                   begin
                    ScanWnd.SignalsMode.BtnSetPoint.Caption:=
                       IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );//101210
                    end
                  else
                    begin
                     Approach.SignalsMode.BtnSetPoint.Caption:=
                         IndValue.Text +siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );  //101210
                    end;

     end;
 2: begin    //vt
             Scrollbar1.Position:=round(StrTofloat(IndValue.Text)*TransformUnit.BiasV_d);
             v:=StrTofloat(IndValue.Text);
             ApproachParams.BiasV:=V;
            if (not assigned(Nanoedu.Method)) and (NanoEdu.BramUflg=0)then  NanoEdu.Bias:=apiType(Scrollbar1.Position)
                                                 else
                                                 begin
                                                   if  NanoEdu.BramUflg=0 then NanoEdu.Bias:=apiType(Scrollbar1.Position)
                                                                          else  Nanoedu.Method.SetUsersParams;
                                                 end;

           if ScanOnProgr then
                begin
                   if STMFlg then
                  begin
                     if V<0 then  ScanWnd.SignalsMode.btnBiasV.Font.Color:=clBlue
                            else  ScanWnd.SignalsMode.btnBiasV.Font.Color:=clRed ;
                     ScanWnd.SignalsMode.BtnBiasV.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) )
                   end
                   else
                   begin
                     if V<0 then  ScanWnd.SignalsMode.btnBiasSFM.Font.Color:=clBlue
                            else  ScanWnd.SignalsMode.btnBiasSFM.Font.Color:=clRed ;
                     ScanWnd.SignalsMode.BtnBiasSFM.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) )
                   end
                end
                else
                begin
                  if STMFlg then
                  begin
                    if V<0 then Approach.SignalsMode.BtnBiasV.Font.Color:=clBlue
                           else Approach.SignalsMode.BtnBiasV.Font.Color:=clRed ;
                    Approach.SignalsMode.BtnBiasV.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                  end
                  else
                  begin
                    if V<0 then Approach.SignalsMode.btnBiasSFM.Font.Color:=clBlue
                           else Approach.SignalsMode.btnBiasSFM.Font.Color:=clRed ;
                    Approach.SignalsMode.btnBiasSFM.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                  end;
                end;

     end;
 end;
end;

procedure TSetSignal.IndValueExit(Sender: TObject);
var v:single;
begin
 if (IndValue.Text<>'')  and (IndValue.Text<>'-') then
 case  BtnFlg of
  0: begin   //gain     FM
//       Scrollbar1.Position:=round(StrTofloat(IndValue.Text)/TransformUnit.nA_d);
     end;
  1: begin     //set point current
       Scrollbar1.Position:=round(StrTofloat(IndValue.Text)*TransformUnit.nA_d);
           NanoEdu.SetPoint:=apitype( Scrollbar1.Position);
            ApproachParams.SetPoint:=abs( Scrollbar1.Position/TransformUnit.nA_d);
            ApproachParams.LandingSetPoint:=abs( Scrollbar1.Position/TransformUnit.nA_d);
             if ScanOnProgr then
                   begin
                    ScanWnd.SignalsMode.BtnSetPoint.Caption:=
                       IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );//101210
                    end
                  else
                    begin
                     Approach.SignalsMode.BtnSetPoint.Caption:=
                         IndValue.Text +siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );  //101210
                    end;

     end;
 2: begin    //vt
       Scrollbar1.Position:=round(StrTofloat(IndValue.Text)*TransformUnit.BiasV_d);
       v:=StrTofloat(IndValue.Text);
        ApproachParams.BiasV:=V;
        if (not assigned(Nanoedu.Method)) and (NanoEdu.BramUflg=0)then  NanoEdu.Bias:=apiType(Scrollbar1.Position)
                                                 else
                                                 begin
                                                   if  NanoEdu.BramUflg=0 then NanoEdu.Bias:=apiType(Scrollbar1.Position)
                                                                          else  Nanoedu.Method.SetUsersParams;
                                                 end;
        if ScanOnProgr then
                begin
                   if STMFlg then
                  begin
                     if V<0 then  ScanWnd.SignalsMode.btnBiasV.Font.Color:=clBlue
                            else  ScanWnd.SignalsMode.btnBiasV.Font.Color:=clRed ;
                     ScanWnd.SignalsMode.BtnBiasV.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) )
                   end
                   else
                   begin
                     if V<0 then  ScanWnd.SignalsMode.btnBiasSFM.Font.Color:=clBlue
                            else  ScanWnd.SignalsMode.btnBiasSFM.Font.Color:=clRed ;
                     ScanWnd.SignalsMode.BtnBiasSFM.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) )
                   end
                end
                else
                begin
                  if STMFlg then
                  begin
                    if V<0 then Approach.SignalsMode.BtnBiasV.Font.Color:=clBlue
                           else Approach.SignalsMode.BtnBiasV.Font.Color:=clRed ;
                    Approach.SignalsMode.BtnBiasV.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                  end
                  else
                  begin
                    if V<0 then Approach.SignalsMode.btnBiasSFM.Font.Color:=clBlue
                           else Approach.SignalsMode.btnBiasSFM.Font.Color:=clRed ;
                    Approach.SignalsMode.btnBiasSFM.Caption:=IndValue.Text+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                  end;
                end;

     end;
 end;

end;

procedure TSetSignal.IndValueKeyPress(Sender: TObject; var Key: Char);
begin
 if not(Key in ['-','0'..'9',decimalseparator,#8]) then Key :=#0;
end;

procedure TSetSignal.ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
var val:word;
      v:single;
   setpnt:single;
begin
              case ScrollCode of
 scTrack,
 scLineUp,
 scLineDown: case BtnFlg of
         1:  begin             // SetPoint    current
                 SetPnt:=abs(ScrollPos/TransformUnit.nA_d);

                 if (ApproachParams.LevelIT>SetPnt ) and (not Assigned(ScanWnd)) then
                 begin
                    MessageDlg(siLangLinked1.GetTextOrDefault('IDS_7' { 'Error!! LevelIT =' } )+FloattoStrF(ApproachParams.LevelIT,fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_8' { '> SetPoint !!' } )+#13+siLangLinked1.GetTextOrDefault('IDS_9' { ' Open the Options Window and change LevelIT if You need.' } ),mtWarning ,[mbOK],0);
                    ScrollPos:=Round(ApproachParams.LevelIT*TransformUnit.nA_d)+5;
                    ScrollBar1.Position:=ScrollPos;
                    ApproachParams.LandingSetPoint:=abs(ScrollPos/TransformUnit.nA_d);
                    ApproachParams.SetPoint:=abs(ScrollPos/TransformUnit.nA_d);
           //         NanoEdu.SetPoint:=apitype({-signf(ApproachParams.BiasV)*}ScrollPos);            //250112
           //         IndValue.Text:=FloattoStrF({-signf(ApproachParams.BiasV)*}ScrollPos*ITCor/TransformUnit.nA_d,fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_1' { ' nA' } );//101210
                  end;

                 IndValue.Text:=FloattoStrF(ScrollPos*ITCor/TransformUnit.nA_d,fffixed,5,3);
                 IndValue.EditLabel.Caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );
                 ApproachParams.SetPoint:=abs( ScrollPos/TransformUnit.nA_d);
                 ApproachParams.LandingSetPoint:=abs( ScrollPos/TransformUnit.nA_d);
                 if Assigned(Nanoedu.Method) then begin if (ScrollCode<>scTrack) then  NanoEdu.Method.SetUsersParams end
                 else Nanoedu.SetPoint:=ApiType(round(ApproachParams.SetPoint*TransformUnit.nA_d));

                if ScanOnProgr then
                   begin
                    ScanWnd.SignalsMode.BtnSetPoint.Caption:=
                         FloattoStrF({-signf(ApproachParams.BiasV)*}(ScrollPos*ITCor/TransformUnit.nA_d),fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );//101210
                    end
                  else
                    begin
                     Approach.SignalsMode.BtnSetPoint.Caption:=
                         FloattoStrF({-signf(ApproachParams.BiasV)*}(ScrollPos*ITCor/TransformUnit.nA_d),fffixed,5,3)
                         +siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );  //101210
                    end;
             end;
         2:  begin
                   // Vt
                   V:=ScrollPos/TransformUnit.BiasV_d;
                   ApproachParams.BiasV:=V;
               if ScrollPos<0 then   IndValue.Font.Color:=clBlue
                              else   IndValue.Font.Color:=clRed ;
                IndValue.Text:=FloattoStrF(V,fffixed,8,3);
                IndValue.EditLabel.Caption:=siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                if (not assigned(Nanoedu.Method)) and (NanoEdu.BramUflg=0)then  NanoEdu.Bias:=apiType(Scrollbar1.Position)
                                                 else
                                                 begin
                                                   if  NanoEdu.BramUflg=0 then NanoEdu.Bias:=apiType(Scrollbar1.Position)
                                                                          else  begin if (ScrollCode<>scTrack) then Nanoedu.Method.SetUsersParams;end;
                                                 end;

               if ScanOnProgr then
                begin
                   if STMFlg then
                  begin
                     if V<0 then  ScanWnd.SignalsMode.btnBiasV.Font.Color:=clBlue
                            else  ScanWnd.SignalsMode.btnBiasV.Font.Color:=clRed ;
                     ScanWnd.SignalsMode.BtnBiasV.Caption:=FloattoStrF(V,fffixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) )
                   end
                   else
                   begin
                     if V<0 then  ScanWnd.SignalsMode.btnBiasSFM.Font.Color:=clBlue
                            else  ScanWnd.SignalsMode.btnBiasSFM.Font.Color:=clRed ;
                     ScanWnd.SignalsMode.BtnBiasSFM.Caption:=FloattoStrF(V,fffixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) )
                   end
                end
                else
                begin
                  if STMFlg then
                  begin
                    if V<0 then Approach.SignalsMode.BtnBiasV.Font.Color:=clBlue
                           else Approach.SignalsMode.BtnBiasV.Font.Color:=clRed ;
                    Approach.SignalsMode.BtnBiasV.Caption:=FloattoStrF(V,fffixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                  end
                  else
                  begin
                    if V<0 then Approach.SignalsMode.btnBiasSFM.Font.Color:=clBlue
                           else Approach.SignalsMode.btnBiasSFM.Font.Color:=clRed ;
                    Approach.SignalsMode.btnBiasSFM.Caption:=FloattoStrF(V,fffixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                  end;
                end;
                if (not assigned(Nanoedu.Method)) and (NanoEdu.BramUflg=0)then  NanoEdu.Bias:=apiType(ScrollPOS)
                                                 else
                                                 begin
                                                   if  NanoEdu.BramUflg=0 then NanoEdu.Bias:=apiType(ScrollPOS)
                                                                          else  Nanoedu.Method.SetUsersParams;
                                                 end;

              (*    if STMFLG then
                  begin
//                   NanoEdu.SetPoint:=ApiType(round(-signf(ApproachParams.BiasV)*ApproachParams.SetPoint*TransformUnit.nA_d));
                  end;
                   if ScanOnProgr then
                   begin
                    ScanWnd.SignalsMode.BtnSetPoint.Caption:=
                         FloattoStrF({-signf(ApproachParams.BiasV)*}ApproachParams.SetPoint,fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_1' { ' nA' }) );//101210
                    end
                  else
                    begin
                     Approach.SignalsMode.BtnSetPoint.Caption:=
                         FloattoStrF({-signf(ApproachParams.BiasV)*}ApproachParams.SetPoint,fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_1' { ' nA' } );  //101210
                    end;
              *)

             end;
         0:  begin       //gain
                 val:=ScrollPos;
                (NanoEdu as TSFMNanoEdu).Gain_FM:=(val);
              if ScanOnProgr then
               begin
                 ScanWND.SignalsMode.GainFMBtn.Caption:=
                                 FloattoStrF(val/($FF-val),ffFixed,5,2);
                 ApproachParams.Gain_FM:=val;
                 IndValue.Text:=FloattoStrF(val/($FF-val),fffixed,5,2);
                end
              end;
          end;

   scEndScroll:
      case BtnFlg of
        0: ;
        1: begin   // current set point
                IndValue.Text:=FloattoStrF({-signf(ApproachParams.BiasV)*}ScrollPos*ITCor/TransformUnit.nA_d,fffixed,5,3);
                IndValue.EditLabel.Caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );
                ApproachParams.SetPoint:=abs( ScrollPos/TransformUnit.nA_d);
                ApproachParams.LandingSetPoint:=abs( ScrollPos/TransformUnit.nA_d);
                if Assigned(Nanoedu.Method) then  NanoEdu.Method.SetUsersParams
                 else Nanoedu.SetPoint:=ApiType(round(ApproachParams.SetPoint*TransformUnit.nA_d));
        if ScanOnProgr then
                   begin
                    ScanWnd.SignalsMode.BtnSetPoint.Caption:=
                         FloattoStrF({-signf(ApproachParams.BiasV)*}(ScrollPos*ITCor/TransformUnit.nA_d),fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );//101210
                    end
                  else
                    begin
                     Approach.SignalsMode.BtnSetPoint.Caption:=
                         FloattoStrF({-signf(ApproachParams.BiasV)*}(ScrollPos*ITCor/TransformUnit.nA_d),fffixed,5,3)
                         +siLangLinked1.GetTextOrDefault('IDS_1' (* ' nA' *) );  //101210
                    end;
           end;
        2: begin       //V
             V:=ScrollPos/TransformUnit.BiasV_d;
                    ApproachParams.BiasV:=V;
               if ScrollPos<0 then   IndValue.Font.Color:=clBlue
                              else   IndValue.Font.Color:=clRed ;
                IndValue.Text:=FloattoStrF(V,fffixed,8,3);
                IndValue.EditLabel.Caption:=siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
          if (not assigned(Nanoedu.Method)) and (NanoEdu.BramUflg=0)then  NanoEdu.Bias:=apiType(ScrollPos)
                                                 else
                                                 begin
                                                   if  NanoEdu.BramUflg=0 then NanoEdu.Bias:=apiType(ScrollPos)
                                                                          else  Nanoedu.Method.SetUsersParams;
                                                 end;

            if ScanOnProgr then
               begin
                 if STMFlg then
                  begin
                     if V<0 then  ScanWnd.SignalsMode.btnBiasV.Font.Color:=clBlue
                            else  ScanWnd.SignalsMode.btnBiasV.Font.Color:=clRed ;
                     ScanWnd.SignalsMode.BtnBiasV.Caption:=FloattoStrF(V,fffixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                   (*  ScanWnd.SignalsMode.BtnSetPoint.Caption:=
                         FloattoStrF({-signf(ApproachParams.BiasV)*}ApproachParams.SetPoint,fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_1' { ' nA' }) );//101210
                   *)
                  end
                  else
                  begin
                     if V<0 then  ScanWnd.SignalsMode.btnBiasSFM.Font.Color:=clBlue
                            else  ScanWnd.SignalsMode.btnBiasSFM.Font.Color:=clRed ;
                     ScanWnd.SignalsMode.BtnBiasSFM.Caption:=FloattoStrF(V,fffixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) )
                  end
               end
               else //approach
               begin
                  if STMFlg then
                  begin
                    if V<0 then Approach.SignalsMode.BtnBiasV.Font.Color:=clBlue
                           else Approach.SignalsMode.BtnBiasV.Font.Color:=clRed ;
                    Approach.SignalsMode.BtnBiasV.Caption:=FloattoStrF(V,fffixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                   (* Approach.SignalsMode.BtnSetPoint.Caption:=
                         FloattoStrF({-signf(ApproachParams.BiasV)*}ApproachParams.SetPoint,fffixed,5,3)+siLangLinked1.GetTextOrDefault('IDS_1' { ' nA' } );  //101210
                   *)
                  end
                  else
                  begin
                    if V<0 then Approach.SignalsMode.btnBiasSFM.Font.Color:=clBlue
                           else Approach.SignalsMode.btnBiasSFM.Font.Color:=clRed ;
                    Approach.SignalsMode.btnBiasSFM.Caption:=FloattoStrF(V,fffixed,8,3)+siLangLinked1.GetTextOrDefault('IDS_5' (* ' V' *) );
                  end;
              end;
  end;
       end;
   end;
end;

procedure TSetSignal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Release;
end;

end.


