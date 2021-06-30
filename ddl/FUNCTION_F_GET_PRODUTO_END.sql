CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_GET_PRODUTO_END" (i_endereco_id in number)
return varchar2 as
  v_return varchar2(100);
begin
  select b.emb || '-' || b.qtd_emb || ' / ' || c.nome
    into v_return
    from wms.endereco a
   inner join produto_embalagem b
      on a.embalagem_id = b.id
   inner join produto c
      on c.id = b.produto_id
   where a.id = i_endereco_id;
  return v_return;
end;
/