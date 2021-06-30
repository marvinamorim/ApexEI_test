CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."ENDERECO_VALIDADE_BIU" 
    before insert or update   
    on endereco_validade  
    for each row  
begin  
    if :new.id is null then  
        :new.id := endereco_validade_seq.nextval;  
    end if;  
end endereco_validade_biu;  
 

/
ALTER TRIGGER "WMS"."ENDERECO_VALIDADE_BIU" DISABLE;