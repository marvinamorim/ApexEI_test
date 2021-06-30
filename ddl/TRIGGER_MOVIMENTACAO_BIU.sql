CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."MOVIMENTACAO_BIU" 
    before insert or update   
    on movimentacao  
    for each row  
begin  
    if :new.id is null then  
        :new.id := movimentacao_seq.nextval;  
    end if;  
    if :new.prioridade is null then  
        :new.prioridade := 9;  
    end if;  
end movimentacao_biu;  
 

/
ALTER TRIGGER "WMS"."MOVIMENTACAO_BIU" DISABLE;