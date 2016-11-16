unit GlobalType;
interface

//  Const  maxValue=1024 ;
  Const  maxVal=256;       //?????
  Const  ArraySplineLen=1024;
  const  IdentifSpectrTempl = '(C) Spectr Template Data ';

  type AnsiArrayChar=Array[0..16] of AnsiChar;
  type PAnsiCharArray = ^AnsiArrayChar;
  type ArrayInt=Array of integer;
  type PArrayInt = ^ArrayInt;

  type float=single;

  type data_dig=integer;          // digital control type

  type data_out_type=data_dig;    // channel datatype

  type datatype=smallint;     // data type для совместимости со старым контроллером

  type apitype=smallint;

 // type unapitype=word;  //unsign

  type ArraySpline=array[1..ArraySplineLen] of float;

  type ColorsSet=array[1..2] of array [1..100] of single;


  type mcell=array[1..3,1..3] of single;
  type MLPCMemPage = array[1..64] of integer;

  type
    Vector=record
 	x, y, z:single;
  end;

  type
    TSinglePoint=record
 	x, y:single;
  end;

  type   TPOintDouble=record
  x,y:double;
  end;
  type TMas2=array of array of datatype;
  type PTMas2=^TMas2;
  type TMas1=array of integer;
  type Array2D=array of array of Word;
  type TLine=array of datatype;
  type TLWLine=array of longword;
  type TLineSingle=array of single;
 (* type    fifo_desc = record
          PIn,POut,PPath:PWORD;
          in_count,out_count,path_count:LongInt;
         end;
 *)
   type RDemoDataInfo=record
     ScanRegimeIdent:integer;
     DataExists:boolean;
     Nx,Ny:integer;
     XLengthNM, YLengthNM:single;
     fSensX, fSensY, fsensZ: single;      // for Demo 2013
//     fDiscrZmvolt:single;                 // for Demo 2013
     fAmplV_d,
     fBiasV_d,
     fnA_d,
     fZnm_d,
     fXnm_d,
     fYnm_d:single;
   end;
   type TSignalUnits=record
        text:string;
        limit:integer; //limit to auto transform units
        coef:single;//discret to name    1=nm; 1000=mcn
   end;
  type TDemoDataInfoArray= array of RDemoDataInfo;

  type PIDType = double;
  rformparam=record
   top:integer;
   left:integer;
   width,
   height:integer;
  end;
  implementation
end.
