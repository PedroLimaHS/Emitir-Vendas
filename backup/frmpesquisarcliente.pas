unit U_frmPesquisarCliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, DBGrids, U_DtmClientes;

type

  { Tfrmpesquisarcliente }

  Tfrmpesquisarcliente = class(TForm)
    btnEditar: TSpeedButton;
    btnListar: TSpeedButton;
    DBGrid1: TDBGrid;
    dsClientepsqcli: TDataSource;
    edtPesquisa: TEdit;
    lblPesquisa: TLabel;
    Panel1: TPanel;
    procedure btnEditarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    procedure abreGrid;
  public

  end;

var
  frmpesquisarcliente: Tfrmpesquisarcliente;

implementation

{$R *.lfm}

{ Tfrmpesquisarcliente }

procedure Tfrmpesquisarcliente.FormShow(Sender: TObject);
begin
  abreGrid;
  goColumn := DBGrid1.Columns.Items[0];
  DBGrid1TitleClick(goColumn);
  DSGrid.DataSet.First;
end;


procedure Tfrmpesquisarcliente.btnEditarClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;



procedure Tfrmpesquisarcliente.abreGrid;
begin
  with dtmClientes do
  begin
    QryPsqCliente.Close;
    QryPsqCliente.SQL.Text :=
      'select nome,cgc,fone,cidade FROM CAD_CLIENTES ORDER BY 1';
    QryPsqCliente.Open;
    Application.ProcessMessages;
  end;
end;

end.

