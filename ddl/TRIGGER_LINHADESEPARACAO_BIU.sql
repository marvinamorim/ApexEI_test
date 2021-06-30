CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."LINHADESEPARACAO_BIU" 
    before insert or update   
    on linhadeseparacao  
    for each row  
begin  
    if :new.id is null then  
        :new.id := linhadeseparacao_seq.nextval;  
    end if;  
    if inserting then  
        :new.created := sysdate;  
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
    end if;  
    :new.updated := sysdate;  
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
end linhadeseparacao_biu;  
 

/
ALTER TRIGGER "WMS"."LINHADESEPARACAO_BIU" DISABLE;