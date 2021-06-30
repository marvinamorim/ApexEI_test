CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."MOVIMENTACAO_VISUAL_BIU" 
    before insert or update 
    on movimentacao_visual 
    for each row 
begin 
    if :new.id is null then 
        :new.id := movimentacao_visual_seq.nextval; 
    end if; 
    if inserting then 
        :new.created := sysdate; 
    end if; 
    :new.updated := sysdate; 
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user); 
end movimentacao_visual_biu; 

/
ALTER TRIGGER "WMS"."MOVIMENTACAO_VISUAL_BIU" DISABLE;