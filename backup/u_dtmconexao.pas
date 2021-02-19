unit U_DtmConexao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, DB, odbcconn, SQLDB,
  MSSQLConn, Forms;

type

  { TDtmConexao }

  TDtmConexao = class(TDataModule)
    zConexao: TZConnection;
    ZReadOnlyQuery1Bairro: TStringField;
    ZReadOnlyQuery1Cidade: TStringField;
    ZReadOnlyQuery1Endereco: TStringField;
    ZReadOnlyQuery1Nome: TStringField;
    ZReadOnlyQuery1UF: TStringField;

  private

  public

    function abreConexao:Boolean;

  end;

var
  DtmConexao: TDtmConexao;

implementation

{$R *.lfm}

{ TDtmConexao }


function TDtmConexao.abreConexao: Boolean;
begin
  try
    zConexao.Connected:= true;
  except
    Application.MessageBox('Erro ao conectar com o banco de dados. Aplicação será finalizada!', 'Atenção');
    Application.Terminate;
  end;

end;

end.

