//080207
unit frInstruments;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ShellApi,
  ComCtrls, ToolWin, ExtCtrls, Buttons, ImgList, Menus, StdCtrls,Registry, ActnList;
  
const   WM_UserCloseVideo = WM_User + 30;

type
  TInstruments = class(TForm)
    ImageBck: TImage;
    PanelUp: TPanel;
    ToolBar1: TToolBar;
    ResonanceBtn: TToolButton;
    PreScanBtn: TToolButton;
    ScanBtn: TToolButton;
    ImageList1: TImageList;
    PanelSTMSFM: TPanel;
    PanelBottom: TPanel;
    ToolBar2: TToolBar;
    ToolBtnVideo: TToolButton;
    ToolBtnTest: TToolButton;
    Panel4: TPanel;
    ToolBtnHelp: TSpeedButton;
    SpdBtnClose: TSpeedButton;
    ImageList2: TImageList;
    AdjustPopUpMenu: TPopupMenu;
    ImageList5: TImageList;
    LabelSFM: TLabel;
    ToolBtnOpt: TToolButton;
    ToolBtnOsc: TToolButton;
    SlowLanding: TMenuItem;
    FastLanding: TMenuItem;
    ComboBoxSFMSTM: TComboBox;
    ActionListChooseUnit: TActionList;
    SFM: TAction;
    STM: TAction;
    Etching: TAction;
    ActionListLanding: TActionList;
    LandingSlow: TAction;
    LandingFast: TAction;
    ActListControlPanelTools: TActionList;
    Resonance: TAction;
    Landing: TAction;
    Scanning: TAction;
    Training: TAction;
    Video: TAction;
    RunOscilloscope: TAction;
    ShowOptions: TAction;
    ShowHelp: TAction;
    CloseWnd: TAction;
    AtomicScaleChoose: TAction;
    TimerHung: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure HintHandler(Sender: TObject);
    procedure SpdBtnCloseClick(Sender: TObject);
    procedure FastLandingDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure FastLandingMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure SlowLandingDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure SlowLandingMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure ToolBtnHelpClick(Sender: TObject);
    procedure AdjustBtnMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure LandingExecute(Sender: TObject);
    procedure ResonanceExecute(Sender: TObject);
    procedure ScanningExecute(Sender: TObject);
    procedure TrainingExecute(Sender: TObject);
    procedure VideoExecute(Sender: TObject);
    procedure RunOscilloscopeExecute(Sender: TObject);
    procedure ShowOptionExecute(Sender: TObject);
    procedure LandingSlowExecute(Sender: TObject);
    procedure LandingFastExecute(Sender: TObject);
    procedure SFMExecute(Sender: TObject);
    procedure STMExecute(Sender: TObject);
    procedure EtchingExecute(Sender: TObject);
    procedure ComboBoxSFMSTMSelect(Sender: TObject);
    procedure CloseWndExecute(sender:TObject);
    procedure ShowHelpExecute(sender:TObject);
    procedure AtomScaleChooseExecute(sender:TObject);
    procedure TimerHungTimer(Sender: TObject);
  private
    { Private declarations }
     addCaption:string;
     procedure WMMove(var Mes:TWMMove); message WM_Move;
     procedure WMNCHitTest(var M: TWMNCHitTest); message wm_NCHitTest;
     procedure TurnOff;
     function ExecAndWaitEtch(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
     function ExecAndWait(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
     function ExecAndWaitOsc(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
  protected
     procedure CreateParams(var Params:TCreateParams); override;
  public
    { Public declarations }
    hVideo:HWND;
   procedure UserMessage (var Msg: TMessage); message wm_userclosevideo;
   procedure RestoreState;
end;

var
   Instruments: TInstruments;
implementation

uses GlobalVar,CSPMVar,CSPMHelp,GlobalFunction,UNanoEduBaseClasses,UNanoEduClasses,UNanoEduDemoClasses,
     SioCSPM,SystemConfig,mHardWareOpt,
     mMain, frResonance,fApproach,fExperimParams,fScanSFM,frFastland,frChangeDir,frScannerTraining,
     uScannerCorrect,Video,UFindProcess, FrInform;

{$R *.DFM}
var  FormWidth, FormHeight: integer;

procedure FindWidthHeight(Const Points : array of TPoint; Const Len: integer);
var
  i: integer;
begin
  for i:= 0 to Len do
  begin
    if (FormWidth<Points[i].x)  then     FormWidth:= Points[i].x;
    if (FormHeight<Points[i].y) then     FormHeight:= Points[i].y;
  end;
end;//function FindWidthHeight


function CreateOddWindow(AHandle:THandle; ShowTitleBar:boolean):Tpoint;
//-----------------------------------------------------------------------------//
//   Automatic created procedure by Gabe's Odd Form Assistant                  //
//                                                                             //
//   Add this unit to the uses clause of the form you would like to transform. //
//   Call this procedure from the form's OnCreate event like this:             //
//                                                                             //
//   procedure TMyForm.FormCreate(Sender: TObject);                            //
//   begin                                                                     //
//     CreateOddWindow(Handle, False);                                         //
//   end;                                                                      //
//                                                                             //
//   Parameters:                                                               //
//     AHandle:  The Handle of the form you want to transform to this shape.   //
//     ShowTitleBar: Decide whether the titlebar of the form is visible or not.//
//                                                                             //
//   Obs! The client area of the form should be of the same width as the       //
//   image you used to generate the source.                                    //
//                                                                             //
//   Informatics 1998-2000, http://www.informatics.no                          //
//   Made by Gabe: gabrielsen@informatics.no                                   //
//-----------------------------------------------------------------------------//
var
  R1, R2 : hRgn;
  dx : integer;
  dy : integer;
  Points : array [0..266] of TPoint;
begin
  dx := GetSystemMetrics(SM_CXFRAME);
  dy := GetSystemMetrics(SM_CYCAPTION)+GetSystemMetrics(SM_CYFRAME);
  if ShowTitleBar then   R1 := CreateRectRgn(0, 0, 463 + dx*2 , dy )  //Obs! The client area of the form should be of the same width as the image you used to generate the source
                  else   R1 := CreateRectRgn(0,0,0,0);
  Points[0]:=Point(1 + dx,73 + dy);
  Points[1]:=Point(1 + dx,66 + dy);
  Points[2]:=Point(2 + dx,65 + dy);
  Points[3]:=Point(2 + dx,61 + dy);
  Points[4]:=Point(3 + dx,60 + dy);
  Points[5]:=Point(3 + dx,57 + dy);
  Points[6]:=Point(4 + dx,56 + dy);
  Points[7]:=Point(4 + dx,54 + dy);
  Points[8]:=Point(5 + dx,53 + dy);
  Points[9]:=Point(5 + dx,51 + dy);
  Points[10]:=Point(6 + dx,50 + dy);
  Points[11]:=Point(6 + dx,49 + dy);
  Points[12]:=Point(7 + dx,48 + dy);
  Points[13]:=Point(7 + dx,47 + dy);
  Points[14]:=Point(8 + dx,46 + dy);
  Points[15]:=Point(8 + dx,45 + dy);
  Points[16]:=Point(9 + dx,44 + dy);
  Points[17]:=Point(9 + dx,43 + dy);
  Points[18]:=Point(10 + dx,42 + dy);
  Points[19]:=Point(10 + dx,41 + dy);
  Points[20]:=Point(11 + dx,40 + dy);
  Points[21]:=Point(11 + dx,39 + dy);
  Points[22]:=Point(13 + dx,37 + dy);
  Points[23]:=Point(13 + dx,36 + dy);
  Points[24]:=Point(15 + dx,34 + dy);
  Points[25]:=Point(15 + dx,33 + dy);
  Points[26]:=Point(18 + dx,30 + dy);
  Points[27]:=Point(18 + dx,29 + dy);
  Points[28]:=Point(28 + dx,19 + dy);
  Points[29]:=Point(30 + dx,19 + dy);
  Points[30]:=Point(30 + dx,18 + dy);
  Points[31]:=Point(32 + dx,16 + dy);
  Points[32]:=Point(34 + dx,16 + dy);
  Points[33]:=Point(34 + dx,15 + dy);
  Points[34]:=Point(35 + dx,14 + dy);
  Points[35]:=Point(37 + dx,14 + dy);
  Points[36]:=Point(37 + dx,13 + dy);
  Points[37]:=Point(39 + dx,11 + dy);
  Points[38]:=Point(41 + dx,11 + dy);
  Points[39]:=Point(41 + dx,10 + dy);
  Points[40]:=Point(43 + dx,10 + dy);
  Points[41]:=Point(43 + dx,9 + dy);
  Points[42]:=Point(45 + dx,9 + dy);
  Points[43]:=Point(45 + dx,8 + dy);
  Points[44]:=Point(47 + dx,8 + dy);
  Points[45]:=Point(47 + dx,7 + dy);
  Points[46]:=Point(49 + dx,7 + dy);
  Points[47]:=Point(49 + dx,6 + dy);
  Points[48]:=Point(51 + dx,6 + dy);
  Points[49]:=Point(52 + dx,6 + dy);
  Points[50]:=Point(52 + dx,5 + dy);
  Points[51]:=Point(54 + dx,5 + dy);
  Points[52]:=Point(54 + dx,4 + dy);
  Points[53]:=Point(56 + dx,4 + dy);
  Points[54]:=Point(58 + dx,4 + dy);
  Points[55]:=Point(58 + dx,3 + dy);
  Points[56]:=Point(60 + dx,3 + dy);
  Points[57]:=Point(61 + dx,3 + dy);
  Points[58]:=Point(61 + dx,2 + dy);
  Points[59]:=Point(63 + dx,2 + dy);
  Points[60]:=Point(66 + dx,2 + dy);
  Points[61]:=Point(66 + dx,1 + dy);
  Points[62]:=Point(68 + dx,1 + dy);
  Points[63]:=Point(73 + dx,1 + dy);
  Points[64]:=Point(73 + dx,0 + dy);
  Points[65]:=Point(75 + dx,0 + dy);
  Points[66]:=Point(390 + dx,0 + dy);
  Points[67]:=Point(391 + dx,1 + dy);
  Points[68]:=Point(397 + dx,1 + dy);
  Points[69]:=Point(398 + dx,2 + dy);
  Points[70]:=Point(402 + dx,2 + dy);
  Points[71]:=Point(403 + dx,3 + dy);
  Points[72]:=Point(405 + dx,3 + dy);
  Points[73]:=Point(406 + dx,4 + dy);
  Points[74]:=Point(409 + dx,4 + dy);
  Points[75]:=Point(410 + dx,5 + dy);
  Points[76]:=Point(411 + dx,5 + dy);
  Points[77]:=Point(412 + dx,6 + dy);
  Points[78]:=Point(414 + dx,6 + dy);
  Points[79]:=Point(415 + dx,7 + dy);
  Points[80]:=Point(416 + dx,7 + dy);
  Points[81]:=Point(417 + dx,8 + dy);
  Points[82]:=Point(418 + dx,8 + dy);
  Points[83]:=Point(419 + dx,9 + dy);
  Points[84]:=Point(420 + dx,9 + dy);
  Points[85]:=Point(421 + dx,10 + dy);
  Points[86]:=Point(422 + dx,10 + dy);
  Points[87]:=Point(423 + dx,11 + dy);
  Points[88]:=Point(424 + dx,11 + dy);
  Points[89]:=Point(426 + dx,13 + dy);
  Points[90]:=Point(427 + dx,13 + dy);
  Points[91]:=Point(429 + dx,15 + dy);
  Points[92]:=Point(430 + dx,15 + dy);
  Points[93]:=Point(433 + dx,18 + dy);
  Points[94]:=Point(434 + dx,18 + dy);
  Points[95]:=Point(442 + dx,26 + dy);
  Points[96]:=Point(442 + dx,27 + dy);
  Points[97]:=Point(443 + dx,28 + dy);
  Points[98]:=Point(444 + dx,28 + dy);
  Points[99]:=Point(444 + dx,29 + dy);
  Points[100]:=Point(448 + dx,33 + dy);
  Points[101]:=Point(448 + dx,34 + dy);
  Points[102]:=Point(449 + dx,35 + dy);
  Points[103]:=Point(449 + dx,36 + dy);
  Points[104]:=Point(452 + dx,39 + dy);
  Points[105]:=Point(452 + dx,40 + dy);
  Points[106]:=Point(453 + dx,41 + dy);
  Points[107]:=Point(453 + dx,42 + dy);
  Points[108]:=Point(454 + dx,43 + dy);
  Points[109]:=Point(454 + dx,44 + dy);
  Points[110]:=Point(455 + dx,45 + dy);
  Points[111]:=Point(455 + dx,46 + dy);
  Points[112]:=Point(456 + dx,47 + dy);
  Points[113]:=Point(456 + dx,48 + dy);
  Points[114]:=Point(457 + dx,49 + dy);
  Points[115]:=Point(457 + dx,51 + dy);
  Points[116]:=Point(458 + dx,52 + dy);
  Points[117]:=Point(458 + dx,54 + dy);
  Points[118]:=Point(459 + dx,55 + dy);
  Points[119]:=Point(459 + dx,56 + dy);
  Points[120]:=Point(460 + dx,57 + dy);
  Points[121]:=Point(460 + dx,60 + dy);
  Points[122]:=Point(461 + dx,61 + dy);
  Points[123]:=Point(461 + dx,65 + dy);
  Points[124]:=Point(462 + dx,66 + dy);
  Points[125]:=Point(462 + dx,72 + dy);
  Points[126]:=Point(463 + dx,73 + dy);
  Points[127]:=Point(463 + dx,79 + dy);
  Points[128]:=Point(461 + dx,81 + dy);
  Points[129]:=Point(463 + dx,81 + dy);
  Points[130]:=Point(463 + dx,86 + dy);
  Points[131]:=Point(461 + dx,88 + dy);
  Points[132]:=Point(462 + dx,88 + dy);
  Points[133]:=Point(462 + dx,93 + dy);
  Points[134]:=Point(460 + dx,95 + dy);
  Points[135]:=Point(461 + dx,95 + dy);
  Points[136]:=Point(461 + dx,98 + dy);
  Points[137]:=Point(459 + dx,100 + dy);
  Points[138]:=Point(460 + dx,100 + dy);
  Points[139]:=Point(460 + dx,102 + dy);
  Points[140]:=Point(458 + dx,104 + dy);
  Points[141]:=Point(459 + dx,104 + dy);
  Points[142]:=Point(459 + dx,105 + dy);
  Points[143]:=Point(457 + dx,107 + dy);
  Points[144]:=Point(458 + dx,107 + dy);
  Points[145]:=Point(456 + dx,109 + dy);
  Points[146]:=Point(457 + dx,109 + dy);
  Points[147]:=Point(457 + dx,110 + dy);
  Points[148]:=Point(455 + dx,112 + dy);
  Points[149]:=Point(456 + dx,112 + dy);
  Points[150]:=Point(454 + dx,114 + dy);
  Points[151]:=Point(455 + dx,114 + dy);
  Points[152]:=Point(453 + dx,116 + dy);
  Points[153]:=Point(454 + dx,116 + dy);
  Points[154]:=Point(452 + dx,118 + dy);
  Points[155]:=Point(453 + dx,118 + dy);
  Points[156]:=Point(451 + dx,120 + dy);
  Points[157]:=Point(452 + dx,120 + dy);
  Points[158]:=Point(450 + dx,122 + dy);
  Points[159]:=Point(449 + dx,123 + dy);
  Points[160]:=Point(450 + dx,123 + dy);
  Points[161]:=Point(448 + dx,125 + dy);
  Points[162]:=Point(446 + dx,127 + dy);
  Points[163]:=Point(447 + dx,127 + dy);
  Points[164]:=Point(445 + dx,129 + dy);
  Points[165]:=Point(444 + dx,130 + dy);
  Points[166]:=Point(445 + dx,130 + dy);
  Points[167]:=Point(443 + dx,132 + dy);
  Points[168]:=Point(435 + dx,140 + dy);
  Points[169]:=Point(434 + dx,140 + dy);
  Points[170]:=Point(429 + dx,145 + dy);
  Points[171]:=Point(428 + dx,145 + dy);
  Points[172]:=Point(426 + dx,147 + dy);
  Points[173]:=Point(425 + dx,147 + dy);
  Points[174]:=Point(424 + dx,148 + dy);
  Points[175]:=Point(423 + dx,148 + dy);
  Points[176]:=Point(421 + dx,150 + dy);
  Points[177]:=Point(420 + dx,150 + dy);
  Points[178]:=Point(419 + dx,151 + dy);
  Points[179]:=Point(418 + dx,151 + dy);
  Points[180]:=Point(417 + dx,152 + dy);
  Points[181]:=Point(416 + dx,152 + dy);
  Points[182]:=Point(415 + dx,153 + dy);
  Points[183]:=Point(414 + dx,153 + dy);
  Points[184]:=Point(413 + dx,154 + dy);
  Points[185]:=Point(411 + dx,154 + dy);
  Points[186]:=Point(410 + dx,155 + dy);
  Points[187]:=Point(409 + dx,155 + dy);
  Points[188]:=Point(408 + dx,156 + dy);
  Points[189]:=Point(405 + dx,156 + dy);
  Points[190]:=Point(404 + dx,157 + dy);
  Points[191]:=Point(402 + dx,157 + dy);
  Points[192]:=Point(401 + dx,158 + dy);
  Points[193]:=Point(397 + dx,158 + dy);
  Points[194]:=Point(396 + dx,159 + dy);
  Points[195]:=Point(390 + dx,159 + dy);
  Points[196]:=Point(389 + dx,160 + dy);
  Points[197]:=Point(73 + dx,160 + dy);
  Points[198]:=Point(72 + dx,158 + dy);
  Points[199]:=Point(71 + dx,159 + dy);
  Points[200]:=Point(66 + dx,159 + dy);
  Points[201]:=Point(65 + dx,157 + dy);
  Points[202]:=Point(64 + dx,158 + dy);
  Points[203]:=Point(61 + dx,158 + dy);
  Points[204]:=Point(60 + dx,156 + dy);
  Points[205]:=Point(59 + dx,157 + dy);
  Points[206]:=Point(58 + dx,157 + dy);
  Points[207]:=Point(57 + dx,155 + dy);
  Points[208]:=Point(56 + dx,156 + dy);
  Points[209]:=Point(54 + dx,156 + dy);
  Points[210]:=Point(53 + dx,154 + dy);
  Points[211]:=Point(52 + dx,155 + dy);
  Points[212]:=Point(51 + dx,153 + dy);
  Points[213]:=Point(50 + dx,154 + dy);
  Points[214]:=Point(49 + dx,154 + dy);
  Points[215]:=Point(48 + dx,152 + dy);
  Points[216]:=Point(47 + dx,153 + dy);
  Points[217]:=Point(46 + dx,151 + dy);
  Points[218]:=Point(45 + dx,152 + dy);
  Points[219]:=Point(44 + dx,150 + dy);
  Points[220]:=Point(43 + dx,151 + dy);
  Points[221]:=Point(42 + dx,149 + dy);
  Points[222]:=Point(41 + dx,150 + dy);
  Points[223]:=Point(40 + dx,148 + dy);
  Points[224]:=Point(39 + dx,149 + dy);
  Points[225]:=Point(38 + dx,147 + dy);
  Points[226]:=Point(37 + dx,146 + dy);
  Points[227]:=Point(36 + dx,147 + dy);
  Points[228]:=Point(35 + dx,145 + dy);
  Points[229]:=Point(34 + dx,144 + dy);
  Points[230]:=Point(33 + dx,145 + dy);
  Points[231]:=Point(32 + dx,143 + dy);
  Points[232]:=Point(30 + dx,141 + dy);
  Points[233]:=Point(29 + dx,142 + dy);
  Points[234]:=Point(28 + dx,140 + dy);
  Points[235]:=Point(19 + dx,131 + dy);
  Points[236]:=Point(19 + dx,130 + dy);
  Points[237]:=Point(15 + dx,126 + dy);
  Points[238]:=Point(15 + dx,125 + dy);
  Points[239]:=Point(14 + dx,124 + dy);
  Points[240]:=Point(14 + dx,123 + dy);
  Points[241]:=Point(11 + dx,120 + dy);
  Points[242]:=Point(11 + dx,119 + dy);
  Points[243]:=Point(10 + dx,118 + dy);
  Points[244]:=Point(10 + dx,117 + dy);
  Points[245]:=Point(9 + dx,116 + dy);
  Points[246]:=Point(9 + dx,115 + dy);
  Points[247]:=Point(8 + dx,114 + dy);
  Points[248]:=Point(8 + dx,113 + dy);
  Points[249]:=Point(7 + dx,112 + dy);
  Points[250]:=Point(7 + dx,111 + dy);
  Points[251]:=Point(6 + dx,110 + dy);
  Points[252]:=Point(6 + dx,108 + dy);
  Points[253]:=Point(5 + dx,107 + dy);
  Points[254]:=Point(5 + dx,105 + dy);
  Points[255]:=Point(4 + dx,104 + dy);
  Points[256]:=Point(4 + dx,103 + dy);
  Points[257]:=Point(3 + dx,102 + dy);
  Points[258]:=Point(3 + dx,99 + dy);
  Points[259]:=Point(2 + dx,98 + dy);
  Points[260]:=Point(2 + dx,94 + dy);
  Points[261]:=Point(1 + dx,93 + dy);
  Points[262]:=Point(1 + dx,87 + dy);
  Points[263]:=Point(0 + dx,86 + dy);
  Points[264]:=Point(0 + dx,73 + dy);
  Points[265]:=Point(1 + dx,73 + dy);
  R2:=CreatePolygonRgn(Points[0],266,Winding);
  CombineRgn(R1,R1,R2,Rgn_XOR);
  SetWindowRgn(AHandle,R1,True);
  FindWidthHeight(Points,265);
  DeleteObject(r1);
  DeleteObject(r2);
  CreateOddWindow:= Point(FormWidth,FormHeight);
end;

procedure TInstruments.SpdBtnCloseClick(Sender: TObject);
begin
 if not FlgStopScan then
    begin
      ShowMessage('Stop Scanning before exit!!!');
      exit;
    end;
  if assigned(ScanWnd) then
    begin
      ShowMessage('Close Scan Window!!!');
      exit;
    end;
  if  flgApproachOK then
   begin
      if Application.MessageBox('Move away!','',MB_OKCANCEL)=IDOK then
        begin
              Approach:=TApproach.Create(Application{,Approach});
              Approach.Show;
        end
        else
        begin
              flgApproachOK:=false;
              Close;
              Main.NewItem.Enabled:=True;
              Caption:='Main';
        end;
   end
   else
   begin
              Close;
              Main.NewItem.Enabled:=True;
              Caption:='Main';
   end;
end;

procedure TInstruments.UserMessage (var Msg: TMessage);
begin
 Application.ProcessMessages;
 FreeLibrary( LibVideoHandle);
 libVideoHandle:=0;
end;
procedure TInstruments.RestoreState;
begin
   case STMflg of
true: begin
       STMExecute(self);
       ComboBoxSFMSTM.ItemIndex:=1;
      end;
false:begin
        SFMExecute(self);
        ComboBoxSFMSTM.ItemIndex:=0;
      end;
      end;
end;

procedure TInstruments.CreateParams(var Params:TCreateParams);
begin
inherited CreateParams(Params);
    Params.Style:=Params.Style xor WS_SizeBOX xor WS_MaximizeBox;
end;

procedure TInstruments.WMMOve(var Mes:TWMMove);
begin
//    if Mes.YPos<Main.ToolBar1.Height+5 then Top:=Main.ToolBar1.Height+5;
end;

procedure TInstruments.WMNCHitTest(var M: TWMNCHitTest);
begin
  inherited;            //вызываем стандартный обработчик
  if M.Result = htClient then   M.Result := htCaption;
end;

procedure TInstruments.HintHandler(Sender: TObject);
begin
  begin
   if Sender=ScanBtn then
    begin
     if ScanBtn.Enabled then ScanBtn.Hint:='Scanning Surface Sample '
                        else ScanBtn.Hint:='Make Landing before Scan';
    end;
  end;
end;

procedure TInstruments.FormCreate(Sender: TObject);
var
  FormCoord: TPoint;
  LinError:integer;
  NewItem:TMenuItem;
  FlgStatusStep:byte;
  reg:TRegistry;
  res:integer;
  olddir:string;
begin
  TimerHung.enabled:=false;
 {$IFDEF FULL}
    ComboBoxSFMSTM.Items.Add('Etching');
    with   PanelSTMSFM do
      begin
       Left:=45;
       width:=76;
      end;
 {$ELSE}
    with   PanelSTMSFM do
      begin
       Left:=47;
       width:=68;
      end;
 {$ENDIF}
  addCaption:='';
  ComboBoxSFMSTM.width:= ComboBoxSFMSTM.parent.ClientWidth-4;
  FormCoord:= CreateOddWindow(Handle,false);
  Main.ToolButtonOsc.visible:=(CurrentUserLevelFlg=Advanced);
  RunOscilloscope.Enabled:=(CurrentUserLevelFlg=Advanced);
  Main.ToolBtnFAQ.visible:=true;
  Width:= FormCoord.x+3;
  Height:= FormCoord.y+3;
  Caption:='Control Panel';
  LabelSFM.caption:=addCaption+'SFM';
  LabelSFM.Hint:='Scanning Force Microscope';
  STMflg:=false;
   flgLinYScanner:=false;
   flgLinXScanner:=false;
   Main.ToolBtnDir.Enabled:=False;
   Application.ProcessMessages;
      olddir:=workdirectory;
      ChangeDir:=TChangeDir.Create(self);
      res:=ChangeDir.ShowModal;
 (*   if res=mrOK then
     begin
     if assigned(WorkView) and (olddir<>workdirectory) then
      begin
       WorkView.Close;
       Main.CreateWorkViewWnd(false);
      end
     end
      else *)
   Main.CreateWorkViewWnd(true);
   Scanning.Enabled:=False;
   Landing.Enabled:=False;
        case STmflg  of
  true: begin
          ScanBtn.Hint:='Make Landing before Scanning';
          PreSCanBtn.Hint:='Landing';
        end;
  false:begin
          ScanBtn.Hint:='Make Resonance and Landing before Scanning';
          PreSCanBtn.Hint:='Make Resonance before Landing';
        end;
         end;
   Resonance.Enabled:=True;
   ResonanceBtn.Hint:='Resonance Fequence Measuring  and Setting';
   SetIntActOnProgr:=False;

        case CurrentUserLevelFlg of
  Advanced: NanoEdu:=TSFMNanoEdu.Create;
  Demo    : NanoEdu:=TSFMNanoEduDemo.Create;
          end;

  AtomScaleChooseExecute(sender);

  LoadConfig;

  LinError:=TestErrorScannerIniFile;
  SetLinSplineZero;
  with ScannerCorrect    do
    begin
       FlgXYLinear:=True;
       FlgZSurfCorr:=False;
       flgPlnDel:=True;
       flgPlnDelHW:=True;
       flgHideLine:=True;
    end;
      case LinError of
      5:                                               ;//no scanner.ini file
    3,4:begin ScannerCorrect.FlgXYLinear:=False;         end;
      0: LoadLinSpline(HardWareOpt.ScannerNumb);       //O'K
      2:;                                                //new scanner
            end;

       NanoEdu.TurnOn;
       //*****************
       //move to start position
       //*******************
       NanoEdu.SetDACZero;
       NanoEdu.ApproachRegime;
       NanoEdu.ScannerApproach.TurnOn;
       Inform:=TInform.Create(Application);
       Inform.Show;
       Application.ProcessMessages;
    //   TimerHung.enabled:=true;
       FlgStatusStep:=NanoEdu.ScannerApproach.RisingToStartPoint(100);
    //   TimerHung.enabled:=false;
       FreeAndNil(NanoEdu.ScannerApproach);
        case    FlgStatusStep of
     4: begin            //out boundary
         Beep;
         MessageDlgCtr('Attention!!!'+#13+'The step motor has achieved top position!'+#13+'Turn screw counter-clockwise by hand!!', mtInformation,[mbOk],IDH_Probe_is_too_High);
        end;
     99:begin
         NanoEdu.ScannerApproach.TurnOff;
         exit;
        end;
           end;
       Inform.Close;
       NewItem := TMenuItem.Create(Self);
       NewItem.Caption :='-';
       Main.mWindows.Add(NewItem);
       NewItem := TMenuItem.Create(Self);
       NewItem.Caption := self.Caption;
       NewItem.OnClick:=Main.ActivateMenuItem;
       Main.mWindows.Add(NewItem);
        //adjust oscilloscope
       Reg:=TRegistry.Create;
//          FlgApproachOK:=true;
  try
       Reg.RootKey:=HKEY_CURRENT_USER;
       if not Reg.KeyExists('software\CSPM\Oscilloscope\Last') then   Main.ToolButtonOscClick(Sender);
       Reg.CloseKey;
  finally
       Reg.Free;
  end;
end;

procedure TINstruments.TurnOff;
begin

end;




procedure TInstruments.FastLandingDrawItem(Sender: TObject;ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
var
  Bitmap : TBitMap;
begin
  Bitmap := TBitmap.Create;
  try
    Imagelist5.GetBitMap(1,Bitmap);
    ACanvas.Draw(0,0,BitMap);
  finally
    FreeAndNil(Bitmap);
  end;
end;

procedure TInstruments.FastLandingMeasureItem(Sender: TObject;ACanvas: TCanvas; var Width, Height: Integer);
begin
   width:=80;
   height:=27;
end;

procedure TInstruments.SlowLandingDrawItem(Sender: TObject; ACanvas: TCanvas;ARect: TRect; Selected: Boolean);
var
  Bitmap : TBitMap;
begin
  Bitmap := TBitmap.Create;
  try
    Imagelist5.GetBitMap(0,Bitmap);
    ACanvas.Draw(0,30,BitMap);
  finally
    FreeAndNil(Bitmap);
  end;
end;

procedure TInstruments.SlowLandingMeasureItem(Sender: TObject;ACanvas: TCanvas; var Width, Height: Integer);
begin
   width:=80;
   height:=27;
end;

procedure TInstruments.FormCloseQuery(Sender: TObject;   var CanClose: Boolean);
var h:HWNd;
  TheWindow : HWND;
begin
 if (ScanWND<>nil) or (Approach<>nil) or (AutoResonance <>nil)
                   or (FastLand<>nil) or (FormScannerTraining<>nil)
                then
     begin
         MessagedlgCtr('Close all windows!',mtinformation,[mbOK],0);
         CanClose := False;
      end
      else CanClose := True;
         { TODO : 250506 }
(* TheWindow:=0;
 TheWindow:=FindWindow(nil,'Oscilloscope');
 if  TheWindow>0 then
  begin
     TheWindow:=0;
    TheWindow:=FindWindow(nil,'Oscilloscope');
    if  TheWindow>0 then
      begin
       MessagedlgCtr('If You use  Oscilloscope do not forget to close  Oscilloscope!',mtinformation,[mbOK],0);
       CanClose := true;
      end;
  end;
 *)
   h:=FindWindow(nil,'MSVideo');
   if h<>0 then  StopVideo;
end;

procedure TInstruments.FormClose(Sender: TObject; var Action: TCloseAction);
var
 uExitCode:word;
 ProcessHandle : THandle;
 ProcessID: Integer;
   TheWindow : HWND;
 ProcInfo: TProcessInformation;
 label 100;
begin
if EXE_Running('Oscilloscope.exe', false) then
 begin
  TheWindow:=FindWindow(nil,'Oscilloscope');
  if  TheWindow<>0 then
  begin
   GetWindowThreadProcessID(TheWindow, @ProcessID);
   ProcessHandle := OpenProcess(PROCESS_TERMINATE, FALSE, ProcessId);
   if not (ProcessHandle=0) then
   begin
    TerminateProcess(ProcessHandle,0{4});
    CloseHandle(ProcessHandle);
   end;
  end;
 end;
if CurrentUserLevelflg<>Demo then
 begin
  SaveConfig;
  SaveElectronicParams;
 end;
  Main.NewItem.Enabled:=True;
  Main.ComboBoxLevel.Enabled:=true;
  Main.ToolBtnNew.Enabled:=True;
  Main.ToolBtnFAQ.visible:=false;
  Main.ToolBtnCntrl.visible:=False;
  Main.ToolButtonOsc.Visible:=false;
  Main.btnViewWork.Visible:=false;
 if assigned(WorkView) then
 begin
   Main.width:= Main.width+ WorkView.width;
   Main.Left:=Screen.WorkAreaLeft;
   WorkView.close;
 end;

//  Main.Paneluser.Visible:=true;
 if  libHandle<=0 then      //????<=0
 begin
   goto 100;
 end;
 if  not FreeCSPMLib(libHandle) then ShowMessage('error free cspmlib');
100:
  FreeAndNil(NanoEdu);
  Action:=caFree;
  Instruments:=nil;
end;



procedure TInstruments.FormShow(Sender: TObject);
begin
   self.left:=0;
   self.top:=Main.ToolBarMain.height+10;
end;

procedure TInstruments.ToolBtnHelpClick(Sender: TObject);
begin
     Application.Helpcontext(IDH_Device_Panel{17});
end;

function TInstruments.ExecAndWaitOsc(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
var StartInfo:TStartupInfo;
     ProcInfo:TProcessInformation;
      CmdLine:ShortString;
            H:hWnd;
            R:TRECT;
begin { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
   CmdLine := '"' + Filename + '" ' + Params;
   FillChar(StartInfo, SizeOf(StartInfo), #0);
   with StartInfo do
    begin
     dwFlags := STARTF_USESHOWWINDOW;
     wShowWindow := WinState;
    end;
     Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
     { Ожидаем завершения приложения }
    if Result then
     begin
       h:=0;
      while h=0 do  h:=findwindow(nil,Pchar(winname));
      GetWindowRect(h,R);
      SetWindowPos(h,HWND_TOPMost,Main.Left+50+Main.ClientWidth-(R.right-R.left),0,50,50,SWP_NOSIZE {or SWP_NOMOVE} or SWP_SHOWWINDOW);
     end;
end;

function TInstruments.ExecAndWait(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
var StartInfo: TStartupInfo;
     ProcInfo: TProcessInformation;
      CmdLine: ShortString;
            H: hWnd;
            R:TRECT;
begin { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
 if not EXE_Running('Oscilloscope.exe',false) then  // h:=FindWindow(nil,Pchar(winname));
  begin
   CmdLine := '"' + Filename + '" ' + Params;
   FillChar(StartInfo, SizeOf(StartInfo), #0);
   with StartInfo do
    begin //cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
    end;
     Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
     { Ожидаем завершения приложения }
    if Result then
     begin
      h:=0;
      while h=0 do  h:=FindWindow(nil,Pchar(winname));
      GetWindowRect(h,R);
      SetWindowPos(h,HWND_TOPMost,Main.Left+50+Main.ClientWidth-(R.right-R.left),0,50,50,SWP_NOSIZE {or SWP_NOMOVE} or SWP_SHOWWINDOW);
     end;
   end
  else
   begin
    Result:=false;
    MessageDlg('program is active or error start program '+winname+'!!'+#13+'If it is error,close control panel and restart again',mtWarning ,[mbOK,mbHelp],1);
   end;
end;
function TInstruments.ExecAndWaitEtch(const FileName, Params: ShortString;const winname:string; const WinState: Word): boolean;
var StartInfo: TStartupInfo;
     ProcInfo: TProcessInformation;
      CmdLine: ShortString;
            H: hWnd;
            R:TRECT;
begin { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
   CmdLine := '"' + Filename + '" ' + Params;
   FillChar(StartInfo, SizeOf(StartInfo), #0);
   with StartInfo do
    begin //cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
    end;
     Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
     { Ожидаем завершения приложения }
    if Result then
     begin
      WaitForSingleObject(ProcInfo.hProcess, INFINITE); { Free the Handles }
      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);
     end;
end;

procedure TInstruments.adjustBtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  point,pointa:Tpoint;
  begin
(*if FlgApproachOK then
 begin
 if MessageDlg('The tip is too close to a sample.'+#13+'It is recommended to make rising preliminary! Continue?',mtwarning,[mbYes,mbNo],0)=mrYes
  then
  begin
    point.x:=AdjustBtn.left;//x-10;
    point.y:=AdjustBtn.top+10;//y-10;
    pointa:=AdjustBtn.ClientToScreen(point);
    AdjustPopupMenu.Popup(pointa.X,pointa.y);
  end
  else exit;
 end
 else
 begin
    point.x:=x;
    point.y:=y;
    pointa:=AdjustBtn.ClientToScreen(point);
    AdjustPopupMenu.Popup(pointa.X,pointa.y);
 end;
*)
 end;



procedure TInstruments.ResonanceExecute(Sender: TObject);
begin
 AutoResonance:=TAutoResonance.Create(Application);
 Training.Enabled:=False;
end;

procedure TInstruments.ScanningExecute(Sender: TObject);
begin
  if assigned(FormScannerTraining) then
 begin
   MessageDlg('Close Scanner Trainning Windows!', mtInformation,[mbOk], 0);
   exit;
 end;
   ScanWND:=TScanWND.Create(Application);
   Training.Enabled:=False; { TODO : 250607 }
end;

procedure TInstruments.TrainingExecute(Sender: TObject);
begin
     if not flgApproachOK then
                       begin
                         FormScannerTraining:= TFormScannerTraining.Create(Application);
                         Training.Enabled:=False;
                         Resonance.Enabled:=false;
                       end
                       else MessageDlg('Move the probe away!',mtwarning,[mbYes],0);
end;

procedure TInstruments.VideoExecute(Sender: TObject);
 var h:Hwnd;
    libload:Dword;
    R:TRect;
begin
 Video.Enabled:=False;  { TODO : 130906 }
 if   flgVideoOscConflict then
 begin
  if   EXE_Running('Oscilloscope.exe', false) then
  begin
   h:=findwindow(nil,Pchar('oscilloscope'));
   if h<>0  then
   begin
    h:=0;
    h:=FindWindow(nil,'Oscilloscope');
    if  h>0 then
      begin
       MessageDlg('Close Oscilloscope program!! ',mtWarning ,[mbOK],0);
       Video.Enabled:=True;
       exit;
      end;
   end;
  end
 end;
    h:=findwindow(nil,Pchar('MSVideo'));
  if h=0  then
    begin
       if GetModuleHandle('MSVideoLib.dll')=0 then
       begin
        @StartVideo:=nil;
        LibVideoHandle:=0;
        LibVideoHandle:=LoadLibrary(PChar(ExeFilePath+'MSVideoLib.dll'));
        if  LibVideoHandle<=32 then
                                  begin
                                   MessageDlg('Library MSVideoLib.dll Load Error'+ IntToStr(GetLastError)+'!',mtWarning,[mbOk],0);
                                   exit;
                                  end
                               else
                                  begin
                                    StartVideo:=GetProcAddress(LibVideoHandle,'StartVideo');
                                    StopVideo:=GetProcAddress(LibVideoHandle,'StopVideo');
                                  end;
        end;
       StartVideo(Application.Handle,self.Handle,WM_UserCloseVideo);
       h:=findwindow(nil,Pchar('MSVideo'));
     if h<>0  then
       begin
        GetWindowRect(h,R);
        SetWindowPos(h,HWND_TOPMost,Main.Left+5,Main.Top+Main.ClientHeight-(R.Bottom-R.Top),50,50,SWP_NOSIZE or SWP_SHOWWINDOW);
       end;
 end;
   Video.Enabled:=True;
end;

procedure TInstruments.RunOscilloscopeExecute(Sender: TObject);
   var H:HWnd;
begin { TODO : 130906 }
   RunOscilloscope.enabled:=False;
 if   flgVideoOscConflict then
 begin
  h:=FindWindow(nil,'MSVideo');
   if h=0 then
   begin
    ExecAndWait(ExeFilePath+'oscilloscope\oscilloscope.exe' ,'','oscilloscope',SW_showNORMAL);
    sleep(300);
   end
   else  MessageDlg('Close Video before Start!',mtWarning ,[mbOK],0);
 end
 else
 begin
    ExecAndWait(ExeFilePath+'oscilloscope\oscilloscope.exe' ,'','oscilloscope',SW_showNORMAL);
    sleep(300);
 end;
     RunOscilloscope.enabled:=True;
end;
procedure TInstruments.ShowOptionExecute(Sender: TObject);
begin
 if not assigned(Nanoedu) then
 begin
  MessageDlgCtr('Chooose Device!',mtwarning,[mbYes],0);
  exit;
 end;

 if not assigned(ApproachOpt) then
  begin
   ApproachOpt:=TApproachOpt.Create(self,ApproachOpt);
    with ApproachOpt do
     begin
          ScanOptSheet.TabVisible:=True;
          ApprOptSheet.TabVisible:=True;
    end;
   ShowOptions.Enabled:=false;
  end
  else ApproachOpt.SetFocus;
end;



procedure TInstruments.LandingExecute(Sender: TObject);
 var i:integer;
begin

end;
procedure TInstruments.LandingSlowExecute(Sender: TObject);
 var h:HWND;
begin
 if   flgVideoOscConflict then
 begin
  h:=0;     { TODO : 160905 }
  h:=findwindow(nil,Pchar('MSVideo'));
  if h<>0  then   StopVideo;
  Video.Enabled:=false;
 end;
 Training.Enabled:=False;{ TODO : 021006 }
 Instruments.PanelSTMSFM.Enabled:=false;
 if assigned(FormScannerTraining) then
 begin
   MessageDlg('Close Scanner Trainning Windows!', mtInformation,[mbOk], 0);
   exit;
 end;
 Approach:=TApproach.Create(Application{,Approach});
 if FlgTrans then
  begin
   Rgn:= CreateRectRgn(Approach.left,Approach.top,Approach.left+Approach.width,Approach.top+Approach.height);
   CombineRgn(FullRgn,FullRgn, Rgn, rgn_or);
    // устанавливаем новый регион окна
   SetWindowRgn(Handle,FullRgn, True);
   InvalidateRect(handle,nil,True);
  end ;
 // Approach.Show;  { TODO : 111206 }
end;

 procedure TInstruments.LandingFastExecute(Sender: TObject);
 var H:HWND;
    R:TRect;
 ProcessHandle : THandle;
  ProcessID: Integer;
 ProcInfo: TProcessInformation;
begin
 if EXE_Running('Oscilloscope.exe', false) then
 begin
  h:=FindWindow(nil,'Oscilloscope');
  if  h<>0 then
  begin
   GetWindowThreadProcessID(h, @ProcessID);
   ProcessHandle := OpenProcess(PROCESS_TERMINATE, FALSE, ProcessId);
   if not (ProcessHandle=0) then
   begin
    TerminateProcess(ProcessHandle,0{4});
    CloseHandle(ProcessHandle);
   end;
  end;
 end;
  FastLand:=TFastLand.Create(Application);
    Application.ProcessMessages;
 if  CurrentUserLevelFlg<>Demo then
 Begin
   h:=findwindow(nil,Pchar('MSVideo'));
   if h=0  then
    begin
    if GetModuleHandle('MSVideoLib.dll')=0 then
     begin
      @StartVideo:=nil;
      LibVideoHandle:=0;
      LibVideoHandle:=LoadLibrary(PChar(ExeFilePath+'MSVideoLib.dll'));
       if  LibVideoHandle<=32 then begin
                                    MessageDlg('Library MSVideoLib.dll Load Error'+ IntToStr(GetLastError)+'!. Test USB Connection. ',mtWarning,[mbOk],0);
                                    exit;
                                   end
                              else
                                  begin
                                    StartVideo:=GetProcAddress(LibVideoHandle,'StartVideo');
                                    StopVideo:=GetProcAddress(LibVideoHandle,'StopVideo');
                                  end;
     end;
       StartVideo(Application.Handle,self.Handle,WM_UserCloseVideo);
       h:=findwindow(nil,Pchar('MSVideo'));
      if h<>0  then
       begin
        GetWindowRect(h,R);
        SetWindowPos(h,HWND_TOPMost,Main.Left+5,Main.Top+Main.ClientHeight-(R.Bottom-R.Top),50,50,SWP_NOSIZE or SWP_SHOWWINDOW);
       end;
    end;
 end;
    Scanning.Enabled:=False;
    Landing.Enabled:=False;
    Resonance.Enabled:=False;
    Training.Enabled:=False;
end;


procedure TInstruments.STMExecute(Sender: TObject);
begin
        STMflg:=true;
        panelup.width:=270;
        panelup.left:=100;
        LabelSFM.left:=216;
                  case flgAtomUnit of
    true:   begin
             LabelSFM.caption:='Atom Unit STM';
             LabelSFM.Left:=LabelSFM.Left-45;
            end;
    false:  begin
              LabelSFM.caption:='STM';
//              labelSFM.Left:=LabelSFM.Left+45;
             end;
                    end;
        LabelSFM.Hint:='Scanning Tunneling Microscope';
        ImageBck.Hint:='Scanning Tunneling Microscope';
        ComboBoxSFMSTM.Hint:='Scanning Tunneling Microscope';
        Resonance.visible:=false;
        Scanning.Enabled:=False;
        Scanning.Hint:='Make Landing before Scanning';
        Landing.Enabled:=True;
        Landing.Hint:='Landing';
        Training.Enabled:=not FlgApproachOK;
        if assigned(Approach)  then
        begin
          Approach.flgCancel:=true;
          Approach.Close;
        end;
        ApproachParamsLast(ConfigIniFile);
        MessageDlg('Attention!'+#13+'STM is intendend for working with conductive samples,otherwise the probe will be destroyed!!'+#13+'Check up  value of a voltage.',mtWarning ,[mbOK],0);
        TransformUnitInit;
        FreeAndNil(NanoEdu);
       case CurrentUserLevelFlg of
  Beginner,
  Advanced: NanoEdu:=TSTMNanoEdu.Create;
  Demo    : NanoEdu:=TSTMNanoEduDemo.Create;
          end;
        NanoEdu.TurnOn;
        if FlgApproachOK then  LandingSlowExecute(Sender);
end;

procedure TInstruments.SFMExecute(Sender: TObject);
begin
        STMflg:=false;
        PanelUp.width:=356;
        PanelUp.left:=54;
        Resonance.visible:=true;
        Resonance.Enabled:=true;
        Application.ProcessMessages;
        LabelSFM.left:=216;
                case flgAtomUnit of
    true:   begin
             LabelSFM.caption:='Atom Unit SFM';
             LabelSFM.Left:=LabelSFM.Left-45;
            end;
    false:  begin
              LabelSFM.caption:='SFM';
//              labelSFM.Left:=LabelSFM.Left+45;
             end;
                  end;
        LabelSFM.Hint:='Scanning Force Microscope';
        ImageBck.Hint:='Scanning Force Microscope';
        ComboBoxSFMSTM.Hint:='Scanning Force Microscope';
        Scanning.Enabled:=False;//  AFMModeBtn.ImageIndex:=3;
        Training.Enabled:=not FlgApproachOK;
        Landing.Enabled:=False;
        FlgApproachOK:=False;
        FlgStopScan:=True;
        SetIntActOnProgr:=False;
        ApproachParamsLast(ConfigIniFile);
        TransformUnitInit;
        FreeAndNil(NanoEdu);
             case CurrentUserLevelFlg of
  Beginner,
  Advanced: NanoEdu:=TSFMNanoEdu.Create;
  Demo    : NanoEdu:=TSFMNanoEduDemo.Create;
          end;
        NanoEdu.TurnOn;
        Scanning.Hint:='Make Resonance and Landing before Scanning';
        Landing.Hint:='Make Resonance before Landing';

end;
procedure TInstruments.EtchingExecute(Sender: TObject);
 var H:HWND;
    R:TRect;
 begin
 //  Windowstate:=wsMinimized;
 if EXE_Running('Oscilloscope.exe', false) then
  begin
    MessageDlg('Close Oscilloscope program!! ',mtWarning ,[mbOK],0);
    exit;
  end;
  if (ScanWND<>nil) or (Approach<>nil) or (AutoResonance <>nil)
                    or (FastLand<>nil) or (FormScannerTraining<>nil)
                    then
      begin
         ShowMessage('Close all windows!');
         exit;
      end ;
 if   flgVideoOscConflict then
 begin
   h:=FindWindow(nil,'MSVideo');
   if h<>0 then
    begin  MessageDlg('Close Nanoeducator Video Camera, before Start Etching!',mtWarning ,[mbOK],0);  RestoreState; exit   end;
 end;
        LabelSFM.left:=168;
        LabelSFM.caption:='ETCHING UNIT';
        LabelSFM.Hint:='TIP ETCHING';
        Main.ToolBtnDir.Enabled:=False;
        Caption:='Control Panel';
//        ApproachParamsLast(ConfigIniFile);
//        TransformUnitInit;
        if assigned(Nanoedu) then FreeAndNil(NanoEdu);
        PanelSTMSFM.Enabled:=false;
        Video.Enabled:=true;
        Scanning.Enabled:=False;
        Landing.Enabled:=False;
        Resonance.Enabled:=False;
        Training.Enabled:=False;
        Main.windowstate:=wsMinimized;
        Application.ProcessMessages;
if not EXE_Running('Etching.exe', false) then
  begin
    ExecAndWaitEtch(ExeFilePath+'Etching.exe' ,'','tip etching',SW_showNORMAL);
    h:=findwindow(nil,Pchar('MSVideo'));
    if h<>0  then   StopVideo;
    Main.WindowState:=wsMaximized;
    PanelSTMSFM.enabled:=true;
    Training.Enabled:=false;
    Resonance.Enabled:=false;
    Landing.Enabled:=false;
    RestoreState;
    Application.ProcessMessages;
  end;
end;

procedure TInstruments.ComboBoxSFMSTMSelect(Sender: TObject);
begin
  ScanParams.flgSpectr:=false;
      case   ComboBoxSFMSTM.ItemIndex of
  0:  SFMExecute(Sender);
  1:  STMExecute(Sender);
  2:  EtchingExecute(Sender);
     end;
end;
procedure TInstruments.CloseWndExecute(sender:TObject);
begin
   if not FlgStopScan then
    begin
      ShowMessage('Stop Scanning before exit!!!');
      exit;
    end;
  if assigned(ScanWnd) then
    begin
      ShowMessage('Close Scan Window!!!');
      exit;
    end;
  if  flgApproachOK then
   begin
      if // MessageDlgCtr('Attention!!! Move away!', mtInformation,[mbOk],0)=IDOK
        Application.MessageBox('Move away!','',MB_OKCANCEL)=IDOK then
        begin
              Approach:=TApproach.Create(Application{,Approach});
              Approach.Show;
        end
        else
        begin
              flgApproachOK:=false;
              Close;
              Main.NewItem.Enabled:=True;
              Caption:='Main';
        end;
   end
   else
   begin
              Close;
              Main.NewItem.Enabled:=True;
              Caption:='Main';
   end;


end;
procedure  TInstruments.ShowHelpExecute(sender:TObject);
begin
     Application.Helpcontext(IDH_Device_Panel{17});
end;

procedure  TInstruments.AtomScaleChooseExecute(sender:TObject);
var  LinError:integer;
begin
//   flgAtomUnit:=not  flgAtomUnit;
//   SpdBtnA.Down:=not SpdBtnA.Down;

  with ScanParams do
  begin
    case  flgAtomUnit of
 false:begin
        LabelSFM.Left:=171;
        ScanAreaStartXR:=5000;
        ScanAreaStartYR:=5000;
        ScanAreaStartXF:=1000;
        ScanAreaStartYF:=1000;
        ScanAreaBeginXR:=10;
        ScanAreaBeginYR:=10;
        ScanAreaBeginXF:=10;
        ScanAreaBeginYF:=10;

        if PathFlash<>'' then
         begin
           IniFilesPath:=PathFlash+':\';
         end
         else IniFilesPath:=ExeFilePath;
//         SetScanParamsDef;
         LoadConfig;
         LinError:=TestErrorScannerIniFile;
         SetLinSplineZero;
       with ScannerCorrect    do
        begin
         FlgXYLinear:=True;
         FlgZSurfCorr:=False;
         flgPlnDel:=True;
         flgPlnDelHW:=True;
         flgHideLine:=True;
        end;
        case LinError of
         5:                                               ;//no scanner.ini file
       3,4:begin ScannerCorrect.FlgXYLinear:=False;         end;
         0: LoadLinSpline(HardWareOpt.ScannerNumb);       //O'K
         2:;                                                //new scanner
            end;

      end;
 true: begin
        LabelSFM.Left:=216;
         if PathFlash<>'' then
         begin
           IniFilesPath:=PathFlash+':\AtomicUnit\';
         end
         else IniFilesPath:=ExeFilePath+'AtomicUnit\';
        ScanAreaStartXR:=100;
        ScanAreaStartYR:=100;
        ScanAreaStartXF:=10;
        ScanAreaStartYF:=10;
        ScanAreaBeginXR:=1;
        ScanAreaBeginYR:=1;
        ScanAreaBeginXF:=1;
        ScanAreaBeginYF:=1;
        LoadConfig;
        SetLinSplineZero;
        with ScannerCorrect    do
        begin
         FlgXYLinear:=false;
         FlgZSurfCorr:=False;
         flgPlnDel:=True;
         flgPlnDelHW:=True;
         flgHideLine:=True;
        end;
      end;
           end;  //case
   end;
          case STMflg of
   true:
             case flgAtomUnit of
    true:   begin
             LabelSFM.caption:='Atom Unit STM';
             LabelSFM.Left:=LabelSFM.Left-45;
            end;
    false:  begin
              LabelSFM.caption:='STM';
              labelSFM.Left:=LabelSFM.Left+45;
             end;
              end;
  false:     case flgAtomUnit of
    true:   begin
             LabelSFM.caption:='Atom Unit SFM';
             LabelSFM.Left:=LabelSFM.Left-45;
            end;
    false: begin
             LabelSFM.caption:='SFM';
             LabelSFM.Left:=LabelSFM.Left+45;
            end;
             end;
              end;

 if assigned(ApproachOpt) then
  begin
    ApproachOpt.UpdateOption;
 end;
end;

procedure TInstruments.TimerHungTimer(Sender: TObject);
begin
 TimerHung.Enabled:=false;
 MessageDlg('Program Hung up!!'+#13+'You forget turn off/turn on Controller'+#13+'Program is terminated.'+#13+'Don''t forget turn off/turn on Controller!!!',mtWarning ,[mbYes],0);
 main.ProcessTerminate;//  halt;
end;

end.

