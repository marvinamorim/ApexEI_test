CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_MUDAR_DESTINO" ( 
  i_carga IN NUMBER, 
  i_new_destino IN VARCHAR2, 
  i_user IN VARCHAR2 
) as 
begin 
  update CARGA_IMPORT 
     set DESTINO = i_new_destino, 
         UPDATED_BY = i_user 
   where ID = i_carga 
  ; 
end;
/