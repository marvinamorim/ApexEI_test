CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_ERRO_SEPARADOR_DEV" ( 
  i_carga IN NUMBER, 
  i_lote IN NUMBER, 
  i_produto IN NUMBER, 
  i_qtderro IN NUMBER, 
  i_embalagem IN VARCHAR2, 
  i_qtdembalagem IN NUMBER, 
  i_sep in NUMBER, 
  i_sep_nome IN VARCHAR2, 
  i_conf in NUMBER 
) as 
  v_cont number; 
  v_conf varchar2(100); 
  v_box number; 
  v_err_seq number; 
begin 
  select count(*) 
    into v_cont 
    from APEX.TB_CDA_ERRO_SEP 
   where ERR_CARGA = i_carga 
     and ERR_LOTE = i_lote 
     and ERR_SEQPRODUTO = i_produto 
     and ERR_EMBALAGEM = i_embalagem 
     and ERR_QTDEMBALAGEM = i_qtdembalagem 
  ; 
   
  if v_cont = 0 then 
    execute immediate 'select apex.TB_CDA_ERRO_SEP_SEQ.Nextval from dual' into v_err_seq; 
     
    insert into APEX.TB_CDA_ERRO_SEP( 
      ERR_CODE, 
      ERR_CODPRODUTIVO, 
      ERR_DATA, 
      ERR_SEQPRODUTO, 
      ERR_QTD, 
      ERR_CARGA, 
      ERR_LOTE, 
      ERR_SEPARADOR, 
      ERR_EMBALAGEM, 
      ERR_QTDEMBALAGEM 
    ) values ( 
      v_err_seq, 
      i_conf, 
      sysdate, 
      i_produto, 
      i_qtderro, 
      i_carga, 
      i_lote, 
      i_sep, 
      i_embalagem, 
      i_qtdembalagem 
    ); 
  else 
    select ERR_CODE 
      into v_err_seq 
      from APEX.TB_CDA_ERRO_SEP 
     where ERR_CARGA = i_carga 
       and ERR_LOTE = i_lote 
       and ERR_SEQPRODUTO = i_produto 
     and ERR_EMBALAGEM = i_embalagem 
     and ERR_QTDEMBALAGEM = i_qtdembalagem 
    ;  
  end if; 
   
  select BOX_ID 
    into v_box 
    from CARGA J 
   where J.ID = i_carga; 
 
  select APELIDO 
    into v_conf 
    from PRODUTIVO 
   where ID = i_conf; 
 
  insert into APEX.TB_WMS_CHAMAR_SEP ( 
    WCS_CONF, 
    WCS_SEP, 
    WCS_BOX, 
    DONE, 
    DONE_PROD, 
    DTAINCLUSAO, 
    CARGA, 
    LOTE, 
    CODPRODUTIVO, 
    ERR_CODE 
  ) values ( 
    v_conf, 
    i_sep_nome, 
    v_box, 
    0, 
    0, 
    sysdate, 
    i_carga, 
    i_lote, 
    i_sep, 
    v_err_seq 
  ); 
  ws_notify_api.do_rest_notify_user( 
    i_userid   => to_char(i_sep), 
    i_room     => 'private', 
    i_type     => 'error', 
    i_title    => 'My test title', 
    i_message  => 'My test message content...' 
  ); 
end; 
/