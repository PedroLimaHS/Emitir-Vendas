unit Ulogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, ZDataset, U_DtmConexao, U_Util, U_Usuario;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    btnEntrar: TSpeedButton;
    btnSair: TSpeedButton;
    QryLogin: TZQuery;
    procedure btnEntrarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: char);
    procedure edtUsuarioKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);


  private
    gbEntrou: boolean;

  public


  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.lfm}

{ TfrmLogin }


procedure TfrmLogin.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.edtSenhaKeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #13)then
   Begin
     btnEntrar.click;
     //edtSenha.setfocus;
   end;
end;

procedure TfrmLogin.edtUsuarioKeyPress(Sender: TObject; var Key: char);
begin
     if (Key = #13)then
   Begin
     edtSenha.SetFocus;
   end;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if not gbEntrou then
     Application.Terminate;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
     gbEntrou:= false;
end;


procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin

    if Trim(edtUsuario.Text) = '' then
  begin
    ShowMessage('Informe o usuário!');
    edtUsuario.SetFocus;
    Exit;
  end;


  if Trim(edtSenha.Text) = '' then
  begin
    ShowMessage('Informe a senha!');
    edtSenha.SetFocus;
    Exit;
  end;

  try
    QryLogin.Close;
    QryLogin.SQL.Text := 'select Nome, senha from Splash '#13 +
      'where Nome = :usuario and      '#13 +
      'Senha = :senha                 ';
    QryLogin.ParamByName('usuario').AsString := edtUsuario.Text;
    QryLogin.ParamByName('senha').AsString := edtSenha.Text;
    QryLogin.Open;

    usuarioLogado := TUsuario.Create;
    usuarioLogado.nome:=edtUsuario.Text;
    usuarioLogado.senha:=edtSenha.Text;

    //QryLogin.Last;
    //QryLogin.First;

    //ShowMessage(IntToStr(QryLogin.RecordCount));
    //ShowMessage(QryLogin.fieldbyname('nome').AsString);

    if QryLogin.IsEmpty then
    begin
      ShowMessage('Usuario/Senha Inválido!');
      Exit;
    end
    else
    begin
      gbEntrou:= true;
      Self.Close;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao verificar usuario.' + #13 + 'Erro: ' +
        e.Message);
    end;
  end;
end;



end.


