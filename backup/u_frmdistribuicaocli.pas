unit u_frmDistribuicaoCli;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  DBGrids, ExtCtrls, DB;

type

  {TFrmDistribuicaoCLi}
  TFrmDistribuicaoCLi = class(TForm)
    DBGrid1: TDBGrid;
    dsCliente: TDataSource;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);

  private

  public

  end;

var
  FrmDistribuicaoCLi: TFrmDistribuicaoCLi;


implementation

uses
   U_DtmClientes;

{$R *.lfm}

{ TFrmDistribuicaoCLi }


procedure TFrmDistribuicaoCLi.FormShow(Sender: TObject);
begin
//     dtmClientes.Qrycliente.Active:=True;
end;

procedure TFrmDistribuicaoCLi.FormCreate(Sender: TObject);
begin
 dtmClientes := TDtmClientes.Create(Self);
 dsCliente.DataSet :=   dtmClientes.Qrycliente;
end;

procedure TFrmDistribuicaoCLi.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtmClientes);
end;

procedure TFrmDistribuicaoCLi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl)  and (key = 88) then
     TMemo.Visible:= True;

end;





