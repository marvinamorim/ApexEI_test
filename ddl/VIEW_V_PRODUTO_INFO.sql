CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."V_PRODUTO_INFO" ("PRODUTO_ID", "EMBALAGEM_ID", "PRODUTO_NOME", "PESO_BRUTO", "PESO_LIQUIDO", "ALTURA", "LARGURA", "PROFUNDIDADE", "VOLUME", "QTD_EMB", "EMB", "LS") AS 
  select distinct  
       A.ID as PRODUTO_ID,  
       B.ID as EMBALAGEM_ID,  
       A.NOME as PRODUTO_NOME,  
       B.PESO_BRUTO,  
       B.PESO_LIQUIDO,  
       B.ALTURA/100 as ALTURA,  
       B.LARGURA/100 as LARGURA,  
       B.PROFUNDIDADE/100 as PROFUNDIDADE,  
       B.ALTURA*B.LARGURA*B.PROFUNDIDADE/1000000 as VOLUME,  
       B.QTD_EMB,  
       B.EMB,  
       B.LS  
  from WMS.PRODUTO A  
 inner join WMS.PRODUTO_EMBALAGEM B  
    on A.ID = B.PRODUTO_ID  
 where B.LS not in ('PR')  
   and A.STATUS = 1  
---------------------------- 
;