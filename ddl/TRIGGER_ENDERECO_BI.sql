CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."ENDERECO_BI" 
    before insert   
    on endereco  
    for each row  
begin  
    if :new.id is null then  
        :new.id := endereco_seq.nextval;  
    end if;  
end endereco_bi;  
 

/
ALTER TRIGGER "WMS"."ENDERECO_BI" ENABLE;