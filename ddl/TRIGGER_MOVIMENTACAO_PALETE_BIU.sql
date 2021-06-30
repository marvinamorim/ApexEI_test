CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."MOVIMENTACAO_PALETE_BIU" 
    before insert or update   
    on movimentacao_palete  
    for each row  
begin  
    if :new.id is null then  
        :new.id := movimentacao_palete_seq.nextval;  
    end if;  
end movimentacao_palete_biu;  
 

/
ALTER TRIGGER "WMS"."MOVIMENTACAO_PALETE_BIU" DISABLE;