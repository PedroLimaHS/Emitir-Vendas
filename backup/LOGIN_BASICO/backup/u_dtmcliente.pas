unit U_DtmClientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, db, U_DtmConexao,uClientes;

type

  { TDtmClientes }

  TDtmClientes = class(TDataModule)
    Qrycliente: TZReadOnlyQuery;
    Qryclientenome: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  dtmClientes: TDtmClientes;

implementation

{$R *.lfm}

{ TDtmClientes }

procedure TDtmClientes.DataModuleCreate(Sender: TObject);
begin
  try
         Qrycliente.close;
         Qrycliente.SQL.Text:= 'select nome FROM CAD_CLIENTES ';
         Qrycliente.Open;

     Qrycliente.Last;
     Qrycliente.First;

     ShowMessage(IntToStr(Qrycliente.RecordCount));
     ShowMessage(Qrycliente.fieldbyname('nome').AsString);

  except
    on E:Exception do
    begin
         ShowMessage('Erro ao abrir tabela clientes.'+#13+
         'Erro: ' + e.Message);
         Exit;
    end;
end;

end.

