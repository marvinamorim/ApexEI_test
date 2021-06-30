CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."EXPEDICAO_INFO" ("CARGA_ID", "LOTE_ID", "LOTE", "ATIVIDADE_ID", "PRIORIDADE", "LS", "CARGA_STATUS", "LOTE_STATUS", "ATIVIDADE_STATUS", "PRODUTO_ID", "EMB", "QTD_EMB", "QTD_PEDIDO", "PESO", "VOLUME", "SEP_ID", "SEPARADOR", "SEP_QTD", "SEP_START", "SEP_END", "CONF_ID", "CONFERENTE", "CONF_QTD", "CONF_START", "CONF_END") AS 
  select A.ID   as CARGA_ID, 
       B.ID   as LOTE_ID, 
       B.LOTE as LOTE, 
       C.ID   as ATIVIDADE_ID, 
       C.PRIORIDADE, 
       C.LS, 
       A.STATUS as CARGA_STATUS, 
       B.STATUS as LOTE_STATUS, 
       C.STATUS as ATIVIDADE_STATUS, 
       C.PRODUTO_ID, 
       C.EMB, 
       C.QTD_EMB, 
       C.QTD_PEDIDO, 
       C.PESO, 
       C.VOLUME, 
       C.SEP_ID, 
       D.APELIDO as SEPARADOR, 
       C.SEP_QTD, 
       C.SEP_START, 
       C.SEP_END, 
       C.CONF_ID, 
       E.APELIDO as CONFERENTE, 
       C.CONF_QTD, 
       C.CONF_START, 
       C.CONF_END 
  from WMS.CARGA     A, 
       WMS.LOTE      B, 
       WMS.ATIVIDADE C, 
       WMS.PRODUTIVO D, 
       WMS.PRODUTIVO E 
 where A.ID = B.CARGA_ID 
   and A.ID = C.CARGA_ID 
   and B.LOTE = C.LOTE 
   and C.SEP_ID = D.ID 
   and C.CONF_ID = E.ID 
;