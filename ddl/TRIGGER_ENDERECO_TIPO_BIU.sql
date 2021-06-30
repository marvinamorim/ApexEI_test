CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."ENDERECO_TIPO_BIU" 
    before insert or update   
    on endereco_tipo  
    for each row  
begin  
    if :new.id is null then  
        :new.id := endereco_tipo_seq.nextval;  
    end if;  
end endereco_tipo_biu;  
 

/
ALTER TRIGGER "WMS"."ENDERECO_TIPO_BIU" DISABLE;