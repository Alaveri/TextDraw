{$I COMPILER.INC}
program TextDraw(input, output);

uses
  Objects,
  DrawApp,
  Globals,
  Utils,
  Controls;

begin
  ExeName := ParamStr(0);
  AppDirectory := ExtractFilePath(ExeName);
  App.Create('Application', 65535);
  App.Run;
  App.Done;

end.