CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."CORTE_BIU" 
    before insert or update   
    on corte  
    for each row  
begin  
    if :new.id is null then  
        :new.id := corte_seq.nextval;  
    end if;  
    if inserting then  
        :new.created := sysdate; 
        if :new.created_by is null then 
            :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
        end if; 
    end if;  
    :new.updated := sysdate;  
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
end corte_biu;  
 

/
ALTER TRIGGER "WMS"."CORTE_BIU" DISABLE;