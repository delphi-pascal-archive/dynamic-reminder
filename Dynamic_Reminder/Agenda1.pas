unit Agenda1;

///=============================================================================
           interface
///=============================================================================

uses  Forms
    , ALIAS, Classes, Controls, StdCtrls, ExtCtrls ,dialogs
    , Graphics  // pour tfontstyles
    , SysUtils
    , StrUtils  // pour dupestring
    , gestH
    , DateUtils  // pour monthOf
    ;

const
  Version = '0.1';
  Ksem  = 'Monday;Tuesday;Wednesday;Thursday;Friday;Saturday;Sunday';
  Kmois = 'January;February;March;April;May;June;July;August;September;October;November;December';

Type
  TForm1 = class(TForm)
    lQUITTER: TLabel;
    Pmemo: TPanel;
    bRETOUR: TButton;
    Ljour: TLabel;
    M1: TMemo;
    L1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure INIT;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure bRETOURClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    {  }
  public
    procedure QUITTER;
    procedure Bidon(Sender: TObject);
    procedure ClicMOIS(Sender: TObject);
    procedure ClicJOUR(Sender: TObject);
   {$I tabloB.int}  // pas su le mettre en unit
   {$I tabloP.int}  // pas su le mettre en unit
    procedure CREER;
  end;


var
  Form1: TForm1;
  K1,K2 : string; // pas mis en const sinon non reconnu dans GetH
  MOIS : integer;
  JOUR : integer;
  FIC : string;

///=============================================================================
         implementation
///=============================================================================

{$R *.dfm}
{$I tabloB.imp}    // pas su le mettre en unit
{$I tabloP.imp}    // pas su le mettre en unit

//------------------------------------------------------------------------------
function Hjour(M:integer):string;
// renvoie la chaine de type H vour afficher les jours du MOIS (2010)
var H : string; i:integer;
begin
  H := dupestring(';',getH(K1,M));
  for i:=1 to geth(K2,M) do addH(H, inttostr(i));
  H := H + dupestring(';',42-getH(K1,M)-getH(K2,M));
  result := H;
end;

//------------------------------------------------------------------------------
function NomJour(J,M:integer):string;   // renvoie le nom du bouton Jour Mois
var n:integer;
begin
  n := geth(K1,M) + J;
  result := 'BJOUR' + inttostr(n);
end;

//------------------------------------------------------------------------------
procedure TForm1.bidon(Sender: TObject); begin {rien} end;
//------------------------------------------------------------------------------
procedure TForm1.ClicMOIS(Sender: TObject);
var n:integer;  Z:string;
begin
  if tpanel(sender).caption='' then exit;
  n := tpanel(sender).Tag;
  if n=MOIS then exit;   // déjà enfoncé
  Z := 'BMOIS' + inttostr(MOIS);
  if MOIS<>0 then begin
     TPanel(findComponent(z)).BevelOuter := bvRaised;
     TPanel(findComponent(z)).Color := clyellow; //jaune;
     end;
  MOIS := n;
  tpanel(sender).Color := cllime;
  tpanel(sender).BevelOuter := bvLowered;
  CaptionsBoutons('BJOUR',6,7,Hjour(MOIS));
end;

//------------------------------------------------------------------------------
procedure TForm1.ClicJOUR(Sender: TObject);
var K:string;   n:integer;
begin
  if Tbutton(sender).caption='' then exit;
  K := Kmois;
  JOUR := Tbutton(sender).tag - geth(K1,MOIS);
  Ljour.Caption := inttostr(JOUR) + ' ' + getH(K,MOIS-1) + ' 2010';
  n := (MOIS-1)*42+JOUR;
  // H := LIG(L1,n);
  ChgH(M1,LIG(L1,n));
  VIS(Pmemo);
end;

//------------------------------------------------------------------------------
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction); begin QUITTER end;
procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
  begin if Key=#27 then QUITTER; end;
procedure TForm1.QUITTER;
begin
  hide; // pour eviter de voir l'effacement des boutons
  SVG(L1,FIC);
  FreeBoutons('BSEM',1,7);
  FreeBoutons('BOIS',12,1);
  FreeBoutons('BJOUR',6,7);
  application.Terminate
end;

//------------------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject); begin INIT end;
procedure TForm1.INIT;
begin
  K1 := ';4;0;0;3;5;1;3;6;2;4;0;2';
  K2 := ';31;28;31;30;31;30;31;31;30;31;30;31';
  setbounds(200,200,536,356);
  caption := 'Reminder - ' + version +'/' + ALIASversion + '/' + gestHversion;
  creaPanels('BSEM',1,7,60,20,100,0,Ksem,claqua,bidon);
  creaPanels('BMOIS',12,1,100,25,0,20,Kmois,clyellow, ClicMOIS);
  creaBoutons('BJOUR',6,7,60,50,100,20,dupestring(';',42),ClicJour);
  FontBoutons('BJOUR',6,7,13);
  GrasBoutons('BJOUR',6,7);
  MOIS := MonthOf(date);
  CaptionsBoutons('BJOUR',6,7,Hjour(MOIS));
  TPanel(findComponent('BMOIS' + inttostr(MOIS))).Color := cllime;
  TPanel(findComponent('BMOIS' + inttostr(MOIS))).BevelOuter := bvLowered;
  Pmemo.BringToFront;
  FIC := 'agenda.2008';
  if not FileExists(FIC) then CREER;
  CHG(L1,FIC);
end;

//------------------------------------------------------------------------------
procedure TForm1.CREER;
var i:integer;
begin
  for i:=0 to 505 do ADD(L1,';'); // 2lignes vides
  SVG(L1,FIC);
end;

//------------------------------------------------------------------------------
procedure TForm1.bRETOURClick(Sender: TObject);
var n:integer;
begin
  n := (MOIS-1)*42+JOUR;
  ECR(L1,n,SvgH(M1));
  EFF(Pmemo)
end;  

end.
