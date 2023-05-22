unit uexport;

interface

uses
  System.Classes;

  function LGI(username, password : PChar) : Boolean;
  function LGO(username : PChar) : Boolean;
  function CEV(apellido,
               nombres,
               docnumero,
               doctipo,
               paisemisor,
               fechanac,
               sexo : PChar;
               var xml : TStream) : Boolean;

implementation

uses
  System.SysUtils, usocket;

type
  TAlignment = (aLeft, aRight);

  MSG_reg = packed record
    length : array [1..5] of Byte;
    id : array [1..3] of Byte;
  end;
  PMSG_reg = ^MSG_reg;

  CEV_reg = packed record
    // Todos los mensajes tienen dos campos generales (longitud e identificador).
    header : MSG_reg;
    // Resto de los campos que dependen del mensaje específico.
    ApellidoPaterno : array [1..30] of Byte;
    ApellidoMaterno : array [1..30] of Byte;
    Nombres : array [1..30] of Byte;
    // Número de registros.
    NOR : array [1..3] of Byte;
    Documento : array [1..20] of Byte;
    Formato : Byte;
    // Ultimos viajes.
    UV : array [1..2] of Byte;
    TipoDocumento : array [1..2] of Byte;
    CodigoPais : array [1..4] of Byte;
    FechaNacimiento : array [1..10] of Byte;
    Sexo : Byte;
  end;
  PCEV_reg = ^CEV_reg;

  LGI_reg = packed record
    header : MSG_reg;
    Username : array [1..8] of Byte;
    Password : array [1..16] of Byte;
  end;
  PLGI_reg = ^LGI_reg;

  LGO_reg = packed record
    header : MSG_reg;
    Username : array [1..8] of Byte;
  end;
  PLGO_reg = ^LGO_reg;

procedure FillField(field : array of Byte; value : PChar; Len : Integer; alignment : TAlignment);
var
  i, increment : Integer;
begin
  if alignment = aLeft then
  begin
    i := 0;
    increment := 1;
  end
  else
  begin
    increment := -1;
    i := Len - 1;
  end;
  while (i < Len) and (i >= 0) do
  begin
    field[i+1] := Ord((value + i)^);
    i := i + increment;
  end;
end;

procedure FillHeader(header : PMSG_reg; len : Integer; msgid : PChar);
var
  strlen : PChar;
begin
  GetMem(strlen, 5);
  // Longitud de todo el mensaje menos lo ocupado por la longitud (5 bytes).
  strlen := PChar(IntToStr(len - 5));
  FillField(header^.length, strlen, 5, aRight);
  FillField(header^.id, msgid, 3, aLeft);
  FreeMem(strlen);
end;

 {***************************************************************************************************
 *                                                                                                  *
 *                                            Exportadas                                            *
 *                                                                                                  *
 ***************************************************************************************************}

function LGI(username, password : PChar) : Boolean;
var
  msg : PLGI_reg;
  msglen : Integer;
  response : PChar;
label
  cleanup,
  disconn;
begin
  Result := False;
  msglen := SizeOf(LGI_reg);
  GetMem(msg, msglen);
  GetMem(response, 3);
  FillHeader(@(msg.header), msglen, 'LGI');
  FillField(msg.Username, username, 8, aLeft);
  FillField(msg.Password, password, 16, aLeft);

  if not Connect then
    goto cleanup;

  if not Write(PChar(msg), SizeOf(LGI_reg)) then
    goto disconn;

  FillChar(response, 3, 0);
  if not Read2(response) then
    goto disconn;

  Result := response = 'OK';

disconn:
  Disconnect;
cleanup:
  FreeMem(msg);
  FreeMem(response);
end;

function LGO(username : PChar) : Boolean;
var
  msg : PLGO_reg;
  msglen : Integer;
  response : PChar;
label
  cleanup,
  disconn;
begin
  Result := False;
  msglen := SizeOf(LGO_reg);
  GetMem(msg, msglen);
  GetMem(response, 3);
  FillHeader(@(msg.header), msglen, 'LGO');
  FillField(msg.Username, username, 8, aLeft);

  if not Connect then
    goto cleanup;

  if not Write(PChar(msg), SizeOf(LGO_reg)) then
    goto disconn;

  FillChar(response, 3, 0);
  if not Read2(response) then
    goto disconn;

  Result := response = 'OK';

disconn:
  Disconnect;
cleanup:
  FreeMem(msg);
  FreeMem(response);
end;

function CEV(apellido,
             nombres,
             docnumero,
             doctipo,
             paisemisor,
             fechanac,
             sexo : PChar;
             var xml : TStream) : Boolean;
var
  msg : PCEV_reg;
  msglen : Integer;
label
  cleanup,
  disconn;
begin
  Result := False;
  msglen := SizeOf(CEV_reg);
	GetMem(msg, msglen);
  FillHeader(@(msg.header), msglen, 'CEV');
	FillField(msg.ApellidoPaterno, apellido, 30, aLeft);
	FillField(msg.ApellidoMaterno, '', 30, aLeft);
	FillField(msg.Nombres, nombres, 30, aLeft);
	FillField(msg.NOR, '999', 3, aRight);
	FillField(msg.Documento, docnumero, 20, aLeft);
	FillField(msg.Formato, 'X', 1, aLeft);
	FillField(msg.UV, '', 2, aRight);
	FillField(msg.TipoDocumento, doctipo, 2, aLeft);
	FillField(msg.CodigoPais, paisemisor, 4, aRight);
	FillField(msg.FechaNacimiento, fechanac, 10, aLeft);
	FillField(msg.Sexo, sexo, 1, aLeft);

  if not Connect then
    goto cleanup;

	if not Write(PChar(@msg), SizeOf(CEV_reg)) then
    goto disconn;

  if not Read(xml) then
    goto disconn;

  Result := True;

disconn:
  Disconnect;
cleanup:
	FreeMem(msg);
end;

end.
