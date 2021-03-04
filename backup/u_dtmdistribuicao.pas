unit U_dtmDistribuicao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset,Dialogs;

type

  { TDtmdistribuicao }

  TDtmdistribuicao = class(TDataModule)
    QryMaxChave: TZReadOnlyQuery;
    QryInsertProdutos: TZQuery;
    QrySelectValues: TZReadOnlyQuery;
    QryCliente: TZReadOnlyQuery;
    QryMaxChave1: TZQuery;
  private

  public
    function maxChave(): string;
    procedure SelectValores();
    procedure InsertProdutos(chave: String; (*produto: String; valor: String;
      cliente: String; nome: String; descricaoserv: String;*) qry: TZReadOnlyQuery
  );
  end;

var
  Dtmdistribuicao: TDtmdistribuicao;

implementation

{$R *.lfm}


function TDtmdistribuicao.maxChave(): string;
var
  liResult: String;
begin
  try
//    QryMaxChave1.Close;
    QryMaxChave1.sql.Clear;
    QryMaxChave1.SQL.Text := 'select vendas from numeracao';
    QryMaxChave1.Open;

   liResult := IntToStr(StrToIntDef(QryMaxChave1.FieldByName('VENDAS').AsString, 0) + 1);

    QryMaxChave1.Close;
    QryMaxChave1.sql.Clear;
    QryMaxChave1.SQL.Text := 'update numeracao set vendas = :vendas';
    QryMaxChave1.ParamByName('vendas').AsString := liResult;
    QryMaxChave1.ExecSQL;
    QryMaxChave1.ApplyUpdates;
    QryMaxChave1.Connection.Commit;


    Result := liResult;

  except
    on E: Exception do
    begin
      ShowMessage('Erro ao abrir tabela clientes.' + #13 +
      'Erro: ' + e.Message);
      Exit;
    end;
  end;
end;

procedure TDtmdistribuicao.InsertProdutos(chave:String;  qry: TZReadOnlyQuery);(*produto:String; valor:String; cliente:String; nome:String; descricaoserv:String;*)
var
  datanow: string;
  teste: string;
begin
  try
    QryInsertProdutos.Close;
    QryInsertProdutos.SQL.Clear;
    QryInsertProdutos.SQL.Add('insert into Estoque (Chave1, Data, Produto, Quantidade,Preco,Vendedor ,tipo , Faturado , ER, Cliente,Historico, Documento, Cancelado, pp , Responsavel , Descricao)');
    QryInsertProdutos.SQL.Add('values (:chave ,:datanow ,:produto, ''-1'',:valor,''37'',''Saída2'',''1'',''T'',:cliente,:Nome,(select max(documento)+1from Estoque) ,''F'',:valor,''thiago'', :descricaoserv )');
    QryInsertProdutos.ParamByName('chave').AsString := chave;
    QryInsertProdutos.ParamByName('produto').AsString :=qry.FieldByName('produto').AsString;
    QryInsertProdutos.ParamByName('valor').AsString := qry.FieldByName('valor').AsString;
    QryInsertProdutos.ParamByName('cliente').AsString := qry.FieldByName('cliente').AsString;
    QryInsertProdutos.ParamByName('nome').AsString := qry.FieldByName('nome').AsString;
    QryInsertProdutos.ParamByName('descricaoserv').AsString := qry.FieldByName('descricaoserv').AsString;
    datanow:= DateToStr(now);
    QryInsertProdutos.ParamByName('datanow').AsString := datanow;
    QryInsertProdutos.ExecSQL;
    QryMaxChave1.ApplyUpdates;
    QryInsertProdutos.Connection.Commit;

  except
    on E: Exception do
    begin
      ShowMessage('Erro ao abrir tabela Estoque.' +
      #13 + 'Erro: ' + e.Message);
      Exit;
    end;
  end;
end;

procedure TDtmdistribuicao.SelectValores();
begin
  try
    QryCliente.Close;
    QryCliente.SQL.Text :=  'select              '#13 +
                            'jf.Cliente,         '#13 +
                            'c.Nome,             '#13 +
                            'jf.produto,         '#13 +
                            'jf.valor,           '#13 +
                            'jf.descricaoserv    '#13 +
                            'from Cli_servicoJF as jf                                '#13 +
                            'inner join Cad_Clientes as c on jf.cliente = c.Cliente  '#13 +
                            'WHERE  c.Bloqueio=''F'' '#13+
                            'Order by 1 ';
    QryCliente.Open;
    QryCliente.Active := True;
    QryCliente.First;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao abrir tabela clientes.' + #13 +
       'Erro: ' + e.Message);
      Exit;
    end;
  end;
end;

end.



