CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_REPOSICAO_ENDERECO" (i_id IN NUMBER)  
return number is  
v_qtd_reposicao number;  
begin  
  select C.LASTRO*C.ALTURA*D.QTD_EMB  
    into v_qtd_reposicao  
    from ENDERECO A  
   inner join ENDERECO_ESPECIE B  
      on A.TIPO_REPOSICAO = B.SIGLA  
   inner join PRODUTO_ESPECIE C  
      on A.ESPECIE_ID = C.ESPECIE_ID  
     and A.PRODUTO_ID = C.PRODUTO_ID  
   inner join PRODUTO_EMBALAGEM D  
      on D.ID = C.EMBALAGEM_ID  
   where A.ID = i_id  
  ;  
  return v_qtd_reposicao;  
    
  exception  
  when NO_DATA_FOUND then  
    return 0;  
end;  
----------------------------  
/