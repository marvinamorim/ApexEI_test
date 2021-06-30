CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."REGRA_VALIDADE_BIU" 
    before insert or update   
    on regra_validade  
    for each row  
begin  
    if :new.id is null then  
        :new.id := regra_validade_seq.nextval;  
    end if;  
end regra_validade_biu;  
 

/
ALTER TRIGGER "WMS"."REGRA_VALIDADE_BIU" DISABLE;