create database escola;

use escola;

create table aluno (
		ra int primary key not null,
		nome varchar(20) not null,
		nacimento varchar (30) not null
);

insert into aluno(ra, nome, nacimento)
	values   (123456, 'Ana', '1972-01-10'),
			(123457, 'Bianca', '1973-02-11'),
			(123458, 'Carla', '1987-12-12'),
			(123459, 'Danilo', '1990-10-02'),
			(123460, 'Elaine', '1987-01-01');

drop table aluno

create table curso (
		codigo int primary key not null,
		nome varchar(30) not null,
		ch numeric, 
		inicio varchar (60), 
		termino varchar (60)
);

insert into curso (codigo, nome, ch, inicio, termino)
		values  (1, 'Java', 360, '2007-12-01', '2008-10-10'),
				(2, 'auto cad', 60, '2008-01-10', '2008-05-10'),
				(3, 'php', 90, '2008-02-15', '2008-07-10'),
				(4, 'redes', 60, '2008-01-20', '2008-03-20');

create table matricula (
		curso int, 
		ra int,
		data date,
		valor decimal (5,2),
		foreign key (curso) references curso (codigo),
		foreign key (ra) references aluno (ra)
);

insert into matricula(curso, ra, data, valor)
		values  (1, 123456, '2007-09-10', 100.00),
				(3, 123456, '2007-10-01', 60.00),
				(1, 123457, '2007-09-01', 100.00),
				(2, 123458, '2008-01-11', 50.00),
				(2, 123459, '2007-07-20', 50.00),
				(1, 123460, '2007-08-10', 80.00);

---------------------------------------------------------------------------

/*1. Listar RA, nome do aluno e nome do curso em que o aluno est� matriculado.*/

select 
		al.ra,
		al.nome,
		mt.curso,
		c.nome
from matricula as mt
join aluno as al
on mt.ra = al.ra
join curso as c
on c.codigo = mt.curso

/*2. Listar RA, nome do aluno e nome do curso em que o aluno est� matriculado, ordenado
por nome do curso.*/

select 
		al.ra,
		al.nome,
		mt.curso,
		c.nome
from matricula as mt
join aluno as al
on mt.ra = al.ra
join curso as c
on c.codigo = mt.curso
order by c.nome

/*3.Exibir o nome de cada curso que teve matriculas e quantos alunos tem matriculados em
cada um deles (Obs. Usar apelido para o campo do n�mero de alunos).*/

select 
		c.nome,
		COUNT(al.nome) as quant_aluno
	from matricula as mt
join curso as c 
on c.codigo = mt.curso
join aluno as al
on al.ra = mt.ra
group by c.nome

/*4.Exibir o nome de todos os cursos e quantos alunos tem matriculados em cada um (Obs.
Caso algum curso nao tenha matriculas, exibir numero de alunos =0).*/

select 
		c.nome,
		COUNT(al.nome) as quant_aluno
	from matricula as mt
join curso as c 
on c.codigo = mt.curso
join aluno as al
on al.ra = mt.ra
group by c.nome

/*5. Exibir o nome do curso e o valor total recebido das matriculas em cada um deles*/

select 
		c.nome,
		Sum(mt.valor) as valor_total
	from matricula as mt
join curso as c 
on c.codigo = mt.curso
group by c.nome

/*6. Exibir o nome do curso, o valor total recebido das matriculas em cada um deles e o total
arrecadado em matr�culas pela escola.*/

select 
		c.nome,
		 concat('R$ ', Sum (mt.valor)) as valor_total
	from matricula as mt
join curso as c 
on c.codigo = mt.curso
group by c.nome

select 
		CONCAT('R$ ', sum(valor)) as valor_total
	from matricula;

/*7. Exibir o valor medio pago em matracula na escola. Chamar a coluna que exibira a media
de valor medio e seu conteudo deve ser exibido com 2 casas decimais*/ -- funcao ROUND para arredendar

select 
	ROUND(AVG(Valor),2) as valor_medio -- essa funcao aredonda o valor
	from matricula

/*8. Exibir o nome e o valor medio de matricula de cada curso. Chamar a coluna que exibira a
media de valor medio e seu conteudo exibido com 2 casas decimais*/ -- funcao ROUND para arredendar

select 
		c.nome,
		ROUND(AVG(Valor),2) as valor_medio
	from matricula as mt
join curso as c 
on c.codigo = mt.curso
group by c.nome

/*9. Exibir nome dos cursos que nao sao VIP ( ou seja que tenha pelo menos 2 alunos) e a
quantidade de alunos matriculados em cada um deles.*/

select 
		c.nome as nome_do_curso,
		COUNT(mt.curso) as quantidade_de_alunos
	from matricula as mt
JOIN curso as c on c.codigo = mt.curso
group by c.nome
having COUNT(mt.curso) >= 2;

/*10 Exiba o nome dos cursos com mesma carga horaria do curso de auto cad.*/

select 
		nome,
		ch
	from curso
where ch = '60' and nome <> 'auto cad'
-- or
select 
		nome,
		ch
	from curso
where ch = (select ch from curso
where nome = 'auto cad') and nome <> 'auto cad'

/*11. Exiba nome de todos os alunos que fazem aniversario no mesmo mes que Ana.*/ -- Funcao MONTH para puxar o mes do ano

select nome,
		MONTH(nacimento)
	from aluno
where nome = 'Ana'
-- or
select 
		nome,
		nacimento
	from aluno
where MONTH(nacimento) = (select MONTH(nacimento) from aluno
where nome = 'Ana') and nome <> 'Ana'

/*12 Exiba todos os cursos com inicio em janeiro de 2008 que tenham alunos matriculados.*/

select 
		c.nome,
		 DATE_FORMAT(c.inicio, '%m/%Y') as inicio,
		COUNT(m.curso) as quant_matricula
	from curso as c
right join matricula as m on m.curso = c.codigo
where  DATE_FORMAT(c.inicio, '%m/%Y') ='2008-01'
group by c.nome

/*13 Exiba todos os cursos com inicio em janeiro de 2008 independente de ter alunos
matriculados ou nao.*/

select 
		c.nome,
		 DATE_FORMAT(c.inicio, '%m/%Y') as inicio
	from curso as c
right join matricula as m on m.curso = c.codigo
where  DATE_FORMAT(c.inicio, '%m/%Y') ='2008-01'
group by c.nome