CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PRODUTIVO_RUA_BIU" 
    before insert or update   
    on produtivo_rua  
    for each row  
begin  
    if :new.id is null then  
        :new.id := produtivo_rua_seq.nextval;  
    end if;  
    if inserting then  
        :new.created := sysdate;  
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
    end if;  
    :new.updated := sysdate;  
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
end produtivo_rua_biu;  
 

/
ALTER TRIGGER "WMS"."PRODUTIVO_RUA_BIU" DISABLE;