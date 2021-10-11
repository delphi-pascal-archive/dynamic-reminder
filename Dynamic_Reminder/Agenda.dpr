program Agenda;

uses
  Forms,
  Agenda1 in 'Agenda1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
