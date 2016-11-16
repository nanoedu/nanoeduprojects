unit frSetOSCParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, siComp, siLngLnk,mMain, Grids;

type
  TOSCParams = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    MainPanel: TPanel;
    bitbtnOK: TBitBtn;
    ComboBox1: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    ComboBox2: TComboBox;
    IndValue: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    siLangLinked1: TsiLangLinked;
    StringGridChannels: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure bitbtnOKClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
    procedure UpdateStrings;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
	strChannelname: string = ''; (* Channel *) // TSI: Localized (Don't modify!)
	strDescription: string = ''; (* Description *) // TSI: Localized (Don't modify!)
	strChannel_LRX: string = ''; (* ADC Force *) // TSI: Localized (Don't modify!)
	strChannel_A: string = ''; (* Voltage Modulation *) // TSI: Localized (Don't modify!)
	strChannel_Ph: string = ''; (*   Phase *) // TSI: Localized (Don't modify!)
	strChannel_Z: string = ''; (* Scanning signal Z *) // TSI: Localized (Don't modify!)
	strChannel_U: string = ''; (* Set Point *) // TSI: Localized (Don't modify!)
	strChannel_X: string = ''; (* Scanning signal X *) // TSI: Localized (Don't modify!)
	strChannel_Y: string = ''; (* Scanning signal Y *) // TSI: Localized (Don't modify!)
	strChannel_I: string = ''; (* ADC Current *) // TSI: Localized (Don't modify!)
	strChannel_H: string = ''; (* PID Output *) // TSI: Localized (Don't modify!)
	strChannel_err: string = ''; (* Force Image *) // TSI: Localized (Don't modify!)
	strChannel_dZ: string = ''; (* Z Bias *) // TSI: Localized (Don't modify!)
	strChannel_DAC_X: string = 'Scanning signal X'; (* PID Output *) // TSI: Localized (Don't modify!)
	strChannel_DAC_Y: string = 'Scanning signal Y'; (* Force Image *) // TSI: Localized (Don't modify!)
	strChannel_DAC_Z: string = 'Scanning signal Z'; (* Z Bias *) // TSI: Localized (Don't modify!)

(*
  Name0="LRX"; Min0=-10; Max0=10; Unit0="В";      АЦП канал силы.
Name1="A"; Min1=-5; Max1=5; Unit1="В";          Амплитуда раскачивания иголки.
Name2="Ph"; Min2=-3.14; Max2=3.14; Unit2="Рад"; Фаза раскачивания иголки.
Name3="Z"; Min3=150; Max3=-50; Unit3="В";       Сигнал сканирования Z.
Name4="U"; Min4=-10; Max4=10; Unit4="В";        Напряжение опоры(напряж, формируемое в предусилителе).
Name5="X"; Min5=150; Max5=-50; Unit5="В";       Сигнал сканирования X.
Name6="Y"; Min6=150; Max6=-50; Unit6="В";       Сигнал сканирования Y.
Name7="I"; Min7=-25; Max7=25; Unit7="В";        АЦП канал тока.
Name8="H"; Min8=150; Max8=-50; Unit8="В";       Выход ПИД-регулятора.
Name9="err"; Min9=-1; Max9=1; Unit9="Ед";       Сигнал ошибки для ПИД регулятора(поступает из мультиплексора).
Name10="dZ"; Min10=-1; Max10=1; Unit10="Ед");   Подставка Z, задаваемая через dxchg.

*)

var
  frOSCParams: TOSCParams;

implementation

{$R *.dfm}

 uses CSPMVar, Globalvar;

procedure TOSCParams.bitbtnOKClick(Sender: TObject);
var i,j:integer;
begin
 (*     OSCParams.LRX:=strtoint(EditLRX.Text);
    OSCParams.phase:=strtoint(EditPhase.Text);
OSCParams.amplitude:=strtoint(EditAMpl.Text);   //  phase
 OSCParams.piderror:=strtoint(EditPIDErr.Text);
     OSCParams.adcZ:=strtoint(EditADCZ.Text);
     OSCParams.dacX:=strtoint(EditDACX.Text);
     OSCParams.dacY:=strtoint(EditDACY.Text);
     OSCParams.dacZ:=strtoint(EditDACZ.Text);
     OSCParams.adcI:=strtoint(EditADCI.Text);
     OSCParams.U   :=strtoint(EditU.Text);
     OSCParams.PID :=strtoint(EditPID.Text);
*)
 j:=0;
  for I := 0 to ComponentCount-1 do
  begin
  if Components[i] is TLabeledEdit then
   begin
    for j:= 0 to OSCParams.NChannels - 1 do
    if TlabeledEdit(Components[i]).EditLabel.caption=aOSCParamName[j] then
     aOSCParamVal[j]:=strtoint(TlabeledEdit(Components[i]).Text);
   end;
  end;
    ModalResult:=mrOK;
end;

procedure TOSCParams.ComboBox1Change(Sender: TObject);
function SetOSCBits(ItemIndex1,ItemIndex2:string):boolean;
var i:integer;
begin
  for I := 0 to ComponentCount-1 do
  begin
  if Components[i] is TLabelededit then
   begin
   if TlabeledEdit(Components[i]).EditLabel.Caption<>ItemIndex2 then
    begin
    TLabeledEdit(Components[i]).Text:=inttostr(0)
    end;
   if TlabeledEdit(Components[i]).EditLabel.caption=ItemIndex1 then
    begin
    TLabeledEdit(Components[i]).Text:=inttostr(16)
    end;
   end;
  end;
end;
begin
 SetOSCBits(ComboBox1.Items[ComboBox1.ItemIndex],ComboBox2.Items[ComboBox2.ItemIndex]);
 OSCParams.NameChannel1:=ComboBox1.Items[ComboBox1.ItemIndex];
end;

procedure TOSCParams.ComboBox2Change(Sender: TObject);
function SetOSCBits(ItemIndex1,ItemIndex2:string):boolean;
var i:integer;
begin
  for I := 0 to ComponentCount-1 do
  begin
  if Components[i] is TLabelededit then
   begin
   if TlabeledEdit(Components[i]).Editlabel.caption<>ItemIndex2 then
    begin
    TLabeledEdit(Components[i]).Text:=inttostr(0)
    end;
   if TlabeledEdit(Components[i]).EditLabel.Caption=ItemIndex1 then
    begin
    TLabeledEdit(Components[i]).Text:=inttostr(16)
    end;
   end;
  end;end;
begin
 SetOSCBits(ComboBox2.Items[ComboBox2.ItemIndex],ComboBox1.Items[ComboBox1.ItemIndex]);
  OSCParams.NameChannel2:=ComboBox2.Items[ComboBox2.ItemIndex];
end;

procedure TOSCParams.FormCreate(Sender: TObject);
var i,j:integer;
    n:integer;
    rownmb:integer;
begin
siLangLinked1.ActiveLanguage:=Lang;
UpdateStrings;
//Panel2.Visible:=false;
Panel2.Height:=0;

StringGridChannels.RowCount:= length(aOSCParamName)+1;                               // 21-12-2012 Ola
StringGridChannels.Height:= (StringGridChannels.RowCount+1)*StringGridChannels.DefaultRowHeight;
MainPanel.Height:=StringGridChannels.Top+StringGridChannels.Height +100;
Height:=MainPanel.Height;

StringGridChannels.Cells[0,0]:= strChannelname;
StringGridChannels.Cells[1,0]:= strDescription;
rownmb:=1;
with  StringGridChannels do
for I := 0 to length(aOSCParamName)-1 do              // Таблица описания каналов
begin
   if lowercase(aOSCParamName[i]) = lowercase('LRX') then
                begin
                   Cells[0,rownmb]:=  aOSCParamName[i];
                   Cells[1,rownmb]:=  strChannel_LRX ;
                   inc(rownmb);
                end
   else if lowercase(aOSCParamName[i]) = lowercase('A') then
                begin
                     Cells[0,rownmb]:=  aOSCParamName[i];
                   Cells[1,rownmb]:= strChannel_A ;
                   inc(rownmb);
                end
   else if lowercase(aOSCParamName[i]) = lowercase('Ph') then
                begin
                    Cells[0,rownmb]:= aOSCParamName[i];
                   Cells[1,rownmb]:=  strChannel_Ph ;
                   inc(rownmb);
                end
    else if lowercase(aOSCParamName[i]) = lowercase('Z') then
                begin
                     Cells[0,rownmb]:= aOSCParamName[i];
                   Cells[1,rownmb]:=    strChannel_Z ;
                   inc(rownmb);
                end
    else if lowercase(aOSCParamName[i]) = lowercase('U') then
                begin
                     Cells[0,rownmb]:=  aOSCParamName[i];
                   Cells[1,rownmb]:=     strChannel_U;
                   inc(rownmb);
                end
   else if lowercase(aOSCParamName[i]) = lowercase('X') then
                begin
                     Cells[0,rownmb]:=  aOSCParamName[i];
                   Cells[1,rownmb]:=    strChannel_X ;
                   inc(rownmb);
                end
   else if lowercase(aOSCParamName[i]) = lowercase('Y') then
                begin
                     Cells[0,rownmb]:= aOSCParamName[i];
                   Cells[1,rownmb]:=    strChannel_Y  ;
                   inc(rownmb);
                end
   else if lowercase(aOSCParamName[i]) = lowercase('I') then
                begin
                     Cells[0,rownmb]:=  aOSCParamName[i];
                   Cells[1,rownmb]:=     strChannel_I  ;
                   inc(rownmb);
                end
   else if lowercase(aOSCParamName[i]) = lowercase('H') then
                begin
                     Cells[0,rownmb]:=  aOSCParamName[i];
                   Cells[1,rownmb]:=    strChannel_H ;
                   inc(rownmb);
                end
   else if lowercase(aOSCParamName[i]) = lowercase('err') then
                begin
                     Cells[0,rownmb]:=  aOSCParamName[i];
                   Cells[1,rownmb]:=    strChannel_err ;
                   inc(rownmb);
                end
   else if lowercase(aOSCParamName[i]) = lowercase('dZ') then
                begin
                     Cells[0,rownmb]:=  aOSCParamName[i];
                   Cells[1,rownmb]:=    strChannel_dZ ;
                   inc(rownmb);
                end
    else if lowercase(aOSCParamName[i]) = lowercase('DAC_Z') then
                begin
                     Cells[0,rownmb]:=  aOSCParamName[i];
                   Cells[1,rownmb]:=    strChannel_DAC_Z ;
                   inc(rownmb);
                end
   else if lowercase(aOSCParamName[i]) = lowercase('DAC_X') then
                begin
                     Cells[0,rownmb]:=  aOSCParamName[i];
                   Cells[1,rownmb]:=    strChannel_DAC_X ;
                   inc(rownmb);
                end
  else if lowercase(aOSCParamName[i]) = lowercase('DAC_Y') then
                begin
                     Cells[0,rownmb]:=  aOSCParamName[i];
                   Cells[1,rownmb]:=    strChannel_DAC_Y ;
                   inc(rownmb);
                end
end;



for I := 0 to length(aOSCParamName)-1 do
 begin
   ComboBox1.Items.Add(aOSCParamName[i]);
   ComboBox2.Items.Add(aOSCParamName[i]);
 end;
if OSCParams.NameChannel1<>'None' then
for I := 0 to ComboBox1.Items.Count - 1 do
if ComboBox1.Items[i]=OSCParams.NameChannel1 then
begin
 ComboBox1.ItemIndex:=i;
 aOSCParamVal[i-1]:=16;
end;
if OSCParams.NameChannel2<>'None' then
for I := 0 to ComboBox2.Items.Count - 1 do
if ComboBox2.Items[i]=OSCParams.NameChannel2 then
begin
  UpdateStrings;
 ComboBox2.ItemIndex:=i;
 aOSCParamVal[i-1]:=16;
end;

  OSCParams.NameChannel1:=ComboBox1.Items[ComboBox1.ItemIndex];
 j:=0;
  for I := 0 to ComponentCount-1 do
  begin
  if Components[i] is TLabeledEdit then
   begin
    TLabeledEdit(Components[i]).Text:=inttostr(aOSCParamVal[j]);
    inc(j);
   end;
  end;
  j:=0;
for I := 0 to ComponentCount-1 do
  begin
  if Components[i] is TLabeledEDit then
   begin
    TLabeledEdit(Components[i]).EditLabel.caption:=aOSCParamName[j];
    inc(j);
   end;
  end;
(*      EditLRX.Text:=inttostr(OSCParams.LRX);
    EditPhase.Text:=inttostr(OSCParams.phase);
     EditAMpl.Text:=inttostr(OSCParams.amplitude);
   EditPIDErr.Text:=inttostr(OSCParams.piderror);
     EditADCZ.Text:=inttostr(OSCParams.adcZ);
     EditDACX.Text:=inttostr(OSCParams.dacX);
     EditDACY.Text:=inttostr(OSCParams.dacY);
     EditDACZ.Text:=inttostr(OSCParams.dacZ);
     EditADCI.Text:=inttostr(OSCParams.adcI);
     EditU.Text:=inttostr(OSCParams.U);
     EditPID.Text:=inttostr(OSCParams.PID);
 *)


   n:=0;
  for I := 0 to ComponentCount-1 do
  begin
  if Components[i] is Tedit then
   begin
     case n  of
0: if strtoint(Tedit(Components[i]).text)=16 then
    begin
     ComboBox1.ItemIndex:=Tedit(Components[i]).tag;
     inc(n);
    end;
1: if strtoint(Tedit(Components[i]).text)=16 then
    begin
     ComboBox2.ItemIndex:=Tedit(Components[i]).tag;
     inc(n);
    end;
          end
  end;
  end;
  n:=0;
  for i := 0 to ComponentCount-1 do
  begin
  if Components[i] is Tedit then
   begin
     case n  of
0: if strtoint(Tedit(Components[i]).text)=16 then
    begin
     ComboBox1.ItemIndex:=Tedit(Components[i]).tag;
     inc(n);
    end;
1: if strtoint(Tedit(Components[i]).text)=16 then
    begin
     ComboBox2.ItemIndex:=Tedit(Components[i]).tag;
     inc(n);
    end;
          end
  end;
 end;
end;
procedure TOSCParams.siLangLinked1ChangeLanguage(Sender: TObject);
begin

  UpdateStrings;
end;

procedure TOSCParams.UpdateStrings;
begin
  strChannel_dZ := siLangLinked1.GetTextOrDefault('strstrChannel_dZ' (* 'Z Bias' *) );
  strChannel_err := siLangLinked1.GetTextOrDefault('strstrChannel_err' (* 'Force Image' *) );
  strChannel_H := siLangLinked1.GetTextOrDefault('strstrChannel_H' (* 'PID Output' *) );
  strChannel_I := siLangLinked1.GetTextOrDefault('strstrChannel_I' (* 'ADC Current' *) );
  strChannel_Y := siLangLinked1.GetTextOrDefault('strstrChannel_Y' (* 'Scanning signal Y' *) );
  strChannel_X := siLangLinked1.GetTextOrDefault('strstrChannel_X' (* 'Scanning signal X' *) );
  strChannel_U := siLangLinked1.GetTextOrDefault('strstrChannel_U' (* 'Set Point' *) );
  strChannel_Z := siLangLinked1.GetTextOrDefault('strstrChannel_Z' (* 'Scanning signal Z' *) );
  strChannel_Ph := siLangLinked1.GetTextOrDefault('strstrChannel_Ph' (* '  Phase' *) );
  strChannel_A := siLangLinked1.GetTextOrDefault('strstrChannel_A' (* 'Voltage Modulation' *) );
  strChannel_LRX := siLangLinked1.GetTextOrDefault('strstrChannel_LRX' (* 'ADC Force' *) );
  strDescription := siLangLinked1.GetTextOrDefault('strstrDescription' (* 'Description' *) );
  strChannelname := siLangLinked1.GetTextOrDefault('strstrChannelname' (* 'Channel' *) );

end;

end.

