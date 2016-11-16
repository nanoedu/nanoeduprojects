unit UImageAnalysisType;

interface
      {class}
 type DataFloat=double;
 type PMas2=array of array of DataFloat;

 type
     Tcom=record   // Complex value ;
	   re: DataFloat;
	   im: DataFloat;
     end;

   // type TLine=array of single;
  //  type TLineInt=array of datatype;


 type
     MasCom=array of Tcom;   // Array of complex values;


        type
    PMas1=array of single;
   type
    PMasInt=array of integer;

   type PMas2Sing=array of array of single;




 type TDataFloatCount=class(TObject)
     private
     protected
     public
	data: PMas2;
	NX,NY: integer;
	//min,max: double;
	function max :DataFloat;
	function min : DataFloat;
	function mean :DataFloat;
	constructor Create;
	destructor Destroy; override;
	published
 end; {class}
implementation
function TDataFloatCount.max : double;
var i , j : integer;
    a : double;
begin
     if (NX > 0) and (NY > 0) then
     begin
          a:=data[0,0];
          for i:=0 to NY-1 do
          begin
  	       for j:=0 to NX-1 do
               begin
                    if data[j,i] > a then a:= data[j,i];
               end;
          end;
     end
     else a:=0.0;
     max:=a;
end; {TData.max}

function TDataFloatCount.min: double;
var  i, j : integer;
     a : double;
begin
     if (NX > 0) and (NY > 0) then
     begin
          a:=data[0,0];
          for i:=0 to NY-1 do
          begin
               for j:=0 to NX-1 do
               begin
                    if data[j,i] < a then a:=data[j,i];
               end;
          end;
     end
     else a:=0.0;
     min:=a;
end; {TData.min}

function TDataFloatCount.Mean : double;
var i , j : integer;
    S : double;
begin
     S:=0.0;
     if (NX > 0) and (NY > 0) then
     begin
          for i:=0 to NY-1 do
          begin
               for j:=0 to NX-1 do
               begin
                    S:=S+data[j,i];
               end;
          end;
          S:=S/NX/NY;
     end;
     mean:=S;
end; {TData.mean}

constructor TDataFloatCount.Create;
begin
  inherited;
  NX:=0;
  NY:=0;
  SetLength(data,NY,NX);
end; {TData.Create}

destructor TDataFloatCount.Destroy;
begin
     NX:=0;
     NY:=0;
     Finalize(data);
     inherited;
end; {TData.Destroy}

end.
