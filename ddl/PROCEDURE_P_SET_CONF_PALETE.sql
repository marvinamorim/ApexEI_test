CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_SET_CONF_PALETE" (i_conf_id IN NUMBER, i_palete_id IN NUMBER) as  
begin  
  update PALETE  
     set CONF_ID = i_conf_id,  
         CONF_START = sysdate,  
         STATUS = 1  
   where ID = i_palete_id;  
end;  
----------------------------  
/