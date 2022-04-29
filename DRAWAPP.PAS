unit DrawApp;

interface

uses
  Crt,
  Objects,
  TextDrv,
  SvgaText,
  TextIni,
  WideStr,
  GraphDrv,
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
  TTextApplication.ProcessEvents;
  if (KeyPressed) then
  begin
    ch := ReadKey;
    if (ch = #27) then Close;
  end;
end;

procedure TDrawApp.MainLoop;
begin
  TTextApplication.MainLoop;
end;

procedure TDrawApp.InitMenuBar;
var
  item: PMenuItem;
  menu: PMenu;
begin
  menu := New(PMenu, Create('FileMenu'));
  item := New(PMenuItem, CreateMenuBar('FileMenuItem', '&File', Desktop^.MenuBar, menu, 0, nil));
  item := New(PMenuItem, CreateText('ExitMenuItem', 'E&xit', menu, 0, nil));
  menu := New(PMenu, Create('EditMenu'));
  item := New(PMenuItem, CreateMenuBar('EditMenuItem', '&Edit', Desktop^.MenuBar, menu, 0, nil));
  menu := New(PMenu, Create('ViewMenu'));
  item := New(PMenuItem, CreateMenuBar('ViewMenuItem', '&View', Desktop^.MenuBar, menu, 0, nil));
  menu := New(PMenu, Create('ToolsMenu'));
  item := New(PMenuItem, CreateMenuBar('ToolsMenuItem', '&Tools', Desktop^.MenuBar, menu, 0, nil));
  menu := New(PMenu, Create('HelpMenu'));
  item := New(PMenuItem, CreateMenuBar('HelpMenuItem', '&Help', Desktop^.MenuBar, menu, 0, nil));
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
  InitTextDriver(tdSvgaText, 'SVgaText128x48x8');
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
  MouseDriver.ShowMouse;
end;

destructor TDrawApp.Done;
begin
  TextDriver.Done;
end;

end.
