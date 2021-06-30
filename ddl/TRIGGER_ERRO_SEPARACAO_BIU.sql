CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."ERRO_SEPARACAO_BIU" 
    before insert or update   
    on erro_separacao  
    for each row  
begin  
    if :new.id is null then  
        :new.id := erro_separacao_seq.nextval;  
    end if;  
    if inserting then  
        :new.created := sysdate;  
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
    end if;  
    :new.updated := sysdate;  
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
end erro_separacao_biu;  
 

/
ALTER TRIGGER "WMS"."ERRO_SEPARACAO_BIU" DISABLE;