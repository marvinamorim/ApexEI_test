CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."CARGA_BIU" 
    before insert or update   
    on carga  
    for each row  
begin  
    if :new.id is null then  
        :new.id := carga_seq.nextval;  
    end if;  
    if inserting then  
        :new.created := sysdate;  
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
    end if;  
    :new.updated := sysdate;  
    :new.updated_by :=  
      case 
        when :new.updated_by is null then 
          nvl(sys_context('APEX$SESSION','APP_USER'),user) 
        else 
          :new.updated_by 
      end; 
end carga_biu;  
 

/
ALTER TRIGGER "WMS"."CARGA_BIU" DISABLE;