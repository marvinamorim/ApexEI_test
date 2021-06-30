CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PALETE_BIU" 
    before insert or update   
    on palete  
    for each row  
begin  
    if :new.id is null then  
        :new.id := palete_seq.nextval;  
    end if;  
end palete_biu;  
 

/
ALTER TRIGGER "WMS"."PALETE_BIU" DISABLE;