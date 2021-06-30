CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."USUARIO_BIU" 
    before insert or update   
    on usuario  
    for each row  
begin  
    if :new.id is null then  
        :new.id := usuario_seq.nextval;  
    end if;  
end usuario_biu;  
 

/
ALTER TRIGGER "WMS"."USUARIO_BIU" DISABLE;