program TextFactory;

uses
  Vcl.Forms,
  _fmMain in '_fmMain.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Cyan Night');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
