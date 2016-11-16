//161202   programmer student Zotin

unit frStm_see;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, FileCtrl, Tabs, ComCtrls, Grids{, Outline, DirOutLn},
  ExtCtrls, ExtDlgs, Tree_view, inifiles,cspmvar, siComp, siLngLnk;
type
  TfrSPMView = class(TForm)
    Panel_find: TPanel;
    stm_DirectoryListBox: TDirectoryListBox;
    stm_ListBox: TFileListBox;
    stm_filter: TFilterComboBox;
    Splitter_view: TSplitter;
    Splitter_file: TSplitter;
    stm_DriveComboBox: TDriveComboBox;
    Panel_file: TPanel;
    lb_preview_active: TListBox;
    siLangLinked1: TsiLangLinked;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Stm_ListBoxChange(Sender: TObject);
    procedure Panel_FileResize(Sender: TObject);
    procedure Stm_DirectoryListBoxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Stm_DirectoryListBoxClick(Sender: TObject);
    procedure lb_preview_activeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lb_preview_activeEnter(Sender: TObject);
    procedure lb_preview_activeExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Splitter_viewMoved(Sender: TObject);
    procedure Splitter_fileMoved(Sender: TObject);
  private
    lflg:integer;
    szpreview:integer;
    ldir:string;
    FormVar: ^TfrSPMView;
    view_stm: TMyListView;
    PanelPrevView:Tpanel;
    procedure SetActiveNext;
    procedure SetActivePred;
    procedure SetActiveUp;
    procedure SetActiveDown;
    procedure WMMove(var Mes:TWMMove);                    message WM_Move;
    procedure WMChangePreview(var AMessage : TMessage);   message WM_UserChangePreview;
    procedure WMSetLBFocus(var AMessage : TMessage);      message WM_UserLBViewFocus;
    procedure myFormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure WMSizing(var Message: TMessage) ;           message WM_SIZING;
    procedure WMExitSizeMove(var Message: TMessage) ;     message WM_EXITSIZEMOVE;
    procedure WMGetMinMaxInfo(var info:TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure Prilip(var msg: TPrilipalkaMSG);message CM_PrilipalkaMove;
    function  Stm_ActiveMY:boolean;
    procedure ResizePreview;
    { Private declarations }
  public
    new_panel: TScrollBox;
    procedure ChangePreview;
    procedure ReDraw;
    procedure ChangeDirectory(flgPositionEnd:boolean);
     constructor Create(AOwner: TComponent;dir:string; var AFormVar: TfrSPMView;   flg:integer);//flg=0 work ; =1 open ;  =2 gallery
     destructor  Destroy;    override;
    { Public declarations }
  end;
var
          DirView:TfrSPMView;
implementation

uses  math,GlobalVar,mMain, frNoFormUnitLoc;
{$R *.DFM}

procedure TfrSPMView.prilip(var msg: TPrilipalkaMSG);
begin
if  lflg=0 then
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
procedure TfrSPMView.WMChangePreview(var AMessage : TMessage);
begin
  ChangePreview;
end;
procedure TfrSPMView.WMSetLBFocus(var AMessage : TMessage);
begin
   lb_preview_active.SetFocus;
end;
procedure TfrSPMView.WMSizing(var Message: TMessage) ;
begin
 //
end;

procedure TfrSPMView.WMExitSizeMove(var Message: TMessage) ;
begin
 //
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
constructor  TfrSPMView.Create(AOwner: TComponent;dir:string;var AFormVar: TfrSPMView; flg:integer );
var NewItem:TMenuItem;
begin
 lflg:=flg;
 ldir:=dir+'\';
 FormVar := @AFormVar;
 inherited Create(AOwner);
 siLangLinked1.ActiveLanguage:=Lang;     { TODO : 290908 }
//  ForceCurrentDirectory :=True;
//  SetCurrentDir(dir);
//
//  stm_DirectoryListBox.Directory:=dir;
  //
  new_panel:= TScrollBox.Create(new_panel);
  new_panel.Parent:= panel_file;
  new_panel.Align:= alClient;
  new_panel.AutoScroll:= true;
//  Splitter_file.Align:= alTop;
  if_stm_tree_is:= false;
  if_stm_preview_is:=false;


  Splitter_file.Align:= alTop;


case  lflg of
2:        //gallery
  begin
   Top:=TopStart;
   Left:=LeftStart;
   panel_find.width:=(width div 2) ;
   Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Scans browser' *) );//DirViewCaption;
   stm_DriveComboBox.visible:= false;
   stm_DirectoryListBox.Align:= alTop;
   stm_DirectoryListBox.Height:=(Panel_find.Height div 8)*3;
  end;
1:        //browser
  begin
   Top:=TopStart;
   Left:=LeftStart;
   panel_find.width:=(width div 2) ;
   Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Scans browser' *) );//DirViewCaption;
   stm_DriveComboBox.Align:= alTop;
   stm_DirectoryListBox.Align:= alTop;
   stm_DirectoryListBox.Height:=(Panel_find.Height div 8)*3;
  end;
0:  //work dir
   begin
      Caption:=siLangLinked1.GetTextOrDefault('IDS_1' (* 'Work directory' *) );
 //     panel_find.visible:=false;
      Formstyle:=fsStayOnTop;
      borderstyle:=bsToolWindow;
      bordericons:=[biSystemMenu];
    end;
         end;
         (*

  view_stm:= TMyListview.Create(self.Handle,Tpanel(new_panel),dir,stm_ListBox,self,lflg);

  if assigned(Stm_Active) and (lflg>0) then
   begin
    PanelPrevView:=TPanel.Create(self);
    PanelPrevView.ControlStyle :=  PanelPrevView.ControlStyle  + [csOpaque];
    PanelPrevView.Parent:=panel_find;
    PanelPrevView.Visible:=true;
    PanelPrevView.Align:= alClient;
    szpreview:=min( Splitter_view.Left,Splitter_file.top);
    Stm_Preview:= TPreview.Create(Stm_Active.lname,Self.Handle,szpreview,Self,true);
    Stm_Preview.Parent:=PanelPrevView;
    Stm_Preview.Align:= alClient;
    Stm_Preview.Stm_ImageDraw;
    if_stm_preview_is:=true;
    if_stm_active_is:= true;
   end;
*)
     Application.ProcessMessages;
     NewItem := TMenuItem.Create(Self);
     NewItem.Caption := '-';
     Main.mWindows.Add(NewItem);
     NewItem := TMenuItem.Create(Self);
     NewItem.Caption := Self.Caption;
     NewItem.OnClick:=Main.ActivateMenuItem;
     Main.mWindows.Add(NewItem);
 //    self.Caption:=DirViewCaption ;
end;

destructor TfrSPMView.Destroy;
begin
  FormVar^ := nil;
  inherited Destroy;
end;


procedure TfrSPMView.ReDraw;
begin
             if lflg>0 then   // explorer
               begin
                   Stm_ListBox.Update;
                   Stm_DirectoryListBox.Update ;
               end
               else
               begin       //workview
                if assigned(View_Stm)    then
                begin
                    ChangeDirectory(true);
                end;
              end;
end;
 procedure TfrSPMView.ResizePreview;
begin
if assigned(Stm_Preview) then
 begin
 if (Stm_Preview.width>(Stm_Preview.Height-Stm_Preview.stm_label.Height))
  then
   begin
     Stm_Preview.stm_image.Top:= field;
     Stm_Preview.stm_image.Left:= field+(Stm_Preview.Width-Stm_Preview.Height + Stm_Preview.stm_label.Height) div 2;
     Stm_Preview.stm_image.Width:= (Stm_Preview.Height - Stm_Preview.stm_label.Height) -2*field;
     Stm_Preview.stm_image.Height:= Stm_Preview.stm_image.Width;
     Stm_Preview.one_image_size:= Stm_Preview.stm_image.Width;
   end
  else
   begin
    Stm_Preview.stm_image.Left:= field;
    Stm_Preview.stm_image.Width:= Stm_Preview.Width-2*field;
    Stm_Preview.stm_image.Height:=round(Stm_Preview.stm_image.Width*Stm_Active.stm_image.Height/Stm_Active.stm_image.Width);
    Stm_Preview.one_image_size:= Stm_Preview.stm_image.Width;
    Stm_Preview.stm_image.Top:= field+(Stm_Preview.Height-Stm_Preview.stm_label.Height- Stm_Preview.Width) div 2;
   end;
 end;
end;
procedure TfrSPMView.ChangePreview;
begin
(*if assigned(Stm_Preview) then
begin
  ResizePreview;
  if assigned(STM_Active) and Stm_ActiveMY then
  begin
    STM_Preview.stm_image.picture.assign(STM_Active.stm_image.Picture.BitMap);
    STM_Preview.SetOneStmPosition(STM_Preview,Stm_Active.stm_image.Width,Stm_Active.stm_image.Height);
    STM_Preview.Repaint;
  end;
 end
*)
 end;

procedure TfrSPMView.stm_ListBoxChange(Sender: TObject);
begin
 inherited;
    {with stm_ListBox do begin
    panel_file.Caption:= '';
    ItemIndex:= -1;
    if (Items.Count<>0) then
    repeat
      panel_file.Caption:= panel_file.Caption +
                           Items[ItemIndex+1]+' ';
      ItemIndex:= ItemIndex+1;
    until (ItemIndex>=Items.Count-1);
  end;}
end;

procedure TfrSPMView.Panel_FileResize(Sender: TObject);
begin
  if if_stm_tree_is then view_stm.Change_All(new_panel);
end;

procedure TfrSPMView.stm_DirectoryListBoxChange(Sender: TObject);
var hMenuHandle:HMENU;
    hMainMenuHandle:HMENU;
    curdir:string;
begin
  stm_DirectoryListBox.Enabled:= false;
  Panel_file.Enabled:=False;
 //  OpenDirectory:=GetCurrentDir;
  curdir:=GetCurrentDir;//OpenDirectory;
 // OpenDirectory:=GetCurrentDir;
  hMenuHandle:=GetSystemMenu(self.handle,false);
  hMainMenuHandle:=GetSystemMenu(Main.handle,false);
 if (hMenuHandle<>0)      then EnableMenuItem( hMenuHandle,SC_CLOSE,MF_DISABLED);
 if (hMainMenuHandle<>0)  then EnableMenuItem( hMainMenuHandle,SC_CLOSE,MF_DISABLED);
 if assigned(View_Stm)    then FreeAndNil(View_Stm);
 if  (lflg>0) then    { TODO : 121008 }
    if assigned(Stm_Preview) then FreeAndNil(Stm_preview);

  if_stm_tree_is:= false;

  View_Stm:= TMyListView.Create(self.Handle,Tpanel(new_panel),curdir,stm_ListBox,self,lflg);
 if   assigned(STM_Active) and (lflg>0) then
 begin
    szpreview:=min( Splitter_view.Left,Splitter_file.top);
    Stm_Preview:= TPreview.Create(Stm_Active.lname,Stm_Active.lgrandfather,szpreview,self,true);
    Stm_Preview.Parent:= panel_find;
//    Stm_Preview.stm_label.Caption:=ExtractFileName(Stm_Active.lname);
    Stm_Preview.Align:= alClient;
    Stm_Preview.color:=$00DCDDDB;
//    Stm_Preview.stm_image.Stretch:= true;
    Stm_Preview.Stm_ImageDraw;

 end;
//  if view_stm.spmfileslist.count>0 then  Stm_Active:= view_stm.spmfileslist.items[0];
  if (hMenuHandle<>0)     then EnableMenuItem( hMenuHandle,SC_CLOSE,MF_ENABLED);
  if (hMainMenuHandle<>0) then EnableMenuItem( hMainMenuHandle,SC_CLOSE,MF_ENABLED);
  Panel_file.Enabled:=True;
  stm_DirectoryListBox.Enabled:= true;
  stm_DirectoryListBox.SetFocus;
end;


procedure TfrSPMView.FormClose(Sender: TObject; var Action: TCloseAction);
  var FL:File;
    iniCSPM:TiniFile;
     sFile:string;
begin
if lflg>0 then
 begin
 sFile:=ConfigUsersIniFilePath + ConfigUsersIniFile;
 if (not FileExists(sFile)) then
  begin
    AssignFile(FL,sFile);
    Rewrite(FL);
    CloseFile(FL);
  end;
//  SetFileAttribute_ReadOnly(sfile,false);
  iniCSPM:=TIniFile.Create(sFile);
 try
  iniCSPM.WriteString('Files','View Directory',OpenDirectory);
 finally
  iniCSPM.Free;
 end;
//  SetFileAttribute_ReadOnly(sfile,true);
 if assigned(Stm_Preview) then FreeAndNil(Stm_Preview);
//  Main.OpenItem.Enabled:=True;
  Main.ActionOpen.Enabled:=True;
  Main.ActionOpen.visible:=true;
 end;
   if assigned(View_Stm)    then FreeAndNil(view_stm);
  if_close_is:= true;
 if  lflg=0 then
  begin
   Main.width:= Main.width+width;
   Main.Left:=Screen.WorkAreaLeft;
//   main.btnViewWork.visible:=true;
//   main.btnViewWork.down:=false;
  end;
 if not( lflg=2) then
 begin
  OpenDirectory:=GetCurrentDir;
 end;
  FreeAndNil(new_panel);
  Action:=caFree;
end;



procedure TfrSPMView.stm_DirectoryListBoxClick(Sender: TObject);
begin
{ TODO : 070604 }
 // OpenDirectory:=GetCurrentDir;
  OPenDirectory:=GetCurrentDir;//OpenDirectory;
  {if not(if_stm_active_is) then
    stm_DirectoryListBox.Items.Delete
                (stm_DirectoryListBox.Items.Count-1);

  if_stm_active_is:= true;}
end;

procedure TfrSPMView.lb_Preview_ActiveKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  InFileName:string;
  now_element: Tone_Stm;
  i,n,k: integer;
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
            Main.CreateMDIChild(Sender,Stm_Active.stm_label.Caption,FlgViewDef,false);
           end;
vk_Delete: begin   //delete
            InFileName:=Stm_Active.lname;
            if FileExists(InFileName) then
            begin
             if NoFormUnitLoc.siLang1.MessageDlg(siLangLinked1.GetTextOrDefault('IDS_4' (* 'Do you really want to delete ' *) ) + ExtractFileName(INFileName) + '?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
              begin
               DeleteFile(InFileName);
               while FileExists(InFileName) do application.ProcessMessages;
              Redraw;
              //update all form stm_view
              case lflg of
           0:
                  for i := Main.MDIChildCount-1 downto 0 do
                  begin
                   if  (Main.MDIChildren[I] is TfrSPMView) and (Main.MDIChildren[I]<>self) and (workdirectory=opendirectory) then
                   begin (Main.MDIChildren[I] as TfrSPMView).ReDraw; break; end;
                  end;
           1:
                  for  i := 0 to Screen.FormCount-1 do
                   begin
                      w:= Screen.Forms[i];
                      if (w is TfrSPMView) and (w<>self)and (workdirectory=opendirectory) then
                       begin TfrSPMView(w).Redraw; Break; end;
                   end;
                             end;
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
siLangLinked1.ActiveLanguage:=Lang;
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
if (ssCtrl in Shift) then
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
 //    DirView.ReDraw
   end;
  end;
end;

procedure TfrSPMView.FormResize(Sender: TObject);
begin
 if (lflg>0) and assigned(Stm_Preview) then Stm_Preview.ResizePreview;//Stm_ImageDraw;
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
procedure TfrSPMView.FormShow(Sender: TObject);
begin
if Directoryexists(ldir)  then
begin
   stm_DriveComboBox.Drive:=extractfiledrive(ldir)[1];
   stm_DirectoryListBox.directory:=extractfiledir(ldir);
end;
  application.processmessages;
if not assigned(view_stm) then
  view_stm:= TMyListview.Create(self.Handle,Tpanel(new_panel),ldir,stm_ListBox,self,lflg);
  if assigned(Stm_Active) and (lflg>0) and ( not assigned(Stm_Preview)) then
   begin
    PanelPrevView:=TPanel.Create(self);
    PanelPrevView.ControlStyle :=  PanelPrevView.ControlStyle  + [csOpaque];
    PanelPrevView.Parent:=panel_find;
    PanelPrevView.Visible:=true;
    PanelPrevView.Align:= alClient;
    szpreview:=min( Splitter_view.Left,Splitter_file.top);
    Stm_Preview:= TPreview.Create(Stm_Active.lname,Self.Handle,szpreview,Self,true);
    Stm_Preview.Parent:=PanelPrevView;
    Stm_Preview.Align:= alClient;
    Stm_Preview.Stm_ImageDraw;
    if_stm_preview_is:=true;
    if_stm_active_is:= true;
   end;
 if assigned(view_stm) then view_stm.Change_All(new_panel);
 if (lflg>0)  and assigned(Stm_active) then
    if Stm_ActiveMY then Stm_Active.StmLeftClick(Sender);
 if lflg=0 then   panel_find.visible:=false;
end;

procedure TfrSPMView.Splitter_viewMoved(Sender: TObject);
begin
 szpreview:=min( Splitter_view.Left,Splitter_file.top);
  if panel_find.Width<60 then   panel_find.Width:= 60;
  if (lflg>0) and assigned(Stm_Preview)then STM_Preview.ResizePreview;
end;

procedure TfrSPMView.Splitter_fileMoved(Sender: TObject);
begin
 szpreview:=min( Splitter_view.Left,Splitter_file.top);
 if stm_DirectoryListBox.Height<70 then  stm_DirectoryListBox.Height:= 70;
 if (lflg>0) and assigned(Stm_Preview)then STM_Preview.ResizePreview;
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
  stm_ListBox.update;
 View_Stm:= TMyListView.Create(self.Handle,TPanel(new_panel),curdir,stm_ListBox,self,0);
  Panel_file.Enabled:=true;
  case flgPositionEnd of
true:   new_panel.VertScrollBar.Position:=new_panel.VertScrollBar.Range;
false:  new_panel.VertScrollBar.Position:=0;
  end;
end;

end.
