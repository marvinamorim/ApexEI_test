CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."FORNECEDOR_BIU" 
    before insert or update   
    on fornecedor  
    for each row  
begin  
    if :new.id is null then  
        :new.id := fornecedor_seq.nextval;  
    end if;  
end fornecedor_biu;  
 

/
ALTER TRIGGER "WMS"."FORNECEDOR_BIU" DISABLE;