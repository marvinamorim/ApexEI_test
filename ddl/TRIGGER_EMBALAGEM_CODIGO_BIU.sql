CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."EMBALAGEM_CODIGO_BIU" 
    before insert or update   
    on embalagem_codigo  
    for each row  
begin  
    if :new.id is null then  
        :new.id := embalagem_codigo_seq.nextval;  
    end if;  
end embalagem_codigo_biu;  
 

/
ALTER TRIGGER "WMS"."EMBALAGEM_CODIGO_BIU" DISABLE;