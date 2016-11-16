//151002
unit frScanParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,  ComCtrls, StdCtrls, Math,
  SystemConfig, mHardWareOpt, Buttons;

type
  TScanFieldParams = class(TFrame)
    Panel3: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PanelScanParam: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edScanRate: TEdit;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    edScanNmb: TEdit;
    Label7: TLabel;
    edDZ: TEdit;
    ClearlBtn: TButton;
    //ImageScanArea: TImage;
    CurScanPanel: TPanel;
    ImCurrentScan: TImage;
    LabelZmax: TLabel;
    LabelZmin: TLabel;
    ApplyBitBtn: TBitBtn;
    Label8: TLabel;
    FrameTime: TLabel;
    edX: TEdit;
    edY: TEdit;
    edNX: TEdit;
    edNY: TEdit;
    PageCtrlScan: TPageControl;
    PanelScanImage: TPanel;
    PanelM: TPanel;
    BitBtnMg: TBitBtn;
    ImageScanArea: TImage;
    procedure ApplyBtnClick(Sender: TObject);
    procedure ClearlBtnClick(Sender: TObject);
    procedure edXChange(Sender: TObject);
    procedure edYChange(Sender: TObject);
    procedure edNXChange(Sender: TObject);
    procedure edScanRateChange(Sender: TObject);
    procedure ImageScanAreaMouseDown(Sender: TObject; Button: TMouseButton;
                                    Shift: TShiftState; X, Y: Integer);
    procedure ImageScanAreaMouseMove(Sender: TObject; Shift: TShiftState; X,
                                      Y: Integer);
    procedure ImageScanAreaMouseUp(Sender: TObject; Button: TMouseButton;
                                   Shift: TShiftState; X, Y: Integer);
    procedure BitBtnMClick(Sender: TObject);

  private
  X0,Y0:integer;

  public
    R:TRect;
    FlgMouseDown :boolean;
    XMax,YMax:single; //   Max size of Scan field (nm);
    DelImgX,DelImgY:single; // nm, Distance between points in the ImageScanArea;

    constructor Create(AOwner: TComponent); override;
  end;

var
 StepXY:double;
 

implementation

uses  mScanRate, fScanSFM{,fApproach},GlobalVar;
var   MButtonNmb:byte;
{$R *.DFM}

constructor TScanFieldParams.Create(AOwner: TComponent);
var
 ScanDiscrNumb:integer;
 wh:integer;
begin
 inherited;
 ApplyBitBtn.Font.Color:=clBlack;
 edX.Font.color:=clBlack;
 edY.Font.color:=clBlack;
 edNX.Font.color:= clBlack;
 edNY.Font.color:= clBlack;
 edScanRate.Font.Color:= clBlack ;
 edScanNmb.Text:='0';
 edDZ.Text:='0';
 edX.Text:=format('%6.0f',[ScanParams.X]);
 edY.Text:=format('%6.0f',[ScanParams.Y]);
 edNX.Text:=format('%d',[ScanParams.NX]);
 edNY.Text:=format('%d',[ScanParams.NY]);
//edCadrTime.Text:=format('%f',[ScanParams.CadrTime]);
 edScanRate.Text:=FloatToStrF(ScanParams.ScanRate,ffFixed,5,0);
 ApplyBitBtn.Font.Color:=clBlack;
 edX.Font.color:=clBlack;
 edY.Font.color:=clBlack;
 edNX.Font.color:= clBlack;
 edNY.Font.color:= clBlack;
 edScanRate.Font.Color:= clBlack ;
 {wh:=PanelScanImage.Width;
 if wh>PanelScanImage.Height then wh:=PanelScanImage.Height ;
 with ImageScanArea do
  begin
   Height:=wh;
   Width:=wh;
  end; }
 PageCtrlScan.ControlStyle:= PageCtrlScan.ControlStyle + [csOpaque];
 PanelScanImage.ControlStyle:= PanelScanImage.ControlStyle + [csOpaque];
 ImageScanArea.ControlStyle := ImageScanArea.ControlStyle + [csOpaque];
 ImCurrentScan.ControlStyle := ImCurrentScan.ControlStyle + [csOpaque];
 XMax:=CSPMSignals[8].MaxVal/TransformUnit.Xnm_d;
 YMax:=CSPMSignals[9].MaxVal/TransformUnit.Ynm_d;
 ScanDiscrNumb:=round($8000*ScanParams.X/XMax);
 PageCtrlScan.ActivePageIndex:=0;
 SetScanRate(ScanParams.X,ScanDiscrNumb,ScanParams.Nx);
 edScanRate.Text:=FloatToStrF(ScanParams.ScanRate,ffFixed,5,0);

 with ScanParams do
  begin
   Microstep:=1;//DiscrNuminMicroStep;//integer;
   MicrostepDelay:=round(1000*tMicrostepDelay);// mks;
   if MicrostepDelay=0 then MicrostepDelay:=1;
           MicrostepNmb:= NDiscrBetweenPoints;// JMP;
           ImageScanArea.Canvas.Pen.Color:=clBlack;
           ImageScanArea.Canvas.Pen.Mode:=pmCopy;
           ImageScanArea.Canvas.Pen.Style:=psSolid;//NOTXOR;
  end;
   FrameTime.Caption:=FloatToStrF(ScanParams.X*ScanParams.Ny/ScanParams.ScanRate,ffFixed,7,2);
end;

procedure TScanFieldParams.ApplyBtnClick(Sender: TObject);
var
DelImg2X,DelImg2Y:double;
ScanDiscrNumb:integer;
begin
       if FlgStopScan then
begin
 //ScanWND.FlgPressApply:=0;
with ScanParams do
begin
   X:=StrToFloat(edX.Text);
   Y:=StrTofloat(edY.Text);
   NX:=StrToInt(edNX.Text);
   StepXY:=X/NX;
   NY:=round(Y/StepXY);
   edNY.Text:=IntToStr(NY);
   XBegin:=R.Left*DelImgX;
   YBegin:=(ImageScanArea.Height-R.Bottom)*DelImgY;       //????290902
  // CadrTime:=StrToFloat(edCadrTime.Text);
   ScanRate:=StrToFloat(edScanRate.Text);
   Xbegin:=Xbegin+ScanWnd.Img2XBegin; //????
   Ybegin:=Ybegin+ScanWnd.Img2YBegin;
   R.Left:= round(XBegin/DelImgX);
   R.Top:= ImageScanArea.Height-round((YBegin+Y)/DelImgY);
   R.Right:=round((XBegin+X)/DelImgX);
   R.Bottom:=ImageScanArea.Height-round((YBegin)/DelImgY);
end;
    DelImg2X:=(ScanParams.NX/ScanWnd.Img2Width0);
    DelImg2Y:=(ScanParams.NY/ScanWnd.Img2Height0);

  with ScanWnd do
    begin
     Img2XBegin:=0;
     Img2YBegin:=0;
     DelImg2:=max(DelImg2X,DelImg2Y);
     ImageTopR.Width:=round(ScanParams.NX/DelImg2);
     ImageTopR.Height:= round(ScanParams.NY/DelImg2);
     ImagePhaseR.Width:=round(ScanParams.NX/DelImg2);
     ImagePhaseR.Height:= round(ScanParams.NY/DelImg2);
     ImageTopL.Width:=round(ScanParams.NX/DelImg2);
     ImageUAMR.Width:=round(ScanParams.NX/DelImg2);
     ImageUAMR.Height:=round(ScanParams.NY/DelImg2);
     ImageTopL.Height:= round(ScanParams.NY/DelImg2);
     ImageSpectrR.Width:=round(ScanParams.NX/DelImg2);
     ImageSpectrR.Height:= round(ScanParams.NY/DelImg2)-ImageSpectrR.top-3;;
     ImageCurSFM.Width:=round(ScanParams.NX/DelImg2);
     ImageCurSFM.Height:= round(ScanParams.NY/DelImg2);
    end;
  with ScanWnd do
     begin
      with  ImageTopR.Picture.Bitmap do
      begin
       Width:=ScanParams.NX*CELL;              {Подгон размера картинки, на которую выводится результат}
       Height:=ScanParams.NY*CELL;
       Canvas.CopyMode:=cmWhiteness;     {Очистка картины}
       Canvas.CopyRect(Rect(0,0,ScanParams.NX*CELL,ScanParams.NY*CELL),
                                            ImageTopR.Canvas,Rect(0,0,ScanParams.NX*CELL,ScanParams.NY*CELL));
      end;
      with  ImagePhaseR.Picture.Bitmap do
      begin
       Width:=ScanParams.NX*CELL;              {Подгон размера картинки, на которую выводится результат}
       Height:=ScanParams.NY*CELL;
       Canvas.CopyMode:=cmWhiteness;     {Очистка картины}
       Canvas.CopyRect(Rect(0,0,ScanParams.NX*CELL,ScanParams.NY*CELL),
                                            ImagePhaseR.Canvas,Rect(0,0,ScanParams.NX*CELL,ScanParams.NY*CELL));
      end;
      with  ImageUAMR.Picture.Bitmap do
      begin
       Width:=ScanParams.NX*CELL;              {Подгон размера картинки, на которую выводится результат}
       Height:=ScanParams.NY*CELL;
       Canvas.CopyMode:=cmWhiteness;     {Очистка картины}
       Canvas.CopyRect(Rect(0,0,ScanParams.NX*CELL,ScanParams.NY*CELL),
                                            ImageUAMR.Canvas,Rect(0,0,ScanParams.NX*CELL,ScanParams.NY*CELL));
      end;
      with  ImageCurSFM.Picture.Bitmap do
      begin
       Width:=ScanParams.NX*CELL;              {Подгон размера картинки, на которую выводится результат}
       Height:=ScanParams.NY*CELL;
       Canvas.CopyMode:=cmWhiteness;     {Очистка картины}
       Canvas.CopyRect(Rect(0,0,ScanParams.NX*CELL,ScanParams.NY*CELL),
                                            ImageUAMR.Canvas,Rect(0,0,ScanParams.NX*CELL,ScanParams.NY*CELL));
      end;
      with  ImageTopL.Picture.Bitmap do
      begin
       Width:=ScanParams.NX*CELL;              {Подгон размера картинки, на которую выводится результат}
       Height:=ScanParams.NY*CELL;
       Canvas.CopyMode:=cmWhiteness;     {Очистка картины}
       Canvas.CopyRect(Rect(0,0,ScanParams.NX*CELL,ScanParams.NY*CELL),
                                            ImageTopL.Canvas,Rect(0,0,ScanParams.NX*CELL,ScanParams.NY*CELL));
      end;
     end;
     if sqrt(sqr(R.left-R.Right)+sqr(R.top-r.Bottom))>5 then
     begin
     ImageScanArea.Canvas.Pen.Color:=clGreen;
     ImageScanArea.Canvas.Pen.Mode:=pmCopy;
     ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                           Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
    end;
 end;
 ScanParams.ScanRate:= StrToFloat(edScanRate.Text);
 ScanDiscrNumb:=round($8000*ScanParams.X/XMax);
 SetScanRate(StrToFloat(edX.Text),ScanDiscrNumb,StrToInt(edNx.Text));
if (tMicroStepNmb=0) then
   begin
      ShowMessage('You have to increase X or decrease Nx');
      exit;
   end;
 edScanRate.Text:=FloatToStrF(ScanParams.ScanRate,ffFixed,6,0);
 FrameTime.Caption:=FloatToStrF(ScanParams.X*ScanParams.Ny/ScanParams.ScanRate,ffFixed,7,2);

if (StrToFloat(edX.Text)>XMax) then
     begin
           ShowMessage(' X > XMax');
           exit;
     end;

if (StrToFloat(edY.Text)>YMax) then
     begin
           ShowMessage(' Y > YMax');
           exit;
     end;

if (DiscrNuminMicroStep*tMicrostepNmb*StrToInt(edNx.Text)>=$8000) then
        begin
           ShowMessage('DAC_X Overflow');
           exit;
        end;

if (DiscrNuminMicroStep*tMicrostepNmb*StrToInt(edNy.Text)>=$8000) then
        begin
           ShowMessage('DAC_Y Overflow');
           exit;
        end;
with ScanParams do
begin
   Microstep:=1;//DiscrNuminMicroStep;//integer;
   MicrostepDelay:=round(1000*tMicrostepDelay);// mks;
  if MicrostepDelay=0 then MicrostepDelay:=1;
   MicrostepNmb:= NDiscrBetweenPoints;// JMP;
end;
    SetCommonVar(PATH_SPD,ScanParams.MicrostepDelay);    // Delay between microsteps;
    SetCommonVar(JUMP,DiscrNuminMicroStep);   //Delay is done after each Jump microsteps;
    {JMP:= tMicrostepNmb; }
     edX.Font.Color:=clBlack;
     edY.Font.Color:=clBlack;
     edNx.Font.Color:=clBlack;
     edScanRate.Font.Color:=clBlack;
     ApplyBitBtn.Font.Color:=clBlack;
end;

procedure TScanFieldParams.ClearlBtnClick(Sender: TObject);
begin
   with ImageScanArea do
      begin
        Canvas.Brush.Color:=clWindow;
        Canvas.FillRect(Rect(0,0,Width,Height));
        with Canvas.Pen do
         begin
          Style:=psSolid;
          Color:=clBlack;
          Width:=2;
         end;
    Canvas.MoveTo(1,0);
    Canvas.LineTo(1,Height-1);
    Canvas.LineTo(Width,Height-1);
    with Canvas.Pen do
       begin
         Color:=clBlack;
         Mode:=pmCopy;
         Style:=psSolid;
       end;
   end;
end;

procedure TScanFieldParams.ImageScanAreaMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if FlgStopScan then
 begin
         X0:=X;
         Y0:=Y;
         FlgMouseDown:=True;
   if (Button=mbLeft) then
       begin
          MButtonNmb:=1;
          ImageScanArea.Canvas.Pen.Color:=clWhite;
          ImageScanArea.Canvas.Pen.Mode:=pmCopy;
          ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                           Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
          R.TopLeft:=Point(X0,Y0);
          R.BottomRight:=Point(X0,Y0);

       end
      else
       begin
        if ((X>R.Left) and (X<R.Right) and (Y>R.Top) and (Y<R.Bottom))
        then
         begin
          ImageScanArea.Canvas.Pen.Color:=clWhite;
          ImageScanArea.Canvas.Pen.Mode:=pmCopy;
          ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                           Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
          ImageScanArea.Canvas.Pen.Color:=clBlack;
          ImageScanArea.Canvas.Pen.Mode:=pmNOTXOR;
          ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                           Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);

          ImageScanArea.Canvas.Polyline([Point(R.Left,R.Top),Point(R.Left,R.Top),
                           Point(R.Left,R.Top),Point(R.Left,R.Top)]);
          MButtonNmb:=2;
        end;
      end;
   end;
end;

procedure TScanFieldParams.ImageScanAreaMouseMove(Sender: TObject; Shift: TShiftState; X,  Y: Integer);
begin
if FlgMouseDown and FlgStopScan then
 begin
  if (X>ImageScanArea.Width)  then X:= ImageScanArea.Width;
  if (Y>ImageScanArea.Height) then Y:= ImageScanArea.Height;
  if (X<0) then X:=0;
  if (Y<0) then Y:=0;
 if ((abs(x-x0)>5) or (abs(y-y0)>5)) then
   begin
       ImageScanArea.Canvas.Pen.Color:=clBlack;
       ImageScanArea.Canvas.Pen.Mode:=pmNOTXOR;
       ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                           Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
       ImageScanArea.Canvas.Polyline([Point(R.Left,R.Top),Point(R.Left,R.Top),
                           Point(R.Left,R.Top),Point(R.Left,R.Top)]);
    if (MButtonNmb=1) then
     begin
     if (X0<X)
      then begin R.Left:=X0; R.Right:=X; end
           else begin R.Left:=X; R.Right:=X0; end;
     if (Y0<Y)
      then begin R.Top:=Y0; R.Bottom:=Y; end
             else begin R.Top:=Y; R.Bottom:=Y0; end;
      end ;
     if (MButtonnmb=2) then
      begin
       if ((R.Right+(X-X0)<=ImageScanArea.Width) and ((R.Left+(X-x0))>=0) and ((R.Bottom+(y-y0))<=ImageScanArea.Height)
             and ((R.Top+(y-y0))>=0)) then
        begin
         R.Left:=R.Left+(X-X0);
         R.Right:=R.Right+(X-X0);
         R.Bottom:=R.Bottom+(Y-Y0);
         R.Top:=R.Top+(Y-Y0);
         X0:=X;
         y0:=Y;
        end;
      end;
   ImageScanArea.Canvas.Polyline([Point(R.Left,R.Bottom),Point(R.Left,R.Top),
                           Point(R.Right,R.Top),Point(R.Right,R.Bottom),Point(R.Left,R.Bottom)]);
   ImageScanArea.Canvas.Polyline([Point(R.Left,R.Top),Point(R.Left,R.Top),
                          Point(R.Left,R.Top),Point(R.Left,R.Top)]);
    EdX.Text:=FloatToStrF(0,ffFixed,6,0 );    //to do Apply Red
    EdX.Text:=FloatToStrF((R.Right-R.Left)*DelImgX,ffFixed,6,0 );
    EdY.Text:=FloatToStrF((R.Bottom-R.Top)*DelImgY,ffFixed,6,0 );
    if (EdX.Text='0') then EdX.Text:='1';
    if (EdY.Text='0') then EdY.Text:='1';
  end;   //(x-x0)>5
 end;
end;

procedure TScanFieldParams.ImageScanAreaMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var StepXYTmp:single;
          NYTmp:integer;
 begin
    FlgMouseDown:=False;
 if FlgStopScan then
  begin
     with ScanParams do
    if (ScanMode=1) or (ScanMode=2) or (ScanMode=3)then
      begin
       if (NX=0) then NX:=1;
       StepXYTmp:= StrToFloat(EdX.Text)/NX;
       NYTmp:=round(StrToFloat(EdY.Text)/StepXYTmp );
       edNY.Text:=IntToStr(NYTmp);
      end
       else
      begin
        StepXY:= StrToFloat(EdY.Text)/NY;          // Scanning along OY
        NX:=round(StrToFloat(EdX.Text)/StepXY );
        EdNX.Text:=IntToStr(NX);
      end;
   FrameTime.Caption:=FloatToStrF(ScanParams.X*ScanParams.NY/ScanParams.ScanRate,ffFixed,7,2);
  end;
end;
procedure TScanFieldParams.edXChange(Sender: TObject);
begin
 edX.Font.Color:=clRed;
 ApplyBitBtn.Font.Color:=clRed;
end;

procedure TScanFieldParams.edYChange(Sender: TObject);
begin
 edY.Font.Color:=clRed;
 ApplyBitBtn.Font.Color:=clRed;
end;

procedure TScanFieldParams.edNXChange(Sender: TObject);
begin
 edNX.Font.Color:=clRed;
 ApplyBitBtn.Font.Color:=clRed;
end;

procedure TScanFieldParams.edScanRateChange(Sender: TObject);
begin
  edScanRate.Font.Color:=clRed;
  ApplyBitBtn.Font.Color:=clRed;
end;

procedure TScanFieldParams.BitBtnMClick(Sender: TObject);
begin
  if HardWareOpt.XYtune='Fine'
   then
     begin
          BitBtnMg.Caption:='+';
          with  HardWareOpt do
        begin
              XYTune:='Rough';
              AMPGainX:=AMPGainRX;
              AMPGainY:=AMPGainRY;
            with ScanParams do
           begin
              X:=1000;
              Y:=1000;
              XBegin:=10;
              YBegin:=10;
              NX:=100;
              NY:=100;
            end;
        end
     end
  else
     begin
          BitBtnMg.Caption:='-' ;
          with  HardWareOpt do
        begin
            XYTune:='Fine';
            AMPGainX:=AMPGainFX;
            AMPGainY:=AMPGainFY;
            with ScanParams do
               begin
                 X:=1000;
                 Y:=1000;
                 XBegin:=10;
                 YBegin:=10;
                 NX:=100;
                 NY:=100;
               end;
       end;
    end;
       TransformUnitInit ;
      SetCommonVar(XY_TUNE,HardWareOpt.XYTune);
      XMax:=CSPMSignals[8].MaxVal/TransformUnit.Xnm_d;
      YMax:=CSPMSignals[9].MaxVal/TransformUnit.Ynm_d;
      DelImgX:=(XMax/ImageScanArea.Width);
      DelImgY:=(YMax/ImageScanArea.Height);
          with ScanWNd do
    begin
                 with ScanParams do
           begin
            edX.Text:=format('%6.0f',[ScanParams.X]);
            edY.Text:=format('%6.0f',[ScanParams.Y]);
            edNX.Text:=format('%d',[ScanParams.NX]);
            edNY.Text:=format('%d',[ScanParams.NY]);
            R_S.Left:= round(XBegin/DelImgX);
            R_S.Top:= ImageScanArea.Height-round((YBegin+Y)/DelImgY);
            R_S.Right:=round((XBegin+X)/DelImgX);
            R_S.Bottom:=ImageScanArea.Height-round((YBegin)/DelImgY);
           end;
                 with ImageScanArea do
      begin
             Canvas.Brush.Color:=clWindow;
             Canvas.FillRect(Rect(0,0,Width,Height));
               with Canvas.Pen do
              begin
                 Style:=psSolid;
                 Color:=clBlack;
                 Width:=2;
              end;
              Canvas.MoveTo(1,0);
              Canvas.LineTo(1,Height-1);
              Canvas.LineTo(Width,Height-1);
                with Canvas.Pen do
               begin
                Color:=clBlack;
                Mode:=pmCopy;
                Style:=psSolid;
               end;
              Canvas.Polyline([Point(R_S.Left,R_S.Bottom),Point(R_S.Left,R_S.Top),
                            Point(R_S.Right,R_S.Top),Point(R_S.Right,R_S.Bottom),Point(R_S.Left,R_S.Bottom)]);
              R:=R_S;
         end;
     end;
      InvalidateRect(handle,nil,False);
end;

end.
