CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."V_MH_ATIVIDADES_RECEBIMENTO" ("ID", "TIPO", "ORIGEM_ID", "ORIGEM", "DESTINO_ID", "DESTINO", "PRIORIDADE") AS 
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
   where A.tipo = 'A' 
     and A.status = 0 
  --Atividades de subida de palete 
  union 
  select A.id, 
         A.tipo, 
         A.origem_id, 
         'box' as origem, 
         A.destino_id, 
         B.rua as destino, 
         A.prioridade 
    from wms.movimentacao A 
   inner join endereco B 
      on A.destino_id = B.id 
   where A.tipo = 'E' 
     and A.status = 0 
  --Atividades de recebimento de mercadoria 
   order by 7, 6 
;