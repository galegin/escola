/*
Created		22/5/2008
Modified		8/7/2008
Project		
Model			
Company		
Author		
Version		
Database		Interbase 6 SQL 3 
*/






















Drop Table "MOVTOCTBI";
Drop Table "MOVTOCTB";
Drop Table "CONTASLD";
Drop Table "CONTACTB";










Create Table "CONTACTB"  (
	"CODCTB" Integer NOT NULL,
	"DESCRICAO" Varchar(60) NOT NULL,
	"NIVEL" Integer NOT NULL,
	"COMPLETO" Varchar(20) NOT NULL,
	"SINTANAL" Char(1) NOT NULL,
 Primary Key ("CODCTB")
);

Create Table "CONTASLD"  (
	"CODCTB" Integer NOT NULL,
	"DATASALDO" Date NOT NULL,
	"SALDO" Numeric(15,2) NOT NULL,
	"DEBCRE" Char(1) NOT NULL,
 Primary Key ("CODCTB")
);

Create Table "MOVTOCTB"  (
	"CODMOV" Integer NOT NULL,
	"DATAMOVTO" Date NOT NULL,
	"VALORMOVTO" Numeric(15,2) NOT NULL,
 Primary Key ("CODMOV")
);

Create Table "MOVTOCTBI"  (
	"CODMOV" Integer NOT NULL,
	"CODCTB" Integer NOT NULL,
	"VALORCTB" Numeric(15,2) NOT NULL,
	"DEBCRE" Char(1) NOT NULL,
 Primary Key ("CODMOV","CODCTB")
);











Alter Table "CONTASLD" add Foreign Key ("CODCTB") references "CONTACTB" ("CODCTB") on update no action on delete no action;
Alter Table "MOVTOCTBI" add Foreign Key ("CODCTB") references "CONTACTB" ("CODCTB") on update no action on delete no action;
Alter Table "MOVTOCTBI" add Foreign Key ("CODMOV") references "MOVTOCTB" ("CODMOV") on update no action on delete no action;


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










