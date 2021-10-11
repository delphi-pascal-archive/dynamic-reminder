//==============================================================================
     Unit ALIAS;
//==============================================================================

//==============================================================================
     INTERFACE
//==============================================================================

uses StdCtrls,ExtCtrls,StrUtils,SysUtils;

const  AliasVersion = '1'; // 31/12/2009

//-- Procédures et functions ----
{*DER}
function DER(var O:TlistBox):integer;   overload    //ok
function DER(var O:TComboBox):integer;  overload    //ok
function DER(var O:TMemo):integer;      overload    //ok
{*IDX}
function IDX(var O:TListBox):integer;   overload    //ok
function IDX(var O:TComboBox):integer;  overload    //ok
function IDX(var O:Tmemo):integer;      overload    //ok
{*LIG}
function  LIG(var O:TlistBox; n:integer):string;   overload  //ok
function  LIG(var O:TComboBox; n:integer):string;  overload  //ok
function  LIG(var O:TMemo; n:integer):string;      overload  //ok
{*QTE}
function QTE(var O:TlistBox):integer;   overload   //ok
function QTE(var O:TComboBox):integer;  overload   //ok
function QTE(var O:TMemo):integer;      overload   //ok
{*TXT} 
function  TXT(var O:TListBox):string;   overload  //ok
function  TXT(var O:TComboBox):string;  overload  //ok
function  TXT(var O:TMemo):string;      overload  //ok
{*XOF}
function  XOF(var O:TListBox; z:string; e:integer=1):integer;  overload  //ok
function  XOF(var O:TComboBox; z:string; e:integer=1):integer; overload  //ok
function  XOF(var O:Tmemo; z:string; e:integer=1):integer;     overload  //ok
{ADD}
procedure ADD(var O:TlistBox; z:string);   overload     //ok
procedure ADD(var O:Tmemo; z:string);      overload     //ok
procedure ADD(var O:TcomboBox; z:string);  overload     //ok
procedure ADD(var O:Tedit; z:string);      overload     //
{CHG}
Procedure CHG(var O:Tlistbox; fic:string);   overload    //ok
Procedure CHG(var O:Tmemo; fic:string);      overload    //ok
Procedure CHG(var O:TcomboBox; fic:string);  overload    //ok
{ECR}
procedure ECR(var O:TListBox; n:integer; z:string);   overload  //ok
procedure ECR(var O:TComboBox; n:integer; z:string);  overload  //ok
procedure ECR(var O:TMemo; n:integer; z:string);      overload  //ok
procedure ECR(var O:TEdit; z:string);                 overload  //ok
{EFF}
Procedure EFF(var O:Tlistbox);   overload   //ok
Procedure EFF(var O:Tmemo);      overload   //ok
Procedure EFF(var O:TcomboBox);  overload   //ok
Procedure EFF(var O:Tpanel);     overload   //ok
Procedure EFF(var O:Tedit);      overload   //ok
Procedure EFF(var O:Tbutton);    overload   //ok
{NDX}
procedure NDX(var O:TlistBox; n:integer);   overload  //ok
procedure NDX(var O:TComboBox; n:integer);  overload  //ok
{RAZ}
Procedure RAZ(var O:Tlistbox);   overload     //ok
Procedure RAZ(var O:Tmemo);      overload     //ok
Procedure RAZ(var O:TcomboBox);  overload     //ok
Procedure RAZ(var O:Tedit);      overload     //ok
Procedure RAZ(var O:Tbutton);    overload     //ok
Procedure RAZ(var O:Tpanel);     overload     //ok
{SVG}
Procedure SVG(var O:Tlistbox; fic:string);    overload  //ok
Procedure SVG(var O:Tmemo; fic:string);       overload  //ok
Procedure SVG(var O:TcomboBox; fic:string);   overload  //ok
{VIS}
Procedure VIS(var O:Tlistbox);   overload      //ok
Procedure VIS(var O:Tmemo);      overload      //ok
Procedure VIS(var O:TcomboBox);  overload      //ok
Procedure VIS(var O:Tpanel);     overload      //ok
Procedure VIS(var O:Tedit);      overload      //ok
Procedure VIS(var O:Tbutton);    overload      //ok
{ChgH}
procedure ChgH(var O:Tlistbox; H:string);  overload           //
procedure ChgH(var O:Tmemo; H:string);     overload           //
{SvgH}
function  SvgH(var O:Tlistbox):string;     overload          //
function  SvgH(var O:Tmemo):string;        overload          //


//==============================================================================
      IMPLEMENTATION
//==============================================================================

uses gestH;    // pour SvgH et ChgH

//------------------------------------------------------------------------------
{*DER}
function DER(var O:TlistBox):integer;  begin result:=O.count-1       end;
function DER(var O:TComboBox):integer; begin result:=O.Items.Count-1 end;
function DER(var O:TMemo):integer;     begin result:=O.lines.count-1 end;

//------------------------------------------------------------------------------
{*IDX}
function IDX(var O:TListBox):integer;  begin result:=O.ItemIndex end;
function IDX(var O:TComboBox):integer; begin result:=O.ItemIndex end;
function IDX(var O:Tmemo):integer;
  var s,n,c,l:integer;
  begin
  n:=0; c := -1;  l:=O.lines.count;
  s := O.SelStart;
  while (n<s) and (c<l) do begin n := posEx(#13,O.Text,n+1); inc(c) end;
  result:= c
  end;

//------------------------------------------------------------------------------
{*LIG}
function  LIG(var O:TlistBox; n:integer):string;
  begin result := ''; 
  if (n>-1) and (n<O.count) then result := O.Items[n];
  end;
function  LIG(var O:TComboBox; n:integer):string;
  begin result := '';
  if (n>-1) and (n<O.items.count) then result := O.Items[n];
  end;
function  LIG(var O:TMemo; n:integer):string;
  begin result := ''; 
  if (n>-1) and (n<O.lines.count) then result := O.lines[n];
  end;

//------------------------------------------------------------------------------
{*QTE}
function QTE(var O:TlistBox):integer;  begin result:=O.count       end;
function QTE(var O:TComboBox):integer; begin result:=O.items.count end;
function QTE(var O:TMemo):integer;     begin result:=O.lines.count end;

//------------------------------------------------------------------------------
{*TXT}
function  TXT(var O:TListBox):string;
    begin
    result := '';
    if IDX(O)>-1 then result := LIG(O,IDX(O));
    end;
function  TXT(var O:TComboBox):string;
    begin
    result := '';
    if IDX(O)>-1 then result := LIG(O,IDX(O));
    end;
function  TXT(var O:TMemo):string;
    begin
    result := '';
    if IDX(O)>-1 then result := LIG(O,IDX(O));
    end;
// TXT pour le Tmemo nécessite d'avoir déclaré IDX avant

//------------------------------------------------------------------------------
{*XOF}
function  XOF(var O:TListBox; z:string; e:integer=1):integer;
   var i:integer;
   begin
   if e=1 then result := O.Items.IndexOf(z)
          else begin
               result := -1;
               z := uppercase(z);
               for i:=0 to DER(O) do
                   if pos(z,uppercase(LIG(O,i)))>0 then
                      begin
                      result := i;
                      exit
                      end;
               end;
   end;
function  XOF(var O:TComboBox; z:string; e:integer=1):integer;
   var i:integer;
   begin
   if e=1 then result := O.Items.IndexOf(z)
          else begin
               result := -1;
               z := uppercase(z);
               for i:=0 to DER(O) do
                   if pos(z,uppercase(LIG(O,i)))>0 then
                      begin
                      result := i;
                      exit
                      end;
               end;
   end;
function  XOF(var O:Tmemo; z:string; e:integer=1):integer;
   var i:integer;
   begin
   if e=1 then result := O.lines.indexof(z)
          else begin
               result := -1;
               z := uppercase(z);
               for i:=0 to DER(O) do
                   if pos(z,uppercase(LIG(O,i)))>0 then
                      begin
                      result := i;
                      exit
                      end;
               end;
   end;

//------------------------------------------------------------------------------
{ADD}
procedure ADD(var O:TlistBox; z:string);  begin O.Items.Add(z) end;
procedure ADD(var O:Tmemo; z:string);     begin O.lines.add(z) end;
procedure ADD(var O:TcomboBox; z:string); begin O.items.add(z) end;
procedure ADD(var O:TEdit; z:string);     begin O.text := O.Text + z end;

//------------------------------------------------------------------------------
{CHG}
Procedure CHG(var O:Tlistbox; fic:string);  begin O.items.LoadFromFile(fic); end;
Procedure CHG(var O:Tmemo; fic:string);     begin O.lines.LoadFromFile(fic); end;
Procedure CHG(var O:TcomboBox; fic:string); begin O.items.LoadFromFile(fic); end;

//------------------------------------------------------------------------------
{ECR}
procedure ECR(var O:TListBox; n:integer; z:string);
  begin if (n>-1) and (n< QTE(O)) then O.Items[n] := z; end;
procedure ECR(var O:TComboBox; n:integer; z:string);
  begin  if (n>-1) and (n< QTE(O)) then
             begin
             O.Items[n] := z;
             O.ItemIndex := n;
             end;
  end;
procedure ECR(var O:TMemo; n:integer; z:string);
  begin  if (n>-1) and (n< QTE(O)) then O.lines[n] := z; end;
procedure ECR(var O:TEdit; z:string);
  begin O.Text := z; end;

//------------------------------------------------------------------------------
{EFF}
Procedure EFF(var O:Tlistbox);  begin O.visible:=false end;
Procedure EFF(var O:Tmemo);     begin O.visible:=false end;
Procedure EFF(var O:TcomboBox); begin O.visible:=false end;
Procedure EFF(var O:Tpanel);    begin O.visible:=false end;
Procedure EFF(var O:Tedit);     begin O.visible:=false end;
Procedure EFF(var O:Tbutton);   begin O.visible:=false end;

//------------------------------------------------------------------------------
{NDX}
procedure NDX(var O:TlistBox; n:integer);
begin
if n<O.Items.count then
   begin
   O.ItemIndex :=n;
   O.TopIndex := n;
   end;
end;
procedure NDX(var O:TComboBox; n:integer);
begin
if n<O.Items.count then O.ItemIndex :=n;
end;

//------------------------------------------------------------------------------
{RAZ}
Procedure RAZ(var O:Tlistbox);  begin O.clear       end;
Procedure RAZ(var O:Tmemo);     begin O.clear       end;
Procedure RAZ(var O:TcomboBox); begin O.clear       end;
Procedure RAZ(var O:Tedit);     begin O.text:=''    end;
Procedure RAZ(var O:Tbutton);   begin O.caption:='' end;
Procedure RAZ(var O:Tpanel);    begin O.caption:='' end;

//------------------------------------------------------------------------------
{SVG}
Procedure SVG(var O:Tlistbox; fic:string);  begin O.items.SaveToFile(fic); end;
Procedure SVG(var O:Tmemo; fic:string);     begin O.lines.SaveToFile(fic); end;
Procedure SVG(var O:TcomboBox; fic:string); begin O.items.SaveToFile(fic); end;

//------------------------------------------------------------------------------
{VIS}
Procedure VIS(var O:Tlistbox);  begin O.visible:=true end;
Procedure VIS(var O:Tmemo);     begin O.visible:=true end;
Procedure VIS(var O:TcomboBox); begin O.visible:=true end;
Procedure VIS(var O:Tpanel);    begin O.visible:=true end;
Procedure VIS(var O:Tedit);     begin O.visible:=true end;
Procedure VIS(var O:Tbutton);   begin O.visible:=true end;

//------------------------------------------------------------------------------
{ChgH}
procedure ChgH(var O:Tlistbox; H:string);
  var i:integer;
  begin
  if H='' then exit;   // vide par défaut
  RAZ(O);
  for i:=0 to DerH(H) do ADD(O,AnsiReplaceStr(getH(H,i),'¸',#59)); end;
procedure ChgH(var O:Tmemo; H:string);
  var i:integer;
  begin if H='' then exit;   // vide par défaut
  RAZ(O);
  for i:=0 to DerH(H) do ADD(O,AnsiReplaceStr(getH(H,i),'¸',#59));  // decoma(getH(H,i)));
  end;

//------------------------------------------------------------------------------
{SvgH}
function SvgH(var O:Tlistbox):string;
  var i:integer; H:string;
  begin
  result := '';
  if QTE(O)=0 then exit;  // liste vide
  H := AnsiReplaceStr(LIG(O,0),#59,'¸'); // remplace les points virgule ligne 0
  result := H;  if QTE(O)=1 then exit;   // une seule ligne
  for i:=1 to DER(O) do addH(H,AnsiReplaceStr(LIG(O,i),#59,'¸'));
  result := H;
  end;
function SvgH(var O:Tmemo):string;
  var i:integer; H:string;
  begin
  result := '';
  if QTE(O)=0 then exit;  // liste vide
  H := AnsiReplaceStr(LIG(O,0),#59,'¸'); // remplace les points virgule ligne 0
  result := H;  if QTE(O)=1 then exit;   // une seule ligne
  for i:=1 to DER(O) do addH(H,AnsiReplaceStr(LIG(O,i),#59,'¸'));
  result := H;
  end;
//------------------------------------------------------------------------------

// le ; a été pris comme séparateur dans GestH afin d'être compatible avec les
// fichiers CSV d'excel  (il a juste fallu modifier les points virgule avant
// le stockage et les remettre au déstockage

//==============================================================================
             END.
//==============================================================================


