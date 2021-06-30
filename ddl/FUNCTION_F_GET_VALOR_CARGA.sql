CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_GET_VALOR_CARGA" (i_carga number)
return number as
  v_return number;
begin
  select sum(b.qtdatendida/b.qtdembalagem*b.vlrembinformado)
    into v_return
    from consinco.mad_pedvenda a
   inner join consinco.mad_pedvendaitem b
      on b.nropedvenda = a.nropedvenda
   where a.nrocarga = i_carga
  ;
  return v_return;
end;
/