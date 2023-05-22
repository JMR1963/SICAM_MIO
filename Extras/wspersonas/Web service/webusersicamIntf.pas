{ Invokable interface Iwebusersicam }

unit webusersicamIntf;

interface

uses InvokeRegistry, Types, XSBuiltIns{, ubaseDatos} {sqlBaseManage};

type
  tResultConsultaNew = class(Tremotable)
    private
      FFECHA_CRUCE : string;
      FTIPO_DOC: string;
      //FEMISOR_DOC: string;
      FNUM_DOC: string;
      FAPELLIDO1: string;
      FAPELLIDO2: string;
      FNOMBRE1: string;
      FNOMBRE2: string;
      FSEXO: string;
      FFECHA_NAC: string;
      FNACIONALIDAD: string;
      FPASO_CRUCE: string;
    published
      property fecha_cruce : string read FFECHA_CRUCE write FFECHA_CRUCE;
      property tipo_doc : string read ftipo_doc write ftipo_doc;
     // property emisor_doc : string read FEMISOR_DOC write FEMISOR_DOC;
      property num_doc : string read FNUM_DOC write FNUM_DOC;
      property apellido1: string read FAPELLIDO1 write fapellido1;
      property apellido2 : string read FAPELLIDO2 write fapellido2;
      property nombre1 : string read fnombre1 write fnombre1;
      property nombre2 : string read fnombre2 write fnombre2;
      property sexo : string read fsexo write fsexo;
      property fecha_nac : string read FFECHA_NAC write FFECHA_NAC;
      property nacionalidad: string read FNACIONALIDAD write FNACIONALIDAD;
      property paso_cruce: string read fpaso_cruce write fpaso_cruce;
    end;

    arrayResultadoConsulta = array of tResultConsultaNew;

  TTransit = class(TRemotable)
    private
      fFechaCruce:string;
      fPasoCruce:string;
      fTipoCruce:string;
      fDiasPermanencia:string;
      fApellido1:string;
      fApellido2:string;
      fNombre1:string;
      fNombre2:string;
      fSexo:string;
      fDocVenc:string;
      fDocNro:string;
      fDocTipo:string;
      fDocPaisEmisor:string;
      fFechaNac:string;
      fNacionalidad:string;
      fDocSubTipo:string;
      fIdTranOlSicam:string;
    published
      property FechaCruce:string read fFechaCruce write fFechaCruce;
      property PasoCruce:string read fPasoCruce write fPasoCruce;
      property TipoCruce:string read fTipoCruce write fTipoCruce;
      property DiasPermanencia:string read fDiasPermanencia write fDiasPermanencia;
      property Apellido1:string read fApellido1 write fApellido1;
      property Apellido2:string read fApellido2 write fApellido2;
      property Nombre1:string read fNombre1 write fNombre1;
      property Nombre2:string read fNombre2 write fNombre2;
      property Sexo:string read fSexo write fSexo;
      property DocVenc:string read fDocVenc write fDocVenc;
      property DocNro:string read fDocNro write fDocNro;
      property DocTipo:string read fDocTipo write fDocTipo;
      property DocPaisEmisor:string read fDocPaisEmisor write fDocPaisEmisor;
      property FechaNac:string read fFechaNac write fFechaNac;
      property Nacionalidad:string read fNacionalidad write fNacionalidad;
      property DocSubTipo:string read fDocSubTipo write fDocSubTipo;
      property IdTranOlSicam:string read fIdTranOlSicam write fIdTranOlSicam;
    end;

    aTransitos = array of TTransit;

   TImagesTransit = class(TRemotable)
     private
        fNombreFacial:string;
        fFileFacial:string;
        fDescripcionDactilar:string;
        fNombreDactilar:string;
        fFileDactilar:string;
        fErrorCode:string;
     published
        property NombreFacial:string read fNombreFacial write fNombreFacial;
        property FileFacial:string read fFileFacial write fFileFacial;
        property NombreDactilar:string read fNombreDactilar write fNombreDactilar;
        property DescripcionDactilar:string read fDescripcionDactilar write fDescripcionDactilar;
        property FileDactilar:string read fFileDactilar write fFileDactilar;
        property ErrorCode:string read fErrorCode write fErrorCode;

     end;

   aImagesTransit = array of TImagesTransit;

  { Invokable interfaces must derive from IInvokable }
  Iwebusersicam = interface(IInvokable)
  ['{167E8DAC-B45A-4C56-AF5F-2FD81313030A}']

   function findPerson(id, pais, subTipoDoc, nroDocumento: string): string; stdcall;

   function findPersonAndTransit(id, pais, subTipoDoc, nroDocumento: string): aTransitos; stdcall;

   function usuarios_pasos(usuario, documentonro, clavesistema, apellidos, nombres,
        pasold, pasonew, idusuariostipos, credencial: string): string; stdcall;

   function findImagesTransit(id, pais, subTipoDoc, nroDocumento:string):aImagesTransit; stdcall;

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(Iwebusersicam));

end.
