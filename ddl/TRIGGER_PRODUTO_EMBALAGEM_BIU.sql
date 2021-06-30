CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PRODUTO_EMBALAGEM_BIU" 
    before insert   
    on produto_embalagem  
    for each row  
begin  
    if :new.id is null then  
        :new.id := produto_embalagem_seq.nextval;  
    end if;  
end produto_embalagem_biu;  
 

/
ALTER TRIGGER "WMS"."PRODUTO_EMBALAGEM_BIU" DISABLE;