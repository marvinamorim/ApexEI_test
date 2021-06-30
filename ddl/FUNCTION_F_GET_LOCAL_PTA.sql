CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_GET_LOCAL_PTA" (
  i_produto IN NUMBER
) return varchar2 is
v_local varchar2(100);
begin
  select RUA || '.' || PREDIO || '.' ||
         APARTAMENTO || '.' || SALA  
    into v_local
    from wms.ENDERECO A
   where A.ID = (
     select max(B.ID)
       from wms.ENDERECO B
      where B.RUA = '996'
        and B.QTD_ATUAL > 0
        and B.PRODUTO_ID = i_produto
   );
  
  return v_local;
  
  EXCEPTION
    when NO_DATA_FOUND
      then return '996';
    when OTHERS
      then return SQLERRM;
end;
/