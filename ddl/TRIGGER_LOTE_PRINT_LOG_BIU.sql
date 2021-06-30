CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."LOTE_PRINT_LOG_BIU" 
    before insert or update   
    on lote_print_log  
    for each row  
begin  
    if :new.id is null then  
        :new.id := lote_print_log_seq.nextval;  
    end if;  
    if inserting then  
        :new.created := sysdate;  
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
    end if;  
    :new.updated := sysdate;  
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
end lote_print_log_biu;  
 

/
ALTER TRIGGER "WMS"."LOTE_PRINT_LOG_BIU" DISABLE;