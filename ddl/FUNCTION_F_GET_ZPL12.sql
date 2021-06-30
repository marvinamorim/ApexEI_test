CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_GET_ZPL12" (carga IN NUMBER, lote IN NUMBER) 
return varchar2 is 
  resp varchar2(6000) := ''; 
  q varchar2(1000); 
  line varchar2(4000); 
  dthora varchar2(500); 
  c1 SYS_REFCURSOR; 
begin 
dthora := '^FS^FO580,329^AD^FC%,{,#^FD%d/%m/%y #H:#M:#S'; 
  for c in ( 
    SELECT W.PRECOMANDO, W.SUFCOMANDO, COLUNABANCO 
      FROM APEX.TB_CDA_ETQCONF01 W 
     WHERE W.PADRAOETQ = 'GEN. SEPCARGA' 
  ) loop 
    q := 'SELECT '||c.COLUNABANCO||' FROM WMS.VW_ZPL_PRINT w where w.NROCARGA = :1 and w.SEQLOTE = :2'; 
    open c1 for q USING carga, lote; 
 
    LOOP 
      FETCH c1 INTO line; 
      EXIT WHEN c1%NOTFOUND; 
      line := c.PRECOMANDO || line || c.SUFCOMANDO; 
    END LOOP; 
    resp := resp || line; 
  end loop; 
  resp := resp ||dthora ||'^XZ'; 
  return resp; 
end; 
/