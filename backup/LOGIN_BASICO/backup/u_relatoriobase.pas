unit u_relatorioBase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ZDataset, RLReport, DB;

type

  { Trelatoriobase }

  Trelatoriobase = class(TForm)
    dsRelatorioBase: TDataSource;
    rlBandCabecalho: TRLBand;
    rlBandFooter: TRLBand;
    rlBandTitulo: TRLBand;
    RlblTitulo: TRLLabel;
    rlbl_CabeLinha1: TRLLabel;
    rlbl_CabeLinha2: TRLLabel;
    rlbl_CabeLinha3: TRLLabel;
    rlbl_CabeTitulo: TRLLabel;
    RLReport1: TRLReport;
    QryRelatorioBase: TZReadOnlyQuery;
    RLSystemInfo1: TRLSystemInfo;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  relatoriobase: Trelatoriobase;

implementation


{$R *.lfm}

{ Trelatoriobase }

procedure Trelatoriobase.FormCreate(Sender: TObject);
begin
  try
     QryRelatorioBase.Close;
     QryRelatorioBase.SQL.Text := '       SELECT         '#13+
                                  '       RAZAOSOCIAL,   '#13+
                                  '       Endereco,      '#13+
                                  '       Bairro,        '#13+
                                  '       Cidade,        '#13+
                                  '       CGC,           '#13+
                                  '       EMAIL,         '#13+
                                  '       FONE           '#13+
                                  '       FROM CAD_EMPRESA  ';




     QryRelatorioBase.Open;

     rlbl_CabeTitulo.Caption:= QryRelatorioBase.FieldByName('RAZAOSOCIAL').AsString;
     rlbl_CabeLinha1.Caption:= QryRelatorioBase.FieldByName('Endereco').AsString;
     rlbl_CabeLinha2.Caption:= QryRelatorioBase.FieldByName('CGC').AsString;
     rlbl_CabeLinha3.Caption:= QryRelatorioBase.FieldByName('EMAIL').AsString;

     QryRelatorioBase.Close;


  except
    on E:Exception do
    begin
        // MsgErro('Ocorreu um erro ao carregar o cabeçalho do relatório.',E);
    end;
  end;
end;

end.
