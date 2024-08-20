
create database db_faturamento;
use db_faturamento;

create table Contas_a_receber (
		nome varchar (60),
		numero int primary key not null,
		valor numeric (10,2),
		vencimento date,
		banco char (20)
);

insert into Contas_a_receber (nome, numero, valor, vencimento, banco)
		values  ('ABC PAPELARIA', 100100, 5000.00, '2017-01-20', 'ITAU'),
				('LIVRARIA FERNANDES', 100110, 2500.00, '2017-01-22', 'ITAU'),
				('LIVRARIA FERNANDES', 100120, 1500.00, '2016-10-15', 'BRADESCO'),
				('ABC PAPELARIA', 100130, 8000.00, '2016-10-15', 'SANTANDER'),
				('LER E SABER', 200120, 10500.00, '2018-04-26', 'BANCO DO BRASIL'),
				('LIVROS E CIA', 200125, 2000.00, '2018-04-26', 'BANCO DO BRASIL'),
				('LER E SABER', 200130, 11000.00, '2018-09-26', 'ITAU'),
				('PAPELARIA SILVA', 250350, 1500.00, '2018-01-26', 'BRADESCO'),
				('LIVROS MM', 250360, 500.00, '2018-12-18', 'SANTANDER'),
				('LIVROS MM', 250370, 3400.00, '2018-04-26', 'SANTANDER'),
				('PAPELARIA SILVA', 250380, 3500.00, '2018-04-26', 'BANCO DO BRASIL'),
				('LIVROS E CIA', 453360, 1500.00, '2018-06-15', 'ITAU'),
				('LIVROS MM', 453365, 5400.00, '2018-06-15', 'BRADESCO'),
				('PAPELARIA SILVA', 453370, 2350.00, '2017-12-27', 'ITAU'),
				('LIVROS E CIA', 453380, 1550.00, '2017-12-27', 'BANCO DO BRASIL'),
				('ABC PAPELARIA', 980130, 4000.00, '2016-12-11', 'ITAU'),
				('LIVRARIA FERNANDES', 770710, 2500.00, '2016-11-15', 'SANTANDER'),
				('ABC PAPELARIA', 985001, 3000.00, '2016-09-11', 'ITAU'),
				('PAPEL E AFINS', 985002, 2500.00, '2016-03-12', 'SANTANDER'),
				('LER E SABER', 888132, 2500.00, '2017-03-05', 'ITAU');

------------------------------------------------------------------------------------------------

/* 1. Listar nome,vencimento e valor de cada duplicata da tabela*/

select
		nome,
		vencimento,
		valor 
from Contas_a_receber;

/*2. Apresentar o número das duplicatas depositadas no banco Itaú */

select 
		nome, 
		banco
	from Contas_a_receber
where banco = 'Itau'

/*4. Quais são as duplicatas (número, vencimento, valor e nome) que vencem no ano de 2017.*/

select 
		numero,
		vencimento,
		valor,
		nome
	from Contas_a_receber
where year(vencimento) = '2017'
group by numero, vencimento, valor, nome

/*5. Apresentar as duplicatas (número, vencimento, valor e nome) que não estão depositadas nos bancos Itaú e
Santander.*/

select 
		numero,
		vencimento,
		valor,
		nome,
		banco
	from Contas_a_receber
where not banco between 'itau' and 'santander'

/*6. Quanto é o valor da divida o cliente PAPELARIA SILVA, e quais são as duplicatas?*/

select 
		nome,
		SUM (valor) as valor_da_divida
	from Contas_a_receber
where nome like ('PAPELARIA SILVA%')
group by nome


/*7. Retirar da tabela a duplicata 770710 do cliente LIVRARIA FERNANDES, 
por ter sido devidamente quitada.*/

select *
	from Contas_a_receber
where not numero = '770710' 

/*8. Apresentar uma listagem em ordem alfabética por nome do cliente de todos 
os campos da tabela.*/

select *
	from Contas_a_receber
order by nome asc

/*9. Apresentar uma listagem em ordem de data de vencimento com o nome do cliente, 
banco, valor e vencimento.*/

select 
		nome,
		vencimento,
		banco,
		valor
	from Contas_a_receber
order by vencimento asc

/*10. As duplicatas do Banco do Brasil foram transferidas para o Santander. 
Proceder o ajuste dos registros.*/

UPDATE Contas_a_receber
SET banco = 'Santander'
WHERE banco = 'Banco do Brasil';

/*11. Quais são os clientes que possuem suas duplicatas depositadas no Banco Bradesco?*/

select 
		numero,
		nome, 
		banco
	from Contas_a_receber
where banco = 'bradesco'

/*12. Qual é a previsão de recebimento no período de 01/01/2016 até 31/12/2016?*/

select 
		vencimento,
		SUM (valor) as recebimento
	from Contas_a_receber
where vencimento between '2016-01-01' and '2016-12-31'
group by vencimento

/*13. Quanto a empresa tem para receber no período de 01/08/2016 até 30/08/2016?*/

select 
		SUM (valor) as recebimento
	from Contas_a_receber
where vencimento between '2016-08-01' and '2016-08-30'


/*15. Acrescentar uma multa de 15% para todos os títulos que 
se encontram vencidos no período de 01/01/2016 até 31/12/2016.*/

UPDATE Contas_a_receber
SET valor = valor * 1.15  -- Acrescenta uma multa de 15%
WHERE vencimento BETWEEN '2016-01-01' AND '2016-12-31'
    AND vencido = 1; -- Supondo que 1 indica que o título está vencido na sua tabela
		

/*16. Acrescentar uma multa de 5% para todos os títulos vencidos 
entre 01/01/2017 e 31/05/2017 que sejam do cliente LER E SABER.*/

UPDATE Contas_a_receber
SET valor = valor * 1.05  -- Acrescenta uma multa de 5%
WHERE vencimento BETWEEN '2017-01-01' AND '2017-05-31'
    AND nome = 'LER E SABER';

/*17. Qual é a média aritmética dos valores das duplicatas 
do ano de 2016?*/

select 
		AVG(valor) as media_aritimetica
	from Contas_a_receber
where year (vencimento) = '2016'

/*18. Exiba as duplicatas e nome dos respectivos clientes que possuem
duplicatas com valor superior a 10000,00?*/

select 
		numero,
		nome,
		valor
	from Contas_a_receber
where valor > 10000.00

/*19. Qual o valor total das duplicatas lançadas para o banco Santander?*/

select 
		SUM (valor) as Valor_total,
		banco
	from Contas_a_receber
where banco = 'santander'
group by banco

/*20. Quais são os clientes que possuem suas duplicatas 
depositadas nos Bancos Bradesco ou Itaú?*/

select 
		numero,
		nome,
		banco
	from Contas_a_receber
where banco = 'Bradesco' or banco =  'Itau'
--ou assim:  where banco in ('bradesco', 'itau')
