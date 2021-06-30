CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."ENDERECO_APANHA" ("ID", "TIPO_ID", "ESPECIE_ID", "RUA", "PREDIO", "APARTAMENTO", "SALA", "PULMAO", "TERREO", "PRODUTO_ID", "PRODUTO", "EMBALAGEM_ID", "EMBALAGEM", "QTD_EMB", "LS", "QTD_ATUAL", "EXPEDICAO", "STATUS") AS 
  select A.ID,  
      A.TIPO_ID,  
      A.ESPECIE_ID,  
      A.RUA,  
      A.PREDIO,  
      A.APARTAMENTO,  
      A.SALA,  
      A.PULMAO,  
      A.TERREO,  
      A.PRODUTO_ID,  
      B.NOME as PRODUTO,  
      A.EMBALAGEM_ID,  
      C.EMB as EMBALAGEM,  
      C.QTD_EMB,  
      C.LS,  
      A.QTD_ATUAL,  
      A.EXPEDICAO,  
      A.STATUS  
  from endereco a  
 inner join produto b  
    on a.produto_id = b.id  
 inner join produto_embalagem c  
    on a.embalagem_id = c.id  
 where a.pulmao = 0  
   and a.rua not in ('996','998','999','AV')  
---------------------------- 
;