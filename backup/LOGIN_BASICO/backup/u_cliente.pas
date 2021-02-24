unit U_Cliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  Tcliente = class
    cliente: String;
    nome: String;
    endereco: String;
    bairro: String;
    cidade: String;
    uf: String;
    cep: String;
    inscricao: String;
    cgc: String;
    fone: String;
    email: String;



    //nome das celulas do string grid
    StringGrid1.Cells[0,0] := 'Todos';
    StringGrid1.Cells[1,0] := 'Codigo';
    StringGrid1.Cells[2,0] := 'Serviços';
    StringGrid1.Cells[3,0] := 'Valor';

    StringGrid1.Cells[0,1] := dtmClientes.Qrycliente.FieldByName('produto').AsString;
    StringGrid1.Cells[2,1] := dtmClientes.Qrycliente.FieldByName('descricao').AsString;

  end;

implementation

end.

