
DECLARE @DOCUMENTO  VARCHAR (10), @CHAVE VARCHAR (10)
SET @DOCUMENTO =(SELECT max (DOCUMENTO)+1 FROM Estoque)
SET @CHAVE= (SELECT VENDAS  FROM numeracao)

SET IDENTITY_INSERT estoque.documento ON



 insert into Estoque (Chave1, Data, Produto, Quantidade,Preco,Vendedor ,tipo , Faturado , ER, Cliente,Historico, Documento, Cancelado, pp , Responsavel , Descricao)

select  '00'+ @CHAVE ,CONVERT (date, GETDATE()) ,jf.produto, '-1',JF.valor,'00','Saída2','1','T',jf.cliente,c.Nome, ,jf.valor,'thiago', jf.descricaoserv  from Cli_servicoJF as jf


inner join Cad_Clientes as c on jf.cliente = c.Cliente



WHERE C.Cliente = '00002'

UPDATE Numeracao SET Vendas = ('00' + Vendas + 1)

 


/*
SELECT Chave1,data, Cliente, Historico, Documento  FROM Estoque where Cliente ='00001' or Cliente ='00002' 
and  data ='27/02/2021' AND TIPO= 'SAÍDA2' 

delete  FROM Estoque where Cliente ='00001' or Cliente ='00002' 
and  data ='27/02/2021' AND TIPO= 'SAÍDA2' 
*/


/*
SELECT Chave1, Cliente, Historico, Documento  FROM Estoque where chave1 ='408' and Cliente ='00001' or Cliente ='00002' and  data ='27/02/2021' 

SELECT * FROM VENDAS WHERE CHAVE='00008'
SELECT Chave1, Cliente, Historico, Documento, Tipo  FROM Estoque where chave1 ='00008' and tipo ='Saída2' 
SELECT * FROM CAReceber WHERE chave ='00008'



insert into Estoque (Chave1, Data, Produto, Quantidade,Preco,Vendedor ,tipo , Faturado , ER, Cliente,Historico, Documento, 
Cancelado, pp , Responsavel , Descricao)
select (SELECT max (vendas) +1 FROM numeracao),'27/02/2021',jf.produto, '-1',JF.valor,'00','Saída2','1','T',jf.cliente,c.Nome, 
(SELECT max (documento) +1 FROM Estoque),'F',jf.valor,'thiago', jf.descricaoserv  from Cli_servicoJF as jf
inner join Cad_Clientes as c on jf.cliente = c.Cliente



update Numeracao set vendas = '00407'




SELECT * FROM Numeracao

SELECT MAX(DOCUMENTO) FROM ESTOQUE

delete from estoque where Chave1 ='00408'



SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pessoa(nome_pessoa, senha_pessoa, cpf_pessoa, rg_pessoa)
VALUES('teste1', 'senha', '123', '456');
INSERT INTO Certificados(nome_certificado, lugar_certificado, idPessoa)
values('cert1', 'rj', (select LAST_INSERT_ID()));
COMMIT;
SET AUTOCOMMIT=1;*/