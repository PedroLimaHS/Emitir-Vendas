unit U_DtmClientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, Dialogs,db, BufDataset,U_Cliente;

type

  { TDtmClientes }

  TDtmClientes = class(TDataModule)
    BufDataset1: TBufDataset;
    Qrycliente: TZReadOnlyQuery;
    QryclienteBairro: TStringField;
    QryclienteCEP: TStringField;
    Qryclientecliente: TStringField;
    Qryclienteemail: TStringField;
    QryclienteEndereco: TStringField;
    QryclienteUF: TStringField;
    QryFormapagamentoDescricao: TStringField;
    QryFormapagamentoFaturador: TStringField;
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
    procedure DataModuleCreate(Sender: TObject);
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
                             '   email,         '#13 +
                             '   cgc           '#13 +
                             '   from cad_clientes where cliente = :Cliente order by 1';




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

      cliente.nome:= Qrycliente.FieldByName('nome').AsString;
      cliente.cliente:= Qrycliente.FieldByName('cliente').AsString;
      cliente.cgc:= Qrycliente.FieldByName('cgc').AsString;
      cliente.endereco:= Qrycliente.FieldByName('endereco').AsString;
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
         Qrycliente.SQL.Text:= 'select cliente,Nome,Endereco,Bairro,Cidade,UF,CEP,CGC,Fone,email from Cad_Clientes order by nome';
         Qrycliente.Open;


         QryServicoCli.close;
         QryServicoCli.SQL.Text:= 'select Produto, Descricao  from Cad_Produtos WHERE Servico = 't'';
         QryServicoCli.Open;

     //Qrycliente.Last;
     //Qrycliente.First;
     //
     //ShowMessage(IntToStr(Qrycliente.RecordCount));
     //ShowMessage(Qrycliente.fieldbyname('nome').AsString);

  except
    on E:Exception do
    begin
         ShowMessage('Erro ao abrir tabela clientes.'+#13+
         'Erro: ' + e.Message);
         Exit;
    end;

  end;
end;

end.

