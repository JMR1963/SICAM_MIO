unit WMfingerMatch;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

uses EgateFunciones,Winapi.Windows,Winapi.ShellAPI;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

var
  CriticalSection: TRTLCriticalSection;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s, transactionId, idLOC,Path: string;
  dir: string;
  score,r,i: Integer;
  StrL:TStringList;
begin

  Response.ContentType := 'application/json';
  Response.Content := '';

  Handled := True;
  if Request.MethodType <> mtPost then
    Exit;
  if Pos('fingermatch', LowerCase(Request.PathInfo)) > 0 then
  begin
    StrL:=TStringList.Create;
    try
      StrL.Text := StringReplace(Request.Content,'&',#13#10,[rfReplaceAll]);
      idLOC := StrL.Values['idLOC'];
      transactionId := StrL.Values['transactionId'];
      Path := DirTransac(idLOC,transactionId);

      ConvertStrBase64ToFile(StrL.Values['huella'],DirTransac(idLOC,transactionId)+'huella2.wsq');

      grabarArchivoBat(Path + 'compH.bat', 'set path = ' + normalizoDir(ExtractFilePath(ParamStr(0))), normalizoDir(ExtractFilePath(ParamStr(0))) + 'CompararHuellasWSQ.exe ' + Path + 'huella1.wsq ' + Path + 'huella2.wsq', '', '', '');

      EnterCriticalSection(CriticalSection);
      try
        ShellExecute(0, 'open', PChar(Path + 'compH.bat'), '', PChar(Path), 0);

        while not FileExists(Path + 'finH.txt') do
          Sleep(3);

        for I := 0 to 5 do
        try
          R := leerInt(Path + 'finH.txt');
          Break;
        except
          R := -1;
          Sleep(100);
        end;
      finally
        LeaveCriticalSection(CriticalSection);
      end;
    finally
      StrL.Free;
      Response.Content := IntToStr(R);
    end;
  end;
end;

initialization
  InitializeCriticalSection(CriticalSection);

finalization
  DeleteCriticalSection(CriticalSection);

end.
