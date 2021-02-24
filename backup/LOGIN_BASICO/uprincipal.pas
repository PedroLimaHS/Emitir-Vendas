unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, Menus,
  ExtCtrls, Buttons, StdCtrls, ComCtrls, U_Util, u_RelatorioClientes;

type

  { TFrmPrincipal }

  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    stb_Principal: TStatusBar;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private

  public

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  Ulogin, uClientes,U_FiltroPesquisaCliente;

{$R *.lfm}

{ TFrmPrincipal }


procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  try
    frmLogin := TfrmLogin.Create(Self);
    frmLogin.ShowModal;
    if (not Application.Terminated) then
    begin
      stb_Principal.Panels.Items[0].Text := 'Usuário: ' + usuarioLogado.nome;
      Timer1.Enabled:= true;
    end;
  finally
    FreeAndNil(frmLogin);
  end;
end;

procedure TFrmPrincipal.MenuItem3Click(Sender: TObject);
begin
  try
    FrmCliente := TFrmCliente.Create(Self);
    FrmCliente.ShowModal;
  finally
    FreeAndNil(FrmCliente);
  end;
end;

procedure TFrmPrincipal.MenuItem4Click(Sender: TObject);
begin

  FiltroPesquisaCliente := TFiltroPesquisaCliente.Create(Self);
  try
    FiltroPesquisaCliente.ShowModal;

  finally
    FreeAndNil(FiltroPesquisaCliente);
  end;
end;

procedure TFrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
  try
    FrmCliente := TFrmCliente.Create(Self);
    FrmCliente.ShowModal;
  finally
    FreeAndNil(FrmCliente);
  end;

end;

procedure TFrmPrincipal.Timer1Timer(Sender: TObject);
begin
  stb_Principal.Panels.Items[1].Text := FormatDateTime('dd/MM/yyyy hh:MM:ss', Now);
end;


end.

