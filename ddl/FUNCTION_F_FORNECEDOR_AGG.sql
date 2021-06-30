CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_FORNECEDOR_AGG" (i_produto_id IN NUMBER)  
  RETURN NUMBER IS  
  v_seqfamilia    number;  
  v_fornecedor_id number;  
  v_seqfornecedor number;  
BEGIN  
  select seqfamilia  
    into v_seqfamilia  
    from consinco.map_produto  
   where seqproduto = i_produto_id;  
  SELECT C1.SEQFORNECEDOR  
    INTO v_seqfornecedor  
    FROM CONSINCO.MAP_FAMFORNEC C1  
   WHERE C1.PRINCIPAL = 'S'  
     AND C1.SEQFAMILIA = v_seqfamilia;  
  SELECT A1.CODIGO_AGRUPADO  
    INTO v_fornecedor_id  
    FROM APEX.TB_CDA_CONT_FORNECEDOR A1  
   INNER JOIN APEX.TB_CDA_CONT_FORNAGR B1  
      ON B1.CODIGO_AGRUPADO = A1.CODIGO_AGRUPADO  
     AND B1.AGRUPADO <> 'INATIVO'  
   WHERE A1.CODIGO_AGRUPADO NOT IN (25)  
     AND A1.SEQFORNECEDOR = v_seqfornecedor;  
  RETURN v_fornecedor_id;  
END;  
/