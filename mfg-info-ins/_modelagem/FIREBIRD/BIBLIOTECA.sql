/*
Created		1/5/2008
Modified		2/10/2008
Project		Biblioteca
Model			Bli
Company		Escola Estadual Cianorte
Author		Miguel Franco Galego
Version		1.0
Database		Interbase 6 SQL 3 
*/


















Drop Index "AK_BARRA";




Drop Table "GER_TPENSINO";
Drop Table "GER_LOCACAO";
Drop Table "GER_LOCADOR";
Drop Table "GER_CURSO";
Drop Table "GER_INDLIVRO";
Drop Table "GER_EDITORA";
Drop Table "GER_GENERO";
Drop Table "GER_LIVRO";










Create Table "GER_LIVRO"  (
	"CD_LIVRO" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"CD_CURSO" Integer NOT NULL,
	"CD_EDITORA" Integer NOT NULL,
	"CD_GENERO" Integer NOT NULL,
	"DS_TITULO" Varchar(60) NOT NULL,
	"DS_AUTOR" Varchar(60),
	"NR_VOLUME" Integer Default 1 NOT NULL,
	"NR_VOLUMEDE" Integer Default 1 NOT NULL,
	"NR_CORREDOR" Varchar(20),
	"NR_PRATELEIRA" Varchar(20),
	"NR_ANDAR" Varchar(20),
	"QT_EXEMPLAR" Integer Default 1 NOT NULL,
	"DT_AQUISICAO" Date,
	"DS_ORIGEM" Varchar(60),
	"DS_COMPLEMENTO" Varchar(60),
	"DS_FORMA" Varchar(60),
	"DS_CIDADE" Varchar(40),
	"NR_ANO" Integer,
	"DS_BARRA" Varchar(20),
	"TP_ENSINO" Integer,
 Primary Key ("CD_LIVRO")
);

Create Table "GER_GENERO"  (
	"CD_GENERO" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_GENERO" Varchar(60) NOT NULL,
 Primary Key ("CD_GENERO")
);

Create Table "GER_EDITORA"  (
	"CD_EDITORA" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_EDITORA" Varchar(60) NOT NULL,
 Primary Key ("CD_EDITORA")
);

Create Table "GER_INDLIVRO"  (
	"CD_LIVRO" Integer NOT NULL,
	"NR_INDICE" Varchar(20) NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_INDICE" Varchar(60) NOT NULL,
	"NR_PAGINA" Integer NOT NULL,
 Primary Key ("CD_LIVRO","NR_INDICE")
);

Create Table "GER_CURSO"  (
	"CD_CURSO" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_CURSO" Varchar(60) NOT NULL,
 Primary Key ("CD_CURSO")
);

Create Table "GER_LOCADOR"  (
	"CD_LOCADOR" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"CD_CURSO" Integer NOT NULL,
	"NM_LOCADOR" Varchar(60) NOT NULL,
	"TP_LOCADOR" Integer Default 1 NOT NULL,
	"CD_SERE" Varchar(20),
	"NR_ANO" Varchar(20),
	"CD_TURMA" Varchar(20),
	"DT_NASC" Date,
	"TP_ENSINO" Integer,
 Primary Key ("CD_LOCADOR")
);

Create Table "GER_LOCACAO"  (
	"CD_LOCACAO" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"CD_LIVRO" Integer NOT NULL,
	"CD_LOCADOR" Integer NOT NULL,
	"DT_LOCACAO" Date NOT NULL,
	"TP_LOCACAO" Integer NOT NULL,
	"DT_DEVOLUCAO" Date,
	"DT_DEVOLVIDO" Date,
	"VL_MULTA" Numeric(15,2) Default 0 NOT NULL,
	"DT_PAGOMULTA" Date,
 Primary Key ("CD_LOCACAO")
);

Create Table "GER_TPENSINO"  (
	"TP_ENSINO" Integer NOT NULL,
	"TP_SITUACAO" Float Default 1 NOT NULL,
	"DS_ENSINO" Varchar(40) NOT NULL,
 Primary Key ("TP_ENSINO")
);









Create Index "AK_BARRA"  ON "GER_LIVRO" ("DS_BARRA");


Alter Table "GER_INDLIVRO" add Foreign Key ("CD_LIVRO") references "GER_LIVRO" ("CD_LIVRO") on update no action on delete no action;
Alter Table "GER_LOCACAO" add Foreign Key ("CD_LIVRO") references "GER_LIVRO" ("CD_LIVRO") on update no action on delete no action;
Alter Table "GER_LIVRO" add Foreign Key ("CD_GENERO") references "GER_GENERO" ("CD_GENERO") on update no action on delete no action;
Alter Table "GER_LIVRO" add Foreign Key ("CD_EDITORA") references "GER_EDITORA" ("CD_EDITORA") on update no action on delete no action;
Alter Table "GER_LIVRO" add Foreign Key ("CD_CURSO") references "GER_CURSO" ("CD_CURSO") on update no action on delete no action;
Alter Table "GER_LOCADOR" add Foreign Key ("CD_CURSO") references "GER_CURSO" ("CD_CURSO") on update no action on delete no action;
Alter Table "GER_LOCACAO" add Foreign Key ("CD_LOCADOR") references "GER_LOCADOR" ("CD_LOCADOR") on update no action on delete no action;


Create Exception "except_del_p" 'Children still exist in child table. Cannot delete parent.';
Create Exception "except_ins_ch" 'Parent does not exist. Cannot create child.';
Create Exception "except_upd_ch" 'Parent does not exist. Cannot update child.';
Create Exception "except_upd_p" 'Children still exist in child table. Cannot update parent.';
Create Exception "except_ins_ch_card" 'Maximum cardinality exceeded. Cannot insert into child.';
Create Exception "except_upd_ch_card" 'Maximum cardinality exceeded. Cannot update child.';




set term ^;












set term ;^







/* Roles permissions */





/* Users permissions */










