CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."CARGA_T2" 
BEFORE 
insert on "CARGA" 
for each row 
begin 
select a.box_id into :new.BOX_ID   from CARGA_IMPORT a where a.id = :new.id; 
end; 
 

/
ALTER TRIGGER "WMS"."CARGA_T2" ENABLE;