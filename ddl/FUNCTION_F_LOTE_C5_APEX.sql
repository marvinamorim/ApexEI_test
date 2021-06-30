CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_LOTE_C5_APEX" 
(i_carga in number, i_produto in number) 
return varchar2 
as 
v_lotes varchar2(1000); 
begin 
  for c1 in (select distinct seqlote from consinco.mlo_cargaesepara where nrocarga = i_carga and seqproduto = i_produto) loop 
    v_lotes := v_lotes || c1.seqlote || ', '; 
  end loop; 
  return v_lotes; 
end; 
/