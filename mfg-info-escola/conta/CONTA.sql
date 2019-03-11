<doc>

<script vrs="2015.05.26" >

/*
Created			25/04/2015
Modified		24/05/2015
Project		
Model		
Company		
Author		
Version		
Database		Firebird 
*/

Drop Table "GER_MOVCONTA";
Drop Table "GER_HIST";
Drop Table "GER_CONTA";

<cmd>
Create Table "GER_CONTA"  (
	"CD_CONTA" Numeric(5,0) NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_CONTA" Varchar(60) NOT NULL,
	"TP_CONTA" Integer NOT NULL,
	"NR_BANCO" Numeric(5,0),
	"NR_AGENCIA" Numeric(5,0),
	"NR_CONTA" Varchar(20),
	"DS_TITULAR" Varchar(60),
	"DT_ABERT" Date,
 Primary Key ("CD_CONTA")
);
</cmd>

<cmd>
Create Table "GER_HIST"  (
	"CD_HIST" Numeric(5,0) NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"DS_HIST" Varchar(60) NOT NULL,
	"TP_OPER" Char(1) NOT NULL,
 Primary Key ("CD_HIST")
);
</cmd>

<cmd>
Create Table "GER_MOVCONTA"  (
	"CD_CONTA" Numeric(5,0) NOT NULL,
	"DT_MOV" Date NOT NULL,
	"NR_SEQMOV" Numeric(5,0) NOT NULL,
	"TP_SITUACAO" Integer Default 1 NOT NULL,
	"CD_HIST" Numeric(5,0) NOT NULL,
	"DS_AUX" Varchar(60) NOT NULL,
	"NR_DOC" Numeric(6,0) NOT NULL,
	"DT_DOC" Date NOT NULL,
	"VL_LANCTO" Numeric(15,2) NOT NULL,
	"NR_SEQREL" Numeric(5,0),
	"DT_CONC" Date,
	"DT_CANC" Date,
 Primary Key ("CD_CONTA","DT_MOV","NR_SEQMOV")
);
</cmd>

<cmd>Alter Table "GER_MOVCONTA" add Foreign Key ("CD_CONTA") references "GER_CONTA" ("CD_CONTA") on update no action on delete no action ;</cmd>
<cmd>Alter Table "GER_MOVCONTA" add Foreign Key ("CD_HIST") references "GER_HIST" ("CD_HIST") on update no action on delete no action ;</cmd>

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