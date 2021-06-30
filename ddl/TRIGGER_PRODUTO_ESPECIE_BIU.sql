CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PRODUTO_ESPECIE_BIU" 
    before insert or update   
    on produto_especie  
    for each row  
begin  
    if :new.id is null then  
        :new.id := produto_especie_seq.nextval;  
    end if;  
end produto_especie_biu;  
 

/
ALTER TRIGGER "WMS"."PRODUTO_ESPECIE_BIU" DISABLE;