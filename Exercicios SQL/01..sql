
/*LISTA DE EXERCICIOS SQL - QUESTAO 01*/

create database loja;

use loja;

create table produtos (
	ID_NF int not null,
	ID_ITEM int not null,
	COD_PROD int not null,
	VALOR_UNIT decimal (10, 2) not null,
	QUANTIDADE int not null, 
	DESCONTO float 
);


insert into produtos(ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, QUANTIDADE, DESCONTO)
			values (1, 1, 1, 25.00, 10, 5),
					(1, 2, 2, 13.50, 3, null),
					(1, 3, 3, 15.00, 2, null),
					(1, 4, 4, 10.00, 1, null),
					(1, 5, 5, 30.00, 1, null),
					(2, 1, 3, 15.00, 4, null),
					(2, 2, 4, 10.00, 5, null),
					(2, 3, 5, 30.00, 7, null),
					(3, 1, 1, 25.00, 5, null),
					(3, 2, 4, 10.00, 4, null),
					(3, 3, 5, 30.00, 5, null),
					(3, 4, 2, 13.50, 7, null),
					(4, 1, 5, 30.00, 10, 15),
					(4, 2, 4, 10.00, 12, 5),
					(4, 3, 1, 25.00, 13, 5),
					(4, 4, 2, 13.50, 15, 5),
					(5, 1, 3, 15.00, 3, null),
					(5, 2, 2, 30.00, 6, null),
					(6, 1, 1, 25.00, 22, 15),
					(6, 2, 3, 15.00, 25, 20),
					(7, 1, 1, 25.00, 10, 3),
					(7, 2, 2, 13.50, 10, 4),
					(7, 3, 3, 15.00, 10, 4),
					(7, 4, 5, 30.00, 10, 1);




/* a- Pesquise os itens que foram vendidos sem desconto. */

Select 
		ID_NF,
		ID_ITEM,
		COD_PROD,
		VALOR_UNIT
	from Produtos where DESCONTO is null   -- o is null >> valores nulos

-----------------------------------------------------------------

/* b) Pesquise os itens que foram vendidos com desconto.*/

Select 
		ID_NF,
		ID_ITEM,
		COD_PROD,
		VALOR_UNIT,
	   (VALOR_UNIT - (VALOR_UNIT * (DESCONTO/100))) as VALOR_VENDIDO  -- calcular o valor de vendido
	from Produtos where DESCONTO > 0 

-----------------------------------------------------------------------------------------------------
/*c) Altere o valor do desconto (para zero) de todos os registros onde este campo e nulo.*/

update produtos set DESCONTO = 0 where DESCONTO is null

/* d) Pesquise os itens que foram vendidos*/
--------------------------------------------------------------------------------------
Select 
		ID_NF,
		ID_ITEM,
		COD_PROD,
		VALOR_UNIT,
		(QUANTIDADE * VALOR_UNIT) as	VALOR_TOTAL,
		DESCONTO,
		(VALOR_UNIT - (VALOR_UNIT * (DESCONTO/100))) as VALOR_VENDIDO
	from produtos

----------------------------------------------------------------------------------------
/*e) Pesquise o valor total das NF e ordene o resultado do maior valor para o menor.*/

Select 
		ID_NF,
		SUM (QUANTIDADE * VALOR_UNIT) as VALOR_TOTAL  
	from produtos
	group by ID_NF
	order by VALOR_TOTAL desc 

-- Neste caso, voc� est� calculando o VALOR_TOTAL com base em duas colunas (QUANTIDADE e VALOR_UNIT), 
-- o que � permitido. Mas voc� tamb�m est� selecionando a coluna ID_NF que n�o est� presente na cl�usula 
-- GROUP BY nem est� sendo usada em uma fun��o de agrega��o
-- Nesta vers�o corrigida, voc� est� somando os valores totais de cada nota fiscal usando a fun��o de agrega��o SUM e agrupando por ID_NF

------------------------------------------------------------------------------------------------	
/*f) Pesquise o valor vendido das NF e ordene o resultado do maior valor para o menor.*/

Select 
		ID_NF,
		SUM (VALOR_UNIT - (VALOR_UNIT * (DESCONTO/100))) as VALOR_VENDIDO,
		SUM (QUANTIDADE * VALOR_UNIT) as VALOR_TOTAL  
	from produtos
	group by ID_NF
	order by VALOR_TOTAL desc 

---------------------------------------------------------------
/*g) Consulte o produto que mais vendeu no geral.*/

Select 
		COD_PROD,
		 SUM (QUANTIDADE) as Produtos_geral 
	from produtos
	group by COD_PROD

---------------------------------------------------------------
/*h) Consulte as NF que foram vendidas mais de 10 unidades de pelo menos um produto.*/

Select 
		ID_NF,
		COD_PROD,
		SUM (QUANTIDADE) as Vendas_uni
	from produtos
	where QUANTIDADE >= 10
	group by ID_NF, COD_PROD

-----------------------------------------------------------------

/* i) Pesquise o valor total das NF, onde esse valor seja maior que 500, 
e ordene o resultado do maior valor para o menor.*/

Select 
		ID_NF,
		SUM (QUANTIDADE * VALOR_UNIT) as Valor_total
	from produtos
	group by ID_NF
	having SUM (QUANTIDADE * VALOR_UNIT) > 500
	order by Valor_total desc 
-- usamos a cl�usula HAVING para filtrar as notas 
-- fiscais com valor total superior a 500 ap�s o agrupamento.

------------------------------------------------------------------------------------
/*j) Qual o valor m�dio dos descontos dados por produto.*/

Select 
		COD_PROD,
		AVG (DESCONTO) as MEDIA    -- AVG -> � usada para calcular as medias dos produtos
	from produtos
	group by COD_PROD

--------------------------------------------------------------------------------------

/*k) Qual o menor, maior e o valor m�dio dos descontos dados por produto.*/

Select 
		COD_PROD,
		MIN (DESCONTO) as MENOS,   -- MIN -> calcular o valor minimo
		MAX (DESCONTO) as MAIOR,   -- MAX -> calcular o valor m�ximo
		AVG (DESCONTO) as MEDIA
	from produtos
	group by COD_PROD

-------------------------------------------------------------------------------------

/*l) Quais as NF que possuem mais de 3 itens vendidos.*/

Select	
		ID_NF,
		SUM (QUANTIDADE) as QTD_ITENS
	from produtos
	group by ID_NF
	having SUM (QUANTIDADE)> 3
----------------------------------------------------------------------------------------

select * from produtos

drop table produtos 