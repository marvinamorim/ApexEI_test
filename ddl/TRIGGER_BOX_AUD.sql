CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."BOX_AUD" 
    after update or delete on box  
    for each row  
declare  
    t varchar2(128) := 'BOX';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if (:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    end if;  
    if (:old.prioridade is null and :new.prioridade is not null) or   
        (:old.prioridade is not null and :new.prioridade is null) or   
        :old.prioridade != :new.prioridade then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PRIORIDADE', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.prioridade, :new.prioridade);  
  
    end if;  
elsif deleting then  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PRIORIDADE', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.prioridade, :new.prioridade);  
  
end if;  
end box_aud;  
 

/
ALTER TRIGGER "WMS"."BOX_AUD" DISABLE;