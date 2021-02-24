unit U_FiltroPesquisaCliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, U_FrmFiltroRelatorioBase;

type
  { TFiltroPesquisaCliente }

  TFiltroPesquisaCliente = class(TFrmFiltroRelatorioBase)
    RBTipoGeral: TRadioButton;
    RBTipoCPF: TRadioButton;
    RBTipoCGC: TRadioButton;
    procedure btnImprimirClick(Sender: TObject);

  private

  public

  end;

var
  FiltroPesquisaCliente: TFiltroPesquisaCliente;

implementation

uses
  u_RelatorioClientes;

{$R *.lfm}

{ TFiltroPesquisaCliente }

procedure TFiltroPesquisaCliente.btnImprimirClick(Sender: TObject);
var
  lsFiltroSql: string;
begin

  lsFiltroSql := '';

  frmRelatorioClientes := TfrmRelatorioClientes.Create(Self);
  try
    btnImprimir.Enabled := False;

    if RBTipoCPF.Checked = True then
    begin
      lsFiltroSql := lsFiltroSql + ' and TIPO = ''F''';
      frmRelatorioClientes.rlbl_Filtrocgc.Caption := 'Status: CPF';
    end
    else if RBTipoCGC.Checked = True then
    begin
      lsFiltroSql := lsFiltroSql + ' and TIPO = ''J''';
      frmRelatorioClientes.rlbl_Filtrocgc.Caption := 'Status: CGC';
    end
    else
      frmRelatorioClientes.rlbl_Filtrocgc.Caption := 'Status: Geral';

    if frmRelatorioClientes.carregaRelatorio(lsFiltroSql) then
      frmRelatorioClientes.RLReport1.PreviewModal
    //else
    //msgAlerta('Sem registros para este filtro!');
  finally
    btnImprimir.Enabled := True;
    FreeAndNil(frmRelatorioClientes);
  end;

end;



end.



