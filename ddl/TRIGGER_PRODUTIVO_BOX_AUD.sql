CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PRODUTIVO_BOX_AUD" 
    after update or delete on produtivo_box  
    for each row  
declare  
    t varchar2(128) := 'PRODUTIVO_BOX';  
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
    if (:old.produtivo_id is null and :new.produtivo_id is not null) or   
        (:old.produtivo_id is not null and :new.produtivo_id is null) or   
        :old.produtivo_id != :new.produtivo_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PRODUTIVO_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.produtivo_id, :new.produtivo_id);  
  
    end if;  
    if (:old.box is null and :new.box is not null) or   
        (:old.box is not null and :new.box is null) or   
        :old.box != :new.box then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'BOX', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.box, :new.box);  
  
    end if;  
elsif deleting then  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PRODUTIVO_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.produtivo_id, :new.produtivo_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'BOX', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.box, :new.box);  
  
end if;  
end produtivo_box_aud;  
 

/
ALTER TRIGGER "WMS"."PRODUTIVO_BOX_AUD" DISABLE;