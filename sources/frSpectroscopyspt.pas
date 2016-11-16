unit frSpectroscopyspt;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frParInput, TeEngine, Series, StdCtrls, Buttons, ExtCtrls, TeeProcs,
  Chart,ComCtrls,Math, ClipBrd, AppEvnts,GlobalType, GlobalDCl,
  QuickRpt, QRCtrls,SpmChart, siComp, siLngLnk, Menus, ToolWin,frspectroscopy;

type
  TSpectroscopyspt = class(TSpectroscopy)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FrNPointsEditFrmChange(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure FrStartPEditFrmChange(Sender: TObject);
  private
    { Private declarations }
      procedure DrawGraphics(const i:integer; UData:Array of apitype; const StepZ,StepValue:single);

  public
    { Public declarations }
     constructor Create(AOwner:TComponent);       overload;
//     constructor Create(AOwner:TComponent;const FileName:string);  overload;

  end;

var
  Spectroscopyspt: TSpectroscopyspt;

implementation

{$R *.dfm}
 uses CSPMVar,nanoeduhelp, frScanWnd, GlobalVar,UNanoEduBaseClasses,UNanoEduClasses,
     uNanoEduScanClasses,frReport,
     GlobalFunction, mMain, frSetInteraction,
     frApproachnew,frSPM_Browser;
 const
	strs1: string = ''; (* no Demo Data!!! *)
	strs2: string = ''; (* The step too small! *)
	strs3: string = ''; (* Change Parameters. *)
	strs4: string = ''; (* The step too small!Change Parameters. *)
	strs5: string = ''; (* Error input. Start point must be <=0! *)
	strs6: string = ''; (* Error input *)
	strs7: string = ''; (* Printer is not connected.   *)
	strs8: string = ''; (*  File not exist *)
	strs9: string = ''; (* Click Right Button- Popup Menu;Labels ( Click  Left Button - Add ;  Del - Delete;Up,Down-Next,Previous ); *)
	strs10: string = ''; (* Curves (Pg up,Pg down- next, previous) *)

constructor TSpectroscopySPT.Create(AOwner:TComponent);
 var  STopUAM:single;
      FileName,TabImgCaption:string;
begin
 inherited Create(AOwner);
       siLangLinked.ActiveLanguage:=Lang;
       frStartP.siLangLinked1.ActiveLanguage:=Lang;
       frEndPoint.siLangLinked1.ActiveLanguage:=Lang;
       frNPoints.siLangLinked1.ActiveLanguage:=Lang;
       frT.siLangLinked1.ActiveLanguage:=Lang;
       frSupLevel.siLangLinked1.ActiveLanguage:=Lang;
       UpdateStrings;
// Statusbar.simpletext:='Mouse Click -- Add Label; Del -- Delete Label;'+#13+'Page Up -- Next Curve;  Page Down -- Previous Curve';

 BaseCaptionStep:=siLangLinked.GetTextOrDefault('IDS_0' (* 'Step=' *) ) ;
 BaseCaptionStepMin:=siLangLinked.GetTextOrDefault('IDS_1' (* 'Step Min=' *) ) ;
 prevScanMethod:=ScanParams.ScanMethod;
 FlgSurfaceData:=not SetIntActOnProgr;//    True;
 BaseCaption:=siLangLinked.GetTextOrDefault('IDS_2' (* 'Spectroscopy' *) );
 Caption:=BaseCaption;
 DemoSpectrCnt:=0;
 Top:=TopStart;
 left:=(main.Clientwidth-Clientwidth) div 2;
 Error:=0;
 lflgIZ:=SpectrParams.flgIZ;
 if assigned(ScanWnd) then Scanwnd.StartBtn.Enabled:=false;
 LblWarning.Visible:=false;
 LabelStep.Caption:='';
 NPage:=SpectrParams.NSpectrPoints;
 NGraphP:=SpectrParams.NCurves;
 FindLine_Pos:=0;
 T:=SpectrParams.T;
 TC:=ApproachParams.ScannerDecay;
 NumbP:=SpectrParams.NPoints;
 seriesColor[0]:=clblue;
 seriesColor[1]:=clred;
 seriesColor[2]:=clgreen;
 seriesColor[3]:=clblack;
 StartPointZ:=SpectrParams.StartSPT;    //nm
 EndPointZ:=SpectrParams.EndSPT;       //nm
 ZStepMin:=(1/TransformUnit.Znm_d);
 if lflgIZ then StepValueMin:=1/TransformUnit.nA_d
           else StepValueMin:=1/ApproachParams.UAMmax;

 if FlgCurrentUserLevel<> Demo then
   begin
      SpectrParams.StartPointLimit:=100;
      SpectrParams.FinalPointLimit:=10;
   end
 else  //Demo
   begin
     FileName:=DemoDataDirectory+DemoSample+'\'+DemoSpectrSFMFile;
     Error:=LoadDemoCurves(FileName,DemoSpectrCurves);
     if Error<>0 then
       begin
        SpectrParams.StartPointLimit:=100;
        SpectrParams.FinalPointLimit:=10;
       end;
      StepValueMin:=1/DemoSpectrNorm;
      prevUAMMax:= ApproachParams.UAMmax;
      ApproachParams.UAMmax:=DemoSpectrNorm;
      ZStepMin:=DemoSpectrStep;
   end;

    SetLength(ScanData.AquiSpectr.Data,SpectrParams.NSpectrPoints,2*2*SpectrParams.NPoints);   // 2*(UAM,Z)*Npoints
    SetLength(ScanData.AquiSpectrPoint,2*SpectrParams.NSpectrPoints);
   { TODO : 290507 }
   /////!!!!!!!!!!!!!!!
    ScanData.HeaderPrepare;

  with   FrT   do              //delay
   begin
    ScrollBarFrm.Max:=100;
    ScrollBarFrm.Min:=0;
    ScrollBarFrm.Position:=SpectrParams.T;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:=siLangLinked.GetTextOrDefault('IDS_3' (* 'ms' *) );
   end;
  with   FrStartP   do
   begin
    ScrollBarFrm.Min:=0;//SpectrParams.StartPointLimit;
    ScrollBarFrm.Max:=100;
    ScrollBarFrm.Position:=SpectrParams.StartSPT;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:=siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
   end;
  with FrEndPoint do
   begin
    ScrollBarFrm.Max:=100;//SpectrParams.FinalPointLimit;
    ScrollBarFrm.Position:=SpectrParams.Endspt;
    ScrollBarFrm.Min:=0;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:=siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
   end;
  with FrSupLevel do
   begin
    ScrollBarFrm.Max:=100;
    ScrollBarFrm.Min:= 0;
    ScrollBarFrm.Position:=SpectrParams.LevelSFM;
    if  lflgIZ then
    begin
     VertMin:=round(ScrollBarFrm.Position*0.01*MaxApiType);
     BitBtnFrm.Caption:=siLangLinked.GetTextOrDefault('IDS_6' (* 'Limit IT %' *) )
    end
    else
    begin
     VertMin:=round((ScrollBarFrm.Max-ScrollBarFrm.Position)*0.01*ApproachParams.UAMMax);   //discr
     BitBtnFrm.Caption:=siLangLinked.GetTextOrDefault('IDS_7' (* 'Suppression ' *) )
    end;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:='%';
   end;

   with FrNPoints do
   begin
    ScrollBarFrm.Max:=600;
    ScrollBarFrm.Min:= 1;
    ScrollBarFrm.Position:=SpectrParams.NPoints;
    EditFrm.Text:=IntToStr(ScrollBarFrm.Position);
    LabelUnit.Caption:='';
   end;
    if  lflgIZ then
    begin
     Lblwarning.Panels[0].Text:=siLangLinked.GetTextOrDefault('IDS_8' (* 'Warning! The set limit of current is achieved!!! ' *) ) ;
   //  LblWarning.Caption:=siLangLinked.GetTextOrDefault('IDS_8' (* 'Warning! The set limit of current is achieved!!! ' *) ) ;
//     label1.caption:='Level IT'
    end
    else
    begin
     Lblwarning.Panels[0].text:=siLangLinked.GetTextOrDefault('IDS_9' (* 'Warning! The set limit of suppression of a amplitude oscillation is achieved!!! ' *) ) ;
     Lblwarning.Panels[1].text:=siLangLinked.GetTextOrDefault('IDS_5' (* 'Change final point.' *) )  ;
//     LblWarning.Caption:=siLangLinked.GetTextOrDefault('IDS_9' (* 'Warning! The set limit of suppression of a amplitude oscillation is achieved!!! ' *) ) ;
//     label1.caption:='Amplitude suppression'
    end;
    StartPointZ:=StrToInt(FrStartP.EditFrm.Text);    //nm
    EndPointZ:=StrToInt(FrEndPoint.EditFrm.Text);       //nm
    NumbP:=StrToInt(FrNPoints.EditFrm.Text);
    ZStep:=(abs(StartPointZ)+EndPointZ)/(NumbP-1);

   LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
   LabelStepMin.Caption:=BaseCaptionStepMin+FloatToStrF(ZStepMin,ffFixed,5,2)+siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );

   if flgSurfaceData then
    begin
        case  ScanData.FileHeadRcd.HAquiADD of
  TopoGraphy:    TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_12' (* 'Topography/Top View' *) );
   Phase:        TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_13' (* 'Phase Shift' *) );
    UAM:         TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_14' (* 'Force Image' *) );
    Current:  TabImgCaption:=siLangLinked.GetTextOrDefault('IDS_15' (* 'Current Image' *) );
             end;
      SpectrImgCreate(TabImgCaption);
      ScanImageDraw(ScanWnd.ImgRChart.BackImage.Bitmap, ScanParams.Nx, ScanParams.Ny);
    end;
    SpectrGraphCreate;
 if assigned(ScanWnd) then ScanWnd.WindowState:=wsMinimized;
end;

procedure TSpectroscopySPT.DrawGraphics(const i:integer; UData:Array of apitype; const StepZ,StepValue:single);
var
    k,j,m,Index:integer;
    umstart,umstop:single;
    Z,Value:single;
    nz:integer;
begin
  Nz:=length(UData) div 4 ;
  umstart:=(UData[1]*ZStepMin);
  umstop:=(UData[2*nz-1]*ZStepMin);
   Index:=i;
   PageControl.Pages[Index].HighLighted:=False;
   if Assigned(TabSheetSpectr) then  inc(Index);
     PageControl.ActivePageIndex:=Index;
     PageControl.ActivePage.HighLighted:=True;
 for j:=0 to (NgraphP-1) do
  begin
    case j of
    0: begin     //red          landing
        m:=0;
        ArChart[i].SetActiveSeries(ArChart[i].HeadSeriesList.Series);
      for k:=0 to (Nz-1) do
       begin
          Z:=UData[m+1]*ZStepMin;
          value:=UData[m]*StepValueMin;
          ArChart[i].HeadSeriesList.Series.AddXY(Z,Value);
           inc(m,2);
       end;
      end;
    1: begin      //blue        rising
        m:=2*Nz;
          ArChart[i].SetActiveSeries(ArChart[i].HeadSeriesList.next.Series);
       for k:=Nz to (2*Nz-1) do
       begin
         Z:=UData[m+1]*ZStepMin;
         value:=UData[m]*StepValueMin;
         if Z>=umstart then
         begin
           ArChart[i].HeadSeriesList.Next.Series.AddXY(Z,Value);//,'',seriesColor[j]);
         end
         else if not (flgCurrentUserLevel=Demo) then  lblwarning.Visible:=true;
             inc(m,2);

        end;
           Application.ProcessMessages;
      end;
    end; //case
  end; //j
    ActiveIndex:= PageControl.ActivePageIndex;
    if Assigned(TabSheetSpectr) then  dec(ActiveIndex);
    ArChart[i].SetActiveSeries(ArChart[i].HeadSeriesList.Series);
    ArChart[ActiveIndex].SetFindLine_pos(0);
    ArChart[ActiveIndex].RePaint;
end;


procedure TSpectroscopyspt.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
begin
 Application.ProcessMessages;
 if ControlPanel.Visible then   //????
 begin
  if flgCurrentUserLevel=Demo then ApproachParams.UAMmax:=prevUAMMax;
   if assigned(ScanWnd) then
   begin
    Scanwnd.RestoreStartSFM;     { TODO : 160906 }
   end;
   ScanParams.ScanMethod:=prevScanMethod;
   Finalize(DemoSpectrCurves);
    if (not assigned(ScanWnd)) and assigned(ScanData)   then  FreeAndNil(ScanData);
    if assigned(ScanWnd)        then  ScanWnd.WindowState:=wsNormal;
    if Assigned(Approach)       then  Approach.WindowState:=wsNormal;
    if Assigned(SetInteraction) then  SetInteraction.WindowState:=wsNormal;
 end;
    for i:=0 to  NPage-1 do
    begin
      ArChart[i].Destroy;
      ArChart[i]:=nil;
      ArTabSheet[i].Destroy;
      ArTabSheet[i]:=nil;
    end;
    Finalize(ArChart);
    Finalize(ArTabSheet);
 if assigned(QRImage)  then FreeAndNil(QRImage);
 if assigned(QRBand)   then FreeAndNil(QRBand);
 if assigned(QuickRep) then FreeAndNil(QuickRep);
 if (ArFrmGl.count=0)then
   begin
    Main.ActionImageTools.Visible:=false;
    Main.FileInfItem.Enabled:=False;
    Main.PrintItem.Enabled:=False;
    Main.ToolBtnPrint.Enabled:=false;
    Main.FileInfItem.Enabled:=false;
    Main.ToolBtnExp.visible:=false;
   end;
   if (ArFrmSpectr.count=0) and (ArFrmGl.count=0) then
   begin
    Main.ArrangeWindows1.Enabled:=False;
    Main.SaveAsItem.Enabled:=false;
    Main.PrintItem.Enabled:=False;
    Main.ToolBtnPrint.Enabled:=true;
    Main.ToolBtnExp.visible:=false;
   end;
  if not ControlPanel.Visible then   //????
  begin  ArFrmSpectr.Remove(self); end;
    Action:=caFree;
  if (self=Spectroscopyspt) then  Spectroscopyspt:=nil;
end;

procedure TSpectroscopyspt.FrNPointsEditFrmChange(Sender: TObject);
 var val:integer;
begin
 try
  if (FrNpoints.editFrm.text='')  then   exit;
   val:=StrToInt(FrNpoints.EditFrm.Text);
    if val<FrNpoints.ScrollBarFrm.Min then
    begin
     val:=FrNpoints.ScrollBarFrm.Min;
     FrNpoints.EditFrm.Text:=inttostr(val);
    end;
    if val>FrNpoints.ScrollBarFrm.Max then
    begin
     val:=FrNpoints.ScrollBarFrm.Max;
     FrNpoints.EditFrm.Text:=inttostr(val);
    end;
    NumbP:=StrToInt(FrNPoints.EditFrm.Text);
    ZStep:=0.01*(StartPointZ-EndPointZ)*approachparams.UAMMax/(NumbP-1);
 //   ZStepD:=round(ZStep); //discrete
    LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+ siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
    LabelStep.Font.Color:=clBlack;
    { TODO : 250607 }
    FrNpoints.ScrollBarFrm.position:=NumbP;
    if ZStep<ZStepMin then
     begin
      LabelStep.Font.Color:=clRed;
     end;
  except
    on EConvertError do
     begin MessageDlg(strs6{'error input'},mtWarning,[mbOk],0);FrNpoints.editFrm.text:=siLangLinked.GetTextOrDefault('IDS_57' (* '100' *) );end;
  end;
end;

procedure TSpectroscopyspt.FrStartPEditFrmChange(Sender: TObject);
 var Val:integer;
begin
  if (FrStartP.editFrm.text='') or (FrStartP.editFrm.text='-') then   exit;
  try
      val:=StrToInt(FrStartP.EditFrm.Text);
    if val<FrStartP.ScrollBarFrm.Min then
    begin
     val:=FrStartP.ScrollBarFrm.Min;
     FrStartP.EditFrm.Text:=inttostr(val);
    end;
    if val>FrStartP.ScrollBarFrm.Max then
    begin
     val:=FrStartP.ScrollBarFrm.Max;
     FrStartP.EditFrm.Text:=inttostr(val);
    end;
    StartPointZ:=StrToInt(FrStartP.EditFrm.Text);
    ZStep:=(EndPointZ-StartPointZ)/(NumbP-1);
    FrStartP.ScrollBarFrm.Position:=StartPointZ;
    LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+ siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
    LabelStep.Font.Color:=clBlack;
(*  if ZStep<ZStepMin then
     begin
      LabelStep.Font.Color:=clRed;
    end;
 *)
except
    on EConvertError do
     begin
      MessageDlg(strs5{'Error input. Start point must be <=0!'},mtWarning,[mbOk],0);
      FrStartP.editFrm.text:=siLangLinked.GetTextOrDefault('IDS_53' (* '-200' *) );
    end;
 end;
end;

procedure TSpectroscopyspt.StartBtnClick(Sender: TObject);
var i,j,index:integer;
    x0nm,y0nm:double;
    nCor,NumbPupdate:apitype;
    ZStepD:word;//discr
begin
 if Error=0 then
 begin
 try
    flgProcess:=true;
    Caption:=BaseCaption;
    StartBtn.Enabled:=False;
    BitBtnSave.Enabled:=false;
    BitBtnExit.Enabled:=false;
    inc(countStart);
    WorkNameFile:=workdirectory+'\'+WorkNameFileMaskCur+ScandataWorkFileNameEm(CountStart)+WorkExtFile;
    T:=StrToInt(FrT.EditFrm.Text);
    StartPointZ:=StrToInt(FrStartP.EditFrm.Text);        //nm
    EndPointZ:=StrToInt(FrEndPoint.EditFrm.Text);       //nm
    NumbP:=StrToInt(FrNPoints.EditFrm.Text);
    if  lflgIZ then VertMin:=round(StrtoInt(FrSupLevel.EditFrm.Text)*0.01*MaxApiType)
               else VertMin:=round((100-StrtoInt(FrSupLevel.EditFrm.Text))*0.01*ApproachParams.UAMMax);   //discr

//    StartBtn.Font.Color:=clRed;
    ZStep:=0.01*(StartPointZ-EndPointZ)*approachparams.UAMMax/(NumbP-1);
    ZStepD:=round(ZStep); //discrete
    nCor:=0;//round(0.01*(StartPointZ-EndPointZ)*approachparams.UAMMax-ZStepD*(NumbP-1)) div ZStepD;
    NumbPUpdate:=NumbP+nCor;
    lblWarning.Visible:=false;
   if ZStepD<1 then  begin  MessageDlg(strs4{siLangLinked1.GetTextOrDefault('IDS_46' (* 'Step too small!Change Parameters.' *) )},mtWarning,[mbOk],0); exit; end;
    LabelStep.Caption:=BaseCaptionStep+FloatToStrF(ZStep,ffFixed,5,2)+ siLangLinked.GetTextOrDefault('IDS_4' (* 'nm' *) );
    SpectrParams.StartSPT:=round(0.01*StartPointZ*approachparams.UAMMax);    //nm
    SpectrParams.EndSPT:=round(0.01*EndPointZ*approachparams.UAMMax);       //nm
    SpectrParams.NPoints:=NumbPUpdate;
    SpectrParams.NSpectrPoints:=ArPntSpector.Count;  //number point when spectroscopy are  made
    SpectrParams.T:=T ;
    SpectrParams.TC:=ApproachParams.ScannerDecay;
    SpectrParams.LevelSFM:=StrtoInt(FrSupLevel.EditFrm.Text);
    SpectrParams.Step:=ZStepD;  { TODO : 220506 }
     j:=0;

    ScanData.AquiSpectr.Data:=nil;   // 2*(UAM,Z)*Npoints
    ScanData.AquiSpectrPoint:=nil;

    SetLength(ScanData.AquiSpectr.Data,SpectrParams.NSpectrPoints,2*2*SpectrParams.NPoints);   // 2*(UAM,Z)*Npoints
    SetLength(ScanData.AquiSpectrPoint,3*SpectrParams.NSpectrPoints);
   { TODO : 290507 }
    ScanData.HeaderPrepare;

   for i:=0 to (NPage-1) do ArChart[i].ClearAllSeries;

   j:=0;
   for i:=0 to NPage-1 do
    begin
      PntSpector:=ArPntSpector.items[i];
      x0nm:=PntSpector^.point.x;
      y0nm:=PntSpector^.point.y;
      ScanData.AquiSpectrPoint[j]:=round(x0nm*TransformUnit.XPnm_d);    //discrets
      ScanData.AquiSpectrPoint[j+1]:=round(y0nm*TransformUnit.YPnm_d);
      ScanData.AquiSpectrPoint[j+2]:=1;
      inc(j,3);
       NanoEdu.ScanMoveToX0Y0Method(X0nm,y0nm);
       error:=NanoEdu.Method.Launch;
       FreeAndNil(NanoEdu.Method);
    if error<>0 then
    begin
     RestoreStart;
     exit
    end;
      Application.ProcessMessages;
      SpectrParams.CurrentLine:=i;
      DemoSpectrCnt:=i;
      NanoEdu.SpectroscopySPTMethod;
     if NanoEdu.Method.Launch<>0 then begin FreeAndNil(NanoEdu.Method); ReStoreStart; exit; end;
      DrawGraphics(i, (Nanoedu.Method as TSpectroscopySPTSFM).U, ZStepMin, StepValueMin);
      if ArChart[i].flgFilter then
      begin
        ArChart[i].FiltrAverage;
        ArChart[i].SetFindLine_pos(0);
      end;
      FreeAndNil(NanoEdu.Method);
      Application.ProcessMessages;
   end;    //i    { TODO : 071007 }     //move to the x0,y0
    while assigned(nanoedu.method) do Application.ProcessMessages;   //wait for  end scanning
       NanoEdu.ScanMoveToX0Y0Method(ScanParams.Xbegin,ScanParams.Ybegin);
       NanoEdu.Method.Launch;
       FreeAndNil(NanoEdu.Method);
   with PageControl do
  begin
    for i:=0 to PageCount-1 do Pages[i].HighLighted:=False;
   Activepage:= ArTabSheet[0];
   ActivePage.HighLighted:=True;
  end;
  ReStoreStart;
  BitBtnSaveClick(Sender);
  Main.ToolBtnExp.visible:=true;
 if assigned(Scanwnd) then
 begin
  Scanwnd.SaveExpBtn.Enabled:=True;
  Scanwnd.flgBlickSave:=true;
 end;
 except
   on EConvertError do
    begin end;
  end;
 end{Error=0}
 else
    MessageDlgCtr(strs1{'no Demo Data!!!'}, mtInformation,[mbOk],0);
end;
end.
