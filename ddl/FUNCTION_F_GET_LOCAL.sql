CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_GET_LOCAL" (i_endereco_id in number)
return varchar2 as
  v_return varchar2(100);
begin
  select a.RUA ||'.'|| a.PREDIO||'.'||a.APARTAMENTO||'.'||a.SALA
    into v_return
    from wms.endereco a
   where a.id = i_endereco_id;
  return v_return;
end;
/