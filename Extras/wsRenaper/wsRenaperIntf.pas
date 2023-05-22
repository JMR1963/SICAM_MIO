{ Invokable interface IwsRenaper }

unit wsRenaperIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, Umini, UwsdlRenaper;

type
    salidaVto = class(Tremotable)
    private
      FVTO      : string;
      Ferror      : Integer;
      FDescripcionerror     : string;
    published
      property vto   : string  read FVTO     write FVTO;
      property error   : INTEGER  read Ferror     write Ferror;
      property Descripcionerror   : string  read FDescripcionerror     write FDescripcionerror;

    end;

  DatosEntradaM2DNM = class(TRemotable)
  private
    FprimerApellido: WideString;
    FprimerNombre: WideString;
    FanioNacimiento: WideString;
  published
    property primerApellido: WideString read FprimerApellido write FprimerApellido;
    property primerNombre: WideString read FprimerNombre write FprimerNombre;
    property anioNacimiento: WideString read FanioNacimiento write FanioNacimiento;
  end;


  personaDNm = class(TRemotable)
  private
    Fdni: Integer;
    Fsexo: WideString;
    Fnombre: WideString;
    Fapellido: WideString;
    FfechaNacimiento: WideString;
  published
    property dni: Integer read Fdni write Fdni;
    property sexo: WideString read Fsexo write Fsexo;
    property nombre: WideString read Fnombre write Fnombre;
    property apellido: WideString read Fapellido write Fapellido;
    property fechaNacimiento: WideString read FfechaNacimiento write FfechaNacimiento;
  end;

  personasArrayDNM = array of personaDNM;             { "urn:mininteriorwsdl" }


  DatosSalidaM2DNM = class(TRemotable)
  private
    Fcodigo: Integer;
    Fmensaje: WideString;
    Fpersonas: personasArrayDNM;

  published
    property codigo: Integer read Fcodigo write Fcodigo;
    property mensaje: WideString read Fmensaje write Fmensaje;
    property personas: personasArrayDNM read Fpersonas write Fpersonas;
  end;



  { Invokable interfaces must derive from IInvokable }
  IwsRenaper = interface(IInvokable)
  ['{D850B356-B16E-4DF9-BCF9-7C57DBF7E460}']
    function consultaCiudadanosDniSexo(nroDni, sexo: string): ciudadanos;  stdcall;
    function consultaCiudadanosNombre(apellido, nombre, nacimiento: string): ciudadanos; stdcall;
    function consultaCiudadanosDetalle(id: string):DatosSalida; stdcall;
    function consultaCiudadanosXML(apellido, nombre, nacimiento: string): string; stdcall;
    function consultaUnificada(nroDni, sexo: string): ciudadanosYDetalle; stdcall;
    function VtoDOC(nroDni, sexo, tipoDOC: string): salidaVto; stdcall;

    function  obtenerMatriculaSexoDNM(const DatosEntrada: DatosEntradaM2dnm): DatosSalidaM2dnm; stdcall;
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IwsRenaper));

end.
 