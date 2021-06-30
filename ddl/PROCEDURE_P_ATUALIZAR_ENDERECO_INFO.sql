CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_ATUALIZAR_ENDERECO_INFO" (  
  i_produto_id IN NUMBER,  
  i_emb IN VARCHAR2,  
  i_qtd_emb IN NUMBER,  
  i_qtd IN NUMBER,  
  o_endereco_id OUT NUMBER,  
  o_pulmao OUT NUMBER,  
  o_new_qtd OUT NUMBER  
) as  
  v_tem_reposicao number;  
begin  
  select count(*)  
    into v_tem_reposicao  
    from ENDERECO A  
   where A.ID = (  
     select max(B.ID)  
       from ENDERECO B  
      inner join PRODUTO_EMBALAGEM C  
         on B.EMBALAGEM_ID = C.ID  
      where B.PRODUTO_ID = i_produto_id  
        and C.EMB = i_emb  
        and C.QTD_EMB = i_qtd_emb  
        and B.EXPEDICAO = 1  
   )  
  ;  
  select A.ID, A.PULMAO, A.QTD_ATUAL - i_qtd  
    into o_endereco_id, o_pulmao, o_new_qtd  
    from ENDERECO A  
   where A.ID = (  
     select max(B.ID)  
       from ENDERECO B  
      inner join PRODUTO_EMBALAGEM C  
         on B.EMBALAGEM_ID = C.ID  
      where B.PRODUTO_ID = i_produto_id  
        and B.EXPEDICAO = 1  
        and ((v_tem_reposicao > 0  
              and C.EMB = i_emb  
              and C.QTD_EMB = i_qtd_emb  
             ) or (v_tem_reposicao = 0))  
   )  
  ;  
end;  
----------------------------  
/