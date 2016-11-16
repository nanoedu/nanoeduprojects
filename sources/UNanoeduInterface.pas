//200605
unit UNanoEduInterface;

interface
  uses windows,globaltype,GlobalVar;
type
IpmApi05 = interface(IUnknown)
   ['{1992DFD0-D33D-4EA7-8881-BB5F728E28CC}']
    function Get_DacY: apitype;
    procedure Set_DacY(pVal: apitype);
    function Get_DacX: apitype;
    procedure Set_DacX(pVal: apitype);
    function Get_DacZ: apitype;
    procedure Set_DacZ(pVal: apitype);
    function Get_Z: apitype;        //z
    function Get_Uam: apitype;     //amplitude
    function Get_Ufm: apitype;   //phase
    function Get_IT: apitype;    //current
    function Get_Frequency: apitype;
    procedure Set_Frequency(pVal: apitype);
    function Get_SDGAM: apitype;    //probe voltage amplitude modulation
    procedure Set_SDGAM(pVal: apitype);
    function Get_SMZSTEP : apitype;
    procedure Set_SMZSTEP(pVal: apitype);
    function Get_SMZSTATUS : apitype;
    procedure Set_SMZSTATUS(pVal: apitype);
    function Get_ITRRES : apitype;
    procedure Set_ITRRES(pVal: apitype);    //
    function Get_DACIREF: apitype;          //  resonant amplitude
    procedure Set_DACIREF(pVal: apitype);
    function Get_DACIREF_AM: apitype;          // setpoint=resonant amplitude*DACIREF_AM
    procedure Set_DACIREF_AM(pVal: apitype);
    function Get_CmpValue: apitype;          //upper limit
    function Get_DACREFSTM: apitype;          //
    procedure Set_DACREFSTM(pVal: apitype);
    function Get_DACVT: apitype;
    procedure Set_DACVT(pVal: apitype);
    function  Get_UserErr: apitype;
    procedure Set_UserErr(pVal: apitype);
    function  Get_ChooseBramU: apitype;
    procedure Set_ChooseBramU(pVal: apitype);
    function Get_PATHSPD : apitype;
    procedure Set_PATHSPD(pVal: apitype);
    function Get_PATHSPD_BW : apitype;
    procedure Set_PATHSPD_BW(pVal: apitype);
    procedure Set_IMaxCut(pVal: integer);
    function Get_IMaxCut:integer;

    property DACY: apitype read Get_DacY write Set_DacY;
    property DACX: apitype read Get_DacX write Set_DacX;
    property DACZ: apitype read Get_DacZ write Set_DacZ;
    property Z: apitype read Get_Z;
    property UAM: apitype read Get_Uam;
    property UFM: apitype read Get_Ufm;
    property Frequency: apitype read Get_Frequency write Set_Frequency;
    property SDGAM:      apitype read Get_SDGAM write Set_SDGAM;
    property SMZSTEP:   apitype read Get_SMZSTEP write Set_SMZSTEP;
    property SMZSTATUS: apitype read Get_SMZSTATUS write Set_SMZSTATUS;
    property ITRRES:    apitype read Get_ITRRES write Set_ITRRES;
    property DACIREF:   apitype read Get_DACIREF write Set_DACIREF;
    property DACIREF_AM:apitype read Get_DACIREF_AM write Set_DACIREF_AM;
    property DACREFSTM: apitype  read Get_DACREFSTM  write Set_DACREFSTM;
    property IT: apitype read Get_IT;
    property CmpValue: apitype   read Get_CmpValue;
    property DACVT: apitype      read Get_DACVT      write Set_DACVT;
    property UserErr: apitype    read Get_UserErr    write Set_UserErr;
    property ChooseBramU: apitype read Get_ChooseBramU write Set_ChooseBramU;
    property PATHSPD: apitype     read Get_PATHSPD write Set_PATHSPD;
    property IMaxCutVal:integer   read Get_IMaxCut write Set_IMaxCut;
  end;

TpmAPI05=class(TInterfacedObject, IpmApi05)

    function Get_DacY: apitype;
    procedure Set_DacY(pVal: apitype);
    function Get_DacX: apitype;
    procedure Set_DacX(pVal: apitype);
    function Get_DacZ: apitype;
    procedure Set_DacZ(pVal: apitype);
    function Get_Z: apitype;
    function Get_Uam: apitype;
    function Get_Ufm: apitype;
    function Get_Frequency: apitype;
    procedure Set_Frequency(pVal: apitype);
    function Get_SDGAM: apitype;
    procedure Set_SDGAM(pVal: apitype);
    function Get_SMZSTEP : apitype;
    procedure Set_SMZSTEP(pVal: apitype);
    function Get_SMZSTATUS : apitype;
    procedure Set_SMZSTATUS(pVal: apitype);
    function Get_ITRRES : apitype;
    procedure Set_ITRRES(pVal: apitype);
    function Get_DACIREF: apitype;          //
    procedure Set_DACIREF(pVal: apitype);
    function Get_DACREFSTM: apitype;          //
    procedure Set_DACREFSTM(pVal: apitype);
    function Get_DACIREF_AM: apitype;          //
    procedure Set_DACIREF_AM(pVal: apitype);
    function Get_IT: apitype;
    function Get_CmpValue: apitype;
    function Get_DACVT: apitype;
    procedure Set_DACVT(pVal: apitype);
    function  Get_UserErr: apitype;
    procedure Set_UserErr(pVal: apitype);
    function  Get_ChooseBramU: apitype;
    procedure Set_ChooseBramU(pVal: apitype);
    function Get_PATHSPD : apitype;
    procedure Set_PATHSPD(pVal: apitype);
    function Get_PATHSPD_BW : apitype;
    procedure Set_PATHSPD_BW(pVal: apitype);
    procedure Set_IMaxCut(pVal: integer);
    function  Get_IMaxCut:integer;
 public
    property DACY: apitype       read Get_DacY       write Set_DacY;
    property DACX: apitype       read Get_DacX       write Set_DacX;
    property DACZ: apitype       read Get_DacZ       write Set_DacZ;
    property Z: apitype          read Get_Z;
    property UAM: apitype        read Get_Uam;
    property UFM: apitype        read Get_Ufm;
    property Frequency: apitype  read Get_Frequency  write Set_Frequency;
    property SDGAM: apitype      read Get_SDGAM      write Set_SDGAM;
    property SMZSTEP: apitype    read Get_SMZSTEP    write Set_SMZSTEP;
    property SMZSTATUS: apitype  read Get_SMZSTATUS  write Set_SMZSTATUS;
    property ITRRES: apitype     read Get_ITRRES     write Set_ITRRES;
    property DACIREF: apitype    read Get_DACIREF    write Set_DACIREF;
    property DACIREF_AM: apitype read Get_DACIREF_AM write Set_DACIREF_AM;
    property DACREFSTM: apitype  read Get_DACREFSTM  write Set_DACREFSTM;
    property IT: apitype         read Get_IT;
    property CmpValue: apitype   read Get_CmpValue;
    property DACVT: apitype      read Get_DACVT   write Set_DACVT;
    property UserErr: apitype    read Get_UserErr write Set_UserErr;
    property ChooseBramU: apitype read Get_ChooseBramU write Set_ChooseBramU;
    property PATHSPD: apitype    read Get_PATHSPD  write Set_PATHSPD;
    property IMaxCutVal:integer  read Get_IMaxCut write Set_IMaxCut;
end; { class TpmAPI}

 var API:IpmAPI05;

implementation

uses SioCSPM, CSPMVar;

(*    function TpmAPI05.Get_Version: apitype;
      begin
        Result:=GetCommonVar(Version);
      end;
*)

   function TpmAPI05.Get_UserErr: apitype;
   begin
      Result:=GetCommonVar(USER_err);
   end;
    procedure TpmAPI05.Set_UserErr(pVal: apitype);
    begin
       SetCommonVar(USER_err, pVal);
   end;
    function   TpmAPI05.Get_ChooseBramU: apitype;
     begin
      result:=GetCommonVar(SelBramU);
   end;
    procedure  TpmAPI05.Set_ChooseBramU(pVal: apitype);
     begin
       SetCommonVar(SelBramU, pVal);
   end;
    function TpmAPI05.Get_DacY: apitype;
      begin
        Result:=GetCommonVar(DAC_Y);
      end;
    procedure TpmAPI05.Set_DacY(pVal: apitype);
      begin
         SetCommonVar(DAC_Y, pVal);
      end;
    function TpmAPI05.Get_DacX: apitype;
      begin
        Result:=GetCommonVar(DAC_X);
      end;
    procedure TpmAPI05.Set_DacX(pVal: apitype);
     begin
         SetCommonVar(DAC_X,pVal);
      end;
    function TpmAPI05.Get_DacZ: apitype;
      begin
        Result:=GetCommonVar(DAC_Z);
      end;
    procedure TpmAPI05.Set_DacZ(pVal: apitype);
     begin
         SetCommonVar(DAC_Z, pVal);
      end;
    function TpmAPI05.Get_Z: apitype;
     begin
        Result:=apitype(GetCommonVar(ADC_Z));
      end;
    function TpmAPI05.Get_Uam: apitype;
    begin
        Result:=smallint(GetCommonVar(ADC_UAM));
     //   if Result<0 then begin  result:=result+1; result:=-result end;
    end;
    function TpmAPI05.Get_Ufm: apitype;
    begin
        Result:=GetCommonVar(ADC_UFM);
      end;
   function TpmAPI05.Get_Frequency: apitype;
    begin
        Result:=GetCommonVar(SD_GENF);
      end;
   procedure TpmAPI05.Set_Frequency(pVal: apitype);
   begin
       SetCommonVar(SD_GENF, pVal);
   end;
   function TpmAPI05.Get_SDGAM: apitype;
    begin
        Result:=GetCommonVar(SD_GAM);
      end;
    procedure TpmAPI05.Set_SDGAM(pVal: apitype);
     begin
         SetCommonVar(SD_GAM, pVal);
       end;
   function TpmAPI05.Get_SMZSTEP : apitype;
     begin
        Result:=GetCommonVar(SMZ_STEP);
      end;
    procedure TpmAPI05.Set_SMZSTEP(pVal: apitype);
     begin
         SetCommonVar(SMZ_STEP, pVal);
       end;
     function TpmAPI05.Get_SMZSTATUS : apitype;
     begin
        Result:=GetCommonVar(SMZ_STATUS);
      end;
    procedure TpmAPI05.Set_SMZSTATUS(pVal: apitype);
     begin
         SetCommonVar(SMZ_STEP, pVal);
       end;
    function TpmAPI05.Get_ITRRES : apitype;
      begin
        Result:=GetCommonVar(ITR_RES);
      end;
    procedure TpmAPI05.Set_ITRRES(pVal: apitype);
     begin
         SetCommonVar(ITR_RES, pVal);
     end;
   function TpmAPI05.Get_DACIREF: apitype;
     begin
        Result:=apitype(GetCommonVar(DAC_IREF));
      end;
    procedure TpmAPI05.Set_DACIREF(pVal: apitype);
     begin
         SetCommonVar(DAC_IREF, pVal);
      end;
    function TpmAPI05.Get_DACIREF_AM: apitype;
     begin
        Result:=apitype(GetCommonVar(DAC_IREF_AM));
      end;
    procedure TpmAPI05.Set_DACIREF_AM(pVal: apitype);
     begin
         SetCommonVar(DAC_IREF_AM, pVal);
      end;
    function TpmAPI05.Get_DACREFSTM: apitype;
     begin
        Result:=apitype(GetCommonVar(DAC_REFSTM));
      end;
    procedure TpmAPI05.Set_DACREFSTM(pVal: apitype);
    begin
         SetCommonVar(DAC_REFSTM, pVal);
    end;

    function TpmAPI05.Get_IT: apitype;
     begin
        Result:=smallint(GetCommonVar(ADC_IT));
     end;
    function TpmAPI05.Get_CmpValue: apitype;
    begin
     Result:=GetCommonVar(CMP_VAL);
    end;
    function TpmAPI05.Get_DACVT: apitype;
    begin
        Result:=GetCommonVar(DAC_VT);
    end;
    procedure TpmAPI05.Set_DACVT(pVal: apitype);
    begin
         SetCommonVar(DAC_VT, apitype(pVal));
    end;
   function TpmAPI05.Get_PATHSPD : apitype;
     begin
  //      Result:=GetCommonVar(PATH_SPD);
      end;
    procedure TpmAPI05.Set_PATHSPD(pVal: apitype);
     begin
      PATH_SPDDemo:=pVal;          //        SetCommonVar(PATH_SPD, unapitype(pVal));
     end;
     function TpmAPI05.Get_PATHSPD_BW : apitype;
     begin
 //    Result:=GetCommonVar(adr90);//aPath_SPD_BW=$90
     end;
    procedure TpmAPI05.Set_PATHSPD_BW(pVal: apitype);
     begin
       PATH_SPDDemo:=pVal; //        SetCommonVar(adr90, unapitype(pVal));//aPath_SPD_BW=$90
     end;
      procedure TpmAPI05.Set_IMaxCut(pVal: integer);
     begin
       SetCommonVar(IMaxCut, pVal);
     end;
     function TpmAPI05.Get_IMaxCut: integer;
     begin
//       SetCommonVar(IMaxCut, pVal);
     end;
    (*   procedure TpmAPI05.DAC_UPD(pVal:apitype);
     begin
 //        SetCommonVar(DAC_UPD, unapitype(pVal));
     end;

      function TpmAPI05.Get_DacLP: apitype;
    begin
        Result:=GetCommonVar(DAC_LP);
      end;
    procedure TpmAPI05.Set_DacLP(pVal: apitype);
     begin
         SetCommonVar(DAC_LP, unapitype(pVal));
      end;
    function TpmAPI05.Get_DacVt: apitype;
     begin
        Result:=GetCommonVar(DAC_VT);
      end;
    procedure TpmAPI05.Set_DacVt(pVal: apitype);
     begin
         SetCommonVar(DAC_VT, unapitype(pVal));
      end;
    function TpmAPI05.Get_DacIref: apitype;
     begin
        Result:=apitype(GetCommonVar(DAC_REF));
      end;
    procedure TpmAPI05.Set_DacIref(pVal: apitype);
     begin
         SetCommonVar(DAC_REF, unapitype(pVal));
      end;
*)
(*
    function TpmAPI05.Get_LAT: apitype;
    begin
        Result:=GetCommonVar(ADC_LAT);
      end;
 *)
    (*  function TpmAPI05.Get_LazerH: apitype;
    begin
        Result:=GetCommonVar(ADC_LASER_H);
      end;
    function TpmAPI05.Get_Vert: apitype;
    begin
        Result:=GetCommonVar(ADC_VERT);
      end;
    function TpmAPI05.Get_SdEnabled: apitype;
    begin
        Result:=GetCommonVar(SD_ENA);
      end;
    procedure TpmAPI05.Set_SdEnabled(pVal: apitype);
        begin
         SetCommonVar(SD_ENA, unapitype(pVal));
      end;
    function TpmAPI05.Get_SdZero: apitype;
    begin
        Result:=GetCommonVar(SD_ZERO);
      end;
    procedure TpmAPI05.Set_SdZero(pVal: apitype);
     begin
         SetCommonVar(SD_ZERO, unapitype(pVal));
      end;


    function TpmAPI05.Get_TuneZ: apitype;
    begin
        Result:=GetCommonVar(Z_TUNE);
      end;
    procedure TpmAPI05.Set_TuneZ(pVal: apitype);
     begin
         SetCommonVar(Z_TUNE, unapitype(pVal));
      end;

   *)
  {  function TpmAPI05.Get_Mode: CspmMode;
    procedure TpmAPI05.Set_Mode(pVal: CspmMode);
    function Get_MedianFilterEnabled: apitype;
    procedure Set_MedianFilterEnabled(pVal: apitype);

   }
    (* function TpmAPI05.Get_SDCOMP_AM : apitype;
    begin
        Result:=GetCommonVar(SD_COMP_AM);
      end;
    procedure TpmAPI05.Set_SDCOMP_AM(pVal: apitype);
     begin
         SetCommonVar(SD_COMP_AM, unapitype(pVal));
       end;
    function TpmAPI05.Get_SDGENF_F : apitype;
    begin
        Result:=GetCommonVar(SDGENF_F);
      end;
    procedure TpmAPI05.Set_SDGENF_F(pVal: apitype);
     begin
         SetCommonVar(SD_GENF_F,unapitype(pVal));
       end;
    function TpmAPI05.Get_SDGENF_R : apitype;
    begin
        Result:=GetCommonVar(SD_GENF_R);
      end;
    procedure TpmAPI05.Set_SDGENF_R(pVal: apitype);
     begin
         SetCommonVar(SD_GENF_R, unapitype(pVal));
       end;
    function TpmAPI05.Get_SDGEN_M  : apitype;
    begin
        Result:=GetCommonVar(SD_GAIN_FM);
      end;
    procedure TpmAPI05.Set_SDGEN_M(pVal: apitype);
     begin
         SetCommonVar(SD_GAIN_FM, unapitype(255-pVal));
       end;
    function TpmAPI05.Get_SDGAIN_FM : apitype;
    begin
        Result:=GetCommonVar(SD_GEN_M);
      end;
    procedure TpmAPI05.Set_SDGAIN_FM(pVal: apitype);
     begin
         SetCommonVar(SD_GEN_M, unapitype(pVal));
     end;
    function TpmAPI05.Get_VTSIGN : apitype;
    begin
        Result:=GetCommonVar(VT_SIGN);
      end;
    procedure TpmAPI05.Set_VTSIGN(pVal: apitype);
     begin
         SetCommonVar(VT_SIGN, unapitype(pVal));
       end;

    function TpmAPI05.Get_DACUPD: apitype;
     begin
        Result:=GetCommonVar(DAC_UPD);
      end;
    procedure TpmAPI05.Set_DACUPD(pVal: apitype);
     begin
         SetCommonVar(DAC_UPD, unapitype(pVal));
       end;
    function TpmAPI05.Get_ADCMCH_ENA: apitype;
     begin
        Result:=GetCommonVar(ADC_MCH_ENA);
      end;
    procedure TpmAPI05.Set_ADCMCH_ENA(pVal: apitype);
     begin
         SetCommonVar(ADC_MCH_ENA, unapitype(pVal));
       end;
    function TpmAPI05.Get_PMSPEED : apitype;
     begin
        Result:=GetCommonVar(PM_SPEED);
      end;
    procedure TpmAPI05.Set_PMSPEED(pVal: apitype);
     begin
         SetCommonVar(PM_SPEED, unapitype(pVal));
       end;
    function TpmAPI05.Get_PMSTEP  : apitype;
     begin
        Result:=GetCommonVar(PM_STEP);
      end;
    procedure TpmAPI05.Set_PMSTEP(pVal: apitype);
        begin
         SetCommonVar(PM_STEP, unapitype(pVal));
       end;
    procedure TpmAPI05.Set_PMPAUSE(pVal: apitype);
        begin
     case ScannerMoveXYZParams.TypeMover of
1,4: SetCommonVar(adr96, unapitype(pVal));  //CTPause=$96
2,3: SetCommonVar(adr86, unapitype(pVal));  //CTPause=$96
     end;
       end;
 *)
  (* function TpmAPI05.Get_SMZSPEED : apitype;
     begin
        Result:=GetCommonVar(SMZ_SPEED);
      end;
    procedure TpmAPI05.Set_SMZSPEED(pVal: apitype);
     begin
         SetCommonVar(SMZ_SPEED, unapitype(pVal));
       end;
       function TpmAPI05.Get_SMXSTEP : apitype;
     begin
        Result:=GetCommonVar(SMX_STEP);
      end;
    procedure TpmAPI05.Set_SMXSTEP(pVal: apitype);
     begin
         SetCommonVar(SMX_STEP, unapitype(pVal));
       end;
    function TpmAPI05.Get_SMXSPEED : apitype;
     begin
        Result:=GetCommonVar(SMX_SPEED);
      end;
    procedure TpmAPI05.Set_SMXSPEED(pVal: apitype);
     begin
         SetCommonVar(SMX_SPEED, unapitype(pVal));
       end;
         function TpmAPI05.Get_SMYSTEP : apitype;
     begin
        Result:=GetCommonVar(SMY_STEP);
      end;
    procedure TpmAPI05.Set_SMYSTEP(pVal: apitype);
     begin
         SetCommonVar(SMY_STEP, unapitype(pVal));
       end;
    function TpmAPI05.Get_SMYSPEED : apitype;
     begin
        Result:=GetCommonVar(SMY_SPEED);
      end;
    procedure TpmAPI05.Set_SMYSPEED(pVal: apitype);
     begin
         SetCommonVar(SMY_SPEED, unapitype(pVal));
       end;

    function TpmAPI05.Get_PATHSPD : apitype;
     begin
        Result:=GetCommonVar(PATH_SPD);
      end;
    procedure TpmAPI05.Set_PATHSPD(pVal: apitype);
     begin
         SetCommonVar(PATH_SPD, unapitype(pVal));
     end;
       function TpmAPI05.Get_PATHSPD_BW : apitype;
     begin
        Result:=GetCommonVar(adr90);//aPath_SPD_BW=$90
      end;
    procedure TpmAPI05.Set_PATHSPD_BW(pVal: apitype);
     begin
         SetCommonVar(adr90, unapitype(pVal));//aPath_SPD_BW=$90
     end;


     function TpmAPI05.Get_CMPENA : apitype;
      begin
        Result:=GetCommonVar(CMP_ENA);
      end;
    procedure TpmAPI05.Set_CMPENA(pVal: apitype);
     begin
         SetCommonVar(CMP_ENA, unapitype(pVal));
       end;
      function TpmAPI05.Get_CMPRES : apitype;
      begin
        Result:=GetCommonVar(CMP_RES);
      end;
    procedure TpmAPI05.Set_CMPRES(pVal: apitype);
     begin
         SetCommonVar(CMP_RES, unapitype(pVal));
       end;
  *)
  (*  function TpmAPI05.Get_ITR_SEL : apitype;
      begin
        Result:=GetCommonVar(ITR_SEL);
      end;
    procedure TpmAPI05.Set_ITR_SEL(pVal: apitype);
     begin
         SetCommonVar(ITR_SEL, unapitype(pVal));
     end;

   function TpmAPI05.Get_FBENA : apitype;
      begin
        Result:=GetCommonVar(FB_ENA);
      end;
   procedure TpmAPI05.Set_FBENA(pVal: apitype);
     begin
         SetCommonVar(FB_ENA, unapitype(pVal));
       end;
   function TpmAPI05.Get_FBSEL : apitype;
      begin
        Result:=GetCommonVar(FB_SEL);
      end;
   procedure TpmAPI05.Set_FBSEL(pVal: apitype);
     begin
         SetCommonVar(FB_SEL, unapitype(pVal));
     end;
   function TpmAPI05.Get_FB_GAIN : apitype;
      begin
        Result:=GetCommonVar(ITR_SEL);
      end;
   procedure TpmAPI05.Set_FB_GAIN(pVal: apitype);
     begin
         SetCommonVar(ITR_Res,1);
         sleep(ApproachParams.ScannerDecay);
         SetCommonVar(ITR_SEL, unapitype(pVal));
         SetCommonVar(ITR_Res,0);
         sleep(ApproachParams.ScannerDecay);
       end;
    function TpmAPI05.Get_CHMODSEL : apitype;
      begin
        Result:=GetCommonVar(CHMOD_SEL);
      end;
    procedure TpmAPI05.Set_CHMODSEL(pVal: apitype);
     begin
         SetCommonVar(CHMOD_SEL, unapitype(pVal));
       end;
     function TpmAPI05.Get_XYTUNE : apitype;
      begin
        Result:=GetCommonVar(XY_TUNE);
      end;
    procedure TpmAPI05.Set_XYTUNE(pVal: apitype);
        begin
         SetCommonVar(XY_TUNE, unapitype(pVal));
       end;
      function TpmAPI05.Get_ENDSCAN : apitype;
      begin
        Result:=GetCommonVar(END_SCAN);
      end;
    procedure TpmAPI05.Set_ENDSCAN(pVal: apitype);
        begin
         SetCommonVar(END_SCAN, unapitype(pVal));
       end;

   procedure TpmAPI05.Set_MODE(pVal: apitype);
        begin
         SetCommonVar(MODE,unapitype(pVal));
       end;
       *)
end.
