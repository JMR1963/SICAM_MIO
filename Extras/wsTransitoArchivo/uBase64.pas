unit uBase64;

interface

  function Encode64(S: string): string;
  function Decode64(S: string): string;


implementation

uses
 IdBaseComponent, IdCoder, IdCoder3to4,
  IdCoderMIME;

const
  Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';



function Encode64(S: string): string;
var
  i: Integer;
  a: Integer;
  x: Integer;
  b: Integer;
  encoder: TIdEncoderMIME;
begin
  Result := '';
  encoder:= TIdEncoderMIME.Create(nil);
  Result:= encoder.Encode(S);
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
  i: Integer;
  a: Integer;
  x: Integer;
  b: Integer;
  decoder: TIdDecoderMIME;
begin
  Result := '';
  decoder:= TIdDecoderMIME.Create(nil);
  Result:= decoder.DecodeString(S);
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



end.
