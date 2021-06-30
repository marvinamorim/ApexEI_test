CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_FINALIZAR_ATIVIDADE_DEV" ( 
  i_carga IN NUMBER, 
  i_lote IN NUMBER, 
  i_tipo IN VARCHAR2, 
  i_produtivo IN NUMBER, 
  i_codrua IN VARCHAR2 default null 
) as 
v_count number; 
v_finish_carga number; 
v_finish number; 
v_inativo number; 
begin 
  if i_tipo = 'S' then 
    update LOTE 
       set SEP_END = sysdate, 
           STATUS = 2 
     where CARGA_ID = i_carga and LOTE = i_lote 
    ;     
 
    update ATIVIDADE 
       set SEP_END = sysdate, 
           STATUS = 2, 
           SEP_QTD = QTD_PEDIDO 
     where CARGA_ID = i_carga and LOTE = i_lote 
    ; 
    --INICIO Processo de conferencia por amostragem--*************************** 
    update LOTE 
       set CONF_START = sysdate, 
           STATUS = 3, 
           CONF_ID = 9 
     where CARGA_ID = i_carga and LOTE = i_lote 
       and LS in ('ME','MF','FR','CA') 
    ; 
 
    update ATIVIDADE 
       set CONF_START = sysdate, 
           STATUS = 3, 
           CONF_ID = 9 
     where CARGA_ID = i_carga and LOTE = i_lote 
       and LS in ('ME','MF','FR','CA') 
    ; 
    --FIM Processo de conferencia por amostragem--****************************** 
  elsif i_tipo = 'C' then 
    update LOTE 
       set CONF_END = sysdate, 
           STATUS = 4 
     where CARGA_ID = i_carga and LOTE = i_lote 
    ; 
    select count(*) 
      into v_finish_carga 
      from LOTE 
     where CARGA_ID = i_carga 
       and STATUS != 4 
    ; 
    if v_finish_carga = 0 then 
      consinco.P_WMS_FINISH_SEPC5(i_carga); 
      update CARGA 
         set STATUS = 2, 
             DATE_END = sysdate 
       where ID = i_carga 
      ; 
    end if; 
  elsif i_tipo = 'SF' then 
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
       and STATUS < 2 
    ; 
    if v_count = 0 then 
      update LOTE 
         set SEP_END = sysdate, 
             STATUS = 2 
       where CARGA_ID = i_carga and LOTE = i_lote 
      ; 
      --INICIO Processo de conferencia por amostragem--************************* 
      update LOTE 
         set CONF_START = sysdate, 
             STATUS = 3, 
             CONF_ID = 9 
       where CARGA_ID = i_carga and LOTE = i_lote 
         and LS in ('ME','MF','FR','CA') 
      ;     
 
      update ATIVIDADE 
         set CONF_START = sysdate, 
             STATUS = 3, 
             CONF_ID = 9 
       where CARGA_ID = i_carga and LOTE = i_lote 
         and LS in ('ME','MF','FR','CA') 
      ; 
      --FIM Processo de conferencia por amostragem--**************************** 
    end if; 
  end if; 
  commit; 
   
  select count(*) 
    into v_inativo 
    from PRODUTIVO A 
   where STATUS = 0 
     and ID = i_produtivo 
  ; 
     
  if v_inativo = 1 then 
    ws_notify_api.do_rest_notify_user( 
      i_userid   => to_char(i_produtivo), 
      i_room     => 'private', 
      i_type     => 'warn', 
      i_title    => 'My test title', 
      i_message  => 'My test message content...' 
    ); 
  end if; 
  commit; 
end; 
/