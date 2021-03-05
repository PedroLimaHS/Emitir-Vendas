unit U_frmPesquisarCliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, DBGrids, U_DtmClientes, ZDataset;

type

  { Tfrmpesquisarcliente }

  Tfrmpesquisarcliente = class(TForm)
    btnSair: TSpeedButton;
    DBGrid1: TDBGrid;
    dsCliente: TDataSource;
    edtPesquisa: TEdit;
    lblPesquisa: TLabel;
    lblPesquisa1: TLabel;
    Panel1: TPanel;
    procedure btnListarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pintaTituloGrid(coluna: String);

  private
       gsCampoPesq:String;
  public

  end;

var
  frmpesquisarcliente: Tfrmpesquisarcliente;

implementation

uses
    U_FiltroPesquisaCliente;

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

procedure Tfrmpesquisarcliente.btnListarClick(Sender: TObject);
begin
  FiltroPesquisaCliente := TFiltroPesquisaCliente.Create(Self);
  try
    FiltroPesquisaCliente.ShowModal;
  finally
    FreeAndNil(FiltroPesquisaCliente);
  end;
end;

procedure Tfrmpesquisarcliente.DBGrid1TitleClick(Column: TColumn);
begin
  lblPesquisa.Caption := Column.Title.Caption;
  gsCampoPesq := Column.FieldName;
  pintaTituloGrid(Column.Title.Caption);
  lblPesquisa.Visible:= True;

  //ordena a grade pelo titulo da coluna clicado
  dtmClientes.Qrycliente.IndexFieldNames:= lblPesquisa.Caption + ' asc';
end;

procedure Tfrmpesquisarcliente.pintaTituloGrid(coluna: String);
var
  liCont:Integer;
begin
  for liCont := 0 to DBGrid1.Columns.Count -1 do
  begin
    if DBGrid1.Columns.Items[liCont].Title.Caption = coluna then
       DBGrid1.Columns.Items[liCont].Title.Font.Color := clBlue
    else
        DBGrid1.Columns.Items[liCont].Title.Font.Color := clBlack;

  end;
end;

procedure Tfrmpesquisarcliente.edtPesquisaChange(Sender: TObject);
begin
  if(not dtmClientes.Qrycliente.IsEmpty)then
  begin
       dtmClientes.Qrycliente.Locate(gsCampoPesq,edtPesquisa.Text,[loPartialKey, loCaseInsensitive]);
       dtmClientes.QryServicoCli.Locate(gsCampoPesq,edtPesquisa.Text,[loPartialKey, loCaseInsensitive]);
       //dtmClientes.Qrycliente.SQL.Add('ORDER BY' + lblPesquisa.Caption);

  end;
end;

end.










