CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_DESC_ENDERECO" (i_endereco_id IN number) 
return varchar2 as 
  v_result varchar2(100); 
begin 
  select RUA||'.'||PREDIO||'.'||APARTAMENTO||'.'||SALA 
    into v_result 
    from wms.endereco 
   where ID = i_endereco_id; 
   
  return v_result; 
  exception 
    when NO_DATA_FOUND then 
      return 'Endereço inválido'; 
end; 
/