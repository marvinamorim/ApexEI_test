CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_GET_ZPL_REC" (palete IN NUMBER)
return varchar2 is 
  resp varchar2(4000) := ''; 
  q varchar2(1000); 
  line varchar2(1000); 
  logo varchar2(4000); 
  c1 SYS_REFCURSOR; 
begin 
  logo := ''; 
  for c in ( 
    SELECT W.PRECOMANDO, W.SUFCOMANDO, COLUNABANCO 
      FROM WMS.PARAMETRO_ZPL W 
     WHERE W.SEQPARAMETQ = '101' 
  ) loop 
    q := 'SELECT '||c.COLUNABANCO||' FROM WMS.VW_ZPL_PRINT_REC w where seqpaleterf = :1'; 
    open c1 for q USING palete; 
 
    LOOP 
      FETCH c1 INTO line; 
      EXIT WHEN c1%NOTFOUND; 
      line := c.PRECOMANDO || line || c.SUFCOMANDO; 
    END LOOP; 
    resp := resp || line; 
  end loop; 
  resp := resp ||logo ||'^XZ'; 
  return resp; 
end; 
/