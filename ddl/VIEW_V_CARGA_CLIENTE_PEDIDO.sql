CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."V_CARGA_CLIENTE_PEDIDO" ("PRODUTO_ID", "PRODUTO", "VALOR", "QTD", "QTDEMB", "CARGA_ID", "CLIENTE_ID") AS 
  select d.seqproduto as produto_id,
       d.desccompleta as produto,
       b.vlrembinformado as valor,
       b.qtdatendida as qtd,
       b.qtdembalagem as qtdemb,
       a.nrocarga as carga_id,
       a.seqpessoa as cliente_id
  from consinco.mad_pedvenda a
 inner join consinco.mad_pedvendaitem b
    on b.nropedvenda = a.nropedvenda
 inner join consinco.map_produto d
    on d.seqproduto = b.seqproduto
;