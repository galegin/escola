/*
Created		22/5/2008
Modified		7/6/2008
Project		
Model			
Company		
Author		
Version		
Database		Interbase 6 SQL 3 
*/






















Drop Table "RECEITA";
Drop Table "CLIENTE";
Drop Table "DESPESA";
Drop Table "CONTAS_PAG";
Drop Table "FORNECEDOR";
Drop Table "USUARIO";
Drop Table "CONTAS_REC";
Drop Table "CIDADE";










Create Table "CIDADE"  (
	"CODCID" Integer NOT NULL,
	"NOME" Varchar(20) NOT NULL,
	"ESTADO" Char(2) NOT NULL,
 Primary Key ("CODCID")
);

Create Table "CONTAS_REC"  (
	"CODREC" Integer NOT NULL,
	"CODPARCELA" Integer NOT NULL,
	"CODRECE" Integer NOT NULL,
	"CODCLI" Integer,
	"TIPODOCUMENTO" Integer NOT NULL,
	"DOCUMENTO" Varchar(10),
	"EMISSAO" Date NOT NULL,
	"VENCTO" Date NOT NULL,
	"VALOR" Numeric(15,2) NOT NULL,
	"PAGTO" Date,
	"VALORPAGO" Numeric(15,2),
	"TIPOBAIXA" Integer Default 0 NOT NULL,
 Primary Key ("CODREC","CODPARCELA")
);

Create Table "USUARIO"  (
	"USUARIO" Varchar(20) NOT NULL,
	"SENHA" Varchar(20) NOT NULL,
	"PRIVILEGIO" Integer NOT NULL,
 Primary Key ("USUARIO")
);

Create Table "FORNECEDOR"  (
	"CODFOR" Integer NOT NULL,
	"NOME" Varchar(60) NOT NULL,
	"ENDERECO" Varchar(40),
	"BAIRRO" Varchar(40),
	"CODCID" Integer NOT NULL,
	"CEP" Char(8),
	"FONE" Varchar(20),
	"CPF" Char(11),
	"OBS" Varchar(100),
 Primary Key ("CODFOR")
);

Create Table "CONTAS_PAG"  (
	"CODPAG" Integer NOT NULL,
	"CODPARCELA" Integer NOT NULL,
	"CODDESP" Integer NOT NULL,
	"CODFOR" Integer,
	"TIPODOCUMENTO" Integer NOT NULL,
	"DOCUMENTO" Varchar(10),
	"EMISSAO" Date NOT NULL,
	"VENCTO" Date NOT NULL,
	"VALOR" Numeric(15,2) NOT NULL,
	"PAGTO" Date,
	"VALORPAGO" Numeric(15,2),
	"TIPOBAIXA" Integer Default 0 UNIQUE,
 Primary Key ("CODPAG","CODPARCELA")
);

Create Table "DESPESA"  (
	"CODDESP" Integer NOT NULL,
	"NOME" Varchar(40) NOT NULL,
 Primary Key ("CODDESP")
);

Create Table "CLIENTE"  (
	"CODCLI" Integer NOT NULL,
	"NOME" Varchar(60) NOT NULL,
	"CODCID" Integer NOT NULL,
 Primary Key ("CODCLI")
);

Create Table "RECEITA"  (
	"CODRECE" Integer NOT NULL,
	"NOME" Varchar(40) NOT NULL,
 Primary Key ("CODRECE")
);











Alter Table "FORNECEDOR" add Foreign Key ("CODCID") references "CIDADE" ("CODCID") on update no action on delete no action;
Alter Table "CLIENTE" add Foreign Key ("CODCID") references "CIDADE" ("CODCID") on update no action on delete no action;
Alter Table "CONTAS_PAG" add Foreign Key ("CODFOR") references "FORNECEDOR" ("CODFOR") on update no action on delete no action;
Alter Table "CONTAS_PAG" add Foreign Key ("CODDESP") references "DESPESA" ("CODDESP") on update no action on delete no action;
Alter Table "CONTAS_REC" add Foreign Key ("CODCLI") references "CLIENTE" ("CODCLI") on update no action on delete no action;
Alter Table "CONTAS_REC" add Foreign Key ("CODRECE") references "RECEITA" ("CODRECE") on update no action on delete no action;


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










