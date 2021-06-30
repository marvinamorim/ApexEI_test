CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."GRUPO_ACESSO_BIU" 
    before insert or update   
    on grupo_acesso  
    for each row  
begin  
    if :new.id is null then  
        :new.id := grupo_acesso_seq.nextval;  
    end if;  
end grupo_acesso_biu;  
 

/
ALTER TRIGGER "WMS"."GRUPO_ACESSO_BIU" DISABLE;