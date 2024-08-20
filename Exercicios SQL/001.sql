
create database Mundo;

use Mundo;

create table Pais (
			 nome varchar(35) primary key not null,
			 continente varchar(35),
			 pop real, 
			 pib real,
			 expec_vida real
);

insert into Pais(nome, continente, pop, pib, expec_vida)
		values('Canada', 'Am. Norte', 30.1, 658, 77.08),
				('Mexico', 'Am. Norte', 107.5, 694, 69.1),
				('Brasil', 'Am. Sul', 183.3, 10004, 65.2),
				('EUA', 'Am. Norte', 270.0, 8003, 75.5);

create table Cidade (
			 nome varchar(35) primary key not null,
			 pais varchar(35),
			 pop real, 
			 capital varchar (1)
);

insert into Cidade(nome, pais, pop, capital)
		values('Washington', 'EUA', 3.3, 'S'),
				('Monterrey', 'Mexico', 2.0, 'N'),
				('Brasilia', 'Brasil', 1.5, 'S'),
				('S�o Paulo', 'Brasil', 15.0, 'N'),
				('Ottawa', 'Canada', 0.8, 'S'),
				('Cid. Mexico', 'Mexico', 14.0, 'S');

create table Rio (
			 nome varchar(35) primary key not null,
			 nascente varchar(35),
			 pais varchar (35),
			 comprimento integer
);

insert into Rio(nome, nascente, pais, comprimento)
		values('St. Lawerence', 'USA', 'USA', 3.3),
				('Grande', 'USA', 'Mexico', 2.0),
				('Parana', 'Brasil', 'Brasil', 1.5),
				('Mississipi', 'USA', 'USA', 15.0);

------------------------------------------------------------------
/*1. Liste todas as cidades e os paises aos quais pertencem*/

select 
		nome, 
		pais
	from cidade
-------------------------------------------------------------------

/*2. Liste todas as cidades que sao capitais.*/

select 
		nome,
		capital
	from cidade 
	where capital = 'S'

--------------------------------------------------------------------
/*3. Liste todos os atributos dos paises onde a expectativa de vida e menor que 70 anos.*/

Select 
		nome,
		continente, 
		pop,
		pib,
		expec_vida
	from Pais
	where expec_vida < 70

/*4. Liste todas as capitais e as populaaoes dos paises cujos PIB e maior que 1 trilhao de dolares.*/

select 
		nome,
		pop,
		pib
	from Pais
	where pib > 1000000000