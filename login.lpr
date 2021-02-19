program login;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uPrincipal, Ulogin, zcomponent, U_DtmConexao, uClientes, U_DtmClientes,
  U_Cliente, U_frmPesquisarCliente, U_Util, U_Usuario
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
  Application.Run;
end.

