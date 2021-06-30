CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."TESTE_BIU" 
    before insert or update   
    on teste  
    for each row  
begin  
    if :new.id is null then  
        :new.id := teste_seq.nextval;  
    end if;  
end teste_biu;  
 

/
ALTER TRIGGER "WMS"."TESTE_BIU" DISABLE;