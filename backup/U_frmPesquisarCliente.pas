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
    btnSair: TSpeedButton;
    DBGrid1: TDBGrid;
    dsCliente: TDataSource;
    edtPesquisa: TEdit;
    lblPesquisa: TLabel;
    lblPesquisa1: TLabel;
    Panel1: TPanel;
    procedure btnSairClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
       gsCampoPesq:String;
  public

  end;

var
  frmpesquisarcliente: Tfrmpesquisarcliente;

implementation

{$R *.lfm}


{ Tfrmpesquisarcliente }


procedure Tfrmpesquisarcliente.FormCreate(Sender: TObject);
begin
  dsCliente.DataSet := dtmClientes.Qrycliente;
end;

procedure Tfrmpesquisarcliente.btnSairClick(Sender: TObject);
begin
  self.Close;
end;

procedure Tfrmpesquisarcliente.DBGrid1TitleClick(Column: TColumn);
begin
  lblPesquisa.Caption:= Column.Title.Caption;
  gsCampoPesq := Column.FieldName;
  lblPesquisa.Visible:= True;
end;

procedure Tfrmpesquisarcliente.edtPesquisaChange(Sender: TObject);
begin
  if(not dtmClientes.Qrycliente.IsEmpty)then
  begin
       dtmClientes.Qrycliente.Locate(gsCampoPesq,edtPesquisa.Text,[loPartialKey, loCaseInsensitive]);
  end;
end;

end.

