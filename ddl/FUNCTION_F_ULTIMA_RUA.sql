CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_ULTIMA_RUA" ( 
  i_produtivo_id in number, 
  i_hoje in number default 0 
) return varchar2 as 
  v_ultima_atividade number; 
  v_ultima_rua_id number; 
  v_ultima_rua varchar2(3) := '0'; 
begin 
  select f_ultima_atividade(i_produtivo_id) 
    into v_ultima_atividade 
    from dual; 
  select case when tipo = 'P' then 0 else destino_id end 
    into v_ultima_rua_id 
    from movimentacao 
   where id = v_ultima_atividade 
     and (i_hoje = 0 or (i_hoje = 1 and trunc(abast_end) = trunc(sysdate))); 
  if v_ultima_rua_id > 0 then 
    select rua 
      into v_ultima_rua 
      from endereco 
     where id = v_ultima_rua_id; 
  end if; 
  return v_ultima_rua; 
end; 
/