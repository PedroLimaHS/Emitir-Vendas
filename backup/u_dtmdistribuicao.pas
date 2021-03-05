unit U_dtmDistribuicao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset,Dialogs;

type

  { TDtmdistribuicao }

  TDtmdistribuicao = class(TDataModule)
    QryInsertProdutos: TZQuery;
    QrySelectValues: TZReadOnlyQuery;
    QryCliente: TZReadOnlyQuery;
    QryMaxChave: TZQuery;
    QryUpdateDescServ: TZQuery;
  private


  public
    function maxChave(): string;
    function UpdateProdutosServ(mes: string; ano: string): boolean;
    procedure SelectValores();
    procedure InsertProdutos(chave: String; qry: TZReadOnlyQuery );

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
    QryMaxChave.Close;
    QryMaxChave.sql.Clear;
    QryMaxChave.SQL.Text := 'select vendas from numeracao';
    QryMaxChave.Open;

   liResult := IntToStr(StrToIntDef(QryMaxChave.FieldByName('VENDAS').AsString, 0) + 1);

    QryMaxChave.Close;
    QryMaxChave.sql.Clear;
    QryMaxChave.SQL.Text := 'update numeracao set vendas = :vendas';
    QryMaxChave.ParamByName('vendas').AsString := liResult;
    QryMaxChave.ExecSQL;
    QryMaxChave.ApplyUpdates;
    QryMaxChave.Connection.Commit;


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

procedure TDtmdistribuicao.InsertProdutos(chave:String; qry: TZReadOnlyQuery);
var
  datanow: string;
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
    QryMaxChave.ApplyUpdates;
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

function TDtmdistribuicao.UpdateProdutosServ(mes:string ; ano:string): boolean;
var
  cont: Integer;
begin
  try

      QryUpdateDescServ.Close;
      QryUpdateDescServ.SQL.Clear;
      QryUpdateDescServ.SQL.Add('UPDATE CLI_SERVICOJF SET DESCRICAOSERV = ''MANUTENÇÃO DO SISTEMA '' + P.Aplicacao +  '' - ''  + :mes + ''/'' + :ano +''.''');
      QryUpdateDescServ.SQL.Add('FROM CLI_SERVICOJF AS JF');
      QryUpdateDescServ.SQL.Add('INNER JOIN CAD_PRODUTOS AS P');
      QryUpdateDescServ.SQL.Add('ON JF.PRODUTO = P.PRODUTO');
      QryUpdateDescServ.SQL.Add('WHERE P.GRUPO = ''0001''');

      QryUpdateDescServ.ParamByName('MES').AsString := mes;
      QryUpdateDescServ.ParamByName('ANO').AsString := ano;

      QryUpdateDescServ.ExecSQL;
      QryUpdateDescServ.ApplyUpdates;
      cont:= QryUpdateDescServ.RowsAffected;
      QryUpdateDescServ.Connection.Commit;

   if cont >= 1 then
     begin
       ShowMessage('Produto salvo, quantidade:' + IntToStr(cont));
     end;

    except
    on E: Exception do
    begin
      ShowMessage('Erro ao alterar a descrição dos produtos.' +
      #13 + 'Erro: ' + e.Message);
      Exit;
    end;
  end;
end;

end.



