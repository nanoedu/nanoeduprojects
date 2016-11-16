//120108    programmer student Zotin  Michael
unit spm_browserclasses;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, FileCtrl, Tabs,ShellApi,
  ComCtrls, Grids, ExtDlgs, jpeg,
  //ntspb
  GlobalType,GlobalScanDataType,GlobalDcl,NTShellCtrls;

const
  field: integer = 5;

type
  open_massiv_2 = array of array of single;

  Tone_stm = class(TPanel)              //One element
    stm_image   : TImage;
    label_panel : TPanel;
    stm_label   : TPanel;
    addstm_label: TPanel;
protected
    procedure StmRightClick(Sender: TObject);  virtual;
    procedure DblClick(Sender: TObject);
    procedure StmMouseEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
private
      IsDblClick: boolean;
      flgViewPrev:boolean;
      Nx,Ny:integer;
      function  find_max(x1_in,x2_in: single): single;
      procedure DrawPicture(const mas_stm_in: TMas2; mas_x,mas_y:integer; max_in,min_in: single);
      function  DrawBMPPicture(var N,M:integer):integer;
  public
      flgBrowserMakeRScorrection:boolean;
      one_image_size: integer;
      lgrandfather:HWND;
      lname:string;
 constructor   Create(name:string;grandfather:HWND;image_size:integer;AOwner:Tcomponent;flgP:boolean);
 destructor    Destroy; override;
 procedure     OnActivate;   virtual;
 procedure     DeActivate;   virtual;
 procedure     StmLeftClick(Sender: TObject);  virtual;
 procedure     Stm_ImageDraw;
 procedure     SetOneStmPosition (var stm_in:Tone_stm;Nx,Ny: single);
end;

TPreview=Class(Tone_stm)
 private
    procedure   OnActivate;   override;
    procedure   DeActivate;   override;
    procedure   StmRightClick(Sender: TObject); override;
    procedure   StmLeftClick(Sender: TObject);  override;
 public
    Constructor Create(name:string;grandfather:HWND;image_size:integer;AOwner:Tcomponent;flgP:boolean);
    procedure   ChangeNamePreView;
    procedure   Stm_ImageDraw;
    procedure   ClearPreview;
    procedure   ReDrawPreview;
    procedure   ResizePreview;
    destructor  Destroy; override;
end;

  TMyListView = class(TObject)      //List from One element
    constructor Create(grandfather:HWND;mParent: TPanel; directory:string; spm_name_list: TNTShellListView;AOwner:TComponent;flg:integer);
    destructor  Destroy;   override;
    procedure   Destroy_All;        //Destroy List
    procedure   Change_All(var mParent: TScrollBox);              //Change List
  public
      left_pos, top_pos: integer;
      spmfileslist:TList;
      OpendirectoryL:string;
    function  Stm_PreviewCreate(preview:TOne_Stm):TOne_Stm;
    procedure DeActivate;
    function  FindSTM(filename:string):boolean;
  private
       lgrandfather:HWND;
       LAOWNER:TCOMPONENT;
  end;

var
 if_stm_active_is, if_stm_tree_is, if_close_is: boolean;
 if_stm_preview_is: boolean;
  DataDrawTree:TData;
  Stm_Active: TOne_stm;                  //Active element
  Stm_Preview: TPreview;                //Preview picture

implementation

uses
  GlobalVar,GlobalFunction,CSPMVar,mMain,frHeader, RenishawVars;//,frSPM_Browser;

{---------------------Tone_stm-----------------------------}
procedure SetDataDraw(FlgReadBlock:integer;const TopoSPM:TExperiment;var DataDraw:TDATA);
begin
 if FlgReadBlock in ScanmethodSetNoAdd then   DataDraw:=TopoSPM.AquiTopo
                                       else   DataDraw:=TopoSPM.AquiAdd ;
end;

procedure Tone_stm.OnActivate;
vAR       L:INTEGER;
begin
  if assigned(Stm_Active) then
  begin
    if (Self<>Stm_Active) then  Stm_Active.DeActivate;
  end;
  if_stm_active_is:= true;
  Color:=clWhite;//clHighlight;
  stm_label.Color:=clWhite;// clHighlight;
  stm_label.Font.Color:=clRED;// clHighlight;//clWhite;
  addstm_label.Color:=clWhite;//clHighlight;
  addstm_label.Font.Color:=clRED;//clHighlight;// clWhite;
(*  l:=length(stm_label.Caption);
  if length(stm_label.Caption)*abs(stm_label.Font.Size)>stm_label.width
                                    then  stm_label.Alignment:= taleftJustify
                                    else  stm_label.Alignment:= taCenter;;
*)
  if  Stm_Active<> Self then
  begin
   Stm_Active:= Self;
   if  flgViewPrev then
   begin
    Stm_Preview.ChangeNamePreview;
    Stm_Preview.ReDrawPreview;
   end;
    Application.ProcessMessages;
  end;
end;

procedure Tone_stm.DeActivate;
begin
  if_stm_active_is:= false;
  if_stm_preview_is:= false;
 if  Stm_Active<>nil then
  begin
   Stm_Active. Color:= clWhite;//BtnFace;
   Stm_Active. stm_label.Color:= clwhite;;
   Stm_Active. stm_label.Font.Color:= clBlack;
   Stm_Active. addstm_label.Color:= clwhite;;
   Stm_Active. addstm_label.Font.Color:= clBlack;
  end;
  Application.ProcessMessages;
end;

procedure Tone_stm.StmMouseEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
begin
  if not(IsDblClick) then
   begin
    if (Button=mbLeft) then  StmLeftClick(Sender)
                       else  StmRightClick(Sender);
   end;
 IsDblClick:= false;
end;

procedure Tone_stm.StmLeftClick(Sender: TObject);
begin
if assigned(STM_Active) then
 begin
  if Self<> Stm_Active  then
  begin
   Stm_Active.DeActivate;
   Application.ProcessMessages;
  end;
  OnActivate;
  if flgViewPrev and assigned(Stm_Preview)  then Stm_Preview.ReDrawPreview;
  if (Self=Stm_Preview) then PostMessage(Parent.Parent.Handle,WM_UserLBViewFocus,0,0)    { TODO : 140108 }
                        else PostMessage(parent.Parent.Parent.Handle,WM_UserLBViewFocus,0,0);//(  DirView.lb_preview_active.SetFocus;
  Application.ProcessMessages;
  if assigned( FileHeaderForm) then StmRightClick(Sender);
 end
 else //add 130916
 begin
  OnActivate;
  if flgViewPrev and assigned(Stm_Preview)  then Stm_Preview.ReDrawPreview;
  if (Self=Stm_Preview) then PostMessage(Parent.Parent.Handle,WM_UserLBViewFocus,0,0)    { TODO : 140108 }
                        else PostMessage(parent.Parent.Parent.Handle,WM_UserLBViewFocus,0,0);//(  DirView.lb_preview_active.SetFocus;
  Application.ProcessMessages;
  if assigned( FileHeaderForm) then StmRightClick(Sender);
 end;
end;

procedure Tone_stm.StmRightClick(Sender: TObject);
begin
   if  not assigned( FileHeaderForm)then FileHeaderForm:=TFileHeaderForm.Create(Application,lname)
   else
    begin
     FileHeaderForm.ReadParam(lname);
     FileHeaderForm.Refresh;
   end;
end;


procedure Tone_stm.DblClick(Sender: TObject);
var INFileName:string;
    DirPart,FilePart:string;
    Drv:char;
    res:THandle;
    fileext:String;
begin
  fileext:=LowerCase(ExtractFileExt(lname));
if FileExists(lname) then
 if (fileext ='.spm') or (fileext='.mspm') then  Main.CreateMDIChild(Sender,lname,FlgViewDef,false,FlgBrowsermakeRSCorrection)
 else  res:= ShellExecute(handle,'open',Pchar(lname),nil,nil,SW_SHOWNORMAL or SW_RESTORE{ or SW_MAXIMIZE}	);
  IsDblClick:= true;
end;

procedure  Tone_stm.Stm_ImageDraw;
var
  TData_this: TExperiment;
  flgD:integer;
  Drv:Char;
  DirPart,FilePart,CurrDir,INFileName:string;
    BMap:TBitMap;
  jp: TJPEGImage;  //Requires the "jpeg" unit added to "uses" clause.
  fileext:string;
  label 100;
begin
    STM_Active:=self;
   fileext:=LowerCase(ExtractFileExt(LName));
if (fileext='.spm') or (fileext='.mspm')  then
begin
    TData_this:= TExperiment.Create;
 try
   TData_this.imFileName:=lname;
   if ReadHeader(TData_this.imFileName,flgD,head,mainrc)>0 then goto 100;
    case flgD of
   Litho,
   LithoCurrent,
   Topography:  addstm_label.Caption:='Topography' ;
       spectr:  begin
                if head.HProbeType=1 then
                                     begin
                                        if head.HTypeSpectr=1 then addstm_label.Caption:='Spectroscopy I-Z'
                                                              else addstm_label.Caption:='Spectroscopy I-V';
                                     end
                                     else addstm_label.Caption:='Spectroscopy F-Z' ;
                end;
       Phase:   addstm_label.Caption:='Topography+Phase' ;
       UAM:     addstm_label.Caption:='Topography+Force Image' ;
       Current: addstm_label.Caption:='Topography+Current' ;
      FastScan: addstm_label.Caption:='Fast Scan/Current' ;
 FastScanPhase: addstm_label.Caption:='Fast Scan/Phase' ;
 OneLineScan:   addstm_label.Caption:='One Line Scan' ;
      end;

  flgBrowserMakeRScorrection:= (not head.HRenishawCorrected)  and  head.HAquiRenishaw ;


  if  Head.HAquiTopo then
                         if flgD =Spectr then
                          begin
                            flgD := Head.HAquiAdd  ;
                            if Head.HNxTopo=0 then begin   DrawBMPPicture(Nx,Ny)  end
                              else
                               begin
                               if  TData_this.ReadSurface(flgD)>0 then goto 100;
                                 SetDataDraw(flgD,TDAta_this,DataDrawTree);
                                 DrawPicture(DataDrawTree.data,DataDrawTree.NX,
                                                         DataDrawTree.NY,DataDrawTree.DataMax,DataDrawTree.DataMin);
                                 Nx:=DataDrawTree.NX;
                                 Ny:=DataDrawTree.NY;
                              end;
                          end
                         else
                           begin
                              if Head.HAquiAdd<>11 then flgD:=Topography
                                                   else flgD:=OneLineScan; //top view topography  first
                              if  TData_this.ReadSurface(flgD)>0 then goto 100;
                              SetDataDraw(flgD,TDAta_this,DataDrawTree);
                              DrawPicture(DataDrawTree.data,DataDrawTree.NX,
                                                      DataDrawTree.NY,DataDrawTree.DataMax,DataDrawTree.DataMin);
                              Nx:=DataDrawTree.NX;
                              Ny:=DataDrawTree.NY;
                           end
                      else
                      begin //not topo
                        if flgD =Spectr then     flgD := Head.HAquiAdd  ;
                         // begin
                        //    flgD := Head.HAquiAdd  ;
                        //    if Head.HNxTopo=0 then begin   DrawBMPPicture(Nx,Ny)  end
                        //      else
                        //       begin
                               if  TData_this.ReadSurface(flgD)>0 then goto 100;
                                 SetDataDraw(flgD,TDAta_this,DataDrawTree);
                                 DrawPicture(DataDrawTree.data,DataDrawTree.NX,
                                                         DataDrawTree.NY,DataDrawTree.DataMax,DataDrawTree.DataMin);
                                 Nx:=DataDrawTree.NX;
                                 Ny:=DataDrawTree.NY;
                        //      end;
                        // end;
                     end;
(*     SetOneStmPosition(self,Nx,Ny);
     addstm_label.hint:=addstm_label.Caption;
     if length(addstm_label.Caption)*abs(addstm_label.Font.Size)>addstm_label.width
                                    then  addstm_label.Alignment:= taleftJustify
                                    else  addstm_label.Alignment:= taCenter;;
*)
 100:

 finally
     FreeAndNil(TData_this);
 end;
end
else
     if fileext='.bmp'  then
                             begin
                                   BMap:=TBitMap.Create;
                                try
                                   BMap.LoadFromFile(lName);
                                   stm_image.Picture.Assign(BMap);
                                   Nx:=BMap.Width;
                                   Ny:= BMap.Height;
                                finally
                                      BMap.free;
                                end;
                              end
                              else
     if fileext='.jpg'  then
                             begin
                               try
                                 jp:=TJPEGImage.Create;
                                 BMap:=TBitMap.Create;
                                 jp.LoadFromFile(lName);
                                 Bmap.Assign(jp);
                                 stm_image.Picture.Assign(bmap);
                                 Nx:=jp.Width;
                                 Ny:= jp.Height;
                               finally
                                 jp.free;
                                 bmap.free;
                               end;
                              end;
     SetOneStmPosition(self,Nx,Ny);
     addstm_label.hint:=addstm_label.Caption;
     if length(addstm_label.Caption)*abs(addstm_label.Font.Size)>addstm_label.width
                                    then  addstm_label.Alignment:= taleftJustify
                                    else  addstm_label.Alignment:= taCenter;;

end;


procedure Tone_stm.DrawPicture(const mas_stm_in: TMas2;mas_x,mas_y:integer; max_in,min_in: single);
var
  x,y: integer;
  stm_BitMap: TBitMap;
  koef: single;
  PointColor:integer;
  RGBCol:TColor;
begin
 stm_BitMap:= TBitMap.Create;
 try
    stm_BitMap.Width:= mas_x-1;
    stm_BitMap.Height:= mas_y-1;
  if (max_in<>min_in) then koef:= 255/(max_in-min_in)
                      else koef:= 0;
  for y:= 0 to (mas_y-1) do
  for x:= 0 to (mas_x-1) do
  begin
    PointColor:=round(koef*(mas_stm_in[x][y]-min_in))  ;
    if (PointColor >255) then PointColor:=255
                         else if (PointColor <0)   then PointColor:=0   ;
    RGBCol:= TCOlor($02000000 or (RPaletteKoef[PointColor])
                                    or (GPaletteKoef[PointColor] shl 8)
                                    or (BPaletteKoef[PointColor] shl 16) );
   stm_BitMap.Canvas.Pixels[x,mas_y-1-y]:=RGBCol;{Round(koef*(mas_stm_in[x][y]-min_in))*$00010101;}
  end;
  stm_image.Picture.Assign(stm_BitMap);
 finally
   FreeAndNil(stm_BitMap);
 end;
end;{procedure DrawPicture;}

function Tone_stm.DrawBMPPicture(var n,m:integer):integer;
var BitMap:TBitMap;
begin
Result:=0;
BitMap:=TBitMap.Create;
try
 if not FileExists(ExeFilePath+'Data\'+SpectrPictureFile) then
  begin
    Result:=1;
    exit;
  end;
  BitMap.LoadFromFile(ExeFilePath+'Data\'+SpectrPictureFile);
  M:=BitMap.Height;
  N:=BitMap.Width;
  stm_image.Stretch:=True; { TODO : 111207 }
  stm_image.Picture.Assign(BitMap);
 finally
  FreeAndNil(BitMap);
 end;
end;

Constructor  Tone_stm.Create(name:string;grandfather:HWND;image_size:integer;Aowner: Tcomponent;flgP:boolean);
var
  label_panel_Height:integer;
begin
   inherited Create(Aowner);
    lname:=name;
    label_panel_Height:=44;
    flgViewprev:=flgP;
    self.OnMouseDown:= StmMouseEvent;
    self.OnDblClick:= DblClick;
    self.showhint:=true;
    one_image_size:= image_size;
    Height:= one_image_size+label_panel_Height+2*field+2;
    Width:= one_image_size+2*field;
    label_panel:= TPanel.Create(label_panel);
    label_panel.width:=width-2;
    label_panel.Parent:=self;
    label_panel.Height:=label_panel_Height;
    label_panel.Align:= alBottom;
    label_panel.parentbackground:=false;
    label_panel.Alignment:= taCenter;
    label_panel.BevelInner:= bvNone;
    label_panel.BevelOuter:= bvLowered;
    label_panel.Color:=$00DCDDDB;// clInfoBk;
    label_panel.ShowHint:=true;
    label_panel.OnMouseDown:= StmMouseEvent;
    addstm_label:= TPanel.Create(addstm_label);
    addstm_label.Parent:= label_panel;
    addstm_label.width:=width-2;
    addstm_label.parentbackground:=false;
    addstm_label.Height:= 21;
    addstm_label.Align:= alBottom;
    addstm_label.Alignment:= taCenter;
    addstm_label.BevelInner:= bvNone;
    addstm_label.BevelOuter:= bvLowered;
    addstm_label.Color:=$00DCDDDB;// clInfoBk;
    addstm_label.OnMouseDown:= StmMouseEvent;
    addstm_label.OnDblClick:= DblClick;
    stm_label:= TPanel.Create(stm_label);
    stm_label.width:=width-2;
    stm_label.Parent:= label_panel;
    stm_label.Height:= 21;
    stm_label.Align:= alClient;
    stm_label.parentbackground:=false;
    stm_label.Alignment:= taCenter;
    stm_label.BevelInner:= bvNone;
    stm_label.BevelOuter:= bvLowered;
    stm_label.Color:=$00DCDDDB;// clInfoBk;
    stm_label.showhint:=true;
    stm_label.OnMouseDown:= StmMouseEvent;
    stm_label.OnDblClick:= DblClick;
    stm_image:= TImage.Create(stm_image);
    stm_image.Parent:=self;
    stm_image.Align:= alNone;
    stm_image.Left:= field;
    stm_image.Top:= field;
    stm_image.Width:= one_image_size;
    stm_image.Height:= one_image_size;
    stm_image.OnDblClick:= DblClick;
    stm_image.OnMouseDown:= StmMouseEvent;
    stm_image.Stretch:= true;
    stm_image.showhint:=true;
    stm_label.Caption:=ExtractFilename(lname);
    stm_image.hint:= stm_label.Caption;
    stm_label.hint:= stm_label.Caption;
    label_panel.hint:= stm_label.Caption;
    self.hint:=stm_label.Caption;
    Application.ProcessMessages;
    if (length(stm_label.Caption)-1)*abs(stm_label.Font.Size)>stm_label.width
                                    then  stm_label.Alignment:= taleftJustify
                                    else  stm_label.Alignment:= taCenter;

    ControlStyle :=  ControlStyle  + [csOpaque];
end;

destructor  Tone_stm.Destroy;
begin
   FreeAndNil(stm_image);
   FreeAndNil(stm_label);
   FreeAndNil(addstm_label);
   FreeAndNil(label_panel);
  inherited;
end;


procedure Tone_stm.SetOneStmPosition(var stm_in:Tone_stm;Nx,Ny: single);
var
  koef_stm: single;
  h:integer;
begin
  h:=stm_in.one_image_size;//-stm_in.stm_image.Top;
  koef_stm:= find_max(Nx/h,Ny/h);
  stm_in.stm_image.Width:=  Round(Nx/koef_stm);
  stm_in.stm_image.Height:= Round(Ny/koef_stm);
  stm_in.stm_image.Left:= stm_in.stm_image.Left+
      (stm_in.one_image_size-stm_in.stm_image.Width) div 2;
  stm_in.stm_image.Top:= stm_in.stm_image.Top+
   (stm_in.one_image_size-stm_in.stm_image.Height) div 2;
end;

function Tone_stm.find_max(x1_in,x2_in: single): single;
begin
  if (x1_in>x2_in) then find_max:= x1_in
                   else find_max:= x2_in;
end;

//TPreview

procedure TPreview.OnActivate;
begin
  if_stm_preview_is:= true;
//  Color:= clWhite;//clHighlight;
  stm_label.Color:= clWhite;//clHighlight;
  stm_label.Font.Color:=clRed;// clWhite;
  addstm_label.Color:= clWhite;//clHighlight;
  addstm_label.Font.Color:=clRed;// clWhite;
  Application.ProcessMessages;
end;

procedure TPreview.DeActivate;
begin
  if_stm_preview_is:= false;
   Stm_Active. Color:= clWhite;;
   Stm_Active. stm_label.Color:= clWhite;;
   Stm_Active. stm_label.Font.Color:= clBlack;
   Stm_Active. addstm_label.Color:= clWhite;;
   Stm_Active. addstm_label.Font.Color:= clBlack;
  Application.ProcessMessages;
end;
procedure TPreview.StmLeftClick(Sender: TObject);
begin
 OnActivate;
 if assigned( FileHeaderForm) then StmRightClick(Sender);
 Application.ProcessMessages;
end;

procedure TPreview.StmRightClick(Sender: TObject);
begin
   if  not assigned( FileHeaderForm)then FileHeaderForm:=TFileHeaderForm.Create(Application,lname)
   else
    begin
     FileHeaderForm.ReadParam(lname);
     FileHeaderForm.Refresh;
   end;
end;
constructor TPreview.Create(name:string;grandfather:HWND;image_size:integer;Aowner: Tcomponent;flgP:boolean);
begin
  inherited Create(name,grandfather,image_size,Aowner,flgP);
end;

procedure    TPreview.Stm_ImageDraw;
begin
   if assigned(STM_Active) and STM_Active.flgViewPrev then;
   begin
     ChangeNamePreView;
     RedrawPreview;
   end;
end;
procedure   TPreview.ChangeNamePreView;
begin
  lname:=STM_Active.lname;
  stm_label.Caption:=ExtractFileName(Stm_Active.lname);
  addstm_label.Caption:=STM_Active.addstm_label.Caption;
  stm_image.hint:= stm_label.Caption;
  stm_label.hint:= stm_label.Caption;
  label_panel.hint:= stm_label.Caption;
  self.hint:=stm_label.Caption;
end;

procedure   TPreview.RedrawPreview;
begin
  ClearPreview;
  ResizePreview;
  if length(stm_label.Caption)*abs(stm_label.Font.Size)>stm_label.width then  stm_label.Alignment:= taleftJustify
                                                                        else  stm_label.Alignment:= taCenter;
  Stm_Image.Picture.assign(STM_Active.stm_image.Picture.BitMap);
end;
 procedure   TPreview.ClearPreview;
 begin
    with Stm_Image.Picture.Bitmap do
      begin
         Canvas.CopyMode:=$00DCDDDB;//cmWhiteness;     {Очистка картины}
         Canvas.CopyRect(Rect(0,0,Width,Height),Canvas,Rect(0,0,Width,Height));
      end;
    stm_image.Refresh;
 end;
procedure TPreview.ResizePreview;
var
k:single;
begin
  K:= Stm_Active.stm_image.Height/Stm_Active.stm_image.Width ;
  if (width>(Height-label_panel.Height))
  then
   begin
     stm_image.Top:= field;
     stm_image.Height:= (Height -label_panel.Height) -2*field;
     stm_image.Width:=stm_image.Height;
     if k<=1 then begin
                     stm_image.Height:=round(stm_image.Width*k);
                     stm_image.Top:= (Height-field-label_panel.Height-stm_image.Height) div 2;
                  end
             else begin
                     stm_image.width:=round(stm_image.Width/k);
                  end;
      stm_image.Left:= (width-field-stm_image.width) div 2;
  end
  else
   begin
    stm_image.Left:= field;
    stm_image.Width:= Width-2*field;
    stm_image.Height:=stm_image.Width;
    if k<=1 then begin
                     stm_image.Height:=round(stm_image.Width*k);
                     stm_image.Top:= (Height-field-label_panel.Height-stm_image.Height) div 2;
                 end
            else begin
                     stm_image.width:=round(stm_image.Width/k);
                     stm_image.Top:= field;
                     stm_image.Left:= (width-field-stm_image.width) div 2;
                 end;
   end;
end;

destructor  TPreview.Destroy;
begin
  inherited;
end;

{---------------------Tview_stm-----------------------------}

constructor TMYListView.Create(grandfather:HWND;mParent: TPanel; directory:string; spm_name_list: TNTShellListView;AOwner:TComponent;flg:integer);
var
  i,index_now,N,M: integer;
  Drv:Char;
  InFileName,CurrDir,DirPart,FilePart,imFileName:string;
  str,st_panel_help: string;
  new_element:Tone_Stm;
  filelist:Tstringlist;
  ires:integer;
  sSr:TsearchRec;
  ext:string;
begin
 inherited Create;
//    lgrandfather:=grandfather;
  { TODO : 140108 }
    STM_Active:=nil;
    opendirectoryl:=directory;
    LAOWNER :=aowner;
    spmfileslist:=TList.Create;
    filelist:=Tstringlist.Create;
 try
    left_pos:= 0;
    top_pos:= 0;
    index_now:= 0;
   for i:=0 to spm_name_list.items.count -1 do
   begin
    str:=spm_name_list.Folders[i].PathName;
    str:=LowerCase(ExtractFileExt(str));
(*    if (LowerCase(str)='.spm')  or  (LowerCase(str)='.mspm') then
      filelist.add( spm_name_list.Folders[i].PathName);
      *)
      case flgFilterExt of
0:   if (str='.spm')  or  (str='.mspm') then   filelist.add( spm_name_list.Folders[i].PathName);
1:   if (str='.bmp')  or  (str='.jpg')  then   filelist.add( spm_name_list.Folders[i].PathName);
2:   if (str='.bmp')  or  (str='.jpg') or (str='.spm') or  (str='.mspm')
                     then filelist.add( spm_name_list.Folders[i].PathName);
       end;

   end;

  if (filelist .Count<>0) then
//  with stm_name do
    begin
     while (index_now <= (filelist.Count-1)) do
     begin
        InFileName:=filelist[index_now];
        InFileName:=ExtractFileName(InFileName);
        CurrDir:=directory;//stm_name.directory;
        OpenDirectoryL:=CurrDir;
        ProcessPath (CurrDir,Drv,DirPart,FilePart);
       if  DirPart='\' then  imFileName:=CurrDir+InFileName
                       else  imFileName:=CurrDir+'\'+InFileName;
       if Index_now>0 then
        begin
         new_element:= spmfileslist.items[Index_now-1];
         new_element.DeActivate;
        end;
        new_element:= Tone_stm.Create(imFileName,lgrandfather,110,AOwner,boolean(flg));
        new_element.Stm_ImageDraw;
        new_element.Left:= left_pos;
        new_element.Top:= top_pos;
      //  new_element.stm_label.Caption:=ExtractFileName(filelist[index_now]);
        new_element.Parent:= mParent;
 //next position
      if (left_pos+2*new_element.Width)>mParent.ClientWidth then
      begin
        left_pos:= 0;
        top_pos:= top_pos + new_element.Height;
      end
      else  left_pos:= left_pos+new_element.Width;
       spmfileslist.add(new_element);
       inc(index_now);
       Application.ProcessMessages;
    end;    //while
      if_stm_tree_is:= true;
      Stm_Active:=spmfileslist.items[0];
      Stm_Active.OnActivate;
   end;
     if filelist.count>0 then  filelist.clear;
  finally
     FreeAndNil(filelist);
  end;
end;

destructor TMYListView.Destroy;
 var new_element:Tone_stm;
 i:integer;
begin
  if spmfileslist.count>0 then
  begin
   for i:=0 to spmfileslist.count-1 do
   begin
    new_element:=spmfileslist.items[i];
    freeandnil(new_element);
   end;
   spmfileslist.Clear;
  end;
  freeandnil(spmfileslist);
   STM_Active:=nil;
   inherited Destroy;
 end;{destructor Tview_stm.Destroy;}


procedure TMYListView.Destroy_All;
var
  new_element: TOne_Stm;
  i:integer;
begin
  if spmfileslist.count>0 then
  begin
   for i:=0 to spmfileslist.count-1 do
   begin
    new_element:=spmfileslist.items[i];
    freeandnil(new_element);
   end;
   spmfileslist.Clear;
  end;
  freeandnil(spmfileslist);
   STM_Active:=nil;
   if_stm_active_is:= false;
   if_stm_preview_is:= false;
   if_stm_tree_is:= false;
end;{procedure Destroy_All;}

procedure TMYListView.DeActivate;
var i:Integer;
spm:TOne_stm;
begin
 for i:=0 to spmfileslist.count-1 do
 begin
  if stm_active=spmfileslist.items[i] then
  begin
   spm:=spmfileslist.items[i];
   spm.DeActivate;
  end;
 end;
end;

procedure TMYListView.Change_All(var mParent: TScrollBox);
var
  i:integer;
  new_element:Tone_stm;
begin
  left_pos:= 0;
  top_pos:= 0;
 if   spmfileslist.count>0 then
 begin
  for i:=0 to spmfileslist.count-1 do
   begin
     new_element:=spmfileslist.Items[i];
    if ((left_pos+ new_element.Width)>mParent.ClientWidth) and (left_pos+top_pos>0) then
      begin
        left_pos:= 0;
        top_pos:= top_pos +  new_element.Height;
      end;
     new_element.Left:= left_pos;
     new_element.Top:= top_pos;
     left_pos:= left_pos+ new_element.Width;
   end;
 end;
end;{procedure Change_All}


function  TMYListView.Stm_PreviewCreate(preview:TOne_Stm):TOne_Stm;
begin

end;
function  TMYListView.FindSTM(filename:string):boolean;
var i:integer;
begin
  if   spmfileslist.count>0 then
 begin
  for i:=0 to spmfileslist.count-1 do
   begin
    if (Tone_stm(spmfileslist.Items[i]).lname=filename) then
    begin
      DeActivate;
      STM_Active:= spmfileslist.Items[i];
      STM_Active.OnActivate;
    end;
   end;
   end;
end;
{---------------------TMYListView-----------------------------}
end.
