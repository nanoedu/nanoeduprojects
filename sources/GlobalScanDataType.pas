unit GlobalScanDataType;

interface

uses globaltype;

  type TData=class(Tobject)
       private
       	function max :datatype;
      	function min :datatype;
      	function mean :single;
      public
        flg:byte;        //type data Topo,Phase or ...
        caption:string;
        captionX:Ansistring; //axies unit
        captionY:Ansistring; //axies unit
        captionZ:Ansistring; //axies unit
      	Nx,Ny: integer;
        XStep,YStep,ZStep:single;
        data:Tmas2;
        constructor Create;
        destructor Destroy; override;
        property DataMin:datatype read min;
        property DataMax:datatype read max;
        property DataMean:single  read mean;
    end;{class}

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

 type TDataLine=class(TObject)
       private
       protected
       public
       	dataLineX: Tlinesingle;
        dataLineY: Tlinesingle;
        XStep,YStep:single;
      	Nx: integer;
        xAxisTitle:string;
        yAxisTitle:string;
	constructor Create(NX:integer);
	destructor Destroy; override;
     end;



implementation
//TData
constructor TData.Create;
begin
  inherited;
//  flg:=Topography;
//  CaptionZ:='';
//  NX:=0;
//  NY:=0;
//  XStep:=0;
//  YStep:=0;
//  SetLength(data,NY,NX);
end; {TData.Create}

destructor TData.Destroy;
begin
     NX:=0;
     NY:=0;
     XStep:=0;
     YStep:=0;
     Finalize(data);
  //   data:=nil;
     inherited;
end; {TData.Destroy}

function TData.max : datatype;
var i , j : integer;
    a : datatype;
begin
     if (NX > 0) and (NY > 0) then
     begin
          a:=data[0,0];
          for j:=0 to NY-1 do
          begin
  	       for i:=0 to NX-1 do
               begin
                    if data[i,j] > a then a:= data[i,j];
               end;
          end;
     end
     else a:=0;
     max:=a;
end; {TData.max}

function TData.min: datatype;
var  i, j : integer;
     a : datatype;
begin
     if (NX > 0) and (NY > 0) then
     begin
          a:=data[0,0];
         for j:=1 to NY-2 do
          begin
             for i:=1 to NX-2 do
               begin
                    if data[i,j] < a then a:=data[i,j];
               end;
          end;
     end
     else a:=0;
     min:=a;
end; {TData.min}

function TData.mean : single;
var i , j : integer;
    S : single;
begin
     S:=0.0;
     if (NX > 0) and (NY > 0) then
     begin
         for j:=1 to NY-2 do
          begin
             for i:=1 to NX-2 do
               begin
                    S:=S+data[i,j];
               end;
          end;
          S:=S/NX/NY;
     end;
     mean:=S;
end; {TData.mean}

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

constructor TDataLine.Create(Nx:integer);
begin
  XStep:=0;
  YStep:=0;
  SetLength(dataLineX,Nx);
  SetLength(dataLineY,Nx);
end;

destructor TDataLine.Destroy;
begin
     Nx:=0;
     XStep:=0;
     YStep:=0;
     Finalize(dataLineY);
     Finalize(datalineX);
     inherited;
 end;
end.
