CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_WMS_CORTAR_PRODUTO" ( 
  i_carga IN NUMBER, 
  i_produto IN NUMBER, 
  i_embalagem IN NUMBER, 
  i_qtd IN NUMBER, 
  i_seqpessoa IN NUMBER, 
  i_qtd_pedido IN NUMBER, 
  i_corte_id IN NUMBER, 
  i_user IN VARCHAR2 default null 
) as 
v_qtd_resta number; 
v_qtd_update number; 
v_new_qtd number; 
v_seqendereco number; 
v_seqhist number; 
v_seqlanc number; 
begin 
  insert into WMS.CORTE_LOG ( 
    corte_id, 
    pessoa_id, 
    qtd_emb, 
    qtd_pedido, 
    qtd_digitado, 
    created_by 
  ) 
  values ( 
    i_corte_id, 
    i_seqpessoa, 
    i_embalagem, 
    i_qtd_pedido, 
    i_qtd, 
    i_user 
  ) 
  ; 
  --Update responsável por fazer o update na mad_pedvendaitem 
  update consinco.MRL_CARGAEXPPROD A 
     set A.QTDEMBANTERIOR           = NULL, 
         A.QTDUNITIMPORTADA         = 0, 
         A.QTDUNITCONFERIDA         = i_qtd*i_embalagem, 
         A.USUCONFERENCIA           = i_user, 
         A.DTAHORCONFERENCIA        = sysdate, 
         A.QTDUNITCONFERIDAANTERIOR = A.QTDEMBALAGEM * A.QTDEMBSOLICITADA, 
         A.QTDCONFMESA              = NULL, 
         A.QTDUNITCONFERIDA_RF      = i_qtd*i_embalagem 
   where A.SEQPESSOA = i_seqpessoa 
     And A.SEQPRODUTO = i_produto 
     And A.NROCARGA = i_carga 
     And A.NROEMPRESA = 1 
     --And A.SEQPESSOAEND = 0 
     --And A.NROPEDVENDA = 0 
     And A.INDEMBALADO = 'N' 
     And A.SEQLOCALITEM = 0 
     And A.SEQLOTEESTOQUE = 0 
     And A.QTDEMBALAGEM = i_embalagem 
  ; 
  /* 
  update CONSINCO.MLO_CARGAEXPPROD 
     set QTDEMBSEPARADA = i_qtd, 
         INDGERACORTEITEMWM = 'S' 
   where nrocarga = i_carga 
     and seqproduto = i_produto 
     and qtdembalagem = i_embalagem 
     and seqpessoa = i_seqpessoa 
  ;*/ 
  --commit; 
end; 
/