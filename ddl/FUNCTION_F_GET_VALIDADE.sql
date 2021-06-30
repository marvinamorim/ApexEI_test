CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_GET_VALIDADE" (  
  i_produto_id in number,  
  i_tipo in varchar2  
) return number as  
  v_produto_exists number;  
  v_fornecedor_id number;  
  v_fornecedor_exists number;  
  v_dias number;  
begin  
  select count(*)  
    into v_produto_exists  
    from REGRA_VALIDADE A  
   where PRODUTO_ID = i_produto_id  
     and A.TIPO_VALOR = i_tipo;  
    
  if v_produto_exists = 1 then  
    select case  
             when B.VALOR < 1  
               then B.VALOR * A.DIAS_VALIDADE  
             when B.VALOR >= 1 and B.TIPO_VALOR = 'E'  
               then A.DIAS_VALIDADE - B.VALOR  
             else B.VALOR  
           end  
      into v_dias  
      from PRODUTO A  
     inner join REGRA_VALIDADE B  
        on A.ID = B.PRODUTO_ID  
     where A.ID = i_produto_id  
       and B.TIPO_VALOR = i_tipo;  
    return v_dias;  
  end if;  
    
  select count(*)  
    into v_fornecedor_exists  
    from REGRA_VALIDADE A  
   where FORNECEDOR_ID = F_FORNECEDOR_AGG(i_produto_id)  
     and A.TIPO_VALOR = i_tipo;  
    
  if v_fornecedor_exists = 1 then  
    select case  
             when B.VALOR < 1  
               then B.VALOR * A.DIAS_VALIDADE  
             when B.VALOR >= 1 and B.TIPO_VALOR = 'E'  
               then A.DIAS_VALIDADE - B.VALOR  
             else B.VALOR  
           end  
      into v_dias  
      from PRODUTO A  
     inner join REGRA_VALIDADE B  
        on F_FORNECEDOR_AGG(A.ID) = B.FORNECEDOR_ID  
     where A.ID = i_produto_id  
       and B.TIPO_VALOR = i_tipo;  
    return v_dias;  
  end if;   
  select case  
           when B.VALOR < 1  
             then B.VALOR * A.DIAS_VALIDADE  
           when B.VALOR >= 1 and B.TIPO_VALOR = 'E'  
             then A.DIAS_VALIDADE - B.VALOR  
           else B.VALOR  
         end  
    into v_dias  
    from PRODUTO A  
   inner join REGRA_VALIDADE B  
      on B.EMPRESA_ID is not null  
   where A.ID = i_produto_id  
     and B.TIPO_VALOR = i_tipo;  
  return v_dias;  
end;  
----------------------------  
/