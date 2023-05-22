{ Invokable implementation File for TwsSolicitudConsular which implements IwsSolicitudConsular }

unit wsSolicitudConsularImpl;

interface

uses Soap.InvokeRegistry, system.Types, Soap.XSBuiltIns, system.Classes, system.sysutiLS, wsSolicitudConsularIntf, UDMDATOS, UBASE64;

type

  { TwsSolicitudConsular }
  TwsSolicitudConsular = class(TInvokableClass, IwsSolicitudConsular)
  private
    function getFileToStrSolicitud(pathFile : string): string;
  public
    function DataSolicitud(nro_doc, Nacionalidad:string):TConstancia; stdcall;
  end;

implementation

uses Data.DB, Ora;


function TwsSolicitudConsular.getFileToStrSolicitud(pathFile : string): string;
var
  fi: TFileStream;
  resultado : STRING;
begin
  if FileExists(pathFile ) then
  begin
      fi := TFileStream.Create(pathFile , fmOpenRead);
      fi.Position := 0;
      SetLength(resultado, fi.Size);
      fi.Read(pointer(resultado)^, fi.Size);
      fi.Free;
      result := resultado;
  end;
end;



function  TwsSolicitudConsular.DataSolicitud(nro_doc, Nacionalidad:string):TConstancia;
  var
    datos: TDatos;
    strFileDoc, strFileFacial: WideString;
    path: string;

  procedure cargar(estado : string);
  begin
        datos.APELLIDO := '';
        datos.APELLIDO1 := '';
        datos.NOMBRE := '';
        datos.NOMBRE1 :='';
        datos.NACIONALIDAD := '';
        datos.FECHA_NAC:= '';
        datos.NRO_DOC := '';
        datos.IMGFACIL:= '';
        datos.IMGDOC := '';
        Result.RESULTADO := estado;
        Result.datos := datos;
  end;

begin
  path := '';
  dmdatos := TDMDatos.Create(nil);
  if dmdatos.leerIni(path) then
  begin
    Result:= TConstancia.Create;
    datos := TDatos.create;
    with DMDatos.OraQuery1 do
    begin
      Try
        Close;
        sql.Clear;
        sql.LoadFromFile('.\consulta.sql');
        ParamByName('unaNac').AsString := Nacionalidad;
        ParamByName('unDoc').AsString := nro_doc;
        Open;
        if not IsEmpty then
        begin
          datos.APELLIDO := fieldbyname('apellido1').AsString;
          datos.APELLIDO1 := fieldbyname('apellido2').AsString;
          datos.NOMBRE := fieldbyname('nombre1').AsString;
          datos.NOMBRE1 := fieldbyname('nombre2').AsString;
          datos.NACIONALIDAD := fieldbyname('Nacionalidad').AsString;
          datos.FECHA_NAC := formatdatetime('dd/mm/yyyy', fieldbyname('fecha_nacimiento').AsDateTime);
          datos.NRO_DOC := fieldbyname('nro_documento').AsString;
          strFileDoc   := getFileToStrSolicitud(path+'\'+fieldbyname('imgdoc').AsString);
          datos.IMGDOC := Encode64(strFileDoc);
          strFileFacial   := getFileToStrSolicitud(path+'\'+fieldbyname('facial').AsString);
          datos.IMGFACIL := Encode64(strFileFacial);
          Result.RESULTADO := 'OK';
          Result.datos := datos;
        end
        else
          cargar('EMPTY');
      except
          cargar('ERROR');
      end;
    end;
    
  end;
  FreeAndNil(DMDatos);
end;

initialization
  { Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TwsSolicitudConsular);

end.
