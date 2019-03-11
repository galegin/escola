/******************************************************************************/
/****                              Exceptions                              ****/
/******************************************************************************/

CREATE EXCEPTION "except_del_p" 'Children still exist in child table. Cannot delete parent.';
CREATE EXCEPTION "except_ins_ch" 'Parent does not exist. Cannot create child.';
CREATE EXCEPTION "except_ins_ch_card" 'Maximum cardinality exceeded. Cannot insert into child.';
CREATE EXCEPTION "except_upd_ch" 'Parent does not exist. Cannot update child.';
CREATE EXCEPTION "except_upd_ch_card" 'Maximum cardinality exceeded. Cannot update child.';
CREATE EXCEPTION "except_upd_p" 'Children still exist in child table. Cannot update parent.';

/******************************************************************************/
/****                                Tables                                ****/
/******************************************************************************/

CREATE TABLE ADM_NIVEL (
    NM_LOGIN     VARCHAR(20) NOT NULL,
    CD_ENTIDADE  VARCHAR(20) NOT NULL,
    TP_SITUACAO  INTEGER Default 1 NOT NULL,
    IN_INCLUIR   CHAR(1) Default 'F' NOT NULL,
    IN_ALTERAR   CHAR(1) Default 'F' NOT NULL,
    IN_EXCLUIR   CHAR(1) Default 'F' NOT NULL,
    IN_IMPRIMIR  CHAR(1) Default 'F' NOT NULL,
    PRIMARY KEY (NM_LOGIN, CD_ENTIDADE)
);

CREATE TABLE ADM_PARAM (
    CD_PARAMETRO  VARCHAR(20) NOT NULL,
    TP_SITUACAO   INTEGER Default 1 NOT NULL,
    NM_PARAMETRO  VARCHAR(60) NOT NULL,
    TP_PARAMETRO  INTEGER NOT NULL,
    VL_PARAMETRO  VARCHAR(100),
    PRIMARY KEY (CD_PARAMETRO)
);

CREATE TABLE ADM_USUARIO (
    NM_LOGIN       VARCHAR(20) NOT NULL,
    TP_SITUACAO    INTEGER Default 1 NOT NULL,
    NM_USUARIO     VARCHAR(60) NOT NULL,
    TP_PRIVILEGIO  INTEGER Default 3 NOT NULL,
    CD_SENHA       VARCHAR(20) Default '123MUDAR' NOT NULL,
    PRIMARY KEY (NM_LOGIN)
);

CREATE TABLE LOG_ENTIDADE (
    CD_ENTIDADE  VARCHAR(20) NOT NULL,
    CD_CHAVE     VARCHAR(60) NOT NULL,
    DT_LOG       DATE NOT NULL,
    NR_SEQ       INTEGER NOT NULL,
    TP_SITUACAO  INTEGER Default 1 NOT NULL,
    DS_LOG       VARCHAR(1000) NOT NULL,
    NM_LOGIN     VARCHAR(20) NOT NULL,
    HR_LOG       TIME,
    PRIMARY KEY (CD_ENTIDADE, CD_CHAVE, DT_LOG, NR_SEQ)
);

CREATE TABLE OBS_ENTIDADE (
    CD_ENTIDADE  VARCHAR(20) NOT NULL,
    CD_CHAVE     VARCHAR(60) NOT NULL,
    NR_LINHA     INTEGER NOT NULL,
    DS_LINHA     VARCHAR(100),
    PRIMARY KEY (CD_ENTIDADE, CD_CHAVE, NR_LINHA)
);

/******************************************************************************/
/****                             Foreign Keys                             ****/
/******************************************************************************/

ALTER TABLE ADM_NIVEL ADD FOREIGN KEY (NM_LOGIN) REFERENCES ADM_USUARIO (NM_LOGIN) ON DELETE NO ACTION ON UPDATE NO ACTION;