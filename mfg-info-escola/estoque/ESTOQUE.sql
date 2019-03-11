<doc>

<script vrs="2015.05.24" >

/*
Created			21/05/2015
Modified		24/05/2015
Project		
Model		
Company		
Author		
Version		
Database		Firebird 
*/

Drop Table "GER_MOVITEM";
Drop Table "GER_MOV";
Drop Table "GER_PESSOA";
Drop Table "GER_PRODUTO";

<cmd>
Create Table "GER_PRODUTO"  (
	"CD_BARRAPRD" Varchar(30) NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_PRODUTO" Varchar(60) NOT NULL,
	"CD_ESPECIE" Varchar(3),
	"CD_NCM" Varchar(10),
	"CD_CST" Varchar(3),
	"PR_ALIQ" Numeric(6,3),
	"PR_DESC" Numeric(6,3),
	"VL_CUSTO" Numeric(10,2),
	"VL_VENDA" Numeric(10,2),
	"VL_PROMOCAO" Numeric(10,2),
	"DT_PROMOCAOINI" Date,
	"DT_PROMOCAOFIN" Date,
	"CD_REFERENCIA" Varchar(20),
	"CD_VARIANTE" Varchar(20),
	"CD_TAMANHO" Varchar(20),
 Primary Key ("CD_BARRAPRD")
);
</cmd>

<cmd>
Create Table "GER_PESSOA"  (
	"NR_CPFCNPJ" Varchar(20) NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"NM_PESSOA" Varchar(60) NOT NULL,
	"NR_RGIE" Varchar(20),
	"DS_ENDERECO" Varchar(60),
	"DS_BAIRRO" Varchar(60),
	"DS_COMPL" Varchar(60),
	"DS_CIDADE" Varchar(30),
	"DS_UF" Varchar(20),
	"DS_FONE" Varchar(20),
	"DS_CEL" Varchar(20),
	"DS_EMAIL" Varchar(60),
	"DS_TRAB" Varchar(60),
	"DT_NASC" Date,
 Primary Key ("NR_CPFCNPJ")
);
</cmd>

<cmd>
Create Table "GER_MOV"  (
	"CD_DNAMOV" Varchar(20) NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"NR_CPFCNPJ" Varchar(20) NOT NULL,
	"DT_MOV" Date NOT NULL,
	"TP_MOV" Numeric(2,0) NOT NULL,
	"VL_ITEM" Numeric(15,2),
	"VL_DESC" Numeric(15,2),
	"VL_ACRES" Numeric(15,2),
	"VL_TOTAL" Numeric(15,2),
 Primary Key ("CD_DNAMOV")
);
</cmd>

<cmd>
Create Table "GER_MOVITEM"  (
	"CD_DNAMOV" Varchar(20) NOT NULL,
	"NR_ITEM" Numeric(5,0) NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"CD_BARRAPRD" Varchar(30) NOT NULL,
	"DS_PRODUTO" Varchar(60) NOT NULL,
	"CD_ESPECIE" Varchar(3) NOT NULL,
	"CD_NCM" Varchar(10),
	"CD_CST" Varchar(3),
	"PR_ALIQ" Numeric(6,3),
	"QT_ITEM" Numeric(8,3) NOT NULL,
	"VL_ITEM" Numeric(15,2) NOT NULL,
	"VL_CUSTO" Numeric(15,2) NOT NULL,
	"VL_ACRES" Numeric(15,2) NOT NULL,
	"VL_DESC" Numeric(15,2) NOT NULL,
	"VL_TOTAL" Numeric(15,2) NOT NULL,
 Primary Key ("CD_DNAMOV","NR_ITEM")
);
</cmd>

<cmd>Alter Table "GER_MOV" add Foreign Key ("NR_CPFCNPJ") references "GER_PESSOA" ("NR_CPFCNPJ") on update no action on delete no action ;</cmd>
<cmd>Alter Table "GER_MOVITEM" add Foreign Key ("CD_DNAMOV") references "GER_MOV" ("CD_DNAMOV") on update no action on delete no action ;</cmd>
<cmd>Alter Table "GER_MOVITEM" add Foreign Key ("CD_BARRAPRD") references "GER_PRODUTO" ("CD_BARRAPRD") on update no action on delete no action ;</cmd>

<cmd>Create Exception "except_del_p" 'Children still exist in child table. Cannot delete parent.';</cmd>
<cmd>Create Exception "except_ins_ch" 'Parent does not exist. Cannot create child.';</cmd>
<cmd>Create Exception "except_upd_ch" 'Parent does not exist. Cannot update child.';</cmd>
<cmd>Create Exception "except_upd_p" 'Children still exist in child table. Cannot update parent.';</cmd>
<cmd>Create Exception "except_ins_ch_card" 'Maximum cardinality exceeded. Cannot insert into child.';</cmd>
<cmd>Create Exception "except_upd_ch_card" 'Maximum cardinality exceeded. Cannot update child.';</cmd>

set term ^;

set term ;^

/* Roles permissions */

/* Users permissions */

</script>

</doc>