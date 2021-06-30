CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_ATUALIZAR_ENDERECO" (  
  i_qtd IN NUMBER,  
  i_produto_id IN NUMBER,  
  i_emb IN VARCHAR2,  
  i_qtd_emb IN NUMBER , 
  i_prioridade IN NUMBER 
) as  
  v_pulmao number;  
  v_endereco_id number;  
  v_new_qtd number;  
  v_tem_reposicao number;  
begin  
  P_ATUALIZAR_ENDERECO_INFO(  
    i_produto_id, i_emb, i_qtd_emb, i_qtd, v_endereco_id, v_pulmao, v_new_qtd  
  );  
  update ENDERECO  
     set QTD_ATUAL = v_new_qtd  
   where ID = v_endereco_id  
  ;  
  if v_new_qtd <= 0 and v_pulmao = 0 then  
    P_REPOSICAO_ENDERECO(v_endereco_id, i_prioridade);  
  end if;  
  commit;  
    
  EXCEPTION  
  when others then  
    insert into teste(c_vc)  
    values (i_qtd||' / '||i_produto_id||' / '||i_emb||'-'||i_qtd_emb);  
    commit;  
    raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);  
end;  
----------------------------  
/