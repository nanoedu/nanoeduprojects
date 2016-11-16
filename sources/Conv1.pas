unit Conv1;

interface
function Conv1(Mas:TLine; S:integer): TLine;
// S size of smoothing , S - odd number (3,5,..)

implementation
function Conv1(Mas:TLine; S:integer): TLine;
 var
 i,r:integer;
 Q, Shift, Buf:integer;
 L:integer;
 Temp:  TLine;
 begin
 //S:=5;
 Shift:=(S-1) div 2;
 L:=Length(Mas);
 SetLength(Temp,L);
// Temp:=Mas;
 for i:=0 to Shift-1 do    // Set boundary elements
      begin                // for convolution;
     Temp[i]:=Mas[i];
     Temp[i+L-Shift]:=Mas[i+L-Shift];
     end ;
 for i:=Shift to L-Shift-1 do
     begin
     Q:=0;
     for r:=0 to S-1 do
     begin
     Buf:=Mas[i+r-Shift];
     Q:=Q+Buf;
     end;
     Q:=Q div S;
     Temp[i]:=Q;
     end;
 conv1:=Temp;
   Temp:=nil;

 end;

end.
 