CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."GRUPO_PERMISSAO_BIU" 
    before insert or update   
    on grupo_permissao  
    for each row  
begin  
    if :new.id is null then  
        :new.id := grupo_permissao_seq.nextval;  
    end if;  
end grupo_permissao_biu;  
 

/
ALTER TRIGGER "WMS"."GRUPO_PERMISSAO_BIU" DISABLE;