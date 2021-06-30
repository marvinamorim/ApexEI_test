CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."V_CARGA_CLIENTE_INFO" ("CLIENTE_ID", "FANTASIA", "VALOR", "CARGA_ID") AS 
  select a.seqpessoa as cliente_id,
       c.fantasia,
       sum(b.vlrembinformado/b.qtdembalagem*b.qtdatendida) as valor,
       a.nrocarga as carga_id
  from consinco.mad_pedvenda a
 inner join consinco.mad_pedvendaitem b
    on b.nropedvenda = a.nropedvenda
 inner join consinco.ge_pessoa c
    on c.seqpessoa = a.seqpessoa
 group by a.seqpessoa, c.fantasia, a.nrocarga
;