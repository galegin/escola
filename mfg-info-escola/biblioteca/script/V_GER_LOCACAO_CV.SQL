drop view V_GER_LOCACAO;
  
create or alter view V_GER_LOCACAO as
select a.CD_LOCACAO
,      a.TP_SITUACAO
,      a.CD_LIVRO || '-' || a.NR_EXEMPLAR as CD_LIVEXE
,      a.CD_LIVRO
,      a.NR_EXEMPLAR
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
,      a.DS_ISENTAMOT
from GER_LOCACAO a
inner join GER_LIVRO b on (b.CD_LIVRO = a.CD_LIVRO)
inner join GER_LOCADOR c on (c.CD_LOCADOR  = a.CD_LOCADOR)
where a.TP_SITUACAO = 1;