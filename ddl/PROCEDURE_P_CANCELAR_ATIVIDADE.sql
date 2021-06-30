CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_CANCELAR_ATIVIDADE" (i_user IN NUMBER) as 
begin 
  for c1 in ( 
    select * from PRODUTIVO 
     where ID = i_user 
  ) loop 
    if c1.ATIVIDADE = 'S' then 
      update ATIVIDADE 
         set STATUS = 0, SEP_START = null, SEP_ID = null 
       where SEP_ID = c1.ID 
         and STATUS = 1; 
      update LOTE 
         set STATUS = 0, SEP_START = null, SEP_ID = null 
       where SEP_ID = c1.ID 
         and STATUS = 1; 
    elsif c1.ATIVIDADE = 'C' then 
      update ATIVIDADE A 
         set STATUS = 2, CONF_START = null, CONF_ID = null 
       where CONF_ID = c1.ID 
         and STATUS = 3 
         and exists ( 
           select 1 
             from LOTE B 
            where A.CARGA_ID = B.CARGA_ID 
              and A.LOTE = B.LOTE 
              and B.STATUS = 3 
         ); 
      update LOTE 
         set STATUS = 2, CONF_START = null, CONF_ID = null 
       where CONF_ID = c1.ID 
         and STATUS = 3; 
    end if; 
  end loop; 
end; 
/