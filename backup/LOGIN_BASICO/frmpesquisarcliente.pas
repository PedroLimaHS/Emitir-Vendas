unit U_frmPesquisarCliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, DBGrids;

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
    Panel1: TPanel;
    procedure dsClienteDataChange(Sender: TObject; Field: TField);
  private

  public

  end;

var
  frmpesquisarcliente: Tfrmpesquisarcliente;

implementation

{$R *.lfm}

{ Tfrmpesquisarcliente }

procedure Tfrmpesquisarcliente.dsClienteDataChange(Sender: TObject; Field: TField);
begin

end;

end.

