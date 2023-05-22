unit UDM1;

interface

uses
  System.SysUtils, system.Classes, Data.DB, DBAccess, Ora, System.IniFiles, MemDS, OraCall;

type
  Tdm1 = class(TDataModule)
    OraSession1: TOraSession;
    OraQuery: TOraQuery;
    OraStoredProc2: TOraStoredProc;
    OraStoredProc3: TOraStoredProc;
  private
    { Private declarations }
  public
    { Public declarations }
   function EstaMatricula(nroDni: string): boolean;

   function cargar(fecha,
                nroDni,
                sexo,
                apellido,
                nombres,
                pai ,
                PROV,
                MUN,
                CIU ,
                CA,
                numero,
                piso,
                departamento,
                barrio,
                monoblock,
                CP,
                telefono,
                tel_part,
                codidgoArea,
                mail:string): boolean;
  end;

var
  dm1: Tdm1;

implementation

{$R *.dfm}

 function Tdm1.EstaMatricula(nroDni: string): boolean;
 begin
   Result := false;
   with  OraQuery do
   begin
    close;
    sql.Clear;
    sql.Add(
            ' select * from TRAVEL_OWNER.INFO_ADICIONAL_RENAPER '+
            ' where fecha >= trunc(sysdate) and matricula  = :unaMatricula ');

    parambyname('unaMatricula').asstring:=NRODNI;

    open;
    if not IsEmpty then
    begin
      Result := true;
    end
   end;


 end;





 function tdm1.cargar(fecha,
                nroDni,
                sexo,
                apellido,
                nombres,
                pai ,
                PROV,
                MUN,
                CIU ,
                CA,
                numero,
                piso,
                departamento,
                barrio,
                monoblock,
                CP,
                telefono,
                tel_part,
                codidgoArea,
                mail:string): boolean;
 var   inifile: TIniFile;
 begin

    try
      inifile := TIniFile.Create(Format('%sconfig.ini', [ExtractFilePath(ParamStr(0))]));
      try
        OraSession1.Server := inifile.ReadString('config', 'server', 'TRANDESA');
      finally
        inifile.Free;
      end;
      OraSession1.Username := 'travel_owner';
      OraSession1.Password := 'tulkas';
      OraSession1.Connected :=true;

      if not OraSession1.InTransaction then
      begin
        OraSession1.StartTransaction ;
        with OraStoredProc3 do
        begin
          Params.Clear;
          prepared:=true;
          ExecSQL;
        end;
        OraSession1.Commit;
      end;

      if not OraSession1.InTransaction then
      begin
        if NoT EstaMatricula(nroDni) then
        begin
          OraSession1.StartTransaction ;

          with OraStoredProc2 do
          begin

            Params.Clear;
            prepared:=true;

            Params.CreateParam(FTDATE,'V_FECHA',ptInput) ;
            Params.CreateParam(ftInteger,'V_MATRICULA',ptInput);
            Params.CreateParam(ftString,'V_SEXO',ptInput);
            Params.CreateParam(ftString,'V_APELLIDOS',ptInput);
            Params.CreateParam(ftString,'V_NOMBRES',ptInput);
            Params.CreateParam(ftString,'V_PAIS',ptInput);
            Params.CreateParam(ftString,'V_PROVINCIA',ptInput);
            Params.CreateParam(ftString,'V_CIUDAD',ptInput);
            Params.CreateParam(ftString,'V_CALLE',ptInput);
            Params.CreateParam(ftString,'V_NUMERO',ptInput);
            Params.CreateParam(ftString,'V_DEPTO',ptInput);
            Params.CreateParam(ftString,'V_CPOSTAL',ptInput);
            Params.CreateParam(ftString,'V_MUNICIPIO',ptInput);
            Params.CreateParam(ftString,'V_TELFONO',ptInput);
            Params.CreateParam(ftString,'V_TEL_FIJO',ptInput);
            Params.CreateParam(ftString,'V_CARACTERISTICA',ptInput);
            Params.CreateParam(ftString,'V_MAIL',ptInput);
            Params.CreateParam(ftString,'V_PISO',ptInput);
            Params.CreateParam(ftString,'V_BARRIO',ptInput);
            Params.CreateParam(ftString,'V_MONOBLOCK',ptInput);

            ParamByName('V_FECHA').Value :=  UpperCase(fecha);
            ParamByName('V_MATRICULA').Value := UpperCase(nroDni);
            ParamByName('V_SEXO').Value := UpperCase(sexo);
            ParamByName('V_APELLIDOS').Value := UpperCase(apellido);
            ParamByName('V_NOMBRES').Value := UpperCase(nombres);
            ParamByName('V_PAIS').Value :=UpperCase(pai);
            ParamByName('V_PROVINCIA').Value :=UpperCase(PROV);
            ParamByName('V_CIUDAD').Value :=UpperCase(CIU);
            ParamByName('V_CALLE').Value :=UpperCase(CA);
            ParamByName('V_NUMERO').Value := UpperCase(numero);
            ParamByName('V_DEPTO').Value :=UpperCase(departamento);
            ParamByName('V_CPOSTAL').Value :=CP;
            ParamByName('V_MUNICIPIO').Value := UpperCase(MUN);
            ParamByName('V_TELFONO').Value := UpperCase(telefono);
            ParamByName('V_TEL_FIJO').Value := UpperCase(tel_part);
            ParamByName('V_CARACTERISTICA').Value :=UpperCase(codidgoArea);
            ParamByName('V_MAIL').Value :=UpperCase(mail);
            ParamByName('V_PISO').Value :=UpperCase(piso);
            ParamByName('V_BARRIO').Value := UpperCase(barrio);
            ParamByName('V_MONOBLOCK').Value := UpperCase(monoblock);

            ExecSQL;
          end;

          OraSession1.Commit;
        end;
      end;

      OraSession1.Disconnect;

    except
      OraSession1.Rollback;
      OraSession1.Disconnect;
    end;
end;

end.
