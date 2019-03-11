/*
Created		22/5/2008
Modified		9/7/2008
Project		
Model			
Company		
Author		
Version		
Database		Interbase 6 SQL 3 
*/






















Drop Table "CONTACLAS";
Drop Table "CLASSIFICACAO";
Drop Table "TIPOCLAS";
Drop Table "CONTACTB";










Create Table "CONTACTB"  (
	"CODCTB" Integer NOT NULL,
	"DESCRICAO" Varchar(60) NOT NULL,
	"NIVEL" Integer NOT NULL,
	"COMPLETO" Varchar(20) NOT NULL,
	"SINTANAL" Char(1) NOT NULL,
 Primary Key ("CODCTB")
);

Create Table "TIPOCLAS"  (
	"CODTIP" Integer NOT NULL,
	"DESCRICAO" Varchar(20) NOT NULL,
	"DESPESA" Char(1) Default 'N' NOT NULL,
	"CCUSTO" Char(1) Default 'N' NOT NULL,
 Primary Key ("CODTIP")
);

Create Table "CLASSIFICACAO"  (
	"CODTIP" Integer NOT NULL,
	"CODCLA" Integer NOT NULL,
	"DESCRICAO" Varchar(40) NOT NULL,
 Primary Key ("CODTIP","CODCLA")
);

Create Table "CONTACLAS"  (
	"CODCTB" Integer NOT NULL,
	"CODCLA" Integer NOT NULL,
	"CODTIP" Integer NOT NULL,
 Primary Key ("CODCTB","CODCLA","CODTIP")
);











Alter Table "CONTASLD" add Foreign Key ("CODCTB") references "CONTACTB" ("CODCTB") on update no action on delete no action;
Alter Table "MOVTOCTBI" add Foreign Key ("CODCTB") references "CONTACTB" ("CODCTB") on update no action on delete no action;
Alter Table "CONTACLAS" add Foreign Key ("CODCTB") references "CONTACTB" ("CODCTB") on update no action on delete no action;
Alter Table "CLASSIFICACAO" add Foreign Key ("CODTIP") references "TIPOCLAS" ("CODTIP") on update no action on delete no action;
Alter Table "CONTACLAS" add Foreign Key ("CODTIP","CODCLA") references "CLASSIFICACAO" ("CODTIP","CODCLA") on update no action on delete no action;


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










