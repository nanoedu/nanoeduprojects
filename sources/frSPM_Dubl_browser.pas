unit frSPM_Dubl_browser;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, FileCtrl, Tabs, ComCtrls, Grids,ExtCtrls, ExtDlgs,
  spm_browserclasses, inifiles, siComp, siLngLnk,NTShellCtrls, TEMGlobal;
type
  TfrSPMView = class(TForm)
    siLangLinked1: TsiLangLinked;
    Panel_find: TPanel;
    Splitter_file: TSplitter;
    Splitter_View: TSplitter;
    Panel_file: TPanel;
    lb_preview_active: TListBox;
    NTShellListView: TNTShellListView;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure Panel_FileResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lb_preview_activeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lb_preview_activeEnter(Sender: TObject);
    procedure lb_preview_activeExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure NTShellListViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NTShellListViewChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private

  protected
    ldir:string;
    view_stm: TMyListView;
    FormVar: ^TfrSPMView;
    procedure SetActiveNext;
    procedure SetActivePred;
    procedure SetActiveUp;
    procedure SetActiveDown;
    procedure WMMove(var Mes:TWMMove);                    message WM_Move;
    procedure WMSetLBFocus(var AMessage : TMessage);      message WM_UserLBViewFocus;
    procedure myFormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure WMSizing(var Message: TMessage) ;           message WM_SIZING;
    procedure WMExitSizeMove(var Message: TMessage) ;     message WM_EXITSIZEMOVE;
    procedure WMGetMinMaxInfo(var info:TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure Prilip(var msg: TPrilipalkaMSG);            message CM_PrilipalkaMove;
    function  Stm_ActiveMY:boolean;
    { Private declarations }
  public
    lflg:integer;
    new_panel: TScrollBox;
    function   ActivateIcon(filename:string):boolean;
    procedure  DeActivate;
    procedure  ReDraw;
    procedure  ChangeDirectory(flgPositionEnd:boolean);
   constructor Create(AOwner: TComponent;dir:string; flg:integer);
   //flg=0 work ; =1 open ;  =2 gallery
   destructor  Destroy;    override;
    { Public declarations }
  end;
  var WorkView: TfrSPMView;

implementation

uses  math, MDI1, ReadWriteMDTFiles, ReadAndExport;
{$R *.DFM}

procedure TfrSPMView.prilip(var msg: TPrilipalkaMSG);
begin
if lflg=0 then
begin
 if (left>=0) then  left:=msg.mfLeft-width;
 if (msg.mfLeft>width) then  left:=msg.mfLeft-width;
  top:=msg.mfTop;
end;
end;

function TfrSPMView.Stm_ActiveMY:boolean;
var I:Integer;
begin
 result:=false;
 for I := 0 to view_stm.spmfileslist.Count - 1 do
  if STM_active=view_stm.spmfileslist.items[i] then  result:=true;
end;


procedure TfrSPMView.WMMove(var Mes:TWMMove);
begin
//    if Mes.YPos<Main.ToolBar1.Height+10 then Top:=Main.ToolBar1.Height+10;
end;

procedure TfrSPMView.WMSetLBFocus(var AMessage : TMessage);
begin
   lb_preview_active.SetFocus;
end;

procedure TfrSPMView.WMSizing(var Message: TMessage) ;
begin


end;

procedure TfrSPMView.WMExitSizeMove(var Message: TMessage) ;
begin
end; (*WMExitSizeMove*)

procedure TfrSPMView.WMGetMinMaxInfo(var info:TWMGetMinMaxInfo);
 begin
(* with INfo.MinMaxInfo^ do
   begin
    ptMinTrackSize.x:=0;
    ptMinTrackSize.y:=0;
    ptMaxPosition.x:=BoundsRect.Left;
    ptMaxPosition.y:=BoundsRect.Right;
    PtMaxTrackSize.x:=Main.ClientWidth-100;
    ptMaxTrackSize.y:=Main.ClientHeight-100;;
  end;   *)
end;

 function   TfrSPMView.ActivateIcon(filename:string):boolean;
 var mx,i:integer;
   spm_t:   TOne_stm;
 begin
 result:=false;
  for I:=0 to view_stm.spmfileslist.count-1 do
  begin
    spm_t:=TOne_stm(view_stm.spmfileslist.items[i]);
   if spm_t.lname=filename then
    begin
      spm_t.OnActivate;
      //
       if spm_t.Top<0  then
          new_panel.VertScrollBar.Position:=new_panel.VertScrollBar.Position+spm_t.Top
        else
         if spm_t.Top>(new_panel.height-spm_t.height) then
          new_panel.VertScrollBar.Position:= new_panel.VertScrollBar.Position+spm_t.Top;
     //
     application.processmessages;
      break;
    end;
  end;
end;


 constructor  TfrSPMView.Create(AOwner: TComponent;dir:string;{var AFormVar: TfrSPMView;} flg:integer );
var NewItem:TMenuItem;
begin
  lflg:=flg;
  ldir:=dir+'\';
 inherited Create(AOwner);
//  AFormVar := @AFormVar;
//  siLangLinked1.ActiveLanguage:=Lang;     { TODO : 290908 }
  new_panel:= TScrollBox.Create(new_panel);
  new_panel.Parent:= panel_file;
  new_panel.Align:= alClient;
  new_panel.AutoScroll:= true;
  new_panel.ParentBackground:=false;
  if_stm_tree_is:= false;
  if_stm_preview_is:=false;
  Caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* 'Work directory' *) );
  borderstyle:=bsToolWindow;
  bordericons:=[biSystemMenu];
end;

destructor TfrSPMView.Destroy;
begin
//  FormVar^ := nil;
  inherited Destroy;
end;

procedure TfrSPMView.ReDraw;
begin
  Panel_file.Enabled:=False;
  if assigned(View_Stm)    then FreeAndNil(View_Stm);
  if_stm_tree_is:= false;
  NTShellListView.root:=workdirectory;
  NTShellListView.refresh;
 View_Stm:= TMyListView.Create(self.Handle,TPanel(new_panel),workdirectory,NTShellListView,self,0);
  Panel_file.Enabled:=true;
end;

procedure  TfrSPMView.DeActivate;
begin
  if assigned(Stm_Active) then   Stm_Active.Deactivate;
end;

procedure TfrSPMView.Panel_FileResize(Sender: TObject);
begin
 if assigned(view_stm) then view_stm.Change_All(new_panel);
end;


procedure TfrSPMView.FormClose(Sender: TObject; var Action: TCloseAction);
  var FL:File;
    iniCSPM:TiniFile;
     sFile:string;
begin
  if assigned(View_Stm)    then FreeAndNil(view_stm);
  if_close_is:= true;
  FreeAndNil(new_panel);
 if (lflg=0) then
 begin
   DTMainForm.width:= DTMainForm.width+width;
   DTMainForm.Left:=Screen.WorkAreaLeft;
   WorkView:=nil;
  end;
  Action:=caFree;
end;


procedure TfrSPMView.lb_Preview_ActiveKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  InFileName:string;
  now_element: Tone_Stm;
  i,n,k,L: integer;
  h:HWND;
  w:TForm;
begin
  Case Integer(Key) of
 vk_Prior: begin     //Page Up
            new_panel.VertScrollBar.Position:= new_panel.VertScrollBar.Position-Panel_file.Height;
            n:= Trunc(new_Panel.Height/stm_active.Height)* Trunc(new_Panel.Width/stm_active.width);
            now_element:=nil;
           for i:=0 to  view_stm.spmfileslist.count -1 do
            begin
             k:=i;
              now_element:=view_stm.spmfileslist.items[i];
             if stm_active=now_element then  break;
            end;
            if (k<n) then exit
              else   now_element:=view_stm.spmfileslist.items[i-n];
           now_element.OnActivate;
           SetActivePred;
          end;
 vk_Next: begin   //Page Down
            new_panel.VertScrollBar.Position:= new_panel.VertScrollBar.Position+Panel_file.Height;
            n:= Trunc(new_Panel.Height/stm_active.Height)*Trunc(new_Panel.Width/stm_active.width);
            now_element:=nil;
           for i:=0 to  view_stm.spmfileslist.count -1 do
            begin
              k:=i;
              now_element:=view_stm.spmfileslist.items[i];
             if stm_active=now_element then  break;
            end;
              if (k>=view_stm.spmfileslist.count -1-n) then exit
              else   now_element:=view_stm.spmfileslist.items[i+n];
            now_element.OnActivate;
            SetActiveNext;
           end;
  vk_end: if (view_stm<>nil) then
          begin
           now_element:=view_stm.spmfileslist.items[view_stm.spmfileslist.count-1];
           now_element.OnActivate;
           new_panel.VertScrollBar.Position:=new_panel.VertScrollBar.Range;
          end;
 vk_home: begin
           if (view_stm<>nil) then
            begin
             now_element:=view_stm.spmfileslist.items[0];
             now_element.OnActivate;
             new_panel.VertScrollBar.Position:= 0;
            end;
          end;
vk_left:  SetActivePred;
vk_Up:    SetActiveUp;
vk_right: SetActiveNext;
vk_down:  SetActiveDown;
vk_Return: begin  //Enter
           // if (if_stm_preview_is) then
  //          DTMainForm.CreateMDIChild(Sender,Stm_Active.lname{stm_label.Caption},FlgViewDef,false,Stm_Active.flgBrowserMakeRSCorrection);

   ReadData(Stm_Active.lName, FrameDataArray);
  L:=length(FrameDataArray);
 // PrepareMDTData(FrameDataArray[0]);
   for L := Low(FrameDataArray) to High(FrameDataArray) do
   begin
      OpenMDT(FrameDataArray[L], L);
    end;

           end;
vk_Delete: begin   //delete
            InFileName:=Stm_Active.lname;
            if FileExists(InFileName) then
            begin
             if silanglinked1.MessageDlg(siLangLinked1.GetTextOrDefault('IDS_4' (* 'Do you really want to delete ' *) ) +' '+ ExtractFileName(INFileName) + ' ?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
              begin
               DeleteFile(InFileName);
               while FileExists(InFileName) do application.ProcessMessages;
               Redraw;
              //update all form stm_view
              // if assigned(DirView) and (workdirectory=DirView.NTShellTreeView.Path) then   DirView.Redraw
              end;
            end;
           end;
//           end;
                    end;{Case Int(Key) of}
end;

procedure TfrSPMView.SetActiveNext;
var
 now_element: Tone_stm;
 i,k:integer;
begin
 if (view_stm<>nil) then
 begin
  now_element:=nil;
  for i:=0 to  view_stm.spmfileslist.count -1 do
  begin
    k:=i;
    now_element:=view_stm.spmfileslist.items[i];
    if stm_active=now_element then  break;
  end;
 if k= (view_stm.spmfileslist.count-1) then exit
                                       else now_element:=view_stm.spmfileslist.items[k+1];
  now_element.OnActivate;
  new_panel.VertScrollBar.Position:= now_element.top+now_element.Height;
 end;
end;{procedure SetActiveNext}

procedure TfrSPMView.SetActivePred;
var
  now_element: Tone_stm;
  k,i:integer;
begin
if (view_stm<>nil) then
begin
 now_element:=nil;
  for i:=0 to  view_stm.spmfileslist.count -1 do
  begin
    k:=i;
    now_element:=view_stm.spmfileslist.items[i];
    if stm_active=now_element then  break;
  end;
  if k= 0 then exit
          else now_element:=view_stm.spmfileslist.items[k-1];
  now_element.OnActivate;
  new_panel.VertScrollBar.Position:= now_element.top-STM_Active.Height;
end;
(*  if (view_stm<>nil) then now_element:= view_stm.Find_ActiveStm(Stm_Active);
  if (now_element=nil) then exit;
  if (now_element.pred<>nil) and
  (now_element.pred^<>view_stm)
    then now_element:= now_element.pred^;
  now_element.this_stm.OnActivate;

  new_panel.VertScrollBar.Position:= now_element.top_pos-
        view_stm.this_stm.Height;
 *)
end;{procedure SetActivePred}

procedure TfrSPMView.SetActiveUp;
var
  new_top,new_left: integer;
  now_element: Tone_stm;
  k,i:integer;
begin
if (view_stm<>nil) then
begin
    now_element:=nil;
    new_top:=  STM_Active.Top-STM_Active.Height;
    new_left:= STM_Active.Left;
  for i:=0 to  view_stm.spmfileslist.count -1 do
  begin
    k:=i;
    now_element:=view_stm.spmfileslist.items[i];
    if stm_active=now_element then  break;
  end;
    if k=0 then exit;

  while ((now_element.Left<>new_left) or  (now_element.Top<>new_top)) and ((k-1)>=0) do
  begin
    dec(k);
    now_element:= view_stm.spmfileslist.items[k];
  end;
  now_element.OnActivate;
  new_panel.VertScrollBar.Position:=new_panel.VertScrollBar.Position-now_element.height; // now_element.top;
end;
(*  if (view_stm<>nil) then now_element:= view_stm.Find_ActiveStm(Stm_Active);
  if (now_element=nil) then exit;

  new_top:=  now_element.this_stm.Top-view_stm.this_stm.Height;
    new_left:= now_element.this_stm.Left;

  while ((now_element.this_stm.Left<>new_left) or
  (now_element.this_stm.Top<>new_top)) and (now_element.pred^<>view_stm) do
    now_element:= now_element.pred^;

  now_element.this_stm.OnActivate;

  new_panel.VertScrollBar.Position:= now_element.top_pos;

  *)
end;procedure TfrSPMView.siLangLinked1ChangeLanguage(Sender: TObject);
begin
//siLangLinked1.ActiveLanguage:=Lang;
   case  lflg of
1,2:        //browser
  begin
   Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Scans browser' *) );//DirViewCaption;
  end;
0:  //work dir
   begin
      Caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* 'Work directory' *) );
    end;
         end;

end;

{procedure SetActiveUp}

procedure TfrSPMView.SetActiveDown;
var
  new_top,new_left: integer;
  now_element: Tone_stm;
  k,i:integer;
begin
 if (view_stm<>nil) then
begin
    now_element:=nil;
    new_top:=  STM_Active.Top+STM_Active.Height;
    new_left:= STM_Active.Left;
  for i:=0 to  view_stm.spmfileslist.count -1 do
  begin
    k:=i;
    now_element:=view_stm.spmfileslist.items[i];
    if stm_active=now_element then  break;
  end;

  if k=(view_stm.spmfileslist.count -1) then exit;

 while ((now_element.Left<>new_left) or  (now_element.Top<>new_top)) and ((k+1)<=(view_stm.spmfileslist.count-1)) do
  begin
    inc(k);
    now_element:= view_stm.spmfileslist.items[k];
   //+STM_Active.Height;
  end;
  now_element.OnActivate;
  new_panel.VertScrollBar.Position:= new_panel.VertScrollBar.Position+now_element.height;
end;(*{ TODO : 091102 }
//  now_element:=TMyListview.Create;
  if (view_stm<>nil) then now_element:= view_stm.Find_ActiveStm(Stm_Active);
  if (now_element=nil) then exit;

  new_top:=  now_element.this_stm.Top+view_stm.this_stm.Height;
  new_left:= now_element.this_stm.Left;

  while ((now_element.this_stm.Left<>new_left) or
 (now_element.this_stm.Top<>new_top)) and (now_element.next<>nil) do
    now_element:= now_element.next^;

 now_element.this_stm.OnActivate;

 new_panel.VertScrollBar.Position:= now_element.top_pos;
  *)
end;{procedure SetActiveDown}


procedure TfrSPMView.lb_Preview_ActiveEnter(Sender: TObject);
var
  now_element: TMyListview;
begin
 (*  if (view_stm<>nil) then now_element:= view_stm.Find_ActiveStm(Stm_Active);
    if (now_element<>nil) then
    begin
      now_element.this_stm.OnActivate;
      new_panel.VertScrollBar.Position:= now_element.top_pos;
    end
    else
    begin
      if (view_stm.next<>nil) then
        view_stm.next.this_stm.OnActivate
      else     Stm_Active := nil;
      new_panel.VertScrollBar.Position:= 0;
    end;
 *)
end;

procedure TfrSPMView.lb_preview_activeExit(Sender: TObject);
begin
 if assigned(Stm_Active) then   Stm_Active.DeActivate;
end;


procedure TfrSPMView.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
var  n,I:integer;
InFileName:string;
begin
(*if (ssCtrl in Shift) then
 begin
 if (Key=ord('D')) then
  begin
   with NTShellListView do
   begin
    i:= -1;
    for i:= Items.Count-1 downto 0 do
    begin
        InFileName:=NTShellListView.Folders[i].PathName;
        if FileExists(InFileName) then
            begin
         //    if MessageDlg('Do you really want to delete ' + ExtractFileName(INFileName) + '?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
               DeleteFile(InFileName);
            end;
     end;
    end; //with
    ReDraw
   end;
  end;
  *)
end;

procedure TfrSPMView.myFormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
var  n,i,k:integer;
InFileName:string;
now_element:Tone_stm;
begin
 Case Integer(Key) of
 vk_Prior: begin     //Page Up
            new_panel.VertScrollBar.Position:=new_panel.VertScrollBar.Position-Panel_find.Height;
            n:= Trunc(new_Panel.Height/stm_active.Height)*Trunc(new_Panel.Width/stm_active.width);
      //     if (view_stm<>nil) then now_element:= view_stm.Find_ActiveStm(Stm_Active);
            if  view_stm.spmfileslist.count>n then
            begin
             now_element:=view_stm.spmfileslist.items[n-1];
             stm_active:=now_element;
            end;
            SetActiveNext;
            now_element:=view_stm.spmfileslist.items[n-1];
            now_element.OnActivate;
            SetActivePred;
          end;
 vk_Next: begin   //Page Down
            new_panel.VertScrollBar.Position:= new_panel.VertScrollBar.Position+Panel_find.Height;
            n:= Trunc(new_Panel.Height/stm_active.Height)*Trunc(new_Panel.Width/stm_active.width);
        (*    if (view_stm<>nil) then now_element:= view_stm.Find_ActiveStm(Stm_Active);
            for i:= 1 to (n-1) do
            if (now_element.next=nil) then break
                                      else now_element:= now_element.next^;
            now_element.this_stm.OnActivate;  *)
            now_element:=nil;
            for i:=0 to  view_stm.spmfileslist.count -1 do
            begin
               now_element:=view_stm.spmfileslist.items[i];
               if stm_active=now_element then  break;
            end;
             for k:= 1 to (n-1) do
              if (i=view_stm.spmfileslist.count -1) then break
                                                    else now_element:=view_stm.spmfileslist.items[i+1];
             now_element.OnActivate;
             SetActiveNext;
           end;
  vk_right: SetActiveNext;
                   end;
(* if (ssCtrl in Shift) then
 begin
 if (Key=ord('D')) then
  begin
   with stm_ListBox do
   begin
    i:= -1;
    for i:= Items.Count-1 downto 0 do
    begin
        InFileName:=stm_ListBox.Items[i];
        if FileExists(InFileName) then
            begin
         //    if MessageDlg('Do you really want to delete ' + ExtractFileName(INFileName) + '?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
               DeleteFile(InFileName);
            end;
     end;
    end; //with
     DirView.ReDraw
   end;
  end;
  *)
end;

procedure TfrSPMView.NTShellListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
if lflg=0 then Redraw;
end;

procedure TfrSPMView.NTShellListViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var  n,I:integer;
InFileName:string;
begin
if (ssCtrl in Shift) then
 begin
 if (Key=ord('D')) then
  begin
   with NTShellListView do
   begin
    i:= -1;
    for i:= Items.Count-1 downto 0 do
    begin
        InFileName:=NTShellListView.Folders[i].PathName;
        if FileExists(InFileName) then
            begin
         //    if MessageDlg('Do you really want to delete ' + ExtractFileName(INFileName) + '?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
               DeleteFile(InFileName);
            end;
     end;
    end; //with
 //    DirView.ReDraw
   end;
  end;
end;


procedure TfrSPMView.FormShow(Sender: TObject);
begin
 Panel_find.visible:=false;
 NTShellListView.root:=Ldir;
if not assigned(view_stm) then
  view_stm:= TMyListview.Create(self.Handle,Tpanel(new_panel),ldir,NTShellListView,self,lflg);
 if assigned(view_stm) then view_stm.Change_All(new_panel);
end;


(*procedure TfrSPMView.Splitter_FilePaint(Sender: TObject);
begin
  if stm_DirectoryListBox.Height<70 then  stm_DirectoryListBox.Height:= 70;
  if lflg then STM_Preview.ResizePreview;
end;*)

(*procedure TfrSPMView.Splitter_ViewPaint(Sender: TObject);
begin
  if panel_find.Width<40 then   panel_find.Width:= 40;
  if lflg then STM_Preview.ResizePreview;
end;
 *)
procedure  TfrSPMView.ChangeDirectory(flgPositionEnd:boolean);
var hMenuHandle:HMENU;
    hMainMenuHandle:HMENU;
    curdir:string;
begin
  ForceCurrentDirectory :=True;
  SetCurrentDir(workdirectory);
  curdir:=GetCurrentDir;    { TODO : 220108 }
  Panel_file.Enabled:=False;
  if assigned(View_Stm)    then FreeAndNil(View_Stm);
  if_stm_tree_is:= false;
  NTShellListView.refresh;
 View_Stm:= TMyListView.Create(self.Handle,TPanel(new_panel),workdirectory,NTShellListView,self,0);
  case flgPositionEnd of
true:   new_panel.VertScrollBar.Position:=new_panel.VertScrollBar.Range;
false:  new_panel.VertScrollBar.Position:=0;
  end;
    Panel_file.Enabled:=true;
end;

end.
