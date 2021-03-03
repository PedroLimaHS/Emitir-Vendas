unit u_frmDistribuicaoCli;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  DBGrids, ExtCtrls, DB;

type

  {TFrmDistribuicaoCLi}
  TFrmDistribuicaoCLi = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    dsCliente: TDataSource;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private

  public

  end;

var
  FrmDistribuicaoCLi: TFrmDistribuicaoCLi;


implementation

uses
   U_DtmClientes, U_dtmDistribuicao;

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

procedure TFrmDistribuicaoCLi.Button1Click(Sender: TObject);
var
  maxchave:Integer;
  lsCliente, lsChave:String;
begin
 Dtmdistribuicao := TDtmdistribuicao.Create(self);
 try
    Dtmdistribuicao.SelectValores();

    lsCliente := '';
    lsChave := '';
    while not Dtmdistribuicao.QryCliente.EOF do
    begin
      if Trim(lsCliente) <> Trim(Dtmdistribuicao.QryCliente.FieldByName('CLIENTE').AsString) then
      begin
           lsCliente := Dtmdistribuicao.QryCliente.FieldByName('CLIENTE').AsString;
           lsChave := Dtmdistribuicao.maxChave;
      end;
      Dtmdistribuicao.InsertProdutos(lsChave, Dtmdistribuicao.QryCliente);
      Dtmdistribuicao.QryCliente.Next;
    end;
 finally
    FreeAndNil(Dtmdistribuicao);
 end;


 Dtmdistribuicao.maxchave();
 maxchave:=Dtmdistribuicao.QryMaxChave.FieldByName('vendas').AsInteger;
 ShowMessage(IntToStr(maxchave));

end;

procedure TFrmDistribuicaoCLi.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtmClientes);
end;
end.







