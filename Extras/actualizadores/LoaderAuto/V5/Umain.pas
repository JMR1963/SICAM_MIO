unit uMain;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Winapi.ShellAPI, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Winapi.Windows, Vcl.Menus, uResourceString;

type
  TMain = class(TObject)
  private
    hIcn: HICON;
    icnDt: NOTIFYICONDATA;
    H_Wnd: HWND;
    Tmr: Integer;     // Para el temporizador
    CrtRes: Boolean;  // Resultado de las operaciones en la creación de la clase
    Popup: TPopupMenu;
    procedure MessageManager(var Msg: TMessage);
    procedure NotifyIcon(IcnPth: string);
    procedure UnnotifyIcon;
    procedure CreatePopup;
    procedure DestroyPopup;
    procedure OnTerminateClick(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    function CreationResult: Boolean;
    function Loop: Integer;
  end;

implementation

uses
  uExtra, uCommon;

const
  ICON_NAME = 'icon.ico';
  { Modificar la versión en cada realización estable.
   No cada vez que se compila. }
  MSG_NOTIFIED_ICON = 'Actualizador V 1.5.01'#$D#$A'Iniciado ';
  WM_CTRLLIST = WM_USER + 1;  // Mensaje del ícono notificado
  TIMER_ID = $0001;           // Identificador del temporizador

procedure TMain.MessageManager(var Msg: TMessage);
begin
  case Msg.Msg of
    WM_CTRLLIST:         // Mensaje desde el ícono notificado
      case Msg.LParamLo of
        WM_RBUTTONDOWN:  // Click derecho sobre el ícono notificado
          if Assigned(Popup) then
            Popup.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
      end;
    WM_TIMER:        // Expiración del temporizador
      MainBooble;     // Llamar a proceso principal
  else
    DefWindowProc(H_Wnd, Msg.Msg, Msg.WParam, Msg.LParam);
  end;
end;

procedure TMain.NotifyIcon(IcnPth: string);
begin
  { Cargar ícono }
  hIcn := LoadImage(0, PWideChar(IcnPth), IMAGE_ICON, 0, 0, LR_LOADFROMFILE);
  if hIcn <> NULL then
  begin
    icnDt.cbSize := SizeOf(icnDt);
    icnDt.Wnd := H_Wnd;
    icnDt.uID := 0;
    icnDt.uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
    icnDt.uCallbackMessage := WM_CTRLLIST;
    icnDt.hIcon := hIcn;
    StrCopy(icnDt.szTip, MSG_NOTIFIED_ICON);
    StrCat(icnDt.szTip, PChar(DateTimeToStr(Now)));
    { Notificar el ícono }
    Shell_NotifyIcon(NIM_ADD, @icnDt);
  end;
end;

procedure TMain.UnnotifyIcon;
begin
  { Desnotificar el ícono }
  Shell_NotifyIcon(NIM_DELETE, @icnDt);
end;

procedure TMain.CreatePopup;
var
  Item: TMenuItem;
begin
  try
    Popup := TPopupMenu.Create(nil);
    //Popup.WindowHandle := H_Wnd;
    Popup.AutoPopup := False;
    Item := TMenuItem.Create(Popup);
    Item.OnClick := OnTerminateClick;
    Item.Caption := 'Terminar';
    Popup.Items.Add(Item);
  except
  end;
end;

procedure TMain.DestroyPopup;
begin
  Popup.Free;
end;

procedure TMain.OnTerminateClick(Sender: TObject);
begin
  PostQuitMessage(0);
end;

constructor TMain.Create;
  {
  Lleva a cabo tareas de inicialización.
  Si todo termina bien CrtRes se pone en True, si no, False.
}
var
  Temp: string;
begin
  inherited Create;
  if not CreateSections then
  begin
    CrtRes := False;
    Exit;
  end;
  { Alocar un handle para manejo de mensajes del ícono }
  H_Wnd := AllocateHWnd(MessageManager);
  { Creamos pop-up menu }
  CreatePopup;
  { Obtener directorio corriente }
  Temp := IncludeTrailingPathDelimiter(GetCurrentDir);
  { Setear el directorio corriente }
  SetWorkPath(Temp);
  { Notificar ícono }
  NotifyIcon(Temp + ICON_NAME);
  { Procesar archivo de inicio ... }
  if not ProcessIniFile then
  begin
    { ... si está corrupto, terminar }
    CrtRes := False;
    Exit;
  end;
  { Procesar archivos }
  CrtRes := MainBooble();
  if not CrtRes then
    exit;
  { Crear un temporizador }
  Tmr := SetTimer(H_Wnd, TIMER_ID, StrToInt(local.Values[TIMER_TIME]), nil);
  { Si Tmr = 0 ... }
  if Tmr = 0 then
  begin
  { ... terminar. Error al crear el temporizador }
    CrtRes := False;
    Exit;
  end;
  { Si todo salió bien }
  CrtRes := True;
end;

destructor TMain.Destroy;
begin
  DestroySections;
  DestroyPopup;
  { Quitar ícono notificado }
  UnnotifyIcon;
  { Destruir el temporizador }
  KillTimer(H_Wnd, TIMER_ID);
  { Desalocar handle para manejo de mensajes }
  DeallocateHWnd(H_Wnd);
  inherited Destroy;
end;

function TMain.CreationResult: Boolean;
{
  Devuelve el resultado de la inicialización en el Create.
}
begin
  Result := CrtRes;
end;

function TMain.Loop: Integer;
{
  Manejo de la cola de mensajes.
}
var
  mess: tagMSG;
begin
  { Loop de mensajes }
  while (Integer(GetMessage(mess, 0, 0, 0)) > 0) do
  begin
    DispatchMessage(mess);
    TranslateMessage(mess);
  end;
  { Retornar resultado }
  Result := mess.wParam;
end;

end.

