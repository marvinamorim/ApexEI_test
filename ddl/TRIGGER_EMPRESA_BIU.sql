CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."EMPRESA_BIU" 
    before insert or update   
    on empresa  
    for each row  
begin  
    if :new.id is null then  
        :new.id := empresa_seq.nextval;  
    end if;  
end empresa_biu;  
 

/
ALTER TRIGGER "WMS"."EMPRESA_BIU" DISABLE;