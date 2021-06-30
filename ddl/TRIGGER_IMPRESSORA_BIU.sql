CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."IMPRESSORA_BIU" 
    before insert or update   
    on impressora  
    for each row  
begin  
    if :new.id is null then  
        :new.id := impressora_seq.nextval;  
    end if;  
    if inserting then  
        :new.created := sysdate;  
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
    end if;  
    :new.updated := sysdate;  
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
end impressora_biu;  
 

/
ALTER TRIGGER "WMS"."IMPRESSORA_BIU" DISABLE;