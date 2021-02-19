unit uClientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls, Buttons, DBCtrls, ZDataset;

type



  { TFrmCliente }

  TFrmCliente = class(TForm)
    btnPesquisarCliente: TSpeedButton;
    edtNome: TEdit;

   procedure btnPesquisarClienteClick(Sender: TObject);
   procedure edtnomeChange(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   procedure FormDestroy(Sender: TObject);


  private

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
end;

procedure TFrmCliente.btnPesquisarClienteClick(Sender: TObject);
begin
  try
    frmPesquisarCliente := TfrmPesquisarCliente.Create(Self);
    frmPesquisarCliente.ShowModal;

    edtNome.Text := dtmClientes.Qrycliente.FieldByName('nome').AsString;

   finally
    FreeAndNil(frmPesquisarCliente);
  end;
end;

procedure TFrmCliente.edtnomeChange(Sender: TObject);
begin

end;



procedure TFrmCliente.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtmClientes);
end;


end.
