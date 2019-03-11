/*
Created		1/5/2008
Modified		10/10/2008
Project		Geral
Model			Ger
Company		MFG-Info
Author		Miguel Franco Galego
Version		1.0
Database		Interbase 6 SQL 3 
*/






















Drop Table "SIS_COMPONENTE";
Drop Table "SIS_MODELO";
Drop Table "OBS_ENTIDADE";
Drop Table "ADM_NIVEL";
Drop Table "LOG_ENTIDADE";
Drop Table "ADM_PARAM";
Drop Table "ADM_USUARIO";










Create Table "ADM_USUARIO"  (
	"NM_LOGIN" Varchar(20) NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"NM_USUARIO" Varchar(60) NOT NULL,
	"TP_PRIVILEGIO" Integer Default 3 NOT NULL,
	"CD_SENHA" Varchar(20) Default '123MUDAR' NOT NULL,
 Primary Key ("NM_LOGIN")
);

Create Table "ADM_PARAM"  (
	"CD_PARAMETRO" Varchar(20) NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"NM_PARAMETRO" Varchar(60) NOT NULL,
	"TP_PARAMETRO" Integer NOT NULL,
	"VL_PARAMETRO" Varchar(100),
 Primary Key ("CD_PARAMETRO")
);

Create Table "LOG_ENTIDADE"  (
	"CD_ENTIDADE" Varchar(20) NOT NULL,
	"CD_CHAVE" Varchar(60) NOT NULL,
	"DT_LOG" Date NOT NULL,
	"NR_SEQ" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_LOG" Varchar(1000) NOT NULL,
	"HR_LOG" Time,
	"NM_LOGIN" Varchar(20),
 Primary Key ("CD_ENTIDADE","CD_CHAVE","DT_LOG","NR_SEQ")
);

Create Table "ADM_NIVEL"  (
	"NM_LOGIN" Varchar(20) NOT NULL,
	"CD_ENTIDADE" Varchar(20) NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"IN_INCLUIR" Char(1) Default 'F' NOT NULL,
	"IN_ALTERAR" Char(1) Default 'F' NOT NULL,
	"IN_EXCLUIR" Char(1) Default 'F' NOT NULL,
	"IN_IMPRIMIR" Char(1) Default 'F' NOT NULL,
 Primary Key ("NM_LOGIN","CD_ENTIDADE")
);

Create Table "OBS_ENTIDADE"  (
	"CD_ENTIDADE" Varchar(20) NOT NULL,
	"CD_CHAVE" Varchar(60) NOT NULL,
	"NR_LINHA" Integer NOT NULL,
	"DS_LINHA" Varchar(100),
 Primary Key ("CD_ENTIDADE","CD_CHAVE","NR_LINHA")
);

Create Table "SIS_MODELO"  (
	"CD_MODELO" Varchar(20) NOT NULL,
	"DS_MODELO" Varchar(40) NOT NULL,
	"CD_MODELOPAI" Varchar(20) NOT NULL,
 Primary Key ("CD_MODELO")
);

Create Table "SIS_COMPONENTE"  (
	"CD_COMPONENTE" Varchar(20) NOT NULL,
	"CD_MODELO" Varchar(20) NOT NULL,
	"DS_COMPONENTE" Varchar(60) NOT NULL,
	"TP_COMPONENTE" Integer NOT NULL,
	"DS_SQL" Varchar(100) NOT NULL,
	"IN_MENU" Char(1) NOT NULL,
	"IN_PREVIEW" Char(1) NOT NULL,
 Primary Key ("CD_COMPONENTE","CD_MODELO")
);











Alter Table "ADM_NIVEL" add Foreign Key ("NM_LOGIN") references "ADM_USUARIO" ("NM_LOGIN") on update no action on delete no action;
Alter Table "SIS_COMPONENTE" add Foreign Key ("CD_MODELO") references "SIS_MODELO" ("CD_MODELO") on update no action on delete no action;


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










