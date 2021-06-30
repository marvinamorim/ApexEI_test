CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PRINT_ERROR_AUD" 
    after update or delete on print_error  
    for each row  
declare  
    t varchar2(128) := 'PRINT_ERROR';  
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
    if (:old.carga_id is null and :new.carga_id is not null) or   
        (:old.carga_id is not null and :new.carga_id is null) or   
        :old.carga_id != :new.carga_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'CARGA_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.carga_id, :new.carga_id);  
  
    end if;  
    if (:old.lote is null and :new.lote is not null) or   
        (:old.lote is not null and :new.lote is null) or   
        :old.lote != :new.lote then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'LOTE', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.lote, :new.lote);  
  
    end if;  
    if (:old.info is null and :new.info is not null) or   
        (:old.info is not null and :new.info is null) or   
        :old.info != :new.info then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'INFO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.info, :new.info);  
  
    end if;  
    if (:old.alert_status is null and :new.alert_status is not null) or   
        (:old.alert_status is not null and :new.alert_status is null) or   
        :old.alert_status != :new.alert_status then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'ALERT_STATUS', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.alert_status, :new.alert_status);  
  
    end if;  
elsif deleting then  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'CARGA_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.carga_id, :new.carga_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'LOTE', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.lote, :new.lote);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'INFO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.info, :new.info);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ALERT_STATUS', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.alert_status, :new.alert_status);  
  
end if;  
end print_error_aud;  
 

/
ALTER TRIGGER "WMS"."PRINT_ERROR_AUD" DISABLE;