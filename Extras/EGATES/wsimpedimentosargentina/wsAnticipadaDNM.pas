unit wsAnticipadaDNM;

interface

  function ConsultarwsAnticipadaDNM(AnticipadaDNM,TRANSITODIRECCION,NRO_LIBRETA,APE_1,NOM_1,NRO_DOCUMENTO, FECHA_NAC,TIPO_PASO:string):string;

implementation

uses IwsAnticipadaDNM4, System.Classes, System.SysUtils;

function ConsultarwsAnticipadaDNM(AnticipadaDNM,TRANSITODIRECCION,NRO_LIBRETA,APE_1,NOM_1,NRO_DOCUMENTO, FECHA_NAC,TIPO_PASO:string):string;
var
  solicitante : Tentrada_2;
begin
  Result := '';

  {
  parambyname('unaDireccion').value := UpperCase(entrada.TRANSITODIRECCION);
  parambyname('unDOc').value := UpperCase(entrada.NRO_DOCUMENTO);
  parambyname('unaFechaNac').value := entrada.FECHA_NAC;
  parambyname('unaLibreta').value := UpperCase(entrada.NRO_LIBRETA);
  parambyname('unApellido1').value := UpperCase(entrada.APELLIDO_1);
  parambyname('unNombre1').value := UpperCase(entrada.NOMBRE_1);}

  solicitante := Tentrada_2.Create;
  try
    solicitante.TRANSITODIRECCION   := TRANSITODIRECCION;
    solicitante.NRO_LIBRETA         := NRO_LIBRETA;
    solicitante.NRO_DOCUMENTO       := NRO_DOCUMENTO;
    solicitante.FECHA_NAC           := FECHA_NAC; // string dd/mm/yyyy
    solicitante.APELLIDO_1          := APE_1;
    solicitante.NOMBRE_1            := NOM_1;
    solicitante.TIPO_PASO           := TIPO_PASO;
    Result := GetIwsAnticipadaDNM(AnticipadaDNM).consultarSolicitud_2(solicitante).Rta;

  finally
    solicitante.Free;
  end;
end;


end.


