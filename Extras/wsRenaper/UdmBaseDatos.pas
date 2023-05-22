unit UdmBaseDatos;

interface

uses
  SysUtils, Classes, DB, DBAccess, Ora;

type
  TDataModule1 = class(TDataModule)
    OraSession1: TOraSession;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.
