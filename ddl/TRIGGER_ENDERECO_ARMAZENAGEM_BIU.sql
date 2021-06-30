CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."ENDERECO_ARMAZENAGEM_BIU" 
    before insert or update   
    on endereco_armazenagem  
    for each row  
begin  
    if :new.id is null then  
        :new.id := endereco_armazenagem_seq.nextval;  
    end if;  
end endereco_armazenagem_biu;  
 

/
ALTER TRIGGER "WMS"."ENDERECO_ARMAZENAGEM_BIU" DISABLE;