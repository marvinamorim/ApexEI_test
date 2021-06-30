CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."ENDERECO_ESPECIE_BIU" 
    before insert or update   
    on endereco_especie  
    for each row  
begin  
    if :new.id is null then  
        :new.id := endereco_especie_seq.nextval;  
    end if;  
end endereco_especie_biu;  
 

/
ALTER TRIGGER "WMS"."ENDERECO_ESPECIE_BIU" DISABLE;