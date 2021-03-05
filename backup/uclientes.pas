unit uClientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls, Buttons, DBCtrls, Grids;

type

  { TFrmCliente }

  TFrmCliente = class(TForm)
    BtnEditarCli: TButton;
    //BtnEditarCli: TButton;
    btnPesquisarCliente: TSpeedButton;
    BtnSalvarCli: TButton;
    BtnCancelarCli: TButton;
    BtnSalvarServico: TButton;
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
    EdtProCLi_Codigo: TEdit;
    EdtProCLi_Descricao: TEdit;
    EdtProCLi_Valor: TEdit;
    edtUF: TEdit;
    GroupBox1: TGroupBox;
    LBLBairro: TLabel;
    LBLCGC: TLabel;
    LBLCidade: TLabel;
    LBLCliente: TLabel;
    lblcodigo: TLabel;
    LBLEdenreco: TLabel;
    LBLEmail: TLabel;
    LBLFone: TLabel;
    LBLFormaPagamento: TLabel;
    LBLNome: TLabel;
    lblservicos: TLabel;
    LBLUf: TLabel;
    lblValor: TLabel;
    PnlCabecalho: TPanel;
    PClienteTop: TPanel;
    StringGrid1: TStringGrid;

    procedure BtnCancelarCliClick(Sender: TObject);
//  procedure BtnEditarCliClick(Sender: TObject);
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure BtnSalvarCliClick(Sender: TObject);
    procedure BtnSalvarServicoClick(Sender: TObject);
    procedure DSDropFormaPagamentoCliDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);

  private
    procedure inicializandoStringGrid();
    procedure limparcampos();
    procedure desabilitarcampos();
    procedure habilitarcampos();
    procedure Preencerstringgrid();
    procedure limparcamposservicos();

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
  desabilitarcampos();
  // fazer um if verificando se existe a tabela de cliente/produto se nao tiver criar
end;

procedure TFrmCliente.btnPesquisarClienteClick(Sender: TObject);
var
  lsFiltroSql: string;
begin
  try
    lsFiltroSql := '';
    desabilitarcampos();
    frmPesquisarCliente := TfrmPesquisarCliente.Create(Self);
    frmPesquisarCliente.ShowModal;
    //BtnEditarCli.Enabled:=true;
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
    Preencerstringgrid();
   finally
    FreeAndNil(frmPesquisarCliente);
  end;
end;



(*procedure TFrmCliente.BtnEditarCliClick(Sender: TObject);
begin
  if Trim(EdtProCLi_Descricao.Text) = '' then
    begin
      ShowMessage('Selecione um produto!');
    end
  else
    begin
      habilitarcampos();
    end;
end;*)

procedure TFrmCliente.BtnSalvarCliClick(Sender: TObject);
begin
  //ShowMessage('Salvo!');
  limparcampos();
end;

procedure TFrmCliente.BtnSalvarServicoClick(Sender: TObject);
var
  lsFilDescSql: String;
begin
  lsFilDescSql:='';
  if (Trim(EdtProCLi_Descricao.Text) = '') or (Trim(EdtProCLi_Valor.Text) = '') then
    begin
      ShowMessage('Campos do serviço em branco!');
      EdtProCLi_Descricao.SetFocus;
      Exit;
    end;
      lsFilDescSql := lsFilDescSql + EdtProCLi_Descricao.Text +' '+ Edtmes.Text + ' / '+ EdtAno.text;
      dtmClientes.updateprodutocliente(edtCliente.Text ,EdtProCLi_Valor.Text, EdtProCLi_Descricao.Text , EdtProCLi_Codigo.Text);
      dtmClientes.carregaprodutocliente(edtCliente.Text);
      Preencerstringgrid();
      limparcamposservicos()
end;

procedure TFrmCliente.DSDropFormaPagamentoCliDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TFrmCliente.BtnCancelarCliClick(Sender: TObject);
begin
 limparcampos();
 //BtnEditarCli.Enabled:= false;
end;


procedure TFrmCliente.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtmClientes);
end;

procedure TFrmCliente.StringGrid1DblClick(Sender: TObject);
begin
  EdtProCLi_Codigo.Caption := (StringGrid1.Cells[0, StringGrid1.Row]);
  EdtProCLi_Descricao.Caption := (StringGrid1.Cells[1, StringGrid1.Row]);
  EdtProCLi_Valor.Caption := (StringGrid1.Cells[2, StringGrid1.Row]);
  habilitarcampos();
end;

procedure TFrmCliente.inicializandoStringGrid();
begin
  //nome das celulas do string grid
  StringGrid1.ColCount := 3;
  StringGrid1.RowCount := 1;

  //StringGrid1.Cells[0,0] := '';
  StringGrid1.Cells[0, 0] := 'Codigo';
  StringGrid1.Cells[1, 0] := 'Serviços';
  StringGrid1.Cells[2, 0] := 'Valor';
end;

procedure TFrmCliente.limparcampos();
begin
  edtNome.Text := '';
  edtCliente.Text := '';
  edtcgc.Text := '';
  edtEndereco.Text := '';
  edtBairro.Text := '';
  edtcidade.Text := '';
  edtuf.Text := '';
  edtFone.Text := '';
  edtEmail.Text := '';
  EdtProCLi_Descricao.Text := '';
  EdtProCLi_Codigo.Text := '';
  EdtProCLi_Valor.Text := '';
  EdtProCLi_Descricao.Enabled := False;
  EdtProCLi_Valor.Enabled := False;
  inicializandoStringGrid();
  desabilitarcampos();

end;

procedure TFrmCliente.desabilitarcampos();
begin
  EdtProCLi_Codigo.Enabled := False;
  EdtProCLi_Descricao.Enabled := False;
  EdtProCLi_Valor.Enabled := False;
  //BtnEditarCli.Enabled:=False;
  BtnSalvarCli.Enabled:=False;
  BtnCancelarCli.Enabled:=False;

  edtNome.Enabled := False;
  edtCliente.Enabled := False;
  edtcgc.Enabled := False;
  edtEndereco.Enabled := False;
  edtBairro.Enabled := False;
  edtcidade.Enabled := False;
  edtuf.Enabled := False;
  edtFone.Enabled := False;
  edtEmail.Enabled := False;

end;

procedure TFrmCliente.habilitarcampos();
begin
   EdtProCLi_Descricao.Enabled := True;
   EdtProCLi_Valor.Enabled := True;
   BtnSalvarCli.Enabled:= True;
   BtnCancelarCli.Enabled:=True;

end;

procedure TFrmCliente.limparcamposservicos();
begin
  EdtProCLi_Descricao.Text := '';
  EdtProCLi_Codigo.Text := '';
  EdtProCLi_Valor.Text := '';
end;

procedure TFrmCliente.Preencerstringgrid();
var
  servcount: integer;
begin
  dtmClientes.QryServicoCli.FetchAll;
  StringGrid1.RowCount := dtmClientes.QryServicoCli.RecordCount + 1;

  for servcount := 1 to dtmClientes.QryServicoCli.RecordCount do
    begin
      StringGrid1.Cells[0, servcount] := dtmClientes.QryServicoCli.FieldByName('produto').AsString;
      StringGrid1.Cells[1, servcount] := dtmClientes.QryServicoCli.FieldByName('descricaoserv').AsString;
      StringGrid1.Cells[2, servcount] := dtmClientes.QryServicoCli.FieldByName('valor').AsString;
      dtmClientes.QryServicoCli.Next;
    end;
 end;

end.



