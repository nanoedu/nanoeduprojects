unit frAdapterService;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ComCtrls, ExtCtrls, CheckLst, CSPMVar, GlobalVar, mMain,
  siComp, siLngLnk;
const
TaskReadAll=$7F;
type
  TAdapterService = class(TForm)
    Panel1: TPanel;
    PanelTop: TPanel;
    PanelBottom: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PanelControl: TPanel;
    PanelSave: TPanel;
    GroupBox1: TGroupBox;
    Panel4: TPanel;
    GroupBox2: TGroupBox;
    BitBtnOk: TBitBtn;
    BitBtnCancel: TBitBtn;
    PanelApply: TPanel;
    Panel6: TPanel;
    PageControl: TPageControl;
    TabSheetScanner: TTabSheet;
    TabSheetHeader: TTabSheet;
    StringGridHeader: TStringGrid;
    TabSheetParamsX: TTabSheet;
    StringGridParamsX: TStringGrid;
    TabSheetCurveXX: TTabSheet;
    StringGridXX: TStringGrid;
    TabSheetCurveXY: TTabSheet;
    StringGridXY: TStringGrid;
    TabSheetParamsY: TTabSheet;
    StringGridParamsY: TStringGrid;
    TabSheetCurveYX: TTabSheet;
    StringGridYX: TStringGrid;
    TabSheetCurveYY: TTabSheet;
    StringGridYY: TStringGrid;
    BitBtnApply: TBitBtn;
    GroupBox3: TGroupBox;
    BitBtn2: TBitBtn;
    Label5: TLabel;
    ComboBoxScannersList: TComboBox;
    Label1: TLabel;
    GroupBox4: TGroupBox;
    LblAdapterID: TLabel;
    Label3: TLabel;
    LblCurrentScanner: TLabel;
    BitBtnNewScanner: TBitBtn;
    EdScannerName: TEdit;
    Label2: TLabel;
    lblPathDBase: TEdit;
    BitBtnSaveToDBase: TBitBtn;
    GroupBox5: TGroupBox;
    CheckListBoxWrite: TCheckListBox;
    BitBtnWrite: TBitBtn;
    BitBtnCopy: TBitBtn;
    BitBtnClear: TBitBtn;
    BitBtnChooseAllW: TBitBtn;
    BitBtn4: TBitBtn;
    GroupBox6: TGroupBox;
    CheckListBoxRead: TCheckListBox;
    BitBtnReadDef: TBitBtn;
    BitBtnRead: TBitBtn;
    BitBtnClearR: TBitBtn;
    BitBtnChooseAllR: TBitBtn;
    BitBtn5: TBitBtn;
    siLangLinked1: TsiLangLinked;
    ProgressBar: TProgressBar;
    Label6: TLabel;
    lblAdapterVer: TLabel;
    ComboBoxUnit: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnWriteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnNewScannerClick(Sender: TObject);
    procedure EdScannerNameKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnOkClick(Sender: TObject);
    procedure BitBtnReadClick(Sender: TObject);
    procedure CheckListBoxWriteClickCheck(Sender: TObject);
    procedure BitBtnChooseAllWClick(Sender: TObject);
    procedure BitBtnClearClick(Sender: TObject);
    procedure BitBtnChooseAllRClick(Sender: TObject);
    procedure BitBtnClearRClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure StringGridHeaderKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnApplyClick(Sender: TObject);
    procedure ComboBoxScannersListChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtnSaveToDBaseClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtnReadDefClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboBoxUnitSelect(Sender: TObject);
    procedure StringGridParamsXSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure StringGridParamsYSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
  private
    { Private declarations }
     int_size:integer;
     SubdirList:Tstrings;
     taskread:integer;
    function  SetComboBox(item:string):boolean;
    function  EnabledControl(flg:boolean) :boolean;
    function  InitTabSheetHeader:boolean;
    function  InitTabSheetParamsXpl:boolean;
    function  InitTabSheetCurveXX:boolean;
    function  InitTabSheetCurveXY:boolean;
    function  InitTabSheetParamsYpl:boolean;
    function  InitTabSheetCurveYX:boolean;
    function  InitTabSheetCurveYY:boolean;
    function  UpdateStringGrids(TaskRead:integer):boolean;
    function  UpdateTabSheets:boolean;
    function  FillStruture(pstructure:PInteger; val:integer):boolean;
    procedure ThreadDone(var AMessage : TMessage); message WM_ThreadDoneMsg;
    procedure ScanSubDirectories(parentdir:string; var subdirlist:TStrings);
  public
    taskreadcount:integer;
    NewScannerNumber :integer;
    NewScannerFolder: string;
  end;

var
  AdapterService: TAdapterService;



implementation

uses   GlobalFunction,Systemconfig,ThreadReadFromAdapter, ThreadGetDeviceId,ThreadWriteToAdapter, UNanoEduBaseClasses, GlobalDcl,
      UAdapterService, UFileOp,frChangePath, Math, uScannerCorrect;
{$R *.dfm}
Const
  SPagenmb0='Page Number';
  SPageType1='Page Type';
  Ssize='Device';
  SHeader3='ID';
  SHeader4='Protocol';
  SHeader5='Scanner';
  SHeader6='Page 1';
  SHeader7='Page 2';
  SHeader8='Page 3';
  SHeader9='Page 4';
  SHeader10='Page 5';
  SHeader11='Page 6';
//
  sParams3='DZdclnX';
  sParams4='DZdclnY';
  sParams5='NonLinFieldX';
  sParams6='NonLinFieldY';
  sParams7='GridCellSize';
  sParams8='Y Bias Angle';
  sParams9='SensitivZ';
  sParams10='SensitivX';
  sParams11='SensitivY';
  sParams12='IVTranform';
//
   sCurve3='Date';
   sCurve4='Points';
   SCurveX='X';
   SCurveY='Y';
function TAdapterService.FillStruture(pstructure:PInteger; val:integer):boolean;
var size:integer;
begin
   case PintegerArray(pstructure)[1] of
1:  size:=sizeof(RAdapterHeadRecord);
2:  size:=sizeof(RAdapterOptFloatRecord);
3:  size:=sizeof(RAdapterLinPointsRecord64);
   end;
   FillMemory(pstructure,size,val);
end;
procedure TAdapterService.ThreadDone(var AMessage : TMessage);
begin
   if  (mReadingMLPC=AMessage.WParam)then
       begin
         if assigned(ReadFromAdapterThread) then
           begin
              ReadFromAdapterThread:=nil;
              ReadFromAdapterThreadActive := false;
           end;
         if assigned(NanoEdu.Method) then
         begin
           NanoEdu.Method.FreeBuffers;
           FreeAndNil(NanoEdu.Method);
         end;
          UpdateStringGrids(TaskRead);
          EnabledControl(true);
       end;

   if  (mGetDeviceId=AMessage.WParam)then
       begin
         if assigned(GetDevIdThread) then
           begin
             GetDevIdThread:=nil;
             GetDevIdThreadActive := false;
           end;
 //        Application.ProcessMessages;
         NanoEdu.Method.FreeBuffers;
         FreeAndNil(NanoEdu.Method);
       end;

   if  ( mMemWriteDone=AMessage.WParam)then
       begin
         if assigned(WriteToAdapterThread) then
            begin
              WriteToAdapterThread:=nil;
              WriteToAdapterThreadActive := false;
            end;
         Application.ProcessMessages;
         NanoEdu.Method.FreeBuffers;
         FreeAndNil(NanoEdu.Method);
         if flgClearAdapter then
         begin
            flgClearAdapter:=false;
         end;
          EnabledControl(true);
      end;
end;
  function  TAdapterService.UpdateTabSheets:boolean;
  begin
     InitTabSheetHeader;
     LblCurrentScanner.Caption:=HardWareOpt.ScannerNumb;
     if ComboBoxScannersList.Items.Count>0 then SetComboBox(HardWareOpt.ScannerNumb);
     InitTabSheetParamsXpl;
     InitTabSheetCurveXX;
     InitTabSheetCurveXY;
     InitTabSheetParamsYpl;
     InitTabSheetCurveYX;
     InitTabSheetCurveYY;
     result:=true;
  end;
  function TAdapterService.UpdateStringGrids(TaskRead:integer):boolean;
  var i,j,res:Integer;
  const mask=$00000001;
  begin
   for i := 0 to CheckListBoxRead.Items.Count -1 do
   begin
    if CheckListBoxRead.Checked[i] then
    begin
       res:=taskread and mask;
        if res=1 then
          case i of
    0: begin
        InitTabSheetHeader;
        LblCurrentScanner.Caption:=HardWareOpt.ScannerNumb;
        if ComboBoxScannersList.Items.Count>0 then SetComboBox(HardWareOpt.ScannerNumb);
       end;
    1: InitTabSheetParamsXpl;
    2: InitTabSheetCurveXX;
    3: InitTabSheetCurveXY;
    4: InitTabSheetParamsYpl;
    5: InitTabSheetCurveYX;
    6: InitTabSheetCurveYY;
           end;
    end;
      taskread:=taskread shr 1
   end;
  end;
 function TAdapterService.SetComboBox(item:string):boolean;
 var i:integer;
 begin
  for i := 0 to ComboBoxScannersList.items.Count - 1 do
   if ComboBoxScannersList.Items[i]=item then ComboBoxScannersList.itemindex:=i;
 end;
function  TAdapterService.EnabledControl(flg:boolean) :boolean;
begin
 PanelControl.Enabled:=flg;
end;

  function TAdapterService.InitTabSheetHeader:boolean;
  var i:Integer;
  begin
      with StringGridHeader do
      begin
        Cells[0,0]:=SPagenmb0;
        Cells[0,1]:=SPageType1;
        case flgMotor of
           PiezoM: Cells[0,2]:='Piezo Mover '+  Ssize;              //device
            StepM: Cells[0,2]:='Step Mover  '+  Ssize;              //device
        end;

        Cells[0,3]:=SHeader3;
        Cells[0,4]:=SHeader4;
        Cells[0,5]:=SHeader5;
        Cells[0,6]:=SHeader6;
        Cells[0,7]:=SHeader7;
        Cells[0,8]:=SHeader8;
        Cells[0,9]:=SHeader9;
        Cells[0,10]:=SHeader10;
        Cells[0,11]:=SHeader11;
        with pAdapterHead^ do
        begin
         Cells[1,0]:=inttostr(PageNmb);
         Cells[1,1]:=inttostr(PageTypeId);
        ComboBoxUnit.ItemIndex:=aflgUnit;
         Cells[1,2]:=inttostr(aflgUnit);
         Cells[1,3]:=NTSPBId;
         Cells[1,4]:=inttostr(ProtocolVers);
         Cells[1,5]:=ScannerNumber;
         for I := 6 to 11 do
         begin
          Cells[1,i]:=inttostr(pagewritten[i-5]);
         end;
        end;
      end;
 end;
 function TAdapterService.InitTabSheetParamsXpl:boolean;
 begin
       with StringGridParamsX do
      begin
        Cells[0,0]:=SPagenmb0;
        Cells[0,1]:=SPageType1;
        Cells[0,2]:=Ssize;
    //    Cells[0,3]:=SParams3;
    //    Cells[0,4]:=SParams4;
        Cells[0,3]:=SParams5;
        Cells[0,4]:=SParams6;
        Cells[0,5]:=SParams7;
        Cells[0,6]:=SParams8;
        Cells[0,7]:=SParams9;
        Cells[0,8]:=SParams10;
        Cells[0,9]:=SParams11;
        Cells[0,10]:=SParams12;
        with pAdapterOptModX^ do
        begin
         Cells[1,0]:=inttostr(PageNmb);
         Cells[1,1]:=inttostr(PageTypeId);
         Cells[1,2]:=inttostr(DataLengthInt);
     //    Cells[1,3]:=floattostrF(DZdclnX,fffixed,5,2);
     //    Cells[1,4]:=floattostrF(DZdclnY,fffixed,5,2);
         Cells[1,3]:=inttostr(NonLinFieldX);           //integer 
         Cells[1,4]:=inttostr(NonLinFieldY);
         Cells[1,5]:=inttostr(GridCellSize);
         Cells[1,6]:=inttostr(round(180*arctan2(YBiasTan,1)/pi)); // // degrees
         Cells[1,7]:=inttostr(round(SensitivZ));
         Cells[1,8]:=inttostr(round(SensitivX));
         Cells[1,9]:=inttostr(round(SensitivY));
         Cells[1,10]:=inttostr(round(I_VTransfKoef));
        end;
    end;
 end;
function TAdapterService.InitTabSheetParamsYpl:boolean;
begin
        with StringGridParamsY do
      begin
        Cells[0,0]:=SPagenmb0;
        Cells[0,1]:=SPageType1;
        Cells[0,2]:=Ssize;
        Cells[0,3]:=SParams5;
        Cells[0,4]:=SParams6;
        Cells[0,5]:=SParams7;
        Cells[0,6]:=SParams8;
        Cells[0,7]:=SParams9;
        Cells[0,8]:=SParams10;
        Cells[0,9]:=SParams11;
        Cells[0,10]:=SParams12;
        with pAdapterOptModY^ do
        begin
         Cells[1,0]:=inttostr(PageNmb);
         Cells[1,1]:=inttostr(PageTypeId);
         Cells[1,2]:=inttostr(DataLengthInt);
         Cells[1,3]:=inttostr(NonLinFieldX);
         Cells[1,4]:=inttostr(NonLinFieldY);
         Cells[1,5]:=inttostr(GridCellSize);
         Cells[1,6]:=inttostr(round(180*arctan2(YBiasTan,1)/pi)); // // degrees
         Cells[1,7]:=inttostr(round(SensitivZ));
         Cells[1,8]:=inttostr(round(SensitivX));
         Cells[1,9]:=inttostr(round(SensitivY));
         Cells[1,10]:=inttostr(round(I_VTransfKoef));
        end;
    end;
end;
procedure TAdapterService.StringGridHeaderKeyPress(Sender: TObject;
  var Key: Char);
begin
     if not(Key in ['0'..'9',#8,decimalseparator]) then Key :=#0;
end;



procedure TAdapterService.StringGridParamsXSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
    if (ACol = 1) and (ARow =10)then
     begin
      StringGridParamsY.Cells[1,10]:=StringGridParamsX.Cells[1,10];

     end;
     if (ACol = 1) and (ARow =5)then
     begin
          StringGridParamsX.Cells[1,5]:=StringGridParamsY.Cells[1,5];
     end;
end;

procedure TAdapterService.StringGridParamsYSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
     if (ACol = 1) and (ARow =10)then
     begin
      StringGridParamsX.Cells[1,10]:=StringGridParamsY.Cells[1,10];
     end;
     if (ACol = 1) and (ARow =5)then
     begin
          StringGridParamsX.Cells[1,5]:=StringGridParamsY.Cells[1,5];
     end;
end;

function TAdapterService.InitTabSheetCurveXX:boolean;
var i,j:integer;
begin
     with StringGridXX do
      begin
        for i:=0 to RowCount - 1 do
        for j := 0 to ColCount - 1 do
           Cells[j,i]:='';
          
        Cells[0,0]:=SPagenmb0;
        Cells[0,1]:=SPageType1;
        Cells[0,2]:=Ssize;
        Cells[0,3]:=SCurve3;
        Cells[0,4]:=sCurve4;
        for i:=0 to pAdapterLinModXAxisX^.NPoints - 1 do
          Cells[0,5+i]:=sCurveX+inttostr(i);
        with pAdapterLinModXAxisX^ do
        begin
         Cells[1,0]:=inttostr(PageNmb);
         Cells[1,1]:=inttostr(PageTypeId);
         Cells[1,2]:=inttostr(DataLengthInt);
         Cells[1,3]:=LinearizationDate;
         Cells[1,4]:=inttostr(Npoints);
         for i:=0 to pAdapterLinModXAxisX^.NPoints - 1 do
           Cells[1,5+i]:=inttostr(pAdapterLinModXAxisX^.Points[i+1]);
       end;
    end;
end;
function TAdapterService.InitTabSheetCurveXY:boolean;
var I,j:integer;
begin
 //      StringGridXY.RowCount:=5+pAdapterLinModXAxisY^.NPoints;
      with StringGridXY do
      begin
        for i:=0 to RowCount - 1 do
        for j := 0 to ColCount - 1 do
           Cells[j,i]:='';

        Cells[0,0]:=SPagenmb0;
        Cells[0,1]:=SPageType1;
        Cells[0,2]:=Ssize;
        Cells[0,3]:=SCurve3;
        Cells[0,4]:=sCurve4;
        for i:=0 to pAdapterLinModXAxisY^.NPoints - 1 do
          Cells[0,5+i]:=sCurveX+inttostr(i);
       with pAdapterLinModXAxisY^ do
        begin
         Cells[1,0]:=inttostr(PageNmb);
         Cells[1,1]:=inttostr(PageTypeId);
         Cells[1,2]:=inttostr(DataLengthInt);
         Cells[1,3]:=LinearizationDate;
         Cells[1,4]:=inttostr(Npoints);
         for i:=0 to pAdapterLinModXAxisY^.NPoints - 1 do
          Cells[1,5+i]:=inttostr(pAdapterLinModXAxisY^.Points[i+1]);
       end;
    end;
end;
function TAdapterService.InitTabSheetCurveYX:boolean;
var I,j:integer;
begin
 //    StringGridXX.RowCount:=5+pAdapterLinModYAxisX^.NPoints;
     with StringGridYX do
      begin
        for i:=0 to RowCount - 1 do
        for j := 0 to ColCount - 1 do
           Cells[j,i]:='';

        Cells[0,0]:=SPagenmb0;
        Cells[0,1]:=SPageType1;
        Cells[0,2]:=Ssize;
        Cells[0,3]:=SCurve3;
        Cells[0,4]:=sCurve4;
        for i:=0 to pAdapterLinModYAxisX^.NPoints - 1 do
          Cells[0,5+i]:=sCurveX+inttostr(i);
          with pAdapterLinModYAxisX^ do
        begin
         Cells[1,0]:=inttostr(PageNmb);
         Cells[1,1]:=inttostr(PageTypeId);
         Cells[1,2]:=inttostr(DataLengthInt);
         Cells[1,3]:=LinearizationDate;
         Cells[1,4]:=inttostr(Npoints);
        for i:=0 to pAdapterLinModYAxisX^.NPoints - 1 do
          Cells[1,5+i]:=inttostr(pAdapterLinModYAxisX^.Points[i+1]);
       end;
    end;
end;
function TAdapterService.InitTabSheetCurveYY:boolean;
var I,j:integer;
begin
 //    StringGridXX.RowCount:=5+pAdapterLinModYAxisY^.NPoints;
      with StringGridYY do
      begin
        for i:=0 to RowCount - 1 do
        for j := 0 to ColCount - 1 do
           Cells[j,i]:='';

        Cells[0,0]:=SPagenmb0;
        Cells[0,1]:=SPageType1;
        Cells[0,2]:=Ssize;
        Cells[0,3]:=SCurve3;
        Cells[0,4]:=sCurve4;
        for i:=0 to pAdapterLinModXAxisX^.NPoints - 1 do
          Cells[0,5+i]:=sCurveX+inttostr(i);
        with pAdapterLinModYAxisY^ do
        begin
         Cells[1,0]:=inttostr(PageNmb);
         Cells[1,1]:=inttostr(PageTypeId);
         Cells[1,2]:=inttostr(DataLengthInt);
         Cells[1,3]:=LinearizationDate;
         Cells[1,4]:=inttostr(Npoints);
        for i:=0 to pAdapterLinModYAxisY^.NPoints - 1 do
          Cells[1,5+i]:=inttostr(pAdapterLinModYAxisY^.Points[i+1]);
       end;
    end;
end;

procedure TAdapterService.BitBtnOkClick(Sender: TObject);
begin
     ModalResult:=mrOK;
end;

procedure TAdapterService.BitBtnApplyClick(Sender: TObject);
var i:integer;
    YSectionBias:single;      // degrees
begin
PanelControl.Enabled:=false;
 with   StringGridHeader do
 begin
   if PageControl.ActivePage=TabSheetHeader  then
   begin
   CheckListBoxWrite.Checked[0]  :=True;
     with pAdapterHead^ do
        begin
         // aflgUnit:=strtoint(Cells[1,2]);

          aflgUnit:= ComboboxUnit.ItemIndex;
          if (flgMotor = PiezoM) and (aflgUnit = Nano)  then
               begin
                  ShowMessage(' Educator Device doesn''t suit to Piezo Mover; Choose ProBeam or Terra or MicProbe! ');
                  aflgUnit:= ProBeam;
                  ComboboxUnit.ItemIndex:= ProBeam;
               end;
          if (flgMotor = StepM) and ((aflgUnit = ProBeam) or (aflgUnit = TERRA) or (aflgUnit=MicProbe)) then
               begin
                  ShowMessage('  This Device doesn''t suit to Step Mover; Choose Educator! ');
                  aflgUnit:= Nano;
                  ComboboxUnit.ItemIndex:= Nano;
               end;
          flgUnit:=aflgUnit;
          ScannerNumber:=Cells[1,5];
         for I := 6 to 11 do
         begin
          pagewritten[i-5]:=strtoint(Cells[1,i]);
         end;
        end;
   end;
 end;
 with   StringGridParamsX do
 begin
   if PageControl.ActivePage=TabSheetParamsX  then
   begin
   CheckListBoxWrite.Checked[1]  :=True;
   CheckListBoxWrite.Checked[4]  :=True;
   // Всегда
  // со страницей параметров Х записывать страницу параметров Y

   with    PAdapterOptModX^ do
   begin
       NonLinFieldX:=strtoint(Cells[1,3]);
       NonLinFieldY:=strtoint(Cells[1,4]);     //nm
       GridCellSize:=strtoint(Cells[1,5]); //nm
       YSectionBias:= strtofloat(Cells[1,6]);        // degrees
       YBiasTan:=tan(pi*YSectionBias/180);   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=strtofloat(Cells[1,7]);//single;
       SensitivX:=strtofloat(Cells[1,8]);//single;
       SensitivY:=strtofloat(Cells[1,9]);//single;
       I_VTransfKoef:=strtofloat(Cells[1,10]);//single;
   end;
     PAdapterOptModY^.I_VTransfKoef:=strtofloat(Cells[1,10]);
     PAdapterOptModY^.GridCellSize:= strtoint(Cells[1,5]);
   end;
 end;
 with   StringGridParamsY do
 begin
    if PageControl.ActivePage=TabSheetParamsY then
    begin
    CheckListBoxWrite.Checked[4]  :=True;
    CheckListBoxWrite.Checked[1]  :=True;
    // Всегда
  // со страницей параметров Х записывать страницу параметров Y
       
    with    PAdapterOptModY^ do
    begin
       NonLinFieldX:=strtoint(Cells[1,3]);
       NonLinFieldY:=strtoint(Cells[1,4]);     //nm
       GridCellSize:=strtoint(Cells[1,5]); //nm
       YSectionBias:= strtofloat(Cells[1,6]);
       YBiasTan:=tan(pi*YSectionBias/180);   // tang of angle between OY and Y-Section (22.01.03, Olya)
       SensitivZ:=strtofloat(Cells[1,7]);//single;
       SensitivX:=strtofloat(Cells[1,8]);//single;
       SensitivY:=strtofloat(Cells[1,9]);//single;
       I_VTransfKoef:=strtofloat(Cells[1,10]);//single;
   end;
    PAdapterOptModX^.I_VTransfKoef:=strtofloat(Cells[1,10]);
    PAdapterOptModX^.GridCellSize:= strtoint(Cells[1,5]);
    end;
 end;
 with   StringGridXX do
 begin
   if PageControl.ActivePage=TabSheetCurveXX then
   begin
   CheckListBoxWrite.Checked[2]  :=True;
   with    PadapterLinModXAxisX^ do
   begin
       LinearizationDate:=Cells[1,3];
       NPoints:=strtoint(Cells[1,4]);
       for I:= 0 to NPoints - 1 do
       Points[i+1]:=strtoint(Cells[1,5+i]);     // array[1..64] of integer;
   end;
   end;
 end;
 with   StringGridXY do
 begin
   if PageControl.ActivePage=TabSheetCurveXY then
   begin
   CheckListBoxWrite.Checked[3]  :=True;
   with    PadapterLinModXAxisY^ do
   begin
        LinearizationDate:=Cells[1,3];
       NPoints:=strtoint(Cells[1,4]);
       for I:= 0 to NPoints - 1 do
       Points[i+1]:=strtoint(Cells[1,5+i]);     // array[1..64] of integer;
   end;
  end;
 end;
 with   StringGridYX do
 begin
  if PageControl.ActivePage=TabSheetCurveYX then
  begin
  CheckListBoxWrite.Checked[5]  :=True;
   with    PadapterLinModYAxisX^ do
   begin
       LinearizationDate:=Cells[1,3];
       NPoints:=strtoint(Cells[1,4]);
       for I:= 0 to NPoints - 1 do
       Points[i+1]:=strtoint(Cells[1,5+i]);     // array[1..64] of integer;
   end;
  end;
 end;
 with   StringGridYY do
 begin
   if PageControl.ActivePage=TabSheetCurveYY then
   begin
   CheckListBoxWrite.Checked[6]  :=True;
    with    PadapterLinModYAxisY^ do
    begin
       LinearizationDate:=Cells[1,3];
       NPoints:=strtoint(Cells[1,4]);
       for I:= 0 to NPoints - 1 do
       Points[i+1]:=strtoint(Cells[1,5+i]);     // array[1..64] of integer;
   end;
   end;
 end;
 LoadScannerParams(flgAllDataReadFromAdapter); //251212
 LoadLinSplineFromAdapter;     // вставлено 25/04/2013, т.к. изменения кривых не отражались в
                               // окне параметров до того, как не поменяешь моду сканирования
 PanelControl.Enabled:=true;
end;

procedure TAdapterService.BitBtn2Click(Sender: TObject);
var i:integer;
begin
 ChangePath:=TChangePath.Create(application);
 if  ChangePath.ShowModal=mrOK then
 begin
     ScannerIniBasePath:=  ChangePathResult;
     ComboBoxScannersList.Items.Clear;
    SubdirList.Clear;
     ScanSubDirectories(ScannerIniBasePath,SubdirList);
     for I := 0 to SubdirList.Count - 1 do
      ComboBoxScannersList.Items.add(SubdirList[i]);
    if ComboBoxScannersList.Items.Count>0 then ComboBoxScannersList.Itemindex:=0;
       lblPathDBase.Text:=ScannerIniBasePath;
    Application.ProcessMessages;
 end;
end;

procedure TAdapterService.BitBtnSaveToDBaseClick(Sender: TObject);
begin
 PanelControl.Enabled:=false;
 SaveAdapterDataToInifiles;
 PanelControl.Enabled:=true;
end;

procedure TAdapterService.BitBtn4Click(Sender: TObject);
begin
 EnabledControl(false);
      flgClearAdapter:=true;
      NanoEdu.WritetoMLPCMethod;
      NanoEdu.Method.Launch;
end;

procedure TAdapterService.BitBtn5Click(Sender: TObject);
begin
PanelControl.Enabled:=false;
 SetScannerIniPath;
 LoadScannerParams(false);
 LoadLinSplineFromAdapter;     // вставлено 25/04/2013, т.к. изменения кривых не отражались в
                               // окне параметров до того, как не поменяешь моду сканирования

 initAdapterHeaderBufRecord;
  UpdateTabSheets;
PanelControl.Enabled:=true;  
end;

procedure TAdapterService.BitBtnCancelClick(Sender: TObject);
begin
 ModalResult:=mrCancel;
end;

procedure TAdapterService.BitBtnChooseAllRClick(Sender: TObject);
var i:integer;
begin
  for i := 0 to 6 do
    CheckListBoxRead.Checked[i]:=true;
end;

procedure TAdapterService.BitBtnChooseAllWClick(Sender: TObject);
var i:integer;
begin
  for i := 1 to 6 do
    CheckListBoxWrite.Checked[i]:=true;
end;

procedure TAdapterService.BitBtnClearClick(Sender: TObject);
var i:integer;
begin
     for I := 1 to 6 do
     CheckListBoxWrite.Checked[i]:=false;
end;

procedure TAdapterService.BitBtnClearRClick(Sender: TObject);
var i:integer;
begin
  for i := 0 to 6 do
    CheckListBoxRead.Checked[i]:=false;
end;

procedure TAdapterService.BitBtnNewScannerClick(Sender: TObject);
var DefinifilesParh, fname:string;
begin
  DefinifilesParh:= ScannerIniBasePath+'default\';
  NewScannerFolder:=edScannerName.Text;
  if NewScannerFolder<>'' then
  begin
    HardWareOpt.ScannerNumb:= NewScannerFolder;     // string
    SetScannerIniPath;
    if not DirectoryExists(ScannerIniFilesPath) then
    begin
          CreateNewScanner(NewScannerFolder);
          ShowMessage(HardWareOpt.ScannerNumb + ' folder is created. You must make scan and linearization!');
          with StringGridHeader do
            with pAdapterHead^ do
            begin
             Cells[1,5]:=HardWareOpt.ScannerNumb;
             ScannerNumber:=HardWareOpt.ScannerNumb;
            end;
            LblCurrentScanner.Caption:=HardWareOpt.ScannerNumb;
            ComboBoxScannersList.Items.add(HardWareOpt.ScannerNumb);
            if ComboBoxScannersList.Items.Count>0 then  SetComboBox(HardWareOpt.ScannerNumb);
            EdScannerName.Text:='';
            LoadScannerParams(false);
            LoadLinSplineFromAdapter;     // вставлено 25/04/2013, т.к. изменения кривых не отражались в
                               // окне параметров до того, как не поменяешь моду сканирования

            UpdateTabSheets;
            Application.processmessages;
    end
    else
    begin
         ShowMessage('Scanner '+ edScannerName.Text+' folder already exists!');
    end;
  end
  else ShowMessage('Input number of the scanner!');
    // Сделать проверку на наличие файлов в папке
    // и на совпадение имени папки и имени сканера в папке
    // Выдать сообщение
end;

procedure TAdapterService.BitBtnReadClick(Sender: TObject);
var i,count,val:integer;
begin
  EnabledControl(false);
   taskread:=0;  taskreadcount:=0;
   val:=0;
   for i := 0 to CheckListBoxRead.Items.Count -1 do
   begin
    if CheckListBoxRead.Checked[i] then
    begin
      case i of
    0: begin  taskread:=taskread + 1; FillStruture((PInteger(PAdapterHead)),val); inc(taskreadcount);      end;
    1: begin  taskread:=taskread + 2; FillStruture(PInteger(PAdapterOptModX),val); inc(taskreadcount);     end;
    2: begin  taskread:=taskread + 4; FillStruture(PInteger(PadapterLinModXAxisX),val);inc(taskreadcount); end;
    3: begin  taskread:=taskread + 8; FillStruture(PInteger(PadapterLinModXAxisY),val);inc(taskreadcount); end;
    4: begin  taskread:=taskread + 16;FillStruture(PInteger(PAdapterOptModY),val); inc(taskreadcount);     end;
    5: begin  taskread:=taskread + 32;FillStruture(PInteger(PadapterLinModYAxisX),val);inc(taskreadcount); end;
    6: begin  taskread:=taskread + 64;FillStruture(PInteger(PadapterLinModYAxisY),val);inc(taskreadcount); end;
        end;
    end;
   end;
   if taskread=0 then  // message make choose
   else //write records to adapter
   begin
       NanoEdu.ReadFromMLPCMethod(taskread);
       NanoEdu.Method.Launch;
  end;

end;

procedure TAdapterService.BitBtnReadDefClick(Sender: TObject);
begin
 EnabledControl(false);
end;

procedure TAdapterService.BitBtnWriteClick(Sender: TObject);
var
   val,I,size,count : integer;
   POptRec:PAdapterOptFloatRecord;//PScannerOptRecord64;
   startPage:integer;
   pDataWriteRecord:PInteger;
procedure PrepareData(DataBuf:Pinteger; PDataWrite:Pinteger;size:integer);
var i:integer;
begin
     MoveMemory(DataBuf,PDataWrite,size*4);
(*  for i := 0 to 63 do
  PIntegerArray(DataBuf)[i]:=ByteInversion(PIntegerArray(DataBuf)[i]);
  *)
end;
begin

  EnabledControl(false);
  count:=0;  val:=0;
   //clear recordslist
 if DataWriteToAdapterList.Count>0 then  DataWriteToAdapterList.Clear;
      //write header!! don't move
   (*    GetMem(pDataWriteRecord,sizeof(integer)*64);
       FillMemory(pDataWriteRecord,sizeof(integer)*64,val);
       size:= sizeof(RAdapterHeadRecord) div sizeof(integer);
       Preparedata(pDataWriteRecord,PInteger(PAdapterHead),size);
       DataWriteToAdapterList.Add(pDataWriteRecord);
       inc(count);
       *)
   for I := 0 to CheckListBoxWrite.Items.Count -1 do
   begin
    if CheckListBoxWrite.Checked[i] then
    begin
     case i of
   1: begin   //param x
       GetMem(pDataWriteRecord,sizeof(integer)*64);
       FillMemory(pDataWriteRecord,sizeof(integer)*64,val);
       size:= sizeof(RAdapterOptFloatRecord) div sizeof(integer);
       Preparedata(pDataWriteRecord,Pinteger(PAdapterOptModX),size);
       PAdapterHead^.pagewritten[1]:=1;
       DataWriteToAdapterList.Add(pDataWriteRecord);
         inc(count);
     end;
  2: begin   //xx
       GetMem(pDataWriteRecord,sizeof(integer)*64);
       FillMemory(pDataWriteRecord,sizeof(integer)*64,val);
       size:= sizeof(RAdapterLinPointsRecord64) div sizeof(integer);    //
    //   PadapterLinModXAxisX^.LinearizationDate:=GetCurrentData;
       Preparedata(pDataWriteRecord,Pinteger(PadapterLinModXAxisX),size);
       PAdapterHead^.pagewritten[2]:=1;
       DataWriteToAdapterList.Add(pDataWriteRecord);
         inc(count);
     end;
  3: begin    //xy
       GetMem(pDataWriteRecord,sizeof(integer)*64);
       FillMemory(pDataWriteRecord,sizeof(integer)*64,val);
       size:= sizeof(RAdapterLinPointsRecord64) div sizeof(integer);
  //     PadapterLinModXAxisY^.LinearizationDate:=GetCurrentData;
       Preparedata(pDataWriteRecord,Pinteger(PadapterLinModXAxisY),size);
       PAdapterHead^.pagewritten[3]:=1;
       DataWriteToAdapterList.Add(pDataWriteRecord);
         inc(count);
     end;
  4: begin   //params y
       GetMem(pDataWriteRecord,sizeof(integer)*64);
       FillMemory(pDataWriteRecord,sizeof(integer)*64,val);
       size:= sizeof(RAdapterOptFloatRecord) div sizeof(integer);
       Preparedata(pDataWriteRecord,Pinteger(PAdapterOptModY),size);
       PAdapterHead^.pagewritten[4]:=1;
       DataWriteToAdapterList.Add(pDataWriteRecord);
         inc(count);
     end;
  5: begin   //yx
       GetMem(pDataWriteRecord,sizeof(integer)*64);
       FillMemory(pDataWriteRecord,sizeof(integer)*64,val);
       size:= sizeof(RAdapterLinPointsRecord64) div sizeof(integer);
 //     PadapterLinModYAxisX^.LinearizationDate:=GetCurrentData;
       Preparedata(pDataWriteRecord,Pinteger(PadapterLinModYAxisX),size);
       PAdapterHead^.pagewritten[5]:=1;
       DataWriteToAdapterList.Add(pDataWriteRecord);
         inc(count);
     end;
  6: begin    //yy
       GetMem(pDataWriteRecord,sizeof(integer)*64);
       FillMemory(pDataWriteRecord,sizeof(integer)*64,0);
       size:= sizeof(RAdapterLinPointsRecord64) div sizeof(integer);
   //    PadapterLinModYAxisY^.LinearizationDate:=GetCurrentData;
       Preparedata(pDataWriteRecord,Pinteger(PadapterLinModYAxisY),size);
       PAdapterHead^.pagewritten[6]:=1;
       DataWriteToAdapterList.Add(pDataWriteRecord);
         inc(count);
     end;
           end;        //case
    end;                     //checked
   end;   //i
      //write header!! don't move
       GetMem(pDataWriteRecord,sizeof(integer)*64);
       FillMemory(pDataWriteRecord,sizeof(integer)*64,val);
       size:= sizeof(RAdapterHeadRecord) div sizeof(integer);
       Preparedata(pDataWriteRecord,PInteger(PAdapterHead),size);
       DataWriteToAdapterList.Add(pDataWriteRecord);
       inc(count);

   if count=0 then  // message make choose
   else //write records to adapter
   begin
       NanoEdu.WritetoMLPCMethod;
       NanoEdu.Method.Launch;
  end;
end;

procedure TAdapterService.CheckListBoxWriteClickCheck(Sender: TObject);
begin
 CheckListBoxWrite.Checked[0]:=true;
end;

procedure TAdapterService.ComboBoxScannersListChange(Sender: TObject);
begin
  LblCurrentScanner.Caption:=ComboBoxScannersList.Items[ComboBoxScannersList.Itemindex];
  HardWareOpt.ScannerNumb:=LblCurrentScanner.Caption;
  ScannerIniFilesPath:=  ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
  ScannerDefIniFilesPath:=ScannerIniBasePath+HardWareOpt.ScannerNumb+'\';
  LoadScannerParams(false);
  LoadLinSplineFromAdapter;     // вставлено 25/04/2013, т.к. изменения кривых не отражались в
                               // окне параметров до того, как не поменяешь моду сканирования
  pAdapterHead^.ScannerNumber:=HardWareOpt.ScannerNumb;
  InitTabSheetHeader;
  InitTabSheetParamsXpl;
  InitTabSheetParamsYpl;
  InitTabSheetCurveXX;
  InitTabSheetCurveXY;
  InitTabSheetCurveYX;
  InitTabSheetCurveYY;
  LblCurrentScanner.Caption:=HardWareOpt.ScannerNumb;
  Application.Processmessages;
end;

procedure TAdapterService.ComboBoxUnitSelect(Sender: TObject);
begin
   with pAdapterHead^ do
        begin
          aflgUnit:=ComboBOxUnit.ItemIndex;
        end;
end;

procedure TAdapterService.EdScannerNameKeyPress(Sender: TObject; var Key: Char);
begin
    if not ( Key in ['0'..'9',#8,'A'..'Z','a'..'z']) then Key :=#0;
end;

procedure TAdapterService.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//   if Assigned(DataWriteList) then FreeandNil(DataWriteList);
if assigned(SubdirList) then
begin
  SubdirList.Clear;
  FreeAndNil(SubdirList);
end;
    Action := caFree;
    AdapterService:=nil;
end;

procedure TAdapterService.FormCreate(Sender: TObject);
var i:integer;
    s:string;
begin
     SubdirList:=TStringList.Create;
     siLangLinked1.ActiveLanguage:=Lang;
     int_size:=sizeof(integer);
     lblAdapterID.Caption:=inttostr(AdapterID);
   //  StringGridHeader.Objects[1,2]:=ComboBoxUnit;
     s:='';
     if AdapterVer_hi <10  then s:='0' ;
     lblAdapterVer.Caption:=inttostr(AdapterVer_lo)+'.'+s+ inttostr(AdapterVer_hi) ;
 (*    case AdapterID of
 AdNotConnectedId:lblAdapterID.Caption:='Not connection'; // exit messages
         AdNanoId:lblAdapterID.Caption:='NanoeducatorLE';
         AdReniId:lblAdapterID.Caption:='NanoeducatorLE + ReniShaw';
           AdPMId:lblAdapterID.Caption:='NanoeducatorLE + Piezomover';
         AdDemoID:lblAdapterID.Caption:='Demo NanoeducatorLE';
     end;
     *)
     case AdapterID of
 AdNotConnectedId:lblAdapterID.Caption:='Not connection'; // exit messages
         AdNanoId:lblAdapterID.Caption:='NanoTutor';
         AdReniId:lblAdapterID.Caption:='NanoTutor + ReniShaw';
           AdPMId:lblAdapterID.Caption:='NanoTutor + Piezomover';
         AdDemoID:lblAdapterID.Caption:='Simulator NanoTutor';
     end;
     PageControl.ActivePage:=TabSheetScanner;
     CheckListBoxWrite.Checked[0]:=true;   CheckListBoxRead.Checked[0]:=true;
     lblPathDBase.Text:=ScannerIniBasePath;
     ScanSubDirectories(ScannerIniBasePath,SubdirList);
     for I := 0 to SubdirList.Count - 1 do
      ComboBoxScannersList.Items.add(SubdirList[i]);
     UpdateTabSheets;
     for I := 0 to PageControl.PageCount - 1 do
            PageControl.Pages[i].Enabled:= PanelApply.Enabled;

    ComboBoxUnit.top:={TabSheetHeader.Top+}5+StringGridHeader.top+StringGridHeader.CellRect(1,2).top;
    ComboBoxUnit.left:=TabSheetHeader.Left+StringGridHeader.left+StringGridHeader.CellRect(1,2).left;
    ComboBoxUnit.Width:=StringGridHeader.CellRect(1,2).right-StringGridHeader.CellRect(1,2).left;
    ComboBoxUnit.height:=StringGridHeader.CellRect(1,2).bottom-StringGridHeader.CellRect(1,2).top;
    StringGridHeader.Objects[1, 2]:=ComboBoxUnit;
    ComboBoxUnit.Visible:=true;
    ComboBoxUnit.Enabled:=true;
end;

procedure TAdapterService.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var i:integer;
begin
   if (ssCtrl in Shift) then
   begin
   if (Key=ord('E')) or (Key=ord('e'))  then
      begin
       if FlgCurrentUserLevel<>demo then
        begin
         PanelControl.Enabled:= not  PanelControl.Enabled;
         PanelApply.Enabled:=not PanelApply.Enabled;
         for I := 0 to PageControl.PageCount - 1 do
            PageControl.Pages[i].Enabled:= PanelApply.Enabled;

        end;
      end;
    end;
end;

procedure     TAdapterService.ScanSubDirectories(parentdir:string; var subdirlist:TStrings);
var ires:integer;
    sSr:TsearchRec;
begin
   if assigned(subdirlist) then subdirlist.clear
                           else subdirlist:=TstringLIst.Create;
  if DirectoryExists(ParentDir) then
  begin
   ires:=FindFirst(ParentDir+'*.*',faDirectory,sSR);
     while ires = 0 do
        begin
        if  (sSR.Name <> '.') and  (sSR.Name <> '..') then subdirList.add(sSR.Name);
          ires:=FindNext(sSR);
        end;
    FindClose(sSR);
  end;
end;

end.
