CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PALETE_VALIDADE_BIU" 
    before insert or update   
    on palete_validade  
    for each row  
begin  
    if :new.id is null then  
        :new.id := palete_validade_seq.nextval;  
    end if;  
end palete_validade_biu;  
 

/
ALTER TRIGGER "WMS"."PALETE_VALIDADE_BIU" DISABLE;