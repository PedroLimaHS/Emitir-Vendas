unit u_RelatorioClientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ZDataset, RLReport,
  DB;

type

  { TfrmRelatorioClientes }

  TfrmRelatorioClientes = class(TForm)
    dsCabecalhoCli: TDataSource;
    dsRelCli: TDataSource;
    QryCabecalhoCli: TZReadOnlyQuery;
    QryRelCli: TZReadOnlyQuery;
    QryRelCliBairro: TStringField;
    QryRelCliCEP: TStringField;
    QryRelCliCGC: TStringField;
    QryRelCliCidade: TStringField;
    QryRelClicliente: TStringField;
    QryRelCliEndereco: TStringField;
    QryRelCliFone: TStringField;
    QryRelCliNome: TStringField;
    QryRelCliUF: TStringField;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBandCliente: TRLBand;
    rlBandCabecalho: TRLBand;
    rlBandFooter: TRLBand;
    RLBandSocioTit: TRLBand;
    rlBandTitulo: TRLBand;
    RlblTitulo: TRLLabel;
    rlbl_CabeLinha1: TRLLabel;
    rlbl_CabeLinha2: TRLLabel;
    rlbl_CabeLinha3: TRLLabel;
    rlbl_CabeTitulo: TRLLabel;
    rlbl_Filtrocgc: TRLLabel;
    rlbl_QtdClientes: TRLLabel;
    rlbl_TitAtivo: TRLLabel;
    rlbl_TitAtivo1: TRLLabel;
    rlbl_TitCPF: TRLLabel;
    rlbl_TitEmail: TRLLabel;
    rlbl_TitEnde: TRLLabel;
    rlbl_TitFone: TRLLabel;
    rlbl_TitFone2: TRLLabel;
    rlbl_TitFone3: TRLLabel;
    rlbl_TitFone4: TRLLabel;
    rlbl_TitFone5: TRLLabel;
    rlbl_TitNome: TRLLabel;
    rlbl_ValGeralConta: TRLLabel;
    RLDBnome: TRLDBText;
    RLDBnome1: TRLDBText;
    RLDBnome2: TRLDBText;
    RLDBnome3: TRLDBText;
    RLDBnome4: TRLDBText;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText4: TRLDBText;
    RLGroupCliente: TRLGroup;
    RLReport1: TRLReport;
    RLSystemInfo1: TRLSystemInfo;
    procedure FormCreateCli(Sender: TObject);
    function carregaRelatorio(strFiltroSql:String):boolean;
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBandClienteBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
         giQtdCliente: Integer;
  public

  end;

var
  frmRelatorioClientes: TfrmRelatorioClientes;

implementation


{$R *.lfm}

{ TfrmRelatorioClientes }

procedure TfrmRelatorioClientes.FormCreateCli(Sender: TObject);
begin
   try

     QryCabecalhoCli.Close;
     QryCabecalhoCli.SQL.Text:= '       SELECT       '#13+
                                '       RAZAOSOCIAL, '#13+
                                '       Endereco,    '#13+
                                '       Bairro,      '#13+
                                '       Cidade,      '#13+
                                '       CGC,         '#13+
                                '       EMAIL,       '#13+
                                '       FONE         '#13+
                                '       FROM CAD_EMPRESA' ;
     QryCabecalhoCli.Open;
     rlbl_CabeTitulo.Caption:= QryCabecalhoCli.FieldByName('RAZAOSOCIAL').AsString;
     rlbl_CabeLinha1.Caption:= QryCabecalhoCli.FieldByName('Endereco').AsString;
     rlbl_CabeLinha2.Caption:= QryCabecalhoCli.FieldByName('CGC').AsString;
     rlbl_CabeLinha3.Caption:= QryCabecalhoCli.FieldByName('EMAIL').AsString;

     QryCabecalhoCli.Close;

   finally
   end;
   end;

 function TfrmRelatorioClientes.carregaRelatorio(strFiltroSql: String): boolean;
 begin
  try

     QryRelCli.Close;
     QryRelCli.SQL.Text:= '       SELECT     '#13+
                          '       cliente,   '#13+
                          '       Nome,      '#13+
                          '       bairro,    '#13+
                          '       cidade,    '#13+
                          '       uf,        '#13+
                          '       cep,       '#13+
                          '       Endereco,  '#13+
                          '       CGC,       '#13+
                          '       EMAIL,     '#13+
                          '       FONE       '#13+
                          '       FROM Cad_Clientes '#13+
                          '       WHERE 1=1 '#13+
                                  strFiltroSql+#13;
     QryRelCli.SQL.Add('ORDER BY cliente');
     QryRelCli.Open;

     Result := not QryRelCli.IsEmpty;

     //rlbl_nome.Caption:= QryRelCli.FieldByName('nome').AsString;
     //select cliente,Nome,Endereco,Bairro,Cidade,UF,CEP,CGC,Fone from Cad_Clientes ORDER BY Nome
     //QryRelCli.Close;
  Except
    on E:Exception do
    begin
       Result := false
        // MsgErro('Ocorreu um erro ao carregar o cabeçalho do relatório.',E);
    end;
  end;
end;

 procedure TfrmRelatorioClientes.RLBand1BeforePrint(Sender: TObject;
   var PrintIt: Boolean);
 begin
  rlbl_QtdClientes.Caption:= 'Qtd. Clientes: ' + FormatFloat('#,#00',giQtdCliente);

 end;

 procedure TfrmRelatorioClientes.RLBandClienteBeforePrint(Sender: TObject;
   var PrintIt: Boolean);
 begin
         giQtdCliente:=giQtdCliente+1;
 end;





end.


