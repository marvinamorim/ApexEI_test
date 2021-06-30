CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."P_PRODUTIVO_ULTIMA_ATV" (
  i_prod in number
) return date as
  v_return date;
  v_atividade varchar2(1);
begin
  select atividade
    into v_atividade
    from wms.produtivo
   where id = i_prod;
  select max(case when v_atividade = 'S' then SEP_END else CONF_END end)
    into v_return
    from wms.LOTE B
   where i_prod = case when v_atividade = 'S' then SEP_ID else CONF_ID end;
  return v_return;
end;
/