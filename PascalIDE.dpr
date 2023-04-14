program PascalIDE;

uses
  System.StartUpCopy,
  FMX.Forms,
  Controller in 'Controller.pas' {Form1},
  FontManager in 'FontManager.pas',
  FileManager in 'FileManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
