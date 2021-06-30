CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_REPOSICAO_ENDERECO" ( 
  i_id IN NUMBER, 
  i_prioridade IN NUMBER 
) as  
v_new_qtd number;  
v_qtd_restante number;  
v_endereco_mov number;  
BEGIN  
  v_new_qtd := F_REPOSICAO_ENDERECO(i_id);  
  if v_new_qtd > 0 then  
    v_qtd_restante := v_new_qtd;  
    P_ENDERECO_MOVIMENTACAO(i_id, v_qtd_restante, i_prioridade);  
    
    update ENDERECO  
       set QTD_ATUAL = v_new_qtd - v_qtd_restante  
     where ID = i_id;  
  else  
    insert into teste(c_vc, c_num)  
    values ('Sem reposicao para o id ' || i_id, i_id);  
    commit;  
  end if;  
    
END;  
----------------------------  
/