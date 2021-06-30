CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."V_ATIVIDADE_MOV" ("LOCAL", "ID", "NOME", "EMB", "ENDERECO_ID") AS 
  select A.RUA || '.' || A.PREDIO || '.' || A.APARTAMENTO || '.' || A.SALA as local,
       null as ID,
       D.NOME,
       C.EMB || '-' || C.QTD_EMB as emb,
       a.id as endereco_id
  from ENDERECO A
 inner join PRODUTO_EMBALAGEM C
    on C.ID = A.EMBALAGEM_ID
 inner join PRODUTO D
    on D.ID = A.PRODUTO_ID
    and D.ID = C.PRODUTO_ID
 group by A.RUA || '.' || A.PREDIO || '.' || A.APARTAMENTO || '.' || A.SALA,
          D.NOME,
          C.EMB || '-' || C.QTD_EMB,
          a.id
;