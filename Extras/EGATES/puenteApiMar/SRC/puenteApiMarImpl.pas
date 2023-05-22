{ Invokable implementation File for TpuenteApiMar which implements IpuenteApiMar }

unit puenteApiMarImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, puenteApiMarIntf, System.IniFileS,
     ServicioConsulta, System.SysUtils, Vcl.Forms, WinApi.Windows; // BQB


type

  { TpuenteApiMar }
  TpuenteApiMar = class(TInvokableClass, IpuenteApiMar)
  public
      function dameApi(Paso , Ape1, ape2, nombre1, nombre2, FechaNac, nroDoc,Libreta: string) : string; stdcall;
  end;

implementation


      function TpuenteApiMar.dameApi(Paso , Ape1, ape2, nombre1, nombre2, FechaNac, nroDoc,Libreta: string) : string; stdcall;
      var perBqb : Persona;
          ConsultareqBqb: ConsultarServicioMaritimoRequest;
          ws: ServicioConsultaPortType;
          rtabqb : ConsultarServicioMaritimoResponse;
          ini:TIniFile;
          URL:string;



      begin
        TRY
          ini := TIniFile.Create('.\config.ini');
          URL := ini.ReadString('CONFIG', 'URL', '');

          if paso = 'BQB'  then
          begin

              perBqb:= Persona.Create;
              perBqb.apellido1:= Ape1;
              perBqb.apellido2:= Ape2;
              perBqb.nombres1:= nombre1;
              perBqb.nombres2:= nombre2;
              perBqb.fechaNac:= FechaNac;
              perBqb.nroDoc:=nroDoc;
              perBqb.nroLibreta:= Libreta;

              ConsultareqBqb:=ConsultarServicioMaritimoRequest.Create;
              ConsultareqBqb.persona:= perBqb;

              rtabqb:= ConsultarServicioMaritimoResponse.Create;

              ws:= GetServicioConsultaPortType(false,URL);
              rtabqb:= ws.consultarServicioMaritimo(ConsultareqBqb);
              Result:=rtabqb.servicioMaritimo.numeroServicioMaritimo;
              try
                perBqb.Free;
                ConsultareqBqb.Destroy;
                rtabqb.Free;
              except

              end;

          end
          else
          begin
            if paso = 'COLONIAEXPRESS' then
            begin
              result:='-1000';
            end;
          end;
        EXCEPT
          //Ver si corresponde que exista!
          result:='-1001';
        END;
      end;
initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TpuenteApiMar);
end.

