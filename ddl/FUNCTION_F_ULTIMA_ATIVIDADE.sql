CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_ULTIMA_ATIVIDADE" ( 
  i_produtivo_id in number 
) return number as 
  v_atividade varchar2(1); 
  v_return number; 
begin 
  select atividade 
    into v_atividade 
    from produtivo 
   where id = i_produtivo_id 
  ; 
  if v_atividade in ('S') then 
    select nvl((select id from ( 
                  select id, 
                         row_number() over(partition by 1 order by sep_end desc) as seqnum 
                    from lote 
                   where sep_id = i_produtivo_id 
                     and sep_end is not null) 
             where seqnum = 1),0) 
      into v_return 
      from dual; 
  elsif v_atividade in ('C') then 
    select nvl((select id from ( 
                  select id, 
                         row_number() over(partition by 1 order by conf_end desc) as seqnum 
                    from lote 
                   where conf_id = i_produtivo_id 
                     and conf_end is not null) 
             where seqnum = 1),0) 
      into v_return 
      from dual; 
  elsif v_atividade in ('A') then 
    select nvl((select destino_id from ( 
                  select destino_id, 
                         row_number() over(partition by 1 order by abast_end desc) as seqnum 
                    from movimentacao 
                   where abast_id = i_produtivo_id 
                     and abast_end is not null) 
             where seqnum = 1),0) 
      into v_return 
      from dual; 
  elsif v_atividade in ('E') then 
    select nvl((select id from ( 
                  select id, 
                         row_number() over(partition by 1 order by emp_id desc) as seqnum 
                    from movimentacao 
                   where emp_id = i_produtivo_id 
                     and emp_end is not null) 
             where seqnum = 1),0) 
      into v_return 
      from dual; 
  end if; 
  return v_return; 
end; 
/