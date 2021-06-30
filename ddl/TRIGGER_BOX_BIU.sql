CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."BOX_BIU" 
    before insert or update   
    on box  
    for each row  
begin  
    if :new.id is null then  
        :new.id := box_seq.nextval;  
    end if;  
    if inserting then  
        :new.created := sysdate;  
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
    end if;  
    :new.updated := sysdate;  
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
end box_biu;  
 

/
ALTER TRIGGER "WMS"."BOX_BIU" DISABLE;