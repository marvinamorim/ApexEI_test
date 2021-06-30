CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_ENDERECO_MOVIMENTACAO" ( 
  i_id IN NUMBER, 
  io_qtd IN OUT NUMBER, 
  i_prioridade IN NUMBER 
) as  
  v_especie_id number;  
  v_produto_id number;  
  v_endereco_mov number;  
  v_tipo_movimento varchar2(1); 
  v_destino_terreo number; 
begin  
  select especie_id, produto_id  
    into v_especie_id, v_produto_id  
    from endereco A  
   where id = i_id  
  ;  
  for c1 in (  
    select DISTINCT A.ID, A.QTD_ATUAL, B.DATA_VALIDADE, C.EMB, C.QTD_EMB, A.TERREO 
      from ENDERECO A  
     inner join ENDERECO_VALIDADE B  
        on B.ENDERECO_ID = A.ID  
     inner join PRODUTO_EMBALAGEM C  
        on C.ID = A.EMBALAGEM_ID  
     where A.PRODUTO_ID = v_produto_id  
       and ESPECIE_ID = case when v_especie_id = 2 then 1 else 5 end  
     order by A.QTD_ATUAL, B.DATA_VALIDADE  
  ) loop  
    select A.terreo 
      into v_destino_terreo 
      from endereco A 
     where id = i_id; 
      
    if c1.terreo = 0 and v_destino_terreo = 1 then 
      v_tipo_movimento := 'D'; 
    elsif c1.terreo = 1 and v_destino_terreo = 0 then 
      v_tipo_movimento := 'A'; 
    elsif c1.terreo = 1 and v_destino_terreo = 1 then 
      v_tipo_movimento := 'R'; 
    end if; 
    if c1.qtd_atual >= io_qtd then  
      insert into movimentacao (tipo, origem_id, destino_id, qtd, emb, qtd_emb, status, prioridade)  
      values (v_tipo_movimento, c1.id, i_id, io_qtd, c1.emb, c1.qtd_emb, 0, i_prioridade)  
      ;  
      update endereco  
         set qtd_atual = qtd_atual - io_qtd  
       where id = c1.id  
      ;  
      io_qtd := 0;  
      EXIT;  
    else  
      insert into movimentacao (tipo, origem_id, destino_id, qtd, emb, qtd_emb, status, prioridade)  
      values (v_tipo_movimento, c1.id, i_id, c1.qtd_atual, c1.emb, c1.qtd_emb, 0, i_prioridade)  
      ;  
      update endereco  
         set qtd_atual = 0  
       where id = c1.id  
      ;  
      io_qtd := io_qtd - c1.qtd_atual;  
    end if;  
  end loop;  
end;  
----------------------------  
/