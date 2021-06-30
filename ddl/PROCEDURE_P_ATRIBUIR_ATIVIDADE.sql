CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_ATRIBUIR_ATIVIDADE" ( 
  i_carga IN NUMBER, 
  i_lote_id IN NUMBER, 
  i_user IN NUMBER, 
  i_tipo IN VARCHAR2, 
  i_codrua in VARCHAR2 default null 
) as 
v_new_atv number; 
v_lote number; 
v_idle_activity number; 
v_new_carga number; 
begin 
  select LOTE 
    into v_lote 
    from LOTE 
   where ID = i_lote_id; 
    
  if i_tipo = 'S' then 
    select count(*) 
      into v_new_carga 
      from CARGA 
     where ID = i_carga 
       and STATUS = 0 
    ; 
     
    if v_new_carga = 1 then 
      update CARGA 
         set STATUS = 1, 
             DATE_START = case when DATE_START is null then sysdate else DATE_START end 
       where ID = i_carga 
      ; 
    end if; 
 
    update LOTE 
       set SEP_ID = i_user, 
           SEP_START = case when SEP_START is null then sysdate else SEP_START end, 
           STATUS = 1 
     where CARGA_ID = i_carga and LOTE = v_lote 
    ;     
 
    update ATIVIDADE 
       set SEP_ID = i_user, 
           SEP_START = case when SEP_START is null then sysdate else SEP_START end, 
           STATUS = 1 
     where CARGA_ID = i_carga and LOTE = v_lote 
    ; 
  elsif i_tipo = 'C' then 
    select count(*) 
      into v_idle_activity 
      from LOTE 
     where CONF_ID = i_user 
       and CARGA_ID = i_carga 
       and LOTE = v_lote 
       and STATUS = 6 
    ; 
     
    if v_idle_activity = 0 then 
      update LOTE 
         set CONF_ID = i_user, 
             CONF_START = case when CONF_START is null then sysdate else CONF_START end, 
             STATUS = 3 
       where CARGA_ID = i_carga and LOTE = v_lote 
      ; 
 
      update ATIVIDADE 
         set CONF_ID = i_user, 
             CONF_START = case when CONF_START is null then sysdate else CONF_START end, 
             STATUS = 3 
       where CARGA_ID = i_carga and LOTE = v_lote 
      ; 
    else 
      update LOTE 
         set STATUS = 3 
       where CARGA_ID = i_carga and LOTE = v_lote 
      ; 
    end if; 
  elsif i_tipo = 'SF' then 
    select count(*) 
      into v_new_atv 
      from LOTE A 
     where CARGA_ID = i_carga and LOTE = v_lote 
       and STATUS = 0; 
     
    if v_new_atv > 0 then 
      update LOTE 
         set SEP_ID = 9, 
             SEP_START = case when SEP_START is null then sysdate else SEP_START end, 
             STATUS = 1 
       where CARGA_ID = i_carga and LOTE = v_lote 
      ; 
    end if; 
     
    update ATIVIDADE A 
       set SEP_ID = i_user, 
           SEP_START = case when SEP_START is null then sysdate else SEP_START end, 
           SEP_ENDERECO = i_codrua, 
           STATUS = 1 
     where CARGA_ID = i_carga and LOTE = v_lote 
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