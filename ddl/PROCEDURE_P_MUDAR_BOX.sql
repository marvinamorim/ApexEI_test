CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_MUDAR_BOX" ( 
  i_carga IN NUMBER, 
  i_new_box IN NUMBER, 
  i_user IN VARCHAR2 
) as 
begin 
  update CARGA_IMPORT 
     set BOX_ID = i_new_box, 
         UPDATED_BY = i_user 
   where ID = i_carga 
  ; 
  update CARGA 
     set BOX_ID = i_new_box, 
         UPDATED_BY = i_user 
   where ID = i_carga 
  ; 
end; 
/