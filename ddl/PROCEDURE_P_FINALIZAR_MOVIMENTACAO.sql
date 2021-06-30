CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_FINALIZAR_MOVIMENTACAO" (i_mov_id number, i_produtivo number) as
  v_tipo_produtivo varchar2(1);
begin
  select ATIVIDADE
    into v_tipo_produtivo
    from PRODUTIVO
   where ID = i_produtivo;
  if v_tipo_produtivo = 'A' then
    update wms.movimentacao
       set abast_end = sysdate,
           status = case when tipo in ('R','E') then 2 else 4 end
     where id = i_mov_id;
  else
    update wms.movimentacao
       set emp_end = sysdate,
           status = case when tipo in ('A','R','E') then 4 else 2 end
     where id = i_mov_id;
  end if;
end;
/