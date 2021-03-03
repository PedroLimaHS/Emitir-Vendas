program login;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uPrincipal, Ulogin, zcomponent, U_DtmConexao, uClientes, U_DtmClientes,
  U_Cliente, U_frmPesquisarCliente, U_Util, U_Usuario, u_RelatorioClientes,
  u_relatorioBase, U_FrmFiltroRelatorioBase, U_FiltroPesquisaCliente,
  u_frmDistribuicaoCli, U_dtmDistribuicao
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDtmConexao, DtmConexao);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);

  //abre conexao com o banco
  DtmConexao.abreConexao;
  Application.CreateForm(TfrmRelatorioClientes, frmRelatorioClientes);
  Application.CreateForm(Trelatoriobase, relatoriobase);
  Application.CreateForm(TFrmFiltroRelatorioBase, FrmFiltroRelatorioBase);
  Application.CreateForm(TFiltroPesquisaCliente, FiltroPesquisaCliente);
  Application.CreateForm(TFrmDistribuicaoCLi, FrmDistribuicaoCLi);
  Application.CreateForm(TDtmdistribuicao, Dtmdistribuicao);
  Application.Run;
end.

