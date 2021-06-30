CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_GET_PRODUTIVO" (i_produtivo_id in number)
return varchar2 as
  v_return varchar2(100);
begin
  select nome
    into v_return
    from wms.produtivo a
   where a.id = i_produtivo_id;
  return v_return;
end;
/