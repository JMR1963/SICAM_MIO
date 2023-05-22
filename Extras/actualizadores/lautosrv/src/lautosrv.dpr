program lautosrv;

{$I Defines.inc}

uses
  SysUtils,
  Windows,
  WinSvc,
  Classes,
  DateUtils,

  uConsts in 'uConsts.pas',
  uDatabase in 'uDatabase.pas',
{$IFDEF DIAL_UP}
  uDialup in 'uDialup.pas',
{$ENDIF}
  uGlobal in 'uGlobal.pas',
  uHttp in 'uHttp.pas',
  uInitialize in 'uInitialize.pas',
  uMain in 'uMain.pas',
  uUtils in 'uUtils.pas';

procedure ThreadProc(lpParameter: Pointer); stdcall;
//var
//  lpDueTime: LARGE_INTEGER;
//  secs: Int64;
begin
  {
  // Segundos entre las dos marcas de tiempo.
  secs := (MinuteOf(Time) - g_startminutes) * 60;
  // Se pasan los segundos a nanosegundos o sea multiplicamos por 1000^3.
  // Ahora para que el tiempo sea relativo al actual debemos pasar una cantidad negativa.
  if secs <= 0 then
    // En este caso tenemos la cantidad de segundos entre las dos marcas de tiempo pasadas a
    // 100 * nanosegundo y multiplicadas por -1 para que el tiempo sea relativo al actual.
    // Ignorando el signo negativo, en "secs" segundos el actualizador comenzará el proceso.
    lpDueTime.QuadPart := secs * 10000000
  else
    // Este caso es igual al anterior pero multiplicamos por 1 hora. Así la actualización comienza
    // 60 minutos después de lo indicado por "startminutes".
    lpDueTime.QuadPart := -1 * (3600 - secs) * 10000000;
  if not SetWaitableTimer(g_timer, lpDueTime.QuadPart, g_timertime, nil, nil, FALSE) then
  begin
    g_sstatus.dwCurrentState := SERVICE_STOPPED;
    g_sstatus.dwCheckPoint := 0;
    g_sstatus.dwWaitHint := 0;
//    g_sstatus.dwWin32ExitCode := STS_FAILED;
//    g_sstatus.dwServiceSpecificExitCode := SE_SET_TIMER_FAILED;
    SetServiceStatus(g_sshandle, g_sstatus);
    Exit;
  end;
  while not g_terminated do
  begin
    // Esperar hasta que el timer expire
    if WaitForSingleObject(g_timer, INFINITE) <> WAIT_OBJECT_0 then
    begin
      g_sstatus.dwCurrentState := SERVICE_STOPPED;
      g_sstatus.dwCheckPoint := 0;
      g_sstatus.dwWaitHint := 0;
//      g_sstatus.dwWin32ExitCode := STS_FAILED;
//      g_sstatus.dwServiceSpecificExitCode := SE_WAIT_TIME_FAILED;
      SetServiceStatus(g_sshandle, g_sstatus);
      Exit;
    end;
    DoProcess(g_baselist);
    WriteLog(LOG_GOING_TO_SLEEP);
  end;    }
  DoProcess(g_baselist);
end;

procedure HandlerFunction(fdwControl: DWORD); stdcall;
begin
  case fdwControl of
    SERVICE_CONTROL_STOP:
      begin

        // tareas de finalizacion aqui
        CleanupService;

        g_sstatus.dwWin32ExitCode := 0;
        g_sstatus.dwCurrentState := SERVICE_STOPPED;
        g_sstatus.dwCheckPoint := 0;
        g_sstatus.dwWaitHint := 0;

        if not SetServiceStatus(g_sshandle, g_sstatus) then
          OutputDebugStringA(PAnsiChar(MSG_SRV_STATUS_FAILED + ':' + AnsiString(IntToStr(GetLastError))));

        OutputDebugStringA(MSG_LEAVING_SERVICE);
      end;

    SERVICE_CONTROL_INTERROGATE:
      begin
      end;

  else
    OutputDebugStringA(PAnsiChar(MSG_UNRECOGNIZED_CTRL_CODE + ':' + AnsiString(IntToStr(fdwControl))));
  end;
end;

procedure ServiceMain(dwArgc: DWORD; lpszArgv: LPTSTR); stdcall;
var
  status: Integer;         // Estado devuelto por la inicialización del servicio
  specificError: Integer;  // Error de inicialización específico de este servicio
begin
  g_sstatus.dwServiceType := SERVICE_WIN32_OWN_PROCESS;
  g_sstatus.dwCurrentState := SERVICE_START_PENDING;
  g_sstatus.dwControlsAccepted := SERVICE_ACCEPT_STOP;
  g_sstatus.dwWin32ExitCode := 0;
  g_sstatus.dwServiceSpecificExitCode := 0;
  g_sstatus.dwCheckPoint := 0;
  g_sstatus.dwWaitHint := 0;

  g_sshandle := RegisterServiceCtrlHandler(CNT_SERVICE_NAME, @HandlerFunction);

  if g_sshandle = 0 then
  begin
    OutputDebugStringA(PAnsiChar(MSG_REGISTERING_SCH + ':' + AnsiString(IntToStr(GetLastError))));
    Exit;
  end;

  // ServiceInicialization es la función de inicialización.
  // status un DWORD que inidca el código de estado.
  // specificError un DWORD que indica un error específico de inicialización.
  status := InitializeService(specificError);
  if (status <> NO_ERROR) then
  begin
    g_sstatus.dwCurrentState := SERVICE_STOPPED;
    g_sstatus.dwCheckPoint := 0;
    g_sstatus.dwWaitHint := 0;
    g_sstatus.dwWin32ExitCode := status;
    g_sstatus.dwServiceSpecificExitCode := specificError;
    SetServiceStatus(g_sshandle, g_sstatus);
    Exit;
  end;

  g_sstatus.dwCurrentState := SERVICE_RUNNING;
  g_sstatus.dwCheckPoint := 0;
  g_sstatus.dwWaitHint := 0;

  if not SetServiceStatus(g_sshandle, g_sstatus) then
  begin
    OutputDebugStringA(PAnsiChar(MSG_SRV_STATUS_FAILED + ':' + AnsiString(IntToStr(GetLastError))));
    Exit;
  end;

  // A partir de aquí el servicio comienza con su tarea.
  g_thmain := CreateThread(nil, 0, @ThreadProc, @g_thparam, 0, g_thmainid);
  if g_thmain = 0 then
    OutputDebugStringA(PAnsiChar(MSG_MAIN_THREAD_FAILED + ':' + AnsiString(IntToStr(GetLastError))));

end;

procedure InstallService;
const
  MOD_SIZE = 500;
var
  smhandle: SC_HANDLE;
  shandle: SC_HANDLE;
  modname: PWideChar;
begin
  smhandle := OpenSCManager(nil, nil, SC_MANAGER_CREATE_SERVICE);
  if smhandle = 0 then
    OutputDebugStringA(PAnsiChar(MSG_OPEN_SCM_FAILED + ':' + AnsiString(IntToStr(GetLastError))))
  else
  begin
    GetMem(modname, MOD_SIZE);
    GetModuleFileName(0, modname, MOD_SIZE);
    shandle := CreateService(smhandle, CNT_SERVICE_NAME, SRV_DISPLAY_NAME, SERVICE_ALL_ACCESS, SERVICE_WIN32_OWN_PROCESS,
      SERVICE_AUTO_START, SERVICE_ERROR_NORMAL, modname, nil, nil, nil, nil, nil);
    if shandle = 0 then
      OutputDebugStringA(PAnsiChar(MSG_SRV_CREATION_FAILED + ':' + AnsiString(IntToStr(GetLastError))))
    else
      CloseServiceHandle(shandle);
    FreeMem(modname);
    CloseServiceHandle(smhandle);
  end;
end;

procedure UninstallService;
var
  smhandle: SC_HANDLE;
  shandle: SC_HANDLE;
  errorCode: AnsiString;
begin
  smhandle := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if smhandle = 0 then
  begin

    errorCode := AnsiString(IntToStr(GetLastError));
    OutputDebugStringA(PAnsiChar(MSG_OPEN_SCM_FAILED + ':' + errorCode));
  end
  else
  begin
    shandle := OpenService(smhandle, CNT_SERVICE_NAME, SERVICE_ALL_ACCESS);
    if shandle = 0 then
      OutputDebugStringA(PAnsiChar(MSG_SRV_DELETION_FAILED + ':' + AnsiString(IntToStr(GetLastError))))
    else
    begin
      if not DeleteService(shandle) then
        OutputDebugStringA(PAnsiChar(MSG_SRV_DELETION_FAILED + ':' + AnsiString(IntToStr(GetLastError))));
      CloseServiceHandle(shandle);
    end;
    CloseServiceHandle(smhandle);
  end;
end;

procedure ProcessCmdLine;
begin
  if ParamCount > 0 then
    if ParamStr(1) = CMD_LINE_INSTALL then
      InstallService
    else if ParamStr(1) = CMD_LINE_UNINSTALL then
      UninstallService;
end;

var
  stentry: SERVICE_TABLE_ENTRY;

begin
  ProcessCmdLine;
  stentry.lpServiceName := CNT_SERVICE_NAME;
  stentry.lpServiceProc := @ServiceMain;
  if StartServiceCtrlDispatcher(stentry) then
    OutputDebugStringA(PAnsiChar(MSG_START_SCD_FAILED + ':' + AnsiString(IntToStr(GetLastError))));
end.

