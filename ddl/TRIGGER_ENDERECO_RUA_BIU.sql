CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."ENDERECO_RUA_BIU" 
    before insert or update   
    on endereco_rua  
    for each row  
begin  
    if :new.id is null then  
        :new.id := endereco_rua_seq.nextval;  
    end if;  
end endereco_rua_biu;  
 

/
ALTER TRIGGER "WMS"."ENDERECO_RUA_BIU" DISABLE;