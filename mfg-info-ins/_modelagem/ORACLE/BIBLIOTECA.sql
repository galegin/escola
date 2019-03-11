/*
Created		1/5/2008
Modified		7/11/2008
Project		Biblioteca
Model		Bli
Company		Escola Estadual Cianorte
Author		Miguel Franco Galego
Version		1.0
Database		Oracle 10g 
*/



































Drop index "AK_BARRA"
/





Drop table "GER_TPENSINO"
/
Drop table "GER_LOCACAO"
/
Drop table "GER_LOCADOR"
/
Drop table "GER_CURSO"
/
Drop table "GER_INDLIVRO"
/
Drop table "GER_EDITORA"
/
Drop table "GER_GENERO"
/
Drop table "GER_LIVRO"
/


-- Create Types section





-- Create Tables section


Create table "GER_LIVRO" (
	"CD_LIVRO" Number NOT NULL ,
	"TP_SITUACAO" Number Default 1 NOT NULL ,
	"CD_CURSO" Number NOT NULL ,
	"CD_EDITORA" Number NOT NULL ,
	"CD_GENERO" Number NOT NULL ,
	"DS_TITULO" Varchar2(60) NOT NULL ,
	"DS_AUTOR" Varchar2(60),
	"NR_VOLUME" Number Default 1 NOT NULL ,
	"NR_VOLUMEDE" Number Default 1 NOT NULL ,
	"NR_CORREDOR" Varchar2(20),
	"NR_PRATELEIRA" Varchar2(20),
	"NR_ANDAR" Varchar2(20),
	"QT_EXEMPLAR" Number Default 1 NOT NULL ,
	"DT_AQUISICAO" Date,
	"DS_ORIGEM" Varchar2(60),
	"DS_COMPLEMENTO" Varchar2(60),
	"DS_FORMA" Varchar2(60),
	"DS_CIDADE" Varchar2(40),
	"NR_ANO" Number,
	"DS_BARRA" Varchar2(20),
	"TP_ENSINO" Number,
primary key ("CD_LIVRO") 
) 
/

Create table "GER_GENERO" (
	"CD_GENERO" Number NOT NULL ,
	"TP_SITUACAO" Number Default 1 NOT NULL ,
	"DS_GENERO" Varchar2(60) NOT NULL ,
primary key ("CD_GENERO") 
) 
/

Create table "GER_EDITORA" (
	"CD_EDITORA" Number NOT NULL ,
	"TP_SITUACAO" Number Default 1 NOT NULL ,
	"DS_EDITORA" Varchar2(60) NOT NULL ,
primary key ("CD_EDITORA") 
) 
/

Create table "GER_INDLIVRO" (
	"CD_LIVRO" Number NOT NULL ,
	"NR_INDICE" Varchar2(20) NOT NULL ,
	"TP_SITUACAO" Number Default 1 NOT NULL ,
	"DS_INDICE" Varchar2(60) NOT NULL ,
	"NR_PAGINA" Number NOT NULL ,
primary key ("CD_LIVRO","NR_INDICE") 
) 
/

Create table "GER_CURSO" (
	"CD_CURSO" Number NOT NULL ,
	"TP_SITUACAO" Number Default 1 NOT NULL ,
	"DS_CURSO" Varchar2(60) NOT NULL ,
primary key ("CD_CURSO") 
) 
/

Create table "GER_LOCADOR" (
	"CD_LOCADOR" Number NOT NULL ,
	"TP_SITUACAO" Number Default 1 NOT NULL ,
	"CD_CURSO" Number NOT NULL ,
	"NM_LOCADOR" Varchar2(60) NOT NULL ,
	"TP_LOCADOR" Number Default 1 NOT NULL ,
	"CD_SERE" Varchar2(20),
	"NR_ANO" Varchar2(20),
	"CD_TURMA" Varchar2(20),
	"DT_NASC" Date,
	"TP_ENSINO" Number,
primary key ("CD_LOCADOR") 
) 
/

Create table "GER_LOCACAO" (
	"CD_LOCACAO" Number NOT NULL ,
	"TP_SITUACAO" Number Default 1 NOT NULL ,
	"CD_LIVRO" Number NOT NULL ,
	"CD_LOCADOR" Number NOT NULL ,
	"DT_LOCACAO" Date NOT NULL ,
	"TP_LOCACAO" Number NOT NULL ,
	"DT_DEVOLUCAO" Date,
	"DT_DEVOLVIDO" Date,
	"VL_MULTA" Decimal(15,2) Default 0 NOT NULL ,
	"DT_PAGOMULTA" Date,
primary key ("CD_LOCACAO") 
) 
/

Create table "GER_TPENSINO" (
	"TP_ENSINO" Number NOT NULL ,
	"TP_SITUACAO" Float Default 1 NOT NULL ,
	"DS_ENSINO" Varchar2(40) NOT NULL ,
primary key ("TP_ENSINO") 
) 
/





-- Create Alternate keys section


-- Create Indexes section

Create Index "AK_BARRA" ON "GER_LIVRO" ("DS_BARRA") 
/


-- Create Foreign keys section
Alter table "GER_INDLIVRO" add  foreign key ("CD_LIVRO") references "GER_LIVRO" ("CD_LIVRO") 
/
Alter table "GER_LOCACAO" add  foreign key ("CD_LIVRO") references "GER_LIVRO" ("CD_LIVRO") 
/
Alter table "GER_LIVRO" add  foreign key ("CD_GENERO") references "GER_GENERO" ("CD_GENERO") 
/
Alter table "GER_LIVRO" add  foreign key ("CD_EDITORA") references "GER_EDITORA" ("CD_EDITORA") 
/
Alter table "GER_LIVRO" add  foreign key ("CD_CURSO") references "GER_CURSO" ("CD_CURSO") 
/
Alter table "GER_LOCADOR" add  foreign key ("CD_CURSO") references "GER_CURSO" ("CD_CURSO") 
/
Alter table "GER_LOCACAO" add  foreign key ("CD_LOCADOR") references "GER_LOCADOR" ("CD_LOCADOR") 
/


-- Create Object Tables section



-- Create XMLType Tables section



-- Create Procedures section



-- Create Views section



-- Create Sequences section




-- Create Triggers from referential integrity section
























-- Create user Triggers section



-- Create Packages section





-- Create Synonyms section



-- Create Roles section



-- Users Permissions to roles section



-- Roles Permissions section

/* Roles permissions */




-- User Permissions section

/* Users permissions */




-- Create Table comments section


-- Create Attribute comments section


-- After section


