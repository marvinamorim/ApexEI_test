CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."ERRO_SEPARACAO_ALERTA_BIU" 
    before insert or update   
    on erro_separacao_alerta  
    for each row  
begin  
    if :new.id is null then  
        :new.id := erro_separacao_alerta_seq.nextval;  
    end if;  
    if inserting then  
        :new.created := sysdate;  
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
    end if;  
    :new.updated := sysdate;  
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
end erro_separacao_alerta_biu;  
 

/
ALTER TRIGGER "WMS"."ERRO_SEPARACAO_ALERTA_BIU" DISABLE;