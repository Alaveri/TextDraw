unit DrawApp;

interface

uses
  Crt,
  Objects,
  TextDrv,
  SvgaText,
  TextIni,
  WideStr,
  Apps,
  TextApp,
  Drawing,
  Utils,
  Controls,
  MouseDrv;

type
  TDrawApp = object(TTextApplication)
  private
  public
    procedure MainLoop; virtual;
    procedure ProcessEvents; virtual;
    procedure Init; virtual;
    procedure InitControls; virtual;
    procedure InitMenuBar; virtual;
    destructor Done; virtual;
  end;

implementation

procedure TDrawApp.ProcessEvents;
var
  ch: char;
begin
  if (KeyPressed) then begin
    ch := ReadKey;
    if (ch = #27) then Close;
  end;
end;

procedure TDrawApp.MainLoop;
begin
end;

procedure TDrawApp.InitMenuBar;
var
  item: PMenuItem;
  menu: PMenu;
begin
  menu := New(PMenu, Create('FileMenu'));
  item := New(PMenuItem, CreateMenuBar('FileMenuItem', '&File', Desktop^.MenuBar, menu, 0, nil));
  item := New(PMenuItem, CreateText('ExitMenuItem', 'E&xit', menu, 0, nil));
end;

procedure TDrawApp.InitControls;
begin
  InitMenuBar;
end;

procedure TDrawApp.Init;
var
  st: TWideString;
  rect: TRect;
begin
  TApplication.Init;
  TypeName := 'TDrawApp';
  InitTextDriver(tdSvgaText, 'SVgaText128x48');
  if (TextDriver.Error.ErrorCode <> ecNone) then
  begin
    WriteLn('Error: ', TextDriver.Error.ErrorCode, ': ', TextDriver.Error.ErrorMessage);
    Close;
    exit;
  end
  else
  begin
    WriteLn('Text Driver initialized.');
  end;
  TextDriver.CursorOff;
  TTextApplication.Init;
  InitControls;
  Desktop^.Draw;
  TextDriver.SetXY(10, 10);
  TextDriver.Write('This is a test of the font system.');
  MouseDriver.ShowMouse;
end;

destructor TDrawApp.Done;
begin
end;

end.
