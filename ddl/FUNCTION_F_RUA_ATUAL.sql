CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_RUA_ATUAL" ( 
  i_produtivo_id in number 
) return varchar2 as 
  v_rua_atual varchar2(3); 
  v_destino_id number; 
  v_tipo varchar2(1); 
begin 
  select max(destino_id), tipo 
    into v_destino_id, v_tipo 
    from movimentacao 
   where ((abast_id = i_produtivo_id and 
           abast_start is not null and 
           abast_end is null) or 
          (emp_id = i_produtivo_id and 
           emp_start is not null and 
           emp_end is null)) 
   group by tipo; 
  if v_tipo = 'P' then 
    v_rua_atual := 'box'; 
  else 
    select rua 
      into v_rua_atual 
      from endereco 
     where id = v_destino_id; 
  end if; 
  return v_tipo; 
   
  exception 
    when NO_DATA_FOUND then 
      return null; 
end; 
/