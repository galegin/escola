/*
Created		1/5/2008
Modified		7/11/2008
Project		Geral
Model		Ger
Company		MFG-Info
Author		Miguel Franco Galego
Version		1.0
Database		Oracle 10g 
*/






































Drop table "SIS_COMPONENTE"
/
Drop table "SIS_MODELO"
/
Drop table "OBS_ENTIDADE"
/
Drop table "ADM_NIVEL"
/
Drop table "LOG_ENTIDADE"
/
Drop table "ADM_PARAM"
/
Drop table "ADM_USUARIO"
/


-- Create Types section





-- Create Tables section


Create table "ADM_USUARIO" (
	"NM_LOGIN" Varchar2(20) NOT NULL ,
	"TP_SITUACAO" Number Default 1 NOT NULL ,
	"NM_USUARIO" Varchar2(60) NOT NULL ,
	"TP_PRIVILEGIO" Number Default 3 NOT NULL ,
	"CD_SENHA" Varchar2(20) Default '123MUDAR' NOT NULL ,
primary key ("NM_LOGIN") 
) 
/

Create table "ADM_PARAM" (
	"CD_PARAMETRO" Varchar2(20) NOT NULL ,
	"TP_SITUACAO" Number Default 1 NOT NULL ,
	"NM_PARAMETRO" Varchar2(60) NOT NULL ,
	"TP_PARAMETRO" Number NOT NULL ,
	"VL_PARAMETRO" Varchar2(100),
primary key ("CD_PARAMETRO") 
) 
/

Create table "LOG_ENTIDADE" (
	"CD_ENTIDADE" Varchar2(20) NOT NULL ,
	"CD_CHAVE" Varchar2(60) NOT NULL ,
	"DT_LOG" Date NOT NULL ,
	"NR_SEQ" Number NOT NULL ,
	"TP_SITUACAO" Number Default 1 NOT NULL ,
	"DS_LOG" Varchar2(1000) NOT NULL ,
	"HR_LOG" Varchar2(20),
	"NM_LOGIN" Varchar2(20),
primary key ("CD_ENTIDADE","CD_CHAVE","DT_LOG","NR_SEQ") 
) 
/

Create table "ADM_NIVEL" (
	"NM_LOGIN" Varchar2(20) NOT NULL ,
	"CD_ENTIDADE" Varchar2(20) NOT NULL ,
	"TP_SITUACAO" Number Default 1 NOT NULL ,
	"IN_INCLUIR" Char(1) Default 'F' NOT NULL ,
	"IN_ALTERAR" Char(1) Default 'F' NOT NULL ,
	"IN_EXCLUIR" Char(1) Default 'F' NOT NULL ,
	"IN_IMPRIMIR" Char(1) Default 'F' NOT NULL ,
primary key ("NM_LOGIN","CD_ENTIDADE") 
) 
/

Create table "OBS_ENTIDADE" (
	"CD_ENTIDADE" Varchar2(20) NOT NULL ,
	"CD_CHAVE" Varchar2(60) NOT NULL ,
	"NR_LINHA" Number NOT NULL ,
	"DS_LINHA" Varchar2(100),
primary key ("CD_ENTIDADE","CD_CHAVE","NR_LINHA") 
) 
/

Create table "SIS_MODELO" (
	"CD_MODELO" Varchar2(20) NOT NULL ,
	"TP_SITUACAO" Number Default 1,
	"DS_MODELO" Varchar2(40) NOT NULL ,
	"CD_MODELOPAI" Varchar2(20),
primary key ("CD_MODELO") 
) 
/

Create table "SIS_COMPONENTE" (
	"CD_COMPONENTE" Varchar2(20) NOT NULL ,
	"TP_SITUACAO" Number Default 1,
	"CD_MODELO" Varchar2(20) NOT NULL ,
	"DS_COMPONENTE" Varchar2(60) NOT NULL ,
	"TP_COMPONENTE" Number NOT NULL ,
	"DS_SQL" Varchar2(100) NOT NULL ,
	"IN_MENU" Char(1) NOT NULL ,
	"IN_PREVIEW" Char(1) NOT NULL ,
primary key ("CD_COMPONENTE") 
) 
/





-- Create Alternate keys section


-- Create Indexes section



-- Create Foreign keys section
Alter table "ADM_NIVEL" add  foreign key ("NM_LOGIN") references "ADM_USUARIO" ("NM_LOGIN") 
/
Alter table "SIS_COMPONENTE" add  foreign key ("CD_MODELO") references "SIS_MODELO" ("CD_MODELO") 
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


