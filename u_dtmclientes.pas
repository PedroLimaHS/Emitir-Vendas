unit U_DtmClientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZSqlUpdate, Dialogs, db, BufDataset, U_Cliente,
  uClientes, SQLDB,U_DtmConexao;

type

  { TDtmClientes }

  TDtmClientes = class(TDataModule)
    Qrycliente: TZReadOnlyQuery;
    QryclienteBairro: TStringField;
    QryclienteCEP: TStringField;
    Qryclientecliente: TStringField;
    Qryclienteemail: TStringField;
    QryclienteEndereco: TStringField;
    QryclienteUF: TStringField;
    QryFormapagamentoDescricao: TStringField;
    QryPsqCliente: TZReadOnlyQuery;
    Qryclientecgc: TStringField;
    Qryclientecgc1: TStringField;
    Qryclientecidade: TStringField;
    Qryclientecidade1: TStringField;
    Qryclientefone: TStringField;
    Qryclientefone1: TStringField;
    Qryclientenome: TStringField;
    Qryclientenome1: TStringField;
    QryFormapagamento: TZReadOnlyQuery;
    QryServicoCli: TZReadOnlyQuery;
    QryServicoCli1: TZQuery;
    QryServicoCli1Bairro: TStringField;
    QryServicoCli1CEP: TStringField;
    QryServicoCli1CGC: TStringField;
    QryServicoCli1Cidade: TStringField;
    QryServicoCli1Cliente: TStringField;
    QryServicoCli1descricao: TStringField;
    QryServicoCli1descricaoserv: TStringField;
    QryServicoCli1EMail: TStringField;
    QryServicoCli1Endereco: TStringField;
    QryServicoCli1Fone: TStringField;
    QryServicoCli1Nome: TStringField;
    QryServicoCli1produto: TStringField;
    QryServicoCli1UF: TStringField;
    QryServicoCli1valor: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    function carregaprodutocliente(strFiltroSql:String):boolean;
    function updateprodutocliente(strFilCliSql: String;strFilValSql: String;strFilDescSql: String;strFilProdSql: String): boolean;

  private

  public
    function getCliente(PCliente: String):Tcliente;

  end;

var
  dtmClientes: TDtmClientes;
  lblpesqi : String;

implementation

{$R *.lfm}

{ TDtmClientes }

function TDtmClientes.getCliente(PCliente:string):Tcliente;
var
  Cliente :Tcliente;

begin
     try
       Qrycliente.Close;
       Qrycliente.SQL.Text:= '   select        '#13 +
                             '   cliente,      '#13 +
                             '   nome,         '#13 +
                             '   endereco,     '#13 +
                             '   bairro,       '#13 +
                             '   cidade,       '#13 +
                             '   uf,           '#13 +
                             '   cep,          '#13 +
                             '   fone,         '#13 +
                             '   email,        '#13 +
                             '   cgc           '#13 +
                             '   from cad_clientes where cliente = :Cliente';

       Qrycliente.ParamByName('Cliente').AsString:= PCliente;
       Qrycliente.ExecSQL;



      if not (Qrycliente.IsEmpty) then
      begin
        Cliente := Tcliente.Create;
        Cliente.cliente:= Qrycliente.ParamByName('Cliente').AsString;
        Cliente.nome:= Qrycliente.ParamByName('nome').AsString;
        Cliente.cgc:= Qrycliente.ParamByName('CGC').AsString;
        Cliente.endereco:= Qrycliente.ParamByName('endereco').AsString;
        Cliente.bairro:= Qrycliente.ParamByName('bairro').AsString;
        Cliente.uf:= Qrycliente.ParamByName('uf').AsString;
        Cliente.cep:= Qrycliente.ParamByName('cep').AsString;
        Cliente.cidade:= Qrycliente.ParamByName('cidade').AsString;
        Cliente.fone:= Qrycliente.ParamByName('fone').AsString;
        Cliente.email:= Qrycliente.ParamByName('email').AsString;
      end;

      Cliente.nome:= Qrycliente.FieldByName('nome').AsString;
      Cliente.cliente:= Qrycliente.FieldByName('cliente').AsString;
      Cliente.cgc:= Qrycliente.FieldByName('cgc').AsString;
      Cliente.endereco:= Qrycliente.FieldByName('endereco').AsString;
      Cliente.bairro:= Qrycliente.FieldByName('bairro').AsString;
      Cliente.uf:= Qrycliente.FieldByName('uf').AsString;
      Cliente.cep:= Qrycliente.FieldByName('cep').AsString;
      Cliente.cidade:= Qrycliente.FieldByName('cidade').AsString;
      Cliente.fone:= Qrycliente.FieldByName('fone').AsString;
      Cliente.email:= Qrycliente.FieldByName('email').AsString;
      except
       on E:exception do
      begin
            Result := nil;
            showMessage('Ocorreu um erro ao salvar o curso'+#13+
         'Erro: ' + e.Message);
       end;
     end;
   end;

procedure TDtmClientes.DataModuleCreate(Sender: TObject);
begin
  try
         Qrycliente.close;
         Qrycliente.SQL.Text:= 'select cliente,Nome,Endereco,Bairro,Cidade,UF,CEP,CGC,Fone,email from Cad_Clientes';
         Qrycliente.Open;

      except
    on E:Exception do
    begin
         ShowMessage('Erro ao abrir tabela clientes.'+#13+
         'Erro: ' + e.Message);
         Exit;
    end;
  end;
end;


function TDtmClientes.carregaprodutocliente(strFiltroSql: String): boolean;
 begin
  try
         QryServicoCli.close;
         QryServicoCli.SQL.Text:= 'select              '#13 +
                                  'c.Cliente,          '#13 +
                                  'c.Nome,             '#13 +
                                  'c.Endereco,         '#13 +
                                  'c.Bairro,           '#13 +
                                  'c.Cidade,           '#13 +
                                  'c.UF,               '#13 +
                                  'c.CEP,              '#13 +
                                  'c.CGC,              '#13 +
                                  'c.Fone,             '#13 +
                                  'c.EMail,            '#13 +
                                  'jf.produto,         '#13 +
                                  'jf.valor,           '#13 +
                                  'jf.descricaoserv,   '#13 +
                                  'p.descricao from Cad_Clientes C                            '#13 +
                                  'inner join cli_servicojf as jf on jf.cliente = c.Cliente   '#13 +
                                  'inner join cad_produtos as P on jf.produto = p.produto     '#13 +
                                  'WHERE C.cliente =                                          '#13 +
                                   strFiltroSql +#13;
                   QryServicoCli.Open;
     Result := not QryServicoCli.IsEmpty;

   Except
    on E:Exception do
    begin
         ShowMessage('Erro ao abrir tabela clientes.'+#13+
         'Erro: ' + e.Message);
       Result := false

    end;
  end;
end;

function TDtmClientes.updateprodutocliente(strFilCliSql: String;strFilValSql: String;strFilDescSql: String;strFilProdSql: String): boolean;
 begin
  try
         QryServicoCli1.close;
         QryServicoCli1.SQL.Text:= '  UPDATE                          '#13 +
                                   'cli_servicojf SET                 '#13 +
                                   'valor = :valor,                   '#13 +
                                   'descricaoserv = :descricaoserv    '#13 +
                                   'WHERE cliente = :cliente          '#13 +
                                   'and produto= :produto';

                   QryServicoCli1.ParamByName('Cliente').AsString:= strFilCliSql;
                   QryServicoCli1.ParamByName('valor').AsString:= strFilValSql;
                   QryServicoCli1.ParamByName('descricaoserv').AsString:= strFilDescSql;
                   QryServicoCli1.ParamByName('produto').AsString:= strFilProdSql;
                   QryServicoCli1.ExecSQL;
                   Result := not QryServicoCli1.IsEmpty;

   Except
    on E:Exception do
    begin
         ShowMessage('Erro ao abrir tabela produtosservicos.'+#13+
         'Erro: ' + e.Message);
       Result := false

    end;
  end;
end;

end.



