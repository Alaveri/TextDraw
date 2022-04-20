{$I compiler.inc}
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
  App.Create('Application', 65536);
  App.Run;
  App.Done;

end.