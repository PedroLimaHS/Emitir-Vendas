unit U_DtmClientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, Dialogs,db, U_DtmConexao, U_Cliente;

type

  { TDtmClientes }

  TDtmClientes = class(TDataModule)
    Qrycliente: TZReadOnlyQuery;
    QryPsqCliente: TZReadOnlyQuery;
    Qryclientecgc: TStringField;
    Qryclientecgc1: TStringField;
    Qryclientecidade: TStringField;
    Qryclientecidade1: TStringField;
    Qryclientefone: TStringField;
    Qryclientefone1: TStringField;
    Qryclientenome: TStringField;
    Qryclientenome1: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    function getCliente(PCliente: String):Tcliente;


  end;

var
  dtmClientes: TDtmClientes;

implementation

{$R *.lfm}


{ TDtmClientes }

function TDtmClientes.getCliente(PCliente:string):Tcliente;
var
  Cliente :Tcliente;
begin
     try
       Qrycliente.Close;
       Qrycliente.SQL.Text:='select cliente , nome , endereco,cgc from cad_clientes where cliente = :Cliente';
       Qrycliente.ParamByName('Cliente').AsString:= PCliente;
       Qrycliente.ExecSQL;

      if not (Qrycliente.IsEmpty) then
      begin
        Cliente := Tcliente.Create;
        Cliente.cliente:= Qrycliente.ParamByName('Cliente').AsString;
        Cliente.nome:= Qrycliente.ParamByName('nome').AsString;
        Cliente.cgc:= Qrycliente.ParamByName('CGC').AsString;
        Cliente.endereco:= Qrycliente.ParamByName('endereco').AsString;
      end;

      cliente.nome:= Qrycliente.FieldByName('nome').AsString;
      cliente.cliente:= Qrycliente.FieldByName('cliente').AsString;
      cliente.cgc:= Qrycliente.FieldByName('cgc').AsString;
      cliente.endereco:= Qrycliente.FieldByName('endereco').AsString;
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
         Qrycliente.SQL.Text:= 'select nome,cgc,fone,cidade FROM CAD_CLIENTES ';
         Qrycliente.Open;

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

