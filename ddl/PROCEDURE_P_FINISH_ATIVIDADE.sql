CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_FINISH_ATIVIDADE" ( --LEGACY 
  i_carga IN NUMBER, 
  i_lote IN NUMBER, 
  i_user IN NUMBER, 
  i_tipo IN VARCHAR2, 
  i_codrua in VARCHAR2 default null 
) as 
v_count number; 
begin 
  if i_tipo = 'SF' then 
    update ATIVIDADE A 
       set SEP_END = sysdate, 
           SEP_QTD = QTD_PEDIDO, 
           STATUS = 2 
     where A.CARGA_ID = i_carga 
       and A.LOTE = i_lote 
       and A.PRODUTO_ID in ( 
           select B.PRODUTO_ID 
             from V_ESTACAO_SEP B 
            where A.CARGA_ID = B.CARGA_ID 
              and A.LOTE = B.LOTE 
              and B.CODRUA = i_codrua) 
    ; 
    commit; 
   
    select count(*) 
      into v_count 
      from V_ESTACAO_SEP 
     where CARGA_ID = i_carga 
       and LOTE = i_lote 
       and STATUS < 2; 
     
    if v_count = 0 then 
      update LOTE 
         set SEP_END = sysdate, 
             STATUS = 2 
       where CARGA_ID = i_carga and LOTE = i_lote 
      ; 
    end if; 
  end if; 
  commit; 
end; 
/