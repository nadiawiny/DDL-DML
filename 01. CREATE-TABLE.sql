-- CRIANDO O BANCO --

use master 

CREATE DATABASE PRIMEIRO_BD   /*criando o banco*/

-- COLOCANDO EM USO E CRIANDO TABELAS --

USE PRIMEIRO_BD  /*colocar o banco em uso*/

CREATE TABLE CLIENTES /*criar uma tabela para o seu BD*/
(
	ID_CLIENTES INT,           /*tipos de dados: int,number, decimal, float, date, char, varchar*/	
	NOME VARCHAR (30),
	DATA_CADASTRO DATETIME, 
	EMAIL VARCHAR (20)		
),

CREATE TABLE LIVROS 
(
	ID_LIVRO INT,
	NOME_LIVRO VARCHAR (30),
	ANO_LIVRO CHAR (20), 
	CLASSIFICACAO VARCHAR (30)
)

-- INSERINDO DADOS --

USE PRIMEIRO_BD

/*inserir dados na tabela do seu banco*/
INSERT INTO CLIENTES 
(
	[ID_CLIENTES],
	[NOME],
	[DATA_CADASTRO],
	[EMAIL]
)

VALUES (3,	'Maria Eduarda',GETDATE(),'contato@maria.com.br');

INSERT INTO CLIENTES 
(
	[ID_CLIENTES],
	[NOME],
	[DATA_CADASTRO],
	[EMAIL]
)

VALUES (4, 'Jos� ricardo', GETDATE(), 'jose.ricardo@gmai.com')


-- ALTERANDO DADOS, COLUNA E CAMPOS --

USE PRIMEIRO_BD

ALTER TABLE CLIENTES 
ALTER COLUMN EMAIL VARCHAR (60) /*alterando uma coluna na tabela*/

-- ATUALIZANDO DADOS DA TABELA --

			--UPDATE --
UPDATE CLIENTES SET ID_CLIENTES = 2 WHERE EMAIL =  '55225 84488454 contato@maria.com.br' -- alterei o id do cliente 
UPDATE CLIENTES SET EMAIL = 'contato@claudia.com.br' WHERE ID_CLIENTES = 2 -- alterei o email
UPDATE CLIENTES SET NOME = 'Claudia silva' WHERE ID_CLIENTES = 2  -- alterei o nome

-- DELETENDO DADOS DA TABELA --

	-- delet --

DELETE FROM CLIENTES WHERE ID_CLIENTES = 4 -- deletando o usuario 4 da tabela 

-- CONSULTANDO A TABELA E SEUS DADOS --

select * from CLIENTES