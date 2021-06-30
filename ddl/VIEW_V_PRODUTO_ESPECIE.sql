CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."V_PRODUTO_ESPECIE" ("ID", "ESPECIE_ID", "ESPECIE", "EMBALAGEM_ID", "EMB", "QTD_EMB", "LASTRO", "ALTURA", "ESTOQUE_MIN", "PRODUTO_ID") AS 
  select A.ID,  
       A.ESPECIE_ID,  
       B.NOME as ESPECIE,  
       A.EMBALAGEM_ID,  
       C.EMB,  
       C.QTD_EMB,  
       A.LASTRO,  
       A.ALTURA,  
       A.ESTOQUE_MIN,  
       A.PRODUTO_ID  
  from PRODUTO_ESPECIE A  
 inner join ENDERECO_ESPECIE B  
    on A.ESPECIE_ID = B.ID  
 inner join PRODUTO_EMBALAGEM C  
    on A.EMBALAGEM_ID = C.ID  
   and A.PRODUTO_ID = C.PRODUTO_ID  
 inner join PRODUTO D  
    on A.PRODUTO_ID = D.ID  
---------------------------- 
;