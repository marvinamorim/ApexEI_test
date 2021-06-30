CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."V_MV_ATIVIDADES_EXPEDICAO" ("ID", "TIPO", "ORIGEM_ID", "ORIGEM", "DESTINO_ID", "DESTINO", "PRIORIDADE") AS 
  select A.id, 
         A.tipo, 
         A.origem_id, 
         B.rua as origem, 
         A.destino_id, 
         C.rua as destino, 
         A.prioridade 
    from wms.movimentacao A 
   inner join endereco B 
      on A.origem_id = B.id 
   inner join endereco C 
      on A.destino_id = C.id 
   where A.tipo = 'D' 
     and A.status = 0 
  --Atividades de reposição do apanha 
  union 
  select A.id, 
         A.tipo, 
         A.origem_id, 
         B.rua as origem, 
         A.destino_id, 
         'box' as destino, 
         A.prioridade 
    from wms.movimentacao A 
   inner join endereco B 
      on A.origem_id = B.id 
   where A.tipo = 'P' 
     and A.status = 0 
  --Atividades de pulmão box 
   order by 7, 6 
;