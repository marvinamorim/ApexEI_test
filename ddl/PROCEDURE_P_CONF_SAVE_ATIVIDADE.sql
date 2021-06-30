CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_CONF_SAVE_ATIVIDADE" ( 
  i_carga in number, 
  i_lote in number, 
  i_produto in number, 
  i_qtdemb in number, 
  i_qtd in number 
) as 
begin 
  update ATIVIDADE A 
     set A.CONF_QTD = nvl(CONF_QTD,0) + i_qtd, 
         A.CONF_END = sysdate, 
         A.STATUS = 4 
   where A.CARGA_ID = i_carga 
     and A.LOTE  = i_lote 
     and A.PRODUTO_ID = i_produto 
     and A.QTD_EMB = i_qtdemb; 
  commit; 
end; 
/