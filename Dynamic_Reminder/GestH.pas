{============================================================================}
                                  unit GestH;
{============================================================================}
// dernière mise à jour : 13/10/2009
{============================================================================}
                                  interface
{============================================================================}

{-----------------------------------------------------------}
                             uses
{-----------------------------------------------------------}
  SysUtils, StrUtils,
  Dialogs,
  Classes,  Controls;

const GestHversion = '1'; 
  
  
procedure RAZH(var h:string);                       // h = ''
function  QTEH(var h:string):integer;               // nbre de champs
function  DERH(var h:string):integer;               // n° du dernier champ (DIMH-1)
procedure ADDH(var h:string; v:variant);            // ajoute le champ v à la fin
procedure INSH(var h:string; v:variant; n:integer); // insère v pos n  h=a;b;c;d  insh(h,9,1)-> a;9;b;c;d
procedure DELH(var h:string; n:integer);            // supprime champ n h=a;b;c;d   delh(h,1)-> a;c;d
procedure PUTH(var h:string; v:variant; n:integer); // ecrit champ v à pos n h=a;b;c;d   ecrh(h,9,1)-> a;9;c;d
function  GETH(var h:string; n:integer):variant;    //h=a;b;c;d   geth(h,1)-> b
function  XofH(var h:string; v:variant; e:integer=1):integer;
   /// renvoie position colonne de V dans H
   /// h=a;b;c;d   XofH(h,'b')-> 1  XofH(h,'z')-> -1
   /// si e=1 ou omis : Majus ou Minus, sinon Test carac

{============================================================================}
                                  implementation
{============================================================================}

//procedure Msg(t:string); begin messageDLG(t,mtinformation,[mbOk],0) end;

procedure RAZH(var h:string);            // h = ''
begin h := ''; end;

//-------------------------------------------------------------
function  QTEH(var h:string):integer;    // nbre de champs
var c,n:integer;
begin
result := 0;
if trim(h)='' then exit;
result := 1;
n := pos(';',h);
if n=0 then exit;
c := 2;
repeat
    n := posEx(';',h,n+1);   // n+1
    if n>0 then inc(C);
until n=0;
result := c;
end;

//-------------------------------------------------------------
function  DERH(var h:string):integer;    // n° du dernier champ (DIMH-1)
begin
result := QTEH(h)-1;
end;

//-------------------------------------------------------------
procedure ADDH(var h:string; v:variant); // ajoute le champ v à la fin
begin
h := h + ';' + v;
end;

//-------------------------------------------------------------
procedure INSH(var h:string; v:variant; n:integer); // ajoute le champ v à la pos n
  ///  h=a;b;c;d   insh(h,9,1)-> a;9;b;c;d
var c,n1,n2,x:integer;
begin
c := derh(h);
if n>c then begin showmessage('Erreur : n > derh(h)'); exit end;
if c=0 then       // un seul champ
   begin
   h := v + ';' + h;            // x;a
   exit
   end;
x  := 0;
n1 := 0;
n2 := pos(';',h);
if n=0 then         // 1er champ
   begin
   h := v + ';' + h;   // a;b;c;d;e; -> x;a;b;c;d;e;
   exit
   end;
while n>x do begin
    inc(x);
    n1 := n2;
    n2 := posEx(';',h,n1+1);
    end;
h := copy(h,1,n1) + v + ';' + copy(h,n1+1,length(h));
end;

//-------------------------------------------------------------
procedure DELH(var h:string; n:integer); // supprime le champ n
  ///  h=a;b;c;d   delh(h,1)-> a;c;d
var c,n1,n2,x:integer;
begin
c := derh(h);
if n>c then begin showmessage('Erreur : n > derh(h)'); exit end;
if c=0 then       // un seul champ
   begin
   h := '';
   exit
   end;
x := 0;
n1 := 0;
n2 := pos(';',h);
if n=0 then         // 1er champ
   begin
   h := copy(h,n2-1,length(h));   // a;b;c;d;e; -> b;c;d;e;
   exit
   end;
while n>x do begin
    inc(x);
    n1 := n2;
    n2 := posEx(';',h,n1+1);
    end;
if n=c
   then h := copy(h,1,n1-1)
   else h := copy(h,1,n1) + copy(h,n2+1,length(h));
end;

//-------------------------------------------------------------
procedure PUTH(var h:string; v:variant; n:integer); // ecrit le champ v à la pos n
  ///  h=a;b;c;d   ecrh(h,9,1)-> a;9;c;d
var c,n1,n2,x:integer;
begin
c := derh(h);
if n>c then begin showmessage('Erreur : n > derh(h)'); exit end;
if c=0 then       // un seul champ
   begin
   h := v;
   exit
   end;
x  := 0;
n1 := 0;
n2 := pos(';',h);
if n=0 then         // 1er champ
   begin
   h := v + copy(h,n2,length(h));   // v;x;x;x;x;
   exit
   end;
while n>x do begin
    inc(x);
    n1 := n2;
    n2 := posEx(';',h,n1+1);
    end;
if n=c
   then h := copy(h,1,n1) + v
   else h := copy(h,1,n1) + v + copy(h,n2,length(h));
end;

//-------------------------------------------------------------
function  GETH(var h:string; n:integer):variant;
  ///  h=a;b;c;d   geth(h,1)-> b
var c,n1,n2,x:integer;
begin
c := derh(h);
if n>c then begin showmessage('GETH(var h:string n:integer) : n > derh(h)'); exit end;
if c=0 then begin result := h; exit end;  // un seul champ
x := 0;
n1 := 0;
n2 := pos(';',h);
if n=0 then begin result := copy(h,1,n2-1); exit end;
while n>x do begin
    inc(x);
    n1 := n2;
    n2 := posEx(';',h,n1+1);
    end;
if n=c
   then result := copy(h,n1+1,length(h))
   else result := copy(h,n1+1,n2-n1-1);
end;

//-------------------------------------------------------------
function  XofH(var h:string; v:variant; e:integer=1):integer;
  /// renvoie position colonne de V dans H
  /// h=a;b;c;d   XofH(h,'b')-> 1  XofH(h,'z')-> -1
  /// si e=1 ou omis : Majus ou Minus, sinon Test carac
  var z:string; n,d:integer;
begin
 z := v;
 if e=1 then 
    begin
    H := uppercase(H);
    Z := uppercase(Z);
    end;
result := -1; // par défaut : pas trouvé
// x := -1;
n := -1; d := derh(H);
 while n<d do
   begin
   inc(n);
   if z=geth(H,n) then 
      begin
      result := n;
      n := d;
      end;
   end;
end;


{============================================================================}
                                  end.


