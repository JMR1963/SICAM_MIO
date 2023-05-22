unit uMisc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, IBCustomDataSet, IBStoredProc, IBDatabase, ShellApi;

  function WinExecAndWait32(FileName:String; Visibility:integer):integer;

implementation

function WinExecAndWait32(FileName:String; Visibility:integer):integer;
var
  zAppName:array[0..512] of char;
  zCurDir:array[0..255] of char;
  WorkDir:String;
  StartupInfo:TStartupInfo;
  ProcessInfo:TProcessInformation;
  Resultado,exitCode: DWord;
begin
  StrPCopy(zAppName,FileName);
  GetDir(0,WorkDir);
  StrPCopy(zCurDir,WorkDir);
  FillChar(StartupInfo,Sizeof(StartupInfo),#0);
  StartupInfo.cb := Sizeof(StartupInfo);

  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  CreateProcess(nil,
    zAppName,                      { pointer to command line string }
    nil,                           { pointer to process security attributes}
    nil,                           { pointer to thread security attributes}
    false,                         { handle inheritance flag }
    CREATE_NEW_CONSOLE or          { creation flags }
    NORMAL_PRIORITY_CLASS,
    nil,                           { pointer to new environment block }
    nil,                           { pointer to current directory name }
    StartupInfo,                   { pointer to STARTUPINFO }
    ProcessInfo);
 
  {Espera a que termine la ejecucion}
  {Wait until execution finish}
  repeat 
    exitCode := WaitForSingleObject( ProcessInfo.hProcess,1000);
    Application.ProcessMessages;
  until (exitCode <> WAIT_TIMEOUT);

  GetExitCodeProcess(ProcessInfo.hProcess,Resultado);
  MessageBeep(0);
  CloseHandle(ProcessInfo.hProcess );
  Result:=Resultado;
end;

end.
