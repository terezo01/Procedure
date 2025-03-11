create database exercicio

use exercicio

create table personagens(
	id int primary key identity (1,1),
	nome varchar(30) not null,
	tipoPersonagem varchar(15) not null
)

create table itens(
	id int primary key identity (1,1),
	nomeItem varchar(25) not null,
	dano int not null
)

create table personagem_item(
	id int primary key identity (1,1),
	idPersonagem int not null,
	idItem int not null,
	constraint fk_personagemItem_personagem foreign key (idPersonagem)
	references personagens(id),
	constraint fk_personagemItem_item foreign key (idItem)
	references itens(id),
)

create procedure inserirPersonagem
@nome varchar(30),
@tipoPersonagem varchar(15)
as
insert into personagens(nome, tipoPersonagem)
values(@nome, @tipoPersonagem)
select id, nome, tipoPersonagem from personagens


create procedure inserirItem
@nomeItem varchar(25),
@dano int
as
insert into itens(nomeItem, dano)
values(@nomeItem, @dano)
select id, nomeItem, dano from itens


create procedure inserirPersonagemItem
@idPersonagem int,
@idItem int
as
insert into personagem_item
values(@idPersonagem, @idItem)
select idPersonagem, idItem  from personagem_item


exec inserirPersonagem 'oslavo', 'barbaro'

exec inserirItem 'tambor escuro', 100

exec inserirPersonagemItem 3, 4

create procedure todosPersonagensItens
as
select personagens.nome, itens.nomeItem, itens.dano from personagem_item
inner join personagens on personagem_item.idPersonagem = personagens.id
inner join itens on personagem_item.idItem = itens.id


create procedure PersonagemItens
@idPersonagem int
as
select personagens.nome, itens.nomeItem, itens.dano from personagem_item
inner join personagens on personagem_item.idPersonagem = personagens.id
inner join itens on personagem_item.idItem = itens.id
where personagens.id = @idPersonagem


create procedure itemPersonagens
@idItem int
as
select personagens.nome, itens.nomeItem, itens.dano from personagem_item
inner join personagens on personagem_item.idPersonagem = personagens.id
inner join itens on personagem_item.idItem = itens.id
where itens.id = @idItem

exec todosPersonagensItens

exec PersonagemItens 1

exec itemPersonagens 3
