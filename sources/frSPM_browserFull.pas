unit frSPM_browserFull;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Menus,  frSPM_browser, ComCtrls, NTShellCtrls, siComp, siLngLnk, StdCtrls,
  FileCtrl, ExtCtrls,Inifiles,Cspmvar,Spm_BrowserClasses, Buttons,NTShellConsts,
  ToolWin, siDialog;

type
  TfrSPMViewFull = class(TfrSPMView)
    PanelTree: TPanel;
    PanelComboBox: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    NTShellComboBox: TNTShellComboBox;
    NTShellTreeView: TNTShellTreeView;
    BitBtnWorkdir: TBitBtn;
    BitBtnGalDir: TBitBtn;
    FilterComboBox: TFilterComboBox;
    LabelFiltr: TLabel;
    LabelDir: TLabel;
    procedure NTShellTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure Splitter_viewMoved(Sender: TObject);
    procedure Splitter_fileMoved(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NTShellComboBoxChange(Sender: TObject);
    procedure Panel_FileResize(Sender: TObject);
    procedure NTShellTreeViewExpanded(Sender: TObject; Node: TTreeNode);
    procedure BitBtnWorkdirClick(Sender: TObject);
    procedure BitBtnGalDirClick(Sender: TObject);
    procedure FilterComboBoxChange(Sender: TObject);
    procedure lb_preview_activeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure NTShellListViewDblClick(Sender: TObject);
    procedure ToolBtnDelClick(Sender: TObject);
    procedure ToolBtnSaveAsClick(Sender: TObject);
    procedure NTShellTreeViewRenameFile(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    szpreview:integer;
 //  flgFltr:integer;
//   view_stm: TMyListView;
    PanelPrevView:Tpanel;
   procedure ResizePreview;
   procedure WMChangePreview(var AMessage : TMessage);   message WM_UserChangePreview;
  public
    { Public declarations }
  constructor Create(AOwner: TComponent;dir:string;  flg:integer);//flg=0 work ; =1 open ;  =2 gallery
//  destructor  Destroy;    override;
  procedure   ChangePreview;
  procedure   Redraw;
  procedure   DeviceEnbmChanged;
end;




implementation

uses math,mMain,GlobalVar,GlobalFunction,uFileOp, frNoFormUnitLoc;

{$R *.dfm}
 constructor  TfrSPMViewFull.Create(AOwner: TComponent;dir:string;flg:integer );
var NewItem:TMenuItem;
begin
   lflg:=flg;
   ldir:=dir+'\';
 inherited Create(AOwner,dir,flg);
   width:=700;
   height:=600;
   borderstyle:=bsSizeable;
   siLangLinked1.ActiveLanguage:=Lang;     { TODO : 290908 }
   Splitter_file.Align:= alTop;
    labelfiltr.visible:=false;
    FilterComboBox.itemindex:=0;//spm
    flgFilterExt:=FilterComboBox.itemindex;
    FilterComboBox.visible:=false;
// {$IFDEF FULL}
    labelfiltr.visible:=true;
    FilterComboBox.visible:=true;
// {$ENDIF}
   panel_file.visible:=true;
   panel_file.align:=alclient;
   Top:=TopStart;
   Left:=LeftStart;
   panel_find.width:=(width div 2) ;
   Caption:=siLangLinked1.GetTextOrDefault('IDS_0' (* 'Scans browser' *) );//DirViewCaption;
   PanelTree.Height:=(Panel_find.Height div 2);
case  lflg of
2:begin   //gallery
    PanelComboBox.Visible:=false;
    NTShellComboBox.visible:= false;
    Labeldir.visible:=false;
    BitBtnWorkdir.visible:=false;
    BitBtnGalDir.visible:=false;
  end;
        end;
//    NTShellListView.AutoRefresh:=true;
    PanelPrevView:=TPanel.Create(panel_find);
    PanelPrevView.ControlStyle :=  PanelPrevView.ControlStyle  + [csOpaque];
    PanelPrevView.Parent:=panel_find;
    PanelPrevView.parentbackground:=false;
    PanelPrevView.Visible:=true;
    PanelPrevView.Align:=alClient;

     NewItem := TMenuItem.Create(Self);
     NewItem.Caption := '-';
     Main.mWindows.Add(NewItem);
     NewItem := TMenuItem.Create(Self);
     NewItem.Caption := Self.Caption;
     NewItem.OnClick:=Main.ActivateMenuItem;
     Main.mWindows.Add(NewItem);
     Application.ProcessMessages;
     NewItem := TMenuItem.Create(Self);
     NewItem.Caption := '-';
     Main.mWindows.Add(NewItem);
     NewItem := TMenuItem.Create(Self);
     NewItem.Caption := Self.Caption;
     NewItem.OnClick:=Main.ActivateMenuItem;
     Main.mWindows.Add(NewItem);
end;

(*destructor TfrSPMViewFull.Destroy;
begin
  inherited Destroy;
end;  *)
procedure TfrSPMViewFull.DeviceEnbmChanged;
 begin



 end;
procedure TfrSPMViewFull.ResizePreview;
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

procedure TfrSPMViewFull.BitBtnWorkdirClick(Sender: TObject);
begin
  inherited;
 NTShellTreeView.path:=workdirectory;
end;

procedure TfrSPMViewFull.BitBtnGalDirClick(Sender: TObject);
begin
  inherited;
  NTShellTreeView.path:=ScanGalleryDir;
end;

procedure TfrSPMViewFull.ChangePreview;
begin
end;

procedure TfrSPMViewFull.WMChangePreview(var AMessage : TMessage);
begin
  ChangePreview;
end;

procedure TfrSPMViewFull.Redraw;
begin
  Panel_file.Enabled:=False;
  if assigned(View_Stm)    then FreeAndNil(View_Stm);
  if assigned(Stm_Preview) then FreeAndNil(Stm_preview);
  if_stm_tree_is:= false;
  NTShellListView.refresh;
  View_Stm:= TMyListView.Create(self.Handle,TPanel(new_panel),NTShellTreeView.Path,NTShellListView,self,1);
 if   assigned(STM_Active)  then
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
 Panel_file.Enabled:=true;
end;

procedure TfrSPMViewFull.FilterComboBoxChange(Sender: TObject);
var
  Filter: TStrings;
  dir:string;
  hMenuHandle:HMENU;
  hMainMenuHandle:HMENU;
begin
   inherited;
   Filter := TStringList.Create;
  case FilterComboBox.ItemIndex of
    0:begin if assigned(Stm_Preview) then Stm_Preview.Visible:=true;   Filter.Text := '*.spm' + #13 + '*.mspm'; end;
    1:begin if assigned(Stm_Preview) then Stm_Preview.Visible:=false;  Filter.Text := '*.bmp' + #13 + '*.jpg';  end;
    2:begin if assigned(Stm_Preview) then Stm_Preview.Visible:=false;  Filter.Text := '*.*';                    end;
  end;
   flgFilterExt:=FilterComboBox.ItemIndex;
   NTShellListView.FileMasks := Filter;
  Panel_file.Enabled:=False;
  hMenuHandle:=GetSystemMenu(self.handle,false);
  hMainMenuHandle:=GetSystemMenu(Main.handle,false);
 if (hMenuHandle<>0)      then EnableMenuItem( hMenuHandle,SC_CLOSE,MF_DISABLED);
 if (hMainMenuHandle<>0)  then EnableMenuItem( hMainMenuHandle,SC_CLOSE,MF_DISABLED);

   NTShellListView.Refresh;
   Application.processmessages;
     if assigned(View_Stm)    then FreeAndNil(View_Stm);
 if assigned(Stm_Preview)     then FreeAndNil(Stm_preview);

  if_stm_tree_is:= false;
//  NTShellTreeView.MyRefreshListView;
  dir:=NTShellTreeView.Path;
  View_Stm:= TMyListView.Create(self.Handle,Tpanel(new_panel),dir,NTShellListView,self,lflg);

 if   assigned(STM_Active)  then
 begin
    szpreview:=min( Splitter_view.Left,Splitter_file.top);
    Stm_Preview:= TPreview.Create(Stm_Active.lname,Stm_Active.lgrandfather,szpreview,self,true);
    Stm_Preview.Parent:= panel_find;
    Stm_Preview.parentbackground:=false;
    Stm_Preview.Align:= alClient;
    Stm_Preview.color:=$00DCDDDB;
    Stm_Preview.Stm_ImageDraw;
 end;
  Panel_file.Enabled:=True;
  NTShellTreeView.Enabled:= true;
  Filter.Free;
  if (hMenuHandle<>0)     then EnableMenuItem( hMenuHandle,SC_CLOSE,MF_ENABLED);
  if (hMainMenuHandle<>0) then EnableMenuItem( hMainMenuHandle,SC_CLOSE,MF_ENABLED);
  Panel_file.Enabled:=True;
  if NTShellTreeView.visible then  NTShellTreeView.SetFocus;
end;

procedure TfrSPMViewFull.FormClose(Sender: TObject; var Action: TCloseAction);
 var FL:File;
    iniCSPM:TiniFile;
     sFile:string;
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
  Main.ActionOpen.Enabled:=True;
  Main.ActionOpen.visible:=true;
//  if assigned(View_Stm)    then FreeAndNil(view_stm);
  if_close_is:= true;
  Action:=caFree;
  DirView:=nil;
  inherited;
end;

procedure TfrSPMViewFull.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var  n,I:integer;
InFileName:string;
  w:TForm;
begin
(*Case Integer(Key) of
 vk_Delete:begin   //delete
            InFileName:=Stm_Active.lname;
            if FileExists(InFileName) then
            begin
             if silanglinked1.MessageDlg(siLangLinked1.GetTextOrDefault('IDS_4' { 'Do you really want to delete ' } ) +' '+ ExtractFileName(INFileName) + '?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
              begin
               DeleteFile(InFileName);
               while FileExists(InFileName) do application.ProcessMessages;
               Redraw;
              //update all form stm_view
                 for  i := 0 to Screen.FormCount-1 do
                   begin
                      w:= Screen.Forms[i];
                      if (w is TfrSPMView) and (w<>self)and (workdirectory=opendirectory) then
                       begin TfrSPMView(w).Redraw; Break; end;
                   end;
              end;
            end;
           end;
                   end;{Case Int(Key) of}
*)
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

procedure TfrSPMViewFull.FormResize(Sender: TObject);
begin
 if  assigned(Stm_Preview) then Stm_Preview.ResizePreview;
end;

procedure TfrSPMViewFull.FormShow(Sender: TObject);
begin
if Directoryexists(ldir)  then
  case lflg of
1: begin
    NTShellTreeView.Path:=OpenDirectory;
   end;
2: begin    //gallery
    NTShellComboBox.Root:=ScanGalleryDir;
    NTShellTreeView.Path:=ScanGalleryDir;
   end;
     end;
  NTShellTreeView.SetFocus;
  NTShellListView.Refresh;
end;

procedure TfrSPMViewFull.lb_preview_activeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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
            Main.CreateMDIChild(Sender,Stm_Active.lname{stm_label.Caption},FlgViewDef,false,Stm_Active.flgBrowserMakeRSCorrection);
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
              if assigned(workview) and (workdirectory=NTShellTreeView.Path) then   WorkView.Redraw
              end;
            end;
           end;
//           end;
                    end;{Case Int(Key) of}
end;

(*procedure TfrSPMViewFull.lb_preview_activeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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
            Main.CreateMDIChild(Sender,Stm_Active.stm_label.Caption,FlgViewDef,false,Stm_Active.flgBrowserMakeRSCorrection);
           end;
(*vk_Delete: begin   //delete
            InFileName:=Stm_Active.lname;
            if FileExists(InFileName) then
            begin
             if siLangLinked1.MessageDlg(siLangLinked1.GetTextOrDefault('IDS_4' { 'Do you really want to delete ' } ) +' '+ ExtractFileName(INFileName) + '?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
              begin
               DeleteFile(InFileName);
               while FileExists(InFileName) do application.ProcessMessages;
                Redraw;
              //update all form stm_view
                 for  i := 0 to Screen.FormCount-1 do
                   begin
                      w:= Screen.Forms[i];
                      if (w is TfrSPMView) and (w<>self)and (workdirectory=opendirectory) then
                       begin TfrSPMView(w).Redraw; Break; end;
                   end;
              end;
            end;
           end;*)
(*                    end;{Case Int(Key) of}
end;
*)
procedure TfrSPMViewFull.NTShellComboBoxChange(Sender: TObject);
var hMenuHandle:HMENU;
    hMainMenuHandle:HMENU;
    curdir:string;
begin

end;

procedure TfrSPMViewFull.NTShellListViewDblClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrSPMViewFull.NTShellTreeViewChange(Sender: TObject; Node: TTreeNode);
var hMenuHandle:HMENU;
    hMainMenuHandle:HMENU;
    curdir,dir:string;
    str:string;
    flg:boolean;
begin
  NTShellTreeView.Enabled:= false;
//if flgFilterExt=0  then  040512
begin
  Panel_file.Enabled:=False;
  hMenuHandle:=GetSystemMenu(self.handle,false);
  hMainMenuHandle:=GetSystemMenu(Main.handle,false);
 if (hMenuHandle<>0)      then EnableMenuItem( hMenuHandle,SC_CLOSE,MF_DISABLED);
 if (hMainMenuHandle<>0)  then EnableMenuItem( hMainMenuHandle,SC_CLOSE,MF_DISABLED);

 if assigned(View_Stm)    then FreeAndNil(View_Stm);
 if assigned(Stm_Preview) then FreeAndNil(Stm_preview);

  if_stm_tree_is:= false;

   dir:=NTShellTreeView.Path;
   if  pos(LowerCase(ScanGalleryDir),LowerCase(dir)) =0 then
     OpenDirectory:=dir;

   NTShellTreeView.MyRefreshListView;

  View_Stm:= TMyListView.Create(self.Handle,Tpanel(new_panel),dir,NTShellListView,self,lflg);

 if   assigned(STM_Active)  then
 begin
    szpreview:=min( Splitter_view.Left,Splitter_file.top);
    Stm_Preview:= TPreview.Create(Stm_Active.lname,Stm_Active.lgrandfather,szpreview,self,true);
    Stm_Preview.Parent:= panel_find;
    Stm_Preview.parentbackground:=false;
    Stm_Preview.Align:= alClient;
    Stm_Preview.color:=$00DCDDDB;
    Stm_Preview.Stm_ImageDraw;
 end;
  if (hMenuHandle<>0)     then EnableMenuItem( hMenuHandle,SC_CLOSE,MF_ENABLED);
  if (hMainMenuHandle<>0) then EnableMenuItem( hMainMenuHandle,SC_CLOSE,MF_ENABLED);
  Panel_file.Enabled:=True;
end;//flgfltr=0
  NTShellTreeView.Enabled:= true;
 if NTShellTreeView.visible then  NTShellTreeView.SetFocus;
end;



procedure TfrSPMViewFull.NTShellTreeViewExpanded(Sender: TObject;
  Node: TTreeNode);
begin
//

end;

procedure TfrSPMViewFull.NTShellTreeViewRenameFile(Sender: TObject;
  Node: TTreeNode);
begin
    if assigned(view_stm)    then FreeAndNil(view_stm);
    if assigned(stm_preview) then FreeAndNil(stm_preview);
  inherited;
   NTShellTreeView.reset;
  Redraw;
end;
procedure TfrSPMViewFull.Panel_FileResize(Sender: TObject);
begin
if FilterComboBox.ItemIndex=0 then
  begin
   if assigned(view_stm) then view_stm.Change_All(new_panel)
  end
  else
   if NTShellListView.Items.count>0 then NTShellListView.Repaint;
end;

procedure TfrSPMViewFull.Splitter_FileMoved(Sender: TObject);
begin
 szpreview:=min( Splitter_view.Left,Splitter_file.top);
 if  assigned(Stm_Preview)then
 begin
  STM_Preview.RedrawPreview;         //resize
 end;
end;

procedure TfrSPMViewFull.Splitter_ViewMoved(Sender: TObject);
begin
 if  assigned(Stm_Preview)then
 begin
    FreeAndnil(Stm_Preview);
   szpreview:=min( Splitter_view.Left,Splitter_file.top);
    Stm_Preview:= TPreview.Create(Stm_Active.lname,Self.Handle,szpreview,Self,true);
    Stm_Preview.Parent:=PanelPrevView;
    Stm_Preview.parentbackground:=false;
    Stm_Preview.Align:= alClient;
    Stm_Preview.Stm_ImageDraw;
    if_stm_preview_is:=true;
    if_stm_active_is:= true; end;
 // if panel_find.Width<60 then   panel_find.Width:= 60;
(*  if  assigned(Stm_Preview)then
  begin
   STM_Preview.RedrawPreview;      //resize
  end;  *)
end;



procedure TfrSPMViewFull.ToolBtnDelClick(Sender: TObject);
var
  InFileName:string;
 begin   //delete
            InFileName:=Stm_Active.lname;
            if FileExists(InFileName) then
            begin
             if silanglinked1.MessageDlg(siLangLinked1.GetTextOrDefault('IDS_4' (* 'Do you really want to delete ' *) ) +' '+ ExtractFileName(INFileName) + ' ?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
              begin
               DeleteFile(InFileName);
               while FileExists(InFileName) do application.ProcessMessages;
               Redraw;
              //update all form stm_view
               if assigned(WorkView) then
                if (workdirectory=DirView.NTShellTreeView.Path) then   WorkView.Redraw
              end;
            end;
end;

procedure TfrSPMViewFull.ToolBtnSaveAsClick(Sender: TObject);
 var
  flgDeleteOld,flgRSCor:Boolean;
  lflgview:byte;
  count,i,old_top,old_left,ChildCount: integer;
  NewFile,OldFile,TmpName:string;
  Dir,s:string;
  fext:string;
  filtind:integer;
begin
   siSaveDialog:=TsiSaveDialog.Create(self);
 //siSaveDialog.siLang:=Main.siLang1;
 //siSaveDialog.siLang.ActiveLanguage:=lang;
   siSaveDialog.InitialDir:=saveasdirectory;//080410
   siSaveDialog.Options:=[ofOverWritePrompt,ofShowHelp,ofEnableSizing];

   siSaveDialog.FilterIndex:=1;
   ForceCurrentDirectory :=True;
   siSaveDialog.FileName:='';
   if  stm_active.stm_label.caption<>'' then
      begin
        siSaveDialog.DefaultExt:=ExtractFileExt(stm_active.lname);//'spm';
        siSaveDialog.Filter:=' spm file *.spm;modified spm files *.mspm| *.spm; *.mspm';
       if siSaveDialog.execute then
       begin
         NewFile:=siSaveDialog.FileName;
         Dir:=ExtractFileDir(NewFile);
         if not DirectoryExists(Dir)then CreateDir(Dir);
         fext:=extractfileext(NewFile);
         OldFile:=stm_active.lname;
         try
             FileCopyStream(OldFile,NewFile);
         except
         on IO: EInOutError do
           begin
              Case IO.errorcode of
             2: s:='file '''+Oldfile+'''not find';
             3: s:='error file name '''+newfile+'''';
             4: s:='file '''+newfile+''' accept denied ';
            101: s:='disk is full';
            106: s:='input error '+newfile+'''';
                    end;
              siLanglinked1.messageDlg(' try again!' ,mtwarning,[mbOk],0);
              exit;
            end; //error copy
         end; //try
         if assigned(WorkView)and (Workdirectory=ExtractFileDir(siSaveDialog.FileName)) then begin  WorkView.ReDraw ; end;
           Application.processmessages;
         if assigned(DirView) and (Opendirectory=ExtractFileDir(siSaveDialog.FileName)) then begin  DirView.ReDraw  ; end;
           Application.processmessages;
    //      view_stm.FindSTM(NewFile);
       end;   // execute
   end; //caption=''
   saveasdirectory:=ExtractFileDir(siSaveDialog.FileName);
   FreeAndNil(siSaveDialog);
end;

end.
