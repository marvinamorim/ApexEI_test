CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."ATIVIDADE_BIU" 
    before insert or update   
    on atividade  
    for each row  
begin  
    if :new.id is null then  
        :new.id := atividade_seq.nextval;  
    end if;  
    if inserting then  
        :new.created := sysdate;  
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
    end if;  
    :new.updated := sysdate;  
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
end atividade_biu;  
 

/
ALTER TRIGGER "WMS"."ATIVIDADE_BIU" DISABLE;