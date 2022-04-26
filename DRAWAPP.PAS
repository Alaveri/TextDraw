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
    procedure InitDefaultColors; virtual;
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

procedure TDrawApp.InitDefaultColors;
begin
  icDesktop := Graphics.GetColor(scWhite, MaxIntensity);
  icDesktopBack := Graphics.GetColor(scGreen, MaxIntensity);
  icWindow := Graphics.GetColor(scBlack, 0);
  icWindowBack := Graphics.GetColor(scWhite, MaxIntensity);
  icBorder := Graphics.GetColor(scBlack, 0);
  icButton := Graphics.GetColor(scBlack, 0);
  icButtonBack := Graphics.GetColor(scWhite, Intensity75);
  icButtonDown := Graphics.GetColor(scBlack, 0);
  icButtonDownBack := Graphics.GetColor(scWhite, Intensity75);
  icButtonHotKey := Graphics.GetColor(scRed, MaxIntensity);
  icButtonShadow := Graphics.GetColor(scWhite, Intensity50);
  icButtonHighlight := Graphics.GetColor(scWhite, 11);
  icWindowTitle := Graphics.GetColor(scBlack, 0);
  icWindowTitleBack := Graphics.GetColor(scGreen, MaxIntensity);
  icMenu := Graphics.GetColor(scBlack, 0);
  icMenuBack := Graphics.GetColor(scWhite, MaxIntensity);
  icHotKey := Graphics.GetColor(scRed, MaxIntensity);
  icScroll := Graphics.GetColor(scBlack, 0);
  icScrollBack := Graphics.GetColor(scWhite, Intensity50);
  icEditor := Graphics.GetColor(scBlack, MaxIntensity);
  icEditorBack := Graphics.GetColor(scWhite, MaxIntensity);
  icDialog := Graphics.GetColor(scBlack, 0);
  icDialogBack := Graphics.GetColor(scCyan, MaxIntensity);
  icSelect := Graphics.GetColor(scWhite, MaxIntensity);
  icSelectBack := Graphics.GetColor(scGreen, MaxIntensity);
  icFocused := Graphics.GetColor(scGreen, MaxIntensity);
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
  InitDefaultColors;
  Desktop^.Draw;
  MouseDriver.ShowMouse;
end;

destructor TDrawApp.Done;
begin
end;

end.
