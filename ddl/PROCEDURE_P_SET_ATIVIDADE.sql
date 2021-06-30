CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_SET_ATIVIDADE" ( 
  i_carga IN NUMBER, 
  i_lote IN NUMBER, 
  i_user IN NUMBER, 
  i_tipo IN VARCHAR2, 
  i_codrua in VARCHAR2 default null 
) as 
v_new_atv number; 
begin 
  if i_tipo = 'S' then 
    update LOTE 
       set SEP_ID = i_user, 
           SEP_START = sysdate, 
           STATUS = 1 
     where CARGA_ID = i_carga and LOTE = i_lote 
    ;     
 
    update ATIVIDADE 
       set SEP_ID = i_user, 
           SEP_START = sysdate, 
           STATUS = 1 
     where CARGA_ID = i_carga and LOTE = i_lote 
    ; 
  elsif i_tipo = 'C' then 
    update LOTE 
       set CONF_ID = i_user, 
           CONF_START = sysdate, 
           STATUS = 3 
     where CARGA_ID = i_carga and LOTE = i_lote 
    ;     
 
    update ATIVIDADE 
       set CONF_ID = i_user, 
           CONF_START = sysdate, 
           STATUS = 3 
     where CARGA_ID = i_carga and LOTE = i_lote 
    ; 
  elsif i_tipo = 'SF' then 
    select count(*) 
      into v_new_atv 
      from LOTE A 
     where CARGA_ID = i_carga and LOTE = i_lote 
       and STATUS = 0; 
     
    if v_new_atv > 0 then 
      update LOTE 
         set SEP_ID = 9, 
             SEP_START = sysdate, 
             STATUS = 1 
       where CARGA_ID = i_carga and LOTE = i_lote 
      ; 
    end if; 
     
    update ATIVIDADE A 
       set SEP_ID = i_user, 
           SEP_START = sysdate, 
           SEP_ENDERECO = i_codrua, 
           STATUS = 1 
     where CARGA_ID = i_carga and LOTE = i_lote 
       and A.PRODUTO_ID in ( 
           select B.PRODUTO_ID 
             from V_ESTACAO_SEP B 
            where A.CARGA_ID = B.CARGA_ID 
              and A.LOTE = B.LOTE 
              and B.CODRUA = i_codrua) 
    ; 
  end if; 
  commit; 
end; 
/