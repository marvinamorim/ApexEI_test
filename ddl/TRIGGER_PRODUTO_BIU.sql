CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PRODUTO_BIU" 
    before insert   
    on produto  
    for each row  
begin  
    if :new.id is null then  
        :new.id := produto_seq.nextval;  
    end if;  
end produto_biu;  
 

/
ALTER TRIGGER "WMS"."PRODUTO_BIU" DISABLE;