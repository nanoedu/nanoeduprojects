unit USpectrSFMDraw;

interface
procedure DrawGraphics(i:integer);

implementation

procedure DrawGraphics(i:integer);
var
    k,j,m,Index:integer;
    umstart,um:integer;
begin
  SetLength(U,2*SpectrParams.NGraph{NGraphP}*SpectrParams.NPoints);
  BottAxMin:=PStrtZ;
  BottAxMax:=PEndZ;
  ArChart[i].LeftAxis.Automatic:=True;
 for j:=0 to (NgraphP-1) do ArSeries[i,j].Clear;
   Index:=i;
   PageControl.Pages[Index].HighLighted:=False;
   if not SetIntActOnProgr then  inc(Index);
     PageControl.ActivePageIndex:=Index;
     PageControl.ActivePage.HighLighted:=True;
     GetAmplitudes;
     umstart:=round(U[1]/TransformUnit.Znm_d);
 for j:=0 to (NgraphP-1) do
  begin
    case j of
    0: begin     //red          landing
        m:=0;
      for k:=0 to (SpectrParams.Npoints-1) do
       begin
          ArSeries[i,j].AddXY(round(U[m+1]/TransformUnit.Znm_d),U[m]/ApproachParams.UAMmax);//,'',seriesColor[j]);
         if  not SetIntActOnProgr then

           begin
              ScanData.AquiSpectr.Data[i,m]:=U[m];              //discrets
              ScanData.AquiSpectr.Data[i,m+1]:=U[m+1];
           end;
           inc(m,2);//m:=m+2;
       end;
        Application.ProcessMessages;
      end;
  1: begin      //blue        rising
      m:=2*SpectrParams.Npoints;
      for k:=SpectrParams.Npoints to (2*SpectrParams.Npoints-1) do
       begin
          um:= round(U[m+1]/TransformUnit.Znm_d);
         if um>=umstart then
         begin
           ArSeries[i,j].AddXY(um,U[m]/ApproachParams.UAMmax);//,'',seriesColor[j]);
         end
         else lblwarning.Visible:=true;
         if  not SetIntActOnProgr then

           begin
              ScanData.AquiSpectr.Data[i,m]:=U[m];
              ScanData.AquiSpectr.Data[i,m+1]:=U[m+1];
           end;
             inc(m,2);
        end;
           Application.ProcessMessages;
      end;

    end; //case
  end;
   ActiveIndex:= PageControl.ActivePageIndex;
   if not SetIntActOnProgr then  ActiveIndex:=ActiveIndex-1;
   Finalize(U);
end;




end.
