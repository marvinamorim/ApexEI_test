CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_ERRO_SEPARACAO" ( 
  i_atividade_id IN NUMBER, 
  i_qtderro IN NUMBER, 
  i_nao_criar_alerta IN NUMBER default null --null para criar alerta 
) as 
  v_exists number; 
  v_box number; 
  v_err_seq number; 
  v_err_seq_alert number; 
  v_local varchar2(100); 
  v_sep_id number; 
begin 
  select count(*) 
    into v_exists 
    from ERRO_SEPARACAO A 
   where A.ATIVIDADE_ID = i_atividade_id 
  ; 
   
  if v_exists = 0 then 
    v_err_seq := ERRO_SEPARACAO_SEQ.nextval; 
     
    insert into ERRO_SEPARACAO( 
      ID, 
      ATIVIDADE_ID, 
      QTD_ERRO 
    ) values( 
      v_err_seq, 
      i_atividade_id, 
      i_qtderro 
    ); 
  else 
    select max(ID) 
      into v_err_seq 
      from ERRO_SEPARACAO A 
     where ATIVIDADE_ID = i_atividade_id 
    ; 
  end if; 
   
  if i_nao_criar_alerta is null then 
    select distinct BOX_ID 
      into v_box 
      from CARGA J 
     inner join ATIVIDADE K 
        on J.ID = K.CARGA_ID 
     where K.ID = i_atividade_id 
    ; 
 
    select SEP_ENDERECO, SEP_ID 
      into v_local, v_sep_id 
      from ATIVIDADE 
     where ID = i_atividade_id 
    ; 
 
    update ERRO_SEPARACAO_ALERTA 
       set DONE_PUBLICO = 1, 
           DONE_PRIVADO = 1, 
           DONE_ADMIN = 1 
     where ERRO_SEPARACAO_ID = v_err_seq 
    ; 
 
    v_err_seq_alert := ERRO_SEPARACAO_ALERTA_SEQ.nextval; 
 
    insert into ERRO_SEPARACAO_ALERTA ( 
      ID, 
      ERRO_SEPARACAO_ID, 
      BOX_ID, 
      LOCAL, 
      DONE_PUBLICO, 
      DONE_PRIVADO, 
      DONE_ADMIN 
    ) values ( 
      v_err_seq_alert, 
      v_err_seq, 
      v_box, 
      v_local, 
      0, 
      0, 
      0 
    ); 
    ws_notify_api.do_rest_notify_user( 
      i_userid   => to_char(v_sep_id), 
      i_room     => 'private', 
      i_type     => 'error', 
      i_title    => 'My test title', 
      i_message  => to_char(v_err_seq_alert) 
    ); 
  end if; 
end; 
/