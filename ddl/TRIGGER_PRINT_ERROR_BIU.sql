CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PRINT_ERROR_BIU" 
    before insert or update   
    on print_error  
    for each row  
begin  
    if :new.id is null then  
        :new.id := print_error_seq.nextval;  
    end if;  
    if inserting then  
        :new.created := sysdate;  
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
    end if;  
    :new.updated := sysdate;  
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
end print_error_biu;  
 

/
ALTER TRIGGER "WMS"."PRINT_ERROR_BIU" DISABLE;