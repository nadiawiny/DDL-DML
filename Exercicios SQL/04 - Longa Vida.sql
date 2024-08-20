create database db_longaVida

use db_longaVida

drop table plano
create table plano(
		numero char(2) primary key not null,
		descricao char(30),
		valor decimal(10,2)
);

insert into plano (numero, descricao, valor)
		values   ('B1', 'basico1', 200.00),
				('B2', 'basico2', 150.00),
				('B3', 'basico3', 100.00),
				('E1', 'executivo1', 350.00),
				('E2', 'executivo2', 300.00),
				('E3', 'executivo3', 250.00),
				('M1', 'master1', 500.00),
				('M2', 'master2', 450.00),
				('M3', 'master3', 400.00);

create table associado (
		plano char(2) not null,
		nome char(40) primary key not null,
		endereco char(35),
		cidade char(20),
		estado char(2),
		CEP char(9),
		foreign key (plano) references plano(numero) 
);
drop table associado
insert into associado (plano, nome, endereco, cidade, estado, CEP)
		values  ('B1', 'JOSE ANTONIO DA SILVA', 'R. FELIPE DO AMARAL, 3450', 'COTIA', 'SP', '06700-000'),
				('B1', 'MARIA DA SILVA SOBRINHO', 'R. FELIPE DE JESUS, 1245', 'DIADEMA','SP', '09960-170'),
				('B1', 'PEDRO JOSE DE OLIVEIRA', 'R. AGRIPINO DIAS, 155', 'COTIA','SP', '06700-011'),
				('B2', 'ANTONIA DE FERNANDES', 'R. PE EZEQUIEL, 567', 'DIADEMA', 'SP','09960-175'),
				('B2', 'ANTONIO DO PRADO', 'R. INDIO TABAJARA, 55', 'GUARULHOS', 'SP', '07132-999'),
				('B3', 'WILSON DE SENA', 'R. ARAPIRACA, 1234', 'OSASCO', 'SP', '06293-001'),
				('B3', 'SILVIA DE ABREU', 'R. DR. JOAO DA SILVA, 5', 'SANTO ANDRE','SP', '09172-112'),
				('E1', 'ODETE DA CONCEIÇÃO', 'R. VOLUNTARIOS DA PATRIA, 10', 'SÃO PAULO' ,'SP', '02010-550'),
				('E2', 'JOAO CARLOS MACEDO', 'R. VISTA ALEGRE, 500', 'SÃO PAULO', 'SP', '04343-990'),
				('E3', 'CONCEIÇÃO DA SILVA', 'AV. VITORIO DO AMPARO, 11', 'MAUA', 'SP', '09312-988'),
				('E3', 'PAULO BRUNO AMARAL', 'R. ARGENZIO BRILHANTE, 88', 'BARUERI', 'SP', '06460-999'),
				('E3', 'WALDENICE DE OLIVEIRA', 'R. OURO VELHO, 12', 'BARUERI', 'SP', '06460-998'),
				('E3', 'MARCOS DO AMARAL', 'R. DO OUVIDOR, 67', 'GUARULHOS', 'SP', '07031-555'),
				('M1', 'MURILO DE SANTANA', 'R. PRATA DA CASA', 'BARUERI', 'SP', '06455-111'),
				('M1', 'LUIZA ONOFRE FREITAS', 'R. VICENTE DE ABREU, 55', 'SANTO ANDRE', 'SP', '09060-667'),
				('M2', 'MELISSA DE ALMEIDA', 'R. FERNANDO ANTONIO,2345', 'SÃO PAULO', 'SP', '04842-987'),
				('M2', 'JOAO INACIO DA CONCEICAO', 'R. PENELOPE CHARMOSA, 34', 'SUZANO', 'SP', '08670-888'),
				('B3', 'AUGUSTA DE ABREU', 'AV. RIO DA SERRA, 909', 'SANTO ANDRE', 'SP', '09061-333'),
				('M3', 'LDA DE MELO DA CUNHA', 'AV. POR DO SOL, 546', 'SANTO ANDRE', 'SP', '09199-444'),
				('M3', 'MARCOS DA CUNHA', 'AV. PEDROSO DE MORAES', 'SÃO PAULO', 'SP', '04040-444');

------------------------------------------------------------------------------------------------------------------------

/*1. Quais campos das tabelas associado e plano 
devem ser utilizados para efetuar o relacionamento entre as tabelas?*/

-- campo plano

/*2. Extrair uma relação geral de todos os associados e os planos que eles possuem.*/
 
 select *
	from plano as pl
inner join associado as ass  -- inner join
on ass.plano = pl.numero

/*3. Quantos associados possuem o plano B1?*/

select 
		plano,
		nome
	from associado
where plano = 'B1'

/*4. Apresente uma relação com todos os nomes, planos e valores de todos os
registros de associados.*/

select 
		nome as nomes,
		plano as planos,
		valor as valores
	from associado as ass
inner join plano as pl
on pl.numero = ass.plano

/*5. Quais são os associados que moram em COTIA ou em DIADEMA?*/

select 
		nome,
		cidade
	from associado
where cidade = 'COTIA' or cidade = 'DIADEMA'

/*6. Apresente o nome, plano e valor dos associados que moram em BARUERI 
e possuem o plano M1.*/

select 
		nome,
		plano,
		valor
	from associado as ass
inner join plano as pl on pl.numero = ass.plano
where cidade = 'BARUERI' and plano = 'M1'

/*7. Apresente uma relação com nome, plano e valor de todos os associados 
residentes em SÃO PAULO*/

select 
		nome,
		plano,
		valor
	from associado as ass
inner join plano as pl on pl.numero = ass.plano
where estado = 'SP' 

/*8. Apresente uma relação completa de todos os campos de ambas as 
tabelas em que o associado possua SILVA no nome.*/

select *
	from associado as ass
join plano as pl on pl.numero = ass.plano
where nome like ('%silva%')

/*9. Devido ao aumento do índice IGPM, a empresa reajustou os valores dos planos básicos em 10%, dos planos
executivos e m 5% e dos planos Máster em 3 %. Atualize os valores na tabela planos.*/

/*10. O associado PEDRO JOSE DE OLIVEIRA alterou 
seu plano de B1 para E3. Faça a devida atualização.*/

/*11. Quantos associados possuem o plano E3?*/

select 
		count (plano) as quantidade_associados
	from associado
where plano = 'E3'

/*12.Liste o nome e o valor de todos os associados que possuem os planos B1, E1 e M1.*/

select 
		nome, 
		valor
	from associado as ass
join plano as pl on pl.numero = ass.plano
where plano in ('B1', 'E1', 'M1')

/*13. Quais são os associados que possuem plano do tipo 
EXECUTIVO, independentemente da categoria ser 1, 2 ou 3?*/

select 
		nome,
		plano 
	from associado
where plano like ('E%')

/*14. Quais são os associados que possuem plano dos tipos Básico e Máster?*/

select 
		nome,
		plano 
	from associado
where plano like ('B%') or plano like ('M%')


/*15. A empresa fechou seu escritório na cidade de SANTO ANDRE e transferiu 
os cliente para um terceirizado. Remova da tabela associados todos os registros
existentes de associados da cidade de SANTO ANDRE*/

delete from associado where cidade = 'santo andre'


/*16. Apresente o nome, plano e valor dos associados que moram em SÃO PAULO
e possuem os planos M2 e M3. A listagem deve estar ordenada pelo campo nome.*/

select 
		nome,
		plano,
		valor
from associado as ass
join plano as pl on pl.numero = ass.plano
where cidade = 'São Paulo' 
and plano in ('M2', 'M3')
order by nome;

/*17. Apresente uma listagem completa de todos os campos de ambas as tabelas ordenados por tipo de plano.*/

select * from associado as ass
join plano as pl on pl.numero = ass.plano
order by plano

/*18. Faça uma relação geral de todos os associados e planos que eles possuem. A relação deve ser apresentada em ordem
ascendente pelo campo tipo de plano e descendente pelo campo de identificação do nome do associado.*/

select * from associado as ass
join plano as pl on pl.numero = ass.plano
order by plano asc, nome desc

/*19. Apresentar uma relação de todos os associados que não possuem o plano Máster.*/

select * from associado as ass
join plano as pl on pl.numero = ass.plano
where not plano like ('M%')


/*20. Apresentar uma listagem em ordem crescente pelo campo nome do associado.
Essa listagem deve ser formada pelos campos Nome da tabela associado e Descrição da tabela Planos*/
select 
		nome,
		descricao
	from  associado as ass
join plano as pl on pl.numero = ass.plano
order by nome desc

/*21.Apresentar uma listagem dos planos que estão situados na faixa de valores de 300 até 500*/
select 
		numero,
		valor
	from plano as pl
where valor >= 300 and valor <= 500

/*22. Apresentar uma relação contendo: nome,plano, descrição do plano e valor de todos os associados que tenham
em seu nome, seja na posição que for, a seqüência AMARAL.*/

select 
		nome,
		plano, 
		descricao,
		valor
	from  associado as ass
join plano as pl on pl.numero = ass.plano
WHERE nome LIKE '%amaral%';

/*23. Quais associados residem na cidade de DIADEMA?*/

select 
		nome
	from associado
where cidade = 'DIADEMA'

/*24. O plano do tipo MASTER teve um reajuste de 6%.
Atualize na tabela planos os valores das categorias 1, 2 e 3.*/

/*25. Quais são os clientes cujo CEP é iniciado com os valores 09?*/

select 
		nome,
		CEP
	from associado
where CEP like '09%'