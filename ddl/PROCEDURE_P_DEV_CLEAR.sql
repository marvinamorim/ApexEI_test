CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_DEV_CLEAR" (i_carga IN NUMBER) as 
begin 
  delete from ATIVIDADE 
   where (CARGA_ID = i_carga or i_carga =0); 
 
  delete from LOTE 
   where (CARGA_ID = i_carga or i_carga =0); 
 
  delete from CARGA 
   where (ID = i_carga or i_carga =0); 
 
  delete from CARGA_IMPORT 
   where (ID = i_carga or i_carga =0); 
  commit; 
end; 
/