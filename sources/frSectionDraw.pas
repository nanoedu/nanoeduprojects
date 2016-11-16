//241103
unit frSectionDraw;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, Menus, StdCtrls,GlobalScanDataType,GlobalDCL,
  SpmChart,OpenGL,ClipBrd,frOpenGlDraw, AppEvnts, ComCtrls, siComp, siLngLnk;

type
  TSection = class(TForm)
    MainMenu1: TMainMenu;
    Edit1: TMenuItem;
    CopytoClipBoardMenu: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    PanelDrag: TPanel;
    StatusBar: TStatusBar;
    siLangLinked1: TsiLangLinked;
    procedure CopytoClipBoardMenuClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//    procedure CopytoClipBoardMenuClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;var Handled: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
   { Private declarations }
    ChartPanel: TChartGraphica;
    procedure WMMOve(var Mes:TWMMove); message WM_Move;
    procedure WMNCLButton(var Message: TMessage); message WM_NCLButtonDown;

  public
    { Public declarations }
    ParentSectW:TfrmGL;
    SectionData:TDataLine;
    constructor Create(AOwner:TComponent;Section:TDataLine;n:integer;const Title:string;const FileHeadRcd:HeadParmType);
    procedure   SaveSectionAsASCII(const FileName:string);
  end;
 type
    TPtSect=^SectGL;
     SectGL=record
        Sect:TSection;
        GLList:GLUint;
        end;

var PtSect: TPtSect ;

implementation

uses mMain,GlobalVar,GlobalFunction,CSPMvar,frReport;

{$R *.DFM}

procedure TSection.CopytoClipBoardMenuClick(Sender: TObject);
begin
  Main.CopytoClipBoardExecute(self);
end;

constructor TSection.Create(AOwner:TComponent;Section:TDataLine;n:integer;const Title:string;const  FileHeadRcd:HeadParmType);
var i:integer;
    Ymin:single;
begin
 inherited Create(AOwner);
  siLangLinked1.ActiveLanguage:=Lang;
  Caption:=Title;
  width:=600;
  height:=350;
  ChartPanel:= TChartGraphica.Create(TComponent(Self));
     case  FileHeadRcd.HPathMode of
  OneX,Multi : ChartPanel.ChartScannerIniFile:=ScannerIniFilesPath + ScannerIniFileX;  //X
  OneY,MultiY: ChartPanel.ChartScannerIniFile:=ScannerIniFilesPath + ScannerIniFileY; //Y
              end;
  ChartPanel.Parent:= Self;
  ChartPanel.Align:= alClient;
  MainMenu1.Items.Add(ChartPanel.EditChartMenu);
  Self.OldCreateOrder:= True;
  ChartPanel.Chart.UndoZoom;
  ChartPanel.Chart.Title.Text.Clear;
  ChartPanel.Chart.Title.Text.Add('');
  ChartPanel.AxisYLabel.Caption:=Section.yAxisTitle;
  ChartPanel.AxisXLabel.Caption:=Section.xAxisTitle;
  ChartPanel.Chart.hint:=siLangLinked1.GetTextOrDefault('IDS_2' (* 'Click Left Button to set label; Click Right Button to show popup menu' *) );

  SectionData:=TDataLine.Create(Section.Nx);
    with  SectionData do
      begin
       Nx:=Section.Nx;
       YStep:=Section.YStep;
       ymin:=Section.datalineY[0];;
 //      ymax:=Section.datalineY[0];;
       for i:=0 to Nx-1 do
        begin
    	  dataLineX[i]:=Section.datalineX[i];
        dataLineY[i]:=Section.datalineY[i];
        if Ymin>dataLineY[i] then Ymin:=dataLineY[i];
 //       if Ymax<dataLineY[i] then Ymax:=dataLineY[i];
        end;
       XStep:=Section.XStep;
       xAxisTitle:=Section.xAxisTitle;
       yAxisTitle:=Section.yAxisTitle;
      end;
  if FileHeadRcd.HAquiADD<>0 then Ymin:=0; //not topography
  for i:=0 to SectionData.nx-1 do
  begin
   ChartPanel.Series1.AddXY(i*SectionData.XStep,(SectionData.DataLineY[i]-Ymin)*SectionData.YStep,'',clRed) ;
  end;
    Visible:=true;
    ChartPanel.InitSensitiveX:=FileHeadRcd.HSensX;
    ChartPanel.InitSensitiveY:=FileHeadRcd.HSensY;
    ChartPanel.AllowEditClick(AOwner);
    ChartPanel.SetCursorClick(AOwner);
    ChartPanel.IsChartEdit:=true;
    InvalidateRect(ChartPanel.Handle, nil, False);
end;

procedure TSection.WMMOve(var Mes:TWMMove);
begin
    if Mes.YPos<(Main.ToolBarMain.Height div 2) then Top:=5;//Main.ToolBarMain.Height+10;
end;
procedure TSection.WMNCLButton(var Message: TMessage);
 begin
      case Message.wParam of
HTCAPTION:
          begin
           if AltDown  then        // copy to clipboard    for report
             if  assigned(ReportForm) then
             begin
               PanelDrag.BeginDrag(False);
               Main.CopyToClipBoardExecute(self);
               ReportForm.CaptureSourceImage(PanelDrag);
             end;
           end;
      end;
      inherited;
     Message.Result := 0;
end;

procedure TSection.FormClose(Sender: TObject; var Action: TCloseAction);
var i,Count:integer;
    FrmS:TSection;
    Item:TMenuItem;
begin
 if  assigned(ParentSectW) then
  begin
   Count:=ParentSectW.ArFrmSectLoc.Count;
   for i:=(Count-1) downto 0 do
    begin
     PtSect:=ParentSectW.ArFrmSectLoc.Items[i];
     FrmS:=TSection(PtSect.Sect);
    if FrmS.Caption=self.Caption then
     begin
      glDeleteLists(PtSect^.GLList,1);
      ParentSectW.ArFrmSectLoc.Delete(i);
      dispose(PtSect);
     end;
   end;
    InvalidateRect(ParentSectW.Handle,nil,false);
  end;
    Count:=ArFrmSect.Count;
   for i:=(Count-1) downto 0 do
    begin
     FrmS:=ArFrmSect.Items[i];
     if FrmS.Caption=self.Caption then    ArFrmSect.Delete(i);
    end;
      Item:=Main.mWindows.Find(self.Caption);
      if assigned(Item) then  Item.Free;
  ChartPanel.Destroy;
//  Main.ActionExport.enabled:=false;
  Action:=caFree;
  SectionData.Free;
end;

procedure TSection.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
 // ChartPanel.Action(Round(Key));
  if (ssAlt in Shift) then
     begin
       flgDragForm:=true;
     end
end;


procedure  TSection.SaveSectionAsASCII(const FileName:string);
var Fl:TextFile;
    s:STRING;
    i,j:integer;
    Year, Month, Day, Hour, Minut, Sec, MSec: Word;
    Present: TDateTime;
    presentdate:string;
begin
Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Minut, Sec, MSec);
  presentdate:=intTostr(day)+'.'+inttostr(month)+'.'+inttostr(year);
 try
    AssignFile(Fl, FileName);
    ReWrite(Fl);
    S:='File Format = ASCII';
    Writeln(Fl, S);
    S:= 'Created by NanoEducator LE, NT-SPb, lmt. '+presentdate ;
    Writeln(Fl, S);
    S:='File: '+FileName;
    Writeln(Fl, S);
    Writeln(Fl, 'NX = ',SectionData.NX);
    Writeln(Fl, Format('Scale X = %5.2f',[SectionData.XStep]));
    Writeln(Fl, Format('Scale Data = %5.2f',[SectionData.YStep]));
    Writeln(Fl, 'Bias X = 0,0');
    Writeln(Fl, 'Bias Data = ',0);
    Writeln(Fl, 'Unit X = ', SectionData.xAxisTitle);
    Writeln(Fl, 'Unit Data = ',SectionData.yAxisTitle);
    Writeln(Fl,  'Start of Data : ');

    for i:=0 to SectionData.NX-1 do
        begin
        Write(Fl, SectionData.dataLineY[i],' ');
        end;
    finally
    CloseFile(Fl);
    end;

end;

procedure TSection.ApplicationEventsMessage(var Msg: tagMSG;  var Handled: Boolean);
begin
 if flgDragForm then
  if Msg.message=WM_LButtonDown then
  begin
   if  getkeystate(VK_Menu)<0 then
   begin
     if Assigned(ReportForm) then
             begin
                PanelDrag.BeginDrag(False);
                Main.CopyToClipBoardExecute(self);
                ReportForm.CaptureSourceImage(PanelDrag);
              end;  
       handled:=true;
       flgDragForm:=false;
   end
  end;

end;

procedure TSection.FormKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
 if (ssAlt in Shift) then
     begin
       flgDragForm:=false;
     end
end;

end.
