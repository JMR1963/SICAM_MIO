program Loadauto;
uses
  uExtra in 'uExtra.pas',
  uMain in 'uMain.pas',
  uUtils in 'uUtils.pas',
  uHttp in 'uHttp.pas' {HttpDtMdl: TDataModule},
  uCommon in 'uCommon.pas',

  udmOracle in 'udmOracle.pas' {dmOracle: TDataModule},

  uResourceString in 'uResourceString.pas';

//uDialup in 'uDialup.pas' {DialupDtMdl: TDataModule}
//   uDtMdl in 'uDtMdl.pas' {DtMdl: TDataModule},

var
  App: TMain;
begin
  App := TMain.Create;
  if App.CreationResult
  then
    App.Loop;
  App.Free;
end.
 