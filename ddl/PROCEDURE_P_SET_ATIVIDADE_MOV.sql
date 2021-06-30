CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_SET_ATIVIDADE_MOV" (
  i_produtivo in number,
  i_tipo in varchar2,
  i_status in number,
  i_palete in number
) as
begin
  if i_tipo = 'A' then
    update movimentacao
       set abast_id = i_produtivo,
           abast_start = sysdate,
           status = i_status
     where palete_id = i_palete
    ;
  else
    update movimentacao
       set emp_id = i_produtivo,
           emp_start = sysdate,
           status = i_status
     where palete_id = i_palete
    ;
  end if;
end;
/