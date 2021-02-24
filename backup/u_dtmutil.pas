unit U_dtmUtil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { Tdtmutil }
  TdtmUtil = class(TdtmUtil)
  private

  public
    function abreConexaoutil:Boolean;

  end;

var
  dtmUtil: TdtmUtil;

implementation

{$R *.lfm}
{ TdtmUtil }

function Tdtmutil.abreConexao: Boolean;
begin
  try
    zConexao.Connected:= true;
  except
    Application.MessageBox('Erro ao conectar com o banco de dados. Aplicação será finalizada!', 'Atenção');
    Application.Terminate;
  end;

end;

end.
