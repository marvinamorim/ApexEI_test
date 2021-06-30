CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_CORTE" ( 
  i_carga IN NUMBER, 
  i_lote IN NUMBER, 
  i_produto_id IN NUMBER, 
  i_user IN NUMBER, 
  i_conf IN VARCHAR2, 
  i_ped IN VARCHAR2, 
  i_pessoa IN NUMBER default 0, 
  i_qtdemb IN NUMBER, 
  i_mesa_user IN VARCHAR2 default null 
) as 
begin 
  insert into CORTE ( 
    CARGA_ID, 
    LOTE, 
    PRODUTO_ID, 
    CONF_ID, 
    CONF_QTD, 
    QTD_PEDIDO, 
    DONE, 
    PESSOA_ID, 
    QTD_EMB, 
    CREATED_BY 
  ) 
  values  ( 
    i_carga, 
    i_lote, 
    i_produto_id, 
    i_user, 
    i_conf, 
    i_ped, 
    0, 
    i_pessoa, 
    i_qtdemb, 
    i_mesa_user 
  ); 
end; 
/