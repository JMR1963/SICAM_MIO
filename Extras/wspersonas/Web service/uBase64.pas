unit uBase64;

interface

type
  TAByte = array of Byte;

  PAByte = ^TAByte;

function Decode64(S: string): string;

function Decode64aByte(S: string): TAByte;

function Encode64(S: string): string;

function LoadFileToBase64(const AFileName: string): string;

implementation

uses
  System.Classes,
 {Indy10}
  IdBaseComponent, IdCoder, IdCoderMIME;

const
  Codes64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

type
  SAByte = array[0..0] of Byte;

  PSAByte = ^SAByte;

function find(C: CHAR): integer;
begin
  Result := 0;
  while (Codes64[Result + 1] <> C) and (Result < 64) do
    inc(Result);
end;

function Encode64(S: string): string;
var
//  i, a, x, b: Integer;
  encoder: TIdEncoderMIME;
begin
  Result := '';
  encoder := TIdEncoderMIME.Create(nil);
  Result := encoder.Encode(S);
  encoder.Free;
  {
  a := 0;
  b := 0;
  for i := 1 to Length(s) do
  begin
    x := Ord(s[i]);
    b := b * 256 + x;
    a := a + 8;
    while a >= 6 do
    begin
      a := a - 6;
      x := b div (1 shl a);
      b := b mod (1 shl a);
      Result := Result + Codes64[x + 1];
    end;
  end;
  if a > 0 then
  begin
    x := b shl (6 - a);
    Result := Result + Codes64[x + 1];
  end;
}
end;

function Decode64(S: string): string;
var
//  i, a, x, b: Integer;
  decoder: TIdDecoderMIME;
begin
  Result := '';
  decoder := TIdDecoderMIME.Create(nil);
  Result := decoder.DecodeString(S);
  decoder.Free;
{
  Result := '';

  a := 0;
  b := 0;
  for i := 1 to Length(s) do
  begin
    x := Pos(s[i], codes64) - 1;
    if x >= 0 then
    begin
      b := b * 64 + x;
      a := a + 6;
      if a >= 8 then
      begin
        a := a - 8;
        x := b shr a;
        b := b mod (1 shl a);
        x := x mod 256;
        Result := Result + chr(x);
      end;
    end
    else
      Exit;
  end;
}
end;

function LoadFileToBase64(const AFileName: string): string;
var
  stream: TMemoryStream;
  encoder: TIdEncoderMIME;
begin
  Result := '';
  encoder := TIdEncoderMIME.Create(nil);
  try
    stream := TMemoryStream.Create;
    try
      stream.LoadFromFile(AFileName);
      result := encoder.Encode(stream, stream.Size);
    finally
      stream.Free;
    end;
  finally
    encoder.Free;
  end;
end;
{
var
  stream: TStringStream;
begin
  stream := TStringStream.Create('');
  try
    stream.LoadFromFile(AFilename);
    result := Encode64(stream.DataString);
  finally
    stream.Free;
  end;
end;
}

function Decode64aByte(S: string): TAByte;
var
  B0, B1, B2, B3: BYTE;
  L, n, i: integer;
begin
  n := 1;
  i := 0;
  L := Length(S);
  if S[L] = '=' then
    dec(L);
  if S[L] = '=' then
    dec(L);
  SetLength(Result, (L * 3) div 4);
  repeat
    B0 := find(S[n]);
    B1 := find(S[n + 1]);
    B2 := find(S[n + 2]);
    B3 := find(S[n + 3]);

    Result[i] := (B0 shl 2) or (B1 shr 4);
    if B2 = 64 then
      break;
    Result[i + 1] := (B1 shl 4) or (B2 shr 2);
    if B3 = 64 then
      break;
    Result[i + 2] := (B2 shl 6) or B3;
    inc(n, 4);
    inc(i, 3);
  until n > L;
end;

end.

