<doc>

<script vrs="2015.05.01" >

<cmd>alter table GER_LOCACAO add DS_ISENTAMOT varchar(40);</cmd>
<cmd>alter table GER_LOCACAO add NR_EXEMPLAR integer;</cmd>

<cmd>
create or alter view V_GER_LOCACAO as
select a.CD_LOCACAO
,      a.TP_SITUACAO
,      a.CD_LIVRO
,      b.DS_TITULO
,      a.CD_LOCADOR
,      c.NM_LOCADOR
,      c.CD_TURMA
,      c.NR_ANO
,      a.DT_LOCACAO
,      a.DT_DEVOLUCAO
,      a.DT_DEVOLVIDO
,      a.VL_MULTA
,      a.DT_PAGOMULTA
,      a.TP_LOCACAO
,      a.NR_EXEMPLAR
,      a.DS_ISENTAMOT
from GER_LOCACAO a
inner join GER_LIVRO b on (b.CD_LIVRO = a.CD_LIVRO)
inner join GER_LOCADOR c on (c.CD_LOCADOR  = a.CD_LOCADOR)
where a.TP_SITUACAO = 1;
<cmd>

/*
NO CADASTRO LIVRO DEVE CONTER
  DS_TITULO    - NOME DO LIVRO
  DS_AUTOR     - NOME DO AUTOR
  DS_EDICAO    - EDIÇÃO
  DS_ORIGEM    - ORIGEM (EXEMPLO, SAO PAULO)
  CD_EDITORA   - EDITORA
  NR_ANO       - ANO DE EDIÇÃO DO LIVRO
  TP_ENSINO    - COLOCAR CAMPO (ENSINO MÉDIO OU FUNDAMENTAL)
                 COLOCAR CAMPO SE É LITERATURA, FUNDAMENTAL OU MÉDIO
  CD_GENERO    - COLOCAR CAMPO DIDATICO (EXP MATEMÁTICA)
  DS_AQUISICAO - DEIXAR CAMPO DATA DE AQUISIÇÃO ABERTO

NO CADASTRO ALUNO
  CAMPO NR.ANO COLOCAR F2 PARA CONSULTA
  CAMPO DATA NASC. COLOCAR A BARRA DE DIVISÃO EXP  /    /    /  AUTOMATICO
*/

<cmd>
create table GER_TURMA (
  CD_TURMA    integer not null,
  TP_SITUACAO integer default 1 not null,
  DS_TURMA    varchar(60) not null,
  primary key (CD_TURMA)
);
</cmd>

</script>

</doc>