unit DemoDcl;

interface
const DEMO_VERSION=55;

  type    fifo_desc = record
          PIn,POut,PPath:PWORD;
         in_count,out_count,path_count:LongInt;
         end;

         PFifo=^fifo_desc;

var PathDelay:integer;
    Points_Cnt, Points_Nmb:longint;
    flgDone:boolean;
    CntDec:integer;
implementation

end.

 