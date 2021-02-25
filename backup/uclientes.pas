unit uClientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls, Buttons, DBCtrls, Grids;

type



  { TFrmCliente }

  TFrmCliente = class(TForm)
    btnPesquisarCliente: TSpeedButton;
    DSDropFormaPagamentoCli: TDataSource;
    DBCBFormaPagamento: TDBComboBox;
    DBComboBox1: TDBComboBox;
    edtBairro: TEdit;
    edtCgc: TEdit;
    edtCidade: TEdit;
    edtCliente: TEdit;
    edtEmail: TEdit;
    edtEndereco: TEdit;
    edtFone: TEdit;
    edtNome: TEdit;
    edtUF: TEdit;
    GroupBox1: TGroupBox;
    LBLBairro: TLabel;
    LBLCGC: TLabel;
    LBLCidade: TLabel;
    LBLCliente: TLabel;
    LBLEdenreco: TLabel;
    LBLEmail: TLabel;
    LBLFone: TLabel;
    LBLFormaPagamento: TLabel;
    LBLNome: TLabel;
    LBLUf: TLabel;
    PClienteTop: TPanel;
    StringGrid1: TStringGrid;

   procedure btnPesquisarClienteClick(Sender: TObject);
   //procedure btntesteClick(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   procedure FormDestroy(Sender: TObject);


  private

   procedure inicializandoStringGrid();

  public

  end;

var
  FrmCliente: TFrmCliente;

implementation

{$R *.lfm}

uses
  U_DtmClientes, U_frmPesquisarCliente;


{ TFrmCliente }



procedure TFrmCliente.FormCreate(Sender: TObject);

begin
  dtmClientes := TDtmClientes.Create(Self);
  inicializandoStringGrid;


  // fazer um if verificando se existe a tabela de cliente/produto se nao tiver criar
end;

procedure TFrmCliente.btnPesquisarClienteClick(Sender: TObject);
var
  servcount : integer;
  lsFiltroSql: string;
begin
  try
    lsFiltroSql := '';
    frmPesquisarCliente := TfrmPesquisarCliente.Create(Self);
    frmPesquisarCliente.ShowModal;

    edtNome.Text := dtmClientes.Qrycliente.FieldByName('nome').AsString;
    edtCliente.Text := dtmClientes.Qrycliente.FieldByName('cliente').AsString;
    edtcgc.Text := dtmClientes.Qrycliente.FieldByName('cgc').AsString;
    edtEndereco.Text := dtmClientes.Qrycliente.FieldByName('endereco').AsString;
    edtBairro.Text := dtmClientes.Qrycliente.FieldByName('bairro').AsString;
    edtcidade.Text := dtmClientes.Qrycliente.FieldByName('cidade').AsString;
    edtuf.Text := dtmClientes.Qrycliente.FieldByName('uf').AsString;
    edtFone.Text := dtmClientes.Qrycliente.FieldByName('fone').AsString;
    edtEmail.Text := dtmClientes.Qrycliente.FieldByName('email').AsString;

    lsFiltroSql := lsFiltroSql + QuotedStr(edtCliente.Text);


    dtmClientes.carregaprodutocliente(lsFiltroSql);

    dtmClientes.QryServicoCli.FetchAll;
   StringGrid1.RowCount:= dtmClientes.QryServicoCli.RecordCount + 1;

   for servcount := 1 to dtmClientes.QryServicoCli.RecordCount do
   begin
     StringGrid1.Cells[1,servcount] := dtmClientes.QryServicoCli.FieldByName('produto').AsString;
     StringGrid1.Cells[2,servcount] := dtmClientes.QryServicoCli.FieldByName('descricao').AsString;
     StringGrid1.Cells[3,servcount] := dtmClientes.QryServicoCli.FieldByName('valor').AsString;


     dtmClientes.QryServicoCli.Next;
   end;


   finally
    FreeAndNil(frmPesquisarCliente);
  end;
end;


{
procedure TFrmCliente.btntesteClick(Sender: TObject);
var servcount : integer;
begin
   dtmClientes.QryServicoCli.FetchAll;
   StringGrid1.RowCount:= dtmClientes.QryServicoCli.RecordCount + 1;
   for servcount := 1 to dtmClientes.QryServicoCli.RecordCount do
   begin
     StringGrid1.Cells[1,servcount] := dtmClientes.QryServicoCli.FieldByName('produto').AsString;
     StringGrid1.Cells[2,servcount] := dtmClientes.QryServicoCli.FieldByName('descricao').AsString;
     dtmClientes.QryServicoCli.Next;
   end;
end;
  }

  {
  USE [SingemSQL]
GO

/****** Object:  Table [dbo].[Cli_servicoJF]    Script Date: 24/02/2021 01:33:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Cli_servicoJF](
	[cliente] [varchar](50) NULL,
	[produto] [varchar](50) NULL,
	[valor] [float] NULL,
	[descricaoserv] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
  }

procedure TFrmCliente.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtmClientes);
end;

procedure TFrmCliente.inicializandoStringGrid();
begin
  //nome das celulas do string grid
   StringGrid1.ColCount := 4;
   StringGrid1.RowCount := 1;

   StringGrid1.Cells[0,0] := '';
   StringGrid1.Cells[1,0] := 'Codigo';
   StringGrid1.Cells[2,0] := 'Serviços';
   StringGrid1.Cells[3,0] := 'Valor';
end;


end.
