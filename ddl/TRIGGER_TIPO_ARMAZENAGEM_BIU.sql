CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."TIPO_ARMAZENAGEM_BIU" 
    before insert or update   
    on tipo_armazenagem  
    for each row  
begin  
    if :new.id is null then  
        :new.id := tipo_armazenagem_seq.nextval;  
    end if;  
end tipo_armazenagem_biu;  
 

/
ALTER TRIGGER "WMS"."TIPO_ARMAZENAGEM_BIU" DISABLE;