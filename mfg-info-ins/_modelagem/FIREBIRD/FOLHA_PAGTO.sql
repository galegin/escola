/*
Created		8/8/2008
Modified		9/8/2008
Project		
Model			
Company		
Author		
Version		
Database		Interbase 6 SQL 3 
*/


















Drop Index "AK_REF";




Drop Table "GER_FUNHIS";
Drop Table "GER_SECAO";
Drop Table "GER_SETOR";
Drop Table "GER_DEPTO";
Drop Table "GER_LOCAL";
Drop Table "GER_FUNCAO";
Drop Table "GER_EMPRESA";
Drop Table "GER_LANCTO";
Drop Table "GER_FUNCIONARIO";
Drop Table "GER_HISTORICO";










Create Table "GER_HISTORICO"  (
	"CD_HISTORICO" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_HISTORICO" Varchar(40) NOT NULL,
	"TP_OPERACAO" Integer NOT NULL,
	"PR_HISTORICO" Numeric(3,2),
	"VL_HISTORICO" Numeric(15,2),
	"TP_HISTORICO" Integer NOT NULL,
 Primary Key ("CD_HISTORICO")
);

Create Table "GER_FUNCIONARIO"  (
	"CD_FUNCIONARIO" Integer NOT NULL,
	"TP_SITUACAO" Integer NOT NULL,
	"NM_FUNCIONARIO" Varchar(40) NOT NULL,
	"DS_ENDERECO" Varchar(40) NOT NULL,
	"DS_BAIRRO" Varchar(40),
	"DS_CIDADE" Varchar(40) NOT NULL,
	"DS_UF" Varchar(2) NOT NULL,
	"DS_FONE" Varchar(20),
	"DS_CEP" Varchar(10) NOT NULL,
	"VL_RENDA" Numeric(15,2) NOT NULL,
	"DT_NASCTO" Date,
	"DT_ADMISSAO" Char(20),
	"DT_DEMISSAO" Char(20),
	"CD_FUNCAO" Integer NOT NULL,
	"CD_EMPRESA" Integer NOT NULL,
	"CD_LOCAL" Integer NOT NULL,
	"CD_DEPTO" Integer NOT NULL,
	"CD_SETOR" Integer NOT NULL,
	"CD_SECAO" Integer NOT NULL,
 Primary Key ("CD_FUNCIONARIO")
);

Create Table "GER_LANCTO"  (
	"CD_FUNCIONARIO" Integer NOT NULL,
	"DS_REF" Varchar(7) NOT NULL,
	"CD_HISTORICO" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DT_LANCTO" Date NOT NULL,
	"PR_HISTORICO" Numeric(3,2),
	"VL_ENTRADA" Numeric(15,2),
	"VL_SAIDA" Numeric(15,2),
 Primary Key ("CD_FUNCIONARIO","DS_REF","CD_HISTORICO")
);

Create Table "GER_EMPRESA"  (
	"CD_EMPRESA" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"NM_EMPRESA" Varchar(40) NOT NULL,
	"NR_CNPJ" Varchar(14) NOT NULL,
 Primary Key ("CD_EMPRESA")
);

Create Table "GER_FUNCAO"  (
	"CD_FUNCAO" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_FUNCAO" Varchar(40) NOT NULL,
	"NR_CBO" Varchar(10),
 Primary Key ("CD_FUNCAO")
);

Create Table "GER_LOCAL"  (
	"CD_LOCAL" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_LOCAL" Varchar(40) NOT NULL,
 Primary Key ("CD_LOCAL")
);

Create Table "GER_DEPTO"  (
	"CD_DEPTO" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_DEPTO" Varchar(40) NOT NULL,
 Primary Key ("CD_DEPTO")
);

Create Table "GER_SETOR"  (
	"CD_SETOR" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_SETOR" Varchar(40) NOT NULL,
 Primary Key ("CD_SETOR")
);

Create Table "GER_SECAO"  (
	"CD_SECAO" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_SECAO" Varchar(40) NOT NULL,
 Primary Key ("CD_SECAO")
);

Create Table "GER_FUNHIS"  (
	"CD_FUNCIONARIO" Integer NOT NULL,
	"CD_HISTORICO" Integer NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
 Primary Key ("CD_FUNCIONARIO","CD_HISTORICO")
);









Create Index "AK_REF"  ON "GER_LANCTO" ("DS_REF","CD_FUNCIONARIO");


Alter Table "GER_LANCTO" add Foreign Key ("CD_HISTORICO") references "GER_HISTORICO" ("CD_HISTORICO") on update no action on delete no action;
Alter Table "GER_FUNHIS" add Foreign Key ("CD_HISTORICO") references "GER_HISTORICO" ("CD_HISTORICO") on update no action on delete no action;
Alter Table "GER_LANCTO" add Foreign Key ("CD_FUNCIONARIO") references "GER_FUNCIONARIO" ("CD_FUNCIONARIO") on update no action on delete no action;
Alter Table "GER_FUNHIS" add Foreign Key ("CD_FUNCIONARIO") references "GER_FUNCIONARIO" ("CD_FUNCIONARIO") on update no action on delete no action;
Alter Table "GER_FUNCIONARIO" add Foreign Key ("CD_EMPRESA") references "GER_EMPRESA" ("CD_EMPRESA") on update no action on delete no action;
Alter Table "GER_FUNCIONARIO" add Foreign Key ("CD_FUNCAO") references "GER_FUNCAO" ("CD_FUNCAO") on update no action on delete no action;
Alter Table "GER_FUNCIONARIO" add Foreign Key ("CD_LOCAL") references "GER_LOCAL" ("CD_LOCAL") on update no action on delete no action;
Alter Table "GER_FUNCIONARIO" add Foreign Key ("CD_DEPTO") references "GER_DEPTO" ("CD_DEPTO") on update no action on delete no action;
Alter Table "GER_FUNCIONARIO" add Foreign Key ("CD_SETOR") references "GER_SETOR" ("CD_SETOR") on update no action on delete no action;
Alter Table "GER_FUNCIONARIO" add Foreign Key ("CD_SECAO") references "GER_SECAO" ("CD_SECAO") on update no action on delete no action;


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










