unit uFirmaDll;

interface
uses
  Windows;
var
  handleDllFirma : THandle;
  TarOpen : function() : Boolean;StdCall;
  TarSerie : function() :Pchar;StdCall;
  TarCerSerie : function() :Pchar;StdCall;
  TarSalvarCer : function (aArch:PChar):Boolean;StdCall;
  TarClose : function() :Boolean;StdCall;
  Coinit : procedure() ;StdCall;
  ErrorMsg : function() :Pchar;StdCall;

  VerFirStr: function (aCadFirmada: PChar;aArch: PChar):Boolean;StdCall;
  FirStr: function (aCadFirmada: PChar;aArch: PChar):Boolean;StdCall;

  FirArch: function (archOriginal,archFirmado: PChar):Boolean; StdCall;
  VerArc: function (aFirmado,aOriginal: PChar): Boolean; StdCall;
  estaTarjeta : function : Boolean; StdCall;
  ExisteUsuario : function (aUsuario:PChar):Boolean;StdCall;

  TarjetaInformacion :function (usuario:Pchar;ArchCert:Pchar;var NroCredencial, NroCertificado:Pchar):boolean;StdCall;
  Procedure cargarDllFirma;
  Procedure destruirDllFirma;

implementation


Procedure cargarDllFirma;
begin
  handleDllFirma := LoadLibrary('DLLFirma.dll');
  if (handleDllFirma <>  0) then
  begin
    TarOpen := GetProcAddress(handleDllFirma, 'TarjetaAbrir');
    TarSerie := GetProcAddress(handleDllFirma, 'TarjetaNumeroSerie');
    TarCerSerie := GetProcAddress(handleDllFirma, 'TarjetaCertificadoNumeroSerie');
    TarSalvarCer :=GetProcAddress(handleDllFirma, 'TarjetaSalvarCertificado');
    TarClose :=GetProcAddress(handleDllFirma, 'TarjetaCerrar');
    
    Coinit := GetProcAddress(handleDllFirma, 'Coinit');
    VerFirStr := GetProcAddress(handleDllFirma, 'verificarFirmaCadena');
    FirStr := GetProcAddress(handleDllFirma, 'FirmarCadena');
    FirArch :=GetProcAddress(handleDllFirma, 'FirmarArchivo');
    VerArc :=GetProcAddress(handleDllFirma, 'verificarFirmaArchivo');
    ErrorMsg := GetProcAddress(handleDllFirma, 'ErrorMsg');
    estatarjeta :=  GetProcAddress(handleDllFirma, 'estaTarjeta');
    TarjetaInformacion := GetProcAddress(handleDllFirma, 'TarjetaInformacion');
    ExisteUsuario := GetProcAddress(handleDllFirma, 'ExisteUsuario');
    Coinit;
  end;
end;

Procedure destruirDllFirma;
begin
    FreeLibrary(handleDllFirma);
end;


end.




