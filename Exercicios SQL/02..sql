
/* LISTA DE EXERCICIOS SQL - QUESTAO 02*/

create database Universidade;

use Universidade;

create table Alunos (
		MAT int primary key not null,
		nome varchar (60), 
		endereco  varchar (60), 
		cidade varchar (30)
);

insert into Alunos (MAT, nome, endereco, cidade)
		values (2015010101, 'JOSE DE ALENCAR', 'RUA DAS ALMAS', 'NATAL'),
			(2015010102, 'JO�O JOS�', 'AVENIDA RUY CARNEIRO', 'JO�O PESSOA'),
			(2015010103, 'MARIA JOAQUINA', 'RUA CARROSSEL', 'RECIFE'),
			(2015010104, 'MARIA DAS DORES', 'RUA DAS LADEIRAS', 'FORTALEZA'),
			(2015010105, 'JOSU� CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL'),
			(2015010106, 'JOSU�LISSON CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');


create table Disciplinas (
		COD_DISC varchar(20) primary key not null,
		nome_disc varchar (60),
		carga_hor char (60)
);

insert into Disciplinas(COD_DISC, nome_disc, carga_hor)
		values	('BD', 'BANCO DE DADOS', 100),
				('POO', 'PROGRAMA��O COM ACESSO A BANCO DE DADOS', 100),
				('WEB', 'AUTORIA WEB', 50),
				('ENG', 'ENGENHARIA DE SOFTWARE', 80);

create table Professores (
		COD_PROF int primary key not null,
		nome_prof varchar (60),
		ende_prof varchar (60),
		cidade_prof varchar (60)
);


insert into Professores(COD_PROF, nome_prof, ende_prof, cidade_prof)
		values (212131, 'NICKERSON FERREIRA', 'RUA MANA�RA', 'JO�O PESSOA'),
			(122135, 'ADORILSON BEZERRA', 'AVENIDA SALGADO FILHO', 'NATAL'),
			(192011, 'DIEGO OLIVEIRA', 'AVENIDA ROBERTO FREIRE', 'NATAL');

create table Turma (
		COD_DISC varchar(20),
		COD_TURMA int,
		COD_PROF int,
		ANO int,
		horario varchar (30),
    primary key (COD_DISC, COD_TURMA, ANO),
    foreign key (COD_DISC) references Disciplinas (COD_DISC),
    foreign key (COD_PROF) references Professores (COD_PROF)
);

insert into Turma(COD_DISC, COD_TURMA, COD_PROF, ANO, horario)
		values ('BD', 1, 212131, 2015, '11H-12H'),
			('BD', 2, 212131, 2015, '13H-14H'),
			('POO', 1, 192011, 2015, '08H-09H'),
			('WEB', 1, 192011, 2015, '07H-08H'),
			('ENG', 1, 122135, 2015, '10H-11H');

	select * from Turma

create table Historico (
		MAT int,
		COD_DISC varchar(20),
		COD_TURMA int,
		COD_PROF int,
		ANO int,
		frequencia int,
		nota float,
    --primary key (COD_DISC, COD_TURMA, ANO),
    foreign key (MAT) references Alunos (MAT),
    foreign key (COD_DISC, COD_TURMA, ANO) references Turma (COD_DISC, COD_TURMA, ANO),
    foreign key (COD_PROF) references Professores (COD_PROF)
);

insert into Historico(MAT, COD_DISC, COD_TURMA, COD_PROF, ANO, frequencia, nota)
		values(2015010101,'BD', 1, 212131, 2015, 20, 6.0),
			(2015010102,'BD', 2, 212131, 2015, 30, 8.5),
			(2015010103,'POO', 1, 192011, 2015, 15, 4.5),
			(2015010104,'WEB', 1, 192011, 2015, 50, 10.0),
			(2015010105,'ENG', 1, 122135, 2015, 22, 7.5),
			(2015010105, 'BD', 1, 212131, 2015, 10, 3.0),
			(2015010106, 'BD', 1, 212131, 2015,15, 4.5);

-----------------------------------------------------------------------------------------------------------------------------/*
/*a) Encontre a MAT dos alunos com nota em BD em 2015 menor que 5 (obs: BD = c�digo da disciplinas).*/

select 
		MAT, 
		COD_DISC,
		ANO
	from Historico
	Where COD_DISC = 'BD' and nota < 5 


/*b) Encontre a MAT e calcule a m�dia das notas dos alunos na disciplina de POO em 2015.*/

select 
		MAT, 
		AVG (nota) as M�dia,
		COD_DISC,
		ANO
	from Historico
	Where COD_DISC = 'POO' 
	Group by MAT, COD_DISC, ANO


/*c) Encontre a MAT e calcule a m�dia das notas dos alunos na disciplina de POO em 2015 e que esta m�dia seja superior a 6.*/
select 
		MAT, 
		AVG (nota) as M�dia,
		COD_DISC,
		ANO
	from Historico
	Where COD_DISC = 'POO' 
	and nota > 6 
	Group by MAT, COD_DISC, ANO

/*d) Encontre quantos alunos n�o s�o de Natal.*/

Select 
		nome,
		endereco,
		cidade
	from Alunos
	where not cidade = 'Natal'

USE Universidade; -- Substitua pelo nome do seu banco de dados
SELECT name FROM sys.tables;

